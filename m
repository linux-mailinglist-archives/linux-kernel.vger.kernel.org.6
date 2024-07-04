Return-Path: <linux-kernel+bounces-240680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6CA9270F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CFCB2183B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C861A38C8;
	Thu,  4 Jul 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Xm6vkzt7"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2135.outbound.protection.outlook.com [40.107.247.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6ADFC02;
	Thu,  4 Jul 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079535; cv=fail; b=dCyZfsn9tstaplSdXXsPb6Ia3s5WI1jCbb+9pQ4yyMuancr6AsI26p7zbJecK93vV75VB28BzONz1kPsfUzH1bgeXfCifa7dvzqUjySW+C6k8L8ff6LFOiqld5tVSDue905xL8RHZrGqksXKEtnWUWjKO9e12qmj3t7LLOf2QZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079535; c=relaxed/simple;
	bh=zYo5/MgZFnHOZ5M0F+z/AgjwMblFYXZ1yE56OG55HXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N5wAtm/9gcUJUiByZhd+OpYfkpg93NbmOz/fAv3/CfE82m+I8qmTlyzcVJRhsT4yuVozBv3kAb//I21Q7DBzKwJeU6D6wAxMlzuXU4V1a1OxK9szcGLnCNbCeIh8XHyoPV6ZNQjtESipCJ2o/F9eQq5znlmdLaebvCBV4BvNNmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Xm6vkzt7; arc=fail smtp.client-ip=40.107.247.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeJ4+2C3qdg7wWzLRPS3AF6Twf/n3NG1sNG3MSdDjh6aO72RKSVNM1D4cmL42T/BrlkVRYE2SfJY9m93qXdpzhoEn6/OBCAuU5cDn2IhMUGw5Sp47s3ZJEjr33+eZVk6dwOl0AbMX3/+AppmxBXlYUzEJMUV4EHz+5BWOC8ircZ0fApLANBwJ189ptWSUVTUW47sYctxw7HG8LnOGtKqGPDpfvm05/a6B7xUGO17526Js2HjaxHv+PXtGmc81dPlDqDUA1RNobb8xO1LhRATHKNGUCF4UDjcam3gBmBD0K/6dYXjQj4Lq6ClWuIDnmreh/VNXe4ocscHCJy2CKPogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loiypHR9JeENJij9kOX4nKJGAV8vSBb0+aE3sIur7Mw=;
 b=B2hf+rahLDQq2sAxty7548M+HBWLmFD0uCjXzhtSp6NEzbqmv+dBs0LEZiwYBry8alE0lBmokZKISUZ823yQ/HFRlHIOI++bs9R713Sh09VkDRg0VeZB65U0zxwGddZeO96BYIAv1paIoQzXfm7Kw7G6G/cWgxpClFVfcYpzwSRnSVb3HEMEfz+68GNkEJTovgCDGruvJADKaiqXvAXMmJfZyGTd1wT1q2y836Fblw5v66siUGYWQ1T8iDWklrLFcktX9545TZMiLHO+tsOjmDGaxTIl4Xx+zgpi64Sf2bG+eGiUo9hHWcwEaVCJBoSjtgAHVqtTYIgjW5bS8kfA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loiypHR9JeENJij9kOX4nKJGAV8vSBb0+aE3sIur7Mw=;
 b=Xm6vkzt7SsvBQuXEfn2zDpMlkEPJLfiwFnqooEjRW3qSURN6NTFTiAj+YijX4jeI0vZCXlcLLJim8bdNrnmOy3QdYsaupLwXgOxjimadZsp8rLMDk4z652vYKdebriA4R6gt3zEB/do5ESSKDznzLa/TG6qh3cZWMUVVPTqn0P0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 07:52:07 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 07:52:07 +0000
