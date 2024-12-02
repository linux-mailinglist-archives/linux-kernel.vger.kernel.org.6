Return-Path: <linux-kernel+bounces-427073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E159DFBF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5467E281BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E941F9A92;
	Mon,  2 Dec 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nyGd1eoJ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577A13635B;
	Mon,  2 Dec 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128382; cv=fail; b=GBq88mk0TFNGWKrzqmgty5GQGQcBvm/O3ukpXgQWFM7bx79Gi0izJsKIWdE88dzQ/d9tAehSYEBEIap0ZQ/N7hu9SZ6l8ztIpXPJstphlt6N3eECyDbc6KWogbrCv6rzhzmglq8e4l7k2JJ0t0Sx0I+9ejp0KdqDAQQ9Be+jwTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128382; c=relaxed/simple;
	bh=plvEi4oCtKqX8QXmQ6xcdKzdm+Sz7g5Y6l/F5b0YRkQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AxP0rSng0NxU/SBqhR1Ar8ApaScS+jKehv/biUqvfAJGTOrRuhMTpULM8UfIR5Sy5H3s88EFfxMLBd+gqefKck5VqY0CA0sy0SzkQlgZ7C4Z3aZUlaqGqSRfrrmgIWIITv78OuJN5EuMrgYQHgOQXOncAZkQngZSDvpM2/rsrZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nyGd1eoJ; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHd6ynR0ukTrtP4mtF2ZWQyw0tXSKg8xQy0tkp2ripCY+BttYAJxWPaPiV4PWeIwh2NUuXUXER+hOfp8vj06bSMBgelyuoGFnC5oZmjyMpqoXEhspDcYIpRK688L8DaIPQxMV2TTpqcvli0cwBdeMvJiPL2yu5FIgaSVp5PY3WX73R9cVxGXagTkjrmiLfFh13oSUICL3J7bFzorCDiySzCYKxcsjpxB1AY4hLqzRyckxkIByAzp/D2lAUT9ttK9mlj2FrUPgZJYzshvIfUQmKEdKsdGcB83GydIMcswm6nrumxqDseVzmv2QHnR4m23vNDe5dIGMZTJ+C5HTYOG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plvEi4oCtKqX8QXmQ6xcdKzdm+Sz7g5Y6l/F5b0YRkQ=;
 b=bPHt7m98u2KrY8EK3v1LBA8nHe/GpiIbYddx/FMsKBsOYaccfp/ddHS7G5YNsv4mvzy4u11aqEav2Xl7nrrWkHa0fsrq1b7xZPn7d0yhugWOoJtSEKBqLsLhcUbv6Vgi/QNkZ5oKLvbbwKZlHc1l6WKeS5G6yg7xLLtJvFlSZrwJmtwhVzdmbhroR5CYswrtxCicGBm1IcQSt3U3fjfTZZGPAFJ3GNXEj6epOybCxqNz8x5BGvFLCkd2hBH3kIZbX7UqXUysz2UXPPd298JufcEyR/Y8k6Z4ihmx9Ju8F9C2BOd5gZgDZ5tYltodGQoTdnuS1/ZkqOZKU+Ekfm1dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plvEi4oCtKqX8QXmQ6xcdKzdm+Sz7g5Y6l/F5b0YRkQ=;
 b=nyGd1eoJW8y494+opx16Ej7r+IVYtFMaavBQW1kRpvELbTUcNSipMHST6GfWoD2Rzcpi1fw9G8czZ4MJiOzEwoUysq13+oUfB5d3X129UUS/ceO4XSIsYRDlh1D5g1M8lsR3Jinfg6uf+fiXiZ7n2kYfsnzLWATt4rq+3LpNtCe8SfsSuQMLj2kITHlvQBjQCjXTFkoWVJNSpBYUuf2Os0sSGqUCbs3/srxk+j22/WO5UUz+m82wcbYLqrOIgn4H8fSF5wFMDWZnHaQ8+n/OzKfawlXugtBDVrf23+7EePz122/ZHoYtkhoH3elPIb8ZjoOoK4GkEWNvcWJ+RovLJg==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 08:32:54 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 08:32:53 +0000
From: <Mihai.Sain@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power
 monitor support
Thread-Topic: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power
 monitor support
Thread-Index: AQHbPLVlL5R94FkZFUuD/5fCO/yderLSqvuAgAAERgA=
Date: Mon, 2 Dec 2024 08:32:53 +0000
Message-ID:
 <PH8PR11MB68043702680864433060E9B482352@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20241122080523.3941-1-mihai.sain@microchip.com>
 <20241122080523.3941-3-mihai.sain@microchip.com>
 <2d8dd1c8-fd4b-4dc1-ba62-312ac86335a6@tuxon.dev>
