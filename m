Return-Path: <linux-kernel+bounces-274456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BF947849
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2BD1F22853
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7015250F;
	Mon,  5 Aug 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cKYAnpdx"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D5822309
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849973; cv=fail; b=FpPRWkOTMYIJzYzxeNFreYJN+6pvmojQT4ydd4voB197RK2i+LIluIeEtxbcBMDYkqT72t6P1jAjh42TkuAZK3Zpp8TfFa0zXH40zbz2NYkt6oB9Rfj6NU6nZtLa2WRG/NJDdSpr9pN6NIHgRtA0efIrxulDhESPOJEQntbHiL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849973; c=relaxed/simple;
	bh=c0U+yD4BPhcfCKeQNhnpM/s0ZiWMUFQ6MCSuQvnxfu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZylbTPIfOffZJTSKIVAXc/YyHDVqxK80ttVJAgoDrfiBmp7uA19qwfdN2KRKim0qSn5G20qjp3CvHagRn18UR6D/lBKCD7N0Q4RTQ1rI/P4YDPHpGm5abPNRLokj7lNTGDrF95RXi8+49dwwd0Vrlm8r7Gz7wF/hfmkTMbeybyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cKYAnpdx; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEVSpKW1LnKuvSICC5xLnQoOvyUxQD5ra0nNNXsd7spUZCvm8rvQbfW4G7gbmF+jZlfiRIvav50+ELzcnU6sxp//p7ljuwD13LJOMYuBthCqgQ8V5dAYbmTeYCkoYRG4GUcLecLNAzawtx29SYZFq2YbVNeUZpqKutAydIn0wpAvmdp7WGPnCJ2QVfEXxuI+Nu+pHPoxLafKntVg73whja6sXBoJ83VDjJBSqOo9dnhEo2r7dDNZvNSUvKngdFNegoFovzmr4PKeYwRlPRs+Xv/ydLvKd4eqlgueljAanmf43Od7sDDJ1sOjwCe4EvYXj/AjoVfIJ/q7gU6BrwcoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rm8qdHnuc6Y25+FxVLlcErpFsO2l6N+ni82ECPyOhlE=;
 b=TNoEY4azjtS/jFlaWUSRr+yudweNkVbKMaqV9Yq2v0cCTIgIau9HEtwEGXf8rmWTj80aP8rGtKP4S2d0VJcfXm5Q2T2ekr88hPj2L7YIesh2FxLjAixWAVOUVQUZ8v6Daxk2xoa9naiAhyeDla7qT4l5r5zeINrzmTdRHK95N/D255GlCaV0m2Ad2Ig4T1DFCD5wdu6yZxF4FEr7X587u/M2xyjpVXmcPVt82pNyjv6Mt+r/zCwfHAEp4Dlfhy8kRMXPUeg2YtkNnW8s4TuX05FVOO1c5MkYDfcxmxaf3BhLCew9ft7x22bByvpH4nYqFxldimKAqpoBGfkgScMcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm8qdHnuc6Y25+FxVLlcErpFsO2l6N+ni82ECPyOhlE=;
 b=cKYAnpdxdrBS5a/28izQFvGscBJMLThfdRU8Sfp0tjif3J4NNiV9Ea/LOzjhT7AReQZsmJlcB370Gyns93jhu4RqHv+ea3YRFWUelD+gmvA/WCfZO9wprpmXgISwtwlsSF+z76nDkvp6KJBj802y2tZttn/nkFBTVpreNlLtX+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 09:26:08 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 09:26:08 +0000
