Return-Path: <linux-kernel+bounces-380591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04F9AF311
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52AA28341F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B92170D4;
	Thu, 24 Oct 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="JNQih5kO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BCjwjiou"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49E189F5F;
	Thu, 24 Oct 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799753; cv=none; b=otbLUpQvukj/UxxTsAl6rwrB6ocrPNXfdB7pEH/vX0pdZ09+NUqVk7AzJ8zfuqsTGoZ0QFOqBw0yuustQgEnGpKENjvQmmpwmnXQ00BXLuBv6/0pNSItGHVsgg51izhRDV9MTkY6yCQ5eybaMs8Lk1HQF7DCZiuXIQhn9MH00CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799753; c=relaxed/simple;
	bh=pYQuRYUioIPEDyBgu8+ZshaoB3MG69sDVqHUAKmub9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJcthPpEfUY6SUTIm+rDRiWt9XJBSFeuRc3Hf79AAtACJk5RbtimukkcPmQqdB0vC18BmWV4Lp3VU6NLtH/AN+9QDJzIBnKTsLhxYr8DNsvMX5OZuT2sZbWGZKxkqyXu+DFt0ckGaY4VmcJxsO/KzX55+D05i0PW4WWjGoq4Ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=JNQih5kO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BCjwjiou; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 29E71138019F;
	Thu, 24 Oct 2024 15:55:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 24 Oct 2024 15:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729799747; x=
	1729886147; bh=jrmQUEFhofqO6xqHrhgja9vDio8qXCoJ0c0hfuIb4L4=; b=J
	NQih5kOORFsgbQu8kjzfegCvGOmvcFfdmgDl5qnvYrozFyHQR7WLFHOhcM+XXjSO
	oZ9wrWCNSBteM2QQCufqR6sYRMQAB4G78IT84X96p9wNTgQuV0FZfSKH24LW8FZp
	JCpHufMRRqkIPB8Kw1kqe3C+vmPDtnNv/fS/SLrLVvbs47syIWNlh0WFa336zKo6
	FkHGNCk4GU06VsIp+pcnKKBG+UoqjpaZBgHoqRaxMAUnO3gNvo/z2naDkCbg7DQL
	JBE11nhf9hdbDlmue+lgcxoZjUoKwfwmy70sF5Qaf+agQfIIkWR4WXSlBhHt9GYw
	iu5fwJNfcNR/9JxbGA68Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729799747; x=
	1729886147; bh=jrmQUEFhofqO6xqHrhgja9vDio8qXCoJ0c0hfuIb4L4=; b=B
	CjwjiouUWnAD54QOyjp847I09XQDVPMPHP3LAQalH9y4D0mTXp5qUmmIr/ISpEC+
	JcyaX+FhXkG34y8S2yC/jzYO2ZcMGKorM/YUFT0fYLGvCwDv5uPSmGX/trqIQOxa
	9KfvY3mfy0Vg6LpIwWs99IvhJQPewaeOxwxr86rcdpgPdiynlYfj0370Dgebz3S3
	e4Dlm5rfkRfpl+XrYlBkfwJsBm4qYYGHYzqQhp2D9QAagyfQGCY+g1nf+aNkkTzV
	bg7Siv0GGuQ6qlFj5Ev8S20g0f4Kgca/V19614Bzjq1NRfu9okCfWk0I/aVBdvJN
	Sjrfq6WGRFzxfrDbETgHA==
X-ME-Sender: <xms:QqYaZ6PesmIGbPK7Yu5UQZYaOvF5zG6r0WKDHGwRlGhj_lhqJb84Eg>
    <xme:QqYaZ49ZaZr1F8Mzk-MsNsCB2NwzKLod1f1y0vIThRnxldeQtmPvj2cEv_GefCYmO
    Of3vyYDvWCLgY3qJrM>
X-ME-Received: <xmr:QqYaZxT0he79ZlH83h0VfflOINLlzlqzuCToD4nqKcazPhg50lxvctzKWgl0FZRlygU3p3fg1MhdAbCFC8U2orAJvHOne6sV6c3AfIZoampr7g>
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
X-ME-Proxy: <xmx:QqYaZ6tQpoeVgRMJkH5UmKZbU0SJLQ6UZxY9_vrRjCv8oxuGTkj3NQ>
    <xmx:QqYaZye_MRKEFcJi_qth3wpiv3DJ_pNRyqVQXGZ-l-9uFJCtdk3ZhA>
    <xmx:QqYaZ-0Jxvs4FfTAGvkr2npRMBurW-N2qJx1v_q_muCo9Ro8Jhv_IA>
    <xmx:QqYaZ2-5Vj8V40Gx3yh5deronpX8g5SWsy0oDUNOewztusahT7oGog>
    <xmx:Q6YaZ_HRXx_xkdK2Inn_0xu5zMDcdP6HOkT0IYZudlW3PqGdyCJmJwxQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 15:55:45 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86: think-lmi: improve check if BIOS account security enabled
Date: Thu, 24 Oct 2024 15:55:21 -0400
Message-ID: <20241024195536.6992-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve determination of whether authentication account is enabled by
checking if either password or certificate is enabled.

