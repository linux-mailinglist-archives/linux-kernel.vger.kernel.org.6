Return-Path: <linux-kernel+bounces-427990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5E9E08D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15143171E43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FB51A76C0;
	Mon,  2 Dec 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pNpsoM/G"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020076.outbound.protection.outlook.com [52.101.46.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101D1A0726
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156585; cv=fail; b=cCJMVaxtqsnSK+C1mgZOW5N/EwUnCsnfm3s/rr/lPhl4t7tvnuMHO69iLDtDhAbuh0CL23oJA49vJDjp0f40G5UrrnDYrk0z+w01XC1oMagskYf7yjP2BrPXeWzihHjwY5yTrC8EB6P9vf5y4vJ9i/A18hoh610pPNBkZdfy1dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156585; c=relaxed/simple;
	bh=BLxGN3kBO1UIPrzd/9WgozXkmTH9SA7kjLPyYU4vFIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNzDEb0Y1i3DTERKsbXTuSEHN4eLuS5gt8jKEvnekEfjonKKTkMd5L1J4Xx0MC7HuSO9XR6uiS5hDkr/ZvZpMlgLntuApFfacluCND8GBPDk81mhgBBe6Y3KpX/U+lw4eUU3i1EKzlgCXbenfedK6cLMMtGktmP+1T3NZVuAne0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pNpsoM/G; arc=fail smtp.client-ip=52.101.46.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbYJrFITA5Vk9pKfj/zUY6S+z06g2ZfWkSTgKIdHIKgfAWNSa2BguRLuaQXE8FPSv4zzfLFjLJh7pmk5wOec6JGzC9ZHDUCe/bnX75MNC4bjLHymG1KrbIF6lf4d+8lGTEyqGarGVoSIi13SkrtxYghPRsxtUFpduBD096Cj4IkbEDlXcEOJ5IB7EnGUKXE0Rnaq2kF50HLLcOIj2nO1NWMjiTmZs1jZTuk8GKKdf9b9Pnvxs8K6RIGzjXJxaeOUpZMkFrCcHIVXap8IOHKaBtdE2JNBPOCAE6X/LVndY+mXrGS8LXcV0EdwkhLCytO02eKdXqGuDVWxi0Oe5Q130w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a+frv1RsJ9vO71VF1PYZDSb10mJnM9MNIx2NhBHz4s=;
 b=EWUSZXiIyqx2h7qaL/2ZkuJ4xZtVsEvAtuZ3HfPRm+7hVDqO0EiRu0Kc9CDW2a7i77EzpF/5GeEgAcOfjnKweTO7ZSJlzEvCR1tVJZr6pjEmKXRRLck0H7nXxuX7u+MAYLgq2d1NkkfJ3R6HypbZrwFqbnoano6kPxqWeepJbXdhcOssvkuN8wFRRh0fKKpllgRlgnySx8ExUAsLyvdpMu4VUgmVy5cwuXTVp2nGc5oBsT54d3qwleGeEk5u6lXzcaHcT+iRyZ+Vms1WeiFvL2R5RlI7NxNf5mlH4ffK3niVZ/QfPcCZPPK0fpU003lb9pftFOQo2fJ4VAvRt37cSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a+frv1RsJ9vO71VF1PYZDSb10mJnM9MNIx2NhBHz4s=;
 b=pNpsoM/GMzGOtLDqkc1/K4dxPUa5b0IVS9f6JFa4ZeOku5vgzJk1STcSz5fY2xsQ9YS/67sluMsviVS3yUeLSdQBMuXpyd1IF6wYHK3+kr7ERGwdi3b1SDct9K1hfEm7VMgu4r1JS4eS1OLn3WB0+PkHZEUdBnSmerPlMLGkY2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 CH5PR01MB8958.prod.exchangelabs.com (2603:10b6:610:20f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Mon, 2 Dec 2024 16:23:02 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%3]) with mapi id 15.20.8230.008; Mon, 2 Dec 2024
 16:23:01 +0000
