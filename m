Return-Path: <linux-kernel+bounces-200752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F88FB480
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B478282AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2DE12E7C;
	Tue,  4 Jun 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBylSPMr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1D171CC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509191; cv=fail; b=GvEuhW4CZS4oXc7QYO24t1pGk23RI78t4Pvpj/gpYqPikPigfPjFqdZ4JqzR1tmv3yByzuNAa413WKljQpo18JuyZjS6yigsNaYen6J+hNytuwEGz4buxo40bSJRk6soscYb0Y8U3H0T4m9oIJ4tLmFjC7h5FdMQzOml82amgdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509191; c=relaxed/simple;
	bh=qYulyM9jpayklSm0Na3gY85F3cyGzPV8zfTVyi6tN5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWix+2Al5hH29hIcQ8uF7buVOzhBQGg4oAi/UTo7LGU/b8WRVqqouWamV0P7BeipiIpNMgXlWD5W4YYnOuxzRWdjRmRF6sPQrt+JXXeYoPOM19EqAi/QFst7sS5wVBLacld2JzYst4zzf7+X/KOYNkExbMaM6ceBxkiKcadxoDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBylSPMr; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0+Jd2YxxHlsFn5qqBVKx0J/Tdf70bRL/iG1y94Wy8Ng7sqSBs4XY4aPDVtH8l8HRmXaQDyDJ079OEn+T830r4mLQDw1SrfEU89OixMUT80Rtqs2icAYoQxr1taJ8JjzdTbpMd2sLtcy2dAiJdNFbWVjlpVrsoK8FLuToJATv+u3+TaFdjLWwsNxv6WPFeOqxvbU5OEY+b5GYl+AArlUeN0+0PtTYqmBPHwrkoD5BJMjnZfFj3cXwl5vbs2uQRSskSl5PBW9PBjwhm0pU18JhMGOgnMEtDWSKBjxQH48RYK4P4zczVu7sK57yWSCoirCuhRLhaNC7SCvoNEyxOfObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVX0ePiqq+MvkGM8hpxE1QczRujHP4WCQFIJ1UHmHPU=;
 b=VdTjIdS+kzL6H7mphDJW/hOO2rnfOmUNumDlv8WPc/HNuf4SLqZP+O9pnqJoH8cmrL0bB0iBxuYBRH6DzQPQERDYgscjLEAiq5tC9qz0VD2g5wBINL8qzeiKtwHGHocFzPbNXtJy0oETsD1H3tpCI2GBERKpky2CUfmFvzftjv0bNYz4GGa9SEDP0SerS2atpbdr4zhqNah+ZHh+6ZLZSMhCVwxdzl3DB0+64OUg7BqhqfIEV7uJShTZN3zeucYUbwxbTdk0wIqzkhGkr/ItBLMSzkVR5h5qvgmB5hyXQKMnghUpLsxN5Tbt/oNc+rAruk3eGkiCPM12Bju5UMvkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVX0ePiqq+MvkGM8hpxE1QczRujHP4WCQFIJ1UHmHPU=;
 b=dBylSPMrEfGPnKnn0v4UNobi82wPTeDSDPKTmdl2tUT9bjA5+y3ysvR4XRDP603jmowV8Jp3dvpZ4IYeiztWXK33T6aD3fmwymNQmMRFXgNNjgca6PQZAKBK5iP19yZW7wauPi5gCg/Mag+F9sDGCR161YrGmLO//aAKP+t53SKSt02ZbXnUtIbyMcCOWonTmaYQuTgdW0zGg1OQSVFcTBBXvRtP+tSyqNVauEyUmMcrPc3q3EMOmcEe3//VuRFYiSZQGaIsRIqDAd+T+e+zk2nbcvDZlpQXmYezHc6phZSn0ft9iolFMq8lOn6HWZXoOOgarT6xScLQ6LlRbXVy0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.24; Tue, 4 Jun 2024 13:52:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:52:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: xu.xin16@zte.com.cn, akpm@linux-foundation.org, v-songbaohua@oppo.com,
 mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
