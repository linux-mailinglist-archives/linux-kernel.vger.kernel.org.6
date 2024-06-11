Return-Path: <linux-kernel+bounces-210602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B5904614
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13EB2821C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C3152E12;
	Tue, 11 Jun 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgCEP1iu"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258A15217D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140219; cv=none; b=FiNIajWEQ4PGNxrwbNkv6Dfih8KPGXAadRcPx2lwlOtIR6LtokkzarzXktwVFTbFUxHdAcdqCcdKA8aWvEdOn3GMYOHbwxvQGn+csGmLR+zW8Gmk3ErptcXNwOsCbp3AwahE2R5stJAmSrb6w4238TGht6KBm1unshlZ6clTJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140219; c=relaxed/simple;
	bh=H2bjtgyCCTGP9h/g8cK79eMCtM0/pm01XHMByNU5ISA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueh/eYOq9yXV2Qv4D1zFC/NiSffdmZNLmZUwKuykBYl5hMf5j9zDXSZ+01rk/OwD3HUgqYfAjnJSWx5tsBB3vfl+h8Zv68hayZPKQe0RfFGOWrKxzmM26P1QJbvSzvOW8N9XLoufBjLVQ0LilKtHntgZ3X/TT05phku0u0Njdak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgCEP1iu; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc0a9cea4so255406e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718140215; x=1718745015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vvb72CkTXBjOFPbVlT36y7EQaQLAOeTkMGyEG4xcuiM=;
        b=mgCEP1iu652SbUlKV/PQMG/ggbQJ9vCM1H+lz26OcNPuo7a6JCtgWcfYO2MIj3uhsC
         OV0LTvn13wNlHlwOi7myjBrgMeXeLEdq1S+PTwEACbcVxhCM9M9jFx1/A0eQDN86JN7Q
         jRs7GTwcgqND85hUL73Rh1JI3RYwXsW1I9WdHok1p1Nd4FaZI3JKgt1Lv2cbFvzTdzPb
         MoW3MHbCJo4/T+OYkYkNEnmbCzAvjlBtL0h6pG6P2cD6WjPr+mf4pGYb54UKOHCs+E/J
         ysulI3QDjTwIoH/rOLySSZIJjrum1QNSnw6q+VKPDLGkTd0oIN54+EUn4uD1eDCxvL3a
         mzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140215; x=1718745015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvb72CkTXBjOFPbVlT36y7EQaQLAOeTkMGyEG4xcuiM=;
        b=AE9XUTPJyy2oAez+4e8EDO0vM36ldWPFUWy9B/0aA412cIpKhnH3tgyP8XT45+JSqU
         Wk3yQHBBcBpe2390Sfpzb6E6DKENN1wnYcKQx6eT6ImfjaE4CDCMZQtyugiMRRpjIbfA
         erwwZEU7ttYlCkfQ8vAq4ksC8xKqxOiQ+5KhHzO6fBOVTcMIQd1VhfNsL/qGYp/TRD7X
         4rf8vZA6isyk8qebiTFtM7oA/fer3TWRPYn6DfFXLX/reJYDHlXL7WUhVJqdMYNxG2ll
         TD8XTLyw/QRGQ5huqGhc2U4zLF388Y537JU2TINA7xSyhbeiXVKzl5Q/B5xbfOd1Afo/
         ew9w==
X-Forwarded-Encrypted: i=1; AJvYcCVx4+1vS0STVtPuS0QV9f+xz3hrQqZHRpEiF5mQk9eReF1t9PrajC+3Tn82j5Up2I/Rg4FmFMkK82KIv7JxkblcL0I6c6ueLiMSY0qp
X-Gm-Message-State: AOJu0YzZwJm2cDLzEP3O8o3iTaz46Eyu+CZqJpEYWSuTfEynARlU6b/A
	mnTzW2Xwj3D+eaEzlBbcHqGm7aayX7LlfguIZ7StbMZKgfKEVv2ZZOC4q+G7uBg=
X-Google-Smtp-Source: AGHT+IHqsaavvJAW1+fikYT/YA1pmPPdv6h5QRKcLuBt8Q4exkTuAhKfJX1A7n0hfkuySR9Qi31/2A==
X-Received: by 2002:ac2:43ab:0:b0:52b:92b0:8015 with SMTP id 2adb3069b0e04-52c9a0c59cdmr28658e87.9.1718140215393;
        Tue, 11 Jun 2024 14:10:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8ebd0572sm899430e87.166.2024.06.11.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 14:10:14 -0700 (PDT)
Date: Wed, 12 Jun 2024 00:10:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel : truly-nt35521: transition to mipi_dsi
 wrapped functions
Message-ID: <uhnjrzii3ydzdsnhc54sbglpy46drzwg2m6if5ymid7gjabcvd@ppzdg6xz4xx7>
References: <3288287d-8344-4b37-a333-722cf12fef13@gmail.com>
 <CAD=FV=XRuU=eh0HzbDCwFrr5h9s-rOdB5dbANAd-BmMhiHR6Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XRuU=eh0HzbDCwFrr5h9s-rOdB5dbANAd-BmMhiHR6Ww@mail.gmail.com>

On Tue, Jun 11, 2024 at 08:57:48AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 11, 2024 at 7:44 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
> >
> > Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
> > mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> > ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> > sony tulip truly nt35521 panel.
> >
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> >
> > Changes in v2:
> >     - Fix patch format
> >     - Fix code style
> >
> > v1: https://lore.kernel.org/all/485eef24-ddad-466a-a89f-f9f226801bb7@gmail.com/
> >
> > ---
> >  .../panel/panel-sony-tulip-truly-nt35521.c    | 435 +++++++++---------
> >  1 file changed, 209 insertions(+), 226 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> > index 6d44970dccd9..5a050352c207 100644
> > --- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> > +++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> > @@ -44,248 +44,231 @@ static void truly_nt35521_reset(struct truly_nt35521 *ctx)
> >  static int truly_nt35521_on(struct truly_nt35521 *ctx)
> >  {
> >         struct mipi_dsi_device *dsi = ctx->dsi;
> > -       struct device *dev = &dsi->dev;
> > -       int ret;
> > +
> > +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
> 
> It's not a huge deal, but normally in the kernel all the variable
> declarations are cuddled together. AKA no blank line between the
> declaration of "dsi" and the declaration of "dsi_ctx". It would be
> awesome if you could send a v3 fixing that. When you send v3, feel
> free to add this above your own Signed-off-by:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ...with that, the patch will probably sit on the mailing lists for a
> week or two and then get applied. Neil may want to apply it, but if
> he's busy I can do it too.
> 
> I believe you were planning on tackling some more of the panels. Since
> you're still getting started sending patches, maybe keep it to a
> smaller batch for now and send another 10 or so? Probably best to keep
> it as one panel driver per patch.
> 
> -Doug

Do we want to delay this until the mipi_dsi_msleep() is fixed?


-- 
With best wishes
Dmitry

