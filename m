Return-Path: <linux-kernel+bounces-549927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952BA558BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C2E189959C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404C27603F;
	Thu,  6 Mar 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8yXhYxb"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309825A2B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296313; cv=none; b=jSFywT/GK4LmvYn066gpKqIc6HrLP9EumAByi6bV8+5vXYl0am/DvaNuYGOh2A6Qsu8CTd+LqqRGTdosgI7wLf98GN8ExluJvaxdEpgOeRdmHhYQKiIcgbG+PI/+51Ie42qW7ylH8d2amy44MTxcPYNrbAHWaRFjayKUpX8D64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296313; c=relaxed/simple;
	bh=6nLUeGZBsOZaxX7lD0yAqrwnU/9EkCCEKqX2KbebjDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCC5BB0g0ZacenQDL4TpZ0jkMmiqvTdNzIIUQpWL6no88wGuuJW/yB6A2n5yN1feyUIKPRwZk6WWa6MVh0YAcaDNTZlh0Cw1W0vWx4eRAj94UsrsYe2iJoq51TxzS6IKx8PT6saQ8uN5qV805Z0O6KKKBLVaK+PvQOxNfgP1inY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8yXhYxb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso220706866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741296310; x=1741901110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6nLUeGZBsOZaxX7lD0yAqrwnU/9EkCCEKqX2KbebjDY=;
        b=y8yXhYxbNasZPZMGQjweQq91JrwF0qwIqKnhDD00CsLW1+uxQB96aHu+/RgxhmQSyY
         ocaQgUQameDnuXFZnKF53BOYjaCdlipwjqg0e4znaayu/EBBoiS4qIYFN0Kz+bfvuPAz
         rlyEmStL4Fr0rQnC7O+dx3Jzqfcvs3t23rGiqtMrtKpJs5Srhr7RkcgkXI6GsbHZjyTN
         5TV6gNy3GffpoEtc7HPbxSCUxOkgp5Y/PXiqB4pvr81Jwlcl/4ThuqsTv8Cz6c5JmbHA
         xPGVmi+wUAV8Om/qWkYPC4VQJBgMRtrYgSPSddxu1KfJ5IgQbEOlnGGIZPr69EdZPBLi
         ST9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741296310; x=1741901110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nLUeGZBsOZaxX7lD0yAqrwnU/9EkCCEKqX2KbebjDY=;
        b=gTWhkCQgdywHG9A9BAb7AedUP/oBXma/owfs5qVPkAwVMjosGOEgP6DuhVu7Jdwuqw
         y6npMbfJhISezJv2TMt0NRRD9Bz2WsViQ0EyTDQhSgUxedO9XubecjFHs6N2o5BQKxEI
         hSJe5hSRQcpyV/1S3HMig55ie19g6YmOhqKjwalW+tYETUIur1GwVvjeUqCQDFtbwD8d
         Vlndvm9uQMAeY2OP47cngakje/qwksQ7URCMnigUw2lPgDWeQ7O+yCCd8G0FYqPsJQJo
         2r4kL1y399C/BuMc3sPxr+g+LbZXcJ2UeaF7WmLmhMXmizW2dFN29v/vyvdJehSvsDtq
         qt+A==
X-Forwarded-Encrypted: i=1; AJvYcCUrbx+MeESuTwusML2Z1o9zrO0nm+0HlqdVnOK/te3tvf+QjjFYbA0XaCCZ7aknWHNVKdiDpy8XAXwVq/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8he/ZchdY2vKusFZNN7SSxIyGoR89bGOVqQAaDcuyrABSWFs
	OTIcPVBsL8FI9pyRXCWhmPk5REk/KTKA2bI4ty3pXn6dSwZ8knXUXhwU7i2qL1g=
X-Gm-Gg: ASbGncv704nnCxyS8KlXr2VEi1BxUdKgg56+nle21ZVnCaeFyhaZE0rDGyHXuoFS831
	aSi9/IU/ksx2wNUJvG2jr6uMYobTq4uXr6Bw5QIplxFN8oMuSZDmUyRMa+5mTs0DJzZWJrzlEVh
	yCpiAAhOlRgeLlRZ/N3bodP4hO2AxCB71/7632cqVYwDh78YBpp3CbpJ/pZXH9Uo57sX3G1MCsJ
	VMkZ5SvTBG+IcdnUpjTQImsuqjkpTe9F/e5WA4ALV44hPHKC0HaWyNJUYy+RGSUtHBA+Nz5bYhI
	qhi/ZFsu/xY4wNBQW9FW5igPxbVjTZUHLdutSZra4/a/44g=
X-Google-Smtp-Source: AGHT+IEfkrY7UVJaq0/ND9NEi5g0hc9ml44W1eaBzgh92FLmrsjRrsJKvCEmtLb9GKZY9TgjXouEaw==
X-Received: by 2002:a17:907:3f9b:b0:ac1:ddaa:2c11 with SMTP id a640c23a62f3a-ac25210ff7emr88036066b.0.1741296310064;
        Thu, 06 Mar 2025 13:25:10 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d7da1sm156779066b.174.2025.03.06.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:25:09 -0800 (PST)
Message-ID: <2c1cab545cd3b57a2155df2e87ad9830b2b94ab1.camel@linaro.org>
Subject: Re: [PATCH v3 3/4] pinctrl: samsung: add gs101 specific eint
 suspend/resume callbacks
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, 	kernel-team@android.com,
 jaewon02.kim@samsung.com, stable@vger.kernel.org
Date: Thu, 06 Mar 2025 21:25:08 +0000
In-Reply-To: <20250306-pinctrl-fltcon-suspend-v3-3-f9ab4ff6a24e@linaro.org>
References: <20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org>
	 <20250306-pinctrl-fltcon-suspend-v3-3-f9ab4ff6a24e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 20:42 +0000, Peter Griffin wrote:
> gs101 differs to other SoCs in that fltcon1 register doesn't
> always exist. Additionally the offset of fltcon0 is not fixed
> and needs to use the newly added eint_fltcon_offset variable.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configurati=
on")
> Cc: stable@vger.kernel.org
> ---
> Changes since v2:
> * make it clear exynos_set_wakeup(bank) is conditional on bank type (Andr=
e)
> * align style where the '+' is placed (Andre)
> * remove unnecessary braces (Andre)
> ---
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 24 ++++-----
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 70 ++++++++++++++++++++++++++
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +
> =C2=A03 files changed, 84 insertions(+), 12 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


