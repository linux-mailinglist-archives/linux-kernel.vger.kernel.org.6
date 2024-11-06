Return-Path: <linux-kernel+bounces-398070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0EC9BE4D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8315A1C23205
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4781DED43;
	Wed,  6 Nov 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwcm+uPU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C11DE8BE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890330; cv=none; b=bgjx6W/lfqdoY1em4ALmj7Ya/yKT2bweIzL5V168YZM1aK1IkyO275zKVGSGu1ev8a0WlJtYMmfOq9v8bKVYs+mjCYJJEF/rWeDRWGog8WuwK8oDvpB6Zw7aaKEzbDpnkaEdbPoPLsTI8DF3VH/juWm+CZEfKP0ojQ6DcLbv4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890330; c=relaxed/simple;
	bh=u7AyQyTK1zEqP2xPv9JHBaVJ0O7ciFV8N45QHJ28EPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5TqqZxMv5cxlexGz5hv0JUvzHNJk5OKas++yjGwFxgPSFajdb7D5KU+xzAj9IlbCpz6aCQjRqJpUj32T33uyS3FZFsnKWic4cP9vWAt3k+PSp0Wes5cORRDrUGSEvHpiDaDNihfJTUZjqzsUnsbCfiaYnaTZcse2u1dkezP40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwcm+uPU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43158625112so57543585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730890327; x=1731495127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCxSEzKgL1zH2eyIUhadinz5mEtbswOhMWKsLzQ9Pjw=;
        b=Cwcm+uPULM2Ebeq37s1XoYJhpXKhUgIUWIcHGU1m7HJTyku2EKoE856BsR7rJHPvFw
         hCmBLwvlkE7Q6/YaxmdTeSn4UUFzWVNtZ8z348jZ/osKtBOYzFKnMRcyXTA5LAfjDTXU
         GtuM4l988b5pl9dK0IglZPCfA5gLsfDqMWIKGOcrsyWAvI2AMEpuWPvqBh3lMM2sZT9D
         N0/Y5YYsQOKvNnyU0BmXUH7/MpkO3w5XO5w5dpmnIBL9C+miAdgd0fYUNtOgYFRas+Qr
         dT5xw3F+Dw7b5yroxzJwiybI/UU275/Kd9bnOZ8M3WqKUs9GZ9jCeNvgVRLId4i2XaHL
         irRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890327; x=1731495127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCxSEzKgL1zH2eyIUhadinz5mEtbswOhMWKsLzQ9Pjw=;
        b=bVtpCCLkqOwMMrsuaBhOk7qlwWKJjzP/Kkw2Qdp0UzjhopE6UK3/hQHthFWJTb1viM
         73N8VeHa8rN6jA1L5A5vpb+R1ptd/OZ4mlJZR1FKHBmNutFyPbgkJChWqpWpFroTcNjF
         +TwKyvRyNLqKhp4evU62ZOwPYzQBnT+Bk568lqocg/tSiRJQjuBTjNxEgC1G3KWSu7hK
         +/sb9xRnPyrhXi62y3YxSbduoOTlthDRLfJt7lFes1W3pLm3U2YITMFXcOk15DynoF9k
         wFO3Ryq0idxn9jCGvEG9i0CEXajQCepzTgua0PasudnnpPVqe9Jd0Zya6N7Toce/J6TS
         Xdsw==
X-Forwarded-Encrypted: i=1; AJvYcCXhON9jZeDSrKk2JSng2FyoRM4RNB3i6Vb2rziEVOaQLNoeBfOKtUizPUPx6EY1euciPVtv0dJwf6UYT7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKBjeK8eyPiKZWvpMiEIsniHO9ao+lMismruASuFvSW8czSP5
	2JpmohCSIxc2oEdBZoT3nFNH+ai6zTZWK00jTz7tfE29a/11KPpB
X-Google-Smtp-Source: AGHT+IHg4XTEew3l0kqPf+Gkb9KGrdyLxo/QnI5GgVlIsaFloaF/eSsiXGJtzKZ1/slEJ0FlL44QOw==
X-Received: by 2002:a05:600c:5493:b0:431:5533:8f0c with SMTP id 5b1f17b1804b1-43285649fe6mr151529565e9.29.1730890326572;
        Wed, 06 Nov 2024 02:52:06 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:e6de:f900:d54a:ec1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e073sm18676391f8f.66.2024.11.06.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:52:06 -0800 (PST)
Date: Wed, 6 Nov 2024 11:52:04 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
	Shawn Guo <shawnguo2@yeah.net>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	imx <imx@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] ARM: imx_v6_v7_defconfig: enable SND_SOC_SPDIF
Message-ID: <ZytKVAQzaMKd3w1o@eichest-laptop>
References: <20241030122128.115000-1-eichest@gmail.com>
 <ZyXTFhEm9UCBii2c@dragon>
 <ZyY41nJY9ghwe-Y4@eichest-laptop>
 <065268d6-84eb-4247-b834-40a9ff32c1f4@gmx.net>
 <ZyiAMpjmXuVMi5FX@eichest-laptop>
 <787b45a1-9f8d-493d-8930-e1c8d396c818@gmx.net>
 <Zyj0VsTJ2qDHiss2@eichest-laptop>
 <1044800423.57572.1730815098440.JavaMail.zimbra@savoirfairelinux.com>
 <283bbd2c-0997-43d6-bc24-08bf2cb2412b@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283bbd2c-0997-43d6-bc24-08bf2cb2412b@gmx.net>

