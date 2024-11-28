Return-Path: <linux-kernel+bounces-424828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CC9DB9F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1982281508
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE31BFE01;
	Thu, 28 Nov 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aH1k8Vg3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF91B3940
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805518; cv=none; b=GcNoeuXAt1gVQcrrbWqMS+wz5ubdTwyy1GSf+3eHrpVe7j6s80QdN1T7KMTsL9uIMs3g2pWKcGJ11c/5ZnK7KTrSREMBTZ8OHYoLV30Pog2SmXZWc1QqJ5srmFf4JPH9CtsNZ5LZmxQzwnFsYD53+IhbA+tKz9ITOmYJuDpYXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805518; c=relaxed/simple;
	bh=iONE0HKU0IqL9O9ShumEXpebGnA8RIwvd+IgFAfUlXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaf5bttR1sXeIq0S3BRmvGM6kyY7qssDV8pNL9YJ36BjRIhvbnP+Oyy0Cs8kgbiBBOE7M6AqZO89JB3afAXgB/t06s2MOt1hsqtxvwkPN3Pw4JJH881W9gk2plDwBkmRIsq46T12UC8VLncInGlNERvDrBC5zb6+KYXmk6tI8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aH1k8Vg3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7251ce598adso651982b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732805516; x=1733410316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/MXPQzhJ+NbcczEaxmCbcj8MjpwS3qOOhKqFULBuO8=;
        b=aH1k8Vg3LzRPvjv+t4OKpUkxmLT3zHCy3vtqri31hXcXWxvwuJf/n5tFhXkpO1YIJI
         dt0JtRorKg3ESrqVKNtm9RqY6zMG2ng/dcQoBP0Wr2YR4tydOdW5uPusd1O5Q8TZIAKB
         8TwY2a+nVzR3Oovo1ugFcEL6cYcnKqLUC7BwAZwgdpLPmtC+fv8AyxeuiuzaUXj1Ots/
         rNl1XMTyUL6H105H3hWu4NuKf6TK10wwhlAfz4kLLoKGJM5+UyLqHlRgfFp5OKrzjfoa
         Y33lfUMpYsSElcJskMaejwReI+tMSAm7kFARrZK/HjiQhPoJ+r6QXzo3OlvZpFXX5mvh
         gVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732805516; x=1733410316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/MXPQzhJ+NbcczEaxmCbcj8MjpwS3qOOhKqFULBuO8=;
        b=rZvqKehAj89pKaa8oNT4Azxvp/SdFJEvWU6Bs0lTOLP/NHhl59ISvdl8484EIphdzY
         Wsb7s0ONx8w1JwZsyLaqSyETUf9l5XxEBgG0RNIlmV+pDs5Z886yvpEj0SHPMYXTBSNi
         Qzq0uICra+r2FOzFC2OevmMFd7EmcakxvWFOPtMOMI2seGxM+a33vc1Vpu+mHGoVW/oP
         WRs+U2hFHYFaugJ+bUt9xfyyaAnNrZT1MyJw4x/R5PwowMrjIUJrxhrApYWC2xBe8lx6
         id2RK6V2JWDdhzh+nnw/vVgbKNNXX0VMLO+hjDz32bGpaegVQhqEcVF1xgBVJqqAJpDi
         BWnw==
X-Forwarded-Encrypted: i=1; AJvYcCVABVGZIpj2Jkjl6/p1lODL+IeVPiFOIlW1Ehqt0UnR9rC5ip6ilR9iS3UsVcOuDQyUxHUHaU2D1UC1LvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gqcPReBvTeo7eNNfa85bjJfDPM6dIrHFFCVyfZ1seQZyZOuJ
	eAm6+TgCUWzqd6b1Q3+k6ZUctoTG1XjXPqzJOfAuN8qzlAeGn33eGCgT/zWhSw==
X-Gm-Gg: ASbGnctXiBUiqdoAJ734iqJBjTY67FDZ8/zxpn2DfEXc3aVT5NvGoZjs3pDNn3E74nY
	xcJMt36EvtqtdzXHWYUqyTBPFtNQgCqevpPgmhARWlLOc7MvBrOpRcLmAK11zcaSUPCSq7Kp9ra
	rWwMHb15yUx3yGJFsgQBqFRcV9j1h1XHUqDEeEuvPefmW1sVCVx2LZjr2ul+UY4MhVV00txI+AC
	pnXWOVF2FhU+RSWEeUPOvBPniAiWVAjsBn03KDmLCxx3phkYeghVxApFnBOidlASkyNkrUKV4xg
	Qw==
X-Google-Smtp-Source: AGHT+IE94xRezL0R5MUb1CgWVQ85Hdjg7x8RVESl+SHCpYNTjmiYjyLuD+1yP71Qqn42MFKmXZk5NQ==
X-Received: by 2002:a05:6a00:1c8d:b0:725:3bd4:9b54 with SMTP id d2e1a72fcca58-7253bd49c20mr7408782b3a.2.1732805515839;
        Thu, 28 Nov 2024 06:51:55 -0800 (PST)
Received: from localhost.localdomain ([117.213.97.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f76dsm1660418b3a.68.2024.11.28.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:51:55 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sa8775p: Fix the size of 'addr_space' regions
Date: Thu, 28 Nov 2024 20:21:47 +0530
Message-Id: <20241128145147.145618-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For both the controller instances, size of the 'addr_space' region should
be 0x1fe00000 as per the hardware memory layout.

Otherwise, endpoint drivers cannot request even reasonable BAR size of 1MB.

Cc: stable@vger.kernel.org # 6.11
Fixes: c5f5de8434ec ("arm64: dts: qcom: sa8775p: Add ep pcie1 controller node")
Fixes: 1924f5518224 ("arm64: dts: qcom: sa8775p: Add ep pcie0 controller node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index e8dbc8d820a6..320a94dcac5c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -5587,7 +5587,7 @@ pcie0_ep: pcie-ep@1c00000 {
 		      <0x0 0x40000000 0x0 0xf20>,
 		      <0x0 0x40000f20 0x0 0xa8>,
 		      <0x0 0x40001000 0x0 0x4000>,
-		      <0x0 0x40200000 0x0 0x100000>,
+		      <0x0 0x40200000 0x0 0x1fe00000>,
 		      <0x0 0x01c03000 0x0 0x1000>,
 		      <0x0 0x40005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
@@ -5744,7 +5744,7 @@ pcie1_ep: pcie-ep@1c10000 {
 		      <0x0 0x60000000 0x0 0xf20>,
 		      <0x0 0x60000f20 0x0 0xa8>,
 		      <0x0 0x60001000 0x0 0x4000>,
-		      <0x0 0x60200000 0x0 0x100000>,
+		      <0x0 0x60200000 0x0 0x1fe00000>,
 		      <0x0 0x01c13000 0x0 0x1000>,
 		      <0x0 0x60005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
-- 
2.25.1


