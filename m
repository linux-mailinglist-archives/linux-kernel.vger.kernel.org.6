Return-Path: <linux-kernel+bounces-215939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDAB90991A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E0B1C20F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B331E534;
	Sat, 15 Jun 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="gl2OipOF"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A9DDDC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471098; cv=none; b=b6+WJHu//v3yT+TVwd2arb6YLMNV0YeefD98rmMLiKjY/llJzM1EzNzV/KnXu9uInn7KGF0lybJFT19XnNVWnaNHtJm9AedfbavC63GvTfbwhu4nwdzVm5rzpsCFhaq+agXk2FaCdAEt/YNFXsLj97Yv6H1hdCsbfQnwd7N9BC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471098; c=relaxed/simple;
	bh=mAN7U7v2QG/WVuixRlQcrTUlR73Kdtu+HoSzBxs69ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpwOjYSjICEZetZ20+45fStsYMXgNss7YGCHd8EwuCiT7+wURNZoVAl/Wd1CQRTnqOpjc6nKjmu7AN1Q5Rx8QGeeRCXZff4roPO85RTyHkcZdMx5q7kvktWkFBsrLsi/5efOVS2Js1AFFhqQg2mO1N7l5C+8cynJSOj6tnG/9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=gl2OipOF; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471071; bh=Z+F0UfaoXDdt1StVLr0ioIKGWYkN+1Ezu/cCRH69328=;
 b=gl2OipOF7kftC5o30amFOfTBJ/fkhEX+26ZjhEcs4OmpBDB8MZSvOrkpFm1UVmNTpDPYKo6fl
 VoAFt4kA/sRfdG0huWAJ541GyjeAjvRsklqIRETfH0vGb/pg3NFz2AxlQrJpyZJEXZT4xFHFlRp
 EX2IHkZy2RM2WRmBPWJCVDP3+mxdC/LP/YrFnf4yFHVaH4yzV1NMb7SO3pe0+BtAyjtahGuIWzi
 TEj0AcY6b286ZQwiIOX2JN020rxFrvuV+ReUiIT82nDTmjcT7iXisZpWeTUq/gqhxusxa0U0s1w
 FtLchMGbsM24fpaCXLgg1XxlhUvDIrhFyKvzYrAPlK6w==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Liang Chen
 <cl@rock-chips.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org
Subject: [PATCH 01/13] arm64: dts: rockchip: Increase VOP clk rate on RK3328
Date: Sat, 15 Jun 2024 17:03:52 +0000
Message-ID: <20240615170417.3134517-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 666dc99c24e0254b39803fe1

The VOP on RK3328 needs to run at a higher rate in order to produce a
proper 3840x2160 signal.

Change to use 300MHz for VIO clk and 400MHz for VOP clk, same rates used
by vendor 4.4 kernel.

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 07dcc949b899..b01efd6d042c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -850,8 +850,8 @@ cru: clock-controller@ff440000 {
 			<0>, <24000000>,
 			<24000000>, <24000000>,
 			<15000000>, <15000000>,
-			<100000000>, <100000000>,
-			<100000000>, <100000000>,
+			<300000000>, <100000000>,
+			<400000000>, <100000000>,
 			<50000000>, <100000000>,
 			<100000000>, <100000000>,
 			<50000000>, <50000000>,
-- 
2.45.2


