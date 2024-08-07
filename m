Return-Path: <linux-kernel+bounces-277472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F163E94A1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B91F28351
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747BD1C57AA;
	Wed,  7 Aug 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IIYeWptq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968F18D651;
	Wed,  7 Aug 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016158; cv=fail; b=uAC4OBUaB0fmP4fciLDWJz/zT+l6oKjKJq/1qhvPYT1jAvqFTA0Ycc+C/IVvSHtbR2dhdjhAuPeUffa2YUK4GIzXgv6KVzshvQSiJyLnMQXnDu5VfKizbAxMjBv0arB96UnAXdI7HfEtb6nCfkHMlD3v9ina4TxdzNYET/2AXkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016158; c=relaxed/simple;
	bh=jjNplifA1lV79A03xSfs7CbGLzs8ZCdCXF04zclOxN4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYttcbJzD5mgCRO0PNAy+VwSNCNDy/0Cq9ajjZXnUniwBe1weyyImJAclhzZHqWby3WeIpro/mGzIRmAM4CMfK/XRJcIfXhBX5U6ksUiWGbB8xL6VG030P5dtgHwUKO/1MEuBgWVFMBRPFEaDZtE2pjXrl0HVkT8IOeapOhS3zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IIYeWptq; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2324WEq8+7cDRwZfrj3ssG7b7ZbPG4tKSmQcE2swCSWqBIax8ag40wA0FDuXHf/1X8inFpnkmDYvj6Z5MAPXuG0JgbKmXAdh9Kdqr6gHk1aFToR3W0ci5W1dac0o6c7ME0Ssb2KMR//ViF51uaNrkDzR2mivJycV8SrPlPGIU167eTZXeu7PJHwcoTtYDPcKqHJ+AbJ/8L5xQVMZcLlh0F7szE2LdMrOLT/SfY7K18hO0qiDbZwfrAi03RBZLBXsWmKDo2sIEGvaOrJPh3jOjXlnr3JOMAOrpNKJAG6Jm9SemjDUDjmFeZEXkFVhN+uQtx6JWezvA1HbDgWbOR/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjNplifA1lV79A03xSfs7CbGLzs8ZCdCXF04zclOxN4=;
 b=GNT28wFcSanEu5qHD1zK6c4o331SxsgWDDpLpDkQWmid7KQSPOoQen3YrAUoBbNVcxnxEjrhK8ABbKMUx0iD7CXFtewAEZPTfV68avU9r1svvIXc4D2dD6VnRjSJkuReQh2HR1nwQZqm9qHACYb7Vk7pYaHm8BWrBh6L96MfLt1Sb+aQgveIcBZ1wW6qfda+ZjujgNOZiVfvwF/hrbfOB6eG3RqtoOjbN4/qNa4sXzbfpaC4ERKOrnkiP7/NfZKa6LaMLsWN+Ofimqzv8tYhpzjBWuDQxJJ0R5uXKHYWWgho8L95xm6rNIHFEw3cJoqijrHv9mvHJRiOAQcWu3TbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjNplifA1lV79A03xSfs7CbGLzs8ZCdCXF04zclOxN4=;
 b=IIYeWptq2qq7A6NbTRIxZkN+cMunGN8kfjb9icZeb/14vfQdx/jT75eVTqTkGcTbotT/PurAkSZLyAfM+RiFutYoLVOcDjIRoSBKJudI96a/ycEF3EO2bi5rfKN6oRdHebl9BrdizXv5eZG4yZ99eYvxZhEPJUFoGgC7lRBcSCFMSFvEPS1XQOIjIhXj3m3oZnQHnyIbfutaBN0JSlAk0ZfhAhjZNVftsB8AhKG4oYykIGI3pIarQQIW88szNLsHWezmR7Cn1Xu+IEmS/2yzxnQZwKEKS89fEWYcIl38HGkp3fwrz1YmcHYzN7npmWUkHinpCej/eDFDnNDSjZ9UJw==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:35:52 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 07:35:52 +0000
From: <Andrei.Simion@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Topic: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Index: AQHa5LhEn97L1tgXxECJyG0oBvR81bIT7XGAgAAYs4CAADuWgIAHLbMA
Date: Wed, 7 Aug 2024 07:35:52 +0000
Message-ID: <6c1a1bf6-fb9a-4dda-9777-6749fe333d03@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
 <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
 <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
 <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
