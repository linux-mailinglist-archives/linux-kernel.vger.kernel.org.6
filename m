Return-Path: <linux-kernel+bounces-317200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757C96DAD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947191C239C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA019D8AA;
	Thu,  5 Sep 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QdgWbd4w"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEA1EA85;
	Thu,  5 Sep 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544285; cv=fail; b=afIQxdFHl0ZcCFTDd4/ITrBFA8VL6jkXAXgEQfAhvq+xXBrvqpL1obkbScB9o38HNF/dqw20YGnzFklSBCJVmJasTib7F8vGcMk4mBAxyUdmmvmvOzsniBOiAgwmncS+I0W2uwBXBrNgoMyvGQFkYMn+PIFVUtcwDYAPu1lRlmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544285; c=relaxed/simple;
	bh=4p3l9+8RIYc9i0MuOtrVwxmtEF2yjDF6YEjpTpa8OHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZKprlH3ogKcEvkjc95fKGfJMbEqH/5YN0rNdP7QlYANT+5RTUvpt0DtyPxPAaX4/ybGqUglz3Gr4wHZHW50lLoY9OWEx4U3RqV74wR3O0DFnqHXUXRv+M/vixJUkb/1h6Yjam7EIhmWHEEopxYnkQdx6fskaJNfeZpctFDpfXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QdgWbd4w; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5BDgL7v0JXfU7HVZyxf4efqqS8jErO1RJA2VUCFbe2Hkaen03d3lKSOWbFLftACeav7Wh4lZXDLPL/LZAev6v1/LzHkPq0wZ0e+a3cEqr0YBpb/W9Qf8uO/pVDVuCTmECaRocTxYezY12knoHLpfFOXrKKHKrs48s3Oas0WEdNE+yEpyLIHf2CLDCOHRJGQVe91hU/Bf/fveOMPdsNjSMCocxXLnkM/H5X1qZG0kSdQK7VipyfZMDmvRleSdWI7YIMr+u6qI4n7t34cEds1fMKXbwMn08XlbgBYth0YNeC7dkjqfAv5i2g4T44I1wsFNOrP5DP2QP66nU6f3GDnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p3l9+8RIYc9i0MuOtrVwxmtEF2yjDF6YEjpTpa8OHA=;
 b=HLjRr1jMpEEThlAisfoR9HxEophIT5hyKO2KCkM26TfaWZtCc0zNStSlewl4Bv+QOQxyTXUzmFJoD9C/jFf+tJwVggBPeSHTmVnSf4oUy5evgJdKXPQz/uytCfkZxKa+oN3db13CaaT6mcUbxW4lnRFr5kaFU6m7rBCnVldle2xCsho8g+rH4j+vp3MxAcgKmNjNDaSvzn2QeQT9CO6rcyiz65Uuwe/gUpO94geIT8TguBCDDb7NPraSGpc3fSbWQTDG5iygokbM4DAl9oUHeaStqyUB3R/Fy5+HLI1QxGTYiKPbzNvYbEFep1+98rJJhWtpaAMZRpkk4XJI5uNtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p3l9+8RIYc9i0MuOtrVwxmtEF2yjDF6YEjpTpa8OHA=;
 b=QdgWbd4wIf3svj2HDNxlD8YR3C34KwXmNEyrVGkh5KbVG6O2Aqq6RqLW6N/9IeT5RRP7/2F0IeTiWuuTzgsKPGtscacbIbLz8KsprjpOmPLSO/DvKF55cz1H+5kF3MMYnaWNcXQsC4Nq8G8ZVLrlmXU6nlPooo1Ar3iUNHHgfxVg2jEgc6gMskFC7BHRKRJrH7i9hU0TuVwSwTx8gAudKHkat/zWTMBtATUMul/rKoH9dkUhbT2NkG+Qkqjn+jpjLOJswMzUnjEAQ6E3B2rqPNZz1J6wiPn3o7B5P8hl9qSxPM4aiDJyA67UMxrI9g8w0P38cUf7/Q5fsxmAzvKssg==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by BN9PR11MB5305.namprd11.prod.outlook.com (2603:10b6:408:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 13:51:19 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 13:51:19 +0000
From: <Andrei.Simion@microchip.com>
To: <krzk@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH 4/5] ARM: dts: microchip: Rename the usb node
Thread-Topic: [PATCH 4/5] ARM: dts: microchip: Rename the usb node
Thread-Index: AQHa7kWPNmfP258mNUyTYBll2EM6LrImvYAAgCKbU4A=
Date: Thu, 5 Sep 2024 13:51:19 +0000
Message-ID: <035ef8b9-36d5-4696-b576-35e051b687d5@microchip.com>
References: <20240814122633.198562-1-andrei.simion@microchip.com>
 <20240814122633.198562-5-andrei.simion@microchip.com>
 <29e5fada-8f8a-4cc0-b1d0-14396f6736a6@kernel.org>
