Return-Path: <linux-kernel+bounces-259599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87065939933
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FA21C21A63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03A13D251;
	Tue, 23 Jul 2024 05:33:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E313CFB7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721712785; cv=none; b=ai2xSHVkhvadc2BAUexK6eiZBtLRTzMrwLa1fTQ8vYiuJHESIMYlzCuxL1U74rEn0hoZ7ohlzyHvy39bKPBWBNNr/4cx8QTH+S+pf/D/U+hdGyh/GqWnsOVr/5XiK1Muy+ZjPzqY8LGBTlKelJ0Mu8aA6QhI7lILckPEGND7q+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721712785; c=relaxed/simple;
	bh=Xz44m3j+L46P7S2MMO91l6CGoQ99zGgAJVWIu+b0MzA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yewny3XqIPpdxTY9aoUAYvscrY7OR9zvxLAaUL8kQlB3oMikfrWJ0Zusr7/RvRDTrEP461qCcjsLH4eM2+U895pyvFvBaHRqkBeaiIKW9Vr9Dn3gqvHaONGtF4NXmpEoWLon40sDoiZ9mWuaQzWddO+O3PQrzr7y5pfJOFgk+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81d1b92b559so305323539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721712783; x=1722317583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07mMm2HTl+CxW+FUdHtY4cD8npz62x8KwHeALxluW4s=;
        b=etKWCiG+rC89liLhiSB3zHMbxqHRLIlfGpRk/7DaO5vqSbn8Mb/SW1qde1thIQu20P
         bzFCvY2ZMuwLiy/4rRiMU+FoDwiX44056kxvSQZB3ZSf4nGuZa345iI5X+4k2TYjCe+Z
         YGeFpMeWaNcEcLCUtV6Vkxsy1gTW68kZcV9rm0OEfK578XOtaOZ0o06yVa4tbhTo44DB
         SXMIogd2FFoWrODKy4wwvQHm/lD41evJqzM24csshJeWf6axwgeu+vDWkJNIwK8HLpEA
         eamdKZTiSlABuILPQVSFGOlSvpq2GXcXQjsfbfoVB8iA/XL7bERCNPB/FLViTicbE0ou
         S4pw==
X-Forwarded-Encrypted: i=1; AJvYcCVb/YyOAOPG3+KYzTasSd6s1bkVp8QRwm7ZnnIVf8Nlkg2U8KIfD+Fru0R9WXUL9KkV2aB0Jxkazn7dj2OnpkXH7it4EZnxGtGcID/a
X-Gm-Message-State: AOJu0YwP4ncF6i9u8bh7byM+XhIbaopUeCyKMg7vTT7JyMMUrlmqcyP1
	xHX2vwqOqeJA11/bVGBbix4zVD44dNQmBdQMS/aSAVPWlrcjuPuBiUfjM12uj9Z8z82HoO9NTrM
	VXk7L1IM2x8uaApssYneTuMT3oMrOiC4TnRfral3/FgVnaoSefzFnvRY=
X-Google-Smtp-Source: AGHT+IHGUsJC9VmsmU3cOOtHllIAk7yjZD1XGw3IEHkz1rRt8RwHdENbZCLzfNxhapQPT1mMfdgZ1LUMZ9nXHianD+oLMY/bU37b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2187:b0:4bb:624c:5a7f with SMTP id
 8926c6da1cb9f-4c23fcbd7b6mr437637173.1.1721712783378; Mon, 22 Jul 2024
 22:33:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 22:33:03 -0700
In-Reply-To: <0000000000004b841a060e876595@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbdb25061de37eda@google.com>
Subject: Re: [syzbot] [input?] [usb?] WARNING in input_unregister_device (2)
From: syzbot <syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, eadavis@qq.com, gregkh@linuxfoundation.org, 
	jandryuk@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, peter.hutterer@who-t.net, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 0774d19038c496f0c3602fb505c43e1b2d8eed85
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon Apr 29 21:50:41 2024 +0000

    Input: try trimming too long modalias strings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c0adc3980000
start commit:   1c892cdd8fe0 Merge tag 'vfs-6.8-rc6.fixes' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=617f4ccb03b9869f6494
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17985b34180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d8d43c180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Input: try trimming too long modalias strings

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

