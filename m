Return-Path: <linux-kernel+bounces-443790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3969EFBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4890D28C731
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6212E198E9B;
	Thu, 12 Dec 2024 18:54:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540117BB24
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029644; cv=none; b=sLMde64RNwna5qE758W6FXj7P0BOYDlu4PSvvtgv2VHKV7UuSWDfniDTE6gZ1fVDN84TXPRjLXPX329JP5Vza6/zpMVsPR2fkwqppNywLEgOza2hTvO1BPadFC3d8noCwwtBJX4Qsj5GBszlXquW8dBU2srQWdNAy83lTaYuUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029644; c=relaxed/simple;
	bh=UNfoccElQa7vPVF/+H7verdV4aFdCV8+TxBW4NVMXd4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dHL2pT9Uz50EQ6jF5dwCNBgE5hljQEXWko3OnenHIF/Ng9u3J/r2mKLRpiQhGJuK3fuSPziF02rxUlw8Fsd4IRCjwrimFTUTynCxmeslQj7ZWkmOK/EjLH5DoZRsJgSdMY9T5gF0b4E/jBXkqYRimzplm+7LbXKTH7Q6H1as1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so19906375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029642; x=1734634442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGZIvxS6TiRFu9OGA0eW/rWMD+h6T8MG4Iiwrml6hRM=;
        b=AaYertaQaraokK1tiIqQ91XWTxFISEDJffqE3bpIr8gw9wKVjOUoY9OC5YmaDnL3ky
         X0vIdNT2dK60mJ0HO0PVRMLSBGFvyvMVHoNGQ0C2qa2szbfeyuD4O+Cp5RLYTiBMq4dK
         DeMK4IGG6obqnB83ildBx2k1+VQPEAZETBgRN63j8tnVSX05eUotyTwx/siTgBiFxqEP
         7tHT9WY04WD1pl839Kh9rzKm/j2gBFQeQLbp24rNIhUdOnh5HqLo4ToK9RXxCIhvmHGS
         OiFa+uxavm7gewDRQ3Pt/MyX1bEvZ/ves2lmVimhDpwnf9VpEFB0HwpeoTqhZQLORrbN
         u8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXgIc/oZvkF5nlLASa6Ci/4hS4mxAzzv5d7iNms9IxwmEAzI9B2h4YEFDVE0yUy7Eguz/o8OdUXTtO28r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7e7kq0A1M5nTnC4ntlWLs2aTA+RtskqBtoUDbC9jY4VCX1Sku
	oGNLBZFb3UXUrGUuaho6pDw4hlLs9nPTCCagGBa9aUaU4TkGlYZ38KrrFI6GDJWhsDaH9SkAOf2
	/K17jhBb1x3vJjdDGnqfDMscx6VCxwi+DX/+HedTLOZ60WanfR5OD9M4=
X-Google-Smtp-Source: AGHT+IHPttnKL/VopRdObut4bUjso9TOqY9ZDrYo53sBLI8RQDCED5J7xQP71J1rT/UrKWtVsLLlpkA8kRXX0MRSZoDmjLy616lw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:3a7:3760:7314 with SMTP id
 e9e14a558f8ab-3ae589a4bc1mr16171225ab.20.1734029642410; Thu, 12 Dec 2024
 10:54:02 -0800 (PST)
Date: Thu, 12 Dec 2024 10:54:02 -0800
In-Reply-To: <20241212180316.A1q7x%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b314a.050a0220.cd16f.0016.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] KMSAN: uninit-value in f2fs_new_node_page
From: syzbot <syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Tested-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com

Tested on:

commit:         231825b2 Revert "unicode: Don't special case ignorable..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11aeecdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95d0bb0535bcaca0
dashboard link: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158d0730580000

Note: testing is done by a robot and is best-effort only.

