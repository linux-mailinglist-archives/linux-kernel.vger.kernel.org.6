Return-Path: <linux-kernel+bounces-262816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F593CD14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311B3282F50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AED2B9BE;
	Fri, 26 Jul 2024 03:49:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD692374E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965758; cv=none; b=qL9fJXP6WG/m29aDTeFrUPgdu4riOx5U5U5XRiCFbZRQkLS2bN73vXFkVmbCnVd+MwPKTRQPacVP7RinnJSZepg0ICR1T6CZITLSLg2UE+MDpzz+9Oyby7PaHsi2p9tnluSDigkiaG3BAjFtOFJi/yeHzgO7xbIYfdoDczwWNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965758; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+73JmbMjEjXtuPLOuOZqBnAJ/8TryFEeiPWyVB8yNRiKwYOimdZatPNZSBomvuW5E2x0cLDQx4Yzw7rLh7IPlk5dhwfRYiEcUs5qDiQ+RqtFxMmbxUFyGB8g/hxbD31IxwWjcIGtSl6YIqbsm+AwwW36VFSv7hHPL90vUCY19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-397052a7bcbso16918975ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721965756; x=1722570556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=KnKG9qdttrnzQAG5R/kJuMrX5XvQfNH1pEdUHdVrkWBUGbFCxC+/n4qJVZxrG4I1A3
         NGNGdcvPBswQOnqrVrJEduJ4FSJi4jgJq2uncFOt5ZPrZL7xwvhwyCqLljX+lUi+VTIn
         1hRRT+i6FeZLXi+mHioLvkGNrdyKxr8c5xHwihqUlhfPgLrBHx3xyVvv7nh5uHFLizLU
         kQhLwNUBiNth4HnAGQG92aruPBI7pxF7/GkvaqJBB645M5cWWP7NTyI6HH0bDvWC3xzj
         3zxwZGwnRHCz61OOH/vTaMvyDzdqrnKK9/5X0bBTbVYRR4PiuRu99LTk10UuPpGc+nY/
         galw==
X-Forwarded-Encrypted: i=1; AJvYcCUP6ybBIZUpoUnPIRYLBs8IFvJslEk6cJnd8oEwu9FizJ7PH2939ww/Dg1rqPkSi8Xx59DzumIxsWndpBR1cSsRZ0r/bmvbNLHooLa2
X-Gm-Message-State: AOJu0YyTYkzJCSmLsH+FllFt0JOPmDeBvDJTQpCntmEsszEZweiZ1ykw
	HVbzYmj4mgvSzL4lKTv7eNvdum4itNwZALi7AA/nquktk2ILO9Xom4HCsUi4D46jkvDO0tJRefF
	ZJ534Xzf+ErCa+QEKnR3is39a7Fd9W0lOmw6qSLmm/+QA8A91yjpdYYU=
X-Google-Smtp-Source: AGHT+IGVxDfTZyj3MA9baZrtud7k5xDLfonIewOkOSq9/ct8qPqAYhIrYw1oXuG3klibzz/6OMWw9vi8eO+gii7aToGwnCPs9lAx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a86:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-39a2185cc84mr2796975ab.5.1721965756603; Thu, 25 Jul 2024
 20:49:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:49:16 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cee2a061e1e65b0@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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

