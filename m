Return-Path: <linux-kernel+bounces-436202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DD9E826F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2991884996
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143B1547E3;
	Sat,  7 Dec 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Des9A9hR"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B614A0B9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609445; cv=none; b=qXP4mHAmvjGTPU8fXrIQPufDjjhjBY56O3K1kpHclNxVFrf+kpkn03WosGYL0LEI/FuRrzEU8famY1Jh/sbZrZqWIXKxVbg8MTYmaIuu3Au8mfOyJI4Krseiu6aZFgravIBLt1TSB+DhI++sPbas4teufO0nRHv9V4rVNxL1+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609445; c=relaxed/simple;
	bh=2yeHJBuvknf2hLBb9j5/HvmE+uUK/8GcZejF0YdVYK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrN0MeaqiLmFulrZkZxqDxMrKJ9THPRMOk8Ztl7KYM/uMen5Atw561tg8I1mo1qP5mfDTslAdUvgVWX94T3uaE7FFKc7P3l7tYTOwnQoyqtlihhkxKzXCEq3Fa4ENdtp9z/ag+pQvNsBLyGP4shS/Ae09H8nZUgJm/WJ1VbRY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Des9A9hR; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ea369fdb0cso2002849b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733609443; x=1734214243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJBGA6D5vNEtEB/ib66h+psHOFDDtr3mhYyS0Z6TU5g=;
        b=Des9A9hR3gOxmX7W3Ui7svdGAiytxqKy5j+LicvGHytfptaUS0vXd2uOX5kjMY/S9C
         rfI57AHvOXB+P7+wW8YSo8jPzYDXFfQrJ4bzt7HpkcYOF1LXte+3m5QsYAmaogg5eheb
         iOrUrWddvTfmveFH/2OKTzjHcIEKOudzLIrLU5ASoAKJsgoZG0gojKMscHbVyiDnKWO8
         +Ag6dRiQLaPKDYypl3qZfBnIS5+DmEraCtVOtxfwyTGa9n8i2mm2Lovti2pt5nu4Wsil
         G7LfqHoscGPlhrLsISsf1mTEdbv0IDSmRQHRTw6w5lypkyh3JoQCFi2BThFgibOYVw1M
         T5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609443; x=1734214243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJBGA6D5vNEtEB/ib66h+psHOFDDtr3mhYyS0Z6TU5g=;
        b=NfAICvCmawOCOxOm0Gw8mt/33vOWOeyR7DYLsO/BGpxpa1mWa6J+On80jdm6RSn2uw
         UnovCPvDdg5cXXoI2G/pPXK+2uwf0NUUfDfOi5tD5Reww98l7ONm2qVGG68kfYP4AHJO
         1KGaOPySVYeR5tmBWMx9Nkzju6ye8NbkOl/LTxeHH31pbhc2/uluDnl3slYwdYR+ZuxT
         f1dlPNuXcIwF0HMNl5IVQNyzqU/vWv/usfQuHJru/jzYbCtNTTJA//uvdNWgIKBVnrHj
         qf1rgUUaeQLGPtIW6Kr4ioChfn6ULberdsrOkaTajXQDxOj0VKSsYJrtZLd1G+XwSp9S
         Avrw==
X-Forwarded-Encrypted: i=1; AJvYcCUJhRZO+PIkJcG8yto7MjZv7GntDsJUL9rV0TLetm8zYBpNIAw9Vc3xzuMxCmQCsPCPcvPkZthPIokvtWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrq0rCcl/puRC2wj1Oq3HazPreQ5n/3xbjmqzQBxqXl1GjempJ
	lLwPhslGRHljjXy5oTcYumQNgTgQiMpQ0p/SGzpOcyCXJSykoXdCY1roFnTbkPxsj4eGim0Ybxg
	LrJ6bJaeILPi2gPdEMRjrwHdjc2Ax5O/wp5RfNQ==
X-Gm-Gg: ASbGncuoeN+aYLy3U3p1vxCL+q9y3+hSKfP6v9ARUCyU0LTTFDU6Ec1jFHsd99R01Y5
	6HrfECRgauM22Lq7UUZiy4mv5ITR9ZZ8=
X-Google-Smtp-Source: AGHT+IEzfEqpnzeYKIfkF5R8fv702t9MqnWDdRkAxs3VAzNsDFAxfBBCyID+B7CHmUcn1Ieg9oCtaHwIu5Jv/QeLWcA=
X-Received: by 2002:a05:6870:f78a:b0:296:e88f:8f56 with SMTP id
 586e51a60fabf-29f7389c4e1mr8234677fac.26.1733609442837; Sat, 07 Dec 2024
 14:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-gs101-phy-lanes-orientation-dts-v2-0-1412783a6b01@linaro.org>
 <20241203-gs101-phy-lanes-orientation-dts-v2-3-1412783a6b01@linaro.org>
In-Reply-To: <20241203-gs101-phy-lanes-orientation-dts-v2-3-1412783a6b01@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sat, 7 Dec 2024 22:10:32 +0000
Message-ID: <CADrjBPpOj3E72SPAB65Zrbct-ny=ynZxKx+21foJdQ9qkPzC7w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: exynos: gs101: allow stable USB phy
 Vbus detection
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 12:40, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> For the DWC3 core to reliably detect the connected phy's Vbus state, we
> need to disable phy suspend.
>
> Add
>     snps,dis_u2_susphy_quirk
>     snps,dis_u3_susphy_quirk
> to do that.
>
> While at it, also add
>     snps,has-lpm-erratum
> as this is set downstream which implies that the core was configured
> with LPM Erratum. We should do the same here.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Notes on testing:

Tested with a Pixel 6 device with 2 different USB hubs and also
directly into the laptop, plugging and unplugging from both ends of
the cable. With this set of snps quirks disconnect/reconnect always
seems to be robustly detected.

