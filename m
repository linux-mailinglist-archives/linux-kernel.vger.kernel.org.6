Return-Path: <linux-kernel+bounces-271691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EB9451D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E798284276
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDF1BA873;
	Thu,  1 Aug 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRFX/tPV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B511B9B4C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534391; cv=none; b=B0duoWCnDocCJPvGoNuehU+KMMcTicn7OWW2g1RlBjxd9D+FqAOnwWtpM8hTYVeIcODIbf4bMT+A4e06dshlL5dOCgr8WdxwImK5CpW/Ka2aI9sITreEsGFvHik0EqW6MD0+VoIgqpNNxoF/W6QNqJigJqRR6MrNomVmBUKdDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534391; c=relaxed/simple;
	bh=lqUBCglzn3f4G/USTNUZWIqwmTKyh9NTx5PNNci0oUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDKolvPcQGGH2+33B0p2Bsmzvf2uXol/sJGHggzQ4AEIUkK1kEaX1c/qZ1qQoLTpF3Q6R4wFG3dsWI+e96bWozeEJvWTcP0j0RM2egtl3KlbhgT4rOvFXvft2jZ9WbT0jCEthNz95JXgiJouATu7n41Qu9FC/hB5uhMuY10l0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRFX/tPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IdydxZIGJr3ghOK2fEzH68i3FlzUyX1ZkiOar1Iub4w=;
	b=dRFX/tPV4f6iP2XtdCy/ukBmKmFOsf/rz/SADRumAgOr9H0HCnPfxlO8rMHOHyWKe2DVq4
	oJV5GKZfQuaEs9mmtcbiQCHYJd/XGP27CxQF99lvzoHUB+J0i1v44Ev4HuMtnSTuDtgKQv
	5h8YN/oHMfra7PxVEG8DAwmFm7wX5kA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-wUOPwDjyNDyw7ePI7Cic7g-1; Thu, 01 Aug 2024 13:46:27 -0400
X-MC-Unique: wUOPwDjyNDyw7ePI7Cic7g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b1fe1cd9eso1317505a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534386; x=1723139186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdydxZIGJr3ghOK2fEzH68i3FlzUyX1ZkiOar1Iub4w=;
        b=SWWAHD+jsp5MNk1T3L4myZTULBqNbfcyUZRyPGOoEkEWeMcjXH7I97cjxRVQJdxATN
         eTXY9ck8DMQG2FmW/Q6pSiTnl1K2bTqrknA8+Cm07jeq9JUYJ/3INKQQJjFXU541gyck
         rPTwCixis2B8CGGfsHo9GzkQDglA+7Njnv59k7h/VN1X6IT+uUrN9HP4qkVOhC4tmOyH
         54ENYoHXiA+AWee0cepviuXxbFMZSp/54lK1hmXLhPtcU4NUTCbN/DcdvUY/AUQ9Y9O8
         kCHPSKP00Cik5se2F3HrMLcg368A8ijeYt0KpJ4e2qLniAKTDZwETDerwLxyOupdU1ud
         fWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfySKcg8x1qqaqyhu+wMgjwOa8AhvmnaBs3VoRpqQOPzPruGKY1aTKHyOj4bAl/3WRMCKfOYN7xHgdQxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8C39D3PgPt2/K7ljfT7e5x0MJmk0p4DjWQIN6JURwbF5Q8py
	MDme7Jhex7oFfPVIRDrlHUVh3UX/slIe6+JWbXyZ8kEKiUVW1jEQqo5ky0frgdEo0FwfSFe599N
	aPr8gBc1A6VOZaLfba1jAahT0dO/0U/8Hwz7dwSf8YWZZk8mBPBSixvPWVuVy1Q==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr44422566b.3.1722534386296;
        Thu, 01 Aug 2024 10:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Km5jd9cOTYruluysPjH0y6sNbWlr0amJSpmaneqU1ki99pbWjXrxV2Pr+1gBC+OPuM4UGw==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr44419866b.3.1722534385669;
        Thu, 01 Aug 2024 10:46:25 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:25 -0700 (PDT)
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
Subject: [PATCH 00/10] Remove pcim_iomap_regions_request_all()
Date: Thu,  1 Aug 2024 19:45:58 +0200
Message-ID: <20240801174608.50592-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

the PCI subsystem is currently working on cleaning up its devres API. To
do so, a few functions will be replaced with better alternatives.

This series removes pcim_iomap_regions_request_all(), which has been
deprecated already, and accordingly replaces the calls to
pcim_iomap_table() (which were only necessary because of
pcim_iomap_regions_request_all() in the first place) with calls to
pcim_iomap().

Would be great if you can take a look whether this behaves as you
intended for your respective component.

Cheers,
Philipp

Philipp Stanner (10):
  PCI: Make pcim_request_all_regions() a public function
  ata: ahci: Replace deprecated PCI functions
  crypto: qat - replace deprecated PCI functions
  crypto: marvell - replace deprecated PCI functions
  intel_th: pci: Replace deprecated PCI functions
  wifi: iwlwifi: replace deprecated PCI functions
  ntb: idt: Replace deprecated PCI functions
  serial: rp2: Remove deprecated PCI functions
  ALSA: korg1212: Replace deprecated PCI functions
  PCI: Remove pcim_iomap_regions_request_all()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/ata/acard-ahci.c                      |  6 +-
 drivers/ata/ahci.c                            |  6 +-
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 11 +++-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 11 +++-
 .../marvell/octeontx2/otx2_cptpf_main.c       | 14 +++--
 .../marvell/octeontx2/otx2_cptvf_main.c       | 13 ++--
 drivers/hwtracing/intel_th/pci.c              |  9 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
 drivers/ntb/hw/idt/ntb_hw_idt.c               | 13 ++--
 drivers/pci/devres.c                          | 59 +------------------
 drivers/tty/serial/rp2.c                      | 12 ++--
 include/linux/pci.h                           |  3 +-
 sound/pci/korg1212/korg1212.c                 |  6 +-
 14 files changed, 76 insertions(+), 104 deletions(-)

-- 
2.45.2


