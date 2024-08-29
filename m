Return-Path: <linux-kernel+bounces-306440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F619963F12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6094D1C243C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFA18DF69;
	Thu, 29 Aug 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eyfp9BRf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADE18D637
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921521; cv=none; b=ppX35NVA8vw/v9Gzx/R05bVNv70L2GL1QDcJuNw7bLWBAy3+CGWPoB8b2PG6b03dJO3kMwSFtkYx3FFvWGdr/GRsrubOOrl/QlyNldGMDk+T10cuhXihnPfcnhzZZW5/K0WRbb+nQ+zCvT8OYnF3e1ADQdHdUL4Cv8GWUXFqP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921521; c=relaxed/simple;
	bh=tqMRQFMDM2g5ylg72XuZPc55O8LFCWQRKQrBNgYLaSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+lP85WM1pCmW+f7Zbx8KdKNRRY55kmK+NCtT5Dka25YvUwItT8Oh9ixHuh6URAvtAXNTyu2luE2+GY59JcZvu5NFe6lD8HOvjV5EKXQLwLSDG/rK0HCI0SJBUQqbbF3es+05Lq+fw8XCStBHulhvi8PoHU8kryV08xkugLJLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eyfp9BRf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20202df1c2fso10765285ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724921519; x=1725526319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qPNG8Y3Tb15rLUaBWAZZ/ecrzt8HqGuiaoxCHg7qJs=;
        b=Eyfp9BRfbe6waEGhjePicwTbLKxm+gYGF8q2CfVwk6oEqWHB39rpuw9LKemfTsk041
         iENmVbwkCNRLwl4eaZfgl4cVfGDg/EgfSKuitgZ0isIMN8fLd5sHK86VZsNEfRQ5LGPw
         0ljKqBo8mCenzgBeK7VL05/qC+jrg5v/3kioE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921519; x=1725526319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qPNG8Y3Tb15rLUaBWAZZ/ecrzt8HqGuiaoxCHg7qJs=;
        b=JtKnLWAAh5playqZSC1e3kV/dbadYiEbH2+O5Rn31p/tKIdABrk1oRqwQlcq764dR2
         au9vfvgLpc3ESRoYjroRzHiIeKwsn4fHTwjDPcYBznS7bfeepz3IdV2RacZ1oaXFH1zM
         ycSmlgbjmws+bSYjr5m7H5cmGF7cI4uLLL7cVc5vtfmNY+eG4m4Nfys9k2rIjsDJUbZL
         rIBt1q37o3fPbeJhZeMmGVVuxuzUFeZsMGMpI7eQtMFxsF7ldeAqY4N9dUNf4BBmoz1H
         scg3836Wq1rvYm805r4hes3PK6hxrR4okpiHwR6NUZf0gDoaqUb67XCu859PFx8W8NFh
         xFXg==
X-Forwarded-Encrypted: i=1; AJvYcCX4OL4+I46YOtA0zufjvdBGIoNqK7gPQMuRzMjkvZ47rPlH2KAlx/yaoRYP7FrYy1nZGbaYaBCRvur8hl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6NtNRXD1POTcKaVNXgR5R3iCqyXYxitaCxncPJL85bDXjIJ+
	o4Yp9aFznP/LsCjxvkFYDblN4AaI/vjI8NjBaGdP2M8fslgeRJUD+8nklH/qvw==
X-Google-Smtp-Source: AGHT+IHniIg70zN8Mcbn6SOTtRLOmATPMt3xZKk81frTkXYpYHX5zq7/IMrglokTZFmgklGCVG2ZMA==
X-Received: by 2002:a17:902:c402:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-2051675f88amr16164665ad.15.1724921519210;
        Thu, 29 Aug 2024 01:51:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fbe5:6d6c:1cc7:23f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515543fbdsm6924165ad.218.2024.08.29.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:51:58 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/10] regulator: of: Fix incorrectly formatted kerneldoc "Return" sections
Date: Thu, 29 Aug 2024 16:51:25 +0800
Message-ID: <20240829085131.1361701-6-wenst@chromium.org>
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

kernel-doc complains about missing "Return" section for many documented
functions in the regulator OF-specific code. These all have descriptions
about the return values, just not in the format kernel-doc wants.

Convert these to use the proper "Return:" section header. The existing
descriptions have been reworded and moved around to fit the grammar and
formatting.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Capitalized first word of first sentence in "Return" section
- Added articles ("the", "a") to the description based on surrounding
  and function implementation context
- s/alloc/allocation/
- s/error code/error number/
---
 drivers/regulator/of_regulator.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index d557f7b1ec7c..dfa9f42d4629 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -338,8 +338,10 @@ static int of_get_regulation_constraints(struct device *dev,
  * @desc: regulator description
  *
  * Populates regulator_init_data structure by extracting data from device
- * tree node, returns a pointer to the populated structure or NULL if memory
- * alloc fails.
+ * tree node.
+ *
+ * Return: Pointer to a populated &struct regulator_init_data or NULL if
+ *	   memory allocation fails.
  */
 struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
 					  struct device_node *node,
@@ -391,7 +393,7 @@ static void devm_of_regulator_put_matches(struct device *dev, void *res)
  * in place and an additional of_node reference is taken for each matched
  * regulator.
  *
- * Returns the number of matches found or a negative error code on failure.
+ * Return: The number of matches found or a negative error number on failure.
  */
 int of_regulator_match(struct device *dev, struct device_node *node,
 		       struct of_regulator_match *matches,
@@ -619,7 +621,7 @@ static bool of_coupling_find_node(struct device_node *src,
  * - all coupled regulators have the same number of regulator_dev phandles
  * - all regulators are linked to each other
  *
- * Returns true if all conditions are met.
+ * Return: True if all conditions are met; false otherwise.
  */
 bool of_check_coupling_data(struct regulator_dev *rdev)
 {
@@ -690,8 +692,8 @@ bool of_check_coupling_data(struct regulator_dev *rdev)
  *	  "regulator-coupled-with" property
  * @index: Index in phandles array
  *
- * Returns the regulator_dev pointer parsed from DTS. If it has not been yet
- * registered, returns NULL
+ * Return: Pointer to the &struct regulator_dev parsed from DTS, or %NULL if
+ *	   it has not yet been registered.
  */
 struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
 						 int index)
-- 
2.46.0.295.g3b9ea8a38a-goog


