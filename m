Return-Path: <linux-kernel+bounces-190365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE088CFD51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F831F22EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648B13A888;
	Mon, 27 May 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb9MluAW"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465994778E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803003; cv=none; b=HbiNMEuqM0evh2tKZiWIKKAE/Z8VsQNOSoRktGSxU2BbxWxxO1FLdtl1dP/elJOTEYn5L7OIq8GdRFYEmu1pfW3UkkAEf/ny/LoIvRPRjCeGiG3kuDxcjpD7MPlBmFpEXRo4eEOS8Fw/xZh8WlQqvy5ZKU3KSZmAe1d2OMg3s5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803003; c=relaxed/simple;
	bh=r9nbaoFqgRjLYGHhUWKMyFC5NnKZ/LrtLxXc77Y9tNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL6AaVH8FLRBp7KOmzG/xa63i7x72H5erGBwho5yP+8wSI+JV3ayqWwInfuZA90zQFN+cn48Gxf/skkSOc9emF0pMsHb/EgCihyK5L+QBmGj8nEDXhvkZloXGJOzPcNkv2s2VOoPb+WVaZXU8e6Om4C76pNlmYfLKlbCPvwzABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xb9MluAW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95b03e0d6so26304371fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716803000; x=1717407800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0N7iqS/jW6psWnJVJQjJRax8oZv8fa2R262LhPDLB+4=;
        b=Xb9MluAWPxk7IKJ7vlRvfD865+OfthMQE9suVJCGWyPtyxrUGQwKJurFL5SOsz2i3+
         HLbTdjQRrA08VxQNKPtmuEYijmOhOAQrsxbezA1WVgLQX/wtF83u91Y93kGaXthKv/Y1
         XdyXbhpA8sL7cY+LPRGcUwzrcpgWDBWVoDOOehuEklUGhoPXe8QaKclgstJQMsaTAcfJ
         Lv3qwQ5ankjw/fPx5jT8uBgJiSyPtrWTdqT1dWEbcTr9ueQQmLxPvPtDy2nthQRpk5eK
         WJt9S2AN+eTG/z1e9UEdqEm0Imsow83fbx5tUVMGC7VulZB2eTGc3QxEBsQQ3vcP0vNx
         nnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803000; x=1717407800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N7iqS/jW6psWnJVJQjJRax8oZv8fa2R262LhPDLB+4=;
        b=dWmOpt8F+Xe9ztAMyplIf3j2FbYcAjMlq6Su5useDr17eYqjHvVekksnnbKmWZ/Reh
         pmAO9S+PvxXf1RhHQJdvkbE8UtvCrpX8XqX+74tZO19maPibxDOWavH9ILi6kJXJkFqp
         3T+iQ2dUftGL0FmFpTw1QswxLe6ivI2KtyNARWxqh25NSoVBy88rYdkFPIB3KKu4073y
         BX+n0bq2xMyQf6GH6P2Xcg4PnihHKeBFK5ZhBa/NWf2fsK4Mur/IH5ds7WnaAwaDo16F
         l0areDQiyZpndOrJG3N0yr8KwQHD24fEGTylcSSx3Gpd07zQy50J0xZ9L5JmpPW1suF9
         HYnA==
X-Forwarded-Encrypted: i=1; AJvYcCWbgMesxBJRsgzVpP7Q57xACSErXqBP/khniUcXxnwG/OTkcMNPvELJEKB/oPrCPes1zlTy16y/+Yk3Z4LbvzpiXxOFjGO6eChXXRME
X-Gm-Message-State: AOJu0YxYWaPQWTbMpVBz1aQyi6egDwLNUZd/odkgpp4eWWsK5r6HkV0V
	F+zb3oNj/eE1TISOp82wr839kE9zAGaT+zKZ7jqPtkInh1ObBqg/cXTLBr/e7gQ=
