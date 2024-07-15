Return-Path: <linux-kernel+bounces-252910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB89319CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040D4282EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C261FFA;
	Mon, 15 Jul 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HfftTcbS"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021080.outbound.protection.outlook.com [52.101.70.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AA4D599;
	Mon, 15 Jul 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065662; cv=fail; b=PZrZERdmXS22R06ERbN4bVbOFK/SIN2zPzRUvb6Nbs7LKrkwsnQ9SbXPZKWRHyCqGYavELTW/Fdtccxfvv4u7HaTnVqXRDB/F6USV/bReG+/WLMk7UCPaebUEZu4xUzx8M9K+Mwlhd88/ymOGM0F5yxBAqdo0QEbD1zINlFb0iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065662; c=relaxed/simple;
	bh=HMcqV+r4P48ON39sVzUXftJ/O96WADhBL3E+gIL0ovQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k85nwJ7le+QtPoNzDYg/c23zp+q3Ca2uV7LkfYBmfWNuARN4Mo2BT+zN9jyPCrvCbiR22vweqoxIlVHESSlYmnb2XdfHcDmXKsizC7lJxx8uz3pGszjL2hGGd3FmVQA7QM6h1J4hY1vCX99dhoUP/Z2A/ELQb5y/q07aaEas/wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HfftTcbS; arc=fail smtp.client-ip=52.101.70.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0cyqRohSVSPrCHXpXO1F8dtcHJnGe7eneW6VhHAeu5PVMjxDAzrUo3WAgZctJlmmNNMctPTJcpnrHK0ntv2eyzep9UcuxKt4D9NhTvhnBWeWsATgo8OZP1In+KbnaJqLLq0jsOoEdVZ0FQFLgozxCRTqmM+8qOEdiY5UYSG8ZOKA6z0sy8OSIkYhXxnHXegnaz1ChZ09+tlVwZrybDG5Y8+7GrQvtesvVUznlALJ8B00hOEHm1oiyokOSUCH5yqbBw8iy+J+kB/BbARon3fTU2qG17AXdFXrgJmzGwr3iZwdmU/mfpQNGDq5PjsuMNK2z7lGdRgeHrhW6aynlmOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpdXz/bNsDro2f1pk2K50xMI39UVVP7u0DZ5T93NaqE=;
 b=APaK1UxAajvqXMFdIOoCA4CWZO5P6V4v3hqwS2VHstLoJtPEI6rYddmi1BDIPj6mgJz9K4KPaCiuBFrUsoZGlNp+jrsOryq/l0iazNiA6w4yDgnxjzWEzoKwgoGHrkrLYlAcjDf3AH9FQzAKYKNoImF6aYoUXsjiv7S9kkjKhH2wKG/CSBOUselETqHGkbSMPVr+p0DAM4Q3uZI+PVE6Z1XYDPCf0UhaKLMZQQnMCD+DUIK49WKLb/beROZEsOzAYEbebREHnAQAKyzAcqYikXCGIHeGHYZrmoG5wcKS5sNdRcy9IpY5OM3WS778QxeOfhVe3nBipp5I5SxlgNUgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpdXz/bNsDro2f1pk2K50xMI39UVVP7u0DZ5T93NaqE=;
 b=HfftTcbSYAzxMDwtsek8o4D+Ptkm+D90QmX0fbTnfcPNXrbZUAMBwMBAFvEfh76R81fGRGpums8W7tkKK0YYSKXaOzgH5JQd/l/Z7F5hvUYPjV4+jEOJF6Fq9S+JBoUxgzUo/7kISkMd7A+OOvFV3W1ki1baqMaDEfpYi9VY+ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:47:36 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 17:47:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 15 Jul 2024 19:47:29 +0200
Subject: [PATCH RFC 1/2] phy: mvebu-cp110-utmi: add support for armada-380
 utmi phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-a38x-utmi-phy-v1-1-d57250f53cf2@solid-run.com>
