Return-Path: <linux-kernel+bounces-557233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD916A5D568
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3804A3B4E57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9071EE028;
	Wed, 12 Mar 2025 05:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHZQ6yHK"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A591EC018;
	Wed, 12 Mar 2025 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756347; cv=none; b=b6OPhveUPCV4XChJLIyo8BjUDRl41HCdnOwnv9vo01yz/V07hA5cNcoKUMRkZ1UrFqB5tAGFNPozB7AETrnXxqTmPBIqUoeiMSsW6MjlbQQMOSaOtdXHIqWEvROt8RPtCnWOWiUlr3h9+eiWOgDj9AmguepyFxtNA7nn+pAVphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756347; c=relaxed/simple;
	bh=+UVctgMLCQI2qtTmv9h2RN5EXbGlaQr/uLpLO/ItiII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7lZ440eDGxmcEjwv0gpbSpIJHJxvJ56HX1V3sOjyNsYP9qwjS8DH6gXUy+RfdGi7Y25+IjVr2jSQs76PgekqmcYpNp1c+7mbk4KLqGdRzlr69QzrY6Z0tdM2zhMJLAF12sKx3uZ2aHEulXG87gl/qjRKFbpVtX2+IREcoVl/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHZQ6yHK; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6feb0742878so59700497b3.2;
        Tue, 11 Mar 2025 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756344; x=1742361144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08INWI3mX8Qq+o80JMhCH1odycnPWIStSqHUAbKsMI8=;
        b=RHZQ6yHKSB0kQK60MemsEh9bW4KRBjV0sAa2oGlj3yq2v3XWoy1noTSI1YUDQbA5wB
         EHFxC99EAvUjuFDStP4/q9GAhSuiZRolKk0auNIhaCdb6aiisjs2pAj22WJ7vv7djdTS
         AK2YiHBAvlz8S+Gyr2R7YUWdg7giC4h0m5OcqIewDYL1ltWRh5FtaN/CGBuEZjtUoxqR
         PBeocIYswU37HQ28hMnnKbL4e0I23wuuM8XkIC12rcV9q0YMNdHMwPG6I3OmgO+vJ/NM
         mxtECSmrbE3MsfbABnXlcrfw8id26A+ZW0CHPVIh/aICTTICi20z27/1ob0PeHGhsLW3
         K7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756344; x=1742361144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08INWI3mX8Qq+o80JMhCH1odycnPWIStSqHUAbKsMI8=;
        b=AhGaqXe51kMq5eLMZiCEQ0uGdRWu3+G3HkBIH4pC4J7n6Ru9xvDDhlrSMazocExi9u
         3SWu6Q8mFLFC6yHWNUawYlOy4H3CsfbIcrNTgWIMNoR1ks8nbCTKBW0AHghQDEeq0H1+
         aTjcqBw5IPTNNtS8LoBa3xcqy1/3MBh3t4lk2FH2EL6L1Mz6Y2CiqfIRlqrDRBtLZoHM
         ugiQXO7Lx2qqlGTFCgbkdIOXpq2HjtBs1fIfpWzr593Myns2Z5bKihEOU2Kw9L6dr6vW
         G7T3UhEVMlaKCSTx+CkGz6B4t/0mixbQYsH/Ot9cJmB6qlXd79KM6EqlTODXQgxUpm3M
         G/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWzGGI2+2h4KtZS63BMJ/gbnRueEYy8Mb4jCmpvthZy8DEanUV3i1Iwj4Q4HOSCIrDG6ogcIHeABDiaoeobfLlYZt4p+Q==@vger.kernel.org, AJvYcCX9EOH3SJ0w5QEwVxkRQVky7dPWS5V0W3W2i09NkY3G+4SZVh/LTL0LdFFz1bFGqgR1dERcV71R27kp7Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbJoKC6NpA+q9gMdoOac4qEYexHauBHF4u+4g7TMMH3RtgXkm
	owNi7/1guQL4TcUNWhVheUTgstWkP1VZiGbBaoMa0+FBgEh9NUHHqSw5rXvG
