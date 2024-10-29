Return-Path: <linux-kernel+bounces-386643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2A9B4646
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851EE1F238B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4397620495C;
	Tue, 29 Oct 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="UDsgeD8e"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2059.outbound.protection.outlook.com [40.92.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4EA191F8E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195824; cv=fail; b=BChz4q95AzNL3FgsFxaf0crGMvDh+hYHvLi6kULx9b18yxgDA30aOkcEji7bujZI8KpdmMAqhaYGkOVNFRh4OMHKMI04iVUi0R0t5z9CrR0644HYm/fiZMYkljQ6TNR3GvUSa6Oo0ttd4Kq7ai7MX1TGkpOs/tMMTZ5K9zPgOOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195824; c=relaxed/simple;
	bh=yn2TUqcRiNHldWO430PgjD6yz+1CPoLYO3rCS94aHm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7pLJ24FFgmgr4JsObNcglmC77jzOMZk7gnrBMbuCs4fOaqU+SgIhnpP4Hn7J+gNYp0aOmLiKE/44SpBMZuqJJkoRECiu/P1dIF3jkfaEZZtHv0gEOVifQvahTZao3SjSmxAgkvVOp8GoIn0MWpTCBG5A04ezFpYJo96YUWmlbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=UDsgeD8e; arc=fail smtp.client-ip=40.92.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohp45MLsZyffKpbwF+Ov0Df1juj6GEU38KwbCDWRzvG98lW3oA4oXueLgK+GKUZWVYPWxk80hlJ3gnseC2be9Qf/iURnVsJ6ppBw9p4LG7WgHhPnQ4MD0PC8Lz3Y3Z32eGrUJbtwshBUrC9AwcuBMr8nojiosDd/Q1ZtwOeNnoJaEcQQTtdZsXxRCCHvUn2f5cD15Z3ojKdgGI916MON230RsAFaFX2YH82fg/SW4Gobvgfog7JihyL0FD3mZVTwP6/L7vQEmL9E8mRLXIonfB+qhk1IP5OogZGD67PyGRPAKbGrfyXYxoViGgB4HTLtBR+Avsd1lm+8wv/UpR9LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn2TUqcRiNHldWO430PgjD6yz+1CPoLYO3rCS94aHm4=;
 b=iOUbkJziHvcagusLCHMFcXKH6/14aqjNb/noydFbq5mpR1fx6bDFuxojGYsVR30cGkT1WZDFyiLPWfSHluzM8hMgfcBUqlLsBjVSyR9tUx24qKHc+faXkhafI7nnRj/ivC00y5O0N/YFtuQeQMo/2/QNBEzgRyiyWQqyiuE0RI02QWC+B9IBCE05sGYOaIG8VWsO3lUjf7MO51MK5dlzMMrO463L9ShOa236Hp5b9jkKVkoMk1y2fbgQ0bK1qC9pYz9eBZ/QGu98S5Nr3fWUPkEsjMufx1+oLjk4OHKuTTZ81Sy3gM4OSnkfR9J8D7Dokac5ZgqgXRIu39YEeteM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn2TUqcRiNHldWO430PgjD6yz+1CPoLYO3rCS94aHm4=;
 b=UDsgeD8ehxOWIlcVnmmDDsRLJ9aLg/a8ybD//XkNVPxVqrsHyP9HkktdL8bZUfDlzmnNp5Hpd1EXLwkoQBbHynY/AnpweNx9EsdgAAk7PJvszN7EOrxPBusr33U7KDdd0Ayc70EkY4XMvT6ht6WilI92b8xbr6c+ubzsievSy2CJEOxmu3h1p1GQVRXL2JSMy03Of9n5coVEzn0aXcatPzL1fs1TYhCsjBLFslQAANVyvu6ZOi6zQDReo2ag4mrBAkbhA0+4sUi8rL6ISjCOnRaAHUf39YWdr9Rgy7/Q3KOIQoSbUssXjwgrVBJhbaMQ0Ufxe1TelwYjmI5MhE64eQ==
Received: from MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:159::11)
 by SY7P282MB3946.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13; Tue, 29 Oct
 2024 09:56:58 +0000