Message-ID: <56ed417c-1dc2-474b-a2bc-5f17e1d2bd60@cherry.de>
Date: Thu, 4 Jul 2024 09:52:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hwmon: (amc6821) Make reading and writing fan
 speed limits consistent
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-3-linux@roeck-us.net>
 <750d28c7-4d90-4bd6-a910-4d5e73828e55@cherry.de>
 <8cb9dc38-499e-4f10-93a4-c07898a776b4@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <8cb9dc38-499e-4f10-93a4-c07898a776b4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2ccea6-1069-4e01-95a6-08dc9bfe33db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0FzVCtzL0NoL1pDckdPZk1OMzhFdi9XdlI2d29sRmdqcmU5dmxkeW5IbXJD?=
 =?utf-8?B?ZGFFemJCMHdmTmFaalJjT0JDQXlvWUNkLzFpRlFheGswSlJweUpyTUZRS1pl?=
 =?utf-8?B?VGFhNUNwYW9hRWpLL3RsZHZ2UVVZQWt0VCs2WlA2eDVKMHRvSjFxUU5oaGJY?=
 =?utf-8?B?QlY1dE1JcDNUYmdCZEI1RVcrMnF3dlVMR1UxaXlweHZwMkh3Tll2Y09STUxZ?=
 =?utf-8?B?elU3a2g3WUhFT25pU0NEUlRqWnpPamNSQzR2amhCcEwzRUN2WTc3NS9yMkNI?=
 =?utf-8?B?bzhuNTRGdG9GRm1HZjIvVG1DYVErQmxDMHdWaHNwWHdzU25hdGEvK0dtdHly?=
 =?utf-8?B?OGJWMTFhYnNRMjM3anJSaERsZS9YMVVRZWNzM2NPd0FHTWQyREQxQzZvR1N4?=
 =?utf-8?B?ejNZWllHd3A2dWl2Rjg0WkpxUUpPb2RtRTlwcEphQzZHYXFSWXdnNndyek8z?=
 =?utf-8?B?N3ZNRllCdkk0RkFRSVUzUFlrcVhUZDRCbmJ5SHlZYnZEajlqTjMyTG5MTjU0?=
 =?utf-8?B?eUNodHl5TnNQa2U4YWxkMHJUTUc4VmlMdjZwUmZsQlNVNG1lSytzS2lkS3hl?=
 =?utf-8?B?VkI5K2JNaFZ6UWVaOFZGU0s2Mkp4S1FqMlBEUElodGw3djBVc1pxV0R3UGZN?=
 =?utf-8?B?a2FRQ05vTFExMDhXSS9FOHp4aStFS0ZwQXFyV3hqQmdNdlVKREhFN1dRbmtu?=
 =?utf-8?B?aU52dUtEMGY0NU1MMWZndzNCcDdySWRLY00rQUlVbXcxNWVxVzhVcldsVXpq?=
 =?utf-8?B?YmpnaElTYXFkc2tQdVlWNHo2Y0tYY1A4UTVjUDRDOGt3STEyM29jeFlZc05W?=
 =?utf-8?B?Zk1IWk1QV2dlTlNIU2ZBd1grMjZVb081M24zRXUvOEx6ekFJRjJ1SE5DZVJH?=
 =?utf-8?B?Z2p0aXYvUUgyL0dOZ0NGeTF1QXhYcm9XOEpmMmI3SGJsc2hzbXNwM0ErMm5Q?=
 =?utf-8?B?bG1sbjFHVUlWUDR5UE9QMjhRY1hVcDhWOU9odjB3aW9RUWh0dVlIWURmc0x6?=
 =?utf-8?B?Tzd2Rm5mbGxQR3RtMDFyVXhvZzcvcU9TR2p6NlVEQWpVWDd3RDIwTURlSHFn?=
 =?utf-8?B?MVRUaTJnY1Nrenpmc0tZZ1I5ckh4ZG10c2RhbEFKb2svWFRqdkg1NzJKRGVD?=
 =?utf-8?B?UUM4blJ2YVppZ05ZWFUzd3FEZGFKWklvUDVhdG5uYUV5dFUrY20xWlZTcVcy?=
 =?utf-8?B?RlZ0ZU52aGtneVk3STlIYVpGVGdtelBxNjdaaXloWWRkZE9BMy9YUCtOb3o2?=
 =?utf-8?B?dEMycFl6SUJ5VDhNdVRhWWxUNVJnblloRW43RDhIWTBOWHN0c3RvNXhTWlVs?=
 =?utf-8?B?RXJndG5XSE5KeTAxL2luRURxTGdjRFk0S0V0V0w2VW5zVzdZckxXSGE4MCtk?=
 =?utf-8?B?SUVSNUtZRHhlWVBpREI3QUp1QWkvMjZaaEZ2eFhRTXB1YWZUelFLcjBYSDUr?=
 =?utf-8?B?T2prQmZUL05xSVhBQ2lHdHRydGxVU09QSGUvekMzTUZpWW96U1gvTjFPSEQz?=
 =?utf-8?B?ZUc0MXVJNEMrZVhuTm9WSGlWYURUNkk1Z2VmS2xnZGJSbHUyb2lrTi8zTGpB?=
 =?utf-8?B?bG5ra3BFRFhoV1YxeG9rM3ZjeFpkMWhTeHVhTVd6cFA2YWl3K1I2bHdHZXZ0?=
 =?utf-8?B?b3VWcXFRWDI2MlVBNmRmbXhEZGRBTzV0Y3A3OU9wSWN1Q3Y4bFJXcGQzTkFk?=
 =?utf-8?B?YUJlMStOcUQ2L1BwMk1NVnhtbDI0NmptcWVqalBpZFVOaHlkdE9yS3RnYVNB?=
 =?utf-8?B?UHV0SjhuTVZNUjhzYnVIUElBQ05HRzNjWSswOTI4UE9LVE9uSm42L01xWkFz?=
 =?utf-8?B?ekRBa3FNQXdFTEwwTlVuQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M00xLzNSWk02cE9iTHAwNy9ubHV5aXg5R2cyM0hreUpXNDhWZTc3dEZtM0pD?=
 =?utf-8?B?UFQ1ZzQ5aHc5dy81RGtEMVBvUUR0VUpjSlozL0kvcnIyTEdESVo1cVpxelhW?=
 =?utf-8?B?ZEVzdTRlQllXK3RHSjBPckFoa28rU2ZLOEJtTUplTklPbm11VHRFYUpaOGk3?=
 =?utf-8?B?b0xJK295c3FjZ2JtVm1ZcS84Z0JRRmVNa0FMUitQdjI5WWpuTEhYenV6d0Vx?=
 =?utf-8?B?OHdQUVVUdGJZREhla3dnTWFwWTVwOW8xUGNBN1FZYXROUDgyKzIxeFZ0VWx5?=
 =?utf-8?B?anEyNFpJd0Q3bkF1a0FGYXNIVUFRWk05RjlWVGFvVnJPaThhV1kwWVk1aUVR?=
 =?utf-8?B?dzczWWVlRzBVWnZucWdpNzd3VFR1ZmV1UUQzYUJ5T1lPMnZwOEFjVXRkSnp6?=
 =?utf-8?B?V3R5aVBQMDhDUGwzdVZqMHRLWlI2NUFiU04vL1JuTXZXRkxQYTRqamdWQSsz?=
 =?utf-8?B?MXFmMzcyUGxtM2M0dGxzeVNCUkk3R0I0NmVvN3FnTDE5WEFRM2tzeTg1UjEw?=
 =?utf-8?B?U0h2SC96WXZaVFhlYUowQ0hPV1NCMy9OOXNqRHJuS3M1RE5pczRXUUN6TzRa?=
 =?utf-8?B?dHVKbGdmZnNNWnNKZzU2ZjQwVGVtYXdMMW1teWNJNHhUS0NKcGVVSlNDKzl3?=
 =?utf-8?B?bGYwZkxDaXYybVJYOW1ZdlVlak0vZEFMV1RCTUdKUGJzNUVtdWU5TW9FOEJI?=
 =?utf-8?B?MnVsMjlQLzJvZGFHNTBVakZoZ09JdGtWUlJEQkpJR29EOE13dk1MYVdzMm1q?=
 =?utf-8?B?MGNkNWc3cnZCSWJ4VmhHWTFkQ090TFBwdEc1MEdrVENmTEN2c05PK1JoNVZF?=
 =?utf-8?B?ODJoSFdWcG5MU3FUaUxlY1A4a0ZoRkNSYlRtSTk0eGxVdlJTeDdOeGtkQS9z?=
 =?utf-8?B?Uzl4S1BVVzVEYy9mU1pEdzlSaGhuTWdha212dUNEc2J3aEFpRkU1WE5HUi9V?=
 =?utf-8?B?U05kNWdyVXpUWU9xZ0FyOVJCYXJ4amVwYUJXbkp1MHc3WWl5VlZnNkhUZTh0?=
 =?utf-8?B?WnpnUnBSMTJlRytoVTc2blFzcDZHcUVSb090V0VSRG95Tk9zbFZvWUVybk96?=
 =?utf-8?B?aEROMTJwSCtqcWJkeU9vMjEwcWZYR2V3d2NVblI0YnU1bkZBZzVQWThtYWYw?=
 =?utf-8?B?ZC84ZlJXUVJaYnZwUG5oZFlHZjlZZUtUR0kybmRaQ2FwQWQxMGdrTVVqd3h6?=
 =?utf-8?B?cno4VTdzQk1laHVtSnEvZ1QwZThNWFUwUDZVU1JxSUIwTWRLZ1N1UjUxekVw?=
 =?utf-8?B?c3hkWVBlQm9JdVNLTVZNQncreWIyeGI5SFIwNm9UMllWS2NsQzN2KzdCaUlF?=
 =?utf-8?B?Z1dEZ1ZncUI5TmlhWW81eVhaZWNRTEhGaE1rNzBITENrS2Npa3BERzR5d0Fp?=
 =?utf-8?B?Y1B2a1E1Z1UybE8wbWRZdkVmTjVFeGhiaEZKamNmL0ZYc0JQL0VXRlFVQkRo?=
 =?utf-8?B?ZENXQ2tZL0ZkRjhKUVZsQ2ZmbjFBS1JRYmRjZmxYQUNpMWc0S2VLbkEybmhh?=
 =?utf-8?B?K2x0aVQ3bElmWXp2ckcvNWw0b2ZPVE84UVlFa1VTbEhRTllkbkk0Vm9EOFRC?=
 =?utf-8?B?akxWaGxIclpwVU5kWFdZS3IyVDRJbDlWQWk5bGhYcGtFQkdpQllyL211YjUv?=
 =?utf-8?B?S1hBL0dWU2RaRlF2NkNUK2RSa1l4RXJzQXEzcGpuZmtQZHdPNzVzT2xDVG44?=
 =?utf-8?B?bmI3ak8vdGVJbXdXZTF6NEx5TjBtajdvS1RxMXQ1dWFRMUpvcFhrWU9Ra1Ji?=
 =?utf-8?B?NHBBTUk4djFPbExLanJWeURUY20xNDBOcE16ekdKNU02Umw1bDVBWmR6bm8v?=
 =?utf-8?B?TGkyalQrbzVvUW01RnFEdjI2eWl6eW0xT1M1UHgzekdhYm9MWGxEeHJpclpw?=
 =?utf-8?B?UWpVUXZOWnJQYjd3YWxLV2hFRHF6T1FmcHdFTDcxdGRJSVE5ZWk0NFk0QnR3?=
 =?utf-8?B?Z01PZm9rRWdNQUZpUFg4QTJkQk14TFcwYmVITEJHeVhYK3FlcVdISHo2Z21x?=
 =?utf-8?B?U2RTemFCTkkxOW5CeU45RVZxemsxOEtEaWMxZTdIMTlJK0xKTFA4OU1xcEt2?=
 =?utf-8?B?Mll4YVVlOVNON0lSb0tuTlpUNlhESjRzS0RYWWZlL0pLalJJQ01RSWh2OTU3?=
 =?utf-8?B?ZlpheU5SVi9jVE1pajBSV0xvYWZleUVhdjZ0M3Z2VU44VGJwajlwdmYyMnhj?=
 =?utf-8?Q?4y0w9a4Wl1fHpz+OaxvdyE8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2ccea6-1069-4e01-95a6-08dc9bfe33db
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:52:07.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8xpJnwxPVl+cP0IxcMzBP6WGiICxz2PcfTvVEvhlB4fUhvXwtKZFdQsg/fIdyYIXgMMcOIga4A6C1w9XHLNEagGuEwRv9bl2KxAm7PT/Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020

