Return-Path: <linux-kernel+bounces-236696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7291E601
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14A5B2330E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F616DEAD;
	Mon,  1 Jul 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="di6NSdUh"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649316CD1E;
	Mon,  1 Jul 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852906; cv=fail; b=GjnNJjClD91wfnfY8+7JZ62vu1/ontZ8XlCi4EvkyJ+L/8z86orJXaZUtaqSocKGjiYqTKcY9ljH9cPLaH9sxO4h0XNCz+NT11L1McDIVKcojZiWNuI09O1JlaqB/iOqQoDRZ2Uv7swFPeZvoUxmWFoOl6mUnD1r9XMitOO+EsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852906; c=relaxed/simple;
	bh=AySICbsV1+DXhkIom3SYvZcmiyy7FeMeAOj3BmYlFBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LTou78Rfel9q6kHcvGkt+A/GUkgLHIgJDO8ccIHKJaLHu8RxNj8+bme8grFp044lJYm3YclITt1XkNMF6Vy5agM76161UJ3FuCLgsmvmg1j3uPB4Cj/5aDOfueCxa7H7wGz/89U/LAMtntIKn5Iav6OX5Kabv9Ud7OorXddLMWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=di6NSdUh; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgfSqw5fu/rL8DrYoCjtCT5D88hzfvDcecXwk4LU1y6i6orRv5HAs3Sc614BrFLdYz/tOtYQE58HfYWrTBDkSdUIt273r0i4mamLDx0DAZaVV2MTeSzNnle9XMud8lLL7q+M65e6TcE7pdneKjJCBbh7oTPPVmHwvap9/Yv26RT1tyn11In0kqk6PyKPHEnhZKOZREWlYitE9PoLE1KcQ1a3ITncN65EACykK0sBFZZKDDlDJEj4884fnLpQ5MKdfEjjK2EBML5BTDMZPOQsMtUoYwncgo/XgYBH3h3NuKGXx2oHQkT1GSiUUcNrv9gLAXdsV2rg9ouT/M0Tuq4HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=145oXhaGHV4ccup+zVSwD+jYUs4keYQDUobeYyVYzsA=;
 b=PI4VitPcqYry0BIrKXoAdcE4736DAJcFL+lGcC2dMnZai669OsY7jnjcZC4JJF0iGTzmrY2xvCjyXYLe8Nui/AzBEKxfGx/sKKGMOCIxpIDkkDBYMWiIRb2ca6fJdUQN3udY9nFmcWxlb43HvqNYD9WUqrVxf/AKae2iY9faxuovixMPo7ngePB9EB+Ft3GG6v+7GLaLtIdJijCi9sUYxOJDQtwCX3JUIr/BS9GWVcG/B1tD/HptjGcAVmUoHdHR3TxCk7JdeGxXuaR99IRCXoBHKYzZKh2rmAz73FlbcnwjQOWbUKsZtohJr3rOn00EIsUhcbvHDcA9tQ5t2530Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=145oXhaGHV4ccup+zVSwD+jYUs4keYQDUobeYyVYzsA=;
 b=di6NSdUhMA5gpTBmag8pBEie8UbmjNZ+Ylzf+PnmNYlQzOuwNq7lvAUDxv30tjKZc93t8Onneg3PUEz2DRC9e1eRpyHcNAyD5cQW65hdVlvWV6ZgCOPVgW6lDDhGd0QoU/2EWqGSFtiMfPQm6Po+k0XKHY10HmPhz4U5y4fIoDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB9352.eurprd04.prod.outlook.com (2603:10a6:102:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 16:54:59 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 16:54:59 +0000
Message-ID: <7a1f2916-3e2b-45ee-9681-7327d7b1798a@cherry.de>
Date: Mon, 1 Jul 2024 18:54:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hwmon: (amc6821) Convert to use regmap
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-10-linux@roeck-us.net>
 <7a829bf2-c5f6-4234-a224-52328045f581@cherry.de>
 <13b73e86-fed0-4ef0-9815-eda765f2a70c@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <13b73e86-fed0-4ef0-9815-eda765f2a70c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::8) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee69570-efd1-4904-42d2-08dc99ee8b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTRIYk9jN1ZJMjZIemU0VkxNSmNsUW5ac1VDblNmYTg1VVYzOTcvRGtWMGtL?=
 =?utf-8?B?YzVYV1lBN1llOERXa245dm5BVFpHQkMxOXBoYmFTWDBKbTRONEpISllFK3BO?=
 =?utf-8?B?OVFHTVNtdFlmS3ZvRjhPMHdvZ0FjMWhJeWFPL0VPNFNYV0RCL0M1VEw1RVdH?=
 =?utf-8?B?T3dTTm96ZnhHS0FxVWZRVzA0ZkRSY1dSSXVQdEJuQmhxRXR4R3d0dVk3cFJr?=
 =?utf-8?B?SVRnRUhYMDFvOVQzS2dobFFMZnpSazFQWEFNL05PZUhMTlJrTStvL2J6ZlFZ?=
 =?utf-8?B?dE1xSEk5aC9jbjJhUzZ0VEtXb0VvbUQ5TFcxcjFIUDY5OGdPOGRkYndFSm50?=
 =?utf-8?B?UTVUOHNLc0RKZ0dOWloyaFhudlhxT1J2TlBRUC9mYUNGRWxjTTlUWDM4cUd2?=
 =?utf-8?B?WkFwOUdCQ1JyZWlxb21ucDFMQUthNzREQnhtdWlLd05CanRCbEpldEtMbTBW?=
 =?utf-8?B?TlRIeGZHVVpyMVdGYkVld3BzRmp3MCtSejFaVkVLZG1vb2dROEkyZG5uekE0?=
 =?utf-8?B?WFJKdnBKbmdCVndXT0NrMnV2OHJ2NVdjUjI1VEpCN0FtK3BPaDA4c3Q3Um95?=
 =?utf-8?B?Y0xYaUMzV3F6L3JKT0t2M0FHV3dNaXBiYmtITmo0LzRqdDNwaGVDdnphQTJO?=
 =?utf-8?B?cE5kY2Y1SHhUZFJ6Q3RRbjUzVGl4RTRPQUNpOEJHS0ozeURUeGJRRzFkb2xp?=
 =?utf-8?B?dDlVTHFlem44U0VTam5SOHhnY1R4MERFcksrUmZkOUt1Q012QzdhYlVLNXN1?=
 =?utf-8?B?b2lkeUtFaFQyMG1iRHdpRUtPek10ZEQvS1NLYXNobm5zMnFDZG1MaStiUXFI?=
 =?utf-8?B?enR3NzF4Mko4d2p0OFNRZTVhTUpScTZiUUQ2NDFmMFUxOE1xQTBHR0YwRXdR?=
 =?utf-8?B?MXZhOG9scDJjMnhZSU9MOW5OQUY1V0xGRlloaW9EV2R4NUVYMzVDSzlSbVYy?=
 =?utf-8?B?NDlkU1JyQ2FhaGNyWlNZdFhRUEJVSUpHS1Q5SzZrMGxkc1BLZW1aTER2M3I0?=
 =?utf-8?B?TmNUbzdxTlErMG83UEZ0azZCVkpKQ20xVk9NZXJqeW1YY1ZmZi94YVRFUUZp?=
 =?utf-8?B?NEx6cU4wTG8xMVo0blFIT1RsTVRnUmFJRDEzdm1CVVI0UjhyMU50Z01wYmMy?=
 =?utf-8?B?ZVl6RnF4SWRYS1ZZWTk0NUd0a3JSZWRvM2wycTI3OEgxcDBFM0JkWEtKTmhp?=
 =?utf-8?B?VUs2T0l2UnRDNHBwbXRDK0tiSjdxUXZBZUlJajlZRDR4Q3pVSXNDK21XVVdX?=
 =?utf-8?B?YmdnaEJYS2ZUNTBUZ0s2aGxoU2M0YUJQdHJpNVdmeS81N3krZFA1NXhHS2Fj?=
 =?utf-8?B?SVUyR1JkTzdESVRpU0lYSE1WNWtDZFowU0ZqOVhOOSs0NURDdVRiZENxRmo1?=
 =?utf-8?B?Z0RURWpQNGNvMTJWTkptYU1PWTRGSUN6N2wrZFoyTE83T2t2OUlIdkVvQm5T?=
 =?utf-8?B?WElZeFIvUWhJM1JxcWxqck1HaGIrajd4eUtxWVpRZ2lUc29JZ1VkRWE2Zm1K?=
 =?utf-8?B?Y0lHa1d1RENTT0RTNmsxcGhlZS80ZEtyeWJCM2Zyekw2TVNKQ01QTUlGdlRG?=
 =?utf-8?B?a3NjK0xnekRIWFNLSVVPTFBpckxtSldRcFAwQnBMNXZwR3cvbmo3a0ZKQ2Vn?=
 =?utf-8?B?ZHNQTlY0b0dOZml4Ulc0b0JNdEllVjFEMGpLRFd0dWtHMGhNVmdPZFBoRlhC?=
 =?utf-8?B?UkJNMDRQTWsyeWZFWW5HRlBQQlJZNkJNc0dIcndPQWFtamF3bWxTUFNDbzFV?=
 =?utf-8?B?OXRUMWdOdXRvaWFTUFdUR0plS1EvTFdZT0Q4aWlKUjlVcU51Y1IwV3M2T3pS?=
 =?utf-8?B?WTFteHdGS2F1aVB5R1U2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjF1QnJRc0kwRElDNThPdmMrQTc4ZE8yeHdUU2xmZ1AvRTY4VzFLNllDTjdw?=
 =?utf-8?B?YzZEbjJVSk1PUmlrV2k5MUx3Vk5GdUJvYUc5NHZPT3oxWVhqY0xZQ1Y4WDZN?=
 =?utf-8?B?TWd0UllxQWM5ZEdha2Y5RXk1RDk4aTFPdTVkTkVVTXRXdmlDKzU4SlhHRUYw?=
 =?utf-8?B?UjByaVZCMk5ybVZSai9WeWNiY0JESWMrRE1ZSG45Vkx3NURyMFRMTmZxT1dn?=
 =?utf-8?B?VmxZVVhNQUE2cEZ4M3p4Um9ZNXRzRmtMdFFMd0FhNUVYcGxrQ1NwL0pxY1V6?=
 =?utf-8?B?ZnplUDVwOE5sYlhrUUIxUmx1ZSttdlV1eThoWUVFRG1zVU9VMG9oUW54UW5H?=
 =?utf-8?B?SUxXTjFndFA2a2RCTGlFV1hYRk0xc2orWFJYeHUvaitwWTZVLzh4SnBnMndF?=
 =?utf-8?B?ZFVEK3VKdVBxcTE5ZGYxdGlzV0l6VzJxcHZ1a01yUW96b0xiNHowMGRtTk1G?=
 =?utf-8?B?LzRUMEdLQ3FSd25QZVhId0tqeENKY2UxV2FSam1IbVN5THIvWVZVTmxlRHFM?=
 =?utf-8?B?RnRkTk95Q3dGSlE4c3VwRDBIWFhJUzFhNndFait4RURDdHNBbitDaTBxTFk3?=
 =?utf-8?B?TnJFRDViNG5zOFNjMUlPZDUraU50ZVR6SEtlUmw2bFNSV0RJc1ZZU05tdVEy?=
 =?utf-8?B?bkdWUjB2WWxJVE9OY0ZhWUVWVWpXc3JBRFpSTXRraDg2NFYwdUx3OXgrampp?=
 =?utf-8?B?dUN5cjRkOTA4UFNuZFJLc2tCUllveUQzMVZzejMxU2U3ekNXTVV2Y0FRdkRi?=
 =?utf-8?B?WVNuQUVoOFp2YTNSOGxxZU9QZ1dYanFQUUw1eWhlQmNuYkxWaXkxYUNpQkx6?=
 =?utf-8?B?UkxiNUtYMmdyaWtGczBweW92YWpNZEplL0tvSCtnRXBVd2JaejV3OFFNdXJL?=
 =?utf-8?B?UmFQWW1uNnNnWkdVd1Bmd2tLRTE0Z3FNdTFabDBXSE5jdURyVEI3TzIyRzha?=
 =?utf-8?B?QXN5aTFXb3dQTXI4RElGUEJMaVAyZi9ZTURaZjNYYlJlZm8zQzRpaW5EWVUv?=
 =?utf-8?B?OEowZllyTHRtSGxpcDVkUzFyT0FRc3h1TWRvR3FFREd4NTJrcDRtMm1xWVk3?=
 =?utf-8?B?NG5UdkRTK2Q2amNzemZvMWZYcEx3VjZQaGx4dDZEYkVIUjI5czJsM24vK0dX?=
 =?utf-8?B?dFVuL1lxSnVhRE00cHBvWU1WUjM5WVdrdC8yTGFsVjd0UEVjbkhqcXo2d1I4?=
 =?utf-8?B?ZjcrcVo0ME1LUlRCU3I5TytRNHVkditUVWNGZjRibWp2R2xmelQxbGVuRGsv?=
 =?utf-8?B?STNuK3FtSEFOcm1TMTVPYnZVUENFOWRFVDZVOXZYYjJZUWcvRlNwSlN5MWd1?=
 =?utf-8?B?RmFtNWxYZW5JVXYrdFhKcU1MdnVlb25KTTdMSjNlWVV6UGJrZUVVdWRHWEJl?=
 =?utf-8?B?cm1hVlAxa1JEV3dvam4rMkZGeW5pd3g0VEFnaXFjbFMyTXdNaUF5YkwxcW9r?=
 =?utf-8?B?eXNpQ0wzS2FtNWxRTDZOa3ZUa0ZSU3hCSEpJMTk3bnNiY3BXT3lvRHBDTmFQ?=
 =?utf-8?B?OW52UUVOVnV6QWludUhQMnE3WFBETUwyaTRUeXUvZVVSSmVDUVZYQU1EbXE1?=
 =?utf-8?B?dFJLMW1Nb05Hay9JSm0ydzFmOWlsaWRNa3pDZ3I5bmhWdkVwZFFXeUZRMGpp?=
 =?utf-8?B?bHpOMjRFYzdKZkhRa1hxejlkVmdMS0ZBVFFzb1RyUXBjZDlHUVZ2Sk1OelIw?=
 =?utf-8?B?SWppdk9ocHNEall0S21seVlycjNjdGxBZjhackxlL0kzdWV5bVlBSVdsSWxR?=
 =?utf-8?B?Zm1jSFdVcVMzLzdPZHA4OGNjV0I0VDJTUE9DYm45UHI2T1dPWVlnRE14QWZj?=
 =?utf-8?B?RXNPYnlHZUVLZ1Y3c2IrdTljOWhlMTNoNU13WFQyMThhLzFHQlpJcDc1SGdn?=
 =?utf-8?B?dmo3RVJxdUlrUTB4VTl3QmpBdEp1RFpwWWZSam5FOTY0Y1VjVGZjZVI2ZmIz?=
 =?utf-8?B?bGJ1RHJGb0RidUhYNkJod0MweHk1QStpUkVyTy9kTThUd2NDOFEvMjNVWHNn?=
 =?utf-8?B?OHlHVlZIc3htbTNPR0Z1ZFQvQlBtc3ozNEpzZXBxQ2U3KzV5VFZuWHdWRHdJ?=
 =?utf-8?B?azJjZEtJcXBUdFNONC9KVmova3Y3ZEYvdGdmd1gwamlqSGFVQXNrY3JsRmFi?=
 =?utf-8?B?Y2ExZjJlZVZ6T1IwRjRHZEZhZC9iY29PeURIYnllaHVUMHNmdUNpZGcvR05t?=
 =?utf-8?Q?Q3H5xd0mZNQnqa5r8JQBjO8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee69570-efd1-4904-42d2-08dc99ee8b03
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:54:59.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z12OEkJD0D+mFjpZHr/PpmYx1V3KayoWlQj4brQdcZVx2Mjai5C2tmIzWBQ/RxCOOiLjzn2SSdCRrm1bPo3/232BspcgfZvaA9s5UcJltfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9352

