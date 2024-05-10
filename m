Return-Path: <linux-kernel+bounces-175164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9F8C1BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA151F20FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D643AD9;
	Fri, 10 May 2024 00:13:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF9746E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299997; cv=none; b=kwWLM+Xn1teMkdycfixVRZ21WdwI93/d/g8el6+Jnv2TW4JAhBLm1hiu6pFqxIphS6PP7LqehYhK+dWymhxuPtr4EWNj6gLxR8tsUkGQDs7UehK+bXP1rYsiZIXp/KZHKX+ompi5RAW5BY59g44vkvTSYqCs9xlQtnMWA0wVylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299997; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pufkb8j4NOK7s5+zW8CwDgD56tWc86eXkVm5c7pfYX/gvnB4x23k3zX2wvM+1ObGDQe1iUbLOl0MtqTV9C9JVVmVDwk40aEkumn/4M9aXYRgP4l7lI6oRvDHVVzXx1OenCB4UVo0yhdy8dVgYLlMmkGX46gNX6eKU0I1Y6MyyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1b97c1b19so12686839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299995; x=1715904795;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=J1eBZiH04i1a4s+Saz0nRXUmBW+H1eIiAiMqJZo0wpFDnlJzgy0fetnVs/vvrKBOYB
         PkIfigmMd+CCL38Q5QYpDKFsPK2+4KBBv+WSffwylrU1J02OR43MX9bZ41SDAOJXCfTc
         9fr1nxvJTmOvaBX26F5fPEbjxpR+AKC2OfQi5lQ3W5JI+w2PFbPTG3PNCxY2hcw3CeKo
         L1O1J4dIpMbSdSKoCHZX2V9YrIadKsqaaJ2PtuvJXwRpGFaZp/EVdJSaP42q4ugVHuEN
         mM5CJdHOccyMWlTR5cYL6Gm5MhN5xbH1v+JRcggdU2lA2F9jC0IoUKhEg6dc+Lq3gjUh
         qhLw==
X-Forwarded-Encrypted: i=1; AJvYcCU2vDTOMH5x5XxYwxVwDs+b2sOzkTEUG52WEL3fnuaykPndt1wEDfNoy/ui1jD1Y1ju7Xq9E7seaayNky2RI4S7hTmX+A4xMHFAvGEc
X-Gm-Message-State: AOJu0YyuakyazNdyPwBwm89fmVTu6nkpcYFFxv1cqmmziyb9Eth/mStT
	o2fkEGCZNT4YUinHEO2njPyocYvS0XJVc/bKSnAha1Y25/cNpi/jKLrsxeeIu0Pc6l7JyAzyNDQ
	9ttBAIs1kfhXvvTwvJsXHP+l1Sb70lFT9gvIS6JiB87NeDO2YcrC451M=
X-Google-Smtp-Source: AGHT+IG8lV0gayEeQv4OnAIVKR5a30CHHZDSkXwY5iPgzJNo/IM83a2phKBkZt0ExDotYyJ/Z5YKhymuoW7uYJ1qBEE9drN4R2p+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150b:b0:488:dd9c:2483 with SMTP id
 8926c6da1cb9f-4895912b334mr69327173.5.1715299995594; Thu, 09 May 2024
 17:13:15 -0700 (PDT)
Date: Thu, 09 May 2024 17:13:15 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebbc6706180e6692@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

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

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

