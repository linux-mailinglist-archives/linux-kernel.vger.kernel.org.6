Return-Path: <linux-kernel+bounces-324732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9BB97503D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E202B1C225BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1399719CC00;
	Wed, 11 Sep 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBBHVqOq"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4619C540
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051943; cv=none; b=F7f3+UCNcNX/h92c2iVvXGKVCTRw6iFq+/8imnLzQwPmHcmccopqgP+c85vLAu0ChphGe8Z/jaYwE4waq8VWrftStRdRLhhodbBvBZUt57eY6Uk9rJKI1+GDDFRpxgEGcqh45/99xElTxVrEGLunbmO0ryU8XAFOkN9kbBzKwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051943; c=relaxed/simple;
	bh=tGKq93KKMs5ixpu0m0Y9PpuAyJk4Ca8B6C4/sWhI8OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I08hEjzljISwSGb9jJt1gbDRykhqJ4i9ipeRwZ+llG5aGiBBiZj+jXoF5azcJXcIpVkyO+OcN1pcJjVtVe5z/Fl/fg+9IJ2/AyTjIWCEoE6xXpFs1xwMcG/gQegmcs17CQ200C+Ip7ApmY4sGNBV6kRAIEYKV/0cw+kHGoJ6DiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBBHVqOq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e285544fso3102530b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726051941; x=1726656741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRJU0t6yYHxtxWleBKO67lBHd41mlkKGaUj6trBU+Ss=;
        b=aBBHVqOqJzVXFpd3HGVNR3NvzEArvkdYsH/w9dVPV9qUwqw8bymYUrY4VqGoInjPsV
         Ovu23v3x8xCv2LGsNprH7rh4QHr/iaLpy/Jy5ePFxqabpUBtWlRsGq99Dn6ONr3SmWsp
         sbYHHbFgMbfrJFj9B337Hk96TD8Ox/UBy3P28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051941; x=1726656741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRJU0t6yYHxtxWleBKO67lBHd41mlkKGaUj6trBU+Ss=;
        b=iUzldsjd8JA5Op0oXG4OiitjWYFLKxzRj7dJje6QktP3SPtbTf7/X2/wzaTIeFineg
         KQeiTTUV1/5Z0c2ivzszauxP+KEAUElQKWLoy3A2Svwsbarow6Dioe8j2eK1HyLc+qwx
         s69zS3LLx5e6EJay3URE8qeE2WkbkbHOy0W3FRdW3J0xxba8qWjCWamZCbpEA7SrPBC9
         AHbltwJEBAt9Ie8EfuqfRvF57GASPYgdw9vWUEs4EGYNKhtSs0aSgrVRNw7ZxMRSNrnV
         ++rWYbYJWPCouNKKCBZGk+FYaZtG4/YYTxM4q9HrN2TXMd0m87DyVSwZ1iwPwzwcR8l1
         9Jvg==
X-Forwarded-Encrypted: i=1; AJvYcCVNVJ7syifT8ofuhausDBXuxRiyT2rrcPN1Y2ZXLuVG0Ktrrkvv3Z9ZV+rgeJzCjUpKBBuUKGLLfurCStw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHmk3zdgoKAzSBkHclPLiMkKMsq7O9iY0CG37vd/ROinZsnaQ
	wgN9brApIXku0zteF6nV6+QK0Q1wEHKVd/t21l/5Ip8rIhxqZzij6M7w9FHoDw==
X-Google-Smtp-Source: AGHT+IECm7bSQDC8ZsxIXjMTAElbncL0v7wsrCPb3dyLQVmVYtqmVb6fO9ZMVHxPt6utNaXN13eKCw==
X-Received: by 2002:a05:6a20:cd0e:b0:1cf:50e6:fee4 with SMTP id adf61e73a8af0-1cf5e19f82fmr5867984637.49.1726051941085;
        Wed, 11 Sep 2024 03:52:21 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8242b3d13sm7147352a12.52.2024.09.11.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:52:20 -0700 (PDT)
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
Subject: [PATCH v2 7/8] arm64: dts: mediatek: mt8188: Add audio support
Date: Wed, 11 Sep 2024 18:51:12 +0800
Message-ID: <20240911105131.4094027-8-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911105131.4094027-1-fshao@chromium.org>
References: <20240911105131.4094027-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add following nodes to support audio enablement on MT8188 SoC:
- sound card
- audio controller (AFE)
- audio DSP and its associated mailboxes

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Replace hardcoded AFE reset ID with correct definition

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 96 ++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 32e5b7108f6a..f459e86d4024 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -429,6 +429,11 @@ psci {
 		method = "smc";
 	};
 
