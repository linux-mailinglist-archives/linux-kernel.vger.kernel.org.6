Return-Path: <linux-kernel+bounces-549860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754AA557EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED73416C04F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EEF204080;
	Thu,  6 Mar 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bt2dBjHb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959011DDC18
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294698; cv=fail; b=Tbcz0Tgf6STGRFXOJXpuzFc8a/276pODfO3tzBvdz3UqWp1ItYgfss7o9VscW1vxJjBKsNizbXDu5SdNz1bzgIHYVdufMITazqJd/Zwzm/vMXuqIf7Ps2uUweDsY5i0PRFdWQBt0KYKyMNbCEOeIqiYS9f7KlmUyvvFlwrIvrWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294698; c=relaxed/simple;
	bh=Ig9JjAEblnsXc2166WYrcR0M1Va+D6a/JBaSYImWTUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ND2iAH/QLYndDpb3W/WJs2SqIoDIgR8eT71y6KyGwk2VFJU0piXgsRxaHqbXNx+zU2WvT6T+o2qQjgyaSXQYwSixwBRjygFZ+U1O10marHHihX9VFft09tsc0IkBWnjJDGlGpHleCwZMA39SyPjRxokGSoDUBEUhLjmrGIqY6L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bt2dBjHb; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG/J+QMhXfUxi2pOEaHEHJDXRTgqcri43GCwLTj5LEa4/nAmbqwZgFfjGBjTofOrzoIrjQC84qfxhmA0hxYTq8hLd5bB+3ut6AiUgxeuPKW4QJB1BQraJfEqKny6v0l4n7gt2/5Xv1qHTcXMRjTTxIP9n8KahnefrL71MQ172SW0/J10zy8j6vwhCFBhLHVEvWKLHL+w5L4ttS8VqGtdiQ9wVN9CSyijqZt0BVHJ5E8PzVmWiRulSyd1xHCL2oISQCeTUDIpumJkvIW/+22yNyfwkyMGB1lhmwdMM61zo6VaZesiB5vv/OLw7rPHxY4vqMZCsDDJIaw6UXQpE345Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZV36Frop1cuD/aH0A9jDPxZdwEAZvjI/Z5eF2nXoHQ=;
 b=Zz8I29o/gpR0BXgoaP4uQXoA/zZu9dRm2C4yNVUAqVXuXgR+X2UxuyAuSx7Sov71usW6OhiyDkCxxVdcgpLTql0VCfvblIqsAozD3iIBlXGmeQO8monlc5cU9dmjToAxAc1tYo1mgRGQSFyfz1ui/MImzTCPWfsgxfDNh7aMQS7Da7CMPUCcnxMqaDQLQzmzE+DXuzwx4fnyrYsYHFe5bfAdrAgLCGymQ5MJQL8EGY4PKCgQHrIwLCR6cpYmUYQOnFeKQnkFz/xkNVBmhDuLZjsYo3zLAWjSELrmuRAs4G6MC9rqJG1vgqCqnJtrTH0P1VapBUbNOA7jK+933AVBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZV36Frop1cuD/aH0A9jDPxZdwEAZvjI/Z5eF2nXoHQ=;
 b=Bt2dBjHbRgGBqzlPrRuGIQNcxJV8RF2n3WxzXhHhQ8sC3Lpt/ACP/ACTsGl82JPLufeIEaoAvBJRS9EfqA2Cr3MKKT1CF1o9fB+rLx/LrONIsmIC+hmFHWS0d4Lmy4Ku2XDehb1TO5ZFxumCMs2mpfMngajS8EOYcFZSmyr36/70sPiHb++yFWjCo72c/SRChUaoKiWZPzB/RVJ/0GQGZdt9CiwDtYZpG5ZZzlIDXjQlLIT//MJ+ldg+FKwcHY2AJ05gvB4QO4wlkreR6AF14JjnNZUs6yt0YGCkSzgvRhFzJ950pGxKy/mmnTtfheeVdJB+LyIf/6TYnVAcQTqwUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 20:58:13 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:58:13 +0000
