Return-Path: <linux-kernel+bounces-207091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3A6901247
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17498282A2F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE517B41B;
	Sat,  8 Jun 2024 15:17:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAF179675;
	Sat,  8 Jun 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859848; cv=none; b=iz93obLpED4rZyHOpN3ndeKixpbhrCT4PJ2ZMIeNiu1ROgxqBD/5HrTQGA90SYH1A3pJiQ6djdaiRAgltyOLefgfKPNxnaObMkEZ7fYXUHQFV1etZiF+1faQxnv87HlgZ89FFZDDVOKv7SoEGm99fbX6dCZ3p/XwA46VGUdZ5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859848; c=relaxed/simple;
	bh=uHg3+Wgz9CV5Yva7pZSHAd9W2b88TUkIRA2v5WtHk+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qN9WgjEcHPQGoOXRESKlEcvsdvW8oBEkt9WsEtcJGMpzfKwBaUDpJRGvV5CUB4pSgPfhMDtk/sxQW+YW6cWdBxLWpCti9F17K4TgNAAxirGau3Xg+ffl3Kf8+tl0gHjV+73rJ1xPqbOyWp5lUYsT0U6kd4mLdve32FZraFcYlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sFxon-0000Ur-I4; Sat, 08 Jun 2024 17:17:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Bee <knaerzche@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add SFC support for RK3128
Date: Sat,  8 Jun 2024 17:17:19 +0200
Message-Id: <171785983005.2839639.8937453926692720849.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606143401.32454-2-knaerzche@gmail.com>
References: <20240606143401.32454-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 6 Jun 2024 16:33:57 +0200, Alex Bee wrote:
> This series adds support for the Serial Flash Controller (SFC) found in
> RK3128 SoCs. The existing driver can be used as-is.
> 
> As without using some "id holes" we would run out clock ids when adding the
> additional SFC AHB clock in the binding and would have to touch the ABI, I
> added patches which remove the CLK_NR_CLKS macro and use the recently
> introduced rockchip_clk_find_max_clk_id helper instead to find the highest
> clock id.
> 
> [...]

Applied, thanks!

[1/5] clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
      commit: 3d0316c949e26392a5098e23c139c932991e50ce
[2/5] dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
      commit: 9f22b4fbd4c6d27ca4e5f8fa6632e6d7a846af28
[3/5] dt-bindings: clock: rk3128: Add HCLK_SFC
      commit: 469d6e0e70eefe1a31a89a7abd379f169b33b1f4
[4/5] clk: rockchip: Add HCLK_SFC for RK3128
      commit: f1fc95b41a3b1b2e613acb04c4f8aee7b87394cc
[5/5] ARM: dts: rockchip: Add SFC for RK3128
      commit: 01689df79018c4d68f84a2ac0cf65c35c852b979

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