In-Reply-To: <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|PH7PR11MB6476:EE_
x-ms-office365-filtering-correlation-id: e1f3501f-07a4-427b-9de3-08dcb6b390ab
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2l4OFpxTGNnWllpTm5LRXByNSt2OUFtT1lqaTJ2c1VJcHptd2cvNnlNSU1H?=
 =?utf-8?B?c0hkMXRjVW5YVEdrZ3I4cXRiVXVGRzRFdXN4dVBaemF3ZVFXbUtMTDBPOTR3?=
 =?utf-8?B?cXlVbTNvbHNzbi9rSEpkVGwyUjhyNGZMeDhJN1Qrc2VnQ0paQ3o1K3RXYnBn?=
 =?utf-8?B?RU9OdGJUREtkeS94SEc0aGo4OU4vQmRSbWZ4dFFBWnhxTUw5SmQvNTJ3cE9V?=
 =?utf-8?B?K09aNUgxaDZPMlJSWVY2bE9oZmlET1VoVGQxV1N6U2NKTnoyRE9yTk02SHA2?=
 =?utf-8?B?OEVaVUxGSkFnWTloOVJhd0VQeWFQZkJ2Z010cTR6bjBtaE9GZzg2Z2JHdnZK?=
 =?utf-8?B?RlV0MHlzcVhaTHBlRDlPY2t6NWl6NXNDbG0wMVZXbzRhOWVSeEJyeng1UXpw?=
 =?utf-8?B?WG1mVHFjQ2FxUEs5OXB5MUljd1dnb3pKYzIxYjVlVlhRdnNha1IxUi9DL1FS?=
 =?utf-8?B?dng5Sy9VVE9jTkdpQXZwT3o5a2lZNWR6YzFsRmgrOWNwS2l1VjNPeFZIaVVV?=
 =?utf-8?B?UEErUTd4aDRJUGw2NDVaVkkrbW9mLzBpWFR5MXMvdlZBaS9tblRObEhvVUVS?=
 =?utf-8?B?U3QxaFVRdzZPWkJ0Z0orWmQxdTljS3h4VHZhNG14Sm83VEEvUHF3TTRRNklO?=
 =?utf-8?B?Z3BaYkN4UEczUG9IWmVkWHRpSjJGTXRlMW55c09zbU1rZ3k5WFFoeE5WOXhp?=
 =?utf-8?B?a3FUMmVacmhsUkc2ejhVZktnNEFpbGI3bXdrM2JuK2M4SWNPVUtudHRUcnFW?=
 =?utf-8?B?TGxxZVYra0pKb3Y0Y0RSdHg5cEF3cDJiVXE1T1FtNGZKNU9BU05hcm9qN044?=
 =?utf-8?B?OFFSVnBHT1lCQ1A4TlRlNUVxMHRNTVl5L2hXMCtHV2hlRjVncS9JWWJBaDVJ?=
 =?utf-8?B?K1pBblF0czRISVV2K3FwcHFPMnhqWTUxd3Z6b3FYWGJ0d0x4bkF2bXFvMGZK?=
 =?utf-8?B?Sk1heTFGRHdWeVVXWXlZNFVZbFhVMTVPWnpaQ2srSGJUS3hENHcrVEt2MHZr?=
 =?utf-8?B?S3ZuNWtiNFI0anAzY2tPSG5LcVZSUkFEeWlkQlJZQVkvQlg3cVhvMUczU042?=
 =?utf-8?B?RWFlRHNQd1g0VGZqbkt6dGZSVitRLy9qTCsxR1R0amljK1pyOFBlTitncExz?=
 =?utf-8?B?WndySzlJdTV4QmhobjlNVDRIZHdoektNNGNBOWYwbkhnV2lHdWxzbU9kMnVD?=
 =?utf-8?B?WlN6WUVLVGRyY01Oc2JmTHdEbUZBS3BELzBNd1pOVWZEd1dJbGp1b09xYWpq?=
 =?utf-8?B?TDdkTHNmU0RLbDNTUmpEbjRpa1dHd3VYQjZ5ZUZnc1p4TU0zVjJTalR4SzVD?=
 =?utf-8?B?OG9BcW1nZnlMME9XQVkzRkZZSDEwaVdZWEpvTCsrK1QrQk5RcHE5U1BjM2Zo?=
 =?utf-8?B?NW1RRkc4UDQxNVoza1V5Mzk2RllyRUlUcTh2VzdRdHNiMnduS3hhSjRSN0Zi?=
 =?utf-8?B?S1ROUDU4QnIrcHRMSWdWL1Bhck1NYXVMT3FzeC9SQUJkNGtYQlc3NUVOeWFL?=
 =?utf-8?B?aXdmby9ZNXlQSUJPRzdtR3Yra0luN2RsS3NyaDkxdzFubmZGOFFXalhIS09y?=
 =?utf-8?B?cHRaYmhyN24xa0JpV2F1dkNaWlZBVXRSUjdsK094ZHVMUEc4VCtzSWJVL1o2?=
 =?utf-8?B?RHE1dmRDUWpua2RHOVpjUStoTVZjSlI0bmN1aFZLVUw5L3JGbk5ZeG5STFZh?=
 =?utf-8?B?Y2R2aGhucGNQMlFkZ1FIRXF5NitRdVJNcFB6UGQ3Sy9TY3JhRjRnZzZxY3R0?=
 =?utf-8?B?THFra3IraEUzeWlmYXhnbEVxSVkrNU5RRUJoSnhINExDcFk2aERpSlhQeU91?=
 =?utf-8?B?TEEyU3l5QVcwdzY2NUlrOG5TbGdBSEY1Z3YxTzJtYkloRWNsMXBNZEtsdEZ1?=
 =?utf-8?B?STFvNFFHU1dWTjZkUDI5N2ZhRFovcWt0ZHl1WTVKelAwdlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWMxTkdheTVLSU5Rak9TcExrbE5BVXBVYnhWdkQ5TkpENEtwcjV1WXh4dCtF?=
 =?utf-8?B?NG10K3ROMXBYbDJ6c1NZZFdiNmRhQW50ZXI5SzJDaXA1YnlyYk03RWh3MDJO?=
 =?utf-8?B?bkFYbkYzMXBrWXNoSkNmbUo3b05MLzNycU40aC9Kb3ZacmVFTVNJS0tKc01i?=
 =?utf-8?B?MTBuZUdFenVGSTkrcUdkZVo3R1gvOWZHQW9HNFQrTWljM3hJV1pzYWpLWUFB?=
 =?utf-8?B?Z2J1UFdjVGxoRGRhRVorV0REV3ppNXFneFBDbnlJR0lXcmFpNXRuazA0RStw?=
 =?utf-8?B?dWRlanNMVCtQd0lISk9Xd0Q2L3ordFV2VUFmZVcyOGU5b0prLytmZVVxdFBN?=
 =?utf-8?B?SC9JMzFyeFNqVi9wMmxNUnBiZU5VRUlzUXBHcVpLNXJqMkVpNW1mT0sxZG5J?=
 =?utf-8?B?OWpnc2Z5aFFFUWJBUmV5V3MvUDNUUW9Tcm0xTy9iZVRSdDZIRjUvaDA5Yk9R?=
 =?utf-8?B?aS9mTy9qQ2E2eVJkSlNDTmt4aWRGblZhYjR1M05qY1VRZU1lNGkrQXZiSk1Z?=
 =?utf-8?B?L0hXbFR3elpzcXViT3JzL2xpbjJSWWREbFF6QzJneXZGdDZKekg2a3NrbElS?=
 =?utf-8?B?OWtRdnYzV0NWTGU1RG1XcHNIbkFidnVOYjI0R3NiS05SWlhuUkVTSGhYcXFM?=
 =?utf-8?B?SnljdGRTaVNwNk9hOFJjWVhub3N2UVcrNS9MMzZVNDk2NkZjUEJielZGSDVF?=
 =?utf-8?B?V1ZrTENWbkhFVlU3KzYyWHo0RnRQMmFKampoUFdLMjNEUit5bVRxYTFPOGZC?=
 =?utf-8?B?YUZ2OUZpYWFabUtyN21BanNlbGVmV3pmVlJlQldmSXM2ZGdid0Z6KzVEWmhP?=
 =?utf-8?B?UjlLSkM4WUdsRG5tK3VUOVlXYjh5WjRLSElHQmdXc1J2M3QwRVFCZmZaTlhD?=
 =?utf-8?B?QlhuWHhnVHRlVEdzeE5CZ2p5dVRFek4vcmF5ZDRQaEdpek9oZUVqVkdYQTNx?=
 =?utf-8?B?bGNrYkR0RFZjYmRGWS9ZZm9lcFBkellqZTJ1a2ZDTm9xWGxxandFcjUzZUwx?=
 =?utf-8?B?VFlHUTZCMldXMFdkR0JmaVNWdWVNYVhhMUJTanFIQXhlZDVZblh0eUFXUlZK?=
 =?utf-8?B?ZHNSOTMxRGxSS1Q5MDRZcVFZSmRaWENnb1JmVVF0T1IyT3BYeXVTT3FxeW92?=
 =?utf-8?B?ZHhVOVJxUXdPRzlkNE92cXgvb3hxbVByeFRacmlVakNwV0ZzSktEMXZsQ2lJ?=
 =?utf-8?B?OVJuUFR3a0hCUitCRTFPaHhHZFRYd3JjOTNURkJjUzNDRkNQWVVyYVhIRnR1?=
 =?utf-8?B?eGRzVEhmWDgzRExvcXVYbnpGTm93TEk4ZXUwaFR5T3UrV1BtZWdzMnFYem1u?=
 =?utf-8?B?Tmp0ZVZ6UnNjSWkyaFMxNWkxd1l3QzFKNUtvUWpRaDc2a2lNZjRkYVczWmZI?=
 =?utf-8?B?VFQxOUROdlNDNXlYelp3TWlkU0FmNDExZG1jVlFmT0ZOUm5CaDhhaVc2bGdy?=
 =?utf-8?B?dHBHT0JjbTZyQXlwUHBmekNSTUlqYk1sZ0J3TU9BOTl3Umk2UVJ6UmxPQmpt?=
 =?utf-8?B?cjdFWXU0V0FYUEJxK0pnNHRnZHoxWXNnaytjaHFyS01aT3NodnBiUmJod3p1?=
 =?utf-8?B?QnY2SnZWWURsK0VTWmlDT0pnWiswUEQ3c2RSU3FiU2cwa1pTRVgyQXBrV2xH?=
 =?utf-8?B?Q2EvK2tERXd2YkZOUlVPdTFTSHE4RHBQdEd6YndLbmxBR3J6OGZnWld1S1p3?=
 =?utf-8?B?S3R1ZThGc1FFNkZnUFBrVlR5d3pDS3VhSmxib3lGdWo0MWpiK0ZGS3llalgx?=
 =?utf-8?B?WmZxaHN6R1JpbTJDbzYzQmRLemd4ZU9ROVBCaHZxYjJKYlBpUDE1UDY4V1NV?=
 =?utf-8?B?RlRTcFUwNndZUVpKZmtDbXlUSHRZSW1IM1pCbG9KWGk2Sk16VzkrTENnU0lD?=
 =?utf-8?B?ZlhkQ2FlU3kvUGpZZzAyeklQV0FvOTgybEovVGJWa3QveDFrNURlNXlWRXAr?=
 =?utf-8?B?OFBoNVp0OEZKaHYyL09Ha2k4Sko0SFZFYkswOXBFM2VlRjhHMzNwakdrSDdB?=
 =?utf-8?B?MDA2U0h4bUxvNkk1NFZQL3pzaGlJRUVYeFhHQ3k0SVM5N1paVnoxQnZhV3Rj?=
 =?utf-8?B?RDVrYkhxdjFNamUrdjNGbUJ6ckJxY01xU0Vwc3I4N3NISUJXcGhveTJkRXA1?=
 =?utf-8?B?VWJUYXh6MG9MR05XZVF6QTdsRXdWWDhobC9RTWo3U05FOGR5QWM2bVhCZUZ6?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA7F05815A07FE48B365304AC1B7886D@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f3501f-07a4-427b-9de3-08dcb6b390ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 07:35:52.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jq/yJPLjvf81aqxILBdXkjsF3Oh+tWtkXjoIGesDNbfW6NH2Z2dpkrP6XFgLPGpHHP7VQYCRmatVx/wt3arIc2aXzHdH2c2OcDb7mn1JpxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476

