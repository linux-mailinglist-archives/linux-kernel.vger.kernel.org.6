Return-Path: <linux-kernel+bounces-264268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C893E0EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA2E1C20BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C82D60C;
	Sat, 27 Jul 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVwYt1ub"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CB29413
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722112088; cv=none; b=Fuu5ppnYNomNzg01HEJxlMJl/Yl0+hWCF4MXumkILb3hCs0V/3vSy7HjYs4nKotW9eM0HhgtktiYL0CeLgiKiKXO2mM732wCO/jmGV11A5+E7r6wiR/zDcAfa51Jzv1zgGTWhLJlwEThMZz3UT6+AZd5qBzwVuUJiV8/Xh4tfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722112088; c=relaxed/simple;
	bh=5Iq+hQdX1Or4aYNR2qZjlxumyuiILNoE8GDhZSLDlAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu2CpE34axO+lSHIVl3w3cYRX3/IF5/7y09ILpfX532MR2dXVSIor+uiB/A0kV6tl5/LelSF/a2uSEtkYQhQoq61c/h4PT4ho+mOxby+QX+HlWZw70Y2H2C78VkM+bcITudZSlsapdAqTmFjb3hbeAaKQXRAfd2Cmkz4kfoIu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVwYt1ub; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso36467401fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722112085; x=1722716885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5TCSE5IQPZmg5+Co6Qb5Q76qkbbdisagHTdBaE0Lw8=;
        b=WVwYt1ub+QimCBdcP7PkJWij9uqZ0PRcwxFLpWNnq0FQvW33uzx2QpeIO8Y4D1VBJr
         GOU5mAetNor5ijB2GgT328pCuwQ8x11amjI9drMf2uPaRVYlElsoertKqT0SjCenduON
         GNfvRDLLd13NUc6NWkYk/absGs/0VkrYP1zEp1fSB5RyN/eiQDO0jGOYvObizey2OlKc
         tixG9ws2y9gIqcPbmvUI9WBFtA1LwRk+4MdgGNPIHcl0YqRdpmo06kip72XUIp3tNZ+W
         zgD5+xatFHjTfSArmR2C6pT0VwbZPiwQw78dYjKREiPvu17tPPsIcJ/jjgQNLtd1+604
         SW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722112085; x=1722716885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5TCSE5IQPZmg5+Co6Qb5Q76qkbbdisagHTdBaE0Lw8=;
        b=iBxPXmaObb1P8MHzEjU3AdTm6Vkx73zCUW+NuJJLndPtRvMqVf5VmfGvQiv0J62djU
         MiFXfHNej+UmbHbiXyzha4BpNeH1CzFJbI2XrQQAI1s9VaV48gKCR+9eEv/MdvROz/ww
         Z4YgX0mRD2w5ivWHOp5CJXMOe5vW/0xfibxQez9jrp/pUdXVBTBBQ8x1t1pURoBPutLj
         l+9S9E8IRbeUqwAsG9gE73dAAnemEKGVBRQgRfsuT94RP9ACjMDqwoOQq3LhypMqttly
         qvaZMs0TKLCC6LKE2/RH01YdeAAnvYiSyKQ0lc0d5IuHODtSL2E+YjXS587SoZvik7GM
         leVg==
X-Forwarded-Encrypted: i=1; AJvYcCUinDnxRdcrpNbdv8bgLR7cp9NnFrOulR5H5UHVfHKQgCrxqzOQaxkfRG0UqB2nX4vtPiY1yL69TO8CAOh2PHrkuOvUh1CAfTCg7kkv
X-Gm-Message-State: AOJu0Yw4M8DwLrHmTRqprZixTGnPEVmkjY7xRfWyroxs1Q/EKRR/DhVN
	nrXr4Yq2GlW/JEH10MCV8MGlqRbNW9N4DSAlAa0+MBXG0KPMtzBMF35r+rVD0bgMZsTONpnM4hf
	z
X-Google-Smtp-Source: AGHT+IHk5AHyaj6Kn7pMIySWcR20lekDgoIkBhN1ucGkQo9nR7bUmFlDSzTzDXUXY1CP8lJJ++NOEg==
X-Received: by 2002:a2e:b5b1:0:b0:2ef:2555:e52d with SMTP id 38308e7fff4ca-2f12ee6342bmr21991621fa.45.1722112084809;
        Sat, 27 Jul 2024 13:28:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d074ea4sm7683151fa.116.2024.07.27.13.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 13:28:04 -0700 (PDT)
Date: Sat, 27 Jul 2024 23:28:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, p.zabel@pengutronix.de, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org, 
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, 
	frank.li@nxp.com
Subject: Re: [PATCH v3 00/19] Add Freescale i.MX8qxp Display Controller
 support
Message-ID: <zr2t6deyvwacawj7s36gols2vxu24fah25x6ofy7xpqyvc4s2d@luavybrlxpaf>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <wky3mjl7fn773myatyrdsea6oc2xebkvrgmigmmoj36eswgqry@2kox5ad5dynl>
 <aba35ecb-2357-4c4f-8366-08d14e40d436@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba35ecb-2357-4c4f-8366-08d14e40d436@linux.dev>

On Sun, Jul 28, 2024 at 03:10:21AM GMT, Sui Jingfeng wrote:
> Hi,
> 
> On 7/28/24 00:39, Dmitry Baryshkov wrote:
> > > Hi,
> > > 
> > > This patch series aims to add Freescale i.MX8qxp Display Controller support.
> > > 
> > > The controller is comprised of three main components that include a blit
> > > engine for 2D graphics accelerations, display controller for display output
> > > processing, as well as a command sequencer.
> > > 
> > > Previous patch series attempts to do that can be found at:
> > > https://patchwork.freedesktop.org/series/84524/
> > > 
> > > This series addresses Maxime's comments on the previous one:
> > > a. Split the display controller into multiple internal devices.
> > >     1) List display engine, pixel engine, interrupt controller and more as the
> > >        controller's child devices.
> > >     2) List display engine and pixel engine's processing units as their child
> > >        devices.
> > > 
> > > b. Add minimal feature support.
> > >     Only support two display pipelines with primary planes with XR24 fb,
> > >     backed by two fetchunits.  No fetchunit dynamic allocation logic(to be done
> > >     when necessary).
> > > 
> > > c. Use drm_dev_{enter, exit}().
> > > 
> > > Since this series changes a lot comparing to the previous one, I choose to
> > > send it with a new patch series, not a new version.
> > I'm sorry, I have started reviewing v2 without noticing that there is a
> > v3 already.
> > 
> > Let me summarize my comments:
> > 
> > - You are using OF aliases. Are they documented and acked by DT
> >    maintainers?
> > 
> > - I generally feel that the use of so many small devices to declare
> >    functional blocks is an abuse of the DT. Please consider creating
> >    _small_ units from the driver code directly rather than going throught
> >    the components.
> 
> Well, I really don't think so. I don't agree.
> 
> I have checked the DTSpec[1] before type, the spec isn't define how
> many is considered to be "many", and the spec isn't define to what
> extent is think to be "small" as well.

Yeah. However _usually_ we are not defining DT devices for sub-device
components. So at least such decisions ought to be described and
explained in the cover letter.

> 
> [1]
> https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.4

-- 
With best wishes
Dmitry

