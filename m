Return-Path: <linux-kernel+bounces-436146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E59E81C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45709165E85
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66B15350B;
	Sat,  7 Dec 2024 19:16:54 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E061E529
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733599013; cv=none; b=jxTEJKQPMm4P3gOd5JVr5jWqTmQgdTOptyaOccWsgOHDbTsCmmkVqTvOD8jxFX9uBuy/ZWWvphUpY4iJiIWpi4afonukhjsOhXm0uIt/37KR1D7fBrhziTLfwkviatlqoqHJHuzkIvnP/zipWC8bUuZNwunwyJ3e6isYhjV3Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733599013; c=relaxed/simple;
	bh=f3GXiWsYvAV48N7PLUMYc3lgNUpwG0uh7ZsslRjW040=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nmDHEQd9oHSchziB3b33c2i4DwZfZXHC4tBHaTBViJXsN5EdioKQf2SN+TSnP6pKWKpANP6aR6V5VP2depQIG9n5DyMXf1fjHOKsdDKoeYKd6uZyoUwhNVQ0pgncwTu5aZav4vs/H4KYHkLdemUInVuiFzXK0aD/WD1rq9FgZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a815ab079cso32386555ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 11:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733599011; x=1734203811;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3GXiWsYvAV48N7PLUMYc3lgNUpwG0uh7ZsslRjW040=;
        b=gMCO/cbhZIExIA1SvxiMp+BM2XELa+TlbPkSWbLejwFUeRjTl3dwtIappbmacDZm1Z
         RdtpqyFP7K9pvIXxZMwH4CjrDu3+Azmxwkj93SHk/pWUlv9LLV804ZKf64Nl+mXN7P8Q
         Ul5fC501clFBPWQwgDFKvbDxDIxNvZDlw8odWxUgEcD7eHj11HcbW9chLRH7nBTyesGg
         Y30IovRGQPdJRRaDYY6wkh9+CGxsIv1Fb+q/cRdv2bwU+JhqSA8Rl+6zA9xIZiJqQcB9
         WOI3KWMbH7PX2gCghyl/JILY+AYl6VEx3p8p+5QdKwEwq8xWjegoIq17TblBcD8ubHOI
         bakQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu7HBTpLLCxHEjePIHzr6Oiwjyvjn3exOL7mexhcpN18a5LaIhdmMD3Wnf0PPM41pfeGwAak7J6oQP6Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFjFfB4Z9Q0ftRjUPUaeNwaiWSgY7/60qN/Vd52XByk6y//fc
	QpISh2Y0+xAJjqznDI3ZWP+2Ucw1f+0eB5MRcsqC8/sIxuPgw92p58z070Wpnps3blGPea2dEzE
	Vgq0FD8qLqW6hoJkveB0PQCWsX6o4ojEQG2gRjKpbm0oXB1DojCZN+2g=
X-Google-Smtp-Source: AGHT+IG7RulbWBgbxQCmp8d13zGHa8pedymEFRRwimChHlDuCmzraKa5kB/oddAqGWw9SM3A5uT7dFCXIh8g4Rb8nwZMHini7Kfh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e06:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3a811db761cmr94081255ab.12.1733599011552; Sat, 07 Dec 2024
 11:16:51 -0800 (PST)
Date: Sat, 07 Dec 2024 11:16:51 -0800
In-Reply-To: <CABMo7LJa5deYaxgCuSFBMxSQeaX5PH4_mMyVnDnRQ+rJHi03pQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67549f23.050a0220.2477f.001c.GAE@google.com>
Subject: Re: KMSAN: uninit-value in mii_nway_restart
From: syzbot <syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com>
To: tuliomf09@gmail.com
Cc: tuliomf09@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This bug is already marked as fixed. No point in testing.


