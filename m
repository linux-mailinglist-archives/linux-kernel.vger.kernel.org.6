Return-Path: <linux-kernel+bounces-251398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F3930467
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184F0B2310D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911A549635;
	Sat, 13 Jul 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="i+O5POC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1bAQ/x4"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38234655D;
	Sat, 13 Jul 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720857597; cv=none; b=D5pCjlYKtommStrX8gzRhPtqf4WOFOuYCgozMnece3EgKEnAj3ndddDeht5CgXkEnZ59BJLhwpR4rQ0P6WtpeWoIW7zuSY0N0w2m+l3d2yjtUkQu0qSQbcFz8MX5NUWEy4qmrGKlJpKTY4HeDPucu8dalsQqb0KsIkiMhOilJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720857597; c=relaxed/simple;
	bh=ThKHIy6sl1xHMQ3TRJ5X/mJ7vjKsgWXyARuvIZNcWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT6iPsv5Gau6ILteBUA2mOxSnDHIRWctX7YRnCaoBEVMFd53jqaDvbq0ktzPEpo5Dqf+2DPMxbDR8cuzwTwrEGwS8zaz+LwdE0pDDmbSNOPdj6nchpvO7MnpnAuyL0qEnscHlrpWbiocxXCDew0mEkF7nhAf+KVxD++jLoEIgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=i+O5POC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1bAQ/x4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E0771141C9F;
	Sat, 13 Jul 2024 03:59:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 13 Jul 2024 03:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1720857595; x=
	1720943995; bh=G4WP8JUuAjNEoU/SWJIVBFFXwy/W3zwWEvh2sFlf0F4=; b=i
	+O5POC2wrR5KDlv6PiezxpgTVxxhnFliMQ5iAMrovQPQl2BBdZIWZkYcZp78ASAZ
	saBaeq+b9/UdIXxTlBfLcKRbszrA0GdEtJglwKqlX5qi96vOg3iSmCldOTJ/jf2e
	Rnf02BuNqgTgyVzqZhB/d2anPVAJUIpKLDpokMoosyQuPKwTIW15WDbjLJtvOoM6
	8plq4+u4UjtkGIZt0q/6Diy4AK4V822JCbJCc41oiCS/DUBhReDoFOcBk0hWXkaz
	b/vPLRak75V0/3tfZoyaSo4g4Vplz8KXHjlGiYWuB8xFyx6KRyZKCPvx0f8YHdon
	2uA8LvRDcihG1G7TVWSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720857595; x=
	1720943995; bh=G4WP8JUuAjNEoU/SWJIVBFFXwy/W3zwWEvh2sFlf0F4=; b=r
	1bAQ/x4eI7Ea5q7W7ltoq1LKQfqGXSVEGrgtvRWGjmKV9XOYRlRF31hXMojFgY0R
	gEiWDomfynX74lZrgFwq81MSAili83QCXwVE6F9DDlkzETcjPIn75PbVrjTYiLkR
	30YdFaw4sWfBAIE30pj7r/NQSATilzsvVhzJTd+fkRF5RukUlq6eCrEVf7Owg3xR
	R/fMP+E/rFKw138iSLPhIpsLB9S0J1jDGSV9yH9xttQ5PLnWxVmQ79kNIwFS/dGp
	p/TnPL6jYlHi235nmF4cDjrul7ykZRdEOcmvtv8pthMbNpAINXUN6kBFds5Ma5/B
	lZpDmn5TTACpvzjYp3iPA==
X-ME-Sender: <xms:-jOSZkUPcqNXhAREjxZ4RQefqsSkIg1gTY6Yz0VEcRRcERiU1ru5ZQ>
    <xme:-jOSZoma2kJS1XDPnUl0PePQKz2aXOsSiEdxkGULAzDxQHifes38yVHFc_gu3jJeM
    CltIPvK5gVjvUe-HjY>
X-ME-Received: <xmr:-jOSZoY6lxnTwntcqBixqJYFoA3UFyrVRRMW5Sb4yFUqQdHpggXIWXzVDOBW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:-jOSZjW7YzBVi8fCs-sFqS7hoL-ZO0E-Ph31uzul8ThG6UbOM13T1w>
    <xmx:-jOSZukXyPvbTSqyvPkow9tJKH1H8HtJJ6grps7B7r_4gihtoZ9DIA>
    <xmx:-jOSZocgYJNrKtq6w8TEYiRxQvfumfnnTGa8Fz6lu1BdwlxFg3Wh9g>
    <xmx:-jOSZgG1OJ5cF4RS3hnBK99djAEa7clwGO6wjr9EejeK7Eg2jr5BsA>
    <xmx:-zOSZltWYdCNSxv7YmTBmNWkSdAOy6zpbmirLw1x7bP_UegpENf3mUtX>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jul 2024 03:59:51 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/2] platform/x86: asus-wmi: add debug print in more key places
Date: Sat, 13 Jul 2024 19:59:39 +1200
Message-ID: <20240713075940.80073-2-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713075940.80073-1-luke@ljones.dev>
References: <20240713075940.80073-1-luke@ljones.dev>
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
index 799d928c7d3d..4c129881ce28 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -334,20 +334,29 @@ static int asus_wmi_evaluate_method3(u32 method_id,
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
@@ -377,20 +386,29 @@ static int asus_wmi_evaluate_method5(u32 method_id,
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
@@ -416,8 +434,13 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
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
 
@@ -453,8 +476,11 @@ static int asus_wmi_evaluate_method_buf(u32 method_id,
 
 	kfree(obj);
 
-	if (err)
+	if (err) {
+		pr_debug("%s, (0x%08x), arg 0x%08x failed: %d\n",
+			__func__, method_id, arg0, err);
 		return err;
+	}
 
 	return 0;
 }
@@ -542,6 +568,7 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 {
 	u32 retval;
 	int status = asus_wmi_get_devstate(asus, dev_id, &retval);
+	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
 
 	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
 }
@@ -3559,18 +3586,27 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 
 	err = fan_curve_check_present(asus, &asus->cpu_fan_curve_available,
 				      ASUS_WMI_DEVID_CPU_FAN_CURVE);
-	if (err)
+	if (err) {
+		pr_err("%s, checked 0x%08x, failed: %d\n",
+			__func__, ASUS_WMI_DEVID_CPU_FAN_CURVE, err);
 		return err;
+	}
 
 	err = fan_curve_check_present(asus, &asus->gpu_fan_curve_available,
 				      ASUS_WMI_DEVID_GPU_FAN_CURVE);
-	if (err)
+	if (err) {
+		pr_err("%s, checked 0x%08x, failed: %d\n",
+			__func__, ASUS_WMI_DEVID_GPU_FAN_CURVE, err);
 		return err;
+	}
 
 	err = fan_curve_check_present(asus, &asus->mid_fan_curve_available,
 				      ASUS_WMI_DEVID_MID_FAN_CURVE);
-	if (err)
+	if (err) {
+		pr_err("%s, checked 0x%08x, failed: %d\n",
+			__func__, ASUS_WMI_DEVID_MID_FAN_CURVE, err);
 		return err;
+	}
 
 	if (!asus->cpu_fan_curve_available
 		&& !asus->gpu_fan_curve_available
@@ -4398,8 +4434,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
2.45.2


