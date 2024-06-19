Return-Path: <linux-kernel+bounces-220719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A32B90E633
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2477A1F24212
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0677BB06;
	Wed, 19 Jun 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="l3hY3TIl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3697BAF4;
	Wed, 19 Jun 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786673; cv=fail; b=FSHy2cSieZCbGYpnwe2GGM6MCtFmTM9yCAPwFa0XeA7QtphMKFbmqK6RS8erUJNzSFT5fApHX3p3eTaVUpjaQ/KJPJv7aOLyPbA7XwQzHCzAhfsWOdZBBaxocfzNfSCpnGrISNDb3Bb668GV08L13vTfk4ngD4Fqzta1HdmyBfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786673; c=relaxed/simple;
	bh=EtUOdI1C3aOYWOtIxGo31ejo+8kYEu5iB9GX/j06DjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1C4JM+LWolOV8WEJzwr93DeO5wF1Am3pZ2JyFPcv1w/s7FrNuwMqn4hZJrwxnZi0Xken6uYAHl57Z8OSZHQmp7zZxUkU6/uNNR4qJ4EITiDlg457Fh6QZ0n46EYWRtObZJ2SP6d7kXsqprtgQ6jzZ+u9kQ6YO5W76VJhh0x96Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=l3hY3TIl; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le+6Dtlqx3oq1X6n/4aIeqgaFpKele6dmO50MQj9vcwTZqEYzKwevXS5D2AndWmJ5SUzKlMTij2uAjUwt+OWZMzPRSfUlFpjzBdfzPa4ewgE1aE2/wyDk8qo9ghg1gDFEn1psrIQcKq3YJ2qArwQyHsUak/rHRpSsyIJuFL9SQPbUjCqcRxTku8LUYzzHv4alRClpgbiGfOd1ww5z9WKFWNFOthbvScuo9IGkYwHDSdFpitAYWqhG3kuZwSUBmW9f9Yfcfab64oZJMwV7RQCTTprs4VMEu0vkdt2/mBhuwm1dq9hETnPm+9AqL07GAI+4ccSRRdpjiO2dZkPJQKgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtUOdI1C3aOYWOtIxGo31ejo+8kYEu5iB9GX/j06DjQ=;
 b=lfCFQuS1vhFS8euamqBXrEAtVmKgoiuie1GDZ1QGTe40nYhcxPJnbJfZ9kgt0u2zyedsTP4fhGirLRLnzEE/6r8QxCL7o1/Gjh6AMEUpsibH63F5yO16mGzbsMNAgLpgisOzENJTHMAEfHgOjE24J1ir6hcHoDoqbu+gP89DDO3DXsv7pd0X3Hn5HlZYayLdY2wBEiE6+QhFX3PzILmb6eD1VaH4ZIViGT7LWX9GMlHF6Kg8GDts3TPS4OtTfUztFYCumUPpnNpP/2dvv2RlDx6HkAKIdoDXEwC9g2i3ScgnN3UwvquaOM/whLveYV+sBM3DuGXNfdInMz5DjeEllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtUOdI1C3aOYWOtIxGo31ejo+8kYEu5iB9GX/j06DjQ=;
 b=l3hY3TIlmZK2EQDogz4pdYOWOmjDu53IU+f4Wd8pynB9bHAaM/TS95DdnMmxuA7NiMjkjPhrTK3ZbJR6vCb7pC1e0tTaVFELVUZEx+Al06yWbrnbUwQ7++OthH2KZpjN/rqfLtgw61H9tCN6R6brjnK5r5odbjk4EpAf+TK6+sqzn+UDH1M0TDcBBxQppDx5fZMJDOxhNTcjnkjDtIhaMGIPsXePYsrCTs0R83lgS3bug1uI2+0/PAYW8ASaLpC/YpGAS9gyjRUPNb3NEYWAckrfhNCtUE7xJuoEQbD+1+1hXALJ9mlfx5I1jwTtFctaqoxVRNqt3PVf40VSHnSaZg==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DUZPR07MB10101.eurprd07.prod.outlook.com (2603:10a6:10:4da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.16; Wed, 19 Jun
 2024 08:44:21 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 08:44:21 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Maxwell Bland <mbland@motorola.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Thread-Topic: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Thread-Index: AQHawY1yjMHcSLIVrke3l17Tw6hdZbHN2kAAgAARloCAANrPAA==
Date: Wed, 19 Jun 2024 08:44:21 +0000
Message-ID: <09d8eb0c-bbdd-48a1-bbd6-b80c9b6cf576@cs-soprasteria.com>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <fgvecau2k64sfzvxbs2yxrhzimseogdt2qk4izboywnrtco4od@ezdoxozrt2yj>
 <194624e9-125e-40aa-b8dc-08895489150e@cs-soprasteria.com>
 <5b5bumqhap3v6tjigekm6cdiv5vjzlk5dhpdwu5so5pk4dz7bd@zeka4bsylxzr>
In-Reply-To: <5b5bumqhap3v6tjigekm6cdiv5vjzlk5dhpdwu5so5pk4dz7bd@zeka4bsylxzr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DUZPR07MB10101:EE_
x-ms-office365-filtering-correlation-id: ddf1e480-5a99-4ad7-73c9-08dc903c0393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3JYKzg3WnFXajZ3VnovVDFQdXJaTUtaZXJsUEp6TVVMby93REtQb2JFak5H?=
 =?utf-8?B?b2QrMjVUTmdzTUtEUDB5UGFaMHNkcGJrd1hZSUt6Z2RkZitoT1E3VENKRGNK?=
 =?utf-8?B?SDA3SkF5aFdRNVlWVjhxeXdMaHplSkw3cDVpSUR5bDJRVTM2TkJIejAySXVW?=
 =?utf-8?B?R2ZqcjRiT1VNNlJEZ1FxTWVqWWprQUdmQkl0TDJ0M1NTSkQ5VENXUUFQRDk2?=
 =?utf-8?B?WWY1M1g1Mkx2bEN3WjlTWTlOUE5vVC84UzcrRWpYSG52bTJzWlVwRlVqcDYz?=
 =?utf-8?B?dEhDMUZNQ2hxcmxVNWNJWGVZTDlDbEd6eGszaUtkUXpRcm4xcVFydmFKN054?=
 =?utf-8?B?OTJGbzA1T3VTc3NudnpXQW5yUXhpT1UyQWtNNDluRnl0SGl6aURnSmdpQWpl?=
 =?utf-8?B?Y0RoSXpzekVUdjM0MEYwMW1CVGV1amtkc1J5eGpnZzhweGtPdzZCa2ErU2Jn?=
 =?utf-8?B?M3Z0NlhnSDMzME85YVh1Yk5sd0xmVkVIekpMQUNQNjRMWGpSbEV5dnN2VGk1?=
 =?utf-8?B?Z1dmeHlwZWtNVGN0c3FrUjArNHVjeDdNSmdtYXNnWmEzRkhGdUVxNmtOWmhW?=
 =?utf-8?B?L3JHemR0eTNic1psZWNyenpBd2dJZFBiQTd4K2NWK3BuTzlaWGlqOTlaalZR?=
 =?utf-8?B?MEU2aG1kLzZnNk5VZHA5amRTWC82dUpBc2d6SkJ6Z0tHeDU5akFGWlBQSXhI?=
 =?utf-8?B?cTQwbWNUc3RNNzZyNktFM1F1aHhoN25PK3NKWThsb2pVblBCRmNIYXp6Z1BO?=
 =?utf-8?B?bU51TE9idlVNQWRJMXNIOGgxL0Y0dkxncTFuRVN5bFhhdHdNN2h6aytxVm9y?=
 =?utf-8?B?eEtsVmFDSmt0YTQvc3k0NnVMZTFXN0wydmtad0d1Wk5yREF4QWJiZU83cGZm?=
 =?utf-8?B?L0IyemU5aUQ0ck12UDlrZ0pDdHNDaU9ueFFmOHIyS2hadVFTdi9MM2pzdnEy?=
 =?utf-8?B?Mmowc2ZDSWppanQwRmZjQUg4VFRjd1pZY2Fla05TbW5oUnNVUjI3SFFsb3Jk?=
 =?utf-8?B?VVZGSGNJajg5bWJLN1JPckJRUWJwbFM3VVgzZlN5SnI3OERtRWhnNUxwOVlx?=
 =?utf-8?B?K2ZicDRwTkVCSjlTd2RCU2VjbDZyY0ErYnRsWWYyTFh6MENzNDErUm85dERW?=
 =?utf-8?B?TXI0NHJSa0NNclhFK1FRRTJjajFmS0dQeWVXUGprM2pWOXNRMGtITXBDcjFI?=
 =?utf-8?B?N0xGRFV2V0JPYSt5cDhJRUE0SENmQWR6M2xzNUdtVEF2SmxYeEhCTXVDQXBP?=
 =?utf-8?B?eFBvSG5SclhndzBlUW5MSXJrR0RiaCtERmVESDVGQXJycitTamtGdUZ3OVpp?=
 =?utf-8?B?TU1wejRxSkduYXcrQmhRc1pXamtwNUQvQnZhYzNxUDYrMGMydmRiejExYUw3?=
 =?utf-8?B?Y1hDWnV4WHcveFJaTHNPby8xSlVHMHozNXlKTmtpSFFRNEh3b3BaOTJ5YzJX?=
 =?utf-8?B?Rk1uajB6MVEzSVZxWko2V2p4MUNNU3h2U3Brc0NCMkhUeDZwWkFDS00wRmJQ?=
 =?utf-8?B?MHBLY21QMmQxU2FZSEc5aHBteEQxRkxXZERDSXVwVElEMUduVnFvc3lqcEJh?=
 =?utf-8?B?aXdRZ1hHWXpSV0MzOWtqMXlPQzFBYWprbGMvcS9aQ21RT1d6M2pVSGZ2TUZC?=
 =?utf-8?B?N2JBeFJtRmhQdVNJaEZMUGJjRmFYaFlRUHBSYVBCTzkzYWR0TFJ2UUh3c1Rt?=
 =?utf-8?B?b3RLQWdFQzh3aGRVd01mcTdPRzlXVlkvUGRpUWV4ZTZwME1lc3didUhkdGJV?=
 =?utf-8?B?OE1lWHZoVXpPZTIwaGRFTUE4WTRPcEtGMEVrakRONHNuR2dzdXZNc2NEbHVj?=
 =?utf-8?Q?0y2JcNIGKO37/vjVsWBbKnUxfcO7ub85HFPa0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWlGZUMzelNyZjY4VEFvNVdpMXZ2WU5RSFQyTmQ2ZHZXNlEvNnlyeTZBa21I?=
 =?utf-8?B?amNWTkpiODRDcFp6V1dSeW02WDVYMTVQdFlLbGV4NFMzdW0wb2ZFMnpjZS9T?=
 =?utf-8?B?T1RpSTZibERaaWE5WVVDNmZMTlB3RUxSRHBtU2VGU3dtKzdBWFpmRWNsZWtJ?=
 =?utf-8?B?R3hjdU9SK2V5UldSYmJtd0JWNktuUm51dDRjbWJ1MlgxVnBvTVptL2RlZERQ?=
 =?utf-8?B?SUxNUHlMc3JFUklZK2RkQ0dDOEpJUHRUbndvcWpZUmlac1BCTG5pTUt4SXV0?=
 =?utf-8?B?R3BOam1jMjZtOHJrRkN4bHZpREhFOEg1SzVNYUFBYnFQL0ovcGYzOWhBWXcz?=
 =?utf-8?B?Z2Z3Q3BKK1BGTHorMzc3OFNsTEVBVWdkaldRRTNaS2VKUzZ2YmM1TWYrd3VC?=
 =?utf-8?B?WkdXQStrTGY1TmZjcEtaNzJlTDVoZmdSSk12NkFDS0llbWErRW8zSWhqazJq?=
 =?utf-8?B?NUJZdDh2YUJNTWR1blR3d1hJYXdvbEZZSGJ0dXFFSCsvemVjaFFrOFBBbUlp?=
 =?utf-8?B?UGYyMk52c2lhbDRZdnREMkoveWZqdW45a0JlSktSSU5hakNnOGh6UXpkeVU1?=
 =?utf-8?B?V1hFdjBqa3ZjSGRJcmxobWF0b2Uzb1ZNNi9PMmRQNUFwTWpZQ2VlWnBQd2po?=
 =?utf-8?B?TzA5aHl0ODRqSUs5U0pMd2lDeXY4NzUrWWZqeTk0bytaVVBoV05UZ0crS1lt?=
 =?utf-8?B?Mk5KeHNNRkV1dDBaeVFPUWxSd2tsQ0xRN3V1SU5sZS9jNjB1MlFxQ1J0ekhq?=
 =?utf-8?B?cnArakdiRllnRVREalVPcjB2UGVpTjZhSy80Sk9iRS83N2Y4WWhDWFNnVDdk?=
 =?utf-8?B?RXpFR3hsanAwNHIrZkoyTDNKYzMvazl2QmZpK0pEUWY3YUJsQjIvdHloYnJX?=
 =?utf-8?B?UFNTdXo4WGRDbUVMWWVIdkRFUSs0L1J2SEFDOEJ2QU1TSW9lVU5YZWNyNzdk?=
 =?utf-8?B?VGhmS0F3WnA3SUFyblBUNXQrVEZIUkRSam1vbVV0VWdJbWdhelJaRTV3SUlU?=
 =?utf-8?B?VnJHa2hxZC9Vblo1Rm5kVlZtcEltV0l6ZE9MWHVEb21PYUJXZlU3NlBoRUJH?=
 =?utf-8?B?K3BKMEkxZmR0KzAwWlFpVXh5aHAvbGJtVWlCMmE2Tm9nOUI5SFFvWEY3cEYy?=
 =?utf-8?B?WVZRMlgvM3cvYVpBb3dJVms3SDhvaXJmQkE4TE44eDhsb0JjS0I0UW01MDB2?=
 =?utf-8?B?R2ZLdWJYcGNsRVBuZVN1NHRJQ1FCWGpzR0x3NlVrTzhpZlkzUTRCZ2YyaGd0?=
 =?utf-8?B?ZTNHbTU0ZVRFK2toYVh4NVRBbnNQUitPQnROYkRQZVBLNUU3TGpRc3FBRVdw?=
 =?utf-8?B?b1Iwam9ZdndQZVl5TTA0dVhrclQ3L3F3YmNEaGNBbE5qM0tscTlycFFxeE90?=
 =?utf-8?B?U3A1SXYrWDFucldISjFxQTROdzQ0bUJBWGxHc3lucGYwRy8yL2FUKzR6Vmxv?=
 =?utf-8?B?K28xVzdKK3d4RENmcEM4RHM0V1htU25MZVVtajUzUG1QVHhsakMreUowd2E2?=
 =?utf-8?B?MFlSQkZ4aFBPQjVkUGNtRXpobWwvTklvcHFneUhtdGlCdVcvVSt0eXZJYU5H?=
 =?utf-8?B?K3BkTFBVQ1ZhL3gzM1huWGlNT1JUMk5rQlNrYmhaenA2eWNGWXZTMllBRTJX?=
 =?utf-8?B?Z1lBZ21FMU9CeUozS3RZbzlwekRaODF5MjFubERpTkV1bUNDVzdWMlBDeFUx?=
 =?utf-8?B?KzBjRU5kVHg4U0RCR09DYTdwTWhaMk9kYkpMQUp3L0VURFpZU3Y5cllqN1Jl?=
 =?utf-8?B?UXkveFBhT3dKYWVkZnlVeTA5UEEvNXRGS3Q1QnlVbWhlMFV1NGhQRzZRc1VE?=
 =?utf-8?B?RFh0WngzUVVNRlpqVnBHSC9lRml2b0IwSFRqWEF5YWtIblNiR0t5b0tieVh2?=
 =?utf-8?B?alRyS3c3WDEvSU90SWpmT0lkYWhvR2NuNUN2cFZVbGhjZFVVRVYwaGhTVkV2?=
 =?utf-8?B?Nk9IV08vZUo2SnFzeFZwRmxjVlFPMXRiS3RHYkswdzdwa0FIN053ZUY3bkZq?=
 =?utf-8?B?OHlaRnk0OFBJL3FYWGZOWVlkU0dsYTRnSTkyNW5zTG53M2N3Y09aMWgxY1Y2?=
 =?utf-8?B?TGVnQ1Nma2I1dU1pakdEbDNGNjFPNmo5anpyRDZWTWxWd1BQOXJJcGRLMUs3?=
 =?utf-8?B?RjN4anpSZjNTbHIrc3lSbGhlbUd2T0hXKzdJN3ZPZGMzbWhYYmpOT2V6a2lz?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C3402E8DD1424F848E343CF53BFF11@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf1e480-5a99-4ad7-73c9-08dc903c0393
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:44:21.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MXSUZhWd4ikEUSbIJwtvkJAhAsEIUR9GYu3xHEAf/Vq8jllO+aP/DrCjwaiPvcDM9f1krUMevLTjeLDq0KgMWtCLsrJsiZtIwjpoIEG/HUv9gBYDeug0bld4yw5VYni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10101
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DUZPR07MB10101.eurprd07.prod.outlook.com

DQoNCkxlIDE4LzA2LzIwMjQgw6AgMjE6NDEsIE1heHdlbGwgQmxhbmQgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgbWJsYW5kQG1vdG9y
b2xhLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IE9uIFR1ZSwg
SnVuIDE4LCAyMDI0IGF0IDA2OjM4OjI0UE0gR01ULCBMRVJPWSBDaHJpc3RvcGhlIHdyb3RlOg0K
Pj4gTGUgMTgvMDYvMjAyNCDDoCAxNjo0MCwgTWF4d2VsbCBCbGFuZCBhIMOpY3JpdCA6DQo+Pj4g
QEAgLTY0LDEwICs2NSwxMSBAQCBzdGF0aWMgaW50IHB0ZHVtcF9wNGRfZW50cnkocDRkX3QgKnA0
ZCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPj4+ICAgICAgICAgICBpZiAoc3QtPmVmZmVjdGl2ZV9w
cm90KQ0KPj4+ICAgICAgICAgICAgICAgICAgIHN0LT5lZmZlY3RpdmVfcHJvdChzdCwgMSwgcDRk
X3ZhbCh2YWwpKTsNCj4+Pg0KPj4+IC0gICAgICAgaWYgKHA0ZF9sZWFmKHZhbCkpIHsNCj4+PiAr
ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX1NVUFBPUlRTX05PTl9MRUFGX1BURFVN
UCkgfHwgcGdkX2xlYWYodmFsKSkNCj4+DQo+PiBEb24ndCB5b3UgbWVhbiBwNGRfbGVhZigpIGhl
cmUgaW5zdGVhZCBvZiBwZ2RfbGVhZigpID8NCj4+IERvbid0IHlvdSBtZWFuIHB1ZF9sZWFmKCkg
aGVyZSBpbnN0ZWFkIG9mIHBnZF9sZWFmKCkgPw0KPj4gRG9uJ3QgeW91IG1lYW4gcG1kX2xlYWYo
KSBoZXJlIGluc3RlYWQgb2YgcGdkX2xlYWYoKSA/DQo+IA0KPiBPaCBteSwgdGhpcyBpcyBlbWJh
cnJhc3NpbmcuICktOg0KPiANCj4gSGVuY2UgdGhlIHJldmlldyBwcm9jZXNzLS0tdGhhbmsgeW91
IGZvciBjYXRjaGluZyB0aGVzZSwgd2lsbCBmaXggaW4gdjUuDQoNCk1heWJlIHdlIGNvdWxkIGhh
dmUgYSBuaWNlciBjb2RlIHdpdGggc29tZXRoaW5nIGxpa2U6DQoNCnN0YXRpYyBpbmxpbmUgYm9v
bCBoYXNfbm9uX2xlYWZfcHRkdW1wKCkNCnsNCglyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfQVJD
SF9TVVBQT1JUU19OT05fTEVBRl9QVERVTVApOw0KfQ0KDQpzdGF0aWMgaW50IHB0ZHVtcF9wNGRf
ZW50cnkoLi4uKQ0Kew0KCS4uLg0KCWlmIChoYXNfbm9uX2xlYWZfcHRkdW1wKCkgfHwgcGdkX2xl
YWYodmFsKSkNCgkJLi4uDQp9DQoNCkNocmlzdG9waGUNCg==

