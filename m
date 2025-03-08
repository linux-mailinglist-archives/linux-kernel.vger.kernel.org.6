Return-Path: <linux-kernel+bounces-552792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C57A57E22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C981188C8A1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF1A215F61;
	Sat,  8 Mar 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux3IVU9K"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4620F07F;
	Sat,  8 Mar 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465452; cv=none; b=EiZNXNf2scR99JPYSIqXbvn0/0adluwf5MtYHCMsOIYZBoyBgfJOZiGgMHFFnLCAc3h12aE3y+2FrCOs90s2y45v0m3fXKggjf9jqXzTricX7zY9T5wqHj9bHEemL4pwtv0DiDO3Y6npSTQbW++i2MoEruKfnrPKuBdBnbQDfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465452; c=relaxed/simple;
	bh=MoPrepwlxFP7fxNo2DLCr3NelEfkZ6jBFL4xdaXEdkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbFTvt1YdRr2tzco20tW4/FCWDmB69WRXco3mXi89f2GF76u5bAlFHyIfsxu3+MRhAh5hHGFP95GipbQCFoGntKyeUc7y3t1c8GmFH7I1VbHHo3iFqYIwIp2SWzhCvRQopGkN078S5VPQbkbA3+cBIgnR0XLq0/VkBhqya0nq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux3IVU9K; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so1212699241.2;
        Sat, 08 Mar 2025 12:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465448; x=1742070248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxF8GLhZE/ZzjWGUIeAK3xtzKENLRNdEpz9w1JFOH84=;
        b=Ux3IVU9KseyXxSr8HKjOsSLw/Xt4sNxfOUw8YxMxw9OMo7pIWZW41YxhVu4a2V+jcv
         R4z4Pnw/pkAMV3JiYRwFQxrxgVy59g0GA9t53lIB2NjKzD43bnygsCC0zUKlQMixgG1u
         5dDe6G51KxzNtZr8Ee6n9V2HvypokkPWghbqwmQiWtkAXv1gt/PcGhk0/OtiUCcAxvV2
         W0APERBDglfyRLlMITipp39DjJ/PwRhSOZerKdMl0LxrdLdvwgWlyKXUdrjvx386rjr3
         BdGDH9lH7pI59qHkWUwr1HdQh3EpsJ1eLAHaQJUpu8Vt/X5NwIELVfB38XAQlryDH/So
         Dqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465448; x=1742070248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxF8GLhZE/ZzjWGUIeAK3xtzKENLRNdEpz9w1JFOH84=;
        b=ZbQVdGBvME6Rwvs5Fdt7Q1/jSibJ85J2ZAJFxmMoswa7JlF/4ZVl96JH53NQrBQ9A6
         4w07438S2DB+eSpsVz67ozna5AJ2PqGW6k546TiPaNT8Em+navnCFJBegAe0zGppMJZ9
         owDG/xhehwpVcvFn0nk2innaW/wUOvY/uLgWYoFHU2u7WcygfWju3VzvT1zXUm7x4T1J
         usjnWD4KE1cK5EfqPsdxSXCK0bsOWu5FuTxRSu0CSa9jCgD9FZYdOaoQLpz8l8Cm/8/s
         UH3oIynXkmpS8g2QlLC9jvsWuRCaKldyBSAbUeqygxbr+fdCKFevl4xaCFowq6/Nipxj
         7mmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/pA0cL3orx1ydDwW7Cz2AGkg+UGVGCu+5rI/BkGQ1vrUkxOQqJgOY5lUaTNgh5nxtbpsLOtqFq85gUwzst4Ib7vdI/g==@vger.kernel.org, AJvYcCUqpFDsi5jOnX3kWsqWh6mhXounKC3zg3Ukvfps64sGCQ9sA/F1clWmS6mAlURRUj9Pk9Ynb2q6NvCmXKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV78HRzRJpVYAIuYT2utIJvjrE9h77laglUMMT8vW6W/29M1Ou
	2HwGEV8AVM5yp8tULjkRFc7Wsw5KMjck3yiTBNrVJBbsNmpnYzEXUZn5Eeal
X-Gm-Gg: ASbGncvf+Uz9EFVHh0fZFcrASRdSiREBpwYJpdaJXbLfKEf7xGksNJ06Y/job4qNZKK
	RrnfCOYIDjDIQCjGq/RsFiWzhXWcUs7gsWQjp/SJ2fxwU/Jehsdls9aGxJ6jkpy847h4VeFhAs8
	0UVKTJ0p46d1bhXzmG8zJiRDF7T2ToCRFTtfiDBr6oIJiS7TsKAWn3n5NQ121fxdHst1/ccLaC7
	nx9hwFKQGjo8bqgEC3aiTO8Upyv6/Qb5PQR4unj8LLednB7t+CTOjXUGyL142ZUeuOMLa5lZGAY
	sNYd5yh40YBHAl0fcSXcwP4otEF51mVMJ86gm53BtHn8xw==
X-Google-Smtp-Source: AGHT+IFK2mD2IHi0uBizwggdYKuNDNbiZBkIQfBP8NEpOvWNB3OKqc8VEeBS49AergoeRP5WDz4HMQ==
X-Received: by 2002:a05:6102:578f:b0:4bb:e8c5:b172 with SMTP id ada2fe7eead31-4c30a5e4f1fmr6342854137.8.1741465448013;
        Sat, 08 Mar 2025 12:24:08 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:24:07 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:23 -0500
