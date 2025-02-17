Return-Path: <linux-kernel+bounces-516884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C0A37945
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1966169C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E24D528;
	Mon, 17 Feb 2025 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fV5LIySg"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805A2581
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739753295; cv=none; b=OfLmYaxt8R4BXTf+VD8Rzo71WpE0Ww9203BOUt3I74AIpewpaLvaDVHDnabyDOfh3ozBnqQg9fm/TH3azIwDPpBaD/eqKYFeQAUhF8R9ks+UyhLdV9P+YkD+F5NHL1MVYv70MjnhD0E+ApDDbqvxjoH/7P2IEakadGBJxAxWl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739753295; c=relaxed/simple;
	bh=eCvLy50k9fOPmroPraS8tsBbrd6h4Cvr978MhURjtew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJFStWAYEcl33VKWOXbRcSp3E+MVfntZIUnxJz/O/550UBcWTlNX5Z6Ns8vlX0uZYUq4jc9ujE9V1ZCEB34sVO8UgSQ708+Tl1/E9xAu2oPQ8d6PI0uJjEIK2GygYb1N4DE4cXOucqat+nEmWgY1G13HtKOhl28D7jIHRsslIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fV5LIySg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f6ca9a3425so32876967b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739753291; x=1740358091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jiE7dDyQpEcuMgGEFZxqBiwxreB1F7LNocjU7g22r7Y=;
        b=fV5LIySgv5oWA6oMgOCmPPsaYlacjwOgzJOeS5tTloiMazIzI4h7VQpvjQZZB2597o
         QWYCBd9VEZQmpXlXaH+9d8fag2XWEEAhVfsIoe19LcMa5bivxdp58ky4uidwsX680sMq
         C3E44Wneh3IHAhTIz1I9Do9n2A2oLVnlDMzzAKE4knhVHnPWROWJ4sLPw1+EW1xpE6Dh
         xd7HsTtPLHKiUCrcQPkgzGLJC+SjCJ073ptM2pwLYqatMDTX9wGNyscJM/Mv7Je5snEg
         cQaTYIvcJ6dVz1CbUkOtR7n07BRnJ5zKf0AWrre62yYwTVsKiMxO4VppTNHzVpf+FBO2
         j7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739753291; x=1740358091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiE7dDyQpEcuMgGEFZxqBiwxreB1F7LNocjU7g22r7Y=;
        b=dJh2532KFmFPWu7SXxsLSRQ+vMNWWO3hHCUR0bdsBEjLh9Ombd6wrIkb9vY0bXMoMj
         2MuA0jcRZ6Kx+5QhfRNwQLUz4rPeb3GtZ0xrZLGuAi3vxYUeVZk/ltPGBFEfiirgxLIU
         0yLpLD5bXBub19brxB/x4qOurOXUYiSxufx2YZU3Yic4fa2TQbWrFVQck1oHGgWOCHrx
         hsQC1uRxsfGF956eTpgtqPNqm7/lw3F40xvLI3lLB+doiHIoT0m2W/GAP7MiZ0S/ftaq
         SHWs8asq05BSYtK2JQKuOaEAsf6vDwCOT44JPLZq61Bl31PtnqgelNbzL9InKvGKcoaj
         4D1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXagnED/pMn08aAMBLGoaS1f9yPkrF/q9ZoDck+lEVI766MULJh85EVUBmvj9JBgj+eSGRWDx304r7ky3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6aPMg+kfoDQK+zS8wl6QK8H7BRrKMY8nYt9twDbL7pYwoUF4
	k6Tj1gPf246UqlAa7B7t4phSa8NUiiwFIVKin4HSRw7UghRUhdtEDI/DiVEJ9DwZn3j1gJszd8U
	zJ9WroFWqK2M5Ef/qkOn14KlB1uVIi2aCzrALUQggYwadXg3s
X-Gm-Gg: ASbGncv8FGLcmQhixhmkxkIABVivp+i1I/pJnkV7Pa3DhL+wUyg/ybxoBDTBj0znhmQ
	tDpyJCErG86AeVA0Liazk9uwfC8qJwBwYjm+vd6ZUL0jtC7vUgRArhwgpqMW9uTjBM8MS3/8nmP
	bJfTlcIssDZOGHp1NQQgkWo+kttkZW
