Return-Path: <linux-kernel+bounces-302630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C921960137
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CEB1C21F04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A4132132;
	Tue, 27 Aug 2024 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpJoNtBv"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB247A724
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738169; cv=none; b=eGNWoOZsFghstgm+rk4cg7XB/lsA/gRzjhkCxXaU+ULew2xSI6XIEjLh/bAPQzePFnzfIOZad4AQG/R5GmXiWsN9/8PKFxsFHejl7iIggXJ6VEfuH/NlRE+KISIFHGF50mFvLjs9Sh0CNyufxr8QgQnSluGAZXudFN3i0ReCejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738169; c=relaxed/simple;
	bh=IUj7d6MyyD/+ZasNZAvTYpfp+WFcWVsB4JMhTzqxF44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYQnQWe08SfGWO7NJ+KlGN/WWFZ2LkagloVq1WnwJi8FKg6G3U260mVc2aIG3RmBaLHX175EaVJ+LDJ5DY058kHTsEPh14engXAsMy7TreTYWbsi+49eX2X2uypOb0RFfV6Ty3g1uWenDL2Ef9++eeC8IVsk2vrpNz+A4w3x3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpJoNtBv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2777671a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724738167; x=1725342967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7++II4ZyoF0+E2oWFj7dUGQKtiYcKou/Mn0UWilD5ns=;
        b=gpJoNtBvMJRQRmscSr8YrxR6wL0WFlsheWuVj5mF8Qqeanyk7pVnXRZjCI615GAK34
         Ti39LPxeSDLAiI+jkGL647PkxZo0sjSMCgN2argRpJD8vMolb+RGs1mG5esTJjWXJwZJ
         Y+sjHWCAqUvPnU50vPyTJd6bwTFV7SbPPCNhA0xwaw4Q9+JKrj2ovIFNDfW4gpPeBgFt
         oCTkH9QlB+RIQF4/VuJa8WsoZWEKOUqVIwiosFFm4/eC9I3+G0c+8FhrM0wFdDxuqREn
         yNvCw4A/LqfwFfO+EnaYyWLB2CdkDTraRw5SEhg9O7MJgaXaljtZLQsU9KZ1zwZX35f2
         OeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724738167; x=1725342967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7++II4ZyoF0+E2oWFj7dUGQKtiYcKou/Mn0UWilD5ns=;
        b=s8C0fM9w0zmm2Nz4+Lrcb571q8gR+WUCuatA6nifwUK3XTU4E5Y1VcZgT87HEskcbK
         DC33baGt1K819T8J5CM4iy1FI/AkPkPTx5/gnO7M/bd1qnq9jTyif5b4FuL6brsHyT7B
         4CbDcT4G7NuQvSVfM7nDcjyoUk2e7ugVaeZa6cQjC7pX690q2eNVyJD1pv7gD2tVr7Os
         ARxfA/TNOk41YZkmvtFOZgk0KTrEw7zrODimQcFysqqar3ONbCQrePRlpn7gGgnUYlQP
         OrYjIMPRQYuEFb27Gbd0BY891H7WXUEIphFg1z3F06zVz8KxsfjCCb11S+NVFsCgwxn3
         AfJg==
X-Gm-Message-State: AOJu0YyqvULSfXTg5ulAXUZSYqPLAGyOI5HKKCfbZE9vCeQoGGA8IwUq
	NEpVl5SCEmdzKbH2ukQePY4nfj6rOHUZwJ5JaKMSGgB3WolaEJR/eyy5qWQEv9I=
X-Google-Smtp-Source: AGHT+IHwuLhY17cw7YN/6XClW4UKLX2849F/+Oz7y17YUrzjBBEpJgiHuEVGpp6vXEMRtZiUjR+p6Q==
X-Received: by 2002:a17:90b:1182:b0:2d3:c664:e253 with SMTP id 98e67ed59e1d1-2d82580d12dmr1950655a91.10.1724738167168;
        Mon, 26 Aug 2024 22:56:07 -0700 (PDT)
Received: from fedora.. ([122.180.189.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b1ac7dsm10989313a91.47.2024.08.26.22.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 22:56:06 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: added bound check to geoid
Date: Tue, 27 Aug 2024 11:25:55 +0530
Message-ID: <20240827055555.65371-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added bound check for geoid in probe function because geoid will
always be positive and less than VME_MAX_SLOTS

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c   | 7 +++++++
 drivers/staging/vme_user/vme_tsi148.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f29..d93a5d428ab9 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1059,6 +1059,13 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */
+	if ((geoid) && (geoid < 0 || geoid >= VME_MAX_SLOTS)) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = root_device_register("vme");
 	if (IS_ERR(vme_root))
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d81be8e4ceba..97323b5563e8 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2252,6 +2252,13 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
+	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */
+	if ((geoid) && (geoid < 0 || geoid >= VME_MAX_SLOTS)) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* If we want to support more than one of each bridge, we need to
 	 * dynamically generate this so we get one per device
 	 */
-- 
2.46.0


