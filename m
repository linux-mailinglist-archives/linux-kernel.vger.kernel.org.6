Return-Path: <linux-kernel+bounces-321251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A1971669
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E601F232B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511D1B81AE;
	Mon,  9 Sep 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CN8RKyHW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D41B533B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880680; cv=none; b=mH4ndi9BnFb6ciBN4NVsr/mSz94M7+xqPqrc+392aJro6ke4KMJzAPeSuJtOSEm9l5WwzjJzaI6H0PBIy0Cu91+ysOWk/+xzgFpzo6kxbRKsdJsDss3kdlkSy11abWuthtOLsmDagAiprff8/N3yKaoCDrsCTTs1iV08E+c4WjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880680; c=relaxed/simple;
	bh=v0lqhXDww126ExqWe1NdjbR42IBr9nBcR7KMJ8c7f20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp4B4RoCZWE/eCU1AkVtAVv4gkbXd2JtG4rnrONG2iHqbOc+wN9KyWUHrEeEr16cHXwp1eCn3Jv51sukI9aj6OItKjAYTP8YE3f+QPoSS6NKSmG15cJjwnUCrt/Fj6SpvBHujWh+11+A3zdUpu2B1E9MaFIXuHqI2r+hGzC/bmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CN8RKyHW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d50a42ce97so1576009a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880678; x=1726485478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k98xHcx8LIPGVP0kPjUAh1AHHL+3f8QtEI3GBp8SnEs=;
        b=CN8RKyHW/v9hdsKYgE2wJa21IKEiURYOsamy0ZCvUC27E0RmarZN/5QcUYmyYHvfco
         G2QupkcLQv+f7Ej3/26/g9EpZaf6sWzQKp0NgQmtBITIpyLpvmciKjmgWy54GRXgkUIq
         1kSV8nNKZH3j2KOo45klf2/pF+xkIMUwkB2n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880678; x=1726485478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k98xHcx8LIPGVP0kPjUAh1AHHL+3f8QtEI3GBp8SnEs=;
        b=nEljqQLEtQqayTg7CkkewHQINujCh/JKCoZsfXtgfcEiTcyoz4xhzceDtfJnFIJxOl
         aN4gRpCthi0lCAdXfQAwcy4D0Y7h7K/5roxK2VrlL8i7CP68Sq5CkSkTQmUs1xw68mZs
         GdBoA1iEmqnmZW8MJsv+uvO17G+g/X8bf0eHJTZOSrpD4U0pmzAjLA0/cbYGyXTyww8/
         8rtKJB0RCqWqvVvdaM+CWVddtDz02xodubLFPHa21+qt6onX9C5QU7yI4HbtAR81023M
         wTaGNejKGQMwCmUBcuc2JCI4eXaAW9afHUG4JkBS9PbdZAEFTtp4z0xJk/QeMp4sqwyg
         eINQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsq00ANK0k8SRUP0iBeCAKOfSjPLVPaNl0mFt5bdT+6iHrpaFu0CjHbHjI4M+LgmUkIxM4jtiqXxb4DmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JaCBJZf6pNS52zcBRPmNmfgbpndzxwNrPI913Qc2ozlJdT7Z
	enF68NS7CPMh9uPL1HG0j50FlNZ3m9JyyQWBJKUtL9tf1bZSDcI/n88pyNerOQ==
X-Google-Smtp-Source: AGHT+IGoS/wNfT96ErEpO6j2A4iVl+SSYkCw9fl18EPKIdICyKbSqkOSzDP41poSrNFHrcako0/RMQ==
X-Received: by 2002:a17:903:22cb:b0:206:bbaa:84e9 with SMTP id d9443c01a7336-2070a7e5982mr90617095ad.47.1725880678168;
        Mon, 09 Sep 2024 04:17:58 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:17:57 -0700 (PDT)
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
Subject: [PATCH 04/13] arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
Date: Mon,  9 Sep 2024 19:14:17 +0800
Message-ID: <20240909111535.528624-5-fshao@chromium.org>
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

There are two hardware IP blocks in MT8188 video decoder pipeline:
vdec-lat and vdec-core, which are powered by vdec0 and vdec1 power
domains respectively.

We noticed that vdec-core needs to be powered down before vdec-lat
during suspend to prevent failures. It's unclear if it's an intended
hardware design or due to power isolation glitch. But in any case, we
observed a power-off sequence here, and it can be considered as an
indirect dependency implication between the vdec0 and vdec1 domains.

Given that, update vdec1 as a sub-domain of vdec0 to enforce the
sequence. Also, use more specific clock names for both power domains.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index dfbc50c878c4..445d30eee2a1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1078,20 +1078,22 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
 							#power-domain-cells = <0>;
 						};
 
-						power-domain@MT8188_POWER_DOMAIN_VDEC1 {
-							reg = <MT8188_POWER_DOMAIN_VDEC1>;
-							clocks = <&vdecsys CLK_VDEC2_LARB1>;
-							clock-names = "ss-vdec";
-							mediatek,infracfg = <&infracfg_ao>;
-							#power-domain-cells = <0>;
-						};
-
 						power-domain@MT8188_POWER_DOMAIN_VDEC0 {
 							reg = <MT8188_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
-							clock-names = "ss-vdec";
+							clock-names = "ss-vdec1-soc-l1";
 							mediatek,infracfg = <&infracfg_ao>;
-							#power-domain-cells = <0>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8188_POWER_DOMAIN_VDEC1 {
+								reg = <MT8188_POWER_DOMAIN_VDEC1>;
+								clocks = <&vdecsys CLK_VDEC2_LARB1>;
+								clock-names = "ss-vdec2-l1";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
 						};
 
 						cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {
-- 
2.46.0.469.g59c65b2a67-goog


