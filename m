Return-Path: <linux-kernel+bounces-559706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B695A5F868
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165013A4506
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57C2686BD;
	Thu, 13 Mar 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2btCvWB"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA326A09D;
	Thu, 13 Mar 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876239; cv=none; b=a8vWK2EKUW57X5tLqP9SRT6ILmwdEloKOK7E1NCUHFk0mtQtqFteMwBWxmELAYZupMsWB/C0l13MdCxHXmnN3uS03/FudyBoWHA095nG+HfT2WJXZpRJ6N9KVSGj1uPlYE5vgK/937QlOt13IoBpDZAXFIV6LVsQ+jlcAKv8e9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876239; c=relaxed/simple;
	bh=+UVctgMLCQI2qtTmv9h2RN5EXbGlaQr/uLpLO/ItiII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjQXyGUrQ5li0W7ysNDZzxbrvO035K2NvIRXXvGFChbz2UX4I58mdo2/NlbRxJSSak129z7BPGMz7yEAqJqCmnCLfrNBnyTWyqgodMoFCO4NdqH0F54HYmoUpoXZJ3vdVthtj6vYt6+4BlWKIEWZdX2oNq62RbQ52vvANuuMHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2btCvWB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso909416276.1;
        Thu, 13 Mar 2025 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876236; x=1742481036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08INWI3mX8Qq+o80JMhCH1odycnPWIStSqHUAbKsMI8=;
        b=V2btCvWBDXK3sy3aZRiY10caAqjSyItQL7lZDGz0J0m3cFmBjeI+2dMYpVKYK9lNfP
         PHo5eLRs3sjI0aVpdCgsAw3zpDFez8sjizBJdDP+aW9kCVLbT3M5U1UJnZWUBe2X+lJj
         hGLzU2zEoSmLfeUZzLKc7FLOB/ARUhc35Yrjzvd8pEip+PYWKu/PYCmAhB/F/r6FuEN9
         UyJ2UCn9hnXF6McV0YRuSw+nEyEGX5wRaie8o1W3nFiSuHvjI6coYXGWSNq5BUW/KrOm
         IMGQiDIy8Bn8hqQ+HF0SKYcJn9ltO4kn3Oq5uu2LFfHaCM5zFPaNUHkO8ZIeIZKqROX5
         RqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876236; x=1742481036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08INWI3mX8Qq+o80JMhCH1odycnPWIStSqHUAbKsMI8=;
        b=qfNjMDfEfUB6ZPQvM6BbsGjUMluBRHMAdt1zYUltF5dWkN0frkjyoAPQIPesfTCREo
         EJx5juUFBDFs1jhxr8TCtF84WCYoGRxmbMBnitKTWGvnF6QkZZTS0lYgmn/YRCAxjH8f
         yoHkue49Tnbpga6VhERWbGecn9Au+K66Jr/NeIWqvzqTp4nYbNht6aKGkyhcyeTBNoKd
         Tif7zUKXPwE7UMsoSoj8QY6kkU6tCN/w5t4VKoPs01TmhRIkYswivCZw+zB1Yl+/HXzK
         w0OnTS+IUnm1Nqx8EJvDB/hQCI9xfoTujZOkz1+NN3EjG5284I+3uJ4nV3l/16qF739i
         0z7w==
X-Forwarded-Encrypted: i=1; AJvYcCXm0E6tYNUdCGyGIvEiDC+ZX1sSUS1sdExpDhz5srKpU3yLe2wYepvPkX16C1ovKUyaBEF3dyh3RvgnaMjkrdn+dC3WTw==@vger.kernel.org, AJvYcCXzK5Y7iaAAibgOgB8pWJYgdkVVhg04l7PaiCTSTOyvtuYeJjrwYyMUzwl1no2TdXFwcJ4xnlSCkHEdgg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzon+Jxbg1hEtSYGkJquiY+YlxiQuvVtBZ3p3hE7q87MPGAnwT3
	1XAxtx80S5ESsIvHmUmKZhKz0Un8RBOvValNWk+rkw3UpDmQmL5vVSEOz7Ip
X-Gm-Gg: ASbGnctWsJJ9Beb20JavhTJlB+G5XmWXqrwG5h86ZimE1LFSWyOLhcnomBK2+uHvFzn
	SUcn6lzcgYbXvb4592u6chgb1fFBsC54BinKWkli8F78Q/BGmcU8QO5xHLxpIQfP1FgXy/S4WUr
	1nkKkmGLyEvyhFDOAVut6dJBjuA4atZ/NmS4YIumZX3mhE/6J7v+EX+iPh2xkhRZwARSWQhhsaY
	xDGvi5/jmOnUXzlqrU3hd80hPRWamCfd2kNmdgG8wgTUiZnXSx2BTvIFnVZATcGFyrf2/hf2HRS
	XMfOLhxCNiJdBK00jNaDJmsLidYOX2QsuASNQirGg8UPcA==
X-Google-Smtp-Source: AGHT+IGmj4KVOfUR9zKVTivrey+683lgb+CPnX2O/8jAGtwG7zq9BkPwsKxPl9loZzk5cxtrlFAC+A==
X-Received: by 2002:a05:6902:a91:b0:e60:a93f:2a86 with SMTP id 3f1490d57ef6-e635c1f4d33mr34739204276.42.1741876236159;
        Thu, 13 Mar 2025 07:30:36 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:35 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:07 -0500
Subject: [PATCH v6 12/12] Documentation: ABI: Add sysfs platform and
 debugfs ABI documentation for alienware-wmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-12-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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


