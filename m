Return-Path: <linux-kernel+bounces-516344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AB5A36FED
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9BE3AE8E7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF9D1624C4;
	Sat, 15 Feb 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XKCgPwKR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A011DF982
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641343; cv=fail; b=OlNuFB5xgoJzaLOz9l5B6z/sZrC2AdJNlTjRqHWI4SIvfDRh8AnD9BKUGPy3nDLAdHBMKPoQraomwTlhEmRmUcRA8rRX1YbPn8UBDUvvYifvmpM5RBQN8AtDgRMcBuK6NZbf70SNpwK/iRyFjnR6smtK228E+Pu6s6koayRqCw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641343; c=relaxed/simple;
	bh=loIXMstYIQxTH6Eu48JqZLCFOYhMgsOYsXRKwFB0Zgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=plSHtFUKNQaVlWFjkqR/WVWOFFaefHHesAia+DrUl2NfnS5j/jCsBqwCUYL5+kE4BTRAq4M6MSR3unaZH8f7gQv6ZUvbAi+6QubDr0EY2xuQRb39Uy+d3bMGJ8EflaRPzskSMXjHpwCd5xiDqpIbx/O3I6ig6U7HQT8UshWxfS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XKCgPwKR; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2gN7g1wr0pF6y4bBqwozR1kZRP0NMzLRLNThkMneDLyiKxkDxcwCfrMAxTO5QwN4fjBfiB+ODnj2t9qHAakSsu6V28RnPC5igTQeVLuP2QfJgjh96P/R7yhtLrNKB+DeDbVq+Y5Ju5XNrnLvFYkOwREHD84G7lmEo/3KXC6Jr0Q9KXlp6kSCgAj/ZUZkXrF7KCd7nyZXrO2EMPgTYGr+CtzAce5Lw4NN0N6qKeQlakKLpuhBhxTasf78BxQ1kRB++mm55OUxy3h5pjGTdPyW10S4bGhJrImdmnaPBx7cfPSizGfUpd8TzvwcnEACQmm70fQJ7wWkTqIZiUSjeruYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loIXMstYIQxTH6Eu48JqZLCFOYhMgsOYsXRKwFB0Zgo=;
 b=TLWrVdfj8sqIRBqAA837MmXGSzUc7evQbW/OmJU258wqiDhiQfMnkhnFj4QHkLd4MiFZaSDST+6iXhnY4mLrz5UDnhBe6uqPrWR9LWlWjX+7uI2b/Sj8mdgY3h2/B59O6x89y21bXJsDmplGidH2tcHmKfP7aumrQaMy3iE3X85HFYw/YULYIpjwLyuFLSA6LHGS2+XtES2djAwky87GmSEsHq5leSAN/RdL6vox66JDHfl5krd1APoT232kz5w2mAAyQ0Ls8kaEUO3zEr2gjPwc7rPCxGam9xHfgujXULXBHc9US4hQztBs30lDWZ2aUChHesop/JIWOhiSC2NLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loIXMstYIQxTH6Eu48JqZLCFOYhMgsOYsXRKwFB0Zgo=;
 b=XKCgPwKRTzvOfnOAp0qwZ/ZXUnRgmsGYXEFFz6tmVDcT5Lq3aMTsv+uC7fDMYYuCSK2EJNgfeXek4vlFv72r3q0xgqxD5WojA/JeySyiUlXL3Mhb4Iyi/S8vq4uJvLzrngFSRfr9OHMFm2scootSyoXCzLzc7IhIHl7Q5NyWfaH7pnMFvj3tNYBULSPl9RvZ5y+T/I+ungxwTzz0VDSKR5OrK8cENUR4RtNosi70BOOG+kCc3M70z/mn0gnfGiV/QxS4OBZ/FLUixqoxBcPKeboaHPxVm1sUmpp8YhEpsvNQYAIPtQB1nerv+ag1rGBA+BVgQsx+lgfI7gx9tGZfPw==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sat, 15 Feb
 2025 17:40:26 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 17:40:26 +0000
