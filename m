Return-Path: <linux-kernel+bounces-393647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9F9BA39D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5D51F21968
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46170807;
	Sun,  3 Nov 2024 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVw/z83d"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C954430;
	Sun,  3 Nov 2024 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730602488; cv=none; b=EDOwaGNu+81/BAlPiBAG2ifs124AuQCmFuMmBfd3aI/Re13f/2d2CxmsDD9shK4EisvilKg1nFnCdEBRnqHXyjMYOBgWcJ2lSyUEfpSjx0RKKVeqQZNg8cQ9g8j01z6mBDzS0AGt9xQSDLW0+s5DcOuu8O+3Ga5PY6zH5uvc0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730602488; c=relaxed/simple;
	bh=flYBXQEmU6lVa4S29lDD3s75gqQsMGVj/lGkcg1sGEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dAn8YMmvh02St70MaH4JSBWzW1T44jagMrk9gOtlPTPLAgFyJGaNLpsJ6ynfjGz0WAKnCXZBU3S8g3qrd3xR61Wer6wbq3z0v8xQjAEtKqEHpxOVnbY31A9t3a4e1ZM8FMdx1LG4DKUTpqlpFlbNo9fgw2Kb8ZCaKnfTVicWBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVw/z83d; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc5b4190eso1738752eaf.3;
        Sat, 02 Nov 2024 19:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730602486; x=1731207286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pig1jzNQ2MNjxc4weYjfTeNoJRHZv0yUVkReARxcao=;
        b=VVw/z83dbN9Eg04UsbicHRadKPrFIlUgTGMcFOG7VayF13dKD4c23xhQ54ckC+dYRB
         V4iur7KJujpd5HBJMma6h5mVkPb5PJK6RIQCujyey9MM1H4MRUcjw8LqCa5bgRfbO1Yp
         3cewEMirvsAbuxEgGx8RQaSILsDQbvc/RmzdsiZFTZf6ma/SxKX2MByqXzyu8+G+Y3xE
         wxEmmrUB/yXK5EX2ZcOH03GbH6monJA3Z+eGZHShC20wkUK3Dygx3ZNSw5XA5YR2YPbe
         kYlqtWB85aqfHVwVcfYFxh6tcJztqF4Aoc+yBzegsye9nb+lnIrELtlA7FS4+9bKPT0P
         ASuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730602486; x=1731207286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pig1jzNQ2MNjxc4weYjfTeNoJRHZv0yUVkReARxcao=;
        b=IIbjv69iqMMIhrv4MtWhgC9O7u6xp5NJiN1yYBYnwTjoY4hwiQDJbj5BPyeVrX+9nr
         +tsxT2FAJtk9nUS7yvUWx5C9dFj3Mxn6bDTj5MeQUGgoa7pm1j92EiBoaPdv9QTs1ek+
         805WJkRZUCz3QofAis33Uc1XCptAJ25rg+vvG3byxBYAnloxFc3/ivBJ+8QK4dkKRnfU
         MYWURbfkuxvFhXX0bgkXZ91PJIO1oIf7XzzQVG7bXlwNOiIjVB9Po1V7IBq7dXYFVYOj
         TcAscG3/JC58soLcnm0wAjthN6iYv7OpePaaV0Gxf4rvYBaccKEX+zvZLdwJFTrnVHy4
         vbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmk9Y9YnkfY6ctMyjKyFciiWEy5ZToYLkRjMtmW/PgdYa1rE6Hs9qjJGauDTlMwJAIt9bgaWA3oNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm12fqquCwDeWH211hZUJFy7fq/LRH01zRXN1snooR021cGkE1
	rzt9p/VI8m1pLIg6OdNcwEQRhKZSmBUvdwtz69KcnW7HPfMxkfEH
X-Google-Smtp-Source: AGHT+IGCOWgJXEaMsNkUNVbWnTDywdL6DAlGGZRp6QOydgZZesOqZguYyN31TRIX9tNhibSNgxuh+A==
X-Received: by 2002:a05:6870:7029:b0:287:3cf8:4abe with SMTP id 586e51a60fabf-2948449c34dmr9477744fac.18.1730602485735;
        Sat, 02 Nov 2024 19:54:45 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:7d08:cd12:4b73:5f28])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29487716fefsm2133041fac.35.2024.11.02.19.54.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 Nov 2024 19:54:44 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] Documentation: extcon: add documentation for Extcon subsystem
Date: Sat,  2 Nov 2024 19:54:36 -0700
Message-Id: <20241103025436.69196-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Extcon (External Connector) subsystem driver lacked proper
documentation. This commit adds comprehensive documentation
explaining the purpose, key components, and usage of the Extcon
framework.

