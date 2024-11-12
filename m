Return-Path: <linux-kernel+bounces-405353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050D9C5029
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B861F216B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4C209F4F;
	Tue, 12 Nov 2024 08:01:07 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-09.21cn.com [182.42.152.55])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4659B1ABEB0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.152.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398467; cv=none; b=Ovf3Cdkh1JB/uMQQdZB+SKfPG5counuR99U9VV110tzehOz6oFBEs2eXXRapt+OFTrdzg5pK443n6vSQHbMjnGeEP43VkAhJvo6lKCuwD1eHuVR181ZcgJPEVpnzR9w7Qv8fJpX2vU/rE/o6PfIhNYims1VPC/bwkaHvckoD+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398467; c=relaxed/simple;
	bh=onsoox37F3BKl2XJCSMZLF4AFqPja7Hs4BV7KNZvd/E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IZjppxa9qoq6c/m7GmwkSCY8ze1E7IeMMFiOqGnpubiM5vwXvBonMsI579WQCiR9ZCZ7G1fv07f5TxqI27DszG4Xy26Py3rOZF594ahTcEpj8GsFXjWxW4Xv9ehjbHjzNqv3RvoLTtMQAIIIsl5wRxqAHqg2cI8bygjcUSMLIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.152.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:0.80849904
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-40.99.74.53 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id AD80111000199;
	Tue, 12 Nov 2024 15:51:59 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([40.99.74.53])
	by gateway-ssl-dep-6977f57994-qtmv2 with ESMTP id 5a9cfc41fb5447a0b16702af418d76fc for baolin.wang@linux.alibaba.com;
	Tue, 12 Nov 2024 15:52:04 CST
X-Transaction-ID: 5a9cfc41fb5447a0b16702af418d76fc
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 40.99.74.53
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From: "liuq131@chinatelecom.cn" <liuq131@chinatelecom.cn>
To: "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "liuq131@chinatelecom.cn"
	<liuq131@chinatelecom.cn>
Subject: Re: [PATCH] mm/compaction: fix the total_isolated in strict mode
Thread-Topic: [PATCH] mm/compaction: fix the total_isolated in strict mode
Thread-Index: AQHbNNdq8nK4T0kNT0u8eubaLwHPug==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 12 Nov 2024 07:51:53 +0000
Message-ID:
	<TYSPR01MB5702BA8F9AE17746F198F077F0592@TYSPR01MB5702.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

We assume that the block we are currently processing is distributed as foll=
ows:=0A=
0   1   2                                                            511=0A=
--------------------------------------------------=0A=
|    |    |                                                              |=
=0A=
--------------------------------------------------=0A=
Index 0 and 1 are both pages with an order of 0.=0A=
Index 2 has a bogus order (let's assume the order is 9).=0A=
When the for loop reaches index 2, it will enter the following code:=0A=
/*=0A=
* For compound pages such as THP and hugetlbfs, we can save=0A=
* potentially a lot of iterations if we skip them at once.=0A=
* The check is racy, but we can consider only valid values=0A=
* and the only danger is skipping too much.=0A=
*/=0A=
if (PageCompound(page)) {=0A=
    const unsigned int order =3D compound_order(page);=0A=
    if (blockpfn + (1UL << order) <=3D end_pfn) {=0A=
        blockpfn +=3D (1UL << order) - 1;=0A=
        page +=3D (1UL << order) - 1;=0A=
        nr_scanned +=3D (1UL << order) - 1;=0A=
    }=0A=
    goto isolate_fail;=0A=
=0A=
}=0A=
=0A=
After exiting the for loop:=0A=
blockpfn =3Dbasepfn+ 2+2^9 =3D basepfn+514;=0A=
endpfn  =3D basepfn +512;=0A=
total_isolated =3D 2;=0A=
nr_scanned =3D 514;=0A=
=0A=
/*=0A=
* Be careful to not go outside of the pageblock.=0A=
*/=0A=
if (unlikely(blockpfn > end_pfn))=0A=
        blockpfn =3D end_pfn;=0A=
So this can happen=0A=
=0A=
/*=0A=
* If strict isolation is requested by CMA then check that all the=0A=
* pages requested were isolated. If there were any failures, 0 is=0A=
* returned and CMA will fail.=0A=
*/=0A=
if (strict && blockpfn < end_pfn)=0A=
        total_isolated =3D 0;=0A=
=0A=
If processed according to the old code, it will not enter the if statement =
to reset =0A=
total_isolated, but the correct handling is to reset total_isolated to 0.=
=0A=

