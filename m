Return-Path: <linux-kernel+bounces-247166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D992CC16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A40F1F23851
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6231284A21;
	Wed, 10 Jul 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlHuowNS"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43479B7E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597237; cv=none; b=a4NwuCHgMjDW4t+LpkX7yBaSEFmzzgPY3HsLUrO/fBYYqIKfeRXV6NLM8+BuCXB0tLmoSgES4t9tuTqDjR9P9ldHs9GVQAaZRqvXBo7upSIVdBA19ZMdd8EzLAxEwjwqF8oAtNaOuZbb60/VtHDoY1JRci8pDtcjYUtbp4QXDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597237; c=relaxed/simple;
	bh=p0pIjWdjYBoLNLQTXm33zgWRnyRngTjMHsxKZmFA36A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEnatGxa3BLeLcz4KAlzl9MoK2gj9cMeaV4X3t6Z0OY/a97C57QB8PNIEYVGnCNQhzoqtAgYA+Ad/q8C+yv6MaDBU81LtLZqVWpYjVUYitopTAavE/8cO3vj1oOOp+vUGjR62b9L5aaM5Bo7DVoBeMf+P3xy+X6TdYiQcahakIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nlHuowNS; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e04f1bcbf84so1057242276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720597235; x=1721202035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjKb2nGH0uufgiLhroJNuFFSjoPflP4yKTqfadCBBO0=;
        b=nlHuowNSGaeoa+hlJDvfz1S/7o2HTBs/Ky1gWQzRcn/Sq4z51fYQuB0OMNYFclAM4l
         IHZd6VrxLfdTPYhDC0uwQssp/UAvNAchIXxcMc/dZ+AnBi14Kp02N3pZYs/IAiRu0+V7
         NucCSECxKmBw6XNSp+YoclZuj6Bwsfm+B1C2nz5PRbxwD+TUIqavn8BH7DVPj3QN0Cq4
         iTv2qUMIrjN4WQKigL8gmzhegyH138GLhM/bH4qYntrcadkxdP7IdwvSpo9Pq/QfSeEf
         Q/X9HnswRFZ5kENZi8vccxzmywhNz/k8df20PR009N/dO7Q/kw7z2TZNe1i5t0UJtcFd
         Q/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720597235; x=1721202035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjKb2nGH0uufgiLhroJNuFFSjoPflP4yKTqfadCBBO0=;
        b=pPkL+d4CzjAIY6noAa2o+FcJcXvGK5geKghjfkoH3Y3KuScjmE+2PEkuFcGdmHAFen
         3FVVdMDvMJoBphKEJbKOPRPNfpyvKK9VoCNtYYjPJ8JtgZDKuaQalX0sitTOVC55fV0a
         CeG7o4rYs+dQd6XTQmmZ/CaNJypi9nSa0detdaVOpkAZfCPnCcBuu63+Y0vR8M4dVs7g
         FWW6Zv+2pjz+NPMA2F6R52RXenWS4280oyiBFOVJyi8s7TFfBAMurinekdjt9GBD846e
         vYAImfZQkdeGQHxTby0NHVIy1+EGsy+iXpBD19WzitT6yy7ka+0xSmG0nBiOWgvAkqcS
         EgEw==
X-Forwarded-Encrypted: i=1; AJvYcCUiPuAEy/h+Bcb4ebaLXaU/vpPhr6l00vtwwlm4ye39Fa/uXn7UinNIwKbwY0NU9MF/MqQJyRfuILYenU9ZfVSAoRttWPGl5uqnDv7k
X-Gm-Message-State: AOJu0Ywk9K9Wi+dOn9MSWOIK24IGcbK67tSLqwTm2VQYVBDua01wTAjI
	dUUgSKMQoA/60S2D6uvHmxi4OAYdsXXf7Kic361ocsKUMTrv4JKEVSl7eCAFfQ0VE6vWZeHLBpe
	RiqtHSsKlglPHNV0XGZoYcPkLr1lqhwoIrreR2Q==
