Return-Path: <linux-kernel+bounces-565778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B460A66F08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80D87A3195
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E41FBEA6;
	Tue, 18 Mar 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l+LTNxbU"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BE1A3056
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287870; cv=fail; b=R6ObhITUlAH2Ne1D55PKmvm9tgetZRKwn+HGwLPimmRJx0xjn8qY12j1V88Tsn/bzcsXjIu1TgJNbins36uvptvQj+URhShM5rm7OaxYJkDFCW+G1POhMMaBhXs3n3BCyJUaJJguhJgb0x2U235X0BVpGcaGvbLKF0EqeOqpGZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287870; c=relaxed/simple;
	bh=us+ejGcKenRv7IbG2axPBQdi1HsCp4d5QgUelBMUtoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGqmsmtVE5qAqCcmaOF3hyGaN8yKzTez6zQ1Njqfj9yncnDyZ6rRdXDQ10U7IVWbyspPzEjZfUI7v+5Hg4ojxmwvzvbf0A5ijtOKqUrXGKbpIM6oWipRgNbPIuvNen7+OGqc3bvV1+1ENx+zPKOU6pPAbWxMzb9pZ7XZaVkVpZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l+LTNxbU; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skQRqUy4wSDkUvwj05qjdnWUt8XIik2cdhQ6Lhg2/wHGVLHjaLh/9ERZGowGGdbs1GwhxujHtwaPHm5Gu1nW9l7AU4bK7habA6bEYPihWodAAtxWBR8d2/dDN/iP4uUQlYpVK7kSr+iEDQssUebpsSsrfGNYuZsv160xBR71dgAuUc5wZ6lWXxIyImTN3jKVpV/5ZF09xKd/YrJSsRlycWK6sNCb/1ccokxGuYGw919N+F9fL19FY1Co5FcAJxYJm6J6guNGT51PahaZKkFitzETKlx8k5JFnYITiLawInk2vvYldyFCPazUIBrhuwaWgAFHjictQHTh2b1+NavBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmUUwifMn5mPLIIUkgJwKXOQK7rXMG40FoUyjRfaJLU=;
 b=F1eE5GiwlHF3tqwT7iljgFQxuvsKgQogWS1Z6D06lND5N2H3NdZCZE9mpeeiMqpd6zIbUZfFvoz/JdaCvtMdVrn41I8F47KC8VYxXYgDY7MSM2z5r01cFdytT6bniLurmILbLQRRS0vdJVb4C3PDEyCYmz7AEz63WQQfh2sAspm3ttmHem9C0pAhI3fMuh4XDn85JjZ0s1o2tbtdjCPWB2S6yo5nGs96pewitfpS726EKdlsg5eaFWZwQRUYyNUlBwxbJDWPGeRXoSznjbDXXxVxC1lpOeAuzVojtGnriJd9Lp84CIxAfLKIbcCnzVhuB++l+uJgOW5+btG1GZWerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmUUwifMn5mPLIIUkgJwKXOQK7rXMG40FoUyjRfaJLU=;
 b=l+LTNxbUTh2IxFdt65Xogay79l6LUtNmSvrqrsS3iRTXWlLmW4NozaCQVieyhs+YTUGi59Q18cpJxo1aBaNmIlb9M54Jh39Wb+0HnmYXoi3aCK3k+TWi372gpvtzKWhxwQPSFzBizDVlkOv5k4u5qbM/tM79zddwZIy1+7lZCxBN9YIqREKij9sn1EuTuBkCEgZf8hYwY2i4rk2DlaL+qqewi1XSkB7bGA7cCfJ2+e5Art8W/C66/mzkU4e/RanZfi9RdGg+u/44Xe+b3K9kBs6PVfO+Y44DHUEJajdSry6/9hDDtnf+BvzU0xJD//U2/qfvzFVA+R/ClmkfDFayqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:50:59 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:50:59 +0000
