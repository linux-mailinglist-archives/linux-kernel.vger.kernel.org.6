Return-Path: <linux-kernel+bounces-338417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4798578A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B94B23A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5766188A0C;
	Wed, 25 Sep 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndJUvKg9"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9E188A06
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262100; cv=none; b=JbzOduC8SVndlgWG8eq4lTetp6ZET4poTW8mwdUIhZnBHr5Hls9/fETT7bHQDPV6hkzM+66wxBv1qhfAb18nENyjmXLsl3JssaNBQbTnO4lTR4ZmLu1vMKr+WCCz4FfMfNg7gjA4Zj0gJBFoGJ4cVLY7e/rqyphwB5GOam4F8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262100; c=relaxed/simple;
	bh=y466IDLgTXXACCjJbDJPwCPXux6NQf37T0B9xg4c4eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHTHYD1Sb8uM3BIK/8KP8DEYPsfnceFttzKZiWfvAEmHY8HtZ+cCOPjiWiOwaIDJDWiijpS5GBl4Qp3hQgQbxD2HB8StdoWueYowlyMHBMC+tnQsiizXSPRhwTQfUgV+sbfDh83RueFqZEnoP8MeMxQKoVrxe4BbDsyb9bkrKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ndJUvKg9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191f58054aso4900360b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727262098; x=1727866898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OokQwblwx7XJowld2zR7LIeuJVeL+KfPUA3UT3AQXa8=;
        b=ndJUvKg9fiQio1fCtWEtmBlIZokWJrJ+XvY0mpYTFpP5Gyhbk2kkDnAER7E9GZup0s
         4issjDCXBLrROdxoIyS+xPpjCdsuE8YfpgGE/n81KQZiVWFLchjV86hz680kY3f3XilD
         ls2vHrqo+YzzsV+Pmym5myG6FuhMpNmZTNDVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262098; x=1727866898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OokQwblwx7XJowld2zR7LIeuJVeL+KfPUA3UT3AQXa8=;
        b=TIPCwM0KGI/iHJqPCLC/UdbxTPLn4R9RIwt6Q478rebuPH5HtYuA+1cuSy1MvNck/K
         auouk4m+xRia4ElypOOZBjO3FDOw1o3dJa6gSPHB6AEUZ1e0uRnmQpOyIkCiuWvxt0uh
         4vpcaxTr3Pkr11qYkweEWlyPQfrWNisMDVOOwJzX3TsDafH4e3R2PKYI+wUx1pO8oitU
         urHADaLQ6gJHg7H05xhSPlr6jv0secJPxA6t9g67UeeH7jO2LpoqrxxfTA9a5ug6NuSW
         2rQXMRYYYkrb1bcXphB81AUFqoU/pYzu6KawFevEu6XEAeHt+IITDLU9NzyJ9HhbSsUo
         9qWw==
X-Forwarded-Encrypted: i=1; AJvYcCXr057QhFz0y4xjg8s1nuXloMeDPqylR+5W3sKG5TTU/PTrPlCCILC0I1M0h102W4W/anU3LEGrgaeDDv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwosJAFt1rqcU1YiZpVEhiWtVdOsn5BecFot6+QIUP9wQ+sMQmt
	WYD8sFLbnz2CkKhvpXwlS9ZKWxrU1IX5MlCiXcHPHi4pHd19UzCKNYzmtC17uw==
X-Google-Smtp-Source: AGHT+IG6lm5IWJgffa43W9/ClCHgkLMhnab6oiXEbKs+fknBPEtsb+qFj/6zqz2ZSq3SheDbWpmfMg==
X-Received: by 2002:a05:6a21:2986:b0:1cf:6c65:b736 with SMTP id adf61e73a8af0-1d4e0bed995mr2986583637.40.1727262098113;
        Wed, 25 Sep 2024 04:01:38 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:2b86:78b6:8ebc:e17a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73085sm2570298a12.59.2024.09.25.04.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:01:37 -0700 (PDT)
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
Subject: [PATCH 5/6] arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
Date: Wed, 25 Sep 2024 18:57:49 +0800
Message-ID: <20240925110044.3678055-6-fshao@chromium.org>
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
index ff5c8e0597f9..a6cd08ea74eb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1064,20 +1064,22 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
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
2.46.0.792.g87dc391469-goog


