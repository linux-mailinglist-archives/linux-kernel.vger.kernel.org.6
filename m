Return-Path: <linux-kernel+bounces-292041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215AB956A72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF552835A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013C16A94A;
	Mon, 19 Aug 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvS3owJR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18E16A935
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069270; cv=none; b=u/s15f2bOiJCgG2GwfhV9MGNetFh8PHKfzSSyssggBwn/M3ZvlcEw1Utri9o7vQn33GdcwRrQaGr4bURNeQbYq+S6zg4dQeidCA0RNGnQLHqjAmAuAPxD1wOqe2GGpPk5jFTDxo2fVSOOzcTlqrw24tPC70KGthijIlTYFWKdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069270; c=relaxed/simple;
	bh=dAElQCkNFNtpOkZTljTKcvnln/5dv96/QE+2EZqHtQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIlI07DXCUvyIkCDXy09daFxGKh3KqyJSsleZsoeIeHa0+e3jxoaz43CBgpdqyqQ+TjkVlvdsSQpv5LwkJHvSef7WTNBdp62uDL1TGKA6CIDPqvuEkeoftmne0zJp6TXu/TZq0nIPVg1LrLlSxSK7NSgl9VWgKOdRVkp7C2dhv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gvS3owJR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20227ba378eso11400375ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724069268; x=1724674068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kb1adcHc3E8U+gSdouMJyc+8B8S5nqfJYg6YgFfK1Po=;
        b=gvS3owJRcrFvtjkBithjkcKVXgv+R1PNzZq6g1oSBxYkPoBitSjbihMhjwb7TwQmcH
         YyJUmq6zZ7f+yUyBZfNjOpHHHAzxxUwMq+9Wx/Uny1U5bmsWpW8yX/3H+oAlGE1JP+ay
         npD5ga+QEIOCQIG00hjEDu+jrhEJ59QFJl3x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069268; x=1724674068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb1adcHc3E8U+gSdouMJyc+8B8S5nqfJYg6YgFfK1Po=;
        b=KN+T2uhoAzt3z2QLEQAm4k8DFAaJ1fz+7c7Nk9ekfnh6M5dGgKukgLOC7QMcrc8sc8
         OL6RNExmzU6twJizbCYLW14xor+dtIeBdgpi5UUXfgWuRlCoJ5MCkSC91EXrN5mm6Y6u
         Caqv2jvKPVt6WwJsZbhSSw522+V7McT/Dp88eVFRBvwTVThTlrcHKZoMcj+ULpnphkex
         0/kDrrueljsVzRG06X3FM8OrURqe/bdM5FpCZRCC8VettzOZXkNykbx6+ULgC7jLic1c
         3TJibP1heAz12iANxXw/Y75OPQrAj9yrl9yT09O+9d1tDZhLsxx82FOo4pqQ0ol0GDvS
         fLLA==
X-Gm-Message-State: AOJu0Yw3wUD9RrASeMH7ogR3xHWGPDzt8K90T4uHfwCIIvZT/SQxgyU2
	bZZPAyg5/aU9WeXrmzG/WFH6N4Xtc/nPWhmtzo7o/jGQnHwEyfTtrgJGzhrKWA==
X-Google-Smtp-Source: AGHT+IEruytxR9BL+HNBSd/NfoQ9M+d1X+XJ4kW9Kd3kJNr04j3cPKnLo1htQAN7DL5PhvB2Vt1A0Q==
X-Received: by 2002:a17:902:f690:b0:202:47ca:fa1d with SMTP id d9443c01a7336-20247cafdd4mr34834745ad.50.1724069267993;
        Mon, 19 Aug 2024 05:07:47 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:923a:77c1:913c:bcb8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fab02sm61802005ad.48.2024.08.19.05.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:07:47 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	Pi-Hsun Shih <pihsun@chromium.org>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [RESEND PATCH v2 1/2] arm64: dts: mt8183: add dpi node to mt8183
Date: Mon, 19 Aug 2024 20:05:55 +0800
Message-ID: <20240819120735.1508789-1-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pi-Hsun Shih <pihsun@chromium.org>

Add dpi node to mt8183.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 267378fa46c0..266441e999f2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1836,6 +1836,17 @@ dsi0: dsi@14014000 {
 			phy-names = "dphy";
 		};
 
+		dpi0: dpi@14015000 {
+			compatible = "mediatek,mt8183-dpi";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_DPI_IF>,
+				 <&mmsys CLK_MM_DPI_MM>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL>;
+			clock-names = "pixel", "engine", "pll";
+		};
+
 		mutex: mutex@14016000 {
 			compatible = "mediatek,mt8183-disp-mutex";
 			reg = <0 0x14016000 0 0x1000>;
-- 
2.46.0.184.g6999bdac58-goog


