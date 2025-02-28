Return-Path: <linux-kernel+bounces-538034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3CFA493CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1920C3ACB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4412528FA;
	Fri, 28 Feb 2025 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSdMfQuN"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0D250C0F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732185; cv=none; b=N65SiO5x0LwAp2IHebL7qwbWcrMBxzizwgaD6SGe3hVqY9AudEPA1xEhnPlmAsbKJGuCKd3KO3GagASw24t76rVlE+bhInxoHXjGCHenrCibt50JOO4H86uqcMYRTPrG67R6kzDH6J/79DjA7NfG1+IUUzBd0CDv3X6qlOMAuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732185; c=relaxed/simple;
	bh=kx5ixhvdP6EmZ7yF5ftbKYrRukemNttfsGC0jekV/Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0RwDVXkz+GFQAiCYuDKZUptZUv3W4wGyoHzv5U4mlqv88PqHqIVYllPuedp5QnXdL9HWhyls5pUOmOdXVRaEuwWB9gw70wZTh0pwe1bqv3Ok9763/WbIz+X1tuisNEpXeT2EzizcUptRlJvatAcqi8sQ6qotlDPZeQR9rSNzcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oSdMfQuN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a28bf1baaso18223541fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740732181; x=1741336981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx5ixhvdP6EmZ7yF5ftbKYrRukemNttfsGC0jekV/Og=;
        b=oSdMfQuNDVth3wWTaRks3YxgepFFHPDjNkiaa3KJatMYwcWQAR4kShm7/1kihKx3Uc
         IYddF7UJXGd8MQ6IK6ZquCshGaxMQfF8t9WC/txbXPp8hLkt4L77st87XQKUjLuuQRkZ
         i5s0aQV9uXLhEyWMhTe7r48iwEEmMD/It67fscjfMFqTQm0kvzwoBOZk9xrBF55MFdAP
         s5nEJpWgXdSRNY+aNt2ssFeDFavjWsU5G637ujmJkjT9li1hqqQB22nL8cUYTmvpGLeu
         p3wiNScWHxT92sredgOHkX2alyUwJ5Hm4YdMxExD2CCqbABPAo6qnq5vUByuVovDB+Ev
         AVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732181; x=1741336981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx5ixhvdP6EmZ7yF5ftbKYrRukemNttfsGC0jekV/Og=;
        b=Toy4TB7WfBHZ9sGFf8wwZQcki0+ZzVX1QK7maciruHIGPGXhl9VGETx28qlyQ9Tp4c
         2kYkHE3CMIA/iHzp3MlfUHepu8zmYsh5ZdESFKD5+flv5U9rn4qDYI98U337zY7mYKMX
         dzy+LU7ME5F8cG5NQRWc3MBlds2La4V/9b33Rp3vQtafep0qJ/GnI5cVmqBUUlPMvlgZ
         x0XQoeU1qv0ot07aNB3okc/3UjWt2bEHP+fUONKcHmnuwGA3HCRzN/pf6ZO7mYQmEELf
         uP58HOStjyRVIrR6P+yPn0l0djBamkLCGgtmtjPpX4CZxZ/O9PW3Ke5WAKEyFr776KDT
         i1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVj0lTISTNKE/jAdckyJtW3DHQ3r4DydQ2ugZLwuMbcgDQ9wl+rcVQv+ZsYv+21cofEp+mCm3aYvF8SlJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yIlP/9Ay8ccst+TF7Lt/Udo4CDXBXNf+WnuhinXYsr4NmjIz
	mpMgLWZEUO6iWJdzOjqGZjOkzITz5FRbUAXZUwqThmkvb2pHcPwz1xm4/B/0HgMNhQ6HO4fv7UV
	Vf+0RM7ObSxQUgzpwNLe0mhy4SdeC/zU2tKN6ujVdLfzVR41x
X-Gm-Gg: ASbGnct4R+urb2suCPiSR5UqNdeVXdRJPqd6enSTsqnM12GhVKduxka2/LOpLh2RVlW
	SjF5IGoNYyjynPqu60xQOwAtgCLXiGIToEJS/YTAktbL/vAKDmw6g/uCMEzjbA793KdDyfusltb
	dfUcw6mzY=
X-Google-Smtp-Source: AGHT+IFnojnEU0ZTQwdhFM8EZ+VzCTRW5WfJ+IRPsOQXruxW3ArvgVeYghHEs1cbMHob7yzBli3HbDb90ZQPHvgxO/A=
X-Received: by 2002:a05:6512:4021:b0:545:f9c:a825 with SMTP id
 2adb3069b0e04-5494c312576mr703967e87.2.1740732181275; Fri, 28 Feb 2025
 00:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-tlmm-test-v1-1-d18877b4a5db@oss.qualcomm.com>
In-Reply-To: <20250227-tlmm-test-v1-1-d18877b4a5db@oss.qualcomm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:42:50 +0100
X-Gm-Features: AQ5f1Jq7kGENpEdbNLcHzj870r4DoaeXZChk9tcwrlm_rnPAZaKo-WGL4SgZr-A
Message-ID: <CACRpkdZP4u+LwhfRYnjhD6bkoBAG7AHX3SnF=5R8fc72BDradg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Add test case for TLMM interrupt handling
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:33=E2=80=AFPM Bjorn Andersson
<bjorn.andersson@oss.qualcomm.com> wrote:

> While looking at the X1E PDC GPIO interrupts it became clear that we're
> lacking a convenient and accessible way to validate if the TLMM
> interrupt code performing as expected.
>
> This introduces a kunit-based "hack" that relies on pin bias/pull
> configuration to tickle the interrupt logic in non-connected pins to
> allow us to evaluate that an expected number of interrupts are
> delivered.
>
> The bias/pull configuration is done with mmio accesses directly from the
> test code, to avoid having to programmatically acquire and drive the
> pinconf interface for the test pin. This limits the scalability of the
> code to targets with a particular register layout, but serves our needs
> for now.
>
> The pin to be used for testing is specified by the tester using the
> "tlmm-test.gpio" module parameter.
>
> Worth mentioning is that some of the test cases currently fails for
> GPIOs that is not backed by PDC (i.e. "non-wakeup" GPIOs), as lingering
> latched interrupt state is being delivered at IRQ request time.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

That looks like a super dangerous footgun to shoot oneself in the
foot with.

But the usecase is 100% valid and I see why you need this.

Patch applied!

Yours,
Linus Walleij

