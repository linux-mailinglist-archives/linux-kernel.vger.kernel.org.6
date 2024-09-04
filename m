Return-Path: <linux-kernel+bounces-315497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791096C351
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D61F291EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A31E009B;
	Wed,  4 Sep 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwv+R8yF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A931DEFEA;
	Wed,  4 Sep 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465768; cv=none; b=KGrd8KyL8HRD9MWvzF8+EYI7P2foiNi+TFpm0bNbcHcJfwts9IcNKmAIKNtO4saQsJBvEUcoLPt+7/GRgp5Y50hWqqykXgQRxGcsyi0X7YWh+uSRvZCRSUjjaqa0Wpqj+bakvHx5oWOcMaA61syD/LWOT3btV2mXXSvLgf74h6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465768; c=relaxed/simple;
	bh=Z1gyw4dLYobDHCz9hkB7O0dcevWeFPaiYZkhlrA60XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzcKECWmetmq72ydP5JZMxsXdUw98d6Q2ICPvWBM6wSP6yQ2ijzXfB3paw1Xq/pr2hpYI30GvwCgibKUue7Kx13+ATxZ6T6v55t1lh2EOEDPU1qNwF9LlFxfkmyW+gZuJocqY+YfwzaMrBnn8TFbgIutQVv69Ko2nxVaFcAOu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwv+R8yF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86abbd68ffso180506766b.0;
        Wed, 04 Sep 2024 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725465765; x=1726070565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOlPyDVyDNnJxsqLNjwzdaNNGqxcXxFsQNriucvgAGc=;
        b=Cwv+R8yFk8lmJt+WCDRSk+5i8miWktVxpprAupStp69t377xHaDbCz36vZphn3ogM1
         6xdpo2Z2UOGuX4IDkF35HFdO6gQyntf11cipypW61Vyrqn2ibIWmjkz3K2xVELAmDRzk
         gAuE6DylvGcex4o90Z0whVKnQcnMR07dDwHkdo8XQNpCzMbEV6Qm5dLPirA3/X3Mq8/+
         HaMGCXce+B60/Chx1p6BIfxYeYAOndolPA6+A/nsNdarB3z7oUsi5qbBaGDLNEOPEzCD
         SqOrOUwFOSnJHud9kTojgijfJs50KHGOMwCNNVyeCZXGZUxlq6mRMfPlO9GGtrsXo9ho
         1bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465765; x=1726070565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOlPyDVyDNnJxsqLNjwzdaNNGqxcXxFsQNriucvgAGc=;
        b=vvByCO/cF87EJmKl+boDXfkxNDuDl3zpU/DhM16qIG9Nmzx3RXfodXKsg0MLH+Zdew
         dsosLGCbxuU1SXdwIpijXTEMEfbh6Nh0C+rojdAb6AWQBkRshWPUw9VUp86mkNfdiqEB
         fnvita8BDG2VCiyJIzTZjrJO2cjRSzuNiwWbwOu7EyJFVW5NcOx8k7EFxDpgVb0L72Gu
         B+W4NS46YFP3sc4jxrynykURFeeUpHfsor6hNU65A3+eA9ZBo6MGfSPk6tmChmvoveiA
         gRst2ePlhZG3E+EUk8kLJY9eZdNGPOB7AXVSRmXxFVRvQoCHUtsb5pi35SOliJVYTkBA
         l16g==
X-Forwarded-Encrypted: i=1; AJvYcCUR00DLuEECeMOYLN4EEShpVqmbEygYee9QCusSWNV+RFIt/wyRLXJlGhsBGsfRTYNENt+KqcHRu1hWiHH2@vger.kernel.org, AJvYcCUyjYnwXk6BiIxxMr+vH2oniixWRTJpY1O8/8ZUeFybjcbtMJBYFFtjL9w57+rUZwj+CvjMYShXAGdF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp75Mpzvlr91/9fLPQTAEdcW/m3GXgGqcsQigul76Svwnurr0C
	K3ZSj2pcl1wig6sbR5/NgUBZz7YnUkH7SsPR/4SR70yDdb8gLtxQ
X-Google-Smtp-Source: AGHT+IG2piJzipr/JVVcLEfvEz1luzO7OwdJYFah1S2GGEPzoKOf977ggGbGuM4z+s4x7RD26h2/5w==
X-Received: by 2002:a17:907:3a95:b0:a7a:a4cf:4f93 with SMTP id a640c23a62f3a-a8a4319cf62mr171551966b.32.1725465765068;
        Wed, 04 Sep 2024 09:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e1800sm7945066b.193.2024.09.04.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:02:44 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 2/2] of/irq: Use helper to define resources
Date: Wed,  4 Sep 2024 18:02:38 +0200
Message-Id: <20240904160239.121301-3-vassilisamir@gmail.com>
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

Resources definition can become simpler and more organised by using the
dedicated helpers.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/of/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 5d27b20634d3..b1bfa14e1c0a 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -429,9 +429,8 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 		of_property_read_string_index(dev, "interrupt-names", index,
 					      &name);
 
-		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
-		r->name = name ? name : of_node_full_name(dev);
+		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev))
+		r->flags |= irq_get_trigger_type(irq);
 	}
 
 	return irq;
-- 
2.25.1


