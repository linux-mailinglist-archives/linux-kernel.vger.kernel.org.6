Return-Path: <linux-kernel+bounces-430177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FC9E2DDB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C29B65E35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE620ADDF;
	Tue,  3 Dec 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP+xuWbG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506A20ADD3;
	Tue,  3 Dec 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258331; cv=none; b=qgsYSsP2Z8jDN6CbR7znCD55sjjRgGeD+87agN7Xp7YaMqVzqJKgWxtiGqxmQNtSLYeypCOojHglhapxP3dFhBJy+eYUK59qZ7uZkXtJFuLAzweTX4RCg5IHeMRnW4AhEAdccxRzDBjmVDpK6E3LHU7J1AgNF4xiYN1uWP3HviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258331; c=relaxed/simple;
	bh=Q02EZGTan8yKgqkTOT2L07J0GBNRMfk/qcvIL6ZIAdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEqO+BQ0rlllHQr6Zn+xJI74Vc/bE2Xa60p/s7/7Xs5amNN5AGs5T2g8k6HK4eIAKACISmSvTzqkpGTCLoqzCIfNF5pk6Ox4NE+AATL0jN6JnWpxAAxoaTYmixm4mAm7jyjzdHn5xHaKR4K31uRe9DzcTRgeVXCLTpg+kt9IJlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP+xuWbG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso55813335e9.0;
        Tue, 03 Dec 2024 12:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733258328; x=1733863128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKcUXU+2AOUg6QNTCMofP8uzOqzKgrO59wIKpeJpBe8=;
        b=bP+xuWbGR1BFBx71doL5slAexnDyb0PTJ/V9WRwjTJiHN2Z5uTtOGYM5LT3vMAOG6w
         v5LehTNgXePsMhiVimz6SpuDkUyxDjDFWtJmHUPGcCna9XyNzW87g1AR1qYwmvNPOOC/
         LbK6FGFOWqZ58TdrSJkeQS0W+2m/Cktc2cz1V3l7euJu7B5gp8MUSi9+VW0IdREfQLsT
         7u5Qj9lThGUNhEgn1hvN95PrzdxvxUCSBUVh+5mZddajA101FKtzIkZwuwW46vuCZRlR
         6fGC4ffXLwi5qdYaNEab0o9HNWEoB3F759Og0SK+Q4fterCQ8IBvyGOfRnZpV7CTutGj
         hY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733258328; x=1733863128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKcUXU+2AOUg6QNTCMofP8uzOqzKgrO59wIKpeJpBe8=;
        b=IK2H0V9VAel/8EXj+6o2blkC4SoFIOcvkwKFutw3NoldRvliX8l17S1NnP+JSbUBtq
         XbHvKByPNQAPJAgtq4GV+UYC/B1QSIY8d2lOTU+kRCKGdnytXPsoQbYXw0RD47cgfnG5
         ydHQZs15Qnm0t16DC6OOUJv+tna/8/xWrkF9pdJSoHmMJID2DWo3VaBQ92Ad1jxXS9Zc
         swacegiNzfOCMsMB1YqTpPYqsA0fTRJ07gVyIrRrYG9+5mv1Te/WA/sov/UiA96Gdoma
         8X7yy/Qy3ZaxwjU+SFLHFWTIVv3z8+nlvteSS5fXpEaSjw+hAVDHJOIbAc5BqshKznOn
         /Unw==
X-Forwarded-Encrypted: i=1; AJvYcCW49oRKPnfRxyzBxva75TCk6cg+4G/YnQVR1KlNJTKziV/Fj/C8unSMm8WUmjVgrLZb/wPjB0JOKDee@vger.kernel.org, AJvYcCXACk59jhe/yfawyKi/ox7F1dSSqunKEiS0FawkMUF3rlW1nIiLllzewNh6pX+XpUgz/Hezcp4/sgu8Z7QT@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaBe+L7p6gcHSefoxb4rsCCcKrnGdRMbaR/IwySVie7OX7SKH
	f1REYLwueQN39iYUzNiv0IwCLprI9TE8od/AmH68hhrybcHXMUYxZW9V1H5A
X-Gm-Gg: ASbGnctuYUhrBhG47zHz531FeGnSzYStyiqqDZolZ9GJXwFJVS/ITCuAOE7LjFr+MgR
	kM5IBBBhoAgbgPRB1JixP2uGqqa5TKkVCUu1IWp+U1p+l0b4+0aWmdCnKXlgfWBgMwcUgo14IhI
	XMcvwS7sdb31M6CgzVEsEjZ7ktRwrwdoy0H2aXUcjj76K8HY6n7TlnmSXQ74kBF0jPT+WsENbBJ
	IVPoOT8sQovfYQNdPHYW2Zl2lmh8o7TJF9T6kfZBRO5V/Ky8veNo4v8h+zsCgh0gvkvFeVxcm+D
	56JyzREAY60kMvDerunryOuT6dfce+yIWfLTI1k=
X-Google-Smtp-Source: AGHT+IH9uBgSdnHGS6bnhvmeoiLM3AKdhhwAPsU89GFG9+bxT2CRResLtnMTRB1w5ZTJPgDgULimXA==
X-Received: by 2002:a05:600c:19cc:b0:434:9f0d:3823 with SMTP id 5b1f17b1804b1-434d09b65cdmr36523055e9.9.1733258328079;
        Tue, 03 Dec 2024 12:38:48 -0800 (PST)
Received: from localhost.localdomain (229.140-242-81.adsl-dyn.isp.belgacom.be. [81.242.140.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763c50sm231266915e9.12.2024.12.03.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:38:47 -0800 (PST)
From: Philippe Simons <simons.philippe@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h616: rg35xx add missing regulator-ramp-delay
Date: Tue,  3 Dec 2024 21:38:23 +0100
Message-ID: <20241203203824.23306-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AXP datasheet says that ramp delay is 15.625 us/step,
which is 10mV in our case.

add missing regulator-ramp-delay to dcdc regulators accordingly

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index 80ccab7b5..b6e76a804 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -238,6 +238,7 @@ reg_dcdc1: dcdc1 {
 				regulator-always-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <640>;
 				regulator-name = "vdd-cpu";
 			};
 
@@ -245,6 +246,7 @@ reg_dcdc2: dcdc2 {
 				regulator-always-on;
 				regulator-min-microvolt = <940000>;
 				regulator-max-microvolt = <940000>;
+				regulator-ramp-delay = <640>;
 				regulator-name = "vdd-gpu-sys";
 			};
 
@@ -252,6 +254,7 @@ reg_dcdc3: dcdc3 {
 				regulator-always-on;
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
+				regulator-ramp-delay = <640>;
 				regulator-name = "vdd-dram";
 			};
 
-- 
2.47.1


