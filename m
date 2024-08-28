Return-Path: <linux-kernel+bounces-304594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7092E962249
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20901F226F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5915C151;
	Wed, 28 Aug 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lQ9EWIt/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F062B67A;
	Wed, 28 Aug 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833515; cv=fail; b=fQa3BQ7NPDcaSuhAdZeLdlFvSOkl2wKN+v65xT3dnfiky9hnVnAs8jKjDe3/E1M1nfa/SYB7f8+NVo3c94xfnVzyQI8eKkvOC3WQvrKiG5pOW2tIFv2hxtkHhs0iH1ifR3jV7DZCNVNJBiOQVcuMEYkKfj9iT6coNLBMtWHxIiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833515; c=relaxed/simple;
	bh=/IQLQop+eKQbakLHPOwm3l2r3nhbgH1WF7yhvejLiSs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNQ8gk+gul5bXg4U5G8X0vbV6MnmLGBKQ4yr7AbThuWwCLGVB/zhE8ti1ZAFSnOx+c6m7wDtNxxb71635A8Z9J3b3idvuH0swkc8CTvzMb3T6rR4wL0RRGe67xyTblq6hX/wnQGJgKKeAedv+h9aSJf418PyVqi1Bquj5/THXOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lQ9EWIt/; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSye88UDtcYdcxT3gfvvdaXi/aqPF6UcmqcDS1FUAekSAutJ8QjdSvv9qbi56AFOJPeCjiQ2yDGHyD2QfHj8X7BbedzJQa5cWaKlEhOUv9sZ9HygJdawVeH2CHah9GOa5PTjGahCQNpEJB3pTIcc/SINTFV7apZ2w6XD+BVjI+6u3RttcJeDldQUQHAsq3JYlNkmfh/TKXX9FyGQqoPDLkPnbsc8II4/Y3uLK7SM1DFrpxva+07fUU9334K7+oXu4PnttligSSCbQXLa5oyOHXuw4fpE5NxGMHj3BhpRnaoCov0lvVUQ/4pLOjrxLL1skX5MEbV664jasRDu/qKeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IQLQop+eKQbakLHPOwm3l2r3nhbgH1WF7yhvejLiSs=;
 b=tXRI2wkZuCHbJAU1utSAU1T9E6/vjWPtg4SalfUQUC/XCT5fdJBUsYWTM1qq7/j4Wadl/VgUIjTd0cR9/sz30qJd0QOryVdE4B90ca9SChAF/KgyRu6qfLMH6ppXmaBuM1acuDf5nCx3g1VF6WOicVwUqWzitVdM4HQOt6Hvb2j404y5esjj2BbYt+8Dm4m9arMV7gDfEn3HB9Iw6oouhnI8HknPeRnsMVvGMMtkIoqTjznfSrAnCZwWAtEHevdP74smSQCDY3hBD+z7iT6yamlB2r6YqKCjDjqwdblRz/PCoF/r/mWsocE8sV4lcMa06Zd4rzwh2gal/fwZR4a+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IQLQop+eKQbakLHPOwm3l2r3nhbgH1WF7yhvejLiSs=;
 b=lQ9EWIt/oiKsx2Wpsq7r6a6FWfb42y6OV2Hz9kcb073gw2Kje2wO2KZslviUFXKWZa8kIB72cmEXqKqQvdzcc8eAbI4TMRF1JAepF/z9cm8vF0d4ZK7bPEWfDwnQAn+YFudeAQvoDvroW5VzntOlnvFLVWsXSGx532qdbUmECcIWCCHqnEIrKCJOIC+bT00l/SjU89F2wdEQNPCyhlqpmAgDW3aMoCKLRi+qL2xlqEFMNF/TEWYZ1HXDDp2ptBnfg3S2G4nRZM6QjwYGgbStmGLIVzXTMQWqVr1CadCZhHZfw1buhZNhWhn8oZRFnlZKEYxP+HKn4HTeWp2fKjMwew==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 08:25:10 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::5303:b2dc:d84b:f3b2%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 08:25:09 +0000
