Return-Path: <linux-kernel+bounces-199012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D68D8082
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4414A283F23
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467384DFA;
	Mon,  3 Jun 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5B8FizJz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5978C80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412638; cv=fail; b=mnYltkMXbGSBVQz3IsfbMzwGg3kwJ71WRTzZ7huSUmjGq91rT1bqUQkCovnvrMZ1xF3UVNLG9h89Ptxyfa1WI8LBX1+M9X/PhOTA6NOtpDKUOmXUX4BiJGOCNcneK7vLwy5uecXimsf3/kbF/HabLVfXPghet5W9jW3qYSzBYUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412638; c=relaxed/simple;
	bh=9tNzYiO3xHDyEPFyspeORK3FoJhhnI/Eid67j4NKW/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ByGIsUnZqbnOXE4lE/bIG4gKPsxblgjvFDj697tgFPFamjKoH3VvzR78zhZjdS2U/TTUImN09hiaWoad6N6DEe2JAQAsGCX4bHboTOEq9m6HlQx7pN6KzTAb22Ag0cVvfZVB2ODfxng6iRm47A3NXxB2F7342QpPCeQxg3bOdUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5B8FizJz; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0Nv2XvgK6GTtZrx4A4bCvRyk7CGB7KrOzhnnWCl7NHCcZqwJqenD+pET9TXY+hMfMLsQ+8rgacmI48fsRcv74XvII1dnjCUnwcIQGyDkN92MZKdozsaHkPnmIqeEcZc7PCGjAGyziUe+ct+s4kP+Rn5dwpsKLV6VeBT+gYzImz04OdJF24c/784FYZo884vr/dxFOYFpbK/GQ3Mu3Kxg38Nxrz1vL9XnLvG3r80xB6DCp4QHSZ5hH5v9M4HjAJc4rrVkGdtiXfwKDPHMa95MFguK9lrvWfz2zpYdpcqJuIymi23usCoQ9Cc4qcFR0v/vIOg3pKc9CuoJBHUBD0Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+TKNcjcXeopTWm2XmMx77bIFDARQCCZcYqc6s65r00=;
 b=OAjVqdvhNp0uOBHKRgBphdYv2jnfZ7pZ2GoaQ8iMj7ajffKpxrxtnX0syLWAN035q8NXIu2OILewrMWCsUsIx4sS3Jn7qAEjra8LRzwJKZrUZeumXG2nH3rXcTUaC+zradwSPkFTFDupzP+vTHj7PCDsFjpoQnKoAXB41mp5YvODT3plk3Lvc/Hci0wkbZM7zHrctbdx/opLKNHyAHKkAlIbkckJCHwGmeaEavLM8yPclZsMoHKSkJpREvJIRXOKt6Ei7w91Jj5QwaGPZxFvfTuNvEODlimq/Pu6deBol26gdJF1SresKv8sUaB//xqXBONmYEpkv1ptWvtDxHPurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+TKNcjcXeopTWm2XmMx77bIFDARQCCZcYqc6s65r00=;
 b=5B8FizJzf4Cu05UWWN6O5zWTm9bcPgsbPe8P75cFJZzOmajUi6gmWdJ49kJvdpGx5OyOKSrqDLnfcfWhagKobd2U8Ul8Qwt304LxMikKe+O6R4Ls8v9gs+a7t4o49ivJNr3aLRkRn96Ep044achYBqW/q4aTHpNWx7ZDEWilnCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 11:03:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 11:03:53 +0000
