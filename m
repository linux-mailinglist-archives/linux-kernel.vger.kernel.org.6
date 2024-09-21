Return-Path: <linux-kernel+bounces-334722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3583F97DB11
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650481C2098A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9123BE;
	Sat, 21 Sep 2024 00:55:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F315C3
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726880104; cv=none; b=PH9Nc8wjXZwTdQuLXUDO7DXqr3YQaqFXS8+1OxluZGd5UvKLzuliAcuEqBgQUp6YpOebw+1V3PsbKBGjBVbsXti5nTptcr+hw76AlE/MT2IYo4He6BY2+to75V4YUABzKwHdDD1rLD/0ACothe0J1F0n0uBCj21MSyvDCgTTgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726880104; c=relaxed/simple;
	bh=vTRUsiS/w9JpyggIat4s9090UznQgsN86hX4vAq0Pic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PTL6Gf90Bwz31TzoGA+XpIUkT0X/poM6kUrzBqphch88wgrRO870+2L+njFCB33QiuYpnQFNLmjsIW2iammbqk3zLOkNfu9EgQcaiHcGDGJ0SNsnvWC6FW2dOoTicxi1/+RLDAhm21bVvB7bqx9auCQlBSJTOwRHZsuisQu5GrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82aa8af04feso272915839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726880102; x=1727484902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAYEzb9MuuROMgm35kFHbu1QyRLa/2KRyxscqCMd15s=;
        b=D/B/f0Iw9lS3ljp+RXiQtVAecxQAup3zkvFTTJLqC87dsZNCKuZuc2t9hE6gTscnYr
         hnWOTjZmvr/gb1W2YCpax+CE1gibV1dOEjrjHd5oy/2eLAVLOECW89kT19sN7nxVut6m
         ZKBO8J5G+N4Db7fwo8Lao+8JnKTMw1u/VxHEPbV8jEfrguQt/9PKmNmhHWHplgyzSOS9
         SBGRsZ1eWEyT6IlcXaXdammtPjNr9sbgPs7HHH2skS7bsgivvxhTEoJe5uu66FbCuvgP
         Qzw592K7XPNnR6KNj5qA9yR/c/6NGL17kZEkYmMQiyquT5JJgGZ1+rOLfyXNzwpvk+9K
         TIGg==
X-Gm-Message-State: AOJu0YzwqnKbkt/EmEdvr1l4B/4Wo6aAoJpFz1kEU0kGSe0jvr6ZuAF6
	R9fBURKXFR2IGRQoo/i/PqRaF+VGawEvHNhSygjafoR2Y8j60xazQUL8JW21prlKTFeCuPkRQei
	M5J5qD5Yjs0OfAlrDRj2KmEyXFEiw/paadCTh+oWaRzf10u4H9sQTCs0=
X-Google-Smtp-Source: AGHT+IF4v9lW4V2dBPJ+8/+5UEINk92sW0Fb5NDfI/U7gbQ9jps47s6omtbATFY29NgZA1zXyiYkvAzYm6otsBg5cU+FCyU0JAxb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a0c8d1602fmr56358995ab.17.1726880102211; Fri, 20 Sep 2024
 17:55:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:55:02 -0700
In-Reply-To: <Zu4SCP1PvViLNOtP@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee1966.050a0220.3195df.0021.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KMSAN: uninit-value in netfs_clear_buffer
From: syzbot <syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, marcus.yu.56@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com
Tested-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com

Tested on:

commit:         baeb9a7d Merge tag 'sched-rt-2024-09-17' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c57607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acaa65be5f19fc5a
dashboard link: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a5a427980000

Note: testing is done by a robot and is best-effort only.

