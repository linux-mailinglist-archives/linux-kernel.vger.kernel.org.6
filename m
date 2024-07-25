Return-Path: <linux-kernel+bounces-261786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEA93BC15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25EF1F244FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3A31F959;
	Thu, 25 Jul 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="GFXNZ5NV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2E1C694;
	Thu, 25 Jul 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886021; cv=fail; b=LERzodX+YtBOTDOGlOArGZNGBYbb93v1YTG7c/rm6RRmn/bS5h2UU63zMlFM3qmq8goeMl2dmyfZQkGudX88J8MAD9Ni7Q6aV/wR4LuVE4JPmcJ/brsfyZdFTqrzN3qRfi9d+PFhTEcth1m9eVcYHvwyVaRkdq4xPSazh4XME3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886021; c=relaxed/simple;
	bh=BhCxpNfT3YROjOve3gXmVwb6obleccPpAse8tHXfhHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQzktpxWm7pXIWrxyCUNaYlmttfWW+jXaObr8Ml+YMLFwPab0s56Dwc1V7Zs4snnzwVBO4n5J3rCv+4h34+CVYmO0POG2hpvN9MBewa6MHi+sFnCywKNnkOotiB8ho32z3hm+7QucjCV2aZaVr25rfDjOZHrKAO3X/nWBPmpR48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=GFXNZ5NV; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlvPjZgVDY2+yIjo5ExOousCwYqA0jNdCTj+F+UJH57LjeYyv+3rPmR9dC8NeAgixEr8e2k8NDXrj2rF/0w6l8DNOw6wdsHHLq17Yj9fg9MHGlAKJinsag3Wc0zj1YxleTjTRTuP4WxNJiV0l2pUjBBeXuqUUIaPqI/lV62f8KCAJoqwLbuUQK3hJDcuH+PrRmdKoMR+NSa5OGGptzO+BlkQifdV+nTtISCrbXOYdYtMCd7RZCfL51ZZgEOXbjKVdfHGKILm3hNQySQDzdwWXVW1fMcDHGhK17mcrnM/K+QsE8EgbFSfMMb/699FCF2LCEjy6Svd1AvGMNil3m4brQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTFhMUJVoYGvd+QSSh782T6A9VqAw5KTdtcCXa6UwIE=;
 b=nnwY9e/iD5ToiTn3MSeNT71T3fHNH+cc2/rRopbXevE+qJllSHv4gsza7TkrruhtlN9QFSJVaIxIuwYUbuB+Bp8GKkXkvxAWVWKUYwXV52rTcxmuBTfHelBOTTxdDUMQEvxI4IA+XekjN7u4jrtdM78ISSJdjRNjJEuDy3hYC2PY4eynkhT7HLvlF3q//cEuuHA47CqDbcuZRODM+8MBy1U1jKTj8pjXN8T8pQd3xLQqQ+ndU8oaX2loL+YtY28IxeRCEaXZjTdh9imXX84YtMbxLu4fHsMcxsaISBR7xL0IA2G41Lno561NEv+E9jjIZ53q6qkkkORrNqtHvU6CNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTFhMUJVoYGvd+QSSh782T6A9VqAw5KTdtcCXa6UwIE=;
 b=GFXNZ5NVc3bkiZ0INEtc3XOjgacb5tHo6NQ+La6Jdc5y3rmGmynf+DmGjebqUdXBkBeEvCVKYZPiy1bYbfUvflnfGgT8cpvkSC+iNsRMRzmSS6gcMjb+80zNusmaq5JMkagyffL4/avrBPu3zM87sZDynnXPsONWhR1DCh4EA2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DB4PR08MB9190.eurprd08.prod.outlook.com (2603:10a6:10:3fd::21)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 25 Jul
 2024 05:40:16 +0000
Received: from DB4PR08MB9190.eurprd08.prod.outlook.com
 ([fe80::c7a:6978:9afa:19a4]) by DB4PR08MB9190.eurprd08.prod.outlook.com
 ([fe80::c7a:6978:9afa:19a4%6]) with mapi id 15.20.7784.013; Thu, 25 Jul 2024
 05:40:16 +0000
Message-ID: <4800085e-1a75-4d14-9f0f-f4161c4af505@wolfvision.net>
Date: Thu, 25 Jul 2024 07:40:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: typec: tipd: Fix dereferencing freeing memory in
 tps6598x_apply_patch()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
References: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20240724162356.992763-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0060.eurprd02.prod.outlook.com
 (2603:10a6:802:14::31) To DB4PR08MB9190.eurprd08.prod.outlook.com
 (2603:10a6:10:3fd::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9190:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 21897b8b-382f-4585-4a38-08dcac6c42e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE5FYmpHYzBRbWNQcTAvaFI3eUNieFVsSmpRYWxKRGNTdWVGd0RrT1ZDL29G?=
 =?utf-8?B?aUNHaUNXdWhPQ2NVaGVSdDB6UmkxYkx0bUdjWE0vdWQxUEpyVnZaV3AxaHRs?=
 =?utf-8?B?T1FEdnVyYmN2dkFQdDZhMVNWNE5LYUlRTjRzdy82cVk5a3J6TzhiTmYySkxh?=
 =?utf-8?B?ZzYya2xWbk5ORkVEVWt0RGtySnlGYk5oRzZPeExSeTJaTlF1M0FqSlVXNE0v?=
 =?utf-8?B?SERLSkk5SW91RlYra2dXN3pxY3FXS1JjL1lxQlFNR0NSNWFTeHQ3MFNNbWZk?=
 =?utf-8?B?NmJKcW5OZGErRzJpRUJmb1VHWXdVYXIzRms5VEV2SlNRQStFU1NHeC85cDdz?=
 =?utf-8?B?c0I0ei9RRFN5RVBQUkduWW5wMkFaVjZrUFMyb2t2aVExRmNDUllCQXU1ZW9m?=
 =?utf-8?B?eFZjbjQxdmdranQzb3Q5bG9FVFkveThxdDVkdXRLYktUY3IvSVZwbVVCUWVx?=
 =?utf-8?B?dTRIRE4ya2ZnMmtHVldMREFhbWVXeHhrTzlMSHRLQnl6VUp0S1RZOUVPTXln?=
 =?utf-8?B?c29JRmR5aVI1M3hIS0o4U3d2a2YxTjBjYzJQS0V0Mk12Vy9UMU1FRitIK2lJ?=
 =?utf-8?B?aEUxb2JnNk9malRlbVRDdE8rYjdGMVc3M2NCN0dFZzJNaEZISS94RUpZNG9D?=
 =?utf-8?B?WldLQTQ0VlQvb1ZaQ0Q5OTlKNjA5NnYwOEQ3cWM2bFA5eXhTMVExdDhOWVZk?=
 =?utf-8?B?WW5oWGJrRjlPanB4MEY2ZWc2Z29wcW1oSHpoTFZmSXFQS0xRKy83b055ZjNU?=
 =?utf-8?B?dEloamszOHBWem5UamhxQkVNM0FHdExNNThzVEJacUFCQ0tEMzhQbm1UR0g2?=
 =?utf-8?B?UUNIendQTStQYWx6TEZxVUt3cGpDd29LcFhqRTQ4UTBocnNBMnZ6ZDBvZURS?=
 =?utf-8?B?TmFMb3ZGMVNiL3BocFJNdEsxTEtsSVpBR05WbGNSWVptUTV4NVN5SW0vT1RI?=
 =?utf-8?B?VlNLUUR4eVdCNllPU2srVWxCZVNCUU5McXUyc0ZHcE5IVzU4cDZvdjFnN3Y1?=
 =?utf-8?B?ZmJBZzJLSFBqWFpsZmpPbDh2WXlJOElmZnN3N25wQ1FQeUxlTTkxdHE2aC9W?=
 =?utf-8?B?YmI3ekpmQmZyZ1gvQ0hpenZ1WEhNOGJDOVRxb3VXSTkzVEhrMFpPaEFZUlRr?=
 =?utf-8?B?djdUT1ZpVTIwRWRyVDlpZVVLcWdRTTZiTENrNytpdTVKQ2VDaWdBRk1QSGwr?=
 =?utf-8?B?ZU5UNm5VNVZ4RTJPd0p3RFRhVTFmNWlac3BwSlhuTzd1aWlLZ09TYUN0WkF3?=
 =?utf-8?B?cTFsdTczTFZuQWxPN2p5RlQ4bFloRi9jSloxL0Y5NWJuQUJDOTNRSjJFb2F6?=
 =?utf-8?B?elFYY2krU1NkdVYxOW9ZWGtySUtCRG16Ty9XSm84UjdEWXJiUU1wTXlibWZH?=
 =?utf-8?B?U0hxY3lnMUFoQkplb21oU3ZhQlA2UWk5ZDRrRG1tQUNxN2JNczdIMkpNTlJS?=
 =?utf-8?B?ZUlVSlJuSWhPZzdUQkRwS0JiRHdhaFY0RTJKQ3BscVhPY0xDcmdPVUtLZzJi?=
 =?utf-8?B?THNvQ3I5NFU0aWlJY1ZHN3ltdUwxOTNaeExtMm8xUVZWNW9zWk04L0hsTmJm?=
 =?utf-8?B?c2t4RjJ1ajUwUHFVUExLY0d6Ti9LYnFtR21Ub1cxTWd4UFA3MUk5ekxlQTZM?=
 =?utf-8?B?ZUJyRyszNTcva1FDejMwL1haMEM5YWRybWlVaUhCN2hhZDdYZkxQNjFYRURB?=
 =?utf-8?B?MjgwNiswNWdMZGFjVkFxdmdleUJpLzBBNHkwTG8wcWVjNHVQUWU2ejZKd0Ey?=
 =?utf-8?B?N3k1NE9aL0h0enpjYmV1dU96T0dmR1I2ZTg1UmJlb1RPZ2MycXVDTEFHYWc1?=
 =?utf-8?B?SmlidHhUcmVWMzhPUER6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9190.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmo4Z0FYcU9OYklrREtqOGhPV2d6L2d2TTZxa2tPdEhmMWhtUG92cDArOXB4?=
 =?utf-8?B?QUZ5bkNCUlBwWnR2VnVwem1VOVc2YnVkaUxvTFlQbXgxNlpDcnBxanZaK1RS?=
 =?utf-8?B?QXhBYi9aMTdQT1NIeTZSam1kdElTbHFIZDc3UndXamhxa3ZtaXZhWTZNOWcx?=
 =?utf-8?B?L2tiS2FMNXl5Mm9rUElIWEJ5d0VsYWhjQk1TSkJQTUJ1NE5vMEZVRCtja2Y3?=
 =?utf-8?B?cWFoK0d0TGVzdUk2NXNodi9yVGg1ZmQ5MzZyNC9PeGZlc3RHWFovMDVUV2RD?=
 =?utf-8?B?WUdZQXkxNzFLeFFpUmdkek1vWmRhaktSZHJETEllaVYzUEVocDRtRTd4Z2dS?=
 =?utf-8?B?VnpreEljeVFCNHNxQWRKWlBoUkF4dHM1cStsYlFvOUkya1BBemlNYW10aVRB?=
 =?utf-8?B?ZGQveDJlSlFxSzYzbmdyQWtoVWFGWFB2TzB5SnVOTzcwa3JPSUo2VkhGVTFn?=
 =?utf-8?B?c0xtYjh0cG8yc3N5MDZxVnhCcUFycnlDU0NEdiswTmVOdmh6VjgyRWc5ZzlT?=
 =?utf-8?B?QS83aHhTL1RTeTk4eGduV0NROG05UlgwcGNsM2h1WDBNOEdmN0l4cjRqQTJZ?=
 =?utf-8?B?WFRwNmVlaFhaVEREMS9CWEhkK1MwdExUeFJBKzdjRHJQVkU2RFRyV0dTZzd0?=
 =?utf-8?B?cm1RV0U2eis0YWo3MXhBU0hHd3J5SWUrUkE4dXFBMHVva3p5VHpGY1h1OGZp?=
 =?utf-8?B?RUNhc0VXL3dabGxGQVVrSWc5VHVubzJjODRMbjlaOTFCQWpNbWs3ZzRCTm1B?=
 =?utf-8?B?NDV2T2V0dDRqWEtCWEZUbEh4SGdiU2NFbVpTU3d6VFkvUFdnazh3cDFoWmRD?=
 =?utf-8?B?R01rRWpMZ0U5YXhZVUxLZWYza0pnVTNwdjZPQVRSNWN2RWE5Y00waUVRdmJQ?=
 =?utf-8?B?RFhYTXhHZ1NHVFpTcHRlTlYraUFJZ0dOUmVFWlk2K2ZsYndwN2U3UmFXMUtF?=
 =?utf-8?B?TktzQkY5T2wvTjllNlZFdHJ0U2dJcTZ5Y0pBeHpSLzYvd1phYjNtT052MUlC?=
 =?utf-8?B?YkhacE1pU25Ob0ZYNUM4V0NIWSs3Zm1uOHQrdlVkOWNDOEYvbFprOGV5SGNp?=
 =?utf-8?B?N1BwbEhkNk9iRU5JeVdrSFYxeUU4eGFhR2J1Mk11eFBaT2NXMFl4eVNnSFlT?=
 =?utf-8?B?ejBZVytrandENHVIZnhwOUtiN0VJUjNKM1lFSVJxcXFMTHJiTmFIaE13RTdU?=
 =?utf-8?B?dFYyVlpNMmt0dXlsOGpzcFJZUDZVV0EzeUpxVS9qZFUwNVFZajJsSVFtRkN4?=
 =?utf-8?B?bEJlZlpHTTF1TG52bkJPVXZRTTViOEJWekQ2SUlobTcvQWhPMUNtdnI4VFdV?=
 =?utf-8?B?eGwwWG5BN1RRWTRYMkxmV2tvS3hxN0JzczkzRGRYZEpWUDd2VU05dmVCUkpN?=
 =?utf-8?B?WUJORkF4dC9DcEpiVEJmbUl2RE95QXZFajhwUlhkZHZDL21FMWNDZ1hsTGVI?=
 =?utf-8?B?Q1MrOXZRMktLSHlKSTUrVEhEdE9kaVc2S25oOU94NHlrcTQvTnhBVjJacmxP?=
 =?utf-8?B?ZXllaGhIb3VXZ2F2aWFCeUpRQm90a1R2ems1cERKa0R6bGdUODV0OFZSRytD?=
 =?utf-8?B?bUdXRFRyTWNPNER5WkJCWnpmSmFoV1JDMHVrLzQweDhtcFY5UHRzODBObmd3?=
 =?utf-8?B?N3V2bnQ0Z2xRYjFMdm1MZWE4SmZzTmkzUlB1NzEwYkNVN3JQcjZIUXlqMDZZ?=
 =?utf-8?B?am1VVDBHMURZd0dSN25oenlKU2dZck11NHpJT1RKOFhOQk9yWXhwS3M4bEd1?=
 =?utf-8?B?cUZ4TmFuTVIxc09tR21PQWNQbHgrQ3FKTUdZbDQ1ZzU3N3lMMVZhNVE1UkNX?=
 =?utf-8?B?TldQU1RGZlphL25xV2pkL3psL2Q0L2NscnJmdkpTRTNVN2hma1ZTSVF2Z1dS?=
 =?utf-8?B?bnhlNDNJMFFKM3k3ZUw2VVYvQ1VSWWxDK3JDSDNHQXQyU2lqTmVDQklwN2hY?=
 =?utf-8?B?YWdpakhxS0xBQnpscExLUnlUVHZJWXhqUTVKZU14V21yTExNNkhSTCtSc3c4?=
 =?utf-8?B?SlcyaUxWOFpqWmdUd3Y2WUdBSU5Tb0srczhxMHlqSy9jMGIvU2luQ1RHV0V3?=
 =?utf-8?B?NS9QT2hWZ0lKVjBRQmxPM3dBVTlNTTNMc1VqSGtIN1UvZVM0cjZVanUvSVVy?=
 =?utf-8?B?N3BZOG5qZTJQalYvSU91QzVCVEhGYXVOMEJRMDg5eHVDT3ZYOXAvN00zWUdP?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 21897b8b-382f-4585-4a38-08dcac6c42e2
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9190.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 05:40:15.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXlQIzBuwVS+CoNEL7QNLMzIHJC7oA1gvLHefLW0L/mtRRJ2FthEIgd82HxNYmHQNlqra+BuKlpVRGSKZ4AwNq1Z791nocLWtNeMBH4lxEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

On 24/07/2024 18:23, Harshit Mogalapalli wrote:
> release_firmware() already frees fw, fix this my moving release_firmware
> after the dereference.
> 
> Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is found with smatch, only compile tested
> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index ea768b19a7f1..eb5596e3406a 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1191,11 +1191,11 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  	dev_info(tps->dev, "Firmware update succeeded\n");
>  
>  release_fw:
> -	release_firmware(fw);
>  	if (ret) {
>  		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
>  			firmware_name, fw->size);
>  	}
> +	release_firmware(fw);
>  
>  	return ret;
>  };

Hi Harshit, thanks for the fix.

Reviewed-by: Javier Carrasco <javier.carrasco@wolfvision.net>

