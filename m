Return-Path: <linux-kernel+bounces-440437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4279EBDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4495B166983
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB61F1905;
	Tue, 10 Dec 2024 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4NpAPNE"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72932451FC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870153; cv=none; b=qTl0YOyZpitf2k0XL2Wiv/lIXK3lMMZOnFyv0zMl+NH5afU7ZnEPBVb6uWM5Z51PZ7a3+JcMN8YfYjeAHmxO1swswHRFk8GgTktAFJx5+V+bEsH7WdxT2FkD9fCoeraWT2g13lyYZTaMGIuKLULZUoy5u6eJZp+MenXwHydpxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870153; c=relaxed/simple;
	bh=tvt3zv+eF6/MbzKSgaDb44zYstTrL0JwPAz1hDN8QLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6MVzArdl1mNz6Ee339HBI9aDWYEjNiupMbd6cxbS3JdvSWkbfUHDSqfVxzuoFzCAXSM/w7DQdsnsr5R75VLWbf7R2y9IO+1uVqKett1qgwafvVeJgGBiNw03cYsxEAStAy/eSBvYpETxVzGNOPbfHLmJusDGPovHEcyWlZbK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h4NpAPNE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so4573616a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733870151; x=1734474951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SegVvC3hp1egRino8jTe24lodQ7Lif4l65T8hABKrm0=;
        b=h4NpAPNE15brYeKEwmKC3ndT6eb/3nMvwuvg/P5Eq1bih/fzWwYJzX1wiB5NFLYWD8
         MqkYgR0SkKy1meBqwXSjQ2A1mXws1rEckbNpM2RjlZh1aDZ6T4+MOBPlAcQw08yddmXd
         kIqxrE4PZN9O0TA88i3Uvk+dyvtbevtmOHdvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870151; x=1734474951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SegVvC3hp1egRino8jTe24lodQ7Lif4l65T8hABKrm0=;
        b=ITFuVlVsePFSANV+sajN3acgIAvSBmjtiwnOwISJ1pfVgt/NBtRLubhPxxxHByABza
         dZM/q2/fqnJxUuUbUnFiirTIS/8bU61dAcIJvLCag8qydUF7K6+O4+/BVJPj76X4VLXH
         Hv7s3cavWOQA2uNV8sjTlneCSHLY2LXxJgiTdkzc5ELMsbQq35niZT1OZNV5M8GPqOjj
         fjZSslDUrp5Ae46ow22Ej72/I3/wKE169CyyqhLbhDB2xrvbg/oNz2euAdRRX1+ranMd
         8rxv2nlsQYJyP42nlsVwLpabjpvFFUSpR+xq25yP3brvPuMgmfTHXWu1W6AR2X8+gzxI
         cL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpHO0hIxslpO2oukFIFQSIEcycwmXan1YC6Lkq/pKbBpCXPQ+Hj6p4/uxFsrziUsIcp6UJM3TZNHVUf2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyDbjPSmTHerxGO6+lrkXpmqwzXUhFUOgISypdIfiCPyD5oAq
	lvi67SDQrHLYymrtHGQd7a9YPpv4H9j9reC3BsHezNDpVwR9ufgmOR2kbF+iqJRIHaU6Xo/70po
	=
X-Gm-Gg: ASbGncvtPAKUd+lyUuk1zPZ/argrVchf4XtNn2mT4ocragUwHWEDAxwJS75z/PuVqZg
	wUHctfENhIVSJSmmVH8X8SFxcATWrCcykZCijU0EclJNwU4agpH09mayVVk2pK3pd5pEQE5uNyB
	d2iSoZ3mwJb37vaKfy/1EerlpqVXXxLuOw9vT3UIr03+SLIwLFt1YqoefQn4/0jvIYXKlpOW4kG
	yzJEWkmgP/ni/phG0LBZtUU5vOkFs0DHWRQmXmbopJRXfzOvWfvMde+6TTwCIge9w92IlO+VXxg
	jfiKiq1aCTnJHkWRYD+T
X-Google-Smtp-Source: AGHT+IHozJGpWgEw/g4SzOTVkfIkUZF5h2qureDvViYEn7VDKtIGBfKwyZywyijDLJQX0fh3YHe5iA==
X-Received: by 2002:a17:90b:4a4c:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2f127fc9d72mr938218a91.11.1733870150829;
        Tue, 10 Dec 2024 14:35:50 -0800 (PST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff77b9sm10323471a91.36.2024.12.10.14.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 14:35:48 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd51285746so1861026a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:35:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZGdB8VPq1eXg3O24GAIGXIMilmY/VH/7bBkAzqv/4rhN05IFwPR11iFAj8bseENIGdDNgX23wye8RP34=@vger.kernel.org
X-Received: by 2002:a17:90b:1c08:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2f128032323mr929730a91.27.1733870147516; Tue, 10 Dec 2024
 14:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org> <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
In-Reply-To: <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 23:35:35 +0100
X-Gmail-Original-Message-ID: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
X-Gm-Features: AZHOrDk0jwuT4BPdDBgtbco-BoT1AXVUFGOsS3tfXUhEEPMwjjkEUWAtW-dj0G0
Message-ID: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_device_hid that can be used when
> > CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 4f1b3a6f107b..c25914a152ee 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > +{
> > +     return "";
> > +}
>
> I wonder if any caller might expect something of a string if provided?
> Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> function returns "device" when one cannot be found (dummy_hid in
> drivers/acpi/scan.c). Unlikely to be a problem perhaps.

Good point. I changed it to return "device"

Thanks!

>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> > +
> >  static inline acpi_status
> >  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
> >  {
> >
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

