Return-Path: <linux-kernel+bounces-396442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372349BCD1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F11C21772
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F41D54E1;
	Tue,  5 Nov 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nrNxqK8W"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E21D54FE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811205; cv=fail; b=KFZcjiqk5RzWGtjpB+pDBMW1aIe+2YiOP4YiLBYHxt81W6JOdxLL/9EXu0/auRcv97J8ZmgTN+5jey/9Gpdzs3PkF3RlJh9sRgEQ30LzHGip7WG2ub9N9LLDVKCNBHvWSR8wcfhryOtDSEx6Msbyqz+ngKeWRHU4Sp76fNrxgeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811205; c=relaxed/simple;
	bh=S5UH3lZ29ENLA33J9Dplk13JG6k0e0QJ8NuarhtBaQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYk5GMdC3ZztK7hkq7sUyLj54uYEuOoe2SXy0IQyaZPeinBJcjawCgrp6SruGxIPKyFoi4scgIOrm0WpV4xGjCT7xpYNo7O8ZKJT6tg3t9/9zk96Pv+WXZvvPgrCmha4rg6j0fwLfd9pJQ2UjBqtUmOdMNl7qzIUiDrgEyqBRdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nrNxqK8W; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXMzU126qgY+0FRr8Wo94oh2klujqemDDqRnJVeLcSLImte/1hJl6S6N4lEVIUeqXfWY8Rbn54JpDk0utscUpIWI6tQY7K6syBOFz1Fu72kZzAbThH0hW0exHsFh6P4JvYmpqkRcH8Lv+hhCM8q/bHJUgXTWKZ2iOIkT4ijt2LmimJ1Rg9uh5oka7fab1W6U5DABgrEQEH1C8KdABiI0r8/ZF2pa2Cveprk8MpFaTTdaBmSGDmvU4zS4XVeIfFdGnYGbSXPK0e7swfO17HafTlWseeh9bMknvu78FhPKh0MUmKq3b6tuN6fvK/IObsLCZerSDm0J2NBGGcEizBNBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5UH3lZ29ENLA33J9Dplk13JG6k0e0QJ8NuarhtBaQQ=;
 b=MW4gKgDXso/VxFZ09HqC51TwbED8A6ppRxnAlapyuAlpCwQndqGL4WvRidpg7Ad9ciVVOOJ0MD7Fejn1zSMfWceq6osK0Gr2se6GtbiLclFL1w4uGmrd4/OrVthDx09uI8ZsxJvxbfTt32YdyktFOCM7WGJojzVccg2hz5oSOS2/adr2AK7JFoxRVBPdTiwAKcEU7eEOOckl5vpsnZi9sxLltHMi3qwUItnkzkpIzEsV0uozIuqYAY9FYFo0hQiS9SXggVkGztzqkBIH8zBj2V8cEgNxJzF6rhZc0gnNX2f5dmftUv+TAVFFkV/stcdzdyVBdwmT1vbk1RjBblRmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5UH3lZ29ENLA33J9Dplk13JG6k0e0QJ8NuarhtBaQQ=;
 b=nrNxqK8WRxM97/zaidehSG5vNjCGFtGa/0SDryEIQFy9CiHwoqNIO2m8qwiedp6Idj6XbcczXLyCEMXti4TDqEty3fgBPRz3ZGrSUb5rLcZFJAhD7J7Op8eGNEowF4V0lNOpM+IGsEkzxhihEaSFsFndGHyOJ6a9TDxtd+IQjsVgBUBFJ2cc04t7wu471Uv2EH5TVFtUH9npXRKg8GfSKGMmRlX3b+YC/ZN8MnSIwuQoM9Nto6PHjv7FZLTnWVOPZAlDgK9n6Girunxi/5fybddIKbnuXpaexgjAzhB6OAWM2AmI2ho3e64K9+Ov3ECKwdF7SHTh5bpNPJp2mS51Ag==
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by SJ0PR11MB4895.namprd11.prod.outlook.com (2603:10b6:a03:2de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Tue, 5 Nov
 2024 12:53:19 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 12:53:18 +0000
From: <Hari.PrasathGE@microchip.com>
To: <robh@kernel.org>, <claudiu.beznea@tuxon.dev>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: atmel-ssc: Use of_property_present() for
 non-boolean properties
Thread-Topic: [PATCH] misc: atmel-ssc: Use of_property_present() for
 non-boolean properties
Thread-Index: AQHbLu30J7W8bhoYLUGt+cd6b4/UE7KopYGA
Date: Tue, 5 Nov 2024 12:53:18 +0000
Message-ID: <4b297a3e-d59e-4768-b482-8ed15d79c220@microchip.com>
References: <20241104190700.275573-1-robh@kernel.org>
In-Reply-To: <20241104190700.275573-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|SJ0PR11MB4895:EE_
x-ms-office365-filtering-correlation-id: 8d132dc3-12ab-44b0-9cde-08dcfd98d281
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWFJQnJyQko5Y0lmcDA3czc0N0UxRVlqL2hhNWJzWVFKMDhyVmYyOGs4b2ho?=
 =?utf-8?B?SlJQdlNIVFdqcElDWWdPVTZUSWtuc2RuV3ZwbVpENEloTHRucUpJT2l0a0NY?=
 =?utf-8?B?Mm05Y3pYZjVaSFNCR2I5VU90UWUrUEgyZ2dnSGc5eVFua0FaZnlCd3BwNkJU?=
 =?utf-8?B?Z2FLbnY2VVcvdGxaUTcxSkhQanowUUtYME9LU3F1cENmVU55dTkrRTluekVw?=
 =?utf-8?B?OTVNR3VEQkMxV3dBTDgzc0ErWWdoejh6SzFIMXpYUkt4M2dabkdFZDd4ZnIz?=
 =?utf-8?B?NWlXcUJJOUxFMTArZWJiZmEwdXQ4ckpUZENFZURCN01KaEVYU0pIdTlRU1RK?=
 =?utf-8?B?UitJUFdiVnRacDJkcC8vSDY0N1FYYlI2R1VENW9QY3p2WCtiYWFuTDNvUnI2?=
 =?utf-8?B?aVMxUERubkF2MDVPVzN6Q0dUY2kycEl3WTkxSkozN21wRjhncml1UHVORVph?=
 =?utf-8?B?TC90RHFLNzJWSjhqaXlwYVkrOVpIYUQrVit6MzllZkpCZlJtTklxekxnQkJn?=
 =?utf-8?B?TnNuRmpMdGVqL09LVmZUWGlQMGRuckhaNXBpWUMxMGFTc1NCd010UVdYWU9T?=
 =?utf-8?B?cXJjUEJzN1FTSHdyTTVlbHVCN25UUXUzK3ZZOTM4V3pyVVFkeXVJYkJLVHRm?=
 =?utf-8?B?SERwbEsxdUVOalB1SXVoMWVYNVFPc0ROZnhPUTR5ZlpSSnIrUWMzU0t0RDgv?=
 =?utf-8?B?NXJ5ZTBiN096b1dMRDJvbzM5VEt0TjNnS1pRYm9xdXlPZGphU3o2aFI4dFR2?=
 =?utf-8?B?aGtDQnhIWlY5VmVwRGdvVVd5dFVPQkk0WHVZWUt2WGN3Q3h6RHJGZWw2dStK?=
 =?utf-8?B?WFlqRnY4VWJOWDRoZG1WZ0FGUlVRNE1DN3JZMWtMQUs1eUQyQ2x1SG5iZWxz?=
 =?utf-8?B?YVZYL2twNGdITVdqaEQwdkhOVUpxSHJ5dGF0eHp5UlJFNjNpV0QveG1UbTJt?=
 =?utf-8?B?bTZWK2dCaTRpczNZV2lKSVA1UWg0ZXo2dDQ5Y05vOHlpRTJqOFIzeXFXemk0?=
 =?utf-8?B?Z1lKVm1kN0JPTkVZK1J6SjFhTDB2bVRWRTdHQ3E1MHBMbjdhNkE3ZXBBeXFS?=
 =?utf-8?B?bVIzQ250ZkRWWHZHUWFzRUdtM29lOVFHMkVzN1V6OElSSURaOEhxUUhuM0NU?=
 =?utf-8?B?dkZFVHhFaFJwc2lJMHp3d0hnN08rck8xbW4wa0pwWG0wTnhqQlZheXFpT0ww?=
 =?utf-8?B?bmU1ZzJlLzRONS9qZ3d4ZzZMYmZvM1JvU0VqZzJrUmRGeWtWQlM1S095NzYv?=
 =?utf-8?B?ZVRsUkZETXR3S0J3WWhQVUtnWXprdnYycVhQVGNYZXRoMWdIMUNoMENtK2Jo?=
 =?utf-8?B?VG1JZFZSckp4MWJQc3JTWVJBam1MWjdjcHkwY010dWV3MTRnNGFPb2hwVmFn?=
 =?utf-8?B?TXdXMGd6WjFneThPbytiY1ZVOWdIMVVjRUlHTW5PRjRuT3N5SHJDOXlqeERr?=
 =?utf-8?B?MEg4alFQdTMxVXN6dkdTNE9mQmQyTGgvWUc2WWVPWkZkSzBicXFqaTZCUVBr?=
 =?utf-8?B?ZGNPS3RNNVFJcmg1eUhWMnV6VlYrODM0cXNzZUlhWEVJVG40bHlUT3lHR0RD?=
 =?utf-8?B?UmliWmhlaDJXUDVxTmZQTWpJeGp5ZVRxbzhialdaUWRON1pkb2QvZ1BWNEJ3?=
 =?utf-8?B?ZWJZVDErRVI4REQ0V2h2eWNteEZkeVZDZVAvU2JmNldyM1N4R3ZndmJrZld0?=
 =?utf-8?B?VmQ3RUZMc3p2RGZaUXNkVURvQzREaXpnRHZMVDYvaG96dXB6RG04SHdzQ2VT?=
 =?utf-8?B?YkdCWTFpaHA5ZjZ5dlg0UHVUVnMyN1VWVmRvZFJvQVdWS1JONWs0UVYxd3I1?=
 =?utf-8?Q?SL8OG327/dNyJ2QcVdcxZhKBoGWwq3iLhjJr0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkpMMVF4M2E3RHc0L1Z3aFlwWlZicmVyWWpWOFU3RTRkTlpsWEtVMG84T1Ba?=
 =?utf-8?B?MkR0QlU4ZVpYOEFjb0k0aXcxeis2TVNvSEMyV1FnRDNkSzVOb2Nja1RXUzhj?=
 =?utf-8?B?WlJiU1ZPVkZENHlKY3U4dDJqaUgrQ1VCYkZ6cW5abXlMYW92NUN3cmlqbzRW?=
 =?utf-8?B?MmhCUG1xcFBhU0dIcUJDWDZOYWVIL1R5V1AvazlWZ1dFSzNBeGgrSHh5bGdn?=
 =?utf-8?B?MXNSQkJaMkFuejAxcjlsbko4SjZNalVpK2hQTzBQQVJGYktweTJnN2FTN0tW?=
 =?utf-8?B?VWFOMHJyYXIxcTVoRHVJZ1VIcnUwNERvMXlPTGoyQWU4NUtPS29uZEs2cU1R?=
 =?utf-8?B?VjF0OUZNSk5sNzNpREFkby9UNVoxai9ISDMyZmZsMFkvTmdqcUFMMWVUbXJp?=
 =?utf-8?B?S1hLU0Z5bjVZSEFMT3ZlODl6OWg3WUZsV0pkVDdXb3ppRzNERGZyOWcxMURU?=
 =?utf-8?B?dDBmc3BMOE5vOTVmOU1FaUZjTVc2RTFDcnkyVUJYV2FGMzBLYW1LL2pxRHYr?=
 =?utf-8?B?RGRVMkdHTFQ5cmhERExpSXB6aVNFZTNLTFJFUkNOZmhkelA3MmdCWTZXQ1ZP?=
 =?utf-8?B?UEZMQm5mdkVvTnZSTWllUENEYlpCQ3ArWU14cFd3aEpqWjY4bG5xNUExRmk0?=
 =?utf-8?B?a0RVTFJ5dzVHdHhaaWdBMmlOY1BaK3VYVUgvaUdzdVg3Yi9MV2lSbFhwanl0?=
 =?utf-8?B?Mk0yYlh1ZzRtWXpJa29YSG4ySVorekxoSUlpZlNROTZXUGtDaGloZXcwdzVl?=
 =?utf-8?B?TXVQbEJIbVFDR0FVdnJhMnlHejRQeEFvRVBnTFFzb0RhdU82WmNXRi8zaitz?=
 =?utf-8?B?MStNcEhqdTdsT3VsTStJdWRLZk1GSzNxYjJvaUtwb29mcDZTeTd1QWhYL2Vk?=
 =?utf-8?B?aTU3cGFQRHRIcnd0R0NZQ2xtbW5XTldhMmtxRG1USTM3U3NWbnpxRnlGUE5o?=
 =?utf-8?B?a0JnMlhrdXZRNVVxWnRaaFpvY2xLWkZsbzdCZVZVZUJRalErVy9ueWVKc3BU?=
 =?utf-8?B?OEFHdUhKY0tQS1VRTFpoMS9HMXF5MnVTYzJ2TUs2MWEvM29UZ0RzbkprZGV5?=
 =?utf-8?B?RGFEMmI2UDZwMmhUNW1kTkNFRzR6dVozQmZ3K2Q2TCsvVmZnYVczVDUrTzlW?=
 =?utf-8?B?VDFCOERTUCtQK09tdUNUb1hJNk5YU0xoRGdnT1VwZWIvWlR1VTdyWGsyMzlO?=
 =?utf-8?B?WXcxcUhqalFOTFprSnp4MFB0Q0xTMUJyU21WRi9TOWtVM29KNUdyeDE2dFBv?=
 =?utf-8?B?VWJ4TWRSYVFOUXRYaVdjSkVWVmRNMkZISEc2YVg3QkhhNjJNS2JFT1VKYkI0?=
 =?utf-8?B?KyttMEl3UkxpbWpON3BmVnlNWXZtRDZFN2VTbTkrcSsvMncyLytGWlVuVitJ?=
 =?utf-8?B?eDhkd0UxeVRhMjlldUhUN3ptUFpUbWVTVmJQU3c2RkxRNlhDTUFCa3NoMzdv?=
 =?utf-8?B?QkpyUmxnSkovaWJXbnFCTFl2aTVET0pjeWZoeFZ1T09zM1ZTQkl5L1FsUmQ5?=
 =?utf-8?B?M3JiN2p5aDFzQVZhQ095dFBxcVlFSkdFck5wbmpzQmVsWG02ai82UUYyT0N6?=
 =?utf-8?B?azNpZ2RKaC8vd0ZPa1ZKTDdOVnM3NGtlQllXeHpGaE9LTS9VMUl4QmRmbHhZ?=
 =?utf-8?B?Q3Y5RGI5UGp3TXdhUHRNVVhTa3JpeG1hanphUlZPcWd4VnZTdUNuNnBLZUFB?=
 =?utf-8?B?bFozWThJaVJzOUs4dGdKN1JIYTByV3hMMDV0V2NqMDZXSytLaUZORzlNR1pZ?=
 =?utf-8?B?QWY4U1F5RjZpNWhMM0d6S3lvUDZ4U0lSQ0hrekt1cXJMTXVyZmdjdjhsYUpt?=
 =?utf-8?B?OWhRVjF5QmIxMGF2dG1KY3pwUmlEV3hsY3JybnNnSHhuRm5GYXpKWE9mNXRl?=
 =?utf-8?B?OW9wdjEvNnhVcUpadHNmcEZ4QnVrY2hZQjEyM0dYS0libDY4a2JZVm1QekRI?=
 =?utf-8?B?N0ZIMXhhbENOaXpZMWJkOFZ3WjBSN1RkTlpScjQyWXRiVWI3dU5wQlNnSHBW?=
 =?utf-8?B?aWtoaXhVT3o3NWFLeGRQdVNINEFvWmlSUUoycFAzMjFUSUFQOHEzQVFvbUYz?=
 =?utf-8?B?WjMza0dQQkNKYnI2MVIwZjdlcy9Wc0t4bHN3Z0pMRDNEY2J3bFNFb2pPTGR4?=
 =?utf-8?B?eGZjMUdhY3Z3SFJXT2RjUzJBa2ZXdWpneG92SVBCT0tNOC9WVUxCUkFXbWF6?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22149EA438969442A9D97D8E92264ADD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d132dc3-12ab-44b0-9cde-08dcfd98d281
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 12:53:18.8274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w55EvOq0/V5bH2pNUo8qCjzpXJeipIB5k8O3YplM8MmRP6cbBtdNcRVsSFw+6PTZGZizkC15nW4vh8+W+iGm/wrE+WEKpVg6DJesbmplCUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4895

DQoNCk9uIDExLzUvMjQgMTI6MzYgQU0sIFJvYiBIZXJyaW5nIChBcm0pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSB1c2Ugb2Ygb2ZfcHJvcGVy
dHlfcmVhZF9ib29sKCkgZm9yIG5vbi1ib29sZWFuIHByb3BlcnRpZXMgaXMNCj4gZGVwcmVjYXRl
ZCBpbiBmYXZvciBvZiBvZl9wcm9wZXJ0eV9wcmVzZW50KCkgd2hlbiB0ZXN0aW5nIGZvciBwcm9w
ZXJ0eQ0KPiBwcmVzZW5jZS4NCj4gDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KDQpSZXZp
ZXdlZC1ieTogSGFyaSBQcmFzYXRoIEd1anVsYW4gRWxhbmdvIDxoYXJpLnByYXNhdGhnZUBtaWNy
b2NoaXAuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IFJvYiBIZXJyaW5nIChBcm0pIDxyb2JoQGtl
cm5lbC5vcmc+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbWlzYy9hdG1lbC1zc2MuYyB8IDQgKystLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2F0bWVsLXNzYy5jIGIvZHJpdmVycy9taXNjL2F0
bWVsLXNzYy5jDQo+IGluZGV4IDZlYWMwZjMzNTkxNS4uMWQwMzIyZGZhZjc5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL21pc2MvYXRtZWwtc3NjLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL2F0bWVs
LXNzYy5jDQo+IEBAIC0xNTMsNyArMTUzLDcgQEAgc3RhdGljIGludCBzc2Nfc291bmRfZGFpX3By
b2JlKHN0cnVjdCBzc2NfZGV2aWNlICpzc2MpDQo+IA0KPiAgICAgICAgICBzc2MtPnNvdW5kX2Rh
aSA9IGZhbHNlOw0KPiANCj4gLSAgICAgICBpZiAoIW9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwg
IiNzb3VuZC1kYWktY2VsbHMiKSkNCj4gKyAgICAgICBpZiAoIW9mX3Byb3BlcnR5X3ByZXNlbnQo
bnAsICIjc291bmQtZGFpLWNlbGxzIikpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
IA0KPiAgICAgICAgICBpZCA9IG9mX2FsaWFzX2dldF9pZChucCwgInNzYyIpOw0KPiBAQCAtMTc2
LDcgKzE3Niw3IEBAIHN0YXRpYyB2b2lkIHNzY19zb3VuZF9kYWlfcmVtb3ZlKHN0cnVjdCBzc2Nf
ZGV2aWNlICpzc2MpDQo+ICAgI2Vsc2UNCj4gICBzdGF0aWMgaW5saW5lIGludCBzc2Nfc291bmRf
ZGFpX3Byb2JlKHN0cnVjdCBzc2NfZGV2aWNlICpzc2MpDQo+ICAgew0KPiAtICAgICAgIGlmIChv
Zl9wcm9wZXJ0eV9yZWFkX2Jvb2woc3NjLT5wZGV2LT5kZXYub2Zfbm9kZSwgIiNzb3VuZC1kYWkt
Y2VsbHMiKSkNCj4gKyAgICAgICBpZiAob2ZfcHJvcGVydHlfcHJlc2VudChzc2MtPnBkZXYtPmRl
di5vZl9ub2RlLCAiI3NvdW5kLWRhaS1jZWxscyIpKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVy
biAtRU5PVFNVUFA7DQo+IA0KPiAgICAgICAgICByZXR1cm4gMDsNCj4gLS0NCj4gMi40NS4yDQo+
IA0KPiANCg==

