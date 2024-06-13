Return-Path: <linux-kernel+bounces-212880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48C9067CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B2BB23DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AB39FCE;
	Thu, 13 Jun 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6rEAlW8"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0556458
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268585; cv=fail; b=rZGS+aj4DgQbp1i3wwvoPgFGog7gAe3MIY6f5uVr2MzgfQaDBtDsKM1RaWSsfxdhoxSo+s/TVCHqBZXpzSr4yn9a+PoEUX09FTs/nVEfZAC6CbSnxpjbyWTk+8/fmc31oK+8qFKlQhhPj4ZQwyI90P9JlAStENTUvvnPu2MN43I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268585; c=relaxed/simple;
	bh=KntcdFB+2W9/d89cxPtWp6ofyr9dbFwkM7wo/XP0DZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urUvkzm77EUdS19xevxXHYwstisOdaoswx/28RaTUi0xkTKlZi0ZfbH5984lnzhq/PDb01PJqZBo07OrdegKanF7GIIyM461pQsteGhDmeEXbFJ/FPHFfz0o1j/UiHv3PsOsuDfznDYWawe2n/TEoFGXXq59BEQE2O43VRCKWVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M6rEAlW8; arc=fail smtp.client-ip=40.107.8.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1a6WtNqM4Ttd4A0dl/QjEdprV5maU9V+EwPzwwyZwjmOVPzSaU9491MpCR2vk+Ongg0/8eVYPJ4YcsrEO9Ejg/6UcvASin00+ySV2T2DhFA8NkqDOugJBftKTcqVYXkgqIlFrmzycBtaM1I9TL5/iMLcpRfe22c2wWg2Fg94kxUPyyjYjfMx6/9VS0nixXilkWb4jEl/C4UbZ+MbsDLJfLEs6yQTUQT6ag9wbX5MeFXK7v8aUZ7cRVb58njkG2c7rIGf9iIFuW2UVFP/6BD3GFzrEObJifFtorHY8KAHvv0imFeVQqCWiIpu1OMqh9HDN5s7qSqrSZDonE3QgzSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txCTghZ0Yw4ehOXF/Xv14tXm2OVOGnryiBLNR7komyM=;
 b=evPZBu4/M2yweLXtFjSxquYmMTxd/Ey4kKg9DfHdhNJbxk85cCBNewUnSOsW7J8Ckh3W+3gqWCaW4aavCXzCjz61Lc/O4vXNgc3VqPr0rP+VKCMYJ2FrhIAU+NKYfmYw0H1xMTR4kvnmcZ1kU2ehpL/kGQuUf7jQoiWISVtB9OVRSQbS9JBPzw8GkAp225F8uD4I4YP+Kz7HbyS8fVc59mv9zELGkuYUEjgfeuNVfVzIRrfX2sBx3ELkUi/vTVY3OUY2Il9eM/GFut+OevhtAXI+AgLNRY2qjVOqyI+gYofAoxNMtLHv/io6kfOrBj156deq7V/qStolSaOGAWIGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txCTghZ0Yw4ehOXF/Xv14tXm2OVOGnryiBLNR7komyM=;
 b=M6rEAlW8zbE2u1Ju1I5k9yTRn7Checw+EMYWbiilqB6D00FEUv68C8nBy+wh+AKsrsOoOxqkOyKX6p9A/yCBcY52pZMvdTynDFQzxWaAEOXGXl7zC/6p4YObo955lHoUXkHJ69ocxnP6cZGFuoomvW/ZyIFx9BdfVLfAy2908Yo=
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.39; Thu, 13 Jun
 2024 08:49:39 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 08:49:39 +0000
From: Zhai He <zhai.he@nxp.com>
To: Barry Song <baohua@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang
	<zhipeng.wang_1@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, Christoph
 Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Topic: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Index:
 AQHavKBGxUJQI1jHm0WeihrG1yRS87HEeMkAgAAvWICAAE1E8IAAFNsAgAAdaCCAABFDAIAAAPqggAAWC4CAAAmTEA==
