Return-Path: <linux-kernel+bounces-321618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB552971CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC0D1F23B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF621BAEEA;
	Mon,  9 Sep 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C220X7JO"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73B1531E0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893021; cv=fail; b=jXBuDwkGpuQe/i4CDR4azl2CiymOkXYu38EUXL49JO/q+7Zh6jQNUmwSe/t48FkEQj3OBIGut/FNZ6cq3ykNC8ab/x6a0zPRh/6CaeO3ip5oW5jkG9EbjUtAfMn2QT/PncOQRUF34asHTZg+Htl5BUPHxBlnKKsxbQB2LC1U0lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893021; c=relaxed/simple;
	bh=0p4meds5THBSMR5PwIpR+y8FpyHbFCyd5sSRe1zXLpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfaM5jE73J3LfAXhHV/jdTiomRpJYIafoYiAJKah3BvR0HVR0LDifjE1R8WqYCPJJ8wvDbohqM0UMzsBB869fXTfq62cPuC6KtlZhCwKa/1bnQfAkqLB8uK78z368YO3KODCYk7jf0FUnTRJtvdAW6vVOTgHtcZYuNYS0w8ZV1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C220X7JO; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da03KKXZsRmjnc6+19MqpbfzQ7MQWTL/HPJWMkzDbjI2G871aKyMRmYB+4ytgb0EvWIrz1Leuqb69T/ufgYDJyu8F5YqAUkho1u4hgMKubNKUaFvEkCw1PebzHGrqAQ5c7zKnsgA2LsnbmvQOSZ+lzSl2Lvj7b5sjuebdePFOunnOgZtPqekzYA/GFoMx3pmFJJhU828bQPsNqCtk+0CzrjkXvU4YQBJ30UlYm47VcXrmhhBHpcZLDTkXC8I9tLtsJPhBKcTO1/4asxlHbs4AFFHgycBLDd35IjOf4JytP913bZJnYAYv5ilhPCbxIPvtAu1QFrJ3LQX5keeLSarnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH4h7QZwuJG3UUcMB1ubgI7V5x+arTZjHBkKISVpIek=;
 b=M4tf0Lv3OQTxL/PmY54pJ80ep1Wyth9A7dWwsCjUqoNZo1ItRRLi+VvN0PObxv0StlN2ue5OfE9GS78l/YqXtq8ke5CKs96FMkgZnAHuTcWxrfxUKcxZCOdp/eGXr3FiOX6Dg2xA4okcV1V35/ehX8p1hJI5XohNr07PCcns/JvxE+AX9biU9lMYJ0uyAVfwBEIMidp0WV6BMElcMqqfzc95vDvILlSWxF07f0PZ8JCiU8SDU8ZOgjEbTIKL1Ql+f36lgbtmVdsxQYlmW0NCWl8ScFduGVI49qgbHnotDqqLcsVuF0QbUalY/R+fWNa2EYTEsq9S8FFcu4QvgCxNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH4h7QZwuJG3UUcMB1ubgI7V5x+arTZjHBkKISVpIek=;
 b=C220X7JOou8GN641VPwpjT+dHPgaamyY22wlARWPgbgd4RKIqNAd3upkWhsI2vjrang2/L0NHGfjCagK04w7nNNiAdf7MZEAk9wd3OHMaBvSNMGkcyQAm7fnJTTfgAIie8AYV2KWgk9ZtCs42V1kp+j/lYtX6SfGIJhSNUYjvQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Mon, 9 Sep
 2024 14:43:34 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 14:43:34 +0000
Message-ID: <3abbad0d-2c01-bb57-bffe-ae75e1138a03@amd.com>
Date: Mon, 9 Sep 2024 09:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
 lijiang@redhat.com, kexec@lists.infradead.org
