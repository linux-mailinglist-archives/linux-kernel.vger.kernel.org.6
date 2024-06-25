Return-Path: <linux-kernel+bounces-228181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB76915BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511A71F21FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70629428;
	Tue, 25 Jun 2024 02:04:10 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AA101D5;
	Tue, 25 Jun 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281049; cv=none; b=FBJQUP+vB92KSQt3AVc7UjoSQYswrwN8J+IVnECaadh4P1PNXJDHKH6YZ/TvpxIat2mPB68KyI2Rf3L7/dHvI+A2Fxoos/tPZoQgY7wa9AuRBLNFzSgu6IHzdputZKL9P7uTXwxitCrvvD24PMY+aH0PcJjxq7ewk2OQXBeJayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281049; c=relaxed/simple;
	bh=EEDCAWWAMrsn5ELWPNy29DPWUfY1dnkpvyxXL4Jl0Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QpBfrZGZPE9CcGJJRdVMqs60lJtimFYSfdLutusNeuu27tlaMVdsO9AlXMgcambeU/PbbbU7lv/B1fNem5B4vil6ktmptXpWPd0lHZ5PznSBeK6wRwxxE9u3xbeWrYFYHfySF3FyUuB2UTQHliDGbBLfI/ybwK25boN7TNe+Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowADX3BhwJXpmUTqVDA--.2757S2;
	Tue, 25 Jun 2024 10:03:44 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: neal_liu@aspeedtech.com,
	gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH v3] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Date: Tue, 25 Jun 2024 10:03:26 +0800
Message-Id: <20240625020326.2564860-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADX3BhwJXpmUTqVDA--.2757S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFy7urW8Xr18Wr4kuF17Jrb_yoWDCrbE9a
	y8ursxur17Ka92qr1UZ3Waqry29a4kW3WDuF1Dtr9xAryUJFWxJr1kWrWkt3y5ZF47urZx
	u3yDKw13ZryaqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_JrC_JFWl1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5qeHPUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

From: Ma Ke <make_ruc2021@163.com>

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Found by static analysis.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v3:
- added the changelog as suggested.
Changes in v2:
- use correct macro-defined constants as suggested;
- explain the method for finding and testing vulnearabilities.
---
 drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 3916c8e2ba01..d972ef4644bc 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
 		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (epnum >= AST_UDC_NUM_ENDPOINTS)
+			goto stall;
 		status = udc->ep[epnum].stopped;
 		break;
 	default:
-- 
2.25.1


