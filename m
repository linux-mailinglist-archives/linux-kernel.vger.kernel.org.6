Return-Path: <linux-kernel+bounces-414304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AF9D261C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EBF1F245F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1261D1CC88D;
	Tue, 19 Nov 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gcLK2gyj"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013036.outbound.protection.outlook.com [40.107.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E71384BF;
	Tue, 19 Nov 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020668; cv=fail; b=XOX+QWVXo43FPTATLHFm6uBbxfLvleUNfmhbHXkmIJyM3bEL4rtCMfeQvcOz0dOR0jpwR1ILC56drmkxq8WmTFaupz1d7Q2Ui5AM8sHYaEg7aqQXl2HoNu6ZQSmcc15+TEBnu1hJ2bwQTIKZ/DRsQJlyLux6XrT41G4Ts5Y+bok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020668; c=relaxed/simple;
	bh=o94zKojUnb11p1z8eVL9CQ935/JvoaIK3lv8EXDdFWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIsTUSeBuKKsV09W1yeFScRS8fbnceFqei00QbUcRcrYf6veo+GAS0Cp23gM3vtLBqzV+f65RnR2K9RojyrdbdKoUpDcWrjBpaTI3WJ6Jxf6S1aX4nxffnTkHqXdHdhha2rKBwrK3OsAN48NF0DAaqZlZVmbiEuvl9z5ImNP/iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gcLK2gyj; arc=fail smtp.client-ip=40.107.44.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbqSf5E/zs1H5X/lBFLV7U0FjzTKgL3czxWJAAajG/W2oaf8JGxAiIRh15feADbYpU4xF0OeH5ZNuiRXszOju6dc5ACyBp/HOfNNZduWJaXUZjbsVTcO4jzqNdu1M0FKl2JvmCXPZL3lVa1DvJA63iOADDnApX4G5wp5NocSZ1loMHUZ+d52gAZDCwAI9ZjQ9aZOCeRP785cKUEfeYrbTY8HxQWxNhf2zv/Xn6lGfxi4gFNHg9Csj4BjmAnIRZnxKkABTpnHm1U8gt+uYKml8cA+ZaEeXFtby42eVw+qJBuPJOKEj7+GjHMN8BzfTMzUmVtH6G0Kb+s+r9o/PeJ2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o94zKojUnb11p1z8eVL9CQ935/JvoaIK3lv8EXDdFWE=;
 b=WDn7VhiNkmgAIIMnXab4TaTAIZcpcE7yoTVPuDBib8c6vop5SgalPQvfSPafB/NMFiCyoDE3FRHKkKk8nFHQ4x/nfmY0aPc29/LCQ7RQs/IfqX4jMeWnC5uFwyGG3PmfvbebrMGytKvLiqvXSJDy6jPVVXyAlBw9+7k4JmHi5oik/mxU2GD6Ty8YEVDb1N6tgTRJnkjVoFE/ibUfuKKWuEMKmHpykdgpBS9Js+0QLESj3zG4CKExCDr4QsTxvGEPRDIQDVID6jTx7y/rkK6VJ+vVOTs69sg6wwU4RocDpr5vFYEjHh0sAhWKa3Ee6hQU8CQMlhZrDvgHJmdEfiTJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o94zKojUnb11p1z8eVL9CQ935/JvoaIK3lv8EXDdFWE=;
 b=gcLK2gyjm31z8twe2t8HdgV0BCq7MjdoRZqz9uL2GnO1vAYS5ZByIoS0Y7HXOSP2I4hVC1KgtV8rDX7ta93OL2IAAe/3z/BT4d3NpY8Ov08iWnZU8Sk6Ak2pX90n+kyyJ8zrwKjaQJQ5kuTDyz5Wfx1M/IyYvIHIL9agp2PPUFavJcB7x8Zryc3hGetTRoYEBrZtPU9VRi2p5DHQhmfP5gNy1pkKUlVQmL1lV5E9oIDhME/VzNzsgTD6E84V7IRBhcLUoB0th6NVGjAae0Cf8suokNBERGa1K83HCS5Dww5nRPL8KkbCKe1tCpqfFc7dm8t/WHV/qySUYyT1z6XErQ==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB5165.apcprd06.prod.outlook.com (2603:1096:101:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.10; Tue, 19 Nov
 2024 12:50:53 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8182.011; Tue, 19 Nov 2024
 12:50:53 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Prashanth K <quic_prashk@quicinc.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "quic_jjohnson@quicinc.com"
	<quic_jjohnson@quicinc.com>, "mwalle@kernel.org" <mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHVfc2VyaWFs?=
 =?utf-8?B?OiBGaXggdGhlIGlzc3VlIHRoYXQgZ3Nfc3RhcnRfaW8gY3Jhc2hlZCBkdWUg?=
 =?utf-8?Q?to_accessing_null_pointer?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogRml4IHRo?=
 =?utf-8?B?ZSBpc3N1ZSB0aGF0IGdzX3N0YXJ0X2lvIGNyYXNoZWQgZHVlIHRvIGFjY2Vz?=
 =?utf-8?Q?sing_null_pointer?=
Thread-Index: Ads5Z1bjTgbcKYBiSvSmNoAzjrMY+ABElzwAAADlTkAAANv3gAAAL9PA
Date: Tue, 19 Nov 2024 12:50:53 +0000
Message-ID:
 <TYUPR06MB62179D03E009DA9E0A786C4DD2202@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <f15c5c40-d836-4995-ba7c-ef7470d1772f@quicinc.com>
 <TYUPR06MB62173B558D42E47CD7BCDF7AD2202@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <e0bc3168-ef0e-480d-a794-d7594c9dc7fb@quicinc.com>
In-Reply-To: <e0bc3168-ef0e-480d-a794-d7594c9dc7fb@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB5165:EE_
x-ms-office365-filtering-correlation-id: 59b0c59c-b45d-4d79-a629-08dd0898cd63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVhMOFYzbVNHMHNlSXZaSG95ZmdxNE0yN0s4bmMycDAyWFo5blFLZFNpTEUv?=
 =?utf-8?B?K2dNc3Ixc3RXalFkcGllaFpTdUlDM1BEZ2QyZnZ4RTdSaFJOWEQ1SE0xd3Fu?=
 =?utf-8?B?MzhjMUdHK3JaZFg3MjJCOVJnSUhIQWFCRVVTYWF3dHFxS1J4VUVGa3ZZZXN3?=
 =?utf-8?B?dkRUb0VpUE51eVlTSWJiZEpDN21KODNEelBzR3NEZGVpWWZCclpVekxRSnNh?=
 =?utf-8?B?cXJ6OWR5MVRvNGU1QXRhMDg4WVVRdUJDc3V4aUxvbWRGUHQ2cHA3azlKd2ov?=
 =?utf-8?B?Y3VKWkNJcGtpMGZ2TjdpZE5RS0FzM2VGOUg4di9mNE5rTkxXSlFSSXArTTFm?=
 =?utf-8?B?dGZCWUwzdEE2cjdibEtLMFVkOVV4SjB1QndCNU5hakYzNVRqdVhYNTQ1bkNw?=
 =?utf-8?B?UXZ6dkdVUWhWMXVkOG9jcXd1K0lOWHpmbTVwSlBHTmh3RWh2ZmVLQVVLWGVp?=
 =?utf-8?B?TXJTbnFlWlhObkR3SkNlTlhvV0ZZdzM3REp3NkQ4TU0vWVRWQ2gzcjEzblRw?=
 =?utf-8?B?TzdtSitiSldlRlByTWp4dGYyQ3VMN1NrUjN2U05qbkozYzFzeHpSTjUzdUxC?=
 =?utf-8?B?TCtWbk13c1hmbytpdmRhcEJwR3Q2R2Y4eUVVTERScnFJSDRzRVJSZVRCckVQ?=
 =?utf-8?B?a0k0ZHZXOU9aWlN3Rkk4NUNFUWNYT2t0QUFBbWlVYUdHNjdHNmVJczhFalJM?=
 =?utf-8?B?aUdBYnZOVnVDNGVkQ0MwL3VsN05HMkYyN2IwQlNTbytDVElWdXZXK05UaGpu?=
 =?utf-8?B?OTd2MEdCT3MwbUtYZGF5OEF2L2I2ODA2MG8wN1ZPWEw4QmdGaklVT0s0aVZ0?=
 =?utf-8?B?MVp1WkVKK0lSVTZjZDc4T0FGNlJ0YkVyVGZEaXdneXVlUllmRGdjcFN0TGFM?=
 =?utf-8?B?c2licmlTbzFTUEk3VlRWYWYya2NJKzRDbkFkWUhoVmN0SHFRNDhYcExNdzZh?=
 =?utf-8?B?VWxGcnZ5S3JxV29jbUFMZThvbTNXcUZiYmhQMXVoVFpmbzRmd3BLSk9Mb3k3?=
 =?utf-8?B?ZGNQb2lDTGpKR2ozR3g4RHh6dkNsM1ZOWHR6WG1GZDZobFprZjZqYkJPTHNP?=
 =?utf-8?B?RERiTzhVemJUR05DMkpSRHM0TGdKQ2NtUytqc09UMi9UT21tWnpydHdEdU5E?=
 =?utf-8?B?WFQ2ZWQwdjg3Vk1hdkpHWnFVUG5FRlFIZUNqaXJ0UzgvZjlmVG0xQXNNNTdH?=
 =?utf-8?B?R2Q5UHhFNkZHb0NxM0dGcEZoQzY4T1dESkE2TDVNMWFycy9Za0NPeURSSzRo?=
 =?utf-8?B?RzR2YVdIRmJkN1dMdWVXL0dnRVllalpnU3h1QlZLZ20zTy9FTmdYM0Rjcm12?=
 =?utf-8?B?SEhoaDNYZjRyVnY1dy84eE9WcUdmRUpkWGxHbzlXcjJrM3Q5K3o5K05Xd2p3?=
 =?utf-8?B?bG1qd1pNaFNBdHM1bHdja3lOL21ZUHFMT0ZheWdic3ExQmNDQllCWDFCcURy?=
 =?utf-8?B?THhwQlNSMW1oN3FlbzlPcnJ4bzV4UGFNZnR3YW9iUnNkc3A3Z2RIV1hSK2xv?=
 =?utf-8?B?cHJOK2FFWTZKeGUxUUlXTTVoek5KMVZFcG1TdWY0by8wMmt1bE53d3laNW5y?=
 =?utf-8?B?UWNyRzgxVVdvb3VqSVlMRy82SHJBc0orRS9vL3JXREdSczJYMHpaeTN1Z1E0?=
 =?utf-8?B?My95blNlcEZCb2xLaERWTDg2L1E0bG5idnNHUFlqVWJQOTJ0V3ZQRDg5YU1J?=
 =?utf-8?B?NVEwWXdWTVVJa1R4UDZObm9LeDByMkQ3TW80MDl2eXd4MS96OG9iazJIY2JV?=
 =?utf-8?B?enFSTVBkSkZiZzE1dlNwQW84anQwTHYvTjZENktoRmM5b1RDUkJkOFdKODkv?=
 =?utf-8?Q?65XTOcodkbTbkGCu/VS/7pFYAaxkvoWfHvs+0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2RaUEMrSFFObnlYaURmNUI3V1VtTGxSR3pLR3d5STJXaUZBWUN2K081OElS?=
 =?utf-8?B?c2RpckVWQUFoUHhETjJFMWltQWw2LzluNzlmY2d3bFBPTmxkNVZiTnEyTmp1?=
 =?utf-8?B?ay9MZElnVWdkNVFsQUJ5NlVRM2RjVkRUZmNwVTVHU1FDdUN3cjZMQnhSa2NV?=
 =?utf-8?B?RmtxSHFaRDV2UkZWVThNVFBSQUREWVF4ZDNML3dyZmhtSjdmWHVOeXovNm5F?=
 =?utf-8?B?UlJWWUREL1RldTBNUzlkdDhabWNtamRVRkpyaEtYalFVY3FqTjVNeDM4Mi9z?=
 =?utf-8?B?dGUyb1VVcUpyS0ZFYThqcnEzUVhEM0xPK3I3Kzk2VWh4MktraDdVTCtEdzg1?=
 =?utf-8?B?ZkRqUzhMeXlORzF4MEF5M3c2Q3dkbmlBUlM3UWtYRSthZlpNc2l1NnVwaUI5?=
 =?utf-8?B?bEgrU2NTYmVsTG1FdTJtZjhOOUlmSTRuQzNkb1M4czhUeS9kZy8vSUJjNzI0?=
 =?utf-8?B?QXFPL05yUEZkRVBwTFRGMnNGTDdJWWtjUkUzSVNXT3QzWDJ3di9sckxuZlRL?=
 =?utf-8?B?SFZMK0VKeUl5NW10ZU5vVWZwTExZNEFVbzkyRy91YnZCa2h3b01kMG1YRkxH?=
 =?utf-8?B?MjU0Y2p2cmF5RFh6Q1BBYWlmQVpTc1lDUVFLQUxGVDE4aUFBYjBwQldMc2Qz?=
 =?utf-8?B?M2N0UXhsWHIzaU94RFdacUVBTTJGVTFKNTVFZkRLd0IzcjBMUEh2bVg2aXNy?=
 =?utf-8?B?NjYzTjdEc0R3VWVTa1d0eEVoelduZmZzYUZuUDZXTTFqUjRPVW40WW8wWWd0?=
 =?utf-8?B?aUtHeklSdHVURE0zaVlHRWRQSEYxdFF4S1VOb3FON1ZvU1JuNVcvSldTR2F1?=
 =?utf-8?B?NFZobUg5RGE1ZytpdEJyQkRaS0hBcGpCRnQvNmJOdDhzeDVCYXBWNmhlTXJn?=
 =?utf-8?B?Yll1WkI0UUFiS1RORUJham9IR3FKVUE1enE4cnpIUXdPd1VkSTEvQlRmQjBo?=
 =?utf-8?B?bVZwekMwSUR2VUJmT0VTR1Z6UjlnTFVUd0N0cHl2WW5vb3BmUVFQUUN2ZWt0?=
 =?utf-8?B?OUNZS0M0RnBvTm01YmJ2R1pkOU5oRmVBNTRWV2pCSUZVSWRrL3Z2U0NwendQ?=
 =?utf-8?B?a2dIOTJZM1puVndISTVHV3pZbHRlY0kvUW0wZDlaQi92Z0xaL2J4SjFubUZU?=
 =?utf-8?B?Zm8zYUxRalJaMFhndGo5OVNGNFYycW5leTBYcVlRYW10cDVwRWZCSWxCUVBI?=
 =?utf-8?B?NTl0SHQ4MHRhcDA1d2RrVVlyR0pUNXlneGpEb2xodHlUMHdUTnBvdmJmbXBq?=
 =?utf-8?B?dmtPdFMxUlREQVF3ZEFvU1ZFTjJvbFpXM1BLV0RDTzUxZXlZbGNzck41b0Qx?=
 =?utf-8?B?ZndReXdmWXNudU8vQmFPbk4xTVFYSy9pSkhEZndHZlZzc1c1V3dPRm1PYjRY?=
 =?utf-8?B?OEJMeG0wWnBoQ2tlTDlkRm1ndnZEeTVUdTlxbkJjWVQzOUN6NTFvRVY3S2hD?=
 =?utf-8?B?NEZMc2tkbm9HSmExeTRxYURkOUU0Z013dFRCN3NGcHBUZTUxRC9SS2p3c282?=
 =?utf-8?B?TkRwTTNqYzk4N0pacThOT3pYS3MxWGFTOEx5NlZQd2JsNFNscmk1a2k3bExD?=
 =?utf-8?B?SHVoQXA1V1AwQ0hzaE5jeG52UHNaQkd5Q3c1YlI5L1NONEwwZ2tCcTltYzM1?=
 =?utf-8?B?TFc1a055ZG5sZ3JhMXJ3eURXRVl3Qk9MR0RkVXVHZW5rL3cyeGtXN2ppUzlG?=
 =?utf-8?B?dFhWTzZWWTU1d3VHY2dtSEh1YThScFlHaXFOVXR1ZytTcWl1eFQ4L0FCQ3Iv?=
 =?utf-8?B?cHRpaFFtaFVQcVJQbDVYMW9JdmtvcmJ3RVNGTFhZcUlMVGRtRFhRaHRKUDZj?=
 =?utf-8?B?UDlvTmE0NVQwMWdqNUx6Y3pIVitWK2E4OWlUK0dUV2llRlRUUUFpYU8vdFk4?=
 =?utf-8?B?ZTkzTCtGM1V3Tlh2UE9FT204Sk93ZzVvMTEyUmZrS25GTTFVQ3J6N2l2cm9M?=
 =?utf-8?B?N3cxblJ0S0ttWWoreDA5MzgxWUo3TVdiREoralhtcHpzdVBsV2ppaGViWTZy?=
 =?utf-8?B?OHNoSUtZbnQwVk4yVjRDNE55WitqUWRyVm5vMGxnTkRRcGlXMGdXUlJtZTFX?=
 =?utf-8?B?ZFRLZUQvcnJtWE9GdDI4eDJpeE9XVXpaeGZ5RkVNYWJQclQ0VWtMby8vVWxP?=
 =?utf-8?Q?OfTw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b0c59c-b45d-4d79-a629-08dd0898cd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 12:50:53.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEE+3BuJnXh7X2TXuFVdv0nR3SHumL7hoWNohlQoqcz+ADtxtE8bQz3Jp/3AfRQTFrRai1f0RBiOxHnsa0Y2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5165

SGVsbG8gUHJhc2hhbnRoOg0KDQo+ID4NCj4gPj4+IENvbnNpZGVyaW5nIHRoYXQgaW4gc29tZSBl
eHRyZW1lIGNhc2VzLCB3aGVuIHVfc2VyaWFsIGRyaXZlciBpcw0KPiA+Pj4gYWNjZXNzZWQgYnkg
bXVsdGlwbGUgdGhyZWFkcywgVGhyZWFkIEEgaXMgZXhlY3V0aW5nIHRoZSBvcGVuDQo+ID4+PiBv
cGVyYXRpb24gYW5kIGNhbGxpbmcgdGhlIGdzX29wZW4sIFRocmVhZCBCIGlzIGV4ZWN1dGluZyB0
aGUNCj4gPj4+IGRpc2Nvbm5lY3Qgb3BlcmF0aW9uIGFuZCBjYWxsaW5nIHRoZSBnc2VyaWFsX2Rp
c2Nvbm5lY3QgZnVuY3Rpb24sVGhlDQo+ID4+PiBwb3J0LT5wb3J0X3VzYiBwb2ludGVyIHdpbGwg
YmUgc2V0IHRvIE5VTEwuDQo+ID4+Pg0KPiA+PiBbLi4uXQ0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCAyNQ0KPiA+Pj4gKysrKysrKysr
KysrKysrLS0tLS0tLS0tLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCAxMCBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCj4gPj4+IGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL3Vfc2VyaWFsLmMNCj4gPj4+IGluZGV4IDBhOGMwNWIyNzQ2Yi4uOWFiMmRiZWQ2MGE4
IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFs
LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+
ID4+PiBAQCAtMTI0LDYgKzEyNCw3IEBAIHN0cnVjdCBnc19wb3J0IHsNCj4gPj4+ICAJc3RydWN0
IGtmaWZvCQlwb3J0X3dyaXRlX2J1ZjsNCj4gPj4+ICAJd2FpdF9xdWV1ZV9oZWFkX3QJZHJhaW5f
d2FpdDsJLyogd2FpdCB3aGlsZSB3cml0ZXMgZHJhaW4gKi8NCj4gPj4+ICAJYm9vbCAgICAgICAg
ICAgICAgICAgICAgd3JpdGVfYnVzeTsNCj4gPj4+ICsJYm9vbCAgICAgICAgICAgICAgICAgICAg
cmVhZF9idXN5Ow0KPiA+Pj4gIAl3YWl0X3F1ZXVlX2hlYWRfdAljbG9zZV93YWl0Ow0KPiA+Pj4g
IAlib29sCQkJc3VzcGVuZGVkOwkvKiBwb3J0IHN1c3BlbmRlZCAqLw0KPiA+Pj4gIAlib29sCQkJ
c3RhcnRfZGVsYXllZDsJLyogZGVsYXkgc3RhcnQgd2hlbg0KPiA+PiBzdXNwZW5kZWQgKi8NCj4g
Pj4+IEBAIC0zMzEsOSArMzMyLDExIEBAIF9fYWNxdWlyZXMoJnBvcnQtPnBvcnRfbG9jaykNCj4g
Pj4+ICAJCS8qIGRyb3AgbG9jayB3aGlsZSB3ZSBjYWxsIG91dDsgdGhlIGNvbnRyb2xsZXIgZHJp
dmVyDQo+ID4+PiAgCQkgKiBtYXkgbmVlZCB0byBjYWxsIHVzIGJhY2sgKGUuZy4gZm9yIGRpc2Nv
bm5lY3QpDQo+ID4+PiAgCQkgKi8NCj4gPj4+ICsJCXBvcnQtPnJlYWRfYnVzeSA9IHRydWU7DQo+
ID4+PiAgCQlzcGluX3VubG9jaygmcG9ydC0+cG9ydF9sb2NrKTsNCj4gPj4+ICAJCXN0YXR1cyA9
IHVzYl9lcF9xdWV1ZShvdXQsIHJlcSwgR0ZQX0FUT01JQyk7DQo+ID4+PiAgCQlzcGluX2xvY2so
JnBvcnQtPnBvcnRfbG9jayk7DQo+ID4+PiArCQlwb3J0LT5yZWFkX2J1c3kgPSBmYWxzZTsNCj4g
Pj4+DQo+ID4+PiAgCQlpZiAoc3RhdHVzKSB7DQo+ID4+PiAgCQkJcHJfZGVidWcoIiVzOiAlcyAl
cyBlcnIgJWRcbiIsDQo+ID4+PiBAQCAtMTQxMiwxOSArMTQxNSwyMSBAQCB2b2lkIGdzZXJpYWxf
ZGlzY29ubmVjdChzdHJ1Y3QgZ3NlcmlhbCAqZ3NlcikNCj4gPj4+ICAJLyogdGVsbCB0aGUgVFRZ
IGdsdWUgbm90IHRvIGRvIEkvTyBoZXJlIGFueSBtb3JlICovDQo+ID4+PiAgCXNwaW5fbG9jaygm
cG9ydC0+cG9ydF9sb2NrKTsNCj4gPj4+DQo+ID4+PiAtCWdzX2NvbnNvbGVfZGlzY29ubmVjdChw
b3J0KTsNCj4gPj4+ICsJaWYgKCFwb3J0LT5yZWFkX2J1c3kpIHsNCj4gPj4gc3RhcnRfdHgvcngg
cmVseSBvbiBwb3J0LT5wb3J0X3VzYiBmb3IgcXVldWluZyB0aGUgcmVxdWVzdHMsIGFuZCBpZg0K
PiA+PiBpdHMgbm90IG51bGwgZHVyaW5nIGRpc2Nvbm5lY3QsIHR4L3J4IHdvdWxkIGtlZXAgb24g
cXVldWluZyByZXF1ZXN0cw0KPiA+PiB0byBVREMgZXZlbiBhZnRlciBkaXNjb25uZWN0ICh3aGlj
aCBpcyBub3QgaWRlYWwpLiBIZXJlIGluIHlvdXIgY2FzZSwNCj4gPj4gYWZ0ZXIgcmVhZF9idXN5
IGlzIHNldCwgc3RhcnRfcnggd291bGQgcXVldWUgc29tZXRoaW5nIG91dHNpZGUgb2YNCj4gPj4g
c3BpbmxvY2ssIG1lYW53aGlsZSBkaXNjb25uZWN0IGhhcHBlbnMgYnV0IHBvcnRfdXNiIGlzIHN0
aWxsIHZhbGlkDQo+ID4+IChiZWNhdXNlIHJlYWRfYnVzeSBpcyBzZXQpIGFuZCBzdGFydF9yeCB3
b3VsZCBicmVhayBlYXJseS4gQnV0DQo+ID4+IHN0YXJ0X3R4IGNvdWxkIGNvbnRpbnVlIHF1ZXVp
bmcgaW50byBkaXNjb25uZWN0ZWQgVURDIChpZiAnc3RhcnRlZCcNCj4gPj4gaXMgbm9uLXplcm8s
IHdoaWNoIGNvdWxkIGhhcHBlbiBkdWUgdG8gdGltaW5nKS4gQ2FuJ3QgeW91IHRyeQ0KPiA+PiBz
b21ldGhpbmcgbGlrZSB0aGlzLA0KPiA+Pg0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiA+PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9zZXJpYWwuYw0KPiA+PiBAQCAtNTc5LDkgKzU3OSwxMiBAQCBzdGF0aWMgaW50IGdzX3N0
YXJ0X2lvKHN0cnVjdCBnc19wb3J0ICpwb3J0KQ0KPiA+PiAgICAgICAgICAgICAgICAgICogd2Ug
ZGlkbid0IGluIGdzX3N0YXJ0X3R4KCkgKi8NCj4gPj4gICAgICAgICAgICAgICAgIHR0eV93YWtl
dXAocG9ydC0+cG9ydC50dHkpOw0KPiA+PiAgICAgICAgIH0gZWxzZSB7DQo+ID4+IC0gICAgICAg
ICAgICAgICBnc19mcmVlX3JlcXVlc3RzKGVwLCBoZWFkLCAmcG9ydC0+cmVhZF9hbGxvY2F0ZWQp
Ow0KPiA+PiAtICAgICAgICAgICAgICAgZ3NfZnJlZV9yZXF1ZXN0cyhwb3J0LT5wb3J0X3VzYi0+
aW4sICZwb3J0LT53cml0ZV9wb29sLA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAmcG9y
dC0+d3JpdGVfYWxsb2NhdGVkKTsNCj4gPj4gKyAgICAgICAgICAgICAgIC8qIEZyZWUgcmVxcyBv
bmx5IGlmIHdlIGFyZSBzdGlsbCBjb25uZWN0ZWQgKi8NCj4gPj4gKyAgICAgICAgICAgICAgIGlm
IChwb3J0LT5wb3J0X3VzYikgew0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBnc19mcmVl
X3JlcXVlc3RzKGVwLCBoZWFkLCAmcG9ydC0+cmVhZF9hbGxvY2F0ZWQpOw0KPiA+PiArICAgICAg
ICAgICAgICAgICAgICAgICBnc19mcmVlX3JlcXVlc3RzKHBvcnQtPnBvcnRfdXNiLT5pbiwNCj4g
Pj4gJnBvcnQtPndyaXRlX3Bvb2wsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnBvcnQtPndyaXRlX2FsbG9jYXRlZCk7DQo+ID4+ICsgICAgICAgICAgICAgICB9DQo+ID4+
ICAgICAgICAgICAgICAgICBzdGF0dXMgPSAtRUlPOw0KPiA+PiAgICAgICAgIH0NCj4gPj4NCj4g
Pj4gVGhpcyB3aWxsIHNraXAgZnJlZWluZyByZXFzIChhbmQgeW91ciBjcmFzaCkgaWYgcG9ydF91
c2IgaXMgbnVsbCBhbmQNCj4gPj4gZnJlZWluZyB3b3VsZCBiZSB0YWtlbiBjYXJlIGJ5IGRpc2Nv
bm5lY3QgY2FsbGJhY2suDQo+ID4+DQo+ID4+DQo+ID4gRmlyc3Qgb2YgYWxsLCB0aGUgcGF0Y2gg
eW91IGdhdmUgY2FuIHNvbHZlIHRoZSBwcm9ibGVtIHdlIGFyZSBjdXJyZW50bHkNCj4gZmFjaW5n
Lg0KPiA+DQo+ID4gV2hlbiB3ZSBmaXJzdCBlbmNvdW50ZXJlZCB0aGlzIHByb2JsZW0sIHdlIGFs
c28gdGhvdWdodCBhYm91dCBhZGRpbmcgYQ0KPiA+IG51bGwgY2hlY2sgb3BlcmF0aW9uIHRvIGRl
YWwgd2l0aCBpdCwgYnV0IHdlIHNhdyB0aGF0IHRoZSBlbnRyeSBvZg0KPiA+IHRoaXMgZnVuY3Rp
b24gKGdzX3N0YXJ0X2lvKSBoYWQgYSBudWxsIGNoZWNrIG9wZXJhdGlvbiBmb3INCj4gPiBwb3J0
LT5wb3J0X3VzYiwgc28gSSBnYXZlIHVwIHRoZSBpZGVhIG9mIOKAi+KAi251bGwgY2hlY2sgZHVy
aW5nIGZyZWVfcmVxIChtYXliZQ0KPiBJIG1hZGUgYSBzaW1wbGUgcHJvYmxlbSBjb21wbGljYXRl
ZCksIGFuZCB0aG91Z2h0IGFib3V0IG9wdGltaXppbmcgaXQgZnJvbQ0KPiB0aGUgc29mdHdhcmUg
bG9naWMsIHNvIHRoYXQgdGhlIHBvcnQtPnBvcnRfdXNiIHBvaW50ZXIgaXMgYWx3YXlzIHZhbGlk
IGJlZm9yZQ0KPiBnc19zdGFydF9pbyBpcyBleGVjdXRlZC4NCj4gPg0KPiANCj4gSWYgaXQgc29s
dmVzIHRoZSBwcm9ibGVtLCBpIGd1ZXNzIHlvdSBjYW4gdXNlIHRoZSBudWxsIHBvaW50ZXIgY2hl
Y2sgYXMgSQ0KPiBzdWdnZXN0ZWQgYW5kIHNlbmQgYSBuZXcgcGF0Y2hzZXQsIHRoZSBjdXJyZW50
IG9uZSB3aWxsIGludHJvZHVjZSBuZXcNCj4gcHJvYmxlbXMuIEtlZXAgdGhlIGlzc3VlIGFuYWx5
c2lzIGFzIGl0IGlzIGluIGNvbW1pdCB0ZXh0IHNpbmNlIGl0cyBkZXNjcmlwdGl2ZQ0KPiBlbm91
Z2ggdG8gdW5kZXJzdGFuZCB0aGUgcHJvYmxlbS4NCg0KT0ssIEknbGwgZG8gYSBzdHJlc3MgdGVz
dCBhbmQgc2VuZCBvdXQgYSBuZXcgcGF0Y2ggbGF0ZXIuDQoNClRoYW5rcw0K

