Return-Path: <linux-kernel+bounces-193069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1648D267B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3780B1C262DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402013C67E;
	Tue, 28 May 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qU9LfOXH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130D45024;
	Tue, 28 May 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929358; cv=none; b=VjFHb3RwjXK7CfdlYaeg8oFiYsn86pN6jwggVcsdmIFSs7ygMcpNUEBmdPzNFx38TdzSnSpoH300yn8H18/ziHKg5xvD8PpWbCIUYxYVeuoS2l577UvfbSWBoasitYpBWyAxDtU3z7LPbkOa/7jscKWNIdpb3Vw8NFmTl0R8eBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929358; c=relaxed/simple;
	bh=lgj/spm7RG5xxoefr3gCdjm12/1dHbjezBtdM193Rgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFSsI6XzPZE7pwE32u2uab84mvuaBD49wjoLNbiUFKutAyZNuHnrH/5CzS8IGaWMHQFRjG8YLKCdBX2sw+1qC1QjmwtQmww3Yfdb46AkZeOv96Oc+KPf2SBOROq4wbFxJ8Z8yEmICo1XYQp5w6yjVH2NMa16rxa7A0Jcu4aGBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qU9LfOXH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716929348; x=1717534148; i=w_armin@gmx.de;
	bh=/MoR4zs991DYMvTz8rBH16o4vXvcYUjLg0tOjYGFX7U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qU9LfOXH3kttrp82hwxTW+Wjqfa5WMs9IHG7lL0VH30GV+yssiXnajDr8/nhQToN
	 bNqtLUPwrMMuqX3rfgkGV3n7ZkAFvVKwRQgHiPTl8NODO8DMLtBRhYmyZpAkfbbtd
	 +GRr8rOLXusBSuPc1GGXXZkK5kJ8rrN13MpkufIoVvISq2ZHZTKHl7J+aq44FclTe
	 qo69FAP0DAmgK5gSIvgbvgGJh1gM8uLRbSsKG+I3/0KKTejOk1kpncvw/Q3RENmzB
	 w+pRowDc6hotPixXgDQvVrEil0WpQZvldqknR/jOjHoYDoQv/Tl5EWTdomvs0WQAg
	 T1JIgpQbM7MEi6Vj4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M8QWA-1s7g2d3lQW-004PmO; Tue, 28 May 2024 22:49:07 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: dell-smbios: Fix wrong token data in sysfs
Date: Tue, 28 May 2024 22:49:02 +0200
Message-Id: <20240528204903.445546-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RIu+x3Tr2dOcYnpYqC2S6AQeTLiKMoAzO3Re2OU/aMuaaANNRnp
 a28RwAPVpGcRM8NFyCMXvXWvPOCWv9ZtPd5XijjsMWPsDv+/N2J4oAjIgNt9zzLlcaKAItr
 z2bP2tfznnWEY41scMfyRzKVf5gpcOsJBuNyE5I3QnVlaVhwTaq3lUQqDEHehuhakSzqERk
 NkdmKX7sWX9fFGmeBZHMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yRxcls1m9yE=;fk5kj66kEpRoN/4AgoTh6KnkR55
 0mdzv/TRnjOr3uAoJS3y1CRg4+/mUxUxh53Mw6Nrpml3lCLVKKJRB6Me/xFPmpw9xehW9sALX
 1+RKkyoqJiCC2joVmgBUfKQBBH71keIfXFeDlVG2dhdgB8DhbCmXb2N3Byz3Dm0HiRQ+lDXs3
 uhCqGnY7xkfFHlaJskq6jXlNi1gYUVxmFICJ7MNGfjVF2iagpsrxF+mro8UbgWnrgt7x8NVfB
 JHyuVAn3BrmglhC0bUMxe3uih8w2KqH+myK6t6ucLfaAGfc068YtVn+cQ8orK2Yao3XrZYzq7
 YdD+bu9HDNPS8/uDaSqV4ou7kKXbBnGz7xdELDJy3Dd/O4T9V7d3vbot2Vyj86ceaCn4SWp9E
 DcozyhRNevWQ/Z/aouXRIOqlLmdTZUZp1UiUMLMZ8IV4S2k6OBUbyhjwvNMfImVIKIsaQeQW1
 PxRog3HOaQoZ0mkxhu3LAZmQjWy7OIVhjcz6Ch4SHFwjUa/KWYOGHCnYegN+DTa07La2ZUiCA
 8eo0i9ZwRQFp1uS/J+xr8uQb5sL9E+D0yTaTsW8w5TNKrSPw41Cfw+jPKgdD7A1WuScyvlPeI
 U057XNz/e7G0TYIGC69xN8N9+FDp3QeI4xPPiJOrrHnmKfWGyqa+ARcUfMuAuZNVCL60Pd2tZ
 d2QW+H/Hr/If8miZaV56ijXs3fvGfQAZ0Yb0SNjJrfpQBz334xMauIxBIBb98aUVw3SxX7gmT
 9tJxD5XmxMiAcw0ZsiaUR1iYGAVrTxuqCRtdeM/80qcBCGjuPlm4FY0dvCBCo72LZn6cjvAKa
 alW5y+APj2bodhsMbBiYvpNF/AdHXn0cC+hqdOxU8ryoQ=

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
Changes since v1:
- remove style changes
- improve sizeof() usage with pointer targets
=2D--
 drivers/platform/x86/dell/dell-smbios-base.c | 92 ++++++++------------
 1 file changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platfo=