The new documentation includes:
- An overview of the Extcon subsystem
- Descriptions of key structures
- Explanations of core functions
- Information on the sysfs interface
- A usage example for driver developers

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/extcon.rst | 255 ++++++++++++++++++++++++++++
 Documentation/driver-api/index.rst  |   1 +
 MAINTAINERS                         |   1 +
 3 files changed, 257 insertions(+)
 create mode 100644 Documentation/driver-api/extcon.rst

diff --git a/Documentation/driver-api/extcon.rst b/Documentation/driver-api/extcon.rst
new file mode 100644
index 000000000000..d3217b9cdcd5
--- /dev/null
+++ b/Documentation/driver-api/extcon.rst
@@ -0,0 +1,255 @@
+=======================
+Extcon Device Subsystem
+=======================
+
+Overview
+========
+
+The Extcon (External Connector) subsystem provides a unified framework for
+managing external connectors in Linux systems. It allows drivers to report
+the state of external connectors and provides a standardized interface for
+userspace to query and monitor these states.
+
+Extcon is particularly useful in modern devices with multiple connectivity
+options, such as smartphones, tablets, and laptops. It helps manage various
+types of connectors, including:
+
+1. USB connectors (e.g., USB-C, micro-USB)
+2. Charging ports (e.g., fast charging, wireless charging)
+3. Audio jacks (e.g., 3.5mm headphone jack)
+4. Video outputs (e.g., HDMI, DisplayPort)
+5. Docking stations
+
+Real-world examples:
+
+1. Smartphone USB-C port:
+   A single USB-C port on a smartphone can serve multiple functions. Extcon
+   can manage the different states of this port, such as:
+   - USB data connection
+   - Charging (various types like fast charging, USB Power Delivery)
+   - Audio output (USB-C headphones)
+   - Video output (USB-C to HDMI adapter)
+
+2. Laptop docking station:
+   When a laptop is connected to a docking station, multiple connections are
+   made simultaneously. Extcon can handle the state changes for:
+   - Power delivery
+   - External displays
+   - USB hub connections
+   - Ethernet connectivity
+
+3. Wireless charging pad:
+   Extcon can manage the state of a wireless charging connection, allowing
+   the system to respond appropriately when a device is placed on or removed
+   from the charging pad.
+
+4. Smart TV HDMI ports:
+   In a smart TV, Extcon can manage multiple HDMI ports, detecting when
+   devices are connected or disconnected, and potentially identifying the
+   type of device (e.g., gaming console, set-top box, Blu-ray player).
+
+The Extcon framework simplifies the development of drivers for these complex
+scenarios by providing a standardized way to report and query connector
+states, handle mutually exclusive connections, and manage connector
+properties. This allows for more robust and flexible handling of external
+connections in modern devices.
+
+Key Components
+==============
+
+extcon_dev
+----------
+
+The core structure representing an Extcon device::
+
+    struct extcon_dev {
+        const char *name;
+        const unsigned int *supported_cable;
+        const u32 *mutually_exclusive;
+
+        /* Internal data */
+        struct device dev;
+        unsigned int id;
+        struct raw_notifier_head nh_all;
+        struct raw_notifier_head *nh;
+        struct list_head entry;
+        int max_supported;
+        spinlock_t lock;
+        u32 state;
+
+        /* Sysfs related */
+        struct device_type extcon_dev_type;
+        struct extcon_cable *cables;
+        struct attribute_group attr_g_muex;
+        struct attribute **attrs_muex;
+        struct device_attribute *d_attrs_muex;
+    };
+
+Key fields:
+
+- ``name``: Name of the Extcon device
+- ``supported_cable``: Array of supported cable types
+- ``mutually_exclusive``: Array defining mutually exclusive cable types
+  This field is crucial for enforcing hardware constraints. It's an array of
+  32-bit unsigned integers, where each element represents a set of mutually
+  exclusive cable types. The array should be terminated with a 0.
+
+  For example:
+
+  ::
+
+      static const u32 mutually_exclusive[] = {
+          BIT(0) | BIT(1),  /* Cable 0 and 1 are mutually exclusive */
+          BIT(2) | BIT(3) | BIT(4),  /* Cables 2, 3, and 4 are mutually exclusive */
+          0  /* Terminator */
+      };
+
+  In this example, cables 0 and 1 cannot be connected simultaneously, and
+  cables 2, 3, and 4 are also mutually exclusive. This is useful for
+  scenarios like a single port that can either be USB or HDMI, but not both
+  at the same time.
+
+  The Extcon core uses this information to prevent invalid combinations of
+  cable states, ensuring that the reported states are always consistent
+  with the hardware capabilities.
+
+- ``state``: Current state of the device (bitmap of connected cables)
+
+
+extcon_cable
+------------
+
+Represents an individual cable managed by an Extcon device::
+
+    struct extcon_cable {
+        struct extcon_dev *edev;
+        int cable_index;
+        struct attribute_group attr_g;
+        struct device_attribute attr_name;
+        struct device_attribute attr_state;
+        struct attribute *attrs[3];
+        union extcon_property_value usb_propval[EXTCON_PROP_USB_CNT];
+        union extcon_property_value chg_propval[EXTCON_PROP_CHG_CNT];
+        union extcon_property_value jack_propval[EXTCON_PROP_JACK_CNT];
+        union extcon_property_value disp_propval[EXTCON_PROP_DISP_CNT];
+        DECLARE_BITMAP(usb_bits, EXTCON_PROP_USB_CNT);
+        DECLARE_BITMAP(chg_bits, EXTCON_PROP_CHG_CNT);
+        DECLARE_BITMAP(jack_bits, EXTCON_PROP_JACK_CNT);
+        DECLARE_BITMAP(disp_bits, EXTCON_PROP_DISP_CNT);
+    };
+
+Core Functions
+==============
+
+.. kernel-doc:: drivers/extcon/extcon.c
+   :identifiers: extcon_get_state
+
+.. kernel-doc:: drivers/extcon/extcon.c
+   :identifiers: extcon_set_state
+
+.. kernel-doc:: drivers/extcon/extcon.c
+   :identifiers: extcon_set_state_sync
+
+.. kernel-doc:: drivers/extcon/extcon.c
+   :identifiers: extcon_get_property
+
+
+Sysfs Interface
+===============
+
+Extcon devices expose the following sysfs attributes:
+
+- ``name``: Name of the Extcon device
+- ``state``: Current state of all supported cables
+- ``cable.N/name``: Name of the Nth supported cable
+- ``cable.N/state``: State of the Nth supported cable
+
+Usage Example
+-------------
+
+.. code-block:: c
+
+    #include <linux/module.h>
+    #include <linux/platform_device.h>
+    #include <linux/extcon.h>
+
+    struct my_extcon_data {
+        struct extcon_dev *edev;
+        struct device *dev;
+    };
+
+    static const unsigned int my_extcon_cable[] = {
+        EXTCON_USB,
+        EXTCON_USB_HOST,
+        EXTCON_NONE,
+    };
+
+    static int my_extcon_probe(struct platform_device *pdev)
+    {
+        struct my_extcon_data *data;
+        int ret;
+
+        data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+        if (!data)
+            return -ENOMEM;
+
+        data->dev = &pdev->dev;
+
+        /* Initialize extcon device */
+        data->edev = devm_extcon_dev_allocate(data->dev, my_extcon_cable);
+        if (IS_ERR(data->edev)) {
+            dev_err(data->dev, "Failed to allocate extcon device\n");
+            return PTR_ERR(data->edev);
+        }
+
+        /* Register extcon device */
+        ret = devm_extcon_dev_register(data->dev, data->edev);
+        if (ret < 0) {
+            dev_err(data->dev, "Failed to register extcon device\n");
+            return ret;
+        }
+
+        platform_set_drvdata(pdev, data);
+
+        /* Example: Set initial state */
+        extcon_set_state_sync(data->edev, EXTCON_USB, true);
+
+        dev_info(data->dev, "My extcon driver probed successfully\n");
+        return 0;
+    }
+
+    static int my_extcon_remove(struct platform_device *pdev)
+    {
+        struct my_extcon_data *data = platform_get_drvdata(pdev);
+
+        /* Example: Clear state before removal */
+        extcon_set_state_sync(data->edev, EXTCON_USB, false);
+
+        dev_info(data->dev, "My extcon driver removed\n");
+        return 0;
+    }
+
+    static const struct of_device_id my_extcon_of_match[] = {
+        { .compatible = "my,extcon-device", },
+        { },
+    };
+    MODULE_DEVICE_TABLE(of, my_extcon_of_match);
+
+    static struct platform_driver my_extcon_driver = {
+        .driver = {
+            .name = "my-extcon-driver",
+            .of_match_table = my_extcon_of_match,
+        },
+        .probe = my_extcon_probe,
+        .remove = my_extcon_remove,
+    };
+
+    module_platform_driver(my_extcon_driver);
+
+This example demonstrates:
+---------------------------
+
+- Defining supported cable types (USB and USB Host in this case).
+- Allocating and registering an extcon device.
+- Setting an initial state for a cable (USB connected in this example).
+- Clearing the state when the driver is removed.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 7f83e05769b4..16e2c4ec3c01 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -86,6 +86,7 @@ Subsystem-specific APIs
    dmaengine/index
    dpll
    edac
+   extcon
    firmware/index
    fpga/index
    frame-buffer
diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..7a8739ed9d46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8572,6 +8572,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
 F:	Documentation/devicetree/bindings/extcon/
+F:	Documentation/driver-api/extcon.rst
 F:	Documentation/firmware-guide/acpi/extcon-intel-int3496.rst
 F:	drivers/extcon/
 F:	include/linux/extcon.h
-- 
2.39.3 (Apple Git-146)