In-Reply-To: <2d8dd1c8-fd4b-4dc1-ba62-312ac86335a6@tuxon.dev>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CY8PR11MB7057:EE_
x-ms-office365-filtering-correlation-id: d2e072c3-a8a1-4806-6cf3-08dd12abea6d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1JydXdrUG5FRmNaNjhseldTM1lUMnQrbCtCRjBFcTRwa01mR3llQTFuK3FW?=
 =?utf-8?B?eEJaM1FWTkVFdDZZM0M2aHpIZWNOR2hlU0FOSnF6QU41S0xJcWxKYzh6Nldi?=
 =?utf-8?B?OUl1aXdkRk9Uai9WamRBbUxqMklyWVJTK2NOM3JjTHVNMVBDSjVwYmsxSHZT?=
 =?utf-8?B?NFJ3Y2FNZE53a2dXRHlQUHdGYnBpMUQvd2tEaHNVSEg4WUVYYTRtK3F0Vm9y?=
 =?utf-8?B?bDFZVjQxNGI3ZEJqYU9VTnp6cUx0MVYxRnphSzNnUGQ4WGRpMXN0VVNYMnR6?=
 =?utf-8?B?OE5GM1F5RldVMEdJT3dQdU1Fc2JxdDRObkQzWmFlaFdKSjJXYVlXUVp6bTAy?=
 =?utf-8?B?RjVEM3VuNHZPM2FlLzBPRzVRWDhjdzNLc0hvZkUyeXRJWi9MSW9VY2hVNkl2?=
 =?utf-8?B?VDg5NmFCVDc0SHZnRHd6NFVGOG40RmNDcUhYeDJXMzllREJyWmM1elJoUkd1?=
 =?utf-8?B?OTd6OVB5K3IyNXVBeExwUk1GNUk1dWZFT0F6Uk1xdE9OWWo0L25SSk9QNjl4?=
 =?utf-8?B?amJHWFVLKzFCMEZlVUlWVk1rUE5tNjQ3RkJnYUZxZUplVWdwbFlLUXozNzZJ?=
 =?utf-8?B?eElFSHp0OEpRc2RTSkNKWnFKNU5HR1UwN0JtQjEvK20yR051d3p5NFlkbkVy?=
 =?utf-8?B?QkFxYXVJdUhkWUpkZzVMaUNqRCt5VWpPTjdzQWNOc25KYjYyakwxcW1YUVh5?=
 =?utf-8?B?RDQ2SURORStxU0p0R2FCOUhmVXo2SVlhRVA5Zmx0WWRPa3RmMVI2UHloZHly?=
 =?utf-8?B?bDRQZzVuWUxVWkY1cjJTemhEemZyT1BSZnAraVJzbSs3SU9FTEVKNm9BVG5V?=
 =?utf-8?B?NnF2OVNITERMdGd3ZU5Jd2pWOVJDbTI5K3JUVGV4WkpobXkzeW5Jb0loRjhm?=
 =?utf-8?B?KzFUQlQ1UE4vVHMwb1BBclZNUUcxTlpXWHJmUnhrRTVaRDRJMnFCU3Q1M3RU?=
 =?utf-8?B?VHMvZEFvZjlHeUJydE1HZUExQTdZWFBuc3pKc25KWHl3bUtoSjhEQjB4UFd3?=
 =?utf-8?B?Q2EwZ1ppMW9aZFE5NHlBdWJDQjZvNDVDbGoya3dWdlVoNDNQcm5qazdFSkRm?=
 =?utf-8?B?N1pYTjMzWFlBQUpyUDBkZnJZRXdQdm5McW0vU2ZMdjI0R0FJb2lzM3lWZXRY?=
 =?utf-8?B?SEtCNklaaXFZRFRJQW56ajlpaklZRDRUbisvMkRTSFYvZmt6VW05RmlScHlM?=
 =?utf-8?B?Wkd1NjhJcXg5L2tDd3JERUxKTHc2SktXVUJzSkw4ME4wT3RFOGlLeVRHYlNm?=
 =?utf-8?B?aldZV0FBOXVNQWd5RkpvK2FRZytvSTJvWjRRWFBzREpPWGVRUUxCSW9ESS9t?=
 =?utf-8?B?SkNnTFJHQWR6dWUxR1h3d1ZtT2tZNE9XUWVFM1J6UnpHUllvR3VzdzRGYzVE?=
 =?utf-8?B?MDMrS011NzFsZStTSVpvQys3aVZBUll0VlNQcWUrUVpqYW45TUxoUnQ2QXFI?=
 =?utf-8?B?bG9ERDVJUW9WSmpKZlVKSGE0Q0dYM294Q3dmWkFSeklGcTYwS3V3Y0NhVndL?=
 =?utf-8?B?WC9DQTlkQ2dCWTNjaEd1S01uZllwcm5hWi9aUjBlMEI5MWtOa2pQQzhMUlJ3?=
 =?utf-8?B?UjJUdCtuZkZUTjhqdnFUTW85SmFYS2JFdHZIQUdNYndscExYTmcveERiVk4v?=
 =?utf-8?B?Q2JqQUNvNE1EUEFmQWJFeG1FUHZ1TXg2QzhrdzEwOGE5NTJhUkpWMVVPQWo3?=
 =?utf-8?B?ekRnWFozeVFuc2EyenRWNzhtWS9sVnFYUjZNNDA1OGZLQUVhTkUvM0ZhQjFG?=
 =?utf-8?B?M0hFeHd1amowZlZ1ZWRiRG4zTVlEeHNpSWVvNGw4WUNnK1lYdUZlMHM2TnBr?=
 =?utf-8?B?SjZzd0hUSTlrcEVjaVhnSlp1WTE2TFZKZDIySjZyaTBJcmJ4dmE2TmU1WHJv?=
 =?utf-8?B?ck45aTVxMlJmSUR5Y1Q0OEhLUVdmNWlUS2lSa0QxSGJNSUE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTFMOHdDSWsycnd4Mk5tdVVzWDRORnhEeFkwTHRST1VHR3N2QU5aRkd6RFBw?=
 =?utf-8?B?Y1RHQU9BSlNlcjFSOEYyeVlzRGttZzk0TDRkekJ6S3Nha0RYVDQwM1hMQzNt?=
 =?utf-8?B?ekZPUmFBM2hFZHNFeUtGeEtNVWlWOGpUR1pvT3FHdXoyVEhnOXhKdU5YMUJk?=
 =?utf-8?B?YnFWS0R6aCtPNVBic1lRTGR4TS9kZW1FSHYxWnJzdDdsZjNMam9yZEVFWVN1?=
 =?utf-8?B?dXNUZUxVNUdnWisyV3doV0NHdTdjUXZzWCtka0lnWDVxckhpYXE1aXlSaGJV?=
 =?utf-8?B?V2dNcXllT0FTNUk0dVhHM0tFUzNwSitaWFdlNjQ2QkJEYzJ3SDlvYVF2S2g3?=
 =?utf-8?B?V2pLTHBGMFd5Mmt4djA5OGQwTDJ0Umlub01GOVVaQVc0Q2pXaG1mcmhmdXFZ?=
 =?utf-8?B?ZndOSVlHV1J0YnYxUzU1QVpuc2pNdlQ4dUJJa01HQ1ZnSTNJTlhNWXRISkhJ?=
 =?utf-8?B?QzRjbzVwdEtFa1hjWWJCTXhXUFkrZURYTkpRaEgzMHFWMTRDY1dDajhlbGJ6?=
 =?utf-8?B?YkRPM29kWHpwMm1iYkdvbTdvaC9KZDlxSUNaZWRnamNpck1zOVlVY0laOEYx?=
 =?utf-8?B?bCtzZ3JSQnp6WjVydXU4SjdHWi81ZTZCdEdUOUZqbFgwMVRkL3VLekU4WG95?=
 =?utf-8?B?d3VCUFNJRzh5OTVQdG8vUytyZitPb2xwR09NVkh3cWtkemFFd3VyaGU3cEJq?=
 =?utf-8?B?V3d0V1dOZno5LzlRS0ZsZ2ZwVVpyNDBSdHJkRldqdW9tcVFsWktRakZrcHU2?=
 =?utf-8?B?WTBZUmkvMDlZME5DQTNSNEFtR1B4V3EwQUdoTy9QOWZhVTNKMGRvTWkyZ3lo?=
 =?utf-8?B?dE5vNFVkVEIybURPQ1VRRDQxVTFmSDNzdnYwRlZrVDFVZ3Nwc3N1czBKNENv?=
 =?utf-8?B?T056RHJkd1VsRVpGY2ROUDUzT2VvWGROanppK25BbzRQREdhcTVzYzY3TWJU?=
 =?utf-8?B?ZlRXOW1UbTRhM1VucGxXTndwOHE1T2NxSlBndm5vMUNSU1JMUysvdk5SUXMz?=
 =?utf-8?B?TXYybWlIVUdZY3dNVFdSOWQ5ellhbzg5S2xFSWxONTFNdzFTYy9ZdzlzaWdY?=
 =?utf-8?B?RldwUHdsUGRSMld0SHJQajRIWFFDTVdGTk9tSmNYWk5paitjV08yT1VVRzda?=
 =?utf-8?B?RzAxSmk2K2lqd0gzWjFaSU94QnNjR3QxRGlOWDluTDhaYy9xWmtReElwbi9w?=
 =?utf-8?B?YlpzWU5wTXY4OGoyenVkcnJkQkQ0eDNtZzFCUVpMcWtFNVpqNy9LUFkvN3d4?=
 =?utf-8?B?RlorQTVyRFZOZkNjVDNmVStGbnRCNFJaYlg3d3JKNk9YVVBFTU5FRW94Q3Y0?=
 =?utf-8?B?ZnlDVEQvWVlETVZVc3liN1dUZUtmQS8zSGJlb1V1MVg1WVFDV3JXSzRYM2VI?=
 =?utf-8?B?dDVTWUpmd1crc29LcDNSYVRpMVF3ZEhBTjRQTk02ZFR6UUtmMG1XZlBCZkhz?=
 =?utf-8?B?a2Y2T2RMcmtBRGRERU81Ti8vZXUvNzdVY3dQU1QrK1NxbFFrZDU4RW9admxv?=
 =?utf-8?B?cy9MdTZ1a2ZveklvMGxjN3NheThidzdOaVp3ZHNrSFVWRTNPZ1FucWVyOUJv?=
 =?utf-8?B?em15TXVtdmRtL051L0NDRGNmQzE2cmp0c3IxaitScHB5YVdDN2JmTkpmd2hq?=
 =?utf-8?B?WlM1Tm0rTW8wMXNqK1ZiRXJSVDRBRFZyMUJDQ1JVNFRJVkZ5TDN2ZnExd3hp?=
 =?utf-8?B?Q01lZFlZcjQzQXZmbXJJeGdBVGhOamM1MFJ2Y1U2NFBWTWJ6V2NscitrRWh3?=
 =?utf-8?B?aWkrQjcwMzc5RW1id2RPeUVMWEVSaDlyNU1tclJuVEZzZlpCQVFTSFpyYnFF?=
 =?utf-8?B?UmRHb3lzQ3FIeW44dXZrakRCSjFKSG9WeTlFNUJzTUtkTkJOUU1VRFZ4YlV3?=
 =?utf-8?B?clFRWkM3cndsWXpaRlFYYVpoT2orTFpwWnRGQUdBb1RZVW5NREVNWGhReWkr?=
 =?utf-8?B?V0xHaVhZdFlWS0VsUlY4NHN2T09sZFJnUXhUdUJ5bjhSc3dwdElmc3BlWUpI?=
 =?utf-8?B?M0JiM21lYklNN1VYU0NRUEVHSTNiM0NoNkxIcU91bHFyNlpUbUVEUndHbFZt?=
 =?utf-8?B?aE1GQjlMVWdIb2htem1iSjdBQmsvWk8ydGF1bWViV3NFei8yN3pCa3plOXlu?=
 =?utf-8?Q?FlnyZEo4b5KR4HM9UaJBiZ/pV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e072c3-a8a1-4806-6cf3-08dd12abea6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 08:32:53.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQaqzHNQ370H86uors+P+MdgJiUMSFB3yUq/Ybf3bTdzmmL0JV1bU5mStaZWo0nwOTf7MKhUC10dpQZYmZB8UK7NMEpxLyb8/rPCe1mO3J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057

