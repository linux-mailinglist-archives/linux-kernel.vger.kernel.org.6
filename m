Return-Path: <linux-kernel+bounces-307093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DB9647EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA75C1F22829
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762491B14E2;
	Thu, 29 Aug 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZCzSrVb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957E197A99
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941135; cv=none; b=g4sHy8chmraqXHw5cfSFumjS73Q7fiJ7AFa6uH9FGOLmbMp+UqVeMfTaAlwOfJpOCrAxLYjozDVk60XJE/VP0m1g4IdwkcCkuD1HkEQoKtYG4PQEJL6lQP+MfVaNIoKt90t0aBqeqnU7XFCSRfz5d4S/xalMrx6YisTaT4sufrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941135; c=relaxed/simple;
	bh=zJ+yRIWc0laMt+VA+WcNeC6inAbzeJDFegXsPKCx36w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6zW4nntEZE/U/v7JWbSf0HUVqgBs7alk2r6C9Jda1+9QMjegxwWK3wNBs/B/b3vHuCYUqLQcXDTL5q4djfHvfZtSt2SPb8h95dKKSKUfTbMTA8KFQfDv6gpwPyZGam1JKCc7SkEqM8JmVBlmGj2VgP4R4f+oz8T8TfU303gnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZCzSrVb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT8+L1vpUCD1XCsuz0jWN9YX0IbdjrEGcfF0kmNNelY=;
	b=ZZCzSrVby/u0diWZI6WwNaFOpiCXlEEuMFV83N+6fDHyTLrsr7SLJiDFf6/Od/WXaIZKrt
	8gyZRZe2sDr/9YstyyEKPCgz3Oh49Zvo1IJ1aSjkcRMrVImcRuEXDvaxuEgkOvAxBfyg5p
	3S5xVckTDlkkrXqVYWmxx2WG2zyKBCI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-jnrS4qlTPIi3q0DktchH7w-1; Thu, 29 Aug 2024 10:18:51 -0400
X-MC-Unique: jnrS4qlTPIi3q0DktchH7w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so7093685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941130; x=1725545930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT8+L1vpUCD1XCsuz0jWN9YX0IbdjrEGcfF0kmNNelY=;
        b=WT/Z0LOnY0C9wrqBLoXfIokDh0qNvX1e0X9FIyAaxtH1Ohga83HoDPqLZOAc5RLHMN
         UioynRIDZaTyVSOrXKBtHZxSKUTy9MSi3gFnPaLkwpUhqnNhulWbUKVmJ8wmbtzsrum0
         jFPIguIV4isyGHwcVaczO/XoOG78SvEgAKDoHDRRhzkHMkqR1ot9wTNwgTYsMZi/CgA3
         zaUP8frLZ94FmWhBRrjmtp5rhy01MkUO8aQPksn38lla0tAfo9liD9gFwGKKsCHpxRuF
         PvhGm92AYYhlRijcOASgSGznuMYh94zk4lUdzS6ZtuAWuKDDek6xxUbkUsmsnuJfdgaD
         OZlg==
X-Forwarded-Encrypted: i=1; AJvYcCVIwrBdMSXlOUCGewhBYHpeJF8iLRYsLtsW6nSIwevjz0huy9ipdaFtE5aKZy4q3Gu1xaZxlwIhrygJlcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyythXOSecqOwL1jsvcfv05Gxj0FW9DofTAN/XUjUH2A9OqxV7c
	Wmq2sw4fgq4+/dPK27D4FBN8CAzyt8tI9ONVePMzUr984NO7pigniEBMp356WPevpMewnAG5hft
	PZ1sDv+oNte5ccQJvkJpY8k74M6iai2Oo4o4f2NE3UpNVS/yt9CyPTN2tN9Ttew==
X-Received: by 2002:a05:600c:4444:b0:428:ea8e:b4a0 with SMTP id 5b1f17b1804b1-42bb02ee51amr21076585e9.14.1724941130180;
        Thu, 29 Aug 2024 07:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkTKSH/QTeIyV54cadvSe1hYdPiDL+tkcm56iHXiGVeo2pmvJLb7aXhRIrmTDGPReCWareA==
X-Received: by 2002:a05:600c:4444:b0:428:ea8e:b4a0 with SMTP id 5b1f17b1804b1-42bb02ee51amr21076255e9.14.1724941129588;
        Thu, 29 Aug 2024 07:18:49 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:48 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 1/7] PCI: Deprecate pcim_iounmap_regions()
Date: Thu, 29 Aug 2024 16:16:20 +0200
Message-ID: <20240829141844.39064-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Mark pcim_iomap_regions() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 8 ++++++--
 include/linux/pci.h  | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..5f6f889249b0 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -782,6 +782,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
@@ -1013,11 +1014,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
 /**
- * pcim_iounmap_regions - Unmap and release PCI BARs
+ * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to unmap and release
  *
  * Unmap and release regions specified by @mask.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pcim_iounmap_region() instead.
  */
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..9625d8a7b655 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2297,6 +2297,7 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.46.0


