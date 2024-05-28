Return-Path: <linux-kernel+bounces-191611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CF8D1171
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170B71C2184D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F80EEC5;
	Tue, 28 May 2024 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="oeqW5vCh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="po79+vK6"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFA944F;
	Tue, 28 May 2024 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860201; cv=none; b=Z+3K2GjxcQjgSavSW6uop0epO6rzepDBrifn+wFxvhl5kDNV2R9R3twy+j6+Q9uduRpYWyqdFAmOjVtPLDkfD8lSl29OArMM0iarUGRNUY4pdBZgljgH+0CJt7ND+nw7437eUcr2iU7YgZX7b/KjNj8mgki9Vtzmhfo55GpKXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860201; c=relaxed/simple;
	bh=vQyiNakurHrTDQqN8eQP1YeGSIHDA/FV2l9h+0yojcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3D9xNjL+uK9MYI8TIj+m0fdVD0NznC0fA/872yiBZ4Tq31h+MF5gBHyNcljZAhD0VeKOWLRHXYHDB3h7a0IpvTw4xWPqWqkL9/nwZf5JbqZ/fw4etxmnIGfE7jNsbKeNWCCGTqN78VVCRdgCHUAZVeFhyvyy5TP+DqiFbIQTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=oeqW5vCh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=po79+vK6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3041F138013D;
	Mon, 27 May 2024 21:36:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 27 May 2024 21:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860199; x=
	1716946599; bh=gcXTqMW4+klc8Afnn2worXjcdcJuH4da6dNmIEEsW4A=; b=o
	eqW5vCh8eBUcyMpseOVdkGD2moSC0uUy63QzscFkXkuK0UvYGFA0+AzjMtd4QRI4
	Ttx4gh6dk1L0Eo9XY/i9CV6NhVNj2X0SsSEeeGs+7knZjQR5SFRKsjWemKi4DTLS
	mdcR15vhW+cNQPkHVCZAPyY+zkksh4EXzxjSZ8bBuZmfot3Ict3Iyfn7fFJ14keQ
	g3ILQG2NNouipH1hvE73Rx9/AxexhwFW9bCmGXTW9aPfoPxTZhoVKXeozB8/Shw1
	y3Y2MWCMIJ8Nbd5buuDBhr7lRRrrOHOyD1LUgsjtev8M6dmaYRc3DHf3G0RpJUsB
	QllJQJwOqQwBkMa/E3mww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860199; x=
	1716946599; bh=gcXTqMW4+klc8Afnn2worXjcdcJuH4da6dNmIEEsW4A=; b=p
	o79+vK68GRoU2qOYorVf8a+pXO/Uo+GPhL7zHTuAmGVW8qO+gppXJypqdskW7PSH
	54OO96GjunBZ5qiWln2Sjmbei3FmVq8wNQJvb8RgYN+tkCqz/tOsJRwF0y26I5bc
	tjIiRlF3ZlKcs+cLFMd54CJohFZSE1RnixtNInJQ7xzxUyrpFDP6bNng2dXoqObW
	pf49Buno0Gsj3ne2HlXjFMytZ/e6cqo+pM/bKNrGAcACkIvuHWYJnQrbg3gWSnw3
	lk9mJBESEu7Dmh8WrCC+PXrNhjnal0JYiI+zpvEOERK2bdLA8AwZMO/eYKN7GZXE
	AQriEdHB1zqKoabrB5Etw==
X-ME-Sender: <xms:JjVVZqOzwO1mbVSX_uC8GDJwuTCRlL8fuYBDEycDcMDSGgvFgJhFvQ>
    <xme:JjVVZo8Kq5i-SA5bfSNkGfu0ia7yTdHiYcTg0_sZ-8NioQki55puWbu4tnyWUcOsp
    TcKEBN4_dXbukjCaZI>
X-ME-Received: <xmr:JjVVZhRRhGHWOONoKsQ6Su9A6oOZDrreDbwtm1GBBNBO1qkwITpFV4dBY0Yo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:JzVVZqvpgcHhK4HDnvjQNX1mRafo1m7moTqNRTavEKRpyNXGD8QaUg>
    <xmx:JzVVZifkJwwYZg1ooiwQsFKXtzX-asdZXjG5Oee3RlZXIBPqFxuknQ>
    <xmx:JzVVZu3K0aqVCgre1LFz8mmk1PXnrL9Wi3EFDWjFABN13UlrH2klWw>
    <xmx:JzVVZm_mvUIdiHzawmQMwS18b8wdkHse-KdVex8m9-P7jI1-KcI0SQ>
    <xmx:JzVVZvEauBb6OBL8wdBzSKaZQyqU5NdgXFxP7Wctwr4W8qkYCnlXmdrY>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:36 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/9] platform/x86: asus-wmi: add debug print in more key places
Date: Tue, 28 May 2024 13:36:18 +1200
Message-ID: <20240528013626.14066-2-luke@ljones.dev>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528013626.14066-1-luke@ljones.dev>
References: <20240528013626.14066-1-luke@ljones.dev>
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
index a58df18a70ad..adc841abbb2a 100644
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
2.45.1


