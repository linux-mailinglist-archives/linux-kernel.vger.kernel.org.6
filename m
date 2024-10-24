Return-Path: <linux-kernel+bounces-380593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1C9AF313
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8806C281D62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E12178E4;
	Thu, 24 Oct 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="oxCtvtmi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaxW4xwE"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89922B656;
	Thu, 24 Oct 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799755; cv=none; b=SDl6pG9dLW1UJ7RaDuGf6UGkLqaPx2p+sqDXVJzNAnAjgbhlr+eDVp6axuFX26mygCcxmaBnllEcP+3CjpjTKYHVbcIF2i4xS3GAburTOB3lGKkvRTZMrVa3Y6PnTQF/TRvKr5T6ibVR5Op7FjY9T0YkLZWVl3XnY+T0m7LpXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799755; c=relaxed/simple;
	bh=eLoZFRv/+bGsCylHl4Z+h5CllioftnShRTa2IZ44h6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeUawRkJUE5HZVtmOCeC6TX53qrzaayqAr8bj8lXSzuAw73GcSrhmbPt1l8FHCUdLR4JMCwg1FXehECNO3mlanNuxiH1jIb1JiQigmJootBST2gT7ZbGtXlHym4FHtk/GP8iB+s19YuRoaLVvplRI8GeIUTHl+6fbu7SJ5ogjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=oxCtvtmi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaxW4xwE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E25F71140176;
	Thu, 24 Oct 2024 15:55:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 24 Oct 2024 15:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729799750; x=
	1729886150; bh=vJH16W/lPDWb/9evzEf9E2AdU2tOOTrsigIU+BP0YWc=; b=o
	xCtvtmiTEN/UV7MJtfhAM0MLGF3IqF8BpCEUgOZwejyowXujDtlZnauzmJMuG2hN
	6p3uob+ssPHKVwxSLCaWxLKcxlV+mopX/kaDqm7g1wdypr/u9jKclcxJ0TQ6ng+H
	yxIs4NKwLdVJ1gmutgTBUBjsDtOp2Rruo2sYG0uvgZ5cfbCJGtmBcZIKqp9Xm+gu
	pvS5lWyQ55z7XjfkI5d+BowlGyrElh+eHdyHA+6LlbLEvWgI/Tc8zphFbvLNzM5f
	1Qp7ZmEAaOLJPADWqqNSSEJjbktMz0wU1KGQp8AsjKL3l2hBFIpeqh179jaZYOQw
	WQzeCOsA0ZhS8e849JhKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729799750; x=
	1729886150; bh=vJH16W/lPDWb/9evzEf9E2AdU2tOOTrsigIU+BP0YWc=; b=F
	axW4xwElVD8lcXv1B5mHD/523sFNqZCKvRZWJyzUSDyba5mv5z8Qsb8u9jOJoJ4f
	wsbvQs0WAavF4ciXildlR7e7Pm3pGT+aCs6KhDZE6YuJjD5mnYlrJ/nKrVuHHqS7
	kmPGx5v5h4vQei4MrM/YC9LsqpySwH8FqMkTWTPzDcHM6aV54h+7vMCSPRMsRQ59
	SpBrvtqtGHQNsFP7OwgoSWFF6FnN8Dwani8+fwmGLhIoMx1i5Kk/i5InMc5X+Bpf
	BvoA4qBvf/bn7xMneP3Pji9lvvdPp7nRcQ/ccObAs71jmle+vRPnAeuKgZtRCnIQ
	SBt/TH3OfzU0C8k5TQ4sw==
X-ME-Sender: <xms:RqYaZ10lDygo_e1DS91eVS9dDprFOqljxmGHY4yxFrdR-qfM_2yJLg>
    <xme:RqYaZ8GStgmNYrzNpB9IWRUL9ZBzkTBWLLMcvSvtf2J-bzrA7_M8-70C3lOmuS4OT
    XCIif-YaMbMjgHOf0Q>
X-ME-Received: <xmr:RqYaZ1464slGbCOG_SV8lyQyELXmuXSDn_WqicJrmMyuOQD8b2dBDKowGcpQqaTSy48aQvYzmPadeJuEIxCWpMkWJ3A1RnStY_HJQ6yoUEf0tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddguddujecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:RqYaZy26Ts2fSwfLnc0Ejne_MYu0b1-9wnbbg2O75gQD1WD1vYh34Q>
    <xmx:RqYaZ4F3iQlVqPOSeZkKP-ZK2Pf5IjdQopdeuxzl4Mlx1kExmrll5w>
    <xmx:RqYaZz9kuBqubUciiwiqipquWL0vraTz7M3LJgAYAqBtgocN-_Kt4g>
    <xmx:RqYaZ1naRImJWB7cN5LUciVNyRZt4OiUtOzNHI6owkOkifCF_869XQ>
    <xmx:RqYaZ9Ojxc4hCQsKw1SnMG5JKdp95UYz1NeU7fGOdJg9fMd2JK0scPNj>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 15:55:49 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: think-lmi: Multi-certificate support
Date: Thu, 24 Oct 2024 15:55:24 -0400
Message-ID: <20241024195536.6992-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
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
Changes in v2:
 - Add cert_command helper function to simplify common code.
 - Correct indentation in auth_attr_is_visible function.
 - Use ARRAY_SIZE for thumbtypes.
 - Cosmetic cleanup from review.
 
 .../testing/sysfs-class-firmware-attributes   |   1 +
 drivers/platform/x86/think-lmi.c              | 115 ++++++++++++++----
 drivers/platform/x86/think-lmi.h              |   4 +
 3 files changed, 94 insertions(+), 26 deletions(-)

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
index c316b1b592d6..6e46329d529d 100644
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
@@ -653,6 +654,17 @@ static ssize_t level_store(struct kobject *kobj,
 
 static struct kobj_attribute auth_level = __ATTR_RW(level);
 
+static char *cert_command(struct tlmi_pwd_setting *setting, const char *arg1, const char *arg2)
+{
+	/* Prepend with SVC or SMC if multicert supported */
+	if (tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT)
+		return kasprintf(GFP_KERNEL, "%s,%s,%s",
+				 setting == tlmi_priv.pwd_admin ? "SVC" : "SMC",
+				 arg1, arg2);
+	else
+		return kasprintf(GFP_KERNEL, "%s,%s", arg1, arg2);
+}
+
 static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 {
 	const struct acpi_buffer input = { strlen(arg), (char *)arg };
@@ -678,18 +690,35 @@ static ssize_t cert_thumbprint(char *buf, const char *arg, int count)
 	return count;
 }
 
+static char *thumbtypes[] = {"Md5", "Sha1", "Sha256"};
+
 static ssize_t certificate_thumbprint_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
+	unsigned int i;
 	int count = 0;
+	char *wmistr;
 
 	if (!tlmi_priv.certificate_support || !setting->cert_installed)
 		return -EOPNOTSUPP;
 
-	count += cert_thumbprint(buf, "Md5", count);
-	count += cert_thumbprint(buf, "Sha1", count);
-	count += cert_thumbprint(buf, "Sha256", count);
+	for (i = 0; i < ARRAY_SIZE(thumbtypes); i++) {
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
 
@@ -721,7 +750,7 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	/* Format: 'Password,Signature' */
-	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
+	auth_str = cert_command(setting, passwd, setting->signature);
 	if (!auth_str) {
 		kfree_sensitive(passwd);
 		return -ENOMEM;
@@ -735,12 +764,19 @@ static ssize_t cert_to_password_store(struct kobject *kobj,
 
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
 
@@ -757,9 +793,9 @@ static ssize_t certificate_store(struct kobject *kobj,
 			return -EACCES;
 
 		/* Format: 'serial#, signature' */
-		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
-				dmi_get_system_info(DMI_PRODUCT_SERIAL),
-				setting->signature);
+		auth_str = cert_command(setting,
+					dmi_get_system_info(DMI_PRODUCT_SERIAL),
+					setting->signature);
 		if (!auth_str)
 			return -ENOMEM;
 
@@ -776,24 +812,44 @@ static ssize_t certificate_store(struct kobject *kobj,
 
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
 		/* Format: 'Certificate,Signature' */
-		auth_str = kasprintf(GFP_KERNEL, "%s,%s",
-				new_cert, setting->signature);
+		auth_str = cert_command(setting, new_cert, signature);
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
+		/* Format: 'Certificate, password' */
+		auth_str = cert_command(setting, new_cert, setting->password);
 	}
 	kfree(new_cert);
 	if (!auth_str)
@@ -873,14 +929,19 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
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
-			return attr->mode;
+		if (tlmi_priv.certificate_support) {
+			if (setting == tlmi_priv.pwd_admin)
+				return attr->mode;
+			if ((tlmi_priv.pwdcfg.core.password_mode >= TLMI_PWDCFG_MODE_MULTICERT) &&
+			    (setting == tlmi_priv.pwd_system))
+				return attr->mode;
+		}
 		return 0;
 	}
 
@@ -1700,10 +1761,12 @@ static int tlmi_analyze(void)
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
 
 fail_clear_attr:
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


