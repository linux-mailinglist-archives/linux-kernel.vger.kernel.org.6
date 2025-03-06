Return-Path: <linux-kernel+bounces-548648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DFA5477E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099387A7B75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEA204F63;
	Thu,  6 Mar 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVZ3ZZcg"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2F201001
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256094; cv=none; b=hri/6CH92YJmzebrx43zGhze/+W56z2JsyEI9z9cxaTMJlHC0jf5a+pxxh+IXLBgnWSxl3OC48kGR7daSGKkDgoskwW1tHEYSNwU+c64//kW7h7LZM5Vpn2cIYiuNF9BVXH8SDU8SiOHltE4iFsGg+9wcAWdreIIKoHymagbeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256094; c=relaxed/simple;
	bh=HrF03on0qzdxjsULol9VxljBccJbl3EpYmHoNX4Y8BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEOJzqti4kLckh8XVTfit2rz09i4lmLIyTjwJ6EHSFGOTfDdyFbM86eWZXPUZ+yMCVYFc/gAGXf7lrYYsBcHo3ykuYvoZvDOe/FKcQgxp6dryjEODF2bUm/lZ1sT6Nasr7gVnaA7MZo2ZuDK00dAToMkMJVULfQy6EPSSbw8Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVZ3ZZcg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so618644a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741256091; x=1741860891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77LEyUB5P/fKu/IBcJvd+QCzhbabA9R1jqKDuYpByGA=;
        b=XVZ3ZZcgHJM7GAfaLtEgCz83tZFIU9buYn8uk42N0WTVso0gW59GaOAy88NMmjXYyz
         L3Y+WXX0uHkopC7eQ/NVJXsJaxkEYnFe5w3453ipybcjuoaVr1kXPmY3/+z0zPUB8BZg
         PpxVEGYyQPsF8r6Q7Penz63QOjp3tfeIFOwE0q74I+mYDE6xZVnnEAfHdy7KohHzybV5
         M1Px/dVNmLKs8o+SSg814oBtSwj4VHUe8OXMcrBZBl9N3s5yH+7pi7hSYjCR2h7PTWvK
         d/ivbbZywbhlfLC4THokMREi43jQWEpLJOEbEMsAHIbGn99257OV7MpCrH4GX/2ZlFS2
         e5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256091; x=1741860891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77LEyUB5P/fKu/IBcJvd+QCzhbabA9R1jqKDuYpByGA=;
        b=MIdd/K6mUq/7vrfEoWVKiubrBLnmpPLRigEnQL1FF3wE+PnzjaJcPXJvkZOQKf2MNc
         Qmax4dQDqpOhDBZT2IV3kxNieU8UDXv1xTa7pUmbs/PQRSXVR7qYZya8niGE+Y4eRpv7
         llTn+6at4DH8KV4afYPujSqDBJp2pnKOcYN2j0ZHOf2f8YEtGaRiUg7Kh/ew/Xux0A6Y
         o/e10mfXICAXcuq4bcSIvU5HkYf3N0wVoyw5IAY+wOixx7mKeTmINL6OjxdBBAy5EOw2
         bW+9uOcXvNUUBAsBWxY5/M/5FXWcAGpgo02s0px95k5eh083eR9VWFoG5gRsNLHiJ/GN
         tXzA==
X-Forwarded-Encrypted: i=1; AJvYcCW04Fvk5m9LYZc83n726KwkejdB8dCSNRJCklQTAUoC149MX71GIg6WUbX8QRFV+z4Y2ijhfofj9ACg1XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV932kiDbNLfyNyTZrVazABJKz38/l2lpe+1gssk8jVjxmm8Lh
	jfQeunCZIH/UAzEPyjlyI7FZ/lZ9CeKFVRQC2ms6HlZDuIDlOOhujg+DKPyHTsI=
X-Gm-Gg: ASbGncvExhHZkV2PwPLzwn97IHduBl9y+yscBT2jmHGEcpZawZM+TgV8BoyQGZZstK9
	WvWU2dC6YukqtmGnyVtxdoXBUdlJVO0RnhFL96YYpjLUsJRt4I3TR5IkBsb1K6Ub0B+0tDhPmfh
	yqz/VBp7QHRxA61g5NhN4ndbnN9Q01GSpQzFbU6rgJItc6c5HqcLzqpGd9sjnxEZdjE8ATA+VpH
	G71vPkLXYxMXb+iLv0Ft8DXqOFN1v8Edk8o5iFU6bJA1PfylEMHu0sZ8bawSTI+h9B6YMOcW7BO
	pqmoJ8StQl2NpTzIjPdikRDERRyXvm5UsYgwhnTAwZ7tcxgRGgK1CYsZc9rZSAWRN6uvP7E2s6C
	tuTEd7hXm055mMd2hcJx4aDmeHfXz
X-Google-Smtp-Source: AGHT+IEjMRlKCm5Pe5LA1PCEOatZDZ7Iaa7e1nWD8ZdLZ5E256EnJO/N5BK7eyefycBEa/h/RFzPqQ==
X-Received: by 2002:a05:6402:210b:b0:5e4:d602:70ae with SMTP id 4fb4d7f45d1cf-5e59f4a3f33mr6101870a12.29.1741256090912;
        Thu, 06 Mar 2025 02:14:50 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a6af7sm708972a12.33.2025.03.06.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:14:50 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 06 Mar 2025 10:14:48 +0000
Subject: [PATCH 3/3] arm64: dts: exynos: gs101-pixel-common: add
 nvmem-reboot-mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-b4-max77759-mfd-dts-v1-3-9fe8b0eb8123@linaro.org>
References: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
In-Reply-To: <20250306-b4-max77759-mfd-dts-v1-0-9fe8b0eb8123@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Now that we have the NVMEM, we can also hook-in the nvmem-reboot-mode,
so as to have Linux communicate the requested boot mode to the boot
loader via it.

The two remarks regarding missing reboot modes from commit ae32b65c9359
("arm64: dts: exynos: gs101: add reboot-mode support (SYSIP_DAT0)")
apply to this commit as well.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index f67fa1e84d994de4d40f29a2d437ab6401ac133d..41f63b4d93fd34e1c955d1f47039cc0d9fb4813a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -60,6 +60,20 @@ button-power {
 		};
 	};
 
+	reboot-mode {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&nvmem_reboot_mode>;
+		nvmem-cell-names = "reboot-mode";
+		mode-bootloader = <0x800000fc>;
+		mode-charge = <0x8000000a>;
+		mode-fastboot = <0x800000fa>;
+		mode-reboot-ab-update = <0x80000052>;
+		mode-recovery = <0x800000ff>;
+		mode-rescue = <0x800000f9>;
+		mode-shutdown-thermal = <0x80000051>;
+		mode-shutdown-thermal-battery = <0x80000051>;
+	};
+
 	/* TODO: Remove this once PMIC is implemented  */
 	reg_placeholder: regulator-0 {
 		compatible = "regulator-fixed";
@@ -224,7 +238,7 @@ nvmem-layout {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				reboot-mode@0 {
+				nvmem_reboot_mode: reboot-mode@0 {
 					reg = <0x0 0x4>;
 				};
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


