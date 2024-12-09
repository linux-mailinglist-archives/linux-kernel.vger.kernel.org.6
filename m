Return-Path: <linux-kernel+bounces-438025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3481F9E9BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A111A281CE9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E2B14884C;
	Mon,  9 Dec 2024 16:38:24 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4933597B;
	Mon,  9 Dec 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762301; cv=none; b=VTmtJGvWv6l+O/R0XFM92kWfobD7sB2ZppjWsXhy1IzfS7uLSkNilOVc6lyuC7yIHQst1/u5YsQqxDFXAgSw81zZ4m6UX3yl3XfhD39zl615Ia5FCTksmJmja3kqsZzaIamiwMvS6GhfcX0aWnpgieyqSSDyDboCv91+/bGoIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762301; c=relaxed/simple;
	bh=+lU3p64+oK/EmrBSLg3tdW2y71daR7hdd7AcW4K1W30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bhvlha99AXCE/6H3l8cu15Y+/HbtqiDwcTCZYKiLcaM9T6yBcEXAwC24m/9Z6eSX3O2R6vqG+qYy9AytdWZhswBjfOnIj6B/1i74Hv0Bm+pNGxhNdmUTLJHWpkjwHnz7LmXkOczdHeAMuk5B9sDsbKdm5lI7nGBuPOVhW+O2SlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54024ecc33dso69544e87.0;
        Mon, 09 Dec 2024 08:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733762295; x=1734367095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTjuimTr9AzedVVZhiD4vF9N44lo51mbWl/zXf28j60=;
        b=n8G0OIZTXEYjvA0THS8LFqeTt65sVFB6wepuUeWNesmyxqlWsZ5w2gnD0qBB6KcFVO
         Dfai7ZdoqoaWgEYkYeBKiA0+ysaslAFBnZMptFW91qhuUI7nOVXH7KTytB6MIdAIQXxZ
         OaeXPA1eW0zGeO6FMQ8+b9gf4qrpN/USOU5CLyMtrlclVR7MWxZCbWW9LAs/r+w5fC30
         CkSfsqm+/Z2x4rS5FUfHOSsHpIvl74Teb4x7oHkFon/OiL6wz6Tz7Qdj/AYCBGj3kjX9
         SEzu71lx/hPKeOkbgNDmj9v1D5N0M5mKPCqnab5EBVnD6SY9pUzxJ3QLq4ZV70+CSVK+
         qARg==
X-Forwarded-Encrypted: i=1; AJvYcCU5JtX3NJ75Od5gNLvYjDTL+Nwbo3FMzUOcWynLOBLjanyNE/celH59J5T+T184SAB5Bz9mRpOyoNI=@vger.kernel.org, AJvYcCWSaO0rByIhhG27dxjHx+rL2MrhRr2zGGTnr+gO2Pr+rmd0qSc12OsyGvb+5OL4U8ntZQBpzlELi/SU2sk=@vger.kernel.org, AJvYcCXepxD0BGwZKlEQv8drM/JneKxYlqyXXDWSviXKhXZ1a/elbFI7PfKnQCKbb/csnsWP1IYnd6hIYgDHPtVmpiWLR+rqmg==@vger.kernel.org, AJvYcCXq/GPkBYIGdN094qBoqXi762WkX3j99/ClLV2n3ZKRKQIJlhgjIrfPZJgBFiFzh4wKkM2Ik/8OvlbyQCrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kryMv+10kVc+KUiYpdpLYILA+R4aZj91zGj0Aywtbuofvu1E
	QFSHbyEUTetK6SVkLOSGpQhQPY4U6axahkmBXtoG32V8RFW47jxL
X-Gm-Gg: ASbGnct8+mFui0RuQEv8Lb20yzbHRefsP0I1qEHvHeBjCrB2epJniCGymFJDw1I28Bk
	HUMI+43i3cEDOHMurAG3T4mGfIj3ehvmwbXv0NGN8utaos/4LQGYoGZ0XGwDOEQ/VJs8mfP4oGm
	SUNRNQFjrjQc5UpbcrS91WYVaWfyiTBCIntlTzHuCZO3gt0LPl2dWAd56cYohJfiRY0OLYIftr1
	j6h/U8+GaoS6YXZN0Vxv7KCssVOUNZhHlBRFfABhf9DRx6ekAg3p18wKcnYYY/xnpw3FNs8VCoG
	u8l2k4PJrzX6L+Y=
X-Google-Smtp-Source: AGHT+IHY94Ykq+9XqV3zUXWIjW/1X6PbZHXz186fnnYlt4PPqDs1jHux57aWK0141vDvanyE/+WK5A==
X-Received: by 2002:a05:6512:1089:b0:53d:f712:53ce with SMTP id 2adb3069b0e04-540240aeb23mr531414e87.7.1733762294124;
        Mon, 09 Dec 2024 08:38:14 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401bb10a63sm558051e87.175.2024.12.09.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:38:13 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH] platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
Date: Mon,  9 Dec 2024 17:37:18 +0100
Message-ID: <20241209163720.17597-1-josh@joshuagrisham.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch will add a new driver for Samsung Galaxy Book series notebook
devices. This should hopefully include all suggestions from my original
mailing list feedback thread [1], as well as a first version for
associated updates to the documentation, Kconfig, Makefile, and the
MAINTAINERS file related to this new driver.

I have tested the driver both using m and y in the config, as well as
with various other options mentioned in the patch checklist of the
documentation.

Other users with other device IDs have also tested successfully using
a version of these same driver updates which I have maintained in a
separate branch of my GitHub repository [2].

I have made an attempt with the coding style to find a balance between what
is written in the kernel documentation and what actually exists in current
x86 platform drivers, but any feedback on this (or anything else) is
certainly welcome!

[1]: https://lore.kernel.org/platform-driver-x86/CAMF+KeYus9dW00WNJMLVxLLHdG9JgCfrGJ491fu7NM8GAEqqCg@mail.gmail.com/
[2]: https://github.com/joshuagrisham/samsung-galaxybook-extras/pull/44

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
---
 Documentation/admin-guide/laptops/index.rst   |    1 +
 .../laptops/samsung-galaxybook.rst            |  301 +++
 MAINTAINERS                                   |    6 +
 drivers/platform/x86/Kconfig                  |   19 +
 drivers/platform/x86/Makefile                 |    5 +-
 drivers/platform/x86/samsung-galaxybook.c     | 1972 +++++++++++++++++
 6 files changed, 2302 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/laptops/samsung-galaxybook.rst
 create mode 100644 drivers/platform/x86/samsung-galaxybook.c

diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation/admin-guide/laptops/index.rst
index cd9a1c269..e71c8984c 100644
--- a/Documentation/admin-guide/laptops/index.rst
+++ b/Documentation/admin-guide/laptops/index.rst
@@ -11,6 +11,7 @@ Laptop Drivers
    disk-shock-protection
    laptop-mode
    lg-laptop
+   samsung-galaxybook
    sony-laptop
    sonypi
    thinkpad-acpi
