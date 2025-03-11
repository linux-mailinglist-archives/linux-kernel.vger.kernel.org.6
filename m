Return-Path: <linux-kernel+bounces-556628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42DA5CCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67E33AF928
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DAD262D2D;
	Tue, 11 Mar 2025 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJ236xM4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C62262D01;
	Tue, 11 Mar 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715237; cv=none; b=LRM5sRf6RV1lXR0gdMogJ5o6MsDi/wANFHDo0s+XZP4K8JBKEvn3nfBihFXHdwDC+anMVRWXKSe4VJgL7TSTRN+aYWCvHGGxTya4sBqtuFP8EMldDPsa3zIH6ePYTTJP+rs52GhUW2N6m4/n7rf+KCsXpm9MplGIa4XVd8huU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715237; c=relaxed/simple;
	bh=l//bDvKxTt9nSDAPrA6fxu4EWvJx8XcFretpSDHjdXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmifskiR19TkKwbxJls2EPEBKIE7OXLjGcRO7UkuRYmZ7FFSFe5RijVmUseVP70uQfVBUhiCutMp66UMOZsfViQiixrzUrAjWnpjPuDI/BbUpdd18fPdSi+hlXHetY533mcHqTNmP+3gn+g7NtrsLeMDw9XYN+tAFhOj9gTns5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJ236xM4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741715236; x=1773251236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l//bDvKxTt9nSDAPrA6fxu4EWvJx8XcFretpSDHjdXk=;
  b=mJ236xM4bMrtvY3WdMmrbMjP3yFb6AJlbyEGdr5GXrd0v8O80K/MKay3
   kE7ADv5bKYkIDpJLyrORq+2fTboTsUeHp5yEG6cle+A8ZcoGgOWXEhr5J
   cbl/wwHhGZQufk58f53RynMlIU7memCLbVvzKH35cd6k0eLhUvY130TR0
   G4eiSkFslyn//mcOKfnv8ui9xLhz90kv2h0oyIJHou9tS0ShvcstFDhQl
   ZtV6m0kJ7aZlq6GjTO5BJSorl/TWuNvfsa4rjl+P/epg5tD0XA/0Wqnv1
   M134Mk9g7w51bAVcJcKpVFC5a0hZI6YDToNpQkNrL4n4V7s216Qf/D0NG
   g==;
X-CSE-ConnectionGUID: B+inrb3lQESySdIP2TSwVw==
X-CSE-MsgGUID: HPbkWCrASBydfVY9j8UgNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46414980"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46414980"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:15 -0700
X-CSE-ConnectionGUID: voxJyQXpSA2u1eRYVtfGLw==
X-CSE-MsgGUID: zw9m+tTmTAmmZMgZTSN5Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125291586"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.251])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] PCI: Move resource reassignment func declarations into pci/pci.h
Date: Tue, 11 Mar 2025 19:46:59 +0200
Message-Id: <20250311174701.3586-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
References: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Neither pci_reassign_bridge_resources() nor pci_reassign_resource() is
used outside of the PCI subsystem. They seem to be naturally static
functions but since resource fitting/assignment is split between
setup-bus.c and setup-res.c, they fall into different sides of the
divide and need to be declared).

Move the declarations of pci_reassign_bridge_resources() and
pci_reassign_resource() into pci/pci.h to keep them internal to PCI
subsystem.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index be2f43c9d3b0..3e05e5506041 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -310,6 +310,8 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
+int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
+int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d788acf2686a..c629962f4ccd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1396,7 +1396,6 @@ void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
-int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 void pci_release_resource(struct pci_dev *dev, int resno);
 static inline int pci_rebar_bytes_to_size(u64 bytes)
 {
@@ -1476,7 +1475,6 @@ void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
-int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_assign_irq(struct pci_dev *dev);
 struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res);
-- 
2.39.5


