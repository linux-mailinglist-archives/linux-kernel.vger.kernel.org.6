Return-Path: <linux-kernel+bounces-523675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E947A3D9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07F3173F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907E1F892D;
	Thu, 20 Feb 2025 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjnsLw+k"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A81F7586;
	Thu, 20 Feb 2025 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054156; cv=none; b=hpj/jhS+yQovSRPUX5ZqRc0xaNlaWuW0+K6SdHKps2bvQ4mGd8bPermlRA58qab9VtgXDZwCVUl01de8xNSoWtqTyDJNWVa6yLLxFizlKSSZs41kPm0b+1ZEz2wN5WKEgCspnnDSb1+qlN5CZZQKm+ZpgNHr6djvlM2pnkyGh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054156; c=relaxed/simple;
	bh=3dP0oDAIN/InBoJgIEEqaYRol8BwNynu3ip0BA5Xbxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3XcmLOGU2gPGLaYegqIViXqOsEldZwlO+Ura43Amf7+U0CO8QrczC1Y9d+hemn7RdqiJ99D6uf5K/2lofLlA4IygLT/eQh1vPbEXdtR6pSb96hDrDWXJ7jDaGlJxE3rjgStikMTP4aYGRgIWg1d+FjFEB8//veJg0ceH8/m2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjnsLw+k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d601886fso11880315ad.1;
        Thu, 20 Feb 2025 04:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054154; x=1740658954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBuJnAWVhO28mlOCOrO1xk7g+eWQaeRbOJaWHDeNHoM=;
        b=gjnsLw+k9GUp62NPNBrhiwTQRmSrSX62EHXISQpDc/myuGZZnNRC91WfD+f34FXqpx
         M/wzOtrKptQQznfGXRuweAkQXOzWgXlXphPQY/d8rxVFJPMBfpOeT4sUNL/siIDXCLxk
         B4SzQhTkHSh/VzXnoQSH6Ihj1uM0yrBGQOV5/1VozN7wsrxy9XXhJUuL5N7mK0OyPWa1
         uOz+mcfC9NoMPNiDlyJ8PCYpZeiM1q+QBFfxgIaTV32WHTVeHAT4dnMe1pmSiX9N+4NB
         cOwyCvxzWGuD9yvbavDSOUIWCHAezODCVQF2LLHmbzCAqN3/WCSV8HSgqGs2xnfLOYCP
         nMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054154; x=1740658954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBuJnAWVhO28mlOCOrO1xk7g+eWQaeRbOJaWHDeNHoM=;
        b=f+0tYbysu7+jjMenEZ52ZmkwSFjfQaMMT3srrBCKAZ/jWFC2UYslwuMzHyr8Vpxvnp
         KtryL6Ebzz5jBQuNImd1gMQNgWWpjO202hW6h80JaDnZ3dV4VnE/ISa9kjMECo1dmgZD
         /TTrlsfursr3fI7DYJN+2VKy8JJCHm3Jj5A9CLyKcSRO1TNtKFjjpbbQpU4gClMrS2g+
         DJGbRo6zIxeFcwJhY/v+GRIUQoPdg5cQmnv2LNdaLycwHeU3QdnL2dvmFn2iG3XowSNb
         5OIrtd/9x81sfu78LyccUWD6AKhZoWgI62qXZa9OgUZ2G1ZYVS+/+OYfZ3VlNlFF86A6
         8hZg==
X-Forwarded-Encrypted: i=1; AJvYcCUHd3KAHvbKnTT7Z8ri7dGxy+KWc5s2rQwtHvpr6fgfTrB1LCSUonmB76nwPY1cVBKDY0d4tmPjvzs1IUtG@vger.kernel.org, AJvYcCWouFCT6cAA1dCGVLnKGAUZrRcei9OMsgE3gIl13514qiwLNRosq+g0Plzb8bmMocZdfUawGsvRV4RE@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZrEcC2qQgxoraYc3kYCfuHD8D/c5btc0Rfl0KCX3viG+jk5U
	Mh5HaS24IDcC+zYG/dbks8eSBoZBQ36x0aeaUOlFVNOu2xoz5lKh
