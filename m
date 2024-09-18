Return-Path: <linux-kernel+bounces-332778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195297BEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881B61C21514
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACE1C68A8;
	Wed, 18 Sep 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkqUfsyq"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEBD299;
	Wed, 18 Sep 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673871; cv=fail; b=a5WhJi+ubH/6oM5KTBPkIhWy7K01pVZSD6fI+TpS3tvv1GKBnt4aLd7W2PHuF6ZShCQLzK+Jub+zi1rws3jBhqBZGGbAeRsvkR0Ujfpu+Hg/2x0CsgJmQyQo+gs7IFo6HOdXI1EMEmzARK3Rg34Fpl+sA24BPiu5FEBH7LdhLR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673871; c=relaxed/simple;
	bh=87y/sYeRPirGHn29gVHUgcOvHcLfRJ1gj8Qi7HersQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MccAzXPkKYaTBnRoO23cUzh9yfed5xY7YkuX+afuWm3X5l39sHWNP4NDzAFAkD1bB7bGVK7vk9ztJ9qsT3J3XeGD80gdl3p1hKnJPP23Kpw3hiENtEgsy7hNP9d7vW4LCP4bpdQ88L7G03zp3eSrUkLVdteih8a1EXtaIpz3Vmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkqUfsyq; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfTCFot3b8nq4tWpRMBtNon/D5jsoH7WwAEPSekNYE2Tn6VxNOxQGHJT4m/FGbFDs/5BXgJVfMt/Hafl06jO32sKRMVwt6Ag2lB9jU8A8oGR+/xjeDGr34NC6njvcnq5XA/JMjv+tpHqn9TnRkVQD0UesvLgx1tXK2IgO3rkAoEpGXKesJxEgRqff1q75U+lmclp2qZDMEqaBJ2Jlh4wbg9Vd0tVbx4Hexrzp3yo/ZqNoU6s6aBcrevD040IoW3JEsmbZhZ4V0a0Mx7XH914fKdYh5/qxnq+Msp5UgD242JMlWXY30vEaY0foUS3o9hAudAml6eUpAp+jKCTAbEt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Q9gzXGurWWIKVrYM1zu+8gpvTyBhBpNCJtJo1TlnA=;
 b=LB7w1JwQtU7kEltjTk4BPzsbyu5faP2kkPNtxuBOW2seKz6H90mSrsH42U7l9XW4RHOUmT9iMPWcZoSEF0UEEAcLRANXaWdvVo/kAytnytQS9Xfo1D4cA+GOsg+1/cT4S6nf7pUB3gnLGJAFPZWmY7+BdGXuuOrv2GpwYO6HDpsHj128KWySxQIQCBNFogxTkUhimOKF+vaKl83IEYqXrkbkshH3N0Ot4B6FDYqV3zNj8nfsO5lKxnm8i662eYutq8P4J82iHwgb2F2fX5TBbHK58ApBAwYBLpDNQDuEDw83ov6vhzwGKO+tO+f4pOcMDMZNh2TBBz6OGyp/kZAsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Q9gzXGurWWIKVrYM1zu+8gpvTyBhBpNCJtJo1TlnA=;
 b=wkqUfsyqozXaIZm+UOHM7hH0NV5RE8du3Q18v5ocjFSumKxkBJOvkWLWSXtEygElrWe93Vfze/lAFmMNYtQi4UmNxF/tMZyhFFm8KvNX/P/CarrmssdMtHkFqZi2v9CfGsnxrY6UlW0c93/jjbQav1faOBFA7hpwvTNeuINFj9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 15:37:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Wed, 18 Sep 2024
 15:37:44 +0000
