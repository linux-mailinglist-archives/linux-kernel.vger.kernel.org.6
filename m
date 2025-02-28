Return-Path: <linux-kernel+bounces-537765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676CA4905E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D06F16C23C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852D1B4F0C;
	Fri, 28 Feb 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMS45xbl"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB71B0F21;
	Fri, 28 Feb 2025 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717161; cv=none; b=pQJoq6DbG1CrajH23P5dHKsp6IkIbk2IUGvGTIXoGiSuRqN2Idj84WaQpH25rmJ8X9qnAuJAk9fg25cm+zal3Apkc+SyYSRrSm4RXwLO/HUkW6kiTTMq92mPokC1MgUVFyTOv3J7l0Hs+paIex+AYRdDBga3abQs59MVlk42LFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717161; c=relaxed/simple;
	bh=BydltNMBU6F6QLU63AOuc0xk1HyAvUD4tBSVKN7rc/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1tf4Py7W0r0go4F8370vt1NMfVnlF6esRfuSD0if0iow69okQK2JnCy7yg1NAd2RRKtFcd0tqzOyn2sRcgpt8Rw4hYfjJBFLoUFqNHh4eiSolTOgbVnoMcj2S+j2Yrl89FJun2qUm++ULEomC54dht9bFy27olG4FQJhyrJEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMS45xbl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d132f16dso24290035ad.0;
        Thu, 27 Feb 2025 20:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740717159; x=1741321959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMVlCD7xq/rs92dyB+px8zy2TgvRUJqxcNz228drEoM=;
        b=JMS45xbldOPZmAiJCGGSrtKJhA12WmCYnt4BWTIKKQ7xgYm/tQ7lFz0RTyusQZ1IVF
         y6c29JEkxu9ob4yhCLkKcAqah9cJWsfFlp4FthR0oDwYrb6Wt9bdBgnf3U1zthYwZYUs
         ZB9Z4SMBgGMHGOiu0WlzGMFUEre4pRZTMRqAZ90nn8caCp5YPy9XA3UC1NjJUC6IpCm2
         BHc2ATQtjnbCW6UsNMIi2itSOEvRIAM9HFFh2NAIBSRqkZ+rvv2UXi3uDL7tQzOiTJka
         9YZQ64MihqW35A9k1H0OyFAd5XZTJHvRlILImSCbtuiZmRfYATO1druzqHGhzCvv4gl+
         5BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717159; x=1741321959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMVlCD7xq/rs92dyB+px8zy2TgvRUJqxcNz228drEoM=;
        b=W8hd7u4xrsBZWqZwcbPCoN4D8mwjFqZMHofA5fADkqHxQy7cS8mhm+GLIzCHY1i0JX
         Q99MSRMCztpDcMsbCb6DC8nsyb7P4Nemm2O9f+L4lSd0FyG0hJWYudS4OmnameBdM7XM
         prtYbUf8VT6yCDKdIS9EOZ+EiXSDOv/fsMszUF087daguqQLJVI4g63OinZl2TfCKvjJ
         6dgrKf9iEYkW9M/70sAnCDll49LJDiB+6PD4AolNJNpVko3UMIFZm5ZtgxMH+zRbNkD/
         lgqiuJSrZHIDAlnLwgWPLHhOm1vGH/50qjGhe4PMI2alAHbyPSYOHv97C56SCqLkRpaF
         hWTw==
X-Forwarded-Encrypted: i=1; AJvYcCVlHwFzM60VaIzsJGMi8k9MQUjDHkEjoZO+iLKpbiIZceip/g3QKqRi0cXuwQMqrVFLleOWr0RPwMcTTQxp@vger.kernel.org, AJvYcCWn2flR4yVYBrrw0I65kENK9Ij9mj9mxE+X1jZlrEXDB/9GmMcY+QuSBvU2CdurVPWS4vEPgyrhwsqg@vger.kernel.org
X-Gm-Message-State: AOJu0YynkU7/auwhXx85Ql4xj1ig85SX4Na6aENi6QK0DQKnRzd1xlSt
	i6KIyk6AMoyU5upb4e34oBCIwr2npb4ef3Osnu6qbZficRXujLPh
X-Gm-Gg: ASbGncsowQwpMlN6fY2sM9Bu6EfJSpFD7ESk4jjsS1SP+4/q9ecqGP9jpOxSpIPVrD7
	a9ZQ382OoPuSDMlUbbIhCSPSiNnFykqN0EPX0gbtP0q7FRANabDSxttaYBNmNFxB+IZXclf566L
	uFm4bFdcEICquDBUY0GoMThZ1wkjxnsrmTKZnRqcSy+rfYeYAeTXOfqXFXF0t+u5hj5LBUhKG6l
	u77D/h0Wl6K/gP/+8LcanmwhinfNagNBwQlPJwEYrcv8gUsr6MTjCGw1wP15KPtiU1T7+zJiAlS
	eH6/1Fqm2EwsKdkIvMzjeoE5tOQX
X-Google-Smtp-Source: AGHT+IHE0slnoj1dLL31W5pNwR3MT6F6XW45z1UHlyHXxfZwkoScSUmF1CY7KEGntHtKZdVlTDIAFA==
X-Received: by 2002:a05:6a00:3d0c:b0:732:1d12:ded4 with SMTP id d2e1a72fcca58-734ac351c0bmr3387428b3a.7.1740717159101;
        Thu, 27 Feb 2025 20:32:39 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm2738204b3a.132.2025.02.27.20.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:32:38 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:32:12 +0800
Subject: [PATCH RESEND v2 1/5] arm64: dts: apple: s5l8960x: Add backlight
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-1-69e450bc4bfb@gmail.com>
References: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
In-Reply-To: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
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
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTxgSjorsYapWG/OMe21bzD4rgcuzKN59JmE2
 75tJQKHpzqJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E8YAAKCRABygi3psUI
 JJ7BD/9+XOvBJhJh3yhB31rFrSWknM4j1ymksznUPbOzne2b7fqk/ZGcdC1RrFaAx8fjuuLPtZp
 LUdUjBEGjY8LqLHaY65VjyMHUgufgBGtUx7qX5r/UagWkIbIkaMrDy2JcuPBCfzuh9fKkS+8Ukg
 s3Cmup+YltkNCOf496+KFezkmNhuhTGMp5bRFEf5elpWzw7BgHegt4NTj/oncRbGqV601wPNHhF
 iXlAWq2LbBwPVj7aFoV0rcB0p/FHNrdeqPcF2xzbE0A9OjdWev7fsVFXRgHMPZfZKtxltM9tp95
 yDyTmeLnKIQucBkP5H7+71OKD0mV5NC9/R4qLwEdQhNxEIDyfjUapQLNdeKh7OVoZkGqJUvFZfP
 iSsqYKRhIfkmc39tU8cpLxFIOJdRMw0cU34ko+fGKKLdMvGPorfJQnHsI51o7tFDEB+udyzhXtN
 vwrda2VbodwK+dTf+XShcJLtVMb7fiJlVsHwzmgasqrbZKlaQN+GYTbcRa4SSp9neIso64UeNiY
 SfoQabxVFpR+3x47nG5te3KaAJyupUsE25lhaloJQvbF7vDQ5h4rbvx2asXfTX+I3+kadmkyCNQ
 9N4xdkHyp5Um6EUin9rowOYdflZCtCrHgOOjmcLe/HULvST32LMARjHeotK3nVI00130uJc9slY
 ckOZ7dDn77pZS6w==
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


