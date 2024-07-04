Return-Path: <linux-kernel+bounces-241213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219C927854
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B410E1C2253A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FF1B0115;
	Thu,  4 Jul 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CfIYKiL7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C71AEFFC;
	Thu,  4 Jul 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103206; cv=fail; b=i2ue0acTyGuPjJCTqbxZ/E5LzZEBEqXjbQGhyc5DrLh6pcWyC/u6YDzvSy5g3u5PB7YxCNG3YhViPh9q2xt/g1r7yCHcq34cqxmvE1UenhVjDTOaraoln/qSp/rbkc/XUzd8Nx0lLPaAThohjNGsVBrLcMXjd9sgx30sVDlXG6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103206; c=relaxed/simple;
	bh=D1gVIlUUk+88OhtjnWpvJKM3YDrq2X83dizkRW+2c5o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=pUrG3a8u6jZAaYBQ/XI/T6Ik2XIMJ2UGUVC9wXaGbW+EqO0dDqqmenFB6u3BUDHZg+NuRCh+lmJC/z106em7YPuoemEaO7UTBzRSc7gElmnAIZMPtVBZTGrsSz8820YqPQNecRplW+8gbi1Ze7Jc9h0r6ACapiAJblB/QDji8XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CfIYKiL7; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SneeW3tPIPqRO1E+L+HNtmjXM1ERjWfQCTHQgWyVPyPi42K1k6TzAXwTRk2q8qzrbmSxmT32hFGAR9uR2ABVHT01BgiUAfncr6J/F7Tu/9OvEiyjXzWNsbOpkuFpqKtyVlE72ON3i6pFaRKhyDa2cyliNTxoJvRQHjTMxQYRF+FCgC466cTswczhrBW7WhSwQlLwM+OwqwNI0ojY4Fw76Gp8lte5k8NDIJ1zbCFNrUsBvkhzsZd5uHIf4sQAUyU61hxn9bF9phzECXTF3xSRm2F1ddtZiviaTVB+4y8KDvh54qc3Mistuv6rOoyzOfyXlzcAxeOkbXL3laUi8lXNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGjAcWeH61jJWgzFkTeiuBIapNeK4otvI89GhRa3xbU=;
 b=NrHty3nto4FSPTqRUYIffSuI8R6Kp7WxpXmpG/akV3bX3nRCnot+gWYBcnDi638mhKLrhDWygGuQyyBXDUciGVdkg/58SqQV6VxViVuyEtWQp+1RgghoCv/jEB+U4BcoBgGfBNkBDjrGbUM0mdXFQmatCB947wg9nx7wMZ1Dud3CtEAjDA1aauzyVOkahYUzS4LaDzmcOQbYvpgIDjpalVaWVn3TfFnOVIn4rBNIuIlHcHuhID8GEds6vQNgJoVtqgJoloBmSjKKWdKQRZxbephAdMc10JBP9OuT6+C/DXKlUpOS9hu8+BBTpfRm9f/FYfLUHqQujqtVl7EpNUXxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGjAcWeH61jJWgzFkTeiuBIapNeK4otvI89GhRa3xbU=;
 b=CfIYKiL71IwvCyFihejxb+OSWcFFihI0yDgxOMVGbE3tJm7eYjQNJKEIfAtR1g5Hwf3EZoSFajUnaIvQJpRWylFbcAR/XUMxJ0iKfi4iINkNskxd2+twjxtSQcEeOeBAdg8J7W0VIRCAftWQh5fbIVoIjOMlyTrjF6rPaWD2+Gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 14:26:42 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:26:42 +0000
Subject: Re: [PATCH 3/6] misc: sbrmi: Use regmap subsystem
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-4-akshay.gupta@amd.com>
 <2024070400-sweat-playback-3a80@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <1be9ef16-46f9-1312-2a61-4d0038e2d32f@amd.com>
