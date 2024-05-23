Return-Path: <linux-kernel+bounces-187470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE18CD246
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B9C2815CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F01487DB;
	Thu, 23 May 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q+pcjNgQ"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A41E4A0;
	Thu, 23 May 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467440; cv=fail; b=Vq4GosLUHQJ7PQLil0UVDUIwJk0c4IUm8qAJjHiiOt7D/9j9lkNroD0mkcIfcbivzt0KQBYOt6Ka8byypTSZNS9kIIjYrcH/UmmJ2ySXU6rLy3mamGg6tUEsRnL7X4rwohCVxWrd8S7a8/146O8ZXA/eOFp6al/pxcrpF9ovdPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467440; c=relaxed/simple;
	bh=xb+imZixQQ7piCKgYHUUzoM1TFBEVliSRAgbI07DC3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAcW6LRk3te2QRpy+3lFMraV9tFlMGquYXCWw6t1Kn+FOZcU4H2HTHiPfH1PXyr8bDPJtHy0dJ/cEDH9Z17d+/SJpdOddFI0i7OJiMISNFW9Z9FvxGHUCw1OC62yTeOVkcO+qRPOB3i95Jo9Smmxw3/MP3TPLJQv7iaodtGcPe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q+pcjNgQ; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGGjI7VnS2e5Ibn7YDZRcXOV9LEpBkEhz4f/ULPul4QMMGo41geLKUKGws1qlzdQrfk93xzNiEI/4bGmBtIJQ3o/lP7CPKDjlLwePQVu/rqMbagGRgpRRmNBdTLmFFc2BYOS23pnouxqrabnkZDiLgzrayM31q4npSGWB48kFmeE+3s2OT7JTTWl50EJP29jKptYCNQqcDwMuosKHdkAvR7+FwoV63urCrvs0Bhlip7T7CMqvqQdPUB/3y5WFEAqb7CIX4TO/lWrkCAHJu6PgajeKFg32BOD4lb04zI56IgvI1kpdNNX6zC66rMIU9LZ9twgSTRagjzERkihDe8enA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEqN2gaqvaAuZMu807hLo2KmJPpRpLrr/2Kxgu1Zy+4=;
 b=h213mHn2O0D34PDXHuDWdzPDmCPAVziE2gJiGnvRCzCOmLRJrg8y/UIJIMIcmjNLmQOhq3ed7a6OmfaMBCPnjauQEqN03Klq+SFqK7PasrzAkBOijJ8xEDfx/JIHV4B6P6y3o4bIsfpNjjGkmnDmvo4BMtt3Xyaj2jCJ8+t5+wll7HH/CIJOpAPHEzSshsIT2qWfrOreMKQyB5+zXfvYtJh5h34i1cU7cOC6Es83ymaXWhxpWclDtfw9VYWxk9cMypILGWQYzDG8i31R7fkrZp74UWh9iEwF9tdqrAxymfeIv1gL36Vl86wBJD5H7rJ+IxL7umPuHglg6Gd76HFujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEqN2gaqvaAuZMu807hLo2KmJPpRpLrr/2Kxgu1Zy+4=;
 b=q+pcjNgQOJlUU4QnWG+EIdK7M2BwivexGBse6UD8uSzczfExA+znmexEYFHj+WLMR0HUyTFAE0Vco8jZZHMu48KShEdbIiGBa3pp4gL36SIIiWEWz926F0lZzc7yLykYQiBQ1/FdL+2pOD4cJz1Qs93+U9rzQ+iOEsHxvfzGvWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 12:30:35 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 12:30:35 +0000
