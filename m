Return-Path: <linux-kernel+bounces-514788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78901A35BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B4B189236B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608624BC08;
	Fri, 14 Feb 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUWNhab7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF59204F6E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529551; cv=none; b=ZGBgxmGGrK3+ys5OiX12WKODyZ2pHyo6EZkTO/Dt0ouuTcnHkzyt1d346ev6MNaAorHMVLMLJxUGbp7iAQunP8L5x85gpOrVBfX/CH+vtq4zXL3sKffH7Z/ttjHBop5B8cNnHt/eQ9wXQfLlD1Qz8RC/FM3jvIorDIPZC2c/mQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529551; c=relaxed/simple;
	bh=9WieDtozVEP30o1rMgmkET2eyeUrqqLkfHQ4w0SM3zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvy2RuZef4RXb5rtQy1INxRJa4D0JJybSx6/YcN5R4uVVusiQ3Vw7bdlWn4Akd5UczayQfv8LXALCC9mJ+mb9niAPjgVKllX71nvRXpgjVd1+p8wvGOToxOThp92uEC/srjOYmyvczzL9HweYzsY5L4EqPqpZ2neav93DHwHy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUWNhab7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3076262bfc6so20182471fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739529546; x=1740134346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RvZPpwQCYzg+8o1DHR3C6tWw2mYjAqdjhIanmYv+iE=;
        b=jUWNhab7+RtuPZckjgGxMEyoAAFzLiugTgbrU3FaFrAJeWBZh7nNexwB3v51pj8mDy
         xFOQ9eJf2kW8CvfMzfRdJpMGnz8w0GrO8i7J2YK9NlEUMd6lU/rVtlRtffJqXIDolqbV
         SgeQrk7cwZxW0l46kt8BofS9S7W2ZV/+LWT+tz9X4R1Cx6wTDnGJ9mJ3xbit84knxDh/
         iWYd2/5e5mWbR1wPKJ024iSxLZEDK3vY6p21nCsZNwS4CXH8jONxxdJSct72dIxo4Fzm
         mMzvy434cFHudvkYNxCdFxkeorPXOcrWn1cU25gSHOaDCUSKYWqIQcG4hL9aZAoTJHoY
         lOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739529546; x=1740134346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RvZPpwQCYzg+8o1DHR3C6tWw2mYjAqdjhIanmYv+iE=;
        b=FdrT3gKwYnIOqv4hfBcJTMMqumap/Q7RVR7lFatXWuskZTdONVJ1M1rZjVmyS0eyF7
         QIrkF78tE79KhXQKkxIy9YjVKE4UI3fRvr9Tr3MT+NjgPfH9qUJl5wVcds+reheaFeEj
         IQqjR3+qJWQ01qjMmJqLlW35sdnCs53AuN0xVU3/JAblyk3zGVFw1T+FBa0mHir469Mu
         JPyD2MNk7s9GJgvwhJg2Pj1W/eYDYrUl/pLqxqjLgp4GJ72lIuv5/8laOjBxvsV0AsA4
         yzm1V4+5RLiDOjZYmwfnCY4z9lZZgkoQSXwKPpuK01Wd58SSGCSF3xr+/3QlqJOCqp9i
         gHGA==
X-Forwarded-Encrypted: i=1; AJvYcCXdBLDKPwB80gN+iDFi+dJFj/mCxHRkuGXQ/D//qEdFpn+QB2lHfkuQ80CdVU+i/CS67N6kxkOMrhHQLT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6i6XvXWjyi/KHUgdh0XWyxAcranyHSlrocG6pZ0ueT0bme9qA
	yQceQ2cXDA2K8SdvP0mGhvy6mQrYGRabMs1P3LCSBh3GM6HP7GI+wLS2R6byHBStE1/5lnN6jg0
	eD8f3rxnajKKWcjNhey+PHpzXTEskj0AdMoedDQ==
X-Gm-Gg: ASbGncvspOYa6xiEeW9cgwyiTuToAlweK9BalgptHNgeuXCVqBpZwPrkAy4F6frueEK
	o4/BeCxtaxu/FgpUD87Jc2FTm7iRTFwyRTB3JPhTTZU1VYQdWb/yQT28PluPKySB4PD13JnCP
X-Google-Smtp-Source: AGHT+IFcOuS4cumt2YODgYWKRsMLvcBHN8sxE4vos/EFY24hOieVy9WXAkHUqW6GJ2CI2TkzytddIGBb5y9f4GGOEpk=
X-Received: by 2002:a2e:9a0b:0:b0:307:2b3e:a4a9 with SMTP id
 38308e7fff4ca-3090dd33349mr28348041fa.20.1739529546052; Fri, 14 Feb 2025
 02:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213180309.485528-1-vincenzo.frascino@arm.com> <20250213180309.485528-2-vincenzo.frascino@arm.com>
In-Reply-To: <20250213180309.485528-2-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 11:38:54 +0100
X-Gm-Features: AWEUYZkcoUajk8OY7YlPuAw6yk_Mx24LP1X0bHTPQEW1VEF0lTSP39l_2JHco3U
Message-ID: <CACRpkda-J_NHC7Te=Shk0A-35qWms3xeM2MggdGM0ze3Gt0KMw@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: arm: Add Morello compatibility
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincenzo,

thanks for your patch!

On Thu, Feb 13, 2025 at 7:03=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add compatibility to Arm Morello System Development Platform.
>
> Note: Morello is at the same time the name of an Architecture [1], an SoC
> [2] and a Board [2].
> To distinguish in between Architecture/SoC and Board we refer to the firs=
t
> as arm,morello and to the second as arm,morello-sdp.
>
> [1] https://developer.arm.com/Architectures/Morello
> [2] https://www.morello-project.org/
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml | 4 ++++

I was thinking, that since the .dtsi and .dts files are not reusing
any of the Juno .dtsi (correct me if I'm wrong!) this should not
be in vexpress-juno.yaml, instead perhaps you should create a new
morello.yaml file?

Yours,
Linus Walleij

