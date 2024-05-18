Return-Path: <linux-kernel+bounces-183003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01C8C9315
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4D91F21897
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8E6D1AF;
	Sat, 18 May 2024 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fW9ApgAZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B56CDB1;
	Sat, 18 May 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716076087; cv=none; b=BcqCv9oOZRzdG83iBeI9cQ3Y8Z1QVgX5QAE+wjKA8oPsxYkcrWZae2iZMP0rxWZmyFz9rCeWuHMVMAYNBBX2oNhTl4vTchnY2vbbajl9YLQ+X6Tij1bvAfYbLx2bHFOpWzf2KgAh6mpwDb+g9CK+3ThRlLwyWVVxDz6fD4fFDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716076087; c=relaxed/simple;
	bh=MboDjw7UodqbAylwm4J5pmI9L6t7ARRFMG9POtsbLWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jjl3D38v3lIjA3KzC6zHjNtdVHY6fH9y2wRb4G1oxBpnNqh0LwEax+/0S2fFVYIhn768Xa1iW6zTGMzd4J/FCFR34Is6ERtEod8h/d0BdbfHPX4GW3Su65XXHHB4ynHiS1tpbWdnmYjCPeeHcvhj7yCmUCRl0rM+KrX92f5GqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fW9ApgAZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716076076; x=1716680876; i=w_armin@gmx.de;
	bh=wni0JTtAGzbpevJrnHxZaYfrMTJPKDklUirDndb/WG4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fW9ApgAZ/8Y+40fHQkKkw/2xQUx6cNeVtgtuV7HlwSc+l/eJlnEvCPzpU7iqHXtv
	 FQmKAIcsrk8V/+YoQj+A0MQ+HFtCEi98XhIa+w9nS0ZQhYCTxAEGFjB2BAH46h65G
	 znxmsfsLUdlVbxbKeSQor9YonJodHxb+D8kwI20AHc1B+R/adD9Y61y3otOIxKv+F
	 JlX1nB7GF02lw7aZ8UNYavC1HTeqCdEYa8T0ZvzRdi32dHeTp3M+oNuf741L9EQZW
	 MXdtlFYOf5DpnASNpuerCcGi9DXKk2ZdDL8rFiHEIQNk675GqIHNR5RHAGJiVuKIq
	 43hJ7oAwthchzoXcvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MuUnA-1sQpiA21v0-00raOF; Sun, 19 May 2024 01:47:56 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-smbios: Fix wrong token data in sysfs
Date: Sun, 19 May 2024 01:47:44 +0200
Message-Id: <20240518234744.144484-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gj4cCbVbURyvuM4xSXOw50+gF+QIt6N5DqFUTE17NXRqScg0AzK
 ktcfTOHbWWcQSe21Cn+VB1AtruTP1TZhPMgThLQvJudOWEt2PLttJ/w2OQ1mvh221VwYEU0
 RQF0YkGoWeNw+klb0jul3eHQjc1LpVOqLYXuEdSaRueTaYbmVGrar6NyHkl3tPlpMooN7tg
 WgIyC37UsD/kEtXYfWDhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rgWB0H3tTdk=;3K5QDzMvdwhmZtaI9m598AF9g8l
 1UawIRU6Oir2k7U96x8mfz97jc8Q+AntstzaTVzHmVc/vuuNrZmeI8Y5I1TByK5r5YbnL7/GL
 0WXtO0eN7nFky/ui6UCmdEzSP98t5Wdf09SDrLJvFyEnvzzBTBwXca2jDPGSWb5Ue9US1EIeA
 Khmiqsx3xkP+LPTfKqWfNtQW2ZjyKNv7fOfDE1GWdci7B5tNWtq5lo4cYmoHaDS9VhYt3QGwr
 +2CEMy7VZJxXhw8N3tbl0yOoDD1H/nCWhoXpfDCBJ8Tn/NWV/ejDtIg2g+0W5RkbSvIZ3Mcu8
 BHULN6zSNM8letctnSKKaF/oIEeXBjANRT2tFlsW1t7d3E6LiK7FrwurM8F01psnCDFQ+915e
 GaXw4YtI4zceitbse425YI+DTAUrjpjysiC1wzSu/zqy5xRpmB9p3Au6h8JIyJToWcgWnFIWF
 GwbcsIs93kVcIYxDEU+wFhw92Z1m3rn+p5k16a7DEYQy5p0rv+Jp8la6wR8PWmFha0EPAkGXv
 gbVEhYYsJdEL7W9sz8+mIjWppFspj8s1UI8IChgQQ6OUX2oFHpgu4e9m5RMJNRV6HRVDr87rS
 Q6CH4PfYD4u0skzDpXqBHMv0Jm3Y5TnZR9CbXPcgii5HeLYwPke4RkUKkykNCbpvSirGvvTWg
 IJTy0Oxr7BIdzCWh9kmXL4UqdWf0Y29rCAkzrFfvr5JbB08wSJFk7Oc+YC2uUuq/EBKoOm4Gl
 VCpmYZCGbeh+7Jlucr3EynSnESQ3t1DhxZ93szhfwjt0+R11esU8PaZUbUCYviXfSKk1T6D+v
 GzI6HPQ9At8KkNDF8VtXly/c4kBClXsVlUGFtU4F9Nrsw=

