Return-Path: <linux-kernel+bounces-341786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21E988637
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037331F2144D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFBB1779BC;
	Fri, 27 Sep 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQEt2ba9"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8421A716;
	Fri, 27 Sep 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443587; cv=fail; b=nqnugIrXeH5N1jdg0OoFByGuUGnmi5vDwYVShq/REZlWMC8XRK6pIVW2ri0g4gNwJdOKjbOhcfifHf121P7tNjloqgruPeA5qVcIBFAVfd+ARzjcKZWVDf+LoFeVoALQ2nngvJ3rQ/I5zORKY235Df0CIu/XZRtJez1PB3o5o70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443587; c=relaxed/simple;
	bh=3vEJaUjl+Rao+Xyb+whoz0I/p0TBXNjtNZ+pFgIsMPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HttxPsGl656Zp/cE40UkJYqC907xiwJboPWMjIexVgnTgUVrIqizqdHoLOQJdlT64BLgCAoYYY9P5bG+QYA/UGpFoz2dMVAW4wOzY/D33Pg6Eret180wfWzPOAkV5x+cV144Nnm5JiafWynYlCukeoFJYjPSJ+7jsx5dDQ6HXeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQEt2ba9; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzvMkZJDhK9jbz5pAHqB3SzgvAwI2LZgPOQGA8lU6gbW08EBbTVr6b/TEh8s7WhybWJyPrTI1RO0TSxyGGvBpYZJS0xcpa4/eb6jzBkUlGhHzeRV431usma7q/P7S1C8Ql6DdUTnZDBodhIjDLvmKQI3TXeFfXFbonf88SyLwOgPHxfun8qveGzKdm46pW3J0Bi4PHlwrO7pykeBqJ/+ijQcBiPYEA/U5oj0ZJtWyPpTEF4+monOuMqkXj6MAvTMOmG8HhdTz6vLERJZ4emeTAMY0lX9mpNeyOf5OEmWdAhapKNFF6r9pZEFc9HjIoV7GXiowkexnWtRxrbu5yKGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nfgAu2uyxuZSS6HPjaHLAg9/eLy4+8qHeJi8NrnO7U=;
 b=sxibbm6qnVcGgfKNvvnUyrpdOuFYLhPa267eTsi4+QX7Lrr9xR86AHWqlRTnmy36vOZ8qgaIwBtneIb8hSAFINK8wBDoTAMSYEGHTaupr6FBw9IgZPmtqT1IsWTrQZY/d41/ldyYXzgThPj+dnbcSgEAF7xBY8sR7feZdvpCcna5g2iorbwwz6yVDriJ6fbUUsKm+fJJCJKDlUWGXmarIEwlzcDJGDrSSTkOC9MK7kfXtOMKG5//ermHtmEQSq2EiXEFL/XyGgOycWfK8TysV83XFCvj29RuyRFdvfFAA7IROAqF4mYLWFs6/C1ClLH6hAsARWEkinFeO1jXBqIQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nfgAu2uyxuZSS6HPjaHLAg9/eLy4+8qHeJi8NrnO7U=;
 b=pQEt2ba9gGArzgf/B1YaPgPzNa5srkOqLLODipeoFYC6dk484e+twLTsT/PsJmMXTIx2oj2c0pTSC+auvpCIA1qG/sI3MCWZfooQfQx+J+bpedYEpNjZsgtwQjCRcP/uOSfhF8bLLzNgRJnlvgSFy4omP0GkzN6ypcn0DaVYycs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 13:26:20 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 13:26:20 +0000
