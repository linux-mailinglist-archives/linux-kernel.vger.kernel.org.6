Return-Path: <linux-kernel+bounces-236874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7391E80C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5031C21CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE516F267;
	Mon,  1 Jul 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Hs7VFFNR"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF110F9;
	Mon,  1 Jul 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860341; cv=none; b=KBYYtPgO6PzIm0EyMVAUkoAdATUjxWetKJYjCk0JiVCwX0eENND3SEosluBfvxrD9qK99GoS52A3rs0xg1Du/rcbBVSFx4O5/4dFH2W5KthYV577IHVmH82lF1KFn/ydj9Z/0awiqq7ivutVXtC6cxbCLMW+4eNLPFFtQlrMJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860341; c=relaxed/simple;
	bh=jetS33nQbJ/Zs44pgSr2icqebgTTKV3ZBtWFKSb/w04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H1+41ogwGEK7B10ySDOUgBOzAhsySlOp0SETWG3GfiNisZizNlPqCZHrsvk8zdz1YluM7ZJrX9lLd5mzOkwAuCb/aDzsoAdTnE7QuqUJikTNo9X7XNPTReAwKxaMhVYj6wKaGRb+dVkyl1GZme87OV2bYCeVf/f2bKrBw7DaZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Hs7VFFNR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719860328; x=1720465128; i=w_armin@gmx.de;
	bh=7PQqll3Iy2KZ7jqD5thlaUNrJgtMeZOmoxeG9yB2+0Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hs7VFFNRpJuhcz+SockAMUmpIcJxi/VRIkEAzQaoJiXE+MMWxI/qfksj7kJEQ7yu
	 XR8v9/N8TqS+KDPWBlHmMfUxIRAsS62M5gEGL4HHNl9i+hihwjw8my43khIa5Ck7n
	 b3WJiE5hNsJ0cdMW5bHDoQHh+mSTYyvqTxslZVj88mER1jcucXLMvyxxGsQI65Afd
	 1H7YUg2dm31qnfwz3HrKNaQo3P668TrPbmSbr05lCfPGGsDlwJ4ucFKCecz0HpPRX
	 5ROTvz6dqIjO123NksOqnZrfclKLbJX9VcJZ3FRMurSnIQ+DzY00kBD/xFQsuUKSF
	 z0gEPbIFFpqMK4Fk+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N17UQ-1sGxec29ec-00zxZ4; Mon, 01 Jul 2024 20:58:48 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: coproscefalo@gmail.com
Cc: lkml@vorpal.se,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] platform/x86: toshiba_acpi: Fix quickstart quirk handling
Date: Mon,  1 Jul 2024 20:58:33 +0200
Message-Id: <20240701185833.338467-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ie5D47L/Y8FZUNY3Atkn23AiXGYJykOJ/I7CgJFWATXloImOU1u
 kvm2trFZzaDZ3goZmpIrwQiumEk/r0M01VrchfY+zSFF6wH+Exj8ROsmFi4KvRfb5XAPh+t
 c3qTYHGr6uEuqohFI/DBW3sVpV5o/IXILtZ0YpcID5v+sveF3puqCNUbxVMvaOX3mtFdyqW
 EYeR+/YySJcjJfAAmRCTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G5bC7GkwdCE=;fW3ZCW6zpV3cg1MPBrTXNi1Ce63
 i5uX/8l1bHRN1BOBhEb2hmbKqeHMZ+z3RcCzTfnv9rmKDkQlOQ6UgwiZscdcLER4viM+KDnmm
 ytOEp0Yqyus1Titee6jmsM9EHa76HkFGJjB/CZ/guVwC3Sp9tuMEvtMZVPH5SngrU85oXcSTs
 36RoT47MWpO97Jmv2PDkNxK0sRfq1XoOT10YDOdM3lcdpjmfvl75unZqk/3wdMeVGF0Qjk9eZ
 Kylydiz66K5iscaQNVL4Lz/8Vk3aZt9ksGeFn4l170mWt0rXZeHX5MoGVxaJ0ZNCya0e+LTsQ
 QPcjypN+n6vFoBKyZzdq/7GRLATk5Hi7eyPYSvFDKkKdLkVT2nIUY367ftcKp3/bImr/5Zvj7
 rDejBWgi7Ynzzdb3d/Q00iVQbBmUWhIu6kssW5cmlkS48K70GdETj0TApqImd/HObWNea3aEi
 GM75tP/XlgBagdZHLfHm6dyxrr6yaERwF7Sg5yIPFW7xUlZrWT772ZUtpTBNqmDg9/J3uGROf
 SrSISDRs8BL21mSRf7jUOBWUvYmQ0hHiS0alKQBMKGYIY4Ge33ZtYA34gtOOY8ZV7cOXnfGIJ
 k/PKKkneUXqJDuJ03IFhKBZYjk7BdEVSPYc0gSAughD5pY30YC/KplGX1CkIqgQuiZuxz5bM5
 gOgAnty6lUbqNHxJStVqBvi2EA1IgIZz6yDYonSLHDSYetNsIWMppeMnXVvgAT6mhIMX80Yo0
 YtTQN2WeakFBW+2qmyrqg6qiafHMZhUnetZqJK5vplgW8zSRaiwOVVD+o0td9KhMg0qjzDxd2
 YY8VviLqJoo7zYuXFx8ye4e+O9WOGWkG7xWLhLmQtvHQtptVLJBmZiTmXHUV5aDNYEEiPw3Ce
 nIBK2o2iS1HdjCA==

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
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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


