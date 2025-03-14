Return-Path: <linux-kernel+bounces-560630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20B5A6077D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712A419C3944
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10F7603F;
	Fri, 14 Mar 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ItJMoRmg"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1170830
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741919292; cv=none; b=tOY9QpT+QsVG9EXqPT1yJqheiduU12Ka14Ju8eZvGqcjFEuVRbVlITIlMroFfKhNIbncmu4jfij8+JDPYlGEqkjSwTRBiEpABOwAu/msHBH2uQQYhCRq6Be5ns48ViXUXUK2llpFDMzUXFWV3ESNRQCcJD7kgrUpPMVPF0OGN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741919292; c=relaxed/simple;
	bh=loebAbx3vNDj+ikpiNeciMGVKZMUSmC7NgxZ7+uX4bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox3fRrWDXGK+WItLTqsB9GM0PLe/RUX5k5/ViSwHgwJfmBMLC/c1bB2eqNUGfqPjm/GwavLJYLisCFBoGPvBilLaHQkkJ/rdiRwnGa2TLKNc8zJQ5fJIzPO4SdPdT0nMpp6jjEoiPNPu0dNHG3hReKv0lOZOq+/QPjq7WKKhDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ItJMoRmg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549a4a4400aso1819613e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741919288; x=1742524088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK4KlxY3uUa17qisCA7GoD5gggjvWR4zuA8FgG9CVRU=;
        b=ItJMoRmg1QrRgGeTmUTIxInLxrqWz3OYQgq1iL7MdTcr3XmdhPcKh89Si4wvSWRF2e
         OlJhKWLW818tPcpzt3csu0skKi63B6AC/8pJoM7v5BlcN0Rww6CcYZwKpXN4ST6OxIpT
         CWBHaNEILpSTJfr8acKRtQXQAg7dS0eEcE+7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741919288; x=1742524088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK4KlxY3uUa17qisCA7GoD5gggjvWR4zuA8FgG9CVRU=;
        b=Wl5ow78/hEKBPQEJc8rpSj4R5xFgh3ZMcewvZjpYODOE6pq0thU5wP1zVBl5LO+Oaq
         jHCCXdAdMzBGIrhY+LCFEPmIIUuI7eLR/2FTSrxwVbxQ218K4Jg8+JHOkHcIkr+fzLE0
         8f+UNJT1Df6hnwlBPWtkp+XKGqxPTd481qHNtLbQo3HYRPbNDq9WyeD6SEDyifLOaKxk
         BLbzA3TzGKRnmlKsKPytTqNnc1VVopnvETwFT3OmCuhMt7Tagq5ngPGcAr4Alr3JSaMH
         vA0snk5M1CkJkWl6mjBjY7Cw0VTdKC0Oos0JHt3KF7gxxxvix69wFngou00vEDLCDOSF
         qeWg==
X-Forwarded-Encrypted: i=1; AJvYcCUYljsdxiNBEd7EUmeX0E09yo6RcxSVSwkNdKbWQv92I7CRltmQj5kKrQsm2DLfMboT23pBv8pHlYzS5Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx621nBYwoypsZ+H/6yeU9jLuwIxOAsVfow+ucJ7eVeAcysJF0q
	tLVhpxCSjjosvsuTK7+h77b0PLjGlw70GkaAK6WEjEUwMWjN8aCgQcajpc/rJ0aiNi13DIj86KC
	E2g==
X-Gm-Gg: ASbGnctuNQszAPNG8d1Px686SLLNbuIaCfXLpG8KsmMe3p7yMZz1Ja/Ae4aUyMNINY1
	XekQqObtrCSEfvNVEUvJ4YyCu/JH0DFwEr0tJcm+CPZvZoNE7nRoDerTaVOFYPGLkjTIxUmFRd3
	3KAKYA3S8LNGKgMEagRlqJzCXJ5PDARr22Ioe+Uvllyur0MKHh6qPbtys4meLmSPcdUWu+Yg4K3
	k4TJLREISYQ/eaQ0aG6YSlUVGKCeTbiP1juGNDRIi4z6y7qxA7gaRe/Fz+nN/wiPoaCinvMlnd2
	RTPbb2/bhivSbMsd19CZgsCOXB5l8NPicl/qf2lmMGXdEDhh/BIqDgJrOR93esbtriapfObbYUS
	qKLVjJRCX
