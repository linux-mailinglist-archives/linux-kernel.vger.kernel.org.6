Return-Path: <linux-kernel+bounces-281335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D222F94D5A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DF61F223C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115813D512;
	Fri,  9 Aug 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WVc25u03"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584A17557;
	Fri,  9 Aug 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225955; cv=none; b=ddngkzrp8wfoROf5QuYtotLqnmyNjxz2biHi2ZuvbycVl4LDVXbVS196JOXV0ETmqwTTBin3nVexy/KP3HkKH+YM+v/dX1GKE0PY+D8wMhZ4oQ/mDv/0Yz/i00qe4etErD33gZiOAxin17LiPGNcS+ROm1cN3qZBxsCJpdNYlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225955; c=relaxed/simple;
	bh=JMiRPrc7ttszRNUNFnFZFTPAc3Iy0dRHRiIuyNvROvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C6Rygh71Hwa65SABvWV/usHVUmqAlbwqOw0EsIP0dYL9F5V3+iqj1NMvI2U9wXhuHmbT4aRm1vxlr5jd1TYv7aGqhSPJ0F8QEhou4DqS0pqL/w6EI++WMf4mSFTkeAzBxrJ/eZRstNXAR+SQBA0T71riH8XfF/aaHa+nX3ETk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WVc25u03; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723225943; x=1723830743; i=w_armin@gmx.de;
	bh=Z0dzszRE/GqPiXhqJqEumn2z1CpBQJ4iy0RlrQvHlqA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WVc25u035aCzeFOT1W4oKFqcuPUsU0bQhyV4WMNQmRISwFnUtwH3kpnXx49I3pU8
	 rEGBwnFx32ViiDYcRTkjci3zmhSqz80gQPuAzVKXROz0LRnvtTjGPWaqfKn3CLpJ7
	 BfYwGWL9GUlpO8lZuIek3Ao1VRn+ItyHFmcIzgh7rTRGvTC1xNDsdztcZbQwrnXeE
	 GFbEirhyzSmPcr0eGZLGwV2RFpT9r6WrGwm0j1kfHS1UPSNCKRqOFkAzLP0OzsSRb
	 ajMH+qseAWKpP1oZE4oOBg+E5vwlZXjJp6UrLNMXVHqgvbrYdW4kv0Fl44rEK2ofl
	 7tdddv6I9zdlMLKCHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MwQTF-1sK7SE2D2b-00r6Jx; Fri, 09 Aug 2024 19:52:23 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	ghostwind@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: lg-laptop: Add operation region support
Date: Fri,  9 Aug 2024 19:52:11 +0200
Message-Id: <20240809175211.5962-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S2Gba/dzy+axnkXov6OUP/bu151m5B3WEqdTfunCuh24GpiTDrj
 02UKzJQuvb+hX1nK9Dunkftz/74bar+q/vmkf4uPwnju7aLucTIGoNTwmy3YHU6t6rzdUWD
 r8Yp+RJS6Pm3DJwZXg9jj4SaQQ6/ZqgLHq3u57O2jwjpSXTsBgm9+Kc0xhAOOkeBZjGbUq3
 KeMBP8QB7shddHpJhq1Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P9/ER+1wjRs=;0m7fW+xcuJqSbvjcecyvL4V49Lt
 iMsjS2N+2kQh0ai2u7ajgnxydGymFAn2kKWEz8ZjrSdyE5/4Avm2u2BuI+hUuqDWFU/jyz9iT
 xAaa5KomSfV2H7jSNzehGUarh3ceO6UQaLsY60O3QdjrypU8DoeGcoJHTwc0Psd9CVOKYGiD3
 QBw7iNg4UwfgmWAOhQi3lF/GP0YIMbT+xoQn+Q0OarQKKrqEkzvoRn3DI+YtXLPYgAirMiequ
 LeBgZ7sk6fDDJEIVvF4DeXZkJNQBQvYK0rwzgx6B6aLZLNJSZVVv78FZ3Ja/ZrdFOPbTA+NUZ
 pdT9oceoJRKKtB6QsyK2TowaQOtrtPFHVibA0FMheKq5ui00ii21ZLSIAN3Z3TK7s64Vg8M7/
 ReI/1cwoOtt85/mTKIFoilidBgqPInU0qW/FNjzT++f95CEPJQL4sr1wwqPyhpt63xfKBNrZ4
 vxNpe0Xb1EXHvWZKJxaUhzZq68BtTZVb1N6fHvKKSF1rvYmD6pkI1LejJnSN37F4mEQdPz0Fb
 7t/z81dZ/vXflALsHBkC8mk/kveoIQnbg8b2GELJK6X7MPdpDBbqZIwaMGUCfqMQA0x5SfEw+
 xDvN+GQoFaWgFfN5USJLDI7z9GxV5IBgdu03McIz9oD77EPUPjjdkucvBala9vu2D3T5WDMey
 xuR/jhijwCii9DVTEMbw/B4TXVXCIEDL0vcaS+QAkznLy9YmW+OeOI4hi15aoCSw9HQ68CcYT
 rOgRtbyAOX13Bs0qQT1h3JEAJLyxAk7+la7+n/e6cGu6ud2rUbPcFB1T/iKPBRz4vKVEGtoRD
 ltl6aRBsAgXq4tj2pwYE2eeQ==

