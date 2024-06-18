Return-Path: <linux-kernel+bounces-219037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42690C965
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AE6B2971F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05A139D13;
	Tue, 18 Jun 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cw45v3lG"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0254724
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705759; cv=none; b=nOm57bDXPOD/Y8rUe3tIdpUb3w8KK98ZGoQXaiSK5WtVSW3bRgC+fqShzjE8lswTfabLtwCnadbejL0S/H05YkG5fnb6LdK/dOiq9gFc9jm+y4KRBT2XF3LSc1LQkKcRFLCdC5J5wy3ETYWuG059GI2quE/no7jePthaRs4rl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705759; c=relaxed/simple;
	bh=NIdZ2bTKasH+nk1kkXDFEdLvkov1+pEV1h3fA2Sb+PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7BGPHlt+IpHHxNhRHBUDu4bb2sncctp+46/A9KwOmYqBJYEMwyxU6d3YQ+Jre7CC2Atd25X1q0SyrTTXGLJ1wKJB6bKWKiEJxJrZeHuoUlA/QFEj/HZQ++T8n5jDC6QtUyFO/fnlES973JHNx0/5vclTnjmL8lz/bjWLUOrrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cw45v3lG; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so5004878276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705756; x=1719310556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XhPNLiHLoa3orzHyeJcCWczzW2ldawXh2vT5fW5oe5g=;
        b=cw45v3lGwh9ibs+BkVPS8XNLTjdmsHttYcOvH1/JB0BK1X4qkdBFWTd5h9/JffK2Q4
         bMqkZCM4cz00gi4b/5raWUhPKZpvwm4dwe+Yp8T0732mA8/rOzrH/1Z0jl6sLZwTJx7e
         Vx6TwaoxOSGY/zBrrV/rL7oI7+1/t90uXcdBQewh094KVaGVZ/OxmpJC77u7D0VMFTBW
         TYV9WZJetl2us1GcNBaa9LUeabSNQTQ9NZFZ8whSHnyuF+iXTcGYhFHAbWrALnhBY9L1
         RAIZw3zkMvbHKNBq8Camt63WaMRgILFnXQ11daDlQ2M9PWIMERTJXvLEDVwfxhVN4mhr
         cWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705756; x=1719310556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhPNLiHLoa3orzHyeJcCWczzW2ldawXh2vT5fW5oe5g=;
        b=vPLaQjq+XtzGm080Z31cEBFx8uxWBzcaHIB6Wb+riTrkIc5qzB2YUMsqRagEVbrD2l
         GTuh/S7aRF+eEPMOOvdHfhl+dbu1eozCR17lUMbK0EdkrnMzB7kobDDqFVr0MOUCXH32
         ELnIqd4P0RekOLNwC8stJwpnE5GZ9sn6Jv0G8byDVCvsJGy6h3+LYjE5p2QC/9Du7Lme
         rBf6xpZOnYwxQtCgl6EAtwiUDbXBbQbDmuGaIzggtmf2qRYx32GQkrbrdpw1ucbCvCqA
         l/NG/J1ncBy5qfX8Ab8HxZjL+YSzKuFA8mNQx9M1Qcaxe4CijXcGvAsihmBlO4Q6O9+U
         skiw==
X-Forwarded-Encrypted: i=1; AJvYcCW+3CXsp0otuohKkH5tT9+62UGwlEYC+tvwTTQYg7LHpVGUsnyd0rFUON9tX7PfQZQ4m2PWeLBkIz2kLNlc6GbPUx+8pbS5q8XppYZ7
X-Gm-Message-State: AOJu0YxL5s4D9BpS2P4n6e0q6bCw4LocX5xvkNcp5H61vFwvKvsqd5Ew
	rNPCt2pyppNGry/PtM5EGTZe9KoVPwyoFAb6J9RUlm5InNE13B4kP2DyNzEY/Fmk3K7dRLssYo/
	eVBULxxVHLBrhpVPbsIIo7HaMbus7T5HzPcqNxA==