Date: Tue, 04 Jun 2024 06:52:54 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <E30FDAA1-B4D4-41C9-993C-0AD5044F30C0@nvidia.com>
In-Reply-To: <fe35d494-b54e-4302-8c75-24abc9094ea1@redhat.com>
References: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
 <fe35d494-b54e-4302-8c75-24abc9094ea1@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1DA8CF4E-A6E2-4232-9624-4A4273D7299D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1dd1c7-70bb-425e-24f9-08dc849da45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PNCaqYvbP0/rE0KetQXJzpWvRRrWEaTHYPrvgcPHg5K+VMOuMpBnl5uTy8HJ?=
 =?us-ascii?Q?Nl2vJj83/5zKyHO8FrYiXDR97mFrZOs1tWdVDNv48mVRo6xMwwLLlNQIJdki?=
 =?us-ascii?Q?RoIfCY7n7Hi6NmrKg91A7AdEFjDMczOmWv2Y9DZY3nx/GXXgJmM+FkzkA90s?=
 =?us-ascii?Q?48Y3az64RIaYa2xEXH+Bs2Vb8Mse9zsGD3BafJ4W68kk/ycAVWXV0K/6FPKZ?=
 =?us-ascii?Q?p23NnCf9zQgZLA4YSF7anAbexQBA26VU/LOOZBqIjNJH19O5wy/NOdXdE5wH?=
 =?us-ascii?Q?C5tOZDy2UaFW8N7W7y07lcGi8mxQbnddWCbUaux0sR9eJTbQ2PPA3sbOBmqE?=
 =?us-ascii?Q?pfEQwJcx5KEH/H3rGzhr5ox4NllsKuSJyE39ylGCi9FTSNHbfTh/ejnMFGy5?=
 =?us-ascii?Q?KHhoCapF1OgyMMKD5QUEFTYLYHihP8uIkF78birN0x7uiaAgYVi0ljZoxfgk?=
 =?us-ascii?Q?yvBY13pYX39TqfnpA1PHHNUycwxMN7K90TD/oHqHFmXQBS7iC5EQryF4rPHP?=
 =?us-ascii?Q?EThNtPGejCh8t0y8kbzEYHnft0U0vn3s0CLgeuYXkQAsUL4LV0tDNJoCjGpo?=
 =?us-ascii?Q?Sx7LYD1hyCtMNgrA2/gN6Xg2YlCoR7/JasCyhr8bkUW3Od4gYOP4LQasDpXw?=
 =?us-ascii?Q?8CO+Q6+mIjjBEW/LSPXGwPvj/XIz6UxVB9R1iruO3rpDVukitJE3JV2g8hxm?=
 =?us-ascii?Q?M8WbGncxiphOSbg5rCq8tvLfZJrblxGzGx5QNMT3t1UEE6SV4c2WoIBaA+Zi?=
 =?us-ascii?Q?rrspJyApayGgHlVrXGLkQBH260loLe9s0MHRFwqWoAhty7Oi1sthKlhdWFc1?=
 =?us-ascii?Q?DRjfq1StlaPYxikewf2uWomDtdleqtQUTX7H0RBPoC4gfN91MFu4epGvKihN?=
 =?us-ascii?Q?8b3VzPlN80pPfKaH28FQUbeCDSS4VmC1LlWCtoQ5q8OcVna/b7pj5794TX9A?=
 =?us-ascii?Q?JUHaWjt8JOm4w2j8FgNzD82Xg65h/UaVF4EzSJjrTfxcNoF1L6S+793UvuhE?=
 =?us-ascii?Q?FvOQJMVnf/AwwIfvwkVmq16fU8XGisTf5ft3ewjH5SwFYyMC7h/W/1ir5H8U?=
 =?us-ascii?Q?Ej0iSCNrqB+JLjrWWiaNQuYIefrXwqaBoNJkBSyIcEPCGB5lSg0NS8PwCJPT?=
 =?us-ascii?Q?69BdAPdtAr4pP6XSNzQ6vkxUgKlwjNVP6zI+87u8J64Daq+ZepRIhVmKK396?=
 =?us-ascii?Q?Gcu+oTxTPJJ6zhbf5BVD9xBESi86kKQbADHuV5koAzHoxziYg6KG6AJrvK7k?=
 =?us-ascii?Q?c12P1bTYOtHMd9GFAry8Qg459dAvGi/zCYnjrOBINQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFsqfUigX3vbOSy2otm25TSMAdsh9/wjslJjKzPdogL/ppAj0foBj4Wk8ZZj?=
 =?us-ascii?Q?5CTNfsUSX5QYYrM8vgTnKrCtncBGKTehiTB8vZcuTks9AX/ZlH9TsijCdz+E?=
 =?us-ascii?Q?nTEaM7sUWSgrygknEe++wXGgwOgvWpLEzRFs99r7coP51HKC4B9o8+HnPUqh?=
 =?us-ascii?Q?1DHwlTHHDFzH5YG55Y18OkODN2yll/dV+BymRgKfyNWy57xARot+dzpZPz0+?=
 =?us-ascii?Q?P0LjIJpz+F0yLsNk5aLBPjVyk9E3sjJWY8HYHjb0ok5h98RIzDIaJK7/oIPM?=
 =?us-ascii?Q?8IQ2bz4QmBnskd2Qa1q+NwUQn1JK1gVECJfDWYgLpgyw/s/N1J54urcAZi1N?=
 =?us-ascii?Q?7IeMKv6ANWorrLse2yUbT2lYR7/xVWxgE2dIIdgUp8mBOlvaEqj25gjnGoPH?=
 =?us-ascii?Q?vk5/pe4UWtAI1e/TO0G0bC2kw765BwOoV/2VRhY3IoIq88qhnWWcKEvGZhPV?=
 =?us-ascii?Q?Wb2zEFuQR2++GwmQEua9XRrtKQ1bfF10oLh4jiEMUWSloe8giVf8EWRRyY45?=
 =?us-ascii?Q?yCKOexgxwOfkVWpIWQ06APAUVbMnooXbftXXA3qu9EMjnmf5dcwvJpe20XI9?=
 =?us-ascii?Q?OycQnD+6Tv8W4Jhoa3O1RwT/TP+eHgtIj80rrX8Sif2fXRRnxKEpeXi0zAUY?=
 =?us-ascii?Q?YbNZTVQ0su7dwxhjAV49HvA9kc3Jv0xqPKlvfoa4pJuuRY51WGDHffEcz35H?=
 =?us-ascii?Q?uLke0AynnezZ/KyzDekcs2CNWE6n2IZjDLc+J/UDeywkLFMU4Ek+0TBTIO/E?=
 =?us-ascii?Q?68a82W+YIYx+rL4H4XYqo3j0Szs4kkeACPUhMaf0ZH1N2vtjN6tf9NEhGHtS?=
 =?us-ascii?Q?IgeR80X2XHkDCnR0iThwapMTVC+Sd/0DL96dzgYuByNRLmxR+1byTLWL7ATw?=
 =?us-ascii?Q?jZDJDbPH25uws4ZpDwyiCyEkj2jPGu7Enbcm+DCeIpEBe4y3vjiQ/Hlotzcq?=
 =?us-ascii?Q?31Sn0KrBYHDKrcQjbYe4FLittl06P/lef7sMwQVQgX0IVy481lLU+ynR5tbe?=
 =?us-ascii?Q?xSOJNyIDqW7Et+ftygleqNOjq0t05U8KYha01EZVTGg3TKn/mJ/L+DPkhnQ8?=
 =?us-ascii?Q?+6r16oUGMMIXKtctbov9xnWlWjAXoCEdmeJBxaGj/lpXTKnqbPfgkwXx8dhT?=
 =?us-ascii?Q?ce4d5pt/+yrpSg78K5nqCxIJtKPOcQI/rmMgatsyI/yYfYlIO/z3/jNzXwRE?=
 =?us-ascii?Q?NU8nDd1i94n6v2cWuFsW1KIW4+nJgqz3tC78kEZ+s5ksUh9S5fMn6u/zyOCB?=
 =?us-ascii?Q?B8qbh23ZajAbpGKcLmdGIhGQ/8UsserPsIdCW+eU9ZA/L9yAn/tx3c77KYRz?=
 =?us-ascii?Q?09k3aDnOefzvStHgC5Vrhq45wurwUhdEew7IseoSSVv53oV23ZTmY6ATU7X1?=
 =?us-ascii?Q?srYIBnevLZnXnHfVU2hRXGYHJhy5e91QgpDLMGdGTaoBk7H84xxaF9fpUd8o?=
 =?us-ascii?Q?LHmlSf0t6syl9req7jziTXRp0YdEjp5DgvBmEh/80/NofwwnS4SRkCRM/TM8?=
 =?us-ascii?Q?tb95PTfpvt+Np8PJ41XZ4aTTMuJakh7UXDAsFq6uPrnCAkei5z3cX4QTBJvg?=
 =?us-ascii?Q?rAigpkXoXTUVa5dXSuo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1dd1c7-70bb-425e-24f9-08dc849da45f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:52:58.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v8q6J29SscJqdNBPd39XSt1ES02C23J3w4xvfNt5GnOcgHuRyqQEcJ2FETol1/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