From: <Varshini.Rajendran@microchip.com>
To: <krzk@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Thread-Topic: [PATCH v6 25/27] ARM: dts: at91: sam9x7: add device tree for SoC
Thread-Index: AQHa4YZMeTWeKexZ3kW/54rPazvlL7IQhMgAgCqFTACAADGvgIABSMUA
Date: Wed, 28 Aug 2024 08:25:09 +0000
Message-ID: <a36c4d23-e2fe-4bf5-a262-5eb9828e6e7a@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
 <20240729070934.1991467-1-varshini.rajendran@microchip.com>
 <7031d811-2bb2-4325-996c-a6de766925db@kernel.org>
 <bf77fe95-0982-4605-a493-25c889e81639@microchip.com>
 <5fbc815f-d52e-437d-bdc3-c61f365e9d1c@kernel.org>
In-Reply-To: <5fbc815f-d52e-437d-bdc3-c61f365e9d1c@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|DS0PR11MB8720:EE_
x-ms-office365-filtering-correlation-id: df62b689-bc8e-40d2-858a-08dcc73aee1e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFhOSVhtamVPaUs3aG9zNW5aY0x1N203dFdLR3V6UzkraVUrQSttbEdsdDda?=
 =?utf-8?B?UENRejBadGRHcGNlWHg3ejhiWjRmWEhRc1plL0IxbldZZDcvK2U4Sk93M01V?=
 =?utf-8?B?MlZuTmRHZExwSHl2OFljWUc3c1paRTVKY3dmVkxpU2hRMmFRdUZZdGtROHdp?=
 =?utf-8?B?MFBwRTlJZjM3ZElCMStPK2VuNEZsNDR5V3BzUi9pL2RjMmI1M0dLcWdnZ1Y4?=
 =?utf-8?B?OGpUSzh3aVZ2WmVJaTloS041SHB6NkpGSVBLOWJjbE5FejFQMUNTeXQ0S1NI?=
 =?utf-8?B?TGMxcGtScTNSNlVRRytMdjNhTEpHbVpvdDQzN1lsUmxtZDBsWDFTVTU1K0tI?=
 =?utf-8?B?T0hWUkNmTTZ3T1V5dzI3dXQ4YWFkbXJWcUlsbjQ5QVl1clRBNkRuaEdpTDRk?=
 =?utf-8?B?REZ1ZEdiaThycWQ5ek5BWDlrRElMczFxS3BDQm1RSHpDY0hoTUIyWGJIeVY3?=
 =?utf-8?B?eTVnMWNhQ2pLV2hNQk5TT1VVdVJKUVRENkxIQTltSEFPVjd6NWtDUnFCNHlD?=
 =?utf-8?B?QW5jRVhuZnFQRlE1cXpKYnc3eGJ3NnBYT1RoVGJMZnRYL1hYQ2pDSENzMCtu?=
 =?utf-8?B?ZGJIOUhrdGZRT2xwTVJUU0dGUU9obUp4Q3dzR0FhTUdCMnNDa0RSd01ub3NN?=
 =?utf-8?B?b0VYdVFnR2FmejVySWJZSWZ4VG4ra1VQQzlZU2RjY3B0ZGluRXZ4aklvdVVz?=
 =?utf-8?B?cDhITWJhZFRDd29MUkM0aFhMVUNGR3BIaktpMzBLMGpNOGd6MmxiOGZVUzlE?=
 =?utf-8?B?K2s2ZFVJWDVnUzdsOUhPSExic1pLVEVTU3NKUHNHRkVBWDVMRm5RUEFoQjdH?=
 =?utf-8?B?QWNmblJJc3ZqY1ZMOERQcmphYTN6eDRBREFrdjdYc29qS1Juc01VNDNxeDFU?=
 =?utf-8?B?WEJsWGhHd3V1eVBubjYwUFdtRjdkM0FaNldhM09pZGtuTktReENTTHFnRXBN?=
 =?utf-8?B?TmZ4MUJSa0k0NVh6OGVXOG5OWGNWTUpjcWNjZkUxQVlvdEJocFJEK0lOWGwv?=
 =?utf-8?B?eU1ZaXB0b21MaDBzL24xZ3Q1S2RVTGc4Z0p4TUR3Ky9zeldJWFN5a1VqS1NB?=
 =?utf-8?B?OUNTVEQ4Z1huSDErdUVCbkpSbUhrQS9jaW5xc1VwS0JVMUluc1hPZ3dvWUVS?=
 =?utf-8?B?M2dJV25JU1EycUM5WUgyL3JiODUxSHpnRk8rN1ZoZzAxa1ZaU1FITkRkdkkv?=
 =?utf-8?B?RVFlSnNXMTJuSzNmTVBkR0djc0ExL1c5NVMzcjcvcFI5b1ZVbHd1aDJZQWpu?=
 =?utf-8?B?aFA0ZzRvRlZOZHZOaGY0UWRQV2ZqWGEvakEweFAwTjdra3lNRklaOW0xWXNN?=
 =?utf-8?B?NmpzSklib0xWcUNOeHJHYUJkMmIrOXhNeHR0d3FVR0oyL2Nib2hmSVE4WU5i?=
 =?utf-8?B?TWRKeFhLcVMvdmx2NVpIYVFRNXQ1SWdzM1d0QmNrQlM2ZGRwVHVzQXVHbkgr?=
 =?utf-8?B?UTd0ZVNpbGw3aDU4MnAzM29qQUkvcG1mRi9TaTFqMEJJdy9JbG00T0FKaFMx?=
 =?utf-8?B?dEVjT1Y5eEdncUZCWEdOS1h5K2Z1REV2WGRiNW1SN2hOdm1PWlJoSWpNdXQ2?=
 =?utf-8?B?cVlnRmpqMTNCSVYyUU1CL2RYQzZzeldtVE1pVytSaE5TMWRWVkZMTnA2OWkx?=
 =?utf-8?B?YWZVbGxWR2drRHh5WFMxUmx0RTRGV0w5MWcvaEdKbUQ3NytzZDNmTFdIeUk1?=
 =?utf-8?B?aEdoRTBuYm9ENGc2cnhSeDBaMEliVHVXcUt1Ri85RzhQRUl3S0V5WU9IVkVQ?=
 =?utf-8?B?LzBrTkw1NFQwbTVZNTRiR3RpZTQ4STlXSEM2RUpYcWN3ZFJPYTJzYTJvejNy?=
 =?utf-8?B?RUxvV052dXRSUXd4T0haMDdZN3U5aks3cXE0anF3MlRLRnYzU3d2WXpiUm5l?=
 =?utf-8?B?QjViSmg1QXJXNmpxR1cybWxOdFFmN21zOFU3TzBFNlFDQ2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnJHNzBOYmpQWkRLaW1FSFhZNmdSY09jc25Kb05FeGVRY2lKSDRCU2lIY2Y2?=
 =?utf-8?B?VVNoZjJSY0Vyd2VPMmY3eWxaYll2U3h0TzNUek5mK0RseXM4Q2xLdTZneHJo?=
 =?utf-8?B?UHBBd2RwQ3Z6c1dheTcxb2ZIV3hhckNmWlVWUmFWRWY0Q2FRamRPNG0rTE5k?=
 =?utf-8?B?ODU2QkI5TDRmUGdYTW94Tzh6V0orTklqUFoxYnB0VFdTOERzRzVKQjhhVGlU?=
 =?utf-8?B?c3dsQnpXNUNTMXBROFp1RkVxZEJRRUZ6WnVUK0dYNVVQdVlFRkppZHV6aHR5?=
 =?utf-8?B?MlJUK24xK3RLQzNmbUFwelFoNlh2eWN2U2VDUHRtZklXSkh0ekI1VW9SdC92?=
 =?utf-8?B?cHpZY0tyalRJQmYrdkZ5MFQ4SS85Zzh5WmNIbEZSb2d6WTBrNnB2b28xbnQy?=
 =?utf-8?B?Z1o3UG4rQUhNWTZQS2IxWCtLU3JhdUlhWWpzQ1p5bkR2WHk1b1dqYU9iR1Za?=
 =?utf-8?B?bDlJQVRvc2tuU0plZFZYWEltNnhySmF2RU9mR29va2E3OEJMOHRSbXU5Qi9n?=
 =?utf-8?B?bUZ2L2praUtmblZMZ0RpMkgrTGZ6RndqWTM5Q1B0RytTWXlHcmNmMURhalN1?=
 =?utf-8?B?aTM3anVRMDNTWVJSMW9vcS80eEhja1Q3aGtWa3Y3WlJFaVNqbDVwUTM0YnI2?=
 =?utf-8?B?ZjRhTFUxekNaQXVzU3AzZ2tyMHZoUEl3U0oyZWNldUtmeGRod0JKYmM0TnJr?=
 =?utf-8?B?NGZPRUcrVHBwZG16NFlkQWRpUlBJQ2hudWRJaG8vaUlTTnNIbU1MNW9QR2Nw?=
 =?utf-8?B?YjBGQnFXYWNjZGQ0RTNESC82MVk4OXlqMDQxZ0paR1d4T3BBaU1oYXhuN240?=
 =?utf-8?B?cXhOWFJwbUtXZk9GWXNaVzZ3TXhXMnpJeTZwTWdXKzRtY1BrODNlbUIvcW9Q?=
 =?utf-8?B?VDlPWUFWbkZuSHZhYTlvdTZvNms1SlBkY1ptem95Z3ovY1kyWnQvWlBqanJU?=
 =?utf-8?B?NkFIMTZqZEVRUTA0cUw1NG53R0JFbUNmNTIvUTRnZkVLRkV3NjFNbEpURTRh?=
 =?utf-8?B?RkVrUm92S2dWOHV4TE1LUjM0eDlsbE1qclUvUGNveUpKVnI4WDl6Z3oweFpu?=
 =?utf-8?B?Nk5LTEFYRjNnaXRFQnFkYUp4Ty9Xa1dLZkNNZVk5bmJZczVVdnlJdnVnd2VM?=
 =?utf-8?B?RmV6WDcyQmczdVNZMnFpRjE1ZVpSaHVWeUVBcnpjQUV5K3YvSUUvb1pUWEJi?=
 =?utf-8?B?OE80bWhlMnVDNkFZeXpNL0lVbUhFRXZMZWNxWFlJWEttRGw0YzllamdWNzdP?=
 =?utf-8?B?bkpiMWZZUFNpSWl0TmRaOER0VFdBT1I5cUFxdnZjT2VuV096VGtPejkveHdI?=
 =?utf-8?B?TnQvZzBUdVBlRzZBNGRlYThIMXdaMWh3elRHc3BydldMU1RGRDNCYXMxeVpM?=
 =?utf-8?B?SVM0NHNERkk5RjdZU0N6TGxXazE1c1N0aDhNRTk4QTF5dWVmOUprTndDY1Jx?=
 =?utf-8?B?L0RJbThHYmRGcmNONkFSSE1LZXNDWHlpOWw3UkZrUWFNalVrVG9RKzRQbnRQ?=
 =?utf-8?B?TkRhWDdMWjd0c0ZEdHlHSEZGdmpPSTYxOEFjeFJXcU9BYkZHUWtPeXF1SDhj?=
 =?utf-8?B?OGVsTVJFekUvbHpoQlNaSUliSE5saXRVNGdpMmVkRFhrMjZ3bnIreXlabWdv?=
 =?utf-8?B?dXdHMkprZmVaZHZEbnpJVjZYZ09ic1pWYWZUZ2FFSXhnNEZyWFh6OWprVDRS?=
 =?utf-8?B?TnRhMFk0Zng1MlpKTU52eHU5bktrQXd1YkovSU5OeTJGVWRlT2lMNWtQYStL?=
 =?utf-8?B?V1FkQVBYTXB4ckZnc0VmMVlmQ0xacWdndmxDSXFwSldSdGJkK3N3eWZrdHBY?=
 =?utf-8?B?ajdpT29jQnFZM3ByV3JzMWtoNUZ2cjFEbXJjeW5ZNSsxdGlqTGVJLzFSV3ho?=
 =?utf-8?B?bkRNVG5zVjFPNzNQcUpQRlpyeTZ0UVg2Slo2dW1JVzJUcFF0VkN2bk05Unkr?=
 =?utf-8?B?WUJOcHFBcVpSRmJIOW82eWlKcTRSYkRHQmxTVkJPcmRIcFN5L3FaOFNpdEhS?=
 =?utf-8?B?K1RtQXlxdWF0TGthdnc0TTlHU2VFKyszMEx6c0gyVk5YQk9PL3JHYjgzZFl2?=
 =?utf-8?B?ZG1YeWN1MVdscXN3d2xyNSsvVC8wWGJDSkEvQ09rdXhGYTZyUmkya285SjVU?=
 =?utf-8?B?WjE4ekdZS0hHVGttUnFBTEpiOU9iTUlZNEhwRVVKTWtPWUVkMUlmV0V0K3dE?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13984DD16888DF4799BE52DA11D227D5@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df62b689-bc8e-40d2-858a-08dcc73aee1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 08:25:09.6621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfHN+YSo4w86bVUtDNQYqSHU+hYXN4rcUwiflH0PoZlz6SX6Tvkv/dNpuMGNxDLb0ZMKggnVgWYt/0UUUly26m1X36E70am7ERMLGPf8t2iL0X9XljbAq0tCyxS7Ig6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720

T24gMjcvMDgvMjQgNjoxOCBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyNy8wOC8yMDI0IDExOjUwLCBW
YXJzaGluaS5SYWplbmRyYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpIEtyenlzenRvZiwN
Cj4+DQo+PiBBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXNwb25zZS4NCj4+DQo+PiBPbiAz
MS8wNy8yNCAyOjAwIHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMjkvMDcvMjAyNCAwOTowOSwg
VmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPj4+PiBBZGQgZGV2aWNlIHRyZWUgZmlsZSBmb3Ig
U0FNOVg3IFNvQyBmYW1pbHkuDQo+Pj4+DQo+Pj4+IENvLWRldmVsb3BlZC1ieTogTmljb2xhcyBG
ZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBO
aWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFZhcnNoaW5pIFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFuQG1pY3JvY2hpcC5j
b20+DQo+Pj4NCj4+PiAuLi4NCj4+Pg0KPj4+PiArDQo+Pj4+ICsgICAgICAgICAgICAgY2FuMTog
Y2FuQGY4MDA0MDAwIHsNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
Ym9zY2gsbV9jYW4iOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZjgwMDQw
MDAgMHgxMDA+LCA8MHgzMDAwMDAgMHhiYzAwPjsNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
IHJlZy1uYW1lcyA9ICJtX2NhbiIsICJtZXNzYWdlX3JhbSI7DQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICBpbnRlcnJ1cHRzID0gPDMwIElSUV9UWVBFX0xFVkVMX0hJR0ggMD4sDQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDY5IElSUV9UWVBFX0xFVkVMX0hJR0gg
MD47DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbmFtZXMgPSAiaW50MCIs
ICJpbnQxIjsNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmcG1jIFBNQ19U
WVBFX1BFUklQSEVSQUwgMzA+LCA8JnBtYyBQTUNfVFlQRV9HQ0sgMzA+Ow0KPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiaGNsayIsICJjY2xrIjsNCj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX0NPUkUgUE1D
X1VUTUk+LCA8JnBtYyBQTUNfVFlQRV9HQ0sgMzA+Ow0KPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NDgwMDAwMDAwPiwgPDQwMDAwMDAwPjsNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnBtYyBQTUNf
VFlQRV9DT1JFIFBNQ19VVE1JPiwgPCZwbWMgUE1DX1RZUEVfQ09SRSBQTUNfVVRNST47DQo+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICBib3NjaCxtcmFtLWNmZyA9IDwweDc4MDAgMCAwIDY0IDAg
MCAzMiAzMj47DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPj4+PiArICAgICAgICAgICAgIH07DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgICAgICB0Y2I6
IHRpbWVyQGY4MDA4MDAwIHsNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAibWljcm9jaGlwLHNhbTl4Ny10Y2IiLCJhdG1lbCxzYW1hNWQyLXRjYiIsICJzaW1wbGUtbWZk
IiwgInN5c2NvbiI7DQo+Pj4NCj4+PiBXaHkgdGhpcyBpcyBzaW1wbGUtbWZkIHdpdGhvdXQgY2hp
bGRyZW4/DQo+Pg0KPj4gVGhlIHRjYiBub2RlIHdpbGwgaGF2ZSBlYWNoIFRDIChUaW1lciBDb3Vu
dGVyKSBCbG9jayBhcyBhIGNoaWxkIHdoZW4gaXQNCj4+IGlzIGNvbmZpZ3VyZWQgdG8gYmUgdXNl
ZCBhcyBlaXRoZXIgb25lIG9mIHRoZSBmb2xsb3dpbmcgbW9kZXMgVGltZXIgb3INCj4+IENvdW50
ZXIgLyBDYXB0dXJlIC8gUFdNLg0KPiANCj4gQW5kIHdoZXJlIGFyZSB0aGVzZSBjaGlsZHJlbj8g
V2hhdCBkb2VzIGl0IG1lYW4gIndpbGwgaGF2ZSIsIGluIGNvbnRleHQNCj4gd2hlbj8gRFRTIGlz
IHN0YXRpYywgaWYgeW91IGRvIG5vdCBoYXZlIGhlcmUgY2hpbGRyZW4gdGhlbiB0aGlzIGlzIG5v
dCBhDQo+IHNpbXBsZS1tZmQuDQo+IA0KSSB1bmRlcnN0YW5kIHlvdXIgY29uY2Vybi4gQnV0IHRo
ZSB0aGluZyBpcyB0aGF0LCBlYWNoIHRjIGJsb2NrIGlzIA0KY29uZmlndXJlZCBhcyBhIGNoaWxk
IGFuZCBpdCBjYW4gYmUgY29uZmlndXJlZCBpbiAzIGRpZmZlcmVudCBtb2RlcyB3aXRoIA0KZGlm
ZmVyZW50IGNvbXBhdGlibGVzLiBJbiB0aGUgY3VycmVudCBkdHMgKGkuZS4sIHNhbTl4NzVfY3Vy
aW9zaXR5IA0KYm9hcmQpIHdlIGRvbid0IGhhdmUgYSB1c2UgY2FzZSBmb3IgdGhlIHRjYiwgaGVu
Y2UgdGhlcmUgYXJlIG5vIGNoaWxkIA0Kbm9kZXMgZGVmaW5lZC4gQnV0IHRoZXJlIGFyZSBpbnN0
YW5jZXMgd2hlcmUgaXQgY2FuIGJlIGRlZmluZWQgaW4gdGhlIA0KZHRzLCBzYXkgZm9yIGEgY3Vz
dG9tIGJvYXJkIHVzaW5nIHNhbTl4NyBTb0MuIEluIHRoYXQgY2FzZSB0aGUgDQpzaW1wbGUtbWZk
IHVzYWdlIGlzIGp1c3RpZmllZCwgaWYgSSBhbSBub3Qgd3JvbmcuIElmIHRoaXMganVzdGlmaWNh
dGlvbiANCmRvZXNuJ3Qgc3VmZmljZSwgdGhlbiBkZWNsYXJpbmcgY2hpbGQgbm9kZXMgd2l0aCBv
bmUgbW9kZSBhcyBkZWZhdWx0IA0Kd2hpY2ggY2FuIGJlIG92ZXJyaWRkZW4gaW4gdGhlIGR0cyBh
bmQga2VwdCBkaXNhYmxlZCBpbiB0aGUgZHRzaSBzaG91bGQgDQpiZSB0aGUgb3RoZXIgcGxhdXNp
YmxlIHdheS4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgc3VnZ2VzdGlvbnMuDQoNCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KVmFy
c2hpbmkgUmFqZW5kcmFuLg0KDQo=

