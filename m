Return-Path: <linux-kernel+bounces-257762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9B937E93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612561C21360
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A61523D;
	Sat, 20 Jul 2024 01:10:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF418F44
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721437804; cv=none; b=esEKJwoErLRlBnFKpAWapIflG5w04q20CrjPfBOgIkVSqah3ziounZTRp5+IzeWEfBfth5DsGnpkEox+AbirFeDiMtVnLslOcltlnlAujNSDrYYIp1+C/N/fiYxbMa5WdJpe2hlBMKXSxaY+dEPYdLv5JHFYVsgtXneAEg6R/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721437804; c=relaxed/simple;
	bh=UX3eDEBF1HDYmxDewJkblwQtFyE2LWxmOoe6/JWWBn0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l6hHLKMDEsT1zHm2Kg5oHrwhcFeUJSLottvL+s8lpO6nivslgQAwnvHjc7OdLVRzBXfM+iP3a9lF9diBA6HFpwZwvQjPm85oQhUMtNVpgXzsgwkJVTKI3pZne0tH+uXoir8PzWcLZlA7V0Jb56rx9+BdCMyTLBp8MlUO+LpENUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39642f5482eso32457725ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721437802; x=1722042602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7xcq0cU5b4LgYfk9M080gIhfi4XtY6sseXnSbkcfUU=;
        b=THUZEYZ3dziEbg3PltQ80X7WAoQwkSsCfZc1AmaW88uGIDaiKjk/pMZRprVwVK4i6o
         jUgZ8pZfJ3FYWfTHXLyGNzkC4wFFxd7vNGC7YQpsFP7qTT2UO2weO2VqkGKbIKhylVQz
         ftLu6+wl/9mjI818A1+fssUWCRg/PzqBYSiAtTBaBYTCrEfGuF+Qgc0uN3WAyfhYnfrY
         nBoWzNZ2CeWwr2LsPvgCnF2e+aN7+E3Sw1bW5V2KaewrCWkBcvR/C1phSk10PlQIF3rn
         ouadRWl2Iyvd9vS3XGIu/5mVTyttgd9/wfH+g70egJuVR2ACwkwdajx0XdAk5Rjj9DuR
         Fh5g==
X-Gm-Message-State: AOJu0YzLyNdjBDLr0iDQg+QE4PzaKyj0Tgjgc3nFTnqnstCQtnBZeE/X
	lZ0Jley7qO+fIbOdQ21ombSviqM+6Z15psKWa9LNphVIfyF453ZsJmkDu5njitPW/GC28yr2VC6
	WfHqIuANNitjD9VZEi3Sp7t/gkWHk6z+DC+sMjzbtvHFK8wl6iOboUkk=
X-Google-Smtp-Source: AGHT+IFvRueDzK3W7Ykjt4vWjXHjwMAngasZ+LxAYnyCOStOn6Q+As1KG46x78t6yjGVAQ86rnwUnSbveTkAenXmNGeZarGcu5sO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:395:fa9a:3187 with SMTP id
 e9e14a558f8ab-398ee03ea4bmr876045ab.3.1721437801824; Fri, 19 Jul 2024
 18:10:01 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:10:01 -0700
In-Reply-To: <e47662b096f45fbdfa3e6ad9959bfb2bf3148bc4.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae50ee061da3785b@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_delete_cat
From: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, simeddon@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Tested-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com

Tested on:

commit:         8e5c0abf Merge tag 'input-for-v6.11-rc0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c10195980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bdc5cf430cf80c7
dashboard link: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d0a8b1980000

Note: testing is done by a robot and is best-effort only.

