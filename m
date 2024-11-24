Return-Path: <linux-kernel+bounces-420178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D197D9D7676
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970FB283C25
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490EA762EB;
	Sun, 24 Nov 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YcoqaQaY"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32203433AB;
	Sun, 24 Nov 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468486; cv=none; b=cXz2+K2AvLPrF9O1vh/CBqXilxZrhgTVG5EEeubKMaCG3ImRfaPWrzaCl2Lo564V+Xom3C1AcS300vwNuWM7jkdSWJ70bV4PCZlHeR87Usg1Ncqk0V1+1FbGO/hKDoZHhkblgm9YrM4efEIdcOvG6fK+2TxgsZaeAw40iXtppWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468486; c=relaxed/simple;
	bh=bvFbxc5P++9Gag+zgAYbv6WxVb4HNe8omEWI00cWw4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4RGydWVtSsnnGDR4Zua5ctW0fOtvE0Xye5VH8pnkK8AWTsayZXg2Qf14Ovnx/8RjMzjOudfcfFfbmDMiOdxbG3pXiNhk1TsX2dD4XK/dlalm6CKi147P5FaFRbgyJJBtYAkWdQ/giTbQnnDX1xkfzGXXk978Lq/yp4jPNhN6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YcoqaQaY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468476; x=1733073276; i=w_armin@gmx.de;
	bh=LDc/EFycTFB282lPDii06kaNXf50E69nOVsxqUvjg/Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YcoqaQaYjYJH2vVFFHV2/YSPItT1Sdji+CGumitPuTRrrmekDRyhLTrI5AfII8KD
	 RvjJw90nl3+d0R50nEpVNR1V1o+VtOv67h0QztmCvIBFZjz1EwpZ2ygdVbnU3uxkI
	 UCnKCEF+TKk11F1JZ0IGQFAsViqUGLTSky9hKnAZz2H/RB0Q5vc5tgpUDCZhrU2FR
	 yErq15IP0WxcHLtOWmNZPDg0XyTKCngPTdO+jAaCbNtho8NOK9PxxZX8t9ySoAJ+C
	 M+WzauaNeCX6DABd3yX+XWK0zlBOQ4pwo2L4emMqmZH21V+M6WEW0dHsMfFDVyTRj
	 GiOZEyeipov4jKRmvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MnJhO-1tyWYi0sNw-00ZNgg; Sun, 24 Nov 2024 18:14:36 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] platform/x86: acer-wmi: Add support for Acer PH14-51
Date: Sun, 24 Nov 2024 18:14:22 +0100
Message-Id: <20241124171426.29203-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:CBcrTuApz/JANqavvS4F0vLgZMUsKTlWwPe68Z0SpBAXF2esHL9
 weVlgbO4z6raUom/2AgHsSv9pyGtPJMYIOTr0kg+02PY7q9PMneY18w2ndBQDl2gu3v+/A/
 d/LoM3MYBcpnRaVuxzwKgLkp9Zs1GBdL5QBE7C5PcFExRdtFgdbdf7STGEK9NK7Z8x5draM
 d+lV+EzHGOzQ9rVtxwAbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pr5Di7ziNNs=;4hmEoIP3jVLVINGfEFgPtWvNkUS
 fP1hGV9SRpJHzPt1BIY8SMcnt2wo/cYS63daEZZe4Z29c3Txh3rfYjz2MiD7rqIan/cPilUF9
 83jMoK82wrum22NQ/0ouhNbkO5EBJjsNwKz8UQYc5XaWgG1v+T9IWL8eRzlWLlSfhSL24cT2q
 Aw2KYKjLcICNhwOrSm1jvaRZw8FwhRc8Sa4dWIUogpYEWrovkWmzOzS3rTzDWWB6Zx4rW5037
 nJL9hQK5pp+/FD+3Oehw4YzPXXNCRPWZFgLPSQx9v48TP8l8GSvePs/xZRf9n3be1OJBy7rPr
 w+Idb7iCNv5VjaQuUQZPy4GkzCMe6N2bfn76rfIqUwJKUklQBFL2cGuW1olrdORAjcharb/yn
 Q34ClxfMmMtHs6CLSNJopaq2UmlCcXI4PaLililwAMeJJc6S4I//3y4XIrSdt9OeN8qZ5j7nH
 19lN/hOEva9YS1/HLtlWvEEp6+iyKfQSQcC8INus9KBUbdJ20dQ3xDW3Db+ZH6517xwlT5YnV
 gh0zMldW1dDdjZL0Uk/i3X6g42TkpvBleNa99FSjWN5MXkx1JW7RX6USDsZW6ocs8uWBpmOoj
 BXc7AXCUsoElyrYRdIRLUoR2uqdgB/u/gb4udWaw0zzoJvOF1GxOqFg2AGZttZlFmfG8eocO2
 pBPi/AfgymIO68ch441ZNhvzpbuGGvpXvDLpE9TJGmSlxPPHInCsChqZ/+Y/ovaOJw1wi4jq0
 4vCyp+BKf45AHSnoLbx12uupXKF/D3hT2DVD8Pryf2PYtYCCH31Z7JmKUqaSWrfC8F5U6/WCc
 NMoWaUs+WGC3pRK7DBukyfS/zF/AlmaNTCXQNq7iTwcgCdwyfOwU2ceQGX1IbU1UFkp2GskTp
 3ye7pm5kZDhHVlYxsZMX4G1ZyTuwLCneZvVSOSeJQMLCdQsTe9+wAttBgmmiXZ4T9Y806ynr7
 VtEMW2aSiDefOnLkO43iSkeYC6OiVN90FK0DNIzNZDS9IOASCELLoutFpdVppD03Ih0nWUGPs
 m/l98Uo9Y5KAVr/Q23TnU/C6qtZaGm0+YiiKctxwlH1beCDBnKo10og2eyILfz3I1EL2jQU8K
 wTJHNc+KyYa43Uw1SUSIEMR0NyjeRH

Add the Acer Predator PT14-51 to acer_quirks to provide support
for the turbo button and predator_v4 hwmon interface.

Reported-by: Rayan Margham <rayanmargham4@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/CACzB=3D=3D6tUsCnr5mus=
VMz-EymjTUCJfNtKzhMFYqMRU_h=3DkydXA@mail.gmail.com
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index d09baa3d3d90..5cff538ee67f 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -393,6 +393,13 @@ static struct quirk_entry quirk_acer_predator_ph315_5=
3 =3D {
 	.gpu_fans =3D 1,
 };

+static struct quirk_entry quirk_acer_predator_pt14_51 =3D {
+	.turbo =3D 1,
+	.cpu_fans =3D 1,
+	.gpu_fans =3D 1,
+	.predator_v4 =3D 1,
+};
+
 static struct quirk_entry quirk_acer_predator_v4 =3D {
 	.predator_v4 =3D 1,
 };
@@ -600,6 +607,15 @@ static const struct dmi_system_id acer_quirks[] __ini=
tconst =3D {
 		},
 		.driver_data =3D &quirk_acer_predator_v4,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "Acer Predator PT14-51",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PT14-51"),
+		},
+		.driver_data =3D &quirk_acer_predator_pt14_51,
+	},
 	{
 		.callback =3D set_force_caps,
 		.ident =3D "Acer Aspire Switch 10E SW3-016",
=2D-
2.39.5


