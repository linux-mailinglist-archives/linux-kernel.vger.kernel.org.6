Return-Path: <linux-kernel+bounces-182673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE48C8E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515E11C216B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F41141999;
	Fri, 17 May 2024 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="sKNqM3jz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQvW2YoC"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7175140E2E;
	Fri, 17 May 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715985848; cv=none; b=UHkLNl4bixn+E6QUHi34SFCeEAaAEG0swdHUn7fU7qBx2M4HcAwEAcRqMvgq4h6qQ+H0sydduZ71U0EFrSblw//1FzS/GP77/6iq2n519Q3i0FyHCwINy9nv5CH07brl2v41NMhk9iOohtI3D7OejeVqcsKdeScKZ2EcxV3omI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715985848; c=relaxed/simple;
	bh=loCrIO0PewTruFGNsjXG5fP1bL8deD1rba3DtzoRRUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwYVj8re+TWhP45npuhM9wuC9gzeHTUADIiZM5iBr6EE8wzDxDSluKPZn70IBRvJNkrtLLFLaPeseabrSSJkmOL92k5iaGAlwoa7L7rrvBXsquNfp+7NIZkCJM+Yw+T5btvLmLlFJ4W/liHjE+LzA79BfUgn0B954z1O/pmvGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=sKNqM3jz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQvW2YoC; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 78CDB1C000AE;
	Fri, 17 May 2024 18:44:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 18:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1715985844; x=
	1716072244; bh=YkNH9UmdI00+6TF86KxexTrZ0A1ZnZI2cRgBC770hMU=; b=s
	KNqM3jz3h1jDIlbJLOu3qwiiPb772onuZcx/ItMTcuAPp2Byr/OcrJxQym7lg74C
	FMuLpm+g4HFS2JHDzNEkz6yFnr3MU5aVdCqsVH9/7RLCR5bUfX7Ih9sKzYE9UOer
	T+Y97FdNXXMvkVrEylgcbjgE//k856zGOWGVTiQOmtbOqRImb/LIVELH3RXw4TP6
	B3fruKgRMaWzftTilK4MzLc/X4RVhTeUXaR2El2LBpXVjCy6MfyApAOLcawAYhYO
	GflnRZBnk55/6hoBRSyPAwc9tnKjJWOf95dkX/Q6HX36RhL3M6Mh1WCKEwwDl4ax
	volF7Sg2hldF2DKUFx/jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715985844; x=
	1716072244; bh=YkNH9UmdI00+6TF86KxexTrZ0A1ZnZI2cRgBC770hMU=; b=d
	QvW2YoCrK9eJLl57PbjiWR/z0SbskAR2jcKJV7Yw02UxXyrwgd+OGunxKQrvOugQ
	Z4JT4f/agUMK7uzmD1pPNb8kIr8w70YD/how97LvUlatzv0OhMlgeW/q58LWeMp5
	BWn2bPWRtG1RMZBVOyDEUWS2Gqm7A8u22vB6OyW8msj8nVWy3Ce6t0tR3u+0YYVc
	ZLJ5lLPGbNtI7BFRtsOPg/msa5ir4MFX+lU6gbdInmdNk+aQCGyTseJ/1LJe7OwK
	Cz3oxyp0UJGBY1PpK5XCIkVP2QlyDJZgkSExlVRI4/zxnjlM83c3bQhCiZHImbyl
	z2KIv7e7OZDFfZ+SLeo6A==
X-ME-Sender: <xms:s91HZkzuuvcqFKJTKBACQpR3DAnA-18F6JhFOJ4-6ppOCOhBHAeTwg>
    <xme:s91HZoTatUrIRMAo6aGEyMU363kbu0w7yzHmDvTB_Hpeys0iQwq_U0EMk1-i2SwPZ
    Sb2bjdYuYtXkPdwx0k>
X-ME-Received: <xmr:s91HZmX60BJcOThRxVzu05HIvMHk5BnGK6bBtP-y3NSV-sHXSjP7BcAnzKpUhvrNGdEWSQHcEbg2vq7B3SpJ6N5Z6HRrzQl->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:s91HZijH8HN1xu3hfAsHGBYkzT6zsyLJULyBycLe84BVPpTD7_jreQ>
    <xmx:s91HZmCAljXgfuz3eOpiIpvl6gSEHqTKPD1ELVCPGXGR3s_VbFwfgA>
    <xmx:s91HZjKF0SHTLIgwnsGENB678tIFnv7xxLqCEf8xNguABInogrHeTg>
    <xmx:s91HZtAzljx_LhQTkjl-TmuNPl1azg7LJ603aTcUY9228XMHb8zkFA>
    <xmx:tN1HZgxpHVOtksRVj05o1kksV7ZZokMipHSyQLHj2oKG5OsjucsXIMXm>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:44:03 -0400 (EDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v7 1/3] platform/x86: dell-smbios: Add helper for checking supported class
Date: Fri, 17 May 2024 16:42:34 -0600
Message-ID: <20240517224323.10045-2-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240517224323.10045-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240517224323.10045-1-lsanche@lyndeno.ca>
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


