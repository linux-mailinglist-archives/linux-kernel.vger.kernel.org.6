Return-Path: <linux-kernel+bounces-343817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6D989FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE5285DED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CBA18DF75;
	Mon, 30 Sep 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1jAN3Qak"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA018CBF7;
	Mon, 30 Sep 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693757; cv=none; b=no4nylbSXG71ZZeelB3THR+kCmwEIW96gssjml6wFQDwL3UKJggVt8AtiQoTXOBuK/h2B20+m8lkN6Wj82A9T+XkROMBFTUgQmzFZQQjRe+1qdZaR09/KsJquab7ezzhr+niOgWKd5YXjfmWfecUYz5R1DFpVWzkfRtfC1qAwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693757; c=relaxed/simple;
	bh=LK7h8MrXhiVajwZzD3fSPZ5pJuwfBtGqD7u8b4Is90U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9nhCoZpGiXmrRg+C9xLy6X3FPEIrAHzZ7E9d/40liCTm4J6jCa/S/yFVR3WZERjz9e3fSoR8MbVK2pls1A8PDvZQs9OAcfG/3RztI4V0c6ufdiaM0sJVKl4tOQCwV85V1lJVAfTkISymJz/Z8Egg03FXhejJ6lucRur2zZhy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1jAN3Qak; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R58EIZy9Q7mtj/nwBuEMemc28InlPv9SX0k3QdzV+dc=; b=1jAN3QakZTkdrhr5aGb/NNXHoD
	DF3qhBZg8p9KY8Mesc7cXCBe1rgMuQ0Jlf2Oji6uHbXwcqQFvBpltSYn8unnu8eoUO+OBNAtqD18i
	D5Ii90wpv5zX4qfNJ472JXSGbPV/N8Mi2g5x1U8a7gffdcLRHb2/Bjf1B3Dx3wwH4O4UXktpEP8I3
	jZOVxuD59qAuH2poNEuu0loiby0rvT3Gn0afLk56oIRNwNVvwdG5Savh/ZInptog3Mk7IfjrFO0GZ
	eSKDzT7ylKnncfYCAsJpBK9v6pMWoJulN7toW/74oiluKLeUaUDzOorQI6uDH7pPVQAurgoLUVD1D
	C1Q9DKwA==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svE4D-0004Xd-SR; Mon, 30 Sep 2024 12:55:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC dtsi
Date: Mon, 30 Sep 2024 12:55:35 +0200
Message-ID: <172769365130.1880381.14526267729451326976.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <84264d0713fb51ae2b9b731e28fc14681beea853.1727345965.git.dsimic@manjaro.org>
References: <84264d0713fb51ae2b9b731e28fc14681beea853.1727345965.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 12:29:13 +0200, Dragan Simic wrote:
> Move the "l3_cache" node outside the "cpus" node in the base dtsi file for
> Rockchip RK3588(S) SoCs.  The A55 and A76 CPU cores in these SoCs belong to
> the ARM DynamIQ IP core lineup, which places the L3 cache outside the CPUs
> and into the DynamIQ Shared Unit (DSU). [1]  Thus, moving the L3 cache DT
> node one level higher in the DT improves the way the physical topology of
> the RK3588(S) SoCs is represented in the SoC dtsi files.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC dtsi
      commit: df5f6f2f62b9b50cef78f32909485b00fc7cf7f2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

