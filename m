Return-Path: <linux-kernel+bounces-219968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495990DADF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FAF1C23E35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C414882B;
	Tue, 18 Jun 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PT7DohMB"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF1148820
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732616; cv=none; b=GcAiZiF5e7l4F5GZZtyMIRYAUt42EXtCgoMM4ifVlDZ4/QBCoeslMJfDtyZCaV6RCuKuJHqP6/1iw4mlXYS673z+LNNTJwh6VZANHaOhvOR2+/19Mzh10WT6L091ZRgjkz7OEAO3gRPNBOzzTj7kjtjlUd6nKY5aFWgF9tVrw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732616; c=relaxed/simple;
	bh=bzJ77FORJG6SIszBgwjpM7mjsiZfg+pfxuOi4S81zVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAk676Z6CLmd0rTvgAybtZfK8yelQUxqY9/XkXnpm1H1ccABf7gHIIZ8WNF5WUTAjgW/LyypYbsFZdWrBDTEHQwiJ0wtD5h5yei9iEDoNSGhUaST8hB7xvBY9uKdtJo7j9UUcU0WaOsP8EAhM9aGXctqThEfWrsAnn137OIegIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PT7DohMB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso95948781fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718732613; x=1719337413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UW3m3IVDCbgoGWkqOyhGrTXzXIbL2Q1j7KVjTgGLhLg=;
        b=PT7DohMBkq/+W6jUFpievCqLrugL6O1P0nQSDpTVgXhSgmsv+JICw6N6QdV0Dd9AbF
         i2gTJaLz5l8OytWAqi4cSAw6mRajX2T28bNbvCJYjQ3RWD3zqLCC2bCXlvd3yLQwWB6i
         CsI8L6Nhg/dbf3bNIxh8+vgROK4xNNQ1958xNaliBO7iMT/HM7Z+Zn/ND1LnS/GOhyp8
         I6D+pVxgbIN8RYwVWEBneBUa+RqB3xQl65wFZgSCvIA4+kiiHcIOZJz/kr5hZ92SPUEF
         ATCD4IH4w1XVs7VBBdncEdXUf4xbrxSWJr5ut3fW5A5tLTVp6Z3sPceLL0OZ5/NwMw+A
         WX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718732613; x=1719337413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UW3m3IVDCbgoGWkqOyhGrTXzXIbL2Q1j7KVjTgGLhLg=;
        b=HBRLPf6dou2A65uC21LjSfLwSkma3H+SorfTg2PCRbQg6PnijeRmWuymCucjJ6gJ/k
         fsdzmOouXNsqDsKXwZXh26xfNIiEUC+f17rJGSsqVWBwYfGqhWvd32q5UXervzzq19i9
         vkFjuW7vCY57qcsRuxvWHaKQDWjJ2vt4GxWeULUl601LdMfooX6oZM5FzexKJsSv5mFv
         6RH/geZfF9n/NWiYUEOYfBx778lvHfqQSgOtT/O7RxPHLsfUgAHPXtb7A08GJY8PkoiQ
         MsIy9tanaH/ADeGXGY7OsN4rne5hanSjh7/76TLl0nme9kuU1WSAnd7wRv1cA24n/k6p
         Bevw==
X-Forwarded-Encrypted: i=1; AJvYcCXk0BgIIzTr2gqrEZOshIo0rDVNxPC6Jr2/iy0TtPUwuYvbSzF5Mh7wTr19MqaYbVSKaRADUc2yBn0RiuJH5fVZv06DGWwaED53zJxa
X-Gm-Message-State: AOJu0Yw4nIKqiBE9adTb2xQEvq/ow0iU1JapWBDyhyCBjYAQWs1mGPrj
	CiZ9PTQjaM1iYA8sm9Kv5jU6sIPmXUwhPYg0a2R+1Cqmq44+fdJoS//D7bN2Buk=
