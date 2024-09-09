Return-Path: <linux-kernel+bounces-321246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7313971660
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A882845DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799F1B5EC2;
	Mon,  9 Sep 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9dfzc6n"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E41B5832
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880673; cv=none; b=tUMk5pKYWUl94Emx6cMdvb7Es4pyQP0RvevVR6ktZI5DD3gcDpaOSfTlyEbTpX3Kqo6wF86pcr/SokyEOFxCHPZYV++aP5G2FtwQCO4SqdqvLgJ7UCoNi6ZeauudqB5qi+HCGwIseYbebV8MIWCAXYv0wRZseEFL9VShyNwSq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880673; c=relaxed/simple;
	bh=9/My7PjvRLT9BbkGoUHtA83sYS5WvCABW72oOHsTTGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYS97hVfeVOvWkBauky68xH2s5+SiCHTn1lkwhlhzxafxybxBmbURWaVlFU4b7YwnguRqAXnDAD2ebqEqKQIPshr3B8bJN8qVjUDlRIbDggAwkRYWN9zsKz+Pgq7MxRoyTh0++9CHXy8I6bGfF95gLk8s2U/5O71WMXTsKxtuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J9dfzc6n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2054feabfc3so36352285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880671; x=1726485471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inMWF7mAc4RQp01FZVAzZYJjZGIEnM27V9mYFjLFKXM=;
        b=J9dfzc6ny2qTtqNGOET4EpXmrGRk7YoIFuZp1zl0n1duc7LJGSxP9NdwRSWt8UMRun
         bSvmewwy8H2xOhgD5WQxXy003YVMlbfEbOf8L6xCgsCZY1EIT30HlG0BUyJLfIdv/d4N
         9ylD4GqWccQPj1LfFtVPvvmhtRkFkFe1Ww3NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880671; x=1726485471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inMWF7mAc4RQp01FZVAzZYJjZGIEnM27V9mYFjLFKXM=;
        b=wCe4UH+VyJYnmhjba+cY2LTR5XERXFBSucbC2xmKyR8qsJ+rQK+f0BnE0w2ZMvQeVL
         npwP42J+paR6iXe+RQpE5eRMUSV6UpEMAbn67eXTSn49fq11N13lyosepHReAHZgZ4PF
         esqbeXD69MhVaqQXSOyPanwll+r7vuNsexx1uJM68TxwsvJrtafMir//nLPW2GwhoQSO
         MmM6nYmXghtr1gE5reJi9l/IeV+mLsvUECTvsqFj2EHB+SnidLLZsPLaNManNRYJP4ji
         /kbkefVmvRSP6YeAczlThpJq4wyRMGFrOUljfLihFxvB3iZVnsjC8GQ+uydb8AfmXGKl
         Op1g==
X-Forwarded-Encrypted: i=1; AJvYcCVLOtiRG5nUO5YqaC9FSVANQZo52UEdjXEX5r/sKzr/Sjk7FpUqFmW8fkU9HuQ21bjYFU8cT64ucyYlPh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVVpJ55kfdNKOXkrmhrspZlqmu5Wxki93ifmn9HLT0LG+MUBu
	kGapaywrK3/3GYPDEgyqMjAbO70yn2duTwaPWaw8sSzh4HDAs7C+rVXcpAITOw==
X-Google-Smtp-Source: AGHT+IGEoXdjMPDfBAFuOqotyznZjRHcP++k8TLwSTP8JbDeKXsv6apEUH19HjF6RrX+uRkTQqMG/A==
X-Received: by 2002:a17:902:f549:b0:202:5af:47fc with SMTP id d9443c01a7336-206f0511f66mr171192305ad.13.1725880670880;
        Mon, 09 Sep 2024 04:17:50 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:17:50 -0700 (PDT)
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
Subject: [PATCH 01/13] arm64: dts: mediatek: mt8188: Add CPU performance controller for CPUFreq
Date: Mon,  9 Sep 2024 19:14:14 +0800
Message-ID: <20240909111535.528624-2-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add performance controller node and performance-domains properties for
CPUFreq support on MT8188 SoC.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

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
2.46.0.469.g59c65b2a67-goog