Message-ID: <1f563104-c0f4-4f80-b441-5d4bd67f693e@amd.com>
Date: Wed, 18 Sep 2024 10:37:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-2-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240918094250.82430-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e171bb4-61be-4a12-79b9-08dcd7f7d706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmhLV0pHVlVldXFnVXhCeHQrL3ZPUlQrcEd1cStpdkw1Zkh6MkZhUXB0TXEy?=
 =?utf-8?B?eDdrcXhuRm9QbzV3aGZJb2pNNTBLdXBkcFBvYndQdVE3K25IYnptZXRXTnhU?=
 =?utf-8?B?dGFuMHBtSUlDRUI4VDVjTlVwTnpQRVdEQnUrYW1hTkNtTWhlOHkwb2VQU2Ju?=
 =?utf-8?B?WmlUSndncExoeTdnaXJLV2g5RzRRYzU0ZXo5bDdPVmh5aCt5UGh6dHBQZWYy?=
 =?utf-8?B?azZVcXAySnN5YWJoaDF6dGJxRWlpZFZ2R0dneXROeldQNGNobGFQTEdkdldt?=
 =?utf-8?B?VlYrTDg4b01zVG1SODFWa2xGTjlJams2aS9FTndRbGtEUkhFOWZkbkpmeWg1?=
 =?utf-8?B?cU9XT096a2s1VUgwdUczQ0dGd2JoQnNCbHhTZlpqNEk1VXd6b3BQTVpTbVNS?=
 =?utf-8?B?WGl1Umlra1JORzRWN3dXWTZxZjFvdEtWM0VPTDVSanZFRGJCaHljWDNqSGgz?=
 =?utf-8?B?QWdsOUl0NktvUnhFRmtvRXR1aXlUKzNtVGcrZEwrbXcwazJuSmFSODF5M2Nn?=
 =?utf-8?B?bURiNUpWc0dVUGZyQmlVa09SOW45U1lXMFFSZS9IdU1lRUJ1NHZTNXE4c2JU?=
 =?utf-8?B?TDlBVE01ZmpQd1A5VFBYMkY2R2R3M2E2WG1uekdWNmdEUDl0NTJWN1JqWnVp?=
 =?utf-8?B?ZFlnb2Q2Vk55VDhiR3FiMDRoL0NnN0ZuYnFuQldFUmQyS3Vnb29JYUNna0p2?=
 =?utf-8?B?YmVKT1JFMkpsbEwxSFFHc2ZWd2pFMXlnQ2I1VUU2YXFJVi9vWFVrVlhaVFNm?=
 =?utf-8?B?L0Z4Vm1QU2w0N0R3RG9wamlwOHRTeUFqK3dvcHlYTnAyZ3RjcGt4Q0xNQlRE?=
 =?utf-8?B?T1kxeW5nNlZVdzgwamYxc0puZHBCNXlhejMyRGxUUm8xSVZSZVpXZk9XQml1?=
 =?utf-8?B?eGNMSlh1Z0VvRHMxVHluUlk5bkpUVWZUbGNMbndkSjZFa0hnRzdIV0t0bFJQ?=
 =?utf-8?B?R0J3Z0FmMVpUVW5NZjBHdkw3REE4WFEwbkdlZzFpRjdxMUk5YXh2UGNZeFhI?=
 =?utf-8?B?enMzaGFtc2lIOXhBN1FDSnNJbUNSN0dzVWZIVFIvd1AxbldrYkx4bmVHclFP?=
 =?utf-8?B?TkhWODVITHJrdU9idmxySUd3OVpzUmRaMEFReW1VUnRwZmFGSnhPdCtJaUVM?=
 =?utf-8?B?cUlaVk84VDY0MDRSTTFMSzhrd3hxMjZ1U3hFaGxXZTdZd041b1BhWHRxZjZk?=
 =?utf-8?B?ZFFKMG40aVVyZG1raFBadXN0WmN1dFU3NGdpTmFaYTZXcFZrMmEvUUxhMGhD?=
 =?utf-8?B?cmNFckZSLzM3VU1PZ1FLelFodjVmS1FxcmpVNVVSTzd1ZTd4Mkh4djNpK2ox?=
 =?utf-8?B?bHNFZWVJallBTGQrSENaNmdUSUhTWUJCZWRGQS8yR29ZaWs1c2dDbjZYZ05Y?=
 =?utf-8?B?SVFIbG4yTzNZYXNtRHpyQU50Tm5MemsyMUhYNTh2Rmc4Ukx3Y0h6RzBhTUFi?=
 =?utf-8?B?YXFLNVdwWk1UTzVGSmMxczNrdktSS21ETm9hNmxkclB6c3JpYURoaGMzYTY1?=
 =?utf-8?B?V01EOVRBaUVFTVBjdCt2cjFZVHlvRUZ6d3YxbWxQR0thV3VFcEMydkkvODFS?=
 =?utf-8?B?Q1h5ejczYmpyV0NvUk80ZUtqZEMzaHBRb1hjUHpyNnZuQjJLNUx6b3Bpd24y?=
 =?utf-8?B?NWtsbUhTNG41UmJYNko5M1VZeXRqS1VxMGFCZkl3MzRKZXV1clltVGo1aWlI?=
 =?utf-8?B?V2NBQWVFNXJURWUvREQyZktzUHc5dURiZ1ZtSWkvUmFkdlBMTnVaclFMdno0?=
 =?utf-8?B?QXhQaEd4NXQ0UW5DWDZUM3p2Yzg3SGlrdStmVXdHVHFGYUcxTktsSXphTjVD?=
 =?utf-8?B?VnV1L3ZBL3RCNkRqais0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9UTGs5MFpncGZaQytJRFg4bzk4WkNLOEVwRi9kOFZpZW1DdENzeDhMTi9m?=
 =?utf-8?B?SDJUZWhZYytYRDRIOWd6QUQ0Vm5iZVZkUkxHS1E4ZSsxaVZ0ajZuYzROdC8r?=
 =?utf-8?B?dUdEMm8xek5EN04rQ2ZmM2laSTFmSCtqNENqTWMwYTBiOVNQd29xYWd6ZlRw?=
 =?utf-8?B?MmxlaVIxWk9aTWZjTXF5UDBCcGhEZk5mN1l3eUhTZmNSNFZMUU0xbVh0RjV0?=
 =?utf-8?B?RVNIOTN0SEpSZ1JSeW01ejdyNWpUSTNKUFl4UFdQbGJBRjVmRUdldTNEZHAv?=
 =?utf-8?B?SFg2TTVYdjNNVXFZL0M5STYrMGpRdXgzUUxBR0tOdzJEUnlWOHFXNXBtZm1l?=
 =?utf-8?B?NUk2a25uYkpkREkreGZXMzRLNm5aejVjYSsxcEtCU1B0M01SbjZUSjFUcGxG?=
 =?utf-8?B?VEFVTmFqcjVWZm5TSUx0Tk8wNXMwVDlVNWpoOFNHTVQ2ZUVRbWFsU3Axd1Fw?=
 =?utf-8?B?cnE5ZDlGMFNXL0RFbWdyaDdNQ2RxaS93cWJ5Wk9aSGNMNXRPRkVMT3lFalEz?=
 =?utf-8?B?ZXh5U1FBSWl4eE1vM0lPdkRFb0hiMVdOZERBN3BCTjJYVHpuVXIvUUQzSTFB?=
 =?utf-8?B?SGFpRWowTUNjL0taaWgvZW5UUUVmdkFSUWhHdS9HQ01EMWsyWk1kNmcwZlZF?=
 =?utf-8?B?N3B2SENsUEp6SUJJMC9KZEdmOTY4M0JFVk9VZGxDTm5CUVpXN3pPcWhXSmtm?=
 =?utf-8?B?dTFXcTg5czJLdXI3amtPd05TY1NhbU53ZHYxY2pBRS9wcVIyeTlTUmFGdUJE?=
 =?utf-8?B?WTE3M3hvTzRpOEdKSXNXK2VaMjZxa3BjS0YxWXQ4a3pqTjc1cEhYeHllcUYw?=
 =?utf-8?B?ckMwSUtoVU5vYTRqOWM3WHFuRkdLRXhHcW1BVyszZk5zRXloZ2FaNU1nczNy?=
 =?utf-8?B?UUorendnWnE2bWhWTnpBelVGVHdPd1RBaHRQZnJibzVnV3NyY05Ua3h2N2I3?=
 =?utf-8?B?cG9jRDVwMjkreTlLUW9NMkFsQ0wwZUc5c1gvT1lZTXRCaC9BVWlyVUl2VGMx?=
 =?utf-8?B?REJpMDRpSWJlcGgwSHExOEl2bUhxTnoxNGhsYmJ0ektLT3FPS2ZPSDQ5YnVD?=
 =?utf-8?B?SmV6UDhNSWMza0laYjR0ak5jKzZwcW90eUJsRFBsZWN1RU5BeUpsZWtUVWxa?=
 =?utf-8?B?RllqVi9ldlo4VHlsdlJwS1lYUFk2M05ncUdTQmNpMGcyUjNQTDVQNTIzSGJq?=
 =?utf-8?B?TmgxYklDNzAzWlpJOFQwZ094YWlUcmZmM3FJa0VCZzJGVHV0WjFLVUQydWw2?=
 =?utf-8?B?Qzg5VTFZb3BPUkdldmV0RlVOMzlMNkYxRDZFMHM3amo5Z3cwYXhDUTJ4a2tJ?=
 =?utf-8?B?Vkc0S1JCTTZmNC9aMWF2QVVvM3k3N0VKVHBnR3VySHJheFZoWS9BM2VrSVRV?=
 =?utf-8?B?eHJWLzQvbDlzanJ3K2RvUDlOa0Q3UGp3ZzZ4ejFUVWJqZER4T3RZYjJ1RnlU?=
 =?utf-8?B?aG5DNFBuZE5lMGVOeThRcW0xdXdDeUV1akFqNDUyU21rZzJHTENkcjdabmJO?=
 =?utf-8?B?ZFBnQWNocEJwaE5aQ1pOcERqWDJwREpLY0F2NjN0TGJDSlFUa0crT0VyZFlX?=
 =?utf-8?B?UEdvTytBUC9VNkxDaWszUGZkcGw0RWN5Um00citOZ3F3WWkvbE1zdVZCQkZv?=
 =?utf-8?B?MkxseStWcExGOThGYUJlbHhaZWF0TUJidEhOTDExR3RqNlRsTktqZnJVOEor?=
 =?utf-8?B?azlXRVNqYUZJc09MYmk1dkg0cXd5Z3E3Y0VvYmdyU2xrczVwUWJwdVovblB2?=
 =?utf-8?B?MHpnbDVVbW95Uzhlb0dlUGs3MzFoQk9BNFdZZlVsb290QlI1M3MxY012N2ZX?=
 =?utf-8?B?SkpqVzBZVEFSRlVhZFVYY25RczZtdHlRV0FKYXZOZXRCbU1qbUFTSzlNVHBx?=
 =?utf-8?B?YUtvZDNwejJXS3VSeFR1YitwRmNidDVGaXZ3L3gzcndxdFNybGpRRk02K2pK?=
 =?utf-8?B?d1dQMFlKYUEvRklDNW5RalRUUVYydWd1VENZem5oNE1ZZk1aV3laNzFubHdi?=
 =?utf-8?B?c3E1YjdFV2JxeFBISDQ4ZFpXdjVFVXRPd3FDQnZ3RHl5TW42V0xLSG9hMWRo?=
 =?utf-8?B?TEt4VDAzQjFFUEtQZ2ZkeWtDcUQrUmRNUHBHT0k3R0VCZk43U2hMVTBvYjZU?=
 =?utf-8?Q?PR7Qe/dRF+mYBmyUpzHxQ7d/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e171bb4-61be-4a12-79b9-08dcd7f7d706
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 15:37:44.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tOPaqlply0wamLd2Sk861wz44KwkBeFKzcIbUOJuTiQHIovk922MlT0uwxbnBFik2ySkedTqZefzg7gMPJm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

