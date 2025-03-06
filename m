Return-Path: <linux-kernel+bounces-548316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D9A5434C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E5216F63D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE291A9B23;
	Thu,  6 Mar 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SRywy+Ls"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2319DF4D;
	Thu,  6 Mar 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244989; cv=fail; b=YQyJJpkVaMIH+prB8BoaEw4Ia6mAA3ZDI5XANFh/BaNBUjO9+O+RWDmp7jK+NWsP1DJqnfRbHzD2wp9BSM3vlPdVeE/KUw2ylaSANu8y9xad4EGI7sjXNfi3VzFH40OIHqrDDZqXkn2mPTmi1oEW6EbwO+WzQDEYy2JZgI/cWPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244989; c=relaxed/simple;
	bh=oHtD19Q3PsgJeGjImlZ0DTnQGnbHFz2t4F1rjdCCPb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPm9oufAxnZO0HVpAKhdzn237nSqBrzCkp+SZ2jPgVotoXigaseiF59dvkT/UKFfK+8tLH7ll2warRxHEWpa4IwB+bPZjAQEggzEsO3tODOK+56R5FF5xNkQr1hzPD5gyZBAuCvNZnGszq46BH01fYQVyg1czN5V0LMZ85SzXss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SRywy+Ls; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSAZBfQwJ5rojoz1AUdvYE7TVXz7GnB0XqtZLi4skX5gB0J/8ara4tDEOTnhlNtT+b8QEgCsFihaRX34S+XcEhp8FKVTnZO/aZ/9eKZbOvm0rQrE7QhPlIb46fkubNPcVENMcIOFJ3COEyuGYKSs0kvcNcbbNTmKfn+EGJG0D4CDIcBzj7i20cp/dK3DPb/D2mtCb/0qKiR1uniz6SqMb6pZvsHxEaKWBsGVgOruAcXibRuJ0yuZXdF5nGGQSONjsgOe4oYyYFm+emSbGmceP25jdKBdvIWPONDypKEVl0eZKfL8hDP7qgoD1i1dK1UtgBR4Un2sdhELsyGdNjIT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHtD19Q3PsgJeGjImlZ0DTnQGnbHFz2t4F1rjdCCPb0=;
 b=uOqRWzd5etF3nyeUn+jA9O8kSckImyiYphch7sK/tY2YF2bdsP/sin4PtbqLfQNee6uyUb/5zu0yzPVoDl2OqV1sR5w3lJKiOfMnTT9o5IoZ1iwPEoUqJRgEtbL3mrUa/iOvu0GTHWHU97xTp4XZqnxhiFD+qUTDKfu4A/sSMFsqU/tSD9HaApFFvP9ZJuWSXtVT84qpWLLqslWHfmLHPKeyORG0t43KMWJ0Zlje7lXoLqmBQjObM4mo00Sq55gUXN5dcg/BRtISOA/NnbpKjGUBrz7u8qGlz+GynaU4NBNt5XEG/LcqR2X+YOfyxfY5m7V9f9WxbGQ+BE9WBWoOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHtD19Q3PsgJeGjImlZ0DTnQGnbHFz2t4F1rjdCCPb0=;
 b=SRywy+LsqPg8ZsnbP1v9PzO3vl0xKHGcep297LcW2FdDyzOW2EhVM4CMYfXZdgINUIEFDtvy6OhB/wVBR5YxrRnGoSpkYrrSC6eHiCR3EiBMCiJ2L5IXmAHt4xIKqw5tAgsX5iiEM6ayNfNwxLYvzVrblowNNGItyBgMmr8+8msqR4yfNiENS7ibG1W9F1zAxjGnmFL89GmKGlAYCfKvd3So8JazpJnpgxV6LofbTxoqv4qtZ/EX32iPaiNMvWvVv/9qaRiOzUqpIeBHyX1zA7uDguLhBNuT/9f2YnuxZo53kZqfkXw5/dEVMSM8EOqs5Z7A/1i7HyLsLjCal6R46g==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 07:09:44 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 07:09:44 +0000
