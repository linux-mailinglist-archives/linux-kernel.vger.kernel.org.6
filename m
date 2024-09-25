Return-Path: <linux-kernel+bounces-338418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D105C98578C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C71285CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF3189F48;
	Wed, 25 Sep 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jafBm6Fn"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA165189BA3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262104; cv=none; b=KK3x5FiHdzrp5RzDvcHozP1QdPm1MhmniVULPdasVyJwEqP9w59BzGdTCTEKEPjL+hHDVato39hffrQ5yK36j35d+3rtWJqc9+BT+r5B11ylwf5cr1WZKCpcbKSBQwj/SDAFQ8KwSVxD+bzt+WXxEefBHGcWQBKm6JSZM6WCwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262104; c=relaxed/simple;
	bh=qTmn6cvNPS/41vZDFYHAEqEZ5hFW5+iV9uAFz4c3bHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewIBsJTRcX86X7vEroQoxULUl+JE1mNeT0dsldtPjOG/FbWef7CfCvhd/f1iFPknwfOthto0lRSZNwLcetrgi90kmyc9f/rDl9qkZ5iVrIJKHbm1rZn2T66v1bEyWXnziYqnIwb9XW8spDST8b8tBKa7hVBDPUp7uJgFOIepmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jafBm6Fn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71971d20ad9so4357642b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727262101; x=1727866901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0gdoWEmQ8OIzTuFnl4n60fS6o89niEVW+7kgdyvnOE=;
        b=jafBm6Fnr9LjWk5Ht+bIW1Rd2r0XRHGe6g0ZYsvjgMW7yJ0HnDAhWAagmYGXHNUSAN
         8goMzYrk7HMXJqUxMZoCEzcUMhj/5iTprDCPnC7iwO/3j1G26f/28ooii62tAWkv/Hmd
         w3S13Y+kcx+lcwHBbvamisSJAssHpPsb6APjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262101; x=1727866901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0gdoWEmQ8OIzTuFnl4n60fS6o89niEVW+7kgdyvnOE=;
        b=NvDaxOV9PqC/Es6fItJkXIn7Br2jZJca/cICrZHibvXiaQM7JE38qRz/U/ZD5F7z3t
         COSy6r74mVWKAFJJOH4Xr/f9fXGqU0fScNWpuhlZ6B8LXTFKysWOkRQR9BLi+lKwKrHY
         08teQuBy6U8Sj2oyvKU6gtRJ9jChk5V+y7xJ0Is473i4F4Ognv4Fj0+qU9PlHR5ibtmq
         4ORpFnt1IXcKP/NH2tiXk/DnqUi0wDPueysadJpQ2vnZx/8YJP5GwvklQ/mGMsifK6Rf
         FJn94icAB88Li/I7x8Bbvnbchtiq+LroeWqlwpLGB6rGar6UNULofI0Zcu5tMi76rq1q
         3G9g==
X-Forwarded-Encrypted: i=1; AJvYcCUv4++lBczT5LphnawP1QZdfynvcvLWvIC2gl5/EEB0PGB/aL5OYmBnIK/E5yRZ68bgsVXn3E30Rv1BYss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrERSQ7cmWwsio++Qb4pjz1h87OeS6XFDUoI7z09BPbWel3sPh
	5SdLLZ689/tuTrCAXgZBjFpl+6JEOQ8Pes9JIlj9DfElEUbotgL6qLCqcWSrjQ==
X-Google-Smtp-Source: AGHT+IHW8akhne8ifxBoarbEIqQkjZqpqla6rNR9R3QeDqTmmCGIt95+B1YaGfD1lQYvQ0y0FfdixQ==
X-Received: by 2002:a05:6a20:1010:b0:1d4:e56e:93b5 with SMTP id adf61e73a8af0-1d4e56e93bbmr1103285637.16.1727262100947;
        Wed, 25 Sep 2024 04:01:40 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:2b86:78b6:8ebc:e17a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73085sm2570298a12.59.2024.09.25.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:01:40 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 6/6] arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
Date: Wed, 25 Sep 2024 18:57:50 +0800
Message-ID: <20240925110044.3678055-7-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925110044.3678055-1-fshao@chromium.org>
References: <20240925110044.3678055-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek mmsys is more than just a clock controller; it's a
system controller. In addition to clock controls, it provides display
pipeline routing controls and other miscellaneous control registers.

On the MT8188 and MT8195 SoCs, the mmsys blocks utilize the same mmsys
driver but have been aliased to "vdosys" and "vppsys", likely to better
represent their actual functionality.

Update the vppsys node names and compatibles in MT8188 DT to reflect
that and fix dtbs_check errors against mediatek/mt8188-evb.dtb.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index a6cd08ea74eb..98ba3485a8bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1783,8 +1783,8 @@ mfgcfg: clock-controller@13fbf000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys0: clock-controller@14000000 {
-			compatible = "mediatek,mt8188-vppsys0";
+		vppsys0: syscon@14000000 {
+			compatible = "mediatek,mt8188-vppsys0", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
@@ -1801,8 +1801,8 @@ wpesys_vpp0: clock-controller@14e02000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys1: clock-controller@14f00000 {
-			compatible = "mediatek,mt8188-vppsys1";
+		vppsys1: syscon@14f00000 {
+			compatible = "mediatek,mt8188-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.46.0.792.g87dc391469-goog