Message-ID: <8ec23c64-0b55-4a71-8199-14cb6061ad45@amd.com>
Date: Mon, 5 Aug 2024 14:56:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
 <20240724071245.3833404-3-Shyam-sundar.S-k@amd.com>
 <a0f5ea6b-2be4-4fac-8c22-34fc21df84b2@linux.intel.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <a0f5ea6b-2be4-4fac-8c22-34fc21df84b2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::17) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 6663291c-c8da-4f26-33dc-08dcb530a342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjU2YmpOa1NYRFZXRmp5T1MzMDd0cndiK0VMUUV4MWJnWjFvZWJ2SFY1M0c5?=
 =?utf-8?B?TGFLTm5XaVhKWmlleFhMT3hLdmgwcXV2ZzdheXlraWVLbUgwL1Vpc2F4d0x6?=
 =?utf-8?B?eUdFUlg4YVMzMVVJUlNkWVFyOUg4M1pmR083QWtZRWUwa1dUYXhLc1dxT05o?=
 =?utf-8?B?eVVHUHU5cFdpc2RVampXNzZhVW9teW1YYnFMTzd6QVdjaWorb0w5dGs3eU5y?=
 =?utf-8?B?eXBhcWxDeVBCZ01LM2ozdjNFMHJiL0l6K2lYK0g2OU5VWTVHendJaCtiL3N4?=
 =?utf-8?B?N0tPUXhXM2dMWnFBSUFJdnpPSHgrQXRqcmVSUFkxNEJhQWxZa21KeG1wTkxa?=
 =?utf-8?B?Q3EvUnRsdktNRWVpT1UwNDgzd0ZNTkZYNXdxaWEvbS9nSkdoK1VkMkk3aWFk?=
 =?utf-8?B?R043bXkxbG9ITVFvRGVvdTUzQndYalppcTZkNHEzWkVoS1VVUTZxcE5wQUtY?=
 =?utf-8?B?THY0RmE3U2JsNVNCNnNtc3Jub1U2a29qWi96ckdXVHg1UmU0NmFpUDA1TFZy?=
 =?utf-8?B?bkYyWjNyZHNNYTNrZCt6UXh0SG9zUGRhMDdSNkhsMDc1ZWRSL1FUdlZiNHFP?=
 =?utf-8?B?eVVYRjVnNVhUdkJHRlArb1VTUHY0amZBNExTd2pOVEhTcE9SY0RsaFRLQ2Zt?=
 =?utf-8?B?bEUxemJSeCtURFMxdUVCejVnVS9YM25qSjJJRkc4Vmo4NnFBUUJ2VC9tRTMr?=
 =?utf-8?B?TzJGZHR6Rld6MUtkclAzbXh3UXphbWF3NUIzeXlFKzlyWTBycFI2QVFjdDc5?=
 =?utf-8?B?YzBpSjFKZXVidGs5eDBReXltcnFOS1lnSkFuQ2puYUlLbHp1OUU4WDUxejdI?=
 =?utf-8?B?Y1liblo0OEVBa1RyTk4vSFlFeURZNENMcVcvRFhSeHBEazgyTktkMVdxQ0k2?=
 =?utf-8?B?Y2xwSEhhV2NIOHNNUDhOZ0x3L0tZWEJGdm8xemtxOCtTYzM0WWY0bk03TjNx?=
 =?utf-8?B?UkdmWUdNakhRMmZiWnY1aDNGRzlKZENsV0JwNXNqc3pSai8zTHR1NnBHWktS?=
 =?utf-8?B?RmUzbmFaQVpISGw2c3RMakJCYTBUSkN0ck9VTWM5aVgzU0FDZTVjVW45dzU4?=
 =?utf-8?B?NGVtcWRFZzJYeU1xUEo5TldXNndjdHZpM05zRHdlSjNucmRjbXpmaUpNUTl6?=
 =?utf-8?B?Y09ROWk4UG1PYlV3NHdzT09RZXJJNGxpY1RLS3BRcHRMdzRoczlkT0lmRDBn?=
 =?utf-8?B?S2hWZUpzOGwvSiszdjZZNUhKenR2TWdSR3VHVCtUNVVlSzJNellNTElyMy8r?=
 =?utf-8?B?Skd5VWdXSXRVeDVERkZYTmlCNG5PMXpJSWhmRENpMzl5NldoQ2VmWlh5M2Fk?=
 =?utf-8?B?ZDNvWSt2ZThpaEpiU1FWMlFpNEMyZ3ZHdmFJMCs1ZHBMNW0vRmFLUStEdlJj?=
 =?utf-8?B?QXZUNHZPTmUwd1BuNThhaEZES0loeTV2WlV6TExSZ3VwSlRpNU1kTmlwM2wv?=
 =?utf-8?B?UGYrOVJmK3FJdGNWM2FFdmMvTmNvSUtDYTNrcGp2UG1mWXFKaTVhSGVuK0w1?=
 =?utf-8?B?ODh1Z0ZlRisrZzRnRWNZWlRaTFI1KzFJMnU0V0MybnMxd29XUGhqdkpHelVW?=
 =?utf-8?B?ZXFMRkRTTEhuNFpsWktOT3dwelBSOVRyNk43R09Fa29tRTQrUDhtQ3MrOEhT?=
 =?utf-8?B?U3V2dHJIUnIrLy9BTnFxQVdSWXRDU0RycE9GRUZsbG1VVTIvSzFuUFVDTmNj?=
 =?utf-8?B?UXF0T2MrSVhTSmtiNW9uUWJXR2tpYk4yQklzeHN4SFVvRnFiUk1mN2tEZ2lR?=
 =?utf-8?B?Yi9xTGlnSFpHNkQ2dGg1YXhjaWx1S3pIUE1weG1lY1JlTE5vdGRUTmlRM3B3?=
 =?utf-8?B?UDMwNWdRb0NFSWU3QTZXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkFGcDdNWDhLaW1kNFVJR2M5Vnp2RWJEMzdvakZ3WWh5ekVtVkxpbWlVNkty?=
 =?utf-8?B?c3dzUmZyZlZ0ZEtmMVJFZE5XeXY4ZlZtYzAxOHZFZjZZdXhBVExLeFZiZHNS?=
 =?utf-8?B?S2RwZzlZT2k3b0JrbEI0YVV0OEJxMm5MZXZrRkVVZHViZzlmUEM1MW91R2tt?=
 =?utf-8?B?ZmtWRHhnS0FwbHg5S3o2b3ZWbXdNd0phZ0ZrM2w0dGRGU1NLRXB2ZEQ2eXk2?=
 =?utf-8?B?L1RTM0g1U3VCTFp1aGZyMktJZHE0VmFoRmF4ZlBkL0J4QlVyMTJlVmowUVEx?=
 =?utf-8?B?RDV6eDA2REprVlNldHpFL0h3enpSQXdRMm5zaE1qaHFxQXE0TXNWTmNPZGZk?=
 =?utf-8?B?NFhxNXg0ZytSOWZQd0xzS1JFckFHdlozb21xUXBZc0dvZHFaTThWODBqbjZE?=
 =?utf-8?B?TmltbGk5d05lbnR6Lzg0WG45SUI0d29QclBjbVFSc1A5TE5oRmRjeWhqYnA3?=
 =?utf-8?B?R1ZpekpEWGY5WW1saExuRTJWTlk2RUdGZThuYWs4TjZJYXhHK0cwVEVaNmJi?=
 =?utf-8?B?VXk2YmlCVlpvUG92L3JVaCtKVEpwV3c2aEwrR0hjWjJtTU5KWTlzakdUcWRB?=
 =?utf-8?B?NjhvVTRjTGd6RkhrVXFwbnpCSndTR1F5ZTh5U0VFaFI1RkNjMGNpMGRIQkNx?=
 =?utf-8?B?NFVqNWxCNE93YXc1Nzl6cmYwdHdzeEh5NllNTkpidjNzY0FZNW1HRDVJOUxP?=
 =?utf-8?B?a1E4WDh0b3NrQXVuQVo4c3hDZUF2a0VJdFp4dTAvTDJSWlVmbFQwODdtOFE1?=
 =?utf-8?B?dHRhODA0UjNSMEhpWHFjT2xoemR3M0RWWmVOa1VHc0pPSTQzalJUN3RTeXdF?=
 =?utf-8?B?SEVkWU9RSXlVTGxLOGRBdXRheFZPUkgrZUI1Y0tSeEt4bnI5WEwrUFZjbjg1?=
 =?utf-8?B?V1QvdDc4V2E0UEVndWI5cXBodGV0UXRtL2xWajlKdlp3WjQzUTJ6MUhLUWw1?=
 =?utf-8?B?dlh3Y0tPQ2JrbmFidC9vRDMzdHRjNnFKZG84dnc5TjRuUWxTczh5TzM2dGRE?=
 =?utf-8?B?NjV6VzhpSlUzaDlrL0YxaGZsQXU4YlZhbXZWWWYza2hBUzhOODRPZXpCM0xS?=
 =?utf-8?B?eVBteEcxblpreGhMVlV3OCszTzd5TU1VenN2NWxybWxnbEx6QmhhLzJ2cHkz?=
 =?utf-8?B?VmdNR2loQzVZR2dqQW0xOWNJZWo5UWE4QTM4SVUwR1dsbzJFb0ZwcGxOcW1H?=
 =?utf-8?B?RDhFZ0dUSit3dXVOUmZYcVJwYTJ1cGVxVi9oR0hsVElxTXZ0Y3BNRkYrdlJp?=
 =?utf-8?B?Vmx3SUJMZ0dTTXQ1aTcvRUFMdFBrTGRJZUtCbjVTK1Rhc1k1ZlBLVytDVTF2?=
 =?utf-8?B?UXVoTldSUGlUOEZsWS9FZkhFbXBzdU5UaEZIZmVwbmdrMlNJTGdic0N2eW14?=
 =?utf-8?B?VElGZGI1cjdqZEVPczRIZlFFcURhRFFNaGJEMXVtSUo1aC94a2VnVFNXN0wz?=
 =?utf-8?B?RVdwZHBNUVU2TVJQRy8wRlBFWGhXYnN5VkRFekg0RUQ2VzlQcWxPSGtwZkdp?=
 =?utf-8?B?LzRoUUtVeExYNGFrRm5VUWNZdzUwU1hjWW5qYzVjT0U1YUcwSk02ZjVtTS9B?=
 =?utf-8?B?WnNVaUVHeHFlUlBobHpDRDBCZDRyREd2Z2IwanRxRXVwaWNEK1pnZ3pFb21u?=
 =?utf-8?B?c2FvSDFFU1JjVFlISWRxdkFINnc0TFZ4b2FVMmMyMUIxMW00eU1vTUY0QUVC?=
 =?utf-8?B?WFEwSFZsV2l0ZmxXdGY2a0EybmV5UjhUYWtMaDJIWmlqcHZRNjB0M2RnNmxh?=
 =?utf-8?B?dDIycUJTL1dqK001eGJ2bzJmeld3bWxEYnU4ZXBiaXhQcDZ3YS80emFKV0FM?=
 =?utf-8?B?SWZEVGhkblV3MnAyeVcwdTF6amxSR1lzWkxvUTBhcEZXd05mdGppcEE1eU1p?=
 =?utf-8?B?TnhWSXZ3RDNqc0V1NkFyMFdvSzRMUUQ1UFZYUU5ySWtxWE90bkxXUUJ0YURj?=
 =?utf-8?B?cjZldWNuUUdRVDArUkRqaXY5NVBybitwTDdiTkhhdmJJano5K2tuK2psZmpq?=
 =?utf-8?B?UzJrQStFZ3EvY0lGbU1KUVRqUEozdmRYam9qRVk4Q0RrS0ViV3diQkNZdzlK?=
 =?utf-8?B?VWx5a3MvajhXenRLanFnK2xEeTdTU1k1aUNFay9Vd3dpVHRsK01pY3NWOEZs?=
 =?utf-8?Q?0HXrPnGCbfjCuy/4OKYlyQgfz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6663291c-c8da-4f26-33dc-08dcb530a342
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 09:26:08.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9oJYSrstoAQWsvEf2XIXy08E8Fnfxxa6mBHaFaiJaKOE+z2xR7UTBCxIlfJ4GZZSagW+3isC8bj+/sd1LMVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

