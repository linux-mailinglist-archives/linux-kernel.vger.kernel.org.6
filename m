Return-Path: <linux-kernel+bounces-348037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3998E1BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66C0B25CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DF1D1730;
	Wed,  2 Oct 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Rd8SbFZQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144EC1D175A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890786; cv=fail; b=tfRfQK+mtsWYbngMUYdYJMLAYT4pAPYLFidJ8pLpifEU37ZsvLYhY7l5H94O3FvuOzwVLWSqt50fIoDMcl10P/8bTUgQg7pqADQoJmJbkryU6X98cSa3peu9E7uJeGF39HOhN2xzcLxHQqs5L+nCQNT1IzoNjByKw9b15vi7VT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890786; c=relaxed/simple;
	bh=t542XBRuGFkoVYXmBIJzIt7tiXuHlVoCIDCb2SdF8dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M8wP4g7X68mYAHrBeBIlF71yA6S7yaIoBYgaa8wwkbiTOyFRxNF7FLjE75z9bGmGFS8EQINnZ8nPFG3WQ9lHOpSJY/7BntA0dfa4sRldcKrgoKppHWUiB/SpHyZRgAWXpVXZfUptsQnWj0eJmn2A2BJ54Aq+xrC3wMT5fpRPm4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Rd8SbFZQ; arc=fail smtp.client-ip=40.107.243.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN8dVjlIEYUc3CHZo7+g3rCvfauJ5TuaTPRKgXLxKNH8bgH0pLkbeQ70oF/Bi9AhfLq0bECqY55v2q0yTc6pJ2q4FqEwJUh+0b6qGXB1LIMxOAjBBb9K8JTzY4TjAwemNoIKeiHfRTqHIeXspP7D0cYG+AxG9uMxrRGaftOJBq1EI4bUeZ3X/47/7X3xZWxd0FP+asXURMMjtZZAnyXEzceWuxwmtTtoOUHTJzSo+b86p4Egj/ysSTKlRpMIKt/HZxSi0ARIJLPoAv3zBUBtmhZiHHjwOnpVwa0p1XJumNSjie56sTf1LSpj7gQkQ9es9qhGqJLEucZq3KZkguxZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpYWtD0vrdBxbz3DyMWu+MfUA4DKV44w3B55TgwcYOk=;
 b=hr9RV15sJKCedqAnKmiifCUMmAuuhoxN/upT/3G/Ety74/Cl6ysDOPDujwaZnqfRmYIFogUSPjThrSHEaymNYI5Svq0FbCworBZbBoFjBG2vVXxTxZwcgLJ9PoaCFem0WzCNTY6XuXfeydtsdTsALmiMV/54Da3+4zwYPtTmX6OGxs4BBUex1xmkwD02tf3/0wwk40zr7UkKtj4Rkd2xBKY2+bXY/uVOhwy6jBhzBas2d3OGyb3QgTNGwiY1hLHNRN8U734j0ECSlR7hDC+JTuQQqPLouR8Xh4J3v2+CiQ634ZwfonDCkaEk7QzAFWAtdVodTxKu3RuQxEMdQpoj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpYWtD0vrdBxbz3DyMWu+MfUA4DKV44w3B55TgwcYOk=;
 b=Rd8SbFZQ0J7Xgxz/CxZr7PEMaIec1BKpplWOUYWWXElDtGzlL90ra4SCiUxHbW5NMX5yudebn2GFfyvdbH6dTi+Ws57xnV15z2AfbeWY82ZNG/qh8OuYEYuCLDRhe1XrT1eIyTYB5ElF1rq9EdioUTfvijUsqfomtlap9ESnJyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM8PR01MB7109.prod.exchangelabs.com (2603:10b6:8:a::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Wed, 2 Oct 2024 17:39:40 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 17:39:40 +0000
Message-ID: <3e772c30-d7b0-409c-83f1-5fc5a961567e@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 10:39:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: James Morse <james.morse@arm.com>, jgg@ziepe.ca, nicolinc@nvidia.com,
 will@kernel.org, robin.murphy@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <d4b53bbb-333a-45b9-9eb0-23ddd0820a14@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::18) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM8PR01MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c844088-ce56-4f53-cafb-08dce309316a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1VSQXpIcHNheVczdGp4NkYvc3I5WUhhRUUreURjWGtPbjFpdHBUbHl4Q0xR?=
 =?utf-8?B?RkhwNGFLeEZ5WXF4WktsUXVBd0JpckZkcUl3dzREdmVJU0ljbEh6L1g1KzJv?=
 =?utf-8?B?RWg2SThNM3VCYU1kbWlHaHBqT2Vkekl3ZGh1VEtyc3BUWk1RcWRQb1NwTi9k?=
 =?utf-8?B?YW5GTHE2VjlXaFV1dTNibnBXR3ZsTloxdi9pV1ZmZUI4aE9JN3k3T0JiaUZw?=
 =?utf-8?B?SDNCT2VQSmI0dWYzcS9FdkVkQk00dm1MS05JRE9hbStGUmE4dGZNQ2RNbzVR?=
 =?utf-8?B?Q241QytoLzRxMkJHLzlMRVZzdDhJRk9POXM5MVNGSmFpblZxc002L3NaamJ2?=
 =?utf-8?B?cGhSVnVOSXZHbHNLeXFOcitoOHlXMzdwTWNjN1J2S3hrRHJoNUd2VFZuTDRB?=
 =?utf-8?B?bUlISVRYb0xUNk5DSTY3T0hOcGRaTng4UlBHTFFSckJtb0YvRDlTNmJ0ZEdP?=
 =?utf-8?B?NXlhRENIbmEwVHNwWktoNHNMUWRPc2R6eFptWG9xNUpBVDdSM1gxb2xKbThu?=
 =?utf-8?B?d2s3QVpEOW95TnluUkRYV2JBSU9MUm9Wd0cyN3huSzJTcTc1a1BvR29jblNi?=
 =?utf-8?B?TlR1UTltazZ4NTJqcVI2VlM5a3k3TXd0cXVVSk5Ja01oVitLL2hxTHYxL2tp?=
 =?utf-8?B?SjdoSGxrbzBLZjdmb2o0QXRPcWlyZ3U1Mk1LUitHYzBOYlhYM1FBaThMYmtB?=
 =?utf-8?B?N0hSaU8xZlgyVXMzdGpXZ2xDYUNQT2pXREk2Q2VCbGFBQTJVdkV5cy9taFRG?=
 =?utf-8?B?b0E2cng2ZTUwWmQxck5UdWloMER2dGtlb1JmNWtwUkVRc2w3MG92WlF1YXRt?=
 =?utf-8?B?T0FKTnlBZ1lkamZwcUZoaTNtNHAzVVZKWExZcHlxNG91bmE5aml5cFI3TUVB?=
 =?utf-8?B?WjJMcVdCcTlXOC9WTjc3VzNwTWdGbUN1YUxFU0YzaGE4UEpEYk5Id2ErZnlW?=
 =?utf-8?B?Qmt6NkNHRU5GVVdVYkJwMHRJUVdVblJ4SWhiS0h1UHgwK2hxUkVvSDY0WUQ5?=
 =?utf-8?B?REFMOXFNSy9ubkRQNTZ3Yms3cENJTjRhMFg5UDgyVHc1ckFKZ0dKNlk4ZVlS?=
 =?utf-8?B?SUNZYUcyOWU5aExnN3JSWVBOeVBmazlOS3dnQUE5Q1hJZWZEWnE0QnRCQy9w?=
 =?utf-8?B?K0J0OXBRQ2djeEVzTHBES1VZb3VKREl4SHp0SkJ1cmkrT3pleGxxYUhPYUY1?=
 =?utf-8?B?ZFdRMkJNL0dmN3p0OUd3cG9TNThTcVNOTGNieWo1K21tSyticjd4MERoYUgr?=
 =?utf-8?B?WG5LVEFEblN4YURMbUsrb3ozNU5RVzREd1VwUzRCV0h0ZThHaXZIQ1MyUEVm?=
 =?utf-8?B?RCtydkZyaGdSNG5MNGlXcU5ZdjhSajNNMk1zaUh4K3FIdzVsajFxbHhPdEZl?=
 =?utf-8?B?UnJRaG1KNEJKUjNubURTK3c2VXRtRk1FaVc4dXBhMjQzRWdGVEQybWgyQTA2?=
 =?utf-8?B?WnZvbExZSS9mSHhRZjNNVUFPS0pmOFBqUXUvcXRGL0QxRks5d3NsRzljbWY1?=
 =?utf-8?B?dVQvNU5lTXNPc2pxMTlzL3FweVI3dUFOUEhhcG5BYlhjTzFmbmpXRVErVkgy?=
 =?utf-8?B?UGZ3cWtHejAwQXAxK3hnVDdEaFpFdWxxWlIrMDBGVkkyaU9kRjdJOHpSOTly?=
 =?utf-8?B?U2ZMdFJSU0o0QVFwdkw2b3o2YzF5bmNjUzQxWk5nZFNZUVhaTCtUV0ZvN3Nu?=
 =?utf-8?B?MXpqbTMzZG5BWWhDR2IwQ2QrTE9uaG1hQk4vS2RsMURnVERsblZiSHpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckY5SUI5Z0Y4TzVzWWs2UWtzb28vOTNWVzJoS1JzMFZYWVVZaWJ4VUd0YXVQ?=
 =?utf-8?B?aUN3aGVhWVdGclNZeGR2WS91UUxEREY1eVlBdlEvZnQrVk94UTBZQUFPS3Vt?=
 =?utf-8?B?Si9tWlZzdmYzTGluWVFYS0JCek1pN0lkcVcrUE8vV2dQbVNuOGpFeXF6bUpB?=
 =?utf-8?B?TUpKOWJJdVg1MTNRb0JPYzYrdlRaZDBIYnhsZXNmYWNrTEhuSUFpdGFjQVJP?=
 =?utf-8?B?czUyeTJLWDJsNWpjSW5CMXRndkVqd1dyNlVMNlk1OEF1ZHBqSGVIamNmRld3?=
 =?utf-8?B?SnRTWWZiOTBySUx3dmp4b3BMdGxtV2l0a0NBN25xaEV5MEJHb240a0RKRlNM?=
 =?utf-8?B?bFlHNStHTWkvTjRZSXEza0xzZ0RycHh4ejBJVTNyNUZYSis1NjByWVNvbnFB?=
 =?utf-8?B?YUlYem53d3dvaXJQK3J4eFVObmgwa1djWFFockZ0ekRmanNEQnBlalRXZm1q?=
 =?utf-8?B?NEVQY1FrL1hYWTQzKzNYa1ZUZXVucHJYTlMwYjZQTFZiQmJKZDF3SW1ZWE1R?=
 =?utf-8?B?Z2JGUkVoY3lZeE9JZ1Z4cnpmY1BXSEd4R0VPbGo0V2Z4T01wOU9tZE4rMlcx?=
 =?utf-8?B?QVRIU05FdDhoZEFzUjBLR2lLT1hxaHptUmxkQjEyS2tMa3poTEJjOElIVkhF?=
 =?utf-8?B?MjN4SCsySkZoZWVRbzd4cW5jcG9NajkyZVBLcHZyOE42Q0xTbnFYTHJLb1Rj?=
 =?utf-8?B?V29xckdpamNRcklQNXJySVQvamxFVVp6MElKNjc3bGptOTVDbFBOd054TEFT?=
 =?utf-8?B?bG1udmV0azZvcVQ3eTJSVytMcFp6blV2MlNtVUFpeVZoc24wVUZxY3pCK1Rn?=
 =?utf-8?B?WENDZnZUOVhRVWphcXU5Skowdk8zL2w4OVpzMVFiSkpwdGVCUzJOVHlrVlZq?=
 =?utf-8?B?ODBXZnFxY0htaC93QjBRTkJGNEE3NFBjeDV4aFovRHk5NUdzZUczYmtMVExQ?=
 =?utf-8?B?TStoZGIxMkdLeW8rTkdxSjhmbDhuN2lidEFSYkJUdklqaTFyMXFCWjYyYU16?=
 =?utf-8?B?RmdhYW0rRTFIZ1V0MUt6QjlJVER6dHVOTFZzclFHVWUxRXUwOEJIRytEM3Zm?=
 =?utf-8?B?OEt0OTZxdzVVWjhqNzBVRTREb1FoQStETWV1RUdGdlpoTUY4ZXdkc1dTa1Nq?=
 =?utf-8?B?Yndvby9Tck05bTBuN0tDMFdnYmJMTFRNZXorcXhTbFRHZjZlZ284aUtZdEw4?=
 =?utf-8?B?Y214SEdFOFZhSzJVM1Btb3E0VHNoL0NNWHF6RFpTZXBmMS9zZnRxYjlSenhk?=
 =?utf-8?B?WGE3Q0ZzRmttb25xb2s3c0UrSVZVdnhlNmxKRGVORzdweWFQd3M4Q0hhbXVK?=
 =?utf-8?B?TkJLc2M3U0d5bkpKQlBTOHZWdDA1ZFNiZGJCN3RDQ1hZL2Q4QTJzQ2Fxbko4?=
 =?utf-8?B?cUI5bGU4eWJzL242Z1VWRGpTZjhQcTdPODhmVlYrd1FTRzVoeTdwTFdoTExo?=
 =?utf-8?B?eWFqZXpmK1ZRUUllYXppWlBzcmNvK1B2QmRmOEpueUl3a1l1S0dHb2tlR2Ri?=
 =?utf-8?B?S01CUUdtb0dVMHlGU2dNVGUzY2VValJud0NZMjIxVXNWSGRUUjJSaGhHNE8r?=
 =?utf-8?B?OVlUUHJ4bG02L0pBMnQrdklzYWF5djZCNFMzcWp5RnpXeHdwRFdzZXBFdHFV?=
 =?utf-8?B?Ny9rdjVWTnh0WDVadzdhdGZqWkFicTdETGF0WjVlRFZyaWxmOGZSdEgraVQ5?=
 =?utf-8?B?T2hla0NjYWxMQU55VTM1ZUFwU1o3N3FBSFhkdHNQVUVVQ1piZzhuNUpzWVlS?=
 =?utf-8?B?eEhHdVNPdTdFWlFHQ0FUZVhkVXhBdDVKaEp3MGorVG9yd3NmUCt1RjBmcW1S?=
 =?utf-8?B?ZjdlODRJcnJWajNTbUJvNzRlV3Y2SGJLRGhzdlhIck5MamsyNis2VEc0czVC?=
 =?utf-8?B?anpiK3pkb3lldXNxeGkxd0Y0MlVma3NZM2JCclZMUDdRQ1pwUlRENWc1MHc3?=
 =?utf-8?B?TjA4MDF2M3AxUTRxanJUMzc4MFFtNDVXWTFHQm5zWnBOVjE2MU1xeVJoYitn?=
 =?utf-8?B?Y2F1dWsveEtKVTM0MU1mcmRieEdsU01ORHQxQ0JSNmdKcC9mOGg4RkRPa1l6?=
 =?utf-8?B?WHRxT3dJdkxDMGhqdVRYL0VIUmUxemxpQUUzTWxabExXZ2wxV1BQc1JOTHVr?=
 =?utf-8?B?VHVQUmJxM0xhdnBJZVlSaktaRGNzZmlZNkQxeFNmUllpZzNOaXJjQVNoZUdU?=
 =?utf-8?Q?lIOu79ynIwIXA1nLW3AJrNc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c844088-ce56-4f53-cafb-08dce309316a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:39:40.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTtzufgmykR8GYNMATyhPzAERHcsWNRrOGfe4Ed3JGipkPWWX+xH4pPY5czKmZdMcSLRpzzNNHDJHmnU5Tmt+iyD1/bpZkPLxLHqMLGNlQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7109



