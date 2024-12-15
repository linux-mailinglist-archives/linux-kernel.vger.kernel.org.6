Return-Path: <linux-kernel+bounces-446439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A29F2457
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD4A188665F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8BB18FDD2;
	Sun, 15 Dec 2024 14:14:26 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4C189905;
	Sun, 15 Dec 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272064; cv=none; b=MmHtbXb4jOXkRRcW4RVXkmyqrXdWRNDTaLPnkh+1FBj3vS1vsXG9/RVSY4W2rb6LRMy0amvHdxpyV3m9f881VuUS/vU9US/IyE8xsz3YTleMwU8WBod9M/MU8K+i03sn5CsGBp/7ljAQUKHaufd5GL9xqWBJwXyBWF9gprrRkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272064; c=relaxed/simple;
	bh=SNVhIgdDt0L/QAg30/OS4jEa0/z5I64DwZg3VE+z9OY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5yYN/HaQ2c1nIXoeqjrcvzWfXIQSipbuJCq781dnKLjaw8goNBrVni7yeTHmS78sEPucQw85h84HruhBsFAml8hoc84LYjWdcUX35QF0GZjKh1Kk37NMh7lciuUEBryTIDQ+zaWj9tzzgpgoFbvvKc5eIvslpY0MAqiAKVYcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-540254357c8so2955775e87.1;
        Sun, 15 Dec 2024 06:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734272057; x=1734876857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iydob9KcWTaOa71XFzzkc5posDX8puK/V747Ff4+YWA=;
        b=knUoKlUHgNfGth5LFdnfjUM6g4eKn40LRPhX1prtytqPToUF1pZMg08M3XIPalwXYQ
         OhfbNdrDdAUnl/GTPTGcMtUuQP6zy/NJlJvHXCjzLK9XCivE9vUrJJ+U0N9MhH+xl3kH
         9OLnE6lxLWo+JEKMPL+mtK5zv1aMBA53ES7QS1Y7LK62wlomA8ZbdYS5tVLtDGGoF8d0
         PiS1SGH/JXkMKNeDQQAZEkbciHx+Jw5EDE9QtDLNyLJfZH2EX7uz5CRh+6BYVrrveyE0
         Fqa2ioCAarSvkclpCoZUWIF2CBH+Q+VMU5z074khEgO2b9MiQ/8tiGOFpNPZcIYKSGxx
         1Pkw==
X-Forwarded-Encrypted: i=1; AJvYcCU6kCapTfHReesDks9k/4UdXApIH9Vkv95mez057yN/p1o85nQ65vip+lvPFK70op4ge5KjqpcOHzQ2sYIq@vger.kernel.org, AJvYcCVlRbN42dYRbknmDEwHE0dh7FNF2IZ/ejYM9bRWIIih3kPvs1TcREza2ZAEE+heZFNkd9cXAQde301KmEXbuE2eEclvHA==@vger.kernel.org, AJvYcCX0t8nITjr8npG8s2YY8baNA0zoswiI9j2UVMEvBpJcSQ8rtf4eBsJHnE5frYg6cncsD+V0MdNzK7s=@vger.kernel.org, AJvYcCXzD9c6HaNDKipRDh/zFph3lSxsf/UYwpWbb+6DQNSFmMzQaSCQu3kBqyZa+R5phocAa6FMC9fgVJtYPYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcf0aR518SDAQUS0Es84RYt1Xm7BYQzKeRm3HmGdzfpbAnDNqB
	rjaBlRW9Ff0EDSDHuT2HjYHoosOYG4Iv8z9h1Q80MHCAlX6iKphd
X-Gm-Gg: ASbGncs5pRw+HxQqyGqmBEHG73uhj3SQPmvGqwAedJNVsDaVi7pIyTxSswkqwIh7gTx
	0VRkCbtRl/JsVYNdD0Ti4COXteRlXhy8dA7/WVES2KcTalmXrufGq9E1rEPywwBiICjLm3doIKu
	MQsK1MesC47hgyFxcScZxeEdI1XMCS9kjb35AZU4sgl8nGm5GLX8zNMF5MF7otIWQv0P+HPUUIK
	I/RO61WxdVLDG1EqcZVLkYKSHLrX8NTEzW25tQQdoaE9E5ekUcQe8Az2DZdGUVmO4yGVtX0vNF2
	Ydi5QUGVvI/yYJwy0G0pow==
X-Google-Smtp-Source: AGHT+IF8r2zaCVwCB0HaAtB50XQ5Aw8V+px6obMjLdt/+OT1wrtuOJy/FiEWQuCejTofL2ud1K21Bg==
X-Received: by 2002:a05:6512:12d1:b0:540:3530:5a63 with SMTP id 2adb3069b0e04-5408cdf4ec6mr2935225e87.5.1734272055891;
        Sun, 15 Dec 2024 06:14:15 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9bd9sm520408e87.62.2024.12.15.06.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 06:14:13 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: josh@joshuagrisham.com,
	W_Armin@gmx.de,
	corbet@lwn.net,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
Date: Sun, 15 Dec 2024 15:13:52 +0100
Message-ID: <20241215141352.58244-1-josh@joshuagrisham.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209163720.17597-1-josh@joshuagrisham.com>
References: <20241209163720.17597-1-josh@joshuagrisham.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Thank you all very much for the wealth of information provided in the
response to the first version of this patch. As there was quite a lot of
information to look into, I took a few days as I had the time and tried to
resolve everything that I could; the result is the attached updates to the
first patch.

I will aim to reply a bit more in detail to the thread and try to address
each review comment one-by-one, but within this v2 of the patch itself I
just wanted to mention some highlights of what has been changed with this
attached update:

1. Completely removed support for fan speed monitoring (including the
associated hwmon device) -- I agree, it does make a lot more sense if
support for fan devices with only _FST method is built in to the ACPI core
(as my guess is there are MANY devices in the wild like this). This
actually removes many of the review comments/issues as well which is a bit
of a win-win!

2. Took a step back to regroup regarding what the logging within the driver
should be like if it is "production ready". In pursuit of this, I did the
following:
  - Removed almost all of the existing print messages
  - Those which remained I have changed to use a relevant dev_* function
  (instead of pr_*) and have moved everything to either warn, error, or
  debug (for messages which myself as a likely initial maintainer of this
  driver would get a lot of help from), as seemed appropriate to me.
  - I removed the built-in hex printing of the ACPI buffers and as
  suggested by @Armin I have created a new tracepoint which can be enabled
  and will provide full debug of all buffers that are being sent and
  received from the ACPI device itself via this driver. Note: As the
  payloads for these devices can be quite large (up to 256 bytes), plus
  that different models behave slightly differently and have different
  features, I have found it very necessary to have the availabily for users
  to send this information to me, whether it is in the form of a tracepoint
  as I have added now, or otherwise.

3. Everywhere possible, I have tried to implement the devres version of
various registration functions, and when there was not a devres function
available then I have tried to make use of devm_add_action_or_reset() to
add a hook to handle the exits to try and achieve a similar result.

4. Tried to remove usage of the global pointer galaxybook_ptr, but with
mixed success.
  - Again, as the hwmon device has been removed, its usage of
  galaxybook_ptr was also removed!
  - From what I can see, I don't think there are actually any existing x86
  platform drivers that do NOT currently use a global pointer variable for
  the battery extension sysfs attributes (even the Dell driver is
  eventually using a static struct of "interface tokens" when you drill
  all the way down to the bottom) BUT I was able to take some inspiration
  from the Chrome OS battery driver and do think I have managed it quite
  well now in this driver by using a dev_ext_attribute where I have added a
  reference to the needed private data on the attribute itself.
  - For the i8042 filter, again I could not find any instance of any driver
  that seems to NOT be using a global pointer variable to execute any
  actions, and on top of that I was not really able to easily figure out a
  good way to rig up a struct member that would work using container_of. I
  tried several things including trying to use a double pointer to the
  function itself to then fetch the private data struct, but it did not
  really work super well and the logic felt very "heavy" for an IO filter
  in the end. I think a better design for this would be if i8042 filters
  could be installed with extended data so that we can actually provide a
  pointer and then just use it directly in the filter hook function itself.
  So, for now, I have left the galaxybook_ptr in, but it is only used in
  the i8042 filter.

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
---
 .../laptops/samsung-galaxybook.rst            |   65 +-
 MAINTAINERS                                   |    2 +
 drivers/platform/x86/Kconfig                  |    1 -
 .../platform/x86/samsung-galaxybook-trace.h   |   51 +
 drivers/platform/x86/samsung-galaxybook.c     | 1329 +++++------------
 5 files changed, 446 insertions(+), 1002 deletions(-)
 create mode 100644 drivers/platform/x86/samsung-galaxybook-trace.h

diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
index ab12f0001..c174cb255 100644
--- a/Documentation/admin-guide/laptops/samsung-galaxybook.rst
+++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
@@ -33,11 +33,10 @@ The following features are currently supported:
 - :ref:`Battery charge control end threshold
   <battery-charge-control-end-threshold>` (stop charging battery at given
   percentage value) implemented as a battery device extension
-- :ref:`Fan speed <fan-speed>` monitoring via ``fan_speed_rpm`` sysfs attribute
-  plus a new hwmon device
 - :ref:`Settings Attributes <settings-attributes>` to allow control of various
   device settings
 - :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various actions
+- :ref:`Tracepoint <tracepoint>` event for debugging ACPI device communication
 
 Because different models of these devices can vary in their features, there is
 logic built within the driver which attempts to test each implemented feature
@@ -62,7 +61,6 @@ enabling or disabling various features:
 - ``kbd_backlight``: Enable Keyboard Backlight control (default on)
 - ``performance_mode``: Enable Performance Mode control (default on)
 - ``battery_threshold``: Enable battery charge threshold control (default on)
-- ``fan_speed``: Enable fan speed (default on)
 - ``allow_recording``: Enable control to allow or block access to camera and
   microphone (default on)
 - ``i8042_filter``: Enable capture and execution of keyboard-based hotkey events
