Return-Path: <linux-kernel+bounces-516771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A31A3772F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281E218845F1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBA1A8402;
	Sun, 16 Feb 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="nBiTgIaP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FE1442F4;
	Sun, 16 Feb 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734410; cv=none; b=GH6+ueoVtr9p+MWx77ra+rzR+EFlknY97YUhaiPeZgS5pDfCZs6kwkrhuxaxGzLXcJo60Upm7a85rKj2bVrqy7apgdwMrl+w5P9mndbotmXchpwQJjwO3u6QBRE8Nsv+2PejGUuOONFAmSLCLjySFAWrH9Wt3VNNjpw9hP73jOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734410; c=relaxed/simple;
	bh=yMjiz646ZJvCb1m2zwAwWL8ybidlrk4U2RBujeYWMdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNcl8sz0R8kkNWl9sTe8qYOP8cAVzfFVs19DFkqvLnBBpDx1ZkUJ+RENjlTFYsZlX2JG5RB0rLvmhWUnMeb1qUvRpAmOGxQUVIEQ10VZ2ZbFvN7JcOZC0u+d/fvQ3icqleAcvEcVvRuNeXZbOI97EZzDSf9Y2shBFfyg+ZVQdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=nBiTgIaP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734385; x=1740339185; i=w_armin@gmx.de;
	bh=7jyOAlVRB2LWS/oqgP3F/K1neWhMeaYSgJQHNRFX1fE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nBiTgIaPEYqBE2U9Su9v+czEg1rVh/YlZ7uhRkpaSKZxynoiXU4Zs9xO5COBva0T
	 Ubunb4qs40HKZIZvue4Q7Zd7uvDZnn88MIAho8ZHBj4YgU+LcmCh53rQGcay2uTPa
	 t6OvMbf3BD84lSNDmwpkY1ellj3sNVhkKELXYsPPInnBdE/OJUSCwgL316vfT7kzG
	 aaIf8xRzdliQ8/iMRz9Z5xfuEyb9eaNxWtiloDnHXk63LDqSeHkdTkgRTgXSxGj3Q
	 WZ9NDoDrzLzNzlxka0MipaDK61l4WKWHL19RLSUmIT540sX3eykJ7pRRb6btx7ZFN
	 IW4Ew5EDnKjTGDs9+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MiJVG-1t6onX1vNe-00mXWL; Sun, 16 Feb 2025 20:33:05 +0100
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
Subject: [PATCH v2 2/8] platform/x86: think-lmi: Use ACPI object when extracting strings
Date: Sun, 16 Feb 2025 20:32:45 +0100
Message-Id: <20250216193251.866125-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:kvuCTzUm6FD2pC4C6wZx2zJIpdrQjAHy2hoZAk8DFKAj/ITrjMy
 JiRYDocLgpFjwvsMCMlitMFQi2B2AwkePI1BPTclVJeyOEG+XQ5Omf7SfBiVPX1rRIz5jU7
 cLHnlZVJDk7uohwI+5AZrEu+f7428shoHv6SqXNxisWC0u25oPSYcwpKHFwF5oZf/8yyh+L
 LwOlkzwfE7uwefR/iTTKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2V3eQl82Db0=;BTYUK2JOTIeDEW2PmW+NjizJYyL
 SnhPwCz+cWrlXPpzA9vDNV/RlrOyXa+SkktJMhRlT8dX6u93+yiaT6SJH0lvyFANHCWj+sNqS
 pcC9bk3jmxVfVCbdFFd+8pYMOVKayTEC1O391eTRENGu/4wUQ6YxNGxN3u+mij4eLK3+j3AdO
 3lBcSeAh+9WLUsBQxDmwAzhQQxVinD7utduXSmoYhxp9pt2gx3HzeihJK+ysSl0j7ZLu28wkB
 ObnQnxCfLX4Bgxr9W35EIKnjFlnf3kJhy1JT6U4OaA2tllN/F2XwpFSATvN2jBkTz17Aefv9J
 wqvNx2VQ//IxE4lptkl1xralDU4IyHPuTzioxUF8/Q7RPmx/YsXEzpG4Fm0BRFlZRPO/YcQ35
 F5jS7qtBNlWqn7BL9UoOvV4H0LK4slS8BQ0ZhyaXEXDMdNuiETMaVic1wOWMf4hjA95Lrt1aM
 B1nyb16A0BWtIbBL4GXhPzEOZUjC391T8wZI5618uU4Zquq5CxerToGeArpz+hBfbBc9IQsYX
 wzBSMi6dbxkXosIanzB5KywU3oWErAWHd3PFg917DxQ6GcLdlp2Yyh2yykSrrz2QIqukRZBoF
 OoOn/QkLm04oyJf3Zf6CEPJ78MfetpUtO7IqaU9SHOT2KtGf4nzXnzZnwYA823KbSiy6o26M0
 eTt0xYQOWEeu0A6QO0azSFG4rIB78LwQRTHdbgl64/dwZFKlKq5AILT7fJmI1DOUixVsJEIA7
 SmY4mnsJSilKdZTPbsKT8hplriXDcS38FHINBvEFYDST/xKxclDpfEKcWMlrEqcuwV1sI5/qu
 +yyZLNpMZFstS7ieRXCDjfVOdiBMy54VHSPrL4K9pNRwCxRZ/wKLsU0WmcPMaknHsTIzyfqP6
 KroT5NH4l+KzcSD2o4MA9iVzHkSP2p1FjnqmMdK6nozv/aLWv5Uc1zV2Q4npIrFJN68Iqwh43
 ffiVNerqGgRnZ/NcyWZQJUVeYRnqL6ioo/JMnk5JzNxvImCs8GIQETW7Ri0DN9hIX5CkE6+9T
 z2/cLT1vvEG+2g+Nvsh2KS5X0x9svC89X+8YD1qjQrTcwnitR845PUIsXvC+fyOBLmImIIpEj
 D3gVaz+hzifFWpkuGtfUVfJ0C46l3M6lPZ7xtYv+2t2TpEwktjpyZXQTh5wf/v0uBZpJO5aOc
 J0cVUYb4ZfH7peGta+N7W39fR0orWgEOvlV/epWgNkfzIm6epLYtoIJBKJIABpHSZ7MRdHkms
 obi8Ee8eVR3L0fiUzImttpY2+NvxAc8bUB57bqNnOeJgiVy/qdd2T22coNSZfTiity5Skv4s6
 BQxAg8TRMOfszc2vpdQ4ONgQy+p463E2bWbW1ek4pGjUEGmIjIBhd60/krXWm0RWtyDUNrjv8
 XkBOBAI49NyiR4d9P08MJrD4NlNk3YUE4BfwAoVOh+w74Jh5yAhBu7kLwI

