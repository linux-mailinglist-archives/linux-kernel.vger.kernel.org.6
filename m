Return-Path: <linux-kernel+bounces-407121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753E9C691A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C411F23787
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB9A176ADB;
	Wed, 13 Nov 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="msavzauM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211A10F1;
	Wed, 13 Nov 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478302; cv=fail; b=S/5soULQ0Tge2WI1UZU5FM9l5REEb/Uv2aFNOyFBmvWuu7wRBAsimiJ7gv190r3IMnJjpQJVuYzF3ZjtsLB1cRE3dcfTSCSL9WgPufLN33Z1mcBSavKoeeqkG/8qv+U9NcEH/4eSCNq0TFOpdeAQnqVkkBiewebjwi9AQsnsP30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478302; c=relaxed/simple;
	bh=571gUQT/hZKe+sfF3B2vceLl1765gHuHzPqUq1HSnr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fO5Mlp3lWiaZQw8iskXiPvkkgSqUqASNDp/iSR/jZHA76TEcUgMAYaYJfFceDJdSSfVEcalXIQwImhFUcgiEvp74TvtI5bd1a2cwDSf38GGHAS4npmQoOwt17hBtHs3aEMignucjDWn9TYeSUVITxtNNJoBFXImkAfHY1rGuhmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=msavzauM; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8AAFv1uWiUUriipQPpXwSS8ai+urmWQdYwPj3Z4k7zZc/uLAh5r+bxULDk/vhUqbTaaxZj+ViwOWuXAKfMk0xr4F5z9WOcu9Yer2bhZGYQc7KzRDAPMXH2x+x7rpeqvOMyUhYDRVuCLXvwv76U12csTkyVzmc4Fr2r5Ll9ol5mQW3rl17RhxukTfsykQHKLDXBgnVq3C+gNWRiz1UbCVLWxxdLnWwCQXoFR86psYMfb8mKCJHdojuYjtmIzy0C4gi5dIERh5ALis80SrqOemzH0ZJoknJRPFs68zEgoBBzuFrXwOirarxdcXqLSY01grKQWYG9khRghPA/5EjcP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4oAjLSClmmbLP5BkY7NnpUuUSR8AvCmzDvYleVf+Xg=;
 b=AwsSPYPgNeEWz57ayTkrVPPShrTAX7BLELKf4z2hgnGa9Rf5awEGvITVp1plrl+Ufz1E7waqxHQtAWEo/DlVGgGCz/hrlu8kskttZ7FLxx4xN2upHwZybr9POyyVdNJ8Y8BnB6ctvs+mIzqn4LPW/NiDoiheFKaeZonPLcjCmloOAHQKWv6YMPbfZxUeFk7qI/DjH0jhlzmosYqdxH4NMueNDohkXzuKElon824AXKqRnm6ERkwOPDPIYEBWk/o9sf+wXMOu5eqoPfLV/wPw51TCr0iicA/22TWYhcq6TEIsx0t1npdhvxEtPcABMBSQMpkdtLZneYUwRsn5G5oZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4oAjLSClmmbLP5BkY7NnpUuUSR8AvCmzDvYleVf+Xg=;
 b=msavzauMDPmlLsyA2nWZ16i6uYApKmDSS3ylaMCG1FsjdFCzqsHIiE06f+xg3obRyl44QZBRZ16uPu0C759kuWuUdc7uoltxE1RXBDXqD38yZpXtAz8JAsRFAyFzevAiVSZRdhXG7C2MkbsA/khK8/YN5tjuMo0KLanOSA443Wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 06:11:38 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 06:11:38 +0000