On 9/18/2024 04:42, Luke D. Jones wrote:
> The fw_attributes_class provides a much cleaner interface to all of the
> attributes introduced to asus-wmi. This patch moves all of these extra
> attributes over to fw_attributes_class, and shifts the bulk of these
> definitions to a new kernel module to reduce the clutter of asus-wmi
> with the intention of deprecating the asus-wmi attributes in future.
> 
> The work applies only to WMI methods which don't have a clearly defined
> place within the sysfs and as a result ended up lumped together in
> /sys/devices/platform/asus-nb-wmi/ with no standard API.
> 
> Where possible the fw attrs now implement defaults, min, max, scalar,
> choices, etc. As en example dgpu_disable becomes:
> 
> /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> ├── current_value
> ├── display_name
> ├── possible_values
> └── type
> 
> as do other attributes.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   drivers/platform/x86/Kconfig               |  14 +
>   drivers/platform/x86/Makefile              |   1 +
>   drivers/platform/x86/asus-armoury.c        | 702 +++++++++++++++++++++
>   drivers/platform/x86/asus-armoury.h        | 209 ++++++
>   drivers/platform/x86/asus-wmi.c            |  69 +-
>   drivers/platform/x86/asus-wmi.h            |  14 +
>   include/linux/platform_data/x86/asus-wmi.h |  11 +
>   7 files changed, 1001 insertions(+), 19 deletions(-)
>   create mode 100644 drivers/platform/x86/asus-armoury.c
>   create mode 100644 drivers/platform/x86/asus-armoury.h

This is kinda a big patch that I feel might have done some justice to 
split into smaller logical pieces.  These are much easier to review.

For example:

1) You've clearly got 3 "groups" of attributes, maybe those should come 
in a separate series each.
2) Some of the helper functions that are exported should be exported in 
their own patches (for example asus_wmi_get_devstate_dsts)
3) panel_hd_mode is a new attribute not leveraged from asus-wmi AFAICT, 
with a new define.  It probably could have been it's own patch to "add 
panel_hd_mode".

More comments inline below.

> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ddfccc226751..d13c4085c228 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -265,6 +265,19 @@ config ASUS_WIRELESS
>   	  If you choose to compile this driver as a module the module will be
>   	  called asus-wireless.
>   
> +config ASUS_ARMOURY
> +	tristate "ASUS Armoury (firmware) Driver"

This is a confusing title to me.  What does it convey that just "Asus 
Armoury driver" wouldn't?

> +	depends on ACPI_WMI
> +	depends on ASUS_WMI
> +	select FW_ATTR_CLASS
> +	help
> +	  Say Y here if you have a WMI aware Asus laptop and would like to use the

Doesn't it also cover handhelds?  I'd probably just say "asus machine".

> +	  firmware_attributes API to control various settings typically exposed in
> +	  the ASUS Armoury Crate application available on Windows.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called asus-armoury.
> +
>   config ASUS_WMI
>   	tristate "ASUS WMI Driver"
>   	depends on ACPI_WMI
> @@ -276,6 +289,7 @@ config ASUS_WMI
>   	depends on HOTPLUG_PCI
>   	depends on ACPI_VIDEO || ACPI_VIDEO = n
>   	depends on SERIO_I8042 || SERIO_I8042 = n
> +	select ASUS_ARMOURY

Two problems:
1. Seems to be a circular depedency.
2. Selects can't have extra depends or selects (FW_ATTR_CLASS stands out).

I feel this select should just be droped.

>   	select INPUT_SPARSEKMAP
>   	select LEDS_CLASS
>   	select NEW_LEDS
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b142947067..fe3e7e7dede8 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
>   # ASUS
>   obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
>   obj-$(CONFIG_ASUS_WIRELESS)	+= asus-wireless.o
> +obj-$(CONFIG_ASUS_ARMOURY)	+= asus-armoury.o
>   obj-$(CONFIG_ASUS_WMI)		+= asus-wmi.o
>   obj-$(CONFIG_ASUS_NB_WMI)	+= asus-nb-wmi.o
>   obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> new file mode 100644
> index 000000000000..6e4507be0f05
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -0,0 +1,702 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Asus Armoury (WMI) attributes driver. This driver uses the fw_attributes
> + * class to expose the various WMI functions that many gaming and some
> + * non-gaming ASUS laptops have available.
> + * These typically don't fit anywhere else in the sysfs such as under LED class,
> + * hwmon or other, and are set in Windows using the ASUS Armoury Crate tool.
> + *
> + * Copyright(C) 2010 Intel Corporation.
> + * Copyright(C) 2024-2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/dmi.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/kmod.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/types.h>
> +
> +#include "asus-armoury.h"
> +#include "firmware_attributes_class.h"
> +#include "asus-wmi.h"
> +
> +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> +
> +#define ASUS_MINI_LED_MODE_MASK 0x03
> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF 0x00
> +#define ASUS_MINI_LED_ON 0x01
> +/* New mode on some devices, define here to clarify remapping later */

