Return-Path: <linux-kernel+bounces-242567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779249289E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBF41C22F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4514C5BD;
	Fri,  5 Jul 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sy7nOoI2"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB913C8F9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186893; cv=none; b=s2C4lkXySjpSxt5Q6malXnbcMDTBf/WtYZKA/Tg8vlam09xmGTvhyuRVa9SsJMyzUCF59Z/le7jDVEtmAtm1TQtz6CCSvUCZ9nO6V1ele7gYqVQQ25cKG7hKXNVRMkupbgNPUKqA/Qv8mA/aos60YRUgisopRIQtKj3KANkQqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186893; c=relaxed/simple;
	bh=Hw6BEA+vksiXlfFVzP4dQJP4Y0NRaZ5ETGsxIyCGigo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay9xci1UcEqsvDiuzkm8TaErMb8Uc4d+Rc5pZy4k57gjVr984OZuz+rFP0Pzsf+M14GE9ek00cipfvIvK8vRqaspzzKiFUP2YLDC6bFYq/YBFQzJGt9007ljbVRqzTtz5mPhizxOc5eI2lBkBJa8IREPoqiwFQVgw1kvMWUQk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Sy7nOoI2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f0d49a9ebso27598f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720186889; x=1720791689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYq4Ghm/qD4X8g59+rt7/AyXTOqvB29s1gzm0udAON4=;
        b=Sy7nOoI2BkIySzxHpsFRKIjmQQNcdelhuEJIDmWdmfX703HpFFS++sECpiuAJ6k0cJ
         OXdjOs2w61SbB1PPrtk/bIVGyLvZPhYYx7I+0rWNHBGtrMyniyy2Cg4H5v/WyjJcXFgT
         bm/PBkkMjOm6fCqh4F/u8kmM2UiXUpZDPCOVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720186889; x=1720791689;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYq4Ghm/qD4X8g59+rt7/AyXTOqvB29s1gzm0udAON4=;
        b=sMug1FzsnSDtole9g+rgTiajMK1q0OF9amHGCtPPdZXPdpZs4LoFC30LnYb1a0i4OQ
         O3xYlZlC4txwQcqPxEYfe4AQVPV46dypxILx8lpoFk2WePH9PBQbXVbYMbo0z5MociDQ
         5kIt8iSNjD+fMXSYwHOEdiVPlA2LSpD7QLSScsLy09Qffk6WIryrJSv8VbMHsjw2lFiW
         eJF2oeYtR4G1W/Z5DqjK4HnOzn5LEWiQjJW4kmYTlpJs5gBBuV+UW+UcgS+PKhKAIM89
         ROMll+xHA0gLCfHTN3PRtrePkXRg9gywifkUqRwiDvrWcJfnXc6acen+eL0AZvbv7Mmc
         hiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS+Vuo0MdafEHfZb9F5Xnzu46Ynesu+kehZh4EfJkGV+IF0cNvbJe07AZ9abxuvCy+YSCk8AXaS8Z91Y+TKzXTn1SrEFYEg+WgdXPS
X-Gm-Message-State: AOJu0YwAz8cRJ2TugHUalGdDyixL3WW8vyeNL7T2bEG1IIkERf/VLdiO
	jLe1paRyc++lMNfL/ocTb5RF1lgTUD3op1Hn59lD8moyEX4It55o/H4gED7rE+8=
X-Google-Smtp-Source: AGHT+IHy5I71tFmzj8hG6kRNj6VGoN9oGdPL1jjZSB9TbVRv2dFuN5Re/aCUVhXZIMsk78oJMav84A==
X-Received: by 2002:a5d:5f84:0:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-3679de74a63mr3125952f8f.7.1720186889172;
        Fri, 05 Jul 2024 06:41:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a0522ea3sm3762365f8f.27.2024.07.05.06.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:41:28 -0700 (PDT)
Date: Fri, 5 Jul 2024 15:41:26 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: drm/sti: mark it as Odd Fixes
Message-ID: <Zof4Bp82iu7hZsSZ@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
References: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
 <ZofW1v4uEFo9GscF@phenom.ffwll.local>
 <20240705-hysterical-beluga-of-courtesy-38b2e2@houat>
 <ff8b84c9-5bef-4cb9-a10b-b3bb1a017366@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8b84c9-5bef-4cb9-a10b-b3bb1a017366@linaro.org>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Fri, Jul 05, 2024 at 01:33:38PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2024 13:22, Maxime Ripard wrote:
> > On Fri, Jul 05, 2024 at 01:19:50PM GMT, Daniel Vetter wrote:
> >> On Fri, Jul 05, 2024 at 12:03:56PM +0200, Krzysztof Kozlowski wrote:
> >>> Patches to STI DRM are not being picked up, so even though there is
> >>> maintainer activity, it seems that these drivers are not being actively
> >>> looked at.  Reflect this in maintainer status.
> >>
> >> Note that since the driver is in drm-misc, other committers can also pick
> >> up patches and push them. Both Neil and Dimtry have commit rights and
> >> should be able to pick up your patches for you, if they get stuck.
> > 
> > I've applied the patches.
> > 
> > I don't think we should merge this one though, a one-off mishap can happen.
> 
> Sure.
> 
> Folks, maybe then pattern in maintainers should be somehow changed or grew?
> 
> The recommendation to all submitters is to use get_maintainers.pl. b4
> also does it. In this particular case, using get_maintainers.pl or b4
> will result in patches not being picked up.

I think get_maintainers.pl is correct: You get the driver maintainer, plus
drm-misc maintainers as official fallback, plus Dave&me as fallback of
last resorts. So all correct.

What's special with the commit rights model is that other committers that
work all over the subsystem can also pick up the patches for you, so that
the drm-misc mainters don't become a bottleneck. But the ideal person
there are drm-misc committers who work in your team or company, or someone
else where you have some goodwill credits to spend with and ask them for a
favour. And there's just no way to model that and make sure the script
gives you the right suggestions.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

