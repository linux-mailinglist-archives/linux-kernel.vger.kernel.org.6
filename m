Return-Path: <linux-kernel+bounces-524994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A047A3E98D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2997A4EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F538F9C;
	Fri, 21 Feb 2025 01:00:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB62A1A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099630; cv=none; b=hPH+1awYwsspw4TXkKSt7Lran5w00inYUslOw4tHNrZfFTd5opCUNUGXu40xTLv21gQKMb0Jaq9ls0omiF+4H2jkV8VrweqGIdvDSTH3VYuhWbrhoEthk+f/9zDK/sEgrZIcqEK1/0HUznf1GBsrGe606ep0OiI51OK5q5gWRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099630; c=relaxed/simple;
	bh=Nik023f6ALS7M27mab7ilsCCPmRYMXmZPt4G/6s87cQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gUlF8xqzXrNoZ/JrOVbrgnW70b+uz0xi6tZaAfXDWpCnR4qJqz9g4I6WPCgfhXqMl4NbUk0LBdVabyO07oyYbq9TtumSUnOdzqDuEWnGx0CfJqvoZf7LAtxGelNabbWBOjnXlJApusgS1AhP200pt8Et0NXubfa4euSBQOXNqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so28490225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099627; x=1740704427;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JROBDxhCfnPW5pT0U++dtoFUf7G513HXQEGZMq1RknI=;
        b=xASMGrMX7JMZ0CHqWqlUr4516nyLJpz65hqPpTGDAM2lcOfDt/JNtaF6cdw5LvPKV8
         t3YbtSFDFMggCM/E/G3oAb0tjQ0L20wsPQw7p6fcv3rFhBI0/dY3zSTahYg17q5eR7yl
         ZBSy8r2A3pxn1NT3WaYjAVBWkFNACojenv0IVZMQYXjTI+VMOk0FdmPsid9gwLuxBEQG
         9KAthTcQm0KJoxy8Khx8jcHNVjmD8jPhB0xxMNPNRWUvlnUtF7h9KsVztLmv/uoHH8XY
         xx+9m6jd2ShmVNbHf+NP0Zfg+tJFQ84m/OG6lwUn5pbyzFOWEBsuWytzSzc9PXop4jvP
         emfA==
X-Gm-Message-State: AOJu0Yz0diUd9wrmqpKArXdfaLFRBD7nnvid0pMCetJS0my1ZZADx/gd
	z1l8ttPbv7Hb5MJJ6ZV/Ztxgx9Ds3c7c9aDxti0zxy2oWDolP95q/yOpzZmZ4gX+nild7M++gQH
	mT/jujkdrKOkIBdH3JbU1mxykMfbroAFUoNWTf5msjBgTiYLEanE1W/Y=
X-Google-Smtp-Source: AGHT+IEJXJ3Vaw3HeX46wjnp41Sn9cbF5MmbIRvB5AydbItypawET7g5xIlvYZDpKNdKn+HhcLMJ4UUSToDO3CgkzYop/XXSQ1Sa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3cf:c773:6992 with SMTP id
 e9e14a558f8ab-3d2cae87c65mr14840955ab.12.1740099627641; Thu, 20 Feb 2025
 17:00:27 -0800 (PST)
Date: Thu, 20 Feb 2025 17:00:27 -0800
In-Reply-To: <67b75198.050a0220.14d86d.02e3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7d02b.050a0220.14d86d.0302.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bluetooth?] general protection fault in bcsp_close
From: syzbot <syzbot+9c957444e37d521b3b94@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_close
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index acba83156de9..18793c485319 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -716,6 +716,7 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
+		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
 		return err;
 	}
 