@@ -154,46 +152,6 @@ services as "on" or "off". Otherwise, the device will accept any value between 0
   will set the attribute value to 0 (i.e. 100% will "remove" the end threshold).
 
 
-.. _fan-speed:
-
-Fan speed
-=========
-
-Controlled by parameter: ``fan_speed``
-
-The number and type of fans on these devices can vary, and different methods
-must be used in order to be able to successfully read their status.
-
-In cases where Samsung has implemented the standard ACPI method ``_FST`` for a
-fan device, the other methods in the ACPI specification which would cause
-the kernel to automatically add the ``fan_speed_rpm`` attribute are not always
-present. On top of this, it seems that there are some bugs in the firmware that
-throw an exception when the ``_FST`` method is executed.
-
-This platform driver attempts to resolve all PNP fans that are present in the
-ACPI of supported devices, and add support for reading their speed using the
-following decision tree:
-
-1. Do all 4 required methods exist so that the fan speed should be reported
-   out-of-the-box by ACPI? If yes, then assume this fan is already set up and
-   available.
-
-2. Does the method ``_FST`` exist and appears to be working (returns a speed
-   value greater than 0)? If yes, add an attribute ``fan_speed_rpm`` to this fan
-   device and add a fan input channel for it to the hwmon device. The returned
-   value will be directly read from the ``_FST`` method.
-
-3. Does the field ``FANS`` (fan speed level) exist on the embedded controller,
-   and the table ``FANT`` (fan speed level table) exist on the fan device? If
-   yes, add the ``fan_speed_rpm`` attribute to this fan device and add a fan
-   input channel for it to the hwmon device. The returned value will be based
-   on a match of the current value of ``FANS`` compared to a list of level
-   speeds from the ``FANT`` table.
-
-The fan speed for all supported fans can be monitored using hwmon sensors or by
-reading the ``fan_speed_rpm`` sysfs attribute of each fan device.
-
-
 .. _settings-attributes:
 
 Settings Attributes
@@ -299,3 +257,24 @@ The Fn+F11 Performance mode hotkey is received as an ACPI notification. It will
 be handled in a similar way as the Fn+F9 and Fn+F10 hotkeys; namely, that the
 keypress will be swallowed by the driver and each press will cycle to the next
 available platform profile.
+
+
+.. _tracepoint:
+
+Tracepoint for debugging ACPI communication
+===========================================
+
+A new tracepoint event ``samsung_galaxybook:samsung_galaxybook_acpi`` will
+provide a trace of the buffers sent to, and received from, the ACPI device
+methods.
+
+Here is an example of how to use it: ::
+
+  # Enable tracepoint events
+  echo 1 | sudo tee /sys/kernel/tracing/events/samsung_galaxybook/enable
+
+  # Perform some actions using the driver and then read the result
+  sudo cat /sys/kernel/tracing/trace
+
+  # Disable tracepoint events when you are finished
+  echo 0 | sudo tee /sys/kernel/tracing/events/samsung_galaxybook/enable
diff --git a/MAINTAINERS b/MAINTAINERS
index 21b4fc504..9e3b45cf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20737,6 +20737,8 @@ SAMSUNG GALAXY BOOK EXTRAS DRIVER
 M:	Joshua Grisham <josh@joshuagrisham.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/admin-guide/laptops/samsung-galaxybook.rst
+F:	drivers/platform/x86/samsung-galaxybook-trace.h
 F:	drivers/platform/x86/samsung-galaxybook.c
 
 SAMSUNG INTERCONNECT DRIVERS
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b6d28b6a4..03f4fb0e9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -784,7 +784,6 @@ config SAMSUNG_GALAXYBOOK
 	depends on ACPI_BATTERY
 	depends on INPUT
 	depends on SERIO_I8042
-	depends on HWMON || HWMON = n
 	select ACPI_PLATFORM_PROFILE
 	select INPUT_SPARSEKMAP
 	select NEW_LEDS
diff --git a/drivers/platform/x86/samsung-galaxybook-trace.h b/drivers/platform/x86/samsung-galaxybook-trace.h
new file mode 100644
index 000000000..09ab6dbe6
--- /dev/null
+++ b/drivers/platform/x86/samsung-galaxybook-trace.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Samsung Galaxy Book series extras driver tracepoint events
+ *
+ * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
+ */
+
+#if !defined(_TRACE_SAMSUNG_GALAXYBOOK_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SAMSUNG_GALAXYBOOK_H_
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM samsung_galaxybook
+
+#define GALAXYBOOK_TRACE_MAX_ACPI_BUF_LENGTH 0x100
+
+TRACE_EVENT(samsung_galaxybook_acpi,
+	TP_PROTO(const char *devname, const char *method, const char *label, u8 *buf, size_t len),
+	TP_ARGS(devname, method, label, buf, len),
+	TP_STRUCT__entry(
+		__string(devname, devname)
+		__string(method, method)
+		__string(label, label)
+		__array(u8, buf, GALAXYBOOK_TRACE_MAX_ACPI_BUF_LENGTH)
+		__field(size_t, len)
+	),
+	TP_fast_assign(
+		__assign_str(devname);
+		__assign_str(method);
+		__assign_str(label);
+		memcpy(__entry->buf, buf, len);
+		__entry->len = len;
+	),
+	TP_printk("device: %s, method: %s, %s: %s",
+		  __get_str(devname),
+		  __get_str(method),
+		  __get_str(label),
+		  __print_hex(__entry->buf, __entry->len))
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH ../../drivers/platform/x86
+#define TRACE_INCLUDE_FILE samsung-galaxybook-trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
index ce8b76d91..4bbd33e83 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -11,11 +11,8 @@
  * Thank you to the authors!
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/acpi.h>
-#include <linux/dmi.h>
-#include <linux/hwmon.h>
+#include <linux/err.h>
 #include <linux/i8042.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -24,15 +21,19 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/nls.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/platform_profile.h>
 #include <linux/serio.h>
+#include <linux/sysfs.h>
+#include <linux/uuid.h>
 #include <linux/workqueue.h>
 #include <acpi/battery.h>
 
-#define SAMSUNG_GALAXYBOOK_CLASS  "samsung-galaxybook"
-#define SAMSUNG_GALAXYBOOK_NAME   "Samsung Galaxy Book Extras"
+#define CREATE_TRACE_POINTS
+#include "samsung-galaxybook-trace.h"
+
+#define DRIVER_NAME "samsung-galaxybook"
 
 /*
  * Module parameters
@@ -42,21 +43,18 @@ static bool kbd_backlight = true;
 static bool battery_threshold = true;
 static bool performance_mode = true;
 static bool allow_recording = true;
-static bool fan_speed = true;
 static bool i8042_filter = true;
 
-module_param(kbd_backlight, bool, 0644);
+module_param(kbd_backlight, bool, 0);
 MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (default on)");
-module_param(battery_threshold, bool, 0644);
+module_param(battery_threshold, bool, 0);
 MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold control (default on)");
-module_param(performance_mode, bool, 0644);
+module_param(performance_mode, bool, 0);
 MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (default on)");
-module_param(allow_recording, bool, 0644);
+module_param(allow_recording, bool, 0);
 MODULE_PARM_DESC(allow_recording,
 		 "Enable control to allow or block access to camera and microphone (default on)");
-module_param(fan_speed, bool, 0644);
-MODULE_PARM_DESC(fan_speed, "Enable fan speed (default on)");
-module_param(i8042_filter, bool, 0644);
+module_param(i8042_filter, bool, 0);
 MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey events (default on)");
 
 /*
@@ -72,49 +70,25 @@ static const struct acpi_device_id galaxybook_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
 
-static const struct dmi_system_id galaxybook_dmi_ids[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
-		},
-	},
-	{}
-};
-
-struct galaxybook_fan {
-	struct acpi_device fan;
-	char *description;
-	bool supports_fst;
-	unsigned int *fan_speeds;
-	int fan_speeds_count;
-	struct dev_ext_attribute fan_speed_rpm_ext_attr;
-};
-
-#define MAX_FAN_COUNT 5
-
 struct samsung_galaxybook {
 	struct platform_device *platform;
 	struct acpi_device *acpi;
+	struct mutex acpi_lock;
 
 	struct led_classdev kbd_backlight;
-	struct work_struct kbd_backlight_hotkey_work;
 
 	struct input_dev *input;
-	struct key_entry *keymap;
-
-	u8 *profile_performance_modes;
-	struct platform_profile_handler profile_handler;
-	struct work_struct performance_mode_hotkey_work;
+	struct mutex input_lock;
 
+	void *i8042_filter_ptr;
+	struct work_struct kbd_backlight_hotkey_work;
 	struct work_struct allow_recording_hotkey_work;
 
-	struct galaxybook_fan fans[MAX_FAN_COUNT];
-	int fans_count;
+	struct acpi_battery_hook battery_hook;
+	struct dev_ext_attribute battery_charge_control_attr;
 
-#if IS_ENABLED(CONFIG_HWMON)
-	struct device *hwmon;
-#endif
+	u8 *profile_performance_modes;
+	struct platform_profile_handler profile_handler;
 };
 static struct samsung_galaxybook *galaxybook_ptr;
 
@@ -217,10 +191,6 @@ static const guid_t performance_mode_guid_value =
 #define ACPI_METHOD_SETTINGS         "CSFI"
 #define ACPI_METHOD_PERFORMANCE_MODE "CSXI"
 
-#define ACPI_FAN_DEVICE_ID    "PNP0C0B"
-#define ACPI_FAN_SPEED_LIST   "FANT"
-#define ACPI_FAN_SPEED_VALUE  "\\_SB.PC00.LPCB.H_EC.FANS"
-
 #define KBD_BACKLIGHT_MAX_BRIGHTNESS  3
 
 #define ACPI_NOTIFY_BATTERY_STATE_CHANGED    0x61
@@ -245,126 +215,72 @@ static const struct key_entry galaxybook_acpi_keymap[] = {
  * ACPI method handling
  */
 
-#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)
-
-#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len)	\
-	do {								\
-		pr_debug_prefixed("%s\n", header_str);			\
-		print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",	\
-				     DUMP_PREFIX_NONE, 16, 1, buf_ptr,	\
-				     buf_len, false);			\
-	} while (0)
-
-static char *get_acpi_device_description(struct acpi_device *acpi_dev)
-{
-	struct acpi_buffer str_buf = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *str_obj;
-	struct acpi_buffer name_buf = { ACPI_ALLOCATE_BUFFER, NULL };
-	acpi_status status;
-	int result;
-
-	/* first try to get value of _STR (and also convert it to utf8)  */
-	if (!acpi_has_method(acpi_dev->handle, "_STR"))
-		goto use_name;
-	status = acpi_evaluate_object_typed(acpi_dev->handle, "_STR", NULL,
-					   &str_buf, ACPI_TYPE_BUFFER);
-	if (ACPI_SUCCESS(status) && str_buf.length > 0) {
-		str_obj = str_buf.pointer;
-		char *buf = kzalloc(sizeof(*buf) * str_obj->buffer.length, GFP_KERNEL);
-
-		result = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
-					 str_obj->buffer.length,
-					 UTF16_LITTLE_ENDIAN, buf,
-					 PAGE_SIZE - 1);
-		kfree(str_obj);
-		if (result > 0)
-			return buf;
-		/* if no result then free buf */
-		kfree(buf);
-	}
-
-	kfree(str_buf.pointer);
-
-use_name:
-	/* if _STR is missing then just use the device name */
-	status = acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &name_buf);
-	if (ACPI_SUCCESS(status) && name_buf.length > 0)
-		return name_buf.pointer;
-
-	kfree(name_buf.pointer);
-
-	return NULL;
-}
-
 static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook, acpi_string method,
