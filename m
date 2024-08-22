Return-Path: <linux-kernel+bounces-297386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0217E95B76A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809D91F230E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2DB1CE70C;
	Thu, 22 Aug 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LX1cRsD6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546F1CDFC3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334499; cv=none; b=mTq5bLeV4vDhr0xUHVjPLvixw92iW5FepiPX2xP4aNWKnONNdu2N6BkhFTWNFMkkCf/tTy87OyGim8EswDeM2OtplN87lnxhdeCaSnptgdqACAuiemN+6k+jTDbQyjU7gxWnM59lbA+lgbu4rzFa7uSCmyJyu09wjVAMbI6Ze+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334499; c=relaxed/simple;
	bh=xzKTSbBUCxwnUpKs8six5ekb8eTkm5n7sI9qBsfTSxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIyJQs6gZnvW1SMarJrPrris1s63Pl2whHm1JNpUIIpZpQqPD4gFhVbEkkGSBqqcFgjXt+vk8KKLtKNBR6hJ3grhcSn6Nt/6L4OBA170kNwzQtls25tTNTbuB43FNKtvgFKKiYa7LeA5sLkekN1ALZiGgGsEC1rTIL3WNueS0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LX1cRsD6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stErXlsn4bG59ZiuP1S49NzWKfcbkIn79Ht3IKYskFI=;
	b=LX1cRsD6/Q6Vax7T1ODI1RnAIXS+w5tZla8sA1P9sgjqJGmHazVO0IraAP4XxtEBys8oGa
	V0R35Q57U62DQZXcOCqDcSvz0s7RaHHBHXp5s6TOoEYlRTiK6W612HbUICGfIrx1xNOm1e
	T3XlBuVqz8iG0XzxM8I50dynEiUbLis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-FlMkcikQNlO1CUCADcYY1Q-1; Thu, 22 Aug 2024 09:48:15 -0400
X-MC-Unique: FlMkcikQNlO1CUCADcYY1Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso6293335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334494; x=1724939294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stErXlsn4bG59ZiuP1S49NzWKfcbkIn79Ht3IKYskFI=;
        b=fflaruok/VQwjVk+8Rmkya7OMYjgQKVweRCpUSoQkNMH2IVIkYa8kLFsYgVzcvhzEM
         CMb4fHEC8ZZJ1/0YyFv7uYfTS1tNORKdqD9de4DMJQc3To5AIVEbrWRp8ucf6ThXu4s2
         6wYeQJkIM75n16zt6hwYL+GhD5wCzI9S5s9eRTPA4nflg5KsmGlCFuJ+WVYWzs8+2xG9
         cio/zf3oIeve5EdsprWa/MR0L8uuWu74L9tCYKx3vTH0i5ZwCoFU1DxKglKB6k9X0fuC
         mMviNOGzTFQn55gqIsIXDgSwjzxabarDi/YI36hkJD6CuHUuc6MmAmDPf4ub6OJmYu4v
         ACvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+AueWNyyEahG9PwT70WJ5ws2vnH7szwBZ18bz1HlZ6oPTu4qtzQFHDX6H7utyHiJ86/3UdIpPqiJp/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyosk8mdhs1Qq9vPefxYsVFn9fi4O7YOxQpXbBuj1Z1qTMhUgY1
	3sh9oNoznhQGqT74ki1BMKrHgDjDg1SpVN0hVtW8Sbqz7zprsiwi+RXopq9s7HcqEGqjku4NqU/
	b0JDvVhXuWHxK/Pyy4G9IHTTD/T1C0+60xqR3soyipCXYckSsWIIrSXwqfV6PrA==
X-Received: by 2002:a05:600c:470d:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-42abd23c42fmr42834165e9.20.1724334493998;
        Thu, 22 Aug 2024 06:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+ml6suAX3eG1pz2LPHUrAJqRTfncLpMSUbPA+Ci3dUa++3KF20e/68btOdPMgiZkBffw5eg==
X-Received: by 2002:a05:600c:470d:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-42abd23c42fmr42833985e9.20.1724334493539;
        Thu, 22 Aug 2024 06:48:13 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:11 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 9/9] PCI: Remove pcim_iounmap_regions()
Date: Thu, 22 Aug 2024 15:47:41 +0200
Message-ID: <20240822134744.44919-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822134744.44919-1-pstanner@redhat.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of pcim_iounmap_regions() have been removed by now.

Remove pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/pci/devres.c                          | 21 -------------------
 include/linux/pci.h                           |  1 -
 3 files changed, 23 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index ac9ee7441887..525f08694984 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -397,7 +397,6 @@ PCI
   pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
-  pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
   pcim_pin_device()		: keep PCI device enabled after release
   pcim_set_mwi()		: enable Memory-Write-Invalidate PCI transaction
 
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 4dbba385e6b4..022c0bb243ad 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1013,27 +1013,6 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 }
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
-/**
- * pcim_iounmap_regions - Unmap and release PCI BARs
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to unmap and release
- *
- * Unmap and release regions specified by @mask.
- */
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
-{
-	int i;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (!mask_contains_bar(mask, i))
-			continue;
-
-		pcim_iounmap_region(pdev, i);
-		pcim_remove_bar_from_legacy_table(pdev, i);
-	}
-}
-EXPORT_SYMBOL(pcim_iounmap_regions);
-
 /**
  * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9625d8a7b655..6c60f063c672 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2301,7 +2301,6 @@ void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
 
-- 
2.46.0


