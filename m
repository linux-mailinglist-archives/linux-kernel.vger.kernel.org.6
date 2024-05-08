Return-Path: <linux-kernel+bounces-173452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D58C0096
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D21F25456
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9C86AE2;
	Wed,  8 May 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC+Akvw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5C69D29
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180773; cv=none; b=h2IY4X6SLpoJht80RVMnIwU7ENPn+wIagX/L1S7UKPBMSfTt1aQ4eBDqgkFUF1Zx3aDpx6EPyrDgR4S3RjczlK6Quaft22RyDfDKUOFHOr227qBmSq3wHZ6NPrSmtqIzSV4506t7t9pW9W5+3PjsJgRN3X+hBJ59O64acapA8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180773; c=relaxed/simple;
	bh=Nz+Ol3vDINwnuP6otiaKVduS2hEYhg4Wrkrvo4FR4qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL6bdcs5AT87nzp66IrBVhRGqLj8oG6sjC8c1DUaOJJfDBNSObGyEnxL/tKHV9GXskR07nmLYjhsg0FeHM4f/rVxtl5b6YJEETaj6E5ahR4FvkTvSX/9jzONpAwEEOt3hO0oEEzYbzuOasfJG7JHirQCEFWgINWKMuL0H4gEpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC+Akvw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BC8C2BD10
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715180772;
	bh=Nz+Ol3vDINwnuP6otiaKVduS2hEYhg4Wrkrvo4FR4qI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lC+Akvw8dV6t4qfe6Nkt77+WkF/akNWt5CcuHD5E180y42aZOTMqm8X4lBJkm4Isw
	 HAOSBgxq3QXI1M+ZGdPuHW361X6TC1jJ5PRaVGykyyC5j22gUdqTbuDT96Cijhmkyh
	 HRTLA0dBHYlFm248NYT/i+NS+AA+++7lbTppiVVugl9b2/R2LhqIywUwKq93Iu29vD
	 gN/kfPrscSbPQuBSF6qb0XtWHA0mn8iLtAC8Xq30Ak7s1iBcx1GKIqoWBKSsmRZbru
	 WNyoa9so/QgOr1fNRs/Ep821vi8LGsCxDDMiGo3BqjReCfMCMwGJDs9ZlyWGV+mkxE
	 mmW54hbAYGwOw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b206b78b47so1713722eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:06:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlppiS6TonLvqnE1GfSjPa2cT552twYQWsqxmfBzhEfJ163y7tk/lOpZGcY15j2OlYzkOcjs8PyVnWmELNpibjhwVWL4B5s76k10Ae
X-Gm-Message-State: AOJu0Yw58Q6jyC0oQCy9BaPUgYVhyw27ExycEaUrpK+Q8gTTGqBP0QpS
	Fm/3/SJw0E4mLmLCMsPL5uf9j5fIa1FxS+IvJQYdo1HkJWT56qMfwVtN0x1dsbp/Ic+DBS5Xqge
	6K9aW2pPfE7vzeyK7X3DSpa4FGUc=
X-Google-Smtp-Source: AGHT+IGg5A2TRMp022OdeUHPWQ5wwCWLuHfL4EJKgMEzNsC2V/Zv/CD4dUXVHjijpf9dHIJlI9dkoi71MMjUiKlZaZk=
X-Received: by 2002:a4a:8c6b:0:b0:5b2:ef4:873d with SMTP id
 006d021491bc7-5b24d62e22dmr2550971eaf.4.1715180772008; Wed, 08 May 2024
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426100054.61506-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240426100054.61506-1-yang.lee@linux.alibaba.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 9 May 2024 00:05:34 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3XdVdqhNex7KQ9Asi70naMixYiO6Rd5rfX06dEamJKCw@mail.gmail.com>
Message-ID: <CAGTfZH3XdVdqhNex7KQ9Asi70naMixYiO6Rd5rfX06dEamJKCw@mail.gmail.com>
Subject: Re: [PATCH -next] extcon: adc-jack: Document missing struct members
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:01=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> This patch adds kernel-doc comments for the previously undocumented
> members `dev` and `wakeup_source` in the struct adc_jack_data in
> adc-jack device driver.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/extcon/extcon-adc-jack.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc=
-jack.c
> index cf5050a244b2..125016da7fde 100644
> --- a/drivers/extcon/extcon-adc-jack.c
> +++ b/drivers/extcon/extcon-adc-jack.c
> @@ -26,6 +26,7 @@
>
>  /**
>   * struct adc_jack_data - internal data for adc_jack device driver
> + * @dev:               The device structure associated with the adc_jack=
.
>   * @edev:              extcon device.
>   * @cable_names:       list of supported cables.
>   * @adc_conditions:    list of adc value conditions.
> @@ -35,6 +36,7 @@
>   *                     handling at handling_delay jiffies.
>   * @handler:           extcon event handler called by interrupt handler.
>   * @chan:              iio channel being queried.
> + * @wakeup_source:     Indicates if the device can wake up the system.
>   */
>  struct adc_jack_data {
>         struct device *dev;
> --
> 2.20.1.7.g153144c
>
>

Applied it. Thanks.

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

