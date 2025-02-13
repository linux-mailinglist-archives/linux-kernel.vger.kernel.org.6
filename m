Return-Path: <linux-kernel+bounces-512310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEEA33760
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B0B3A645F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30383206F05;
	Thu, 13 Feb 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pCM7i1s/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F186325
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425193; cv=fail; b=fiNlN7Wg64WttsrNuLMUey03l1gIFf9hQhwVx8T7JBRcwQHEHy9eBBKrXirE3zECbLXqU2uujOLuUE8fqEvIwKfjPhSV3+4/8KkySaZ2k5vQPLkOrsFtxbP5rHH87fOoxVWnbjBouHBu7b1JJOo2bNwc7nNdHdlqvHx7juEz6RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425193; c=relaxed/simple;
	bh=Uxz3PUlEd599iqTMvVpkVoHGXTNHncxk90zdPFebG4Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cvoq1mvSTXHxfAKq9b2Uqof4sBUKwdeSdNKelg1+yUt8GZ5+mUITfABVXLkS9uIG0Dg3TXPk30cr+738q0Vck4cb9rxW/mp/0B3f7roLmhbJAltvczsAUaIu+0TzTs2zekqkLisTbWu4x/X6gACudP0FxF4QvuMwtRgvBtIGqGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pCM7i1s/; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuh1leoN/4mgOfqpW7Ia9PLTkQQZjgwbXlRx2GMx/TkzEEt3tAeL3ofLDdGklwlkkaJPSnWh1hFCO4MMz1dEVYV+Zs6zbpB9lBDVFeZIp32Nikjvk40XWamuEjwT6oK382WCHNFNbJlVBZMW2XFACnISog/SIfiryJ0dxDIvJafwrcRbqiNycnn1YdbdWQPEXUX5mdkrXgvOlb6cElLWzN54NByfurAF0rXdbufGwLjsTOH1+qUiB/jxcYbpg4bUYCihlehAlVBu387sNQ73rgIj8ixHQKhM66j8QW/xw5JK8j+3xEmMSgvcjIS+igUeeGvIW835+M4PLiclsyUccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9L2H0JYB0YVA4euTfhEZEVHDeOOOgo3yl3IhXJ6O7U=;
 b=j7H7xAjyAqcMywN2+00kgovU/Ea7d4Y3so/I4Xc04MXocP/nu8+MXd/s8w1qTHAq1BKZsxt0Oc27/MyDC6elY08db16bVjpiyjEfpsIN0OnJLv58ZEZxHowfsTIz0iZllbYjRB3a1EJgloU0JSV1p3EAkmzbzQNlOgLXj5h2/1np18ugzRTFNB5azzxtc9vKRZdWytw36DdqYb4FKeIG/3EBQ9UBVT8TJK1mxbVdIp0GTlK+0uxkuwaz1FLdJP6uyen/4KREPZNYC8NSzjpHkJBaFgngW34X4etKavUbH7KP1y9OCaaOEwknzTxMPiiHnenm2QIAFVglGylQ+KJBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9L2H0JYB0YVA4euTfhEZEVHDeOOOgo3yl3IhXJ6O7U=;
 b=pCM7i1s/wvPf97fME3KMwz+uLwm6M45H9PWOGh3+HxNTpqpgwmABnyDeXP5IEevEVYhV3d371OVPTj7u2UwzbL3QUlCxlUI2HkZEWgsNnYfNvCmLPviQXNHwIQaDAnux5JepYXw+r1tXmeMsep5gpEAcWS9LN16Masa+1PClFnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Thu, 13 Feb
 2025 05:39:49 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 05:39:48 +0000
