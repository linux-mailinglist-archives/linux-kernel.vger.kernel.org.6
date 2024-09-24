Return-Path: <linux-kernel+bounces-336782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCD9840C0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56AD1C2266F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BF1514F6;
	Tue, 24 Sep 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI3LPbyr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360814F10F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167274; cv=none; b=gK2eenYdmzT22T9gjWoQ58E8SDm74WBIRn3mjDt9EmaiupHncv9JoIjh60/1xPjlWLsecQaHrOdhm3HMtU7BEutrYLYN9Fsu9eL3+rHUe/wef1pUut/u+AK3p5i0c64wKpUUbw3G10bRLohke4zNSIj+IpBlab+98UCZxQx7C9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167274; c=relaxed/simple;
	bh=4ltDlNqrDGR27ksNZnCiug3GSOdf6tIVfNnAqB0cnUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7OYtyon3+OysMf4c/QX8MfweNI5+YtV4RiP3+F+I7Qw4e0k9KCtNIfVfZWA5OZfD5ni6KnEXXOxM9sh1w5h1ws700C5Du70nd3iD0s54Pd6Ukl3JN3srDzpa8uifhGTy7/VkKlx0AUEK3sAnpWPGH+QPhDUt6HeY18g4/H7Wwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI3LPbyr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727167272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZZ5Fx0mtQJO1gSt0hL1ASxmxmOaX7Z23At8t63rE11I=;
	b=NI3LPbyrBt3DJssTazl+voPhvpX4ybynCQ407CPgLUxCUnsKLalxR4xyYt7LLoxzX6rgEs
	p7mGwiWxlfPfu8+2yPv4OjwbMsmapbIxRER1ycUP8lLZqaOoyMmIoNqc/OlWhrN43umZ3g
	8ehSuwOIvzdIKkK0H1OQfHiAsqOEeSY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-jd0ALN4kN9mUpnib-dy5cg-1; Tue, 24 Sep 2024 04:41:10 -0400
X-MC-Unique: jd0ALN4kN9mUpnib-dy5cg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8bso33363115e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727167269; x=1727772069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZ5Fx0mtQJO1gSt0hL1ASxmxmOaX7Z23At8t63rE11I=;
        b=DQBwN8HIF9G1IMtma/FQcbcUONbjiFN4NdW2OR9awqbbFH9GP+RNmh+wWRiyOKW+D4
         GtqIj5q8+Ab1kBMUU7d1AsKG+AVlc+ZvBPYINb9423gV7nw7yJ1yJJNnAI2JVDgiAoX4
         9bKGYpBH0XhDY1/Oxma6EnUAR7eTcV1E6LoaFqxJglWG1hk+RxXJbkLv8D5A4Vk2Jy+F
         giZVlFmpuh6CS32UBJUaa5lc+M4qhO+PAjvAYyyXhNT5xnECEdQey6n7T2jOMORnpzkY
         h1kmMRfazwnGOqlL2u5MX7oCYLh+2BvxJGK7yGjftkzUUKpb8SdeTslKtxlXJBtG7PvZ
         yL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaA1d6kKly0jP+5FTbuRn11zuiHhNxf3enUsjclRcEpArKzN0BRBkJnjL0YxJvPnzMtngwOsXU27ZK/9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1M7pUpfzjtEyadA+G2M01vJvWUaVkIa2F+1TKdaFiTiZvM9ZR
	go2BB18/1dVLo1XbXxOoEkGIwmvGaCgtqFbZ5oUcYLmJXDbsDbo8e+KJxTKCJzMNZHBn4nP2QNV
	yetf2k9bY86wutZZxixRuvxLWgKwd/s7If7p8moFMIgxiw9+UPUYAdIV9L/nWqw==
X-Received: by 2002:a5d:434b:0:b0:374:b6f4:d8d1 with SMTP id ffacd0b85a97d-37a4226543amr6838956f8f.13.1727167269374;
        Tue, 24 Sep 2024 01:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg2yg6W81UBOHvRHLFJDRDvodAV4WI9aSY+BW2GEqIIxZ8SG9S5WI+REDe8rZ3VTtvckwPAQ==
X-Received: by 2002:a5d:434b:0:b0:374:b6f4:d8d1 with SMTP id ffacd0b85a97d-37a4226543amr6838936f8f.13.1727167268887;
        Tue, 24 Sep 2024 01:41:08 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f96f6sm958087f8f.87.2024.09.24.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 01:41:08 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] platform/x86:intel/pmc: fix IS_ENABLED() check
Date: Tue, 24 Sep 2024 10:40:56 +0200
Message-ID: <20240924084056.48447-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with
pmtimer turned off") accidentally slips in some CONFIG_CONFIG_X86_PM_TIMER
(note the duplicated CONFIG prefix) in the IS_ENABLED() check.

Fortunately, ./scripts/checkkconfigsymbols.py notices this accident. Fix up
the IS_ENABLED() check with the intended config name.

Fixes: d7a87891e2f5 ("platform/x86:intel/pmc: fix build regression with pmtimer turned off")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/platform/x86/intel/pmc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 0431a599ba26..4387b5103701 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1546,7 +1546,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 			       pmc_core_adjust_slp_s0_step(primary_pmc, 1));
 
 	map = primary_pmc->map;
-	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
+	if (IS_ENABLED(CONFIG_X86_PM_TIMER) &&
 	    map->acpi_pm_tmr_ctl_offset)
 		acpi_pmtmr_register_suspend_resume_callback(pmc_core_acpi_pm_timer_suspend_resume,
 							 pmcdev);
@@ -1563,7 +1563,7 @@ static void pmc_core_remove(struct platform_device *pdev)
 	const struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_reg_map *map = pmc->map;
 
-	if (IS_ENABLED(CONFIG_CONFIG_X86_PM_TIMER) &&
+	if (IS_ENABLED(CONFIG_X86_PM_TIMER) &&
 	    map->acpi_pm_tmr_ctl_offset)
 		acpi_pmtmr_unregister_suspend_resume_callback();
 
-- 
2.46.1