SGkgQ2xhdWRpdSwNCg0KPiA+ICsgICAgICAgICAgICAgY2hhbm5lbEAyIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4Mj47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNo
dW50LXJlc2lzdG9yLW1pY3JvLW9obXMgPSA8MTAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBsYWJlbCA9ICJWRERPVVQ0IjsNCj4gDQo+IE9uIHRoZSBzY2hlbWF0aWNzIGF0IFsxXSB0
aGlzIHNlZW1zIHRvIGJlIG5hbWVkIERDREM0LiBJcyB0aGVyZSBhIG1pc3Rha2Ugb24NCj4gWzFd
IG9yIHRoaXMgcGF0Y2ggbmVlZHMgYWRqdXN0bWVudHM/IElmIHNvLCBJIGNhbiBkbyBpdCB3aGls
ZSBhcHBseWluZy4NCg0KSSBqdXN0IHdhbnRlZCB0byB1c2UgYSBtb3JlIGZyaWVuZGx5IG5hbWUg
Zm9yIGJ1Y2s0LCBzaW5jZSB0aGlzIHJlZ3VsYXRvciBpcyBub3QgdXNlZC4NCg0KPiANCj4gVGhh
bmsgeW91LA0KPiBDbGF1ZGl1DQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly93dzEubWljcm9jaGlwLmNv
bS9kb3dubG9hZHMvYWVtRG9jdW1lbnRzL2RvY3VtZW50cy9NUFUzMi9Qcm9kdWN0RG9jdW1lbg0K
PiB0cy9Vc2VyR3VpZGVzL1NBTTlYNzUtQ3VyaW9zaXR5LVVzZXItR3VpZGUtRFM2MDAwMTg1OS5w
ZGYNCj4gDQoNClJlZ2FyZHMsDQpNaWhhaQ0K

