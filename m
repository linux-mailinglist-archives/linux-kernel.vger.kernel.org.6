Return-Path: <linux-kernel+bounces-199739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9D28F9F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F2F1C24583
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8A13C80A;
	Mon,  3 Jun 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVozPV++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159213BAFA;
	Mon,  3 Jun 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450614; cv=none; b=MJzRnc4+maisnFZNWLzLsWQX0HhzQJFkhfIBetzgjlTzf6ifN/3zum+Q4p0E6fIo/S0p8+f/tLq53bGDrA+f25QsO2ctXq+C4XQ5lUp4jn+vW1H9FyFiExVs9JycGp81KP1hV+4e10to2qE1InuqJn0HFBis1tmJdu5gKyRTIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450614; c=relaxed/simple;
	bh=0TacpChjWF6BZ+mwmy7iO27gmbgjpFbCq69+FboeDeU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=h1Oxdd5ypppIrU2KhSmyvO1kGJ4lBvubF6/dDY4PV9P1Z9o3oe8geqPwVNGcRissjEtFhWqGLDKh0VpHROCZliStY5CXkFoI2QVtSJ5OPPGTOSCH3Va/1EWk6j21Lil617FL/SG2gQOnnd1/Jj7NkTRxPQXkJKFJX7ZHnH7XR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVozPV++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC78C2BD10;
	Mon,  3 Jun 2024 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717450614;
	bh=0TacpChjWF6BZ+mwmy7iO27gmbgjpFbCq69+FboeDeU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MVozPV++vnGOvooQjEWhNJ+/rWZiL2MiN1OXLujIYp80JiyZwaGwEOLRgyL6Yzezf
	 P5ly0bbePi2wWKvK/SVlhX1WsqG0awWZ99EMpwH30a6WLJArmpgjp//DZ1asJMEt3p
	 RyeU08K2ie+UbyC0d1FFERIsz/0NG8XRaE5fTysK77iPOprVvVbyRbwTdL5QSi76A+
	 H18ipg2ty6FqmEgQ3hTAgCFQcKfwcFQCgUU73bngsAzi9NaPUHwFQR8ICQBiN/92OW
	 JM1TTCKD0X9YF1urWtKB23swqBN6lMyymHlIzbVvryPNXwo6c4qFjIu9L804SKgfUU
	 d+m6TzWEKhF4g==
Message-ID: <0193c984c16103e4fb517c5791642673.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240529131310.260954-3-gabriel.fernandez@foss.st.com>
References: <20240529131310.260954-1-gabriel.fernandez@foss.st.com> <20240529131310.260954-3-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v2 2/3] clk: stm32mp25: add security clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.or6g>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>
Date: Mon, 03 Jun 2024 14:36:52 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-05-29 06:13:09)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Add ck_icn_p_iwdg1, ck_icn_p_pka, ck_icn_p_rng, ck_icn_p_saes,
> ck_icn_p_serc clocks.
> They could be configured for non secured world.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

