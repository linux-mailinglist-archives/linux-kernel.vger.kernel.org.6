Return-Path: <linux-kernel+bounces-361792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A199AD15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0CAB22AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5C1D12FE;
	Fri, 11 Oct 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2LSqeHN"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F01D0E3F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676130; cv=none; b=N+Iv7WqkU07Mgs/6D+nen2/VQWmS6w3Nyq9BRQRIC6ISMuOivY0IduArSzmzFI4kMRq6H2PVsLRsOe+nXtU0fZsRSK9luhUH0YiRPPvpaFUuApEOBpOZa7GkrrlUvQ2bnN37Um3Xsz2MiymMWLshE1XR71hpa/KRhq5nBX+9z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676130; c=relaxed/simple;
	bh=nPrrWFEkh/n2rwW9DN6U89zucgrkrCgU+Jm4I59wVB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5SZBwpplRtsrFVS2ka5hw2uIs5lfAQjwqoqxlp0AvDUZ2U01aHZJPZHnUdfHcxltqm6yM8zPyyKpf0ymy+ViLHV7LcujKbjKmM7cKJnCF32TAa3PB4cEaAS9SRY2G7fBvVduERJXPqW+sSthpBV5xGKsHA+B9CVl6fl5Qu+WYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2LSqeHN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e314136467so22524947b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676127; x=1729280927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPrrWFEkh/n2rwW9DN6U89zucgrkrCgU+Jm4I59wVB4=;
        b=l2LSqeHNrPE8sEGGeFbmBXTt2+BCxSfXWqfmcyRwfoWpuCUCGvJZeAVYNvR+ykUqCo
         b2iWibJH9z/PuViVNVrbkz3JsqsDTpapSVPLE4xBFVOaYhlWzpKTa8U04uVFtpMYqLye
         vMUQUrsNIF+4QW7XJXkL5HJU53ajZZrtPxQwgoEooi633B+bLzgJw2iSWpgle8aiJ0P4
         xeEmAeUs/UicS5gbtoZrj1dU6xARWJVxoiFziGx/Dfd+/c5ZLUlMYr2gzX48si58AN1W
         HMzDT9BSoJEvswGkJqwyhG1HHR4/0TGYmtAys+Tfc6Wd2BeMpQY/++pvLue6LyrFVmNF
         GEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676127; x=1729280927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPrrWFEkh/n2rwW9DN6U89zucgrkrCgU+Jm4I59wVB4=;
        b=O0SagRkrHYlMYi1TmTfmzm+/Vd/BhJ3LN4SCnUu1BzUw1ofywkYEtA3xH7MFcqPSmO
         wyNXcsk9CfkRt4YGig+EBgXSjplsJGatcICriEau9gyUJ6OnlGNyzJk9Veb5uFvd2KXD
         fdeyNaazKkHTLfTKu1mNxntg9fbwRy0YKlxMcZewsAyCBZQ2HW9XcYWcHvxr8Zgxk7d5
         /f0jAptcfTKbLUJcSIE0ERLPKL3n/9FzNyjkELC4UsLYXoBj6eMpXzwfvI3wJRIwR2sY
         s++BfL8GzX5+yVHLfZ4cYw2BXxaIDRQYz4oCcwq43EJuGwvif0DHORuMYz6e6mkgEEic
         GngA==
X-Forwarded-Encrypted: i=1; AJvYcCW5a4/31DqjxQLz5ZnPyAV1aodQsRcodJEADSxtIGtR8Bsd6zmkgaVYNvjfUuNwGm7PV9aaER1GVhLaBN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/3UPn33mLc4BQNlqOxal6Q2FQozbR5Ni9SGNy4b69MVR8C6N
	9wr2ok04VtF+35xh4xPwfQ0Ktur7fYjR0Spwx7DdYdHkzenAnSR4UkEKTqu0O1JQHs+ntFA2LoF
	KVwJ4+FcIDAxYusJV0HTaqb9q+Odgp6ko3CvMjA==
X-Google-Smtp-Source: AGHT+IGcgArKV9Ezyx2JxXIT5g/tpC2AAQqsWGKx7COvsSQwXw4Ct7g3+6rTQ0Ix418MqQv3uMJC5A57ho9IASI8Obs=
X-Received: by 2002:a05:690c:7442:b0:6e3:1d8c:1224 with SMTP id
 00721157ae682-6e32f29c8e7mr61767057b3.20.1728676127524; Fri, 11 Oct 2024
 12:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008081555.23465-1-brgl@bgdev.pl>
In-Reply-To: <20241008081555.23465-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:48:34 +0200
Message-ID: <CACRpkdbO6cQL37DNozuePACe5nT-DWgzrrBN8SLEYzrFrJKXPQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: drop dependency on OF_GPIO
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:15=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This driver doesn't really depend on interfaces from OF_GPIO so the
> Kconfig dependency can be dropped.
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

