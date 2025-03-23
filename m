Return-Path: <linux-kernel+bounces-572934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D797A6D088
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0562816C2A1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AE17A586;
	Sun, 23 Mar 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yfQJJ6pQ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAC433A6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742753655; cv=fail; b=VwPSJ1MC4r18QOGrlao4b/OyHHN3K6mdtYHe4nrw/xNLdZBgybPnIOxfXUvizZNAuf0Lrmt1Cd9qkhXchx0h8txle5/HGiaxKpuGQ3w9/lsty2assrX2kwLs33Otxs64Ik87V/LeJXZsTrI37FhHQVU7iAts2EXtta39UUFV6Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742753655; c=relaxed/simple;
	bh=qIjPtSz++OvhBgZL7MA7SETpQli4TasMJKBhHJedDyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBbUvhSAI2rbU0hbHYjJWq0Xvm/0xuA1IOg5q16LpiM0MA/WKS0hqfjEyWejZaQDUwgSfI1Wnd1lqgdmKR0bJas1DgokuNUJ+kh7Azx6KLM+6P/3A20aORsQRLkGfP97Qda4/qenqxA65+Qs3tI36I181WIrbu2qEwCZC8u5Ark=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yfQJJ6pQ; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ff4jwKXCWe2u/HCpwMVR9mZJorBaaH6HlCZzf83UxOfFok1TW6b2gblr9SpEI7LgPzSsf1xyaechT7Tw4TldVH04mc00Wjx6ImWToJAPWp4qwCFkgoQ53vFCtA9uRiI2t4JtrdL+pQm6tBk984c5r8a3ZTjXXO9aYVSpu4FG8l2A+fXtWh/ppeTGhTlUha8hHOcgUC1ytoa71DyPmaJqdSOy+Gcu2L5OZ+SibaHxeIu5x7mvEXDaIabAvg8eajT6Ayq7UcEMniJhBXBdZvlLTOH9YiNqjmkCYSL16K5m5cpRgwYGBZBnWe20MSx+XP52/RZtnqwxRIXT0xIPmzLNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxkpZZjf4DwCMRXid+pZBZA/+fviHwvMp9MBenU2/30=;
 b=gI10196c/ua00izh4zlYH3lloKO92mVXHalxF2/45Ih4B8Rm89W5J/wHVfzL15mOcEqtHrNLX5SMGqqlrzzl2jd9kHdpyBJm9aGFYilQdCyyzuU5JP/CFYUeBco7Hhpn2Dywt+17TUo8l3IG+DVZicuXPrx16q8YQt9AEPrmzDofer3rSzZLmJb+ft0vz3ljXzcc4huh4HuavUrW/JQc0ZEH/aCRdQ9RJjb1pi9RAeZRZ8Gx5HsBv9U9W8IxHeqeH0NMMnwnC8zGJn9aeodItX4+fPwiwLjmLCtTDcM2xcx24Vlgor0qXoQzG3bVSfrCyvb6QN3SUTIjTx+gChGKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxkpZZjf4DwCMRXid+pZBZA/+fviHwvMp9MBenU2/30=;
 b=yfQJJ6pQOlBx15kKui9t9IqGWYOLkBjcFwo7kQSb5h/rwhIDfiALBSKrBGJfomiceDIzrWinkuACrqywbsMJadqed513n5DDEOKhUqBy/DXNTGBeEGfXhtCsqEUcmltPzfo2C3kiN3TF2ANxwSqhymcOwvYtdZOCldsFTRynMQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 18:14:10 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 18:14:09 +0000
