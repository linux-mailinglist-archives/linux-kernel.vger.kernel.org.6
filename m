Return-Path: <linux-kernel+bounces-566916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D947A67E45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E26B426586
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070A20E700;
	Tue, 18 Mar 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WKSXtq1H"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3C1E834F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331047; cv=fail; b=HYU8uNldnd8JmsMtEQhNv8a0Y4FIh2zrrWmE2zGlMRsuztL+kN7kZrCyaWNk7WZW6qw3rfrf/+NKGMsluC37Sj0EaY70VRP6933WwxrWIGPffn5y5St7fNcOqa3ZL1e8g8gzMEQpWxry35q6i31OkuX1vLAYs3lDyC4EEb3/woc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331047; c=relaxed/simple;
	bh=tN+NhtIgY2aplszo23Cg1GqBwESecOXM33fRmDYbIcw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KRpkb/HSKvskmUaH2trkiczT+vz0ZD0tMMdnCG8jjUmY1N1GZ+GJKjzdW89hEaBsXNIHIXquy030Cmg/v84QivxfCiPxApq4+30X+eorCkaHsG0HG+sPvJeFXmsLXCOU3zz7tVYFzJc2n+33LkbHWMseCixcwPSIdZe2oITR0tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WKSXtq1H; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFcTjXFT6cSRtlfeBDuif2cmEX/vhaAoIhgD9zf44IcwluTUcMDJBjUDxHAE7xDJ4L+R9q5cXs7Zwd1hwhrNbF5v6Tc0CfUkL5IU7kWBZtAS/itom+vHzzL+rRUehaiapBD/Qs/gNiL3RWdRYIBZoriVpJCoHC4WVa4X21Na/R3990kZUS7MRTL/QaviMSlNSqulfESwg5mAZWyR1RI8sTUYVLT6C85KybG74Ww979TB1QltWE+dWxOnKhu8MEmi6QMYWApFrDWvkmxJnShYNbNEdZzedKhpgdJdbzVlWGQ0AyCT+oZMTaexTghe0FcPeIM2i5E2ybAFsC2PVtrw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCAuPtFfMELZsk/JsOeJJVhJhx23Bftvgd6gLieF9+k=;
 b=L84erGNwIrxL96ik1NpwLJuv+w+4KhMsAGG/fqS9D0ZvLeXZ88Vcb7zADnL697rDW08ImkbxLKxBXTLhseamYYlvd9B7Xtawsp09hENN18JcQmBEcbI/p4nv2YVya9TyaWRXvB91QcgN3vJ2PoX9WW5shnOlxwvuGi+EDjbMrWGPrUjyf48Zoq0zZjv4GwPjQKW5n0eOUAacIOcKjZCUicZukq0QnisFVpAP9yNlwgqmSGQh35GJIEfRhQqDlRUSBcyr6VR7R+xvdQUEt0Nh5KyLBcXP0lyRb8dUZEpxujSt2hQyDPXsmy02D1uF75oZonIZ0I3a7vXdVcEwZFWHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCAuPtFfMELZsk/JsOeJJVhJhx23Bftvgd6gLieF9+k=;
 b=WKSXtq1HhukeLuMnQbNoLTTKglmxTue/sWHUDWIvrRKVjII2ZA6gwr6p2fzwxJAkHlRFa3lnojx4LROK5cTJzVlBXTYHUSwrBj8y0RSxdtQgcQBoiapAuu/jFHE3fV1j10ER8ALJSQxl/55AUrd3/3jtbPkDaO6Ot60D8W7rUzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 20:50:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:50:43 +0000
