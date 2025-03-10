Return-Path: <linux-kernel+bounces-555021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE61A5A492
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E77A67AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9911DDC07;
	Mon, 10 Mar 2025 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJjd7WuS"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024141CB332
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637700; cv=none; b=fHM82kWi7cpSbEBkzOdn+eDNPttQLBKPIo6Jla+YqZCufdhoiKnNhCx3MywfLd45lc6yrBFf+jEmZFz9elEVQBeQJ9heVydqleWrxt2C1N6c9la/GfSBSuP1WfjgwCiZUQrN1VdhkskOm1tZb7UjafdW2J8pLMCQdOtw3Fl2byU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637700; c=relaxed/simple;
	bh=ry/+85ZmYTRdlqLAhzTZeWNOPlc1un8Ml0iI/c/OYgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVNAfF/vCPKjUSeUFK/nYug39YHxucRWFAa5hY6da6VZpx7YzMchaWwocvsazLBwJ4GZv4ix8bubSlVzD4fmj4Y/MEfo/7L42pSCZ6Nnp62Nk7bbFO73QMiKykAhsemPGG7j+V7+uQ5HR++OytlAL+h94kL919BNvkMASAo77uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJjd7WuS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so5566762e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741637696; x=1742242496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9ZJhe15SI2R1lxy0woL42QmbLTLLNcrjryXpvdsrm0=;
        b=aJjd7WuSKSuvvjMagZG7wD6TkRcZfBllXG6zESDz55BC6wOp9jk7UFL15txkl6vJ2O
         d3VCDn819hSt1kHdOuqpYgmfaGVHgYc9bKiWU1u7yyVlKhx6bzr8qotS7g1NZANZ37q5
         KzYV/WI6b+x3U1KAD8SFYlqhmGbtZ7QjWnD/lsZfDPsNvLJfhhJ0Udtfo/5+ozV+Wfnf
         AuN2mfF00bMs3T/dl+hTXUmpCQUqJPoINLW+VePLlA3rjAv7IAlGDq6GXVNAj2ig+xbw
         bQ0uhPcsnvIXcbVd8RLTGSLBafZi2JjlCohS3TVWptmWjPeshfxh06I2PeGMAnwXK5wM
         qSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637696; x=1742242496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9ZJhe15SI2R1lxy0woL42QmbLTLLNcrjryXpvdsrm0=;
        b=H+EpLaUuy1CflDdGWL+m2HLFF4JLnX4WZTm3sq8PrLDXyQvuJmqfeETkpq9mk19lHU
         qcbnq0TlsQDC3AeDr3qkZ1QUbzN+i38Ywc9PlI4xO7CDfJa6/ibLqrLc/t+ghTAkSf6u
         33SJ9xthZ/09oXyqemf85T1vdK93qs8m3zPYZYK+mF4pNyBuz6lmqNQ+eSONgM6fGwjb
         cMFvWjoy3K4EKFBocxAc2Ab9aG9E/4DlCUOTj5ytWPNvTKj7I77YF5PFlabNWP1q7s0W
         QvciYHZvy/fdnpCNUL5Ayiq8QMt8CFJpXeoNFew3JnusU3/M+ozPcWFQ8VumXnTxZIG7
         AyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZLpRNJ8Atca3Ks+3NmIPKVo3vcRGRgkWW3zqepnEwJy8cT+zmxr02uw/1Q0qNvJ1V91kZ6BPwNQNwnXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgxNThulNwWm/5WP4AUTJXZCDOoI+fwtCSJdvxRol9wdHR+yJb
	uhwiFSSAdo9qCTHl1kiwXqQzf5xF/bBbxrlsXDmMzUW11Ve/A06L6Sr5HHpb/H8=
X-Gm-Gg: ASbGnct4eAV/i5FYawgqBEBGpfdt19ZH1Vx9GldoZ+ne//ec1n1bjvQImcpeKKKfWjH
	bmzlBsOnL57LbmM+h1R7JvrZVMeB+ZeXbjOS1FdptZ0EL2Xk7CUYhS/x1jYSiFLgAf8TWZtqDb2
	vXQq623cZsBpsPKSPgfIe0YVqnwmuNoZ7qMs5llqAWUoP7BsroKwWdU3VhKnp/Ks5enkkjBOW/j
	U8r7txnc0SzTcWVRoofBveKfz1KRujBa3ROvJPt9tFVOyk6U/skNF+r0GHPEbBwoJJyB64DuytZ
	T+NmA8V4ba0xskyHyXjuNDJimJyHZ8t0ldoLFBvNEIw0dfmAoUKJz8BHTRuonU94vSdBDzfJQXY
	/WwPK20WH2mtNg8TCa/GJy8rg
X-Google-Smtp-Source: AGHT+IGctet0tbvnmmVPz/oI5Fqb6I+mucDKMgJv9axzwjfvPetRICONErkndHiBh4Y5t/R08GW8iA==
X-Received: by 2002:a05:6512:3ba5:b0:549:4e78:9ed7 with SMTP id 2adb3069b0e04-549910d0e7bmr5230788e87.49.1741637695928;
        Mon, 10 Mar 2025 13:14:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c29adsm1554207e87.215.2025.03.10.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:14:55 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:14:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/4] drm/display: hdmi: provide central data authority
 for ACR params
