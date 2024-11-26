Return-Path: <linux-kernel+bounces-422451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0D9D99D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9914B2671F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64B1D61A1;
	Tue, 26 Nov 2024 14:43:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80C1D5177
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632185; cv=none; b=mi2APBjF/eY9MK9wID1DosgHmmkUxXLVkG7AhjOPtEKswt20e3jel6uo02jIVcMRUNQSu9ZqifuPzlrlgXoiLpCfFtR3/tfWVE1pu5t2nXP/ZlNRZpnlTbEoISV22XVs3D6Oty3eZZO3oVIncneWLybug7L7wAW/380F8dgk6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632185; c=relaxed/simple;
	bh=oZ2U+TR3HpR8vr6TU1NLBMPx3jtCe+sz/la9/FkRAK8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KhmOF45FPL695fRPgiMZoyCTRXF1R0tR6+e2LaingPOy5x7GrpxjA5GoB3500ZGrNP2mVqwIyHO+ZYLRR8GhxSRXJ4kfeVghxZHFOE1KPRcKVNry5lIhrO8WXajrzzH9de8+TlBoRK0m2FSwnMXdDF+wNQLAjng9oMQqg3ga0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a79039ae30so59556455ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632183; x=1733236983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm9TicSPUToN5ja0H8CfLPul6Rp0mNhRfDIRhAmk84A=;
        b=EgKcYdL3Bm0ZmsnZvMkUixEHGFK4uYyeFLrzmdmWrvfrmtIiUAyVLy5X7qrhEYqruG
         CeZFAQeACCDIUkpHCXEG4zEiLLGnr1t9A+w5nmoxt5HJXgj+IwtQ4er+g6YxmZ4D2Fwq
         X63EMCyyu382ERwU2JFAMNDfhkjeoXx1FCu0CKMSYHKAJg0Fi3vuO0t11wT2NuycHuW6
         O767qOBgjd2hA8L8kfAXIkemHbsYTCmjsMED+Eioxll5RhHr2mYfWgBwAsuYmwTsTAS3
         Z1Qn1Mn2Wo97kNOSVfjg5/HDv4CYU1gsFWZAD8wlFWp7TpgaX6ihOBVOqwmzKy9QqOWA
         +XYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/fLVF6nEtP0k+TobKGgSTTy36gC2rIU4eS6AhYgIPAPAKNS3CbfzQajC07pfPcm8zlKP52Z7W/rUJZCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYOLsrzhdrtVBCa+qwA2FoAiBWVBFGzO4S9rfxXhAeWrSqsNY
	j/h+V+Y+L+w2rEa0k7Z/oQanD2XLYdQGa7n2RQpgWf4VLw0FEGPHIM/Aw8hKI9bOAMuQVM+Gpw1
	JF8rZhvjUqDXihQ+p2xMDB/baAvDOAy9xXEU0O+I0L+hjuGaLyX9Fu38=
X-Google-Smtp-Source: AGHT+IEq64wXQsmpsUQlLvYn2vOFU+udBfQ5L7C2L/up205iGAdxfWd1unk/NWHwUDNiRLb+Z80xYNtckJnO2cIykQB6dE2hmvVA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3a79acfb902mr228550875ab.1.1732632183229; Tue, 26 Nov 2024
 06:43:03 -0800 (PST)
Date: Tue, 26 Nov 2024 06:43:03 -0800
In-Reply-To: <CAOQ4uxibdcHmnkn15G1M+8Ay7TK_4uB1tUi06+yuPWAze382Lg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745de77.050a0220.21d33d.0019.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: slab-out-of-bounds Read in ovl_inode_upper
From: syzbot <syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
Tested-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com

Tested on:

commit:         e638d5c6 fs/backing_file: fix wrong argument in callback
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=103e9530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afdea6b282c7e739
dashboard link: https://syzkaller.appspot.com/bug?extid=8d1206605b05ca9a0e6a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

