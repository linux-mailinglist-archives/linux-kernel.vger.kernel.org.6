Return-Path: <linux-kernel+bounces-529332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52AA4233F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707A13BAC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF024886A;
	Mon, 24 Feb 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="g/L/E01V"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D71EA7E6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407322; cv=none; b=lFozNeb/ALioQRps/Y7El/RwQbDCQU2bIFnv7ciTklQgtUXZlHwG91u3PInI4bPXJGbHz+NQz5L3BTezpdwL+c8sP5V54E0JSQClXjBLmjPBkdwqWxuawJrzUFyuV15L2LZ7e7zXMM2UNflIGtYarQ9aMN5x9g/r+P94e0CLfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407322; c=relaxed/simple;
	bh=oOm1FU6bnGwCzq6hDTWsx6pFHsKwB8TyNvtEkuEDz5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hII+ONr2DhTaIzrETONS2q99Fip2LxsS9FDt1zcNY0rE3qlaarnIeP/CvnGb8mEBy3MaF2wSO8osSOZ9akYlZB6y8XFxfB1eTen7vmKAienbYPR/6Ogg6QPAUyBkVR1xfBZz75IrrV114EjcotzCJo3oiP/GZNEajK7yMv62WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=g/L/E01V; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=zx7MvlB6HU8Mone1UvhmXub58CbDSzOvGiV2JBKE2U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=g/L/E01V8FGxZOKgANrpGazYxXi0CW/GwTeo5EfmWANP7kCOO5WVyLjUbAGQq4qP0
	 SwJvb+a1DYGi1q7fjbun1nskPZCVbBTx7mPfA50ZuEwilrYTeooRuSN/b4RbpdZE2q
	 xdX5L4+api1iqvhIyzOe61Ao98iB3LmrQU9Cbc3dqw/1mCyKxFN47UV/G3Pa2ni2/8
	 8xS323BgLKM1ycQR0cmkADWNPIBLGKVGhXmNhnW/0ES151setkafqki/z3vODaoPFU
	 Eiz2eADSsOPtmTwIXd94dQxkjji+wWPdUhJRS5xIPqvDmpG0Ffmggpu2dtwSJ8EohC
	 NFeaZFYOjmWMw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id CE0714A0446;
	Mon, 24 Feb 2025 14:28:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 24 Feb 2025 22:27:59 +0800
Subject: [PATCH 3/5] of: Correct property name comparison in
 __of_add_property()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-of_bugfix-v1-3-03640ae8c3a6@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
In-Reply-To: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: f8g7UmWd-tUBLPefCfnrNeoZNjUjwumV
X-Proofpoint-ORIG-GUID: f8g7UmWd-tUBLPefCfnrNeoZNjUjwumV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=846
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502240104
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

__of_add_property() compares property name by strcmp(), and that is
improper for SPARC which wants strcasecmp().

Fix by using dedicated property name comparison macro of_prop_cmp().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 001ff6ce4abf85c07f13649d5a9f691f549a8ccc..c810014957e81171675b63f25eaabe391cc903e4 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1651,7 +1651,7 @@ int __of_add_property(struct device_node *np, struct property *prop)
 	prop->next = NULL;
 	next = &np->properties;
 	while (*next) {
-		if (strcmp(prop->name, (*next)->name) == 0) {
+		if (of_prop_cmp(prop->name, (*next)->name) == 0) {
 			/* duplicate ! don't insert it */
 			rc = -EEXIST;
 			goto out_unlock;

-- 
2.34.1


