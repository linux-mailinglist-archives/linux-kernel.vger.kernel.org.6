Return-Path: <linux-kernel+bounces-447166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9AC9F2E47
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71FE166171
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046AF203D4A;
	Mon, 16 Dec 2024 10:39:27 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D551C07D1;
	Mon, 16 Dec 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345565; cv=none; b=WkZ6IXIkko+WtWu2agyMKqdOJvqvy7nRsgYcriQNXjVqLyjwI48Avgq6+Q+3A4+bx1lsUxqAVG+eoXntQzMUg36xMCTulEPysNg8h5Fnhh3IYDi94lIiFzD8vO+dlNpipXP8rwY80oD6mfg1yAMUh3LhaXzorMSCjYmEDDIh7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345565; c=relaxed/simple;
	bh=TzJGMYnJO/3kUKXbeB9bIG6qXDL8q6xfqX9J2Ru7cOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K7WhKfdjt3AOXISTFs+oMX5QUmTLEDE79FXYYV9+3Ugv+yN76L8XCyblfWAQiUkgsf6jkV24Qsg+J1/JsGDzGYNHGK4EtVF04DigyFUVuqlbSMGtT4pTTum9F3EM+ioFzAyNTMwJGYMIpaF+fezYiphX2oXxOAz0Lm9Lu8gC2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e399e3310so4743559e87.1;
        Mon, 16 Dec 2024 02:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734345559; x=1734950359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wc6DcbYvQereSEHOElX9Do+9/+PYx1M+DfX0v9S5Qmc=;
        b=s5g0S+UrsFCI3T9jMdJUyikXDbYDE5t6JZXxROfUnaXFd1aMn6rXxPqdrwPpzNLJh6
         xnN10T6439ahOFGuXqKChRXtbsqIjyAIdJxYkPeD9P2iTiSswrRcMhUdtoZqs+shkLvO
         5q88MCW9hLJVA8fRlZ6BhaaL7b0ooFxOlSntZaW8JFCscMMxeCEVzQqZF/79XLGt9EHK
         XxJlAPFukmF9kYaEp9Gs4FEB2M39MK5PfsQrhAkurmYbvhVmnKbiyD0rMFenH1Icjs1j
         8FwBsimKGitNiPw0bWQnYXUaBAx13SxyVPrpPV+1fI4u1gWkWHd5DeT+H8+JjxJX9fHT
         qRWw==
X-Forwarded-Encrypted: i=1; AJvYcCVfv2RaMyZOnXIwV9W7uYYn2EW5wF5hKgUgVdRRp1c+bWRpbdqOrGkOwlRJqKPhzrD2Bobw3hitCagfbQPq@vger.kernel.org, AJvYcCWDXRCsTBQveoL0XLa4h5QdA5XnTECv6+ri0umXz1DWdMH8oMl+OfG8JroROS+1oOXpqAY94kctC9o=@vger.kernel.org, AJvYcCWvENiYYUciIvmaAuDeE4aJSD3x3pjXJQOVGZtmuWu/GabGEbQfP+yOuaV1aA+lW51jKIEezBN2H0lm9TaK/vGHBux+Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTiCipr86xhgt/ksVZ0UUWtfc38XMShGiTPie1TgBcvoMHJUk
	uR7+4fEVDIL59zE0QVGPPtW1JMAYfulWOkCQKR+58kv29xXrHHIu
X-Gm-Gg: ASbGncvHoYlfCnoP3VEt18e9Moj8GwMVMZfrfniJPWRMgeRFLM6c5p2phEnqnFAv9kd
	FKZAjIDp0/OAj0YSmcrF3mT2J7urEr7+jTzcsNuN1D33Tw2qau9TusvyW318OU7JylUah7KkkHD
	vFxN6td3XuALo/TFFY0aqJzFbOub9RgRlm14b8TAzwbICIDF+LXms9/jKf5U5Fi2qkIrMZeXsZn
	ikCt2PRlnVO29yCSAa6epjx3rWzMRzyqvnCE3fCku1kavMOr1iskQ23d+pCRj+ziBC4lGccnWUA
	sWLdQM4B7P+NzESMao/bjA==
X-Google-Smtp-Source: AGHT+IE9r3/Y5tfjPyfbeiTkq+iJn0OCRHiz03HuB/oeYYKyti/kdTpyUiRWa4LjBp0a0ePDdWo6VA==
X-Received: by 2002:a05:6512:3b90:b0:53f:8c46:42a7 with SMTP id 2adb3069b0e04-54090561558mr3181003e87.26.1734345558340;
        Mon, 16 Dec 2024 02:39:18 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13ca2sm801117e87.212.2024.12.16.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:39:16 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	W_Armin@gmx.de,
	platform-driver-x86@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH v3] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
Date: Mon, 16 Dec 2024 11:38:54 +0100
Message-ID: <20241216103855.18457-1-josh@joshuagrisham.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds a new driver for Samsung Galaxy Book series notebook devices. This
includes the driver itself, a tracepoint header file, a new page in the
documentation, and relevant updates to Kconfig, Makefile, and MAINTAINERS
files related to this new driver.

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
---
v1->v2:
 - Attempt to resolve all review comments from v1 as written here:
https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-463912dd966d@gmx.de/T/#mbcbd8d5d9bc4496bac5486636c7d3b32bc3e5cd0

v2->v3:
 - Tweak to battery attribute to closer match pattern in dell-wmi-ddv
 - implement platform_profile_remove() change from
   9b3bb37b44a317626464e79da8b39989b421963f
 - Small tweak to Documentation page
---
 .../laptops/samsung-galaxybook.rst            |  280 ++++
 MAINTAINERS                                   |    8 +
 drivers/platform/x86/Kconfig                  |   18 +
 drivers/platform/x86/Makefile                 |    5 +-
 .../platform/x86/samsung-galaxybook-trace.h   |   51 +
 drivers/platform/x86/samsung-galaxybook.c     | 1380 +++++++++++++++++
 6 files changed, 1740 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/laptops/samsung-galaxybook.rst
 create mode 100644 drivers/platform/x86/samsung-galaxybook-trace.h
 create mode 100644 drivers/platform/x86/samsung-galaxybook.c

diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
new file mode 100644
index 000000000000..947810c5f998
--- /dev/null
+++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
@@ -0,0 +1,280 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Samsung Galaxy Book Extras
+==========================
+
+December 15, 2024
+
+Joshua Grisham <josh@joshuagrisham.com>
+
+This is a Linux x86 platform driver for Samsung Galaxy Book series notebook
+devices which utilizes Samsung's ``SCAI`` ACPI device in order to control
+extra features and receive various notifications.
+
+
+Supported devices
+=================
+
+Any device with one of the supported ACPI device IDs should be supported. This
+covers most of the "Samsung Galaxy Book" series notebooks that are currently
+available as of this writing, and could include other Samsung notebook devices
+as well.
+
+
+Status
+======
+
+The following features are currently supported:
+
+- :ref:`Keyboard backlight <keyboard-backlight>` control
+- :ref:`Performance mode <performance-mode>` control implemented using the
+  platform profile interface
+- :ref:`Battery charge control end threshold
+  <battery-charge-control-end-threshold>` (stop charging battery at given
+  percentage value) implemented as a battery device extension
+- :ref:`Settings Attributes <settings-attributes>` to allow control of various
+  device settings
+- :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various actions
+- :ref:`Tracepoint <tracepoint>` event for debugging ACPI device communication
+
+Because different models of these devices can vary in their features, there is
+logic built within the driver which attempts to test each implemented feature
+for a valid response before enabling its support (registering additional devices
+or extensions, adding sysfs attributes, etc). Therefore, it can be important to
+note that not all features may be supported for your particular device.
+
+The following features might be possible to implement but will require
+additional investigation and are therefore not supported at this time:
+
+- "Dolby Atmos" mode for the speakers
+- "Outdoor Mode" for increasing screen brightness on models with ``SAM0427``
+- "Silent Mode" on models with ``SAM0427``
+
+
+Parameters
+==========
+
+The driver includes a list of boolean parameters that allow for manually
+enabling or disabling various features:
+
+- ``kbd_backlight``: Enable Keyboard Backlight control (default on)
+- ``performance_mode``: Enable Performance Mode control (default on)
+- ``battery_threshold``: Enable battery charge threshold control (default on)
+- ``allow_recording``: Enable control to allow or block access to camera and
+  microphone (default on)
+- ``i8042_filter``: Enable capture and execution of keyboard-based hotkey events
+  (default on)
+
+.. note::
+  Even if you explicitly try to enable a feature using its parameter, support
+  for it will still be evaluated by the driver, and the feature will be
+  disabled if it does not appear to be supported on your device.
+
+The availability of various sysfs file-based "settings" attributes
+(``usb_charge``, ``start_on_lid_open``, etc) will be determined automatically
+and cannot be manually disabled at this time.
+
+
+.. _keyboard-backlight:
+
+Keyboard backlight
+==================
+
+Controlled by parameter: ``kbd_backlight``
+
+A new LED class named ``samsung-galaxybook::kbd_backlight`` is created which
+will then expose the device using the standard sysfs-based LED interface at
+``/sys/class/leds/samsung-galaxybook::kbd_backlight``. Brightness can be
+controlled by writing values 0 to 3 to the ``brightness`` sysfs attribute or
+with any other desired userspace utility.
+
+.. note::
+  Most of these devices have an ambient light sensor which also turns
+  off the keyboard backlight under well-lit conditions. This behavior does not
+  seem possible to control at this time, but can be good to be aware of.
+
+
+.. _performance-mode:
+
+Performance mode
+================
+
+Controlled by parameter: ``performance_mode``
+
+This driver implements the
+Documentation/userspace-api/sysfs-platform_profile.rst interface for working
+with the "performance mode" function of the Samsung ACPI device.
+
+Mapping of each Samsung "performance mode" to its respective platform profile is
+done dynamically based on a list of the supported modes reported by the device
+itself. Preference is given to always try and map ``low-power``, ``balanced``,
+and ``performance`` profiles, as these seem to be the most common profiles
+utilized (and sometimes even required) by various userspace tools.
+
+The result of the mapping will be printed in the kernel log when the module is
+loaded. Supported profiles can also be retrieved from
+``/sys/firmware/acpi/platform_profile_choices``, while
+``/sys/firmware/acpi/platform_profile`` can be used to read or write the
+currently selected profile.
+
+The ``balanced`` platform profile will be set during module load if no profile
+has been previously set.
+
+
+.. _battery-charge-control-end-threshold:
+
+Battery charge control end threshold
+====================================
+
+Controlled by parameter: ``battery_threshold``
+
+This platform driver will add the ability to set the battery's charge control
+end threshold, but does not have the ability to set a start threshold.
+
+This feature is typically called "Battery Saver" by the various Samsung
+applications in Windows, but in Linux we have implemented the standardized
+"charge control threshold" sysfs interface on the battery device to allow for
+controlling this functionality from the userspace.
+
+The sysfs attribute
+``/sys/class/power_supply/BAT1/charge_control_end_threshold`` can be used to
+read or set the desired charge end threshold.
+
+If you wish to maintain interoperability with Windows, then you should set the
+value to 80 to represent "on", or 0 to represent "off", as these are the values
+currently recognized by the various Windows-based Samsung applications and
+services as "on" or "off". Otherwise, the device will accept any value between 0
+(off) and 99 as the percentage that you wish the battery to stop charging at.
+
+.. note::
+  If you try to set a value of 100, the driver will also accept this input, but
+  will set the attribute value to 0 (i.e. 100% will "remove" the end threshold).
+
+
+.. _settings-attributes:
+
+Settings Attributes
+===================
+
+Various hardware settings can be controlled by the following sysfs attributes:
+
+- ``allow_recording`` (allows or blocks usage of built-in camera and microphone)
+- ``start_on_lid_open`` (power on automatically when opening the lid)
+- ``usb_charge`` (allows USB ports to provide power even when device is off)
+
+These attributes will be available under the path for your supported ACPI Device
+ID's platform device (``SAM0428``, ``SAM0429``, etc), and can most reliably
+be found by seeing which device has been bound to the ``samsung-galaxybook``
+driver. Here are some examples: ::
+
+  # find which device ID has been bound to the driver
+  ls /sys/bus/platform/drivers/samsung-galaxybook/ | grep SAM
+
+  # see SAM0429 attributes
+  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM0429\:00
+
+  # see attributes no matter the device ID (using wildcard expansion)
+  ls /sys/bus/platform/drivers/samsung-galaxybook/SAM*
+
+Most shells should support using wildcard expansion to directly read and write
+these attributes using the above pattern. Example: ::
+
+  # read value of start_on_lid_open
+  cat /sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_open
+
+  # turn on start_on_lid_open
+  echo true | sudo tee /sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_open
+
+It is also possible to use a udev rule to create a fixed-path symlink to your
+device under ``/dev`` (e.g. ``/dev/samsung-galaxybook``), no matter the device
+ID, to further simplify reading and writing these attributes in the userspace.
+
+Allow recording (allow_recording)
+---------------------------------
+
+``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/allow_recording``
+
+Controlled by parameter: ``allow_recording``
+
+Controls the "Allow recording" setting, which allows or blocks usage of the
+built-in camera and microphone (boolean).
+
+Start on lid open (start_on_lid_open)
+-------------------------------------
+
+``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/start_on_lid_open``
+
+Controls the "Start on lid open" setting, which sets the device to power on
+automatically when the lid is opened (boolean).
+
+USB charge (usb_charge)
+-----------------------
+
+``/sys/bus/platform/drivers/samsung-galaxybook/SAM*/usb_charge``
+
+Controls the "USB charge" setting, which allows USB ports to provide power even
+when the device is turned off (boolean).
+
+.. note::
+  For most devices, this setting seems to only apply to the USB-C ports.
+
+
+.. _keyboard-hotkey-actions:
+
+Keyboard hotkey actions (i8042 filter)
+======================================
+
+Controlled by parameter: ``i8042_filter``
+
+The i8042 filter will swallow the keyboard events for the Fn+F9 hotkey (Multi-
+level keyboard backlight toggle) and Fn+F10 hotkey (Allow/block recording
+toggle) and instead execute their actions within the driver itself.
+
+Fn+F9 will cycle through the brightness levels of the keyboard backlight. A
+notification will be sent using ``led_classdev_notify_brightness_hw_changed``
+so that the userspace can be aware of the change. This mimics the behavior of
+other existing devices where the brightness level is cycled internally by the
+embedded controller and then reported via a notification.
+
+Fn+F10 will toggle the value of the "Allow recording" setting.
+
+
+ACPI notifications and ACPI hotkey actions
+==========================================
+
+There is a new "Samsung Galaxy Book extra buttons" input device created which
+will send input events for the following notifications from the ACPI device:
+
+- Notification when the battery charge control end threshold has been reached
+  and the "battery saver" feature has stopped the battery from charging
+- Notification when the device has been placed on a table (not available on all
+  models)
+- Notification when the device has been lifted from a table (not available on
+  all models)
+
+The Fn+F11 Performance mode hotkey is received as an ACPI notification. It will
+be handled in a similar way as the Fn+F9 and Fn+F10 hotkeys; namely, that the
+keypress will be swallowed by the driver and each press will cycle to the next
+available platform profile.
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
index 3809931b9240..9e3b45cf799f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20733,6 +20733,14 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/s3c-fb.c
 
+SAMSUNG GALAXY BOOK EXTRAS DRIVER
+M:	Joshua Grisham <josh@joshuagrisham.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/laptops/samsung-galaxybook.rst
+F:	drivers/platform/x86/samsung-galaxybook-trace.h
+F:	drivers/platform/x86/samsung-galaxybook.c
+
 SAMSUNG INTERCONNECT DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Artur Świgoń <a.swigon@samsung.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0258dd879d64..03f4fb0e93e7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -778,6 +778,24 @@ config BARCO_P50_GPIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called barco-p50-gpio.
 
+config SAMSUNG_GALAXYBOOK
+	tristate "Samsung Galaxy Book extras driver"
+	depends on ACPI
+	depends on ACPI_BATTERY
+	depends on INPUT
+	depends on SERIO_I8042
+	select ACPI_PLATFORM_PROFILE
+	select INPUT_SPARSEKMAP
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  This is a driver for Samsung Galaxy Book series notebooks. It adds
+	  support for the keyboard backlight control, performance mode control, fan
+	  speed reporting, function keys, and various other device controls.
+
+	  For more information about this driver, see
+	  <file:Documentation/admin-guide/laptops/samsung-galaxybook.rst>.
+
 config SAMSUNG_LAPTOP
 	tristate "Samsung Laptop driver"
 	depends on RFKILL || RFKILL = n
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b142947067..32ec4cb9d902 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -95,8 +95,9 @@ obj-$(CONFIG_PCENGINES_APU2)	+= pcengines-apuv2.o
 obj-$(CONFIG_BARCO_P50_GPIO)	+= barco-p50-gpio.o
 
 # Samsung
-obj-$(CONFIG_SAMSUNG_LAPTOP)	+= samsung-laptop.o
-obj-$(CONFIG_SAMSUNG_Q10)	+= samsung-q10.o
+obj-$(CONFIG_SAMSUNG_GALAXYBOOK)	+= samsung-galaxybook.o
+obj-$(CONFIG_SAMSUNG_LAPTOP)		+= samsung-laptop.o
+obj-$(CONFIG_SAMSUNG_Q10)		+= samsung-q10.o
 
 # Toshiba
 obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+= toshiba_bluetooth.o