From: <Manikandan.M@microchip.com>
To: <mwalle@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <Varshini.Rajendran@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Thread-Topic: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
Thread-Index: AQHbjbXbTNB5hzSu106BrFJRNUN76LNkVjeAgAFb1gA=
Date: Thu, 6 Mar 2025 07:09:44 +0000
Message-ID: <6fee6e71-106f-474b-9a0c-5df5fb0caa00@microchip.com>
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
 <D889CRJC6W19.2LDQCDVG7BLNG@kernel.org>
In-Reply-To: <D889CRJC6W19.2LDQCDVG7BLNG@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|SN7PR11MB8065:EE_
x-ms-office365-filtering-correlation-id: dbe00793-44b3-4138-f188-08dd5c7ddf7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHBib3MzSDlDNjI5OWtKeFRmM3pIQW12SHAzNCtIL2o2QkpzQzdFVmlVaXh5?=
 =?utf-8?B?enBvWmZ3am9IbGFxUWhrSEZzRVNpV3NwNWtTbzhJM0pJTWV3dGtKenVWbWU0?=
 =?utf-8?B?NnorRk9CeGU0SDJsTVVwSmNWTGg1KzdoLzEzZ2JvWkJHRmFhQ2Q2UXUxT000?=
 =?utf-8?B?bDAyd1lmbGIvd0JkYkk0eWJwTG5pY2wwb1YrVVVwY3k3cUJtQVZYSkR1aXFm?=
 =?utf-8?B?T3Jhdi9XNEwwSkxJVjk5bCs5RDh0UVc2ZXFKenBOWnZVcE5XU0tWTjg5NzJu?=
 =?utf-8?B?SUZneW45YzJnWWUrSjdJRlJ2MDVaNTNXd0xhekEweU1JbG9jVzJ6VDBWTEkw?=
 =?utf-8?B?RFhja3VORnNScEFiYUJOVmpSY3haQThhOGRIK1ExVGhjKzNkNG1KL2V3RG5Z?=
 =?utf-8?B?WDN6OVVka3k4TWlqYVdPb29RNHNpRUZNb2xzbndPQ2tWdkF5Wk0wTkE1WVl5?=
 =?utf-8?B?V3NJUm9kaTE2aHFWM05COGVJK0NWbUVKTExyRFZUZndycHIxZjluRkdSc2NF?=
 =?utf-8?B?TE45RW5jaitUNWhkeDVmT0ZvYWx3M2k5Um10STUvQjZBTzdwMFJCRHgzVnhh?=
 =?utf-8?B?TzZHNHQ4SEpCN1duWjZZcmpUTDduKzVPc1lyeEx6OU9wMHFKV0pIWGgvbnlG?=
 =?utf-8?B?YllRMDYvR0hDbk5JOG9uTGFJMlQwQzRHV1B3R1g4Z0VWT2tTQTc0KzY3VkFz?=
 =?utf-8?B?WkFpYS9yNXJuOEtoZjdNb1pJMkg3VGFpdHpCbkdwKzhCVEZvTWMzalNoK1ht?=
 =?utf-8?B?SzU5UGtwdHRsMFVIN25VZ2dDY2IvWTBFdGNvaXZWWEZJakp5ckhFUjlLdlhv?=
 =?utf-8?B?WHNMRUpkUjJxSXBKcm1TWkFTQ3Q5RjdjTk9JUm4vTDRRZGVVNmNmTW1XOG5w?=
 =?utf-8?B?WUJsZG9BQ2RHckpiODh5U1F0bUhaKzN2OEdRT2IwcDZzNEFQK0JPN3hkaDNO?=
 =?utf-8?B?UnVTVmp2ZTlUQ08vQ3krazRmQ0RKa21OTTFzS01mY3ZKbmF1MzE2WUlWNGVZ?=
 =?utf-8?B?d0NqaVBJTVp5RzFDdGxkMnNMeUtBT3RSMUxZS05nRnRGZVhFRFhRVnpxdC84?=
 =?utf-8?B?Q2dySnZIR1VGeW9ldFUxQ2FneVNkQmptcFZONDlNeXpyVHZ4emRzZElRWHla?=
 =?utf-8?B?dndVNlVYMm1ydzRORVY2TlU0NG9SRnRYNitBOXM4bkcvWnUxN2xWY3V3cjZH?=
 =?utf-8?B?b3dmdUkxQW55QVljU1hUaXQzcldiMGpTcGhpYVpLY3Q2RzR4VzQzTmFKRnBa?=
 =?utf-8?B?czF2WUtVWlJkRkxzNjk4WHR0WmxnMEtFSVNyOXJGV1VsNXRUMWJ4UkJxUmU0?=
 =?utf-8?B?NlB2cnR1eFl5Q2NCM3c0OHo0OERLald6bi9pWXU4MW85aWd3ZjdaeDV2QWpS?=
 =?utf-8?B?ZVZ1WUxMeG5oRnk1RWZlVGlBUHRVTWNjbGQvWEVXdWFmalFONVhOcThXVzJY?=
 =?utf-8?B?UDV1NDZ6TlNOdGJjaEo1Qk9kNUxpc2t0U0t2OG9ZRUN1b0N6OTczZWRqZElk?=
 =?utf-8?B?WFN2a0NON2o4MnFVdi8rU0ozaVFKZG5zVytQZHQxVnFCbElTNURqQi9mak1h?=
 =?utf-8?B?NzBNTEZVMk5OTW5JNHNWRE5YOTZrWXpHZHBhQVdJK0RkV25ISzROdmFuK0ZX?=
 =?utf-8?B?KzMweWNkUENCNlluSE51bFA1dTVhckV1eDJuR1ZkSkhZb2o1R0VmZmVXMHpv?=
 =?utf-8?B?TWpIT1V4WHhnekZFVnc5dCtKYjdRWW1WQTNtQnliOThUZGg2Q3hqWkJLc2NZ?=
 =?utf-8?B?VFR4MEtNNXZTejRnZHdmRSs4b2tRWjBxbTlnQzNuVllUaXZSYUM4Rk4wSmhQ?=
 =?utf-8?B?QTBDNmNMTVlPd0hJVlNDOHFhS2lWT1c1WkpENTRyc05HdFNTN1ZERWlnRGdw?=
 =?utf-8?B?S3BMaVptOTIvREUwUzlwR0k1UWpyL3diWTlNSVBTRmZMWWNQZm1nUUs0ZWVm?=
 =?utf-8?Q?Pi8fxepdwyQx5uJ95+EuQiodlRy8DDtK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlVKSWU0RmdQVklZakVRREJpU2NIMGFDL1RqWHFzUlNacFhOSytNRUhRM3lY?=
 =?utf-8?B?R1BQaUZhc24yOHhTMmtMbTlkUTNUWko2ekNRRDMwdUtoaWpKZExqWWxsbmlx?=
 =?utf-8?B?T2pjWTJ4UGU4WHRYRU5pOWFYWU9rbG1QdWwrckJZZ3JIQklNc2xqMlRMdUUz?=
 =?utf-8?B?bHRvQUVVRzExajlqN2trU0UzWjFSLzl2b0dhUFJvZStyNFNXTVhIbmxGcWRC?=
 =?utf-8?B?OHVBR3VqdDRrcTNSV3ExVndZNU85MzRZRDdVVFlWcTdTRHU1UnhDVGNaVDJZ?=
 =?utf-8?B?b0tsVEVIMm9rMEIyc05rd1pObmoycmNBU1dIU1JNN0JMSkVkQ3RsRDIxMmln?=
 =?utf-8?B?UEFUMHVaQ1dlUXZ2N1ZGZ1dLakdpNFoxaG15eTdtQXVCODFpQkNiYlFEa2pY?=
 =?utf-8?B?UmxlWS9xMU5ERUxtN0dIaUYrcnRSR1Y1V0ZYcHc0TitGc0xCaXQxa2xPNjdB?=
 =?utf-8?B?VjRYM1V3Q0FReWIzMEZ6U2JNMUJ2V1B5S05OZVlDemZ0V0ovVmxHeDBpa3VB?=
 =?utf-8?B?WkN3d0lHaFJvb1FKTnhIVForeklaeHdVUUswWXhEMysvMWVaRlZwMTZzRWVO?=
 =?utf-8?B?VWN5M09UOWt4UDJhSk1WTHhuOVVmQ016b1lQc2pBNUp4dmtDTGg2eVBIK3Za?=
 =?utf-8?B?OTI2OGZhVktJTUg4ZTFWM3hDdC9RTTFUandsRksrQlpiZEdRT1V2c09CUnVp?=
 =?utf-8?B?empNK2xHWGlMRmdoc0pUMVhSMk4wS2FTSTNFWUhKZ0dUNmNvdFRNdG81MS9m?=
 =?utf-8?B?eXI1bjNtSXZtaXpNSm1ieTNxNDNNaGRSd21tdlBudVRMYUh0M21iQXdNVjJw?=
 =?utf-8?B?VUZWOFh5NXJGVXpPRG5qNlJvaTZqUUUxT0paaUhCSmJyYUpVQkdsSExldWF2?=
 =?utf-8?B?NFdYeVJ6N29GWFJLS25nME9iMThCbE5lZHhXVlJBVUF5Zmd4Ny9GSUZZWmI4?=
 =?utf-8?B?L2pUdUxCS1N4M3IwZWdKc1lFdi8rcXlWMEhRMzFtYjFBUitWRmc0K1JheHVN?=
 =?utf-8?B?M1pvanVvV2NnR3VQTEY3cHhHNE94M3FVM0lCUnBFSWVFSUowQUU0Z1pIVEcx?=
 =?utf-8?B?bU0zV0xPdkI5UTN2cVJNNlFaODlyOXpFcTZtSDRoKzZrb2V6MnR0bWplYWlS?=
 =?utf-8?B?dVhhZEcrUEIxUWFURFdHUUFseWpnMjI1KzhvdVNvY0N2MW5wZHBKbnVCY0w5?=
 =?utf-8?B?TytSTWRRTG82TnNyV3k1b1RpWmYxbGFRUDYyS0hBUHhXd1Juamp5M3pDcVdR?=
 =?utf-8?B?Unc2ckNvSnVTZTRyYnNHTklSOG9NN1VJaWxjU21MNEt6THREVytrVGEvWDIz?=
 =?utf-8?B?UTRGd3lCNFJoMHlJUFV1dThLYURHaEtvM2Z6ckcrc2tsd1lhNm1od2FrNytZ?=
 =?utf-8?B?eW83Y0ZPN1BQMEJaNlZQWmJZVG5CSlYwU0dGbnVWcEkrYmFyRVZoREVaZ09W?=
 =?utf-8?B?UEg0bExQM01ZNFhDMU40NkM0MUs3VHNQdnFxN2dVMjRBMUx2MGNmZHpMR1ds?=
 =?utf-8?B?K0hlbW04cTJnbHNpSWwvNlNrZGJIc0l0WUQ3c1RWZEZlMjNaSDBvV2ZUanF4?=
 =?utf-8?B?ZEZJSDhYcXdMMkZHUUVaVlc4ZUJ1dG9GRU5CZVQ3MlBNMXVyUldPaHo2QVZy?=
 =?utf-8?B?bTZ5ZXBFQ2hIdkduOEZXYmVGWUtPTU16QTdsS3NLM25iUGkxMkh4QkdGUlk3?=
 =?utf-8?B?S2E0dStuT3lJcjRMTVg4NkZPYWUzeDdlNnJneG9iWWhXRXc5S1RPMXA1QmFI?=
 =?utf-8?B?Q2diS0FMdHhvSWpQRmNIV2tuQmdBd0l1MGJyNkJHV1YwK1duVkxOZy90Kzlx?=
 =?utf-8?B?c3NSUTZFTkxkNGhDWi9oeVJkNldyY2MyMEx1M21KQ2tEUmg1MkNDOERtNis0?=
 =?utf-8?B?RmpQeThSME9vQjFmOWF5ZTJ3ckVDL0FlWFpuVENsWmxobktLOWlCYjIrR21Q?=
 =?utf-8?B?UHhSZEh5VnQrOTNyVlpoTld0MDdDclEwMkV5NEV1U0tLbmVnVXdIQjM5OU1r?=
 =?utf-8?B?MUJ2Y2N5cUFVdytIMnpya0RBV0VhSlVEYnNSSHJUaSt4T3lRaEhsU3pDT25l?=
 =?utf-8?B?cGdIOGRjMU9WSWpIUXhhQS9tQlJ1em5sekx6cG9iTXcrODRERHg2YkpzYnFJ?=
 =?utf-8?Q?v3VUTquH2wPkxlem8NFF80Wpu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3EBE73B5C58C645BE8D0A1FAF8404CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe00793-44b3-4138-f188-08dd5c7ddf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 07:09:44.6456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEOuKKycHTGmzaNOYZaLqLQKDkzSO05s9BDGF6Feu7hEQZKfsO9o4hulbRHVzvab53nv6oOHH2eKCnW6v5+BBenqR5NZwQuWoJ0Djn0F6QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065

