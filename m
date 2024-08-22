Return-Path: <linux-kernel+bounces-296400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB40E95AA94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518121F23308
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE68179AE;
	Thu, 22 Aug 2024 01:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Dxd9hdX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46E225A8;
	Thu, 22 Aug 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290311; cv=fail; b=KmAFt5Ztk5+nQg/8im9NJIY49NJypfnuZO7U1XNudN6+BDQ/QcIBp7r8yxewBxnWQq84HLurdSVN8F18luSR9sK3ctMfTpx5N7mO7V+tqjVqzzPu7T9i0OOk7PBJhgqi1/CnnIqDUOkYsSuC7HhPygDewyfW7D4ZdtaqWl8onFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290311; c=relaxed/simple;
	bh=ECX8QrHvFyqpVE/H3W6eshcQo2cXkHFJ57YbIiqNX2k=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6iyBDTbtgTaSe4rZnBxzcXZ9AXjsIe2WVy9LEV72xRDx2kPaCfu9F+y7kD+8nnYpD09M9AIwZAsqvhDD3eUOtA63DffgJz0nQ/QwdcaFLH18Zz4Aj7h5smZDagzpSsZccyGej+XdZfAX1rRVdQc0quHZNOE5H2gkR3ZaljJNs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Dxd9hdX; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAQnKAD6LnMz71LCrrfIU95rwshPZKgeAYBbgyIUJHP9iRZyYOD9v863oQRLgmAFMfEQEmPuf4YsWBSRiWmFS0U1XnBsgLvJBqdnEFLGo7PoWdKqkPH5A26vehXJhUXIUfozl5brIkgPCy5pDZLFnuenSie0+J11+L5jIByjhrMWmunkQzx09sw0xbleZDeEReCvAR1vtcXRmuDH6B2VWze8B/C30Gdg/s2BXM0lsvTuiqF4440VKmOshpOYbAzBgszuaD29EZB+KDyCCioCrpkvPk4loovOTtaRk+KNkZ3h1fOY4/7g7kPcpxjVDMnUj87IsymN7qT2p+8qrv17NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkw7dN0eWNkOykC7Jlnw8oC2iE/SOZ4/PJiijGCRD5M=;
 b=L7okNhqDabwZrZvXaTzfvwIUjfdKYSwJk171/QKwZE5bqsmZl+yM7t53HeOYrRxyp0XLQk7q+WEIdb5rhCXcwn+Wxrk9vq0yAf/Y3OXxbX/h5HBeScAD02RU5fZG/jI4lRIQhh0xdCVjp29zRc4yW6nucfCLe3FtmKqAziGP4Y8sGVMoQNcnLgGWDcFWL97GxsoWNHqUJpM9uFAZaC18b45l8q06+JScXF0L6JzAsWCOKyS9YPNTFIpf7RLbDgoll1MXr7uz0xA4b0XvdS37/+d1Vz1JKzHi56SW2w7p0p10+vfr+dZ7JhEgq1Y0xEhhGTdJIDfVSaezrbyWq/A/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkw7dN0eWNkOykC7Jlnw8oC2iE/SOZ4/PJiijGCRD5M=;
 b=5Dxd9hdX7yGArQQi3/7R+5D8nJ8MPXyIAFLTBdf9ckzwUBfgtqGOGsxnpHMiPnDZerLSCwm8hTBSa2c5Z0Gn7/NYkAWz+a2RJgOGF2r9azg2eTmJ/HyQdCRZRzr06prUEbPRF02RvflC1biJnAlNhusS6h/8DV3JgpunaSjkiDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 01:31:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 01:31:45 +0000