diff --git a/drivers/platform/x86/samsung-galaxybook-trace.h b/drivers/platform/x86/samsung-galaxybook-trace.h
new file mode 100644
index 000000000000..09ab6dbe6586
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
new file mode 100644
index 000000000000..7baa3441fbfa
--- /dev/null
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -0,0 +1,1380 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Samsung Galaxy Book series extras driver
+ *
+ * Copyright (c) 2024 Joshua Grisham <josh@joshuagrisham.com>
+ *
+ * With contributions to the SCAI ACPI device interface:
+ * Copyright (c) 2024 Giulio Girardi <giulio.girardi@protechgroup.it>
+ *
+ * Implementation inspired by existing x86 platform drivers.
+ * Thank you to the authors!
+ */
+
+#include <linux/acpi.h>
+#include <linux/err.h>
+#include <linux/i8042.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/platform_profile.h>
+#include <linux/serio.h>
+#include <linux/sysfs.h>
+#include <linux/uuid.h>
+#include <linux/workqueue.h>
+#include <acpi/battery.h>
+
+#define CREATE_TRACE_POINTS
+#include "samsung-galaxybook-trace.h"
+
+#define DRIVER_NAME "samsung-galaxybook"
+
+/*
+ * Module parameters
+ */
+
+static bool kbd_backlight = true;
+static bool battery_threshold = true;
+static bool performance_mode = true;
+static bool allow_recording = true;
+static bool i8042_filter = true;
+
+module_param(kbd_backlight, bool, 0);
+MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (default on)");
+module_param(battery_threshold, bool, 0);
+MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold control (default on)");
+module_param(performance_mode, bool, 0);
+MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (default on)");
+module_param(allow_recording, bool, 0);
+MODULE_PARM_DESC(allow_recording,
+		 "Enable control to allow or block access to camera and microphone (default on)");
+module_param(i8042_filter, bool, 0);
+MODULE_PARM_DESC(i8042_filter, "Enable capturing keyboard hotkey events (default on)");
+
+/*
+ * Device definitions and matching
+ */
+
+static const struct acpi_device_id galaxybook_device_ids[] = {
+	{ "SAM0427" },
+	{ "SAM0428" },
+	{ "SAM0429" },
+	{ "SAM0430" },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, galaxybook_device_ids);
+
+struct samsung_galaxybook {
+	struct platform_device *platform;
+	struct acpi_device *acpi;
+	struct mutex acpi_lock;
+
+	struct led_classdev kbd_backlight;
+
+	struct input_dev *input;
+	struct mutex input_lock;
+
+	void *i8042_filter_ptr;
+	struct work_struct kbd_backlight_hotkey_work;
+	struct work_struct allow_recording_hotkey_work;
+
+	struct acpi_battery_hook battery_hook;
+	struct device_attribute charge_control_end_threshold_attr;
+
+	u8 *profile_performance_modes;
+	struct platform_profile_handler profile_handler;
+};
+static struct samsung_galaxybook *galaxybook_ptr;
+
+struct sawb {
+	u16 safn;
+	u16 sasb;
+	u8 rflg;
+	union {
+		struct {
+			u8 gunm;
+			u8 guds[250];
+		};
+		struct {
+			u8 caid[16];
+			u8 fncn;
+			u8 subn;
+			u8 iob0;
+			u8 iob1;
+			u8 iob2;
+			u8 iob3;
+			u8 iob4;
+			u8 iob5;
+			u8 iob6;
+			u8 iob7;
+			u8 iob8;
+			u8 iob9;
+		};
+		struct {
+			u8 iob_prefix[18];
+			u8 iob_values[10];
+		};
+	};
+};
+
+#define SAWB_LEN_SETTINGS         0x15
+#define SAWB_LEN_PERFORMANCE_MODE 0x100
+
+#define SAFN  0x5843
+
+#define SASB_KBD_BACKLIGHT     0x78
+#define SASB_POWER_MANAGEMENT  0x7a
+#define SASB_USB_CHARGE_GET    0x67
+#define SASB_USB_CHARGE_SET    0x68
+#define SASB_NOTIFICATIONS     0x86
+#define SASB_ALLOW_RECORDING   0x8a
+#define SASB_PERFORMANCE_MODE  0x91
+
+#define SAWB_RFLG_POS  4
+#define SAWB_GUNM_POS  5
+
+#define RFLG_SUCCESS  0xaa
+#define GUNM_FAIL     0xff
+
+#define GUNM_FEATURE_ENABLE          0xbb
+#define GUNM_FEATURE_ENABLE_SUCCESS  0xdd
+#define GUDS_FEATURE_ENABLE          0xaa
+#define GUDS_FEATURE_ENABLE_SUCCESS  0xcc
+
+#define GUNM_GET  0x81
+#define GUNM_SET  0x82
+
+#define GUNM_POWER_MANAGEMENT  0x82
+
+#define GUNM_USB_CHARGE_GET              0x80
+#define GUNM_USB_CHARGE_ON               0x81
+#define GUNM_USB_CHARGE_OFF              0x80
+#define GUDS_START_ON_LID_OPEN           0xa3
+#define GUDS_START_ON_LID_OPEN_GET       0x81
+#define GUDS_START_ON_LID_OPEN_SET       0x80
+#define GUDS_BATTERY_CHARGE_CONTROL      0xe9
+#define GUDS_BATTERY_CHARGE_CONTROL_GET  0x91
+#define GUDS_BATTERY_CHARGE_CONTROL_SET  0x90
+#define GUNM_ACPI_NOTIFY_ENABLE          0x80
+#define GUDS_ACPI_NOTIFY_ENABLE          0x02
+
+#define FNCN_PERFORMANCE_MODE       0x51
+#define SUBN_PERFORMANCE_MODE_LIST  0x01
+#define SUBN_PERFORMANCE_MODE_GET   0x02
+#define SUBN_PERFORMANCE_MODE_SET   0x03
+
+/* guid 8246028d-8bca-4a55-ba0f-6f1e6b921b8f */
+static const guid_t performance_mode_guid_value =
+	GUID_INIT(0x8246028d, 0x8bca, 0x4a55, 0xba, 0x0f, 0x6f, 0x1e, 0x6b, 0x92, 0x1b, 0x8f);
+#define PERFORMANCE_MODE_GUID performance_mode_guid_value
+
+#define PERFORMANCE_MODE_ULTRA               0x16
+#define PERFORMANCE_MODE_PERFORMANCE         0x15
+#define PERFORMANCE_MODE_SILENT              0xb
+#define PERFORMANCE_MODE_QUIET               0xa
+#define PERFORMANCE_MODE_OPTIMIZED           0x2
+#define PERFORMANCE_MODE_PERFORMANCE_LEGACY  0x1
+#define PERFORMANCE_MODE_OPTIMIZED_LEGACY    0x0
+#define PERFORMANCE_MODE_UNKNOWN             0xff
+
+#define DEFAULT_PLATFORM_PROFILE PLATFORM_PROFILE_BALANCED
+
+#define ACPI_METHOD_ENABLE           "SDLS"
+#define ACPI_METHOD_ENABLE_ON        1
+#define ACPI_METHOD_ENABLE_OFF       0
+#define ACPI_METHOD_SETTINGS         "CSFI"
+#define ACPI_METHOD_PERFORMANCE_MODE "CSXI"
+
+#define KBD_BACKLIGHT_MAX_BRIGHTNESS  3
+
+#define ACPI_NOTIFY_BATTERY_STATE_CHANGED    0x61
+#define ACPI_NOTIFY_DEVICE_ON_TABLE          0x6c
+#define ACPI_NOTIFY_DEVICE_OFF_TABLE         0x6d
+#define ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE  0x70
+
+#define GB_KEY_KBD_BACKLIGHT_KEYDOWN    0x2c
+#define GB_KEY_KBD_BACKLIGHT_KEYUP      0xac
+#define GB_KEY_ALLOW_RECORDING_KEYDOWN  0x1f
+#define GB_KEY_ALLOW_RECORDING_KEYUP    0x9f
+
+static const struct key_entry galaxybook_acpi_keymap[] = {
+	{ KE_KEY, ACPI_NOTIFY_BATTERY_STATE_CHANGED,   { KEY_BATTERY } },
+	{ KE_KEY, ACPI_NOTIFY_DEVICE_ON_TABLE,         { KEY_F14 } },
+	{ KE_KEY, ACPI_NOTIFY_DEVICE_OFF_TABLE,        { KEY_F15 } },
+	{ KE_KEY, ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE, { KEY_UNKNOWN } },
+	{ KE_END, 0 },
+};
+
+/*
+ * ACPI method handling
+ */
+
+static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook, acpi_string method,
+				  struct sawb *in_buf, size_t len, const char *purpose_str,
+				  struct sawb *out_buf)
+{
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object in_obj, *out_obj;
+	struct acpi_object_list input;
+	acpi_status status;
+	int err;
+
+	mutex_lock(&galaxybook->acpi_lock);
+
+	in_obj.type = ACPI_TYPE_BUFFER;
+	in_obj.buffer.length = len;
+	in_obj.buffer.pointer = (u8 *)in_buf;
+
+	input.count = 1;
+	input.pointer = &in_obj;
+
+	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method, purpose_str,
+				      in_obj.buffer.pointer, in_obj.buffer.length);
+
+	status = acpi_evaluate_object_typed(galaxybook->acpi->handle, method, &input, &output,
+					    ACPI_TYPE_BUFFER);
+
+	if (ACPI_FAILURE(status)) {
+		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; got %s\n",
+			purpose_str, method, acpi_format_exception(status));
+		err = -ENXIO;
+		goto out_free;
+	}
+
+	out_obj = output.pointer;
+
+	trace_samsung_galaxybook_acpi(dev_name(&galaxybook->acpi->dev), method, "response",
+				      out_obj->buffer.pointer, out_obj->buffer.length);
+
+	if (out_obj->buffer.length != len || out_obj->buffer.length < SAWB_GUNM_POS + 1) {
+		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
+		       "response length mismatch\n",
+		       purpose_str, method);
+		err = -ETOOSMALL;
+		goto out_free;
+	}
+	if (out_obj->buffer.pointer[SAWB_RFLG_POS] != RFLG_SUCCESS) {
+		dev_err(&galaxybook->acpi->dev, "failed %s with ACPI method %s; "
+		       "device did not respond with success code 0x%x\n",
+		       purpose_str, method, RFLG_SUCCESS);
+		err = -EIO;
+		goto out_free;
+	}
+	if (out_obj->buffer.pointer[SAWB_GUNM_POS] == GUNM_FAIL) {
+		dev_err(&galaxybook->acpi->dev,
+			"failed %s with ACPI method %s; device responded with failure code 0x%x\n",
+		       purpose_str, method, GUNM_FAIL);
+		err = -EIO;
+		goto out_free;
+	}
+
+	memcpy(out_buf, out_obj->buffer.pointer, len);
+	err = 0;
+
+out_free:
+	kfree(out_obj);
+	mutex_unlock(&galaxybook->acpi_lock);
+	return err;
+}
+
+static int galaxybook_enable_acpi_feature(struct samsung_galaxybook *galaxybook, const u16 sasb)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = sasb;
+	buf.gunm = GUNM_FEATURE_ENABLE;
+	buf.guds[0] = GUDS_FEATURE_ENABLE;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "enabling ACPI feature", &buf);
+	if (err)
+		return err;
+
+	if (buf.gunm != GUNM_FEATURE_ENABLE_SUCCESS && buf.guds[0] != GUDS_FEATURE_ENABLE_SUCCESS)
+		return -ENODEV;
+
+	return 0;
+}
+
+/*
+ * Keyboard Backlight
+ */
+
+static int kbd_backlight_acpi_set(struct samsung_galaxybook *galaxybook,
+				  const enum led_brightness brightness)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_KBD_BACKLIGHT;
+	buf.gunm = GUNM_SET;
+
+	buf.guds[0] = brightness;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "setting kbd_backlight brightness", &buf);
+	if (err)
+		return err;
+
+	galaxybook->kbd_backlight.brightness = brightness;
+
+	return 0;
+}
+
+static int kbd_backlight_acpi_get(struct samsung_galaxybook *galaxybook,
+				  enum led_brightness *brightness)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_KBD_BACKLIGHT;
+	buf.gunm = GUNM_GET;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "getting kbd_backlight brightness", &buf);
+	if (err)
+		return err;
+
+	*brightness = buf.gunm;
+	galaxybook->kbd_backlight.brightness = buf.gunm;
+
+	return 0;
+}
+
+static int kbd_backlight_store(struct led_classdev *led,
+			       const enum led_brightness brightness)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(led, struct samsung_galaxybook, kbd_backlight);
+
+	return kbd_backlight_acpi_set(galaxybook, brightness);
+}
+
+static enum led_brightness kbd_backlight_show(struct led_classdev *led)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(led, struct samsung_galaxybook, kbd_backlight);
+	enum led_brightness brightness;
+	int err;
+
+	err = kbd_backlight_acpi_get(galaxybook, &brightness);
+	if (err)
+		return err;
+
+	return brightness;
+}
+
+static int galaxybook_kbd_backlight_init(struct samsung_galaxybook *galaxybook)
+{
+	struct led_init_data init_data = {};
+	enum led_brightness brightness;
+	int err;
+
+	err = galaxybook_enable_acpi_feature(galaxybook, SASB_KBD_BACKLIGHT);
+	if (err)
+		return err;
+
+	/* verify we can read the value, otherwise init should stop and fail */
+	err = kbd_backlight_acpi_get(galaxybook, &brightness);
+	if (err)
+		return err;
+
+	init_data.devicename = DRIVER_NAME;
+	init_data.default_label = ":" LED_FUNCTION_KBD_BACKLIGHT;
+	init_data.devname_mandatory = true;
+
+	galaxybook->kbd_backlight.brightness_get = kbd_backlight_show;
+	galaxybook->kbd_backlight.brightness_set_blocking = kbd_backlight_store;
+	galaxybook->kbd_backlight.flags = LED_BRIGHT_HW_CHANGED;
+	galaxybook->kbd_backlight.max_brightness = KBD_BACKLIGHT_MAX_BRIGHTNESS;
+
+	return devm_led_classdev_register_ext(&galaxybook->platform->dev,
+					      &galaxybook->kbd_backlight, &init_data);
+}
+
+/*
+ * Platform device attributes (configuration properties which can be controlled via userspace)
+ */
+
+/* Start on lid open (device should power on when lid is opened) */
+
+static int start_on_lid_open_acpi_set(struct samsung_galaxybook *galaxybook, const bool value)
+{
+	struct sawb buf = { 0 };
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_POWER_MANAGEMENT;
+	buf.gunm = GUNM_POWER_MANAGEMENT;
+	buf.guds[0] = GUDS_START_ON_LID_OPEN;
+	buf.guds[1] = GUDS_START_ON_LID_OPEN_SET;
+	buf.guds[2] = value ? 1 : 0;
+
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting start_on_lid_open", &buf);
+}
+
+static int start_on_lid_open_acpi_get(struct samsung_galaxybook *galaxybook, bool *value)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_POWER_MANAGEMENT;
+	buf.gunm = GUNM_POWER_MANAGEMENT;
+	buf.guds[0] = GUDS_START_ON_LID_OPEN;
+	buf.guds[1] = GUDS_START_ON_LID_OPEN_GET;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "getting start_on_lid_open", &buf);
+	if (err)
+		return err;
+
+	*value = buf.guds[1];
+
+	return 0;
+}
+
+static ssize_t start_on_lid_open_store(struct device *dev, struct device_attribute *attr,
+				       const char *buffer, size_t count)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	if (!count)
+		return -EINVAL;
+
+	err = kstrtobool(buffer, &value);
+	if (err)
+		return err;
+
+	err = start_on_lid_open_acpi_set(galaxybook, value);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static ssize_t start_on_lid_open_show(struct device *dev, struct device_attribute *attr,
+				      char *buffer)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	err = start_on_lid_open_acpi_get(galaxybook, &value);
+	if (err)
+		return err;
+
+	return sysfs_emit(buffer, "%u\n", value);
+}
+
+static DEVICE_ATTR_RW(start_on_lid_open);
+
+/* USB Charge (USB ports can charge other devices even when device is powered off) */
+
+static int usb_charge_acpi_set(struct samsung_galaxybook *galaxybook, const bool value)
+{
+	struct sawb buf = { 0 };
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_USB_CHARGE_SET;
+	buf.gunm = value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
+
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting usb_charge", &buf);
+}
+
+static int usb_charge_acpi_get(struct samsung_galaxybook *galaxybook, bool *value)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_USB_CHARGE_GET;
+	buf.gunm = GUNM_USB_CHARGE_GET;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "getting usb_charge", &buf);
+	if (err)
+		return err;
+
+	*value = buf.gunm;
+
+	return 0;
+}
+
+static ssize_t usb_charge_store(struct device *dev, struct device_attribute *attr,
+				const char *buffer, size_t count)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	if (!count)
+		return -EINVAL;
+
+	err = kstrtobool(buffer, &value);
+	if (err)
+		return err;
+
+	err = usb_charge_acpi_set(galaxybook, value);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static ssize_t usb_charge_show(struct device *dev, struct device_attribute *attr, char *buffer)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	err = usb_charge_acpi_get(galaxybook, &value);
+	if (err)
+		return err;
+
+	return sysfs_emit(buffer, "%u\n", value);
+}
+
+static DEVICE_ATTR_RW(usb_charge);
+
+/* Allow recording (allows or blocks access to camera and microphone) */
+
+static int allow_recording_acpi_set(struct samsung_galaxybook *galaxybook, const bool value)
+{
+	struct sawb buf = { 0 };
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_ALLOW_RECORDING;
+	buf.gunm = GUNM_SET;
+	buf.guds[0] = value ? 1 : 0;
+
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting allow_recording", &buf);
+}
+
+static int allow_recording_acpi_get(struct samsung_galaxybook *galaxybook, bool *value)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_ALLOW_RECORDING;
+	buf.gunm = GUNM_GET;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "getting allow_recording", &buf);
+	if (err)
+		return err;
+
+	*value = buf.gunm == 1;
+
+	return 0;
+}
+
+static ssize_t allow_recording_store(struct device *dev, struct device_attribute *attr,
+				     const char *buffer, size_t count)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	if (!count)
+		return -EINVAL;
+
+	err = kstrtobool(buffer, &value);
+	if (err)
+		return err;
+
+	err = allow_recording_acpi_set(galaxybook, value);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static ssize_t allow_recording_show(struct device *dev, struct device_attribute *attr, char *buffer)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool value;
+	int err;
+
+	err = allow_recording_acpi_get(galaxybook, &value);
+	if (err)
+		return err;
+
+	return sysfs_emit(buffer, "%u\n", value);
+}
+
+static DEVICE_ATTR_RW(allow_recording);
+
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
+/*
+ * Battery Extension (adds charge_control_end_threshold to the battery device)
+ */
+
+static int charge_control_end_threshold_acpi_set(struct samsung_galaxybook *galaxybook, u8 value)
+{
+	struct sawb buf = { 0 };
+
+	if (value > 100)
+		return -EINVAL;
+	/* if setting to 100, should be set to 0 (no threshold) */
+	if (value == 100)
+		value = 0;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_POWER_MANAGEMENT;
+	buf.gunm = GUNM_POWER_MANAGEMENT;
+	buf.guds[0] = GUDS_BATTERY_CHARGE_CONTROL;
+	buf.guds[1] = GUDS_BATTERY_CHARGE_CONTROL_SET;
+	buf.guds[2] = value;
+
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "setting battery charge_control_end_threshold", &buf);
+}
+
+static int charge_control_end_threshold_acpi_get(struct samsung_galaxybook *galaxybook, u8 *value)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_POWER_MANAGEMENT;
+	buf.gunm = GUNM_POWER_MANAGEMENT;
+	buf.guds[0] = GUDS_BATTERY_CHARGE_CONTROL;
+	buf.guds[1] = GUDS_BATTERY_CHARGE_CONTROL_GET;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "getting battery charge_control_end_threshold", &buf);
+	if (err)
+		return err;
+
+	*value = buf.guds[1];
+
+	return 0;
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
+						  const char *buffer, size_t count)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(attr, struct samsung_galaxybook, charge_control_end_threshold_attr);
+	u8 value;
+	int err;
+
+	if (!count)
+		return -EINVAL;
+
+	err = kstrtou8(buffer, 0, &value);
+	if (err)
+		return err;
+
+	err = charge_control_end_threshold_acpi_set(galaxybook, value);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
+						 char *buffer)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(attr, struct samsung_galaxybook, charge_control_end_threshold_attr);
+	u8 value;
+	int err;
+
+	err = charge_control_end_threshold_acpi_get(galaxybook, &value);
+	if (err)
+		return err;
+
+	return sysfs_emit(buffer, "%d\n", value);
+}
+
+static int galaxybook_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(hook, struct samsung_galaxybook, battery_hook);
+
+	return device_create_file(&battery->dev, &galaxybook->charge_control_end_threshold_attr);
+}
+
+static int galaxybook_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(hook, struct samsung_galaxybook, battery_hook);
+
+	device_remove_file(&battery->dev, &galaxybook->charge_control_end_threshold_attr);
+	return 0;
+}
+
+static int galaxybook_battery_threshold_init(struct samsung_galaxybook *galaxybook)
+{
+	struct acpi_battery_hook *hook;
+	struct device_attribute *attr;
+	u8 value;
+	int err;
+
+	err = charge_control_end_threshold_acpi_get(galaxybook, &value);
+	if (err)
+		return err;
+
+	hook = &galaxybook->battery_hook;
+	hook->add_battery = galaxybook_battery_add;
+	hook->remove_battery = galaxybook_battery_remove;
+	hook->name = "Samsung Galaxy Book Battery Extension";
+
+	attr = &galaxybook->charge_control_end_threshold_attr;
+	sysfs_attr_init(attr->attr);
+	attr->attr.name = "charge_control_end_threshold";
+	attr->attr.mode = 0644;
+	attr->show = charge_control_end_threshold_show;
+	attr->store = charge_control_end_threshold_store;
+
+	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxybook->battery_hook);
+}
+
+/*
+ * Platform Profile / Performance mode
+ */
+
+static int performance_mode_acpi_set(struct samsung_galaxybook *galaxybook,
+				     const u8 performance_mode)
+{
+	struct sawb buf = { 0 };
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_PERFORMANCE_MODE;
+	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
+	buf.fncn = FNCN_PERFORMANCE_MODE;
+	buf.subn = SUBN_PERFORMANCE_MODE_SET;
+	buf.iob0 = performance_mode;
+
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE, &buf,
+				      SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
+}
+
+static int performance_mode_acpi_get(struct samsung_galaxybook *galaxybook, u8 *performance_mode)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_PERFORMANCE_MODE;
+	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
+	buf.fncn = FNCN_PERFORMANCE_MODE;
+	buf.subn = SUBN_PERFORMANCE_MODE_GET;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE, &buf,
+				     SAWB_LEN_PERFORMANCE_MODE, "getting performance_mode", &buf);
+	if (err)
+		return err;
+
+	*performance_mode = buf.iob0;
+
+	return 0;
+}
+
+static int get_performance_mode_profile(struct samsung_galaxybook *galaxybook,
+					const u8 performance_mode,
+					enum platform_profile_option *profile)
+{
+	for (int i = 0; i < PLATFORM_PROFILE_LAST; i++) {
+		if (galaxybook->profile_performance_modes[i] == performance_mode) {
+			if (profile)
+				*profile = i;
+			return 0;
+		}
+	}
+
+	return -ENODATA;
+}
+
+static int galaxybook_platform_profile_set(struct platform_profile_handler *pprof,
+					   enum platform_profile_option profile)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(pprof, struct samsung_galaxybook, profile_handler);
+
+	return performance_mode_acpi_set(galaxybook,
+					 galaxybook->profile_performance_modes[profile]);
+}
+
+static int galaxybook_platform_profile_get(struct platform_profile_handler *pprof,
+					   enum platform_profile_option *profile)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(pprof, struct samsung_galaxybook, profile_handler);
+	u8 performance_mode;
+	int err;
+
+	err = performance_mode_acpi_get(galaxybook, &performance_mode);
+	if (err)
+		return err;
+
+	return get_performance_mode_profile(galaxybook, performance_mode, profile);
+}
+
+static void galaxybook_profile_exit(void *data)
+{
+	struct samsung_galaxybook *galaxybook = data;
+
+	platform_profile_remove(&galaxybook->profile_handler);
+}
+
+#define IGNORE_PERFORMANCE_MODE_MAPPING  -1
+
+static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
+{
+	u8 current_performance_mode;
+	struct sawb buf = { 0 };
+	int mapped_profiles;
+	int mode_profile;
+	int err;
+	int i;
+
+	galaxybook->profile_handler.profile_get = galaxybook_platform_profile_get;
+	galaxybook->profile_handler.profile_set = galaxybook_platform_profile_set;
+
+	/* fetch supported performance mode values from ACPI method */
+	buf.safn = SAFN;
+	buf.sasb = SASB_PERFORMANCE_MODE;
+	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
+	buf.fncn = FNCN_PERFORMANCE_MODE;
+	buf.subn = SUBN_PERFORMANCE_MODE_LIST;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE,
+				     &buf, SAWB_LEN_PERFORMANCE_MODE,
+				     "get supported performance modes", &buf);
+	if (err)
+		return err;
+
+	/* set up profile_performance_modes with "unknown" as init value */
+	galaxybook->profile_performance_modes =
+		kcalloc(PLATFORM_PROFILE_LAST, sizeof(u8), GFP_KERNEL);
+	if (!galaxybook->profile_performance_modes)
+		return -ENOMEM;
+	for (i = 0; i < PLATFORM_PROFILE_LAST; i++)
+		galaxybook->profile_performance_modes[i] = PERFORMANCE_MODE_UNKNOWN;
+
+	/*
+	 * Value returned in iob0 will have the number of supported performance modes.
+	 * The performance mode values will then be given as a list after this (iob1-iobX).
+	 * Loop backwards from last value to first value (to handle fallback cases which come with
+	 * smaller values) and map each supported value to its correct platform_profile_option.
+	 */
+	for (i = buf.iob0; i > 0; i--) {
+		/*
+		 * Prefer mapping to at least performance, balanced, and low-power profiles, as they
+		 * are the profiles which are typically supported by userspace tools
+		 * (power-profiles-daemon, etc).
+		 * - performance = "ultra", otherwise "performance"
+		 * - balanced    = "optimized", otherwise "performance" when "ultra" is supported
+		 * - low-power   = "silent", otherwise "quiet"
+		 * Different models support different modes. Additional supported modes will be
+		 * mapped to profiles that fall in between these 3.
+		 */
+		switch (buf.iob_values[i]) {
+
+		case PERFORMANCE_MODE_ULTRA:
+			/* ultra always maps to performance */
+			mode_profile = PLATFORM_PROFILE_PERFORMANCE;
+			break;
+
+		case PERFORMANCE_MODE_PERFORMANCE:
+			/* if ultra exists, map performance to balanced-performance */
+			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERFORMANCE] !=
+			    PERFORMANCE_MODE_UNKNOWN)
+				mode_profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
+			else /* otherwise map it to performance instead */
+				mode_profile = PLATFORM_PROFILE_PERFORMANCE;
+			break;
+
+		case PERFORMANCE_MODE_SILENT:
+			/* silent always maps to low-power */
+			mode_profile = PLATFORM_PROFILE_LOW_POWER;
+			break;
+
+		case PERFORMANCE_MODE_QUIET:
+			/* if silent exists, map quiet to quiet */
+			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_LOW_POWER] !=
+			    PERFORMANCE_MODE_UNKNOWN)
+				mode_profile = PLATFORM_PROFILE_QUIET;
+			else /* otherwise map it to low-power for better userspace tool support */
+				mode_profile = PLATFORM_PROFILE_LOW_POWER;
+			break;
+
+		case PERFORMANCE_MODE_OPTIMIZED:
+			/* optimized always maps to balanced */
+			mode_profile = PLATFORM_PROFILE_BALANCED;
+			break;
+
+		case PERFORMANCE_MODE_PERFORMANCE_LEGACY:
+			/* map to performance if performance is not already supported */
+			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_PERFORMANCE] ==
+			    PERFORMANCE_MODE_UNKNOWN)
+				mode_profile = PLATFORM_PROFILE_PERFORMANCE;
+			else /* otherwise, ignore */
+				mode_profile = IGNORE_PERFORMANCE_MODE_MAPPING;
+			break;
+
+		case PERFORMANCE_MODE_OPTIMIZED_LEGACY:
+			/* map to balanced if balanced is not already supported */
+			if (galaxybook->profile_performance_modes[PLATFORM_PROFILE_BALANCED] ==
+			    PERFORMANCE_MODE_UNKNOWN)
+				mode_profile = PLATFORM_PROFILE_BALANCED;
+			else /* otherwise, ignore */
+				mode_profile = IGNORE_PERFORMANCE_MODE_MAPPING;
+			break;
+
+		default: /* any other value is not supported */
+			mode_profile = IGNORE_PERFORMANCE_MODE_MAPPING;
+			break;
+		}
+
+		/* if current mode value mapped to a supported platform_profile_option, set it up */
+		if (mode_profile != IGNORE_PERFORMANCE_MODE_MAPPING) {
+			mapped_profiles++;
+			galaxybook->profile_performance_modes[mode_profile] = buf.iob_values[i];
+			set_bit(mode_profile, galaxybook->profile_handler.choices);
+			dev_dbg(&galaxybook->platform->dev,
+				"will support platform profile %d (performance mode 0x%x)\n",
+				mode_profile, buf.iob_values[i]);
+		} else {
+			dev_dbg(&galaxybook->platform->dev,
+				"unmapped performance mode 0x%x will be ignored\n",
+				buf.iob_values[i]);
+		}
+	}
+
+	if (mapped_profiles == 0)
+		return -ENODEV;
+
+	err = platform_profile_register(&galaxybook->profile_handler);
+	if (err)
+		return err;
+
+	/* now check currently set performance mode; if not supported then set default profile */
+	err = performance_mode_acpi_get(galaxybook, &current_performance_mode);
+	if (err)
+		goto err_remove_exit;
+	err = get_performance_mode_profile(galaxybook, current_performance_mode, NULL);
+	if (err) {
+		dev_dbg(&galaxybook->platform->dev,
+			"initial performance mode value is not supported by device; "
+			"setting to default\n");
+		err = galaxybook_platform_profile_set(&galaxybook->profile_handler,
+						      DEFAULT_PLATFORM_PROFILE);
+		if (err)
+			goto err_remove_exit;
+	}
+
+	/* if adding dev remove action fails, remove now and return failure */
+	err = devm_add_action_or_reset(&galaxybook->platform->dev,
+				       galaxybook_profile_exit, galaxybook);
+	if (err)
+		goto err_remove_exit;
+
+	return 0;
+
+err_remove_exit:
+	galaxybook_profile_exit(galaxybook);
+	return err;
+}
+
+/*
+ * Hotkey work and filters
+ */
+
+static void galaxybook_kbd_backlight_hotkey_work(struct work_struct *work)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(work, struct samsung_galaxybook, kbd_backlight_hotkey_work);
+
+	if (galaxybook->kbd_backlight.brightness < galaxybook->kbd_backlight.max_brightness)
+		kbd_backlight_acpi_set(galaxybook, galaxybook->kbd_backlight.brightness + 1);
+	else
+		kbd_backlight_acpi_set(galaxybook, 0);
+
+	led_classdev_notify_brightness_hw_changed(
+		&galaxybook->kbd_backlight,
+		galaxybook->kbd_backlight.brightness);
+}
+
+static void galaxybook_allow_recording_hotkey_work(struct work_struct *work)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(work, struct samsung_galaxybook, allow_recording_hotkey_work);
+	bool value;
+
+	allow_recording_acpi_get(galaxybook, &value);
+	allow_recording_acpi_set(galaxybook, !value);
+}
+
+static bool galaxybook_i8042_filter(unsigned char data, unsigned char str, struct serio *port)
+{
+	static bool extended;
+
+	if (str & I8042_STR_AUXDATA)
+		return false;
+
+	if (unlikely(data == 0xe0)) {
+		extended = true;
+		return true;
+	} else if (unlikely(extended)) {
+		extended = false;
+		switch (data) {
+
+		case GB_KEY_KBD_BACKLIGHT_KEYDOWN:
+			return true;
+		case GB_KEY_KBD_BACKLIGHT_KEYUP:
+			if (kbd_backlight)
+				schedule_work(&galaxybook_ptr->kbd_backlight_hotkey_work);
+			return true;
+
+		case GB_KEY_ALLOW_RECORDING_KEYDOWN:
+			return true;
+		case GB_KEY_ALLOW_RECORDING_KEYUP:
+			if (allow_recording)
+				schedule_work(&galaxybook_ptr->allow_recording_hotkey_work);
+			return true;
+
+		default:
+			/*
+			 * Report the previously filtered e0 before continuing
+			 * with the next non-filtered byte.
+			 */
+			serio_interrupt(port, 0xe0, 0);
+			return false;
+		}
+	}
+
+	return false;
+}
+
+static void galaxybook_i8042_filter_remove(void *data)
+{
+	struct samsung_galaxybook *galaxybook = data;
+
+	i8042_remove_filter(galaxybook_i8042_filter);
+	cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
+	cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
+}
+
+static int galaxybook_i8042_filter_install(struct samsung_galaxybook *galaxybook)
+{
+	int err;
+
+	/* initialize hotkey work queues */
+	if (kbd_backlight)
+		INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
+			  galaxybook_kbd_backlight_hotkey_work);
+	if (allow_recording)
+		INIT_WORK(&galaxybook->allow_recording_hotkey_work,
+			  galaxybook_allow_recording_hotkey_work);
+
+	err = i8042_install_filter(galaxybook_i8042_filter);
+	if (err) {
+		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
+		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
+		return err;
+	}
+
+	/* if adding dev remove action fails, remove now and return failure */
+	err = devm_add_action_or_reset(&galaxybook->platform->dev,
+				       galaxybook_i8042_filter_remove, galaxybook);
+	if (err) {
+		galaxybook_i8042_filter_remove(galaxybook);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * Input device (hotkeys and notifications)
+ */
+
+static void galaxybook_input_notify(struct samsung_galaxybook *galaxybook, int event)
+{
+	if (!galaxybook->input)
+		return;
+	mutex_lock(&galaxybook->input_lock);
+	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
+		dev_warn(&galaxybook->acpi->dev, "unknown input notification event: 0x%x\n", event);
+	mutex_unlock(&galaxybook->input_lock);
+}
+
+static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
+{
+	int err;
+
+	galaxybook->input = devm_input_allocate_device(&galaxybook->platform->dev);
+	if (!galaxybook->input)
+		return -ENOMEM;
+
+	galaxybook->input->name = "Samsung Galaxy Book Extra Buttons";
+	galaxybook->input->phys = DRIVER_NAME "/input0";
+	galaxybook->input->id.bustype = BUS_HOST;
+	galaxybook->input->dev.parent = &galaxybook->platform->dev;
+
+	err = sparse_keymap_setup(galaxybook->input, galaxybook_acpi_keymap, NULL);
+	if (err)
+		return err;
+
+	return input_register_device(galaxybook->input);
+}
+
+/*
+ * ACPI device setup
+ */
+
+static void galaxybook_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct samsung_galaxybook *galaxybook = data;
+
+	if (event == ACPI_NOTIFY_HOTKEY_PERFORMANCE_MODE) {
+		if (performance_mode) {
+			platform_profile_cycle();
+			goto exit;
+		}
+	}
+
+	galaxybook_input_notify(galaxybook, event);
+
+exit:
+	acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(&galaxybook->platform->dev),
+					event, 0);
+}
+
+static int galaxybook_enable_acpi_notify(struct samsung_galaxybook *galaxybook)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	err = galaxybook_enable_acpi_feature(galaxybook, SASB_NOTIFICATIONS);
+	if (err)
+		return err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_NOTIFICATIONS;
+	buf.gunm = GUNM_ACPI_NOTIFY_ENABLE;
+	buf.guds[0] = GUDS_ACPI_NOTIFY_ENABLE;
+
+	return galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				      "activate ACPI notifications", &buf);
+}
+
+static void galaxybook_acpi_remove_notify_handler(void *data)
+{
+	struct samsung_galaxybook *galaxybook = data;
+
+	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
+				   galaxybook_acpi_notify);
+}
+
+static void galaxybook_acpi_disable(void *data)
+{
+	struct samsung_galaxybook *galaxybook = data;
+
+	acpi_execute_simple_method(galaxybook->acpi->handle,
+				   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
+}
+
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
+/*
+ * Platform driver
+ */
+
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
+static int galaxybook_probe(struct platform_device *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct samsung_galaxybook *galaxybook;
+	int err;
+
+	if (!adev)
+		return -ENODEV;
+
+	dev_dbg(&pdev->dev, "loading driver\n");
+
+	galaxybook = devm_kzalloc(&pdev->dev, sizeof(*galaxybook), GFP_KERNEL);
+	if (!galaxybook)
+		return -ENOMEM;
+	/* set static pointer here so it can be used in i8042 filter */
+	galaxybook_ptr = galaxybook;
+
+	galaxybook->platform = pdev;
+	galaxybook->acpi = adev;
+
+	dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
+	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->acpi_lock);
+	devm_mutex_init(&galaxybook->platform->dev, &galaxybook->input_lock);
+
+	err = galaxybook_acpi_init(galaxybook);
+	if (err) {
+		dev_err(&galaxybook->acpi->dev, "failed to initialize the ACPI device\n");
+		return err;
+	}
+
+	err = galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEMENT);
+	if (err) {
+		dev_warn(&galaxybook->acpi->dev,
+			 "failed to initialize ACPI power management features; "
+			 "many features of this driver will not be available\n");
+		performance_mode = false;
+		battery_threshold = false;
+	}
+
+	galaxybook_init_feature(performance_mode, galaxybook_profile_init);
+	galaxybook_init_feature(battery_threshold, galaxybook_battery_threshold_init);
+
+	/* add attrs group here as the is_visible requires above initializations */
+	err = devm_device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
+	if (err)
+		dev_warn(&galaxybook->platform->dev, "failed to add platform device attributes\n");
+
+	galaxybook_init_feature(kbd_backlight, galaxybook_kbd_backlight_init);
+
+	/* i8042_filter should be disabled if kbd_backlight and allow_recording are disabled */
+	if (!kbd_backlight && !allow_recording)
+		i8042_filter = false;
+
+	galaxybook_init_feature(i8042_filter, galaxybook_i8042_filter_install);
+
+	dev_dbg(&galaxybook->platform->dev, "driver successfully loaded\n");
+
+	return 0;
+}
+
+static void galaxybook_remove(struct platform_device *pdev)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(&pdev->dev);
+
+	if (galaxybook_ptr)
+		galaxybook_ptr = NULL;
+
+	dev_dbg(&galaxybook->platform->dev, "driver removed\n");
+}
+
+static struct platform_driver galaxybook_platform_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.acpi_match_table = galaxybook_device_ids,
+	},
+	.probe = galaxybook_probe,
+	.remove = galaxybook_remove,
+};
+module_platform_driver(galaxybook_platform_driver);
+
+MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
+MODULE_DESCRIPTION("Samsung Galaxy Book Extras");
+MODULE_LICENSE("GPL");
-- 
2.45.2


