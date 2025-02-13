Return-Path: <linux-kernel+bounces-512184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058FA3355B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FCC7A1E23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67214A0B5;
	Thu, 13 Feb 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyyqECEt"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67113D53B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412794; cv=none; b=auhkOyEDj7UpZq9KaG46PXXdDM0okFjNkscrHnOzF6mUkdnipl89uTQg5ydSz/HiVeHAAG9bzvW3KJWClmX40X2HPGPkBuSGiI3upLFzpHBygNBgJlYR/VWDSyzLwTssctDDqSR1FxwtMDFt4ler501xVVTZYuTg6GJZJk/qOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412794; c=relaxed/simple;
	bh=8MJIRbb7WsM8a3n0MKIH5Jbu69Pr1rZ/BDRDPU7I4wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scPBULV9/H58rJvDWhF5HFzkkWnPjQJ+IWiYg+NAK9mlfyO6h18hE9vwpx5HrZdrPpkAjN2+rDhuha+6N993J1g8I0cwWd0QcMYvQ8MAPyyR45C6LjnlBYqYO0pdjwE0B6OMQ3WcX8VAuPT1RC4eS49H1XYjTnsygLZV1jUXS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyyqECEt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308ef06b4e1so3558721fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739412790; x=1740017590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGMi3Hp+9/bQmjultqdLIF1nZcd4s1BR7J7PwlZZx/0=;
        b=HyyqECEt1uqagSxdVMcR85dODeGb63118e6yXi/xPpEF7dW0RfzmKx+DR/qaEISmkv
         4/mAVvDfvkQwOE4mYiNpK4KusiCYNYQvTt6Eo7iE/E6SQgfIooDb7TaauouqkSNn3usc
         py5OuQWLp5DrrS+zxxXklL2amh07DGjlh2Ak6M7+2i1jWlkmogC22/zOADCtYO27vb91
         b4lxkgWN50V0TpJcwRDlC1L/bUu965U4Q5XJSwe60PYQACYbCKo8UYCNSXiUuBYrR0Le
         SLC8r5G0xza4vGWytySZzCmgCwt5wRTZwQIpqaJeDYBY1CyAE3l39jEoO7A+LLXbNXg0
         /DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412790; x=1740017590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGMi3Hp+9/bQmjultqdLIF1nZcd4s1BR7J7PwlZZx/0=;
        b=og8yScb4JNd3Kypwlw3VpicvdfK3rfc53AOB/u8e1muwKAuXITvqWjNdVIO/Zz/tKx
         uEmGaihkQnce0RoNPevLSIx/8+uhtApPfm64LsQoJW0kUoEyyZwvpQwX7rsEqvybdn7V
         ymW6fVMKeRUM0kR6QF6fQTATvyHLIDBE+stbsHWJ7pgYkk3tuOeaF5yP1gMGVOVeI3hr
         mSe/9YniukQKl+VjvUjamf2iFf1v4IepNdAN2xW5UctTNdvERWlmjxJQ/v1f1D+7nyJi
         NKLEQqFVB+WGi/rHOv+KyryegOLf8Mv4y6yuhXja+9oDcpw22XzfW8o5NteLQR7wN/tF
         eGUw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6RsNdRwmIlV2cJ02CcAk1yFa6zs4Mw/8/WPFp1jpIAh2jdbqmoHgDxuDCYHS9YA0PJ2j3ThgHExZ3dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4n9//lgaZ94uQQ12sPYDJRkauhQapovYnqIx1NSkgGzN3/vd
	l/aicpZXdSZoh0e0OHP8L9tfmliuqHzTp7CXkp6WdZm/zCib+bGtwh+7agtRLOwNvJ+EC0gMMoJ
	ArEQ=
X-Gm-Gg: ASbGncvEq82+5yZjtbmXhZLZqfF5oRRYo2S6s1WtjxLWcWNQJhxodUSNrhHBFJlrsr4
	UUrvQ8n8Q8HAppFwQd5GPoSsShYxuNOwQ/EVvdVEZd30lZ0q1O22Dh3HSfgdHuzb+c8CeDC9qjJ
	pGYMy+j1rg6uYO3xwjtyVMVumMEoO/5HfOncQBwl64/5EtI0RsFq0eqrJuQXbYWeDd5KHXoaEdB
	D0UtYWvjeyaxYaRUQuhMiYO0U9K4iKJZoP0DaQFaIicLUSICc6nG43j+dqxtZP2sGDZ5GmzSVEy
	chIY05zUt7tMov1tgJ0p3xz6rrDtZ400qLhpDnWj0E463Cho2GaahSqVbSQxsah+6XQ7N1M=
X-Google-Smtp-Source: AGHT+IEmMbELCnUbRJwClshsnX4iixkLoQEOYZtcE+7298TlajRpBP1u+uXg5U1gx43ozlPd0fUbow==
X-Received: by 2002:a05:651c:211b:b0:308:fac7:9cc3 with SMTP id 38308e7fff4ca-3090dce23b7mr6496371fa.14.1739412790482;
        Wed, 12 Feb 2025 18:13:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100effbasm548781fa.29.2025.02.12.18.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:13:09 -0800 (PST)
Date: Thu, 13 Feb 2025 04:13:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Vinod Koul <vkoul@kernel.org>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jordan Crouse <jordan@cosmicpenguin.net>, ~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Martin Botka <martin.botka@somainline.org>, 
	Jami Kettunen <jami.kettunen@somainline.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] drm/msm/dsi: Set PHY usescase (and mode) before
 registering DSI host
Message-ID: <hvwpqzvdoeosz34ptbksc44ad7ohi6uwioy6o7qc4ewwcvx4d4@g3kksn3rwk6j>
References: <20250209-drm-msm-initial-dualpipe-dsc-fixes-v2-0-9a60184fdc36@somainline.org>
 <20250209-drm-msm-initial-dualpipe-dsc-fixes-v2-2-9a60184fdc36@somainline.org>
 <nzm3tokbvho3hxz3e5vblp5ndagfcv5ah3j7gtkqjmt7ynr6f3@v36juvu73i5v>
 <vsxfi43d7rxh5xxc7ctivjslf6w4yy5iprqpqid3u3diylrtwd@wayafjlgzz7v>
 <x4jced57uhdfnq4d7tdqsozxbdosu2fcmsjlqtuuvh25ltx2rc@2eqsa7e4vcdv>
 <c5503020-0224-428a-9452-f8d668b47caf@quicinc.com>
 <ca80bd37-3b3f-48d3-a57d-2440d20d0c6c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca80bd37-3b3f-48d3-a57d-2440d20d0c6c@quicinc.com>