From: <Dharma.B@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <Varshini.Rajendran@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: soc: atmel: fix the args passed to AT91_SOC
Thread-Topic: [PATCH] drivers: soc: atmel: fix the args passed to AT91_SOC
Thread-Index: AQHbZKw6Ok+ZUGx9okGeVAl6MZ8VPLNIzCoAgAAL4YA=
Date: Sat, 15 Feb 2025 17:40:26 +0000
Message-ID: <ae01d358-308c-43fc-9f23-ef20f1cee54d@microchip.com>
References: <20250112-atmel-soc-v1-1-822937f1dd5a@microchip.com>
 <ee14c4ef-04d9-488a-8304-75d9401b76c5@tuxon.dev>
In-Reply-To: <ee14c4ef-04d9-488a-8304-75d9401b76c5@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|CYXPR11MB8731:EE_
x-ms-office365-filtering-correlation-id: 0049dea2-97d5-41d1-a673-08dd4de7d50a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NllGcHJmNE5aek53QjhEcVpqalVKNlJOdm1rM1p1dTVyWkJNSlRpY3NxQlVn?=
 =?utf-8?B?Rk1YZnBqMXlGY09DNDIreTBOTVJOVHFsYmF0TVNWaFJFeW1rdzV6S1FtN2FM?=
 =?utf-8?B?bElJV1RKYzZkMHpySWJnNGFPZnpRZEkwL2lpM3ZKY3RDVlVMeks2SklBVGFa?=
 =?utf-8?B?WDhpSEFscDNKdEdseFRYVjNOdlY3T2tabTFVaDlERUpWaEZWZjFaYnJOL0Uv?=
 =?utf-8?B?Vng2MjdHNUQ5VUZPdWFQQzRYQ3RTM2hLczZDYjZPNGw2RW9vVzJBRkwwZlBY?=
 =?utf-8?B?MEVDSWRPeGJoblNBUDFhT0hYNE5GZlBaaEJielFBelZIZzlFOXNFM0xxbm5O?=
 =?utf-8?B?MU1kZUVGcE42MGhiakd2TnVBV1g3am9vb0R0NGFxRldGbW55VmtuUmFyRDNV?=
 =?utf-8?B?eFBTL0U2WTUwejREOXpFZDFmM0MveHdXbDJYaHNGUzlGdldGQUVlaUJwTS9I?=
 =?utf-8?B?cVJ4WWxOc3ZBd1FpUzg0QjE3Qjl0WWpUQjM5TmZWbVBXWnFuejBOSXNQR2tU?=
 =?utf-8?B?K2Z5aXhvVUFQMHhmanBtTGVxaDhvcXdFS1dGRXl3bGxVT0FoS2NId1JMN0dz?=
 =?utf-8?B?RXN3OG1rWkRtamY1eTN2aWhabmlPVDlnaTZseU5haUFPeDExZ0RCWTNJNk1N?=
 =?utf-8?B?N2VoaDZKK20wbHkwY2orRmwxL3B4bTAyNGxOaGFGS3NnU3VpcHpPU1dVQzRS?=
 =?utf-8?B?aDNHaVF1YkwrTnQ0a1lxbXZWOGFrMmpBNzVvcDZmbkRqN055UWxDalI1T09l?=
 =?utf-8?B?c2t1RlgyTmtiS1ZoSitqdUFhNCtpZHBQUExxTHlrQUJRcDVtYVdJQVlsUmw4?=
 =?utf-8?B?SUs5TmN1ZlMwUTN3eW9DakN6eW1RRHRFL0Y5SjNseGt3eldiRkVWNTNCTUFC?=
 =?utf-8?B?MmNpVlFPT3JXMFFkWWpiaXc3alVGSXdtZGkwNCtkMFB2RGM2Z29BN0FkelZm?=
 =?utf-8?B?YmVycWE4NjVrSy85SldKa0dYZHoxZmd4eWp3bWJLRTdldHB4U0wyOU8vTmNp?=
 =?utf-8?B?TGp0TlRpT3p6UW04MDRnclBQeHdNbkp3VCtDUzZNaytOb2x6cHp4Zi9CMmRl?=
 =?utf-8?B?RXF2cHE5aUttUERoRHVhN1N1eTFxTkhMaWNlZVhpV0dpanFpNmdlSFcrRVA4?=
 =?utf-8?B?OTVMN29YcFEyY1lBZ1pOZlFvUVR3Q2taMnBwQVZKM25ySWtJOHRRRzhWUDdx?=
 =?utf-8?B?U3gvWGJaR3dBSFFneHZXTEg4c0ZkUlhzcGZpYXo0TVVDTEl3YkhPUHdBYklZ?=
 =?utf-8?B?S2lKWmtkZHdnWE1rRzNqZHFGcmxNVEJHd1drdnNqUVhCK2l2UndzM1Flaktl?=
 =?utf-8?B?N25YRkNEdHFFRTV0VG9ocW1tZTdlS0lCWGlCTityaGtxc0JlKytJYmh2RGNI?=
 =?utf-8?B?cVcweTJlZk5yak52eVRiUjZGb0lHWkd1dTA1UmU5bVoyZGY5cVNMbzJRMDlm?=
 =?utf-8?B?V3hhK3E2eHJlTFlBYjBENEdzZEpNMDMvVnZ1MVlFN2VWREUvSkNFR2QwdXV5?=
 =?utf-8?B?eENSRjQ3Q3ZLRDl4Skc5bnBxWnU1MnZIOStYbWxMcStDMHROOFZSeWk3MGVo?=
 =?utf-8?B?bjNUVkhrck9kMFF1M2J5c1pTdkxvdzBkaG0xdHpXM3prZ2NtMENQUEJmMUdj?=
 =?utf-8?B?cmtXR1p2UHBjZzdwUjExYXdNbXlYWGtpOVFwTS9nbHpJUERjSGhlaXV2N0g0?=
 =?utf-8?B?MDhZTE81VFJkWE5GdGwyRmpnTVJiQXpHeC93VTJ3YXJHQ2p0UVdnWnRJeUZ4?=
 =?utf-8?B?bG1nSnZ3S1BNa0t6K1dTT0FmZlBWUGxIbnhUUXBwVGdxSGYzb1hadDFSY25u?=
 =?utf-8?B?NGJ3ZGJlaklZRWNtYXNTbkxkb3lKVXcxVW12Z0JzdWlvN2k1TkhIWGx1OGkz?=
 =?utf-8?B?LzJaQWNvVS9oVXl2b241bWhORTJiZnRPa2VjeW03MWFyblBQdnRyaGtUYnJP?=
 =?utf-8?Q?jgmc9dTh7zNJgXdeAr3WiBcH3qRz53wn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkhFamQ5V0t3YldCUmFYSjRwTWNXNUdTeFNmV0FDOXpNekhQeFJsOU5jSlAy?=
 =?utf-8?B?THRrOXFQQndxZVpmUVYzTE1xcVF1NXA1OVlqaG10K2tBQzJxUmgwMWd2Z1BY?=
 =?utf-8?B?bWJIQ1BYSkRGSDE2TlQ2aTBJbndjZUpZb0wyZ2M2Sk1vOHhpKzFpc0oyTytT?=
 =?utf-8?B?RGptYmxqMG9SNFBaa0F3aW5NMUhXcDlMV1plVGNFK2VaNlVzMStXVVRQbllv?=
 =?utf-8?B?b3ZYVjJkSXc2eC8zRUpld3E1SHQycTNDMWtFZmhVWk5tVmUwQ05GbExqY29T?=
 =?utf-8?B?QjJLVDR4MDNPakZlZlZFVVV2Y0ZnZGhpcmJscmdhRmxvVC83cHFwZloxODcz?=
 =?utf-8?B?eW02NE93MlEzUXZhR0RqQ0ZzbTZpTkdIMjdIQ2ZBd2VJbEUrU2xTYVZEQnN4?=
 =?utf-8?B?MkNLUkp5eklWQS9oeHNzT3lNR09zTUxneU9GazNZWDhEelZjaWJMYTF3YW0r?=
 =?utf-8?B?TDNaMkd1cERYRGluN1pPeXpTVVg1SkFNQ3E1cjdaRlEzaStvSWFxQVJndmNC?=
 =?utf-8?B?VG83VVdlbE5CK0tJOXlWOTkzRTc1YlhOQXhSYkhUVVNTVlAxWEJqbXR1cUdl?=
 =?utf-8?B?cTc1Y21hLzRhODJUYmJsV3czU000R3V1bjJEcitobW9xdk5yS2FUZjJCSXdX?=
 =?utf-8?B?Tit3ejNWb3JuNW9xTVZuV0t1U01EU0gvR2JVMnY5cTBPRzZwSFp0VHIrMFl5?=
 =?utf-8?B?UDlSMmpjZkdKMSs3bEFPTW9zYWNJWDk1eDVqdnAzUGN0Mnkva1Z3clpJaG9p?=
 =?utf-8?B?N0EwbWZhN1M2aEtnK1ZZMTdadkVzOUMvSmFmWTRXUUtEWU9tTWg1WGFncU45?=
 =?utf-8?B?MXNjOVNJb1E0Mi80T1p1dXo0SGNRbmJEaklUQ1JGLy8rQ0lheUJUM1plSnYw?=
 =?utf-8?B?MWxsZThaRE5nck9NNUM2RkpBbWRzTDZFN29uRHc1dFE5ZkhOc2JUVnpDcW5K?=
 =?utf-8?B?N0FCdFF4Q2s3RXd1cGVINUpFZ3dKMlhobEpPTXM1aXUyN3FtakE5V3BuUm1w?=
 =?utf-8?B?YUZ3N2xXSGlod2lXUC9iTTBucWVYcjJ4dmJwcGNtWHZoTjdJdTkvOUxjMURt?=
 =?utf-8?B?MGRiZUZQQ0prWUQrQm1xYVRUQXA1QlAvZm9SLzhvSXhiSXZ6RjltVFVyQjND?=
 =?utf-8?B?WGM3eEJ2cjRjREdiTnhaLzRZbkllMktHZGVOTlhHMnQvakZ2ZVFPMzl3RXZt?=
 =?utf-8?B?dklJOGhYenJaa3BvUjBTOGJxUzIwY1hhZXZRNFhqNng2dHdmci9MbXJsc1BQ?=
 =?utf-8?B?MEJodUFpclRtbG1wMHlUYlRSUjZYQXhEYk5qTjFkbUE3UWR5R0pibUlsVzRG?=
 =?utf-8?B?ZU1vb3hIRnpjYVZmczdaREVMNS8yZlczeTMxbVBTTWdYNndtamg3bklIQTlX?=
 =?utf-8?B?bm16WDJjYkFrUjRvYmJGMmNPN3RKOXhVTW04UjRoQkVQbUpQR2UyTnNWVm9a?=
 =?utf-8?B?b0xWcXRXTWxJVlRsajgvOW1Sc2NDQlJpdWFJenJrakNSUWt2VVVMd2RDakhw?=
 =?utf-8?B?Nk80Z0F0bDFiQ2pPK2R6MTM0Y3haaVdpVVVCMmNhTUFzNTB4ZmpPZUZtYTdl?=
 =?utf-8?B?QTJWMDI2Tmw2K2gwcy9qTktOZm4wOHdQSTBJYlhpV0lnV2FEY29Wbm92Y0du?=
 =?utf-8?B?U1hQV2pwNDgxUjYveXV5Szg4dTNTc1c5T0tLMEZ5TmhyWHo2cVVpdDhKRXNM?=
 =?utf-8?B?bHNMNjRPL3pFS21LNnJLYlNHN1c5WkViM0ZtSnZKQStabm5YdVYvTVVKcmFq?=
 =?utf-8?B?ZlBaRGU5b0d3M3BESDZpelhxMjBYQVU1cmgzaE1xelBya1h4Q0VYWEtPNCtH?=
 =?utf-8?B?NzB3TDZZai94LzNESjRjQ2dtWk91ajR1Y3U4L3lzN2tkQUlEM3JJRmVmYThQ?=
 =?utf-8?B?RHBzSHRqeDZPR3Vld0x3ZHdWL2kwYTFobldKOU1CaHVrblZqcTNMVVRldFNZ?=
 =?utf-8?B?Q1ZFTTFqUDYvdE1HWlFvSk1RbGlBRGc3NEY5RThqbitnRFFSTldSdUNsNmdl?=
 =?utf-8?B?cW9Ud2lDaFdWR2hPYkFkU0xzTjdJQ1hrMTk3TktoMjlOdWQvMzdCakU2WXMx?=
 =?utf-8?B?dGk3ZUJNVWVRR2Y2NTdLZ2FERm4vQzZpM2pqaW1BZVJmbktEZmhDeURLU1I2?=
 =?utf-8?Q?ygo9S03M8kt2aLHS1NcfyWJGU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A887D26DF5DFF41A74FD58CC90661B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0049dea2-97d5-41d1-a673-08dd4de7d50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 17:40:26.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvZHL0eBHafYZNQdCcnwrLJZCMDI9Igdm24HjkQX1OoOPDUAuFZevbm96cEs06JcYSkSp7em7ELKgSg7ICNkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731

