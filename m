Return-Path: <linux-kernel+bounces-398351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C279BEFF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C291F2350E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CF61F8184;
	Wed,  6 Nov 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4BeCbMV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B531DE4CA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902651; cv=fail; b=PDiFSIDCtMQtP0Sq4zfrsdqCZq3a0ZmxLWVVnD53oc0lMoX6EI838Sf0wyE/2GCZy2zGi4CpnAYz5vPU4l66wdI/eMsjt+nWmNy90NFgp4NMnAKDd9TUPH7DP2whCJcdcqlSQFluBDPVpOGsaSch7iuVYxnV93TdA7L96zbO15o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902651; c=relaxed/simple;
	bh=QIrFCdJaicY0Fq+hAVjTv/5TzdMCFpGUTq4A/ibS8Pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih04B/Cn0g+MhiSK3eMiIXvHuBxCSNNWYiNxbbToOvo3/ObVSqBdxB0p7SK47xI7lcINIBcbkviKcKukYxK3euHQV61WvlYKNA2xjqIkmZKg9fBPHVg00oe+ATu7zKhsusqIqavgdbU/GjzdGMwy7EoFOxFJoYlaY0cEzDOxMXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4BeCbMV; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJERMDSYNU2kqvDo/1CFLr46u78KFkS4h3/DY+CapduOQz0mUQi7IXRbm1uBSMJYkPb9adlRKqyLBXis/zSXtIi+IfvWuMs8I/1ajtRxJfhjhwApKQmn4ePu+2MQe+qfldfolloj9JoEZZIl7KRPiTLTxd2DaEGI9BwxPFfZcbIpH/2DHsZi0VsrDzpttzTreNyS9RGiS1Hx+cFuPoeuj0SMVQ/W2dGAvpUh9x0/2+APFJN1ocNmo029EGmgRQLEUXrf6VSF/SgIX4NDwV+EKiW5MK5/GQMSbVmKDWh0Knaj49ZWcjkMdb+LGQrG6O82IYH+mF++gwuXD3gyZ1rWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJUU4OLB+ngOu79lhi0a2d0EWSO0HGvMcYbO6SK7thI=;
 b=hS173OHq67fBLQh4K6cpzdne6r61UVk0TshCIEfMLEftlY9cc2RXZHamVi7LG3Mlmrtmzw62xIykxeT0jBD2RKjFwBpkm/6epFkS+QlpBZtbv3DcW8Me+lXPJjUZhj2krV1Je0Pu7q8SgXSTI0st84zapQ/PWr0Rnb/eXrWyXFE8FNrrqFIMLBlFRAJCr5B2kNOl4N7v+JHAK/zCBJmvJk6PXDfrU6ZIW1zTGuKoP/ZDxZSR+WMm1Q3YAIxJ1zkCDky6AUDZz5Z+/vrzVnQniIK4DDs2t9pEtvYag1G6ms1cYgVjrgDeDRAxVbnbvhAamo8LL8ujbO4ljJP07xC/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJUU4OLB+ngOu79lhi0a2d0EWSO0HGvMcYbO6SK7thI=;
 b=W4BeCbMV+qKywIw4uZVfl0XCjIbId6ytuwTj6ue9AczfmSsze2aMFQMdK3xVsE0jzHlf1pxICuFHLJ8xoohi6DnK9dwSOaWA5DjX9lIn85oAkpA3ipj82dj5Kzs0LH7iUGqKXt6Z0dm1xE5X5ccN+Fqknf0Wxl4LEMzVIcsqvMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.32; Wed, 6 Nov
 2024 14:17:26 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:17:26 +0000
