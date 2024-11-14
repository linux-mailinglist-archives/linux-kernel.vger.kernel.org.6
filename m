Return-Path: <linux-kernel+bounces-408653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64D9C818F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655781F22743
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4617C20F;
	Thu, 14 Nov 2024 03:50:08 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-10.21cn.com [182.42.147.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD229A1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.147.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556208; cv=none; b=JphxA4QmTUDEWZOMoyam+UbFZtoDZ0dl1d0Jyyvs7PmTzaY5YGmM+IBX5nwNZ9M9WWjdVrFzXLuzktX6vqRtpscWxr80NEh/miiMdh7tuWsrAbaVUrdgF+badZ/Q9KTivFD/mwExkC3qp7i5Bd/jZv0ZDA7B4M2YYD5vsPcXms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556208; c=relaxed/simple;
	bh=QHyLUTHIcrMjHkYArBJt6BSeytcYQGDeQYiSbcIBLdQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iEqNhWyxaHEcb5fK/RYBRTe7tH/50/1Vv1vAPfrrlpjxguzQ99M9Y2FJXPoaIZz1NhVBW+TwyZn8pa0zvzc3krahVaqVtk5H7PQUZyuy3AKbPql/E5gvQ8PIotYEu3OofBCPzKtZqEScGecWvA4vufiMM3GyJpE18Bj1u8EDjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.147.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1238574180
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-40.99.74.53 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 36D39B023C02;
	Thu, 14 Nov 2024 11:39:41 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([40.99.74.53])
	by gateway-ssl-dep-6977f57994-mvlbg with ESMTP id aac8cf383ae94647b2c8727026599108 for akpm@linux-foundation.org;
	Thu, 14 Nov 2024 11:39:47 CST
X-Transaction-ID: aac8cf383ae94647b2c8727026599108
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
Thread-Index: AQHbNkbURyN8abWjmkOgiipc5QOI5A==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 14 Nov 2024 03:39:38 +0000
Message-ID:
	<TYSPR01MB5702E9AFDC00ED26F2ACBDB2F05B2@TYSPR01MB5702.apcprd01.prod.exchangelabs.com>
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

On 2024/11/14  10:58, baolin.wang@linux.alibaba.com wrote:=0A=
>On 2024/11/14 10:10, Qiang Liu wrote:=0A=
>> From: Baolin Wang <baolin.wang@linux.alibaba.com>=0A=
>> =0A=
>> =0A=
>> On 2024/11/12  17:47, baolin.wang@linux.alibaba.com wrote:=0A=
>>> On 2024/11/12 10:16, liuq131@chinatelecom.cn wrote:=0A=
>>>> "We assume that the block we are currently processing is distributed =
=0A=
>>>> as follows:=0A=
>>>> 0   1   2                                                            5=
11=0A=
>>>> --------------------------------------------------=0A=
>>>> |    |    =0A=
>>>> |                                                              |=0A=
>>>> ---------------------------------------------------=0A=
>>>> Index 0 and 1 are both pages with an order of 0.=0A=
>>>> Index 2 has a bogus order (let's assume the order is 9).=0A=
>>>> When the for loop reaches index 2, it will enter the following code:=
=0A=
>>>> /*=0A=
>>>>   * For compound pages such as THP and hugetlbfs, we can save=0A=
>>>>   * potentially a lot of iterations if we skip them at once.=0A=
>>>>   * The check is racy, but we can consider only valid values=0A=
>>>>   * and the only danger is skipping too much.=0A=
>>>>   */=0A=
>>>> if (PageCompound(page)) {=0A=
>>>>      const unsigned int order =3D compound_order(page);=0A=
>>>>      if (blockpfn + (1UL << order) <=3D end_pfn) {=0A=
>>>>          blockpfn +=3D (1UL << order) - 1;=0A=
>>>>          page +=3D (1UL << order) - 1;=0A=
>>>>          nr_scanned +=3D (1UL << order) - 1;=0A=
>>>>      }=0A=
>>>>      goto isolate_fail;=0A=
>>>> }=0A=
>>>>=0A=
>>>> After exiting the for loop:=0A=
>>>> blockpfn =3Dbasepfn+ 2+2^9 =3D basepfn+514=0A=
>>>> endpfn  =3D basepfn +512=0A=
>>>> total_isolated =3D 2=0A=
>>>> nr_scanned =3D 514=0A=
>>>=0A=
>>> In your case, the 'blockpfn' will not be updated to 'basepfn+514', =0A=
>>> because 'blockpfn + (1UL << order) > end_pfn', right? And remember the =
=0A=
>>> 'end_pfn' is the end of the pageblock.=0A=
>>>=0A=
>>> So I'm still confused about your case. Is this from code inspection?=0A=
>> You're right, the situation where blockpfn > end_pfn would not actually =
=0A=
>> occur here.=0A=
>> I encountered this issue in the 4.19 kernel, which did not have this che=
ck.=0A=
>> I didn't carefully examine this scenario later. Sorry about that.=0A=
>=0A=
>Never mind:)=0A=
>=0A=
>> However, when blockpfn =3D=3D end_pfn, I believe the patch is still appl=
icable,=0A=
>> but the git log needs to be updated. Is there still an opportunity to =
=0A=
>> submit=0A=
>> a revised version of the patch?=0A=
>=0A=
>Of course yes, and please describe your issue clearly in the next =0A=
>verion. However, IIUC when blockpfn =3D=3D end_pfn in your case, the =0A=
>'total_isolated' is still 0.=0A=
>=0A=
Indeed, that's the case=0A=
        /*=0A=
         * Be careful to not go outside of the pageblock.=0A=
         */=0A=
        if (unlikely(blockpfn > end_pfn))=0A=
                blockpfn =3D end_pfn;=0A=
This if statement is redundant=0A=
=0A=
>>>> /*=0A=
>>>> * Be careful to not go outside of the pageblock.=0A=
>>>> */=0A=
>>>> if (unlikely(blockpfn > end_pfn))=0A=
>>>> blockpfn =3D end_pfn;=0A=
>>>> So this can happen=0A=
>>>>=0A=
>>>> /*=0A=
>>>>   * If strict isolation is requested by CMA then check that all the=0A=
>>>>   * pages requested were isolated. If there were any failures, 0 is=0A=
>>>>   * returned and CMA will fail.=0A=
>>>>   */=0A=
>>>> if (strict && blockpfn < end_pfn)=0A=
>>>> total_isolated =3D 0;=0A=
>>>>=0A=
>>>> If processed according to the old code, it will not enter the if =0A=
>>>> statement to reset total_isolated, but the correct handling is to =0A=
>>>> reset total_isolated to 0.=0A=
>>>=0A=
>>> Please do not top-posting:=0A=
>>>=0A=
>>> "=0A=
>>> - Use interleaved ("inline") replies, which makes your response easier =
=0A=
>>> to read. (i.e. avoid top-posting -- the practice of putting your =0A=
>>> answer above the quoted text you are responding to.) For more details, =
=0A=
>>> see=0A=
>>>   :ref:`Documentation/process/submitting-patches.rst =0A=
>>> <interleaved_replies>`.=0A=
>>> "=0A=
>>>=