References: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
In-Reply-To: <20240715-a38x-utmi-phy-v1-0-d57250f53cf2@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: d24115b5-f2af-428c-3c60-08dca4f63603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cStZTXZtR0xpNHdRSzQ3U2E3ZzNKMHBkU0tOTkhLZFFnZ2FndmE2d0hDMFlK?=
 =?utf-8?B?bG9Bd0o0NlJrdWhrYURmLy90NzVybnF6Tzgwb0U5S2dIcTRFK1ZPbVk4Rnhl?=
 =?utf-8?B?RHNPSEpPREpQOHFpb3lNSDVHVTVCa3Y4WnZQYWhYNlVPUXJaVENic0hDZStm?=
 =?utf-8?B?ZUVVSWNVdGE2WmZ1SHF6ZjZSU0dLZEpqMDY5dEdLTmV2a3lVQVYyb0sxeXdU?=
 =?utf-8?B?eFUyVVhCWmJaUVByY3VMNWQ0TVdhUnpyMEVYZUZBOERlc1puQUx0dUJqbHZk?=
 =?utf-8?B?Z0dBVElkbG1OZncyMFJuQ1RxOHpJMTVxVHZOejVxY29TSjVQZ1lGM05NbjdN?=
 =?utf-8?B?enpFWmszSnFuOWdtQTVVcVp0Yi92Q0cyamxPNENZempVOEcveGdYYUE0RWh6?=
 =?utf-8?B?c1o5Tkl6V3lKQXVVNFlVRDNqM1paU1ZpRENwcmFpaEx1OVdQL2l4RENCelpM?=
 =?utf-8?B?b0VQVkxiR1UrWlk4OHlMTGZwbFRMWk0xUm1KN1dRUGRQUHExWlpsYjRtOW45?=
 =?utf-8?B?UXhiK0MzUjh5cksxaW5TbFc1ZGJ0cXRMUUF6OXkzQ2pDWWFQUnJuRzBrTjJL?=
 =?utf-8?B?UnBxcGZ3V0Y1YnIrYkpQcWZ2cGI2V2F4ZXE3dDczWXpjSllNVlZkbnVFUTJt?=
 =?utf-8?B?MStMTkJUQnRWVHFFbHJUbm9QS2E5dERyZ3lBVEY1dE9CUWJHc3kxUmhzNmd5?=
 =?utf-8?B?TWNSYVVXRVBoK1RrbkxJQldMaFJOYjl4NmVETjU2c1ZWS2RaNjBGV2JCbC9W?=
 =?utf-8?B?WGFpWmd3ZjVJYjJVL2pnOC9Lcm1rQnFMRlFidlBlOUFudExONHpoZm1ieng2?=
 =?utf-8?B?WFdPcGQxdldKMEpNcWNJbGl6N3pqSVBRTlNvOThIbHZPQldoQWt0WUVhV0J2?=
 =?utf-8?B?YWlyTStaK3psVzhPejNFcTNkM2JNK2llRUJ1V2Z0RHJLb3Fqa0VQeWIxMU1h?=
 =?utf-8?B?cDFvaFV0ZE02dmpUREhhZS9yNjRHOEo2SGZwcE9lS0QwZENDUUlORFQxUzUz?=
 =?utf-8?B?a3NHNmJtZ0QvR3BTYXRsNnA4aTdmTjIyS0hPQ1RjSmhUMjh5SENGaVZNZ0lj?=
 =?utf-8?B?MzBPd1lldTMraVp5UUEySmdHUUx0Tkc1eWVXZWUyQTF4Z291QmQ1QUtWRERD?=
 =?utf-8?B?cDNpZVRYbE5TTFl2eW5LUEN3Ujg0VlgvRXpHRDJjNmFkZXJLa0tWQ2VVQkhB?=
 =?utf-8?B?dlVaTU45L05TaTh1WEZiNEpYZkFiNjMxTi9OdWMvNVZyZG1MQzBnV1dHVTJE?=
 =?utf-8?B?ZUtWMHJLQTdmRFUxYThJYmRaKzRCVjN4UVE0TUtMLzc0STlLd0ZXZk9QZUxC?=
 =?utf-8?B?SUNXV1FoTHRkUkNuYm1xd0NpZWxzVkVSQTJLaU8yQWxCQVhiNUtnbDdzbXFj?=
 =?utf-8?B?Mlc2dU5KNFY4RUhyOUZremdSNXJIanZHcjltMXh1OUNMeEVackw3YUVwWjdH?=
 =?utf-8?B?bnBjU2d1ekRkNmI3VHFuMUJQdjNDRVpwdW11U2lobDAyemx3ZlRFS2lGb1F3?=
 =?utf-8?B?WWxxSTZ3dHJGZ1F1Q2NkYmxYRU9CZGtYVkp5cUFSZWhOdTBLQi9zR0Q3T2ZJ?=
 =?utf-8?B?T3A3b0JxalFRYVF6YlhlZDFnU3dmaFNEcVpHdlhjZHo0Tk1hcnVFU1M5YnNW?=
 =?utf-8?B?WTM3K2ZKU0FkTk5GY011TGdsM0wvdFpzMFBrUG5FZThOeE5NRWFWeTBVZURB?=
 =?utf-8?B?THVMTFJ0NzViYTVHWk0vczBwbXRxREwzSnNRQ28xNWFLQkZIMmFWRWN2dGRW?=
 =?utf-8?B?UFlRTFlhNmNCSzB3MW1QSlE3S3JSR3BTT0l4Q1MwTjhUSWpLRlJBK3JiSHNB?=
 =?utf-8?B?ZERrMis3clBpcWNienYzQzdWRHZ1QkpqSENEZFcxYnBzREd0bUliZWN4Zlll?=
 =?utf-8?B?aTNpd3FGV1l6N1kxZ1Z3NHBDUUhsRnZHblhjWjRkTE1OOGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnMvbTloVzhlZU5semtiQ3JxSURzVEtPaDV5T2ZsWUJuUUcyNXA2S3U3YkZR?=
 =?utf-8?B?Mmg1RFVqemZMQ2RnU1dpNkY3eXVMRVlRYTREczdCZGx6cDd1THo3M014U01O?=
 =?utf-8?B?Q2orWnBpemNRT3Q0ZWFmYXIxSCthZnp6dTU0QVZhWENqam9jMlhuNE80OTIx?=
 =?utf-8?B?U2dCaFlnWG5wSXd3eXF6bGErZ0FDaTRkeE4yYjhRd09WOVA5TlRtdGd5RmtO?=
 =?utf-8?B?Q2g2bW1oQzJhc0tKclFSMU4zY0xZSEVvVTd3M1YwMzh5ZUhZVElHbHp0Z0FG?=
 =?utf-8?B?YWoxN2ptZWFyMGl2Y3MvRkVCNjV6QStrZEJsSTErdk1WQnRYTXA5RDBrc2V1?=
 =?utf-8?B?NXdhbWZCS043UlpoMld4RDFoK3FhQkZpNGNuVFRiZFNEYkJZeUNzZ1dmajVS?=
 =?utf-8?B?T0ZtZ1Voamt6cDd1ZzlQd0tFRTc1d1NLWTMwS3dCcStBV0g0L3hqSWU5YXpp?=
 =?utf-8?B?YW1qaFM2cnordXNld29uSVIrSEgzL1ZQMWRscjRiaFo4NkduN1FXS25IY0lm?=
 =?utf-8?B?QUlUbHlyUWJ2ek1ZNkIrQ05MdUtpQUpMLy9nME5Jcjdza01pQ05CTGs3OGFD?=
 =?utf-8?B?VEVKK3JyTHJkUlRqbEVUZHNmTnhLbmgwa2lHMEJxVy8xSHpQL1ZjT3JmUSsv?=
 =?utf-8?B?emV0cTdUeWd3OFpFTW1UNUMyV2E2aG03aHg1d1NQeXVhWFhzZ0tFaG9BSTJM?=
 =?utf-8?B?MC9VU0FDc25VUi9PVVU1Zk1TV0ZxQXVOQmJYdGt6MHp1TWdUM0V4eEpiRnAw?=
 =?utf-8?B?ZEJWdnVtTk4xQzJuM0lva2phLzdUWDRWT2NZV2JEV0hwQ1l2MXE4Um5UWVFN?=
 =?utf-8?B?UmE3K2E5aGtxR2Y3V0RiS2NFNmk2T3FwTGJEV1NkenFnUno4VU9ocWlzNnZ3?=
 =?utf-8?B?S1p3Q2VmVWJQZnNlSndMZ1FYVUh6dVFNdDFvdG43ZWhFMmppZGI4dkR3L2N6?=
 =?utf-8?B?UllwRng2RUU1U0ZQelg1a3g2TUNGTHNLKzdXRjZGY1FCVVV3QTNUa1lIdis0?=
 =?utf-8?B?ZnZOdGpaZkJBSXZ6WWtJdGtRSDRpZHdTQ2hFZUdUTnliZzV4MHNiblNmU25o?=
 =?utf-8?B?dkJHaXFnS0RZWFJscm8vZDNQNkdENmxyclhoYWIwVFZxNEpMemcvU1phZmV6?=
 =?utf-8?B?OTQ1bUkxK1ZZRzlNM2srbE5Bdkl6MnJ5YnBIczRUekFlY0oyaUtFVklsbFN3?=
 =?utf-8?B?M2NvSDBuUUdSSUFzRmN3dDdOL3F6ZloyMVg3MEhCTDBTMWxQUjJuUTlEZW0w?=
 =?utf-8?B?SDIvbGwxQUZjNCtwclFQMlAxQzJQRVFldm05L3ZEQjlSZDFTTFVCUHZIaUdw?=
 =?utf-8?B?RHl2U0Z0Vy8xVUh4R3hnZ28yUGt0cUR0WjBENGl0SU9adXUrc3VPdzVnSkVZ?=
 =?utf-8?B?N0xzcFdyZXJMZ3p6NWVhbTBuQjVVckEySmxvcWd2T3N2Z0VXS0RST0RIMGhu?=
 =?utf-8?B?SEdQSytOOC8yZkgxR1Bya2V1SnZMWm1CRlN2cHQvcWYwNkxsSTFVd21VQ08w?=
 =?utf-8?B?T3RHOWIxeDkxVDREOGdaUHVFakM2eG9TYVdpbE1hSElteCs0S2x2MnRIMFJJ?=
 =?utf-8?B?blNxS0R2MzdnVVN4S01rcDVsbElHaEw2emtNeHlsRmpXNkltM3E5aHFpdkVN?=
 =?utf-8?B?OXkydjNRZXpIVnlNZ2VFM3ZUcmtCbExVRFVVQzFhUmU2Y3dVbHp4R3RMaFdH?=
 =?utf-8?B?TEJlUm13V2dlc3F3RjRveWJoRGtjRVdXNzNhNGJZdmxMYTlLeEJ1a1piaUxT?=
 =?utf-8?B?SExVL094Vk04RGk1Wk4vWkh6aVpzUkcxdmhiY21NN2N2V0xOcjJMT2ZmbmpR?=
 =?utf-8?B?dGRaeGxlbzJPTnc0ajQrQ0RnU2dzRzllUUNtaUlQWWlsNFNoZzBKdzduWS9t?=
 =?utf-8?B?eUhpZHJFUXRLLzRpemN0RHhlTHR1NkMyTnZhQzdLMjBTZkY2a0l0OWlMZXNP?=
 =?utf-8?B?ZXhyUDBiZnhJbmF1b0E2dk1SVnUrQXpKY1g0VHZmdW4yNVNRd2NyUStFSWly?=
 =?utf-8?B?azlDUXpwRHo5M3Yzb25rUVh3WE5ZcTdjSmRFNnFMR1ZocWFYT1dOSS9Vbjgz?=
 =?utf-8?B?eURQUHlzK0x6SUs5QXRJRTcyNzhJRG9QWVk3bXlkajUzbU5laS9lcXNLT1Ra?=
 =?utf-8?Q?m2o9g5JyAsZWl8KV/5yT+434W?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24115b5-f2af-428c-3c60-08dca4f63603
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:47:35.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw38KF7g1MtahuqzQ3zJ+4SQlF93U3yXTW8Sv1PLcpvE0/xPHhoFCsnUFaFbn4r1Ajq/t7Do6EsaWgHgPmvEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271

