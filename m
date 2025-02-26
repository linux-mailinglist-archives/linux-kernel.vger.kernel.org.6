Return-Path: <linux-kernel+bounces-533022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05AA454E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4751189B470
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB7191499;
	Wed, 26 Feb 2025 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KA//Y0Zi"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89321ABA4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547904; cv=fail; b=YgPKG1w69APxt4Y171kMc0bXEZqCbueoqhohfAwSX9US/FjEaaXRw9DeiIi1FYmgqmZKwsU21YXwxzxR/JejfK10lqUD4OxtoOWiUp4gHycNE73AvPoqcnvli+KNYltm+QXBdJRBn2ZxZlei26xy6YIRb6h4ojZtqyBV68oI/eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547904; c=relaxed/simple;
	bh=jLXv8f2PocUZEJH0oVze9md0pYSgVBqIUTHqC15FmC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XsyLkZO5gWkkGPYU5jUAH0YCccW0uIFYHDrBMBo3QlHZL61R+I04HRVa5xUTxzTwjiOFOOnn78/GUD8JzNME0tOhpQdXtD/nxzXMF9/a9QHh2QonCa/1b94XjvX5+CVWhsIZrmuG1AbuvRXSiz7IWbvM6B/0SvXJYdHo7mKDl3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KA//Y0Zi; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0iJh0enPkScr3q5bVbajHebF97NzDUlBZBsFPBxsl9ux1C7BB7uKVnVhO5EF+Uf257HkHC7c4aUh37jij2YTGC/nT6YDIufFAQfSBGYzYvvg65Md4F3wdSd7ko/h2oaNrURlimUh36ZP3dXpdLD1xR2rOBRr8HyceBG99lnodL+KSFzXLJFuhVUWsP8lVU81mXtMdTFqg+u+AhDqpJAFHV0JIeeG4N9aUVLfYzPmk8++JfgAnnCONuwk4yNVVB6CWPw2ThNkaJH4Eac8AXDoJ2W97Q/LUhNM8BDkJo5Nnjd1XR0fuLLT1D4UqYW9ThXa5yyfbPffgOLpkgoJgcwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e91NTKqlWGjkXlO3/++/YfBvKOi9uPEdecgOl6wvqus=;
 b=rQbLXQvSjfUI/7zuBSuexWroJxtmUS/LpzORo25ImLFve88NFVHhcO1p6fGYO9Sc96n7yNHNzgrtm18eKhHPzKXOulZUh3mQMZVTVB22Ve08lctNUQvp3wz8lS0wddtsHW8rqsUNJBlONMLoDiSKBAOrDz0a9pJbWVXqdaqGkPY8McwAWUEHrMowlURb40Ha5wG/FwLfgugsc8Ydo6fij45XamQUYT1z+DOSSyWGl1ryVnEJhouPD0ZDJD/8QZ8VMCt2i0BRhQ6mY8D65cmRz0XqmOS5z9J4/QgpUJvpLkjqEh4pAHZSJDOE0DIjfmvtsRbU4LYVk+x+9idoIQXGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e91NTKqlWGjkXlO3/++/YfBvKOi9uPEdecgOl6wvqus=;
 b=KA//Y0ZitdR1fq7tluFZ905fFoc8Jd2HadN4onv1M+eS4JWY5L6h3A8PPVdsL8wu0q8zu7EmXwJLGrQzB1v9QOcFHe6rZrWNp3+nh/ywbFtI1NUHUN86heZJsyEHeMu6qMMp+4mwGZx51KT6tjuICqqqMssCdt7qp7OgHhyjU11OrJ7k4D9myCV6d/Wk1sry2fpQOfuljwm+DqrZZUQ9+fMnRaRGct0bqD0mjLuMCsWHJszoPfX4KT3b7Pn7CyRywjtoIUkfiKShBx8yyjKdPk8qyXNuX61BRIMh/re4jCgXuibvNuHdqHokFwEP6T31Kmv1XjSyE1+PSzCTurHolw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 26 Feb
 2025 05:31:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 05:31:38 +0000
Message-ID: <07414bd7-e93d-4d0c-b6fd-d9178df2a894@siemens.com>
Date: Wed, 26 Feb 2025 06:31:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/gdb/linux/symbols.py: address changes to
 module_sect_attrs