Message-ID: <3223bd31-2112-0c5e-08d4-7e4942d031ec@amd.com>
Date: Wed, 21 Aug 2024 20:31:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 00/22] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <d093c0bc-dfd2-422a-9d23-2bde68dc6f73@intel.com>
Content-Language: en-US
In-Reply-To: <d093c0bc-dfd2-422a-9d23-2bde68dc6f73@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0009.namprd21.prod.outlook.com
 (2603:10b6:805:106::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c1d13-28f4-4b8d-296f-08dcc24a2f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFBtYXFIcXhCWHNrek81clpZL0tNcnRQdXd0aVdwV0YyeXQ2MWNUT3VSVGxE?=
 =?utf-8?B?RUhqS3pYV2ZwdlZlRlFESTJHWlRDR2hsdC9RTG1QVmRGbHFOa2g3ZU9meHNj?=
 =?utf-8?B?UTJsM252eGthUnBDMy9Zc2ZpaFBmWUdkdFVnZkRCaTNSeGE4em5ZaHlpRUx1?=
 =?utf-8?B?dzFJRzNiT0RhNGJ3N1FlaHZ1MzZibGZzeVdjREt2emxuU3lIWCthQU1rR0g3?=
 =?utf-8?B?czEwcVBySHM0K2FLdzRFN3Q2c0M1R0l0Uno3VTFXQ0I1S2FmSVU4VUVzY1Yx?=
 =?utf-8?B?ZTlOc3BUd3ZrT1htTXJjY0Fxbi9xRDNhc3RXSE9XUEU5eUdYc1dzcllXVFFk?=
 =?utf-8?B?dUtnWUc4SFFSTWI1UHhxN1dhclpxbWRnNVlqcWFtcG1XWkZlRTkyeGlkZWp0?=
 =?utf-8?B?RVdZK0NMblRPcDN5Z01zcGhIWVJReWRpbUZrNWl4cFh6STV5c1Z5SSs1ZDhF?=
 =?utf-8?B?cDUwL0VXUGU2RW1aeFVEck9hb09jZkUxdE0rTmdPc0ErOW1ScjZIUDFONmtB?=
 =?utf-8?B?K3puU3FrcHB5S0trZTI5YXgrSHA4UFRiWnNHajNSZ1FVZjBlazBnU1lHbEtM?=
 =?utf-8?B?ajJObVp0VGNoZ2hOb2dUc09RQUZnSmpHd1NId0dqWEFmMWxZUy9Na0QxWTJx?=
 =?utf-8?B?QkUwa0kzdnQweWFUaHplWGpXN0hQR1VOWWVIV3RqM3UrQlFBb0VvaldmSG1x?=
 =?utf-8?B?dXA5SGQyb1RUOHhVRzI1cTlPSk13T3Qrd2wyZDNFbk95RkpqNXFqS1NtRGZ6?=
 =?utf-8?B?OVRhUUZSMjhBS3RJS24xTVNWc2JuRWtPRExnbEt4UHpIUTVMVkJ4SnN3aC9D?=
 =?utf-8?B?MXdxSnYweld5MzJQaHVwc2VKcGNCdVllVkcvajB6OWptTE9yZEdkdW1OQzFU?=
 =?utf-8?B?S1BSZTdIZ1kwUEY2TVpiVnEwSTEyZ3NuUVkzclhYSWwxN3dVdkRWd1ZuWm1O?=
 =?utf-8?B?dDdPTDdhRWh5Ujh0bUgvTHhlRFlCdmhndGZSMTFYOWF5cWFVU0dMK2N4ZnVE?=
 =?utf-8?B?UC9JUU5QbEtEL2lQZC9scnJMSnM2Y1ZnV2pOVm8wZlNyRUFJSGN4ZjNvL2pn?=
 =?utf-8?B?Y2x3MldEWmtkYkw2Mnc5bTFHR3FobjFncUtTUmhOS0lvNmluZ3krUmY0RW5y?=
 =?utf-8?B?eDlmc08zczgwcVNLdU0vZHpJaEM5b0NQYXBGalkxWHN6MFdOWkNoekNHdjls?=
 =?utf-8?B?SU5FeDZiRWYzS3ArbEdhUWJ0OE1INkpEcnA1NGtOcWVMTndBQy8yUXZqM2VN?=
 =?utf-8?B?U0RkS2VJemhaSDdOb1o2SlpHYm9MUVNkQXhlTGc5ZXdEeDg2a04vU0dKQUx5?=
 =?utf-8?B?Qk9hQUdnNjFLK2I2T0Q1eWlBWUVzMWtHTG1TY05PUkFLMDJ4NUdBeXROa21Y?=
 =?utf-8?B?eDUyRjNTaWx0WGdPTXg2TWJ6SE95MUlES2p4cTZiL3ZSRUhwQ1g5SHNEbFNF?=
 =?utf-8?B?NUcxeEh0SjJMVXZ5dmt5eUFJSURBQjRmU3hxNENxTzdyaFFrMmZWSno5aUZE?=
 =?utf-8?B?T0FPZ2lsb3pVdEQ4QjdmVVUzeUs0UU54ZnV2dkRLL3pGeXhVc0xkUjViek5F?=
 =?utf-8?B?dkh5Yk50SGRIOTBwMkxTRWY3cTltYVRMbXZxSE5PSE9BT2JjazJ0SkVhcW53?=
 =?utf-8?B?TjgweWM3cHl2TmdLQkhJcFNxa0VhUDBzeG5Ycy8rajFRSEdRN0Uvbjg1dExm?=
 =?utf-8?B?dS82a2F1QzVUMGN5NHZjVmpPR2hYM2xsc0ppcHN0SkJybG56ZlBMNW1DanZG?=
 =?utf-8?B?ZFRZK3JXc0RTLzhhR1FFdEMvaEcxbE1jaTYzSjM3QS8yS2RWa3R5NnJkdVRa?=
 =?utf-8?Q?keyi8UzXJl8qBwSsylnNTwgyN8ys2L2Sbuduo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnV3VEtoQ29URExZcHpLKzYwa1dmYnFFQ1pVblpBcGdEL2FGa3o5ZWxhRFd6?=
 =?utf-8?B?SEcxNTFxUUppNE5saFlYL2VXK3NaUG1TK0pIRWYxb055ZzdzeCtWY2ZkTnAw?=
 =?utf-8?B?OU1yWTRUMGdsSmxDdXZOam91ak1pRFg2RUJzQ0hsZjA1OUJ2VTV2aXRWN04x?=
 =?utf-8?B?L3VLcytWbnRpZWVhSzlCRlF6ejFBeWl6SHp4SHZZdkhZZ1JrVCtTcnhDbDlF?=
 =?utf-8?B?WUY2eG56WkJkUFdyR2RHOHg3WGpsbjA0dUtVamR0NDRzaVpKS3ZSc21FMFcv?=
 =?utf-8?B?VllONVFBL2RlWFp3YXZHcjN4cloyWmM3enNQVGxZanJOODVEbHl2R3pra2lk?=
 =?utf-8?B?SnhsR1BqcjJNRnRvRmdSdzd6OGQ0ZG9zMU54b1Z2ZnZnVjNKTmdkekJtZkZX?=
 =?utf-8?B?SGNpczRUQWVPb3BOUE9POWJxWWVtZ3JQcXdvc3FZaVpzbzltOVBqWXR4RmRK?=
 =?utf-8?B?c1F3TjNHZzVDQUI3dytqNm9wNGhyNVNQTjg4d1UrUGRXUFBuSXZYMEl1WDB6?=
 =?utf-8?B?MWdsZUdvaTFoU0pYZnlJWjkwWVhpd2dxQkF4OU1xQ2piTVh6MzRqYm9KT3dQ?=
 =?utf-8?B?VGh4TlhYek5BWnVzMHBSbk0zdE54eTBjVFZzODNxSUNpNVpad3ZFTmE4anRP?=
 =?utf-8?B?b3drMHp1dXEwNjQ5OEhZRzB3SUM3MXVsMkZQczVOQ21Oa0pQMlZaMU5Ed1p0?=
 =?utf-8?B?YitjUlZGdENaMzl5SG0veWJyTDBSYTVvZTJEWC9nOElYN0Nob29GQ2RkZXRY?=
 =?utf-8?B?Y2tQNms1UEsyMHR3eWNycHVmT3pYZFZhSXN1UGhmdHJPTFhzTFJZeGE1TDd3?=
 =?utf-8?B?ZFlqWThjSjE4U0RJcXc0SzhzTFVnTmE0L29heHRuS2RweU9oRWo0Vyt1cXEx?=
 =?utf-8?B?WGdPdzZ5U2lFUExtamRQWVhyQVQvS3RGOFMxZmZwNi9RTXRrZWJSUmtrSTdu?=
 =?utf-8?B?SFVaMlpJZWtLNDV5RUx5cXduUTlFbG0wK2lMdUw2OGtsMTdaUi9BVnZWZkVR?=
 =?utf-8?B?QXBRQTdYQnc4NkRaOGVsajR4SjBxdXNkaU41enFSdHZDNDloSkpGV2FUb3Uz?=
 =?utf-8?B?Zjg5cHdJTjlMc0xkd1Z6T0hhUUQvNUFWaCtQQ3lwcjZGdk55djBsM2NXVVk3?=
 =?utf-8?B?K1FPQ0FvMmdUNHN2VFp2dVhSQzZhdnAzbFlzZUxKakFXQXRkTDZaV1MrV3Ev?=
 =?utf-8?B?UDRpT2w3bGc0R1VnU3Q0MlhTWXIzTWpYV2xLK0grZEhoSTB5eTBSTFhFdFB4?=
 =?utf-8?B?WVdKNTIySDFsR1pZSU45UzM2akdhaVFxRDJTMkhzZWFHeTMyaUdRN0l3QzJs?=
 =?utf-8?B?Um9wZ295dzZLbVJ4V0FDelNiM2JXbU15eWtjVjRlaU5yVnpkUDN5UXpRMGZI?=
 =?utf-8?B?V1d5YmphVWcvUndOMldoTHBNUXQ2QXNPVUpPdnZwNTNTd29RaFgwUXB0ckJN?=
 =?utf-8?B?d2lXVW9yRXpEckZkNG5NRitJSGNUQ1E5NWIwNWVEcW10MzRvVXllejIzQXJM?=
 =?utf-8?B?SldsaVBWVjBRS1ZUT0lqSXdVa0sxRDVXdS80dDhUQkI1dndrVHNVKzZrWVhq?=
 =?utf-8?B?YW5Wbmh3aVJaYXZmeFhVTHVGbDV3WTFsOEo3OHppcloyMVNDS1FpY3RWSlF4?=
 =?utf-8?B?TjJtT21lNjZqMXlSNDByL2ZwTVRTSkZoTmJWdWJJWXNrS3lxRnZSc3N3dWlm?=
 =?utf-8?B?MDBxTytvWWd4ZzN5Yk9TcEFMbzM0MXVzWUdoOGFWZUwwaTYwZE5FRXNMMHUr?=
 =?utf-8?B?US9JRE9EZXAxR2x3WlNVSjQ0WWc0SDI2RlY3N1ZCb2JRNnJGWVBTY0duclho?=
 =?utf-8?B?bHJsNGRMUzdjYkt4NXRMZkdVd0Q5Y25BYTJFNFI4MTU1MmRoWVBSVGhINU9H?=
 =?utf-8?B?cDhoSzdCS094T0h6VS93S2ZpUGtwdUpYMC81NjVOUm9hR0RBUkF5NDJSY2RF?=
 =?utf-8?B?eEhibytjN1BLaklJTnJEVEhJNXBNWk1jNGRXTjFCWUVZeDMrdjcyc0lZeWpz?=
 =?utf-8?B?aWNhQ3IzaVk3OTVmcUpKV2NaVEh4aFgyS0FiZ0JoWmlBQi9kNUtIUnJyMlMy?=
 =?utf-8?B?alNITlBvMTZiWGk0N1dVOE42Z2ttVDhybWNGZXFyaWorSkhYNkg5KzEzeVVU?=
 =?utf-8?B?NENhRjliTnZqVlNFT0ZMSkhWU1JOMFJGanhzVlptc25kU01sczZqUGd0VlhX?=
 =?utf-8?Q?TwUTbMSVcIsHEAmSXs95rBUuEgNHFmkYrVXSBdBHK1J5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c1d13-28f4-4b8d-296f-08dcc24a2f36
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:31:45.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+/eX1ezmtMKkOFiVpIWQv2X4niufU3nzWDPN6T+MP2dxjaC9q55TZYkVCL5Bggg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279

Hi Reinette,

On 8/16/24 16:28, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>>
>> Feature adds following interface files:
>>
>> /sys/fs/resctrl/info/L3_MON/mbm_mode: Reports the list of assignable
>> monitoring features supported. The enclosed brackets indicate which
>> feature is enabled.
> 
> I've been considering this file as a generic file where all future "MBM
> modes"
> can be captured, while this series treats it as specific to "assignable
> monitoring
> features" (btw, should this be "assignable monitoring modes" to match the
> name?).
> Looking closer at this implementation it does make things easier that
> "mbm_mode" is
> specific to "assignable monitoring features" but when doing so I think it
> should have
> a less generic name to avoid the obstacles we have with the existing
> "mon_features".
> Apologies that this goes back to be close to what you had earlier ... maybe
> "mbm_assign_mode"?