Message-ID: <6df77680-6541-3d77-0680-1d67abdae0c7@amd.com>
Date: Fri, 27 Sep 2024 08:26:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 20/24] x86/resctrl: Introduce the interface to switch
 between monitor modes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1725488488.git.babu.moger@amd.com>
 <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
 <b84fee44-d52b-45c3-8664-b2215074bea9@intel.com>
 <773d02ba-64d0-4c03-968e-f303ffefc4dd@amd.com>
 <0812e4ff-d8d9-4356-bf20-7d20170e9813@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0812e4ff-d8d9-4356-bf20-7d20170e9813@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 97349c31-4052-4cc3-79cb-08dcdef7f949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUFHc1FTdzJuZHpMQ1JPdWMzV3dRSjg1Y1hjU1k1bStobEhOaWFGTEl0WTQx?=
 =?utf-8?B?cGwyV3NUTngwN2lkTkw1L3VtVXNsdXlXekdNQ2FYWk1XNXR2VlRCTXljQ3g5?=
 =?utf-8?B?NGE4R3VKU25LSjZ2Z0JEM3BYUm1nS0tycU1EVXpETnAvd3NJQ1BCWmNsZEg1?=
 =?utf-8?B?ckM5a3FCS05yNzgzMHlkeVBZWUJsR2JkVUt2cTVySDAyVHExdURsVDRSRmI1?=
 =?utf-8?B?SlBuOXRKSkZPQkV2M0h4TGxTcXc0Y0hzZjNVa05XYTR0dG0xYldTWkpYZFpy?=
 =?utf-8?B?TFlXQktwbFMrUlRpOVdNV3JLb3dLdGRGZ2pqMkQvWXltVy9QRWxDK3VpRSto?=
 =?utf-8?B?OVVOaUtaVkFvSTE1QXhJb2I0VDlXZFBlRjlzcDVvRE41ZURHR1NMOXEzRGxy?=
 =?utf-8?B?cWhTMjBHSFdBY01TWkI1RUkxWHFGSlpkL2ZlTHBEQTNrUHRBTkNMT2IvZjFV?=
 =?utf-8?B?c2twd1kySlR5Nk5mQVZEUUdiclRvRWtGM0MrYkJPcHpHWHV2WGpnUUM3S2cv?=
 =?utf-8?B?Z3JnRWhJS1Mrb1JJd2xmV09QWkpMejB0NFNXTitVcVVPeHF3c2wycEJ4ejZy?=
 =?utf-8?B?d2hxSmtVWWpBTThoWTc3TVRHT2xmeS91Mkt4L1ZIUmlYRjdBWG1nVS8yUDN4?=
 =?utf-8?B?bGdoYXFid1p1a0xzL2s0NFBqRGsyU2lUR2hXVHBlai9PMzA2OVJ2TXRsQWh4?=
 =?utf-8?B?SXczZlA3VU1taVdPWTVoendXSlVrNXl2U0VSZ0xKeVJLd0ZFY3Q5NXBWa1Ru?=
 =?utf-8?B?aU94aHFQazdQQUt2SVpoejFUVmxHQTNEdHZ6Wk9YaElFOTFETFNxL1BFZUth?=
 =?utf-8?B?aCs1alcyOXlBNW5sc0E5RHBXM1ZkNHZ2ZTRpY280STY3d2g5QlVjdGZEV1Vt?=
 =?utf-8?B?VGFaYXFVODI1cnkvSVZqNitncGJIMDFGRzFzc1pCS3lpeUJ6L3pXS1hqbmYy?=
 =?utf-8?B?NG5tZ0VLUFNFcUNTQXZOamptSXBENVgzdlhkTjhWNkdTbHdySG04MU1oakt5?=
 =?utf-8?B?ZUJjN2h6aWFmdGtYbElab1lJTkVNRlU3SUdvVXJERXlCU1pXRjdVMFhhd2Z1?=
 =?utf-8?B?c3dsNVlKSmdNcEVFWG12cmVJTWdBK1NrT25SeEtzWkFYbTNaU2tHeXpoN2I0?=
 =?utf-8?B?ZnZwNG9FaS9XNU1mekNzZEU5dmdIK3B4Z1FXbDJNRnR2V2VlZHg1cUpmYTR4?=
 =?utf-8?B?T3EwRWdyVSt5OG9FSUhydmpveGdmNVBZQVRybWFJYkVNMXJublFsMlg3bGF5?=
 =?utf-8?B?ZHNRUEZTZzM3aEViVzhuM1IwMldNdU12dE5GY3hkaWlTRmlYSVdYZkVZVUhK?=
 =?utf-8?B?V3JNeVZ1TkEvZmwxQjFMQ1BSWjVpSFUraFhFMnBCcXN2clhUYWZKUEpERDBE?=
 =?utf-8?B?eXVhcUlJbzdLZTA3a1k1UGhvQk5yRG1lODhxTkVFRDhEdXAxQ3pBYXJEYkhL?=
 =?utf-8?B?azlQa3pwMkN6OTBMcXBoV2l6akpobUYxMjI3eVgyVUtVY2t5NWV5eVVoTGt0?=
 =?utf-8?B?SmIwRlZteWxXNDMrK1QzNkxCUlhla1U1OHl6dEtrbEQ2UWdHT0xaRFlCZlZW?=
 =?utf-8?B?eXRzUHhQdWFFbGIxTmpQamxQWklZSVhRNjhZZnpmUm1yenhkQVc1OUs4cGYy?=
 =?utf-8?B?Nms0TDQvQmdlUGE1M1NOdUowaFVnL1oxR1BmR0xNY1JZV0dhdzZ5SVVtdk5h?=
 =?utf-8?B?WHJxZXNOVTA1anBhUitnNnlNSzRGckdMWFpMOFpxWXM4RXFuZThST2dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3JSRE5MYm1PTkIzazJJUnorZ2Qwam9xSnB6enRMTDMvY0grcmdYUTk3L0Mw?=
 =?utf-8?B?c1dIdWNiTGxwK3VNdVhOMEcvTjM3clhnR0J1RkdBVlRPYXZ2NGlJK09kOElZ?=
 =?utf-8?B?cEhpTWc2VDh1aGZvZXhvY0M4dngwYTZWVnhHTTNCSWZVdklFZkZVOUltcHlt?=
 =?utf-8?B?Z0EzTXBNbHYzbFZKVWRHNnJRVWlJNWp3c01XWVRUcGNob2pHVFkzQWxsdEV5?=
 =?utf-8?B?ZkNlNzhQbTl3VE5EVlVGajY1YmpoZmcyKzhicDJocnR0M25qbU4xMmRnNE8x?=
 =?utf-8?B?K21YcnFlNVV0ejFveHE0ekgxbGUvRWt5NGNQQXhROWh3TlJmRFVHTE9HVkNL?=
 =?utf-8?B?cGxEOERhMDVtcTBtWTVTQkcvT1RXTUVQRnhPSzlRSFRPS1BxQkk0MjU1UTlR?=
 =?utf-8?B?SDllWGcvZGVKWGpSU09yS09rNTF1NndQejAvc2hYVjBha0JPSHVLNkJ4MHQ1?=
 =?utf-8?B?R3NFaDV0eUd5TmxhcS84c2RiTS94OTFjTUJUeGxwZWd2YVFVMHN0cHNKV3hP?=
 =?utf-8?B?RmhOeFhlYmZ3bGQrMmlTdFVSNlJIalVkZVUzZkpCYk1hNkxkT3NYSHBEbTRP?=
 =?utf-8?B?L1l3LzFzeXZ0RkJ5NzV6TVdLOWhLUjhvYVdpMko1RXNteWlPdmNTOFVRbTU4?=
 =?utf-8?B?OXdwQnptY0dBNEh0MjJKTGliUDBRU2ZBbEVIaWIxTG9QeCtWdi9pK25KTkdv?=
 =?utf-8?B?UFgxNnpiK20xbEdsUUJ3Znd2Y0FXZ016aWpqOS9zK0phNks1Z085Mm1wVUhX?=
 =?utf-8?B?QnVERXJxVzJTWlhEUHU1SEN1eVhRSE1sS2tuQnYyd2dNNk9EMjkzY0tseEZy?=
 =?utf-8?B?MVJvbTgwd0MzUzZ6bCtZOFgzQmt1Nk44dldsMUdUT1ByTUQ3WDRxQ0UxSUhD?=
 =?utf-8?B?WDVkd3dsRUovOFZnZ1dxR2d5S1ZRNUJrS0VGSjlNSlZxTXJPaGJLdVRoZnlz?=
 =?utf-8?B?K29aRG1HUnR3Q2pIT2N5WWxldWhFeXN1Rkx4SlBpK1JubjBPRmErQ1Y5MWRz?=
 =?utf-8?B?b3UxZFdxTDBvT1V0Sjlnb0ZjNmRKbFRXR0hnbTY3UktjLy9zMHdsamxYWmxo?=
 =?utf-8?B?U1NOMmtPU0EwZ2luczZVb2g0cGw0U1MvMkxRNzk5djFMRkZnNVpGbXpvS21M?=
 =?utf-8?B?d1pXTHUrVVFzaCs1OHZaTkNqblMvWVRwV0VKUWNRL1kyNjBKVzNhTUVYNk1P?=
 =?utf-8?B?NWk1QlRiOTdCYVBjYVUyakkwdm8zSlFlaFlhdTdrYTlpcE9UQkZnckhRaEln?=
 =?utf-8?B?dzFWQnlCZGZnRWttY1AzVVpuVnliN2R3L25aUmlkQUVpa3hyT3M4ZXN0ZDY0?=
 =?utf-8?B?UUwwVTBuNGU5eFlIWCsrTFdRekh1Vzlub3g0NGlJbkMrU3FOa201NlhnaUVT?=
 =?utf-8?B?UmJOc090ZGZMQ1lGQVZoZHlabmNub3k5TUFDUVNCU0F2Sko1aEhMMnArL1hD?=
 =?utf-8?B?MVp0ODB0Z2xmRTZ3aDV3TkFDZ1Z1N0JzTlVYRmQ2b1o0RWU1Rk5Vb21XLytL?=
 =?utf-8?B?ckJmNnhSSUxoQnFmRzk3M0tpSE9obmtQU1A2WjhRK0NpSjlnSEwzWFdLcnpu?=
 =?utf-8?B?a2FHL2tMRzllTGNyRFliK0xvN3lBY3lXZ2J1alhPcVpUWjJReGhJVkNxMnVY?=
 =?utf-8?B?VkdzRU52Q0FyZGc3S2UwL3dqenhoVW1CeWJzMU9ONCtIZ3JYQ0FkVFRaYmlw?=
 =?utf-8?B?MnBhRjViTlhVSzZLM3hkU01LRDRzSlg5dFJQMlFPMmZJS1Y5NXZCMDJveWRU?=
 =?utf-8?B?NTlYSTE3VnArZGYvYkh1M3dTQWxGOFZxVzNOVjNCLzhvemNPK0MvdUJiNWpJ?=
 =?utf-8?B?WmdOeHRqeklEeEh2ZFRiWjFFaGZZR0ExZHZXMjZrMnFzcGtTMS8xTkkxNjFv?=
 =?utf-8?B?NFc1NnY3NHdxRzB2dm1ObFJjcUxGbS9EenZhMzZ6ZzVML0RQUjRhL3JhSE55?=
 =?utf-8?B?RmhERVZyb1JnRXh3c1lQQlZCZTBuV25xb1doZWhQUHpXT2llc09LWVd0dmRY?=
 =?utf-8?B?bU5Qd3NpV1pwZ0hIb1ZleTZPZU1jUVdUbmI1UWtjV2M1S3hSUkhHNFR1aWNs?=
 =?utf-8?B?aEl4Rnc3akpRTUtOVG5GZURyL3hUWDMvUXdmSWl5cHVMMVpkcEh4aXd1MzI2?=
 =?utf-8?B?MFlTdzF6RHNKMjlkL0xCT2dDWVBXamZ3MlZmUWFRL3BUZkJVS1BsREp2aUsw?=
 =?utf-8?Q?YrP4C4vf7AOe+DdlZ5mXTZp9p4jt0fmoeTX4MZgSNiik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97349c31-4052-4cc3-79cb-08dcdef7f949
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:26:20.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yin1ap1Ja7a0/Pv+Nes8feewYq6MaEcE6Hf+2rkn8YWsa3jdfFzD53fQfKqYwSr1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

Hi Reinette,

On 9/26/2024 8:51 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/26/24 12:39 PM, Moger, Babu wrote:
>> On 9/19/24 12:38, Reinette Chatre wrote:
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
> 
>>>> +	  ::
>>>> +
>>>> +	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>> +
>>>> +	The MBM event counters will reset when mbm_assign_mode is changed. Moving to
>>>
>>> "will reset" -> "may reset"? Please also be clear on what is meant with "MBM event counter".
>>
>> It "will reset".
>>
> 
> I understand that this is true for the ABMC implementation. My goal with making this vague is
> to not have this reset set in stone if some other implementation behaves differently.

ok.
> 
>>> Note that "counter" has a very specific meaning in this work and after considering that
>>> it is not clear if "MBM event counter will reset" means that the counters are no longer
>>> assigned or if it means that the counts associated with events will be reset.
>>
>> How about
>>
>> "The MBM event counters(mbm_total_bytes and mbm_local_bytes) associated
>> with the event will reset when mbm_assign_mode is changed."
> 
> In the docs "mbm_total_bytes" and "mbm_local_bytes" are termed "events" ... maybe
> "The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated
> counters may reset when mbm_assign_mode is changed."?

Sure.

-- 
- Babu Moger