References: <20240829104016.84139-1-bhe@redhat.com>
 <20240829104016.84139-2-bhe@redhat.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240829104016.84139-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0035.namprd11.prod.outlook.com
 (2603:10b6:806:d0::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4a720e-a0c5-44a4-0c99-08dcd0ddc7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3FCejJkaDRFdXRrZ0c2OEVVeVBKamJhditsc3FNRWRITFgxbUlZOGFIRWll?=
 =?utf-8?B?ZUJmNGg5bjVNc0kzTUhPcUozL3pudzV2c0g1UEROVTJjSWtmT3Y0QmZkbUh3?=
 =?utf-8?B?YWtQUVY3eFAzQnk3dEtKMUNGN0xmOTJ3TFAzTmtuRDZYUHBoNFNrRzd6UE9F?=
 =?utf-8?B?bUdSOTdqYWlEMG1vdFM3cmx0U2VWallLcmRQSklJeUhVd1dXUWtpUDgwb0Y0?=
 =?utf-8?B?VlBJNWxKTVZrWFlFbWRaUjRXelhtRjBkWG9yMHN4SHhsYU54N3ZGZGdGZi9B?=
 =?utf-8?B?SnBBcVpmTUJNMDRnaFJKa01CamRJN1ZXOGszaEZhSG11TFBWeDlFRXJrV2ps?=
 =?utf-8?B?SmJyL21QL2FBYUJWMHFUR2VScy9KSzFpNkRUK3VBZVF6WGlvQnVlQitpQ0hv?=
 =?utf-8?B?c0lUV1JzdklmbDFOcFk5YjZJbDQ0Nm5lTzBlV2hhalFIRHZXbnZ0ZDRUWjlp?=
 =?utf-8?B?NWFRYmM1SzMwcVU2b3U3UXpuTDJCSjI5YlZTamYzWGh6NVlGd0NOZkI0OUR6?=
 =?utf-8?B?bE92Ry9haE9tVXBUa2ExNGxMRXNieHNuU0h6eUdnS0RDbnBPZWJETjJ4ZGJZ?=
 =?utf-8?B?bVE4bTF0MEpkUEhZTkgraUNOenJ2WW9XZnhPYkRtWDI1aCsrejJwN2pnbUhp?=
 =?utf-8?B?T3RJSC9xb1p3elh5YU5VZHZreDRQQk1UQnB2UUdYSTllS091aTFSelovd1dk?=
 =?utf-8?B?UXllYW43a0ZTWFpOM1BSVGNvRTFheFNpM2M2Y21ZUUZqTFlEVzZYNkJrcVJ4?=
 =?utf-8?B?YnVRR2orMTVpR0NaYWlmSENUSnYrQW1BcXpqWE5iSG9mWEwrdmhBZXdiMS9N?=
 =?utf-8?B?bHFqQ3lBdUxPYTE0dWFkMnloUFBzWnI4SWppUFVIeGpVd2FUMFZ4WFY2QXI3?=
 =?utf-8?B?bjUxcnZ6VEp2OWNSZTdMUGNuV0w3Q3BjdlQyaGxTSWNuaStjZDUyd3RFT1pD?=
 =?utf-8?B?U3Ria2NYcU1PWm1HVmlMNnYraTZjZ0djSkUzZmJzYVB3SjlaQXlVejBQOW55?=
 =?utf-8?B?T2MyRFRBc2s3UGNoYXRVVEpnRWJDMHlnQXRueTQwYks1M3hJbE9QeWVVbC9U?=
 =?utf-8?B?RTNZZ0FmNjB0VGVhbk5rdDAzZXNxcVRRbGJKd2ppN0g0STRVaVZKRE9UZSs1?=
 =?utf-8?B?bXpiU1VNZXhVMURXczRNcERqTE1ZUzFmMlVWeGhlbWR2dVc0ZFArd1M1Qk1m?=
 =?utf-8?B?dExnVWdRTnAva1dMMWZpYmw2Wkt2aWRwc3hTZ2xmWGxOK3VMbVpLTllFKzhH?=
 =?utf-8?B?OWxiY2IyYnFvU25pNHRsTVNkRVZMWFdPRlFJTGR0SzVoOUx2eE5Eb25iNisr?=
 =?utf-8?B?dHZjM3hTeUEvWXU5Q0ZUQi9rU0NWQzd5alRRSE9GeXFXbGdJbEVtakwzV3Nl?=
 =?utf-8?B?T2dRblcweDV5NStHNEhhYWRZRmkvMjRnV3RiNVVkN1hSbytJNlBvamJyUHRN?=
 =?utf-8?B?Q0VjZW5lSkREREF1RHRYeVV3VzZoZFVLaXFtWCtBRXF3VUdlNnpLZGNEUGtn?=
 =?utf-8?B?NlVMa3FZTWJRRlROVk1XbXhIYmt5ekdieUE1enExSkx0bUJncVowK2tlMENL?=
 =?utf-8?B?c09SQWdYRjFORm5XMTQveXJ1SHVpMGhlTGZKUjlCSXdNenhvclhJOTZNSWhp?=
 =?utf-8?B?QW45RzZabHdBR1VUQ3ZkWm0zNEIwUE45SitBQ2I4OW5ha2o1VkpUcUdjaHFt?=
 =?utf-8?B?cUhnNVZYVlM3cjM2Kys5dDRMQ1dGTjVZK25MeWhkbldTREl3RUQ2cHZ5QUJE?=
 =?utf-8?B?TVFVZ0NQc1BKSWZKSEV4YWpUWVVyZ3NXRHgxaTVRODljdnRGT0pXaG5ZU2cy?=
 =?utf-8?B?NFphZ3h2d1k3eTcrVWtGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3QwWTlSbDhDRitLc085T3RIdjFqdEZ3WENBV2xBT01KQ2VHQ1ZsVldPZmU1?=
 =?utf-8?B?cE03WStkTVNhNW9ZbTdJamRUVG1WU0VRcElDOVdhR0xEU2hXNzUrdW1sL2Jo?=
 =?utf-8?B?UnFXYWV6UStyY1diOVIyZ05BVnVwWFZhckJTaC96ZStlcXM2SU8xZDUyYjRy?=
 =?utf-8?B?VUJiaTliclZHbElrR3hpWGJWTmFGSE52eXZWVEg1RzJqaG5zYm5NTWtOVmdt?=
 =?utf-8?B?RnNCTm54MDFMVXRsdWhFUkZGdkFxK1FrN21vNHpHcnk1bm41VnFMRWRla09i?=
 =?utf-8?B?dUJ5dnltYUorSml1SUk1NHhBU3hleTZ0VkNkQnljSEZ5VWthd1dEYjh6eFZv?=
 =?utf-8?B?TndBbytWOEZ5dU9pazAxcTQ3TlFRNk9NQ1l0d05xVThBUy9hVWtONjQ5ZTBx?=
 =?utf-8?B?SEcvSDRURmRwbEpmQU02UG1QVkpabG5xR2QydldEdVlnUlZkV0hqL3NiNDl6?=
 =?utf-8?B?cHptNlVCVytuR1RyQjk4N1NkbTNJWHN6aVBBR3lOU25kQnl3bGJ1NGszbnZF?=
 =?utf-8?B?bDZGQk5iSUo0NGx6ZEtjdDlHRjF5Zk9GNlRjZ1F3NnRXQXEyajlUYUtTd1Ev?=
 =?utf-8?B?NWxMRy9hZm5pZ01lWUMxWWJ0TktLU2NLeTk0dHhqdHFjM1o0ZUs1UEZzMzdn?=
 =?utf-8?B?SFJNZTVkZllURTJJMUk5YU1tTG1Na3ozZnM1eHlhRWU3NnAzTW9CZXErQkJh?=
 =?utf-8?B?R2k4WWdZdlIwU0VMZUJTVUtSQVpPZTN6a3JMRUxianAvVG5rUUVrcjdPVDhJ?=
 =?utf-8?B?ejRVeXpHL1Avcmd3SUFzbHFOL3c1WjFreGtvZElOUE1QWG4yZHB3cklhN09O?=
 =?utf-8?B?MTAwRXBsS3lpUHhESTZiV3M5VWxuL2tWdjR2UW90SnhBR2JCZGUyR1g1SGdw?=
 =?utf-8?B?OFJMZlNnK2xrNGFsRVBTcitZQ3lXcitSelBEVnF4TUxhNXY2Snkvc0FjSWhy?=
 =?utf-8?B?Y0JQaXk4TmFhVzE5Q0dIQlVOTm9KYmpmdHZ1YzVGdGg1WVo3YWpqdEhRT1Nn?=
 =?utf-8?B?b3ViLzc3cVhYWkhWOS9zeE1UQmlLakhaRE1aNEpIcTlob2FySCt2Vlkzbk1T?=
 =?utf-8?B?Ky9MdWNzd0xqbGhGSEVZOW1VWmtOOGdBWFhvNzJ1a3l3SlNXVU1ZL3lOTlRn?=
 =?utf-8?B?eU15RWdyYUo0UitIVUwyNHNDTWJoQXRzVyt6aXBJMFVESHlvdnliMTBWN3BE?=
 =?utf-8?B?U21KL2FmZjhIY0c0UjExUiszV1JvVmRHMmF3TlJLRDNDUUl2dklhdFdsOTRr?=
 =?utf-8?B?R3RFWUExcDFkRUIwK3RtTXN1TzlaRVNwTGdPaTRJOXUwcFo5aEVtVWloTTFY?=
 =?utf-8?B?cEkxSy9wS05qdzVIVWNZTFI3NG9Hdkd0SUdXUlRwUURHMnNWYVVnR2RmT2FQ?=
 =?utf-8?B?V2cxempMVUgxRzd4UjI1NGpiK0tvTFdJZlpIQ01ic1ZYdlU4SVZTbGFWamtE?=
 =?utf-8?B?K1g0ZVp4Y0hiOUdtVVJNbzlCa3I5M3lzc2dJbkxYUEg5RlRKYVdjQkl4UjRC?=
 =?utf-8?B?UzhvTk80NW92M3FQMFVDQzNpTzlpODZVMkFyMm1aaWNWVnNwbmNTdFllWEpi?=
 =?utf-8?B?RWlDeDJnNVJscE50OVpEVWFieVBMek04YXZ5YWg3Q1czcFYyTE9VczZLZ3Ux?=
 =?utf-8?B?Y3ZtZFROSXo1aFYvZEpwcG5VTlRwOTJnRWsxeGV5N1hnRlpOaTF5TDcwamRN?=
 =?utf-8?B?bDk3YThQVDk5aHV2d09BR1c3cS93RTNlWkw0N0NvaDcyTDBuUHVKNkJoQi9T?=
 =?utf-8?B?YXlkRlY2c3ZXWXBTZnN6Qm5Lb2pReVRiVmtPL1dVZUFuTU9pUkNsWmFXbllX?=
 =?utf-8?B?Y3NiTlNDdlp4NlFhRnpJMzNpY1NSUkU4VnhKbGlIRFdFdHA5NVFRRnJjNWNh?=
 =?utf-8?B?Syt2QWdxRDFLYUQ1UktJTUdIZGFab05zZCtmNnlPeS9PZGNCanRCUXQ2c3BQ?=
 =?utf-8?B?OHJNMFdXZmVPVzF6ZDF0Q1R3MU5lQndYVEhqR2tGUjhpODI5SndnbjB6c3d5?=
 =?utf-8?B?MnpJb2dpSHo2ZnVIRHJ4Y05kTm9SU0NZTitBcWZRSjhUNXNYMjFOd2JqK2FZ?=
 =?utf-8?B?djRMR0E4Ukp3QnQyMUxsd0FaOW5XcFdJL0M2dFhMdGhSY1lTMk5kWFFDYkpH?=
 =?utf-8?Q?+OLl4df5jgj/cazbyb2J6uO0i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4a720e-a0c5-44a4-0c99-08dcd0ddc7f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:43:34.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR4onVyAYOeSkGhC3GZSzoQyNOmtkzV4udqJuvdVg/LISI/8f4fsQwVjEClX3r7Ex74aU9GAXK0SVFMluI3/NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264

On 8/29/24 05:40, Baoquan He wrote:
> In function early_memremap_is_setup_data(), parameter 'size' passed has
> the same name as the local variable inside the while loop. That
> confuses people who sometime mix up them when reading code.
> 
> Here rename the local variable 'size' inside while loop to 'sd_size'.
> 
> And also add one local variable 'sd_size' likewise in function
> memremap_is_setup_data() to simplify code. In later patch, this can also
> be used.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/ioremap.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aa7d279321ea..f1ee8822ddf1 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	paddr = boot_params.hdr.setup_data;
>  	while (paddr) {
> -		unsigned int len;
> +		unsigned int len, sd_size;
>  
>  		if (phys_addr == paddr)
>  			return true;
> @@ -652,6 +652,8 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  			return false;
>  		}
>  
> +		sd_size = sizeof(*data);
> +
>  		paddr_next = data->next;
>  		len = data->len;
>  
> @@ -662,7 +664,9 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  
>  		if (data->type == SETUP_INDIRECT) {
>  			memunmap(data);
> -			data = memremap(paddr, sizeof(*data) + len,
> +
> +			sd_size += len;
> +			data = memremap(paddr, sd_size,
>  					MEMREMAP_WB | MEMREMAP_DEC);
>  			if (!data) {
>  				pr_warn("failed to memremap indirect setup_data\n");
> @@ -701,7 +705,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	paddr = boot_params.hdr.setup_data;
>  	while (paddr) {
> -		unsigned int len, size;
> +		unsigned int len, sd_size;
>  
>  		if (phys_addr == paddr)
>  			return true;
> @@ -712,7 +716,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  			return false;
>  		}
>  
> -		size = sizeof(*data);
> +		sd_size = sizeof(*data);
>  
>  		paddr_next = data->next;
>  		len = data->len;
> @@ -723,9 +727,9 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  		}
>  
>  		if (data->type == SETUP_INDIRECT) {
> -			size += len;
> +			sd_size += len;
>  			early_memunmap(data, sizeof(*data));
> -			data = early_memremap_decrypted(paddr, size);
> +			data = early_memremap_decrypted(paddr, sd_size);
>  			if (!data) {
>  				pr_warn("failed to early memremap indirect setup_data\n");
>  				return false;
> @@ -739,7 +743,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  			}
>  		}
>  
> -		early_memunmap(data, size);
> +		early_memunmap(data, sd_size);
>  
>  		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
>  			return true;

