Return-Path: <linux-kernel+bounces-350723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FFC99088C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A5C1F21186
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA731C302C;
	Fri,  4 Oct 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rS1WdYak"
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023104.outbound.protection.outlook.com [52.101.44.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAF10A24
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057975; cv=fail; b=sPOKp958oDfaYzI3vzToGVNC0wEm6uDo/egaXJlZdKeQu7Fa8dppM9sBlLMLhg/7b2ETCFJwjLc7e1t+XD7m7cSiiFW0H6gAOxZb+hjxsUZZ/13kifsPhP5gdZwGo4Jertr3QS+n92ipwldoA9P8XCzCMQMu2tULDsjIcCvrMWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057975; c=relaxed/simple;
	bh=LpXccpojde9XddBOwpnooygnmtOrvCwywXn9GOfvgew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SqG9cBEfKzI2nUy8PnZhqR6ATgKlR93vvZzX1KedyBIyfaJuDKUFJYEMR+h6fCDCWKH39540SwLPxnm9wsBWSMlphi12ksYoiEDmCc59/7faBRIbWQmo2OyvOgVaRhcrLvmhrcMLjSkitewBdnACCJuNmS6R0z82hfsLljd188c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rS1WdYak; arc=fail smtp.client-ip=52.101.44.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edcoHT8aUf6W6TXNkVuqmfdeN97HbiikwqB5iygaTIC2A4sQgr7fPUiUT4aEW3Za3jCO5o/1ZIhQitujH2sAkDQWUb0A9/37oxynSXexEo04FK7Vpzue0QalXAlIAMgHGoTtVpqZNSe7gVd83m3aA6PwPvCP0f83wytHRFaMXxU8ARAmWPGUrgM4HEjmWAsECLvTdCvIJ/wjgJK2FUQ4ipwaiEfVXLSrtlVUf4/WAbbmTnobATqVl3nJK0v6WtNGOn4DVxrpscOcylg3yWOuKim3/b4INFPxwyXuo5RH/G8qhdB4X2Siqn3ZkEp5I8krosXdY2T+11s3G6OV+EK2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpXccpojde9XddBOwpnooygnmtOrvCwywXn9GOfvgew=;
 b=SMk5iVleh7dXlbxEJheiVMfDIrln2sHP9XFgLiBUjbvrci/ltD/qUg9K5oVm4DkQMSU+kD+Zds/T6iumwHq97EMWTN+LDehDXojk4m7t1sdb5Vt32bEv97dslQG4PUC/zIsdC2bqFhsnuSFiBAI98LoK78fp1MqwcnO4ONOD48sThZYqeaRnIisud3ZHCmwOs8P7F4Ingg1FL0PvbfN3noxWsZcZS3cAtqdZLyt7n8VAXKn6/Jny4/tOFQdSwfxMzsXEovV/cqFmCoPPfgFszKRzBLclZWHoCY2DMI69/L9bi4EZw6ZMoXx71WPUYvbCGbQ947YfmWg3K0b4ZxAlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpXccpojde9XddBOwpnooygnmtOrvCwywXn9GOfvgew=;
 b=rS1WdYakHj0sO3NqtinCAklXBqVGtBJQd1RhIj2otRxMM22w/4YLNFy1W3FPIwDFd1mIcBpN6D/39AcZZGRy1DYuO7BpoF9zQ/rrEhehZQX985X2z5N94o3ybyA9WsXtH2Qclw/NtFZRxtDQriDCuvyDxehaKZlAmRZJ8ptuIuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB6576.prod.exchangelabs.com (2603:10b6:806:186::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.32; Fri, 4 Oct 2024 16:05:50 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Fri, 4 Oct 2024
 16:05:49 +0000
Message-ID: <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>
Date: Fri, 4 Oct 2024 09:05:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia> <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
 <20241004124343.GE2456194@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241004124343.GE2456194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a94310c-e222-4271-4d2c-08dce48e69d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk1FdVhJZjcwOGt4NjBGYTJ1bGxoUk9iZDNIQWR4ajdVaFZsc2VkZTVIU3pm?=
 =?utf-8?B?K2lkZWxHQ3pVNmkrMzhtWjFTbmV6MnFHdGttUWJaaGJEUlczWlpRS050K1No?=
 =?utf-8?B?N29sdFpKQUtyK1lrTjl3a2VkRjhnRUVPSWgvNU9YYWJxUzlvWC9yTjc1d1ly?=
 =?utf-8?B?MTY2djV0cHVBSXBsdjBDcWpOT0FWdGN0MXB0NmgxNkQrL2ZuU3hzWWJnSW5X?=
 =?utf-8?B?aXVzQkpWaitWMVppRHpqLzFzS2dTM3crdEtPWFloMGJTOWl1NzFNWk00THhF?=
 =?utf-8?B?YUJlaXJrQThpcm9ReXV3cTlyeFFXdks3clhjUE9LclBpSkxkRk9GNTlXZ2NY?=
 =?utf-8?B?WlV2bVZqb2tPT2ZWbFF3SjJKcVBZZ01sdko2WUJ3ZURzbVJvVGZmdm50Z3Ew?=
 =?utf-8?B?NnlYem14YmlKcTF6MXBteWVTUCtHNnJaN2xaSkwzRktyTEpJVlpJK2NWREd4?=
 =?utf-8?B?L2ZOU2ZtcDlOVTAyVFAyOHE1eGs4Q2ZMYVJaSzRvanE1QmVPUnhzM2pZRWtZ?=
 =?utf-8?B?enRsb0d5RE1Sc2R5bHhpaXYzd2U1N2xLS2g2Qkd0V2RSRlNkalQ4NHo2djVM?=
 =?utf-8?B?OXNiTXJYOHB3UTl3Nm1BcnY3VmFnYzhXZC9DUjJQUUZMcEsrN3krWnlIUDRs?=
 =?utf-8?B?VG94VS8yd1dCYzJYdkIrekFNNWxmU2U1QlpmSkpwM2h1U0FnbFg5NE5WTjJ1?=
 =?utf-8?B?eXFLN3VONURlNldpZnYvYXRkajVhMVIyL3IwdkhTK1BQamhzL3N6QzI5Y1hW?=
 =?utf-8?B?Skl5VWU3K0N6MHlQUHl2UUkrcCtsd1pZVDZvV05jelRqV1preklkd0lBZ0NK?=
 =?utf-8?B?V2g4RDFsZUFwVExoQ2RNdEVFeEZxUnhYZW9xM25VR3lpZlVGb1VKZHI5Z2VL?=
 =?utf-8?B?bE9mRGY4Tk1VZXZYQU9mMjBSdThReTN3ZFZhdjZVSDgxWC9uT0NUME4xUmhk?=
 =?utf-8?B?QVplaWJ5NTdxMVUyLzRXZDQwMENocC9xcWRzcDI1R1A1NzhuYmNuTCtHcmJE?=
 =?utf-8?B?UDJocU5NZDJ0empVUlByenZnYzE0OTZjVFVKdUkxRVBpOXNYbnNwcGEzOGRo?=
 =?utf-8?B?WTZnWW9Sa09kSWFGODBCQXo5SmFqYkZaRmxTRXl1WE0wY091R1lFMUN6aVRy?=
 =?utf-8?B?eHhsV3N5dmdJWVJhODljM3phNFB2WStYZ25UREgrZG5KMk5HWWRmOGk3aVZj?=
 =?utf-8?B?U2hqVWNWNVFZT2w4c1FGeUc2dis3VXlHTzhGNmYxL1o1NzNJWjRhVjREby8z?=
 =?utf-8?B?Nk9nNFFKYzdMblN6MlB6Umthc2FSWlB0UHpiWFVCZm5WTjgyZWE4cEUwc2g2?=
 =?utf-8?B?Z3U5MXFmQ2pBQmlPL2VaU20yVzBNMytjNGtTMDYyQzl5YnQ2SVMvU2Q1ZUYr?=
 =?utf-8?B?bFFNZWlKZVd3VnlPSHl0WjBGeE1sZTFqMmdicHFtSG5jZ0tEV2pGRnEzak94?=
 =?utf-8?B?eHI4K2NFUFN3anYwSzIrbjFDNlEyRWk5REpjdEhoWG54eWRVZmVZbDFmTmhy?=
 =?utf-8?B?SldEaDBVczU2SFlncnh5YmtPWU1XMnZLeHYvVVhhV1FmZFE3VUNZU1YwalRZ?=
 =?utf-8?B?QnR6dE04LytoR3M4c1RtMlFMMDRHRGhsbGJhMEsyWTI0My9oU3VtSzZCeWpD?=
 =?utf-8?B?bXhsYXZ5TVplS24rdUZTUDU2bFByK01VTnp6em9DM1lrNEpoK3lMTkk1bS96?=
 =?utf-8?B?eUpvSnliWmh5SDQ0MHdaYW9rVks4cTRiNE81YllLYVBZNi9DWjYwZUp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2g3OXNpMVBNeGROeDJnSXowc1FWa295RFc3ZmNYVVZtN1dwZnlDTGNlWmNz?=
 =?utf-8?B?SnpBSHZzMkJOdGplWTg5R0dVendLUnN5M01pbmk1S2h4dkxDV3hSOUozTEZQ?=
 =?utf-8?B?U3hhQmF0eENrT2lPdWcrL1RZRTFyZEZvamN2SXMwSlZjV2lCbFR2YitpMVo5?=
 =?utf-8?B?c1J4UlVJY21yQUc5aFcxcDR4TnNvOExGMlRTZmdwTWRMcHlDRFdmSGVETTR4?=
 =?utf-8?B?cXV4cHBCVCtHTGRkTEFLL2VjeDErRm1TUmJTTjFHOTNwUVAvMGsybHE5TWJ6?=
 =?utf-8?B?K3RnNTYwSkNONGVGTjYrU3F1c3l3alpDMXJiMVdHYk9vaG1saEdGcUFJNlV1?=
 =?utf-8?B?dzJCOTRvSHhXbnE5NXdramFtcUVNSkhYQmhxN0VBUHJvYnBhczRBRmFSV2lK?=
 =?utf-8?B?dFNreGwrekZqK0g3YlhTeGtLVlZGT005eEhvZVNnelhUemM3dXZpNnZzRldS?=
 =?utf-8?B?Vk9QOFlkdVlUaXNGS1lpVXR2OVFhWlA0NGoveXRPSXNYd3NVdzBwMk9LODcr?=
 =?utf-8?B?NUZkbjJRNlp6RUVNUFVkWW96L1pYTXQ5Q0ladlZoNkcxQ1hQUjBaNjFSNEg1?=
 =?utf-8?B?K1ZQOE14NmdRNHNGZWZnRGFyT3o0RTM2eHBSOFJweFB5ek5Fb1dTT0VWTys1?=
 =?utf-8?B?RklqVWFhQ2xVYnhwOHBwbXRYVUJnZU5qMTBMYWRsTVFDbEd3ZE5NdCttTnBN?=
 =?utf-8?B?Njh2dnZLQWNUNThVYnFtY2pycHdGV0hpRWhhN0s5VGtlQ0FpaXFFZU1aYkN0?=
 =?utf-8?B?VHhvNVNSRXRHTGZxTWx5Nld1VmtMNkJCTHVEbmhPYStHOXU4NEdIYXFnZnhx?=
 =?utf-8?B?cFBnTVE3RGgzNTRjRjk3YVNBcG1iQ21GTkdaMWRoK1RyM0k1NUNrQ0NXTGNP?=
 =?utf-8?B?ZVZxL2RHMzlMSnVtdkxDeWYzQkY0R0Jwbml4aXExRytYZmdSZE45YWdVd1Rz?=
 =?utf-8?B?Y2dFa0dRL0tKeEQvV3d3bjV3RVEwVjRESUZCcCsyRWYyK2RQeFFzZnBtclR5?=
 =?utf-8?B?clFyMmFIMDFLU3dabGdjeEQ1bml1M1dkZGlLRzNFVVlsTXpuK0VxeDZJVnBz?=
 =?utf-8?B?NmtoYmxaSVd0UklCdDQzUzNMVllwcitjUUxlMjNWak1BbklxRFUrRkw3R1Z5?=
 =?utf-8?B?K3kycGRCK2RJRnVaa3lLaGZReDRqNno4dnBVSjllRW56cUR0czVBVkQ5R1lw?=
 =?utf-8?B?S2FjSWtkM3FqaGFYM2hLakx2QlBxVk9pYUVVNjVpaGYrY3d0Q3N2cG1DVCts?=
 =?utf-8?B?STZxZHJyTDh3NjgzVURDWE5Oam0wNnF2c1J5eUFVK3BPeVUzNlU3cFZHeFVx?=
 =?utf-8?B?YVg1ck1rRFVDOElITjlkVmFrTHZjakxJaS8wdTNlbTFCbll3ZUJ5OXU0MW1l?=
 =?utf-8?B?aGFURHdCQnYyZGFET2VWTnBDRnViYWRmdEhZeUd1bHdsdVgzQlZuZnFZTkZh?=
 =?utf-8?B?TzB3NUpBU2JLVUludVllUHZXUkF3Q1RkVm5PMUM2dnROK3NBLzhEZyt1aUtP?=
 =?utf-8?B?K2RMZVhXbnJ5MUlTWDU3c0tWVU42dkxxU2piUm5HT2FWM3gwLy9lOSt0MStt?=
 =?utf-8?B?UjdCV1NQVUhTZ1N6UTJsYTAybEFqVEVjbzFVK1MyOVVidXNHbC9kcVA0UUYw?=
 =?utf-8?B?aGZTSjVReklLSmhXUyt2SWh1Zk9zS213d3FVbTUzMUUweWQyd2JrMDlTMUox?=
 =?utf-8?B?aWdkMzEvTEFDVmE2TG5SZWw2T0xpbmRNNTZBVklSVFJZa252MG44aFVXSGVv?=
 =?utf-8?B?MVA5QVVwb0tRcmxDQTNERjZvYm4wdkJaTHd6anJJdThEMkRrVkErVkZDajls?=
 =?utf-8?B?NDN2U0dkeUtBSFZHd3pmQmNweHMzd1ZWSmVOZGhGUXV5dHB6cGtIdDRUYkVn?=
 =?utf-8?B?UXp4SUxhRzdJZkM4Wkc5Qmhvd0ZqZWo1RlhnaWlheWZUbUovVHlyeEhxTEIz?=
 =?utf-8?B?eTNBTUNWaXBIL3Z5ZEkzODM1Ri8vVE9nZlFES1hxYmVyeE54cFk4dUp5OWkz?=
 =?utf-8?B?Q0JLaDg4c2w5Q0g5dVkxN2Evd1ZvRkhPelVCZnFsa3FuTHpBdTVpTHFoZkZq?=
 =?utf-8?B?NVZFV3FNbURBUW9WQmR0UFFwVFBSN3FqcUZaZm1LS3lxMWN6c1IwVzhqQXAv?=
 =?utf-8?B?eXBsekw1Y0hwaUE2bGNFY1BaN2gxeSsxVE1CT3MzZkUwRDA1NHNkSmhuSmtG?=
 =?utf-8?Q?GzTu7nRT4YQeY2AFvpX7EoQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a94310c-e222-4271-4d2c-08dce48e69d9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:05:49.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3LlPx3R5jp1wlOrGtkDn5j6HY15nyOYiiu+FTlttOX/myTv0xc9V30sg4ZtYCRzWvwPjhwVZzPtjphp4RUambO7Rs+uKgAfCjgPDAdR6n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6576



On 10/4/24 5:43 AM, Jason Gunthorpe wrote:
> On Thu, Oct 03, 2024 at 08:31:23AM -0700, Yang Shi wrote:
>> If I understand correctly, the check is mainly used to avoid the u64 -> u32
>> overflow. This check guarantee no overflow. If some crazy hardware really
>> requests that large memory, the allocation will fail.
> Sure, the kalloc will print a warn on anyhow if it is too big

Thank you. Will spin a new revision.

> Jason