Message-ID: <6aec1d44-4a89-4acf-a16b-4493626b93bb@os.amperecomputing.com>
Date: Mon, 2 Dec 2024 08:22:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
 <e6b3e6c7-193d-43c4-a8c6-6023458723dd@redhat.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <e6b3e6c7-193d-43c4-a8c6-6023458723dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|CH5PR01MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 1313c533-c72d-42b4-ed0e-08dd12ed9775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THRUSXR3UUw3a2lSR0xVNURFSlpOWTBvWHNUeVIwajFCN2R3UWZUUHBrNUtF?=
 =?utf-8?B?TTVqMUpCQmM4SFRwMWt1OWtxaEovV29KekVDZzRVYmcvdE5ZNE95bUJaMGt5?=
 =?utf-8?B?akxpWTV4eUFBN0NKMGRKc1JDL1pqRlB6YkNadlNGMVJZTGlmSGNmNGxHUEtw?=
 =?utf-8?B?UXlMK0hTSlBLWWdlTzVidDc1NzhzOEpVNllZOU14Y2M2cU5ZZkpneG9YWXI4?=
 =?utf-8?B?V0hwYTVDUzBIcGdBU0tBSFU3L2RvdXpTMzVUTldPUWcrOFp1eE5wODRaTlcw?=
 =?utf-8?B?Tm1pTDZvWXZ3WUk1UjVOK1pNc1krWG9ZVEY3Vmsxd3ZNaDFROWVuWU4xS3Nr?=
 =?utf-8?B?elRha2VGSHRtejNnYjhJK0FzVXYzemRLRjVtNnBKN0dDckpSOUZ2bVg0eWFW?=
 =?utf-8?B?RzFlclAxS1ZzYm04S0pDTXNLVXhnRFdKVE5DMWpMbmZ0VmhOUHgxZ0ttMFJY?=
 =?utf-8?B?SWR6a3lnYlpiRGNXOTZseE14Ukc4bnliYWV6WEczZ0M4anY1V2ZHTTVWUEtp?=
 =?utf-8?B?cEJnSnhSdm43N3NFblRSNGVycTFNekVKOVpTT2dGbnMreHhTdm9oS0UxN2JK?=
 =?utf-8?B?bHRJaXkyUjlPREp6WU1NdlE0bXdETysxOWZKeDh1L05BeWNZbk1obUE5am81?=
 =?utf-8?B?Z08yeHRTTlZrR25lUWlHWkNiZHY3eHFvNWdUQnVHbmI2MzRKQnI1TUFSTEMr?=
 =?utf-8?B?UFQvWFVzVjZkVlR6dUVLSmlDalI1d2RGS3NlOXlIck1BazVBeXJmNWVGQnRN?=
 =?utf-8?B?ZG9JcjhCdzVKcWpPQzVrUER4dWlGQUhwVUJ1eVc3cXNFYktMdVZMZWg4WFBx?=
 =?utf-8?B?eTFoTzE1MnNQU3NQbDVkNVkxNzF4SlNqRVcyZFpmenF2UUJ0d2s3c2NXOEVI?=
 =?utf-8?B?M0NJcThkWkI5UDJjZlhSc3VoQWFJdHdVa2FrM24wbVNIY3BlQW5mYTIvekdR?=
 =?utf-8?B?MzJIWUthNlNjZ045QTlaMWxIWFpqK2Fya2s5UkM0RkQrU3NkL3JkMXR6UGdt?=
 =?utf-8?B?eVo4cGhISFpQYWM0VDdkc0lzaG1kZm82eEJ3bDVWSzdWN1F2SjJJb0RKd0p3?=
 =?utf-8?B?anFkZ2pmc1ozSStsZGZtTE45aUZEdU45ZGlQUWZDUXREeThyazNaZEt2aGxZ?=
 =?utf-8?B?dWlMaHZrVnVHbjViVDdkbk9iUFdjSWJGcEQzL2w1NkpUekJKQWJoODQzOUZu?=
 =?utf-8?B?Sm45bm84YmMza0Zra01iM1FBQ1NNN1hXZVcrRExMa0VtQ1F4c2JlUlRSWnlX?=
 =?utf-8?B?NTRPdXp0d0pBc1poR1A5NU5JK3JPZUdjak9La21BY3NoNEJCTElrYnlRc2lL?=
 =?utf-8?B?cUZzUVNQRjl2dEVydlNOZlVaVmhqM3c1T2RxcGxJckVCZHFTUmxnS2hrQTZj?=
 =?utf-8?B?RUppS3BxU3V5blZnM0VKWUxHRzFvK2E0VGFTdXBqakZhWFJKYVhUSHN1Z05n?=
 =?utf-8?B?OERpWHpPRTI2M0J6bG5odWRka2VPQXlCUUJpZU56UEEya3dMblZYb1hoNEVw?=
 =?utf-8?B?c1hYM0dZVjFYV25BZnBRdEtqOTlUNG5taE1tVG1hOFZ2YVJYaDNQSERPMVdj?=
 =?utf-8?B?R0ZYNlpMaGpuU3BRanZ4a3cvcFN4UmJxVGlNYTdYRjlnNVB3NEtlRVFSbExQ?=
 =?utf-8?B?Qm8wRHFqRlRSU1pwc01GeEpZNU5tK1BXNjg3VWZDd2xzeXZXTG1kY3Y0cCsz?=
 =?utf-8?B?bmFpMTZtR1laay9ETDRBRlZFdTM3NVZvTjJBcHBaOFFWZ2VMZnpRbGg4aWJO?=
 =?utf-8?B?WmdEVE5MMGhxVkMrcmRFN0xCVEFpNnFjSDc5K05LeS84RFgvcGtCeWJrTU1u?=
 =?utf-8?B?SDNHMmpIMVVBcUZCMC9KZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWZhelpVc0lNb012YUdFR1RLOWs0Vm12b0tBdXp1RURQU2dneEdBVGd3Y2tC?=
 =?utf-8?B?dzlxQ1lKeXRkcG1PWEd4M2ZLU045eEtWSjg3RVRjM2dmaUt4cGc5T3ZteDVt?=
 =?utf-8?B?dmRWUUgrd0RwSHJ1T2E1clYwazBHdE9wZ3NheWV3T0g5UGV5ay93eUtyRTZp?=
 =?utf-8?B?REUvWXU1K3JKUWRFVWhMa3VtN1MwdTVHYWYzSjRybUlpaGlTVCswWEtyakRq?=
 =?utf-8?B?alNxNnVSUEdnSDZ0d3FJaE1EWkx3RmxjazZ5TGVuK0xwcFUvckZRYmc4eGNv?=
 =?utf-8?B?WklqM0U2S0JlMU45bTNzbjQ2dXhpdFJRbE9rckZyYTVpL29DZC9NMWJQZk0r?=
 =?utf-8?B?Qk5BTWNXbFlQS3YwOE52TzJwbmJJWGQ4aitleVd2Vm5zbnhMd3lJL3RCN20x?=
 =?utf-8?B?WGROZWxjd0gzbzUvRkh6VXdubFNkMWsyT2NNVlJjSUE5Umw2Nml5dE9aZHFa?=
 =?utf-8?B?ekNCZ25vREI2RGhtTXdOU05aMmp4N3BQb01oT2Qza1Z2RmNtaW5RZ1d0MGZX?=
 =?utf-8?B?S2pySjVCV1FEOW1QcDgwcjFENHVvTExaVFRDTzlTc2tFck5QbjBJNyt0bERo?=
 =?utf-8?B?VXlScTUwMERQOFR6ZWVJby9jTlNmd1UrbXJVSzdVd2pKYjZNVisyL3ZsQmlE?=
 =?utf-8?B?cnNKZGdwU0l6bkpXRGYzL24yd3dYdCtxQ1kxTnZvRjRISWdVczk1d0JiMllm?=
 =?utf-8?B?R3A3TFQ5YVVTY0ZUbDJtUjZTSDU1b05qb3VLZE5NcGNZUmJzcGIvZGZoZlZJ?=
 =?utf-8?B?RWpDUHRJbm0yU3RRSk1nbVB1WHIyWTRRR0lzS1BReWFNT3k1QmVGMmEvYkRj?=
 =?utf-8?B?YmlteEd3aDJPYzVXTGFYSzRsUmhKMkhmMjVsTi95NFpNVStFcHJwSmVuSWky?=
 =?utf-8?B?VmlvWnF6MFo5YXdnaHl6RjB5eW9DWUZ5bk1MdDBFM3RTRjM4WGRkS2Q1QmNp?=
 =?utf-8?B?eTZ2bEVOUmZaWERTTXhSMzdoY3BqNjhJTlU0VmYwMGo2OTVSYUpTTjROSHZR?=
 =?utf-8?B?UFVkc1NUeXVTZ1p3bFBNUTRwQmM1ck9TeitKTXB0UkE0WWlDa0tQZmNxRnd3?=
 =?utf-8?B?YnI2SmtIVUttbmhEcTZPNFkxKytVdkFhazZhM2JXbUwvalNYNlRoWGpOczZI?=
 =?utf-8?B?UkJwaUQyZnNsbUF5MmF2UGx0cUdXZEE0bGdIbHZrVXo0TExmZVV1UVNDZk5t?=
 =?utf-8?B?K2grSnExZVA0K2RvTlBheFBuNWVFTWVDUzhBQk5taXArVUx2ZndXZ3pNWVJ2?=
 =?utf-8?B?aTNXWHRvcTRzVHpQNTlhdXVuUzROOFB6cnVwSUY5MU1EY0UwOGRNY2lqUitu?=
 =?utf-8?B?d29mVHg1UHNQcG9SVDlZcGxYQURlaGIrK3Q2SUh5NEN4UWc1Q3FGR1VNdUxM?=
 =?utf-8?B?L3MrWmFkVGl1OFpxQ1dnRFp3cEN1UUR1MHFaZm5HOHhOalg4TmRVa2xWNHFZ?=
 =?utf-8?B?T253cUFXU2loS1FZSVowYkJPYzdFSjBza3RsRU5QZTcwUUp0dmJ5SnRYSW1r?=
 =?utf-8?B?cXVoRXNRUiswREYydTU1WE5RNVFxTWp0RTZnUGErVnUrYmUxc3JIa2l4Qyty?=
 =?utf-8?B?L1MwUzlac1JudmZ0KzM2dVBpRVV0eUp5c1BzMTh0QW5LU000MWpPZU1taFRI?=
 =?utf-8?B?VTFGZlJyZ2xZZmVDOFBQcnhSSG1VbGF3cnFPNHBMSXpYOENNRmkzd0JIT2NN?=
 =?utf-8?B?a29CS21HUkludFBXZUtFSEdXam44MWRrVEZrUW9XV0JsZEpUV3ptTlVwU3NM?=
 =?utf-8?B?Y3ZpU0VCVlVuUVJYWW9iSi9DT0JnZnA4dytoNG1GSTFXcmdMRTZVSFI0M2Ix?=
 =?utf-8?B?Z0I5TTZQWEVJcGdMT3NjSjl5dEhKZjNsOXl3RzExVlQzQTNlbVlneTMzMUJQ?=
 =?utf-8?B?N2l5Z2hUbTdGbThPajhRc2lyQktQQjc1dkJJZUVhT0hvcytpRDBwSmxkMGZi?=
 =?utf-8?B?dGhNQytCbnlYU1VrVllKNHBkVk11ZlJLRXlZZENKeXRDMWtPNEVxaDRTMGpy?=
 =?utf-8?B?RlMvKzZzTk1yZkNOTkVIUzBxTDZ4OUtEWnFSb3BlWWxDSVgyNVJBNER6eklt?=
 =?utf-8?B?UTMxV21sNXZ3aTFxeVoydUNpazROWTkwQUVkbFZqRytteU94RnZ1bGFFbCsz?=
 =?utf-8?B?cmZGZ0w3c2ZKaUt0aEJDZmFJREtreWhicnE5L25aVWxWWVpuUjlEUkhJZWZW?=
 =?utf-8?Q?LP7yrBvo194VzkHgZCoBtQI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1313c533-c72d-42b4-ed0e-08dd12ed9775
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:23:01.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cfy/ShXtNaUwdzpg8dbbrAm4YxGcc7eRrg9iBmOuGgqfdM+5Ks8+XwTG+cP1qVOOV7gs55LMDCVFd/OxuDiOvo5lqkdR9i6IZPtoi2+je/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8958



