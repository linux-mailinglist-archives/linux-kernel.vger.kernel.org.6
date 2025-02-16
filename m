Return-Path: <linux-kernel+bounces-516767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 982BBA37721
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9C189001A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2171A2564;
	Sun, 16 Feb 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FukaASuM"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AC42AB4;
	Sun, 16 Feb 2025 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734399; cv=none; b=L7sszvmBCAsB/+7g5F/vNSQ2IvOc+CFmD//YVqJ23cRMYuwVjJ/DvD7kZdTqhF+ygaFGG47IscDrX9OQAVLzk+C8WsWlxMYwT7NK5cx5lzvMhL612a3K5DbGGPs13W4yVQbkeNBfaQrDnFfbyHvQSD3oGZ24jFc8v6sR0qlp1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734399; c=relaxed/simple;
	bh=4zFvPourB8H8dcn2mIjlbEat5V6fdoA0xfssgADHt8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf0gBCTTkegWXlqSZCGi3rQr0r9oO576R4YnHdbz0aBsaMLv310UEp20iwzgVQCVRSqGvaDC4pYKEZl9Vi01DmF7h1SQjMw+f+djL1IkZcRPXMRail2ujoMtuSjS2cgBwFLSOI6ZVEQsvS5syCprTPgfAFtAjeJf6ZpLLhuAxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FukaASuM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734388; x=1740339188; i=w_armin@gmx.de;
	bh=LGy+YSCR5EXvi4r55nuFgMVSm/uxFYtiz967rCHqBWY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FukaASuMPulkd5/llRPinx6CGBQrHgDRlh5W25yb4FXINVbp9un9GXNwQzFWNPBe
	 J8UQcXzzyrVdGPyyk6aQaAeWlzcFDgJAv4evIvqN5iky4sC99lbFRuTgtbUWNMknt
	 UCVBouGBUaaCvZn6yCv31Bj1VIPqFrznGlNxgkr6HKrp6paQU65B7CedS23CyQUmo
	 imwkxnDV0m2hiaSKp/Knt7XjiWxyWZXOiiR4TICF9EDO8c4ngkixshLJEYQnba6Ww
	 7214awmFX561Z4gbuPqjW4d4blrKXLykqJ/UTZFv79/1fqBkl4/TbspMHNKQ4lx6q
	 cSt6DZc7R+3vFBNpIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBDj4-1tdeVZ3Pag-002GLc; Sun, 16 Feb 2025 20:33:07 +0100
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
Subject: [PATCH v2 3/8] platform/x86: think-lmi: Use WMI bus API when accessing BIOS settings
Date: Sun, 16 Feb 2025 20:32:46 +0100
Message-Id: <20250216193251.866125-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:OYDecztJG0YqpsI7jHjqnFqVJkOdsPHa+jTcw42NzfmhRMiw+ZL
 y6++CTXgYmhvIW8xZiKhzHc1zCpR8SeCd3k1pa7mTrQCbaCe4iK58o6ZpJ1jM+aRMv/V2Jt
 RTKeNU2KMH9uB84Di2cld9FLOze3MGjdIzpQN9huKh4hu1I4ucvUT9JfdxkJNh6FWDoQMrD
 ZXIRbmot3VtUKxDnP7/iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eQY/Orl/C+k=;KyES0va4qGRw69QoCFrMtPlrTkf
 w1MKr0w0CGfv41ognV7ap8aiQCxIUMuwMUtPW6c8kEDHuy11GXvAOKmmz6lO45HUG4S5JLdAU
 KhFAB349yycK2mV31QUmJ6H4P5bAS4LRSoHBcLqOybHl+iFTD+92wRMvjZOwelaXEHcxtWgO7
 TsCAL0ZAmSnTWcXIEEXdeYYiso4ML4I+xAdM19QqSvIZ8h3T8W8KL3Dh07uktA9PJ+PS20uu/
 XvL3YGzBKlF/Add5rx2ozy+9OU1kxuGfnj6WcVbAEVAB8cqLP3MhZrERfkr2P62tqOmdFi4vw
 FKYrjiD1RryYBmqid9cez0w7uHaV92Z5znAKhHRRzEQJMOYq9wnf1cwMr/sPN+KFbtBeRkQfb
 p2VG0HJ1JoNphY5ue6kZQegZmjiwUF0xrgymySAjflfEMtHFRzvP66dfujBTe8uY+QLKbpfa6
 GgGIRt27SvsQFdVxVBFor7CHaOy+qpeizry6tbBktTs40OiEaBXG7hcFs5yKUNPEntjJYaToJ
 r0E2P2gd00cOY6+YqW4pr1txbUfc8GoA0Lrz89iaLEQPqDioe/yv61YsxczGTKyzMl+SwbW2q
 zFIlzQ/YrscinaRfvHkAkWB+jYGYMQa6tnoxD5wc9EPxOndpTcyNDBw7656qz29nuhNiyHIOQ
 r5uYhX4+LME1UdMkB8hTd57/+7JC8QzKZ4VdpDHfYbjC/bu28TZOiuhAO161+K9j89BFmpbim
 qJ11A36WQxqVdwZgeOXRh8QT1fJmRnkQ/4KyjIswlbFciC0Uy3wOyjmgkniY09q1tPgTa+TM6
 UDFzzpQuPqhHSrNJtZ9I8etfWKGKU0RNEj/vMcWfEPSOowpGw8gFL/u+4R65ynUNUjqhV8br4
 rrMb3tLa2gNfmMQlGli1PrA/Ywzii7SiZwSyBGbScLg7/xc4OjhHJVyhkeEE5oHTteGg5D/lA
 1pL5s6jJaZFAwLUPww3rZNR/Nu/us2a5XTLTCJDfl6wA4X7/KePbNPPida9T+dcCf2Q1X8fUB
 Yg/X12gwB9UsLGdByDR0grfRGNWHxT4hKOLvT3T/cPde+hggi45X17srpaw1sYtWjQ92I3JM1
 2it48hmaS7PexKRuHTG3rmZrgW306Jhmz8XbF1Ug4ZoTtbafoZr6lgSFKH09D78mPEe/aQ4e+
 ElSQf18IRzDZibSH7ldxGpwTTO7Tzsb+e2BHpKhsgiGFEm7ePezh6wrXJabNGWkYztUi8O2IY
 cQJUhoHgqPmYOUAVGVIjSKAxgWuxNUUx03PYidhEMT7J6NAkDsfw/SZZW5iE6D4V9Q3W6+KdY
 hpnk9ah7B2iV3yIPxp5GdelYh3ZMUIGp/AbVXh9HEIs0YiQMn5XDFRT3vx5sB5/fgoKm46pKN
 g5E5HGQeB1qs5BZ8Q+MZT0yo2X3lN0aLIkchx66AXZtoC9zleky3P2WfBT

