Return-Path: <linux-kernel+bounces-381959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C29B06D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935901F22CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662E20D4FB;
	Fri, 25 Oct 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O387BUbs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278781862AE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868452; cv=none; b=mqCdkSSXVhJK7xbIjAYykUkXjnjiG+WdOYY7YglCDzlT3K8OidUMPcSLfyMm86dfPwKu+Nb8YoQUcVzSx2cOAVGWEqe/fPA1R+y6OMnskm1VRkAdCM8O/mIMb3AngQsFvvYrm59lY4okBnv6zsokw+KYadQ3wuVUWXahqSURM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868452; c=relaxed/simple;
	bh=J3pG/0Gfw8HnALwZ/Br+hrSE4pEfpHhtl4LqImtqkrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqiRFAJk881uI/jjsq5xwd3UvKJIwtPz1ez6qxAZ2zboDx82LYmiRqN9E5cH101gZ9YsTsQnqTXa6cVXKwwUyMb6IpkR9kiWGd/kreCZoYCaRmAUaxazNibTopgJ0yyATuV4TKFO7Emg47bkif/ISqcEJkGrqK4B+GaNr/e+iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O387BUbs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLUy2S875DNBeHIOQOxEOE4p7AHnezc+a90RKtjms08=;
	b=O387BUbsjQOgSoWMKA1dpDjBJRdsgcWhzZHbzO0jRZKgXl5/HBALr7q8bjRHk6NnSjBnIw
	YbI2xJy0o94zN7ZnUaA5qVRFUHYThikaXu+LQUVJiDV3AjZytcBYkEnA08gd0un8QIMekg
	dLoBwgqdHdnk/mbHVwS1SfEQ53pbeOo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-4yEObYlGP4-JmAL_0CnAaw-1; Fri, 25 Oct 2024 11:00:46 -0400
X-MC-Unique: 4yEObYlGP4-JmAL_0CnAaw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d432f9f5eso1117912f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868445; x=1730473245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLUy2S875DNBeHIOQOxEOE4p7AHnezc+a90RKtjms08=;
        b=DPMSjXkoqu7CBVUC75Dk9uJqDNO+QNLoNR+hZ5IyKL/33YN2Q9SPVEm8Qi2q2OPgsm
         g9JfOtav+Wz9mmGJnnKxalK4qzYVrR87/vJMR9juB1cIwnFrZqnKplymhynuz11liIWi
         rba9OHmVk+ZLE6+Q3UJT49o1o8z2qdxX3YvsQiLghYIym5742C5r0masEqVjeEgarKjU
         Pe+DcC0Nbpg+vP/w4YsHWGZq3ToRC+55UWmLydUnh8AoWKqgNpnXDNwgUdAWF95RMsOP
         tEHQ8F3/gVkoHxbPgF6l6Ti5yd14+zwwX0ja4H9OHfIzw3Z4oqdn48iIYDd9Koj8Cuy/
         wW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWoSHhXi1h5iZWOhM4C7ykmCdVnN1AjK7sj4LQ8TXk964tP/7bKr1cJdfRDahL+nKMrVmyQcCMjjG7yg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWivTL3cKAv+4uruOfPyf890fBjDm3/E2tr2/FpUm+nHETgsx
	keEPf4stLcnpVGetfcv4T2wqKz0GZn8qsmUweUziIIeOD7Q8Ydxs2203o/EaztlkJ6RuCwV42sr
	I+QxMU6wcYxoZjP4BkrbYuU5B2nnjxOkV//tz4ufKZXz8sOOjPC6vSYBNFoOiww==
X-Received: by 2002:adf:8bda:0:b0:37c:cc4b:d1ea with SMTP id ffacd0b85a97d-37efcf93402mr6344478f8f.53.1729868445221;
        Fri, 25 Oct 2024 08:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6ZQPMgpVCbtBrqjfejgU4ALi6/qBZHusO5I0iFUt9VWaUU2evS88UKp9GOeAkaETKTdLQgA==
X-Received: by 2002:adf:8bda:0:b0:37c:cc4b:d1ea with SMTP id ffacd0b85a97d-37efcf93402mr6344361f8f.53.1729868444438;
        Fri, 25 Oct 2024 08:00:44 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:44 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
Subject: [PATCH 05/10] intel_th: pci: Replace deprecated PCI functions
Date: Fri, 25 Oct 2024 16:59:48 +0200
Message-ID: <20241025145959.185373-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025145959.185373-1-pstanner@redhat.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
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
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0d7b9839e5b6..e9d8d28e055f 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -23,7 +23,6 @@ enum {
 	TH_PCI_RTIT_BAR		= 4,
 };
 
-#define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
 
 #define PCI_REG_NPKDSC	0x80
 #define NPKDSC_TSACT	BIT(5)
@@ -83,10 +82,16 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions_request_all(pdev, BAR_MASK, DRIVER_NAME);
+	err = pcim_request_all_regions(pdev, DRIVER_NAME);
 	if (err)
 		return err;
 
+	if (!pcim_iomap(pdev, TH_PCI_CONFIG_BAR, 0))
+		return -ENOMEM;
+
+	if (!pcim_iomap(pdev, TH_PCI_STH_SW_BAR, 0))
+		return -ENOMEM;
+
 	if (pdev->resource[TH_PCI_RTIT_BAR].start) {
 		resource[TH_MMIO_RTIT] = pdev->resource[TH_PCI_RTIT_BAR];
 		r++;
-- 
2.47.0