Message-ID: <980f8828-1cf8-4ff2-a0d2-f6c9739a7dcc@amd.com>
Date: Tue, 18 Mar 2025 15:50:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
To: Mikhail Paulyshka <me@mixaill.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250312123130.8290-1-me@mixaill.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250312123130.8290-1-me@mixaill.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0125.namprd05.prod.outlook.com
 (2603:10b6:803:42::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: ec962763-6fcd-420e-79ba-08dd665e8ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VC9VYndwOUhqT243ZFZHOEdtTGl1a3BIYjBBeEFMWW1hdmZNQVI3bWFBL3h0?=
 =?utf-8?B?TWcybHlER25FRUJSbHl1RGducFRsYlFycnowZDR1eVhDdUpFTUZ5WUM4TEEy?=
 =?utf-8?B?S1RQOW1KaVd6RC9iYTUrcUNwZGFtOVRXMThRRE1FY1ZuWlhqQU9UdFFwS2kv?=
 =?utf-8?B?MXFWbXBvd2Q5c29kT1pKK3ZZQjI5OW1Fd04rYW5aZkI4c0czS1J1YS91MHd4?=
 =?utf-8?B?Qm5Ea2x0YmR3Tnh1bFlLZHRteXYwWU5Wcm5wdENrWVZsYmQxeVo1Y0VlcUg5?=
 =?utf-8?B?OE0rK3pQRXlXZURqZUpaNFl4bHBCM2FxTWpTY0lkVVk3VkJQUGlhU1M3VUx5?=
 =?utf-8?B?QmlPcCtkc2NDcnkrbG1pU3dJL2NxbHBFVytXOUdmVmo1ejA3TGJGWGV3Vmpm?=
 =?utf-8?B?bTVaU05URzZuZ3hMc2lHRUVpbTdQTG5CM3NpbnBIRVlZQ1RwbTVoVUpua0ls?=
 =?utf-8?B?bWpjN1RTb3JvZzB6Ni9BNjJnQzFCVEZ4S0J1NWlsQmhGcW11OUtYcFhEeEx5?=
 =?utf-8?B?endLbFZuT3dtSEY5azArdmVhbTZFeUxlUE0zWFVjRmw0RmtYUGdzcS8xTStG?=
 =?utf-8?B?ZFlBcWtrLy93SksvQUwrbUJldkJ1dmxidlBDekhiekFUM0dCMStQMURCM0VT?=
 =?utf-8?B?Um4rcGRWT0tXSUxvNkJ2aTJsbHhHSXNzYm9ncm9hYlAxZXRiamt0bGsrSURv?=
 =?utf-8?B?YzVjUnRnWFRmbTh2b2RVRE1JeWs4Tm5CeE5JbFdWLzlDUTR6UFVnUEJ2Wmg0?=
 =?utf-8?B?dzhpN1hQc3hnRm5FR3JDZWFrUXdsSWxmNHpLQm9qdzljb1pCV0o0Y2IzU1lq?=
 =?utf-8?B?WXQ0VHpFQjNFeHNjMHI1WTFZT2JJMHpNNjNkN1VRUUFnUnE5Zm9sWmJYUEdW?=
 =?utf-8?B?NmtZdWxGVjJYdFNQODRLMTJYdmpsUzJ3NmFXZUtXS1VFaVUvZDVqdEd1NnBm?=
 =?utf-8?B?c0N6dVExN1lDYk96eFczdjJtOXo1cngydndkUkx5TXlPb1NzK0MzM3Y2dU8w?=
 =?utf-8?B?SGtjYmlyaHBUODNYcFpRc0pibWZGeVhta3UyL2ttZkd0OFpZbFNVL2dlMDRj?=
 =?utf-8?B?NExtaVI4Nk1teFVBb3FWN2wycG9OZFVncEtMMGRSdjRaaDhVcXVrTnNFQVhq?=
 =?utf-8?B?WHFEUXdKMVA4cEQrNk5oVFhZME1CMjF2VHp2UWkrRXl3WnFxNk1uYUxHOTRk?=
 =?utf-8?B?TzRjbFYzZ0gvOVFmVjZodlRaMDRjdEpKNkpLTnlLNGdGSUVnYTBlTmUrdURz?=
 =?utf-8?B?TEdkZGhrc2NNQmM3WHB4TnVOdk9kMm9SbmxUNmpGczFPL3UvWEJqMnRJa1I1?=
 =?utf-8?B?T1c0R3FXLzlmQU5TTnZ2MVZMbDE2a0NsSC9YT0hvR0dpZmlrenBhK3UzMnEz?=
 =?utf-8?B?Z2V2VkM2MUpUenRBYkRNemFDUU56Q2toWVEybWhPN25oUDRrZzJKZEJ2VWJs?=
 =?utf-8?B?OGdXNkNpYnpoUjYyekJDY1drb3ZjVW9mcSs3ZUx6dE5tOGFSYktjeUJoMTkv?=
 =?utf-8?B?RmZkU1dwQ3h1WHlkTGRRQ1A2dVJCeFNXTkNxVDZTdXpyTzdFY0owMXF3Vm1s?=
 =?utf-8?B?SVhlREVMaUFqd3pmdnpQc1E4WE1ncDZIWGV2WHprNXZEKytlRS9xcGgycW5R?=
 =?utf-8?B?dzNGOGtVV2dteGtQaVZqRER0YVg4V01UaUFEMDJ4dXM5czIrbTBubG5HeGpD?=
 =?utf-8?B?UXh2R1JRNnFTN0YrMGhsSnNVYlV3eWpxeEEvcldPL2VocGpKcXFndjY4Zzdq?=
 =?utf-8?B?anhTd2V3akp6RTVkUW9vNHRqclpoUk1ObWNieXo0aHBvSFIwcUhsZUF1OWhQ?=
 =?utf-8?B?UVpBRmlEZDVidTRXVElRSWVST3ZWTU5OcWxIZG9OblMwbHpPbnBXU3Y4b2J3?=
 =?utf-8?Q?Zm7wKxcIQiIXv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1hwZ0VpZzZ3ay83dzZtUC9XYmpzNG9TY2ROMkk3VU0vNkN3RFZzK0Jmdi9V?=
 =?utf-8?B?Y0o2Y3BqSXFhSDhMN3hFeEF4dGNlbHpwSWNDT252OUxCU2hWNE9LL01yK2hS?=
 =?utf-8?B?TU5qSWd5QzlJOCtlTFZnc215Z29YSEFFdnNtTytTbUtoUGNtYnJUbHV0dktO?=
 =?utf-8?B?cnVLQlpxWCs2bVRzZ3pzMzRBY1drOVBBTUMxbGFVTVVxOXdqUHk5djZjcndJ?=
 =?utf-8?B?cnozUmVNZGZYTmMrTFJwVEhPRVoyV00xaFBVSTcrVW85V3BMckpLNWJGRjlZ?=
 =?utf-8?B?b1hXc2dBeFowRjI3a0Vlb3NrU2ZYMm9YdVA1S05sa1RTbXFLWkwxOFhEdjRZ?=
 =?utf-8?B?TnAvYTB1NmRmYWtKY0FMQWplYUZaeW83N21mbkZnUUF4aXRTTEorSmtqOUJt?=
 =?utf-8?B?emVZdm1zWTdtTUJzL3lLdHZOY2FBZGwrYmhmeWJZbW9ZL3M3UjBheG5hQUpy?=
 =?utf-8?B?ellXVkQwN2ZqOU1tbndiQjZaaGxrekZsTERFWUJqUlFLbG1ld21yaTlYc0o0?=
 =?utf-8?B?R3NCdHFHOTF4MEtnbUltejd3aEpHbE9GVnl3REJ3Vlg1Y1RkSkh1UnQrYWFu?=
 =?utf-8?B?ZnJYekRZVXlCUHNiQWhWUGQ5MS9Ed2k3Y1laeXI0VklSSlZ4U1JnZVdmOWxa?=
 =?utf-8?B?TGZwWWhmdzlCL2tjajBwbHkrNGp4ZUhCVFZFeDRkakhid1U0OHZ3TnZUVnJN?=
 =?utf-8?B?UVRPOENKT0szeXJ4YkFKaTluOG5Sb2ljbkhrREZ0MVEwWHZMaXFYRFREOTY4?=
 =?utf-8?B?NGdUeDhKQkN5NTZjRDFiQXdyUFBOY3Zwb2RnSENSbGtsTk1zUTVpUFRlWHRh?=
 =?utf-8?B?NnNzbVJMRG1mNFJtbGx0ZWxsV2tUVjRXZm5NcHlIbDE2ajlNM2hkWURFWlBC?=
 =?utf-8?B?UVZoek5Gb1NhNFJzN09xSFRSTDF3aUdHVTRrY3NheGhMcEdtTHpqRERmaUJK?=
 =?utf-8?B?cGlBaWk3Y2c0U0Y3Uk9rdGsySzV3d0g5TWVTTGI3VkpFWEFvR3IzdGxlTzk2?=
 =?utf-8?B?M0JaclBqM0ZGZi92S1dPLytqTSt0WkJGRm9CY3pMUmdEcm5uVExtNDdHZ2Yx?=
 =?utf-8?B?RU43RTlhSGpISDJRV0RlSlZ1MVY3ZXdLMEFJTC9sQlJBeFUwV1pQdndKOVRG?=
 =?utf-8?B?N0pPanYraXVYcE1pajlQdEc4UTc4dHJkZENqK0Vrd1QvWkFXbFRDK3gwT2Yy?=
 =?utf-8?B?SG9KSGU5NlhoNk4xNzVIbXVSRFJQUzc3b0JobEZEa1V1MlBiY09vWXQ5Y3ow?=
 =?utf-8?B?Nk5lVkZ2ano2ck51aVhEMjYwWEhYTCtDbjROaXdkYnRqcE1vU3pTcDNnUHhi?=
 =?utf-8?B?U3NNYkh3anBMOVdMTUxsUXpHQzB3Y3BFdGVDTVRlTTlRUVQ0RjhlSkEwdHQw?=
 =?utf-8?B?VnpwQ3YzdkFiRzlGTlcwNGd6SW5yRUpMMENWK0htYnBIeHVMSjcwbmNSM0lK?=
 =?utf-8?B?eEtQMmhLMkw3N0ZwR2tGa3VkdmZ3WCt6M1hhN0JCVWlUZXgvcU85MUFtL1ZO?=
 =?utf-8?B?dld4NFhNUGw0aWdYVU40cDdMZVFWREZNZzBEZW8rR2RXS0JjMEhPWnR1TGx2?=
 =?utf-8?B?NncvRXJreGtsRjRwVnFwZG1RdElxTFpQOUxoZStEV1VKOVVjbkpsY2VHRlZh?=
 =?utf-8?B?SnJKWHpybjlPQlNsVFVyTUgrb2VYbXhFTmVJZllONGdWUHI2b2lSN1NSY1N3?=
 =?utf-8?B?RFpHZnZhc0xoQXV5RkNhYUo4MkhSM3lWU3Z5cWZBVUVnRzJ6VFZjNURWTFJi?=
 =?utf-8?B?dDE1RkRua1BjYk0xQUF4UXRuTGJFV1FoaVd6K0FvbjlVOEJNUHdUWnpKZzBW?=
 =?utf-8?B?Rk1rRnFvNEIrZFk2TFRLeFQwNkpyM21qMC9xWGZxQm1wUmZsZHRHcWI4Y1NS?=
 =?utf-8?B?bTljS1puK2t6U2pTOHVGVlQ5NzR1ejcyWWtFWnZXUXFxL085MWwxZTB6SHZz?=
 =?utf-8?B?NGdRRDU5YkJLMlQwbUFUdVRuckE4aFAzMHovSEcvZlVyckNNZFNoaW9xWkJp?=
 =?utf-8?B?VktzMW9MNGNoU1hoK1Fzc3Mzenk4czhDRlRSVWMzTW1tZ2pOdC9yYjZjc1FE?=
 =?utf-8?B?dFVuZjNwci93ajZ5ckRodVJEeWxGN0ROVEJUb1A2cjFjRmJWb3g3cVJzTWdw?=
 =?utf-8?Q?H7WQcugkkYfLw6ApHLqiM9Pug?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec962763-6fcd-420e-79ba-08dd665e8ca3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 20:50:43.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7czrSF+EkQsTjzTc3q29IAV4EyY+vdBH9N+XMKKoyfR5qePV4J0ApMsjGtdC31a8JVdqeayaKKhbgpfV+QEcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

On 3/12/2025 07:31, Mikhail Paulyshka wrote:
> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which
> is a Zen2-based APU found on the AMD BC-250 board, there is a situation
> where RDRAND works fine, but RDSEED generates FF. This leads to some
> applications that use RDSEED to generate random numbers (such as
> Qt and KDE) into a nearly unusable state.
> 
> Although AMD has fixed the Zen2 RDRAND issues in 2019 with a microcode update,
> no such update has been released for the Family 0x17 Model 0x47 core.
> 
> This patchset introduces an separate sanity check for RDSEED and hides the
> RDSEED and RDRAND from CPUID on AMD platforms in the case of a malfunction.
> 
> Mikhail Paulyshka (2):
>    x86/rdrand: implement sanity check for RDSEED
>    x86/rdrand: hide RDRAND and RDSEED from CPUID in case of a malfunction
> 
>   arch/x86/include/asm/archrandom.h      |  1 +
>   arch/x86/include/asm/msr-index.h       |  1 +
>   arch/x86/kernel/cpu/common.c           |  1 +
>   arch/x86/kernel/cpu/rdrand.c           | 48 ++++++++++++++++++++++++--
>   tools/arch/x86/include/asm/msr-index.h |  1 +
>   5 files changed, 49 insertions(+), 3 deletions(-)
> 

Can you please share more about the BIOS firmware version on your device?

/sys/class/dmi/id/bios_version

Thanks,

