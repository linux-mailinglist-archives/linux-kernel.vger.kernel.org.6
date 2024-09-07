Return-Path: <linux-kernel+bounces-319719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C397014F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35771F233A2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69C14B094;
	Sat,  7 Sep 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="M2N0qBg4"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFA12E5B
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725700580; cv=fail; b=Lgjy2pZc5Wv2M8eVoySVJYt3QQaCJn//X3Qr1EKV9hBFCfou5p6MKDVfXhO0TeIwW/o+W1VDyaNkdW2Rk2CydHXM5kFFTwQ55bhxikJpsCryDFDvYX7etXju5oJxVpCsKWunz304pXBT0n+oeqgl8gmTChse3QPc8ZvapLSo2BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725700580; c=relaxed/simple;
	bh=NBieqCoV3fQnR7Sp8m9GSwGDH156R+1tjNnpdCgVfAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ldPpoJgjt0iWnthKoxhPBd/RrqfD3jhxAnKsUUL12LvSbhonukeGCb5gZSJjciThssUTbJ/4ZeHhU3BP294mzWNafAETYqQjIiIViDJYzrxLj/roRYliTlyVZGngDIeOWaQS7JAbM3R20a7BBpPorNU9UkT3vpSTG1fGT/o7iqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=M2N0qBg4; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaqDnLw5tM4Gv8/dZ2tiwK9a2f7fDCBUXnGedTERpoRTjKVnjKDn35ZzHy6QZkePjxOaIozP2yjUEBIglEYxWFMbR9oRPNMpDn+h2e+NvOXNcWZEsojNfHXo+KD9WH84rOuFFnflxW0Gb0ITanUDYlOqC5p0cOugkvvHxj4bM+JY3zFyM6TRl9H3c8rnULKh1HcZ3ceHlJ9BHUyEa0B+9D6HLNUQokTXIDYmINaWjCXpY0FNQlZbrTS5rgX6Bd0iK7Zv8ND7n41IAG6mwiZrLe5+ZUyMmb9NcfCRKT7Oq3OdUbQv6sOTiNl+uCojU+8nDpBXbNeOL1kfg6+k/+T/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1LHaZiuApNc+2tWzPG3CvmGX5VK3zq9yw/r5c5kzOI=;
 b=DXQUKkv7j7tQDqWxzGwIhISkOS4GIbfIaeKTY1npoP5N94F8sO0OJ0gUejup6FFNtV5SHoXLyJ3K/1vyUbQDKw0vUf96XASr5qA3q7Ecra+0Yk+gysTmLWYA+Bgok1T2GqWQu6iIwep2QI4r0xiOddWdNzEUGPZJBIq8homfg2gpqQkc+cCiX7na1Xyrzx0P7nCeARefTYjbSDcOuS3rPm48YNFP2PzlDyzzOfQh4HWM4R9ZH+LK/nyVv+3hTGSuxU0Iyg52/kX3AHJPb5N2NE273GsFQ4rjUpfTTh9gnYT+nSrAaFnvG+agw/juzfWURwFlxTnXBx1xzKlHmgqt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1LHaZiuApNc+2tWzPG3CvmGX5VK3zq9yw/r5c5kzOI=;
 b=M2N0qBg4RFhd35edaUIja7HrRAgoaCo3NfqOHcfh/DKF8GlVrjE+w74d6b+tNItvgpnIxYp1svlhLCPOtbeWqC3dnBDu3I6cAWFTTIJjTzTul16JbWaDG+dW2eW+TCBj3H/Wtcc6lMVRUyfZccd9QamHFV73B6kQqPOghQRwBYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by DU2PR02MB10447.eurprd02.prod.outlook.com (2603:10a6:10:49d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 09:16:11 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%3]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 09:16:10 +0000
