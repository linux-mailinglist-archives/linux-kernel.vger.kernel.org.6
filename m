Return-Path: <linux-kernel+bounces-433285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC69E5601
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240FA1882EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6521A42E;
	Thu,  5 Dec 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+5Z/ibo"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53732219A81
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403423; cv=none; b=ca5aPdwlBY6Lnt/jLJnfrAuLsukLtKeEXcLoI9o1Ztib+dvWN20XfG8to8d1n1fkyu1/b0val+reg228Tpnll/Nh2u4n6gr9VXqsBa3BwQa47CcZb890ePGmfZrQ/Wnm4OQAYPL91PeJMKQcL3PaVguxLTp40+2HppL9tHwaA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403423; c=relaxed/simple;
	bh=lrmVwp9MTTP8vf6Seft4g9nKq4y4c+Dk4Abh6s3Sokg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQOERoVWju0Lr6qNdgdt9/IDiGweN9Z9jdZwkDSqlaCvKDJFVChd6ff5YlCuUleS9p+jgId5LYTsORUwLyKTW6FcElXxjRZquX5v7nvhS9Ow6/GhOMJmdAXms2Wc/xAalNxr2uFZOEC5LsEEOcu+CU1pWnMHqLR7IqH3GSO1sP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+5Z/ibo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so818055e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733403419; x=1734008219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Jxa49+lF4JxHiGnW6UzqLVnsE/QayBWcQoJh8S91E=;
        b=v+5Z/iboTEnMu4ZRCBjn46GCA/C6PN1VsWvwD4LQxSH4PRc1OBn0uRE9IV9TKLyvDO
         /nqksHIt3a9bn6PznbBHMCHp/xynveqxAPOAWfGp86h8fp8uYAaGYVviL99nDt8he3fv
         ZOkEl5kt6z9mIIbaWGjMiggF7CU2iA++HHGknKJr6A2TCcKuXlf3ExrjrnSnmNMGyfVI
         LVAYhewyndkpypiMlzY0ZeQyVSdyY5KBMod69/9v+nexoSdyYEcibUarBpgrkJ91wUzr
         8GrEJ3Ii8MWUq/3gHpdYfsqHvdmVPfhfZW2/WAqGmlKeVCNYUBGAYyCw1ttVHopkLID8
         dDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403419; x=1734008219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2Jxa49+lF4JxHiGnW6UzqLVnsE/QayBWcQoJh8S91E=;
        b=o7t9ZZhOgwNo/Sjam/snrCgx2U5CRWE6zBljCMhV64p83dxMQMGc8esBDmyk5/R9c5
         HSTifKNxiZwm6jRJADa52Menw5cijXF2rbYr5TpX2hsebBiSDNGWj1GC1ab5/0puGl2l
         RpZS6muu5uHuqmCW/p9Itd7VjvfAtA+JolDpODzX+rXiBapiiSwrf9Pel9KG9W1oibFM
         MxJyFJzPNhL2D635T6a2SfnTxvFJXdDJLJUtcSlUK8FMPIL0mS5L0JBNSk7eW5n9P90M
         NpaglVY3nZtaHxudPRijlfxFoxWvQfLrDbaqKKZYeyltw2X+wwQCW8GPGF+TCw7w0x9e
         HQrA==
X-Forwarded-Encrypted: i=1; AJvYcCWKI+9z0xc1HUGWcxntzrzv7T32WqxzH2a00CzkgLg28rC2LRtYLV5YDLZmA+53aQRyyl+cnm0JzEGIMOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvT0aAwPvzVzgsxlcJvmrDvaB7tKTKbT0Q5RACqfVvvEs4bhg
	ZbXAh25H2BiSt7gKb7BL4B9lAv6fPtAg9FjeavvQ5f7/K63mD/M7Wl5yLWX/Has=
X-Gm-Gg: ASbGncvW9UvwIa5qStbjrFD83Kd02XdCbwj6FH3CF6cZ2i6PfnJsVSQqNrTMaN3FgHh
	VpvNZ+IzGp8nQoQDuFSC1pMbXWUH3U88aAnBBAp1JjwP7wwEc8zZs6d7jj5ZIGw2WIPGP44n3wd
	cVD+el+V7TMc3rJsV0hJkhhxsU2Lfuq2hwcjAFNxJqvheF/c511I/QYr35pKc/jCnSvK/tQV6+a
	E3/ivRcsYQLhgOGeQ08hA2gcBDvJPX90s7rXSwx2yxJHgpFD4uzjohPAXp55NilgKFaX/9mU75y
	92u1hyTcf3LxqUbgd9TbN9tBVhQCFQ==
