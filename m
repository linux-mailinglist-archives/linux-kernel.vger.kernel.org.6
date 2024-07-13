Return-Path: <linux-kernel+bounces-251552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A73930632
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980E21C20F2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFDF13B5AD;
	Sat, 13 Jul 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdxwksn3"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF8139587
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885108; cv=none; b=HSpFwrMIOIzWK3Ta+2/I3ZR/FQUyqxAL9MG9362qcavmLwq3U0hXgqUKmCqkVfFYESjxCCXddu0MfdN1Jn1TOs6S0WzTKYRCTJhFy9t627bQsvlvn7ncIyfwFlycFH8a6RjWpry3pIZHLwAuxc1cgFsHFS1Uua7an6gX5EHmdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885108; c=relaxed/simple;
	bh=bZjVENWzdO/dM9O6jLuW2OjfM6Jn9UeSxTtq5vBQWFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+I+1UXK2vhZGbLPRAkPAX/GCk1+YeQqqCDa2GHoGE+YLwoRFAWhz9An/miyItW61t9CeTZBf3uPcVRv2tpQqSdMnMQegfk0KDXxv4Lf8eLsM06/oqvwchYDHiCWjm0LFaUWJaIkS1F9DA4s6TUqjWEAb4Dc9UTpQycRJAzBoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdxwksn3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e9944764fso3493907e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720885105; x=1721489905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrw656yPZ58/He6Z0SljV1MTH9DNc6XhfX4EqtbUZcw=;
        b=qdxwksn3gP/yJP2uhFkMb7k9Z4Nu/LLAm+TCJ3dDNGzfZGo/FH0ULo+4R/rCRpntN3
         hzZiXIt1HeULmdKTPprhSZv6JvYZ25fMp7hCGlfUntv1MuzE5FBT6K7fQupu4DrTBZl4
         KS8s3XMBMHWEOKOKl6IKyedxE5ntD+7c4VsQw3h4r5r00sCsF5TTimkX/EXTczwnFYik
         p1krCQtCHNYor8HdSZM2SkUHypu2RmXaRfzbgWksoi1vbjhHchJOd1dfALXCAbPTOjaF
         go92qDqZP0KOv0L1iqt4Yd7YMFP+zS+9RVkygSCFtpEQEMMwTHDWeMVg8TCYgUiek5x6
         Mrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720885105; x=1721489905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrw656yPZ58/He6Z0SljV1MTH9DNc6XhfX4EqtbUZcw=;
        b=dV6KXsFG2oOJaW/cEKJZqglj21GXSAQJyy0gG025ALX69RYuqUi6Qpr4d5FpzR13Ji
         SzdR0rHYAV1zKKRWEGTBfeFkpMsZgcsAR6gJ+OHRKidrqCyu3k1KcqTpssZvDmqlPMDl
         b1IiGGLt0MHD0TRgg8uwCivQcry89xRHHkEo/EJXQfbojAYoTSoGZDLt90xzf+4Oi+eO
         RuZjJzqr4aApJ5AXrlHKO5M709nV5xzz+xgESqNHkLvsH/sfJ+dsZTlp+Rv+jkoOYKPU
         I6DQiC+aE6d5tCvVQyLLEwvisa9vtymjIBF7qvut8fCcTz6q+iT2xyA0rZgf8RgNs4wE
         ByQg==
X-Forwarded-Encrypted: i=1; AJvYcCWSRd5yMIw8PDN2uVVAoIJ3Eq0lBqCDRNKawmzYGKCmE6iIIVDyhHQ4ZUMKucp9X10NG3g89tk7YWlcmq16sYdg5PaZyz+0le2HqT0z
X-Gm-Message-State: AOJu0YyrQTp3dXHT+UtNm8i+DrQltr9DhWavhAvMOi2P5wzG8pm1fQKn
	TSBjAQnyrnB1wDkpkZN8FoUNF66Cicu1cAbtRvDuewAOpy1Ws36dKA34Jm60KdM=
X-Google-Smtp-Source: AGHT+IHd1JycgmrKTAmXhfqJQqu17IdmqopYEnNGA4fjNnAG4okwte5I2bl+t6SJIVoBWEeIA7EZqQ==
X-Received: by 2002:a05:6512:3e19:b0:52e:93d1:57a6 with SMTP id 2adb3069b0e04-52eb998e483mr10940314e87.6.1720885105051;
        Sat, 13 Jul 2024 08:38:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed252d538sm224218e87.141.2024.07.13.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 08:38:24 -0700 (PDT)
