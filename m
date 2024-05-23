Return-Path: <linux-kernel+bounces-187305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C318CCFEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44E62840DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9F13DDB8;
	Thu, 23 May 2024 10:05:29 +0000 (UTC)
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CA54FA9;
	Thu, 23 May 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.240.192.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458729; cv=none; b=HyaaV70CIqHtlqjc71L4YQgsetfytkEEk+h29XHieJXHMBTjU+4KpU6v5krJBAxTIkiZg/J9jljwa3Nxngn1K3ci25hqOmuAKtLqEkpYVGyrRedyDvl1ErB7CAzFoY5XryT/fXt0tZllRbQgXrpenvICf2oTp9ftgu0249zASgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458729; c=relaxed/simple;
	bh=TVULNsPOp0MUxGLrhYYex7VZrXDsn6a1Lrdw1F8dmQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ll3o/ynoTF8c7ZY7KxkhyAnFbjoIJOf+Yf2jAChHFz/16VuJvp8xWXaqsK9DlJfEaMQgOdZ+y3TtUuUIFhYpmVNRvIRgS9bQm7uCo+ugJcNxXRPblMgCTKm6WsdHVcE3Ix1mNTzKp7DlzSGRcaimbbRYPhzJKVPSraNOr7ev318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com; spf=pass smtp.mailfrom=siengine.com; arc=none smtp.client-ip=43.240.192.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siengine.com
Received: from mail03.siengine.com (localhost [127.0.0.2] (may be forged))
	by mail03.siengine.com with ESMTP id 44NA3ffa073193;
	Thu, 23 May 2024 18:03:41 +0800 (+08)
	(envelope-from hongchi.peng@siengine.com)
Received: from dsgsiengine01 ([10.8.1.61])
	by mail03.siengine.com with ESMTPS id 44NA3HPr073142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 23 May 2024 18:03:17 +0800 (+08)
	(envelope-from hongchi.peng@siengine.com)
Received: from SEEXMB04-2019.siengine.com (SEEXMB04-2019.siengine.com [10.8.1.34])
	by dsgsiengine01 (SkyGuard) with ESMTPS id 4VlNz801Cvz7ZMhX;
	Thu, 23 May 2024 18:03:15 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB04-2019.siengine.com (10.8.1.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 23 May 2024 18:03:15 +0800
Received: from localhost (10.12.10.38) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.1544.11 via Frontend
 Transport; Thu, 23 May 2024 18:03:15 +0800
From: Peng Hongchi <hongchi.peng@siengine.com>
To: <hminas@synopsys.com>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hongchi.peng@siengine.com>
Subject: [PATCH] usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled
Date: Thu, 23 May 2024 18:03:15 +0800
Message-ID: <20240523100315.7226-1-hongchi.peng@siengine.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail03.siengine.com 44NA3ffa073193

When using dma_map_sg() to map the scatterlist with iommu enabled,
the entries in the scatterlist can be mergerd into less but longer
entries in the function __finalise_sg(). So that the number of
valid mapped entries is actually smaller than ureq->num_reqs,and
there are still some invalid entries in the scatterlist with
dma_addr=0xffffffff and len=0. Writing these invalid sg entries
into the dma_desc can cause a data transmission error.

The function dma_map_sg() returns the number of valid map entries
and the return value is assigned to usb_request::num_mapped_sgs in
function usb_gadget_map_request_by_dev(). So that just write valid
mapped entries into dma_desc according to the usb_request::num_mapped_sgs,
and set the IOC bit if it's the last valid mapped entry.

This patch poses no risk to no-iommu situation, cause
ureq->num_mapped_sgs equals ureq->num_sgs while using dma_direct_map_sg()
to map the scatterlist whith iommu disabled.

Signed-off-by: Peng Hongchi <hongchi.peng@siengine.com>
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 74ac79abd8f3..e7bf9cc635be 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -885,10 +885,10 @@ static void dwc2_gadget_config_nonisoc_xfer_ddma(struct dwc2_hsotg_ep *hs_ep,
 	}
 
 	/* DMA sg buffer */
-	for_each_sg(ureq->sg, sg, ureq->num_sgs, i) {
+	for_each_sg(ureq->sg, sg, ureq->num_mapped_sgs, i) {
 		dwc2_gadget_fill_nonisoc_xfer_ddma_one(hs_ep, &desc,
 			sg_dma_address(sg) + sg->offset, sg_dma_len(sg),
-			sg_is_last(sg));
+			(i == (ureq->num_mapped_sgs - 1)));
 		desc_count += hs_ep->desc_count;
 	}
 
-- 
2.34.1


