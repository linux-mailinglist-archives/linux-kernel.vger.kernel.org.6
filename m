Return-Path: <linux-kernel+bounces-326116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510139762CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832B81C2231F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714818C929;
	Thu, 12 Sep 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rF8Z8QJZ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8E18BBA5;
	Thu, 12 Sep 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126566; cv=fail; b=EbRGYXfBaP6Fj/EB00B04ZED8Zxvc4aQHtjuLhlqQOA6nhGICQua8r5PGw7y04v+qlZ7KVVvAxoBPJQJUPHeKmn09qtxkVYgUcNVnUn3UlScDi2kAuAdXnHcQ1kb77dho7ZNrJDYhz3NCMeYqIRDcc+RO98iLSw0ZZLb7btceIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126566; c=relaxed/simple;
	bh=z+0nqcj4pqvtfMcUpZL0rSB2ZHXefovr0/b5h7hpfSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MndeOIw5yhDWBbKub0ZcQe2nB6CaO6hX4RAnITDjPmM3jjGlSg3qS5IeNnM8U5n9FqRfvNqd8a+Lf4cVqyGBaWg6Jj857D4w225vFnqTJmo9Yupp+om4SEk0Xjzfg4bTnNaPvgQ1ULhJlReoviXGK8i2igGKOR3Bp05R64uqi3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rF8Z8QJZ; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puU7r8kClpfOQrx8sb4Dp9CeliRawF6n5/Jn7WSWfKoyHsRTEmFOJX6d9dmgWzAXC0l7yUYN+9CWiZ4JtUmOcJBNWF1AtTBbfNpr+1a7kzRKogM7Vv9maioodV9J3X880brEhZ3Qc+jvdf9T+tyorf4ZeFvd3wDi6PoBxSlQG6+z/1hdr/OuXq7f/xa1uhMqlPEIvTJtyqXrnL7so2Xn2zXyKVLKvHa8gtmL9o8+G8Mu2wfobOsKAtfgwRXgGvZ7MLnm/OSVa3w9DwQP9o0FiRz2B0WbYr1GiiibxT9UObxueUeUNiwduLuXM87L3yuv2igUlyCXEUSecBh75qs2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+0nqcj4pqvtfMcUpZL0rSB2ZHXefovr0/b5h7hpfSc=;
 b=AwyS3AHBHb6wCR0wopLxM/TI6c3tcCep7WxvwQlMGL/XL7fwkaEo0ogVHNI8yOFHmiT+17ovZvlNYGlZEfYGG1QOjpeLHlSb8fYxQQZ106bxZ56a1exBtUwCQMpBNaGPopC9XSYyc5Ypi3sx+6OCqSon1pw7oPRyVQAkxfVwrQbQboA8k68cn6nGYesPNOYASz/EdFX2luMxDvgDMed3Ra3onmuEL++hYXVzA072z62va/LYKnjJP6hQe3NvbUVuwOpMn/HGMiYqxhWXcgHJ6tcXdPh/+0vnfxZ8sORyAWq05BHVVasgE3Yn7tW/7jqAF9KCRZzxwTOqzG2ZO9Ty/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+0nqcj4pqvtfMcUpZL0rSB2ZHXefovr0/b5h7hpfSc=;
 b=rF8Z8QJZRkRibGWJd4rnxhA46feBQnTdA6q6afG70FmQH9qLkEKCXgiIW4m0XlXyHFZf59654isSb9jRPROaGx6glFvh3r+6EXim9wPjR4bk0iG0G6ZJZ1ohVqzHkqBItlNPPybSbploOBC53vRC7NzvGHIrzDWJwAwYXnxzH1d972vlOeNU/H5T/9yrZ8Zy8dzC8PnpKk4cGwK963HrEbOuf4QvsUcsCWDI/cOr5f7Zam71CAaQMLwlNQo2jGsrunpnddzEPbZpjBKz3vMHVjOt/PT+BDvRAOlGBYxCaSb/YuwyHjkMdmUESc4h8ThAa58VtX6oELzLxklJrb/HuQ==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 12 Sep
 2024 07:36:01 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%6]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 07:35:57 +0000
