Return-Path: <linux-kernel+bounces-192232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40D8D1A64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E51E1F242FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C4016C875;
	Tue, 28 May 2024 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CL3KAjlV"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B016C841
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897407; cv=none; b=lsbVmDj1DcNmcu4OEntb7dGn0S2Wn3BvvlcAq4Vjv26XVAp8n7HyNjD4iNp/GnoTwXxC2YFc10HAoU+HnGMmEIs4kRXRmkF4etIs6fMc5E6crxTznX3z+NEzhDdz0kfqI+g1xc+RTcbMMJDXiBKRzlvMNbZG63Z2uice5xpxnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897407; c=relaxed/simple;
	bh=JoFKSxnpuAFmFALL4XOOxMVE666JdBUw5hFTodj0Jok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFgz77O9ZCWQbFwacrX1gfotDw+CWd2UY6xrRhfyHT+Et1bT49RO5p0/XhNmya3zZm4BGwwcelqvAyYzbhmvLaVOcI7pfLk5Ulfv0rrR7cJ9NiaGRvk1kxAk+9Qc+pFS0UEtN7vTkKx2rUYQpeVLxGS5zsz6CSgM7X5Ar32kMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CL3KAjlV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so9084801fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716897404; x=1717502204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oCjaRC8Eu5PO/jMlynPBkhbwEoTzC3Pm/rk64eh59dQ=;
        b=CL3KAjlVydEbiEutMnkbvpPZEB9c+6zsTebZCzS86Av2RbMYEoL69qIlOXbIoTaB3b
         0TJg7iMaDNNckcHdu1aCR6sMfvNe9m+Yg66kogy/V52HHqdsTTmmOcd6CO7jceZ7YyRA
         jO9xVCuox2U9pXNT8hoDNkIm/eS9T/b1zhCepcO+pk10dHukfskUjxVovMf4TPTt47SB
         mhw7YTyPt1FaZY9AS2TZRAQESl9Pooe+ZuF2P/5C1OUQRZkVxwhHRu3h/N+8ExAH7I6y
         iP2SJCBTDk3Y6Icetwj5D5xUVA1Sg4uNBUHwtCEXt4pBa5lgq9iSFqKlCofW3IcL0XqI
         xuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897404; x=1717502204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCjaRC8Eu5PO/jMlynPBkhbwEoTzC3Pm/rk64eh59dQ=;
        b=dohrGhNg4kd5IS3M6LAJQzV5/hLWeYN9oj6lc8eRE1Ia/ts4bPLIq5kDTS9uP2Zsxm
         TDC7ay0UPgrdXYBvnIFkQMof24WGpfg624ZaeFkhZkBA/7FjuSgYVv5kufGgPMwPOPBi
         6MLHbflauA2/DIhjilpcdhQgfpkuQhmONDL9eualVL8fbcr1PJNTeFNbi312ZAL9eBSe
         rQ4A4a+o3EmQ1l9ayfQDvU9TcMZPuu+6tINf4ex0Jp/rX2REU6m+jHx066Jo2NmnNVrI
         sbx/QoKC4AvEP4njZUfhzqeVRntaws1txphDraJMLe+TEUjNVq94XZcQp2tddFMJTW3e
         OlFg==
X-Forwarded-Encrypted: i=1; AJvYcCWRcg6Ud1RRtvoClWZ/V6MJdcoH13jC4IdMpXSU1w0c2WweLRunLfbLnuylG++MPTcFtDBZmr2OUNHR3RdKbk1YYoJ8mPWaGiPbfCLn
X-Gm-Message-State: AOJu0YyQiJZxR26effcFPf1QVn6hhYatDEHE4CxyVCXga8uF1x2kSGGb
	lZFfQZmiwiBFoSwlKPBfp36rMhfwYk11cKN/s4IiXtQX3cNfSb2KziE9W1VnGnk=
X-Google-Smtp-Source: AGHT+IHsJsDnQl+EL8lCVJ54Xb104AElU7vavZkJuJ90hTUqa4aoOEIcclt6lXoq7iXLRtqyt4A4DQ==
X-Received: by 2002:a2e:b0ef:0:b0:2e9:834e:b9e8 with SMTP id 38308e7fff4ca-2e9834ebb5amr28341211fa.1.1716897404252;
        Tue, 28 May 2024 04:56:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4962sm22516371fa.11.2024.05.28.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:56:43 -0700 (PDT)
Date: Tue, 28 May 2024 14:56:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] drm/msm/dpu: adjust data width for widen bus case
Message-ID: <sjz2el73774uaht7gfwbyuteprd3nv73gvj6g557putrxh7jut@g34dvy4s23ui>
References: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
 <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-2-f797ffba4682@linaro.org>
 <57sr3ssi6nwermdqtnb2ackmu4tlxs4gcslvp4v6ndafnvbqhb@4npuqfpkzzan>
 <CABymUCOCcgfHsBaFBk63z+CLJu6Lee983nCM14PgPWZjkFFikQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCOCcgfHsBaFBk63z+CLJu6Lee983nCM14PgPWZjkFFikQ@mail.gmail.com>

On Tue, May 28, 2024 at 05:59:13PM +0800, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2024年5月28日周二 08:48写道：
> >
> > On Mon, May 27, 2024 at 10:21:48PM +0800, Jun Nie wrote:
> > > data is valid for only half the active window if widebus
> > > is enabled
> > >
> > > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> > > index 225c1c7768ff..f97221423249 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> > > @@ -168,6 +168,15 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
> > >
> > >       data_width = p->width;
> > >
> > > +     /*
> > > +      * If widebus is enabled, data is valid for only half the active window
> > > +      * since the data rate is doubled in this mode. But for the compression
> > > +      * mode in DP case, the p->width is already adjusted in
> > > +      * drm_mode_to_intf_timing_params()
> >
> > Is there any reason for divergence here?
> 
> Lots of parameters in dpu_hw_intf_setup_timing_engine() is calculated
> from timing->width,
> such as hsync_period and display_v_start. So the width cannot be
> adjusted beforehand in
> drm_mode_to_intf_timing_params(). Otherwise, we get below error.
> 
> I guess the interface timing configuration differ in silicon, thus the
> software shall handle the
> difference. If we adjust the width beforehand for DSI, we get below error.
> 
> [    6.625446] [drm:dpu_encoder_frame_done_timeout:2469] [dpu
> error]enc31 frame done timeout
> [    6.642369] [drm:dpu_encoder_phys_vid_wait_for_commit_done:525]
> [dpu error]vblank timeout: 4200c1
> [    6.642395] [drm:dpu_kms_wait_for_commit_done:493] [dpu error]wait
> for commit done returned -110
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

