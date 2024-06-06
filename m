Return-Path: <linux-kernel+bounces-203813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E88068FE0BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53A71C24831
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41413A868;
	Thu,  6 Jun 2024 08:17:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43C5C96
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661824; cv=none; b=EnKJ4iQg9QbttK4UGpg47OeNP3QFsJqe7Ua+70mCr59KWdt25/FVRpAZYzEymzRMz5HHgSA1Akb9i2PX050u+YJebxRP8OAtO/nPkn0O9J32mlHAisPdcfucWl6SjQHDMMCm4/fTt7g8AId5UhBAEI0R5ruyTHwiC9yv/LjKiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661824; c=relaxed/simple;
	bh=1iAwT4rOexokslr4VkzFNBIjO5w2CqacAayYOvHb1nM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y6nSVWtpXIH3ObIxJq1cj6ngTRAvgp0Xxy1H+vH5WBTx8z7uLJ0Yk0Eamsrx3l+I2AkKIYjfBwqjttlesFCeKteiBL5rfHbBMqVCIYmjKHDk9kRWPYgX/h9SVzWDxaMhtS/NDoC09zA32+Au8ozJRPL715Iws0ooQZOPFU4R7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36db3bbf931so7074185ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717661822; x=1718266622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2o7hetwM7EVXZENeM6kBFmpp4JbrfGTg6hchmnat7o=;
        b=praUSrAk11+bNqmSVyUTwdmO0eZvXEAMNyYWnQSGnwd9iTVaB1KRZbs750GNf5329q
         bQptYkOCP9F6JMJ+xRUnniOZRmJvTWf1CVoul/BwHgh6SC39ZL0/Xs/8Q+2t4TmnJ9O1
         zCjvmqrQc2InEuQuB9Yajz1H8hCWSqn6pqp+Rt9sem+mCdKnijE7/yibAQ2Dht46kySK
         m4LhGzlJN/Pw3R79nkm3TjnmUFYW+UNDCksMrzDkwcHFFXFrxDzkD0cGaVe74sM5pjpE
         GqR9vAwuo82AAbtz8cY/ct91+t1EZROQl/GfSurM1+BXIShcEfi9u1h7vJ+EGLbIIkw3
         IWFw==
X-Gm-Message-State: AOJu0YzfjXsOxbvCohcPHKo1GG4HJYm1T4C7XBB6ASNugp8WakHCp+hH
	tE8RCaUizLa/Fgr5f0nFy+S1wroy1kUlDRL/JpQG/fC36UW6/ydCvGR0KDczYO/40kv1OHfiGQs
	HXr2sna1VMnNjnG9ePcImgcskDYU9ougbIbIeSiP2lAQiZhdlftH8VW8=
X-Google-Smtp-Source: AGHT+IER9iDWONIOZ0lYT9NzCwz+NWtl/1IFfc2eEqzzPyhuIuPiSKfcSnVy0zgOGNr6CjFyBgEdY+kHGJTQLgMiUGL2/niaEVfY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cab:b0:374:98c7:febe with SMTP id
 e9e14a558f8ab-374b1ee8324mr3451835ab.2.1717661822555; Thu, 06 Jun 2024
 01:17:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 01:17:02 -0700
In-Reply-To: <20240606075724.26674-1-norkam41@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c72bfa061a344e0e@google.com>
Subject: Re: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/06 08:15:57 ignoring optional flag "sandboxArg"="0"
2024/06/06 08:15:58 parsed 1 programs
2024/06/06 08:15:58 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         45db3ab7 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=177f3096980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1211f026980000


