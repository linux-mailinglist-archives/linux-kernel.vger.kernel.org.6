Return-Path: <linux-kernel+bounces-375030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBB9A8FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71DD1C220ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C31FC7F5;
	Mon, 21 Oct 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="B1suubmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6zH1OIj"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBF1CF7A6;
	Mon, 21 Oct 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539528; cv=none; b=SKN1E0XY8hbl1q4H1LE/wQVijMVX6ujSh8a78ovIcQGTnNBNU9YrNiqUcTqK41Kr8yyvtmGupx6QUrt3leVWQ+L6vCa88NDhBaO/sxddQL38/UdH7ebQlZLEyEFaV/0owbgmpIgMO4Lxt1JZVThfSIwKGZtS1WkmN6V6tXTlzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539528; c=relaxed/simple;
	bh=54jwoouqgKE0bVqr3uFQHW/WkkHaCd/oyMvONoJ0cjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Esgnmx8QUip6fMQ7pHdMKicQaSBQzQxVeXuNpfjFVaAJMCNXt8crAb8tvZd3KUUqTGUlUaeBjMzwAWHj96WoU9gAs1VSg65KrAHtkd3C1058fRD41Gq3GyyWmSeh4ixl8XJC+dmaA6sCBnfI//0pb412fTa2GoQ/S75KWSoTQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=B1suubmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6zH1OIj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AA82813802EA;
	Mon, 21 Oct 2024 15:38:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Oct 2024 15:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729539524; x=
	1729625924; bh=LE2Hk0JKN4Kf5sI0bnT9emdXdEal6XnN2BMhL9CtIWs=; b=B
	1suubmcTwhSmTm8CJzrBvOAAUvImE8mUJG0Z3n28qkFDJmWrfqgHpcGRcbolhWYL
	H/jsOgPpkyrZOQJFsnG/kxxLVM4wB+ELsMpyHOGgjw0GXyou3KjZcwSdYI3CCNL3
	t9hxZCfMUi98KfCGV1beM/OX1uwLfaJOqz11gME5ifvGPK4Z4TGo1Y2lqrRXi0jC
	WeodFYgV1Iq/H9ZigHoyU6i5PobZfqspAdjlQzrtP4+KSqa2jUwR0+AnATi0imT2
	3U72sM5DoCK+PMjjIVwxcEwAnQJ70Oq3OQdS9te3w0BWvW7mrbTZgkYezMzDJj67
	mRr33ZJcq+c1Yhx6Tr6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729539524; x=
	1729625924; bh=LE2Hk0JKN4Kf5sI0bnT9emdXdEal6XnN2BMhL9CtIWs=; b=Z
	6zH1OIjfdDjS5OhpBHWkd7j7a2ydqf+kDjpwcHONPlvFOzZvIFU7QLp16OiUiT4u
	eey5suMIz86gSXHXfR/QBLcNxi+tYq/lwLtbno8gmD9vJIcdUKUTOWcSICGoOWuP
	kUoeWM8DZxUz+zT8Uc7G46WExukXHcaYn369iLZg9dyG15M38mnQ5zxmqZLgqaSI
	JDt0nakod5m1Wu+s56qjZ/hk33hWrPpiyNflYpV2fmw2D7N29p7sI/xBDcTDK2BG
	C5I2V9T9l65Q2EIaSLWLCGobhoENgwm5kon9SBl4cN2hoxDQPpVERzmiJRemL4Gb
	mVgeljUeVJxWZ2udAExzA==
X-ME-Sender: <xms:xK0WZyQbOIWvI2CFDWbXJpeGq6QHdye3LjxGh44DUQRcce7mQESfdg>
    <xme:xK0WZ3wCbKZS3UhuoTUQUXxJJqtkSy0HQcX5BBwOc0fHTR7XJUBSYxY-RQp1NHZmr
    CvWh1f_g6olxs8sLAY>
X-ME-Received: <xmr:xK0WZ_3O6K8ojBpJGgCvL3z0G2Xr6RmBtXcNSLyV-vdh1ZKUHV3r24r2MPvjzyFAJ9KL6KYxUpsEtv_k-kWRjeJ3K3m1FbAirfcIgxlF6rlcGfJ6WV-rgcch-jytdg>
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
X-ME-Proxy: <xmx:xK0WZ-DbNowvML_uJrB8rH-GYW6tBKA0Vk4crB-0pnSJirJY5QZSJw>
    <xmx:xK0WZ7iiqiuOVF8xhWnlJoH9JgyJZUad9M-6HKADoqdoiCOnGgA2tg>
    <xmx:xK0WZ6o0X_gEgNF5tC_pkgvErsmjmk-79tY9Yfa0rpTpXQrLPsklig>
    <xmx:xK0WZ-i5L7VavWEn7qDRaYsPWKj2BWX3jkvel_C9cll8z6rieXzjkg>
    <xmx:xK0WZxaHvXv-wCOUKtcGpyhIijNwnUbhJ8VKy72STZFXbdYm83N1seSb>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 15:38:43 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: think-lmi: improve check if BIOS account security enabled
Date: Mon, 21 Oct 2024 15:38:23 -0400
Message-ID: <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
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