Message-ID: <bensvtxc67i566qqcjketdlffyrwxcnydwarqyjau6b7ibcq4b@d6d4sbm3rubf>
References: <20250309-drm-hdmi-acr-v1-0-bb9c242f4d4b@linaro.org>
 <20250309-drm-hdmi-acr-v1-1-bb9c242f4d4b@linaro.org>
 <20250310-funny-malamute-of-promotion-bb759e@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-funny-malamute-of-promotion-bb759e@houat>

On Mon, Mar 10, 2025 at 03:46:33PM +0100, Maxime Ripard wrote:
> On Sun, Mar 09, 2025 at 10:13:56AM +0200, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > HDMI standard defines recommended N and CTS values for Audio Clock
> > Regeneration. Currently each driver implements those, frequently in
> > somewhat unique way. Provide a generic helper for getting those values
> > to be used by the HDMI drivers.
> > 
> > The helper is added to drm_hdmi_helper.c rather than drm_hdmi_audio.c
> > since HDMI drivers can be using this helper function even without
> > switching to DRM HDMI Audio helpers.
> > 
> > Note: currently this only handles the values per HDMI 1.4b Section 7.2
> > and HDMI 2.0 Section 9.2.1. Later the table can be expanded to
> > accommodate for Deep Color TMDS char rates per HDMI 1.4 Appendix D
> > and/or HDMI 2.0 / 2.1 Appendix C).
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_helper.c | 164 ++++++++++++++++++++++++++++++
> >  include/drm/display/drm_hdmi_helper.h     |   6 ++
> >  2 files changed, 170 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > index 74dd4d01dd9bb2c9e69ec1c60b0056bd69417e8a..89d25571bfd21c56c6835821d2272a12c816a76e 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > @@ -256,3 +256,167 @@ drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> >  	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
> >  }
> >  EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> > +
> > +struct drm_hdmi_acr_n_cts_entry {
> > +	unsigned int n;
> > +	unsigned int cts;
> > +};
> > +
> > +struct drm_hdmi_acr_data {
> > +	unsigned long tmds_clock_khz;
> > +	struct drm_hdmi_acr_n_cts_entry n_cts_32k,
> > +					n_cts_44k1,
> > +					n_cts_48k;
> > +};
> > +
> > +static const struct drm_hdmi_acr_data hdmi_acr_n_cts[] = {
> > +	{
> > +		/* "Other" entry */
> > +		.n_cts_32k =  { .n = 4096, },
> > +		.n_cts_44k1 = { .n = 6272, },
> > +		.n_cts_48k =  { .n = 6144, },
> > +	}, {
> > +		.tmds_clock_khz = 25175,
> > +		.n_cts_32k =  { .n = 4576,  .cts = 28125, },
> > +		.n_cts_44k1 = { .n = 7007,  .cts = 31250, },
> > +		.n_cts_48k =  { .n = 6864,  .cts = 28125, },
> > +	}, {
> > +		.tmds_clock_khz = 25200,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 25200, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 28000, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 25200, },
> > +	}, {
> > +		.tmds_clock_khz = 27000,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 27000, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 30000, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 27000, },
> > +	}, {
> > +		.tmds_clock_khz = 27027,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 27027, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 30030, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 27027, },
> > +	}, {
> > +		.tmds_clock_khz = 54000,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 54000, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 60000, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 54000, },
> > +	}, {
> > +		.tmds_clock_khz = 54054,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 54054, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 60060, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 54054, },
> > +	}, {
> > +		.tmds_clock_khz = 74176,
> > +		.n_cts_32k =  { .n = 11648, .cts = 210937, }, /* and 210938 */
> > +		.n_cts_44k1 = { .n = 17836, .cts = 234375, },
> > +		.n_cts_48k =  { .n = 11648, .cts = 140625, },
> > +	}, {
> > +		.tmds_clock_khz = 74250,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 74250, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 82500, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 74250, },
> > +	}, {
> > +		.tmds_clock_khz = 148352,
> > +		.n_cts_32k =  { .n = 11648, .cts = 421875, },
> > +		.n_cts_44k1 = { .n = 8918,  .cts = 234375, },
> > +		.n_cts_48k =  { .n = 5824,  .cts = 140625, },
> > +	}, {
> > +		.tmds_clock_khz = 148500,
> > +		.n_cts_32k =  { .n = 4096,  .cts = 148500, },
> > +		.n_cts_44k1 = { .n = 6272,  .cts = 165000, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 148500, },
> > +	}, {
> > +		.tmds_clock_khz = 296703,
> > +		.n_cts_32k =  { .n = 5824,  .cts = 421875, },
> > +		.n_cts_44k1 = { .n = 4459,  .cts = 234375, },
> > +		.n_cts_48k =  { .n = 5824,  .cts = 281250, },
> > +	}, {
> > +		.tmds_clock_khz = 297000,
> > +		.n_cts_32k =  { .n = 3072,  .cts = 222750, },
> > +		.n_cts_44k1 = { .n = 4704,  .cts = 247500, },
> > +		.n_cts_48k =  { .n = 5120,  .cts = 247500, },
> > +	}, {
> > +		.tmds_clock_khz = 593407,
> > +		.n_cts_32k =  { .n = 5824,  .cts = 843750, },
> > +		.n_cts_44k1 = { .n = 8918,  .cts = 937500, },
> > +		.n_cts_48k =  { .n = 5824,  .cts = 562500, },
> > +	}, {
> > +		.tmds_clock_khz = 594000,
> > +		.n_cts_32k =  { .n = 3072,  .cts = 445500, },
> > +		.n_cts_44k1 = { .n = 9408,  .cts = 990000, },
> > +		.n_cts_48k =  { .n = 6144,  .cts = 594000, },
> > +	},
> > +};
> > +
> > +static int drm_hdmi_acr_find_tmds_entry(unsigned long tmds_clock_khz)
> > +{
> > +	int i;
> > +
> > +	/* skip the "other" entry */
> > +	for (i = 1; i < ARRAY_SIZE(hdmi_acr_n_cts); i++) {
> > +		if (hdmi_acr_n_cts[i].tmds_clock_khz == tmds_clock_khz)
> > +			return i;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * drm_hdmi_acr_get_n_cts() - get N and CTS values for Audio Clock Regeneration
> > + *
> > + * @tmds_char_rate: TMDS clock (char rate) as used by the HDMI connector
> > + * @sample_rate: audio sample rate
> > + * @out_n: a pointer to write the N value
> > + * @out_cts: a pointer to write the CTS value
> > + *
> > + * Get the N and CTS values (either by calculating them or by returning data
> > + * from the tables. This follows the HDMI 1.4b Section 7.2 "Audio Sample Clock
> > + * Capture and Regeneration".
> > + */
> 
> I think we need to make it clear that it's for L-PCM only (I think?),
> either through a format parameter or through the documentation.

Ack

> 
> > +void
> > +drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
> > +		       unsigned int sample_rate,
> > +		       unsigned int *out_n,
> > +		       unsigned int *out_cts)
> 
> And we should probably take the connector (or EDID) to make sure the
> monitor can support the format and sample rates.

Interesting perspective, I'll give it a thought. I was really just
trying to get rid of the duplication.

I think that 'supported' parts should be implemented in the hdmi-codec
instead, parsing the ELD and updating hw constraints. WDYT?

> 
> > +{
> > +	/* be a bit more tolerant, especially for the 1.001 entries */
> > +	unsigned long tmds_clock_khz = DIV_ROUND_CLOSEST_ULL(tmds_char_rate, 1000);
> > +	const struct drm_hdmi_acr_n_cts_entry *entry;
> > +	unsigned int n, cts, mult;
> > +	int tmds_idx;
> > +
> > +	tmds_idx = drm_hdmi_acr_find_tmds_entry(tmds_clock_khz);
> > +
> > +	/*
> > +	 * Don't change the order, 192 kHz is divisible by 48k and 32k, but it
> > +	 * should use 48k entry.
> > +	 */
> > +	if (sample_rate % 48000 == 0) {
> > +		entry = &hdmi_acr_n_cts[tmds_idx].n_cts_48k;
> > +		mult = sample_rate / 48000;
> > +	} else if (sample_rate % 44100 == 0) {
> > +		entry = &hdmi_acr_n_cts[tmds_idx].n_cts_44k1;
> > +		mult = sample_rate / 44100;
> > +	} else if (sample_rate % 32000 == 0) {
> > +		entry = &hdmi_acr_n_cts[tmds_idx].n_cts_32k;
> > +		mult = sample_rate / 32000;
> > +	} else {
> > +		entry = NULL;
> > +	}
> > +
> > +	if (entry) {
> > +		n = entry->n * mult;
> > +		cts = entry->cts;
> > +	} else {
> > +		/* Recommended optimal value, HDMI 1.4b, Section 7.2.1 */
> > +		n = 128 * sample_rate / 1000;
> > +		cts = 0;
> > +	}
> > +
> > +	if (!cts)
> > +		cts = DIV_ROUND_CLOSEST_ULL(tmds_char_rate * n,
> > +					    128 * sample_rate);
> > +
> > +	*out_n = n;
> > +	*out_cts = cts;
> > +}
> 
> EXPORT_SYMBOL?

Yes, I forgot it.

> 
> Also, I'd really like to have some unit tests for this. Not for all the
> combinations, obviously, but testing that, say, 44.1kHz with a 148.5 MHz
> char rate works as expected, and then all the failure conditions
> depending on the monitor capabilities.

Ack for the tests. For the monitor capabilities, let's finish the
discussion above first.



-- 
With best wishes
Dmitry

