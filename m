Return-Path: <linux-kernel+bounces-446921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B49F2AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DC163997
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3F1C4A3D;
	Mon, 16 Dec 2024 07:33:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854E24B34
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334384; cv=none; b=irjfv0lIyzk4V5k4oH8nVIlTU+bIYZcZtyX43yu96m4xGmlCBwyiIoZ13f/EWyyCzY9M9CPus58x/oAV6kKiT0WjUwNhrakZC9whXMLA25CnY8uN/JQLs6Ma9Dded3eHuBczuSCOcOH5IhlWaUO+zYuY0FWZAZBNcCJSG7PJpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334384; c=relaxed/simple;
	bh=TSvDwBThpfmqEhfTeJy6+ixEWqfj4eiHuoawhW43sWo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WjlNCiBt8zUAaRUofb3QH15FuxZwCmiP297m7fhZfVhid0IX3kBYMirrRuAN1XdoUzkklziHR30SbK/WB22FLvz5ggIf3nwMdrFnYUPfpB2TXkhmGfC6Ds7urdWs1HA/6tGWqqlzbR4jgh4KB2fB1m9+86BlS5p3Y521idCeQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso79386195ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734334382; x=1734939182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMPwaxyX+Zgk0ggaEPQbeOdezoUYK/bvKJ6J91CN7Ps=;
        b=frqSFBXq22lVDCsU0lEwonKI8Me/3T9ftqiS0EdH8fto19f7xETmrd1fCPtMWdKfVL
         yZSAXU8npGaFpiE65C9Jv8k6b1RCy/UhncFu8QXCbqwiBjZRurRzIwYqqa1mbFDosg6J
         igP8Q942LNGfHE3/ALDI6Jrf1+s5QhKpRjjPDMkf8DVieitFFz9+HsNgRQ3s6klfxUum
         ZDRDlqfP3Ulmx4I4gXlO928CJ6904OhOzYVuMiMkolP5ldOtgf8vWmiPDmwQi7aEsDsM
         fy6LgaUVuFevI0ts/NMeuvrQSGE49/Z2jJYb05kyXTVpaDrIgvWSthrRVu6CBB8Rfw0F
         EXRA==
X-Gm-Message-State: AOJu0YxNKcO5RnycBsqFPkDwgcQbqLyvs2+OUDqzy4l/Gmkdydx3ae7K
	HOdwIIrdZNmwG+EsSJR1wInc4ixCvbgnd0+F9YB7QJch6vLBFMLa+CWsPcO1L9nfYUYQVCfZ09Y
	eGeIOv6sHYYXQHdMjUq8jalv7b1D4Sy6iIx1veuyDXnEVC/pMQ/YqSCk=
X-Google-Smtp-Source: AGHT+IF/OsexMFZIH9F4DgCRliZqjkutp3HKi98q9b9sfoieal4QIuBuSzHso6flUpj4B4/pc2fk/46y+02Sd+0sCHgWx+jIzaE7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3aff50b57abmr119827455ab.7.1734334382240; Sun, 15 Dec 2024
 23:33:02 -0800 (PST)
Date: Sun, 15 Dec 2024 23:33:02 -0800
In-Reply-To: <20241216071906.2506927-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fd7ae.050a0220.37aaf.011a.GAE@google.com>
Subject: Re: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
From: syzbot <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in tomoyo_write_control

================================================
WARNING: lock held when returning to user space!
6.13.0-rc3-syzkaller-g78d4f34e2115-dirty #0 Not tainted
------------------------------------------------
syz.0.16/6711 is leaving the kernel with locks still held!
1 lock held by syz.0.16/6711:
 #0: ffff88802a08b080 (&head->io_sem){+.+.}-{4:4}, at: tomoyo_write_control+0x51/0x1b0 security/tomoyo/common.c:2657


Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d7d4f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cac7e24ceea492
dashboard link: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12eb1730580000