Message-ID: <b879be59-ce4d-4cc0-b672-558a64ee9a97@amd.com>
Date: Mon, 3 Jun 2024 13:03:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: xilinx: Add cb event for subsystem restart
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240424095937.2448-1-jay.buddhabhatti@amd.com>
 <20240424124900.29287-1-jay.buddhabhatti@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240424124900.29287-1-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:803:1::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: b58f8429-42d7-40d5-1c15-08dc83bcdb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTF4WjdOcTFWTDB3RWhiaEEvdE9FNDNpK0NNU2QvVG43Nk54dm05b0VsZ002?=
 =?utf-8?B?cHhkaEZKUjZieGtaYWV0RGV3bGl2TjI0QUV3dnluR250MEpITUpSOXpsa0lR?=
 =?utf-8?B?YndkZUJXemVVMjhjOTdVRmtFWHFvUWJES1ZQMERmcjFIbCswWXBuaExmVjhH?=
 =?utf-8?B?RHRXNVkrNlFpOW9UV01TRHpQbG9tWWhQeHNzYk5lRzdqU0dxU0xnNTZlMS9v?=
 =?utf-8?B?Q1FORmM1U3Yva3FUNWt6Y0Fmd2xLRWVtYXF0SFhCMnY3dkE4dUVpeUo3dzVh?=
 =?utf-8?B?cWhrL0RoL3ljMnZpSisxckZBLzBXN1FlR24ySkJJdUhHMUNQVW1ocEo1MUt6?=
 =?utf-8?B?cnA1VXJZd0dyMEt5dGFteHovcmFyZGNqbjJUQThQVlFyQ0R6cDRNb3NBVnh0?=
 =?utf-8?B?SzNZSmRFck1ydFB2ZVB0UjROUFdtZWtFbEdYa21xdVJBVjhQTHg5VU9sU09v?=
 =?utf-8?B?NzlDS3haTm5LeFpFV0U1dHdmNDQ1SzJFQkZ4SWdzYVZmY29naGhWR04wWDF6?=
 =?utf-8?B?cEduK0dqQXA0aGM5NHVqVVkwRG5iN2NZR2d6VnJuNExNRDc3OTc3dlNXUlNQ?=
 =?utf-8?B?c0R6VkQzYStja0lUc3pBSkE0eWRRMzlxYlNqNlNlSTc3Qm1mVWt6Q0FWM3l6?=
 =?utf-8?B?d25TUklUODFIcDNMNzZDbE9MdDI2V1Jzc2tPc3BBbk1qK0kweWY5Zmw3K2VU?=
 =?utf-8?B?dDBmZU5tNkQ1Z3crOXdLSnAwd0pHZEN1Z0hPeHZlOEhmZlZxRy9BRXVZUVc2?=
 =?utf-8?B?cXVmOUluNXEwNlpVV3h0MGtYYU1jaEgzZFFWYzVHSld4V2x2UTA4TXhYdmFB?=
 =?utf-8?B?dFNHNzM5SEVPb1JHS3J0a0lKWDRFWGJ2aFdoNDFCSWRsN1hhSGJOYTJkY2NS?=
 =?utf-8?B?VTVIS3JuY2xnVEVkSE1QSlVTa3BMVFFPbUFTV09aa2d4QlczaVA5Tkhqbmdl?=
 =?utf-8?B?Q3ZqUFpKSUVGUlQzcWk1QkNzQXRNR3lGd1d0amdBcmlmN1lkdzZMLzlObGVT?=
 =?utf-8?B?TVBPMzNDYURCcGZUYWVSeFlIR3lRaGR0YU56WEszRVN3YVBhR3VZRkhsVHd6?=
 =?utf-8?B?VXd3T2t5S2g2dVBpK2FvKzNkb2QxV28rN3pHQkZRNEwwWmtWUHRhdWtwZ082?=
 =?utf-8?B?YS9hWkwyRWM0RDY0NGx0NzZnSm1qWTJ2MWJWOFBnbnlzdEprc1VEallLMSta?=
 =?utf-8?B?bmdaU2hXc1RsUURWNzNPTGlabzFoTjhCWmxiVEFjZFJ4cTROOTI4RWtJVGNT?=
 =?utf-8?B?OWJvczZvNXpyRVcyUEJYeWlUNXRVOG1IY2NNa0lCQ25QOFpFT3Z0V2ZjNnJT?=
 =?utf-8?B?NHlUM2RDV3pXS0pQSzVUTmt1bG9nQVgrc0ZSenN3ZTA4djBUaVdva3JINVBS?=
 =?utf-8?B?MDRPd3czaXp5eXh5ZFJnUUN6REw4SnM3ZkVlOXowcUtGOTVZdFI1Tk1vcDdB?=
 =?utf-8?B?TVBrSzZaVEZrK1lZcm4vVGkxakIySGFuNkcrbzFCRForYjQ0Uk83VVVmSU5l?=
 =?utf-8?B?QjRUekFzTDQ4N0ZHR2twM2JqYURRY1hhNUVkWnVqU1VPZHg4WDJWa2NJRGdT?=
 =?utf-8?B?THdHVkFqQVZlN3RXbVJXTTFYOFgrVVJtUTA3SUs2MVJFc3VPVFdTUUpQaGUz?=
 =?utf-8?B?ZGU4T29ZSzZaenRsWFZ0UGVNaStFU0FBQUFNRVlDVVEzbzhzR1pNeDhkUUtn?=
 =?utf-8?B?RXdPM2xOUHdtYWNEUFNiK0VTdi9xUWEwdWJ2dHMwTDZqQWtzblJZSVJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0d0bkhkYXN4K1NFVkZkSlo1YU5NYXFFOXI4UkMzY1FISGVkc3hHaDdrS0Va?=
 =?utf-8?B?U0NoY2pOUHA0THBjaCtKcHNIU05pMXljcStnRHcxMWtTbWNESVdHUDNzT2ds?=
 =?utf-8?B?YkYwS0xEcjFSY0o4R1ZSRERFL2NGOVF0cU92UmdYZ2l2bUZXWHNtZFZHVXg2?=
 =?utf-8?B?a0NiWWUzTjlhUTJRbHBIMVdpRjJieGRzU3FnMHczT3dzc2E1K0xSZGdZaGtF?=
 =?utf-8?B?dkdKbzc0UERXRkNEdEZScHMvMEt4dDFOYldzUXFicGNvRGxsUWkxZFI3ZVl3?=
 =?utf-8?B?UHhCWXdYeGJZelB4ak91dFN1eVFLd2g3Z1RwOGVSTmxVeHlZVlk1TVZuWTZP?=
 =?utf-8?B?Yk9OeTBKL1RmZHVpUWYzQ1ZsWEtOZmdlaTgxcVhWcDd2bEx1Q05WK1hYWFFH?=
 =?utf-8?B?TW9KKzhDeUh2SEp4ZTRvSmtkbnpUN3YrN0VuLzdKYjRIZWdVbUlPdXVTWXBP?=
 =?utf-8?B?Zm1BQlRtT3JhRDVwbkZqV0xNUHk5dDBKSlYyYU9kQWxRUkFiWTZiTFhLWHRi?=
 =?utf-8?B?NzVZOHNDTFZiNnJmOEVYK2VEZ01YTWU1cVJIR0V6VUloSTVxcHZHNFN6RDdR?=
 =?utf-8?B?YWtIOTk4ZkRkL2NzTEc3eG90OHZ4dWsreGZrVTN2d3JKZnU2dGZPTXlrUkVj?=
 =?utf-8?B?VGk3UlVldzlEaS93ellXUEZSTzZNRjhmamlXNG13MWFVNklJRDVVSDJhZFRo?=
 =?utf-8?B?RjlqUzBwaVo3eG1BdmNmakIreGdwV0RTQW15TVBpYWIxclYxMVVkQkcvNUxt?=
 =?utf-8?B?a1NTRXprb0xiSHZyTnBhcW1SSWZZM1JRT3EzZXNpL3VpZHkyWlNTYmkxUVlX?=
 =?utf-8?B?bWRENThDVzVPaDBXazMzWTE4VW1KQkFhNnNNMHNqUnQyT2RBTnN4ekIvNnZw?=
 =?utf-8?B?Y29wMGJacmZnTzV6ZEx1OXpTOUhyNXBjS3RqZURoY3RMSFQybHBhc0VOemFU?=
 =?utf-8?B?a1RmcFFTMzBsNUl6UGl4VUc3VmJobU1GNEVKaVphWG9rZ3NycGJNUXFHbTJ1?=
 =?utf-8?B?OEJaaFptRTJDUUgwNHpwR0l0V29lMXpxaThDSzVHbFRiT09iYTZ4ZEdxczYx?=
 =?utf-8?B?Q0NnQ1RnRlU4QTQ1aU1HbWgzcTRGVyt5R1lzZjhDdEV0Q0NFMm1FOEdBTVRs?=
 =?utf-8?B?aWNjT09BYXNPOUd1Wkc1TGpkVVN6Z1VXRTl0NGJFK1JMSEkzUG1CU2Zid1NP?=
 =?utf-8?B?R09TTDlUZkNmZk05UTRDMkdvYWlPZTdHdyttcTBCbE1FMUFlMW15NzhpS24x?=
 =?utf-8?B?NzZ5SWhwZFFZQUxMWmlLR09qL2EwY0xiSDIwd0VzdFhOUnVMcXE0aXRZZXZw?=
 =?utf-8?B?Q3ZlZU16NGU1YTRScitYa2FzbzgwMWp1ajd3UFZBWEVYdERYTGFnMG1CZ2h6?=
 =?utf-8?B?QWhzNlJBdTBMZXlSWG9qanFtMzBTZTNRelNnMHNWNklQSnY0WHFyN3pQOFNW?=
 =?utf-8?B?b1d1VnlhZ2hQVnFYR3lyTUd0UExHNkpoQVluM05wZVEyQXBRTWppUGVocnNC?=
 =?utf-8?B?S0h2UTYwZ2QxODRCQ2ZyeFFIeUNzeXJBTWtnclRBVkg5ZGNzdzBTeTEwV3lj?=
 =?utf-8?B?WlhORUtmQmxOZ0IxS2JiWm1BZUJhN1lvS2pabjZiK1B1a3pJQW9rMHVBK0hQ?=
 =?utf-8?B?bVhaQnIyem5kc2tVNnE3c1NGT1ZEakdwaVMzYUp1T21QTWZyUkVsQSt3WW5Q?=
 =?utf-8?B?bGtSeURxYzRTYzd3SUtQME5FaXZBREVuRE54dXM2NU84UExoVVpwVzNaZzdM?=
 =?utf-8?B?VWJ5MGJhbU1POXdCdDUwWHA0WFc4UlgyaFMzWktkWGt1WTlyZ1gvbEEyUFNs?=
 =?utf-8?B?QzdyQi9xck1WYjM2YVV4cnROQitJRWFaajRoSmlWbDZoOG1sZ1hoUG0wZkR5?=
 =?utf-8?B?ZDlib3hPZE9kVGFYbWFuWWNleTdnUGgwSDk3Rk82TDVLUW9CVjJ1RjRFaEYz?=
 =?utf-8?B?bkNNT2p0NnNPNkp4ekMzaTgrb3BpaFlMSFlwOWo2WlZMUUtyU2ZUcFg2SVht?=
 =?utf-8?B?T0wvSWFjamRreGxaQmJTYTViU1l4NERFOStoN0wrZW1WSnVQZnlRWkxabzdK?=
 =?utf-8?B?QXdFcG5JMm9ya3E0T3BXd2svWnYwU2VqWjVNV0twbk5xOHlJdkhEbUgrVWVn?=
 =?utf-8?Q?lralIYjCrvQG8YwiXh8/Sb3/x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58f8429-42d7-40d5-1c15-08dc83bcdb6b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:03:53.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEtOVCBpt6GDnXVQaHjakzNba3xTwKWKKnHrwu5dTJF9U7U/dRGI4peB3WaTF5gl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774