X-Gm-Gg: ASbGncsWz6VY/UnvvJuVViS2VF7aRvJua84vEn+tiUiSCUoglUyfh9Yj7aiVDizgJP8
	HPgqvvl/AhKSNFLS0Xo8gmRgUzPod64ZOS46oy7b9tNtQH1tdJLRtu/MNEeFtHUjwmROleF28gX
	z8gYJf/PAIA/7apWKL0nbcn+5ReLEUjZhzSvukY4SsXk6wZbx5hULUXJooZjY9Kd79qmqfwK2K+
	IhxA4BT8NclW03d3yRLWR2Fjn9qw5PiMUhZvJvPU36omasfW29mcUvK+xrhsqaedcbMznwcNhTz
	i2HpKWOlW4vretbfew==
X-Google-Smtp-Source: AGHT+IH65NfsjOzwTpqmb7nGlYrkljWx2zuSmpAI4ns0SFN1VCagsWWVvimBp2kuvzzwPZxNgSongA==
X-Received: by 2002:a05:6a00:3e0c:b0:730:75b1:7218 with SMTP id d2e1a72fcca58-732618c1ec6mr35494739b3a.16.1740054154443;
        Thu, 20 Feb 2025 04:22:34 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:34 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:44 +0800
Subject: [PATCH 3/9] arm64: dts: apple: t7001: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-3-2c7011097768@gmail.com>
References: <20250220-caches-v1-0-2c7011097768@gmail.com>
In-Reply-To: <20250220-caches-v1-0-2c7011097768@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=3dP0oDAIN/InBoJgIEEqaYRol8BwNynu3ip0BA5Xbxw=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5+6R8kl4XjwXno6F3R1YST47PDcS75fBq9D
 rJWwg4NDTyJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefgAKCRABygi3psUI
 JH6bD/4+Uuk91oX9dOv7aKSCauwvonXydDd98FtccI7OIe68dRR3+FUfJTG8uyXR+pYU/mNKFzR
 ZZUoH0VGqFto509TYITNK/SpkOdFyiXL6HeAwk7qJOfsPMRc3sigral9s7lvLIbUdtUiz6HnDCf
 fBBBbikZwjRa+DD+uJaQlRC1w1anizTEWrGL6t64YZfOSj2AbeJL7Zstv6NQPVhGPkcYfTZdtwL
 81ZYUXPCHpSPuqWPS4QOYAsJUQU42XHCq/bti9nI3Tck9VSZ1nKy+re7Qn6os6ONPaZB78/FNHS
 5e3wazbFon98qhpKB9zaR386r5uHoVcCidjHi2FW3s/zL/3XFOifV7QNwf0EpJRJFGrh7unBGsY
 21iPBE1hav7RAnWirgmnQJELJ2Wb0M54976wFqtSC/DLGK8+v4Ly//P7s2z8tWESSKshNVpqNzi
 l6V1S2D3hp5E6xIh9l9Z3YuOPdqotRyTUZmjoAnJpl4zG97rdRDqpynbdwTyGmNncZGeo4ipggQ
 COriGrhTb6WgOIDPzd2Uu+uesy0JCbkMnrTyc8npg7Xo86G/lCxfhS/8BT03so0KmwrYgr4OcSW
 sKQGasFL7wwrZv3Ru2IDH9jP+tpRlD1CVdwZLJWbPXioIlq2obTiTytTwZ+4bG9TdjEYKMzoCva
 HsyzDzgsE+iB+/Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in Apple A8X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7001.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7001.dtsi b/arch/arm64/boot/dts/apple/t7001.dtsi
index 8e2c67e19c4167fc6639458ce79588e153336603..a2efa81305df47bdfea6bc2a4d6749719a6ee619 100644
--- a/arch/arm64/boot/dts/apple/t7001.dtsi
+++ b/arch/arm64/boot/dts/apple/t7001.dtsi
@@ -39,6 +39,9 @@ cpu0: cpu@0 {
 			operating-points-v2 = <&typhoon_opp>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu1: cpu@1 {
@@ -49,6 +52,9 @@ cpu1: cpu@1 {
 			operating-points-v2 = <&typhoon_opp>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu2: cpu@2 {
@@ -59,6 +65,16 @@ cpu2: cpu@2 {
 			operating-points-v2 = <&typhoon_opp>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x200000>;
 		};
 	};
 

-- 
2.48.1


