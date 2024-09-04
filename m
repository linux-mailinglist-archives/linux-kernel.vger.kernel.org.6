Return-Path: <linux-kernel+bounces-315204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9209D96BF78
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CD28A61C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0681DB52A;
	Wed,  4 Sep 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="RGqCls/K"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859F1DB536
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458087; cv=fail; b=ZJaKULMMUaxnaALZsdhuw7cVFJ4MyXwNb1BIcEh0j7xesRvxl1dxm3ipQf5U/LxTNRQvlmE3RHVf1Nuxeru1nWNkPz8rgyR+NkayVkR8J36PlcjH2gG/R5WWMdpndV2zDJ/PrB+B/G0QU5fyQcjAHWkFXoH4ItLVoZpkB+35DXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458087; c=relaxed/simple;
	bh=mDJ14P+y9YxvoidgJ3alphTZk9g38JQxRPvWa9vZT9M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mm81tZl6tx/N0YiumGm73EzN2nwt6LlS+wUgiYsqtmEzTQhYX6UcC043tXQNuKP4CwXXvkUkNMKBK5NSgYmjD7GHqcf2r0x9vZ5y1N+69ySamy/raAnDGEsfjXEpDNow8Mzr7LURhXs7u2giN0SeSFLuggjfw1ZbP/BQBfv4fLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=RGqCls/K; arc=fail smtp.client-ip=40.107.21.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYnOSH4V42gNwFcqIfIuDNGSN60yFtMKXHyX3SNkMHCe/GPtNGV891PJvktRhKLegkvXiONg43AzGMQA1z2gzZs7hwaC/3TVHjirwV6mhK8chQpk1K1/F1QwVVwm33F7kwfYcNXmMUDZT28L8QCkxsIadsFr7NXLspRfgMrg7mnWhRRAOMBGzr18BqIL3AGK/UfGGk/kLOtJ3bcukKH+hsXV/p6ONo6bJJCUnf/hSRdS6LRk/lsNNCtsauhkTkNW4toTIYUz2Uni2+hqQcIsHa9rMn1mCKPT2b4mVx+05PTxL7XmH3egkyXennBgrAZUy7yLdlb3L8KIWHVp1qj3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh7+FEuErdvFMa/EgHn6LKqhqvlAo/mxI/ofSYWuiPw=;
 b=Zz3qUBICESA/wIGG84HEyIHQWLmKCvyPr5YNoaL+Wu8PCXyDOiOdOPOiUHDh7flpFEOkfIuJoWGbJj+m5Rgejak4P76miLmkmk4nC5eP2kyiZwfe02Okx5cSr1wXbQC1lFlbq80Tu2Gzfo3SpKxGNdMAFQf9un4gJmiAuD2gdBKZ3TkVgBu1gn6VGzIKrTI80LrxfFXr6HGwykDa3aF9yOwiznu+PoAP6A9GV4TlyQtB4b1KVODalioBVPN8xxm3vm3tWcuWMaShCDIUBiL4o5L0Vbj0Powjvg9CjXWDJAhoE7GrahSov98LUk9WC1dSE3BSAxPc/SqnyppDnS4TVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh7+FEuErdvFMa/EgHn6LKqhqvlAo/mxI/ofSYWuiPw=;
 b=RGqCls/KYWu0YyOnUDxavmZl8QY6kdFmQjl9oZ+FSnB0xzj54ZCGfuWfvvdMqyESKFmFdggHVYlQ4uJ5XHK0iOQH/Vpzyq1kgNLTYisilP+63D8YWwldr+7laTiM9lfNZBAd9cNxZ6SYWpfp545lVM/dOTSkCCAD4M4l07zd7K8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB4PR10MB6237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:54:41 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:54:41 +0000
Message-ID: <92f51c96-9386-43e4-bd19-422dcd8462b9@kontron.de>
Date: Wed, 4 Sep 2024 15:54:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-5-aford173@gmail.com>
 <0a860fc7-14df-40c6-a92a-868568ae7a24@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <0a860fc7-14df-40c6-a92a-868568ae7a24@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB4PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: abba3394-4956-48c0-a7ca-08dccce91fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnI0L3dsbHBpN2xEbWxSQ1o3MTNkMXhSOEErQ0VVbml2MHlvdnJ1b09OZnlw?=
 =?utf-8?B?dWVtT0ljNGNrcDI0YmhkK2JtS1U0NVp0MHRjZUd6MEhEbWZ3a0ZNaXZNSnBi?=
 =?utf-8?B?WXRwM1pKZENocWFHTEFNb2YzYnJTYjRLZVBPY2hiLzFSRnFOTnp2WVYxL1gz?=
 =?utf-8?B?SXJtVHFPay9qU3JsV2ljOUlIa0gwTDhoWndPUnhsMjN2VExEaWt3cnU3L0M5?=
 =?utf-8?B?cXFFUmZIWGtwcU12eGY0bXAwZEF1UHNIREJsTkRaZ3hFSzZ2bzNOWHVTTUlV?=
 =?utf-8?B?RzdWZGpWNS9EQWF5RERwRnd1OVhqeDJwbUM2ZVhRK2ZGMVpTY2xGV2xOTzhz?=
 =?utf-8?B?ODh4QXhhY3ZGOWIwamF4THlmNVlnZkhvT3BKZFNCN0VFcjVJY09KWTVrbmRR?=
 =?utf-8?B?alVFU0RPWWw2NGIvL2VEOFJpdDNHRi9KQjdrRG14Qm9iaE5nUkR5QzRFdkl4?=
 =?utf-8?B?SHNCK1ZrSG55NnQva2pod2UrYVpNOG1LMXQ3RW5ZbXN6TmZhYXVhd0dyaVE3?=
 =?utf-8?B?b1dnQnJUOGYyUkR0aEV4REVKWTNHYzAzWWQ2TFJ6ajVRb3NhYi9UdkN5bEpk?=
 =?utf-8?B?OHo1YzNPSUIyQTNFRDFhUllpbkdubmxDQVJDejQzQkJ1cTEvS3I4Q2dIS01C?=
 =?utf-8?B?SWpERHBRYXNvNjFGMWMrMkxFMnJ1MktocEhpWnp5clhXQyt1V3RzWksxNlkw?=
 =?utf-8?B?RzJ3a0tjS2JiOWpybng1Y0YzaUw4TkpqdHBzWjJ6MGwrZU1TMzB0dWpHUEZw?=
 =?utf-8?B?a1dyTlZNQnh1N2lTdWsxSjdyRXY4QnhXMWhybDZmZkpsUFVwUzJnZHVadFZ1?=
 =?utf-8?B?c0xBMEw3STM3TzRXMzQ3REw4SkZYSysxOU1DZC9WTUdFT1A1QnBlMlFVT2pQ?=
 =?utf-8?B?NjRzZmN0NXVNSThzMjFEY2J1dU1Xd2F5K2UwM2M2NEZNVGFYZ0x2WDczek8w?=
 =?utf-8?B?Z0grczdsbnlaaDVOWWxBK3FxRlJnRFZTUFBxWGMwZUREa1ozK1IzYWRpVm5F?=
 =?utf-8?B?MmtpaktIZWFCMER0ck9xSXFJSGY0R3IrYVZLeGR0Ym1lNjlpUW5UaldzMmV1?=
 =?utf-8?B?TzZINGxUcTJTNm91SFpiZXRBR0xvZi93MjZING1qSTdJQzVoZXNNOGh0UnFK?=
 =?utf-8?B?VFlqSmIxRmUrTmhMV1ZscGVmc3h3Uk94MEVGZVFXTlUzWG44bkJWVDk0TE0y?=
 =?utf-8?B?eHhRNCtYQjZqR0pyYVcvSk9uL0pwQnZ3b1p6RnFLZngrb1dkY3NvZ1F4bmE5?=
 =?utf-8?B?VXhuaEpkcDRYUG55MmxQbUdkMnNpdG81aXV2U25YejAyb3B5YllvL3RhQlJP?=
 =?utf-8?B?dXJCMWNPSm91U2R3eFByYlVGUDNhdGozTWN2WlpIMTVsUklwdFFaWDFqUjZq?=
 =?utf-8?B?U0daMVA1TXpGZEFWQWoycW93dzM2eW5zUW1GYUhTWWxzNE4wV2ZYcTdEVmpq?=
 =?utf-8?B?R0dON3paQmQ1cC9EdXR1WVBUTVErYy9TdVNwUDF1M1hCbk41Sm1qUjJXbjd0?=
 =?utf-8?B?Vy93Tmphb09vZ1h6ZHQ4bWlHdzV3QWpMOCsrRVBzaXJnck5wQWxvL1FEUG9z?=
 =?utf-8?B?QTFDNUFndDNyaWladllQQWFnSnFjaHFiY05VTXhlVC95STZsU2NDR0c1aXZF?=
 =?utf-8?B?UE52OG5rM3JPL0UrZFdiYzFwZFd5TERMZnU2ZitlZFUyeU1oblptTEZnZWFx?=
 =?utf-8?B?M3RVTHhXS0dDaWV4YjZBeWo0TDR1SVYrd29CUEpIK21VSzIwb2dlWXE4U1Na?=
 =?utf-8?B?RnFJS3N0clhkVHVhYXVVMFJYREZGYmtxOGl5THo4dC84OEZQSXd4aTFNK1JR?=
 =?utf-8?B?MTJTbEZYSnhmaG82NHVPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhWQVQzN2NTdXNjWnc3Y3cxSFlleVA5WTZBRE5BVzFpOFhscW96RjV5RW9u?=
 =?utf-8?B?V3NOUXVUQzRENFhXS2ZBczBFTkNmK2ZwNHlreU9LNDJITmFxY3NqUTQyaGw5?=
 =?utf-8?B?U1FKN3VwYTRjNjl3V3I5Y1BuTHNPMUxZRkNvQ2d4YmhwVnhuM0dqVTIvQndI?=
 =?utf-8?B?M25zcDNUanJqbm51emRpWkxyYXpOY3VoL2NYc0ZDeWxQTzcwY1V5d1lKNDlE?=
 =?utf-8?B?eE8yQUZ6UVEyZnZCNjMwa2MwUys1d2UxUUpiNEJtNXR6cVl0SENEWTZJR1dE?=
 =?utf-8?B?VnVMMEUrd205MlVlUnNGWGp3TVZxTy84cGRaR1Qxd2dqUXluWjlVVm9kR2Z1?=
 =?utf-8?B?VC93S0djam5JZGZzSEJRNCtGblNPRFcxMFhHaW9RNTliU2xXYXd0Q1UyaDYv?=
 =?utf-8?B?L0l2Ynp3NXdxSEFnNXFTR2ZiendGNkwwb3ZPV25RK2JzdEM5MndIVVBFQ3ZL?=
 =?utf-8?B?WkFENDk0ZTdPMzYyMWlBOHVRVUJBVUVGczNMbWNwMitXU3dlT1I5dzJDb1Jo?=
 =?utf-8?B?VmFYVWZLN3J4Zncyd25yWXdqSStkdTc4RjZZUS9XdFlMMExrZC9ZK05DNDhv?=
 =?utf-8?B?aytzVEgvZnlMY3FaQ0VRdG5ZYVZhVTd5TEt4NmlwaTk1akZEYXhBdHY0SEJH?=
 =?utf-8?B?aFVYZVFWZDlMMnpLSDRDRElST2JoUUJ4QXhyOGlXeWNJTjUvblV5WXFBaFJz?=
 =?utf-8?B?UDB6aUMxdUhGQlc3bVA3WndHOENOT0pwcW5kbHkzcUlLbGM0QW12ZXhzb01v?=
 =?utf-8?B?bmIzK084MDJoWjgrMU9oUnZMd1RQak5aRnpZUFlDZEY0aTlvS21RL2VmT2VG?=
 =?utf-8?B?dktCcXdqeU1DbDZ0NHFSQXpYSGZINnRKNVB4cmx1UkE2RnBybWtIeTZjSnRt?=
 =?utf-8?B?RUY5aisvVjQyQzVnbDU4MnUyMWVYQ2xCTEJTTjg4M2RlYytXMWJzWXZzZ0Nl?=
 =?utf-8?B?eW9jbHgwQURXUTFabERuWHVkZ0dNaC9peEU3Q3puTjU3MTdUeUY5MjVhdWwx?=
 =?utf-8?B?YjlRM3JkMW5UdWhnbnJkdzhTMGhRNWd2Q1NXRnJZQ3VNRVhOQ3haWnlocVNJ?=
 =?utf-8?B?RmJ6Zyt3VUtZL0xQekxvejdQeE5zb3ZWbEVYTzhnd3BsNjVUTGRmS2t0U2dS?=
 =?utf-8?B?dDIzb2Z3V3I4ZmJZSFVKazRCOUNNUmFrbWZPc1p4SmFTcytWVDFDbENnN0dr?=
 =?utf-8?B?REtaL1VkUFZMbE5OUVI4anArMVVhSUF3Z3NPdGFXMXhaZTY4UFk5TmRpUVVu?=
 =?utf-8?B?eEpiSlhhbUtpSGdiNVBCcStSdXVaWU1CRUJFVTNoOE5XSHRBK080NXA0cmFp?=
 =?utf-8?B?RnNTZDlXaUkxNmk4d2trMzhSTkY2YjloaUxFS29xTDJrRm9PYVVpQTg2MTg2?=
 =?utf-8?B?ZmlXVHhMajlGdWtXb1QyRTV4aXorbmM3bm03UzBDMGVXaUZSM091MUpvTHl5?=
 =?utf-8?B?Qkp5UWlCSmowY0xMRlQxT1NYcDN4VWhsTEt1SmRjYXA0aTJWemVDQmJZZC9M?=
 =?utf-8?B?dVJKRkIrOWkwdmNXMTRlN25POWdwbXBqU2JmWGx5UjkxeWRCeVYzbnM0Q1lt?=
 =?utf-8?B?dFhPR003OENyT1lKRkZRL3hxbzVpQVZiUm1NUFhWN1p3WU1wRTJCd0VZZ0Ja?=
 =?utf-8?B?S1ZKbXRUM3VjdkE3akI0VTZEOFQ3VDJRREZPSkE5S1M0Rkd3N3lYMGJyVXJC?=
 =?utf-8?B?MEhhS3dWVmcrRHZ1QTVBeFpSbnBqblA2WjAweUVXMnZCSmVBKzhLZEswK0hi?=
 =?utf-8?B?TnhYUHRpSmNwNWtYd08zNkwvSStRb1l5c0NuRGJGUlR4eXlHcnhxdXVyb2hV?=
 =?utf-8?B?SHVpUzZZendqUWFWZFpmSjROeVJvYVJVa0FSRXl5cnRPdFRqQUxJOVJrcGVv?=
 =?utf-8?B?OG9XZVhYZVFtR1QydVJCWVBoSUI3c2ZKaFUwOUxMWWV0NE94TFltd0N5Z2Nu?=
 =?utf-8?B?S1NaV0JlcTBEY0F5bXBleGJydnJlY2p4QkFvVHorVmxYSXluK1hHS2JXNzM4?=
 =?utf-8?B?NWQvOGtpR2RiUmdXZC9IaVJYazZwUTdqTXhkR1dRcUNNeXpmSW5NNDNHK0sw?=
 =?utf-8?B?OFRCLy96TG5MTjhURlV0YTZLbk1XUG5nRmpnNlBiZFhEU0pYTjBrNnU0OE1Y?=
 =?utf-8?B?WDV1RmV6QU5NaXNzcmNpVnE5K0VOUlJPazFTR2RlYUdsbmRJUHYxb0F5SUIy?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: abba3394-4956-48c0-a7ca-08dccce91fc2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:54:41.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pikn1BQ09TZU+Rpm7rbqstSRo29NWWPekGSRxE5HYDrI/FUW35STq2JKLbIHTihw01vn1fuBwi4jz9tmu8ohaS5Fem61kmoHAEzz4zfZe38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6237

