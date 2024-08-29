Return-Path: <linux-kernel+bounces-306441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13C963F13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFADBB22D85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B818DF8E;
	Thu, 29 Aug 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bg8mwNou"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270018DF61
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921523; cv=none; b=rYELlCBRkGqXjW9aG5Dym47GsoWZb8AP628oSgR8EpVkw9TWtUch5WkXsndHhZpn+sbPwKZQI9cbQt18VfEIJHeUqdk/7u4SeLqcC33mC3dfA+FqAHi5OkqCjEfyzQmgOdFZLigUaWZhF0ptfAVOTtSk/Cw8aRJiywKgFfV2X4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921523; c=relaxed/simple;
	bh=Ys1aolYt/lRZW5Vi+ayqWyuwyr8HYv3CS6ogA9snSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOgo1GQgl461i7fDtoonvM7igE1qNIJA70qA2IHsMMPcaJ0MRHlqgD4hFPIThq1Uk0tQ6Xxpkae7aJLlefyrMcTquq7nkX8eM/bzhu2wRGcYEedsH/3VNWOdGYY9Ae8YFRzt7T4NDa6PC4nK1eF9cUHuVPoKdw/DAnwkqgxS3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bg8mwNou; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202146e93f6so4030415ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921521; x=1725526321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgPHavE7K4ClGYJgJpC5pW6t6qCTjxay4H8VAVIO8qM=;
        b=Bg8mwNouhDF9cgTRMOhyAeugDG4VMvpQ/awtMEiHV1S6R8nUEiqxvwiuoSz4nw/6LP
         O28qK1t3cXnvSP4gDRDibJDkQqhArhVjH3cSh2cfRGiVqcoeeCgtSEfGDkIB1/30bq5a
         z+LOIrNL/GDc6GAoWfQolg8Ov0QxVm7O1iirA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921521; x=1725526321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgPHavE7K4ClGYJgJpC5pW6t6qCTjxay4H8VAVIO8qM=;
        b=gpiqrlPlmlm35Jx7z7tD9hbA7YNXvE6DEnvKuasGJQIw8TIxYDkSI4ykGvu0IZqbfs
         55X9VCnbNypX4/GB7ctS9mSX1n78iVv2BhcVU9a7FahOzOg+fPXhlhuWMmUscV/P7N9h
         egcC9ElE2VwgqpBwTDeRrjYTgDjViH+P1Mn5Q1ubCprxJRKY8xFUiDBS4KKZY8rQR1ly
         1bb3kZcijrKSrP66DsvS12LmdacZkhBKC2IAmKQwtvfMJqj1TY3JAGsJ1faM4ywEs/US
         8w7yPPqJAJiRLkdYTxeETCkDK+hX/bKjGAqd6fPPIlGMy3vpE4fv+Oi1khubkGz1zKgD
         0/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWVkdCksqYrpZ4hWDxd7sss70m1RWX+bL2m00wG0VtOXIesrf90WYh2foB5uWRk3xn8XrVq9ok+hKJjufs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2+yUruOJfJk2NlCa0iG/vJgI27s0bA6v/BSHl3MIFN9UIkye
	/fSQUzcHImqSBvm5Py6Img6tY1Nnq4oxtJM7bSYbwHkRrAnudmNoiC4HweHMvA==
X-Google-Smtp-Source: AGHT+IHNUXOidI2Jf1faocA3YuPGFcSZUSZSENW9FgWaOxjFlPiWIkyXqvj6UuCHYbxvh0ZYtCh0GA==
X-Received: by 2002:a17:902:d4c2:b0:1fd:a0b9:2be7 with SMTP id d9443c01a7336-2050c33e3eamr25630315ad.13.1724921520981;
        Thu, 29 Aug 2024 01:52:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:52:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 06/10] regulator: fixed: Fix incorrectly formatted kerneldoc "Return" section
Date: Thu, 29 Aug 2024 16:51:26 +0800
Message-ID: <20240829085131.1361701-7-wenst@chromium.org>
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

kernel-doc complains about missing "Return" section for kerneldoc of
of_get_fixed_voltage_config(). The kerneldoc has a description
about the return values, just not in the format kernel-doc wants.

Convert it to use the proper "Return:" section header. The existing
description have been reworded and moved around to fit the grammar and
formatting.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Capitalized first word of first sentence in "Return" section
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context
- s/alloc/allocation/
---
 drivers/regulator/fixed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index cb93e5cdcfa9..c3de9c783d26 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -158,8 +158,10 @@ static int reg_fixed_get_irqs(struct device *dev,
  * @desc: regulator description
  *
  * Populates fixed_voltage_config structure by extracting data from device
- * tree node, returns a pointer to the populated structure of NULL if memory
- * alloc fails.
+ * tree node.
+ *
+ * Return: Pointer to a populated &struct fixed_voltage_config or %NULL if
+ *	   memory allocation fails.
  */
 static struct fixed_voltage_config *
 of_get_fixed_voltage_config(struct device *dev,
-- 
2.46.0.295.g3b9ea8a38a-goog