SGkgQ2xhdWRpdSwNCg0KT24gMTUvMDIvMjUgMTA6MjcgcG0sIENsYXVkaXUgQmV6bmVhIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLCBEaGFybWEs
DQo+IA0KPiBPbiAxMi4wMS4yMDI1IDA2OjQxLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6
DQo+PiBmaXggdGhlIGFyZ3VtZW50cyBwYXNzZWQgdG8gdGhlIEFUOTFfU09DIGZvciBTQU05WDc1
IFNpUC4NCj4+DQo+PiBGaXhlczogNWViNjRmMmIzNjhmICgiQVJNOiBhdDkxOiBhZGQgc3VwcG9y
dCBpbiBTb0MgZHJpdmVyIGZvciBuZXcgc2FtOXg3IikNCj4+IFNpZ25lZC1vZmYtYnk6IERoYXJt
YSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBk
cml2ZXJzL3NvYy9hdG1lbC9zb2MuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb2MvYXRtZWwvc29jLmMgYi9kcml2ZXJzL3NvYy9hdG1lbC9zb2MuYw0K
Pj4gaW5kZXggMjk4YjU0MmRkMWMwLi4yNzNjMTQyMGZkNDAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL3NvYy9hdG1lbC9zb2MuYw0KPj4gKysrIGIvZHJpdmVycy9zb2MvYXRtZWwvc29jLmMNCj4+
IEBAIC0xMTEsMTcgKzExMSwxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0OTFfc29jIHNvY3Nb
XSBfX2luaXRjb25zdCA9IHsNCj4+ICAgICAgICBBVDkxX1NPQyhTQU05WDdfQ0lEUl9NQVRDSCwg
QVQ5MV9DSURSX01BVENIX01BU0ssDQo+PiAgICAgICAgICAgICAgICAgQVQ5MV9DSURSX1ZFUlNJ
T05fTUFTSywgU0FNOVg3NV9FWElEX01BVENILA0KPj4gICAgICAgICAgICAgICAgICJzYW05eDc1
IiwgInNhbTl4NyIpLA0KPj4gLSAgICAgQVQ5MV9TT0MoU0FNOVg3X0NJRFJfTUFUQ0gsIFNBTTlY
NzVfRDFNX0VYSURfTUFUQ0gsDQo+PiAtICAgICAgICAgICAgICBBVDkxX0NJRFJfVkVSU0lPTl9N
QVNLLCBTQU05WDc1X0VYSURfTUFUQ0gsDQo+PiArICAgICBBVDkxX1NPQyhTQU05WDdfQ0lEUl9N
QVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ssDQo+PiArICAgICAgICAgICAgICBBVDkxX0NJRFJf
VkVSU0lPTl9NQVNLLCBTQU05WDc1X0QxTV9FWElEX01BVENILA0KPiANCj4gQXMgb2YgWzFdLCBj
aGFwdGVyIDM3LjYuMTEuIERCR1UgQ2hpcCBJRCBSZWdpc3RlciwgdGhlIGNoaXAgaWQgaXMgb24g
Yml0cw0KPiAzMC4uMC4gQVQ5MV9DSURSX01BVENIX01BU0sgaXMgZGVmaW5lZCBhcw0KDQpUaGFu
a3MgZm9yIHBvaW50aW5nIG91dCB0aGF0Lg0KDQo+IA0KPiAjZGVmaW5lIEFUOTFfQ0lEUl9NQVRD
SF9NQVNLICAgICAgICAgICAgR0VOTUFTSygzMCwgNSkNCj4gDQo+IElzIHRoZXJlIHNvbWV0aGlu
ZyB3cm9uZyBpbiBbMV0gPw0KDQpObywNCkkgc2VlIGF0OTFybTkyMDAsIHNhbWE1ZDIgaGFzIGZp
cnN0IDQgYml0cyByZXNlcnZlZCBmb3IgdmVyc2lvbiAoMyBmb3IgDQpnYWxsYXJkbykgYnV0IG5v
dCBmb3Igc2FtOXg2MCBhbmQgc2FtOXg3IChlbnRpcmUgMzAgYml0cyBpcyByZXNlcnZlZCBmb3Ig
DQpDSElEIGFuZCAzMXN0IGJpdCBmb3IgRVhUSUQpLg0KDQpzaG91bGQgZml4IHRoYXQuDQo+IA0K
PiBUaGFuayB5b3UsDQo+IENsYXVkaXUNCj4gDQo+IFsxXQ0KPiBodHRwczovL3d3MS5taWNyb2No
aXAuY29tL2Rvd25sb2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL01QVTMyL1Byb2R1Y3REb2N1
bWVudHMvRGF0YVNoZWV0cy9TQU05WDctU2VyaWVzLURhdGEtU2hlZXQtRFM2MDAwMTgxMy5wZGYN
Cj4gDQo+PiAgICAgICAgICAgICAgICAgInNhbTl4NzUgMTZNQiBERFIyIFNpUCIsICJzYW05eDci
KSwNCj4+IC0gICAgIEFUOTFfU09DKFNBTTlYN19DSURSX01BVENILCBTQU05WDc1X0Q1TV9FWElE
X01BVENILA0KPj4gLSAgICAgICAgICAgICAgQVQ5MV9DSURSX1ZFUlNJT05fTUFTSywgU0FNOVg3
NV9FWElEX01BVENILA0KPj4gKyAgICAgQVQ5MV9TT0MoU0FNOVg3X0NJRFJfTUFUQ0gsIEFUOTFf
Q0lEUl9NQVRDSF9NQVNLLA0KPj4gKyAgICAgICAgICAgICAgQVQ5MV9DSURSX1ZFUlNJT05fTUFT
SywgU0FNOVg3NV9ENU1fRVhJRF9NQVRDSCwNCj4+ICAgICAgICAgICAgICAgICAic2FtOXg3NSA2
NE1CIEREUjIgU2lQIiwgInNhbTl4NyIpLA0KPj4gLSAgICAgQVQ5MV9TT0MoU0FNOVg3X0NJRFJf
TUFUQ0gsIFNBTTlYNzVfRDFHX0VYSURfTUFUQ0gsDQo+PiAtICAgICAgICAgICAgICBBVDkxX0NJ
RFJfVkVSU0lPTl9NQVNLLCBTQU05WDc1X0VYSURfTUFUQ0gsDQo+PiArICAgICBBVDkxX1NPQyhT
QU05WDdfQ0lEUl9NQVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ssDQo+PiArICAgICAgICAgICAg
ICBBVDkxX0NJRFJfVkVSU0lPTl9NQVNLLCBTQU05WDc1X0QxR19FWElEX01BVENILA0KPj4gICAg
ICAgICAgICAgICAgICJzYW05eDc1IDEyNU1CIEREUjNMIFNpUCAiLCAic2FtOXg3IiksDQo+PiAt
ICAgICBBVDkxX1NPQyhTQU05WDdfQ0lEUl9NQVRDSCwgU0FNOVg3NV9EMkdfRVhJRF9NQVRDSCwN
Cj4+IC0gICAgICAgICAgICAgIEFUOTFfQ0lEUl9WRVJTSU9OX01BU0ssIFNBTTlYNzVfRVhJRF9N
QVRDSCwNCj4+ICsgICAgIEFUOTFfU09DKFNBTTlYN19DSURSX01BVENILCBBVDkxX0NJRFJfTUFU
Q0hfTUFTSywNCj4+ICsgICAgICAgICAgICAgIEFUOTFfQ0lEUl9WRVJTSU9OX01BU0ssIFNBTTlY
NzVfRDJHX0VYSURfTUFUQ0gsDQo+PiAgICAgICAgICAgICAgICAgInNhbTl4NzUgMjUwTUIgRERS
M0wgU2lQIiwgInNhbTl4NyIpLA0KPj4gICAjZW5kaWYNCj4+ICAgI2lmZGVmIENPTkZJR19TT0Nf
U0FNQTUNCj4+DQo+PiAtLS0NCj4+IGJhc2UtY29tbWl0OiAyYjg4ODUxZjU4M2QzYzRlNDBiY2Q0
MGNmZTE5NjUyNDFlYzIyOWRkDQo+PiBjaGFuZ2UtaWQ6IDIwMjUwMTEyLWF0bWVsLXNvYy00MGM0
YjQwYzliNjgNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+IA0KDQoNCi0tIA0KV2l0aCBCZXN0IFJl
Z2FyZHMsDQpEaGFybWEgQi4NCg==

