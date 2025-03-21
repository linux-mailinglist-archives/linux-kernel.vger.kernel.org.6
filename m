Return-Path: <linux-kernel+bounces-571662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A632A6C04D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2113A189F757
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A522DFAC;
	Fri, 21 Mar 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWHFaHSd"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4422D7BF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575285; cv=none; b=mCjwsjvokHxfWC4An9P+ZJfGGC5aBnjUo+TBZZoBfn2JcgJJuZbRg8xztLgV9jxMboy9FpEqHCgGxFax4e6ygGbPG65sGE1a3AZpWM9tLrMHLpjW4rQ6QxdKvUO7uE+7DnYRSo8bMUQvAa9RyY8aFBaI1tHekC0qC8irrTD6A88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575285; c=relaxed/simple;
	bh=Pws08LvMbXyIYXHBhhgM7dOJmvCHCz3WGZZhXE7y8N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7JnVbEB0q2RBKwSuQgZi0l+2aMEFIbLkgS78n7YyC5qG793QAbm/xXUsCEItmadzbtlIKnAGGZUugAgXASTGOWXXSNAi1TcbKVgHLEkHvzcKEkwfD72HBhJrC1GKwSvDNJA66T4MoZvzLhhK5OplT3IkhdsZpT+gfZkqjVqzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWHFaHSd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac29fd22163so395414066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742575281; x=1743180081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgqqVRk8zgVEKC8aOnJN2NYUg3kMqPomNQlkiSAg/5E=;
        b=CWHFaHSdsZjmt6BWVhoeGM+/dVvsaDBWbfJUOlGjb8aizJk3QiTkhIjOuDwkkm7tkv
         H1PV7TWQlYhsDSPEolg3j0KQr21wCROSKdd8JEsMSEkoouYsE6xDmqIw8DRCHy8Apifw
         LmVYgSI0XFvCc4OX5enFHMPwaCec7yjPlPX/jGb74CfSGx5Q5c2zAO4b40QQ73rusABa
         bvRRz4gU7pili3KbC94fFkEkw99Haj/fcvkQj87W//8wo+Hxhc5JQMkaq+Cenz3eaADP
         Y/QUwXYEqKyXHPa7kBaQIEIhwnWXlvSB0jrjQMCBDYSPdtXSn2DEJer8TwfaPi54wFW3
         53VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575281; x=1743180081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgqqVRk8zgVEKC8aOnJN2NYUg3kMqPomNQlkiSAg/5E=;
        b=Varw2q4UWqhZW6kXCvBSHlcmyikH+TFi+STmO9gBsTSsZeBu/0bACqua+WS2SPni1v
         bLxPiAtnM4JoV04VpsAfLFZ3lcsNM+RBeXHBmuSjHtgKbo+qtl1gDX09Q/OPXbUUFDnU
         JDGqSWPLi/1v0EKvB16VA4/dJgXDx+d5h8rZNpblheZfLR62TtFcLZVamfhB0kumn+vx
         ILQDZ8Yusy+yTl0WMpj6Fm2IqubooUAroY6SiUtqz9io8K6s5Fq+6LqpmG0tm9S4dn9N
         F2d7+kmo1k4sQwRgIAHNfBJM44s/XmpPJTW8qqcu3DmIe6xU8hU021ZxtZWm3FnzRAAS
         izzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUyVg6GBl4TpklALqJBtLx4P6vnbkXKNTknb0nHoB0hXaM6yGK3DcQpWYrwRtyRl54x9VMjf0w2xCxKjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyluQBUR8BI4FeKDXXymzbHjtRb+F8VQuLQUhnBF4AQbHIm/ij6
	6ahWUZ958+E5wG4VercHRhXzUxZUEgA5dVByvLhj104Xy2I7nu2ppvhDcl/ynhQ=
