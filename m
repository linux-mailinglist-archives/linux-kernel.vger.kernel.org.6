Return-Path: <linux-kernel+bounces-282102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0694DFAF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8598B209B3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013E21BF58;
	Sun, 11 Aug 2024 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="faOyms28"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE34D8BD
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343170; cv=none; b=HVCL6Gk39hZx+0O56Z5yCijiKMSLa0M/y+v2DzhZ6y2IZhN8o2xWG9JtMOy6+xC4nVmfxW11I1gYKU3qkN3Wf461EQeCM+Ttk83mS8g5BPZGArkNDg561jmL7gJ+5hO75E6TzNNV0HNU+556XQEyBjf0Y6jttQQTzoFH3Poap28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343170; c=relaxed/simple;
	bh=bisY/lqrEfDV9xy/mfE+P9wOZdGTQq2XkR8ibVmdsBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpdDWvJ63tjbjxAJlOs9gzcdP4olOqK3Rrs32+O+V7SJFoOFBgZ48l43qDSAFTthvlRGqOay+rYF7RNq1PFOAHban+YSSOOhckoHRouKsGeWnmrNBIs6DINn0H4eTk40sp1oEAbFOGdGsur7888EX73YNlIh0eEfnSCVz7xcxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=faOyms28; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343168;
	bh=qZNVSRTUPBsfB6Mn/z/sMtjrBk5bD/GxeiSQM507KV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=faOyms28I+yR29GzY43GR2xGm09af2gHzFRdKUE9d7jmlV31oaiJjvb18yBxbHSMt
	 ZXFXgsJtdiF2gPYbtjcleQrvS4Hvx9q6R8sAKts5WvUmGqHm2ABUreakps5AEEWhkD
	 f2BJ+YhqTQL4lbKAiETYagUu/Qc1/9TCMQniTlOYMJCNPIQKduEd4PvfzMvHILY/61
	 weJk3VAabcR27DyRE2dzA4fEgey9LVZv9OBZWHB6ut0V3LxNYDVckZPwYAB/dUnq4V
	 dkI0IxE7mr8e/7+3OohF9XxknC9kBdVzZDQUk3kDzKohqoaVghnCLAX8FpflG/x2gr
	 Z/8XGwy8EACxg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 75C121349C0A;
	Sun, 11 Aug 2024 02:26:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:05 +0800
Subject: [PATCH 14/27] cxl/pmem: Make device_find_child()'s match function
 take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-14-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: UJ1XZxKUqofimsKCEVeuGxOtY0ZNt7aB
X-Proofpoint-ORIG-GUID: UJ1XZxKUqofimsKCEVeuGxOtY0ZNt7aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
match_nvdimm_bridge() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index c00f3a933164..015759595aaa 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -57,7 +57,7 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, CXL);
 
-static int match_nvdimm_bridge(struct device *dev, void *data)
+static int match_nvdimm_bridge(struct device *dev, const void *data)
 {
 	return is_cxl_nvdimm_bridge(dev);
 }

-- 
2.34.1


