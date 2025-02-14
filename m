Return-Path: <linux-kernel+bounces-515666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F4A36774
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7F1188C6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4D1C861E;
	Fri, 14 Feb 2025 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDqAkAW5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24301940A1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568287; cv=none; b=Dln9YIdhzEODJOaS0L+DkqLu5FLMYYJLfwv2UlMPXzXUfdeYprD/i+sqGYyFXNIc9aYxTfFt403RbJKBsMC2iOsplnO88JClA2X7kTm1/f2YaGZ//wEMqoRKP1sIDJQBgkPfgqRrhTf9KkzSQ/zuGK1/ri0oKtK1cxoKsoTrOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568287; c=relaxed/simple;
	bh=lwoVslBS6wZ1Qezv4juBXxlILTIYR0EXGigMemVLFi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB0dvc444I8GNnfZN0G9bopjTiUqv/6bDZ542COJXhb+I5qaUOBKvxDOc8d5ftqqyi+MG5vuN/A1t3t0KyAoGgX9q+gHiRSKA5U1vN+DrAzaP6zo2M/pmjYO131tLcYlU7Eo5rSVTEsP3umqZlCnmmYhZQpjnlXubJM2XeECWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDqAkAW5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739568284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0yGoDn9WQL4xqIpbzJrahMzWypuCj7vXrg4Y7knzprE=;
	b=iDqAkAW50zzxHjT+7w6Ox/CCbzDHT0rBDJq+KRrPq17bFEr8BqP3PNql0gu/+8t4dmaX76
	hFqwh5yMyvjOZnYLC58y1/I2oXME74PQPm4hPRTwmzyhsyAuOcmjpeMi+qPjr8fXNG8n9q
	MA1A5mm5JYc5oSKku7wyn0um5gQdVOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453--DlM7kyzMGukDIKPaNUhJA-1; Fri,
 14 Feb 2025 16:24:38 -0500
X-MC-Unique: -DlM7kyzMGukDIKPaNUhJA-1
X-Mimecast-MFC-AGG-ID: -DlM7kyzMGukDIKPaNUhJA_1739568276
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28F5519560AF;
	Fri, 14 Feb 2025 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.32.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6C88300018D;
	Fri, 14 Feb 2025 21:24:31 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Wentong Wu <wentong.wu@intel.com>,
	Jason Chen <jason.z.chen@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mei: vsc: Use "wakeuphostint" when getting the host wakeup GPIO
Date: Fri, 14 Feb 2025 22:24:25 +0100
Message-ID: <20250214212425.84021-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The _CRS ACPI resources table has 2 entries for the host wakeup GPIO,
the first one being a regular GpioIo () resource while the second one
is a GpioInt () resource for the same pin.

The acpi_gpio_mapping table used by vsc-tp.c maps the first Gpio ()
resource to "wakeuphost-gpios" where as the second GpioInt () entry
is mapped to "wakeuphostint-gpios".

Using "wakeuphost" to request the GPIO as was done until now, means
that the gpiolib-acpi code does not know that the GPIO is active-low
as that info is only available in the GpioInt () entry.

Things were still working before due to the following happening:

1. Since the 2 entries point to the same pin they share a struct gpio_desc
2. The SPI core creates the SPI device vsc-tp.c binds to and calls
   acpi_dev_gpio_irq_get(). This does use the second entry and sets
   FLAG_ACTIVE_LOW in gpio_desc.flags .
3. vsc_tp_probe() requests the "wakeuphost" GPIO and inherits the
   active-low flag set by acpi_dev_gpio_irq_get()

But there is a possible scenario where things do not work:

1. - 3. happen as above
4. After requesting the "wakeuphost" GPIO, the "resetfw" GPIO is requested
   next, but its USB GPIO controller is not available yet, so this call
   returns -EPROBE_DEFER.
5. The gpio_desc for "wakeuphost" is put() and during this the active-low
   flag is cleared from gpio_desc.flags .
6. Later on vsc_tp_probe() requests the "wakeuphost" GPIO again, but now it
   is not marked active-low.

The difference can also be seen in /sys/kernel/debug/gpio, which contains
the following line for this GPIO:

 gpio-535 (                    |wakeuphost          ) in  hi IRQ ACTIVE LOW

If the second scenario is hit the "ACTIVE LOW" at the end disappears and
things do not work.

Fix this by requesting the GPIO through the "wakeuphostint" mapping instead
which provides active-low info without relying on acpi_dev_gpio_irq_get()
pre-populating this info in the gpio_desc.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2316918
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 35d349fee769..7be1649b1972 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -502,7 +502,7 @@ static int vsc_tp_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
+	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
 	if (IS_ERR(tp->wakeuphost))
 		return PTR_ERR(tp->wakeuphost);
 
-- 
2.48.1