Lets see:
#cat /sys/fs/resctrl/info/L3_MON/mbm_mode
[mbm_cntr_assign]  <- This already says 'assign'. Isn't that enough?

default            <-  Default mode is not related assignable features.

I would think mbm_mode is fine. Let me know.

>>
>> /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs: Reports the number of monitoring
>> counters available for assignment.
>>
>> /sys/fs/resctrl/info/L3_MON/mbm_control: Reports the resctrl group and
>> monitor
>> status of each group. Assignment state can be updated by writing to the
>> interface.
>>
>> # Examples
>>
>> a. Check if ABMC support is available
>>     #mount -t resctrl resctrl /sys/fs/resctrl/
>>
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>     [mbm_cntr_assign]
>>     legacy
>>
>>     ABMC feature is detected and it is enabled.
>>
>> b. Check how many ABMC counters are available.
>>
>>     #cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>     32
>>
>> c. Create few resctrl groups.
>>
>>     # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>>     # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>>     # mkdir
>> /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>
>>
>> d. This series adds a new interface file
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>     to list and modify the group's monitoring states. File provides
>> single place
>>     to list monitoring states of all the resctrl groups. It makes it
>> easier for
>>     user space to learn about the counters are used without needing to
>> traverse
> 
> "to learn about the counters are used" -> "to learn the counters that are
> used" or
> "to learn about the used counters" or ...?

