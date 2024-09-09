Return-Path: <linux-kernel+bounces-320994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B2971321
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB021C22416
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B4B1B3731;
	Mon,  9 Sep 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiEZRHtH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F6176251;
	Mon,  9 Sep 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873410; cv=none; b=h7pyi3TgU2PmVgTppsJlxXOBTbIkn+8/1zVYn+OoogqlcgYAM7hSte2EnLTLMRKcJqCXcXW+GowdCswWUbUOpARWW1IpF5qpLDweReETYbxvJjYHElYZtYhPRsy8/7GYxXqErs4G4cbIEv8NBE4en192xWgZyAEntI7QyeNsoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873410; c=relaxed/simple;
	bh=70ruTc1aOPJJxfTDI45qWnTyn5GOXRE+iQDpdlk/skk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXUYvwpLtOIjlmmqgqBobcJ8w4HJeIWzgSVz9BVoeF+IAt/qHxhE8vb89mRldXbOmNkMYGnW80ocCQUyYeyq++kzmQUuFZQQYpj4QmfW2d3aEqujAaoUnzkUETee/+T3TgRDDDROf/UwQSYXPUdup0RMzfODMq//yj0xpSJplPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiEZRHtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B414C4CEC5;
	Mon,  9 Sep 2024 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725873410;
	bh=70ruTc1aOPJJxfTDI45qWnTyn5GOXRE+iQDpdlk/skk=;
	h=From:To:Cc:Subject:Date:From;
	b=RiEZRHtHYKpnYlncrgCFQgkD7sxbtikbg5CsovFojcVLJ7YFEpiDeG8z576H3IwvT
	 nW8J0SjxQCnbOlkEWSRy15LFBFWj28PC8pef+vKfM3DxZWdkoTo5Fu5d/z4V4K/0nH
	 mWbEg+iHuZc8fihgiNWLAHu2V48Dkyl1T8rO97u6AWm8OE7/i5sOB4hNVYT9mg0AxR
	 dHF62EjuEqYDst0KrRXlVJffwQTDmXxQ9Uuf3zruHYjAoOyfPEGfY5h4Xi4ozecRDB
	 zXrmjFDf98EBJJRPlwlEYGJFEAHZ32BcgSoGcJ9hxMPreviJYerPQmF3WgsGKtvL1T
	 OQW9aCXtOVJhA==
From: Arnd Bergmann <arnd@kernel.org>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Xi Pardee <xi.pardee@linux.intel.com>,
	Rajvi Jingar <rajvi.jingar@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kane Chen <kane.chen@intel.com>,
	Marek Maslanka <mmaslanka@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86:intel/pmc: fix build regression with pmtimer turned off
Date: Mon,  9 Sep 2024 11:16:35 +0000
Message-Id: <20240909111644.248756-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The acpi_pmtmr_{un,}register_suspend_resume_callback() declarations
got added into an #ifdef section without an alternative inline
stub, which now causes a build failure:

drivers/platform/x86/intel/pmc/core.c: In function 'pmc_core_probe':
drivers/platform/x86/intel/pmc/core.c:1507:17: error: implicit declaration of function 'acpi_pmtmr_register_suspend_resume_callback' [-Wimplicit-function-declaration]
 1507 |                 acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/intel/pmc/core.c: In function 'pmc_core_remove':
drivers/platform/x86/intel/pmc/core.c:1523:17: error: implicit declaration of function 'acpi_pmtmr_unregister_suspend_resume_callback' [-Wimplicit-function-declaration]
 1523 |                 acpi_pmtmr_unregister_suspend_resume_callback();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Remove the unnecessary #ifdef and use IS_ENABLED() checks in the
respective callers.

Fixes: e774696b1f95 ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended")
Fixes: fe323dcb12fd ("clocksource: acpi_pm: Add external callback for suspend/resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/pmc/core.c |  6 ++++--
 include/linux/acpi_pmtmr.h            | 13 +------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 695804ca8de4..bbe90b1f56e2 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1503,7 +1503,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
 
 	map = primary_pmc->map;
-	if (map->acpi_pm_tmr_ctl_offset)
+	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
+	    map->acpi_pm_tmr_ctl_offset)
 		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
 							 pmcdev);
 
@@ -1519,7 +1520,8 @@ static void pmc_core_remove(struct platform_device *pdev)
 	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_reg_map *map = pmc->map;
 
-	if (map->acpi_pm_tmr_ctl_offset)
+	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
+	    map->acpi_pm_tmr_ctl_offset)
 		acpi_pmtmr_unregister_suspend_resume_callback();
 
 	pmc_core_dbgfs_unregister(pmcdev);
diff --git a/include/linux/acpi_pmtmr.h b/include/linux/acpi_pmtmr.h
index 0ded9220d379..0846f90ce179 100644
--- a/include/linux/acpi_pmtmr.h
+++ b/include/linux/acpi_pmtmr.h
@@ -13,14 +13,12 @@
 /* Overrun value */
 #define ACPI_PM_OVRRUN	(1<<24)
 
-#ifdef CONFIG_X86_PM_TIMER
-
 extern u32 acpi_pm_read_verified(void);
 extern u32 pmtmr_ioport;
 
 static inline u32 acpi_pm_read_early(void)
 {
-	if (!pmtmr_ioport)
+	if (!IS_ENABLED(CONFIG_X86_PM_TIMER) || !pmtmr_ioport)
 		return 0;
 	/* mask the output to 24 bits */
 	return acpi_pm_read_verified() & ACPI_PM_MASK;
@@ -39,14 +37,5 @@ void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool sus
  */
 void acpi_pmtmr_unregister_suspend_resume_callback(void);
 
-#else
-
-static inline u32 acpi_pm_read_early(void)
-{
-	return 0;
-}
-
-#endif
-
 #endif
 
-- 
2.39.2