X-Google-Smtp-Source: AGHT+IEMhSRFHPDYkw5GeVrG2kqJaVOkuZfxzT78iT6QhZXjbf5bNidkqWZ4fujnyRRGkAao4NrfMknk7hZDlpY2vkc=
X-Received: by 2002:a05:690c:6e0a:b0:6ef:5097:5daa with SMTP id
 00721157ae682-6fb5835b290mr64408277b3.34.1739753290871; Sun, 16 Feb 2025
 16:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209-drm-msm-initial-dualpipe-dsc-fixes-v2-0-9a60184fdc36@somainline.org>
 <20250209-drm-msm-initial-dualpipe-dsc-fixes-v2-2-9a60184fdc36@somainline.org>
 <nzm3tokbvho3hxz3e5vblp5ndagfcv5ah3j7gtkqjmt7ynr6f3@v36juvu73i5v>
 <vsxfi43d7rxh5xxc7ctivjslf6w4yy5iprqpqid3u3diylrtwd@wayafjlgzz7v>
 <x4jced57uhdfnq4d7tdqsozxbdosu2fcmsjlqtuuvh25ltx2rc@2eqsa7e4vcdv>
 <c5503020-0224-428a-9452-f8d668b47caf@quicinc.com> <ca80bd37-3b3f-48d3-a57d-2440d20d0c6c@quicinc.com>
 <hvwpqzvdoeosz34ptbksc44ad7ohi6uwioy6o7qc4ewwcvx4d4@g3kksn3rwk6j> <xtcwuscf3nz6o6qhv4lerpeoxep34iloj6kvxxuad7yoqsus22@tmuv2jqvfpo7>
In-Reply-To: <xtcwuscf3nz6o6qhv4lerpeoxep34iloj6kvxxuad7yoqsus22@tmuv2jqvfpo7>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 02:48:00 +0200
X-Gm-Features: AWEUYZnr5JEM_NzM6_fTTLE79Hxcuewl699FSlC_aTSNnkIVaJZXXU_BNMa4HAc
Message-ID: <CAA8EJppoeuO-JWPzG=OB_HQXKokf_aj-JOW4GDfgGF1r3n+u=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/msm/dsi: Set PHY usescase (and mode) before
 registering DSI host
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jordan Crouse <jordan@cosmicpenguin.net>, 
	~postmarketos/upstreaming@lists.sr.ht, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 01:06, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2025-02-13 04:13:06, Dmitry Baryshkov wrote:
> > On Wed, Feb 12, 2025 at 05:13:08PM -0800, Abhinav Kumar wrote:
> > > Hi Marijn
> > >
> > > On 2/10/2025 2:17 PM, Abhinav Kumar wrote:
> > > >
> > > >
> > > > On 2/10/2025 6:24 AM, Dmitry Baryshkov wrote:
> > > > > On Mon, Feb 10, 2025 at 01:54:29PM +0100, Marijn Suijten wrote:
> > > > > > On 2025-02-10 01:11:59, Dmitry Baryshkov wrote:
> > > > > > > On Sun, Feb 09, 2025 at 10:42:53PM +0100, Marijn Suijten wrote:
> > > > > > > > Ordering issues here cause an uninitialized (default STANDALONE)
> > > > > > > > usecase to be programmed (which appears to be a MUX) in some cases
> > > > > > > > when msm_dsi_host_register() is called, leading to the slave PLL in
> > > > > > > > bonded-DSI mode to source from a clock parent (dsi1vco) that is off.
> > > > > > > >
> > > > > > > > This should seemingly not be a problem as the actual
> > > > > > > > dispcc clocks from
> > > > > > > > DSI1 that are muxed in the clock tree of DSI0 are way
> > > > > > > > further down, this
> > > > > > > > bit still seems to have an effect on them somehow and causes the right
> > > > > > > > side of the panel controlled by DSI1 to not function.
> > > > > > > >
> > > > > > > > In an ideal world this code is refactored to no longer have such
> > > > > > > > error-prone calls "across subsystems", and instead model the "PLL src"
> > > > > > > > register field as a regular mux so that changing the clock parents
> > > > > > > > programmatically or in DTS via `assigned-clock-parents` has the
> > > > > > > > desired effect.
> > > > > > > > But for the avid reader, the clocks that we *are* muxing into DSI0's
> > > > > > > > tree are way further down, so if this bit turns out to be a simple mux
> > > > > > > > between dsiXvco and out_div, that shouldn't have any effect as this
> > > > > > > > whole tree is off anyway.
> > > > > > > >
> > > > > > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > > > > > > ---
> > > > > > > >   drivers/gpu/drm/msm/dsi/dsi_manager.c | 30
> > > > > > > > ++++++++++++++++++ +-----------
> > > > > > > >   1 file changed, 19 insertions(+), 11 deletions(-)
> > > > > > >
> > > > > > >
> > > > > > > Fixes: 57bf43389337 ("drm/msm/dsi: Pass down use case to PHY")
> > > > > >
> > > > > > I'm not exactly confident about that.  Abhinav pointed out in
> > > > > > https://gitlab.freedesktop.org/drm/msm/-/issues/41#note_2375646 that
> > > > > > msm_dsi_host_register() was not supposed to be enabling the PHY, which I
> > > > > > provided a counter-stacktrace for to show that is indeed the case.
> > > > > >
> > > > > > Either this was always a problem that's only become visible now
> > > > > > (and it's an
> > > > > > issue with that patch), or a different change causes
> > > > > > msm_dsi_host_register()
> > > > > > to enable the PHY and program the usecase too early?
> > > > >
> > > > > As currently usecase is being programmed after the DSI host being
> > > > > registered, there might be a race condition between panel driver probe
> > > > > _and_ usecase programming.
> > > > >
> > > > > >
> > > > > > What do you think?
> > > > > >
> > > > > > - Marijn
> > > > > >
> > > >
> > > > Yes I agree with Dmitry's explanation. The race condition between the
> > > > two can cause this. Hence I am also fine with this change.
> > > >
> > > > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > >
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > > > > > > > b/drivers/gpu/ drm/msm/dsi/dsi_manager.c
> > > > > > > > index a210b7c9e5ca281a46fbdb226e25832719a684ea..b93205c034e4acc73d536deeddce6ebd694b4a80
> > > > > > > > 100644
> > > > > > > > --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > > > > > > > +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> > > > > > > > @@ -74,17 +74,33 @@ static int dsi_mgr_setup_components(int id)
> > > > > > > >       int ret;
> > > > > > > >       if (!IS_BONDED_DSI()) {
> > > > > > > > +        /* Set the usecase before calling
> > > > > > > > msm_dsi_host_register(), which would
> > > > > > > > +         * already program the PLL source mux based on
> > > > > > > > a default usecase.
> > > > > > > > +         */
> > > > > > > > +        msm_dsi_phy_set_usecase(msm_dsi->phy,
> > > > > > > > MSM_DSI_PHY_STANDALONE);
> > > > > > > > +        msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
> > > > > > > > +
> > > > > > > >           ret = msm_dsi_host_register(msm_dsi->host);
> > > > > > > >           if (ret)
> > > > > > > >               return ret;
> > > > > > > > -
> > > > > > > > -        msm_dsi_phy_set_usecase(msm_dsi->phy,
> > > > > > > > MSM_DSI_PHY_STANDALONE);
> > > > > > > > -        msm_dsi_host_set_phy_mode(msm_dsi->host, msm_dsi->phy);
> > > > > > > >       } else if (other_dsi) {
> > > > > > > >           struct msm_dsi *master_link_dsi = IS_MASTER_DSI_LINK(id) ?
> > > > > > > >                               msm_dsi : other_dsi;
> > > > > > > >           struct msm_dsi *slave_link_dsi = IS_MASTER_DSI_LINK(id) ?
> > > > > > > >                               other_dsi : msm_dsi;
> > > > > > > > +
> > > > > > > > +        /* PLL0 is to drive both DSI link clocks in bonded DSI mode.
> > > > > > > > +         *
> > > > > > > > +        /* Set the usecase before calling
> > > > > > > > msm_dsi_host_register(), which would
> > > > > > > > +         * already program the PLL source mux based on
> > > > > > > > a default usecase.
> > > > > > > > +         */
> > >
> > > My compiler is throwing a warning here
> > >
> > > drivers/gpu/drm/msm/dsi/dsi_manager.c: In function
> > > 'dsi_mgr_setup_components':
> > > drivers/gpu/drm/msm/dsi/dsi_manager.c:94:3: warning: "/*" within comment
> > > [-Wcomment]
> > >    /* Set the usecase before calling msm_dsi_host_register(), which would
> > >    ^
> > > drivers/gpu/drm/msm/dsi/dsi_manager.c: At top level:
> > >
> > > Can you pls address this one so that I can pick this one up?
>
> Whoops, that looks like copy-paste mistake when copying the comment from
> !IS_BONDED_DSI() and merging it with the original comment about PLL0.
> Will resend when I understand Dmitry's question below;
>
> >
> > While you are at it, Marijn, could you please also fix the first comment
> > to be properly formatted?
>
> What exactly do you need to be reformatted about the first comment?  It's
> exactly the same in both branches.  No multiline comments in dsi_manager.c
> start with a newline after the first /*.  Anything I'm missing?

Yes. But those, I think, are older comments. Please use proper
formatting for new comments.

>
> - Marijn
>
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry

