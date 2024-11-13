Return-Path: <linux-kernel+bounces-407178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAB99C69C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB9E284542
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545F17E00E;
	Wed, 13 Nov 2024 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VVoIPpu4"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396C230987;
	Wed, 13 Nov 2024 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482211; cv=fail; b=sCYAXhspT4lVtxP9sHvM3kUxiqqgbxIRonA588M4os7pYOJ95NUkdan+fq3QNvLZk8JTH4RqHhvGljyq2+QNwbWIEs0Y+huDXj1jXttNLdYJDEMfxr0BcyvLOeKYRsP8l2PxoQ0fGu3LyYcrxRncTUJ8AdnXA/mgq4sYqHI2QrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482211; c=relaxed/simple;
	bh=2kLy/z9+bzB+R7Q0Vr0+mS6oDfVqFWTmbkNdlTB06bU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F66zJ83eLyTrLOelz8orWYHad3wNml7Oz/DxxdmgU+ZG3/Ew3feG+Kd8rGjjipRrFgv9J4u4tXINdYn12nlvkXMIZq4/JPyBb0/BmgbRwProuAZYedN4sxakjdDF4+/P4+347wajYloZU70JMB/NHGquIW+dK3DxjlEgrhx8TWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VVoIPpu4; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izT/rWeizQnFSDOLhDzayTOnW/ta1/mgQk2rZEWjP8b9I+y1umz1LZarR/NG3DWkREC2Yb1abAvLLdJzXwzGiZtzYkhEi/QpO7TgP8krEjg7KtT82TWijRazIU4sXdVPCNWxebn9OdTVeFP2+Fu+WYAux/rsQ7nMOw6Iz8C9/443YgQT6KVZV/G87oT8TOC5wMI+zpSDic9FnCBq6Kyv5wa2LRGAtH2fCdkkVDLqI7ZcVHpA/7i0g1ZSufI0QGRwOpw+qcZSI1DRfgJj8ZxLiv7la4dnp7MMs9LJj3k9iNWEGbHE775ZA0a/WwQ7eqd1r+bpAN2MSh6wPmgECjpXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BYUgN95uMmJVoFmFEchk+HigNMgilEkwMryJEZXBSY=;
 b=MdQahm/ppqpiiooEtj1TQLPFUNfBvPqF1hVMkFDe+bqk941ouJrNm9VWPlk90Qt9qBSyn7ZgJg8ZXBKTo7LqGPu5aiO9qZKPHhnCz+9ir3ZpRwypfYo3+TxVCMiyEL238YI/QMKm0exgbbXRgH5W+rr9htjnlUcg80AVz2HWzlHKXIQw75h7EhoijZQ7dumRtiweZX4iEZS9Ih/sbRKnWY1vKhERp1jnKoxQX/mb9SSTcEoQwfxkxsZ/nh1zZeYA0tILJV1z20Q8sc+DGvqWdNvv3OGiqlSNP3U0Uqjhc7cFPOWf1YUhnsyYbF3pXGoZxaGdujWXET/5kzAxA3BiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BYUgN95uMmJVoFmFEchk+HigNMgilEkwMryJEZXBSY=;
 b=VVoIPpu4qF4vn3KtspPrA6vMa2zMiI5piMzIryGBtSUdOpDbxnJCbKYDREj4O7Jy5thI8HcB0kOAMIaJhMv2TvDM50pec6sIromdK0PZ0hOxYjFBOKml3yNjWPlq1XOvCR+hlewM4sjRd4kcLCe17DmyLf8NhOI4FVzpPQNzltNe80QwFZK7jRRK60prIvHbdgYwk6J7ZjUuM2mLUEeOFsmi3rt1mDxl7RE56mEBqwCQqRCeuQEIyAKzlqn7yG5oCjJZWYK7Tu7pkRS827MbJRZf9JDytNdDF6CqFrx8IL/ieLVZ7fo72WzE2LU2HsCQoe0ghoEpMKRjHKG/h+CRGw==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN3P287MB1814.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 07:16:41 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 07:16:41 +0000
Message-ID:
 <PN1P287MB281846EC1E6448397E17CC1DFE5A2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 13 Nov 2024 15:16:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2042
 MSI
