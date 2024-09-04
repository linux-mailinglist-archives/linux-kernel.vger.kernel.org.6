Return-Path: <linux-kernel+bounces-315496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057896C350
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422C11C21A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC81E0095;
	Wed,  4 Sep 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMLO4LUW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55271DEFDA;
	Wed,  4 Sep 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465768; cv=none; b=sZUfmDjwAtbxan9EoM8fH//cDPfodsakuW4FfAa4ppamJ9MXmIIH/Rf+Ank2zGruH8tLfSLqNkrQxHvoagK3tYJ8R250RclDHqnvw7YuBA1HzCmk0ReFfJA4hT3i78j7qiT82oWaWuPEEmuWvBdeKBw8T5PjF4IN8uyzvjJGNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465768; c=relaxed/simple;
	bh=H2suYae5iM6L1DtCVBTYDToGGRv2Auy3CNuYHjEmKlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjAmucLAjmwvMZT3P3hBicTNdUObmJca8ONJWu9qnPbbwjxZ2Wj4+mbTR8MBiNqdwPKYF7W/kXqmhQ57h3udYJ+Fx3mqlte9esddy55hYRvstsPsQeCtH66x8YI7XQ3O/gLnOx3eRBzq3e6mDPHoZk+Ay1nt8SGzsshoUFn3X6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMLO4LUW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a1acb51a7so324320566b.2;
        Wed, 04 Sep 2024 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725465765; x=1726070565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdtgN31kPt0RvleKlCQP+UGvVwGtDOF+3xyaJYfyWRI=;
        b=iMLO4LUWyVcfPCzx96Cjl/9npyl+zPeo52drFtFO0dDA2EZL30DCi/tOosnROC94on
         XPkI9WUX+ayH4luIhPnQmQGgxGxY4tR1YbGoFOrKr33MXolV8D+nznf/4EMldulXZhvs
         xrl+jqOXv1HjdCLdYQqfAtUUrcBfWCjT1SMj8MsXRzGIeX3TVN054XCFLmkxINXEsu5u
         0VsWtVtWUrNmJy7xGkg0iBTiAId/D6nkNmJ89PAx+nDCBw6UwwiT0Z7f27K8U8Lfllsl
         bqWc1my9h7B6qVyA2RZpb//FeekJ6YqqhmNhqAIeEkKWvVtotY4BMVfykrNRnMotWZtA
         XuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465765; x=1726070565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdtgN31kPt0RvleKlCQP+UGvVwGtDOF+3xyaJYfyWRI=;
        b=MDBlom7xjNrFQ7M0guJgXZ3I/iaGokeev8qgLa91YmP1zXarim3XZAoIDN4qv08zr5
         9aS0wTreJWp6Uiw2wK5QtNYuU2b8TMszXSxGHJAGyXpOZ3I4IS+FsLqhEcyLOZaOC0ch
         qXaq31gzNUs9Fx1urqZKFzizaLxeUUzbbfJ4FJAkqZJm4ey1DUfHnRzDa9Wkt1XYZL6p
         ugwcc2mYe39vuyN43DqV7bKa9WR8+kGlNUJ/g2V4wB/rdCVm9iTOk9TTYeoriF2A3pwX
         b7jPoVH99AisFtxaATD4elgCrnJ5PJgZwBh4CdK88MfDfyP13j86JDinE2egw6mmvg5S
         oUKA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Gv8JQhsgTOZox5K13ATUcFtBdMYYYbtDLq9NaVUBPbJlw5Sf9D+Xrl7vK35jrkXal/q770jOkJw7fby3@vger.kernel.org, AJvYcCXsU1M+nMkmDc7wEuKN3vzXgrwfJ2Q6yuzuQ02LoDldMaHFcWHKYQl7Vh1woVAh9sdgePrX3yCEeUjW@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvpLNVjspKHNIAt3JD84ELR+3wny7d4FO/rJLjxFGBMtHuTIv
	C+s32231Vmlars4K48Yyaz+K8X2MkxTjjwtyvYDFpUKAhaKmTutJ
X-Google-Smtp-Source: AGHT+IEKgnIB+SWOrrd9Xanv3pZFWxB1RKR/2QBbPKj+Hqb6wMAUBE2ExVgv4hSDv1rMJf08XXDI9w==
X-Received: by 2002:a17:907:7e84:b0:a77:e1fb:7dec with SMTP id a640c23a62f3a-a8a1d2c81a7mr626286366b.17.1725465764015;
        Wed, 04 Sep 2024 09:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e1800sm7945066b.193.2024.09.04.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:02:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] of/irq: Make use of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 18:02:37 +0200
Message-Id: <20240904160239.121301-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904160239.121301-1-vassilisamir@gmail.com>
References: <20240904160239.121301-1-vassilisamir@gmail.com>
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


