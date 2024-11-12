Return-Path: <linux-kernel+bounces-406806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A419C6538
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E56B2D01E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9B21A6FA;
	Tue, 12 Nov 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtkvhmsP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684F21A4D0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450597; cv=none; b=uqOSu4gTJzNEUnHbbotrBCaI6Nd3q6If8aWrUGYnj5CRmf7C0U+q72Rnpus0fZsx7ztVh3G6Ft7B8nVFOZjt/qzqx74fx3Xdn9B+9hnbWp8s1qV2N2aQ25OtESZZ+y8oAraiMPjs+jtWCyMqjd4oLdT+W6A8LZVK3WMQ9Pp6S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450597; c=relaxed/simple;
	bh=qjBP7bdvStDQrKNammPad8Fnlc6kW/7F8hV3YzwDMZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmJQ+lOcuK/miXszt9EGlVvllBoagrIS7Uz4OPEnNf4Qpy94MmRlGb2O6vYH/UYzfDkRa/gO7NDoepIab5gevu9WX9Fu90FHmrRO87yKaVGNPfbTZW03DetFVFC5Snih8fE4cJNutiND68XzzLxNj6x15Vb4H0zdUrjz9cYX/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FtkvhmsP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb587d0436so60811921fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731450592; x=1732055392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMLlYAFDqKDkf0WiPqQcIBDe5t9vWTyk5bdOv0ivtJ0=;
        b=FtkvhmsPnR4px0NWYjCFGA6z9iQGnabPPefbRwUr/jfjDqGHBL+dBotOFImsfCS8uR
         +jzYhNzKSrAjo8AyMGJhtEbCsEPYT8K8HADELlVGCGBdvs9FJDdgfuToMB+Ibne0A5hk
         YFLUloibaEN6F8N0p/6vOUoBZqNP5nS8pFRYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731450592; x=1732055392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMLlYAFDqKDkf0WiPqQcIBDe5t9vWTyk5bdOv0ivtJ0=;
        b=agyro0ZwAWiA+FR2nTcqGFXIK4IO+fLe+/KnmeoKg12AMd6+egI6FBE4HGU3Xbsxor
         gm2W6mtYl0gDGJbes/Bv672C0e08T2Wdcghesj83RhZzoreCZMifjjUy2WT0NOFw5s1j
         issCf2QC5qABcRKqR5CWpeENdDio9FDUkMBaOOHYpN4ZlwEghBrOB68lyBSCWVojCeHb
         C4G5So1Tb85DFFYXuLC2CzziW/lg4fIneP8luUpHbeY1uK2toNw0MiKajQ7aDz6F4xGJ
         mXw9/vBAUWrFTznoLvIDI3VBiWUQrl+AoGfdevt+nfp7L3qINOMsYFDn8uf5vFsruQub
         Jb5g==
X-Forwarded-Encrypted: i=1; AJvYcCVSP8dvjMndaScxIeFRYOKu4ufNuUafKX3ox0e/6vbb/3Xl/1vY3kLpA2yfgM83oQU4VTMyVahzyhwB/L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EUJzmrxjj9mDD4Oeb2fssSs31oPMnbE3Nw328a3Mtb0PUVie
	Lqncb7KAFSc8c8fB6DYmIsHqYX1NKbuCoxK8sUR4IoSIpHAVl/gsb7iJqAZf5SUknWXTNSO5KEJ
	jqg==
X-Google-Smtp-Source: AGHT+IEr/Vr1GxyNhVHkk4zLDl2KC+p0kdOeNMrywCCkGvQMapc5a2o1k0lsUc3ktzb52j8TeNRDUA==
X-Received: by 2002:a05:651c:543:b0:2fb:5f9d:c2a3 with SMTP id 38308e7fff4ca-2ff20222f14mr97443031fa.29.1731450592063;
        Tue, 12 Nov 2024 14:29:52 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d84c9sm21471191fa.113.2024.11.12.14.29.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 14:29:50 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb599aac99so59951951fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:29:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVndQEBf72bwbxbTPgPSuvUY+mp/meG437N9jCPMZ4yOcb6231TmbdTjXsGwS/IhFXDsGBEzPaqys76ozI=@vger.kernel.org
X-Received: by 2002:a05:651c:158f:b0:2fc:9622:794b with SMTP id
 38308e7fff4ca-2ff201af817mr81726791fa.24.1731450590306; Tue, 12 Nov 2024
 14:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 Nov 2024 14:29:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJ=KVbopwovCvqR=WKi-pdpj3c5dZ57c+uUMh1ryk=+A@mail.gmail.com>
Message-ID: <CAD=FV=XJ=KVbopwovCvqR=WKi-pdpj3c5dZ57c+uUMh1ryk=+A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Constify struct i2c_device_id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 12, 2024 at 1:12=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct i2c_device_id' is not modified in these drivers.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>   15566     987      32   16585    40c9 drivers/gpu/drm/bridge/chipone-ic=
n6211.o
>
> After:
> =3D=3D=3D=3D=3D
>    text    data     bss     dec     hex filename
>   15630     923      32   16585    40c9 drivers/gpu/drm/bridge/chipone-ic=
n6211.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c   | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9211.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c      | 2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c      | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Douglas Anderson <dianders@chromium.org>

