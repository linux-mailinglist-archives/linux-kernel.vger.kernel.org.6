Return-Path: <linux-kernel+bounces-536341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9498FA47E65
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197E33B1B43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723E22FAE1;
	Thu, 27 Feb 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJvuX4mm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0022DF99;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661075; cv=none; b=EgRZZ6CKjLAgnojO/JJfpFuKBRCsfUfBPQWZR4nlmQmQK35dX+4HZ2WRPK8qJvWoDmBxsfBuT4XIaB7Z5IWOlRFuSBBDS/zOUUpTIaXdz9Ca76CvUsKq0YmKylAuxMfiNfk4t5NMJ1cXojQh/poz6KnO0o0nFORuVrCR8ScpSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661075; c=relaxed/simple;
	bh=kEZrX72/lSloh5I+sGS62hbeb4KZC6fi2m86m4hb2wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtX34aTyOBY9xitUWAr9LNqyQAml96u5UAELLjlQ8EDpoP5h44DEvgkx5/T2NbJdvwojY7XJuWQgW/4TqfXMo7ITvgK/g2fpcHyLmiw5Yl0mUz2JHc75IN3C/mBWMn/OasoppEvFVrgmSamgQu4HIn+5w5AmJ2ySvILSuO6o6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJvuX4mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43DEAC4CEEA;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661075;
	bh=kEZrX72/lSloh5I+sGS62hbeb4KZC6fi2m86m4hb2wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vJvuX4mmy/cX4JNjFmGIGZuu7qgnYNng+Ufrmo0+O3nKqAVezKO/gueRTfEKEv6Ni
	 J9TtZA38y+0d0QjJwA9y7jwqARRgj0VUn9TRF9crplNPe2euLnXStjM85Lhu4rcHtT
	 4BjZ9IMkuDKr2UT1KtmnQeAF5V9vV6RmbP57SKvzUU85MNWsvG7i6qnqCYhAIxzKDV
	 8DXoE4gn6p+PUBNRgGCKaVkM6MEW4Np3kVTm740+Ggu3ZqVYXWRDDR3MaWhV4lhNG6
	 hn/9RS5Y8MUGLOeWxQv+5cWRbnLH4kemPctAWBhK5//yEQYRoEEN4y/RCvugyxRKA1
	 X73DmdJuVqeXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30CC19F2E;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 27 Feb 2025 13:57:53 +0100
Subject: [PATCH 3/3] hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor
 table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ntc_thermistor_fixes-v1-3-70fa73200b52@gocontroll.com>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Joseph McNally <jmcna06@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740661074; l=3425;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=JzTO5KFiHcrwpuT7BW1qiQaJXRCQVMkUIuPMKe8dI38=;
 b=3Q1xEMiSYUJiPAasiu4enywjJAFYhRtoCZ/D0o0+tV7hAh/q14mK8ZPD24IbkU8mBvl7N0ScU
 7Uf34Hr0xvlDf1PmiNhn8l3l3Fj6RsnbdPu59Sl9Qbm7Wbo0GEOg2uc
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

I could not find a single table that has the values currently present in
the table, change it to the actual values that can be found in [1]/[2]
and [3] (page 15 column 2)

[1]: https://www.murata.com/products/productdetail?partno=NCP15XH103F03RC
[2]: https://www.murata.com/products/productdata/8796836626462/NTHCG83.txt?1437969843000
[3]: https://nl.mouser.com/datasheet/2/281/r44e-522712.pdf

