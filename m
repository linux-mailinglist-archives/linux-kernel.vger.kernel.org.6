Return-Path: <linux-kernel+bounces-335971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6897ED55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AC281B11
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2819CC36;
	Mon, 23 Sep 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="Hl01RO80"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C77DA7D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102860; cv=none; b=l7x0rIJkRtUCpCl99XSLrkCQEjDDjwy9JrGFIoJewQb3D5W4V6dGjlnRkHt3xnSikkbV2+B29DR24sIq7rPXVHbRLYKd4xt75Hr9/MZDGeGfMo3lddbHRx5oNtQMQvD9iHN4u3YT6uaXeNUTr2gCITJ7Ils7f41EP06Fnufd75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102860; c=relaxed/simple;
	bh=4xOmHPRWCNA4rm8kugTZPG9onTyqHhinxOqer09fNpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcRP5V6QNnGvr5TR3d/qa2hjtsGxoWuyBtl1KaxxFHO8RQoOJq/uWdl7HAlXjqQXDKv8Yt+mfnz4m9Oq/AS+V9gudhgMg0lXx1kc3/RatLv5FtO/40iaBM/GJsePTKoeIv/OB/Vv+s/P+EjxBYKqYjUfJSQeL4CRBzcj4VWH/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=Hl01RO80; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d91eef2eso2815938b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1727102858; x=1727707658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1pOvFlUWHq7/p7TdIR1C+iDmXhaSnb5086tRuytuw=;
        b=Hl01RO80FMM6kPgijNDoOR6UNS/FDIO6leaOU4yLXIL968XRb+h2syAgo8BHs0Ypar
         9pe1mALTvAIJKk/zqmGT5+Sa+hSvwlqEAy2A9WAyYbCSEZAGuFwK01pm4UZ6F1vi9fOQ
         oCtxO3faBRE+BfJholS1vOAB5xPBhdPl+e1L27VDTkpXCxL/cQ6stbyq1ukUM1uROd85
         XWJ9DiKkxjor4pzCULgb8LNrptrmVz7cgPmZcnCtNBExbcv/gnGaFo6xO7qbLnsDUZuG
         tkvnI3IJZaY7NM+1r6hVoRmFEdhmICWzZyjOAA0C6iEshTR1o/Gkk7KxNDETZfZ+4dye
         zaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102858; x=1727707658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah1pOvFlUWHq7/p7TdIR1C+iDmXhaSnb5086tRuytuw=;
        b=ms7Y9Qi17jbqphQWBTUACGXP0N5aI/Hrg8d0i35YyJAQr7seWNem8Mal1AqTesV4iC
         1PMBkuRGLz7kUGQbcmeEsbxbU6yj34TIPE24MqQJw2qTXVqODlPrTgt06fdWIV5PmVoj
         bnmm/BjEj23JYEzVmmBSEEL8EmO8hHUjJq/7GUnnGUn+an2lo1hZsaZfFAK1kl3G1CnC
         d51lneDRfU3AqBtYQXUk1lskLBaevpI7inf8mhZlf5XV97uvWUe1ZWewdVKUipmemq6F
         o3XAUq6Ww3oNDSqNUYXVHP1DeLYeYrakJ6/jjUV8h8qk4HfuKJ620CbCqnmXGPZtXHw5
         tQow==
X-Gm-Message-State: AOJu0Yx5lGsCvjTexLSlpimETPlndsH2JKC6O5oUdmXg3MfC/p6jrToL
	VpTELKbyBfnNNm/6VNU66Lg9dgzqwOpYsBhUpFWXH9P7R/dpImHcT3z2fEmCuNhYAeYwwxdpAj4
	D
X-Google-Smtp-Source: AGHT+IGnzbB8vGG9Sm8T5RN6ljJ6BCzgDbeKgiBqIATXey8B3rBl6Yt3vZdISaSG9UHRAnN3Jn9N7g==
X-Received: by 2002:a05:6a00:4b0d:b0:719:24a3:2a8b with SMTP id d2e1a72fcca58-7199b14832amr16818922b3a.12.1727102858079;
        Mon, 23 Sep 2024 07:47:38 -0700 (PDT)
Received: from maxweng-Latitude-7410.. (2001-b011-6c08-d055-c470-c180-5435-2e25.dynamic-ip6.hinet.net. [2001:b011:6c08:d055:c470:c180:5435:2e25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a974dcsm13991122b3a.32.2024.09.23.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:47:37 -0700 (PDT)
From: Max Weng <max_weng@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: max_weng@compal.corp-partner.google.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] arm64: dts: mediatek: mt8186: add FHCTL node
Date: Mon, 23 Sep 2024 22:47:28 +0800
Message-Id: <20240923144728.870285-1-max_weng@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: max_weng <max_weng@compal.corp-partner.google.com>

add FHCTL device node for Frequency Hopping and Spread Spectrum clock function.

Change-Id: I7f9f2991978df7d5d3a6a8bc78f6f443f2f0460d
Signed-off-by: Max Weng <max_weng@compal.corp-partner.google.com>
---
 Change frome v1 to v2
 * Modify the commit description
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 148c332018b0..d3c3c2a40adc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -29,6 +29,13 @@ aliases {
 		rdma1 = &rdma1;
 	};
 
+	fhctl: fhctl@1000ce00 {
+		compatible = "mediatek,mt8186-fhctl";
+		clocks = <&apmixedsys CLK_APMIXED_TVDPLL>;
+		reg = <0 0x1000ce00 0 0x200>;
+		status = "disabled";
+	};
+
 	cci: cci {
 		compatible = "mediatek,mt8186-cci";
 		clocks = <&mcusys CLK_MCU_ARMPLL_BUS_SEL>,
-- 
2.34.1


