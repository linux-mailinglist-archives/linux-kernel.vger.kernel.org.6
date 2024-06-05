Return-Path: <linux-kernel+bounces-201835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F818FC417
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF57C284A69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA8518F2F1;
	Wed,  5 Jun 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FlYJqt0h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gl7th0py"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34618C321
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571088; cv=none; b=qzEK5cZJ4AOGnIyecg7cnuzuhndoaR2HaCLYiFyLuU4MFfA8zFw/wYHumXksTGYsI/IqGcvG7Z3e+n6gt7mcL8cAEjFdpWs9PRauLTN6DSfXq81HfzEF5DOMgw6uQvSbDrBSU5vPsgwtBb1NNa1lWeR0+tNpbKQThAGHts0bHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571088; c=relaxed/simple;
	bh=bX23BzlAIyUwv5XaT5UEHsPZU+heRgXBUj97RkhaTBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeXWuwrJvOAieIR+GNa/0oslhwf3UjMVEFBxrsfeGXgdNRbjWajLQqsz2iPCu950s7I4Sr4/njI0Nn6p9DXLtE0vzyeeVQlb/XvN2IObsfy0UjvFi9xB68gEbOSMx47kDNVm43fmTBRdiDp5eEoFrziH2a+X6xCghhAtL6uuVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FlYJqt0h; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gl7th0py reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717571086; x=1749107086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32MmV7Af8SI9o2LQZGI6LZQGXaTSQyqVttjyukn0kuI=;
  b=FlYJqt0hpNYQwcFwbVVsJbdU3bRpXPXMshHCSwGOwzzqZ2lmVhKXfQEp
   rEyjBWFj2YKsXp2tlGf1wegKaNEJ/+c8eYVtgFsu75JOMBFMO28j7F5Kh
   dvQGqxYqQcXE4UmEpxy2D/bXr+qjaolShD6pVdgp8T/r2dqPYytghXkHL
   0GAfQCrI1Jr98S4k8WgvSZfT7NwsEktrDgK5u9UI5b+Sb66lzrpm8aGLN
   oilTb41KlHP5UJ8JRNVZG3biBabCQnlAPVTRGFykAm1olozK/Y1c8eKWS
   ofmhGHCVtFfE7LYTxrUZmrwP2h9hQ39Ia6YRmkHWlbgn+oE6PYDjpKSa3
   Q==;
X-CSE-ConnectionGUID: fTPc0MBpTO250mz0zFOcdg==
X-CSE-MsgGUID: abk4GJFOQEO0Pr3fAdHI7w==
X-IronPort-AV: E=Sophos;i="6.08,215,1712613600"; 
   d="scan'208";a="37226802"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Jun 2024 09:04:46 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8B9E172D69;
	Wed,  5 Jun 2024 09:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717571082;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=32MmV7Af8SI9o2LQZGI6LZQGXaTSQyqVttjyukn0kuI=;
	b=gl7th0pyr0W5M59+mV6znVnu6ka6fBBLQj94UPN0fYNMTIe51ySs93dVmG1IQUeJJNsJRZ
	/dIgPEVrar1Z83H+org4dvyuXtmTRN1eGw5kT082WcTZddAvnopvH3Bvz785HT2xaqp24S
	Q7VESn8B68NgG/8QKNQB8/3vt8wJECdinWXSL1n7HDtJ/EJihWPm2tkP0RcWcsz2jE1aeq
	ZLC8o7KrEONfL/lYQBEnSOXIo8xKOiFlm/hstPmwN4kxwYl+XIMLkCpInNQIxmn8LSM+Tv
	MNvy4xLWIXDu8QtACltalkFQWW1bgafnMf3CPRcS/k8cx2D8zyC7fdD8D4cw7w==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/4] mfd: tqmx86: add I2C IRQ support
Date: Wed,  5 Jun 2024 09:04:03 +0200
Message-ID: <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Gregor Herburger <gregor.herburger@tq-group.com>

The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
Add module parameter to allow configuring the IRQ number, similar to the
handling of the GPIO IRQ.

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index cf27497245322..b96af7091b6bc 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,7 +61,12 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
 
-static const struct resource tqmx_i2c_soft_resources[] = {
+static uint i2c_irq;
+module_param(i2c_irq, uint, 0);
+MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (7, 9, 12)");
+
+static struct resource tqmx_i2c_soft_resources[] = {
+	DEFINE_RES_IRQ(0),
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
 };
 
@@ -271,6 +277,18 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c_irq) {
+			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
+			if (err)
+				i2c_irq = 0;
+		}
+
+		if (i2c_irq)
+			tqmx_i2c_soft_resources[0].start = i2c_irq;
+		else
+			tqmx_i2c_soft_resources[0].flags = 0;
+
 		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					   tqmx86_i2c_soft_dev,
 					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