Renamed valid to pwd_enabled for better readability.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2: No changes, version updated as part of series.

 drivers/platform/x86/think-lmi.c | 26 +++++++++++++-------------
 drivers/platform/x86/think-lmi.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 4cfb53206cb8..727a9400d406 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -391,7 +391,7 @@ static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr
 {
 	struct tlmi_pwd_setting *setting = to_tlmi_pwd_setting(kobj);
 
-	return sysfs_emit(buf, "%d\n", setting->valid);
+	return sysfs_emit(buf, "%d\n", setting->pwd_enabled || setting->cert_installed);
 }
 
 static struct kobj_attribute auth_is_pass_set = __ATTR_RO(is_enabled);
@@ -469,7 +469,7 @@ static ssize_t new_password_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->valid) {
+		if (tlmi_priv.pwd_admin->pwd_enabled) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 					tlmi_priv.pwd_admin->password);
 			if (ret)
@@ -777,7 +777,7 @@ static ssize_t certificate_store(struct kobject *kobj,
 				new_cert, setting->signature);
 	} else {
 		/* This is a fresh install */
-		if (!setting->valid || !setting->password[0]) {
+		if (!setting->pwd_enabled || !setting->password[0]) {
 			kfree(new_cert);
 			return -EACCES;
 		}
@@ -1019,7 +1019,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		 * Workstation's require the opcode to be set before changing the
 		 * attribute.
 		 */
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+		if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 						  tlmi_priv.pwd_admin->password);
 			if (ret)
@@ -1042,7 +1042,7 @@ static ssize_t current_value_store(struct kobject *kobj,
 		else
 			ret = tlmi_save_bios_settings("");
 	} else { /* old non-opcode based authentication method (deprecated) */
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+		if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 					tlmi_priv.pwd_admin->password,
 					encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1215,7 +1215,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 			if (ret)
 				goto out;
 		} else if (tlmi_priv.opcode_support) {
-			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
 							  tlmi_priv.pwd_admin->password);
 				if (ret)
@@ -1223,7 +1223,7 @@ static ssize_t save_settings_store(struct kobject *kobj, struct kobj_attribute *
 			}
 			ret = tlmi_save_bios_settings("");
 		} else { /* old non-opcode based authentication method (deprecated) */
-			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 				auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 						     tlmi_priv.pwd_admin->password,
 						     encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1273,7 +1273,7 @@ static ssize_t debug_cmd_store(struct kobject *kobj, struct kobj_attribute *attr
 	if (!new_setting)
 		return -ENOMEM;
 
-	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+	if (tlmi_priv.pwd_admin->pwd_enabled && tlmi_priv.pwd_admin->password[0]) {
 		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
 				tlmi_priv.pwd_admin->password,
 				encoding_options[tlmi_priv.pwd_admin->encoding],
@@ -1637,14 +1637,14 @@ static int tlmi_analyze(void)
 		goto fail_clear_attr;
 
 	if (tlmi_priv.pwdcfg.core.password_state & TLMI_PAP_PWD)
-		tlmi_priv.pwd_admin->valid = true;
+		tlmi_priv.pwd_admin->pwd_enabled = true;
 
 	tlmi_priv.pwd_power = tlmi_create_auth("pop", "power-on");
 	if (!tlmi_priv.pwd_power)
 		goto fail_clear_attr;
 
 	if (tlmi_priv.pwdcfg.core.password_state & TLMI_POP_PWD)
-		tlmi_priv.pwd_power->valid = true;
+		tlmi_priv.pwd_power->pwd_enabled = true;
 
 	if (tlmi_priv.opcode_support) {
 		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
@@ -1652,7 +1652,7 @@ static int tlmi_analyze(void)
 			goto fail_clear_attr;
 
 		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SMP_PWD)
-			tlmi_priv.pwd_system->valid = true;
+			tlmi_priv.pwd_system->pwd_enabled = true;
 
 		tlmi_priv.pwd_hdd = tlmi_create_auth("hdd", "hdd");
 		if (!tlmi_priv.pwd_hdd)
@@ -1670,7 +1670,7 @@ static int tlmi_analyze(void)
 			/* Check if PWD is configured and set index to first drive found */
 			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
 					tlmi_priv.pwdcfg.ext.hdd_master_password) {
-				tlmi_priv.pwd_hdd->valid = true;
+				tlmi_priv.pwd_hdd->pwd_enabled = true;
 				if (tlmi_priv.pwdcfg.ext.hdd_master_password)
 					tlmi_priv.pwd_hdd->index =
 						ffs(tlmi_priv.pwdcfg.ext.hdd_master_password) - 1;
@@ -1680,7 +1680,7 @@ static int tlmi_analyze(void)
 			}
 			if (tlmi_priv.pwdcfg.ext.nvme_user_password ||
 					tlmi_priv.pwdcfg.ext.nvme_master_password) {
-				tlmi_priv.pwd_nvme->valid = true;
+				tlmi_priv.pwd_nvme->pwd_enabled = true;
 				if (tlmi_priv.pwdcfg.ext.nvme_master_password)
 					tlmi_priv.pwd_nvme->index =
 						ffs(tlmi_priv.pwdcfg.ext.nvme_master_password) - 1;
diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
index e1975ffebeb4..4728f40143a3 100644
--- a/drivers/platform/x86/think-lmi.h
+++ b/drivers/platform/x86/think-lmi.h
@@ -65,7 +65,7 @@ struct tlmi_pwdcfg {
 /* password setting details */
 struct tlmi_pwd_setting {
 	struct kobject kobj;
-	bool valid;
+	bool pwd_enabled;
 	char password[TLMI_PWD_BUFSIZE];
 	const char *pwd_type;
 	const char *role;
-- 
2.47.0


