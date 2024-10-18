Return-Path: <linux-kernel+bounces-371744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7E9A3FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05131F2256C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFBC1DB929;
	Fri, 18 Oct 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JC4CGpNv"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D231D79B1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258341; cv=fail; b=JueEwUlVPyr7KLLnyteAssuAaLSHsTAlMtsxNsuKM6jhGPkaRCstl3ec6CgjnRKWBucz7UBBXoirlFmkQHEcXtA4/tqwtZgAJZVn3rbOW9NvTlMJf+x/hXnrIuimCp9kFqqvHPuEeh5YkX7mrZdDR3JLD5fASWfxyBPG+dyc2V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258341; c=relaxed/simple;
	bh=Jm4AwUqwBGOTqyik7bXDCj6xItJ/KDPGEff4EPjYUB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SaVbwFcon5ZfwBDVREwk3fiH5QCbb8MkDjFjQp+Sg208X8K+uNmVBcGpizcsVORkDd+7VpERQ1R8zXcbCu+KTMmTkteq9LM9YjvAOHIgbIgM9WPUTAPp4L/58/Pv3J8m14tWoKaYIkShMRUGmJBLRvdMzstcraneBAnYACgp0nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JC4CGpNv; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuBxTPs4dpxeEK59hV/321f516vfb5258xlYS8nfCegoYl77Phq3cUCSCzEGxgSpRYJlG0n8cR07dhZ1RL+MVsNSqK+h4BihRTcDZmxtR9BGKbD76E2JYUHvVez8Z/W27gRiLBT8OC9tDeA74C/IUfIon9rdmYtAbNIYkTgahEwqsywmmHLgmu7S86S+20yB1pDihBnoNSd7y3EhfnGrklzkKRhk3tBHJIPvN9lNzEWElUnYfdBcjPBPeodCnMrZ27qtNZRZ1jSLnjEHNykjcvZBRx2RZ2IPQOZEfJ3plONuydisCs+5rg/nzif0mhZlQUtMG5eV9zfI6KQSRt9uJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9ZJlvu2QBfLSbkmjVCt/u7hHc0zKDPnzaEtDxQl6JY=;
 b=IQgHw6TviWqVIIcdoum6ZWfhl9lgyvF1rWl9OuBEF6jBotr9+oYE8qvkcXdutMC98yuHHuU97DxtgsIKGDdpG6ofsrb8VSE9U85Odk1sX23R7TJlgY7pLB/I0Q9fHHM5NDynexkgoarK8VGRMLY5XiLqITJq1DDWQ77Mpo6VH9fyZV2MkmJL05BKAiXzAwUcrYMliys+chfof/faxkUpFEqDx/7tzzhHZrgucH1Dsn0LAmvSzYUnQ6QsPTIvO0xG9iOs1wVOKAaq9hObNzc1WT7ltKADEWh14o0LvJHn7r0M1JBYdln9l2Mn5uP2P0i01zsogch4yP2s7V0mUnha4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9ZJlvu2QBfLSbkmjVCt/u7hHc0zKDPnzaEtDxQl6JY=;
 b=JC4CGpNvvBUaupS4icB0uaRwrmZrH64/gSAUSFFoIui0pijXM9bCITLTH+3astyRBkECByWpSE8ANckXD4N1NGKkU7vAgSZ39DmIu9FJvGz2jdbZTKTVN5AdcJOMsygQtsEz7eXmzsG/pzfI3hgVYBLjc9vID9vcnTyYojM4w2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 13:32:16 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 13:32:16 +0000
