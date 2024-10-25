Return-Path: <linux-kernel+bounces-381963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E529B06E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190391C24E92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7E231CAF;
	Fri, 25 Oct 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpW37LVf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE420D512
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868458; cv=none; b=V9wRQgK/3uTS2R3RCgzuCxPvXitgIJvgycy0aCUomJjQGAtV+UX958MEttnkLkCpVoD/M1t9h3dYA8lA8ExlqJ1q3bqL5BtTKhnXXa2WDK6yD43imBfNfuKCutS6OpEn8nmRhQcupls32Bper53hOTkWhODj/Cw2N56BkCbChlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868458; c=relaxed/simple;
	bh=fUViQ0wuhaRh1Z4rYxnCtcfkzxZviFoQ/oXZmPMz6Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgAPshQNmUct6gkVCkO5g1iTyMjBWnOv6FvLgSiMj2ga3HtTtBdz45W5/h0jppN7Q8f0BWKpfpJcA/GaCGuXvHFMdFtLCM5ZQAzmUWppnG2G97DiNaSnnnJb7J0rBr87+SCkGmoyZCI59TyGPM9DVJKqNWN7SylzI75b7DUtmlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpW37LVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pA/Y9KFQGL5eKPmyYHAWaMItiz6sKe/fm026vyTOII=;
	b=JpW37LVfOAmR563tcLs00abiiyWwXlNCDtU437nq1AF4Tz9wzDqXuR/GlxGJX7Qftm+DBQ
	uV08I0s/yhxEiSv7o24UWnhKDdUfD4A9RqZzWRCfgdL1vf06/lLzZP/eCiTC+aEMHeEHA7
	iZsnJszHG1hD+fTV5fZ1PTolWFXPRlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-jxxGSd0YPi2blIz3kTUSWQ-1; Fri, 25 Oct 2024 11:00:51 -0400
X-MC-Unique: jxxGSd0YPi2blIz3kTUSWQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d533a484aso1612420f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868450; x=1730473250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pA/Y9KFQGL5eKPmyYHAWaMItiz6sKe/fm026vyTOII=;
        b=VUN0/NLKfCxb9fYLKvdcK0IMape8cpb4a4la9eJh4KPQWdZozAcIdsUjlW2wVSP1Z0
         1bGHkdy8ysSu8WIrt2u0qje8Od3rUyhCp0B036BqUJ2JIu3sOWl8mVWqMpnVTLxpvx2U
         ubYMX1mibKTubjHkicEClxPLkd6m9WKawjDHH6vbJT0+ZqWuiLWuVRzcEaC0iTb+JXts
         PTk5+TrpdFRnVvIxd0FFaVOIIBJY/kCkCSDztX+9mw7i0hwY2lox32woNNo5mb+zzB8g
         GisLpA6gY/osyhf4gZt1p+4AGNK9pn252PrzzYARSkpUM52iuN1cZAUaDibwi2iF6gWm
         UPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgydodRTq+5wkELUttmibq3zYi5T6RzQzgNeRzRrP10MZVmnucKQR2DEW7yTJOdJ6fqGezKHeJsDhtEJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrFL+keOkk8Lfhs5an4uzs1dG9ASwYnn1wxpxLCBWmi6/WWYb
	K4QEmg2e+WzxArUaWZF0YLYtrawybx9Z/RLrklTcUTHWhpWeVavHGI7N+nv/LbtpgejlFRJGkHS
	BSB9t2ua+azHGOfs5rT//9JIWj7BvSEUaPBC5VwVpSj/viK1TD2PTa4iyUlM2DQ==
X-Received: by 2002:adf:f5c3:0:b0:37d:2e74:2eea with SMTP id ffacd0b85a97d-3803ab671c1mr4935721f8f.5.1729868448916;
        Fri, 25 Oct 2024 08:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrImwuTr8UU6hSynSFO/Qk6OWlhES0U2PEH7e6DuZZMiwqG+LsgRJgOGFwOY24fOpFVbrN7g==
X-Received: by 2002:adf:f5c3:0:b0:37d:2e74:2eea with SMTP id ffacd0b85a97d-3803ab671c1mr4935358f8f.5.1729868446141;
        Fri, 25 Oct 2024 08:00:46 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:45 -0700 (PDT)
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
Subject: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Fri, 25 Oct 2024 16:59:49 +0200
Message-ID: <20241025145959.185373-7-pstanner@redhat.com>
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
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3b9943eb6934..4b41613ad89d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3659,22 +3658,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
+		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
 		goto out_no_pci;
 	}
 
-	table = pcim_iomap_table(pdev);
-	if (!table) {
-		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
-		ret = -ENOMEM;
-		goto out_no_pci;
-	}
-
-	trans_pcie->hw_base = table[0];
+	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
 	if (!trans_pcie->hw_base) {
-		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
+		dev_err(&pdev->dev, "pcim_iomap failed\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.47.0


