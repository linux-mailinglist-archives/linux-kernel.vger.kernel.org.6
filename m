Return-Path: <linux-kernel+bounces-207941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEA901E40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB971C21476
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859F763FD;
	Mon, 10 Jun 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBgve4Ha"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7C7407D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011928; cv=none; b=H8dN9sQvowa1yIlp5gF8ArfEm8ho+OVMs20DazKgg5flOERp1jaSASdeHPOC71QvwzuKOVnXzImikgJhjUa8pJYEB7G+Qc7whkLfinuy4Maqyktq7a3OD/RBihgPlmg7Nh9oFt7ntH9f2arLyBhKgRndHK1mV0i855DszTbDqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011928; c=relaxed/simple;
	bh=TgkR4Nl7UsfcnDus5PAQ/eglmpUMQS/oRcoljkpQuXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NONC3NZWebrwdCupUJX+6pjyokqsNtzZQjr6bq4dHhKu6rnJCqMZHg7uAkPgXWU9q6EC1fei7qNUpzyBiv7IlWzLKMDHVsyflbWDBAnYHBRZKK/Z8jiXoPpb8lyFzveUd4e+WqD1wsD2MZZC1iT8iFWKHaZsSebcLb8ts5aKgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBgve4Ha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTRnfk+xncNuJMn54sP5qzAQh4gcZ4Sy3yYao6iQeYc=;
	b=fBgve4HaBONMdXGPyAQqmE5QnrszPXafnzxJMgaG57Nb1v+u2uJoZtqPIT+2gVkuqGq3H3
	57+Sd4atkSQd8sYS0Xwl4ak9sRBO1j26yjGdlEVOZC/D8O0tY6ghDl9Ahon6zNRWM8ZZ6T
	BdyszpxeymKlf9HOxjZIasRkJDWERGc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-JlplhzJMPfChmiAklxDNhQ-1; Mon, 10 Jun 2024 05:32:03 -0400
X-MC-Unique: JlplhzJMPfChmiAklxDNhQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f1ccdbf82so14868f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011922; x=1718616722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTRnfk+xncNuJMn54sP5qzAQh4gcZ4Sy3yYao6iQeYc=;
        b=dk85bLIBMeRukJNYbT9lN088cojBkVmKgnBCGy8Xc40p9RoC6Pwga01qu0SclXJhev
         gOqb0DiLjvwLDPuxAeaEabIIk07J1oQilEeAXjmpDxx3fRabLLzfArPtBmu4MeeRQ9G0
         3kNr87FA39AK+STn94Um2u8br+s4Le6cKrUGUhxBZZbsK0h5QLa101EPWQr67z89iiGr
         ay/bZT4oDpIB34miMlbU7r5QiWtxFHzf7u8FpdDdpazEsIUG+h2aKMj+5x2zH9cnxYSL
         Hi2W8VAnxsv5k1wbD6hP5LI8Ndo5GdKMPGntmaUeCfaR/iutQoJNl90g8ltKZ7UohXSC
         2KuA==
X-Forwarded-Encrypted: i=1; AJvYcCXBlXr3T0SmNrnceoyF91v5268HabJZ1fqtz9QhdsA9398fbPXIRuxC+ImXL0attdYFzBwzmqmFi/znuDD4r3ShYSpXhwbnc6TvSl0p
X-Gm-Message-State: AOJu0YzY8HFFW5JTi+2DBVw6I13eyfpJxdlmWHBFpADf1nrA2bhLvsDB
	PbmOp+Nipo3Unl0EW/FGuHAnJwmS62bo8B4ssyepyPdrr+lpCHmjq9X/Hv55E/p2zwSw7PxeQ4z
	a2OsMD9s5aBDhP9DXlZnzsM3azzMLCjxYCbR2gzZumstkhGsjjrHAr9NCDh1cTA==
X-Received: by 2002:a5d:588e:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-35efedd2e3emr6479222f8f.4.1718011921898;
        Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ34RIrsm60vplmSUHSp8HATp7AS7kEdOir9ms2KbhbicgUfnK/HnyWUyl28CP1kKuZ42sMA==
X-Received: by 2002:a5d:588e:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-35efedd2e3emr6479204f8f.4.1718011921628;
        Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v8 02/13] PCI: Add devres helpers for iomap table
Date: Mon, 10 Jun 2024 11:31:24 +0200
Message-ID: <20240610093149.20640-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcim_iomap_devres.table administrated by pcim_iomap_table() has its
entries set and unset at several places throughout devres.c using manual
iterations which are effectively code duplications.

Add pcim_add_mapping_to_legacy_table() and
pcim_remove_mapping_from_legacy_table() helper functions and use them where
possible.

Link: https://lore.kernel.org/r/20240605081605.18769-4-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
[bhelgaas: s/short bar/int bar/ for consistency]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f13edd4a3873..845d6fab0ce7 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -297,6 +297,52 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_iomap_table);
 
+/*
+ * Fill the legacy mapping-table, so that drivers using the old API can
+ * still get a BAR's mapping address through pcim_iomap_table().
+ */
+static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
+					    void __iomem *mapping, int bar)
+{
+	void __iomem **legacy_iomap_table;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return -ENOMEM;
+
+	/* The legacy mechanism doesn't allow for duplicate mappings. */
+	WARN_ON(legacy_iomap_table[bar]);
+
+	legacy_iomap_table[bar] = mapping;
+
+	return 0;
+}
+
+/*
+ * Remove a mapping. The table only contains whole-BAR mappings, so this will
+ * never interfere with ranged mappings.
+ */
+static void pcim_remove_mapping_from_legacy_table(struct pci_dev *pdev,
+						  void __iomem *addr)
+{
+	int bar;
+	void __iomem **legacy_iomap_table;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (legacy_iomap_table[bar] == addr) {
+			legacy_iomap_table[bar] = NULL;
+			return;
+		}
+	}
+}
+
 /**
  * pcim_iomap - Managed pcim_iomap()
  * @pdev: PCI device to iomap for
@@ -308,16 +354,20 @@ EXPORT_SYMBOL(pcim_iomap_table);
  */
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 {
-	void __iomem **tbl;
+	void __iomem *mapping;
 
-	BUG_ON(bar >= PCIM_IOMAP_MAX);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+	mapping = pci_iomap(pdev, bar, maxlen);
+	if (!mapping)
 		return NULL;
 
-	tbl[bar] = pci_iomap(pdev, bar, maxlen);
-	return tbl[bar];
+	if (pcim_add_mapping_to_legacy_table(pdev, mapping, bar) != 0)
+		goto err_table;
+
+	return mapping;
+
+err_table:
+	pci_iounmap(pdev, mapping);
+	return NULL;
 }
 EXPORT_SYMBOL(pcim_iomap);
 
@@ -330,20 +380,9 @@ EXPORT_SYMBOL(pcim_iomap);
  */
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 {
-	void __iomem **tbl;
-	int i;
-
 	pci_iounmap(pdev, addr);
 
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	BUG_ON(!tbl);
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (tbl[i] == addr) {
-			tbl[i] = NULL;
-			return;
-		}
-	WARN_ON(1);
+	pcim_remove_mapping_from_legacy_table(pdev, addr);
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
-- 
2.45.0