On Wed, Feb 12, 2025 at 05:13:08PM -0800, Abhinav Kumar wrote:
> Hi Marijn
> 
> On 2/10/2025 2:17 PM, Abhinav Kumar wrote:
> > 
> > 
> > On 2/10/2025 6:24 AM, Dmitry Baryshkov wrote:
> > > On Mon, Feb 10, 2025 at 01:54:29PM +0100, Marijn Suijten wrote:
> > > > On 2025-02-10 01:11:59, Dmitry Baryshkov wrote:
> > > > > On Sun, Feb 09, 2025 at 10:42:53PM +0100, Marijn Suijten wrote:
> > > > > > Ordering issues here cause an uninitialized (default STANDALONE)
> > > > > > usecase to be programmed (which appears to be a MUX) in some cases
> > > > > > when msm_dsi_host_register() is called, leading to the slave PLL in
> > > > > > bonded-DSI mode to source from a clock parent (dsi1vco) that is off.
> > > > > > 
> > > > > > This should seemingly not be a problem as the actual
> > > > > > dispcc clocks from
> > > > > > DSI1 that are muxed in the clock tree of DSI0 are way
> > > > > > further down, this
> > > > > > bit still seems to have an effect on them somehow and causes the right
> > > > > > side of the panel controlled by DSI1 to not function.
> > > > > > 
> > > > > > In an ideal world this code is refactored to no longer have such
> > > > > > error-prone calls "across subsystems", and instead model the "PLL src"
> > > > > > register field as a regular mux so that changing the clock parents
> > > > > > programmatically or in DTS via `assigned-clock-parents` has the
> > > > > > desired effect.
> > > > > > But for the avid reader, the clocks that we *are* muxing into DSI0's
> > > > > > tree are way further down, so if this bit turns out to be a simple mux
> > > > > > between dsiXvco and out_div, that shouldn't have any effect as this
> > > > > > whole tree is off anyway.
> > > > > > 
> > > > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > > > ---
> > > > > >   drivers/gpu/drm/msm/dsi/dsi_manager.c | 30
> > > > > > ++++++++++++++++++ +-----------
> > > > > >   1 file changed, 19 insertions(+), 11 deletions(-)
> > > > > 
> > > > > 
> > > > > Fixes: 57bf43389337 ("drm/msm/dsi: Pass down use case to PHY")
> > > > 
> > > > I'm not exactly confident about that.  Abhinav pointed out in
> > > > https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2375646 that
> > > > msm_dsi_host_register() was not supposed to be enabling the PHY, which I
> > > > provided a counter-stacktrace for to show that is indeed the case.
> > > > 
> > > > Either this was always a problem that's only become visible now
> > > > (and it's an
> > > > issue with that patch), or a different change causes
> > > > msm_dsi_host_register()
> > > > to enable the PHY and program the usecase too early?
> > > 
> > > As currently usecase is being programmed after the DSI host being
> > > registered, there might be a race condition between panel driver probe
> > > _and_ usecase programming.
> > > 
> > > > 
> > > > What do you think?
> > > > 
> > > > - Marijn
> > > > 
> > 
> > Yes I agree with Dmitry's explanation. The race condition between the
> > two can cause this. Hence I am also fine with this change.
> > 
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > 
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > > > > > b/drivers/gpu/ drm/msm/dsi/dsi_manager.c
> > > > > > index a210b7c9e5ca281a46fbdb226e25832719a684ea..b93205c034e4acc73d536deeddce6ebd694b4a80
> > > > > > 100644
> > > > > > --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > > > > > +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > > > > > @@ -74,17 +74,33 @@ static int dsi_mgr_setup_components(int id)
> > > > > >       int ret;
> > > > > >       if (!IS_BONDED_DSI()) {
> > > > > > +        /* Set the usecase before calling
> > > > > > msm_dsi_host_register(), which would
> > > > > > +         * already program the PLL source mux based on
> > > > > > a default usecase.
> > > > > > +         */
> > > > > > +        msm_dsi_phy_set_usecase(msm_dsi->phy,
> > > > > > MSM_DSI_PHY_STANDALONE);
> > > > > > +        msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
> > > > > > +
> > > > > >           ret = msm_dsi_host_register(msm_dsi->host);
> > > > > >           if (ret)
> > > > > >               return ret;
> > > > > > -
> > > > > > -        msm_dsi_phy_set_usecase(msm_dsi->phy,
> > > > > > MSM_DSI_PHY_STANDALONE);
> > > > > > -        msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
> > > > > >       } else if (other_dsi) {
> > > > > >           struct msm_dsi *master_link_dsi = IS_MASTER_DSI_LINK(id) ?
> > > > > >                               msm_dsi : other_dsi;
> > > > > >           struct msm_dsi *slave_link_dsi = IS_MASTER_DSI_LINK(id) ?
> > > > > >                               other_dsi : msm_dsi;
> > > > > > +
> > > > > > +        /* PLL0 is to drive both DSI link clocks in bonded DSI mode.
> > > > > > +         *
> > > > > > +        /* Set the usecase before calling
> > > > > > msm_dsi_host_register(), which would
> > > > > > +         * already program the PLL source mux based on
> > > > > > a default usecase.
> > > > > > +         */
> 
> My compiler is throwing a warning here
> 
> drivers/gpu/drm/msm/dsi/dsi_manager.c: In function
> 'dsi_mgr_setup_components':
> drivers/gpu/drm/msm/dsi/dsi_manager.c:94:3: warning: "/*" within comment
> [-Wcomment]
>    /* Set the usecase before calling msm_dsi_host_register(), which would
>    ^
> drivers/gpu/drm/msm/dsi/dsi_manager.c: At top level:
> 
> Can you pls address this one so that I can pick this one up?

While you are at it, Marijn, could you please also fix the first comment
to be properly formatted?

-- 
With best wishes
Dmitry

