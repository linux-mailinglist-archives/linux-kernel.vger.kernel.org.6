Return-Path: <linux-kernel+bounces-223402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD341911262
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CCF283EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6C1BA89D;
	Thu, 20 Jun 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KPYKYZdN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087C1BA862;
	Thu, 20 Jun 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912560; cv=none; b=trA0TCm0cLaXoGx/HdxM4v2VtRl0GTReEVNiGa5pW6zdDar8uT08AYS6IzenDwnOSfauzB2c/7NXHMH8dqSQjjVu4KF1RVEyEaBo9TtBdEv9zJa9gjVS4J7PV7HtDoBk6zwK53q4xqCHlTTZ5yhgJJpET315smpb5mA1f1vSABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912560; c=relaxed/simple;
	bh=rgO1E5m1JwjccUW7vLOgocs4uvqBG5I021npctWy4Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBHv/NGPK3ZotniJmGQicRNMJnp4raYaE9R9zfFgY2lWGTjBRtmEn/wAG1AW+LLwmHg4BiwX92zU61+T41Jg1+fbuirAViNCAPzEaLfS5M0m2zpDN4pLQpR0oMnFfxuvoL7j89vDfqZyOiAUJkZVYQHRd9DluCO0ejn212pvtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KPYKYZdN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718912546; x=1719517346; i=w_armin@gmx.de;
	bh=NTt4UAsbkzh4AqOHoa3WKT/B58KkzdFtRTM7qG1/NdY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KPYKYZdNkn0q1HHptb3Fb3zlLdUAnGtRNAGGM6h69bu7eE4N80vi+dkyxE81Ozst
	 4COql9WtUL0LshdSEODiGzoVK84sFBLfuAOHANGKKcUBew9Smh5rZr/orWIXPX7Fh
	 qL/9P0L4mEGvRh27AQRooUUC+WkbMRUx8+rQ5wuXsz0Mc6/hXySqvx6f98gaIycwv
	 rK2BmE/1zxxuOmfwQZOPnEbE6AdbdpoJq60ZeTrmhpFCfM6iAFprbz+pZRGDZKifd
	 UqkEy9vaRSsX5wNxQMhxHCrdm/js7uGKTu5C7f2p7VO+KT3efZaWk/mFy2pCNQKqE
	 54KQFtHactgV7j312Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9T1-1sBtLc3OzJ-007Qfr; Thu, 20 Jun 2024 21:42:25 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: wmi: Add bus ABI documentation
Date: Thu, 20 Jun 2024 21:42:14 +0200
Message-Id: <20240620194214.3071-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620194214.3071-1-W_Armin@gmx.de>
References: <20240620194214.3071-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ANwm/VGL9vNKvR+20DvM0fa5so++m1mNpNnsnnz58hDasQBoosw
 SM/1+WsrfyH3Zo1yv/o1l7YTWX4q/vMYEjtJWSk1Iu79oXndgio3OxJsiOsiedInEV7wfHV
 yCzltDCpPlP+r04v4d1roCV6Zc5oP73wo8twkMAUYVHCvBBiRT4SPl7ZIqp2G4NeJxIHeCT
 5j8GRBANo+/wagsiQb3kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NixsimkRXNQ=;mWR8dNoMAAF77tu9X3BQNRjK59c
 3CqQWmK08iya4KcOs/TsZm7Sul/0HK8I1eiGRD3hCKj9pRUWyIXUksZpv3T+JKTlsSO0rEdqp
 5GLphf7HCoLtgwNAuY5oBgtpS+T/1NYBhlGmOJ80jUvtRPYgPLTvoMdBCRwtZhBA4h/hsykGA
 sKH1jVXcB5CF0fmn9a5BRSzP7aGRHbIykXYvaYJUF4Tjg8WF0JKtJHQOr0IxlYaIydIZKAksv
 20hH7SyvqcJdO86KeN7PO00PVjFJeEAgtccefINA7k6R4BLA551055OxCDPRCSLK7URUFsjF6
 L+/gIJ8cqsVAXL7UVkA2LddMXBSZalQMdRKFJuLpHMAaAwBr6kNrKhabJzPJVhg0A+S/Okef7
 4ic+2lcuBTIVTm28iZSOQ0dfmoTaxM9xYtrV/1LH78zfrYDqyFIsG56ZX2fNyRK9SVyH13ZuX
 20gtly9n7U5igIf5SaumdyNrG46RHnO9Fx0d3IAxo5TRQ67iC8S4dml415Bn1LtFH94QAIKPn
 OsQzjS+wxepbgWjZ/09z1HYvZoO7sge4TndfIpwMMrvUD58wDWfiG6xbQcnJGlfRWs3qdwReB
 4AsSQEf6TqWDhv3phJzmDHFNuMSSsRJNv0WCZA+WNCFtolD36qUHKVOcrIggrO3xhRzA6arqU
 8Ld43rBCHgy7CnUuXWny1S+myk6F9VwBqz6rzusqMjfCNdXpK2v02ctApVGG7ve2srDLsbjY2
 JFaH8EnfC8D8YKlnjeZdR7b4GauJMAohiVcvdeprO1/YOfvAnt3VfblYekqnQSk4+GNnC0ERL
 +ewdncG3eZqOq43CROKEq0356T+MRyJNSTTZGDROKFmAA=

