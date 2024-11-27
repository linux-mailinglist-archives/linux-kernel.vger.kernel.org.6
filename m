Return-Path: <linux-kernel+bounces-423527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99A9DA8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D46B2236D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298A51FDE2A;
	Wed, 27 Nov 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlUcSyKy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826401FCFE9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714989; cv=none; b=vD6utYXfnbbCl3oSWuCbeyRxnKu8BgkBoultTEBp3UCeqnQ74Qd5gzp3jmUNO8/WPOHiB1uPj1S9P1kYDHp+c2KvcwoXtiPtZiBZ6byTGVEgNAs/RMhPUavUkmlXYrgK6za4DW2w9a2sA5XGQtsmFGQDniXKfrHfoynwbwMxhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714989; c=relaxed/simple;
	bh=uR+2gUFaQ/bKOjmUqL7EE/x3pFNAGPUlCiSBh+z2VYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8JdRhA6vpD6bZXLSYgnaLLoRnDI2Am/moJVq0cU9Z6m7S4FUaQziZTuP3t/UtG5VQ/dQUzPsgg8eipHzMUw1g7rdT39vRTXKxwcLv8LoZfSZn5tWvj/w0O0hYnqXsDJSUwShK9urSuneyhRWayLBY8SqU5TYyLykj3ZVeLwK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlUcSyKy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a099ba95so27263745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714986; x=1733319786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NiDU4+PesaIdwCfPunSw0bMrPrm9AGZnmPORKEPq5c=;
        b=UlUcSyKyhltzeRqSKX0nv8rGgoqvCQKMYL/I+bwq4TnFvxFpQ7ZNm4z27vi8mhabHj
         4vuCD7ZM2+ohCJh91RDzcklizYgMtWXANg8aHuMrvwKZX9QWArVJ6Zr45mGmcJKVwZ0u
         GQr7Y9jheDCwEbpUHipX5IdfrvyuTHxjnOKeo43YD/zu/h9slz3nUA314YlLqYNB5x4w
         C2/RhVah1rJEKlqpwJNQE6mBCQ+Wak0b6bl8Xl681q+10zsvch8cXVo472ATEG4uV24f
         6Khya+8ouTV432xXzrijNJgjoPirK4NXCDnbc3w3fKimldMWdE6wLUGNQBOW46qLqslG
         7pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714986; x=1733319786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NiDU4+PesaIdwCfPunSw0bMrPrm9AGZnmPORKEPq5c=;
        b=Eov1L7B6+zKnMznmxznt68ME8oN5oBmqlhff0WXRu+chkblF/HV4XAdUYRnrgE8JxQ
         v3ZJCDnuAYHPzQRNAQZA5tEORekHnxguvp+jOhWMVFTgeb6s9CB1FQC3YzSqEREYIemu
         oYlNc/Eif2/yCwqBivv/qR31S96KLTU81Tsf+ar0VBQmq0lkXr/1goljhRrdQegtTmni
         apyOd7YKForlEjfrkNNV2Sva0Hu9+XvMxTAOFSoO7fDNn8gamp3xGec03dDzujH50dtN
         EFf8e5mbM7d/+2135AJau4YJgDoTorEwqN1cZD+BbEc+mlE9dQkZtIb+8YCAbxr7DkGp
         yT3g==
X-Forwarded-Encrypted: i=1; AJvYcCWFiVCqDAQ6Gp8NdwdCBypjACBCPjKzb3RgpDzVAGuCsMy7nCkjf9T55162DH9mee1VQwgiQaKuCTXl9N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Eum6GrbLjlX58lGolq+sDrL2BxzF6SE2L7JU2cwvqTqAZ5eB
	pqsLXB58iw792Qy0E1I2KhH3ddkNmEaUoCWsytzTwf1VESpTzYGe9Qvz8cEvV2s=
X-Gm-Gg: ASbGnctKK99fngWGfc2uV8AEGWhmpjZWvAtLS56ayqxqhoxWxAH7V6CJ5D43fcHVJVt
	Nx1C6tQ6t5KuCoADtOPep5TR/UXG5HbMWoARc2jrpJhJ4v5KKMOxBpF6fniEwWXWY1R4p2DMfGO
	FXpFjZ2Ms+i5LUVvtfZIj3ppeE8QHjacj+2CKS/iI/E3vr5SSdTM6mI5YnOWxTs5VLzDssUg18/
	LxAebA0Ujz/1ykur81UMttmTK4vV1q8nU9xqW1RMEq8rUohtIY/
X-Google-Smtp-Source: AGHT+IE989jzkeAsumQF9Xor81wjfIshk1Fi9eocD3+gjibZ7MizC96YWhPR+VcT19M8dHkWDMMcxA==
X-Received: by 2002:a05:600c:350c:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-434a9dc0c94mr29355435e9.8.1732714985815;
        Wed, 27 Nov 2024 05:43:05 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:05 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 6/9] coresight: configfs: Add attribute to load a configuration table
Date: Wed, 27 Nov 2024 13:42:53 +0000
Message-Id: <20241127134256.2254851-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127134256.2254851-1-mike.leach@linaro.org>
References: <20241127134256.2254851-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add in a binary attribute to allow load of a configuration table.
Calls API function to load and validate incoming table.

Use of binary attribute in this way is modelled on the load of
ACPI tables which also use a binary configfs attribute.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index d7883fe802b5..ce8eabc86701 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -791,6 +791,16 @@ static void cscfg_destroy_feature_group(struct config_group *feat_group)
 }
 
 /* Attributes in configfs that allow load and unload of configuration tables */
+static ssize_t cscfg_cfg_load_table_write(struct config_item *item, const void *buffer, size_t size)
+{
+	int err = 0;
+
+	err = cscfg_dyn_load_cfg_table(buffer, size);
+	if (err)
+		return err;
+	return size;
+}
+CONFIGFS_BIN_ATTR_WO(cscfg_cfg_, load_table, NULL, CSCFG_TABLE_MAXSIZE);
 
 static ssize_t
 cscfg_cfg_unload_last_table_store(struct config_item *item, const char *page, size_t count)
@@ -846,6 +856,11 @@ static ssize_t cscfg_cfg_show_last_load_show(struct config_item *item, char *pag
 }
 CONFIGFS_ATTR_RO(cscfg_cfg_, show_last_load);
 
+static struct configfs_bin_attribute *cscfg_config_configfs_bin_attrs[] = {
+	&cscfg_cfg_attr_load_table,
+	NULL,
+};
+
 static struct configfs_attribute *cscfg_config_configfs_attrs[] = {
 	&cscfg_cfg_attr_unload_last_table,
 	&cscfg_cfg_attr_show_last_load,
@@ -855,6 +870,7 @@ static struct configfs_attribute *cscfg_config_configfs_attrs[] = {
 static struct config_item_type cscfg_configs_load_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_attrs = cscfg_config_configfs_attrs,
+	.ct_bin_attrs = cscfg_config_configfs_bin_attrs,
 };
 
 /* configurations group */
-- 
2.25.1