Hi Guenter,

On 7/3/24 11:48 PM, Guenter Roeck wrote:
> On 7/3/24 07:35, Quentin Schulz wrote:
>> Hi Guenter,
>>
>> On 7/1/24 11:23 PM, Guenter Roeck wrote:
>>> The default value of the maximum fan speed limit register is 0,
>>> essentially translating to an unlimited fan speed. When reading
>>> the limit, a value of 0 is reported in this case. However, writing
>>> a value of 0 results in writing a value of 0xffff into the register,
>>> which is inconsistent.
>>>
>>> To solve the problem, permit writing a limit of 0 for the maximim fan
>>> speed, effectively translating to "no limit". Write 0 into the register
>>> if a limit value of 0 is written. Otherwise limit the range to
>>> <1..6000000> and write 1..0xffff into the register. This ensures that
>>> reading and writing from and to a limit register return the same value
>>> while at the same time not changing reported values when reading the
>>> speed or limits.
>>>
>>> While at it, restrict fan limit writes to non-negative numbers; writing
>>> a negative limit does not make sense and should be reported instead of
>>> being corrected.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> v2: Do not accept negative fan speed values
>>>      Display fan speed and speed limit as 0 if register value is 0
>>>      (instead of 6000000), as in original code.
>>>      Only permit writing 0 (unlimited) for the maximum fan speed.
>>>
>>>   drivers/hwmon/amc6821.c | 13 +++++++++----
>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>> index eb2d5592a41a..9c19d4d278ec 100644
>>> --- a/drivers/hwmon/amc6821.c
>>> +++ b/drivers/hwmon/amc6821.c
>>> @@ -617,15 +617,20 @@ static ssize_t fan_store(struct device *dev, 
>>> struct device_attribute *attr,
>>>   {
>>>       struct amc6821_data *data = dev_get_drvdata(dev);
>>>       struct i2c_client *client = data->client;
>>> -    long val;
>>> +    unsigned long val;
>>>       int ix = to_sensor_dev_attr(attr)->index;
>>> -    int ret = kstrtol(buf, 10, &val);
>>> +    int ret = kstrtoul(buf, 10, &val);
>>>       if (ret)
>>>           return ret;
>>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>>> +
>>> +    /* The minimum fan speed must not be unlimited (0) */
>>> +    if (ix == IDX_FAN1_MIN && !val)
>>> +        return -EINVAL;
>>> +
>>> +    val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
>>
>> I'm wondering if we shouldn't check !val for min after this line 
>> instead? Otherwise we allow 6000001+RPM speeds... which is technically 
>> unlimited.
>>
> 
> If ix == IDX_FAN1_MIN, val must be positive because of the check above.
> The expression "6000000 / clamp_val(val, 1, 6000000)" is therefore always
> positive as well because val is clamped. Its minimum result would be
> 6000000/6000000 = 1. The alternate case of the ternary expression would
> never hit because it is guaranteed that val > 0. Am I missing something ?
> 

No, I misread the code and I didn't see the clamp_val, which means we 
cannot have the denominator be > 6000000, meaning val cannot be 0 after 
that line (well, except if it is 0 **before** already).

So no, just brain fart.

Also, we probably could swap clamp_val(val, 1, 6000000) for min(val, 
6000000) as val > 0 because of the ternary operator condition. But 
that's nothing important nor interesting.

Cheers,
Quentin

