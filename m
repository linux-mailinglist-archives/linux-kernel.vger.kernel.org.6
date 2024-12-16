Return-Path: <linux-kernel+bounces-448251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C69F3D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F816C432
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596481D89F0;
	Mon, 16 Dec 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="gWj8WwO2"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C811D86ED
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734388321; cv=none; b=UEWLSroTlKKE5xX73lboqHruQ8BxdfGxzuAkQgdBqNSAmUC1WXHHV7OsaujeHW5Cm0BTHK3r+R/nXPCBgDQXrwqUSnKXNtXkCMfl/AvBnXR76wWbFi8vNLhwsnc6MCIYukCcn2MXX0Tq/gm+jrV/+KxKtRvOZph1RyvvEpnUcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734388321; c=relaxed/simple;
	bh=1uGIbsxoPlE08Dk2PTvQ2UKXwAtNvBQDUjn0GNOAGuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEpvWBMiaL/KzuGleC+UdWFgg+rJ9E92JnkcLNGqkfPFhLZpbZ6R1kLdR7M4Dum2jgxdbqRsD4ubADR/1Ob6ZcquFOdtUGjrOYK4Vasupy+SEq+7kNZ/1yh8K+kmjV15lKk+TewbU/yLmpGUBl6TGonxSK9p+Hbvqej60W8aKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=gWj8WwO2; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 4235F2FC005F;
	Mon, 16 Dec 2024 23:31:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734388311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sncl4e9UgPZiTF/SjSO2WBM8N+7rex7SV4V3sZMTcUg=;
	b=gWj8WwO28RuNj3eMJo0zxOnSweGuD7AbbePFXyJeLNU9YnD9URDR8OO0UY/uIXSxlvCduR
	w3Pjz1tl9mnRtFHsVeZLDicJa4J0AmD7g1HECH0OR688oxsdbaicvb29WZkBwfLE7CZFIj
	ALEPwuWyoY7NcOPqlL5fNP7XcdPmx4c=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk
Date: Mon, 16 Dec 2024 23:28:04 +0100
Message-ID: <20241216223145.135942-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216223145.135942-1-wse@tuxedocomputers.com>
References: <20241216223145.135942-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georg Gottleuber <ggo@tuxedocomputers.com>

On the TUXEDO InfinityBook Pro Gen9 Intel, a Samsung 990 Evo NVMe leads to
a high power consumption in s2idle sleep (4 watts).

This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
a lower power consumption, typically around 1.2 watts.

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c5ecbda6bd1da..f00f72d57355c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3145,6 +3145,7 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		 */
 		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
 		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
 		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
-- 
2.43.0


