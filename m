Return-Path: <linux-kernel+bounces-289281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B795443B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83CCBB25F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DE156222;
	Fri, 16 Aug 2024 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEkIqy0N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2653153835
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796615; cv=none; b=pF8cblkgQR6y3F7DuIDZuEJGHm41zb5zAoyUmzFf0AuncUVDFYT7V+vMd2wXqRYuBsQBNm7BN7yK6MhUMuKWnAO0KGoHAJcOwB1aDRYUkYysKiFFFiqmTrP7aBw7AiF7Do5ck3qaXAFpBUYwdW4qLPAXcuIYli/t2kUG0RRgx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796615; c=relaxed/simple;
	bh=YADw69teg6OUTw/9kGSAzVxq8RbBIlzKklSmAwNjgek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgQ+BOcZ2o98uXtW4Nc3joIjmg6yy226/fgrd3KNIC2y67c+4K4AWvP+CAgFluRCFo3O7YvvXqiJpfZadeMvWypGIvNdUcH1T4I4z0/qF8Z+NXcIvxys2XGS+2uiO1kbQnrRSqm2dal2HRJe1+hce86ra+qnfqGBSEqUT8bvpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEkIqy0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wR7g/AUrRep93UkGki3e8tPEClSI97kh3uS4quT0v8M=;
	b=XEkIqy0N7XaBFiOzgYWs9ZaW9Som+U05MIdoJyKbFi1VGpd0E12l2YcmajAzXmvDeI7d4q
	QkLqzHf/F9DuT2w5k8E3oSo1AiVh3hTUBJp0/Yv1JCVInB9DeRrnAeio3lCYzpG3L7SzwD
	WJDPZC7kI+lTURV32h7CL5l8mrD7R0s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-zBFdLsEQO4GnXlAnL2vXpA-1; Fri, 16 Aug 2024 04:23:31 -0400
X-MC-Unique: zBFdLsEQO4GnXlAnL2vXpA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-532ffe0530fso251178e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796610; x=1724401410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR7g/AUrRep93UkGki3e8tPEClSI97kh3uS4quT0v8M=;
        b=wm6oHnqUxFbvccFKrYd2pQgHUBLniKFFUjOMTHJdl4pLm8wUVJBKHGrvNqXvZoL2Gh
         S+61vBwcBJ93fasexJrqJjyKWqmJd/Aa6GyQTQCPc4dgl7cGxflbwc0UV82vgiXoO44x
         n2BXhLorqlKKvO8veg8kLLXgusnp1Tbfuj5kFDUa6Xa02gDp6YdeeJIAMUKkOQmD1WNQ
         sg9OcWXTdxY0zTYbX2IXD+x9k5kfW56DmRwCmhy4g1NqlSQCCJD9p8B9kD4QHmxiElvG
         ICY+3M56gALMzPXzRxUNvqVamNXzFNigIYh3ROqaXUYPmA4ZzPAPdebIYkQsCzPcCDRL
         0mOg==
X-Forwarded-Encrypted: i=1; AJvYcCU5YOdBjuiwLalsqY8NAyEnpOQl3/JzqgzYdL9a2yJ/bTGiswz0NpXsGrIJ47V7xElKSAlQRaNYYAwzbX2jteface8oofmpCqaDDuoS
X-Gm-Message-State: AOJu0YyTg3IKHUV4yYtxRJnVQlKYyBZMvzbxyyxsSV+c0C1tinhsZlGs
	osqy0b+9TPpuLKGV3V0F0hJwm3EQWhVSvKp2ULlgyTSm0a53slD5PczhlR2AmYgKbpLp4JZkWWu
	FRner6jVk0pRAocbDMqvlGJ+EaQKyiL+SgAJWYUz2DLYtH1zLOwjGD1oH3UtkhA==
X-Received: by 2002:a05:651c:210e:b0:2f3:b38c:a142 with SMTP id 38308e7fff4ca-2f3be6074c1mr8717981fa.6.1723796609787;
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedci6wEskLStoN5T+/a5fQ7mQwe3Hdz3eZpzwNe45i6iFhaTa+e9V9NXIeJ1Uhhe0A/2fIA==
X-Received: by 2002:a05:651c:210e:b0:2f3:b38c:a142 with SMTP id 38308e7fff4ca-2f3be6074c1mr8717741fa.6.1723796609341;
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 08/10] serial: rp2: Replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:23:00 +0200
Message-ID: <20240816082304.14115-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816082304.14115-1-pstanner@redhat.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..b6b30bb956fa 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.46.0


