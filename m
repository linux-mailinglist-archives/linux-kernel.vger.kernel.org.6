Return-Path: <linux-kernel+bounces-560099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC9A5FDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E2A3BFEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE481607B4;
	Thu, 13 Mar 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aq/GNE2+"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020105.outbound.protection.outlook.com [40.93.198.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B178F4C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886900; cv=fail; b=RPBzvTsTttiBW/CL0m427dWk8uoigyoMssYa54fX0+7OP5KYJMKlqd4MZ4f/KYsYtwJXLElvxqoFxJcynwhC1imMTxpNs+DP12c/7sI+CbFB/WjjrxVBi4NvDelrAVn5hV2qYGV5Vj33+V96EkhkM2zgArwHx2Ow4naK4rM4j00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886900; c=relaxed/simple;
	bh=pWYivht6S71/EhQHwfPrvUIi99oAK2Zs+BM1umuotsc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKI6CHSxzNKhZy5F0VjldVVyxp9zc/j4VNSMKau6HUr7yik53nIPNzg2DS6U8vmk3s/HL1GVxKm5jCJNlLrd3fzjO8gnxOjyxO70+lOXrqjhCepRRXrD8FQyYq6UOgy04igMYwmPLoLoBZgEePW+5TGgQ7zLeymDCJm2BQjHIjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aq/GNE2+; arc=fail smtp.client-ip=40.93.198.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICFWZ6vbYIB4Bo/SW4PX6DYldQfWPtCBzfCoSdQhl6KmOT0ziNb27BM33c2MZKGXbuosTutaK0xXViT4cLSRsLG7bXQ6RUTXPj5mHqlHp8AXyvxmSWiblRNXvb9JbOwb/LvNXEQyDdcuAR82zYDL2if8n0IF5BkcsybtTVhrfjcKbDvp8fRQ3QgHi0wANAPEq1ewew99ecp1xssYlZlVaIY3dgbkEYssS/py9xecLVLIwIvabZ3MMy1v+A6xjjMndb8mxzm1/qR3k3F2IV9RB487vNadM5TLJPpYzeHuuTge9cVCoDjwXspRtop/YHUrTjZh9cC1CX2MdQHaCejAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z23qyvGrZwIce3eRshKC+nk0LVVmZFNVV1h/6S25ZeI=;
 b=HR1cD1lyNCyo4gvCU1BdELRZehqDSdYb8on0TjT8Tm2dB30osab3GSrNkYyadMB4ng44rfkRM3LmZNJi2In4G2eYBH2848PIaSXAE/W6moa5KjO33bJlK+phNgd1QR3RSDifszS1MNuEllDxhDBm10UtDj41yC0uchETzT+CDejpvYQAViyCHPiG6pRqpjkP0sbQFm9dFQcS3Rb37dtA6g93WNA1q6pvc5PQ7SJdtYdgrEWz0XxC5RzqHLVQbVB6WoBI3VAW57yNHTCBKbhzHUbT3hFQuwGLr/exDkK6dDpS1GIdNqSKFlUs3VZIcRdduUgahw7u8a7cUw1BKAG+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z23qyvGrZwIce3eRshKC+nk0LVVmZFNVV1h/6S25ZeI=;
 b=aq/GNE2+7copNVXjmGAgaBTYWPP+aakn0LHgK0SS3NExdlhfJwkYB+QM83aQIKVbJ3C8dB8yF3dfmz/rwcGOs7FKTyjyvyPBy58oTwMppiEgzxzxcpun4gHkzQE4HDx88+ylIBWnXe9dSlFBd0lOV51pfSba1s+kY4bW+ksP8Pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6604.prod.exchangelabs.com (2603:10b6:510:79::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Thu, 13 Mar 2025 17:28:15 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:28:14 +0000
Message-ID: <3750d3f8-17c6-4bb8-8107-215d442e4ec3@os.amperecomputing.com>
Date: Thu, 13 Mar 2025 10:28:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com, will@kernel.org, catalin.marinas@arm.com,
 Miko.Lenczewski@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <20250304222018.615808-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:930:13::32) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdb9461-762c-4a50-f3c8-08dd62546f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGY1WGZNWW15d3NsOVFVT2swa2UzSFk2M2U5YVJXbzlldWNoMG10Z2hmWEU2?=
 =?utf-8?B?OUgxdmd6dXhZNUpnUWRYRjRwUFNEM1RhdStWSnVCK2xUNUUvSTFaQWVTY0RF?=
 =?utf-8?B?YVpMMmlGcVg3eHZrN09DWXZOT2pwVVhaUzJKUEhrOFlHNGFOam5oYWY2ekQ0?=
 =?utf-8?B?YXFTc3hVWVpCZkxENlRuWFNJWnJBTWYrK3dOMnZQZFc0ZUJ3VmZXZTZOWWcz?=
 =?utf-8?B?TGl2ZTJQd1IwdlhSZDEzMURuaGlQYXhnbGluK3NkNFJ6UzlVV3RNVjUyNk5r?=
 =?utf-8?B?V25haFU3VmNheW5ZYzh6enRGN3VBbjdWbG1ST2c5KzQwamRHMjhQM3NkTTVv?=
 =?utf-8?B?bFZ1ZjdmWjJ5YmM2Tk04dlFOdXdOOWRSTnZnQUlmRFUzVzE1VUxJSEY2Nm9K?=
 =?utf-8?B?blZjTzhGKzhISHJsVmo5MlRIcXpsZG5CRmlHRU9oTmQ5MHlKRnB5ekJ2SXMx?=
 =?utf-8?B?T3FmTzlWNnFPWDlJNnNrZTVleUtta1k0YzZaRjM1OENrdW5jUUl6SnhwV3JV?=
 =?utf-8?B?aGVmc29uYjFMVEt5Y1FuWnhYbzlHdUw1NENNK2xYaW8rZlZzeU9GbktPWUJy?=
 =?utf-8?B?cFk4TkNqQVR2WktCQ3p0MmtaUE1uYmhCa0FVMUk2RGZ5cDlTTnVmd1k4R0ZO?=
 =?utf-8?B?R0V6NGxWSU94OEM4WFUwckwrRCtqd3RpWXJVNzlnbCtnUXllclc1SVV5blIz?=
 =?utf-8?B?ZTkxQmg3UTQ0V24xTjBwUUo1Y29maXdjdjQ3N1dwZHZYcjVtM3B3SWh6TXdR?=
 =?utf-8?B?ZXU3anZXejRhN1BqZkZ6dFN4QXp0OXZsK0Z1UGwrQUJBMys0WVJUYWlZeWJa?=
 =?utf-8?B?L2dpQk5sbXZsMXgvc1Aza2QwRDF4K0ZTL0J0MmpyOU5rYVRnaEs1cGhjenhm?=
 =?utf-8?B?V0FLWEFvdHJ1T3F1aHdOcDcxbkpsQ2tJYklKbGNnMjgyQ0pwMjZqTjV5eDZL?=
 =?utf-8?B?VlFsTHRIb0dIM2lOOUNQLy9lRlY4R3QrYWVqVkMxM2VTM0NVSi81eWVaOFRo?=
 =?utf-8?B?ZEtzamZGS2RJemw0cnRmc1Q1SjludkxhcEh2TkRqNXpIeGgxdkdwaWlOQi95?=
 =?utf-8?B?QVBmNmJZc1B5QkZoUHdzaW1ISVBES1JEMU5YYlBzYm5ZZEtpK2hza1JPTEpk?=
 =?utf-8?B?YWtjS2RuNGJzeVRaV3BYbTJGMTNxOXRWeWFycmcrTnE0MG5BdFA3ekVYVGFG?=
 =?utf-8?B?SlVvRitsc0JZclg5UExWN0drd3o4ZTFXN09BVDRyaVU0UjMxTGlzOGJTK0tC?=
 =?utf-8?B?VWs2T1FDVndRY3llTzUyR1YrRExRVXdOVDdkV0ZIWlBQRHRpSDZ3WFZZb0gw?=
 =?utf-8?B?UjhGdkdkVktOSmR1cnZTZ2QwM3FmaittSkwvZENFSjlEWnByOUYwbDhrcVd1?=
 =?utf-8?B?RytjN3FIMWt2cEN1R1pVVjlyTlQ0VE1NS1BHVUg0OXZqaWw1VmVFSmh6QmNS?=
 =?utf-8?B?TkEzL0xFWmlzc0Y5RVFQTERGQldpck44ejZWbjJTVXdmUzJVenZ0RzQxdTlI?=
 =?utf-8?B?M0daUytYeStzN3g0MUpMSlhScDNOQWEvNnd3bktGQUI4YmxyVjFFakVaMHc2?=
 =?utf-8?B?VER5NVlHRWErMWNuR3N0M0M5MUVGRjE4ODIxYi80TGVDME5idThoVmMrN0Zp?=
 =?utf-8?B?WGthb28xdUI3bk5TNm5uQU8vbEd6VnptL2xtSURKbTE0L0JPZkhMWlpNU2Yx?=
 =?utf-8?B?U2RUZGhPeEtRUCtRT1EzWXNUWVkzMldFWm1QWVM1WkVnaUM3RzlhM285emtk?=
 =?utf-8?B?SzVXVjR2OXVGZC8wd2dCcDdldmRxaGlDS2MzRHMrZkYxTmgyZEl1ZzNjK2Fw?=
 =?utf-8?B?RGVMNnlzVG14akQrR1dhM1cvcXNiT3Y2WTFZRzd5b0ZTZmlJTHpTVCtrYVky?=
 =?utf-8?Q?rwgISffIzNlQO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0FIWFM0UmxHbWhHYXM0WFdFb1FOaklDQzEvS1N0Nkt6UVByQ3h3U2Q4SUVU?=
 =?utf-8?B?ams3dzZRNUcrbXZuVEJlNERSeUxOQ2wwL1Z0SFZ6TzlJSTJLQ2FzVGw2M3U2?=
 =?utf-8?B?cmU5R3pXaUhSZHBQZmNQdDRpbUZQSndGR0czb0RyVElac2p0NndxT0tYN3c0?=
 =?utf-8?B?TWRRTWJmU0kra2MzN1ZDNklqRVpJcnJ4QzZySUhMb0VVWlBPUGhCdk9Qbjg2?=
 =?utf-8?B?MEJOUkY5RGV4SDdYR1Zyb3A3UFNDZSs1ZEpMZjFSNVVmbzJxUXJqRjREZUhM?=
 =?utf-8?B?ZStQS1hxN0FtMXVVaU9nSjdISDJ0RklYaDhIR1J6OWV3dExSc0ZWUWFRb1Vm?=
 =?utf-8?B?NHBwWjFxQmFZY1BRZ2NBQ25Rei9xZnhBQWZWYjM1cHdqZ0xsVmVnV0Mwak5J?=
 =?utf-8?B?Z2dDdFAwZDZSVllJeXBEL0JQZ1V3MUcvTStRWjVLSkhnOFhlUmFPYWQyNzVn?=
 =?utf-8?B?Q1RZOXVYNGd1Mkpkb1ZQM0ZPOCt4VCtHK1g2K3VFNmlaSVJzd3E1K3JuVGhU?=
 =?utf-8?B?SlpNcUFiK2pNOXpLaENtNVltQVdTOCs5cXNrVkxHQ1hqbkpHUXIvSmRIMUFv?=
 =?utf-8?B?RzBnT080eTIzcDhlYUpFS2c0SGV5aXVpaVRscUtWR0VhbkpjZG13eXloT3Za?=
 =?utf-8?B?Vm1RN2x4aUtCTE9KTlZjUFlWTHUxY3RzNWYrYWpOeGwwVkxhM0R2aEFKS0Fs?=
 =?utf-8?B?cFYveHZwQmF2WlI5bFNUK0syYno2MHlPQ0N1eC9GTkg3TjdwRTloNXljR0do?=
 =?utf-8?B?MU1XWStrZC9zYXBvY2s1Szk1bnNzOURMY1daQmJYNWdMTUQzYjduaEFYQ2Y3?=
 =?utf-8?B?bVU3QXg3Y0NqUVlkNUFHQklJbVEzQWlmOU1lY2Q0T25pQUwxbFFvcHdIb09u?=
 =?utf-8?B?ZWpXdTJCSkY4WEtTUjRLS05OL0pkWWQ4Q0puWks3MWtIdGxpbjNEWWNkZ0Zy?=
 =?utf-8?B?U1d3bFVWSDBjdzBObUFhTGNkVmN4cENaNTZsSyswdUdBMEE4RmZjNzhzUmJt?=
 =?utf-8?B?L3YvVS9rTVRYbDJQTHdwemFvbU04UGlVeHM3WFpwYllTS3ZNWXgveU9DUmMx?=
 =?utf-8?B?R1Rkd21zL09KSENZT3NUK1FERmkvcTg4a0lPUVY1UjBSSjBRdFM4ZEZQeXN2?=
 =?utf-8?B?K05Pb2VTRVlmYWdpV2RVQUdVT3lzQ0pUNERRdWV0Vk1ueE9CVlBxdENlQ05o?=
 =?utf-8?B?eFBCYUw0NUdqUUdEblp1TmVNNkZueHMzK1draEFNNEpPVnVQYVJHNXN4L3h4?=
 =?utf-8?B?emgxd0MrSjA0ZytZYUM0ODVEd3lCUlV4Z1dnVExLQkhzOGxpRUZpTlcwcUdM?=
 =?utf-8?B?V2NGSDVLK0NYTGhCWWVLcUxoZ3N3WG9uN3FUTEFNbHNmb1E4MW9RVlYzdGw3?=
 =?utf-8?B?dnA4NktNT0ROaVRiZmYwbUl2eGZRbUIydStYZGtTcVBmV216VDJ2Wk00MkFs?=
 =?utf-8?B?ODdkcXdDT3h2YSt3R0J2R2owSGs1dzJHNHpWajR1V0xkaXRvT1YwaVBFaGdB?=
 =?utf-8?B?Q0ltY2o1OXdkdEE1YzlwNVhJaDMyTURIK0EyTThDV0V0TkF2bWJsaXZzb2Vu?=
 =?utf-8?B?dmZ2VFZ6SGRmRC9OTHlxekZnOHJvTXVHWHkyRHZCZEJQRlloRWZyczBwb2VP?=
 =?utf-8?B?WXFkdXFTbERzOUFqOTNPd0lNYVpCb0s3b3dKYWVOU3FGdUp4aktRZEU5bGt3?=
 =?utf-8?B?NTBONHpyeFpLZVh3ckU1cE9oWUtPVTRab1ZMQURiVU1TY3Y3RFdReExLZlA3?=
 =?utf-8?B?S2ttVmxkUTh0ZHdTVDlBT1BQRzhOd0RzSWJCL3BCVzdrbVBkRGZFVWhwK01N?=
 =?utf-8?B?YkZrc3hGV1JpaEZxMEZCdUZYdHhNbGRuamRYQVJlOVlIRkVCUGRpcEx6aGJv?=
 =?utf-8?B?WmF3ZmlvVVlSajk4OGtwVmR4TWNxWVMwL1NTZTZ6UERDY2ZtbEFuL3BYNHJq?=
 =?utf-8?B?UUptKzlmK013ck1xeDk0VU5telVXeWU3QlJVdUdrVlk0dTJSWFFyZEJnUHZ6?=
 =?utf-8?B?OWN3cFZDSE9PM0JONzZhbDVtT0NxM1UyRktZVS9SNEdEd2EwMXl0S0EvYnpm?=
 =?utf-8?B?QkMzNllLUVNqUlZBRUN2QXVpSjl5cnIxQUN1RC82MS9HRHhDZlBJdVloV3h2?=
 =?utf-8?B?QmJUdHBtTnlIMVgvS2t5NHZNNUlicmptaFNUNnVYbXo2aWhuVEI1eTFWQnpz?=
 =?utf-8?Q?qg5rpzoJ8TwDEc80wxLG0Vg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdb9461-762c-4a50-f3c8-08dd62546f63
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:28:14.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQrWm9BLMOVflR++rvvmzLZuUVgF5ShgVd2cwEENGxJChgZb9X5OgYXvm8tRnUbuC5fB8YLrXiWoFvWp7rEGWgPTHFsukOgpb9b95UI+CfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6604