Message-ID: <59656301-8224-407b-a16a-868a314f29f9@vivo.com>
Date: Tue, 18 Mar 2025 16:50:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com,
 vivek.kasireddy@intel.com
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
 <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
 <20250318084453.GB19274@lst.de>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250318084453.GB19274@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TY0PR06MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c6d562-9f78-46f8-26dd-08dd65fa00d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eER4Z2V6akhYK2kyK1JGbWhTRVduUGVqNHVRM1FmRE9qYkJPQkRSZTBQZWdG?=
 =?utf-8?B?S1FtSk94TGF4RjArMnByaTFSRWN3Z3JLZU5kR2xQdTJJS0pzdmNHeGVKRWxm?=
 =?utf-8?B?YkpUb3FFTVZUaG5JZVZtWjlrZk90RTNvL1JiMDVySk85UWpyVUNzbTNOTk05?=
 =?utf-8?B?YmpRd3cyM3NjYTFwdWV1UXV6bWpPbkhKZ2hrSVNPYVZwaERWUWo1OFdqWEVX?=
 =?utf-8?B?ZGZOYTVWak42b1dOQUpTTUc0L1dSRy85U0ZxOCtVVlVpRjlyMUdrTURhV0hY?=
 =?utf-8?B?SnJUcS9RbXZxUFpVODhOR3Z6RUtWZVU1bk1QWUpTekE3ZDlEc0toeHU4aHVv?=
 =?utf-8?B?c3A1N2ZobjlRVVNDTWRjMmtRVFVQU1F2WXpXeWE5SGJISDM2U01WUFJiamU1?=
 =?utf-8?B?Q2RzUXhXRjFnUjl4bWxIVVRRSjJmWkxIOWExYjNQNCtqb2RYRnkyeTBGYklo?=
 =?utf-8?B?UTRwUFlRekxZV0hjbWNIOHhLNklNMGdyekFrcjd4ZWVseFVqVnhDbGJ6ZHdJ?=
 =?utf-8?B?ZnNBYndrSTBpMHVHOVFiNEpZL2ZQR25ZTkx1WDBRUFBFODlRejZCK1lJRHp1?=
 =?utf-8?B?b0J3QzJKMm5NSmt0d1JnYW92bnJYU1RXSlR5b0JTUVFMOGtUVGZ5M0pjQlVJ?=
 =?utf-8?B?d0NDdnNzZFFHejI3dUhhQWRNVjZBVnhidXVDVFd3eFFoWlJYWmdjSEQwdXFG?=
 =?utf-8?B?WmhvWnJiWmYybVdhdUd6SVpuQy9yTG9yQ2wvNmxDekVRVWt3K1hKcW1qMHE5?=
 =?utf-8?B?MWpLajNqZ2pGSWFsUVJaYjVuWkF5empZd3pJdTllMTRtNEpvU1o1QWVCK3pH?=
 =?utf-8?B?NUIrdzZsWStlYytxazhyOTdENWY0NnZENXFwOEdrdEVUVzkxN0lET0RBbk82?=
 =?utf-8?B?RXBjOGVPRGcwaUVDZXg3TkQ3KzJlTDNDMmtMUmJzZ2xzQ3k5YlRlZU9WTmpk?=
 =?utf-8?B?bzBWcE95emtIR05XT3IycXBhZ1lPTmY5bG44OW43V1pVaVZJM0ljVDFpMDg5?=
 =?utf-8?B?TTlxMzdUcTk3ZUVEczVkdTRYSWpGNXRPbHZJNWZST3dKanpjYjZmOWxsekRz?=
 =?utf-8?B?NmwxTk1oVWNydEVLbWtMb24vcjZ0bUNSdHFqTm4zWlhpUHRjK0p3WE5jYlNH?=
 =?utf-8?B?eFZwZXhkaDVjUFp3Q0ZpTnpwTlRSK1FUbURrZ0VJK3RvR010TlRzWEZqZnhy?=
 =?utf-8?B?RXp5QXNCZmUvd0pzVDFTQUUrUml6L01uV3BMM25FZ3duUmw2RHlMR2ZxM0Q1?=
 =?utf-8?B?QWJWRG1aejc4Q0ZYVGpKVnNjaW5MeTFBaXhkaThjaTlldzV0dUUxdm1PWDJR?=
 =?utf-8?B?QjFFZ0tQeGRYMkJjbnhzWXoydHV2ZDFzejhESEVCTlM1eER4Y0dWdVdlRXRQ?=
 =?utf-8?B?d25UWkxLL1FlSjVjNFhycGxPVVdhcHM5eGY2R3Bhbk5BSm5iVnhoay8zRHZq?=
 =?utf-8?B?dEpLdFVjMmtCWWY4K3VHVWY5KzVOcGNybVN2bWorbGFGQTRpZHJuTmlVaHBB?=
 =?utf-8?B?TXZUZ29UcEY3VXJyK052RjNnUWFZcWtXbXV4R2xBTXRLSS9IRHNiOU5RV3RU?=
 =?utf-8?B?M0pGRXlrd0N2YmY5NFkzaVcxRDJwanV6VnlsR0hOaVBqN1J1bmI4d2dIbFN4?=
 =?utf-8?B?dWNzM3FmNFF6SEZhM01CMTZQQ0V2bGpaZEVvS1BtZ1FVSlluRXdCV3o0T2Fo?=
 =?utf-8?B?MWU1cmdGZ21INWhqUGVBdmFJbFRHNHlHZWxlZWpRbFdIdTFEVlhvdHZTOUJL?=
 =?utf-8?B?U28wbmc1WlR1OUJjQW5PamNJTUtGUlVhdWhZTitCY2NiU0tKbFJwblBvZitE?=
 =?utf-8?B?TXdTL3VGOTJXb0hhcXM2Q05TdkRrSDVVZG96dUplMlhZSTgzeTdwSVQwUWY5?=
 =?utf-8?B?dk9xczZFOTB2OXJjeFJ1OUNELys4Y2FXUTdTcFI3ZGhGUnpTWXRaRmZPazJk?=
 =?utf-8?Q?NrEYOFYykr0yZK8Zy9+Cm38YF+AeB/IE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1EvMzdlNU9lT1J0WlBHN1JkNGEyY0FRVldlQVJpREQyZjl0Vm1yVlF4bmZT?=
 =?utf-8?B?d3Ivc1RPNmd4enpGMFoxNmJEK01CSlk3clhRbGVUQm9Zbnc2R0JUVklrUTI4?=
 =?utf-8?B?MTl0WmNVMm1BU2NDMk82NVBKVjFsS2I4SzQ3L3IwK0ZFL0w3TndISG9GMXJp?=
 =?utf-8?B?MkdYVEsvRENNSHlKVFl3K1BNOVFhMy9nZXB3NkY0YnJBSElUVFpYT3FiS1JY?=
 =?utf-8?B?elVZSzNnc1lxVnNpZGdDSlg1MGtGR1BKTE9yZUVuZlpwNGNTck4vd3A0NEdx?=
 =?utf-8?B?UGtNM2ZhVjU1clRpaElvTTBWSzNtWFp2OGJjNDlhVFNwaStTcU5SUEVMUFdM?=
 =?utf-8?B?Q01TZk1MVFpVS1NxUFdyV0dTeDE4eGtUQjVFdVF5Rm5DNi95NWowTk9kQXpy?=
 =?utf-8?B?RHFrWXAyQzE0NjV6YkN4eE8zdjdROUo2MUFaSWJMTERpcmdveUI2T1lSY01u?=
 =?utf-8?B?Z2thU2lKV0xQR1phNVBoQ0tQWVlrQ2VEcE8yMGE1YzRocXVQdzVRaHJ2Vk16?=
 =?utf-8?B?dzVXeXBYRGg0ZkRTUEFiMTdEUllmeGdDT3lKOCt2aFlKSGpMRkUybnczMWls?=
 =?utf-8?B?QWtmYkgzTVVqczNMalE0VnZJN3dhekhmcW13dDRTQkxLbmhUbHIrZ2d3TXpQ?=
 =?utf-8?B?N0VmVGVKRjdYZ2l3Zjc5NmNRSkxob3RPSFBZYXRXR3ZVRStWVmZ3OTBBTEZ4?=
 =?utf-8?B?SGVjMThkMENSMVVpMHhRYXdyWXkrWU1TVER2dU1MOUFGWXpxamp6L3ljemor?=
 =?utf-8?B?OStvVEQ5cTB3TlFxL2hJZ3hHWTB4S2FTRE01eU5iMFdjM0ZoaGRkRXUwVTVI?=
 =?utf-8?B?MERobFdCQ3FVb2o3QVVwQU5McDhFaFN4WEJueVBYUGNxZmpBYVd3MTFSRE84?=
 =?utf-8?B?TGh1bGVEcGd3cWpDbjhGdE1yRWxrOU1tOGNzR3BnU0pOMEkyL3BZZjA3bGFs?=
 =?utf-8?B?a3cyYUlDdC9rTDFGMEJGeERhSXBZaUk5eUtFdWhMRlE0TFpSa29lbHVwdmZL?=
 =?utf-8?B?QmkvNWw0cVV4Y2JsV2NRQU53SERsLzVGTGt5RzdOMTZaOGJHR1Noc3J6dXRp?=
 =?utf-8?B?dll3NjgvRmlrSEFxZmVYaXNsMWx5amdIbFlrY29OTXdISTc1VmJMMUFHNHlN?=
 =?utf-8?B?L2xialRTOUFyWWI3dlRNWHg5a2FGdmpMMmtNOWtveVNMWk1sek5LNGMvWHdr?=
 =?utf-8?B?d1FPazdBalhMMkxHYjBVR2lCUkRDbDRqNXFhcUE5ZG5mUXB4WUlvallwdWtU?=
 =?utf-8?B?c1BzWU40T2ZNY1MvNmZ6N3kwYnNBempQYkFWMktvVnZ1aXN4aUsrUFJ4MXJw?=
 =?utf-8?B?aTdjek5qaFJyMlBzUDdjSExZOENsL00yT1VveWVWdHBFNDNpVHQvNkpQZ0Zp?=
 =?utf-8?B?eGlqQ1pRNnkyUEthRFdyWWxjNHlSd21OTUwwZXRsT2FaVzRSUjllUXFLVVdP?=
 =?utf-8?B?eHUyR2RqUVcyUFNsc092bTI5OUZ4b082UGhPL2NEeGttSlVMUjcwUW95L1NP?=
 =?utf-8?B?ZThxRmxRWGtHZis5a0tIRzJBQTJ0QUoyMCtGUUlXNVJVMkhZaUVydUJUL1I0?=
 =?utf-8?B?cUtNNENwN0U5NUExZURiaWxGdnZQYldtZnNBN2VvT200T2RhVitjTHJsUlpI?=
 =?utf-8?B?Qk9KTDRONE4vSW1VVDZWQmJiQzU5NnJIQ3orbEMyOXM1dDBQK2ZSUHNiM05o?=
 =?utf-8?B?SU1KUVJ6Sk9zZVhkMExvNkxMQ2FYeVJobnpxSTRSNWN6SW5KcERid0hsSXBD?=
 =?utf-8?B?QTRaN2gyOUdWZi91ZGxmUWlVdWJ0VktBL2F3QnBIendHUWtlNUl4SU9CUUYz?=
 =?utf-8?B?U1ZCWjEyb244aG1WdGpaRnRUWUxUNVo0Kzg5RWswUmRxR2xtZGhlWW52QWN1?=
 =?utf-8?B?dm9KajJBZ1hiQytxYXljejNEL0tQQ0tWdThvV0h1cTBpdnM4NXpqVWdYSTN2?=
 =?utf-8?B?eUp6T3dudTc4MEZCbEtkcFI2aWRDMk9TaFJEWG0vRG9ZcGIzMXRtV09BajZW?=
 =?utf-8?B?elNmMEVLSzJqUDVsQi9wZFM0dXNkb05SR2VZaHNVZHVYZGgrOEdaWWtEQ29Z?=
 =?utf-8?B?WmpwZWg3Y1VqK1VCMkFwMlNhQWdCSXJpSWtjNUZMMU00NDZRSFBCTHR2NFg3?=
 =?utf-8?Q?aAMlOJf3VRd73pUpyUxOaSARa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c6d562-9f78-46f8-26dd-08dd65fa00d9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:50:58.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7kabjJK3x9Cl1Lfs3iKMxsgMNVvZp+bqNztA2rKltSNUD0kBbM3drzQRI4gKZN+/gmkmR5WekZnj37dr0ZzWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

HI Christoph

在 2025/3/18 16:44, Christoph Hellwig 写道:
> [You don't often get email from hch@lst.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Mar 18, 2025 at 04:39:40PM +0800, Huan Yang wrote:
>> A folio may be 2MB or more large 1GB, what if we only need a little, 1M or 512MB, can vmap based on folio can solve it?
> Then you only map part of it by passing a length argument.  Note that
> in general when you have these large folios you also don't have highmem,
> so if you only map one of them, or part of one of them you don't actually
> need vmap at all and can just use folio-address..

The situation remains complex. We are not only referring to this single folio, but it may be composed

of multiple folios and start with a small piece. For example:

Folio 1 2M - use 1M

Folio 2 2M - use 2M

....

Combine these folios into memory used by udmabuf. So, directly virtual memory useless. :)

>
>> Normally, can offer 4k-page based array map it. But consider HVO, can't. That's why wanto base on pfn.
> Well, for any large folio using this 4k based page interface is
> actually highly inefficient.  So let's fix that.  And my loop in
Yes, indeed. You mentioned good to entire folio array mapped into vmalloc, I guest here are many user like it.
> willy as Mr. Folio while you're at it.
I'd like to research it, but not too fast. :)
>

