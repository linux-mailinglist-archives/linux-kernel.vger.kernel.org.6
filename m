Return-Path: <linux-kernel+bounces-307097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9250696482C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9202BB292A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE81B1406;
	Thu, 29 Aug 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErAbAP7T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DA1B29B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941140; cv=none; b=VXf9X5YEexKWNMo/CtUVlEFof2Dd/oUYmlBdZL19Y5KA0IE2ZDCwfa9i4UvfLHTdgwuhYwFfaGi1nfPO2thorHIxYvBPJQo2ol5G/WaVEpuGgMeFe/jX4NHFSRcltJWiZZEwMtfY61+p9/56G8xEril3a5c+FVE+KnJRrkeHl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941140; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr8ABBO4y/spjxzhGQCvFwgZZEe+mWuZCWMYLxnEp7lNOzd9W3q+BmMtCJqg85dLCqz1DGX949lg6rtW1CBxU8n7lye8KHTVbVt7r8m4Tlh1htVJ19TQIjwC8rAzubDQTl68d0zxnwuCgTPno6dCYiHv7TkrfgTmYPA5jE9TZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErAbAP7T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=ErAbAP7TsDCT7KhAyJmeVt9ChwTVkGjAWh6n7/3GUBgQq+T6svF4dmP+ZKUxDUrqy/+cuh
	A06/s7ZCg0iUwpn6XM0ThzBwgdMopkCuRY9MGJaUArmdQppQceW8/V9knjDg2Eqtd/kZ72
	5yROY3GNnH1UMCXj12WvVcQ6u46D4nA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-4jA46QKePGWpVVOzdaaIgA-1; Thu, 29 Aug 2024 10:18:56 -0400
X-MC-Unique: 4jA46QKePGWpVVOzdaaIgA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428fb72245bso4642535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941135; x=1725545935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=GDOR8kLWoNZJ428IRMtVdT+N4Joxb1P2vkfSoVOjFy+TC0G7mF5VCMKjJ4jOxf1QOu
         5f8g0GNUj8qINeiJlqR/gaU+msG4hQnxVrsbVvy8ebluVfEUc1VKiJWbVMLV5ptfd189
         k9xXk+e0z8oZlc0zQ5HCSVw8erlOcPHA/Z3+7vUlbb+7wOSjOVTQaYK3x2ZFLJFLI94w
         gm3Fv2wAzfFAhrGqEV6nP6d/T/yU5gTANmQpK0ePDmIFau4Cp+nNY7L17wY3vgldKS+O
         wV2zCnyBC1rOJXF5ha0ieOCej0i0lpt86ZBQz/3K00ZptEwp0rxUYzDBU8sMMuPRr3NW
         EFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN5xKvTEfZaGkdemm5kPn+eTQCOehCzlcDeCXN2wicnSkcOi/mWRUqds0F1Y2czClf521q4ngpszOQnjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuVqeb/Xpa7AXv190ej4TEAkPE2ogyR/Y/a8uIeL4RW2Dfuqx
	X+bgoAcsCu6HJjomdG2IJpGc70+gRLPD76kk83C0alPf4KI7+2pNEjYfHRLSUIRXJp0HUIplgZP
	KXcnwg+OC6T/crx6K9okEN4R2qrtTYB97RzgEPVgwWJa99zQA0AY9bRSYdkaBLQ==
X-Received: by 2002:a05:600c:3d16:b0:42a:a749:e6 with SMTP id 5b1f17b1804b1-42bb74403eemr18537955e9.10.1724941135154;
        Thu, 29 Aug 2024 07:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5CyqY/wd5nkLrhi1KCiNw1KCCPc5Bn48lyL/rJpYaGF/BSmvD7WGs5d/ldDgSNQeuDENYTQ==
X-Received: by 2002:a05:600c:3d16:b0:42a:a749:e6 with SMTP id 5b1f17b1804b1-42bb74403eemr18537655e9.10.1724941134717;
        Thu, 29 Aug 2024 07:18:54 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:54 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 4/7] gpio: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:23 +0200
Message-ID: <20240829141844.39064-5-pstanner@redhat.com>
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

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..274afcba31e6 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
-	if (retval)
-		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
-
-	base = pcim_iomap_table(pdev)[1];
+	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	irq_base = readl(base + 0 * sizeof(u32));
 	gpio_base = readl(base + 1 * sizeof(u32));
 
 	/* Release the IO mapping, since we already get the info from BAR1 */
-	pcim_iounmap_regions(pdev, BIT(1));
+	pcim_iounmap_region(pdev, 1);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->reg_base = pcim_iomap_table(pdev)[0];
+	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(priv->reg_base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.46.0


