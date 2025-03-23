Return-Path: <linux-kernel+bounces-573039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7FA6D232
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C593B7F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA31F8690;
	Sun, 23 Mar 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHbphFSY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91E1EB5D4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769587; cv=none; b=ujmdoOpXHVJIrcUV+wGiKyACz1E7UvRwuMWUYNJdTgOUbgJB21uJ2JaZZFYRX+ca+LenJK6YRKd/1QsM0NiK+FumfYFJxUORmbc0CI9Uj0SLnQJWvMOmdt6lTDQ22lDUzHPf2rRZjUU9e5K92C6R3T8EutZVt8B3bdk1YPIybqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769587; c=relaxed/simple;
	bh=6qUMnnrlHHUbgLCde/zD0N2oNsEsgjH7lEf2K9i3EHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uobZufrpC5FoZh/GNFaKwrnNJt+t+F5zYd7GhRuAmwcQ/tPcAT+ANQqWnfx2iB2AlZ0RrmpWEhOuT/iaTFDvDznxOT0u0clOYug1+WUZ0n2Y4srVnXeJT/YKfnYu2OI8Qjmci/D4M6D+4y62fcSIK0z+X6OxvfgZf5Yx9vu035g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHbphFSY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso689706166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769579; x=1743374379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHaTbCMsBXEPy+wffmMjNGPy/wKjQsHouvVH+3/pTJ8=;
        b=KHbphFSYz2QnhFS2dmIqOpu+K5CNichuxCqtiNn6yUUuNlTOlfkUmuag1+FWiGgf83
         jrfmeBlM7IGsZBEEx0n3r68Kco+iUvayvCZLPznhRebIelrrBk6Kuh1ExlFXJ4gupnVf
         tIVaee/3Tzsizl7n7kd9j+bW6bFkZ4s7AKpb6R09opWwGO4s6lGUUVB43NF4tcpAIwV3
         /2vRKbc2PIh6FsOBs6eHyaqeZi4GwjBT7yKdyh2b/EQVFAdJjOvIXi3Z5RdmPd4Rb2Wy
         BxZZTVWEHOdTWmQAys6XzyjM5HOzheakCF3MrVvj7nSuL4K7pLwdfUV2tWnVZLida5CA
         08Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769579; x=1743374379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHaTbCMsBXEPy+wffmMjNGPy/wKjQsHouvVH+3/pTJ8=;
        b=MbxYE2wp0sA8FRLUz+upP6K3RTi93lLphzyI1God/cEdZu0aBKuInGp+4m6c3x4j8G
         rH6OqotpQF7Y3uMk+DN5dxfdYY1ftA3DoBpcaSudwVMl4y7LsAgL6kNO6U54t9sybwuy
         gv3F1iIp0nFkPdrh6HJF3UpNgL29A1Kk4QSQKc0MxA3KRI8DD3IRkKdEnESHUHQetuOu
         +23JU9RCp2Zuvq++mYC7ctOAju3u61Pq2jXMUEWVrhbmac7Fn8/ZAVMfsXxuM57zNN0x
         IC5fjxo6oBPvu8pZSS0myLbQTKSRerxG+uX9uAYXzQ7IZQXBxjhpTURJXd5vfC8O9IAV
         GpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTU6DJCgUTZms4hJOENltWRmb1a27ACahy+YKENRmmQhmS//47SJlxcf/zOgQqvSYqKXzDmqIFXa16uKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+nFOvgUWdsRGhif9xFwWITfOXCZXbXv2xoRUcSOBPs8ETuGP5
	w270+odhgG5dMxalWUo4+3fZLydvesIrRBeb2Z9C1e8r6yHULQppU1bnErN+oPM=
X-Gm-Gg: ASbGncve426b7Qwje/xaBRMadXF+b5kRIQfftmjc3PH6qJbMe4W9sjpTlC7x7iLayiB
	eG3Mg9uKpcIXyj/VLyAmvp+jSE63QY0eCDNi3+jJmjpknuAug+RncwROIU2wWmdtmZITmwxvOTk
	My87hqIzZUH9HrmVO9guiKEG6uPhhv0JrDL2iSlDwGvbwzcqcMuTP9WwTxcpw08o2KTyFfeY422
	bqyCaLKVS/HbdJo1uoJZEjNNaYTUVYSXWhDXagANs57vwHXv5TkpVlYtxksZAFt0zjCPQiUt10h
	+n+qH/BiX3nXP/qv3MygHgpqSZtpRLYa7Zlu3dfGINiTZK6CdRrpapW8npEKTlxwdZ/I1X/hGtH
	j2XAviE/9FnFUvw0WG3n39JkFmxoG
X-Google-Smtp-Source: AGHT+IE8DhyAI41xwJ1273XUXoV37Lt8dbT+04E2oAAFhJgLPXY5M4zmkgkE92YY51ZbbO2cYsb3Mg==
X-Received: by 2002:a17:907:d84d:b0:ac1:e18d:a738 with SMTP id a640c23a62f3a-ac3f00af8famr1143082266b.3.1742769579059;
        Sun, 23 Mar 2025 15:39:39 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:38 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:42 +0000
Subject: [PATCH 26/34] clk: s2mps11: add support for S2MPG10 PMIC clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-26-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for Samsung's S2MPG10 PMIC clock, which is similar to the
existing PMIC clocks supported by this driver.

S2MPG10 has three clock outputs @ 32kHz: AP, peri1 and peri2.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/clk-s2mps11.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 014db6386624071e173b5b940466301d2596400a..e86a762f80ccd7485a9f2a6f567b81bafe119874 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -11,6 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/samsung/s2mpg10.h>
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps13.h>
 #include <linux/mfd/samsung/s2mps14.h>
@@ -138,6 +139,9 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	switch (hwid) {
+	case S2MPG10:
+		s2mps11_reg = S2MPG10_PMIC_RTCBUF;
+		break;
 	case S2MPS11X:
 		s2mps11_reg = S2MPS11_REG_RTC_CTRL;
 		break;
@@ -220,6 +224,7 @@ static void s2mps11_clk_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id s2mps11_clk_id[] = {
+	{ "s2mpg10-clk", S2MPG10},
 	{ "s2mps11-clk", S2MPS11X},
 	{ "s2mps13-clk", S2MPS13X},
 	{ "s2mps14-clk", S2MPS14X},
@@ -240,6 +245,9 @@ MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
  */
 static const struct of_device_id s2mps11_dt_match[] __used = {
 	{
+		.compatible = "samsung,s2mpg10-clk",
+		.data = (void *)S2MPG10,
+	}, {
 		.compatible = "samsung,s2mps11-clk",
 		.data = (void *)S2MPS11X,
 	}, {

-- 
2.49.0.395.g12beb8f557-goog


