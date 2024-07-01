Return-Path: <linux-kernel+bounces-236008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008591DC43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759D51F21DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197A13D53A;
	Mon,  1 Jul 2024 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="UmxkLC8d"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2091.outbound.protection.outlook.com [40.107.241.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3313AA35;
	Mon,  1 Jul 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829180; cv=fail; b=JqRfcun8jN3Qis5t0r19AWQUMA3VQbBt1eTquBB4mQIXVaXFXGpV7HzaUFsnjrus3GVoXh4NXfDCESvTs2kxz/nIPcTDFMHn0cADPk7hhmHUo5QUTgs6Tj7NqmO4hg4VCZ58IaKB9AiFzOljqfJJZS5hfy0YP4cr6I/xh59XJcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829180; c=relaxed/simple;
	bh=Fmil2c4Fx+EXq87GvPckOx0kP4Xchbih4B7cu4oBOI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D05KEyGwgqZNAvnS2QpvjRrwYYQO8UU1yGfSFADpPoMpeHsqWxVWDjIweG14gRkqIn3Ecd4kgmraZ35SbgQggny7bS+lCmRDIm1CvZhOb3ac4MXXWK+DW0a9NRctrI5NhNLxhCDKLmXcmduAy/wYQe1m2VWOFEaeTE7K8oqjc4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=UmxkLC8d; arc=fail smtp.client-ip=40.107.241.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJDprHkGYpUY/w+AjZF7QxZOTGl3rkcRsx1wCssCZUV0zyvGXMPz1svCzQVvjqssh0aIPITeqiAR95DKN4wsfh/Saw/0TyG+UYSU/1xaQZDlBhzxnbtQndbL+8G/8cWyphRpj9S1BcubH8Ro8IY//q+t+Pa2foAj/n5WP52GnupwoTadWsNFD3J+0hoZqTKosCSkickqqrbYQb1VriQpoSAp/j6OVJLaYpwfCyTHYS1Zrux0ZETvMiPSW1ZxWoXb3Nkdqpa7hj4CoXrI8ZEOxruu7R+NPxPd/V5AoPZtLavLFaBd9s/MKJv+2QeXrlTOFZOR7M0aCdrmK4gIwVR9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZF4HOy4vbZNSN+UaFe5GeLMS9nz8+uW9gp+azs2ip8=;
 b=XjP3ImB0JBTZHiy9WEKgBD5GTwtf6sW4FP2tdZmYaMSK8SWiqMTWImek+4znA4ozOJQ6RqtMX5RTRZe00qmbXgMng3KlYqIcGyztd2OYKxSlnByJrXDa0tQVhsz/0IZ8zLaiU6PcRKMpx8KHOkgebC/x3c4dD8gx7IEEHgha+VBtshcX3pz0S1sAcGT6POzRAcwhsKKFJDrN26RpSYMlR2rDnCnWXnU/x0C7p0XCanV++dr6sYqkERhvg6TEpjhLo8HT/rIglsKCIqGBIQObWAN9rvIWMDtmD2ir5qBs412UXU3rI5ofEeP4gyzUdQiE2h2AZwS+PqKXNG5aFVzPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZF4HOy4vbZNSN+UaFe5GeLMS9nz8+uW9gp+azs2ip8=;
 b=UmxkLC8dSJ0ReJ6xsfz48napXjREipyypPLVnNN+emx7ZUx84p7O26OZD2FC76aP6gIVHHlvMHYX/r+NqDcl6FO3h1H19v4z82m9tvaYc5rH1XG6we1FZnHl3B0ee2N+HN0gXec+nQLAI+OrOTSD7aq0z94Rtudy+mpbxlkWMfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI1PR04MB6829.eurprd04.prod.outlook.com (2603:10a6:803:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 10:19:32 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 10:19:31 +0000
Message-ID: <8fdb07b6-ef80-4faa-80cf-ea16839e9e98@cherry.de>
Date: Mon, 1 Jul 2024 12:19:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hwmon: (amc6821) Stop accepting invalid pwm values
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-2-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI1PR04MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: a8db789d-6081-43c6-7139-08dc99b74c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGFZSHlwdmZZcTljQmlBQXM2a1BkZ1VFU3hrUm5XYTVNU2lDa2JjRXdqRTFT?=
 =?utf-8?B?dytWdVVOU1J4bk9VK0hwR1VGa3J2YmZCb0VBNkU2eGs0TDJReXo1OGFvZjdt?=
 =?utf-8?B?WFhWWjdNYm5acXoyS1Y3bEtQT2hBa2NlQ1JnWi8xUFZBYTVtYlRzdk1JajE5?=
 =?utf-8?B?QzRHbEVDSVRhc0M0bWExUmoydm1hVUphYk5ScGdlVUxjdVUrdllQZ01wK0ND?=
 =?utf-8?B?ZFpPS3dZZ0FmSHpPdWlPajhpdi9raHpXeUFab3JrQW40aXNZdWR5bXV0TjE5?=
 =?utf-8?B?WGp1bkgvNWtjM1R4eVZJd0kzM0FoU2I5U3JxaXNVTHAzOHFvZ2pzM1RuV0pY?=
 =?utf-8?B?T0JidDc0cFNzR2JvYWZxMStISnRiQ2ZnWm5tSm9wb0FrZ1VxZE1ZRCswWnVx?=
 =?utf-8?B?Sklwa0I2Qis2dTdhTS8zeXhqV25HWWQ5VlZEQlZTSlVZSDBsbHBwOEoyZHd5?=
 =?utf-8?B?RzRncTM1cjBsRWNFSHNML1ptcG4yeWo3dmpuQlNWUHkzRi9LcUtLQ2lvZnBU?=
 =?utf-8?B?c2dwcWZXSmVzNkVWLzl3ZmN3YlhBUmVjdDIvbjVvMnJTM1h6cE5JbW5DUWxo?=
 =?utf-8?B?VnNtdEQ4TmUyNmhlMEZXYUgwUXl4QTVUOHJsc201SHQ3NFoxVFhXY09zeWVn?=
 =?utf-8?B?OGp3Vml5Rmo5N3pNa2UwelBBOWlnczFwV29DZmtSMEYvWnNYb1lUNXgwTHFQ?=
 =?utf-8?B?K2VQOXFMWDFMbnVFQWNXaXFXVHFJMWE0aGg2Rm9mbVlzVGhCQ2Fkck50bE9D?=
 =?utf-8?B?L0VvWkFEWHVRcFdoSnZOTmVoUXhPV1dqLytYQ05DVTVMTmJ4WXJmY2JDY21z?=
 =?utf-8?B?Q3pmOGNia0FmaHgzaHcvS0J0NjdCRnRua2pWSkRka2hpMlNqS0lEOGZwd1Zz?=
 =?utf-8?B?T2dCNVllN1BPaG5ST2ZQd0d6cVUzdFBsOFZ5ZnM5RHFHUlNnZVpqVC9XcWMx?=
 =?utf-8?B?RVdKdElhSW5GM0wyNkQ2VW1TVWk1RUJ6enNrQWFlemtNQ0t4UDFYb1ZmNzVq?=
 =?utf-8?B?cmRoeVpIZ0k1dE5tRndPYUFKU0RrYk9kWTRtTVlRdHNIeDBJNTJpcEsya0dD?=
 =?utf-8?B?MzhIQ3BxNXFuK01hNmkzL3pSRTFNcnhuTVR5eDRaM2xRM1VleVZtL09iQk8z?=
 =?utf-8?B?YndXRGVDWFVGZC8rS0VCTSttL1d1YVJwbWI1U2xpVkUrVk1INnFNRlNuNVJa?=
 =?utf-8?B?OWJORUFVWStjYnV4TjNsUVJNUTFLTUtVRGtTZExXNnhPR0VWQld3UnlxaDY2?=
 =?utf-8?B?eUxURW10SlYzc2lxWUpQWFBCbklacXYyMkM4WjlXWnVuV0FMWjdlaU9OeGJS?=
 =?utf-8?B?WjRIR0NCNzZ5dFVpQldIZ0U1Wkd5R2FUc2Q4bkhFL0ZnUk9uTXBVSU9kajdB?=
 =?utf-8?B?aVRBM3QzZU1ucEdhWmJEYUt1bnN0NENLaXk5RmJ4Nmh4SXFSZG43VXJUWFJi?=
 =?utf-8?B?WXhvM3doR1RtNWdGWVFPR3plUjZPVEhvOXlWZ3RQOHdaSTFTb3VINURIQlRB?=
 =?utf-8?B?SEVlSnZNNVFxZ0ViaUFTWmsyTXkyWHh4aXI0S0JKOFhQZ0pRcEJNenFIbk1H?=
 =?utf-8?B?ejNCY3BneVk4aWN6Z0tSMUgyNWNBUEJFdUlBaFlZV1lldEljbzJsZUpBSFlO?=
 =?utf-8?B?bGI0S0hZSlVkWjhOdUVyWHk2Y3B1dlNQK0s2RlZBOFZ5UDRSYldrVGlVRG1J?=
 =?utf-8?B?c0F0dWYvSHNtNlNOVXY0RXNFVVJHT0JBdHZvbm1KYWliRldSZlhubkNmS25F?=
 =?utf-8?B?NGU2VHRTaGI1Ry9Dd3ZvRng4QkhlVU16d3d4UzdPYmw0U05TY2t6N1JEZkpR?=
 =?utf-8?B?TC83aW5USUZDWlV2OHVYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTZQR1RwekJ2ZnJzZSsrRHZTdU5GTEcxV3gzMFhra0oyY28zenZONm95UytD?=
 =?utf-8?B?OUlUdVFkeUJvdnRyNE53d0RGaXV6MEpabjkvU3NZTjdVUHg4L1NVa2ZEU1FT?=
 =?utf-8?B?anNmRmFCN3NMRy9Udk9LQUNOR1YzT0VESWhTbWpiTzQ2USs3RU5HOEdodkJW?=
 =?utf-8?B?dUZ6UXFzeFRkY1ZaODhMUFczUWVqMWpFMytOMWM1NGtjaW9mZUI4cFZyclor?=
 =?utf-8?B?UkhuWFhObkNXNXZEUDhDaFU2VVB5aktTeDlpMHh5UmZFWEdJZVdxbmwzdWU1?=
 =?utf-8?B?aDZvT0ZWeHRIT2JrWXk0Myt3MlA1cHhCZHBWUXVhL0xxV3NIcWxzZkFhOXhk?=
 =?utf-8?B?U0Z1aHdxUHdCbUd4MVd6MDEvTlZhRmhJclRPbFBOTVJNSVhIeGlOT0FRU1Rr?=
 =?utf-8?B?RFc5M25LeWE4QVRWMjlqdUYxem01NmZHY3ZEdGh4T0Y1a1ZvQVVrQ0ppTGVw?=
 =?utf-8?B?MTQreFJMWXhnODRUanZZRFNnOExaSXZYc3NyVzVWZlNaMmd0QWVtbGZnRkor?=
 =?utf-8?B?aGg0VWlFRVJ2anBsSVViY0MwT1NIbjI2cHppUWxKOGtIdVF0SUI3WTcxMlhS?=
 =?utf-8?B?VTdyU2RhZ21oNFltZ3BXYlgxNDgwcndIR0JnSXZxTU9WV25SSlJCY3g4Q2RU?=
 =?utf-8?B?R0k0bDBYK1VWUDJURWxBWUdRZHNpWjNueHB1RWxPWE12OVhuMzlQWHpoQmY5?=
 =?utf-8?B?WE1pTis3Q3JYOU8xbnJJNW1pYjBBZTN0T3pJT2ducmJ0OE42d09NUFI3Q1B1?=
 =?utf-8?B?QitPNDdHVkY2bi9GcWIrSEtsYmJHbUliRkp3RlFDZTdFNE1CVDI3Y3QwN0VT?=
 =?utf-8?B?VGl3WVc0bXNtVmJ3cVVPSGo0VDFQUS9QMEMvNWxFRmJmT2kyKzJRSXcyeGQ0?=
 =?utf-8?B?MDB4VW1BQ1dGQ250dVNsUTZ0K0ZHMTA4NWpJTWRraFFCUHZyQU9pRGNJMjY3?=
 =?utf-8?B?MUxKOG5tZ0J0VVUwd3hFTTI4eW13RnU2M3NQK2krMzJMQ0dteVdPc29XcjY5?=
 =?utf-8?B?bWFxa2Yrcis0USswWFM1b3JRa2Y1QXVOKzdhQ2hzOGpaWWdja3dnOHJ6VVhT?=
 =?utf-8?B?YzVaby8rUlp0V2tHRDNlalN4cVptUGFUZ2tUdlhUOWdwbkM4N0tpdEQxT0lX?=
 =?utf-8?B?cFQ0TDR5SVBqdG5WTjRGOVp0QVc3aWNqUW9PWjE2QVgzVlZvZzU5V2lzNHhi?=
 =?utf-8?B?T0NYV01vUFJZeXBqZ08rRm95UWkwOUZIR3o4aUEyamtJNGR0bDlobm02WEJW?=
 =?utf-8?B?cWhRQlFlWUpabjlNL0krbE5qdzJFODJ2SEhZN1RUcTloaEMwKzVYcVFTNTV2?=
 =?utf-8?B?SXEyanU3ZUtlTlZpWlNKSmEvQ3V4aHczME9iYWR4L3M4NEZWTDhJQ0lvSXVh?=
 =?utf-8?B?bGZuQlVHYUhvSmhDQ3djdDhxOFBGRlJPNExMWmtadXBwUHJiQTVucmk3L0FZ?=
 =?utf-8?B?Rm9uSCtxZnpzYk9zWnd3NUV3ME1RYmhwWStaanRaS2hnbU16TjRZLzMvZDdQ?=
 =?utf-8?B?WGdlWndZazZ1ekgveHVUb3lONTZNZWZCS2xHd1l2azVSTWo5MWw2S1h6Rnl3?=
 =?utf-8?B?dmdnRktVMHVsekRkSWt4UlM1TG1ESXR6UG9hclRmQ1pyWXF3d0hHZkEzUWV2?=
 =?utf-8?B?WnQzRWR4dHlLVHA5YXh3WlkwU2ZScGJlLzdzcXYwdjUwenZWa0FabmxpVHlr?=
 =?utf-8?B?aEtCZndISVhTSCtDZTFILzV1MGNYbXc5ZThISnBSMi85Y0dVb09jZ0ZvOGxQ?=
 =?utf-8?B?S2FveGlVQXlDd2s3UHl0NGVHMVJZM1lSeDVpR2E4OGx5NmVqdmdqbjdsL1Bv?=
 =?utf-8?B?Nk43WEtwcUVlZXI0OG95MnczcmpYZU1SaHUvcVdSbkRMcWo0WmlTbUNGdHlH?=
 =?utf-8?B?d0ZjRmtUa25zOXNXUmJtRElhU2ZrbWREdFR4VHptLzQxQmlLeTJrVE8ydGJD?=
 =?utf-8?B?bTNaUTQ3OC9yeVlLZmdMOUx0TjNBTkkxRDltYU53WVNYQUhKV2szcDVDY1lj?=
 =?utf-8?B?VlFsSGpteDFSdUI4QWpzb0ZqMlFqdW1GOXpZT1cxM2NSSDcxK0VTcVlVUWNm?=
 =?utf-8?B?RVZJZm5hWnZHckFha3Jpbk1KdU9ib3FsVUcrMDczOElnWkZaaVFaUHRQQ0Qw?=
 =?utf-8?B?aWwyUVRqa0h5WDI2MFArb2hFdTI0MDU0Q0grK3J6dEdnNGkzWDZFM3FkUTBP?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db789d-6081-43c6-7139-08dc99b74c37
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 10:19:31.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWZ/72lW0iutJCasRDNtuZTfrk9oj/wF5riZRWyGT5K4IKPr/A69b5p/XfzeiQ+OiUugZThSQQUKGQgKwhba3atoH9FP6XtDq+7xTGalthk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6829

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> The pwm value range is well defined from 0..255. Don't accept
> any values outside this range.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/amc6821.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 9b02b304c2f5..3c614a0bd192 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -360,8 +360,11 @@ static ssize_t pwm1_store(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> +	if (val < 0 || val > 255)
> +		return -EINVAL;
> +

Why not use kstrtoul to avoid having to check for negative val? The same 
way that is done just below in this patch?

Additionally, why not using kstrtou8 so we don't have to do this check 
ourselves in the driver?

>   	mutex_lock(&data->update_lock);
> -	data->pwm1 = clamp_val(val , 0, 255);
> +	data->pwm1 = val;
>   	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
>   	mutex_unlock(&data->update_lock);
>   	return count;
> @@ -558,13 +561,16 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   	struct amc6821_data *data = dev_get_drvdata(dev);
>   	struct i2c_client *client = data->client;
>   	int dpwm;
> -	long val;
> -	int ret = kstrtol(buf, 10, &val);
> +	unsigned long val;
> +	int ret = kstrtoul(buf, 10, &val);

Same remark concerning kstrtou8 use.

>   	if (ret)
>   		return ret;
>   
> +	if (val > 255)
> +		return -EINVAL;
> +
>   	mutex_lock(&data->update_lock);
> -	data->pwm1_auto_point_pwm[1] = clamp_val(val, 0, 254);

We're suddenly allowing 255 as a valid value.

I don't see 255 triggering an obvious divide-by-0 issue in the code, nor 
any limitation from a quick look at the datasheet. 254 was introduced in 
the introducing commit, as well as the other 255... so probably an 
oversight by the original author? In any case, I would make this a 
separate commit or at the very least make this explicit in the commit 
log to show this isn't an oversight **right now** and that this change 
was desired.

Cheers,
Quentin

