Return-Path: <linux-kernel+bounces-305706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27ED963312
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B261F25007
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353F1A7050;
	Wed, 28 Aug 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bzF8eE9K"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120A224D7;
	Wed, 28 Aug 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878397; cv=none; b=WS9SH8bJ+uIqg0+s1fw9+mtERdTzedr7BEPATRTmuK5tlrdc7wIvz1AKmCxduUy/gPJ4rX6xFp8kZD9fzuvVO8k1jtQn+2gDSIungFZV2+y/yJV6bmu+wMnx0ZhCM/BWWnJ4S5+BD7Ty26wj8SnDlxFMb9s2CiYNjZ5X1mF3+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878397; c=relaxed/simple;
	bh=CCI33Y/2VwAbG4/HMIVzpBvjF4PhNjBcdf8LFRfer3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5ikEykyx2EsEcqaEygTq0X4ZUjiQtWPH9XcGhFLiF7UBK0kEsFV4F8BqiU112stcr9YSxnRT5ywQ527kt0eY/ND0cihmx3vZLOj7RWaqMxztVsLqaXJV2CKDV/FP2NpPRA6TKxLVLvoEkK5GaqF5H0yHdSlLtAQrQ8nAmMpAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bzF8eE9K; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W3xTxHAVy8T5VJ7Gg1s6MiPfQ5UiQz/WzG7TYzz8skM=; b=bzF8eE9KcDKbWremHjI+p9vENo
	kOIg26PodC1g7xxbORtbpeQWua22oLyy4EqQdMupKpPdm45NkbFR6TZqGa7THFKRpSypmVGGrnUMR
	xNNR2qsiFU5ilXpcsC9Y0Mnnsl5xYmy00k8CQ5UDwL+hVdxNj/eiIloiwHdzA0SNjHGP6be0YfI9O
	VYrzn0CIPvxCFPWrjI0/3uDbJncw7K0vgTvq7/iVMgIok/2ydV/8ykuc+/rLTeP75pfylc+q3QDWh
	PAshHSQvyOuVHdr+5AV7YtdgVuYEPG7o3KbOE0Thle7C+ewbX6iZCHG9e6W5yEPr/5tzI2SqEtbES
	OdWcY/XA==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjPf7-0007tF-O1; Wed, 28 Aug 2024 22:53:05 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	mturquette@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	krzk+dt@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v1 0/9] clk: rockchip: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
Date: Wed, 28 Aug 2024 22:53:03 +0200
Message-ID: <172487836642.1577158.12196598647797813806.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
References: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 18:36:40 +0200, Johan Jonker wrote:
> In order to get rid of CLK_NR_CLKS and CLKPMU_NR_CLKS
> and be able to drop it from the bindings, use
> rockchip_clk_find_max_clk_id helper to find the
> highest clock id.
> 
> Johan Jonker (9):
>   clk: rockchip: px30: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
>   clk: rockchip: rk3036: Drop CLK_NR_CLKS usage
>   clk: rockchip: rk3228: Drop CLK_NR_CLKS usage
>   clk: rockchip: rk3288: Drop CLK_NR_CLKS usage
>   clk: rockchip: rk3308: Drop CLK_NR_CLKS usage
>   clk: rockchip: rk3328: Drop CLK_NR_CLKS usage
>   clk: rockchip: rk3368: Drop CLK_NR_CLKS usage
>   clk: rockchip: rk3399: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
>   dt-bindings: clock: rockchip: remove CLK_NR_CLKS and CLKPMU_NR_CLKS
> 
> [...]

Applied, thanks!

[1/9] clk: rockchip: px30: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
      commit: 2496910c84a4bd1aa2c10fe57cf4ae1cbcab17f4
[2/9] clk: rockchip: rk3036: Drop CLK_NR_CLKS usage
      commit: ec4f4261c315d9bc30bb1bb8c3bb17cbaebe7741
[3/9] clk: rockchip: rk3228: Drop CLK_NR_CLKS usage
      commit: 819b2e19a9f7dc9e84a00e2f6da2b2f15a01cee6
[4/9] clk: rockchip: rk3288: Drop CLK_NR_CLKS usage
      commit: 545b1313c5a24eed0e4d34554c715b46686251ff
[5/9] clk: rockchip: rk3308: Drop CLK_NR_CLKS usage
      commit: 31fe14956883bc09846ce239993e215330218a6f
[6/9] clk: rockchip: rk3328: Drop CLK_NR_CLKS usage
      commit: 0758fe99bc969294c2391de145b67c1223c7b104
[7/9] clk: rockchip: rk3368: Drop CLK_NR_CLKS usage
      commit: 41563197e7f2a0b449476bbbe931cb2806e84966
[8/9] clk: rockchip: rk3399: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
      commit: 1a229868852ffe1d59f6bdad1e473d9d5f9e14bb
[9/9] dt-bindings: clock: rockchip: remove CLK_NR_CLKS and CLKPMU_NR_CLKS
      commit: fb234516c5a0728d7dbd718667c33c1523b55fe8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

