Return-Path: <linux-kernel+bounces-393331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D59B9F57
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFEF1F220AB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE6189BA0;
	Sat,  2 Nov 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2C6lb0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8216DED2;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547264; cv=none; b=mxTwMjcL5V342ZCTUM11JVN1JKUpr2nOoLy26dEb+tFombALYSYQApQPQqY7sTDDx5W5nvCsIqiiCnJc4Tv0/cMS3NbVJimVlUbIlyiAmiH7qLyJRamPNgDElahl+Gybr5NS11HHrPfnlQtKKhlUJ5LUhZwBAjGsSFpxqoj44Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547264; c=relaxed/simple;
	bh=mrf6lKlF96SpNcTN0gbN/Kkk9/u7S84IM9hSP1KPBDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxsczMGXHOJKfqk6ZAr5YTjsRo0BJtXNK+anMKwLgoFG+ftVsfJnF9z+OVXzOxXlfb//LkVFXaHhm7CVu0iftfDx9Jr9PliEZNAGC/luiVx0AdtYMIX3cTzbvcBjgdIGQ73x26G27PLeCVLGR8ce8y0wYSSEdapziDcZjhSzpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2C6lb0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 871B4C4CED2;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730547263;
	bh=mrf6lKlF96SpNcTN0gbN/Kkk9/u7S84IM9hSP1KPBDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F2C6lb0QH32WyNtReKR9i50Ivgo1GHFYE9nzCQQyIYvyPHuC40RKtBzlMbglV0GVq
	 bTwz24CKcAJ+ZpRBt7Q4UgFL9v1uPT7Gy5o3efYNk48U6KCM/NqjcRjSmyNtvMgZLg
	 4VRP4tYuVBP+l+4BY2ojFpoaM+5yrqKqJKLq8ur2r/QmEiZJ+N6vwbD2Kh10KkkLL0
	 /oxT50JA6BMbQj/ygQOi2F2d4A0vav7HaedIUdN/2XoKE2S6MB0Ils9RwuTpNzA8fh
	 G141548sTToVM19FntqIV3VLd75d2y4Aqf4vJuTk/8D+NhmxVRhk21yr0zSzWoIWla
	 sQyxG2DqngGRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708E2E677F9;
	Sat,  2 Nov 2024 11:34:23 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 02 Nov 2024 12:34:20 +0100
Subject: [PATCH 1/5] arm64: dts: apple: t8103: Fix spi4 power domain sort
 order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241102-asahi-spi-dt-v1-1-7ac44c0a88f9@jannau.net>
References: <20241102-asahi-spi-dt-v1-0-7ac44c0a88f9@jannau.net>
In-Reply-To: <20241102-asahi-spi-dt-v1-0-7ac44c0a88f9@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=dM/GrGK9N/5tAToyLPPTWx70HidhWtGG6XOo893Pexw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQ1Ptvp6+cnpq9tM70WkXdTq6l03hTzE/Nj0s2OFi5Rt
 4z1bK7oKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJELpYwMy2VeOE7e8ENw+Re/
 ZKat79iT9+5eNve/c/HMG4GymzLlqhn+uye9YdflnfXw4HvOJTMl5MzLIjILV8oW3VBZtbhEulO
 BDQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
index 9645861a858c1a7c46c25a614c2cc4b03083bf46..c41c57d63997a59a9fe3c88de31fddb31781398e 100644
--- a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
@@ -387,6 +387,15 @@ ps_spi3: power-controller@258 {
 		power-domains = <&ps_sio>, <&ps_spi_p>;
 	};
 
+	ps_spi4: power-controller@260 {
+		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi4";
+		power-domains = <&ps_sio>, <&ps_spi_p>;
+	};
+
 	ps_uart_n: power-controller@268 {
 		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
 		reg = <0x268 4>;
@@ -558,15 +567,6 @@ ps_mcc: power-controller@2f8 {
 		apple,always-on; /* Memory controller */
 	};
 
-	ps_spi4: power-controller@260 {
-		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
-		reg = <0x260 4>;
-		#power-domain-cells = <0>;
-		#reset-cells = <0>;
-		label = "spi4";
-		power-domains = <&ps_sio>, <&ps_spi_p>;
-	};
-
 	ps_dcs0: power-controller@300 {
 		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
 		reg = <0x300 4>;

-- 
2.47.0



