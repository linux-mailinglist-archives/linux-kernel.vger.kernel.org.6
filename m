Return-Path: <linux-kernel+bounces-210185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4881904085
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B62B281F53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A433987B;
	Tue, 11 Jun 2024 15:53:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483D3839C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121185; cv=none; b=UDZLE3eHNPsYILw0tmceWUo9s8fwXq8W7bUcJKOZV6dghvd57JihXJf2gHh5J837dM9bDLulNdVHGVd9HSuutqJP98zPks4sl49K1GtHXHl5NDOn1TdBFCsIqEr4OAUeZFsbfFdbVW+jIfG+epI8sPH+vhlZ9FqgZ/PHF8HyPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121185; c=relaxed/simple;
	bh=4YWTAY4k/NT07i2PrAMgV8Tt2wCvS+q0e0VohlzadUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n3n8xup4yq1R8uMTQHjX5but+zw6KxjgeMOh8RqtDouJxkEO2pFCBioeO64j/vpjHBqhc6fWwOfextyaJyLFC10dzLL7xCVsYNUXoFuWo1cuQsTcNqIZaOw5Rm2HtCLWaJH3X9YdLcoJtIhPNUVjvR0H81HbjahRTmX2RXxt8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3745fb76682so60978525ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121182; x=1718725982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFjbHNvcgSLNXhJqn3uZ0hKKgUPVLUjPjtWE4E1qJgU=;
        b=CpVlzZeoKF7CSGO/KXVP+1UP6mUDPV/VS/vJS1c7pT8eExIWTQ+Bdv3nyO9so8Fd2k
         C+DO/AVOJDisLqHTEhmkPrwfYBRx2zm/2mbena40h0DCXTilOM6do7yVSFujO+7XheM1
         bKkdp/AQ5vgZj3YulLp/Xvwb0I7ZqJGePopVDzdgGJyg5gAiAwZAeSb/0tJmDxcY3ixs
         FQ90Gqyt8QGQlo4iQk8R511uiw0tHOWWJNKy6ni8YC5yC/YXSWwzDK4CZ0Du7UosOU34
         T3p4YZhPM6Vu1BnnYzltSVk9CRWzPN9d26th3lGv/CCddFnl+LP7tT985mY4FUTDGLjB
         CuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ15qONh0orpzDoYlC9pyYZtf9wbKngG8bBQkAcXZK1yhZNE6Sdl8E/6sj0Tkk/t33aFwA9+fsRWbSLYl1AaRdHN4ZFMgpDJWL1z0n
X-Gm-Message-State: AOJu0Yyhj+l2jSflGS07Uf2BjZgTmA9x61oRQExj0oC/OcabdAfiT++K
	fNA3kJ4obASpPERkJ1V2BL6RW7vpgX7BNbne3Ta6rNS3oxmVS5YmWrifmWo8VCUsUkOpXeOeUmk
	QRbseZgtlZRzrc3qyLNc1KURee6e7jv4VqkFIBaD8ZhLCgQQESG711DU=
X-Google-Smtp-Source: AGHT+IGX4GhvZg4jJi7qIRxkQJLJsCVxY7kkD2G+PAaxGMOK9zdGU2RuivPQudvigA1TlgfuRyax4v+kmchvaBlro09kIzvP63XE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:374:a16b:6f7e with SMTP id
 e9e14a558f8ab-375803c4cd0mr8494635ab.4.1718121182777; Tue, 11 Jun 2024
 08:53:02 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:53:02 -0700
In-Reply-To: <23b1962c-044d-4dbd-a705-58754f0914cb@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7e169061a9f42e8@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
From: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com

Tested on:

commit:         8867bbd4 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bcfa36980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
dashboard link: https://syzkaller.appspot.com/bug?extid=5f996b83575ef4058638
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17790922980000

Note: testing is done by a robot and is best-effort only.

