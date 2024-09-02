Return-Path: <linux-kernel+bounces-311329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3366968797
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307131C21883
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD033185B6B;
	Mon,  2 Sep 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LAt6zT9U"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F50184523
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280512; cv=none; b=HlfwpOBtpSvS1UqNC56b1we8p28zP/qDtGXY4piomENEFCa2UszDzofUwXwaLuzwhyb2/Kv34LQW5/UGQ+TgMUOnyg3nXTT6B+x8G7Tak9jxZGBaSHYbvJ/l+7rm8vX9loqHHupYclsbmOfXdBqBqTPIjKF7WD6p6/4FIkPNFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280512; c=relaxed/simple;
	bh=5ePKlOnV1wWn86HVHXuHwt4L9SKwu7vupgGNA7ENl08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ol892/bE+2hrcYk971YQn8wICDupCc3LDM7RkOoRS/3wuXCwO1oLknqvHKwHb16u2Hh2u3URMylWkB/0/tZnSjuAxcv8l6ERo0Tx9/Y+m2Pedg7ZeFrg8CiRkr6Xa0SW8poFijPO50Gov1USjkqZKxxgqn4+RrN7ko9ZdVGBBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LAt6zT9U; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53436e04447so4348863e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725280508; x=1725885308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw1aJAOXrixR6TUTNnns/dVDr/oIQjUDJUJrPgQykCQ=;
        b=LAt6zT9UqqmKV/18BvWq6c1m08xB9eTrOPOc8xSGHkAvrL3hD6Z01BkJHG9ODoDumN
         H4Fgq6VwU15AmtQkQcX/1y571An14DgaR+Pm33qFNNAToGsvzQAGHyQbP1QwoXL3cFNt
         +vYFGnfj36lSj+tzLyjAL9HOCl1gkerhz9AZS5RbGuTgvehQGhscaNQ4Z6UotwxFD6xl
         VRtnDf7d1eCSYY8q3jSVrNGMLnNCCZM6UIsN6SRF6kfp6j+5WPdxzlLipLZutxV6GRqG
         sIjLHYZ2uox7AHxr0wvB4xPwW/5VYA/gi3oxIeTxeonjkhLoGfcLKJlN3BFdlXTVdoX2
         Hd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280508; x=1725885308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw1aJAOXrixR6TUTNnns/dVDr/oIQjUDJUJrPgQykCQ=;
        b=rIIc2GDLgOi9x+H1+pyuKPs4mmUWATX01FhZ3nLEQ2VDn2cYg7jvWqVZPGBV5ShZA6
         E8HcjyDVKVJjhDekbfbzk5ezjyBKKPySpWZsNnxWoxfgR//J7TCZp6zhGb+6Rlgl9tmW
         aeXKrFkfqeGwLjJhW0f11P7Jz886PHwAdDP9lSgsv8aBrh9+h3IT4ESURGt8euFtIwkq
         +Lz8kPC4+cv3Vmsv4KzljFKLfSwr57uKD/St2QcSx1CEhaHixaHGV1GZoBrcQ3AwR/V5
         44hQfxwcqJQ4Q+OxKLmAvaXgTzU6ZYKs4D2hMjypTatlgriqINFNb+GiO21WOLGQ7xfG
         XH9w==
X-Forwarded-Encrypted: i=1; AJvYcCXZFoLIU3uSzE/DNIdYZl5vSQo5/2c4Q9+yyKt+7deQtg/LlfjeLtPsrflP8HVpD5CBosdkXjPvZoGepkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpp7j0TpE10Iu207SxrCmqzmyYgIcjdXTb3n31rqSz7vpcJUl5
	b9T+eXgHm1a7NBsqdmAG5Zoqbfe/kI1AGVBjoB8th0irZwjjRBnX3ta7fBJlws9kcZAHtMdiWbh
	z1vzsQ1TM3anmfiJRekPPopv78UNoXKLh85QA3A==
X-Google-Smtp-Source: AGHT+IFR8ir3pzwR1vG03zebP3b957HnmOuJCMw+Yhq7P3ScciiovNTTo3H2/+/m/x2OGk+vk1tFadnUcofYIkrYpok=
X-Received: by 2002:a05:6512:2812:b0:52b:bee8:e987 with SMTP id
 2adb3069b0e04-535462ee2cemr3730497e87.3.1725280506817; Mon, 02 Sep 2024
 05:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826161850.74447-1-krzysztof.kozlowski@linaro.org>
 <CAMRc=McgbL5DCu2mr6oWERMQMFQU1Bm-1BkC+XR=-2fPXpOW4A@mail.gmail.com> <b67efbc8-ff21-486b-9961-498eae0f85bf@linaro.org>
In-Reply-To: <b67efbc8-ff21-486b-9961-498eae0f85bf@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 14:34:55 +0200
Message-ID: <CAMRc=MfnyapSZUWRfTFbfmD-b5YotmWLFzdxG_W=s=bdLULgGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: kerneldoc fixes for excess members
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 2:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/09/2024 14:03, Bartosz Golaszewski wrote:
> > On Mon, Aug 26, 2024 at 6:18=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Drop kerneldoc descriptions of struct members which do not exist to fi=
x
> >> W=3D1 warnings:
> >>
> >>   drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lock' de=
scription in 'pch_gpio'
> >>   drivers/gpio/gpio-syscon.c:46: warning: Excess struct member 'compat=
ible' description in 'syscon_gpio_data'
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >
> > I have a different patch in my queue that addresses the syscon warning
> > already. Can you resend just the pch part?
>
> Heh, you just picked up something which was sent week after mine. :/
>
> Best regards,
> Krzysztof
>

Sorry, I got back from vacation and was just going through the inbox
in no particular order. If you really insist, I can back the other one
out but I'd prefer to not rebase if I don't have to.

Bart

