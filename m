Return-Path: <linux-kernel+bounces-535151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA165A46F94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC833AF274
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA525F985;
	Wed, 26 Feb 2025 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6joGw31"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58A2620E4;
	Wed, 26 Feb 2025 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613389; cv=none; b=MOzi9dvBK0UZ67igHEdFj5xEtGuFHUBT2Vdy0oRReTOiaziRQgHekboe/2FQqUwXvjcxq8Kvbk4DL1ks/owkpcMa9hZQYqfWKcMZh814byjJ7lN3K2M27WSeP0O8j7SKiAl2cLekUVoFZEejSSM6lSkQbK5uP4KBbM5vAL/AkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613389; c=relaxed/simple;
	bh=cga9488zLVFf7sCO0MjjdfdtRfVLyx321Cy+QiZ4Dvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHodTbRz9EED8CVKzerTf4U6qEmf++apGYl2DbsmGKmAqOf1ySBvQDngM9jIZbNjdif3VOU7O3d3IldjKU+iXoNHJKqhLbixO7L9T2rpbAGEnh8KBmiyJnkAhpGPeRNvZ+CK/Svk4aDX2BpfxUIZMrfPQTkBN2VgJVlypLWPJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6joGw31; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472049c72afso3783131cf.2;
        Wed, 26 Feb 2025 15:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613384; x=1741218184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqQoHTg7agUCd14WEWX/oWRFNn9TygqwW0Esl6cK8GI=;
        b=J6joGw31se8+a4xfAZsI1MAZqwSmGysdBPQgVkiqpE4GlcVt1/da/XcygqRmCt90mU
         8XBCOuPK9bnbXcW5QqbZy6y9ygXfB3MAjWIO8bPuiQji91e1r9bPyEmK6KDwTqjA2Uch
         pIafKjDUcuBhYSJ81gGyjAMwu6xEpDDyIH7pNEoYpy/YbTdhjfyHxua7ODT6zcvxskbF
         AJJqc9/qiv4NMYx3eoV2LkaF+TasyRTy9ntsu7D95/GmT8EDpIPgrcqpKsLRII28UYkt
         P+NW5ZqLXvJyx1HG3S1+aZStVybGALwZs4AljIMyrD8LYBafxVElI/0qeB82Tzjp+ufU
         om1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613384; x=1741218184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqQoHTg7agUCd14WEWX/oWRFNn9TygqwW0Esl6cK8GI=;
        b=NGimbjZewLinF5iYO5z5Ysmywj2ltQRyZIJl+KtmgNxMjn4PtvvwMP36/4wzeaAqRg
         Gd1rAyvDYnF4hXB6/520kRuevZ10lzljZX4eWa86NkLBLJUnYIE2n5eYJW5bFUXooNGn
         66qNanDO2FUj1yU1a8lffBka3/TucM3QPrdJt1zY611UltViyb89lqfjpxLT1DqyG7hw
         XoGzS/djSyvsuMwZYMhLiMv4uppMEJIs3Ec4NrR5ivz3uhpol2HYelUdsImYfIGvM/R9
         RgEMGZGNDiqAMR+4sR5+8oT8wx6HfFqKKHP/nFz95LZAqMf0wy4Xhu5hF8MfiBA68D3M
         /+kg==
X-Forwarded-Encrypted: i=1; AJvYcCWUzfInDV3P10R/vzK65pAJOEq1S/ggkWFg4v4Qo9Vhly+MXHwgjeM0inosvG6a0rhu6xGH9zVhWAWlrUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NKsSAuVayamR4U4p8AjpbUig30eOwvWiN9jDIzLoZ3l4gE3M
	1MOrSbkiOzT2Hp/C/x5gxIll7kRc9q66RFMF48ttos4u+nQ491hJacv6wA==
X-Gm-Gg: ASbGncv74F/8kkteZ1VNj1iBzR8DvS1JCzoZ95lChqw40pjLWDfM76jAo3jSCyGw3KO
	HaL/p70y7Cofq7p7U197LZe9VXlP3Hr313F/g/9q/c1P3dXV+JVKxDoI18pga8kznM1CKwdNvaH
	67yko7O07V1j8NCHfMW0bu2UIAA1bgcL+0L10usqbvHyjj//Xm48ngC1ifrQveZTqoqjgYoyObE
	89m8hJpCISYgF2LmmfEWxstFC9RRgrO4NtLGDB7n52h7bja8CRaMNAtf2AbkC1HG8+4p/XH4Vvn
	3A==
X-Google-Smtp-Source: AGHT+IGamOlB8L5DPR7KmoFMGsjzwDrX/7GZPr5d7+DS9KT5p5K9ctOUhXRuQL0MoiV6ugPJfD161A==
X-Received: by 2002:ad4:5ccf:0:b0:6d8:8109:a547 with SMTP id 6a1803df08f44-6e88689b91fmr79086796d6.22.1740613384532;
        Wed, 26 Feb 2025 15:43:04 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976d9f19sm2383616d6.98.2025.02.26.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:43:03 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 2/5] reset: simple: Add active-low property support.
Date: Thu, 27 Feb 2025 07:42:30 +0800
Message-ID: <20250226234234.125305-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226234234.125305-1-inochiama@gmail.com>
References: <20250226234234.125305-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce "active-low" property support for the reset-simple driver.
This property allow users to mark the reset device is active low
without adding a new device id in the driver.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/reset/reset-simple.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 276067839830..4b08f8d70942 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/reset/reset-simple.h>
@@ -190,6 +191,11 @@ static int reset_simple_probe(struct platform_device *pdev)
 		data->status_active_low = devdata->status_active_low;
 	}
 
+	if (device_property_present(dev, "active-low")) {
+		data->active_low = true;
+		data->status_active_low = true;
+	}
+
 	data->membase += reg_offset;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
-- 
2.48.1


