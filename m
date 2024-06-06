Return-Path: <linux-kernel+bounces-205160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F7B8FF83A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517BC1F25FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373D13F00C;
	Thu,  6 Jun 2024 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EMXEqH0E"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AD13BC02;
	Thu,  6 Jun 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716968; cv=none; b=phcR+ie4AtyujEa+NBaMmOkEq90CsfOcjT+R3gDjO3zg9E8voDAtp6ybUistQ9FI73YvxE8O5CBdxqqM2qJQxUrTTg9v3LZyF3MWBjDonTa3jem/4u/ZA+9b9ciBfoOsuVFu4ecEwC9LmyIuuleH/m8VCz8eXHjtWmQhtuaCOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716968; c=relaxed/simple;
	bh=otV4zp1MoGFcTiETzXfR3TcxXLb4cvvRGl8k3ULZ0sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IePemqVJEmqBasGVenCGYIJJ1C4c5f+fzF4BKlaomK8+3dNCK2/fLZ5COenThPc3UolDJIM1Ml8JheHKNm85jP258w4ulWAFuMzBkI7wev41h4okxu/yHoCtIHcF5+FBGJxSyZLJrGdsp8et3Ic2dROrbf/LDDsxG2VfglUs1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EMXEqH0E; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717716958; x=1718321758; i=w_armin@gmx.de;
	bh=ISDNXycXxWS0qiiXv/+/ANk/YpjMLHNtNunSMSoCI94=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EMXEqH0E7UooufD5REalm+XgOuY1ZRzgM7v00fquYiQeY7sCUJ4+wwk5maSIIh7w
	 uaizp24FDwLG85dT2snxzv55EJfM60jmj+/VxGjdHBjWQVIyOQSV0YlmE9aMHyPWQ
	 CU2BUmOAw7R/1qll8lAtMHgWbU3ZFmEry5KFnJgmsYhk4ZSu2cQr31q17rj8ffuAT
	 BgUBxPJkS068JkDiDr87HL+h9PYCgS12/lwSTmYl97kuedDs/92aMEpYTmJQghrB+
	 3YTwwHdClSg5ZIoal4nUv28V4SYeS87Fl93F4gcpsoPQYtP4mt802rc5386hvmLTj
	 i+PzVChIe8jDCDsT3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MsHs0-1sYggG02mY-014Dw8; Fri, 07 Jun 2024 01:35:58 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	agathe@boutmy.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
Date: Fri,  7 Jun 2024 01:35:38 +0200
Message-Id: <20240606233540.9774-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:DIdyGUYS8BPW7Q9MzAcW6zeIXzDGwemyHaDEjkBvBDmwF3sTIMx
 8wF2cnYmpa+/deSSBjREYMcodtsv7gl4Qkii67si1G+ii/WV4Ab79D8rI0EknkQtGdH6uKE
 7htEoZxF5sf5Bv78VCY4Dv/+W6HpgP56Bv3W1VPfoxJP2xp7MFooE8tG//fFcbCdLSkvzlc
 w9g+pdgBP3Z8Xhu1gmOtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YoPEzoASVvk=;FrKHFjjPPLCmrwJdNHNjg3KzhM/
 Y1N6w2rL6jNDzUSqfTJu2pFruthpBYZ6NmOgGqHFQIugsKU0X3ZsqSUmE/YQcNVJl+Dd7UBC6
 YNfSq999qBdvNuMKH9r3b+94CgdEybT9/JEVAOssVD/tjmK43yG9dGN5mQQmjKZ5lwcw5aEb4
 ep6kWHcAaARboq9FazJlep9dlVd2PuDLNoTfZP4C7+gFvCadYz/JqYW/hIQg3+aFKLO09DYQ4
 Y+zJkvpRiN/eFf5yzzCcxQKWkPDgigVKRzraI0wJSsbVLpwLW1sjR3DLZwY9KklbM/zOP5HXE
 DjwX49Cln9C4GIwsBU28LKXNmbYtBtQ3voNa9c2VXYbpsEp2Umk7L6ZfKftu2IX5RWkcvVYey
 IbJK05CjdygNMgi9/APxb7iyHb7QR1KaJXcRGSdIBhmO+819hczONF9oSy9LFyygQWh78crZU
 dFzK81Rwi7CsyEREAM0dUnOoIyiVlixOsbzjau6QRJsiyWenbNtNcEK+azeCzjXbRGQGJGNeq
 L8AHvYraJoCBfdwH5gQJL0gW2ZQ1+HaLIsmI7NlrQdSnx9S6QueWIaner2wAauQZfOGdeLent
 HkQ7oNQXMo2ED2ntrnQfPi/TuDR545lx8CKOdtFTsrh2GFVAXjt20heHrCmZqzSeF8xd7pkCy
 8xD+aJGlPsSHJMHrla8op1VmQZOy1SOwOUVaX/VSz7/yB/5nKHrRlDINN/Fmk2tlplHeLZN0w
 3iGLzViDHHY25gvBMOwQfgxZ3VC4qvAK/0BT2iVZQtkBp65YnMjkbEHtid4m3dxsB+fCvAPVS
 54eYqvdqrRNUMvEkU8FmGEehf2lYOArhu5WsH0i2wYjdo=

The rfkill hotkey handling is already provided by the wireless-hotkey
driver. Remove the now unnecessary rfkill hotkey handling to avoid
duplicating functionality.

The ACPI notify handler still prints debugging information when
receiving ACPI notifications to aid in reverse-engineering.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/lg-laptop.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index d0fee5d375d7..ea83630106e8 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -84,7 +84,6 @@ static const struct key_entry wmi_keymap[] =3D {
 					  * this key both sends an event and
 					  * changes backlight level.
 					  */
-	{KE_KEY, 0x80, {KEY_RFKILL} },
 	{KE_END, 0}
 };

@@ -272,14 +271,7 @@ static void wmi_input_setup(void)

 static void acpi_notify(struct acpi_device *device, u32 event)
 {
-	struct key_entry *key;
-
 	acpi_handle_debug(device->handle, "notify: %d\n", event);
-	if (inited & INIT_SPARSE_KEYMAP) {
-		key =3D sparse_keymap_entry_from_scancode(wmi_input_dev, 0x80);
-		if (key && key->type =3D=3D KE_KEY)
-			sparse_keymap_report_entry(wmi_input_dev, key, 1, true);
-	}
 }

 static ssize_t fan_mode_store(struct device *dev,
=2D-
2.39.2


