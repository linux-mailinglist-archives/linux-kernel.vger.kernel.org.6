Return-Path: <linux-kernel+bounces-408592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA699C80D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D31B21FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC51E3DEF;
	Thu, 14 Nov 2024 02:36:08 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-01.21cn.com [182.42.159.233])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A32F5A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551768; cv=none; b=jbV65FfVcyZWxlq0vkzykC/upt+/6rTf9QcpBkJ5cIK94sItTbqWs/LBWE4fwAwKjRpRHIVfvdw5PYVTUcfZhz5X09lSdCIiAKPJ4Kxyq7CnrvKf3+VhHc9FBs+QkDeDqzVUeFTzKxgH5G6rRPMKs5Kh6qlxWVGOGKJA4LMoZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551768; c=relaxed/simple;
	bh=lWFR0tiU/5BAS1L7F/sh16Mx3kDtfSth2eQNIp1NpGU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AjXRoFyaZz6eKVCJySHnoe6OVnTk30CGmB7dDBOUr3Fa1GA8pvJBkz/zn7MHKY8qlPKpMDPMa0Xwtykb2ttoulx68TRToiHlPXuxKb9bWrZaEtazfe+sgo1o28hQbwsUWNRj6cOcIe1lyL5Z6gNV68OQvJwi4r5wDqATdSjWrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1557565417
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-40.99.74.53 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 5473D100112C0;
	Thu, 14 Nov 2024 10:29:27 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([40.99.74.53])
	by gateway-ssl-dep-6977f57994-mvlbg with ESMTP id f84cc24f0c0d4249be433d436875358f for baolin.wang@linux.alibaba.com;
	Thu, 14 Nov 2024 10:29:30 CST
X-Transaction-ID: f84cc24f0c0d4249be433d436875358f
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
Thread-Index: AQHbNjzPixRVO6Ot3kKopSfFalJ1dg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 14 Nov 2024 02:29:24 +0000
Message-ID:
	<TYSPR01MB570235A0139F17DE8371CA4FF05B2@TYSPR01MB5702.apcprd01.prod.exchangelabs.com>
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

On 2024/11/12  17:47, baolin.wang@linux.alibaba.com wrote:=0A=
>On 2024/11/12 10:16, liuq131@chinatelecom.cn wrote:=0A=
>> "We assume that the block we are currently processing is distributed as =
follows:=0A=
>> 0   1   2                                                            511=
=0A=
>> --------------------------------------------------=0A=
>> |    |    |                                                             =
 |=0A=
>> ---------------------------------------------------=0A=
>> Index 0 and 1 are both pages with an order of 0.=0A=
>> Index 2 has a bogus order (let's assume the order is 9).=0A=
>> When the for loop reaches index 2, it will enter the following code:=0A=
>> /*=0A=
>>   * For compound pages such as THP and hugetlbfs, we can save=0A=
>>   * potentially a lot of iterations if we skip them at once.=0A=
>>   * The check is racy, but we can consider only valid values=0A=
>>   * and the only danger is skipping too much.=0A=
>>   */=0A=
>> if (PageCompound(page)) {=0A=
>>      const unsigned int order =3D compound_order(page);=0A=
>>      if (blockpfn + (1UL << order) <=3D end_pfn) {=0A=
>>          blockpfn +=3D (1UL << order) - 1;=0A=
>>          page +=3D (1UL << order) - 1;=0A=
>>          nr_scanned +=3D (1UL << order) - 1;=0A=
>>      }=0A=
>>      goto isolate_fail;=0A=
>> }=0A=
>> =0A=
>> After exiting the for loop:=0A=
>> blockpfn =3Dbasepfn+ 2+2^9 =3D basepfn+514=0A=
>> endpfn  =3D basepfn +512=0A=
>> total_isolated =3D 2=0A=
>> nr_scanned =3D 514=0A=
>=0A=
>In your case, the 'blockpfn' will not be updated to 'basepfn+514', =0A=
>because 'blockpfn + (1UL << order) > end_pfn', right? And remember the =0A=
>'end_pfn' is the end of the pageblock.=0A=
>=0A=
>So I'm still confused about your case. Is this from code inspection?=0A=
You're right, the situation where blockpfn > end_pfn would not actually occ=
ur here.=0A=
I encountered this issue in the 4.19 kernel, which did not have this check.=
=0A=
I didn't carefully examine this scenario later. Sorry about that.=0A=
=0A=
However, when blockpfn =3D=3D end_pfn, I believe the patch is still applica=
ble,=0A=
but the git log needs to be updated. Is there still an opportunity to submi=
t=0A=
a revised version of the patch?=0A=
>> /*=0A=
>> * Be careful to not go outside of the pageblock.=0A=
>> */=0A=
>> if (unlikely(blockpfn > end_pfn))=0A=
>> blockpfn =3D end_pfn;=0A=
>>   =0A=
>> So this can happen=0A=
>> =0A=
>> /*=0A=
>>   * If strict isolation is requested by CMA then check that all the=0A=
>>   * pages requested were isolated. If there were any failures, 0 is=0A=
>>   * returned and CMA will fail.=0A=
>>   */=0A=
>> if (strict && blockpfn < end_pfn)=0A=
>> total_isolated =3D 0;=0A=
>> =0A=
>> If processed according to the old code, it will not enter the if stateme=
nt to reset total_isolated, but the correct handling is to reset total_isol=
ated to 0.=0A=
>=0A=
>Please do not top-posting:=0A=
>=0A=
>"=0A=
>- Use interleaved ("inline") replies, which makes your response easier =0A=
>to read. (i.e. avoid top-posting -- the practice of putting your answer =
=0A=
>above the quoted text you are responding to.) For more details, see=0A=
>   :ref:`Documentation/process/submitting-patches.rst =0A=
><interleaved_replies>`.=0A=
>"=0A=

