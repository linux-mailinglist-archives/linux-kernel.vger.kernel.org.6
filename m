Return-Path: <linux-kernel+bounces-306437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD1963F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AA9B21A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10418CC00;
	Thu, 29 Aug 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcZ4dMvX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903618CBE2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921514; cv=none; b=H8YBOWbzs56v/u4M+HnrHFTSlDVOkUaRRs+Fi4ZWHXVgCxeJgRKN8GHnyowGjY/wEjTAlc0L9BTJseXiMhPVRkA1l3pw6fdXZouK0WOFkkwIDhniRO878Oe0CLUnS7XwXFsXbXdOI8QVaDgQiFDDcGLT7hhY2FkqfKtyQx2Mzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921514; c=relaxed/simple;
	bh=rI1cuM7zPA2AWIuXq4oowgaExrrcgVvEGWOi1YCarxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trBLrd1eKT69xxYjOyLlKNtOJR0o46xlZalSjmW0Pn303q8G8CDHsEYwZjI25HdJf4AnxbpdFp1xyHKi5MFtxIUZ72NoMUo2OXQOsWIRo/Jjn511lba8zNomm6BAdxGN2YOATwVwzwxAcqjO05cwfYA32UBoJGsfo61HckBr6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AcZ4dMvX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201d5af11a4so3455125ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921512; x=1725526312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DtBpQpzoEhtHDP36c0mJ9L5tYUfKN1YBrSu8HK2DxM=;
        b=AcZ4dMvXRL/uzIn5cTJCHvT84f2VsLaK39wTEipV3fQK9Wli9j3oHrND1XeH49zMlC
         1KCOuygdhLbkjfD5etkqsmnEy+UwAhEkdwcYlgx/Ogt2APN2hwPiDaOUtMTnAdOVh/yZ
         qxSxJR5wrwoTfkfQkQ/6Do3UfEMvklKS8US2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921512; x=1725526312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DtBpQpzoEhtHDP36c0mJ9L5tYUfKN1YBrSu8HK2DxM=;
        b=YnVqApGsVKK8G2WuFNS61IzrKJle2Y6f6mMyXaeC3ILjDZdHL5f3EmCm9yikEErU3c
         UHS0KvIS3LGtLwpTGvPUeY/mJT1NqH1v3z6mJaSY4okLgcWVYktPkiqQ6QTRc7runLgg
         WE9GPg3JA1u5FE0Gh/zZHnj5OK9DQk2Tb2mR1Qp53kK0E+/MBrDTaozGPU54ZGig1thT
         zbRZfhxfGRuy0eKwa6+ZPA1OI8WFt/PaMoTtr94yDwfxGIIdg6BDwf6/xY5dRrStByfv
         uZR7DWkyKrUdWXBGdNokpgTlWDI+lhMiwxf2v2ewm4iqZAingT9wVi0sdSmp68UvO0lv
         9k4w==
X-Forwarded-Encrypted: i=1; AJvYcCWOqY6GVxDIppAVVwqnCPoSC/cq2WpbToMy4hB6gcK693nza/NKfnkatzPOtz9NXAA3I1OvDTB+0wWM4bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgcDE2FUwWy7bby5IVUQxmSbWQOQzfJpJy7mDv5+V/z0Drd+X
	Nh0rivxjEzoErEhryyadBZG+M6Vf7SMv83HbompqIpYoxRVgzsBIHS9cSgoJ2A==
X-Google-Smtp-Source: AGHT+IEcjaIAJ52LI0Yoz6FfV49r57/iDw8FfyvOIgo4jwrVsqHjPRBovzCDzdVCqzFPC1qXPu6OlA==
X-Received: by 2002:a17:903:647:b0:205:79c:56f5 with SMTP id d9443c01a7336-2050c3777demr18432935ad.27.1724921512415;
        Thu, 29 Aug 2024 01:51:52 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:51:52 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 02/10] regulator: core: Fix regulator_is_supported_voltage() kerneldoc return value
Date: Thu, 29 Aug 2024 16:51:22 +0800
Message-ID: <20240829085131.1361701-3-wenst@chromium.org>
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

The kerneldoc for regulator_is_supported_voltage() states that the
return value is a boolean. That is not correct, as it could return an
error number if the check failed.

Fix the description by expanding it to cover the valid return values and
error conditions. The description is also converted to a proper "Return"
section.

Fixes: c5f3939b8fe0 ("regulator: core: Support fixed voltages in regulator_is_supported_voltage()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Replaced "true, false" in commit message with "valid return values"
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context
---
 drivers/regulator/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 763048d6f1ed..0ce3fe1774fe 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3456,7 +3456,9 @@ EXPORT_SYMBOL_GPL(regulator_get_linear_step);
  * @min_uV: Minimum required voltage in uV.
  * @max_uV: Maximum required voltage in uV.
  *
- * Returns a boolean.
+ * Return: 1 if the voltage range is supported, 0 if not, or a negative error
+ *	   number if @regulator's voltage can't be changed and voltage readback
+ *	   failed.
  */
 int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV)
-- 
2.46.0.295.g3b9ea8a38a-goog


