Return-Path: <linux-kernel+bounces-176270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2928C2C92
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F38F282EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12113D29A;
	Fri, 10 May 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhYoHmnv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47113D269
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379785; cv=none; b=TnWEvJ5oKtEHQg1Hw5V2429tZXXJlrq0fHnFwRm7KZcDZjIIIjGWT3e8PIs5TR7KJM3DzVsf/51s/04Mts2GkqPKa2nypaDFQRQ5nlcm2eOvKax3175dybWaK8IZwLDzRnBswIQWo4s7nRtutsHh17olYlwsdPzhRyl4/dLIQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379785; c=relaxed/simple;
	bh=eCdUarSfFLXkDc/5ly1Nzd9KnHDS3kjXw/0YlB+bbkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvKJOIxCz9/U53fWcXxgcPbnYx8AcRDVX9lEyQvfSV2uRMA6cfnOsaG65t0qTtnaRTXKMh2zvoaioHsljVRWMuGRn522djBQa4HxhZ5HpUbrsZwmJrXFb/2mMPwbNVq8kJ0Aa3vwdQf3deIoGJI+USRSFxCYJQpWIoLNQKbLw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bhYoHmnv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso3194201e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715379781; x=1715984581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G0Uyr1pN8k/ARGpxhDyBbiCgjg0OynDBUphzu3LkFrg=;
        b=bhYoHmnv/VtxKWKT63dCjIgFTujPR61ImSF7pW+XF+8g6ud0drxpBEalGuvnWUq0tl
         nrcI9FhxlxE2JpCz+IFXNH9aR+QM0aUUGHhHnRo3Z9illnnem2jek/6J6hJPkrCxeVLl
         XfHBsiUVFD4C2Vqk/+e1IXHtsrkX0lHAWcxAfuwvLWTWF4dDRhrWH8id7ujmorQGgX6M
         XTgMsM9uL2PLMq6dt2gsrmWx82xGZSsDFcsuw8wUWEHi0zcL3nAJRcPeUCqAvO/ugnxU
         Jq6dxDUx4eJN95bZTMVneJ0D1k0y8S3GnDajbkTcuxFoKVCH/dNqybvfPxJxgW/OdWyP
         8apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379781; x=1715984581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0Uyr1pN8k/ARGpxhDyBbiCgjg0OynDBUphzu3LkFrg=;
        b=v3ksf/KYKIuGdf3UNB/yIzPwoGzRfAs9dhqHWNPXtnCBhQkBOJSktXJmCLgR0mK8Yf
         Zz7vbUq4EEC3txvJ/8ay+qtZLUCY0zn4bft/RD+I8BmCseZZKIG5cQ0qre5VOwTwwFDE
         0K9v5BumYNiQ35JOkb9U4ieBvs7MNy85pqlvM+vC8dG1Ibj6PwsfhM1aKhuJJxRr/tFL
         w4UTJEdOeX6GriHlWfABqjNzhr+DcRelDVzw3z2QKercFsYFiTXnivQnf1T+c8e01bb6
         3xjbHFMobfFgWgla5HKIXcSFCucbIWR6Qc+5euqGd+/y0GmQsSjMlLmOyfNBPJfQzPB5
         vcdw==
X-Forwarded-Encrypted: i=1; AJvYcCXLGOVVG1gFNTYdJq76r45M15++j0C4DoKyujbqMbkoS2ERaB8ORYBHA6Q8U3PAitrD9mgoHG/H9M2Uw0WxY0ALfGtwtBC/WlrHDCUP
X-Gm-Message-State: AOJu0YynogbJFGz4PcbMtuBMx4dz0se0myQIndp7e0jrEKw8A3j+9tzr
	4bTMEO38wbXrtverctLE93YJvNwGbQ8r43hfnKsM8O3mCAotGGTr3/1ypeS0zUw=
X-Google-Smtp-Source: AGHT+IF1IRH4d76n4pNOyKYDdO40mH/uIs2el/Qhpb/0zJQWJsLL3MOXUVp9zI7G4e8SrdOea3SYfg==
X-Received: by 2002:a19:2d07:0:b0:522:e58:86b3 with SMTP id 2adb3069b0e04-5220fc6d53emr2348194e87.36.1715379780683;
        Fri, 10 May 2024 15:23:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2db3sm832202e87.269.2024.05.10.15.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:23:00 -0700 (PDT)
Date: Sat, 11 May 2024 01:22:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] drm/mipi-dsi: wrap more functions for streamline
 handling
Message-ID: <3ooczfup63gjhuphlujaq26ggo4rasu6c5j2ki3avzxs5wgcqn@lx55p76myvpn>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
 <20240510-dsi-panels-upd-api-v1-1-317c78a0dcc8@linaro.org>
 <CAD=FV=UuJF5Nv6qLzH8SK8NPfHa6Qwp4XOwkLUYt2Rv8ACjfeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UuJF5Nv6qLzH8SK8NPfHa6Qwp4XOwkLUYt2Rv8ACjfeQ@mail.gmail.com>

On Fri, May 10, 2024 at 02:45:45PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 9, 2024 at 3:37 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > +/**
> > + * mipi_dsi_compression_mode_ext() - enable/disable DSC on the peripheral
> > + * @ctx: Context for multiple DSI transactions
> > + * @enable: Whether to enable or disable the DSC
> > + * @algo: Selected compression algorithm
> > + * @pps_selector: Select PPS from the table of pre-stored or uploaded PPS entries
> > + *
> > + * Like mipi_dsi_compression_mode_ext_multi() but deals with errors in a way that
> > + * makes it convenient to make several calls in a row.
> 
> Your comment is backward. The name of the function is

True, my bad.

> mipi_dsi_compression_mode_ext_multi() not
> mipi_dsi_compression_mode_ext(). ...and it's like
> mipi_dsi_compression_mode_ext() not like
> mipi_dsi_compression_mode_ext_multi().
> 
> 
> > @@ -338,6 +345,18 @@ int mipi_dsi_dcs_set_display_brightness_large(struct mipi_dsi_device *dsi,
> >  int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
> >                                              u16 *brightness);
> >
> > +void mipi_dsi_dcs_nop_multi(struct mipi_dsi_multi_context *ctx);
> > +void mipi_dsi_dcs_enter_sleep_mode_multi(struct mipi_dsi_multi_context *ctx);
> > +void mipi_dsi_dcs_exit_sleep_mode_multi(struct mipi_dsi_multi_context *ctx);
> > +void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *ctx);
> > +void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ctx);
> > +void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
> > +                                   enum mipi_dsi_dcs_tear_mode mode);
> > +
> > +#define mipi_dsi_msleep(ctx, delay)    \
> > +       if (!ctx.accum_err)             \
> > +               msleep(delay)           \
> 
> Please enclose the above in a "do { ... } while (0)" as typical for
> macros. Otherwise you could possibly get some very surprising
> behavior:

Ack.

> 
> if (needs_big_delay)
>   mipi_dsi_msleep(ctx, 50)
> else
>   mipi_dsi_msleep(ctx, 10)
> 
> ...with your macro as it is I think the "else" will match up against
> the "if !(ctx.accum_err)" inside the macro and not against the "if
> (needs_big_delay)"
> 
> Also: nit that the mipi_dsi_msleep() should probably be defined above
> the "mipi_dsi_dcs" section.
> 
> 
> -Doug

-- 
With best wishes
Dmitry

