Return-Path: <linux-kernel+bounces-307244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C314964AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5264F1C249AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B4B1B3758;
	Thu, 29 Aug 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VhBI2bz+"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E41487F1;
	Thu, 29 Aug 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946804; cv=fail; b=s2mbTYfYS6phaR4x30EP9cQdvuzmVeqEHUo29X5Nr+jFAKivjDTYnKotIlVBMdZ/hRJiahUCUZn2YOGXTIy8WXuRwXfHZJ0SNrLGFpToZMIeXAyfgXnUtY8SE0+tALJ1yM9Nkh1EBCRFKxYnszrb+JeZmkwTlBN8L/jSZ1FH2B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946804; c=relaxed/simple;
	bh=jUQyTvzj94Ky8hQz8sOC7Gel/+xT/uzHq/quMrLsNnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HZR6H0bT+QPG74ffoGvXTQhph+HL6di68wYRtvBDGtxQ/3MC0C3HVNGKo0m2/8kd0KvTCPaSmfdWN/Ca2iHLwAtPAFcrCZH1ykJqF/PjPEfUi2ROjXOHeY8qHJXnbke4Z3hJl7igjjCD1/rZ8yzoP6FWiu0ZyMrQuoNfk7Ikvc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VhBI2bz+; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ3/Qa2dnzuJBAbMuygZgjSRQ/a+rO3kcTzAlSAbWgsg73PEgSQcqvggos/8xjqXyR+4FzhWPZMMtvDgSDCgtiegez50tQ58dV32vXzyGXAjiZg3+5xLryV88PIRjmGK2AP4zGRzzqL8UjDZc/A2W2MKN4Nhn1kPcB5OGBuCLKIorJMikRhBs04iKk57xb5NZx1Mx7dt1n/KEzQxTYbjfiZ2UaADOyPIU4WdGhow0mQSV4niHcHKDesuIh83lJ2hG5Po8vESisAGyco/rsG3bOQ2DDsKTHaxAESA6UuK+DPVp3iNz+5kl/GEDhEicFveDTx63yrZKaj+IvC4Ent3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrhorl1RztPA478T3uH76Lzaojfx7K3C5aSORf3wqRk=;
 b=a8x4s6k5N788h2TaMNM9AaUWyJquqduN8zvBSz6OB+t3QKBS1n/sH/IGp3Q2GHasomxXkszHqwOha4na2tRrlXY/VBAbR82v8lcNAsWJiznYKhA1We8EyOmA3fdk9ikrqh092gt6WXA3iJqqOwdLCov9cipIN5t5NtXc7HCNVzxtdABeXUjM19mQ9IpHZlpla2cK8aEPQ0hIRids91Pz/JMuQ/8TRK6rSPn1S+nTezcxmx2zTy8nC06ouwcHHBvcDosL3AOPptdXdTQ6U9s7LnvCVXYNr/8b+48ZvuLQV2w3J9gAT6pc1ntUSPXUAP1bOddUO5taMqQY+a4hY6/QLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrhorl1RztPA478T3uH76Lzaojfx7K3C5aSORf3wqRk=;
 b=VhBI2bz+XvSA2YHwqw1uc4gB5m/gVzCdojoGylkWXdgSOQGmCnNWB4PPKKPL63AgE4JI83OjMnsM1m75Se0GG9lXbh4LnEQMt4neGwTEK/yvfOwGDy9BfUTq6twMziusFttOYy3wbSWYV9ffjUnHffHaRy5HWEIDPPUNKz5v0VQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 15:53:18 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:53:18 +0000
Message-ID: <9c632a10-9b68-c144-5477-197bf693651b@amd.com>
Date: Thu, 29 Aug 2024 10:53:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "VanTassell, Eric" <Eric.VanTassell@amd.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "Kalra, Ashish" <Ashish.Kalra@amd.com>, "Roth, Michael"
 <Michael.Roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paluri, PavanKumar (Pavan Kumar)" <PavanKumar.Paluri@amd.com>
