Return-Path: <linux-kernel+bounces-378887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FD9AD6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0971C22DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F41D9A5D;
	Wed, 23 Oct 2024 21:31:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46192146A79
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719065; cv=none; b=GjwjrDx9eMLX/M9XOvBKOqNuGT+eJdtkJ/tQbvMYlCEZXHqWwFDnk9Zk432ujTvYEzXT4UvB/vgMKOIbQ3e0mm2ElhxhDwjgHE5uXLLcuMIpKq99QetRwqfLaH0C/XYF0jgNzmV2iFO7m07yGQElJdkIHUL/aJyKGAjODcH4Edk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719065; c=relaxed/simple;
	bh=3cSJUOqfOoAnUobbHM1u2Kzp2kA/6fPmzrir0UjiVAk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jk7ycCMDdgIaRLQZtzH9SITa8UY4YpjNpCRRkXfcoLgqFdj07cjHTuEudUNE5RhS68f87jOR0Duqtx0E5iAYwHFWaPCr+LMuPlnFw6512v8qbhJBiGsnHHim3q0dblZJBzPm9oR7ChUy3kDmj26eqi22BlT05a6rfKuXU+sRjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aba93c01bso18962539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719062; x=1730323862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q44A/WVtj7cZXVYXYuDTMudlEL8eZwD9GufEFx4Z3TY=;
        b=LYdTboaMDoGQ7R6lPpCAlTf4Lrf4642WCQOBtm5zur1cYXEfG0SudTL5HGy/SHUUfa
         h6IkT7TolbBV0hceNcmWuwsZmyWZYd5CZ3g85ZegMTmR48Pgx1XeYG9vFoNVFBQoPCyH
         xsZs6Vu1KuNDqclSHCcfxm39ANiVoh6m5OW/PzbPpfQGelKC1L553VocsNBHphCdZqXl
         tdkVBoHfmHtBzOAW1ueurV3GxBtGTOjdoaZdr/kfqCe7zqugOSzbt9bFAr136ch6U41N
         sfw+NQtCs4vfJX4n2k6S/5JoU7Ezad9O1rYVwpLptQtzF6PiG56CRGcqJpz0XMzX4v2j
         rokQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtfK2Zj933ylPPv8vIReVBGDF8bHzusJ4KDfZ+4dzR3bRVtaJmMVDRVZ1y/jQSOSIQ9DH7qjMrNNxwFOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oM2tS+rS+n/rYiLfSsr1Zoz+D8ZejULreNbJHSm38dAeI5k9
	9pfm/R3Wkap/j0yDFocIK2gwvE/ZC/HQz4vG8eB0anCs1+lu4apWultF2sqNRDRA70i+Bwphl9q
	25e59cwfmv66wEiBPrqPvqJhzsmKxzeVznE2nlBx/UtW0O20aULBjOOw=
X-Google-Smtp-Source: AGHT+IHA8t8UEnIqlOTqKu6GQf/WciKiTYGXwN+LcJfVR4RIkfo19jymcVT5eZqoYV8uH3BMqD5bkp10D8DjlBEFhoOzu56R3/pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:39b:3894:9298 with SMTP id
 e9e14a558f8ab-3a4d58262acmr45927555ab.0.1729719062476; Wed, 23 Oct 2024
 14:31:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:31:02 -0700
In-Reply-To: <f605e8cd-2229-45d0-88c7-3dcae7eaa9e1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67196b16.050a0220.10f4f4.01cb.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com
Tested-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dccc30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=089fad5a3a5e77825426
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dd265f980000

Note: testing is done by a robot and is best-effort only.

