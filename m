Return-Path: <linux-kernel+bounces-576010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEFCA709D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1460A3A47AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D891A7044;
	Tue, 25 Mar 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO+teKn+"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3971ACEC9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929036; cv=none; b=c4ZTURqyU9j4dAxBup52yyfOJSDHyPvOnaudHhvSTvq+s4WQM/6TmephaHasABx25dSUQ2QCqxQR3jTizLqxol2FdyYG9e9GyurY2DUjM++luucPtujhtax49heIhwyAmHhDDinfd4pbluXj8TyaOqQbLpyD5KDAkYgcj0md1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929036; c=relaxed/simple;
	bh=bH08W7y44kEthONmxWs0JsMCJXv5WJd+1QRs+3Z1JkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN+weOJYdkJi+FWls0BR3LNbLsYo0eBERpcjMpUCrVEY5yDCzq/W61waAMnFP1omgCFnX8cjjV6/4alcr4xH3JBL5YftC3CXrzDxLTasaq9BVDHFZv7GLFNOVDmWkyiNJJalScLd+f0qw2aeeatclsAL/oXRNrmsSd9DM1r9SjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO+teKn+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a1acf61eso55450331cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742929033; x=1743533833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc1b/KonmqQlWVjQyIDNx1PB8OnyCz3qh1Tew/uSRf8=;
        b=CO+teKn+MWsezEymr5tFlJJ67bxc1yTMnTqg7KpfybKZzcvsaZ4FbA87hLfJT0SeDc
         u1Z/ka+qgkGPm5rOBVXIWmgWTc9sS9AImUzuSCxzF/ec4pfbS/S3fOkEAWSlwaG87PhY
         Taqy6L71nGQdX9lmfg4NftBqx7glRpQm4k2dTrdDfA8oGhm0yBw6WtRraHCzZ7X6YR6U
         zRV2zNIIF6070GhUK+xhKxY6OBwkxUnUf9mM8MMKx7EjCoSSP2WYqPKbQQ4aHDNpMHJt
         JqT72hbzBSAoDriyEVM2+BSS3Z/FVTTrKnx82A14oTjRGD1CllthyRtGQarYRswurnnA
         cn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929033; x=1743533833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc1b/KonmqQlWVjQyIDNx1PB8OnyCz3qh1Tew/uSRf8=;
        b=MsqPs1HrmKaH4eHVmDfjCm8GPvvb2x/qss1kKg/NsrgzGVTzq3DLQ0RliOGT2jDDwX
         oYkvVFwIVdNs1VM4Bul+UaVsO31d9kHgtDpS2z5G7HVsMkVHOn70EsP7+khyj1Rl+2b7
         spUCLna0Pqs8XX1fiBuk3qAVEOpz3fvdVshKEYt4eeGmy7fuC6xPYPhgEoLk/2m2q2IF
         KGNQs8Mi3BE+SPjqXfgKECTsMbB4OIIJfGL1rP0NREWtCQpAWwmZwoW+Yy2k4uaj+Y9Q
         zljLtdI4xk51ExEmFeCkNhU4igAyGjFWnwd6JJqB3YcQvy+jD4T3bUzzwvoIWVf+5Bi8
         lHBg==
X-Gm-Message-State: AOJu0Yzrq4bePD1+c8B5q+ElGBxLgGo8PCufdLIyqGr9EKOpEgRBuoiD
	QbBlqMmoJoenAk+T5V4qQ2/syvfn4YNdq8H6ZIJLejAzedYCHs49oiV2bAR+qWeFi3thmtbN8oI
	1rDrhHyOFHaLXkUtplJvldTfnZuuUZ2D2
X-Gm-Gg: ASbGncvbRVLFwUPVfT3xoxgf+yV+oVcg/N7FI1UheXaYXq/cupZ8JykqZdLxD3P41MN
	6ZRTb03HtOldAKt/LOnL2mVDnVZAFUBYyri0sM2YzgknXL8E65Uc/E7XI4XI3ycW5Wx9NoK/kHF
	XfO9w5HaW7hNlgJzrgTl6xjDYq4IV2HUIeoBI=
X-Google-Smtp-Source: AGHT+IHZrxz76tlBAchwWlwvG1UO5HlgQQvC8bUrjtin9ky9DD1ICNaN0M4Dchd5qiDKedF02gvCDAitk2nLkn591/E=
X-Received: by 2002:a05:6122:251b:b0:520:61ee:c7f9 with SMTP id
 71dfb90a1353d-525a84c5e96mr14236045e0c.7.1742929022532; Tue, 25 Mar 2025
 11:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-45-jim.cromie@gmail.com>
 <c3514758-5a22-4acb-8ff0-1f4ddade02f4@bootlin.com>
In-Reply-To: <c3514758-5a22-4acb-8ff0-1f4ddade02f4@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 12:56:36 -0600
X-Gm-Features: AQ5f1JqwCZoNQkWvPRC6s-f7lWQaMvaFRZI7Bln1P_k3mQTyHi7JUmVlxPTmisg
Message-ID: <CAJfuBxw_OixCp0KsoYu9nH6=hprKJpKt7dkPT0hL-32syCTJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 44/59] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:24=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/03/2025 =C3=A0 19:52, Jim Cromie a =C3=A9crit :
> > Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
> > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, this tells dydnbg that Xe uses
> > has drm.debug calls.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   drivers/gpu/drm/xe/xe_drm_client.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe=
_drm_client.c
> > index 2d4874d2b922..756dba5c88f8 100644
> > --- a/drivers/gpu/drm/xe/xe_drm_client.c
> > +++ b/drivers/gpu/drm/xe/xe_drm_client.c
> > @@ -21,6 +21,8 @@
> >   #include "xe_pm.h"
> >   #include "xe_trace.h"
> >
> > +DRM_CLASSMAP_USE(drm_debug_classes);
> > +
>
> Is xe_drm_client.c the best place to do it? I think the module entry
> point is a bit better [1].
>

yes perhaps.  I was drawn by the _client in the file-name.
Im not sure Im fully consistent, iirc the drivers get it near driver-iinit =
ops.


> [1]:https://elixir.bootlin.com/linux/v6.13.7/source/drivers/gpu/drm/xe/xe=
_module.c
>
> >   /**
> >    * DOC: DRM Client usage stats
> >    *
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