Subject: [PATCH v4 11/12] Documentation: admin-guide: laptops: Add
 documentation for alienware-wmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-11-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add driver admin-guide documentation for the alienware-wmi driver.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../admin-guide/laptops/alienware-wmi.rst          | 128 +++++++++++++++++++++
 Documentation/admin-guide/laptops/index.rst        |   1 +
 MAINTAINERS                                        |   1 +
 3 files changed, 130 insertions(+)

diff --git a/Documentation/admin-guide/laptops/alienware-wmi.rst b/Documentation/admin-guide/laptops/alienware-wmi.rst
new file mode 100644
index 0000000000000000000000000000000000000000..fa3980de77fa457ea431b20c5131d7c59a836419
--- /dev/null
+++ b/Documentation/admin-guide/laptops/alienware-wmi.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================
+Alienware WMI Driver
+====================
+
+Kurt Borja <kuurtb@gmail.com>
+
+This is a driver for the "WMAX" WMI device, which is found in most Dell gaming
+laptops and controls various special features.
+
+Before the launch of M-Series laptops (~2018), the "WMAX" device controlled
+basic RGB lighting, deep sleep mode, HDMI mode and amplifier status.
+
+Later, this device was completely repurpused. Now it mostly deals with thermal
+profiles, sensor monitoring and overclocking. This interface is named "AWCC" and
+is known to be used by the AWCC OEM application to control these features.
+
+The alienware-wmi driver controls both interfaces.
+
+AWCC Interface
+==============
+
+WMI device Documentation: Documentation/wmi/devices/alienware-wmi.rst
+
+Supported devices
+-----------------
+
+- Alienware M-Series laptops
+- Alienware X-Series laptops
+- Alienware Aurora Desktops
+- Dell G-Series laptops
+
+If you believe your device supports the AWCC interface and you don't have any of
+the features described in this document, try the following alienware-wmi module
+parameters:
+
+- ``force_platform_profile=1``: Forces probing for platform profile support
+- ``force_hwmon=1``: Forces probing for HWMON support
+
+If the module loads successfully with these parameters, consider submitting a
+patch adding your model to the ``awcc_dmi_table`` located in
+``drivers/platform/x86/dell/alienware-wmi-wmax.c`` or contacting the maintainer
+for further guidance.
+
+Status
+------
+
+The following features are currently supported:
+
+- :ref:`Platform Profile <platform-profile>`:
+
+  - Thermal profile control
+
+  - G-Mode toggling
+
+- :ref:`HWMON <hwmon>`:
+
+  - Sensor monitoring
+
+  - Manual fan control
+
+.. _platform-profile:
+
+Platform Profile
+----------------
+
+The AWCC interface exposes various firmware defined thermal profiles. We expose
+these profiles to user-space through the Platform Profile class interface.
+Refer to
+:ref:`sysfs-class-platform-profile <abi_file_testing_sysfs_class_platform_profile>`
+for more information.
+
+The name of the platform-profile class device exported by this driver is
+"alienware-wmi" and it's path can be found with:
+
+::
+
+ grep -l "alienware-wmi" /sys/class/platform-profile/platform-profile-*/name | sed 's|/[^/]*$||'
+
+If the device supports G-Mode, it is also toggled when selecting the
+``performance`` profile.
+
+.. note::
+   You may set the ``force_gmode`` module parameter to always try to toggle this
+   feature, without checking if your model supports it.
+
+.. _hwmon:
+
+HWMON
+-----
+
+The AWCC interface also supports sensor monitoring and manual fan control. Both
+of these features are exposed to user-space through the HWMON interface.
+
+The name of the hwmon class device exported by this driver is "alienware_wmi"
+and it's path can be found with:
+
+::
+
+ grep -l "alienware_wmi" /sys/class/hwmon/hwmon*/name | sed 's|/[^/]*$||'
+
+Sensor monitoring is done through the standard HWMON interface. Refer to
+:ref:`sysfs-class-hwmon <abi_file_testing_sysfs_class_hwmon>` for more
+information.
+
+Manual fan control on the other hand, is not exposed directly by the AWCC
+interface. Instead it let's us control a fan `boost` value. This `boost` value
+has the following aproximate behavior over the fan pwm:
+
+::
+
+ pwm = pwm_base + (fan_boost / 255) * (pwm_max - pwm_base)
+
+Due to the above behavior, we expose the fan `boost` control to user-space
+through the following, custom hwmon sysfs attribute:
+
+=============================== ======= =======================================
+Name				Perm	Description
+=============================== ======= =======================================
+fan[1-4]_boost			RW	Fan boost value.
+
+					Integer value between 0 and 255
+=============================== ======= =======================================
+
+.. note::
+   In some devices, manual fan control only works reliably, if the ``custom``
+   platform profile is selected.
diff --git a/Documentation/admin-guide/laptops/index.rst b/Documentation/admin-guide/laptops/index.rst
index e71c8984c23e43ca7cd6373b88803354dff6bc60..db842b629303c1bcf02646204d51938f9bd4043e 100644
--- a/Documentation/admin-guide/laptops/index.rst
+++ b/Documentation/admin-guide/laptops/index.rst
@@ -7,6 +7,7 @@ Laptop Drivers
 .. toctree::
    :maxdepth: 1
 
+   alienware-wmi
    asus-laptop
    disk-shock-protection
    laptop-mode
diff --git a/MAINTAINERS b/MAINTAINERS
index 1afd30d00aecf9a48f8c71e156affd5f329539bd..c609bc321b8dc3ab0e8d92b04e42483be8cc171c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -796,6 +796,7 @@ M:	Kurt Borja <kuurtb@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
+F:	Documentation/admin-guide/laptops/alienware-wmi.rst
 F:	Documentation/wmi/devices/alienware-wmi.rst
 F:	drivers/platform/x86/dell/alienware-wmi*
 

-- 
2.48.1