-				  struct sawb *buf, u32 len, const char *purpose_str,
-				  struct sawb *ret)
+				  struct sawb *in_buf, size_t len, const char *purpose_str,
+				  struct sawb *out_buf)
 {
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object in_obj, *out_obj;
 	struct acpi_object_list input;
-	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 	acpi_status status;
+	int err;
+
+	mutex_lock(&galaxybook->acpi_lock);
 
 	in_obj.type = ACPI_TYPE_BUFFER;
 	in_obj.buffer.length = len;
-	in_obj.buffer.pointer = (u8 *)buf;
+	in_obj.buffer.pointer = (u8 *)in_buf;
 
 	input.count = 1;
 	input.pointer = &in_obj;
 
-	print_acpi_object_buffer_debug(purpose_str, in_obj.buffer.pointer, in_obj.buffer.length);
+	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method, purpose_str,
+				      in_obj.buffer.pointer, in_obj.buffer.length);
 
-	status = acpi_evaluate_object(galaxybook->acpi->handle, method, &input, &output);
+	status = acpi_evaluate_object_typed(galaxybook->acpi->handle, method, &input, &output,
+					    ACPI_TYPE_BUFFER);
 
 	if (ACPI_FAILURE(status)) {
-		pr_err("failed %s with ACPI method %s; got %s\n", purpose_str, method,
-		       acpi_format_exception(status));
-		return status;
+		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; got %s\n",
+			purpose_str, method, acpi_format_exception(status));
+		err = -ENXIO;
+		goto out_free;
 	}
 
 	out_obj = output.pointer;
 
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
-		pr_err("failed %s with ACPI method %s; response was not a buffer\n",
-			purpose_str, method);
-		status = -EIO;
-		goto out_free;
-	}
-
-	print_acpi_object_buffer_debug("response was: ", out_obj->buffer.pointer,
-				       out_obj->buffer.length);
+	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method, "response",
+				      out_obj->buffer.pointer, out_obj->buffer.length);
 
-	if (out_obj->buffer.length != len) {
-		pr_err("failed %s with ACPI method %s; response length mismatch\n",
+	if (out_obj->buffer.length != len || out_obj->buffer.length < SAWB_GUNM_POS + 1) {
+		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
+		       "response length mismatch\n",
 		       purpose_str, method);
-		status = -EIO;
-		goto out_free;
-	}
-	if (out_obj->buffer.length < SAWB_GUNM_POS + 1) {
-		pr_err("failed %s with ACPI method %s; response from device was too short\n",
-		       purpose_str, method);
-		status = -EIO;
+		err = -ETOOSMALL;
 		goto out_free;
 	}
 	if (out_obj->buffer.pointer[SAWB_RFLG_POS] != RFLG_SUCCESS) {
-		pr_err("failed %s with ACPI method %s; "
+		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
 		       "device did not respond with success code 0x%x\n",
 		       purpose_str, method, RFLG_SUCCESS);
-		status = -EIO;
+		err = -EIO;
 		goto out_free;
 	}
 	if (out_obj->buffer.pointer[SAWB_GUNM_POS] == GUNM_FAIL) {
-		pr_err("failed %s with ACPI method %s; device responded with failure code 0x%x\n",
+		dev_err(&galaxybook->acpi->dev,
+			"failed %s with ACPI method %s; device responded with failure code 0x%x\n",
 		       purpose_str, method, GUNM_FAIL);
-		status = -EIO;
+		err = -EIO;
 		goto out_free;
 	}
 
-	memcpy(ret, out_obj->buffer.pointer, len);
+	memcpy(out_buf, out_obj->buffer.pointer, len);
+	err = 0;
 
 out_free:
-	kfree(output.pointer);
-	return status;
+	kfree(out_obj);
+	mutex_unlock(&galaxybook->acpi_lock);
+	return err;
 }
 
 static int galaxybook_enable_acpi_feature(struct samsung_galaxybook *galaxybook, const u16 sasb)
@@ -411,8 +327,6 @@ static int kbd_backlight_acpi_set(struct samsung_galaxybook *galaxybook,
 
 	galaxybook->kbd_backlight.brightness = brightness;
 
-	pr_debug_prefixed("set kbd_backlight brightness to %d\n", brightness);
-
 	return 0;
 }
 
@@ -434,8 +348,6 @@ static int kbd_backlight_acpi_get(struct samsung_galaxybook *galaxybook,
 	*brightness = buf.gunm;
 	galaxybook->kbd_backlight.brightness = buf.gunm;
 
-	pr_debug_prefixed("current kbd_backlight brightness is %d\n", buf.gunm);
-
 	return 0;
 }
 
@@ -444,13 +356,8 @@ static int kbd_backlight_store(struct led_classdev *led,
 {
 	struct samsung_galaxybook *galaxybook =
 		container_of(led, struct samsung_galaxybook, kbd_backlight);
-	int err;
-
-	err = kbd_backlight_acpi_set(galaxybook, brightness);
-	if (err)
-		return err;
 
-	return 0;
+	return kbd_backlight_acpi_set(galaxybook, brightness);
 }
 
 static enum led_brightness kbd_backlight_show(struct led_classdev *led)
@@ -469,8 +376,8 @@ static enum led_brightness kbd_backlight_show(struct led_classdev *led)
 
 static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *galaxybook)
 {
-	enum led_brightness brightness;
 	struct led_init_data init_data = {};
+	enum led_brightness brightness;
 	int err;
 
 	err = galaxybook_enable_acpi_feature(galaxybook, SASB_KBD_BACKLIGHT);
@@ -482,27 +389,17 @@ static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *galaxybook)
 	if (err)
 		return err;
 
-	init_data.devicename = SAMSUNG_GALAXYBOOK_CLASS;
-	init_data.default_label = ":kbd_backlight";
+	init_data.devicename = DRIVER_NAME;
+	init_data.default_label = ":" LED_FUNCTION_KBD_BACKLIGHT;
 	init_data.devname_mandatory = true;
 
-	galaxybook->kbd_backlight = (struct led_classdev){
-		.brightness_get = kbd_backlight_show,
-		.brightness_set_blocking = kbd_backlight_store,
-		.flags = LED_BRIGHT_HW_CHANGED,
-		.max_brightness = KBD_BACKLIGHT_MAX_BRIGHTNESS,
-	};
-
-	pr_info("registering LED class using default name of %s:%s\n",
-		init_data.devicename, init_data.default_label);
-
-	return led_classdev_register_ext(&galaxybook->platform->dev, &galaxybook->kbd_backlight,
-					 &init_data);
-}
+	galaxybook->kbd_backlight.brightness_get = kbd_backlight_show;
+	galaxybook->kbd_backlight.brightness_set_blocking = kbd_backlight_store;
+	galaxybook->kbd_backlight.flags = LED_BRIGHT_HW_CHANGED;
+	galaxybook->kbd_backlight.max_brightness = KBD_BACKLIGHT_MAX_BRIGHTNESS;
 