Message-ID: <584d3ace-ca64-424d-b8ce-c2cd54cec8a6@amd.com>
Date: Sun, 23 Mar 2025 23:44:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 09/13] mm: Add heuristic to calculate target node
To: Hillf Danton <hdanton@sina.com>
Cc: dave.hansen@intel.com, david@redhat.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ziy@nvidia.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250321105309.3521-1-hdanton@sina.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250321105309.3521-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bda9c32-f5da-4bdd-c52a-08dd6a368175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhseGZVL2xLY05FWFFjWlQ5NXlHMUZBSkRnRW10cE1OSnRaRVhUUnVTTU81?=
 =?utf-8?B?Smh5T0FZcStJTkpjZGZ3Wm1vR3BlVVE4OUp4TVkzMTU5QXArUDNIUHNSbktZ?=
 =?utf-8?B?Qk16YkxtdGNheTM1MFppd2h0MlFZV0VaVFA1bGlUclJTSWltbW54dERBRHk0?=
 =?utf-8?B?YjYwQS82QmVFSStrcmtUdGhrVnFmbTdzT1RER2Q2bDNpWGdBTmZ4NExMUmFy?=
 =?utf-8?B?YVBYWHRqVUNyc3ViOGs0SnNYMmo0aXFnMDBWNmhiaW5oaDdFTGIzdWRwQWg1?=
 =?utf-8?B?V3BCTUMraG9aQ2lveXM2NlpnWWswODIvU2Z4YmpUdkxJK3lCeEZOazBpQTNW?=
 =?utf-8?B?M1J6UTVWcmhqaCtVeHJENkovZERoMTdYWXRGSGpsOHBVVkdjTHRMYU1nUlJZ?=
 =?utf-8?B?MGM2MDJXN3FTeTExTUJyRWRYUkxNNWljdW53UG5ta2poenRrbnR1R3RvZUFP?=
 =?utf-8?B?VUxoTGhrZU91QmNjajhyRy9uSzVhaW1ic0k2L0xiZkY0ZVpSQkV3TXpOT0NJ?=
 =?utf-8?B?ZnZOVTJxKzdJNDhRejdqK2JlR0lQamFDL2IyWHVpaHhsZks1aUxqK2tsS2pP?=
 =?utf-8?B?U0UwUko0c0pJYVAvSTBLNFlPcThxTUhMbnRudnlkbmVUcFBtZ0ZtZFN4V0h3?=
 =?utf-8?B?VWl4RVZWZE1EZDEyZklXcE1tSEMrVVQrelJZR0xXYXgrcGVuUkxnQVloRHQz?=
 =?utf-8?B?Z2NOOURyZ0NCa3NxNzU5SEx3T0JCVTdBNmR0SlVlNGI5Q2xRRUpHcEdvWXpM?=
 =?utf-8?B?RWo3VDBnT0NUQUNUYXJRRkt6dGlVdnNoL0hoVHZzUlJUYnE4MHIxZnNmblpp?=
 =?utf-8?B?b2pBMG1GaHBTZzBCS1Y2Ky9CSUw5c011VFVOUUp2STVTNm1Ld2FJQlRVbFFp?=
 =?utf-8?B?bVJ6RUZJbHMyR0U3Y3IvYzRma2pTTFB6Q3pUUzd0dFA2TGxYZ0F3dFQvdHJ0?=
 =?utf-8?B?amNRZVJjMFFCNFhtRDNFRy9tZjBLQWJ2MkhHVFAvU3o1Y3ZSL1VtMUhwemJ3?=
 =?utf-8?B?bEgzd2FucllHdDZLNTBITHJ2UW9LRGtUOEVaOFJmbklyb1MxSlNPK1ZiZndT?=
 =?utf-8?B?cjVyczFOSHFZQ3Urb2tkZXZrOCsxYkduemZDeDVlQm1xUmZwbENOWXhQK2JF?=
 =?utf-8?B?VFJRMWpBTjF0cy9XdWFMZzVSdkFQamZtU3hPSHpEM3ZKTVlqSHlkTzN2ZXFl?=
 =?utf-8?B?ajQ3VnZCY25vMjVZMkJzRnZEWTlDbTMwT3ZrRzZmRWdHR2lucHhPa203bkpj?=
 =?utf-8?B?OEtZWC9nS013bk12RVVrMEZmcHdnc3ptMXpvODBkWWtLSklweW8xa29CLzFh?=
 =?utf-8?B?ckhqUUJoQ011V2FHQnZHRDl5U1dGM2x2RkUrdG1pWDBMTGxWT1FYeWJwaDkz?=
 =?utf-8?B?L0xxemxYcFpaMXFvVmVqcDZJUUpaUVp5UG1zdVdtUkVGVGswbTRLVFN5M2RY?=
 =?utf-8?B?YkpFWlZSRFNRMEVLcURLNXJCdEpRa2NBcXBUSDlubWs2L2RlakJJcHRqZmYx?=
 =?utf-8?B?aG4zaDBNYW91VjFCOHZ2S2hwci94NGhGTURtd2VIRnoxaUFuZ24zSzVqZHo5?=
 =?utf-8?B?cWFkcktNdExtWmZXVU1Da0J5L1lQWEtnOCtKMzVFUWV2aTM4SFRibndreXYw?=
 =?utf-8?B?V05VT2U3UVZEdzNXWDJMcXFITTdpVDBqVUxTdU5QMWxTS3RzdjRSZVJXUjJL?=
 =?utf-8?B?a05rWVM2R0ZLUTRTYnFnditBVFFBcWJQZ2tkbW1xVzJmL3FtMDg4aFNvZFA4?=
 =?utf-8?B?R0tJMnNZbFVYOWM4Vld6K29hL0x1dk5sVHZpMHJTcDJDODI3eUNGVngyWUY2?=
 =?utf-8?B?VGY4UjF3dWlXOXM0WW1tS0g2Z2p4U21HdTZvbW51MXlZVHpzck9qTlltcmI5?=
 =?utf-8?Q?NkBFEeJzilnJZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjhPdTl0TGFBemY2SDExaVRWczB1Rm83c0lMQVg3UjlDV1JRdEMwRFFPN2cv?=
 =?utf-8?B?YjVPbEtINitFRzdLTU9PK2psRVlkWEx1VFh3clp6THJMWFkwNDBKMlRzMjJ5?=
 =?utf-8?B?dEQ2bGl1R1VZZm0wcklmbnhVZkJ0QnFnMmJVWlovTldSdUJQZjlIVjRxaFBD?=
 =?utf-8?B?Slc4Qm8wMEtXbzI1S001NGpGckZLQ1lXbDg5MGkrbFVlYVIvYmVIY0JVWHJC?=
 =?utf-8?B?SVZvWmZaRGF6NjBBQjhHV3dKelV1SUhVa1JzRk1KcVRCdFdOMG9nM0YvL3JZ?=
 =?utf-8?B?UFV0ZllkQWtqbUVSbXpxbWZWNVRNNEdCOXl3c2Z3QTQ0N0REY2JGRXNyNExs?=
 =?utf-8?B?c2ZlaEZSNmdRbkE1U2tEdytsNUpCTEFoZ1pXUjNWRFprUldjMGhJU0FYTnpH?=
 =?utf-8?B?V1liaGNrWWVsWnAwUTJGWWhRLzJPQ2hQdVhORHRTeVlRanpNNDNnVCtzamlK?=
 =?utf-8?B?ZjU4WlhHNkYrbmd4VzJhNkVmY3lSMEMvL0k4RjVhYmVnSDU4TUpteWVBaGZH?=
 =?utf-8?B?bUJrdXd1UWhJTGxaWVBZMC9lWFd6cU53TU9NTGpEUlRDNCtFN0NDMWlBeWJZ?=
 =?utf-8?B?bGsvTk9zQjZxZ0FSS0gyVjlhK2JPbWMzTkZNVTY2K1pMWm9mQ1M5dVpybEdR?=
 =?utf-8?B?Mkwya0tqaTcxYVlMdThrUWRKb2x6U05TUlhzYmpsK3R2MitQSGVzVThyL2ps?=
 =?utf-8?B?TzB5a2JGYjNWNUJtNFVRTkwyUEJkSDVjbUd6ckptNWNCWUFRdXJDU1JOOFN4?=
 =?utf-8?B?MG4xWkFDZGtYUHZCWkh3N3NicmVLL0lDUDc3UGdvYzI0T2NuY0RtY21qR1c1?=
 =?utf-8?B?dk4ySlgzbm8xblYzK052dXNJWnpseUJOZnB1ck1WTThrK3dhQkp3YVFRZEtP?=
 =?utf-8?B?U3NhNTJrZnN1VzlQVzZ4clQyU2xoWW9Za3VaaUUrb2NmNUhPeUZUY3N2Z2M2?=
 =?utf-8?B?a2hadDhhbE9kdFJjaWtUTlQ2TnpMN1Y5Wk1waFNKb3NPaWZYQVVDS0ZDbTNR?=
 =?utf-8?B?RnVVU1VtTWhuNXB1WGV3MjJrdDdOWjAvVXRYUXR0UVVZOXFOQ2lTNTVPTkJp?=
 =?utf-8?B?RWFtbnFtajN1QUdIRndsMWZ0MTZCS3hlT0JjUEZwdkdjUFNacEJwUGRSOE5S?=
 =?utf-8?B?WXdhWEpVWUlINGhFeUo4bnZzWmQ2OWNNVHdrVThpWFM4a0NOMk5UMThCSWhk?=
 =?utf-8?B?S2RpMXY5QjNQYlZTbEtaKzBhV1k2Z05JdHNNZEZqQm1qTDdMVDM1V3FkQitq?=
 =?utf-8?B?WlJ1WTU5T0FjYlIvTVpldmgydEc5anhtbHEybEZHYWQ1ZjQ3WUJ1OEM2dHZ6?=
 =?utf-8?B?cjUzMjg0SDlSMTh4a3VqRnpNaXgxVU1RbzVxU2t6WTVWaS9HT05FMklVK09t?=
 =?utf-8?B?WlZvQ0RRMERkU2M4MGYra2RxQUIxVEdMbHJEUjFHSk9sMkdURDFpUngwTFVZ?=
 =?utf-8?B?V3BHRzI0S0srSitTTGR6VThhdnJndWhMVlBZTzJjWU41bWtFazB4SnRXaGpK?=
 =?utf-8?B?dGU1NG1UOUxZM1lVSFY3VnJ5MlhIT2p5aHFqcDZNN01ud1cyVnVGZi90VlNR?=
 =?utf-8?B?ek1yUk5ZOThUU1FsOVhTTCs5QXhKSzk5QlYrSXpUbitOREtrWkNGNit5MDJp?=
 =?utf-8?B?ZUJOTm1HYitWa0dGQzBtWVBqL2JFdEdjMXR2RnlKYUR4d0RlTGZ4WWpHSUFD?=
 =?utf-8?B?TmtaakNMK1Z5K2cyQnNKbGt1N1lKaCtjdS8wUjZ4NTVZL1NpSFZXc3JHbVdD?=
 =?utf-8?B?OHFMSEFXS25OTnJLT29QMlhwTkN5UXNRVWVmUmhYK2pub1ovZWFCaGorUU9a?=
 =?utf-8?B?d1RUL0J1QkVLMVc0WVV2UGtyYVhSWmsxZjFQam9vMnZ0cnZ2MmNGRTM5TzZ3?=
 =?utf-8?B?Z1hWbWsySUZZQWczRC9ZYnB3UGY2bmJjYkFZaHZDeC83VlZwWVN0SnBydVd4?=
 =?utf-8?B?NGF2UkpKU0t1cTBaMWtEMGRHcXc1MGR6M2NsVFBodGhJSDJ5d04ydWNXTWtS?=
 =?utf-8?B?amxVM2VCY2VGU3o5ZTVqV2UyQWNpTzN5QjcrN3AzaSt3TnNYN0xobFdYekxl?=
 =?utf-8?B?QjVtL3lMaFVNckYvS2FmWHJMbWpRaDdrd21oVUJCYzR1ZEZVdXdWdEZkTjRZ?=
 =?utf-8?Q?+WTR3+W37C2ePaKntS4mhFwoo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda9c32-f5da-4bdd-c52a-08dd6a368175
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 18:14:09.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2jDq0X7B+qtkNT9Np4NBCsuuWHYo1Y2I8SYmjzgmfiO9ZF2c1mtNgUyA2yjbjTZhhad1eFINHWfetzEk1Uokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047



