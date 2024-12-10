Return-Path: <linux-kernel+bounces-440434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3543F9EBDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA66167F72
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E491F1907;
	Tue, 10 Dec 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hp1euByq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B72451EE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869935; cv=none; b=Ux6wLHEaA5L0E79eoGtR6tlg+YNLcWLn9qHauC3ABTKPmR5lMNOKA/CDPuWNpYqqY77QEIZxJzrL/6E3F2R5op919CwWv7Bumrf/YSimFs7P3Kb3E44OIrH9hF4M1AhN/HNANzY+jrPBHaMSG9DCq3D3CtsJozu9scqE1Jn91VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869935; c=relaxed/simple;
	bh=5sAckLh2O+Xqp/B3w/FFV+cbSlpNec1FrjP1mHYiP74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OthbS2/NGVzdsu+FhHIaUA6Fhv9SzMqz5y7iZ+K5XN0exOdtSooU3D8jcnEEXPE6oyz0OohoMODA+yx5otw7o0YehMiuZ2huGWv0SqxTtG3IEJ3NLdjQI2TTWjcIosqCo01zLK2Lru2Fb3EmNu0JYX7H6DD+cIHIkOdhw9M0gqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hp1euByq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so25736645ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733869932; x=1734474732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbiia8j7j6jNdjJNl2DYQMz55vjkekkDfU83OLWkpH8=;
        b=Hp1euByqmK84QDuMKywicw7Xsl96neP0hhR1ilBpsLceJRXiXgk8KoYRLNl1BmKCpC
         SOi16q1UinbG87+j3x1zkVbwRzqTCfIaI4nGrys8xF+fjFFxcsECgcCmbMOEDIHpp5eo
         dAYk5K624IiM1IEYOj0tVAEhG79TZKDK1VNSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869932; x=1734474732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bbiia8j7j6jNdjJNl2DYQMz55vjkekkDfU83OLWkpH8=;
        b=LJiWC0FxAF9mnlJVOjx4caUIR9uqTpas7moXVxmqGNVtmPdv05Y3VIJkZRB2yEZ/WH
         FtiNUiAr74Q8qlRRC2nHbSdUKBOCaiae1CXeYzrF9kUTUuAvKfyhfACppBHhfb6H6y9g
         OxZ4jWAsxP83hzYQ+pgM7QsyO095KPbiPT1TfqY+GL+A22zSam0DaKJTcWgZ8tF+o3+Y
         0izI12sHBs4GOSO9qHXd1XhNssxLQwdKJXRJMbHtkFOs3RYqjhRn3BQfTmdDXz2wLlVu
         abzrazp+zBOLBQKn4mPE9r9qKjgQYHA2jcwkdCSGGxOE6mRnfWgXeMTrflU0RZPuQEa/
         1i1A==
X-Forwarded-Encrypted: i=1; AJvYcCW+ryfdrmfwura0VJ7LdBddxCjPZlmYqwept3/Aydxz/SL2qsJFKIkx6XEftNqphXV0ExzMPbz6BqpEEY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPlXpzuSkDExZoh4dMeNI5vspfktTKIPokO0zva3ihW62f4dj
	BLO8n6/gaU28W5ROwRQOrZf8/d2wY1Goalt2O67XvluNADG019YL28GaLIaQxq7evBbqx3vP01I
	=
X-Gm-Gg: ASbGnctrggO47voKApGdGZFkTK/owZZie04ww74iw8GmbiHvjnbDj7Cw3caBtsGcLwU
	b4KSjtfsQdQ3byFIuKn38Hn4cckdRLVOzqQw0iFJfQvchsMQg/rrgMltFMfDUbHcxijgQ+gGJYK
	wjc7QprJhAhmn7+fmtNTXRVlvy1/2J8R3/TICCT2VoyO/gM4XYq2KbnlCiehKvPiUoCjeWSzi3Y
	h0vL0Vt7yqK365cKqKi2cnkT9dDD7clma6AHGa+YG/9WsLukJw0uzUChTqfabqGMcVDXBivXcdt
	E0Om4yyQ7tYCKJ7J
X-Google-Smtp-Source: AGHT+IF67RIouGpuSANEFYOSiWIHlEkHjALSV95Y4zlM1C1/fo81QT3vOlfK2B8wUoZJUg/ukQELWw==
X-Received: by 2002:a17:902:f683:b0:216:4a06:e87a with SMTP id d9443c01a7336-21778505a23mr15444705ad.40.1733869932595;
        Tue, 10 Dec 2024 14:32:12 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216413a6c92sm47494855ad.249.2024.12.10.14.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 14:32:11 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee74291415so4397815a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:32:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVePwaPqw8Bl3zkO+0NZSu/VHeX7aQxr7V8I2Vamx4cqCTjO9x7Z+Ck2GP1C+rTnvSyJFVBBKLu7I5yR7c=@vger.kernel.org
X-Received: by 2002:a17:90b:4b12:b0:2ee:c797:e27f with SMTP id
 98e67ed59e1d1-2f12804fc63mr899384a91.36.1733869929209; Tue, 10 Dec 2024
 14:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org> <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
In-Reply-To: <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 23:31:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
X-Gm-Features: AZHOrDm5Mc-6e5PYz70Xt3CVLGWF-rWtXL2uCKjRJio5ykJKaQ08kVB9D3kD-OE
Message-ID: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 21:56, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:01PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_device_handle that can be used when
> > CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/linux/acpi.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 05f39fbfa485..59a5d110ff54 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
> >  #define acpi_dev_hid_uid_match(adev, hid2, uid2)     (adev && false)
> >
> >  struct fwnode_handle;
> > +struct acpi_device;
> > +
> > +static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
> > +{
> > +     return NULL;
> > +}
> >
> >  static inline bool acpi_dev_found(const char *hid)
> >  {
> >
>
> Please remove the extra forward declaration of struct acpi_device a few
> lines below this.

Instead I have moved the function under the forward declaration. Let
me know if you disagree.

>
> With that,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

