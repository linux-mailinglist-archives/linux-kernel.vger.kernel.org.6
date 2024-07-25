Return-Path: <linux-kernel+bounces-261858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AC93BD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25523282C31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727F16F830;
	Thu, 25 Jul 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oQcPRt0g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1C16D9B9;
	Thu, 25 Jul 2024 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892194; cv=none; b=PfyZkCM+/olsrwpV96JmR7osoaC7yqzg9V4YMtSHirZbC8E11/YmyTp91Ao3Ctiz8OjN2htEb47UpQ7p+MeOs8gMVzhwDZo7J1zlRzdlW9lavKwcneXyTmjbPeErUHGG6NElyKbapLMHbFRjLBPie2OxIjtAHKDdEEENJh8glPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892194; c=relaxed/simple;
	bh=LybX6K9ckx8LWHxoZ8RF7U51lUc9uadONdKAka89nR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKRcaXmenZx7yTIzp3TIe5RASh0m5HY+mjP8JFxwlmD3+fhSiQItFQh6QaY4lNv/x6h6aiEQYddkN0tRrZmMndW1jhkj0whqe1nAEHVnSPvNXSWA9F3fvJ5C0ot2kgRT4bpUN8IAlx2LaukbMtpwlolUC2bLenqUdf68wJ/llBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oQcPRt0g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721892190;
	bh=LybX6K9ckx8LWHxoZ8RF7U51lUc9uadONdKAka89nR8=;
	h=From:To:Cc:Subject:Date:From;
	b=oQcPRt0gV6n4RhWpSjX2OkdJhXIIy0qJSx1BiKa33V58VcISEGOS/6+rnSFlHlgbR
	 EhpChXPIXtqLflIdzPrlrQBSzKz8xdVa3ZVsONDIFMuBcjVkZ/Gy9Nd8wrLmFJDgOb
	 W/NdvgA7aMY3Pfs7bpV5TYvw3gMITgdc++x6JdBpywwoOx1KBaJKxLWdeDwWnr8GfJ
	 hxSQS3osndlbfRrY+mZq9bXWLr8TTo10dslQp2nY+Umg8EvYYTWgTA/cYMiZYMa/DJ
	 K1pNov4d76V5Vb8JSo0NNJkCZBZr0eWB6+0WDXRKRut+o0fJPzABHEc0N58O3t+1zl
	 czYPPpZPws/kQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D514837808FA;
	Thu, 25 Jul 2024 07:23:09 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] arm64: dts: mediatek: mt8186: Fix supported-hw mask for GPU OPPs
Date: Thu, 25 Jul 2024 09:22:43 +0200
Message-ID: <20240725072243.173104-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The speedbin eFuse reads a value 'x' from 0 to 7 and, in order to
make that compatible with opp-supported-hw, it gets post processed
as BIT(x).

Change all of the 0x30 supported-hw to 0x20 to avoid getting
duplicate OPPs for speedbin 4, and also change all of the 0x8 to
0xcf because speedbins different from 4 and 5 do support 900MHz,
950MHz, 1000MHz with the higher voltage of 850mV, 900mV, 950mV
respectively.

Fixes: f38ea593ad0d ("arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4763ed5dc86c..d63a9defe73e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -731,7 +731,7 @@ opp-850000000 {
 		opp-900000000-3 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <850000>;
-			opp-supported-hw = <0x8>;
+			opp-supported-hw = <0xcf>;
 		};
 
 		opp-900000000-4 {
@@ -743,13 +743,13 @@ opp-900000000-4 {
 		opp-900000000-5 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <825000>;
-			opp-supported-hw = <0x30>;
+			opp-supported-hw = <0x20>;
 		};
 
 		opp-950000000-3 {
 			opp-hz = /bits/ 64 <950000000>;
 			opp-microvolt = <900000>;
-			opp-supported-hw = <0x8>;
+			opp-supported-hw = <0xcf>;
 		};
 
 		opp-950000000-4 {
@@ -761,13 +761,13 @@ opp-950000000-4 {
 		opp-950000000-5 {
 			opp-hz = /bits/ 64 <950000000>;
 			opp-microvolt = <850000>;
-			opp-supported-hw = <0x30>;
+			opp-supported-hw = <0x20>;
 		};
 
 		opp-1000000000-3 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <950000>;
-			opp-supported-hw = <0x8>;
+			opp-supported-hw = <0xcf>;
 		};
 
 		opp-1000000000-4 {
@@ -779,7 +779,7 @@ opp-1000000000-4 {
 		opp-1000000000-5 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <875000>;
-			opp-supported-hw = <0x30>;
+			opp-supported-hw = <0x20>;
 		};
 	};
 
-- 
2.45.2


