Return-Path: <linux-kernel+bounces-279634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5694BFCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05931283E32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001618E76D;
	Thu,  8 Aug 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYwL99EA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F718EFD0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128117; cv=none; b=f2Hj7+Axx2YT8Fa5WrtzB0Fx7Jg0YIqYHMkFb7SPZIjeTPQUZff6tISHlGpaVcvci0p78wHl5KDeYIntr4OSzGFwXFJdTV8xz5mDcGv0tTpsszRrlSTEODHsUL17mLDZMHp4uPSf27BE4NisBFsxSMlI30o0BqWG3NBGQbTSl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128117; c=relaxed/simple;
	bh=3Zm++0EiwaZDCPUMCRwmX3AigDh0NbUA1FXFLoV1300=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ5qJSZdw6XPnuNELW4k2USVQ9suGtiNqFIROsYeNXNrZ/s2UvHMKEwLIsZvsDv7QCX9cMKdmszkMsnrX7SXxTb6+K3Lz1EEOPgjth1pc9pbwlpU4DHzIXnsciiMB9p49zV4/8TaFTyHfgH1fqmRW6iamw3DlXhbwN92ZE7Ynns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYwL99EA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42809d6e719so7838085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723128114; x=1723732914; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Zm++0EiwaZDCPUMCRwmX3AigDh0NbUA1FXFLoV1300=;
        b=lYwL99EAAlSYJnvP2D748Ayi2IZj5Ev4RKAt95IkQap7RHSglGBlb3BKUTGBIV2fWe
         lp1BiaXRM2nPtSGeVC2JL3KkHHEqvGEYRNq29P5uDz+kbC2galb3PURJDD6uP8OAgGF8
         gGzqFOdcECZnaJs+65ltyhI3fnfM7+y/cPTbt0VXH3shZxkIx5SvXHgZcZx5NQ4oJqyu
         /FUpy6BomBWXVy7bZrku9BbzdBAvaoO0rH6uB5ogLOg7g3KsXzL/EkJkI+e7D2lpmZNS
         RGk655biGEdd6RVF6rhbnEJ+n5hBXg0hxytTJDremgjtzsSrxN87YNdRHS4Y2RVifcmH
         LYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128114; x=1723732914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Zm++0EiwaZDCPUMCRwmX3AigDh0NbUA1FXFLoV1300=;
        b=YpSbO4tNMKbRGEEpzbY9hV1Ed+eGoUViU5ci8oY9q658u+4gi4YcsdSoc+bMVg2sCw
         SSxLqRvHAoQuQNqINMVcxQRPeWflOHq+ABm2PY7hmvMPp8LTaU5wVi8qm97VoS1lnoyb
         buRp60iEdc6DLgWuXmxW3ZYhKD3/o21zJKpsZH1D6ZTHLcEvSypRcmhNoN3WIuTZQt3j
         EAHxz0lt2anIvddlTJppHoox9ASVKVqeCNFCh7FJFBHNUevnP0N26r/ShjRLVoBI4CN6
         T+E+dJ3lQ/ZpW5bY8n/EDoLX1LMzZr/A1zDEiY91NSwnnMjJDI0+B3OtSgCkhv40+0XO
         KmnA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Bsuxvt8DCqgyFAC64i00iefDJpmMV46p+kHyv4Wbp0qAzlujZ4SSAM+6h70yGZUODop0iBA9Ld20fGQafNtXvvEkdOe/fPKl4/fq
X-Gm-Message-State: AOJu0YxW0gzWyrsofg48dTcsqLPeJR4UVMAyulJkyHu4My6Lf6bckwGs
	DqcB9bF16XbjQFEefa1Jm3Rd5RAsfsTHBXheX/aKykH8iZKK8L2het2l1Gz/SF8=
X-Google-Smtp-Source: AGHT+IFXHGeeJUFdxaEWDM0TtP4N4O/AiT5tOuX2HrCQW4T6X/PQQ9IxC6Nf6q2GswA9UY7T4LQ/ng==
X-Received: by 2002:adf:f250:0:b0:368:57dd:3822 with SMTP id ffacd0b85a97d-36d27574952mr1574108f8f.37.1723128113815;
        Thu, 08 Aug 2024 07:41:53 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716caadsm2103076f8f.39.2024.08.08.07.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:41:53 -0700 (PDT)
Message-ID: <0fbc53b1c9e7b27d1363495b6fe3c8eb64efbb8e.camel@linaro.org>
Subject: Re: [PATCH v5 01/20] clk: bump stdout clock usage for earlycon
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Peter Griffin <peter.griffin@linaro.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar
 <alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>,  Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev
Date: Thu, 08 Aug 2024 15:41:52 +0100
In-Reply-To: <20240808-gs101-non-essential-clocks-2-v5-1-11cffef0634e@linaro.org>
References: 
	<20240808-gs101-non-essential-clocks-2-v5-0-11cffef0634e@linaro.org>
	 <20240808-gs101-non-essential-clocks-2-v5-1-11cffef0634e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 15:11 +0100, Andr=C3=A9 Draszik wrote:
> On some platforms, earlycon depends on the bootloader setup stdout
> clocks being retained. In some cases stdout UART clocks (or their
> parents) can get disabled during loading of other drivers (e.g. i2c)
> causing earlycon to stop to work sometime into the boot, halting the
> whole system.
>=20
> Since there are at least two platforms where that is the case, i.MX and
> the Exynos-derivative gs101, this patch adds some logic to the clk core
> to detect these clocks if earlycon is enabled, to bump their usage
> count as part of of_clk_add_hw_provider() and of_clk_add_provider(),
> and to release them again at the end of init.
>=20
> This way code duplication in affected platforms can be avoided.
>=20
> The general idea is based on similar code in the i.MX clock driver, but
> this here is a bit more generic as in general (e.g. on gs101) clocks
> can come from various different clock units (driver instances) and
> therefore it can be necessary to run this code multiple times until all
> required stdout clocks have probed.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> =C2=A0drivers/clk/clk.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 129 ++++++++++++++++++++++++++++++++=
++++++++
> =C2=A0drivers/clk/samsung/clk-gs101.c |=C2=A0=C2=A0 1 +

I shall send a v6 with the modification to clk-gs101.c dropped. This was le=
ft
by accident while moving some of the code :-(


Cheers,
Andre'