Sure.

> 
>>     all the groups thus reducing the number of file system calls.
>>
>>     The list follows the following format:
>>
>>     "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>>     Format for specific type of groups:
>>
>>     * Default CTRL_MON group:
>>      "//<domain_id>=<flags>"
>>
>>         * Non-default CTRL_MON group:
>>                 "<CTRL_MON group>//<domain_id>=<flags>"
>>
>>         * Child MON group of default CTRL_MON group:
>>                 "/<MON group>/<domain_id>=<flags>"
>>
>>         * Child MON group of non-default CTRL_MON group:
>>                 "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>>         Flags can be one of the following:
>>
>>          t  MBM total event is enabled.
>>          l  MBM local event is enabled.
>>          tl Both total and local MBM events are enabled.
>>          _  None of the MBM events are enabled
>>
>>     Examples:
>>
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>     
>>     There are four groups and all the groups have local and total
>>     event enabled on domain 0 and 1.
>>
>> e. Update the group assignment states using the interface file
>> /sys/fs/resctrl/info/L3_MON/mbm_control.
>>
>>       The write format is similar to the above list format with addition
>>     of opcode for the assignment operation.
>>          “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>>
>>     
>>     * Default CTRL_MON group:
>>             "//<domain_id><opcode><flags>"
>>     
>>     * Non-default CTRL_MON group:
>>             "<CTRL_MON group>//<domain_id><opcode><flags>"
>>     
>>     * Child MON group of default CTRL_MON group:
>>             "/<MON group>/<domain_id><opcode><flags>"
>>     
>>     * Child MON group of non-default CTRL_MON group:
>>             "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>     
>>     Opcode can be one of the following:
>>     
>>     = Update the assignment to match the flag.
>>     + Assign a new event.
>>     - Unassign a new event.
> 
> Since user space can provide more than one flag the text could be more
> accurate
> noting this. Eg. "Update the assignment to match the flag" -> "Update the
> assignment
> to match the flags.".

