Return-Path: <linux-kernel+bounces-554552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E6A599C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4863A5328
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675D22CBE6;
	Mon, 10 Mar 2025 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4OfXKFtw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140CA22A4EF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620070; cv=fail; b=h2u380cJblKlbvxhACOrQmRCD8sdIPIIz0HbDaFEH1RzIPLJz64wQltrYOXQrEu+TPGZk0kC2SH5nwZyd+fqivZr0Z596TKMH8W/rc7ygkiwWsXWjhanaDWP51+CyaCaLbE22MWC0BdWZoDMrgP/eWo+t1mSPodzFQuL/qaxFWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620070; c=relaxed/simple;
	bh=lgw622a2dqyUPCbPaN3UIN81a/NswtQG4PNZZpGrel4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p8Be2cXDA+AdSHViVbQ/Nldep9eu+VnWZ5/E3b8mROs0r86Aztfn63ucbKeae98L51WLvZwKw4vLr3W8803CfPzdYatCYoiCIeXdo9BHVE+yup5nmll7OPPeDR04fNTWCacxZcsJh6OBuej5+lru6PvRLtQL1HdlvwHRbaPrb6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4OfXKFtw; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZOA79JK0YXiOdAvTsn/6o0bGw/6y7uHd8nAsTlX1LY+Yyx4sNPS+9QkmXDvDJ+2YlggYlUX7v2v/kmsW52fAm2jPwjD1NAYHGMq40zpKzGQcGufD04nlG34HETQsVSaSxK+3g6rQzDrGhDeTXQxKzufO4xNZylvPRMJXPj227n8l3yVGHogRzmCMyUnvSHcnsUWWj9O5RKP6Rm752dC97rZdZd6E4Dpiuk0Uije/oCvTwDaOZ3gUutwD8TuCMX87qQ7T2DyO67uXtCpMADnGeGfU/mni4pmi04q6/jqcRDvGYuID/Hy1pzDFszhdJF6u/KzRpgP+b0pON6mJsxMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBKG2LecTEH+oTtWihpFWgf1qkB9Fb/yg1+WukVQvgg=;
 b=hy0KdayXtLEyXcNe8aojX15vEAnfYkb47X2C+xnkXyL5TFFtj6cgyLhGARANnQIMh/rrUfbttNqDO1yghmVOGPFvFxOwJDzu4WXdKinuEtMCdhOnvztwjeor0tUTDWV9v5EOobBehkWPDQAqbcWMsAqQXUFuI/swWy8aL44QUlniVLf6+OvIlNBEpbnCx1KsVozKUPeU3mXvOO1+AWMm1XmO5SB3LmctXdpppporQkeeSFuxTCNTOPa/HXCrIqmJy/ACS6Ly8y0HaxmHPeHAtnIqFEpPv+Z8hc0/WT0Jt0ND9aFMP5O080K4MRb4x7r5XWo5hSH+F52k0L0Q29eIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBKG2LecTEH+oTtWihpFWgf1qkB9Fb/yg1+WukVQvgg=;
 b=4OfXKFtwMyI4ugvaty6wDEDEU5H9nxfodB4nwQDQCzBxW3bP+wzowDRSR/Qb6AkEUsaA7MZ0Dl4hFCrE+TqJEV35D5v/qwnPQJ5hskKFJXEw8bEW8NtKliKnRQn8hHX9mJehpHGKdb9w58xNx5VLW+9u/bF+fyXlaGZjO/3E6Sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:21:06 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 15:21:06 +0000