X-Google-Smtp-Source: AGHT+IEsv7IfYeMsArzBejH8niE9nZt3hfwkV12Dx+vdDglKTjgIuNRzw5dNj2kD/OX+usllX3TQnPLf/mPK46iUQlw=
X-Received: by 2002:a05:6902:11cc:b0:dff:310b:9b40 with SMTP id
 3f1490d57ef6-dff310b9ea5mr8048320276.45.1718705756426; Tue, 18 Jun 2024
 03:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618081418.250953-1-j-choudhary@ti.com> <20240618081418.250953-2-j-choudhary@ti.com>
 <r5szraxdqfs4v4hnvqgx6tbmc5e5ew5ljyf5xlaobywm55bohy@6kygxenn2tvd> <e236648c-e257-42a3-a0a3-a1b88b539459@ti.com>
In-Reply-To: <e236648c-e257-42a3-a0a3-a1b88b539459@ti.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 18 Jun 2024 13:15:45 +0300
Message-ID: <CAA8EJprX0ePM1Xvmo9DahSFAnADRPBuwVo95A423xeffgpr49w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: ti-sn65dsi86: Add atomic_check hook
 for the bridge
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: dianders@chromium.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, spanda@codeaurora.org, a-bhatia1@ti.com, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 12:56, Jayesh Choudhary <j-choudhary@ti.com> wrote:
>
> Hello Dmitry,
>
> Thanks for the review.
>
> On 18/06/24 14:29, Dmitry Baryshkov wrote:
> > On Tue, Jun 18, 2024 at 01:44:17PM GMT, Jayesh Choudhary wrote:
> >> Add the atomic_check hook to ensure that the parameters are within the
> >> valid range.
> >> As of now, dsi clock freqency is being calculated in bridge_enable but
> >> this needs to be checked in atomic_check which is called before
> >> bridge_enable so move this calculation to atomic_check and write the
> >> register value in bridge_enable as it is.
> >>
> >> For now, add mode clock check for the max resolution supported by the
> >> bridge as mentioned in the SN65DSI86 datasheet[0] and dsi clock range
> >> check for SN_DSIA_CLK_FREQ_REG.
> >> According to the datasheet[0], the minimum value for that reg is 0x08
> >> and the maximum value is 0x96. So add check for that.
> >>
> >> [0]: <https://www.ti.com/lit/gpn/sn65dsi86>
> >>
> >> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> >> ---
> >>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 65 +++++++++++++++++++--------
> >>   1 file changed, 46 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >> index 84698a0b27a8..d13b42d7c512 100644
> >> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >> @@ -113,6 +113,20 @@
> >>
>
> [...]
>
> >>
> >> +static int ti_sn_bridge_atomic_check(struct drm_bridge *bridge,
> >> +                                 struct drm_bridge_state *bridge_state,
> >> +                                 struct drm_crtc_state *crtc_state,
> >> +                                 struct drm_connector_state *conn_state)
> >> +{
> >> +    struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
> >> +    struct drm_display_mode *mode = &crtc_state->mode;
> >> +    unsigned int bit_rate_mhz, clk_freq_mhz;
> >> +
> >> +    /* Pixel clock check */
> >> +    if (mode->clock > SN65DSI86_MAX_PIXEL_CLOCK_KHZ)
> >> +            return -EINVAL;
> >> +
> >> +    bit_rate_mhz = (mode->clock / 1000) *
> >> +                    mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> >> +    clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
> >> +
> >> +    /* for each increment in dsi_clk_range, frequency increases by 5MHz */
> >> +    pdata->dsi_clk_range = (MIN_DSI_CLK_FREQ_MHZ / 5) +
> >> +            (((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
> >
> > atomic_check might be called several times, it might be called to test
> > the state. As such, it should not modify anything outside of the
> > state variables.
> >
>
> If not in atomic_check, then where should I move this calculation and check?
> mode_valid with returning MODE_BAD in case of failure?

I didn't write that it's the wrong place for math. I wrote that you
should not be modifying global structure.

So you have to subclass drm_bridge_state for the driver and store the
value there. Or just add a helper function and call it from
atomic_check(), mode_valid() and set_dsi_rate(). It really looks like
a simpler solution here.

Note, there is a significant difference between mode_valid() and
atomic_check(). The former function is used for filtering the modes,
while the latter one is used for actually checking that the parameters
passed from the client are correct.

>
> I had to move it from bridge_enable based on the comments on v1:
> https://patchwork.kernel.org/project/dri-devel/patch/20240408073623.186489-1-j-choudhary@ti.com/#25801801
>
> Warm Regards,
> Jayesh
>
> [...]



-- 
With best wishes
Dmitry

