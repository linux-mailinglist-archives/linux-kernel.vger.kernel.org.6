Return-Path: <linux-kernel+bounces-304502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DC6962107
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27EC281B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5615A842;
	Wed, 28 Aug 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="evxXLPC4"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2102.outbound.protection.outlook.com [40.107.21.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFE158DB9;
	Wed, 28 Aug 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830074; cv=fail; b=LokeH8dIDoczF6fhFb/rRfE4yhl4IsAwto9lvWnNsz9qUM4Z9IDKmqHYPtHdtYPjKhxTtxk2L89uMnKzT9EgxMHpNd53bIUnq5RVUr8DZ+l1omu/UQRPY7S4scl6hlGjb8sRPyu+6UEVGQZ9maGZh76+OFmOYYlLfF51cEaXatM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830074; c=relaxed/simple;
	bh=aajpUiN3VRGm+TGKBOC0zmUuEmNIKZhthnpAEl4tAyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ul+OAeffW9n809x+rqkg8RoEYWTH0hvY2GPHddGWAgwK0Q0r+waJRURmTy4y6u7FiMCb7z4NkT6u6FGG0Xukb29gTahvpS59uy567mygWH95te24CCs1X1yigw2yqqgvnm6ySZrxeRanUwlCfXhUL/3yCyJUM42WqvkOAFhGNVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=evxXLPC4; arc=fail smtp.client-ip=40.107.21.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGXeP6HhytZvOLXeDXwcV9Iy7UOsYJTi81EohXylE4iuoBpH6d8CAf7sWrLnvx3xz7NmHLP/PQvSC0a80ThXnk3HgMguR1O2GigY8WkT0n74fnv2m/UgRD9vrHg4N/Y98i2ib7jcrrACIjXv2EqYDYYggFc673r/7Mq+W1stbDLqGu7kcQ80YKN7sKb2d7KdNUtRu75tpA88PC3enCmYSaaZZxjqsP6tPiXlCoT7N/TlI2a1BF4ObX1pOKXzI7OoUEIOh/VrpPo7vH5XKN9FmBYVH9ov2MrNLp89HHrpwJUVoezQ7Y06cmuCG8LDNOs/8JwYhzrUK1P1OLZPFvI0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKYutbQdkPFGETHOTjjlWmR0LBwqyqduSdAx+gC985A=;
 b=Y7NvRCVcoCn1Wv1ZG/C2ISijKe142rZXwdaRU7rMkVLu2dGXL2FMd/vQUJ9sL0Mt4W/mw23RzdR7wKWp3zIbZs0OFD3ntLCmWSvqnqBZRjiARk2Kp1J6howg2Rqh4IDIV08BHMdnMhTaFtVDb1p5filyjHb6nhPKqn7Y/Nge9M2bKW1eXAmXPG2RuQO96AhwHoh8XEkgpbguHLXc3i8/iTSF1Pm79/EFIyvWxIgVpsg4eue6Hxa6iM36XH8Gd8OnB4hnsjzPG2w6JJBTeMHwTbXur/tA9AS7dEiZht5T0H8uW6DYl7taSa2Sb1n8+QPVwYew50/HGbOH8efCRRi0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKYutbQdkPFGETHOTjjlWmR0LBwqyqduSdAx+gC985A=;
 b=evxXLPC4xSlAsuI0Gz5ajyrp/0NbURoeP+YhdqM5yrPvfoPmkE5QQFZD2wBk8SpZuY6hOn0YtY2mx0aA07AHRw4i8339txFzjkdmr/HaJgPg5uGkpTRGzMq3/S6/yf9moDOOQQTqp3igIeoS7V0nEnckcO/F59hTZ3hCnCfyQyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB5311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 07:27:47 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 07:27:47 +0000
Message-ID: <b5c280f6-098b-4a76-998e-4b30c8917f57@kontron.de>
Date: Wed, 28 Aug 2024 09:27:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: imx8mm-kontron: Add DL (Display-Line)
 overlay with LVDS support
To: Shawn Guo <shawnguo2@yeah.net>, Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20240806133352.440922-1-frieder@fris.de>
 <20240806133352.440922-5-frieder@fris.de> <Zs6R6pqpFybPDa31@dragon>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <Zs6R6pqpFybPDa31@dragon>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b936c4-6464-456e-899f-08dcc732ea2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHRpV0pVZUpxdEpTWkhtMlU4MnVlVkpuWXJZYlRHcnVvTnhTdHRVQ3J6dHg1?=
 =?utf-8?B?U0RoeTdrbUM4ZGdrMExnc1BBMDR4YVl4aGt5SVRlVFNKOXczNUE1NlV2d0wr?=
 =?utf-8?B?MEdZUDJzcUhsSU1neGM4YmdSTnczYjhUeCsyUWZnck96N216blQ5ZElScGh6?=
 =?utf-8?B?ZUIranlOdVlaRjFadEtMS1lCWFhxbkR2V0xHTGxKK2puT2RRWUtvQkFTTjIx?=
 =?utf-8?B?RGV5elM1c2FCdTRUR1JsTWltNFA2d3M4S2dzcGJPR29PYmY1U3Jxb3NXdE5L?=
 =?utf-8?B?QllyVCtod05xOUdwSFFrbnNReXIvS3JiL0pkc29UZFB4OFUrWUxWNjB5blJt?=
 =?utf-8?B?MjZZbHJtOW1teG15eTJ3WFVpTCt4emR4eW56dEdtOXFQbkxVSStpRFMvaG5R?=
 =?utf-8?B?S0k2R0lZeCtxbXQ0RzVLaFZpc0pGUERzUzQyWnlWNmkzbVpSeTMzaHI5ZUlp?=
 =?utf-8?B?ZlRyMnlrZ0U1a3VlWDRrSk1TSitnekJmQnh6QVh1U3A4ZmlPOE5Bcy9aVHlE?=
 =?utf-8?B?TXVvOGpZMmFPZkhiaG1IKzNCL004dERWc2pNUU5rSCtvQkU1T0l6UHRuYnpa?=
 =?utf-8?B?UFVndjdwblZoSEp4MkhkRUg4eVE5YzRDT2ZDOHRwek1sUWxPQVQrY29nRVll?=
 =?utf-8?B?Vy9mendVSTVlRjc1WGRtVHBsT3RldEJUQW5XY0RMVWxsQzNYWXhaeHVHME81?=
 =?utf-8?B?NkRROUlNRXlSOHpENVJxVlo2K0d2dXJUb2J5NjI5NkpiZ01JYzdKd2xVTkRn?=
 =?utf-8?B?NlhGaVlsQWx3dmppWjZoYXZEM1VBRkJkZjNwMjR5dldDdk9na2VUT0Z2cVBn?=
 =?utf-8?B?dnFhRVQzWlVRZlJZTEV3cmdXc1RuVXRMalAvd05qVEVZWEg0bzFwdG1rRGJy?=
 =?utf-8?B?YXpZMnBHZkE1Q3lLQis1V2Z2K0VBWlNNVUFSMlBpOUtpR2pGdXZRWitHZk91?=
 =?utf-8?B?UmZWV1A0dVViOG5HbEx0bDdDOHMzMkZEUVRTVWMxL3Q5UXNZRWkvOUlucm9N?=
 =?utf-8?B?aUh0Myt4aUdUQStiT3d0aVMzSkIzSnNJNDZlaHJGUlUyQi9PMkc0MG8yWU9G?=
 =?utf-8?B?SkZQeC9NTUcyR2tQUzFpL1Q4ZmxvZlNHT3lUbFBQRW9RYWRFd1FqTGRpTmhp?=
 =?utf-8?B?YzUramVZSjRjTGN3Qm9sa1IrOHhKYVQ3SDU0TGFtbmpLS1BUbXhPdWEwakRD?=
 =?utf-8?B?UTFReUk2WTU2N01hQ1NLS1d0WlYwamc5c3NURU8ySi8vVUdvd3ZneHk3eHFP?=
 =?utf-8?B?Ym5WTURlTVV4N1lDVTVYeTZxQWdZaDZKZDNqVjVXR3p4MC9aaVpvakJ6SXZy?=
 =?utf-8?B?c0Q3eTN6NTl4c0FBU3Bwb3BibWdpUGluaWJ0RFpZWTBMWHprRTRQNGJtNGFW?=
 =?utf-8?B?MWU1bDlqODhLTHFNSGFwc3cycFpEZGxSckE0eFc3ajMxbzJBOWdxSy93Uy9R?=
 =?utf-8?B?TjBGd3FXQlFzZUcrbHZiRXp6Rjd4TTA5OEppRkRCc2dZNmR0YUJUcGtJbk0r?=
 =?utf-8?B?K1RsS1RLSmV2UHVscVJ3b2o0dXdCNC9hcVVqOGdNRHl3WERNMURoUHRhOUpG?=
 =?utf-8?B?ZURhWS9hNUZKZ2V4ZXNFRUc3emQvYnVHbDd3Szl5MUZqajREVTVVVEdjNFQy?=
 =?utf-8?B?bzROaTdOZ0NvUXpwRGhudWl3blp0dWt0b2g2NlRyVWs3OUQ0ODdoNXdwZ1gw?=
 =?utf-8?B?WVF6ekFxWmdLTlVaVkhhVzlBdFo3b3lkdmgwaUFYYWlHYXYvdGltRmRLWW0y?=
 =?utf-8?B?OUFxbnM2UzZiWElSd0JXZzJKUUpQVy9mQ21qc3hsSFF2cEVaRkhGWHBndS9P?=
 =?utf-8?Q?QY6wZtPmgzfEIH5yKsYota0mmhVwGWLgc2qvs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZXTmRmaHJnNk9wRlBVaG5MOTJkNlJlMjVIZ25peUZFdGhnZG9oUHg2TFpU?=
 =?utf-8?B?ZGlib3RJd2RWZmlsRVBqS0N1L3NYRHZXaHBPaTBmQzFFSXpjR2NGZ05iNk9H?=
 =?utf-8?B?OXZUbGdDN0VqckxGVVRkQzM3YVlobWpaRkphb0k0a0tJN2lJNU82VmRVdmE4?=
 =?utf-8?B?aEY5eE0xN1JneVRyWlpsMEh2QjVaZnFNZ2F4YzYrL3VUV2dzWURTUWZTRE5W?=
 =?utf-8?B?NmJWemJDdWVSVkF3VE9sQWxiYlQzbzRTOHNsUy9DWUdFNzBYMUk2amo3bWlz?=
 =?utf-8?B?bHQxclBreHd6ZUZnakVka1lKaFF0bnpqWUxXV0w4UGJMeGV3cW9JWUg1UlNK?=
 =?utf-8?B?WlF2SVErTGNxR01OeHFWV2lhYllMc0VTOGM2TXkrQmYxMytkZ1UzSjJIM3ZF?=
 =?utf-8?B?dmlVQjl0UnFJcUVNalBxL0pvc2ZNeHYwRlkyWmpJTkF1UzBGSWk5ckhiOFNn?=
 =?utf-8?B?WFRtdStKNDAxYSt4R0NDQTVHWjNJaXZXVE1GSitDU01QSFVvUytMc0kvTUln?=
 =?utf-8?B?eGhvNlFkZEcvaFYweUl4UmM2WEtUMzIxZThyMTUvK3VObG9jTVBpYVdTTXdU?=
 =?utf-8?B?VC9mS2liZ0krUWo1eG1WWFhzYXMzcUozbi9SdXVzcUhYZ2hkWmxQSkhNNzc4?=
 =?utf-8?B?Y1VwdnVxSW1NbWlFM09ET3dLaHRMZGdEYWo2SlVLZ1ZGT3FJQWg4WEVCZXFn?=
 =?utf-8?B?a0xEdjJZSHBzcThreVZTNUJLZ2FSaXpxenVkL1NRdEM1OUx2cGJyZjBnbGkx?=
 =?utf-8?B?d3lnZUFVQ1N1T3cwaTFJN3VnQ205eElPRVBZVElmeG1oUlA4T3NCRmNYelo5?=
 =?utf-8?B?REdNZVJ0NUhCdUlKQlFzVEl3WmVLQ2lkRFJYL3RlL1VQM2cwd2haUDg0OXpI?=
 =?utf-8?B?cFhrZnNkUVBkdGFqNmVNajdMWlpDQTdHcUJnaEJTYXRDUnNRNDFDd1NGRmdY?=
 =?utf-8?B?RWJXSjIyNzk5TStnVDVzbEErVTFyNUEzVGllR2pqSk51VVRVQnhZQS9xS2gr?=
 =?utf-8?B?VXBHOEVpcHo3TUQzL3UzckM2eGRvM0NrL0dsQXFNK21pOXBWNDBEWkJja0FR?=
 =?utf-8?B?NGxjbUZGWjJxeWZBNnhTbndIZzR3OWpvb1BVb3IyaEpRaHJKWTlYWFdGYkJm?=
 =?utf-8?B?a3pYL3YzRXJnVHpuaW1zQ09IRzhQU3djTjJ0cENrb0ZaZS9XTFNRNnFqMnFK?=
 =?utf-8?B?WHVhSDZQNVZkTzNmdUt3WlZKT04waVQ4b2hxdmdlWlZtd1lsMFgxdG9leDdU?=
 =?utf-8?B?Sm1la3AwQXJlS2tXV3hxbU5YLzY4Rkx2ZHlhem1JVjhvRHFabHp0UitEOWhJ?=
 =?utf-8?B?YVR0SVEzNDliejRRU1pnQ0k5Y0M4QzI5K25vQ2tpL051ditaWlpnTVNZZWt0?=
 =?utf-8?B?ZXZQOFRNLzhsSnVwRklXdTN3L2YvUitlVGQ4RVBKWmlzRGpZTVhCbC8zV0Qy?=
 =?utf-8?B?Rjk1Q2xDMENKK1d5YzdyQWl1ZndZOUZ6NTI4bWhwSFpiUkxsZW0zODdKMFA0?=
 =?utf-8?B?UjdZTmhJem0xVE52MCs2YWZNUk95bTZjby8xM05lSE5VZVd6RkFRRUNvZTdE?=
 =?utf-8?B?MWlGdlF3MSttR0xKV24xTVFUYU1rRE5Lb0k4eXRXLzBEUkUzaTlubkc1M0x3?=
 =?utf-8?B?ZHVDSkFKMkRkVmk1SFVVVENzVnBVc0RXV21CejBod2RPRjFwRmRiaHo3Wkcv?=
 =?utf-8?B?YkpNZHdMTzVTbHZnRzJSREUxeEJiT0svMFBzNXBZL1padDV6SHVPeHNJaGRp?=
 =?utf-8?B?K3AvUTBucWlNYVF5LzBoS2RWaWNZSmx1NDhtYjRVTmpaWWVxY0JMMldvVlZz?=
 =?utf-8?B?aWlLeXNCOFdpVTdRQzMxRjd0ekIxVUlJa2M5YU16K3gzRFlscjlMNGNINk5n?=
 =?utf-8?B?RkIwamFPZmZ3WGRzcTBKUllaNkthck41RzRJUWVnMTJLbVhyczBYcnJzZTEz?=
 =?utf-8?B?MlVKRFY0STZjNXczVGgyZ1dHTTFrZEpnSDFmdlY2bGdpRExCaFQvNE1OR25I?=
 =?utf-8?B?QkQwVHJhZ3pXN3VKNmVqak5QbWt3NVFsTmNEME1GRW5SS0E2M0c2Q2NQYnZw?=
 =?utf-8?B?YUNYRlZMdjErUkhiQVU2Q1hMOVlCbnVOQUppODhFdkFHMnNFRDBCUHlxMnVo?=
 =?utf-8?B?QkJHOEdmMkhQYUhuTWVOQXNEYndwbVUvK3Y4RnlqQWhpaDJhQUJILzJ5Misx?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b936c4-6464-456e-899f-08dcc732ea2a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:27:47.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3CNS4jT/FTylgE4rV7p20VQdx+CyPUjRG0lUy7/DFei6lFMZOdRS1UJz3HANUeYm8+iFXeyW0xHaN/OHIyxUwhdNAnTeNquuYhX5dG8UYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5311

Hi Shawn,

On 28.08.24 4:56 AM, Shawn Guo wrote:
> On Tue, Aug 06, 2024 at 03:33:02PM +0200, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The Kontron Electronics DL i.MX8MM consists of the BL i.MX8MM board
>> and a 7" LVDS panel. Provide an overlay that enables the panel.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Note: This currently throws the following warnings:
>>
>> Warning (graph_port): /fragment@3: graph port node name should be 'port'
>> Warning (graph_endpoint): /fragment@3/__overlay__: graph endpoint node name should be 'endpoint'
>> Warning (graph_endpoint): /fragment@3/__overlay__: graph connection to node '/fragment@7/__overlay__/ports/port@0/endpoint' is not bidirectional
>>
>> There is the following commit in DTC that relaxes these checks and
>> will eventually resolve these warnings:
>>
>> 84b056a89d ("checks: relax graph checks for overlays")
>>
>> https://git.kernel.org/pub/scm/utils/dtc/dtc.git/commit/?id=84b056a89d3c5b6cf6c5eeeafd4c4b14d6333aa9
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 210 ++++++++++++++++++
>>  2 files changed, 214 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index f04c22b7de72e..d8af069139920 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -244,6 +244,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>>  
>> +imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>> +
>> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
>> +
>>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
>>  imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>> new file mode 100644
>> index 0000000000000..b2d593d700e2d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>> @@ -0,0 +1,210 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023 Kontron Electronics GmbH
> 
> 2024?
> 
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "imx8mm-pinfunc.h"
>> +
>> +&{/} {
>> +	compatible = "kontron,imx8mm-bl", "kontron,imx8mm-sl", "fsl,imx8mm";
> 
> Not sure we need compatible in overlay.

I've seen discussions around this elsewhere. We don't need it, but it
seems a nice way to express which base DT this overlay is intended to be
applied to.

Anyway, I can remove the compatible for now. Your other comments will be
fixed in v2 as well.

Thanks
Frieder


