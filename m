Return-Path: <linux-kernel+bounces-561790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9BA61644
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789FC16FBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF5203711;
	Fri, 14 Mar 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P33hj0AP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F42036FF;
	Fri, 14 Mar 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969755; cv=none; b=UgNRIZzc0xsxIfdi03hrhO3G78UbeqwTcbCThuCMR0Xx9qBRH3T1A9ke80JWXH3g48PFeYpNjsf/4+qsY0/B26BGzwjIE21kvf97mqglVmbAXdPymiTixPBWkqiqzoDpl4DXD0z+WA2RXy3MP5Ng5c+Iza8tbcw5zCgjsJCILuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969755; c=relaxed/simple;
	bh=bu0+6A28/pA/UbpaYwkpo2/XRA69E2bGKPU381eGsao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlCsk8DAmoMM9MyzOIKcJ9cPBCkNE4HBkZEwps1CWzzlDCrGLJ6Pk8qWrnFkh852TfGe4m6Ja21ALgibaWpjbuAE0NF73agEq3fq4lcjd3yJE/0BDOoAHDacWqxSz93WEzfOzIJdfisDaNvic5AtIFCgmfbTvE7IoXGICLynQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P33hj0AP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301317939a0so534698a91.2;
        Fri, 14 Mar 2025 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741969753; x=1742574553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNW8VpIhZt224I3dMj5F5IETEZjdTxNG9TiOVkUl7fk=;
        b=P33hj0APRQXQcElwUANVDMVqEKk37VVHOiq500iPBNx4UuGzgOYGczP4Jw7QaZ2gBt
         UX8yCcgGq+BFH8BErBbHuJpW++AZQQIjtjQoJT7RDtLoepYButnTWAQWIhAVdoQX8Iqw
         7tZkIC/Dx/m44SkIg9KLQ62AYfkfJKGkcKqFyYaS6KOVDZTMm7E7vlWXzV4t+q6MS1QV
         ljJerlN4Jn9KrxWZzvaAjgxiW96cnk+EuExMeLpprkg/mPjbtv3Ocb6KdksXqvxSOXSQ
         lValNR+aiYp1EmEW1humXz19ueuU191tEsTLjMdKrbyh2OW3PUcJXQ7C1ObOIeVwtZ+z
         Ug5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741969753; x=1742574553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNW8VpIhZt224I3dMj5F5IETEZjdTxNG9TiOVkUl7fk=;
        b=D2L8kG8tN6dFh5PFT0DVW3EqzQ7STBVfNVTSguzHf4GNTo9oLhtKv8USb7wIYFsIZU
         BNAft8C3bILqJaG1kP/fdG+vwZGJx6a3dkhYW7vKCq28qUkcw8u6fmGbibgB9FsAkjTi
         9peRUIefDmS/1hYg+11ynoGhlaa4wL61OAi3Let28PJrmwQmNvOaBmfVSduo1e/rbNsY
         Yd1br2iye0Htk0oJ+l1Ot53X5IsxKn1XtFJXChxxQTzV3nmQWECCaju4xlfbI200zQ5i
         4SUjtQeFLhK3CXlJM3Cp5X6gW6+gFFk5F+qmo+1ToW7yi9nfnS+cvEAq5YlWIOzTqL4i
         Oo6g==
X-Forwarded-Encrypted: i=1; AJvYcCWjnaJwZwf53vh8w/FloBvLmY0gvMisSzeNFxiQWucFMzjQh+ijanxTB8qG4yl42yGUQrTHerkfS9v502JhsOCxQlKWrQ==@vger.kernel.org, AJvYcCX+iS5iUFZX5nuNqqEtxp8yYFUJqQr0mJPKQDEm6NOy/8GlMmfgFw5nO3NvVeuOAmI5VqqCKMLjDqs97xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJjn7SOcYg364UHcbqNpyn9tMpmzr24xUSgTB8R5xVfOGyJCO
	bEvbVqxcMBQIzJjwXeeJqM1sVObNC6NYXyvm7SHEZNbydKu2BjCALuIaITVvlRpK9vWq44pCsrM
	G6Rthd7Bkij00fAnIyB7u/hewusFQ
X-Gm-Gg: ASbGncuTxEiGLSvIuQkuUine/AjaRz4EHQY0I+aeM2cZ5IXa5RTzjcj/6eTJfcgSCZr
	Ofkc17UlbAQjk7N9ZWyrq1KeP1eHevxWS5Z1kSWXWMGVh1p1qIGfrqFqLoOgTUCczlxWL997hrF
	OBEg5SRQCk8c01tD0Ud0YJQ50VmxM=
X-Google-Smtp-Source: AGHT+IFYNmu8UeUSFLCAa8ypOmZfPXpGQdsV494sv84pNqAeC8StFvEgKaMYQrATH8tfcYnnhaHHwIuS5gvE1NvjkO8=
X-Received: by 2002:a17:90b:4a50:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-30151d9d643mr1640899a91.8.1741969752748; Fri, 14 Mar 2025
 09:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313162820.3688298-1-chenyuan0y@gmail.com> <ff53debd-05bd-3a7f-89a5-2110b8103fad@linux.intel.com>
In-Reply-To: <ff53debd-05bd-3a7f-89a5-2110b8103fad@linux.intel.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Fri, 14 Mar 2025 11:29:01 -0500
X-Gm-Features: AQ5f1Jq8sL_qcRD6zYheJPuJdvZ6kD57OPruc-df_JLd6b_zi3G_FCm-XGfb6tM
Message-ID: <CALGdzuoWo+sT5ShVRpY6Q0R=5GOBvbOY10hyvUeT8DL9vsSj3w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: Add Null check for device
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thanks for pointing this out.
This was found by our static analyzer.
Sorry that the checker didn't make further reasoning.

-Chenyuan


On Fri, Mar 14, 2025 at 6:41=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 13 Mar 2025, Chenyuan Yang wrote:
>
> Hi,
>
> Could you please be consistent in style and write "NULL" also in the
> shortlog in the subject.
>
> > Not all devices have an ACPI companion fwnode, so device might be NULL.
> > This is similar to the commit cd2fd6eab480
> > ("platform/x86: int3472: Check for adev =3D=3D NULL").
>
> Please fold the paragraph normally.
>
> > Add a check for device not being set and return -ENODEV in that case to
> > avoid a possible NULL pointer deref in parse_wdg().
> >
> > Note, acpi_wmi_probe() under the same file has such a check.
>
> Hmm, is this a bogus fix, as parse_wdg() is only called from
> acpi_wmi_probe() so how can ACPI companion turn NULL in between??
>
> How was this problem found??
>
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > ---
> >  drivers/platform/x86/wmi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > index 646370bd6b03..54e697838c1e 100644
> > --- a/drivers/platform/x86/wmi.c
> > +++ b/drivers/platform/x86/wmi.c
> > @@ -1091,6 +1091,9 @@ static int parse_wdg(struct device *wmi_bus_dev, =
struct platform_device *pdev)
> >       u32 i, total;
> >       int retval;
> >
> > +     if (!device)
> > +             return -ENODEV;
> > +
> >       status =3D acpi_evaluate_object(device->handle, "_WDG", NULL, &ou=
t);
> >       if (ACPI_FAILURE(status))
> >               return -ENXIO;
> >
>
> --
>  i.
>

