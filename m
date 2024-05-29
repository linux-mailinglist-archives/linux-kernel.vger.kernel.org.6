Return-Path: <linux-kernel+bounces-194537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E03A8D3DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAC41F25919
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B8184115;
	Wed, 29 May 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="ifrZJg/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJt1aqFp"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE731A38C9;
	Wed, 29 May 2024 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004977; cv=none; b=oxZ44vqlBHLXS23ZFfVGBm9nsFcLlwBZlg66hPF4FaM/E11E8ntYCp3g7gi1XJjgBJdq7/+Q1bahWxV9NMpOcAjJeUuwVIpQg6vA8cBJm+fb/JGZYjoOCz6doBgbRSQ5ePm7Z8jOfWP2u9DItkmqhkUS8kCDcRDqNEU2ZtVf4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004977; c=relaxed/simple;
	bh=HWrrVsIWO8Y/vDkkDrw8BNTFmPPWbA2OH5R7wP7hxmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLBooHKRXRR3Hrw/WQfluD5wPb7rDwXP80cdgi9g59KklpVk2XE8H6Q8vjOc5KIweMSm/VcAu1hX8xhf2s0dVAUU6mCyHAb61gXXfNaxFerPzSJNgukNAyUzCyHhQ92vb0bsHqMVmrIxxZ+UbgdZZIxk4bV2M2wvI54IUYWS4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=ifrZJg/i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJt1aqFp; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 00CCF1C0008E;
	Wed, 29 May 2024 13:49:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 May 2024 13:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717004973; x=
	1717091373; bh=ophfuI0pldy6rb1ZeywejXaBasnIE+4VwXup8tD4W3A=; b=i
	frZJg/iyCDfTlqq602aQ+grPmzMPKXYz4FaDfMNWf8IhmR5/06RP3klARaZ9JubH
	B5hB7oT84Q91LmFGk9n8NCnhBNMur24t/Bey+F4nS09Erk3H3GhuwGc7ssD4RElE
	kCTCFch/2VAwaZAmK8Wj7Xwb+1iIDVu9ieNOJBEznqvZg/9Y10/KIp0JyIg3X404
	kkDYXEOFvIegV6p4PkHKWZ1G+Hx6jwMPEXEfxgKVOHNnSml6zp30Yyr6yYOVZpBU
	Idp2NqJpNor5M42aKWl//W+PQAfh8N/E20U772nu62FByOZ2n/0MxrHxGrMMgo+G
	DmZkDJ1+t5Z3SPwxjP1NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717004973; x=
	1717091373; bh=ophfuI0pldy6rb1ZeywejXaBasnIE+4VwXup8tD4W3A=; b=h
	Jt1aqFpyWyKWVetiu1xxBJvv9qYlcXqoMsrHFOervIGTK0tptFb53KNgD2wsr9JU
	BNHhrAJ7hxCuBhqGNFcFYw10PEXm9/4Fw9ZcH5bHHHrp7RgFWhdtTLVeq9dWV6FC
	u41+G+Glk3NiaNaYcE+2F1i8thI67hMJi6lebr4yARYgMrLQYb4GfQpPQ0in3Owm
	Uv+Vj9GxT2JKWOgA6reiyc41jWywSNqzLi3vneulrQ3LA7LC+ziTXjgN5guZu8/n
	qntjEbD8aeF4gIY5kUMtsc7yydCKP5RvT4MW494NxeSNYNZiwGY0Lmapobeb7CFM
	ZT9zvUnpJgNUS6vtrqMlg==
X-ME-Sender: <xms:rWpXZquhrAWHftGnY4tj6NVZSDcna2wEQirL4NVVVembBybWiczrbQ>
    <xme:rWpXZveTWh9ZBxtJdItbJcEHa0DEEEgP1OfV8JcfLnwPe0XQndezKng7rxOVPp6pn
    _BgFhQqMANE309SB6M>