On 4/24/24 14:49, Jay Buddhabhatti wrote:
> Add support to register subsystem restart events from firmware for Versal
> and Versal NET platforms. This event is received when firmware requests
> for subsystem restart. After receiving this event, the kernel needs to be
> restarted.
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
> V1: https://lore.kernel.org/lkml/20240424095937.2448-1-jay.buddhabhatti@amd.com/
> V1->V2: Updated copyright header in xlnx-event-manager.h
> ---
>   drivers/soc/xilinx/zynqmp_power.c           | 151 +++++++++++++++++---
>   include/linux/firmware/xlnx-event-manager.h |  10 ++
>   2 files changed, 141 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index 8570ab1a6857..c193daf04a0a 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -31,9 +31,27 @@ struct zynqmp_pm_work_struct {
>   	u32 args[CB_ARG_CNT];
>   };
>   
> -static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
> +/**
> + * struct zynqmp_pm_event_info - event related information
> + * @cb_fun:	Function pointer to store the callback function.
> + * @cb_type:	Type of callback from pm_api_cb_id,
> + *			PM_NOTIFY_CB - for Error Events,
> + *			PM_INIT_SUSPEND_CB - for suspend callback.
> + * @node_id:	Node-Id related to event.
> + * @event:	Event Mask for the Error Event.
> + * @wake:	Flag specifying whether the subsystem should be woken upon
> + *		event notification.
> + */
> +struct zynqmp_pm_event_info {
> +	event_cb_func_t cb_fun;
> +	enum pm_api_cb_id cb_type;
> +	u32 node_id;
> +	u32 event;
> +	bool wake;
> +};
> +
> +static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work, *zynqmp_pm_init_restart_work;
>   static struct mbox_chan *rx_chan;
> -static bool event_registered;
>   
>   enum pm_suspend_mode {
>   	PM_SUSPEND_MODE_FIRST = 0,
> @@ -55,6 +73,19 @@ static void zynqmp_pm_get_callback_data(u32 *buf)
>   	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, buf, 0);
>   }
>   
> +static void subsystem_restart_event_callback(const u32 *payload, void *data)
> +{
> +	/* First element is callback API ID, others are callback arguments */
> +	if (work_pending(&zynqmp_pm_init_restart_work->callback_work))
> +		return;
> +
> +	/* Copy callback arguments into work's structure */
> +	memcpy(zynqmp_pm_init_restart_work->args, &payload[0],
> +	       sizeof(zynqmp_pm_init_restart_work->args));
> +
> +	queue_work(system_unbound_wq, &zynqmp_pm_init_restart_work->callback_work);
> +}
> +
>   static void suspend_event_callback(const u32 *payload, void *data)
>   {
>   	/* First element is callback API ID, others are callback arguments */
> @@ -120,6 +151,37 @@ static void ipi_receive_callback(struct mbox_client *cl, void *data)
>   	}
>   }
>   
> +/**
> + * zynqmp_pm_subsystem_restart_work_fn - Initiate Subsystem restart
> + * @work:	Pointer to work_struct
> + *
> + * Bottom-half of PM callback IRQ handler.
> + */
> +static void zynqmp_pm_subsystem_restart_work_fn(struct work_struct *work)
> +{
> +	int ret;
> +	struct zynqmp_pm_work_struct *pm_work = container_of(work, struct zynqmp_pm_work_struct,
> +							     callback_work);
> +
> +	/* First element is callback API ID, others are callback arguments */
> +	if (pm_work->args[0] == PM_NOTIFY_CB) {
> +		if (pm_work->args[2] == EVENT_SUBSYSTEM_RESTART) {
> +			ret = zynqmp_pm_system_shutdown(ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
> +							ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM);
> +			if (ret) {
> +				pr_err("unable to set shutdown scope\n");
> +				return;
> +			}
> +
> +			kernel_restart(NULL);
> +		} else {
> +			pr_err("%s Unsupported Event - %d\n", __func__, pm_work->args[2]);
> +		}
> +	} else {
> +		pr_err("%s() Unsupported Callback %d\n", __func__, pm_work->args[0]);
> +	}
> +}
> +
>   /**
>    * zynqmp_pm_init_suspend_work_fn - Initialize suspend
>    * @work:	Pointer to work_struct
> @@ -185,10 +247,46 @@ static ssize_t suspend_mode_store(struct device *dev,
>   
>   static DEVICE_ATTR_RW(suspend_mode);
>   
> +static void unregister_event(struct device *dev, void *res)
> +{
> +	struct zynqmp_pm_event_info *event_info = res;
> +
> +	xlnx_unregister_event(event_info->cb_type, event_info->node_id,
> +			      event_info->event, event_info->cb_fun, NULL);
> +}
> +
> +static int register_event(struct device *dev, const enum pm_api_cb_id cb_type, const u32 node_id,
> +			  const u32 event, const bool wake, event_cb_func_t cb_fun)
> +{
> +	int ret;
> +	struct zynqmp_pm_event_info *event_info;
> +
> +	event_info = devres_alloc(unregister_event, sizeof(struct zynqmp_pm_event_info),
> +				  GFP_KERNEL);
> +	if (!event_info)
> +		return -ENOMEM;
> +
> +	event_info->cb_type = cb_type;
> +	event_info->node_id = node_id;
> +	event_info->event = event;
> +	event_info->wake = wake;
> +	event_info->cb_fun = cb_fun;
> +
> +	ret = xlnx_register_event(event_info->cb_type, event_info->node_id,
> +				  event_info->event, event_info->wake, event_info->cb_fun, NULL);
> +	if (ret) {
> +		devres_free(event_info);
> +		return ret;
> +	}
> +
> +	devres_add(dev, event_info);
> +	return 0;
> +}
> +
>   static int zynqmp_pm_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
> -	u32 pm_api_version;
> +	u32 pm_api_version, pm_family_code, pm_sub_family_code, node_id;
>   	struct mbox_client *client;
>   
>   	ret = zynqmp_pm_get_api_version(&pm_api_version);
> @@ -206,21 +304,43 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>   	 * is not available to use) or -ENODEV(Xilinx Event Manager not compiled),
>   	 * then use ipi-mailbox or interrupt method.
>   	 */
> -	ret = xlnx_register_event(PM_INIT_SUSPEND_CB, 0, 0, false,
> -				  suspend_event_callback, NULL);
> +	ret = register_event(&pdev->dev, PM_INIT_SUSPEND_CB, 0, 0, false,
> +			     suspend_event_callback);
>   	if (!ret) {
>   		zynqmp_pm_init_suspend_work = devm_kzalloc(&pdev->dev,
>   							   sizeof(struct zynqmp_pm_work_struct),
>   							   GFP_KERNEL);
> -		if (!zynqmp_pm_init_suspend_work) {
> -			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0,
> -					      suspend_event_callback, NULL);
> +		if (!zynqmp_pm_init_suspend_work)
>   			return -ENOMEM;
> -		}
> -		event_registered = true;
>   
>   		INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
>   			  zynqmp_pm_init_suspend_work_fn);
> +
> +		ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (pm_sub_family_code == VERSALNET_SUB_FAMILY_CODE)
> +			node_id = PM_DEV_ACPU_0_0;
> +		else
> +			node_id = PM_DEV_ACPU_0;
> +
> +		ret = register_event(&pdev->dev, PM_NOTIFY_CB, node_id, EVENT_SUBSYSTEM_RESTART,
> +				     false, subsystem_restart_event_callback);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		zynqmp_pm_init_restart_work = devm_kzalloc(&pdev->dev,
> +							   sizeof(struct zynqmp_pm_work_struct),
> +							   GFP_KERNEL);
> +		if (!zynqmp_pm_init_restart_work)
> +			return -ENOMEM;
> +
> +		INIT_WORK(&zynqmp_pm_init_restart_work->callback_work,
> +			  zynqmp_pm_subsystem_restart_work_fn);
>   	} else if (ret != -EACCES && ret != -ENODEV) {
>   		dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
>   		return ret;
> @@ -267,15 +387,8 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
> -	if (ret) {
> -		if (event_registered) {
> -			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback,
> -					      NULL);
> -			event_registered = false;
> -		}
> -		dev_err(&pdev->dev, "unable to create sysfs interface\n");
> +	if (ret)
>   		return ret;
> -	}
>   
>   	return 0;
>   }
> @@ -283,8 +396,6 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>   static void zynqmp_pm_remove(struct platform_device *pdev)
>   {
>   	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
> -	if (event_registered)
> -		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback, NULL);
>   
>   	if (!rx_chan)
>   		mbox_free_channel(rx_chan);
> diff --git a/include/linux/firmware/xlnx-event-manager.h b/include/linux/firmware/xlnx-event-manager.h
> index 82e8254b0f80..645dd34155e6 100644
> --- a/include/linux/firmware/xlnx-event-manager.h
> +++ b/include/linux/firmware/xlnx-event-manager.h
> @@ -1,4 +1,9 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Xilinx Event Management Driver
> + *
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + */
>   
>   #ifndef _FIRMWARE_XLNX_EVENT_MANAGER_H_
>   #define _FIRMWARE_XLNX_EVENT_MANAGER_H_
> @@ -7,6 +12,11 @@
>   
>   #define CB_MAX_PAYLOAD_SIZE	(4U) /*In payload maximum 32bytes */
>   
> +#define EVENT_SUBSYSTEM_RESTART		(4U)
> +
> +#define PM_DEV_ACPU_0_0			(0x1810c0afU)
> +#define PM_DEV_ACPU_0			(0x1810c003U)
> +
>   /************************** Exported Function *****************************/
>   
>   typedef void (*event_cb_func_t)(const u32 *payload, void *data);

Applied.
M

