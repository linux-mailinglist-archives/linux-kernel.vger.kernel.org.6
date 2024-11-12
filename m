Return-Path: <linux-kernel+bounces-406052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6AC9C5A71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020881F22456
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36A1FEFDF;
	Tue, 12 Nov 2024 14:32:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91051FCC42
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421928; cv=none; b=TP/FjR44F9c1MSfQ/fbLKUzeDzJTO3Wg75ZT8Ug658zoupuyxlrvlplAQ7hbEszTsq5/gpOU1ryu3PNzluzVNMAXSaPkfHtClIC8KTPIy98D3U7mknWBEQd/uU1kqIy03/+6s3Sbzq90dD7jlw3KQJ/UVd9zXdKCJM2ISJLiRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421928; c=relaxed/simple;
	bh=fAR7NsHOFHIqrJXvbMl4qc0UVdjQmpaMiqyavC+tHJ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MwTEt8bzxzachfbn3TPblv6v2YSG3eVf5NzgHl58ZsGTvSvBbm39h32bzqnDdJlOESopah0ScCrHnsME/P8cxH7uiRMVHDtXPiXtjLPrnQ4+O5X123Mt3eWlppKQ8rLdECuu5oqjeuT/3aMBiDMlT8/kxBIQ5mRGCu3LMd162GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so62019745ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421926; x=1732026726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBWs2Zd4T8e9v0oYYaH0pBxxLwc7TOyhEeIoWtbFK8Q=;
        b=vPN6IsqlQFFRp8QvPUbcRy874++pEYyPuTTdY22bt2xekJcsQkS6KqkP8OMYtjoLsT
         OqDQbsZCwQMmH15rR4XeEcfwg46YzVLCz3vCz0WVID7fbFAvGUKYgCBYtpX/qBzfGUdP
         jEfkpHm4X/Zh0smm80jXr2MERKVQCNhJFUDeL5oorBvxyIhYHSGtmE9Mybog/krbRCVn
         34wCu1UN1D0+yhSSIXC20q99UFwk5pgJe5U3S4V/FgZWE7DqPa9j9v1TjQQVuurL0tyD
         4+QBaoxfz4Jgaq57NWnOYDWS/JezYVZYS9khaTuSiJ4ORueqx9LMpXKedSs6CwAOzv1o
         +fpg==
X-Forwarded-Encrypted: i=1; AJvYcCVFPxaHMZLKzwpOdZD/QA0KnFeC5z1CMGP6lSkdPjqOshmuSr8MIgkrMFsAScfyVPIVOynwNDTgL3uf8AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6RMaN0BkjUXOhZvs/rY0SszzKxGesDQuPzxmNiqCrqeX5kuhy
	SKJylzjy4Dbc9oP/FixbhBQ6YjEAmgoyYDk0xOH/wlqA4Ewbl3YTBjMFBQQmSX51VJLQX6JKO1d
	6V+GWoCyT5fOLdvh0kOsU4yHBTWKHCptFtM3riCHpzhMvDIpfLXUTPBg=
X-Google-Smtp-Source: AGHT+IH+odsalTFOJKKKW5uexg6WaA9g4d0Qrx20qSXJsuWc8jFUFFgObR0N2apLEnR9cuwGy55QGSNpcSZOkcSZ/64ixYTgB++E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a87:b0:3a4:e8cc:2aaa with SMTP id
 e9e14a558f8ab-3a6f1a07897mr183506185ab.10.1731421925894; Tue, 12 Nov 2024
 06:32:05 -0800 (PST)
Date: Tue, 12 Nov 2024 06:32:05 -0800
In-Reply-To: <20241112.231215.1262254749077533950.konishi.ryusuke@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673366e5.050a0220.5d845.0005.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_find_entry
From: syzbot <syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com
Tested-by: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13600130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=96d5d14c47d97015c624
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d201a7980000

Note: testing is done by a robot and is best-effort only.

