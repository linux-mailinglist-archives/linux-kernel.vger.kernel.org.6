Return-Path: <linux-kernel+bounces-252603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A59315DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63031F22232
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883118D4D3;
	Mon, 15 Jul 2024 13:35:15 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065C18D4CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050515; cv=none; b=eYySza0Kf4BS9bwOAEQ8KTLCy6ckMNKTtwOWPUXXWACmgRUtt43hXWwUf56dCWtlz1q9rg6Gm3gmt35oR60jwVRFSMI88yiJIIcmNraSsZs3UzvwGVs4DL2aLYyMhJphcKEYCUQeg9lH+j6W6D18/VI18+OjSPPILyYZdccHO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050515; c=relaxed/simple;
	bh=SmyG6Eoc//AkzX1uumr7PmduUREuFi7OxTGIbkmXVBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lNpTEbnUbGwwtMGeM4Sv8rhgo8GruLOFok8s4HNVPq4GsCaDKWZ1V24gBDcWkHp4FghzuNZk1A0R0RIqWWwy3s57Q6F+gplAGydYoaoB4xOT0gKwR9/NUQ3EyKDR0dxnvM+Z8/Z8DcCF1hDcO5/u8lsoJ3wQJAHp2yaOJ8OqCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81258697716so138087239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721050513; x=1721655313;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmyG6Eoc//AkzX1uumr7PmduUREuFi7OxTGIbkmXVBY=;
        b=RkBqzeaISZldip+O8IXJmW23RcJsRQPRSk3+/77htSFL+TOX0aUl90WsIc72/uu/LR
         +3EHjzrOTEMbgdCsshuMfpUhIvwceoTAsNyEWV1pEugwZFgjJEzfOb1cXCekrSTP5lYD
         x1XX1ADqlnmmlwMPc7Em0D677SME7zw1U5DfABT4+JTqLrSLbuZSrw3GkA4V9eHExIPW
         0u/rvYY+cLJJhmupXA9uM3Gp6DUTToCxkC7z0I2EZEWoYIUrxWo89ltnY0NRJoENl686
         0Ko9jum3Yple+dfMvG5oIJeSA06Zt8J8x1muOpRTs9cV4hX0xFG9khfgwJGHXf0iTluo
         DPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXuaAuZ+fZ90x+wbVaqDcTYOvt1Ob0I3M3YyPyCs6aVMWaHZc4I/VzAIIfeZZ1o2Idv2T/+knlgYd+tSds5WN1tAZE6sE9n2BNT6ZX
X-Gm-Message-State: AOJu0YwEyGD3DCSyjbMZ4d7DqTMkbi8UyS4lYr3oN0g5jr4qVJyJ2RSs
	6B8LhP3YCTSQe+FAa8IksyEQeZHn8cv4/eBN37T21UbmUZmqw7Sxn4MDpLcnDStw2JYVxxdOVzP
	yPUi2sjlLQjZMT9zAgtBl/AdCw/G0Ba/DMayCezyAze2YkfOqJZSezBY=
X-Google-Smtp-Source: AGHT+IFmEwFa8QVudIOKZB44YDeGzyQqXKQu1ZCtMx0xufwxuTjSSMz3U+JqyKtujTaD3RE1VNySe/i4DVhEpP7MyYmJ+sd8WhOg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c7:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c0b2b7ed9fmr2683778173.5.1721050513228; Mon, 15 Jul 2024
 06:35:13 -0700 (PDT)
Date: Mon, 15 Jul 2024 06:35:13 -0700
In-Reply-To: <0000000000007de0cf06140124c0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b55ab061d494ced@google.com>
Subject: Re: [syzbot] WARNING in unmap_page_range (3)
From: syzbot <syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
mm/memory: Fix missing pte marker for !page on pte zaps

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=e145145f0c83d4deb8fa

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