Message-ID: <bbd7986d-70b4-47e4-a2e4-ed99a1b89239@amd.com>
Date: Mon, 10 Mar 2025 20:50:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] perf: Rename perf_event_exit_task(.child)
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
 <d8be26ad-763b-4ab0-9f57-cfafad792194@amd.com>
 <20250310144717.GS5880@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250310144717.GS5880@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: c429b5e2-2bf7-4406-9402-08dd5fe72d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFJIeG9Kam1KUFV1eERheTlBV1BObEJVVFlIRVJScUYwSWFsN0JUTjJ2U290?=
 =?utf-8?B?Ukk2d3pRbnhobE9FZzYyN1ZobWtFUktZaFNwYVZCK2FtK1R0WG9RMUdmZXY4?=
 =?utf-8?B?UnZFYVh5WTFEMUxUa3NLMVMyRGI5RDZmSlJUTGNLM0dTSjE3amx2cW1PU3M4?=
 =?utf-8?B?VjcyNk51Um9qbS9hVWZnZXVwTmphbEVQRHFmVHYxUk5EUTI5TkNrWkUwTTN6?=
 =?utf-8?B?V3h0UDZid1hzTEhxcUs1TXV2dmxGUUZzcDRST3l1cnRoSG5KdEMwYjZEUXd5?=
 =?utf-8?B?RkpBT0h2eHFVSU8vaEZzb1h1eFl1ODhMVk9Dak0ranBSV1FUSHVVcngxVDdu?=
 =?utf-8?B?Mit4Sy8rb0FHOGJvUUZEYzFudkpNVWpQdUMvZmp5UWVSd1JmQk9jR1NadTJx?=
 =?utf-8?B?U2Fidk4zQ1JNemZpR2d3TUVJcWxCeU82SmhHc3ZFeXdscFgwTkdQNFdZMkE4?=
 =?utf-8?B?L29KN1V4bjdwbjIzRVk0eVcrZG9CWm1tcGlLOVM5eXFvTURhQ3pGbzlSenJR?=
 =?utf-8?B?cGdPK296R1ZvazdTVWFTMHJLVXdrZWVIS1R4TEp5M2srTHZLbHZDMUMzZVFp?=
 =?utf-8?B?b2p6Z2dabUswbFllRm5tREVGVTdtV2RXNjlPdldqNEZJOVhOV2dCbE9MRTFI?=
 =?utf-8?B?Y0dDN0U4VWxjNXJ3NVI1TTUveWtZcXdtZ2hoY0JxV2tncWdFMmpQWHQ0eG9H?=
 =?utf-8?B?YUJkWFZmZ3kvelovMVZqVSs5cFNmQVU2QmRpNGJiWC9tSm53THJQME1jOURF?=
 =?utf-8?B?cEZrSWsrdnNlTHI4LzhKeitSRHRDbEhPZXkvNnNKN3VuODdmejE0L2FmLy9q?=
 =?utf-8?B?K2tuQ0pBY1kyZjhTSlZtN0g5QzdCbzNPblA0aHNuTWF3UWZ1bzdEYWtLVlE3?=
 =?utf-8?B?ckJJMmFGaWpuOEFDMTJIMXplSHVYaDNDVTFjQjJzdnhkcS96K1VQUldUT01P?=
 =?utf-8?B?T2JmeDVsOXRUWHdzTHpBZ2Q4OC9lOFhjSEVmSENrOHlSdWhqTnpBejNSd0gx?=
 =?utf-8?B?WUVLeldDaG5rOEhqc1RMUk1qQlB4c0lNWGdkdUJoZlpGU1FKelFZcDY2VE01?=
 =?utf-8?B?MWZiUHVUanhnd2FsbjZjM0x0dDJkQzBYTFM2LzVPaTRacVZqKzRWT1lKbkdv?=
 =?utf-8?B?a2RxN0VRclBUL1JYdm1IcEUvdENRZ0VHUVVyeDQvNmJObm1rQno2ZTFEMDBr?=
 =?utf-8?B?aXg0SkcyRWtSakxKeWd5aXdWbzBRUVZiejFpU0NJeWNkSDNyQjNNUFhqOUMw?=
 =?utf-8?B?U2N2OFZVQVdpYnJ2d1dqMGllUjg3Y291MVZRaXdWczdmY2FYM3VXMGE5UXFQ?=
 =?utf-8?B?OEZISlBBZHZDWnpFQUp0SlFmenJBbFNlYzFJVC93RCtLL1huZGFCQUNtVjFY?=
 =?utf-8?B?eVZFYVF3Q09ISHZFL01lWlk4bGFrMWtlemQ1Z2l1RlVxcmVWSExpR3E5SGd0?=
 =?utf-8?B?VHhzemVuYnNuUVlsVjN4RGsrN211dS9WbS9UZkdsYzREeDY4Uzg1aUloMFRY?=
 =?utf-8?B?cEJPeWRrQ0xiUjU5MWY4ZEU2dy9sMlRlMFcwVUhTSUFNWHllMVhCbHE3WU1Q?=
 =?utf-8?B?TUs4VmhrQVZyVmI4YVFNY1MzT3k2bUw3Z3ZsT3p0MXROb3JuUjNpNHpEZlht?=
 =?utf-8?B?UFhnZ1h3ditZWDdUcEFwdUJ0TlRrNFlORk8ra0RxSjhUSXI2MFVPbmFyY2di?=
 =?utf-8?B?ZjB5NmNnMVAxM3Vtby9qUXB5Mjhla2NIQWVNK1REeEYxby9uTEk5T0gyYVcv?=
 =?utf-8?B?TS95ODV6MzlPRTJOY2s0ZkdtcSs5OUsxSmd1dExXZzgwYktiRWVyQTg1Mk8w?=
 =?utf-8?B?d1ZNUWd4cFRYZjNmb05SNGZiMkpNejNlZll4SFc1TXBBczVUSnNQSkdNek5t?=
 =?utf-8?Q?dOfkts4M8DoCg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERXYTBuTWswWjNlV2laT2ZWVlNCcU5FM1RsTWNBL2FEcVN3QzUxNnExdVM3?=
 =?utf-8?B?OHd6VU92eHRhSDgvb0s3dXk5NG9id29jcVNjbmMvL1Bpb21qajhXNXlZS0pw?=
 =?utf-8?B?cnFJaTdLUE1nZmkyc3A1RFZwK09RZVNlbkxvU1FOVzljdW9XNHFOdXA2TXdo?=
 =?utf-8?B?VW1HYmJUZmlaTTJBcmJCSmJWTnVhMUM0aGJoRC9QazJHdFhScGhjNVd3ZGNQ?=
 =?utf-8?B?WWFENGNZVEsxdjFVNHNsSDFjazJIUnlabTZ6eWlQUEIxb05WalVsTnJCdmox?=
 =?utf-8?B?NkdOWVJma3hITkJ6UU1Gc3BNWTVrMHhWMnoydzJyV1lWcnp1S3YxcTA3SFgy?=
 =?utf-8?B?WWpKMUswRkZVNnJzT0FCK1pMTndiUkNDaXIxTlRDWVpnZEw0VHhIa0pNWXVO?=
 =?utf-8?B?NFM4aHJIeDJDa3FlcXg3M21QYVl4NWxIQTc0RFNoNy94V2YzWGhIYlVhTmZH?=
 =?utf-8?B?akQ5eEpPd20ycVJnRGdqbG13UllEcmdWS0t2NHJMZGtvQmg3dGdEU0tRZGpZ?=
 =?utf-8?B?Qi92cSsvM205QnhFcTZOZlpDVjZ6VkpEVU9tZDU5ZEZGRFRhUytrdUxyOUFY?=
 =?utf-8?B?SWFoQTVibHlBRDJiMnRBWjc0dzJ1M01raCt3dFJoOG1vYVhLb1UyTGYvWU94?=
 =?utf-8?B?czVlZkxQdXcrLzJNRGM1bjRVN2hRcmZyWjdjdDdGWDFqcSsreGFNS1pzTDkw?=
 =?utf-8?B?ZThJS3BORlRYNmhMcWp0ODJac2RTN0Y1UkJoYVlEdHlPd0FUKzg5aTk0RkxH?=
 =?utf-8?B?WkRzdnFEZm5ENEZpVnpheUloM1FCd0tlSXZySDVIMjRXT0pHQlllUjBJYUVS?=
 =?utf-8?B?elcrem82Njc2SWhRTHdBUDNIbHFpVlZXcUkwMjBsRkVzZFM5TUlLMGZacjlP?=
 =?utf-8?B?K0EvK2QrTDY0aXJyVnBIQmN4RXJqWkN4SmpZd0ZBK1ZNOFdYSmpoN0lQZUFV?=
 =?utf-8?B?ajFOZDdNRHUwVlh2eGRDTTZsbDJWd1FReG56c1NCbHphaEFtbXhnajBZcURB?=
 =?utf-8?B?VzZhdDIxRHdiOSsyempDdmhXVWd0WU14WWpTVnlLeXB1cGNiNUZab3hSeXNs?=
 =?utf-8?B?Y2piRzJzL1JxZDVCN1MwSXBvekdkVjFFSUY1dmtPR2FjaW9WTnpZdUUvUmdP?=
 =?utf-8?B?Q0ZCYTdQMVJjQnhqbnI0SFVDaHovSEwwMWNjUnR4ejU4MEFjTjZVMkJtZHds?=
 =?utf-8?B?dkpBMEJsa2Z4dmM0bEtQYmN2M24wdVh4VDk3VjBpTzRJRjdsMG5vQmlCUkV2?=
 =?utf-8?B?QS9CZTJ0OUk2N29Nc1ZJSGE2bEEraVhuTGJDbS8rT01ncVdob3A0QktiVUZ0?=
 =?utf-8?B?MTZXNGZJcCtGdGxSdEJCdUJ2UWJUendZZkwyQ1BNdENzNy9ONTBESmp5eHRv?=
 =?utf-8?B?SzBkNnFtWmZOUmVJRTRNMGtoTWg1WGpEWk5jNEpBRHZoc1hsMjF0dTB0VEhv?=
 =?utf-8?B?M0NTMXdyZG9uRDFKNFZLQ1FCYXIxYk0vVTZVbTRqOVFIdFFSenJjT2pUVXJM?=
 =?utf-8?B?bnFXVHJhWVdUWTBZcm5GdmZ4VWNhYUJEOVhMRTFSVTZvMFdiejhnUHR1MU15?=
 =?utf-8?B?M05wcmtHTUhsTExzUW4yUnRjRGxwdEhGSmNveDZoQ1k5d2lMSkhEYUluVGpm?=
 =?utf-8?B?bkxBSm9iMDBFTHB5Y2RGaUR0SURiclI1TStLQWVGdFJBSitNbjhvUVVvVGwx?=
 =?utf-8?B?dktIb1FNR2gwR1VYMWtBTm5wM2xLeVBMbUNhem1rdHFLZ2lDeHkvM002V2Uv?=
 =?utf-8?B?Y05sclFvWmlzcjVPaFY0ZGRMSDFKakozV1JKQkxrVzhmV1VoMEh0M2Vxb1lS?=
 =?utf-8?B?KzFNNDM4UGo1em1ISGptVnM0QldPMFI3dG0wU3NyTnVnWTdRSU9GOWVzZUlH?=
 =?utf-8?B?clVNSlR4c3M4elNFcUlQQUxJZ0hmVFdGWHA4YTF6RUM1VzZ6cmpuOWZORTQ0?=
 =?utf-8?B?WmVvejUvZlY1MC9BeU5nK1RVNmVvOGpNN1A1MDc2TkNiRWhlNjJ0azdOTTdv?=
 =?utf-8?B?NkhMQTZwUGhyaitJRkU1R3F1VXdkSjROWHRpTkJSNVo5cUtFdWZvSG5IbkFT?=
 =?utf-8?B?aWNVbGhNWGdwQmoycGE2dFdPc3lWQ01pbmxSNExNNi9KaEt3N09uMnJWcFBI?=
 =?utf-8?Q?jZtFHNYUoH5RZ3SJ8jFOlvIJk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c429b5e2-2bf7-4406-9402-08dd5fe72d25
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:21:06.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCqnvHlSMAz5sNkdtQqrTf4hwvtFZxXL9QeM7nwPdk1IZ/iewvr6B389V09a8Eb6uPKnKlDOmycr98d7naeX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

