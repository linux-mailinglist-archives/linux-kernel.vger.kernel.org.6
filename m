Return-Path: <linux-kernel+bounces-185470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954A8CB547
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E386283A73
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500A15218B;
	Tue, 21 May 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="w/yo98BV"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690914A60C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325906; cv=none; b=soEzSRXcE/QxM7d/ag81Zf7guKBoRxKHgdYSDA2J4P3bfaGoZXpgvTEW/2gCPLLGX2WXIfa7rj0f/08L/D6JHO5n3uV3sMXxSxcQfBDeHXi+Yz6y25+ExckCaANIPLREF6Byf1It40iQb892KSZMQBrGST4ft13mKv9AfCFH4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325906; c=relaxed/simple;
	bh=MyNjHS82u/1nlo9KiwUv4RWaAOeUxHx48yQ0reKxhdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNqY7X0mYvV8T5q+zeBHNA/YZMgPnjNoTNZe7JLwLEMdDHT6DcvHWgVK9Hi7hiHX64YKuDTq0lqkZGc8e0yDT8XQTcd0JL1spSKdyExOiy8UCmeuEct2IRIRqsM/EKx41gFj6Lu/xZ7ChBVa5k0tlkneQAXZFO2XaiETeKQxHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=w/yo98BV; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325887; bh=fq2OvK7SXWF/bksH5MfdcoQtqn5vKwKJIs3XwiGaAgk=;
 b=w/yo98BVP39OzhJIKLpQuI7F2gUaq7aIAdr8jQ85Ol0dqo6xHKrk0BG1Lc/KLYsZ/xVnx9+7C
 xJxo08dvhTzxiJY1mHejzwt3FjTv5EFPTyBOqs2lBe2nfInONizylk4QSojGo6At+stDaDYKrzR
 0hN3/7KsKXDtjS9je3+kAVlg7pczSNKebn1+W6tuW3UVcT1stuElJjS4n2LRKSDUZa/RubLKXHc
 MDRQaDRwDyeR9iOrU1k6bO81WHeAZhauu/ZH57M0qZM+f2uPCw51X66xdtgdcpznKtd31ALd1nk
 6PtgzeFD3p8ChKB6GqIvk5A72AF25MiRddtvMZX958Gw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/13] arm64: dts: rockchip: Add RK3308 IO voltage domains
Date: Tue, 21 May 2024 21:10:14 +0000
Message-ID: <20240521211029.1236094-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 664d0df98b6b0c828344af66

Add a disabled RK3308 IO voltage domains node to SoC DT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 6531ede13af9..31c25de2d689 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -173,6 +173,11 @@ grf: grf@ff000000 {
 		compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff000000 0x0 0x08000>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rk3308-io-voltage-domain";
+			status = "disabled";
+		};
+
 		reboot-mode {
 			compatible = "syscon-reboot-mode";
 			offset = <0x500>;
-- 
2.43.2