Armada 380 has smilar USB-2.0 PHYs as CP-110. The differences are:
- register base addresses
- gap between port registers
- number of ports: 388 has three, cp110 two
- device-mode mux has bit refers to different ports
- syscon register's base address (offsets identical)

Differentiation uses of_match_data with distinct compatible strings.

Add support for Armada 380 PHYs by introducing a per-port regs pointer,
and add extra logic mapping port id to device-mode mux register value.

This driver is not immediately usable on Armada 38x as it relies on
syscon framework for access to shared registers.
While all CP110 based designs declare a syscon node in device-tree,
Armada 38x has various drivers claiming parts of the respective area.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 97 +++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 4922a5f3327d..29ee73b6d8b5 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -76,7 +76,11 @@
 #define PLL_LOCK_DELAY_US			10000
 #define PLL_LOCK_TIMEOUT_US			1000000
 
-#define PORT_REGS(p)				((p)->priv->regs + (p)->id * 0x1000)
+enum mvebu_cp110_utmi_type {
+	/* 0 is reserved to avoid clashing with NULL */
+	A380_UTMI = 1,
+	CP110_UTMI = 2,
+};
 
 /**
  * struct mvebu_cp110_utmi - PHY driver data
@@ -104,6 +108,7 @@ struct mvebu_cp110_utmi_port {
 	struct mvebu_cp110_utmi *priv;
 	u32 id;
 	enum usb_dr_mode dr_mode;
+	void __iomem *regs;
 };
 
 static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
@@ -118,47 +123,47 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
 	 * The crystal used for all platform boards is now 25MHz.
 	 * See the functional specification for details.
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	reg = readl(port->regs + UTMI_PLL_CTRL_REG);
 	reg &= ~(PLL_REFDIV_MASK | PLL_FBDIV_MASK | PLL_SEL_LPFR_MASK);
 	reg |= (PLL_REFDIV_VAL << PLL_REFDIV_OFFSET) |
 	       (PLL_FBDIV_VAL << PLL_FBDIV_OFFSET);
-	writel(reg, PORT_REGS(port) + UTMI_PLL_CTRL_REG);
+	writel(reg, port->regs + UTMI_PLL_CTRL_REG);
 
 	/* Impedance Calibration Threshold Setting */
