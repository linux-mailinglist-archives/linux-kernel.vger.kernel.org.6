Return-Path: <linux-kernel+bounces-343822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C7989FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAFC1F239F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9418FC65;
	Mon, 30 Sep 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ekwvj0OL"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82D18D64B;
	Mon, 30 Sep 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693770; cv=none; b=UeN03/4Oths6ESI8xn7YJFmISdX807Ob+wcbSxQUJaT2Z9RPhmj3zcgxyM8f6ClCvLt0mwQdWtrRaM99VWkrw9Wv+1lSKnUjMTnigFpMG6hCMGT8AKklDwEY0vHL23L3Hfu3dHugwv2bneVI/6u9YRtt2bL6zh10xPT6QwE80Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693770; c=relaxed/simple;
	bh=qrNS5+9Y9bAbJ8B6oBxSogGci4Gcon2QBypjlk/CqZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jR4W/8xrNk+tXUTz6xTBcIlVqsUAVEg3fszwyiThuAcLFAliPrEEjqwj9PU//rg+UtWU98dSL7GgA7At9rdaCGbiuj/4X4xxAafEnJqx6TNQD5cVunBfwwg4Ght7uRMAkuqPDQEpepz0QmBZCDIOleKT/gnUp0a8N8AJAHUEtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ekwvj0OL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NtLnEvnvmxA2Hw+YLR311xgnBqdt57NsrhOOUbVmrJo=; b=Ekwvj0OLBkNW60L7kWUgdEFY6m
	ckTAo/8f/guzfap7F49YoAprGCo2YTD3dfWfhFaHpy3rxxOSIiG/dLLRcOHr0aIbcSGYBnqUg3VSF
	paldoxeP7CsCdjJwlb/wzulMgxbG7ItH2f/k7zuXzFPB/uHQR3kPhaaYkOU2cQWwIzPAHw3j4yDyG
	AUTS1rkdh3BCvjMA/aZkwJuuzsTTOBfEkh0STy0C2lAicjK1uFwUWaZk9hPLjubiQcw+GVvU6u+5C
	d9utiHcBe0uG/3rdmCs+9PcX7lVhn0gG+n9DGy74d/vCatVzl0lBZeCIVU5bhC+U94qeF5x6ljNnM
	uRl0+CHg==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4B-0004Xd-OQ; Mon, 30 Sep 2024 12:55:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Alex Zhao <zzc@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Jing Luo <jing@jing.rocks>,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Joshua Riek <jjriek@verizon.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Sam Edwards <CFSworks@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: (subset) [PATCH 0/5] Turing RK1 SoM DT updates
Date: Mon, 30 Sep 2024 12:55:32 +0200
Message-ID: <172769365136.1880381.2087468618693375702.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912025034.180233-1-CFSworks@gmail.com>
References: <20240912025034.180233-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 19:50:29 -0700, Sam Edwards wrote:
> It's been a little under a year since support for the Turing RK1 RK3588-based
> SoM board, was introduced upstream. Since then, the driver developers have had
> great successes in further RK3588 enablement, achieving such enhancements as:
> - Stable thermal ADC support
> - USBDP PHY support
> - Panthor: a driver for the Mali-G610 GPU found in RK3588
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: rockchip: Split up RK3588's PCIe pinctrls
      commit: 4294e32111781b3de4d73b944cbd1bc1662a9a7a
[2/5] arm64: dts: rockchip: Fix Turing RK1 PCIe3 hang
      commit: ed1b30c33bb97abea9de4f749a890f5c88183d71
[3/5] arm64: dts: rockchip: Enable automatic fan control on Turing RK1
      commit: 604c164317ac93feae4b06bceac5bdb0be3bf96f
[5/5] arm64: dts: rockchip: Enable GPU on Turing RK1
      commit: f136ce5d07cbd91c8eadc407ddf1ad00dc1c3cec

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

