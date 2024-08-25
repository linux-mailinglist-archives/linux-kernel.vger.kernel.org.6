Return-Path: <linux-kernel+bounces-300273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584095E1C1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ED51F21EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2AB2AD29;
	Sun, 25 Aug 2024 04:57:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925F2F46
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724561826; cv=none; b=nJvMUq6N905VMN7D1pjoVh9JgBP7kR+M5s/ruzp8TTD56i/dsTLCH0isTCymLraDWR9IwPrPQsqg8Mw+hbgfCtF3LxTioiuSTGxWTDunEDXnf+BF3TnbJO7cacIFwv+l7WIL64I94rgfViWXbNwsrVTDncaDInONi0jiwrj+AOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724561826; c=relaxed/simple;
	bh=9XcNoWJX8/MaUwNzGRGlJlhxcScfBfyXNwa4OsWGErs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RIaliJ+JHdGkb/dRtzraz4/w6HvQthqjLKdQNEF4hRLEww9J/ttXX4U9UFchBoyHpLp0c+0F3JTwTu/RIMDCmCT0E4trrjoLcNn5aqJI7Et0RC3DsX/IOkTc7FDn2RTPfSKSddZgsOdGcgQakxdtLt05qXGHGs/SFUnlSscPxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4c656946so38738875ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724561824; x=1725166624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy+So0va/2sU1sp0yX1eS4yzKgzVLJwJurjiPIyZ0Bo=;
        b=BlR+3POwZnSrziijoSIqz9Z5TVkxYI8aW+SWDGsF3SEsFV4100Gwk/NN1X6nuWxCQ/
         er5P/aY0ynoi7tciwErs4LsXkeKlS2coBko2YS1Gi8P4A0X6WbghXaf4TCcbQuBNQNll
         bV3TOQwc7kW241gqYnrVlXmF6pKv4DsbI9OHL3H6YZyukW6QBdMKj2wB8cPpHgJRO3Gs
         SviQvzRNUR3u+3IikcCxpACp7JWsf4yVg2QyREQSCmVbKkIG1epKpnJp9W/iFFci28GO
         uloHlKkQfwyV+LZz/xEmAxHqYHT3qBjQHDIk7AO4Pc7rK+7rxaIsfnIxorZe2A6ZEQmX
         cihw==
X-Forwarded-Encrypted: i=1; AJvYcCUQhD4XymZR/4p5L3Zxz9xQg/mRa8ZMsgdUvvJHGemfbKonH/SgCWyM7LJaGJsPR8OQuMXdWelkBstzoAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNwDIxbyCmm8cg+E+LxdJ6LRrgQ5zwCVYPvMzP7Wezyi3IUJU
	LS/j8g7UO3m/cxwmHmXod+KST351IQc0onmABTQuMg0ubKx1ekePiyd8O2BvzwW0br62ax0Dz2h
	87gQHJRDolMHJPKhjOo0vpEMgVHM3akfqJAILUG6hQSNtAzheAd461fs=
X-Google-Smtp-Source: AGHT+IFuvkIprzlhvRYE9xPY2mFBPbQEZRYv1wVkhw0DTGai49ASyYLxbFSZ6dfWiMlXV9taZBQ5pT8i4V/j7uluPeZ5TYrqZnsu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39e3c975718mr5766565ab.1.1724561824175; Sat, 24 Aug 2024
 21:57:04 -0700 (PDT)
Date: Sat, 24 Aug 2024 21:57:04 -0700
In-Reply-To: <tencent_64FB06448999AEE1EEE50C9927E9C6D15206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec66d606207ad63f@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] WARNING in ath6kl_bmi_get_target_info (2)
From: syzbot <syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com

Tested on:

commit:         780bdc1b Merge tag '6.11-rc5-server-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b4ec33980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31bb2857b4a82509
dashboard link: https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a3b015980000

Note: testing is done by a robot and is best-effort only.