Date: Sat, 13 Jul 2024 18:38:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>, Archit Taneja <architt@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jeykumar Sankaran <jsanka@codeaurora.org>
Subject: Re: [PATCH 2/2] drm/msm/dpu: don't play tricks with debug macros
Message-ID: <cvizlwetyzmwxwtesd54kgghb4ttnj3kgdnca2ujq6orzntymw@tei6xtsoh3og>
References: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
 <20240709-dpu-fix-wb-v1-2-448348bfd4cb@linaro.org>
 <46487222-6818-b0bf-e5cc-2310d62b5fe6@quicinc.com>
 <CAA8EJpq7Lp-3V_AsLxO9ZOt8ZW1ZZ=FjhXV6R9jvH=sQ8XQE9w@mail.gmail.com>
 <fb285034-ed4c-4f20-ab80-cf91d36fc67c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb285034-ed4c-4f20-ab80-cf91d36fc67c@quicinc.com>

On Thu, Jul 11, 2024 at 11:03:15AM GMT, Abhinav Kumar wrote:
> 
> 
> On 7/10/2024 12:40 AM, Dmitry Baryshkov wrote:
> > On Tue, 9 Jul 2024 at 22:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 7/9/2024 6:48 AM, Dmitry Baryshkov wrote:
> > > > DPU debugging macros need to be converted to a proper drm_debug_*
> > > > macros, however this is a going an intrusive patch, not suitable for a
> > > > fix. Wire DPU_DEBUG and DPU_DEBUG_DRIVER to always use DRM_DEBUG_DRIVER
> > > > to make sure that DPU debugging messages always end up in the drm debug
> > > > messages and are controlled via the usual drm.debug mask.
> > > > 
> > > 
> > > These macros have been deprecated, is this waht you meant by the
> > > conversion to proper drm_debug_*?
> > 
> > Yes. Drop the driver-specific wrappers where they don't make sense.
> > Use sensible format strings in the cases where it actually does (like
> > VIDENC or _PLANE)
> > 
> 
> Ack but we need to not just drop the wrappers but drop the usage of these
> macros as well because it is documented that they are deprecated.
> 
> So I assume you want to get this in and do that as a follow up change?

Yes, somewhere in the long list of cleanups. I have a similar item
against DP driver, which uses correct macros, 

> > > /* NOTE: this is deprecated in favor of drm_dbg(NULL, ...). */
> > > #define DRM_DEBUG_DRIVER(fmt, ...)                                      \
> > >           __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
> > > 
> > > I think all that this macro was doing was to have appropriate DRM_UT_*
> > > macros enabled before calling the corresponding DRM_DEBUG_* macros. But
> > > I think what was incorrect here is for DPU_DEBUG, we could have used
> > > DRM_UT_CORE instead of DRM_UT_KMS.
> > 
> > It pretty much tries to overplay the existing drm debugging mechanism
> > by either sending the messages to the DRM channel or just using
> > pr_debug. With DYNAMIC_DEBUG being disabled pr_debug is just an empty
> > macro, so all the messages can end up in /dev/null. We should not be
> > trying to be too smart, using standard DRM_DEBUG_DRIVER should be
> > enough. This way all driver-related messages are controlled by
> > drm.debug including or excluding the 0x02 bit.
> > 
> > 
> > > 
> > > And DRM_DEBUG_DRIVER should have been used instead of DRM_ERROR.
> > > 
> > > Was this causing the issue of the prints not getting enabled?
> > 
> > I pretty much think so.
> > 
> 
> Alright, I am okay with the approach, just one minor suggestion, to keep the
> behavior intact, previously the code wanted DPU_DEBUG to be controlled by
> DRM_UT_KMS and DPU_DEBUG_DRIVER controlled by DRM_UT_DRIVER.
> 
> Keeping that intact, we need to use DRM_DEBUG_KMS for DPU_DEBUG?

I might make that more explicit: I don't think that it is a good idea
for a generic DPU_DEBUG macro to be tied to DRM_UT_KMS. We are reporting
a debug message from driver, so by default it should go to the
DRM_UT_DRIVER channel. While refactoring things we might end up with
messages going to ATOMIC or KMS, but DRIVER should be the default.

-- 
With best wishes
Dmitry

