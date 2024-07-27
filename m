Return-Path: <linux-kernel+bounces-264287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1B93E146
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 00:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE32281E85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA842AAD;
	Sat, 27 Jul 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsLdO7IJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D42D058
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722118105; cv=none; b=bpbsY4h1LGG6QLCA9kSKjZRXHVfhipQ6NiFuyHKsArRcrRtNQzGuRXVbhL6qG2176JOzj5DktNbXagTIV7oS5zF63u2hykbR4EUWLbU9dOTCeW1rxoWppmZhUqwznLJiRdZLlF5AJxp5Nggu/2Ru3teJp7hONKJyAVn699NGf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722118105; c=relaxed/simple;
	bh=HTtH6lIft5ZQOLIYIWCibqht64/060nP/EZnnBgGREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/TMgEV/+FGxOvgnO65r7pm+ntvpQKczwpTPrJfkMFCvLb9JcHTbq3LVbXx/H9PKHG7DWVze6vR5itY/dcypwuzNzw5WEE2RrHZiBfaX6h+AbdY2ZZxUxXrlBjFU8T9ENSSzf+KBNO4ArWeCAUnbo8b7S/tDMX3E76a4laOqmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsLdO7IJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efbb55d24so3455552e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722118101; x=1722722901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwqWPO6eJP4Qec95t6HNVfe9KGEXFic++ajRHBM7iSo=;
        b=LsLdO7IJUhHjT3Gn3WjF9pDzmiUYvFogcYIPOGENGpQpbgs/aqjCojWOqhuBO3IPE5
         yzCpaD4In9KaBK7qeRby6bicXErn3AnBP/LwwjoeLEIJHcXDUBrpDITJoytgqMGhZyih
         cH/9n6PcjJHxBMtOE1RK9EQcnh1Vy/Rnjt6bPJbWgy9All4bkS3JaD9DqIbkiZAyq49R
         9XciEEWHZj5Js/EfD57Ut4btE75MsslY5R9SCjj5LLIM7/QQBfiksUAWx++1xUn2AYIp
         yPvX/HDI/zAdGn6joIgPOXhAavsTvHXUNraGUa0Cc3V2Hc8XuJhJ1+5zNZfuRTFmaFGq
         +aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722118101; x=1722722901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwqWPO6eJP4Qec95t6HNVfe9KGEXFic++ajRHBM7iSo=;
        b=GQypyZ7NWIbLchZbxxBl/OOV//Rn1Zp+6bmAOlt+0I6nHe2FoLxDV0oFbvggoQrfnv
         22bF1Q+pLJdiTUkfTRfx6EmkOZ35ZlRrHXLosJ0pk1H3505QPPglQ3xUfKUAzav1Lreu
         GUMGVmPNqAw9GqhwYih/esaITBL6zcAC8SnApyaRbc8Wr5SR5EdHFDbViODcuogdA3pb
         vNxuuL9ZZMQn661Ygr3PA8oLV9iYZZwMhxxVIR62w0g9SuVfgLvohPJWH7xv1TAiu5fT
         Epof1nclnhPhqydAnHcl2nu5m6l3stHr6JlYOyPgt23T/cdiggoNE2XO4RwMoBREpZm6
         U8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVevQgzC0EGIEORQ4snQQVsghWt6XYTROdLqEu6+xvFIpstnLbxAb23lMaDjryfVnJ2lNAjA53MObr4WSgWt0UD1MgG/7wLN5xanH1+
X-Gm-Message-State: AOJu0YwN4yFYbWMTG/0pRWZSo2WYOKhnvND64GFySakxOmZA2DDLsPsE
	i35kQ9lci9aD5uGnmn20L2ZEg3H/nKaXyeCaF3h++5ThUgf7KikluO3zXawlies=
X-Google-Smtp-Source: AGHT+IEESjcuV3/3oS+Os1zyf2LB2n6lMR6DUHxbQ1nXgYeN+N3EfPjlTdSC2SKSZtLypC95ksepqA==
X-Received: by 2002:a05:6512:1296:b0:52e:933f:f1fa with SMTP id 2adb3069b0e04-5309b2e0b62mr2773797e87.61.1722118101176;
        Sat, 27 Jul 2024 15:08:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd1292sm872881e87.105.2024.07.27.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 15:08:20 -0700 (PDT)
Date: Sun, 28 Jul 2024 01:08:18 +0300
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
Message-ID: <no7cgb4vfd4cxhsjoftfeizvzby4vfbq2okvneq4nbxs4ogwvt@ohplzz5bez4j>
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <wky3mjl7fn773myatyrdsea6oc2xebkvrgmigmmoj36eswgqry@2kox5ad5dynl>
 <aba35ecb-2357-4c4f-8366-08d14e40d436@linux.dev>
 <zr2t6deyvwacawj7s36gols2vxu24fah25x6ofy7xpqyvc4s2d@luavybrlxpaf>
 <8014238b-2668-4602-add1-64a0c6e480ad@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8014238b-2668-4602-add1-64a0c6e480ad@linux.dev>

