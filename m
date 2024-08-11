Return-Path: <linux-kernel+bounces-282115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2E94DFBC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B07B21AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B260C2E3F7;
	Sun, 11 Aug 2024 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="N2dzariP"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A914373A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343223; cv=none; b=W3zDseFcXg9qW46j9jA6D1HpDNZ6d1XtSxw5kNjFhfScySLCa2o2orbDHGC/J1gZkbG1dx/PDx37N+fiURNdRMm5Jds+osEwe7ctINr7X9A5F0njpXrzF5fcRCvkHZraOuOF4ZZ0QpknTq19GV7oApFSaZVyzmQoh/tGBr/oKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343223; c=relaxed/simple;
	bh=LWX7LBE6ad0PQrT4zk/x097OL76QaLuC+pu7IpVboWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/ZUpnnaiwMoDDgqtvJJ6IFAtgSRj+Ew4IJdp0aPbxA9HyUKGKTLB5lslv6/VVoQA20P5QwRw2RjCd20xLvuTW+T6+EoziZIZgPFYOlK7CsGrs1iC+NEp3yu1cE1Urhlb9OP5l6y6ITRXtamTCHfVR2XYX1twG6k3DPmyEmZHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=N2dzariP; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343221;
	bh=hdZ+n0KmYBrpSPFHuho4P6uBvAePrqcRvV+VZrantrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=N2dzariPkx27lVVf+9jUNNYZQ7KKJPypD5/7skXEdQwdE4OaFm/aagAQC9C3VrIut
	 6Re9yuU5AP7BfVurO8aMakz7wJCF9i/87nm7dFMUTsrAeoD6vySLRpnsKzH9X6XtvX
	 MonKMHoKJXV4c7Sgs/wmLzIB2ZYtylo8zW68vkGGqTIkssauslVL+ppT+JUPfwpX0Y
	 YgexEGQGvP/DSPq9AjWPF392CEvZAF4DAsvQUMACAaizlR1ysmDN6+BpL92pRhSg2k
	 s3+Cw0VsdF3bwn1NNqGiIMsCFVwTCIOGrOdIBIZxblOubd5f2+sAHyh/MgkrbojAiV
	 bO0DwzxbZEsQQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 11AE91349B23;
	Sun, 11 Aug 2024 02:26:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:18 +0800
Subject: [PATCH 27/27] cxl/test: Make device_find_child()'s match function
 take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-27-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: nRXnq8XxWFuSCuZ54c-JWGrYp0TEtmlZ
X-Proofpoint-ORIG-GUID: nRXnq8XxWFuSCuZ54c-JWGrYp0TEtmlZ
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
first_decoder() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 tools/testing/cxl/test/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 90d5afd52dd0..6e82a4816ee7 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -729,7 +729,7 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	cxld->reset = mock_decoder_reset;
 }
 
-static int first_decoder(struct device *dev, void *data)
+static int first_decoder(struct device *dev, const void *data)
 {
 	struct cxl_decoder *cxld;
 

-- 
2.34.1


