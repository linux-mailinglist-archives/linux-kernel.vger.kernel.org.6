Return-Path: <linux-kernel+bounces-387613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1039B53A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E971C227E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130620896A;
	Tue, 29 Oct 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiVS2gzL"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128A2076CE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233515; cv=none; b=TIMvsU3OfeatrGFJ/IMsEp87eVrL3UPhULg/npmpHK7ip0AznmM6F14L9lAD/ApRRQa7Iz0Z9OPzHgzbYSttxd5ngTgSIN4CH/t93jlIA1BjLCctVo73tg139odIFPUVSo4xOqpxXAvvs/qAe8s6dqC6fXX0z+44ub75tX9EZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233515; c=relaxed/simple;
	bh=Cdq5WzIzYiSL79xJC9IxPZpy+THtLin3kptHx+ymums=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8IEyXB7W5IX9wBPfDJOxoEYfQMifHPbUfMSi4MjakmrEnmc9QhShZQSjYZrcRTN2GpBPYztzfQIfaIeek9q8mmq1C0k5JMSPEE95sQtvKCrZBjMPxqag2MTeyI5iWHbGrYSfT+MIyk4+WjUNQ0HKy+iyLeeDa2HazNAmP+SpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wiVS2gzL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e5cec98cceso49022487b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730233511; x=1730838311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mBI2uNkuJz5hUFFer3XXwlG4B2x7GV7bsYE7YJzJyF0=;
        b=wiVS2gzLEp+2GZnv3fI6OOTlhr2VFr3e2DgicBSo3KsgzJXfFJMj7GfygA6mnE6n1I
         mb/ME3t+1dZANdVjtGRgOsreJ5Z8zvntfCfJ/HXPcSLJmX5r3JJ6a/Y/+l1r9Fei2etS
         kxtzdeDklbP5Jt6Vdqom7tdkkwcNC4y5i3mKgrO0H9Tn2GaBHKT4wuaym2dDVQ2X96UG
         ywZEDhyNEjlz4+yyNHIqqWLVO5CMmJOBqUvJtf4Ut55yAvgLiqKsHKerOpBvDKy9Saus
         5cbhVXr+/O6eoK9oYFTGI6Sb5Kcmjp6Ua9+Pu4WLnTCf1wSaaEo4h1gHl1sGifK6jKvp
         aqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233511; x=1730838311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBI2uNkuJz5hUFFer3XXwlG4B2x7GV7bsYE7YJzJyF0=;
        b=HS7Yq5lkyySDEUYbm7AzQLE94mW0b1xJjf0W4a96LVc8RwwFi5daMSFpK0CmNe6gv7
         x7Cja9LeK6AMhcZFtR27Ob5G3CmoZc2evt/jlXRzIXEu79sX/c9XBsvlWqa+uXesw3Is
         ISH3PYoEV3hhE/oM0rtpitF1d7eSEoKF3XcXJybc4qYCby24Ui+ars5rBHKGoCJvL7H3
         WH/JqLmle/cCmZ2QE66RGj+9P3Hm5EezDjfmXnI5L9i73vJsi9KbTwTi7lENu4WWfc7C
         4LtgbUP+p2Ap8OV9EVa8t1pSv+eC4SzN04GmkcNninNtyq/Eps3iLfUe4HYoQt8yQ+ay
         hmlA==
X-Forwarded-Encrypted: i=1; AJvYcCVuht7Im9//mYhAVVwgnroBzqPByHCAf1U0IGERPFSr/t8k7+imok3jI2Gl52GkeiQwPIoFoWCdeBBUc+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHe7BMu8NVg9aB0vbSUVbnQ9c8PfceXL8QJ5lHXwPLpgAhfPJ6
	uMihEjj3/tOjYjliCZCNn+77BhlRIOBUROrlGq5oEJYAwy8FtqXUII78jUHINBCXq9o57KZkrfU
	VBDhuojx9KOT5INlnsKqqqAZS9GqkwW4s/wtT7A==
X-Google-Smtp-Source: AGHT+IG6cX2wf0btAXPAAKNWp9X+HWlDbdwmWyBjB7hXl2DJFXF4XbNv617o/puLRUgalkZOG9h9QJAkPDP/9SnuOAI=
X-Received: by 2002:a05:690c:d8e:b0:6ea:34b1:62e3 with SMTP id
 00721157ae682-6ea34b1660cmr28135337b3.7.1730233511044; Tue, 29 Oct 2024
 13:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-msm-dp-rename-v1-0-a2564e9457b0@linaro.org>
 <20241028-msm-dp-rename-v1-2-a2564e9457b0@linaro.org> <3d142f8c-f7b1-45dc-9a4b-d0b16843a8ba@quicinc.com>
In-Reply-To: <3d142f8c-f7b1-45dc-9a4b-d0b16843a8ba@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 29 Oct 2024 22:25:01 +0200
Message-ID: <CAA8EJpqXE4U4nH8yjtYEryJ4ZOmnDxo--+eUm2_AvDymufjVjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/dp: rename edp_ bridge functions and struct
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 20:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 10/28/2024 4:49 AM, Dmitry Baryshkov wrote:
> > Follow the estalished prefix and rename eDP bridge symbols to use
> > msm_dp_ prefix, moving the edp to the end of the symbol name.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_drm.c | 36 ++++++++++++++++++------------------
> >   1 file changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> > index 6a0840266c0f..ff9ce9b15234 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> > @@ -115,7 +115,7 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
> >       .debugfs_init = msm_dp_bridge_debugfs_init,
> >   };
> >
> > -static int edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
> > +static int msm_dp_bridge_atomic_check_edp(struct drm_bridge *drm_bridge,
> >                                  struct drm_bridge_state *bridge_state,
> >                                  struct drm_crtc_state *crtc_state,
> >                                  struct drm_connector_state *conn_state)
>
> msm_dp_bridge_atomic_check_edp looks a bit odd.
>
> What about just msm_edp_bridge_atomic_check?
>
> Likewise for other edp names.

Yeah, I was torn between these two options. I'll switch to the second one.

-- 
With best wishes
Dmitry

