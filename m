Return-Path: <linux-kernel+bounces-370150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D025D9A2885
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8DCB25D61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F71DF253;
	Thu, 17 Oct 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hZpx7TVB"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B05FDA7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182252; cv=fail; b=eUlVRmHcC/AQRM7Ss6cuLGwIITKs7lmtwkL1CkbwAI3WgMV75IJ3BldTIJeVC9P6v9W9P0xYGKjxpoBvVetInYUk0GsC+s8Hf7qANEv/lOsj+8NisKYlMmoL/DmoYRvt0Sbiqcm2KaseRMwLNQzHeEfbLLAIcxlGRR0F0lMXg+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182252; c=relaxed/simple;
	bh=S1w4/8cHikJGsscMmdrfoRJXfiDo+9BnScR6Kuf2Hc4=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=eqUiqW7Pnb4FjF7ZJrhb0rgniXmkcqFMXVozte8dx9l4y6vgddetb8OBAoiu0jc1Um1NhwkXVuo6bWk/3Hz1WNr5Xc2vRMNjTrIeC/yQeZI/V3z/RH/TyUO0vm6Zzj90522xf1OrTm1lbXDBs1Jgr5VrDMAa0Uk6gwaKQJ0fEaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hZpx7TVB; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBiBLv1EY+inPjR2VTILRETZy0Z+l0VXFblbgrw3FmmttDuzyNY3GjB2/4r4N+/6C+7SzIYYdXhWHYLtU24XEshlvn+IjwJ89654vrQyhickNMua0l9rXGCYrgJ7/Q5KEZL2bqSSTCz6qbMfVo3EbnYQYaN2KSz+sigHBkTxZSFvLjg02w7+iDaTOMNp41BZoNg+mzswxKKds2yQpEoE/RwMIZgliyr4+t5NcT4JImC/qjlmW8zXd03sbBl2T+v4iVXNUralwV1US3dnO7jqBVF8Nd5a3Lmm+YmkgMQTVAGsHME2yxcuzi/Q/25zDj8Wx256HmknGA5xCq3y0qzIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwObs9KqIlC1Edv3JjkbykS2XzuU/tDuiIegjYOekGo=;
 b=Z+2lT8Nymx6JnSaL2F1SjYs2PkYhKv0uPW4M1TQt5nb9TSZwb2JfHKOZQMRsqwClBw8HIeHmNkfKC2TpJeZByJOuL+QGKsNj/zHOK7bem+5W7o0x4toblJPT3HMB6XavqEt4SiPzEwnEpYZuWrlUholW3HnLZFew9GhuaX/nf2O9WnyQA/jWWYFBuThrJ8KtPA7nn+f4pM3UyRaR1J7aia50wvhUJK2COl6B/D+8JvY6MHB2BTtUNXISannflgZ8tvcLKjxnow6ZTx6MEWRu31x14H0xfHkllS4fdOGs8waO/qPNRF2ZJqTZzGA1enLWWH94dDiKm+xoMh+1STzZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwObs9KqIlC1Edv3JjkbykS2XzuU/tDuiIegjYOekGo=;
 b=hZpx7TVBwat7iHWtXMmyy689/Z9YIQcN8V22H1G6kOMqxlu8dhptpv1FSR3MsRR9CEVYIpfBzqmuiQD0xd4O9+6wjOVerH1s2cdLebGTqg4MGFQeXdU1O3c7kTDlBXg75PfO8JK/SSviC216c2871r9HYmUX7d89yx5tdFtKw9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:24:08 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:24:08 +0000
Message-ID: <f5383cb1-0c0e-eb8a-e3b5-bb7d5a80fcbd@amd.com>
Date: Thu, 17 Oct 2024 11:24:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
 <20241017152601.GAZxEsid01FYKqwnPA@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
