Return-Path: <linux-kernel+bounces-266782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890D9406C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC0E1C227D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4714F9EA;
	Tue, 30 Jul 2024 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OVHIQH/r"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DE2114
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316348; cv=none; b=FhBlgFJzkeI2HGMLZgGZgOs2Kmm3+6LNKG4v6P8vqUFCIa9OEOkgiXy1wWa3b49bWS3egdWe2Y8d2s9yROiuEulk6tn0Jhj+XfGE3pneg2Sf/XvutWzr/ZIS+ulnljH264u/YBNx2WQL0W5jlcwDXDu+78fzYjmDIBdJJek/G3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316348; c=relaxed/simple;
	bh=bme4o/4I0sgLcFj7XGElo3gb53rFuL8XYo4QvTtxmvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6RW7rrZjz+6x3aD7Qlq91B266wqOr+HczdoyKX+no6BiVPUU0MFf39DXU5Go1q1lDerqPD/LDSND4a7STDdPLjx1fCJILpx0V5VewaG0y3s7RLuaJyO9ak6kEEri9H1CDHrvyLMte/iZ9lRj2QJ7lYtzRRc0a5V7bFmO4DaW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OVHIQH/r; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2cf11b91813so2572001a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722316346; x=1722921146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TT6aLVW/zdodnhT+XtKZ6i2hFkw9MF/DUQGOLynubkI=;
        b=OVHIQH/rKzwUq7b4vEx/+heu2xuxrHIWvwD7yg400MhvHR0S7UyeRd/rt9OZMgho+f
         Zkz/53RsAX1UbEOsS5Jo3i9SIWy0TI5tp7imHyiqkp8/VYteOPpZe8xqBOqZu93ZZQ9J
         IZMQc6hKZ6RAvYqNeNR2aHe5FQwBqori+MhAQQpu244xQVcNJrY04ozkfzIXqwE6d0H/
         ICRtfVBOibjAlYg9qPxpTs5nabYavatyQSG6rGqpZD8QE3OABDFpO5p6alhVF7rq1Plz
         xK9fRSWQ0dnwCwnWeYnq9fPVrbNgJ7GdYuRWHCJXAMOXu2PmsJEDlMbC9+J8uKCdwDwi
         ngmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722316346; x=1722921146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT6aLVW/zdodnhT+XtKZ6i2hFkw9MF/DUQGOLynubkI=;
        b=aaf3FCY8uYRh6DGnALo+zAfP8sq0BOMmDGNMPISNrDEEqu8MoEBUWhjkl7RlFw8dXt
         HgJEkeS6hCJSg4GjHJ/4MhlKeBzwuKKcyQJ3onlbSgjUHSRQz9sVx3236nX4X0RaZjAQ
         eEvpklSEjqrkmxb5G2T8XDJUgsv33+30rtvafC8IaiFgPKbzHmfLxBOxBrlRG6e+SIX6
         kYZdXYyOqPpUrg/+IVj6zO/BrN8xhjUtBMUa68ax/F27eyGtKNm6sC3/2lTnxHfrr9RO
         TGCSi6KFa0KbpzPkPdMot/qVhHqyYwabHN5nxweUdOb+u1wd/2SXK6/maa6wx+0PCuLy
         mBNQ==
X-Gm-Message-State: AOJu0YzzAe4LhB7uBcvlDhvCXVf7Sqcj9o58RNNjHnPmb33qxKGCzDMm
	f8j2nUNwtkuDVee6ae6tHuTjZY6YtChTyCBoj8usNRt5+7ayPzDIKufEXuLbql68J/gEM2mmnRH
	e2V7QTucm