Message-ID: <f9e56af4-3474-91d0-aa43-eb1a582a8074@axentia.se>
Date: Sat, 7 Sep 2024 11:16:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mux: add mux_chip_resume() function
Content-Language: sv-SE
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
 <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
 <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
 <4cf89e3d-7164-67b5-0a3c-9e8e4df274eb@axentia.se>
 <c8a82583-5570-4286-9f1b-00a2717bae4b@bootlin.com>
 <6267cf2b-1c05-ec72-9ac8-e715561d5bac@axentia.se>
 <10f29bcc-b627-4bd6-89f9-b8c48fa6fd3a@bootlin.com>
 <df9c448b-5f74-c0be-3a06-198e46a5de62@axentia.se>
 <4d5ea9a9-df92-47b2-bd60-15e4a2e6f8e1@bootlin.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <4d5ea9a9-df92-47b2-bd60-15e4a2e6f8e1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003853.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:1b) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|DU2PR02MB10447:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b870b1-8295-4c25-17af-08dccf1db6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTlMQ3FrV1RUTHJiemNjZjYxRE05Z3FzOEl2bzFoNyt6b21GVHkyZDg4dDU0?=
 =?utf-8?B?Y2YwQlp6TnQ4Z01NVDc4TzRpa2gyQkt0c3FoU3ZPb1d2dG5pY0c4VUoxcVBC?=
 =?utf-8?B?TDl0RzVKODlnbmxjZ2xJTHdhTXpZYWQ2VElGRjVQMHRKQ3R4L1FxMDNtQnJP?=
 =?utf-8?B?ZWlJbG1YRU9BcHZBMGRJeE5mVFI1MXRCeWZCekFYSzBCWHBRL3hqZVJFOTU4?=
 =?utf-8?B?bWtpc3hseWRCRjRrNzJCeWdXTEFMMlAvTFNXWHlwd3ZoZ2l6endxYkF1Q01W?=
 =?utf-8?B?cG44czIzSVJob2VkTkJmMFlsVzNFYk5tdkkxeWczbWtocWh0V093TEN3V0pT?=
 =?utf-8?B?REJKc2d2emQ5YlBjWnhsUllxOTFNMDByZEd4aG1EWUFWS0xaVHNtTFh5cFhR?=
 =?utf-8?B?YmhtNXhYenpYaXRUM0pLRndabklyNFl1a2VtRWo2c3FxSVN2VkI2UE5FeGxa?=
 =?utf-8?B?RG9XVjBkV004aWpydXZZZFBLdXdEUElxcy9Ld3ZLNGhRa3Y5b1JjZWxvMitU?=
 =?utf-8?B?RnN4SGFsNTZqS2FXejJBckl4dkQ4MWFEYnBzaDg3ZmN4bkplQmt2ajdmNnVr?=
 =?utf-8?B?eGRqTjNkTWZnVUFMSzNRNVJ6SFBEUGxsWFJUR3Vxczh5RmFkNnI1eEd4S3dH?=
 =?utf-8?B?QXNiQWlheStIN0pxZjdZdngzOFZNTDg1aW9va1ZadEY1cnBwK1VKb2wwbXFB?=
 =?utf-8?B?UlJvV2wxazhZN1lzd2ljak8ycS9WOGZUQzF3UjBoRkhFYlU1YW5BN0gvYzc1?=
 =?utf-8?B?U2VtMndwOFJJRmZaVlVOL0dWeVNKeUxsZnc5bGttTmdwRlVTRnNkZm1aZDl1?=
 =?utf-8?B?ay9WMVh4eTRhbVN2dlppMWh4QVpoNEMyNk5VMm1zQ0dhdS9CU1VBNGI5c3V0?=
 =?utf-8?B?cGtHYXFsYWkzVzdhcTFIb3p6NmNrZ0w3NUFDN1JMRURrbHpjU0RpTHBmdk1O?=
 =?utf-8?B?a3dZWUlwdzBsNWpCdkQ1TTNXbFRnNi9QRVFFdDZzSy8xT2UvMTJqQXQrcGRW?=
 =?utf-8?B?MlhaMUxPNGNtd0xRdGJDb2NXalY0RXNrSjJmL01OUTluWlBWN0RQMUs5U20z?=
 =?utf-8?B?cGJFM1oydzZhdE9EbSt4Zm50aWtQTGlPWjFTRjg4QjNWSWNidzB5dG1KM0Vx?=
 =?utf-8?B?Yy9Kc2M0SFRKbUc5L0xqNGN0NXArYmV1VmlCb2pZaEx1VG9xZDNzdEw5T0s5?=
 =?utf-8?B?Z0ZjSDB2SnRMODdRaFliSk5SUHJQcUZ4NVZwQlpIMkpuMXFVTTc2T24xdUo2?=
 =?utf-8?B?Ymxnanh3cnNVMjI2NW5jUEhLdUpYYTFxOUV2WHpENTBoWElKWTVSbzMraWRN?=
 =?utf-8?B?UzdqMHd2am1RbnI2dVp6OXVOcTJiTFU3V3k2ZGdaM3QxdzhmYmhoRDNvVkoy?=
 =?utf-8?B?OTdCaWR1ZlhKRTRJVDExRFZQMStqRnJ0N29hYjA0cFRVczhqNTVLTnV6WDNL?=
 =?utf-8?B?Y0FLYWRFMzJ6T05KcnhvWktveHVTWTN6ZHdpbml2VFNDdmpRZEJEcE5pT1d5?=
 =?utf-8?B?aTY1cVhRbk41dUl1andvaEprVWJPU21UL3MyNGpsa1dacnU2UVNXZnMxWklK?=
 =?utf-8?B?Q3ZQOCtZSDdqVEdLR2oyOXlmVkVZYlNrdnRhSWVDaGh1Y3d6NldPNXhJNWJ5?=
 =?utf-8?B?T0V0U2x6cXdIeEFtTzFXREE5bHgrdEQ1S0FtalMzWnhsRDM0bkxZUUFrSFYw?=
 =?utf-8?B?ellpOVMvZWZ3cENWb0JxM0UrdURSQ29tR2JDSGI2eVdCVHdxT2pYd3pDT1h2?=
 =?utf-8?Q?ZapMys8KeaCnJ37yVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1pDNnB0ejNFZEk0QURUOC9Ic2wydHhqQmt3YXhGY0RwL0YrR0dHOGV0QVRN?=
 =?utf-8?B?R3MxTDNFTHo2dUdtMWpwTzM5MFlQdWFMbG9jc2VLM29aLzhiTUZsOHgxRUl1?=
 =?utf-8?B?RGQ5YmVVeVdkWlcwVEcyVmd1eEVPUFh1bk5nandiYVg3VWtqOUxMSTJJZHJl?=
 =?utf-8?B?NHphN0x1RTVYTkc5L3MyQzdhMFcrMHR0dDhOZ2ZIckpiTE5CNHd1SnhkMFlR?=
 =?utf-8?B?Q1FwYkNjMS9la3dEL3pPdElENU10UnNSOWxoOUtIY2ZuQUFCVFo1K3MwVXRl?=
 =?utf-8?B?cFk4YkQ5YXdmTkVSQjMrTWxsck5iamNCaXBUMzF1c1ptTVBEeDdrUWl6OHRZ?=
 =?utf-8?B?V2hUcCtUS0hlNXIzNDdnRVU0NllNYkNBUG9rTGZSUTExUjE4a21KNStkaVky?=
 =?utf-8?B?Z2h5SHF6SGhEVXV3cUNYalNiVlRtL1JLRm1acWNnSnh3dFVIUzdTK1ZVdGRn?=
 =?utf-8?B?SytaaXBrTkgrVnl1TUc1UTJkNjdhLzNwYXI2S3RGUFgxYm5UZ29oT2d2d0FE?=
 =?utf-8?B?UEFLa3BuTEw3SDVOMGJuQVp4c3lqT0daUmpBdVZ6eVkzQ1d3U1VIbUE1eThv?=
 =?utf-8?B?K3oxTXJZQ2twR1FmTGpoU0VvNXJJeVoxbXAwdjRuMGorQ2JnQWx1dlprbEFZ?=
 =?utf-8?B?VUhvMG14MkUvcURaaGVzcmV6YVhLcUxJekJTM2o4N1VGNWkwMzRxbkhUSXd2?=
 =?utf-8?B?QWJHcWs4QktrU3laNUdBODRLbHdVb3lkeU40STA0RUszY3BUYml0bzJ0SWZv?=
 =?utf-8?B?QStCQnZYMk1DdHlSREY5bkpSMGFOdzk4ZWZJNThzY1FzVnAwZC9VZno5OG5T?=
 =?utf-8?B?OE1HUStyaE5rVDVyUUVpVXRtdFFNNWNvZ3pVam8xVDFpVXhhN3UzZXRJNHNE?=
 =?utf-8?B?ditVUVN2aHdhcE1zOHFvS1dyWEJOcHZ0UmozNGFQNW50TFJiSWFxQ0lRY3hm?=
 =?utf-8?B?ejR4QzRJOEw1ZmJBU0JuU1ltL2Iwbm9hSGcxRXpzb3FaVVZxTE1mTHhCSWJV?=
 =?utf-8?B?M0QxVGtSUk8yc1BxaTY1ZkUxb1UrWFprYXlpMVRaYTJvc2ErZEVodUx3R1ly?=
 =?utf-8?B?anY0cnpkOVBLWkxlMEZrU3R6dEFwbTMrMTQzNGxwZ3hqYkRCRzlqeCtRY1JY?=
 =?utf-8?B?REsxMTJ5R2FhMUFYTkhoSEdXZkZpaFMydEMyZ2RoOWZzY2YyQXlvYmtmYVFn?=
 =?utf-8?B?SFdYN2JnTmtpeXVlTUZPeTRhUVpSRVlUMkg3d2VweVZNWDhZYmIwQnc0TFBr?=
 =?utf-8?B?WFNoRWtkQnVmbC9YbnZIRXNkNTNLbGNNZ0VzRFhvUCtIc1VINkR3Vyt5Y1pY?=
 =?utf-8?B?bDNNSHNPUDIwM0U1THpySms0MGROZ0hLNndRbFVGUEMxSFk1U041OVJpSzJK?=
 =?utf-8?B?OHpvaUI3bEcrU2x2cEdGc2RILzVnVjY5bDh3TVFPcGRHZC9MUXNibEJGclJY?=
 =?utf-8?B?VFRXSWJhVVlrVHduSzNmSmUrK0ltWmF4MkZvZnRlM25udEw3L3NyOWdOakQ5?=
 =?utf-8?B?eHc2dVkxK2Z1djFrQWlRczR0a2g4Z1NOZHpYZWFsRTROWVlCdWZvRzRmWXh3?=
 =?utf-8?B?bVZ5dE1VeDJXRUJRY3JPdGhLVjBkbEhyZTY1UWFzYWE1NkJicy81ci9RbTRB?=
 =?utf-8?B?NVVVTDIwb0ZqYXQyYW9uRzUyRDNFaFlvM283RzB2UGROZGV5U25Ld1p0aEt6?=
 =?utf-8?B?cHg5MzRxbFYyc3hLekJtc1czTWd5a2hzelRXVEZ3VFRoN3Z0dHFCRUZoR2F2?=
 =?utf-8?B?aFZwTFdZSUpubmlIa1hFMkw2OFRTelBRQzNTS3Z0TFVreG04dXZwRkFzTGR6?=
 =?utf-8?B?a2tWQUdSdkdjWWswcGZiVVd1QllFUUZQQlFjckNleW9kdHRMMFZSaDExUTMz?=
 =?utf-8?B?K1RFYUxFeDRjT0JTcWJEVHFyTENmUEpRVkR0bVdBWkx3RkxsY25rcXd4ZHdW?=
 =?utf-8?B?MnBMZCtlYjQvallDSGViMThJai96blRZaDNpdTI5cWh1TWtTRkR1L3pDOWdB?=
 =?utf-8?B?MFRZT1ZFQ2Nma3BJblQ0WUJML3JyK2ROQVVHOTZOSnF5ek1DdjdPSlVFWnpr?=
 =?utf-8?B?a1JoZGhYYnBrNWFPSWFyNERtOFl4dm1BSUFETWZ3ZFBnVnFkRGRZTmFXZmZq?=
 =?utf-8?Q?cGNIU4L/ebzFzT1GcrpWxqK91?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b870b1-8295-4c25-17af-08dccf1db6b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 09:16:10.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nm6P41/Zidjhz2J5hLkoV8nb3Cnl2wAXK07U0Ok8WLxopPRvppkoLF8N5Q6xQjc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10447

Hi!

2024-09-06 at 18:17, Thomas Richard wrote:
> On 9/5/24 10:28, Peter Rosin wrote:
>> Maybe you should simply implement resume locally in the driver itself and
>> have it reprogram the register, perhaps still based on mux->cached_state,
>> but "behind the back" of the mux core?
> 
> Ok, it's seems to be the best solution for now.
> I'll send a patch.
> 
> Just a small comment, I think I should not use the cached_state.
> I should implement a mux_mmio_get(), which is called during suspend, to
> get the "real" state. Then use it during resume.
> Because the cache is not coherent during is a very small period [1].
> 
> What do you think ?
> 
> [1]
> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L144

If you are worried about that, then I think you need a mutex in the
driver. Or why wouldn't a mux_mmio_get() be racy as well? (since you
are not able to grab the mux->lock)

Cheers,
Peter


