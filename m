Return-Path: <linux-kernel+bounces-236129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224F91DDCF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAADB22167
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA213F439;
	Mon,  1 Jul 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="YPAapqay"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2115.outbound.protection.outlook.com [40.107.104.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3D13DBB3;
	Mon,  1 Jul 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833183; cv=fail; b=puVWqyosyDAOVgCYAH0CBanaYxyGkQEeCS8+1HtUcAvEwi1FcDAwSbeNXm9TJnUARWcRv3Ec+w98pEGxXRTxcTHLAoBmvH5UB43FCUYLyZKBffK1wjvntqgSj1+ti7OnvmClnQw2TOU0C+Dx3IZd+VOEPtx0oJ3LBjijb8x5nNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833183; c=relaxed/simple;
	bh=RY0w0iAbwDSIXaYmJIfmfFJxwBfHpYFk2RBRmPfzsRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UungAfpjIaS9hRBXBVYyTsmNKITXP4oVg8MRayled4F7YbVrFNa/FDmTE2OiUOz12APTg2hNIxm4csMFFQB/2em8hGwvAtNiE1bMAzgmW5KA+ETKlVFKku6ha5pn9znwt28B+wmT8IJz0iAiKo7PTR2YaVjBQG+L2xezPIB0kDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=YPAapqay; arc=fail smtp.client-ip=40.107.104.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiE+FK9TVhXaO3F07q/oPlniAePp4nx0BMfg4ixVgdSdXizWm3EnfG7KxIYeSt2tUN7iPimYqiKDFKs0TtFbXOtxjpO+7AYPSLJNOr2+oNPLzEsqgKkbKEuwIkiNcYTvSmwbawOgtFt+KuO9bD1THrj8w1b8/0tNxkpM/0AU5mcyhgHYww8FyeMn4fSjsmelcVw6gon1W+Xv+KsP1BRtbu/3G8pZDntmtwBtGSrdlXQfBd+OW/nMd6YU8PJcovsfKn0fYCIR/fgRENlvA+OviX3Q1Zov6BNTVNsWJEOutroCWFxgJ4x2gRdysJVWLM9ODlmjPXU7Q0z//XBbusypQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF0cn0r8DOkmqRBRvAEY44hJDUdC7Yni8efwG5C0Ddc=;
 b=a43MVAS10nt4mYK9dfmMmzdHiBUYpBBXhAHHVDclMIImQd3BDiXpDpJbYdy4jIk4yZYbVodyp/n7s1x9i6uLhFu7CPecGOoBvjyf1Ih1mb03gvhguY2IoqYxmKjlOkebFuCtIkzFIiDljfx+S+PuvKz5dcIeg/Dh5BYAvHx7EciqEMz56q6E+TWazKVpuG+ASHUfjAnWPyiiARz84B/cgu5aAQLhTSZt8ZOPbeizKhvTHm7YwWH1a+FAn1jYkzJzPLYQpZEAp0l9mbL+w2gDXxp2OsSHRYT/8fjF5dWrV8impCszn7O7AP1GXNcjTN1ZfzNbqO1R+uMz3WUWGVG2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF0cn0r8DOkmqRBRvAEY44hJDUdC7Yni8efwG5C0Ddc=;
 b=YPAapqaynZrqNQTbMZVdAs34OvDZgwODtZVffxS/KTUZlXP2v4ZllN75dbKoER9LIFCiPih89g910bmu/O/LYtHl2BoRTEMxrnOwB0N9q2QYKNEGFUlz/MjvPuhXNoZg0txEnRXAxH+atL/WiaVKM22qJaSMG0Uvdua5j78JWsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:26:19 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:26:19 +0000
Message-ID: <fb4169e2-b605-40de-9bb4-6c3b3297bb0e@cherry.de>
Date: Mon, 1 Jul 2024 13:26:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hwmon: (amc6821) Use tabs for column alignment in
 defines
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-7-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-7-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adcdcd0-c6a3-458c-cdec-08dc99c0a0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWtLU1YwUmZ3M0dRaUtEWkpkTXN3emtZZzB5ZTc1MmQxQnBWbU9WNDlOeHlS?=
 =?utf-8?B?V1Y5ZEk5Q0NIaDljQ0F4UTRTR1cxSjE2TGxyaHZRUWpSZ3J0Nk9JbGVJTEtD?=
 =?utf-8?B?NlJkbXJocTFBazBYUHhSTFNPWHpma0gvQ245YVFQQ2JrZGpOQXY5M2tOczFt?=
 =?utf-8?B?V0x6SXh2SUZyZTNSZkg2K1BCNGVERmJ2Q2V3NE12eE03SzkzN3J1aXZzdWRF?=
 =?utf-8?B?b2hVdkhJUDlnSW05Vlp3bUp2ckJqS3gwWk1ZK1hUUFVSdHNSVGljaTQ4bW1w?=
 =?utf-8?B?L01kMFlaZndIL0Vyb0t5VUE1NllwQU54UWluV2Z0SHVrenFSMjB2UjIwOGJ5?=
 =?utf-8?B?QXFrS0lSd3BSU2ZzM1BJclIzZ1NBUDhQRGQyb1crKzN5cDU0U3lIeUtYWW50?=
 =?utf-8?B?cGF3ZmtJR1VZUjFGSWtGSnlaWExKMUs5c2FwclJsSkF0SEZTYi92Q2NZWGVx?=
 =?utf-8?B?YTdhU0QwWEtUckhLLzdWckZsN0ZNVTA5ZlBaV1hHZlZXb1lMRVhSdjNldHVj?=
 =?utf-8?B?Y2VhSDlyK0xQM1V0OTV2WG5XRzdOWXJrT0FaR1l6MUFWeEU4emZkd0pPYktS?=
 =?utf-8?B?ZGVjZzdYcTJIdHppVkdtS2FjQ3ZJZ0Q4WGx5MWwvSjRvZHREaTYxZlJtY3pU?=
 =?utf-8?B?NXNkay84UGJHVTFsejl0dG1WZnh1NHhSREdKV2J5c2YxU3V4VFFVWU9vcVlG?=
 =?utf-8?B?UURuei9ZQW10ei9pVUFBUDF5SGwxZDZmZFBVS0FiY3o2a3E4WFkzYlNkSm9p?=
 =?utf-8?B?SEhNb3c1Ti9CaUtmUzlpaEI4dVNaYXg1Z2pQR0V2YmpZUmtoS3V6WkhFc1o3?=
 =?utf-8?B?V3pYMk16aERncEZLNWFYVHA2RFJ4c1BnV04vU1BVT0xCRUdEV0xGcll6OEM5?=
 =?utf-8?B?bWNVSVZSNXc0b2h6aFR0UnZEV0FGeEE3TVp6SXZYdkNxQ0c0SWdIZFdIaWJz?=
 =?utf-8?B?cXJ0USt4V1FidGRpaGJoR1RBd2c4OFZsQXJYakhRS3AxQkQ2MVRVbWx4Q2pq?=
 =?utf-8?B?MktkUVo3eVBJOFBmcjdLQ3I5U3JTS2JibHZEQ0FZWk41Vmk5cDRmUklObEx4?=
 =?utf-8?B?RkFzVnpPdzk2RjZGeWdONU1ZZGowZXhyUC9VYXBBY25tbkVGQ01PTEtyaVZB?=
 =?utf-8?B?WnZPdDFORlBOdWkxd0M4bUJtMkxXMzRrNjJIQ0NSZ3UxNHNMaThXZkpxT3VL?=
 =?utf-8?B?WUZranUxZlhwWEhEUi9jUFYwdGpaNm53UEVjOVYxYlQ4bGlySTJaODZwQkxF?=
 =?utf-8?B?d0J2VFB4VEc3blk0dS8wK2VqNTYrQ2czUk9IMmQxRzE3WnNhVnphdkJIZnl6?=
 =?utf-8?B?U2RuR0RlTzE4OFhoUEZlK2Y4ZkJkZVEwVVJjc2tLQUFzdkRQeGl6YmxjMnJD?=
 =?utf-8?B?SVdwQzhtZFUvOWVxdlp1M3k4YkxaeVJuNTEraE1adnRuUlZ2ckQ2Tm4xYVhG?=
 =?utf-8?B?amlhdExNb3hUUGtLcXNxSm8rMlJIbGwrODRSQngxUzkwUDJNWjdacWptcGFB?=
 =?utf-8?B?MllBVTVqWjErTThDSGNaLy8ydjQrT3BXT21abHJTTW0wMnIxTDNkQVdRT2Q1?=
 =?utf-8?B?VnlEZ2JEM21GclRubzZNZTJNQjFISzAwa05ZemRMM3JJMUF6T1VUUld0dlUv?=
 =?utf-8?B?S3ZUU2ZNaVlsS1FQTXBBWTBXcFYyei92S2paamxkUXk3WVBzMWtIbzhRWGZz?=
 =?utf-8?B?M1FvNkZKcnpyZFVlTEgvb1F5cHVhUFZvK1JpaytaOGdkOHhZd1dnTHFZREw5?=
 =?utf-8?B?TExIMExXcTJxOXZMOGJMQ242Ni9FNEM2UmVCWGJaUnlyWHdOWEhCV0w3T2Y0?=
 =?utf-8?B?VG93SDRRUHA2RnJBeE9Mdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SS9OUGJ3NDYzenVYYjhIdjZFRnRQQTg0RDFNTDRnUEV5bUhuK1ZxQVBmS1Vh?=
 =?utf-8?B?Vkt5WHVQN0l6Z3o4VXFzbmJsWXlneTJGbmRkYVovT0QrQ0ZxRjZpc0huQWpO?=
 =?utf-8?B?cU1VenZpbnpzVUsvR1BzblpoVHN3aWJSYXk2cG1sRlZWRGE3Uit4MDREcVky?=
 =?utf-8?B?WFFvc1N0NVVzdDh3NDllaUFHbUpBSGZVMTlsWnlacEpRNm5hVERhTFBDOUhz?=
 =?utf-8?B?b0oyQUF2dUpmNUpiMDh2UEhRcUZTdzY2MU9ETXF4VlJCellNbS9PVjFQOEFC?=
 =?utf-8?B?THpCc3d5cXpnVXNxM3BTb2FqMDFDZE4zTEFkYjl0emp0U00yZDJBVm40WmxK?=
 =?utf-8?B?dHZvSTYrRXlJMmwyZ2NGcFY3N0EzdWNlWXBQSXJyOWtmdEZLMXBtM3p5ZHhj?=
 =?utf-8?B?U3dCUk5CQjRhckpFSjVwSlZ6THdUWVA4RklFVVRZczRjTElsRC9CdmxyREhq?=
 =?utf-8?B?SG1wM0dXemd1UWVyNk1jUi80NTFuL2dnQ2lzYmNIQU5LQnlEZU5sSmVpT2tD?=
 =?utf-8?B?TDM4MGR0TWpidFY5V3ZUWkRqakt3V3o0RmM4cTNOWE5kdlV4QmdDOW5NaUYx?=
 =?utf-8?B?NktURExHYUdNVHBsTWppZ1RZQmNGajlBdVJpTlhDZjJnb05vRlRwZjVkS1FG?=
 =?utf-8?B?QW1ZdGdta2YrU3hIeEZsb05MRkVaWVlaLzJoaXhXUkYvZVhob2Y3QWJOaDV3?=
 =?utf-8?B?RVhrTGY4RjhGTW45OHJBVkVXWDQzaHpQZEtoRDFBL1k1NWI1Ump5b1B3NTZh?=
 =?utf-8?B?MlJ0bGlUak9qc2YzTVlUR0VURFNQeFhMVGoxejlDMldhUWNjQ1l0TS9lNWtl?=
 =?utf-8?B?Ri9nNGVqSHRMNC9QWjZlSzJrQUhuaVZxOTBLc0pKUnlxQjVSVndKcEo5VkZX?=
 =?utf-8?B?S3h5VTJzOHZmZTV6MEpDa2wwUVFpWkhYeG9DdXZ6eEpIMVAwY1h1M3ZCWWVX?=
 =?utf-8?B?K1orNHc5MVJLbzJ4RGZHU2tXWmFsR2o3dVNhSXNLUG5jUnVpa21Gamdwb1lN?=
 =?utf-8?B?dm0yYlNQcitXZ0dTNUl4cFBEQ1hoSmdFZklCKzV3QVVPUndNRCtEeFE4ZndG?=
 =?utf-8?B?K1Z3WW1KaHJiQzVDMHN4aUY3NndxdDE5bkFGV1IzeWJXWlBCNWN5WDJlZFpm?=
 =?utf-8?B?dE5qWjh1dDN2MmpGc2NQOUdoVUd1bVUxcU9iRHlEa3p6bTY0c1JQc2hmODFq?=
 =?utf-8?B?Vy9EUHZObGN3bUJKdk14b2hGR3ZCVU11UlZKTVJCZkJMWGIwbGthTCs0d2hS?=
 =?utf-8?B?eEVqelNQbHUvdjltOW1oc05WNDFPd1VRamhOcmx5WjVXOWVxVE9nZ0pVV1RC?=
 =?utf-8?B?c3BJcTYvNTJPVWxtYXB3VGRXNHRka3hTdW1kT040TlFFNnNSWWVmUjdrWWVZ?=
 =?utf-8?B?NVovU29idVp6QnZ3eUNML0dJNHlsbjkxb1hHLzQ2dXUyelorakpJa05QMzlK?=
 =?utf-8?B?eG5lNTRUM0ZzcElGU3JIVWFuWFVYamNMM1NhTVJGQWtWTEVza3pWd25KNVNY?=
 =?utf-8?B?aUxmeG9hMEFBMVNXQmZ0MVdGTkYwQjBBUmpSQ3BuWTNaQkVzcjFERFNxbnJo?=
 =?utf-8?B?Y2xNQVhzY3hOeU82cHhzblZRN2FJMUkyMHNERFBwSGE2QmdTQkNkYjZoMVRl?=
 =?utf-8?B?ZWJQMlQxS0RDamgxUHh2L0Y1MzNuYWM4c3pqcVdOZGI5SWcydlFWazcxeTJF?=
 =?utf-8?B?aWdqTkEvSEtiTnpQd2o1U3B3Wm4rRFRnaGhPR0JpQVc5SGM1U000bXh4UWFF?=
 =?utf-8?B?LzlyQTQ4WEpmOGRCcjJHbjFaaXo2UkVkOE5VNXhlR0ZiMVM1Q0lqQkhmc3BG?=
 =?utf-8?B?VE1mQm16Uks0cWRtOG9XYk5KQVpGcytXSFNCeEtpUFRjMXVGTDFNTjlTVEFJ?=
 =?utf-8?B?VEJ4V0pyUmVKVkdGQlUrTjZVRlRNRDJKUERHcGYyc2NkV3JOQ3VoaGZ5eHAy?=
 =?utf-8?B?L3lQYW1JbVN6VnpFeHlXRm1WM0w4Wnk1aEUzN2ZHbFFveVhsVU9Za0VjcVRi?=
 =?utf-8?B?cWtxYUkyZ1pmUVRySGNHOWMwQVBnUm9hcTJPL2JZM0J3NkgzOVhnbWU0NnlO?=
 =?utf-8?B?SWRUMkdSVDJWMUlYN04rSkpEQTE1T3R5Wm9XODJRRlBoUkxzTEVXMkgvdk9I?=
 =?utf-8?B?eUE4a0pKNVF6c1ZNTlpSbXg5S3AyVTYzbTRzRzdZSlliYzNxN0xDbUd0dUVL?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adcdcd0-c6a3-458c-cdec-08dc99c0a0b7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:26:19.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hQmKNOemTQxMMSPu4xhPwbnB8wFsP18vnrsovotb6nhBVAulR3pmHorwWipkcIjosu7EzG7cJBzInLpHCCFZuNENL2T1g26GdGqZlep+i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> Using tabs for column alignment makes the code easier to read.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

