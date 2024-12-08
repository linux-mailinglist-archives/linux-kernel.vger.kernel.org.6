Return-Path: <linux-kernel+bounces-436310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D09E8432
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC563281ACF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CDB7C6E6;
	Sun,  8 Dec 2024 08:21:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCE28691
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733646066; cv=none; b=dNZlcEbyBaUx/bLiXci16V9rnb9g0sx5A3R6hnGJcaCSqtcqXDkNPJVHM01Gd1uWUyl4xXasp93aUMCKh8cm3jXMDJdsPZAmXQMLNAdqd4+xKDql7BUOVD6ZgcfTSs1qBiG8z/WBryw/JfJLaLlZUgIRC6dBLLaRcuVmnUQo0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733646066; c=relaxed/simple;
	bh=K6n9Hg7yg3kRa5AwkvKWmbxqvP0JXjfsAooeYKJ3dqw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hH69O4Hq7XIS5O0E14ucCFAm+/FquvxyI04tHHDIfN8wdFkpNNs9j2OsgHElXDwsokMkz712wfFAJYEiRwR7pYIs0I92GMk5VNiIsKU0HLYONK7bc0oUDGazSAfJCcWQ1JM8adSXuAVONN9lgBo0TM3xuPAoD/7qxZIfZEdI4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841aa90930cso315755139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 00:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733646064; x=1734250864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSxII9Zkal/cqf97D7R42a7rJvgYvLT14C2bf6snPok=;
        b=ENq54hdFymBAd5H+2jgYZ2wUnP4WcDi+34RHYsJ5/6drHy7sXknKscx8vvb45B25uG
         7TDcNET5BV+zNFlhrUFXXOecCsoG5TnXapWPJq6Po2VtkgcBDLZMeZn2Pn9KCNOB8BKQ
         oszlKJy+2AAQo7w32Mgr6i2TlDbTTkpUgSyUFwhfMYBj/aWGgUI8pwqgEIoiAosktJzL
         ycGNERYhWJ4k9hi1DAdAQBGBTh7eMB+uR3iJJbbneS8oplGSg2L1VCFpdecljctB5qZ6
         Io0A0Z5nGlcFKOW8w5twkF0yn1EQu6g9wyiqeu1OoqVY97x6ShPVJS+T+b/RxbrirEt0
         eqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6qpi87nU6N1rnRMbAhjlnDp4oyXMB7QfordBj6C4gnW6O9JLv2lElZ2cGXDsAcxMLrFmTFtmnqbdPkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLsYXOBWo36PH75YmszVYFx9WZIWxcb4Z0vTohE/MI3qITEKP
	gNfuOnABHq6KDjXL+1cg8FzoJgZkfcnVfGR1XaVT+3vrGsJS6Yrk6v2koWGVNVfWrwqNX1Nn2ph
	2xWmbzocDsG7vus2Uzn9f5109RHK5RBX2GNvnIeRNNxcfYZeX4OnAJeA=
X-Google-Smtp-Source: AGHT+IEMSBaFk0ArHb79ZzPaYoCzAvg7K/58PDvYg10807cVacnmRH8gDee8ZOBNRELQRAS/cGScABzQQ3xmzafqvUHyCCafQj7A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1888:b0:3a7:783d:93d7 with SMTP id
 e9e14a558f8ab-3a811d774b6mr95088935ab.4.1733646063827; Sun, 08 Dec 2024
 00:21:03 -0800 (PST)
Date: Sun, 08 Dec 2024 00:21:03 -0800
In-Reply-To: <20241208075058.48814-1-dennis.lamerice@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675556ef.050a0220.a30f1.0173.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in notifier_chain_register
From: syzbot <syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com>
To: dennis.lamerice@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com
Tested-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com

Tested on:

commit:         7503345a Merge tag 'block-6.13-20241207' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142f4820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d99f0bff41614d0
dashboard link: https://syzkaller.appspot.com/bug?extid=0988a383ae7c57b99dd9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b3f40f980000

Note: testing is done by a robot and is best-effort only.