The LEGX0820 ACPI device is expected to provide a custom operation
region:

	OperationRegion (XIN1, 0x8F, Zero, 0x04B0)
        Field (XIN1, AnyAcc, Lock, Preserve)
        {
            DMSG,   8,
            HDAP,   8,
            Offset (0x03),
            AFNM,   8,
            Offset (0x10),
            P80B,   8,
            P81B,   8,
            P82B,   8,
            P83B,   8,
            P84B,   8,
            P85B,   8,
            P86B,   8,
            P87B,   8,
            Offset (0x20),
            DTTM,   8,
            TMP1,   8,
            LTP1,   8,
            HTP1,   8,
            TMP2,   8,
            LTP2,   8,
            HTP2,   8,
            Offset (0x3E8),
            PMSG,   1600
        }

The PMSG field is used by AML code to log debug messages when DMSG is
true. Since those debug messages are already logged using the standard
ACPI Debug object, we set DMSG unconditionally to 0x00 and ignore any
writes to PMSG.

The TMPx, LTPx, HTPx and AFNM fields are used to inform the driver when
the temperature/(presumably) trip points/fan mode changes. This only
happens when the DTTM flag is set.

Unfortunately we have to implement support for this operation region
because the AML codes uses code constructs like this one:

	If (((\_SB.XINI.PLAV !=3D Zero) && (\_SB.XINI.DTTM !=3D Zero)))

The PLAV field gets set to 1 when the driver registers its address space
handler, so by default XIN1 should not be accessed.

However ACPI does not use short-circuit evaluation when evaluating
logical conditions. This causes the DTTM field to be accessed even
when PLAV is 0, which results in an ACPI error.
Since this check happens inside various thermal-related ACPI control
methods, various thermal zone become unusable since any attempts to
read their temperature results in an ACPI error.

Fix this by providing support for this operation region. I suspect
that the problem does not happen under Windows (which seemingly does
not use short-circuit evaluation either) because the necessary driver
comes preinstalled with the machine.

Tested-by: Chris <ghostwind@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/lg-laptop.c | 128 +++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index 9c7857842caf..6310a23f808c 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,8 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
@@ -31,6 +33,25 @@ MODULE_AUTHOR("Matan Ziv-Av");
 MODULE_DESCRIPTION("LG WMI Hotkey Driver");
 MODULE_LICENSE("GPL");

+static bool fw_debug;
+module_param(fw_debug, bool, 0);
+MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
+
+#define LG_ADDRESS_SPACE_ID			0x8F
+
+#define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR		0x00
+#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR	0x3E8
+#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR	0x5E8
+
+#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR		0x20
+#define LG_ADDRESS_SPACE_FAN_MODE_ADR		0x03
+#define LG_ADDRESS_SPACE_CPU_TEMP_ADR		0x21
+#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR	0x22
+#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR	0x23
+#define LG_ADDRESS_SPACE_MB_TEMP_ADR		0x24
+#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR	0x25
+#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR	0x26
+
 #define WMI_EVENT_GUID0	"E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
 #define WMI_EVENT_GUID1	"023B133E-49D1-4E10-B313-698220140DC2"
 #define WMI_EVENT_GUID2	"37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
@@ -646,6 +667,101 @@ static struct platform_driver pf_driver =3D {
 	}
 };