X-Google-Smtp-Source: AGHT+IHqgDsYBrSMyIeMIZAipBnP2CCm4mOxj6zvMMUSinXZl5+Bwzr+RzB97A5TqXTmpBeosa9Onw==
X-Received: by 2002:ac2:59db:0:b0:51d:9f10:71b7 with SMTP id 2adb3069b0e04-52ccaa33e25mr244374e87.28.1718732611978;
        Tue, 18 Jun 2024 10:43:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2884064sm1619765e87.242.2024.06.18.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:43:31 -0700 (PDT)
Date: Tue, 18 Jun 2024 20:43:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, 
	Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
	Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, 
	Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Boris Brezillon <bbrezillon@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v7 2/9] drm: Support per-plane async flip configuration
Message-ID: <aflfggx2dc2p3y2a76yecjgmahozmbpnkk2qpekrnkpvviih6i@g2uuxeubozbo>
References: <20240618030024.500532-1-andrealmeid@igalia.com>
 <20240618030024.500532-3-andrealmeid@igalia.com>
 <878qz2h9pp.fsf@intel.com>
 <CAA8EJpqM4iaG3PKM5c0Op7Y7c1SRDrOCk_oOnwG8YfdCxC8w6g@mail.gmail.com>
 <fc67b552-6f61-4f30-9e34-dd6b2364d155@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc67b552-6f61-4f30-9e34-dd6b2364d155@igalia.com>

On Tue, Jun 18, 2024 at 01:18:10PM GMT, André Almeida wrote:
> Em 18/06/2024 07:07, Dmitry Baryshkov escreveu:
> > On Tue, 18 Jun 2024 at 12:38, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > 
> > > On Tue, 18 Jun 2024, André Almeida <andrealmeid@igalia.com> wrote:
> > > > Drivers have different capabilities on what plane types they can or
> > > > cannot perform async flips. Create a plane::async_flip field so each
> > > > driver can choose which planes they allow doing async flips.
> > > > 
> > > > Signed-off-by: André Almeida <andrealmeid@igalia.com>
> > > > ---
> > > >   include/drm/drm_plane.h | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> > > > index 9507542121fa..0bebc72af5c3 100644
> > > > --- a/include/drm/drm_plane.h
> > > > +++ b/include/drm/drm_plane.h
> > > > @@ -786,6 +786,11 @@ struct drm_plane {
> > > >         * @kmsg_panic: Used to register a panic notifier for this plane
> > > >         */
> > > >        struct kmsg_dumper kmsg_panic;
> > > > +
> > > > +     /**
> > > > +      * @async_flip: indicates if a plane can do async flips
> > > > +      */
> > > 
> > > When is it okay to set or change the value of this member?
> > > 
> > > If you don't document it, people will find creative uses for this.
> > 
> > Maybe it's better to have a callback instead of a static field? This
> > way it becomes clear that it's only relevant at the time of the
> > atomic_check().
> > 
> 
> So we would have something like bool (*async_flip) for struct
> drm_plane_funcs I suppose. Then each driver will implement this function and
> check on runtime if it should flip or not, right?
> 
> I agree that it makes more clear, but as far as I can see this is not
> something that is subject to being changed at runtime at all, so it seems a
> bit overkill to me to encapsulate a static information like that. I prefer
> to improve the documentation on the struct member to see if this solves the
> problem. What do you think of the following comment:

It looks like I keep on mixing async_flips as handled via the
DRM_MODE_PAGE_FLIP_ASYNC and the plane flips that are governed by
.atomic_async_check / .atomic_async_update / drm_atomic_helper_check()
and which end up being used just for legacy cursor updates.

So, yes, those are two different code paths, but with your changes I
think it becomes even easier to get confused between
atomic_async_check() and .async_flip member.


> /**
>  * @async_flip: indicates if a plane can perform async flips. The
>  * driver should set this true only for planes that the hardware
>  * supports flipping asynchronously. It may not be changed during
>  * runtime. This field is checked inside drm_mode_atomic_ioctl() to
>  * allow only the correct planes to go with DRM_MODE_PAGE_FLIP_ASYNC.
>  */

-- 
With best wishes
Dmitry

