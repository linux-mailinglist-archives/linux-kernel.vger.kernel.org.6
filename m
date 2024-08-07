Return-Path: <linux-kernel+bounces-277119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC2949CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7771F2459E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB555E093;
	Wed,  7 Aug 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uHoFUd5B"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E453EA9A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990713; cv=none; b=mkl3gz1clkGAIQoQlwqVKdi9APtdY/7bFHmKA52k+42CO5o3YT6vYsAQXQMXOkEJrZIyF/iP1nwn8MIAZhITGimowDN0wsj846LTKlM4ipIsE3wbs5iHaFSjoVBFxsKMO9oAjCG+1wecZ0foTMYOvOaGGdgKYoXwAfwzaHcGUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990713; c=relaxed/simple;
	bh=twijwVNwXlRnqiWorC6lSyhzIHtshmEdOl4sTIAcK5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qH9V3IZVX4DoHXON9wOOpfWPUmNKyhkWGN3Y06q2sQ/fnBqGdfvv241OuB08miWr3hXs+svTinRZ6R8GvVmYmmSIe5UfaDMwcIxCgXxD6ZJR0XLyn5HrQGuqFtKyyPw4P6Dvgr9bXDhIOwywDQVJ7DACVE5tSfi8sVpkRRWL+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uHoFUd5B; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14339fb0so777552b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722990711; x=1723595511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34tWDw4L8SN+akOs9Do5H0mwwhItc2hNKASWAYLthDo=;
        b=uHoFUd5BwiprbVyGdXFmz8VtI5RnOoy+HvBnRBfVXDbNn1k95HROP4F4nVvlEErijJ
         33LmzbbE+ogqyqLTJ2Ufcysej3vktrlxkp6WUGSh7OoG0WqbXuiF/rSVui/TiH8yzE9z
         COiGPV9/krShrRpdtscWVLlTB3BnFLXC/MVbkME2mKYrkYTmiZsf72Bso5vWZzMro3Cv
         1iZJAiR1Qg4s2Rx3ucbhzqCW+1g6Vrkn4hbVEUodGARoSA+Kw8Q3d0GsoQ9JpQWWKPrV
         Hln/0PgnlSu5IUdB/ZR2zo6tj2pgZtVtRIsdP33sFMUibPkD+v8OSMZm6bMY9bCR0AqB
         4PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722990711; x=1723595511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34tWDw4L8SN+akOs9Do5H0mwwhItc2hNKASWAYLthDo=;
        b=CwXH3EqczyGxOxFgVaTzUNAd7bHUO84rNawz2HDt69f6q9eZXVg+Ob+HVrZKKvaiUs
         4meFxSwF8JTlnn4a1Z0bsvni9gaMpHwAjCo1aEX8UM8bv56jaCyopgH8rrR3AkZMljn+
         jjAP+uUAtlvyv9vMQH38wB55DkDdSDfL7iWDWH7XXEb5Aa6MqT2r+fiSk0RMoyPpBb8e
         tQxYE60mbbKpuGxicdwOnlR7FiCUIouX8Pj5ePyEtb0BJnDiDMEIYbvn8GxJ14d5UTtL
         GAnKyF4b9KpmFTvhATXwlKtwrEJaEvfA8PFmQv8qtQ3zdXpiO4VH7vQbeX1dNqO9dgEV
         mwRg==
X-Forwarded-Encrypted: i=1; AJvYcCVHxLl+BTL7PzIa5jm2zeiGz7sxCAGVr3F6/uko4VGU46vh313TKw+DzLTXymtw6dAs/JNgIw24lUqO5hlEI1n2dyC5QzdLzMuNJGN5
X-Gm-Message-State: AOJu0YwmhNLJ0DAiYsafxkIN8nqVV489rTCTZ3RNd3dRE+k4oaAcxYRI
	4XSlemGepYz7hczlFnKcXuMJtxToqGu2D4ubrrw0iGR601hiRiRqn3hO2PXNaOE=
X-Google-Smtp-Source: AGHT+IHwYGXcB8IEkAHupmpVK0nhVZhhoMXREywsV/hko3tnE1IuMh1Xx52utwzABh32nak18wgz7Q==
X-Received: by 2002:a05:6870:639f:b0:25e:129c:2223 with SMTP id 586e51a60fabf-26891b1d159mr21444778fac.19.1722990709937;
        Tue, 06 Aug 2024 17:31:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm7476174a12.6.2024.08.06.17.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:31:49 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 06 Aug 2024 17:31:39 -0700
Subject: [PATCH v9 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-xtheadvector-v9-3-62a56d2da5d0@rivosinc.com>
References: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
In-Reply-To: <20240806-xtheadvector-v9-0-62a56d2da5d0@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722990701; l=960;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=twijwVNwXlRnqiWorC6lSyhzIHtshmEdOl4sTIAcK5Q=;
 b=8DznulBYmzcnRUsTl4PU1Nfrq9DX3CsK4UyIPn+bOSuqD+WxzqyupxoffPAdmO9Cn/UjtYnuL
 m95rcERBaneBI+ZYTnjfNE+sqBlPjvW4j5RZ2+DHqV9e0OsJAzGlQtx
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The D1/D1s SoCs support xtheadvector so it can be included in the
devicetree. Also include vlenb for the cpu.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6cbe0..6367112e614a 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -27,7 +27,8 @@ cpu0: cpu@0 {
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
+					       "zifencei", "zihpm", "xtheadvector";
+			thead,vlenb = <128>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {

-- 
2.45.0