Hi Ryan,

I saw Miko posted a new spin of his patches. There are some slight 
changes that have impact to my patches (basically check the new boot 
parameter). Do you prefer I rebase my patches on top of his new spin 
right now then restart review from the new spin or review the current 
patches then solve the new review comments and rebase to Miko's new spin 
together?

Thanks,
Yang


On 3/4/25 2:19 PM, Yang Shi wrote:
> Changelog
> =========
> v3:
>    * Rebased to v6.14-rc4.
>    * Based on Miko's BBML2 cpufeature patch (https://lore.kernel.org/linux-arm-kernel/20250228182403.6269-3-miko.lenczewski@arm.com/).
>      Also included in this series in order to have the complete patchset.
>    * Enhanced __create_pgd_mapping() to handle split as well per Ryan.
>    * Supported CONT mappings per Ryan.
>    * Supported asymmetric system by splitting kernel linear mapping if such
>      system is detected per Ryan. I don't have such system to test, so the
>      testing is done by hacking kernel to call linear mapping repainting
>      unconditionally. The linear mapping doesn't have any block and cont
>      mappings after booting.
>
> RFC v2:
>    * Used allowlist to advertise BBM lv2 on the CPUs which can handle TLB
>      conflict gracefully per Will Deacon
>    * Rebased onto v6.13-rc5
>    * https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-yang@os.amperecomputing.com/
>
> RFC v1: https://lore.kernel.org/lkml/20241118181711.962576-1-yang@os.amperecomputing.com/
>
> Description
> ===========
> When rodata=full kernel linear mapping is mapped by PTE due to arm's
> break-before-make rule.
>
> A number of performance issues arise when the kernel linear map is using
> PTE entries due to arm's break-before-make rule:
>    - performance degradation
>    - more TLB pressure
>    - memory waste for kernel page table
>
> These issues can be avoided by specifying rodata=on the kernel command
> line but this disables the alias checks on page table permissions and
> therefore compromises security somewhat.
>
> With FEAT_BBM level 2 support it is no longer necessary to invalidate the
> page table entry when changing page sizes.  This allows the kernel to
> split large mappings after boot is complete.
>
> This patch adds support for splitting large mappings when FEAT_BBM level 2
> is available and rodata=full is used. This functionality will be used
> when modifying page permissions for individual page frames.
>
> Without FEAT_BBM level 2 we will keep the kernel linear map using PTEs
> only.
>
> If the system is asymmetric, the kernel linear mapping may be repainted once
> the BBML2 capability is finalized on all CPUs.  See patch #6 for more details.
>
> We saw significant performance increases in some benchmarks with
> rodata=full without compromising the security features of the kernel.
>
> Testing
> =======
> The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
> 4K page size + 48 bit VA.
>
> Function test (4K/16K/64K page size)
>    - Kernel boot.  Kernel needs change kernel linear mapping permission at
>      boot stage, if the patch didn't work, kernel typically didn't boot.
>    - Module stress from stress-ng. Kernel module load change permission for
>      linear mapping.
>    - A test kernel module which allocates 80% of total memory via vmalloc(),
>      then change the vmalloc area permission to RO, this also change linear
>      mapping permission to RO, then change it back before vfree(). Then launch
>      a VM which consumes almost all physical memory.
>    - VM with the patchset applied in guest kernel too.
>    - Kernel build in VM with guest kernel which has this series applied.
>    - rodata=on. Make sure other rodata mode is not broken.
>    - Boot on the machine which doesn't support BBML2.
>
> Performance
> ===========
> Memory consumption
> Before:
> MemTotal:       258988984 kB
> MemFree:        254821700 kB
>
> After:
> MemTotal:       259505132 kB
> MemFree:        255410264 kB
>
> Around 500MB more memory are free to use.  The larger the machine, the
> more memory saved.
>
> Performance benchmarking
> * Memcached
> We saw performance degradation when running Memcached benchmark with
> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
> With this patchset we saw ops/sec is increased by around 3.5%, P99
> latency is reduced by around 9.6%.
> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
> MPKI is reduced by 28.5%.
>
> The benchmark data is now on par with rodata=on too.
>
> * Disk encryption (dm-crypt) benchmark
> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
> encryption (by dm-crypt).
> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>      --name=iops-test-job --eta-newline=1 --size 100G
>
> The IOPS is increased by 90% - 150% (the variance is high, but the worst
> number of good case is around 90% more than the best number of bad case).
> The bandwidth is increased and the avg clat is reduced proportionally.
>
> * Sequential file read
> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
> The bandwidth is increased by 150%.
>
>
> Mikołaj Lenczewski (1):
>        arm64: Add BBM Level 2 cpu feature
>
> Yang Shi (5):
>        arm64: cpufeature: add AmpereOne to BBML2 allow list
>        arm64: mm: make __create_pgd_mapping() and helpers non-void
>        arm64: mm: support large block mapping when rodata=full
>        arm64: mm: support split CONT mappings
>        arm64: mm: split linear mapping if BBML2 is not supported on secondary CPUs
>
>   arch/arm64/Kconfig                  |  11 +++++
>   arch/arm64/include/asm/cpucaps.h    |   2 +
>   arch/arm64/include/asm/cpufeature.h |  15 ++++++
>   arch/arm64/include/asm/mmu.h        |   4 ++
>   arch/arm64/include/asm/pgtable.h    |  12 ++++-
>   arch/arm64/kernel/cpufeature.c      |  95 +++++++++++++++++++++++++++++++++++++
>   arch/arm64/mm/mmu.c                 | 397 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
>   arch/arm64/mm/pageattr.c            |  37 ++++++++++++---
>   arch/arm64/tools/cpucaps            |   1 +
>   9 files changed, 518 insertions(+), 56 deletions(-)
>
>


