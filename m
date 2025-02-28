Return-Path: <linux-kernel+bounces-537769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABFA49066
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383083B3C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255F1BEF95;
	Fri, 28 Feb 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL9wv/K7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5F1BD9C1;
	Fri, 28 Feb 2025 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717171; cv=none; b=F/4of/dbHcleD6Rx0Scr80L62G5P02nrsve+a6RHEtlgiL/wduizGjXZA5dfjKsr2CMtuNolv2T5Loy5tXiwkKC34+1UQn4TeJ1Zhbwkw3pRHL3PnUg1VdV6viWp/bjCLyt0bCIgE1bggTdNTacL4lXG+10Ht4j8rmdbkRIAzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717171; c=relaxed/simple;
	bh=qZhdXikI6UVY1zdlQzyoBJcvZeFaA39QMPy5jc+lJ4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3Z+FlEr4JSaOQRfKPyJqERL8KYo99ShyDsvFSwJYfYaCPBQUG4xWH5iFgfgjXsM/K87M6o+pOfbF7rkk2NYWvOO43xCYYbfTqrvLYWSiU33s3kBVg+shPgrGvrt+WOdB+eKD+ER7z1hOQisXxp16BNN9BS2NiA93pXN+BhB3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL9wv/K7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22339936bbfso26758635ad.1;
        Thu, 27 Feb 2025 20:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740717170; x=1741321970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY1ZEHmtwa1GitLrlmJuselIoFJmZMHZa/Euu9FfPU0=;
        b=UL9wv/K7SSQQwZHgEQQRJvIgNO++fdoaGW/qQgkgRfq8sbp6CwtESx2qct3gdUYTYG
         fkANkK9WJzxBzy5K00kb0EpibSQPAMx/Ey3g43jNLLKkY7aSh39pToevS+EBgKVITNEX
         J8FbWRJnmhhCBbGhUsNUOY47xk0698I34BNVL3i8YuET5u7cFp+KKRrrQdQXkcqVaKkX
         6VZPZdV2nJqfdq121GCI9gHd6y1osBNwlFw2a3LJMz+hm5t395+s8uhyzr/EYLGi0TXa
         PlIAPyGXK1hZoznRP/njVKsH15wl0OQfnnkps5Icmma5O2Xi0KmGxR9vTNhf5QhE9Vb/
         QqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717170; x=1741321970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY1ZEHmtwa1GitLrlmJuselIoFJmZMHZa/Euu9FfPU0=;
        b=lLl/n6/AesnGC67th8Q5DNqiGYoIMo004hJdl0PiEcbjv4vkcBqubz58V0N63hh7R1
         97B5Q1bSrbVs2IB91w3EE3E+6ONp39GB515RFOaAFAKJRfHtTbZJGEenp4+jW5qQX/+x
         HaWQvp8kX5UVUjs4BEKT+/AwjLU08L5VcpKdopkmYPSOs327zcUliDWNhFDPJ+6jjGqZ
         q9O+JChvMgjdk+Muo4uGYB9LalhGcCMNbkMSwvi+HRoHOLxbsEplKRGtPON8YMQt8dK0
         jNMq2hz2E9LNSqbYGqLWcDmr45LrFjM9hTc2fsL1bl1YVhlc5e++J3F4tf86YMGl7iEC
         f2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUEHi4gH7wSCDQY8i65fp0DZ8P1GxspS8xYKB3AEqGkfGGrCYBP6qXdO/jcdCcOVgIClFuaqDblzBEL@vger.kernel.org, AJvYcCVsf0VeUn5uvFOrlLUBgDfrn1Rywr8Q4hYFTJymoOjsC1hCJuM71toX08L0qmMyINjsA2OURNDp0qQabX8H@vger.kernel.org
X-Gm-Message-State: AOJu0YzORpSv3fh+w7+vC8xCpKeJswbZmXCpZzCgb42wW08yGQgtofQ4
	U9rv4TWKs4Bs0OJ2Ymv+DDO82/Vd9PMRXT/QldXUx4BVpa/Lw8MA1cJliQ==
X-Gm-Gg: ASbGncu0z8eAGFlKtCLlDvtj6oiKhXX3bgycG60UatZtkRwmThCyntcF8BNb2Uqfzax
	Csoonwy7rfnXBDOdg7vQK7riovb+/zBJAccla6B01aqDgyVyLoekFVC2UWpqUGtusaE5mpIQUwO
	1EEbiMu+BwAsq9ogT/7oQDoDDM9DKUpgWooi+n+cTDvtslVlTnGkuQYmotj1+bpMXZHYs0YqzVt
	zDBn452sfsdVTFO2L5c+SJ/2Ns2zBq65t5PoEYxyeKWWQIuw7HSSPuVbVua9vJb5T+KVgDHv3yt
	Ewen6vfFITF9KzmS0Rn5erMn33Ec
X-Google-Smtp-Source: AGHT+IEd45BbRxuJcc/ODzZoJKKfv+EegnhVjoVMaQy8U6rbvnXBM+bXYqV4j3BtClJXhPFYagq+JA==
X-Received: by 2002:a05:6a20:7283:b0:1ee:e16a:cfa8 with SMTP id adf61e73a8af0-1f2f4e01863mr2897050637.34.1740717169879;
        Thu, 27 Feb 2025 20:32:49 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm2738204b3a.132.2025.02.27.20.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:32:49 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:32:16 +0800
Subject: [PATCH RESEND v2 5/5] arm64: dts: apple: t8015: Add backlight
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-5-69e450bc4bfb@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=qZhdXikI6UVY1zdlQzyoBJcvZeFaA39QMPy5jc+lJ4E=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTxhj6M3NanBr5AvddymnbZR2d8cHPaGW4NzK
 2jryU6pj5GJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E8YQAKCRABygi3psUI
 JKWhD/9Kye4j0aRu2dTcTj19vBKZO44Ncolu40yJZDoGyjZ61paCAKdGVjuTcWY9c7tit399/J/
 A2uRCQNQFddsl6uIBMMMHvkZd1ldws1boplm2P90ltqOkQ9IsQVcUqia/WlcR3Tx2GG2IOI6ee+
 ypekvAXxcSeKhAvjl4Ds410iPec+ueF9PWWP3eFDHojA7ge+DH4ummzhnrtVscaECWM3zpd5/AD
 2lb4/jDhCWWZuWfdeUhTdl46zakdZIiFImP5OOHHbvpFUf+RPhcrV91g3BI7CVhL12TEZtmBNzW
 5T+0buNt166NeM90BHShWxPKH7fofypOIQFjrXydSF9XKchP27u8TClv3gBRS7cyUcmd18CbFm0
 SM2Y+pbIv3aNU5uf+B1ctiARPi4Gv0oAXhj8Agg+D3hMEb7fG5gfFHNoHJSqChlbEXqsr3GgKhm
 JLlA41rfnGvnZYt/SbXF5Qo57Jul7m7ikBXE7d6LYuzQuM4a5BJ3ZZDBiHOfDrprrQPKsTO914A
 hLEWFZ4wzSvzFatsslxPy999apbmmWTjmHtBNyqDphTDeL2eK9Vl7AN3zPuNpbmZrjbzisQzKze
 uUywQTswPe+5TkBYL0T+gWSnNDbFnGiyCp5iSnhoXlohNdDvl0KhN6RlxrjaZgX7MyyaR1pxQ9O
 5QOv4NskCVgf18Q==
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


