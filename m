Return-Path: <linux-kernel+bounces-576062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19654A70A98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD9317535A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA051DDC2E;
	Tue, 25 Mar 2025 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsP6jvLb"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151FBA50
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931320; cv=none; b=DcFVtbyHtIwsoBxVbySArgHAmCkLzSgiosuM+o2Xdti9+gC/igSpeyLmlPiTtWMyKBOgA6eH4tbt+Nnv8CqHb6wxp2LkIp4xh2d5WBGpQJ6O6Bq1y3N+m97RKJGAnW9+RXm95JdCqp2JMZWTWLIwG+C7pVLeuDwAfDq1bk24J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931320; c=relaxed/simple;
	bh=0oW8ZhLEnQtMqlbuYx3wlQprIlFWVLs0KdOamwqzHw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dx2F7hq47EteeOIYTR8PMXP4bAtz55nHkoJt3AkTLwFzVYVAzAyD3hz1E4TKtJIGqnUFxQOfkvMf6yjG0eDe2kQDpcXVfzN8Us6gsrtUMNAEgLWaJz3qfwASURdOQg1u4kFN9psbXCUWleOOILZl0K2zyq9yZtStOu0i/x925Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsP6jvLb; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f6ae4846c7so58420577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931316; x=1743536116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42aHX7MDOHSOMSp6xeS+nFUOuh+iMMc1q+a6ux7j3PQ=;
        b=JsP6jvLbiTNmNFqyO0lejpn+S0NVggVeU0hYYl0maUpul1XMmORnlkRro4xp4J4Vj2
         amfVLTYjruoV0aK1I/ryqMbNupXeLB4F4vvSgrpUTuTZ9DYUeynkR9rgr1O4+seYnNfO
         ZTNRtRwdEnOQBcfnFeFq3H2krEN34CA5vjg4Rql5tTNfXoKE78BqrivjLnvIkMyH8iE3
         rkb5k5SN9Q0BWdhvZnM24rQg0Oklfp3jRs9wO8X/ysvBSIK1eJeietva7+AtHxkygvZD
         QjnH5ubfo5iF6x9rbkY/gY/POkf6NKjbis6xWRIWYf0sRW0FVSuF5dIvLdXzN4XCWZEd
         KwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931316; x=1743536116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42aHX7MDOHSOMSp6xeS+nFUOuh+iMMc1q+a6ux7j3PQ=;
        b=IKtR4S+FmPNxBe7pBOBMmzxWi/aRgKXDcSHRYeMsdew70JPD2OMKs2j2mF/n0av/K3
         XYcD6JNGxju6cejnha0rrMfMMhwtIX3+0pJ829+V2QbJSNfs0YhtkNfmQx38o8ZiIwn4
         iMcsztPoL8mcQULD8qRSgyvgGsewoBj6DbBNUMyR2UbaQyKZ/W4Gy/x6D91KIGYYC1R8
         wduSM9NFcBwWK60VLus9SolYXjg39fAoL8GtbrikczdFbOVghQaK3i3JhGzISNTXHWgD
         8DcII3TjLFA7JKZtMMTpLfSlQ3fZIbPlP0LTVoCmu7ebURn9yawWRB3+owuzKYMoeEjd
         tDrg==
X-Gm-Message-State: AOJu0YyrjoLpO4atO0uEsAEKOcvy720edCGn/gmO0VllEUDzG4G2cqux
	oZYzJ7E6+TftUxjb0ejyG5PBKTm3kmX7MimF0j5JqzaW9sDW8jsOX/RVNhrfwC7FsApTHT6duN0
	hMdLBkXJxBgWwIJ1oWNRKAAIM2UY=
X-Gm-Gg: ASbGnctAdqj6YYAuMh7nXh7G+mBEWlVrMSA0GUeksabrakRiJOj6cH8WW1FyUcoU1+E
	8L41JwwYs6LgNIrKsPWvyN6UZrTYZtdoU18gQZtXaa5rSnpFDqOaHbeIUZGV0xMJ41I/Mx7GGCh
	GvgC5Yo4ZidkzjZn3FA+Pr9UO8
X-Google-Smtp-Source: AGHT+IHATNylw+gsEglZW+PXGiyYbRxUfbKIQGJtdl+fH3JTfXNCfGYjHvngrOpvTsOSzlZ94tSCZQ+ubU8QCVnzCek=
X-Received: by 2002:a05:690c:7512:b0:6fd:4473:5184 with SMTP id
 00721157ae682-700bad025bcmr232347107b3.35.1742931315686; Tue, 25 Mar 2025
 12:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-48-jim.cromie@gmail.com>
 <bec1c938-aafa-49cb-b173-5b876f77779f@bootlin.com>
In-Reply-To: <bec1c938-aafa-49cb-b173-5b876f77779f@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 13:34:49 -0600
X-Gm-Features: AQ5f1Jqa1QuPUv1TyJbyyX5GCLsktpgCTY8YYNpeF7kzWCBGQI4AZHsFZX61b_g
Message-ID: <CAJfuBxyR_x7tKUFZppXFA_dKFaXb9gTkGnZYfP5GGA7SnorScA@mail.gmail.com>
Subject: Re: [PATCH v2 47/59] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:03=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/03/2025 =C3=A0 19:52, Jim Cromie a =C3=A9crit :
> > tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
> > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy by telling dyndbg that the module has
> > class'd debugs.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> > ---
> >   drivers/gpu/drm/tiny/bochs.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.=
c
> > index 8706763af8fb..dbcc8ba70dfa 100644
> > --- a/drivers/gpu/drm/tiny/bochs.c
> > +++ b/drivers/gpu/drm/tiny/bochs.c
> > @@ -59,6 +59,8 @@ static int bochs_modeset =3D -1;
> >   static int defx =3D 1024;
> >   static int defy =3D 768;
> >
> > +DRM_CLASSMAP_USE(drm_debug_classes);
>
> Do we need to add it for each driver that use drm_* print macros? Is it
> reasonable to add this directly in drm_print.h, so there is no way to
> miss this call if you use drm_* macros.
>

Yes, AFAIK.
Ive tried to invoke declarators from a header,
It never works out.

59/59 was an attempt to do it for everyone, but it falls down...

> >   module_param_named(modeset, bochs_modeset, int, 0444);
> >   MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
> >
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

