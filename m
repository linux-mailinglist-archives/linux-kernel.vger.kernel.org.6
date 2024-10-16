Return-Path: <linux-kernel+bounces-367447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0C9A0286
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB911C263F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A51B652B;
	Wed, 16 Oct 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4XhgxCh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289F1B393A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063584; cv=none; b=F83mPCAeWv2t98KQQS671tU+nlf3pHLQcRrchk3kXVwSvfhzMdJgxu4ILyzJ3Eds3RiWZqb+H4118F/QWLKgrSbU5NDTDT2gDCNIconzGE45VW9tdPPfqaL7YfiXWAblNiDJoqwBdc/w0FfZ/PGF29vVJriBAHzwjontJvZnkMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063584; c=relaxed/simple;
	bh=C7myXz1PzgO5KntaMzSJdRvlacDd6/XrNcUeuxTsbuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2klpCyvIEsRjzHXUg7OdiJseZ/SmjrIjqnHgv47g/UQyLEEzUOkJqBIewN83K087Lgfd5Pom18N7rRfiwPL2rmd5ZIarP+cMOSTd0alfvgap8oWReXF0ehZPiTVI6VPprMHnPmzBMr3QZe97UmGP7Bu6HsjcbTMg7zMYqEU2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4XhgxCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729063581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
	b=i4XhgxChQav5iWKZaCyCTfUR+ZvdqMED3U/MiHbqijZWOhj3I1YKmEaFiB4woz4LIudidl
	oVvFRcHYUI6tPVQ2196I2RlwB29ZBch7pCPQTLUf0cp8A3+Dp2j+QZPNU/td3tBo0h0cjT
	6WuDaEqR+C+1kiYjwCDuv1vHtwgyPDo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-_ceVXFrQOmGDm6Q50hmhSw-1; Wed, 16 Oct 2024 03:26:20 -0400
X-MC-Unique: _ceVXFrQOmGDm6Q50hmhSw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso9724208276.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063580; x=1729668380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
        b=C4kAwAmHJXGaf4ytKjph0y+0aonKyEx84SDOBG/xijfXpZjW7nTvRjg4OXXbPs0dhE
         F8zoShBodyHP6kaIEHqaWd/nZKZBVn6Hm2kvXhNaj9OwQlv2wjUFZXUBRmpGSy8KJkKp
         DPHfaINXE8fJIu9m2NN3JU+pRjme36fYrM7MO53nIIvCNY9TbIuttcZ8M1YaVqJQMK21
         Mr57Oxo0OzC2/cHYG01mBUiKW6sS5lb0LHlnrYxJgx15nahy9gGNX5oe3u0AIK5X8WmD
         ySSey6Adg7bCyDeFRcrjMHukS3S1x+sz3IR2T0qmcndogGN+Bo/jLYB7bpgkm0eRJQ8L
         Bipw==
X-Forwarded-Encrypted: i=1; AJvYcCXZvYitp3f90T/YToZdc9xPZImmWT8YuR1LG3n3ol2dg8RAtiEs8aHG9E6wQ1UU/S9Rf3DAPI85dROh2zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAba+EC9q5NsIGrWkoMNE2pYoYfm0Y7E7Mn5Y7beE/FMkiMhSU
	6h+n9KX4WVZY8KZ/6Xk+3XYlKLALc+WgDsV4CIl0JecAMG0O+lbgLJergHHAHWageOAZq/81ERV
	5H/nNEhl/02Zx+Pe88hn3tSAvoOHOOSajkZTNITi6G7ND+sG+KnyyGRZd00jfHA==
X-Received: by 2002:a05:6902:2b92:b0:e25:fc6f:9cbf with SMTP id 3f1490d57ef6-e2919ffb24amr15378997276.52.1729063579898;
        Wed, 16 Oct 2024 00:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VnLtU01GEdrbqIU14wiCEwVYdDzFIuoPMbbYPcqCMCItsvNSf8e9UkD6khJT6N2aapdCgQ==
X-Received: by 2002:a05:6902:2b92:b0:e25:fc6f:9cbf with SMTP id 3f1490d57ef6-e2919ffb24amr15378990276.52.1729063579574;
        Wed, 16 Oct 2024 00:26:19 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm14645746d6.16.2024.10.16.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:26:19 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
Date: Wed, 16 Oct 2024 09:25:54 +0200
Message-ID: <20241016072553.8891-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..c8b74980dbd1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.46.1