X-Gm-Gg: ASbGncszOL/0d1TURbV6uQMAfjXVu/jsyqa+9L01evOCDbkv+LA2gJsMbjxV1uxmXSf
	QkE1NCbT4LWZhfHk9mRV86tIdNTmjucA+Bz2X2nkVgxY+NpZYoXze7URNZQ3yb8nWbnmtLUatCg
	EMQ5MWD8/6xi56X1Dc8QHrQW7Vq9jiHPPkiu8mQ+fjMmgDw/n/l+FHrFln92ZRiCYSuPiXj79kS
	52o8hBo2dZHJuRxk5DwxzYc+Bhs1DGwxb4mS1/UXfvF8nuRGyJZ2jgP1Po2fEXubPkHalIrMHDf
	9M1n7dAFszx7E1OoWMjKOtCX1y9iq1Chy4LccshqTfgy3w==
X-Google-Smtp-Source: AGHT+IFQ4JC8nq0hoD0bARgCw1bOg9w9D4MdkvqMH7tvMGdNG3W/XyzBLq+BSedGaBrQQJv8sc3pHw==
X-Received: by 2002:a05:690c:4807:b0:6fe:af14:57f6 with SMTP id 00721157ae682-6febf2a3050mr269605847b3.5.1741756344545;
        Tue, 11 Mar 2025 22:12:24 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:24 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:25 -0500
Subject: [PATCH v5 12/12] Documentation: ABI: Add sysfs platform and
 debugfs ABI documentation for alienware-wmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-12-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add ABI description for the alienware-wmi driver.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/ABI/testing/debugfs-alienware-wmi    | 44 ++++++++++++++++++++++
 .../ABI/testing/sysfs-platform-alienware-wmi       | 14 +++++++
 MAINTAINERS                                        |  2 +
 3 files changed, 60 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-alienware-wmi b/Documentation/ABI/testing/debugfs-alienware-wmi
new file mode 100644
index 0000000000000000000000000000000000000000..48cfd4d0b002efd7b68d9c1d3aa91a3a05f49db5
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-alienware-wmi
@@ -0,0 +1,44 @@
+What:		/sys/kernel/debug/alienware-wmi-<wmi_device_name>/system_description
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	Kurt Borja <kuurtb@gmail.com>
+Description:
+		This file exposes the raw ``system_description`` number reported
+		by the WMAX device.
+
+		Only present on devices with the AWCC interface.
+
+		See Documentation/admin-guide/laptops/alienware-wmi.rst for
+		details.
+
+		RO
+
+What:		/sys/kernel/debug/alienware-wmi-<wmi_device_name>/hwmon_data
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	Kurt Borja <kuurtb@gmail.com>
+Description:
+		This file exposes HWMON private data.
+
+		Includes fan sensor count, temperature sensor count, internal
+		fan IDs and internal temp IDs.
+
+		See Documentation/admin-guide/laptops/alienware-wmi.rst for
+		details.
+
+		RO
+
+What:		/sys/kernel/debug/alienware-wmi-<wmi_device_name>/pprof_data
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	Kurt Borja <kuurtb@gmail.com>
+Description:
+		This file exposes Platform Profile private data.
+
+		Includes internal mapping to platform profiles and thermal
+		profile IDs.
+
+		See Documentation/admin-guide/laptops/alienware-wmi.rst for
+		details.
+
+		RO
diff --git a/Documentation/ABI/testing/sysfs-platform-alienware-wmi b/Documentation/ABI/testing/sysfs-platform-alienware-wmi
new file mode 100644
index 0000000000000000000000000000000000000000..4877b3745f4e5b503376d375bf48464250328ce2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-alienware-wmi
@@ -0,0 +1,14 @@
+What:		/sys/class/hwmon/hwmonX/fanY_boost
+Date:		March 2025
+KernelVersion:	6.15
+Contact:	Kurt Borja <kuurtb@gmail.com>
+Description:
+		This file exposes fan boost control for Dell gaming laptops with
+		the AWCC WMI interface.
+
+		See Documentation/admin-guide/laptops/alienware-wmi.rst for
+		details.
+
+		Integer value in the range 0 to 255
+
+		RW
diff --git a/MAINTAINERS b/MAINTAINERS
index c609bc321b8dc3ab0e8d92b04e42483be8cc171c..faa377126bda0b9c848760495dc893982f3a4c3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -796,6 +796,8 @@ M:	Kurt Borja <kuurtb@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-alienware-wmi
+F:	Documentation/ABI/testing/sysfs-platform-alienware-wmi
 F:	Documentation/admin-guide/laptops/alienware-wmi.rst
 F:	Documentation/wmi/devices/alienware-wmi.rst
 F:	drivers/platform/x86/dell/alienware-wmi*

-- 
2.48.1


