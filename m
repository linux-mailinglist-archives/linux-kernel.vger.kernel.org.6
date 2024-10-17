Return-Path: <linux-kernel+bounces-370037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDB9A2640
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA3B1C217B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F014B1DE4DF;
	Thu, 17 Oct 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bekfGzNy"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823E111AD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178191; cv=none; b=Uf5XcMDUhZmmqYkti2YwPno5R6F+MGGCtgU3UAJ6TW+hrJC2C6SGiqs08fxWThEdlQM7zgLqlrn2S75lEeHYf//lsEWvpawOoGLTdHPsZKVRZH3TxapwfGB4VbMfzIVxf/WZYy7iwD7QjgMEUJvTfVcClyLtn3GmObt7tr2+SQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178191; c=relaxed/simple;
	bh=0jrxNKr44EWevwzYZOe3obIVtjx6gJzr3afqa3w3+Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aETzCqTVAAWHP6gAleZ0s8uWa1EXBGBv+dsqRgoK5woixHHDywot9nu21gDJcZUqISjH3oQW5m9baWTszrg2cBQLrXeM+KbiapqKNxZH2bWl2JgMAColLowEdo+UEM2eMr4jtMY9npvrPudedalAnjrbN7VppJY+iHbFOoerndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bekfGzNy; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729178186;
	bh=/VqUV/PfUOYudG6pKRJp2s/oZtsw+8LT2DuRdKOIijc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=bekfGzNy1/tGjsE3l9BalKF5SO/D/4tJm2XZU/DhNP5hWjVvrdhNcRXYiDYSV0mNL
	 9++quD75K0rZIOlNC6lAVUmo3NKt4wgWcTmx0rhTKpz7GgpkuX3/zI2v6g5MatKl5L
	 mdPkJr5hp33zMfZg+qxuKK8uKLQgNCt6UOjaLQEYM6ggHm0iWMeH0/yZ06iILM4/Vp
	 CGa4jyFv/jI6RwkfUQP/FzgM+UOudo6mcW4b3d14OxTKxxOyMbDgfifdYAEPLXdUCh
	 pibcMjz/r4AMZyOufSFy7DAN8jbq9mHvVBr4OgKEgcD5EA6LCa3RfpZ4JTcSliPf+V
	 2iBGHTEM54zlw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 567DB1803C8;
	Thu, 17 Oct 2024 15:16:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 17 Oct 2024 23:16:01 +0800
Subject: [PATCH] genirq/devres: Simplify API devm_free_irq() implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADEqEWcC/x2M4QpAMBRGX0X3t9W2JvEqksw+3Gh0V1Ly7paf5
 9Q5DyUII1FbPCS4OPERM5iyoGkd4wLFITNZbZ3RplYBlyANGyRiH2a+lfO28aiMDwiUu1OQ9f/
 s+vf9AFA12bpjAAAA
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 4tSlSpHvjZP-CPzrJEYbXsdgrTqqJtdg
X-Proofpoint-GUID: 4tSlSpHvjZP-CPzrJEYbXsdgrTqqJtdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=954 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410170105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify devm_free_irq() implementation by dedicated API devres_release()
which have below advantages than current devres_destroy() + free_irq().

It is simpler if devm_free_irq() is undoing what any devm_request_irq()
variant did, otherwise, it can avoid wrong and undesired free_irq().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
linux-next tree has similar fixes as shown below:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ee4dcafda9576910559f0471a3d6891daf9ab92
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
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