rm/x86/dell/dell-smbios-base.c
index e61bfaf8b5c4..86b95206cb1b 100644
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
@@ -416,47 +422,26 @@ static void __init find_tokens(const struct dmi_head=
er *dm, void *dummy)
 	}
 }

-static int match_attribute(struct device *dev,
-			   struct device_attribute *attr)
-{
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
 static ssize_t location_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
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

 static ssize_t value_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
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
@@ -473,22 +458,15 @@ static int build_tokens_sysfs(struct platform_device=
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
+	token_entries =3D kcalloc(da_num_tokens, sizeof(*token_entries), GFP_KER=
NEL);
+	if (!token_entries)
 		return -ENOMEM;
-	token_value_attrs =3D kzalloc(size, GFP_KERNEL);
-	if (!token_value_attrs)
-		goto out_allocate_value;

 	/* need to store both location and value + terminator*/
-	size =3D sizeof(struct attribute *) * ((2 * da_num_tokens) + 1);
-	token_attrs =3D kzalloc(size, GFP_KERNEL);
+	token_attrs =3D kcalloc((2 * da_num_tokens) + 1, sizeof(*token_attrs), G=
FP_KERNEL);
 	if (!token_attrs)
 		goto out_allocate_attrs;

@@ -496,27 +474,32 @@ static int build_tokens_sysfs(struct platform_device=
 *dev)
 		/* skip empty */
 		if (da_tokens[i].tokenID =3D=3D 0)
 			continue;
+
+		token_entries[i].token =3D &da_tokens[i];
+
 		/* add location */
 		location_name =3D kasprintf(GFP_KERNEL, "%04x_location",
 					  da_tokens[i].tokenID);
 		if (location_name =3D=3D NULL)
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
 		value_name =3D kasprintf(GFP_KERNEL, "%04x_value",
 				       da_tokens[i].tokenID);
 		if (value_name =3D=3D NULL)
 			goto loop_fail_create_value;
-		sysfs_attr_init(&token_value_attrs[i].attr);
-		token_value_attrs[i].attr.name =3D value_name;
-		token_value_attrs[i].attr.mode =3D 0444;
-		token_value_attrs[i].show =3D value_show;
-		token_attrs[j++] =3D &token_value_attrs[i].attr;
+
+		sysfs_attr_init(&token_entries[i].value_attr.attr);
+		token_entries[i].value_attr.attr.name =3D value_name;
+		token_entries[i].value_attr.attr.mode =3D 0444;
+		token_entries[i].value_attr.show =3D value_show;
+		token_attrs[j++] =3D &token_entries[i].value_attr.attr;
 		continue;

 loop_fail_create_value:
@@ -532,14 +515,12 @@ static int build_tokens_sysfs(struct platform_device=
 *dev)

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
@@ -551,12 +532,11 @@ static void free_group(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj,
 				&smbios_attribute_group);
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


