Return-Path: <linux-kernel+bounces-319996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D2E9704E6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC83B2827DB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F119BBA;
	Sun,  8 Sep 2024 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qniOS4J3"
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738E33C5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725763746; cv=none; b=eqZecKTbdbi/CRIzQPJCi4f4fOFGR/KevJQJQTtQhL3PaNEkulVsAFeKVl61REnmGY0DfuRQ6lSO9cg1yTFCjnuV4rAHhWc9Hj3qAlZBV5KfioJrE4kmZA3Ak05yofKHH9r6EAQO/i2WoCWex/qFti+yyUYVZ+Vj/XpolINvnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725763746; c=relaxed/simple;
	bh=8bRPoQlegv6of45xQkgNEKc5W0ySdFnjUALq2EY7jTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RsU87hO/cKeCmBlIG6TP/vXT7os1dcPSddX3UuaJ8OAnHiwl/D+/aVA0mJ664ug5ftjKSnt1s3ZFJdadqmdy5GodliYaA+GPqdTeSkCf5+WT51GhLFlRXOe1BF8wE8Gi1TOWachGmhivw+4IZlTvogyFzkBHbb8qmO0GGSXIfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qniOS4J3; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725763744;
	bh=23t6K0AMRZ/RSIosMnKLtEhCcK6/5aP4sqpXuUZEwYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=qniOS4J3qyq0hLEHjeV1L1M9TP+GsfJV7292yw5HZWQS3uy7miUm2ngy4oj+tXND+
	 6RdjbjxT1URSt7ENQjZo0etkAc/ITJSeG5XjXJn6ApGRWNNh1aXW0DEyUtG/fBWFVC
	 nzMqY4bg+pbwMBJlYZHi3NPwKIz7Whcbu0aseWFg1xCZ+QqflpKBP0UD7LKGb16bXi
	 dSbtvIvVj4U3zts8uLA29GZPYpJGb7hMjrfZsX8+Clbc4Dzxe4gIMRdGOMwHR2wdiX
	 Q5OveZC1PBvYREh4pczDnR4ASlJ7Z690jdDFE9tthVzPWbOSXwLZs48hxCPeXZ8Fyi
	 ltb/G4LudRu3A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id A478D8E035E;
	Sun,  8 Sep 2024 02:49:01 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 08 Sep 2024 10:48:47 +0800
Subject: [PATCH] driver core: Trivially simplify ((struct device_private
 *)curr)->device->p to @curr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240908-trivial_simpli-v1-1-53e0f1363299@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAI4Q3WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwML3ZKizLLMxJz44szcgpxMXXNzI0sLk8TUNONEEyWgpoKi1LTMCrC
 B0bG1tQDKuWO5YAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: s0vlb8_vrUhjpVCpiF9fwFf0l3LTcWmc
X-Proofpoint-ORIG-GUID: s0vlb8_vrUhjpVCpiF9fwFf0l3LTcWmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_14,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409080022
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Trivially simplify ((struct device_private *)curr)->device->p to @curr
in deferred_devs_show() since both are same.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9b745ba54de1..a7cc7ff0923b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -248,7 +248,7 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 
 	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
 		seq_printf(s, "%s\t%s", dev_name(curr->device),
-			   curr->device->p->deferred_probe_reason ?: "\n");
+			   curr->deferred_probe_reason ?: "\n");
 
 	mutex_unlock(&deferred_probe_mutex);
 

---
base-commit: fea64fa04c31426eae512751e0c5342345c5741c
change-id: 20240908-trivial_simpli-772984aef3a4

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


