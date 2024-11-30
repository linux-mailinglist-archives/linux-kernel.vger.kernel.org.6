Return-Path: <linux-kernel+bounces-426081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FFC9DEE94
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 03:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298CAB215C3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367743ACB;
	Sat, 30 Nov 2024 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OxPQHmZp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AE156CA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732933458; cv=none; b=NsSmsm1IMGuwAgBgz+U3J+Emu/5nkhwD78tWn6/yZDsqY2lq5WUHMGf0uxy3yaRFIdL3uOFM7lUunmoSWGHilvVhpLnhgvZCtqyVItyKIreFA0vmIg9S19iJpxvROztqkn+8mn2vUhxBDDADesjYwwTi9kVGR0YvqSQhXG143fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732933458; c=relaxed/simple;
	bh=tku7xzRwOLC9Dkm7sTV6vM/mwHHI3xglkq5pCdaHVGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHhpW59KntD7YS7V5IHGbWMrBCYrDb17t1V7Xu9jY7wtfyPvWQ4Q047pLxu7r7B3TxqBVDC9fxXSs2v/FFzFJbl7O9bXQIP3btlhH8cAIUZU6k9piel16eNNNS9KlxTwN/ZGWgZTvlnn3JDNxH+kCMpjMrMtUGxBdzBxk4IhYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OxPQHmZp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yZyp0ILoEYAPuICM2gNAI86wuJEf0mHY3eh4LeCdpT4=; b=OxPQHmZpxU1pFF4Q241LAGXIeq
	/P8v/8DTi20+02MkuY6clxxfY7FpC12mm5XjLpgftKP6bRG4HPtWahJRHotIVQm9HGVEBM6xRPRrU
	0i3CI8fD+Sz4R5Gdqq1fnTOFp1Knk4SsVxqZpGq5dGoMnCB/QEgYopxAddPf/Fv6LYnl3I01oO2kN
	RH7EEOZz5lYL135hgqdWmx8wEHb/1rhXrBL4+8W+sDdRz49Jkp4rFowO52xn4fhyXdKYlg/Onpzdu
	DlNNFSmxooLndpNHrMc5sbzS5WHCqpJ2xsQ911Oyb8CvKF6s2DLVZmGUl/dBYrmmyzOvKTzdATwhg
	p5tmEliA==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tHD9X-00000001J8P-1jw8;
	Sat, 30 Nov 2024 02:24:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scatterlist: fix incorrect func name in kernel-doc
Date: Fri, 29 Nov 2024 18:24:06 -0800
Message-ID: <20241130022406.537973-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a kernel-doc warning by making the kernel-doc function description
match the function name:

include/linux/scatterlist.h:323: warning: expecting prototype for sg_unmark_bus_address(). Prototype was for sg_dma_unmark_bus_address() instead

Fixes: 42399301203e ("lib/scatterlist: add flag for indicating P2PDMA segments in an SGL")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/scatterlist.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20241125.orig/include/linux/scatterlist.h
+++ linux-next-20241125/include/linux/scatterlist.h
@@ -313,7 +313,7 @@ static inline void sg_dma_mark_bus_addre
 }
 
 /**
- * sg_unmark_bus_address - Unmark the scatterlist entry as a bus address
+ * sg_dma_unmark_bus_address - Unmark the scatterlist entry as a bus address
  * @sg:		 SG entry
  *
  * Description:

