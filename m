Return-Path: <linux-kernel+bounces-194535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA98D3DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1161C228A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CE187322;
	Wed, 29 May 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="TdDPe68r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knny4Wk1"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60518733B;
	Wed, 29 May 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004961; cv=none; b=Vk/UxdoS1yiUZ2g8IlV/ut+3yTl3oXDspMuQF2w2nLrio+6zqsNKN79dUyaXByVpG6T5bcyTp3Z7Q/WLBzU82kKaSHB0qFGa1orQ8UxXgNCGQT2DA2nfaohVUzYDcPjKbMr0Sap9JMDaaC7a+nSsXe9GrekukkXBdy46Z5DNqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004961; c=relaxed/simple;
	bh=loCrIO0PewTruFGNsjXG5fP1bL8deD1rba3DtzoRRUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg3tc8wY4pfrHHP8T9nCEnlZixcFOWiisfPVdX+19s7+zNdJ50mE84904x63jxAnGFXTtxYRT2tPWzJNulT8jW1A8/3auJDIfaWjCLI+Fm6zWbfMrSM/F0yUlb7eb41B5+q1v6csgOK7hpPu49KAtIcZ7jokPmmy+loEYYHBjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=TdDPe68r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knny4Wk1; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 210F518000C8;
	Wed, 29 May 2024 13:49:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 13:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717004957; x=
	1717091357; bh=YkNH9UmdI00+6TF86KxexTrZ0A1ZnZI2cRgBC770hMU=; b=T
	dDPe68rycKGkqzRIXKJfId6gp4MVdLGJaGtnslobqhN8XrCf+9QS5VWrWs1dAMyZ
	xK8RbM1HXPGcg0SorXAG7xiYudlzN+aq+FedKCzNsv41bEu8XTUiVmD8OzstFucM
	uCBNleV5M67l8xKWCbIoCCs9LZ14TtKMtkC3NwIcvprpihqmNoWUXRzLYqnK3IEi
	xlfb/a5qFBf5Z3uZ+sIySukAHEX3thRDytiDpFyRSy8w3UPjylr3a9/RTx3b1sD4
	GJ6Y6JJW+txL7c5NV6qPgH1V8IxiHagNiESLbVhGRWujEtIiTP3XsD8Wj6I3gfC9
	j8a+gOQh5qhDp5bctNlOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717004957; x=
	1717091357; bh=YkNH9UmdI00+6TF86KxexTrZ0A1ZnZI2cRgBC770hMU=; b=k
	nny4Wk1Zc8jruxWqcb02mVqQcVhmBdKRjOBXWlgV2AU0dc60uaFTDALuCfwyf/kb
	88WTQhydMOfoIPTnxMkfA3oMkkenDcHIc1Tg0v+cRYsqX0n1YflvkszXjOMyu/zj
	jeRTvkn3ZWDxJMdo22s30c4egc4CsVKepaEGxilIcsina3cRuVOhBxa2lLF33uNb
	MW66nRIlIUz2vG4ORHfLZ85K9ERH0VLsl3Vet5+1tatxJjn0QKB507uj2it4wnaY
	p6Vo1XA8dhNbidAsD3Y6IBvZATU4v7yqscG27ytUrXIlUdmMPquBQfdLH7iZYk7Y
	COYE+dK/CLT425p/0x6VA==
X-ME-Sender: <xms:nWpXZuVlTWJSrH8tKrEdl4-HGaJk7UyAOAs5o4Wx73d_cGgIMF8Mnw>
    <xme:nWpXZqk8kjEfyJ5F8Mb5KPOUtR5KZAidj5Zt0Rht1iM_5GaxwANM5pT2dKBNgLCIW
    90Lg61WoqB8w5hXYw0>
X-ME-Received: <xmr:nWpXZiYC8O6LKidOcGKI388CMFpQefA6hSCMaKpd6ymZeb8bN3cQVhOZF45aTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeer
    tdertddtnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslh
    ihnhguvghnohdrtggrqeenucggtffrrghtthgvrhhnpeelhfeiffektdeludfgtefggeef
    hefhtefhhfffueevhfdtkedvieekheeljeeiteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:nWpXZlV6CpLV8Ly2WMfHx0AWwRSvx1nT78Y-rObrjD1LoxY4oYSh8g>
    <xmx:nWpXZok4_lDGCp4tPqZ01ymaWnoOXqghawJlxHSisJCiFKPCTuXu8Q>
    <xmx:nWpXZqfEO1DXEVb9lTMgQy0hXRqHuKLZztDMu4MrSvj644DQou_WDg>
    <xmx:nWpXZqFWsmo-MSudh78Adxy3e5QzTu_mrn9BZBcLd0VxFBG5UCAk3g>
    <xmx:nWpXZvooeaBmG6p7CKZW7PiiKpEC4vuwi4Fsv28CaE-OdSxMQ0RmiQom>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 13:49:17 -0400 (EDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v8 1/3] platform/x86: dell-smbios: Add helper for checking supported class
Date: Wed, 29 May 2024 11:47:44 -0600
Message-ID: <20240529174843.13226-2-lsanche@lyndeno.ca>
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

Add helper that returns true if smbios command class is supported.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 9 +++++++++
 drivers/platform/x86/dell/dell-smbios.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index e61bfaf8b5c4..fbdd12a7cb8d 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -350,6 +350,15 @@ void dell_laptop_call_notifier(unsigned long action, void *data)
 }
 EXPORT_SYMBOL_GPL(dell_laptop_call_notifier);
 
+bool dell_smbios_class_is_supported(u16 class)
+{
+	/* Classes over 30 always unsupported */
+	if (class > 30)
+		return false;
+	return da_supported_commands & (1 << class);
+}
+EXPORT_SYMBOL_GPL(dell_smbios_class_is_supported);
+
 static void __init parse_da_table(const struct dmi_header *dm)
 {
 	/* Final token is a terminator, so we don't want to copy it */
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index eb341bf000c6..756c354b1eef 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -73,6 +73,7 @@ enum dell_laptop_notifier_actions {
 int dell_laptop_register_notifier(struct notifier_block *nb);
 int dell_laptop_unregister_notifier(struct notifier_block *nb);
 void dell_laptop_call_notifier(unsigned long action, void *data);
+bool dell_smbios_class_is_supported(u16 class);
 
 /* for the supported backends */
 #ifdef CONFIG_DELL_SMBIOS_WMI
-- 
2.42.0


