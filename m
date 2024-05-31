Return-Path: <linux-kernel+bounces-196473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA28D5CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BF7283181
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9417BD3;
	Fri, 31 May 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NuWbKq64"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DB714F9DB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144371; cv=fail; b=AxGG7RHOwW4zn8onbpf0aio7jHySoPq2j2plI/lV3USxOGHJ/nBRrpYsEDfbbxoCv+svQimHTOjYUpVGzdKrJe3ohquNCh/+LUKjEPk/TTnC04zypMh54i+U9jMWPqM2VVMADTFr1rpBPq8XIwLGekiCRv7dHO6FwoaHkFUI2CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144371; c=relaxed/simple;
	bh=RmgbVq0Qbx+8wwj2SKz5vIWFcVqeC2lvEPqv0I50p5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8JGon234UmsRRa0I73DV9V+QgeDvJPXOSG2rqVjRFC892cf5OLskwRvVt8Ej5N1AiolTUYIuths3CC2nS3xyEprr39pPi45aGmF+kUZG3Fa3oDLnvcuJHXqke+HedFRFaRy739RQjZx4f24nNuwSHW7bQ+C5Vp72laSqk+xRiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NuWbKq64; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsNOc7IDrpogV9xFL8zoPi0bPFqsgaR9hUO5Yndg5xVE5T3qztCO5ZfzVpNP30CExVG5qSVDamfhySgPo/yBqTNifKYE1XureY781rcuh5DQqq3eN3+QuxHoQU18xrlRGJ4jpoJ9rR0zXx7yIYgeOAIfXtJegGi+eOTa0TLsTmynHnpvPTj4hRSd2g6nGtNUQ7g6iSRW2eDGNyHyLkA8yhwQJA7eFZr9uH0xXsFcyAkyqWgaYP7P2mKa8FHliVvAUHY+tt29KdSr9pzKqDC6k7aK1lwIeywsu9qdMEm4iD7lHp8P2UH1pSy5B/fHBb2cIvw+L0+oJjglOMREFvqx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNQiMysmSQOa6OmoV5nMh65bORKox7vrfIMgbt94Xt4=;
 b=kS3XPkOMmE2A3htvOsi3nwP+TF+68b/+GRszfi/ZV9tUel2tTFcYBP3iQjbYir+6+dlBGhcdt/N0funAsDtpjkc5D5WmNWuolAVrOacjrypT0tV3w3jj0BEg7cEsfnhJ3Nu7SGfKg+G/9kYc2mZi2X19VBnRnJmQDmYREKOnACiOW7tFg+HoLddIVPaopjIN9rA75HAQlQJfDzD3doO4gOcZxTbuFqCt2DU84ukAIO24yfzSE0ED8fh4i42e/BmF61s6w+blhO/bQdA5SwKJ5gc95Oci69S62kdu9HY/QP5BL2VuC2D3IhojdnOYZNa6w94eI61t1w4KpVB+rf3JDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNQiMysmSQOa6OmoV5nMh65bORKox7vrfIMgbt94Xt4=;
 b=NuWbKq64nzFMSg83ijhdWcm46ZP9sUIpwOZ6vL957gCZRQmSCDkbnGIJg2qJCehKMp03UwDN8VnU7VajYozv7u935Cw3paFFqcCSj9x8ddv6ZLNZ5DWL3uWd1M8LPHxoWRtEz0PXgQ8DJzq56/zXn8+8a1fcBnAjqRaIeVXFGuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 31 May
 2024 08:32:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 08:32:46 +0000