+static acpi_status lg_laptop_address_space_write(struct device *dev, acpi=
_physical_address address,
+						 size_t size, u64 *value)
+{
+	u8 byte;
+
+	/* Ignore any debug messages */
+	if (address >=3D LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR &&
+	    address <=3D LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR)
+		return AE_OK;
+
+	if (size !=3D sizeof(byte))
+		return AE_BAD_PARAMETER;
+
+	byte =3D *value & 0xFF;
+
+	switch (address) {
+	case LG_ADDRESS_SPACE_FAN_MODE_ADR:
+		dev_dbg(dev, "Fan mode set to mode %u\n", byte);
+		return AE_OK;
+	case LG_ADDRESS_SPACE_CPU_TEMP_ADR:
+		dev_dbg(dev, "CPU temperature is %u =C2=B0C\n", byte);
+		return AE_OK;
+	case LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR:
+		dev_dbg(dev, "CPU lower trip point set to %u =C2=B0C\n", byte);
+		return AE_OK;
+	case LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR:
+		dev_dbg(dev, "CPU higher trip point set to %u =C2=B0C\n", byte);
+		return AE_OK;
+	case LG_ADDRESS_SPACE_MB_TEMP_ADR:
+		dev_dbg(dev, "Motherboard temperature is %u =C2=B0C\n", byte);
+		return AE_OK;
+	case LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR:
+		dev_dbg(dev, "Motherboard lower trip point set to %u =C2=B0C\n", byte);
+		return AE_OK;
+	case LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR:
+		dev_dbg(dev, "Motherboard higher trip point set to %u =C2=B0C\n", byte)=
;
+		return AE_OK;
+	default:
+		dev_notice_ratelimited(dev, "Ignoring write to unknown opregion address=
 %llu\n",
+				       address);
+		return AE_OK;
+	}
+}
+
+static acpi_status lg_laptop_address_space_read(struct device *dev, acpi_=
physical_address address,
+						size_t size, u64 *value)
+{
+	if (size !=3D 1)
+		return AE_BAD_PARAMETER;
+
+	switch (address) {
+	case LG_ADDRESS_SPACE_DEBUG_FLAG_ADR:
+		/* Debug messages are already printed using the standard ACPI Debug obj=
ect */
+		*value =3D 0x00;
+		return AE_OK;
+	case LG_ADDRESS_SPACE_DTTM_FLAG_ADR:
+		*value =3D fw_debug;
+		return AE_OK;
+	default:
+		dev_notice_ratelimited(dev, "Attempt to read unknown opregion address %=
llu\n",
+				       address);
+		return AE_BAD_PARAMETER;
+	}
+}
+
+static acpi_status lg_laptop_address_space_handler(u32 function, acpi_phy=
sical_address address,
+						   u32 bits, u64 *value, void *handler_context,
+						   void *region_context)
+{
+	struct device *dev =3D handler_context;
+	size_t size;
+
+	if (bits % 8)
+		return AE_BAD_PARAMETER;
+
+	size =3D bits / 8;
+
+	switch (function) {
+	case ACPI_READ:
+		return lg_laptop_address_space_read(dev, address, size, value);
+	case ACPI_WRITE:
+		return lg_laptop_address_space_write(dev, address, size, value);
+	default:
+		return AE_BAD_PARAMETER;
+	}
+}
+
+static void lg_laptop_remove_address_space_handler(void *data)
+{
+	struct acpi_device *device =3D data;
+
+	acpi_remove_address_space_handler(device->handle, LG_ADDRESS_SPACE_ID,
+					  &lg_laptop_address_space_handler);
+}
+
 static int acpi_add(struct acpi_device *device)
 {
 	struct platform_device_info pdev_info =3D {
@@ -653,6 +769,7 @@ static int acpi_add(struct acpi_device *device)
 		.name =3D PLATFORM_NAME,
 		.id =3D PLATFORM_DEVID_NONE,
 	};
+	acpi_status status;
 	int ret;
 	const char *product;
 	int year =3D 2017;
@@ -660,6 +777,17 @@ static int acpi_add(struct acpi_device *device)
 	if (pf_device)
 		return 0;

+	status =3D acpi_install_address_space_handler(device->handle, LG_ADDRESS=
_SPACE_ID,
+						    &lg_laptop_address_space_handler,
+						    NULL, &device->dev);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	ret =3D devm_add_action_or_reset(&device->dev, lg_laptop_remove_address_=
space_handler,
+				       device);
+	if (ret < 0)
+		return ret;
+
 	ret =3D platform_driver_register(&pf_driver);
 	if (ret)
 		return ret;
=2D-
2.39.2


