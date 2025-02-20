Return-Path: <linux-kernel+bounces-524122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10E5A3DF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC86700C66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E700211A1D;
	Thu, 20 Feb 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8mzav3q"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF82116E1;
	Thu, 20 Feb 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066719; cv=none; b=sdOZVULG2BlFp1RC7MvFXoJY+oheo7xb4NQ9n+21Vw2iigwVv9XDD67hr3NYW0T0jWcEGaCg26qHBsp1hGdmrCVJgdUIEpqKT5cOCaOvvzeagVM2jh/mhvoRqJekdwtDqID5c3jdY4JaVWZauQ9pwvRyxHuECAqOYMNgELevRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066719; c=relaxed/simple;
	bh=qZhdXikI6UVY1zdlQzyoBJcvZeFaA39QMPy5jc+lJ4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr4qmgcFB1L2UBB6hvNRdtZvxjtrwnQLcSX0YgN6iPb04azf7i/F/rdRwEsPxA0N5QZbvsDiiacJk2+ZrM3ctleV7GS1FB8Ut18ruEkKyQr16HE5q20Qjrv+qoyTH70jTohtCisu/5OKoMxGqLFnszk0Hhdz2k98YOUlQNg42fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8mzav3q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220ecbdb4c2so28798785ad.3;
        Thu, 20 Feb 2025 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066717; x=1740671517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY1ZEHmtwa1GitLrlmJuselIoFJmZMHZa/Euu9FfPU0=;
        b=T8mzav3qSS2RLx1zJY0YNaSGK3LWslzAG6VUiY7WTGgjp2kwVuty5ExoNbBcdAsaK7
         BnJhBuHQ4fA94CFlbgoCeUkqZSnuVo4oiDhCWJZnjTx7XzGwCfj9fQrR/A4nF+xGf0XH
         K9cDdSLi1cQuSKDlq2Z4wV0htiaWYSOAoWf0lWSpcva55UlLtJrWxGsuPtcDJZsaxnW4
         RoZpGsp2LQ7FB3/UrEDNGMPJSTQkCIWcQOcsQHWnwcPLlIIKfIGnGHbZopAPPReBh73m
         zylJYFdOKglknYZPe8clfZLBfeT7UEG+QTVnl6XOZLLb8dicd+Ky0Q/vRDAPrvxnh5yR
         tM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066717; x=1740671517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY1ZEHmtwa1GitLrlmJuselIoFJmZMHZa/Euu9FfPU0=;
        b=lR+Y6z8dnpUqLxZpveWyCMI2SN++ETrkAIUAClsZwmaXcTPNt/xHnEJ+M2QNAP/hbU
         YR3ex8QjxmN/9pIygd+jkiDQYrE518eaCTi1A05uwbl3ub3gifz/3+5A3MXkUyC8lrjU
         0Nn8RWmErLsE6hGvfdO5m5VDv7g0Pe1vJCyUDWovjUVo6o22vEfEqKMulKrQJ+psp5Jw
         76ze+wngUaSIJ1/mqkHCY+QcV2FGarBcK56s35pK4D0bCiZuaFa1AMO8ZthHx4XNogcM
         QaI7ysL8JWler31YKk0aiA8DoPhEghIBUC/F0WY542b0z6FxQ0edGiIyZAtyCTMvRo2m
         Zuyw==
X-Forwarded-Encrypted: i=1; AJvYcCU/BpMNT+YA5/k2lWDFQvl/VjzghkeESUntTM4AbOZBchHEcpJ7VHDVMNtR/0iwmUS5RE2hHSO0llqedFIY@vger.kernel.org, AJvYcCXcSYUUQeSXUYcWRj1V2whWoZ5gUWDSK2n8zoIsXSLzvxO3p1CaIWoc9faBjfhCTp6J6SQM+DwplK8w@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqogPqLwQBxSJa8VJjB02IMaJkpNNVzFC4sRzQEnOis6JdglO
	XPQH0aBnbESvECfyHEF/lgkqrR8l9ySXhC1rZAKYNQRE+iCO6O+b