On 3/21/2025 4:23 PM, Hillf Danton wrote:
> On Wed, 19 Mar 2025 19:30:24 +0000 Raghavendra K T wrote
>> One of the key challenges in PTE A bit based scanning is to find right
>> target node to promote to.
>>
>> Here is a simple heuristic based approach:
>>     While scanning pages of any mm we also scan toptier pages that belong
>> to that mm. We get an insight on the distribution of pages that potentially
>> belonging to particular toptier node and also its recent access.
>>
>> Current logic walks all the toptier node, and picks the one with highest
>> accesses.
>>
> My $.02 for selecting promotion target node given a simple multi tier system.
> 
> 	Tk /* top Tierk (k > 0) has K (K > 0) nodes */
> 	...
> 	Tj /* Tierj (j > 0) has J (J > 0) nodes */
> 	...
> 	T0 /* bottom Tier0 has O (O > 0) nodes */
> 
> Unless config comes from user space (sysfs window for example should be opened),
> 
> 1, adopt the data flow pattern of L3 cache <--> DRAM <--> SSD, to only
> select Tj+1 when promoting pages in Tj.
> 

Hello Hillf ,
Thanks for giving a thought on this. This looks to be good idea in 
general. Mostly be able to implement with reverse of preferred demotion
target?

Thinking loud, Can there be exception cases similar to non-temporal copy
operations, where we don't want to pollute cache?
I mean cases we don't want to hop via middle tier node..?

> 2, select the node in Tj+1 that has the most free pages for promotion
> by default.

Not sure if this is productive always.

for e.g.
node 0-1 toptier (100GB)
node2 slowtier

suppose a workload (that occupies 80GB in total) running on CPU of node1
where 40GB is already in node1 rest of 40GB is in node2.

Now it is preferred to consolidate workload on node1 when slowtier
data becomes hot?
(This assumes that node1 channel has enough bandwidth to cater to
requirement of the workload)

> 3, nothing more.