Date: Thu, 13 Jun 2024 08:49:39 +0000
Message-ID:
 <AS1PR04MB95593F3D6C60573707DFFF0DEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
References: <20240612081216.1319089-1-zhai.he@nxp.com>
 <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
 <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com>
 <AS1PR04MB955915A33F184E141BCD69A2EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4w=MYMOoQnY7c9nE-iCdzP9amCyYTkje-PNGYe35u+1Kg@mail.gmail.com>
 <AS1PR04MB955988579ADFC6B5CCC8BBB3EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4wyQnAhzq_KoAoMp6g89DHgjKo3VfmE=o=g3HANGj6n+Q@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4wyQnAhzq_KoAoMp6g89DHgjKo3VfmE=o=g3HANGj6n+Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9559:EE_|AM7PR04MB6773:EE_
x-ms-office365-filtering-correlation-id: 11618ba2-1dcc-43cf-a8fc-08dc8b85c29d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkdubGxhMWNQa3BoTXVkbEdhNm1GN0E3RHBDc3pqUUpmd1FHL3cvbi9Wa3ZY?=
 =?utf-8?B?RkR5UTFwQVpSOGlYK0crZ0QvbXVmcEJjb0dTRC9Udkp3NG1GMXhNVW5sVUpO?=
 =?utf-8?B?TGUyS3dFRzhNN08zOTJubkRYQ0V5bmN3R3BxMWdCL2JBK2Q1YjROMjdXc0JY?=
 =?utf-8?B?OThaRWJ0bk9POXhjTENVaFRBeVcwMjFiZU0rMFo4Z1A3S09FTktFTUJwazRC?=
 =?utf-8?B?TjAwRVJ0dkh6U2JUYXpCZ2xWbzF4Ni9IcXpab3Z6Y1dpdkxnRDBEK3NKbzNl?=
 =?utf-8?B?NXBMSFZIUm82VjlleWIvay82SXQ1NExQdlE3OFdzUGFjZ2VrOVVxdVVidGkz?=
 =?utf-8?B?bmNyZ1p1UGJKdXJ5cEhPdHp4TEVwZHJ1ZlRtK1NUQm4wQVZxcTBjMndsdXk2?=
 =?utf-8?B?dElMcER5VDU0SUlKVllRZEhCb3FPREJFRkhYWGtDcFhOTndFNEwxRFBnOXhl?=
 =?utf-8?B?RE55aG82OWlwNGlUQmNWbTFxODA4VmFOakhIa0ZQblZrT2hQbDZyRUZNWVFW?=
 =?utf-8?B?QTJDRWVoZHd0bUtrcktaLzlaQ3dvaW5NM0NneVZ1b05zd1FZSXN2WU5ocS9q?=
 =?utf-8?B?R3YvY2tIWnd0NWNpK090TXY3Vi90bmNsZ0lZeUw0bkR3UWZmZFdhTTRlUkhq?=
 =?utf-8?B?TmRJeG1hYXhwd1Fqd2oxL1loSVJhZTI3M2lwdnhoeURWVUdobHRZMGVrRmZl?=
 =?utf-8?B?WDNOaGMvM1lNRk1kM0ZZNjNUVHFWeW5VNXdGTVBnMkI3dVB5SUpSQUZXSVlW?=
 =?utf-8?B?eEtERE5xUVJ0UWtYSHB3WGZwTXhYclgrKzBWMnViSnIwMm9Sa3JsbVBNRWhT?=
 =?utf-8?B?bDJ2b09KWXBIT0J5SjFtZ0ZiejRrMmw0YU9adyt2U2I5UUNkbDZ1NFc5RDk2?=
 =?utf-8?B?YjZyL2MyYnMvaFJYWk8wWnhlN3JzcU5NaFoyRDJwYWJ6czVqU3k1MGxpSlVQ?=
 =?utf-8?B?bkZXQnA1eUNvSzRWQUZEY2JUdC84MWFvU050aURCZUZ4bENQVWdKbXZCL1Zi?=
 =?utf-8?B?WWFIME92cW1hc1J3S1p6aWZkYmdCWTN0dnd2Vkp3ak0wdWRuZlNFVkhESHMv?=
 =?utf-8?B?cElveVlPOGZKY2o0Z2dHTFl4Yll3TjZiUjhpM3JBMDdUeTRLejlyNndDajRi?=
 =?utf-8?B?TjgvbmFpb0xNaHc3RlBwbjJiVFUwNEJRa0xBVlBoalNQQnFodnRIK0s1QVhC?=
 =?utf-8?B?WlNCWVdpazNXVWxWWkVtVCtydmlCM3p4UnZZRm5qd1RBL21CSFJuSkFxS3RH?=
 =?utf-8?B?eXd3eUsvb2UwQWUrNWl5T25SY0xPNkV5QVZFVC81ZlhXMGs2Q2xqWndDbHdD?=
 =?utf-8?B?KzVEN0ZMZVcrWlIycWJrOWd0S21FbDk3ckdWZVZ4RSt2bEhzbVdIdFAvcEZH?=
 =?utf-8?B?SDBYQ1RnQVJTVmxleGVGUEhXeE9Od2RsTVJMbnBKb3FJQ084ckNFbVp0M09n?=
 =?utf-8?B?V1hzdzJodWVKYnVZbzhIMS9pVjZQQVo3TUpJenRiRVZwWDhFdzR0V0ZzSnZt?=
 =?utf-8?B?TnlRQkVJbnllRmovQ3VTcjkzZmxtUlRZazA1dENLS0JJOTdnVVh2WEJwbFlF?=
 =?utf-8?B?WTRqdHNKWEQ4eklSd09oa0N4Z0IvSG43TTR2eHhFTm5MdnFVR3BGMGc1VnlO?=
 =?utf-8?B?aHc5Q1BQeFg4M1E5M010QmJNZkt4dm1remI3MTBZdTJZV1AvQVZOTVJ6azFH?=
 =?utf-8?B?T1Q0VGt6UzVmS2hrR0NEZ2MxUGlWc3BiN0hZSUlEM3F1eXM4WTYyeHlCd1pI?=
 =?utf-8?B?N0Uycm9HeC9WYmlIVnNkSDVORzJMcVJzODNoUkRJcytXR3RxVjZXS0FpQ2ZZ?=
 =?utf-8?B?S3I5RU5NN0RnOXJ2cWpkMDJzOVYxNkpoY3hucE1uT1djOVo0eEF1SzZiWGRz?=
 =?utf-8?Q?gUyDlWqi513z4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akEzTG05SVpqeTB2L2l1cHNMU2N4NVlLdmZvakFZbWRQRzJ1dFoyVnE0anMw?=
 =?utf-8?B?NnVYTFNZb0RnNWh2UkdoVkR0RWErbWpqZ2VsbWxPUnBlbUJUaS85a0gvWDEz?=
 =?utf-8?B?ekJFbGxUamdwWlpOOVlFOVY1blYwNXphVnRudWhXYmVubkI1MzZzODM3NEhv?=
 =?utf-8?B?d2FtbThiUkxVakdLc2RRdENzUTJDODY5Zm4zQm4vZUdYVFJQZVV3STRYUEhC?=
 =?utf-8?B?MXFtQWZ5V2c4VFMvRUJJOWQvbkNicU9Fa3h3Y0phWlNSUEdqc3VFdGNBaDNR?=
 =?utf-8?B?RzU0dHVGWjI1dEY1YTkyM2FUWEFTYytmRTFGd1MzSkZ2NE5OY0s1Z3NMVGx4?=
 =?utf-8?B?c3ZJQUNXQWgvQXQ1ZndBOURFMmI2V25kTVNjaFMyMVMyalBaV3NSanozYlBi?=
 =?utf-8?B?dXdueFMxcjkwR2UwNElKaC9CTDVaTXlRREdQcmtBNzhhS1FBalVuU2JxTUFI?=
 =?utf-8?B?MHlocnhkTGpvTFNCOW1XVWlYaVd2UU5lN3ZZVU1pQm5GSkVRMENKZ0hUUGt5?=
 =?utf-8?B?cmNlcnZUTmYreGNEWk51eDllYnc2MkxZVkNkRER6aE9zNnpKdzBQVS9SSnY2?=
 =?utf-8?B?S3ZrSkViMU51bThid2QzaEx2Q1lFbnhiRzJMOU1hVTBEaHhJUWE3MVpUd0Qr?=
 =?utf-8?B?dmdIMmh5QzE0WG01dUw1Mm9YS3FiM0dzZHdsNWd5QllXWlZsbWRFbWdURVUz?=
 =?utf-8?B?bHFpelJNSmFqbGQxWStJK3BFM2hmbnFOaG1Qd1dBcTNpVFZqbTNYUTIzWURY?=
 =?utf-8?B?RlUvUFRvNkZHcDVrUGsvcWxHaDl6ZFJNbGFGckd2ZHBiWnlETWFtY3V6Sldk?=
 =?utf-8?B?Uy9RRGR4QTJFR3g4SUhIZHAybEFTWHlKWjJSR3lodS9pR1Ryd1FveE5RWUFE?=
 =?utf-8?B?VE5QTHR0UmJCL2c0ZGJLc2VLRERtSktLeHA2eFFmemJ5VHF0TkFvK2ZjbC9F?=
 =?utf-8?B?T0NZZFNUVzJHaFJxUExyM2p6OGN0MHVzM0d1TmVqcWxuaWoxbkdBTnJVSFRn?=
 =?utf-8?B?QjlYaFBjc0t2bm9RcGxxeUdxSU1zM0l1by9Xem1pUEJreks1N24xdVJ4aHVH?=
 =?utf-8?B?Yjd6MGNqSWNUSjZFcWNHSkJBU0JBbXZteEZpMGtVdjQ5TkJkQmVJYmQvaW54?=
 =?utf-8?B?Q3gvRS8vQ2xxQ1BWWFh2TlprS2Zja1F3YU5HTWtWdGc1NUN4ekluc1lydmE4?=
 =?utf-8?B?THFIRE5IWng3Q3lMMmdFcGV0dExjZmxtRWJubVJKS2dyMTNVWUNpNjRxL2dv?=
 =?utf-8?B?YXFrWTlhRzA4dUtEMXhPVTVzeVg3bkZ2a0E0V0FmMEhub2grc3gyWWV1UTRa?=
 =?utf-8?B?bDQ5Y09oYjREeStEbTJHQ2J1YnMxTFRTcXlFalpkWFpWa2crVW1GS2VJbSt6?=
 =?utf-8?B?cXRCbDhLRFNpSmU0QzA4SE83VUNjT252SUhtenRTNE5XODVxc1l3U1JpY2M1?=
 =?utf-8?B?ZkY2V3BmSlJpMW5TQjZETnhPNmJNejBTdEIyMzYzcFB4cm1JNUY5Y2FuNUxZ?=
 =?utf-8?B?UVlPejh1YWY3ckFSMkhneGNFMkt1OVJaQnl4TEEvZjlPWDZrQzQ4c0EwUkRL?=
 =?utf-8?B?eFd0Y1k1Vm54MzhVL1R4N0FGd3BUNHNIcTcwY0pXb0F4UHZmKzdVYkdOSWNP?=
 =?utf-8?B?ajZqdjcyVklscGpBK3VtOS95cnQvK1BDVU5lQlNJZUVkeHl3K01scmZGMjZt?=
 =?utf-8?B?eE9mNXRIM2prTk56YTFNMThMN2pxaFNEMGZndE1rS0ZrZ3FuZWRrdk1HNkVi?=
 =?utf-8?B?K3NKUFF3ZXprU1I5MTBXUStlVzhjazFKMGFtTjJIY0s1VWttcVB5ZFR0Ym5z?=
 =?utf-8?B?cXR1UzdDK2FlenppMGFXWUxNRFpsR0hWcm43MnRDdW02c1dESkswYTVwdUow?=
 =?utf-8?B?aFRKekp0UHpzcWErNVJZWS8wbmNyRHowU2tQSFQ3b1pQVXR2SVBhL0JSN2h4?=
 =?utf-8?B?dHFIV2Y3Q2hLUUsxZFZaZ0ZOdHFkYk9FZkhPSStkN2dnV00vNkltZ3U2a0or?=
 =?utf-8?B?UXB4Yk9wZ0J3MFQ2azVxWWJLUWdBS2p3TGhEd2syb00yRkxHaUl1di9XdWho?=
 =?utf-8?B?YzFyWEJoUWJBRTJGUTJucS9WN3J4TkZvc3NHK1BRV3Y0QzRjUk1WcFNCeERk?=
 =?utf-8?Q?ui3Y=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_01BB_01DABDB1.AC96B570"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11618ba2-1dcc-43cf-a8fc-08dc8b85c29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:49:39.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKI52flvy7R1MC7kdJx23i2xhyMQcS+pOZTnVmvAFFgptv/UKXgcoKiLb3Hr284D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773