Message-ID: <0f9a6f66-7cbc-4c0d-b12e-9eaacdf1bda8@amd.com>
Date: Thu, 13 Feb 2025 11:09:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V0 0/10] mm: slowtier page promotion based on PTE A
 bit
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
 nehagholkar@meta.com, abhishekd@meta.com, david@redhat.com,
 ying.huang@intel.com, nphamcs@gmail.com, akpm@linux-foundation.org,
 hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com, bharata@amd.com,
 Hasan.Maruf@amd.com, sj@kernel.org, willy@infradead.org,
 kirill.shutemov@linux.intel.com, mgorman@techsingularity.net,
 vbabka@suse.cz, hughd@google.com, rientjes@google.com, shy828301@gmail.com,
 Liam.Howlett@Oracle.com, peterz@infradead.org, mingo@redhat.com
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
 <20250212170212.f5coa462p75fuqj6@offworld>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250212170212.f5coa462p75fuqj6@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: b80450eb-1be2-4f22-81ce-08dd4bf0d461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlFCVEdBNUpVcXY2S0RUM2lHOWdHQnVaeDRWVnZvakorUkJKWGd2ZFVHclFX?=
 =?utf-8?B?TnJTRm9FN0N0Y3RxMm5obEtxYTRDWmVjRklJblZJazA2YVkrV0QxYy8vSnpo?=
 =?utf-8?B?cjhudTB0Zi8rTEZGM1o5S1hmQ21XRncwUi8zT25vRDRjNVVGVm9pR2ltR3pv?=
 =?utf-8?B?L3I1aUJOSU9zbFJpbjM4M1l3RzlOTEdDVytlWmlSN1B1RUUyMStpQTBlSFkw?=
 =?utf-8?B?U3lhY2J6RTFwWGtXa2x0aVdVV1FTL3lqM2QxR1hHcC9pS2ppTGlUUEdjVzdP?=
 =?utf-8?B?WlBpY09kNStuVzR0TlozY085RGJrTC9OUFlRQzV5MzhMaTZTd0xCNlRHZUV5?=
 =?utf-8?B?L2xoM0ZlUCtHRG1ObCttd0JYOUNsdmcxYm5ZYXFLT1hZQVhmQ1U0TGFvcWNR?=
 =?utf-8?B?eVJZZjhTYVI3RU1LMFJBVmVXTVpQMWk0cGxFa1JoZ1ZnWDlJRmpoSFVzR2Fq?=
 =?utf-8?B?azRDN0hBV0l2enROVUJWZ1NKeExZcThGNUJWcDdTTk5EVitqZUdDMm9tWWhl?=
 =?utf-8?B?ZUYxSXB0YkozS0F0YmY3UzZWM09nUkRudU9vZzdMME4wZ0ZIOHZUczFaakx4?=
 =?utf-8?B?YW4wM2t3cVVEV0N6cGc1RmJGZTZPQnhZNkRhQ3l3Tkw0M09hRkROdFp5MFlS?=
 =?utf-8?B?Q0FVZFREKzVWNWdiZkpBS3ZJamxrbEZ4MEtEdG0rS3RWU0kzUE9ma1VYczdU?=
 =?utf-8?B?Q0Z1ZElBK25wR0Exb2pBc3N4a0ZrSG0yQ05ORDNBVlV6L2xwc2JxMlEzRE9D?=
 =?utf-8?B?N1V6L0VmTW12RnVHUmlidndCU0h6cVBVYmJhVHg5L05vSEJXSDhNRDQyNVhj?=
 =?utf-8?B?ZUVzd3psTFN2S1ptMloxL3JabWg5UzhoU1Jqem9CNSttak1udXpxV1JGZXBu?=
 =?utf-8?B?UVNSck95dEI5NmhKTzVVbDY3TnVWNjhPektOdXR5RldLTytyMG01Y2ZjRG1p?=
 =?utf-8?B?R2cwaU1WemdHdGcwdjBITC9CSWdQT1ExZ0M3VWRRYUg1VXZ5RzRaWSt4aGlT?=
 =?utf-8?B?a3V6UlB0U0tYOE5xVVNCdXhXakVpS0ZiWUIyRHRnZWF1aEp0RVBNQzY5cFp3?=
 =?utf-8?B?Y3NGSVphRDg4MU8vUjRTSzBEeWpoMTF6aVFuZzBpMTh4dHZSTllxL1FCZlVK?=
 =?utf-8?B?MTB2R29vcmdWMzRoa2VNU1NZM1BoaFdBS2plajQ2ZGhWZG1DMEZxMXNkbGQ0?=
 =?utf-8?B?MlZHamF3WS9NN0NGcVJCOEI1ZnJPYlAxdTVlTFFEMmdXbytma0FvSHFncXcr?=
 =?utf-8?B?Mjl4MGpwbjhMOTh0Ni9UZ2liSCtQZUhvNzByQitrdjBsbnRMMGdGNGhzcnVN?=
 =?utf-8?B?bVRlT1cwRU5ZY3hrY1lDUXR4eEphMTAzVXMrb3pHWFpzRjdsWUFxbVRIRkRm?=
 =?utf-8?B?RnZkUTF4T3dmRjBSdE1URDU1QjJmaVlWd0IwUG5ycVZqWjVmSmZzNStkeWNX?=
 =?utf-8?B?bkF5ZHpMZGsrWFh4MTBFS2hxNllPQTlUUkJNSVRPYjlKQUN1aEtzWTJtY3Bj?=
 =?utf-8?B?MElpYnVvK00vQ3BvKzhEUlAzNzI1WGxIQW11L1IvWFk4V2I3SjdncjdlMG8z?=
 =?utf-8?B?bkl0Q09lYzdqNjBVNjE5OE80emZIUkkraWdualZBanpMWE03N1AzTVFhMHJm?=
 =?utf-8?B?K09NbjZTaTNhd2puNXRtZXFEVmxlSUhNU2IxQ2dHaHR4anlFbXJ4Sm1Sd0RT?=
 =?utf-8?B?blQyU0trWmRNMUwyazlBbTFjWXdHRC8xMTl0ei9RQ240eGZ4amNQWEQ1eEdQ?=
 =?utf-8?B?UEJZUGYweGpDdkRqT0RseHMwalpxQkZseGRoc1BQSWg2OGZWV21HRUx4bGNI?=
 =?utf-8?B?V29OcTlXK0tIUDNuVVd1VjZaZlYwUHhLWXZiSjVFZXZISTBHVjlObnJiWFJF?=
 =?utf-8?B?c1Rsb0FyQUhZSEg5Y3RSTFdZMGtYVnlkM28xSlNmMWRIa3dmcEt3RTlseHUy?=
 =?utf-8?Q?++6CyLub9Ug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1k3Qk5tVklRMGt5QW5XRWJOR0pOYVdodU8wd2lQbnI5WWRaTG1xemxjN1VT?=
 =?utf-8?B?VEVZOXJZNVVTa3lnVlE0NFBvN1M3Qi9mTUFOQWc3YkQzTGh0RkVza3VjakJJ?=
 =?utf-8?B?eVJSb0tvOUxQaFJOWUEyckJYTmVZcXhNbTdzQ2NwU1E3RnZnVU1HOUQ5cWl2?=
 =?utf-8?B?SHUxSzRUd3VCVzVTZEJPcVNkS1BCVHJmeVVzVVRhWUZyMk42c2xRZU5KUHhE?=
 =?utf-8?B?M0d5N0NQbm9iLzQ5c3hJRGFPVnFDb3dWdCtRMnZxdXdaZFM1OG5rNHo1WDlW?=
 =?utf-8?B?bXM0dzBVd3JyL1cwNjN3V3RuM0NRZ1BhaHFTcXRERkR5R0pGVEpzSXFabVR2?=
 =?utf-8?B?Q1ZFTTlNVFROQ0dsbXZ4dDNSNW5BTWpUaUs0Qm4yVkhHQXhERGpmZWxVdTQv?=
 =?utf-8?B?ZC9WQ0Q2czNiTmNxNnhUWUFiN3FzWkxWbUdyVXVvYWw1bU1pRFlvL3h5c0Fh?=
 =?utf-8?B?TS9ZTTdFYzAzNlN3cVJCeHo3cm5Qa0NCSnYrS0Q0TU5wZzltY2ZTOVUwdnZZ?=
 =?utf-8?B?L296OTFCaW01R3RQZnlFUHd5clMzdHd0czZaMGhWMzJaUnl2VUJQdmZURFZH?=
 =?utf-8?B?TmdwV0lDWVFXL05SNHl1VzJMZ0JkU0ZwVjRDRlJyeGFKMXY0UWdOcDhpV09K?=
 =?utf-8?B?NDIzMmYwa0lhYll1MWh1aXJ1VDcwbXMzRlVQLzJva3ZDRkI3TkYzcXpuajZE?=
 =?utf-8?B?QktMelJ5SG1qcU9iSzB2b2Q5dWdxK3N4SCtTSjJqZlk1WVQ5M3ozS3h6dGl6?=
 =?utf-8?B?M3AzRGV5cUFKTC9CdU9vUHorYkZCaUNqUHpaRjRaUWZUY2tqTlJqeXpsWWo4?=
 =?utf-8?B?d3o3bkFORTFFRUJobW5SNWJ1MXhMeHFrd3hiOTBQTS9PT25yTVI2YXBUUmVV?=
 =?utf-8?B?dWxTSnVZT21pWVdHZUNPOWpBUkUvTkQvbmVmaEVHYytMc29maDQ5bTNyRW55?=
 =?utf-8?B?aVE1UkxQV3NTT2wycjl1V2hMd2pzbmRaMkl4Wm1vaWhNL2JWT3VhVDJHbDBS?=
 =?utf-8?B?a1MrUmpQRUc2WHRFcnBKS1JRcVQzeDRQTjk2bDVteCtxQ2RZSUtxUk80OHJG?=
 =?utf-8?B?VksyYUhrVUZRbVhMSGxxcWZRRk0yZmFYMkN2WFNZM25ObW1VUC9iYzAydmcx?=
 =?utf-8?B?bWZLZXduSnliME9NV3h6Z25jK1lGQTNHcXhRMlUvZTVHN2hnQVVieVUrRGdI?=
 =?utf-8?B?MC9UOG1VRDZ5eGViNkY2U1NUM1VHVmFONjFNNWoxMEVWOG5CNDl4SVZaQldi?=
 =?utf-8?B?SWxrUXo4MW1rdmxkb2tCZnN6c0dXQWQ0Sm5YaDhUS0pLWWpNU3BVZjU0UHZk?=
 =?utf-8?B?RjlZa3RBYTRiMFZ5di9wQUpVQmJLajhtdGtUem41d3huVXI1QXRJazBTMmdm?=
 =?utf-8?B?RStoRThEbnVrdE1XaXptcVN4ZGt5Mjh2dWNpeHFLUHhKRnF6OUc4V1ZlRjlV?=
 =?utf-8?B?bVhhZzYyYVdpTjh0cTBQRXlsWmdGcUhBbk9uQ2RtMm94UEFsRmdudlpSNFM0?=
 =?utf-8?B?TjF1WGRzTFpaNktuOGoyeTlqdVZKalRwYVdCZUZaZUhkYTN6RW8wOWVCYVRW?=
 =?utf-8?B?OXo1NjM2dDgvRGNBVWFhMVJ2NTRNakJTamdCVXZGOTdSUkY3RHE2YTFsNE95?=
 =?utf-8?B?b3duRzNiS0JxUW9VSXV1dkxvbWE1RmhxQXMzZ3Z6K29LazFodWwrS0RnUWpC?=
 =?utf-8?B?SDNwWHM5YnBEZ1lrQWErSC9ZZGo2amRVdVdRSUNWUFgyRkRqL2h0NlpGU1Z1?=
 =?utf-8?B?VDlFMWZFRklhS1crNjNwZUdpcjhFKzFNTzI5RXZLaVpqNjZmakpUVGdlb2d4?=
 =?utf-8?B?aHd1WGhXOWVkbHBzbVZVZ0tPanFwakNRMitReU5IWExxNHR0RVhjSXY5Ynpa?=
 =?utf-8?B?NUNNQTNsd3A1TmJSUEZ4Mk9TUDU0Z2NDb00xM2hvb0wzZ3lPcDduNjN2ZnBP?=
 =?utf-8?B?RWNOOCsrUDlrWlhtZFg2cXd4SUtoSFlTME11dWhya25YdnZWalg0b3NhKzJU?=
 =?utf-8?B?NnM3bzVkTVhyR0ZraVBlRmRnMDBmNkxCbXI1WEtzMWszaHdaaEdJRVBBNmZp?=
 =?utf-8?B?MVY4Y2tWM3hUR3VFMW5ZSVJFb2twQ1ZrdU9tWjEra0xLWHI5Q3JHaWdmK1Ir?=
 =?utf-8?Q?excosZDxwEEtXPGKZqRqVkTSY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80450eb-1be2-4f22-81ce-08dd4bf0d461
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:39:48.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb5FxgTpoCAAbW9B2Yq765556MBxBOSAFKhpfbBey+6Z4rt57j7AV2jXDawHr2Z4WLSPfGI/kFO6ThHCj8izOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279



