Return-Path: <linux-kernel+bounces-227105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E9E914869
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47F31F223F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF4A13958C;
	Mon, 24 Jun 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmuiA2J2"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC86137758
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228041; cv=none; b=cG0aAVhbSBjnjOs3zbG2wNRuko4ku9S6vnxlCVGMmwaOAKusK4OErKwKqn5SCp4fQZyMWDEtFUKdAgsR+mrUId6k+5/5uSt2Htuz25qjB3bXXlmpUjd284uvLY4osG+B56/4wVFxLxKcYcu/mTxzg0JFHNJPwpqizLUJykjfjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228041; c=relaxed/simple;
	bh=8SljLriCQU/R9iZ5gWt9zSCnrJAdSlcr5Md1yQsHitk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0NNC18uaHApPrRDzPUP2L0nZAKec/jlyykUaQOBQhRxcLMbfnjgocHJyAUX1pl3yRpVKH0cV1h1xAuPlIpGfF3LulPMyNwkUyYISWEMOgF/ArJIMHlge9c00wMIWii0nDnIvs6Q/5W2Vf9N/yk9U3ewl6Zs1KuX+A2tx7xgV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmuiA2J2; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c20995d038so178660eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719228037; x=1719832837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiWe4k8FtBd5fLnyYS4pxEhg5OzBr8vUWEFs5mIbuS4=;
        b=HmuiA2J2rC+CpZ6U6KTdguUb92pH7DT52mE3U8EnDhUKPXpB49IFYd3c+oLszwXYBg
         w8X5wMXwZCjFsvwgS4z3BHXvgGPrjfk92jQCVTVqTkDE8+5MHThp4TI6Tj5KtrPPLzm8
         GsDWLqIlxIzdXvAWzRq0iDGDE+lV7FDMldHSy4pzBnBdq9b/b2u9wRsMb9BM//CDlhjX
         UQmVsAzr/NJHb1inZCmDFLg3d5o98EFVFVaLE+B50Z/WjDLdE7vsh8HKDIXL0qlGuPg0
         DFHWNSXElIibyfEhOT0gSMBg3br4W6qT9V2v4v6vFoH0AA6i/UtP0jqpBwTuCbX4rpU/
         frMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228037; x=1719832837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiWe4k8FtBd5fLnyYS4pxEhg5OzBr8vUWEFs5mIbuS4=;
        b=IWyDhO6gyi62ZqtuQnodPb6PXmptKKpQ7OH6sASEAXferScpAWsxL3fWe/QOv+Pnb4
         NCRBDBDKDEp+5B//RSH1IPu8E10SdXkumErFTTQdKZUnMxZ4DFepf8VXj256Jzld90xA
         bNjusVuZPyhiz07DQircuqZRfbMDcPcAZnnggn89Kb7MGuxwdfITZudpGIp5X/LE0gCo
         QXNAMY7RSdPNbNY8eUlXZfWCg2KxqKPOWIAy3SYNAzNmGDgHjhIKAiTSYqzhxoOwprI2
         fDOPY997GbrSFn963QRMGw80UIWTzgMV3QLYd6HPCIY7aMkoMazI2oxLGmjoC/vOcvEm
         rx1w==
X-Forwarded-Encrypted: i=1; AJvYcCVroRTUeBHtzTvMlf4wl3Vt01B8bLJHqqNsb7MxcnKx5BQ6p0u+V8ipmHrdP+UAAq/UzNqKWKbDjnSgLMwUK3RR/Kn6FROdduVUDZ+2
X-Gm-Message-State: AOJu0YwyoFpABQqpzmoGF/+hLez1fWW9AWjf0PXspvXyMlQ28E/tSHET
	qqLtOqmf4NomunL4UQOwnyW5XepOmTvPlIcA+Q4+UkARsO3m8qQo24zyh7I36HJVBiPU4at31GO
	LF4wWacrfx9BJd6wONiG917Xl1lArmqwAphVGlw==
X-Google-Smtp-Source: AGHT+IHfldjpB99ZpNwFcajstPYz4MdvmrWm26sCR24wJ27onowRiUicbCtcbFxhvjwoR18exO9DD0r6k4/LILVcIj4=
X-Received: by 2002:a05:6820:2b0d:b0:5c1:eee6:6ed5 with SMTP id
 006d021491bc7-5c1eee66f99mr3951941eaf.2.1719228037550; Mon, 24 Jun 2024
 04:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org> <20240617-usb-phy-gs101-v3-2-b66de9ae7424@linaro.org>
In-Reply-To: <20240617-usb-phy-gs101-v3-2-b66de9ae7424@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 24 Jun 2024 12:20:26 +0100
Message-ID: <CADrjBPpRCuQwLOG35mjAc==6mD4rgx2HzqLHgCA8fNGg79YOnw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] phy: exynos5-usbdrd: support isolating HS and SS
 ports independently
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Mon, 17 Jun 2024 at 17:45, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Some versions of this IP have been integrated using separate PMU power
> control registers for the HS and SS parts. One example is the Google
> Tensor gs101 SoC.
>
> Such SoCs can now set pmu_offset_usbdrd0_phy_ss in their
> exynos5_usbdrd_phy_drvdata for the SS phy to the appropriate value.
>
> The existing 'usbdrdphy' alias can not be used in this case because
> that is meant for determining the correct PMU offset if multiple
> distinct PHYs exist in the system (as opposed to one PHY with multiple
> isolators).
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>
and
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Tested using my Pixel 6 pro device. USB comes up and it is possible to
use adb from the host to the phone

regards,

Peter

[..]

