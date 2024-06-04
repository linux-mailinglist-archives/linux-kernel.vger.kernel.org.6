Return-Path: <linux-kernel+bounces-200665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E98FB31E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C4C1C243C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C79146010;
	Tue,  4 Jun 2024 13:04:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90AE145B27
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506247; cv=none; b=SUOHCQJAXarCipr2y3D1h4X/VrfO9qXxQM9dCKaeaUSrpip+hKUInvRnswrZXPJtStFkGAPK9SCRnbGoo/FxD1VSaBOqLCk26Xt+PhKKlLclnjZNW51FYqcKpBbRfB+I3kkBUU+5X15cuh2PHGvSHoYchjp6pZZdLP4b2zNox60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506247; c=relaxed/simple;
	bh=T82aw7Fpj21f88lzPdno3fpEjbQRYfFzL+k+rLk0xiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uNwVNYvXgT6iYZ1aJFZN5tTO/hB07YlV67fEZ7fwDvlDbw5ka4jzRRiAFtre8wes2vQ08oa1bzQEjeBPe0sT/PZiQ3sqSjtE0yezwPoebg4hrUTFNCRtFIJFGbC/mZuZg6/Pu4W0O4UPve1zYdNsENAQdUJWhfXc0isdzxKgOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37481e2793eso41325795ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506245; x=1718111045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nw/tThhWCHkHloMeX9fThExXMhZwmGS7k7p/KTeKvYw=;
        b=cYGbdVTl8Nd5jHjNTGMeED38rbD97pxIiPcF7gMIgjz7gXP225YCFMKP1fHENiNdlL
         EhPow26BWKr/YwdPbG5LQVBFVOnT22rmHy7Wn+Mf/cnIGRfgZe0L4gNBFHJXVDSVbefM
         q6/tUcHcrTkveOeWJOEzSEXAlP/b0KXYi2h941iTfRDeE7qAgtZYGFpPYazFPDSme16a
         QO7sZ6SDBghun8vhARdo6dT8eDhndIYodVXRSv3bQuCHjOjldsU9SZP/b1Ey1xfSEXYg
         wV3TG++dH//jPXt/Z3RoL9NrfnQsyaAzubnKshi956hoHS9d0pQe7zca/cZ2nYzWSRyS
         GtZg==
X-Forwarded-Encrypted: i=1; AJvYcCWxZWoOxr3gxwo98LHdrERjXO73px4AJyRqV8hCP+NOdsC7Yc8+QK4hbB9bUeHHD10uqE3RWtyLysRGBW2QYL/IWby8Tnq7N0blQPqJ
X-Gm-Message-State: AOJu0YwkEVHgFJY+xImhYiRM4vEky/n/pNL+4wJnbMJ1Dn6T6+x9bexz
	stKCHKxBLB4ErIduOKA9x54gRrCb6rBqDV5b6ZwCgiud5d4qrCk88Zw8Z3Z1aukQalxsuQUmasR
	H6jJTsikvhjf+pCiCVZEFC7vgz08EQsKw0syM93p98fQAvH5LR3i2D1w=
X-Google-Smtp-Source: AGHT+IHKWmn40BeYhgMpDyeFHftsrJuJM990+N+AT+ehS/LyH+++SAfGjXFq45B2WUbLAY3ZcKC0n6XDK/+WLKiz3pD91u2wzbIJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:374:9305:62be with SMTP id
 e9e14a558f8ab-374a850a1fcmr1526135ab.2.1717506245110; Tue, 04 Jun 2024
 06:04:05 -0700 (PDT)
Date: Tue, 04 Jun 2024 06:04:05 -0700
In-Reply-To: <20240604123656.1730-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3bf64061a101538@google.com>
Subject: Re: [syzbot] [mm?] kernel panic: corrupted stack end in userfaultfd_ioctl
From: syzbot <syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com

Tested on:

commit:         2ab79514 Merge tag 'cxl-fixes-6.10-rc3' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=108249bc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48aeb395bedeb71f
dashboard link: https://syzkaller.appspot.com/bug?extid=5a1cb2c00e895afca87e
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d60c26980000

Note: testing is done by a robot and is best-effort only.

