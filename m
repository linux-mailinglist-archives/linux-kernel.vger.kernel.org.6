Return-Path: <linux-kernel+bounces-230102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388C917865
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86021F234EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582D14A602;
	Wed, 26 Jun 2024 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xrpvKfed"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653E139D04;
	Wed, 26 Jun 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381323; cv=fail; b=M6akyVxXVLZQcs+u7Cc88brwXa2+rm6F2kxXsGnOiQL+l/K34aTOiIwxtEy8osh6DoPgARUu63n5F+Xzhv63wQYwA27kf4duhWUoeGnXTJXuY8AKsbf9w06A81+jD/ZvPKVcBSXvDyxAS1Of17n/2gQfbDneQZEQtV6YarjNaQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381323; c=relaxed/simple;
	bh=mwkR7osQkWO9RH81eF6mzyw+76+jMhBknANhDZamiZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhUJPWS1AhL07UWlGvey7DOJevy0jzIXucaJz90SR9rvav06Miwt593bOIQp7XkSKS7ijEXXGhtbAKo3b/9ZtGPXKcGRz50TprPvh7tjccS0dez5c/azjo2mw36Hd3aDE4ky7Y5FTFROAropi2KtNoHcbTeSmKej8SDZmr81+Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xrpvKfed; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2ugFBZISrYYPzLyiyJ1X9Ye/W+3HOIeTG7wmjgYj05cQe0X0FtpLua/O+m6W+qhbAg5ixD/finOewNXK4BGNnYHnZhmaw/d3RZ6BQ/qYupB98rkDEtkFWUs0yFUKuhoDzzV4pc4s9YduA8VyBSQwVO3Zyb7zc2AtsnXIYfIdzEOdTt9R4+yq/vR81R8X8PPG6FFrcVAbnrgeVDAjQi3ucWekyGmWf1Yng08RsEmYvCZX9GljGSGgqV23WKK2163/fo3++HIoeSh7/66DeZgogMeSfU9ylO5rjsyD4b5urOTdAQkjLjbO7ySawCdGxcV1sAVXEU3TXHOBtdUqsMJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nITemJqEtoD+iInxH/xBw/EfvioVNu00lBVnjAGsGM0=;
 b=EgvKO/bul4iupBVtA130BFXKiQUhJrfVLYNYhVhq2f8Z0x4/1cMNKEd3nAFvaG6y/jWWFkp8EdAYfCptZyyr0xYC7MeTFTKowaGhgUv6RnUb8C1tWkTW/ddG3j/PXUV3YHp9IIc9RwDSSj2DzSb7tYD0yPgCH2gi8ZII4GH6tpPHEroeOuSsldZNYCSWDSNZxYEpPQ35tW8ZzPsFh7h46dgi0D6cz48VYPE3JqHpVoUjDMdTDRltZ7w+QTOX6ZOq6kJvRel8CqAGbohaqdul14Z8e72RNhd/3UKHnOE2nf0O+Jbqdg4NXFjFA1NlG4bDU8/Sk2bvxzcQ9q34os4cUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nITemJqEtoD+iInxH/xBw/EfvioVNu00lBVnjAGsGM0=;
 b=xrpvKfedoSx92EMMgdqyu5QFH5rMfx83ufIDugXTHexXACFAdKiTnHZdVYfv3VL/RkAUjK16INM9ShYdhfl1pjC0eAiTCoWa1vVTbFa4zif1ptKUFrjqdLtaBH86lF3DmFQvOuO9WjiOrbt8ttj4oq9GZQMZdvGsrrukFnut0HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 05:55:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 05:55:19 +0000