------=_NextPart_000_01BB_01DABDB1.AC96B570
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Barry Song <baohua@kernel.org>
> Sent: Thursday, June 13, 2024 3:38 PM
> To: Zhai He <zhai.he@nxp.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> Hellwig <hch@lst.de>
> Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when =
the
> device-specified CMA memory is not enough.
>=20
> Caution: This is an external email. Please take care when clicking =
links or
> opening attachments. When in doubt, report the message using the =
'Report this
> email' button
>=20
>=20
> On Thu, Jun 13, 2024 at 7:11=E2=80=AFPM Zhai He <zhai.he@nxp.com> =
wrote:
> >
> > > -----Original Message-----
> > > From: Barry Song <baohua@kernel.org>
> > > Sent: Thursday, June 13, 2024 2:15 PM
> > > To: Zhai He <zhai.he@nxp.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> > > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > Christoph Hellwig <hch@lst.de>
> > > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA
> > > when the device-specified CMA memory is not enough.
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thu, Jun 13, 2024 at 5:32=E2=80=AFPM Zhai He <zhai.he@nxp.com> =
wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Barry Song <baohua@kernel.org>
> > > > > Sent: Thursday, June 13, 2024 11:28 AM
> > > > > To: Zhai He <zhai.he@nxp.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>; =
sboyd@kernel.org;
> > > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> > > > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > > > Christoph Hellwig <hch@lst.de>
> > > > > Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default
> > > > > CMA when the device-specified CMA memory is not enough.
> > > > >
> > > > > Caution: This is an external email. Please take care when
> > > > > clicking links or opening attachments. When in doubt, report =
the
> > > > > message using the 'Report this email' button
> > > > >
> > > > >
> > > > > On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He =
<zhai.he@nxp.com> wrote:
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Barry Song <baohua@kernel.org>
> > > > > > > Sent: Thursday, June 13, 2024 5:37 AM
> > > > > > > To: Andrew Morton <akpm@linux-foundation.org>
> > > > > > > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org;
> > > > > > > linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> > > > > > > stable@vger.kernel.org; Zhipeng Wang
> > > > > > > <zhipeng.wang_1@nxp.com>; Jindong Yue =
<jindong.yue@nxp.com>;
> > > > > > > Christoph Hellwig <hch@lst.de>
> > > > > > > Subject: [EXT] Re: [PATCH v2] Supports to use the default
> > > > > > > CMA when the device-specified CMA memory is not enough.
> > > > > > >
> > > > > > > Caution: This is an external email. Please take care when
> > > > > > > clicking links or opening attachments. When in doubt, =
report
> > > > > > > the message using the 'Report this email' button
> > > > > > >
> > > > > > >
> > > > > > > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton
> > > > > > > <akpm@linux-foundation.org>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he"
> > > > > > > > <zhai.he@nxp.com>
> > > > > wrote:
> > > > > > > >
> > > > > > > > > From: He Zhai <zhai.he@nxp.com>
> > > > > > > >
> > > > > > > > (cc Barry & Christoph)
> > > > > > > >
> > > > > > > > What was your reason for adding cc:stable to the email =
headers?
> > > > > > > > Does this address some serious problem?  If so, please
> > > > > > > > fully describe that problem.
> > > > > > > >
> > > > > > > > > In the current code logic, if the device-specified CMA
> > > > > > > > > memory allocation fails, memory will not be allocated
> > > > > > > > > from the
> > > default CMA area.
> > > > > > > > > This patch will use the default cma region when the
> > > > > > > > > device's specified CMA is not enough.
> > > > > > > > >
> > > > > > > > > In addition, the log level of allocation failure is =
changed to debug.
> > > > > > > > > Because these logs will be printed when memory
> > > > > > > > > allocation from the device specified CMA fails, but if
> > > > > > > > > the allocation fails, it will be allocated from the
> > > > > > > > > default cma area. It can easily mislead
> > > > > developers'
> > > > > > > > > judgment.
> > > > > > >
> > > > > > > I am not convinced that this patch is correct. If
> > > > > > > device-specific CMA is too small, why not increase it in =
the device
> tree?
> > > > > > > Conversely, if the default CMA size is too large, why not
> > > > > > > reduce it via the cmdline?  CMA offers all kinds of =
flexible
> > > > > > > configuration options based
> > > > > on users=E2=80=99 needs.
> > > > > > >
> > > > > > > One significant benefit of device-specific CMA is that it
> > > > > > > helps decrease fragmentation in the common CMA pool. While
> > > > > > > many devices allocate memory from the same pool, they have
> > > > > > > different memory requirements in terms of sizes and
> > > > > > > alignments. Occasions of memory allocation and release can
> > > > > > > lead to situations where the CMA pool has enough free =
space,
> > > > > > > yet someone fails to obtain
> > > contiguous memory from it.
> > > > > > >
> > > > > > > This patch entirely negates the advantage we gain from
> > > > > > > device-specific
> > > CMA.
> > > > > > > My point is that instead of modifying the core code, =
please
> > > > > > > consider correcting your device tree or cmdline =
configurations.
> > > > > > >
> > > > > > Because we enabled secure heap to support widevine DRM, and
> > > > > > secure heap requires security configuration, its starting
> > > > > > address cannot be specified arbitrarily, which causes the
> > > > > > default CMA to be reduced. So we
> > > > > reduced the CMA, but in order to avoid the impact of reducing
> > > > > the CMA, we used a multi-segment CMA and gave one segment to =
the
> VPU.
> > > > > >
> > > > > > However, under our memory configuration, the device-specific
> > > > > > CMA is not
> > > > > enough to support the VPU decoding high-resolution code =
streams,
> > > > > so this patch is added so that the VPU can work properly.
> > > > > > Thanks.
> > > > >
> > > > > I don=E2=80=99t quite understand what you are saying. Why =
can=E2=80=99t you
> > > > > increase VPU=E2=80=99s CMA size?
> > > > Thanks for your quick reply.
> > > > Because we added a secure heap to support Widevine DRM, this =
heap
> > > requires hardware protection, so its starting address cannot be
> > > specified arbitrarily. This causes the secure heap to occupy part =
of
> > > the default CMA, and the default CMA is therefore reduced, so in
> > > order to avoid default CMA Shrinking introduces other problems. We
> > > added a specific CMA area for the VPU. However, due to the large
> > > size of the secure heap and default CMA, There is no remaining =
memory
> available to increase specific CMA for VPU.
> > >
> > > I assume the secure heap you are referring to is a section of =
memory
> > > that should only be accessed by TrustZone and not be visible to
> > > Linux running in non-secure mode. How do you allocate this secure =
heap
> from the default CMA?
> >
> > No, secure heap is a reserved memory, secure heap is not allocated =
from CMA,
> secure heap has been reserved during the kernel startup phase.
> > And this reserved memory is protected by hardware. Only specific =
hardware
> and secure world can accessed it.
> > For example:
> > &{/reserved-memory/} {
> >         secure_region: secure {
> >                 compatible =3D "imx-secure-ion-pool";
> >                 reg =3D <0x0 0xA0000000 0 0x1EF00000>;
> >         };
> > };
> >
> > > Do you use the cma_alloc() APIs or the dma_alloc_coherent() APIs?
> > > Given that the VPU has its own device-specific CMA, why is this
> > > secure heap allocated from the default CMA instead of the VPU's =
CMA?
> > >
> > The VPU driver will use dma_alloc_coherent() to allocate contiguous =
memory.
> The secure heap is not allocated from the CMA, but because the secure =
heap is
> enabled, it occupies some contiguous memory, causing the default CMA =
to be
> reduced.
> >
> > > If this secure heap was allocated before the kernel booted, why =
did
> > > the kernel(your dts) fail to mark this area as nomap/reserved to
> > > prevent the default CMA from intersecting with it?
> > >
> > Secure heap does not intersect with the CMA.
> > for example:
> > before secure heap enabled:
> > 0xA000 0000 ~ 0xFFFFFFFF: default CMA
> > after secure heap enabled:
> > 0x9000 0000 ~0x9FFF FFFF is the CMA specified by VPU,
> > 0xA000 0000 ~0xAFFF FFFF is secure heap, (the start address cannot =
be
> specified arbitrarily, because this memory is protected by hardware, =
if the start
> address is 0x9000 0000, uboot will use this memory, but uboot can't =
access this
> memory because of hardware protection. So we find a section of memory =
that
> UBOOT will not use as secure heap.
> > Note: The memory of uboot can be adjusted, but avoiding the secure
> > heap will limit the memory range that uboot can use, causing =
problems
> > such as the uboot stack)
> > 0xB000 0000 ~0xFFFFFFFF is default CMA.
> > So default CMA is reduced.
>=20
> How is that related to your patch? I assume the default CMA is reduced =
because
> you modified it in the DTS after enabling the secure heap, as the CMA =
size is set
> by you. The default CMA size won't automatically decrease due to the =
secure
> heap. To me, 0xB0000000-0xFFFFFFFF(1.25GiB) is still too large a CMA.
>

