Return-Path: <linux-kernel+bounces-274329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E899476C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BB31F21B29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0131158547;
	Mon,  5 Aug 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhDwejoo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BC156F44
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844945; cv=none; b=RXSvb8dHIKjk87Qt1g0EXWL8BWHDfRfenmfEd01sabfxLqNnvAbvDq5GwwMYYnvs5MIVBhIFuJ4X6K+7XHt5yOYOhLI8DxmE4TTTKUFR0no68ph7BH7tgazlJatnvTp65U6/5t3xk6EC4pYfL5ewl40mcgST3zjTOQ1pNHe//J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844945; c=relaxed/simple;
	bh=XVnRSeomOV2CcZ6TomefmLqSPd3/SQ4wMxlPfANkowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/C5X7xuvVt8Ep9fXomgkxFYnvAMNOf10y1ZvZ4IniYa2r/xmx6m9kQmRTHTnVkCjcvh+sVHgpNbePWGcA6QqWrkiDMiXnLyYGdGy/uO3Px6KtzompeOKEstPBSYUpv1sCUhgkygGg4fVdqVRmGrCJ/p98KniHx0/sfw4edqh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhDwejoo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0/Bizm19ADXNR3ICrhb9w7/UmlF3K0oMXeQfztA/nw=;
	b=XhDwejoodYA5wKQeRgyWMoy6nwVTu2m5m9z+UYXe32OxEkRg0ycXtanZQslGa5B77qTGpw
	20Rqeg08t5cKURSkwWQZaXu+hwG88hQRq7XRVX2EDD2cLNXJRqUjI7De0zOtdZf2fTCfKp
	7CHSpsd80WoEaWN+/EOEWuZb8sNa4so=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-FrT5WxKCMSqLPROIurF7pg-1; Mon, 05 Aug 2024 04:02:20 -0400
X-MC-Unique: FrT5WxKCMSqLPROIurF7pg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58b1fe1cd9eso1900634a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844939; x=1723449739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0/Bizm19ADXNR3ICrhb9w7/UmlF3K0oMXeQfztA/nw=;
        b=gd1JFEdc+3VpfPC17WDcF0wVyIzQ9za9NWRLGdKasxiHm2YCanWIh27pdCWSkXvV2N
         yjoxkIW+e8cUYe0RIVB6VeiIP4nGSwvUf5lpKZ+Mnyz7/TwQjGQcWcNbqOijSyR3mlSA
         ZZLF/R2tx478gvQiPJkD91WktiOfhFRnYjSl7TbzB3HmbE8Yt8BVvWasHVpT2R/UKpJ+
         H4fpWSJxa7E0Cw99BmjXKtrdSZ5Ou9vfoWY0sQ+c5RX/WYxv+vVOsipvBrK5N4mn2wXy
         UjuO51GEPSwVf4YhXWkXGx6YlIBkT5/8dF7XhCUXItY6gZPpG5q1jmoxPofAP916veHJ
         x55g==
X-Forwarded-Encrypted: i=1; AJvYcCWg/MShr7x1BYlA/0n2f473K+ptgveI16sCIvRfZSEECqZLeMWhD0FasJxCRTUs8y3K4fqVXA8rFl/iYYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEcw9CizUwon/qLfm66cWM/cQfmO1Z2+Tpuh6HLth8foxyQmy
	RFf/SSqwUO1j+vNWHDUoQ/LaWa4ioxbBxKLlpQF5Pu4mTBpSOo9+5i9sLIzdSRde+ElnzF7x0YQ
	0MuCbSFN9wZwCja+068m1sINxJfEInYGgvDF/Nw/hewRPkgYKQnT3bi3bPtWOjw==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr513583466b.9.1722844939178;
        Mon, 05 Aug 2024 01:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SJB/SW4G2idNXeZQo9TGP1SQwm7yFqzOP7n5lB+7g8ap58Lk3/dgBFHgiZuUlpVVamp1Nw==
X-Received: by 2002:a17:907:6d06:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a7dc51b4cf1mr513582166b.9.1722844938741;
        Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:18 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v2 08/10] serial: rp2: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:35 +0200
Message-ID: <20240805080150.9739-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805080150.9739-2-pstanner@redhat.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
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
pcim_request_all_regions()

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
2.45.2


