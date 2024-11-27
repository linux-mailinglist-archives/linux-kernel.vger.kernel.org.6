Return-Path: <linux-kernel+bounces-423519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275679DA8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD3162020
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB031FCF6D;
	Wed, 27 Nov 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut0X/JPE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC531922F2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714952; cv=none; b=Gju3YGsXcsQSYZGqJZk5vOmXZ1FDxZ+UrEUGjgM13SeVq/j/4qfDiZwiY4RycuifVSQYyIsjMl9zr2W0KETKkKh49MF4fa06IJaU3NqrEIt7eGLEho8ph0+HFBOyfT4+POyf2Gdd8BxZRfbMubGcL/el/PBqFoIeTIvBdnKvz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714952; c=relaxed/simple;
	bh=ranfFkcb0taLy3/caOuI+8tG8S/9geIMxfR+u4xYOwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vCBIGsz2e1zh4U/8c/PoAW/gnbRA45jcxak/eSrXk9WMPitB5RlqyTui6hu7DxtU6JuNwuySDwJO9fPyIiWmkanlvHJE0z6st+YjkA6tkcLtkwn3G9W1YpmEZ8Cs8MY8p5tZSh9bUq1Or5xinxG9nRbsWl2nWrltC3/0XGKAMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut0X/JPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526A2C4CECC;
	Wed, 27 Nov 2024 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732714951;
	bh=ranfFkcb0taLy3/caOuI+8tG8S/9geIMxfR+u4xYOwU=;
	h=From:Date:Subject:To:Cc:From;
	b=Ut0X/JPEvqIRzSpQAzCYlCHW62XEKhTsOkZ5EHcsBvu6omzRVWXxUyBm8MSCu5tr8
	 ShIQy7yZLUf8tPp4aUoTNkr5QN9UfLVg1mALDuFf8lnwBEcvgC9547w1jA8Hx2RMmt
	 j5soxoiZBASjvORYBQXi/e1itFTpqfLkqThTVKrQZb2+1s7uEnvjojjQMn6GAOq7WK
	 0J5qOmMpyBwQNxV45RF69hBXnxvwMp6J/xl3G5xwFODiXFPV+9AeFcO7zyZkCJ4uvZ
	 2ELoYY+vM+YhnFf8M9ILK7aYDqSDBpkvDu8rau00q9Ng8+MtRi1ZOxDKu5cn81jE07
	 BEo4ufLf+1V3Q==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 27 Nov 2024 13:35:06 +0000
Subject: [PATCH] regmap: Use correct format specifier for logging range
 errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAkgR2cC/x3MSQqAMAxA0atI1gZsncCriItq0jYLB1IRQby7x
 eVb/P9AYhVOMBQPKF+SZN8yTFnAEt0WGIWywVa2Mcb2qBxWd+DJ6cQoIaIjUqS5W2pqe+c7D7k
 9lL3c/3ec3vcD15+LEGcAAAA=
X-Change-ID: 20241127-regmap-test-high-addr-db6c3d57af6f
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ranfFkcb0taLy3/caOuI+8tG8S/9geIMxfR+u4xYOwU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnRyHGfKXfyWF+gUvOZ43Sz/dnztxdfi7oyMC66zGB
 ewW2nBiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0chxgAKCRAk1otyXVSH0JsAB/
 4t+L5jkutkFog2y28jwqC5jt0S0A5BBSiReLFYX43lt8QQcDLeMSFNLaX0DvHwCxbhH3DPuaE2yrAY
 c+5XxrEZHi459qRHYgHeyve3a1Mj6QGh2qK25PXJDLVgh56TiOvxWU2O3J9CbeUgQIktP3/PoecqsN
 tt/Iin+wSiiyHOarnWETwZBKmcT15ZzRVOx2yxumvgOhnTA61392krLcXQ2O8klGjxiz4SAwveRHGw
 kVOx3t3JwfGtZ9OKDUOqqdHQcXR9GMXRukj5anSV8OT346sZdiQwDSDBSLTz+8CVu2y/VlcJAqXJye
 2Y+WWYNgCerwshxMnDzhP3JORJqMsG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The register addresses are unsigned ints so we should use %u not %d to
log them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a6aad54bc85e970124f6b166a8010..7ac4dcd15f242acd579ee327be5cfec82d91bf49 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1052,13 +1052,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}

---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241127-regmap-test-high-addr-db6c3d57af6f

Best regards,
-- 
Mark Brown <broonie@kernel.org>