To: Antonio Quartulli <antonio@mandelbit.com>, kbingham@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
References: <0849b8a0-e1b7-4486-a376-43403e52dd1f@mandelbit.com>
 <20250221204034.4430-1-antonio@mandelbit.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250221204034.4430-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 067a39d9-160a-4772-48f0-08dd5626d7c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFURjdHZkc0UEFyYzlzM251UU0vblMzUkVNdElEUG5INUIwNTFiOHo1eEVO?=
 =?utf-8?B?RElMWWhaRE5sQUJtMDl1VGE5a21taGI3U2FKMlhaNG4vdGplK0l0djBlRWpY?=
 =?utf-8?B?SVkrSGZ0S2xvOUJlK2FaRFRDZnNoejNvbmFsV3NvQ3BrTVp0bnNTeVZvVFZY?=
 =?utf-8?B?amxqcFlJcWJrRFJSVVVMTlA3U1JzMGdleVo1K0tLcnNCU3VzYVBlUUk3Y3hu?=
 =?utf-8?B?L1JoQitzTzNIQ1A1QVFRUjhZM2pnYVFMVHFCSkovRjhrZ3g2Wk9CQkE3aHlX?=
 =?utf-8?B?Qy9PNGlvdUhSQytSMS9HQ1JsMEFFNVFodW1QN0tmbW5rVDlUOWlhNmtBaXBK?=
 =?utf-8?B?WjhycXV0KzRXcUhCV2NpZExtanQ1LzhVNEJ2V2Iyc1dhdEora3l2N0x1MTVm?=
 =?utf-8?B?YWtjd3RrYzNPdG4xSlo1NXhKRElDdzlPYWJDakFTTjdUNnJSaEpsNFNSWXo4?=
 =?utf-8?B?ZDVFNHd0WGI4cXg4YkxnS1gwTVd1Z1BGYlB1dWt5c2h4cE5WTCtBbzk2TEZp?=
 =?utf-8?B?U1B4dGxYMkhWQXJIREF2Nm9SYkczcXE3S1d5NjBjRFJxZ0V2MW85MjdMOHJB?=
 =?utf-8?B?dnE2U3U4QzVVcU5yMktaN3hHTnV3LzRSd1J6Ym9idXU2V0ZNVjVBaVVnNHBJ?=
 =?utf-8?B?V0k5NTkwOHdGaXV3eFhxYXpXNXcxLzZQMTZ5aU5CNC9hWDBLeXAxSzZsazJs?=
 =?utf-8?B?a2cxRkN2T3V6cTNGVFRZaDlpSW90WTVFb0FzM3B3TjkranRvdEF3NFRRd1Bp?=
 =?utf-8?B?Um42d2V2MHBhcEdEK3QzRmJKV3VjYnBzL3dCTE5tQUE0aTg1a1lKRUxzSWRS?=
 =?utf-8?B?S3FQMTBRdUdkdWg1WEZ1bjFFU3ZkNzhER1hoYXNyVW9PVm4wUWgyR1daWkVR?=
 =?utf-8?B?Q2tUeXNpbzRxSW04Vy84eGYzNHJ0WmJsYWVaSG00Q1RnNnpodCsxbTM1VmdT?=
 =?utf-8?B?WU5VNEladHp5Lzh5M080d2F6NXA3Rjk3K3B5Qll6aVVrbWZybG9hQjZQenp0?=
 =?utf-8?B?WjVuN3JBRW8yNGsrTXY4RWFsazIyaFplZmhFMGk2QVk4eWNxM1hIejZFWkxP?=
 =?utf-8?B?QTI3dE9aNVN3RUxiOHRKL09rRFk5SlpWUnNUNERZdzBhZERKYkNzV29LNGlt?=
 =?utf-8?B?UjE3WjdqejljekFiWFJ3L3lEYjJaOUU2SU5CcnF2VDBYS0RmQVFORnNOZHIv?=
 =?utf-8?B?c1ZLUjl3WGZGSWZFSTZyOUhra0dkZDZSVmFTNUlIYnZRUFRLakNTK2VCam5q?=
 =?utf-8?B?ZnZmRERTRlF1QTdwSWttVUdXZkNSZFk3R2VqQm9hT1o4eDlXVTRhUXdzdlls?=
 =?utf-8?B?ajRnZkZNREZLZHkvaTRkTldEbnFhWTNSbHU5VXREZDBibFJvOWViWEk1S093?=
 =?utf-8?B?SmNhMytrUWU5VWp5UXl3akp4aGhveTlQMUhWbUdwTDB4QThIR09pUmwxdFVv?=
 =?utf-8?B?eTFiSW1ObkZwSmI5UkFIaHZodXNUTC9ic1JnQkk4bkJJSVlsQkY3L2cyUW81?=
 =?utf-8?B?N01YaXlsdHA2VThSdU5HMW1GaG4ranhkSW9uWGlhMWNnalZvQVVTZllxU0RB?=
 =?utf-8?B?dkJpZnYrWEJnRUJMN1AxVlo3dkZLZmdDWXVsQ1MyMVJoWGVVRDV4Y2FFYmRs?=
 =?utf-8?B?WS9nQnFQSytYNnZodFNRZW9PTVREWXNpMHdIcmRWMzlUdDdSRnQxVkpHZmha?=
 =?utf-8?B?THVrTytVaS9iK3FmOWhpOFdGUkxXV3gySFMxR3ZpRStSNm91eno4R0VrTENq?=
 =?utf-8?B?M1p5K2ZmUTRtL0Y1by9Jbm1POG84enVGZ1QvQkNpZ1RlTStzeXBFNDZvd0pl?=
 =?utf-8?B?QTBiZmExRER3Rlo4M0QvMUU0d21Sazcwa21uN3U0K3N4cVgycjFCMWJ1ZHNO?=
 =?utf-8?Q?b13znbtx+b6ga?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXpVNEkwWHZ2b01BSEl0TjZ2ZTNmT3pkaHNzTklnSlIwSDFHZ0lFUHkzWUYw?=
 =?utf-8?B?WlZBd3V2anlKZ3pIUzhMZ0Zja29iL3h6WkNOa0J6RVVtNGRxc3NKU2Z4dXIz?=
 =?utf-8?B?YnVseERManhRZ0NzVHcwVWQzU0QwSUhPaE02SnlGVHMrOENYZ0F1S0hVVWpy?=
 =?utf-8?B?RnAyeDNXVUlWM3hsT2xaWi9Sb1JEYmZSSUZmc3RFQWdIaE1WSFRTQTdVeDc4?=
 =?utf-8?B?NFRjajU0VS9RZWJaQmQ2OEZXK3pWaGRzQ2h5bnFqS1RCMVN4YTdHWm5NYTNM?=
 =?utf-8?B?TnJudzdMY0YycCt3TU1LUkFKQU5nb1pjMHNrZUx0Vno1bE4zMXF0VzNTK0tj?=
 =?utf-8?B?NGVlc1hBWm1tcFk1S0hmZjYvRzhyZm9PYXprdHJsdDlkM0pHTDFDVk5ONTZE?=
 =?utf-8?B?cytuM0dEYTZZUzJiSXRkTUQ2MFc2NHNHQWhGT2dxUlJENnROdXdHcnliTE44?=
 =?utf-8?B?Rm5qWHhpM0VtWVMwV3Naams4VERsWFNnWmRRVWFsVlJ1UDJLckFUSUVZWms5?=
 =?utf-8?B?M2Zpdi9zMTBtK2I3RkZIbHlFM0VWNmVjanFKSGVGQi9FSGx6ZmtvS29zZ25K?=
 =?utf-8?B?RTNVaGRaWVVEOXFvc3ZzeVUvQWxacGJ2RjVRMWJuRTEzVUdTeklzZTZZdlgz?=
 =?utf-8?B?d2pxN3B2MlNudkYvV0EyTmtKclI3L1NwNkQyajJtTkppMVY5SWtpVmdjSkNs?=
 =?utf-8?B?TFoyaTQwYUdFWWZYZ3lxU3ZMcEg0cUdRUlpyMnRtNmN1Q1RLMXpaaVhmUzJ1?=
 =?utf-8?B?Y09GMUJxRjM4TGc0b29vOC90OHNVQnc4endTUGdpenJ6bk93ODg0dmVqVEQ5?=
 =?utf-8?B?dldrM2hFQ1ZHT0hGMTEwMWpGbXUzOW12YkxuMnVFSk1kZ3B0c0MvWXRxYndj?=
 =?utf-8?B?T3VMaFNveC9rWHNCNTBGSWljSTh5K2U2dVlGUXd2ZFBSbVhtQ2F2d1FOV0s3?=
 =?utf-8?B?a2hYR2E2bkp0YUpmNEI1azllOG9FbWkzYk5zVW9yb0g1bUl1SEZUTUkzYkxK?=
 =?utf-8?B?OW8vWW9NRHBoU3hCVThFZEhXNXdpT01NcVRkL0lTV2hySVBmWTVTUm9nWUts?=
 =?utf-8?B?K3FoWFJEUXNPb1BMWTkwL2VOcUsrQ2JpR3pGYjNKa0xsQ3FmemFObzNxcmpS?=
 =?utf-8?B?ZDFZOEIwUVJaTHpuR2V0RkFqVkVGcnNwSjk0cWZsU05jV3dzalBZclZIY2Nj?=
 =?utf-8?B?UW1YR1hmclU4NWVRK2hPRWwrVnJqZEJiR1RXbjcxMTRpQUJ4S2VTbGpNNmpW?=
 =?utf-8?B?TSttVW9MZUVaemRvYmN4ekgyanQrM25TZktBbXRQUnQyR29tUGl1MXQreFpJ?=
 =?utf-8?B?ZjQxdi9sWFB5UkYwZXpla1R6aWlDR3JlVDdFdVZFTWozUXJ3cW5pY0dGcHZr?=
 =?utf-8?B?b3YyWmpCeURlY01PRTlwRHZXZFlpSjB0SnBEeXBMZjBrRmJ0WXdZd0RJbmNh?=
 =?utf-8?B?WXlOamRGU3BXamF5czBaU3pZY040NFE3U21welBiakxhU1dCeXpJL2VPVE8y?=
 =?utf-8?B?MFVUcTBmWmsySFY1STZqVzdhTm5jQkZIckdwTU1Oc216dEVob3VtSHJjUUhs?=
 =?utf-8?B?QjU4Z052S3JhNFMvOURyWWhwdUU4WDVNbW9kZEN4M2U2dlVWWll2WjRIeVdz?=
 =?utf-8?B?WTdncEhpcmVLUm0ydi9hY3BVUTlIT1cwZCtiVXdzbXpVYXRQcmhDb2dGdWZC?=
 =?utf-8?B?czVhY3ZsdENITmFoRHc2UWFrS2ZhV0p0NjAzQzJCeFpOVFpJVXgzQ0JIWFRH?=
 =?utf-8?B?RjJvNTRlY0p4amtxM1pmemwyRi9MVUhXdnJLR3ZYeFRpOUNiajdubTc3Nkg2?=
 =?utf-8?B?OTk5S3FnNTVUcTdDb1ZiTkF5Ymh3V2ZMdHVQdEQxRG9rV2NMeGdNckFXOUx4?=
 =?utf-8?B?ZFRXa3hZbW0xcTEzODluWjRsdmliQzVnMWo0MHJPZkdPRUI5cXo3S1lTcHIv?=
 =?utf-8?B?TTNtamtocWlIWCtIOTVuL2ppOWlkVkFIcXhFQllCeDVRdTN0MElNNHI1SjFU?=
 =?utf-8?B?aEhCV3A1cWdIY2dtUVNXMitGRWpKMmdPN2taMjhDMXlwUTEwa2w1VnQ0aTQw?=
 =?utf-8?B?ZEkzZnNUSXZBRzBhQXdBc0VzSzBuUmpNWXFYSHd4TzFFL2ZBQTJWemhtOTNX?=
 =?utf-8?Q?itAUWT1V46CDpvc0/Epeja8h0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a39d9-160a-4772-48f0-08dd5626d7c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:31:38.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Pth8ZWhQE2JowA1R661VkZNmaZF01wUHQjkw8lzORPwSu8gkKXOuo+ZYoz7J3VmDovhe6tBoCyf5pjjCoia/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4103

