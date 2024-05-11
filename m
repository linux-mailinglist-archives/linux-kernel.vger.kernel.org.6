Return-Path: <linux-kernel+bounces-176393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23A8C2F17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A98D281E77
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4CA21106;
	Sat, 11 May 2024 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="E4GawP8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4zgbjb9"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA62572;
	Sat, 11 May 2024 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395173; cv=none; b=NLs7B1aUKlxyZ7mf5P9dBfHoQ6pd56X2wDH25sW01TnSIGjKH6XpcyCKWjdDvqeMYu83R2k34CqvUwP3Cnpadxh4Y270SdWC52dDQ8J0iyCiGb8kTYLM4B1FiJ7/lkTwXo4ZMmyI3sdh9EfeUIQDscIQ+8NRSKLsSHZnmec1Lu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395173; c=relaxed/simple;
	bh=Xl8oG1vNP1R1K5IfgdCKZp5GZ4/mirRPRQXXutp+H/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBhATDiXeT2R5nGnstotsfBy+Tc8lGGtEW8tCadVw4+0bGpEHJJ/Vzkm21v6o7ztquAN2mWh+gdfAmA4ADN8v+Z8JCdn9CLg6n+iEsaRgfflEJnSmmaVQ11peesxAuNtyfA4tsxEvWlu2/rzut0qOYwVQ6mcOnttJFDZokpiOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=E4GawP8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4zgbjb9; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 007421C0007F;
	Fri, 10 May 2024 22:39:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 May 2024 22:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715395168; x=
	1715481568; bh=YsogiH7uJdKdsluepDZ+W6UmxveCzPT2QEioiEwES7U=; b=E
	4GawP8e3O2QTmUxJAxC6BlGshP3FyjjDMCuNV4BuqrKFtGwEoSVcY5bbAgUAXmcW
	k4H7QMyw2e2abEvXonvovfFfM8CGj4sqa2IP6hRyWtTi5+jk3cf6NNY3fbTlIb1Z
	Iklh7KyErjZL2HMHUitNe5Uuno5iwQSF9MEfZPEG2hSNc0cN367oCwOMq+75Zk0J
	44Zz2AEvt/Ncuw6J4ilVf7wS34oYeVpw0+oLF2kg7qt6pTVoEJRDsKBj0ZUOoxqv
	fdJqE+2jALlRV8r/FnhjybFGTK8fGiro6QsAbLAZiG52RgBR5iKgL19SY+kEypHu
	I9SECM5eBfP7jocg9/KIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715395168; x=
	1715481568; bh=YsogiH7uJdKdsluepDZ+W6UmxveCzPT2QEioiEwES7U=; b=j
	4zgbjb9Q2ggFvkdkWQxuKhG/R0z9ut2deU70rnk+3nScQgH2wkNqpKOa3z7zH9cX
	diDLaBL/O6/XyQnhjfWpEo0cES3bEr3vdngTHQ3Zt4niZDlSuqVc7bg5aRHhWVVK
	gDrvQ8XUuXA5bOq59LB8JxCcAzUnx0DQtPgDAb6d6vpVhtzLDyEU0w177KZqQxMQ
	Btin3fB2GB0CwcdDdgcPGQp087MdMQThkXvWopLaKWhKqiglWLe0cnGQfqavBwUQ
	RT+aLz54y+tOocZbSWXpvReizpOPOIASHBNK8pYFuA4ZwR2fTmwe2QHe9zdAyYDy
	pNtbmVitvKeZWitw3CiTw==
X-ME-Sender: <xms:YNo-ZlVX_7lknkt_YtJTAsVTNB65X27P4ifEPvXYDJxYaBvR1eAbEQ>
    <xme:YNo-ZlmpgBpfk13EOYYWxgOcljFb-XqTQs5ao9jZgebuNPXaAxzQoCG3r5OunQYhg
    S5DbbRdiPLZ1pksL7g>
X-ME-Received: <xmr:YNo-ZhZpWiQ2doI1-N6RbP7mq9NYhjsGNjSE-4CWYMcIqzArKHIeOa8rLhRKQFFWFeoIyz44p6E00KZQNxat0AM8ZT4_oghk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:YNo-ZoXuE-6KLWj2-o93qC6D2uyD-CIKqiwlh-PcI09YemyGeZh7Hg>
    <xmx:YNo-ZvnQp7vhYOJaskuI3oEZLunfq-euQHEIbn_hs3hrj3Cga9FQUA>
    <xmx:YNo-ZldMpsC9h9mOn0WeIvUxlj-D9W-nfU3P0h9zZfzrYfrfaCjPMA>
    <xmx:YNo-ZpE8NrSbFhVXYiV8dtsDJTSqTXTITqnv5QJ35bI8XdqmrbeB-g>
    <xmx:YNo-Zh0zUhaUt7wmXhDlhrFm--kjdY-7BJeNSvL3bwES4geH_jcj2h9y>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 22:39:27 -0400 (EDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v6 1/2] platform/x86: dell-smbios: Add helper for checking supported commands
Date: Fri, 10 May 2024 20:36:51 -0600
Message-ID: <20240511023726.7408-3-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add symbol to check if a specific class of smbios command is supported.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 drivers/platform/x86/dell/dell-smbios-base.c | 6 ++++++
 drivers/platform/x86/dell/dell-smbios.h      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index e61bfaf8b5c4..6ae09d7f76fb 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -350,6 +350,12 @@ void dell_laptop_call_notifier(unsigned long action, void *data)
 }
 EXPORT_SYMBOL_GPL(dell_laptop_call_notifier);
 
+bool dell_laptop_check_supported_cmds(u16 class)
+{
+	return da_supported_commands & (1 << class);
+}
+EXPORT_SYMBOL_GPL(dell_laptop_check_supported_cmds);
+
 static void __init parse_da_table(const struct dmi_header *dm)
 {
 	/* Final token is a terminator, so we don't want to copy it */
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index eb341bf000c6..63116671eada 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -73,6 +73,7 @@ enum dell_laptop_notifier_actions {
 int dell_laptop_register_notifier(struct notifier_block *nb);
 int dell_laptop_unregister_notifier(struct notifier_block *nb);
 void dell_laptop_call_notifier(unsigned long action, void *data);
+bool dell_laptop_check_supported_cmds(u16 class);
 
 /* for the supported backends */
 #ifdef CONFIG_DELL_SMBIOS_WMI
-- 
2.42.0