Move the ACPI buffer handling out of tlmi_extract_output_string()
and instead pass the unpacked ACPI object to prepare for future
changes.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/think-lmi.c | 38 +++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think=
-lmi.c
index 323316ac6783..2c94a4af9a1d 100644
=2D-- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -262,16 +262,11 @@ static int tlmi_simple_call(const char *guid, const =
char *arg)
 	return 0;
 }

-/* Extract output string from WMI return buffer */
-static int tlmi_extract_output_string(const struct acpi_buffer *output,
-				      char **string)
+/* Extract output string from WMI return value */
+static int tlmi_extract_output_string(union acpi_object *obj, char **stri=
ng)
 {
-	const union acpi_object *obj;
 	char *s;

-	obj =3D output->pointer;
-	if (!obj)
-		return -ENOMEM;
 	if (obj->type !=3D ACPI_TYPE_STRING || !obj->string.pointer)
 		return -EIO;

@@ -352,17 +347,21 @@ static int tlmi_opcode_setting(char *setting, const =
char *value)
 static int tlmi_setting(int item, char **value, const char *guid_string)
 {
 	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
 	acpi_status status;
 	int ret;

 	status =3D wmi_query_block(guid_string, item, &output);
-	if (ACPI_FAILURE(status)) {
-		kfree(output.pointer);
+	if (ACPI_FAILURE(status))
 		return -EIO;
-	}

-	ret =3D tlmi_extract_output_string(&output, value);
-	kfree(output.pointer);
+	obj =3D output.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	ret =3D tlmi_extract_output_string(obj, value);
+	kfree(obj);
+
 	return ret;
 }

@@ -370,19 +369,22 @@ static int tlmi_get_bios_selections(const char *item=
, char **value)
 {
 	const struct acpi_buffer input =3D { strlen(item), (char *)item };
 	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
 	acpi_status status;
 	int ret;

 	status =3D wmi_evaluate_method(LENOVO_GET_BIOS_SELECTIONS_GUID,
 				     0, 0, &input, &output);
-
-	if (ACPI_FAILURE(status)) {
-		kfree(output.pointer);
+	if (ACPI_FAILURE(status))
 		return -EIO;
-	}

-	ret =3D tlmi_extract_output_string(&output, value);
-	kfree(output.pointer);
+	obj =3D output.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	ret =3D tlmi_extract_output_string(obj, value);
+	kfree(obj);
+
 	return ret;
 }

=2D-
2.39.5


