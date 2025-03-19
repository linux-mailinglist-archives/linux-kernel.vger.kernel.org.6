Return-Path: <linux-kernel+bounces-568005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04618A68CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C787A1890423
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02412561A9;
	Wed, 19 Mar 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="CLBTFVvw"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2107.outbound.protection.outlook.com [40.107.105.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C252561A5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387324; cv=fail; b=IkFmM8QL68x5NOkCHHXTvLO9zqm798mZHb+/Vp2j8s81SFvXmG6Pw/iUS9x8Rdqk4u+z0za7n+I2ZlfEP2meQKcwg0uiBG7Kqh1/9OkAsWDouJTfU453duTK7q7PBha9+7uRH6TB0MEmB1Wz2s8SyrNuroJ8f3zE9tWpyx5KBpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387324; c=relaxed/simple;
	bh=IM/yfD2IRG8jYA+ZWp2zSDeoz/b2jKPb8z++bVCJrSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJIuTNpSXwb4+A9rhC7q0vHsAOqA7J/c2b6Mk0XhR3Y45/+v8n44eG2SdvMODoppQbKvNxVRT+MSkLseHKhb2cTGMrmunWvD/wXlB8jOA8fM0F3msKusLw6c9LvWOyunPImzQYHcRatvkti2l23KP8YecQA3UsoJ7Bikpsf39HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=CLBTFVvw; arc=fail smtp.client-ip=40.107.105.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XATOhPE4Ko/jGPbkuwLI+E+l2nf685ykHPSVIEHufYwKYIkWzPClZyGtYloRT5R6Wxrr5dS41pohjEqklnaTUD/Xa+oTL9HDqXkqy6kHfmf7moH4KP/ZeROOJOXGFpy/ZJ9O1KmFjovwdKeuic8pCaOkow7QDsR4vYhLcpUqlz5hPJCwIz0R951qS2VgZrg5yYDFwubXe3Brx9mQfVcenGwPYsKQjrCmySKO9/ytTZ9tGXsJVRZUCx67KzXsk7sDz+Z9snkmzE8rgHlBfCMSDYJA/tJ8RD1CJaIMkoR4HS7aGQaETOicvY8rR9I4Lpo6CNEtUyJSImB1cMphhb06IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM/yfD2IRG8jYA+ZWp2zSDeoz/b2jKPb8z++bVCJrSU=;
 b=iRiIcKk89Z4CtnEeN73GhW1PBsoZtgDxjk1cT5XDDmsPpqaEissmFfcVIBc0O3PhdCDwIhWDMEuO0ILwB+q/OZ5u53mhp+YcxcGD2bSKuNJ5uF3YGlcKU8mvdJ2avpa0iSsFExuxNd5bVMCDbcpNd7puV8X7QcHCHVKmyJn5eGAyUPciiFFxWKH2LK54ZtpSMbhmk2JlSvBsbw77q8XSB7S3E5TlMyUjcsIuU4ThmV9L4ZNd4enAKLovIbp0+vATeoa+CAn2MGI5UzI0nFlQFomv+RiZWrkdBIwQkh2TCKnYd78gcQwktZzeMYmO1UYsaREkgTPMM4v0SJKzw3FGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM/yfD2IRG8jYA+ZWp2zSDeoz/b2jKPb8z++bVCJrSU=;
 b=CLBTFVvwg31XZgWm8hOCq5Vx/+c0OHbNYPciEsGaQkRo2zftuHBzwiygG/Ntla0/7OCBvlQTWc7PukpuVsanT9SslwqyDhDorxiWGj/koNQrv9cyx3dPRN+tA+4Pr4XF6n+EyKXylseppNxk6SSsjtJ0z9ECGJkyL6Ow98SXMlbBzJyg0hhyTUSgnXl6FxlIf4++pJL9rPR3vAAIMlxymJJAFc3q80YBkaLd+XyzVp0hewqz70egeHPWtN4yZY920EQGvDSUO1LZGxktw7gD8rlgKNmpGScrlhtVSz7kpn353fUB7HG7qlkra0TyUNG3hyNpS/EhPKR5f4PCvQVXmw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4121.eurprd09.prod.outlook.com (2603:10a6:10:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:28:38 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:28:38 +0000
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
 AQHbVqZn/pI7OIZJ7UylkIiurYUBW7MPcKwAgCMk5oCAAhmtAIABgpoAgAAFGwCAAAVfAIAAHUYAgALETYCACqLCj4A3JmQU
Date: Wed, 19 Mar 2025 12:28:38 +0000
Message-ID:
 <AS4PR09MB6518D0A168465DF5F0890B8EF7D92@AS4PR09MB6518.eurprd09.prod.outlook.com>
References: <17E9A830-AE5C-41F5-AC07-2BD9C70739BB@jrtc27.com>
 <mhng-50508e34-b5cc-4dad-b4d4-7d2bac5a74d8@palmer-ri-x1c9>
 <AM6PR09MB26808ACAD8DF14A7F63808D0F7FC2@AM6PR09MB2680.eurprd09.prod.outlook.com>
In-Reply-To:
 <AM6PR09MB26808ACAD8DF14A7F63808D0F7FC2@AM6PR09MB2680.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Enabled=True;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SiteId=9f85665b-7efd-4776-9dfe-b6bfda2565ee;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SetDate=2025-03-19T12:28:38.074Z;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Name=HTEC
 Public;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_ContentBits=0;MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4121:EE_
x-ms-office365-filtering-correlation-id: 1815cc88-d114-4972-8748-08dd66e19376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1hOSGpCNndGS2E0V0o2UllmU0Z1bGNnUkhsRlp4UmwyemxrVkFXYjhnaE9Z?=
 =?utf-8?B?djhGekVhMVp3d3l3dUtOMTVkeDlvbXgrcmRvcVBFTUo5OXBLTGZTa3MxYjhU?=
 =?utf-8?B?Z3BJQUViRlVmZUxUOHF1bGtTRXppMXQ2WHg4aHJ6OVkwSWtVM3pxY1hKVzZi?=
 =?utf-8?B?dG5RNE91bnYzR2tXUE54T2FWTUZQQUdhbGIyUTRSbGxmV3BTMVlOMEpHejNk?=
 =?utf-8?B?NlgreS9iR1hqV0t4anhib1A2TUFCNW56SzdSL3ZSaFJHM0pscXhycjNBMGV5?=
 =?utf-8?B?cmFjdHoxUVF2Qm5UMGwxTFJFSzFJajJDRlgxakhEUXZpQlJjOENMcXR3S2g2?=
 =?utf-8?B?U0tHeWw3Q2xuMFd3VGo0dzNWR3gvYVR4VjRUUUFkZExiRGdtQTk2aWowek5L?=
 =?utf-8?B?NjVVQnp3L1ROOGZxd3hvTzBQN2NiRE8zbEFITERQaE1tMFltSTFWc0wzYURQ?=
 =?utf-8?B?Q0VkWFNrZ1FBNE5ZNDhjQ3lWdGlIeEIrNy9KWTZkcCtDbEpGTm53VlEwSWZC?=
 =?utf-8?B?dC9vMktmbU9lMHdaZUliYkVvTVZvbVpORmg4djB3aVloK1FnK3BYdTRoczFY?=
 =?utf-8?B?OEw5a295ZW5BUERCdUx4VmlXMHlLOElvSDkrMVd5VlRNdlprSTFYOWk0L01H?=
 =?utf-8?B?dGNWdkVLREpWMkNQWmJ6TlVENmtQV1dZVDhkWmtHQ3hmNlJ2aCtwNWRmdlJh?=
 =?utf-8?B?cWpscFJsUGFYNFNRMFdJYU8vR0Z4OEh2T1dPclpZcTJKc1NvcW02aEw4SEdP?=
 =?utf-8?B?SnBudTB6a3hZSUVOWTlESmk2OVZNbndFdURhQjRHemRRck45YUV3akZ0cjhH?=
 =?utf-8?B?VTBNTlI4Y0tKaTc1UnlPRm0vTjdYWG9BOXhmaUVZTG9WQU9rSERJN2pDZUJx?=
 =?utf-8?B?OGZOWnlDLzBRSVJ5cUg2YnRjaEh2cHBDMUtWVElLZmdYYlFBSkc4ZzUyOFpi?=
 =?utf-8?B?MnlBMGc4SGc0T1Yvbm1nS25GalpiTEVlNERWN2R2ZHVlTnpGVVVZTW0xWGpr?=
 =?utf-8?B?MTBhRTBmb09OQ1REeEVrYkVBQ0FQL2xqcmtvTFEraWlGSjBpemN2K0NIWkNX?=
 =?utf-8?B?aG8zbWNJMmpEY3JOR0lkSm9OL0JJSTJkR1BJQmdlZnhwWTlROFk1cUhGdnBU?=
 =?utf-8?B?eG5UbzcvYVdiMTJWKzdKdlU5NDhDaWgvY1hwejJOUTEzOUo0MzNMeTVSY0Fs?=
 =?utf-8?B?WDJyVzJ5aml1MWdsN3lmdEx6TjdFWFRxd1ZtNUdTaVlzYkp1cUgvNGxrWjBn?=
 =?utf-8?B?MlJGK2F4TjdZNy9lK2JmcTVhbURNNHJCeWM3eVVMRERxdC9yRWZ5KzIrdnln?=
 =?utf-8?B?SXE0K1A3QmlKSEtBYldDZUNhWW14Q0p3M0xmZVdNZWJtRXVEN0FhVWtlc0VU?=
 =?utf-8?B?QVZnU2MxQ0ZSS0MwYWprNCtUTFpVL1dxL0c5T3JIdjBId09yaThpTnp5S1Y3?=
 =?utf-8?B?UFVBQ0xRdnBUZ0tXek9Ec3lvTUVWUVNhalZnQ29ha3lzQURQNENMa0MxYWM4?=
 =?utf-8?B?YVRIV3ZuN1ZkVUVhd28zMENWSlUzVTNQRS84MUFwUnZ5eVBPbEoyN01qSFIv?=
 =?utf-8?B?elcxQlAyLy9vek5qZE9hUVlBeTlXaHgwUzJCV2MrbGF6S1ROdjlqU0d3bTBk?=
 =?utf-8?B?My9GVm1RMlFJenRjSklXbm9uNmtVbmsvcUJRSUhYdVFtTGhYZFdtbWdtRVAz?=
 =?utf-8?B?WGxaNDBtR2lFMWdob0lSOTdSVE9nQ0hzMXJkTkZyNkNiVXhkSEg4TDlkazVj?=
 =?utf-8?B?NnhqMlZmbVA5bGMwRFh1VzV6QUE2cngxck81dHVPQjh6aHg0OGQrblNqaXJR?=
 =?utf-8?B?aDRPYnZ6T1pIK1NSaDB2akVoV2NaQitzdTJoWXZ3MVdEMUZzK0hSVTFSN0x1?=
 =?utf-8?Q?QUSehve6H3Mww?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR09MB6518.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDgzUktCeTJodW5Oc05rOEswU0psTmVDbERzNVdpYWZ2U1FvQVc0cmxDandY?=
 =?utf-8?B?MmJ1Z0Vubk5JUGRvcG9SYmliTUVnVTZxVjNnRkEwOXpQVnlqZk1HZTJUeXM0?=
 =?utf-8?B?RG15N2p2OFQvVWJ3eHYrWnV3aXB1ajZ6S1JhNi9RODBLZjFvWEQ5YlBpOUUv?=
 =?utf-8?B?NXdTd2I3cXdIWWk5dm03Ylpzd1Y1MktadlpKTWFFd0NoQkVxQ2ZaMkg0Njdz?=
 =?utf-8?B?SFBGRFc0MUs4L1Y2VTVTejdya05pcVZRS2I1VWs5aHhTSjU4bkpob3lwZXM5?=
 =?utf-8?B?a0dBZHJsRW83TGZSS1FLU3lKbFduNWUybVZ1WTZCbmFUV1cxV0JBemQvOEtL?=
 =?utf-8?B?RXZiTm91Wk85WEFrQnF0VHVjSmowbWJuVkZYOVIycjB0eWhGaFpSOVhPVTlS?=
 =?utf-8?B?bVBrLzJqL0QrTzBxR1ZSKzhoRVRmUXlLN3NVQnRZMytNc3Q1UE1QcXRPNk1x?=
 =?utf-8?B?enF6SlRjU1NDZXFLaU5yNmc4cnQ4WHFtM01BQUp0dk1rOVdzbmZuRUc2V0hW?=
 =?utf-8?B?ZW1jR2dKbncrUnVOWVFkMkpHUXN1YlVHM3Z6YjFyRFFuR3YvWEo3NGh2NGFD?=
 =?utf-8?B?TFQvUSt4dDI2bkloV0dPNW4zQ3doeEFJUkdDYXdmQmRWcHdtMzZ0a1JVSXZi?=
 =?utf-8?B?OEhqTTBTOHZaOCtodWM0bmpWajRVbk1pYUd3emtEQjNCZyt3RXVYOWI3TlA0?=
 =?utf-8?B?TjgvdFRTdEJlSmxWdUo1cEJZbzVoWFhCZDJMRjBpSjZSVnF1MHA5eTVLVTZt?=
 =?utf-8?B?TkJYRGtSYVVJWWRmaU1lVjBLZmZSdlI2TDd0aUJ4Rmg4bkNBUlpoeDZTaWJw?=
 =?utf-8?B?SVdneHM1alh1YUpNU1lab3A2RDh3SEtmWmpDclhXYU4yQUllSWFZUjRuT3U3?=
 =?utf-8?B?NlRjWHZ2STNWQUJxUC80MG5zTlo0SDJORDVHc3pwTVNVaFdIVG5ZNzVxdm5H?=
 =?utf-8?B?dTE1dE91MG10WCtsVGl0dUdqYXlkWExHVzUrVFp6Z3VSbjNSV0lsczUvUE14?=
 =?utf-8?B?K29yeWplNWFibHdVY29wL1NJck52OHFweUY4Yk9xMldlSkR2Z3d3cHdQNThN?=
 =?utf-8?B?RC9SOVgrUnJ3cHNIdUNnZXY1ZTNSQ2dBSlBVbHhOSEE0TVNPbVYxUFgveWNl?=
 =?utf-8?B?VG10Q2trL1lIZWMzVmVrclpDclZhN2RHQ1IvMGFqekErU1liUUQrTG5mWmdV?=
 =?utf-8?B?SEprWnNzZFZFKzBIeUJQcGNjaVJGdSszV0taenF6am1FQWlvYy9WcGFFY2pC?=
 =?utf-8?B?blZDSE9pOWQxWjZBc2l4UlBqeGQwbGEyNmw0SW8xMVhhVDRMSjhXWEZqSWdF?=
 =?utf-8?B?T2RXak9uSCtaa09IOCszOFluRFhoWFVvdnhLNTJSY09uTXVLZUtVZ1dXQmtt?=
 =?utf-8?B?MWxHWE53WTZ0MUdqVkVyaG1zNmRFWUlxeFNzdkw1S2gvZnlVT05vTERuUFA3?=
 =?utf-8?B?TmVBQkdldGhuaS95Tms4MldER3F0SjZzMG9JTUxmYVY0VHYwWUtneDY1bTh6?=
 =?utf-8?B?SVVRUk5FV203dWVkaTh5WFc4TlVZUlhvQWIxTGxNcnA0LzFSZ0dRUGtXSUdj?=
 =?utf-8?B?bXkvc044SlFDY0NkTkxwdTJvL0pyMVZieXd3dng2QmxiUEduY1V4Um5BL20v?=
 =?utf-8?B?ZmpuQklUNnBvaGdPMXMxSkt2M1JwTTFXUkFhbGdVRXVmRU1hTlZxcjhDVUdL?=
 =?utf-8?B?NmNNTHptUW04SU1zWTh2d0t5cWRvdVEyQkZrbHBScmJUdWhPZThoejUweWRU?=
 =?utf-8?B?Q3IwaDJqa2FoVWo2YXlwSXR1aGQycXVvZFF5MVBrdm4reTh0RzlENC90dVpE?=
 =?utf-8?B?NkwyR0VyRWEyWFQwb3RRWkRoUzlJNll3cnFtVzM4aUpDUm5qOW5tMmlpVzlH?=
 =?utf-8?B?WndNbjVqVVpLNlgvZEF4MThFVmFOREhwVW1JWDgwNFM2RTg5NGFBZVpqVE4v?=
 =?utf-8?B?eVlORG1oNXo5eGhwOUlkbDJmYm5hU0NxMGx1b3h1Sm96MlZCb21TTEtycUQv?=
 =?utf-8?B?RFZQV1JldkJNQTBoMmE3eERNQ1EzVTFCK0RmbUp6YmhSZTFsbEJuOUlOcWNo?=
 =?utf-8?B?WFhHdzRsNXFlQy8xamZ5KzVRakk4N09KZ0M5NE4vOVJOa3NYM0JMSk5sbXhk?=
 =?utf-8?B?c1R0UExJeTRka0V0SHlNMEtHaHIzMEJDSGhuMktBMldEVDJidmtLUnUxeEVB?=
 =?utf-8?B?MkE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1815cc88-d114-4972-8748-08dd66e19376
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 12:28:38.4145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47lmcwFjEVpGveZ2GlscBbzlgfnEYhYIQOOhpfYzp6WhCyUdAN3lXjdLrtgRo6VJeXdUjIiPZ8BnBDUiGHNg2wV3tL/vWnaqDjCC3TRJAv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4121

SFRFQyBQdWJsaWMNCg0KSGkgZXZlcnlvbmUsDQoNClRoYW5rIHlvdSBhIGxvdCBmb3IgeW91ciBj
b21tZW50cy4NCkkgYW0gd29uZGVyaW5nIGhvdyB3ZSBzaG91bGQgcHJvY2VlZCBmcm9tIGhlcmUu
DQoNCkJlc3QsDQpEam9yZGplDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCkZyb206IERqb3JkamUgVG9kb3JvdmljIDxEam9yZGplLlRvZG9yb3ZpY0BodGVjZ3Jv
dXAuY29tPg0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxMiwgMjAyNSAxMToyMiBBTQ0KVG86
IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBqcnRjMjdAanJ0YzI3LmNvbSA8
anJ0YzI3QGpydGMyNy5jb20+DQpDYzogQ2hhcmxpZSBKZW5raW5zIDxjaGFybGllQHJpdm9zaW5j
LmNvbT47IHNhbXVlbC5ob2xsYW5kQHNpZml2ZS5jb20gPHNhbXVlbC5ob2xsYW5kQHNpZml2ZS5j
b20+OyBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+OyBhcmlrYWxvQGdtYWlsLmNvbSA8
YXJpa2Fsb0BnbWFpbC5jb20+OyBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnIDxsaW51
eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnPjsgUGF1bCBXYWxtc2xleSA8cGF1bC53YWxtc2xl
eUBzaWZpdmUuY29tPjsgYW91QGVlY3MuYmVya2VsZXkuZWR1IDxhb3VAZWVjcy5iZXJrZWxleS5l
ZHU+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgcGV0ZXJ6QGluZnJhZGVhZC5vcmcg
PHBldGVyekBpbmZyYWRlYWQub3JnPjsgYm9xdW4uZmVuZ0BnbWFpbC5jb20gPGJvcXVuLmZlbmdA
Z21haWwuY29tPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IHl1cnkubm9y
b3ZAZ21haWwuY29tIDx5dXJ5Lm5vcm92QGdtYWlsLmNvbT47IGxpbnV4QHJhc211c3ZpbGxlbW9l
cy5kayA8bGludXhAcmFzbXVzdmlsbGVtb2VzLmRrPjsgcGFycmkuYW5kcmVhQGdtYWlsLmNvbSA8
cGFycmkuYW5kcmVhQGdtYWlsLmNvbT47IGxlb2JyYXNAcmVkaGF0LmNvbSA8bGVvYnJhc0ByZWRo
YXQuY29tPjsgZ3VvcmVuQGtlcm5lbC5vcmcgPGd1b3JlbkBrZXJuZWwub3JnPjsgZXJpY2NoYW5j
ZkBnb29nbGUuY29tIDxlcmljY2hhbmNmQGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gcmlzY3Y6IFVzZSBaYWxyc2MgZXh0ZW5zaW9uIHRvIGltcGxlbWVudCBhdG9taWMg
ZnVuY3Rpb25zDQoNCkhpLA0KDQpUaGUgb2ZmaWNpYWwgcHJvZHVjdCBwYWdlIGlzIGxvY2F0ZWQg
aGVyZToNCmh0dHBzOi8vbWlwcy5jb20vcHJvZHVjdHMvaGFyZHdhcmUvcDg3MDANCg0KVGhlIG1l
Y2hhbmlzbSB3ZSB1c2UgdG8gaGFuZGxlIEFNTyBpcyBkZXNjcmliZWQgaW46DQoiNy4zLjEwIE1J
UFMgQ29uZmlndXJhdGlvbiA2IFJlZ2lzdGVyIChtaXBzY29uZmlnNikiDQoNCkJlc3QsDQpEam9y
ZGplDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IFBh
bG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1
YXJ5IDUsIDIwMjUgNDo0OSBQTQ0KVG86IGpydGMyN0BqcnRjMjcuY29tIDxqcnRjMjdAanJ0YzI3
LmNvbT4NCkNjOiBDaGFybGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMuY29tPjsgc2FtdWVs
LmhvbGxhbmRAc2lmaXZlLmNvbSA8c2FtdWVsLmhvbGxhbmRAc2lmaXZlLmNvbT47IENvbm9yIERv
b2xleSA8Y29ub3JAa2VybmVsLm9yZz47IGFyaWthbG9AZ21haWwuY29tIDxhcmlrYWxvQGdtYWls
LmNvbT47IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcgPGxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmc+OyBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+
OyBhb3VAZWVjcy5iZXJrZWxleS5lZHUgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT47IFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+OyBwZXRlcnpAaW5mcmFkZWFkLm9yZyA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+OyBib3F1bi5mZW5nQGdtYWlsLmNvbSA8Ym9xdW4uZmVuZ0BnbWFpbC5jb20+OyBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgeXVyeS5ub3JvdkBnbWFpbC5jb20g
PHl1cnkubm9yb3ZAZ21haWwuY29tPjsgbGludXhAcmFzbXVzdmlsbGVtb2VzLmRrIDxsaW51eEBy
YXNtdXN2aWxsZW1vZXMuZGs+OyBwYXJyaS5hbmRyZWFAZ21haWwuY29tIDxwYXJyaS5hbmRyZWFA
Z21haWwuY29tPjsgbGVvYnJhc0ByZWRoYXQuY29tIDxsZW9icmFzQHJlZGhhdC5jb20+OyBndW9y
ZW5Aa2VybmVsLm9yZyA8Z3VvcmVuQGtlcm5lbC5vcmc+OyBlcmljY2hhbmNmQGdvb2dsZS5jb20g
PGVyaWNjaGFuY2ZAZ29vZ2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBEam9yZGplIFRvZG9yb3ZpYyA8ZGpvcmRqZS50
b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHJpc2N2OiBV
c2UgWmFscnNjIGV4dGVuc2lvbiB0byBpbXBsZW1lbnQgYXRvbWljIGZ1bmN0aW9ucw0KDQpbWW91
IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHBhbG1lckBkYWJiZWx0LmNvbS4gTGVhcm4gd2h5
IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbiBdDQoNCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNp
ZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlLg0KDQoNCk9uIE1vbiwgMDMgRmViIDIwMjUgMTM6MzQ6NDggUFNUICgtMDgwMCks
IGpydGMyN0BqcnRjMjcuY29tIHdyb3RlOg0KPiBPbiAzIEZlYiAyMDI1LCBhdCAxOTo1MCwgQ2hh
cmxpZSBKZW5raW5zIDxjaGFybGllQHJpdm9zaW5jLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gTW9u
LCBGZWIgMDMsIDIwMjUgYXQgMDE6MzA6NDhQTSAtMDYwMCwgU2FtdWVsIEhvbGxhbmQgd3JvdGU6
DQo+Pj4gSGkgQ2hhcmxpZSwNCj4+Pg0KPj4+IE9uIDIwMjUtMDItMDMgMToxMiBQTSwgQ2hhcmxp
ZSBKZW5raW5zIHdyb3RlOg0KPj4+PiBPbiBTdW4sIEZlYiAwMiwgMjAyNSBhdCAwODowODo1MFBN
ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4+PiBPbiBTYXQsIEZlYiAwMSwgMjAyNSBh
dCAwMTowNDoyNVBNICswMTAwLCBBbGVrc2FuZGFyIFJpa2FsbyB3cm90ZToNCj4+Pj4+PiBPbiBG
cmksIEphbiAxMCwgMjAyNSBhdCA0OjIz4oCvQU0gQ2hhcmxpZSBKZW5raW5zIDxjaGFybGllQHJp
dm9zaW5jLmNvbT4gd3JvdGU6DQo+Pj4+Pj4NCj4+Pj4+Pj4+IEZyb206IENoYW8teWluZyBGdSA8
Y2Z1QG1pcHMuY29tPg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFVzZSBvbmx5IExSL1NDIGluc3RydWN0
aW9ucyB0byBpbXBsZW1lbnQgYXRvbWljIGZ1bmN0aW9ucy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSW4g
dGhlIHByZXZpb3VzIHBhdGNoIHlvdSBtZW50aW9uIHRoYXQgdGhpcyBpcyB0byBzdXBwb3J0IE1J
UFMgUDg3MDAuIENhbg0KPj4+Pj4+PiB5b3UgZXhwYW5kIG9uIHdoeSB0aGlzIGNoYW5nZSBpcyBy
ZXF1aXJlZD8gVGhlIGRhdGFzaGVldCBhdCBbMV0gc2F5czoNCj4+Pj4+Pj4NCj4+Pj4+Pj4gIlRo
ZSBQODcwMCBjb3JlIGlzIGNvbmZpZ3VyZWQgdG8gc3VwcG9ydCB0aGUgUlY2NEdDWmJhX1piYiAo
RyA9IElNQUZEKQ0KPj4+Pj4+PiBTdGFuZGFyZCBJU0EuIEl0IGluY2x1ZGVzIHRoZSBSVjY0SSBi
YXNlIElTQSwgTXVsdGlwbHkgKE0pLCBBdG9taWMgKEEpLA0KPj4+Pj4+PiBTaW5nbGUtUHJlY2lz
aW9uIEZsb2F0aW5nIFBvaW50IChGKSwgRG91YmxlIChEKSwgQ29tcHJlc3NlZCAoQykgUklTQy1W
DQo+Pj4+Pj4+IGV4dGVuc2lvbnMsIGFzIHdlbGwgYXMgdGhlIGFzIHdlbGwgYXMgdGhlIGJpdC1t
YW5pcHVsYXRpb24gZXh0ZW5zaW9ucw0KPj4+Pj4+PiAoWmJhKSBhbmQgKFpiYikiDQo+Pj4+Pj4+
DQo+Pj4+Pj4+IFRoZSAiQSIgZXh0ZW5zaW9uIGlzIGEgcGFydCBvZiAiRyIgd2hpY2ggaXMgbW9z
dGx5IGFzc3VtZWQgdG8gZXhpc3QgaW4NCj4+Pj4+Pj4gdGhlIGtlcm5lbC4gQWRkaXRpb25hbGx5
LCBoYXZpbmcgdGhpcyBiZSBhIGNvbXBpbGF0aW9uIGZsYWcgd2lsbCBjYXVzZQ0KPj4+Pj4+PiB0
cmFwcyBvbiBnZW5lcmljIGtlcm5lbHMuIFdlIGdlbmVyYWxseSB0cnkgdG8gcHVzaCBldmVyeXRo
aW5nIHdlIGNhbg0KPj4+Pj4+PiBpbnRvIHJ1bnRpbWUgZmVhdHVyZSBkZXRlY3Rpb24gc2luY2Ug
dGhlcmUgYXJlIHNvIG1hbnkgcG9zc2libGUgdmFyaWFudHMNCj4+Pj4+Pj4gb2YgcmlzY3YuDQo+
Pj4+Pj4+DQo+Pj4+Pj4+IEV4cHJlc3Npbmcgbm90IGJlaW5nIGFibGUgdG8gcGVyZm9ybSBhIGZl
YXR1cmUgbGlrZSB0aGlzIGlzIG5vcm1hbGx5DQo+Pj4+Pj4+IGJldHRlciBleHByZXNzZWQgYXMg
YW4gZXJyYXRhLiBUaGVuIGdlbmVyaWMga2VybmVscyB3aWxsIGJlIGFibGUgdG8NCj4+Pj4+Pj4g
aW5jbHVkZSB0aGlzLCBhbmQgYW55Ym9keSB3aG8gZG9lc24ndCB3YW50IHRvIGhhdmUgdGhlIGV4
dHJhIG5vcHMNCj4+Pj4+Pj4gaW50cm9kdWNlZCBjYW4gZGlzYWJsZSB0aGUgZXJyYXRhLiBBIHNp
bWlsYXIgYXBwcm9hY2ggdG8gd2hhdCBJIHBvaW50ZWQNCj4+Pj4+Pj4gb3V0IGxhc3QgdGltZSBz
aG91bGQgd29yayBoZXJlIHRvbyAoYnV0IHdpdGggbW9yZSBwbGFjZXMgdG8gcmVwbGFjZSkNCj4+
Pj4+Pj4gWzJdLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBbMV0gaHR0cHM6Ly9taXBzLmNvbS93cC1jb250
ZW50L3VwbG9hZHMvMjAyNC8xMS9QODcwMF9EYXRhX1NoZWV0LnBkZg0KPj4+Pj4+PiBbMl0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9aMi1VTmZ3Y0FRWVpxVkJVQGdob3N0L1QvDQo+Pj4+
Pj4NCj4+Pj4+PiBTbyBmYXIgd2UgaGF2ZW4ndCBmb3VuZCBhIHdheSB0byBkbyB0aGlzIHVzaW5n
IGVycmF0YS4NCj4+Pj4+DQo+Pj4+PiBZb3UgbWVhbiB1c2luZyBhbHRlcm5hdGl2ZXM/IE5vdCBp
bXBsZW1lbnRpbmcgQSwgYnV0IGluc3RlYWQNCj4+Pj4+IGltcGxlbWVudGluZyBaYWxyc2MsIGlz
IG5vdCBhbiBlcnJhdHVtLiBJdCdzIGEgZGVzaWduIGRlY2lzaW9uLg0KPj4+Pg0KPj4+PiBXZSBj
b3VsZCBkbyB0aGUgc2FtZSB0aGluZyB3ZSBkbyB3aXRoIG1pc2FsaWduZWQgYWNjZXNzIGRldGVj
dGlvbiBhbmQNCj4+Pj4gcnVuIHNvbWUgaW5zdHJ1Y3Rpb25zIHRvIGRldGVybWluZSBpZiB0aGVz
ZSBpbnN0cnVjdGlvbnMgYXJlIGJlaW5nDQo+Pj4+IGVtdWxhdGVkLiAgSWYgdGhleSBhcmUgYmVp
bmcgZW11bGF0ZWQsIHBhdGNoIGFsbCBvZiB0aGUgcGxhY2VzIHRvIHVzZQ0KPj4+PiB6YWxyc2Mu
DQo+Pj4NCj4+PiBJcyB0aGUgaW1wbGljYXRpb24gaGVyZSB0aGF0IHRoZSByaXNjdixpc2EtZXh0
ZW5zaW9ucyBsaXN0IHBhc3NlZCB0byB0aGUga2VybmVsDQo+Pj4gd2lsbCBjb250YWluICJhIiwg
ZXZlbiB0aG91Z2ggdGhlIGhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgaXQsIGJlY2F1c2UgQU1P
cyBhcmUNCj4+PiBlbXVsYXRlZCBpbiBNLW1vZGU/DQo+Pj4NCj4+PiBJZiB0aGF0IGlzIG5vdCB0
aGUgY2FzZSwgdGhlcmUgaXMgbm8gbmVlZCBmb3IgcnVudGltZSBkZXRlY3Rpb24uIFRoZSBhbHRl
cm5hdGl2ZQ0KPj4+IGVudHJ5IGNhbiBjaGVjayBSSVNDVl9JU0FfRVhUX1pBQU1PICh3aGljaCB3
b3VsZCBiZSBpbXBsaWVkIGJ5IFJJU0NWX0lTQV9FWFRfYSkNCj4+PiBpbiB0aGUgSVNBIGJpdG1h
cCBsaWtlIG5vcm1hbC4NCj4+DQo+PiBUaGF0IHdvdWxkIGJlIG11Y2ggYmV0dGVyISBJIHdhcyB1
bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSB1c2VjYXNlDQo+PiBmb3IgdGhpcyBwYXRjaCB3
YXMgdGhhdCB0aGV5IHdlcmUgcGFzc2luZyBpbiAiYSIgYW5kIHdhbnRpbmcgdG8gb25seSBnZXQN
Cj4+IHphbHJzYy4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gY2hlY2sNCj4+IFJJU0NWX0lTQV9FWFRf
WkFBTU8vUklTQ1ZfSVNBX0VYVF9aQUxSU0MgdG8gZ2V0IHRoZSBpbmZvcm1hdGlvbiB3aXRob3V0
DQo+PiBydW50aW1lIGRldGVjdGlvbi4NCj4NCj4gSW4gTExWTSBhdCBsZWFzdCAtbWNwdT1taXBz
LXA4NzAwIGVuYWJsZXMgdGhlIGZ1bGwgQSBleHRlbnNpb24uLi4NCg0KU28gdGhlbiBJIHRoaW5r
IHdlIG5lZWQgc29tZSBoZWxwIGZyb20gdGhlIEhXIHZlbmRvciBoZXJlLg0KU3BlY2lmaWNhbGx5
OiBkbyB0aGVzZSBzeXN0ZW1zIGltcGxlbWVudCBBIHZpYSBNLW1vZGUgdHJhcHMgKGllLCB3aXRo
IGENCnBlcmZvcm1hbmNlIHBlbmFsdHkpIG9yIGlzIHRoZXJlIHNvbWV0aGluZyBmdW5jdGlvbmFs
IGVycmF0dW0gaW4gdGhlIEENCmltcGxlbWVudGF0aW9uLg0KDQpJZiBpdCdzIGp1c3QgYSBwZXJm
b3JtYW5jZSB0aGluZyB0aGVuIHdlIG5lZWQgc29tZSBiZW5jaG1hcmsganVzdGlmeWluZw0KdGhl
IGV4dHJhIHdvcmssIHdoaWNoIG1lYW5zIHNvbWUgaGFyZHdhcmUgd2UgY2FuIHBvaW50IGF0IHRv
IHJ1biB0aGUNCmJlbmNobWFyay4gIFByb2JhYmx5IGFsc28gYmVzdCB0byBzaGltIHRoaXMgaW4g
dmlhIGFsdGVybmF0aXZlcywgc28gd2UNCmNhbiBrZWVwIG11bHRpLXZlbmRvciBrZXJuZWxzIHdv
cmtpbmcuDQoNCklmIGl0J3MgYSBmdW50aW9uYWwgaXNzdWUgdGhlbiB3ZSBuZWVkIHRvIGtub3cg
d2hhdCdzIGFjdHVhbGx5IGJyb2tlbi4NCg0KRWl0aGVyIHdheSB0aGlzIHNob3VsZCBiZSBleHBv
c2VkIHRvIHVzZXJzcGFjZS4NCg0KPg0KPiBKZXNzDQo=