Since the driver already binds to LENOVO_BIOS_SETTING_GUID, using
wmidev_block_query() inside tlmi_setting() allows for faster
access to BIOS settings.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/think-lmi.c | 23 +++++++++--------------
 drivers/platform/x86/think-lmi.h |  2 ++
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think=
-lmi.c
index 2c94a4af9a1d..0fc275e461be 100644
=2D-- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -344,20 +344,14 @@ static int tlmi_opcode_setting(char *setting, const =
char *value)
 	return ret;
 }

-static int tlmi_setting(int item, char **value, const char *guid_string)
+static int tlmi_setting(struct wmi_device *wdev, int item, char **value)
 {
-	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
-	acpi_status status;
 	int ret;

-	status =3D wmi_query_block(guid_string, item, &output);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	obj =3D output.pointer;
+	obj =3D wmidev_block_query(wdev, item);
 	if (!obj)
-		return -ENODATA;
+		return -EIO;

 	ret =3D tlmi_extract_output_string(obj, value);
 	kfree(obj);
@@ -995,7 +989,7 @@ static ssize_t current_value_show(struct kobject *kobj=
, struct kobj_attribute *a
 	char *item, *value;
 	int ret;

-	ret =3D tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
+	ret =3D tlmi_setting(setting->wdev, setting->index, &item);
 	if (ret)
 		return ret;

@@ -1588,7 +1582,7 @@ static struct tlmi_pwd_setting *tlmi_create_auth(con=
st char *pwd_type,
 	return new_pwd;
 }

-static int tlmi_analyze(void)
+static int tlmi_analyze(struct wmi_device *wdev)
 {
 	int i, ret;

@@ -1625,7 +1619,7 @@ static int tlmi_analyze(void)
 		char *item =3D NULL;

 		tlmi_priv.setting[i] =3D NULL;
-		ret =3D tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
+		ret =3D tlmi_setting(wdev, i, &item);
 		if (ret)
 			break;
 		if (!item)
@@ -1648,6 +1642,7 @@ static int tlmi_analyze(void)
 			kfree(item);
 			goto fail_clear_attr;
 		}
+		setting->wdev =3D wdev;
 		setting->index =3D i;
 		strscpy(setting->display_name, item);
 		/* If BIOS selections supported, load those */
@@ -1666,7 +1661,7 @@ static int tlmi_analyze(void)
 			 */
 			char *optitem, *optstart, *optend;

-			if (!tlmi_setting(setting->index, &optitem, LENOVO_BIOS_SETTING_GUID))=
 {
+			if (!tlmi_setting(setting->wdev, setting->index, &optitem)) {
 				optstart =3D strstr(optitem, "[Optional:");
 				if (optstart) {
 					optstart +=3D strlen("[Optional:");
@@ -1791,7 +1786,7 @@ static int tlmi_probe(struct wmi_device *wdev, const=
 void *context)
 {
 	int ret;

-	ret =3D tlmi_analyze();
+	ret =3D tlmi_analyze(wdev);
 	if (ret)
 		return ret;

diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think=
-lmi.h
index f267d8b46957..a80452482227 100644
=2D-- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -4,6 +4,7 @@
 #define _THINK_LMI_H_

 #include <linux/types.h>
+#include <linux/wmi.h>

 #define TLMI_SETTINGS_COUNT  256
 #define TLMI_SETTINGS_MAXLEN 512
@@ -87,6 +88,7 @@ struct tlmi_pwd_setting {
 /* Attribute setting details */
 struct tlmi_attr_setting {
 	struct kobject kobj;
+	struct wmi_device *wdev;
 	int index;
 	char display_name[TLMI_SETTINGS_MAXLEN];
 	char *possible_values;
=2D-
2.39.5