On 11/28/24 1:56 AM, David Hildenbrand wrote:
> On 28.11.24 02:21, Yang Shi wrote:
>>>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>>>> index 87b3f1a25535..ef303a2262c5 100644
>>>> --- a/arch/arm64/mm/copypage.c
>>>> +++ b/arch/arm64/mm/copypage.c
>>>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page 
>>>> *from)
>>>>         if (!system_supports_mte())
>>>>             return;
>>>> -    if (folio_test_hugetlb(src) &&
>>>> -        folio_test_hugetlb_mte_tagged(src)) {
>>>> -        if (!folio_try_hugetlb_mte_tagging(dst))
>>>> +    if (folio_test_hugetlb(src)) {
>>>> +        if (!folio_test_hugetlb_mte_tagged(src) ||
>>>> +            !folio_try_hugetlb_mte_tagging(dst))
>>>>                 return;
>>>>             /*
>>> I wonder why we had a 'return' here originally rather than a
>>> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
>>> issue with the hunk below? Destination should be a new folio and not
>>> tagged yet:
>>
>> Yes, I did see problem. Because we copy tags for all sub pages then set
>> folio mte tagged when copying the data for the first subpage. The
>> warning will be triggered when we copy the second subpage.
>
> It's rather weird, though. We're instructed to copy a single page, yet 
> copy tags for all pages.
>
> This really only makes sense when called from folio_copy(), where we 
> are guaranteed to copy all pages.
>
> I'm starting to wonder if we should be able to hook into / overload 
> folio_copy() instead, to just handle the complete hugetlb copy 
> ourselves in one shot, and assume that copy_highpage() will never be 
> called for hugetlb pages (WARN and don't copy tags).

Actually folio_copy() is just called by migration. Copy huge page in CoW 
is more complicated and uses copy_user_highpage()->copy_highpage() 
instead of folio_copy(). It may start the page copy from any subpage. 
For example, if the CoW is triggered by accessing to the address in the 
middle of 2M. Kernel may copy the second half first then the first half 
to guarantee the accessed data in cache.


