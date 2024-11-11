Return-Path: <linux-kernel+bounces-403765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A472F9C3A93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DF32829EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764F1714BC;
	Mon, 11 Nov 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ycs8JVcP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5487158535
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316235; cv=none; b=kElCkjbU809Fa1vkqmci64VVWzptTzgLtVFWZcW1Y7SHRN4QrUZJwVGPnHCTLcheo8fhWfQLKTLl1MRb8mqdBAVWZF0jgrACabwA8JaZ6yx2Km6jsbHg3a5hXQy8L32nQT6XOBmRDVEzSj6a4dE5+Fwd1wkMju2Ru2SYnySfcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316235; c=relaxed/simple;
	bh=+l/zsWsq52qKCE3S0cgeDR/mooKURFiNVPd0zNkl844=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEszwucMipLrvGOPUXwAKyLNUU5laDKMaJ3cbeaYNu0k/Y0LkGKO27EPpi8S7FCSzKoftHLtuU4YdGRQ4joB1wpixquwepc5JJWNZitj4B2wsLyNlqIMfUEPPb17G7NdxnZMeL5mK3wnjOVjQaQdzjLWI5imoo/rvDTBKC/5foY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ycs8JVcP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731316232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IlkBwIYLXEfoDb6mBwfLXq8ed8F/Z1AKH2ippr194IY=;
	b=Ycs8JVcPmQXeq9DJQp4PkwT6qQr2F/MpE3cuDtxfheuBCc1rhkwuZVsQj7i9olXKxV/MRC
	C29DgT710Kct6grEog/QD/phhzYd/L02PtQcUq2vejDg8NLJcUbJ6iUjAPfPZ2lgTQTcvU
	5SwmGL1rB0M8iJf19AbbrU6Uy5pBPxI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-AdEPPxe8PWmhj-pQfDQ8sQ-1; Mon, 11 Nov 2024 04:10:30 -0500
X-MC-Unique: AdEPPxe8PWmhj-pQfDQ8sQ-1
X-Mimecast-MFC-AGG-ID: AdEPPxe8PWmhj-pQfDQ8sQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso331243966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731316228; x=1731921028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlkBwIYLXEfoDb6mBwfLXq8ed8F/Z1AKH2ippr194IY=;
        b=kNhhcEpgM/wPjwzli8/gNpRM1bwycYRNwTu6cEJFOprX0/i3+0L2mTTxVxizkM2YTb
         DocHu/lcIJVHdNlHgdl4B9aXDEDa0PJAAQB5uXMZ5BfsvuiNJJwkkfrKEixjmIA0Aok5
         wcW6x2ZU55YYWZkUgPZsp/1FFeGdFjjYM+JMsT1AL/MMa2s8izlbgOjgQtsVBuqSNz83
         ttwpgK4oSsinY616GWl8QeNaJBo7Kng2z1mUIWp5AtnKsaaoRXA3R3tbSvEd6Zg/cN1g
         n0JsvTTpC6lVYraoFDuqzCkC9pcsbjLUZFlvy3H8WLlrR1zsHTnJ8Pioey8RjNtgDx3T
         PRRA==
X-Forwarded-Encrypted: i=1; AJvYcCU54hihlUf7xYbNauoxb9324K2Nv7N686VkTLmbapGOqgi0rcHcoObd+hT1POR3yIecF/i2nusO20His0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ/Ojn+UkmUpSjq/kgO2rAMm91mpdN0FU50S8KbcEBJh4CncKO
	NEoAIsqibEP1fky16jTOmvQ/ilm5gb6iNWEpzb3qHuBuUba3QbDKNCp9vNVh4MceuZBrjdPmjKm
	775oxYTTINI/hRjl2Q/hDWbsmdI7Rn/xw0ZrCp/6Hi5aW+3DQZG+hCAy+fTl3Wf86k+TNXA==
X-Received: by 2002:a17:906:2b10:b0:a9f:4f7:f064 with SMTP id a640c23a62f3a-a9f04f816a1mr533605066b.3.1731316228608;
        Mon, 11 Nov 2024 01:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfptwuQySnMp9mLjTjygS0OEF2Vq3dFxQupPHmBODj6rGIER/wZkM2N4C/u8BMIH2XVy65mw==
X-Received: by 2002:a17:906:2b10:b0:a9f:4f7:f064 with SMTP id a640c23a62f3a-a9f04f816a1mr533602466b.3.1731316228231;
        Mon, 11 Nov 2024 01:10:28 -0800 (PST)
Received: from eisenberg.fritz.box (200116b82d9ab900a46c5a062bbe27a3.dip.versatel-1u1.de. [2001:16b8:2d9a:b900:a46c:5a06:2bbe:27a3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc50ccsm579203366b.100.2024.11.11.01.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:10:27 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2] pwm: Replace deprecated PCI functions
Date: Mon, 11 Nov 2024 10:09:45 +0100
Message-ID: <20241111090944.11293-2-pstanner@redhat.com>
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
Changes in v2:
  - Use PTR_ERR() instead of PTR_ERR_OR_ZERO(). (Uwe)
  - Say in error print that either request or ioremap failed. (Me)
---
 drivers/pwm/pwm-dwc.c      | 14 +++++---------
 drivers/pwm/pwm-lpss-pci.c |  9 +++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index fb3eadf6fbc4..b6c16139ce4a 100644
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
+	if (IS_ERR(ddata->io_base))
+		return dev_err_probe(dev, PTR_ERR(ddata->io_base),
+				     "Failed to request / iomap PCI BAR\n");
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


