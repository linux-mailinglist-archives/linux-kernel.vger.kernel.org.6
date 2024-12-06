Return-Path: <linux-kernel+bounces-434178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF1C9E629D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D748283A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72A2AF1E;
	Fri,  6 Dec 2024 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jBpGd9le"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76413AD32
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446433; cv=none; b=OVRHJYKXa1UFAUbBqe2DeBxK4qI/mDT6AtLXo0z5ReOUR6QiT6q5mmDgvLnchMLXLh/s+CpaE+sOjtHaeYPiE8zyyqL1hlpBPFy50RQpp4juT2RTbDjgbA9dH2x4+Vr8nu4K02+Fc/AKEgqfJ4gEzuigdtmC88LxXbRarc8WXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446433; c=relaxed/simple;
	bh=3r59l2ZKH0fb/gjUMwsN9/pByrdyRbSqBd7pZeH+Fqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgIo6O4qFWqcvhsGXL/b9V9cpZfuU9+3Zp7TchS9Htu82DE1j7Alavje6yAUf496UuXJrOW2BIJ2V7PQ2oObtrbgaPMR123N3glPWtcrRQuaq9cJldGekUUcleakKoqRnhlguPEa5lr+90ujEk16ZtgjJ4Xyhj3Ph/waaFTqKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jBpGd9le; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446432;
	bh=6eW1KIk0QTFVWX1i7yXwMwfKqVa+AKG/PTqwf319jEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=jBpGd9leV4TpDMvlt7wR4rMtF2g2DydLFBQY7S+BYpS0dSSseYv+xMlS0mCmf/uF0
	 iBUH5cuf0Eugc2Ikokj2j+Sy5CB4ZzMolCh+mE5ku+S1tMAQ+8ytMzkWJ5nZE9nDdC
	 DBrM8QmIq6dnfZo7vFFTioiOq+ZsIUQeWe0xE81DNTJ3yVuk0O2XjIOtvtl7dcu33K
	 MraPlklI10JEg5GO7X7q0t0e+KvqNpnF7KWh3ix5lE+Cpn8q7rumZKNFoc+zukuDPC
	 XzfHeGc27Ed4q7LkcMUcP1YhC5w2kMT51cATzGx2To7vP3G26IEGefWVCdbeWe99ed
	 WQFxIFfA2LAxQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 64023A0286;
	Fri,  6 Dec 2024 00:53:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:33 +0800
Subject: [PATCH 07/10] of: Correct comments for of_alias_scan()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-7-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0Di-Sp0-9pGnSZP4hO3f-_yAwFawx1pf
X-Proofpoint-ORIG-GUID: 0Di-Sp0-9pGnSZP4hO3f-_yAwFawx1pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Correct of_alias_scan() comments by:

- Replace /* with /** to start comments since it is not a API.
- Delete return value descriptions since it is a void function.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 1c62cda4ebcd9e3dc5f91d10fa68f975226693dd..33abb6227468c03fd191201aa2bbe05a41fdd9f4 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1812,14 +1812,13 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 		 ap->alias, ap->stem, ap->id, np);
 }
 
-/**
+/*
  * of_alias_scan - Scan all properties of the 'aliases' node
  * @dt_alloc:	An allocator that provides a virtual address to memory
  *		for storing the resulting tree
  *
  * The function scans all the properties of the 'aliases' node and populates
- * the global lookup table with the properties.  It returns the
- * number of alias properties found, or an error code in case of failure.
+ * the global lookup table with the properties.
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {

-- 
2.34.1


