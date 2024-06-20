Return-Path: <linux-kernel+bounces-223527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8519911486
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7485C1F2648B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDB13F439;
	Thu, 20 Jun 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4J0NUOV"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B11422BC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918665; cv=none; b=F3Mq89fT31VLXDob81C0egupVfOZGnVLAvLRFN1rxaqJPd2XJyZnVDXUuRseEivMygyvF2AT4tpQUWfpVynua/xerGYocC2F5N/GVv3qLiBiuUPslLu2Y5aZoO0DvhkJalTo5XM1NskYRcGXYMSmGvudJgxSEpw+MA/8rUOI/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918665; c=relaxed/simple;
	bh=06lK5dGPZdDGdiBO8ai7qqBqQQoqI3YcJoe7/Fmiy6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHByB61idjOtxCxSoYkXeD7DYtLBf8s23q9zT+QwInpwUuCHxOznIB7Da5tLus+uPiJXNFuHVj3H1Lvi71vkirJCwZJ0BuVuAilfG1LCSZELBCEW4tJu/CSoSC4/iBpwhSkmacKAmQwRtlv0McfYzuZtygevjL5NXzMHzwweq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4J0NUOV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec0f3b9bb8so15319061fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718918662; x=1719523462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFyki6Li5WwqMNFDu+p0N+C8j4Ogo1hQX4orW8yQhio=;
        b=U4J0NUOVe8aa7WBAm+QjopRfPZp4MiTwkhYeka0fdP1i+Uy2puAID3tA8EOBmFClnz
         PJ6xNm7/zUyRDT1HJ/H+OQCyEL0MQYhJUeUxSierJWp9hOMECH0MCZgUAFl99Ab1uD84
         ldz7FE1M48YArTkw8FG5AcgKHKQ8zw3W1MwqdAiursQMrGK2kwUwySOtAgxS1Mug+C/G
         0R6SF5EBTbBDjZyVTIakeTtCz56BQIShIv3vtXTBfcHNcRFbaTpC/kCpJIpi5hdZtvnr
         q+dT2m/RvrflO2gwQZYJ6IqqesTczUJCm3MY6GORH8VCfJaabTTRQ+ZFKJk1fHopb84O
         oIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918662; x=1719523462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFyki6Li5WwqMNFDu+p0N+C8j4Ogo1hQX4orW8yQhio=;
        b=stebnuB932Tv6W1cwklOgN5OFh/D53zYl+UfY8acAqhmxDJoqcn6dlhlk82X5dw9n8
         7wcfmUNUdbgzDpunRymyJaYdvsceMVnUyIPYJCyr0eGZXHUFKWMFcXqC0v4F6a1gkHov
         pwBTTaY7eRZ7ge7jZApTy0cNLxyUJQB0kUxROpoH6bB1Sfx+yZ2IPiGUGDHu/2SLp/0x
         XswC+I+zQNjHqXsC0h8jQ/r69k+fcq8XXN9Q7N2ATZT3RFPrV4DvSeBiQtwNAtp5eKbC
         qwGTqieMo7N1KJQDbYBX+cfUckBbj6B8tSHz5o8LKt7i7Lo06+T2bKwORGD+qe3yWq8D
         bTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQhYVpvpdSjg+kLU6FvUaTHEflV+U7Yof5gTizHOLmCvB4onBR6m4dpvDoNQLUHiSVW6wWsjuOgrSzpl+zkhLQhjn1ewZemlZWU5T1
X-Gm-Message-State: AOJu0YyhVdctQDVe6CU3eTJdRw+hSoimrA9FlWE86SeWe7Wi4i/70BiA
	QucmocA1iNoxk9FcI8QOv7YgMZNCItpoP3I7BKEonCWwTjM4Homuj/DCXrFCsJo=
X-Google-Smtp-Source: AGHT+IGdvA2DIoY5t70jMsOWedO2yArpk+phlv8FZmQtgjRbT12WJ2FeYFzLVCDHpnmOy3D7V2RrEw==
X-Received: by 2002:a2e:97d1:0:b0:2ec:4890:3750 with SMTP id 38308e7fff4ca-2ec4890390emr18300431fa.39.1718918661577;
        Thu, 20 Jun 2024 14:24:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d758170sm271791fa.89.2024.06.20.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:24:21 -0700 (PDT)
Date: Fri, 21 Jun 2024 00:24:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] drm/msm/hdmi: turn mode_set into atomic_enable
Message-ID: <il2bg6bsu4nu4lpztzwo2rfonttiy64grxcsn7n4uybn3eui77@jxyzd744ksva>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
 <20240607-bridge-hdmi-connector-v5-5-ab384e6021af@linaro.org>
 <f34c4210-fd59-9d27-0987-3345631c9e35@quicinc.com>
 <xymopystyfjj3hpqes3uiw2g3dqynxzvz23snrbfzf2judgxnt@j4nmpcbuy7a4>
 <6d416e1a-1069-8355-e9f3-d2732df081a3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d416e1a-1069-8355-e9f3-d2732df081a3@quicinc.com>

On Thu, Jun 20, 2024 at 01:49:33PM GMT, Abhinav Kumar wrote:
> 
> 
> On 6/20/2024 1:32 PM, Dmitry Baryshkov wrote:
> > On Thu, Jun 20, 2024 at 01:27:15PM GMT, Abhinav Kumar wrote:
> > > 
> > > 
> > > On 6/7/2024 6:23 AM, Dmitry Baryshkov wrote:
> > > > The mode_set callback is deprecated, it doesn't get the
> > > > drm_bridge_state, just mode-related argumetns. Turn it into the
> > > > atomic_enable callback as suggested by the documentation.
> > > > 
> > > 
> > > mode_set is deprecated but atomic_mode_set is not.
> > 
> > There is no atomic_mode_set() in drm_bridge_funcs. Also:
> > 
> 
> Please excuse me. I thought since encoder has atomic_mode_set(), bridge has
> one too.
> 
> > * This is deprecated, do not use!
> > * New drivers shall set their mode in the
> > * &drm_bridge_funcs.atomic_enable operation.
> > 
> 
> Yes I saw this note but it also says "new drivers" and not really enforcing
> migrating existing ones which are using modeset to atomic_enable.

Well, deprecated functions are supposed to be migrated.

> My concern is that today the timing engine setup happens in encoder's
> enable() and the hdmi's timing is programmed in mode_set().
> 
> Ideally, we should program hdmi's timing registers first before the
> encoder's timing.
> 
> Although timing engine is not enabled yet, till post_kickoff, this is
> changing the sequence.
> 
> If this really required for rest of this series?

No, it was just worth doing it as I was doing conversion to atomic_*
anyway. I can delay this patch for now.

Two questions:

1) Are you sure regarding the HDMI timing registers vs INTF order? I
observe the underrun issues while changing modes on db820c.

2) What should be the order between programming of the HDMI timing
engine and HDMI PHY?

What would be your opinion on moving HDMI timing programming to
atomic_pre_enable? (the exact place depends on the answer on the second
question).

> 
> > > 
> > > I would rather use atomic_mode_set because moving to atomic_enable() would
> > > be incorrect.
> > > 
> > > That would be called after encoder's enable and hence changes the sequence.
> > > That was not the intention of this patch.
> > > 
> > > NAK.
> > > 
> > > > Acked-by: Maxime Ripard <mripard@kernel.org>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >    drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 33 ++++++++++++++++++++++++++-------
> > > >    1 file changed, 26 insertions(+), 7 deletions(-)
> > 
> > 

-- 
With best wishes
Dmitry