Sorry, This example is just an example. In fact, the size of our default =
CMA is less than 1.25GiB.
Our current memory distribution is as follows. Now the size of "c" =
(default CMA) could not meet the needs of our requirement. And "b" =
(reserved memory for secure) is fixed, so we couldn't expand "c" =
(default CMA) through modify DTS. Then we reserved "a" (specific CMA) =
for VPU. However, we have confirmed with the multimedia team that the =
maximum size required is It is uncertain, so specify "a" for VPU to use =
first, and "c" for other devices that require continuous memory. If "a" =
is not enough, use "c". =20
That's the purpose of this patch.
	--------------------------------------------------
	| a. VPU specific cma             |=20
	--------------------------------------------------
	| b. reserved memory for secure    |
	---------------------------------------------------
    | c. default CMA                 |
    ---------------------------------------------------
> >
> > > >
> > > > > It seems you mean that only in some corner cases do you need a
> > > > > large CMA, but most of the time, you don=E2=80=99t need it to =
be this
> > > > > big? So you have
> > > to "borrow"
> > > > > memory from the
> > > > > default CMA. but why not move that portion from the default =
CMA
> > > > > to your VPU=E2=80=99s CMA?
> > > > >
> > > > This is a method, but because for VPU, the continuous memory =
size
> > > > allocated
> > > by the driver is based on the video stream, we cannot determine =
the
> > > maximum size of memory required by the VPU. This makes it =
impossible
> > > for us to determine the size of the specific CMA assigned to the =
VPU. Thanks.
> > >
> > > I don't understand how this can happen. You should precisely know
> > > the maximum size required for the VPU based on your multimedia
> > > pipeline and resolutions.
> > >
> > We cannot estimate the maximum contiguous memory required by the VPU
> because it depends on how the video is encoded.
> > Thanks very much.
>=20
> Yes, you can. Please ask your multimedia team; they will give you a =
number.
>=20
> >
> > > I still don't understand your scenarios or the problem you are =
facing.
> >
> >
>=20
> Thanks
> Barry

