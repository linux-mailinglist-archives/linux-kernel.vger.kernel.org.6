Return-Path: <linux-kernel+bounces-375033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279059A8FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DAB2844CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9A1FCC5D;
	Mon, 21 Oct 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="FLYzyAdV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eHr4eBTz"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613D1F8EFC;
	Mon, 21 Oct 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539530; cv=none; b=pL9P6+19uR3eDFlGLRkfUIMqzEEVlh/6sVRFEPaU7kcm/aEgwXpX+nTHUKBt7KS0EhPG7EVwIgcOUb8AfFpKD3qxtrGGy0wJz/19jP/5Db7rI/xIhH7U32CdjhuRhXx2a7Zj48WydSyJ0s9gGmdiAUhH0sH5WhoogdKdP5oKv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539530; c=relaxed/simple;
	bh=JPjj8vFXxj1rHxd5bQ9ucqiLJ/GIvhEwH5McHfGzYZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR2jVFrmSOR2Y+1dol1d5Z3XK9uojS8Ck5kKjqmlTxd4pgT/y/tFZQ9klV6mnIaMWtxIq7nyr53DnV1NQpYzV9SeFrIjtxYwvNLSGgntw4pkCGowWcd5/mrhemwheASbsPSMPJV9LXjbsIGrAcr8oPH8DCb+Kz7TOOJP4UK9jxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=FLYzyAdV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eHr4eBTz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CF0713805F2;
	Mon, 21 Oct 2024 15:38:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Oct 2024 15:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729539526; x=
	1729625926; bh=0GY4lqaCIiz/+86oKZcavgzRFRu4yb/WVgx5SRAPiSk=; b=F
	LYzyAdV2T3jpspcGeOdEc8MRXEHeVhNcea6fcH9CQe+z+pWbSgL8atEcE8iE0o82
	fEXWs2H3urjBGuhosNosBQbP5VvJMu+eMmKaMrNfSvCCjcOK14frjxvnCLzc5MZW
	kuQ4sUzhNIb5QHw4fwGDmDyK0pmeIGjUjAzYK4jaNcpg7LP5gUcz1PXKJW7K5G8Q
	G4E9bJzlBd65tzRo5xwoalMSj5TjwsFOYoI4Y8RoDos6U7ppSu1lgQtquTPDUw21
	VkLXUtjU14HNKI1pCNLb4lKWq7V5Hb5LOPHSQxLVW2MUDAYduJ4EG853hCAcw4hr
	fob46vCNU5lx1KBYGQwhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729539526; x=
	1729625926; bh=0GY4lqaCIiz/+86oKZcavgzRFRu4yb/WVgx5SRAPiSk=; b=e
	Hr4eBTzPRENopk3U07Uj/h/9PFzGZuP4NJ7PX6kzcNishqtHNjauJWtEYv2ZinNN
	pjp29KABsqFGwAFQLpb5ldtcGuROvzELpyUNG+vT5qX/aE6R/oA/PtDvrXqfzr+R
	JMpGr0fwWNLLCGab3LYwYblbV3oqqJr2RxtiwJOEXdTXwKqxKNwegoiBmB14UIJh
	7Rgg64IaNjtwh/KG/lw9IKoykeY5oh7NIo55m22ANBLkwv7aV1GzwYKIYWq/sMcN
	t9wR1Cx6On6SMzvu0w77XcVXOPVsCnC72q2a6G8GG5vcRXZajneNmjVQV0mmhAQ0
	FbJxHP1HlKT2w8YH5hK+w==
X-ME-Sender: <xms:xq0WZ8TANB975IopElyh6mJ4Cr3CMn28Sc58wwzJCnmpUbBTR5a6UA>
    <xme:xq0WZ5xHTKPZbRfElESC_2VCjlH3BWVnp9vi0rTVm7NePp4PlfVn0liT_xE4Tz6FQ
    v9tvzyOHc_Je7ihzYQ>
X-ME-Received: <xmr:xq0WZ539AFOTHYiKJiYBq423jNIkgII1sLjBGLhQf6xt1546mjo8MJ9KL2J-MLMpckJOf57EIeRbwWGnTzCYY4QO57eaubLv93lX594m8wYCweZDJft9Sc5hHOLrZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduuc
    dludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peforghrkhcurfgvrghrshhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteei
    geeugfekhffhgeejudeuteehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdr
    tggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghpthhtohephhgu
    vghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvih
    hnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhm
    qdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xq0WZwB25nJ-Kd7ljiOzApUA582gtcRWlLDTqLY45dDLeikwhyrYKg>
    <xmx:xq0WZ1gCaP5FWfmxRJ_lIanaECX_hEsXcfINKXGhIzbXZPuiKEM-fQ>
    <xmx:xq0WZ8qrar6RA7j4eZX33RlQmi9IRHOmap90gw3igPZQCvJl-yz8lw>
    <xmx:xq0WZ4gymObsjsuT_sdsaX85nyLj1-X2N7VD6PObjVw5G-w58eKdAw>
    <xmx:xq0WZzYHlAfEh29a69rL7EXvEknataal18x3E-uva_WUcKxYOr4dYKCB>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:38:46 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: think-lmi: Multi-certificate support
