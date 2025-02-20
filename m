Return-Path: <linux-kernel+bounces-524117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9CEA3DF70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACCB19C6544
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496CE8F5B;
	Thu, 20 Feb 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYBOvrYH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03D1FECBA;
	Thu, 20 Feb 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066708; cv=none; b=QaxpKqwz0QbAfg8nmoBT9K5b0XE0nSpILxR4hVWIYZQNoFtFtnz7OzNfPKFtwn6LvDoqe+1H2Gqw348lKr3ZWLKbCM47oDpXFrW5XwfRwS9/IPPsAB4jmG4NAG5QG9NtyIWwxjQIFuDy1IPtbLK/G2tlfVw01ypKBE3POriaWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066708; c=relaxed/simple;
	bh=uDPmflVJvnxOB1rw8vcGbu46t3L1/i8a/zN5ANyYz3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pl3Y7pY99Sjh8xYBnZQ88NU0+UhpVgruqCw1ej+nHq86L/qyQjJJ8FcR6tdLWIz55Zp+l2PacW+SJyBaayEUelAmoXNq4I2/5TNdBIIGep8coMgudH5hkT6/wOKc2Gupiuwm3kcf7xmit6yo8rlKuc6POC7VTndoASDv+Lse0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYBOvrYH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e6028214so24264985ad.0;
        Thu, 20 Feb 2025 07:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066706; x=1740671506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1NlfLag6cXRAi1RREWAXx7+nFLb5S0lG/vhce/4QOE=;
        b=gYBOvrYHEsUp+6EoYGmM8bl8mmDRtRZDhBixgt78DWwoQBcPq8bkyh0qS6Z8NscxM0
         la9OlGscmP4CjaGsFGxW5Z1orZjQeyfr07kGMvp9o0YoGs6d03aO+OsZDvc0szN0b/vF
         S7uwGzzTOZSX19kwe/BmNdM8xkaTR/w9UI/KO9bkvNCK0ovvNvyYoUKCN3tjS++DkVGi
         ggd6D+Zsbo4SDuqAz+UkdKwW76Dr9z9kNyGROsmDlHHg8NlWDwgFyWlpKwmeXJ3qY6rB
         2pEu18gDFSS70htypfDEw7d8m/uNjFi6STddT2jSeBZg9pS7hvnEHuMklv0AkMXnDh++
         4nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066706; x=1740671506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1NlfLag6cXRAi1RREWAXx7+nFLb5S0lG/vhce/4QOE=;
        b=dK+vrDwbAONs23aPQVi2PafayMrDkQAOGFDIbqucU62EcjKI8n+Ui4lZn1vmnnH3xw
         GXUHuKSmcyHvne9eZa5T3tRj6gVnCv66iIiAYTSoDFTurqGD3/I+BowPrkreTWRXHD/y
         4KQetAlHj/1TAI+UwKF47FEha6EsMn6CvJWPL2ROK9jdCfEO9FoibudUyXm3JqJQEvWx
         CcpL3WihR9xyXyJ8Y/GH+vXL57npHE3jDv0X6zzxnGjIxsPoXu5iZyccy0vlqvL9y0qZ
         M6W81UKF79t52FInHjRiZ8ygYb4R2o0BQqKvR1HVljg1BOnRQHWcylVXVLkK6EiZtnRm
         Wh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjcVTySJBBEQ7ReCVU76t5wiw9jwtiVOS8HUMMg2jd2032JkOrTtDLS5Z5/9VYhOSBcqO2sJYiPdLM@vger.kernel.org, AJvYcCVrhaanGDIE+TF3DdllzAQjY1xmFwn8DRtc5VAUS4EL97GLuy14pdNQjXbeJrUXZpEt1wyRGo2k1OZVkkUS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ghweW6NB6NnRlZBLUD/lfIM5jQAyFGdlo1OvTSW7Nsm4ThXr
	9HEXHmlWtkyi30zdqN9E1ZNvlvvZFg/SbnLd1i3mOHj+cN9y75SQ
