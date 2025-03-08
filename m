Return-Path: <linux-kernel+bounces-552793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF2A57E25
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0EB3B35A2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C0215F75;
	Sat,  8 Mar 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFZ91m69"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA189215F45;
	Sat,  8 Mar 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465453; cv=none; b=hEmywRJ+mmLb2hCN5hLyOdsk9zwwIaqCRpI3cwjdU+CjsQ/5iy8258vPqXBVGHqj0HdlLiFe1hXRlpkKJINbKPLagClGeutUHXydvKcJVLY23IarNzpPuRkIfLI50XXbzzqPGj1oUju1pGnlKU5j6Ohhzxh9hHfRfN3wa9bmtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465453; c=relaxed/simple;
	bh=snnBzgnx45BY551HJwZzSOCPAMvggCW5QA2j4ofGGwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlwB4o3fkS/dHlPuFceD2GO4faRLx0FyyAvcymhEU3HfYma3xBY8CrrX6jHyYMg/kokSyEGwPzy8EITntOSWYTVf+Ml39sBQ4gG5MXvGEtTZDivwaPADAINIzr01Dnddrne3VJnjG+PM642oX133/EHOylBCxaIoBs3VfT0xjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFZ91m69; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso1266839241.2;
        Sat, 08 Mar 2025 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465450; x=1742070250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow5M59Yec7VakUaC2tNDYbZogIjsAYrtW+Ao/807hoI=;
        b=VFZ91m69YKv07U8vx0aLwBjutoxWbyxU89VYXnhIKy2OlbTw8q6nA+ThKK9BjbZb+9
         v8EyLq7BtN8lmTMs6drCb85z/rsUgN/KeHaL0z4g6ivHl7JAgOpiaJzyJC7nORYN1/ak
         gHMLbK+1cr2Hoonj1Jyqg9mwPR5wFd0Cl18TsJ8Y7ACVIk45+5gRiCHfQqc8Z0RUPUoZ
         pDKci/6afYztR83R1JxNyFerw6uNa4MK9uw/e8fRzl0hwcpn8u3ZixqqhrdGQZazwzCF
         gfcnvSKxse9WFA4Fmv8OhjtBOtRw8+qCXoFtbYo/gigWLFyPCjVedddUqETWglo2im8U
         BWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465450; x=1742070250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow5M59Yec7VakUaC2tNDYbZogIjsAYrtW+Ao/807hoI=;
        b=KaS5bUcpAZG7lk3NGAyL39imAVYEPpDIU3LKPSoGyiQEN7B+pVqh0200nujKbOmGxA
         5d3Ud8Hdh5T9n+0RV7uQqA0zbRXhnTK/cu7fR7kPg6Mhz4Sb0V46tQDZHqGgwYwnFVUG
         qjux4G9G0DIn37zaW0ZGSARXgJMG3nw9MyHLiavypGQQ2u+boawu0U0ZbuDw1iyDsndw
         D9D7sa9UZeAjWqFZDKdUJatVB8fERkE4GNWW14JyKmhcbw6GAb08DYtVsEtQNUMBJ3G+
         dhnduWovAm403K9X+XlPD4j3+FchwEtCE2XVY4wWsdljxCwKwkbdrf1pZ/bnpudBSUif
         X7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAgpPBmdLaoBmqbtObCZEgwG1xmxR6BwAtOPeeBF2NVYVPx+YtKRqy+h3C/GjD5GVpAtb96YRE3jzJW0Ou3qbZ8Apivw==@vger.kernel.org, AJvYcCWo7lydupXgZXzhp9YcANDpmqFxazL9j8JyatPs2ZApTrGaYloh/b4A/gUwQ8nn4rL13vIqFl183z7wwa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3PZmUP0adHXrrEyNl5TxQUxkgC6sidb1jnZbCe4E4eOoPPDc
	QxWsBVGwNgjXHOPhoX3RswHK3ul5zAzqiygjAsrAU0awh6CM+kANE1sUV2pr
X-Gm-Gg: ASbGnctJk182J7gNFJlmHbZJh4zAj8zf5PBNgJq/v2ubBtj/6q6PlPVYSrSCjGu3nVP
	16gjZ7yfl6klacCK6adbBYmzpXBqXmyro5Pn6rQc5Olgyl8kBifeba9KK7rnNdZpZXOSu50JAW2
	vrzoj0L8yjN7GHBSH/whN60mdxYvWjeUgHIQyXK3TgP2tseBqHlP+/Y8/oMc88M7Y1nEeqnXKif
	CT5D9OwV4Z8TMQIH1S5BsTPMcRjilk5cePtfY0cD/yf97Q7CYTncYE9nEl0Xmzl2n+SzL/y+kQI
	ZuReYvsHQXPSkxmg3yGtwdRpb2999AWKt1xyceocB4DSTw==
X-Google-Smtp-Source: AGHT+IFO85emDTfPho8prBm8xs9uwG0lLdsuCN5KLhw+N2n245bKg/jWnqZDJLtaPENR17SSmgAJhg==
X-Received: by 2002:a05:6102:9d0:b0:4c2:20d3:a125 with SMTP id ada2fe7eead31-4c30a5aa387mr6067763137.8.1741465450457;
        Sat, 08 Mar 2025 12:24:10 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:24:09 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:24 -0500
Subject: [PATCH v4 12/12] Documentation: ABI: Add sysfs platform and
 debugfs ABI documentation for alienware-wmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-12-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add ABI description for the alienware-wmi driver.

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