Message-ID: <0e571211-8921-4548-a093-6c5719c866c4@amd.com>
Date: Wed, 26 Jun 2024 00:55:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
To: Vyacheslav Frantsishko <itmymaill@gmail.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org
Cc: perex@perex.cz, lgirdwood@gmail.com
References: <20240626055131.44014-1-itmymaill@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240626055131.44014-1-itmymaill@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaa30a8-a859-422e-ac25-08dc95a48f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2I0VFpzMWNOM1FFQWlyeXF5aVN2RUtqNXFrUDFGMlBDOXJDU3REdW9lcHlw?=
 =?utf-8?B?cjhQM3hyL2JmSEpRbDBqOFZSaUs0bFE4YWxOcWVyZ0h5ZEY2bVpjaEJVcjBL?=
 =?utf-8?B?MDFvQkN4eURJenI3Y3VqYWtrVmhNYU04QkpDU202NktpY3k4K1B3YW9qVllk?=
 =?utf-8?B?MnRtUElDQmJQa0xkS0pvSS9Ic3hYWis1akVCNXpWcU9lUkRyTUZLTDdJWElR?=
 =?utf-8?B?eXpSYmZMbDJ4bGxuenBzYTNVbnVoUTl2TlBuWG9SelZvN1hpT0U0REJONlNO?=
 =?utf-8?B?R1dsLzJTMjU3Njg2VHpSMnJrTlBBSjhuYzF6ait2bVRqWFRBSEpDVEcrcG9R?=
 =?utf-8?B?S1dpRUxpckk4K1BhUEQwVlBva3lFbUFQMUlKZ1JxZC93ZkltT2t1dkwxa3ky?=
 =?utf-8?B?NDBGTlAxQXZmeUVucEhOb3Z2MnIwa0xNNXJCTGswbFVQTTJBR0Z6Y1RZL2Zh?=
 =?utf-8?B?NjFiK0hoNys4R3ZyZENWWmNySklMZ29vK20zQ0pIOUtaOEU0NER3MGowQ25D?=
 =?utf-8?B?MHhFOGNrelE3VDIyVzlxOXVYSjVZOEswZ1h4OXdDQTdjSTdnRG5ZT3FRMkh6?=
 =?utf-8?B?NUpwQVJsVjJFQ1BJNjBNd3g2TXA2YkJydWFaclVMUUdTNjBsckkyaEVGaTIw?=
 =?utf-8?B?Z290S0ZVRXkvU25OSEFIRGdIRUhzZDNZbi9HS0FuMnlXcjN4elZvem1XUG9I?=
 =?utf-8?B?TThVQjY5TkFoQTBvbzBqcTZ0allMYVZobG5FQkliRFJpVm16c3lxWUdXNzlJ?=
 =?utf-8?B?VER2Y0lRRFNWSXpQLy9YSUd5THVodStWQktzczVmcWtCL2hJZXlvMDR2U2RQ?=
 =?utf-8?B?M2RxY1BFcUZYNWhMRkpKY2Z1NjBSK00wbnhpZkxwd0RESFpicVVUazdZeU5o?=
 =?utf-8?B?WVVGZTE1aWwzMWFaVTk3R3Bia0wzbG1jSXVnR0c3RmNpR3pncXplL29MdVg0?=
 =?utf-8?B?emlsVW96WW5xd2NIQkI3elRITHZXei9qVXFQS21xdklMaFVNZmcwMEZUQjc0?=
 =?utf-8?B?bi91aUJYdkFBK2pTTk1UMVcybXJzWDVYODBNYnk5YVhVU2tGbFJob0dBSzJX?=
 =?utf-8?B?aWJXRnlXdjlRRmhQMU1Mbnk5WSswVS9XYTg1UUd0bGNnTGxkWm0rdUtwVzlu?=
 =?utf-8?B?ZVdQdk1EcUkwVHJMSmdQeWQ3TWFkQTJMUFVzdjhLajFlRk1WYlRLK1FyQXB3?=
 =?utf-8?B?WXZDaWlsN2d2bVJtV2ZqSEN0UWNuU1liTExqbkxIejF1QjN2MEZTVGxqdFB2?=
 =?utf-8?B?UEZtb0J3cE03ZVBXVmtUdktjNjBkZEE0QzNHbXlWSTZweVpHZTl5cTJNVXdC?=
 =?utf-8?B?NGF1djNmSTVDUEh1L1hFMEcrckx1TSt6VDJUM250UXV2dHBmNzZ4eENiL0w1?=
 =?utf-8?B?amNzS2JUSEhzOEZRdE92SDY5ekVsemVMeFEycm84T016R1NRVDcrM3gxWHhu?=
 =?utf-8?B?MGhOc3haT3R1SmY2SEdWZVN0VnJLa1VnbUxLUjJZcG5abnV3clFMSzY1Sy9H?=
 =?utf-8?B?OHVsRUFqRnFJR0RUdWZycFhSS1A5ZG84dzVqMGtMSC9RM0IrSmFQUmx1a1la?=
 =?utf-8?B?MzBPMGIxSWJIQmtkenRPYW83Tmd4UkdNUDNORmtZUGhkbzZ2M2xGendyZXZN?=
 =?utf-8?B?YVBJOVhIV2xpNmlzVlpyTE93bkhMLzZvTE1LZDM3U3dqVmpMZ2RHMmRPSkVj?=
 =?utf-8?B?V2ovYW11dXNRbFZSOXJ3b2lweFhWc2dOVk1Rb0ZhOHZGczVSSStobFRUZmhC?=
 =?utf-8?Q?yM1xigNVFWFg8DcQvA/8VTZ0aTKQIhJXsu6E4Fv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWMyYUIvSVloM3dxRmwzb043czlFQkwyYm1JZy9ZYjE0ZWZkUWZjOEMxTjR0?=
 =?utf-8?B?VHYxd0xBaUZXcU5idmp4YXQ2WE9aTDd1NlQ2TW9HNVlUcmRZNTYrQW13REZC?=
 =?utf-8?B?cnpFamx3ZFJjdWduRS9EZm9KUHZYT0FQdXB1dExqc1JnaXF6cWJic3hYaVFL?=
 =?utf-8?B?TFRiUTZCNnRpQ1AvUEtOOG5OVTZydnRvZTREOUNQbi94T3ROSUZDN2FHMTdZ?=
 =?utf-8?B?Y1FWMERROWkwS1FZRnVVb0JGYW0zbml2RlI1WlFscmkvNUpQWWZnNFBwYlFS?=
 =?utf-8?B?Zk9mczFCekFBYmlRalVVTWFZSzVXVUo1QnhteFJVbTROZmx5ZEhrM2ZLS2lB?=
 =?utf-8?B?ZXV2T2RrKzJYeVhKUzExRkhoM2ROUkdDaFM1aThFK3JpVEhVSmNxRkJ1ZEQ1?=
 =?utf-8?B?bUVqWFBnNWdvdjliTWFwS0VScFhEWjI0aWJmWnp3SDEyZlJzTXI1UXVJWE9B?=
 =?utf-8?B?cGNESFZOZzFZa3pPWTg2elZxVWhFeWxQUlBvQmxna2RLbjVsaXFob0l4MVln?=
 =?utf-8?B?aVZJZDVndUt4K0VVM2VoUDB3d1oyR3phKzdJWnViaXBUY2xQL3NKdDRMczNl?=
 =?utf-8?B?V1kxVGZ5emxMTW9IUkovenJwVlI2SzZQNXN6YWNBdE0rM2grbjFWT2VzN2pE?=
 =?utf-8?B?UmowTnlvWDdFZU5kbDc3c3BuSDBlbE80eVpUNURseDBKSGFHMkdwQTVRS3BC?=
 =?utf-8?B?QVJQNTJ4b0dPQWNXRkVWd0U5R2RORVdrM2ZNeXpMNkhvNml4WWRDOVk4NXYx?=
 =?utf-8?B?RUI4NkFnR3ZIakl6SC85Z25LeGZLZ1ZhYVV0czVhOU15RDNUUnh2N1hDQkM1?=
 =?utf-8?B?OVlybzh0d2pRS25rcG5tbHZ5QlQ3eUZBbE5FSHkrcHVjRURGTVYwcWJJdTFq?=
 =?utf-8?B?dVlxc2ZWZkp3eDR6T0srdXlFeEFyWHVNUzlFdkFnWkZwMkJEZlM3bWVVR3dt?=
 =?utf-8?B?ZU5pZG4zRW02ajE0dkZlRkpEaThDWWV5cXo1SDhLQnQwKzB5dVpLb21CeWVk?=
 =?utf-8?B?eXlabzJWMFVXZ0NDQmgxSzl5VVdwSVU3NVM1VWdVUDBLRWdrb1lrdSsvSkNh?=
 =?utf-8?B?UkJ6eSszTERPeDhDTmtPbmFJRUh0SExqK0VMSjBjdnM2bWdpTzgzS3BlL0g4?=
 =?utf-8?B?ZnRaK05XNjhTZ2tUcUVNLzFVU2tyRy91T2RUNEQ0MGlrRHFXQ2hyZ2l2cTZo?=
 =?utf-8?B?eU96M1piZHAwT2JuVG4zYk1JK0ZzN1BiMWNJRkJiM29WUUlPZ25RWmI4akR2?=
 =?utf-8?B?SytzNjJrem1oMzFvbm00bjBpYk8vN3BiUExhTDBJNG5OTmZIb01haDhQR0Zv?=
 =?utf-8?B?aTVXV1ZYenJ1UEs1TnpHMlhpMzJid1B1Y1lLZlJRbytYOHRMVnBLQnp6Mi9j?=
 =?utf-8?B?MHBxbjFVbWdoODM2N3VrSzRUVnFmU1FGNWk2NlZkeGRqZ3BMWFdnT3dXc2x3?=
 =?utf-8?B?WWRjR3ZQVElOMGNmK3d5SEsyckpMZUVCU3FwNEVDcEdhTHh5MC80bCtST1NR?=
 =?utf-8?B?L2h4azF6M0ZzSmtHWG5BRkdVdjNmWUFXUDBiZjl5Q2swZEhkR1N4bk5mUGVw?=
 =?utf-8?B?K2lOVUROZ1YzcFRUOEFDWm5mcnFudUFEWVdEOHIrZXFNVjBFSjEvenhXUGxG?=
 =?utf-8?B?bE0zYW81elR2UmYxd1B5L0krSGJGck1peThPM2Z3MmtLTlhCMWhwWERoYzZ5?=
 =?utf-8?B?Q252S0d3VFRjQUQ0TzE3NjlhNDR0Vm5oeFRUT0FMdEQrU2V6d1g4OTVxRzEy?=
 =?utf-8?B?a1Y5YzBVd0JWOFJ4eXg2NU0rR1NXUitHTnNmdjVSaFlzVkNDM0pvc0V6eGM4?=
 =?utf-8?B?aTZoZHE4UEJwZmttaitjUVI2NXljbGNKRytxUDdLemI2diswVjJ3RzFvdDFJ?=
 =?utf-8?B?STdvdENwOGNoSTBDRk1sVE5FNVRaby9CdndYZ2tveENoZ01HM1ZsbGJnOWpF?=
 =?utf-8?B?TGhnQ0NxRDJiT1Z6aXI4K3lPUWR4RnhmcFpHTEpQeDlycEt1OEJwVGlUTDBF?=
 =?utf-8?B?MFVaS2xGc1ZjbXNsc1NmVDhCOVBUdU94bU9VSEpLR3lKR05jS0gweUxkbUwv?=
 =?utf-8?B?UmZLTlUvSFhXWEpRUWo5L3dFbDdaMEZmWG9OdkZIOWFpZmxrS2FzR3FxZWla?=
 =?utf-8?Q?HxOmQTxmzVNpBkGABflM3UGmT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaa30a8-a859-422e-ac25-08dc95a48f7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 05:55:19.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKL5DkfcArpfdmPB65OWTqqdbAxrCdYrvZdc/YxmTc6zIZkGzfVCnfOgUioLawBUAJswXPcoLiUFHupqE3kZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

On 6/26/2024 00:51, Vyacheslav Frantsishko wrote:
> Signed-off-by: Vyacheslav Frantsishko <itmymaill@gmail.com>
> 
> The Vivobook S 16X IPS needs a quirks-table entry for the internal microphone to function properly.
> ---
This is a Ryzen 6000 (YC) product, so this does look like the right 
solution.

Your SoB tag is in the wrong place (should be at end of commit message), 
not sure if ALSA guys can fix that while committing or you need to 
re-submit.

But the content looks fine to me otherwise.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index 1760b5d42460..4e3a8ce690a4 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
>   		}
>   	},
> +        {
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
> +		}
> +	},
>   	{
>   		.driver_data = &acp6x_card,
>   		.matches = {


