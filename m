Return-Path: <linux-kernel+bounces-557232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B57FA5D566
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F787A5B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A791DFD86;
	Wed, 12 Mar 2025 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kfq/SbbS"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB541EB9EF;
	Wed, 12 Mar 2025 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756346; cv=none; b=TSokKlMz1w4g5Uh6rUKH++qjqCQHj4usz+bvcuWzSDdXTE4slpIA+W3yoKOEflrFv1q8Q4pt34bb0IJbxfQLO6SSlisFM6ASe10Uuz2HugOQu6hJcC0Gos7614n05aIxsiaxfoS0qKEcy+iVwt74A5j39BqlvceM/8Ro3U7eEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756346; c=relaxed/simple;
	bh=9bd+fFXZOGpfjf5fiMZ91f038xwI4VpLqB8yAWQipxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ln1kKjF7LrdoHipdNkUQckZDipIYqUHAsTeGjgin4woEabha26a+LUuO8lsP3hFkmxGFPbmY7KZ4Ou1+fjY64RFncl3sG/mYCK654PZ9XzPyEOgCi25m01DnfhP1N8bKOtzjUShhdLL1bn4gn+/MWzA8aWLhflidE6Q25QBNtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kfq/SbbS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f47ed1f40dso48300117b3.1;
        Tue, 11 Mar 2025 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756343; x=1742361143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOocp0DmQcn5u4f3g9aw3Ib1o2FEUYsoDQmnBjH/Bjw=;
        b=Kfq/SbbSEHK/heIa7jicmWs6MPEpCnSKQlHyJQowoqSzpRvLg9WeEJCPnFf7FYWE3A
         rT6cWBH6HZZ/rDI88Rwlb9HYbvlj1sR7s/bBKRNXnwwFSzj1boFwHtlZR1hjyBnPOhB5
         jYbxVpaIWR1eEUB/9sX8ZDr5JGOU36MsDtLV21DAwrBcZPkB0OfW/huQSBioqVmDHFwE
         RaQRPP+pVDuimfqK+cA5pWm1mAqs3SPTo4vskxLxcSNDo0vF7RcmCAk9p/l05myJYXQ8
         VwzdZp41x21DcikQKFjLhkM8DTtCVRULlcM9usinkIEPi5WnclQRRd5tl/90v9OatIz8
         1Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756343; x=1742361143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOocp0DmQcn5u4f3g9aw3Ib1o2FEUYsoDQmnBjH/Bjw=;
        b=IGjV/PbYXnL27JPxRc1hF0FRV0hmvy+VhtmUjx1YfvvNCuBvUMm6Js1TZFneyxmTc/
         XZvHF0rPqlf2YETKSYMZC3xdvThFTh4Lw+fgH3A4Ek6SZd24Sy5WuMxp/FKLARi7do8t
         QdPg3yxG8JGdBemz4dL04ORC/7wH2PonMO3KXcUA6DoJMiUmaEK5WJlHw7B6WOnCrO0Y
         +WY6l/FlXSqMS6GnaNcEVdmCUxU6Q2ngMPHTWEYppyXu/4We4AqFm+2nQ9aMmj7JYpqa
         /C8tut87nhndX8bze0ziiI0T6GpFriG9ow2Bt3+5aDtto3VSca29BWrqI5O3LeGSsuyP
         hF0A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8SRSo0993MUJpJKPXFb06NeyIFMXII5HJ75CPm6WcbZtb7a602azgA3ecGIekmvu8IZPhqaP3bMBr7fKuzcYpPvqog==@vger.kernel.org, AJvYcCXdQtdyZgHiA/fgAlBhz+amS9jY0w7gP4qrFeSH3qHHQuCwS8tnLhCWam/DhLKTAk7a+fx1dIHbxePLWS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLrQlCcLOnMkkTcpQ0kDq4j0kXqRLUKsazgb3sdK7cWbfg7Gv
	fBNfr4CuXXvCMpumeMY3JzD5Ev0kdE5M2cYTbBUSYDu64xNhzqooy/NU86l8
X-Gm-Gg: ASbGnctLmlBQ1CJumTjPF0td0blB32BG54SSbafRyamxctd5+dBo5T1eSbFGlk7CB18
	h/5dSi0lMCh0X5FAeeFeGa7op8MukJ/yFk1i69ANiUlS6gk4t6xCM820UQsE8Snuze2ig11TwVQ
	iO7ARukZIB9fBsmgIF7bmal9qNZWJIzsyyM3CL0FEDE+bj7QBKupdMRBJwubNv7HJFn7ChrCxhu
	s2f9BH1uNXbLwXyAvdZdggZaiR8pYjcu+nWlWsgr1JW82FdXojgjoZeseZK9yuGkS65fhNUeb45
	6pRSvTWdqeTgVQzzgnoym5ZJ8MHH/EnXPBxyQ19FcSxAjQ==
X-Google-Smtp-Source: AGHT+IEpnejrMZcfMvoEVMzpvXr75wHFUipNxRInr6q7BwtatDy8+J0bYqhMlnVHTYKjAvqRS4QGbg==
X-Received: by 2002:a05:690c:7207:b0:6f6:d405:7010 with SMTP id 00721157ae682-6febf39bb73mr281902847b3.29.1741756342837;
        Tue, 11 Mar 2025 22:12:22 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:22 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:24 -0500
Subject: [PATCH v5 11/12] Documentation: admin-guide: laptops: Add
 documentation for alienware-wmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-11-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add driver admin-guide documentation for the alienware-wmi driver.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../admin-guide/laptops/alienware-wmi.rst          | 128 +++++++++++++++++++++
 Documentation/admin-guide/laptops/index.rst        |   1 +
 MAINTAINERS                                        |   1 +
 3 files changed, 130 insertions(+)

diff --git a/Documentation/admin-guide/laptops/alienware-wmi.rst b/Documentation/admin-guide/laptops/alienware-wmi.rst
new file mode 100644
index 0000000000000000000000000000000000000000..fe7dec73706f8ec85040dc1cbaec38ffda70b563
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
+WMI device documentation: Documentation/wmi/devices/alienware-wmi.rst
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
+   In some devices, manual fan control only works reliably if the ``custom``
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