X-Google-Smtp-Source: AGHT+IH/sNttlz7iEcuuUfbPUqCuI5UQBYVSoBT/R+GVBSmPgZ4m9GAISSCZwv88ItHVb+x6KfGQ+5FMLUM7PbL3uKE=
X-Received: by 2002:a25:800c:0:b0:e03:6533:136d with SMTP id
 3f1490d57ef6-e041b12408amr5399518276.40.1720597234909; Wed, 10 Jul 2024
 00:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org>
 <20240709-dpu-fix-wb-v1-2-448348bfd4cb@linaro.org> <46487222-6818-b0bf-e5cc-2310d62b5fe6@quicinc.com>
In-Reply-To: <46487222-6818-b0bf-e5cc-2310d62b5fe6@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 10 Jul 2024 10:40:23 +0300
Message-ID: <CAA8EJpq7Lp-3V_AsLxO9ZOt8ZW1ZZ=FjhXV6R9jvH=sQ8XQE9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dpu: don't play tricks with debug macros
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Rajesh Yadav <ryadav@codeaurora.org>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>, Archit Taneja <architt@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jeykumar Sankaran <jsanka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 22:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 7/9/2024 6:48 AM, Dmitry Baryshkov wrote:
> > DPU debugging macros need to be converted to a proper drm_debug_*
> > macros, however this is a going an intrusive patch, not suitable for a
> > fix. Wire DPU_DEBUG and DPU_DEBUG_DRIVER to always use DRM_DEBUG_DRIVER
> > to make sure that DPU debugging messages always end up in the drm debug
> > messages and are controlled via the usual drm.debug mask.
> >
>
> These macros have been deprecated, is this waht you meant by the
> conversion to proper drm_debug_*?

Yes. Drop the driver-specific wrappers where they don't make sense.
Use sensible format strings in the cases where it actually does (like
VIDENC or _PLANE)

>
> /* NOTE: this is deprecated in favor of drm_dbg(NULL, ...). */
> #define DRM_DEBUG_DRIVER(fmt, ...)                                      \
>          __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
>
> I think all that this macro was doing was to have appropriate DRM_UT_*
> macros enabled before calling the corresponding DRM_DEBUG_* macros. But
> I think what was incorrect here is for DPU_DEBUG, we could have used
> DRM_UT_CORE instead of DRM_UT_KMS.

It pretty much tries to overplay the existing drm debugging mechanism
by either sending the messages to the DRM channel or just using
pr_debug. With DYNAMIC_DEBUG being disabled pr_debug is just an empty
macro, so all the messages can end up in /dev/null. We should not be
trying to be too smart, using standard DRM_DEBUG_DRIVER should be
enough. This way all driver-related messages are controlled by
drm.debug including or excluding the 0x02 bit.


>
> And DRM_DEBUG_DRIVER should have been used instead of DRM_ERROR.
>
> Was this causing the issue of the prints not getting enabled?

I pretty much think so.

>
> > Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h | 14 ++------------
> >   1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> > index e2adc937ea63..935ff6fd172c 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> > @@ -31,24 +31,14 @@
> >    * @fmt: Pointer to format string
> >    */
> >   #define DPU_DEBUG(fmt, ...)                                                \
> > -     do {                                                               \
> > -             if (drm_debug_enabled(DRM_UT_KMS))                         \
> > -                     DRM_DEBUG(fmt, ##__VA_ARGS__); \
> > -             else                                                       \
> > -                     pr_debug(fmt, ##__VA_ARGS__);                      \
> > -     } while (0)
> > +     DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
> >
> >   /**
> >    * DPU_DEBUG_DRIVER - macro for hardware driver logging
> >    * @fmt: Pointer to format string
> >    */
> >   #define DPU_DEBUG_DRIVER(fmt, ...)                                         \
> > -     do {                                                               \
> > -             if (drm_debug_enabled(DRM_UT_DRIVER))                      \
> > -                     DRM_ERROR(fmt, ##__VA_ARGS__); \
> > -             else                                                       \
> > -                     pr_debug(fmt, ##__VA_ARGS__);                      \
> > -     } while (0)
> > +     DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__)
> >
> >   #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
> >   #define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
> >



-- 
With best wishes
Dmitry

