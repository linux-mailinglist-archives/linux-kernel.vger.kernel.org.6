Return-Path: <linux-kernel+bounces-537760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B59A49049
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC613B0BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795E71A9B5D;
	Fri, 28 Feb 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSgWoJg8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3911A8F74;
	Fri, 28 Feb 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716763; cv=none; b=gy/nELVoInkJ24ar8QQs9sKZGCVwl3EBJede9o1vWkcuy84cnrVnJXxkAqOqcoWocKc8g+AOuORBiS0GH7Guv2g/iTAAaJLM5LlgokA1Mqdo3q6OMl+u/Af9iBwNCnq7bqnziyfTrxyZrtPfx2kGvmbWx5gWYnQApi0fzQqdeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716763; c=relaxed/simple;
	bh=BydltNMBU6F6QLU63AOuc0xk1HyAvUD4tBSVKN7rc/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZQ9FY5G/aqqoXJAXp6PUDHPW3RAdrC3bQuKvxksTFk9T5xvRNO2Idg17LQ6qtenlORK0DioKk+iOi+ALUUnHVlGMHpvHNtLrkI91E0D9EYz1K5o6MKFVqqZNmmusNc6zz5eUiFnekvl6dmdKmAS8Mda6sQ2vtXvw2+m0LMcAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSgWoJg8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22328dca22fso27072925ad.1;
        Thu, 27 Feb 2025 20:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740716762; x=1741321562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMVlCD7xq/rs92dyB+px8zy2TgvRUJqxcNz228drEoM=;
        b=XSgWoJg8ZSuSYSk9STWUx/LgNvk6Xxb6UUVgw0gWL/MkAIk7xcyMtXZ8VDR2IQIjjN
         2h9XMFDRjrPdFdrwjKRC7VqyuytyMRxoOsviB6TBbbEAismCzBFGd557nOvTXQC/cEt7
         7Bb23PtEZ0mqphX7zgifMqNdBvpIEVSrg9qFuqejdYCoNRkAVCuHz2OawerSP9IOF8C/
         L25zPq8PaebGs+aGe0HbOA4ESsNwp4gyJ4qF2hvbjD4QTX+04R94eayHDcr/spvlW8sx
         xC9mexvoStJkLABEILq1quWtTUFDeu+bCU7OLCvKJ6twfNDr+8yRgzuAmhg0CSzmQcI0
         SZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716762; x=1741321562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMVlCD7xq/rs92dyB+px8zy2TgvRUJqxcNz228drEoM=;
        b=aVZneCo30C0YxOY7GBXc3WWJ1OOywoDVyn4aJ/pEdQjIxMINPboWFBP1/rYMtJdw4l
         c0CNvSC4uHyEhX0+L6D2QtrRjuN2m6bicy86DDejKAt/IOFVXugIWtaqR9WA3DgqwEFk
         3VnvXGTul8S26Xb+KqrJ3OZDNGkWwj36GJMZu4Kjbkr3PMf3X168QkTjX5H6zOqQ4DMj
         k0ohRCxfnMG1DyGCCtII4PBmzoJTuBU4xvF1abs77L54it6UOmdfnSCE05DbSrCw9NpJ
         kh7ImUtIf5ErgsnLLWWJuMzk8JGIzSBpfT1/oggOLJOE0mWeR1svxNpZzy9UGNSXb3ME
         blJw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Y8eZhYScSNArsG/aTWnTUeCI48kIlSQ9mXyXzpQXAg2MW/t1fLjTBp1cJPUWOKk7iZcg0e7wjuZs@vger.kernel.org, AJvYcCXDakhrcKw7OGyNIcH437LQLmr+MHd0tarlShkk8op8yhP5adehce8RPo2nNZIp6sAtzujBO8+iq2Lwcw8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEInME4gmP/thKYM2S7jPIg353o7nN9R95gTFsn2MRQD1ZG7d
	CBDLxuOQmx6JAfGvLlvulpN/lWjMHMdk7yh2qU2DlSUPKZcn/NlW