X-Gm-Gg: ASbGncv+6jwHYeyCCc081K3EpHiPJFWn0N7K6KsQ1aNeAFBhoohgwlP4CHTM7iMjnxe
	6+/s1w+PktlWeSPjupIm4NBqCRT74g0leKZZ2lZshU+P7sIW+x9n6KfB2LcivEBIW2Wi5edce1o
	pkcDl7sFZWT911nOao/O6VDnHmL/W42KmTeanPEP/3+qmVaOF2xgpVw+P+Q5mXPMZQtZqLLJDNd
	qh+nYZhEbIZXYNyMIvUTdYbM9+HweafuoDcuf2jOwY3bYwfb+f+zYyIAYI55WTzodYDKC2qWBTi
	B08JhLWmUbNQcnpSkg==
X-Google-Smtp-Source: AGHT+IF5nb3qL/RD7OyYRMOZ8L+tw+d0s1Z5Bw8xKRR7akur52BeX2LWZzmSm2zFJMw6MwCvDDyQjw==
X-Received: by 2002:a17:902:e5c6:b0:220:d256:d133 with SMTP id d9443c01a7336-221906111f4mr36757955ad.14.1740066706443;
        Thu, 20 Feb 2025 07:51:46 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5349019sm123694345ad.36.2025.02.20.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:51:46 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 23:51:03 +0800
Subject: [PATCH 1/5] arm64: dts: apple: s5l8960x: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dwi-dt-v1-1-d742431c7373@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=uDPmflVJvnxOB1rw8vcGbu46t3L1/i8a/zN5ANyYz3k=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnt0+MO0zMTpQPauB/DSJytq3Q1Jtgk5jzXbhik
 yG+F2AiJbiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7dPjAAKCRABygi3psUI
 JPYbD/4uMyhSLygzQKP3tRNOkXR68uKYdbWUne6RZKdORb8nRY6IDKTkSHm1msNt+3k6yCSnY18
 3WYKTs02Dj0qFtD1EWGQBjbrFFUg5HopoF+bYSITupj0EX/9XO3Ln0Z/nkc0pOWNj+HgXwF21xK
 +tvU1iH9nQklHoHgCRUA1RtQKxUjyRUg5+9zukwWwdz1Fq3CNswD49chIwhje5kci8Z54BrJLeR
 hRc5uUTHy35LPKBrXnUKfuQdboR6+0aRrP4FYphRKYB7zQp1HYR+Hvkg2b+a8XJVCoNpAWeQHWQ
 koMKbIaVBljKbT0XATmTdDnSeGjMAk+gFqUK+IGNJ1CrcUnhVomiasZ9R51uZod/AH227aM+Pnr
 2pajZ/GeiI3VEj5abSXGWSlumLfhVTi56aTRuBMPNZUOysKiHZkTjRFoaT129KEjk0TXp0MoJzS
 auCiQgY9E7vcnHx2tyNj90Jcwoy7ighwhD/kdKjYdqBHfNAztGL1tp/h2AJQ5iwV1Rr/6ZexdKF
 A8exgNFmdJTYT2aKbiNMx4NbnI8E7x9JFzPQbbznmFKtuateNcN0MSfGzKpiTekh3Vf5inajGwp
 uuVlutt0uOYqJftBxvwz+ZaBxIdxSTmRZ+Q9yA2qrRYBdKrFHePJZi1qw41jqItp9LoepT/3SfE
 7IpGjYTS/CDB4RQ==
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
index 64dbae5c73515bb6a1651b9b26d349d0cfd0408a..b109a1e7fcdad4ee3caf0efd2c56d76c66706e9e 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -100,6 +100,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200010 {
+			compatible = "apple,s5l8960x-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0xe200010 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,s5l8960x-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;

-- 
2.48.1


