Return-Path: <linux-kernel+bounces-324681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE97974FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343E31F25E05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DB184547;
	Wed, 11 Sep 2024 10:24:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7E155346
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050245; cv=none; b=tKsFq3qFWJdEwTZuaqROpM3yJQuF5wRwhm6JCwJq9QY8s+rUnaFu+5BPF0BtMNIFFAbDPOGEHDJid08trcB9+rPOvFlhHHav79/7nyQfYgOj/Gx3dzlR93KZEzR8InHU2/slP2dlfNEOdAbmc1G+KoEaVw8JIKABX5VTeyfEkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050245; c=relaxed/simple;
	bh=elWmyrfEPqOWHHLW9xNi8OLZz3TCLz9AFxFanA/QUgc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e/pqcIlJiLa1Wg/A6ReAUvMJ4YkcJi5B8RTpM1XzYP00nBa7VtTQXRS9vFpwT8eV2EVCjM8vvFX0MHBqZ2S56uiULPPf1PoYwHBjMplQRW2coya2qz9UADwDf2wIeyZQOT/14JAXufUjUFy25XWeGY7Soyy+n9MGc7Wb8AYqDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso124924715ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050243; x=1726655043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZj1nmLjRC8rxV4FOa514/Nx5PJwrr332NZgUdsfOjM=;
        b=w33U2v+ryqI4QI2xKlMiyxW5QKqwkfh3MnhE0rmOwrl5Fvery20/z7ruXQ3r7Gt2cC
         g7+YNg5qj/LDyRAHUiaf+w6PnZ5bsp4VvP3q9yLKrskP5S3fTm16wwg8aj4u0IEv6urK
         M8VSh8TcXdO4kd0sUI7UrYDrDhB4neCjS0cVqAmFZeK7ey/42gPUavXDkCsAGxwd5FFK
         Hb2ufz/opRlKW/TNc4rh3lEzFEAgxX3KsXj8PxUZLuVV89qEWdLva49VBTl7/yNv2RJN
         i7Q1XM7iq/HHw1nU3fMF2ANY7pDS4C7pI6jb+0pCqu0O4ty5TdZBB1rCUQGPXfjuh5mB
         w/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUR8Zf0AZrksC0mixx5i1dTBTE1Sfn6nPoZRRW0aQ8asgxqQcQ7ROfDPgGKAdsRf/GALgp0WeCXNjLxTpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYqr/jDDAh+AP2KZyxkf1diXj1Kxbf2CBqvnxwoMmpvZh/mZt
	0GLuxYR8VVzUXSwqaP00qzhXTMeRD+FvGBhzHI63zxNo54AGCYi8tiQiUy3TQfkXFPBQtMR5fbv
	L4syUGDKxFiI8SUj5a36ICkSX+id4nK/Z2K3KPjQawbqQy0dDL8p7SME=
X-Google-Smtp-Source: AGHT+IEUC8FU14ZHBadiR4HCI/EChMbCfgkzq821/gR9wEJWx4zgycmGP0vo3c72UbwP23TQHIWYL/E8yUY2p1f9JQzUE0TT1Z2W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216d:b0:398:16d1:610b with SMTP id
 e9e14a558f8ab-3a04efebf08mr228750875ab.0.1726050242948; Wed, 11 Sep 2024
 03:24:02 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:24:02 -0700
In-Reply-To: <818d52f9-d557-45b5-9711-a672ea7c7bf1@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000987ee40621d5630b@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc_inet.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7e3e2c7f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e16100580000