From: <Andrei.Simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Add missing property
 atmel,usart-mode
Thread-Topic: [PATCH] ARM: dts: microchip: sam9x60: Add missing property
 atmel,usart-mode
Thread-Index: AQHa/3ZRSb21CzWm2kyzuzG2afEotrJTynQAgAADYgA=
Date: Thu, 12 Sep 2024 07:35:50 +0000
Message-ID: <1b7f2442-8a37-4cf2-a6bf-c05def4948ed@microchip.com>
References: <20240905093046.23428-1-andrei.simion@microchip.com>
 <f1daa78b-43e4-400d-bb50-9cce1b42fd86@tuxon.dev>
In-Reply-To: <f1daa78b-43e4-400d-bb50-9cce1b42fd86@tuxon.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|SN7PR11MB6849:EE_
x-ms-office365-filtering-correlation-id: 5951229f-f11e-4f26-b131-08dcd2fd8aab
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qjg3RzllNGt6SHFRcHZvenQzeWRVV0Y0dVBOZzRZbW5BV2ppMlJ5YVpzbDZB?=
 =?utf-8?B?UW96QURDaGVPd2pHK1ZGODR6Q0x0YkV6dWRIR2JyNkY3aG5oYWwwTlBIck0x?=
 =?utf-8?B?cXBwTUxnWG1xOXc4R0hpUzRmaUgybkRlUldTYS9EdkN2b2NwOEJJV05mT3Ru?=
 =?utf-8?B?SkJ6UGdJZ09hN25wRWVrOUFaV21pQ3ZhSG9TUXdlVm0xZDBOUmVxQVVCdHly?=
 =?utf-8?B?MlJuMUFkRTdQYWI5MjErMmNKR0JGT2R4ekN0MWx0RDVGbnRvVWNmdWJsaEhq?=
 =?utf-8?B?NVNSNGVIZ20vY2p4MUZIc3RoWnlJdjBBSmpBalE3bVAxTXVJN21tMlk0NVh4?=
 =?utf-8?B?VDlXd21uVlJ6NmVvRmhacjNkNG1vUW5wZGtuTG90RSs0Y05kdXkycUZncXVw?=
 =?utf-8?B?RVJ2aUYySmJIUmRBS210QVhvMThNVVJqTktEZWtFWE1yRDdrdjgyQmVUVVVW?=
 =?utf-8?B?QTVWOXZSOEdYMkN2RTNNRFJadFdJby9XYkVZZGtzQXF5OUY3TDBvczJ4dEU5?=
 =?utf-8?B?VC9sOTA5QkduQmtaMXVHK1JWQXRWdDJmZXRYR1RXV0xEK2VyeVVkVzRRc2hH?=
 =?utf-8?B?VnRlRklqU09yTjgwNWJiRU5yNEd1QzNQUDRJZXRtdGx2QTMwRGdYMnZ4TThM?=
 =?utf-8?B?NlZibVhsNE5iUVhtam9MdXFUT3ppK01rWFF4WUJXbXlVSE5hVkNNUHZjWjlh?=
 =?utf-8?B?SzVaVTQrdm1XMjVHcEI0V3lUbEhqOGNUeW85Mnp5cTB3dUtWYWFZZk95a1Zr?=
 =?utf-8?B?cm04N29kY2VuREJxWjZBTURoSGVnRVJYR1JJOXlmQnFrTmtxaDZtdmRVRjN3?=
 =?utf-8?B?M2V2UUdvNUhBMFFSTWtVeFovUDNvOGIxSkZrbHVKdUI0Z09lOFpQaW5JbFRT?=
 =?utf-8?B?V3BJbnRpOGRpTUl3d2hZUHk1NDI3YXNaMi93bW51NmNja0o4WmZTWW9KZW5T?=
 =?utf-8?B?TW5ieE50RW9nWFdhTHoyOElLdWcvVlhOZ2N2eFhZa0xTWk5qeHE0V1NtMmVt?=
 =?utf-8?B?VU1HS0VMWU1sT3hJN0xQOTlNTlZLM05PZnQ2WmhzYkJwbllmYnVXOXZ5cGgy?=
 =?utf-8?B?VmlOTjRJR3AyeFZaZ2VtUnhzWHk4NjZEb0R5U2g2NThGNnpCTXJFNDBJNEhh?=
 =?utf-8?B?WVdPNGxDN3lrR1dLdzJsWkwvelY1emdGdlJXWVEvR2kzOGREMlBuTEJDcDlU?=
 =?utf-8?B?dlA1OFBwTVhPQlN6V050Mk5sTTBYMk9oYUlDVVVUbmZpZVhZY1d5NjN6UjdS?=
 =?utf-8?B?Ni9EQkt5Y01LdnhoMWllT0J4eExPaklJSmphaXpLUzBpY1Rmc2tUSklQcHVN?=
 =?utf-8?B?RUxlYVdzSjFLMmVZb2tiSEQ4N2Y0cGIyUXNJU21wdk93dU41ZVVHY25rWklZ?=
 =?utf-8?B?c2FINDlpa0UvNU5lSHNlZU5vNzcvUS9JOEZYS09yQWpLK1NtdXpIaS8xNzdL?=
 =?utf-8?B?ZGtpK084M3JKQjh2aHFKSmJWLzRPckY0VS9LNHI0ZGs3Rm9nYnBRN3QxRHIr?=
 =?utf-8?B?dlM3bkFhNGdwYW01TG1EaGtjVHgxNG1CdzBDNVBpQTBxdVB5aXE1bmFTSzFq?=
 =?utf-8?B?cUM3WWJzbTh2ZFBlVWtHdFlPd09FaDdRUTBUYXRVMzlVVWpSeGV3ZmkwNVlv?=
 =?utf-8?B?V3hGcXB0QlRHTkdnRVliS2JvT2Z5ZlpyUTJiclRBMFlWU0tialJwU25vbUZ2?=
 =?utf-8?B?d0VtbDQyNnhSOXpxekI5MklnVlJtUVVvTTlvNHQ1NVEyLzJVOXpWdjJOSHgw?=
 =?utf-8?B?SEZNUkRrT2w4ZEp1bUQ0TVZxOGw0dkNOT1o3ZlUybW1lRUhQQzhtMU5vWmJJ?=
 =?utf-8?B?N29YYlYzZDF6bE1OSG8yVFRMUjZ6WDgvcEhKRWxTN1RGMlRnR1JhK3lNYXN0?=
 =?utf-8?B?bWsxU1BiNVp2Slp3VnVQRkpPTkJEZjBZUlIzS1l0dFN6d0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlMxWlZFOSs1NDVWN0s4L1pDNGZIUmxkSnRadzVWSkJRUkdURXhCcGd1WEo5?=
 =?utf-8?B?UGp3ay9VdWY1bUZFNDQwc20ydXVPbXNzTkQzT3ZvZ0ZRY1ZValhHb2VRZHVp?=
 =?utf-8?B?OW1tdDRKSDFGQnFpMXlHMFpKdFh5N3psNmFldkhLbnBsNUdjUmlKNTMrclox?=
 =?utf-8?B?eW1VdGJDelNHdlJPcFhSL2dMVFRXd0VZU0FvN3hFYTl4bEpqU0YvbmRyMlFw?=
 =?utf-8?B?UkhZMHFmN085Y2o1QSswNTRuUVpGRDF0aE45QTY0UGhsZWlJVGVmVXp0bVVs?=
 =?utf-8?B?YVpRZTBUZmlVc05aVlVvQ3NaTzRRZDJZZmp6bkE2b2xJMzlMOWJSa0JzMWtB?=
 =?utf-8?B?aDFlbnF0aVE3aGJOZDdXZDV1TnlCNXVKRDZLVDRXSjJxZXVBeTBkWExycndG?=
 =?utf-8?B?OXF2UlNReHI4eVhGMUR3ZWZaZUI2cFZkWWJLaXI0RkFRd25LUmlyZ2Q4Ymoz?=
 =?utf-8?B?STZ0azRqelVyVkNNdGJ6Z21LZWtLRkFZTTFQcWI4OHkwQkxGOVkxNHp0RXZY?=
 =?utf-8?B?RU5hTW5GUHBGaUJnc0FRMkxRRGdpWm5scWhjVXhSdVFMTkxQOGNwbmNCcTk2?=
 =?utf-8?B?dWh4T21qanFpRkxDSHFjTEprb3ViSllaUWZ0MTlZT3gyTGxoTlBOWktaWGEv?=
 =?utf-8?B?dWVlQ3RiK3VMMkxoMWxQSWEyNXp0d2pIVlNrQ0lsaE5wNWh6eXBROEhPOUxV?=
 =?utf-8?B?WVd2NTVSN25QLzFMNzRjU2xNRzAvSG54ajE0U0hQSWttbUtKOThxbFNyNHpt?=
 =?utf-8?B?OEo0Y2s2ZjJNWnM1TWI1OVBjNUJQY2FYTVk4TEJuU2RtSkIzZVkzcUJqRnk1?=
 =?utf-8?B?VVZ5d1A3dm1MdU1UL2JNRlpva2hSbWVGcy9TOHI3VlVHR3MyT2hxT3NWNHlk?=
 =?utf-8?B?cGZKTXlZbkVUc1hvaklhVmg4MWFKMUxJbWE2OENZTGErRWpCUkkrRzI3cGlj?=
 =?utf-8?B?bm94cEtOaTMvMWlTcmlRdzZidFlsbHhDVU9MZjY4ZkxabXlRQXRkSE1qZHRW?=
 =?utf-8?B?WDE3KzFYbzRlUnkzUEdvNEdzSmtrNC91YVh3WmxoVC95RG43d2pOTkVZc2J4?=
 =?utf-8?B?a3AybHNNK1VQVGlCVTN0RUxmQ0l6d0NIVmlwRnF1WkxhRDJyMzZ0ZTBaVWc0?=
 =?utf-8?B?ekR6SFlwMS83M2gwQjFLcnpOUTNtQXBzYnJEeGkyV3I2czRkcUFZTHhJVnVQ?=
 =?utf-8?B?dCtJVHJBWHB3b1ZteENFZ1Z6RDZPR3BIbkF1UlZtZkhMSURhUitLUmZwNU1N?=
 =?utf-8?B?K09iTFhlQ2VXNjdVTXlHS2Ric1BvNmlqa0VQRllSMWd0aDk5dEdnYVhQQ21p?=
 =?utf-8?B?ejNYRzI4eDFSU0Z2WEJzcGI0YlRtYm8wSnlGN0VORGZ4QjVnVzhJUTZBdktQ?=
 =?utf-8?B?anhIajNESHphTzc2bkhJbGplRUNwYkR5WCtlYjhLYnU2eVBqTERlNkZKLzFh?=
 =?utf-8?B?cC81WnB0c3hjYkVsTnRLZ1BNZG1uNktnb2FSZzBzMFdhODdURjdLVTg1akM1?=
 =?utf-8?B?L1k1U09oTExjeURYeDNtTkU4QUwyZ0pCL0M5THIyVXdBcjVPdHhNSlV1WDdm?=
 =?utf-8?B?V2ZCOFk4SkZ3NjhQZ1ZycXRkUjR2ZDAxYUxRem1LU3gzRU9IcmNIQW43akRQ?=
 =?utf-8?B?a2dXV2Z1UGEyVlJFN3lncXBEZTF3b3ZvOGNkbXRVNExMSkcyQmdTUXhjYmVL?=
 =?utf-8?B?WkpyVS9zR2NCMGI4ZUhwWnJYK2xlZ214U2VPbm9SRHpYL0k4OWd0emhJK2Zi?=
 =?utf-8?B?dnZIejk4aERrbWxLa1RoeDAvUk1memhaYlk5QmRSZldveDFoaTdoYXljbFdD?=
 =?utf-8?B?SFpHZUg3Y1ZUQ3Q0OHhMd1RlL0VOMW4vZ2Fkc3BsYlp1MEVnVGxkMmh0WEkz?=
 =?utf-8?B?SG1sWTlvQnVocmU0aWlxRjlJZXJpWTJTR0NFODVJNEltdThUc2x6NUhPK1k1?=
 =?utf-8?B?a1oxZURkcEx0L3NHTlI4ekh2Z3Fqb1FrUVlHcTg3OVA0K0krTThycGVzcjFG?=
 =?utf-8?B?RHpRd2RwcGQxdDhKSVBCUUNzMlB0OEszZEdGV1h3aHcrRmozNW5kTWFpTW1O?=
 =?utf-8?B?TjVGSFZ5QWR0cHhVMmVQWEFSRzBWZnc3T2ovSmh4ak56S09xYXNUMUVpc2tk?=
 =?utf-8?B?OTQrSXVrNExLZVQwNFJ3aEpVNWFqdkgyZlFkWVk5d0lLUy8vaWRzaWdScWRi?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F82A7F7AB8C4B34C9E152F77C0DADCF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5951229f-f11e-4f26-b131-08dcd2fd8aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 07:35:50.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqVCudOaSjk9Cf1yNSozBcIPIfsiX1RHGLaXyLl5CEHEiyzIahLCKVfyzaCjJGnlZRFIJrYMDTXZ311jYA49XzVPqJyjxiEERqElGCtZSDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849