X-Google-Smtp-Source: AGHT+IFMHivNH4RMDotuWrEigk/566gljKmvKgYSaYrdZAxDrTLZ78PUztPHx2BFQsrKbEtPpLVQaw==
X-Received: by 2002:a17:90a:1787:b0:2c9:75c6:32dc with SMTP id 98e67ed59e1d1-2cf7e09a8b8mr8383256a91.1.1722316345586;
        Mon, 29 Jul 2024 22:12:25 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e8957sm11497728a91.39.2024.07.29.22.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 22:12:25 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH] serial: 8250_platform: Enable generic 16550A platform devices
Date: Tue, 30 Jul 2024 10:42:18 +0530
Message-ID: <20240730051218.767580-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, 8250_platform driver is used only for devices with fixed
serial ports (plat_serial8250_port). Extend this driver for any generic
16550A platform devices which can be probed using standard hardware
discovery mechanisms like ACPI.

This is required in particular for RISC-V which has non-PNP generic
16550A compatible UART that needs to be enumerated as ACPI platform
device.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/tty/serial/8250/8250_platform.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index d5c8d851348d..bdfb16bed4f2 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -6,7 +6,9 @@
  *	      PNP 8250/16550 ports
  *	      "serial8250" platform devices
  */
+#include <linux/acpi.h>
 #include <linux/array_size.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/once.h>
@@ -100,6 +102,65 @@ void __init serial8250_isa_init_ports(void)
 	DO_ONCE(__serial8250_isa_init_ports);
 }
 
+/*
+ * Generic 16550A platform devices
+ */
+static int serial8250_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = { 0 };
+	struct resource *regs;
+	unsigned char iotype;
+	int ret, line;
+
+	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (regs) {
+		uart.port.iobase = regs->start;
+		iotype = UPIO_PORT;
+	} else {
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!regs) {
+			dev_err(dev, "no registers defined\n");
+			return -EINVAL;
+		}
+
+		uart.port.mapbase = regs->start;
+		uart.port.mapsize = resource_size(regs);
+		uart.port.flags = UPF_IOREMAP;
+		iotype = UPIO_MEM;
+	}
+
+	/* Default clock frequency*/
+	uart.port.uartclk = 1843200;
+	uart.port.type = PORT_16550A;
+	uart.port.dev = &pdev->dev;
+	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+	ret = uart_read_and_validate_port_properties(&uart.port);
+	/* no interrupt -> fall back to polling */
+	if (ret == -ENXIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	if (uart.port.mapbase) {
+		uart.port.membase = devm_ioremap(dev, uart.port.mapbase, uart.port.mapsize);
+		if (!uart.port.membase)
+			return -ENOMEM;
+	}
+
+	/*
+	 * The previous call may not set iotype correctly when reg-io-width
+	 * property is absent and it doesn't support IO port resource.
+	 */
+	uart.port.iotype = iotype;
+
+	line = serial8250_register_8250_port(&uart);
+	if (line < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -110,6 +171,15 @@ static int serial8250_probe(struct platform_device *dev)
 	struct plat_serial8250_port *p = dev_get_platdata(&dev->dev);
 	struct uart_8250_port uart;
 	int ret, i, irqflag = 0;
+	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
+
+	/*
+	 * Probe platform UART devices defined using standard hardware
+	 * discovery mechanism like ACPI or DT. Support only ACPI based
+	 * serial device for now.
+	 */
+	if (!p && is_acpi_node(fwnode))
+		return serial8250_platform_probe(dev);
 
 	memset(&uart, 0, sizeof(uart));
 
@@ -198,6 +268,12 @@ static int serial8250_resume(struct platform_device *dev)
 	return 0;
 }
 
+static const struct acpi_device_id acpi_platform_serial_table[] = {
+	{ "RSCV0003", 0 }, // RISC-V Generic 16550A UART
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, acpi_platform_serial_table);
+
 static struct platform_driver serial8250_isa_driver = {
 	.probe		= serial8250_probe,
 	.remove_new	= serial8250_remove,
@@ -205,6 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
 	.resume		= serial8250_resume,
 	.driver		= {
 		.name	= "serial8250",
+		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
 	},
 };
 
-- 
2.43.0


