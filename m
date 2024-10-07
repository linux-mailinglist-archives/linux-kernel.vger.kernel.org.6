Return-Path: <linux-kernel+bounces-353167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB59992997
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0422842A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFE1D172E;
	Mon,  7 Oct 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="fGywnsXV"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E81D131B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298690; cv=none; b=Omc942WUMgRgrr8hfCXTc3IUjqGz0T9r3MdyXA1XfLG0KQqcMnB4q6yGAJYPqnivBrFFhi1DqVlOYmECbcwMoU9OWSqw/2R3fHggbiwuZnyqxXR0PmuPRkOgKxzsCuyL/cqmatN7nYbs1Oa7gmy88pO7NpSA2IaOUznxs/qG+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298690; c=relaxed/simple;
	bh=0yMXOS6c/571bYvdA11DNpEGNc7xrPdegK3HCF1t8hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsDwr2+1wFaVv62Xq/d/llwJ4aIdIeSjxI3Nx7MdeN5AQ0w+P/mlqsZnSvxJu3glEBvk+G6WZ1JkmDUjAp1OpGHysx4HENwDC7YqHVOGx4Lj6Fl/y+Ei9IudD2JXjYTwwQveYW+s7/uxpsRA48NoGzQnnGM1nh6lFXmxaf5CsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=fGywnsXV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728298685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpC8BuQyOu1raVOWGNw8JM3D5RZAUOKPIqZm8ouVEJc=;
	b=fGywnsXVBIEG14aD2DI4EiThRvHG7l5pskggxCBIx1uvC1/6sEp5OhUgWC0/iJBsEN0lK5
	pepZc5qDavCqNXlNOgBaJ30E8+rlz4Ceija1AHMDX1DiErvYFJ025rgaJqK+DO460iVLh7
	xEGfT5GmZVF7gHeZacQhWIiCCxbB8xACbAaVE1PUkXSlVjX1xFkPLhn6QUSyUq1bPOLXGU
	jjlj8rH3h4BHBAtj+cvxS+y2Adr1j/T+AmsRbqLKmD7NAwrC04ACCMy3HUL4THrHEHmpGD
	nKQ2mB6yYtLIie8W3mO921iEEpKwG98+xV9J/J0hM/TXmz+zuIyDEx7ldAfuRg==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: rockchip: Add PD to csi dphy node on rk356x
Date: Mon,  7 Oct 2024 12:28:16 +0200
Message-ID: <20241007105657.6203-3-didi.debian@cknow.org>
In-Reply-To: <20241007105657.6203-2-didi.debian@cknow.org>
References: <20241007105657.6203-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "rockchip-inno-csi-dphy.yaml" binding requires the power-domains
property. According to RK3568 TRM Part 1 section 7.3 (page 475) the
CSIHOST is placed in the PD_VI power domain.
So set the csi_dphy node power-domains property accordingly.

Fixes: b6c228401b25 ("arm64: dts: rockchip: add csi dphy node to rk356x")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 0ee0ada6f0ab..d581170914f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1790,6 +1790,7 @@ csi_dphy: phy@fe870000 {
 		clocks = <&cru PCLK_MIPICSIPHY>;
 		clock-names = "pclk";
 		#phy-cells = <0>;
+		power-domains = <&power RK3568_PD_VI>;
 		resets = <&cru SRST_P_MIPICSIPHY>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
-- 
2.45.2


