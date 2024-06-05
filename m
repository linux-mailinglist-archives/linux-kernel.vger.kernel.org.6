Return-Path: <linux-kernel+bounces-202783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182F8FD101
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8214DB24635
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF182629F;
	Wed,  5 Jun 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="MgnZVIA7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="JtzMo7Et"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6072232A;
	Wed,  5 Jun 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.138
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598492; cv=fail; b=M/0iW6zQj7GCkmmwzq+uf8MHL924Hr3kixxP/raJ8PVhS6AD80Pu2iaQd6yd3dRqOQlpm9G/1Oz8ica8EjozoUug0iwIJWtUhJnqpe6ji59rfzbkbGcE45yJKwYSSFIoPij14Eeopb+GLOyIE6dD+9P/10D0kDTIHhQ49cJStoQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598492; c=relaxed/simple;
	bh=LxsbS/kN/UDMUqM2yYNZyAXBGgHmx396iyZUrxNyeGI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IfUKClGfYuc2dsNGeTXZ9uIKAYwcVWc9KJE45Pz0nvUnh3FlK4FDIwd8KtXuPQL/uw3Rudf3KKphTGu0SMJNBWvCHjZMcgC71G81qpJW/s9o2RiTp0iYhig6UUu6tj21Vg69OjID7aRB9/UGdFQnaafd82xV6qn3iDiRkgQlyMM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=MgnZVIA7; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=JtzMo7Et reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=AbtoLuvNE6Zypw2zcqH27L/5r94tarmGde6VwTjMyf9k2ayDrUgdasaZ+ol1BxpjYXyFOomhzz5O2aN8pqL6RgmwqLEng6QV6U1pPfbDG+HahF0V1b63T1L5r344vDCxx1t4vhmjzkxzuRbt6ric2BaJIKLhSsFMD6BcyUgIgKRhkL+A14RPyqX08o2A5HAKYyDfTkNLKsC1c/ptJPhrXuJ3dhc0OX9Mh1/Lesax+12gIyx2EWNM6j5RZFS7CyuxYoQ2YOP2Ls2JsmiLbdNHTrKpQ7rB1UvtdvtBeUmtQWsMQuCmOEQlWTcxpU+BZwoSsnKvkuc5PCHTwkRmuElCRw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KffSPewvU/v93yPR4H+XcgMgU8d4d2TofxLtxc13uFk=;
 b=R0VE90P3WBYd5jurrKgm11W8HBBRLzSoU29tBzJJz1qnGmG8nHtLA08YQHDraYNlizCvrjwzRC10ptmC+WuCYOhDY1HpaL/SnRF6NY71TRoFYmGYDuJKP2tyq571UF42QAT8i7LXyoG1iziJPSN+B0q13/ux5JW33C23UnpPQ9OgB2nmseEZT4e6RIS/9VVx46dCEen5oaVjBZxbSkGEdZw7rvzegRcsFSp8AqxMcLvbPO95rjxsqp0wWUaKboT8Mvt1RUNMYowbcbBd9Zact2vDZ/tOQ3Pu9FT5grwNaKSIHpqvWnQWiHypdRzOIV5YMPi0GUfZ4zF/3nh3xRxh/A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=synopsys.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KffSPewvU/v93yPR4H+XcgMgU8d4d2TofxLtxc13uFk=;
 b=MgnZVIA70biX9240GNp43OCya2f2AEG3/vUHKmiKOsM/j4JIBiPT+BNUAJb4HOgZw09hEDJjPAGDHNs/MyjJTYVaAadgcL6Y/cuzkJIAs8F+m+vBARfv3PwEbRe8hghPVf/TnXKePbSkb6gi58VEuXO+3Tl/VW2vZQdjo7avSG80vK12h+j2rAHEYAuJeS0GA46tXiqGvEsUJ3CuxsilKUF5tX2WFqeyI3vY54SezcdIpjxqS1OSXCsz9EZK0L6K0w3ek1Zzg+9NroviXn0dO8pGL5WgITxFMlymuSLgURxV7Z4vCPCOUtHoyHvldJpxLjqTnN9YddZ40rdmU+vl9Q==