Message-ID: <c63c2212-16d0-4d4b-9055-afc1196d7da1@amd.com>
Date: Fri, 31 May 2024 14:02:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/iommu/amd/iommu.c:2011 init_gcr3_table() warn: missing
 error code? 'ret'
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <7765e9c3-414d-444a-8943-7e244c945e57@moroto.mountain>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <7765e9c3-414d-444a-8943-7e244c945e57@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: bd17160c-6de6-4e0f-a17f-08dc814c3f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtsSGF1L1hjTWc0MHdoUDN2UFRDdXUwUlRQVXZUbnBYYUFYOXRibm1nMUY1?=
 =?utf-8?B?TXFCS29WWTdPY1B5UjVuam1BMEJVOGtnYUhBS2Y5cTNlY3lMNFpSUnF2Q1ds?=
 =?utf-8?B?S0dndlBFUWdVK1F2UTloTTI0ZXo0aGRBSWhlRjBaaVU0M2VaeTVxMHFIQjY4?=
 =?utf-8?B?TkFyaGg3Z3RkS1RidExpbmluYU1ncGRVemw3QnNSU1hlQ1dFSEZidnhVTDFO?=
 =?utf-8?B?YVI2S0JaVDA5MXpkTFZoSk5uZHQzNzdnV0xsU20yRTdwTnhWMHF5c2pjcnpq?=
 =?utf-8?B?MWEzQ3owVTRLcTdOaVdZbFFrR0VOeXJWanhtWDMrRkU4MmxHdlVmYVoySXVk?=
 =?utf-8?B?RnQ3SkFTUG1TU01PMEhIcHh4THhtVTNWOEwyUlRmNDQzRVBTcTA3R04wcnJn?=
 =?utf-8?B?aWdLaUpKYW9PNWFyaFMwMkZFd0N2Q2k1bWVUcjA0NWorQ1RRZmQ0c3ZJTnho?=
 =?utf-8?B?NFhaYlZoTjZMMERGVkRQQno0VVJNSTcrVFdwRTZXb0RpbEU2VVBDY1BZNytN?=
 =?utf-8?B?SWFteWtORTI3OVVGN1JodlNCcTlUalZuZU1XaGNXRFlTMUF1ZGNRWlRaRWZT?=
 =?utf-8?B?MzJXTkhUZU9mdEFZblhTMmRTRk5RaWFOTWxPbmxBS2hzTTlpd0lLNHFPb0Nu?=
 =?utf-8?B?Wm84anVuN1lHbXhmRUhBU1hMRWZvRXhCTENFR29icWtaek1zekhLUlEyRmFW?=
 =?utf-8?B?d0h3T0h2QzNnaEFLUVFTWHdzMXJYWUlqeFhzWDR6aVA3TXFuNzVvZGxseVVW?=
 =?utf-8?B?V1pVekc5Z2kzM0tZOS9YSFZhYjM0Q2N0ZHN4cm80L3JET0FTRkZqTmlobjFk?=
 =?utf-8?B?R1VNcFQ1c1NFSGh1WWlOMzRWSnhQNjBNanNDR2orV3BhaDVsaUVWTGJhT2Q0?=
 =?utf-8?B?bjVSOGhXL1Y3d2J0OVFTUXQ1eVczc3h4Zm44djNkRWVTVTNyMERmTXlYbnZa?=
 =?utf-8?B?b094aXh3RG51eTEvZnVsNnNIcXIyeDlrTENLbk56K3BrTlZiWWdWZGgvdnRQ?=
 =?utf-8?B?MkhDcTFhbExjQ3ZDK3p1Zmlnd2FwclNaTUo1S2xKSVlEVHJRMlFiKzV2RDM0?=
 =?utf-8?B?cmFDS084aU90Z0I3NGwrMU5ETEZLZXBFcDJWa2wvZ1FRWVZ3U0xoSzZacXdD?=
 =?utf-8?B?MmFlYlh3NDkyNS9IM2JBRXlFeDZaREZIdVdZZWgzV1Q2WnJwRFFQMm9RZGJx?=
 =?utf-8?B?azJuU2pya1VISDdCTEltdjBKNWhxaTZrdDJmTU40ZmhUM3cwOGtzZGdrRW1x?=
 =?utf-8?B?bGViY0hVQXpzZXpaWHZ2dU13YmJleWtKdHh0MUlSWmIybGdseCtDOXVFcDR2?=
 =?utf-8?B?K2U2VWljaWIza1ZOUHFaZWljM0pRNStQeElQRGJna2xTWFZYOEIxdC94Z0xR?=
 =?utf-8?B?bllObmZuVDNOaU9qTk5YZ1QrQVZINnBFenVoYVd1MU93NjFadEZzT1FXSUZC?=
 =?utf-8?B?Z3Q3SGFiZytOb3BtRDRZWUNMb3EzWXltSzVlOEJWc3BialU3ZzRPSUtoaGsr?=
 =?utf-8?B?N2dYS3pSQ0dVRnMzNXRBcmJPOVpQbmg1Q3I0VEJFYXozVm4vbDQxbEZKamdO?=
 =?utf-8?B?aERxY1U3S2VNSTh1Z3JZZ3JKMENabWlVNVkvQTZOZHNoTlRlb3lSVnNwL0RC?=
 =?utf-8?Q?+TkfzPMQ9FP2OFXqAQoigXPZHvts69s6G9cSqUeEYvQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YktiakxUcjV1L0ZTOUx2ZEUvaXBmdjlReGdtQlptbWUvajN4dlVaTE92Q0RU?=
 =?utf-8?B?MytoSWs4Vm5IQ094OW14ZHgxUjlGNmVEUm4zcnhGams2OWNhUDZoUkdaT1RS?=
 =?utf-8?B?MVpZTnNQUmxucmZCNW1JL2FqZTZKaEY0N2s0eGRZNlJaK1M4Ym1lNHROUnVp?=
 =?utf-8?B?RUlhVno2M1dvOFM0ZWFLYiszZUhtRmtmSG5oMDJkbjdsQ1BMRFR2aC96Y2VT?=
 =?utf-8?B?UzhiM2pWeVFlZ3BIM2JxWFB2cy92b2VHWnBvQmNMR2FLRXBJUy9LZXZlRHdv?=
 =?utf-8?B?NXh4N1JuUGQ4K2ZzeUxiQmZZdzhqYnM1aWpKTWhrK0pZUy9DOUE5bndKTHN3?=
 =?utf-8?B?aUY5QWtHeFpHblY5MEsrTmtRQkczdURaenpmSFhYb01Tc0RQSDE0UndvYjhy?=
 =?utf-8?B?SjFETHVEakc3N2ZOckQ0NGF2NVljMTcxVjZOWGRrSzYyRDZTL0RPTzA4RHJG?=
 =?utf-8?B?VkNtbG1pNllwRlFMU0thd3hseEtZbks4UEE1NzlhSWdkVm9sMThWTFpNbUdp?=
 =?utf-8?B?RG1HMjlxQVdmRERiRmhLS1lQLzdIVDcwallmQnNRS1o4bmw0dXFka2l4WHU2?=
 =?utf-8?B?dFYyWXNRSEtGemZBb09OVDRUYlJIS09JZ2Y1eTNUbEJyQURwQnJJZUFNNlN4?=
 =?utf-8?B?TFlxSFh5U01HU296U2pGODd3QmtzT2tpVFlIQ2laRGJhcDZZbit5MGFqenp6?=
 =?utf-8?B?MGlTRWF2NGYxa3RmSGFDalUydnRpeWZ3TGZRdERBMmh3ME1haHhJSU4zdEsx?=
 =?utf-8?B?LzV5K09uSHBzZWovT21PYVNCWmNYV3dXZnkrdllZakFqeVJnVnluUHVGcXdE?=
 =?utf-8?B?RTFBZUVOcUZ0NWtyWmN1elJ1akszeXA4bjViSjVhNjhGVEVVMElIMDFYS1Ft?=
 =?utf-8?B?WEdXZXhqQnFXVkdXK3BZUTJhNUJNakJQVDNRKzlLOS9zZGJwWUVhb2J4aTNB?=
 =?utf-8?B?WlhqY1FUVlZCbWF1clJ1S2pHNDQxNkNuYUxvYThLbFV1VTZNUTNUZVNtWTRT?=
 =?utf-8?B?WUpyK2ZOaGFSR3NuT096eTZBcGQyaEZEbW1wSlZiaTBBT0l5ZFAxejNraFFD?=
 =?utf-8?B?NWdoczJnODBFZXBLL1dxL25TVWdKbHlnTEpNZFEzT1VDb2I3Mi9pakNhTCtK?=
 =?utf-8?B?T0ZyWjNTVnY5bjFqVnB0MXVDZC9ML0o5Z3JTTkZ5WTE5U0tUeXpZMnYzZWlx?=
 =?utf-8?B?NTd4OU5YR0lLZUxqOG11R280RDc4b0N6cXRRV3VBd29PQnkxSWJJRGZpN1Jy?=
 =?utf-8?B?YUYveGJMRCtidFpQSnJ6TGM5TTNqcWFoQWsxS1Z1Q1BLaU55R1hyK1Axc3Vr?=
 =?utf-8?B?RXk1OVBaZjA2YmpiTTE3WVV3ZE9pdCtVUCs0YnVaUjVFOWd4cUxXaUFYZmRv?=
 =?utf-8?B?bGtJeXRINnNNM1psdEdhNlVjY1dPc0lGRDhPWGdETCttRmw5QkloQ2Qremo4?=
 =?utf-8?B?RVJ5OE9Vb1RRTVhReStTMjI3bnNaR2JjeXVENk5OL2ZGdzRtVDdiOTdIVE10?=
 =?utf-8?B?UjdEOGp0VWxtUHlNV3d3SlZ2dnM0cUtqTzJzL2JyQmc4V2tHR3VzdGN2cEpO?=
 =?utf-8?B?c2RwQ1VLMkxPTGdaYkhSaEFFcHg3K0duZlBHMlFvTm1scXJqOGFFWEdWSHk2?=
 =?utf-8?B?bWFMU1lyZG5xVlpuRWkvcWpRUHJvQUJHdkdmQmxrTGhvSGdySW1LWTMwbDZF?=
 =?utf-8?B?a1RNRGs1QzNmUFlUOEZsSGRKZDMxOFZJaXdjam9kWTR4MzRTQWl2NTAyUjZI?=
 =?utf-8?B?VnlYVUQ1aXM1UVlCU2tOZlpQdXBPaWpHVVFHNVhJZkxUdkNxY0hBQzE4NVJz?=
 =?utf-8?B?UThyeTN0RHVubmNqRUk1dXc0cXk0L2RsbGJQSUU4N1l2eFlFby9QNDJmZU5T?=
 =?utf-8?B?dHBHdWVlZEsrQkpRelFqcllzaVlPS2lUUFYzWk02SlQrZzJETW90bW5BS1dn?=
 =?utf-8?B?elRlVG14Q21TQUdNUUM1clRGTXJwNGJqRVNiREFXRmxDaUJ4RGNtKzVTU3dP?=
 =?utf-8?B?MGM2TlY4cjZZaFpZOHRNMXRCYmpHUHRINnZVVjNkeE4reGJEQ1NHTXNQUlBt?=
 =?utf-8?B?cVJlNWZjRkZyeEhmZGtUY3lKbkt1RkVxc3hGUGhhSFF1ZDk5UTFjREZXTTUy?=
 =?utf-8?Q?Euw4nd5ZNyPleYz+qs8/ne6Jp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd17160c-6de6-4e0f-a17f-08dc814c3f77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:32:46.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBCFma56ZP3EdvtRUofTLH9lpamFYSgBgQXySn/VEiY3E2Cw+PG2wTbhaAQD8JBg5pOFE2VPbujottqPMh97Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

