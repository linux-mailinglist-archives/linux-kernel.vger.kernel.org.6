Return-Path: <linux-kernel+bounces-187474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DE8CD24E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A03B21C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A51482EB;
	Thu, 23 May 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZ7lBvwi"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B51E4A0;
	Thu, 23 May 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467597; cv=fail; b=cNoLBRLyF4sgj1VZ0jORvIxxtJHifoXQXtS4c8MHfYfmG1vrDvZO0tU8Iw64aQ0wrjvENQ+P//AGVIXebIrlo2QaXtc+YvyDkr+WxKYpmuyDxx9c9S5lhRaq5Gp6TH3+14QyHoAgK+AuVLhzRkFZiWrRIQxGcpV289q7XNil/JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467597; c=relaxed/simple;
	bh=YDSgs+0MhO3Q2e6q5KylwF0o7rg2WV2Snkntx0dSbrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=midDQiEPnWZL5dOmmSkpIvRjXSOnEB47S1jYS1CyPhmgmtwEDBDpsPXPL0jz82sdkzfTEL4rSH4jX3I9C3mSK2Up6vlKdbxkvBNACVzsxeO6hpvT6ppguxjGr8arugcMuj1tm5dBLoKm0KhGbm9DrzqOe7jT0I3I3TZbZNzWKGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZ7lBvwi; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxI//mDMytVJ1G7bUIZTivDKIyglcHDdnKdHJ9f0MPdJRPQoxKSumullSgcNYG0HaPpm1mq1lW0bcjrCnvUWtjWwQ/IeZwuu8Jd5PwcUuHTiePckmjFDw5yzh6UbZKG6GBsl1sxmwxrs8dM6F9vrPU/oc1qp+67e3J67fUfJ8XJ40q/0PBVt1UixqeF1edPD/1f+NWDeAxfPanOcsXDxgZN4hbUlbpFit/r1HlJK8vPdcdLKlD2vF6l/KXsRDJP/jP64XPcLsR4YBQoXru0lrv/hsMGcx+gKkERgwf2NITqm0H7gXutkXtc6MghdtFfuafJV2gbQOi3HInwpZzIHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDSgs+0MhO3Q2e6q5KylwF0o7rg2WV2Snkntx0dSbrI=;
 b=LNh6+OlyL8Hbp1ufB4lKg5qOy6IH3PXbiidJlByl22KPsyh3BVXnWDMikFcegB56Kksr5VEMCJf3/AXZqdMsXqHycWrrJxuOCHrJ9jNUmfhJXZ2qg9zhrsne1stwNfLbAgzXkQIFHxGhsIpfZsigXqHenKExVm9iefC7sQ3WVl+oltAHcHTUR55Rgcs9jsCUeuasmtEfot1jD+nln5fDrCA01IjEtG01UI4lKTJ0K6JrsHQksxL4fl23q/O50Zk64f8gRzB4pPlf/Kq0M0a0qIekzUFHuGa6fLBEs5/3y3k2aJz7yMMy9k9XUVKU2Dbj/+t2cQ/hh+nIgCbUaVa89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDSgs+0MhO3Q2e6q5KylwF0o7rg2WV2Snkntx0dSbrI=;
 b=AZ7lBvwiB3S8oMBF4Rr+nD2mFLDvhy87BeJPZ0toEsrgP6JkGxrMnSmI/Q3V+QVF8nmu4kkht3+L2SmHiky+ddmC8qEnZS8NutC/nhu3RX3pL5kwREDnEKKoLosJivXagg2t/qk6oqKn8CyUuk1PEyfHP/sDnzuDRyRuXVbQxIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI2PR04MB10884.eurprd04.prod.outlook.com (2603:10a6:800:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 12:33:12 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 12:33:12 +0000
Message-ID: <2df11fd3-0778-494f-871b-bb6876f763c0@nxp.com>
Date: Thu, 23 May 2024 15:33:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: DT schema bindings conversion mentorships (was Re: [PATCH v5]
 ASoC: dt-bindings: omap-mcpdm: Convert to DT schema)
To: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 <20240522-unpleased-morally-4dfdee2193af@spud>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20240522-unpleased-morally-4dfdee2193af@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI2PR04MB10884:EE_
X-MS-Office365-Filtering-Correlation-Id: c49ce3eb-6c7a-4d31-45f7-08dc7b2482d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1NLWWxna3N2VWxQbUJjQ1dLeDNXTWM1ZlVSQWpaNGJXeTV5ZTlWY3NRRHRH?=
 =?utf-8?B?L3B2K0VFRk90eWtrbGhmQ2FjVGQ2Z2diV21FZWdpZnRCNkpnTFhGMUtjZUZL?=
 =?utf-8?B?NDM3dkVkWTdmMjNnYjVnT0hvUlRDQXYycFZ4RkdBMjYxamZKOEtYYVhEWjFC?=
 =?utf-8?B?eCtNdGpxY21KVG1pN0NVS1hqeDdSYmVPaE93UnNvTmVpVG9WU1Z1WlpiQ29O?=
 =?utf-8?B?SVd5VXRSUDNSYnNUQUhRUVd2ajYyNXozWHUrQVcrWWlYRXMyQlFCN2paNzFX?=
 =?utf-8?B?N0NxTlJIdTJtZVAwUWtHMUY2SzNsc2puQTRnU0ZaM2ptSHhGZnR1S2I1VmdJ?=
 =?utf-8?B?NlA2MmNwbDErSEJpRklUeldpNlFxTVd2VXNoaUxGQTNhNkNuZFhUQldtR2p0?=
 =?utf-8?B?UHRlMjNXNktUZ2VyRjliU0EvQjNWazZGalVkM01YK2FWeXhrTXVUenZCNSto?=
 =?utf-8?B?OWhHT2x4U1A1ZThyVGk2UjcxSDY0ZzNyUE0ydUhFa3lGSHEvb3Y1RE9ZamJi?=
 =?utf-8?B?RlJiRUhGdU9XUUM3ZVpuTm45VEtqcjNLb2RTc3h0UVhxZWo1Y1N3eHpEVFE5?=
 =?utf-8?B?dzhBS29Edk82K2hnSHFFR05GUm0yUWljdDExaWs5SXIzTVFMdFZoM0RjZ2R2?=
 =?utf-8?B?Y1ViSllRUENJQmZrUFBWWGFpNHJGd2c3eklsS1FPcHgycGkxbWp5djdlNjVX?=
 =?utf-8?B?YWNiOS9Fd0tGbXBKaFF1VUJIUzRGRlEyN2U2VFpKUkFJbkJweU85cmp3Ri9R?=
 =?utf-8?B?cGZiTHFZeWpjOXdmTTkzV3VMb3Fla01rWUx6WGM4ZDZRWTF5WmV2WSsraTBK?=
 =?utf-8?B?TjdaNXhJSndUWWZxMVBvUm5kdzFKSXo4MEQ1b2xobTBRSHkxd0xaNlhaMG15?=
 =?utf-8?B?OWpkQmJSenUwMUpqcVQ2cHk0N0grdE5EbjQvMlRVcDE0ZHZnMnJHaTFhdklz?=
 =?utf-8?B?eWlKeFFIN05JcCtubHo2eFR2VTNjN2dLTVIrTlBBeGk4Tjk2RW01eU5mc1dx?=
 =?utf-8?B?d1diZERQMytLaHErendSd0lEY0VWa2tjSnpIY0U4Z0c5T1pBbDMra1liTE9Q?=
 =?utf-8?B?R0xBbFV3NWIySCt1cm9HUzNsakZ4Tk4wWG1wYnBjTXBuRFlLa2d4WUtMQXRn?=
 =?utf-8?B?UUhNcXE1WXVNNXg3UjlPMWlnWjZYUmlBVXh1WnJ3d0xTT3R0OXZaVWhTMGVJ?=
 =?utf-8?B?bE5ER0xudXVnSnQvRmRMTFhFVGQ1c1FhWlFPczgxOWNZQkpwMmRWUmFDeXN6?=
 =?utf-8?B?K2JlOWhMTWpqSlRzdERCdjVLeGtiYXpBS29XU04zSU9tbGdHcFYxRFVtVE5S?=
 =?utf-8?B?QXVXa2RRV21lYkVja2lqc29JUWdmbUNEVFlVQm9WNEtTM3BOc05xMjB4dHhL?=
 =?utf-8?B?dFRuQ21GMGNrRXp0SlQ2bmJtTGxmTDZ3NDhMSkJOM2dqL1pFaEJBTkttTVNS?=
 =?utf-8?B?bkZpemFaZHFkeHN2Yi80YURFU3kvUWRlYmM5VGdmVG5McWkwRjgreUk1V3Vr?=
 =?utf-8?B?UHpwVTJpZ0pZTWtBdzhMalpRQ2RXd2dnN3dyUElZL01KbGYxYXRmdzhnNTBX?=
 =?utf-8?B?aXE0Y3YvVXBGdkQ1UjVxKzg5N2lwQjRRVmE2WFpTUUJlTzFkalRKM1NSY1pB?=
 =?utf-8?Q?DMLDZK93H17Uf8uEGb+zxSczpHw9hetEP6aRADTMqNWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWVFMFlmTUlLbVZTcEIxVnB6R0FCanF6K3o0Y1lJd3ZYTjNNTWNRdEF1RTM4?=
 =?utf-8?B?UnNSd0F4N2VvVEV6UEhKUXU5cUxoUFBFSHZuRUU0ZHY0Rk43T0NwaDd2MnNR?=
 =?utf-8?B?N0J0eWp3OGhHTmQ1M1V2OHZJVW1RZWJuUUoza1B6ZVJzdmhlT1J6c3RSWlBS?=
 =?utf-8?B?aEQ0aC9UYmVWU3FDZDNQcXBBbUMyZ3h6VEtjMnc1dVd3M2pzOUFKUjZjMVhi?=
 =?utf-8?B?MVpUOXVQeHRTcVZCRll0UDNvZGFhbHUyUVhmYW5CKzVyOEhmSGs4MVVBR0dX?=
 =?utf-8?B?OUp0TkFHYUJsU1V3bXZ0OXBrbXczSnl0ZUNBRDlZeTE4ZHZSa3ZRL1RqOXRv?=
 =?utf-8?B?R3BlOHV4ZStPVUJMcm0rQUFTZjk4b291UnVyYVNGVFRueTk2TXp3a1pqWjNq?=
 =?utf-8?B?YTRNYVJJUCtEU2pYYjhPb0FXN1d2TlVSSEdZUWR4UTBKT0VEVzdOaDlwRGVV?=
 =?utf-8?B?bXlxOTh2WVJ2NFhrbFNwWUcvclFKMUpoRll1elNiWk9rZkVQYmJIbDduK05U?=
 =?utf-8?B?d1lENFZ2dEo5OTJiNDlteWtOMEY4cjRHUTE2d0ViWElKZER6T2VyU1BXOGRI?=
 =?utf-8?B?QkdKZkJnWEhCWkRGTkk0enZReVUxdHozaHRiam9MQ05pSEZaR2lYdlA5cG1j?=
 =?utf-8?B?UmI5YkxVTmFXV1VpcXkrcWt5SG5Lb3YyRFFNMzVBcTFHd21WdlBGczAwNUxm?=
 =?utf-8?B?SWE5Z2tLVmJBaXFHZ0p6YjNqNVltWEZnWXdxZExESTZSSnM4VytaQjA4anov?=
 =?utf-8?B?ck9MWWtrNDhQS0k0L2JvYlFDOHd3V1MzSEphakJxeTRVN1hCeldMZVBYSyt4?=
 =?utf-8?B?SW84OUdWZnpiL0tlcHN0Yi8vQnpNaWg2NFIvL2VmQkJZTlErUUFVYldvTnRY?=
 =?utf-8?B?Sm85MytJMm5RM0N4K3duaFFvaVBzU3hiakl5MGVDZUpNL1ZMb0doSmIyWDc5?=
 =?utf-8?B?SHhGaUxzVXFyeFlQK3g4WDBhZUNNUVE1MDRka3l3REsrMlRoSG9pNGEwVHlq?=
 =?utf-8?B?ZGpvQ1FiRFhRR2dQTmtvcFNaWENLaDh5d1pjQUgrcDJJdTJaWllyVFZ2eVpv?=
 =?utf-8?B?R3I4SjZMcXNhYUt2OEN4RnNhTGpiOTQ2SFVXRDBEUUhJWnplc0MxL1B1a0da?=
 =?utf-8?B?ZzlpaUlRYmJXNHNjdndrWnpOU1ZvYUtmRkNoRFpwYnN4eHhXb3FCaSsvTW93?=
 =?utf-8?B?MTA4MFdBWURvRTg2eStCN3dqNE4zOUZCdlpMMkpEaFlhUVZqZjVySUxHbk41?=
 =?utf-8?B?ZDJTVkgvaTJMV1lCY0o1MmJtZy8rQWh6WWxxUjFIK1ZCK0hJZUVMbHNYYklp?=
 =?utf-8?B?UzlhYUc0SDArSStxOWh0bTZ6OFgzaUIvcUhFQloxV2QrTnZvSDhoYWJtU00v?=
 =?utf-8?B?eWlEcVZmdjc1UkllTWJtOUFWRG91SENQWno2N1dod2p0NURzLzdCc2N2dVdP?=
 =?utf-8?B?dkt5RFlOeW8ySG90UXcvYjl4bWxqT1lLMkduUFkydFlLaURhUmtOblVERVh1?=
 =?utf-8?B?OXNnUzVtUFRZRzJPYk1qV0VDUWhjSjJCY0h5TU9JcHNvMWNRWU4vMko0b2V1?=
 =?utf-8?B?Y2NIa213RVAxQWNtcmZwTGdxbnR5ZTdWSkprRzBlczR6L2VEbzgzY3d3N3hs?=
 =?utf-8?B?Y3lUa21qOTN4cGsvU2ZIcVBIM3FWQWtweUltUmZqQVY2OUMzbVB2VFNFMGpG?=
 =?utf-8?B?K3IzanRXbU5LUmthZm9lakdIRy9FVHFNQ1FaeEQ4MHBQS053MlZ0ZGR2dFFI?=
 =?utf-8?B?UVlyZyswN1VWaG1nMlZmMjZRSU1lM0I1WE9iNU8ydktDcmMxby8rTUFjVGt1?=
 =?utf-8?B?ckE0M3ovUnN0WVFubGRwVTViVXVJZmtkYlJlQndnMXl6b3Nubmt1RWEzcnZq?=
 =?utf-8?B?azBrSjIwWVdNWWFPOGJVMGpQUXNYY3RLb01iZ2ZMbXlwQzBNOEdkQ3FCbTJk?=
 =?utf-8?B?Q1NwWjZkR2s3c1lVNjkxWDAyZ2lnVWF0SHd4N3Q4RVMrTlVPZ1FZQ2phRDcx?=
 =?utf-8?B?ZmpjcmMySUdTU3duT2NCdFR2VmNlKzQ0ZFBqTFhPdnVWRHlaVER6YkF2QUNU?=
 =?utf-8?B?VHV4QnNicFk4S1JobnlyS05BRUVEWkJzUmlmZ01HYkFCM2J1dXFNNmF2TDFa?=
 =?utf-8?Q?je0flopw3WstqnmVq8Hpjyytn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49ce3eb-6c7a-4d31-45f7-08dc7b2482d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:33:12.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0svk9PnLWGM86xIBS/eWFrdKYSIg85kEXGykCaZULHNjvgaJX4pOVqWMfooJmgBQjU6AaK8rds34zLD5iAkxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10884


On 5/22/24 21:36, Conor Dooley wrote:
> I noticed that the 2024 dt-bindings gsoc wiki suggests using the wrong
> dual license for bindings:
> https://wiki.linuxfoundation.org/gsoc/2024-gsoc-device-tree-bindings#proposal_1convert_device_tree_bindings_to_dt_schema
>
> The correct dual license is "GPL-2.0-only OR BSD-2-Clause", not
> BSD-3-Clause.


Thanks for pointing this out, Conor! Fixed now!