In-Reply-To: <29e5fada-8f8a-4cc0-b1d0-14396f6736a6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|BN9PR11MB5305:EE_
x-ms-office365-filtering-correlation-id: c2d8f28f-08c1-473f-9944-08dccdb1d21c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmhiT0RvMmgwWlFQRXZrRkxiQXNpa2ZUR1Y5UHhkSTcwT1Y4U3RTcFh4NnEr?=
 =?utf-8?B?QWh5RWlMQlpYSExhdGlLZjdmNkxSb1FWVUpHYTg5bUR4KzdHcVc3NnF1U2dT?=
 =?utf-8?B?aGY5SjNhYnJFOGFuNTVCdE01WlhaazE1bHNYUGRsY05QMDBldGdrbGxaa3Iw?=
 =?utf-8?B?M0Uvc3BwaHRhc204dE92TnFnWGJibUlmcUxONk9zTkhyYVFyK2NPc3NVeEZi?=
 =?utf-8?B?ZVdxZWxPMndDRkJFaURsNWpjbzZicUlKdURvNUVNS255cE8rQXJhb0RiVVVv?=
 =?utf-8?B?VGU5bjAxMCsvcmcyMVNibTdYdEJwM3F2QXJQUnV1MElQdFNwNFJpVnEvOE1S?=
 =?utf-8?B?Q3R3SDRCby9qRXBOMTFhYlhGVVh3RmFpek0zc2FmU21vVGZydmRrN3lLQW9t?=
 =?utf-8?B?UEFqRUJQTnFOK0VnaE9YUllkd3FwUU1kN2Z4VWdJcW1yOFNQSDg4RHh5SFFu?=
 =?utf-8?B?NXRqdytVanpxZnlRb2dlTHdXN0I3dlNlSFRxRVhCVTZTK0tkMDIrRk5rZG9U?=
 =?utf-8?B?OUJRMnRxN2JXNDdoN3ZWZDlwUk1xQ3NtWUFVN1BlKzhRalZ1eUtrS1JXL1U4?=
 =?utf-8?B?NGg3Nm9RNVhLSjRFWkRacCtQVGdDNDBxQlJoZnFvVk9PZHlLU2J1MS8rSmln?=
 =?utf-8?B?NVlFUG1LSkFyT2tXS1E4K1F1OEdZSUYxaU1NM0V1TUlETTRtOWZQMjZPZEZV?=
 =?utf-8?B?ajhrTVBudUpDa0h5N0pjZWxzN3RERGg1ek1IODcyKzZsYVJZcDhmRENMb05B?=
 =?utf-8?B?dll6YzltWUhxYm1jK3pzVHdxcEdnS1Y4V3ZiaWhXcGs5Y3pVNmE1c0gvdHUz?=
 =?utf-8?B?Q1dMYW5icmhPYXlkQ1BMVGk0cU9Cblk4QkxKdkFrajQ5MEYyc0xUM1NiTVRK?=
 =?utf-8?B?MUh5aDBESkpxSkNadjc5aUxCYlQvMjA2c1pUMi95WGJ4T1dVZ3ZwMXJDT1lQ?=
 =?utf-8?B?cm5oZm03NzJQV01MbmxFbTd0bG5uWUhtL0VidHJwSml1ejllS1VvSy9wc1hw?=
 =?utf-8?B?Tk1sbVhpMGdORnhUVElacHkraFAvcEMrZFRPbncxdlorQ1Q5K0pvdW45RS9V?=
 =?utf-8?B?L2c1YzFLa1BwNm5Ed0g4eVd2NTRaWWdjVU1ab2Fjd3lnQlhsdy9kSXJScVEv?=
 =?utf-8?B?a3hMZDBIV3BDZjliZzlpUzUrQmdCVEhLajAvZytFSHcybUxLaktkYWJCYXpC?=
 =?utf-8?B?UmJjakJXVitjUSt5MTN5d2N5eXhYaU96OENmdzl1UkZpS3ZETlNZM05XdXZU?=
 =?utf-8?B?ZVVVYUREZW8wMEJLVVZVODFlT3JmdmdXTTBoNWxJSTBmTHRhTFE2VjhyaFZE?=
 =?utf-8?B?aE93Z1RrQzdabEV6RTFJMHBKb3ZiQUsvK21MUktNdEs2dE1tRFJCazYxN05w?=
 =?utf-8?B?b0ppTnNrVzRQaSt0VHpTeHFCWVc1Q1RUK3NybEgvQVIxeVR5RmdhVWN3aXpH?=
 =?utf-8?B?N1JqWDBYTEw0dnJyU0RwcTRKbU8zSk1NQjQxYWVYelFLa2huanlrbkJUbUYy?=
 =?utf-8?B?MEh3eDlhMWNZaWozQlZVOGpUaUsvSmt3WG1weTFaYWtQdUpNS2MycDNVS2Zr?=
 =?utf-8?B?T1gvMU1wSFJhU1drNWRuYnpyeU9XVEE3Y05vNjhRM01aYWRjMnhQb1FsdlY1?=
 =?utf-8?B?citFTFBYS1JmOUxmUGhzR212Q1lac0YwTXdDeC9GdlhGeUdZb0djN0YzeVBX?=
 =?utf-8?B?eTNZZVJId0I1Vkc2cXBnZlJUbFlCTUwzM2lXc2JiWGM2TE0rKzJoaHMyY0lY?=
 =?utf-8?B?M21uK1lMN3cvNHg1Q0VXcmwwUDc3UlVPRW5jYWs4bjhHMjIrSFZSSENrTDRM?=
 =?utf-8?Q?7vMwsrsDjGwfYR0sFn8kIzmLU5mrMVuNfVpP4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0RjMXkwY05nV1kwNWZtYit0YjJpQmd2MWpKRHVmZlZNU3pyc1lRUlVjUENk?=
 =?utf-8?B?UDdiY1BuVWYyQ25admZLOGIwUG01akVYUUxGV0FmYmE3LzRVRDYyZTlhanVS?=
 =?utf-8?B?SVNuRXF2QnRDeVl2UWxXUzlWQTFhcGEyMlIwYk5SRHM1YlpnVmtzME1IMHpp?=
 =?utf-8?B?UXllaUlkNWF3M1cvWEZyY2Z3NER0NlhMZDJabXN1aXBLb0lHUUFYUUdpcTJO?=
 =?utf-8?B?cTdMdjJvNWZEY2xYR1QrTnBodm9rN0FSb2FZcnpHZEQ5TDh4UjhydGJCdmpE?=
 =?utf-8?B?ZDc1SjZFT1V1T2E2TTJhZThKZTJlaExsK2c2emxFaVpuUCtwZ2hNTG84T2d0?=
 =?utf-8?B?MEQrZW1wVmlPM2ZrVHlHOExaTmliVTlNbHdYeDkzTE1FMnFsdnR0RkhFUjJT?=
 =?utf-8?B?eUdTbXAxd0Q5Y1lOWEtSY29DL1h6MHMxQ0JlMHJ6L3pzeGF1b3hLaEtnVUZK?=
 =?utf-8?B?T3kydU5ObGM3VGc1NzNvWE1oRDQ0c1ovdllSb1dQTWF5dVlOZlN5bUcrVE1J?=
 =?utf-8?B?M0FJazZtaUpBSG1KSE1PU01GZStzTXo1UE11SnpGZTc1azNFaExlT09vOWt5?=
 =?utf-8?B?clhvb0V1QW5JTWZDVXBxa1AxTW9HZCtIajJwL3J5dkFPKzZIcDE3TmJiT3hB?=
 =?utf-8?B?ckEzQkQ2Y1F2Sk5LOWVSbTh4SEtXNDFDc0htNUJsYWd0eS9PTGE2bktaakpK?=
 =?utf-8?B?d2t4THkxQnhCWDlRME9YNGNDK0d2cjNGQm4rYmN0SjRLdCtHUzBJYUhYMk8z?=
 =?utf-8?B?bnFBT1lVWm1CeEs1eEhqR0J1Mi9rT0pneEh0b1gvTVVrbnRFRzJtYlpVbjFP?=
 =?utf-8?B?SHd4dTNnSEVZZFdzWXBiQ2hNdm4reWQycnhWZ3R1cHAyOW9lSnRCZnNGVC9x?=
 =?utf-8?B?cHFkVzVnVTFFNzdndStIUjV3Tll4NlY1MTNGTFVBRVBwTFdJdi9sK3FyL2pN?=
 =?utf-8?B?eTZsSmhVZ3pxb3pLOC92a2ZPeWFrckhLcTdGV0RaYW9nNklZNUJxdUQyaHVh?=
 =?utf-8?B?bEI1WFFhaXFYU1Bid2hUQ0lkL2VzUzNjcTcrRE5HT0VCN01FdFJjZWFvU1RK?=
 =?utf-8?B?S213RW16V0szZ1pqb2VZZDRZWTlMS3MrMVdmazBMNVYzNWZNR24xK1lGRXlw?=
 =?utf-8?B?aHBWOW53MXBrMkpDN29Xd0xvWEZXZGUxUHZUWVNxeUMvY0F0eW42ZnhyT2hn?=
 =?utf-8?B?L2NwNUNidi96NFk1WU5YZzV1c0tJRGltSjhBVFNjZGdQdngvZVVkaW10eGZq?=
 =?utf-8?B?NDE4N1BQQTFVaGZpanZPM1JYeTZsSy9TWFQ3QlNYR25hTTFGK0JCeXVVcGo3?=
 =?utf-8?B?OTZ0Ty8zanU3MVZPTkYxMGVsY0hwMmlhakFKdm9Rb2lmaW1JWlk4QXNOVjRD?=
 =?utf-8?B?MllWOXJSV1RZMVlKSTN6ei9sVlM5bUpqNXh2VCszR0NjVUcyaWFFOEpUdE50?=
 =?utf-8?B?Zll1YnJ6TmtJS1Z0d0JJTnFRUGduZXpLRVlFYVNqaVplQ0NSNzdVVzZUYkdK?=
 =?utf-8?B?YmxFV0xrenZHZ0ZmeEhrRi82VmtYcFBaYStkb2ZPOXZURjdnUXZPbkZPN1BQ?=
 =?utf-8?B?MUtMRXAwTzhjNmlsVHErTUkydWh2SlJQSGRjbHFvQ2RSc2ZVTGFuNzIxN3lv?=
 =?utf-8?B?QVRyT3FGRC9JcjJRSEEyZ2d4U0JmdjFuUUNZMHNkc1hjZTZweVBabkRhYUh4?=
 =?utf-8?B?aXROVzd1RjcycXR5QWlvdlo3UWcyVEdMbUlxdU4rRWxGNFFBUlU4eHJJYmZp?=
 =?utf-8?B?VWFjYXZSeHNQbDJUM2k4MUlMeWpMeFhzTDRTNlIyMVJIUVgwTStMODg2NExx?=
 =?utf-8?B?TEIzQmo2SFB3OTZFdmxDNGNqckgxMzJBR2tWWTBiS2p5ZWw1WTR0Q0tVa0RZ?=
 =?utf-8?B?SU84alJ1WDNFTHZHenNLRW1OQ0ltaG5TcExDRDhHSmFMQzYyUVA1Y3Biaysw?=
 =?utf-8?B?M09CdUR0cDRuVk01Snd1MG0xUDBDeGk2TkRGaFNTVTB1ekhXM3N4WGJiNmZu?=
 =?utf-8?B?Y3JvOWI5RU1lbDkrUTZuYjNvd3ZWZHM1aVJ3S2phOGNxOENZM0dadlVuRlJr?=
 =?utf-8?B?RjJGeWJZSTRBZ3RBUzhHMUhBTjFXQ0pzbTI5MzFJU1ZwcTRzUUM0aVRjVFlK?=
 =?utf-8?B?cFdXRTF0VGNjSEUxejZlTnQ1OVZoSmJvVmd0RllTYkI3UWR6WGsxK295c2xx?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19C1202F5B868345A83A031335AD4A40@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d8f28f-08c1-473f-9944-08dccdb1d21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 13:51:19.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsdRnrt31ylhxneWhgg81IKQZX+7jBVfOTUeia1EDUUV419A86idH6m7I2lGK78lZCXamQBmRPgwqtJyJRvVwTkhFByeBKLOqOl1tIWxVuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305