Date: Mon, 21 Oct 2024 15:38:26 -0400
Message-ID: <20241021193837.7641-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo are adding support for both Admin and System certificates to
the certificate based authentication feature

This commit adds the support for this.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 .../testing/sysfs-class-firmware-attributes   |   1 +
 drivers/platform/x86/think-lmi.c              | 141 ++++++++++++++----
 drivers/platform/x86/think-lmi.h              |   4 +
 3 files changed, 116 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 1a8b59f5d6e3..2713efa509b4 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -303,6 +303,7 @@ Description:
 					being configured allowing anyone to make changes.
 					After any of these operations the system must reboot for the changes to
 					take effect.
+					Admin and System certificates are supported from 2025 systems onward.
 
 		certificate_thumbprint:
 					Read only attribute used to display the MD5, SHA1 and SHA256 thumbprints
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 751e351dfc42..fca190232c24 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -169,11 +169,12 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  */
 #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
 
-#define TLMI_POP_PWD BIT(0) /* Supervisor */
-#define TLMI_PAP_PWD BIT(1) /* Power-on */
-#define TLMI_HDD_PWD BIT(2) /* HDD/NVME */
-#define TLMI_SMP_PWD BIT(6) /* System Management */
-#define TLMI_CERT    BIT(7) /* Certificate Based */
+#define TLMI_POP_PWD  BIT(0) /* Supervisor */
+#define TLMI_PAP_PWD  BIT(1) /* Power-on */
+#define TLMI_HDD_PWD  BIT(2) /* HDD/NVME */
+#define TLMI_SMP_PWD  BIT(6) /* System Management */
+#define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
+#define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
 
 static const struct tlmi_err_codes tlmi_errs[] = {
 	{"Success", 0},
@@ -678,18 +679,35 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	return count;
 }
 
+#define NUM_THUMBTYPES 3
+static char *thumbtypes[NUM_THUMBTYPES] = {"Md5", "Sha1", "Sha256"};
+
 static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
-	int count = 0;
+	char *wmistr;
+	int count = 0, i;
 
 	if (!tlmi_priv.certificate_support || !setting->cert_installed)
 		return -EOPNOTSUPP;
 
-	count += cert_thumbprint(buf, "Md5", count);
-	count += cert_thumbprint(buf, "Sha1", count);
-	count += cert_thumbprint(buf, "Sha256", count);
+	for (i = 0; i < NUM_THUMBTYPES; i++) {
+		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
+			/* Format: 'SVC | SMC, Thumbtype' */
+			wmistr = kasprintf(GFP_KERNEL, "%s,%s",
+					   setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+					   thumbtypes[i]);
+		} else {
+			/* Format: 'Thumbtype' */
+			wmistr = kasprintf(GFP_KERNEL, "%s", thumbtypes[i]);
+		}
+		if (!wmistr)
+			return -ENOMEM;
+		count += cert_thumbprint(buf, wmistr, count);
+		kfree(wmistr);
+	}
+
 	return count;
 }
 
@@ -720,8 +738,15 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 	if (!passwd)
 		return -ENOMEM;
 
