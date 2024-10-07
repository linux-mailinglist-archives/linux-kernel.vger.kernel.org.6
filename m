Return-Path: <linux-kernel+bounces-354140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B999383E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9A01F22476
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74951DD546;
	Mon,  7 Oct 2024 20:31:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB52320F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333064; cv=none; b=T7oaflSDrSISszsW52HPiRhuIoX3kdlodiyoP8B4Ra8N3JvO73FMJPmo8ou3pEDnedSiMiU0PIzuL33Uzmn+Q69qIwzqjHYVvdbL4UPinwqIdsEKAvcmt5yFqPezjqA35vNlO8gnvP10dcoZxUNLHgA5PtzAaQYc3xK1nyT44NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333064; c=relaxed/simple;
	bh=aOsETMLErRCS/BfHmNp4mfHluNGXQGuBul2dSh08/LQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GxH/rcnDDJ0BLz35pc4gIkDY6imWQB3bPLWU5hqmNpbV6eeAPNb+prqrdeZcNyVOEOeJgEaFLuuYRh9ZycmcwqvyWmRqkd9gGTSQUFMe6uCA9a6xDljPuKEdsLekf1V3HLDewZTjwdK6dTeWUIySW66pMNNndQ1+tt387Gbvwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3496b480dso43723715ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333062; x=1728937862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEYORwWNcL1Omn7+Gt0+HjIWbRyypA7wNNgoLRuOSRs=;
        b=Jvoz2o9/atz62JhFMNfnML2jHZJjuBoLsxPAmoeGdGGEjTvwgnFzLynCSHVqAnIwFb
         Dx1kClsGfubrPANDQvvHt+3lSi6IrdhZ7SndNk0uSF2jCe37XknSVgwhx1QOi5d1tkpV
         jl6OMfmn02NU+eIJ5cblLdwIROXhs8HnBWEzNVcECYJluTcppuBKSgOMaoOFqgsWmU6G
         aToznZzkyj8wZeeSuMg11yOm2ShHYBk3eMF/fthFSkOJYBWMM+9WmsZJpGPUC5KQt6nK
         RmvMNjLZ7oY54ZDUcgwtFPWqIZ3PDUYH/V/Jn+fAFdpU5LuX4njxBt/0R9bRsJKOzoPH
         /MBA==
X-Gm-Message-State: AOJu0Yydn3bRP+opq4bYBQrPyjV1q8CFHDQwwK7oOXvTz9kC85125XU5
	GPbuyrxEUIcjcqmfmxZmne0uJ4mXdSsEXmVcKnr8Zuwxx5mEN+0GrZQeu2cCcDVax4d5yLYElEn
	CdZdnpo5CBxlq8cRuT3WV5SzVgYJh/8xzixQLpV581wdKzggdxwaEmVY=
X-Google-Smtp-Source: AGHT+IGY7Gw+d2y52bEgFWcK/ri8aemP99C/CUsLHvoM9H+duuHDYe721yjmsw53NRFWsBsPfWdX6lkpVv970+6z0SA93lf8/F0e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a3:4b10:65a4 with SMTP id
 e9e14a558f8ab-3a37599ab3dmr111567275ab.9.1728333062045; Mon, 07 Oct 2024
 13:31:02 -0700 (PDT)
Date: Mon, 07 Oct 2024 13:31:02 -0700
In-Reply-To: <kQXi06MMqFpJHpnTUVuy1lTREJ1DVh1obmiDutmzESdyf1fd2z6pgLfGa32VsBMugcR38-G11y_XLb7M2f6IDWu6OJhnKsp-taulKl3c2sU=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67044506.050a0220.49194.0519.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in bch2_replicas_entry_validate
From: syzbot <syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com
Tested-by: syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com

Tested on:

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173ca707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=4d24267b490e2b68a5fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170ca707980000

Note: testing is done by a robot and is best-effort only.