Message-ID: <19452eb2-10e7-e90e-fdf0-19269d04e84c@amd.com>
Date: Wed, 13 Nov 2024 11:41:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] usb: xhci: quirk for data loss in ISOC transfers
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 linux-kernel@vger.kernel.org
References: <20241112122104.120633-1-Raju.Rangoju@amd.com>
 <2024111226-spender-saturate-dc6e@gregkh>
 <2a02f0c3-f535-4ac0-d29f-a33e0c45cf4c@amd.com>
 <2024111330-crusher-alike-a88d@gregkh>
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <2024111330-crusher-alike-a88d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7869cf38-6cdd-466b-4c28-08dd03aa08a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjBIRHZRUm5vTjVhSWZFcmZ6QkdtejNpazZZMGptQ0NJZHplK3p1TEFIaFoz?=
 =?utf-8?B?S2V2dkpWNks4RHF6akIrZEwrTTlwTkhCZnMyRTYrUGVscExOWlByQjZ6QjBu?=
 =?utf-8?B?TzRCaDFSTW8yL2FpYllKOXFHc0dtYk84ZWlCV3BGR2JlcDcrOVBkc2NKQ3JC?=
 =?utf-8?B?aWRpdnlrVmFraDh6LzF0RGM3bEhnTkJNTmo5Z3JLdDYzRGdWbGo2ajhkOVhJ?=
 =?utf-8?B?SU5LcEJpRUQ5S1VOcmZtdk9xWWR1OE44VVgzUE1weXhRTEpKZy9rOWJPM0ZM?=
 =?utf-8?B?TlZlSVlRYTN1cFVzMHJEdWEzQTFVSWM2MEJONHFnWWFXS0pBTDAwcUhkNVBL?=
 =?utf-8?B?RVBUbkNaU2lzcDV1RnkvV3ZEUmRoWFlwRmVsakpnMURzc3NPM05ZWXBlZzVy?=
 =?utf-8?B?aDF6U0JOVysvQlEvS05JVGd2U0o5WkxoaWJ5SGxJMTVuS0d0Mlhuc211QkFQ?=
 =?utf-8?B?WGUwb3krNXgwNWM1OXdETlIyNUdOQUNWeGVuYVNCUFJXUDJScHd3OGxrTkpn?=
 =?utf-8?B?RVV1dWtTamllSlREMnplc0NybkM2cmFrTWxvNGRZZkZHaS9EMEp3S3J5Z1JB?=
 =?utf-8?B?ZjRidGRYdkVWelhYdWhqa2h6am9NZmo1eVJhcFp1UERsUko0VDZJYU5QOWNv?=
 =?utf-8?B?azNCMGdaTUtUS3grQlBVRzFsWThEN0VXaW5MbEE4NHk3Si9kU1hhdXNnUlRX?=
 =?utf-8?B?UUFjRmRINlA4UnhORFRPbVhEZ3g1cDRCWDAvWS8rbWd3NVY5Tmg5Qmsza3ZZ?=
 =?utf-8?B?K2xyd2ljTHJYTU4vN21NUVNOdDl4ZU1DaEFadTk5OUk2ck41NDk5MGJqWnV3?=
 =?utf-8?B?L3FyWWwyN2g3Tm5WRGRHVnVESWtkV2NQcXlPYnc1ZHFHUEtMRXdoWmNpVlFS?=
 =?utf-8?B?QlVOd01RQzNxdUU2TXl1Y0RtTlNCamdnZjM3ZzY5MUFWb1JKWkc0UFBmTWVy?=
 =?utf-8?B?RVBRbUtGRUNFKzQybXNFOWZkVVFLcUtQV2F0S1RKSG92ZmszaFFnaU83V0t0?=
 =?utf-8?B?WURMWDRkTXJpU1AvWi9wSU1OUFhpTXhXNFUzbWt1T0M1Zmg2Y2s1UFNBVEV6?=
 =?utf-8?B?NjFJWG1jcUNtSW00VXUzM2I0N0FtLytTc2FYVUczbUNEN1VGK1cySnpEY0dT?=
 =?utf-8?B?bmRFRlkzelo5Mi95cUZvZElRT1Bzd096MWpNRGZyUWIyZDgyc05PMTVjSFRQ?=
 =?utf-8?B?NjFtNlVqVFFxQk5sTHFrYUJERHcrdzBaTk4yRWdYcHc4OVNkOTV5S29OeWla?=
 =?utf-8?B?cUhmR1A4WlZ0UmJDY0Zsc1RKR2VzZ0JvM2Y5T0F6NnRjRXFRM1FxdE4wZjhY?=
 =?utf-8?B?RVF2SVV5TERyL2ZHallrVnltTVZOR3ZWcG9saTc0dGtoM054ZGdSZnZHYk04?=
 =?utf-8?B?Um54ZExhNUo2bHVldy95bDZnUTFxZmd5K01TS0RRQjVTOG9tTkxCem9reG1G?=
 =?utf-8?B?ekp2OFN0TFVVcGpySTZGMUQ3bDE1UU1DL0FDNjdrZGptdGlmSkdhQ3VYa0RK?=
 =?utf-8?B?ajdMVUpIV0Q1cFJ0VWZZWTJqNDVpZjF1aFdCQ3hxeXVIUU45OEMreUQxaG84?=
 =?utf-8?B?VmNpRTZpQW40ZDUxaGYxVHlkckNLa3M2KzdPV29rNTFpY1JaeEZBUWlPRXVh?=
 =?utf-8?B?cUlLNWNxYzIzclUyUFNtOWkzcTFONHRjaXhBL2pmVnoyQW5xMHp5c3J2WjRJ?=
 =?utf-8?B?ZUswNjdXVXAvQVhMSEpVdU5HK1Y1cWhaazNiL3AwYlZDNnFkS3ZId1lDeStL?=
 =?utf-8?Q?XjBebrDRn+9kBSncOlKh7lqh9XEU35WGuy9kM4R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NS95U0NlQnRMdnFzc1p4N2RuSTUvbU5MUmw0UnpTMElhb3ZuKzVrTFVLY096?=
 =?utf-8?B?SGJNTks0Y1ZZckVkNFAva09OcnRZUmV1OGdlMW1iUlZYbjlncE8yaXhQYU9E?=
 =?utf-8?B?bXVkUmtYQkNpYzhXUVlGZUZ3Ym9DUTExbFNBSWlXZlVSdjZnOFVKUkZJc0NP?=
 =?utf-8?B?elFma3AwM3F0ZlorYjZWZ2E2anVDcENTLzV3LzQ5d0FvRDJtQ0daYWtYYmhW?=
 =?utf-8?B?ZjZLZUZrZUwwZWZVN2ZPWGRiMmJwaDMwSUhJRk9tZ00rY2dqa0k2RkxzNERm?=
 =?utf-8?B?bmRmTDVmR3RXM0hkT283UENmVVpKSHMvVVlNdEJXM1dNZ1Fid0o1WEczb3Uy?=
 =?utf-8?B?blZzUTRVdEszT0JDZEpTOEt3M3BaNHhVWktlMHBZZWJtemk4UkxaQVkvcDRa?=
 =?utf-8?B?WWMvTFZHYlIrQW5ucGlmcDNxNnZ5ZnQ3WTMrWmRDSU9LTkkwM1ZNS3U3Ykpm?=
 =?utf-8?B?Vjl4dU1XZVhKVGNmUzZpU1h6MW56SkQrdDJWZFdQallZRUY2OVU4RnduZ2py?=
 =?utf-8?B?L3BEZWtjbytvQ0dkeHlLNmIyOU1zdmM2N240bmR0b1FiR1JNY1kybHlZQ2Ft?=
 =?utf-8?B?NC9UTnc2VDFvejRIdHZDeVZVcFhmWjR2eitVTFloaXRDTGVWYjlLMUpBNUJh?=
 =?utf-8?B?ckY2cXkwRkt4dUp3RUFqN0RpdE9ybmNOUXNaTG5taHZia1FoaVR2dkhlMkVt?=
 =?utf-8?B?a1BTcVlwUlljYlBsN1psZDBwVzR0cGdBcXlvM2Y4MlNFd1NjYnkrUmxsT1VD?=
 =?utf-8?B?NHNzNUw5MkpJbjdwTTFLandrZGpycFZpNmNkdjBmQ1dLVERvcGh1TVBGdjdN?=
 =?utf-8?B?NzEyMnhBTEp3UDJMeEtlTlIwNk9QWmU1UUtreTZTWmZ5MWJVVXFhaCs5N3hW?=
 =?utf-8?B?TkVxSEplS1JpYmZ5MG1KY3RyaVNHdFYxN0Fia2lPbllDKytSMDIrckdHTGdw?=
 =?utf-8?B?R2x4aHdsWnJLNzRjbkVvNFdOWG1qbmhZRk9aeVVsWjJGd0lUOTd2RVlWU3lv?=
 =?utf-8?B?MEpjVGhETFM2QnlGOUlBTmI4YWYzb1FtUGx0bUE2QldKa1VhWVlKWUxESmVB?=
 =?utf-8?B?eVBKSVRuYk1lZjg3blpxSk5na1QzSm1QRkNTaEd4MXcxdnVRNFhJYklNOTZ1?=
 =?utf-8?B?WFJtK1lQcVJnWG5zc1RySklYUlhWYnJ6OWZLcmdyQlgzQzJyb01xcW90UDRX?=
 =?utf-8?B?eWNSWk04ampKSG5hMkpOaytrSCtKWkdRZlV4NlBiOWRBc05uVGJDVDBiSXJ1?=
 =?utf-8?B?QVF1dFdJZUJDMTNsNTArSlZDRUZIWExpeUswUnFwUU1WbHFoNVZoZTBKTjRw?=
 =?utf-8?B?Qnh2UXJyUVluQ1BJV3FucTVjK3NIY1pFY3VBcWs0bWhSenFWV1NncjVMT25H?=
 =?utf-8?B?VU96aC9iVVBsdHhTTUdGWnZ3ZzJLSXJyWnNCRm80QUI1eWZOWE5xQTZVbGhy?=
 =?utf-8?B?ZHZVWUhjV2g5cmd2Z3piYlcvT0pyYkRXUnNZMCtsL2ZGem5HL2tuNDg5QVhx?=
 =?utf-8?B?MlRhNWdCanhzZmx1VkJnb3RrMm45QlBLclhLYWY0ZlZVYUhMSnpETGx2V3BR?=
 =?utf-8?B?UHY0S3FESTJJZ294VGdya3ByRHIrVFp0WlNJdXJrWDc1SlRNYllSSGJrYjFE?=
 =?utf-8?B?TFhCa0RLYXVERkV2SjB6ZTZqTDhMazVQVFVSKzcrVm53N1dQQnRsYXNIUWpk?=
 =?utf-8?B?MWZZVGkxWitqclFNVnh2dXpUV1NkdkdCSmVEY2FRMjNMNnpLcENFcEJVTm1Z?=
 =?utf-8?B?TDZVZ3RlZWxLT1Q5OHZOUzM2QXppWWJVRDlCcVN6OFlNMlQzekRzL1BXNWEr?=
 =?utf-8?B?bjF0dzBidmlpSmtJVURmZkw4bldHNjQzYUhjeS8zcnZPVUVGcWh1WFhEamVI?=
 =?utf-8?B?VGZaVndESEZYL2dxQWoyM3BmUVJ3WHI5SU5ub1crMkVoUkJxMEY4UXAyeUxa?=
 =?utf-8?B?NUF1OFJiNllyTmRWNWRqcTdVeEdDcEpvaDR4bGFrVHVZQXlSOVVYeDI2SHJZ?=
 =?utf-8?B?Q0FhWi9Ed1VGQnZkc0lXSWZnbmlCeG9MbWprbjYxVEdPYzAyZEg5Y2ppdlJx?=
 =?utf-8?B?aXk4bTllRnlnZ0dkZGJNamNQZkltYnBleXhVMVo1NzNiV3BheWpGYkY1bk1p?=
 =?utf-8?Q?3CG1uKhd8TOSwzUWRV1aT13aE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7869cf38-6cdd-466b-4c28-08dd03aa08a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:11:38.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pPCM/s0PsNBQaFDoCwB9sdlm0BndYRR1+isfX4mtpxhovYdqeuLTmqYIZYLEpz2ZzDn6n3ZUQWj0bxnk5NjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939



