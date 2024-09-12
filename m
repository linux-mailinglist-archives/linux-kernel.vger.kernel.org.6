Return-Path: <linux-kernel+bounces-326889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C0976E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D52B216EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D861A2876;
	Thu, 12 Sep 2024 15:47:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E67C144
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156025; cv=none; b=g9z8f16bQPS9haE/gtttZSictEmGv6wrYOeczqGNu2jEkx8RFkDUBNNeLCaooG4APCjhDkiFSzaNwKCS+icfEVmfcdCqO/T5hYqVkJrq1FoZl3dL1C1Oa39d7bjsm9dlfJ9VVE5AqLLgrBKEXk5fTaVf/U/yizQ8yWXsS2wxHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156025; c=relaxed/simple;
	bh=du7iGjmF0Upo7ebcwdH5GIv0ih/U1/o7XJCooqYKjsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=frVgrEj4lUaVgHBPkSNMiwCU7qFZBaFp+E4neetnHI+coHC+FVBwL+hsID6L9f4h2eJwjk9gyP5M1BPw7k8YdgPTbzm0WMx9+q73HGiDdp1CDZNZH7dMkjogw8yxWzmV72QEJifNTBfD4gxak9OYtm2IzOH3+2DrZfbCumeHooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0539a446dso15474975ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156023; x=1726760823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2iY4kfQ0pcNAE2g2icTQK1gdVPAhfM8REbk4rhp2xw=;
        b=jfjWi+20l62uuD9+q50ziDhk8uW+a+A4JuRBr9NoFf8gMGiK89yH4xEGVKb3+5n6t3
         4JaD9Cr66H/MTPbwi6uLEqakgUqxXSYv3DiRNdO4t85VWHv6tGFxHTf+mB6BpnhXymGq
         wMZur1aWKZhZJA+G9pSxiXz/8jWBH2N7ZFxQ+GhvWmoETYOy0RrrqkHhYIRf3DQLr9Cg
         VzxVFpSgmWP6s5sfutZqqgAT9eV+Ia04YBTLaAipMwQcRg6OBm1XDPWrnnTnT4RqY63D
         /ds20dSZI24Rg9xWoobOPKYidT1TnjsK+kxgsSbgDI4Fvz+pA8Gf4g/APLVDhmJBL9F9
         bM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxskL0lMT3x6uhTROUVRXm6CM8w/ZGSoqOu2V4zJ+HOHd2vdLM8JRhSygyae7uR0tyufmaavImVdzCVrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cNsMY/eAuqYGSNUQdio0tXPWfAYG7hg/XvS8zkBBjpsB5WRS
	lWTn28IlXCAV6EJuLWFotiKg2ppW9nbs07iNjHvgQOGS0VKNZsc+uShYU3vSzhyYE/uTgaQ7Q7r
	ZZWZ0UHU62wLnP1wWbd24dwEBMqWpAw5Q7iwM8VTfLIOpBYSLrNLUTcM=
X-Google-Smtp-Source: AGHT+IFaoNcfm7xMMkVx4ORuHztMXbe0SfdqhpN511Kpywl9ZR92LpdpDuSFWInyxeeV3n469lAN3ml2rCLpBNZ9cNz7RC9x/g6s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e03:b0:39f:d10e:55e0 with SMTP id
 e9e14a558f8ab-3a084958dfdmr31875815ab.19.1726156023545; Thu, 12 Sep 2024
 08:47:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 08:47:03 -0700
In-Reply-To: <20240912142145.8418-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c4e3e0621ee0434@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
From: syzbot <syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Tested-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com

Tested on:

commit:         77f58789 Merge tag 'arm-fixes-6.11-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158460a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
dashboard link: https://syzkaller.appspot.com/bug?extid=b8080cbc8d286a5fa23a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ff6797980000

Note: testing is done by a robot and is best-effort only.

