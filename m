Return-Path: <linux-kernel+bounces-365428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC399E224
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59286B26363
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4911CF2B6;
	Tue, 15 Oct 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xASEa0dg"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A21DD54B;
	Tue, 15 Oct 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983075; cv=fail; b=XHr2X73DNZgvgPGmp8U5HYo1Bc6dWpkTanyxYQDmJbp0p702WOPni0wrvvJgDIHdwiOCxLqMXhKgHGwI/3uUYeeWUaoHQ4+XilP+NLU8qcbB5xZpuvMcl9C2fv5KGG/pfSsOpKcG4FvwNWi8leLfPvf+L/+gsuk8wrIC0Cx/00o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983075; c=relaxed/simple;
	bh=wP27HueCiCWBsP1mGk6+R5EksJo59xbY1KqfIMNPax4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hmhEaGPgrt4mC9LGDMAp97L44PMOeFjyIAzW1WEBZ77+EDbLsmOIVR2ZKjOAPRNSHd2dofBoCsBr69MOPneBhvNvUmxgLMjUVDOph1mHP5vrXrk4f6ie/H68rNspjAiRf6hux4WyZSNpzonY5MxPI3C+CO3R9xZjHCfnSxm+u1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xASEa0dg; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABJJz8xWfeQBLXCCn9dVilLGGeTC1zGwOyvK6u+miawyxDUJ/Iv7N31yp6PSMQrPW5DIm3ecAsZk96NUavb1Lyts85lYUj+YPCsecXXqd8yWBL4WoR2ZpcQT4KtcT3rpIw2ptzb9KH80xFPPaAwV/aElU1IATKRNNux3qcCDPighxyVd2zfGlyDnJE05MAJ2A6RpAEXAjOS62vzfIRJcRDdjm9/ApLQBq9AECGcgLLOzeMDx4sa+213XpK7YEGIm88aiowSv/bHXo/sr/r4ww8+il3YLMv56HlxTIT6JqYLSydkex0zcI5314iNkAVonusJ8PeEddyliJvzphlOm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx3lJN055xyuXOvb77rlXx4FEMUD/LQbM9qa88DzoZk=;
 b=QA7MU4OL8lFC7l4/0GrqmAvmD6ns5PIJ4p1xxwcmAkT8PzCj3AYj/ybBl7RNnlAUVAVJzB3HEuN9ANc8OIx9DjgAN3FcwMMgNcJe3Qx4uhx5XRWxWGazAJeAduftskx3v9cESS8kYXJKrvDWVkBl/pK3d+q93lWfTtT8JnM3U7RlhTixdoQcZFvXLXdEicaLqYZvjRkAOtFMXRKx+vdt6vFlH0DYPYVyUeFhaV+yQIxa7vyOVc91JNTJ/7bAS4sRt/LFiM06NWBDj71JUex4B6Ncy/yeuFEteoCf/vcaJnVlJCHXaX70GGzVDXyJmczRHNnlf4Rl8T66QI6Xs77H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx3lJN055xyuXOvb77rlXx4FEMUD/LQbM9qa88DzoZk=;
 b=xASEa0dg0HYXT1wUfRj4JJLdK+JYB/A6CaYTzvmDCQHmLNiw2GdUJM597k6OxpSMHP65Hic8pygre+U7Nvb7M2CrGB9hk7UvpsPm5eMeaK7/2/G1r6eWrKq2cIZePhKeBFfOcyCMDUTrZzmg83OEh5duuGZl3RG9LPfg0wSen6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:04:30 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:04:30 +0000
Message-ID: <38ae8fae-cbb7-dab5-c7ae-fc029dfef6a6@amd.com>
Date: Tue, 15 Oct 2024 14:34:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/9] misc: amd-sbi: Add support for AMD_SBI IOCTL
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
 <20240912070810.1644621-5-akshay.gupta@amd.com>
 <2024101329-suitor-humpback-21ca@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <2024101329-suitor-humpback-21ca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0252.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::11) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1336877c-296e-4332-c3b2-08dcecf8609a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXc1QmFVcEdyOFJuekVvSzZiTHo1cFN4K1V5ZitPaHRLTGVBUHNXMWE1Tks5?=
 =?utf-8?B?UnZVejRSY1VXbzdyTm5ZNm13TkRTdzRUazhRMnZuNmZHdEZ5c2dxVVlHUmh2?=
 =?utf-8?B?clZtMGsrWXloY09BZU9ZQnJ5NXF2ZE5zTHhlSGhxaVM1ZkdOaGlUMVJlZkJW?=
 =?utf-8?B?T0lrNDljWGpNSVNBWmxIUTVxY0FjYzVzeDlmQzlHMDUxUW9BZVFGSjk3cjdp?=
 =?utf-8?B?Y1JpK3JOL2dFRWM0cDl1ckVQSTFkc3NHTEdRQkt3aGdNcUQyQzRxNTJyeXZ5?=
 =?utf-8?B?S0lKQ21VOTZmNkUzVm9ZOFZQVlUxNUpCb0h0c3ZKa0cvZ0JFMjAvdWtwNEVu?=
 =?utf-8?B?czNFK3R2N0NFa1lCbEJnTWxYUEtsdlIva3ordzljbFJ2Yk54MVNZaFNWT2to?=
 =?utf-8?B?OUpreDJsd3VUZ1hoTGJjSGNielR6eWNpZDhkK3NaMDN0TnFkTWhMVTFkODhr?=
 =?utf-8?B?eUdYMEIrNk1BWEtBZEtEbEE3cWRXRnJBdjg5RkVLM3BhcDNHVThHTHhFY1hL?=
 =?utf-8?B?RXR2SjZrQ0tMb1oyRDhVQ2MzL2Y1aWM2MkoyVmVWc2FIam1sTUYyL2tSVjVQ?=
 =?utf-8?B?NDc1dmVhek0vbjRWcXFGWWlwb3RsVDd2QTd4N1pUVmxDaHIzdzA2RTZvbjRl?=
 =?utf-8?B?cytaNVdMc0t2OW1jd3Y3Y1VLUlg0VExQT05qRXNBamxnMVA2NEYrRThkblRp?=
 =?utf-8?B?WXBxNGpscmtiMG1BZnk0aVl4K3ZtUDV6dExZOGxITUV5dXd4RSs3Q1YvQU9J?=
 =?utf-8?B?SlFCc3U1ZjFIOFFYYzlYZnZiTk5EN2tENG9kVGxOMU1ZRm1ObHVYQlNNc2pN?=
 =?utf-8?B?T3NidVpBOWt2NXc2eTJ0SGl2aFUyUnZzbjFlelhqWWk3a3VaWHdkVGFhSkVY?=
 =?utf-8?B?bnZ3OWdhL3J1aWRNeG1WaEFNS2hZaGJqVXlWZVE5djl1OVVHcjgxa3JmYlJp?=
 =?utf-8?B?d1pVUnJlUUk5V3JOL1FLaWVpbkJMYmtseVA4RzNDcm53d1lxMW1zRlphQ0Jv?=
 =?utf-8?B?N1ErL0pVTmpTVEN1ZWthZSt4ME5LN2ppY2Q1MGk2NWpNMS94bE8rR2RtMzEv?=
 =?utf-8?B?UTk4T0E3aGJUd05aOUg3VTYwZThJWC91KzlTbmZKc0dXZksrTE9VQ2F1T0ZN?=
 =?utf-8?B?NytrTC9aNEJibDlhWFNqSXNLMFRPRytoejhnZGNBTDYvNFFRbklNYUl1Nkha?=
 =?utf-8?B?LzFGenBjTC9xdTY1ZTMrTTdnQi80TTVSZDdQeGpINkFRcU1rMncwdEErQzlz?=
 =?utf-8?B?WkZHRWxkczI0TmxvOGYxM1hjQVFvcmpiMFd1Z3A3YjdpM1BlYWZHeXV0Ni9N?=
 =?utf-8?B?QXYzdmFWSDFKdmlkQVYwYklZMnpaRmV6d0dLY3FFTFJQVUVZa3FFZlBXODZV?=
 =?utf-8?B?cER1Q0RTRWd4dHlRSXdoNDEza0xTV1lRa1AvQk5kb3hkN0lkc0tPOEl0eW5O?=
 =?utf-8?B?MjFlY2hxcXZSWlVJeG1DSUM5V1U5Mmh2cW1weFlyMVkzZDdkWjVZVEI1Ulc5?=
 =?utf-8?B?WUNkMWI1d1hzOXNnWUJkZkxFZHFmZEQrRnlzZUxjQkpBN0pvUXFsKy93dDR4?=
 =?utf-8?B?d1J3WnJib0xtTG1Ia3JVenpMNmFIakh5Z2trNWNiUENTNGRiN29TSzhkbFN1?=
 =?utf-8?B?bUE5WFQwMEZkN2tubkYyL20xMXlzZkFGUnFrNmlVKzJISmhrOHhEQmtuZkd4?=
 =?utf-8?B?d0gwTVlVRG8ySjVOenVjVzVBRThZSG53aENGOENBNnJrSUdkaW1tVUd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDVpN1g5VFltL0QvNFNnOVp4SU9sTE8vR05NZXdmaW9aL25RQXppTGI3VTli?=
 =?utf-8?B?K1Vjc3FEWHpPcFJKRmQrVjVHMkZJZVVlcGNvZHMzOThNZVI1cGxUd2JVQUJT?=
 =?utf-8?B?NG9jU1R5eStnNjVQQnhBWXRTSG81ZURieFJwdnV2d1JjWnJNZ2JoS0EvS1hi?=
 =?utf-8?B?cWJMT1dpK3JyK25kSHRIWGhFUG1lcE9wd2MxekhDQTRvRnhMZlpxN1hRWm5j?=
 =?utf-8?B?eVJ3UDhSUXNjallJU0x2bFNjV3Z4TGF5TWZPUlJ0VUszb1FuRjk5am9adzcw?=
 =?utf-8?B?QTFuN3JmWXZNaGpYZjJiWDA3eTZZOGY5dDhqVG5Lc21uR1pEVW5YQTAwVnNm?=
 =?utf-8?B?eXJEMmF0MEVXc1ZPWUcxa2pmNDg3TUFQcUNNc0pkekpIWExtUXJ3QWd3SHA3?=
 =?utf-8?B?UU1sWHc2TU54L3lmZ0kxaHNZZUlvdGJhcWpIb3ZxMUFBVnE0MGxFMW1ZMlpr?=
 =?utf-8?B?eUIyV1NSQUpDYnE5RzZhYkQxK1B4YUJhWmNtMDVOamVMNnl0QlYwMjg3MnZG?=
 =?utf-8?B?WW1mdVJaR2FiRlEwOVAyZ2xRQlVTNGJWUDdRdHl3Tkh6WGExdWJ6R1Z3ZWcv?=
 =?utf-8?B?L2tNQytQVG5XZk1TenBpd0tHK0NXSTdBaW85LzZmWkhjTHM0YUNScXc3NWhp?=
 =?utf-8?B?dTU5VWVJSVNjMVVZUTZqbEN3T29ibmsrZGdVRS83UTdVQnB0TER1UmxMZEky?=
 =?utf-8?B?N1prR1JvbUlnL3pGQS9IZGl1RDY5Nk91S3gzeWVpN0tDOUl3M216N3hLZCtX?=
 =?utf-8?B?TWl4U1RYak9YZ1JjSGhkdUF5ck5hbnhPVEhUQjhLbVlKU3dDMG5LZEk4eWo0?=
 =?utf-8?B?NDVVYllYaE9CdGNlMjRremZScUs0VEhrQWVmRkw2U08xWE9yRXNCUjBkaFUr?=
 =?utf-8?B?Njd4WVh5K0hRRGJWcGlQcXQ2T0N5WW0rdGpHZGc0blFkMTJCbjRra0xwYlpu?=
 =?utf-8?B?QlR4TjNoK3lvdHVoK2loTkQ0RzcrQk5tM1BHanpSeWRXM00wWVV5UDlTUTcw?=
 =?utf-8?B?Q3ZTd2d2RlF5WURBNjdOU0gzbFcvN1hFRHVWQTFuSTV5bStIbEIyRE5PMWtZ?=
 =?utf-8?B?eHNTZCtxZ0R2V1g1R1BrZ3dKcklOZzBkS05sS1dlQzRWQkhTYjZTRnZxMTlN?=
 =?utf-8?B?SzRWWkR3ZVJwaGpTbDN5dU1sVUxNRWVUeVB1U25ONWFMS1VweEM0SmUrbjdw?=
 =?utf-8?B?N3grbmdoSWVwUVFEYTNVd2NFNnM2UWJWUEhrT05SSS8yMWFUbXlSR24zSTI1?=
 =?utf-8?B?dVp2cFE3OW1rWGRCNU5JZVdDMGF4ZmNHckpSNXhlZDlZRTFYSXZIUURZQ1FT?=
 =?utf-8?B?VU1uUHNMWFBRNWEramhuSFB6UFprU0swcEowWUlubUYweHBMMWJIMjFiRUY3?=
 =?utf-8?B?MmVZMkdZYS90RTIySko4bWNuL2UzOElDWmtYdllYTTJMWDlMRTZucmk3Nko2?=
 =?utf-8?B?ZmhHaGduMDBJY3h6SGVoZFdtMEUvcUUwbkhNdVdxb2FZOVQ3cWk1azZMeDNl?=
 =?utf-8?B?U2d6eGIyaTZ0aGhSSnVpT0Exck0yM1F1RUUxWTNzSlNTcHVkd0RNcjY5NXdM?=
 =?utf-8?B?OUZyL0c4anJseDg3MXF4Wk50T2xEMVJkVjBXSU5nYTQrZ3lJUTZMTzJIWWs4?=
 =?utf-8?B?SThId3I1bmRCVTlTZEl3TkpoZmN3T0F1NllmaDJyZWZvTVFhTEdIaVhtTXRC?=
 =?utf-8?B?SzZXNlA2VGsyLzFiYi9Edm9rWGpMRk83VnRIRUhmRkFVdTE3Ykt6NGFZVHBB?=
 =?utf-8?B?RExMb1FhQ2h1akNMTStlYTFiQVJrbmZLSmY3WkhpVHBYTVFXQ0pMbVVzUm5X?=
 =?utf-8?B?M3dQOWRlc0hrT21yanlxcGp1SHVHeDVpN2lpdEd1eHFRVTFObzNIMzFuUERM?=
 =?utf-8?B?QVVmU216WG5EbUVlalVoS214elA4UlpoMzdMS3IvVm9oZzRScEExeVlkTUNI?=
 =?utf-8?B?MEw3WEU5K05XR3lZTVc1T3A4TGFvcUl5TDBXaGYvcUs3MGR0d3RSRnkwSlZj?=
 =?utf-8?B?c0lWMmdLYVc3MW1zbHJ1b3VsckM2M2Y5SHgvZVd3ZzZVWnNMSWhNcVJMaE9X?=
 =?utf-8?B?aHJ0QlFzVjdzNnVhd1Azb0hFZnIzYmwrS0RZT0N4WmMxWmVqTml6TG43c2Jm?=
 =?utf-8?Q?SQ3cW9am2kgxU+Z+63eiUwskU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1336877c-296e-4332-c3b2-08dcecf8609a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:04:29.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwV6wJWuSu+tVKnySJKa85pEOuKeErcbTNVS33fbMP43HEo8rJc3DBFzf2EcvTdu93hd3Bkvx5peltA4RkDc7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493


On 10/13/2024 8:52 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Sep 12, 2024 at 07:08:05AM +0000, Akshay Gupta wrote:
>> +     switch (msg.cmd) {
>> +     case 0 ... 0x999:
>> +             /* Mailbox protocol */
>> +             ret = rmi_mailbox_xfer(data, &msg);
>> +             break;
>> +     default:
>> +             pr_err("Command:0x%x not recognized\n", msg.cmd);
> You now just allowed userspace to spam the kernel logs for no good
> reason :(
Thanks, will remove the pr_err to not to spam the logs.
>
> Also, always use dev_*() calls in a driver, not pr_*() ones, as then you
> will know exactly what driver/device is sending out the message.
Thank you for the input, will do.
>
>> +             break;
> And you returned the wrong error code if this happens :(
>
> greg k-h
my bad, will take care of this.

