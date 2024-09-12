Return-Path: <linux-kernel+bounces-327324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7AB97742F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF448285F61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47F1C3304;
	Thu, 12 Sep 2024 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPdu5Z63"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A218EFED;
	Thu, 12 Sep 2024 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179436; cv=none; b=GdGbPsnPAX5n6T1JG3YDAF4nNKjYAvtPhqYz5dnMNuC81FcpGhlCaa1XgbnoQKIYTZhQSXg0yKZbOE6XTUxHSQgh/jPZP+eSWTBogzpmktUV2cnyjNGWaCj6YBE2p75foKANQvVDPVxkNSs0FVc80zz43x86mC1LBL/t0u+opAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179436; c=relaxed/simple;
	bh=0yvTbsVdvaWVX8wtGlFVHBYRY8ev+j9H3/xlChpDAtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDVemSVXta/e00ksGPqV5oDOQsAUJqbaCOY6LXnzVR8chq//sTjELgay6uLd6wGNSymfn8IajLP6ZWxAVKM946UMwZKlEAa3wWa/mPkcqBVee3dv1l1Etcs70eTVZ5G+06kv1efnV/SUJ80GlvD0ANM8sKGgZX9FNoUPH9uwNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPdu5Z63; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c412cab25cso313047a12.2;
        Thu, 12 Sep 2024 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726179433; x=1726784233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOHkC93q2/NcMMXdoPu8Crd8ScZInZREuK/Q8pIEDkE=;
        b=PPdu5Z638JmcJOcBNlsX9d63YbnPBQtLbmF8FadnZvo4R5N50lL9z3jLzCfZvDgJiI
         XZaQLvRqqFtkl7jzYOTEtW0n8VNkttECP68z7LLc+WsNrDXkb6xLNONMyJfqmf1eARO4
         1CpgtixWnsa5tMNAu4//BrQsY8LoRG1DlAXhAvIRCkQJQtnLG/DssqXzhGh2r5j6aI4i
         j6vgv8OFupVgQgyYH11iKDXVISLCz8hnWnVOuw7L0nxANKIj1yYwezjyqpmQQ/d6KOee
         ZrJOW473OXMHzwHFhWsHqycvdnM5sRVhAIyFK4uGkAqw9mEItTm2NuMKFsgenD7eBuSr
         7Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179433; x=1726784233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOHkC93q2/NcMMXdoPu8Crd8ScZInZREuK/Q8pIEDkE=;
        b=hhk9SFb8VdXOIXRv43pg8pjCEUiRXYrSoGXwp9p31XctjbwmXodAjV9UIqoZnwGyVL
         KnmjEoJSxghARzAoM0mjO7reI6yeoeYItYZoGyVD1BpbgmTTvPo2FPJY06hS8YVElZY5
         00jJ9+R/+caE0v5GMWjtNtb1IQGlFeZd8w4tKPfqRbMVcflfNDkt9LUADnEmE+S86eOy
         YrVgJg62xJIyr6evVagsXcG4ekZ6diqKuno+/sm1HqGmJejin2KuPpsqRwb0gcqr6HcK
         yjAWdXR9KykmGnxy5zTVduEmgT7qjPKTwT63TgZUv1LNd28nP52PiPKEgrI0rI1cJgOu
         48gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDYC6Ig0n6Wbb10nxKt+gDPnkhHmQ6tW/d3oDGLqUMLDh+o9L8pwKLh8VKPK8ZkHtjCPHoKs/R9DJv@vger.kernel.org, AJvYcCW1ikktAhCJNKDyV3KZ82zzbpo5eVlmA6bFtCPQ+9Wz+yndXFkMdQEBUhge6YyZMFbZlpEeIIgydj9p3BXc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyy7ZBKJZrEh28sPzVMGOILWtm7dm9ZykoizIUceyB1Z7D/HRU
	vfWX3FpMav6USjv+HourF9aw3u+qtI3uX5MoC9CjeVOOx/WoflqJ2aoZfA==
X-Google-Smtp-Source: AGHT+IEApnZRs6c/INDckzmQatK/rOMP+3oRv3q4dBE2lP/zo1NUdP2AwD0tkaBIxaCZuQTh3jkK/w==
X-Received: by 2002:a17:906:d7e2:b0:a86:af10:6a47 with SMTP id a640c23a62f3a-a90480ce6eamr46506966b.60.1726179433312;
        Thu, 12 Sep 2024 15:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5491asm792195066b.198.2024.09.12.15.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:17:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v4 2/2] of/irq: Use helper to define resources
Date: Fri, 13 Sep 2024 00:16:05 +0200
Message-Id: <20240912221605.27089-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912221605.27089-1-vassilisamir@gmail.com>
References: <20240912221605.27089-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resources definition can become simpler and more organised by using the
dedicated helpers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/of/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 5d27b20634d3..a494f56a0d0e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -429,9 +429,8 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 		of_property_read_string_index(dev, "interrupt-names", index,
 					      &name);
 
-		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
-		r->name = name ? name : of_node_full_name(dev);
+		*r = DEFINE_RES_IRQ_NAMED(irq, name ?: of_node_full_name(dev));
+		r->flags |= irq_get_trigger_type(irq);
 	}
 
 	return irq;
-- 
2.25.1


