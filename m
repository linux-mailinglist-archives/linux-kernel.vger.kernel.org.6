Return-Path: <linux-kernel+bounces-314654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4A96B664
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C001F23CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140501CC17F;
	Wed,  4 Sep 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="O86K6XbU"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2128.outbound.protection.outlook.com [40.107.20.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DC155C96
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441726; cv=fail; b=ZhOvCCfktlTHX4foSm0VibmgSssaeJIyh1OIb6dIKwQrpQb5OoJHUOp4k18Rl3m8E1QgXDbWuIsmFb/2j5H6GK3EHCc2Nd46Lvj1GKcBKjbje7C8DsBfgM6eJMlnhNUywdAr7uD4rw18cZwTKE/SP2DrGHtK3dfs0eWc0ZOz5sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441726; c=relaxed/simple;
	bh=lLD9hGRHwsAmITOXgOQ3+LTgxn+wL6XQCRc6fiezbGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZGPK0oQNzpO4veZKeFqTqtDjZrjj/Dkd5spuDTi5V8qUokabj38ggICW9lwbifSvkzQfIrw5zVyctqpmPtHwkNAhtEiLqbmO9FzBI25oQDqSkDaPlQjLyiyd4b4Auu28CUZ2RohpHgtRSTNch8n77jGKy4mcmyN0lArEzr0ToY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=O86K6XbU; arc=fail smtp.client-ip=40.107.20.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmvbs7dABzShAzdkue7Zuu3JPBz2j52L8x1dL7526/AlP2Y62tRXD7ee+jvMf+Drk/f50TN+AUi9BFy14QfjqPBmlQY68EmwGhn0lD4OflaimtfHQXwW1lbxi6Ox63sBVYbYJNkCNSgHDAqa2VMgr9rLmOos8wbB4lmkre05C/OZ4GrecElPdSfkw6jPv11Yhqalux03N4WgeKtitBjFUXegeAzAyufo+liAByuyMybZ6c0Ovxzw/G514QB4LCBA4jUFk6YDP+xY4X+iqYUlANFjvzBqNRnemS4C0fn3yQbP5IDOKw7xraC9MWogH9qYdBop8+VFax6xZ1uUwciIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWQEM4+CSMA37mZPUvxlQZ0Rbba4LcMwQA6rlditGDM=;
 b=t84Vmlif/c0FU2UjRI55spGSNmS1SnyHoV+qpypZZJon4IkgthATklRWjUEYecnHZTCIPQ5BZmmI171kX4v8Lt/fabmUGKsYyCTda+8xxo98C7IIBmsq6aNzM+G0DGlpwWeIBSNZrRba+0iqF/vS5Q5eZ9ygU5/mB7dVgC4YOk3miHCAO1RZLa3SRqJKwFo9zbE/uX61jCak/VZMgaXE0jw9P2nwR22V56RlG2GQP2a1vElkHZyZ3WurzjT9EnqajyxnUjZY5ynGMzVH4rjqeLR9BFCZt8yzIfYgaalFL2TU6jNbXWBgUmZG/2LZ1EBkSNBkwLi51xvnkDhHvqiooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWQEM4+CSMA37mZPUvxlQZ0Rbba4LcMwQA6rlditGDM=;
 b=O86K6XbUjLNSBVWly0JXXxpx/bMwIEOubnJV1eY5G7pXKD3WaMl0Pp5nUFIxLYAc9GDUi7igTa6/VCLSy5L7J2xgl3Jl8rLyEzt7cHD87hBhK1Ak3SuJVU3937SJy5iuBER6e+j87zRO+XYMa7IKKEca+zZ1AfcfLX4qysCDd8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 09:22:00 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:22:00 +0000
Message-ID: <eccf0274-51c8-4afd-bf98-af7d401f4422@kontron.de>
Date: Wed, 4 Sep 2024 11:21:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] phy: freescale: fsl-samsung-hdmi: Replace register
 defines with macro
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-2-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904023310.163371-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e863890-f824-4701-8db6-08dcccc3080f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGpOSEhEaEliWUZ3dHJzZUdNaVIwaUdZWkhjcWRQYStZcWxIRFBPL3phRUx6?=
 =?utf-8?B?UlhMS0FMd0U5b3RHZzFaWGQvSSt1MGNpajBhOGFPSkJzbTRoT2RDSVBIamlU?=
 =?utf-8?B?eHM4bHlNdWlHdEJhY0JHTVQ4NnFQSGlaRFNhTGRSeGszS0lRUkU1OFA5Z1BZ?=
 =?utf-8?B?S1ZYc3BnVGt6ZmhzRDZkU0ExTDV5WHVwbkgwc2ZLQXpzczdyNndFREpQODIw?=
 =?utf-8?B?NEUvVThPSUlRVThqTlBDVUt2VUl0bzVzK2NNL3E2emZCSTdQWHc5Z1lNcnFF?=
 =?utf-8?B?VVFRY0ZzbDdCVVdDMlg5K1BRRFVGMlhpNzVuN21CNWZuQi9nemtKVk1NaFZY?=
 =?utf-8?B?NXZCYlB0Q3RwcmNkOGZYVjR3L2hOUHZWOXNVcmNjLytCQ2lFZ1JTMDFpMGVt?=
 =?utf-8?B?RW1DSTdQem53NGNHTnpJRWgyQUNnWTlQQ0ZEMCtXemp4Z25yL2x4ZWx5ZStk?=
 =?utf-8?B?dy9vS0JMa1hhelBqckd5ckNtdmxkTTltVVNlM2hUMDZyRGx4RjBhd2VaWXc3?=
 =?utf-8?B?ZU5nUXJwNjBUQ3FWc2VhMUN0UlRZQnQxbjd2YXpOdTRsZWdXU25kdE0zYnEx?=
 =?utf-8?B?VU5yeXZ0Z0o0aE5yTmhYa3JNTk5PdzZuWXhZK2gzVUIzZnlMdzZSNGZSU2RR?=
 =?utf-8?B?bE1iVEtycGF4OFJObWhNcUtlcURFM2MzQlJFaEFNWDRkblMyQTRld01XeEtY?=
 =?utf-8?B?enhtYVRxY3gxU1NLdmZEeTVrT3YzYzFqZjFRRFRndmhOY3FVeEV0SXpnbmdz?=
 =?utf-8?B?YUkzS1FZVk5USnZsd1N0RGFsK1BHUGZhdDQ5Mm5ucndvZENqTERjVTMrd1pG?=
 =?utf-8?B?ZWt6cXBGOHZpbWlBS3B3TmQ5enhQRDhBZU14aE85b29QWFJodzNoT2tyUmdD?=
 =?utf-8?B?M0ZtTzNuanZWVGMxOUhqdG9KYjl1TXdvR3BtZEhlK2R0OHVqMTNzZzhmeHlU?=
 =?utf-8?B?bnErRXc3TTBSRytneDlvOVdwbmtxTHV4aVdtMmoxclA4cVcxako1VStsNmdj?=
 =?utf-8?B?dVExalA1VWkwcnRFUjh5cUVYNU43ZCtGc3o0dlh0dWNZMDc1RjVUZlVNelMx?=
 =?utf-8?B?MW5FNm1IK3Z2aUlRMUNHNXIxeEZmSVV1SVpTeE41cS9KTDRiaGhkL0VBazJ5?=
 =?utf-8?B?ajlVU21DSUdmTDl6eTQ1aUZ1clk3cCtuZ05YUmljR1llOHFrcU1YRUwvdnNM?=
 =?utf-8?B?LzNuSFdzRFhhSkJSelBQbnRkVDNMV09JTTBQNXNIMzNiTU14Mmtxc2N5eHBK?=
 =?utf-8?B?cUVUcmxJdHVqa3k0eXZZRnoya0N6WnBpRmFmVFcrVEJyVityZ21uUEJNVmhY?=
 =?utf-8?B?MTV1Q3daU0x1TCtVNCtMWW5MdmJmbTk3V1lzUVNZdDdhZFlHc3Nwcml4WGhH?=
 =?utf-8?B?NksvcUYvNHFIU0g3T1NwdzBqWTR3b3A3N0RpV2ozZGdSMjZqVXorMEtyQzJt?=
 =?utf-8?B?U2NINS9EQWFoemNEZmRvTnFwM0tIM1ROTjAxZHdFbk5iM3poOWF2VkhtWFdk?=
 =?utf-8?B?YlA3NnNMZFY4VUMyRmVaMCtLbTcycEZWS3IwZ2RDeDFTcFpmbFVGMTFPZFU2?=
 =?utf-8?B?dEV0aHR5b09RYVd6WlAyT2hNU0psN1N0WkpnWmd5RHhRV2swSVY1blU2dDk2?=
 =?utf-8?B?YzdwTGtrV0RXb1RDOXhWYkxCZXJvOTFIcWFxK3dlR0JpQ3N2WjRsd2VvMXVS?=
 =?utf-8?B?ZTJWdlJ2RnhXRlJxQ0pkdTlEWjVBMStvWDJZekswS1pQZFFhcmJNeEdhelpm?=
 =?utf-8?B?Zit0QzkxRlFmVTY5RER3MHd6MnlwbGFVeThCbWhGSGVRSzRJNDdQWDB0WjFx?=
 =?utf-8?B?dHA0UVJISW9GMTZEcjlSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUxKTWc3MXhJdG5LR0FXd1ZEYWJIS1hYM3I5TVFwZUVZc24xdWRlVnc3cXRS?=
 =?utf-8?B?V1JpVG5IMzA0c3JhNVJ6RzlKUDVqeFN0VDcxU1RrS2VyTEdHTWZXdUZ3RXJx?=
 =?utf-8?B?bGVSQ3RUR3VmeTNtV3N5UTZtNGZ6aHk0RXBjWUxzYkd2T3RNdkY5Ui9EeXMv?=
 =?utf-8?B?QURhVVE0VzFFSEw2NUYvRU9NandiR21rNmRJQm5DNThiZUlqcmxPOFhJNEhl?=
 =?utf-8?B?RFkzSnMzVHRCSzR0dWlTeW9mQitYWk9IRkQ3cmFlTjU0OTZReUk4MXRNbG5q?=
 =?utf-8?B?a0NsQnBHanlrZmxGS052b29lVFpxZFpscGtEYUNIMGtFNXlWeWtOMk5Jd3BW?=
 =?utf-8?B?NGlndC9aamhVOWREblVkMUxySHdtOW1ubXBRL0VIc0RIUnhSQ09ZRDEyNnQ3?=
 =?utf-8?B?Q2Q5WEpwQ2FLSkJIYU92enJtcmR1MjdBaG9rVHFyWXJaV2d6R1BKbDhvOUYv?=
 =?utf-8?B?Sm9qaUtwcXJmY0JaZDBMdHVCSEhnd1lmb05YZWpDTCtXUW82NFZrS3BIUy9q?=
 =?utf-8?B?MEJyRmloTGU3bFZENkt5dk9QZWVSTnA3YWVha0xVdjFMMVIrc2h2S1dGbEx3?=
 =?utf-8?B?MjhxNElqV2oxSzBDcUNrdGZBdnltdURKYTlhVVE0Q0ZhYUllZmgyanRPTk85?=
 =?utf-8?B?elhOZElhODV0K2diUVJhcUhZUkVCUE9Vb2IybmRmQks2d2g4eW9DQ29ueGlF?=
 =?utf-8?B?NzRhb3VZOEh4VWd3RUxJZEZqbmphbVdQdVk5RG4vOVdyWjFhVVdCbkwxZDh2?=
 =?utf-8?B?S0JLYmdsQ2oyN2ltUkwyeDE4aXBFK05VREZsNnF0RUIvYzAray94NGJaNS8w?=
 =?utf-8?B?OUozMHp2VVU3S01IK2FSRlpLVm5xWDRzM0ZDVldoSHBwcHFVM3NUOFZQOTlk?=
 =?utf-8?B?aDN0VXNSdVFqSjN1c0lHMVJtb3hQZGFkdmdRZUtwcmtzOEFiWEltRjZpTzds?=
 =?utf-8?B?UWtvaFNCdkFFRE1hM1NNblIvVjlvcEVPQ0YvcytJVGttcG9aT3l3MzJRQklq?=
 =?utf-8?B?MHk0WmN1V1NlckJ6VnY4b21MemNQS3pySS8yZVhjSHV3ZjU3TFRPMVpvVjhw?=
 =?utf-8?B?RE9pRHZQdmFONzZOdlp5SGVyTGtwSGVacllXbnBQQ3RVVGhCYTBmdkRXUUwv?=
 =?utf-8?B?ZlNqZVdESjJIZldrS3JOckRvdzdkczBhRjlLTFN0UU9KSjJPeVJPa09OS1RW?=
 =?utf-8?B?TXhLaDRBTUljOHFIWitwNzU4ZnpkeHFhYmdhV1FGcU8xWlhNT3ZFZkJxd1B0?=
 =?utf-8?B?aVV6ZldvWWxHbFc1aFFKaWtnRTZ0WHVMZnpqK1lNZUtzV2haTmVRZ25SeURT?=
 =?utf-8?B?VDg2ZlZTZUlvZUpGUG5PNUdqR0ZRT3haOTVOSlRWMmljZUQxODFVdDh3SThy?=
 =?utf-8?B?R0phc1lUUVJlclQxSjY1S3dwWkczcURzM2JrQXh1dmZJR2lzVEFJaHhmQ05Y?=
 =?utf-8?B?dzBrMWNDZ1RIYVBFOFhHY1g1WmM2NlRjekI2VUxGZWlLZzRhSTBKZCtranZu?=
 =?utf-8?B?c05HT1I4U0ZYNE1YcVdlTktMejBVajlPYVZFOWgvbTh0KzJBRWJBUEkzYW5J?=
 =?utf-8?B?REhTdDB2Vk14M1JDWkVmcFhMZkFEclM2TVkza2h1WFZoM1JnWG9DSFdXMmk1?=
 =?utf-8?B?aHVmeFl1c0M0UTk5a0JqRmJsM3paV2JqeWFRNGpBNHJvUWM5UmNHaDlDd0pX?=
 =?utf-8?B?Z2hueWEzWHdBWXRuaFVUSGljZjVPbWxrbCtxcjY5K2RZNU1SL3kzRGE5bXNR?=
 =?utf-8?B?MGs3US93RG1YRjMzRFF2M29FZGFrWjdibml1YUtpUmhTZFgva1c0N09CQkJh?=
 =?utf-8?B?Um55TDE4djdlbFgrbVJvZy9Jb1VZcnZneFNXN1NTU0d6cG5yNVlwSFpQSlp0?=
 =?utf-8?B?UEZBRGVvMkR1cENOSUtQN1RJVGQrUUNmczVNU3p4ZHJCZWIxUFhkNW1hQm03?=
 =?utf-8?B?Y1ZNbkkzL0dHWTBuUFdidndncUorL2p6VGdZSTd4cUFRalJHVTgyR2lXam82?=
 =?utf-8?B?emJQdklqK1ZNQXBIZkhzREttYkpxNjMvTmNQRHdnN09CeElVL2hrdHhLejZF?=
 =?utf-8?B?S1UrZmF6TnVCd21uR2hpOU5LcDNpVXpTWlFoSXg2OHdBbjhpQXBkVktxVS8y?=
 =?utf-8?B?V1ZBTU9QZ1YyV2M4K2ZrQ3lnMFo2ZytSWVRUSDIvZDRMYXBnUzBVV2d2Y09Q?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e863890-f824-4701-8db6-08dcccc3080f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:22:00.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS3T5VNXrTBgFSri9tRI/PTZ4vBTvCFskZoPQTZDJ+UhGXrdYsHfaCiauZCBDMaHSRZCf/TdnsSLxDHtWtHHdVQnAM/9OruUtCOB8gNzdF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8802

On 04.09.24 4:32 AM, Adam Ford wrote:
> There are 47 registers defined as PHY_REG_xx were xx goes from 00 to
> 47.  Simplify this by replacing them all with a macro which is passed
> the register number to return the proper register offset.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