Message-ID: <dde53484-2ff8-85bd-4b0a-c69d0035d792@amd.com>
Date: Fri, 18 Oct 2024 08:32:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/8] x86/sev: Map only the RMP table entries instead of
 the full RMP range
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <89d50ef2f0a9b3eaf4e9c4cf4e0a418f963d92e7.1727709735.git.thomas.lendacky@amd.com>
 <b7ef4305-39ba-4650-bfec-287599730554@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <b7ef4305-39ba-4650-bfec-287599730554@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1aee2b-47f2-448f-1150-08dcef794862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T08wMUZOa29wZm5URXNHUzlJVmRjNm8zaWwrNTNjV2xVN24xVHVjeVZvRHh4?=
 =?utf-8?B?U202M0EvOG5TN2lMRklxUU9jVVNFdlN1UFZmbjBzN0xET0lOeUZCeVNCcytC?=
 =?utf-8?B?amdpTm1BdlNuazFUQ0V2Ui83QVYwdGE0NmhnOWtOYVZqc0NnSHlkK1BYU1dK?=
 =?utf-8?B?Y1A5WkR4Z3ZLZllVYytqeUVubDJhU1ArdGNJeXhYVUcyS08xZW5hWUFkZVA2?=
 =?utf-8?B?cGovL2swV0tOQ2lDN2psaDUyNHREcGtHNHFCa3VvMTg3K1lMMmNLOEZKbFI3?=
 =?utf-8?B?OWdTbTNEMmdHMU1OaEFOMjNUMWFUVHY0WEFFNThXSDZ1UTA3M0lPMkhOd3RR?=
 =?utf-8?B?dkVTbkdRVEZuNEs3NUtzUzFrUTFpckFveDNUTkVkQTB1QzVsVkMyR3dtU3hZ?=
 =?utf-8?B?ZEtiWTlBNGduSnA4Q3hDc3N6Z0xCZEdoTEh6c2dVWGFPVGVDN3Btcm1UOVpR?=
 =?utf-8?B?d202SlJMZHpHYkhOeDdZcUsrbFd4TC9QOFFhNXdPemJBNVhBTzRJVHpGN3VH?=
 =?utf-8?B?RzdsK29zcFoxREk1Z2kwMXJ2VjdlbEc1bU1Rekk0NU9nK1JxV3JwUmhla2tK?=
 =?utf-8?B?SHExOEw2VXE5NGhvRVVhcGFwd29mcjJtVWc4dXdPYTdES0tuMzZTQ3VLV2pJ?=
 =?utf-8?B?eGhRNkpoa1VUdlJaQ2FBdno2SjhjRDY3SmdHZjIrLzRTSnJRbkZqbHlPZU5Y?=
 =?utf-8?B?WS9RQUFnMU1LT3RFVWtqcjNZZWxpK0dVRzhFaGwrZDhkQjRzM3Z3MjNwWmty?=
 =?utf-8?B?d0R6ck45MENYcVNRSHYvbjNFOC9KK1FzTHdzUndNY3BHYk85WmFBRDhkZ1VX?=
 =?utf-8?B?c2E1YllJaVdnczRybXcxajNFTEdXNHRmWndEdlBuRVpxbVRoZWhybVc3UStN?=
 =?utf-8?B?d1IzL1Q1Qm1BM1h4ZnVidndPbXEwWm1KSHBSR1RSdVZZUGlxUWlYcWZKV2Y1?=
 =?utf-8?B?TUtLdUt6ZmxsRnhZVTkwL0JQczFkd3NnSHZMaU5jQ1A5WVRLSVRHT2dHei93?=
 =?utf-8?B?WmJoQ2Nnck5JSkFHLzJOOTVXTi9SNjZxMzVDSmxuOUlSdWhhZDJNQ1hiU09U?=
 =?utf-8?B?WkdMallTSjdDemY5c0FYd3RtaEhoWG5jN0RNZzZ3djhCSUZpTWViRmZZSzZS?=
 =?utf-8?B?OTd3aEkvTGc2U2ZJVS9pQ1JQRmZJN0t4RzJqSWhSOFpKL3RQYlBrRjZMOURO?=
 =?utf-8?B?aHVhakZjNkRndGZPL0h6VGtEUzE5S3RvN09QOE03TWlvRjZKR3BhWlNtTmhG?=
 =?utf-8?B?eDlBL2ZqOUtUSElwek9DS2diNVZvNHV5dEJEN2dQWkwxUHhkK1BSbFlESDh0?=
 =?utf-8?B?aU5LWHYva2VLVUJ4NU1KTmNDYUJ2UXBCNzI2bFhuUkExa0p2ZzJ5dHduTUky?=
 =?utf-8?B?bXFNOVZSRFJuZFVWK1A0VXFMTVNOak9Rc0pPekJYZm16N2poc0VlcTQ5THU2?=
 =?utf-8?B?d3hLWXhwWWNaSzNsTm02Z0ZRSXRBL0xEcy9kSHBWRXM5SzdRVmhpbHp3OHVi?=
 =?utf-8?B?bUhGNlh2MWdFazZNbTdzMTNJUWlIclJPYzZiU0xmeHowRmJ0eTdIT2NWWlZO?=
 =?utf-8?B?ZnlpSlR0RU1YbVlKdWtKbDU0S3Rnc056QjFDajY0RXNBTWZ6cXowd3lVa2RC?=
 =?utf-8?B?Y0hpbVRvcEJaamo4VUpqZU55S0Z6UmowYXdpeitpYUpDbUFnMEdLZHZuOExD?=
 =?utf-8?B?K3dPOUY5TzVxL1RFdFhha0FCV2FvS2FHR2pac1JubzE3aTY1UDZveFEzbU41?=
 =?utf-8?Q?Vg2Mhwfy32aDgj7+ryU4wJe29mH9Azpld4tSoSj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlN5QUZLRUU2KzZCblIvTzV4NlBwc29CMkRNdFd1OFdxMVJlSndmVEp5aW1o?=
 =?utf-8?B?YWpGTVBHNFpleGxUV2VwS3Z0cnd5ZmdFSHV3YUFZL1ppMFFVRHVKeEZWeEdq?=
 =?utf-8?B?WVFWQ2Job0hGdXAxWTIxb2YxU1N2UzhHeGNEU0V6Z3QvUU0ySU4xSjlud3kv?=
 =?utf-8?B?K0p6NUVTT3h6TncyMldWMnpidERXL3RSM0o5RS9henl1ZFhhRHZDSGgxdlpx?=
 =?utf-8?B?THFrY2xIT21NREY2R2FhUDRHVFNhcU4yQWY4eTE0QU9vNlRnSGpZRDAwRzBl?=
 =?utf-8?B?U0Eya21MeFI5RFVHSzNXUE8xNWV5aklWVDdleGlnSm14QWY3cVkwWTdkM0dZ?=
 =?utf-8?B?Ym1Ra3FabHdoTkppWmVBRGNITTBpT1U1NVNVM0ZobTk1N2Nic2dFRmpFcjc4?=
 =?utf-8?B?eFhOM1dZbVBXK0R3WWdlQnZVR2RYNFNYb1lMaFpDQXRnT3RBMG5vcGFob2Mv?=
 =?utf-8?B?OUxwVk85TW9nN003VVRDcjZPcnhtajlxUGMyeE4vUXcyTVB3cGxiZ0g2bHRr?=
 =?utf-8?B?bTZ3amRPTGFJekRnRW0zaG40a1ZjL0hGMFpEa3dsbHdoRE55UnhMT2x5M3V4?=
 =?utf-8?B?VUZSNGtUOGwwOWtqNmdzdy90c0syQk9adUoyZHJ0bTYyS0hUS0lzd3I1Zlla?=
 =?utf-8?B?RHdCdXE4M2lSUUVmUlBPa0xVMWVFZENkbzk5TWxEMUUrK1hKd3ptakhOb2xQ?=
 =?utf-8?B?U29tY2hkMHhiQVg4eHZWOVJ5WXNYcCtBekMzMUdJTy9lVXVWakhuSVRhdlZa?=
 =?utf-8?B?ZGFHNXcwekJPcGFQWW5ZenVEbFUyUk5ORFZBUWtFUWswSGlyVHM1aFVUMmlF?=
 =?utf-8?B?Zk81OUFnOTdXWG5NYXRxblk1ekdwSTBLSHJ5VGdzODl3ZThzdEVkaUZhbHFp?=
 =?utf-8?B?ektEdFJZV0IxV2FoeHBWcHFTZk9hTmsyYWtWblJpMGRzNjk4WHc1THdmVEpK?=
 =?utf-8?B?QlordWFQOXp0bkxUYktORmFpWmYvSmw0Vnc0UVZzaXBXamJ6aXhRUTQ4UW9G?=
 =?utf-8?B?VWJmL1hNNDVmZUM1TTl0bGxHay92ZkJ2UDVKRUZnWGxXR2o1VjVNVjU3dE9h?=
 =?utf-8?B?ajZDSUpkM0RZbnVIM2tvcHkzZ1JlZkxacm5maTU4M1lVQURBTkV4TG5EanJK?=
 =?utf-8?B?amw4THhuOXp2aCs0UlRhOG1Kd0ppbUlXM09WRVpZSzl3RnRXdGpmL2pEa1By?=
 =?utf-8?B?WFBBL01WNDdzL01tMWpXOTNwZ1lFeGVkMDBtL29mNjhXSm5Ib2NQbnkwQlpH?=
 =?utf-8?B?WTN2MXh1cjMyWHBxREFBMklHMzBCbmZOdWZkQVZCSGpnNGM3RDlBV3kwZk15?=
 =?utf-8?B?ckRueFBiWEFlM0szRkttTHNRelVTN1Eyb1lrUnlYSTBKcU1QTVlkaGlGcW0v?=
 =?utf-8?B?VTdOek90OTc3QXVTZzhkaklXaVZJQjErY0JLNnhOL3J4Wk01UHVrancwdXM1?=
 =?utf-8?B?c0RWVUNDcXBETkh0YVJpekl4SUM2RVhCUnl1SXViRWVwNlVJdFlyck5JTlpi?=
 =?utf-8?B?OFEyQVJVVkVkSXpWWkM4Uit2MUhCQUJ2R0h2ekhUNWdBRHl2RGJJMDNWV3li?=
 =?utf-8?B?ejVUdmlsK1did2YrRHNsZ3U3RlZ6dittT2tpMFhUd053VFI4QUtPRVltOVdY?=
 =?utf-8?B?VnRwK0wvMnRESGMzUFI0b2JxUGMrUDZqRmpxck16YStpR3NVTmVkVDVzQm9K?=
 =?utf-8?B?c0V2RnlVVkFZa1VpTXVLUGJEL0FKTVdjVFJ0NUxiMGExaE8rMWRueThSbkdZ?=
 =?utf-8?B?cVZ4NWxBTGkyMHZuNG93NUtVeDNDK2ozNlVjVkJtYWJ3NWl2anZNOVRzOVZo?=
 =?utf-8?B?TksvUnQ1ZkNGR0lVNzgzNHpnV2FFK3dneFRyaWUrOXd2M1RtOEpkUGFxb3dw?=
 =?utf-8?B?K2lsOXpxVVIrZlNFNzdqbU5IMnhUMUU0Tlk2TDZjdUovckU0elFHbXBrSWZs?=
 =?utf-8?B?cGgyV2cwNkR1SXdIZWQ5ZnBtbnR0MzFpWkJXYXM2WkJscTNHdDh6Mi84Vitp?=
 =?utf-8?B?MTYyNGFxTm1Ubkw4Y1VleW1DeGhXajh1QzRpbFlYbmxSVGxnY3hFRU5zRld6?=
 =?utf-8?B?Z05PWllWWWF5UGdjUHR6OExSQXZxSzhjdEVZU2xvR2haMS9IM1IwYWRGd0lp?=
 =?utf-8?Q?nvAcyiglswS38/FWLed+/ah7w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1aee2b-47f2-448f-1150-08dcef794862
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:32:16.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lExOKsAuVm8hL37/5MZED1W4JDZxPFHJ4+/+C4JgLPIk9m6dKj9Xjrkh51/ycvFIoI/jj2EWkyKMkPmXm3LORg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804

On 10/17/24 23:38, Neeraj Upadhyay wrote:
> 
> 
> 
>>  /*
>>   * Do the necessary preparations which are verified by the firmware as
>>   * described in the SNP_INIT_EX firmware command description in the SNP
>> @@ -205,12 +222,17 @@ static int __init snp_rmptable_init(void)
>>  		goto nosnp;
>>  	}
>>  
>> -	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
>> +	/* Map only the RMP entries */
>> +	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
>> +				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
>> +				  MEMREMAP_WB);
>>  	if (!rmptable_start) {
>>  		pr_err("Failed to map RMP table\n");
>>  		goto nosnp;
>>  	}
>>  
>> +	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
>> +
> 
> Nit: Move this assignment above 'rmptable_start = memremap(...)', so that
> rmptable_size  can be used there.

I like the symmetry of the base and size adjustment in the memremap(). To
me it looks very obvious as to what is occurring.

Thanks,
Tom

> 
> 
> - Neeraj
> 

