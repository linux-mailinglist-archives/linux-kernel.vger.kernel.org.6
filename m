Return-Path: <linux-kernel+bounces-440220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373D9EBA63
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E683283D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52905226892;
	Tue, 10 Dec 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EG21YSAt"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592F226181
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860571; cv=none; b=uyDY3gZBk+xHqy64YE87QiXL8BAWCbnCBM1192e/0u4NyEEnfUZ41E0Gt7UrNl0+l5OeqEwFPmFSyzKQkxu35Wn3An2WDyCUBo0zQxToIixaxRe8sT3lF8gzqJpgh7EltmJQeRK2fmXIg9L/PSF0XlLKnTdA7SLN9gLnL/3XiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860571; c=relaxed/simple;
	bh=e6N+GiKT6QGfW61aH0GmQOtN0oMTDgLGk2yx2uhx9Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pa5b7LnDFl45PASwTVzKVAIDdvKDrqzFZHsfz1kNVjZxHdBOEsyzVDcw5PoUNJBULE7EY9ETmB0+piJHBJ8Ys1zi4ACqJVYO/TW9VO5xto82YxA3BcnQU8+lTAUPL8+vXaIOVdKUNzjVlPv4gJ7QqViajdzO6u2O2qJSFZhjIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EG21YSAt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e1799d95so1172311b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860569; x=1734465369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhVnUUt21FbgPDOVIQ39erkKtCV93uZ7UVN8hJAABAg=;
        b=EG21YSAt3XH3jRunxQRZkV+RmSKTIQ2YMRAj8UoO7TvkgSFs+omu2U5x/awxNE0v5y
         xxgSaO1Z8BO0OG51bkqPhJRL1EwefcSfh9zFFd5PTjmCjSHEyaEgBYNZJzcHDFCMO1Nq
         DGHu56pLpEmckiC/ZNy+7tzZHRgPtX/48ngIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860569; x=1734465369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhVnUUt21FbgPDOVIQ39erkKtCV93uZ7UVN8hJAABAg=;
        b=RhlnNOHgHrgespd+q0WH1P52R5bR+EB0iJQ4hZmimWdhTrWH7H0k2DFdRyycY8erQk
         RXwykAYRnIHhauY8ksvSqj55KL9PZOojklaFy2XuETOaXktAA80LJnvjbeASFb6b8dRO
         ycGV2xfFnla6y06iEK+XZH+LmNszixJlJc7rYKYtqDB6EgdG+z7S7bf9ppnXONwlsHFC
         BdxpbxofyhWO4rfrC0I4qVNXci6JvNC5E3QPoOeIj72hLkQTAvimHRVAWb5wpwCV0QnB
         FqM7eaB7NcHeuGSZFjR2gTG3vdvmxrY0o8U3Cxow1UAl2qpjZ/L3l2qLIWV6qEPL1+if
         mEYg==
X-Forwarded-Encrypted: i=1; AJvYcCXs0mRwyU1hi0FqDORj6ogQeZbJOvWoxTE4rb3deJY+DzJGi26NXd1h+XqADny4Fm+US7e01yB9TTNAweg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAC2JZO5EhEwL6zcZ1Ok96EFdowOaJnuR4+P/hd+LuNItQQ5H/
	trDbKkCBQzpGUilxb04UR5AgOVGhNzEdCNJ8f+CpBVqsNAQn/+ROECHsGL+afRJE3HRRYZZjkuM
	=
X-Gm-Gg: ASbGncupIu+0kbvecT7OG8Y6/j3mrBPV/B9OpB2L1/inDBJMHQ9FMhOSTUsiXahRNFM
	S8gMFvwW+x0sYamcDCV/7TPYWEQQfDVIyGlJK5Gl5vlh5w5ZVA9s56qdDSi5sUSa6SeRN+xeOX8
	b4vLyFd67Tws8jDGFKkUKG/ZlY0+jbbGj4RPWrDzfKx0RB8LfW6eqmhrUhZax4Tkvk2vkdhafke
	HRxc4DASBuo4UF9GK4J6SPZQMLU3GehzM/BpeRhKpcMhXBRlHrZxcrAoh8UT6M0qxqGJZcFTq7m
	PKrz4iLkDeAC4GRb
X-Google-Smtp-Source: AGHT+IERCODtF9w69N6jFS6sU7rpUdsj0xS8ab78nhh9e4esn1iw4kizkJxUGrUxEpaPP4wDzuOkng==
X-Received: by 2002:a05:6a00:3cc2:b0:727:3cd0:112b with SMTP id d2e1a72fcca58-728ed3bed65mr371559b3a.9.1733860569149;
        Tue, 10 Dec 2024 11:56:09 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725df133a56sm5590704b3a.69.2024.12.10.11.56.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:56:07 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so5116497a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrykuRhROorRF9LoPA9a1P3jkJCTvDVgNkvKh7kSuHrnJPhVPsWUmAWD/+jOystEmZab0HIRimH86aX7Y=@vger.kernel.org
X-Received: by 2002:a17:90b:4c84:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2f127f50d18mr438841a91.7.1733860566933; Tue, 10 Dec 2024
 11:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
 <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org> <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 20:55:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCsYcQBzUzjACQdhASarR9Ad4bnD035+DZzJnrQboXVDAA@mail.gmail.com>
X-Gm-Features: AZHOrDkADV0-JEZsLMswWL8-2MF9FWIqIKoMqh9rPKxVkdv7pvHri8tCHfHVYAw
Message-ID: <CANiDSCsYcQBzUzjACQdhASarR9Ad4bnD035+DZzJnrQboXVDAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 at 19:31, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 22, 2024 at 10:48=E2=80=AFAM Ricardo Ribalda <ribalda@chromiu=
m.org> wrote:
> >
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index eaafca41cf02..4888231422ea 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -43,9 +43,6 @@ acpi_status
> >  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_cod=
e,
> >                   struct acpi_buffer *status_buf);
> >
> > -acpi_status
> > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > -
> >  bool acpi_has_method(acpi_handle handle, char *name);
> >  acpi_status acpi_execute_simple_method(acpi_handle handle, char *metho=
d,
> >                                        u64 arg);
> > @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t =
*guid, u64 rev, u64 funcs);
> >  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t =
*guid,
> >                         u64 rev, u64 func, union acpi_object *argv4);
> >  #ifdef CONFIG_ACPI
> > +acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > +
> >  static inline union acpi_object *
> >  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 re=
v,
> >                         u64 func, union acpi_object *argv4,
> > @@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *=
bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +#define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
>
> This is a function, so static inline please.
>
> Analogously in patches [4,6/7].
>
> And you can merge patches [2-6/7] together into one patch, as far as
> I'm concerned.

I was trying to avoid some extra ACPI_PTR and a forward declaration...
But overall I think it looks nicers with static inlines.

I have kept the patches separately. Feel free to squash them if your
prefer that way


Thanks!
>
> > +
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                  =
 \
> >         for (adev =3D NULL; false && (hid) && (uid) && (hrv);)
> >
> >
> > --



--=20
Ricardo Ribalda

