Return-Path: <linux-kernel+bounces-394343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D372B9BADA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDDB281F39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3541AB530;
	Mon,  4 Nov 2024 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORVKwUYq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20D1A7AF1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707512; cv=none; b=ah8Ok/aB5YzHzwPj+km8xQz09uoHiAm8VzFNYcQXoflK2VS7AEMZDcqSZwgvIDBxQ1U/kpM/CKGdruTwkycq69u96EvSd7oKFUXoIplNtZvbp7PHzqh6buYmHAv65P3spVSZrKhhX/DvleQRgWWx8eCY2vETKu5QV2Fs73nfrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707512; c=relaxed/simple;
	bh=wIth8q+oiY1s7f4175bP4VdisldBLxMivwg/wJA5TVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErQmeXeQ7HnFOlWNKEheUfmJBPIvuGG/sVqHKC2iWq3yOXBkJhhZvC87T81l4eI2Lk39InjZmsFUSON0OCrEtOaE09dNzBR7UbYA8r2xdDOUf2AsoWj8PbE1WBwnOwKR+PszllqhylBHqgq8hGerWVtMsP//QQgXGbCQ0Oa6OE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORVKwUYq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so31840075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730707509; x=1731312309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmjx6zA4K8y+qr1LBwquRLGW8I8RIiLSEH4MjF5V3eU=;
        b=ORVKwUYqxG3UKZL/4ppvxGxNFSX7jFFH81TvCiDnQCBvIfYXvdk8bx3ZNie2AWi+/z
         znGZUL+6uCzzrW/RgRQaELAaI1hJSS+Wh80pOPj2beVhQGxcOb7G6n1i6qC5XpPMIrcL
         /7wiMfTQYrAyuakipEPhCns+a6XUEyMehFeM9x3mhlzceFVaNmSdnj7ymiZ8zGwzNNda
         cbdkF7e8ewZpIfKWXqwF1XRFFOP0gjv+pn1othg5ShwNebKeoEwcDIL+8m9YuMk5Ttvs
         exPYPxoE4DgHJd3W9Flp5dER+HB0S0D9UyIt+/seigtkw/JiHIlyZdAY0z03W/7HEWQ7
         60Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730707509; x=1731312309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmjx6zA4K8y+qr1LBwquRLGW8I8RIiLSEH4MjF5V3eU=;
        b=Bh1iGsOdSYe+CBxxNjLp5mArsrHO8aboOhX9qWmHbSZh2aLjhQMJpPJVsV+uPnuhXK
         kWcEv3PQ1Or/bPtmzo2w4q+LgdbR/ioLsSGbiA06kewRVKbc+TyM8kqrGMkAzwSGZD3E
         1Yc0SvgsQJqyM4dj6JU5gTB7405AeJh3F/Akb1UeUVn4a6HdsJ7xDGax7DEZICHm3WwT
         46HZIJy43pSTZ0FaC+TPTmaKt9rtSKAfZqqQMheotKFCwxp6D42HQEOMjIM7GbMqBCBl
         MD2Rysar83i3T6bpgCqc1q0t0vw9muhOEjzCJ1ECNDaEQV91qVE00iIhK5F0MO0NzyUo
         BRqg==
X-Forwarded-Encrypted: i=1; AJvYcCXo9NY627Yuxyyy59tAc7aq6UQQXD1t+jYniBvFGIrJ4pHuyou3jx624Iaq+50q8EfoFfKfzRabE4IkP04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIayD2r9Cxi3gWUYBWmuZyTm5hc+iox6Nqpcodx2pQhcOMKkF
	dLhbpLV6Ho0Czxouuz1Zgjs4ujsXbPdKekxov9OF0DnFNpP+hqeb
X-Google-Smtp-Source: AGHT+IGJZ1N0iKEAhj3LObQcIfZjoje2HIVVrTvS8omAzjtiJyXmwbcvyD/6ltNJYT44sT96drjLmQ==
X-Received: by 2002:a5d:4d48:0:b0:37d:49d1:1e89 with SMTP id ffacd0b85a97d-3806115ab56mr23099545f8f.27.1730707508506;
        Mon, 04 Nov 2024 00:05:08 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:58c3:98c7:13bb:aad2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d414csm12396504f8f.26.2024.11.04.00.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:05:07 -0800 (PST)
Date: Mon, 4 Nov 2024 09:05:06 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Shawn Guo <shawnguo2@yeah.net>, linux@armlinux.org.uk,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, elinor.montmasson@savoirfairelinux.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Message-ID: <ZyiAMpjmXuVMi5FX@eichest-laptop>
References: <20241030122128.115000-1-eichest@gmail.com>
 <ZyXTFhEm9UCBii2c@dragon>
 <ZyY41nJY9ghwe-Y4@eichest-laptop>
 <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net>

Hi Stefan,

On Sat, Nov 02, 2024 at 04:35:19PM +0100, Stefan Wahren wrote:
> Hi Stefan,
> 
> Am 02.11.24 um 15:36 schrieb Stefan Eichenberger:
> > Hi Shawn,
> > 
> > On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
> > > On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > 
> > > > Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. This
> > > > change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sound
> > > > card node properties") which moves away from the old "spdif-controller"
> > > > property to the new "audio-codec" property.
> > > > 
> > > > Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node properties")
> > > It doesn't look a fix to me.
> > I agree somehow, it was just that before the referenced commit our test
> > succeeds with the imx_v6_v7_defconfig and after that we get the
> > following error:
> > [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card: snd_soc_register_card failed
> this error should have been in the commit message including the
> information which platform/board is affected.

Okay, I will add this information to the next version. We see this error
on an Apalis iMX6 which has in my variant an NXP i.MX6Q SoC.

> > So maybe it is not a fix in the sense of a bug, but it fixes the error
> > message. However, I'm also fine with removing the Fixes tag.
> But this patch doesn't look like the real approach.
> 
> Could you please clarify the impact of the regression?

So the problem is that before commit d469b771afe1 ("ARM: dts: imx6:
update spdif sound card node properties") the audio driver was
using an implementation of linux,spdif-dit and linux,spdif-dir which was
directly inside the fsl,imx-audio-spdif compatible driver. Now with the
referenced commit the idea is to use the more generic linux,spdif-dir
and linux,spdif-dit compatible drivers. That's why this driver must be
enabled in the kernel configuration.

> Is it just this error message and audio works fine or is audio also broken?

It is not just the error message, audio is not working because the
driver deferes and because it is not enabled it will never succeed to
load. I don't know if this is called a regression, because the driver is
there it is just not enabled in the imx6_v7_defconfig. I thought because
a lot of the i.MX6 based board use the generic driver, it makes sense to
enable it in the imx_v6_v7_defconfig.

Here the output of git stat to show which boards are most likely showing
the same behavior as the Apalis iMX6 with the current
imx_v6_v7_defconfig:
git show d469b771afe1 --stat
....
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts          | 15 ++++++++++++---
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts          | 15 ++++++++++++---
 arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts         |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi       | 15 ++++++++++++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apf6dev.dtsi      |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi      | 15 ++++++++++++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi      |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi    |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-wandboard.dtsi    |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6sx-sabreauto.dts      |  9 +++++++--
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi           |  9 +++++++--

Regards,
Stefan

