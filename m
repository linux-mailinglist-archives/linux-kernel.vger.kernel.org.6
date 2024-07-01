Return-Path: <linux-kernel+bounces-236938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C439191E8CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653A01F22AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EEF17084C;
	Mon,  1 Jul 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZRG/62xQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D4170829;
	Mon,  1 Jul 2024 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863155; cv=none; b=VThe6oboIm9l82Q2UsaO928CvMFBYqoHagakNSqsQ7sCPykJxmPQIJSoub6alfcbjRsHHCF+uI/VP5rvd6aMSiMT6HiA5OA5VfPjZy6ABoiA+E1vbX6SvhmP+tyBV+scW2r+ELhFRY8GgMMEbmMPqbNWMgsscbzwFHhGqEat8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863155; c=relaxed/simple;
	bh=1dzYkIoQq7jXNDs7/iguWByuLCN/7rusCVeClH16S3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l1f94G54qk9o0GYwveQw2eghmRZEGFZIdYl//ZSa4e+SJI4TaM3C0BlVryDfVKlD9job/R1ndTXNDR3Azddjleza2mXPvLMQqkFz58QidR/3Hfc7QJPEWbso8wNh+wS//PQ0PMJkgrvFRdEBL4WrJUbCNi3+xdbKUWc7DM3/VGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZRG/62xQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719863144; x=1720467944; i=w_armin@gmx.de;
	bh=60e1cvO011/WrefJIyp1GUBREQSkNR+xmDwAyJVjRqg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZRG/62xQ3yRtqi5j3CErDhhzpSbKxSks1xPOBOyFxDi7hHEvXXe54IZDMZh6YdZc
	 ThbAVTyDpbLUnr6hx9ry7PETwEp/FZS0ynMtX+zCvme3soe5uYjQIgRJAKuw/Im1s
	 rkM++WdZKtFxIBHJY2XLvVusByKCU8GU1qW76aIRxWPLGBhkya/25s78zksQZYVjt
	 VuxxWNWw216OEpmGCbjrxE7EDgFbyhwPz42zIT9ApU9mmxyGE3UZ8y0ugV1ZNTQTi
	 yfTi9Qa1D8TD5XudhNc2X68Z7GEdZalx+hB1Tbgx8BEww9K/esfZw8XqNZNdJGm1y
	 Y2lxvJNhIVpw76l4+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIwzA-1shh2T3aFm-00L3id; Mon, 01 Jul 2024 21:45:43 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: coproscefalo@gmail.com
Cc: lkml@vorpal.se,
	kmal@cock.li,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: toshiba_acpi: Fix quickstart quirk handling
Date: Mon,  1 Jul 2024 21:45:39 +0200
Message-Id: <20240701194539.348937-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TH6oq55UceMJ5dcs+TEYOr66PizX+3yJ+gHNATIfN+505gLYwGs
 Ie+15nyZkZ+YWphM9Zqj2/DvRpL1/bzCba0jD/ebs0HL7ISCo78iX4hZqLZkLUG3CLetXQb
 yyBWFo3Lg9Mv6n5AlYjmHebSTNLcalm7sEI/d55Jdz6fdSXLI7Zyx2jF3CEBDo/wfiHiPGi
 eV2MWwTVfEci0/tYNtqpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DBOTM8PFdes=;6e2AdNsMGFHwfW+awENqQSJxl4H
 YE6rURiKuumkepYoSOLrPHKn0ErVBqzks9LM+rZnKX3xnp4OaCLhvJJB1+KMiWQnH3VTQ3/aI
 o3VVYUg9Z/QwQ7NxPPhjGyqttlJWLGNqeZ58gGgUlTsLk8o7h99iBRQWp7wH4kY6qxd78rQjC
 BFX/TcN8p/GAMtp+4kPoFYlL3sdKlrY3ZNLwf57BxpdlJ3bJkHfzBCIQJGbIyOt210zfPYE4e
 9sOH/bVzWkvLdRg+LOEELVWF64PYPkTCiYxEBBlJTY76VKUeb3dgCFFnaScUdz1PVmfOM3ZbT
 SigKqsTQvtueLrAZ7swrQNwbAbwYe/7dx0cywkedbFd9XZIymsn5UhJuKkmMAu15e5MGFiudQ
 tjK0y6pLeAFWOqVzFAsE6vDlFJQ7OZC6WAv+9wTlToAxQ4zoKEHqfZ4RHSQG6F3MSWXMdQmrt
 7HkN+mEu3Qtx41KkUgnybBUYg4MPD+KvFPHMgUAHZvCAZ07tRc72HsNFidcYlGHaBxF7hhJWi
 5itBgJa6WT5qGFpPSM3vh/pyAc2uonB1cv1LmwpLuTbJ/Jqp8ZGYU/DAtAQJqmMafBzTY0A2b
 McPDlKFYaI+boIc3/6yX/UaJS+vbQPiEti1RPdM+tbyqEh8N+kyCouIKSS6+SUz9P5mVjon2L
 mz3wQ4wu4wmQkiEnijpvEr1FxRPb25l+akD/SkUEakS/ELH9mH3XoQMK6/uG06Gmm8UA1g1sD
 HptxsyLzwViAutDCH1SSXb3IxX2He+9iV+9xO2LO4fqpm3xEMWX3F0wEjYtj5x1SP9HciuWA9
 dgFgd7F20LOEby1eQclblQOPyfJW4qJa1waEzEGve/T1TYVkjd81CvCdZPWUL7rnK/wYXw9MP
 aJrYLng2RSQVMOw==

