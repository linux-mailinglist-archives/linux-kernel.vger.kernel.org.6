Return-Path: <linux-kernel+bounces-343276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B466989903
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159761F219F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B88F45;
	Mon, 30 Sep 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="uz+u4/U2"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF306FC3;
	Mon, 30 Sep 2024 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727660882; cv=fail; b=AC9+8vBKpdr1qJdHxT5IkGchXHayIYcjY1Ly4VHKptBqblUmG8N5gXUzwPq407aXfJuTaK4WHC9OEEe8LGsF0QtikD1p4LHF7XGOk84q/kjaJf6kpzXPoXpwbiBcM012b8XTdPVMbUIZ542PooP+ZR2SGv+46n3jptvDOg8TL5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727660882; c=relaxed/simple;
	bh=FneLy7/IT3VfbFlK5jfh0Gf1Vw29Enb3uG3ct7eGRxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MpzS7mLBUj+llOIyuzcctUz0B4IS7POkox6TkGxmDymce/BGoUvr2sLL+N8JcTHqxElBL3M8rSP1lZ4wCJSkAiPNqDCNxfDLcyHDZ4RH677GcSvBRn7MT3L2nVxpg2QACv2EvHKS/O1d5S6aigyJGhMy1AhyZbAM0U39P5q/Yds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=uz+u4/U2; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7ve4EcVLGEJ/6fK6+3iuZkFoXOxmCNNB8qLY3+fCsbked9hkmIS8+aXkkLNyrewhAlO1elkV5suIZT6DEQ6XjZGMlsMX4vr388HNbMj9rzvFEJdCsWiyZ6QHLzCGh1FKJf1d8ZCxdllS4xAUM7LErhcozxfNoG353HuiL2d9ZZ0t85HbegY4DcotRZvedb7NuV38oDKbetAvxXmHeUFVLHbBYNaT8QN1WRZL7kfeH+ko/U33UlR7lTmq0cJ97ygVAsyUX+g5K5Lqbvg6xzCwQPvFkUg+QnA1yS3NrjP9V7duVwi1e9/VfkX0olnV9DesVlKSsPxMdNtuwOScMq1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRqDcvoK/NlrS9UqVSUaoWLDhf6jPrFpUmrvNMSrSNw=;
 b=MiYSatxJwb1Q7eBVjM6Qs90DkdTsuS1yzBBrpHBwzjD/ye2yP7SSC19EhtwG33KOFGtDp6tQKeCi7EFxs2iVyi3icyTtmCA4oAy4cwP9GJ2TmpUsadFbaOb+S79hLsyBiPoL/Cdpd5EZlLrQM7PunlEL76d5r2IPLspXuo7YeIgjD+RfBrEdR+8m16kn4Hgz2/6Kk0RH5LH3oJyD8jU6Oo9Yqp4pEkYMjezd4UuQyeGOoxpQqnyWiCtZvEpRknJpPB9HAyAyDY+5zRxBLfgX4iMz/ynkJXMRsKUz9LszWFEdbgwNV6ecYJR2FRraz6DdZ269+1MA1hLdyhXgp+YZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRqDcvoK/NlrS9UqVSUaoWLDhf6jPrFpUmrvNMSrSNw=;
 b=uz+u4/U2Pa5GoWWgG5Z4bKt6LPRPoHYafzzwSTef/4rNO15rrKZ14qbSEHY2atl317qGPDCnO5u64F7K/joBEjqH1lIFen+8wyUxEskmRyMVUfBl1kShSD7Kgk1obiW6iMNKyXmvbUTdAEislY8o4qVS7yMOh6SjMsFMrCHJgbHogHn5KBSzpG9AzbqezeOmPSo7/wm2rYg0Yly6M1x/QM8+dMirwVP1LsnIXfixIiO3Qh2UACP38yhbegHlecs8UIl/AqAP8F7fGRuij80vWv0mEta/qIiwkEN/MDwJH+tYwAAvl3jJvMflqf0vziIDL10QMkmQgx5219Zldzm/Tg==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by PUZPR04MB6607.apcprd04.prod.outlook.com (2603:1096:301:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Mon, 30 Sep
 2024 01:47:52 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 01:47:52 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Patrick Williams
	<patrick@stwcx.xyz>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ricky CX
 Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
Thread-Index: AQHbD72dvqgTMAKzWkuYvi4zIhwj+rJrJMWAgAAxixCAASfCAIAC9XGAgAAdDXA=
Date: Mon, 30 Sep 2024 01:47:52 +0000
Message-ID:
 <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
In-Reply-To:
 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|PUZPR04MB6607:EE_
x-ms-office365-filtering-correlation-id: 74f8f06c-b640-4e6e-2c53-08dce0f1e5ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Nev4Gr3P4039pDHGmIzQl/t9hB6VV/4jeXUTam0wRtRFAAee0kXaIe5Tsvsy?=
 =?us-ascii?Q?6h4223tCFqyuQEakwRBcK3ci8e0LvvZhQNlS4s/sEr7o+ciZhMvZGshzn19i?=
 =?us-ascii?Q?trWdrhFLlOfv7qW704ajKxiWJCOeDyaeftKk+cHBMjoINCF3UWnVzs4rLlop?=
 =?us-ascii?Q?GxcpNh90ENq5IHdsRzMpMpNnxCgAlAn6AjbmN61i2geNW6sjnl93oXXSzLqh?=
 =?us-ascii?Q?xj0XkLnJeEJFjDqkKwPr6Fzht3fiV6Y5s03CvA6QPeyocGc/Em5NeBKsu4W5?=
 =?us-ascii?Q?kCN5VxsTZ3Y2LEk4FruLJ4/wFjh11BV9xQskUMk5451BHo8Q7JgIVvHgPgHG?=
 =?us-ascii?Q?ng60hPdYIA4hB4/ImtOpEDLvQYRnHHcZRcPg7arAekbwhASB/Dt0U82C1qOw?=
 =?us-ascii?Q?Hk3KYw5lpMbT3YXAQtRkh4pflq49BsglHHU83nfe+6Zb3nDt7na4dedxar8s?=
 =?us-ascii?Q?SDMS/x9ssgGyPXN61S1yGbvt49HoYPQRW/8Je3BgNh90SC+SQSHGXPWC/MyO?=
 =?us-ascii?Q?HtqmDWXzw72EYV6yZMVJIhK4jbwGTyQwh3pDwc2kMP6498wO0bBTduWTCpF6?=
 =?us-ascii?Q?ZXo08bGfMFzNZigwqsV3Aqx3iHJOXRHPcN3x+aERqV/YQPrm277TGt6zOk+D?=
 =?us-ascii?Q?YLrak2JnttJjj+WGdH1nUyKcbl42bH57oH1ryuW2r8wpd/OAWRZ+2yDo6bpC?=
 =?us-ascii?Q?HbnLfvPrx2Qd3eyLnDnJNjD5vgm0h0b5vhgcNe5juoQ+zLCll22zU7ols/dE?=
 =?us-ascii?Q?BUTT4abvWFXzgFH9ClVz3TBR9PPKAX8EKlDCGQRqnqHCqvgtd8nSeawq0EqX?=
 =?us-ascii?Q?yworiLo/VR9v+KN7njI+ZUI7JVGamfSZes4/MkMzV+wh6KmDtyS2l54Lqzud?=
 =?us-ascii?Q?FQJllG0qPYQgO3MPM2b0d0W4rBnBjPpXTV5de54rvvfDY3HKbDpDzHBxdwR2?=
 =?us-ascii?Q?f5pd5PocFBfiucb9ToX0RiMeRfrCOjxw0ulajHkQF/p6hTbR+4d+k+YP/4c2?=
 =?us-ascii?Q?wNiKYhIFMT0EBKKKIkH0U5J7wMwoPEDAOVyn32lgWuAt/stXLgVcr2UYWo3c?=
 =?us-ascii?Q?UoonZ5tKw1FfF028x6TacqWmDKKPtCZi4ypFLelcLxyYUw/4UceRIwlLLf8r?=
 =?us-ascii?Q?eg/FSFxU47VSgKsa5U2G+kY8ZWvB2iqkvUd9nmmH55ZEkF3P5AjMo1qfNF0c?=
 =?us-ascii?Q?va3ObPS6wSrVEHNoaDgzjkxz1Y7IrVmeLzHYNKwnoSYI7f8fJ1zI8BlFsfRO?=
 =?us-ascii?Q?YqbKoUGaSH6lFJ5iRQBzDMga2+HObxAAZT15WPAwKtUgvx2NVe0/yxevd5po?=
 =?us-ascii?Q?sOKVfCsnEVZA/px17UebxluJ3lQ0CrwLbtFz/2KGpy+KXA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zMho9Q2vCWWkopXeO0HrOCBZSS1y/GlzeVcUNl041OvVcF8rleABy1so+eTX?=
 =?us-ascii?Q?qQZmFHY8LNrISPexE09E77XZHG5QFnwgeEor2pXy4ybR+IWvHkMXEvFPR89o?=
 =?us-ascii?Q?sX7Az9qF6tJXJWhJdHZJHa44jBoSw/zNflGzZDG1uKbvrQPI3mXwTbDtENdM?=
 =?us-ascii?Q?3ig+nQ2BfOcyDJH1HOshcpNlRKtHvtV6ZtaiRh6rvSwWzAotIvY54hojRpKv?=
 =?us-ascii?Q?VnZQ9w8bgT2K9axL+YBQAVr8dcXCMjIMDlXEeLKeVWFtb/EZHBGgTne77bLc?=
 =?us-ascii?Q?bkQNX8Ns/vEnwho1kDw/bgAjiMp1SAWbzKb5vRQDtEHU00m9KfPx0tG5Bz84?=
 =?us-ascii?Q?fMvMDiBY2aj7Q+zzZLseaSVXim5hrat69JN86GfBSUWle53PX7CKN2vRFpfG?=
 =?us-ascii?Q?32rxqnmyBRKbenc6RXOxVmqI4pLL8d0wPQ+hc55ZhbPKhaGa/EkvM4jDIE1e?=
 =?us-ascii?Q?WTIFdWXlBSQI7pOVzc88Z0cN9gROd0Rtbz7rf9VmpvQOf5zz6xTaMnBoC/qP?=
 =?us-ascii?Q?HR95oEkk2Hhx3NpifQYEcMqwSZZgApW+2AdIYkpPh++XQDDRt7eHbE7asMmA?=
 =?us-ascii?Q?3/SW+fDDFwWDA2XJ4QyKNIRAMu61per+kMAGPhjGPF1KVceB91UzNGFpr1tw?=
 =?us-ascii?Q?KpZk5IbGvKikBlGa1NQ7+ucgBHH5sXEsK1vwrIiCdzz6WCxcABtGJCS9UI+1?=
 =?us-ascii?Q?1HLJ5kWclGQdvQ1e5mFg/Rq1ZWfFG3V28uRWATwrKgEb014nCYQUcLHy/C5o?=
 =?us-ascii?Q?9qfLVkcyPEKST3AIH31fGsTTlCOXuDpya5hmgT58IofObarCkkjupnsXPJ87?=
 =?us-ascii?Q?U0rHLpdH5tJ4UP64UZlLdyNuCLsfea5tBJ9pkSWnGCENWBh/zBqWJTomon8O?=
 =?us-ascii?Q?KMYYoEjqCKn6EORQitZSMv+BttIPniSspPNCGQy+CosA0wvvyDoyEjmQnQOK?=
 =?us-ascii?Q?9FoUKOU0Ac9HMdYr3yVnfnyaxHU+h3EtT3btFDWmVdbLYcE7GksiYmxN5vsV?=
 =?us-ascii?Q?O5+1BGz6XskYWI2bnWryA3fcYPuvxYK/3F9kHUIGb6+o/cNlRaF09FBuOpQG?=
 =?us-ascii?Q?wb1bmJdcrbtEkVoJxwO+QNzK32EsFfALcMueRG81HFJO+K07tKdbwc7IQ9fa?=
 =?us-ascii?Q?sen13OyKo82AmqTjUGpNXnW63VPEB5jBzsyjN+RDk4nHXy9UrCBUuwC9pqFk?=
 =?us-ascii?Q?O+4lIZ3sJlRd3GUQybybxXFAVWsl86QIJ+fnoe1RgOngWc2Ml9RopP8IUKkt?=
 =?us-ascii?Q?OfN45mIeEGwReoHLHrbil/2xO0fL7yjozYDu13diUG8eW0xejj5Wz3n0Eyk0?=
 =?us-ascii?Q?dixNUXALT8bnArbbMbZCN503eaA3qIp4T4BmCYlDTwuB9c+Hz/xsCkZHiXU/?=
 =?us-ascii?Q?jSYFyyrpH+AD2Hh421JtgnpEvubhJ/dAPmoiZHUy6xbwKms8Ks+LnjFeePJz?=
 =?us-ascii?Q?0k4vCyKCVBZwh68ldb04L9t/NGDwClaikEb+Orxb7+e000tMhdZKOfpnQo0b?=
 =?us-ascii?Q?qZNb22dUjQZ8OVZYqLILqhTQMIMDYxJmM6jp/8QwCojACCrobvclsevabE9W?=
 =?us-ascii?Q?f29KVT/4IEvPqn87XSP5RQKQXUWs3h9MfNt0CBbP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f8f06c-b640-4e6e-2c53-08dce0f1e5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 01:47:52.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dy+V7wNv+mY8G0KTjENle4aJgK6ywL4V7J+qTHfO1ATfGouiS/MIFQuqVGiXXP7D+RjISUCJZMZq0FmyD7LNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6607



> -----Original Message-----
> From: Andrew Jeffery <andrew@codeconstruct.com.au>
> Sent: Monday, September 30, 2024 7:44 AM
> To: Patrick Williams <patrick@stwcx.xyz>; Delphine_CC_Chiu/WYHQ/Wiwynn
> <Delphine_CC_Chiu@wiwynn.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.or=
g>;
> Conor Dooley <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Ricky =
CX
> Wu <ricky.cx.wu.wiwynn@gmail.com>; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
> IOE on Spider Board
>=20
>  [External Sender]
>=20
>  [External Sender]
>=20
> Hi Ricky, Patrick,
>=20
> On Fri, 2024-09-27 at 22:33 -0400, Patrick Williams wrote:
> > On Fri, Sep 27, 2024 at 09:24:11AM +0000,
> Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> >
> > > Would like to ask should I base on the openbmc/linux repo to create
> > > the remaining patches that have context dependencies and add the
> > > lore link of the those patches that I've sent in the cover letter?
> >
> > I believe you're trying to get the patches applied onto the upstream
> > tree, so no you should not base on the openbmc/linux repo.  That repo
> > is a 6.6 branch.  You need to base the commits on torvalds/linux.
> >
>=20
> In my previous email[1] I requested:
>=20
> > Please assess the remaining yosemite4 devicetree patches (those you
> > haven't received a thank-you email for) and send an appropriately
> > constructed series so they can all be applied together, based on the
> > tree here:
> >
> > https://urldefense.com/v3/__https://github.com/amboar/linux/tree/for/b
> >
> mc/dt__;!!J63qqgXj!N56Dq0KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_Ozc
> SGVPC
> > SBOJk6u28AWPfgDRWsLE1B__-_ZNVKYv-zhc_6PY$
>=20
> So I'm not sure why there's confusion and speculation as to which tree sh=
ould
> be used :( Note that the for/bmc/dt branch above is currently based on
> v6.12-rc1.
>=20
> [1]:
> https://urldefense.com/v3/__https://lore.kernel.org/all/fbdc9efe87a1bed9f=
ea7
> d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au/__;!!J63qqgXj!N56Dq0
> KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_OzcSGVPCSBOJk6u28AWPfgDRW
> sLE1B__-_ZNVKYv-uNCc7qE$
>=20
> Anyway, I asked that because I have already applied one of the
> Yosemite4 patches there, and developing the remaining patches against any
> other tree will again cause conflicts (due to the lack of that patch).
>=20
> More broadly though, Patrick is right: If you're sending your patches ups=
tream,
> it is required that you develop and test your patches against an appropri=
ate
> upstream tree. Usually this is the most recent -rc1 tag, unless there are=
 reasons
> otherwise (such as conflicts). The OpenBMC kernel fork is not an appropri=
ate
> tree on which to base work you intend to send upstream.
>=20
> Thanks,
>=20
> Andrew

Hi Andrew,

Sorry for my misunderstanding.
So I should combine the remaining yosemite4 device tree patches as a single=
 serial based on torvalds/linux and test on openbmc/linux then send the ser=
ial patches to torvalds/linux.
And you will help to fix the conflicts when you apply the serial patches to=
 openbmc/linux.
Do I understand it correctly?

