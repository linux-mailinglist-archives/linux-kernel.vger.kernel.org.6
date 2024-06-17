Return-Path: <linux-kernel+bounces-217262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B790AD88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F235A1C22D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30FA194C66;
	Mon, 17 Jun 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3GrK7Vt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61290171B0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625654; cv=none; b=KGCio6ZxGDjoJCbx8S9yAPiLZJsNAo0QcmBfWjYQzDVoJ+9Q1qIBTrEv4QizKs4gw8Btt49pGvakE3VZP+K5ERpM+RL+jHVzmDgHufmAAgUdnjzbDhdCN7f74T9e6eSuOzzfyo1duckbxBACchWwwp8PNYz4fw6tQgcSTpDijec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625654; c=relaxed/simple;
	bh=DPjahjEeaBVIGThbQcqyaa2U1LiV3i5aPAepdhCYKpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbKV6unu99vjiF9TgUVHpVzeuReHslsJcIkSCHsCgYIF0rigH9WSvGOMr7Y6Nkpe2dFN0GZnMNrapgcLH5pJt1qlhVaLvnWH8tSKwBdfY49KQPosZVcofVNu6gYwMyq6IcftCAYI7xoAdWtTzaFL1uvIGCdm8pFCbMqKY2+Xb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3GrK7Vt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cc129c78fso231272e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718625650; x=1719230450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NU/LTmlktNIMT1128wfVsbnpn1ZfLn+vUpRJKBKxt0U=;
        b=d3GrK7VtWLqQcYpo7roQAIqwLV8V+uZOh/gLGGLneQElxXGlg6TbmsAGCJND5DOobX
         mVxTPltUawBV5yuPBL4RIYlsA0DCP2SkndHke+cFJeAlCqs7OKUetKZtgksvwH3zH8hJ
         WQC00Ms2yycD7OvIMP0HJJHTnMUfq6e6AQ5wdYcxaeaJw0zq7YJJKNPxhjU//ucsCax9
         9pU/w8MIUr9rr7FKIdrHxVleUAF5lUJiR+NZ63SgR4LnzG56rEm8k6rmr4Y3NM6zKCjf
         ji9wfOGwm+nVyzysaNlehFbiwaqrRg0jQ+OSrT4+bp0C1xDmfBenaHWNsCGmZNRgbmgj
         6mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625650; x=1719230450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU/LTmlktNIMT1128wfVsbnpn1ZfLn+vUpRJKBKxt0U=;
        b=YeWVF0vi3eipVteMOwfcqgMq8adWjUjMl6yZvo2RTzMgPtapFJgOfNTf4Mkues7nWf
         y/dcfhZwFZuq7kj5JC8On0QzjrXjtXLuzRduYjIhtujfRPfqQIe+TR4/Uv74tAVJODG9
         MSWX/mGyWQnGPR7jdS1RpIstBn8x/LZ0F9Bi1cRDhOSJkNptWuQdii6mfM9ty2IuV5cH
         s5dqI/U5pLclgh+l8FIW2m60qnQkgm+oArjRp/J+UYd1Oof+tjMwCxiT3Owf/UMVj+1l
         vCF1f6HPt3CBmSv3caBPEp4HJ6HUzUbluppxyBZiyE/FtN1GZjOD0rr4xT5IdPQTxSgf
         iNfA==
X-Forwarded-Encrypted: i=1; AJvYcCVXVKCCaFReMj8MdCR92AXV3jkBT6CH77HKWh4TAQ51kEkL8qAjqkLxxgaUqHLM9jPXGBpH4cFMzisN9h2aXbIpAPAFlcQYnQSTPGuM
X-Gm-Message-State: AOJu0YxKer4ExnK2S8aVvbq/erKt3nMj1I0WOdvBwCn+JTckgrl/ifOh
	yGMxFkA24gS6OdvhlOky110uCJRgCH00Wki/Ckvd2O62LrUgVEmMlCpP4u2PA9U=
X-Google-Smtp-Source: AGHT+IH25QDdxRClhZAe83V9E83up0xzJCKOP0Or36m8YFuJoo3ltUbEJfz+c38SeyoOcm23ix9WvQ==
X-Received: by 2002:a19:6406:0:b0:52c:80db:bfe3 with SMTP id 2adb3069b0e04-52ca6e643edmr5993226e87.21.1718625650508;
        Mon, 17 Jun 2024 05:00:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282efe1sm1210861e87.76.2024.06.17.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:00:50 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:00:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v3 07/10] drm/mipi-dsi: Add helper to find input format
Message-ID: <3snmlbjux7j44hxnbrws54lth76uid3zxstwccswiz52gfbqbc@6svsb2zrpsoy>
References: <20240617105311.1587489-1-a-bhatia1@ti.com>
 <20240617105311.1587489-8-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617105311.1587489-8-a-bhatia1@ti.com>

On Mon, Jun 17, 2024 at 04:23:08PM GMT, Aradhya Bhatia wrote:
> Add a helper API that can be used by the DSI hosts to find the required
> input bus format for the given output dsi pixel format.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 37 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  1 +
>  2 files changed, 38 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