Received: from DB8PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:10:100::31)
 by DU2PR04MB8743.eurprd04.prod.outlook.com (2603:10a6:10:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 14:41:26 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::be) by DB8PR06CA0018.outlook.office365.com
 (2603:10a6:10:100::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 14:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 14:41:25 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.47) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jun 2024 14:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJY7NG6oq16TlHVGKw9DoqCWFNHX96cNPGP6RsRFJzGrQh2B0R8eFJio4pphCp2G3shICyZzAA/6dnPLvMgYkL/o3NbjnD5QeYV0MemMlstLHU6zj42gRDfMxTJlSiJipUniDVOmx0WckZsf4JjUHIqpHFidoYk24f7G7EOIXBmF0tX+3/trRVvQG+RaCrz5UwKTv0yChpyK0VmdWrIuRkMBeffeQNdxYPQ+W5gnBYmIKtHGXz7ktXRol9tv2qQHcNZiLK9DPFhH+ru7Ai210pTICFQvkD0Rfeg/VbQ3zIz/vo1pTL6Tu8UWQU5F6y6dVUr9OEBXzbIKEptgznmguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNLt7RnHnBoOQPEzhcqJAxT39swVrV+6gsYeuvwiZYU=;
 b=T5MaKzY1NHroeGf3nmOsAOrxopSf5zJSJFR9KH6krxcPADBunBK2X6cQRZv9jJpDD/5pudSYAaLMcwIrv4ASRk+U9pF6RE/xDPuXXnLNixSY/mRWDdzCRkm4Ztb9v0CJf2JqsRezgbXg/+aWilnFvmrqULzmvxY9tmkF9ZDjiGPvZVPiwKx5OsFnpOhsRbkIChvMHojA2awAbu7jGif6DHDjUO8fISbgvgeM41ex8eqNi/FKFz8B6G1VxQOCfmrrn24HyzBFL14lFub7RLaIgkWCosqR2yhncBvl31skj5diNq1XuDkrST+KL3sFxPtyXrFRxt2Sp5EsodSSyBQ8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNLt7RnHnBoOQPEzhcqJAxT39swVrV+6gsYeuvwiZYU=;
 b=JtzMo7EtT2yfxNPlfm0lZhOqS/1LtV1O2136Qehi/HYYWZKf6yyxzrpbEr8vRSvEWeagGtCrCoTBCvoo7qSNJobqBzGgkY21ouKyWLbYIwL8s55K7/SxF1OIL3czovp9aHX2VIB/zr0t/LN+0KNUxkabuI9b+CrUk17BZdzCk4acpb+ow9oVxYK4gdo7rjMyowfb+kkJs18/fjGOCEf+uSIX/DJWvXK56+MDxEJZgy3SL7TLo+3ZclChtkGyfFURfjsg5K83RtTuATG7Fd8ia0G1G8lDmdSZQWZnWUxahT6MPhN+LH4c8Nu3JaaS5mA3yKAuGNycR0IjJ8sOPpIHnQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8528.eurprd04.prod.outlook.com (2603:10a6:102:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 14:41:21 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:41:21 +0000
Message-ID: <23bf65a8-b3b2-459e-bee7-ca7c4e4993de@topic.nl>
Date: Wed, 5 Jun 2024 16:41:21 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
 <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
 <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
 <20240604230624.dk3pssivd7g3qb7p@synopsys.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20240604230624.dk3pssivd7g3qb7p@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8528:EE_|DU2PEPF00028D13:EE_|DU2PR04MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d444a7f-8b99-427c-a9b6-08dc856d9378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WnZxSkFMV21hdEVRMysrMldPejBDYThVRzdZRmRBamgrN1NXR3NGZGlud1R5?=
 =?utf-8?B?TkZ6ZGZaK3YzNTl3cy9KY2xSVG8rUWVkYktLaEtUS3NYTlpCWnNiTDNoSXdZ?=
 =?utf-8?B?c1hUdmRQRTE3di9aVXA4dVM3Nitzai9oZkF3dWNvOE9BdWxTK3ZZVmpmV3dL?=
 =?utf-8?B?c2ZCRVpXZXZ3a3lZM3hwR29RUFZFbTcwaENFVWI0WENDc1hiY04vakFZbVpa?=
 =?utf-8?B?WTRmRkRFdXlkVWY3bEFTNkNCcWpXS21vdXlLOUdkY1V2RTd2YlNuR1I2R2tG?=
 =?utf-8?B?REkxYlQ4Ri9zR1RpRnYrU3FubUYyR0ZZYmFzb2tZdGZCV0VVZWllRWpvUFZO?=
 =?utf-8?B?K0ZDd3ZxYXk2NmNYZll3aENuODUyR29oSWg0SVk5bHZtelkzbzFSZHpnV3RD?=
 =?utf-8?B?blZkRVZzdnV1VityWDRVWURGRmxGeGtrN2tHbFNKZG5YRk44QjRDSHBYY25q?=
 =?utf-8?B?YWFkTTBMOEZtZEJaY2VoRUsyMnpYRXdqK2RFcjJBQ05RV3hwV0lIemZBNnJQ?=
 =?utf-8?B?dU9LbFMranU4aDZHWUlVV2ZhcUgrTXM4YjlJUThZc2Q1bkpDU08vR015emkw?=
 =?utf-8?B?ZDVQMFRLelB4YzJQVXVZVjQxSG4vTWEyQlB4RUs4ZVJqVTJIbXVyQXJ1dUs4?=
 =?utf-8?B?ZkZhZng3aXpZNjlsUXJ0YUgyWGtOaFBSeDZDR2gxUTcyWUk1Z0VDU25XRm56?=
 =?utf-8?B?MWZrcDgxdkFrdENQWk1OYllZbHhhTGhiaXJEa1JCRUpkbmpTb25TbERYczRI?=
 =?utf-8?B?RjZRUnJTNWJhRG5WM2RUK0xpbmVXKzR1MlBaQ3diZEVyT2NGWjVnNEo2OFZC?=
 =?utf-8?B?U3hvSHdudGdQWDdlUTZaQVFQbU9wZmp1ZWZjTFA0emptVmFNVGN1eWl1YlZR?=
 =?utf-8?B?RDI2WTVBcW9HQkd1ZE14Rkd4SUFmdUY1NVNkWHcyQTcrUFpWVFF6elM4RjZ5?=
 =?utf-8?B?Q1Nycm5GMHo4dVQxK2tZRUhGV2Y5MC9DL0xoMHlTQVBMNXNDc2d5UEYvR29a?=
 =?utf-8?B?QmU2dkljU1M4MitnTit1Y09BVEVuQ2t1cWhXR0tQK3l2eTFVSE4rRVI0SnNG?=
 =?utf-8?B?S1hnaHlxMW50aTBualI2VlU1QUlpc3hzMHhpcVVCMUJMY09vQ0VXa1lOcldO?=
 =?utf-8?B?aWw5NS9aSmEyUkR6MEUxNWtCNG9NTFE5WWhYYWhiMkp0Rkp2b1o5d2J6NXZZ?=
 =?utf-8?B?NWxCVVZvTHYxRzNaK1lWbloyYWxhTTcwRk5QMmd2bVlRVkZ5NjhMcTlJbWtF?=
 =?utf-8?B?b0xzUXY1SUR6TS9yL0lXU2VFS3pwcWhHQ01ScnBIa0llTC9BVUdGeFdFSThN?=
 =?utf-8?B?NFZYTGZnSndKTEVXb2JIOW5GZzU5NURNVUJzRlhuWVQ5UW9LUWVhNjNDSWpK?=
 =?utf-8?B?dHNTR3lXeU9WQU5mSVBsSTBnZisxU29HVFpVbjNnTHAvdHdQN1BxN1JwSkV0?=
 =?utf-8?B?WS84OURjOW9qUTlCdys5Z0lOOFhmRmxvU2U4TlJUTzZHUGsxZlpLVk9IVnND?=
 =?utf-8?B?ZVZEM2RZanJucy96VUZobWo3N1FleU1VMFNvQ283TFJiTUZ3TVY5aWNXTWs1?=
 =?utf-8?B?N0J6Z1ozeFlNMDNSVHNseENmMnoyN0Y0WHJlbkVuUWRzRFovQ3h3T1V0c0NE?=
 =?utf-8?B?M1o4UjZDbVEyMGkwMGR6YzlaaHlzbDhESTJLWVo0RVF2czZWOXA1RThmeXFK?=
 =?utf-8?B?NmdaYzJqakwycHRBQ1ZOdXovVExwY2h5RzRPUFUzOHE0dnRrbFRoU1A0akRs?=
 =?utf-8?Q?dO0KMneSicbhHerNnpHdYSOUUq6KGz6Ro6QzOfr?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8528
X-CodeTwo-MessageID: a087a4f7-a4a3-4177-9759-7131ad6103b1.20240605144124@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6240d4fc-b13d-4155-f052-08dc856d9159
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|35042699013|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVEyR0NDaUhHeitmMThZa2lCa1NVT0Q1VW1IbWFXd0xoeW0zY0V3UzhEeE1B?=
 =?utf-8?B?Znh1NUZsSmRrZnY2bEVZRDA0WUJ1UVZkM2F6RFlQVTNsa2NoaUZIT1JUUm1P?=
 =?utf-8?B?dEMwT2g4RTg2UnRGaXlIVXZxL0hLb3ZJVmd3L3BxWWhpQzJYS1gyMkVWcTU1?=
 =?utf-8?B?VG5FNVd4YmdqOGcwTFFLUmMxQXBjeGcyVzRPQkx4NVZNby90ZmIxNXlRNXMz?=
 =?utf-8?B?bGpRL01iQUcwTHcySlN2ZDZoaGwvNFdTUzk0ZU1WR1l0ekFpSmg5RnRvcFhD?=
 =?utf-8?B?NlBOdmg2anRjNE4xeDlzLzVOd1VPY0RCcXZHRHB6RkpKVkROZTE1ZGM0cXRW?=
 =?utf-8?B?S0hLMkt1dHVOcHY3NjZCaHVhYTBmTnhyVXNyTDlHOHd3Z2ZQNnFRbmJaNkk0?=
 =?utf-8?B?SkxvNXF1KzFtWUZJa1R0cXFib2lQNk1QNDZUekZmRytZdllIdStwM3dJTUlj?=
 =?utf-8?B?cUtJdm5jMU1pakc0c3pMaTAzbUMrMjR2RWU1UkVTSW00bWFEamwzZ2tXZUZF?=
 =?utf-8?B?WWE3UUlzZ08xcjBRazc2ZDdSM04xVi95WlQ0Uy9Mc05FdS9JbFhPY05oRTNp?=
 =?utf-8?B?V2NCaXJMNG1LckRtL1RieDg1NmxIRDR1cUduYTUvK0kyajBRRXdIbXR3MEQw?=
 =?utf-8?B?M2pnbW05YjluNkpFa0VpZjRadXQ2Q0JzS2RTMVpPbjhkaWppWkp5RHlWNTJK?=
 =?utf-8?B?RGJyRVdqdkVLcHUrMjE1akxFRVhZYzNOV3huSHhlNGluOVNzWnlUM1QrS1hQ?=
 =?utf-8?B?bjdpdnZVaFNnVjB3LzZoOGRYSHFWeUJKeVJMWFNDVzNtaWlyN0NnVFpJeEE0?=
 =?utf-8?B?MzY2c2gwOUk0S0NDNll2eW5CRTJmcnVKMkd5cldrMllWanlCZURtSUlwOE8r?=
 =?utf-8?B?REJHTTNoWkNEOFcxcDZvRmk3KzBwdmZIMDhra2IwMUVNeVRzNGlKVzlEbUQy?=
 =?utf-8?B?RjhPN0t2QVNGcnM0eU5xUHlqT21LSFFUKzRRN2tuUGREM1lxSVkwL1hsYUZI?=
 =?utf-8?B?Q2ZCb0ZhWTUxRThWVXpqVXN2VDhrZXY4VW1iNFMzVDdseHpVcHBXWlFTMUpO?=
 =?utf-8?B?d3h1T205Y3RGVFdtQ3hBVEFVZFREY1paTTh0UVBMUmN0Y1JBbkVzOGxNL1Zq?=
 =?utf-8?B?SGhXNHk4Vk1RQ05DSkg5Y25nMFFYcjgybitSeDkwejBOUDE4aFNXRXd3N1NQ?=
 =?utf-8?B?TGJtcEdSa2FEakoxc2pOTEplazZWMlJabkxKdnVXMDN5Qmh5L3VoZ2U3R2FT?=
 =?utf-8?B?OU5iM01jVUtyZ0VDQS91dVloUVp0Z2Q4cnJmK2FTZmhvMllqbU1qYzAzQzl6?=
 =?utf-8?B?Z2VPUnArNzF0aEFBdVdWcHdaNjBIekVPTUZyWTUyYUs5UUMzWXVaRGFCaDNB?=
 =?utf-8?B?alozdVkrdi9QRjQxRllTVnQxNUVzaFA4Uk1LTTBmMDhCeXlnMFk1ODRNeXc1?=
 =?utf-8?B?SUxRN2I2RHE0Q2lGM2djbTV0dW05MEMyaFAzUWh3WTVHQ05WTTdBTGY5d2NT?=
 =?utf-8?B?RElFNEJYTGtDSmZmeFd2SXJCL3MyUHo3YjVwMkZPeFpDQk1vclIvWkxXTHFS?=
 =?utf-8?B?dW1jVkh1OCtwMCtQTG5WUFN6K3llMmE1MHNocnhWL3UvZndlSytlV0ZmRjEz?=
 =?utf-8?B?alBpM25sQldGT3pNMWdkMlNOam44OEtVZTJmTnFVdm1Uc1lEN1gzZmVpZUFw?=
 =?utf-8?B?QjJuelJjV2tndW9GMGVEalYwRjNRZ0o4SllNL3hRb2dGMFRnbnlpbFdOdDlE?=
 =?utf-8?Q?ACpTMNYEQA3x4INYRMwfItXzDoQm3rbbYuyBnft?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(35042699013)(82310400017)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:41:25.0918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d444a7f-8b99-427c-a9b6-08dc856d9378
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8743

On 05-06-2024 01:06, Thinh Nguyen wrote:
> Hi,
>
> On Tue, Jun 04, 2024, Mike Looijmans wrote:
>> On 04-06-2024 03:03, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Mon, Jun 03, 2024, Mike Looijmans wrote:
>>>> When disconnecting the USB cable on an LS1028 device, nothing happens
>>>> in userspace, which keeps thinking everything is still up and running.
>>>> Turns out that the DWC3 controller only sends DWC3_DEVICE_EVENT_SUSPEN=
D
>>>> in that case, and not a DWC3_DEVICE_EVENT_DISCONNECT as one would
>>>> expect. As a result, sysfs attribute "state" remains "configured"
>>>> until something resets it.
>>>>
>>>> Forward the "suspended" state to sysfs, so that the "state" at least
>>>> changes into "suspended" when one removes the cable, and hence also
>>>> matches the gadget's state when really suspended.
>>> On disconnection, did you see disconnect interrupt? If so, it should
>>> transition to USB_STATE_NOATTACHED. This change doesn't seem to directl=
y
>>> address your issue. Can you provide the driver tracepoints?
>> The device doesn't issue a disconnect event, I didn't have tracing enabl=
ed
>> in the kernel but added some dev_info() calls to determine what was goin=
g
>> on. Added this to dwc3_process_event_entry():
>>
>> dev_info(dwc->dev, "event: 0x%x type=3D0x%x", event->raw, event->type.ty=
pe);
>>
>> When disconnecting the cable from the host, I see this:
>>
>> [=C2=A0=C2=A0 50.841411] dwc3 3110000.usb: event: 0x6084 type=3D0x42
>> [=C2=A0=C2=A0 50.841457] dwc3 3110000.usb: event: 0x4086 type=3D0x43
>> [=C2=A0=C2=A0 50.841494] dwc3 3110000.usb: event: 0x6084 type=3D0x42
>> [=C2=A0=C2=A0 50.841534] dwc3 3110000.usb: event: 0x4086 type=3D0x43
>> [=C2=A0=C2=A0 50.841571] dwc3 3110000.usb: event: 0x4086 type=3D0x43
>> [=C2=A0=C2=A0 52.650990] dwc3 3110000.usb: event: 0x30601 type=3D0x0
>>
>> The "0x4086" and "0x6084" messages are endpoint events that occur all th=
e
>> time while connected. The last event is the "suspend" one. After that, t=
otal
>> silence.
>>
>> If you need traces, please point me to a description on how to obtain th=
em.
>>
>>
> Let me know if you run into issues following this instructions to
> capture the tracepoints:
> https://docs.kernel.org/driver-api/usb/dwc3.html#required-information
>
>  From the patch you provided, you only apply the change for the usb
> suspend. But did your device go through system suspend? If that's the
> case, then the dwc3 driver will cause a soft-disconnect. Currently that
> will not prompt a state change. We need the tracepoint to know more
> detail.
>
> Until we have the tracepoints, you can experiment with this test patch.
> If my suspiction is correct, then this may resolve your issue:
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 89fc690fdf34..29dbb889a0e2 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2682,6 +2682,8 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 =
*dwc)
>           */
>          ret =3D dwc3_gadget_run_stop(dwc, false);
>  =20
> +       usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
> +
>          /*
>           * Stop the gadget after controller is halted, so that if needed=
, the
>           * events to update EP0 state can still occur while the run/stop

I tried the patch above, but it doesn't work. Apparently=20
dwc3_gadget_soft_disconnect() doesn't get called when I unplug the cable.

--=20

Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




