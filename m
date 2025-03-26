Return-Path: <linux-kernel+bounces-576594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C168A7118E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D48188EF53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99919DF9A;
	Wed, 26 Mar 2025 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIxxlW39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B8919ABD8;
	Wed, 26 Mar 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974917; cv=none; b=mOpVZItTgQJsYddNJUu8t0T5jOkefKzPFn5Q2Ui0k8l9aFL44XEKgsJAisaoz6wNF+IbPUAS1ZaJ1szVZAR4gZzVyTxUnNKaVG5UmXPwVVosUL9A9VI/+IL/rOipE8PZcZIXl82N5AcmyIl5Dnb3UEk4zvuRzokMvxS+laL22io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974917; c=relaxed/simple;
	bh=rKOd4j1t74rlaXbctW4uta67o0YN3LITaSJsnrWbc38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW0UmPrYhp83YEcDUdcj9zcUmX9b7CqF+ynPFtLhCHVKuOiidSa5Cejgiggxs/gLmVr6OuvAxGEYhLSX73zom1WGN0oq1UNGEG8G8sOLPwDMKPeS/lV96LWKgw8krMwcJv5IyPlBVqA/i1kFySCvm+HiDCaUvZ8CySFBq2XrCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIxxlW39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B77C4CEE2;
	Wed, 26 Mar 2025 07:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742974916;
	bh=rKOd4j1t74rlaXbctW4uta67o0YN3LITaSJsnrWbc38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIxxlW39PQQqRFZ4v6Bj1eF/al7IN+zt+cDy8kyspl19eOj5XLtOWj7htTrZvJi7N
	 aE/lZxGA5EszkpdfxtD7k11lkvQr0g1/+J5jyoSLYKE0SxCLAOgIqXCMc7PrGMHnyB
	 yt8cwzZlBn5XrPmDoDGZCsZyNlEMWIc4778LGMVRPvPvxSe0jFUTZbqNgor+n4RRMB
	 fSnHnc767b/nUtVW34ZGg6ZuXCh51oo0Zh/154dZ4KqAcKearMCt2mngjjhBSDBT/q
	 1wnNxzRgObQErJrhcEo9fAXP7ViDzhvuBamqptBTFLN1m9/eaXt1Ncmd1td6FUaKmC
	 r48TymtjCPb8A==
Date: Wed, 26 Mar 2025 08:41:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] ARM: dts: stm32: add initial support for
 stm32mp157-ultra-fly-sbc board
Message-ID: <20250326-lumpy-spry-alpaca-ce087c@krzk-bin>
References: <20250325110409.2323611-1-goran.radni@gmail.com>
 <20250325110409.2323611-4-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250325110409.2323611-4-goran.radni@gmail.com>

On Tue, Mar 25, 2025 at 12:04:07PM +0100, Goran Ra=C4=91enovi=C4=87 wrote:
> From: Goran Ra=C4=91enovi=C4=87 <gradenovic@ultratronik.de>
>=20
> Add support for Ultratronik's stm32mp157c fly board. This board embeds
> a STM32MP157c SOC and 1GB of DDR3. Several connections are available on
> this boards: 2*USB2.0, 1*USB2.0 MiniUSB, Debug UART, 1*UART, 1*USART,
> SDcard, RJ45, ...
>=20
> This patch enables basic support for a kernel boot - SD-card or eMMC.
>=20
> Signed-off-by: Goran Ra=C4=91enovi=C4=87 <goran.radni@gmail.com>

All patches seem to have same issue....

Best regards,
Krzysztof


