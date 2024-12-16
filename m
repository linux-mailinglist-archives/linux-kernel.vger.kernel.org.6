Return-Path: <linux-kernel+bounces-448244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581D9F3D68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89CB16A2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4051D63ED;
	Mon, 16 Dec 2024 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icv5nbRE"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1E1D618E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387850; cv=none; b=TEqTRci39Qr/HjVczyqprAzUvoPVyriv0EpOb6JK4E24TpemvZapFewFkQt5Kz9sQxHcj6Zkx4ErhI2VvF8wPHSpdD6+Jw6eyJRwfkmXM7d31iSIo6i7SxyoUJPnhPN5Jh8WTIZhNhD0B42RDoWZMJqPqujR3xEWeRUb0r5HDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387850; c=relaxed/simple;
	bh=6LviHM/ru+IiuAWvPxDcpbR5i9G5GNycZOjMe7v7LE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGJ3vO6ObCgkRLZR9uADWHizNeQGeCcPx5gQnZvuVEvbaPLpTwzK/L6iN17tFJEFLfUMT82Q4zG8omvuOIX6XtjQwSi9AU51enVSrGHmBoynAIhyFInrRRB9Z63UzMmRx0s1gsMX/Y+t35HcMwVKFudOzOJmbtGnYyx/VK8UxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icv5nbRE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3003943288bso44198521fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734387846; x=1734992646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7TrH1UvKd3oaC2SonGHzYdfePQRSyRbTdYf+pidBv8=;
        b=icv5nbRELljnWh65VM/rnDRMpP++K5x32IWvvLdp9PR+bmzWqL7hTdL83Seu3085iO
         5Ou65SUgUVgyajGDSPZ4p8/Xlk+9/S0ucN0CZ+bz65ce72dODbLSglsJsZ80kipUkzjt
         guAZEsWZW6ivwdiye9IRLefWAgnMdX2WUIDtX8czKXMPdiCkCEH53jyIltC1RgM1E9SY
         8x0GpPtJ7P8qea11ZGcEKVyQ25cVkqfLsqpeMnjrcmUft0eCWhr47vlJTdIdzxd0VEHC
         BaHlNswNynZ6XfB3qVHBVi77bQkdZcjBidQ3DHJ6pxPxCiGhGXUL+vJ/xMxGCYzQ/3xY
         fj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734387846; x=1734992646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7TrH1UvKd3oaC2SonGHzYdfePQRSyRbTdYf+pidBv8=;
        b=Un9h3XFMaISyhIwgvPkwO6oiVvy/8ctpbw40CqgGtZ8SkxCIjhln1ChgUXvBhN3I6h
         Gtu7juuRZZmlWFnxphUTZv93Lb7z8+ihQF70b4EHO3HOLP5FfP49zWDCXN6gNdNY0yPC
         JBhuj+TMxxq/1HTQ8E7jOmflNOtGW46ALujCuyyw+Ga9mGjaN2xAZ++nwmV5vDfnPoRC
         Ka8SkalAlc6AHOC3WD/D/D4M24AiNNRME0mZV/sZ2XXiGOqRaiVpnTISNRm1yGev04W4
         LqVmkzpHYL0mMl3DGFrkzQWlhy/hiBc66WI3NIhAC9dqIgcCORqqzMnoLDt7fRaHvTWb
         Rl+w==
X-Forwarded-Encrypted: i=1; AJvYcCWIKAnzDWjO11OCeCKhUqNY8lS11fgwiwI5PxTckSWOUjs+mlNK2ET2YDJ0sIjDzIHeL0czmwsT095Qhm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsdZ8Lt8aTqokqYOGZM5lBBbBtWiZbZIAyImpmU8C+3X3rp/2
	80eRz/Bsuj+vzDvWdApv6OnV5xeTYcCI7fUsAOIeH2bb0SXSQI7NV7G7JBH1mbY=
X-Gm-Gg: ASbGncubXDbO6zoHEg66ULzTaJAKfS8h/0VoXIrd3LBXIxOx+g3jlAW0XP9ersHtLL0
	17pYxZ1IxGaQ1OH7vSuukpCRHSuFileuDRlas7J2VfOaaftJQ0aGvXDiuDV1iyLHTBL2Lb3VR88
	4g6P1Bc9q+HB/watky+JFISpqhcuDK6EA6NXuwEMsKDWNg//bm+hod6AU6ZDUvmEFjQjIMV9ony
	w8lgu0WGQ46NLwgz5xdVGAS5bqYF9PBtuLlbg/09ftfKPvzZTtf/m8fdMY/Kz8GMQMnSr0mX+NJ
	bCF4ol3vVZG3TCx7PvXlvQd9miaypYvMK6Bf
X-Google-Smtp-Source: AGHT+IGVrNsBIuWVRv0FfM+cys7dHh0GLTm6LZ/EdLm6AhlrYBZqk0DuZoUJzXDknWjG4LoS58j5OA==
X-Received: by 2002:a05:651c:1a0b:b0:2ff:cb47:3c77 with SMTP id 38308e7fff4ca-3025459d373mr53682521fa.26.1734387846495;
        Mon, 16 Dec 2024 14:24:06 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a43desm10440181fa.98.2024.12.16.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:24:05 -0800 (PST)
Date: Tue, 17 Dec 2024 00:24:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/16] drm/msm/dp: use msm_dp_utils_pack_sdp_header()
 for audio packets
Message-ID: <wfgn4oomnlsgckazp6z2cqoj5lk76gd5wmphrg6kwiomfvo2j2@rinnzg2ml7is>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
 <20241216-fd-dp-audio-fixup-v4-2-f8d1961cf22f@linaro.org>
 <0cbe48cd-b830-444a-8de0-529343d86192@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbe48cd-b830-444a-8de0-529343d86192@quicinc.com>

On Mon, Dec 16, 2024 at 11:32:57AM -0800, Abhinav Kumar wrote:
> 
> 
> On 12/15/2024 2:44 PM, Dmitry Baryshkov wrote:
> > Use msm_dp_utils_pack_sdp_header() and call msm_dp_write_link() directly
> > to program audio packet data. Use 0 as Packet ID, as it was not
> > programmed earlier.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/dp/dp_audio.c   | 268 ++++++------------------------------
> >   drivers/gpu/drm/msm/dp/dp_catalog.c |  71 ++++++++++
> >   drivers/gpu/drm/msm/dp/dp_catalog.h |  10 ++
> >   3 files changed, 122 insertions(+), 227 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
> > index 5cbb11986460d1e4ed1890bdf66d0913e013083c..46fbf8601eea8e43a152049dfd1dc1d77943d922 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_audio.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_audio.c
> > @@ -14,6 +14,7 @@
> >   #include "dp_catalog.h"
> >   #include "dp_audio.h"
> >   #include "dp_panel.h"
> > +#include "dp_reg.h"
> 
> This change still does reg writes through catalog. Why do you need to
> include dp_reg.h here?

A leftover from the previous patchset.

> 
> >   #include "dp_display.h"
> >   #include "dp_utils.h"

-- 
With best wishes
Dmitry