diff --git a/Documentation/admin-guide/laptops/samsung-galaxybook.rst b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
new file mode 100644
index 000000000..ab12f0001
--- /dev/null
+++ b/Documentation/admin-guide/laptops/samsung-galaxybook.rst
@@ -0,0 +1,301 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+Samsung Galaxy Book Extras
+==========================
+
+December 9, 2024
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
+"SAMSUNG ELECTRONICS CO., LTD." devices of type "Notebook" which have one of the
+supported ACPI device IDs should be supported. This covers most of the "Samsung
+Galaxy Book" series notebooks that are currently available as of this writing,
+and could include other Samsung notebook devices as well.
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
+- :ref:`Fan speed <fan-speed>` monitoring via ``fan_speed_rpm`` sysfs attribute
+  plus a new hwmon device
+- :ref:`Settings Attributes <settings-attributes>` to allow control of various
+  device settings
+- :ref:`Handling of Fn hotkeys <keyboard-hotkey-actions>` for various actions
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
+- ``fan_speed``: Enable fan speed (default on)
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
+.. _fan-speed:
+
+Fan speed
+=========
+
+Controlled by parameter: ``fan_speed``
+
+The number and type of fans on these devices can vary, and different methods
+must be used in order to be able to successfully read their status.
+
+In cases where Samsung has implemented the standard ACPI method ``_FST`` for a
+fan device, the other methods in the ACPI specification which would cause
+the kernel to automatically add the ``fan_speed_rpm`` attribute are not always
+present. On top of this, it seems that there are some bugs in the firmware that
+throw an exception when the ``_FST`` method is executed.
+
+This platform driver attempts to resolve all PNP fans that are present in the
+ACPI of supported devices, and add support for reading their speed using the
+following decision tree:
+
+1. Do all 4 required methods exist so that the fan speed should be reported
+   out-of-the-box by ACPI? If yes, then assume this fan is already set up and
+   available.
+
+2. Does the method ``_FST`` exist and appears to be working (returns a speed
+   value greater than 0)? If yes, add an attribute ``fan_speed_rpm`` to this fan
+   device and add a fan input channel for it to the hwmon device. The returned
+   value will be directly read from the ``_FST`` method.
+
+3. Does the field ``FANS`` (fan speed level) exist on the embedded controller,
+   and the table ``FANT`` (fan speed level table) exist on the fan device? If
+   yes, add the ``fan_speed_rpm`` attribute to this fan device and add a fan
+   input channel for it to the hwmon device. The returned value will be based
+   on a match of the current value of ``FANS`` compared to a list of level
+   speeds from the ``FANT`` table.
+
+The fan speed for all supported fans can be monitored using hwmon sensors or by
+reading the ``fan_speed_rpm`` sysfs attribute of each fan device.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 3809931b9..21b4fc504 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20733,6 +20733,12 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/s3c-fb.c
 
+SAMSUNG GALAXY BOOK EXTRAS DRIVER
+M:	Joshua Grisham <josh@joshuagrisham.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/samsung-galaxybook.c
+
 SAMSUNG INTERCONNECT DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 M:	Artur Świgoń <a.swigon@samsung.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0258dd879..b6d28b6a4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -778,6 +778,25 @@ config BARCO_P50_GPIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called barco-p50-gpio.
 
