Return-Path: <linux-kernel+bounces-284125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107694FD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED05C282588
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7E28DBC;
	Tue, 13 Aug 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wd58KWct"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC613219EB;
	Tue, 13 Aug 2024 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527125; cv=fail; b=P7HDE/Toebmhf+M09PGPpUFgCJLhV54dWbdKw6Bczu1JnfuouNoPV/A2uqQ0B8hBPJqsSPFoVSK77YDdW32HgL2eZDq05qWuTHt72vIVSGZIc+nrr2p1Mn4lvzr5MNrYIfNvCZF9XZVEHD8ff3WmlGiqT5T9wdvZWQn0oB//gBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527125; c=relaxed/simple;
	bh=r4g2O5gS3f0jCz4blr4ldU/R8x2Y6Qdk27j4KfwHklk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XAbsn8WltIoYM5XtrSTyk9dTcBHhcz/oXziVm4z8LfZp3VMr7S4rApIWDnvdvJh1sqwM2JmQC+lt2cEIiyMfOu8jy8QD8Tee5PtEnVnAwuqdN/C8NQj5s9Pz0DaCZJEP8rObDbzuqhddg54dVmGhjW8euGTnYwj8K1ivGi+4vNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wd58KWct; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrPTlpX0532MaH2RCeLpGJV8Dt/ZtfnSiR226cC5QLWCvUlmvd12Sv3+vHjtJCMPmo0Umluah+M836jAYn5iYv6udoRfZE4mkQLb4sfXImwiX2EzzQWm31v8mkWg1jrF5CAQM7pUm45UOnqfpTnYlHDz08a9nYGXqWYffu2iryUckYiRv7/7ouJF0/pN5dq1gUhjK3TW4MIFuW2WgVLzGGXNoYKYRufihUrY6p3xZdqx0JzExxknLrGta65BVoRGDGbPsUa2AXG1d3Zk+LccyTY6E6DwjfdOq1XtmpYbmXCvHFaKBX0ybRgHBY6+FZM6K9OlYAWG5RugxZ/pqUm4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKhins825aWj3v6S1pmXeQrNSMOTACxh3E/YtfeVxxY=;
 b=HBPVckS/+X6wKb4Z2Kw3F/AjSBlfdjD5fPz6Ty8W79a9V+PmVWU7fBEdX10vn68maZdetVvyqShw9y+/GdXyszi+KgBEBADlz0C/+bUssdr7xaRnevoirstEH7Dh+AQZJqZCKCAWRcSvXId5OyuQ//kwdIr3/w8GgClOaAbpLEzFP6A06/YAvRfKDZNXItBLXrAXHnKAFec6FB2MRZQxmxbPyPKE7JfBdScWXm1f2159rMnR0KOw+m07bAqd8ezqckpO6shHHvU+l3vgyoek1+AhC8eP55/+R9zpVZX1s8RiGHX3U5e3xDfAyjf5OlFd2f/XjiDUbWhCw7RMi0lPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKhins825aWj3v6S1pmXeQrNSMOTACxh3E/YtfeVxxY=;
 b=wd58KWctqvcWG/m7I94X8TvV7r5IlV6Azb7kheATLNfJOdFuCWR0+r01ve3CmMNhgJw3z2aI1SI4JuatEk2QyghpQWUh0J1AdZ7EfLcx+MTyOgiBWwCzMJPNIMuvqARsRl6zH/PY86cFvieSKDSM7M/xVR8Zzz2LxbmkOUyWm9elOVI3Y/rJiT+d0nZyR8IMs6DvTFdSkdgez0clxRPkWzbApAxH67hotMPrmf1oeId2AC+0zDpsXwvOqx/8GlcFrnL7RaLTJvXIZuLVRVtVM6jn/08eBuVV88smcZiDInNgUzm/hjwtY7mSeobS2XoEsIZI+GBedE8P1iNaCt7dQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 05:31:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 05:31:52 +0000
