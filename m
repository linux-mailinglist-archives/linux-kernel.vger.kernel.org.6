Return-Path: <linux-kernel+bounces-322416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CC9728C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF96E2841ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571B16ABC6;
	Tue, 10 Sep 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="RLea/Y5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4bt724P"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853B38DD3;
	Tue, 10 Sep 2024 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944717; cv=none; b=XSJSDl/9I3lxKizL7gOyp5CdNWhj7e2IlcoDx2TGrNgHJHQHMC2xP6UY03KgS3tOhQxxBSa9ekP5Seo0b/fSTXhu5zhFTfwMi2bdws3CmShWlN7mOmFVg7FOHUbYNsrqAeZLlufuTLYmpfjLWDqiZIFGSuCiD3Z74eHIxEtEVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944717; c=relaxed/simple;
	bh=36w5LN/cNmCZmo1wdtMW/0wQJ4a2jDmoWxHzCrTnau4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRaDzrfnwXYWuPENwOl08bV5XdqSQdSJ7J1vChVV3+EjMG+K/TRpi5YJxoO2B9LOQwpclwgwF6L5DJyEXz8sbDuSJNrMI3RfxQ7h5F9QskN/qCp56Svl50LJ23JT2qg5PGBrErRa8D14KzC1wu2Y6QvlRnzeNYLk3rSgmTZtjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=RLea/Y5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4bt724P; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 340DA138032A;
	Tue, 10 Sep 2024 01:05:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 10 Sep 2024 01:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1725944714; x=1726031114; bh=6XTNGnM9yC7rHUm4eIlz6
	XgUuyw3KJQWESfzgQcikrQ=; b=RLea/Y5wnrOyLQSZeEad/qAHHsYGtsvbckyL0
	5Zj9oQ6d77nH6/o+9KXb+Sh0aoSzRt9ONlanFdTcdIzp7Ohm0KKFdb9IU2zJN6po
	fgb7REUApuh1kIQbnQPoPHyASmHQiP2jCRhDBIq4qtArwFYU+gu7wXRoun07cjlT
	rBaprtHJatK5JlxY3xiC4SUj1nBy15TsoECScx3NWZBPywVXDnc+djn8r7VKCnB3
	DU9iBAEh07l1KUMvBhWraXvyj4DS/limGHgEI+vOYa15sLMn0dowLGHBe/+nL2RG
	xQspidPZmdKdR0nur8BkGz7eNPsrMdv8S8yuMErf0/81no7Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725944714; x=1726031114; bh=6XTNGnM9yC7rHUm4eIlz6XgUuyw3
	KJQWESfzgQcikrQ=; b=E4bt724PMdVe9bWm7bMO97vhN1HFvvfqMNSyN00xGKRj
	ywEv5Hgybv4+BRx+EA98BCtQIxLWRZlSDuFEv1rnnhvWfI5u0nkYn6Hb7FRSy1cp
	saJfUD/kL8makH+D6qHooJYUPCFBwo/D7hH+yl87VFh2AC8cvZLCpJVMYJBNwmlP
	+WLYi/gNGQ7OUS2NjNJmhR3sLA5jgchgmprZbqZs08+3ZQjbTu3pYhKhzVKsoEyC
	ZnuQh14Bnu5mc6uNEMyLakIEwq+FGWXEAdnedoIUwUgk45D4bJjperaH+ZuyIeTg
	w+wFqNqCBoxpdaqUEYd3q+EueqdwDs20EDbtjNF5AA==
X-ME-Sender: <xms:itPfZtAGXX_C6BXKzFXpTfyFhTKIDgyOKfBt292gNZ59cWZ02XWEwA>
    <xme:itPfZrjicL6uNx4T4qq8hhy102K3JiVxudykZKraFJeZSVh0tZHHX0tHh78OLjOYa
    XoTPViCKr5bS3rNfDI>
X-ME-Received: <xmr:itPfZokwwgp199PYMzq09YdJaPCFz8ejRUziVurC3qAw9NgIYZCVgtlMlXM5PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdf
    uceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthf
    duudekffefkeeiffdttddvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvsh
    druggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtphhtth
    hopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:itPfZnwsed0x6Fsx-BjWsfKqveIRJ4NqVDMfRMQxzYeqw4Q6LZwqeQ>
    <xmx:itPfZiQdI_FMs4tXdW0Ttu730_msDMo3Zd_2Q6LpdtyuATJi5BFgVg>
    <xmx:itPfZqZcOM7Tw2YGddvsUZIa2iU0KZjUzjXIxYtu8rOD87jIYMjRWQ>
    <xmx:itPfZjQo4kA1UOR55GHV8O5pPRY9VjRy4if0qoIkl20cvFXWrc4Ckw>
    <xmx:itPfZvK0Da1D2v6YM-Ie4a-l_gCNQsn751nRgPafrEG9g3ZPiyw0uOUc>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 01:05:11 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: add debug print in more key places
Date: Tue, 10 Sep 2024 17:05:07 +1200
Message-ID: <20240910050507.685069-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more verbose debug print in the WMI method calls. This helps a lot
with debugging various issues working with regular users as the WMI
methods can be traced now.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 58 +++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 85c90ed9873b..6d187fc3aba1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -354,20 +354,29 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
 				     &input, &output);
 
-	if (ACPI_FAILURE(status))
+	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x, 0x%08x\n",
+		__func__, method_id, arg0, arg1, arg2);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, -EIO);
 		return -EIO;
+	}
 
 	obj = (union acpi_object *)output.pointer;
 	if (obj && obj->type == ACPI_TYPE_INTEGER)
 		tmp = (u32) obj->integer.value;
 
+	pr_debug("Result: 0x%08x\n", tmp);
 	if (retval)
 		*retval = tmp;
 
 	kfree(obj);
 
-	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
+	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, -ENODEV);
 		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -397,20 +406,29 @@ static int asus_wmi_evaluate_method5(u32 method_id,
 	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
 				     &input, &output);
 
-	if (ACPI_FAILURE(status))
+	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
+		__func__, method_id, arg0, arg1, arg2, arg3, arg4);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, -EIO);
 		return -EIO;
+	}
 
 	obj = (union acpi_object *)output.pointer;
 	if (obj && obj->type == ACPI_TYPE_INTEGER)
 		tmp = (u32) obj->integer.value;
 
+	pr_debug("Result: %x\n", tmp);
 	if (retval)
 		*retval = tmp;
 
 	kfree(obj);
 
-	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
+	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, -ENODEV);
 		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -436,8 +454,13 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
 				     &input, &output);
 
-	if (ACPI_FAILURE(status))
+	pr_debug("%s called (0x%08x) with args: 0x%08x, 0x%08x\n",
+		__func__, method_id, arg0, arg1);
+	if (ACPI_FAILURE(status)) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, -EIO);
 		return -EIO;
+	}
 
 	obj = (union acpi_object *)output.pointer;
 
@@ -473,8 +496,11 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 
 	kfree(obj);
 
-	if (err)
+	if (err) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, err);
 		return err;
+	}
 
 	return 0;
 }
@@ -562,6 +588,7 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 {
 	u32 retval;
 	int status = asus_wmi_get_devstate(asus, dev_id, &retval);
+	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
 
 	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
 }
@@ -3583,18 +3610,27 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 
 	err = fan_curve_check_present(asus, &asus->cpu_fan_curve_available,
 				      ASUS_WMI_DEVID_CPU_FAN_CURVE);
-	if (err)
+	if (err) {
+		pr_debug("%s, checked 0x%08x, failed: %d\n",
+			__func__, ASUS_WMI_DEVID_CPU_FAN_CURVE, err);
 		return err;
+	}
 
 	err = fan_curve_check_present(asus, &asus->gpu_fan_curve_available,
 				      ASUS_WMI_DEVID_GPU_FAN_CURVE);
-	if (err)
+	if (err) {
+		pr_debug("%s, checked 0x%08x, failed: %d\n",
+			__func__, ASUS_WMI_DEVID_GPU_FAN_CURVE, err);
 		return err;
+	}
 
 	err = fan_curve_check_present(asus, &asus->mid_fan_curve_available,
 				      ASUS_WMI_DEVID_MID_FAN_CURVE);
-	if (err)
+	if (err) {
+		pr_debug("%s, checked 0x%08x, failed: %d\n",
+			__func__, ASUS_WMI_DEVID_MID_FAN_CURVE, err);
 		return err;
+	}
 
 	if (!asus->cpu_fan_curve_available
 		&& !asus->gpu_fan_curve_available
@@ -4438,8 +4474,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 
-	if (devid != -1)
+	if (devid != -1) {
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
+		pr_debug("%s called 0x%08x, ok: %x\n", __func__, devid, ok);
+	}
 
 	return ok ? attr->mode : 0;
 }
-- 
2.46.0


