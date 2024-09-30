Return-Path: <linux-kernel+bounces-343816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D427989FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AD0B24D12
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590418D646;
	Mon, 30 Sep 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2Gmr+wCQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9418C939
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693756; cv=none; b=EpbcgrZ3l2YPU3nKdg4tGVHHiCztE0PeInaj6G9NDgmg0pZ7C8dBbF7p7nJXK/F/aiLk1Kfzk6b6KSrH1gAjVloWHjeaiQ5GieKJ3O4iyQnB7AcWdfqnq0Ecu0s+Rh2AiebTrwVJXymKGYyunP0osoQQH8obWvNPCflS00koyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693756; c=relaxed/simple;
	bh=qb2dfIMQ0eg/y/UbDkzM/PZm4HNmvCystBZKgKZD1kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hlv+bDY6Q1UnycboKiAqNyj+Nb4h69GbX2P2MgbTTyPw4jK5tMMs9XtMOHRR7Ls49euBQpZFTsNkt00VSwLk232i0V+GHEgQzIpJ5uPoJrc2K1/z42BkLOp518IxxtUNR1BxNV4Dpgxga7pM9NCVnNwc3IYIYIZxZSUSPdAHlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2Gmr+wCQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HjXijcub5KRyYpYBDj5VbCSmtbuXJeTxEKrLzUy55Ds=; b=2Gmr+wCQhEKRfyZzjxJ//K330A
	dLhA0g5OCTk0Yie/JMUdEiC4CPBJvLUzqvGp+cTkg3eU3S1igWPixiELOHn0WjBGfUZKaqa9GVk0i
	sSvRiAISOKdVBN06irD6HZhY6IsrHtE8wQ9+sxa0p3H9+NIB8jey/Rveq2rxxdX21iuJoSii2S998
	tpb3fxdNz1cqEHCEGh3eYKE3AoiyZ7w3UCfaGgCbf3dWRxoqvqwKnCGFOYS6+L8HuTxhfSz6CUEiC
	7HAIfSEradOp+MC1DsC7OfrixPp9me3Ei6R+3N4PqzwTDrA1IQ3nyqVY2+xlDFSlQTQ6YBPR4xmBE
	siXM85qw==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4H-0004Xd-0K; Mon, 30 Sep 2024 12:55:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
	quentin.schulz@cherry.de
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
Date: Mon, 30 Sep 2024 12:55:41 +0200
Message-ID: <172769365129.1880381.55263225152675030.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926132028.21910-1-jakob.unterwurzacher@cherry.de>
References: <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de> <20240926132028.21910-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 15:20:30 +0200, Jakob Unterwurzacher wrote:
> Ringneck v1.4 can contain (placement option) an on-board ATtiny
> microcontroller instead of an STM32. In normal operation, this
> is transparent to the software, as both microcontrollers emulate
> the same ICs (amc6821 and isl1208).
> 
> For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
> used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
> we are running on an older Ringneck revision, SWITCH_REG1 is not connected
> and has no effect.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
      commit: 1871e6f7c5e606b97708af50a7fec83a904a761b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

