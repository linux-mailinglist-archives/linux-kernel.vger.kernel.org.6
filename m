Return-Path: <linux-kernel+bounces-307094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA79647F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940311F252F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFE1AE84C;
	Thu, 29 Aug 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL38qi4c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742001B1435
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941137; cv=none; b=YlFeAPkRG4tGwO0nXEU6I2P4Xs0pRR2Lw1ssm3mC0WSZ1iVQdpsSqnLrOq0B6ZEVdM8Tq0zoLlkwqJdi+bIH9b3pKSJOhDMpS/55oatHxbyMdtfnuvyeWA+m+Bb/MhLFQqsBO55P9wXHhR8P9vGa44XOUDOJ+GH8Zk/hMC32Jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941137; c=relaxed/simple;
	bh=V4KRcC8BfWc5Sti/Fdc73KUa8QY4uocvnp5UyVnLmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhOxOzgRVUkfwS/aXQo8patUTtQVTsTTt/UnCWIbtsQwfTlSIo82w/6lWv86ppghBUzwdOsshZ0xpY3i37P6NH/dJlcLhm48PDR0eC+YethakDPZOdZbi4p1+qkrb9zvtg0bjJoHQLe2MToNGgF3uMm2NtYdZb9n/ez/oxESb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EL38qi4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
	b=EL38qi4cB3+4SU5JW/ydGVgTvO/anUFhfijY29tDBkoHifNcruZlRGcmW4iYtUS2ZqOF8z
	z/uVqCl9UrFhsp+I+O541cH7chFy9Al8X07LfLTkZksZW7WiGTTT3uUES8HMv57yOkaz7l
	opRmYXjMFetGoRkV72vka1gvVm5xc+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-WQVMIzTbMZKBR7T8oDsp7A-1; Thu, 29 Aug 2024 10:18:53 -0400
X-MC-Unique: WQVMIzTbMZKBR7T8oDsp7A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718eb22836so447934f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941132; x=1725545932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
        b=dfuMvvLFGXkX0/PHqlGY6dV3Sz/eyEz4lwQhOkji+153ppUEXOjgNuykvBLpmdKSy9
         VQ0PcOTCdpZiCXGseBaXVQkrsBJYf9+jG7ciqgdN9uJ3pY9D9MF+f5XoiwelOhhXATGN
         Ow8J1Nlemd8RPb2cb+7uyvC+BF/sROjSCdLo4Zm9FQiDWl/6hIY+pamvTWi/ghUtQI6e
         BCHpjOe5d2QV0HE3oqU+ultYcT+vBq4elSxfxLg6viSwtJ0C9r5rVGj9Wd3tiQC+i5d/
         4jjZ36dFYF1fsRRe99vgFxYNyhOZzK/RIds3ufaUIsylJheQv1rYo1I+7zn3PbCK1XEo
         DoIw==
X-Forwarded-Encrypted: i=1; AJvYcCWwdB/DDYyANqHSg0FyUq7d7qNdfjhlGrHV2Gcxi3IwKVI3yUd3LynanhJnuM4gjEa060vIhY12yYn0mws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjhmAGAISJ84DIjyF9+AgY9gARQiyxKeKEY7UHBrHRt/lg4H0
	Oy6O3+G0kao1eJ+CczaXgKYIGE2WzyH8I9Yw5DOf9wohYgKtQyl/eRtjuqkjuksjOuD3GCqoPyA
	pYqJsFWfXWMkB8wDPB1sf04RsEP0GPpKauwH6ks7oQnDfqkq3NqZMmN0EzZEe8Q==
X-Received: by 2002:a05:6000:4d0:b0:371:890c:9b5c with SMTP id ffacd0b85a97d-3749b58e35fmr2067670f8f.62.1724941132032;
        Thu, 29 Aug 2024 07:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExu3DQrPfL2Xn0gAB2fCj8JJI6EtuIM+NkPB8RfQMu0+YrU4TAxvDtIU5CsDAlbEI3/d8Pow==
X-Received: by 2002:a05:6000:4d0:b0:371:890c:9b5c with SMTP id ffacd0b85a97d-3749b58e35fmr2067629f8f.62.1724941131450;
        Thu, 29 Aug 2024 07:18:51 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:50 -0700 (PDT)
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
Subject: [PATCH v5 2/7] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:21 +0200
Message-ID: <20240829141844.39064-3-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..602807d6afcc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,14 +39,6 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
-{
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
-		return NULL;
-
-	return pcim_iomap_table(pcidev)[0];
-}
-
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
 {
 	int ret, nvec = pci_msix_vec_count(pcidev);
@@ -235,9 +227,9 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	u64 v;
 
 	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base)
-		return -ENOMEM;
+	base = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -296,7 +288,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.0