T24gMDIuMDguMjAyNCAyMDo1OCwgTWFyayBCcm93biB3cm90ZToNCj4+IEluIHJlZ3VsYXRvci55
YW1sIGV4aXN0cyAuKi1zdXBwbHkgWzFdIHdoaWNoIHByYWN0aWNhbGx5IGFsbG93cyBldmVyeQ0K
Pj4gY2hhciBzZXF1ZW5jZSBiZWZvcmUgLXN1cHBseS4gSW4gdGhlIGJpbmRpbmcgbWljcm9jaGlw
LG1jcDE2NTAyLnlhbWwgWzJdDQo+PiBlYWNoIG5vZGUgdW5kZXIgdGhlIHJlZ3VsYXRvcnMgaW5j
bHVkZXMgYWxsIHRoZSBydWxlcy9kb2N1bWVudGF0aW9uDQo+PiBmcm9tIHJlZ3VsYXRvci55YW1s
ICwgc28gSSBzdXBwb3NlZCB0aGF0IGl0IGlzIHVubmVjZXNzYXJ5IHRvIGFkZA0KPj4gaW4gdGhl
IGJpbmRpbmcgb2YgdGhvc2UgbmV3IHByb3BlcnR5Lg0KPj4gV2hhdCBpcyB5b3VyIG9waW5pb24/
IExldCBtZSBrbm93IGFueSB0aG91Z2h0cy4NCj4gVGhlIHNwZWNpZmljIG5hbWVzIGZvciBhIGdp
dmVuIGRldmljZSBhcmUgc3VwcG9zZWQgdG8gYmUgc3BlY2lmaWVkLA0KPiB0aGVyZSdzIGEgYnVu
Y2ggb2YgZXhpc3RpbmcgYmluZGluZ3MgdGhhdCBhcHBlYXIgdG8gZG8gdGhhdC4NCg0KT2ssIEkg
d2lsbCBzZW50IFYyIHdpdGggYmluZGluZyB1cGRhdGUuDQoNCkJlc3QgUmVnYXJkcywNCkFuZHJl
aSBTaW1pb24NCg0KDQo=

