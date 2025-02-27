Return-Path: <linux-kernel+bounces-536543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF9A480F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E846318934A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7583230D3D;
	Thu, 27 Feb 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgAKdHxf"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF992376FE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665519; cv=none; b=ENIhXPyQybLMsTBueiiJLDnwkeqolEXDF1zvvC9uvB4jUwJp417GWYeyPJ8gAbDucvIBG+agYuyZTU6ntqJ5q6des6hEVEILsqPe2C2th9qa4I53gGDVg9tI6B76MpcGh7HD/2wjs/zDSJFQgL3O0rySrboMpELLQiuM1qmIvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665519; c=relaxed/simple;
	bh=YLrA9sPtdsQptr6Dd2lYJd2WxUGRFrsSmMZxtTCIW4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx7fCSBqWvyABaL3jp8iZOL0IXp+rSk9PwFeaRaL+dJTRBC7tjO7TfVVSQG3gEiIfWQ9Eh/UGwosf+eOGxC5iwKUjlUDN96GZeqM6JOlW35uAgiA9+gWMFrxj2VbkDPVYq7r5ejNtD2l3IEEu8hXtowVATdVku1gpMKf50qwL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgAKdHxf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abee50621ecso138532666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740665515; x=1741270315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLrA9sPtdsQptr6Dd2lYJd2WxUGRFrsSmMZxtTCIW4Y=;
        b=AgAKdHxfVEwuv61exo2AErH/OvnskIitJcWutXTjiJkc3GQim0hatO8+oeIOUbt5js
         ftZFoGiREzj+90tDPHQjrrFVlRifRqP3VeNj0JcCJiXH6ep3LNZzvyzjzEIQzOsVN9S4
         xpg0Si82MdaDxEkNO2PjyZtTDi45gMqykhf0GBIsoli4qiK4pp3bpqe6v/1aDMbK880A
         mEgNM414OUDrg14bB9Fuuil2M7DBT/wc5B9zCcrvww0mK6z8YVQeP5eUxHG9Vli/Uqjc
         LrbklMkgEL8Q0NzgHzD8TEFrGJnUswrnuFAj1ezanhbdzaz8Rm2F3Ne/kpdwS4VbNL6z
         H/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665515; x=1741270315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLrA9sPtdsQptr6Dd2lYJd2WxUGRFrsSmMZxtTCIW4Y=;
        b=OnaZLK9vqUFTn915uXl9Rb7wN0hfsm6mgEuUdUC8quF/LarIzRn6fuZO3vILbf+1VU
         sR3lyO39HSQlwrWVTjiocfutY5HuQb40LMbsyqMSKYw968gc/zbsxQx8YgzcFhUC44TP
         NmM+fAiFKV4/SiNTOvQkwVwXOHNXPHPQ7IROnQ5fAUNS7EBL2OskKJejLjWnbd+mbVCW
         J6XghvPLL9MMKHcWjcJPKLktXX1FCEX1Ej+NGWBDxVWZT/hUlu3OA1tCOnTJsjeof+lQ
         jgWqrAt+IJRCO+UCSCOQg4hfbkVuOyEnMeO8S4v6bgCvzEw+1mNbpIv0urFEn6pdDo9c
         oJpw==
X-Forwarded-Encrypted: i=1; AJvYcCU+mACPKOIZ8sQ3PPlep7NRY1TGFnFB+uvSOf06qP8RlYolpzl0M8biIm3iG5R8JbkVzbV3uUO2ZSoLleY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2c6QKB19nOhgVNKvRTonZgKhziDFFTyp4fmXKoi/BKilaXNxj
	5ik7PLHugQAWTnKS6KDCWj/OqVqqv6R8xmI92p2jDeQEYGV83JbuBHbbb+pwkuPRSLpvx8IVDcx
	1PQuMjXdlwRm5vNW29lifSYBZ1zo=
X-Gm-Gg: ASbGncuZxaUdLVP6pXplhs+piM84AtKDvgH+jDyhN9H8dpS4mbqkN5HW/sSYPuSRmuv
	MOv1H7XhQM5ELqJ+/rQ/3b823/x8K9zoAxCwjlZA9kWSb9RuiBjvPWcoacamn0A+Ndp8eEheNeG
	FSNjZkVxUCHw==
X-Google-Smtp-Source: AGHT+IHTJSjBxBkH9ZrAnC0DLc9/eVwS8Go8m2tkwt3/GOiyWln8ahSPkySd+15g4vK24BdBiDteJSkN2ITq/akVYs0=
X-Received: by 2002:a17:906:3110:b0:ab7:d537:91cb with SMTP id
 a640c23a62f3a-abeeed56795mr833080266b.7.1740665514659; Thu, 27 Feb 2025
 06:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-5-raag.jadav@intel.com> <Z78VIjgkzf_GlauU@smile.fi.intel.com>
 <Z78VkEnJh8l9MWF7@smile.fi.intel.com> <Z7_0gJJL_h6lq4cz@black.fi.intel.com>
 <Z8ASOo-TcQrZtgbj@surfacebook.localdomain> <Z8BwlFk-mnrMSxUe@black.fi.intel.com>
In-Reply-To: <Z8BwlFk-mnrMSxUe@black.fi.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Feb 2025 16:11:17 +0200
X-Gm-Features: AQ5f1JrQJxda8C82z91wYBzs3avAskOI8D4TAZeqztL5G5q-yzipzDxqvowufpo
Message-ID: <CAHp75VfeGh0RCAZtMKf-DneP-gakOTSycrVoY7nFwqz2QPfMTg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE
 GPIO and TIO
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lee@kernel.org, 
	giometti@enneenne.com, gregkh@linuxfoundation.org, raymond.tan@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:03=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
> On Thu, Feb 27, 2025 at 09:20:26AM +0200, Andy Shevchenko wrote:
> > Thu, Feb 27, 2025 at 07:13:36AM +0200, Raag Jadav kirjoitti:
> > > On Wed, Feb 26, 2025 at 03:22:24PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Feb 26, 2025 at 03:20:35PM +0200, Andy Shevchenko wrote:
> > > > > On Wed, Feb 26, 2025 at 11:45:27AM +0530, Raag Jadav wrote:

...

> > > > And also Subject, you have currently 3 different names for the same=
:
> > > > Kconfig, Subject, filename.
> > >
> > > Yeah just trying to dial down the acronym syndrome, you know how it h=
as
> > > plagued our minds.
> >
> > Right, but in MFD we are trying to follow some common schema(s) for fil=
e names.
> > Currently the most clear one is for PMIC drivers. Let's keep going with=
 the
> > rest as well.
>
> Sure, I'm also a bit confused about how to wire up Kconfig here.
> Should PPS select MFD or depend on it?

Intel MFD drivers seem to select MFD_CORE.
Drivers that are using those ones are usually dependent on the
respective MFD drivers.

--=20
With Best Regards,
Andy Shevchenko