+config SAMSUNG_GALAXYBOOK
+	tristate "Samsung Galaxy Book extras driver"
+	depends on ACPI
+	depends on ACPI_BATTERY
+	depends on INPUT
+	depends on SERIO_I8042
+	depends on HWMON || HWMON = n
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
index e1b142947..32ec4cb9d 100644
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
diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
new file mode 100644
index 000000000..ce8b76d91
--- /dev/null
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -0,0 +1,1972 @@
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
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/hwmon.h>
+#include <linux/i8042.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/nls.h>
+#include <linux/platform_device.h>
+#include <linux/platform_profile.h>
+#include <linux/serio.h>
+#include <linux/workqueue.h>
+#include <acpi/battery.h>
+
+#define SAMSUNG_GALAXYBOOK_CLASS  "samsung-galaxybook"
+#define SAMSUNG_GALAXYBOOK_NAME   "Samsung Galaxy Book Extras"
+
+/*
+ * Module parameters
+ */
+
+static bool kbd_backlight = true;
+static bool battery_threshold = true;
+static bool performance_mode = true;
+static bool allow_recording = true;
+static bool fan_speed = true;
+static bool i8042_filter = true;
+
+module_param(kbd_backlight, bool, 0644);
+MODULE_PARM_DESC(kbd_backlight, "Enable Keyboard Backlight control (default on)");
+module_param(battery_threshold, bool, 0644);
+MODULE_PARM_DESC(battery_threshold, "Enable battery charge threshold control (default on)");
+module_param(performance_mode, bool, 0644);
+MODULE_PARM_DESC(performance_mode, "Enable Performance Mode control (default on)");
+module_param(allow_recording, bool, 0644);
+MODULE_PARM_DESC(allow_recording,
+		 "Enable control to allow or block access to camera and microphone (default on)");
+module_param(fan_speed, bool, 0644);
+MODULE_PARM_DESC(fan_speed, "Enable fan speed (default on)");
+module_param(i8042_filter, bool, 0644);
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
+static const struct dmi_system_id galaxybook_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+	},
+	{}
+};
+
+struct galaxybook_fan {
+	struct acpi_device fan;
+	char *description;
+	bool supports_fst;
+	unsigned int *fan_speeds;
+	int fan_speeds_count;
+	struct dev_ext_attribute fan_speed_rpm_ext_attr;
+};
+
+#define MAX_FAN_COUNT 5
+
+struct samsung_galaxybook {
+	struct platform_device *platform;
+	struct acpi_device *acpi;
+
+	struct led_classdev kbd_backlight;
+	struct work_struct kbd_backlight_hotkey_work;
+
+	struct input_dev *input;
+	struct key_entry *keymap;
+
+	u8 *profile_performance_modes;
+	struct platform_profile_handler profile_handler;
+	struct work_struct performance_mode_hotkey_work;
+
+	struct work_struct allow_recording_hotkey_work;
+
+	struct galaxybook_fan fans[MAX_FAN_COUNT];
+	int fans_count;
+
+#if IS_ENABLED(CONFIG_HWMON)
+	struct device *hwmon;
+#endif
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
+#define ACPI_FAN_DEVICE_ID    "PNP0C0B"
+#define ACPI_FAN_SPEED_LIST   "FANT"
+#define ACPI_FAN_SPEED_VALUE  "\\_SB.PC00.LPCB.H_EC.FANS"
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
+#define pr_debug_prefixed(...) pr_debug("[DEBUG] " __VA_ARGS__)
+
+#define print_acpi_object_buffer_debug(header_str, buf_ptr, buf_len)	\
+	do {								\
+		pr_debug_prefixed("%s\n", header_str);			\
+		print_hex_dump_debug("samsung_galaxybook: [DEBUG]   ",	\
+				     DUMP_PREFIX_NONE, 16, 1, buf_ptr,	\
+				     buf_len, false);			\
+	} while (0)
+
+static char *get_acpi_device_description(struct acpi_device *acpi_dev)
+{
+	struct acpi_buffer str_buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *str_obj;
+	struct acpi_buffer name_buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+	int result;
+
+	/* first try to get value of _STR (and also convert it to utf8)  */
+	if (!acpi_has_method(acpi_dev->handle, "_STR"))
+		goto use_name;
+	status = acpi_evaluate_object_typed(acpi_dev->handle, "_STR", NULL,
+					   &str_buf, ACPI_TYPE_BUFFER);
+	if (ACPI_SUCCESS(status) && str_buf.length > 0) {
+		str_obj = str_buf.pointer;
+		char *buf = kzalloc(sizeof(*buf) * str_obj->buffer.length, GFP_KERNEL);
+
+		result = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
+					 str_obj->buffer.length,
+					 UTF16_LITTLE_ENDIAN, buf,
+					 PAGE_SIZE - 1);
+		kfree(str_obj);
+		if (result > 0)
+			return buf;
+		/* if no result then free buf */
+		kfree(buf);
+	}
+
+	kfree(str_buf.pointer);
+
+use_name:
+	/* if _STR is missing then just use the device name */
+	status = acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &name_buf);
+	if (ACPI_SUCCESS(status) && name_buf.length > 0)
+		return name_buf.pointer;
+
+	kfree(name_buf.pointer);
+
+	return NULL;
+}
+
+static int galaxybook_acpi_method(struct samsung_galaxybook *galaxybook, acpi_string method,
+				  struct sawb *buf, u32 len, const char *purpose_str,
+				  struct sawb *ret)
+{
+	union acpi_object in_obj, *out_obj;
+	struct acpi_object_list input;
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_status status;
+
+	in_obj.type = ACPI_TYPE_BUFFER;
+	in_obj.buffer.length = len;
+	in_obj.buffer.pointer = (u8 *)buf;
+
+	input.count = 1;
+	input.pointer = &in_obj;
+
+	print_acpi_object_buffer_debug(purpose_str, in_obj.buffer.pointer, in_obj.buffer.length);
+
+	status = acpi_evaluate_object(galaxybook->acpi->handle, method, &input, &output);
+
+	if (ACPI_FAILURE(status)) {
+		pr_err("failed %s with ACPI method %s; got %s\n", purpose_str, method,
+		       acpi_format_exception(status));
+		return status;
+	}
+
+	out_obj = output.pointer;
+
+	if (out_obj->type != ACPI_TYPE_BUFFER) {
+		pr_err("failed %s with ACPI method %s; response was not a buffer\n",
+			purpose_str, method);
+		status = -EIO;
+		goto out_free;
+	}
+
+	print_acpi_object_buffer_debug("response was: ", out_obj->buffer.pointer,
+				       out_obj->buffer.length);
+
+	if (out_obj->buffer.length != len) {
+		pr_err("failed %s with ACPI method %s; response length mismatch\n",
+		       purpose_str, method);
+		status = -EIO;
+		goto out_free;
+	}
+	if (out_obj->buffer.length < SAWB_GUNM_POS + 1) {
+		pr_err("failed %s with ACPI method %s; response from device was too short\n",
+		       purpose_str, method);
+		status = -EIO;
+		goto out_free;
+	}
+	if (out_obj->buffer.pointer[SAWB_RFLG_POS] != RFLG_SUCCESS) {
+		pr_err("failed %s with ACPI method %s; "
+		       "device did not respond with success code 0x%x\n",
+		       purpose_str, method, RFLG_SUCCESS);
+		status = -EIO;
+		goto out_free;
+	}
+	if (out_obj->buffer.pointer[SAWB_GUNM_POS] == GUNM_FAIL) {
+		pr_err("failed %s with ACPI method %s; device responded with failure code 0x%x\n",
+		       purpose_str, method, GUNM_FAIL);
+		status = -EIO;
+		goto out_free;
+	}
+
+	memcpy(ret, out_obj->buffer.pointer, len);
+
+out_free:
+	kfree(output.pointer);
+	return status;
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
+	pr_debug_prefixed("set kbd_backlight brightness to %d\n", brightness);
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
+	pr_debug_prefixed("current kbd_backlight brightness is %d\n", buf.gunm);
+
+	return 0;
+}
+
+static int kbd_backlight_store(struct led_classdev *led,
+			       const enum led_brightness brightness)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(led, struct samsung_galaxybook, kbd_backlight);
+	int err;
+
+	err = kbd_backlight_acpi_set(galaxybook, brightness);
+	if (err)
+		return err;
+
+	return 0;
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
+	enum led_brightness brightness;
+	struct led_init_data init_data = {};
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
+	init_data.devicename = SAMSUNG_GALAXYBOOK_CLASS;
+	init_data.default_label = ":kbd_backlight";
+	init_data.devname_mandatory = true;
+
+	galaxybook->kbd_backlight = (struct led_classdev){
+		.brightness_get = kbd_backlight_show,
+		.brightness_set_blocking = kbd_backlight_store,
+		.flags = LED_BRIGHT_HW_CHANGED,
+		.max_brightness = KBD_BACKLIGHT_MAX_BRIGHTNESS,
+	};
+
+	pr_info("registering LED class using default name of %s:%s\n",
+		init_data.devicename, init_data.default_label);
+
+	return led_classdev_register_ext(&galaxybook->platform->dev, &galaxybook->kbd_backlight,
+					 &init_data);
+}
+
+static void galaxybook_kbd_backlight_exit(struct samsung_galaxybook *galaxybook)
+{
+	led_classdev_unregister(&galaxybook->kbd_backlight);
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
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_POWER_MANAGEMENT;
+	buf.gunm = GUNM_POWER_MANAGEMENT;
+	buf.guds[0] = GUDS_START_ON_LID_OPEN;
+	buf.guds[1] = GUDS_START_ON_LID_OPEN_SET;
+	buf.guds[2] = value;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "setting start_on_lid_open", &buf);
+	if (err)
+		return err;
+
+	pr_debug_prefixed("turned start_on_lid_open %s\n", value ? "on (1)" : "off (0)");
+
+	return 0;
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
+	pr_debug_prefixed("start_on_lid_open is currently %s\n",
+			  (buf.guds[1] ? "on (1)" : "off (0)"));
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
+	if (!count || kstrtobool(buffer, &value))
+		return -EINVAL;
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
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_USB_CHARGE_SET;
+	buf.gunm = value ? GUNM_USB_CHARGE_ON : GUNM_USB_CHARGE_OFF;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "setting usb_charge", &buf);
+	if (err)
+		return err;
+
+	pr_debug_prefixed("turned usb_charge %s\n", value ? "on (1)" : "off (0)");
+
+	return 0;
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
+	pr_debug_prefixed("usb_charge is currently %s\n", (buf.gunm ? "on (1)" : "off (0)"));
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
+	if (!count || kstrtobool(buffer, &value))
+		return -EINVAL;
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
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_ALLOW_RECORDING;
+	buf.gunm = GUNM_SET;
+	buf.guds[0] = value;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "setting allow_recording", &buf);
+	if (err)
+		return err;
+
+	pr_debug_prefixed("turned allow_recording %s\n", value ? "on (1)" : "off (0)");
+
+	return 0;
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
+	*value = buf.gunm;
+
+	pr_debug_prefixed("allow_recording is currently %s\n", (buf.gunm ? "on (1)" : "off (0)"));
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
+	if (!count || kstrtobool(buffer, &value))
+		return -EINVAL;
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
+/*
+ * Battery Extension (adds charge_control_end_threshold to the battery device)
+ */
+
+static int charge_control_end_threshold_acpi_set(struct samsung_galaxybook *galaxybook,
+						 const u8 value)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	if (value > 100)
+		return -EINVAL;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_POWER_MANAGEMENT;
+	buf.gunm = GUNM_POWER_MANAGEMENT;
+	buf.guds[0] = GUDS_BATTERY_CHARGE_CONTROL;
+	buf.guds[1] = GUDS_BATTERY_CHARGE_CONTROL_SET;
+
+	buf.guds[2] = (value == 100 ? 0 : value); /* if setting to 100, should be set to 0 (off) */
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_SETTINGS, &buf, SAWB_LEN_SETTINGS,
+				     "setting battery charge_control_end_threshold", &buf);
+	if (err)
+		return err;
+
+	pr_debug_prefixed("set battery charge_control_end_threshold to %d\n",
+			  (value == 100 ? 0 : value));
+
+	return 0;
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
+	pr_debug_prefixed("battery charge control is currently %s; "
+			  "battery charge_control_end_threshold is %d\n",
+			  (buf.guds[1] > 0 ? "on" : "off"), buf.guds[1]);
+
+	return 0;
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev, struct device_attribute *attr,
+						  const char *buffer, size_t count)
+{
+	u8 value;
+	int err;
+
+	if (!count || kstrtou8(buffer, 0, &value))
+		return -EINVAL;
+
+	err = charge_control_end_threshold_acpi_set(galaxybook_ptr, value);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev, struct device_attribute *attr,
+						 char *buffer)
+{
+	u8 value;
+	int err;
+
+	err = charge_control_end_threshold_acpi_get(galaxybook_ptr, &value);
+	if (err)
+		return err;
+
+	return sysfs_emit(buffer, "%d\n", value);
+}
+
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+
+static int galaxybook_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	if (device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold))
+		return -ENODEV;
+	return 0;
+}
+
+static int galaxybook_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
+{
+	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+	return 0;
+}
+
+static struct acpi_battery_hook galaxybook_battery_hook = {
+	.add_battery = galaxybook_battery_add,
+	.remove_battery = galaxybook_battery_remove,
+	.name = "Samsung Galaxy Book Battery Extension",
+};
+
+static int galaxybook_battery_threshold_init(struct samsung_galaxybook *galaxybook)
+{
+	u8 value;
+	int err;
+
+	err = charge_control_end_threshold_acpi_get(galaxybook, &value);
+	if (err)
+		return err;
+
+	battery_hook_register(&galaxybook_battery_hook);
+	return 0;
+}
+
+static void galaxybook_battery_threshold_exit(struct samsung_galaxybook *galaxybook)
+{
+	battery_hook_unregister(&galaxybook_battery_hook);
+}
+
+/*
+ * Fan speed
+ */
+
+static int fan_speed_get_fst(struct galaxybook_fan *fan, unsigned int *speed)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *response_obj = NULL;
+	acpi_status status;
+	int ret = 0;
+
+	status = acpi_evaluate_object(fan->fan.handle, "_FST", NULL, &response);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Get fan state failed\n");
+		return -ENODEV;
+	}
+
+	response_obj = response.pointer;
+	if (!response_obj || response_obj->type != ACPI_TYPE_PACKAGE ||
+	    response_obj->package.count != 3 ||
+	    response_obj->package.elements[2].type != ACPI_TYPE_INTEGER) {
+		pr_err("Invalid _FST data\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	*speed = response_obj->package.elements[2].integer.value;
+
+	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d\n",
+			  dev_name(&fan->fan.dev), fan->description, *speed);
+
+out_free:
+	ACPI_FREE(response.pointer);
+	return ret;
+}
+
+static int fan_speed_get_fans(struct galaxybook_fan *fan, unsigned int *speed)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *response_obj = NULL;
+	acpi_status status;
+	int ret = 0;
+	int speed_level = -1;
+
+	status = acpi_evaluate_object(NULL, ACPI_FAN_SPEED_VALUE, NULL, &response);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Get fan state failed\n");
+		return -ENODEV;
+	}
+
+	response_obj = response.pointer;
+	if (!response_obj || response_obj->type != ACPI_TYPE_INTEGER ||
+	    response_obj->integer.value > INT_MAX ||
+	    (int)response_obj->integer.value > fan->fan_speeds_count) {
+		pr_err("invalid fan speed data\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	speed_level = (int)response_obj->integer.value;
+	*speed = fan->fan_speeds[speed_level];
+
+	pr_debug_prefixed("fan device %s (%s) reporting fan speed of %d (level %d)\n",
+			  dev_name(&fan->fan.dev), fan->description, *speed, speed_level);
+
+out_free:
+	ACPI_FREE(response.pointer);
+	return ret;
+}
+
+static int fan_speed_get(struct galaxybook_fan *fan, unsigned int *speed)
+{
+	if (!fan)
+		return -ENODEV;
+	if (fan->supports_fst)
+		return fan_speed_get_fst(fan, speed);
+	else
+		return fan_speed_get_fans(fan, speed);
+}
+
+static ssize_t fan_speed_rpm_show(struct device *dev, struct device_attribute *attr, char *buffer)
+{
+	struct dev_ext_attribute *ea = container_of(attr, struct dev_ext_attribute, attr);
+	struct galaxybook_fan *fan = ea->var;
+	unsigned int speed;
+	int ret = 0;
+
+	if (!fan)
+		return -ENODEV;
+
+	ret = fan_speed_get(fan, &speed);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buffer, "%u\n", speed);
+}
+
+static int __init fan_speed_list_init(acpi_handle handle, struct galaxybook_fan *fan)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *response_obj = NULL;
+	acpi_status status;
+	unsigned int speed;
+	int i;
+
+	status = acpi_evaluate_object(handle, ACPI_FAN_SPEED_LIST, NULL, &response);
+	if (ACPI_FAILURE(status)) {
+		pr_err("failed to read fan speed list\n");
+		return -ENODEV;
+	}
+
+	response_obj = response.pointer;
+	if (!response_obj || response_obj->type != ACPI_TYPE_PACKAGE ||
+	    response_obj->package.count == 0) {
+		pr_err("invalid fan speed list data\n");
+		status = -EINVAL;
+		goto out_free;
+	}
+
+	/*
+	 * fan_speeds[] starts with a hard-coded 0 (fan is off), then has some "funny" logic:
+	 *  - fetch the speed level values read in from FANT and add 0x0a to each value
+	 *  - _FST method in the DSDT seems to indicate that level 3 and 4 should have same value,
+	 *    however real-life observation suggests that the speed actually does change
+	 *  - _FST says that level 5 should give the 4th value from FANT but it seems significantly
+	 *    louder -- we will just "guess" it is 1000 RPM faster than the highest value from FANT?
+	 */
+
+	fan->fan_speeds = kzalloc(sizeof(unsigned int) * (response_obj->package.count + 2),
+				  GFP_KERNEL);
+	if (!fan->fan_speeds)
+		return -ENOMEM;
+
+	/* hard-coded "off" value (0) */
+	fan->fan_speeds[0] = 0;
+	fan->fan_speeds_count = 1;
+
+	/* fetch and assign the next values from FANT response */
+	i = 0;
+	for (i = 1; i <= response_obj->package.count; i++) {
+		if (response_obj->package.elements[i - 1].type != ACPI_TYPE_INTEGER) {
+			pr_err("invalid fan speed list value at position %d; "
+			       "expected type %d, got type %d\n",
+			       i - 1, ACPI_TYPE_INTEGER,
+			       response_obj->package.elements[i - 1].type);
+			status = -EINVAL;
+			goto err_fan_speeds_free;
+		}
+		fan->fan_speeds[i] = response_obj->package.elements[i - 1].integer.value + 0x0a;
+		fan->fan_speeds_count++;
+	}
+
+	/* add the missing final level where we "guess" 1000 RPM faster than highest from FANT */
+	if (fan->fan_speeds_count > 1) {
+		fan->fan_speeds[i] = fan->fan_speeds[i - 1] + 1000;
+		fan->fan_speeds_count++;
+	}
+
+	/* test that it actually works to read the speed, otherwise the init should fail */
+	status = fan_speed_get_fans(fan, &speed);
+	if (ACPI_FAILURE(status)) {
+		pr_err("failed to read fan speed level from FANS\n");
+		goto err_fan_speeds_free;
+	}
+
+	pr_info("initialized fan speed reporting for device %s (%s) with the following levels:\n",
+		dev_name(&fan->fan.dev), fan->description);
+	for (i = 0; i < fan->fan_speeds_count; i++)
+		pr_info("  %s (%s) fan speed level %d = %d\n",
+			dev_name(&fan->fan.dev), fan->description, i, fan->fan_speeds[i]);
+
+out_free:
+	ACPI_FREE(response.pointer);
+	return status;
+
+err_fan_speeds_free:
+	kfree(fan->fan_speeds);
+	goto out_free;
+}
+
+static acpi_status galaxybook_add_fan(acpi_handle handle, u32 level, void *context,
+				      void **return_value)
+{
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	struct samsung_galaxybook *galaxybook = context;
+	struct galaxybook_fan *fan;
+	int speed = -1;
+
+	pr_info("found fan device %s\n", dev_name(&adev->dev));
+
+	/* if fan meets acpi4 fan device requirements, assume it is added already under ACPI */
+	if (acpi_has_method(handle, "_FIF") &&
+	    acpi_has_method(handle, "_FPS") &&
+	    acpi_has_method(handle, "_FSL") &&
+	    acpi_has_method(handle, "_FST")) {
+		pr_info("fan device %s should already be available as an ACPI fan; skipping\n",
+			dev_name(&adev->dev));
+		return 0;
+	}
+
+	if (galaxybook->fans_count >= MAX_FAN_COUNT) {
+		pr_err("maximum number of %d fans has already been reached\n", MAX_FAN_COUNT);
+		return 0;
+	}
+
+	fan = &galaxybook->fans[galaxybook->fans_count];
+	fan->fan = *adev;
+	fan->description = get_acpi_device_description(&fan->fan);
+
+	/* try to get speed from _FST */
+	if (ACPI_FAILURE(fan_speed_get_fst(fan, &speed))) {
+		pr_debug_prefixed("_FST is present but failed on fan device %s (%s); "
+				  "will attempt to add fan speed support using FANT and FANS\n",
+				  dev_name(&fan->fan.dev), fan->description);
+		fan->supports_fst = false;
+	}
+	/* if speed was 0 and FANT and FANS exist, they should be used anyway due to bugs in ACPI */
+	else if (speed <= 0 &&
+		 acpi_has_method(handle, ACPI_FAN_SPEED_LIST) &&
+		 acpi_has_method(NULL, ACPI_FAN_SPEED_VALUE)) {
+		pr_debug_prefixed("_FST is present on fan device %s (%s) but returned value of 0; "
+				  "will attempt to add fan speed support using FANT and FANS\n",
+				  dev_name(&fan->fan.dev), fan->description);
+		fan->supports_fst = false;
+	} else {
+		fan->supports_fst = true;
+	}
+
+	if (!fan->supports_fst) {
+		/* since FANS is a field on the EC, it does not make sense to use more than once */
+		for (int i = 0; i < galaxybook->fans_count; i++) {
+			if (!galaxybook->fans[i].supports_fst) {
+				pr_err("more than one fan using FANS is not supported\n");
+				return 0;
+			}
+		}
+		if (ACPI_FAILURE(fan_speed_list_init(handle, fan))) {
+			pr_err("unable to initialize fan speeds for fan device %s (%s)\n",
+			       dev_name(&fan->fan.dev), fan->description);
+			return 0;
+		}
+	} else {
+		pr_info("initialized fan speed reporting for device %s (%s) using method _FST\n",
+			dev_name(&fan->fan.dev), fan->description);
+	}
+
+	/* set up RO dev_ext_attribute */
+	fan->fan_speed_rpm_ext_attr.attr.attr.name = "fan_speed_rpm";
+	fan->fan_speed_rpm_ext_attr.attr.attr.mode = 0444;
+	fan->fan_speed_rpm_ext_attr.attr.show = fan_speed_rpm_show;
+	/* extended attribute var points to this galaxybook_fan so it can used in the show method */
+	fan->fan_speed_rpm_ext_attr.var = fan;
+
+	if (sysfs_create_file(&adev->dev.kobj, &fan->fan_speed_rpm_ext_attr.attr.attr))
+		pr_err("unable to create fan_speed_rpm attribute for fan device %s (%s)\n",
+		       dev_name(&fan->fan.dev), fan->description);
+
+	galaxybook->fans_count++;
+
+	return 0;
+}
+
+static int __init galaxybook_fan_speed_init(struct samsung_galaxybook *galaxybook)
+{
+	acpi_status status;
+
+	/* get and set up all fans matching ACPI_FAN_DEVICE_ID */
+	status = acpi_get_devices(ACPI_FAN_DEVICE_ID, galaxybook_add_fan, galaxybook, NULL);
+
+	if (galaxybook->fans_count == 0)
+		return -ENODEV;
+
+	return status;
+}
+
+static void galaxybook_fan_speed_exit(struct samsung_galaxybook *galaxybook)
+{
+	for (int i = 0; i < galaxybook->fans_count; i++)
+		sysfs_remove_file(&galaxybook->fans[i].fan.dev.kobj,
+				  &galaxybook->fans[i].fan_speed_rpm_ext_attr.attr.attr);
+}
+
+/*
+ * Hwmon device
+ */
+
+#if IS_ENABLED(CONFIG_HWMON)
+static umode_t galaxybook_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		if (channel < galaxybook_ptr->fans_count &&
+		    (attr == hwmon_fan_input || attr == hwmon_fan_label))
+			return 0444;
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static int galaxybook_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+				 u32 attr, int channel, long *val)
+{
+	unsigned int speed;
+
+	switch (type) {
+	case hwmon_fan:
+		if (channel < galaxybook_ptr->fans_count && attr == hwmon_fan_input) {
+			if (fan_speed_get(&galaxybook_ptr->fans[channel], &speed))
+				return -EIO;
+			*val = speed;
+			return 0;
+		}
+		return -EOPNOTSUPP;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int galaxybook_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+					u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_fan:
+		if (channel < galaxybook_ptr->fans_count && attr == hwmon_fan_label) {
+			*str = galaxybook_ptr->fans[channel].description;
+			return 0;
+		}
+		return -EOPNOTSUPP;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops galaxybook_hwmon_ops = {
+	.is_visible = galaxybook_hwmon_is_visible,
+	.read = galaxybook_hwmon_read,
+	.read_string = galaxybook_hwmon_read_string,
+};
+
+static const struct hwmon_channel_info *const galaxybook_hwmon_info[] = {
+	/* note: number of max possible fan channel entries here should match MAX_FAN_COUNT */
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info galaxybook_hwmon_chip_info = {
+	.ops = &galaxybook_hwmon_ops,
+	.info = galaxybook_hwmon_info,
+};
+
+static int galaxybook_hwmon_init(struct samsung_galaxybook *galaxybook)
+{
+	int ret = 0;
+
+	char *hwmon_device_name = devm_hwmon_sanitize_name(&galaxybook->platform->dev,
+							   SAMSUNG_GALAXYBOOK_CLASS);
+
+	galaxybook->hwmon = devm_hwmon_device_register_with_info(
+		&galaxybook->platform->dev, hwmon_device_name, NULL,
+		&galaxybook_hwmon_chip_info, NULL);
+	if (PTR_ERR_OR_ZERO(galaxybook->hwmon)) {
+		ret = PTR_ERR(galaxybook->hwmon);
+		galaxybook->hwmon = NULL;
+	}
+
+	return ret;
+}
+
+static void galaxybook_hwmon_exit(struct samsung_galaxybook *galaxybook)
+{
+	if (galaxybook->hwmon)
+		hwmon_device_unregister(galaxybook->hwmon);
+}
+#endif
+
+/*
+ * Platform Profile / Performance mode
+ */
+
+static int performance_mode_acpi_set(struct samsung_galaxybook *galaxybook,
+				     const u8 performance_mode)
+{
+	struct sawb buf = { 0 };
+	int err;
+
+	buf.safn = SAFN;
+	buf.sasb = SASB_PERFORMANCE_MODE;
+	export_guid(buf.caid, &PERFORMANCE_MODE_GUID);
+	buf.fncn = FNCN_PERFORMANCE_MODE;
+	buf.subn = SUBN_PERFORMANCE_MODE_SET;
+	buf.iob0 = performance_mode;
+
+	err = galaxybook_acpi_method(galaxybook, ACPI_METHOD_PERFORMANCE_MODE, &buf,
+				     SAWB_LEN_PERFORMANCE_MODE, "setting performance_mode", &buf);
+	if (err)
+		return err;
+
+	return 0;
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
+static enum platform_profile_option
+profile_performance_mode(struct samsung_galaxybook *galaxybook, const u8 performance_mode)
+{
+	for (int i = 0; i < PLATFORM_PROFILE_LAST; i++)
+		if (galaxybook->profile_performance_modes[i] == performance_mode)
+			return i;
+	return -1;
+}
+
+/* copied from platform_profile.c; better if this could be fetched from a public function, maybe? */
+static const char *const profile_names[] = {
+	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
+	[PLATFORM_PROFILE_COOL] = "cool",
+	[PLATFORM_PROFILE_QUIET] = "quiet",
+	[PLATFORM_PROFILE_BALANCED] = "balanced",
+	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
+	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+};
+static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
+
+static int galaxybook_platform_profile_set(struct platform_profile_handler *pprof,
+					   enum platform_profile_option profile)
+{
+	struct samsung_galaxybook *galaxybook =
+		container_of(pprof, struct samsung_galaxybook, profile_handler);
+	int err;
+
+	err = performance_mode_acpi_set(galaxybook, galaxybook->profile_performance_modes[profile]);
+	if (err)
+		return err;
+
+	pr_debug_prefixed("set platform profile to '%s' (performance mode 0x%x)\n",
+			  profile_names[profile], galaxybook->profile_performance_modes[profile]);
+	return 0;
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
+	*profile = profile_performance_mode(galaxybook, performance_mode);
+	if (*profile == -1)
+		return -EINVAL;
+
+	pr_debug_prefixed("platform profile is currently '%s' (performance mode 0x%x)\n",
+			  profile_names[*profile], performance_mode);
+
+	return 0;
+}
+
+#define IGNORE_PERFORMANCE_MODE_MAPPING  -1
+
+static int galaxybook_profile_init(struct samsung_galaxybook *galaxybook)
+{
+	struct sawb buf = { 0 };
+	int mode_profile, err;
+	u8 current_performance_mode;
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
+		kzalloc(sizeof(u8) * PLATFORM_PROFILE_LAST, GFP_KERNEL);
+	if (!galaxybook->profile_performance_modes)
+		return -ENOMEM;
+	for (int i = 0; i < PLATFORM_PROFILE_LAST; i++)
+		galaxybook->profile_performance_modes[i] = PERFORMANCE_MODE_UNKNOWN;
+
+	/*
+	 * Value returned in iob0 will have the number of supported performance modes.
+	 * The performance mode values will then be given as a list after this (iob1-iobX).
+	 * Loop backwards from last value to first value (to handle fallback cases which come with
+	 * smaller values) and map each supported value to its correct platform_profile_option.
+	 */
+	err = -ENODEV; /* set err to "no device" to signal that we have not yet mapped profiles */
+	for (int i = buf.iob0; i > 0; i--) {
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
+		if (mode_profile > IGNORE_PERFORMANCE_MODE_MAPPING) {
+			err = 0; /* clear err to signal that at least one profile is now mapped */
+			galaxybook->profile_performance_modes[mode_profile] = buf.iob_values[i];
+			set_bit(mode_profile, galaxybook->profile_handler.choices);
+			pr_info("will support platform profile '%s' (performance mode 0x%x)\n",
+				profile_names[mode_profile], buf.iob_values[i]);
+		} else {
+			pr_debug_prefixed("unmapped performance mode 0x%x will be ignored\n",
+					  buf.iob_values[i]);
+		}
+	}
+
+	/* if no performance modes were mapped (err is still -ENODEV) then stop and fail here */
+	if (err)
+		return err;
+
+	err = platform_profile_register(&galaxybook->profile_handler);
+	if (err)
+		return err;
+
+	/* now check currently set performance mode; if not supported then set default profile */
+	err = performance_mode_acpi_get(galaxybook, &current_performance_mode);
+	if (err)
+		pr_warn("failed with code %d when fetching initial performance mode\n", err);
+	if (profile_performance_mode(galaxybook, current_performance_mode) == -1) {
+		pr_debug_prefixed("initial performance mode value is not supported by device; "
+				  "setting to default\n");
+		err = galaxybook_platform_profile_set(&galaxybook->profile_handler,
+						      DEFAULT_PLATFORM_PROFILE);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void galaxybook_profile_exit(struct samsung_galaxybook *galaxybook)
+{
+	platform_profile_remove();
+}
+
+/*
+ * Hotkey work and filters
+ */
+
+static void galaxybook_performance_mode_hotkey_work(struct work_struct *work)
+{
+	platform_profile_cycle();
+}
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
+/*
+ * Input device (hotkeys and notifications)
+ */
+
+static void galaxybook_input_notify(struct samsung_galaxybook *galaxybook, int event)
+{
+	if (!galaxybook->input)
+		return;
+	pr_debug_prefixed("input notification event: 0x%x\n", event);
+	if (!sparse_keymap_report_event(galaxybook->input, event, 1, true))
+		pr_warn("unknown input notification event: 0x%x\n", event);
+}
+
+static int galaxybook_input_init(struct samsung_galaxybook *galaxybook)
+{
+	struct input_dev *input;
+	int error;
+
+	input = input_allocate_device();
+	if (!input)
+		return -ENOMEM;
+
+	input->name = "Samsung Galaxy Book Extra Buttons";
+	input->phys = SAMSUNG_GALAXYBOOK_CLASS "/input0";
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &galaxybook->platform->dev;
+
+	error = sparse_keymap_setup(input, galaxybook_acpi_keymap, NULL);
+	if (error) {
+		pr_err("Unable to setup input device keymap\n");
+		goto err_free_dev;
+	}
+	error = input_register_device(input);
+	if (error) {
+		pr_err("Unable to register input device\n");
+		goto err_free_dev;
+	}
+
+	galaxybook->input = input;
+	return 0;
+
+err_free_dev:
+	input_free_device(input);
+	return error;
+}
+
+static void galaxybook_input_exit(struct samsung_galaxybook *galaxybook)
+{
+	if (galaxybook->input)
+		input_unregister_device(galaxybook->input);
+	galaxybook->input = NULL;
+}
+
+/*
+ * Platform device attributes
+ */
+
+/* galaxybook_attrs can include start_on_lid_open, usb_charge, and/or allow_recording */
+#define MAX_NUM_DEVICE_ATTRIBUTES 3
+
+static struct attribute *galaxybook_attrs[MAX_NUM_DEVICE_ATTRIBUTES + 1] = { NULL };
+static const struct attribute_group galaxybook_attrs_group = {
+	.attrs = galaxybook_attrs,
+};
+
+static int galaxybook_device_attrs_init(struct samsung_galaxybook *galaxybook)
+{
+	bool value;
+	int err;
+	int i = 0;
+
+	/* attempt to get each attribute's value and add them if the get does not fail */
+
+	err = start_on_lid_open_acpi_get(galaxybook, &value);
+	if (err)
+		pr_debug_prefixed("failed to get start_on_lid_open value; "
+				  "this feature will not be enabled\n");
+	else
+		galaxybook_attrs[i++] = &dev_attr_start_on_lid_open.attr;
+
+	err = usb_charge_acpi_get(galaxybook, &value);
+	if (err)
+		pr_debug_prefixed("failed to get usb_charge value; "
+				  "this feature will not be enabled\n");
+	else
+		galaxybook_attrs[i++] = &dev_attr_usb_charge.attr;
+
+	if (allow_recording) {
+		pr_debug_prefixed("initializing ACPI allow_recording feature\n");
+		err = galaxybook_enable_acpi_feature(galaxybook, SASB_ALLOW_RECORDING);
+		if (err) {
+			pr_debug_prefixed("failed to initialize ACPI allow_recording feature\n");
+			allow_recording = false;
+			return 0;
+		}
+
+		err = allow_recording_acpi_get(galaxybook, &value);
+		if (err) {
+			pr_debug_prefixed("failed to get allow_recording value; "
+					  "this feature will not be enabled\n");
+			allow_recording = false;
+		} else {
+			galaxybook_attrs[i++] = &dev_attr_allow_recording.attr;
+		}
+	}
+
+	return device_add_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
+};
+
+static void galaxybook_device_attrs_exit(struct samsung_galaxybook *galaxybook)
+{
+	device_remove_group(&galaxybook->platform->dev, &galaxybook_attrs_group);
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
+		pr_debug_prefixed("hotkey: performance_mode keydown\n");
+		if (performance_mode) {
+			schedule_work(&galaxybook->performance_mode_hotkey_work);
+			return;
+		}
+	}
+
+	galaxybook_input_notify(galaxybook, event);
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
+static int galaxybook_acpi_init(struct samsung_galaxybook *galaxybook)
+{
+	return acpi_execute_simple_method(galaxybook->acpi->handle,
+					  ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_ON);
+}
+
+static void galaxybook_acpi_exit(struct samsung_galaxybook *galaxybook)
+{
+	acpi_execute_simple_method(galaxybook->acpi->handle,
+				   ACPI_METHOD_ENABLE, ACPI_METHOD_ENABLE_OFF);
+}
+
+/*
+ * Platform driver
+ */
+
+static int galaxybook_probe(struct platform_device *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct samsung_galaxybook *galaxybook;
+	acpi_status status;
+	int err;
+
+	dmi_check_system(galaxybook_dmi_ids);
+
+	pr_info("found matched device %s; loading driver\n", dev_name(&adev->dev));
+
+	galaxybook = kzalloc(sizeof(struct samsung_galaxybook), GFP_KERNEL);
+	if (!galaxybook)
+		return -ENOMEM;
+	/* set static pointer here so it can be used in various methods for hotkeys, hwmon, etc */
+	galaxybook_ptr = galaxybook;
+
+	galaxybook->platform = pdev;
+	galaxybook->acpi = adev;
+
+	dev_set_drvdata(&galaxybook->platform->dev, galaxybook);
+
+	pr_debug_prefixed("initializing ACPI device\n");
+	err = galaxybook_acpi_init(galaxybook);
+	if (err) {
+		pr_err("failed to initialize the ACPI device\n");
+		goto err_free;
+	}
+
+	pr_debug_prefixed("initializing ACPI power management features\n");
+	err = galaxybook_enable_acpi_feature(galaxybook, SASB_POWER_MANAGEMENT);
+	if (err) {
+		pr_warn("failed to initialize ACPI power management features; "
+			"many features of this driver will not be available\n");
+		performance_mode = false;
+		battery_threshold = false;
+	}
+
+	if (performance_mode) {
+		pr_debug_prefixed("initializing performance mode and platform profile\n");
+		err = galaxybook_profile_init(galaxybook);
+		if (err) {
+			pr_debug_prefixed(
+				"failed to initialize performance mode and platform profile\n");
+			performance_mode = false;
+		}
+	} else {
+		pr_debug_prefixed("performance_mode is disabled\n");
+	}
+
+	if (battery_threshold) {
+		pr_debug_prefixed("initializing battery charge threshold control\n");
+		err = galaxybook_battery_threshold_init(galaxybook);
+		if (err) {
+			pr_debug_prefixed(
+				"failed to initialize battery charge threshold control\n");
+			battery_threshold = false;
+		}
+	} else {
+		pr_debug_prefixed("battery_threshold is disabled\n");
+	}
+
+	pr_debug_prefixed("adding platform device attributes\n");
+	err = galaxybook_device_attrs_init(galaxybook);
+	if (err)
+		pr_err("failed to add platform device attributes\n");
+
+	if (kbd_backlight) {
+		pr_debug_prefixed("initializing kbd_backlight\n");
+		err = galaxybook_kbd_backlight_init(galaxybook);
+		if (err) {
+			pr_debug_prefixed("failed to initialize kbd_backlight\n");
+			kbd_backlight = false;
+		}
+	} else {
+		pr_debug_prefixed("kbd_backlight is disabled\n");
+	}
+
+	if (fan_speed) {
+		pr_debug_prefixed("initializing fan speed\n");
+		err = galaxybook_fan_speed_init(galaxybook);
+		if (err) {
+			pr_debug_prefixed("failed to initialize fan speed\n");
+			fan_speed = false;
+		} else {
+#if IS_ENABLED(CONFIG_HWMON)
+			pr_debug_prefixed("initializing hwmon device\n");
+			err = galaxybook_hwmon_init(galaxybook);
+			if (err)
+				pr_warn("failed to initialize hwmon device\n");
+#endif
+		}
+	} else {
+		pr_debug_prefixed("fan_speed is disabled\n");
+	}
+
+	/* i8042_filter should be disabled if kbd_backlight and allow_recording are disabled */
+	if (!kbd_backlight && !allow_recording)
+		i8042_filter = false;
+
+	if (i8042_filter) {
+		pr_debug_prefixed("installing i8402 key filter to capture hotkey input\n");
+
+		/* initialize hotkey work queues */
+		if (kbd_backlight)
+			INIT_WORK(&galaxybook->kbd_backlight_hotkey_work,
+				  galaxybook_kbd_backlight_hotkey_work);
+		if (allow_recording)
+			INIT_WORK(&galaxybook->allow_recording_hotkey_work,
+				  galaxybook_allow_recording_hotkey_work);
+
+		err = i8042_install_filter(galaxybook_i8042_filter);
+		if (err) {
+			pr_err("failed to install i8402 key filter\n");
+			cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
+			cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
+			i8042_filter = false;
+		}
+	} else {
+		pr_debug_prefixed("i8042_filter is disabled\n");
+	}
+
+	pr_debug_prefixed("installing ACPI notify handler\n");
+	status = acpi_install_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
+					     galaxybook_acpi_notify, galaxybook);
+	if (ACPI_SUCCESS(status)) {
+		pr_debug_prefixed("enabling ACPI notifications\n");
+		err = galaxybook_enable_acpi_notify(galaxybook);
+		if (err) {
+			pr_warn("failed to enable ACPI notifications; "
+				"some hotkeys will not be supported\n");
+		} else {
+			/* initialize ACPI hotkey work queues */
+			INIT_WORK(&galaxybook->performance_mode_hotkey_work,
+				  galaxybook_performance_mode_hotkey_work);
+
+			pr_debug_prefixed("initializing input device\n");
+			err = galaxybook_input_init(galaxybook);
+			if (err) {
+				pr_err("failed to initialize input device\n");
+				cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
+				galaxybook_input_exit(galaxybook);
+			}
+		}
+	} else {
+		pr_debug_prefixed("failed to install ACPI notify handler\n");
+	}
+
+	pr_info("driver successfully loaded\n");
+
+	return 0;
+
+err_free:
+	kfree(galaxybook);
+	return err;
+}
+
+static void galaxybook_remove(struct platform_device *pdev)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(&pdev->dev);
+
+	pr_info("removing driver\n");
+
+	galaxybook_device_attrs_exit(galaxybook);
+
+	galaxybook_input_exit(galaxybook);
+	cancel_work_sync(&galaxybook->performance_mode_hotkey_work);
+
+	if (i8042_filter) {
+		i8042_remove_filter(galaxybook_i8042_filter);
+		cancel_work_sync(&galaxybook->kbd_backlight_hotkey_work);
+		cancel_work_sync(&galaxybook->allow_recording_hotkey_work);
+	}
+
+	acpi_remove_notify_handler(galaxybook->acpi->handle, ACPI_ALL_NOTIFY,
+				   galaxybook_acpi_notify);
+
+	if (fan_speed) {
+		galaxybook_fan_speed_exit(galaxybook);
+#if IS_ENABLED(CONFIG_HWMON)
+		galaxybook_hwmon_exit(galaxybook);
+#endif
+	}
+
+	if (kbd_backlight)
+		galaxybook_kbd_backlight_exit(galaxybook);
+
+	if (battery_threshold)
+		galaxybook_battery_threshold_exit(galaxybook);
+
+	if (performance_mode)
+		galaxybook_profile_exit(galaxybook);
+
+	galaxybook_acpi_exit(galaxybook);
+
+	if (galaxybook_ptr)
+		galaxybook_ptr = NULL;
+
+	kfree(galaxybook);
+
+	pr_info("driver successfully removed\n");
+}
+
+static struct platform_driver galaxybook_platform_driver = {
+	.driver = {
+		.name = SAMSUNG_GALAXYBOOK_CLASS,
+		.acpi_match_table = galaxybook_device_ids,
+	},
+	.probe = galaxybook_probe,
+	.remove = galaxybook_remove,
+};
+
+static int __init samsung_galaxybook_init(void)
+{
+	return platform_driver_register(&galaxybook_platform_driver);
+}
+
+static void __exit samsung_galaxybook_exit(void)
+{
+	platform_driver_unregister(&galaxybook_platform_driver);
+}
+
+module_init(samsung_galaxybook_init);
+module_exit(samsung_galaxybook_exit);
+
+MODULE_AUTHOR("Joshua Grisham <josh@joshuagrisham.com>");
+MODULE_DESCRIPTION(SAMSUNG_GALAXYBOOK_NAME);
+MODULE_LICENSE("GPL");
-- 
2.45.2


