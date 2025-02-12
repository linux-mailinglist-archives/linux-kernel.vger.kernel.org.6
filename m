Return-Path: <linux-kernel+bounces-510901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D4A3236B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46831664CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105D2080D5;
	Wed, 12 Feb 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="Hnh32rjF"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023105.outbound.protection.outlook.com [40.107.162.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CA1E500C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355748; cv=fail; b=u53x7FNfYZVfoILzwamoTiVzSrlj6l1IYnJWJdOJRn2czDqG/6oZnnFqIS40O/C5Q/54HBzgU0owLceWdXIe7jgfqGGPP5VfnAQ8YBoi6DOlu1W71S9FCg5k39mzolQ4i10pw7/hUHOHfp++kD8FDx2pCHbU1Ue8/cofHPz7L34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355748; c=relaxed/simple;
	bh=bN9Q/YyLMwT39UnXdfzGCiuhxYxa3Azkwqr9Cs1t9AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oGEyvMcu/q0NcAUn9MO6ZGQOdivG4+F9N/woQDwS467nHQ0YvpBrQr110PZAORUJg5DZWmov8V5TGdZRbgWgPYN624/0odpfsTXofzvEFZZGlbmbBffcmuDcaIcNeeS9ScKK//akhwvKkkdv6x6WVjkSjoTh1+9p458nxX5bZGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=Hnh32rjF; arc=fail smtp.client-ip=40.107.162.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQvVEkYNN6fvV2CSKU4m1LjhCUHpbkWOmhbANkxUrQcXmfJysoPOdMDur2Qoc3m/qBDTb9gntfRoxMQM/GSYzVFa5N0qSZcHWxRWozTeBrLtHOO7NwLiBeIvUqf7vwZBqoaVEG/Fcm3DFHdxXDcs6OfJ7SIsf2LV1NuayWz6cAFfMdv1o9i3f1bL9ras/AsPu/oeI7YD7QU1Dp5FP+boo1+ZYOvIbtc1AmsoJ5VsmLjRPedQrYy434Pkh8sz4NbUnkAW41+b3GIIfxn98uuQ4w4NeKMHOgcqY83fOq/ZWtFxcJXvchi4b5L63FClK7bxnpOAG+5uKAVFDKjfVJrvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN9Q/YyLMwT39UnXdfzGCiuhxYxa3Azkwqr9Cs1t9AE=;
 b=v6IZBvGD7Yxv7TEbDRZsdTHadst0JajcLYSh99G7AavEWPOMucvJL5HPM5+50PIIZkK3Uudnyf4zCTkyfge8LDQ5VdZEBQBq8Q8UngfBRNiFFKCnZ9AbanV2UxO/TY5RMo5nZQ7izJome3CVr3AjjY8E9qrFdiUszikO+BC4LCE7FHKtEB3Qm3R69dXHOZh6DyeI1J6AxSHeofDQ+cYjgUXBl71RWMUa/U6f2HE/GszH9hDy6rVlKzMkDniT2BSLSTTHkeQH2lpPI8kjmwcoAkxRfpysW7GFhQpsQjTAO5/chNylYjQrg9lSZdW5cRx3vlKoYT3rVNgevGyKEz328Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN9Q/YyLMwT39UnXdfzGCiuhxYxa3Azkwqr9Cs1t9AE=;
 b=Hnh32rjFpVgeyMGfzCOzi0V4OGs0U0eDiLgDM0yhCr+nfMFXLitO+1G0s3E+f6ONUzVf+vZVBYJoR/aGIctoLDwnvj74IbGtgV5fOz6DU6IGxr3jOALGZnE7oTbvzv5OBPCFZfJuAZfk8cwApWkHSuOwofhLtBw9P/RaQBmf1iln41DvqMiEBsyV5MGrPO/U8ILF8MR1+md7tGW46onot9ebyoSy3hpYsowyvS3nT70PINYbLnJ41RL36/QBgrLvyI+N2YNKHO2K8VWJLhR9EPA34MeND7nWR5R8EzJp0QBqmv6Kji5+pnXOQ63BJx7OBpKtQc2srow7OZiNOcXQFQ==
Received: from AM6PR09MB2680.eurprd09.prod.outlook.com (2603:10a6:20b:4f::13)
 by DBBPR09MB4523.eurprd09.prod.outlook.com (2603:10a6:10:201::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 12 Feb
 2025 10:22:22 +0000
Received: from AM6PR09MB2680.eurprd09.prod.outlook.com
 ([fe80::c551:65ae:a91b:8dd3]) by AM6PR09MB2680.eurprd09.prod.outlook.com
 ([fe80::c551:65ae:a91b:8dd3%5]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 10:22:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, "jrtc27@jrtc27.com"
	<jrtc27@jrtc27.com>
CC: Charlie Jenkins <charlie@rivosinc.com>, "samuel.holland@sifive.com"
	<samuel.holland@sifive.com>, Conor Dooley <conor@kernel.org>,
	"arikalo@gmail.com" <arikalo@gmail.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Will Deacon
	<will@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, Mark Rutland
	<mark.rutland@arm.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"parri.andrea@gmail.com" <parri.andrea@gmail.com>, "leobras@redhat.com"
	<leobras@redhat.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"ericchancf@google.com" <ericchancf@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: Use Zalrsc extension to implement atomic
 functions
Thread-Topic: [PATCH v2] riscv: Use Zalrsc extension to implement atomic
 functions
Thread-Index:
 AQHbVqZn/pI7OIZJ7UylkIiurYUBW7MPcKwAgCMk5oCAAhmtAIABgpoAgAAFGwCAAAVfAIAAHUYAgALETYCACqLCjw==
Date: Wed, 12 Feb 2025 10:22:22 +0000
Message-ID:
 <AM6PR09MB26808ACAD8DF14A7F63808D0F7FC2@AM6PR09MB2680.eurprd09.prod.outlook.com>
References: <17E9A830-AE5C-41F5-AC07-2BD9C70739BB@jrtc27.com>
 <mhng-50508e34-b5cc-4dad-b4d4-7d2bac5a74d8@palmer-ri-x1c9>
In-Reply-To: <mhng-50508e34-b5cc-4dad-b4d4-7d2bac5a74d8@palmer-ri-x1c9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Enabled=True;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SiteId=9f85665b-7efd-4776-9dfe-b6bfda2565ee;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SetDate=2025-02-12T10:22:20.839Z;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Name=HTEC
 Public;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_ContentBits=0;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR09MB2680:EE_|DBBPR09MB4523:EE_
x-ms-office365-filtering-correlation-id: b3d40b0c-bdb6-4cbf-9d4d-08dd4b4f2349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVg1dWF4czVNWVIrNWp4QVZWYlpQclIrcDRuK0E5Rmp2LzhXMWFkRENFSDlZ?=
 =?utf-8?B?aTNqaTliNHFRYWt2VEJub3JSUW4zdUcvYThwQUN4M050S2pVdHVVdVNqb2gz?=
 =?utf-8?B?M3VhUXY3VjVnN0RJczhnMlo3LzhIay9OUStjZEp0QmxqZFYwVVo1NTkvMUpT?=
 =?utf-8?B?b3dxSG1Mcjh6Mkp0b2IwYVdKeHZuaVRBbSt1K2ZiVVl6Q1phVytBclMrL1c2?=
 =?utf-8?B?Q3dEUS9SYzJQUk5sVVZZaUFEUlEySTFTbzRDUVBPdndUTUt3RmhWVkVJMnUw?=
 =?utf-8?B?Tmo2Q1hyYU44WTdZTTdiUHcwZ0p3V05McEFLTnJBTDNQVklsclVEaUxIanNG?=
 =?utf-8?B?dmdpa2VKb0pEU2FpQ1RnaG12d0dTZUY0a0xFTjZQNGhXQm9rQWU4aFVoeER4?=
 =?utf-8?B?emVac0ZrV1dSaHV2VzNSUEp3NnVaQzdRY2ZyWklVUnZ4VnorR29naGYrMTZj?=
 =?utf-8?B?R0pQdHRUWFlLTUR2Zkw0SHRva1gzV05JVkhEQlZSNzkrK01QTWR3T01YOFk5?=
 =?utf-8?B?UmhyWDN6U0UrNUdoZ0h3cE04SW5yTTZwdUtmWW84aTF3eStnVWZZd1MyS1Y1?=
 =?utf-8?B?NTVlZmZ3YXhZSFExWUZiVk5KbkxzZUk3ZFoyWWUzZmRJUjIvZThTeVRqcUoz?=
 =?utf-8?B?L1BEem5GUWtLQ0hZSWN2aFZWM0ZrK1BSQStzN2liUmFaU2h6QitUamRsM0pV?=
 =?utf-8?B?TGtvL0NabmZRNmJNdVk3czBsRTBFaFMrZjhXeVRFSFJhZldEc1VCRWJ3L1hr?=
 =?utf-8?B?eDdQWStZNmxwUE1TcFFzWHlPVldUVGpPRktSdk1uK0FYOTlRUXMxM1NvVm9E?=
 =?utf-8?B?ZW1MT2xvaVYrTHR6OU9rMVlydU0yakhUZWpmRkZod0d3aE8rcmR6elcwRHNW?=
 =?utf-8?B?bmJiamEzNExNbTFQK3U3dURRNW0rUUdQdjZ4dndQeFFEOS9rbnBwakdObnhy?=
 =?utf-8?B?ZUFZVUx0dnpqNUlTNWowYi8zNERrTGFiczVQK3JHVmJiR3dHTmwvMzZzUGo5?=
 =?utf-8?B?a21wSXlFY3dRNnVWbGxGYVozS2Y0YWtxa3psWkY2YjlreEFHTmwzdVdramdQ?=
 =?utf-8?B?TzNyY3FwZjdyOGJvMnJNTS8xUzVaeW5kTThoOWpQWXNPZTV0OCsxY2hZTjc1?=
 =?utf-8?B?TjJJVVBicXRjUTFna2RSRk5tQm4ycEtmS25BblNraGE1Um5nZ3BDdWxqNTRa?=
 =?utf-8?B?WkViaTdsR0poTTh4cE5JbVByWHNpbFEyc2RROTY5a3VFb0ZWT2ZrT0tyTW1v?=
 =?utf-8?B?VW1kRThIb0x2ODZtY3RTRjRHVUcyNTFORklZMGF2bitwcTlqMVBRUGNVK01X?=
 =?utf-8?B?RHJrSUlWQ05kL2RLMTVaMmN2dXNaQVFnaUFaRkxXZjdCd3NDcmIzSGtlNkI2?=
 =?utf-8?B?cGdoSHRYczd0ZFNibTVERWU0aEhKT3Z4aTZkZ3k0RlFSN3IvNkw0S21DeFV6?=
 =?utf-8?B?VVkzNCtNdzFCRXRIWHBqbDhEYnFGSXhsalVLQnZ4N0h0ZHZEamVwb0VseC9l?=
 =?utf-8?B?dVRWbnpPcGtVRFVlSVF6L0lIUDlLRXp3N1ZQSjJwd1JiS2toV0M1aWNORUdN?=
 =?utf-8?B?N0x5WlFJbjVxVTFOQUd1Vm5NTnhBd3VDNy9yRnBYeERvZXFFN0FhM1BnbkRv?=
 =?utf-8?B?dGtPWnUwRWNhWVNCaVEvNTcrY1FsSElCL1lGNTZxTmlLbmlub3hBeFh6Rkw0?=
 =?utf-8?B?OTZLdTJsYzFLbm9Rck8xTW9ZNi9tSUlsc1VuYVV6VDhJRUZtWTh2aEpoSFl0?=
 =?utf-8?B?bXAvWHpZVmhodm5XUmphUlNBZ0pER2pEZkFBL3RTRXZkUFREUXc2bDR0cGxX?=
 =?utf-8?B?TkIrLzNRQkI1K1ZpNXZ1RVE1dlRjNXZxblM1TExZWFYzeFFodHJqdnA4ZWNK?=
 =?utf-8?Q?tFRq+uW4oB1jR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR09MB2680.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHZkdVlJMDRSUUZWakFvd1lpSlFSUEVhRE5VVVNGRkVOYWxRNmNQZlNKaS9a?=
 =?utf-8?B?OXRTVGhITVRYUEFyQ3dHWmM5UXMzcnZIQ3p3Z0ZpaGpERHdpeUg4cHl6eVZk?=
 =?utf-8?B?NGt3RlMyQmFLVVViUDdxSTBJbjVIamEvNVdqcTBlbGlJT0ZlWVFyTkh0elY3?=
 =?utf-8?B?Q3FVeXdFWXp2cVlMd1JTV1JZVW1sdFlBMFRVdVE2b0ltMVNCY0ZwR0ZJYWRM?=
 =?utf-8?B?UjB1cGV6OFllSEVoOGdXUHdabmNhSkpTTHR1MHF3WHlDZlJlSzdSSk9mWVpT?=
 =?utf-8?B?M3I4QW1CN3BBK3pQczlSZHdkZGRkdFVQT0pNRG5NdzB5NWYzODdvb1ZRT2dX?=
 =?utf-8?B?SUY4OWlNd3d3My8zUGpRRVkvWDllVnBnNGtMOVRvNHdBTlp5VSswT2pNNk5E?=
 =?utf-8?B?VHZoRStCNjVucllDWlFNOHNybDkvWXhSb0o1Q3c0UTc4bjQ1dnpJaGt4blcz?=
 =?utf-8?B?NXdiSm14UDVNdmRuZDZCZC9JQnRmb2RuVndmRVBpRy9YYlVHZld5RW9wMFNK?=
 =?utf-8?B?SGROanM5VTFMTVdBRUJpODFCSWhPZGY3VUI0VTJGM0E0TWxLMDJqTmZXa0M3?=
 =?utf-8?B?d0tyMHdFVDZXWUZZa0R6cldkWTRSTUVUMEY1RzIvT3E3ZitMMUtNcDVwZ0pW?=
 =?utf-8?B?bHVVNUoxNWR6OUU3THcrSXVtWVZWQjNrNzR4dXdVbUNhVVowUGZxSHBxS0hJ?=
 =?utf-8?B?ZmZudHQyeTFOTTVzMEhFUVhKWi9hbDQ2bGNxK1RSSmNkT0J2aDVIM3o4V1VM?=
 =?utf-8?B?TGUvMkorRFFlNVUwS1ZVWkE5OTBxYkhZWldkRTJoWGgySllRRkhESjlEejNX?=
 =?utf-8?B?Nnp6TGhTK0Ztc2p5SVRxK2NIVTdNYnVKTVE1SVJMTy9tTVAyU2VWdnFYRW1S?=
 =?utf-8?B?UVhmTW9Ma3dDSlAzcS9IUEV3RGZ5VzBJVk8rbGZTY1JmbERzTXhaVkc1NFN0?=
 =?utf-8?B?TjFpc2MvUjdnQWRRWEIvYUhDNVl1Y013S1QrY3Z6Zlp0NWQ0U2ZsRWcreWZY?=
 =?utf-8?B?V3VJM2ppajFjWDhTTXZTVXUvZU5NckhaT2xNNUE0ZkVBYzEwc3pKODF3Nm1N?=
 =?utf-8?B?OHhyNWk0d1ZqbjZZVXRTYXhIdjhvVGQ5bXcrRHJveHpwNGtCTUd0NitpcUQy?=
 =?utf-8?B?akw0TXNDeVRzNHZWbFVRdmdha2pjTEM1WFFxRHZ2USt2b0pXbUpzY1A2dDJ4?=
 =?utf-8?B?cks4TlZRTE94U3dwZTJQQjNycjAwYTlNVHQ2T2FNMmdDWXhwQVhZTGZTdFVL?=
 =?utf-8?B?VDhXUmViSVEyeVoxb0tYUDFtaFJOQ0I3MXN0SmVUQUdWRjYyY3I2d1hMaWdP?=
 =?utf-8?B?ZThWVS9rTjM1RDR1aVNsemRNZW9LNkh3TGVDdDMwMkViTFk3dEl6M0p1UGh0?=
 =?utf-8?B?dFJIS2tiU2tRYzdVd0FYSnAxVHd5VERPY0JkUGVOREZqeXJxakpGTzE3VWhp?=
 =?utf-8?B?cVoyUm0rUFpMT3VYMC9UN2hxTlAvRldmRG5CSGExWkFOOXRCZXBWdVdWN2Iv?=
 =?utf-8?B?bC9kb0NTeEFxY0tUQTdNelhXTGlMWDNjY2tzMnMyZjBNK205TStzM0JYSmRW?=
 =?utf-8?B?c1lqbkNpTnR1ZXVzdGhxdituQm5FOGhHdXZHN0p4VTZ2bFhVMVQwbmxRQUVR?=
 =?utf-8?B?QVY4cVpIQzFFeWxGT3FMMjdpSjZWVXdSekRrZEluaDF3U2ZSRG5CQmlkdW4v?=
 =?utf-8?B?RTU5VDkwVU5Sdk1rSmdRZnN0V1VTR29Ncm9XTjRVQUlXN09ERTV0enl4a2xF?=
 =?utf-8?B?OVlhRy9SQ1dKVGZHQnhNQklvdUFWL1pGUDZwMkRIaU1MblNOalZYeUQ1V3ly?=
 =?utf-8?B?L3cyMzFaR0g4TFlsQ2JOa1l2OFdoVXhvUHRZVmFyOTFGZHZ6bnU0WVVEazlr?=
 =?utf-8?B?RnNBL21GOXlYb1FGaVdhTzJzeTI4VksyRjdoVVdFMUt1RHVoVXFsUHk0RjdF?=
 =?utf-8?B?K3E3M09ub25zTytWRlJ2Mklic0ZWd2pXdm4yZFd1YVRLcS9SY0thQ2RzbVFT?=
 =?utf-8?B?N0NscXJPSjA3Rk5nSis2bHVsMlVBYkxtTHZDWE9qV1ZPd0NkYVgzSUtMVDc0?=
 =?utf-8?B?UmNUbldsQjYzZXJQa2doeUpYSXBVcFRRZnQ2V1hoMUxHR3o5TS9LVVVHUXFF?=
 =?utf-8?B?SGI5anpacW9TRytaa3V5SWJKRU1NRTZWaWV4ZjBML2hTOTVyeTNGU3R1UVc3?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR09MB2680.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d40b0c-bdb6-4cbf-9d4d-08dd4b4f2349
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 10:22:22.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvKiYU1IQiexFmRNS5MgpRI82NkBpCMzQt/UC5jY2KhU85aSoFKaLbE+G8gv8ibdHUeNC4CI8h2AFp1745sM9aXAu/UetAXmt3ZjJM2ldWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR09MB4523

SFRFQyBQdWJsaWMNCg0KSGksDQoNClRoZSBvZmZpY2lhbCBwcm9kdWN0IHBhZ2UgaXMgbG9jYXRl
ZCBoZXJlOg0KaHR0cHM6Ly9taXBzLmNvbS9wcm9kdWN0cy9oYXJkd2FyZS9wODcwMA0KDQpUaGUg
bWVjaGFuaXNtIHdlIHVzZSB0byBoYW5kbGUgQU1PIGlzIGRlc2NyaWJlZCBpbjoNCiI3LjMuMTAg
TUlQUyBDb25maWd1cmF0aW9uIDYgUmVnaXN0ZXIgKG1pcHNjb25maWc2KSINCg0KQmVzdCwNCkRq
b3JkamUNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTog
UGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgRmVi
cnVhcnkgNSwgMjAyNSA0OjQ5IFBNDQpUbzoganJ0YzI3QGpydGMyNy5jb20gPGpydGMyN0BqcnRj
MjcuY29tPg0KQ2M6IENoYXJsaWUgSmVua2lucyA8Y2hhcmxpZUByaXZvc2luYy5jb20+OyBzYW11
ZWwuaG9sbGFuZEBzaWZpdmUuY29tIDxzYW11ZWwuaG9sbGFuZEBzaWZpdmUuY29tPjsgQ29ub3Ig
RG9vbGV5IDxjb25vckBrZXJuZWwub3JnPjsgYXJpa2Fsb0BnbWFpbC5jb20gPGFyaWthbG9AZ21h
aWwuY29tPjsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZyA8bGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZz47IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNv
bT47IGFvdUBlZWNzLmJlcmtlbGV5LmVkdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1PjsgV2lsbCBE
ZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IHBldGVyekBpbmZyYWRlYWQub3JnIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47IGJvcXVuLmZlbmdAZ21haWwuY29tIDxib3F1bi5mZW5nQGdtYWlsLmNvbT47
IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyB5dXJ5Lm5vcm92QGdtYWlsLmNv
bSA8eXVyeS5ub3JvdkBnbWFpbC5jb20+OyBsaW51eEByYXNtdXN2aWxsZW1vZXMuZGsgPGxpbnV4
QHJhc211c3ZpbGxlbW9lcy5kaz47IHBhcnJpLmFuZHJlYUBnbWFpbC5jb20gPHBhcnJpLmFuZHJl
YUBnbWFpbC5jb20+OyBsZW9icmFzQHJlZGhhdC5jb20gPGxlb2JyYXNAcmVkaGF0LmNvbT47IGd1
b3JlbkBrZXJuZWwub3JnIDxndW9yZW5Aa2VybmVsLm9yZz47IGVyaWNjaGFuY2ZAZ29vZ2xlLmNv
bSA8ZXJpY2NoYW5jZkBnb29nbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGpl
LnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gcmlzY3Y6
IFVzZSBaYWxyc2MgZXh0ZW5zaW9uIHRvIGltcGxlbWVudCBhdG9taWMgZnVuY3Rpb25zDQoNCltZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gcGFsbWVyQGRhYmJlbHQuY29tLiBMZWFybiB3
aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklk
ZW50aWZpY2F0aW9uIF0NCg0KQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUuDQoNCg0KT24gTW9uLCAwMyBGZWIgMjAyNSAxMzozNDo0OCBQU1QgKC0wODAw
KSwganJ0YzI3QGpydGMyNy5jb20gd3JvdGU6DQo+IE9uIDMgRmViIDIwMjUsIGF0IDE5OjUwLCBD
aGFybGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBN
b24sIEZlYiAwMywgMjAyNSBhdCAwMTozMDo0OFBNIC0wNjAwLCBTYW11ZWwgSG9sbGFuZCB3cm90
ZToNCj4+PiBIaSBDaGFybGllLA0KPj4+DQo+Pj4gT24gMjAyNS0wMi0wMyAxOjEyIFBNLCBDaGFy
bGllIEplbmtpbnMgd3JvdGU6DQo+Pj4+IE9uIFN1biwgRmViIDAyLCAyMDI1IGF0IDA4OjA4OjUw
UE0gKzAwMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+Pj4+IE9uIFNhdCwgRmViIDAxLCAyMDI1
IGF0IDAxOjA0OjI1UE0gKzAxMDAsIEFsZWtzYW5kYXIgUmlrYWxvIHdyb3RlOg0KPj4+Pj4+IE9u
IEZyaSwgSmFuIDEwLCAyMDI1IGF0IDQ6MjPigK9BTSBDaGFybGllIEplbmtpbnMgPGNoYXJsaWVA
cml2b3NpbmMuY29tPiB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+Pj4gRnJvbTogQ2hhby15aW5nIEZ1
IDxjZnVAbWlwcy5jb20+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gVXNlIG9ubHkgTFIvU0MgaW5zdHJ1
Y3Rpb25zIHRvIGltcGxlbWVudCBhdG9taWMgZnVuY3Rpb25zLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJ
biB0aGUgcHJldmlvdXMgcGF0Y2ggeW91IG1lbnRpb24gdGhhdCB0aGlzIGlzIHRvIHN1cHBvcnQg
TUlQUyBQODcwMC4gQ2FuDQo+Pj4+Pj4+IHlvdSBleHBhbmQgb24gd2h5IHRoaXMgY2hhbmdlIGlz
IHJlcXVpcmVkPyBUaGUgZGF0YXNoZWV0IGF0IFsxXSBzYXlzOg0KPj4+Pj4+Pg0KPj4+Pj4+PiAi
VGhlIFA4NzAwIGNvcmUgaXMgY29uZmlndXJlZCB0byBzdXBwb3J0IHRoZSBSVjY0R0NaYmFfWmJi
IChHID0gSU1BRkQpDQo+Pj4+Pj4+IFN0YW5kYXJkIElTQS4gSXQgaW5jbHVkZXMgdGhlIFJWNjRJ
IGJhc2UgSVNBLCBNdWx0aXBseSAoTSksIEF0b21pYyAoQSksDQo+Pj4+Pj4+IFNpbmdsZS1QcmVj
aXNpb24gRmxvYXRpbmcgUG9pbnQgKEYpLCBEb3VibGUgKEQpLCBDb21wcmVzc2VkIChDKSBSSVND
LVYNCj4+Pj4+Pj4gZXh0ZW5zaW9ucywgYXMgd2VsbCBhcyB0aGUgYXMgd2VsbCBhcyB0aGUgYml0
LW1hbmlwdWxhdGlvbiBleHRlbnNpb25zDQo+Pj4+Pj4+IChaYmEpIGFuZCAoWmJiKSINCj4+Pj4+
Pj4NCj4+Pj4+Pj4gVGhlICJBIiBleHRlbnNpb24gaXMgYSBwYXJ0IG9mICJHIiB3aGljaCBpcyBt
b3N0bHkgYXNzdW1lZCB0byBleGlzdCBpbg0KPj4+Pj4+PiB0aGUga2VybmVsLiBBZGRpdGlvbmFs
bHksIGhhdmluZyB0aGlzIGJlIGEgY29tcGlsYXRpb24gZmxhZyB3aWxsIGNhdXNlDQo+Pj4+Pj4+
IHRyYXBzIG9uIGdlbmVyaWMga2VybmVscy4gV2UgZ2VuZXJhbGx5IHRyeSB0byBwdXNoIGV2ZXJ5
dGhpbmcgd2UgY2FuDQo+Pj4+Pj4+IGludG8gcnVudGltZSBmZWF0dXJlIGRldGVjdGlvbiBzaW5j
ZSB0aGVyZSBhcmUgc28gbWFueSBwb3NzaWJsZSB2YXJpYW50cw0KPj4+Pj4+PiBvZiByaXNjdi4N
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gRXhwcmVzc2luZyBub3QgYmVpbmcgYWJsZSB0byBwZXJmb3JtIGEg
ZmVhdHVyZSBsaWtlIHRoaXMgaXMgbm9ybWFsbHkNCj4+Pj4+Pj4gYmV0dGVyIGV4cHJlc3NlZCBh
cyBhbiBlcnJhdGEuIFRoZW4gZ2VuZXJpYyBrZXJuZWxzIHdpbGwgYmUgYWJsZSB0bw0KPj4+Pj4+
PiBpbmNsdWRlIHRoaXMsIGFuZCBhbnlib2R5IHdobyBkb2Vzbid0IHdhbnQgdG8gaGF2ZSB0aGUg
ZXh0cmEgbm9wcw0KPj4+Pj4+PiBpbnRyb2R1Y2VkIGNhbiBkaXNhYmxlIHRoZSBlcnJhdGEuIEEg
c2ltaWxhciBhcHByb2FjaCB0byB3aGF0IEkgcG9pbnRlZA0KPj4+Pj4+PiBvdXQgbGFzdCB0aW1l
IHNob3VsZCB3b3JrIGhlcmUgdG9vIChidXQgd2l0aCBtb3JlIHBsYWNlcyB0byByZXBsYWNlKQ0K
Pj4+Pj4+PiBbMl0uDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFsxXSBodHRwczovL21pcHMuY29tL3dwLWNv
bnRlbnQvdXBsb2Fkcy8yMDI0LzExL1A4NzAwX0RhdGFfU2hlZXQucGRmDQo+Pj4+Pj4+IFsyXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1oyLVVOZndjQVFZWnFWQlVAZ2hvc3QvVC8NCj4+
Pj4+Pg0KPj4+Pj4+IFNvIGZhciB3ZSBoYXZlbid0IGZvdW5kIGEgd2F5IHRvIGRvIHRoaXMgdXNp
bmcgZXJyYXRhLg0KPj4+Pj4NCj4+Pj4+IFlvdSBtZWFuIHVzaW5nIGFsdGVybmF0aXZlcz8gTm90
IGltcGxlbWVudGluZyBBLCBidXQgaW5zdGVhZA0KPj4+Pj4gaW1wbGVtZW50aW5nIFphbHJzYywg
aXMgbm90IGFuIGVycmF0dW0uIEl0J3MgYSBkZXNpZ24gZGVjaXNpb24uDQo+Pj4+DQo+Pj4+IFdl
IGNvdWxkIGRvIHRoZSBzYW1lIHRoaW5nIHdlIGRvIHdpdGggbWlzYWxpZ25lZCBhY2Nlc3MgZGV0
ZWN0aW9uIGFuZA0KPj4+PiBydW4gc29tZSBpbnN0cnVjdGlvbnMgdG8gZGV0ZXJtaW5lIGlmIHRo
ZXNlIGluc3RydWN0aW9ucyBhcmUgYmVpbmcNCj4+Pj4gZW11bGF0ZWQuICBJZiB0aGV5IGFyZSBi
ZWluZyBlbXVsYXRlZCwgcGF0Y2ggYWxsIG9mIHRoZSBwbGFjZXMgdG8gdXNlDQo+Pj4+IHphbHJz
Yy4NCj4+Pg0KPj4+IElzIHRoZSBpbXBsaWNhdGlvbiBoZXJlIHRoYXQgdGhlIHJpc2N2LGlzYS1l
eHRlbnNpb25zIGxpc3QgcGFzc2VkIHRvIHRoZSBrZXJuZWwNCj4+PiB3aWxsIGNvbnRhaW4gImEi
LCBldmVuIHRob3VnaCB0aGUgaGFyZHdhcmUgZG9lcyBub3Qgc3VwcG9ydCBpdCwgYmVjYXVzZSBB
TU9zIGFyZQ0KPj4+IGVtdWxhdGVkIGluIE0tbW9kZT8NCj4+Pg0KPj4+IElmIHRoYXQgaXMgbm90
IHRoZSBjYXNlLCB0aGVyZSBpcyBubyBuZWVkIGZvciBydW50aW1lIGRldGVjdGlvbi4gVGhlIGFs
dGVybmF0aXZlDQo+Pj4gZW50cnkgY2FuIGNoZWNrIFJJU0NWX0lTQV9FWFRfWkFBTU8gKHdoaWNo
IHdvdWxkIGJlIGltcGxpZWQgYnkgUklTQ1ZfSVNBX0VYVF9hKQ0KPj4+IGluIHRoZSBJU0EgYml0
bWFwIGxpa2Ugbm9ybWFsLg0KPj4NCj4+IFRoYXQgd291bGQgYmUgbXVjaCBiZXR0ZXIhIEkgd2Fz
IHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHVzZWNhc2UNCj4+IGZvciB0aGlzIHBhdGNo
IHdhcyB0aGF0IHRoZXkgd2VyZSBwYXNzaW5nIGluICJhIiBhbmQgd2FudGluZyB0byBvbmx5IGdl
dA0KPj4gemFscnNjLiBXZSBzaG91bGQgYmUgYWJsZSB0byBjaGVjaw0KPj4gUklTQ1ZfSVNBX0VY
VF9aQUFNTy9SSVNDVl9JU0FfRVhUX1pBTFJTQyB0byBnZXQgdGhlIGluZm9ybWF0aW9uIHdpdGhv
dXQNCj4+IHJ1bnRpbWUgZGV0ZWN0aW9uLg0KPg0KPiBJbiBMTFZNIGF0IGxlYXN0IC1tY3B1PW1p
cHMtcDg3MDAgZW5hYmxlcyB0aGUgZnVsbCBBIGV4dGVuc2lvbi4uLg0KDQpTbyB0aGVuIEkgdGhp
bmsgd2UgbmVlZCBzb21lIGhlbHAgZnJvbSB0aGUgSFcgdmVuZG9yIGhlcmUuDQpTcGVjaWZpY2Fs
bHk6IGRvIHRoZXNlIHN5c3RlbXMgaW1wbGVtZW50IEEgdmlhIE0tbW9kZSB0cmFwcyAoaWUsIHdp
dGggYQ0KcGVyZm9ybWFuY2UgcGVuYWx0eSkgb3IgaXMgdGhlcmUgc29tZXRoaW5nIGZ1bmN0aW9u
YWwgZXJyYXR1bSBpbiB0aGUgQQ0KaW1wbGVtZW50YXRpb24uDQoNCklmIGl0J3MganVzdCBhIHBl
cmZvcm1hbmNlIHRoaW5nIHRoZW4gd2UgbmVlZCBzb21lIGJlbmNobWFyayBqdXN0aWZ5aW5nDQp0
aGUgZXh0cmEgd29yaywgd2hpY2ggbWVhbnMgc29tZSBoYXJkd2FyZSB3ZSBjYW4gcG9pbnQgYXQg
dG8gcnVuIHRoZQ0KYmVuY2htYXJrLiAgUHJvYmFibHkgYWxzbyBiZXN0IHRvIHNoaW0gdGhpcyBp
biB2aWEgYWx0ZXJuYXRpdmVzLCBzbyB3ZQ0KY2FuIGtlZXAgbXVsdGktdmVuZG9yIGtlcm5lbHMg
d29ya2luZy4NCg0KSWYgaXQncyBhIGZ1bnRpb25hbCBpc3N1ZSB0aGVuIHdlIG5lZWQgdG8ga25v
dyB3aGF0J3MgYWN0dWFsbHkgYnJva2VuLg0KDQpFaXRoZXIgd2F5IHRoaXMgc2hvdWxkIGJlIGV4
cG9zZWQgdG8gdXNlcnNwYWNlLg0KDQo+DQo+IEplc3MNCg==

