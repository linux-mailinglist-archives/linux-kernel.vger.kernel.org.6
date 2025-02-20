Return-Path: <linux-kernel+bounces-524121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41FA3DF69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84023AC3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDB620FA98;
	Thu, 20 Feb 2025 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJpFUIRs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305D20E03E;
	Thu, 20 Feb 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066716; cv=none; b=nmRbdJY8Ntsy0P3nza/kjsYatY+ifB60Nz2PbUGF9Fh4L0XU2QDaa50gBfnd4Ypiv/VBI7wHxvvN3/GRlCiWC0M5FGhBR1EVBwHdAjlM2Uv01p1+aPUCkUSMPKhaGxGl5CsdRXyAUev/pLiJ/CCLSsW6GWYLcR618OeMhlr7l68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066716; c=relaxed/simple;
	bh=fG5z+I6G4IAhE7dnPnquPSBWf8fdQscLoMVg36c2Odg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JU14Ts4Ob+IryToMs8/WEYxSclxMK/FLSyintl65YFZfqr90fOES2pKf3qdCsfIxsNG91UhZitSzppzfWwtCeXUpElPW8wDKrt0KCKiPjYLCsxBLbRt2hVFHV00tq3DQq3rQ7c3zeiBiMy3DPW6my+vODW36PXVVlZ2B1xG9hZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJpFUIRs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2210d92292eso31476015ad.1;
        Thu, 20 Feb 2025 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066714; x=1740671514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0YU2/erqWDrMnbDnClvO8uF+WZwecalDqDcoo48HoQ=;
        b=OJpFUIRsvFxTU0BB0ktIadLL3V8tDC5FiGD9bYBx8eIKEFI+rnRsFhXrfqCNJItYEg
         fusZrp3mHytfNrQNY8mX1m8NWBke1goWqnS++5VnXjDGSH+Ws76tKFKK1smdCrbYbb28
         Yw+s1ROhfdfQo74+kAqu5IAmTwBlkDs4PKeDCiKm84BO5Pxq3ngzYRe7HnCHJy8vqELV
         zfiQtlpiq9Ij5Fvn+bf+jT+iMJVu4T6letr8LhaXD7h2fAEZfNXqd0WdQQUZbwQjOphK
         0+/KvVwXSEU6cAILccgo1VtUuLzb72YrYyREg5LlBJ3+DDNh1twmo/XkJ+8nHPmxBs9Z
         Ekbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066714; x=1740671514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0YU2/erqWDrMnbDnClvO8uF+WZwecalDqDcoo48HoQ=;
        b=hUI02iHU6BAhS9c1vF1XPT/jY6xsRLo0KRlfmVeyFtD/wIKm1jRo3AFEvcgGV1HA+8
         C+Q74jmiaBYLcF/uwJ29RERMv99iQXcvydLkpOqL+iLNig1BuJgogGpNVFLJus/9xki7
         pRroPOrlELo1E2+q4rji6DIYUVc6iU/GKIKJMORz8cS9OSCU/7g29Y/d6ZV9BCYmucu1
         PjZhaNRjQGxqxlJSWsG7YriXf5DH/+nx7FrigEl/a/tTcfV5lnmH1pT6BPI9mVpuRD3S
         96Vm2LxlK41eJKcB8dzOmiZ0XRuow/lPjv9W6GpZkTFA1z8/5UpZy0+RhxzJUSENdcvy
         vGxA==
X-Forwarded-Encrypted: i=1; AJvYcCVWJEekEWWbijsUnsEH0UhLQkRxdr8KiVHbf95a5oJYYzOkkGheaFqTo2U9vUTY7dN8O5HZk8+SBS3q@vger.kernel.org, AJvYcCXgYB4iZsfdW6Q1z/uOY6mnMpDJm/GaMgzhzSZynmFIyHm9/3yFlHMW43lY9juyb7RExHHXyKpiAjm3KFhE@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjVIJHBoMJccUAYs/wPeZsy9i/ZWYsndtOwDd/79XX/urWuLB
	fp634M/hgVYIcbPXRlvD991/+jOrlJ5iuQfD0b+6oxiJVOGJhmIT
