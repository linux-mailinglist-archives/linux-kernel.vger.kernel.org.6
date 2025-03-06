Return-Path: <linux-kernel+bounces-549913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE24A55885
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6281897480
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08131207DED;
	Thu,  6 Mar 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsIj3VKe"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0F19DF5B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295726; cv=none; b=bZJSmfsoeBvY5khOySaJoqZtP/s3Mtlppzj13W2X8i0Q0VAm+zulgmKPXQGzkH+dAP4zaAR7j1TNTjNsuSmGuBs0ezyJBM2pW2Q6nBSGbeXzxEwsvk2e8HQZT0oZE9T6ys//Cgim/ikFFnlE5pp9Y6OBra4dEHy6t+HF+Il3IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295726; c=relaxed/simple;
	bh=vEXvflwEV04efj6bnvhXaeOA0qHCeEgvrAzgI3xl7wA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OD/LzzBSUoOMZ7IUOKFY0yRxUlhilUynjdOZ8O/fjJL8605VAJEyh8qaZS06dLEgpiY7dv5zhX1q0rFnIajvYAZWnmEEaw4daV2wXZuyKP93L9zHib3JesxFQrWZ4Z9naTCwNDXi2ZM114anPgv+FcmYO7gFGolhZeIbLt0UHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DsIj3VKe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf518748cbso208784966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741295722; x=1741900522; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vEXvflwEV04efj6bnvhXaeOA0qHCeEgvrAzgI3xl7wA=;
        b=DsIj3VKeLHdEyUqNenk75PVHmr8R3bDFxHIWKbBzLV/+0mAd0/srz+KYSKWiz2/Umr
         8aP90On4uip1RVIyis5A7XDTvaQvSkbzaEsFTUcQIQiE+0wgi7zrAxcjbtOn+PDpwmYD
         1isxmiCG8AYjQBHJJBIfU4RTk4NnkTmz8bCK3tljJsgPH84CH1mTFV2ISaQpXFap0+QO
         5/RnMIg6CXAXtzsr2Perikh4yO9hvO3xyLEsOWR4AvnvoLThDXGaazwefn440UyiZhep
         +SRm5p59fyIZ5GLedeoTbF8R54phMghDPDnT/LDfVq6z6t56E2BjqzgpNmjyg+tijrfI
         M5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741295722; x=1741900522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEXvflwEV04efj6bnvhXaeOA0qHCeEgvrAzgI3xl7wA=;
        b=WmeUf8bRonAq1iRq9QABNdomvZ28RJzIvick75JYQu1tWEyAEY8N3evl0MElRuYd2g
         XBH62AWNCepKs5y9iX9TWvPpytgd1JyWkP9SWuhPTnq1N83lVcreRDnV+KUTQrtbPeQx
         3e9SRJLz95qYjJB7CRhpOnMLkIZHBvgQilmhOYzbONqk1PHsJ63K4+TajhixQkRgkGSD
         jUUfVoQ4UdI8CL5FE+xCEX4KSJgL4hOX02NLJW25cpm02mfu/TvK5GzLAbkM6fRkg1M7
         7pYT8FtbzKk2hRZwt7iXqLugPh8ef7J3BV1gZG8/I2eiu9JiMaCElaP6g051ZBDUg9OG
         iwsw==
X-Forwarded-Encrypted: i=1; AJvYcCV1lqh5mBZ1ThkFjrN5tBhZDPDWzzLa5H4z1iqKTyK54dMBi+N+6XDoMC33D8n6U8zpYTcgLHNsNG5/jcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKY2LhK1Rdv1j0crZBA1RJvGfuYHPUWCTitQ5ugxKl7PnlIid
	9I7Wi0RdqMo9SO1HQAvPf9fY8sZDHLDgo0mlBw4xqxZKx/A632Sb9YW8gMYw+y0+yh3N9YlNUsR
	D+Go88A==
X-Gm-Gg: ASbGncttV88w37qJDwsaZrxMHRXjDYe/YfIRo8qqh0SKn2JFs2iFUjRWFO9+F/KUiR2
	GlCEN+/q1rAIHPQAKF90jiXHx8vKFO7GF9nZE+Hc4TY27GIcZXBUMdxA4RAXs5s3zs27W8+VSVr
	YbRCnfX1jyl1QpRZyznOVA/pLgysFFWVPCVssvndosqVnUckSA4sWKD6lS7wG3tqxfVnLciOnqt
	3yGqrFdy9VcEAw87LPoql8rIG1XGmKiWanV27ohyedWO1grl0p3oIaKDmqc6Ot/BxzmGTzXeoOx
	Hzn9pOxrQ5WbCYakreM5ve81M0T0McWGIAOLJc4jvGVrIXU=
X-Google-Smtp-Source: AGHT+IE+LHNfvlp8dFOhg8/hGQEzMaTOw9w3ZnSxV/FqKSm/TD4PkI2UTRYu6TY3+BOkP+WRqnVYGg==
X-Received: by 2002:a17:907:9490:b0:ac1:ebfe:fd90 with SMTP id a640c23a62f3a-ac2525980femr71342066b.1.1741295721652;
        Thu, 06 Mar 2025 13:15:21 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239887693sm152427066b.126.2025.03.06.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:15:21 -0800 (PST)
Message-ID: <1418fde488646160a1be14b2153e409488f3d861.camel@linaro.org>
Subject: Re: [PATCH v3 2/4] pinctrl: samsung: add dedicated SoC eint
 suspend/resume callbacks
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, 	kernel-team@android.com,
 jaewon02.kim@samsung.com
Date: Thu, 06 Mar 2025 21:15:19 +0000
In-Reply-To: <20250306-pinctrl-fltcon-suspend-v3-2-f9ab4ff6a24e@linaro.org>
References: <20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org>
	 <20250306-pinctrl-fltcon-suspend-v3-2-f9ab4ff6a24e@linaro.org>
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
> gs101 needs it's own suspend/resume callbacks to use the newly
> added eint_fltcon_offset for saving & restoring fltcon0 & fltcon1
> registers. It also differs to previous SoCs in that fltcon1
> register doesn't always exist for each bank.
>=20
> exynosautov920 also has dedicated logic for using eint_con_offset
> and eint_mask_offset for saving & restoring it's registers.
>=20
> Refactor the existing platform specific suspend/resume callback
> so that each SoC variant has their own callback containing the
> SoC specific logic.
>=20
> Additionally we now call drvdata->suspend() & drvdata->resume()
> from within the loop that iterates the banks in
> samsung_pinctrl_suspend() and samsung_pinctrl_resume().
>=20
> This simplifies the logic, and allows us to remove the
> clk_enable() and clk_disable() from the callbacks.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> Changes since v2:
> * Remove useless init (Andre)
> * make it clear set_wakeup is conditional on bank->eint_type (Andre)
>=20
> Changes since v1:
> * Split code refactor & gs101 parts into separate patches (Andre)
> ---
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |=C2=A0 28 ++--
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 201 ++++++++++---------------
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0drivers/pinctrl/samsung/pinctrl-samsung.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 11 +-
> =C2=A0drivers/pinctrl/samsung/pinctrl-samsung.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A05 files changed, 109 insertions(+), 145 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>



