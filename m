Return-Path: <linux-kernel+bounces-516772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7ECA3772E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11151888952
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D01A2541;
	Sun, 16 Feb 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="toO+fCLo"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0914AD0D;
	Sun, 16 Feb 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734410; cv=none; b=Hhp3QCa6GcOOd8wKDcKo9rh2LAeuAF5c3zrkrkRHlHyAFpxh7jBYtLUJf3tCmzAZX8T2Sy9Lmdx7vCv54mTJK9wR44S8CMZ6S5Q9YilFAIF5EiUxQ9u4AIiMMiRl4qLQXLOy/6wCSn2dTbiNEoXmeCnTsTQINuEzrmHbVGJ4bFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734410; c=relaxed/simple;
	bh=Ca4htyzMV4BbSbS57tRGc2+Cc0LiM6cUtsp4GcmvYPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qZq7zkqGgWw97fDQqjVeC16VcZxxaYukEGa3SHIo+a+V87cvksu9VbF832NpMMDpIa1UuQ31tOR8ULlR+9BN4ATW9WK/KpjqAtYNM6Qd6mpWVHWBS0qJXt8FnwwQIc4j9ntKEABLfxXjDI01xL4sSdug8cNoQ3pA/2Ji1+G1BfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=toO+fCLo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734392; x=1740339192; i=w_armin@gmx.de;
	bh=486rwmOb89mmDx+Ffk5gLFZ3t0a1l6qw1EFvtUtqR4M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=toO+fCLoIP+SF3uiXqZTWkDYKgGcK6H3kNXovGDdi39bPNFea0CKHDk6bvjj4pk6
	 QZ1433SrcOlKU70dYTPcT8dzkBb0xWV0AuXlDCEOIxo2Mv17AGYkH4JIOBPPMoat4
	 CJDfLO7qPXa3nwYko1ArlCi4QPbOXv7WL/Ki51Pza4vb3h2NTqRJjQ37JGLvuS3Es
	 AvjEE3FrjKbL92020/p7NBTiSE+z7vGcae/l23kxd9BnMLeGKc+xMNmHuiNyg9plg
	 qYBNEMCg8IfTR8Hxnu9YaCHV8ZQrdbE0LVeFdt4KwZWCQ86WH80EsFTzSwRvLdiQv
	 cTf0CybquYGqHdGEpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mkpap-1t4rmq3onX-00hkfU; Sun, 16 Feb 2025 20:33:12 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	markpearson@lenovo.com,
	jorge.lopez2@hp.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 4/8] platform/x86: hp-bioscfg: Use wmi_instance_count()