Date: Thu, 4 Jul 2024 19:56:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2024070400-sweat-playback-3a80@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::23) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be0b264-32a8-45cf-f25e-08dc9c35533c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTl0TFh5WDNXbHV6cWhMYTZWN25GVEtKdHRlWkVZdUhkUUIxY0hDb1VwbUJz?=
 =?utf-8?B?UFdFamJiQWRFVGNoOWRGUFlibXhLaGlmbnVZRlBnY1NTczBQY0wreEdIVEx4?=
 =?utf-8?B?WmtsZzBadGM2bEp4anNWcDU1QXlZN0lwRXhKKzlQVDZOR1dxemxFUUxzWDZK?=
 =?utf-8?B?N1NLRnlYY010WjYzZk9qbmxOWTc1cGhQQVhrQnpDL2dhVkx2ZE51RUptZ09W?=
 =?utf-8?B?WENjRFNObUJXek80S2czd2IxcGVlK3Jqb2NvbjlHcTE0T2dpeFMrNFdiaklN?=
 =?utf-8?B?d3RzNEhSMWdnY1c5dUNNWWo3NXh2VStnYVBSajNoQmZFbE4xTlRmbkl6MDZR?=
 =?utf-8?B?QVBzRW5HRjFHQnpiOHdwMTA1YjN4aXpURkE0QzFBMFEzMXJoaFFXREwxL3ds?=
 =?utf-8?B?OS82NS9KTzBKdWlOWFhscVd4VFFHR0JNSEQrRlVYWnJIWEhiaVZZTUxMWTFV?=
 =?utf-8?B?aXZ3Z01DdlRkTytkN01rNEl6QzdvV04zSFhpOWg3RUZYMmJvcWtLOEMxQWp4?=
 =?utf-8?B?T0FsRjdMK2p6R1BCY2JpcnJUaEQ4NWE2dVJpSVVCVTZwb2RuMEJVd0QvME1G?=
 =?utf-8?B?STQyUCtqVEZGZUg3Y3V5TXVRSW1tM0dteCtHQlRWYzlzMGNHeW9rd1RTMUhT?=
 =?utf-8?B?b2F6dDk2RzRKVTFjZUNQY3A5Q0NYZlZhN1Y5aFNWZVl2YU5WTDkwU2daTHlq?=
 =?utf-8?B?bmpLa2dXdnYzM2phaWNsV0tDd2ovd2ZIaEYyMlVBNE1TeHFjelY5VTFLK0hR?=
 =?utf-8?B?dHVpdE1ZTHV2ZmF3anhJa2Q5QXpaeExaSHFWNWNMZDE4YlJGaUlaWkZUQWwz?=
 =?utf-8?B?VmtlTTFnUm9INmVEUU8yYy9xaHFMTXNhdHBDdWFzand0bUJKenM1bDlaK0M0?=
 =?utf-8?B?UHkwSkhSN3JYakdvVHZIUnJKdldvOVkvM1I0NHRKZFcxbTRBa0NGMFlGRGZn?=
 =?utf-8?B?dTR0OWNQQzBrUjBwNHc1d0c0elU4K0NydWtlVnIxMTJ6WDBSSnFFQWNwTzNy?=
 =?utf-8?B?Q1pwbWhQcjRSY1hwam9FY2NLeHpEaE0vUlJXdGYvZktoYm5kZHFaejVHSmRZ?=
 =?utf-8?B?K0ZvMFhvTGlSZE9oUXFKcmdUWVRDdDhNZGJQZUxRUUthcnVqRm5DWXBudVFH?=
 =?utf-8?B?SzgzclJlbzEyOGo5amZwZE5nWlFMUEQ2aDVhc0NWSGVuVVBUU2hRZWZHRTQ0?=
 =?utf-8?B?K3FTOTFiVi9mb00xd0QvbHRBU0VOR2loVUlZYTJQRlR3SUJVS3JIdkpHa3Zq?=
 =?utf-8?B?Y3VGSGwrK0c3SzhUS1MzbjJpQUEzRENmelFoeVRWYVEzTlFCZ3o4N2dIVGEx?=
 =?utf-8?B?RCt3a1BMeVZzdXh0MUdTQm4zMGpDSnFOOHJmZjFPayszMEswd0RrSTJDemwr?=
 =?utf-8?B?aklPNVhJTXFBRjFqQStCcUxraGlIdGRqWG0wYVNqaTRoWVY1VzRNcDFFTGFG?=
 =?utf-8?B?K1FGMHNRVnNCMUtLbUtTM2RBbks0N0N5eGxCK3o0eFN5Z0lsc21xRGhQLzFo?=
 =?utf-8?B?ZWdPR2NwLzUxQ1VyZmg1emIyYkM1UmxVZTZpa0d2WUhFeEFiMS9jYlBKQ29W?=
 =?utf-8?B?MVZJS0RaMXRkTXVZSkkxbEtMWk5JM0ZCWW4vOXk4bitnbmtHUGh1eDBTZXEx?=
 =?utf-8?B?RVRqNDQ3VStTbUE0aFc0aUloemtzUnRzSmFDUkIxNkVDbm0rcC84R3NZL3hJ?=
 =?utf-8?B?L21hK2ovK3hkOXZNMnQ1WUtlNm9abEZPZXBpbTJKNC9lV2kvVDRWUDk1RXVT?=
 =?utf-8?B?ajVOMTBYK1piOHZRdmlSdnR2ZWE2WEVBME1BaUNEc2ZLdS96aTBKWU1Daklu?=
 =?utf-8?B?QkNGd0NJUmpxa0tSQXRHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEE5aGwyKzQ2TEdNZklocEgwVU9xNHdRK1RrSHplbkgrUGc0ZVJGMnNZdlJW?=
 =?utf-8?B?UnJidTl4bmcxUXdZaU9NR1dYZXp2MXZlTlA1YjhsSUtUcWh5UCtaYThrWHJP?=
 =?utf-8?B?UjI2V3IyTXpMUVBHTmNKUWpra1BrNHo0L3U0TSthRmxXcnFCckhnbFVZejR4?=
 =?utf-8?B?ZTN1UVBpSUhiZXdUY3V0aWk1Z2VYVGl5NjhJbXFhc3RUYzFkL0NJSVVmUjBt?=
 =?utf-8?B?dkFFd095cDZQc1hNSDNFRFNUMHdRaXZRd1hOaFhmVVVXWFBrc01FbXg4amhu?=
 =?utf-8?B?bkhCNzB2Qm9xR2hoZmYxRm9sSkk3bDZXT3doYTQvWTNSL3JWUWlaaUQ4TUdO?=
 =?utf-8?B?ZTI5NlBMd2dUZHNQcndnRjE1L1hZWnQ4MFRsSzlOWVBwcEl2MDNtZU9KSDJk?=
 =?utf-8?B?YlJKdy9raU9Ed3FxUFpZU2cwODgvcUhzdTVSc1JEZ0lNV3NaOE1mcFprRG9o?=
 =?utf-8?B?WGNkSlZuRFExWFFKMWZXOVQ1RDVjMDRqcG5HSVErZnF2Q3ZzRUJYUjNQL21v?=
 =?utf-8?B?K1JEZWFFRm1BanJiN0VqQmQwVVViQ1grT2ZSaENIVUZGWWswUWc0T2hqVkR3?=
 =?utf-8?B?c1dTZ09uZzh6dnpmaTNTc1lKWk9RV2F1eG9ackZnemMrYnVLRjR6VG5iME1m?=
 =?utf-8?B?S0FibndMek5oRW1iVG80c283RWRhTTJuODdXeDduekRKRFVRaHpPcTFPL3da?=
 =?utf-8?B?c0sxQWM0aEtsNFFSZ0NYVHdHVVZuWmtleDZoZVlnTGdXMmw2dkRaUzFqV3Rx?=
 =?utf-8?B?Vnl6UTYxRnZmUWtYRGJVQVJVOHh1bGdQTFZ1K2NMd2dvMXVHbVN3cG1qSTJ5?=
 =?utf-8?B?WmQvUlV0QXpzRWhCVXFvZEJyVUFxZnUyQk9jdlphMTJxWU1weTVVV2ZqQ281?=
 =?utf-8?B?NU0xZk5WRHc0WTBIUForUk9EenEyVm1kTmp0elZvcXIyMkpLU1ZreFVsZ2kz?=
 =?utf-8?B?K2pKbTFzL3BGY3pRSU9mUGMybTZTQ1UzNEQzWVRvY0VGSlFTc0VONGRHUGVt?=
 =?utf-8?B?cTdDWk95VFdIVHZyQlAvZTBXS2UrNjVZZkRuL05LRHR1UjRlelpSTGNFYmdR?=
 =?utf-8?B?S0N0Y2FNblB0bVpxUjVVSk5yU3R1cUFIV1h2NzZPa252U2pDTC9FSjdiODlr?=
 =?utf-8?B?T2QxR3AyY1p2TFRTYkZvREV1Y1dhS2NXcCtpcnJ4bDM1cGNFd1NyOXI5c1ZJ?=
 =?utf-8?B?Ny9CVlF0V0VmK044eXZMUldxREpGeEdvaGpTM2R1N0VBWmRxSWxZYVlUVXpy?=
 =?utf-8?B?THlBdkRGNFpLK0lDY2R5MDVBVmQ0LzVJSmQwVklWd0JCM0ZpMjgwaUY0S2Fk?=
 =?utf-8?B?VmRzdHBLVWNwcisrajQ2ME9RdmNpc0RhQVhaRCs1WkZSeTVGbGpPRVdLZUNq?=
 =?utf-8?B?Vi9tZStRbDZOdVY2UW8wZUN2aFYyeEwxR2Z6eENQeFhVUVI1TWI5ZFJ6YzlZ?=
 =?utf-8?B?L0M3NllQYzJEeVl4ZThzV0UrUzE1SnJhQ3A4QkdVV3I1R3kzblNWVVZGbnVR?=
 =?utf-8?B?dFpuc1ova1ZqVUc4Z0E5ZWh0ZkxyWFl5NHdBR2hMOXFEYWQvSWJMN0YyS3ht?=
 =?utf-8?B?KzVpNFVqV2FlcmpoU3B1eFcxZnkrTWpxeWxDcm9ZU2oxQ1B3U2hmMkpjSjNm?=
 =?utf-8?B?UzhJVExNZkNOSUplOHh4NVY2d0pEelZuUGNxb1o4UVEzSHBwVnp2WnpJMFFU?=
 =?utf-8?B?d0JDU2xRM0p3UklBa25GMWM2NTNoNjJRUmFWeWxSN0RxRjRHaW5jRlJxemlh?=
 =?utf-8?B?Wk1HMXNqRFVuR1RyTzNNbzB1WUNueW9hNmQ2T1gxdDhPK1pVbUZGeHN2RVpT?=
 =?utf-8?B?dXNTZU9hMTVvWXgzc01aZDFSeDhJODZtaUpZWUhiaFNFeElocWdoRHpUaEhr?=
 =?utf-8?B?cW02VWRKbkx0dkN4VW9SbEQ1TmZOTnROaFAzTk1kVlk2Mm1kUzJQa2Q2WXNS?=
 =?utf-8?B?Y2F1SmFlZGtsU2V6K0EwZE1zcExGUnpVOEE5bkpqUHRudlROVmdUWlNXb1B2?=
 =?utf-8?B?bHdlS2JFUW5vZTdWZGdlWU9qZ1hNOGM1YlZqaHo4ZVBlSll1Qk5EZ05jMjFQ?=
 =?utf-8?B?NGNBak9vZnFYYWpGUGxCV3lTTGdwU0R0OGlEOWlYSEZzWjBucGprMkRpazlN?=
 =?utf-8?Q?CkQvBiJCYgbLOS8zBFJAtXGgl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be0b264-32a8-45cf-f25e-08dc9c35533c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:26:42.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Lk2k8AVVZGbpzMnUbiOp39XhrWEcMzUCVWu8lHBBN11JZuEni7whwBkeIlv6cqhjHjCm+34HfDXmmeUuVPtow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491


