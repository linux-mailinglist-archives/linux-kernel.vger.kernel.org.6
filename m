Return-Path: <linux-kernel+bounces-531320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCDA43EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C791885C62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916AE25A322;
	Tue, 25 Feb 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MJPtBUFK"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96625A2DB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485566; cv=none; b=jhXHQnwqvlH4gSiatrN9b5Xbp3IVXmZU2x+sdlERBZab3FnT9wX3425UtjcodOXSY+QFypt5gL23XD/XI2NcYmmpiXC9CBqm1h4OiuTDTewR79sbz2u03cM9vy7WVAyS65M3OdB9eZuGY1637z1KcuiIMSe5q4azJOtjmdLvwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485566; c=relaxed/simple;
	bh=y+DSh+B4Ia7eVns6epgZqtVmPcd8qfrJX91wLDtT3Ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lz2nnduBkPBSkyYezD9WY/Ce/epOA13eP9Po6UY8OPV49B4pJYWuUDHJ30Mnsf0mb4Fwit9pQx5pDkyuUt8paVNxd8YVDdIbJKUTE4kG3EcDReJ+L2dG2xDHhzTAF6bd5SLbRw+xoqszfdqJaMnC4A+swD8GprbnoZkgdL2X6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MJPtBUFK; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=gKxG5eS6rbQKNbowkheAi2w8IlNhOj1jqAhU4f8X4ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=MJPtBUFK6ED9C3owHSyQ06OC9KpyFncv/fVhK0Qa1tj/c9SNFhe5Am9lsN55kRjwW
	 Yt+zF/KKQIeGTjW/mD339UkJbl46gmLHrkYzPUcpN8isYvXvD8mNiYO7S04qs4sOs+
	 HAWVYVP+i8zolZJ2UiMym0TLWW/K2Fhuwx2YhycajnwbLwB8yZrJl7COsoJfd4BK7d
	 SN7HZuFzCNQUNMCm/MCqhx4hNJmRc0BqzuFbfTMUp0T+zsEk8pYY1zgK8meGZSpWD7
	 cqk4qu+Gsj75BFsfeDldcAYlo7Ovh4radQpDx/UT2y6HJe65Ag3Rnr4mYUPHQWcRKn
	 jXGTMaW39zorQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 0465B18001F;
	Tue, 25 Feb 2025 12:12:40 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 25 Feb 2025 20:12:21 +0800
Subject: [PATCH] of/irq: Fix wild pointer dereference in of_irq_parse_one()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-fix_auto-v1-1-cf8b91a311dd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKSzvWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3bTMivjE0pJ83WQjM0ODRGNTi0RjAyWg8oKiVKAc2Kjo2NpaALL
 JaBBaAAAA
X-Change-ID: 20250225-fix_auto-c2610a358a30
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Fh6kVGO-h1qvazjKEsbMDaawYiiqO9KK
X-Proofpoint-ORIG-GUID: Fh6kVGO-h1qvazjKEsbMDaawYiiqO9KK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=902
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250085
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_irq_parse_one() will dereference wild pointer @p if it returns due to
condition (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC).

Fix by initializing @p with NULL.

Also adjust __free(device_node) location to solve checkpatch.pl warning
drivers/of/irq.c:360: CHECK: spaces preferred around that '*' (ctx:WxV).

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1efbf9f9bdecaab93b1d11f3ea2687679cb8e586..21c74b207c6835bddce8ce2774bcaa5d0ec72986 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -357,7 +357,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_raw);
  */
 int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_args *out_irq)
 {
-	struct device_node __free(device_node) *p;
+	struct device_node *p __free(device_node) = NULL;
 	const __be32 *addr;
 	u32 intsize;
 	int i, res, addr_len;

---
base-commit: cd726b80a9b2e35397f3f4ecd845a8fd247ee79e
change-id: 20250225-fix_auto-c2610a358a30

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


