Return-Path: <linux-kernel+bounces-295031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38009595CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E4C1F26064
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E003192D66;
	Wed, 21 Aug 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFdx8qa/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2E1ACE0A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224771; cv=none; b=tIlWDFMy6NFxie9LJhFZ8/3YqqcBHwRGYIuy1hitdgdFrzSdvOMyF3xOws+7sbZdYx3Ozju1MWxvqnZciAkbgSnNjie7ZD9sG9DoRxOLngUik4++VPD8hcjNPoPV86U4maFfW5e80PUVY5JixA6tWUHxI9pDA8Ay+/8xlyOyoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224771; c=relaxed/simple;
	bh=SgQa/apEnyQVxi5RGIOMYDsJA8zmcu1/aNTE/QznKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEQL53Eq5SdbdfC78u1vYDHRTwzsyxhZQ0kRZHaxYeI0hcyt0EKqvihTBRvT+EGE2+gLBm2kfrn3f8ZvidGQLe4ypWN3IA9mMubAGrN0SGo7m1CbQsQZTWNJgLPxR96wOJRg/dwydcoM8L1yILSTNPOEsjV8uyY74plM/orSylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFdx8qa/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
	b=DFdx8qa/gnXIzIUX9EIP3arwWTB3wz7vM5bbozS6zC50PPdZGLv1L2qytAlGixBpmL/8oA
	X95k90sYfQSVgp4SKkS8v9O8ok2p/CmaFyWN+B3duxEr4Q22rKYvYxxDzAhoDiV7o7Nums
	jQDBo/5ub8tZV3FCNLGcMD8n84Ornko=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-BsGd-XsXPBa3asbhQt2ZGw-1; Wed, 21 Aug 2024 03:19:26 -0400
X-MC-Unique: BsGd-XsXPBa3asbhQt2ZGw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d40f49f5so711505185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224766; x=1724829566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
        b=FwffZyuU05Y80Onjt2knWDeclrmH1EXBxB08VJWWFeeZ6KCoQh9y76rszZw2BTof5Q
         N0AZDlI5AI+a9MpQR37hM2GeDSNcYsEmMcSgBCES0DZmCB4/8hUVIT+3oCk3Wtdrhbx6
         6M5dWLxN1c3tiv5wYlzk7Ncmh/WjLw1b+YhGVP1RDP8/y+Wy7wcAlKGWICG3KpO/5rrt
         KuFX7YQvYyhs1yT/lBmDE9sioDwbixNuhK/JjFJchDGC9eNC5gh/Ocyzr17/G9c6waOX
         VmpBqy8xT6Yt5NGX7eQxoBpo3lB4Y3g/prmlTBDqY7GzjeOjVfTwCotoesn6FCFUtc94
         zzLA==
X-Forwarded-Encrypted: i=1; AJvYcCWE/rwroXztVKH5KynvCZ939UXjvlUGCR7S4/TsOgo4gehjd50TMc3OnRvmw+WyqXpLmvIaFs6hBNKK/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkOCLdaZtbCl0h1HQGNXwFr4RgulwAY2w77aAbKrlk7aEmdLRj
	sTh7fgrDFe209ljWRjwdnhfm9HMv/Jk5OEOfXWp/3mGc5LDAa01PW64H7v2gJOnXkyo1NrnqiXC
	E+p09HWinjHX5X2acCPqpvYVJg45VbzNl+wkV7M2vM9YPF21O8v4HNukTiqzpeg==
X-Received: by 2002:a05:620a:4447:b0:7a6:6b98:8e36 with SMTP id af79cd13be357-7a6748f3e18mr161733985a.16.1724224766190;
        Wed, 21 Aug 2024 00:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmBWfs7G37gw0gXLs+jJ1ak3VoPRzhFXnnqGnvalRJy1Z9qU/iCGfIEx/5sYtw8Qbb8DqgNA==
X-Received: by 2002:a05:620a:4447:b0:7a6:6b98:8e36 with SMTP id af79cd13be357-7a6748f3e18mr161728685a.16.1724224765719;
        Wed, 21 Aug 2024 00:19:25 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:25 -0700 (PDT)
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
	Keith Busch <kbusch@kernel.org>
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
Subject: [PATCH v2 5/9] ethernet: cavium: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:38 +0200
Message-ID: <20240821071842.8591-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821071842.8591-2-pstanner@redhat.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with the function pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..1849c62cde1d 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,11 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
-	if (err)
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	if (IS_ERR(clock->reg_base)) {
+		err = PTR_ERR(clock->reg_base);
 		goto error_free;
-
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	}
 
 	spin_lock_init(&clock->spin_lock);
 
@@ -292,7 +292,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0