--=_MailMate_1DA8CF4E-A6E2-4232-9624-4A4273D7299D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Jun 2024, at 0:57, David Hildenbrand wrote:

> On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> When I did a large folios split test, a WARNING
>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>> was triggered. But my test cases are only for anonmous folios.
>> while mapping_large_folio_support() is only reasonable for page
>> cache folios.
>
> Agreed.
>
> I wonder if mapping_large_folio_support() should either
>
> a) Complain if used for anon folios, so we can detect the wrong use mor=
e easily. (VM_WARN_ON_ONCE())

This is much better.

>
> b) Return "true" for anonymous mappings, although that's more debatable=
=2E

This might fix the warning here, but the function might get wrong uses ea=
sily.

>
>>
>> In split_huge_page_to_list_to_order(), the folio passed to
>> mapping_large_folio_support() maybe anonmous folio. The
>> folio_test_anon() check is missing. So the split of the anonmous THP
>> is failed. This is also the same for shmem_mapping(). We'd better add
>> a check for both. But the shmem_mapping() in __split_huge_page() is
>> not involved, as for anonmous folios, the end parameter is set to -1, =
so
>> (head[i].index >=3D end) is always false. shmem_mapping() is not calle=
d.
>>
>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>> patch, large anon THP is successfully split and the warning is ceased.=