The global hci_hotkey_quickstart quirk flag is tested in
toshiba_acpi_enable_hotkeys() before the quirk flag is properly
initialized based on SMBIOS data. This causes the quirk to be
applied to all models, some of which behave erratically as a
result.

Fix this by initializing the global quirk flags during module
initialization before registering the ACPI driver. This also
allows us to mark toshiba_dmi_quirks[] as __initconst.

Fixes: 23f1d8b47d12 ("platform/x86: toshiba_acpi: Add quirk for buttons on=
 Z830")
Reported-by: kemal <kmal@cock.li>
Tested-by: kemal <kmal@cock.li>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
 - add Tested-by tag
=2D--
 drivers/platform/x86/toshiba_acpi.c | 31 +++++++++++++++++------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index 3a8d8df89186..10d0ce6c8342 100644
=2D-- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3271,7 +3271,7 @@ static const char *find_hci_method(acpi_handle handl=
e)
  */
 #define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)

-static const struct dmi_system_id toshiba_dmi_quirks[] =3D {
+static const struct dmi_system_id toshiba_dmi_quirks[] __initconst =3D {
 	{
 	 /* Toshiba Port=C3=A9g=C3=A9 R700 */
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D21012 */
@@ -3306,8 +3306,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi=
_dev)
 	struct toshiba_acpi_dev *dev;
 	const char *hci_method;
 	u32 dummy;
-	const struct dmi_system_id *dmi_id;
-	long quirks =3D 0;
 	int ret =3D 0;

 	if (toshiba_acpi)
@@ -3460,16 +3458,6 @@ static int toshiba_acpi_add(struct acpi_device *acp=
i_dev)
 	}
 #endif

-	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
-	if (dmi_id)
-		quirks =3D (long)dmi_id->driver_data;
-
-	if (turn_on_panel_on_resume =3D=3D -1)
-		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
-
-	if (hci_hotkey_quickstart =3D=3D -1)
-		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
-
 	toshiba_wwan_available(dev);
 	if (dev->wwan_supported)
 		toshiba_acpi_setup_wwan_rfkill(dev);
@@ -3618,10 +3606,27 @@ static struct acpi_driver toshiba_acpi_driver =3D =
{
 	.drv.pm	=3D &toshiba_acpi_pm,
 };

+static void __init toshiba_dmi_init(void)
+{
+	const struct dmi_system_id *dmi_id;
+	long quirks =3D 0;
+
+	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
+	if (dmi_id)
+		quirks =3D (long)dmi_id->driver_data;
+
+	if (turn_on_panel_on_resume =3D=3D -1)
+		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
+
+	if (hci_hotkey_quickstart =3D=3D -1)
+		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
+}
+
 static int __init toshiba_acpi_init(void)
 {
 	int ret;

+	toshiba_dmi_init();
 	toshiba_proc_dir =3D proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
 	if (!toshiba_proc_dir) {
 		pr_err("Unable to create proc dir " PROC_TOSHIBA "\n");
=2D-
2.39.2