Message-ID: <9d8fdd74-5e82-47b2-ba7b-c33f791065fa@amd.com>
Date: Wed, 6 Nov 2024 19:47:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] i3c: master: Add support for SETAASA CCC
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <20241023055118.1400286-6-Shyam-sundar.S-k@amd.com>
 <583c5381-11fe-4fc0-83b4-512c2aae50bd@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <583c5381-11fe-4fc0-83b4-512c2aae50bd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ceafd9c-0e13-4312-4d24-08dcfe6dbd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJIb3pEV3N3WUNGVkxHaFIxQy84a1dwakNmQlcxR3VmTjhWcnZPcjN3MDhq?=
 =?utf-8?B?YUdyQUJwTGQ1SFM0S1N5c1l5TnFWU2R0Wk1xcEpHVkNGWmxIUmY0bHFTNUVh?=
 =?utf-8?B?Y2lNYTMyeUNWY29PMUFPUHp3QUNSMDFvdU1YdUlPWklHUnBKSGdUM0lVYnUz?=
 =?utf-8?B?K3dsK0F2dmlod255RWp2UDVKa1dZUmQxanFrWUVXeFA4ckxFN1VLRE5oVjVz?=
 =?utf-8?B?THBMWEx4SGNpcHV1RGxxNThVZ3Y1QW8rUXpGc0l1QmNQSjZuVkhvTmsraGNw?=
 =?utf-8?B?R042cUtjRkhJVEF6M05hejFBeCt4WCtCSEZPNHhDR2hPL2RsYWJycWNNcG9M?=
 =?utf-8?B?KzYxK2V4VnF5SWZXaGRGa21Tb2YxcGYvKy8wM1RkcDNpNXRMUGxYMFM4K3No?=
 =?utf-8?B?c1BhSVBkanlpRHZZRm1OaEM0QUhYS2tqaGVLd204UjI4TjdmYmtuNHdYOERS?=
 =?utf-8?B?cHJYaXFKTEZDK2RYSkw1RUdmdFZ4MlJtRFB5bTJxOGRwK3JiVlpOalJ6Zktk?=
 =?utf-8?B?MVorWFBxZkpsUjZuVnFuVWJHWWx6YWR0UGRpdTVVSDNJa3ozS0hlN1BWR1R2?=
 =?utf-8?B?Qk4yZUVKNld5ek9VemdKZlFBYlFoc3BDTUx6b05nUFhDVHRxYTFmbGxaL0Ur?=
 =?utf-8?B?QlBpem1Hc3A0VEFJdm1jTWJoS29iM1Z3eDkxdnBSQS9uWXZhdy8vdkdST2ov?=
 =?utf-8?B?Slg0RnB5emVTVnNmVGNZYjc2VnpXRUoxdkpFL1kzOWFlWEhBR3lMTzNFQW04?=
 =?utf-8?B?TGdjM0JIMVBxek95cVhNSUxyRWFkRmtpaEMxZ2gySUpMZ3gxS3B1ZW04VGZu?=
 =?utf-8?B?VnpjMjNmUUFodUVhdStFMTJURDF1eS9YUHdSditTem5CYmNEKytsaEJ1OUlT?=
 =?utf-8?B?TUtuWTdPcytiNythbnRIRk5NQlUzaG5TT2l4MTdySU1odmhxTTB3MWFvMGhL?=
 =?utf-8?B?U3JRS1FsVmxSdUIrMkhHejBiSnZBajNzQ2NOWVl5OE5zOVUydzlhclZSV1Uz?=
 =?utf-8?B?KzBnSDBjdEJaM2hMYyttVE5iVEFEUXVSQkVsL0ZXLzRIdkFRaEJWdXpQTk8z?=
 =?utf-8?B?cE9zUHBqVnhrdjRXVXB2YkVKUWQ1UHIxdEZjalVFODFiYlEwaVdLZTFuaDh2?=
 =?utf-8?B?TEYxOVVkQ2FVbFVMSUFOWjlxWVB1VFNtMEtRNWxXNm93bVZieWROYk9KRWJS?=
 =?utf-8?B?WUlQWjNDd1dhNjJMR1V5dU1WNFhHNG50WXdDMVV0K0hUaWFXRHNVWmNjbnNO?=
 =?utf-8?B?K1ExNDhVK0gybk1HNXVwM3cyak8vTnczdklwLzB2VUg3TUR5bktseFZweUNm?=
 =?utf-8?B?NW9uN1pwY0w0L28wcm9XSWtkc09KYTEyWFpTeThTNmt5QnRIQjdUZjh4eGZI?=
 =?utf-8?B?RjdTZUorVGxmbTloa1B1UWlIK0NPUyttZzIrYi82Z3RRVWdlenZKWWxyN0Ir?=
 =?utf-8?B?SE5VUUhsZlQyS0JrOUlNYWs0dWJQQUNrUDlwNWlKYWYzc3ZEMW53YnVIdC9E?=
 =?utf-8?B?MEtFV3k3NzRmU0JGRS9uMDBqS0YxVGw0NllsanJxaUdKaEp2MTV2WncvL2du?=
 =?utf-8?B?dEZOTzVuSk96NkwrQzFsOVRWQkpwNDBVZC9xeEtjVFZCWCs4KzFGcXFTbzdz?=
 =?utf-8?B?eEJza0NKOUErWkJuTm03UXJjSlM0ZDVzWWdNYUZCbityRXJMRzNjQWpyWWF0?=
 =?utf-8?Q?vmqG1myczbYQ5jp2Crws?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU96eWhuSUpyN3cxQ1JHNVpESGpJUXpIbXUxWWU4encwZ3p5M3pHWGJjNkY0?=
 =?utf-8?B?aVV2NTh5WlhBT2dEQXBrek1uMnJYNVd5YzVRZ0Q1OThKMEN6enVWMS9saDV2?=
 =?utf-8?B?cFEycDRJNlBhQWpwaVppbGhzZHU1UFg0MDhvNWlzSldrclQ3b2tmMlZHK0lP?=
 =?utf-8?B?UW5ydEJzbVROeVBGbUZPQzBLYlJHcGxCY1RXNTY5Q1VzY1pzbjlZdzNybHFG?=
 =?utf-8?B?S3FFVHlwRG5HMzFGRVVrWnNSOHVOZlRiVGRuaENwVVh3eTVyWDRZL2YxSWdw?=
 =?utf-8?B?WEVkSUJoWW1pSDZyNGg5andaTXp0d2lnak9RdDRJQ2dnWUhVai9LY1pad3ZE?=
 =?utf-8?B?MmI3QkpueGFRYWRGeEdLY0tqY1VpNUIxYWplNHNyT3JMUnBtU1ZhbGl5YW5C?=
 =?utf-8?B?OVkyM0V2SHZEdjJsalNObklremVQNEJZSjI0WGdmNE0vYi94dFBkUTF2dVU3?=
 =?utf-8?B?dk1QNWdjUXMwamIvcDJibWpURm15dFZVdnFVVGcrS3orZE15MCtUdDdWVFI3?=
 =?utf-8?B?OEs5V1BkQlg1UytzQkhrWnUxc0ovYnEyYVdMZWJyNmplRlJ2YzhPd1FZMTZS?=
 =?utf-8?B?VXdrMDUrcW5UVFZlWldsdStkY1hSV0VVaEwzeXFXSXlRL3dydGQwR2ZmQ2tY?=
 =?utf-8?B?MjE1dHFVLzkxU0JiazM5L1Rma2hzOU1hSFFjbG5VeFFBN1k5cE1FRVhjdmRY?=
 =?utf-8?B?WkVnVjhNS0FDckl4bTRuMW1XZWkxOEUxK2cyam5Cdk9pSk9SV2kwc0xIY2w4?=
 =?utf-8?B?VEtzUEZsV1dXYkZUQUsrZE1WencyT2w5WlFEZnQvREpBSWsybmhlZ1J6RGhT?=
 =?utf-8?B?d2tWM2MvQ1JLWkVQTVpmY1dMUDJXN0JVYUwrVWZZbUs2MlFRdU44QjBmRWlZ?=
 =?utf-8?B?V0dIQ3lyVEgzMXFyVVdPY01zSjJ4N1VLN1kwY1loS2hyV0VRalRyWXRDUUpB?=
 =?utf-8?B?amZIU3YxRmFjU2RScG5vR24wMmZpVEVHQTBEbStoWUNaNW8xUFhPOFhPSEEx?=
 =?utf-8?B?V3o2blAvWkcwZENnVERSeGhzM3JMT1duc0l3aGJhcWc2cW9hUjZBK0tONjRJ?=
 =?utf-8?B?ZTQxeUhxTld4eTUycjF1Vk5Sbk9wMzZNR2sxRzI2aUhZWTQ0Q3ljbzZScFFC?=
 =?utf-8?B?dzl3Wnh2NkM3TktwYW5qbjZsZjExekhzbWdyYTk3UXNSZWEyUktDZGVHZzZC?=
 =?utf-8?B?bmd2c0RNK0M4emlQTDl6NnpnUCtWOFNrNWtvY1NJSDBrNzR1WVB5Qnp4Wksz?=
 =?utf-8?B?REZ4SXgvR2pCcUZrdFZJRVRpVDZmUVZsb2xpamZrNTF1bEFWN1dsNGNLVHFm?=
 =?utf-8?B?Qzd6UFlUK3RtNjI3bWZsdElyK2lNSHd5N3V1SmFEUTQxYmJOVDZaUUZmb1JE?=
 =?utf-8?B?aDdlSUxyUzc3N1cycThuQkRpSmNsUEpzYlRrRDc4b1doTnBYejZvK1Y2SVBM?=
 =?utf-8?B?Y1VQTGxzeXQvRTVGRUlyRkMvdDVud20zNFpPdXVzS3JTeFlncWNSN0Z4MUQw?=
 =?utf-8?B?MUdPR1c1dUhiT3Rpcm9ZTHRHczkzUDluSFllMjlyZzY5cmJWeWYzRjNweEFY?=
 =?utf-8?B?bis5ZE5nTENhUnMyUEoxVDRKL05IM3BlNEtwQURNL3M0WG5neHZxcHRUZDdi?=
 =?utf-8?B?eFhsMElEWGJOME9pcElQZVl2Nzh2Zm1BSXc4N2dWS3JWbXhaRkdML0ZCWEw5?=
 =?utf-8?B?Qm1uaWJCWlovSFZYdzNnRVFtU2hqMkpRZ3Q4K3EvTmpEYmFmZ21EeGMraUt0?=
 =?utf-8?B?VmJ1OFMvd3VreHRwSTNsNHM0Ly9IZHdUMkhpYnhZeUxXUGpheVYxZ2pHMEZy?=
 =?utf-8?B?V2cyMU9BeVlGTlQ4Ky9yYitIYXVpbGxwa3J6WVlhTEo4TXdKVlhMUEVRY29n?=
 =?utf-8?B?djBtTW5BVDdwdzdWQzdiaXAyU3c1RGRxaVoxakNQdXV4NkNPOW51THNGNlJT?=
 =?utf-8?B?OWRZMFU4QXFkUlpyYmM1SDUyRExkY3Nqc1J3R09YRTdTd3lrclV1Rmk0RWNC?=
 =?utf-8?B?Rk1YOTArRXRXMGduaTJoTHpKNUhrL3BOYlpWbTZuV2UyTlRXaXoycDBMei9C?=
 =?utf-8?B?cE1Fc0lZcThWNVdtQUNxQkR0V0U3ZVQ0aHFianFZVytCWFdUQXlHbjkyVHBN?=
 =?utf-8?Q?LE5nwGzA268cNU4b9w2naj7kk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceafd9c-0e13-4312-4d24-08dcfe6dbd58
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:17:26.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61j8JdMDfkkUsv5MLD3IUGzn37U/gDkUgC0ZMFv2IesIUzfTB9h2MHvXH7+dFiqMgin9AB3XUhz7Valkm09/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937



