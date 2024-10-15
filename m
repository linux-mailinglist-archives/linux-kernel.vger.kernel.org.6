Return-Path: <linux-kernel+bounces-365568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92999E478
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D04283F29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D71E3DF1;
	Tue, 15 Oct 2024 10:47:33 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC81C7608
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989253; cv=none; b=Fgo0LAkOPXFaeYvbOztRwFiRen12PJ4bb9aoFWK3mxyccMsyS8U1kbEEVOL2aK6PVRwn18UNme26lPcKxCgnU32U455rFkmuIfFOvwnhAlp13sEQy1V0MrUzZQcSRVeKqTcqEw6bbPPy2JOSoltTO/p8HEp7z5sUMhogJNE2pV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989253; c=relaxed/simple;
	bh=umAoHZaLg8OL5sN8+MqwYrOLLhFk3DJGmdHe+GY/UiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EqOk2TvJFy3GSiUHyCOwFXOjxUbDnXLCkOxmgttp0DUvbrbU63REUmbr9SQm+KbI8ie6dp/SrYZogRfdKNOpF1QhDsH09i/fGp/rIrxutCIAe7HosYohTofud0w5erJTdexHv1wVOW5qGPKB6iZ6xmEqK5HeJA7fclm0fTdLRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2f01:8211:4b4e:86e2])
	by michel.telenet-ops.be with cmsmtp
	id QanN2D00G4yGcJj06anNtu; Tue, 15 Oct 2024 12:47:22 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t0f53-003nsb-9h;
	Tue, 15 Oct 2024 12:47:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t0f5G-004mAF-Bs;
	Tue, 15 Oct 2024 12:47:22 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob@rox.of.borg,
	Herring@rox.of.borg,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: Constify dummy pci_register_io_range() fwnode_handle
Date: Tue, 15 Oct 2024 12:47:20 +0200
Message-Id: <6a3ae390e2a978ec452ecbce3082cf51f7ee3076.1728989210.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_PCI=n:

    drivers/of/address.c: In function ‘of_pci_range_to_resource’:
    drivers/of/address.c:247:45: error: passing argument 1 of ‘pci_register_io_range’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      247 |                 err = pci_register_io_range(&np->fwnode, range->cpu_addr,
	  |                                             ^~~~~~~~~~~
    In file included from drivers/of/address.c:12:
    include/linux/pci.h:2022:63: note: expected ‘struct fwnode_handle *’ but argument is of type ‘const struct fwnode_handle *’
     2022 | static inline int pci_register_io_range(struct fwnode_handle *fwnode,
	  |                                         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~

Fixes: 6ad99a07e6d2ed91 ("PCI: Constify pci_register_io_range() fwnode_handle")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11421ae5c5586443..733ff6570e2d5544 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2019,7 +2019,7 @@ static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 { return -EIO; }
 static inline void pci_release_regions(struct pci_dev *dev) { }
 
-static inline int pci_register_io_range(struct fwnode_handle *fwnode,
+static inline int pci_register_io_range(const struct fwnode_handle *fwnode,
 					phys_addr_t addr, resource_size_t size)
 { return -EINVAL; }
 
-- 
2.34.1