On Tue, Nov 05, 2024 at 04:52:04PM +0100, Stefan Wahren wrote:
> Am 05.11.24 um 14:58 schrieb Elinor Montmasson:
> > Hi Stefan,
> > 
> > On Monday, 4 November, 2024 17:20:38, Stefan Eichenberger wrote:
> > > Hi Stefan,
> > > 
> > > On Mon, Nov 04, 2024 at 12:39:40PM +0100, Stefan Wahren wrote:
> > > > Hi Stefan,
> > > > 
> > > > Am 04.11.24 um 09:05 schrieb Stefan Eichenberger:
> > > > > Hi Stefan,
> > > > > 
> > > > > On Sat, Nov 02, 2024 at 04:35:19PM +0100, Stefan Wahren wrote:
> > > > > > Hi Stefan,
> > > > > > 
> > > > > > Am 02.11.24 um 15:36 schrieb Stefan Eichenberger:
> > > > > > > Hi Shawn,
> > > > > > > 
> > > > > > > On Sat, Nov 02, 2024 at 03:21:58PM +0800, Shawn Guo wrote:
> > > > > > > > On Wed, Oct 30, 2024 at 01:21:12PM +0100, Stefan Eichenberger wrote:
> > > > > > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > > > > > 
> > > > > > > > > Enable SND_SOC_SPDIF in imx_v6_v7_defconfig to support SPDIF audio. This
> > > > > > > > > change will fix commit d469b771afe1 ("ARM: dts: imx6: update spdif sound
> > > > > > > > > card node properties") which moves away from the old "spdif-controller"
> > > > > > > > > property to the new "audio-codec" property.
> > > > > > > > > 
> > > > > > > > > Fixes: d469b771afe1 ("ARM: dts: imx6: update spdif sound card node properties")
> > > > > > > > It doesn't look a fix to me.
> > > > > > > I agree somehow, it was just that before the referenced commit our test
> > > > > > > succeeds with the imx_v6_v7_defconfig and after that we get the
> > > > > > > following error:
> > > > > > > [   24.165534] platform sound-spdif: deferred probe pending: fsl-asoc-card:
> > > > > > > snd_soc_register_card failed
> > > > > > this error should have been in the commit message including the
> > > > > > information which platform/board is affected.
> > > > > Okay, I will add this information to the next version. We see this error
> > > > > on an Apalis iMX6 which has in my variant an NXP i.MX6Q SoC.
> > > > > 
> > > > > > > So maybe it is not a fix in the sense of a bug, but it fixes the error
> > > > > > > message. However, I'm also fine with removing the Fixes tag.
> > > > > > But this patch doesn't look like the real approach.
> > > > > > 
> > > > > > Could you please clarify the impact of the regression?
> > > > > So the problem is that before commit d469b771afe1 ("ARM: dts: imx6:
> > > > > update spdif sound card node properties") the audio driver was
> > > > > using an implementation of linux,spdif-dit and linux,spdif-dir which was
> > > > > directly inside the fsl,imx-audio-spdif compatible driver. Now with the
> > > > > referenced commit the idea is to use the more generic linux,spdif-dir
> > > > > and linux,spdif-dit compatible drivers. That's why this driver must be
> > > > > enabled in the kernel configuration.
> > > > > 
> > > > > > Is it just this error message and audio works fine or is audio also broken?
> > > > > It is not just the error message, audio is not working because the
> > > > > driver deferes and because it is not enabled it will never succeed to
> > > > > load. I don't know if this is called a regression, because the driver is
> > > > > there it is just not enabled in the imx6_v7_defconfig. I thought because
> > > > > a lot of the i.MX6 based board use the generic driver, it makes sense to
> > > > > enable it in the imx_v6_v7_defconfig.
> > > > okay, thanks for the clarification. From my understanding
> > > > imx6_v7_defconfig is just an example config for testing. All possible
> > > > users of these boards might have their own configs and stumble across
> > > > the same issue. So I thought it would be better to add the dependency in
> > > > the Kconfig of the FSL audio driver.
> > > > 
> > > > I'm not that audio driver expert and don't know how the dependency
> > > > handling between the FSL audio driver and the required codecs like
> > > > SND_SOC_SPDIF. So it's possible that I'm completely wrong here and your
> > > > approach is the best we can do.
> > > That might be a good point. I don't know how this is usually handled.
> > > @Shawn and @Elinor, do you think this could be an approach to make
> > > SND_SOC_FSL_ASOC_CARD select SND_SOC_SPDIF? It already seems to do this
> > > for SND_SOC_WM8994 and SND_SOC_FSL_SPDIF.
> > SND_SOC_FSL_ASOC_CARD will compile the machine driver fsl-asoc-card,
> > SND_SOC_FSL_SPDIF the CPU DAI driver fsl_spdif for the SPDIF
> > and SND_SOC_SPDIF the codec drivers spdif-rx and spdif-tx.
> > 
> > In my commit series I made SND_SOC_FSL_ASOC_CARD select SND_SOC_FSL_SPDIF
> > because the old machine driver previously compiled with SND_SOC_IMX_SPDIF
> > selected SND_SOC_FSL_SPDIF.
> > But because fsl-asoc-card is a generic driver, it could be used on a system
> > that doesn't have an SPDIF device, and therefore should not require
> > SND_SOC_SPDIF nor SND_SOC_FSL_SPDIF.
> > So maybe it is not a good idea to automatically select SND_SOC_FSL_SPDIF or SND_SOC_SPDIF.
> > 
> > On the other hand, if every imx6 or imx7 boards have an SPDIF device, then
> > I suppose SND_SOC_SPDIF can be put in imx_v6_v7_defconfig.
> Okay, I'm fine with the original approach.

Perfect thanks, then I will improve the commit message and send a v2.

Regards,
Stefan