SGkgTWljaGVhbCwNCg0KT24gMDUvMDMvMjUgMzo1NCBwbSwgTWljaGFlbCBXYWxsZSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQgTWFyIDUs
IDIwMjUgYXQgMTE6MDEgQU0gQ0VULCBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiB3cm90ZToNCj4+
IEZyb206IFZhcnNoaW5pIFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFuQG1pY3JvY2hpcC5j
b20+DQo+Pg0KPj4gRVVJIGlkZW50aWZpZXIgYW5kIHRoZSBNQUMgQWRkcmVzcyBvZiB0aGUgRXRo
ZXJuZXQgSW50ZXJmYWNlIGlzIHN0b3JlZA0KPj4gYWZ0ZXIgdGhlIFNGRFAgdGFibGUgb2YgY29u
dGVudHMgc3RhcnRpbmcgYXQgYWRkcmVzcyAweDI2MCBpbiB0aGUNCj4+IFFTUEkgbWVtb3J5Lg0K
Pj4gUmVnaXN0ZXIgdGhlIGVudGlyZSBTRkRQIHJlZ2lvbiByZWFkIGJ5IHRoZSBzcGktbm9yIChu
b3ItPnNmZHApIGludG8gdGhlDQo+PiBOVk1FTSBmcmFtZXdvcmsgYW5kIHJlYWQgdGhlIE1BQyBB
ZGRyZXNzIHdoZW4gcmVxdWVzdGVkIHVzaW5nIHRoZSBudm1lbQ0KPj4gcHJvcGVydGllcyBpbiB0
aGUgRFQgYnkgdGhlIG5ldCBkcml2ZXJzLg0KPj4NCj4+IEluIGtlcm5lbCB0aGUgRXRoZXJuZXQg
TUFDIGFkZHJlc3MgcmVsaWVkIG9uIFUtQm9vdCBlbnYgdmFyaWFibGVzIG9yDQo+PiBnZW5lcmF0
ZWQgYSByYW5kb20gYWRkcmVzcywgd2hpY2ggcG9zZWQgY2hhbGxlbmdlcyBmb3IgYm9hcmRzIHdp
dGhvdXQNCj4+IG9uLWJvYXJkIEVFUFJPTXMgb3Igd2l0aCBtdWx0aXBsZSBFdGhlcm5ldCBwb3J0
cy4NCj4+IFRoaXMgY2hhbmdlIGVuc3VyZXMgY29uc2lzdGVudCBhbmQgcmVsaWFibGUgTUFDIGFk
ZHJlc3MgcmV0cmlldmFsIGZyb20gUVNQSSwNCj4+IGJlbmVmaXRpbmcgYm9hcmRzIGxpa2UgdGhl
IHNhbWE1ZDI5IGN1cmlvc2l0eSBhbmQgc2FtOXg3NSBjdXJpb3NpdHkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogVmFyc2hpbmkgUmFqZW5kcmFuIDx2YXJzaGluaS5yYWplbmRyYW5AbWljcm9jaGlw
LmNvbT4NCj4+IFttYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbTogSW50ZWdyYXRlIHRoZSBudm1l
bS0+cmVhZCBjYWxsYmFjayBmcmFtZXdvcmtdDQo+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFu
IE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAg
ZHJpdmVycy9tdGQvc3BpLW5vci9zc3QuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NzdC5jIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9zc3QuYw0KPj4gaW5kZXggMTc1MjExZmU2YTVlLi5hMGFiZjIwMWFkNDEgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NzdC5jDQo+PiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NzdC5jDQo+PiBAQCAtNSw2ICs1LDcgQEANCj4+ICAgICovDQo+Pg0KPj4gICAj
aW5jbHVkZSA8bGludXgvbXRkL3NwaS1ub3IuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvbnZtZW0t
cHJvdmlkZXIuaD4NCj4+DQo+PiAgICNpbmNsdWRlICJjb3JlLmgiDQo+Pg0KPj4gQEAgLTEzLDYg
KzE0LDggQEANCj4+DQo+PiAgICNkZWZpbmUgU1NUMjZWRl9DUl9CUE5WICAgICAgICAgICAgICBC
SVQoMykNCj4+DQo+PiArI2RlZmluZSBTU1QyNlZGX1NGRFBfRVVJNDggICAweDMwDQo+PiArDQo+
PiAgIHN0YXRpYyBpbnQgc3N0MjZ2Zl9ub3JfbG9jayhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2Zm
X3Qgb2ZzLCB1NjQgbGVuKQ0KPj4gICB7DQo+PiAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0K
Pj4gQEAgLTU2LDggKzU5LDY3IEBAIHN0YXRpYyBpbnQgc3N0MjZ2Zl9ub3JfbGF0ZV9pbml0KHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgICAgICAgcmV0dXJuIDA7DQo+PiAgIH0NCj4+DQo+PiAr
LyoqDQo+PiArICogc3N0MjZ2Zl9zZmRwX21hY19hZGRyX3JlYWQoKSAtIGNoZWNrIGlmIHRoZSBF
VUktNDggTUFDIEFkZHJlc3MgaXMgcHJvZ3JhbW1lZA0KPj4gKyAqIGFuZCByZWFkIHRoZSBkYXRh
IGZyb20gdGhlIHByZXN0b3JlZCBTRkRQIGRhdGENCj4+ICsgKg0KPj4gKyAqIEBwcml2OiBVc2Vy
IGNvbnRleHQgcGFzc2VkIHRvIHJlYWQgY2FsbGJhY2tzLg0KPj4gKyAqIEBvZmZzZXQ6IE9mZnNl
dCB3aXRoaW4gdGhlIE5WTUVNIGRldmljZS4NCj4+ICsgKiBAdmFsOiBwb2ludGVyIHdoZXJlIHRv
IGZpbGwgdGhlIGV0aGVybmV0IGFkZHJlc3MNCj4+ICsgKiBAYnl0ZXM6IExlbmd0aCBvZiB0aGUg
TlZNRU0gY2VsbA0KPj4gKyAqDQo+PiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1FSU5WQUwg
IG90aGVyd2lzZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW50IHNzdDI2dmZfc2ZkcF9tYWNfYWRk
cl9yZWFkKHZvaWQgKnByaXYsIHVuc2lnbmVkIGludCBvZmYsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2b2lkICp2YWwsIHNpemVfdCBieXRlcykNCj4+ICt7DQo+PiAr
ICAgICBzdHJ1Y3Qgc3BpX25vciAqbm9yID0gcHJpdjsNCj4+ICsgICAgIHN0cnVjdCBzZmRwICpz
ZmRwID0gbm9yLT5zZmRwOw0KPj4gKyAgICAgbG9mZl90IG9mZnNldCA9IG9mZjsNCj4+ICsgICAg
IHNpemVfdCBzZmRwX3NpemU7DQo+PiArDQo+PiArICAgICAvKg0KPj4gKyAgICAgICogQ2hlY2sg
aWYgdGhlIEVVSS00OCBNQUMgYWRkcmVzcyBpcyBwcm9ncmFtbWVkIGluIHRoZSBuZXh0IHNpeCBh
ZGRyZXNzDQo+PiArICAgICAgKiBsb2NhdGlvbnMuDQo+PiArICAgICAgKiBAb2ZmIGlzIHByb2dy
YW1tZWQgaW4gdGhlIERUIGFuZCBzdG9yZXMgdGhlIHN0YXJ0IG9mIE1BQyBBZGRyZXNzDQo+PiAr
ICAgICAgKiBieXRlLCAob2ZmIC0gMSkgc3RvcmVzIHRoZSBiaXQgbGVuZ3RoIG9mIHRoZSBFeHRl
bmRlZCBVbmlxdWUNCj4+ICsgICAgICAqIElkZW50aWZpZXINCj4+ICsgICAgICAqLw0KPj4gKyAg
ICAgaWYgKFNTVDI2VkZfU0ZEUF9FVUk0OCAhPSAqKCh1OCAqKXNmZHAtPmR3b3JkcyArIChvZmZz
ZXQgLSAxKSkpDQo+PiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gV2hhdCBo
YXBwZW5zIGlmIHlvdSByZWFkIGF0IGEgZGlmZmVyZW50IG9mZnNldD8gWW91J3JlIGV4cG9zaW5n
DQo+IHRoZSBlbnRpcmUgU0ZEUCByZWdpb24uIFdoYXQgaGFwcGVucyBpZiB0aGVyZSBpcyBhIDB4
MzAgYXQgYQ0KPiBkaWZmZXJlbnQgbG9jYXRpb24/DQo+IA0KU2luY2UgdGhlIG9mZnNldCBpcyBw
YXNzZWQgZnJvbSB0aGUgbnZtZW0tbGF5b3V0IGluIERUIEkgdGhvdWdodCB0aGF0IA0KY291bGQg
aGVscCBhbmQgSSBub3cgcmVhbGl6ZSB0aGF0IHRoZSBTRkRQIFRhYmxlIG9mIGNvbnRlbnRzIGZv
ciBvdGhlciANCnBhcnQgbnVtYmVycyBzdGFydGluZyB3aXRoIHNzdDI2dmYwNjRiIGVuZHMgYXQg
MHgyNUYsIGdvaW5nIGZvcndhcmQgSSANCndpbGwgYWRkIGEgY2hlY2sgdG8gdmFsaWRhdGUgdGhl
IG51bWJlciBvZiBEV09SRFMgaW4gdGhlIHBhcmFtZXRlciB0YWJsZSANCnRvIGRpZmZlcmVudGlh
dGUgYW5kIHByb2NlZWQgZnVydGhlciBmb3IgU1NUMjZWRjA2NEJFVUkgZmxhc2guDQo+PiArDQo+
PiArICAgICBzZmRwX3NpemUgPSBzZmRwLT5udW1fZHdvcmRzICogc2l6ZW9mKCpzZmRwLT5kd29y
ZHMpOw0KPj4gKyAgICAgbWVtb3J5X3JlYWRfZnJvbV9idWZmZXIodmFsLCBieXRlcywgJm9mZnNl
dCwgc2ZkcC0+ZHdvcmRzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ZkcF9z
aXplKTsNCj4+ICsgICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgc3RydWN0
IG52bWVtX2NvbmZpZyBzc3QyNnZmX3NmZHBfbnZtZW1fY29uZmlnID0gew0KPj4gKyAgICAgLndv
cmRfc2l6ZSA9IDEsDQo+PiArICAgICAuc3RyaWRlID0gMSwNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgc3N0MjZ2Zl9ub3JfcG9zdF9zZmRwKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAr
ew0KPj4gKyAgICAgc3RydWN0IG52bWVtX2RldmljZSAqbnZtZW07DQo+PiArDQo+PiArICAgICBz
c3QyNnZmX3NmZHBfbnZtZW1fY29uZmlnLmRldiA9IG5vci0+ZGV2Ow0KPj4gKyAgICAgc3N0MjZ2
Zl9zZmRwX252bWVtX2NvbmZpZy5zaXplID0gbm9yLT5zZmRwLT5udW1fZHdvcmRzICogc2l6ZW9m
KCpub3ItPnNmZHAtPmR3b3Jkcyk7DQo+PiArICAgICBzc3QyNnZmX3NmZHBfbnZtZW1fY29uZmln
LnByaXYgPSBub3I7DQo+PiArICAgICBzc3QyNnZmX3NmZHBfbnZtZW1fY29uZmlnLnJlZ19yZWFk
ID0gc3N0MjZ2Zl9zZmRwX21hY19hZGRyX3JlYWQ7DQo+PiArDQo+PiArICAgICBudm1lbSA9IGRl
dm1fbnZtZW1fcmVnaXN0ZXIobm9yLT5kZXYsICZzc3QyNnZmX3NmZHBfbnZtZW1fY29uZmlnKTsN
Cj4+ICsgICAgIGlmIChJU19FUlIobnZtZW0pKSB7DQo+PiArICAgICAgICAgICAgIGRldl9lcnIo
bm9yLT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgTlZNRU0gZGV2aWNlOiAlbGRcbiIsIFBUUl9F
UlIobnZtZW0pKTsNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIobnZtZW0pOw0KPiAN
Cj4gSSBkb24ndCB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBoYXZlIHRoaXMgb25lLW9mZiBpbiBh
IHBhcnRpY3VsYXINCj4gZHJpdmVyLiBJZiBhdCBhbGwsIHRoaXMgc2hvdWxkIGJlIGhhbmRsZWQg
aW4gdGhlIGNvcmUuIFNvcnJ5LCBidXQNCj4gdGhpcyByZWFsbHkgbG9va3MgbGlrZSBhbiB1Z2x5
IGhhY2suDQo+IA0KDQpCZWNhdXNlIHRoZSBFVUkgaWRlbnRpZmllciB3aXRoaW4gdGhlIFNGRFAg
aXMgdW5pcXVlIHRvIHRoZSANClNTVDI2VkYwNjRCRVVJIGZsYXNoLCBJIG9wdGVkIHRvIGhhbmRs
ZSBpdCBoZXJlIHJhdGhlciB0aGFuIGluIHRoZSBjb3JlLg0KDQpBbHNvIGhlcmUgdGhlIE1BQyBh
ZGRyZXNzIGRhdGEgcmVzaWRlcyB3aXRoaW4gdGhlIDB4MjYwLTB4MjZGIHJhbmdlLCBJIA0Kd2ls
bCByZXNpemUgdGhlIG52bWVtX2NvbmZpZy5zaXplIHRvIDB4MTAgaW5zdGVhZCBvZiByZWdpc3Rl
cmluZyB0aGUgDQpmdWxsIFNGRFAgcmVnaW9uIGFzIE5WTUVNLg0KDQo+IC1taWNoYWVsDQo+IA0K
Pj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gICBz
dGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3JfZml4dXBzIHNzdDI2dmZfbm9yX2ZpeHVwcyA9IHsN
Cj4+ICAgICAgICAubGF0ZV9pbml0ID0gc3N0MjZ2Zl9ub3JfbGF0ZV9pbml0LA0KPj4gKyAgICAg
LnBvc3Rfc2ZkcCA9IHNzdDI2dmZfbm9yX3Bvc3Rfc2ZkcCwNCj4+ICAgfTsNCj4+DQo+PiAgIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzc3Rfbm9yX3BhcnRzW10gPSB7DQo+IA0KDQot
LSANClRoYW5rcyBhbmQgUmVnYXJkcywNCk1hbmlrYW5kYW4gTS4NCg0K

