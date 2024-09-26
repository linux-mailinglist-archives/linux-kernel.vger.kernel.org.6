Return-Path: <linux-kernel+bounces-340278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C789870CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97D3280E65
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258631AD5E6;
	Thu, 26 Sep 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="vFyRzKzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvHp1GPf"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08101AD40E;
	Thu, 26 Sep 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344460; cv=none; b=Mm47TOkEArRREm2teQtEFtk3fD/wpaT0o+shtfcHWhGIMOKcHImCmEf5k99xvHvFO7x9IMBfp6Y4jCnHFsCAfPRDoUjmrOzdlE5TLiE0MJEqMTQncw7RoYvvddpnDBJe/jrcd9wAXM5LKZM3VuVp91jGZdBYj0Zkrov4ezfy1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344460; c=relaxed/simple;
	bh=G7aw/NqYcnc/D1+SAoG//bSgoeFNLtDlCLzjVu0B7Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZWwPdXEJtwtPAVYXHMb1C7y2+PxYPtcX4Bon6YgFLsRIpq2cJt1URLOAyixWT6qcVBsvwZY6hlPxzXdPvp6JaN7SVxOjchJtKPYl5eH/m1QpWiznofwXNrC8ubt2TD98GdYb2vFUpewhpsYO1kIXkx2qYPVbZTm73ewRcB4U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=vFyRzKzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvHp1GPf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ED99F13805F7;
	Thu, 26 Sep 2024 05:54:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Sep 2024 05:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1727344457; x=
	1727430857; bh=cez1vd1E6Fgprar10HoRDPuiMNPnzWbbx/FRrRyMs9M=; b=v
	FyRzKzgYjM6BMH6ROK11CwtBpvwfZVcHK2lGSRHAlhgUJay9VVvK9O7g53XDPKxJ
	1LfTpiPMp4UJxBdVKvH5KT0I8MdX+sRM/JERgJ0IK8+j7P8UtxNEWSf/FEMGWqtv
	7g1l1LgJZ8Tu+sOhfCw9TyZIXZxD0pKlzEH+wJQiDwPWOY+c7WTQ+eN1JHI18FAn
	FhVzdc0JFd0YLn29u5cwX8AMZfCidAbHjJbyGTutivqO0O/h1PuWg/iP/Ykpyifo
	+bw08QLoQEuAU0bH/4+1btKRqyc1m2DWu7UX+MAun4niIjHPCOS8TV+PlmozLlid
	oDTnB7M4sBaBLpcOJMEAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727344457; x=
	1727430857; bh=cez1vd1E6Fgprar10HoRDPuiMNPnzWbbx/FRrRyMs9M=; b=O
	vHp1GPfB2d/0jRz/SPlaiREPL877cTMqJ4ROreiJLL9VTJzpZvbYNDIysAnxiiXA
	fH+5NEi302EWe6xCQaq+2Ke5scpcuiDMRS+m8xl+Ge5IY55MS/dIpfKPmzstxhT3
	RdPY6obq+y6JPGAjrvCzEwL4Hfi4lWa/NgvjPLJiTcfUtrYYAkhiKZVBGe3guZBC
	tYYjN8YmGSNDGb4wuW6KzFSrSm7tyDbt4XvPZfdaTN+7EIh8ITBZPV2rxmLop01X
	8Y34668CsdNp29BzLlyXrZZwF1itG4ahVvCkh2OGLZvc7wbMZoazYlsq87BCpAM5
	UYBVYn6ui4v4hfIABeWbw==
X-ME-Sender: <xms:SS_1ZmxUaSwEIw5JlCXyqwlZCxMZvlLAPVLxW7l_hb37mgloGZUMWQ>
    <xme:SS_1ZiQWOE5mAOuCJOiB0_nBHRLgeplBZIxkH8xljJpn3mEVovIe4RWDJRHFM1Fkm
    OS3luikfHJeH_cLoIU>
X-ME-Received: <xmr:SS_1ZoUdVkoqfIjaX7Ktr2qK9B8PilERQFzFesMFpgkdEwkhzoO6a1TM_zAFog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgv
    shdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfe
    dugfetudeuheetjefhuefggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonh
    gvshdruggvvhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtph
    htthhopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkvges
    lhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:SS_1Zsh7r9YFWLcityr6V8DFO8565MQQiVY9B5KBK1OGbMwcG7ppyQ>
    <xmx:SS_1ZoAokdr1kk1UFK9LC8QdjVs2b_At8RBioFn6ajAuR-kh6hGoMw>
    <xmx:SS_1ZtLaF1EHE4q_CMfKMVbaK0MVRtyzAakcfSpTAcPgRVsDi7Hbuw>
    <xmx:SS_1ZvBo9j0y_j2Zpeel1LIRAVdAmA-FeeNUwtHdgRd7K9YA948xmA>
    <xmx:SS_1Zq2sxIXc7A6vCyiNN-0sc3CpfnvkGl3-Yf2o_mA6HAh7qy2dRbf8>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 05:54:14 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	superm1@kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/3] platfom/x86: asus-wmi: cleanup after Ally quirk reverts
Date: Thu, 26 Sep 2024 21:53:44 +1200
Message-ID: <20240926095344.1291013-4-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240926095344.1291013-1-luke@ljones.dev>
References: <20240926095344.1291013-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup some leftover code after reverting:
- 7e7a5dee49732ed01a3a17c9a3edf027fb9457fe
- e0894ff038d86f30614ec16ec26dacb88c8d2bd4

This is part of some hacks that are no-longer required when users have
updated their MCU firmware to the latest version:
- Ally 1: v319
- Ally X: v313

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 27b9fa2c29ae..2c4094004549 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -274,9 +274,6 @@ struct asus_wmi {
 	u32 tablet_switch_dev_id;
 	bool tablet_switch_inverted;
 
-	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
-	bool ally_mcu_usb_switch;
-
 	enum fan_type fan_type;
 	enum fan_type gpu_fan_type;
 	enum fan_type mid_fan_type;
@@ -4773,8 +4770,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
-- 
2.46.1