Add documentation for the WMI bus sysfs interface so userspace
applications can use it to access additional data about WMI devices.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/ABI/testing/sysfs-bus-wmi | 79 +++++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi

diff --git a/Documentation/ABI/testing/sysfs-bus-wmi b/Documentation/ABI/t=
esting/sysfs-bus-wmi
new file mode 100644
index 000000000000..496d602b67c6
=2D-- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-wmi
@@ -0,0 +1,79 @@
+What:		/sys/bus/wmi/devices/.../driver_override
+Date:		February 2024
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file allows the driver for a device to be specified which
+		will override standard ID table matching.
+		When specified, only a driver with a name matching the value
+		written to driver_override will have an opportunity to bind
+		to the device. The override is specified by writing a string
+		to the driver_override file (echo wmi-event-dummy > \
+		driver_override) and may be cleared with an empty string
+		(echo > driver_override). This returns the device to standard
+		matching rules binding. Writing to driver_override does not
+		automatically unbind the device from its current driver or make
+		any attempt to automatically load the specified driver. If no
+		driver with a matching name is currently loaded in the kernel,
+		the device will not bind to any driver. This also allows
+		devices to opt-out of driver binding using a driver_override
+		name such as "none". Only a single driver may be specified in
+		the override, there is no support for parsing delimiters.
+
+What:		/sys/bus/wmi/devices/.../modalias
+Date:		November 2015
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+		This file contains the MODALIAS value emitted by uevent for a
+		given WMI device.
+
+		Format: wmi:XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX.
+
+What:		/sys/bus/wmi/devices/.../guid
+Date:		November 2015
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+		This file contains the GUID used to match WMI devices to
+		compatible WMI drivers. This GUID is not necessarily unique
+		inside a given machine, it is solely used to identify the
+		interface exposed by a given WMI device.
+
+What:		/sys/bus/wmi/devices/.../object_id
+Date:		November 2015
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+		This file contains the WMI object ID used internally to construct
+		the ACPI method names used by non-event WMI devices. It contains
+		two ASCII letters.
+
+What:		/sys/bus/wmi/devices/.../notify_id
+Date:		November 2015
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+		This file contains the WMI notify ID used internally to map ACPI
+		events to WMI event devices. It contains two ASCII letters.
+
+What:		/sys/bus/wmi/devices/.../instance_count
+Date:		November 2015
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+		This file contains the number of WMI object instances being
+		present on a given WMI device. It contains a non-negative
+		number.
+
+What:		/sys/bus/wmi/devices/.../expensive
+Date:		November 2015
+Contact:	Andy Lutomirski <luto@kernel.org>
+Description:
+		This file contains a boolean flag signaling if interacting with
+		the given WMI device will consume significant CPU resources.
+		The WMI driver core will take care of enabling/disabling such
+		WMI devices.
+
+What:		/sys/bus/wmi/devices/.../setable
+Date:		May 2017
+Contact:	Darren Hart (VMware) <dvhart@infradead.org>
+Description:
+		This file contains a boolean flags signaling the data block
+		aassociated with the given WMI device is writable. If the
+		given WMI device is not associated with a data block, then
+		this file will not exist.
diff --git a/MAINTAINERS b/MAINTAINERS
index 09ff0dfd65cb..4f76d6a5d348 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -392,6 +392,7 @@ ACPI WMI DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-wmi
 F:	Documentation/driver-api/wmi.rst
 F:	Documentation/wmi/
 F:	drivers/platform/x86/wmi.c
=2D-
2.39.2


