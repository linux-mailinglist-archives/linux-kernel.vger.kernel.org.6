Return-Path: <linux-kernel+bounces-205159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED88FF837
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72147289C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB313F44E;
	Thu,  6 Jun 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gvpX9uyu"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A54D9E9;
	Thu,  6 Jun 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716966; cv=none; b=NvTlCkug39Z1tX1EgPPUO/Z7lWEWSj8uF0sboXT7PSn85S4ZnMZNiAzCs4BQLs8/wIzQ6J4T+7AispY/I2WBmNdJflZlfiJQf2LUQFgPGmom8/dZrrnGkBwFIQ259XZGny9dXRxTje7NA80AI379I4lDlrl99g4uiaCg/SKKC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716966; c=relaxed/simple;
	bh=CszDyLkit3de2JZWz7Ffnq1hiMqWQuFV3nWNx51JSHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P92qvF39rcL8x7m2qriuGBLxm4UZ3tpgvAGuMRyiXt6JubPq6aCKrvGz1npWA8v+qwPCN5Xe4Hgh0ksXCsr6scpFhyUwPNBvUHDuHa3yKc6VCwk/XaWoRBo6FpMh723bguE8YO045YqYQEVsJ3gdRTlEk8twn/ku4M79g9Lx0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gvpX9uyu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717716955; x=1718321755; i=w_armin@gmx.de;
	bh=ls7bbEgPyWSpw4Yu8LPj3JEysDNJBAPZLyyhcFGu83E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gvpX9uyu/8A3ND5tnIKz6j95NO40vevlzQFO18WtNqNK92nqh51t1t/HMMBn2SIJ
	 qogdl+R3GgJO8o//Osr9h3QMW04t897fMNYh2N6M0hk8Nfr+MON0aJABHMm6Zs8AA
	 AF5P7zmPJ3Mu7KFuxX+7ANGzEtUkyxs+lV9dynoxBSr4AWR5hiO0PzGBLT45MB8oH
	 UT3SgxEbnJJ9LdKCo11FdwP89U3yTbUhIZaCmv92p5//Zbk4kwqvo+GM06zWwf70l
	 prcxqTvJD2QQOBc/63Rf/+V2ocFXRvTfvzZco93ZXE3hQcaf+sfwdshPX8cFmjBfr
	 FFMFMuQJW5x4JX514Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MEUzA-1sCfku3bJa-00GkmE; Fri, 07 Jun 2024 01:35:55 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	agathe@boutmy.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: wireless-hotkey: Add support for LG Airplane Button
Date: Fri,  7 Jun 2024 01:35:37 +0200
Message-Id: <20240606233540.9774-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606233540.9774-1-W_Armin@gmx.de>
References: <20240606233540.9774-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mj/34HTANbvlRo/35nqfopFGSdz1vprlRwqVKzNwP7eHuxrCn4I
 WWPx2AEDPtyjcd5LMICltjh9KUTyTVFTqaxwyks55aTYLaLZ56t60n1K1cktj3EApDKs5w3
 81XZ62tDg/zT0iFhRAHlW9L8d0Z28uMdE9Yllbwl2Ryi6p6mh4r0LsfA6hAJeizaHkdS+PU
 Pl0nxIOS8KP0sLF5wKZYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YMOj+HmkksQ=;U+a2OK8ue6btpop0GkP6qB35OoV
 bniKoh/POHGzcRLLMR2Jz/663KtcpkiGnBwgMjxzOUiorITtIvYr0SzwgAuHxiooVwqh+0WC7
 uj2WJs3WldTPD8Qg5HxC5ihZ1QL6YVk37e/NOKd7271cMTIYdMQYqtyctFekDEmnxkryKeQEf
 e1+PgP+P9K5rfoZLx+Oc8SgBauiBlyE6/e3i82S7J6FV5gaDWR1YObKT2BEmUzCdHvAeQYPpE
 duhNw+0rVnfSxwD/LCibtT4vFObSzcyTHO8FDMoHTh8PhKG1rQsZBci3WCkg2MqTh8Exx++7h
 vCw/td6SzCEbjY3XK9H5g452TkRAnd0rcc5unFWwsjfKdQNDyK8xyv5mOllv3kPSlJVqUSNHB
 /0su+Z12tCo8EBsGNt+jo1K5fcDsB6iBst3aluiKpSPuVyWwbvjNJQPr8wwSnIc+PnWm5EdIz
 5zVVSXZ8/RZGHgJ0a74yRl4jB+Edl+56Ti5/0gkuOUsUJOFnvbZcc4ZtVemt6Jnn4GpT8zuLY
 fsB9nqUjIjOfgJf9KMknMV6CvakIQnLeRKrd9FgmI6KSEa+sDXtiPgdnS06hSQhcVVMFzqYx+
 XvMqmzNz89auTuf2IzHoJ5FDRh8qiIG+SCay8tpjTo3QJkKXytFB9ThKeRVS+WZ3uVnT0idOh
 fVbvwocfwWA293THqYHjaxnEqm8j8p4iTvL2EcIgHi9iYaT05ImcwZRiv+hhcLhpWYwG6A80O
 U9jMzkzF3bQ8bF/H4VE80UiRf3vg5cvjeovSG+16WQ+BYbDI6vn0Fga035DMzf1xFTsySkbJE
 O+19QTu8DnJcrByVCzv6Wn2O3dZz4D4Zm6OMJdEneLc70=

The LGEX0815 ACPI device is used by the "LG Airplane Mode Button"
Windows driver for handling rfkill requests. When the ACPI device
receives an 0x80 ACPI notification, an rfkill event is to be
send to userspace.

Add support for the LGEX0815 ACPI device to the driver.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wireless-hotkey.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86=
/wireless-hotkey.c
index e95cdbbfb708..ab46164cbe13 100644
=2D-- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -19,6 +19,7 @@ MODULE_AUTHOR("Alex Hung");
 MODULE_ALIAS("acpi*:HPQ6001:*");
 MODULE_ALIAS("acpi*:WSTADEF:*");
 MODULE_ALIAS("acpi*:AMDI0051:*");
+MODULE_ALIAS("acpi*:LGEX0815:*");

 struct wl_button {
 	struct input_dev *input_dev;
@@ -29,6 +30,7 @@ static const struct acpi_device_id wl_ids[] =3D {
 	{"HPQ6001", 0},
 	{"WSTADEF", 0},
 	{"AMDI0051", 0},
+	{"LGEX0815", 0},
 	{"", 0},
 };

=2D-
2.39.2