------=_NextPart_000_01BB_01DABDB1.AC96B570
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhTTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
MqAfBgorBgEEAYI3FAIDoBEMD3poYWkuaGVAbnhwLmNvbYEPemhhaS5oZUBueHAuY29tMB0GA1Ud
DgQWBBRnNp0/tSrFNJlgS+ZRdCT+c5yRQDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
ggGwWe/YcZgJiMbIhUsSO/bYD09itDFnYO+uQqGwvPalRuHk3rA6pXfNb4DoA+gFZLgVDHNul0YA
oS8u+LYHUwXe/tP1HZvoInRRnUjPCP7o3uoQFcX2Ay0pVz3AoByHaFAqF3zCCsAdDhTksMPZu2eQ
oapJc06m3ZaIBpjT6aVZOXnRFVcHUjaMAZrpm2jqv3jJt58kP0dRsCrfKUkeTflak885rGuUypZC
j9tjOii+7/qAsUR/JqMZADUo2cD+PvCwHZRPpj0x1b5Ain8/3mRDTCaa7mMOUApMdd7De9fNjosF
LLTdnTiUXO+gnVgwXLvMOhuHTI6aWS+Z9pD1tTCCCDgwggcgoAMCAQICEy0AC58oXPwK6O6UsbsA
AQALnygwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQI
DA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhw
MRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yNDAyMjcwMTIyMzNaFw0yNjAy
MjYwMTIyMzNaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMw
EQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1N
YW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY2NDU5ODCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOFpbP807BLOCF4Zt9RudYkITj3hHgHYcWcIYUiT
PmR5wym2ussl7jezDSHHlEvPmzhgdSx/PVPpYcv80hjMDHFw3aoV0qyOU+W/pOT2oCL/7S/fHWUe
2Sahoup+MvYXycNdoONBohwwdCcWt71fxvxzsCq0XtnkUdgoTXFlZb53vhD3rAHvP/QhY8jLGvMa
I/xK5kFNYIC5EBH5m+atfPB7qERZIUU9nCacRfJVAZpkK0j8L1YBjG28Xm9OcDdgQAsOVRFdkFxk
3YVjHiSmGfDmd8QdvPJrlIDb/mdVXR/FGSl95J16mkithq2e3DBNOJtWrxxj3XDkmXpr9iAUGpEC
AwEAAaOCBFcwggRTMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUua
klY/heaKboS14X4CAWQCAUEwEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/BAQDAgUgMAwG
A1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGG
MIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBGTAL
BglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4GCCqGSIb3DQMC
AgIAgDAOBggqhkiG9w0DBAICAgAwUQYJKwYBBAGCNxkCBEQwQqBABgorBgEEAYI3GQIBoDIEMFMt
MS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5NDU4LTk0NzgwMjA7BgNVHREENDAy
oB8GCisGAQQBgjcUAgOgEQwPemhhaS5oZUBueHAuY29tgQ96aGFpLmhlQG54cC5jb20wHQYDVR0O
BBYEFDrgyxq3zDcnhNi/Mb2VXLlr7Mn3MB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50H
MIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJp
c2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIYvaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0
dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUH
AQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
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

------=_NextPart_000_01BB_01DABDB1.AC96B570--