Message-ID: <dc31c4ba-1bea-4056-a68f-87d742eb8da3@nxp.com>
Date: Thu, 23 May 2024 15:30:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: DT schema bindings conversion mentorships (was Re: [PATCH v5]
 ASoC: dt-bindings: omap-mcpdm: Convert to DT schema)
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Julia Lawall
 <julia.lawall@inria.fr>, Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
 <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DU2PR04MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c101f5-16bf-4e5e-5f37-08dc7b24250a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zkx1VDFiNktaQkZGK2kzVlpodzlPakZlZFM4eG42QlJHSWlRY3UvMW14Z1ZP?=
 =?utf-8?B?T2RaenhTSXBybkRBVFBNcjQvR3JCTUp2YUJTVjRMaUZieTVRMi8vT3dPNDFR?=
 =?utf-8?B?YXBNQjVXdjRqemlaZTN4SHlGRUV4aXJScUJnT3c2MXJlR1FtWFcyS3lyc2NF?=
 =?utf-8?B?b3h3ZTF1eTJuekE3RTBaRXdrc2xVRitpTzVNbTgxcWFZZGFoSEtIeGx3WlRa?=
 =?utf-8?B?OHpFTHNvUmJzcW0zTEJmWWpSd2JMK3ZQVTYzKzdIT2NvbHIvVHhIMFFDWFVl?=
 =?utf-8?B?ZTA1QjM0S1N1VS8wWVpsb0JHWmJ1WFJ0STNFMHZzdGZLTGRnZm1weUJZdWt3?=
 =?utf-8?B?Q200RisyZVJmMWxYTkVHaXRlRWViNHFFWU1WRmlYMnA5azg4UFUzRXo4QUR1?=
 =?utf-8?B?d1M4a1ErcllYMW1sR0U1ZWJ1SmhmUXNKTHlyaFlibnE2SlR2REw2bnc5K3RT?=
 =?utf-8?B?dzVSS2Iybjlsdzkzd2Z3VVhYakhqMzYzb0R0SER2TndCZTN2ZFlzc2F4bGsv?=
 =?utf-8?B?TjlGTGtyVzM4K3RKdy9GN2lzUEZzWnpSUnZFamEycFJqNjlzdjZmWjBhaDFL?=
 =?utf-8?B?ZndGU3ZPcTE3RTZkTnJLN0FEd3ZSVjcwemFMbnpmd2NEZHhobDJITloyaDZ3?=
 =?utf-8?B?NUEyL0U5TUpVdldMQ3h1b09vaUkwcUhyYWhTcGY0dEQvMVJsMVJ4dlJMRERY?=
 =?utf-8?B?Rnl5S1pmeHBGNzBZL2NUcVF6Ly9rU2hUWHJ1aS9WS05nWmF1Y2ZLMWFraXJI?=
 =?utf-8?B?SEN6YnJUR01URDJtZVVNOU9WZFR5c21jK2YzWWRhaVBCamJqcE1qSkRRbG10?=
 =?utf-8?B?SE1PWi9yUmJEV09XRTBlSHpLa0pQSHRMb3dsbERPM3pQQjFzN2dnYWx2Y0Jx?=
 =?utf-8?B?bFdCcVA4WWxNWXloSjEzL0xHcDg0eVJGRlFHV05BVnluOHFjaWhFTWxGN294?=
 =?utf-8?B?eFNTem9nWUxBZ3hwVjhSalFWZzFGa2NTRWVwbGdWTmVaalM4ZGFuWGdLRHBR?=
 =?utf-8?B?Yy92ZzJDYzQvQkw5NDJiWDBETjlUSkNKU1JHVFZQOW5mNTVPenFvakV0WVFt?=
 =?utf-8?B?cERZeDN6VnJ4ckVQSmtPY2dzTWIvaU9iay9mbmptMjM3aldQR3JnTlRtRVBI?=
 =?utf-8?B?WFo1VlhMeTA1UitSaVA2TnYxZUQyQklKNk8vNUdhMER1T3RqT3FjNW1tbGlv?=
 =?utf-8?B?R0ZWY1g5U2YxMzNkenpRdUQwdUliM0xBeVFvUGltOHNsZ01wbzhwMVNHZ1No?=
 =?utf-8?B?bTA1Q1luWS9xNE9IUnJSQW9maThtaGErSk12VzI4NE9pcDFlbG1Kc1hHY3ZZ?=
 =?utf-8?B?RXlMaFNiRXhiU2JEbCttWjJtb29ZNFNkUy9Zay9qeGhFQ21LdUwrVHh0V1px?=
 =?utf-8?B?TDl0b0hlckhPYWk1RjZhSk9vckJhZkQwZmp1SEJiSVlGQ1pTT2h5S29WVktS?=
 =?utf-8?B?ckZ6d08yem1yUlBxSW5NUWdFNFhhNW16NDdhVmhmTE5TZTB3VTN3UlhKeS9r?=
 =?utf-8?B?S2w5UzlIbnZCOGFud3dHMHpoYlRab3pwNWthQVAvRDhUOVo0YlhFV3NYQ2Jm?=
 =?utf-8?B?MHRjaTFPS01CY1gyazBsa2FIZC9taXRvUW1UVG5JZmp2bTFReDdqTHFvc3o1?=
 =?utf-8?B?cGJFcFBSazdmWDliVTZScU1CdWxvOXJBSC9rejQ5aFFHbzRBMVY5MmtrQzZE?=
 =?utf-8?B?SFNiV1JLV21CY05aU1UxUjU0MHo1U1VRcTRxQmZPSjhvWEZyM2pzVjRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFieVFPT0x0b0duc3BoeHhFUUdMdUhMWm1hMHdYem1KMXo1MnFYVjlkSE9r?=
 =?utf-8?B?VWdvRUV0YWlpYzlNeFMrRjErMUFlT2Q1M2swQUtQZVNVdGdHQ1VyZWpZODRC?=
 =?utf-8?B?MHhMZWQ4b0FTYVNZZmFnOW9nd0M1M2FER24vcTBENldnZWsweHhkcXN3S2RF?=
 =?utf-8?B?NHhOYlk0SnhGS2dxdklxb1pONUJ0dDE1Q08wWS9EajJwa0RRVE9Ya2dDMGxw?=
 =?utf-8?B?ZXRuaEhiZXhTblAxMnRiWEVuWHRDRHZESGpBWVpGbGJUMW9US1VPVXd4c3FX?=
 =?utf-8?B?SE84SHlxd2xwcGVHYXMzL0NvaUhFZ3BsUnBYczF0bWloZ3VuTmozbXhlbmhL?=
 =?utf-8?B?YldlUTduSEJ6a2htSWdnUlB5YmtaY0ZmZXNXTFYwWVhHSDV1QVRzb1JSZzda?=
 =?utf-8?B?bE16cGk1TlVscHlxMUYvSDMvQ2FCd2lLbnd5cGlLelFBRC81NEJCZU1YVGd6?=
 =?utf-8?B?RC9QZWErMExMMXYyYmxCU293cEZ5Sk5xdHpsNEdpUE9oWG8xRjdFTUNpNDNL?=
 =?utf-8?B?TlVEb2tKNjZLak03MzFHQ2xmcmFsWTdZUGlaZXR1bmFYeVZiRjJzbjNZZElz?=
 =?utf-8?B?WnVuMklTek1yS3praHAvM3ZtMXZ4cW1pVFdxS3Q1R1FnVXYvaHcxY0pmU3FG?=
 =?utf-8?B?bDdYU1RBMDZKdSswd2U2RG9mMzFjT3RRWlU3M2N2U2k0YktiMEkrVVk0MUVL?=
 =?utf-8?B?VWNoVHlZTDhFVmpENWtOalM2NG5mdm5OOXg1T0grQlNCSDJOcGpVa3NjTU05?=
 =?utf-8?B?czlmcHU0RzZLM29CQVkrUEJ1a1dzUWd5QWEwa1RWdkM4YWtDS1dwQVRubGRs?=
 =?utf-8?B?bkZNYVpJQnF2MDdoSUZLYUdXNXNKV0NyZE1SdHRNYnN2Kzd1Q0JhSHd2Q3NL?=
 =?utf-8?B?dDR2dlUwZHI0M2FjY2lwUDhEUTQxVEgxWk9iY3AwRGE3c1pCc0czLzdCbkU3?=
 =?utf-8?B?R2VwR29zdHhLWlZpQzd3a3JJWFErZDVycDZib2Z4eHIvSkVkWU9wdEJxZkhj?=
 =?utf-8?B?M2dRV3diTkNiaitvS2ZjUmJJRDlYejhmWUYwSy9rTStLbGhSZDhna0JOTE83?=
 =?utf-8?B?WG50aXNsNE9tb01MeHlmVnVzSWU3UFY4RDNxbXdXT2srbUZhNGFobUw4OEtY?=
 =?utf-8?B?VFZuN3VKMjI4aGpjNG9EU1dyWTNPM2gxNklqYUgreXIxbnhQSmMyMWxrVHNZ?=
 =?utf-8?B?dE0yT05sa1N1Ti9PWFJDZXNEZGdhcmQ2NmR2SlFDancrNEIrMTh5V2t0MVN0?=
 =?utf-8?B?eE9NWjNFUUZjaHJLVTl6N2czczQyWC9FbXVMbkN4eG9qOHhXNi8wOTdNZStQ?=
 =?utf-8?B?bXd3a25pU2RDckhuWFA4T1BaeXdEUWpGYVZyWVRHalpNRjlheEYvRW56L0RL?=
 =?utf-8?B?cm8wR3hNN1BzaTMyQ09IZUdPMWpFRk1id2NRRFhhZUIyOC9QMndVc0ZtNith?=
 =?utf-8?B?WFR5NGpCbUdMbER0Mm1HUm5iYzRET0J1NlhHRnlIWVpFN1ZOWTQ5WHZvVHdk?=
 =?utf-8?B?WUNrRllFWEdMa2N1Z0Yrc0RTRjQrdTk4a3R3bmtOa0xWeUYwbUgxOUxJSU9w?=
 =?utf-8?B?cFBVSGxCSHFjN0FyWFgzc09YOWdMTzIyVmRvYmtaOTJpMkNHMzhjYW9MV2tn?=
 =?utf-8?B?VElCdU9TUW5OdVZld3BORDZlL1RRcFpHT3VOcDl2QkpUeGdZTW9yS1pPNmR5?=
 =?utf-8?B?K2I4L1Erc25teGwzMjZDaFVoZFFvREVLeHFUcFl5OG0xYWhVU1RtSVYzaFh6?=
 =?utf-8?B?bkFwV3lJSUxBaW8rWnV1cUdQK2lRNFR2RkV0Mm1keldjQkcvY3craVhXNk95?=
 =?utf-8?B?ZGM4MjhVV3ZIWnZoQ0h2dE91cFBkVzF4NGtsRVR3Y2hSRk5QSE5KcmxveUp5?=
 =?utf-8?B?aFhldmx3SzQzZXQ1cnJoVyttbVRTOVlpN2tSYXAzK1Y5ZzgxL2kxVTlGZGxC?=
 =?utf-8?B?R0NHTVcvbzV3eDJCa2ZrN3c2OGhKaFFnYnFZM29obWl4TEdWcmhjVnZ6blN5?=
 =?utf-8?B?T0ozRU1rMXp1UlpkYXZNYTJoMStpbVZERjhSY1A3SzRRbTRpMThtaE1SUzVL?=
 =?utf-8?B?b1hHaHhhRjc3bUczcUZmNHRiVWNjZHcxTThXVXZwSjd2UW9wTXNicndYSmVh?=
 =?utf-8?Q?+45YT5T0hpFgojs3sKCimg/bk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c101f5-16bf-4e5e-5f37-08dc7b24250a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:30:35.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5kchdN4/gCUfZ8TYq5mPD7C4a9Eg9z89yZRibVVq1C2QD5/FTjSwNr2lL6Smr1JVWSVXpoavU2AK7b7hzu3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999


On 5/22/24 20:05, Krzysztof Kozlowski wrote:
> Dear Daniel, Shuah, Julia, Javier and other mentorship managers,
>
> I see some contributions regarding Devicetree bindings which look like
> efforts of some mentorship programs. It's great, I really like it. Only
> sadness is that no one ever asked us, Devicetree maintainers, about some
> sort of guidelines. This leads to sub-optimal allocation of tasks and
> quite a strain on reviewers side: for example we receive contributions
> which were never tested (tested as in make target - make
> dt_binding_check). Or people converted bindings which really do not
> matter thus their work soon will become obsolete.
>

Hi Krzysztof,

Some of the faulty patches are on me! Sorry for that. We had an 
unexpected high

number of people sending contributions for Google Summer of Code and I 
couldn't watch them all.

Now, the application period has ended and we have 1 intern working for 
the summer!

Will follow your guidance! Thanks a lot for your help!


