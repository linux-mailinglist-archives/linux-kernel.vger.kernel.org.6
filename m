Return-Path: <linux-kernel+bounces-201971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE48FC601
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681C0B2712D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED7192B6F;
	Wed,  5 Jun 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmsfHn8c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B819006D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575411; cv=none; b=MEFoXqHPc81jr704aeQh999fFTqNx7jSwKBfQZdKP/00xaRNcWyeweb0hghQk57VFD2K4dDaSDlozZBjbWXclf0diDP4JMPdSDXZG5PSJ8yu1qHeGXL63U/jb5FsfvLuz27UCicc6H1GAhBtRBdmAvTHdoE412SlFnPV1RO1XcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575411; c=relaxed/simple;
	bh=bCBZE66HS4MGevuCEuGbllziHVNkZUwOrdLYjEkBs5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALu/mU5Np+GWPv1mo/1W6LzlzPak2DrTKKhr1lj1uMXe1ueab9L3VB5lDm/qlQE3tuEpJomnM8hrsh/4g1D3hLFASiNWqU1+R3nhc2707M15k0WLDAB6ZgwyqGW67jgsKGwb1lbH7/qBiHdWxiC1IUyWCpNJ9+r/yZFufdfOUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmsfHn8c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQF/RRtq2M1mXHCVQZRIWcpncx1S//L9Tm5LTcwCt7g=;
	b=KmsfHn8c6eauuEhh2mbN2kph4i+AvisbLPX8RKMIqLBhoptlrK6+3Jbvb+gKRoADzlrFDV
	NlU8ga2ciTn/ONy5+4lqJawLZS8kpuzXu+JZ7QTVV9eR3/RfnnPSinxcjfbqvN0wYYe0IX
	x3O6zrZgEHkKjOoKXBzLK0qhGzAKF2E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-gpZ_iZtZOpWJ_WrPemMXnQ-1; Wed, 05 Jun 2024 04:16:42 -0400
X-MC-Unique: gpZ_iZtZOpWJ_WrPemMXnQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-579ca673b43so269134a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575401; x=1718180201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQF/RRtq2M1mXHCVQZRIWcpncx1S//L9Tm5LTcwCt7g=;
        b=b1xLe/dwqv27ikURg4glt35FvGkqc3vssviOL13shpVBmYs8E2P+h/qmaVbmBod16X
         qM3LA/PprahLgPCUGn+mUziGKjSzM0hAMr9beLRbozZ6j2aLuS1BEgDYJSyqdAEn2B1+
         XJF6VVExooNLb93fHMNDm9L4Z7azYreFCFAagzeIx1X9L4+D6El8PFTrG2ev6jxvNagL
         RqKuyE7Jj2dZI6vAANeRjL9+GeEhuZcy1D/NhV93GLw+6xL6POFwAkfrhMPw8Iqa6wzk
         jfbUPdFkUP9ztw+pd4oahODKtbXI1VVII1EBTsmMowtRqR2WXNgBIXbW0MEqtxGuMXQf
         3ExQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNPRUwj9GV5DNo/m7hgpPCrpNQYrmMGNbPkRGL1ZxZJC5NOcjg/MjYmfXf06HV76GBursBZE8vAXSMhIZPnL6QcYWDMKJEvbvejy/W
X-Gm-Message-State: AOJu0YyX6c/pp/5FnA72oo88kQpYiKzx+LhjliDwvWFDL2MH5X8uwL+P
	L9otlAJdFwzAKcQvfExVQ/FNG4Jt5HlBHhJYUqimT7/8yNl8AYwhxydeIBITDv9PFMLx0mvGsxt
	A3voM3c4WaNMwHtwKsO5KHWT0APDLOmy6q+a+P9+3TWAfjrLdhvppr7YDWO6zWg==
X-Received: by 2002:a50:aa93:0:b0:57a:79c2:e9cc with SMTP id 4fb4d7f45d1cf-57a8bcb4bdbmr1299556a12.3.1717575400837;
        Wed, 05 Jun 2024 01:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnDWsmeGVuf2mez79IRf+VouIvlEPmoOV19RR5wEUe4IIflrHEB7JVXR7OyM17+DSycTI2BQ==
X-Received: by 2002:a5d:62c4:0:b0:358:a09:2677 with SMTP id ffacd0b85a97d-35e84046ff8mr1214838f8f.2.1717575380210;
        Wed, 05 Jun 2024 01:16:20 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:19 -0700 (PDT)
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
Subject: [PATCH v7 04/13] PCI: Deprecate two surplus devres functions
Date: Wed,  5 Jun 2024 10:15:56 +0200
Message-ID: <20240605081605.18769-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() should not be used anymore because it contributed to
the PCI devres API being designed contrary to devres's design goals.

pcim_iomap_regions_request_all() is a surplus, complicated function
that can easily be replaced by using a pcim_* request function in
combination with a pcim_* mapping function.

Mark pcim_iomap_table() and pcim_iomap_regions_request_all() as
deprecated in the function documentation.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e6e791c9db6e..f199f610ae51 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -501,7 +501,7 @@ static void pcim_iomap_release(struct device *gendev, void *res)
 }
 
 /**
- * pcim_iomap_table - access iomap allocation table
+ * pcim_iomap_table - access iomap allocation table (DEPRECATED)
  * @pdev: PCI device to access iomap table for
  *
  * Returns:
@@ -515,6 +515,11 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * This function might sleep when the table is first allocated but can
  * be safely called without context and guaranteed to succeed once
  * allocated.
+ *
+ * This function is DEPRECATED. Do not use it in new code. Instead, obtain a
+ * mapping's address directly from one of the pcim_* mapping functions. For
+ * example:
+ * void __iomem *mappy = pcim_iomap(pdev, barnr, length);
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 {
@@ -886,7 +891,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 }
 
 /**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
  * @name: Name associated with the requests
@@ -897,6 +902,9 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
  *
  * To release these resources manually, call pcim_release_region() for the
  * regions and pcim_iounmap() for the mappings.
+ *
+ * This function is DEPRECATED. Don't use it in new code. Instead, use one of the
+ * pcim_* region request functions in combination with a pcim_* mapping function.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
-- 
2.45.0


