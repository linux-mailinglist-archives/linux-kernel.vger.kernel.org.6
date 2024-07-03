Return-Path: <linux-kernel+bounces-239045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E81925562
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4791F23977
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230B13B280;
	Wed,  3 Jul 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCJFGlJN"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC392629C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995461; cv=none; b=isnrTOV7XcrzScqG2vpQwGEV4plvFBxrWis6vqHIwpYTNtp4eI34zE8SVdkvl0fniiiaJH6ysC/f6TmxoF9hsq8JkIjD4FE6iQ3mOlJ30nrHhV/LHGwK6z8Bin/LxL1FZPhoSr/UDQZuSJucwUtEWPLYxG1S5RK5KBmqEHyi7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995461; c=relaxed/simple;
	bh=Y4rDUf52JWPZ9MeShgIRd+f9mgpzSlHQnn1AWb2aU+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dx0bSISlvuIkwGCqN2pKmEKdQf7h07mnRLKjtL7XNhLLfj4s/9ft9VvVDkyORTn2z/9FzTYMxfuMg/h2YdTCvIZfb8VqGKqkA1OVupKKKCF57fvr31BAOD18U9pIlf1dU6L4eEYZuMxUFgifAFOcmIOgSP6LyRRKrkXgDmyQLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCJFGlJN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42565697036so2084575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995458; x=1720600258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2Vordpgq08V3AOsjjIdK4cHDDX5qouIu99HjhhGPw8=;
        b=yCJFGlJN+iE6+tlmIJk9CIpYuBd+9FWiXdq6E2YtUWQbbAftWB2EonVhXNzNdUap9H
         Zm/KPktlsg9Y9qBE25y2/N0mxTKGKth40QiSjozEiuGvlJMZgofvlW0+npmP9mkYTQNf
         ntN3JQnWSpwnxtR+ZHvFpCFk6CrmJ/Jiz5BeapIlcMUVDhoDTFvhn96AdIESPvLMAvIB
         b54qu6+fplj/HvuLmChhor2fJv7/QRpEEcWrHTW/td5xYgA5tZv4oMypnCRQdEZkxUJ1
         N+ZgfXsP6MI+zQZ8Z5zqirxl3zW//X2jB0NUjioE7S0EtPKZnX1uhlNjX/TDgUJrJw/G
         hEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995458; x=1720600258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2Vordpgq08V3AOsjjIdK4cHDDX5qouIu99HjhhGPw8=;
        b=LbPr+VlrN4lyJLqjKhtJoCz5ZevFFYz8sWk6F2CXqmmsZE8NBlCLiZJEE+FkKle2Kw
         4ikVNMPP/s21EhvFZ68gaY0m8iI9nm0Lwe855NrU+zfrnHUI0Aajb9yRd4Hk8siCrFaC
         N3UU0MhiKeqf++bRQW+m7b3fuPMJEa+o9Kwcy61hMevz+fInxMOA5HDSG4+pFU3UXMAq
         7JbBi8QUHDQ/5J5LXVUeVgviDTUja/BVhLaswe2Kra3XOJHqVqPHp5pGSlWaeFIH2AmZ
         YNeINitnlO7jXpcW1ZnxkLW7qOo5CA2hTv0mBnZ0/ZaJGGMRlqDtLbty/qhA9++1ikID
         iF2g==
X-Forwarded-Encrypted: i=1; AJvYcCXv/JsW7PNuzfWVyPcbvebluUfaD0giX3DHoyhvQ6Xr5WWrhCJnQQCvBpiA1TUTsdPwFchL0G1lHTaspB73B3Q0hI3QT6ViD+HN1ZCl
X-Gm-Message-State: AOJu0YweWvZHjZM/NGzhWt8L6k5ZFYx554SgM/pJ1v+zxZJRyjj/vGdt
	+A/Yc4XuNwha7ie0B517bxdPY8AeFrqkSMf0IBi68/AW4Rl1V7eiRqvUXBbK5EA=
X-Google-Smtp-Source: AGHT+IEO0qOMucq0/Dkxhbd3FQ73eQMSmyuAD2YjjnYf5q6PoaQe0ZZMFP4WVE2UsDcDNDtS+2Ienw==
X-Received: by 2002:adf:f202:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-367947b319fmr762548f8f.28.1719995458595;
        Wed, 03 Jul 2024 01:30:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm15302768f8f.16.2024.07.03.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:30:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] cxl/acpi: simplify returning pointer without cleanup
Date: Wed,  3 Jul 2024 10:30:55 +0200
Message-ID: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'return_ptr' helper for returning a pointer without cleanup for
shorter code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..1e4bed8a933e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -339,7 +339,7 @@ static struct resource *alloc_cxl_resource(resource_size_t base,
 	if (!res->name)
 		return NULL;
 
-	return no_free_ptr(res);
+	return_ptr(res);
 }
 
 static int add_or_reset_cxl_resource(struct resource *parent, struct resource *res)
-- 
2.43.0


