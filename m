Return-Path: <linux-kernel+bounces-228190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA8915C24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05AA282889
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE73EA90;
	Tue, 25 Jun 2024 02:23:24 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4711CBD;
	Tue, 25 Jun 2024 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282204; cv=none; b=RX1l3n5jj6BwoCa8Z2pFRPo5Z8Iek3bCawoR+yX6sFBjmsPSWVDV3aXEYTwZV+qZOMpujCBXB/84/be2P3LIweI8qiqfO499bfDL4JSMVopP4dy1qvoizABg8yzAEjAR4QnWF0Fjh1FBH0/PzNtMHmMiYQJSJ03qCMGoAf2h3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282204; c=relaxed/simple;
	bh=4UpCrjjjbQ+LdgDNQ0X571/f69DZUSE+73A8EjlmRzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HkPTmXxwRpQOoG8nrxhSBVdJHrPkNbvA10mzOLXWLdrDMMDgMVhkjaKba+Cto5k9h0q6GKTS19Dky1adP1rQqCIY1Hf40lX1QqKbnxv/DD2pLCnE6oLzwavxUiLmJH9ggrjFNeRUHteIENK2C0S9oW3+bpdr0ENEPA6h/xyTCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAC3vhIMKnpmXuiVDA--.13743S2;
	Tue, 25 Jun 2024 10:23:10 +0800 (CST)
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
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Date: Tue, 25 Jun 2024 10:23:06 +0800
Message-Id: <20240625022306.2568122-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3vhIMKnpmXuiVDA--.13743S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFy7urW5GFW7Kr4rtF1DWrg_yoWDKFXE9a
	48ursxuw17KayI9r1UZ3W3Xr1j9a4kW3WDuF1DtFyay34UXF47XrykWrW8ta15ZFW7uF9x
	C398Kw13u34aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAku
	cUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Found by static analysis.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- used a consistent email address to send patches, sorry for my negligence.
Changes in v3:
- added the changelog as suggested.
Changes in v2:
- used the correct macro-defined constants as suggested;
- explained the method for finding and testing vulnerabilities.
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


