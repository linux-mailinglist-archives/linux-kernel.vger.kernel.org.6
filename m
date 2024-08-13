Return-Path: <linux-kernel+bounces-284002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE694FBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7D1B21E45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290717545;
	Tue, 13 Aug 2024 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="eEur34Oz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14015A8;
	Tue, 13 Aug 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723516166; cv=none; b=I6GwTtNUHmHE5wOY0Um2/IarTxo82WzwuCX48NxIpjevS+spmo3QhfwRYD2POA5oy/JNqUqUdelLTN+QY53W0Xc3jYaIZTVVE4m05s64JDmMpagAq37KWQQAHMnIhlI4w962P373T8/1nlNot4oyQ/Nf8eq0NnBn9dLre6q+OAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723516166; c=relaxed/simple;
	bh=qxykC2Boj0Z9Aj0YZhuHKcXe4DicZs+D51mT/ZyF/zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eSbGRQI9i8eNYZA16VIkEeC5U1WVuB+wzm192UtoHPuKZ+eE3G5O6lmvjynxHrUKcvoeVFMSJadvrJyGz65slitHuNZ7N2SGabZO5k8W3B8eTXNQIhN+2wN6/sHiyb8rSv4DmJNzmNHFXMDMRDZ8SLPxzPzTjc3oMTIQ4Nru/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=eEur34Oz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723516151; x=1724120951; i=w_armin@gmx.de;
	bh=EjDWZu/Lzer1DLgfBWbtMVkqWi33ymTduQ2E9KilLHQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eEur34Ozlj3n/Hiq35OK31m2+JBagso5A3bLHifashR7qbnJBKrHpaRpugJSmcRl
	 37Im6JRdjbotkMcU8qb220F17ZUUL7/Agg5N6VsIxRGp47hk7uIB68LFf78dD5E+R
	 K9sJ56TiWYrrYxomVqbvZ/x4YEMCq+fY+TmsGd6pgiw23th3MPz9rKO1H5tqA9nSA
	 EQr8QPDvE/8zRCRvswRdU2Cu+19Xm3p6J74iDtl+aDKk8odANGc/St+SdhTShTDUd
	 LCmWsuSHSYMD0tjFLlg2VTVB2Y1L69vcYa0j1kgwhChh/nyGVkJuX28JECd4LVt7n
	 Rtdk8FRKjShRxknbUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MdvmY-1s4uQb0MTe-00d0Kl; Tue, 13 Aug 2024 04:29:11 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	ghostwind@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: lg-laptop: Add operation region support
Date: Tue, 13 Aug 2024 04:29:03 +0200
Message-Id: <20240813022903.20567-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ltxM73CDi41HWHj7mPLY1S0LybX0cc6OsDj3vooGolyLocA89y
 hRaYrqxPsz9u2BDWCAvnT3icOWUnCTkvdtCF1CPJ1FoIQ1TYlXjcpEa+J3Rzoa/D1PpV9PP
 HumIIixz1H7ONvCJZLRsu53VR7dDlYn6iOpWOLDx5FlIxIFQhPMvQOG3zmJPonAusaVos1C
 eY9slcP1eqpAHH6/hCOoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AS9kP3Ze4co=;0HL8pS6z0rsZuH08hGzbqgOqZLY
 gdUnTYDkTVSkF18MWLnhWPZ3IIehXiRRu3W5B26IuoF3P+vX6rpCIOLK18Je3cx85tD0ESYb8
 1OkKkqvXlGTTg3vAYpdvyqC1TrpDQ0xOKWTCK00wG5/mYXvtgzws1YAhNUO/h4O9FPZZw+DJW
 uEvlBThYpgyzpnc7Wkkk+OPOqHZcUOlBEJpIYdKNHIR2LzX5K5XAoDOioEWRncqytYZUX+bVX
 TuSxUxHagHqDo7U5Wj1xP4ntm/CJmc2Lyxl8na4qdJB1JcwrXAmULy+oUOaI7gy9Bxcztoew1
 ly/+6zH+ztfHOf20Eyxv/pkP6l5n1ixmCAZFehDNsHnT+vu0smREz2ITzGoFudxkcC4TGFyds
 POdi9vZElWH1Ij2lnh7lZl5den0mOWjTm6FMTvP0BGw+H8aKl28AMzoNXPVxA6dANqAVBeIEX
 2GNnxQbV9CdzRMmGq/ZQY20GGXER7g4jeDHfsFwGfh21IKB4CRXzHdfiNYUtYfZtrpKbc5jwm
 QNHzqTv9nkA04koSaumPcc9PNWkRite/CnZf/zaHS0NbjJW4K2e1gsyWgqGW1alDuricBSIyS
 YnRWln1SdzpDe68dNtWxmJiHH8eCo5t6KAt2inU8qImvnPkptuUeBrAiDC5MYHTYlNbTTidxh
 J68awyN+SDUyBMrWxBg4gU+BkSTIojWRRrL31NTvOIsFeDo5RL9tZxuXcUiBN7UiVxkcgdhww
 +hwa/Ys6fqsF7K/+CDafABWnRBySnJRNhQWqeoQ8RVs0RkM2G93dcn8GQ4OY3uq9lDpB1uzbo
 AyJaP45aay/nZmHHLEFai28w==

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
methods, various thermal zone become unusable since any attempt to
read their temperature results in an ACPI error.

