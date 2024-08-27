Return-Path: <linux-kernel+bounces-303032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC5960661
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706361F215D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397619EEC2;
	Tue, 27 Aug 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nAVEUX0c"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3604158D9C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752569; cv=none; b=ZRysMfP80YfYfWp6KbtFwCeu1+B8YDoIbEjtM8yCjMObVj7g3+OaSLhH/QV4g0Ql/HRBlz8ZUcno3MrCU9mPMBpoZqMUsAQfqc9FP3hEkLNhXfJboTrK1w6GZmrG0wcTPG64EYSt9cfQJcxQXyHSBgldK8j3FId0H5HQEJ52UCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752569; c=relaxed/simple;
	bh=JS7zaQvkWkzBMXANwpvTuIToEQVmz8bURDImoYt5Rb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI2AvfBLOQSaS1Hcnn/LYqpXhkOWVjn8IPJbyvcUdteVPnLviM3gFBNUO9hxIvXBuIo0CV/Sa0kvpzQ5om3qJO4KuUOgfJNoIXmtxOIaFiwPzUtpP2VxI1NlEv8LmbqHBohz8L04OBzfDlm+DPtnQVbxMKvhZ/S6RWHvqhQoXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nAVEUX0c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fba05363so42398715ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752567; x=1725357367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESZ230OnhQbgGMwqd+oa/xXMpMZe5y6HmOQapIAtswk=;
        b=nAVEUX0cpEHoxYyG/5dilw2B6C28U0OZ3KWHNrQBrgCfJaGawYlQK0g9UxTjq8pLde
         KWUSe0GG00oSE19E1NO5KTm55XMjwv2BnhLe1zIamZ+AsVUbjIIyVBZSEjV1mopacpzY
         miZ7GwCjlwWeMQhK5qjpL8w2NFJU+cVa/I5rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752567; x=1725357367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESZ230OnhQbgGMwqd+oa/xXMpMZe5y6HmOQapIAtswk=;
        b=E1gsxEVNaDyxQWkwL6p5/tv2OiMnyidTYedH31AdjjkwwPivuyMW1oo641yt6qhstt
         z5z6vGWbxX2TsIAXt2JDIbhhT469yLN/dTVlRd/XYinEi7gduKG5MQD+3OxLJQwT7YzW
         X5JBMpyFyMj4e6ILgch7EY3QICCZXDH87peMN4mIK78uL8Q0hoPHiD4oWvfAt7EUqXiD
         n9pQSZ0+unPcCz7iu4C9kIX8y7x6tSdIPwpN/qdYtD29gxKtrfmgkoQbiVqSJNNGdAao
         Lj4MoSZ6qjOG8MnCiKLom5kb+qITt2z5SL3tWSbqwUZoK5YSDhO1uH5ZCfBY52psdp5G
         cIrg==
X-Forwarded-Encrypted: i=1; AJvYcCW67q6kIEliGJUtS0xc++vejnb5mxnIxWe86pWHLzd0nXR4BoZTASQXXQGVc3kwXvCr3zhFQnFhWYB15Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy739FibIpLG+OhCGZaUlrCoGBLHqIfxeOgVPEsIHlg6+dvBrpH
	1bWNObOGi77NAkyqEP+cMrfxFtP7ExW/cs4FI8hjOZQJ5P7DEZjXoD5zXv7oHA==
X-Google-Smtp-Source: AGHT+IFFCHZgHL9RBU8dd5+9PfndpKeAF0h1nYtKjBFa8A/QGyHizQ8yJecYPHXnUGL5ASbJDHv72w==
X-Received: by 2002:a17:902:ec8a:b0:202:3711:6fe9 with SMTP id d9443c01a7336-204df4d6d6dmr19210065ad.51.1724752566916;
        Tue, 27 Aug 2024 02:56:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:06 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5/8] regulator: of: Fix incorrectly formatted kerneldoc "Return" sections
Date: Tue, 27 Aug 2024 17:55:45 +0800
Message-ID: <20240827095550.675018-6-wenst@chromium.org>
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

kernel-doc complains about missing "Return" section for many documented
functions in the regulator OF-specific code. These all have descriptions
about the return values, just not in the format kernel-doc wants.

Convert these to use the proper "Return:" section header. The existing
descriptions have been reworded and moved around to fit the grammar and
formatting.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/of_regulator.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index d557f7b1ec7c..9dab8ee74fde 100644
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
+ * Return: pointer to populated &struct regulator_init_data or NULL if
+ *	   memory alloc fails.
  */
 struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
 					  struct device_node *node,
@@ -391,7 +393,7 @@ static void devm_of_regulator_put_matches(struct device *dev, void *res)
  * in place and an additional of_node reference is taken for each matched
  * regulator.
  *
- * Returns the number of matches found or a negative error code on failure.
+ * Return: the number of matches found or a negative error code on failure.
  */
 int of_regulator_match(struct device *dev, struct device_node *node,
 		       struct of_regulator_match *matches,
@@ -619,7 +621,7 @@ static bool of_coupling_find_node(struct device_node *src,
  * - all coupled regulators have the same number of regulator_dev phandles
  * - all regulators are linked to each other
  *
- * Returns true if all conditions are met.
+ * Return: true if all conditions are met; false otherwise.
  */
 bool of_check_coupling_data(struct regulator_dev *rdev)
 {
@@ -690,8 +692,8 @@ bool of_check_coupling_data(struct regulator_dev *rdev)
  *	  "regulator-coupled-with" property
  * @index: Index in phandles array
  *
- * Returns the regulator_dev pointer parsed from DTS. If it has not been yet
- * registered, returns NULL
+ * Return: pointer to &struct regulator_dev parsed from DTS, or %NULL if
+ *	   it has not yet been registered.
  */
 struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
 						 int index)
-- 
2.46.0.295.g3b9ea8a38a-goog