-	reg = readl(PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	reg = readl(port->regs + UTMI_CAL_CTRL_REG);
 	reg &= ~IMPCAL_VTH_MASK;
 	reg |= IMPCAL_VTH_VAL << IMPCAL_VTH_OFFSET;
-	writel(reg, PORT_REGS(port) + UTMI_CAL_CTRL_REG);
+	writel(reg, port->regs + UTMI_CAL_CTRL_REG);
 
 	/* Set LS TX driver strength coarse control */
-	reg = readl(PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	reg = readl(port->regs + UTMI_TX_CH_CTRL_REG);
 	reg &= ~TX_AMP_MASK;
 	reg |= TX_AMP_VAL << TX_AMP_OFFSET;
-	writel(reg, PORT_REGS(port) + UTMI_TX_CH_CTRL_REG);
+	writel(reg, port->regs + UTMI_TX_CH_CTRL_REG);
 
 	/* Disable SQ and enable analog squelch detect */
-	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	reg = readl(port->regs + UTMI_RX_CH_CTRL0_REG);
 	reg &= ~SQ_DET_EN;
 	reg |= SQ_ANA_DTC_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL0_REG);
+	writel(reg, port->regs + UTMI_RX_CH_CTRL0_REG);
 
 	/*
 	 * Set External squelch calibration number and
 	 * enable the External squelch calibration
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	reg = readl(port->regs + UTMI_RX_CH_CTRL1_REG);
 	reg &= ~SQ_AMP_CAL_MASK;
 	reg |= (SQ_AMP_CAL_VAL << SQ_AMP_CAL_OFFSET) | SQ_AMP_CAL_EN;
-	writel(reg, PORT_REGS(port) + UTMI_RX_CH_CTRL1_REG);
+	writel(reg, port->regs + UTMI_RX_CH_CTRL1_REG);
 
 	/*
 	 * Set Control VDAT Reference Voltage - 0.325V and
 	 * Control VSRC Reference Voltage - 0.6V
 	 */
-	reg = readl(PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	reg = readl(port->regs + UTMI_CHGDTC_CTRL_REG);
 	reg &= ~(VDAT_MASK | VSRC_MASK);
 	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
-	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
+	writel(reg, port->regs + UTMI_CHGDTC_CTRL_REG);
 }
 
 static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
@@ -191,8 +196,15 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	struct mvebu_cp110_utmi_port *port = phy_get_drvdata(phy);
 	struct mvebu_cp110_utmi *utmi = port->priv;
 	struct device *dev = &phy->dev;
+	const void *match;
+	enum mvebu_cp110_utmi_type type;
 	int ret;
 	u32 reg;
+	u32 sel;
+
+	match = of_device_get_match_data(dev);
+	if (match)
+		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
 
 	/* It is necessary to power off UTMI before configuration */
 	ret = mvebu_cp110_utmi_phy_power_off(phy);
@@ -208,16 +220,38 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	 * to UTMI0 or to UTMI1 PHY port, but not to both.
 	 */
 	if (port->dr_mode == USB_DR_MODE_PERIPHERAL) {
+		switch (type) {
+		case A380_UTMI:
+			/*
+			 * A380 muxes between ports 0/2:
+			 * - 0: Device mode on Port 2
+			 * - 1: Device mode on Port 0
+			 */
+			if (port->id == 1)
+				return -EINVAL;
+			sel = !!(port->id == 0);
+			break;
+		case CP110_UTMI:
+			/*
+			 * CP110 muxes between ports 0/1:
+			 * - 0: Device mode on Port 0
+			 * - 1: Device mode on Port 1
+			 */
+			sel = port->id;
+			break;
+		default:
+			return -EINVAL;
+		}
 		regmap_update_bits(utmi->syscon, SYSCON_USB_CFG_REG,
 				   USB_CFG_DEVICE_EN_MASK | USB_CFG_DEVICE_MUX_MASK,
 				   USB_CFG_DEVICE_EN_MASK |
-				   (port->id << USB_CFG_DEVICE_MUX_OFFSET));
+				   (sel << USB_CFG_DEVICE_MUX_OFFSET));
 	}
 
 	/* Set Test suspendm mode and enable Test UTMI select */
