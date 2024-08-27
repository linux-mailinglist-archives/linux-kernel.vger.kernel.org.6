Return-Path: <linux-kernel+bounces-303019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB1F96063E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41591F25ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668719D075;
	Tue, 27 Aug 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4vPPnxMo"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F21714B8;
	Tue, 27 Aug 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752244; cv=fail; b=WmaU0YGnB9HtlLOURVBvRu92MUjg3n5oOdCEGNUbASeaJ49M2SaCm/DHudX2uys2rqLoMXFm3HcfA6Q0Ckj83qFLZQm4jbZLKOlSajeMv65Ldh4V7VobpL8yYGTgCMBIodNGeulUGVMJabacynVFZqzYiq+pglAYQHgJGSqXqTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752244; c=relaxed/simple;
	bh=v64hnktqDk056B7PRzZGCSi87G368Jnp1bAN0PaohZw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/0nRQ5H9NXCGDNon1AybSLm+lm2OQwcpo3VKuePj8cE/OhvVB6hjz5/O3NqebRjkPWTH1JZL2UmNpqpwygew1JfDl3lgq4QC5xt8MzjdFyOiBQfCEm0fluM1dFzUuG/SbizvuzaUi5dBmejy0z+tOuOhkkEx2JS4VCVrpRIy0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4vPPnxMo; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN0McJ+okOsxPhLKGxoBtHoMeyMc++pUbxxYvh3y1gNzuFhT3zBkuICn8oFOdBYl02h4aaFmwThYEDJwPYaIMvplVR1gliva1KjEhHAtuhgz8pPI8T4IavCvjERsA+fXrMn1FoA+PxA9I/lEH8DxWHTyL2TRttSHPitGW47jUts/vEKMSzs9iM542UBuDd+Hn6+0EisxAoLARevZMPxFGj7sBwYpNHE3KILQ9/kS45wYI9SIbcSlXfrloaxUlSFKQwX2stX0paW93A/KC0YHLlY3L0ah9B3AHqbitMaJ9/CH9gJEJ5z8uN5f5Z92+hFMgtLs/RgKegDmwcAjatMwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v64hnktqDk056B7PRzZGCSi87G368Jnp1bAN0PaohZw=;
 b=ntsZS4loqGhfTaJ7IO5LpL18uRcbAcjVj6iaEeBMmAKqWwAvQagQzGo77GqCGAcR9ciQVR6TOPyxHKQC27b8Osz4SuOwRDHqYbfxtpgaXX9L2MWknAsIdkTd32y+OJa96l+u9edPNXktFvO6zlMZCYXIynXwDwG/y0OD7s1a7gfkaz0PZ0icH1FSg9zjxuSdJfzvYpr3T/UdG7x1QuQdOs372tcZ/Wm+R97yfdDV/cVnyoEKxAD0w+Xzx0KyyIOBiQWgC4JhSYWWu5+GiDlEzVt5oWHNWlnk0Xl+MBllDu7KNKlyIYcwDNp7c7UnACqTBYIAj4TQW7RTfZLu2KCvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v64hnktqDk056B7PRzZGCSi87G368Jnp1bAN0PaohZw=;
 b=4vPPnxMoxz0q55swIJLPu/QJshPIYPvazCG9uljQyO+dykpdLH/rca7oOfJQqq2BjMs/kIqNo0/16mLMr/xQPXU2ZD6ZQUYcJHeIKdgpXMKeW4ms5m9byYV/usKk6fjdJOi1VzMhMTLV9BNzEZx94DeQnw/lhScf+ZEQ0YLa4N2XYONW8AP72ylFmo4n7jHW86W5XWqpnNWYWZ4vRTxn7TPMrQ0e/zqrrDIJ4GlKbTTkcbusJyhDke81SdUIl3d7uiO7dmRLf24YEUACaowN0qBUmEf0bHhM6Yf/aW8YylKWm3XngHTzQXbQHZbXQQQme3nJfPDy9CuoEIlNUXbtPg==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 09:50:36 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:50:36 +0000