Sure.

> 
>>
>>     Flags can be one of the following:
>>
>>          t  MBM total event.
>>          l  MBM local event.
>>          tl Both total and local MBM events.
>>          _  None of the MBM events. Only works with '=' opcode.
> 
> Please take care with the implementation that seems to support a variety of
> combinations. If I understand correctly the implementation support flags
> like,
> for example, "tttt", "llll", "ltlt" ... those may not be an issue but of most
> concern is, for example, a pattern like "_lt" that (unexpectedly) appears to
> result in set of total and local.

Yes. Should we not allow flag combinations with "_"?
I am not very sure about how to go about this.

> 
>>     
>>     Initial group status:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>
>>     To update the default group to enable only total event on domain 0:
>>     # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=t;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>
>>     To update the MON group child_default_mon_grp to remove total event
>> on domain 1:
>>     # echo "/child_default_mon_grp/1-t" >
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=t;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>     To update the MON group
>> non_default_ctrl_mon_grp/child_non_default_mon_grp to
>>     remove both local and total events on domain 1:
>>     # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>>            /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>     //0=t;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>     To update the default group to add a local event domain 0.
>>     # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>     To update the non default CTRL_MON group non_default_ctrl_mon_grp to
>> unassign all
>>     the MBM events on all the domains.
>>     # echo "non_default_ctrl_mon_grp//*=_" >
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=_;1=_;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>
>> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>>     There is no change in reading the events with ABMC. If the event is
>> unassigned
>>     when reading, then the read will come back as "Unassigned".
>>     
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     779247936
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>     765207488
>>     
>> g. Check the bandwidth configuration for the group. Note that bandwidth
>>     configuration has a domain scope. Total event defaults to 0x7F (to
>>     count all the events) and local event defaults to 0x15 (to count all
>>     the local numa events). The event bitmap decoding is available at
>>     https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>>     in section "mbm_total_bytes_config", "mbm_local_bytes_config":
>>     
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x7f;1=0x7f
>>     
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>     0=0x15;1=0x15
>>     
>> h. Change the bandwidth source for domain 0 for the total event to count
>> only reads.
>>     Note that this change effects total events on the domain 0.
>>     
>>     #echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x33;1=0x7F
>>     
>> i. Now read the total event again. The first read will come back with
>> "Unavailable"
>>     status. The subsequent read of mbm_total_bytes will display only the
>> read events.
>>     
>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     Unavailable
>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     314101
>>
>> j. Users will have the option to go back to legacy mbm_mode if required.
>>     This can be done using the following command. Note that switching the
>>     mbm_mode will reset all the mbm counters of all resctrl groups.
> 
> "reset all the mbm counters" -> "reset all the MBM counters"

Sure.

> 
>>
>>     # echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>     mbm_cntr_assign
>>     [legacy]
>>
>>     
>> k. Unmount the resctrl
>>     
>>     #umount /sys/fs/resctrl/
>> ---
>> v6:
>>    We still need to finalize few interface details on mbm_mode and
>> mbm_control
>>    in case of ABMC and Soft-ABMC. We can continue the discussion with
>> this series.
> 
> Could you please list the details that need to be finalized?

1. mbm_mode display
    # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
      mbm_cntr_assign
      [legacy]

     "mbm_cntr_assign"
      Are we sticking with ""mbm_cntr_assign" for ABMC?
      What should we name for soft-ABMC?

2. Also we had some concerns about Individual event assignment(ABMC)
    and group assignment(soft-ABMC)?
    Are the flags "t" and 'l' good for both these modes?

> 
> Thank you
> 
> Reinette
> 

-- 
Thanks
Babu Moger

