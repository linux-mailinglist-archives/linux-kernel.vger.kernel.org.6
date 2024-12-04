Return-Path: <linux-kernel+bounces-430871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0D9E36B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD87281062
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216A1B3945;
	Wed,  4 Dec 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ERHyhezw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C71B3956
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304712; cv=none; b=JWzDhhnVJ3JLoOuxvVyhyrjweVC7MouLfLN+y9b15RkjssKveG7IqLTvIKSVwlae/X42y2Xm5u9aGbUZioWBZsuCUdkRW0r4MaeOz/pYB8KFRu2q/SEX9I9FOZ8wVXGxXvdw2ouH+A8On84nSgPYsInrw9KpL4/RiYqg9waoDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304712; c=relaxed/simple;
	bh=3gLGxW2HVXpkPQ5AFOvirBqMHKf9n4CAMSQ7dIjYRdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exeu+JTsQhc2+fS8UAF7twr74WsD5fsi7w/qNFBaMFNpV6lP/tUguEMeSiZjPrlmdenVk+/KAQ7wbtaf6xri60XNFLLUJviAtrhZEpa9iQrCK/tLNh+lrYpaYXHZdT+DoxzsTBJCrZw76b4P8cNySxDTdscAbn2S4aaENu1+DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ERHyhezw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80E4A4D4;
	Wed,  4 Dec 2024 10:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304674;
	bh=3gLGxW2HVXpkPQ5AFOvirBqMHKf9n4CAMSQ7dIjYRdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ERHyhezwQJQSY6qmbamAteHL38TD59NbuSoPylS+hX0amw7ud1DENxnW669cRcxOY
	 xJ4AZUV5/KdKiYxE6h5sLIVymbD8Q3JeMJBFP7XB4fNoON/pMbNHYaMMNO5wN1/9WA
	 6U6rJhOQCJCjr+yDdtrtDYmLleby8B19RCMDW6yc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:10 +0200
Subject: [PATCH 10/10] drm: xlnx: zynqmp: Fix max dma segment size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-10-0bf2c5147db1@ideasonboard.com>
References: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
In-Reply-To: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=764;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3gLGxW2HVXpkPQ5AFOvirBqMHKf9n4CAMSQ7dIjYRdc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCF0ZBts/F3Q3/nmyZ3acCAUk/Z9QNIzpazk9
 2p+d0+xOBqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhdAAKCRD6PaqMvJYe
 9dTzD/4264e5H9nuI6cbErkz9dOv3nzTmuYcoJ/vwyiVHnu3c8oBYbQVe/fwBR7vsyAptznjqaW
 m2MydIEztef4OKL/JdUmXfogn29iHkdT8G40q85rHxFRNX3yhMFgWt/MfYtMUcx1WPHGO8sNmVi
 UZ+uT3uBqd43EHBnRW1k9xVXgRryZrZqlGza0o1kAARG27GW4k309oIT9TpzhIhkbGSFy6T+5y5
 zCyJQ/fpr5YJ2P4j4lcQ1xfx+0bOMOwRdPOeSBNn5JmBcBAe/eZIyi3torKvRNJrDNROqucq/fb
 80wub34XYvF4GGjxiTd3v25ZHN51SGczWZEDmVYp34o13Gq1kmq+98ReAU9FO/+OQvsjZpXQijH
 YROOL8y00upWzXM3eqtRZLJ2OeE/Rsas1BjUqy8ikJLR2dXErDrLZs+FN2nykdRU3eKUwX/liBw
 3KcpQsL6cyKruROnYb0uGBQACBom+mJO1Ot8/c8M3vlM1/AQldZlP7YZK4+Muwo6xGHcBufYyJW
 xVrhvgw+Kq47O8Au+Dd5iY+dlmGMBRQl1DGU9T/MRdZgnm4U8eCU8M7usEyCxvC7Jo4Bj/VLE5j
 FE1lLM7dVNEpOoOkVbI26XvBZ+mBRJt+jVPr9RpFppcMTFYpXWPG3KE4w0gW+L9EPNbswnojw2e
 S3M31bU/5fkpoLg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Fix "mapping sg segment longer than device claims to support" warning by
setting the max segment size.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index f5781939de9c..a25b22238e3d 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -231,6 +231,8 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+
 	/* Try the reserved memory. Proceed if there's none. */
 	of_reserved_mem_device_init(&pdev->dev);
 

-- 
2.43.0


