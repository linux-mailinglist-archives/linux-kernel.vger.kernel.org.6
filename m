Return-Path: <linux-kernel+bounces-297378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296F95B72B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA757282CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E711CBEB6;
	Thu, 22 Aug 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRMmp4Tw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A911CB339
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334485; cv=none; b=bM+rEBsXZZn70jeUcRLtawV3/eoR6jEnOOJ/J4uoyJqBSrZYwvRZ3xbiCQkpADPpWbkxu+d4z1flQ2dt3b9rPZVp4lQaUcxtq1VcoybMaKsKfLbJYa9GzSj76M4bcl3O6tyZRsbBapS5Y193sFBLEOxATQ94Ors8kAojyf9Y+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334485; c=relaxed/simple;
	bh=TveaYkEbx2doRY7IcRS2QWPC/9cfsUPF8paUrSreb6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JAN9QD2hdNDi0PC3/4QYCIdGSIkojQBTuE1otcXZ7ukH/7/29U6Yf2NT3kL/dA80poBqhKn3jGVy8Kv/iFmmyjlchgY4n6NnBDW6F9Tc7uP1LCGdle60ge37ulzivo3rB8SFo2sRkf1SphRAZ9zzv7yvmhQjhSxMaw1qKW7PwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRMmp4Tw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FjYBhspv7tRST0pSqSmRh821Mv70zB5zctMwrlaK9DI=;
	b=KRMmp4TwaYeNmgMYe+OAC61MmEjeegfpkvS9vY3tIbqXkintCa+7Xmk53QqE5uTFNN9HRI
	VLjjgy8oOrHR8bWReuZGcdYv4afXV5sOqLDYF+hFbinBn5NKh0K7Ir7NBSdbnl5u7wnA5a
	mt0Gxp4hosf5gz/+8VAIuJyMn3yFoAA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-Vf9zHfb5MKuKlYilsKV9jA-1; Thu, 22 Aug 2024 09:47:59 -0400
X-MC-Unique: Vf9zHfb5MKuKlYilsKV9jA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso6288655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334478; x=1724939278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjYBhspv7tRST0pSqSmRh821Mv70zB5zctMwrlaK9DI=;
        b=R3n7YzdxoA1qzNqNzkVzWv4UskPSQFe3GBw7nCtfczDN2gMr6/LWlgkUwYMkyKAr1o
         BUZhs0Y5bVrzTWxTjCMSUVTQ3VmUf7231AvPwUYpuiVbwolKgotlMKYAV2q6KOTPPu2S
         FAB6lNUKMnRiiRLZNTvpFKfK3FTWfEiiJUlb2x44u66NAp8P+ja7T09ljTQ50paYV6L4
         aVadQa5VZ0ixzlER8F+aChqNfR4SvbR8ED8+DCru1BypBDtiuVaWwys4b7UpXmH93WMz
         A9HraGE03AZRwzO/TWtMFNia0oSDdUVUq6aetDKqajC2i2YlYVEcmwsUTjns/KG4zPvE
         taZg==
X-Forwarded-Encrypted: i=1; AJvYcCWuldYSQPxa5PAmCEfydkoZmVSotHaQmNUNa1yCKRnTj3xbTXeQ9tbndwW3+HhKmfP0AfwoX8VLmihqA6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7nPNoBHp/obM+8sBi1OfuqnaG8opp0o0RiKypB7Q7i3gSp6G
	rIrJLs5UePVSXes5xGIxPWl6JFiCZFkJLcT/Oc/FpnzQmCYOXYDkAnmQ8y/4lxssqskzI/I14Ze
	UB4hpW/gPsngYKNOW9tLjO5NGkk0PEt5vYZUKz5efex9QnIcV8sG+PhgA0yHwpA==
X-Received: by 2002:a05:600c:5014:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42ac55babf8mr14882845e9.4.1724334478053;
        Thu, 22 Aug 2024 06:47:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9pgATN30e2cGvgnx/4ylawVQ+wC24Vnwz41hd/vPVumxXeQFsraVN5ewZN1S7fwv2HF76Rg==
X-Received: by 2002:a05:600c:5014:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42ac55babf8mr14882365e9.4.1724334477513;
        Thu, 22 Aug 2024 06:47:57 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:47:57 -0700 (PDT)
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
Subject: [PATCH v3 0/9] PCI: Remove pcim_iounmap_regions()
Date: Thu, 22 Aug 2024 15:47:32 +0200
Message-ID: <20240822134744.44919-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v3:
  - fpga/dfl-pci.c: remove now surplus wrapper around
    pcim_iomap_region(). (Andy)
  - block: mtip32xx: remove now surplus label. (Andy)
  - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
    occurs. (Andy, Christophe)
  - Some minor wording improvements in commit messages. (Me)

Changes in v2:
  - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
    patch, put stable kernel on CC. (Christophe, Andy).
  - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
  - Consequently, drop patch "PCI: Make pcim_release_region() a public
    function", since there's no user anymore. (obsoletes the squash
    requested by Damien).
  - vdap/solidrun:
    • make 'i' an 'unsigned short' (Andy, me)
    • Use 'continue' to simplify loop (Andy)
    • Remove leftover blank line
  - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)


Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (9):
  PCI: Make pcim_iounmap_region() a public function
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  ethernet: stmicro: Simplify PCI devres usage
  vdpa: solidrun: Fix UB bug with devres
  vdap: solidrun: Replace deprecated PCI functions
  PCI: Remove pcim_iounmap_regions()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/block/mtip32xx/mtip32xx.c             | 16 +++---
 drivers/fpga/dfl-pci.c                        | 16 ++----
 drivers/gpio/gpio-merrifield.c                | 14 ++---
 .../net/ethernet/cavium/common/cavium_ptp.c   | 10 ++--
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 ++------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 ++----
 drivers/pci/devres.c                          | 24 +-------
 drivers/vdpa/solidrun/snet_main.c             | 57 ++++++++-----------
 include/linux/pci.h                           |  2 +-
 10 files changed, 61 insertions(+), 122 deletions(-)

-- 
2.46.0