X-ME-Received: <xmr:rWpXZlxClUvFGpqXgUPz1zHOdZz9OX9ywjjK1ejeLtvYlqssncBm95Jdwttbkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeer
    tdertddtnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslh
    ihnhguvghnohdrtggrqeenucggtffrrghtthgvrhhnpeelhfeiffektdeludfgtefggeef
    hefhtefhhfffueevhfdtkedvieekheeljeeiteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:rWpXZlNV34EiLfYT3pOhpdE6Xe-RNRk28x94wA3_rlWXl20TS-gAPg>
    <xmx:rWpXZq-qh9E6FhgJSyiixtsFynLOskhysr3RSEl5psXspUF8TNe7kw>
    <xmx:rWpXZtWCV7bUwH39cdIsT1RkpBnakDlg3aBkNJwLZsPZ3mWqn-W8ug>
    <xmx:rWpXZjekxwdtNw3tSvduzR34MJnRYn6gBLrElkKn0VF6nauScH6hdQ>
    <xmx:rWpXZjjRMwzL4VxffkaG9iYcxf89rc8bDBCvEfVz_GOzsNpbYDCidzfF>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 13:49:32 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	hdegoede@redhat.com,
	Yijun.Shen@dell.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v8 2/3] platform/x86: dell-smbios: Move request functions for reuse
Date: Wed, 29 May 2024 11:47:45 -0600
Message-ID: <20240529174843.13226-3-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240529174843.13226-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240529174843.13226-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the dell_send_request and dell_fill_request symbols into smbios-base
so that they can be used in multiple modules.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 drivers/platform/x86/dell/dell-laptop.c      | 23 ------------------
 drivers/platform/x86/dell/dell-smbios-base.c | 25 ++++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h      |  5 ++++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..6552dfe491c6 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -353,29 +353,6 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
 	{ }
 };
 
-static void dell_fill_request(struct calling_interface_buffer *buffer,
-			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
-{
-	memset(buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer->input[0] = arg0;
-	buffer->input[1] = arg1;
-	buffer->input[2] = arg2;
-	buffer->input[3] = arg3;
-}
-
-static int dell_send_request(struct calling_interface_buffer *buffer,
-			     u16 class, u16 select)
-{
-	int ret;
-
-	buffer->cmd_class = class;
-	buffer->cmd_select = select;
-	ret = dell_smbios_call(buffer);
-	if (ret != 0)
-		return ret;
-	return dell_smbios_error(buffer->output[0]);
-}
-
 /*
  * Derived from information in smbios-wireless-ctl:
  *
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index fbdd12a7cb8d..515c454acfe6 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -314,6 +314,31 @@ int dell_smbios_call(struct calling_interface_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(dell_smbios_call);
 
+void dell_fill_request(struct calling_interface_buffer *buffer,
+			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
+{
+	memset(buffer, 0, sizeof(struct calling_interface_buffer));
+	buffer->input[0] = arg0;
+	buffer->input[1] = arg1;
+	buffer->input[2] = arg2;
+	buffer->input[3] = arg3;
+}
+EXPORT_SYMBOL_GPL(dell_fill_request);
+
+int dell_send_request(struct calling_interface_buffer *buffer,
+			     u16 class, u16 select)
+{
+	int ret;
+
+	buffer->cmd_class = class;
+	buffer->cmd_select = select;
+	ret = dell_smbios_call(buffer);
+	if (ret != 0)
+		return ret;
+	return dell_smbios_error(buffer->output[0]);
+}
+EXPORT_SYMBOL_GPL(dell_send_request);
+
 struct calling_interface_token *dell_smbios_find_token(int tokenid)
 {
 	int i;
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index 756c354b1eef..1d6463cca12a 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -64,6 +64,11 @@ int dell_smbios_call_filter(struct device *d,
 	struct calling_interface_buffer *buffer);
 int dell_smbios_call(struct calling_interface_buffer *buffer);
 
+void dell_fill_request(struct calling_interface_buffer *buffer,
+			       u32 arg0, u32 arg1, u32 arg2, u32 arg3);
+int dell_send_request(struct calling_interface_buffer *buffer,
+			     u16 class, u16 select);
+
 struct calling_interface_token *dell_smbios_find_token(int tokenid);
 
 enum dell_laptop_notifier_actions {
-- 
2.42.0