X-Gm-Gg: ASbGncsouf79TxEWmlDlfNky3vocBgCRo6UaN+LJe89qhjiBkpvHjhdedg5vc1jLpZA
	Y9A9jZC9konMPMvCgQr+CmkCG06FfYQSGac5Jw3MU5vs037Gl5ssIryGdTe9LIaAvuHO23LheL3
	WrPkYDkRaefTjIAn9N77t63kt9iDHqhEbLS8EXCpF3hZ3Ddvv+aaqUYG1e1cKFBbHXXbjrqBzKJ
	CeoSK3UfG4vB9OrkfzVKo3F3KhH+WBJBksq2ILgtUObte0nOxxjuGKtpyWMiNM33zU/gj5U4Bfs
	D5y8S0aaLwjGelyQTw==
X-Google-Smtp-Source: AGHT+IE8RED21Bp6xhI9HWjc7ruzxzx5fVu7CJktOQA+Nvq9/CXCB0o39pnbOtdMG0YPDQ7Bt5pSMA==
X-Received: by 2002:a17:902:e746:b0:216:69ca:770b with SMTP id d9443c01a7336-221707775a6mr131233215ad.12.1740066714503;
        Thu, 20 Feb 2025 07:51:54 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5349019sm123694345ad.36.2025.02.20.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:51:54 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 23:51:06 +0800
Subject: [PATCH 4/5] arm64: dts: apple: t8010: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dwi-dt-v1-4-d742431c7373@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=fG5z+I6G4IAhE7dnPnquPSBWf8fdQscLoMVg36c2Odg=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnt0+M8LE8bsWThAPeUR40vROINMJjWs37phpAQ
 3m62h1TqryJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7dPjAAKCRABygi3psUI
 JDb4EACoI0y7cteXJJ99qb6oFbOEw39+ZyQLxLjbcKIiBueVvQZo5pYL0TASPWLu/6t3+YmLFiE
 Grrnko+nnMva6uLuS+qfSsOUMKBNkcleZm7/TE3uUXddo8jM6WNqYzuo7wCUJJCOeNKQECt9mUa
 2SQ1/2GFkLPOGKZpw6gADOVSIPQub3gFo79123XTK3/8My3UAx3lZ037gcesBkePNE5yw87k8e2
 8o/k9ldBIGd7ab8o4+9QlnPO3KY4arfOU/d11dlFFoQCXjotqb9mIoV+jqyFfWXY+tcrIpZ1EmV
 JDc03nkvM+FhcRF+VR+eYd4U/EvD+qUiR6mEq1cez0PtEgM4o+q7w0k8JAcmwsilgW6LhoXRy5R
 OR8Fp3YAnYUKlPEiQ1P8QLiyKPj3DAFHAqQ85AJFQih7FLBp1WAgeGM2Q0UsmcVbFHsoCyOFEq2
 bBtYDj3MaRgGpyOC894pZjBYQJQ5gpdv3bIDNKmKLA3wLSz3N/g9tNBPTyLUSSygl1Qb3NyXvag
 Qcg6WaGsjOcUj97xTGhazI8EaEb2T7yJtjU5qL3kRq0u9AL9FWmgQCfszZyfpG7zinSec0mgSpp
 tH7IRdzYLSrU66PLmRfHGzLolNzqBfiWk8eyxLDJZYQ0Em3Tpd7PXSvoBDtvbIGmvl7WyDp10XM
 gFFtK7WMiVNFpzA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A10 SoC, and enable it for:

- iPhone 7
- iPhone 7 Plus
- iPad touch 7
- iPad 6
- iPad 7

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t8010.dtsi        | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010-common.dtsi b/arch/arm64/boot/dts/apple/t8010-common.dtsi
index 6613fb57c92fffd41c34a61a78e7bb6b1888a5ea..44dc968638b13814baf94e782f2267191ce267f9 100644
--- a/arch/arm64/boot/dts/apple/t8010-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010-common.dtsi
@@ -43,6 +43,10 @@ reserved-memory {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index b355d443ee476e7c98b352470e3b1b5d0fae7652..17e294bd7c44c7961cc3ba0ec5f4178840d5b9c6 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -167,6 +167,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200080 {
+			compatible = "apple,t8010-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200080 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl_ap: pinctrl@20f100000 {
 			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0f100000 0x0 0x100000>;

-- 
2.48.1