When reading token data from sysfs on my Inspiron 3505, the token
locations and values are wrong. This happens because match_attribute()
blindly assumes that all entries in da_tokens have an associated
entry in token_attrs.

This however is not true as soon as da_tokens[] contains zeroed
token entries. Those entries are being skipped when initialising
token_attrs, breaking the core assumption of match_attribute().

Fix this by defining an extra struct for each pair of token attributes
and use container_of() to retrieve token information.

Tested on a Dell Inspiron 3050.

Fixes: 33b9ca1e53b4 ("platform/x86: dell-smbios: Add a sysfs interface for=
 SMBIOS tokens")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-smbios-base.c | 127 ++++++++-----------
 1 file changed, 50 insertions(+), 77 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platfo=
rm/x86/dell/dell-smbios-base.c
index e61bfaf8b5c4..bc1bc02820d7 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -11,6 +11,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/container_of.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/capability.h>
@@ -25,11 +26,16 @@ static u32 da_supported_commands;
 static int da_num_tokens;
 static struct platform_device *platform_device;
 static struct calling_interface_token *da_tokens;
-static struct device_attribute *token_location_attrs;
-static struct device_attribute *token_value_attrs;
+static struct token_sysfs_data *token_entries;
 static struct attribute **token_attrs;
 static DEFINE_MUTEX(smbios_mutex);

+struct token_sysfs_data {
+	struct device_attribute location_attr;
+	struct device_attribute value_attr;
+	struct calling_interface_token *token;
+};
+
 struct smbios_device {
 	struct list_head list;
 	struct device *device;
@@ -416,47 +422,24 @@ static void __init find_tokens(const struct dmi_head=
er *dm, void *dummy)
 	}
 }

-static int match_attribute(struct device *dev,
-			   struct device_attribute *attr)
+static ssize_t location_show(struct device *dev, struct device_attribute =
*attr, char *buf)
 {
-	int i;
-
-	for (i =3D 0; i < da_num_tokens * 2; i++) {
-		if (!token_attrs[i])
-			continue;
-		if (strcmp(token_attrs[i]->name, attr->attr.name) =3D=3D 0)
-			return i/2;
-	}
-	dev_dbg(dev, "couldn't match: %s\n", attr->attr.name);
-	return -EINVAL;
-}
-
-static ssize_t location_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	int i;
+	struct token_sysfs_data *data =3D container_of(attr, struct token_sysfs_=
data, location_attr);

 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;

-	i =3D match_attribute(dev, attr);
-	if (i > 0)
-		return sysfs_emit(buf, "%08x", da_tokens[i].location);
-	return 0;
+	return sysfs_emit(buf, "%08x", data->token->location);
 }

