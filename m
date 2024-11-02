Return-Path: <linux-kernel+bounces-393046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED659B9B5C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C600A1C2114A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15828EC;
	Sat,  2 Nov 2024 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzXFLAkK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B7193
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505676; cv=none; b=odvPhFgHLorki1oYg1ZJ3m7EXixgCS9Ir4mdlXUqlYBC7LT1RbYA7cgqUZ3cmRZfj2oQNmGAvxPwvrlBz7RxrrnCQ5ZniWX/yuJX9jX3TdcUTRm8/0RUgUqyioG2GINuG0zG3MpZGqxPRxZcNvn3QwSYhnZxjS1GZ4aGI08IyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505676; c=relaxed/simple;
	bh=oO5dEtCYKHA8WVp/y+Q9JDrwAquCxvO29vbUzO+v2dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duxAJszyS4B2cboKlouj27LtHn603g+qpj9TamCslTtAoclGv8BdTjwMUkwAivL96K+9WyKpC4Y+9wEUt7GPykGgqXqCAVqVuh2WJrHXrcJ7wQ5FE44Kzx05nETkcymXiirBE25NnGCvg2Y1oZwlyN0ZX5kLkWm9sZHm4K0gIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzXFLAkK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cceb8d8b4so15941695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730505674; x=1731110474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQlnDsBGBd5CAx+c3fZXd9BvBPvh5/l0g6m2gnycK5Y=;
        b=IzXFLAkK4rg/e4nC+3QYtRDyQt8/r2/CAkFrg0Rh2w2ipqLNvKkjKXsWvb/G+5N1cx
         OIv/qYPd8tNqR6rG4WrI83xWzmvJUnrYDqZT9STjEDBGlz/3tF8VHDtBUE7XVso2Xgia
         5t8gGDpstLgVHyr7Vpj+bnyqXR0X9TR9thfCousC47NnTMnMzoocXBFHREXvEfuc5hGs
         z6ARfljX9LRgzjzD0+MnWxjPlIGM2fpJ/xnxHTrz43S/MGm+Lj0Uobolv1WISgRl32pB
         SB4RkucQ+I7gf8hcTbCXrGhYEvitpvnM+oa6LQqmooAEjiM2CpmcUTNjjhdUDwVK5Ebh
         K+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730505674; x=1731110474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQlnDsBGBd5CAx+c3fZXd9BvBPvh5/l0g6m2gnycK5Y=;
        b=icpOzkvL47jf+PtbSg46Roe0qij9yaxcJjULuHEk2CpMoSdyr/9Da0Z5HOhuvfRxoH
         IrVFDgCNnEWlsc5WTqR5SlK0kGXSwlnJd+xOiLS8ckVDlEZoFmp05KT6neWaZzrURdvq
         7p4Yevu1/KtKL9l2PKWIo7km7XSwXlRdO9FF3TvSuyRaex+KR+3SWY/4d71tubJkJXcn
         DoQ3X8FDa+nCyN9w5lX1pB5SdxQ6pw3psBRYjy+to3nZS8rzeVG6e6K3IaxT3tbpgz4Q
         X0jfwXAy+Fyz87QS2grZcHpW0QNPi+m+Lj0SN4YcXlD/fJzWZ0un+RZfsLDfLkMBxNCD
         Sjvw==
X-Forwarded-Encrypted: i=1; AJvYcCWtiNzty+2Y/AoT+DDyou7eTMeCgMV32O/T8wQspRh7FTniWOee6+HRWkriSprDwzG94qv1lITg9M0GuFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxas1AJtNgqO0euuB2cdv30Thk/BBupjRk9QLBrDAOYwYawThwZ
	J6DpUBvYoGy/pJyM/KL5SUAtgTP26a9ZNnej1LtqygzGQhAfc3bItzQW99WphAXQmsOkF6G6AhK
	0qE/G4BAI7jSJfdI6uE74Key5oqo=
X-Google-Smtp-Source: AGHT+IEnrcAVcZXkp/niZpYU2l8IpIjNYvOacuB+pzIpPD3b46rCkHvlbrWia7qukikf0ww499n9eAGJYXsuaqXBQrE=
X-Received: by 2002:a17:903:2a8b:b0:20b:6c1e:1e13 with SMTP id
 d9443c01a7336-21119468f38mr80067875ad.23.1730505674296; Fri, 01 Nov 2024
 17:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029084859.135172-1-gye976@gmail.com> <6um3enfackjotwj2ikhvpbnyq3ocro34b5iahx72yhzfxemjsn@xqnovtxzsapb>
In-Reply-To: <6um3enfackjotwj2ikhvpbnyq3ocro34b5iahx72yhzfxemjsn@xqnovtxzsapb>
From: gyeyoung <gye976@gmail.com>
Date: Sat, 2 Nov 2024 09:01:02 +0900
Message-ID: <CAKbEznuRLDwDhuYi3WwWR7GWbvu0oBCB53UF_4Yr+FpScYmWDA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/xe: Fix build error for XE_IOCTL_DBG macro
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >--- a/drivers/gpu/drm/xe/xe_macros.h
> >+++ b/drivers/gpu/drm/xe/xe_macros.h
> >@@ -11,8 +11,12 @@
> > #define XE_WARN_ON WARN_ON
> >
> > #define XE_IOCTL_DBG(xe, cond) \
> >-      ((cond) && (drm_dbg(&(xe)->drm, \
> >-                          "Ioctl argument check failed at %s:%d: %s", \
> >-                          __FILE__, __LINE__, #cond), 1))
> >+({ \
> >+      if ((cond)) \
> >+              drm_dbg(&(xe)->drm, \
> >+                      "Ioctl argument check failed at %s:%d: %s", \
> >+                      __FILE__, __LINE__, #cond); \
> >+      (cond); \
>
> there's a double cond evaluation here and given any expression can be
> given to XE_IOCTL_DBG(), this doens't look very safe. I think this would
> be safer as:
>
> #define XE_IOCTL_DBG(xe, cond) ({                                       \
>          int cond__ = !!(cond);                                          \
>          if (cond__)                                                     \
>                  drm_dbg(&(xe)->drm,                                     \
>                          "Ioctl argument check failed at %s:%d: %s",     \
>                          __FILE__, __LINE__, #cond);                     \
>          cond__;                                                         \
> })
>
> as it then evaluates cond just once. Also the generated code seems to be
> sane compared to what we had before too.
>

Yes, if (cond) has operator like ++, it will be a bug. I miss that...
I will revise a patch again by referring to your review, thanks.

> And I also needed this to build-test:
>
> | diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> | index 08cfea04e22bd..82585d442f017 100644
> | --- a/drivers/gpu/drm/drm_print.c
> | +++ b/drivers/gpu/drm/drm_print.c
> | @@ -215,9 +215,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
> |  {
> |         const struct drm_device *drm = p->arg;
> |         const struct device *dev = drm ? drm->dev : NULL;
> | -       enum drm_debug_category category = p->category;
> |
> | -       if (!__drm_debug_enabled(category))
> | +       if (!__drm_debug_enabled(p->category))
> |                 return;
> |
> |         __drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
>
> as otherwise it complains category is unused.
>

I also submitted a seperate patch to fix '__drm_debug_enabled' macro,
from '#define __drm_debug_enabled(category)  true'
to     '#define __drm_debug_enabled(category)  ({ void(category);  true; })'
This removes the build error caused by the unused 'category', too.

Anyway, it can be build. I tested both cases.
I realize now that these two patches should have been submitted as a
patch series
I'm sorry for my mistakes.

Thanks,
Gyeyoung Baek

> Lucas De Marchi