To: Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1731296803.git.unicorn_wang@outlook.com>
 <5186bb9c7feebb87136eb5e5e117fb1142dba4c2.1731296803.git.unicorn_wang@outlook.com>
 <20241112155240.GA956207-robh@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241112155240.GA956207-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:214::7)
X-Microsoft-Original-Message-ID:
 <6e1c65fc-5059-4c37-a747-877b9778acfa@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN3P287MB1814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1b1821-32e0-4f99-c156-08dd03b31f24
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|6090799003|19110799003|7092599003|15080799006|10035399004|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1BQM3kxNk0xVmU3cUtQcUE5a0FhV0pPN1dhbXpzYkFCZm0xVFVxNGJkNGg5?=
 =?utf-8?B?QW5NN3FML25ac1hkNFJ2ZDZoUkpYeTB3QnJUTG41cGZMZXMwM21iWFFoRFRW?=
 =?utf-8?B?cU9oODFoUGJYa3MwVzBYT3ZoVjNpNUUzaWUvZ1ByN01aa3J1ZWVDbmQ0Z0JG?=
 =?utf-8?B?dVhReUtkVDhSRzJ2dENrc1FuK09LZ2hSTFMwZmlXYXB3WkI1aVFCdERNcFlJ?=
 =?utf-8?B?N2JpZklsd216TWVyRkVId1hRY0dzTjA0ckMwY1E3RzY3Wi9GTG1ST1EwZmZG?=
 =?utf-8?B?UktzWTBkM1NkT2dNU1Y3UXNsS0x0RDhGMnFwM1k3SW9wdG9vY1FJbXRkaHIy?=
 =?utf-8?B?MUpvMDdNekNlM0t5eDJNSWxEWDFVYUZBWkJRVGJjSkN3VFl4MG8xL3EwaG5i?=
 =?utf-8?B?NlQ3K0tjcDZZYzlsTHJzU2sxL29CejU4Njl5L1Z3UVJkZ1JLLzBhSHpmd01L?=
 =?utf-8?B?RWdkNHJ6TEg5TzZuVGZhYU4rODN2TDVpYU9JbzhWbzM3TFVZRk85NnlodmQ3?=
 =?utf-8?B?V3paWW1ndUI0ZEVWZmNUNGdpZ1F2RkF1Z3RsNnRsR2NMVVRDMVFoMC9XRUpy?=
 =?utf-8?B?aWpNM29xTENDaE80Q1BWTm1uMWFGbXdvenV4M2l2d0twVU84LzlIYTA0K3Qr?=
 =?utf-8?B?RGJ3K2FOMlE1VHhwWTZ3eGlDS1FMS0lmakkrMVVnOU9kblE1dWVmSEovS0hh?=
 =?utf-8?B?N1N0cW8zRTB3dWtrRTBXbWJ5aDY4UGVQODkxb3I0MUdSeE9iampqcTE5aVVw?=
 =?utf-8?B?NmNnWnExT2VPQVFZajIxTkFta2crVWQ0STBGamx3bEFWdGZ3ZC9QYUNBcFln?=
 =?utf-8?B?UlFCWXV0eGI4WS9iWnlldHptVkxyajRwMFhmWU9VMzl5RzR5cURRZk4zWDdH?=
 =?utf-8?B?T2c4UDFic3lsZEp0Yy8vQml4NjJjaXJXRVU3ZXZjNGg1RHZ6eGMxeitEM3dk?=
 =?utf-8?B?bk9QRXNmMHJ5cE93VzVkL2pLNEF3bnNCWFhoV1JqZ0lvSFBSa0laUENCVVBm?=
 =?utf-8?B?SjRjODR2d1liWjVRdTlPeUpiVGp5Z3hyWk5ZelozYXloUnNkQVViZnJhTmtU?=
 =?utf-8?B?OUhzL2JjNUxBOGxjTms0Y0MxMExPMkJCdUdpVW5hTGI4TWZXVHRLRFdENTZm?=
 =?utf-8?B?OHNUdjIyTTVQbmh5Ti9MZmdvNkI5RjIyWUh0YnVTWWNGeGVKMWtrZkJKRHBi?=
 =?utf-8?B?RWxyblA5OTNCM0IySzY2Y1RRT1NuTWZNSEF2aHQzSW0yS0JUUjA4eVAvMmJ0?=
 =?utf-8?B?Q3g0SHZua2p1SnNxa1d3ZnQ3emJUT0kwL0tWeStWYlBMNXgrVGcvUlhCc3Nl?=
 =?utf-8?B?TE5CR25UbXdXRU1CdzA4b3Q2RHJnbUJIZXdxb2o0UWdiTnFCSkRmTVB1QmlE?=
 =?utf-8?B?eHpjb051RXQxczg4cCtIRkFvTEIzYTZNOTE2cVdKK1hsT1hGM2VwQmJhMnpX?=
 =?utf-8?B?dEV1L0JWVDdmeUZEY3RkbFhyc2IrN3dNSWkxRnJnMFo1aElTZEZoOXc0cVhu?=
 =?utf-8?B?YjYrOHM0RkFnQy9NVVhCa1JkY1YxaHVKU3ZMREx2OVhhTWs1eG53T1J2WDNQ?=
 =?utf-8?Q?ZZVrBcKQfpw8nSI1kbwbubIKvtUXhdUBfEZ5lb7KSNv0ob?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldJaHBCcVUzMGtZNFloQkN2VHhLZ3Y3aVRMTzVwdXNIRnBpMlZiRGhRb3di?=
 =?utf-8?B?QVgvamxTdmhZVXBueUp1V2VvNU1rR29wZkc1R2RoQ0xNTFVNLzFDODloTkI3?=
 =?utf-8?B?WE1MdTdLaXdZYmVKdnJ4UVFJR3BVejE2L3owRGFIc0xCQU9DdytWZ2duOStm?=
 =?utf-8?B?Wk5tSHh0Skd1K2Rqazk5SW43VjlyOGp4Mm5pRVJrYnZnSkl6ZzU1VXBSK2w3?=
 =?utf-8?B?TnhHcGtkcVFkWEY0VURLbVc1N0tjYWhnR25Obi9lYzZDektQbSt5MjlwU3FV?=
 =?utf-8?B?dWYyczZZZWk4TGxoZVVjdVd5eklkTWsydnE4Z1ZMUVdqRWowV3hCTlpSTWN2?=
 =?utf-8?B?bGliYlVxbmxBd1NrbEZ2TGhZQ24yM2FOREV3WE53U1JBUFp5cTdNYmVzdmcy?=
 =?utf-8?B?MHVYM05vUC91SHV1S1pGckg1amNNQ2toWWU1MkJrMFd6cjNveFZtak5SalFy?=
 =?utf-8?B?L1loalJ5UkRhNlRQTTBoZ245RVA5NTY1aXBkZjc5WkxycnVueXhHVW5tRkdN?=
 =?utf-8?B?ZW5NalNMczIrUFl6VjRUQ2cvZlNGbG9pd3FEcHhQMGpzVEI2dkVqYVBlN21k?=
 =?utf-8?B?M1lVWnZEU0JoVitwbk5iSnVmemtESExWOUgwbFdHZHFUVHdrdDhUNU5JWUY5?=
 =?utf-8?B?U3RiY2JLV00wbFkremNoTkN3cDJ0Y1ZLRDFJcEMzclExQ2twdGdiMTdxeGtC?=
 =?utf-8?B?UHBaTjllcUxkNnJuVVlNalZ1RTRyVFIyZ3pZWWxWTzFOT1g2REVoS1FjUkhv?=
 =?utf-8?B?MXMzVWo0Nm9zdFFPM1M2RlQwd0ptWjR4ZUtMR0FneGlzZkZ2UGNxYllZL0Ny?=
 =?utf-8?B?TmhOdG9NcDhCUzhxRFJaV1EwK3Vvdm9lNFd0bERya2RpUnlBc01ENVcxdGZz?=
 =?utf-8?B?bEhYRE13eUgyQ2dlWU5LL05zYUVnUVBoMDJZVlg0b3cyL1pHZG1wRGlxQ0pK?=
 =?utf-8?B?elpGem9NWlJidUVTWWFFTk1Kb3cvNHM2YWxFSXkxMCtpVFQ4cWdxak9UQ251?=
 =?utf-8?B?a08zOUFWbWlLb3ByQzJJbTR0b1Y1MjNmQW92SnFmbFY2V0ZDM29nWTNSVm02?=
 =?utf-8?B?S2s0VW9GZisrZGdMT0Jzc3UxaWdoRERodDc5RnQzZXRmeWZQQjJtamFpS0Zz?=
 =?utf-8?B?U3BwQm9ZUlFBeTRZNjdUVDZMS3VaVlVoK204d1pZQjlrL2laTFdtQ0k5eXBl?=
 =?utf-8?B?Z2FxMG5qNjE4K2tmcm1NUWFQc0NRZ0xIcldLWC9tSmJPMlhPc29RTGFMMExv?=
 =?utf-8?B?SWdiZDg5anpTMk5aYjVTR0diQ1l3QWo0Z1JZSmFHZC9xVFNuTm9EMGM2dVRm?=
 =?utf-8?B?L0JGWlhxQnNJNEpUR251UFNxQjZURWVKMGcxbTlENnNtWjN5R2FYVlBsREVJ?=
 =?utf-8?B?c0VwRW51dGJxVUlOL3QzcXN0V045RTlDZVBDNko0U3cwbm9CVXI2SXpkMmp1?=
 =?utf-8?B?TVg3MVYraFArV1BLeVNwblR3NzhkSmcvM3BOalpXcWdmVlB0bElWQ3QrSEdy?=
 =?utf-8?B?UGxwRVpJVVhBTjA1RnJ1ejBJa2xRaVg4VzhiM1N0cFpTenV1b05OenRUTmdi?=
 =?utf-8?B?TkYzK0tnSExFaHNUNitKdS9lMzc1eVBvUTNPR1RXUGUzbytlVGY3VUc2NHUv?=
 =?utf-8?B?NGphbFdITW9IeXZwYVhVTDZNYVZhQURVSUhUY3IyRjhCbmlQWEJjd3NoSmFP?=
 =?utf-8?Q?KLYT09Qx3pJfcrRDCkV1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1b1821-32e0-4f99-c156-08dd03b31f24
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:16:41.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1814