X-Gm-Gg: ASbGnctR1qIqmEKmkBduB2wGwwjK1xTymFEovHl0+osPMD6EteDesQAdjBsCLN2TC7K
	PqIEmjYLCSZbOUdULfKXcJaFRR1eMDdWQVA8pe42xP0al697uXfHy0CsymFAVF9nDfpVvGj1Zja
	vk5zNhvGeAKKm/cawZAhiAaXXn8YE28cWUKxutnybKQ7hAXM+p9H2GY48WA0Jqkf9uP+lotZ9zn
	RxoRtMRM93popzsAVD3O2o6vuOYacsiUqTB4oiWRoprxI4XpCOZjMQ/yVJXTkIugz9Yjw5ltz4n
	84QNjll8JvD9xtIUmJAh6pOqlVwxiHHa717SI5e0gKCcDIvDmoFQo5lw0TjB1vw3fXS64QKNmwt
	2QpOHNwwTp8yxvsx/jW3KMWuFVfJH
X-Google-Smtp-Source: AGHT+IECXlewiRNaZcsT7VByFGLy8wa/hYDpGmKSUjf1tAtN9CwCl6c2v3o8DCAfvXOp8IgGjxsCNw==
X-Received: by 2002:a17:907:3fa3:b0:ac2:758f:9814 with SMTP id a640c23a62f3a-ac3f211101emr418514966b.23.1742575281409;
        Fri, 21 Mar 2025 09:41:21 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdc78esm184015666b.134.2025.03.21.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:41:20 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 21 Mar 2025 16:40:58 +0000
Subject: [PATCH 2/2] firmware: exynos-acpm: allow use during system
 shutdown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-acpm-atomic-v1-2-fb887bde7e61@linaro.org>
References: <20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org>
In-Reply-To: <20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

We need to access the PMIC during late system shutdown and at that time
we are not allowed to sleep anymore.

To make this case work, detect this condition and use busy waiting via
udelay() instead of usleep_range() in that situation.

The code isn't switched over to udelay() unconditionally so as to not
waste resources during normal operation. acpm_may_sleep() was heavily
inspired by the I2C subsystem's i2c_in_atomic_xfer_mode().

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
udelay(10) causes a checkpatch warning (it suggests to use
usleep_range() instead for usec >= 10), but that's exactly what we can
not do.
Reducing the udelay to be smaller will generally cause the loop to be
iterated more than once, which I wanted to avoid.
I could reflow the code to hide the actual value from checkpatch, e.g.
with the help of a local variable if that is preferred to ignoring the
checkpatch warning.
---
 drivers/firmware/samsung/exynos-acpm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index d7ed6b77a957af5db5beba7deecce13ac7b30fd2..33cde6e88e2c0773fdd36c80927c77d3bcb44135 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -15,6 +15,8 @@
 #include <linux/firmware/samsung/exynos-acpm-protocol.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
 #include <linux/mailbox/exynos-message.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
@@ -24,6 +26,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/preempt.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -272,6 +275,17 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 	return 0;
 }
 
+/*
+ * When ACPM transfers happen very late, e.g. to access a PMIC when powering
+ * down, we can not sleep. We do want to sleep in the normal case, though, to
+ * avoid wasting CPU cycles!
+ */
+static bool acpm_may_sleep(void)
+{
+	return system_state <= SYSTEM_RUNNING ||
+		(IS_ENABLED(CONFIG_PREEMPT_COUNT) ? preemptible() : !irqs_disabled());
+}
+
 /**
  * acpm_dequeue_by_polling() - RX dequeue by polling.
  * @achan:	ACPM channel info.
@@ -299,7 +313,10 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 			return 0;
 
 		/* Determined experimentally. */
-		usleep_range(20, 30);
+		if (!acpm_may_sleep())
+			udelay(10);
+		else
+			usleep_range(20, 30);
 	} while (!ktime_after(ktime_get(), timeout));
 
 	dev_err(dev, "Timeout! ch:%u s:%u bitmap:%lx.\n",

-- 
2.49.0.395.g12beb8f557-goog