Fixes: 54ce3a0d8011 ("hwmon: (ntc_thermistor) Add support for ncpXXxh103")

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/hwmon/ntc_thermistor.c | 66 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index b5352900463fb9b4fc68605a73feb8875961f554..0d29c8f97ba7c2f264588b6309b91ca494012ad6 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -181,40 +181,40 @@ static const struct ntc_compensation ncpXXwf104[] = {
 };
 
 static const struct ntc_compensation ncpXXxh103[] = {
-	{ .temp_c	= -40, .ohm	= 247565 },
-	{ .temp_c	= -35, .ohm	= 181742 },
-	{ .temp_c	= -30, .ohm	= 135128 },
-	{ .temp_c	= -25, .ohm	= 101678 },
-	{ .temp_c	= -20, .ohm	= 77373 },
-	{ .temp_c	= -15, .ohm	= 59504 },
-	{ .temp_c	= -10, .ohm	= 46222 },
-	{ .temp_c	= -5, .ohm	= 36244 },
-	{ .temp_c	= 0, .ohm	= 28674 },
-	{ .temp_c	= 5, .ohm	= 22878 },
-	{ .temp_c	= 10, .ohm	= 18399 },
-	{ .temp_c	= 15, .ohm	= 14910 },
-	{ .temp_c	= 20, .ohm	= 12169 },
+	{ .temp_c	= -40, .ohm	= 195652 },
+	{ .temp_c	= -35, .ohm	= 148171 },
+	{ .temp_c	= -30, .ohm	= 113347 },
+	{ .temp_c	= -25, .ohm	= 87559 },
+	{ .temp_c	= -20, .ohm	= 68237 },
+	{ .temp_c	= -15, .ohm	= 53650 },
+	{ .temp_c	= -10, .ohm	= 42506 },
+	{ .temp_c	= -5, .ohm	= 33892 },
+	{ .temp_c	= 0, .ohm	= 27219 },
+	{ .temp_c	= 5, .ohm	= 22021 },
+	{ .temp_c	= 10, .ohm	= 17926 },
+	{ .temp_c	= 15, .ohm	= 14674 },
+	{ .temp_c	= 20, .ohm	= 12081 },
 	{ .temp_c	= 25, .ohm	= 10000 },
-	{ .temp_c	= 30, .ohm	= 8271 },
-	{ .temp_c	= 35, .ohm	= 6883 },
-	{ .temp_c	= 40, .ohm	= 5762 },
-	{ .temp_c	= 45, .ohm	= 4851 },
-	{ .temp_c	= 50, .ohm	= 4105 },
-	{ .temp_c	= 55, .ohm	= 3492 },
-	{ .temp_c	= 60, .ohm	= 2985 },
-	{ .temp_c	= 65, .ohm	= 2563 },
-	{ .temp_c	= 70, .ohm	= 2211 },
-	{ .temp_c	= 75, .ohm	= 1915 },
-	{ .temp_c	= 80, .ohm	= 1666 },
-	{ .temp_c	= 85, .ohm	= 1454 },
-	{ .temp_c	= 90, .ohm	= 1275 },
-	{ .temp_c	= 95, .ohm	= 1121 },
-	{ .temp_c	= 100, .ohm	= 990 },
-	{ .temp_c	= 105, .ohm	= 876 },
-	{ .temp_c	= 110, .ohm	= 779 },
-	{ .temp_c	= 115, .ohm	= 694 },
-	{ .temp_c	= 120, .ohm	= 620 },
-	{ .temp_c	= 125, .ohm	= 556 },
+	{ .temp_c	= 30, .ohm	= 8315 },
+	{ .temp_c	= 35, .ohm	= 6948 },
+	{ .temp_c	= 40, .ohm	= 5834 },
+	{ .temp_c	= 45, .ohm	= 4917 },
+	{ .temp_c	= 50, .ohm	= 4161 },
+	{ .temp_c	= 55, .ohm	= 3535 },
+	{ .temp_c	= 60, .ohm	= 3014 },
+	{ .temp_c	= 65, .ohm	= 2586 },
+	{ .temp_c	= 70, .ohm	= 2228 },
+	{ .temp_c	= 75, .ohm	= 1925 },
+	{ .temp_c	= 80, .ohm	= 1669 },
+	{ .temp_c	= 85, .ohm	= 1452 },
+	{ .temp_c	= 90, .ohm	= 1268 },
+	{ .temp_c	= 95, .ohm	= 1110 },
+	{ .temp_c	= 100, .ohm	= 974 },
+	{ .temp_c	= 105, .ohm	= 858 },
+	{ .temp_c	= 110, .ohm	= 758 },
+	{ .temp_c	= 115, .ohm	= 672 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
 };
 
 /*

-- 
2.48.1