On 10-Mar-25 8:17 PM, Peter Zijlstra wrote:
> On Mon, Mar 10, 2025 at 04:38:36PM +0530, Ravi Bangoria wrote:
>> Hi Peter,
>>
>> On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
>>> The task passed to perf_event_exit_task() is not a child, it is
>>> current. Fix this confusing naming, since much of the rest of the code
>>> also relies on it being current.
>>>
>>> Specifically, both exec() and exit() callers use it with current as
>>> the argument.
>>
>> ...
>>
>>> -static void perf_event_exit_task_context(struct task_struct *child, bool exit)
>>> +static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>>>  {
>>> -	struct perf_event_context *child_ctx, *clone_ctx = NULL;
>>> +	struct perf_event_context *ctx, *clone_ctx = NULL;
>>>  	struct perf_event *child_event, *next;
>>>  
>>> -	WARN_ON_ONCE(child != current);
>>> +	WARN_ON_ONCE(task != current);
>>
>> exec() codepath (i.e. copy_process()) passes child pointer, not 'current'.
> 
> I am confused, this not a new warning.

Right, However the WARN was present only in perf_event_exit_task_context()
before merging it with perf_event_free_task() (patch #5). And
perf_event_free_task() is getting called for child task.

> Also, copy_process() is clone(), exec() is another code path.

My bad. I meant clone() code path:

  copy_process()
    p = dup_task_struct(current);
    perf_event_init_task(p);
      perf_event_free_task(p);
        perf_event_exit_task_context(p);
          WARN_ON_ONCE(task != current);

Another one:

  copy_process()
    p = dup_task_struct(current);
    ...
    bad_fork_cleanup_perf:
      perf_event_free_task(p);
        perf_event_exit_task_context(p);
          WARN_ON_ONCE(task != current);

Or am I missing something?

Thanks,
Ravi

