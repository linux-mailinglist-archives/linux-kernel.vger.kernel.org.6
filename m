Return-Path: <linux-kernel+bounces-428025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260829E0931
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C821B3CA96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC721B6555;
	Mon,  2 Dec 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JX4cxuex"
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023086.outbound.protection.outlook.com [52.101.44.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79521B21A1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157679; cv=fail; b=tur+efzNeqhSOytqEAfSoFgBIz/7soU0dD8Gjy/R6uSrc0Bhu3ZEKwirlMU1/jiLSvmIqU6bDVRbHuQxGKse1Z8XcQ/qM1i5V5BCPGWpweObm3uiy2yjIS8wF/yPXSPlhtQuBAzT0t2nwdgLEAMJxi2qXlm/rvsKjNrxHecpMLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157679; c=relaxed/simple;
	bh=SEzUjoDaDDV2Ot8fNCUmWcVx4y+xL7Y/tNtoZE/jz/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bd0T2wb2v6bCzggurul34TNUa2iDVd+cMLH55M125q3dJj2SWKsWJzW4J//rSACrNaPk9Ns1WNEHdAS9JKXl3DtMDo6DNvUkqYjJ+9snFbhq2Ihi2XfKJc7gLSf08kF+birYabT0NYfyCurvPUVbg34/SAwTfVBrk4aPehOlCpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JX4cxuex; arc=fail smtp.client-ip=52.101.44.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq5a3WdYX6KE1tfLcBF/Quxa5DvLf4m2ucbMDCGoT9GyQcH9g/GhmNk12HZNKbQrpabYBImMtesFvt3Nnj1fNFSc+BdeGkoj/64IU90IYK/QGFT0yub0V26uAUEGOOu9oPCDNrIuvfKeKL8mCEKJvYuqN8NDNPVpvXXJgWE8H2SkOx+ALkgoaB803F7l9sx+6BCdm9CV3v7q+vQ3P1nwaj8T/fXcFEjg+W0IeoFRMDV+wjqZVjc1lxU12T/vTyOZoc91fEK3OngPJsZAtlCuXuJoEkQjYOmwUjABk3QxfZTQgYs0P64Pkg1Lp+FY6WSkQcpAm9r7bfPOq/MDs37Mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MCqn5rsAM7mTvZZGH9Vn9dK4CQtpO2fzI2bAdSyip8=;
 b=W0Ia5SVZYTMSKnGW1tL4evNp18r7hS2HyTMdfYY2SQCewO5FgJ+MgWjwPu+fDgSAfU8vLnNPhLlxRsgkRUpLxczoQyUMSfkum6hBkizCaK3REaDc6XKAkrLjfLkLupfGo/h/Gf3b9ynLhAsZ+TL6p02EnKBckDwPvTV5ntAGWkraovEmiLl6xR5Xs3rmhNP2DwCMlo2+wbIb/3zWbHOWBkiIZyGRDMObmIBy/L9ncYgbNdB9QlRg/vCRPy2rrrbIxvu/akeSSHmTv4y6vylhW1vkmlsjGIpjBcQBHJwyA2zRQbnnAAdJ6sjQc0Ey5WqOiyfWB8wFwh6vyXIFAw05Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MCqn5rsAM7mTvZZGH9Vn9dK4CQtpO2fzI2bAdSyip8=;
 b=JX4cxuexgpZwfXmrB6mQ2VRYt/8CLgFP/cmmlfDsfjX99fTge5YGiPy8tTFs0bKKSsvjgsJnnytGJ+SlopSgGUFoEOF1zodEPB3sWKWeHAaVi6lQtbH2By3ENA+6CI+daIksGx5diOeBqy/655wGN/VFi4BnlzQoudaLXmAs6XM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 CO1PR01MB9057.prod.exchangelabs.com (2603:10b6:303:274::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.8; Mon, 2 Dec 2024 16:41:14 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%3]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 16:41:12 +0000
Message-ID: <c1b5a5de-94b0-4b27-a597-a34e84c3ef08@os.amperecomputing.com>
Date: Mon, 2 Dec 2024 08:41:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
To: Catalin Marinas <catalin.marinas@arm.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Baruch Siach <baruch@tkos.co.il>, will@kernel.org, ptesarik@suse.com,
 hch@lst.de, jiangyutang@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
 <87ttbu8q7s.fsf@tarshish>
 <98583682-a95e-440e-bd89-03828998b48e@os.amperecomputing.com>
 <Z0dbsRCsWT3hiVds@arm.com> <7720d275-bc52-49c3-949a-6a6a32157418@arm.com>
 <Z0oYMXMGYgXoyon7@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z0oYMXMGYgXoyon7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0150.namprd11.prod.outlook.com
 (2603:10b6:806:131::35) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|CO1PR01MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df56146-ab38-4cec-ea03-08dd12f0216a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGZwbGxwTUhCN0d3a3ZubjgzcCtEYjVYUmRRVlNUcXlWbHp5b0szSDZwMnBH?=
 =?utf-8?B?WllGajYxRXIvMjlpdTBMbTN6Z2grWE54R0k3c084N09xVTFzZWFxRnVPcEdB?=
 =?utf-8?B?L1lUTkxob2dwVmhUTkR1REpTZitHRjhyanFWREJEbHJvNWFIRitSbGRma3BF?=
 =?utf-8?B?WHBVdWhycThBTXpzSVpJeklhZEx5bWxwNU5BYm5ib1dodlBQZ3A4MjJDYUhU?=
 =?utf-8?B?RnVRVEJEV2JaOUE5TmdTb1l1R1VIK0pmck1EVk9xSmF4UHJlNDVlVkRvM3lP?=
 =?utf-8?B?SUNZYWF5dDJsNmNVYXM0VG5TOWVPYU9XSGVRMDNrSEtLaEQ0MEd2MU9kTFdC?=
 =?utf-8?B?MHVZR3B1eUt2Z3dVc1ZaSVJrWEpDYXpLRWVZZHJ1bmFJWmcwVXB6Q25UOTlk?=
 =?utf-8?B?WnRHTmszSlUybjVoZzYrKzMzcWtXTVE2VG5YaTlBNndHV0twa3ZFWGFESWJJ?=
 =?utf-8?B?RlNkYXo4VERzU0E2OHFFNlVpdWxMbllEWHZsU284ajNFa2hxVVBHK2JGejcr?=
 =?utf-8?B?aG9MRjBFb3lSQTZNRUl0MlZkUnIyN0F5VWE2bWMzRTU5bFBQMC9vMDlsK0w4?=
 =?utf-8?B?dEQxYXlTTkp5a0E3d0szNWF1ZG9odHVRbWtsUU8zWUQ0VFl6VEFMQldHTzF1?=
 =?utf-8?B?NmtjRkVvc0tGSy93bHF0N3NKUGJqQXhqTGtHY3MySXkvZ21rQTZuRlBGTHVw?=
 =?utf-8?B?OTVyUG93RHJLd0FpMVJKeEVLUVhvWTJIamxKNVBQRk1iSW5NZGdWVzhWaGZr?=
 =?utf-8?B?MTVlbkErV3h2cDVoaTVYa1ZIK0pORmdOWUx3V3lIUk9EWXFNdnkreWQ1WDN3?=
 =?utf-8?B?Zi9qSnRRVDZTNW5pSmN2amNvYkNEaTUxOHJ5RytlV3NLSXNEbHFRYnloZVR1?=
 =?utf-8?B?SG5FRGtjUTJnNzhPaS9NSGdQaW1iRGFxaDM4K0pRbFI4VXZBR1BudjBNa0ZB?=
 =?utf-8?B?VnEyc3J6UkNaVUJOVXNYRU5LU2J1Zk8wQ1h3SE1yRWw4VjFmeHRjVUZlQ0tw?=
 =?utf-8?B?WElyZG1SRGVFdTBhcXg2dWVsM3JHa1R0d0NGdDN6T2s0SUZrNXlMT2NqZEhS?=
 =?utf-8?B?MTkvMHlCb2R5aFZYcUg3eWt5SnVXNk9DWUk1a0RUMnJzczVvcGVsZlNqZUwv?=
 =?utf-8?B?OGV5OFJ2YWdFc3pVQnBqLytJbURrakNaVFFYS1RDYmgyTXp0Q3UzcmRrbWxS?=
 =?utf-8?B?Yk9aS3pwR012OEo4UkprNGNDUVdlS1E3Sld0cEhjY2VhOE52aGkrcmVGTG91?=
 =?utf-8?B?MUFndjRrMGRmbXpEQVFmZWtBZXJsMFJyTzhxS2Y5Rng0SVZGVGlyM1AvT1Zt?=
 =?utf-8?B?M3pON2hyWjlreTJCMjd1ak5PTkd0d0grcXdtMU16dzQ3R1M3Nmp2dldmMGVs?=
 =?utf-8?B?c2NnOFFnVVF1U3pzYjg1WWlpUEprOGJpRTF6R3c1MXlFSldkc0ZaeWpPWkk0?=
 =?utf-8?B?OHlhbFF2SkR6VHBFd2NjZWZvaUEyTDh0emxRUUd2eU5pcUgxcER5MHFwbWJI?=
 =?utf-8?B?OWpWcThuS3R0clhMQkpLRStzck5CZFljUWxxMHFoRW5DS3BLNzdmYW40K1dY?=
 =?utf-8?B?dS9uNGZVa2JnMU9EZ1dwd3VhaHJoVGt0V21kT2N4ZlBBZk1ONkp2ajJacW5P?=
 =?utf-8?B?b2ZWTElEK1hrbUtYVHE5akdxVUNnd2RnRFhhVjQ4U3UvaGVHOGU0UkkrcFFF?=
 =?utf-8?B?Ni9SY2gzb1JVUTVFUXRoMmRFYUZ6cDhKS3NGZERLVGtDRExXejI5WGtnT3ZE?=
 =?utf-8?B?OFZKaVlzQWU4YjdHZWN0TFl1SGhpMEpTY1R6cTFjL0VLakx4UjhhWGVENE14?=
 =?utf-8?B?b0Z2Vjd6L1VudHQxazByQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1dqQk9PalhMMzVPUUJ4R3V3M2h1djlrUkFKaksvdkVwM2tNZVZjMHlGV0xp?=
 =?utf-8?B?dlNjTmg0MUxGcnppTTdRNDh1SDh6czY0L0F2QnlDYUR0TVlqU1JWQmE1MGZv?=
 =?utf-8?B?UlExUTZHbjVFTTE1N2dYRnpObkEraE80d0dPNjFxOHlWQlNCbGFxaFpWTzVO?=
 =?utf-8?B?YTEzKys5bEJLYkozckhTUHlpR3RSWUZuTjJmZzc2ZFpwZ0RkRldUQUROZHpq?=
 =?utf-8?B?ZlhYVGtsZ2tvY0tKQzRweEtIRG5ESUFTNVZyUS9vQWYrdHdIM3p1VUx2VW50?=
 =?utf-8?B?UG44TXVMSGkwR0h5dDg2aXNET1ZBNytsMGJSK0M4emtIR3E3U0d0N1lZVEhI?=
 =?utf-8?B?SUcyRjFFWFpxN0FwTVcxakVDQXZEcXVqY1hCT3ozZFVCWUVRd3Fua0hnNU55?=
 =?utf-8?B?dG1KQ1ZhVlpnMHppZzFGc05wZVI1dUJNbjI2ZXpkUnFya3UyUS9tSXhLelFt?=
 =?utf-8?B?UjBURjNMV043d0h6RVExWXhDVzJyRGVQNXBqYXJ6QVpNODN2MTlDU2ZnNzZa?=
 =?utf-8?B?aXpJUll2L05GR2w1WmFVUHpaeS90TmNXU1RLeUw5NWRGTDllUnlMcW1uRmNw?=
 =?utf-8?B?WjJsL1N0QndhcHBWU0N0NUpqVnVWc0pkYlV2VDJFUUorUVlIaVUyWnRpbWhJ?=
 =?utf-8?B?T2liR1BFS0FoOUNScllDQWV2TXFyQ0RWN2tXNFA1ZXRrcUwrem8rMTZjR1VW?=
 =?utf-8?B?ZUViajJMTkJZM3NseHFvY3hzdWNRbHh5dUZYbi9VNkRkYUd0cGY4ZnpiSS96?=
 =?utf-8?B?bWhlZktnek1uNDhZbTdNU1hVSkxmV2xiK1hMSTJGcy92RGRUVWN0MFM2ajRq?=
 =?utf-8?B?bDc0UEdXWTlWRmFyTmNNTzZySnJOa2U5K0I5RVJpU0EzVjYwZUhjVDBlZlRJ?=
 =?utf-8?B?TTdTUkhvaWZQNzBnMFdKd2tPMFFNdFN1Y2Vuclg1Z3k3Qmxxa29pVXV3dlpB?=
 =?utf-8?B?czhpUVRyVnRhTnJCWmhlNENXSThVSFlkYTRISklFRFV0Qis1Nk13S1ZwWElG?=
 =?utf-8?B?Zko5L2pxWkZJZHFrb2k1emhiMUpTeUNVNmtxYW9NT2tpejB6UjJ4VnNuR0xj?=
 =?utf-8?B?STFLYjJ0UFVDSXhRY2svSlVJaU53R09GUFd4S3ZPcVFDYzR1K3cyZEE2T3dP?=
 =?utf-8?B?MHV5SW43d3dTSVE5TjNESGhCZWpHTmo2VGh6NkN2THR3MTQ5ZHRsak1wL3Vu?=
 =?utf-8?B?RmhiZ2NyN0IwaC93Mk9VZEtGZGdGUi85cFk2b2VObCtHZDBTamxGSEJBVWNu?=
 =?utf-8?B?ZlFjTjhtZkxOVnk3RkJpM0N0dFFQcG4zRW5mUDNtbG9ydlpLM29YVW1DaW5F?=
 =?utf-8?B?M2ZoQnhtY3FQQXVXbWg4K0NFQk9NNHVrT2Z6TU1YUWdZa3lISGlQOXFPSXJk?=
 =?utf-8?B?MzliV1M1YTN3K1oraUZSTHlmcEVjZ211WGt3NkoxSVgvVVU5Z3FZRkt2aWUw?=
 =?utf-8?B?SCtVUUxYck50bzlFTG9iQ1VPOU9TVVdTVnJzN1IxTkdidVEyd2p0V3pTN2dH?=
 =?utf-8?B?b04xcFFJWGl4aWhIK25UVXM3ZkhwUWFCbW1XcXMvZVBURWJvWFFkK0ppSU9k?=
 =?utf-8?B?UVo0LzFZUFFwcTBDR2NnV3IwbEtVUGNlMXltK0U4YlZuVzBhYTJCaHc3OFI3?=
 =?utf-8?B?c1Rkcm5GcFpGUUQ3YlkvM1gzaS9QTy9nM3plZkI5MVBYbkdHeHExUDR0K3ZW?=
 =?utf-8?B?T2tsZXAzOXZDNzE4QjJNL2ltZzRvNDNuVld6NEFYNFBnMzZHZDFuMzFxN0Jo?=
 =?utf-8?B?NzNhYVVIT1hnbkFjWXlmeVV6TzFGRWtETC9Kb2dxQSs4aG0xUkgwYzZ2cmJJ?=
 =?utf-8?B?RUNBMi9mV3RmYmRhcWg4clV3UWxKVUhybkRTOGtQQVUwd214VkI3QWJtS0Ir?=
 =?utf-8?B?RnhlN2lWRmNNc1pWbDFSUENvVXZFOHNsVzZid0J2bjQwNytPWE5uUDhITTdE?=
 =?utf-8?B?S1krdlFqcmcvZzl4dUErYmVvY0RSRWpUYWpYWkoyaTFwWXhoYjVPbE9PUlli?=
 =?utf-8?B?L2NOS24wdVY4NGliV1BEcytTcWR3Yk0rWm1CazZnL25keFRZU3pPTkVmMWcr?=
 =?utf-8?B?M1ArVVJXU2x4NllzMnkvMzlsS1VsUE5UbG9CUkRmcjR5Z3p5Y3FZZzVqWHhT?=
 =?utf-8?B?Sy9zWU5icVNKbGVGSEdBdVdHWXMyeVdsaDU5Z1ZpZmRqRExRQ2czVjA3U0lI?=
 =?utf-8?Q?RNK8B4gtfO33MtBfWoLexVs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df56146-ab38-4cec-ea03-08dd12f0216a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:41:12.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBtSIhs9EJXFOlz52ojc5Ky2aj1c5uSyfsDEPiowhOV2mqr786GhF4ihbhbFOMbx/Wj5eK+2HSNZU6g2vvvi1hZMNeqKQTHmaqCF2qzp/UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB9057



On 11/29/24 11:38 AM, Catalin Marinas wrote:
> On Fri, Nov 29, 2024 at 06:06:50PM +0000, Robin Murphy wrote:
>> On 2024-11-27 5:49 pm, Catalin Marinas wrote:
>>> If IORT or DT indicate a large mask covering the whole RAM (i.e. no
>>> restrictions), in an ideal world, we should normally extend ZONE_DMA to
>>> the same.
>> That's not right, ZONE_DMA should still be relatively limited in size
>> (unless we really do only have a tiny amount of RAM) - just because a DT
>> dma-ranges property says the system interconnect can carry >32 address bits
>> in general doesn't mean that individual device DMA masks can't still be
>> 32-bit or smaller. IIRC we're still implicitly assuming that if DT does
>> describe an offset range into "high" RAM, it must represent a suitable
>> lowest common denominator for all relevant devices already, and therefore we
>> can get away with sizing ZONE_DMA off it blindly.
> Fine by me to keep ZONE_DMA in the low range always. I was thinking of
> only doing this if ZONE_DMA32 is enabled.
>
>> After staring at it for long enough, I think $SUBJECT patch is actually
>> correct as it is.
> Thanks Robin for having a look. Can I add your reviewed-by?
>
>> In fact I'm now wondering why the fix was put inside
>> max_zone_phys() in the first place, since it's clearly pointless to clamp
>> DMA_BIT_MASK(32) to U32_MAX in the dma32_phys_limit case...
> I came to the same conclusion. I think it might have been some left-over
> from when we had a ZONE_DMA32 in the above 4GB (AMD Seattle?). Than we
> changed it a few times but only focused on this function for setting the
> limits.
>
>> However the commit message is perhaps not as clear as it could be -
>> technically we are correctly *calculating* the appropriate effective
>> zone_dma_limt value within the scope of zone_sizes_init(), we're just
>> failing to properly update the actual zone_dma_limit variable for the
>> benefit of other users.
> I'll have a look next week at rewriting the commit message, unless Yang
> does it first. I'm planning to queue this patch for -rc2.

Hi Catalin and Robin,

Thanks for moving this forward.

How's about the below commit message?

We failed to properly update the actual zone_dma_limit variable. Now it is
the memsize limit in IORT or device tree instead of U32_MAX if the 
memsize limit
is greater than U32_MAX.

The zone_dma_limit is used to determine whether GFP_DMA should be used 
or not
when allocating DMA buffers.  The wrong zone_dma_limit resulted in DMA 
allocations
use GFP_DMA even though the devices don't require it then fall into DMA 
zone on
node 0.  It caused regression on our two sockets systems due to 
excessive remote
memory access.

>