-	/* Format: 'Password,Signature' */
-	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
+	if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
+		/* Format: 'SVC | SMC, password, signature' */
+		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
+				     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+				     passwd, setting->signature);
+	} else {
+		/* Format: 'Password,Signature' */
+		auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
+	}
 	if (!auth_str) {
 		kfree_sensitive(passwd);
 		return -ENOMEM;
@@ -735,12 +760,19 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 
 static struct kobj_attribute auth_cert_to_password = __ATTR_WO(cert_to_password);
 
+enum cert_install_mode {
+	TLMI_CERT_INSTALL,
+	TLMI_CERT_UPDATE,
+};
+
 static ssize_t certificate_store(struct kobject *kobj,
 				  struct kobj_attribute *attr,
 				  const char *buf, size_t count)
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
+	enum cert_install_mode install_mode = TLMI_CERT_INSTALL;
 	char *auth_str, *new_cert;
+	char *signature;
 	char *guid;
 	int ret;
 
@@ -756,10 +788,18 @@ static ssize_t certificate_store(struct kobject *kobj,
 		if (!setting->signature || !setting->signature[0])
 			return -EACCES;
 
-		/* Format: 'serial#, signature' */
-		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
-				dmi_get_system_info(DMI_PRODUCT_SERIAL),
-				setting->signature);
+		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
+			/* Format: 'SVC | SMC, serial#, signature' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
+					     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+					     dmi_get_system_info(DMI_PRODUCT_SERIAL),
+					     setting->signature);
+		} else {
+			/* Format: 'serial#, signature' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
+					     dmi_get_system_info(DMI_PRODUCT_SERIAL),
+					     setting->signature);
+		}
 		if (!auth_str)
 			return -ENOMEM;
 
@@ -776,24 +816,59 @@ static ssize_t certificate_store(struct kobject *kobj,
 
 	if (setting->cert_installed) {
 		/* Certificate is installed so this is an update */
-		if (!setting->signature || !setting->signature[0]) {
+		install_mode = TLMI_CERT_UPDATE;
+		/* If admin account enabled - need to use it's signature */
+		if (tlmi_priv.pwd_admin->pwd_enabled)
+			signature = tlmi_priv.pwd_admin->signature;
+		else
+			signature = setting->signature;
+	} else { /* Cert install */
+		/* Check if SMC and SVC already installed */
+		if ((setting == tlmi_priv.pwd_system) && tlmi_priv.pwd_admin->cert_installed) {
+			/* This gets treated as a cert update */
+			install_mode = TLMI_CERT_UPDATE;
+			signature = tlmi_priv.pwd_admin->signature;
+		} else { /* Regular cert install */
+			install_mode = TLMI_CERT_INSTALL;
+			signature = setting->signature;
+		}
+	}
+
+	if (install_mode == TLMI_CERT_UPDATE) {
+		/* This is a certificate update */
+		if (!signature || !signature[0]) {
 			kfree(new_cert);
 			return -EACCES;
 		}
 		guid = LENOVO_UPDATE_BIOS_CERT_GUID;
-		/* Format: 'Certificate,Signature' */
-		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
-				new_cert, setting->signature);
+		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
+			/* Format: 'SVC | SMC, certificate, signature' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
+					     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+					     new_cert, signature);
+		} else {
+			/* Format: 'Certificate,Signature' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s",
+					     new_cert, signature);
+		}
 	} else {
 		/* This is a fresh install */
-		if (!setting->pwd_enabled || !setting->password[0]) {
+		/* To set admin cert, a password must be enabled */
+		if ((setting == tlmi_priv.pwd_admin) &&
+		    (!setting->pwd_enabled || !setting->password[0])) {
 			kfree(new_cert);
 			return -EACCES;
 		}
 		guid = LENOVO_SET_BIOS_CERT_GUID;
-		/* Format: 'Certificate,Admin-password' */
-		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
-				new_cert, setting->password);
+		if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) {
+			/* Format: 'SVC | SMC, Certificate, password' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s",
+					     setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+					     new_cert, setting->password);
+		} else {
+			/* Format: 'Certificate, password' */
+			auth_str = kasprintf(GFP_KERNEL, "%s,%s", new_cert, setting->password);
+		}
 	}
 	kfree(new_cert);
 	if (!auth_str)
@@ -873,14 +948,19 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
 		return 0;
 	}
 
-	/* We only display certificates on Admin account, if supported */
+	/* We only display certificates, if supported */
 	if (attr == &auth_certificate.attr ||
 	    attr == &auth_signature.attr ||
 	    attr == &auth_save_signature.attr ||
 	    attr == &auth_cert_thumb.attr ||
 	    attr == &auth_cert_to_password.attr) {
-		if ((setting == tlmi_priv.pwd_admin) && tlmi_priv.certificate_support)
+		if (tlmi_priv.certificate_support) {
+			if (setting == tlmi_priv.pwd_admin)
+				return attr->mode;
+		if ((tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) &&
+		    (setting == tlmi_priv.pwd_system))
 			return attr->mode;
+		}
 		return 0;
 	}
 
@@ -1700,12 +1780,13 @@ static int tlmi_analyze(void)
 		}
 	}
 
-	if (tlmi_priv.certificate_support &&
-		(tlmi_priv.pwdcfg.core.password_state & TLMI_CERT))
-		tlmi_priv.pwd_admin->cert_installed = true;
-
+	if (tlmi_priv.certificate_support) {
+		tlmi_priv.pwd_admin->cert_installed =
+			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
+		tlmi_priv.pwd_system->cert_installed =
+			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
+	}
 	return 0;
-
 fail_clear_attr:
 	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
 		if (tlmi_priv.setting[i]) {
diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
index 4728f40143a3..f267d8b46957 100644
--- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -41,6 +41,10 @@ enum save_mode {
 };
 
 /* password configuration details */
+#define TLMI_PWDCFG_MODE_LEGACY    0
+#define TLMI_PWDCFG_MODE_PASSWORD  1
+#define TLMI_PWDCFG_MODE_MULTICERT 3
+
 struct tlmi_pwdcfg_core {
 	uint32_t password_mode;
 	uint32_t password_state;
-- 
2.47.0