Fix this by providing support for this operation region. I suspect
that the problem does not happen under Windows (which seemingly does
not use short-circuit evaluation either) because the necessary driver
comes preinstalled with the machine.

Tested-by: Chris <ghostwind@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
 - attempts -> attempt
 - sort defines in numerical order
 - make lg_laptop_address_space_write() take a plain u64
 - use BITS_PER_BYTE
 - manually check fw_debug when handling fan mode updates
=2D--
 drivers/platform/x86/lg-laptop.c | 136 +++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index 9c7857842caf..55d31d4fefd6 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
@@ -31,6 +34,26 @@ MODULE_AUTHOR("Matan Ziv-Av");
 MODULE_DESCRIPTION("LG WMI Hotkey Driver");
 MODULE_LICENSE("GPL");

+static bool fw_debug;
+module_param(fw_debug, bool, 0);
+MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
+
+#define LG_ADDRESS_SPACE_ID			0x8F
+
+#define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR		0x00
+#define LG_ADDRESS_SPACE_FAN_MODE_ADR		0x03
+
+#define LG_ADDRESS_SPACE_DTTM_FLAG_ADR		0x20
+#define LG_ADDRESS_SPACE_CPU_TEMP_ADR		0x21
+#define LG_ADDRESS_SPACE_CPU_TRIP_LOW_ADR	0x22
+#define LG_ADDRESS_SPACE_CPU_TRIP_HIGH_ADR	0x23
+#define LG_ADDRESS_SPACE_MB_TEMP_ADR		0x24
+#define LG_ADDRESS_SPACE_MB_TRIP_LOW_ADR	0x25
+#define LG_ADDRESS_SPACE_MB_TRIP_HIGH_ADR	0x26
+
+#define LG_ADDRESS_SPACE_DEBUG_MSG_START_ADR	0x3E8
+#define LG_ADDRESS_SPACE_DEBUG_MSG_END_ADR	0x5E8
+
 #define WMI_EVENT_GUID0	"E4FB94F9-7F2B-4173-AD1A-CD1D95086248"
 #define WMI_EVENT_GUID1	"023B133E-49D1-4E10-B313-698220140DC2"
 #define WMI_EVENT_GUID2	"37BE1AC0-C3F2-4B1F-BFBE-8FDEAF2814D6"
@@ -646,6 +669,107 @@ static struct platform_driver pf_driver =3D {
 	}
 };

+static acpi_status lg_laptop_address_space_write(struct device *dev, acpi=
_physical_address address,
+						 size_t size, u64 value)
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
+	byte =3D value & 0xFF;
+
+	switch (address) {
+	case LG_ADDRESS_SPACE_FAN_MODE_ADR:
+		/*
+		 * The fan mode field is not affected by the DTTM flag, so we
+		 * have to manually check fw_debug.
+		 */
+		if (fw_debug)
+			dev_dbg(dev, "Fan mode set to mode %u\n", byte);
+
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
+	if (bits % BITS_PER_BYTE)
+		return AE_BAD_PARAMETER;
+
+	size =3D bits / BITS_PER_BYTE;
+
+	switch (function) {
+	case ACPI_READ:
+		return lg_laptop_address_space_read(dev, address, size, value);
+	case ACPI_WRITE:
+		return lg_laptop_address_space_write(dev, address, size, *value);
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
@@ -653,6 +777,7 @@ static int acpi_add(struct acpi_device *device)
 		.name =3D PLATFORM_NAME,
 		.id =3D PLATFORM_DEVID_NONE,
 	};
+	acpi_status status;
 	int ret;
 	const char *product;
 	int year =3D 2017;
@@ -660,6 +785,17 @@ static int acpi_add(struct acpi_device *device)
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


