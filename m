Return-Path: <linux-kernel+bounces-174416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0888C0E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A090B1C20F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54F12F37C;
	Thu,  9 May 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWuTFvrq"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5B322E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251678; cv=none; b=DnkWqulytge0GmJ/3KEB1KGMauDwwoHjgX9/Ben2NvuXXFQ2xszmDAF7ZLasVkWUPy7ex10cbPr7/V1y02VrMel6ys1J9nKol9aMeoVcjnwHijgCAtrAXm8V8o6i8qyu7bd3HLwbGnCxCUXrCpcxWDBzLad3O2d5miw2kzfQxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251678; c=relaxed/simple;
	bh=OQni8xvnYy9WGLxuioB/twwX1etnlijk5yX08S2h+Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQH86h8dxe/LsUI2l8f2M6DIT62s+q9DIJBrpRdbXflO502O0ShOrEaVOZ1OCYHoTVTJWR3mfGN27Nbp/92aq3hcRd7HsYO8aCpJp1MU50PwQDhAbxwyLokxbjxTGgES0FyoHgnYQp+53bi0SSMvekMEzrta8Fjewg0FkA4kyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dWuTFvrq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso178488766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251675; x=1715856475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FR+x8sKExGfyELSBtCHiRo7zGgjRFCGjuQW294Rt+84=;
        b=dWuTFvrqOaHm4EOefjAct63wRausS/vS0xBZ01eIbZ8Y7LI2B/ewqQsusYxZAr0W5f
         Nq9XXJ+J5prbW6Gnjy7L+BvIsUVXpXKWbP4EReI5RpYirzfbsL3anIoU7FD8GZVxhGdG
         zSq+yO6rv1CtfGsl9tMiN0p5FQ3tikyKrt4QkfEzJmCxYEjAIQgi7g48yPsDEtt0+4Z0
         EQGwqBhopoYmfsyAhhOER+konyKDCgTJbVhBIMslJZ82OTHIq2Hf9Z+1YEd/12iYfVDs
         8Y2EMmYukQWihWvEoEWorm6iKy8gmYvMeoc3wVX/a4airHXTrMzNR3i4DG7c76IjcsSo
         5WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251675; x=1715856475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FR+x8sKExGfyELSBtCHiRo7zGgjRFCGjuQW294Rt+84=;
        b=UGTbJjkH5k7m41Lpsqd6vKF3XI8QgUJWjYnaQje2hzHYF4DQRupbuwygKdkr3z+BcA
         fzyNeJS2WElCMWIDZb9jFGhyfDKJpeOL4De3VvUe+yE7KRPwgfNxPU8puUCvwmH6ROoO
         ZZkDGwrXViVxSbFMfmBReL+8BWgLtfUUtsfO+gkCXHcoidf2eUnllBFoSgWbnJOPh9OG
         W28dbL777Bki+oKzWUkPQx3WcdLMTROp7eGkxPd+0HANP3y5gHf8q1hzhaBS1aHpbPUZ
         NJoiQln6NKE74xTHspmuhwI9LIX1w1p1InOQBw04LzU5yOeGInHA0iHpK39rK61AQRxf
         hoWw==
X-Forwarded-Encrypted: i=1; AJvYcCVSQjkwwQPNyaNvg7Za8mqgOklUSFR+E7e36k/d9M/ROtgVELqw4cuTTOWDuFRzjKfAmUl8ZXRK2W4yd2/6MLKMdzL//ZBRy3LcH5hS
X-Gm-Message-State: AOJu0YzWqvAzjYxfq+5FEBJf7IDSQQJjHeV+dZARj+q3N55dpHUJF3Fa
	hhw0BKZkwEiFKo2ERrQ9dz5DMp57Rjjy7QYy8dWefgSoKztdxna1jSJFQpMkL9ww9oqBElNAoaT
	i
X-Google-Smtp-Source: AGHT+IE2edGeC5X3qKaBM4AttahM0ZV4LqNcNkCLMrXATw1Lh+N+0G/Wq2ZQZT8l7qjwdwAJ0EegoA==
X-Received: by 2002:a17:906:455a:b0:a59:ccb9:846d with SMTP id a640c23a62f3a-a59fb95d605mr322034766b.37.1715251675192;
        Thu, 09 May 2024 03:47:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fc4sm60588666b.135.2024.05.09.03.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:47:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: vt8500: align panel timings node name with dtschema
Date: Thu,  9 May 2024 12:47:49 +0200
Message-ID: <20240509104749.216605-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT schema expects panel timings node to follow certain pattern,
dtbs_check warnings:

  vt8500-bv07.dtb: display-timings: '800x480' does not match any of the regexes: '^timing', 'pinctrl-[0-9]+'

Linux drivers do not care about node name, so this should not have
effect on Linux.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/vt8500/vt8500-bv07.dts  | 2 +-
 arch/arm/boot/dts/vt8500/wm8505-ref.dts   | 2 +-
 arch/arm/boot/dts/vt8500/wm8650-mid.dts   | 2 +-
 arch/arm/boot/dts/vt8500/wm8850-w70v2.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/vt8500/vt8500-bv07.dts b/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
index e9f55bd30bd4..38a2da5e2c5d 100644
--- a/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
+++ b/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
@@ -16,7 +16,7 @@ &fb {
 	bits-per-pixel = <16>;
 	display-timings {
 		native-mode = <&timing0>;
-		timing0: 800x480 {
+		timing0: timing-800x480 {
 			clock-frequency = <0>; /* unused but required */
 			hactive = <800>;
 			vactive = <480>;
diff --git a/arch/arm/boot/dts/vt8500/wm8505-ref.dts b/arch/arm/boot/dts/vt8500/wm8505-ref.dts
index 2d77c087676e..8ce9e2ef0a81 100644
--- a/arch/arm/boot/dts/vt8500/wm8505-ref.dts
+++ b/arch/arm/boot/dts/vt8500/wm8505-ref.dts
@@ -16,7 +16,7 @@ &fb {
 	bits-per-pixel = <32>;
 	display-timings {
 		native-mode = <&timing0>;
-		timing0: 800x480 {
+		timing0: timing-800x480 {
 			clock-frequency = <0>; /* unused but required */
 			hactive = <800>;
 			vactive = <480>;
diff --git a/arch/arm/boot/dts/vt8500/wm8650-mid.dts b/arch/arm/boot/dts/vt8500/wm8650-mid.dts
index f6a42149a0a0..7977b6c1e8eb 100644
--- a/arch/arm/boot/dts/vt8500/wm8650-mid.dts
+++ b/arch/arm/boot/dts/vt8500/wm8650-mid.dts
@@ -17,7 +17,7 @@ &fb {
 
 	display-timings {
 		native-mode = <&timing0>;
-		timing0: 800x480 {
+		timing0: timing-800x480 {
 			clock-frequency = <0>; /* unused but required */
 			hactive = <800>;
 			vactive = <480>;
diff --git a/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts b/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
index c7a6fe0ce48f..5d409323b10c 100644
--- a/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
@@ -28,7 +28,7 @@ &fb {
 	bits-per-pixel = <16>;
 	display-timings {
 		native-mode = <&timing0>;
-		timing0: 800x480 {
+		timing0: timing-800x480 {
 			clock-frequency = <0>; /* unused but required */
 			hactive = <800>;
 			vactive = <480>;
-- 
2.43.0


