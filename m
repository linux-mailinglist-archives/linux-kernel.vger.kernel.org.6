Return-Path: <linux-kernel+bounces-271699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B4945217
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11ED1F28ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331571BBBEF;
	Thu,  1 Aug 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfs87WY9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F031BE22C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534408; cv=none; b=Y28WImAjxND61JwVzBaDCVHL2bjHhQorcJtzeRQKNo65+n+L9xqwdb6yvvmHQIEduz4QFPIr61N2ZDnzuBmfRanmk/ExeDN0t+4Q/jwCePzd8a7J9GtHF/JMwO81SubwMBN/Eqq6nTcrU9YraXM8DkhfzQW8r0Y8uykKP+LIJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534408; c=relaxed/simple;
	bh=4GexEWYmB++TVKtf95ojSGSSevwi4ufn2RVpQzXAHG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW9GYPifZuBpzejPnmvKupa4+sfMR18ROFHXzlxMGmstDSI57UEG+e6RlG9CGBLVWcsHUnL6j8jpCfAFNVNj2PuyXGM7WnqkAkaalBqb2E/6mbIZQZwfXYuUq+pOMwNcJUxq9dOVeEfGQIT9P7ItS6lIp7Y0V0dX0m+mlnJmnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kfs87WY9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5hpd+G0LExVaxl+UI//CFwTq02L8uYAsSV7qLlWbdA=;
	b=Kfs87WY9Vb6wvOCN6m1yhyQjWjrgggKllyUikSRNJPMALVeBpqR8kfc7OEVDmDx1FQk4mW
	VHbsXmtvxqMIDOJkEwSHOEv5EJLPiyetXSVZt95+HfxQaHGosO/hDPo+F/6W1PS4QlHtcb
	3ivXHTHypCLI3I/6A8vmdonKbZqVThw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-sNUihTbOO9KSLhtBXf0z-w-1; Thu, 01 Aug 2024 13:46:43 -0400
X-MC-Unique: sNUihTbOO9KSLhtBXf0z-w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a0f73ff43cso1109913a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534402; x=1723139202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5hpd+G0LExVaxl+UI//CFwTq02L8uYAsSV7qLlWbdA=;
        b=LXFsJqwv//sxkC0R9yJukMqiV1nUCdo8f1ksno6jW9dDb67hsQG/KREHbGZP+FK4c7
         6Sbh5vReEhVIawD2dLI94oFrA48rPN8R6taUxRdpfrIkt6/dXWVccTtZO5P+m8do6uKy
         VZHs805gkZ838ftGz7fqnHf6xoZUG3XQeC71xGm/uMgUP65ivUon386zenSjVtTQ/+R4
         D030zuEuqFAS3bwFDG5f+qujqSOElpC9MuDFz7hKkZQ5N9qlp4WETIEhMVS3hFAenDrq
         xOVWdbm25gJmMyxRgemHmkNbxMgUivSS//mY4anXl2Ro1peIYqZ0B8GT/0c0IdejU473
         yMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWep8FffAj+KRzkPJ6Vrl+vjgLXrkOF6vgb+xJhf+FbidaZxur5pjXSSkmWRSKkAjQr5yKIbc2MtFVOqXw3nC5e9C6EpBpg3U6+Ckht
X-Gm-Message-State: AOJu0YxeUjVdziZ4Eu8BryVNQn6iwrsMy8rk80QGI7UxayMe2UXq9s3h
	u/icTRcI5YrRw1gBBqyGhOhPs9WU7/hpXtPpG6db1o3thpgH9XAIXcmjrCXDWWduiwypEWJRXvL
	sRmJZHdJrWPNgcq1lXA5VFHgBZAx1j/XjCYDtpwf8dWbzgndAykZt4gcMf0zEQA==
X-Received: by 2002:a17:906:cad7:b0:a7a:ac5f:bbeb with SMTP id a640c23a62f3a-a7dc4d9510emr40295466b.1.1722534402517;
        Thu, 01 Aug 2024 10:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAz8VECBqGLuxnHbBqNGh97d2AXukf5BmEUdwoQf65+BgJnzGGIwfvlOLLLnXxYF4IguemOQ==
X-Received: by 2002:a17:906:cad7:b0:a7a:ac5f:bbeb with SMTP id a640c23a62f3a-a7dc4d9510emr40289566b.1.1722534402107;
        Thu, 01 Aug 2024 10:46:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:41 -0700 (PDT)
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
Subject: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:06 +0200
Message-ID: <20240801174608.50592-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801174608.50592-1-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
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