Message-ID: <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>
Date: Tue, 13 Aug 2024 07:31:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
To: Conor Dooley <conor@kernel.org>
Cc: Minda Chen <minda.chen@starfivetech.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
 <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 871e0659-3862-4fce-3db2-08dcbb593ca6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGhWemh6TmRPVHNQbzlodXRDUXVXSFpGWWVUN2l0a0VOQ0xaaVROOVVpUFFt?=
 =?utf-8?B?dEI2VHQ1d2MvdEhRdlBvSnRlZlEvZG5xVG5SbStzMEw3WEhWRE1SWWZXandz?=
 =?utf-8?B?Z3QrN2JyMHRkRlJiZGRJV3hDKzhwMmpPSWp2WXJtZGt1blRJU3QvQUcwN0VJ?=
 =?utf-8?B?QmZXTzA3dnp6WWRhLzZWWlJpdzhUK1pEd0NkNFNYaUdKZGYwOVkwOE94VEtH?=
 =?utf-8?B?K0NwL1RGOThhbGJGRFBlN2hYV3JoaHAyb3pIdlRZM2hWNXlSd0RmWjZNU2NN?=
 =?utf-8?B?S0pFY0l4VktSa2tWd0ZCQ2Mrb3VnVkRDanhCdGxvaUJuZDloMGpGUy9veHBo?=
 =?utf-8?B?WWJpNTduMDJlZTFoeXdtNENoMmVQNSsrOENwb0h4bTdFVUhBNTBwQjAzZjlE?=
 =?utf-8?B?Vi9TMGZ3UFRBRzgvN2kwY1l1RlA1akJ0aDM4aEdvajBwVkVKYncrRjJXNmli?=
 =?utf-8?B?clkxVnJLM2pqN0o0OVgxaXU3cFN2WFVUak5kSDFEdHYxVUp0WUFMbzdMODFp?=
 =?utf-8?B?OGVXR0pySFJyNnVMNVJhUm5mNk5QVnhVS0RxdHRLeDNnSHlQd0czZGxWSEc1?=
 =?utf-8?B?N09ReTZ6bnpQQjJOTE0raEhOZU9vYUxKenVtWVFnQk5uQ3NDeGdtaDBVWU40?=
 =?utf-8?B?WU5ZZEEyc3h6SHlIdnU5OUZneVhZOHh5K1Fjekk1clZDcHJDN3RaM3ZuZ3pH?=
 =?utf-8?B?YVRDR2N2bmtyZGMvWGpUM0xROGh1YkNaYWtXZCtJS05IZU1TNzRBc2Z4T21W?=
 =?utf-8?B?MjFTbmhNdFRqOEh2Z0RZLzZ3cVZzWHVYbFhXbGxzdm9CU3M2b3VMZVNaK2lY?=
 =?utf-8?B?NU4yZEF5T0dQUnMwZlNSdXBGTjNqbmxPZndNUkNEcloxZUNNdHlNcitLYVB2?=
 =?utf-8?B?Y3U0VEJZQUVjNXFVdUxxcFZjQkI4bHh5bUo2RkdXTjhmWHJ5cDZ1ZmpFckV0?=
 =?utf-8?B?aW5uei9yZGVhUndSWlhKSE9jVEJIbGczR3I1Nm8xT0htSVlPOUxIVFB3QmFr?=
 =?utf-8?B?dXFsQnR5M09GYXFJQ1NKM3RxTG1lN2VaSkxudDV5VHY3R1V0VGk2ZHRNNUJu?=
 =?utf-8?B?Vkp5dlNUL00xQ0RxOGVnNTlabFoveGF4c0swOXQ2U25zcnlNc0hFZkhvUkpN?=
 =?utf-8?B?ZlhBVEllZzVOWFFFQTZXV29jeFQ3Vi9uTC90U3FhcUxiRXV4TDJLKzlGL1dL?=
 =?utf-8?B?NFJFZGlSQm1OZU9tc1gxUzFKNUE0QkM3ZEtmTUUxL3lMT1EyMk5RaGE2WDA1?=
 =?utf-8?B?K0lxY1lnWWtIaWc3YUd2cmNoaGtTcVhKa2hsV1U5WjdjTEJJZitjbW91UUY0?=
 =?utf-8?B?NTlHSE9FUHpZbTVEQ2libFBqa2xWczdpREJGd1lWbXNvNndSekR5Zm5pYmkw?=
 =?utf-8?B?aldWY3FrSW5kdmp5SUtoclJDRTdNT1ZTelYwMHc3enpvZ28yN1FFV1Q2Y1U5?=
 =?utf-8?B?SVh4bUpDWU5SZ1RhWkRpbi9vVy96VFdnNmdoZDg2RVNwaTdDckk5cEpLbFVF?=
 =?utf-8?B?bENnTWZNUk9ITUtiM0pOUmZDT3YySExycGVmYTg2KzhTMk00ZHZ5K0M4RVhV?=
 =?utf-8?B?OW5DRVFRbnJoS2NQTHNHenFGZjFDRVAyU3BlZXd5b25SeitqYkExNnV5cFBh?=
 =?utf-8?B?QXVmeFNhRlpTOWxubHVQT0I5NWUzclVOWUZ2SEtJOWxTSUljQ2t3Y1pYRFZu?=
 =?utf-8?B?V3JUaXpTcW8wTjhkNFRtWk8xc29iTlUycWxVSTNTQjhYVHdVKzVwWC9hZTFD?=
 =?utf-8?B?aEdTOHo4N0FVNzlaVmJHS1kwbW5ndU1IZWF4Q1Vvb1hnTDlrK0tXSGN6NkpM?=
 =?utf-8?B?N05mdXpwM3BQUUtrc0V5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODYyc2VoN0U5b3B2TWZTSjVCOUQ0MG8vSkpvbkwrZ28wckZ1WjBYMDdnWi9t?=
 =?utf-8?B?NTAzd3pmZ25wbzd4YXVvcGplMFF1ekpoTmRUTldWYUwyQ3RWMFg1Uzdka2w1?=
 =?utf-8?B?dngyTlM5ZUFBL3VCRUU4aitNZGg0ZGo2QzFuNlcxb0UrQkdOSFllTmFXSTln?=
 =?utf-8?B?MytUY09MeFpwMjhEQTMweUVkT2x5N3J2dG1hMWhqZzlZaERQT3R3ZW9OZTR2?=
 =?utf-8?B?dHhjM3pBbzlJbHBlUmg1TEUxT2VpMDMxNzUwNDBVWFpMQXdYNWFlZzNXVENy?=
 =?utf-8?B?cmZFUjBZczlJLzFvaEVONXpnY1QyOER2SFF3cmM0VUcwWlB1ZzdUSUVDR0w2?=
 =?utf-8?B?MEJZUy84UHFFU0JRN0VkTCthZzBXWmE2N1piYlRIcWx3L1VINHEvOFZ5VHN3?=
 =?utf-8?B?MVc0RkxudHFuc29iZEdXTml0WU5WWmc5QUgxWTk4SVJPYnJCSnVoblRqQ2J2?=
 =?utf-8?B?b1dMSHIxYXZWalI3azlXUnhIQ1gxanpnc0tVYlU4VzVLMWRzYWxDbzVyanUw?=
 =?utf-8?B?bSsrdS9CbEova0k2bytXQ3hPeGZTUUpFWlNDN1Q4cy9sbG9XRUpzU3lvdjN4?=
 =?utf-8?B?a3ZtY25NVFVPY1NTYlFHVFFPQWl3ZHp3ZVBrTTR0UzNyOW1ZcUFlbUQrc1B4?=
 =?utf-8?B?SGZnNVNTbUZKdE9ySVlDTjlRaW8xT1h3U2lPTTlNUmhHdVhJNGFmNGV3RlFE?=
 =?utf-8?B?YTU5NUZvbCtWR2tGR0FFSUlreDNsTWd2MHJvL21PNU5xK0VWSFpmQ3hoMm1P?=
 =?utf-8?B?d0YxVWJOSXRYNDNocm1oZFdqRjBLaFpsc1ZPYk16Qm50TWVtYnVoczhONDhV?=
 =?utf-8?B?WFI2Q1NsL3BlN283YTk0ZHBNUURoMkpTV2pGM0xZTUxGNUVQK1dXMkdad2Z3?=
 =?utf-8?B?YzV2aDRqV2N0RHFKQldFdk1sc0N6Tmllc0tiQzNhOExtMG1WK2xVR1RLMnNX?=
 =?utf-8?B?ajB4bDNZNGViM3hvTFZpNW9zOEFqci93NnZDZmh2bGZxVGRvZVVISStzeVlp?=
 =?utf-8?B?Zk9tY1lPNjR1VDNva1pVOVlQYzJnV1pCamVlcWFwQ0JiS1lNWWpQancvWUkw?=
 =?utf-8?B?ei8yV2dDVDAyM09aeGxpbDVVMWhveWY4dWcyL0lHUmkrOHV2VlRwbXM1M3pj?=
 =?utf-8?B?RXRNektPcHNFb3Z4SDdobjBKQlZsQkxld05hdUJEQ0JZY2FxbnhIU1hsQ1My?=
 =?utf-8?B?eTlMVTlLLzgySHJRN2NpRWVvUERJWjRCOFAzQUU0T2RiR045ZmIyM1orZThT?=
 =?utf-8?B?MExUVTFIUnFQYzBZTEw5ZUF1cnFTRkpWSVE3enRXTGc3V1c4N1BsbFpxbFhG?=
 =?utf-8?B?aVd3SFVoK2xzK2kvRjUvMkNVaDh2bW01MVY3d2lVeGRSRVNlQW1pVElFK05P?=
 =?utf-8?B?M3NKR1hTWEFucEJHb1hVS1hpS3oyeGM3ZVZSRU5KUWRCUDYrOG1nZWpQZUY3?=
 =?utf-8?B?c0Fob1daZnNkYkZ4Q1BwNWVhQ0dCaW11WVE4Y3JpcmVDVGpzSEE2VnYvN3ZC?=
 =?utf-8?B?dkZWNG9mY1liZGhmM0pSV0VCVjN2TDZNMmJrbVIzTFZVUlhPZG51UXJYZGJI?=
 =?utf-8?B?bVBodGdzc1NJTDJyZjk1UVRKMEJ1cXk5cTV3RStLb0FDUGJEREphd0FNZ1NF?=
 =?utf-8?B?MFNkZlBOY0oyOVNGWFo3cVE0ZzhjTVZRdUVBd1JSeVY3eDk3d0lDRWg0R2s4?=
 =?utf-8?B?K1lNSDVwcGUvdDJJQnFja0p0SDh6R1J3WEUvRnd0NGpRV0k0cjVUM2lXUStq?=
 =?utf-8?B?RUd0TWs4QVUvQ1h2Q090NkZyQXY5TS83V0gyb2pTbk1lRUdHdXhwckMzTlR5?=
 =?utf-8?B?V3lKMzc5LytXSTdnYmxFc2VGeHhBRlQzVkYzRVpGMUpPK3gwVDM2NXQzRE91?=
 =?utf-8?B?MjliY0F1QWdGMFI4MmJUKytVSVl4NzJ0b09NcGswUkpSSTdXaHFEeFN0MEox?=
 =?utf-8?B?QUE1YUxwS3JiZHBuR2dQQlRjVXF6M0E5bWkxT295OWkvOG1DS1ArbkpiZlF3?=
 =?utf-8?B?eHJ6eDh4K094UWgzWEFlcnNmbmg5WEhCMXdKZTA5V29ZTnV2aERGSVBuUVUr?=
 =?utf-8?B?dCtpUkp4SXBhcTBnZm9QNndKVFJDbE5nOHNtL0RNK3g0UEtvU1FGeU1ORHFm?=
 =?utf-8?Q?LguYp3Fp9fVxR9Qfs2FfRgL5I?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871e0659-3862-4fce-3db2-08dcbb593ca6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 05:31:52.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPiCqfbN6xzL6E7fTmUC3V5o5zE22hizMK5833sIL8ZtF9MVkDOwqKn/5DD/VIy8DHWuVUub6sUq0CNR7Hzfmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8864