X-Google-Smtp-Source: AGHT+IEiQ8C9Lceia0g8JujCBp7raFBHsn1Pi+Zhb5Y4D5nikSTHmLnkevBZXNf8N4rIWwJyGf6zsw==
X-Received: by 2002:a05:6512:3145:b0:520:ed4e:2206 with SMTP id 2adb3069b0e04-527ef9d9483mr3265363e87.17.1716803000505;
        Mon, 27 May 2024 02:43:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529a7fb982esm230632e87.265.2024.05.27.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:43:20 -0700 (PDT)
Date: Mon, 27 May 2024 12:43:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v14 17/28] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <a65wtf2hy7ufimkcgo5k2c34ygvtv7erwh567ngsnuaha7qiny@nl6lx67qsjuw>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-17-51950db4fedb@kernel.org>
 <4n55dbl2h275z5ubebigri4xjtjsvt44w62n656srdgndcav2j@rrq5haucqx5u>
 <20240527-adamant-just-spaniel-ebed4e@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527-adamant-just-spaniel-ebed4e@houat>

On Mon, May 27, 2024 at 11:02:13AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Thanks again for that thorough review :)
> 
> On Thu, May 23, 2024 at 01:22:56PM GMT, Dmitry Baryshkov wrote:
> > On Tue, May 21, 2024 at 12:13:50PM +0200, Maxime Ripard wrote:
> > > The i915 driver has a property to force the RGB range of an HDMI output.
> > > The vc4 driver then implemented the same property with the same
> > > semantics. KWin has support for it, and a PR for mutter is also there to
> > > support it.
> > > 
> > > Both drivers implementing the same property with the same semantics,
> > > plus the userspace having support for it, is proof enough that it's
> > > pretty much a de-facto standard now and we can provide helpers for it.
> > > 
> > > Let's plumb it into the newly created HDMI connector.
> > > 
> > > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > > Reviewed-by: Sebastian Wick <sebastian.wick@redhat.com>
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > >  Documentation/gpu/kms-properties.csv            |  1 -
> > >  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +-
> > >  drivers/gpu/drm/drm_atomic.c                    |  2 +
> > >  drivers/gpu/drm/drm_atomic_uapi.c               |  4 ++
> > >  drivers/gpu/drm/drm_connector.c                 | 88 +++++++++++++++++++++++++
> > >  include/drm/drm_connector.h                     | 36 ++++++++++
> > >  6 files changed, 133 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
> > > index 0f9590834829..caef14c532d4 100644
> > > --- a/Documentation/gpu/kms-properties.csv
> > > +++ b/Documentation/gpu/kms-properties.csv
> > > @@ -15,11 +15,10 @@ Owner Module/Drivers,Group,Property Name,Type,Property Values,Object attached,De
> > >  ,,“saturation”,RANGE,"Min=0, Max=100",Connector,TBD
> > >  ,,“hue”,RANGE,"Min=0, Max=100",Connector,TBD
> > >  ,Virtual GPU,“suggested X”,RANGE,"Min=0, Max=0xffffffff",Connector,property to suggest an X offset for a connector
> > >  ,,“suggested Y”,RANGE,"Min=0, Max=0xffffffff",Connector,property to suggest an Y offset for a connector
> > >  ,Optional,"""aspect ratio""",ENUM,"{ ""None"", ""4:3"", ""16:9"" }",Connector,TDB
> > > -i915,Generic,"""Broadcast RGB""",ENUM,"{ ""Automatic"", ""Full"", ""Limited 16:235"" }",Connector,"When this property is set to Limited 16:235 and CTM is set, the hardware will be programmed with the result of the multiplication of CTM by the limited range matrix to ensure the pixels normally in the range 0..1.0 are remapped to the range 16/255..235/255."
> > 
> > Should it still be defined as a generic property?
> 
> I'm not sure what you mean here, sorry. It's being documented as a
> connector property now, so it's very much still listed as a generic
> property?

I didn't perform my duty well enough and I didn't check the file for
other instances of the property. Now I indeed see a generic "Broadcast
RGB" property, but to me it looks like having a different set of values:

,,"""Broadcast RGB""",ENUM,"{ “off”, “auto”, “on” }",Connector,TBD

-- 
With best wishes
Dmitry

