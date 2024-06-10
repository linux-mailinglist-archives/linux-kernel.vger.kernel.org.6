Return-Path: <linux-kernel+bounces-208714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80A9902869
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D78128859B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23114F131;
	Mon, 10 Jun 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGObxygp"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0A14AD35;
	Mon, 10 Jun 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043054; cv=none; b=WlHfLdCMi6cQ+Fq0j2QR+UbrX7ycunRCY5t2O2cDTyQRLVvXfmn+xFQS/LCxedlaL0m75v1oC93TlX/r+miZwrn4Wd3hNRMLRf0mydO7PDKWDPJx+vpFIsG7laW3e4Bpy8rNFZKZyMmWX4pqKFEqU+ZcvyuAd1oo3tjTvF5nTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043054; c=relaxed/simple;
	bh=nSKjz0KWv20MSmp1Zba7UhZtqkG9QdgLPUj3njHimJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LTOBt3+3bnLxRe2FNG/5D/KMqpDOaFFMFVYXgyaOrMP9CeQW0u/1gXXNy1yWHu87H92P+CVg4GtnIIZyXQxs0qoitc4Zlw5BM8hdOt1WEK3Rd+o4PoTrWPaVXeAkdTjM64oaacVrQfPE3e73nZeNR9EpZNhx4/Cly+mcV0QcHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGObxygp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7041f4553ccso2575030b3a.1;
        Mon, 10 Jun 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043052; x=1718647852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBodwoDy4NoI0gKU3CfVEoLymIQQPIjGJMUe5cvNy78=;
        b=KGObxygp2JsmnV4pmbLLNrwLb/UvQDXNDJrLF7YyVrTHx9ZdaHvoh1RsUTlIzaVzRu
         OYuCnFhYIfHXv3Bs9wSOdvZqq4T7Cyd/uJ3cqUeRGzuEjZkb+3ZtcJHrIo2MRK5XrNx1
         EsVAXngyqI9+4mRUR7iIX9hfSPWDTKkmDSfpiiOt1WzQA/p6nbC/I3nd2rVRld4I/7SV
         GVaDUNRA8IuyiZW+wV43dE6RRu/n107XcujigCxRBTj4sPkL9lWtGa5J5GvY2dl3k6jN
         iLGjiJkQybbsPl+mzEa2Deuu36x3Js2WmBkQEwHvNK0Pa2WckoSNvrsJlt4sIwfXJc9L
         0TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043052; x=1718647852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBodwoDy4NoI0gKU3CfVEoLymIQQPIjGJMUe5cvNy78=;
        b=vBrV+RihUyNqoKYjFPinx9nvxPA4U3mBrxFoktmb8hsqsZbvjA4UE9kYOVRfGbgVAO
         NRPiTfgIJ5nmecd6/VUWVJYf5zUIe6abO2pzzF4GoNl7VyaVJZpAT7O4RQY144/coDRs
         t6hfGm7GPwE1a5m9Y5NF9TGI+u2WE0kzlsjGgh0Ei1HCh5IcKGm7xvCrUdkN0BcK2YsR
         5HWUpANjbQNLOwT3QgCSLuJrA2kblm+MYXzgZ2G5BXEO6LogEmAzpfaOf7TGK4CS+d0q
         rsUA77+Y4tkUhRYebpw59iHNTCSzzAAfJ3pdcJWiI9Zv+0N4Y/k9HpKJ32NAsYzTmDmC
         cQug==
X-Forwarded-Encrypted: i=1; AJvYcCWcj/rIXZiymMjkwIfMpEVqzSBEMbXG2xq1Homx8E+70NjJo62SRP90DLM16+BcuYM/FAiY1+p4hRuEoOpmL4Y+tIbBOsqQG9n0Kztp
X-Gm-Message-State: AOJu0YyTY6wb8AM1Y1EY/OqpWC9jCMBsF1AyjEgwv0v6DlqVT84/ObUv
	cKFKJn028UIBZB4ZRVqgi5D4QExkKlBbXFkuhdsgNgulvYX+EKaKI11i1g==
X-Google-Smtp-Source: AGHT+IE2tFZcUOCIKyL7dElvOves9MyVhE0oBcRixoK4cmeWLfET8JN+rel7uEgGfjpuzQA0DfYwfg==
X-Received: by 2002:a05:6a00:1996:b0:704:2d99:9ee0 with SMTP id d2e1a72fcca58-7042d99a023mr8198447b3a.33.1718043052084;
        Mon, 10 Jun 2024 11:10:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704326f9342sm3104637b3a.103.2024.06.10.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:10:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Potin Lai <potin.lai.pt@gmail.com>,
	Daniel Matyas <daniel.matyas@analog.com>,
	Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/4] hwmon: (pmbus/lm25066) Let enum chips start with index 0
Date: Mon, 10 Jun 2024 11:10:43 -0700
Message-Id: <20240610181046.1991436-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610181046.1991436-1-linux@roeck-us.net>
References: <20240610181046.1991436-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()") changed
enum chips to start with 1 instead of 0, under the assumption that
the data pointer in of_device_id must not start with 0 (NULL) if
i2c_get_match_data() is used. However, that is perfectly fine as long as
there is also an i2c_device_id array with the same data which is used
as fallback in that case.

Let enum chips start with 0 to avoid confusion against other drivers
where the enum starts with 0 and i2c_get_match_data() is used as well.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/lm25066.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index cfffa4cdc0df..c36c124d1a2d 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -17,7 +17,7 @@
 #include <linux/of.h>
 #include "pmbus.h"
 
-enum chips { lm25056 = 1, lm25066, lm5064, lm5066, lm5066i };
+enum chips { lm25056, lm25066, lm5064, lm5066, lm5066i };
 
 #define LM25066_READ_VAUX		0xd0
 #define LM25066_MFR_READ_IIN		0xd1
-- 
2.39.2


