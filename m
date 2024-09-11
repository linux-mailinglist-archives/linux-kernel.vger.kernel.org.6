Return-Path: <linux-kernel+bounces-325327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F829757E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6018F28432C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414B1AE865;
	Wed, 11 Sep 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjSOpDh6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A021AE039;
	Wed, 11 Sep 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070598; cv=none; b=ZazKP7Z4TBzgMb0QKn+u3wspc9Hy8277wa7WPGAZgXCp5lKmUc2ABtPKs5UCVhGznS8y+b4gIgNG6Z4jRArkzZIY15ksCBeyE49Ri6gbYShyS+AOoKA+EgrQbgL/jCBFuoPAqEV9WA1Ynz4lB4rBhI2mfot/eCwjBOFJiofLhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070598; c=relaxed/simple;
	bh=6iTMa7L1Y3mYgrQhyvUF/e12dXDdZo/h9tFzArNqF0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6xkPb9xL9UVfPz121vItZ00U/VXrImMw7JtWQ/+FwpwvM8zy3SrBWXXY7LwNDLpma2ilvNjP+/A7yloZWn4TDUnvDC1UEOb+nqaShSLI+Lwf5qHCR3cfxqU/dAIPrXY4I35EqhlXwBkHKdLNPpEV/SxkbV3+usx63jTUy8gqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjSOpDh6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d64b27c45so493502766b.3;
        Wed, 11 Sep 2024 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070595; x=1726675395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zsfn69703GEXpjpUIVNTmvpMXLyqrldpw15ngGkOQeY=;
        b=VjSOpDh6ezDbiM7hr+Q24Qh3S8uUjVrywPuUBewzZ5qkXQlAzDavgQZS+4HxhioDq2
         Y9KEFUHPptOBppEKPG4Hpcfyqttj40gDf/ndBQ/uiEHl/LN/cRMfFF9wA9QyFmbiS3dV
         JSOv/KAZ0Y9j+FrkzL8oMq6hhjCmjHROKpORp1+0h9mpPJ9b6W943+8quvfBkiH4i3Wa
         /njmt1uj5GtQD6f9Eisw1/9GfXKstC/cdo3wl3DhTNiwow1JiP3wAP6G9kMB9OiSzO68
         dymDIx5NokEV3baqGD/v3KhpnJYC+V0U2i5+t39e+TP0hW8tex/2QVsYZa70GhGyhw3Z
         lebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070595; x=1726675395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zsfn69703GEXpjpUIVNTmvpMXLyqrldpw15ngGkOQeY=;
        b=KU8Zl9Wx+TCWUAe4hf5yvY0AZXxrpdxkk6+ODF7yjMT5M6WeLjpv57/jw4YGsSd9en
         4xI97iYz2hqax913UTdukOyTH27cmZiTu0G4wxtj3eMGF7NLYGGqyHCAsmtPZXZvTQR/
         krZk0T4z2rEIY1u4qOL0OBCn30gfa5nB8hQdUFp213n73ehkv/WU1z1uKTweaeqvBbnt
         f4U67wPj7nvgRHVdoxVFv0zMd5fJwfGlmcZNFSjKSY/qs5Lqfsyuv/3ZTPBHBZb7vRAK
         BawafgDCSq7Gx3Fz6yEvW3Cdqbny8PWCvjcA65vl3DE3OLm9nAgzK7It/1evky9dvGYX
         /Yew==
X-Forwarded-Encrypted: i=1; AJvYcCVk9YYp+wOhAm+bvLu912GheA693hnV+zDjrVzPMEuFDTQbHY62boVUzRBiaV1swexELHBUmD2kgiTa@vger.kernel.org, AJvYcCXZd7TfnMGITyMSvJP/oM9USw0lHdeL4zJzDjUx/hyaYvOSRPDKeRl68BXHY0Mwo9/+o64xbEa24mcb5eO9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EJKREo/aZC8J6Dp3Tv4UB+ZictqDtwY1Ttmhtq9YEaWl84vz
	XadNjqCdAdJkCM30m8dt6Gve3M4UYVwjQZmz16tdM4lkNNvx9g+P
X-Google-Smtp-Source: AGHT+IH/LLf4PrwkHLESTCBOzTFR+MsO1r1IfLokqGJPLcPt2sFlASgGyRhdbZyBM3JbIzEIjHLnew==
X-Received: by 2002:a17:907:72c2:b0:a8d:1774:eb59 with SMTP id a640c23a62f3a-a8ffae1db80mr530008866b.54.1726070594162;
        Wed, 11 Sep 2024 09:03:14 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:797a:1b45:332e:77c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d64880sm621635466b.219.2024.09.11.09.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:03:13 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 2/2] of/irq: Use helper to define resources
Date: Wed, 11 Sep 2024 18:02:53 +0200
Message-Id: <20240911160253.37221-3-vassilisamir@gmail.com>
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

Resources definition can become simpler and more organised by using the
dedicated helpers.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/of/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 5d27b20634d3..64639f9da9fb 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -429,9 +429,8 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 		of_property_read_string_index(dev, "interrupt-names", index,
 					      &name);
 
-		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
-		r->name = name ? name : of_node_full_name(dev);
+		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev));
+		r->flags |= irq_get_trigger_type(irq);
 	}
 
 	return irq;
-- 
2.25.1