>>
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> Cc: xu xin <xu.xin16@zte.com.cn>
>> Cc: Yang Yang <yang.yang29@zte.com.cn>
>> ---
>>   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 317de2afd371..4c9c7e5ea20c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct pa=
ge *page, struct list_head *list,
>>   	if (new_order >=3D folio_order(folio))
>>   		return -EINVAL;
>>
>> -	/* Cannot split anonymous THP to order-1 */
>> -	if (new_order =3D=3D 1 && folio_test_anon(folio)) {
>> -		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>> -		return -EINVAL;
>> -	}
>> -
>>   	if (new_order) {
>>   		/* Only swapping a whole PMD-mapped folio is supported */
>>   		if (folio_test_swapcache(folio))
>>   			return -EINVAL;
>> -		/* Split shmem folio to non-zero order not supported */
>> -		if (shmem_mapping(folio->mapping)) {
>> -			VM_WARN_ONCE(1,
>> -				"Cannot split shmem folio to non-0 order");
>> -			return -EINVAL;
>> -		}
>> -		/* No split if the file system does not support large folio */
>> -		if (!mapping_large_folio_support(folio->mapping)) {
>> -			VM_WARN_ONCE(1,
>> -				"Cannot split file folio to non-0 order");
>> -			return -EINVAL;
>> +
>> +		if (folio_test_anon(folio)) {
>> +			/* Cannot split anonymous THP to order-1 */
>> +			if (new_order =3D=3D 1) {
>> +				VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>> +				return -EINVAL;
>> +			}
>> +		} else {
>> +			/* Split shmem folio to non-zero order not supported */
>> +			if (shmem_mapping(folio->mapping)) {
>> +				VM_WARN_ONCE(1,
>> +					"Cannot split shmem folio to non-0 order");
>> +				return -EINVAL;
>> +			}
>> +			/* No split if the file system does not support large folio */
>> +			if (!mapping_large_folio_support(folio->mapping)) {
>> +				VM_WARN_ONCE(1,
>> +					"Cannot split file folio to non-0 order");
>> +				return -EINVAL;
>> +			}
>>   		}
>>   	}
>
> What about the following sequence:
>
> if (folio_test_anon(folio)) {
> 	if (new_order =3D=3D 1)
> 		...
> } else if (new_order) {
> 	if (shmem_mapping(...))
> 		...
> 	...
> }
>
> if (folio_test_swapcache(folio) && new_order)
> 	return -EINVAL;
>
> Should result in less churn and reduce indentation level.

Yeah, this looks better to me.

Best Regards,
Yan, Zi

--=_MailMate_1DA8CF4E-A6E2-4232-9624-4A4273D7299D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZfHDYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK4p8P/3Z00wHEG3jJ5l4vHPNvPA1fb9aeUraW5Tvn
Y0xAcbNViss4cuFknKE6z0Aw65b3nb4lQZ9Ux7m8lbpeW8JKFraj2qAjg1yMl8ZT
+e44orvEwbbUA9ga0ZlcATkWETb/hMYb1E1Wa090lToXU1CjtrWSLZeU0FTAeRQT
SIoNqX4faWAs2p4hOAle+YUTzzdqbXTrowQwVhXxV8efB0x+RAv8qdJd4frWtio1
oBuSNTs/iUqFykXDsQekxDon1l4SW9bWvMKP2w9PsrIoP7iH49i1rqeOYNgCuQwW
TbWiiQYzjm/8tN9VP4NVNR6ZKGIXS5RR48pIoIeqX9J8QsHM6S913NM+87wZL+0k
AXFXKzRAIxvyJxMCw+GpfpZ22TQrlaTrtVRpX0J0cHiDSq/24Ff2vpDxB4r1aigp
WbBhFSWgD1FBjouj5i2Op/yGhxL3XhZD4FV4TFx6XCzPJGUTY6aZ3iqFQ1pMIxLO
uSdWQq37GmvcD4yxjoou1QaiutbfMo10otc8g9uVEpzAjOFwoKiON9lvxT9OrYJB
wI1pitQv3CPXXkQcvdFRnFD/Xc569TOHkdAOn30peh9oYbzyhxmsHDR09eYf1s64
HHdG6QkrlR+01iCyzdVUOuAEa985ca7cM/CXO8Dk4tVT8OsLqA/AObTRZrwyMpDg
KxhiF9mf
=VAWf
-----END PGP SIGNATURE-----

--=_MailMate_1DA8CF4E-A6E2-4232-9624-4A4273D7299D_=--