On 7/4/2024 5:23 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Jul 04, 2024 at 11:16:21AM +0000, Akshay Gupta wrote:
>> - regmap subsystem provides multiple benefits over direct smbus APIs
> In what way, please document.
Answered below.
>
>> - The susbsytem can be helpful in following cases
>>    - Differnet types of bus (i2c/i3c)
>>    - Different Register address size (1byte/2byte)
> Is that what is happening here?  I don't see i3c support...

This is a preparation for

1. I3C support: planning to add support, on AMD platforms BMC can 
communicate with SBRMI over I2C/I3C

2. patch 6/6 in patch series, is adding support for 2 bytes SBRMI 
register address size

>> --- a/include/misc/amd-sb.h
>> +++ b/include/misc/amd-sb.h
>> @@ -7,8 +7,8 @@
>>   #define _AMD_SB_H_
>>
>>   #include <linux/mutex.h>
>> -#include <linux/i2c.h>
> Why remove this?
In this patch "struct i2c_client" is removed, so no need for the header 
inclusion.
>
>>   #include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>>   /*
>>    * SB-RMI supports soft mailbox service request to MP1 (power management
>>    * firmware) through SBRMI inbound/outbound message registers.
>> @@ -23,11 +23,11 @@ enum sbrmi_msg_id {
>>
>>   /* Each client has this additional data */
>>   struct sbrmi_data {
>> -     struct i2c_client *client;
>> +     struct regmap *regmap;
>>        struct mutex lock;
>>        struct platform_device *pdev;
>>        u32 pwr_limit_max;
>> -};
>> +} __packed;
> Why is this suddenly required to be __packed?
>
> Isn't that going to cause more problems than it is worth?  And why is it
> worth it at all?
I will look into this and update.
>
> thanks,
>
> greg k-h

