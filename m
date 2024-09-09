Return-Path: <linux-kernel+bounces-321022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6E971368
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222FC1C226B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059911B29D9;
	Mon,  9 Sep 2024 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dlpCD7h7"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301842A81
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874008; cv=fail; b=AL1B3nkHxZTlXJv5162l8i8H7LxEanTk+AlGfrTNQUTjoL78CpDeZViX7fbvGnQC1hLcgm87+nh6gNKX1pnmKyYN+bQQvOXrBD7T38pWTMInaXPOVY51hk4vZoUOLHD0UBpiaJvwIuiHbYPI4Hwk8n3pWPdNLdAlrP4f/aHd5Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874008; c=relaxed/simple;
	bh=5fU5WJ8em5gSNNiAr9MAHpNhuRexXXgNt66u0zlteok=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FvaJGQeeUbSg8VrNT/Pci6bpwYwvabKccAtS7B9vdWYduUbiI0jof9l6UEVLQot399Y+udrRnSzQ40nhcTkvnADTgN7RKPm1PoKcB47O/bvTxA3ZJLe9nhm8Q8TyKkpS73Ph1RYNIZ9dbCSsVOGhNCqneGtm8rokULDchHwUlso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dlpCD7h7; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+FMfaZuwh7mT75CW6x/9Z7QxkDNloM/e7aKlFkT0lYVgnDrZeesB7tHhEKJfqCNPjavzR7M1TpiuT5xnzT3pOIsRPh/IHv3lTo1nPB3hOoUvyAfe7sVPbF6N9yKLnJl7L8afmKfHWo0s1dZdr2N7rTJYwZFeNKn4bJEM1DXAUaPME6oblrCSM5lsr7bIK54Y8ViYDzPvO0V+MC2wwKcChKZrCg+eYiRwBagUfRveO90c/zcYUNAy3sb3z+9gzKf/7klqbMwXmJvFjKshtKoxVqcowKJp31iBXwTZGEpep3hHveHvGNGpmStxqsdgIXl5XS27UtQUF5a4MHC+hVkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMAjrdsigjQP+In8hrMCrNTSdKRBernnHTS7AvmTPfE=;
 b=T/Qceqv1znUUHUW7J5HmhIQ17QsqUjCMhl+hLvEGfBQnAsK2xnfsqK1JaYTUnHHhGP+/wgqucw0jZrTn27hecba35RV1i/J6Rg7pxf1cvcBVUH0rjiAXq5J6ydeu9y3icroZK1bYXLCS73YsGvjJHRGUcgBNQMhqvYCx5tubjTADYtVbvM4YgIp75W9uMGKdMi4fm0IkdjLjasY4z6PStaU5MOPT1zL5DlljEZ2k4XCTTXFpIAXju1ekxas2ADBw3XL0qlygegDoiPqynjru2yoPjtln6JgrqoFUEN/YMnpU1XU3MvogxSgXB1dY7wmN621PhSoIAMCGgy/73JbKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMAjrdsigjQP+In8hrMCrNTSdKRBernnHTS7AvmTPfE=;
 b=dlpCD7h7U7o3gpNZfGJftuhl51jiptLE7CiFN1XxwGTOOSLaNAX0Mh9JCtJ2l0U/vDnqOpNW2LNv8JZ6ydqUq501Fb+NlXPa/KyuiHrpEtft3L0q6wjARxzIdQtkp8OK2ROx897+j+cWsPPbNPujUlrN1t2aJmvXfEpfniKbAfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 09:26:43 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 09:26:42 +0000
