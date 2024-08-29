Return-Path: <linux-kernel+bounces-306444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF26963F17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6720F286F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EAD18E365;
	Thu, 29 Aug 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D16GhPuY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123518E355
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921530; cv=none; b=RUQT7ZtlsPNyxlhOWV9ri4goNOd7B0HBbQ4H2P9rQcMPbJxxuF0nbVSl1KSmR6dx59rwqSU+Dq1PVGZRZ3soxLAK+AFy9uspoU9sb69PmnPKXR8S8flOSM3ED9n/IPQn0e3OlmCl3ugfTVU3043BCwR7U52igRGNfAZ6hjJClCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921530; c=relaxed/simple;
	bh=U8Wxx2A86/hM9uHvSu4wzKX5x6eclhbGxoahVqz/w7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnH2aM7TZ6/lVgBheH1wX6Se1OtGCPPEMU94eVJUoPnfeDIv6z1X/UhbydQnMDAZu72q2VbIxNCaU0YoIFn0RB+8JIoxzUNInJAr5Ip7HOXTeRldeW9klc6L1qF9PZEsrERsMIcE+NNI2GpgESfvjE/746tt1Do1ZfEu8j3lOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D16GhPuY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2020e83eca1so4476875ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921528; x=1725526328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGXU5ZUf9Kum8MvTiT62dktX9ZINShim7TcYLEwJ+xA=;
        b=D16GhPuYRgvW+Vzl0urbWS8vwB7j8yCcyf+lSv7A582XzMd93A5JyoBppYO/QDrbEX
         zMlWh35PaCjyLuZNj7dtv218r103yVRjSK2RetRg5Wdy/1HiFgqHpKSXVHohL1FM1UKq
         NieD4GBiy/C+DQqKOo/s564PCSzUBTzVctCvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921528; x=1725526328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGXU5ZUf9Kum8MvTiT62dktX9ZINShim7TcYLEwJ+xA=;
        b=YZnlXsc+r6gHZ32Ityn4Jh3lhUEG6+MwmzEqPf9W2KzLD2c2GG4M101bOwAP/DYlJw
         ER0y/fFHQUbqZ3/11RidAFCWoF2tI9dE5hGFdLBHyb8BsT/fsTuBC5Lmvn5ESHt3CAZY
         upoIUFjIfGEk3h3ZsOfO+cP0greTDHHF2/CNVJGVC5uvLW9TSDa3A/EGHMoCJR2htsSu
         3jDwdiZn/WBq8XlWh7mFk9suLn1UtzjMyJ4IVVRPFlTJqo5ER7dGt10TF8zweoYmxbAs
         OAETVcb+aZK7woK5680t5QeKKYmxTpp3ywiio3ZSAc3l5J3xwLLuHg2atkJC5TgX1Mg6
         trbg==
X-Forwarded-Encrypted: i=1; AJvYcCUNmJQrUSA3UGtjkDWtDaSlHBVfcN9dIwCdHVtpB5cOlklzkdzYYBbNAqMfw/lBinIEuXN2D7NdsCsPTaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp26BRzPJ+YSfIj+SHdMEzi6h6oUUjjDl764yyf1AIdeFdmU2h
	x+Nr1vZ2UolibvoNvgnkFjsTDeBBTF3ov6stDhfszbWcoCixX53+dUXe/eTSzg==
X-Google-Smtp-Source: AGHT+IHUyBDCpfIX5P3V2AMkg3EedGNWdt2N5Ptsh59Vr2CDGX3G67sN2tw4UC/flCPqMmOzvy7RXA==
X-Received: by 2002:a17:903:32c1:b0:202:4bd9:aeb4 with SMTP id d9443c01a7336-2050c237b8cmr20017425ad.17.1724921528190;
        Thu, 29 Aug 2024 01:52:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:52:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 09/10] regulator: of: Fix kerneldoc format for of_regulator_bulk_get_all()
Date: Thu, 29 Aug 2024 16:51:29 +0800
Message-ID: <20240829085131.1361701-10-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240829085131.1361701-1-wenst@chromium.org>
References: <20240829085131.1361701-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_regulator_bulk_get_all() has a comment section that pretty much
resembles a kerneldoc block, except that the block begins with "/*"
instead of "/**".

Fix that and also rework the "Return" section and the error code
terminology so that it is the same as the other kerneldoc blocks
in the same file.

Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- New patch
---
 drivers/regulator/of_regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index dfa9f42d4629..cec8c3647a00 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -737,20 +737,21 @@ static int is_supply_name(const char *name)
 	return 0;
 }
 
-/*
+/**
  * of_regulator_bulk_get_all - get multiple regulator consumers
  *
  * @dev:	Device to supply
  * @np:		device node to search for consumers
  * @consumers:  Configuration of consumers; clients are stored here.
  *
- * @return number of regulators on success, an errno on failure.
- *
  * This helper function allows drivers to get several regulator
  * consumers in one operation.  If any of the regulators cannot be
  * acquired then any regulators that were allocated will be freed
  * before returning to the caller, and @consumers will not be
  * changed.
+ *
+ * Return: Number of regulators on success, or a negative error number
+ *	   on failure.
  */
 int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			      struct regulator_bulk_data **consumers)
-- 
2.46.0.295.g3b9ea8a38a-goog