+	sound: sound {
+		mediatek,platform = <&afe>;
+		status = "disabled";
+	};
+
 	thermal_zones: thermal-zones {
 		cpu-little0-thermal {
 			polling-delay = <1000>;
@@ -1349,6 +1354,97 @@ scp: scp@10500000 {
 			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		afe: audio-controller@10b10000 {
+			compatible = "mediatek,mt8188-afe";
+			reg = <0 0x10b10000 0 0x10000>;
+			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP>;
+			assigned-clock-parents =  <&clk26m>;
+			clocks = <&clk26m>,
+				 <&apmixedsys CLK_APMIXED_APLL1>,
+				 <&apmixedsys CLK_APMIXED_APLL2>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV0>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV1>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV2>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV3>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV9>,
+				 <&topckgen CLK_TOP_A1SYS_HP>,
+				 <&topckgen CLK_TOP_AUD_INTBUS>,
+				 <&topckgen CLK_TOP_AUDIO_H>,
+				 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+				 <&topckgen CLK_TOP_DPTX>,
+				 <&topckgen CLK_TOP_I2SO1>,
+				 <&topckgen CLK_TOP_I2SO2>,
+				 <&topckgen CLK_TOP_I2SI1>,
+				 <&topckgen CLK_TOP_I2SI2>,
+				 <&adsp_audio26m CLK_AUDIODSP_AUDIO26M>,
+				 <&topckgen CLK_TOP_APLL1_D4>,
+				 <&topckgen CLK_TOP_APLL2_D4>,
+				 <&topckgen CLK_TOP_APLL12_CK_DIV4>,
+				 <&topckgen CLK_TOP_A2SYS>,
+				 <&topckgen CLK_TOP_AUD_IEC>;
+			clock-names = "clk26m",
+				      "apll1",
+				      "apll2",
+				      "apll12_div0",
+				      "apll12_div1",
+				      "apll12_div2",
+				      "apll12_div3",
+				      "apll12_div9",
+				      "top_a1sys_hp",
+				      "top_aud_intbus",
+				      "top_audio_h",
+				      "top_audio_local_bus",
+				      "top_dptx",
+				      "top_i2so1",
+				      "top_i2so2",
+				      "top_i2si1",
+				      "top_i2si2",
+				      "adsp_audio_26m",
+				      "apll1_d4",
+				      "apll2_d4",
+				      "apll12_div4",
+				      "top_a2sys",
+				      "top_aud_iec";
+			interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_AUDIO>;
+			resets = <&watchdog MT8188_TOPRGU_AUDIO_SW_RST>;
+			reset-names = "audiosys";
+			mediatek,infracfg = <&infracfg_ao>;
+			mediatek,topckgen = <&topckgen>;
+			status = "disabled";
+		};
+
+		adsp: adsp@10b80000 {
+			compatible = "mediatek,mt8188-dsp";
+			reg = <0 0x10b80000 0 0x2000>,
+			      <0 0x10d00000 0 0x80000>,
+			      <0 0x10b8b000 0 0x100>,
+			      <0 0x10b8f000 0 0x1000>;
+			reg-names = "cfg", "sram", "sec", "bus";
+			assigned-clocks = <&topckgen CLK_TOP_ADSP>;
+			clocks = <&topckgen CLK_TOP_ADSP>,
+				 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>;
+			clock-names = "audiodsp", "adsp_bus";
+			mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+			mbox-names = "rx", "tx";
+			power-domains = <&spm MT8188_POWER_DOMAIN_ADSP>;
+			status = "disabled";
+		};
+
+		adsp_mailbox0: mailbox@10b86000 {
+			compatible = "mediatek,mt8188-adsp-mbox", "mediatek,mt8186-adsp-mbox";
+			reg = <0 0x10b86100 0 0x1000>;
+			interrupts = <GIC_SPI 478 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <0>;
+		};
+
+		adsp_mailbox1: mailbox@10b87000 {
+			compatible = "mediatek,mt8188-adsp-mbox", "mediatek,mt8186-adsp-mbox";
+			reg = <0 0x10b87100 0 0x1000>;
+			interrupts = <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <0>;
+		};
+
 		adsp_audio26m: clock-controller@10b91100 {
 			compatible = "mediatek,mt8188-adsp-audio26m";
 			reg = <0 0x10b91100 0 0x100>;
-- 
2.46.0.598.g6f2099f65c-goog