On 2/12/2025 10:32 PM, Davidlohr Bueso wrote:
> On Sun, 01 Dec 2024, Raghavendra K T wrote:
> 
>> 6. Holding PTE lock before migration.
> 
> fyi I tried testing this series with 'perf-bench numa mem' and got a 
> soft lockup,
> unable to take the PTL (and lost the machine to debug further atm), ie:
> 
> [ 3852.217675] CPU: 127 UID: 0 PID: 12537 Comm: watch-numa-sche Tainted: 
> G      D      L     6.14.0-rc2-kmmscand-v1+ #3
> [ 3852.217677] Tainted: [D]=DIE, [L]=SOFTLOCKUP
> [ 3852.217678] RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x290
> [ 3852.217683] Code: 77 7b f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 
> 08 30 e4 09 d0 3d ff 00 00 00 77 57 85 c0 74 10 0f b6 03 84 c0 74 09 f3 
> 90 <0f> b6 03 84 c0 75 f7 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 5d c3
> [ 3852.217684] RSP: 0018:ff274259b3c9f988 EFLAGS: 00000202
> [ 3852.217685] RAX: 0000000000000001 RBX: ffbd2efd8c08c9a8 RCX: 
> 000ffffffffff000
> [ 3852.217686] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
> ffbd2efd8c08c9a8
> [ 3852.217687] RBP: ff161328422c1328 R08: ff274259b3c9fb90 R09: 
> ff161328422c1000
> [ 3852.217688] R10: 00000000ffffffff R11: 0000000000000004 R12: 
> 00007f52cca00000
> [ 3852.217688] R13: ff274259b3c9fa00 R14: ff16132842326000 R15: 
> ff161328422c1328
> [ 3852.217689] FS:  00007f32b6f92b80(0000) GS:ff161423bfd80000(0000) 
> knlGS:0000000000000000
> [ 3852.217691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3852.217692] CR2: 0000564ddbf68008 CR3: 00000080a81cc005 CR4: 
> 0000000000773ef0
> [ 3852.217693] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [ 3852.217694] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
> 0000000000000400
> [ 3852.217694] PKRU: 55555554
> [ 3852.217695] Call Trace:
> [ 3852.217696]  <IRQ>
> [ 3852.217697]  ? watchdog_timer_fn+0x21b/0x2a0
> [ 3852.217699]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [ 3852.217702]  ? __hrtimer_run_queues+0x10f/0x2a0
> [ 3852.217704]  ? hrtimer_interrupt+0xfb/0x240
> [ 3852.217706]  ? __sysvec_apic_timer_interrupt+0x4e/0x110
> [ 3852.217709]  ? sysvec_apic_timer_interrupt+0x68/0x90
> [ 3852.217712]  </IRQ>
> [ 3852.217712]  <TASK>
> [ 3852.217713]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 3852.217717]  ? native_queued_spin_lock_slowpath+0x64/0x290
> [ 3852.217720]  _raw_spin_lock+0x25/0x30
> [ 3852.217723]  __pte_offset_map_lock+0x9a/0x110
> [ 3852.217726]  gather_pte_stats+0x1e3/0x2c0
> [ 3852.217730]  walk_pgd_range+0x528/0xbb0
> [ 3852.217733]  __walk_page_range+0x71/0x1d0
> [ 3852.217736]  walk_page_vma+0x98/0xf0
> [ 3852.217738]  show_numa_map+0x11a/0x3a0
> [ 3852.217741]  seq_read_iter+0x2a6/0x470
> [ 3852.217745]  seq_read+0x12b/0x170
> [ 3852.217748]  vfs_read+0xe0/0x370
> [ 3852.217751]  ? syscall_exit_to_user_mode+0x49/0x210
> [ 3852.217755]  ? do_syscall_64+0x8a/0x190
> [ 3852.217758]  ksys_read+0x6a/0xe0
> [ 3852.217762]  do_syscall_64+0x7e/0x190
> [ 3852.217765]  ? __memcg_slab_free_hook+0xd4/0x120
> [ 3852.217768]  ? __x64_sys_close+0x38/0x80
> [ 3852.217771]  ? kmem_cache_free+0x3bf/0x3e0
> [ 3852.217774]  ? syscall_exit_to_user_mode+0x49/0x210
> [ 3852.217777]  ? do_syscall_64+0x8a/0x190
> [ 3852.217780]  ? do_syscall_64+0x8a/0x190
> [ 3852.217783]  ? __irq_exit_rcu+0x3e/0xe0
> [ 3852.217785]  entry_SYSCALL_64_after_hwframe+0x76/0x7e


Hello David,

Thanks for reporting, details. Reproducer information helps me
to stabilize the code quickly. Micro-benchmark I used did not show any
issues. I will add PTL lock and also check the issue from my side..

(with multiple scanning threads, it could cause even more issues because
of more migration pressure, wondering if I should go ahead with more
stabilized single thread scanning version in the coming post)

Thanks and Regards
- Raghu