T24gMTIuMDkuMjAyNCAxMDoyMywgY2xhdWRpdSBiZXpuZWEgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksIEFuZHJlaSwNCj4gDQo+IE9uIDA1LjA5
LjIwMjQgMTI6MzAsIEFuZHJlaSBTaW1pb24gd3JvdGU6DQo+PiB+OiBtYWtlIGR0YnNfY2hlY2sg
RFRfU0NIRU1BX0ZJTEVTPWF0bWVsLGF0OTEtdXNhcnQueW1hbA0KPj4gLT4gZm9yIGFsbCBib2Fy
ZHMgd2hpY2ggaW5oZXJpdCBzYW05eDYwLmR0c2k6IHNlcmlhbEAyMDA6ICRub2RlbmFtZTowOg0K
Pj4gJ3NlcmlhbEAyMDAnIGRvZXMgbm90IG1hdGNoICdec3BpKEAuKnwtKFswLTldfFsxLTldWzAt
OV0rKSk/JA0KPj4gc2VyaWFsQDIwMDogYXRtZWwsdXNlLWRtYS1yeDogRmFsc2Ugc2NoZW1hIGRv
ZXMgbm90IGFsbG93IFRydWUNCj4+IHNlcmlhbEAyMDA6IGF0bWVsLHVzZS1kbWEtdHg6IEZhbHNl
IHNjaGVtYSBkb2VzIG5vdCBhbGxvdyBUcnVlDQo+PiBzZXJpYWxAMjAwOiBhdG1lbCxmaWZvLXNp
emU6IEZhbHNlIHNjaGVtYSBkb2VzIG5vdCBhbGxvdyBbWzE2XV0NCj4+IC0+IE1lYW5zIDogYXRt
ZWwsdXNhcnQtbW9kZSA9IDxBVDkxX1VTQVJUX01PREVfU0VSSUFMPiBtaXNzZXMgZm9yIHVhcnQ6
DQo+PiAwLDEsMiwzLDQsNiw3LDgsOSwxMCwxMSwxMg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgZXhw
bGFpbiBpbiBwbGFpbiBFbmdsaXNoIHdoYXQgdGhpcyBtZWFucz8gRnJvbSBbMV0NCj4gDQoNClll
cywgSSB3aWxsIGRvIHRoYXQgaW4gVjIuIFRoYW5rcyENCg0KQmVzdCBSZWdhcmRzLCANCkFuZHJl
aSBTaW1pb24NCg0KDQo=

