Return-Path: <linux-kernel+bounces-371651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FA9A3DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914F9B2237B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD21BC49;
	Fri, 18 Oct 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hoJUmkG3"
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C618028
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253331; cv=none; b=Up1JCKw//7FWkHFwCol4wp7ENV3wmPudktqp9Gxt/sX8+KCJxBVT7l8AcJes8OhVt8OHxgmEddyc26Gnph6OvDTl8nHWYrMkG//NEdaTTteYA0/7R/CTwCHPof0vaYFQiWfgL0oqlDwlMLC7zIRaYgyqK4lU+CYSRi6kJojSdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253331; c=relaxed/simple;
	bh=65HBpwVDNjKN5jvOjViaIzKJTLIt46u4J0pXgLRDsGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OZM2uNr2iScN5348XyXdd7MlGVgw+DNWGHrMcTkorJN8VJeWMVqj4OCFpVPa0rBRGhnujuUpFxc1BHatiH8xGXfyxP4S3DEOQkrEl++z+Kds2ER1MlSfDKj7Uex7cBwlez5szSwH6JkL7zbbOO1A1DyjtUYiboEwXqppdkrB9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hoJUmkG3; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729253329;
	bh=ryeVHK+NdiihpE7HeTDwi8BfNT6Rq6KcBq/R3xPfg/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=hoJUmkG3wWRx2k63Y3Dw7iYA4RzXyjxY25Ggzuca7VZINUoQIw0buDyGN9bmeU37D
	 r4O5klxQ26+hSA6PWs+V7fTm33zl3xlY8On8nmtxqPKOO83ujcdVHkhmXdEA3zfvKq
	 EGmkXe4C0HInmpIzUD7jPsnUQoKb0AUFoM6NiKgl9J0C4GJ9RLHmeo+uPk3nGV9gOO
	 iqLiPjUx6iwCFh7xJAwoej0yfZRz9BjUYHbAh7w0xWvUR24yKPBtb02DrvMLsUjCEx
	 bf/Bcdx5cVuBZ4g/kReUGVytPXIy0CE9qLDX7nH+mwZoaS7S2ivSCo7mVmmTnava0Y
	 PA0MkmLTwL3TQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 0C47E2010266;
	Fri, 18 Oct 2024 12:08:44 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 18 Oct 2024 20:08:25 +0800
Subject: [PATCH v2] genirq/devres: Simplify API devm_free_irq()
 implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-devres_kernel_fix-v2-1-08918ae84982@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALhPEmcC/32NQQrCMBQFr1L+2kgSIkVX3kNKSZNX+1ETTTQop
 Xc39gAuZ+DNmykjMTIdmpkSCmeOoYLeNOQmG84Q7CuTltooqVrhURJyf0EKuPYjv4UZ9H7ATg0
 enurunlD12jx1lSfOz5g+60VRP/uvVpRQwlgrfevMCJjj48WOg9u6eKNuWZYv3a0vh7QAAAA=
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: isFtvBQk6UjQ26GJS8A3C7k-d92sWPPq
X-Proofpoint-ORIG-GUID: isFtvBQk6UjQ26GJS8A3C7k-d92sWPPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410180076
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify devm_free_irq() implementation by dedicated API devres_release()
which have below advantages than current devres_destroy() + free_irq().

It is simpler if devm_free_irq() is freeing IRQ which was ever requested
by a devm_request_irq() variant, otherwise, it can avoid the wrong and
unnecessary free_irq() as explained below:

Currently, devm_free_irq() still tries to free the IRQ by free_irq()
even if it can not find a matching devres entry within devres_destroy()
for the IQR under the othewise condition mentioned above.

So that is wrong as devm_free_irq() should only free IRQ requested by
a devm_request_irq() variant.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
linux-next tree has similar fixes as shown below:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ee4dcafda9576910559f0471a3d6891daf9ab92
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
---
Changes in v2:
- Correct commit message and make it clearer base on Thomas's proposal
- Link to v1: https://lore.kernel.org/r/20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com
---
 kernel/irq/devres.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index b3e98668f4dd..eb16a58e0322 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -141,9 +141,8 @@ void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id)
 {
 	struct irq_devres match_data = { irq, dev_id };
 
-	WARN_ON(devres_destroy(dev, devm_irq_release, devm_irq_match,
+	WARN_ON(devres_release(dev, devm_irq_release, devm_irq_match,
 			       &match_data));
-	free_irq(irq, dev_id);
 }
 EXPORT_SYMBOL(devm_free_irq);
 

---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20241017-devres_kernel_fix-4b29be51bded

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


