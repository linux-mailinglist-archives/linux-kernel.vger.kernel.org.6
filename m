Return-Path: <linux-kernel+bounces-227678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A8091556E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B063DB23542
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893219FA77;
	Mon, 24 Jun 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QgU1SMyW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A119CD0B;
	Mon, 24 Jun 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250300; cv=none; b=hGnfPdq9ttit27JOMTNkNY9a0akwP8ggjfDH2ZGhCCoLJdCqvUslys+Bexd4S5QRBZx4tcG6r3yQwd+SHWHe3nC+cfH1lPL/ATsI3OLQAqMU8T7wt9QMyvqH4mjd30k0ZPnTrFDVIz8Yknp1VJqnaVUIWg0hTdEKANYhj/BErEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250300; c=relaxed/simple;
	bh=PKfC1wyJ0jC9WuWVPUlkKkRao8tanlKUXrZrk9kTYiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0MjLaRnNeSoh+57Ry4M/UHGlCLW18ikhrr+CWvlJUMqBv41H3I/BwNvhOW9meHEDwz4s+sMga7Wm20UW69L/Sv9eJPUIqitiE7beVz/AvSCJiE4JrsBodaYvXDkwzd41oTva8CU9U6H4pz8NSMmjo1BzUUx8lk7dLUAHp0q8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QgU1SMyW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719250289; x=1719855089; i=w_armin@gmx.de;
	bh=IDaxS/x326fXcXmy8hZ1dWgd7Z/z9xvhU0lQQS1fboA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QgU1SMyW3kEPsuDx7Xsq3cxFsA7HUrT7yX87jbYAvPhU8IBItq3F7ugz1B+bFiAQ
	 hA5Cq+l8jIouJ9FyGpsJfuWmcUKSsrMVzfAS0qmcpnvIGkl2KM01BXVwOkNztjRGJ
	 L6jbzjTUyqbOHrgFLSIGzNB3lpbCN4a8lXQQn6N1INOkA3glIGPrmimt2XalMRnoR
	 3DDnnVCp0ElLkz70rr9mM8FYJROcxp6TEazOKLrfwXz6uhpV+zHzzco+UcjRTsLLX
	 uq/lWqBRVwyxbLSNy1ptvS/nlYxLFkuPP1IVuV7e2ea7hHSeIlM3ieLcwuAHVhRjg
	 KIZoEY/OMCuirKyIGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MQMuR-1rzboe1ELB-00TXqG; Mon, 24 Jun 2024 19:31:29 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: wmi: Add bus ABI documentation
Date: Mon, 24 Jun 2024 19:31:16 +0200
Message-Id: <20240624173116.31314-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624173116.31314-1-W_Armin@gmx.de>
References: <20240624173116.31314-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6CGvYmV5GLtPBdwMI2/Ey6YGTQf9ZC5AxrDYHO17to/M0/BxY/8
 830ZgtdlH5RWuzkRMhsK/SqyRynMNJu/9UFR+tWlyv7L9gnFvM8NXMKO16wQOPb6I9Lzqtq
 PkYcSxaFXfAbUJOJXnIx9yMlMrKXfohhW6TQQ3GroCO9RksUCyqIPIBVL6nOmf9lfQ5iC7a
 +jjj90G1r4+4+CpnsT8IQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LIqM02drmFI=;Mms0gEyqRCGaD+OKlkRhScXnbOC
 siE2V6eXuc7eOQQLEirJnv1Bhi+ezJ3B4RBz6aHBDKf4Olzt78VLEXdVgvLM7/O4t591yVi1b
 Fm7yQ+9TXYrkpiGclsaOeBBWnUJD0Sldp6EsXNxgOR8ofGKaIKQ+E3KLBSVYz5dSEK80Ns5PQ
 NwMd2v8vuEx+2hVsHef73gIuHP8SkmZ3LLppqYQXVPpDY4R3hS31jEVpKOhnmnFamMNemJE1Q
 vBKH8Ax32MtL5fcrwZp2KVG4k7y7E2SF2B+b15Ced6NS0LFMV/TQ5U4dJ2Lx/LhQf74ZiggM8
 a2NX8IV9dtsp6p4d5iD+JkBHpnroJ2pM/9fHGpAiA7jDQliO6X0ycIYLmUSDEQukM1JYha0Fw
 LcbdCSg3jhgzziwBw1ZcYuXKn1PpO10UWQv7HhCPBWZFvmylV9o5w5jMIWX8rV3hzpEriLl8x
 e6npQ5Cm7v2JYNSangzK/VsvHl1PeCUxISPmsfSuHb15AERmCa95/wWkMzCAn8NhkYw8FX3AJ
 062ni03yYFMcL+qiwfrzAGy//+ZPx8t1YnOMARrWRrJ5uNyRAm83AYyBdXrIdSmfSJYFkSmfJ
 nwbnAM083ut2Li3q2avGEbcBfrEAkxbMRX/uEYfxwtqJU3bb9I7Qm/aEFqIj4UhJ7g7uYoADZ
 PnwKTd2QbCZg3PTrQH+q5fXARgS6gEuHQpggNnEnQvc0tH8NyxawwmQChSekrWTH2rleJ15C1
 /UZWo8KeiDHaUjjoOTUFQdD63vzpBmIVXKdkMuhM8ocPVOJpKIj8qqRUt83xlnCe7at0yHmAy
 YaJQfi/KAblw3WaJe1Z83AJ0rbxajcfbmN6Rzox/wbxAc=

Add documentation for the WMI bus sysfs interface so userspace
applications can use it to access additional data about WMI devices.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/ABI/testing/sysfs-bus-wmi | 81 +++++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi

diff --git a/Documentation/ABI/testing/sysfs-bus-wmi b/Documentation/ABI/t=
esting/sysfs-bus-wmi
new file mode 100644
index 000000000000..aadb35b82198
=2D-- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-wmi
@@ -0,0 +1,81 @@
+What:		/sys/bus/wmi/devices/.../driver_override
+Date:		February 2024
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file allows the driver for a device to be specified which
+		will override standard ID table matching.
+		When specified, only a driver with a name matching the value
+		written to driver_override will have an opportunity to bind
+		to the device.
+		The override is specified by writing a string to the
+		driver_override file (echo wmi-event-dummy > driver_override).
+		The override may be cleared with an empty string (echo > \
+		driver_override) which returns the device to standard matching
+		rules binding.
+		Writing to driver_override does not automatically unbind the
+		device from its current driver or make any attempt to automatically
+		load the specified driver. If no driver with a matching name is
+		currently loaded in the kernel, the device will not bind to any
+		driver.
+		This also allows devices to opt-out of driver binding using a
+		driver_override name such as "none". Only a single driver may be
+		specified in the override, there is no support for parsing delimiters.
+
+What:		/sys/bus/wmi/devices/.../modalias
+Date:		November 20:15
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


