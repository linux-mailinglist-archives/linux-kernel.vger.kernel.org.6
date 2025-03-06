Return-Path: <linux-kernel+bounces-549117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C8A54DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2534C16E204
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD016D9AA;
	Thu,  6 Mar 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VbHNERiP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A114F9FF;
	Thu,  6 Mar 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271147; cv=none; b=oFQoZs7yfP+ejotMdUFenI4Bad8lPlXiUZ0ZL+W7uPK4Iy8baL1T7sScsDfH+Qf9kFCgQcTNaJlT/SiMnk84W8EAHhBSv9fIJzLwtz5yD23K5Q3R9WkChkp7GHdc/7UX5I1ZEBHvn3oFfReAAM1VWmKp1Bz6mdsoIrNjnFXS4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271147; c=relaxed/simple;
	bh=n5aD5c3lPAMGKpNg0pZzLgDxoQS/0A88tfAf7d3Ga4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5rCW/S7xHP54m0hWmzhG5RyJ9TIFmb6t80Ow4VjhsMHTAJII8wISMN6UoX6zkhxCYYNLcF81qMHC3tSSSJVb4kmroGg9e1oHwIHuj6met00SeTPi4zCaTcjFSPQeezIrFvvul6NBW2TN3WkSdGa4tSULthXGs202LahqbTgkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VbHNERiP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n5aD5c3lPAMGKpNg0pZzLgDxoQS/0A88tfAf7d3Ga4w=; b=VbHNERiPVO6UZVnSVLhH/tOQiz
	HLsRkehic5Kdr8Pkuh5l32tXLLGTr0jhQtsWV1LR8rF+68sFVabAncu0fMP4PLN9WUaCt3YLNwSMJ
	8ni205h1cSu/7MwtOXW8pGSzGwa/E2cY+umKUZzBEgZrrm9kaHOQvmYd0NkSv1gwi61L6K60D0Ql5
	GYNOi8ZtbUVJZzAGpFHczQQewDlR0l+5tjK2v7YgoHuwMXiDg7uhwa7VqSh0JiTcJTycvLQEYHOaF
	GyylM3xLjEWC8L2ZNMf5X9PyGDM15ntLOcfiFxAXCm52uujTsq6dxcADQIQ1zO+4odHPrgRdWRHWv
	dG7NbngA==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqCAL-0003oY-Bc; Thu, 06 Mar 2025 15:25:37 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: krzk@kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Cc: amadeus@jmu.edu.cn, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu, 06 Mar 2025 15:25:36 +0100
Message-ID: <24848438.6Emhk5qWAg@diego>
In-Reply-To: <20250306142008.389243-1-amadeus@jmu.edu.cn>
References:
 <10115c0f-4a7f-460a-a0bd-0c86d1e7d3b6@kernel.org>
 <20250306142008.389243-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 6. M=C3=A4rz 2025, 15:20:08 MEZ schrieb Chukun Pan:
> Hi,
>=20
> >> Any suggestions would be greatly appreciated.
> > Where is the SRAM located? Inside the SoC or is it carved out external
> > ROM/RAM?
>=20
> It is located in the SoC.
> "Embedded Memory" Area:
> BootROM | PMU_SRAM (8KB) | SYSTEM_SRAM (64KB) | OTP

are you really sure about that?

Looking at Jonas' recent rk3528 u-boot series [0]
0x0 _to_ 0xfc000000 is the SDRAM memory area
so 0x10f000 is a carveout of the main sdram.


Heiko


[0] https://lists.denx.de/pipermail/u-boot/2025-January/578393.html



