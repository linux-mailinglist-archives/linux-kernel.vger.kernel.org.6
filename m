Return-Path: <linux-kernel+bounces-241104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7157927712
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4728295A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C41AED31;
	Thu,  4 Jul 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWwrhkwP"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4541AED2F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099312; cv=none; b=Dshs76YEovLlfZCI5KeWyD1jn2GZaUGJwhKc4WFcMUXzFbjNVVj5jifE0iw5UAcHaoSYYfzXU+FpMSsRFIlAqYfWgv+rTj69WV24xUaBazwxx+XkJII9wME/gTFiUwjq9bQgUTFrj3TsYAROyYgAQCaoR+7oM8/tUTm/KH+Fl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099312; c=relaxed/simple;
	bh=1q9ACrqo0jK0jaO+wWlY0L+TBLvGfhkJTIx8SEXEo4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=txcd3juZOqWlWBGu/pqcdFJ3JAvj8ppC+5lEUutYqkKHJ1JVyP7T4L9JnozMKe+fXTRNuX3nNLr+ZIRUKq+oDw3/ot0X4c+14OFPo0KAmO/Ufqoh+BDCJmKpaLqxvbximzVFTDXliunGoT2UTY8hx7/TyTqTW9S0WVR1JTc3FMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWwrhkwP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b04cb28baso238445b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720099310; x=1720704110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxv4zWBK4FG19nclOzgciDpwXeW+GGBMkHfutZYKU+g=;
        b=lWwrhkwP2EpD19zJtirqin1govJNpfDTygmwMjB/tNImjnWaDkzmS3cuE3NNEOI9TY
         YtIzIT6Wn3zseeIiPISXA3YfI50lObx6+JSAW1lX4mS3wI+INEK6jwdf41qyE87XVkP3
         Dvs+FPUudQIdEtv0oDzoEoO4DpeGvmyRjGXyQ83zqCwzNGS30Tg6UVWt3S69BPfVNJeR
         qQq5+3ee0S+Nd66dMvMKhUb47MISerZ7Tno4U+U9d9f7jpxlFkrr/lfKxOCeWhFpm/KX
         EddnTvcB99ds6qD2oCiZzaGAZJniZsz6sXu4sU37e2hCvA1ZP/L7qYXm9cIow8LihCBt
         I/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099310; x=1720704110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zxv4zWBK4FG19nclOzgciDpwXeW+GGBMkHfutZYKU+g=;
        b=a6RULw9xj6j0BZpE6tl4tUSGhBWVzpi1FhlGsFTsvtl1sn7Kz1SjcS9CM2cUBOdgHa
         MfAj2Pu/Xx6WP8xJI5jy2xVSowRtCNKaMHHRc9qJULCZzaCPa/c8hgy3mwrUKsi2xFuZ
         m0BXylopKR8Cn8aQrpS8GpiGuouvHWyKL2yKFDSD+Ee7NE2nhN3bcfDaItoUl5+7wfrP
         7xq6QazVOu0yeaoNfPXH0HFCHQgMXZotqs8qm6S/ZyNF6Ep3qE+YGUVxH3wyJzrCKypr
         L44dP3+vSfv86Tq4q5aD0NQZ9MIgCDJ7Dc7S0pkZUZCDCYEjNMgOvof5W5qhHMJrIWlH
         uubQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQehmSvkGpmRgBaGGaFuMmDKF3FYKnTh9A01t9zXVEsgwY3BFyuMtzzxAJPTVLXSyiKKJBAcfOm/XOqaoi9OE4/FEl3qx5nW9wtc9q
X-Gm-Message-State: AOJu0Yy2jekVmO+Nk23MfFPgVdZP9hRE6y3IzR365Tsh4fHuhx65Ss8e
	Fx1xX/kGiFwab9b5pC9TdGa6g8HqfkBxA66mmnrRdcyOu04hXvDK
X-Google-Smtp-Source: AGHT+IG1LfZ/JBubCZYsSHvhki2sszTRErOK4JEkHtWrxAk7vstk3ejVZH+SNcCxdensOuBZaoq2cQ==
X-Received: by 2002:a05:6a00:3cc5:b0:702:65de:19e5 with SMTP id d2e1a72fcca58-70b00ae8bc2mr1974332b3a.33.1720099309945;
        Thu, 04 Jul 2024 06:21:49 -0700 (PDT)
Received: from dev0.. ([49.43.162.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b397c9esm8253522a12.49.2024.07.04.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:21:49 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com,
	julia.lawall@inria.fr
Subject: [PATCH v2] gpu: ipu-v3: Add cleanup attribute for prg_node for auto cleanup
Date: Thu,  4 Jul 2024 13:21:42 +0000
Message-Id: <20240704132142.1003887-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cleanup attribute for device node prg_node.
Remove of_node_put for device node prg_node as it is unnecessary now.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
- PATCH v1:
https://lore.kernel.org/all/20240702150109.1002065-1-jain.abhinav177@gmail.com/

- Changes since v1:
  Enhanced the commit description to better suit the work being done
  as per the feedback in v1
---
 drivers/gpu/ipu-v3/ipu-prg.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 729605709955..d1f46bc761ec 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -84,8 +84,8 @@ static LIST_HEAD(ipu_prg_list);
 struct ipu_prg *
 ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
 {
-	struct device_node *prg_node = of_parse_phandle(dev->of_node,
-							name, 0);
+	struct device_node *prg_node __free(device_node) =
+		of_parse_phandle(dev->of_node, name, 0);
 	struct ipu_prg *prg;
 
 	mutex_lock(&ipu_prg_list_mutex);
@@ -95,14 +95,11 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
 			device_link_add(dev, prg->dev,
 					DL_FLAG_AUTOREMOVE_CONSUMER);
 			prg->id = ipu_id;
-			of_node_put(prg_node);
 			return prg;
 		}
 	}
 	mutex_unlock(&ipu_prg_list_mutex);
 
-	of_node_put(prg_node);
-
 	return NULL;
 }
 
-- 
2.34.1


