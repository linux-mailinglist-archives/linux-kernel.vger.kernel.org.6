Return-Path: <linux-kernel+bounces-325326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F092E9757DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FF528D7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288F1AB525;
	Wed, 11 Sep 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4/Vvs3f"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD418C344;
	Wed, 11 Sep 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070596; cv=none; b=EgQBPjx5BJ0ax3KTFYWDQLwpMTO/gvRgDvo4vF1SmTGK1QighiZFPmBOZpAZAo30v3cS4/2RL9bccrjT/p0IxPt42HPXbWmlzCz5PPsmdvixIuAPFlWni7UkAuq0DxnfgwfEBEN8PK2xX/ZKfJbagQbMmu8xMRo2mx0Mkr0m6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070596; c=relaxed/simple;
	bh=H2suYae5iM6L1DtCVBTYDToGGRv2Auy3CNuYHjEmKlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQf48Rr5fDrXrSCGbGcPpJwbV5F4ur/irU2hqfPxcqGnH2ATL+Rp2iYYINxQDYO3uXQBvy9FWiRISOCi97CE9DVd+FG17e1lUTYIuvfxY7835i7XWZtVRd8zkQ7uv8d5Nv9zxdhnuz6Y9CsvuKo/TT//nFWhjyFyA48kjXE9g3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4/Vvs3f; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so184183066b.0;
        Wed, 11 Sep 2024 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070593; x=1726675393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdtgN31kPt0RvleKlCQP+UGvVwGtDOF+3xyaJYfyWRI=;
        b=J4/Vvs3fvVVb/2BNUDMWYrB0sn9PrtsG5dJiSnurhIY5K4eaedU1ie+lBbCdX9+4Og
         GiorzOxK/urTBvgAtYaZYa/bOSz94Efs68Y4xPPZ/QSn/9MaXlkMHGzaUkKO+QgMnTsF
         K80SJNobUJCt6J8z4cSd/4BOFG6Ty0mHvZzMsaNPiwxDAMND5gjatCRzQJ2gRjehvtyQ
         elh0+Mkmcb4ng67Wa0I5Sv4c+kYi47Zf0SpUduc48w3ymavXx+IJJDB/2q20u2tOEmC3
         eh4xhLB1AzjLon9NS7f369uWEpzIr7fkNyi+NH1eAfAqnmMTRddz/KJETB5hsrgtq37c
         HfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070593; x=1726675393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdtgN31kPt0RvleKlCQP+UGvVwGtDOF+3xyaJYfyWRI=;
        b=tfses6/JavCVZucOL8MZkg2Q6bUVZz9TUCKcEQglb/PzxIb01Fud9rg1Z5X1/3LwJy
         nOYlPHQBqqy6dU/1pTODHJGiK0F0R3Z02xx54rZwoLa3qIWZS469Q+Q59y6PBTQVsq0A
         7ukt95UiHhfox2m6GM1l9KxVrBl3E0EattlNBjatrAFJDYu2d5sb/Zv6D73TwjICnWLB
         ZDFAP6S0ITffllZn6Dw6EAlNzYM01wIIDBwU8xy7ZV8tDsWHETMZs6qhpEV+ft880zG/
         r6MGpeoLGjjuSdkwfPNSY+y0oxsmtf4/yf71eF16uWMILfynItbuogqfcujIGNDAYHxC
         kTLw==
X-Forwarded-Encrypted: i=1; AJvYcCUqmQMGaDFHe6oRzD2GZHtnpFST4eyLp7NrqOrnIshnCdEIOaGZIQEIfQXgYl62jOZXK9z3tUZ6ysS0Tsgm@vger.kernel.org, AJvYcCX4CkaIIwuCSVPBRBWoL/sSBXKDkrZaVTJZ69dWP8q61PjZ5lRg0sdq89uSA7DSltKcveTO+lRclmth@vger.kernel.org
X-Gm-Message-State: AOJu0YwEm8IshzM+7Z35iSTQ5zWqg0RmFvq50GWpChDyW/LJUyj1kk5Z
	8XP2z0hXajGi2E1YB7OVkleCfPS2inRHAawlW8U8iX6EE4iEHo9e
X-Google-Smtp-Source: AGHT+IHIzYvj8CgVcpg0FpcpWx/CGrwPJN4sSMfi9dbo5M//xlhJgqU9xdZ6PfStLS2PnCDrZgYMcw==
X-Received: by 2002:a17:907:da3:b0:a86:6a9a:d719 with SMTP id a640c23a62f3a-a8ffb2c454emr533400466b.29.1726070592939;
        Wed, 11 Sep 2024 09:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:797a:1b45:332e:77c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d64880sm621635466b.219.2024.09.11.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:03:11 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] of/irq: Make use of irq_get_trigger_type()
Date: Wed, 11 Sep 2024 18:02:52 +0200
Message-Id: <20240911160253.37221-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911160253.37221-1-vassilisamir@gmail.com>
References: <20240911160253.37221-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 36351ad6115e..5d27b20634d3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -430,7 +430,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 					      &name);
 
 		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
+		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
 		r->name = name ? name : of_node_full_name(dev);
 	}
 
-- 
2.25.1