Message-ID: <88fa2064-c054-4833-872c-0cf5ff1e3609@amd.com>
Date: Mon, 9 Sep 2024 14:56:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-7-kan.liang@linux.intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240802151643.1691631-7-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c8fc36-ab21-4aed-e262-08dcd0b1842f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0VmZEFOLzZvSXYxNFpyN3RHV2Z6cmVmd0trMWhnSlNFRlR2THExUE9ZeEk3?=
 =?utf-8?B?cERzRDcxZ1VpcDI2SVJPblhxbFhtK2FpWGQ5ZS9YWTdiYWcwSk9VeGthVXJZ?=
 =?utf-8?B?TVI1enhmcHlZQm1mTm9hb2FCZy9naDR0Z3Y4UGVsVktQcmZqOE1TQTE5L0kv?=
 =?utf-8?B?VDFrMHlVbjZNTXNaV2RFRGRQN0NkVTR0ZkovMi9peFY3YUJ5ZzRCU3RCU1FE?=
 =?utf-8?B?VUVYVVVHbzN2R0Rla1M5OStCMWYvSW94ZVFkWlM3a2lHWlM3N0lWVHJ6YnBZ?=
 =?utf-8?B?eGZtTGxaYTBscEk3NHRjc21wUUpQWWhGZlY2UnRhT0wyMStQS25zeWl3Uk9x?=
 =?utf-8?B?Z3BVTlYvNVRyRlV4a0VPNXNnemRmTUxQWDNIaHExNWc4M3FlZE9oOWJqcXVE?=
 =?utf-8?B?dzFzNFVwNGtYOWxhRUVLVmF3ZFRRQ1Fkdm1mME9RVlcvYTZFajh5Wit5OG94?=
 =?utf-8?B?UHg4NzhIMlZIMnV2aU1haXZMRGdCcnVqKzcwVnJwaURoVTFUajdhYVlUN1BW?=
 =?utf-8?B?QzlrRVk3WkVPdHJTZWozTkVmdnRuUGVjNEx0bHYrbEhyTjFMZ2xuSFpJRWFK?=
 =?utf-8?B?TDE2S0hjRnRyMDFqbUdTRUhjNjNBbjlHWUFEL0JwSkkwcDJSN2ErUkpjcGly?=
 =?utf-8?B?N09NSFhPVFRWK0FKQzJ6dFl5MTN4WkFVOHg4M1lNL0czMUlFS3Njakl4ZWdZ?=
 =?utf-8?B?YjhUNTNmNE94dFNQRG5MM3JoTlI1ZzhLNWQwQWxVZnFXNVJrZU1ucGpYT2ht?=
 =?utf-8?B?OXpvam00VWNzcHlkb1lvcllsOW10SWRUb1pKUEI3c2oraWMrcGY5S25aN2xO?=
 =?utf-8?B?aUVUZ1Vxc1BCam5vQ3ltMHpWWXNCL2ZHYWhaN2NTRnNlSUw4V1dNM3FkQmdn?=
 =?utf-8?B?SHhjV2Yrb2xoTmU5aG5yWGNzcHZidkdFVVFibElJWTBWOXhxdWV5UkVlOFhH?=
 =?utf-8?B?TzI2ZFN4eTJ5K0lCTTJ6Qy9uSW9ISEJxdkgrNWRUTHpkQnBRYVFpd1Q3TWpK?=
 =?utf-8?B?SGJIUFVRMmo4UGtVWEZlbW95NFFuRDFlRVpsV05lZnBpK1dnU09vZFV3eGZm?=
 =?utf-8?B?aklucDBWVVhEMXIvWkw0YnlQUW00dnIvZkZKQnBQZEIwWTBXR0JrU0xiNkcy?=
 =?utf-8?B?emRXbkRqTHB3ekpWM005MStQMngxVDgyTWV6dTJYRmNaN3lNUUhLYWdRaGxs?=
 =?utf-8?B?YmhKQ2luYWdaUGd3S1MxRm15L1VRWnowY1ZMNUV4eHVtVmpteHp5RzRkQ250?=
 =?utf-8?B?N2NaZ3lvYjE4N2piWWo1WUdvelNtMXJ3blI3cWJtanZCM2t6OVAwWklXem8z?=
 =?utf-8?B?K0xRS1ByeThKRFE3SFVKengzQjh0S0lza2RIeWZsL2dYeitybEVIT091NWxv?=
 =?utf-8?B?dDVvM3hNK2M5eFk3djU0ZmVWMEloZFhmYUMrVjJVa0N0dTkrRlM0VnhwMmEy?=
 =?utf-8?B?QVQrOWJUbDFPUDFrYzdTandEamcyVVJHcE82V0VZL2txbWxTTDEvQWo1YWtY?=
 =?utf-8?B?ZDg0UXBiaDBKT1BMU3hTaWR6SG1uYkV0V3BJWThoKzAyR1BYdjN4NkVtbU5K?=
 =?utf-8?B?Z1pHOG9mMkF4WVFzd2tBNHBxTU5MR0krV1hkTjFhNXFaMExEUUVKbzN5UU5U?=
 =?utf-8?B?S0pTQ1NwQXBMb1ozcEhudU81QjRyaGhyMjFkUS96Y1orQ0c2bXQ3dXQ3VnVa?=
 =?utf-8?B?L2l4MVJsc25ISUNPMWt6dUlIRHVDRUc0VXVkRldJN2lWOVcvZzdvVnJhcWRu?=
 =?utf-8?B?NVdIdXNYZkJ4UEhDd2xlUktmbll2VU1SemplUXZxa2RmUnlSdXFtbnZJeUpt?=
 =?utf-8?B?Y21VZ3liVzlZQWgwYVFhdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWZ3NElEd1pkSERSNVRDcFQ2bEdJNVhDTFM0U1k1Vm9JNVJSQjRlQWcvcXlx?=
 =?utf-8?B?SVdDbkpKTHRwdlBFWnR1VG1TbVdOTStFVENHTytnQnVXY2l0ZDc3eWdYbmNI?=
 =?utf-8?B?N2NqN0xmaTN6NC9pL1RiME5scmlBNkZXZ05NL0F1T3dCS2dQdFdPOStLN0tl?=
 =?utf-8?B?aW5JdFVwbkFHMi9OYTU3aGxWNkxIcVo3NFZRWUZmUzhQQzBrcEN3dHJiWXRq?=
 =?utf-8?B?WnBtSDVOQXBlTGN4Z0FYV0dwUlc5RitrSHRrbVdaR3c3UEZuS0hLRElCOFUw?=
 =?utf-8?B?UEhaKy9VN1lnVllBaVJmWC9sZFFSOTVLZ3JUenRwUnhQcVFhN05RNmJ5RGdH?=
 =?utf-8?B?bExQUXBYMCtiZmV6OFBraHFPYWdSTXZyZCtlUEhlSWYvNi9hOWZ6N0hzK1Zk?=
 =?utf-8?B?RFJIODgyVmczODFzSlJucUZRODNmc0NURFVkWFBPMjUzOC9vZFZmVFFXY2pw?=
 =?utf-8?B?ZkdVbGJxclZNbnFUUUg0a3REZFFsOXZZeXBLeElWWXd3Q1QwTysvdE1SenpX?=
 =?utf-8?B?Nk5RWlVyZm9tWlJKeEVhZHRHN2xZZTJMMEpyMHhraVkrci9YWVBicHFyekdI?=
 =?utf-8?B?Y3VnQjNDdTBkN001L1pZVDJyemhCT0piSkVDWDRpdWhlUUdaM1IvTmR2UGNR?=
 =?utf-8?B?OENITnhySllKTkZCdzk0VmQxWitWTmZwUE1pSmw0czdjbGoyNEQvYmhZZzh6?=
 =?utf-8?B?enk3RWNvTTAxdXVocjZ4a3F0QzJmTWQxNUJDK1cxaXhwYXVKbXE5amdMZEdr?=
 =?utf-8?B?d0hSUEh5N2QxMWFic0lKR09pdXBuVW9qK1lzdzZjYUlnaGE3eElHZ0hNRFor?=
 =?utf-8?B?d244eGhKaWpnL252NTkwdGljUklKS0h4bDRRKzVMNERWWTVhZGxyeG5rTmlZ?=
 =?utf-8?B?ak9IZzc5eEdVUU9hUnRUUlMyS0FsbEZqeEMvQjlHT2JLVUNJeDRZenFLMk1x?=
 =?utf-8?B?c3lQL08rblVibEYvSVJTSytVSXZXYktBdldWN2l3WFdUUWxmUkxjb295NWYw?=
 =?utf-8?B?ZjUwbTBBRWNIQW8wRlczNUttSFY2Yml1RUY4R1pZZHpnbVhOeEFDWDNjNlpV?=
 =?utf-8?B?Snh0NHBnMllKcVRubGJoZFFiTDRJVFJPRWFES0t5Q3pIYU9zWkdnOTRjZVp1?=
 =?utf-8?B?VHJoVGl4L2sxNzAvSEN4eE9hVTY0NHR2L1ovMEluMlppWjJkdzRKTGpHVjA3?=
 =?utf-8?B?Q2NWQUNZcUdWUTVVakNocy9IRUlMYlA1VHcyNzY0ZXVJQVpxQ3UrLzh0VzRk?=
 =?utf-8?B?Q3ZIcmNxbmlkc0FqQzBucXBHYzdUUVBQQVhDaXVMWlpHUTZWWUN3SVA2MjVP?=
 =?utf-8?B?Lyt5YmlLeUdGamk0eUZCUEVPZnJSTDNWU0V5UjdIZW1tcGJ4UjBYSVdLN1JI?=
 =?utf-8?B?NHhCYnY5K0Y4N1dXNld1eEMyTlZLOHllTjJad2hzNDNpbkdyTFAvYTFKVGpx?=
 =?utf-8?B?RVFIbGVJTFYwT2psVVhaNm9UcEFYR3dhR0N0WmFISGtqOXdJUW4xZXdsRHhT?=
 =?utf-8?B?eFF3VEEzaHJueEMzQnRBRTR4S2NZbXUxV2IxTC85RUtxRFhoRVhTcjR1elQ3?=
 =?utf-8?B?WklzaCtKMEE5TkFNUWlpVDc1dWVnT3ZPZEdtRkd6dm53UFZtbHltU1NTWnZa?=
 =?utf-8?B?d3VBblRxeWMySDg1KzEzK2tEMklUdmljcGcrMDRpK25lVkJOQ1NOc1EvZU9a?=
 =?utf-8?B?L3p4cGcwL0hxVWEwQTVLT2VvS1pMMXVJQVhCZ3g2UFRrWUhuTGhXdG9nMXhP?=
 =?utf-8?B?VVhXU1NxT1JhMjVMN0tXNVpwVVBxZkRRak9nRStnb240NlhZaXNCNnoxaDQz?=
 =?utf-8?B?N2xqZWxnbEV0VUxka0lvSFlHZWk5bDBBQTk5UGcydmFYWHZaQk5lUTZneThN?=
 =?utf-8?B?ZjZSTWFwemcwQTVuNCt0VExHVVVVMWJqUU5PRzF0MjZ4ejdIMDRnQTRVSFVZ?=
 =?utf-8?B?RytjMlhRL1luNElOUGFiTWxEMy9ERmdrYW9sSFBleFRvMmYvWnhzNU5ZMVBD?=
 =?utf-8?B?cElLY010a0NSODhtSHRuT0JQb04rNzhMZUFCUFFMNVlRMTUyUW9rdC9tY3c5?=
 =?utf-8?B?Mi9nS29paWFIMDhzc1pDenJNY1hWem1SMjBDQzRWcVhQWlNPcnduOHc0eWtv?=
 =?utf-8?Q?rQWVGgkjO8wIslpnbPXpQ6JDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c8fc36-ab21-4aed-e262-08dcd0b1842f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:26:42.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pGCDIy3xNgzenYhWNYXXu3K3iyHRVfFqcWA7F175DnmncjA7CxESCmGt88NiSCZKf5FmLOD6Hg8KJJkeOSv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694

