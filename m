Return-Path: <linux-kernel+bounces-225724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DEB91346F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA35B2313C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F516F8ED;
	Sat, 22 Jun 2024 14:23:38 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0814B965;
	Sat, 22 Jun 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719066218; cv=none; b=pGI1ABDg3IpVgULUdM42UGQ/zb+bkeXSEr17SdLVCF0E3cg0bQnQTqe7hKfcCAeCEp8Wcr2jE66a6q7cxN6r1WVz7T0SqtORYCuSyCDKAcoh8X+uZfdDY5EwX8sMkHR+wtONTJ/4fne4MakpGycGx4vDNKByQRF8kYHGncrr4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719066218; c=relaxed/simple;
	bh=6RRg/nOTb67RkzxMaWSRqqe+Hwc0N6oaElgH4k+aOuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUEVstAUyLbrKeiVqea4e9YxkGHO2zcaR46zkwPJOO4uPf3vtrTk7ZQ48h/ni7IlPbc5nB/lvy5Q2tfiU16tj+Sgj6Io1V2usRtyqyfaXFmy1q6ILJuxy6l9Z8JficSWeoWo3uGst+CWukv33YSpHCDltYeRGA6RNJmh/7KBkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACnrr5V3nZm3ZLZEQ--.44139S2;
	Sat, 22 Jun 2024 22:23:22 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de,
	make24@iscas.ac.cn
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: r8a66597-udc: validate endpoint index for r8a66597 udc
Date: Sat, 22 Jun 2024 22:23:08 +0800
Message-Id: <20240622142308.1929531-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrr5V3nZm3ZLZEQ--.44139S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkWr4xCFW5AFWrZF43Wrg_yoW8Cw4rpF
	WDGayrKF12yry8CrW8ta98ZF1Yka9akrZFkFZxtw1a9FnrJr98Aw1UtF1xKr4DtFW8ZFsa
	gF1rtwsxKwn8ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUGVWUWwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq-e
	rUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..93fc4201c0ae 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1173,7 +1173,11 @@ __acquires(r8a66597->lock)
 		status = 0;
 		break;
 	case USB_RECIP_ENDPOINT:
-		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		int pipe = w_index & USB_ENDPOINT_NUMBER_MASK;
+
+		if (pipe >= USB_MAX_ENDPOINTS)
+			break;
+		ep = r8a66597->epaddr2ep[pipe];
 		pid = control_reg_get_pid(r8a66597, ep->pipenum);
 		if (pid == PID_STALL)
 			status = 1 << USB_ENDPOINT_HALT;
@@ -1208,8 +1212,11 @@ static void clear_feature(struct r8a66597 *r8a66597,
 		struct r8a66597_ep *ep;
 		struct r8a66597_request *req;
 		u16 w_index = le16_to_cpu(ctrl->wIndex);
+		int pipe = w_index & USB_ENDPOINT_NUMBER_MASK;
 
-		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (pipe >= USB_MAX_ENDPOINTS)
+			break;
+		ep = r8a66597->epaddr2ep[pipe];
 		if (!ep->wedge) {
 			pipe_stop(r8a66597, ep->pipenum);
 			control_reg_sqclr(r8a66597, ep->pipenum);
@@ -1268,8 +1275,11 @@ static void set_feature(struct r8a66597 *r8a66597, struct usb_ctrlrequest *ctrl)
 	case USB_RECIP_ENDPOINT: {
 		struct r8a66597_ep *ep;
 		u16 w_index = le16_to_cpu(ctrl->wIndex);
+		int pipe = w_index & USB_ENDPOINT_NUMBER_MASK;
 
-		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (pipe >= USB_MAX_ENDPOINTS)
+			break;
+		ep = r8a66597->epaddr2ep[pipe];
 		pipe_stall(r8a66597, ep->pipenum);
 
 		control_end(r8a66597, 1);
-- 
2.25.1


