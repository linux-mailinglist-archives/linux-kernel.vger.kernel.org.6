Return-Path: <linux-kernel+bounces-273171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9023946536
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C0C1F21B33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB98137745;
	Fri,  2 Aug 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E34VGHam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186271ABEB7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635064; cv=none; b=DGrOlJoo/hWz5bG2irtk1CE/Nt3N5D6BX6TJDG+DNHutic189ihtOU1otk6nInl5XvBbIznA2nMu+j4+5fmkt76c3eCS++rv2COeKB0mo/vbY07kanxOQuXXSqrt621sN6UbT7l0RlnIoVLdYtLvjUjuLJx7XghUoTCl2MCgtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635064; c=relaxed/simple;
	bh=wmX5BOavDV5A0y4JGTIfwXXXDCYeYux2q4KKf6xw9vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myUOAcJ3KG1yTXZzDGntP/j1gGbVUFVbFDayDVktX8EVRgIH4b5o1jIXoOHhCiBE2gUOMU6f9soYO6vCq1FaB6ElGcaVP2Sj75q/eVxnElCoPh/kDmZHAcfIPe9uPzYjWQmNmmmkpR64fHIyXQbu2LNzZ0i9ZHFhlXmCVl3I2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E34VGHam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2175C4AF11;
	Fri,  2 Aug 2024 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635063;
	bh=wmX5BOavDV5A0y4JGTIfwXXXDCYeYux2q4KKf6xw9vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E34VGHamkEFAsuv6m6ZKnXZVpDvel53+0WGEuomQDdXsiNOY7IlOGo+NEWMqfWSnV
	 UIz2EsZ6/FjAg5o6/jOZ6+GMVI7QmQGuW9gR4odCeELqyWkE9nS4Zm1otbIE4q4N6A
	 BpKIrZM4fUOApvdDrXdGhh4eSUnTpa66JbQxEKcVgVz88ebRWL1toHdCWj9VRajlQU
	 SdCzqGu409bHWlNojB2k3TSUJF49smY2qxBx+r8IMQ8aoE0xQKUzg1oLAZ4oSVhh2B
	 1pC/xuHFMyiJAS19E9a+2NmQ3+vONULZcqlloUdaTBW1yCng8jvrjIVm4eQRspdgEy
	 eZQp0oz87Hlcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1sa04T-00000002naD-2eiE;
	Fri, 02 Aug 2024 23:44:21 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 1/7] arm/virt: place power button pin number on a define
Date: Fri,  2 Aug 2024 23:43:56 +0200
Message-ID: <e5afbbaf2836ebe22b48c455285eccef86db966b.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Having magic numbers inside the code is not a good idea, as it
is error-prone. So, instead, create a macro with the number
definition.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/arm/virt-acpi-build.c | 6 +++---
 hw/arm/virt.c            | 7 ++++---
 include/hw/arm/virt.h    | 3 +++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e10cad86dd73..f76fb117adff 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(dev, aml_name_decl("_CRS", crs));
 
     Aml *aei = aml_resource_template();
-    /* Pin 3 for power button */
-    const uint32_t pin_list[1] = {3};
+
+    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
     aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
+                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
                                  "GPO0", NULL, 0));
     aml_append(dev, aml_name_decl("_AEI", aei));
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 719e83e6a1e7..687fe0bb8bc9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     if (s->acpi_dev) {
         acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
     } else {
-        /* use gpio Pin 3 for power button event */
+        /* use gpio Pin for power button event */
         qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
     }
 }
@@ -1013,7 +1013,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
-                                        qdev_get_gpio_in(pl061_dev, 3));
+                                        qdev_get_gpio_in(pl061_dev,
+                                                         GPIO_PIN_POWER_BUTTON));
 
     qemu_fdt_add_subnode(fdt, "/gpio-keys");
     qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
@@ -1024,7 +1025,7 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
     qemu_fdt_setprop_cell(fdt, "/gpio-keys/poweroff", "linux,code",
                           KEY_POWER);
     qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
-                           "gpios", phandle, 3, 0);
+                           "gpios", phandle, GPIO_PIN_POWER_BUTTON, 0);
 }
 
 #define SECURE_GPIO_POWEROFF 0
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ab961bb6a9b8..a4d937ed45ac 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -47,6 +47,9 @@
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
 
+/* GPIO pins */
+#define GPIO_PIN_POWER_BUTTON  3
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
-- 
2.45.2