In-Reply-To: <20241017152601.GAZxEsid01FYKqwnPA@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:20::11) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bae622c-0e54-40bf-164d-08dceec82017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V05MUWgzd0g4YU9zR284TTlYNXh1blZNVTV2V1VZai8rWGlQNVdHZ1dYQXdH?=
 =?utf-8?B?cVUrb2ttcEJBMTk4ZExURmszOTUray85eFZMUUxWYllnQXJVaWp6TG1CeVBH?=
 =?utf-8?B?SktkU2RoU05mZ3pLcVFUUFY1UGJNbnVDMmVhZGJmVWUrd2c3aGxJMHhTVUs2?=
 =?utf-8?B?aWEvdDVEOWNFNUZ3bUllZTBaV2FoYkVQUGZEa0dSaE9EVDV5TVNrc3cyQVVh?=
 =?utf-8?B?cjFFRzBjN1Y0KzVVMElGbFMrdHVPcHhwbWM3N3U4S1pqVm9LaHdUd2h3RE5R?=
 =?utf-8?B?NUxkdzRjcUFGREtmTnNQNTZPdUMyKzhvUSt0ZXhZTHpOdVM1ZHBxL3NSelo1?=
 =?utf-8?B?U0t3VE9XVVljeUxldzRIT1dlVlhMT2t4WWJJNnB5bHhCenFISDRNYUtVUUZX?=
 =?utf-8?B?VllaZFl1azFZdndiNjgwTUJWRER6OGhUL0dSQmZhcTJ1TFI5OS9yS0lhdFdS?=
 =?utf-8?B?amorOVVMdHZFZnppMTFSZzRxaEl6cGR5MFpKSTJlc0VOUmdoTWZqL3lJM3BE?=
 =?utf-8?B?SlJkM3I4U0RoaEFTai9KRDFUN3FDR29zOXJHZm1OS0x0Y0FmMFhTY09TWCsx?=
 =?utf-8?B?NXhMR1duakN4MUF5WjlVNVF3OTJaK0s3bXJkQzcyU1MzQ0w4T0V5RWdXUU9x?=
 =?utf-8?B?WHRYd1lDcW9FRzdZbTZhV09OZ2NIdTIxZm1vV3NoNGJhTGpYWjhsbHlhRWFQ?=
 =?utf-8?B?QzFzTHNNMU5xeHA2aXM2eDY0ZDg1WG54QU1aSVdBbEVRVjNVOElzQkpqZW40?=
 =?utf-8?B?czhQeDYxN3B0SGdMQzJaWDZUalBEdFVPd0doYWZVMXJzdG8xTDBGdGhjQVMz?=
 =?utf-8?B?RkJBUm9EL0tnTnZxbUxzOWJmVko4b0NMbXhtbEdQbDI1RGFlZDZVTXVwN0Vy?=
 =?utf-8?B?TUY1dk5ReEFNbXNPQmVpTzN4bnBQNDNIVk02bER4Ujl3ZU9TQ2E0MnpDMHRW?=
 =?utf-8?B?Q2NabW9TVDlzSUtPaXJoZndLSjJERWZma05ld2t3K25TMDdoUmhBWlozd09V?=
 =?utf-8?B?NElUb2pCNmF2SFBpTk9BdWMvZUh1bWZFOEE1UVp4QVNDQ3d5b2JMcHdLMjlr?=
 =?utf-8?B?b2NweXorL2JrQzFiVFlrdGp5a3VqaXJmOWpxSnluLzRjYWRsNUlyU29UQ09s?=
 =?utf-8?B?dUxtSFBMSTNxR1RZdlVydlYzMXRkVlI4dlRJU1FKcWJtQ0VHeVJROWd4MW9C?=
 =?utf-8?B?dlkrRllSdFlIbkNvRmV4a0g3T3Zwb0ZGZElBUVVWUVprTDlMNVFKcStJSDEx?=
 =?utf-8?B?Mzc0K3VpTFlTbElYWWVCZlJmMVB1VTRDSWVma1ZCUk5FcERaYnVRbmNKWWNL?=
 =?utf-8?B?Sy9BbVlJZGdBVzZwNXdzR0FIdUUrZ1lpMXUvREEzRjhKdFlRQU83ekhWWWhn?=
 =?utf-8?B?bGxMVWtYc2d2TTlPVmJrRElpMGJPdm8xMzVGSHcxNWc3bzlQa0FCclovN3JV?=
 =?utf-8?B?czlVZk5kYmFqMkVBVHp4L1BLQ0dNakZLalZkamVCdlNqYk5GdnFUZEVLVlJU?=
 =?utf-8?B?Um5WMHM1UUZBYjFNK0RVYXVzZmcyOFdXU1ZMZTNDNTZNbk9hMzJTUzJCeEZM?=
 =?utf-8?B?L2I4MGhZOFVFUlZGZTFjTHBSVmdndW9JWDlFcUpXdFpwR2JIcUIvVm1hdjhZ?=
 =?utf-8?B?ZitBUmxPZnV5WWxoRHU3VG1FbXVUZUJUS25IbDRWUnZzZEc3YkZ1S0Q0OEVr?=
 =?utf-8?B?bTd1T3NmRWdMUkJ6eGxTK3VnYWE5alJUaWdxby9QOVhTQUNRb0hMRk9zWHVR?=
 =?utf-8?Q?QxmFY7PS1gd8umDKiecJjdHgvITSrfHMQpRaL8D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXNBWlNFczZuM0ZFY1hDRTU1NitxYVlJZUlzMHVyK0RUbEhBY2gvZmFmRzdt?=
 =?utf-8?B?L0RPL3VtS2t6aTFHNk5RSUl1eThVSjFQTnJwTFk4R0cwemZoUm5hWUZIRDE3?=
 =?utf-8?B?NTNJb055Sys1N1BDc2VCR3QzK3UyL2VQLzJtWFpzc1VsOW9sTXpNVWxTV1lU?=
 =?utf-8?B?cnJaa2QrZFlYdkpPQU9rQmwwSVRuc0dLTnRkeUdoODkrbjE0MVhuZFVrTTZy?=
 =?utf-8?B?ZUlsRHpKZGFyOVI4TjFrUHNqSU4vZFpiTElBeG8wWjhSby9pU3ZONHo2U1M2?=
 =?utf-8?B?Z3ZLOHRPQ2lJRFl3c2JtNE9JNFo3WEVpVkwxMVNyMGJqWXYzVWpEcm5EQWQx?=
 =?utf-8?B?YjdoVUpvTkNNVWxCMlFncTcza2hNOTdDRG01WXk3Rnc5bTdSU053MkF3Z3Rl?=
 =?utf-8?B?YmErcTVSM1FHZ2tWc0FpV2MwTTByWGZQYWlnTyttRW1OWHBpb0prVU50UlA3?=
 =?utf-8?B?R2FMbUl3bmZlQ0UzTUJVLzNJWnNqWUllVlZmalBtdmtkMVQvcVE5UFlreW5x?=
 =?utf-8?B?aERSVlB2bDNLR211TTlnejNZaEJvblYxNlFBbTFnRThzU3lKMHc0a2lSSUo4?=
 =?utf-8?B?N04xYURuYnkxYnJ5NHJtRmZlWUlvcCtnSGtmWUowTmx6TUREdHo3N1BOcE9p?=
 =?utf-8?B?eEliRGY2NTNuWjZoOXJrbWl2bk1wN0ZuaWJCVWUzMHFWRy9sMXhxRm9raXZB?=
 =?utf-8?B?T1RnM1hQaDNhdkFRbDRubE1ucWlFbWhlaU1Ca0psNXdoa01MUGcxYVBDRlBl?=
 =?utf-8?B?SFUvWEpkeGsyeWhYSlRQMEcrdkNkTVpidWxXblMwd0U1YmRyYTQvYmEyWmVi?=
 =?utf-8?B?RFlaWEw2TjREckpZdDYwZE42L0NvYUpVVzJxZ2dLZjhobEpkd1JJUTFOaU53?=
 =?utf-8?B?Z1d5UmRMSndZYmR0bThRZVN6TmpYOWtoR3cvKzJramlHdm5zNlZka2hZWnhR?=
 =?utf-8?B?dncvTFh2TllIRWVqNWpSaFRyTXJGTUNNSHpSTUhVYkkwZ0IzaDZnTVR6ZStW?=
 =?utf-8?B?RHgybzZZZEVRcmxrTklBWGN6SFN1RkpQbDA5WUdzRTEvZHdiVEhKcmtDUG1E?=
 =?utf-8?B?R1d1RU82b0xUbzFlVlMrOFZySjJtZHY2TzViaWw1OTgvdDJJZytob0pMR252?=
 =?utf-8?B?YUlzbnNXUnBDeHhPSDlrcHg1cmdBYmpPYkNUWFNsaUozbjduUXVaQms0V0lU?=
 =?utf-8?B?bFZtZlJvZithUUJyRHdnU0xxTE8wU3hTNVE1R014bmVkZXB6ajJHTEJNWjlh?=
 =?utf-8?B?dUVwN09GMVlxaEtaUGFHY1JuaGhrMm5KTE5yRFhubGpON0c2RElXZ3JHMVU1?=
 =?utf-8?B?U3RSei9jMEpvTUxxZlFrQVZZcDRCdXpwR0VCK2RlTWsxK3REWG91SWxHQmN5?=
 =?utf-8?B?UzRLTWU1Z2xWemp5VmhxU1FOQW9Vb1hydU5NdHBhMjJXTm9jeEZrclJCSUh6?=
 =?utf-8?B?eGR5dVRvMXNwYXFWUWZINmdON0Y1SXcwOUV5Yy9HRTNMOE1FeThlUTB4OFpP?=
 =?utf-8?B?MGswbG5XbzhSYzRJTzRsR1FYclBBVENCb0dkMTZRZmlSUmx4Zm1mbmJPalJV?=
 =?utf-8?B?M2x1cGUvaUF5enhIaEZoc1plVG4wOENJekdrSjRoVFdyN0V0enA0RXNiYldm?=
 =?utf-8?B?ayt1THBYV0VzU2NIWlhaVHh6Z1hSM2FMa3NnSDZpZ2l4R0N3b05IbXdiRmlk?=
 =?utf-8?B?T3hwc3RreTNKRGxpZ2xrdExXN3o3UThtaStXWGVvOFdsV1ZNTUJndGcvbDZ3?=
 =?utf-8?B?MTNoNmhKZU8zeWF4T05GNEJyUmNQS01ET2ZZbGVwejIzNURJQkZ1VFZ2RXZj?=
 =?utf-8?B?MndpTVVpUEp0NTByTkJXR3FKN2pWSndaeE1CemZvbTJhYjdxa3YyaVFuOExx?=
 =?utf-8?B?Y2h6dzhqcDlxRDBvZkt6akRQZkZaUVlhbTYvTWhPdE1QeU50M2NOSmFiTklQ?=
 =?utf-8?B?RmFhR3J0SU1mQW5OU2hIZmlSUmZCWDY4UHo3RzJTRHVCeS92Z2ZqWmZ3emF6?=
 =?utf-8?B?c1J0U2Yyd1dWYlhKU1pOQTZ0UHhFeGdWWHFJbEZCUG9KTUhFR1ZabitoS0R0?=
 =?utf-8?B?YWVIY1FWWEM0WEJCbGZnaGNJSno1alk1NjdhbFY5QmcxZ3VMNW5udEROSGdx?=
 =?utf-8?Q?HSIuG0bSCLB3DItC1Y1GoWMUR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bae622c-0e54-40bf-164d-08dceec82017
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:24:08.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svYsasxQjBxjUn/FTMlIyT4azbFQDRw0eRmWfeBR5qLOly3pY/VKIA2lKZNdqrT41P4QJY6QqEUoWkiS1bLiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