Message-ID: <ce11e79c-76cb-4aa9-8f75-a76b91edc56e@nvidia.com>
Date: Thu, 6 Mar 2025 12:58:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/49] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-3-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1bae7e-abc8-401f-22f7-08dd5cf19bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHdqMGtCRjRMZGgwcUhFTHpFNlYxa01qckU2TDVPa2ZiRDVsR1FQZzVIZUtQ?=
 =?utf-8?B?eGpDWEdsdFlPZmNVRnQ3WDR4YU94ZVpVM1JpeE5vYmNDYW0xNXRpWFNsS2hO?=
 =?utf-8?B?N2E4UHh3WEZCYWZ5d1VXR0hBT2g2Tm9heXNzV1hNd1FlQVBKRE8rVGp1cEhh?=
 =?utf-8?B?ZDZ3MHNiMWNIanlEM3NEdFFPc3pYUUI0Q0Q5RWRjbE9sS0tHUjFOa3cwSkpZ?=
 =?utf-8?B?L2RSN0J3bmtITHJla1pqT3ZQOThZQjAxZk1BV29UWjZpampXRXFTd1UyRGZt?=
 =?utf-8?B?R1Ryc1U1bkZvMjZ5eDROWk5wNTJ0KzB0RG5wSWxVYmliWGFwNE9zemFJZ2dt?=
 =?utf-8?B?MDFTK2tBUk1ySWtxTWFkVmYwbmtBSWpUREkvRnJnNkRQeDRLT0dPNlJ3N0N3?=
 =?utf-8?B?eFg5bUJHVGpwd1F0N01lRjdrczRXNm9CWEw1NTJrWGdXaVpIZTdqVVh4SDNT?=
 =?utf-8?B?VDdSazFzR2hyekpkVlE1MTkxNS9QaUhaTlZ4d2RGWHBqZmtyRE9WOWZteVNX?=
 =?utf-8?B?TjB2M3QvSFlsUFltVDZxWDZaU0xRM1dFbVlHbk5YTUhES3VpaWVpckpTbit1?=
 =?utf-8?B?dWwxRkpFb0RyZWc2ZTExRzYzU05uTDRhUndHZHpPV2NOY2FpdHIza1YxQW9h?=
 =?utf-8?B?L3RjY2EvbS9NY2hHWTU1bndsL1NTSHRxTW1zR0VjVGJ1RHZlNWZxM3Q5VTZQ?=
 =?utf-8?B?cnFyMzh6TzQxaXBRRHd6Z2pDREdTK0pPdEtmZ2oxN0xMbDQ1WGhlT2c2U2E1?=
 =?utf-8?B?Q3NVazFiS1h0d08yVzRSays4bUJuU081Rk11QURVdEFEL3l5TGVFeGFpVy80?=
 =?utf-8?B?M2tGVjBWcVpoU1liTEJFazFRRm9SRDhETlEwSjZ2Q0dXNmxrbTV5aDhJaGx1?=
 =?utf-8?B?SkFjejhQRHVSWFRXa1VHdE5Vc0dOL0JyL1AxL0diUXUzbmxYZ1lxWG5WVFpF?=
 =?utf-8?B?SUNjSTRRUTVlZHoyb2dWR2NkWWZrMmpGVEw5UStFSHQ2OGd5SHJmamNpaElx?=
 =?utf-8?B?VjZIbmdBM0pMT1dpS3hRWjNWRDA0ZHI1ajB3TldjNnJHN0pwVGxCNmpqZWow?=
 =?utf-8?B?aGZRQk0xUFpudzZaY0JiS1YyRkcxQVpDaGlESmZpM25seWEvMUxuSy9taGt0?=
 =?utf-8?B?WlQrZTRRUnFQWTlJUm1kU2VuTURoZTBJVWhQSEZKV1Q2SW9ZL0dqdmwvK21s?=
 =?utf-8?B?Y0JRWW5qYmo2ZzJLdXVYSjFwNDdCdjV6aTFHdlNRdGoxS1l6MjhzY0lEUmp0?=
 =?utf-8?B?YlpmSFNwKzhHSlF6OXhCdXdNNFp6bVVleGFtSjIxNHlDaVBBSWpxU0FoL3Q3?=
 =?utf-8?B?ekR5Nm80OUdEbDVZZmRwNUhuZUsxVTV4enVVN2lnMW9MNFlacDVJVmNzaGZv?=
 =?utf-8?B?c2lpMXE5ZHJ5WnBvbkxzWmloYkdLVFVGM0xoMXZyazQ3SnpSc2RrUlpaYkJE?=
 =?utf-8?B?NEVXd2d4Mm9od29Ydkhld0Y1c0psbWFnSHJ0OFNKK1ZSdW5rUGJqb1ROSi8x?=
 =?utf-8?B?U0xPdEROMVpMa2J5U3lmN215cmR5ei9NaXFFeTIwaTdUdG9mR2pFSEFWamI1?=
 =?utf-8?B?N0dpbU5RRVJsQThpZUJtcldWdTM3Q0liSWdNcVVxVFZhQ1ZTK1JldnBIaEpm?=
 =?utf-8?B?RHc1RHFBVzdHbXV2Mmo0QVM2M29UMnArWUlKWE1qTG1yRzVJTWgvdDRSU2E4?=
 =?utf-8?B?TUlEbXhvL0R4Vm0xcCs0TnNNOCs0RkVLdkcyL21NRmI1SGd3RVB1WGRGajNp?=
 =?utf-8?B?Q3k5WFIzN0h1V1Q1RThWWS9PTmRMVHdYQmw5S3NBOEM2b0tlQmVJQVN1OXMv?=
 =?utf-8?B?UVM2ZUVwRHhZZkpsM0tqeXdYZkJMbldVeWJsL3Q0TEZLZkRuQ2VGdkhOakpO?=
 =?utf-8?Q?1NzSFjVfm6hZe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZ0VDFuMm1yNlk0TC91UHR3N0lMQW1vak9BSEFXT002VkhPRFNPUHZpOWt5?=
 =?utf-8?B?bkRqMlFHTnNjdkZIbHY3R0IyYThSeThPdm1VZ2p4eFNYSW1LRFlxQUl4eHU2?=
 =?utf-8?B?cWk5eEZwUmhQMVlZQ2JBMGoyUkN5aXRQU0FHZURuVTJTckZSWVkydGYxRTB4?=
 =?utf-8?B?OGxPbU1FY2JvMDBseEd6b29MVU5tMEhEbTdlaStTQVhoYzhXMHNiQURsVjB5?=
 =?utf-8?B?Ym5SczlYQVBPQjlvbWNQcWFmRDE0aGppME93RnQ3TVVqZ014aHk5dVlzcWZw?=
 =?utf-8?B?cnlrOC9vVUtrSGdQZEF2bnlkZXlNZ0ZBVTdPTTdCcHpKWUc2czFkVy9sR1Yv?=
 =?utf-8?B?RklvMHZBUHlseTJ0dVplN0pQS0o2a1lrN1JScTM0S05UakMvTjlVVTBBcElx?=
 =?utf-8?B?T2NHbHk1UWpYUlllZWVLT0ZHVkRpaFQwZ2JTQTZBT2pKMWNFM200VThWVGNq?=
 =?utf-8?B?SllvVTRHMmNIdlUrODFXTTltZ1BEdzZaa0N5Q0JFRzZ3QjJmRXdwK1Z2NkFr?=
 =?utf-8?B?TGRCRGF3eHo4WE1RMDhLSkhZSERUa29IMmpuRjJhWHhYYjZxU29FU0hCYU5L?=
 =?utf-8?B?UFhmczJETVd4ajJwRm5na1l6Wi9ZazFESUJqK0FQdU9SQ1Y4VkhEdTlOT1pY?=
 =?utf-8?B?ZHJudkpIU215bzlnL0RNZ29RRDMwL3lSeFZMODdKbzdxWlNjamFuWEhiZVpW?=
 =?utf-8?B?SlE0ZnhESTdFT1Z3T1k1aXAydFFYSUFXSUxKejRLSkRWVXBvNlhaWW9URUdZ?=
 =?utf-8?B?TUF4dXhWb0VBR3p3TzNmYlhITDlqVmFicjFyTnQ3ZnEzN3crMWhmSXJQb3l5?=
 =?utf-8?B?UlNCalg4ZmRFclJOUkJPRHBkV0UwZkxFQWtlajBYQmtYWHJHTU1qTmx4cWYw?=
 =?utf-8?B?TlNNWWlEanhRZkM0YjZQZ1YrSmQ5Unk3OWlJd0djUzRmb0UrazhBT09YQ2VW?=
 =?utf-8?B?cEVCUEUvQjAxYnpYckMwK1ozYWNKTXMxczBGMjVzbFpRNVR1UUZidHRub3Az?=
 =?utf-8?B?YnVQeEx5b0hrZFYrUGdIcnY2eVhLZ00zeGwxRTBGdkR0d1BpVytKRVZPK2lh?=
 =?utf-8?B?TFZKV3RLdGJsSlpMS29WK1AvU2p5alo4OFFaZllSelZ1RzlGZUROY2ZaaFlD?=
 =?utf-8?B?OFVoL3lnRXJZRmJlcEVSMUdNRmFkWGgydFNjVkNqdUc5SkdaRkJJRzdUS043?=
 =?utf-8?B?OWhPWUlqSHRpWFUweCtYQklVaStILzF6cGlKS1ptV3UrVmZUM2V2TUxhWlFw?=
 =?utf-8?B?V21HQnhJMnZsdG0xS3hNVmE3R2hCelRjdzhsMDdPS1VmelJPUWxwUXJqNHpZ?=
 =?utf-8?B?bzZTSks2TVBYYmlnVUNocm9ON21DSDhjRDVZamZNMnB6SHhhNFFSTGJXV3R3?=
 =?utf-8?B?R3A0WnZUaFhpalBwRFNrTnpDUVhhTjdZYTg5aHdWTG5hQmVxRmIvS1I4SDBD?=
 =?utf-8?B?V2hTckJVcUJDUUJiTWcycVZYVTY4Z0hFQVpTdENRaGIwUUNqR1FjVnBXRmQ4?=
 =?utf-8?B?RUxzREVWaWUyT0hGd0pVWVVCb1Y0V2FTbDY3ZmUwdXVwNko5WTVMckw3eDdN?=
 =?utf-8?B?azdsTUZiSnlyQnl1S2w3Rnd5MVJCczduVFB1cnl3RjYweTAwelFOS1ErUU1j?=
 =?utf-8?B?TUQ5ZU5OaHM2emNtWWY3MXBvNWFrZjNpYURSeVVhc0FUSlFlcXo4bE9VNXVs?=
 =?utf-8?B?SXZMc09TZW00MHRuRHQ2SHFTSkRvMHFZbmZSK2VjcDhMbnNzWjM3S0lLQU42?=
 =?utf-8?B?SUVUQkExUEZia0tvY2dTNjdtOFZQcUFoV1YwMW0rdXNiZGdTY0JnR2J3S0tY?=
 =?utf-8?B?NkZ2dG84TFE4dkIwMncxMS9hSnhSNzVXOVpTb214M0Y2cTBkWlZkcDZyL0Uy?=
 =?utf-8?B?bGNTdG0rdXNTcUlyMW84UjNEWmF3d0o3b3FrZ2FkYVVRQzJXYW96cERLL1p1?=
 =?utf-8?B?U3N0T21nZ1hwYUFjTnM4ZExuc1V4cHVnWmdueTVSNkxiVXBKQnZCZFB2dG42?=
 =?utf-8?B?bDdjZTNEb2RaSUNWWDNyVVpQdUFtUXpyOC9CYnNhSEduODdzZFFiQ0RlQ3pi?=
 =?utf-8?B?WE13WFZ2R0JabVlZSDdWWExHaG9lK1FYS0cxQk1nZ2pnVUJSOXo2TjFIOE9E?=
 =?utf-8?Q?hK+XyUhTLt92iQobjqiSQbYNo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1bae7e-abc8-401f-22f7-08dd5cf19bd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:58:12.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DbgXf63BmlZTi0u5nyK5OpfnjpXwYgy401RlRsbVYWLbXvGIWh5Siiz1lgC2FE9E27iCbSUlaGONJQtBevD7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> Resctrl occasionally wants to know something about a specific resource,
> in these cases it reaches into the arch code's rdt_resources_all[]
> array.
>
> Once the filesystem parts of resctrl are moved to /fs/, this means it
> will need visibility of the architecture specific struct
> rdt_hw_resource definition, and the array of all resources.  All
> architectures would also need a r_resctrl member in this struct.
>
> Instead, abstract this via a helper to allow architectures to do
> different things here. Move the level enum to the resctrl header and
> add a helper to retrieve the struct rdt_resource by 'rid'.
>
> resctrl_arch_get_resource() should not return NULL for any value in
> the enum, it may instead return a dummy resource that is
> !alloc_enabled && !mon_enabled.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


