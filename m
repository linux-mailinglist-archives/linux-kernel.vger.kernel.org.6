Return-Path: <linux-kernel+bounces-365304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D099E031
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A241F22D32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67B1B85E3;
	Tue, 15 Oct 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVaIiI8E"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A41AC450
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979381; cv=none; b=Pp7rZ/Tpbf8N2fI/ELZvvotri9SmvuGwY2L/oyAXX1imVEJkycOx3WCCk5JB7mivzRF0WofgPbMJ2wLoJHHKDXR1aEz6ejZ24w6Me8+W36RRyoFgbCESsJTNPj6ny3Q9kwYrCrrZ2+wx9JomNyYpSEHLeWWWvkMYHHBGj/qO9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979381; c=relaxed/simple;
	bh=DRj1/DHOXWncVXSoPGf7EFkE095YCbchip8AqFOhxqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgigno2Os470/gbMseWfh0ElGRKd+tkHIsEjqU+bq1DUnJmmbMEiJPBbmI1ibG/CA4ymrF8TIzCIjz0Gnj9f7JBzIOnZnQP0XWXlmNw4C3RCp2daN2P5T3aak9Wh8vshljvJXBBYFnmxT/lvuB+1FjFDqmTzy0xo7f0GLebWJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVaIiI8E; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f84907caso2096916e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728979378; x=1729584178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRj1/DHOXWncVXSoPGf7EFkE095YCbchip8AqFOhxqE=;
        b=SVaIiI8ENl03f3PgPyrrssknvb0UhJvlcDjjEpmxn+8bWq7ycuwU7YkKMR99N0EdX0
         PDqVJwgXRybOvX72djjDWB7ZQ8qhQgCERyH1VlJmPt2Mx720krtQO9atiqOWYe6c9gK7
         D44PlTVkV+68RwI3ehKTwEGh/ajKeNIKi71/rLE9zUzBt1dnfTVBsOUT2bddphqGMNLo
         VKMa0ti14ILrCpz137q4CDmydLcnVZ2dP3oqXO1jwLvSMxL9JSX160mZ3blFHbSqLKZN
         om1tUdeYNlWq2iMSlW/HxOP3Hl0KNjoamMyQIPrC5oCUkE1l88lwz1QcoTubw9b/ZqEC
         x+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979378; x=1729584178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRj1/DHOXWncVXSoPGf7EFkE095YCbchip8AqFOhxqE=;
        b=ffldG8MxIr7TVnrL8Cg3YsXSdMNMuJzPJ1lzuE8KEIbFGNg6zOJjHIQuSg3gjyKcct
         hab2xPHjHD0YVUb5NRQuw6g340bCjuuPEIDx5+h0POOV2rBUdzOwQV6RAWxDW7A7SbFP
         sY08YKDJX7ZvmaQ9k/HFWAEybE2XX60e6mWu2GtwMkCFGUrLxkAoyvsRX4yH7r/aFVlL
         l1VK2HXzmKcU7S8E4OprRGX7Ky4Jhq1xRvLNm0Rf2Cz48P3Ii6XrjYU1SxGo0d24HggN
         oSD6bFHyTM3s/jFGGNh1+uM4QpOzIy3qzpQbFhVDASsowMllFkBODcKUErg2d2ouw1Jc
         GQTg==
X-Forwarded-Encrypted: i=1; AJvYcCUbIXSlj1y6gdzVhtmGEuUez3nOEOCwHt015WEoyiLbSgVICPDJ6IWXyLXHfkTR1VHv0DffXwkFatw62mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5egzT+ZtYHsZeCE2bWQfhorlrIipCgFdOUW2GZdhosSgL5nB
	wV869DIK56rSHMsExnOCXMghEKueS690zMMQ4WwtnoyGlcdZyx45dVhJt8LN7K5Azj2jOv2nucL
	deVYVsMpYXpNL/LHgnpX6kLtqoTsaKdjadsDeNzVOH9WCvVVCtfQ=
X-Google-Smtp-Source: AGHT+IGJJNnLVcsF3y/8ICzDvD767dBuQe2rvPulj3G4OfonxvMah+hTdyQMaO5wO7v6M1Vdj5GcuyQNjVe1r9Tyiok=
X-Received: by 2002:a2e:6109:0:b0:2f5:abe:b6bd with SMTP id
 38308e7fff4ca-2fb32b0242emr58456921fa.42.1728979378168; Tue, 15 Oct 2024
 01:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014121831.106532-1-brgl@bgdev.pl>
In-Reply-To: <20241014121831.106532-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 10:02:46 +0200
Message-ID: <CACRpkdbBB0+zYatRJYGGtKFE9gZynKCWUeJBY9npJ29Y5fRiyQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sysfs: constify gpio class
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 2:18=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> All class functions used here take a const pointer to the class
> structure. We can constify gpio_class.
>
> While at it: remove a stray newline and use a tab in the struct
> definition for consistency with the line above.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