On 04.09.24 3:40 PM, Frieder Schrempf wrote:
> On 04.09.24 4:32 AM, Adam Ford wrote:
>> Currently, if the clock values cannot be set to the exact rate,
>> the round_rate and set_rate functions use the closest value found in
>> the look-up-table.  In preparation of removing values from the LUT
>> that can be calculated evenly with the integer calculator, it's
>> necessary to ensure to check both the look-up-table and the integer
>> divider clock values to get the closest values to the requested
>> value.  It does this by measuring the difference between the
>> requested clock value and the closest value in both integer divider
>> calucator and the fractional clock look-up-table.
>>
>> Which ever has the smallest difference between them is returned as
>> the cloesest rate.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
>> ---
>> V5:  No Change
>> V4:  New to series
>> ---
>>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 +++++++++++++++-----
>>  1 file changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>> index 8f2c0082aa12..56b08e684179 100644
>> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>> @@ -550,7 +550,7 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>>  static long phy_clk_round_rate(struct clk_hw *hw,
>>  			       unsigned long rate, unsigned long *parent_rate)
>>  {
>> -	u32 int_div_clk;
>> +	u32 int_div_clk, delta_int, delta_frac;
>>  	int i;
>>  	u16 m;
>>  	u8 p, s;
>> @@ -563,6 +563,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>>  		if (phy_pll_cfg[i].pixclk <= rate)
>>  			break;
>> +
>>  	/* If the rate is an exact match, return it now */
>>  	if (rate == phy_pll_cfg[i].pixclk)
>>  		return phy_pll_cfg[i].pixclk;
>> @@ -579,15 +580,21 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>>  	if (int_div_clk == rate)
>>  		return int_div_clk;
>>  
>> -	/* Fall back to the closest value in the LUT */
>> -	return phy_pll_cfg[i].pixclk;
>> +	/* Calculate the differences and use the closest one */
>> +	delta_frac = (rate - phy_pll_cfg[i].pixclk);
>> +	delta_int = (rate - int_div_clk);
>> +
>> +	if (delta_int < delta_frac)
>> +		return int_div_clk;
>> +	else
>> +		return phy_pll_cfg[i].pixclk;

I would also prefer to use a helper for calculating the closest rate.
Something like:

static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
						 u32 int_div_clk,
						 u32 frac_div_clk)
{
	if ((rate - int_div_clk) < (rate - frac_div_clk))
		return int_div_clk;
	
	return frac_div_clk;
}

