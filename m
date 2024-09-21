Return-Path: <linux-kernel+bounces-334946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7877097DEB4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B971C20CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74AF3D556;
	Sat, 21 Sep 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdEB+Z/e"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15D179BD
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726949018; cv=none; b=nrUf0tvHAbLCHq+sbrNjmsVGNmX/bQGDaMQ3jkzA+oOJ+Tbe4mUfCpJCwIYmD4vEVz/gEIdR7deZq7Jn07KmyrHwFJWPtq6mmsRSZyxKHnEf4vK/oiazTXhcotuYfDMjcK2fUWgAQ5V0JFB9kScA8ezaA+kqfWX6W0rr2TcqsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726949018; c=relaxed/simple;
	bh=sCMkjBpIFcXMCXZShVhYbKuGYU7egp53f7tzAmFj0l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwtNv75obnXJzA2v4NX8WSw+332iMM+ptLk34cG3AotxU5bc0RtE4cPl305flMqpxl63I/K2ZAKXNI1q5vgdLTuR8N7GLRtdD6ptStjy0wtlOBOBhBrUkX3a+JDrQ4bBjnlIBDuXD6SAiAOrf8Feo+DQBNvaSFbTu7D54yDrsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdEB+Z/e; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso29276211fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726949014; x=1727553814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//dPyHa0UWKdAvWVcUz38Rp299z63kJ0pkS+sV7gK0g=;
        b=qdEB+Z/eSIK7M8FBqjBR3D/iSCr/LPKty9h3zttFCUS8+e3CsU1SFu4g6ewMvORBiz
         GHwm9InIvVCtDwmalMDyjR13bKfNcpLuo8L4baBqybd2nbNWJbfcKqivj34RYaIDjXbp
         mdy9hfJa9RroNB9G01dbE8YoIgnA2CncPNH95/ZdXZ2HXtuT0+XMqoQNJal0e5z5w/vO
         TrUV+ofJZAP9VDdxpPKSgTKSiIMnNZ279+g5tuxwQNItEU8uo8NyEcxVe8T4BaEK9VdQ
         ZZajp38fT2/CxMa20g9AoXBcM95iZgi020KRiaoWtKkhKJBFU63sCfrN6+wy9TcedXMI
         2ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726949014; x=1727553814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//dPyHa0UWKdAvWVcUz38Rp299z63kJ0pkS+sV7gK0g=;
        b=qYBLTJ/xbOFYI6ILqC41WiSyixq9b/iCwQ7A8K+J+KbcSNqSoOLcZmondAX80CeKyT
         cNOyiYLNmykUkJZgJYCj0fOPjyE1n7VJrtRmGW5pMv2NjY4Mrh7C5sJ5b5wNvt4asxRk
         HuoUqHQb1NEWt1+TRr+iuehhRkm5iV2vTzIjuo9fWVN6CYkP9rBcPUPCG5TViUa9xL+V
         B7RWGwVgnYroLk8hBOFe8F5zdg5b7/nmyN7AtWxVLM0PZU65es0rm4SiATz5xUkHL4Ik
         3AFP+PX8lYdL3y+v1kImprxEdIminZ78mmpqqwUQzhwiA3km7/OyBI4/nOHG4AP2u8Sk
         jb8A==
X-Forwarded-Encrypted: i=1; AJvYcCU476RJC8iCGgkCGgvmrc0lgSCcYL6acXZBUVYdaW75jxJVJ6hw+0/nyMLEpVZ7uvfE7AhjyzaK7qJYaQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3pCh9v+Epx+AK63NUABpPag92ryVYJhRbayIaJazj2pfxa8q
	THXjEvuiSXXR85NToiTYJ6TTrGif8mdsMNQ4mM7dfpvNC/eWJO2dNx5Z9cfnm0E=
X-Google-Smtp-Source: AGHT+IHl3CzloggE6ZkXGgjqllbtSWEeupLOO6YGSpU6Ugo9qQZmUJSybuhb9yX51HmSvfwAxUvdFg==
X-Received: by 2002:a05:6512:239a:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-536ac2f4e47mr3637916e87.26.1726949014244;
        Sat, 21 Sep 2024 13:03:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a86b1sm2754817e87.216.2024.09.21.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:03:32 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:03:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: tjakobi@math.uni-bielefeld.de
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	=?utf-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm: panel-orientation-quirks: Add quirk for AYA NEO
 GEEK
Message-ID: <b3rgwasctcww2gicpjmxdnt4333qcnvrt3mydprs4sfkqcksel@qx3lubcwdrjd>
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <40350b0d63fe2b54e7cba1e14be50917203f0079.1726492131.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40350b0d63fe2b54e7cba1e14be50917203f0079.1726492131.git.tjakobi@math.uni-bielefeld.de>

On Mon, Sep 16, 2024 at 03:18:55PM GMT, tjakobi@math.uni-bielefeld.de wrote:
> From: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> 
> Add quirk orientation for AYA NEO GEEK. The name appears without
> spaces in DMI strings. The board name is completely different to
> the previous models making it difficult to reuse their quirks
> despite being the same resolution and using the same orientation.
> 
> Tested by the JELOS team that has been patching their own kernel for a
> while now and confirmed by users in the AYA NEO and ChimeraOS discord
> servers.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
-- 
With best wishes
Dmitry

