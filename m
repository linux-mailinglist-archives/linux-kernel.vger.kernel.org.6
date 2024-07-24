Return-Path: <linux-kernel+bounces-261048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4393B226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBC71C223C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9615A4B3;
	Wed, 24 Jul 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kS/6BaGD"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D7158DA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829441; cv=none; b=BqoAkiSUqlC4xREsqjfFZ3JdsXcAqx+w5BMmpIKQcUHNnbCK14Ar1KTABXBF2k/GjPnoWJ/L97ZpvJ7z/eJAQtUQfsRBYNlu/bpyeENfDc0ARDoTTzGCxAhw1GrxcEl2WQMo6j/vhoZTG4IMqcjxUaziicJu6nWo5+E6XcUQdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829441; c=relaxed/simple;
	bh=ZaJdQt0D9mYBt/7a7QwTMkE+wN+62KNmLBYo0UShddA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZQg85WER1PzqVmasaBy99CBvcjScyi16EWpeGcCbDozgaHnV6I4J+Mzu6PEQh8qrDdZ+mM6Xy0dKxZJCuxT+qO4xHUQXwF4o1rsXxSx5Awfl6cnpKn8TP7eJ0NtJgVh+xURue7+pgJt5HgSlvCamDY11nZcsH73O9DIe1ApBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kS/6BaGD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8667F2000D;
	Wed, 24 Jul 2024 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721829430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QR06apVRJjhxG+CqyyWgjhXKf9amybU00BGsGyyilaw=;
	b=kS/6BaGDp9r9yAW7MUuyMCYfuCroXo4j4lvgJcNkgPrtzVMiPGmaMJ18IUFt9w07vOwYra
	dkMsmlO+RJRjsuzDPpwqtCnuomeHiYNUarotrf8WPZ5GcXvUr6dlzPj3fHt86aYXgu6nnY
	O/crtsP/1ztXujMG4OLwZ9kdkYJ1JOYFDwPAiy8/XBdyjEDd/M4hcqEC+pKyiLQavSeYar
	58XJmyGrKgzRUn1/ZjeyLEUifRBnjunJtjhhCFgwuSVJ4l86xF7Aqjd010JfK7DyCfO04C
	Gc6u2tBk0EDggStNRO9IR8jCBbUTF9llXykATSTuAqakCCpjDXL6BX7T2WVZMw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 24 Jul 2024 15:57:10 +0200
Subject: [PATCH 3/3] nvmem: rmem: remove unused .size field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240724-nvmem-rmem-v1-3-d2e3a97349a0@bootlin.com>
References: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
In-Reply-To: <20240724-nvmem-rmem-v1-0-d2e3a97349a0@bootlin.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

The private structure used by rmem contains a `size` field that is
unused. Remove it.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/nvmem/rmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index b2dd25acd7d5..418c10cf1266 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -13,8 +13,6 @@ struct rmem {
 	struct device *dev;
 	struct nvmem_device *nvmem;
 	struct reserved_mem *mem;
-
-	phys_addr_t size;
 };
 
 static int rmem_read(void *context, unsigned int offset,

-- 
2.45.2


