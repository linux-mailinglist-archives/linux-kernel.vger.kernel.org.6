Return-Path: <linux-kernel+bounces-340277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705999870CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B51C24D29
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675171AC45E;
	Thu, 26 Sep 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="sxw4I04C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hK93oYAc"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC051AD3E0;
	Thu, 26 Sep 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344456; cv=none; b=WRAJ7ooNWxV74s5XLWwSqzWG3J7P37wej4bobideFEQ7+QOiOUR1Eh015X2FwVOnrqDC6wuawC9OSChgREx0i/Af8tRbE6MoXwlyWvYc9UGOekAoUEHCFYUHMu1HO3GbQkPiFrkxrxEukITpAU+8TnjJg/7lQj1VNGQBOQ/PeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344456; c=relaxed/simple;
	bh=K4r3ZHtDdVwxu0KYK9+ld+RhGfv+PjFdyOJ73N7Os7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx392KUcP/2YGB1Nqhub1x5kPG3GyCbvYVb67TFmG/MFjlot1fOXgxngPmzlZcho3C/CD/OyEAAVrHnRUokvz+D7aSGCL5Wox21iOVDqVcTKIxnHypgFartxKr3ixjzRXG1GeSM4MOiT0S1MBx8R2UC62E8tc8k/gphX1HJh7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=sxw4I04C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hK93oYAc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 377D513805EC;
	Thu, 26 Sep 2024 05:54:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 05:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1727344454; x=
	1727430854; bh=ZFx6bHZZmYPBZHXbu8ROAgHZRPYt7Cvx5swag6tKpNE=; b=s
	xw4I04CCyhpEqfFhsiEIaoYX2ghpajEM2GHJUOwTHrEvvSyyaqYBhWutvX1RwOvZ
	g7I+cGonCRWvJ6gSDiEXguB4ZEgT4bc+BEQv3ymMEW9sIGLZW+oqj3DRgqy0Yi8v
	3kZ1D45+rFjSJuBdBQLNKx6Jwp3ePxDNH2LoIZl3wEWbnR8iJeBoRhqHCNpPXqZ1
	Q2VO5P4S1dbmef7O/v/kBibJV8ro04NjepVHg2u6Bfg2c6mwEBOHoPXBz3TkSTsl
	op0P+2wkR8Ukl0bj06Z2D+w6jjmUnT3KlvVb9U1WqPibBGsFusSBmZWpaKhm5CM9
	QImumXVLBbjUqh6DgySqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727344454; x=
	1727430854; bh=ZFx6bHZZmYPBZHXbu8ROAgHZRPYt7Cvx5swag6tKpNE=; b=h
	K93oYAc9j6QhJ1Nb3QUOdXENs7FYhvuEpLY9+OQaPPgVIYNWdxDjeDJkHmq7M2HQ
	in12cxDnMjmUQPCxzlag0P0X6h1BStRZs+EhRClhLWRkxjADDhSD8bXVJ3QsaBLc
	kd4oFSuorj3JAV63YMKmH2rY50fMD/c7l+6gLexG9l78fOFAaktW6u26C04JVb1P
	9ZPR/6SVgEF4AbhUScJonX5AR1/uz5ewMwlHBiIiBAgBdLNVAYp5TowEy15BxbfY
	4zqnV/pTstYo1v3VgQD5g/mm6PsnzvmhzxMEgzc80M80+LU7A3TaFfkM0QuJfVYM
	tol27EkLM0o2ocVUBCrSQ==
X-ME-Sender: <xms:RS_1Zl2TdHhan0BuRZpriyFSqEi5ShUdnTJqsx7h5POwwjUTXDD_mA>
    <xme:RS_1ZsFous3PF2bkpgZOMbR_5BCaazcaQaJNbW-AhwRvvzfW5V0eLM37_1itG6o_c
    401BzbwEgQ0K5z8idg>
X-ME-Received: <xmr:RS_1Zl5YyPmfvBSkyNpGNWRPr83VyXd6ZuzBW1riohRfeyM3rJUftwyMa9v0qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgvdduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:RS_1Zi2APZllnxqL47iWM5bUcQKtbPGVeAexdr4T2xq0Xic8CkoJUA>
    <xmx:Ri_1ZoHFF-wGO6TNbKk0-AsK7bMaLKLno-1dSAoLUVqx84Zjg3UaKg>
    <xmx:Ri_1Zj-aY1P6tGuKqsLL0IQs-pQYnrxJpSCr_DMm641VHEF6sOB7sg>
    <xmx:Ri_1ZlnYrkQVaGJb1O1aLMO9wuR6fOOxqxz36spM2P2oX--3fZyleg>
    <xmx:Ri_1Zt6JUdCO9gHJ9qMrTdA46sJ40Hz3UoQIuxrbHi1PCsmW-81VIJwL>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 05:54:10 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	superm1@kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/3] Revert "platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend"
Date: Thu, 26 Sep 2024 21:53:43 +1200
Message-ID: <20240926095344.1291013-3-luke@ljones.dev>
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

This reverts commit e0894ff038d86f30614ec16ec26dacb88c8d2bd4.

This is part of some hacks that are no-longer required when users have
updated their MCU firmware to the latest version:
- Ally 1: v319
- Ally X: v313

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 40 ---------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 8daefd9a0d94..27b9fa2c29ae 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -16,7 +16,6 @@
 #include <linux/acpi.h>
 #include <linux/backlight.h>
 #include <linux/debugfs.h>
-#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/fb.h>
 #include <linux/hwmon.h>
@@ -4962,43 +4961,6 @@ static int asus_hotk_resume(struct device *device)
 		asus_wmi_fnlock_update(asus);
 
 	asus_wmi_tablet_mode_get_state(asus);
-
-	return 0;
-}
-
-static int asus_hotk_resume_early(struct device *device)
-{
-	struct asus_wmi *asus = dev_get_drvdata(device);
-
-	if (asus->ally_mcu_usb_switch) {
-		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
-			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
-		else
-			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-	}
-	return 0;
-}
-
-static int asus_hotk_prepare(struct device *device)
-{
-	struct asus_wmi *asus = dev_get_drvdata(device);
-	int result, err;
-
-	if (asus->ally_mcu_usb_switch) {
-		/* When powersave is enabled it causes many issues with resume of USB hub */
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
-		if (result == 1) {
-			dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
-			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
-			if (err || result != 1)
-				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
-		}
-		/* sleep required to ensure USB0 is disabled before sleep continues */
-		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
-			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
-		else
-			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-	}
 	return 0;
 }
 
@@ -5046,8 +5008,6 @@ static const struct dev_pm_ops asus_pm_ops = {
 	.thaw = asus_hotk_thaw,
 	.restore = asus_hotk_restore,
 	.resume = asus_hotk_resume,
-	.resume_early = asus_hotk_resume_early,
-	.prepare = asus_hotk_prepare,
 };
 
 /* Registration ***************************************************************/
-- 
2.46.1


