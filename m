Return-Path: <linux-kernel+bounces-396184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1F9BC917
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FCBB21B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E11D041B;
	Tue,  5 Nov 2024 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQbwDawb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FA70837
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798845; cv=none; b=cIstGRD4JYJxNqjw6HI7Jo6o9c/vqJ68bzxp/O7Yz0+DL7uB1cpZErCvBs1z2Jg8fXmLEhPzulh37x1oCOYsNNCLr57Mvy/edeOEIa22norY9XnJC0ouuM1fQ4UA9lQCHXeO6h0Jlsy5/hR9NTk6T0OwDzezRdd05W/ooBh42Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798845; c=relaxed/simple;
	bh=HuHzf+MqhJGpURxtX9qNPh+hM10o/G7WSixEaE9uEys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cT0VmXXzYBMcfimwkmPdvIxkuwCsM2fcZMcdOXIjopELP156C62ydEWge1CvYSEldKVhS5TJOfkn1EfHUk/e4Z5q1nJybkhbFGXTtkkqgVElbsxjRGayb8UnjEKRw3GE9SctsWTSipWm/W55pqFoiMKJQePxk8fMlFs97ta3wLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQbwDawb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730798842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K3diC4LcG5d/+GbrQGIZW0Sx7qNZLaP/PHesTT7qPXI=;
	b=ZQbwDawbYXflIK1abYFre5SvTZDsQxTGEHHEUMvAb6zCF10ven4ufzpSYIFN6h2a5/Ljun
	Y2aqyc/LgN/iFZI27/vd2MvpFXbu194wNnw8MbqVK1LeCcb7BnorTuK3pIsd6nOncXzlCJ
	jjUoVfKmYShp1CLRWR22dqBxpaCwHzo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-MnjIJWUxMOuW_wSp3GG-lw-1; Tue, 05 Nov 2024 04:27:21 -0500
X-MC-Unique: MnjIJWUxMOuW_wSp3GG-lw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so2645401f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798839; x=1731403639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3diC4LcG5d/+GbrQGIZW0Sx7qNZLaP/PHesTT7qPXI=;
        b=dycSSjpM2t7o6YfdoYYVEpSgsdk5MtJUmV6X3KC3WW8mOQEENtPeE0kcxZMOaz9wPq
         KCG0yrL6g/D0vqC1uv9KHn5UgTpkKwwoEhvu4kkeVrgMVYG+xOregJzDgg0XGnWpc5yN
         KPL0tWvkNV7WxNyU7AkIPB7RwyHYJZ8fF9mmEcFTzcwHyiVrgvvQ0+Mfnu3750ZEVqoA
         WVxSh0aAzuE6fuwxaq6xqAf4nJMCIOq1Mmy4ZertiN1xkl8LC5bpspsp/V18lfnQYs/y
         Csm4lSQrCO2i6LEkW0JJoT3PHwy8UbfGNPFJBsvDfXMueZsn9vskVkUwmJquFKs9KH7S
         heCA==
X-Forwarded-Encrypted: i=1; AJvYcCV+/z+2ZBya8in7N4ZTDmvSde/sLuFClWKfO61yaS0LfUa9dPFckRWNSOKEwmJyZ/1yrvRbjwEc6NCNylw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlXDtSP1w3GB0CfDvNJJNZYY6kMHK9pDLuMvry94vPU7cCFZc
	vXnIqjyVdWcBgPAeHjMxwbMJ5ZsB3yLKlB/fmI3rsSaMQYKTVj0vWiaeJzfi50v/1MwFSlI6fWY
	iOnWyi/KzLs0raw5w4K+kZLm/O6l2dCPBgsLkRIlzYA3FmHYTvnQ1HHRA0iJOb912w7QVtw==
X-Received: by 2002:a5d:64c5:0:b0:37d:5429:9004 with SMTP id ffacd0b85a97d-381c7a3a52amr9948972f8f.3.1730798839493;
        Tue, 05 Nov 2024 01:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd0D0YfbnU3NzZsDpew5RZ831pQ7qFlOc9vb73OqtmymlL7yjzae5dufSS8ZhcRxOhmi2/iQ==
X-Received: by 2002:a5d:64c5:0:b0:37d:5429:9004 with SMTP id ffacd0b85a97d-381c7a3a52amr9948964f8f.3.1730798839092;
        Tue, 05 Nov 2024 01:27:19 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d7e0fsm15393636f8f.47.2024.11.05.01.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:27:18 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] pwm: Replace deprecated PCI functions
Date: Tue,  5 Nov 2024 10:26:42 +0100
Message-ID: <20241105092641.49541-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()").

Replace these functions with pcim_iomap_region().

Additionally, pass the actual driver names to pcim_iomap_region()
instead of the previous pci_name(), since the 'name' parameter should
always reflect which driver owns a region.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pwm/pwm-dwc.c      | 14 +++++---------
 drivers/pwm/pwm-lpss-pci.c |  9 +++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index fb3eadf6fbc4..9101a89447d6 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -66,20 +66,16 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	pci_set_master(pci);
 
-	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");
-
 	info = (const struct dwc_pwm_info *)id->driver_data;
 	ddata = devm_kzalloc(dev, struct_size(ddata, chips, info->nr), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
-	/*
-	 * No need to check for pcim_iomap_table() failure,
-	 * pcim_iomap_regions() already does it for us.
-	 */
-	ddata->io_base = pcim_iomap_table(pci)[0];
+	ddata->io_base = pcim_iomap_region(pci, 0, "pwm-dwc");
+	ret = PTR_ERR_OR_ZERO(ddata->io_base);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR\n");
+
 	ddata->info = info;
 
 	for (idx = 0; idx < ddata->info->nr; idx++) {
diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index f7ece2809e6b..823f570afb80 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -18,6 +18,7 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
 	const struct pwm_lpss_boardinfo *info;
+	void __iomem *io_base;
 	struct pwm_chip *chip;
 	int err;
 
@@ -25,12 +26,12 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 	if (err < 0)
 		return err;
 
-	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-	if (err)
-		return err;
+	io_base = pcim_iomap_region(pdev, 0, "pwm-lpss");
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	chip = devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
+	chip = devm_pwm_lpss_probe(&pdev->dev, io_base, info);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
-- 
2.47.0