On 11/4/2024 20:30, Jarkko Nikula wrote:
> On 10/23/24 8:51 AM, Shyam Sundar S K wrote:
>> I3C devices like DIMMs over SPD use SETAASA for bus discovery
>> instead of
>> SETDASA. Add a new routine for I3C host controller drivers to use.
>> If the
>> I3C slave on the bus is an SPD device, skip the regular DAA process.
>>
>> According to the SPD spec[1], use SETAASA for bus discovery, and avoid
>> sending RSTDAA and DISEC, as they are considered illegal. Skip this
>> entire
>> process if the slave is SPD-compliant, as indicated by the
>> "jdec_spd" flag
>> from the BIOS.
>>
>> [1] https://www.jedec.org/system/files/docs/JESD300-5B.01.pdf
>> (section 2.4 and 2.6.3)
>>
> SETAASA seems to come in MIPI v1.1.1 specification. I think worth to
> mention in commit log.
> 

OK. I will do it in the next version.

>> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/i3c/master.c               | 32
>> +++++++++++++++++++++++++++++-
>>   drivers/i3c/master/dw-i3c-master.c |  1 +
>>   include/linux/i3c/ccc.h            |  1 +
>>   include/linux/i3c/master.h         |  1 +
>>   4 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>> index ba6f17cb8aa6..1596efd6d82a 100644
>> --- a/drivers/i3c/master.c
>> +++ b/drivers/i3c/master.c
>> @@ -1657,6 +1657,21 @@ i3c_master_register_new_i3c_devs(struct
>> i3c_master_controller *master)
>>       }
>>   }
>>   +static int i3c_master_setaasa_locked(struct i3c_master_controller
>> *master)
>> +{
>> +    struct i3c_ccc_cmd_dest dest;
>> +    struct i3c_ccc_cmd cmd;
>> +    int ret;
>> +
>> +    i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR, 0);
>> +    i3c_ccc_cmd_init(&cmd, false, I3C_CCC_SETAASA, &dest, 1);
>> +
>> +    ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
>> +    i3c_ccc_cmd_dest_cleanup(&dest);
>> +
>> +    return ret;
>> +}
>> +
>>   static int i3c_master_add_spd_dev(struct i3c_master_controller
>> *master,
>>                     struct i3c_dev_boardinfo *boardinfo)
>>   {
>> @@ -1684,6 +1699,10 @@ static int i3c_master_add_spd_dev(struct
>> i3c_master_controller *master,
>>           i3cdev->info.pid = i3cdev->boardinfo->pid;
>>           i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
>>   +        ret = i3c_master_setaasa_locked(master);
>> +        if (ret)
>> +            goto err_free_dev;
>> +
>>           i3c_bus_normaluse_lock(&master->bus);
>>           i3c_master_register_new_i3c_devs(master);
>>           i3c_bus_normaluse_unlock(&master->bus);
>> @@ -1907,7 +1926,14 @@ static int i3c_master_bus_init(struct
>> i3c_master_controller *master)
>>           goto err_bus_cleanup;
>>       }
>>   -    i3c_master_add_spd_dev(master, i3cboardinfo);
>> +    /*
>> +     * If the I3C slave on the bus is SPD device, then do not
>> follow the regular
>> +     * DAA process. Also, as per SPD spec SETAASA is required for
>> the bus discovery
>> +     * and sending RSTDAA and DISEC is considered as illegal. So
>> skip the entire process
>> +     * if the jdec_spd flag has been identified from the BIOS.
>> +     */
>> +    if (master->jdec_spd)
>> +        return i3c_master_add_spd_dev(master, i3cboardinfo);
>>         if (master->ops->set_speed) {
>>           ret = master->ops->set_speed(master,
>> I3C_OPEN_DRAIN_SLOW_SPEED);
>> @@ -2311,6 +2337,10 @@ static int i3c_acpi_configure_master(struct
>> i3c_master_controller *master)
>>           return -ENODEV;
>>       }
>>   +    status = acpi_evaluate_object(master->ahandle, "_STR", NULL,
>> NULL);
>> +    if (ACPI_SUCCESS(status))
>> +        master->jdec_spd = true;
>> +
> 
> Am I right "_STR" object should carry a string "jdec_spd"? But this
> code is not actually checking it, only the existence of _STR?
> 

I don't think so.. its just the string SPD/DIMM.

Scope (\_SB.I3CA)
{
	Name (_STR, Unicode ("SPD/DIMM"))  // _STR: Description String
	Name (_DSD, Package (0x04)  // _DSD: Device-Specific Data
	{
		...
	})
	Name (MST0, Package (0x02)
	{
		...
	})
	Device (SPD0)
	{
		...
	}

	Device (PMI0)
	{
		...
	}

	Device (RCD0)
	{
		...
	}
}

Thanks,
Shyam

>>       num_dev = device_get_child_node_count(dev);
>>       if (!num_dev) {
>>           dev_err(&master->dev, "Error: no child node present\n");
>> diff --git a/drivers/i3c/master/dw-i3c-master.c
>> b/drivers/i3c/master/dw-i3c-master.c
>> index f683e2a398ad..90a43209e55e 100644
>> --- a/drivers/i3c/master/dw-i3c-master.c
>> +++ b/drivers/i3c/master/dw-i3c-master.c
>> @@ -282,6 +282,7 @@ static bool
>> dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
>>       case I3C_CCC_GETSTATUS:
>>       case I3C_CCC_GETMXDS:
>>       case I3C_CCC_GETHDRCAP:
>> +    case I3C_CCC_SETAASA:
>>           return true;
>>       default:
>>           return false;
>> diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
>> index ad59a4ae60d1..a145d766ab6f 100644
>> --- a/include/linux/i3c/ccc.h
>> +++ b/include/linux/i3c/ccc.h
>> @@ -32,6 +32,7 @@
>>   #define I3C_CCC_DEFSLVS            I3C_CCC_ID(0x8, true)
>>   #define I3C_CCC_ENTTM            I3C_CCC_ID(0xb, true)
>>   #define I3C_CCC_ENTHDR(x)        I3C_CCC_ID(0x20 + (x), true)
>> +#define I3C_CCC_SETAASA            I3C_CCC_ID(0x29, true)
>>     /* Unicast-only commands */
>>   #define I3C_CCC_SETDASA            I3C_CCC_ID(0x7, false)
>> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
>> index 367faf7c4bf3..cd8390d8b469 100644
>> --- a/include/linux/i3c/master.h
>> +++ b/include/linux/i3c/master.h
>> @@ -516,6 +516,7 @@ struct i3c_master_controller {
>>       const struct i3c_master_controller_ops *ops;
>>       unsigned int secondary : 1;
>>       unsigned int init_done : 1;
>> +    unsigned int jdec_spd : 1;
>>       unsigned int hotjoin: 1;
>>       struct {
>>           struct list_head i3c;
> 

