Return-Path: <linux-kernel+bounces-429684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26C9E1FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B61287A31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7951F6696;
	Tue,  3 Dec 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysTKvBey"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E911F12E0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237250; cv=none; b=J+FPFb/CySTTq6sSRKHTPT8NvInEHgvKUHsLGQb/WqEFPpoJHTrK1Cuknpeh6iPzPxVw7Y+cSsJHJUefH7JeGvF2CoZJuYKKKwbo4I5Yuj7PCTlp771eUGrFggfgkDLKHxc+ysPVK+/XLBndcS79dTmQU/EuZSluNMp3DsY06hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237250; c=relaxed/simple;
	bh=88ogFTJY+WVyaXYeQRUUQYXOcq9qFAHKf+T0txnkxSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqjSeGwpbk62qh9TWJ5B+EYQ/7bSBNTL5yi0EBHoG5KqEbE5ewyX8u2kanDgWMPn3XUMO0VDDSUzaEBySMs2jkMETdc/Vi8HCGEsfVKL2S+N0PHyp7fUQ+FOFyMohjP22rNFcBWqYuYeUt6YMZr4xZ+X2/eepJxaZ65tHuFnU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ysTKvBey; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f1e560d973so2767140eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733237247; x=1733842047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgM8+c6QyalF7cc/76yT7fGDgmWP/O2VdbCIDqU+xlI=;
        b=ysTKvBeyHEc8p5/6Z6YLQ1+96Bm2m9VR7cR1H2ZGitg4eJgPD1qgk+7/hpQTKysuib
         p2QoQxucpSqcQ/J7T2Cywp9ApM7tTEHWz7X6gRVztjjv2XZM4WEHxXtpJsAbKy24aTVD
         drbpkY73hgW47K3Oms8bA6tYjPN8Wsdda8JLlA27crNsX/ArQu9K6WjNiha7pdQk64u7
         jnBxAkQYOj9oBq2Ipn/0gMIQ22KtlvxwosEShUEc7zIvEWg6tyxnR1pC6Vdm+7ca3wov
         bwOq8suUzUgmM4pMlp4A6icHyR8CKDkFgf+oqHq/p2sRNYw5Yd/COx1RKrZwXNBg9iBk
         nCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237247; x=1733842047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgM8+c6QyalF7cc/76yT7fGDgmWP/O2VdbCIDqU+xlI=;
        b=ZQoytPwhSHEz3ZMowH4Qeua/YyWn5uYgU9d+GRfNjc2yngoAgpCsQ5aFgr83Djs2HW
         15y8PMYxnBVi5nhMrrY89biLE55L1VjH6+U+40ldsf6FGYm3WVJ3vFhj9cMn/4vK98/+
         Pd7UaamANTOrgi2cIjcY3kUB3uhswE0Jr1hqrGepWWOgL5iRQDzE/bAi9rX3uWR8RTuZ
         xwN+L6rkGFw6/lciJJc/StWr+dN3er6MGj/eLg9dXkZbRFEjbB2NaQY6JyNED1JpXKmE
         4dG/eD0bIRdd3bN2qh2svsHIlaOXHrvQqvLQkTOPN7XqVHY9W1xLgZwIYNkzdnToy5I3
         kHQg==
X-Forwarded-Encrypted: i=1; AJvYcCUTT6LAH6t4E2Db87hNTsiRCupEdm/W4lLqjcx6QDrr/scmPKJ8VcDj3qu4TXmYtKWSwTEVR8mclEDtEZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmloK/2BVxqQFzJ7LUeP74eqbvKycddNy+xfOleWCvcMi3OQh
	JQhEAsDhlh8SwLku+7FBCV/ZoA8dG7lkd16Wlrcx2YvreqL+mFiQuldBIK9ZO20EEE408sgCpS0
	k7Mv+qqcJh+z5b8MY7kaGY4mBIYsR/QT0b6VNDfoaqlVVR6+91gw=
X-Gm-Gg: ASbGnctmMX2UG+EZmSrZiqeBc5YIpEPsr0N5zyG7/xscMuaW5ML8OzXVCcNS3hkUlGb
	W9V3as+eE/ethxlJDlqcwSeE75zI2bxyCcw==
X-Google-Smtp-Source: AGHT+IENhzKf3J+XAqUzX24pS41sfMggDYWVmlBRkpteJm5vDK7SpgO5QphskG20CDt+MT2o+rMDEXThjllUSYU+Bt0=
X-Received: by 2002:a05:6820:408d:b0:5eb:5eff:afbb with SMTP id
 006d021491bc7-5f2178caf33mr13278379eaf.1.1733237247113; Tue, 03 Dec 2024
 06:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
In-Reply-To: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 3 Dec 2024 14:47:16 +0000
Message-ID: <CADrjBPrYvz6yNdvZUmTGVAvOtP53kHBLVt6A7zCcRwK3rDg2FQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself and Tudor as reviewers for Google
 Tensor SoC
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9 and Krzysztof,

On Tue, 3 Dec 2024 at 13:03, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Add myself and Tudor as reviewers for the Google Tensor SoC alongside
> Peter.
>
> While at it, also add our IRC channel.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

@Krzysztof could you take this via the Samsung Exynos tree?

Thanks,

Peter

>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf1d81bd04a7..2039cc57d8a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9754,9 +9754,12 @@ F:       drivers/firmware/google/
>
>  GOOGLE TENSOR SoC SUPPORT
>  M:     Peter Griffin <peter.griffin@linaro.org>
> +R:     Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> +R:     Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  L:     linux-samsung-soc@vger.kernel.org
>  S:     Maintained
> +C:     irc://irc.oftc.net/pixel6-kernel-dev
>  F:     Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>  F:     arch/arm64/boot/dts/exynos/google/
>  F:     drivers/clk/samsung/clk-gs101.c
>
> ---
> base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
> change-id: 20241203-gs101-maintainers-9a24c8b220e3
>
> Best regards,
> --
> Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>