This can be used above:

return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
phy_pll_cfg[i].pixclk);

And also below in phy_clk_set_rate():

if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
phy_pll_cfg[i].pixclk) == int_div_clk)
		phy->cur_cfg = &calculated_phy_pll_cfg;
	else
		phy->cur_cfg = &phy_pll_cfg[i];


>>  }
>>  
>>  static int phy_clk_set_rate(struct clk_hw *hw,
>>  			    unsigned long rate, unsigned long parent_rate)
>>  {
>>  	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
>> -	u32 int_div_clk;
>> +	u32 int_div_clk, delta_int, delta_frac;
>>  	int i;
>>  	u16 m;
>>  	u8 p, s;
>> @@ -602,19 +609,34 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>>  		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
>>  		/* pll_div_regs 3-6 are fixed and pre-defined already */
>>  		phy->cur_cfg  = &calculated_phy_pll_cfg;
> 
>                              ^ unneeded whitespace (comment belongs to
> patch 3/5)
> 
>> +		goto done;
>>  	} else {
>>  		/* Otherwise, search the LUT */
>> -		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
>> -		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>> -			if (phy_pll_cfg[i].pixclk <= rate)
>> +		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--) {
>> +			if (phy_pll_cfg[i].pixclk == rate) {
>> +				dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
>> +				phy->cur_cfg = &phy_pll_cfg[i];
>> +				goto done;
>> +			}
>> +
>> +			if (phy_pll_cfg[i].pixclk < rate)
>>  				break;
>> +		}
>>  
>>  		if (i < 0)
>>  			return -EINVAL;
>> -
>> -		phy->cur_cfg = &phy_pll_cfg[i];
>>  	}
>>  
>> +	/* Calculate the differences for each clock against the requested value */
>> +	delta_frac = (rate - phy_pll_cfg[i].pixclk);
>> +	delta_int = (rate - int_div_clk);
>> +
>> +	/* Use the value closest to the desired */
>> +	if (delta_int < delta_frac)
>> +		phy->cur_cfg  = &calculated_phy_pll_cfg;
> 
>                              ^ unneeded whitespace
> 
> Are you sure that this is correct? The calculated_phy_pll_cfg is only
> set above if there is an exact match for the integer divider. I don't
> think it contains the data you expect here, or am I missing something?
> 
>> +	else
>> +		phy->cur_cfg = &phy_pll_cfg[i];
>> +done:
>>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>>  }
>>  

