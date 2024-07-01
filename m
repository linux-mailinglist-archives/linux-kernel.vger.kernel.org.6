Return-Path: <linux-kernel+bounces-236103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481E91DD75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B07B21F48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08013C80C;
	Mon,  1 Jul 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="ZFTGc2by"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2138.outbound.protection.outlook.com [40.107.22.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC5376E7;
	Mon,  1 Jul 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831952; cv=fail; b=DDZ1eXMusL+8rAxHwD3fcC1QEPQwyGNK/Prb5BdnNGW99ofLU4XC8+ZFI9aDgIys/O22JsF54FScvbg21oKbEMzKB45TF109eOlBlC40XG7Tur+dXqXw3F8oyh1egcwGoOeSKXSy/wQkzIHv1Izj7EsOUOmsqYHQNAk01J3iX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831952; c=relaxed/simple;
	bh=DQnzlwwEm2z7s8Y8KLKdh05AlcISvo90izfzquqv3jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmFAqaj4KgNxwrnMcITqjENA1Gym28URHugRz3zR8Eu/QVici6a90buBSsCnarIqAopBffRlgpkvTEiaYUwr4Taz6UgWyAUkucFlyZ3DhLwd9tKHx1kdmgMFAjGPEFMVmuJj/xcWPEskXCcXqWgwravsnEmdoEBeE0WPlJ6h1zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=ZFTGc2by; arc=fail smtp.client-ip=40.107.22.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTf+B/BtoRodCFTSSQSC3xEZEGH//FrsJlMOoEhI5fOxVMsWZ9Ir1aDr9DnCqxK0ATM3AEZHudYkqsUI5sncOM2lHT00pyIURkeaxLYEEukuiX2Bimxt6NIbAY32lv5WYfRjl7c20wbMwnqiQGdrdoyLqfu5b3f0x+SfqJqsFsWWCFG3FhyHgxf3jr46Wk0bc2frHY8e/vKNsFxfAvZdfwtJ0L611ZBRUYTvUom1iwxuwgF/U9Eu+tZz76UOlR9I9WnrE+8CDpr9gvIlFHau6RjJLN4ErEQJFbyALFBnRHzXeBGF/szmBrf0WOnTfvYRacW0vDx7C9vV9dB/3zXxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo6yuuZ/VdefsmaAbEkcZmaDVSHlqkfN56TJfu3NbrA=;
 b=Gm6miMVJbpsB+nTjGwsD7y/YvNjy6/vCj2hEvU/CRP8mHmQPcwtJBuyiXs8oPolDD5nGiXjn7rF/W5IdtJctWZBhm8pPl/e8W1b6ysP9uYkvQuFVSZ7+4Gdx+XO0hxtDVxfFcyljbnnzDGZ2OPs+wuIFWHYplWIr5FmvsHeIQCj3TKI83MJxuYO0RE+1E4lRUjsh2za0N5PVbM0/VwvIh/4FIys6O/mFb+0VsQE3i4kQXXS/RIAjDh4gY3rdp7pR8faFZf49x4t6udqB7DdxTrkRjnzyL3l+pgpA1eTXP9ZCf2Vj9Si1DOx+lakG8eQLRiT+zQ/v9qKcPFfkqzKGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo6yuuZ/VdefsmaAbEkcZmaDVSHlqkfN56TJfu3NbrA=;
 b=ZFTGc2bynxHjyeEuiHz2quev0YNJI6MHeacOZhMpCd4Hnilj1Q7M5D6AD9yAHmCQrHlURR8jWTrNL1tQZzBs3s5Ps1yqueNMnlMV6pqoBCaZqQh/SO5xnAkmAbqfIGk5bjp5covtnyvr+Ds3pVPLisfdkbdyz3K2wZGFaTq9lm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:05:45 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:05:45 +0000
Message-ID: <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
Date: Mon, 1 Jul 2024 13:05:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hwmon: (amc6821) Make reading and writing fan speed
 limits consistent
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-3-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: f8240978-f562-436b-efbe-08dc99bdc15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjZtb21nUzFDWGFFSStyOU5wS3l1bXM2UXZzUTZqcE5SV0tQQUhzZkVXNng3?=
 =?utf-8?B?TkhhejRpWWJOSys4ZHpuclpTZFJsdXNIV004N1RmcDZyRUY0cWJzMGhWZUhm?=
 =?utf-8?B?azFaVlFJbVZUUGIvTkdoYlcyMm1nSHB0aENiREJXSkl5U1RQVGpJcllXS3Uz?=
 =?utf-8?B?Z0p2NmNNTEM5T3MwWHdGMjVvYlduaDh1QXZ6OTIwbjhWRk1wYVBGR2ZEWFky?=
 =?utf-8?B?RktKVitSUjQxWk9pRWNLTE43T0FWL3pxTGpEaXJGVnlNMmxISUFhVXNkSG56?=
 =?utf-8?B?T3lJTWlvWmdIZjR2cGhEaWZjcW5HN0RvQzkwTk0wcEozeVgvRUNzM0t1WURD?=
 =?utf-8?B?OUoydTlISHlsbmRIa0s0OTlPU2NxV2tpSzBjdi9JUmpLaDUyb01rS29sbXFa?=
 =?utf-8?B?Sk9iRTlKTU0xMWhFcjBBMkNNQ3FjSjJXL0dDSXBkRmxtc2syczhuV3pkUUk4?=
 =?utf-8?B?MzA5NmtaV01WQmhKdHAwNzJmNzRrdlNCVVZPZ2VpRHZWS1JsSnVXcHFOWklN?=
 =?utf-8?B?R0xNNFF0S2xJbHZsZnFnT1VlY2ZSaDAwZjRKaE9hQ0tTL25HOUtta1JpaXlL?=
 =?utf-8?B?bHczU3ZuUnhrUWszU2FNMW8zUlZrVmt5dFZTakZPTGl0cm5kc2ViRklpZ1hl?=
 =?utf-8?B?bFNucTFNaS9TR2lrL3I4bmlkSXpVTVZ3M1R5YWJvWUkrR3VOa3RtaEN0bTdY?=
 =?utf-8?B?K0hZNjBSb1NWYWNBWFBBYTRXRHE2V0pFUDhHM1ZJYnE5NVBaektVUlFXSlRE?=
 =?utf-8?B?UzYwbi9kMW9BUjZ6dDBJREJPYVlkRXlpYkozbnEvckNSaHA0amZaRHFyRDcy?=
 =?utf-8?B?M09xM085eEVDSzNaVVBwbk1ZVVMwNWZxenZJekQ2VGNIUGZmcFlkWUN6cHVD?=
 =?utf-8?B?SU5CVTZwdXdJeGZ1WWxqVS9LWG9qazVLRFBBeDI1eXdYeE1EVWFvcXZTd3RP?=
 =?utf-8?B?QkRpcVZ3MTdWdTRLNGdWNmJkYXFXZHZFY1lTOERQZTNaQXcra1l1eGxGT1lK?=
 =?utf-8?B?YmJvcEFvWEJsSWJhUDFNS3FDcG5NY0pTMXpBRzZHYy8xdXdseHpWTHlHOGt0?=
 =?utf-8?B?YUlpTlV1TFBUR05XS09MSVNlNFVicUdTZHZFcUt3azFOODdsUHEvT01TUWp4?=
 =?utf-8?B?aVozdkw5Q0JrdFVBSzhWenc5ZVJzQ3B0MGRxb0hhNnEvMjVLRW5zWUdIKy9w?=
 =?utf-8?B?aUE0R09lbDlkTzcvZ3BJWEpWNkhYclZDTzByV3lyNWJNMG9BUkk0QVAwejdQ?=
 =?utf-8?B?MTdPdjFlNUVkdllwcVRUMnJ3VTNlam8rQU9WamxqQlZTWVZOVjNxZHp3eUo5?=
 =?utf-8?B?MlVVZzAwVGVOVFFpMGVGdk5CWng0cmcvWkJ1SFhaUGhkNGlNWk14U1BWai9V?=
 =?utf-8?B?aUZDOUxCSHczbGdwRTIwNzBkTnluYUNLVTdlRU5vTWpsQnc1Z1RXbjhKOWtY?=
 =?utf-8?B?ejdhdEJEQnRvSURvNEFkSmJmTlFid3pEalpCOTNsaVdKdDFRQVpXZzJVdUVy?=
 =?utf-8?B?QnVGWm9aRzJjLzVTN2VQTXgzaEw1UmI5eEpUT0U4R2NjOEdJRkxGVVFoTy9U?=
 =?utf-8?B?SHBxZ0wxN01sa0FRNlp0ai9HUnJRMTJLNHYwNXQzdFF1NmlIMzVzSU1WSDEr?=
 =?utf-8?B?SlZmN044ZExYZ3NoMHVZdlFsajFheDF2UmlNOS9adUQ3ejM2Ly85TzdiazhJ?=
 =?utf-8?B?M3VyRndMYzJGTFQzZzJKRzMwV1BHK0NpOGhsVGtLUmtIaml5VWxCdzlidGo2?=
 =?utf-8?B?Uk9BQjRvMnduMloxeVdWMGJnU2VTbExEb0dHYm10ZGtMYzBKTytHcmJZRWpW?=
 =?utf-8?B?Q1gwMmYxYlZDenljR2k3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUVlU29LTGdjSElJcmN0cFhwbTQ0VWRmVHMyeFV0ejhsUUhsUFMwT0UrM2dX?=
 =?utf-8?B?c0xaSUsrV1VLUlF3RDB5RCtXbjloNTNGM25qMkM2K3kzUTYrRnVYd09kWVlJ?=
 =?utf-8?B?dHRLWjdGcjFNRG1tVEJiZ01rVXV6ZFFVdzdSSTI0NTViNG1MN0dEQ2RURmpE?=
 =?utf-8?B?YXBxcjhoTmFCVmpIazgzb0NnQmNJYS9yUjBJcHVkZUhsdzM1SWhYNDhyZ2xv?=
 =?utf-8?B?LzBzMHRZOS9UcHhacXBWaU5EK1VaUTlFakdzTDZDWG8zVEEwY0xZWG5xWlRl?=
 =?utf-8?B?Z1ZiclB2NVc0aWYzeDVWbjRXZnJNUGh6YUFhbFkyRU9XeHd3cnJOU1ZNSUo1?=
 =?utf-8?B?YzJjL2Q4TzVPUGJ6b1VPeWJ3UFdqWEpzVFdYKzRZSjlHS2E1NHRabXFtTk1Q?=
 =?utf-8?B?TzU3bkxwNjVHblJRcEFPN2l5TGt4WVZ4Nk5ERHNLSVRDSWdqUERFdHpaUkdx?=
 =?utf-8?B?SXBybDd2dTZNNHFIandMakRqRFhKb3pvdlZydmpNeFBGdDdlSUVjOTRCOFBD?=
 =?utf-8?B?NHdodkdVVDMyZWQ0VHMxbmIwVzBhMlp2WERGWjBNaGgvK214UllPYkpEQ2Fs?=
 =?utf-8?B?cVludG1YL25JRmlsTVVEMkduQzc1a1d0VzQxNjlueVZkYkFnWXFBMitOcFZN?=
 =?utf-8?B?dzVVclJZblBTVkpKUFUwTlBRZXNNTjgzRFdyTHFjVFJXdUZ3cVcyS1hYeTA1?=
 =?utf-8?B?L3dlWkFXSzFUNnhvRVc2ZXFpRm9HTUdLSitvS3g4YjVwZlg0cHE1V0hWTVpa?=
 =?utf-8?B?ZDl5bllQRE9Lb1ZFeDF0blQwaTkyZlNkYzh6aWR4V3dDMGxveGE1RFZBbUJ4?=
 =?utf-8?B?Z3hnQVNQWkdOMWJzWHRiaXhPRlUxTkZENWxVN0RMa25jQUJBcnE0L3FkVFZ0?=
 =?utf-8?B?MXpCeE5vT0R0Z0tNc211NzIwakt0bGZZa21ta21PZmlDY3NjYU5LVzIyVEQ5?=
 =?utf-8?B?aC9NYzBoTi9yeWFEQWFOOERnbXdoVWdkRHh2Y3A0YWx2blNjTGJXL2J5enpp?=
 =?utf-8?B?T2xySHVaKy8wTlVYblFIY3FBUHA0eHROaEdIVVRqbEpVK1ZGL0pQaVBxY3JJ?=
 =?utf-8?B?aHFRV213OTNuS2g4Uk80eHVYQmYyVlI2eENSRW9FNCt5M1JSajRDRjBoZGFM?=
 =?utf-8?B?T2IzRFBaaVNmbWlvc0tNSmQzMUpYMDRZc2gvbmphdnFaZWNDcVRROUR5UkFn?=
 =?utf-8?B?YXlSR01vOHZpeHl6c1lPNzJId0E5VTJDVEx4TXEwZEhzZ2JNc2xkN1lHRFVm?=
 =?utf-8?B?SGk3Y1o3NGQvV0grLys3YkJmL2w0Mjh1V1E1aVBhaWR1Y2VSUzVHTXFOU21V?=
 =?utf-8?B?RTJIaGlEeDVhSldOeWlPYTJnYUkwL1J0ZTcyOVhwd2pYYlkrdmRyZGVuOWth?=
 =?utf-8?B?djhTQkhFTzJDN3diMHFpRDBqNUZ6UVh6bVIwQnZyeVBnbmdtc213VEdhTmt1?=
 =?utf-8?B?SWxIZWNmdk5pcTlZY0dSdm1jN1krVnVTZU4vSEtKNDJ3QmxIemVSQU1oci9I?=
 =?utf-8?B?dUR2WmpHd1lOTVNxNUZGL1ErUFUvQ0hjb3pyQUhERkM1eXA2Y1NnQmVnT0s3?=
 =?utf-8?B?R2t4aVQwQXFTaXJDUFc3RlBoNERqUUR6Q0ZGUWxCS3AzMUZpalhkTzVQWVRX?=
 =?utf-8?B?ejNLd2orWDZsalpxb01CbGNhN0tNdWRvSTZORU9rU1VyMlhNYzlkUGd0VXNO?=
 =?utf-8?B?QWYxdzUweDYzM0MzK3B1emNTQ3hPd1p2eW9PQmJ3Y3ZVLzZYdmRvUitQUjNO?=
 =?utf-8?B?Z3dFbFpFL3h5c203RVQwNTJUdWJqOFg3djZuUS8wK0ExVThnd3BJWFlyR3I3?=
 =?utf-8?B?QTh0N3VsWHNYQjVITTZjT21kcmVCbE04MHJ0ZlpxdkRCK1A5VjdYdUE3S3FE?=
 =?utf-8?B?bU5ybDZYUTRoSDgwdE9GWlE2OWQvQ1JyWE44b3RNQWVjeDVUeHQvYy9JendT?=
 =?utf-8?B?empQbkdkRkNUaUt3V2ZqYm5oU0lndDNBSUF4VmRsVkxaeExjdUdzMzg0K0M3?=
 =?utf-8?B?UXhKTTNWcGcrdUNkNXNlOVdoTkdKMTZtdkxGWUl2KzdyMEE0Tml0VjB4RTVx?=
 =?utf-8?B?MEhiL25DeElrYkRLTmcvbUN4cDZTQVV1b2JPUkp4ZUFReCt5VlU4ZEdNMDBE?=
 =?utf-8?B?d21aMmhQVDl1UEQ2akRPd1plbVE3UHo5SGhRSjNoSmFqeFhPQmJKaWl4NDU0?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8240978-f562-436b-efbe-08dc99bdc15e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:05:45.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrrDROaWCqlRvHbEz7fTUkGvtP0U1Ljz/xEzR3Dqt+R6kbT68nNes92kURaopmIzj9uHz1WSP2DuMh0sOFiXLK71zapijj0+bP4LzpWrUxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> The default value of the maximum fan speed limit register is 0,
> essentially translating to an unlimited fan speed. When reading
> the limit, a value of 0 is reported in this case. However, writing
> a value of 0 results in writing a value of 0xffff into the register,
> which is inconsistent.
>  > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/amc6821.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 3c614a0bd192..e37257ae1a6b 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -601,7 +601,7 @@ static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>   	struct amc6821_data *data = amc6821_update_device(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
>   	if (0 == data->fan[ix])
> -		return sprintf(buf, "0");
> +		return sprintf(buf, "6000000");
>   	return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>   }
>   
> @@ -625,10 +625,10 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>   	int ret = kstrtol(buf, 10, &val);
>   	if (ret)
>   		return ret;
> -	val = 1 > val ? 0xFFFF : 6000000/val;
> +	val = val < 1 ? 0xFFFF : 6000000 / val;
>   
>   	mutex_lock(&data->update_lock);
> -	data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
> +	data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);

This is an unrelated change I believe and I would therefore have this in 
its own commit with proper documentation in the commit log. Indeed:

1- Change in fan_show handles the default 0x0 register value (which can 
only currently be achieved via the default value of the registers)
2- Allow (re-)setting unlimited fan speed by allowing the user to pass 
6000001+ instead of clamping it to 6000000 RPM.

Looking good otherwise,
Cheers,
Quentin

