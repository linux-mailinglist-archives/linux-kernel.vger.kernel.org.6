Return-Path: <linux-kernel+bounces-443419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909C9EEF55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E812958AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF8243B6E;
	Thu, 12 Dec 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtUHQHDY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAE229694
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019254; cv=none; b=K4k4yeZyxDT6IVJFLc0wQACgfaXi+yHAtk77zUWTeUV38vOBcBDYOIg5tECIfnbjROBJiF/SEgiBtZB7FxND8Vyyv9I4rhYdUsGcQ8AfPDs4VVeaZHF2eFj2PAHVheMbXkJXafjM1VcAjNlerfUE/RDC1ymS23zw8zIwpXhtnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019254; c=relaxed/simple;
	bh=XbnGi70yp2CGKe3dsPZc/woxkOlnLt94ojsF7pP5ut8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPt0cvBlP2tJE+FpqxvsONtzayegDr+833BfzNiyUZprYfDPKOTaIR+cv329XooajeX0XIGwHNeAai2UgzBQC4lKETnTbZnhDraySFHQy+zuvOBlkQV299e/uYgfltnky01bU8iXijnSgFuUyZWmZ6BehQez1/nyJWEx8Hf2r5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtUHQHDY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434ab114753so5646505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734019251; x=1734624051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHOVK7hLZe7Wh/344MswWZk1I6BpgHguWKa4xSWa9kM=;
        b=AtUHQHDYxAhsTS+M9GJx1PRQr/B4qDxDU+IUus3xXQebn77blZx0R3kMFfHB9IgrFt
         r1W7Gym+Gj3djWrrgxKKu7LbNGw3hU+BCOvxNMfkqfNdNe08YQSfDT7qp/55wkZzkTN+
         k0DDahcn4Tdy+aRGHfQH9/dBlalqJy8+V4eNe/5HLr5fOHHva3BxWaJ3T8L1JBeX53At
         75uMfsYeOrE6C2qRZbqZmhr2LpasOAVayvZJcKBWQZpXiJLM3yWLZ29gd3zmy3FOsbJk
         AcDz7+28BFFZvO+AqlY+coJgl4hwughobwtaa8gUbGK2705qcwxpudsmH9etmUgy1Tor
         gxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019251; x=1734624051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHOVK7hLZe7Wh/344MswWZk1I6BpgHguWKa4xSWa9kM=;
        b=HAz6c1IoxH95oeKXJsH+eFgheGrE9ZOBFc1v2L7MnuGx26iT00SZFvITAMeYadF4gK
         JMnB/QcXQTjo0GQG27GAzAW+Kv6Rnz6CTIZRBrgg2TVBb1IUuWW4NbPA9By/Djog7kb3
         olsjSXOGwUEvBIL8EEdiee2XnZ3rG7zKIuUr8EwXE68fZaux8awFcN/1OFSatz/zNZmj
         NDs5Xd8ttli69W0o+mq1NQHNka4S+BU2mxUevKYP/rKmpcktJHPj0J3V8Ql5DuNOEkNc
         pz6hg3pWPhevS1hOpppnFJQR+syL3mjJ0gh29yVtJjuUSFHSq0DCTZLBE1emFtBClBin
         e9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUpLdSFGeGOBBE0RATpFBlshfVKjbGPggu6HZf/v6GCOInWWYX03SYe6c8tyAfT3aMt6D1X09IHa6/bPpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWkunUHQU5f/5EydxRW2sXTtZnWG9Qjb39htfKUMIfAeyCn/O
	2x+K4LJXBjtFc84CuWMHzHdh1fIUqt51tDAqpCpjkdUgnHvmhhUkmMuVBpQjzhU=
X-Gm-Gg: ASbGncuiOWyjYa78JGjkT7+J1rxEaviya2Kclfwg2e5grQI8w6dePyt4c41FQqq/bKY
	83cPxrn6Zc8E7Yk7wZiMcQS4zs9xg835nR81vK4bbCAtEYdEWi9Oxrbt8riIbAcrhDs2WoIowl8
	Fea+G9wwUPfj0UBe3r14zYObSIEMDAKSaz2EYMLvUGQPNIO5QxCII0mzezrWTwdHaGOwypOjhv2
	qwnoc5VB3N9l+fGUZp7uKq4beYqEIQ/7xS201/MKLBs2HvGA2Eg/aRJX5pS1dj2TooWiebNfUlA
	eZpN/ftSPGJHSwj4Uu10NFE6uIMmxOQG+A==
X-Google-Smtp-Source: AGHT+IFlK2IZ26AyokS8CKojybaVhLvxESDWWONU+RNmiG7Oe5YQFYwn5cnnv2vcSKdLM5Z3BlTwtQ==
X-Received: by 2002:a05:6000:2ae:b0:386:4a16:dad7 with SMTP id ffacd0b85a97d-3864ce495c9mr7671034f8f.10.1734019250289;
        Thu, 12 Dec 2024 08:00:50 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d35sm4462941f8f.74.2024.12.12.08.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:00:49 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 12 Dec 2024 16:00:40 +0000
Subject: [PATCH v2 3/4] arm64: dts: exynos: gs101: add ACPM protocol node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-b4-acpm-v4-upstream-dts-v2-3-91b7a6f6d0b0@linaro.org>
References: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
In-Reply-To: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734019247; l=1371;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=XbnGi70yp2CGKe3dsPZc/woxkOlnLt94ojsF7pP5ut8=;
 b=6Wl14vGUhIl14sU0fLxYuasLnwizMnpBV5iAByDdT3MnW5mXwH8MpxKGJEZzeAVdW7DCLd8pW
 2kFiuaCUJuwCk2Ic62bVSRZuULxkx7xGKuE0/uFY1uEUXnBwY8i7iw5
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add the ACPM protocol node. ACPM protocol provides interface for all
the client drivers making use of the features offered by the
Active Power Management (APM) module.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 04561e15b96c..8c3f07371912 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -277,6 +277,28 @@ apm_sram: sram@2039000 {
 		ranges = <0x0 0x0 0x2039000 0x40000>;
 	};
 
+	firmware {
+		acpm_ipc: power-management {
+			compatible = "google,gs101-acpm-ipc";
+			mboxes = <&ap2apm_mailbox 0 0
+				  &ap2apm_mailbox 0 1
+				  &ap2apm_mailbox 0 2
+				  &ap2apm_mailbox 0 3
+				  &ap2apm_mailbox 0 4
+				  &ap2apm_mailbox 0 5
+				  &ap2apm_mailbox 0 6
+				  &ap2apm_mailbox 0 7
+				  &ap2apm_mailbox 0 8
+				  &ap2apm_mailbox 0 9
+				  &ap2apm_mailbox 0 10
+				  &ap2apm_mailbox 0 11
+				  &ap2apm_mailbox 0 12
+				  &ap2apm_mailbox 0 13
+				  &ap2apm_mailbox 0 14>;
+			shmem = <&apm_sram>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;

-- 
2.47.0.338.g60cca15819-goog


