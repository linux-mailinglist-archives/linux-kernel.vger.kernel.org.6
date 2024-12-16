Return-Path: <linux-kernel+bounces-447404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E39F31BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3617A219D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7194205AAA;
	Mon, 16 Dec 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C7FmkeL/"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011026.outbound.protection.outlook.com [52.101.129.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DA3FD4;
	Mon, 16 Dec 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356427; cv=fail; b=l79dhMB8bfTuE+xT7pYkT2wJxjl46QAfIhuwyApS0U+shJ6Gsl822QV+BJLb83ZUKqIs6Cb+qTzQVWGopc7L8S+CqdF0OYOeAU8uvM5UNvb8xnOz3uyLmGyTx01oaN9Hq6x4mQ23d4iogmIxkjReF+G1pghKdwD51RUSNacBgZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356427; c=relaxed/simple;
	bh=qZvJY+8jchpZU+q89XM5+byU8F9Lt9Y5HaDYtPJTc3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eEnQJxDIHmVQOpzh70MZTwNRKRfhCxuu3eZtVf22oMT41KQREEMP8tPFJOilFPNIEGs/slwwdT3KSwSh2pSO+Tv0oKPjN8X/xFg+CAI1L8keUEI2wYWBAzxEjrreo8a3VXLdNm9emAjNZXyIuNMBYEQuco7BO3/sLp5HbpeRofY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C7FmkeL/; arc=fail smtp.client-ip=52.101.129.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvvdd0q+ASH9gJY5BX2FUccJGQExRBmPbijkwNrFKv0Vs0pHhJ7LEDpYQ9Y+dpR0W3GhoGLlskgBvmTPmI6XlyxWJAfKt2WUxo+cKev2KyPtdhgFZq8RFLaToDEMe8TTvzeB0atO4INA/z7u/r2zpWeoaGamueKO8yUjOGA21ttOhT2q03I9AJo7pBdca84/wxnG6atfrFfAyqqdVLcrDx1AwJG1kP6rK8mRBBWXLQPkqY0sFB2G9q4HN2JJYdbEE+6gFAX1Xoeo2/o8MDU4ZYKWpxpzAhGo8leaqh62kzGo4tlnNTqRiZAzU1xlWJ0WDPoJO1KS5Oigvwem7TYYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZvJY+8jchpZU+q89XM5+byU8F9Lt9Y5HaDYtPJTc3k=;
 b=YiUdO3fWXHXHQnM5yTxxfJc7wZaWskvGuD22/kZoyR39f7BYbNeuA83Qm0/BjCzsgMCvXS/eGvt5pOADjjRimudnjQeJshl14RrtdnsU+42Pc/J8OgiFOytOWYnVzhgzzxPSDU9jG7V9q5zzRQqG/wvGhsPak46DwN1NomUp6154aTFrrI0QhOj/FYKBlR8TDFbnCBdd8KaNkIF5GVHJEK2hbu8VhJM7Kf95Xn956hZGUNuMRsKoaMo3RiaYYxIfPOWe0Aiqy3iigsYHH7zIxllKEiolDVdN18uNb0TcJyXNwsR7VcmfAZKEaZlLm/y81WF9yC0A7rHZKV0ZVTFfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZvJY+8jchpZU+q89XM5+byU8F9Lt9Y5HaDYtPJTc3k=;
 b=C7FmkeL/74+wI1fgl5yDcpDHxWDtRrYDL/pDVZotr5iv1TNQZ9S5f0KfIfqFn57OjrQ1H8TbxGNzOTR3G+29issZ/3mR8UYM3u5+5TWBT9hE0SfZEO5cR28NzkGAFsNo53L7g0UEjzu4gl5E3UFMFr8RjSL80ezLr2uVmaWskSIJ/Dqij9M7xKeDk7ifq5gp+EAbdw931C4Mbi3kS1b0KJYmFD/JFJjyY4BiOjiEMlEHsnZKyn69Qv979selxHOyuz/+amTW+wR11nbi+DL3Xt0Ok5w8H645zS6MyPKq3igJeJ6j8+lMPKx4y8nqIRD2eClywbatZv154KidGYc94Q==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB6059.apcprd06.prod.outlook.com (2603:1096:101:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.10; Mon, 16 Dec
 2024 13:40:19 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%6]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 13:40:19 +0000
