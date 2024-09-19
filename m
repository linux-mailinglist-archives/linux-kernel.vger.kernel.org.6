Return-Path: <linux-kernel+bounces-333159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94BC97C4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6301F2291F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35409191F9B;
	Thu, 19 Sep 2024 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="fEXgH+hf"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2132.outbound.protection.outlook.com [40.107.117.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66B1F16B;
	Thu, 19 Sep 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730027; cv=fail; b=s4XlWUqfAkVQmJMMJxc51QJddVj1oZt/+o9mxDPUA/H6Ha8OFQDTti4w+sIEU8sHntWntmFFUWqJHgwAK4AI7fygfUCQQ8SnS8bH/7mRzPcKb6l6uTnyIF0FnoRjJ4TG7gZt3TkbCMc69irTE7zwpBankV5MhtpA57Ulr/wlEF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730027; c=relaxed/simple;
	bh=5F4Uopn8KYtGE0UmRIC1qncyyHbVD+T/8nbrrq9rEOA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m7Bzk3BIjJHlxzDRMPc/X2uRQNWQ/TNNeAcMaMcAnda8nYE52MTAxc0kFLKX3JKVHj5ZRzNkifRRSoY5o/7rqeTxOlvCSYI9ZxgiCGvchWSLB1JQnD73g9T+ayKiVZ2eTCChiiGFRYTnnFI14puNV4YkUW7gR0HNBmVZsSv2Pa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=fEXgH+hf; arc=fail smtp.client-ip=40.107.117.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olVmQfYXGK12YrlNtYeY4+plu4qDdZOKcEqOEEiJlAJQLHU8qJVNojBcJaKTACPCaJNaN2oYM7N0toTvgZY2fqLdY75/DGbbVIFsoYxZ55m7VHjDH+IyEPL2NihRERARZa7SNAFOy2tFOetEVrcVrh/5Zo9W7ycTNrKr1LGz60qLUZ2W46JG4cBecveQxIL819oCL12YVSVedU3aV9fPS+MQzKsTaf+FfkrVZHI3duFFcmxgFHL2lHq+MgowaScPBDgUOoMVkALjiKf+0uONa4xV8YgLuHD79WQ4XVLQELce4h2nkEPaVF8rxi3hfVmagB1Xje9qFkphMpFx8E1ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F4Uopn8KYtGE0UmRIC1qncyyHbVD+T/8nbrrq9rEOA=;
 b=NkHPZRd8F5kat0n5UvPHY6aW4joJMBoxXMc1IqzmLxP0ge4LUWxO4E32kYlAyvSK4MkKLpQ3Z7MYBfUPQIw/5PSdYOJXymzQP1TmmcCLeWpJjbyJ6AawmToWzl7uhQGuFGCRax7XlXrqPu+A7TAckoaevvQWpIptSkrQPGGwF2iVwFqTtdSuPG1+Jp7IkbV3N/mD/yv8EspdexRMbscmUnrsz7v8udq0G0eL2GsVRIggu2dhLZze+tVRexDeGIfIQIG2MQtf8VkzDZkh7EDR9SgaDMiFeGgpBvSrvn5c5OUYZXIEDgcs3uLv3x4rLhrIZIkc6YnEHf9w/e5rRLZmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F4Uopn8KYtGE0UmRIC1qncyyHbVD+T/8nbrrq9rEOA=;
 b=fEXgH+hfb4rKR5Kz+tj15cKi/fUaQcj07CgwcvLpEhXApX9gmhpiEau5bEJ88vs/0VpRSTa6wSj0u2jehX9qPJITCiNlQ1tspcISsBJhXQeuDgBjJYaxfa8i26tlkyLzRbci2WqNb+ntMLyF8YaUp9oU00zHVpwnplm62HE246qdtd+Pb0PPdGZ5GH8nykCiqZev62RAxio1lDc7c0Yzb5Y5B+WCIciftw6KHFFJRuYakjTQqNifts8GK8JSTQgc4X9ocKt+1VyVb2QPP5uY78Q+f3MPW7TfWDD73oYV9h8n3gZi4CCkFTeAs5QThHx6JUfa1fmbQE7+THDHsZ5/3w==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by OSQPR06MB7202.apcprd06.prod.outlook.com (2603:1096:604:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 07:13:28 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 07:13:28 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: aspeed: support for AST2700
Thread-Index: AQHbCBhSCltx7mVaxk6lgtgjWxjd+LJaMKkAgARx6aCAAA+HgIAAA4Bg
Date: Thu, 19 Sep 2024 07:13:28 +0000
Message-ID:
 <OS8PR06MB7541FDB6A74119A160B1A57CF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240916091039.3584505-1-ryan_chen@aspeedtech.com>
 <20240916091039.3584505-2-ryan_chen@aspeedtech.com>
 <9b356379-907c-4112-8e24-1810cfa40ef6@kernel.org>
 <OS8PR06MB75416C23247B7AC64260C0AFF2632@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <f79a48e6-e0ff-453f-98c1-1c5acbe6467d@kernel.org>
In-Reply-To: <f79a48e6-e0ff-453f-98c1-1c5acbe6467d@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|OSQPR06MB7202:EE_
x-ms-office365-filtering-correlation-id: 39926214-2fdd-4079-b712-08dcd87a8f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?dU11SWkvbURaSHR3VkpDRWw2cjhZUHhLQjBQckYzdnYvYVdaRWM0ODBNTkFq?=
 =?utf-8?B?QWJMWmRCWXErTnhBSVNSUTdkSVpjQ28vTHFHZklxaVVHNjEwbmRobXFSZHZs?=
 =?utf-8?B?dWJQUEVWc29BMU1oYS82S0Y2M2RnWVJLcE5kWDM1ZnU4czNTelJKc1UxU3RT?=
 =?utf-8?B?TFBzTDRoa096WUZEWnN0bXhMY0M2OHB4Y0dib05VVWUyWlBWQTJ3b3E2ZWhG?=
 =?utf-8?B?dWtzcExlZ3NsL3UzSTlUZEdVWExJRGI2MlN0eGxaTFNVanBRSlA2MEp4eU9M?=
 =?utf-8?B?ZmMrcGFvMzB6M01LbmNsZmVHb1NIVTFZaWR3K2k2cnVKcVdmblZYN3ZCb3JC?=
 =?utf-8?B?bTc1RERuQjJPYzNUcDlWWEpxN0lkNTMyaVV1SnphQU1Zanppc2lKMUd6YlFD?=
 =?utf-8?B?UjVsVGQvV3UweGhxbDR6NjZ0TEt1TnE2MzFiblZmRmM0Z3krNTBjdTFubWVO?=
 =?utf-8?B?YmdSdXhXaDFKdG9JTWNPck1tY2RwQk1pcGJzSmpIcEMxNGFSSnFBUEZTQXg4?=
 =?utf-8?B?TzhaUHZYTDJUMW8zYUY4c1VLTzRINFRkQ3U0N2hWM09nYWh0eXdjYUtMbEJ6?=
 =?utf-8?B?OHRpMzdWR0JLUGVIczYvb3M5bmkrdllTdTNqYzdjTXJuL3c2cFFoSnBObHFS?=
 =?utf-8?B?ay9mbDJOVkcvdXZYdWxTOThvT016MmtCcS9sWUZaUGxmS2REN3FOdW9LOVR6?=
 =?utf-8?B?dHZVakFDOUUyam9UckRrekJwNmJRQmFSTE9lUUNDQy9rT1prLzgya0M0U2FC?=
 =?utf-8?B?WWlGYUVMU2UyMXYzUDVYZ1BSWllkd2c0Z3VsRTFhZUY2QkhIMEE2SzI3Z3VW?=
 =?utf-8?B?VjFRenE3ZjNEMitsZFJJTTdZTGZ6QitZci9IdkVhNFQwYm14dUZHMVgxYklZ?=
 =?utf-8?B?Y0IzS3dnSnR6SG4xcDBTc1JoeTkyRWNBTGFUZUNRRzhSMDFMb3V5bjM1SzI5?=
 =?utf-8?B?VnBWRnYxbFVvaHZvbWpGNFNxM2xZcEc0RW9sWnJ3OHI2SitTSnU5VFlBcHJm?=
 =?utf-8?B?ZXA4NStyUmt4T2xnZUcxL3U4RHBDY3F5dmYwbzBZQ3ArampMYWJLeUMxNDB0?=
 =?utf-8?B?UkZGV3YrQkVSYStBSkVYTGRYVklEdnlJbDhmSk9SODkxQXNWLysxUlhFdFBS?=
 =?utf-8?B?ZjU5U29YcFBWRllkVTM0ZlBvTnV5RlFsUU5GWnFwL1FwNXBldWRCcXZuMXRi?=
 =?utf-8?B?bFpjTC9PY3VNODg2cEMyamYvUVlnaG9RMFgyZEFNNFI2c3o5MDdITU81WnJM?=
 =?utf-8?B?V1htTUFlUlVZcklwemo2Zlh1aWNqNEpLYmw5Yy9kQ1BRb0Y0UUFHZnkwb0FK?=
 =?utf-8?B?NjYvVFNkc3I2aGgvSzZ1Q2lKeDA1Qit3L1NyK0o4RG8zWWROU21JdVVQNGlK?=
 =?utf-8?B?Z1hqUjBrVks1YmJsclR1VTlyVHZYWWc2c0VwQWtJYTlhYWJzdVNDa0VVQXJT?=
 =?utf-8?B?MmhVa01DNnUyRkZPS3NUdWtVWTRTRjlSMUVWZlNMdUdPN2xrNmFpeFBBQTFW?=
 =?utf-8?B?dHhnRFFVQjg3WkZvdzNueld5Qk9qNVArbEZONHFtVE4rdy9KREtScnBuZG0z?=
 =?utf-8?B?ek0rWlhrclN0cXBId0p6MkJ1US9JcG9nN3UvdTJPTGtSaWZaU3I0RW80aHZ1?=
 =?utf-8?B?alA3ZTNoS0NJRUxQZWtjRGt6MnBUR0J2RkhsWnlCZ1F2WnIwT2JSWk5IbVBP?=
 =?utf-8?B?UU5ObFhVVVExSTgzTzBXOUJaUVZvaGJlRElGaFNsemUyZEFUbHRzVW1nQm5F?=
 =?utf-8?B?R1RBdHVFNTcyclh5Q0FGVW1HSGhwNzBPeHJYT3NVL1o0YldkV2EzSmd1S1No?=
 =?utf-8?B?dlhzekQ3dERCaVlOQ2graWRUS0UvanVGUjY2M2lvb1h4TzlLQkhZeHBncUxW?=
 =?utf-8?B?Vzhva045UG82akpZYmlkdmtTMGQwejhVc0hXSVpXNWQxUnpJeUF4M1VndVBQ?=
 =?utf-8?Q?3SQHVqZNmX8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1RUTVNRSGpqK3g4T0ZwRXpTVk1RMkVNV1B4N2MzR0NjWXZkeElGOHpLd2dG?=
 =?utf-8?B?S1lqMEZ6VndIeGo4UmN3QmNRL09tOU1FTmJhZEVhRHVqSXp6bkh0Zy9aVE00?=
 =?utf-8?B?TmVISlc1eGduaUxhUTFkWTVvajZCUDQrR3J0YkVJL3lBUWQ4M2phRm5RSnRO?=
 =?utf-8?B?MDZQRUdsTzVnYjlrU2doMmVuek1QNjg5UDVJRitpcDlkSllCRmtJWjYyN283?=
 =?utf-8?B?OE90bzlDV2hrcTBwMFZkTzZlSHpDazZkS3MxamQ3TGMrMTdZbGxMRWtSU3R1?=
 =?utf-8?B?aHdkSFNaaUxkVGhRWnRYS0pVc052M2hpVFNUVjhVd0M4bDRxbll5YmEwSnBR?=
 =?utf-8?B?WnpxM2FwN0RXdmxFQXFMbkxzZ1IxMFEzbW5XYVY2eGxFSWw1RmJTUXNyQkRj?=
 =?utf-8?B?UHMrK0FvcXdVL2dLdGF0WlJKcFlhVmc0SmNMWWhpeWVsZmFKSTl0c3krUzUr?=
 =?utf-8?B?T1ZXRjBtSU1zWm01V29IaTJvaFJGMFZOZTZTeFJSaEpMeFNVKytkRHg1cmVL?=
 =?utf-8?B?RnVOeWZtMVZJM0xCUzhVRENpSkpoVE8zcUVlZFROQmlLZDlydElGOTh0QzU2?=
 =?utf-8?B?MGE5clRsZnZ6RmhLT1BOd0RYazVrVjZKck51blExZGtyQ0VHdzRISFh4Y0pu?=
 =?utf-8?B?emZhK0plUEhSU0t4RmlQNWIydk01R3I2bXVaT0xmZkpFamtYTXhMd3BaZ3ZS?=
 =?utf-8?B?bTlhVlNQYWM5a0xtNGZaSjliVGF1SlYxRFNEKzA2WHpwRXZTMmpCcUttaytv?=
 =?utf-8?B?K3ZzdU1yRVNGMlJMaURjMFJaY3o1dEZ1aGt1VVdJajFETmZzNURMMlJNWDQw?=
 =?utf-8?B?ZkcxcUJOM3ZCQnM0cmlqZGw0bGNVQThBdlUxVGdobjlDNVZXMWtabm5ONjBQ?=
 =?utf-8?B?b1hXb01mTjBYYWVsWG5PRGt0T0xMSDIvY0hMTlVFVWJOYmlWZFVhbG8rc3hX?=
 =?utf-8?B?V2JMU1RWQzhjNTlRZ0hZWTl2MDE2Y1RUcE5IczZOVm9PM3ZGcVc3eHVWbUtq?=
 =?utf-8?B?ZjcyZlljRkZMeWdLbEtmOTB2Y1MycU05aytBN2RCYWp5MnJVanE0MVR2Z2R6?=
 =?utf-8?B?NjhXaFlDVjViK3R2RXpRVDgzMnNpN0dSbXJobVo0bWlQT0pEOFB4bmo2M1pj?=
 =?utf-8?B?d0pHOG54SmtoK2JKT0xSMVMyN04yWkZtQjZpUlhwSDFIekk0YTh2TkVGbXFt?=
 =?utf-8?B?TzQ4dXVOVGpKRGNyU29abFFpUW1UVmg3U3d2WkQvcVA3TThSNVZVWW92TUl2?=
 =?utf-8?B?U3FLcm9Gc1puZG90cDdEUGpuR2pmektOb0liUU0weE1Wc1N3VGxMeVZJYWlr?=
 =?utf-8?B?V0RlM0lya0x3VUlyWXpqb2xrM2lsUDczUFA3TFR4ZzhiQ3pyMnZ4RHloY3hj?=
 =?utf-8?B?dWNjRTBOWTliWUFSRUVxVFpoSkxoK0NwbjMzdWVHWEhmWTNBWGpIeEQzTWVW?=
 =?utf-8?B?dWRnbVBJSk5ERDIzQ2IveDdDLzYrRFdJc05qd1djTmRpQUlYMi92T0RqeHpW?=
 =?utf-8?B?S0FXcjBIendxLzg0RE40NW1lM05Da2p6d0xIelZNWjdNYVNHYy9SUXFOWEJv?=
 =?utf-8?B?Mjg3RkpDZmRrZmVyVVVaTk5tc2VJSkN6NmlMd2xNUDJKS0ZyTUd0Y1ZlR3h4?=
 =?utf-8?B?V2tUU0pFeFZDeVhQT2RUdUM0Z3AxVmpPTGR2Uk5mMCtyckpsM1lvZzVUaUtH?=
 =?utf-8?B?Y3hIZEluclpNK1pBOHE5eE96QWd0QUlwR0hnN2J3OG9zNlp2bnVpcW12eWJH?=
 =?utf-8?B?QmxSWWlZWHZIeWZ5QU9jTTM4dnhKMTZ5dEpVd1M4NFNzWkp6TG12ZHFuVVl4?=
 =?utf-8?B?SndYdGI4Y01rOFp4ZUIxdmVBY2NpeGc4cVFiWWZpR3Jjb0lZTXhBRzlBaTlH?=
 =?utf-8?B?SllmMloxeDlEUVFaWTV0dkg3UDIxV08yUjVwZzJsWXJuczZ3L0dEVmxkR1Zn?=
 =?utf-8?B?cEhnczVEaFhidndva05MTVdEb1JNdUxYbWxRUFloWE1zZmJOV0xNSGc5WjQ1?=
 =?utf-8?B?aFZMSkx3bzYycjVEK2tmM1dOVHdqT0tpWDF1NGR4NVYwNHljT1JFTXkzSGFP?=
 =?utf-8?B?U1p3R3JKQStjL3VtQ0dtTVQwQmhkWUNoSEZwZFErU0ZXa3VuakVaOTVYSk4w?=
 =?utf-8?Q?N2mDvjCCu2l3r1kaG7uxMhK2F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39926214-2fdd-4079-b712-08dcd87a8f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 07:13:28.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rkLSr9hFqAaA+odgqxFGebYS8uTIlpCs960fs3tCSLfqBIqhsWRd9QKBUxwp7Wv0t5ihqI/beYQUORhySMEmnTeY46WThugxt9Ks6TBqXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7202

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVkOiBz
dXBwb3J0IGZvciBBU1QyNzAwDQo+IA0KPiBPbiAxOS8wOS8yMDI0IDA4OjA1LCBSeWFuIENoZW4g
d3JvdGU6DQo+ID4+PiBkaWZmIC0tZ2l0DQo+ID4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDJ4MDAtc2N1LnlhbWwNCj4gPj4+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MngwMC1zY3UueWFtbA0KPiA+
Pj4gaW5kZXggODZlZTY5YzBmNDViLi4xMjdhMzU3MDUxY2QgMTAwNjQ0DQo+ID4+PiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZCxhc3QyeDAwLXNjdS55
YW1sDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2Fz
cGVlZCxhc3QyeDAwLXNjdS55YW1sDQo+ID4+PiBAQCAtOSw2ICs5LDggQEAgdGl0bGU6IEFzcGVl
ZCBTeXN0ZW0gQ29udHJvbCBVbml0DQo+ID4+PiAgZGVzY3JpcHRpb246DQo+ID4+PiAgICBUaGUg
QXNwZWVkIFN5c3RlbSBDb250cm9sIFVuaXQgbWFuYWdlcyB0aGUgZ2xvYmFsIGJlaGF2aW91ciBv
Zg0KPiA+Pj4gdGhlDQo+ID4+IFNvQywNCj4gPj4+ICAgIGNvbmZpZ3VyaW5nIGVsZW1lbnRzIHN1
Y2ggYXMgY2xvY2tzLCBwaW5tdXgsIGFuZCByZXNldC4NCj4gPj4+ICsgIEluIEFTVDI3MDAgU09D
IHdoaWNoIGhhcyB0d28gc29jIGNvbm5lY3Rpb24sIGVhY2ggc29jIGhhdmUgaXRzDQo+ID4+PiAr
IG93biBzY3UgIHJlZ2lzdGVyIGNvbnRyb2wsIGFzdDI3MDAtc2N1MCBmb3Igc29jMCwgYXN0Mjcw
MC1zY3UxIGZvcg0KPiBzb2MxLg0KPiA+Pj4NCj4gPj4+ICBtYWludGFpbmVyczoNCj4gPj4+ICAg
IC0gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4gPj4+IEBAIC0yMSw2ICsyMyw4IEBA
IHByb3BlcnRpZXM6DQo+ID4+PiAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI0MDAtc2N1DQo+ID4+
PiAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI1MDAtc2N1DQo+ID4+PiAgICAgICAgICAgIC0gYXNw
ZWVkLGFzdDI2MDAtc2N1DQo+ID4+PiArICAgICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtc2N1MA0K
PiA+Pj4gKyAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLXNjdTENCj4gPj4+ICAgICAgICAtIGNv
bnN0OiBzeXNjb24NCj4gPj4+ICAgICAgICAtIGNvbnN0OiBzaW1wbGUtbWZkDQo+ID4+Pg0KPiA+
Pj4gQEAgLTMwLDEwICszNCwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+Pj4gICAgcmFuZ2VzOiB0cnVl
DQo+ID4+Pg0KPiA+Pj4gICAgJyNhZGRyZXNzLWNlbGxzJzoNCj4gPj4+IC0gICAgY29uc3Q6IDEN
Cj4gPj4+ICsgICAgbWluaW11bTogMQ0KPiA+Pj4gKyAgICBtYXhpbXVtOiAyDQo+ID4+Pg0KPiA+
Pj4gICAgJyNzaXplLWNlbGxzJzoNCj4gPj4+IC0gICAgY29uc3Q6IDENCj4gPj4+ICsgICAgbWlu
aW11bTogMQ0KPiA+Pj4gKyAgICBtYXhpbXVtOiAyDQo+ID4+DQo+ID4+IFdoeSBkbyB0aGUgY2hp
bGRyZW4gaGF2ZSA2NCBiaXQgYWRkcmVzc2luZz8NCj4gPg0KPiA+IEFTVDI3MDAgaXMgNjRiaXQg
YWRkcmVzcywgc28gaXQgYWxzby4NCj4gDQo+IEJ1dCB3aHkgZG8gdGhleSBuZWVkIGl0Pw0KPiAN
ClNvcnJ5LCBJIG1heSBub3QgdW5kZXJzdGFuZCB5b3VyIHBvaW50Lg0KU2luY2UgYWRkcmVzcy1j
ZWxsID0gPDI+LCBEbyB5b3UgbWVhbiBzaXplLWNlbGwgc3RpbGwgMT8NCklmIHllcy4gSSBkbyB0
aGUgZHRzIGNoZWNrIGl0IG5lZWQgc2l6ZS1jZWxscz08Mj4sIHdoZW4gSSBkbyBhZGRyZXNzLWNl
bGxzID0gPDI+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