-	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
 	reg |= SUSPENDM | TEST_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
 
 	/* Wait for UTMI power down */
 	mdelay(1);
@@ -230,12 +264,12 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 			UTMI_PHY_CFG_PU_MASK);
 
 	/* Disable Test UTMI select */
-	reg = readl(PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	reg = readl(port->regs + UTMI_CTRL_STATUS0_REG);
 	reg &= ~TEST_SEL;
-	writel(reg, PORT_REGS(port) + UTMI_CTRL_STATUS0_REG);
+	writel(reg, port->regs + UTMI_CTRL_STATUS0_REG);
 
 	/* Wait for impedance calibration */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
 				 reg & IMPCAL_DONE,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -244,7 +278,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* Wait for PLL calibration */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_CAL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_CAL_CTRL_REG, reg,
 				 reg & PLLCAL_DONE,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -253,7 +287,7 @@ static int mvebu_cp110_utmi_phy_power_on(struct phy *phy)
 	}
 
 	/* Wait for PLL ready */
-	ret = readl_poll_timeout(PORT_REGS(port) + UTMI_PLL_CTRL_REG, reg,
+	ret = readl_poll_timeout(port->regs + UTMI_PLL_CTRL_REG, reg,
 				 reg & PLL_RDY,
 				 PLL_LOCK_DELAY_US, PLL_LOCK_TIMEOUT_US);
 	if (ret) {
@@ -274,7 +308,8 @@ static const struct phy_ops mvebu_cp110_utmi_phy_ops = {
 };
 
 static const struct of_device_id mvebu_cp110_utmi_of_match[] = {
-	{ .compatible = "marvell,cp110-utmi-phy" },
+	{ .compatible = "marvell,armada-380-utmi-phy", .data = (void *)A380_UTMI },
+	{ .compatible = "marvell,cp110-utmi-phy", .data = (void *)CP110_UTMI },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mvebu_cp110_utmi_of_match);
@@ -285,6 +320,8 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 	struct mvebu_cp110_utmi *utmi;
 	struct phy_provider *provider;
 	struct device_node *child;
+	const void *match;
+	enum mvebu_cp110_utmi_type type;
 	u32 usb_devices = 0;
 
 	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
@@ -293,6 +330,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 
 	utmi->dev = dev;
 
+	match = of_device_get_match_data(dev);
+	if (match)
+		type = (enum mvebu_cp110_utmi_type)(uintptr_t)match;
+
 	/* Get system controller region */
 	utmi->syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
 						       "marvell,system-controller");
@@ -326,6 +367,18 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
+		/* Get port memory region */
+		switch (type) {
+		case A380_UTMI:
+			port->regs = utmi->regs + port_id * 0x1000;
+			break;
+		case CP110_UTMI:
+			port->regs = utmi->regs + port_id * 0x2000;
+			break;
+		default:
+			return -EINVAL;
+		}
+
 		port->dr_mode = of_usb_get_dr_mode_by_phy(child, -1);
 		if ((port->dr_mode != USB_DR_MODE_HOST) &&
 		    (port->dr_mode != USB_DR_MODE_PERIPHERAL)) {

-- 
2.35.3