From: =?gb2312?B?uvrBrMfa?= <hulianqin@vivo.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Prashanth K <quic_prashk@quicinc.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6IERpc2Fi?=
 =?gb2312?B?bGUgZXAgYmVmb3JlIHNldHRpbmcgcG9ydCB0byBudWxsIHRvIGZpeCB0aGUg?=
 =?gb2312?Q?crash_caused_by_port_being_null?=
Thread-Topic: [PATCH v2] usb: gadget: u_serial: Disable ep before setting port
 to null to fix the crash caused by port being null
Thread-Index: AdtPtYeiqzUBNnqHShOjibIiJOIUEQAAVFQAAAIF3hA=
Date: Mon, 16 Dec 2024 13:40:18 +0000
Message-ID:
 <TYUPR06MB62170825AFE73942D1B10B2DD23B2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB6217DAA095A9863D4B58D57CD23B2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024121649-balancing-appliance-80f0@gregkh>
In-Reply-To: <2024121649-balancing-appliance-80f0@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB6059:EE_
x-ms-office365-filtering-correlation-id: 165277f7-b1d5-4abb-c6e7-08dd1dd72e5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?OWpmM2hVQ0ZQc3VzeWM0d3Z3VW5xb3N0TnUyMTlVRUtCb2YvNkpFak5mUGtl?=
 =?gb2312?B?VzR0NTZXbGhINkdqQ3lNN2xhMkYxckQ1b2NvS2Y5WisxNGFiLzBWU2Q1UEx6?=
 =?gb2312?B?VmMxNW1QUDE0Sm9hQXhsNzJKeitRTUVOZ2V4N1Y5NTBVdXNCZWtOTSswRjdQ?=
 =?gb2312?B?eEFVc001cTErWmJ3NHVGbFZzMTZ6VzZ2Z2s2b2ljdXpUTWNJVG9PdWNtN0Uz?=
 =?gb2312?B?RFRaUE1MNUZyU2tmdTN4VnBTVjNKMjNIajMyWVYvNVpScGtZS2hwL2ExNVZl?=
 =?gb2312?B?cTZBMnV1TnVnRU9CYmRoYmVCdEx1K2xjbW9VQTRuUWgyUTdYaU9ERUwzQXVl?=
 =?gb2312?B?Z2xtM3Z6N2VUZ0lZUUF4N3VqUzR1NUtWVkhJTUgrS1pUdE81RkhoQ21oeEY0?=
 =?gb2312?B?cGtwR0NMSXhkR1VWQ0tFSzZmZWtLLzArb2c1a2d3RUpIUXlKV1pSZUYrRlVy?=
 =?gb2312?B?aTdXa3EyYS80QkdpNm51RVU2UitOZ2luWVlCN2o5RHZlOW1vS3lPRFBQS25K?=
 =?gb2312?B?YnJ2d2NwR0ZBUkwwU28weFFORDVQUHpxYW82RzZkT05aN0xQRXhicm90WDR1?=
 =?gb2312?B?d0Y4R0oycmxuT0xtN3RxV1FtMzdJQkNadXZxeS9RREpZVWRrYXNRNkpyNEh1?=
 =?gb2312?B?d3kzcXloN3l6S3lvNFNuZ1NqelpiWFBYRitmQWJWbmk1c1owT0xZRDlhZ0pj?=
 =?gb2312?B?ckhzOW83bzErZGNBMVlnTm5DZ05uSUZOTTlHVE5QVjBITTAyUTRBc1hYbzJa?=
 =?gb2312?B?SHRTWlBiNEVGL1pCUUl6T0s2dmxzQnBrUC82OSsyemRQZDBFVUorNkNWQ1lj?=
 =?gb2312?B?Q2prSnZiZ1gySG5DZDhPUUl6UGZnU053allUT3JibVZtZDhKakdhK3FkVWZJ?=
 =?gb2312?B?K3g5bFpVSXNDMUprbENJdUF4VkdhdkNVOXNUeUdPNUlxV2toQVNnYXBBMFVG?=
 =?gb2312?B?cGd4MkpjNDdhN0VVNVZiaGk1cXA0YUxuWlV0aTIxV3FBTGl6ZEUyYVNVQ1V6?=
 =?gb2312?B?bWNEYzFTQ21vS214MFR6WS9MZEFkL202OGlsWHp6TC9HT0JzdjV6TTZVbXFM?=
 =?gb2312?B?QzR1V2xpU3B4dExOOVlLZnVTcVB2dVFzVTVzUFdqbWdpVFMwUGRTK1lxeGZq?=
 =?gb2312?B?dTlYZTJJZlVtSFBRZVloZjlra3p4ZFlJWCt0dHZTY0xNcXgxdG9NRXpMRTZl?=
 =?gb2312?B?YmJ2U2NIVU10U0tiRWtRVmoxQUhXTzV3eFZzRGlTeC9DUGxnNTF2dkNQRjlw?=
 =?gb2312?B?bFZiWWROMEhWTGlJbHArY1B4WHpsNGdOWSt5SGFHbVJwNzVjSzdYSHRtS24r?=
 =?gb2312?B?TFpod1dMQytVbXVyVVJQTUw4R0k2YWh0L3B2WVhCNy9EZ0ZhdDhDQ2VyaUR5?=
 =?gb2312?B?eXVCTlBZaElXOGwrV1djQWsrTXNkVmRyL1ZXSU9HaXJpTFVIK1doT2Jzczhp?=
 =?gb2312?B?TzI0bHQ1c3pHL2huaXV3YmRaUmJKVUFHVVBSREVZVTIvUnZZSGhHWE9JcFBJ?=
 =?gb2312?B?WGwwM0ppY2ZHL3Y4Ynpja2NYbEtXejNvcmIwVEprNVduaGJLOXZaanJpZkdv?=
 =?gb2312?B?TTBQVEl1Si84ekdVTnh5WW9xU0VXUkNUdVI1VXR2UG1qNS9lNWVISHg2angr?=
 =?gb2312?B?U1BiQ0NERllHaEhDT01pQ3lSMFkvcGpHa3hudzR1YmFPd1U5dHU0aEtCSVpX?=
 =?gb2312?B?cEZRRzBMSDZPUWxJb2RHaHhjdnJoWTR4TUlmRU10dVZ3UDNmTzA2UzdJcmNk?=
 =?gb2312?B?aS9WU0ZqWnFHajNoVUJjLzV4Ynk4ODBQeENUbHZZb0VxbmdWSWtVbkRNS2xX?=
 =?gb2312?B?YUtYRXE2UnVtbmVieTN2YUYxU1Z6SHpndDlObEFZS2tuckJQSmVuelFvenRG?=
 =?gb2312?B?MDVHaXpiQVcxOFJRTU9Yc0MrRGJ0N3dHR3Z0NHpzdDVhdmwwbjRjd0htUzJr?=
 =?gb2312?Q?iWuPYJujPXY1R5tmIXhgIrpfsTP7zfyg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Y0lGdzZ6Rlphc2cxZVF4N053RElnV1d4SElkdllTM2orUkI3a1hMSFQ5a3lt?=
 =?gb2312?B?c3puU01ETjRYODA0ejEzczF2aG9MRTJMRG9lSGZuNjg4U1JRNzB3N2NqQkND?=
 =?gb2312?B?ZXErTnZGTEJ5a0x4YURMbnFQSW85MGZlNzlYTUt6dS85dkc0ZGczMDhKUlhu?=
 =?gb2312?B?WU0zcGZFNjhlckJEZG5Ka29mZEc0cURKa0hLT0JBQkZ3d2Nlc2RzTFp0T1dn?=
 =?gb2312?B?cVRwd3dBYmt3Slk2RHlycmJoY0xQa1NwTlJ4LzgwUG9SaURIMExIR1VEa0ZG?=
 =?gb2312?B?ekVqeHlhV3VmVTUyRjdiRk9xL2JBRXkvUHhxazFsWDh5cHpiYlhxQllxT2tD?=
 =?gb2312?B?eGdBVFNoV1NCRUx2d2RYbVNvQzRhUUJGZ3FKVGpPaWViVTZlY2hzdWFZN1ps?=
 =?gb2312?B?M2J1akx1bjZGbE9Sai8vNmxFOS8zOTdvZVozVjVvOFBiWnFxY3VxMnNvVUpC?=
 =?gb2312?B?TWtaMkZycXZaZTNERVdNVWV1UThWNXNpanhiV0dMZ0pMdTZtenoxMVpoV1dQ?=
 =?gb2312?B?alhUVGd5Ym5BZVBrSGJPWDVvQ0hqSVBTMGdTTk9DRFZGTi90Wks1SmJ6aWhq?=
 =?gb2312?B?ZGU4ZUZsWDhzRDRVT0RLUlNvK01ja0xFMDM1bmZSOE5tSjRVeERHYWgzMHls?=
 =?gb2312?B?WGVXeTUyMXhYYXpEREJaeGZvRS9LRm9yUFpKNHBQdE5Delg1STluWi9ESUYr?=
 =?gb2312?B?ZTdQNVViSzlHVkg1NXUyUXFYOHNGcnVXeGhhckd3Kzd3aGxFN2JyRWUvSW0x?=
 =?gb2312?B?bEEzdEY2a1ViL0VFcTljR3VNYXk0dkhTNnQvbFhpaWFoN3dwRjNvb09DSFJs?=
 =?gb2312?B?cEdZTDlCL1d4ZjYydW8xNDIrc0ZzNHFDMG40OTRWbDgvMFVZK3BUazdFOVI4?=
 =?gb2312?B?MHAwNHpEWXBMaTBydkRtcTVuSytBTXA1cWVvaUQ2b0ppTk9idU95akFvbWpq?=
 =?gb2312?B?Tm0ySjNzZFRsVDl5dlBzY1Z3MS9PRC8waXFQUE1ZanExaG5GUWFQZit4VUY2?=
 =?gb2312?B?WGczT0dkdVYrSXF1bFBOcVNJa2lKVHdoSC9NbnNRWkR1amhnQ2xPbXRhZUpq?=
 =?gb2312?B?YU9XcVI3RWpOTGFIdnNWUlBTUXdkZ3FBTWRrRlBSSXdmKzdHREpoQVErZ3Ev?=
 =?gb2312?B?SkJ3cXluN1A5K0dkUzZJamdCMnhYYVIwOTFMUVc1dndoRlpxM1JHeEJ1WjVN?=
 =?gb2312?B?dzJXRGxqdWRCNlpsVXp4VGdWb29wQmhWdWZDcDUzbllIUFdtUnBNa3JidDFu?=
 =?gb2312?B?cmdaSnB5VkZUM2MzNlM2QmZvWVZJOFhST2JuUG1YRG9rbWVFSjRqNk5RSU9w?=
 =?gb2312?B?NW1qQnVyT3BBZGdKYXIwdnozcGRGY2ZjVm93MHhTWThTUFJCYmQzcmx1amlq?=
 =?gb2312?B?MmtKdFQzaXMxSWV1OXBtQlJYZm0xRzNrZzY4R1Q0ZjdCbThRZDVQS2VxTWwy?=
 =?gb2312?B?YzZ3ZlUrbXdnbXZPdHhWMGlibVhqNGF6N25uS0g5VXdSWHhjM05wcjRselM2?=
 =?gb2312?B?YnFveERncTd3SUxNVk9xL00waHo3aEd2VlFrWXlWMUhMcFhIRFV4cXFQK2s3?=
 =?gb2312?B?RUhtT0VNZkRCazRaVXEzZ3Biam95dk50RXpybFVaSEhjU0JrVkdjNTIwbnhV?=
 =?gb2312?B?YVFGRTdYc09oWExtSDVrRHBqcVRWLzQ0QnV1c210QVIvNndveTVSRFhHQmtu?=
 =?gb2312?B?azRlazAzcHJWQXpQMi9NRDlNVW9PcnFnNVgzSkpISkhYdTEvUEdEUGZ6ZGJ6?=
 =?gb2312?B?Rzl4OHd5T3ZlTHh5eVNQbzB5ZVNSem0vZlREVVUzdjBtZ3MxN0k0RGgxRTdN?=
 =?gb2312?B?NmlvMUtyYzBSTWw4MEs0dkkzNnhONkNHaGFPY1Qzd0NTUUkrNlE4cFRwWE9z?=
 =?gb2312?B?MHF2czVINWMwb3lTNUlVUzdhTjhMTUlOQ1VLNEJlRVYwQ3M3c3dQNFRkNmR2?=
 =?gb2312?B?YmlaY05YSXVpUXlLQ2RxNVUxUExxZDRLS3N1NnRhdGpJM1hwVkNyTnZvT205?=
 =?gb2312?B?Wm96eGU0NzZITmp5ekozUUhHWE1Bdnp4TWtkd3pKa0JaZ1h2MFo4S2c0b2hR?=
 =?gb2312?B?by9CbnNmclpaajl3TGtBdTNTTSs3LzV6Q1gxazJsWkFtV21heFpKalIwWlV5?=
 =?gb2312?Q?p8Wg=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 165277f7-b1d5-4abb-c6e7-08dd1dd72e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 13:40:18.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qiqa0Jm1tieVntcKonbbItaygECVzpPeDZNuCVyR/rOTwVvUzARn4tKVEYT8rCNw+DzCKxe1iSWMq4GNCcTfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6059

SGVsbG8gIExpbnV4IGtlcm5lbCBleHBlcnQ6DQoNCj4gPiBGcm9tOiBMaWFucWluIEh1IDxodWxp
YW5xaW5Adml2by5jb20+DQo+ID4NCj4gPiBDb25zaWRlcmluZyB0aGF0IGluIHNvbWUgZXh0cmVt
ZSBjYXNlcywgd2hlbiBwZXJmb3JtaW5nIHRoZSB1bmJpbmRpbmcNCj4gPiBvcGVyYXRpb24sIGdz
ZXJpYWxfZGlzY29ubmVjdCBoYXMgY2xlYXJlZCBnc2VyLT5pb3BvcnQsIHdoaWNoIHRyaWdnZXJz
DQo+ID4gZ2FkZ2V0IHJlY29uZmlndXJhdGlvbiwgYW5kIHRoZW4gY2FsbHMgZ3NfcmVhZF9jb21w
bGV0ZSwgcmVzdWx0aW5nIGluDQo+ID4gYWNjZXNzIHRvIGEgbnVsbCBwb2ludGVyLiBUaGVyZWZv
cmUsIGVwIGlzIGRpc2FibGVkIGJlZm9yZQ0KPiA+IGdzZXJpYWxfZGlzY29ubmVjdCBzZXRzIHBv
cnQgdG8gbnVsbCB0byBwcmV2ZW50IHRoaXMgZnJvbSBoYXBwZW5pbmcuDQo+ID4NCj4gPiBDYWxs
IHRyYWNlOg0KPiA+ICBnc19yZWFkX2NvbXBsZXRlKzB4NTgvMHgyNDANCj4gPiAgdXNiX2dhZGdl
dF9naXZlYmFja19yZXF1ZXN0KzB4NDAvMHgxNjANCj4gPiAgZHdjM19yZW1vdmVfcmVxdWVzdHMr
MHgxNzAvMHg0ODQNCj4gPiAgZHdjM19lcDBfb3V0X3N0YXJ0KzB4YjAvMHgxZDQNCj4gPiAgX19k
d2MzX2dhZGdldF9zdGFydCsweDI1Yy8weDcyMA0KPiA+ICBrcmV0cHJvYmVfdHJhbXBvbGluZS5j
ZmlfanQrMHgwLzB4OA0KPiA+ICBrcmV0cHJvYmVfdHJhbXBvbGluZS5jZmlfanQrMHgwLzB4OA0K
PiA+ICB1ZGNfYmluZF90b19kcml2ZXIrMHgxZDgvMHgzMDANCj4gPiAgdXNiX2dhZGdldF9wcm9i
ZV9kcml2ZXIrMHhhOC8weDFkYw0KPiA+ICBnYWRnZXRfZGV2X2Rlc2NfVURDX3N0b3JlKzB4MTNj
LzB4MTg4DQo+ID4gIGNvbmZpZ2ZzX3dyaXRlX2l0ZXIrMHgxNjAvMHgxZjQNCj4gPiAgdmZzX3dy
aXRlKzB4MmQwLzB4NDBjDQo+ID4gIGtzeXNfd3JpdGUrMHg3Yy8weGYwDQo+ID4gIF9fYXJtNjRf
c3lzX3dyaXRlKzB4MjAvMHgzMA0KPiA+ICBpbnZva2Vfc3lzY2FsbCsweDYwLzB4MTUwDQo+ID4g
IGVsMF9zdmNfY29tbW9uKzB4OGMvMHhmOA0KPiA+ICBkb19lbDBfc3ZjKzB4MjgvMHhhMA0KPiA+
ICBlbDBfc3ZjKzB4MjQvMHg4NA0KPiA+DQo+ID4gRml4ZXM6IGMxZGNhNTYyYmU4YSAoInVzYiBn
YWRnZXQ6IHNwbGl0IG91dCBzZXJpYWwgY29yZSIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaWFucWluIEh1IDxodWxp
YW5xaW5Adml2by5jb20+DQo+ID4NCj4gPiB2MjoNCj4gPiAgLSBSZW1vdmUgc29tZSBhZGRyZXNz
IGluZm9ybWF0aW9uIGZyb20gcGF0Y2ggZGVzY3JpcHRpb25zDQo+ID4gIC0gTGluayB0byB2MToN
Cj4gPiBodHRwczovL2FwYzAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsb3JlDQo+ID4gLmtlcm5lbC5vcmclMkZhbGwlMkZUWVVQUjA2TUI2MjE3
NjNBQjgxNTk4OTE2MUY0MDMzQUZEMjc2MiU0MFRZDQo+IFVQUjA2TUINCj4gPiAgLSBMaW5rIHRv
IHN1Z2dlc3Rpb25zOg0KPiA+IGh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRmFsbCUy
RlRZVVBSMDZNQjYyMTdERTI4MDEyRkZFQzVFODA4REQ2NEQyOTYyJTQwVFkNCj4gVVBSMDZNQg0K
PiANCj4gVGhlICJ2MjoiIG5lZWRzIHRvIGdvIGJlbG93IHRoZSAtLS0gbGluZSwgd2hhdCBoYXBw
ZW5lZCB0byB0aGF0Pw0KICAgT0ssIEknbGwgbW9kaWZ5IGl0Lg0KDQo+IEFuZCBubyBuZWVkIHRv
IGhhdmUgYSBibGFuayBsaW5lIGFmdGVyIHRoZSBjYzogc3RhYmxlLCByaWdodD8gIERpZCB5b3Ug
cnVuDQo+IGNoZWNrcGF0Y2gucGwgb24gdGhpcz8NClNvcnJ5LCBJIGRpZG4ndCBjaGVjayBpdCBj
YXJlZnVsbHkgZW5vdWdoLiBJIHdpbGwgbW9kaWZ5IGl0IGFuZCBzZW5kIGEgbmV3IHBhdGNoLg0K
DQpSdW4gY2hlY2twYXRjaC5wbCBiZWZvcmUgc2VuZGluZyB0aGUgcGF0Y2g6DQpyb290QHZpdm8t
NjAwLUc2On4vbGludXhfa2VybmVsL2xpbnV4IyAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAwMDAx
LXVzYi1nYWRnZXQtdV9zZXJpYWwtRGlzYWJsZS1lcC1iZWZvcmUtc2V0dGluZy1wb3J0LXQucGF0
Y2ggDQp0b3RhbDogMCBlcnJvcnMsIDAgd2FybmluZ3MsIDIwIGxpbmVzIGNoZWNrZWQNCg0KVGhh
bmtzDQo=

