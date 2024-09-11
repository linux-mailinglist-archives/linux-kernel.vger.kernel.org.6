Return-Path: <linux-kernel+bounces-325151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D728B97559C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159B21C25B35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A561A4F1A;
	Wed, 11 Sep 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nPXPRE59"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4C1A4B74
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065319; cv=none; b=o+2TVGf+Xpnp3OumebEqbAG1MxHLRo2akHcMCu4C5eRssp+z4iV6OSy6jEzmZBXumbjxLwZBXI05Qf39z9C6FGlUWE2zum56fh/nQlzm2jSha/njtBgLNuUPhpvHLUOe5DKuHLHLoJvmJY3eOS3Lhzp9l6bK9Yh/MxMxZABQOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065319; c=relaxed/simple;
	bh=W71pzCUhjFb9jZ/lCd/tp6gYwQ/Gmmvx4o0ugiLRFds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5iFIa3vOFHIoOwh0FI0iymjYvbLG8e2J5BpDtT6KUMg6SVk+oTIAgpuTRv64fz4DdjA6E7kSgcFhJTjpnAnazFS3aIpLMIFPmL0wMno84OoqMoGXhPR5x5/USbWUAeOyVJhxeqfdafwOKx4ZKnv3USljbbVjdrRyNmj3oGson0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nPXPRE59; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71798a15ce5so734520b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065317; x=1726670117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flO2kMjBbd38S9uV93LXACtUKy2NNrMVAURW7PjykH0=;
        b=nPXPRE59KgbQ6/lhXDRjmk83epgR/vb3J3wUBKcuYXUc9+2r3aGIxc17BCpVgRA3Oa
         3CfHNQ2JuljwLHJgjCXF9Bfq4F5BOpFIV1atL6I0/p6jo2yqCn7fJCLFXEP5+92qw0h5
         GBqn5zeJRMewLE20gmiqnWd8W5IoA06tLGCIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065317; x=1726670117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flO2kMjBbd38S9uV93LXACtUKy2NNrMVAURW7PjykH0=;
        b=sqHeE3EH6yZDDgv+gAD4UYolaxjuAtJ/gaSNemskhKEis/LqWhP8NucptCx0hqa+aH
         N1VyKxbLZj4CsfSD39ugKFfOZDZ44i2sFhgxJseI3aDiPY6ycOliR8tp1uuZF2U8V3rq
         cyj/rTXyTIDxTpMs8WeEBSTnA/2Nh3sKnZqel+n3lffCFIMhEProLAbszRLxV56T7tOz
         CJYubIz0kNKbHTAMPV72Thf4ZrPz9f1+0udhzhYqUlYQ86tFHLzS+UiqIIbsgsAfBTfS
         i+Vpj3ycTDbGV/00jBLGZop135rWybJv1zv/F01ruUPLrcSv2kdXzgLoTKtViKI7Zpsq
         4uzA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8UkwtDzaGlRNb9FhwjjKsIH65f8CoFPk5mTfG/FcI++kZ8u5G6pmZdIrzSjDpXRYujdThtU1WWro3yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oVfr8nKJ0l37dDUSXYfcAkPNGRcE8OWJG9l4nisc1QPMJDEW
	WFEmqAailvEYS1yg9uXerupX7sLOLCbYm2YPykYFzSMb97ZDBsPk84sdy1e3dw==
X-Google-Smtp-Source: AGHT+IGWqqDq3WXUh183xK34Rxbjn61wnWFW93OstXI7bPArv11G83ZnspRU58x8mGmEmitA0kG5lg==
X-Received: by 2002:a05:6a20:2443:b0:1c6:8c89:88c9 with SMTP id adf61e73a8af0-1cf5e1ae57bmr5808169637.18.1726065316653;
        Wed, 11 Sep 2024 07:35:16 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:16 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/8] arm64: dts: mediatek: mt8188: Add CPU performance controller for CPUFreq
Date: Wed, 11 Sep 2024 22:33:56 +0800
Message-ID: <20240911143429.850071-4-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911143429.850071-1-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add performance controller node and performance-domains properties for
CPUFreq support on MT8188 SoC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index cd27966d2e3c..cdd2fe14effa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -41,6 +41,7 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			#cooling-cells = <2>;
 		};
 
@@ -59,6 +60,7 @@ cpu1: cpu@100 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			#cooling-cells = <2>;
 		};
 
@@ -77,6 +79,7 @@ cpu2: cpu@200 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			#cooling-cells = <2>;
 		};
 
@@ -95,6 +98,7 @@ cpu3: cpu@300 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			#cooling-cells = <2>;
 		};
 
@@ -113,6 +117,7 @@ cpu4: cpu@400 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			#cooling-cells = <2>;
 		};
 
@@ -131,6 +136,7 @@ cpu5: cpu@500 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			#cooling-cells = <2>;
 		};
 
@@ -149,6 +155,7 @@ cpu6: cpu@600 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			#cooling-cells = <2>;
 		};
 
@@ -167,6 +174,7 @@ cpu7: cpu@700 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			#cooling-cells = <2>;
 		};
 
@@ -880,6 +888,12 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		performance: performance-controller@11bc10 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+			#performance-domain-cells = <1>;
+		};
+
 		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <4>;
-- 
2.46.0.598.g6f2099f65c-goog


