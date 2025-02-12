Return-Path: <linux-kernel+bounces-510627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC172A31FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B931188AF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5620124E;
	Wed, 12 Feb 2025 07:14:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D71E7C32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344448; cv=none; b=ISBcP3+A8L9dlZntvBWHs14oDYzIdV5J2HsE3rgVXAe5/3H8WhC6in9ffRs5Xvr54LDonBUsVVvBTlIN4M+Wxk1HzSEDYVGAn6+CuDCSPvuMNzi6f5K3xxzsfAysnEi9fSr8CSyQ0Zu9w/6HotVI92OnREb0lKRoFEiDxYF4oYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344448; c=relaxed/simple;
	bh=zaNqzBSMcIQZXY9ZvIt7+qqbfra6dLMOwrxJN4ZabIs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NilQxPPQTF71zIwHILGujc++a58bdWYd1KofvTMre2gUqcbrCDmNtIYAwUQs7y5Ny0GVWHf42tcKILUuu90GXxe7cmMuqzEOlbTZvHsM/1qdxTDhLA7elepFsPYA+ogKYFkR9kE5jtJBgHojoE8yi2AbjFBAAUQnrO9UZrc47hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d13f29ca32so90235255ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739344446; x=1739949246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Og5bvwhvhKoFdyVw94dIkty6Mefj0ZwIRl9Su87Fn7I=;
        b=rtYcRYSk4oJk//R2IolTCf7H4w70N6W4b6YrfLe9a1pKjpD7JcAzXJMVZHpBttFwyD
         3O6MtlpyOU/UuvQNXW6fPMdaCBLJ2Tg9WA+NaDGaQscvuPkTcwijarncT3oMMtEJmZfB
         0zthx8UGlJJfK4etxPxM9Q+W5uPHU/PN0bpKiaAZZHn2XLGMKwJctZV5enlgsrcT+0/2
         cLYAtyv9db/f6o0fQA7sojbYEEy9FLvBIT/kFv0TJ/KqSHhnK6mF99ogn1jI5y8JyjXP
         lrm3fa82jQoXroySCPnGeQtPwYs7WRQ5gKmUQ0xuiJc/zpjxmujo2doV/8zHngY+5er/
         dzcw==
X-Forwarded-Encrypted: i=1; AJvYcCXUUNB4KbzX6CDBQRvqtxlJmCMqjA/DCDpUSjzV6htXDcLcLFMsOmVB9tTnZ5iSq9BUHuzbURTc3RfGaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LxHT6bC99rBcnmaGQzSd6oRuQ1cvN+W5AC38e6Ifk34FSJ1z
	kjX6lDrFt9wLAS4wnDGV42ul2Sulzxv+akXHvoBpKp8Nxpw5d3hXkXDGj6K/mzGlhL9XFk/WdKh
	5bMhvr1xbWEmM+khEE3yJefF0gISIv/NRYMFpl2yFwWdHaZi0PvpGpz0=
X-Google-Smtp-Source: AGHT+IGw2qMHAT//UJUsT0kOfbyPwJWmtREXaqlGBdTJfT+ooeDqUeC/0MzYt82v6bAiYLO0/YSZXWfhVB7wsO56WdpHKaqSQziT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d14:b0:3d0:4b06:def3 with SMTP id
 e9e14a558f8ab-3d17d092da5mr13330275ab.10.1739344445914; Tue, 11 Feb 2025
 23:14:05 -0800 (PST)
Date: Tue, 11 Feb 2025 23:14:05 -0800
In-Reply-To: <0cc53c2e-a7cc-74ea-a5f0-928af997ecf7@salutedevices.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ac4a3d.050a0220.3d72c.0117.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (2)
From: syzbot <syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Tested-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com

Tested on:

commit:         c674aa7c Add linux-next specific files for 20250212
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c10ea4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fd539126ae5541
dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a51097980000

Note: testing is done by a robot and is best-effort only.

