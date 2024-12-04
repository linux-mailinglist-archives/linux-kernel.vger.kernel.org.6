Return-Path: <linux-kernel+bounces-431455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A99E3DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0707FB44BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2420C022;
	Wed,  4 Dec 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVAS6+BA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2C20C00F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324411; cv=none; b=OH/F2AY1CllHnBOkXBPjdcoGqiz+kLdO4ai6cSHU64OiFCi+mEG5f0CHf9/t8AXF630zv9iNuAR7f4J8FVWHcluqN3Y4OQRAbSMj9Q3oz1jgOUwL2g7oPoVxUlhsCyI8pFAxfRwOoS5ILETcsW7uVdtf3CIkrZB5ojhvjHrku7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324411; c=relaxed/simple;
	bh=OmedF/kc7VLNX4vobufGbdHgkXfgzLJYRlZwn32nfxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT0BBn8EkIPOb/16rjRAWmZYWf1xGmL+9QfI0hkJDWo7u6MylAX4TAoSFuq/qsHDkMmm7p/GX20EyPUqj0C+e0tlNzFl+XS02wtZMRgRi2iF76I6IgZBGfmp8rR8JPNpt7KYoOVL3GR2nfiRRmofJ/54tMVZf8aXVK5rG1kPzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVAS6+BA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de880c77eso8120988e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733324407; x=1733929207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z8SsfJIMZ6wbDGLFC2pyak5YjkCzmlnT64gSuKBGIU=;
        b=lVAS6+BAl7rFA2dNyAbmuc5Uv3LmVbxQHtM3QlXDHXoiuJTrjpd9ZMtYq1g4JhUyfa
         ICc8ugknVovRuM+0u4hb12DZ88oqEfK5OkeC2wI69wbMPbEt2K4mV00yjO+DQXq+G49T
         43diXNHGUvrVpsrJ32im/fmxwVAoLMzuyW/lo2wDgndNN1EUgFKR8iLe7QAM+qC/s+7W
         SHPdGv9Ub7lKEI0URj6LFkjSvXyrgWJiwBLkfuWzkE1szPRwFW1oRZ6/kROgovrj6OPe
         vC8C9tQaTnCFqbjWlwhp6jr5F2L1uHX+SBVjp2QyCyAtVapvJsNDM+VudbqHGuLv8xJO
         beVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324407; x=1733929207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z8SsfJIMZ6wbDGLFC2pyak5YjkCzmlnT64gSuKBGIU=;
        b=Kltf5xWbj05UtCgiOTbetEiEnVPC2T5ZcLaB4c/+G3BY03zZvx8z9F6KKLqGkdGxu6
         CLYoW30qMlaVn5oOC9XAAhzVYdm/cDTSu2e/UopW9s9Sxj/iTru7cfEI/2cjRqzilrNN
         9DVhHkF/aKqiQlDZIIXGCH5792DKwStvChM7E4oMUMC+jz6scXbH3/QnZVOW5gnr5CvU
         QtYX8Q0vrc5ToZORJug8gtG/+LjF11gXNSuDKDkCEJ8OAKJ+QRiwx50QdX3N/5YNW1F3
         H7qdKjilkCMZIAmwhT2n4NqCeJvcdJE9AK6NOeiZXLEpkrZL9kNOTGSz61dU2rL5LIen
         zFHg==
X-Forwarded-Encrypted: i=1; AJvYcCW4RcrT5MD2C9Wws+0MNOqjB/TmtpB1r3dAsq/R+56lgdhvbTuvvYufkRYohEDC+GHxks1xRswHJJUZ3PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6GQXY3SKmuQeX2E4OnmmmkpBQcFmxltcKQHyrcronk9b5Q++
	SFIxMSSzEbec5I3cK6mmCTRVW8xwl1OjfomlXCpku0+2Kgoy/F45MOfBMsVvkcyMI/oRDVCEm4z
	H5eejgNZ6upDrSgIkXN0qmOGLhWg5yDjb9l1m5rMrk6M+mepFBgw=
X-Gm-Gg: ASbGncsXavNuLB3P1efeIiTfIV4f4p3cuR9YsxyiN6vcCsgHBy8sURBwlBm5XF3r/A+
	R+Qfjvez3mNADfcFJHVqlIzb3INw1PA==
X-Google-Smtp-Source: AGHT+IHT8ot8EDFntaLIs72pipJWUq+cKx2vj1L2uGRfDd/p23/CZ604435wdZoBy3VHdRA1oxNIm06ieh8Uc9hFCWQ=
X-Received: by 2002:a05:6512:31d4:b0:53d:e57e:dd4a with SMTP id
 2adb3069b0e04-53e129f2a38mr4263497e87.22.1733324406989; Wed, 04 Dec 2024
 07:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203083838.3260036-1-jvetter@outer-limits.org> <609b026d-d54c-4a11-b7df-6ef0ac315f25@app.fastmail.com>
In-Reply-To: <609b026d-d54c-4a11-b7df-6ef0ac315f25@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:59:56 +0100
Message-ID: <CACRpkdZZ0vrYT1-76SBa0XN00p33sRTmpT1JPLjvBuyGD_yu0Q@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove IO memcpy for Big-Endian
To: Arnd Bergmann <arnd@arndb.de>
Cc: Julian Vetter <jvetter@outer-limits.org>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Julian Vetter <julian@outer-limits.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 11:08=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:

> - There is one ARMv5 "BE32" based platform, the ixp4xx, which
>   works differently, and this in turn allows multiple configurations
>   for its buses where a byte-swap is performed in the PCI
>   controller.

Actually it affects all memory-mapped I/O. E.g.
drivers/irqchip/irq-ixp4xx.c
for this reason IXP4xx drivers that are not PCI usually
use __raw_readl() and __raw_writel() to let the bus
do its thing.

IXP4xx PCI drivers are however *not* doing this, because
PCI is (IIUC) specified to be little-endian, and the hardware
deals with this. (Except for the PCI host driver itself, using
__raw accesses.)

> Before we apply your patch, I think the minimum would be to
> have Linus Walleij try it out on an an ixp4xx with a driver
> that uses these functions.

I applied the patch, compiled v6.13-rc1 HEAD for the
Linksys NSLU2 (oldest system there is! also a classic!)

+ Boots cleanly
+ Mounts root - this is on a USB drive which is on a
   PCI-attached USB controller, so PCI is tested
+ Reaches userspace and console
+ Gets network and IP address
+ LuCI web user inteface works (browsed to web server on device)
+ Dropbear SSH login works fine

Tested-by: Linus Walleij <linus.walleij@linaro.org>

I doubt any IXP4xx driver uses ioread/iowrite. The
MTD driver does not for example, because of other weirdness
with address swizzling (drivers/mtd/maps/physmap-ixp4xx.c)
For similar reasons drivers/ata/pata_ixp4xx_cf.c is
using readw/writew exclusively.

It also looks like a good idea:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Your,
Linus Walleij