Hi Dan,


On 5/23/2024 8:39 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   29c73fc794c83505066ee6db893b2a83ac5fac63
> commit: c9e8701132e6cc162d082e7dad8a2e9110f5f8fd iommu/amd: Setup GCR3 table in advance if domain is SVA capable
> config: x86_64-randconfig-161-20240522 (https://download.01.org/0day-ci/archive/20240522/202405221116.X7cP3GzG-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202405221116.X7cP3GzG-lkp@intel.com/
> 
> smatch warnings:
> drivers/iommu/amd/iommu.c:2011 init_gcr3_table() warn: missing error code? 'ret'
> 
> vim +/ret +2011 drivers/iommu/amd/iommu.c
> 
> c9e8701132e6cc Vasant Hegde 2024-04-18  1986  static int init_gcr3_table(struct iommu_dev_data *dev_data,
> c9e8701132e6cc Vasant Hegde 2024-04-18  1987  			   struct protection_domain *pdom)
> c9e8701132e6cc Vasant Hegde 2024-04-18  1988  {
> c9e8701132e6cc Vasant Hegde 2024-04-18  1989  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> c9e8701132e6cc Vasant Hegde 2024-04-18  1990  	int max_pasids = dev_data->max_pasids;
> c9e8701132e6cc Vasant Hegde 2024-04-18  1991  	int ret = 0;
> c9e8701132e6cc Vasant Hegde 2024-04-18  1992  
> c9e8701132e6cc Vasant Hegde 2024-04-18  1993  	 /*
> c9e8701132e6cc Vasant Hegde 2024-04-18  1994  	  * If domain is in pt mode then setup GCR3 table only if device
> c9e8701132e6cc Vasant Hegde 2024-04-18  1995  	  * is PASID capable
> c9e8701132e6cc Vasant Hegde 2024-04-18  1996  	  */
> c9e8701132e6cc Vasant Hegde 2024-04-18  1997  	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
> c9e8701132e6cc Vasant Hegde 2024-04-18  1998  		return ret;
> c9e8701132e6cc Vasant Hegde 2024-04-18  1999  
> c9e8701132e6cc Vasant Hegde 2024-04-18  2000  	/*
> c9e8701132e6cc Vasant Hegde 2024-04-18  2001  	 * By default, setup GCR3 table to support MAX PASIDs
> c9e8701132e6cc Vasant Hegde 2024-04-18  2002  	 * supported by the device/IOMMU.
> c9e8701132e6cc Vasant Hegde 2024-04-18  2003  	 */
> c9e8701132e6cc Vasant Hegde 2024-04-18  2004  	ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
> c9e8701132e6cc Vasant Hegde 2024-04-18  2005  			       max_pasids > 0 ?  max_pasids : 1);
> c9e8701132e6cc Vasant Hegde 2024-04-18  2006  	if (ret)
> c9e8701132e6cc Vasant Hegde 2024-04-18  2007  		return ret;
> c9e8701132e6cc Vasant Hegde 2024-04-18  2008  
> c9e8701132e6cc Vasant Hegde 2024-04-18  2009  	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
> c9e8701132e6cc Vasant Hegde 2024-04-18  2010  	if (!pdom_is_v2_pgtbl_mode(pdom))
> c9e8701132e6cc Vasant Hegde 2024-04-18 @2011  		return ret;
> 
> From the comment, this looks like a false positive, but could you please
> change it to "return 0;"

ret is already zero. Hence I used 'ret'. Yeah . I can change this to zero.

-Vasant

