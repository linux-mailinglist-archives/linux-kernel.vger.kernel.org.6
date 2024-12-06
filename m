Return-Path: <linux-kernel+bounces-435033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414469E6E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023E0282CB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B7201019;
	Fri,  6 Dec 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBB+/Gg2"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182E1C6B8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489693; cv=none; b=EuJT+BnAbBb+bC5X8Cn22m3vARW0KhWnalIsIjNqiUqQ7JQcYYWYl3orf/JaCed2Jsjp7UA2AEbSIKPx/xgB04kcaMiEFqmi5dDFy4eakDjeXtn0U2kHOLmAtRjkuwoHqacOtPzgsuIBBDS3fbRo9zvnMDEr6l2WVEeEQx2/z/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489693; c=relaxed/simple;
	bh=RnYzMjXxxKgluLSX8uSrROphylKORwO3mdERKj59/+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibXJ29ciS6J3mpEYqejckJpmgZNNrT661jxQ2SKzKl6mzDIiHJEASaHgXBIo7bD//tYyvXPxF2SXJXot3RUB9Q3KXe9thsMIeSAkJTrX2ohJDqSqUeAwGwo/G3WxMAPXSjqAMHxb0B6kx1yEj1z7KcnLECdJrvWWjFfZNdBe/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBB+/Gg2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d340313a4fso1570258a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733489690; x=1734094490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+cSdLWerTjpIWdpKS2ZeBmdwXT6z47G8KTu7IgFn4g=;
        b=GBB+/Gg2SKufa1vOb3uiq6jtQYvnQ4RG1FC/zQSnFegemVB16ahRy6B9iw6aVhMYEe
         cVi2TRMoEvl0vX0Wh2ibtQufPIGXlhh6vD5qdI7U29zHIAv7ysgoBz9jwvKJvJR5TCM5
         50IghKad1EMzVJ7i51/2cQ6Frf9flLa+lo7QmX4omVAGrL9VLvxXhDHjJMnS7dX/pd37
         YQuN3+pNv70FysD//OIF6z5nVL6i2oqNKj37hhrIZWtwBrwkLqccdwJ2ExZGihz++lUA
         OgdZFvkZlblMp7uH+6tsb7dDXCpS+iPuX/nXYba+DFf5NzzeKN2lsRWHRydKS9RRYAhG
         Jqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733489690; x=1734094490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+cSdLWerTjpIWdpKS2ZeBmdwXT6z47G8KTu7IgFn4g=;
        b=kQkic6p9wgABhRkjlyJLiGMsZ6g7ojXolvChxf2XopBj94aySQEi6yc4pcoBm5FMkg
         TeWI/o/NZX6FD70NBEyP0ecoLYsophor/nlzj0eXnbvmi9mQ38DNEge84EY9oEYt9hHU
         1JW0YKP5NsjDWlgicTx61T9bjcB/GTHMX5R8veVf0HAEikb89pkoyxFZGmPfjvXxt9aN
         VENYnsW7Pk6F97ohhtrs/EjbiiU2dLRB/NRVyttfZBgH1cb3HNLeZh5ceh4hVysnrDkq
         psS5pM+/51hn6YpKXJoQIwlLG5QEyEv9YUstD0vn4ByArU4gLrESzTcVGHOJutLdr3Ia
         yrfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRmXX0HyNxIxZWGPBdkHKlpwNaWzG0tDaOlHC+WZdQ2HI+he3qHY4FaRCFLmvqdY6Kcsj4Apw4EkIKk5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDRiDsELqLfA40K3nFZz81ty4eSxop3e8GcD7C057YY27q3yt
	rSBLXevqSMrzyYYtYbK+5gGPWl+7d4/toLyi7flsrkedon7Lxo/elCp7CMNQ94X76zGoPQqFVOS
	HwqoXK6/j1ZLFBQYQGz9kOZIq/G4=
X-Gm-Gg: ASbGncuMrYbLjLrA8akYUzyReIpYKEUuMFublaESXNProDN8SdddurMFiI07TqL9WSC
	+QufwxGskShGJ73nBqY1WGXaUrRwBQgHqJbeK
X-Google-Smtp-Source: AGHT+IEJ1uTWztFPMXUa13myAD7pRmH2eD+8WLEx/8vKOiSH7gacScLEHzd8zwYm1IqWVHHTeAYxU86XHNkHC+7qDsA=
X-Received: by 2002:a05:6402:2682:b0:5d0:e63e:21c3 with SMTP id
 4fb4d7f45d1cf-5d3be6aa9demr2001307a12.14.1733489689797; Fri, 06 Dec 2024
 04:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206123751.981977-1-simons.philippe@gmail.com> <2ec677db-2db8-4a74-af76-d8ff1f4b2173@sirena.org.uk>
In-Reply-To: <2ec677db-2db8-4a74-af76-d8ff1f4b2173@sirena.org.uk>
From: Philippe Simons <simons.philippe@gmail.com>
Date: Fri, 6 Dec 2024 13:54:39 +0100
Message-ID: <CADomA4-xTcPyFcX_qCYJwoi7y5vfYmzOfF9iO5MKgEzZdpbJCQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:48=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Fri, Dec 06, 2024 at 01:37:51PM +0100, Philippe Simons wrote:
> > AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> > which is 10mV in our case.
>
> >  static const struct regulator_desc axp717_regulators[] =3D {
> > +     AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
> > +                     AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
>
> This doesn't seem to match with the above - ramp_delay is in units of
> uV/us?

15.625 us / 10mV =3D 1.5625 us/mV =3D 0.0015625 us/uV
0.0015625^-1 =3D 640 uV/us

Or did I miss too many math lessons...