On 2024/11/12 23:52, Rob Herring wrote:
> On Mon, Nov 11, 2024 at 12:01:36PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding for Sophgo SG2042 MSI controller.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../sophgo,sg2042-msi.yaml                    | 78 +++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
>> new file mode 100644
>> index 000000000000..9fe99b74c211
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-msi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 MSI Controller
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description:
>> +  This interrupt controller is in Sophgo SG2042 for transforming interrupts from
>> +  PCIe MSI to PLIC interrupts.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupts.yaml#
>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-msi
>> +
>> +  reg:
>> +    items:
>> +      - description: clear register
>> +
>> +  reg-names:
>> +    items:
>> +      - const: clr
>> +
>> +  sophgo,msi-doorbell-addr:
>> +    description:
>> +      u64 value of the MSI doorbell address
>> +    $ref: /schemas/types.yaml#/definitions/uint64
> Why not use a 'reg' entry?
>
> In any case, this should be a translatable address (i.e. honor
> #address-cells/#size-cells and ranges).
This is just a address to write MSI data, but not a register for driver 
access. So I think it seems better to configure it separately, rather 
than as other registers. This address does not need ioremap.

What do you think? I would like to hear your opinion.

Regards

Chen

>> +
>> +  sophgo,msi-base-vec:
>> +    description:
>> +      u32 value of the base of parent PLIC vector allocated
>> +      to MSI.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 64
>> +    maximum: 95
>> +
>> +  sophgo,msi-num-vecs:
>> +    description:
>> +      u32 value of the number of parent PLIC vectors allocated
>> +      to MSI.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 32
> Use 'msi-ranges' for these.
Got, will fix this and thanks.
>> +
>> +  msi-controller: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - msi-controller
>> +  - sophgo,msi-doorbell-addr
>> +  - sophgo,msi-base-vec
>> +  - sophgo,msi-num-vecs
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    msi: msi-controller@30000000 {
>> +      compatible = "sophgo,sg2042-msi";
>> +      reg = <0x30000000 0x4>;
>> +      reg-names = "clr";
>> +      msi-controller;
>> +      sophgo,msi-doorbell-addr = <0x00000070 0x30010300>;
>> +      sophgo,msi-base-vec = <64>;
>> +      sophgo,msi-num-vecs = <32>;
>> +      interrupt-parent = <&plic>;
>> +    };
>> -- 
>> 2.34.1
>>