On 10/2/24 9:58 AM, James Morse wrote:
> Hello!
>
> On 01/10/2024 19:03, Yang Shi wrote:
>> The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
>> calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
>> is 32 bit value.
>> However AmpereOne has 32-bit stream id size.  This resulted in
>> ouf-of-bound shift.  The disassembly of shift is:
>>
>>      ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
>>      mov     w20, 1
>>      lsl     w20, w20, w2
>>
>> According to ARM spec, if the registers are 32 bit, the instruction actually
>> does:
>>      dest = src << (shift % 32)
>>
>> So it actually shifted by zero bit.
>>
>> This caused v6.12-rc1 failed to boot on AmpereOne
> Same here - one of arm's reference designs prints 1 giga-tonne of:
> | arm-smmu-v3 arm-smmu-v3.5.auto: event 0x02 received:
> | arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000c90000000002
> | arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
> | arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
> | arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
>
> during boot - then fails to find the nvme.
> Bisect points to ce410410f1a7, and the below diff fixes it.
>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 737c5b882355..01a2faee04bc 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>>   	u32 l1size;
>>   	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>>   	unsigned int last_sid_idx =
>> -		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
>> +		arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
>>   
>>   	/* Calculate the L1 size, capped to the SIDSIZE. */
>>   	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
>
> Tested-by: James Morse <james.morse@arm.com>

Thank you for testing. I will change the patch subject a little bit to 
make it more general.

>
>
> Thanks,
>
> James