-static void galaxybook_kbd_backlight_exit(struct samsung_galaxybook *galaxybook)
-{
-	led_classdev_unregister(&galaxybook->kbd_backlight);
+	return devm_led_classdev_register_ext(&galaxybook->platform->dev,
+					      &galaxybook->kbd_backlight, &init_data);
 }
 
 /*
@@ -514,23 +411,16 @@ static void galaxybook_kbd_backlight_exit(struct samsung_galaxybook *galaxybook)
 static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galaxybook, const bool value)
 {
 	struct sawb buf = { 0 };
-	int err;
 
 	buf.safn = SAFN;
 	buf.sasb = SASB_POWER_MANAGEMENT;
 	buf.gunm = GUNM_POWER_MANAGEMENT;
 	buf.guds[0] = GUDS_START_ON_LID_OPEN;
 	buf.guds[1] = GUDS_START_ON_LID_OPEN_SET;
-	buf.guds[2] = value;
+	buf.guds[2] = value ? 1 : 0;
 
-	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
-				     "setting start_on_lid_open", &buf);
-	if (err)
-		return err;
-
-	pr_debug_prefixed("turned start_on_lid_open %s\n", value ? "on (1)" : "off (0)");
-
-	return 0;
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting start_on_lid_open", &buf);
 }
 
 static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galaxybook, bool *value)
@@ -551,9 +441,6 @@ static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galaxybook, boo
 
 	*value = buf.guds[1];
 
-	pr_debug_prefixed("start_on_lid_open is currently %s\n",
-			  (buf.guds[1] ? "on (1)" : "off (0)"));
-
 	return 0;
 }
 
@@ -564,9 +451,13 @@ static ssize_t start_on_lid_open_store(struct device *dev, struct device_attribu
 	bool value;
 	int err;
 
-	if (!count || kstrtobool(buffer, &value))
+	if (!count)
 		return -EINVAL;
 
+	err = kstrtobool(buffer, &value);
+	if (err)
+		return err;
+
 	err = start_on_lid_open_acpi_set(galaxybook, value);
 	if (err)
 		return err;
@@ -595,20 +486,13 @@ static DEVICE_ATTR_RW(start_on_lid_open);
 static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, const bool value)
 {
 	struct sawb buf = { 0 };
-	int err;
 
 	buf.safn = SAFN;
 	buf.sasb = SASB_USB_CHARGE_SET;
 	buf.gunm = value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
 
-	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
-				     "setting usb_charge", &buf);
-	if (err)
-		return err;
-
-	pr_debug_prefixed("turned usb_charge %s\n", value ? "on (1)" : "off (0)");
-
-	return 0;
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting usb_charge", &buf);
 }
 
 static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, bool *value)
@@ -627,8 +511,6 @@ static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, bool *valu
 
 	*value = buf.gunm;
 
-	pr_debug_prefixed("usb_charge is currently %s\n", (buf.gunm ? "on (1)" : "off (0)"));
-
 	return 0;
 }
 
@@ -639,9 +521,13 @@ static ssize_t usb_charge_store(struct device *dev, struct device_attribute *att
 	bool value;
 	int err;
 
-	if (!count || kstrtobool(buffer, &value))
+	if (!count)
 		return -EINVAL;
 
+	err = kstrtobool(buffer, &value);
+	if (err)
+		return err;
+
 	err = usb_charge_acpi_set(galaxybook, value);
 	if (err)
 		return err;
@@ -669,21 +555,14 @@ static DEVICE_ATTR_RW(usb_charge);
 static int allow_recording_acpi_set(struct samsung_galaxybook *galaxybook, const bool value)
 {
 	struct sawb buf = { 0 };
-	int err;
 
 	buf.safn = SAFN;
 	buf.sasb = SASB_ALLOW_RECORDING;
 	buf.gunm = GUNM_SET;
-	buf.guds[0] = value;
-
-	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
-				     "setting allow_recording", &buf);
-	if (err)
-		return err;
-
-	pr_debug_prefixed("turned allow_recording %s\n", value ? "on (1)" : "off (0)");
+	buf.guds[0] = value ? 1 : 0;
 
-	return 0;
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting allow_recording", &buf);
 }
 
 static int allow_recording_acpi_get(struct samsung_galaxybook *galaxybook, bool *value)
@@ -700,9 +579,7 @@ static int allow_recording_acpi_get(struct samsung_galaxybook *galaxybook, bool
 	if (err)
 		return err;
 
-	*value = buf.gunm;
-
-	pr_debug_prefixed("allow_recording is currently %s\n", (buf.gunm ? "on (1)" : "off (0)"));
+	*value = buf.gunm == 1;
 
 	return 0;
 }
@@ -714,9 +591,13 @@ static ssize_t allow_recording_store(struct device *dev, struct device_attribute
 	bool value;
 	int err;
 
-	if (!count || kstrtobool(buffer, &value))
+	if (!count)
 		return -EINVAL;
 
+	err = kstrtobool(buffer, &value);
+	if (err)
+		return err;
+
 	err = allow_recording_acpi_set(galaxybook, value);
 	if (err)
 		return err;
@@ -739,36 +620,78 @@ static ssize_t allow_recording_show(struct device *dev, struct device_attribute
 
 static DEVICE_ATTR_RW(allow_recording);
 
+static umode_t galaxybook_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	if (attr == &dev_attr_start_on_lid_open.attr) {
+		err = start_on_lid_open_acpi_get(galaxybook, &value);
+		return err ? 0 : attr->mode;
+	}
+
+	if (attr == &dev_attr_usb_charge.attr) {
+		err = usb_charge_acpi_get(galaxybook, &value);
+		return err ? 0 : attr->mode;
+	}
+
+	if (attr == &dev_attr_allow_recording.attr) {
+		if (!allow_recording)
+			return 0;
+		err = galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDING);
+		if (err) {
+			dev_dbg(&galaxybook->platform->dev,
+				"failed to initialize ACPI allow_recording feature\n");
+			allow_recording = false;
+			return 0;
+		}
+		err = allow_recording_acpi_get(galaxybook, &value);
+		if (err) {
+			allow_recording = false;
+			return 0;
+		}
+		return attr->mode;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute *galaxybook_attrs[] = {
+	&dev_attr_start_on_lid_open.attr,
+	&dev_attr_usb_charge.attr,
+	&dev_attr_allow_recording.attr,
+};
+
+static const struct attribute_group galaxybook_attrs_group = {
+	.attrs = galaxybook_attrs,
+	.is_visible = galaxybook_attr_is_visible,
+};
+
 /*
  * Battery Extension (adds charge_control_end_threshold to the battery device)
  */
 
-static int charge_control_end_threshold_acpi_set(struct samsung_galaxybook *galaxybook,
-						 const u8 value)
+static int charge_control_end_threshold_acpi_set(struct samsung_galaxybook *galaxybook, u8 value)
 {
 	struct sawb buf = { 0 };
-	int err;
 
 	if (value > 100)
 		return -EINVAL;
+	/* if setting to 100, should be set to 0 (no threshold) */
+	if (value == 100)
+		value = 0;
 
 	buf.safn = SAFN;
 	buf.sasb = SASB_POWER_MANAGEMENT;
 	buf.gunm = GUNM_POWER_MANAGEMENT;
 	buf.guds[0] = GUDS_BATTERY_CHARGE_CONTROL;
 	buf.guds[1] = GUDS_BATTERY_CHARGE_CONTROL_SET;
+	buf.guds[2] = value;
 
-	buf.guds[2] = (value == 100 ? 0 : value); /* if setting to 100, should be set to 0 (off) */
-
-	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
-				     "setting battery charge_control_end_threshold", &buf);
-	if (err)
-		return err;
-
-	pr_debug_prefixed("set battery charge_control_end_threshold to %d\n",
-			  (value == 100 ? 0 : value));
-
-	return 0;
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting battery charge_control_end_threshold", &buf);
 }
 
 static int charge_control_end_threshold_acpi_get(struct samsung_galaxybook *galaxybook, u8 *value)
@@ -789,23 +712,28 @@ static int charge_control_end_threshold_acpi_get(struct samsung_galaxybook *gala
 
 	*value = buf.guds[1];
 
-	pr_debug_prefixed("battery charge control is currently %s; "
-			  "battery charge_control_end_threshold is %d\n",
-			  (buf.guds[1] > 0 ? "on" : "off"), buf.guds[1]);
-
 	return 0;
 }
 
 static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
 						  const char *buffer, size_t count)
 {
+	struct dev_ext_attribute *ea = container_of(attr, struct dev_ext_attribute, attr);
+	struct samsung_galaxybook *galaxybook = ea->var;
 	u8 value;
 	int err;
 
-	if (!count || kstrtou8(buffer, 0, &value))
+	if (!galaxybook)
+		return -ENODEV;
+
+	if (!count)
 		return -EINVAL;
 
-	err = charge_control_end_threshold_acpi_set(galaxybook_ptr, value);
+	err = kstrtou8(buffer, 0, &value);
+	if (err)
+		return err;
+
+	err = charge_control_end_threshold_acpi_set(galaxybook, value);
 	if (err)
 		return err;
 
@@ -815,39 +743,42 @@ static ssize_t charge_control_end_threshold_store(struct device *dev, struct dev
 static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
 						 char *buffer)
 {
+	struct dev_ext_attribute *ea = container_of(attr, struct dev_ext_attribute, attr);
+	struct samsung_galaxybook *galaxybook = ea->var;
 	u8 value;
 	int err;
 
-	err = charge_control_end_threshold_acpi_get(galaxybook_ptr, &value);
+	if (!galaxybook)
+		return -ENODEV;
+
+	err = charge_control_end_threshold_acpi_get(galaxybook, &value);
 	if (err)
 		return err;
 
 	return sysfs_emit(buffer, "%d\n", value);
 }
 
-static DEVICE_ATTR_RW(charge_control_end_threshold);
-
 static int galaxybook_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
-	if (device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold))
-		return -ENODEV;
-	return 0;
+	struct samsung_galaxybook *galaxybook =
+		container_of(hook, struct samsung_galaxybook, battery_hook);
+
+	return device_create_file(&battery->dev, &galaxybook->battery_charge_control_attr.attr);
 }
 
 static int galaxybook_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
-	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+	struct samsung_galaxybook *galaxybook =
+		container_of(hook, struct samsung_galaxybook, battery_hook);
+
+	device_remove_file(&battery->dev, &galaxybook->battery_charge_control_attr.attr);
 	return 0;
 }
 
-static struct acpi_battery_hook galaxybook_battery_hook = {
-	.add_battery = galaxybook_battery_add,
-	.remove_battery = galaxybook_battery_remove,
-	.name = "Samsung Galaxy Book Battery Extension",
-};
-
 static int galaxybook_battery_threshold_init(struct samsung_galaxybook *galaxybook)
 {
+	struct acpi_battery_hook *hook;
+	struct device_attribute *attr;
 	u8 value;
 	int err;
 
@@ -855,397 +786,22 @@ static int galaxybook_battery_threshold_init(struct samsung_galaxybook *galaxybo
 	if (err)
 		return err;
 
-	battery_hook_register(&galaxybook_battery_hook);
-	return 0;
-}
-
-static void galaxybook_battery_threshold_exit(struct samsung_galaxybook *galaxybook)
-{
-	battery_hook_unregister(&galaxybook_battery_hook);
-}
-
-/*
- * Fan speed
- */
-
-static int fan_speed_get_fst(struct galaxybook_fan *fan, unsigned int *speed)
-{
-	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *response_obj = NULL;
-	acpi_status status;
-	int ret = 0;
-
-	status = acpi_evaluate_object(fan->fan.handle, "_FST", NULL, &response);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Get fan state failed\n");
-		return -ENODEV;
-	}
-
-	response_obj = response.pointer;
-	if (!response_obj || response_obj->type != ACPI_TYPE_PACKAGE ||
-	    response_obj->package.count != 3 ||
-	    response_obj->package.elements[2].type != ACPI_TYPE_INTEGER) {
-		pr_err("Invalid _FST data\n");
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	*speed = response_obj->package.elements[2].integer.value;
-
-	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d\n",
-			  dev_name(&fan->fan.dev), fan->description, *speed);
-
-out_free:
-	ACPI_FREE(response.pointer);
-	return ret;
-}
-
-static int fan_speed_get_fans(struct galaxybook_fan *fan, unsigned int *speed)
-{
-	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *response_obj = NULL;
-	acpi_status status;
-	int ret = 0;
-	int speed_level = -1;
-
-	status = acpi_evaluate_object(NULL, ACPI_FAN_SPEED_VALUE, NULL, &response);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Get fan state failed\n");
-		return -ENODEV;
-	}
-
-	response_obj = response.pointer;
-	if (!response_obj || response_obj->type != ACPI_TYPE_INTEGER ||
-	    response_obj->integer.value > INT_MAX ||
-	    (int)response_obj->integer.value > fan->fan_speeds_count) {
-		pr_err("invalid fan speed data\n");
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	speed_level = (int)response_obj->integer.value;
-	*speed = fan->fan_speeds[speed_level];
-
-	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d (level %d)\n",
-			  dev_name(&fan->fan.dev), fan->description, *speed, speed_level);
-
-out_free:
-	ACPI_FREE(response.pointer);
-	return ret;
-}
-
-static int fan_speed_get(struct galaxybook_fan *fan, unsigned int *speed)
-{
-	if (!fan)
-		return -ENODEV;
-	if (fan->supports_fst)
-		return fan_speed_get_fst(fan, speed);
-	else
-		return fan_speed_get_fans(fan, speed);
-}
-
-static ssize_t fan_speed_rpm_show(struct device *dev, struct device_attribute *attr, char *buffer)
-{
-	struct dev_ext_attribute *ea = container_of(attr, struct dev_ext_attribute, attr);
-	struct galaxybook_fan *fan = ea->var;
-	unsigned int speed;
-	int ret = 0;
-
-	if (!fan)
-		return -ENODEV;
-
-	ret = fan_speed_get(fan, &speed);
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buffer, "%u\n", speed);
-}
-
-static int __init fan_speed_list_init(acpi_handle handle, struct galaxybook_fan *fan)
-{
-	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *response_obj = NULL;
-	acpi_status status;
-	unsigned int speed;
-	int i;
-
-	status = acpi_evaluate_object(handle, ACPI_FAN_SPEED_LIST, NULL, &response);
-	if (ACPI_FAILURE(status)) {
-		pr_err("failed to read fan speed list\n");
-		return -ENODEV;
-	}
-
-	response_obj = response.pointer;
-	if (!response_obj || response_obj->type != ACPI_TYPE_PACKAGE ||
-	    response_obj->package.count == 0) {
-		pr_err("invalid fan speed list data\n");
-		status = -EINVAL;
-		goto out_free;
-	}
-
-	/*
-	 * fan_speeds[] starts with a hard-coded 0 (fan is off), then has some "funny" logic:
-	 *  - fetch the speed level values read in from FANT and add 0x0a to each value
-	 *  - _FST method in the DSDT seems to indicate that level 3 and 4 should have same value,
-	 *    however real-life observation suggests that the speed actually does change
-	 *  - _FST says that level 5 should give the 4th value from FANT but it seems significantly
-	 *    louder -- we will just "guess" it is 1000 RPM faster than the highest value from FANT?
-	 */
-
-	fan->fan_speeds = kzalloc(sizeof(unsigned int) * (response_obj->package.count + 2),
-				  GFP_KERNEL);
-	if (!fan->fan_speeds)
-		return -ENOMEM;
-
-	/* hard-coded "off" value (0) */
-	fan->fan_speeds[0] = 0;
-	fan->fan_speeds_count = 1;
-
-	/* fetch and assign the next values from FANT response */
-	i = 0;
-	for (i = 1; i <= response_obj->package.count; i++) {
-		if (response_obj->package.elements[i - 1].type != ACPI_TYPE_INTEGER) {
-			pr_err("invalid fan speed list value at position %d; "
-			       "expected type %d, got type %d\n",
-			       i - 1, ACPI_TYPE_INTEGER,
-			       response_obj->package.elements[i - 1].type);
-			status = -EINVAL;
-			goto err_fan_speeds_free;
-		}
-		fan->fan_speeds[i] = response_obj->package.elements[i - 1].integer.value + 0x0a;
-		fan->fan_speeds_count++;
-	}
-
-	/* add the missing final level where we "guess" 1000 RPM faster than highest from FANT */
-	if (fan->fan_speeds_count > 1) {
-		fan->fan_speeds[i] = fan->fan_speeds[i - 1] + 1000;
-		fan->fan_speeds_count++;
-	}
-
-	/* test that it actually works to read the speed, otherwise the init should fail */
-	status = fan_speed_get_fans(fan, &speed);
-	if (ACPI_FAILURE(status)) {
-		pr_err("failed to read fan speed level from FANS\n");
-		goto err_fan_speeds_free;
-	}
-
-	pr_info("initialized fan speed reporting for device %s (%s) with the following levels:\n",
-		dev_name(&fan->fan.dev), fan->description);
-	for (i = 0; i < fan->fan_speeds_count; i++)
-		pr_info("  %s (%s) fan speed level %d = %d\n",
-			dev_name(&fan->fan.dev), fan->description, i, fan->fan_speeds[i]);
+	hook = &galaxybook->battery_hook;
+	hook->add_battery = galaxybook_battery_add;
+	hook->remove_battery = galaxybook_battery_remove;
+	hook->name = "Samsung Galaxy Book Battery Extension";
 
-out_free:
-	ACPI_FREE(response.pointer);
-	return status;
+	attr = &galaxybook->battery_charge_control_attr.attr;
+	attr->attr.name = "charge_control_end_threshold";
+	attr->attr.mode = 0644;
+	attr->show = charge_control_end_threshold_show;
+	attr->store = charge_control_end_threshold_store;
+	/* ext attr var points to this galaxybook so it can used in show and store */
+	galaxybook->battery_charge_control_attr.var = galaxybook;
 
-err_fan_speeds_free:
-	kfree(fan->fan_speeds);
-	goto out_free;
+	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxybook->battery_hook);
 }
 
-static acpi_status galaxybook_add_fan(acpi_handle handle, u32 level, void *context,
-				      void **return_value)
-{
-	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
-	struct samsung_galaxybook *galaxybook = context;
-	struct galaxybook_fan *fan;
-	int speed = -1;
-
-	pr_info("found fan device %s\n", dev_name(&adev->dev));
-
-	/* if fan meets acpi4 fan device requirements, assume it is added already under ACPI */
-	if (acpi_has_method(handle, "_FIF") &&
-	    acpi_has_method(handle, "_FPS") &&
-	    acpi_has_method(handle, "_FSL") &&
-	    acpi_has_method(handle, "_FST")) {
-		pr_info("fan device %s should already be available as an ACPI fan; skipping\n",
-			dev_name(&adev->dev));
-		return 0;
-	}
-
-	if (galaxybook->fans_count >= MAX_FAN_COUNT) {
-		pr_err("maximum number of %d fans has already been reached\n", MAX_FAN_COUNT);
-		return 0;
-	}
-
-	fan = &galaxybook->fans[galaxybook->fans_count];
-	fan->fan = *adev;
-	fan->description = get_acpi_device_description(&fan->fan);
-
-	/* try to get speed from _FST */
-	if (ACPI_FAILURE(fan_speed_get_fst(fan, &speed))) {
-		pr_debug_prefixed("_FST is present but failed on fan device %s (%s); "
-				  "will attempt to add fan speed support using FANT and FANS\n",
-				  dev_name(&fan->fan.dev), fan->description);
-		fan->supports_fst = false;
-	}
-	/* if speed was 0 and FANT and FANS exist, they should be used anyway due to bugs in ACPI */
-	else if (speed <= 0 &&
-		 acpi_has_method(handle, ACPI_FAN_SPEED_LIST) &&
-		 acpi_has_method(NULL, ACPI_FAN_SPEED_VALUE)) {
-		pr_debug_prefixed("_FST is present on fan device %s (%s) but returned value of 0; "
-				  "will attempt to add fan speed support using FANT and FANS\n",
-				  dev_name(&fan->fan.dev), fan->description);
-		fan->supports_fst = false;
-	} else {
-		fan->supports_fst = true;
-	}
-
-	if (!fan->supports_fst) {
-		/* since FANS is a field on the EC, it does not make sense to use more than once */
-		for (int i = 0; i < galaxybook->fans_count; i++) {
-			if (!galaxybook->fans[i].supports_fst) {
-				pr_err("more than one fan using FANS is not supported\n");
-				return 0;
-			}
-		}
-		if (ACPI_FAILURE(fan_speed_list_init(handle, fan))) {
-			pr_err("unable to initialize fan speeds for fan device %s (%s)\n",
-			       dev_name(&fan->fan.dev), fan->description);
-			return 0;
-		}
-	} else {
-		pr_info("initialized fan speed reporting for device %s (%s) using method _FST\n",
-			dev_name(&fan->fan.dev), fan->description);
-	}
-
-	/* set up RO dev_ext_attribute */
-	fan->fan_speed_rpm_ext_attr.attr.attr.name = "fan_speed_rpm";
-	fan->fan_speed_rpm_ext_attr.attr.attr.mode = 0444;
-	fan->fan_speed_rpm_ext_attr.attr.show = fan_speed_rpm_show;
-	/* extended attribute var points to this galaxybook_fan so it can used in the show method */
-	fan->fan_speed_rpm_ext_attr.var = fan;
-
-	if (sysfs_create_file(&adev->dev.kobj, &fan->fan_speed_rpm_ext_attr.attr.attr))
-		pr_err("unable to create fan_speed_rpm attribute for fan device %s (%s)\n",
-		       dev_name(&fan->fan.dev), fan->description);
-
-	galaxybook->fans_count++;
-
-	return 0;
-}
-
-static int __init galaxybook_fan_speed_init(struct samsung_galaxybook *galaxybook)
-{
-	acpi_status status;
-
-	/* get and set up all fans matching ACPI_FAN_DEVICE_ID */
-	status = acpi_get_devices(ACPI_FAN_DEVICE_ID, galaxybook_add_fan, galaxybook, NULL);
-
-	if (galaxybook->fans_count == 0)
-		return -ENODEV;
-
-	return status;
-}
-
-static void galaxybook_fan_speed_exit(struct samsung_galaxybook *galaxybook)
-{
-	for (int i = 0; i < galaxybook->fans_count; i++)
-		sysfs_remove_file(&galaxybook->fans[i].fan.dev.kobj,
-				  &galaxybook->fans[i].fan_speed_rpm_ext_attr.attr.attr);
-}
-
-/*
- * Hwmon device
- */
-
-#if IS_ENABLED(CONFIG_HWMON)
-static umode_t galaxybook_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
-					   u32 attr, int channel)
-{
-	switch (type) {
-	case hwmon_fan:
-		if (channel < galaxybook_ptr->fans_count &&
-		    (attr == hwmon_fan_input || attr == hwmon_fan_label))
-			return 0444;
-		return 0;
-	default:
-		return 0;
-	}
-}
-
-static int galaxybook_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
-				 u32 attr, int channel, long *val)
-{
-	unsigned int speed;
-
-	switch (type) {
-	case hwmon_fan:
-		if (channel < galaxybook_ptr->fans_count && attr == hwmon_fan_input) {
-			if (fan_speed_get(&galaxybook_ptr->fans[channel], &speed))
-				return -EIO;
-			*val = speed;
-			return 0;
-		}
-		return -EOPNOTSUPP;
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static int galaxybook_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
-					u32 attr, int channel, const char **str)
-{
-	switch (type) {
-	case hwmon_fan:
-		if (channel < galaxybook_ptr->fans_count && attr == hwmon_fan_label) {
-			*str = galaxybook_ptr->fans[channel].description;
-			return 0;
-		}
-		return -EOPNOTSUPP;
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static const struct hwmon_ops galaxybook_hwmon_ops = {
-	.is_visible = galaxybook_hwmon_is_visible,
-	.read = galaxybook_hwmon_read,
-	.read_string = galaxybook_hwmon_read_string,
-};
-
-static const struct hwmon_channel_info *const galaxybook_hwmon_info[] = {
-	/* note: number of max possible fan channel entries here should match MAX_FAN_COUNT */
-	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL),
-	NULL
-};
-
-static const struct hwmon_chip_info galaxybook_hwmon_chip_info = {
-	.ops = &galaxybook_hwmon_ops,
-	.info = galaxybook_hwmon_info,
-};
-
-static int galaxybook_hwmon_init(struct samsung_galaxybook *galaxybook)
-{
-	int ret = 0;
-
-	char *hwmon_device_name = devm_hwmon_sanitize_name(&galaxybook->platform->dev,
-							   SAMSUNG_GALAXYBOOK_CLASS);
-
-	galaxybook->hwmon = devm_hwmon_device_register_with_info(
-		&galaxybook->platform->dev, hwmon_device_name, NULL,
-		&galaxybook_hwmon_chip_info, NULL);
-	if (PTR_ERR_OR_ZERO(galaxybook->hwmon)) {
-		ret = PTR_ERR(galaxybook->hwmon);
-		galaxybook->hwmon = NULL;
-	}
-
-	return ret;
-}
-
-static void galaxybook_hwmon_exit(struct samsung_galaxybook *galaxybook)
-{
-	if (galaxybook->hwmon)
-		hwmon_device_unregister(galaxybook->hwmon);
-}
-#endif
-
 /*
  * Platform Profile / Performance mode
  */
@@ -1254,7 +810,6 @@ static int performance_mode_acpi_set(struct samsung_galaxybook *galaxybook,
 				     const u8 performance_mode)
 {
 	struct sawb buf = { 0 };
-	int err;
 
 	buf.safn = SAFN;
 	buf.sasb = SASB_PERFORMANCE_MODE;
@@ -1263,12 +818,8 @@ static int performance_mode_acpi_set(struct samsung_galaxybook *galaxybook,
 	buf.subn = SUBN_PERFORMANCE_MODE_SET;
 	buf.iob0 = performance_mode;
 
-	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE, &buf,
-				     SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
-	if (err)
-		return err;
-
-	return 0;
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE, &buf,
+				      SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
 }
 
 static int performance_mode_acpi_get(struct samsung_galaxybook *galaxybook, u8 *performance_mode)
@@ -1292,40 +843,29 @@ static int performance_mode_acpi_get(struct samsung_galaxybook *galaxybook, u8 *
 	return 0;
 }
 
-static enum platform_profile_option
-profile_performance_mode(struct samsung_galaxybook *galaxybook, const u8 performance_mode)
+static int get_performance_mode_profile(struct samsung_galaxybook *galaxybook,
+					const u8 performance_mode,
+					enum platform_profile_option *profile)
 {
-	for (int i = 0; i < PLATFORM_PROFILE_LAST; i++)
-		if (galaxybook->profile_performance_modes[i] == performance_mode)
-			return i;
-	return -1;
-}
+	for (int i = 0; i < PLATFORM_PROFILE_LAST; i++) {
+		if (galaxybook->profile_performance_modes[i] == performance_mode) {
+			if (profile)
+				*profile = i;
+			return 0;
+		}
+	}
 
-/* copied from platform_profile.c; better if this could be fetched from a public function, maybe? */
-static const char *const profile_names[] = {
-	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
-	[PLATFORM_PROFILE_COOL] = "cool",
-	[PLATFORM_PROFILE_QUIET] = "quiet",
-	[PLATFORM_PROFILE_BALANCED] = "balanced",
-	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
-	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
-};
-static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
+	return -ENODATA;
+}
 
 static int galaxybook_platform_profile_set(struct platform_profile_handler *pprof,
 					   enum platform_profile_option profile)
 {
 	struct samsung_galaxybook *galaxybook =
 		container_of(pprof, struct samsung_galaxybook, profile_handler);
-	int err;
-
-	err = performance_mode_acpi_set(galaxybook, galaxybook->profile_performance_modes[profile]);
-	if (err)
-		return err;
 
-	pr_debug_prefixed("set platform profile to '%s' (performance mode 0x%x)\n",
-			  profile_names[profile], galaxybook->profile_performance_modes[profile]);
-	return 0;
+	return performance_mode_acpi_set(galaxybook,
+					 galaxybook->profile_performance_modes[profile]);
 }
 
 static int galaxybook_platform_profile_get(struct platform_profile_handler *pprof,
@@ -1340,23 +880,24 @@ static int galaxybook_platform_profile_get(struct platform_profile_handler *ppro
 	if (err)
 		return err;
 
-	*profile = profile_performance_mode(galaxybook, performance_mode);
-	if (*profile == -1)
-		return -EINVAL;
-
-	pr_debug_prefixed("platform profile is currently '%s' (performance mode 0x%x)\n",
-			  profile_names[*profile], performance_mode);
+	return get_performance_mode_profile(galaxybook, performance_mode, profile);
+}
 
-	return 0;
+static void galaxybook_profile_exit(void *data)
+{
+	platform_profile_remove();
 }
 
 #define IGNORE_PERFORMANCE_MODE_MAPPING  -1
 
 static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
 {
-	struct sawb buf = { 0 };
-	int mode_profile, err;
 	u8 current_performance_mode;
+	struct sawb buf = { 0 };
+	int mapped_profiles;
+	int mode_profile;
+	int err;
+	int i;
 
 	galaxybook->profile_handler.profile_get = galaxybook_platform_profile_get;
 	galaxybook->profile_handler.profile_set = galaxybook_platform_profile_set;
@@ -1376,10 +917,10 @@ static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
 
 	/* set up profile_performance_modes with "unknown" as init value */
 	galaxybook->profile_performance_modes =
-		kzalloc(sizeof(u8) * PLATFORM_PROFILE_LAST, GFP_KERNEL);
+		kcalloc(PLATFORM_PROFILE_LAST, sizeof(u8), GFP_KERNEL);
 	if (!galaxybook->profile_performance_modes)
 		return -ENOMEM;
-	for (int i = 0; i < PLATFORM_PROFILE_LAST; i++)
+	for (i = 0; i < PLATFORM_PROFILE_LAST; i++)
 		galaxybook->profile_performance_modes[i] = PERFORMANCE_MODE_UNKNOWN;
 
 	/*
@@ -1388,8 +929,7 @@ static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
 	 * Loop backwards from last value to first value (to handle fallback cases which come with
 	 * smaller values) and map each supported value to its correct platform_profile_option.
 	 */
-	err = -ENODEV; /* set err to "no device" to signal that we have not yet mapped profiles */
-	for (int i = buf.iob0; i > 0; i--) {
+	for (i = buf.iob0; i > 0; i--) {
 		/*
 		 * Prefer mapping to at least performance, balanced, and low-power profiles, as they
 		 * are the profiles which are typically supported by userspace tools
@@ -1459,21 +999,22 @@ static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
 		}
 
 		/* if current mode value mapped to a supported platform_profile_option, set it up */
-		if (mode_profile > IGNORE_PERFORMANCE_MODE_MAPPING) {
-			err = 0; /* clear err to signal that at least one profile is now mapped */
+		if (mode_profile != IGNORE_PERFORMANCE_MODE_MAPPING) {
+			mapped_profiles++;
 			galaxybook->profile_performance_modes[mode_profile] = buf.iob_values[i];
 			set_bit(mode_profile, galaxybook->profile_handler.choices);
-			pr_info("will support platform profile '%s' (performance mode 0x%x)\n",
-				profile_names[mode_profile], buf.iob_values[i]);
+			dev_dbg(&galaxybook->platform->dev,
+				"will support platform profile %d (performance mode 0x%x)\n",
+				mode_profile, buf.iob_values[i]);
 		} else {
-			pr_debug_prefixed("unmapped performance mode 0x%x will be ignored\n",
-					  buf.iob_values[i]);
+			dev_dbg(&galaxybook->platform->dev,
+				"unmapped performance mode 0x%x will be ignored\n",
+				buf.iob_values[i]);
 		}
 	}
 
-	/* if no performance modes were mapped (err is still -ENODEV) then stop and fail here */
-	if (err)
-		return err;
+	if (mapped_profiles == 0)
+		return -ENODEV;
 
 	err = platform_profile_register(&galaxybook->profile_handler);
 	if (err)
@@ -1482,33 +1023,35 @@ static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
 	/* now check currently set performance mode; if not supported then set default profile */
 	err = performance_mode_acpi_get(galaxybook, &current_performance_mode);
 	if (err)
-		pr_warn("failed with code %d when fetching initial performance mode\n", err);
-	if (profile_performance_mode(galaxybook, current_performance_mode) == -1) {
-		pr_debug_prefixed("initial performance mode value is not supported by device; "
-				  "setting to default\n");
+		goto err_remove_exit;
+	err = get_performance_mode_profile(galaxybook, current_performance_mode, NULL);
+	if (err) {
+		dev_dbg(&galaxybook->platform->dev,
+			"initial performance mode value is not supported by device; "
+			"setting to default\n");
 		err = galaxybook_platform_profile_set(&galaxybook->profile_handler,
 						      DEFAULT_PLATFORM_PROFILE);
 		if (err)
-			return err;
+			goto err_remove_exit;
 	}
 
+	/* if adding dev remove action fails, remove now and return failure */
+	err = devm_add_action_or_reset(&galaxybook->platform->dev,
+				       galaxybook_profile_exit, NULL);
+	if (err)
+		goto err_remove_exit;
+
 	return 0;
-}
 
-static void galaxybook_profile_exit(struct samsung_galaxybook *galaxybook)
-{
-	platform_profile_remove();
+err_remove_exit:
+	galaxybook_profile_exit(NULL);
+	return err;
 }
 
 /*
  * Hotkey work and filters
  */
 
-static void galaxybook_performance_mode_hotkey_work(struct work_struct *work)
-{
-	platform_profile_cycle();
-}
-
 static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *work)
 {
 	struct samsung_galaxybook *galaxybook =
@@ -1575,118 +1118,77 @@ static bool galaxybook_i8042_filter(unsigned char data, unsigned char str, struc
 	return false;
 }
 
-/*
- * Input device (hotkeys and notifications)
- */
-
-static void galaxybook_input_notify(struct samsung_galaxybook *galaxybook, int event)
+static void galaxybook_i8042_filter_remove(void *data)
 {
-	if (!galaxybook->input)
-		return;
-	pr_debug_prefixed("input notification event: 0x%x\n", event);
-	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
-		pr_warn("unknown input notification event: 0x%x\n", event);
+	struct samsung_galaxybook *galaxybook = data;
+
+	i8042_remove_filter(galaxybook_i8042_filter);
+	cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
+	cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
 }
 
-static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
+static int galaxybook_i8042_filter_install(struct samsung_galaxybook *galaxybook)
 {
-	struct input_dev *input;
-	int error;
-
-	input = input_allocate_device();
-	if (!input)
-		return -ENOMEM;
+	int err;
 
-	input->name = "Samsung Galaxy Book Extra Buttons";
-	input->phys = SAMSUNG_GALAXYBOOK_CLASS "/input0";
-	input->id.bustype = BUS_HOST;
-	input->dev.parent = &galaxybook->platform->dev;
+	/* initialize hotkey work queues */
+	if (kbd_backlight)
+		INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
+			  galaxybook_kbd_backlight_hotkey_work);
+	if (allow_recording)
+		INIT_WORK(&galaxybook->allow_recording_hotkey_work,
+			  galaxybook_allow_recording_hotkey_work);
 
-	error = sparse_keymap_setup(input, galaxybook_acpi_keymap, NULL);
-	if (error) {
-		pr_err("Unable to setup input device keymap\n");
-		goto err_free_dev;
+	err = i8042_install_filter(galaxybook_i8042_filter);
+	if (err) {
+		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
+		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
+		return err;
 	}
-	error = input_register_device(input);
-	if (error) {
-		pr_err("Unable to register input device\n");
-		goto err_free_dev;
+
+	/* if adding dev remove action fails, remove now and return failure */
+	err = devm_add_action_or_reset(&galaxybook->platform->dev,
+				       galaxybook_i8042_filter_remove, galaxybook);
+	if (err) {
+		galaxybook_i8042_filter_remove(galaxybook);
+		return err;
 	}
 
-	galaxybook->input = input;
 	return 0;
-
-err_free_dev:
-	input_free_device(input);
-	return error;
-}
-
-static void galaxybook_input_exit(struct samsung_galaxybook *galaxybook)
-{
-	if (galaxybook->input)
-		input_unregister_device(galaxybook->input);
-	galaxybook->input = NULL;
 }
 
 /*
- * Platform device attributes
+ * Input device (hotkeys and notifications)
  */
 
-/* galaxybook_attrs can include start_on_lid_open, usb_charge, and/or allow_recording */
-#define MAX_NUM_DEVICE_ATTRIBUTES 3
-
-static struct attribute *galaxybook_attrs[MAX_NUM_DEVICE_ATTRIBUTES + 1] = { NULL };
-static const struct attribute_group galaxybook_attrs_group = {
-	.attrs = galaxybook_attrs,
-};
+static void galaxybook_input_notify(struct samsung_galaxybook *galaxybook, int event)
+{
+	if (!galaxybook->input)
+		return;
+	mutex_lock(&galaxybook->input_lock);
+	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
+		dev_warn(&galaxybook->acpi->dev, "unknown input notification event: 0x%x\n", event);
+	mutex_unlock(&galaxybook->input_lock);
+}
 
-static int galaxybook_device_attrs_init(struct samsung_galaxybook *galaxybook)
+static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
 {
-	bool value;
 	int err;
-	int i = 0;
 
-	/* attempt to get each attribute's value and add them if the get does not fail */
+	galaxybook->input = devm_input_allocate_device(&galaxybook->platform->dev);
+	if (!galaxybook->input)
+		return -ENOMEM;
 
-	err = start_on_lid_open_acpi_get(galaxybook, &value);
-	if (err)
-		pr_debug_prefixed("failed to get start_on_lid_open value; "
-				  "this feature will not be enabled\n");
-	else
-		galaxybook_attrs[i++] = &dev_attr_start_on_lid_open.attr;
+	galaxybook->input->name = "Samsung Galaxy Book Extra Buttons";
+	galaxybook->input->phys = DRIVER_NAME "/input0";
+	galaxybook->input->id.bustype = BUS_HOST;
+	galaxybook->input->dev.parent = &galaxybook->platform->dev;
 
-	err = usb_charge_acpi_get(galaxybook, &value);
+	err = sparse_keymap_setup(galaxybook->input, galaxybook_acpi_keymap, NULL);
 	if (err)
-		pr_debug_prefixed("failed to get usb_charge value; "
-				  "this feature will not be enabled\n");
-	else
-		galaxybook_attrs[i++] = &dev_attr_usb_charge.attr;
-
-	if (allow_recording) {
-		pr_debug_prefixed("initializing ACPI allow_recording feature\n");
-		err = galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDING);
-		if (err) {
-			pr_debug_prefixed("failed to initialize ACPI allow_recording feature\n");
-			allow_recording = false;
-			return 0;
-		}
-
-		err = allow_recording_acpi_get(galaxybook, &value);
-		if (err) {
-			pr_debug_prefixed("failed to get allow_recording value; "
-					  "this feature will not be enabled\n");
-			allow_recording = false;
-		} else {
-			galaxybook_attrs[i++] = &dev_attr_allow_recording.attr;
-		}
-	}
-
-	return device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
-};
+		return err;
 
-static void galaxybook_device_attrs_exit(struct samsung_galaxybook *galaxybook)
-{
-	device_remove_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
+	return input_register_device(galaxybook->input);
 }
 
 /*
@@ -1698,14 +1200,17 @@ static void galaxybook_acpi_notify(acpi_handle handle, u32 event, void *data)
 	struct samsung_galaxybook *galaxybook = data;
 
 	if (event == ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
-		pr_debug_prefixed("hotkey: performance_mode keydown\n");
 		if (performance_mode) {
-			schedule_work(&galaxybook->performance_mode_hotkey_work);
-			return;
+			platform_profile_cycle();
+			goto exit;
 		}
 	}
 
 	galaxybook_input_notify(galaxybook, event);
+
+exit:
+	acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(&galaxybook->platform->dev),
+					event, 0);
 }
 
 static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *galaxybook)
@@ -1726,247 +1231,155 @@ static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *galaxybook)
 				      "activate ACPI notifications", &buf);
 }
 
-static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
+static void galaxybook_acpi_remove_notify_handler(void *data)
 {
-	return acpi_execute_simple_method(galaxybook->acpi->handle,
-					  ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_ON);
+	struct samsung_galaxybook *galaxybook = data;
+
+	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
+				   galaxybook_acpi_notify);
 }
 
-static void galaxybook_acpi_exit(struct samsung_galaxybook *galaxybook)
+static void galaxybook_acpi_disable(void *data)
 {
+	struct samsung_galaxybook *galaxybook = data;
+
 	acpi_execute_simple_method(galaxybook->acpi->handle,
 				   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
 }
 
+static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
+{
+	acpi_status status;
+	int err;
+
+	status = acpi_execute_simple_method(galaxybook->acpi->handle, ACPI_METHOD_ENABLE,
+					    ACPI_METHOD_ENABLE_ON);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+	err = devm_add_action_or_reset(&galaxybook->platform->dev,
+				       galaxybook_acpi_disable, galaxybook);
+	if (err)
+		return err;
+
+	status = acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
+					     galaxybook_acpi_notify, galaxybook);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+	err = devm_add_action_or_reset(&galaxybook->platform->dev,
+				       galaxybook_acpi_remove_notify_handler, galaxybook);
+	if (err)
+		return err;
+
+	err = galaxybook_enable_acpi_notify(galaxybook);
+	if (err) {
+		dev_warn(&galaxybook->platform->dev, "failed to enable ACPI notifications; "
+			 "some hotkeys will not be supported\n");
+	} else {
+		err = galaxybook_input_init(galaxybook);
+		if (err)
+			dev_warn(&galaxybook->platform->dev,
+				 "failed to initialize input device\n");
+	}
+
+	return 0;
+}
+
 /*
  * Platform driver
  */
 
+#define galaxybook_init_feature(module_param, init_func)			\
+do {										\
+	if (module_param) {							\
+		err = init_func(galaxybook);					\
+		if (err) {							\
+			dev_dbg(&galaxybook->platform->dev,			\
+				"failed to initialize " #module_param "\n");	\
+			module_param = false;					\
+		}								\
+	}									\
+} while (0)
+
 static int galaxybook_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct samsung_galaxybook *galaxybook;
-	acpi_status status;
 	int err;
 
-	dmi_check_system(galaxybook_dmi_ids);
+	if (!adev)
+		return -ENODEV;
 
-	pr_info("found matched device %s; loading driver\n", dev_name(&adev->dev));
+	dev_dbg(&pdev->dev, "loading driver\n");
 
-	galaxybook = kzalloc(sizeof(struct samsung_galaxybook), GFP_KERNEL);
+	galaxybook = devm_kzalloc(&pdev->dev, sizeof(*galaxybook), GFP_KERNEL);
 	if (!galaxybook)
 		return -ENOMEM;
-	/* set static pointer here so it can be used in various methods for hotkeys, hwmon, etc */
+	/* set static pointer here so it can be used in i8042 filter */
 	galaxybook_ptr = galaxybook;
 
 	galaxybook->platform = pdev;
 	galaxybook->acpi = adev;
 
 	dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
+	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->acpi_lock);
+	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->input_lock);
 
-	pr_debug_prefixed("initializing ACPI device\n");
 	err = galaxybook_acpi_init(galaxybook);
 	if (err) {
-		pr_err("failed to initialize the ACPI device\n");
-		goto err_free;
+		dev_err(&galaxybook->acpi->dev, "failed to initialize the ACPI device\n");
+		return err;
 	}
 
-	pr_debug_prefixed("initializing ACPI power management features\n");
 	err = galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEMENT);
 	if (err) {
-		pr_warn("failed to initialize ACPI power management features; "
-			"many features of this driver will not be available\n");
+		dev_warn(&galaxybook->acpi->dev,
+			 "failed to initialize ACPI power management features; "
+			 "many features of this driver will not be available\n");
 		performance_mode = false;
 		battery_threshold = false;
 	}
 
-	if (performance_mode) {
-		pr_debug_prefixed("initializing performance mode and platform profile\n");
-		err = galaxybook_profile_init(galaxybook);
-		if (err) {
-			pr_debug_prefixed(
-				"failed to initialize performance mode and platform profile\n");
-			performance_mode = false;
-		}
-	} else {
-		pr_debug_prefixed("performance_mode is disabled\n");
-	}
-
-	if (battery_threshold) {
-		pr_debug_prefixed("initializing battery charge threshold control\n");
-		err = galaxybook_battery_threshold_init(galaxybook);
-		if (err) {
-			pr_debug_prefixed(
-				"failed to initialize battery charge threshold control\n");
-			battery_threshold = false;
-		}
-	} else {
-		pr_debug_prefixed("battery_threshold is disabled\n");
-	}
+	galaxybook_init_feature(performance_mode, galaxybook_profile_init);
+	galaxybook_init_feature(battery_threshold, galaxybook_battery_threshold_init);
 
-	pr_debug_prefixed("adding platform device attributes\n");
-	err = galaxybook_device_attrs_init(galaxybook);
+	/* add attrs group here as the is_visible requires above initializations */
+	err = devm_device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
 	if (err)
-		pr_err("failed to add platform device attributes\n");
+		dev_warn(&galaxybook->platform->dev, "failed to add platform device attributes\n");
 
-	if (kbd_backlight) {
-		pr_debug_prefixed("initializing kbd_backlight\n");
-		err = galaxybook_kbd_backlight_init(galaxybook);
-		if (err) {
-			pr_debug_prefixed("failed to initialize kbd_backlight\n");
-			kbd_backlight = false;
-		}
-	} else {
-		pr_debug_prefixed("kbd_backlight is disabled\n");
-	}
-
-	if (fan_speed) {
-		pr_debug_prefixed("initializing fan speed\n");
-		err = galaxybook_fan_speed_init(galaxybook);
-		if (err) {
-			pr_debug_prefixed("failed to initialize fan speed\n");
-			fan_speed = false;
-		} else {
-#if IS_ENABLED(CONFIG_HWMON)
-			pr_debug_prefixed("initializing hwmon device\n");
-			err = galaxybook_hwmon_init(galaxybook);
-			if (err)
-				pr_warn("failed to initialize hwmon device\n");
-#endif
-		}
-	} else {
-		pr_debug_prefixed("fan_speed is disabled\n");
-	}
+	galaxybook_init_feature(kbd_backlight, galaxybook_kbd_backlight_init);
 
 	/* i8042_filter should be disabled if kbd_backlight and allow_recording are disabled */
 	if (!kbd_backlight && !allow_recording)
 		i8042_filter = false;
 
-	if (i8042_filter) {
-		pr_debug_prefixed("installing i8402 key filter to capture hotkey input\n");
+	galaxybook_init_feature(i8042_filter, galaxybook_i8042_filter_install);
 
-		/* initialize hotkey work queues */
-		if (kbd_backlight)
-			INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
-				  galaxybook_kbd_backlight_hotkey_work);
-		if (allow_recording)
-			INIT_WORK(&galaxybook->allow_recording_hotkey_work,
-				  galaxybook_allow_recording_hotkey_work);
-
-		err = i8042_install_filter(galaxybook_i8042_filter);
-		if (err) {
-			pr_err("failed to install i8402 key filter\n");
-			cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
-			cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
-			i8042_filter = false;
-		}
-	} else {
-		pr_debug_prefixed("i8042_filter is disabled\n");
-	}
-
-	pr_debug_prefixed("installing ACPI notify handler\n");
-	status = acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
-					     galaxybook_acpi_notify, galaxybook);
-	if (ACPI_SUCCESS(status)) {
-		pr_debug_prefixed("enabling ACPI notifications\n");
-		err = galaxybook_enable_acpi_notify(galaxybook);
-		if (err) {
-			pr_warn("failed to enable ACPI notifications; "
-				"some hotkeys will not be supported\n");
-		} else {
-			/* initialize ACPI hotkey work queues */
-			INIT_WORK(&galaxybook->performance_mode_hotkey_work,
-				  galaxybook_performance_mode_hotkey_work);
-
-			pr_debug_prefixed("initializing input device\n");
-			err = galaxybook_input_init(galaxybook);
-			if (err) {
-				pr_err("failed to initialize input device\n");
-				cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
-				galaxybook_input_exit(galaxybook);
-			}
-		}
-	} else {
-		pr_debug_prefixed("failed to install ACPI notify handler\n");
-	}
-
-	pr_info("driver successfully loaded\n");
+	dev_dbg(&galaxybook->platform->dev, "driver successfully loaded\n");
 
 	return 0;
-
-err_free:
-	kfree(galaxybook);
-	return err;
 }
 
 static void galaxybook_remove(struct platform_device *pdev)
 {
 	struct samsung_galaxybook *galaxybook = dev_get_drvdata(&pdev->dev);
 
-	pr_info("removing driver\n");
-
-	galaxybook_device_attrs_exit(galaxybook);
-
-	galaxybook_input_exit(galaxybook);
-	cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
-
-	if (i8042_filter) {
-		i8042_remove_filter(galaxybook_i8042_filter);
-		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
-		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
-	}
-
-	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
-				   galaxybook_acpi_notify);
-
-	if (fan_speed) {
-		galaxybook_fan_speed_exit(galaxybook);
-#if IS_ENABLED(CONFIG_HWMON)
-		galaxybook_hwmon_exit(galaxybook);
-#endif
-	}
-
-	if (kbd_backlight)
-		galaxybook_kbd_backlight_exit(galaxybook);
-
-	if (battery_threshold)
-		galaxybook_battery_threshold_exit(galaxybook);
-
-	if (performance_mode)
-		galaxybook_profile_exit(galaxybook);
-
-	galaxybook_acpi_exit(galaxybook);
-
 	if (galaxybook_ptr)
 		galaxybook_ptr = NULL;
 
-	kfree(galaxybook);
-
-	pr_info("driver successfully removed\n");
+	dev_dbg(&galaxybook->platform->dev, "driver removed\n");
 }
 
 static struct platform_driver galaxybook_platform_driver = {
 	.driver = {
-		.name = SAMSUNG_GALAXYBOOK_CLASS,
+		.name = DRIVER_NAME,
 		.acpi_match_table = galaxybook_device_ids,
 	},
 	.probe = galaxybook_probe,
 	.remove = galaxybook_remove,
 };
-
-static int __init samsung_galaxybook_init(void)
-{
-	return platform_driver_register(&galaxybook_platform_driver);
-}
-
-static void __exit samsung_galaxybook_exit(void)
-{
-	platform_driver_unregister(&galaxybook_platform_driver);
-}
-
-module_init(samsung_galaxybook_init);
-module_exit(samsung_galaxybook_exit);
+module_platform_driver(galaxybook_platform_driver);
 
 MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
-MODULE_DESCRIPTION(SAMSUNG_GALAXYBOOK_NAME);
+MODULE_DESCRIPTION("Samsung Galaxy Book Extras");
 MODULE_LICENSE("GPL");
-- 
2.45.2


