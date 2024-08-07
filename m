Return-Path: <linux-kernel+bounces-277564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C394A2F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E93281032
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476E1D1738;
	Wed,  7 Aug 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbwXSc2m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7321C9DF0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019455; cv=none; b=JbpHGGp6AM4/NRjjAxnuA6Og+ViQHf6pWeD7xFcUmG+wnV3wqMy48x17CQWKpGUziSTV89eSigMnDCd4vndLR/29odWfWpPG6M0BkvZekaFPSaS+u/KDax00LVKFAOoVj1Owk3zoYcpFHLf0wKJnlUBCo2R3rWLha9LtT5AxgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019455; c=relaxed/simple;
	bh=PwYwdcFZJjXI/1ZBi07VVhiw7uh58Ga2zr6zHKgzONw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1l0tx2noCFuEGh5qjdiZzVssbwMIyFyTDjLgzcque9b6Za3qKuGHfqJ2vs3KHCXsJMHWWpNuZEWMcrkuoRcPDuFtQ5l+g7mueM7Qeqn64nNBSxVXZNVXNcA9ahsO9D9IOjUZ0AXqJSCsM/N3peY22fmpmI1BYPZSFYWXBrhdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbwXSc2m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723019453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVbzma6Ld8kQQE1ZL49LKh4hv2SyDx3pxf2xj02v3wI=;
	b=UbwXSc2mVbrkzLcMsltCZHaFo2kA+Pba2aobY4UjZblBLlRxXYY5VXLUJ7C0B4ze5/npAm
	MVxvx1ONNDRO7PhS/sr9XqQxqk9D6sxcw1BtkAtL/XOTfkTGOzZ9X911kyImDekUTu3NTS
	W3+mEziHDITtITlsDCKOMIhKRpQCciE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-HZ5Ujkc2MLunGUw2SwNFlQ-1; Wed, 07 Aug 2024 04:30:51 -0400
X-MC-Unique: HZ5Ujkc2MLunGUw2SwNFlQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef185db2b4so3536681fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019450; x=1723624250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVbzma6Ld8kQQE1ZL49LKh4hv2SyDx3pxf2xj02v3wI=;
        b=mZrdH43Pt+mVh3DwhzdQHedjomeqRBDyYdl2+u2/CAUoQXDhlQS2dTwrAmyZuop8ZP
         CxbNkOHPc6waQQHjh3dwNLJkmoq2OELaYpUdgH6RenKz9rAfMGxm4jPbXSnKk8O50o1v
         0cHRxqfe/TUoNqGyFQV/sVz6CIM0QWfFS616Z64pycFlhUx7RO9bu0OI6cS8aiw6oHEt
         be5wh265BylRu0LKg4DsHi7PtVaCnzx1+BdBe9PCFSnmn50DT526m8aWekTDqboiUKL1
         Wss3norRT6kUrTZ5/Pv2mIHy81p+mo52EWpOAXjzwYkwGcCDQ7Si4M1rBoz72ZKbtOHQ
         W4og==
X-Forwarded-Encrypted: i=1; AJvYcCVIdbYm/E17xCQ6wr5j97dp+BpF8WZS99qNJXg7pmi0nq72IymfCH85PXixv99miEMc2kLJwpydWvP5s2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6G6W4gZ5e6DtNuss5TJO/6lrr5YH4E+Sa8n9mMR+1JSpOZ8Vl
	pljCPt6LXRHlvgMrLgA/VtDk4/IeQR4pbImVDudAJSe7QMT5+RmexsNiaJ6fJCjlq/TCXaQGCj/
	LTCUppTC/t05oBcYaLaOnrlHXWtdPvSbfdMkIwpEixLKUGXoBnJLDUXRvA44QNA==
X-Received: by 2002:a2e:9bcb:0:b0:2ef:24a9:6aa4 with SMTP id 38308e7fff4ca-2f15a9f617emr66033671fa.0.1723019450105;
        Wed, 07 Aug 2024 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM3mk64vP4ZIUUqLKFHzIo7xNqsM+xJ9/DLlPYGzmqWK63piOdQggG6zFHh9ocfAw3S9zfvA==
X-Received: by 2002:a2e:9bcb:0:b0:2ef:24a9:6aa4 with SMTP id 38308e7fff4ca-2f15a9f617emr66033551fa.0.1723019449584;
        Wed, 07 Aug 2024 01:30:49 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580cb80sm18544835e9.45.2024.08.07.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:30:49 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 2/2] drm/ast: Request PCI BAR with devres
Date: Wed,  7 Aug 2024 10:30:20 +0200
Message-ID: <20240807083018.8734-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807083018.8734-2-pstanner@redhat.com>
References: <20240807083018.8734-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ast currently ioremaps two PCI BARs using pcim_iomap(). It does not
perform a request on the regions, however, which would make the driver a
bit more robust.

PCI now offers pcim_iomap_region(), a managed function which both
requests and ioremaps a BAR.

Replace pcim_iomap() with pcim_iomap_region().

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/ast/ast_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index aae019e79bda..1fadaadfbe39 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -287,9 +287,9 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
-	regs = pcim_iomap(pdev, 1, 0);
-	if (!regs)
-		return -EIO;
+	regs = pcim_iomap_region(pdev, 1, "ast");
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	if (pdev->revision >= 0x40) {
 		/*
@@ -311,9 +311,9 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		if (len < AST_IO_MM_LENGTH)
 			return -EIO;
-		ioregs = pcim_iomap(pdev, 2, 0);
-		if (!ioregs)
-			return -EIO;
+		ioregs = pcim_iomap_region(pdev, 2, "ast");
+		if (IS_ERR(ioregs))
+			return PTR_ERR(ioregs);
 	} else {
 		/*
 		 * Anything else is best effort.
-- 
2.45.2