SGksDQoNCk9uIDE0LjA4LjIwMjQgMTY6MjIsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTQvMDgvMjAyNCAx
NDoyNiwgQW5kcmVpIFNpbWlvbiB3cm90ZToNCj4+IFJlbmFtZSB0aGUgdXNiIG5vZGUgYWNjb3Jk
aW5nIHRvIGRldmljZXRyZWUNCj4+IHNwZWNpZmljYXRpb24gYW5kIHVwZGF0ZSB0aGUgbGFiZWwg
YWNjb3JkaW5nDQo+PiB3aXRoIHRoZSBub2RlLXNwZWNpZmljIHN0YW5kYXJkIGFzOiBvaGNpLCBl
aGNpDQo+PiBvciBnYWRnZXQuDQo+IA0KPiBQbGVhc2Ugd3JhcCBjb21taXQgbWVzc2FnZSBhY2Nv
cmRpbmcgdG8gTGludXggY29kaW5nIHN0eWxlIC8gc3VibWlzc2lvbg0KPiBwcm9jZXNzIChuZWl0
aGVyIHRvbyBlYXJseSBub3Igb3ZlciB0aGUgbGltaXQpOg0KPiBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni40LXJjMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1p
dHRpbmctcGF0Y2hlcy5yc3QjTDU5Nw0KPiANCj4gLi4uDQo+IA0KDQpJbiBWMiBJIHdpbGwgd3Jh
cCB0aGUgY29tbWl0IG1lc3NhZ2UgYWNjb3JkaW5nIHRvIExpbnV4IGNvZGluZyBzdHlsZSAvIHN1
Ym1pc3Npb24gcHJvY2Vzcw0KDQo+IA0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9taWNyb2NoaXAvYWtzLWNkdS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAv
YWtzLWNkdS5kdHMNCj4+IGluZGV4IDc0MmZjZjUyNWUxYi4uNTJlMTY2YzhhMzY1IDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2Frcy1jZHUuZHRzDQo+PiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvYWtzLWNkdS5kdHMNCj4+IEBAIC01MCwxMyAr
NTAsMTMgQEAgbWFjYjA6IGV0aGVybmV0QGZmZmM0MDAwIHsNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPj4NCj4+IC0gICAgICAgICAgICAgICAgICAgICB1c2IxOiBnYWRnZXRAZmZmYTQwMDAgew0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgIGdhZGdldDogdXNiQGZmZmE0MDAwIHsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsLHZidXMtZ3BpbyA9IDwmcGlvQyAxNSBHUElP
X0FDVElWRV9ISUdIPjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9
ICJva2F5IjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPj4gICAgICAgICAgICAgICB9
Ow0KPj4NCj4+IC0gICAgICAgICAgICAgdXNiMDogb2hjaUA1MDAwMDAgew0KPj4gKyAgICAgICAg
ICAgICBvaGNpOiB1c2JANTAwMDAwIHsNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGVzZSBs
YWJlbCByZW5hbWVzIGFyZSBjb3JyZWN0Lg0KPiANCg0KSSBjaGVja2VkIGluIG90aGVyIGR0cyBk
dHNpIChvdGhlciBzaWxpY29uIHZlbmRvcnMpIHRoZSBVU0Igbm9kZSANCmFuZCBpdCB1c2VzIG9o
Y2ksIGVoY2ksIGdhZGdldCwgZXRjIGFzIGEgbGFiZWwuICBBbHNvLCBJIHZlcmlmaWVkIHRoZQ0K
YWRkcmVzcyBpbiB0aGUgZGF0YXNoZWV0IGFuZCB0aGV5IGFyZSBjb3JyZWN0bHkgbGFiZWxlZCAo
bWVhbnQgdGhhdCANCnRoZXkgd2VyZTogdXNiIGdhZGdldCwgdXNiIG9oY2ksIHVzYiBlaGNpKQ0K
DQpGcm9tIHdoYXQgcG9pbnQgb2YgdmlldyBpcyBpdCBub3QgY29ycmVjdD8NCkkgd291bGQgbGlr
ZSB0byBrbm93IHNvIEkgY2FuIGRvIGl0IHJpZ2h0DQoNCg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgIG51bS1wb3J0cyA9IDwyPjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAi
b2theSI7DQo+PiAgICAgICAgICAgICAgIH07DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvbWljcm9jaGlwL2FuaW1lb19pcC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9taWNyb2No
aXAvYW5pbWVvX2lwLmR0cw0KPj4gaW5kZXggMjk5MzZiZmJlZWI3Li45MTFjOGQ5ZWUwMTMgMTAw
NjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvYW5pbWVvX2lwLmR0cw0K
Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2FuaW1lb19pcC5kdHMNCj4+IEBA
IC0xMzYsNyArMTM2LDcgQEAgdWJpQDYwMDAwIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPj4gICAgICAgICAgICAgICB9Ow0KPj4NCj4+IC0gICAgICAgICAgICAgdXNiMDogb2hjaUA1
MDAwMDAgew0KPj4gKyAgICAgICAgICAgICBvaGNpOiB1c2JANTAwMDAwIHsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICBudW0tcG9ydHMgPSA8Mj47DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
YXRtZWwsdmJ1cy1ncGlvID0gPCZwaW9CIDE1IEdQSU9fQUNUSVZFX0xPVz47DQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLWFyaWFnMjUuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMv
bWljcm9jaGlwL2F0OTEtYXJpYWcyNS5kdHMNCj4+IGluZGV4IDcxM2QxOGY4MDM1Ni4uZmVkY2Yz
MGE5MjRlIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL2F0OTEt
YXJpYWcyNS5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLWFy
aWFnMjUuZHRzDQo+PiBAQCAtMTczLDExICsxNzMsMTEgQEAgJnVzYXJ0MyB7DQo+PiAgICAgICBz
dGF0dXMgPSAib2theSI7DQo+PiAgfTsNCj4+DQo+PiAtJnVzYjAgew0KPj4gKyZvaGNpIHsNCj4+
ICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+ICAgICAgIG51bS1wb3J0cyA9IDwzPjsNCj4+ICB9
Ow0KPj4NCj4+IC0mdXNiMSB7DQo+PiArJmVoY2kgew0KPj4gICAgICAgc3RhdHVzID0gIm9rYXki
Ow0KPj4gIH07DQo+IA0KPiBBbmQgaG93IG5vdyB0aGUgc29ydGluZyB3b3Jrcz8gSSBkb24ndCBn
ZXQgdGhlIHBvaW50IG9mIGl0LiBXaGF0IGlzDQo+IGV4YWN0bHkgd3JvbmcgaW4gdGhlIGxhYmVs
IHRoYXQganVzdGlmaWVzIHRoZSBjb2RlIHJlc2h1ZmZsaW5nLg0KPiANCg0KVGhlIHBvaW50IGlz
IHRvIGJlIGVhc3kgdG8gZGV0ZXJtaW5lIHdoYXQga2luZCBvZiBzdGFuZGFyZCANCnJlcHJlc2Vu
dHMvaW1wbGVtZW50cyB0aGUgdXNiIG5vZGUuDQoNCj4gQlRXLCBpcyB0aGlzIHNvbWUgc29ydCBv
ZiB2Mj8gSWYgc28sIHByb3ZpZGUgY2hhbmdlbG9nIGFuZCBwcm9wZXJseQ0KPiB2ZXJzaW9uIHlv
dXIgcGF0Y2hlcy4NCj4gDQoNCkl0IHdhcyBhIG5ldyBzZXJpZXMgYW5kIGZyb20gbm93IG9uIHRo
ZXJlIHdpbGwgYmUgdjINCg0KQlIsDQpBbmRyZWkgU2ltaW9uDQoNCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCj4gDQoNCg==

