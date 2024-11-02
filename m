Return-Path: <linux-kernel+bounces-393449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04E9BA0CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC052825CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E019CC02;
	Sat,  2 Nov 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeoWIdMP"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB235A4D5;
	Sat,  2 Nov 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557922; cv=none; b=FGJQWo/LgZ/10p6i2NaRSrg6kfd9cq4MKKvqAeBTHeQEyfEgElw48Z+0uyiMiLQtfZrtqgmHEvY/rK6841LJfVXPjkkMI47zs3xLVwTb/E5svW0qjcSreJaWkv31UdUwqX/2hDl7IFcHcf3TNa9A1ftqpOFs7re/dSROzd6zVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557922; c=relaxed/simple;
	bh=VoPv0nCeP2KrCbSJNTwdSe/naVgbmSZFA8ESeMEM7YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIMtLtju2RF9TSALbHqJbNpxgcjEV72fdVMJzmGotefY8fHXI3A4eeKOKuAFeV09JrlCCNdDNs6YO2MP3qf5NVKwD9eT3y4znC2e4d1d6LRXEFSDDTMG1plivxTs1sCSMeAxdUL5pTXd0Ge/0XOqt3GcDY+Q16XJopj/bIE2LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeoWIdMP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1865099f8f.0;
        Sat, 02 Nov 2024 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730557919; x=1731162719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAYb8ZWo+6oqgopAoB/L+X6KhCpnV2TRcgj8aWyRjcs=;
        b=eeoWIdMPhaL3I9zarbxL8UjFpqQFmdAJFearhwU3V1qscSpYWFwl3uL0Bj+n9rZj/r
         niQfKwzv7PCkpfmPxHjXE4r7u5h2cvjTSWwLAP/xHjsweBiTeUg1dApCTyHGwWB6jMd6
         cbb9DkyZuhEr8Hggqx06vVNlRp+6EsumCGlcB3qS12apmqNDWbuJq+4HeSE9l4yY7N+d
         BB+x/Qjqn0G5cArzoSJIE/mmke9Jb0WwwxM8uqskruODSooWQ8a58pAuvgKQpinSf67B
         2vN/RoYipv4/W7ER/XbObfqVDiYPxFIdjVvwJFwdfrx8YM+EOav3b98XLInnG01cJlJd
         0WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730557919; x=1731162719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAYb8ZWo+6oqgopAoB/L+X6KhCpnV2TRcgj8aWyRjcs=;
        b=usRtIQtYHQmbvG2voIHGxi0u01a4OpGcUUFcFDFDikLepq4PG6O+yOPOX5VGfSFoEk
         ivTI5CyKyJywVwhikVVBjMb7NxttA158k88hW6JNlZJ7kr4voW2x5Wcdy0QU4ISgcqrP
         teaESa3HsORUKfDsnPzhzHgu3uGfNGr1ZkfAouR0s3El75qI0QNDdVL8/oi04+dhMQOB
         RLCY8E5uC1s3irFLT5k4WISjRM0O49vge36jggT4KwC6SFaUqqY8WfQG24OIUdF3vu4E
         SYpD/1TECpJ8WQvJhJaFDhoOsKI01BFPVEzBZ4vD6g0fmn28lYOx1NRdLDLbHpmsismI
         jZzA==
X-Forwarded-Encrypted: i=1; AJvYcCUaxE6QubNNZR8QbjuNAQBkr2BaNHqrNhRKhMQFBndsGvzmmaIg4Ms2JHfH7mAH11hgsz+MtVblOtVE@vger.kernel.org, AJvYcCVLyhWsujygiiJL5k0f5OZwg1RL6hCrToj6X3CAXDgnb1nURs0/yQ7eKOvLAIHdlbh2bTR7ndxE9vPJd+Xm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tubsnsV7MrvS5RXjWuHXEJscLEkRAEhyCArV2cu4GqrcrGng
	uLiDenjSoRgnhgmLuWMdvYdJwWxHEfp14RQbaZGGeCbQily/fFdi
X-Google-Smtp-Source: AGHT+IHO7EK4WejfjK60Ywe/XJsJA7dpSEF+xjKyDkwV41ZCRX7ykEoI4QfPPkh6TJrgd+sMtyrihA==
X-Received: by 2002:adf:a15b:0:b0:37d:4ebe:163e with SMTP id ffacd0b85a97d-38061206a7emr18644432f8f.53.1730557918570;
        Sat, 02 Nov 2024 07:31:58 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:492c:2677:72f4:9f57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1189118sm8196240f8f.116.2024.11.02.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 07:31:58 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:31:56 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: add single-master
 property to all i2c nodes
Message-ID: <ZyY33Ai6xndqTHzi@eichest-laptop>
References: <20241025095915.22313-1-eichest@gmail.com>
 <20241025095915.22313-2-eichest@gmail.com>
 <ZyWv+BVp91xYr4UZ@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyWv+BVp91xYr4UZ@dragon>

Hi Shawn,

On Sat, Nov 02, 2024 at 12:52:08PM +0800, Shawn Guo wrote:
> On Fri, Oct 25, 2024 at 11:58:02AM +0200, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > By default we expect all i2c nodes to be single-master, we do not have
> > any module or carrier board that uses multi-master mode on any i2c
> > controller. With this property set, we benefit from optimisations made
> > exclusively for single-masters.
> > 
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > index 5fa3959141911..95d5d2333ca1e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > @@ -367,6 +367,7 @@ &i2c1 {
> >  	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> >  	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >  	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> > +	single-master;
> 
> Hmm, I do not see this property is documented in i2c-imx bindings.

According to the discussion we had in this thread
https://lore.kernel.org/linux-i2c/2bbddaxyjkxfmlgmq3yqcbzo7dsb2pq5bvdatk2y4ig4iintkt@35btqkdv7sy3/
it is not necessary to have the property documentation in the i2c-imx
binding because it is already documented in the dt-schema:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/i2c/i2c-controller.yaml
In the initial discussion, it was addressed for multi-master setups, but
it also applies for single-master. See also this discussion:
https://lore.kernel.org/all/bcdd6cae28edd9dd05a71118f9979e7460688775.camel@pengutronix.de/

Let me know if I have missed anything or misunderstood.

Regards,
Stefan

