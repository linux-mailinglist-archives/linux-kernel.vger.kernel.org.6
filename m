Return-Path: <linux-kernel+bounces-303029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A8396065E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14F21C214E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42A19E7E0;
	Tue, 27 Aug 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dl01uO9G"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D519DF65
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752564; cv=none; b=lvFZd6WHCg8LFd7pIKgi9Q0mR8oGBifPioDXzKXyhHNLwLrAv1fDUVwnGQHKrYhXiaxTS4Trtto/2E/CY4EXwlAW3Mf8CqeXqgQSc432jSZ4ao8y84yKV3R4d2XS3C13M/gzLncMXwHppIw9u+AdCGu852UxwepbYNjRzlRC7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752564; c=relaxed/simple;
	bh=9eletfkZoOidjC/xY6StFxKzNyYPlUK7lRHiXuisd4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDYZ6xNvADJNC4ORvV43pW+/EbuJC5fWbmMOVx6CrVs4heITUSfd37VuNJZYPA4Mr1QESL1FeTvMY3nleyFKKDjxRySpJQ4dY9oeiMmPZw+aJTFPQW0xvAWAT/Rxz0oKnAbLzDZBkTnPQjB2tYUevMicnkCBBjAR2E+eSh9bOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dl01uO9G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201f2b7fe0dso45377765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752561; x=1725357361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5dITA99bOKmhMprOxuF3vZ8vny2EwMiPeFLCOo3XcY=;
        b=Dl01uO9GOkqchIB53dVKdofarXuUgTrXAk7cDyuODXV9EkZ0PfGsb8yEM0NfcrbX8J
         tRhMqU/viM6zC7EeVn47HnGCB6/g9sftCD87g5q12O//48KLKZsisDIL/g6MzQNAC4js
         zic9RoLMGZ/GRNE/vutRgj0HJ04AVIdmlDGf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752561; x=1725357361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5dITA99bOKmhMprOxuF3vZ8vny2EwMiPeFLCOo3XcY=;
        b=tKV2f/cfmaJzBMLevdzQRyh9/bPNMrh8nx/ucWkZ2uWyfcFw2ai97O1xDOUi7VaX+y
         a+O54itJjKvEd7ANiaPlX4XzQ2aeNP6YbZKmTx5ALHs4TPES7ut3sqMnKAOpcCpCnHRx
         bP4UHSrWS/+AS4I/BpDyv9s+str5CIspkY6cOsc72Ve7Q11/H5AjCuayQQLFb916Q7nD
         uljgdPP8VvJCQImU7LkL8WOlqN8ozOjxGyIVlzOrS+2O2GxcjbEbaMNWP0PimTrYQAMP
         jRbbzqfszbHutD7FcaF5qlJgXMVkKzgS3oqReDcG0Vv2ydtixl6Xb0dIluOmT79zfWRw
         Xt7w==
X-Forwarded-Encrypted: i=1; AJvYcCWYAeWJVEmbrfl66ZT15PecRWWC76KskM4jMgReipvAeVvegCwHgatF774E7zHkkWi7vIz9D/tteG4zB70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZSm7DbRnOfkw+EFPVIe9H+M/FNmNmtCcqavKBj6KlmwiSQva
	corO9Fn5NUAQ0yFLoKc2o9ZHAEHApDUaBL6dUimDPeDOPv9iagWF5ZD8bc5dTw==
X-Google-Smtp-Source: AGHT+IFxyh4Dh7I2pxOeTqe3BqQCexIZIRHzvyu5zz5qW6LwCSFvv6FVccQkTwPQyRBDrynayef2Cw==
X-Received: by 2002:a17:902:e842:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-2039e4b5193mr94212775ad.33.1724752561488;
        Tue, 27 Aug 2024 02:56:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:01 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/8] regulator: core: Fix regulator_is_supported_voltage() kerneldoc return value
Date: Tue, 27 Aug 2024 17:55:42 +0800
Message-ID: <20240827095550.675018-3-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
References: <20240827095550.675018-1-wenst@chromium.org>
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

Fix the description by expanding it to cover the true, false and error
conditions. The description is also converted to a proper "Return"
section.

Fixes: c5f3939b8fe0 ("regulator: core: Support fixed voltages in regulator_is_supported_voltage()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 763048d6f1ed..3a1b6fd9780d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3456,7 +3456,8 @@ EXPORT_SYMBOL_GPL(regulator_get_linear_step);
  * @min_uV: Minimum required voltage in uV.
  * @max_uV: Maximum required voltage in uV.
  *
- * Returns a boolean.
+ * Return: 1 if voltage range is support, 0 if not, or error number if
+ *	   voltage can't be changed and voltage readback failed.
  */
 int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV)
-- 
2.46.0.295.g3b9ea8a38a-goog


