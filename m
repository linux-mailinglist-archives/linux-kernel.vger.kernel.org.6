Return-Path: <linux-kernel+bounces-236347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093291E0C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C21B281371
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5115A863;
	Mon,  1 Jul 2024 13:34:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A91CA9C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840859; cv=none; b=mDYu56a2gXReVdIlVMhY+hkB8OKtFd0QuRJb7cfbVZZ/EFS9ujMqOQv4RvKXC9jjBTiqdAESaNdAbkSJ9+H66mWnBMEOajkgJqIqsCh4xQvthsL1312Jl9WoAzozCfqBaOTQXPNgJY/XL8cv9sMe7kMSlXF84FXTuc8GFU6vH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840859; c=relaxed/simple;
	bh=SmyG6Eoc//AkzX1uumr7PmduUREuFi7OxTGIbkmXVBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GJJEBzbFcDaWGy7Z7f1ZG2hcs8Krf1rVMxCcnLwF9JpDibctbJjF4cvtKdJbLwfvogOGV2Wex5vTHGOsHb/kk2Tc7T3XPc1GEd9v1bwdrTa8eGZrmuBgZoK8qSmDx+u5oFPEjS2M+uS3VRbDW5oEz+vOetGLWnuOk05lN9BnMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f634e2d110so173958739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719840857; x=1720445657;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmyG6Eoc//AkzX1uumr7PmduUREuFi7OxTGIbkmXVBY=;
        b=ihnf95CJN3D8WarEz2UfFcUyFmbEWz1GVpqwYY29KYoBMB1j0v4tDcCi4GgqE8pOlG
         ijoVYNLrHXoflEoXEN0vwMwyaNs5bcUWhImxI3aWNwQ9S4nPR4yxbWyIcMQYZmQ7DrB0
         OcZRypAugEXRX+dsBztHFISrgkKW1JzwXKaoApqMuGyQXuG7h3f3Xe6hM9PvxqeTd6Io
         ny2ntWaej66Wqonibm8Qk0yiig48pFiZ1casemPR9JXFTUpdYB8Sjkcp5gh7qeZptVpt
         bjaFm+3lzzVn7/iCh/Nwy2nZED1alt9VDY+gvDAHh5XnSK7ryRjxTjwvJ4g2LGJEMHSG
         R+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVuGdUJNSo0b9y/PsVRP4sqQyXXpEfUehf3gFAXg3WFmQBB1BKUuSucvLMBNAXwKgjxFmbVyLxTDFifZLenxCMAl7XFk5+Fb2Jox83p
X-Gm-Message-State: AOJu0YwtadH3jrAtiTYfwGg9jUFS47zyxOkJX/3Wj/8//+Ir7zlM8z8S
	ohRbGmTFSanz9RsSNlM/GxmYzUZ+xMnxRDsO/gWT0BgKonOnSCmyWNctBjvCheiyJSncOdPzJ/l
	jLIqSdNt21qzQkjC8paZkBTvAaE4ZatvuXRSY5GtG1xhsP9c1GpNF82w=
X-Google-Smtp-Source: AGHT+IGCZcR6Lq1ZlvN2pSvXyIEvi/xJkv35rhv67bPiavK983GgaNPsUWobrnM4tUj7pP3118Zt6saeMioss1AShHGrLGSX3hiz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd4:b0:7f6:1e9c:d6f4 with SMTP id
 ca18e2360f4ac-7f62ee9d6f1mr48022939f.3.1719840857393; Mon, 01 Jul 2024
 06:34:17 -0700 (PDT)
Date: Mon, 01 Jul 2024 06:34:17 -0700
In-Reply-To: <0000000000007de0cf06140124c0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000601bc9061c2fa734@google.com>
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