Hi,

On 8/2/2024 19:28, Jarkko Nikula wrote:
> Hi
> 
> On 7/24/24 10:12 AM, Shyam Sundar S K wrote:
>> The AMD HCI controller currently only supports PIO mode but exposes DMA
>> rings to the OS, which leads to the controller being configured in DMA
>> mode. To address this, add a quirk to avoid configuring the
>> controller in
>> DMA mode and default to PIO mode.
>>
>> Additionally, introduce a generic quirk infrastructure to the
>> mipi-i3c-hci
>> driver to facilitate seamless future quirk additions.
>>
>> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
>> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/i3c/master/mipi-i3c-hci/Makefile |  3 ++-
>>   drivers/i3c/master/mipi-i3c-hci/core.c   | 15 ++++++++++++++-
>>   drivers/i3c/master/mipi-i3c-hci/hci.h    |  3 +++
>>   3 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile
>> b/drivers/i3c/master/mipi-i3c-hci/Makefile
>> index a658e7b8262c..1f8cd5c48fde 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/Makefile
>> +++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
>> @@ -3,4 +3,5 @@
>>   obj-$(CONFIG_MIPI_I3C_HCI)        += mipi-i3c-hci.o
>>   mipi-i3c-hci-y                := core.o ext_caps.o pio.o dma.o \
>>                          cmd_v1.o cmd_v2.o \
>> -                       dat_v1.o dct_v1.o
>> +                       dat_v1.o dct_v1.o \
>> +                       hci_quirks.o
> 
> This doesn't build since hci_quirks.c is added by the patch 4/5. One
> idea below.
> 