References: <20240801205638.6603-1-papaluri@amd.com>
 <20240801205638.6603-2-papaluri@amd.com>
 <20240829132438.GCZtB2lqeYpleYk9c4@fat_crate.local>
 <385ef968-4b13-9124-1f13-e521992ac0c7@amd.com>
 <20240829154156.GHZtCWxP7mkn7aVyWm@fat_crate.local>
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20240829154156.GHZtCWxP7mkn7aVyWm@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f75b370-6863-42af-35ed-08dcc842b38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFM5V2dWZXl3cUxEU0d2WVA2djJrcmEwRlFVd0tzVHFXbDIrUDJHdXNrN3VO?=
 =?utf-8?B?S1IyWjI2bSt4Rm9oRFZZckYwWUlIRm45MlA1ZUtaalZqMjc3bUExQm1Db1ow?=
 =?utf-8?B?cXR4Nlk3R2FIbUUzMkxJSHVZalJEeXdJU0pMelNxSXZDaW5sbUZkRHVvcERX?=
 =?utf-8?B?S0ZsUVd0ek92RmYyenNJSlcyc25ydDY4R1NXWnlyYzRRSHRRRWMwd1o2TmRG?=
 =?utf-8?B?VHJBTC9zT1NuWUtjQzN4ZW1JTy9ydDl5TVNsWVhtcEs5U09zQmJEN0lPSnRS?=
 =?utf-8?B?cUFnVlIzMnhHa2FDK25mdDc1TVgyQ0JHOXR2SFBOZmFoa0hXVGFSQ2Q1NU1s?=
 =?utf-8?B?N2VweTRwUTl0OVRod3h0R0RhYndJSGhBT1lyYUZhMG9TMThsYkFXRnd1ZDZR?=
 =?utf-8?B?dnBMWWFMY3NwRUY2dGpKeFg5RzFCbW1yMW9kLysyeXlaYkJqTTA0S05yelNE?=
 =?utf-8?B?bk9MTVcxS2Q4eU83S3hYQlNZUkt6bnc5S09MYVZFQVVmZnV1cG5HcnlGL3Rl?=
 =?utf-8?B?OS9JbE1lSVRENmFUZ1ViQnVDMXNabWhQc0NsQUZMNURsZjRjSGRKbFBRTWJz?=
 =?utf-8?B?U2VRdG9GWGlMMUROZENaNUVSMlgvZEEzU1hXZFBlMzJKVzZTU25aT24yQi8v?=
 =?utf-8?B?emU2cU53ekpaaUlEajc5bCsrSWVqdHJDMVpJaDJFdVlET2c0RDVzc3FKblM2?=
 =?utf-8?B?aUNhNWc4emhkZ1h0N2ZQTWM0N1pxaXBtcXNvcDJudG5Yd0pIYk5mYlRZdkU3?=
 =?utf-8?B?U2pnVTR4c3hYQkFTZ29KN1hxOHhtUTdvTTg5WXg4SWV0Wk9RbExhdEpYV0Zl?=
 =?utf-8?B?Zy8rSlEzWGYzejRsOTYyY2FiMlNHeHpySlBSUXNyR240NFhVUFpneG43c1Z4?=
 =?utf-8?B?ejd0ZjRFL3ZUWE1wSVVJSWIzQUJoSElrVlg4R2NtSzZpZ2pSb3VldEhEai9t?=
 =?utf-8?B?TlMxb21ldUh4S2Fsc1hDNGxKN3BwSzc3N2UxTnVZK3lJajUvdFppQ2RVelJr?=
 =?utf-8?B?Qlc4bzAvWlpxbXJIeEtOMFNtNFBtTXlHRm5aT0FoNUlSMFNjbityTi9tcXFp?=
 =?utf-8?B?NzhvNWRxZGZtSCtDSG4rU1F4TFlSZFArQnE0ZThqdDYxK0dLQ2h6N1lkbEpl?=
 =?utf-8?B?elJaME9LOFBaYzFHSm53Nzl1Y3pVMlpXNkJsWlRHbjExVEVTSm4wRzVGQlZS?=
 =?utf-8?B?VEdNdUZHaExSUG85VFFnSVpBZ0lkU05kVXdvWGFwbWRYRVNFVDgyb3Vtb3Vj?=
 =?utf-8?B?YlNrR1Mza3MrMCtoOVdkR3ZpWit6LzdvaktFb1kwMnZzdm1oOHFoNlRNMFNm?=
 =?utf-8?B?MFNnb0ZQNDUvMTMxWWxqZWt1bHlDMlIxMWwrK01kdVpPQlJEaW56NkhzTUQ0?=
 =?utf-8?B?MWxIbmVBd0tEeDVYNzMrYlcvWGVJY0ltL3A5WWx3MUJSSmJsL1prOThpaE1o?=
 =?utf-8?B?K0NxTldXVkxmREZDWUt6Nzc0cVpPNGFGK09HaGdNRmp4UFEvOHVOelBDMXVm?=
 =?utf-8?B?T0xqWElRQ0taSHk1WFBDRDdZVXdVdlF2MUJnM3haVjM0MHBjdDk1YUNlSW80?=
 =?utf-8?B?VjBnb001cFlZUGJ6dzYxTXBIRzdFYTNGdzBodDZRS0doVG05cmU3SWNJTG1Q?=
 =?utf-8?B?SmpCWUFLMnRqM2MrOVhWNUxKUTNpQ25OMVF5b1M1THdDMDA2Um9qaExLSERF?=
 =?utf-8?B?MUxJeTBacVp4Zk82bVlKdkczU25KVWt3YkpKc09DUUNmN1preXdTN3YzUG93?=
 =?utf-8?B?TWliMUlRakFsZVVzc2ZncU9YTDltSW96bmpTYUVUczdoYlhSVWx1SmxsRXB0?=
 =?utf-8?B?TGJDZ3RnV2F6NzNIZFpkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGJVSWM0ckJ6SGZ4dW41N1d0SlkydVFnbDZFVmZPeG85eGdrSjd1cVBZOWxh?=
 =?utf-8?B?OWVBalJibGp6KzFkUXlZVVBocWRWQ04zeWtzY1gxQnRJRUhtMHlWTmkxK0F2?=
 =?utf-8?B?bGlkQlMybFdzTUlQMmFka1lHS1lEd01VNE9IZ0MxMFpHM0xUU1VmcHJRdVcz?=
 =?utf-8?B?WUpXWEp5NnU5WHI3U2Rpd2tKaEhWOFduRVJHaHFTeXRsNGU5NE9RL202Y1kw?=
 =?utf-8?B?S3p2dzI1ZCsrSjJHb0o5Y0dObUd6Rm9UUTJUYktNVlYyZFN0eHpWQnBwZ0VE?=
 =?utf-8?B?eEZQWkJMdTBhc1dOM0lJOU9mbTVlSUpkNm5PcUMxTkdwVlQvUjAwSnliOGcr?=
 =?utf-8?B?NTZkdGRIK1NGU25BNG83OWMxNWdGUDF4YjcvOWNwQlAvQ3RWejA5MXA4Vzlu?=
 =?utf-8?B?ZXM5cU1GTUJJdjdKbFVDTmxOSW5EYy9QdmNRM2RKR1prbkVNWXA5UjFnVzZK?=
 =?utf-8?B?RSt0WWxNMWRzS2krOHZ3ZGlYb1NzTzNNU0dlbThQSngxclRYWFZ5MGZJMUda?=
 =?utf-8?B?Zm55N3pVcXZTM1Y2Q1VXQmV6UXhEM2NydkRrUmMyMnh1RURVS3k3a0JUd3FV?=
 =?utf-8?B?anYyUWZTeEc3S054ZWRCMlZnSG45Vmd0cjdYcUVzWTlHSGJjU3Z2ZEhNNHBO?=
 =?utf-8?B?Qk5QMktmalIvMG45MldnOWt5RWtYQmdEQjJQT200c0xFNzFtanFXWHI2dDFT?=
 =?utf-8?B?SU9FQTFMUTdBOUFNSUxzQ01nZjNNa09JR200elFsSDJLdmZVdmpFRWFmcGsz?=
 =?utf-8?B?TjczdDI5alFUMEhEamVZcFdOVFRlbktxcG42UC9rM2RpWWF3UGNrbGxURTd3?=
 =?utf-8?B?bnFXUC9QdCt0TXVBY3ZGZ0FXcGRCZjVaSTF6OGlLVm9nQStlWGhlb3dMa2t0?=
 =?utf-8?B?ckFpbTJqMjF3QnVhZ1lYMHU0R3hFVnhoQlVXNllBMmtRaGxWSXE2WnMvUUxL?=
 =?utf-8?B?cW9BcVB5ZmkxY3o3S2M2WlpQbHZ6RzVSZ0MvNDhrYUExNm93NDdDc2d3d1Mv?=
 =?utf-8?B?enVVQXB3RllxNVJ3Q0FqMEx6TGU2SU05TUt0dEdJMEhOb2xOUEpnSGhMMTlq?=
 =?utf-8?B?VHdVU09NYjEvd1RUVHovajRmc0M3YlFYR3J3cWFxSmZqRndUMk1UR2tYWEdK?=
 =?utf-8?B?ZGFuSFVPYys0M1d6Y2NsWlE2Z2FaYkdYaVVZSXhNcW4wNDBPWW5sMzEzWmlN?=
 =?utf-8?B?ZlRDQjZVNGU5d3BzZTB0czRaMm1rQU52WGtzSUYwZzJSZk9BQnV2aDl6VHVV?=
 =?utf-8?B?dkIwRllhd1llbGxkNWNLWUhXUFBoaWpFYWF2WkUwRWVqbDBVWWZyVlZtQWY2?=
 =?utf-8?B?dG1YT1Ntem1zUGRJVlNFa3A2VGwyd2liUy9Wa0J3azYwNVJkeUp4NTVrYmNW?=
 =?utf-8?B?d2J3aEk5YUZST1RlT0RjRDl6dXl1dVl3amtnVG5SVUJRYVJxbHgzVkl5eGls?=
 =?utf-8?B?N1pMdExaL3FvY05ySG5GSXl3WklWUXRiVTRUZFBSQWZRV3pEUHJQZ1hXU3ZN?=
 =?utf-8?B?ZW1VRjhLdkhwS0VHRVpFZFNJRnkzdmdWNzRKOXhobnVmTUhmK3R2K3FWZmRS?=
 =?utf-8?B?Q1M5RHMxb3pjcE1QU01MaFlCUEhGenFIc0ZiRUIrWTBqUVptTThxMy9wZGFR?=
 =?utf-8?B?Y1VDR3FpbVozazN2MDgzWHhEcTVSMVROQ2Z6REcvYmhNcWZxWVV0QmFId1Yw?=
 =?utf-8?B?bDNxa1ZnVDE2MnNxQzJwS3c1bEN0RG9mMUdHRFRhQ3NPV1psb3kyT2VHbjZx?=
 =?utf-8?B?MXNtS2J4TzBTTittWU9NMFVieTEwVzhVMHdxM3YzbHNJajMySzNaSGJnZnVO?=
 =?utf-8?B?M1BOc2VrWG43RHQweDRoZFFsald0YlJkam5TbEtRb3BxNWtsVHdtTGxCaTM3?=
 =?utf-8?B?Uzc2eHFwbzRvK2xGdjczek5zd1YvYjVmQmwzYXlhSmRqS0M2ZXBYdC9GRExK?=
 =?utf-8?B?blVxV2ZEakFRemRpVnRyNkRLcTFEV0hjZEpkMmtDOVFhUS9Ia1k3dm9qSStl?=
 =?utf-8?B?Q052RkJoMWt3WHJWWDdvU1J3bktYZzdlYzE0OVVzMnRwdkt6aWp6RC93UVV0?=
 =?utf-8?B?d090NEU1NDV4ZDJCb2p2a3JIMHNpUW43YUpqRkNBa0VibGhTbk1pdjQ4UWRu?=
 =?utf-8?Q?3Vt4gKC67MshgzoPBuiz/4lcu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f75b370-6863-42af-35ed-08dcc842b38e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:53:18.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEitapa+mLwm5zEf9DtujuW6jlTgEPraXPlAEX76X8w7FHVHahR5tpiCF1RP8vdwkeCtLhJE/70kHUBhDLMRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994



On 8/29/2024 10:41 AM, Borislav Petkov wrote:
> On Thu, Aug 29, 2024 at 10:29:16AM -0500, Paluri, PavanKumar wrote:
>> So here's the updated diff (for patch #1) that is compile-tested:
> 
> Make sure you build
> 
> "allnoconfig" "defconfig" "allmodconfig" "allyesconfig"
> 
> builds, for both 32-bit and 64-bit on each patch before you resend.
> 

Sure, will build with all the above configurations and send v2.

> Thx.
> 
Thanks,
Pavan

