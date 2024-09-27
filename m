Return-Path: <linux-kernel+bounces-341604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B698824E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E161283281
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9E1BC08A;
	Fri, 27 Sep 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wq/39tSf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E81885A2
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432215; cv=none; b=kH9uMhujEa93q9rHBVki7LOUNZa4O4706lyZFoHJ2rsYK+7+edG55jDi74vhGt8SbroL8U7cDLfbkaENr9Zi4vp5bdeaKZcAPhEFpdRAFmAPTwwrfCq+jeuRQLM+yVTG5MYlpVtYkTP1bbZocJBQMJHJpEuNf3j1xOpOnzinI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432215; c=relaxed/simple;
	bh=cAxaVY79viWfr3dOL3dJjnZC0KcE579FMqX0FSoNdpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOQJ69S3SwTzQL5LO5uPegoUuvSzBs1TvzHD+tZAapn3UDWpNGMuI+UxbUuOPSGH9/jQR+CfaedghMn++SJvXW+0OZyQq4vTNQ6FpcUJLWZjH7uUwW4lhxUn0DQ2DnDfZManQFznQrG2Kvc5LJ+yZBVMxPrTdWXLK94OEFz0jGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wq/39tSf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-719b17b2da1so1489865b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727432213; x=1728037013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwCiuRYsk936wm4u/HVOckfXG1k6CXzT+Xy0kwjFKfs=;
        b=Wq/39tSfgTet3ccRn4yF+YIKFSZgenKd4gLwHGddPlCX3jfUPODRNQqTFJf7ydjGsV
         Smrv3GzCVemLt50jnAqo8I4ytyE/UJjRK1uqm56MJGea7H70yuj2TJ9Fjjj+eGqWau44
         RS3/mKN2aeMUrJDp3GX5/F7LBTHM+C+p+b2Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727432213; x=1728037013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwCiuRYsk936wm4u/HVOckfXG1k6CXzT+Xy0kwjFKfs=;
        b=UMyqv+vw6TYtrIbRRhQEbXG0dxYOjHZBjR9aIQ/UZM9WOsswDSj7f+pepR7C9FIBq+
         kEwBlI7rLpTx4aRskMyO79VKE9G3QDE0vGfRt/X1pVFMFBN9l/uDUWlJw2F5ylJ8LRZ2
         tKoHcQtD1NYihAKsBgGTScRck5Fca+9JogzVaTz5VxCOSb7E3c9cnEimgxn84RBWkqcb
         iX+vHQTGsKsVTraCVWEk628w+Oxg57VCnJS5s0+qd6ExbUGTDLFlOeMO410b/2cQa8eb
         WUzIEXc1y4L/bsDZY+WKJKPPDydFqeB+l9UYeLNSYJ9aWvlE7OyQPIbhX6Rnfko/4AFU
         TLuA==
X-Forwarded-Encrypted: i=1; AJvYcCUk/CPWE0EmEOL9jQIZTnfEMXmSMycfJ2DG6QMrT+BNXQn4PVxzCwrdNrqkKrfZjfz+1ZbOgILcNIjjJa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/64BdmqaHa/19ybU3gRuAiJydwQsDgk8H5GeUGWId1lMfKnn
	h7vZ2Si6TWTbZTIUX+8XFZ5bGM/ZkLZ6Rhe8rDg8j8f41AHjZAIrXBmcYuoIVmaYfWnImAQ9tLA
	=
X-Google-Smtp-Source: AGHT+IFl35mO9iFFgoL1EJmbWXe96n48f2Nm5VneG9wvFEOUhOYmuDVn9iXd9FWAu1cqeoz9sDJWIQ==
X-Received: by 2002:a05:6a20:2d27:b0:1d4:fa04:1cf7 with SMTP id adf61e73a8af0-1d4fa69a08bmr4660866637.12.1727432213083;
        Fri, 27 Sep 2024 03:16:53 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26516125sm1265808b3a.137.2024.09.27.03.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:16:51 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70b2421471aso1241018a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9CIDkNMGumT78Kok3S5TZjS4L62qngLnNRyBU4bgEvDpnwq3RZo9sA+ulI1F4wPL1ivB1RJ2f+/cIkO4=@vger.kernel.org
X-Received: by 2002:a17:90a:ba95:b0:2e0:b6f5:1884 with SMTP id
 98e67ed59e1d1-2e0b7b83739mr3267623a91.0.1727432210480; Fri, 27 Sep 2024
 03:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927-cocci-6-12-v2-0-1c6ad931959b@chromium.org>
 <20240927-cocci-6-12-v2-1-1c6ad931959b@chromium.org> <CAHp75VeGAzU1BT5bE0BrVj4MR=TR2KEzjwhoFUnN5Q=fUanJZg@mail.gmail.com>
In-Reply-To: <CAHp75VeGAzU1BT5bE0BrVj4MR=TR2KEzjwhoFUnN5Q=fUanJZg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 27 Sep 2024 12:16:34 +0200
X-Gmail-Original-Message-ID: <CANiDSCvF4g7H77Tuy=YUfCG5xYxcb8R8oTsvCjSt65zPAsepog@mail.gmail.com>
Message-ID: <CANiDSCvF4g7H77Tuy=YUfCG5xYxcb8R8oTsvCjSt65zPAsepog@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] media: ti: cal: Use str_up_down()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benoit Parrot <bparrot@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Tianshu Qiu <tian.shu.qiu@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy

On Fri, 27 Sept 2024 at 12:10, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 27, 2024 at 1:02=E2=80=AFPM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
> > The str_up_down() helper simplifies the code and fixes the following co=
cci
> > warning:
> >
> > drivers/media/platform/ti/cal/cal-camerarx.c:194:3-9: opportunity for s=
tr_up_down(enable)
>
> ...
>
> >         if (i =3D=3D 10)
> >                 phy_err(phy, "Failed to power %s complexio\n",
> > -                       enable ? "up" : "down");
> > +                       str_up_down(enable);
>
> You never tested this, do not bother to send untested material, please!

Do you mean tested in real hardware or compile test it?

I did test it:
https://gitlab.freedesktop.org/linux-media/users/ribalda/-/commits/test-new=
linus

But obviously we are not building that file :S. Let me figure out why
did this happened

Sorry for the noise

>
> --
> With Best Regards,
> Andy Shevchenko



--=20
Ricardo Ribalda