X-Google-Smtp-Source: AGHT+IFxozV5yADLSZdT2aZmMAmC3YLc8oyR/mmxvGNOEAUjKfoe1x86CuOyh23J/0TyZbHiXn/ilw==
X-Received: by 2002:ac2:51d3:0:b0:53e:1c3d:d0c5 with SMTP id 2adb3069b0e04-53e1c3dd10cmr3218316e87.28.1733403419364;
        Thu, 05 Dec 2024 04:56:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229751fcsm237413e87.87.2024.12.05.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:56:58 -0800 (PST)
Date: Thu, 5 Dec 2024 14:56:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, jie.qiu@mediatek.com, 
	junzhi.zhao@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Message-ID: <uhcl2ypz3xmari73xl3l4klu2ucfkfkuj7bt3dz35hfmuzvvkj@5odvmmhivl54>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
 <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
 <olxtqto5mbgofxg4iqjvsmpxxzz6zoj7pbwmoeklhfjiavqfvv@dyveek7hgtki>
 <f2862790-f613-4583-bec5-302e06c77d8d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2862790-f613-4583-bec5-302e06c77d8d@collabora.com>

On Thu, Dec 05, 2024 at 01:36:18PM +0100, AngeloGioacchino Del Regno wrote:
> Il 05/12/24 13:29, Dmitry Baryshkov ha scritto:
> > On Thu, Dec 05, 2024 at 12:45:14PM +0100, AngeloGioacchino Del Regno wrote:
> > > In preparation for adding a new driver for the HDMI TX v2 IP,
> > > split out the functions that will be common between the already
> > > present mtk_hdmi (v1) driver and the new one.
> > > 
> > > Since the probe flow for both drivers is 90% similar, add a common
> > > probe function that will be called from each driver's .probe()
> > > callback, avoiding lots of code duplication.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/gpu/drm/mediatek/Kconfig           |  11 +-
> > >   drivers/gpu/drm/mediatek/Makefile          |   1 +
> > >   drivers/gpu/drm/mediatek/mtk_hdmi.c        | 724 +++------------------
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 425 ++++++++++++
> > >   drivers/gpu/drm/mediatek/mtk_hdmi_common.h | 203 ++++++
> > >   5 files changed, 729 insertions(+), 635 deletions(-)
> > >   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > >   create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_common.h
> > > 
> > > @@ -1026,19 +812,12 @@ static int mtk_hdmi_setup_vendor_specific_infoframe(struct mtk_hdmi *hdmi,
> > >   	return 0;
> > >   }
> > > -static int mtk_hdmi_output_init(struct mtk_hdmi *hdmi)
> > > +static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi, u8 *buffer_spd, size_t bufsz_spd,
> > > +				    u8 *buffer_avi, size_t bufsz_avi,
> > > +				    struct drm_display_mode *mode)
> > >   {
> > > -	struct hdmi_audio_param *aud_param = &hdmi->aud_param;
> > > -
> > > -	hdmi->csp = HDMI_COLORSPACE_RGB;
> > > -	aud_param->aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
> > > -	aud_param->aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
> > > -	aud_param->aud_input_type = HDMI_AUD_INPUT_I2S;
> > > -	aud_param->aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
> > > -	aud_param->aud_mclk = HDMI_AUD_MCLK_128FS;
> > > -	aud_param->aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
> > > -
> > > -	return 0;
> > > +	mtk_hdmi_setup_avi_infoframe(hdmi, buffer_avi, bufsz_avi, mode);
> > > +	mtk_hdmi_setup_spd_infoframe(hdmi, buffer_spd, bufsz_spd, "mediatek", "On-chip HDMI");
> > 
> > Please use the HDMI Connector framework instead of handling everything
> > on your own.
> > 
> 
> Dmitry, my plan is to get the MediaTek HDMIv2 driver upstreamed *with* using
> the HDMI helpers - this commit is only splitting the old HDMI v1 driver in
> common parts and v1 handling.
> 
> This "handling everything on my own" is something that was already present
> into the old v1 driver, I am *not adding* this code, but *moving it around*.
> 
> I cannot migrate the v1 driver to the HDMI helpers right now because in this
> moment I have no way to test that and I don't want to break any functionality.
> 
> If you check patch 15, you'll see that I am indeed using all of the helper
> goodies - but for now only on the new driver, and not on the old one.
> 
> I do plan to migrate the v1 driver to the new helpers as well, but I would
> (please) really prefer to do that only after the v2 driver is upstreamed.
> 
> Is that okay for you?

Yes, I've sent this comment before seeing the last patches.

> 
> Cheers,
> Angelo
> 
> > >   }
> > >   static void mtk_hdmi_audio_enable(struct mtk_hdmi *hdmi)
> > 
> 
> 
> 

-- 
With best wishes
Dmitry