On 11/13/2024 11:35 AM, Greg KH wrote:
> On Tue, Nov 12, 2024 at 07:02:40PM +0530, Rangoju, Raju wrote:
>>
>>
>> On 11/12/2024 5:54 PM, Greg KH wrote:
>>> On Tue, Nov 12, 2024 at 05:51:04PM +0530, Raju Rangoju wrote:
>>>> During the High-Speed Isochronous Audio transfers, xHCI
>>>> controller on certain AMD platforms experiences momentary data
>>>> loss. This results in Missed Service Errors (MSE) being
>>>> generated by the xHCI.
>>>>
>>>> The root cause of the MSE is attributed to the ISOC OUT endpoint
>>>> being omitted from scheduling. This can happen either when an IN
>>>> endpoint with a 64ms service interval is pre-scheduled prior to
>>>> the ISOC OUT endpoint or when the interval of the ISOC OUT
>>>> endpoint is shorter than that of the IN endpoint. Consequently,
>>>> the OUT service is neglected when an IN endpoint with a service
>>>> interval exceeding 32ms is scheduled concurrently (every 64ms in
>>>> this scenario).
>>>>
>>>> This issue is particularly seen on certain older AMD platforms.
>>>> To mitigate this problem, it is recommended to adjust the service
>>>> interval of the IN endpoint to not exceed 32ms (interval 8). This
>>>> adjustment ensures that the OUT endpoint will not be bypassed,
>>>> even if a smaller interval value is utilized.
>>>>
>>>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>>
>>> You don't want this backported to any older kernels?  Why not?
>>
>> Hi Greg, Yes, backporting is needed, but some of products were released back
>> in 2018, not sure of the exact commit id to quote here for backporting as
>> there were no precise commits that added this initial support in the first
>> place.
>>
>> Would you mind tagging it to all stable kernels. Let me know if the patch
>> needs to be respinned.
> 
> Yes, please resend it with the proper tag, don't ask maintainers to
> hand-edit changes for you, that does not scale at all.
>

Sure, I'll re-spin with a stable tag.

> thanks,
> 
> greg k-h

