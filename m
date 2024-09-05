Return-Path: <linux-kernel+bounces-316939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F096D748
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46421C25486
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38220199E8F;
	Thu,  5 Sep 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUEJFb2K"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1319939E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536151; cv=none; b=GLNqJk2Mw75TTe13hSoO7A8u+bI/5bkBeo0OksRVmNokaOtQwVHiWhGSJyUK6INJcRnJTyQOkigygqCrdvGt+p+U2l7W6B2dk5wIhD6klx4dxQZD30d3SCcD3sOXGs9rZKTT+K+jN3SqQKn8dmcUG4LX2bDhzFcRr1CjwUw/dQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536151; c=relaxed/simple;
	bh=7yk3x+ZbeN2BNhaMaKl08JcgwzeeYygIIBA3a3DlQOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVrZty8zqxrs5I5AGZseaI7gO8/qqop7LGEEO0IPPVj8FeKv/GK3+OC0P3XsoOzcxIsk9OtZV8wtSKM4zHdY8BM1+DXPZeaFADwBoid7vuYMYw1pfpgGBhoKEScOSq6592PBVxmFUd6a6vrs+SBrnC+y5lDJ9TWLNg7v6BBl6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUEJFb2K; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so754284e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536148; x=1726140948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yk3x+ZbeN2BNhaMaKl08JcgwzeeYygIIBA3a3DlQOU=;
        b=eUEJFb2K2udfs4O6UtOes3ymXNfx0MRAZwKhCG48F8MSR/20b8WWvYyoneNYxB+NjN
         YHbEz0U2L1DcD+0wga2e3H5PSOzb+XORX+uASm/5kn4TYqcK5qTRN4dvkfwIjt+wi7oi
         bDgNWNq2KNiydtyfjsQA0H7xqLD6WZo0i0Kjugent4Ac3t3a8OrdnAXlnq1a9BiEb4M4
         iuS4m/JlJ27enJymYwXSzmqDsHRqYCz+sN2PxZoRJvTwgIHNXTIfAgvzxw/et/jWKVw0
         mtA4JWhN/oZxuvEGGzU8haq58dUUF95IlEEKpNo8H15/hU4Pws80SBY2fC4gL9nDHa2W
         WgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536148; x=1726140948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yk3x+ZbeN2BNhaMaKl08JcgwzeeYygIIBA3a3DlQOU=;
        b=ncGeRMGRPWL75I72xvdqtj1Hig2ue0XhVVp0U649kK75E+K1JxJQfFYJAqOI4v1Fuf
         ByFv1CWX0UIgqkbq0RG8HWh/yRTb2FzZjs/5mhkw2tKItl50H1e71mZHeZhpGKEct3ke
         5az248QgWwrTMkGZ+zDhNnZInHKguvdixfWkU4M1L3PFin7Rj3bVHI89iOSlnM8+15fI
         1Akss11hZ03f3+vpYXr0qNRq8jhjh+7GAAyetM8kVHkJtzglSDp95yi4V0XxyrgIq+XI
         dQ+XzotJz5xFF+P1F5T1grQQBd+cSimJiaPfXM2b/mcvsa9ZNXNffwazsSmN1dpirKiG
         YDyw==
X-Forwarded-Encrypted: i=1; AJvYcCXuMuYvwzn4VG4lohpZKkwaBl/mkPAY33YeRCDBI9V4Pe9LKLKrGPnWWgVCBqpTCbYmsssBUXYZf3CVexs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4zzvJuRnN3q8TBRy0D+O+G/ZBF7MXq76s2u/FXrBkDHtKOcy
	tBnz2wSclqpBafopZrxZpP1LuNnYoZSt3f1egrEdFGtWpl5Zptiu4uR5/ayksnbBs13aEsxdZYL
	hFfQBT++FRdukNL18MmirYqZYneurO95aKVsPqA==
X-Google-Smtp-Source: AGHT+IEjAFWpawyNYHX6o04UXdt1Y15kepVJVBWzcsdgvk6TbjbGz0vYtLmv8rsg/6hXc0HmbI0fHBkTDS09WeNY7AM=
X-Received: by 2002:a05:6512:224a:b0:52b:de5b:1b30 with SMTP id
 2adb3069b0e04-53546ba09afmr15547801e87.44.1725536147976; Thu, 05 Sep 2024
 04:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com> <20240902133148.2569486-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902133148.2569486-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:35:37 +0200
Message-ID: <CACRpkdbVfJf_bte_0BoGK3eu80LjO1kLGP3QzgLO0_B1guuD0A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] gpio: stmpe: Make use of device properties
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

