Return-Path: <linux-kernel+bounces-420181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8659D767C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB056165519
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E91442F4;
	Sun, 24 Nov 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SQLwZXDW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94313C67C;
	Sun, 24 Nov 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468493; cv=none; b=dFjaH3kX8NqS44nyOwqaQRQV89o3L/52WMNGL2I/se5DktxaBh+ELUj68uyYHYjT5bqAq5W6BPVSkFrQ0KIoVf9FkMhMPxioxSy3NBwM7hVXK0ffh4sygyXJ51DDwNObuEzV0mUrF3f2zDll7QR1N4DR/e6jXXwgi84JTqi7xQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468493; c=relaxed/simple;
	bh=jeJr9pNckNqyUtItMreZp/xbZoNuzRhND+ij3pWjuOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJHn7ZevJiwdvLa6T7DdtaI0ANhGqk/P61DXcAzGzwOR++mGWl3Xf4sYbN020N08+aidr0gMIsKG7yd+0DUJPfBZg+jKwedWHg9QxuquDDjpQMN4jEWOOdrRCHkqW2lc+YzaONJiBFNfgjW+QOk27InhbZKU5QavhbFIsosnJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SQLwZXDW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468484; x=1733073284; i=w_armin@gmx.de;
	bh=5csBIJ5NYZF2Vp9CmRhZS/Mn3fYDpyfQnXs60XIx8Pg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQLwZXDWbTF8IvY2tBCLl0FHl2MjME7GiYMKQ9o+ZFHUu+9K3SdaG7RYRm5CyM/D
	 inJ1S7kD3/fVFl1Kn/EuvM5Yzrfo23sKHNp6Ckuw164DjTFl+vOSGHAURSLsxosET
	 VLcvznSFudLI4BcKg08HbqJ3PVAyvwg3Xy9bt1ocu2M0W5vIdTffKDfA7Dgw9KU/z
	 CE/xLsUCF6HaKU1rg1TApPzdFIq+H3teMRyPkVrnmQAt6eYIHRBpksAkYDaZ0Z6KF
	 8C4XMvqXefGW/Iqu4Ad6eFuYtVTbA++LiGdepJvy6SAXhvg8UZWobk+sWMveAf8Op
	 qUJAfFXdfin8Kby7eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MJmKh-1szVYw3IL3-00U36N; Sun, 24 Nov 2024 18:14:43 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] platform/x86: acer-wmi: Improve error handling when reading AC status
Date: Sun, 24 Nov 2024 18:14:25 +0100
Message-Id: <20241124171426.29203-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241124171426.29203-1-W_Armin@gmx.de>
References: <20241124171426.29203-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KTC22Ub/XvgdO7f+LCMCexLP8K3fbNSob6bqwD7Gd9k0/u10VwA
 xnURzPzjH8Feyds3Tg1jEBunojOsuDmpyiyX3CQhGyaKS//9+muBf8lxjNGRbSKTVlzZKd4
 6d1uMTazSwSdd4SdV3ARWTjVELvsJQIps/kH0PPKq+Yem4kzGLwEPOhrNwPnutA96+iESBT
 7jMGmHAmQ5oBVw9xyuMZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dv3MOpZJ4fo=;zNSBzA0V4DBUC/bdoLdrUmGJbkH
 Fd2Ngc29Wwo7q4hYu3cAGSBMG0b+24arxGdPLmnFlsqTqdfOH5hBRI3XNzfXT7s1weEIoPhhm
 2XRJx/rxj7gUzBsQNmZP3PZn++6aKGZyRxThwlHcGxtQnEtm5Z7RawoqhAltnrw/B64R+YKSh
 5cEYuomHe3VrBz9K2zV/HMXk/6ah6avtZ210XXXqvZRsV0U3y2XHAZKmZLKHPGSuPpysORbpF
 CUh7672wVGiwao4lNdl4WzpVJrDfL9YIWemYk4njfBPHHO+swHnsJPOkchrxG15Gr9YWS5Ta0
 IcyQ3OfnsUWo7aOgfSf5siWztC+5uiRczMaaSxRCR4t3L7/JrjtVcV8Sp0sdjRdOMYSal3ZMC
 mg/HTPyjjbGdoekHWruD80YX7AucOnsFUPstluNfVmm4lCRaQswqF+2rHVbtN1CQQAJ2AwcvG
 mNu3qlYCGKy6btWB5YVeOvIuZN09Rxwi3ni9vmgOf7R3P625AyEHINijLbiDNN1fCaS2wP5dq
 p5r6LA+uoQQsfYmpc+xsoScqd/QS5xsLgz6OCf+ZwhU41mDdygGbG7e48fFLqghbRpK0cWRQ7
 rCIvQarDkTAtE8Et947EGfB1yw29MsiL5joAv9IwIeAcle89VpuBDM+/c+bH1geV9DqM3736g
 QSbYndnavsD1WTHz1R06vov8xDjcQoepjE1lthiAzKAQMnOkmpAJIWF63DHNYwd6ocuBZci2E
 1gnOjiMoZH5f5ZScDvnN2rtMIPCHwXhmEwX9FQCHjejPc2ujMD5muhhpomwpL4sColE1PhJaA
 5jhwTUegkW+m4j5bT0zt9GOCx9P6OENJntG4+nCBal4C95Kepo0eA/4H72j355cwqKE7Ld7Pm
 zxt2b85vESr34+ZAl5ki5FNeLmZXCLP9WP8akUmvEMT3ghtWVHiU5wwf4

If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
8 bits will be non-zero. Use WMID_gaming_get_sys_info() to check for
this when reading the AC status.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 7b549920eba7..6964fea84fa1 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1951,12 +1951,9 @@ static int acer_thermal_profile_change(void)
 			return err;

 		/* Check power source */
-		status =3D WMI_gaming_execute_u64(
-			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
-			ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
-
-		if (ACPI_FAILURE(status))
-			return -EIO;
+		err =3D WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STAT=
US, &on_AC);
+		if (err < 0)
+			return err;

 		switch (current_tp) {
 		case ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO:
=2D-
2.39.5