From: <Varshini.Rajendran@microchip.com>
To: <krzk@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Thread-Topic: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Thread-Index: AQHa4YZMeTWeKexZ3kW/54rPazvlL7IQhMgAgCqFTAA=
Date: Tue, 27 Aug 2024 09:50:36 +0000
Message-ID: <bf77fe95-0982-4605-a493-25c889e81639@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070934.1991467-1-varshini.rajendran@microchip.com>
 <7031d811-2bb2-4325-996c-a6de766925db@kernel.org>
In-Reply-To: <7031d811-2bb2-4325-996c-a6de766925db@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CH3PR11MB8444:EE_
x-ms-office365-filtering-correlation-id: ab1a2476-d6cd-4c4a-a0a5-08dcc67db3b1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlM3VU9WRjk1NWZtalVLMm11Q0x1RlZ4SFgxMTJaYTZseDZWZjhpcXM0enp0?=
 =?utf-8?B?SUJ2UmxxTGNwejJqQU1pUnlONWRtbER2SEhEL2J4cEJINjkydTdYNUVGM1RD?=
 =?utf-8?B?NVNtQ2VyRTd2SVVDMWRwMVFHOTlOUEkzUGdQdjVCNDMwM002bHJNNUhiZlR4?=
 =?utf-8?B?U3FyanlUaTdKUEw0RGNab3BKWkMzNDFGa2hmVmIzeEkyMjdJUTZGV1V3V3hN?=
 =?utf-8?B?ak1ZNWNmMXNkblphUTdWNkVmVmlwOXZ6M2U5OHdjWG03a0krZWJXR2RFNW5O?=
 =?utf-8?B?SzRaYzFXdU1rZVRWdW0wV2tMTXpMdjVscnBtT0djano5Wk5abGF2clIvVzJV?=
 =?utf-8?B?NHRkRHJQN2thTWJHUFU2cGJkQ1pEbnRWTmlaMmVaMS92cHVLNmdNRmRzd2JN?=
 =?utf-8?B?eXpEYnJKd0wvZmhGaktBOVQxalphYmIyLytveklWa1lKSFA5UUF5TTJ6S0tx?=
 =?utf-8?B?QXVrZG5oUVpaOVd1Rm1hTURiL0tiNHNSWDdtbjZFS2xPSjVkSHNUdTZJanZS?=
 =?utf-8?B?c0VaZXZUZzFERmZwR0VCM0E3M2w4SjQwU3FkVjRJT1NyWnhqQ1JnNk50Uzd6?=
 =?utf-8?B?Qnk1NjBWeWk4Q3UrYWZiVjdCc3VqcWRoWUNTUGdkdDRkYTUxcDM1M0dweWVW?=
 =?utf-8?B?WTZzSUVNRjJRcjVkY0p4VTRFR3lzU20zWUQvWS9pRGtWQ0ErWVFKK3NuYnhO?=
 =?utf-8?B?Z0Yvb3o1THcySm9rV0ZWaVMrMDA3eXphSmpDT2RFdnpYNWhQaWxZZ3JKd0tH?=
 =?utf-8?B?bDZ6bTFVUXExVEI0bXdNMkI3QVUvbWNGL1NvbWsxdGhKK1VkZUt0bTFzbThV?=
 =?utf-8?B?eWVLY3hZWTIxeWJyeVVIemFRZU1YeDczZndyQmlmM3B0dDRYTHluOTgwU1NX?=
 =?utf-8?B?cU81K0lxelhUR3E3Vk0wMDdtNE1hVzdYMEJQOEJUWU1va0k2VDdqNGRpVXRU?=
 =?utf-8?B?ZFJsY3FtaVVnV1ovUkhjOEk0WDZHWGpvN2l4K1JXQXdVQ09jbDFjakdOZDBs?=
 =?utf-8?B?QWNUekZ4TFp4ZVBCTThTZnNFZ0hjVGxnV1E2cXc4ZUhuUm5NN1BlQzl4cnRw?=
 =?utf-8?B?NWJrajNQVjR4ZXpSQ3prM0hlRWdsQlJ6RFZEeElQZU03ODBseHA5dCthanBC?=
 =?utf-8?B?NnJzOVcvVnBzdkQwWG1ubklHMmMwSFR2TXNad29GRGZDY3MxRi9kOGxKNGds?=
 =?utf-8?B?K0hQVitITUxnRTN5TExIdnp0RDI4QzBzOW5UWEpNaDJaaGRLUWl4Ukx6aTgy?=
 =?utf-8?B?dU55Ymt4OW0razVRaUpWMmQ0SitMUzluNy9LTUNad0dJTTB3anFVSVhZRFI4?=
 =?utf-8?B?VWgvU0JSRk13ZG1wRm5acW0vS0ZTOE1PMzNPSGVEQ0dkZmF2OEU3bytjRS9V?=
 =?utf-8?B?dmhFQVJmWVVWeC9JOW95aDJWOEhidGQ1ekdPcldwNG1mQ01PbER5WXhDKzFn?=
 =?utf-8?B?Kzd0bFJKSmI0MXZLUHZSOEZ2YVZCZXh1YndlMXBBamZSUnQ4MkVKcTdBOGxJ?=
 =?utf-8?B?OEZncHljZUVtQjNvRlI0Z1lCOENTcHdmbFpxU284dG56Y1lBRWRyVmo1R0Zh?=
 =?utf-8?B?ZHdkaW90ZzVYUG93cVhlNzFnYkNJbTlkSWpUWkFHRjIvODNjOWUzUTgvZWYy?=
 =?utf-8?B?YmlWclZ2NytZZXFzWk8rRll4ZmFYL0ViMEdqYTU3WGdibVlwd3UyUXZHYlZa?=
 =?utf-8?B?VHBpbGhGNGwrd2lGUTFaWnpRSEIwY0tmSk9yV3BLZEdSazlUYkV0THU0dXBy?=
 =?utf-8?B?TkpoRzBobnVtamZ5MVZvbTlJcEdhRWxTVmhvOFZmbVhQY1Z0cEZteDZzR1NL?=
 =?utf-8?B?cGlZOStkSk5EMENTQWtJN1NoYkRLTlRGd25TeDZzTVZzcXhYWTZGRVdWUjcr?=
 =?utf-8?B?NG1BVkkrVGtROFVjem9QTGY0NHRZKzlLS0NmVEYvK09vc2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkRGQmxnYUl2eS96eVdmcjZwK2oxaWg5dGZpNGNNTnVwUUk0a3Vaa253MEhL?=
 =?utf-8?B?UW5HTWo1NDBzMXBsMWVLWFVPaGZTV2ZGZy9qbGdXRXRjbERySUxaOHpwSU9K?=
 =?utf-8?B?ajhBN1h6UTBYYWRrYzFCWUhVb2oxZGZvN2tna0NyOUpMWEZNZkxDdFpkbGcy?=
 =?utf-8?B?TEU3R3ZYQUpYNnkxVVdDVlhONjdWdlNLTEtKeWFLeVFFZ2JQVzZFNHFiREhT?=
 =?utf-8?B?WmhjaSt0Mk8rdFFZUEpQbkY2UTlVU3FhcEd0YmJIeUpHVjltTjdQeXlCbFN6?=
 =?utf-8?B?Vk9RRE5rT0M2YmlSaU9ad0JvVlNJK2EzbFhuL0NqV1hqWmw0YlBCclhxMEx4?=
 =?utf-8?B?aEZtV2VZVmwyZnZKNXZDS2MzalRBamxiVEwxckIzNktZMDZQTXJ6Z3hTSExh?=
 =?utf-8?B?ZDcwbFVUNll2WHNtQzVHUm5TVndQT1VBZTlyL0JpVk9rVFlhb2h2dTZPckNS?=
 =?utf-8?B?bWRtQjZKOUN2Tzd2MDVSVEY4SkJaeEFCa3RTYnRmbmhYVndtTWFEY0J4ODFk?=
 =?utf-8?B?V3R5Ly9ZSWNTMXFKaHloVitzQlNKVHB6UUR2OVhzaUM5VHRzS0UwQS91M3Rx?=
 =?utf-8?B?TFpBQ20wa1E0QjhVU0xtNG5tb2ovKzNvTHZTbmI5VGdsZCtMcThDbVdXRjJQ?=
 =?utf-8?B?L3p3bXZ1QmpjQk5uNmYwRFNmVHNZaGtuREZHTVB3aVk3RERRTDUvMHdzdmkz?=
 =?utf-8?B?cThOSTdSREI4aFhLMk5MQlpGK284VlFHOThkRVFYcFJqMk0rZHcvL0FiMDJU?=
 =?utf-8?B?UHZDbytBenh4elAwZmdFTkR6SmlRbWlxT0RXSFhRUk5IdTRNOU41LzZCVFIz?=
 =?utf-8?B?d0RTSjZzRFhTbjhEWjMwUnAwNFpSRXJtcndZaWNaazFybWpqTVBYY2EvZGcv?=
 =?utf-8?B?SUFjTzJuOTZHUjdsS0htclJHaTd4bTVZMldvc1BONVJWZ2cybC95N0YzaC8r?=
 =?utf-8?B?TW5icjlrN2I4Mzg4cTVsSDljeS9vdVY1UWhBeE5RQkV5eElyTnZrdVBmQWtx?=
 =?utf-8?B?SEMxK00xVytOcHQ0d0ZaODF3UUZ4WnVtczNPVEI0aEpEQVE4c0ZQcHFmekVE?=
 =?utf-8?B?djVPaWh0eWpueDFiUHlWeHBqbXJ1ZDQyU1NUclBpczArRHZ6T3YzYUZBR1R2?=
 =?utf-8?B?NFpkbEtaKy9tUUdlQ2d5SEZYeHNZQkVLcWdlS0hwNnordTJoNkNPSlMxUWNQ?=
 =?utf-8?B?TW8xVzJ4WkNUTlBKT1NGTXR2UmdtK0QxbEg3VWdxNFpDaVBzVFEwTUNMdUZ6?=
 =?utf-8?B?RG5NUEtBN0xpTVVHM0RGeXBNRHozdzcxWkdHUW1HVUthdkFUR29YaHB0UkpG?=
 =?utf-8?B?eGtPYkFqVFRjSWIwMWh5b1ZuM25QLzV6Q3hyWkNuRGhBeEhnTHI2TVQyM0Fn?=
 =?utf-8?B?d3dHWkFqRWEyNlpIb1V0bHJzMTlObFBZelBpNGJnWm1OSU16aWZQRFhwVFMw?=
 =?utf-8?B?QTBjb3BlVTM5T2NTSWdvcFhjN25oNGFoNzBuNW53QmlMZVNGbU9KUmRsaUt3?=
 =?utf-8?B?MEJvN245WFVQNURqY2tDZXpCRGhCbTNyME5ReU1qVFZENGUvTmp1QjdIZCt6?=
 =?utf-8?B?R2w2TVFuTzI5VldkWDdvL2dnVWRIelpJQlppL3NVdEE1N3lORkpYOHl6TmdP?=
 =?utf-8?B?cEtXVHhNeGxZZ0N6dDkwdy9ibVNid0F0OTFIUkNEaTR3YTFSTWNkWUlwWmxk?=
 =?utf-8?B?TmFQL0N2RGJsLzIzRGVOTUNwYmpWODBGclRZRDNwUjRFNEFwRHJxcUpYUEpz?=
 =?utf-8?B?NnNpZDkvMDZPMkJsbXgyY0h2QzQrMm5PV1hXc0FyWWdjWUJPdE9kRUlkSEE4?=
 =?utf-8?B?OHcwREdSNFpDcmJJN21VWFVld3FGMXFyOGY4YXV4ZDR5NTdJN1BvRXg3dlBY?=
 =?utf-8?B?aDJ0YUlkcUJYaWM3QU9LVFkxaS9LWmxNb0hkTS8zUzhBUTRXSXZZcXJLVGp0?=
 =?utf-8?B?RjU0aTgxekVtNmdLR3IyeXlFTC9iajkwcjhMbU1hZThza3FyNFQrVUFpMVJY?=
 =?utf-8?B?TkFvKzU1eFdabEd0REYvT2paZTlZUHVpdDRwcmFybU5YVlNIL01oOHFKck9Y?=
 =?utf-8?B?eHdKbFNaQ3FSY1lRaFFnOW9oWGtFZjRCQWt4RU95S2dSbHNMMjlvZGZxZENJ?=
 =?utf-8?B?WitRMy9kMEoyWUFTUEpvN1orSXZHcGg1UU94UERFVmc0U3dETmdkZ0pIZ3cz?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA06FB705A4EE443AF6721BC21D55121@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1a2476-d6cd-4c4a-a0a5-08dcc67db3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 09:50:36.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmYhcERW9zuXCEx0fp3F+L+Mz/e2x+OZ769yAUjlGYlWMAssvy9I2quPphHX4LkeSVIdlmIp5SL9XAFyvgK/GFs9YV2fSgLRkI0sO2AapcdNKMBSz5wTkEU9U3XJWf1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444