-static ssize_t value_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t value_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
 {
-	int i;
+	struct token_sysfs_data *data =3D container_of(attr, struct token_sysfs_=
data, value_attr);

 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;

-	i =3D match_attribute(dev, attr);
-	if (i > 0)
-		return sysfs_emit(buf, "%08x", da_tokens[i].value);
-	return 0;
+	return sysfs_emit(buf, "%08x", data->token->value);
 }

 static struct attribute_group smbios_attribute_group =3D {
@@ -473,73 +456,65 @@ static int build_tokens_sysfs(struct platform_device=
 *dev)
 {
 	char *location_name;
 	char *value_name;
-	size_t size;
 	int ret;
 	int i, j;

-	/* (number of tokens  + 1 for null terminated */
-	size =3D sizeof(struct device_attribute) * (da_num_tokens + 1);
-	token_location_attrs =3D kzalloc(size, GFP_KERNEL);
-	if (!token_location_attrs)
+	token_entries =3D kcalloc(da_num_tokens, sizeof(struct token_sysfs_data)=
, GFP_KERNEL);
+	if (!token_entries)
 		return -ENOMEM;
-	token_value_attrs =3D kzalloc(size, GFP_KERNEL);
-	if (!token_value_attrs)
-		goto out_allocate_value;

-	/* need to store both location and value + terminator*/
-	size =3D sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
-	token_attrs =3D kzalloc(size, GFP_KERNEL);
+	/* We need to store both location and value + terminator */
+	token_attrs =3D kcalloc((2 * da_num_tokens) + 1, sizeof(struct attribute=
 *), GFP_KERNEL);
 	if (!token_attrs)
 		goto out_allocate_attrs;

 	for (i =3D 0, j =3D 0; i < da_num_tokens; i++) {
-		/* skip empty */
+		/* Skip empty */
 		if (da_tokens[i].tokenID =3D=3D 0)
 			continue;
-		/* add location */
-		location_name =3D kasprintf(GFP_KERNEL, "%04x_location",
-					  da_tokens[i].tokenID);
-		if (location_name =3D=3D NULL)
+
+		token_entries[i].token =3D &da_tokens[i];
+
+		/* Add location */
+		location_name =3D kasprintf(GFP_KERNEL, "%04x_location", da_tokens[i].t=
okenID);
+		if (!location_name)
 			goto out_unwind_strings;
-		sysfs_attr_init(&token_location_attrs[i].attr);
-		token_location_attrs[i].attr.name =3D location_name;
-		token_location_attrs[i].attr.mode =3D 0444;
-		token_location_attrs[i].show =3D location_show;
-		token_attrs[j++] =3D &token_location_attrs[i].attr;
+
+		sysfs_attr_init(&token_entries[i].location_attr.attr);
+		token_entries[i].location_attr.attr.name =3D location_name;
+		token_entries[i].location_attr.attr.mode =3D 0444;
+		token_entries[i].location_attr.show =3D location_show;
+		token_attrs[j++] =3D &token_entries[i].location_attr.attr;

 		/* add value */
-		value_name =3D kasprintf(GFP_KERNEL, "%04x_value",
-				       da_tokens[i].tokenID);
-		if (value_name =3D=3D NULL)
-			goto loop_fail_create_value;
-		sysfs_attr_init(&token_value_attrs[i].attr);
-		token_value_attrs[i].attr.name =3D value_name;
-		token_value_attrs[i].attr.mode =3D 0444;
-		token_value_attrs[i].show =3D value_show;
-		token_attrs[j++] =3D &token_value_attrs[i].attr;
-		continue;
-
-loop_fail_create_value:
-		kfree(location_name);
-		goto out_unwind_strings;
+		value_name =3D kasprintf(GFP_KERNEL, "%04x_value", da_tokens[i].tokenID=
);
+		if (!value_name) {
+			kfree(location_name);
+			goto out_unwind_strings;
+		}
+
+		sysfs_attr_init(&token_entries[i].value_attr.attr);
+		token_entries[i].value_attr.attr.name =3D value_name;
+		token_entries[i].value_attr.attr.mode =3D 0444;
+		token_entries[i].value_attr.show =3D value_show;
+		token_attrs[j++] =3D &token_entries[i].value_attr.attr;
 	}
 	smbios_attribute_group.attrs =3D token_attrs;

 	ret =3D sysfs_create_group(&dev->dev.kobj, &smbios_attribute_group);
 	if (ret)
 		goto out_unwind_strings;
+
 	return 0;

 out_unwind_strings:
 	while (i--) {
-		kfree(token_location_attrs[i].attr.name);
-		kfree(token_value_attrs[i].attr.name);
+		kfree(token_entries[i].location_attr.attr.name);
+		kfree(token_entries[i].value_attr.attr.name);
 	}
 	kfree(token_attrs);
 out_allocate_attrs:
-	kfree(token_value_attrs);
-out_allocate_value:
-	kfree(token_location_attrs);
+	kfree(token_entries);

 	return -ENOMEM;
 }
@@ -548,15 +523,13 @@ static void free_group(struct platform_device *pdev)
 {
 	int i;

-	sysfs_remove_group(&pdev->dev.kobj,
-				&smbios_attribute_group);
+	sysfs_remove_group(&pdev->dev.kobj, &smbios_attribute_group);
 	for (i =3D 0; i < da_num_tokens; i++) {
-		kfree(token_location_attrs[i].attr.name);
-		kfree(token_value_attrs[i].attr.name);
+		kfree(token_entries[i].location_attr.attr.name);
+		kfree(token_entries[i].value_attr.attr.name);
 	}
 	kfree(token_attrs);
-	kfree(token_value_attrs);
-	kfree(token_location_attrs);
+	kfree(token_entries);
 }

 static int __init dell_smbios_init(void)
=2D-
2.39.2