Date: Sun, 16 Feb 2025 20:32:47 +0100
Message-Id: <20250216193251.866125-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216193251.866125-1-W_Armin@gmx.de>
References: <20250216193251.866125-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XkQe/A6H4OjVacgqzzAFK4m6QQUH+OhJO/tL5ttc+HP02Vb9vCV
 LxFJn0uFX1ZFQWtfCoMl80/2D5IUsCRk+7V+odJBqQWx6+JbIX+kVaBtIIkbUQl0Li0tCD5
 ml/ex6m16uLG3fMwbuKXAbPVTAM5hIyWTqdTVlT4LSk2/onjyc0RwYu+mGTmXa8KZA4xmE4
 v1huKG3PxqulVXw7XB2kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q5A0Wm4+rl4=;8oTH8q/LU6hRLiUVS6oJ0qWmPKg
 g1GkdyG9pQ4nvAuR6plRr2rNqY683xubIpfNFchy9fs3/bdwxe9O51jIOwZFUPNcYnzouwuuc
 0PRMy26Us8+p+0f7ge8ZCx+i01n8KH58QH2HBKutJrCzF13FUxtGMFt9hE0D2q+K1x9wODFi+
 rLq1RMcmxyd9A0LgXZN754l7UKNXp8bnoEUiOkr9q5VPu0E8VzIqWR/zGS5tAGOIC4n+x3Izp
 oWuhxl9WBJfk1zSaqozHgjBjxE+MN4xpBxQ2HRK+xI6pWSoTk87irbHfyOquw219Axs7xRjI8
 k3ttZZ85mP7o9K2TPc+8ocw1Z/iy16i1laghJ7CjRuYhyNeV2ei2jG/htNrulMVT6pQ/+PAzQ
 qe1YTDKRx/8igqTEYP1upJsFOOEwlZpCCBripaZGF2W63Z2frMbG54W8bSRfD+ZPXY726HTqk
 w+JHiRKhbLxRMlY/zkwBvv7DT0W6BINTEIqIg/+fYlN0rJtbKHTVSSjMkKuHlzObyzoL3RZyZ
 +mmpUUFcL0bQu7/IRLxq6oAx76CDGi7trHHsrRr7qvIX/Sa6mkqhd5T1hZJFWtOaPDUdf5cZr
 UAyAUWKjkVg9/uiqY1D/xdo9myZ6D0LEZVZ/deUDBVgMzdFFbR15LINb48srOadjhnVYxIbyP
 8TI0GXIG/eNetFJdcn3INZo09317MZaGfeu1yPYoUxMN61KekTru3ZtOx2lalyarRlEI2+Dcz
 oVgEJ2Eu1Hkb1TvsBesuoNKlX9yrn+eex/ilUQieqxL3jK1Mp2C9vxEe21Ohn0ns3wDHii91K
 CZh46Cx8slfiLc5J8pvJPimWmlrLjWYVVAw9MP5yZtx6uZm2RVJPWeiyWM1QI4wRUUXAHLsDi
 Jqm5Rhn+QEia6+rAzPxxUo5+uPk5wgnP5/G5MSoD/mrcz+21aLOADRA2twfy8xHG7+owY3zo/
 FiX/B2to54HWdsEX+7EUJPnoNQErLFZf1G7Jh903k8o7ynGXq682iTj7RwncQBK+tXAmOHksW
 YKUH0mYUh0MUV5iYYHil0RQOHDi6ngpcfQhJsyDpHi5ZcoLKqSuNfz4WmOHD9fSIFadSu/EcC
 R/7gzOkwcX937WfRqF6ACnb9fbBSY2PDYQ2lQElh5aSwlab+i/DZ/xY3mE4P+TktlFGTkYM74
 szWXEVnZ8zmR6FKCMdR4GZeyV55b1zDVmoDAGvmxSlwX5A5jfw6cBwu3b8FhYrKzhH/7R46Ai
 niJUfea8AXaXmDoGKdVcXU0VLyAF7085YYPlPUujdqqnfvzguRMOurhwWV8D56yc2U2bcppoV
 DbyWny+z2TJkZ++TwXoROXB0Mf4tjFaVZyNkpt+w8WSWtKmM6zyqSC99bLbe/SpBlXPwkJ+zQ
 DNMEP9udgNvDx/2pM2jVlTVdCaHss3Q2XbbWUicubgvgtLb9vtkbn9VBN3++gvVueELuIE+rR
 yctORLg==

The WMI core already knows the instance count of a WMI guid.
Use this information instead of querying all possible instances
which is slow and might be unreliable.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platfo=
rm/x86/hp/hp-bioscfg/bioscfg.c
index 0b277b7e37dd..63c78b4d8258 100644
=2D-- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -388,16 +388,13 @@ union acpi_object *hp_get_wmiobj_pointer(int instanc=
e_id, const char *guid_strin
  */
 int hp_get_instance_count(const char *guid_string)
 {
-	union acpi_object *wmi_obj =3D NULL;
-	int i =3D 0;
+	int ret;

-	do {
-		kfree(wmi_obj);
-		wmi_obj =3D hp_get_wmiobj_pointer(i, guid_string);
-		i++;
-	} while (wmi_obj);
+	ret =3D wmi_instance_count(guid_string);
+	if (ret < 0)
+		return 0;

-	return i - 1;
+	return ret;
 }

 /**
=2D-
2.39.5


