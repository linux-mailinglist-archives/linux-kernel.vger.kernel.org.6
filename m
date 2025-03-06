Return-Path: <linux-kernel+bounces-549019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856EBA54C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659D91898380
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6E20F083;
	Thu,  6 Mar 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Afl9wm+B"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27A20E33B;
	Thu,  6 Mar 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267798; cv=none; b=be37AEN2ZsoD7A0sGY+TepPUKjs7vloN3Q2FHQO/+ta5U6AwP7g+hXN8duJHg0KmHJI1iJK+GRPC7nejOh0x0762AnTJ4OgGHRN3KbcpUOZQexGIB+vxlmMQ+ze/64i07Huo9yYWz7Ahb8D2OApT2xdTunRsiNDZ9OcpqZcrK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267798; c=relaxed/simple;
	bh=ZqlvbwmjCHHW0riLi6URTpOFQ0T1GqXhnWE3enEVXVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViV9IyI9pSvfeeraeezB7ZSWY4+zYwvqH0B6yiM9faGSwahrcB1P1daQq0qJ23al/GbsEqmarqT6wMT75MDfto95JYpDkuHkvy8prU+By9YhcRmSpXN6yPCRd0FiA6CtI6y5pS0XcAYe7Dr/i19IhrFhPIYVr4P5gY9yI83i5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Afl9wm+B; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y1r0XL1092fmLSaUg6P9eZbIAeeU2xay/HqiLlb+zMY=; b=Afl9wm+B0ta8/YCf8e7GaHaAlb
	w3e+75j86lq+KQZK6gvVoTYKa9zUilVpMQx83DWou9X3zPv1zbGTRICX4BYKVzKwDR6PTLcuX9bXM
	ec7/6WJhxRqCGCVZNjqTNbGOYiZUkCAVQd/gyRR+c9ZtXbKQbcp1uIfK/KtpI2Wm8xtltEdPFSblC
	MrghlQaA2pKnYO6u5kV9U5iz8BXaYTQ8B3183E+yHppVu7odwKQZPUPfOg3upIrUZKbtviFnsDKSL
	tZk4uboZ/98MB0VuFk+UmW2/J8K0DT+S5MVF4yEiTfhg4/oXod9vf2YgIjbxmFEvN97Wond06OK9W
	QhFdvwQA==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqBIK-0003LI-U0; Thu, 06 Mar 2025 14:29:48 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu, 06 Mar 2025 14:29:48 +0100
Message-ID: <4856313.kQq0lBPeGt@diego>
In-Reply-To: <20250306131016.281290-2-amadeus@jmu.edu.cn>
References:
 <20250306131016.281290-1-amadeus@jmu.edu.cn>
 <20250306131016.281290-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Donnerstag, 6. M=C3=A4rz 2025, 14:10:16 MEZ schrieb Chukun Pan:
> Same as RK3568, RK3528 uses SCMI clk instead of ARMCLK.
> Add SCMI clk for CPU, GPU and RNG will also use it.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---

> @@ -110,6 +129,19 @@ gmac0_clk: clock-gmac50m {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	sram@10f000 {

That sram is part of the soc (and has an mmio-address), so I'd think
it should live inside the soc node?


Heiko