On Sun, Jul 28, 2024 at 05:38:37AM GMT, Sui Jingfeng wrote:
> Hi,
> 
> On 7/28/24 04:28, Dmitry Baryshkov wrote:
> > On Sun, Jul 28, 2024 at 03:10:21AM GMT, Sui Jingfeng wrote:
> > > Hi,
> > > 
> > > On 7/28/24 00:39, Dmitry Baryshkov wrote:
> > > > > Hi,
> > > > > 
> > > > > This patch series aims to add Freescale i.MX8qxp Display Controller support.
> > > > > 
> > > > > The controller is comprised of three main components that include a blit
> > > > > engine for 2D graphics accelerations, display controller for display output
> > > > > processing, as well as a command sequencer.
> > > > > 
> > > > > Previous patch series attempts to do that can be found at:
> > > > > https://patchwork.freedesktop.org/series/84524/
> > > > > 
> > > > > This series addresses Maxime's comments on the previous one:
> > > > > a. Split the display controller into multiple internal devices.
> > > > >      1) List display engine, pixel engine, interrupt controller and more as the
> > > > >         controller's child devices.
> > > > >      2) List display engine and pixel engine's processing units as their child
> > > > >         devices.
> > > > > 
> > > > > b. Add minimal feature support.
> > > > >      Only support two display pipelines with primary planes with XR24 fb,
> > > > >      backed by two fetchunits.  No fetchunit dynamic allocation logic(to be done
> > > > >      when necessary).
> > > > > 
> > > > > c. Use drm_dev_{enter, exit}().
> > > > > 
> > > > > Since this series changes a lot comparing to the previous one, I choose to
> > > > > send it with a new patch series, not a new version.
> > > > I'm sorry, I have started reviewing v2 without noticing that there is a
> > > > v3 already.
> > > > 
> > > > Let me summarize my comments:
> > > > 
> > > > - You are using OF aliases. Are they documented and acked by DT
> > > >     maintainers?
> > > > 
> > > > - I generally feel that the use of so many small devices to declare
> > > >     functional blocks is an abuse of the DT. Please consider creating
> > > >     _small_ units from the driver code directly rather than going throught
> > > >     the components.
> > > 
> > > Well, I really don't think so. I don't agree.
> > > 
> > > I have checked the DTSpec[1] before type, the spec isn't define how
> > > many is considered to be "many", and the spec isn't define to what
> > > extent is think to be "small" as well.
> > 
> > Yeah. However _usually_ we are not defining DT devices for sub-device
> > components.
> 
> I guess, this depended on their hardware (i.MX8qxp) layout, reflecting
> exactly what their hardware's layout is perfectly valid. It also depend
> on if specific part of those sub-device will be re-visioned or not. If
> only a small part of the whole is re-versioned in the future, we can still
> re-using this same driver with slightly modify(update) the DTS.
> 
> The point is to controll the granularity and forward compatibility.

That's why I asked for the comments or explanations. The cover letter is
a usual place, as it is an introduction to the series. The reviewers
don't start the series from 8/N, they start from 00/NN.

> 
> > So at least such decisions ought to be described and
> > explained in the cover letter.
> 
> Agree, but I see 08/19 patch has a beautiful schematic. I have learned
> a lot when reading it. I can't see any abuse of the DT through this
> bulk series anyway.
> 
> 
> Comments below are not revelant to Ying's patch series itself.
> 
> /*----------------------------------------------------------------*/
> 
> By the way, the last time that I have ever seen and feel abuse of the
> DT is the aux-bridge.c[1] and aux-hpd-bridge.c[2]. I strongly feel that
> those two *small* programs are abuses to the DT and possibily abuse to
> the auxiliary bus framework.

Off-topic should be directed as an answer to the original series. And if
you tried, you'd have seen the reason and the explanation. And a quick
glance around would have shown you the ti-sn65dsi86 bridge, which also
has similar structure for exactly the same reasons.

Nevertheless, the aux-bridge and aux-hpd-bridge provide a way to link
two different directions of the probe dependency chains: from the SoC to
the connector (DRM bridge chains) and from the connector to the SoC
(USB-C chains).

> 1) It's so *small* that it don't even have a hardware entity (physical
>    device) to corresponding with. As far as I can see, all hardware
>    units in this patch series are bigger than yours. Because your HPD
>    bridge is basically a "virtual wire".
> 
>    An non-physical-exist wire hold reference to several device node,
>    this is the most awful abuse to the DT I have ever seen. In other
>    words, despite you want to solve some software problems, but then,
>    you could put a device not in the DTS, and let the 'OF' system
>    create a device for you. Just like what this series do.

Thank you for your opinion. However you have clearly provided the reason
why these devices do not have a separate DT node: they are internal
parts of the existing device.

> 
> 2) I feel your HPD fake bridge driver abuse to the philosophy of
>    auxiliary bus [3]. The document of auxiliary bus tell us that
> 
>    "These individual devices split from the core cannot live on
>     the platform bus as they are not physical devices that are
>     controlled by DT/ACPI"

This is correct and two mentioned bridges follow this approach. This
phrase mostly provides a boundary between platform-based MFD devices
which usually have MMIO-like addressing for cells and non-MMIO,
non-platform devices living on the aux bus.

>     Which is nearly equivalent to say that devices that are controlled
>     by DT/ACPI have better ways to enforce the control. When using
>     auxiliary bus, we *generally* should not messed with DT. See
>     golden examples[4][5]. At least, their code are able to run on
>     X86, while the code you write just can't.
> 
> [0] https://patchwork.freedesktop.org/patch/605555/?series=135786&rev=3
> [1] https://elixir.bootlin.com/linux/v6.10.2/source/drivers/gpu/drm/bridge/aux-bridge.c
> [2] https://elixir.bootlin.com/linux/v6.10.2/source/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> [3] https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html
> 
> [4] https://patchwork.freedesktop.org/series/136431/
> [5] https://patchwork.freedesktop.org/series/134837/
> 
> 
> Best regards
> Sui
> 
> > > 
> > > [1]
> > > https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.4
> > 
> 
> -- 
> Best regards
> Sui
> 

-- 
With best wishes
Dmitry

