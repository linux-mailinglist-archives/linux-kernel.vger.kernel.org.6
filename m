Return-Path: <linux-kernel+bounces-559704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E868A5F85E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BD87A80CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAA26A091;
	Thu, 13 Mar 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeN6FEa2"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCC267F70;
	Thu, 13 Mar 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876237; cv=none; b=Il2BDZvBrhEUZCFboFx1XOXNygCVp1wi2KoMJU6FM6bFjob4fUOtAKjNHrDl8sICi+7ACXrAiTk2+gODjvq0lGVbsZ8N56FptllDnL3z+lQgO1Oo3+truXaF58g4B79HGMDZRWndle4kntl0NdcCykELAXqVAbOPpBCk/qKhVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876237; c=relaxed/simple;
	bh=9bd+fFXZOGpfjf5fiMZ91f038xwI4VpLqB8yAWQipxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0snGla4drfR+eM3CVi1cywKgAAsMkBjCM5MTEno5CtbSNQd08ECYbLsnjS0kjKE/FnyNyLFi3vF5QQpFj7ZgUVhW12ZMOZWfcgwnLaIAnV9+eKUvoJiOt+sPq8JhNd7bMUJPaPEucAWwF9EBKyxskXrQu939DkCrH0OGim3qME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeN6FEa2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so882262276.0;
        Thu, 13 Mar 2025 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876235; x=1742481035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOocp0DmQcn5u4f3g9aw3Ib1o2FEUYsoDQmnBjH/Bjw=;
        b=FeN6FEa29WnH0cLYEEoN9oUXl+tvfta2J1elkQkK9/EG+Rxx4s2TfnKVqs+Ja29aCW
         LF0XOEspfYXiWtLMVYQfe93jfKb5qD/gmwac5vUFyuUHlZ7W/i5M3/5J2W54KqaA87j/
         a+4C+kjf7GDma2X0Ra0pmhF8zDvUrh7+H9qhcFcd3SQgfVEXpmnOJ2xeRgs0c12dqppL
         wfZZq3RJmvu9HvrFseXg6XENFnhiN3Ym5lAPWQRgd7Kmtgui7DHT+K4PmSHOAalVL+p7
         g3/zGVRyv5HTVnSNKdBQLrbkIwp2yy/SYWR51dUg03PdvvkQROY4TvZGeBvZlWNWj+1G
         zgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876235; x=1742481035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOocp0DmQcn5u4f3g9aw3Ib1o2FEUYsoDQmnBjH/Bjw=;
        b=SnRurExEnjDu2IXcOUNwDXqvvsyswivqgWWUghTqlsSKtYPxvZUUJ0m0KuOnn7KBF3
         3Vdr4W7lGzisEhyubeqvCZX8sfEU9B1O6LUwSTvBjEWDytvUQA1QPI9oT2uEIKbRQk3j
         G5KHbN4X7/9QVUf4n/uIax9SXstbiP05wZqkO7DyW6P9mQ3V+WeqIEsl95SLM7y7PG6K
         3w8cKUptj8iO9EuLOJqhZI0kLzupHmtXpBOjB/CdrAL0qxHcSFLORBlt9u826Gi796KG
         W1eTwPUwriCs9gy5ViBtTx+T404S2yoLtMHgRzekDYbyLV2x1kSSyhqUIOfGmslvla1L
         mFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7P9gezJIvGuXeA3vfhdH42C896Q61VhbTtvJt0FNPoK5fwRuz7GSO9Yz2euwQmZPP5ZM5n2UExpmS9DU=@vger.kernel.org, AJvYcCXHmrZ+Tv15BCdMCfn87kNgnY3vot3l1qxecftaamkSc7VnkqjAuSp+cOntg1Q1H/mN5R92PXNCgDHL7+W1VvGcLjg4ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TWi99Xh/Z6pdxvXJu0CCK+q8nOCwi25SW4VbcmgpBc9YUg9K
	4ZXskY9Ue9r6eGRnvPl48w4c7avS8S8Sm76ZKQeR4PZvCSLlw5B46F18Z53I
X-Gm-Gg: ASbGncsB0mXCaRMmXZCw/OX5xWtMOecv4DPvrBsHiwDRUzgtKNSmm24+muuMRVEuTRE
	6mbbWaycBwCG+1FTJX4exHmFKKvGhrag9s5IKTFgEDOCgZOdCsr4JmAMVU7WMfO7+PBEc3T/JBo
	uL+awN1T6oWwE9BavHYAhjzvFbYJEp3EnEYhX1LgH+AlmUnTtkUJwM8QAXCX6dBzJPF1HjUL9eg
	0wliy8UvGqiMIJ4C+DRU1juilFXGJtI0D6l67G7EkrKFLugYcfjkegLchKNW19qC2hw/Amhw6Q8
	Db6R3LwFKSgAUd+OfkVS6sJFaraehVgmbM77jzJT0uvWww==
X-Google-Smtp-Source: AGHT+IGwMVc2RU+zHHELmrIwICHYTq1+E+km6vWD4wbCL6PpVAiutZscBAPkJahHzbgQk7SEDEG01w==
X-Received: by 2002:a05:6902:348a:b0:e60:aa39:11f2 with SMTP id 3f1490d57ef6-e635c1d97c3mr27214369276.32.1741876234584;
        Thu, 13 Mar 2025 07:30:34 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:34 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:06 -0500
Subject: [PATCH v6 11/12] Documentation: admin-guide: laptops: Add
 documentation for alienware-wmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-11-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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