On 12.08.24 17:55, Conor Dooley wrote:
> On Mon, Aug 12, 2024 at 04:15:51PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Analogously to the PCI PHY, access to sys_syscon is needed to connect
>> the USB PHY to its controller.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>> CC: Rob Herring <robh@kernel.org>
>> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> CC: Conor Dooley <conor+dt@kernel.org>
>> ---
>>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>> index 269e9f9f12b6..eaf0050c6f17 100644
>> --- a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>> @@ -19,6 +19,16 @@ properties:
>>    "#phy-cells":
>>      const: 0
>>  
>> +  starfive,sys-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to System Register Controller sys_syscon node.
>> +          - description: PHY connect offset of SYS_SYSCONSAIF__SYSCFG register for USB PHY.
> 
> Why is having a new property for this required? The devicetree only has
> a single usb phy, so isn't it sufficient to look up the syscon by
> compatible, rather than via phandle + offset?
> 

I didn't design this, I just copied it from
starfive,jh7110-pcie-phy.yaml. As that already exists, I'm neither sure
we want to change that anymore nor deviate in the pattern here.

Jan

>> +    description:
>> +      The phandle to System Register Controller syscon node and the PHY connect offset
>> +      of SYS_SYSCONSAIF__SYSCFG register. Connect PHY to USB controller.
>> +
>>    clocks:
>>      items:
>>        - description: PHY 125m
>> @@ -47,4 +57,5 @@ examples:
>>                   <&stgcrg 6>;
>>          clock-names = "125m", "app_125m";
>>          #phy-cells = <0>;
>> +        starfive,sys-syscon = <&sys_syscon 0x18>;
>>      };
>> -- 
>> 2.43.0
>>

-- 
Siemens AG, Technology
Linux Expert Center