Hi Guenter,

On 7/1/24 3:47 PM, Guenter Roeck wrote:
> On 7/1/24 06:01, Quentin Schulz wrote:
> 
>>> -#define AMC6821_CONF1_FDRC1        BIT(7)
>>> +#define AMC6821_CONF1_FDRC1        BIT(6)
>>
>> This should have been squashed with a previous commit.
>>
> 
> Yes. I had found the bug but then fixed it in the wrong patch of the 
> series.
> 
> ...
>>>   static ssize_t temp_show(struct device *dev, struct 
>>> device_attribute *devattr,
>>>                char *buf)
>>>   {
>>> -    struct amc6821_data *data = amc6821_update_device(dev);
>>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>> +    u32 regval;
>>
>> Why not a u8 directly here? We know single reads are going to return a 
>> u8 so no need to store more?
>>
> 
> The parameter of regmap_read is a pointer to unsigned int.
> 

Eventually through the many indirections, because our regmap_config sets 
the size of values in registers to 8b, it's a u8. But it's not worth our 
time to optimize this.

EDIT: coming back to this after reading the rest... Wouldn't we have a 
possible endianness issue here? Especially with the int8_t cast or the 
sign_extend32 (wouldn't the sign bit be at a different index on LE/BE 
?). Sorry for the question, endianness really isn't my cup of tea.

>> I'm not too fluent in type conversion, but maybe even an s8 since this 
>> is actually what's stored in the register?
>>
>>> +    int err;
>>> -    return sprintf(buf, "%d\n", data->temp[ix] * 1000);
>>> +    err = regmap_read(data->regmap, temp_reg[ix], &regval);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    return sysfs_emit(buf, "%d\n", (int8_t)regval * 1000);
>>
>> The type casting choice is odd here. Considering we'll be printing an 
>> int and that 1000 cannot be stored in an int8_t, maybe just cast it to 
>> an int directly?
>>
> 
> This is a trick which actually originates from the original code, only
> there it is hidden in amc6821_update_device(). This is equivalent to
> sign_extend32(regval, 7) which is more expensive, so I decided to stick
> with it. On the other side, you are correct, it makes the code more
> difficult to understand. I'll change it to use sign_extend32().
> 

Indeed, I completely missed the implications of having a "real" s8 
stored in a u32, thanks for the explanation. It does make more sense to 
use sign_extend32() indeed.

[...]
>>> @@ -603,58 +582,72 @@ static ssize_t pwm1_auto_point_pwm_store(struct 
>>> device *dev,
>>>   static ssize_t fan_show(struct device *dev, struct device_attribute 
>>> *devattr,
>>>               char *buf)
>>>   {
>>> -    struct amc6821_data *data = amc6821_update_device(dev);
>>> +    struct amc6821_data *data = dev_get_drvdata(dev);
>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>> -    if (0 == data->fan[ix])
>>> -        return sprintf(buf, "6000000");
>>> -    return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>>> +    u32 regval;
>>> +    u8 regs[2];
>>
>> Can't this be a u16 directly.......
>>
>>> +    int err;
>>> +
>>> +    err = regmap_bulk_read(data->regmap, fan_reg_low[ix], regs, 2);
>>> +    if (err)
>>> +        return err;
>>> +    regval = (regs[1] << 8) | regs[0];
>>> +
>>
>>
>> ..... to avoid doing this here?
>>
> 
> Then it would need an endianness conversion instead. That might save a 
> couple
> of cycles, but I think it would make the code more difficult to read.
> 

Ah dang it, I always forget Aarch64 (thus LE) is not the only 
architecture that exists in the world :D Endianness conversion being my 
nemesis, I wholeheartedly agree with you.

[...]
>>>   static int amc6821_probe(struct i2c_client *client)
>>>   {
>>>       struct device *dev = &client->dev;
>>>       struct amc6821_data *data;
>>>       struct device *hwmon_dev;
>>> +    struct regmap *regmap;
>>
>> Save this variable by using data->client directly?
>>
> 
> Then I'd have to dereference it twice to check for error.
> In such situations I prefer to use a separate variable.
> 

Fair enough. One's taste after all :)

Cheers,
Quentin

