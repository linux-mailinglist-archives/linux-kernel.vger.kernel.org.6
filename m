Return-Path: <linux-kernel+bounces-239663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 859699263B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB46B26A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E417C7AA;
	Wed,  3 Jul 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="kBl8Iqq+"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2123.outbound.protection.outlook.com [40.107.22.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67C17C218;
	Wed,  3 Jul 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017834; cv=fail; b=WVoOd18A4xPtCGtNDYhuwPXv3Dmai0lqWAhnDNsttCbD8uXCTzO33NnOnYhU47rlfF5CyTAMkqx56Lndz4eDZmRvCffzvZMhjEN6Pw1pQDd5M3JTzT0BLPvOHGSfnmftn/c9U72ul37IXeb1JpC/uEyMPsrTy0fEndDyDfBQ2Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017834; c=relaxed/simple;
	bh=hZAtZfIOLfCPiyh/Xg5UaYOjeaj0O4mfKYZIcYrPCxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uHmeJcBgx0mbrbmIHJ7tixQt2ynbsgmo/HplsakbSdxHTABYX99hCTFBJ8jdlbMGV7O/9nwXMauboCvQ2c6hN7dT8iBNOAj0+a4Asp0Yw3gko60fDijmVF9JsWKgc5dNHt81vP3aEoI2AhHNYZShnK844KUcfURCpSNHICnqDrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=kBl8Iqq+; arc=fail smtp.client-ip=40.107.22.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzxMfIx74LN2L3b69yR8kC9ecdH7fp+j55+UwhvWGTpxB4fsrVQUQEIjsnw9AKy+moPI/1IETkWDfN1qoBTRBZVIDZB8HP/y9Bb7tHJGcLI+3OFBo/WertndXoOrU5//AIa1fnwV+hIojtt7nP6PXFvtX3AgKVfEf/MYKb9gkwTEiKhhV7uzGfRKBzfc6PcjG15tC8E4U8kZrywgemytcfWSCpva7BGyOebdNHzv/92GqG0V3DxK4COIXZooLeN958qU3JQk0V+Zsf5DUKmFh65YypR0AFXCiNHLsThURvSxnaCKF8rymZx6Cg2S/u4C8+q2Bzfw0amrNDA14vw6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/97HQVulAk5dpmDClxqYm1Yqs1Z87SAhHNpfsztxrI=;
 b=F7Kza68QceDgRcZ9S7WdexRGS/or8D4FhvZzaGhcmpFoa/Fd0aiqyzCYbkWDcQQ3lwYBgztE+/QZEDXcrpu7Bchvm+MGWPu+JqU9TuW4H9AQDbPIZMxUrB1zW+cu2VgpgmIFoMnVB4K3XqSCmzeZAKu5qJVV32r9HUSWqTlSneaL+GjKRdssnxwy4Fkn7cnX16FqOXyYJ57b/JSBo72un/WwuNdFipzgBp+/E5MLFicGg7Sw4/FvhlHu92nYCbeHWXuOUttkYb9C84ayS/y/QvFngQWK8x664OZETraRzZS/IClTxnfzGfwyJBkdJJ4V0a30MQULxCYRds681FUkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/97HQVulAk5dpmDClxqYm1Yqs1Z87SAhHNpfsztxrI=;
 b=kBl8Iqq+wTBq5oeqoDxbzzyP+h3sGwan0+tyqqa9ojwb9TLVs69B8jt4AK0XDu4HkRa4fEh7xasXFE92b7rhVHK+xg6HEGLYFHehAzFUDrdy+lvCGb5+Zn6VmNEw7Oi0RRGTGn61Jx1ntj1WO7Zg6hXGnkqPC7urrbGgfxRvgG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PR3PR04MB7465.eurprd04.prod.outlook.com (2603:10a6:102:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Wed, 3 Jul
 2024 14:43:48 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:43:48 +0000
Message-ID: <e06966ea-882f-4ec9-99ae-b62f59eb0bd3@cherry.de>
Date: Wed, 3 Jul 2024 16:43:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] hwmon: (amc6821) Add support for fan1_target and
 pwm1_enable mode 4
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240701212348.1670617-1-linux@roeck-us.net>
 <20240701212348.1670617-5-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240701212348.1670617-5-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PR3PR04MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aa9cc5-7bea-4f37-a316-08dc9b6e8c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJzdUM3S25Ed3REUEFBQ2dwYUo3bEh6aEk3SWsrZmF1cSt6UWpqbzkvTFJ1?=
 =?utf-8?B?aDl1U2VrVG1zN3FFOTlIK2pQZnBlaDNEN3JwR0NFMzYxeUdCM3BLQTkwbHUz?=
 =?utf-8?B?M0FzVFJ5Vndydi9mZDVDd3czTE9sZHhGOTZUMS82bXJYYTJTdlNpa3BGQjNL?=
 =?utf-8?B?bnRnbExMalQ4emk2MjdldXd6WkFvdmFEYWtGOW1pdHQrV1lVM01INnVoOFRE?=
 =?utf-8?B?T3BXSlhTajlncGxWT3lBWUdGVjFqZExDZVFaNWRuUGg4TXNHa2dLS3lucEdS?=
 =?utf-8?B?NWRzZ3N2ZXdPZFlxZkJ6Y2kvRXdUdEZTeWRWcGJIc2JacXBQaHRLR3FENlZq?=
 =?utf-8?B?OWIyZ1h2aC9maVh4QXBEK25hanpBWXZqdVV6Syt0R2RmbnZwdEJwNmQxT0sx?=
 =?utf-8?B?OGRLMzl1M0xjRllEcnJDU0VzaXJzTFdnbkE1RXBFaTMvcGZVb0VsZDR0Qzc5?=
 =?utf-8?B?S2RGZ3Z3TmRBdENWWHo0bE9ST2k0OFRZWU1FTHpiV0FyWk9pR3JxNlh3RTlJ?=
 =?utf-8?B?YTIzdW9jMDNPUW1TRndteHZJamdObktrSDJ2SUdSbk1DakNEd3BVU0dYN2xw?=
 =?utf-8?B?SWNBTG1ZcDc3em5rcnlIVUJ2cGtVTXV5aUIyT3hsSkZ6TDYzRENpSGgxSWg3?=
 =?utf-8?B?MEVlbnhvTUs0dDhURVBIQlBnSUF6TWpScFMveFdTNTl3YktMSGkyUXVwNGc2?=
 =?utf-8?B?Q3k4aTlLS1hjRkxYZ3luSFhSVGwvS0FpSStPenNEN3JweWVSSlF6VFhscHZO?=
 =?utf-8?B?Y0h3U29jQ2h5VGdPcVc3RG9hbjJvVWlzV3hrTVQ3eTdzRnFIWWNBY3VzV3dp?=
 =?utf-8?B?K1BmWDJQRXdiclE2bUhOcGVYNUIvVGR6K3liUVl1azdWaHNtK0lvaGhEVk1G?=
 =?utf-8?B?UTdZNi84eW1XZVVNbGlNdG9Kbmo1U1hNLzkrWHBCOUtwdzM0N1gzclRKd0g3?=
 =?utf-8?B?MTI0N0RnQVJVV1RtK29EZ2pJMm9tMUJOUWRXcEtQVEFvNXVDZGhmOXhUdkJ1?=
 =?utf-8?B?cjZLQ20xVjF5V3BHZGl0anJTRUN4TlJnKy9la2xPRVN2Z0hkMStEL29aMDlx?=
 =?utf-8?B?OXc1OW1GNTlLZUdidUJtdC9GalJQZG1oUlZ6WldaTTlWZlkrRkVSZ0wydUNr?=
 =?utf-8?B?SEhBRGlIVEFGOFNEZm9tZnloVzA5Y2lRZjBVT29iQzBraCtoZHhkUFFMNnVE?=
 =?utf-8?B?RjdnU1BNanZDbmJFaXJxdjRsVDFOanJoTGdMOFI0L0JZbk5pRE1LSmVDMkhG?=
 =?utf-8?B?dDlici9WdUE1NHBCV1UxZ1M3emtGaHNReno2d0x5d3BRNkYzR1J6UGZnblJS?=
 =?utf-8?B?RUdoS2trVkgxZEx6N0N2UU5VY2o0K2QySk9sa1lYUFloMFFoU1dqcWdkQUtm?=
 =?utf-8?B?djdEVGFqMWU2VVArdnVwZ0hXZjBOUkI4ZVllTlpSWnNBdkUrbGNlWWZSdGUr?=
 =?utf-8?B?L2ZCb0lLS1l3WWVqbyt4dTN2di94OXRpV2pFaUZlZ0wxdERYY3piZmtMNUpB?=
 =?utf-8?B?UGY0K2ZyaVpoMFVmUEIzazE0WStnaUJjNkF2VzJ5L0VUZXlkZEluTU9DT1NN?=
 =?utf-8?B?blBUb0VlSzlIV1J6b0xjb0hoWG1kK0dtTmF0NjFFa0pzYjhYTnhXUHJUTmFn?=
 =?utf-8?B?QytNRU5WSFFURXdud0laV3ZGMkdkRVluV2xVazFza2JYRVMzQWxsb1cxNm13?=
 =?utf-8?B?aHBrYm1VdEw4akR4K09RSXcraXNVRDM4WXgxVkpUTXZnSDg4V2VySXFTSWJB?=
 =?utf-8?B?TmRXOWIrTWUrbTdqaTZ3MmMwTUlVZTNGR3UxR3RBcklmU2NKYUdrblEzeXpv?=
 =?utf-8?B?MGEvTG9LMUNvOWl6OVhNdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGEwVVZsWGVzcU5HUTVSbWkyK2ZTS205UHNjMS9uNE5IWWMyclg0VEZ3cVlQ?=
 =?utf-8?B?WTNLU3VNTUxuQnU5UFB1QmYrRUFubjRBUW54bjdWZU93K2tHaDNibUlGVzdq?=
 =?utf-8?B?TzV1aGx4NjQ0MENnMVE1aUQzVzVLQ0tKb1N0VXFMR2VyaFU3N0RPM2JYSGRQ?=
 =?utf-8?B?TUVzZlkzZVFkTWNCRFF1MW8razhCUEdUV0V1dURtVWl1dGdFOGVSTzRDVmNj?=
 =?utf-8?B?ZjlwcjlPNUJmQ0l1bUpTRHNTc05JdlNFWmdHYXdDN2VlN2RrclUwSEx6TDV2?=
 =?utf-8?B?dXg5NFI2UEorSWoyQldOQVRRY0pBb09WN3lZV2l0cWt3UmRMSnZOK0RtL2x3?=
 =?utf-8?B?M09vS0hESHZwcE5GM01LekVLbHh3Zm9VMFhUU051WVJQWmVQcDQrb2R5d2hN?=
 =?utf-8?B?T0NaYitqNWJwTjYxTG5Ub1FXblZudEZIbmluS0I0MGJNdDR0b2l0aXpuNXF6?=
 =?utf-8?B?Zk04aDFjcEtzRTlRUTh4ZzJiR244MjVqUHQ0NlEwQWs4ZHA0SjlpTFB0ZVhu?=
 =?utf-8?B?d3VqbVBSUGNRZ0wxNFlSTHhIQzJkT21BVkZHb2o5dzhTS1EwWm5wK0VOZkFZ?=
 =?utf-8?B?UGpWSHlnekVOYlJyYmpMaGFwMDVsU01reGlXTDlxd3ZYNk9JYkdaNGpvVVNz?=
 =?utf-8?B?bitjSjJLNWhNdTQzWUYzaUxFUS9pWW15bW1FUlU4WURRVFcwdDZ0SHNMMDRC?=
 =?utf-8?B?ZmJLelZWNWxMbzhzTHlVRlFEVURKektrbk1WUVJpMEdSVHpOMVNVQmp5MTJv?=
 =?utf-8?B?ZnJrUFhiR0NFOFpNQVIwaWVFSk9mUnFrVUZqZnI1aldLRVk3ZWQvRDJiaVNX?=
 =?utf-8?B?L0srWTJDUVJTd2t3bG9yYkdmNGM1TTVpQ1dwcEVKWS9BVERvNlhSTVFYWTVZ?=
 =?utf-8?B?V1ZsUHhod1hhaEtkaUVqV2R0VzhDUzhuN09IdUxsNTZSNXUrcjdDWDFYM3ZJ?=
 =?utf-8?B?SnRiMlRaNXVhZDMxdXVjZmV0KzVhV2xIZCt0SVEwSlZEZWptNGo4a3hpQW81?=
 =?utf-8?B?ZmFrdGFaVzVOWE9qMUl1bFZKRDhPSTFlSGIxeUxUcEgxQnozNkRHd3gyTlM1?=
 =?utf-8?B?UElBOFFJcFE3OGZ2TlNRdGkxVlh3dUV2OWRhVEFCYWsrbU9MYWpoM0lYVUw3?=
 =?utf-8?B?bXh2YmVyK05PTXFaSW9RQTRLQjRCQm9vbEpTYVV1ZHN0YW5DUXM4dGQ5dWxD?=
 =?utf-8?B?ZFdIaE1MR1JTNUtmTlUydUMyMmpDdkdOSkd1d01YZlZYRUJ3UURLRTIzYkZK?=
 =?utf-8?B?V2hLQ2p5ck94dHl0SEszc0wvaFNVOXpKbUswaytNc0VaQkVuRm1USnY5dDE1?=
 =?utf-8?B?UEFIbFNPRU9UclVHZUY1dVZrT0E5ai8vQmRVV3lBVitzeDBPWGdGK0wvZEdv?=
 =?utf-8?B?bHp6d0xJdDlUYXlRWHoxZzcxVkVKQzIwWnE2WUxVVVhxUGFRc3ArbGFWQVNH?=
 =?utf-8?B?YmlMSER0aEZNQ0Y2a1BaRE02am9CWXpOMm1mdVlTUERSaXFzOC9KQTRnU1o3?=
 =?utf-8?B?cU13S1Jja2NFQzlQN08wM040Z2pmRWdoeDJlamY0TCs4R0g1V3o5SHFpam1K?=
 =?utf-8?B?SmxPZ1pTVXlSTTFVY2xiaGNCUmRnR3I5ZmYvY0VicktMaHBSTW5iWmtsdlo4?=
 =?utf-8?B?SWdvenIwRTJZekZ5WU9SQ2hFSVVTWGJ1N0grMGhrZ2hHR2dEYm1pOE1WaHNL?=
 =?utf-8?B?OUtVVW0rbFNGQ2k3ekRGdzZvbi9tWVdqNURmakdBc0JpeVZzM0JOL3lDTE9u?=
 =?utf-8?B?bEtUOGNrNHd4UnpJMlA5UVJ2UVRQNzBqWmlBRk9Ia2xEdGRmTXhCbGkyazJQ?=
 =?utf-8?B?VGROUUdHVllVb0VTS2k1elVDZFIxTHg1RjI0eW91ekJHQU84bGJwa1A2Tytw?=
 =?utf-8?B?NStxOFpBNGh3UVA4WjJZUXkxRmw0ZWpjK1B6OHMwNTBFWmFiSUo2V1VXNk4z?=
 =?utf-8?B?c3dLM3NGSTlhYmkwYldyWkFCNFlaL1RFeTZ5TC9JY09nT0VNRWxoREdVYlYy?=
 =?utf-8?B?V3FpaXpvbnd0THFDUnI2Nno4U1d4emt3OGUxWGVDOXdkczQvYnNudlkzdFZZ?=
 =?utf-8?B?RFdoZ1k5NktVeWVnVzU4cnVkSjcvWE1EQXdaeTBob0tkZGg4bXJTQVFMT3FX?=
 =?utf-8?B?RmVEZ1ppZXFreVJCbnJDb2FsenZ4c2plbUt3ak4rR09xMlpuMjRCZVE0dzRX?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa9cc5-7bea-4f37-a316-08dc9b6e8c83
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:43:48.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI3T8OXrVDYNnIJYVUhWeVeHgaUhu4htaq+A183+2kbmwhuZfhhdY8m5Kdz2yYcw9kbS8nDHDWaVKD2wAkge1idi2tL+eURZHSw8v0pc+vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7465

Hi Guenter,

On 7/1/24 11:23 PM, Guenter Roeck wrote:
> After setting fan1_target and setting pwm1_enable to 4,
> the fan controller tries to achieve the requested fan speed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