Received: from MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f65e:52a:9bfb:525f]) by MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f65e:52a:9bfb:525f%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 09:56:58 +0000
From: Ryder Wang <rydercoding@hotmail.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>, Waqar Hameed
	<waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: "kernel@axis.com" <kernel@axis.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
Thread-Topic: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
Thread-Index: AQHbGydq3UGpSRV3ek+T5tpnLt8T+rKdeqgFgAASuACAAArg6A==
Date: Tue, 29 Oct 2024 09:56:58 +0000
Message-ID:
 <MEYP282MB316491A32BE6F870B093540FBF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
References:
 <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <MEYP282MB316412B08A32373E5ED9B896BF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
 <fc567699-59c7-265a-b7c8-7b658cc6fc05@huawei.com>
In-Reply-To: <fc567699-59c7-265a-b7c8-7b658cc6fc05@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB3164:EE_|SY7P282MB3946:EE_
x-ms-office365-filtering-correlation-id: 32a19f6d-3c69-47ff-7060-08dcf8000721
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|8062599003|461199028|8060799006|19110799003|7092599003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 X2ZDpihVUloWj8Fkp+v898e7I+XtHeatDeK2oRlPEPC9j79FGs3RhRKfUJTIKhuEdXhqr4s6JSpEq0rzZVF5iPhitge5u0m8+snKAvf35ZG62x4k60nCbeKc8HK9kSlT+O7Gcf/bBjt1De/hjmotwvwbU9jXBwPDmfl72A5qozNm34riPUAn19ECBQ5o4GGHJD10hXlSu1IG4Nb/ikx2k30H2WPWO5mBiErWu0ETznbozsNtO8K4YdaOaK2B6SJUKwc5N0YvFluNPgOdqxIU6ckdppdmOPSn8/GHNlrBMauJ7OZPGzhKGMNQMJhd4oaDJs6zVCNY7t9IgTRgDn79iRzWuW5mN55Azgk7qhOiyN4ekl5TCURE9rkq+SQnFFOU/yP8ox+ZdOyYTkElhgE+GZIoRCQf5HmpTeL9AuDytd7gK+8XRCnEV4GdeMzs9fQdSRVw6cel2O8y4wJAWWuzsp4mVazgayTKI8bpcV7g5i9krqxAyliJsSXfeGru1NVmp2zNmI140e3VWQd+QBYNQA0LbPRPV8ZRo8UTb5IxGo6BG9365G3ApxdDpa0jMS4/Y8cbD8FQprz27ZIJsyL/1ytzMy1dTqXbRKyt2moiw4afx+7EZI5dWriXCdYsshO7fJEj6ccsPwQoxaRMeiBWVlx/zqlIYohc+FGp+vahppVw8/YGKSX1nD8MaK9WKbYU/0COGvlrlD/zQg4VIMit/3Dxs0nzYGppl0lpUpZWKEO7fLWYBCZMk4pjLor26qkhxZG0rSme47ACfie9yJz4Cw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?87mk1g3eF8ErUTfiLz3iDpGZkzKUqjZfhYhF8ZR6vNVsev77yVu2zVJH6c?=
 =?iso-8859-1?Q?x+n9KvmOMDFrCYqjywG5qGlei0dmVK4fGz8i66OCraLtfdJJUdJJFcYEA4?=
 =?iso-8859-1?Q?Ankt4zNlNtfdpyCen6yUH1jif4Hre9ZDT3oeif3U7oiDgmLDQfEpJctokG?=
 =?iso-8859-1?Q?sLcpc9/bhetoUFBbbvbV23UsfLPDYYORRIMnhMN+GtFx+7TsHkazJ3BiIs?=
 =?iso-8859-1?Q?ktoA6I0YybspV0V5igCx2I++cvk9egKE1HhMdPrerDcrsqUT7r6ynDjpR8?=
 =?iso-8859-1?Q?5MBGTSccpk51sKQxw7rpaO5vZY+QL0hUQLMCFiLgvSgiFXyHsRw7MywmkT?=
 =?iso-8859-1?Q?MwzI/D1ShP+qiRprfAlEKKo8QOdfrh12kJPaAa5HRJK9N67qvv4nZkW35P?=
 =?iso-8859-1?Q?9EtA5XJRFn/exIGsCnUxQIj1qZwNHjBO9ZJV8PfOaXtkXIsg2wHb496PHt?=
 =?iso-8859-1?Q?IWgdbfjkS0KPv1+5VWoFrBKPj6cNN6PCE2mHotmI2aS1mD0w6bgxplkcSu?=
 =?iso-8859-1?Q?ZI86Fn0vDwLpdUpe9jNuvb+5/cPXog9bSM8OlQnf29fUWXUH9cuXmLKfly?=
 =?iso-8859-1?Q?Jny9NNu9m7K4HgpKUkbC7/nI9JHhDrCVc3PWgmsh133kD4BKpBgikbjRvp?=
 =?iso-8859-1?Q?cMCBT/dvyt4QOOq1d/UGQBB2uPg7A87hT0msbWkarJyAosVy90xuDcI+Xe?=
 =?iso-8859-1?Q?nv4u7bNbj9s63Rk1g3J6zwLklK7PO3uY/75emuVtRGatDZtimDO/fyF2nc?=
 =?iso-8859-1?Q?eJY6mCUJKL5W2uLtTln5h2Io3SOalSYWndHwhnTEUzigik/AAUdDRIBWnc?=
 =?iso-8859-1?Q?0MlNN6aheeCB4uIeP9+rmOcguKPgURedAtLcgJvdM8Cu8dg0VqGO9ixvw8?=
 =?iso-8859-1?Q?S4FRdlw/mpX3amvU3iCX5p34c43fwDieiUtGrNLE61Jfs5W5P21S9YZyFM?=
 =?iso-8859-1?Q?fUm0oq+pPza99vmsqbiLvu+td2ZBVuOVwGY1xvQbP/3s3n+KFCHRAYeiD/?=
 =?iso-8859-1?Q?YSA4p10MOViHbTIRjWOf9jEtxmoehSUCyxeRHgZCf1Ilg3vQsFwJkIfgst?=
 =?iso-8859-1?Q?3kTLPwwuCk4gCAwjEkG/zydl3yMtIdx4ObAAlxF5Wmn7wcs3NtAJP5JROE?=
 =?iso-8859-1?Q?/KBndIpKush34kV3EkM3Ud0cbS6P9Ra+CrBS5meikoHQjjmtyojWyH5xLR?=
 =?iso-8859-1?Q?AI03UScVRpruyHAdp7yMKwcoHHgwzEMLzORrEzJ4JN3/dQL/P2NfsLnjaA?=
 =?iso-8859-1?Q?gwCGaOFMeGWUD71pq/Q1wwgNgqqgnmfXpitAoaxEw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a19f6d-3c69-47ff-7060-08dcf8000721
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 09:56:58.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB3946

> Thanks for reporting that :-). I noticed it a period time ago too, and I=
=0A=
> found 'c->znext', 'c->cnext' and 'znode->cnext' won't be accessed (in=0A=
> write mode) by other tasks, because there is only one function=0A=
> do_commit() modifying them and do_commit() can be executed by at most=0A=
> one task in any time.=0A=
=0A=
It looks the race condition can really happen in this case from the issue r=
eporter.=0A=
1. do_commit (ubifs_bg_thread): it can finally touch unprotected znode whil=
e calling the function write_index().=0A=
2. ubifs_evict_inode (other kernel thread than ubifs_bg_thread): it can fin=
ally touch the znode in the function tnc_delete(). Even there is mutex prot=
ection for tnc_delete(), but it has no meaning because of do_commit (at the=
 point 1) doesn't have such mutex protection while calling write_index().=

