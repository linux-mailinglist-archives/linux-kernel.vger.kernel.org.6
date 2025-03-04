Return-Path: <linux-kernel+bounces-543430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F289EA4D579
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC5188D5EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448DA1F891D;
	Tue,  4 Mar 2025 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxAjPqaR"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838D1F8731
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075027; cv=none; b=eUCQ8I03HZX5khtjWW1xCGydYvWJsw4BfkrsB8tLazwBRminf5FmqjzrxqgWDpaN1mpHYGFgJcf67q5Q8hkWVdtIWpHs2Drbt58EtIHr1mlISjgE2Y5TU1Bb2/E5+66ehqjsBulUixCnGoCexxbNnVZc9HEIM6Yqb1GMqZahDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075027; c=relaxed/simple;
	bh=sW335vmvtfvYEmaka21fFYN5MW1M94pNUFyg4zfSmOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLTwjJEzQzFJukkGdfPcTg07kxW9lgm0cxCz7zKNkcZr6J+l9sDEnCVJWtmiOsTWSR7RdIGWJmIPzG2wNnbyJBxN1NtuMdnrnuMH5uyN9VmpvTYc4qAPzNKqR1tacYx2H4775hF8Wz2yaOKnc7kVAlfAmnKmlZaN9nfYi/fScbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxAjPqaR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5494bc4d796so4716458e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075023; x=1741679823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW335vmvtfvYEmaka21fFYN5MW1M94pNUFyg4zfSmOE=;
        b=kxAjPqaRB0bbaHR0pCFRcRQD+t1TKYz5mPoVHxw5+9FSwf60nbz8bsr9YxqycKbd+R
         JI8YCgTARUcfnyWg4LuHqHLE5jY7nNfaClBgNpuB2q3+2SogeS7GDs7CSo64qmp1f3jc
         OdJWMXyz8dsu2C1I1WLdfzXWBULV1UpNYVrRPduFAQ5HLT3p1C3SeSU2lyxWaxWVaQIX
         U8ZW06XawCeUxs6giW7Xbven1Tg6UeufXKuv97JJt/BKSwSrDiie0iNWGyxzaqGnneBC
         TykUcAujZTXPC5/K7pf2vGZbqRq9n3o66WF3WYB6d2OIDte77Iob9fsHfk6m7neSwIZ5
         SwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075023; x=1741679823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW335vmvtfvYEmaka21fFYN5MW1M94pNUFyg4zfSmOE=;
        b=HgWndArWhuJk6wKN2cvJdtnpxcZXEn05TPrsCtoP6bp4W3le1bPwnWlu3YUwfnB8L6
         SlJa/2ZxzUhhQtmt4RTSH+86Afk4xx09XGYJLMmP0B+LwFfaNJ0y8YtlTgbsw+/seyzM
         Fz5oLR9P7fI+hZS0bV+tEmosr02s+oty6kuqMQ530EcPWCHesAyYEG6+f6/paZxfFwlY
         3CqAX06wa50lQo1V9oPlrD2DXoKfgmNagV3SRI/Z73ZUNQXAmHDH7c6P3oQa250CBMJf
         RRAd75ney4wwTNw2ucQzfh1aqRt1PGsMzqiT4t+Jzo7vZtDxFgH7uaLNg79nY//16qwL
         m2ug==
X-Forwarded-Encrypted: i=1; AJvYcCW9wUqOpTP4hBodcFjdcHzBuPGiMXS4ULgW4wVO6JFKNjgp1SJ4pky3Pa2nCaS3hKuUbCjElRo/cHbnbjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAer3oQ0QbIOIyw6PdE77qGnqmvBZSTJ/tIwXa2+t9/aGZC67F
	RGtExBbi9qPrEzOThJ5JDwOnEfcXAa8PraKl9/ya3uwI5zmeiDG8b21TfO0I3zZTvdN1qcwkRip
	+7Oj8bG5KW/ETlhCQ2HBWhQkVjA+nhpkWeJoJLzb86OSh/Af+mgw=
X-Gm-Gg: ASbGncvGHs6f3vcSeG0vzvVvWd3doHBMhSHrNcV3S4G/Ag2UwbM2uwnzrSp04fhai5G
	NSa8Nrym+03KAv0R5EccHEIHOxkhhD6O3Rlmx19mDZAEO28oDrlyPvFeJohnCLc04VHyzD6M4WX
	FWleYBRG+fIvGEnNFcYAJlqteYyA==
X-Google-Smtp-Source: AGHT+IEC45SEMzq1znYQylPcN1bDBXravSrfHmPZ3iZfnPgxT5XNdRhy75iGuFWtpRBT6l+L7MEoL6EyvLtuAZmNlU0=
X-Received: by 2002:a19:ca08:0:b0:549:55df:8af6 with SMTP id
 2adb3069b0e04-54955df8c86mr3865824e87.53.1741075023137; Mon, 03 Mar 2025
 23:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740745270.git.mazziesaccount@gmail.com> <50003ead72a41672ad25e90b7a273ce48f04c8c4.1740745270.git.mazziesaccount@gmail.com>
In-Reply-To: <50003ead72a41672ad25e90b7a273ce48f04c8c4.1740745270.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:56:51 +0100
X-Gm-Features: AQ5f1Jod23brmYoB5KN0x6KAMbdCsgZ468CTcmxQ4fZ2A-aCMV_-agQInBIxzjM
Message-ID: <CACRpkdZ=64sgZuyb9sEF6+kOVxPcBdiVvkGgQSio2wO3kpeChg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: Add a valid_mask getter
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:35=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The valid_mask member of the struct gpio_chip is unconditionally written
> by the GPIO core at driver registration. It shouldn't be directly
> populated by drivers. This can be prevented by moving it from the struct
> gpio_chip to struct gpio_device, which is internal to the GPIO core.
>
> As a preparatory step, provide a getter function which can be used by
> those drivers which need the valid_mask information.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

