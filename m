Return-Path: <linux-kernel+bounces-187120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A849F8CCD72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6036A282FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390C13E04E;
	Thu, 23 May 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FAWxKYbB"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151C13D500
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450874; cv=none; b=VPKYRLoE2hhd8tIdk84LW408522kNJVa/OxMWZyq3BeWZmC39u0N74P6CHbpZSInltV9zCEqkqHpenUD9Y3OO5pJKPpzGnrONKhLoBhFXjBJUjn26fuqk5YiN0pYLBLou9dl9zG7HH8lQZSXXxZds03TyGvav7jfohQ+xfMF8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450874; c=relaxed/simple;
	bh=EBn95oZYJBuKE7wbNSUlYqgJ3DNNnfrc/sMkkpKiyYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/5CRRMfTDB+QFe8ik5y3CqC+SpCaDjNrg39U0JXC1lcc/ENqPf+Qs89hk7Hm0G4Iita5EnH9bQ91nnYg8CqRV0UVEHoZ9bbMct0RcaFSlH6eQIbKumEJcQ84btViCB7gSJKKan+qJtJagCx1ts6pTz8xSghAVkEKbK+bigccLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FAWxKYbB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so699545f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450871; x=1717055671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs95lBC/TcgC4HuVf1dVMWZC1dwKXurnxylDtWkEO30=;
        b=FAWxKYbBBHrb10okho6w4NrO9ZfsKTcmSIIt3LccRcld6AzKL4IdRgouRjRi+sZUow
         Q6beG7T2FpGdFHBp1cXYIMdFr5SeXdk1nSMlnWSc5xYI+/5Jbyc5dUW7mKuuvDHFUCDR
         SzhAUv1TgeQY0iAgLG2AaNMH9+a6k6g7ShKTbeKIp9yoN5Gl5fVvUP1HN1ilS5slce2G
         czxcJgMdjBkdSUVvJ7QlBEzDATVr9Zxa+VgeFLPxPcAnx0ti9ZSfPm/8r+nV81pI1l0R
         1oCm7HZqSPMAevGIFsXLBOlCBAQrqc4Wfjeb8QYve3cMMMgDs1anMyGzykXMZ1Vp47nc
         YUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450871; x=1717055671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs95lBC/TcgC4HuVf1dVMWZC1dwKXurnxylDtWkEO30=;
        b=qCnKZywpHAGcpEKZFgzLS69z3ZA1+EFETDtMM2Xe0fJe4Vd2aUbnFR7i883ggk9RsT
         9zMDgDkHAXPPV//TjPl9DD50OPtzzw1Lr2McZGFitVGaL5cTo3mW3i7p1lJk0J72frQU
         JOVFiYjbiHAMttLxrxkG9L1jvsK6sqMxc1WRHvCCwKojURnQLfu6cjVsrVvpv/YoHqmk
         O+m0fV8ar3NXBFAoiOOzjjrnbcCWy0YQt0hmCrqXkrIpGyTQAzC3ziHyIm/2RMRI6q/l
         jiCLSgvPxsi8crQsepHWwtC9LPhP5e7LK9X2kHjJzSvegmiK+7XqSysSIh66XUiYp1P5
         Aakw==
X-Forwarded-Encrypted: i=1; AJvYcCUvYtnJlJxaDVpZFOCzhAhL0AqIeEdluh1qdGFZ7BIPAv/X2/wVqxgeHo6hkwSyyMcpdmybq1jOZUaq+OelwNgxK95d8K/A+an+RgXp
X-Gm-Message-State: AOJu0Yx7SkpOUF/wBhvs+ZylFiEt9jiHqP5OJm0ytbDxxMot7cNfWS2+
	IvkwkeSQRRifbvBhPFtRQOf8SKsKKtKGdZQG2x1fbQ082uMhZwqHLxAA5LaWmjI=
X-Google-Smtp-Source: AGHT+IG7YTkLUSffWTrDruzFzrKP7L50CGiVA7fCsGK/KJwutYO0L6Mt4f2SRF1jo89ocb1d3uWezw==
X-Received: by 2002:a5d:6e09:0:b0:349:d810:9974 with SMTP id ffacd0b85a97d-354d8cf9050mr2859963f8f.17.1716450871014;
        Thu, 23 May 2024 00:54:31 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:30 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 6/7] arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source
Date: Thu, 23 May 2024 09:53:46 +0200
Message-ID: <20240523075347.1282395-7-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075347.1282395-1-msp@baylibre.com>
References: <20240523075347.1282395-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 8c36e56f4138..f0f6b7650233 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -153,6 +153,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -165,6 +166,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 };
-- 
2.43.0