X-Google-Smtp-Source: AGHT+IGa3b0R4M4oZJE5pdf/FlMpK7U6uXzeOyl30n/y9tSS0LglWhlKakblPkvhn6xbhFjyPTWyJA==
X-Received: by 2002:a05:6512:3a8e:b0:549:4d78:2418 with SMTP id 2adb3069b0e04-549c38f7d9cmr254415e87.27.1741919287741;
        Thu, 13 Mar 2025 19:28:07 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7bee7fsm381385e87.54.2025.03.13.19.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 19:28:04 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5495078cd59so1723433e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:28:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuWnRkcokgu7R2SXGoGd6pnVgKgEH94UjhXHyTPUxolsuI62XiO1S/cixBnkDewZxYTlfEl2+FzMei3Xw=@vger.kernel.org
X-Received: by 2002:a05:6512:3a8e:b0:549:4d78:2418 with SMTP id
 2adb3069b0e04-549c38f7d9cmr254376e87.27.1741919283647; Thu, 13 Mar 2025
 19:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310104114.2608063-1-damon.ding@rock-chips.com> <20250310104114.2608063-8-damon.ding@rock-chips.com>
In-Reply-To: <20250310104114.2608063-8-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Mar 2025 19:27:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XigZ7k9ZmyT8wEeJKB79ef4ut7XrKdmXGqLbwdbxwe_w@mail.gmail.com>
X-Gm-Features: AQ5f1JqOO-vARbb-qxWvQyFu_Kv3lXKxcHR_dDdzPTPbj0JZAG253PMvReLZCQo
Message-ID: <CAD=FV=XigZ7k9ZmyT8wEeJKB79ef4ut7XrKdmXGqLbwdbxwe_w@mail.gmail.com>
Subject: Re: [PATCH v8 07/13] drm/bridge: analogix_dp: Add support for &drm_dp_aux.wait_hpd_asserted()
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, dmitry.baryshkov@linaro.org, 
	sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com, 
	boris.brezillon@collabora.com, l.stach@pengutronix.de, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 10, 2025 at 3:42=E2=80=AFAM Damon Ding <damon.ding@rock-chips.c=
om> wrote:
>
> Add analogix_dpaux_wait_hpd_asserted() to help confirm the HPD state
> before doing AUX transfers.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 2b76a9cf3bcb..b7e143b3ff75 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1548,6 +1548,26 @@ static ssize_t analogix_dpaux_transfer(struct drm_=
dp_aux *aux,
>         return ret;
>  }
>
> +static int analogix_dpaux_wait_hpd_asserted(struct drm_dp_aux *aux, unsi=
gned long wait_us)
> +{
> +       struct analogix_dp_device *dp =3D to_dp(aux);
> +       int val;
> +       int ret;
> +
> +       if (dp->force_hpd)
> +               return 0;

As mentioned previously [1], it's _possible_ that this should have a
delay like we had in sn65dsi86, though maybe that was to deal with
legacy device trees? It's been a while. Oh, I remember. It's because
even if HPD was hooked up to the controller like it's supposed to be
we don't actually implement HPD in the driver for the eDP controller
(long story). ...so we worked around that with a delay.

Right, so your code looks correct. :-)

[1] https://lore.kernel.org/r/CAD=3DFV=3DWoigDDTG6wTK0smsxASVfK5BzzW6KNpKWq=
97v4GAgvmw@mail.gmail.com

Reviewed-by: Douglas Anderson <dianders@chromium.org>