The word "new" ages poorly, especially in comments.

> +#define ASUS_MINI_LED_STRONG_MODE 0x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK 0x00
> +#define ASUS_MINI_LED_2024_STRONG 0x01
> +#define ASUS_MINI_LED_2024_OFF 0x02
> +
> +/* Default limits for tunables available on ASUS ROG laptops */
> +#define PPT_CPU_LIMIT_MIN 5
> +#define PPT_CPU_LIMIT_MAX 150
> +#define PPT_CPU_LIMIT_DEFAULT 80
> +#define PPT_PLATFORM_MIN 5
> +#define PPT_PLATFORM_MAX 100
> +#define PPT_PLATFORM_DEFAULT 80
> +#define NVIDIA_BOOST_MIN 5
> +#define NVIDIA_BOOST_MAX 25
> +#define NVIDIA_TEMP_MIN 75
> +#define NVIDIA_TEMP_MAX 87
> +
> +/* Tunables provided by ASUS for gaming laptops */
> +struct rog_tunables {
> +	u32 cpu_default;
> +	u32 cpu_min;
> +	u32 cpu_max;
> +
> +	u32 platform_default;
> +	u32 platform_min;
> +	u32 platform_max;
> +
> +	u32 ppt_pl1_spl; // cpu
> +	u32 ppt_pl2_sppt; // cpu
> +	u32 ppt_apu_sppt; // plat
> +	u32 ppt_platform_sppt; // plat
> +	u32 ppt_fppt; // cpu
> +
> +	u32 nv_boost_default;
> +	u32 nv_boost_min;
> +	u32 nv_boost_max;
> +	u32 nv_dynamic_boost;
> +
> +	u32 nv_temp_default;
> +	u32 nv_temp_min;
> +	u32 nv_temp_max;
> +	u32 nv_temp_target;
> +};
> +
> +static const struct class *fw_attr_class;
> +
> +struct asus_armoury_priv {
> +	struct device *fw_attr_dev;
> +	struct kset *fw_attr_kset;
> +
> +	struct rog_tunables *rog_tunables;
> +	u32 mini_led_dev_id;
> +	u32 gpu_mux_dev_id;
> +
> +	struct mutex mutex;
> +};
> +
> +static struct asus_armoury_priv asus_armoury = { .mutex = __MUTEX_INITIALIZER(
> +							 asus_armoury.mutex) };
> +
> +struct fw_attrs_group {
> +	bool pending_reboot;
> +};
> +
> +static struct fw_attrs_group fw_attrs = {
> +	.pending_reboot = false,
> +};
> +
> +struct asus_attr_group {
> +	const struct attribute_group *attr_group;
> +	u32 wmi_devid;
> +};
> +
> +static bool asus_wmi_is_present(u32 dev_id)
> +{
> +	u32 retval;
> +	int status;
> +
> +	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, &retval);
> +	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
> +
> +	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> +}
> +
> +static void asus_set_reboot_and_signal_event(void)
> +{
> +	fw_attrs.pending_reboot = true;
> +	kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
> +}
> +
> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
> +}
> +
> +static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
> +
> +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> +{
> +	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
> +	       !strcmp(attr->attr.name, "panel_hd_mode");
> +}
> +
> +/**
> + * attr_int_store() - Generic store function for use with most WMI functions.
> + * @kobj: Pointer to the driver object.
> + * @kobj_attribute: Pointer to the attribute calling this function.
> + * @buf: The buffer to read from, this is parsed to `int` type.
> + * @count:
> + * @min: Minimum accepted value. Below this returns -EINVAL.
> + * @max: Maximum accepted value. Above this returns -EINVAL.
> + * @store_value: Pointer to where the parsed value should be stored.
> + * @wmi_dev: The WMI function ID to use.
> + *
> + * The WMI functions available on most ASUS laptops return a 1 as "success", and
> + * a 0 as failed. However some functions can return n > 1 for additional errors.
> + * attr_int_store() currently treats all values which are not 1 as errors, ignoring
> + * the possible differences in WMI error returns.
> + *
> + * Returns: Either count, or an error.
> + */
> +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf,
> +			      size_t count, u32 min, u32 max, u32 *store_value, u32 wmi_dev)
> +{
> +	u32 result, value;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &value);
> +	if (err)
> +		return err;
> +
> +	if (value < min || value > max)
> +		return -EINVAL;
> +
> +	err = asus_wmi_set_devstate(wmi_dev, value, &result);
> +	if (err) {
> +		pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> +		return err;
> +	}
> +
> +	if (result != 1) {
> +		pr_err("Failed to set %s (result): 0x%x\n", attr->attr.name, result);
> +		return -EIO;
> +	}
> +
> +	if (store_value != NULL)
> +		*store_value = value;
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	if (asus_bios_requires_reboot(attr))
> +		asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +
> +/* Mini-LED mode **************************************************************/
> +static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
> +						struct kobj_attribute *attr, char *buf)
> +{
> +	u32 value;
> +	int err;
> +
> +	err = asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &value);
> +	if (err)
> +		return err;
> +
> +	value &= ASUS_MINI_LED_MODE_MASK;
> +
> +	/*
> +	 * Remap the mode values to match previous generation mini-LED. The last gen
> +	 * WMI 0 == off, while on this version WMI 2 == off (flipped).
> +	 */
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (value) {
> +		case ASUS_MINI_LED_2024_WEAK:
> +			value = ASUS_MINI_LED_ON;
> +			break;
> +		case ASUS_MINI_LED_2024_STRONG:
> +			value = ASUS_MINI_LED_STRONG_MODE;
> +			break;
> +		case ASUS_MINI_LED_2024_OFF:
> +			value = ASUS_MINI_LED_OFF;
> +			break;
> +		}
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", value);
> +}
> +
> +static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
> +						 struct kobj_attribute *attr, const char *buf,
> +						 size_t count)
> +{
> +	int result, err;
> +	u32 mode;
> +
> +	err = kstrtou32(buf, 10, &mode);
> +	if (err)
> +		return err;
> +
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
> +	    mode > ASUS_MINI_LED_ON)
> +		return -EINVAL;
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
> +	    mode > ASUS_MINI_LED_STRONG_MODE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Remap the mode values so expected behaviour is the same as the last
> +	 * generation of mini-LED with 0 == off, 1 == on.
> +	 */
> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (mode) {
> +		case ASUS_MINI_LED_OFF:
> +			mode = ASUS_MINI_LED_2024_OFF;
> +			break;
> +		case ASUS_MINI_LED_ON:
> +			mode = ASUS_MINI_LED_2024_WEAK;
> +			break;
> +		case ASUS_MINI_LED_STRONG_MODE:
> +			mode = ASUS_MINI_LED_2024_STRONG;
> +			break;
> +		}
> +	}
> +
> +	err = asus_wmi_set_devstate(asus_armoury.mini_led_dev_id, mode, &result);
> +	if (err) {
> +		pr_warn("Failed to set mini-LED: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result != 1) {
> +		pr_warn("Failed to set mini-LED mode (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	return count;
> +}
> +
> +static ssize_t mini_led_mode_possible_values_show(struct kobject *kobj,
> +						  struct kobj_attribute *attr, char *buf)
> +{
> +	switch (asus_armoury.mini_led_dev_id) {
> +	case ASUS_WMI_DEVID_MINI_LED_MODE:
> +		return sysfs_emit(buf, "0;1\n");
> +	case ASUS_WMI_DEVID_MINI_LED_MODE2:
> +		return sysfs_emit(buf, "0;1;2\n");
> +	}
> +
> +	return sysfs_emit(buf, "0\n");
> +}
> +
> +ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the mini-LED backlight mode");
> +
> +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
> +						struct kobj_attribute *attr, const char *buf,
> +						size_t count)
> +{
> +	int result, err;
> +	u32 optimus;
> +
> +	err = kstrtou32(buf, 10, &optimus);
> +	if (err)
> +		return err;
> +
> +	if (optimus > 1)
> +		return -EINVAL;
> +
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> +		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> +		if (err)
> +			return err;
> +		if (result && !optimus) {
> +			err = -ENODEV;
> +			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %02X %02X %d\n",
> +				result, optimus, err);
> +			return err;
> +		}
> +	}
> +
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> +		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> +		if (err)
> +			return err;
> +		if (result && !optimus) {
> +			err = -ENODEV;
> +			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled: %d\n",
> +				err);
> +			return err;
> +		}
> +	}
> +
> +	err = asus_wmi_set_devstate(asus_armoury.gpu_mux_dev_id, optimus, &result);
> +	if (err) {
> +		pr_err("Failed to set GPU MUX mode: %d\n", err);
> +		return err;
> +	}
> +	/* !1 is considered a fail by ASUS */
> +	if (result != 1) {
> +		pr_warn("Failed to set GPU MUX mode (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +	asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +WMI_SHOW_INT(gpu_mux_mode_current_value, "%d\n", asus_armoury.gpu_mux_dev_id);
> +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
> +
> +/*
> + * A user may be required to store the value twice, typical store first, then
> + * rescan PCI bus to activate power, then store a second time to save correctly.
> + * The reason for this is that an extra code path in the ACPI is enabled when
> + * the device and bus are powered.
> + */
> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> +						struct kobj_attribute *attr, const char *buf,
> +						size_t count)
> +{
> +	int result, err;
> +	u32 disable;
> +
> +	err = kstrtou32(buf, 10, &disable);
> +	if (err)
> +		return err;
> +
> +	if (disable > 1)
> +		return -EINVAL;
> +
> +	if (asus_armoury.gpu_mux_dev_id) {
> +		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
> +		if (err)
> +			return err;
> +		if (!result && disable) {
> +			err = -ENODEV;
> +			pr_warn("Can not disable dGPU when the MUX is in dGPU mode: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, disable, &result);
> +	if (err) {
> +		pr_warn("Failed to set dGPU disable: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result != 1) {
> +		pr_warn("Failed to set dGPU disable (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	return count;
> +}
> +WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
> +ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the dGPU");
> +
> +/* The ACPI call to enable the eGPU also disables the internal dGPU */
> +static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 enable;
> +
> +	err = kstrtou32(buf, 10, &enable);
> +	if (err)
> +		return err;
> +
> +	if (enable > 1)
> +		return -EINVAL;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, &result);
> +	if (err) {
> +		pr_warn("Failed to get eGPU connection status: %d\n", err);
> +		return err;
> +	}
> +
> +	if (asus_armoury.gpu_mux_dev_id) {
> +		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
> +		if (err) {
> +			pr_warn("Failed to get GPU MUX status: %d\n", result);
> +			return result;
> +		}
> +		if (!result && enable) {
> +			err = -ENODEV;
> +			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
> +	if (err) {
> +		pr_warn("Failed to set eGPU state: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result != 1) {
> +		pr_warn("Failed to set eGPU state (retval): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	return count;
> +}
> +WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
> +ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
> +
> +/* Simple attribute creation */
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
> +		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_SPPT, cpu_default,
> +		       cpu_min, cpu_max, 1, "Set the CPU fast package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_SPPT,
> +		       platform_default, platform_min, platform_max, 1,
> +		       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID_PPT_PLAT_SPPT,
> +		       platform_default, platform_min, platform_max, 1,
> +		       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_fppt, "ppt_fppt", ASUS_WMI_DEVID_PPT_FPPT, cpu_default, cpu_min,
> +		       cpu_max, 1, "Set the CPU slow package limit");

I go back and forth on the existence of tuning knobs for all these 
values.  As a tinkerer it's of course nice to see so many knobs.

However thinking about how this would be exposed to userspace and what 
users will drag for a "slider" for performance it's really confusing. 
Which knob is tuned?  What's different for CPU vs platform?  What's slow 
vs fast?

As a result, I think I would rather see these (specifically) relegated 
to debugfs attributes and instead export an ACPI platform profile.  The 
ACPI platform profile can then give users a clearer set of expectations; IE:

"power-saver", "balanced", "performance"

Bifurcating it this way will enable both audiences.  The people who want 
to drag a slider in a UI to save power or consume power can do so, and 
those that know what all these mean and want to spend more time 
tinkering can go to debugfs to do so.

But with this idea there would essentially be two sets of knobs that 
change the same thing.  So I think that if the debugfs knobs were tuned 
away from the defaults the platform profile needs to be reset to an error.

> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BOOST,
> +		       nv_boost_default, nv_boost_min, nv_boost_max, 1,
> +		       "Set the Nvidia dynamic boost limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
> +		       nv_temp_default, nv_boost_min, nv_temp_max, 1,
> +		       "Set the Nvidia max thermal limit");
> +
> +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
> +		       "Show the current mode of charging");
> +
> +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
> +		   "Set the boot POST sound");
> +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
> +		   "Set MCU powersaving mode");
> +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
> +		   "Set the panel refresh overdrive");
> +ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
> +		   "Set the panel HD mode to UHD<0> or FHD<1>");
> +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
> +		   "Show the eGPU connection status");
> +
> +/* If an attribute does not require any special case handling add it here */
> +static const struct asus_attr_group armoury_attr_groups[] = {
> +	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> +	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
> +	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> +
> +	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> +	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> +	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> +	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> +	{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> +	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> +	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +
> +	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> +	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> +	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> +	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
> +	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
> +};
> +
> +static int asus_fw_attr_add(void)
> +{
> +	int err;
> +
> +	err = fw_attributes_class_get(&fw_attr_class);
> +	if (err)
> +		goto fail_class_created;
> +
> +	asus_armoury.fw_attr_dev =
> +		device_create(fw_attr_class, NULL, MKDEV(0, 0), NULL, "%s", DRIVER_NAME);
> +
> +	if (IS_ERR(asus_armoury.fw_attr_dev)) {
> +		err = PTR_ERR(asus_armoury.fw_attr_dev);
> +		goto fail_class_created;
> +	}
> +
> +	asus_armoury.fw_attr_kset =
> +		kset_create_and_add("attributes", NULL, &asus_armoury.fw_attr_dev->kobj);
> +	if (!asus_armoury.fw_attr_dev) {
> +		err = -ENOMEM;
> +		pr_debug("Failed to create and add attributes\n");
> +		goto err_destroy_classdev;
> +	}
> +
> +	err = sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
> +	if (err) {
> +		pr_warn("Failed to create sysfs level attributes\n");
> +		goto fail_class_created;
> +	}
> +
> +	err = 0;
> +	asus_armoury.mini_led_dev_id = 0;
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE)) {
> +		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &mini_led_mode_attr_group);
> +	} else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2)) {
> +		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &mini_led_mode_attr_group);
> +	}
> +	if (err)
> +		pr_warn("Failed to create sysfs-group for mini_led\n");
> +
> +	err = 0;
> +	asus_armoury.gpu_mux_dev_id = 0;
> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX)) {
> +		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX;
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &gpu_mux_mode_attr_group);
> +	} else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO)) {
> +		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX_VIVO;
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 &gpu_mux_mode_attr_group);
> +	}
> +	if (err)
> +		pr_warn("Failed to create sysfs-group for gpu_mux\n");
> +
> +	for (int i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
> +		/* Do not show for the Ally devices as powersave is entirely unreliable on it */
> +		if (armoury_attr_groups[i].wmi_devid == ASUS_WMI_DEVID_MCU_POWERSAVE &&
> +		    dmi_check_system(asus_rog_ally_device))
> +			continue;
> +
> +		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> +			continue;
> +
> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +					 armoury_attr_groups[i].attr_group);
> +		if (err)
> +			pr_warn("Failed to create sysfs-group for %s\n",
> +				armoury_attr_groups[i].attr_group->name);
> +		else
> +			pr_debug("Created sysfs-group for %s\n",
> +				 armoury_attr_groups[i].attr_group->name);
> +	}
> +
> +	return 0;
> +
> +err_destroy_classdev:
> +	device_destroy(fw_attr_class, MKDEV(0, 0));
> +
> +fail_class_created:
> +	fw_attributes_class_put();
> +	return err;
> +}
> +
> +/* Init / exit ****************************************************************/
> +
> +/* Set up the min/max and defaults for ROG tunables */
> +static void init_rog_tunables(struct rog_tunables *rog)
> +{
> +	const char *product;
> +	u32 max_boost = NVIDIA_BOOST_MAX;
> +	u32 cpu_default = PPT_CPU_LIMIT_DEFAULT;
> +	u32 cpu_max = PPT_CPU_LIMIT_MAX;
> +	u32 platform_default = PPT_PLATFORM_DEFAULT;
> +	u32 platform_max = PPT_PLATFORM_MAX;
> +
> +	/*
> +	 * ASUS product_name contains everything required, e.g,
> +	 * "ROG Flow X16 GV601VV_GV601VV_00185149B"
> +	 */
> +	product = dmi_get_system_info(DMI_PRODUCT_NAME);
> +
> +	if (strstr(product, "GA402R")) {
> +		cpu_default = 125;
> +	} else if (strstr(product, "13QY")) {
> +		cpu_max = 250;
> +	} else if (strstr(product, "X13")) {
> +		cpu_max = 75;
> +		cpu_default = 50;
> +	} else if (strstr(product, "RC71") || strstr(product, "RC72")) {
> +		cpu_max = 50;
> +		cpu_default = 30;
> +	} else if (strstr(product, "G814") || strstr(product, "G614") ||
> +		   strstr(product, "G834") || strstr(product, "G634")) {
> +		cpu_max = 175;
> +	} else if (strstr(product, "GA402X") || strstr(product, "GA403") ||
> +		   strstr(product, "FA507N") || strstr(product, "FA507X") ||
> +		   strstr(product, "FA707N") || strstr(product, "FA707X")) {
> +		cpu_max = 90;
> +	}
> +
> +	if (strstr(product, "GZ301ZE"))
> +		max_boost = 5;
> +	else if (strstr(product, "FX507ZC4"))
> +		max_boost = 15;
> +	else if (strstr(product, "GU605"))
> +		max_boost = 20;
> +
> +	/* ensure defaults for tunables */
> +	rog->cpu_default = cpu_default;
> +	rog->cpu_min = PPT_CPU_LIMIT_MIN;
> +	rog->cpu_max = cpu_max;
> +
> +	rog->platform_default = platform_default;
> +	rog->platform_max = PPT_PLATFORM_MIN;
> +	rog->platform_max = platform_max;
> +
> +	rog->ppt_pl1_spl = cpu_default;
> +	rog->ppt_pl2_sppt = cpu_default;
> +	rog->ppt_apu_sppt = cpu_default;
> +
> +	rog->ppt_platform_sppt = platform_default;
> +	rog->ppt_fppt = cpu_default;
> +
> +	rog->nv_boost_default = NVIDIA_BOOST_MAX;
> +	rog->nv_boost_max = NVIDIA_BOOST_MIN;
> +	rog->nv_boost_max = max_boost;
> +	rog->nv_dynamic_boost = NVIDIA_BOOST_MIN;
> +
> +	rog->nv_temp_default = NVIDIA_TEMP_MAX;
> +	rog->nv_temp_max = NVIDIA_TEMP_MIN;
> +	rog->nv_temp_max = NVIDIA_TEMP_MAX;
> +	rog->nv_temp_target = NVIDIA_TEMP_MIN;
> +}
> +
> +static int __init asus_fw_init(void)
> +{
> +	int err;
> +
> +	fw_attrs.pending_reboot = false;
> +
> +	asus_armoury.rog_tunables = kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
> +	if (!asus_armoury.rog_tunables)
> +		return -ENOMEM;
> +
> +	init_rog_tunables(asus_armoury.rog_tunables);
> +
> +	err = asus_fw_attr_add();
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void __exit asus_fw_exit(void)
> +{
> +	mutex_lock(&asus_armoury.mutex);
> +
> +	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
> +	kset_unregister(asus_armoury.fw_attr_kset);
> +	device_destroy(fw_attr_class, MKDEV(0, 0));
> +	fw_attributes_class_put();
> +
> +	mutex_unlock(&asus_armoury.mutex);
> +}
> +
> +module_init(asus_fw_init);
> +module_exit(asus_fw_exit);
> +
> +MODULE_IMPORT_NS(ASUS_WMI);
> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> new file mode 100644
> index 000000000000..8bb75cf88305
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -0,0 +1,209 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using asus-armoury driver
> + *
> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#ifndef _ASUS_BIOSCFG_H_
> +#define _ASUS_BIOSCFG_H_
> +
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "asus-armoury"
> +
> +static ssize_t attr_int_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			      const char *buf, size_t count, u32 min, u32 max,
> +			      u32 *store_value, u32 wmi_dev);
> +
> +static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	return sysfs_emit(buf, "integer\n");
> +}
> +
> +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			      char *buf)
> +{
> +	return sysfs_emit(buf, "enumeration\n");
> +}
> +
> +#define __ASUS_ATTR_RO(_func, _name)                                  \
> +	{                                                             \
> +		.attr = { .name = __stringify(_name), .mode = 0444 }, \
> +		.show = _func##_##_name##_show,                       \
> +	}
> +
> +#define __ASUS_ATTR_RO_AS(_name, _show)                               \
> +	{                                                             \
> +		.attr = { .name = __stringify(_name), .mode = 0444 }, \
> +		.show = _show,                                        \
> +	}
> +
> +#define __ASUS_ATTR_RW(_func, _name) \
> +	__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
> +
> +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)                          \
> +	static ssize_t _attr##_store(struct kobject *kobj,                \
> +				     struct kobj_attribute *attr,         \
> +				     const char *buf, size_t count)       \
> +	{                                                                 \
> +		return attr_int_store(kobj, attr, buf, count, _min, _max, \
> +				      NULL, _wmi);                        \
> +	}
> +
> +#define WMI_SHOW_INT(_attr, _fmt, _wmi)                                     \
> +	static ssize_t _attr##_show(struct kobject *kobj,                   \
> +				    struct kobj_attribute *attr, char *buf) \
> +	{                                                                   \
> +		u32 result;                                                 \
> +		int err;                                                    \
> +		err = asus_wmi_get_devstate_dsts(_wmi, &result);            \
> +		if (err)                                                    \
> +			return err;                                         \
> +		return sysfs_emit(buf, _fmt,                                \
> +				  result & ~ASUS_WMI_DSTS_PRESENCE_BIT);    \
> +	}
> +
> +/* Create functions and attributes for use in other macros or on their own */
> +
> +#define __ATTR_CURRENT_INT_RO(_attr, _wmi)                          \
> +	WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
> +	static struct kobj_attribute attr_##_attr##_current_value = \
> +		__ASUS_ATTR_RO(_attr, current_value)
> +
> +#define __ATTR_CURRENT_INT_RW(_attr, _minv, _maxv, _wmi)            \
> +	__WMI_STORE_INT(_attr##_current_value, _minv, _maxv, _wmi); \
> +	WMI_SHOW_INT(_attr##_current_value, "%d\n", _wmi);          \
> +	static struct kobj_attribute attr_##_attr##_current_value = \
> +		__ASUS_ATTR_RW(_attr, current_value)
> +
> +/* Shows a formatted static variable */
> +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)                         \
> +	static ssize_t _attrname##_##_prop##_show(                            \
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> +	{                                                                     \
> +		return sysfs_emit(buf, _fmt, _val);                           \
> +	}                                                                     \
> +	static struct kobj_attribute attr_##_attrname##_##_prop =             \
> +		__ASUS_ATTR_RO(_attrname, _prop)
> +
> +/* Boolean style enumeration, base macro. Requires adding show/store */
> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible); \
> +	static struct kobj_attribute attr_##_attrname##_type =          \
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);                \
> +	static struct attribute *_attrname##_attrs[] = {                \
> +		&attr_##_attrname##_current_value.attr,                 \
> +		&attr_##_attrname##_display_name.attr,                  \
> +		&attr_##_attrname##_possible_values.attr,               \
> +		&attr_##_attrname##_type.attr, NULL                     \
> +	};                                                              \
> +	static const struct attribute_group _attrname##_attr_group = {  \
> +		.name = _fsname, .attrs = _attrname##_attrs             \
> +	}
> +
> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname) \
> +	__ATTR_CURRENT_INT_RW(_attrname, 0, 1, _wmi);           \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)           \
> +	static struct kobj_attribute attr_##_attrname##_current_value = \
> +		__ASUS_ATTR_RW(_attrname, current_value);               \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dispname) \
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                                \
> +	__ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)             \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);      \
> +	static struct kobj_attribute attr_##_attrname##_current_value =   \
> +		__ASUS_ATTR_RW(_attrname, current_value);                 \
> +	static struct kobj_attribute attr_##_attrname##_possible_values = \
> +		__ASUS_ATTR_RO(_attrname, possible_values);               \
> +	static struct kobj_attribute attr_##_attrname##_type =            \
> +		__ASUS_ATTR_RO_AS(type, enum_type_show);                  \
> +	static struct attribute *_attrname##_attrs[] = {                  \
> +		&attr_##_attrname##_current_value.attr,                   \
> +		&attr_##_attrname##_display_name.attr,                    \
> +		&attr_##_attrname##_possible_values.attr,                 \
> +		&attr_##_attrname##_type.attr, NULL                       \
> +	};                                                                \
> +	static const struct attribute_group _attrname##_attr_group = {    \
> +		.name = _fsname, .attrs = _attrname##_attrs               \
> +	}
> +
> +/*
> + * ROG PPT attributes need a little different in setup as they
> + * require rog_tunables members.
> + */
> +
> +#define __ROG_TUNABLE_RW(_attr, _min, _max, _wmi)                             \
> +	static ssize_t _attr##_current_value_store(                           \
> +		struct kobject *kobj, struct kobj_attribute *attr,            \
> +		const char *buf, size_t count)                                \
> +	{                                                                     \
> +		return attr_int_store(kobj, attr, buf, count,                 \
> +				      asus_armoury.rog_tunables->_min,        \
> +				      asus_armoury.rog_tunables->_max,        \
> +				      &asus_armoury.rog_tunables->_attr,      \
> +				      _wmi);                                  \
> +	}                                                                     \
> +	static ssize_t _attr##_current_value_show(                            \
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> +	{                                                                     \
> +		return sysfs_emit(buf, "%u\n",                                \
> +				  asus_armoury.rog_tunables->_attr);          \
> +	}                                                                     \
> +	static struct kobj_attribute attr_##_attr##_current_value =           \
> +		__ASUS_ATTR_RW(_attr, current_value)
> +
> +#define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)                            \
> +	static ssize_t _attrname##_##_prop##_show(                            \
> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf) \
> +	{                                                                     \
> +		return sysfs_emit(buf, "%d\n",                                \
> +				  asus_armoury.rog_tunables->_val);           \
> +	}                                                                     \
> +	static struct kobj_attribute attr_##_attrname##_##_prop =             \
> +		__ASUS_ATTR_RO(_attrname, _prop)
> +
> +#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _default, _min, _max, \
> +			       _incstep, _dispname)                            \
> +	__ROG_TUNABLE_SHOW(default_value, _attrname, _default);                \
> +	__ROG_TUNABLE_RW(_attrname, _min, _max, _wmi);                         \
> +	__ROG_TUNABLE_SHOW(min_value, _attrname, _min);                        \
> +	__ROG_TUNABLE_SHOW(max_value, _attrname, _max);                        \
> +	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", _incstep);        \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);           \
> +	static struct kobj_attribute attr_##_attrname##_type =                 \
> +		__ASUS_ATTR_RO_AS(type, int_type_show);                        \
> +	static struct attribute *_attrname##_attrs[] = {                       \
> +		&attr_##_attrname##_current_value.attr,                        \
> +		&attr_##_attrname##_default_value.attr,                        \
> +		&attr_##_attrname##_min_value.attr,                            \
> +		&attr_##_attrname##_max_value.attr,                            \
> +		&attr_##_attrname##_scalar_increment.attr,                     \
> +		&attr_##_attrname##_display_name.attr,                         \
> +		&attr_##_attrname##_type.attr,                                 \
> +		NULL                                                           \
> +	};                                                                     \
> +	static const struct attribute_group _attrname##_attr_group = {         \
> +		.name = _fsname, .attrs = _attrname##_attrs                    \
> +	}
> +
> +#endif /* _ASUS_BIOSCFG_H_ */
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 08861792bddd..d265ef0d7aba 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -152,20 +152,6 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>   
>   static int throttle_thermal_policy_write(struct asus_wmi *);
>   
> -static const struct dmi_system_id asus_ally_mcu_quirk[] = {
> -	{
> -		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> -		},
> -	},
> -	{
> -		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> -		},
> -	},
> -	{ },
> -};
> -
>   static bool ashs_present(void)
>   {
>   	int i = 0;
> @@ -386,7 +372,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
>   {
>   	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
>   }
> -EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
> +EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, ASUS_WMI);
>   
>   static int asus_wmi_evaluate_method5(u32 method_id,
>   		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
> @@ -550,12 +536,58 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
>   	return 0;
>   }
>   
> -static int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
> -				 u32 *retval)
> +/**
> + * asus_wmi_get_devstate_dsts() - Get the WMI function state.
> + * @dev_id: The WMI function to call.
> + * @retval: A pointer to where to store the value returned from WMI.
> + *
> + * The returned WMI function state can also be used to determine if the WMI
> + * function is supported by checking if the asus_wmi_get_devstate_dsts()
> + * returns an error.
> + *
> + * On success the return value is 0, and the retval is a valid value returned
> + * by the successful WMI function call. An error value is returned only if the
> + * WMI function failed, or if it returns "unsupported" which is typically a 0
> + * (no return, and no 'supported' bit set), or a 0xFFFFFFFE (~1) which if not
> + * caught here can result in unexpected behaviour later.
> + */
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +	int err;
> +
> +	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
> +	*retval &= ~ASUS_WMI_DSTS_PRESENCE_BIT;