X-Gm-Gg: ASbGncu3WvkRTJW/tKSx3A3OJwS55DWAgse9itg0lqPSWb9N6BlDWe5nN/iETF+5wN9
	wRKHu7OinNLZ1gyXNN7mpxxxsToBOL0FqHSDZFWkKw4ahShE32zwj3levRHg164N8f7m2lr+2rH
	GXbu3YsU0FGgFQ8vxKTYPUIedoz6yTKqtE605qet0XkccPmaK+VdwDOZpaOavDoQUzqMr5cyyP3
	z9nXNRTUjFprrkK+zfuS3koKTxikgrq6tNriBlh3h2RGRbP85TRLLMuODL5o6buiwfWpVHemLuq
	L3a4yUnVfK4g9QSxEg==
X-Google-Smtp-Source: AGHT+IFZ4waWbLP6Cecv/2VqnWVBd26xIfd6Cc00GYuO0UcuzNJuDEqe9P6MhtWqvvfa4Xee+Dfqyg==
X-Received: by 2002:a17:902:ec85:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-221040c0706mr332046705ad.45.1740066717220;
        Thu, 20 Feb 2025 07:51:57 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5349019sm123694345ad.36.2025.02.20.07.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:51:56 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 23:51:07 +0800
Subject: [PATCH 5/5] arm64: dts: apple: t8015: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dwi-dt-v1-5-d742431c7373@gmail.com>
References: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
In-Reply-To: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=qZhdXikI6UVY1zdlQzyoBJcvZeFaA39QMPy5jc+lJ4E=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnt0+MPQ8JTGw4F5YzGUBWmHCB+DlZx7fcvvsKk
 sDTlG6+i/OJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7dPjAAKCRABygi3psUI
 JDl4D/400FHyrq6Eb5o2/1uOVNJxJzFt+ILrPpy3mk45/VPqv5iGiCQWyWjOzJEACVEawuTnMe4
 jX0nylQ2XiadUBbVmK2NwG9ZVV6xh7TeQ9wqcY4aaDG/nEgCMraDMuq8VwyjlHIhxCUBEN2uDMQ
 PhYrBy5HzYkGjwzZYyopVvIg99vh7RJTZNYpnIQxZGZbnnefmdhT/o5bM+6osTPjzkL4oviftFn
 fulEaLRpzYEboa2SKzGoD5+oPJG1q+65Cf5gZT9m02bgyRpZh7K+6B6ZVUAkbSNgl+gJ6XccqDJ
 FgPNEkgEVvEByBrpLhwFD+DtIBuOjypVNQbRd669Z40i06IZp8BdQ9a2uqNoo4LeKObMsLRq5ev
 6/O/GnIWT7zHP7kJASGdy8H0X86I0WeMwimQQyK/cpUT9WLmdwgShldHEcvoonhlo8g5Y86hTg1
 CyNf67bs4tpZdfOB4NPjabnuxKPzalO4sKXjQ3ivKKlq2+R7EnsADFDAHe3ZHagFrkoKUYFh/eO
 u06SkuOcTm6+OhyMy/eU/dEtJKbEZVzeekXz4cV4I5pXNPhSm1LwwOF1FGpfbkg/qdtK+RMiXwX
 jXdeMxOefrBZDG4wRbpsB4mjcsHsU0AHdyROEc0DkmmX7uqlwtLnZgfcdsw+mt8zab5cDDOuQG4
 IYk3b4ZngcQhmaQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A11 SoC, and enable it for:

- iPhone 8
- iPhone 8 Plus

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-8.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t8015.dtsi   | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-8.dtsi b/arch/arm64/boot/dts/apple/t8015-8.dtsi
index b6505b5185bdd728a7416efaa3dd53d1c6a5fab9..0300ee1a2ffb7d2bd0558f6cb6f86514f4b433a4 100644
--- a/arch/arm64/boot/dts/apple/t8015-8.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-8.dtsi
@@ -11,3 +11,7 @@
 / {
 	chassis-type = "handset";
 };
+
+&dwi_bl {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index b68647bebd20782ba7a125e670b3264c184b62cd..4d54afcecd50b50ed1fd386ccfc46c373e190e6b 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -262,6 +262,13 @@ pmgr: power-management@232000000 {
 			reg = <0x2 0x32000000 0 0x8c000>;
 		};
 
+		dwi_bl: backlight@232200080 {
+			compatible = "apple,t8015-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x32200080 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl_ap: pinctrl@233100000 {
 			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x33100000 0x0 0x1000>;

-- 
2.48.1