On 10/17/24 10:26, Borislav Petkov wrote:
> On Mon, Sep 30, 2024 at 10:22:10AM -0500, Tom Lendacky wrote:
>> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
>> +		int ret;
>> +
>> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
>> +			     : "=a" (ret)
>> +			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
>> +			     : "memory", "cc");
>> +
>> +		return ret;
>> +	}
>> +
>>  	e = __get_rmpentry(pfn);
> 
> So dump_rmpentry() still calls this but it doesn't require the newly added
> services of RMPREAD and so this is looking to be disambiguated: a function
> which gives you the entry coming from RMPREAD, I guess the architectural one,
> and the other one.

Right, because for debugging purposes we want to dump the raw RMP entry
that is in the RMP table, not just the information returned by RMPREAD
(since RMPREAD doesn't return everything defined in the RMP entry).

This is why dump_rmpentry() merely prints out the RMP entry as two u64
values.

> 
> IOW, I am still unclear on the nomenclature:
> 
> The _raw* entries do not come from the insn but then what's the raw-ness about
> them?

The raw-ness is that it is the actual data in the RMP table. The reason
for RMPREAD is because there is no guarantee that the raw data won't be
reformatted in a future program, which is why we only allow access to
the RMP entry for Milan and Genoa, where the format is known and the same.

Thanks,
Tom

> 
> This convention sounds weird as it is now, I'd say.
> 
> Thx.
> 

