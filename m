Return-Path: <linux-kernel+bounces-389480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF09B6D94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61B11C215E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EC1E572F;
	Wed, 30 Oct 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWXwZcMR"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44119CC24;
	Wed, 30 Oct 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319928; cv=none; b=V6JNkMZsjcEThmfp8+3/+kwQFOUhMfLRjHBxqn385hg+4+MvBxqifmEhT23uFYiz70rICBBPqYNT8V/vV4EKO4vU9cOt6YDMuonJbAHmfwESFKP+p155ua08972E/CIXFKiGkk+D8XxJZFa+phk8PkcnKXwjaIsvimVsT7RY4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319928; c=relaxed/simple;
	bh=qR4ZD4xyvmDCe8Dmrh9vDH4pJM5PfIoOoeRxNCJrHms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrSwqhPq4Wx+HG+pa0X6oYmt0QkpsihRfBFbAL+GX74jjJpiOzuScczajIiYhqnDS7A55r0BelexJKXLp1QHRi27NNLWAcjjJA/oKWhqd4AuZTUYWqfeJrSstvY2q99H5Qt1NsAt3kpynz/nBjQn8fpvjMuy+OlzB5m3Ew9IBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWXwZcMR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539fe76e802so302814e87.1;
        Wed, 30 Oct 2024 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319925; x=1730924725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VZEJYFGFDY62qRZoKIua+9OCnTC0iVCsGRMn1XjbXk=;
        b=SWXwZcMRxB5GTxqFof9MpuYMM7T9RFF7vhsKQ8FKR9ZmHo9zd3TUSvhQAPr6G9vTQN
         gMYdLbTGA1wtM8Y+BJygCsJfPWGJ3Upm2YYLoAMSswpjkQKktPNKASyA+aSQMpSY6N/Q
         PgBpInhm5od20vPTcw7lJT8vtSgLUB8a07cDgOazSn3SYIoy/FQS2XL003rn+ay3NVKS
         m51I2mrB8SC2+LxW+Exk9rAcgyPxVX/NCc1HJ5m+/ra4crLne4jqO3esACoFhojPYbfo
         yvZuwJOvufHkZui3+TtnXEsmBWN3udUvFIpQNVO6BDqVrJMgrfqAZXHGih0F+Q0JIWmZ
         U+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319925; x=1730924725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VZEJYFGFDY62qRZoKIua+9OCnTC0iVCsGRMn1XjbXk=;
        b=DDIhlwOWgLJt1FAr8kCckIXH+rz56T47FzFJwFiHqkKmLgiwFpiOpIeVUgYZbBhEkG
         Pr5+uagLaE6q5wnxNvttkEN/Tvfs1qEbIr2KWF9KTo0QJ48otJPzePkbSvb6UxEzw+tO
         M/gMs+T5EoGfflSvUIhIkktcKsxqXc2NLpvpzz7GHGYwlIB89fbxjsdNjDKR4OaOBHKQ
         hhEmf5or/qp0RTywWPJbld69uxyOgXFyk4VjXLxcARtahJ+ic+NFVMfl9hyq7dz/psW9
         aW5OhkTIu3ux4CoXMYoiAEqlWfroskoTN3TxbziN4w4MIq0uRLBNboNV1q4kAStL9G7h
         mJxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8voBotjWqqtmgIRYVUIE3SjzPLtuXMFIYynCVjGclZAr15khGUTFFr1urpOEjHWWJ0mGlR5y0k5BCtBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4ffircIR9GVq5hh3TR9MDloKY4VnxtZXf7J0Si7gKQari+Un
	nTItmSADhEHS1tdscRzanbA8XhaqVSjHhWA8/NQqD7eNd8FXR2Eb
X-Google-Smtp-Source: AGHT+IFIcw2dRxHZtSFhC12hb+wqEBUhV/76DRIb86Ahh1Ta3GUBrb+6iZQphI2Zhhc56TKRJau+Pw==
X-Received: by 2002:a05:6512:3b8f:b0:539:d428:fbd1 with SMTP id 2adb3069b0e04-53b34a34bacmr9118824e87.55.1730319924336;
        Wed, 30 Oct 2024 13:25:24 -0700 (PDT)
Received: from localhost.localdomain ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d6ff10sm334644e87.269.2024.10.30.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:25:23 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Banana Pi P2 Pro board
Date: Thu, 31 Oct 2024 01:21:43 +0500
Message-ID: <20241030202144.629956-2-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030202144.629956-1-dmt.yashin@gmail.com>
References: <20241030202144.629956-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BBanana Pi P2 Pro is the SBC made by Shenzhen SINOVOIP based on
Rockchip RK3308.

Banana Pi P2 Pro features:
- Rockchip RK3308B-S
- DDR3 512 MB
- eMMC 8 GB
- 100M lan + onboard PoE
- 40 pin and 12 pin headers
- AP6256 BT + WIFI
- TF card slot
- 2x USB 2.0 (Type-C OTG and Type-A)
- Headphone jack

Add devicetree binding for Banana Pi P2 Pro.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1e3eceb266b7..c88a3981248b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1104,6 +1104,11 @@ properties:
           - const: rockchip,rk3568-evb1-v10
           - const: rockchip,rk3568
 
+      - description: Sinovoip RK3308 Banana Pi P2 Pro
+        items:
+          - const: sinovoip,rk3308-bpi-p2pro
+          - const: rockchip,rk3308
+
       - description: Sinovoip RK3568 Banana Pi R2 Pro
         items:
           - const: sinovoip,rk3568-bpi-r2pro
-- 
2.39.5


