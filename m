Return-Path: <linux-kernel+bounces-441625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C89ED0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9F2168774
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230A1DE4CD;
	Wed, 11 Dec 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggZxrwYf"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586C1DA11B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933248; cv=none; b=pAcHJfeu9iQNMyauVOg8gLK3Ed4QLzDbUv155XxVDNGOQ8hxm1Q37wU+HyV04W9AjgRxsSY5Ln0EizId3OJym64L/K9jeQp1WpzPIc6S1S7nuK/eEcDjCfQLRyQCSjNQcTPG04g/WtkBJ+aX4CVm2J6tD1kzj8irW+KtU3j1FH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933248; c=relaxed/simple;
	bh=9zHOmlSE2lBt2Rpl8UOox++hLCi27/TryYwCxVSnPew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGYCypDC8l5QW6NR9z9L5af/rWIEKLdqA7TXYLqW6NcM74Y/bIHaL0CW1/jf9cLW8WpnWeJ+qpYvF47a5K6hSCrZsER2vn8/T2nGbPz4vDQPwQUMmNbgDlQYKae/BQWS02uc7OPXeAalkKEz+EeT+wl/+Vz546tiysxFVSKgnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ggZxrwYf; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d842280932so93962096d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933245; x=1734538045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMK9uUImiu6io0KCKsugDZpWMzJZHLlDJZIO+NA/9Ro=;
        b=ggZxrwYfYxo8MedkfkE5GyjXE2AUWIFdBn+/HP2yQfTAZkVKbw7d2VZjsqpsQg3oav
         0QWMr3/r52j8KVpHqkV9cANK4UiIr/6BWS3uu7y59ly8gVMawscV2Ss5z4iVbmq5u9Hx
         VkRJjaK6tR8lUphGE4aJHXyeAm1TmKP7SihpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933245; x=1734538045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMK9uUImiu6io0KCKsugDZpWMzJZHLlDJZIO+NA/9Ro=;
        b=v7y3kTYNAgjBZ0c1KvfLHkbMou9Cz9uxlReWTDelKS5OI16ls2EBOZuY5IgPJJ+U9F
         teSkINY19hhbxvMUxkmoLRxXs2PUzZO5kxu6Qd+Ss9DFhDzRjuQONmRyPfq/Nvx6H0Ww
         mV3SOJT11wGtypMNNancWeCNqyWAMRRrPh8CqlPc4fWMq0OEZRegzcSnGzcLbaaSOMpu
         5km8PBLC79ejMu3oF+gDYaBw1K1vYIIBbA8av3WPHz1MU+pGGHyyfD4XK1re4tKBAo8C
         MUAietAuBSPHZMVLAorK/cOsrGcNBMHkGHtG+LUmGAkK+dOPEaxDtRKxVo1g1dDGzfTp
         9kfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnd67gTk2DsERZPBjmNSz7OdCyMCPRBV2LzHPi/LrlZdvQJ2nvd5Wg9m5Zn7wQHjEY0GHzm/yroO8npDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqHBYkJt+IqtOmn5Ano4sbpza8QBNhIRKPCusyWwxZmb/A6s3
	Ebwz69go89Bc/qwp3Q5Wlm2rUvMg0ePXXpCwh1y6Q/2wqf7cd7TGebh17JghZg==
X-Gm-Gg: ASbGnctcs+2Sk3dCwKtzjOAc8nBNCtC576pQkI7g0FFCmHGHj9o2kwiiC2wA6N0HUqC
	ei1hGRD+v4URRawukuEPuVRC0L2SD41UbG26iQnVtSaEtl1+D76BghpyuzzBSXdRIOvuEtwD36j
	lC6kIqYnYGAtxlBlpmm1GbvLvGty812omxsq/ro8jVBiuYVux+m5uc5p+4Cysx4P8OI1nIv/Q8U
	eidagX+iKLv+iM5fL8CWIR4BsVPdRhchU7Du4V2ZA7acL1dAZWqhmmTphAKiHdgpQapZJQdeLkF
	qpadDw2lDtdXW8oHRjzkMxh0KKZn
X-Google-Smtp-Source: AGHT+IHPKXKsI2zaWBcy93AAaoxDDsJF4jn7MhbcckWqatjm8Z8ybpD/fk9DT9vAC4RVxmtKnQPx9A==
X-Received: by 2002:a05:6214:4106:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6d934be3d2bmr58201826d6.34.1733933243809;
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:20 +0000
Subject: [PATCH v4 4/6] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-4-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b312a72f48ad..80ddd76b3a6a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return AE_ERROR;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.0.338.g60cca15819-goog


