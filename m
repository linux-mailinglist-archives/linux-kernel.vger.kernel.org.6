Return-Path: <linux-kernel+bounces-531761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06940A4447D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B52318905EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB614F9C4;
	Tue, 25 Feb 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqH6ahKO"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022013D531
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497614; cv=none; b=lDv4Y6+hUm5cPoMQRZSOObPAOl19BWpg1IpRYB+ceoUUS4A7IuPPpbMSOfm5wJqmtgk/btwV40/jh+hmuK+aPe9RB0M6B5Kd/dmuvcq1IqMzytMejsK1los+VN/2e4qyuOGhqjcQ56DnZmnfJwLgQb+tKJHvowuTjhUxCVddU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497614; c=relaxed/simple;
	bh=R6pBXTVHR9QU6qXSdZSZAmxkEn4hY2E0r+sj+/bLfjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSXOM1jmNB3/8NWzIHSkqYGLgaBek8y1HMHjk7Q+ED4MXiNRB7H36b40P/XhH5lMLu5HtSf1kdKEGWVPuW4FphxuH4BlHhrvz6tFJbsxt5CYa9Uhn9bxPV3LhpbqMyChziG5A+NFQRKIELAzLoU0kK3F5t06g+gXEiO7QLdXq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqH6ahKO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54298ec925bso8053161e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497611; x=1741102411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6pBXTVHR9QU6qXSdZSZAmxkEn4hY2E0r+sj+/bLfjs=;
        b=LqH6ahKORLr0yYrijSSt946oeSNCRJzZHxtzK2hOxz9NR7IwGDYp39D73JP7UR2nCj
         idOVLhmLeC1JvqBq2mk2t01Ct1DloqTSqP/dmQ/ZdbSYeA+CJzSJuiz3EPwPgP4qoX+R
         8uly+seyzEh/g7GZEbqNP+0GD8GQ2UN1y+1Ht3Cf8+uE2igQCoMmS3Of0vFWa3Wglurf
         YLiWraylHT4fbhsYWot7iJI25ddUSvIP/pmsFGnffs/U1y9L+H6/e9RP618X1rzpfjPl
         JRWWjP7hsfh4XzNqhFHYEOyEWkCrhm6RPgSqKQYNw9K4lTWYKNDOc10lf9w8vQ/ahAxJ
         5ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497611; x=1741102411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6pBXTVHR9QU6qXSdZSZAmxkEn4hY2E0r+sj+/bLfjs=;
        b=thK7D2IFPZDNaRQHGkVn6NU+XrDRjxqCd5wX1K14Tu0Jbtn2UIvanVKl4rZ5I5+xOD
         4s6qavJm1rxarLjCFiov5Rycgk3bFdsPrldp1BK5zuWo1WM6EARwavUUmtD5rEs8qQG8
         PsUVDN0QEKPkaTkG7UKy7IloIB4BtJvP83EAsb77vPA59UCynDlzd8jcCINsT18SWQ9J
         Y9ClX6tGr9+Hqd7IylpLxM4ygf3OlCCXNHBVqde77Tt6WZNwc7uxh0xBA90ZHobd9Hpr
         F68wnKyOQE1KFEblXMcprVwwNwC18dEmy6nzTUqHbGQ4QWX0+/l3BFym2YSC6jt2b7pV
         2FMA==
X-Forwarded-Encrypted: i=1; AJvYcCXLMOZU2XJAsc2h5hPga/Q9dkoXH0bhR1W8PswXRfUPeDia/QWQhjdTyfEKIpjEo/7QjMLqhtW+fsrMKRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9OB14NzEWm9MAIliRDp8MAH3v7Ocyv18ELRuCgjSXpws4L1q
	RQcBKvTvC3xYcInuB1yUQmny975ZT1doUtZbpeILr8AcVWUeYg7W11GRfbgw2p1g476IhOUoN9X
	1qRfv2/9xNS9CABTxbweiEotH0VBQN1f4u5YhOQ==
X-Gm-Gg: ASbGncv2Lwb7crdFtIJuIvfDD0vDQbZFPYIDfktSZD6muD3a/B5AjTHRagBq0u5xngN
	dDRg8CG7X85oTdu1a/WMHDOR2gOTSxlMBJU0tm9ur01ddLT6vuT57x7llf9om/ZcP6M7ZtNNNxn
	3I4Met+5c=
X-Google-Smtp-Source: AGHT+IEV90oaeu9UQxuAox5ozndHtPuNH0Ob263aEQeN5znD9xNa5kzTKRICNt8bxpmQgEzKtDBqpOJObQ7W05CiKtg=
X-Received: by 2002:a05:6512:e97:b0:545:c1e:6603 with SMTP id
 2adb3069b0e04-54838f7ad45mr6306343e87.50.1740497610771; Tue, 25 Feb 2025
 07:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-3-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-3-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:33:19 +0100
X-Gm-Features: AWEUYZmJsXDo98RLls1F3CtT0bdN8aQhWcPtJx3KNfEkQgsWeFCVIwFiC9YVgbc
Message-ID: <CACRpkdZ+6WHJ2N3vbzPUXSj9Y86nPwkg90uwCpVQoRZY_KbLTg@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] dt-bindings: arm: Add Morello compatibility
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

