Return-Path: <linux-kernel+bounces-302929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CDB960525
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039E8283621
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C21993B4;
	Tue, 27 Aug 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsk400PI"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11A198E92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749820; cv=none; b=aM999SI3k0D0Hod7uD1DAPekb1KtzWQEFKHM5zrL9Jol3yBPPnNCaFMxEKyEDwqtxyQ4tHIb8hNMCGmXhj8Pd+HoamCdxb35mm2KuvK6mdSJmIN2EZfLiLXX07T47hHWgouDYRRRwyx43uDZ2MuT3Hm4YZfiXO2Is9WtFSAviyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749820; c=relaxed/simple;
	bh=SjJOIJDonqyCbGBVsptkveUfW+eSL22SDCSdNNhBrzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dINvtX2XI3OYE4UEV1Z3WaXRO+cYiMenZ+Pc7oseoRxh5WCRdUhvcNmlMCZHKxHRvv5q0+hjG6sYGXLNS3ByZtBhuqH2OHnQq/d1XfgHoM/OUHK+YZlIi69AAkDpHz58IIP/Oz7NoBCJPURcVTdMmSuSao/3MiK4msn2YdTbUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsk400PI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3676510b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749818; x=1725354618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpgI7qvi8/v8UE8AR/QkH1xctnOGEtIqR82DIL0PGgY=;
        b=dsk400PIsGMwUV30/mExwupziy7B5Nrl4rxbktfttneMsCK+3QJMiA7Xyt+J7rEHDf
         piKDpL+CRZzPBvptOnjzWQJpee0WOMyrR/fOxVyIa6JvEHat//uICRn6jZKHhqcKemub
         mHDN8JGpEsp97Yr73u0m/VrYdbOJmRFBvJAI+Lm/4U4xKZisVFpAZfDwyVjD2laRLO1U
         CS2SiFomoSBx92qma9K+h/EJ3jjTvb3AMyvOak5CDKPJSQRa4sAhjSDhto4Ih3I3BVCu
         WMOKhEzviwvreJAzTU1OSx1AIehgIeWTORf7lyNLVs0ZGWyAGZvS9Bm1JYnZWZJNIL28
         ht4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749818; x=1725354618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpgI7qvi8/v8UE8AR/QkH1xctnOGEtIqR82DIL0PGgY=;
        b=N9+5Fy8b8mH3Raja4OW5VFdGzPx2Pgw81k0PkP27FZ2RAP5OFnecWZFBK3srYJYmno
         AkYiCjtH+cD0NeoP8KVBHhixT7DY4imcE+FkY1ksARxM5UcmtGRbqn5QZwpiyxz9IyKX
         3aYm3uT8xulPhEptNlpS2bkcQ4gEH1mPZxTfaWeGz7q1OnfiYF6nGHZ+NktAx7mlkMvT
         /mBpzeOfVpqXRF8mCJfIRB4VqTsI86zBnyALr+9LpQzeHAeI3AlO65q9aFBEpMCE7HoM
         N7JfA0QRHmo7BuZGaSR8r/dwLXTEb+85E4JdV4VLvLXiUHd/gjI0HS6jQVsciB9LPSim
         gASQ==
X-Gm-Message-State: AOJu0Ywg8wzFKvUDmnXjowb3coH8dhZLjT4H8H+fv+RseKtFf6vPkIqz
	gvr4maiiqc5jY9SFxtJn8dwZ17VSCULhPEJOGMnBTNBsgpPJaBhG
X-Google-Smtp-Source: AGHT+IEp4F23A8FqnAiZiVhKzZdRj7Hw+WbU+hcF+rxcWDfP9CmhJ8mQv3vTlx26C7YOKtzlm4iQtA==
X-Received: by 2002:a05:6a20:c709:b0:1c6:fbc8:670d with SMTP id adf61e73a8af0-1cc89ee58f0mr14191085637.43.1724749818030;
        Tue, 27 Aug 2024 02:10:18 -0700 (PDT)
Received: from fedora.. ([122.180.189.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434333e61sm8195275b3a.192.2024.08.27.02.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:10:17 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: added bound check to geoid
Date: Tue, 27 Aug 2024 14:39:55 +0530
Message-ID: <20240827090955.49339-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added bound check for geoid in probe function because geoid will
always be positive and less than VME_MAX_SLOT

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c   | 7 +++++++
 drivers/staging/vme_user/vme_tsi148.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f29..d8f4ba29da0e 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1059,6 +1059,13 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = root_device_register("vme");
 	if (IS_ERR(vme_root))
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d81be8e4ceba..9ec981cd2009 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2252,6 +2252,13 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
+	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		dev_err(&pdev->dev, "VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* If we want to support more than one of each bridge, we need to
 	 * dynamically generate this so we get one per device
 	 */
-- 
2.46.0