On 21.02.25 21:40, Antonio Quartulli wrote:
> When loading symbols from kernel modules we used to iterate
> from 0 to module_sect_attrs::nsections, in order to
> retrieve their name and address.
> 
> However module_sect_attrs::nsections has been removed from
> the struct by a previous commit.
> 
> Re-arrange the iteration by accessing all items in
> module_sect_attrs::grp::bin_attrs[] until NULL is found
> (it's a NULL terminated array).
> 
> At the same time the symbol address cannot be extracted
> from module_sect_attrs::attrs[]::address anymore because
> it has also been deleted. Fetch it from
> module_sect_attrs::grp::bin_attrs[]::private as described
> in 4b2c11e4aaf7.
> 
> Fixes: d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")
> Fixes: 4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> 
> Changes in v2:
> * changed attr['attr']['name'] to attr['attr']['name'].string() to
>   ensure extracted value is a string, otherwise an exception is thrown
> 
> 
>  scripts/gdb/linux/symbols.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index f6c1b063775a..15d76f7d8ebc 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -15,6 +15,7 @@ import gdb
>  import os
>  import re
>  
> +from itertools import count
>  from linux import modules, utils, constants
>  
>  
> @@ -95,10 +96,14 @@ lx-symbols command."""
>          except gdb.error:
>              return str(module_addr)
>  
> -        attrs = sect_attrs['attrs']
> -        section_name_to_address = {
> -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
> -            for n in range(int(sect_attrs['nsections']))}
> +        section_name_to_address = {}
> +        for i in count():
> +            # this is a NULL terminated array
> +            if sect_attrs['grp']['bin_attrs'][i] == 0x0:
> +                break
> +
> +            attr = sect_attrs['grp']['bin_attrs'][i].dereference()
> +            section_name_to_address[attr['attr']['name'].string()] = attr['private']
>  
>          textaddr = section_name_to_address.get(".text", module_addr)
>          args = []

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

