Return-Path: <linux-kernel+bounces-543432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81746A4D57E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E2C188D503
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298A1F8AD3;
	Tue,  4 Mar 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0bS78ux"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4181C84D7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075077; cv=none; b=GlUzJejVocRcAzQOfE131sg+DusprYZ1+n8cNLqepODOVeNhYeQjd5i8hfIiZBXrzPyFniRVTIk49N/l9N+JyNkKP0Sb91aiJIzZzP/vxqe/xU2MwDAvXU7hyBOlMexkc+MszZF4LjGo5RTOyG6CqHDXlw5MjAoxvPTnE1T97Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075077; c=relaxed/simple;
	bh=uFSrwfAZqk41LBtysZsC0obSOGXPJGDgnLsmqfIMDK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+LjR9fDvtRteewD9cMleZod52DxPvF0esUuXaabdfLPkGT5QlWFJIZauM2HUWkooEbiis/OIK7R99y09pDkIt75UhvCXgWhkee27jUwi75RCS863bef+v4gBW/Ey9BNZUAtEuQZ+FP5lcY0gF/PmBC/KWdkNBEtis48l/3Hctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h0bS78ux; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30baa27b209so23962441fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075073; x=1741679873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFSrwfAZqk41LBtysZsC0obSOGXPJGDgnLsmqfIMDK4=;
        b=h0bS78uxQEHqrlGBbWDNyWhOnfXHwswmQNb6X5XQwuRPExDKrGn+gxQEPfssC3JprW
         Rh1Bs9nvtLHa3P6gZmBaf08mgbG0PD5+DvogS0CYjuy1f8rbNDd74z2s+xioGRU6m8ED
         w7emGgmBeK/po3vvXx0Var4PqInQjhuOrtBl12lAlrLL21HS+VeWXpSRYmIFgfoxKEXk
         vFWWqSnE9wS3gUVUznZc6icn0x2mzC+sSbm+F162ykEcyEyCsRXRzbCvmQIczKFOWr2W
         CZi/t8vO+QhSpOb11QKHcWEawqIzNRGgJeM4osiucVIWWYEh+eyNJ2jUkCaW++h6oWcI
         iqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075073; x=1741679873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFSrwfAZqk41LBtysZsC0obSOGXPJGDgnLsmqfIMDK4=;
        b=wwOnVpY/WICpos/i4qAXWhZYCOJO1h8Fu++Vbs3E/izZBj6wFphgxJXf2RHAJ4FTjw
         uPHb0tnb5x+fCrkb5jb1CdF5Sqg7EzbyDaazi+J4fpJeLGfixfioYpUjYDibDOBtNpyk
         iKFpla44nEdoU183i+pp5w+uvBIeTT881SbIbIr0ojHb7B+UyXwg6HVXybpxfdZwUDkL
         fVBLYXgAUtbk7AV11QyTgp3CF7+netIuuS8Eg6Ljp+t7T6VKsBLAxHnVn4umt1t1gxHQ
         TWF4W5a+LUA9LZEIzto6/sQSmT55IPO10G42F2xN9UMQFyBHFR7zhAzMQA0QzHNZYiwH
         8oEA==
X-Forwarded-Encrypted: i=1; AJvYcCWgCSXuuKn6S5u7uSS18dQbyaJXXVPttOpPNcGvH0zSplwdf56oRN//pIN3e0vgoJNMor6reSgS2HtNFhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkXE1nDDST0zaWoeQsLxu+Q1obz6+Tt3PqQ4a+L2s74uW5V4h
	XlRlM1jnOq7Tg5hlGsPo55Mm7JjdU+lC4PO3HrIM2+mS9Czt/N0UYCCjVWn1oIoDWXecH+CaXf2
	jU9pFFsgF2YoMT2DDToM048fA8DQykEN6vVOvSw==
X-Gm-Gg: ASbGncuX9HqBCEFvRasrSa00bSocR8jpWE3G6P++Ev41QmGtxRDi3ChhTrdK4k7q2gM
	XF9+pvrOKbR6Sj+D83GS11H5wE71HE/vAfizjLzp8THgL1inJzhDJDxUgM8jvssimBxGDiZmhJV
	WkSwlxEGZg9X6bc7BAsw9lOuqX0Q==
X-Google-Smtp-Source: AGHT+IFUItRedI2YhId4MQjoRhsnzWgBSgpMCiIIbrX/B01VKJvMgvQpYNmla4BoPUJ/iCM2iebgjYU/iv6QgkwIA2I=
X-Received: by 2002:a05:651c:556:b0:30b:c83e:721f with SMTP id
 38308e7fff4ca-30bc83e77a3mr14176531fa.15.1741075073573; Mon, 03 Mar 2025
 23:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740745270.git.mazziesaccount@gmail.com> <fe08d70938b63206421dd39ab71cdedd5dc458a1.1740745270.git.mazziesaccount@gmail.com>
In-Reply-To: <fe08d70938b63206421dd39ab71cdedd5dc458a1.1740745270.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:57:42 +0100
X-Gm-Features: AQ5f1JqqwwSDIbZMqDw_-etGHDDKdPgc4Hf7zcm5pk30Rfl1B9ZP_8HFgo8U7Rk
Message-ID: <CACRpkdYjfvSywb2=ppopk5W57jCbe8fj-HK4HJFS_cMLopJ9YA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gpio: Hide valid_mask from direct assignments
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:36=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The valid_mask member of the struct gpio_chip is unconditionally written
> by the GPIO core at driver registration. Current documentation does not
> mention this but just says the valid_mask is used if it's not NULL. This
> lured me to try populating it directly in the GPIO driver probe instead
> of using the init_valid_mask() callback. It took some retries with
> different bitmaps and eventually a bit of code-reading to understand why
> the valid_mask was not obeyed. I could've avoided this trial and error if
> the valid_mask was hidden in the struct gpio_device instead of being a
> visible member of the struct gpio_chip.
>
> Help the next developer who decides to directly populate the valid_mask
> in struct gpio_chip by hiding the valid_mask in struct gpio_device and
> keep it internal to the GPIO core.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

