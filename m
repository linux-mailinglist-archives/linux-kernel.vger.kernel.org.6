Return-Path: <linux-kernel+bounces-543428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B992AA4D574
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4628172D83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84551F8BB0;
	Tue,  4 Mar 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpHpgR04"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629F1F3D52
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074957; cv=none; b=JoUq3Hbpwl7Zi2HIxufuUUx5tkHX+sGLhPVHl/beINh/lTfhvF7gtZaEQd5wQprs6QiWM53tZqUhGJprcvq/Ub0mn6WMacehkR8MzvxiPUEhFlyBjr3WRvM0i1Ew0rJ5pTYruSuXKFCTt/XORdjr0YC5h/Hi/RMOKhHxiCbEmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074957; c=relaxed/simple;
	bh=wMro+oQYT8L3eIKeDTeKQmWxyrhEKtJYvqmJAViAmFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfhtklY8wd2+odGvM0ekTI24qWb61jShzt8RF+fMjVBRjYiNPc8QYsZO1vPMOPFr8doixdITrwe75NFzAo1VJaPb2+SQhByW1CgkLTfR6YxmcfOUU+q5UesaqJzQ+I8+e0MjUx2cPCcj3976/4NBlODb615Qw/FL5tCivdmroPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LpHpgR04; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bae572157so24887721fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741074953; x=1741679753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ9DDcCt9QUtQRCh/VCueix6q79R8Gu4pWj0lHBrn+E=;
        b=LpHpgR04YegxvVXXkteciN3cJ0lKUmaPebPmFhaA7R86fg/6KuBYzk8SIEPZ7matho
         Bn9whmBBZrrZJnF6Ilnltyu2kBRi7G40t7ZlKMFHqVCyk731U8Y92iuQzIf1xSK357pX
         R7DVfkZ4p6Z0ZVbfDmkqbqYuvQtuSToM1Jy0k2tmmGSveSpMQeTyUik/Z9Hu4c9p2XHM
         /UJpok8T44oxaosD7ZKLg36XxE0zoeAgNL6osIl06fWuL4BB7gpmPpvcbOnFEANZjm0h
         APgob62LWlPkT0L2slXDnUYHOuYywQfk1HXiTWyfVGr2btTXQL3E+rMT06GIlFi6sTBa
         ++1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074953; x=1741679753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ9DDcCt9QUtQRCh/VCueix6q79R8Gu4pWj0lHBrn+E=;
        b=tDY9a6b6E5dEgUCFxmC0zanAtLNoXvabwtHk1yrQbRoDkiVp3PmVooiHGcJOEpkg5P
         FvKHNTbKIN4e+/sWwp5VM/wFoifbvvP8GfcZ0DQcUY7vec3UI01a0Aaxlc0ktkkZBRka
         KzU1vz5ldrTSqmEGMLkL1MVevjkKvzxR1Bl23rg17BvIetYHDbWLL5RoZnuTTUbr4how
         TTL8s0FeQgUaCpByWVZbKXn9Kio1NVYuRD2s2WOZjM7v8TrDCFDnP9v+6PAPDdNYsnd4
         JImeEeX2jnHBrvVHpGExzjdrzUNx2G5k1htyrjgxjGx9kOzPqZYniAUlHK45iIVoZVAA
         WlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXlh1TGDms8bJ0mcnEzYXa4w84351f8Alra6D9mwMG/iWkORHsgjPdgyadBz4TAeY3pE1aOCbXrg6rwFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxN8nhYe9h8EbJfeG3wwJ3Bu39AfaV+Vd+Xq1qx52rZpMF5nmb
	gTukJc2qNDCBUTZDFgWQu8Ox3wy0snxD8eAVmDH+/qXGOOkTMOYypG2uVaeamCh9e50851EsTgd
	OBoB59pNsw0i1AOJaplth4H+Ku1uggopQmoojRaVq61Wg340F
X-Gm-Gg: ASbGncvm0J4WNxfeEWxioqykriXyWbRlMOLoMbRMpQU3YEDEX2YuCvCSlKrrOU9j4rf
	KPSVmbMhSXwObvUt1CuVHFP0LhgFnLcHZxWTlpsi5pSXogcSfae8Weu0YBbbr0UF3EgspuVt3Vx
	Swbm103fgltOAryOyi9Co+cUWtjg==
X-Google-Smtp-Source: AGHT+IHzVd8RaIZzzyr6YTNF8GY5ofx0PywPASYXwtX0erFZJL3oJT+GFdH/GWC223tClxws6TZBUM7lp+ECMgXu1vE=
X-Received: by 2002:a05:651c:503:b0:30b:b204:6b70 with SMTP id
 38308e7fff4ca-30bb2047363mr34222911fa.10.1741074953543; Mon, 03 Mar 2025
 23:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740745270.git.mazziesaccount@gmail.com> <e50cf74a587b33cae3133a6b9e0081062f771249.1740745270.git.mazziesaccount@gmail.com>
In-Reply-To: <e50cf74a587b33cae3133a6b9e0081062f771249.1740745270.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:55:42 +0100
X-Gm-Features: AQ5f1Jpy987oPMQI8JiveGzipXCGjOLloV363WVv3DPMAv-V3aTk6ejZsBcPGkg
Message-ID: <CACRpkdZE2mtOB2BkKudQHq5-=-dyK6S2Se2hXUH+_equXhqwdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gpio: Respect valid_mask when requesting GPIOs
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:35=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> When GPIOs were requested the validity of GPIOs were checked only when
> the GPIO-chip had the request -callback populated. This made using
> masked GPIOs possible.
>
> The GPIO chip driver authors may find it difficult to understand the
> relation of enforsing the GPIO validity and the 'request' -callback
> because the current documentation for the 'request' callback does not
> mention this. It only states:
>
>  * @request: optional hook for chip-specific activation, such as
>  *      enabling module power and clock; may sleep
>
> The validity of the GPIO line should be checked whether the driver
> provides the 'request' callback or not.
>
> Unconditionally check the GPIO validity when GPIO is being requested.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