X-Gm-Gg: ASbGnctzPobq01Ov1JOrIWcbyQNLLkT7waEEcvAZEaepWJnbk1pol8gYqQW6da5H4c+
	9+M4teICk8wwZ61i8kh3ODO+qHIanNmV94YUwzD3JYjKzqfU4SDsLbVpdyXBEfnOLdjNoLbloqu
	Qr6GoqNhVGMTufqa3x2FN28eJrerM/jz1H+S4c8HckONPFuujYjwnzkI/34V3lpAmswQjqW7quL
	QR3CBrUMCG9kj1+h8c97m1EaGiv9c5cwteKeMXBO8XUbrlBcul3mlCnN/NREQYaShXvRuarkq87
	S+kbYZxdlRofaYlNtUaar9oxgw==
X-Google-Smtp-Source: AGHT+IFN9RDW8T0Nw42judDpKoBGP38GDULwt+Z5nlzyDmf4maft+vUwsQUJG+p5WveGNHv5ketPNg==
X-Received: by 2002:a05:6a21:99a2:b0:1ee:a410:4a99 with SMTP id adf61e73a8af0-1f2f4d1a4e2mr3348169637.24.1740716761890;
        Thu, 27 Feb 2025 20:26:01 -0800 (PST)
Received: from [127.0.1.1] ([49.130.82.63])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dd19sm2738318b3a.131.2025.02.27.20.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:26:01 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:25:32 +0800
Subject: [PATCH v2 1/5] arm64: dts: apple: s5l8960x: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-1-4243fe8647a4@gmail.com>
References: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
In-Reply-To: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=BydltNMBU6F6QLU63AOuc0xk1HyAvUD4tBSVKN7rc/0=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTrQCWUFfgSa2s3Vd3yBbA52m0/0+CdUSIB5M
 Jjdg/pZlIqJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E60AAKCRABygi3psUI
 JAanD/4nH6K0dM5YgtmL+DcnKJqZ9WPb4GXPbawmq+XCH8MJdyqz9lLdZjdtMX2HfI43IfahKQw
 +VIXnOPWUXcvI7PtHoSnSxqFwjydRo9xOytIxAjK4kIuSv8VzIS3UZ+SkMBX6TWAFymwxMuzpKL
 JsG8ng3zvr5Php624nywp3jalOJUceyduFKsRQ/F/aO5NCVXqHGxroPhruqbwo6bcBmx4aoUgHN
 3atpNlRxAWP+fG2szqyHZ6H5u20oQPKRSl0D9SmMV5r0xDdo26utpO+c9rrM/6PSeAwbL4oqjsd
 3+QewRoJhaOpHEdh1mXPEFaMezhim6N8SWlul7BCVVHswE3hNVMw45xTOPOZqosVG56m6P+I6fU
 A/kXidChB0sKKsT5HZnKKCSX7JcK2dVTsmrU1AUPGD91AlJj/C0R5CVPYE+fVpTs/YFHTXJRo8Q
 7Us+v5i4wtIb0SJhLK2l62aN+dVMOgMerQk7vocPwOCmP0joDiP0FU5xtqG5KahareH7GyeDmhk
 Z1lzNOvtc6dTaKAUCoQMnPx0WzwJe+Y3DPh8lyjNpdDZ7cMFP//4D4GvBjjCSWkgmGI/UYgPL0I
 cjAHhSfShPy+EMSAWymtFVo5ePQUw2F54chcPUfIrvdyyiO8zTWL1cNNKs8V1aw7T62olWuppg5
 V+qnVKowqh/9kDA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A7 SoC, and enable it for
iPhone 5s.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi    | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
index bfbd2629e206736822a157431ec959e1aa70f41b..8868df1538d68595cfe92c80b1fcecee42d348df 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
@@ -51,6 +51,10 @@ switch-mute {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &framebuffer0 {
 	power-domains = <&ps_disp0 &ps_mipi_dsi>;
 };
diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 64dbae5c73515bb6a1651b9b26d349d0cfd0408a..d820b0e430507f681a5f2aa13a498be98080e1db 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -100,6 +100,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200010 {
+			compatible = "apple,s5l8960x-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200010 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,s5l8960x-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;

-- 
2.48.1


