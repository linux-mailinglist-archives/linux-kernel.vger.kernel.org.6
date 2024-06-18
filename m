Return-Path: <linux-kernel+bounces-219693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA790D734
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4956AB28451
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0062E85E;
	Tue, 18 Jun 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F/8Isz2c"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A59225DA;
	Tue, 18 Jun 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723394; cv=none; b=QNYWMVDUw0CyVr/TQZz5CQueKRJtKiIldbv9WETqafUusxJCVzILzOZrxH322CizUpTapHAUWCJCuWcv6637mxTbr40dw39NiScJSKjCkbos1qvcI+2VBaxtcg6e6z0vQ0PbhLsJq+Ss+dJh43yMV552d7wjFv2XNx8WbTTveXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723394; c=relaxed/simple;
	bh=57AlE/JBuz4I+cc9dzSa/amJPM5Cv1VAQVMXwQJljJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFqZzaawlDcEhivtjyBsw+LgpOlzU0gEnVOpiamc9zTUu6kg2hr//UcXqoFXpQ68VAGECNN2r2mWiC1ndpUFl3kqpJMD8S/st4RwK2H5FZpcH1x7sGe5cWdsCTJfO8z2ceKc8jQn1lPx3OaQuHiNj4lCIvt5zGgJRDA23EsbQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F/8Isz2c; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 238C0C000C;
	Tue, 18 Jun 2024 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718723385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y07knCwXHCUucIMupszwWWMBTSEjPRCFVuAxZg1aCBQ=;
	b=F/8Isz2cZMZSb80h5No49mkKv8mv0AtP4iy7wq2kNI8OksYPXYZQCS+mGUVmMDrIKrT38A
	mwhHJdA7HPOnhaxGuOjROhfrB8XLYVigaEpcwW30+Ye+dvwISLLKrCYNZxmwvmwfe61Na9
	szLySrChR3n1+FCTREG9bz6RbrLV10sXPR+G+pQDNS8K21eCjJGmr3xziJQhbjDgQ8g3UV
	lAIWnKv/29zCeZnPUut/Z4s8hXQeAdLZEYFNxgs5VEXxH78A94p0SyDtW0XO8CNDrDRCvp
	Wgs45cV9MU3Ygq0XiedYHh7BtV4sDTiWb+0RqnRH7ijOKhNp2RzVXqWeQwbO7Q==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 2/2] firmware: ti_sci: fix TISCI protocol URL link
Date: Tue, 18 Jun 2024 17:09:33 +0200
Message-ID: <20240618150933.1824185-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618150933.1824185-1-richard.genoud@bootlin.com>
References: <20240618150933.1824185-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

The http://processors.wiki.ti.com EOL in january 2021

Fix the old URL with the new one.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/firmware/ti_sci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ef3a8214d002..5846c60220f5 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -4,7 +4,7 @@
  *
  * Communication protocol with TI SCI hardware
  * The system works in a message response protocol
- * See: http://processors.wiki.ti.com/index.php/TISCI for details
+ * See: https://software-dl.ti.com/tisci/esd/latest/index.html for details
  *
  * Copyright (C)  2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  */

