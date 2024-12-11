Return-Path: <linux-kernel+bounces-440981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA09EC76E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB25416A56F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125281D90B1;
	Wed, 11 Dec 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sfbu4AKq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B571CACF6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906246; cv=none; b=ux44g3P27PgP9zbi8uefvNMKb8mh3TlbzsHLqcZztEFRc0KV1lhpw4rsA30FTDKLz+v96mccFAJKpJI4kwY7/EFgaGNUywxbJC9d7gKGtLfHe26v/qWCDF7hCdyYi1jOubHcayeFagi2jRQbC+T959ZhZ45F5IUBuHf99A6DpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906246; c=relaxed/simple;
	bh=XBgmqrGOR+TiaTyhJ7G4EyEffKB3hn5wBPa+e60msYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3h/RzYQWcfkhSHueu54UGfngHqEEOy8v+Gg2gRtYTb6tSL2dD/VmtyyElyeGPhZCORkGz/7EvTBCO2Gx0eR6Vwx7a3jNnmIzIQwtGpgjELK+EklI+ig0U5/FkKTEzsBprgP7Ryh+PXdv47Po2BD2xLNsjQRGzOLmAm0DaEnb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sfbu4AKq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725dac69699so3181069b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733906244; x=1734511044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbJ9A+m8ws44k2uM8AYTsZl/eWYOAV0rPVSUcQb9sbo=;
        b=Sfbu4AKqcVnMPqtjBe0dZSm2IXmS2CzV4/K47pJ9pLxaNGYe4G8OUU/2j5bH1EV0K3
         07rxWsZp/lnR6KD2JN0KENXEG2IhoB+xI2VoOtk0t/fgfDXf7YB4VsiA4zRDJZxkEA4M
         ljNd2XEjuSDFZ3YXh87qFUzKpde2LN+hEHWOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906244; x=1734511044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbJ9A+m8ws44k2uM8AYTsZl/eWYOAV0rPVSUcQb9sbo=;
        b=spKhHhViqqGZS98fm3PH9/lSOMe/ORx2oQqVJiJuXbg8M1/AdgcQlNFGtpZ9W1xTZc
         wg8nK7Fq2xkTahZBVlwVUgID7+2XCukOnDIcYcaC4iWBpsV/hmVrYMRx0O4rYt/lBKp4
         Sj2BpYRa4IcOaGTwe+6+oIpubgMgNLzFi0y82/Jawn74D2x0J5jCCk4AbZn4rISR+ywB
         nj40Dn9+y9kBAspL+YCubpMrowfaQ422DTDzHxGTaMR3u2f6i2zY8mIhGuWUAt2AjvXb
         6Zndmg1jBxObLy/cAdOFHgNzxR6S8Lgxcp18dq591RYfwJwXtRGmS4SRSo85VEMRJCMH
         cFcA==
X-Forwarded-Encrypted: i=1; AJvYcCWhi1sC/Hruv57URWxRPaYOP7WtdJo58PioWXcuF3GieVIsgqARk4CTsyNb0/irq/dBfhaOfyzleFXr6MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYZc5ftfYDdVjcFwSh6rCOnv0PkV/GmFItaqnZ8zpHto0ae5r
	jtsA7AbKO58+Bz7YrIms0bTjx3sX8FhvXFCcQDJ31lbR6g+lLaL8FfhbejjvtJXx+L6cjXNbgqs
	=
X-Gm-Gg: ASbGncs1g2yoz+x43BPg13bjh7I90wtd/IGlfJjiko+WLeyL/bGRIsB26cJTr4bPJzI
	2FmeG/9f0ONUh4a3zYOy6BLOjJEbDud37FbSU+zEsoAR+FuFHU1q/N4DqKTWk9COxqQqIc7CWl0
	2ghXAoavU4QU90RB8qr4Kt238V6CvN6Vl5Wo9cNZe8jIH/I7Kf12C41UYpHV4glNu1RDvIY0mS5
	OWQL9BfhyvqwuP6FHewJs3rX0L0AYO4YKQx0T51FcUspy3EArkp+ebC95vzwikfaW2iPMztKgeZ
	pCwfsaOZ/0IWRkfF
X-Google-Smtp-Source: AGHT+IGbaKIr5ZcMsPc988amMavKw8xy5hjJp28HANrWbivUSCIhJVH7u+TF9jAPYCw1YDhUFQfQbg==
X-Received: by 2002:a05:6a00:2e9b:b0:725:9f02:489f with SMTP id d2e1a72fcca58-728ed4cf3b9mr3593201b3a.26.1733906244104;
        Wed, 11 Dec 2024 00:37:24 -0800 (PST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e1e49912sm6084635b3a.12.2024.12.11.00.37.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:37:21 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efded08c79so1066575a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:37:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOxbZR3NymxBeU2ZvXeAZ4S6BFMNLFBi5vaRXeWjKhCt9eEBxTaKG9BcH99tjQJrNj3Svmr6/rGum94ug=@vger.kernel.org
X-Received: by 2002:a17:90b:4c84:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2f127f555a9mr3269053a91.1.1733906240145; Wed, 11 Dec 2024
 00:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org> <20241211091954.42a5c778@foz.lan>
 <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
In-Reply-To: <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:37:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
X-Gm-Features: AZHOrDlaYtacxTR4SrQpC121lb8rk1oSdpiMfzTs7ikEYNouO9W71c6h8nTE3PY
Message-ID: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional compilations
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 09:32, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Mauro,
>
> On Wed, Dec 11, 2024 at 09:19:54AM +0100, Mauro Carvalho Chehab wrote:
> > > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> > >     unsigned int i;
> > >
> > >     for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >             const struct ipu_sensor_config *cfg =
> > >                     &ipu_supported_sensors[i];
> > >
> > >             for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > > -#else
> > > -           while (false) {
> > > -                   sensor_adev = NULL;
> > > -#endif
> > >                     if (!ACPI_PTR(sensor_adev->status.enabled))
> > >                             continue;
> > >
> > >
> >
> > Considering that you drop patch 1, and keep the ACPI dependencies
> > at the header, as proposed by patches 2-6:
> >
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>
>
> The 1st patch fixes a compilation warning when CONFIG_ACPI is disabled.
> Merging that patch as a temporary solution is simply easier than making
> arragements for merging the ACPI patches to the Media tree so the last
> patch may be merged, too.
>
> Besides, the fix should also be backported.
>
> Ricardo: how about adding Cc: stable for that one?

Adding:
    Cc: stable@kernel.org
    Fixes: 8810e055b575 ("media: intel/ipu6: Fix build with !ACPI")
to v4

Regards!

>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

