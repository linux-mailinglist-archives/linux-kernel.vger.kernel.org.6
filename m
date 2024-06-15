Return-Path: <linux-kernel+bounces-215729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895E909660
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E0E2841A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9415E86;
	Sat, 15 Jun 2024 06:46:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB079F5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718433965; cv=none; b=paqapCYh23Jn2OtKeR5r6wI5ZQdSnZ70B/jAo1DPLLZj2tdc3xLtIrZf8sFpDMdrQHSprftsdGz7SnOAymh2P7nGpxMmKGpq2mLi+TyL5O6NUhRkwalO0xv7Zs9cF1qqLNfXR+3t0wHG4ZEjbrjrrsEmnIPJy7P/vo+q7udKi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718433965; c=relaxed/simple;
	bh=Z6ZxOHuo51bhXrhKxGAAl4Be2obTI1ktIUvd9NLggSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UTSaxOTZyxHlU40S0iapObRFBF171PUPBVlxeZG2lhzCjUye4KEZYw3BTHAinERve593xqR06Oihf8AOZJddyu0fdd9+rVhG9R0aPnUvQFfihfXJxngeprkdZ/Giv9nLc0FqAzZ+IyHP+7SD/ZYTAxNxkXuAHheRQCaCMWP56ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so308437639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718433963; x=1719038763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAaNcTGjd9HzAfVs1f4ohKKCtORu2ff2az+FkQxkLNM=;
        b=V1cB15DhZbj0yUcEdDsnw0ZXKHhOID7BoWj//ODyy0cq3FmV6/mG8665lNtmnHAObP
         /K5sJRns3Ab7t0DN210V8dFluSSD9bi0WMJEkDlRty0bS5m5X0zSNRMPL4aAeFDNOuSO
         FrgTMgBHrXtUQ3XRVFTpIIdo26Mut0kSpLvQyD9M3/GkGpxarLxsTPvw6xVFqg1nN9b2
         tcAth2WJ1prry2zguiC9on6IRj7zIMrpLzbSsmU7v+vVqlJ0z+cffqUL04MrobYOfpJ2
         /CTcKbnYyjGPWZK+trP4O2LKOdG6uNOwi59WY0qkC/b6FkTvO8vAdt9NmpP09YWJvHxp
         Eq7A==
X-Gm-Message-State: AOJu0YxKzBN0xg8HmzpoBuegnoKqN5nUF2uhxtutda7+AbJYOnXjyHU3
	4b/QwQl2vgdY/3sFyutdn6R/he/NTv+SbEn0CxBEQpnWtUQtHkk05l6KGBRMMA/rnYW+IYy3gpW
	piU73Ks2+nNOPTQoVH0Nv690GC5LnbJasBQab4DQnVc/tP6RsG4+t7dY=
X-Google-Smtp-Source: AGHT+IGQ3IeEp6USZQ/h03SopDhzWvYm6CKH46JkD3u43ZV6MQdR3foY+C/8oQYIuaMZwwA+5f7H9XqbiFCgbA1pQuNHYj11D0Gf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8611:b0:4b7:bdb3:502d with SMTP id
 8926c6da1cb9f-4b963bb9bccmr155048173.0.1718433962846; Fri, 14 Jun 2024
 23:46:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 23:46:02 -0700
In-Reply-To: <20240614115730.26293-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecfae1061ae815b4@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_percpu_map_lookup_elem
From: syzbot <syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com

Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=14e98e56980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ad6a8768920dd4b
dashboard link: https://syzkaller.appspot.com/bug?extid=0a079d6ef3831217a230
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f473fe980000

Note: testing is done by a robot and is best-effort only.

