Return-Path: <linux-kernel+bounces-415308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381CE9D3429
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5E12838CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626B15990C;
	Wed, 20 Nov 2024 07:33:28 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87515533F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088008; cv=none; b=tSK2OOt5TBIV2NOm7NnYJ55vD7FrnMFDQtb0kW9lzcOkYlk+uRGaDDZKbdyyHTf3e7UJsJiZl7E0b5U+8AWeJ7xNkr/ku0SmZCRZ9cZiq7sJ5ox/FTpnZ7OBZ9qOSqM3ce2zcOAzh9yXVYsjhpXGiWPvP0Bfd3xrpqnhcSpoQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088008; c=relaxed/simple;
	bh=KL2avKrEhHAjiKIIhbAif+PymrYZOFuFoHbTsarkpeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vhvf2lvbwo5R7cuDh/v7YnLyNw8IgVcOFwxUdVlJOBeJs+1txLNu6IrCJEHFNT1SXBq8GHcQTKrM9euzBCDF5O8QB9abmeT1uaXDTP60O8iK802GzzoCXSbUzfMDW0w9snM8sm/ip7kmM009j+yBXfcXNSFonxqcb5ldJgr6rcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9673d90be26d-59283;
	Wed, 20 Nov 2024 15:33:19 +0800 (CST)
X-RM-TRANSID:2ee9673d90be26d-59283
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673d90bfab1-6e2d0;
	Wed, 20 Nov 2024 15:33:19 +0800 (CST)
X-RM-TRANSID:2ee1673d90bfab1-6e2d0
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: mst@redhat.com
Cc: david@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] virtio_balloon: Use outer variable 'page'
Date: Wed, 20 Nov 2024 13:49:20 +0800
Message-Id: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

There is no need to define a local variable 'page',
just use outer variable 'page'.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b36d2803674e..89da052f4f68 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -251,7 +251,7 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 
 	for (num_pfns = 0; num_pfns < num;
 	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+		page = balloon_page_alloc();
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
-- 
2.33.0