SGkgS3J6eXN6dG9mLA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXNwb25zZS4NCg0K
T24gMzEvMDcvMjQgMjowMCBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyOS8wNy8yMDI0IDA5OjA5LCBW
YXJzaGluaSBSYWplbmRyYW4gd3JvdGU6DQo+PiBBZGQgZGV2aWNlIHRyZWUgZmlsZSBmb3IgU0FN
OVg3IFNvQyBmYW1pbHkuDQo+Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBOaWNvbGFzIEZlcnJlIDxu
aWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIEZl
cnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWYXJz
aGluaSBSYWplbmRyYW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAuY29tPg0KPiANCj4g
Li4uDQo+IA0KPj4gKw0KPj4gKyAgICAgICAgICAgICBjYW4xOiBjYW5AZjgwMDQwMDAgew0KPj4g
KyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYm9zY2gsbV9jYW4iOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweGY4MDA0MDAwIDB4MTAwPiwgPDB4MzAwMDAwIDB4
YmMwMD47DQo+PiArICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gIm1fY2FuIiwgIm1l
c3NhZ2VfcmFtIjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDMwIElS
UV9UWVBFX0xFVkVMX0hJR0ggMD4sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDw2OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAg
IGludGVycnVwdC1uYW1lcyA9ICJpbnQwIiwgImludDEiOw0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMzA+LCA8JnBtYyBQTUNfVFlQ
RV9HQ0sgMzA+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImhjbGsi
LCAiY2NsayI7DQo+PiArICAgICAgICAgICAgICAgICAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZw
bWMgUE1DX1RZUEVfQ09SRSBQTUNfVVRNST4sIDwmcG1jIFBNQ19UWVBFX0dDSyAzMD47DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NDgwMDAwMDAwPiwg
PDQwMDAwMDAwPjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBhc3NpZ25lZC1jbG9jay1wYXJl
bnRzID0gPCZwbWMgUE1DX1RZUEVfQ09SRSBQTUNfVVRNST4sIDwmcG1jIFBNQ19UWVBFX0NPUkUg
UE1DX1VUTUk+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGJvc2NoLG1yYW0tY2ZnID0gPDB4
NzgwMCAwIDAgNjQgMCAwIDMyIDMyPjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMg
PSAiZGlzYWJsZWQiOw0KPj4gKyAgICAgICAgICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgICAgICAg
ICB0Y2I6IHRpbWVyQGY4MDA4MDAwIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gIm1pY3JvY2hpcCxzYW05eDctdGNiIiwiYXRtZWwsc2FtYTVkMi10Y2IiLCAic2ltcGxl
LW1mZCIsICJzeXNjb24iOw0KPiANCj4gV2h5IHRoaXMgaXMgc2ltcGxlLW1mZCB3aXRob3V0IGNo
aWxkcmVuPw0KDQpUaGUgdGNiIG5vZGUgd2lsbCBoYXZlIGVhY2ggVEMgKFRpbWVyIENvdW50ZXIp
IEJsb2NrIGFzIGEgY2hpbGQgd2hlbiBpdCANCmlzIGNvbmZpZ3VyZWQgdG8gYmUgdXNlZCBhcyBl
aXRoZXIgb25lIG9mIHRoZSBmb2xsb3dpbmcgbW9kZXMgVGltZXIgb3IgDQpDb3VudGVyIC8gQ2Fw
dHVyZSAvIFBXTS4NCj4gDQo+PiArICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZjgwMDgw
MDAgMHgxMDA+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MTcgSVJRX1RZUEVfTEVWRUxfSElHSCAwPjsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhF
UkFMIDE3PiwgPCZwbWMgUE1DX1RZUEVfR0NLIDE3PiwgPCZjbGszMmsgMD47DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAidDBfY2xrIiwgImdjbGsiLCAic2xvd19jbGsi
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArICAg
ICAgICAgICAgIH07DQo+PiArDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiAN
Cg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpWYXJzaGluaSBSYWplbmRyYW4uDQoNCg==