Shouldn't you only update this if no error?  IE move to the end of the 
function before return 0.

> +
> +	if (err)
> +		return err;
> +	/* Be explicit about retval */
> +	if (*retval == ASUS_WMI_UNSUPPORTED_METHOD)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, ASUS_WMI);
> +
> +/**
> + * asus_wmi_set_devstate() - Set the WMI function state.
> + * @dev_id: The WMI function to call.
> + * @ctrl_param: The argument to be used for this WMI function.
> + * @retval: A pointer to where to store the value returned from WMI.
> + *
> + * The returned WMI function state if not checked here for error as
> + * asus_wmi_set_devstate() is not called unless first paired with a call to
> + * asus_wmi_get_devstate_dsts() to check that the WMI function is supported.
> + *
> + * On success the return value is 0, and the retval is a valid value returned
> + * by the successful WMI function call. An error value is returned only if the
> + * WMI function failed.
> + */
> +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
>   {
>   	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
>   					ctrl_param, retval);
>   }
> +EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, ASUS_WMI);
>   
>   /* Helper for special devices with magic return codes */
>   static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
> @@ -4774,8 +4806,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>   	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
>   	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>   	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
> -	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
> -						&& dmi_check_system(asus_ally_mcu_quirk);
> +	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE);
>   
>   	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
>   		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index d02f15fd3482..c66e970b3674 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -86,4 +86,18 @@ struct asus_wmi_driver {
>   int asus_wmi_register_driver(struct asus_wmi_driver *driver);
>   void asus_wmi_unregister_driver(struct asus_wmi_driver *driver);
>   
> +static const struct dmi_system_id asus_rog_ally_device[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> +		},
> +	},
> +	{ },
> +};
> +
>   #endif /* !_ASUS_WMI_H_ */
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 365e119bebaa..7caf2c7ed8c9 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -73,6 +73,7 @@
>   #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
>   
>   /* Misc */
> +#define ASUS_WMI_DEVID_PANEL_HD		0x0005001C
>   #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
>   #define ASUS_WMI_DEVID_CAMERA		0x00060013
>   #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
> @@ -158,8 +159,18 @@
>   #define ASUS_WMI_DSTS_LIGHTBAR_MASK	0x0000000F
>   
>   #if IS_REACHABLE(CONFIG_ASUS_WMI)
> +int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
> +int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
>   int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
>   #else
> +static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
> +{
> +	return -ENODEV;
> +}
> +static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
> +{
> +	return -ENODEV;
> +}
>   static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
>   					   u32 *retval)
>   {


