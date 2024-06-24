Return-Path: <linux-kernel+bounces-226548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7787914037
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734FA28200B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF94A2D;
	Mon, 24 Jun 2024 01:53:45 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797731FB4;
	Mon, 24 Jun 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194024; cv=none; b=V+uPzAIQOdoeASdzYyW101E/QmZTjP3bikknoBieZSiJrdr7YN4YQW2AUy61C23tqRm7Rlj1zjD2JlkQm7SHhGZE7mbknmLy4MPFhL9D55D1s3jA3j19ktzxjZ5X1HqLvmBzzulROFujYOCet6bkeavvXZMG3DYO5gq11iqLrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194024; c=relaxed/simple;
	bh=K6oB4d1ujtoE/u8JVRWTpboTeLjD99YXt/R34wojgWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Njd8o+dkIOzc9r0SRtzNahscEUyRxWmoRxifBKpz14rl+tdZWA0tCQKvlGbCn7fdSHQmSW9VUNcLEfSFL0Wpss+vOuFTfYcRwSA3Ujv8J7qOieHFs2At0X7FyfkfQe6fhPBq4M7F1fYTBTvlC9sJod6T0b+29UMBRWJt1kajgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnrpqL0XhmqEYjEg--.64990S2;
	Mon, 24 Jun 2024 09:53:22 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: neal_liu@aspeedtech.com,
	gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Date: Mon, 24 Jun 2024 09:53:13 +0800
Message-Id: <20240624015314.2249128-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrpqL0XhmqEYjEg--.64990S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFy7urW5GFW3Zw1UJr4xWFg_yoW3ZrcE93
	WUur43Wr12g3yIqr1UZ34a9ry29a4kW3WkuF1DtryayFyUXa4xZw18WrWkJw4UZF47uF9x
	C3yDK343C34FqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOlksUU
	UUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Found by static analysis.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
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


