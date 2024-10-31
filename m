Return-Path: <linux-kernel+bounces-390567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02949B7B80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5D1C20D53
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4819CC2D;
	Thu, 31 Oct 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2jNm+Fm"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967E2110E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380582; cv=none; b=TLGhhwLle51Iu0vumpKaTv7fzKLufBe9puW0KY2OM2QVDvpnG538g4rrTrtCGHb3Am9hkyAVjzOW0AyS03gG2biU7ogBzBWrqwbQ4XHBjSNhMCqL/J+jUyFImWqO6SHNfpNP/sP10J3FjWuZl13NB7746fN5PyOGrc/PpYLsQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380582; c=relaxed/simple;
	bh=Ya7CUb7FV9g9y/+elRZ/f5V5YxdfeApgm8Lye7LQoUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ybtfa0sbvdsrwVAcN+laaWtiJDymJQu2m/julADZP+8US/HHMzaEfloh3aGwaW/KJoeB1j17YBvfgCvtYlwxGJfynGqNlHFl1zyLrk8K0+EdThQCJcCtg1946Kgwqj7bEBlkHnesRbiQgJa92kNP0rlhUbeG8HRSqMqr27lTmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2jNm+Fm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f1292a9bso1156799e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730380579; x=1730985379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya7CUb7FV9g9y/+elRZ/f5V5YxdfeApgm8Lye7LQoUg=;
        b=h2jNm+FmpcASElHcIbPnMCb7RjqFf8auO9d+fWyG3MbMiEq3TPxzIgey96te2Ig+49
         uU0EgxRVTsjY6ib9/sMLeMLZynxq1GBEQAUF2sj2ay+YMdtJ8H/GTbAMfrxPL7oCGEI6
         rYCTQwmCZvPKn0dt1NIt7Yi4A2mxb0Cq2KMBm1DQMzt2AqL/Qxbi34dstVF4nSbs3lZC
         x17Hj/3StbHg2kbqX6VEbg3nvkHqB0XRXYhy5oWBOAliiMkxKZyRHGPzDhHr/yZUiWC2
         nnvTFMVFSyz9VmOYuGa+VLWqmfRlA83WEZ9s9q7+YwNFBVoMmVpZYztdFOrUABxYjiHT
         +RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730380579; x=1730985379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya7CUb7FV9g9y/+elRZ/f5V5YxdfeApgm8Lye7LQoUg=;
        b=hbZvlHVgK9oHp5FuS/509LkFTzMp8YfiHgOsf269BofALIQ5iaZw+nCV7gLn+hJ722
         870Tt4cg8a15ZVrFTluk0pAwxu7VOhA9xFubqJWfpjP1MeHe1W08PUc23txZtnicavSH
         Onsae3vbuVRTuxBWFrdPxcb4P7fptULx2tKyOrFaqgRNFEsozfbj7cwaKJd6x09y85H5
         c/zuAzYnul0cfckItjiy+PTY3jcS3TCeUMO8EtQlFGwaklNUnDAhDbnDH92eZe35k0vJ
         NEYAW/yXQ1fdORhsNM4KBf8bmu7ooVqQXszVxE2iw5EORLs3MYiDldQtnm3itN6Mva+Q
         HnWw==
X-Forwarded-Encrypted: i=1; AJvYcCXScJuwYU+cHKPboTDv1aAsaVm3eHFTWSw7TOVDsseOWFUA0Y16aSC0BDOSDL9RcxhrOPIWxSYJhHrPKkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRN71qcvWFVxgF6rbIB7avLsKUuK/OZXegQZWae3Slle8Rz2Q
	cOrmvb+yD9KBwb6IiMmYDHf+3ozo8nac8mFotdkX+xgJxxJZM6kyPjzz6GOh1DgLTEf04D8JvTP
	+76Mj+5WFDxGTvHGFDYtdvA7pnekyoRIgvzkjksLKG6dFtSHK
X-Google-Smtp-Source: AGHT+IEI73z1BtuNE0Kxpp+mnj0gibj9aj5yv3ry3uVyRGLBedQWBbUpi0wzeC8AxQMJ0/8fvyuJADzzvCbd5VyOplI=
X-Received: by 2002:a05:6512:10c7:b0:539:fd1b:baf5 with SMTP id
 2adb3069b0e04-53b348cb072mr10600630e87.16.1730380578745; Thu, 31 Oct 2024
 06:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031101836.2434308-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241031101836.2434308-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 31 Oct 2024 14:16:07 +0100
Message-ID: <CACRpkdbOy1Gj+MrAAAtQGQT=jZ+Zb-NV+Tc5nTrJ7OWT35sfwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: altera: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Mun Yew Tham <mun.yew.tham@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 11:18=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Remove legacy-of-mm-gpiochip.h header file, replace of_* functions
> and structs with appropriate alternatives.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for cleaning out this!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

