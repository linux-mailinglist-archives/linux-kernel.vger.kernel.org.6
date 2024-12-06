Return-Path: <linux-kernel+bounces-434177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4039E629B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A23318843C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658D13AA3F;
	Fri,  6 Dec 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="R9wSIWxo"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4574421
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446427; cv=none; b=N7nYTCPLT4ffsRQSmwcxaD8/LWvs2O63pDQ4rpsONshFjSUJKKZbxMBGVMiHjMe2jlogS4TWdyiu+Qyr/HS4DJVz+THa0e/xdlH3XCX+2BJ2ihXKrqX1dV2xK9NtAhEdbChefrwEq/DWGRUwUmndvDoci8jGNrgZhtLo3NT1NHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446427; c=relaxed/simple;
	bh=Q9xVwx+mmn7ZFp9zYbGBt/qs8maxp/kG00CZiM5eHAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jira/jBz3W7JWJxrMkeWy0cJsBpC2A4Ku6/tJqQiSpAXmg5U8zgLYR5sr/v9JT+OhRTjzYVqSgrJWnGi45CjCgECV73d/w6Wuq69A73wNs72CzYnaaTHhlO1zRQ2aMpOxfH2h/pdlraHoqNCvFrfSiiwLzMUXLeUsf+ckMte2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=R9wSIWxo; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446425;
	bh=h19CCu79uQPaou5AwQpkA6b+XyLa6pyMxHtnX9ZwgYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=R9wSIWxodsjd+FrWBAWSML3aQx5b1J4EEhuCEb95I/d+3DDIBG6iLrwKcTtE8Vjxk
	 AqXh3lepG6aA94eCND1wqvXaF90wGwzj5Sc14faR6vqwha5uuNBS1OC3ZreQa5wblG
	 xWsxhC2cMRZ/BOXVjBOrhycvsdbGqrocoLDYtD5f5npyLjIfn4hu13p+Vh/GWSC+ng
	 4iwN6gMoEPFdR/o9hZ7Gmayxp4SQ5e1UsoxHOR+w8QquLDuBHhAlhAfyDYi/TkKF9Z
	 aS/BgJH9nTRe2oMsVBGIzS7/a0EHWEbCRi3yLzEj865ldHPFeqbxUaVh7mcGJclXTk
	 vRW5kX56p2pcg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id B7B5BA0287;
	Fri,  6 Dec 2024 00:53:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:32 +0800
Subject: [PATCH 06/10] of/fdt: Dump __be32 array in CPU type order in
 of_dump_addr()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-6-dc28ed56bec3@quicinc.com>
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
X-Proofpoint-GUID: _l3FG0YuEQ29KnYZI_r-lqY1WcqzrzaZ
X-Proofpoint-ORIG-GUID: _l3FG0YuEQ29KnYZI_r-lqY1WcqzrzaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=771
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_dump_addr() dumps __be32 array without conversion to CPU byte order
in advance, that will reduce log readability for little endian CPUs.

Fix by be32_to_cpu() conversion before dump.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/fdt_address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt_address.c b/drivers/of/fdt_address.c
index 9804d7f067056a9437d37f0b4561d79dedcc3187..1e5311f6f1858b59b99f650bcafa55a8d11225f9 100644
--- a/drivers/of/fdt_address.c
+++ b/drivers/of/fdt_address.c
@@ -28,7 +28,7 @@ static void __init of_dump_addr(const char *s, const __be32 *addr, int na)
 {
 	pr_debug("%s", s);
 	while(na--)
-		pr_cont(" %08x", *(addr++));
+		pr_cont(" %08x", be32_to_cpu(*(addr++)));
 	pr_cont("\n");
 }
 #else

-- 
2.34.1