Ah! will fix this in next revision.

>> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c
>> b/drivers/i3c/master/mipi-i3c-hci/core.c
>> index dbc8c38bd962..8bb422ab1d01 100644
>> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
>> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
>> @@ -33,6 +33,7 @@
>>   #define reg_clear(r, v)        reg_write(r, reg_read(r) & ~(v))
>>     #define HCI_VERSION            0x00    /* HCI Version (in BCD) */
>> +#define HCI_VERSION_V1            0x100    /* MIPI HCI Version
>> number V1.0 */
>>     #define HC_CONTROL            0x04
>>   #define HC_CONTROL_BUS_ENABLE        BIT(31)
>> @@ -745,6 +746,14 @@ static int i3c_hci_init(struct i3c_hci *hci)
>>           return -EINVAL;
>>       }
>>   +    /* Initialize quirks for AMD platforms */
>> +    amd_i3c_hci_quirks_init(hci);
>> +
>> +    regval = reg_read(HCI_VERSION);
>> +
>> +    if (hci->quirks & HCI_QUIRK_AMD_PIO_MODE)
>> +        hci->RHS_regs = NULL;
>> +
>>       /* Try activating DMA operations first */
>>       if (hci->RHS_regs) {
>>           reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
>> @@ -760,7 +769,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
>>       /* If no DMA, try PIO */
>>       if (!hci->io && hci->PIO_regs) {
>>           reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
>> -        if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
>> +        /*
>> +         * HC_CONTROL_PIO_MODE bit not present in HC_CONTROL
>> register w.r.t V1.0
>> +         * specification. So skip checking PIO_MODE bit status
>> +         */
>> +        if (regval != HCI_VERSION_V1 && !(reg_read(HC_CONTROL) &
>> HC_CONTROL_PIO_MODE)) {
>>               dev_err(&hci->master.dev, "DMA mode is stuck\n");
>>               ret = -EIO;
>>           } else {
> 
> This is true, I see this now from pre-v1.0, v1.0. v1.1 and v1.2 specs
> too, HC_CONTROL_PIO_MODE bit is present only after v1.0. And therefore
> version != HCI_VERSION_V1 check is not fully correct since bit is not
> present in pre-v1.0 HW versions either.
> 

Agreed. HC_CONTROL_PIO_MODE is only present in v1.1 and v1.2.

anything below v1.0, the version check handling is already present;

        switch (regval & ~0xf) {
        case 0x100:     /* version 1.0 */
        case 0x110:     /* version 1.1 */
        case 0x200:     /* version 2.0 */
                break;
        default:
                dev_err(&hci->master.dev, "unsupported HCI version\n");
                return -EPROTONOSUPPORT;
        }

Let me know your thoughts.

Thanks,
Shyam

> I'd split this patch and do version check alone here (perhaps as a
> first patch) and do quirk stuff later where hci_quirks.c is added.