Hello Kan,

On 8/2/2024 8:46 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The rapl pmu just needs to be allocated once. It doesn't matter to be
> allocated at each CPU hotplug, or the global init_rapl_pmus().
> 
> Move the pmu allocation to the init_rapl_pmus(). So the generic hotplug
> supports can be applied.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  arch/x86/events/rapl.c | 43 +++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index b985ca79cf97..f8b6d504d03f 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -568,19 +568,8 @@ static int rapl_cpu_online(unsigned int cpu)
>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>  	int target;
>  
> -	if (!pmu) {
> -		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
> -		if (!pmu)
> -			return -ENOMEM;
> -
> -		raw_spin_lock_init(&pmu->lock);
> -		INIT_LIST_HEAD(&pmu->active_list);
> -		pmu->pmu = &rapl_pmus->pmu;
> -		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
> -		rapl_hrtimer_init(pmu);
> -
> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> -	}
> +	if (!pmu)
> +		return -ENOMEM;
>  
>  	/*
>  	 * Check if there is an online cpu in the package which collects rapl
> @@ -673,6 +662,32 @@ static const struct attribute_group *rapl_attr_update[] = {
>  	NULL,
>  };
>  
> +static void __init init_rapl_pmu(void)
> +{
> +	struct rapl_pmu *pmu;
> +	int cpu;
> +
> +	cpus_read_lock();
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		pmu = cpu_to_rapl_pmu(cpu);
> +		if (pmu)
> +			continue;
> +		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
> +		if (!pmu)
> +			continue;
> +		raw_spin_lock_init(&pmu->lock);
> +		INIT_LIST_HEAD(&pmu->active_list);
> +		pmu->pmu = &rapl_pmus->pmu;
> +		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
> +		rapl_hrtimer_init(pmu);
> +
> +		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> +	}
> +
> +	cpus_read_unlock();
> +}
> +
>  static int __init init_rapl_pmus(void)
>  {
>  	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
> @@ -681,6 +696,8 @@ static int __init init_rapl_pmus(void)
>  	if (!rapl_pmus)
>  		return -ENOMEM;
>  
> +	init_rapl_pmu();
> +
>  	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;

I feel there is one potential bug here, first we are calling init_rapl_pmu() --> cpu_to_rapl_pmu(cpu) --> "return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;"
Then we are updating "rapl_pmus->nr_rapl_pmu = nr_rapl_pmu;". This makes the return check in cpu_to_rapl_pmu() ineffective as the rapl_pmus->nr_rapl_pmu value would be falsely zero. 

Please let me know if I'm missing something.

Thanks,
Dhananjay

>  	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
>  	rapl_pmus->pmu.attr_update	= rapl_attr_update;

