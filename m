Return-Path: <linux-kernel+bounces-377697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134EB9AC278
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C33CB25E19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E8F189B8F;
	Wed, 23 Oct 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Ptjca2aY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E59170A2E;
	Wed, 23 Oct 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673954; cv=fail; b=IVf2MdlYM4sWLgtv4yXp2NDQ4fuQUl1m0t3fyuu5ltbrDRz4ug43ybjvS+60p/JgKyCjuMuCLP9dy1uQiGCunjr1B0uQqSxspmMyQKhiXFzAAw9vu8sZPidmbbtT+dG3zae3AaxY3wCGIici5/OwNpS2kFZnouTefOm+L8IBXY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673954; c=relaxed/simple;
	bh=FRD/mu10oJbhAkFeanXpcGiDQX4dXb77n1ypYxP4WGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6+RWa2R2V3a4qalHzcQ8dF3VzkENvfxweflJ9dYHE0DrEZ1K4LPfuPBellk2jXyEtmHz6AqjFLabaSK7DcuZuKlQ9O+AWP6zRtjNqQfxyo2s+3+8ZuIczuW/YaZoqdF5uDwU4A3tRF82ox6Ozkkbsa5a5Yuvq1RSfIOoHfD3Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Ptjca2aY; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOjCcxcv4sVpoxY76M3XGee7/geFaMj36LrrISER3nQ4Fi9MpIMWxtRnPE73NwXXbusXIdVHFJPurBc32wpBcmk/Lx7+Yep/lB1ZmdzDDZ/PJFH+LuMODOn7Iy0AkGFnqH+VVwTFBKBogKmUUMJSxpsVJi1B9b36NWNkIMhqjATgLhYPkShe/MfCPxcP9LdKjuTGcDAfldegla+Or/7DnhM608KVnzYoUJMaxqVpjPn7LD2b2YBYgBaJvH2vhW33wnFY5SO28781KF579NntUQ+PfzbV8yUAc/RQ1hngN043/69Mmj2La3yYGLIZ1M08hFwrbCsVuMYhVyCrEqlsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRD/mu10oJbhAkFeanXpcGiDQX4dXb77n1ypYxP4WGI=;
 b=GKn13+Cu9B1bMzRvKuO5cCxBS+Zlbsi/MEtr73EyWDyeUc5A19F2bZ5KmmjYG/zCWxjjK8ZB5lab1IK+Lk+z9mX0LzBdpFmy4uIaPftRZhsoBKUlttpZ2nys4h+oC9t7VQ1e6DEerMiIQMUgEShHVoPAodrBM/ZnDRTqCcnzAt3YaXa6oRd4bkAnR3UEzfSjnHXH9rwG04bT9oRImdBYnfKNs2l4Ezk3F/85r5/GUHyAbxmoD0jDTW3pu0HpMjFDTUDlj74+ngkE9ciNJZXDQbXhU6Hgo3ex7IN1XOvlupMtRo0ynC7zgwWEUdG1GpDQAygdm+8l+I91OjuVZX/o4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRD/mu10oJbhAkFeanXpcGiDQX4dXb77n1ypYxP4WGI=;
 b=Ptjca2aYnW/yS4Z1/vvnbZKedWv6L3LA4sWFQcYpzmEmx2gsa8bd48aFFZVEhPeszkPgPcYPrcU6EOtmO58D6wt0MbphlmOi5bAeJBV19VzDofRaf2inM3krAeplydfUTgG9xn3tdfhAjwOlEaK2OOa/3m4WB/MyJkPJyMyR1ZQ=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by PR3PR06MB7131.eurprd06.prod.outlook.com (2603:10a6:102:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 08:59:09 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 08:59:09 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "peng.fan@nxp.com"
	<peng.fan@nxp.com>, "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>, Sherry Sun
	<sherry.sun@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: add cpuidle state "cpu-pd-wait"
Thread-Topic: [PATCH] arm64: dts: imx8mp: add cpuidle state "cpu-pd-wait"
Thread-Index: AQHbGL8KifipXUsSOk2/fobsQXRO0bKUIiaA
Date: Wed, 23 Oct 2024 08:59:09 +0000
Message-ID: <44e997af-3275-4a4d-8d37-b8d313107d30@leica-geosystems.com>
References: <20241007134424.859467-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20241007134424.859467-1-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|PR3PR06MB7131:EE_
x-ms-office365-filtering-correlation-id: 88c0ef5a-a1f9-4859-b152-08dcf340f532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGFuSXM1OUkzNUxRUnJZaFJXMWswV05GaE1la3pPbzlWZGUyeHh5Lzh1VVc4?=
 =?utf-8?B?cENoaTF6QlNhZVZDVGNZM0VlUlJTY0REK240Nm4valhxdTJVNnFFell0ZERK?=
 =?utf-8?B?aGZjZzUwUnNJZWI2RWJVUFFSSitROXFLWWwrcWFyUDE1SGkyVy9NMVJFTm1q?=
 =?utf-8?B?bmR0cnIxV3plSjQ4RU9wYmU0MzFHcFF5d1paeExBWGFJMVJsWmNQbVJoMGpn?=
 =?utf-8?B?aEYrNXRoTGJCK20zL0dDYjY2Y2RzQ3VlSUlVNEtxWVpPMWJkdzlsVUZVNmhX?=
 =?utf-8?B?RWNzdlkwUHM5TjdBdVJWV1RlRHorUEVXVlRVVFBMVS9SUTAzRm0rSUU5S3ZT?=
 =?utf-8?B?QnNnZHF6UTdhc05nNnFHWDNuT0E3Zm01YWFsUUkyTXZJbDN4ZVVzNVVGdm1r?=
 =?utf-8?B?TStWd0E2cGxqNXZnN01KWW5pNEZzY3ZMRnFjeE81ekpkQUtpYnZnVG5zUlh2?=
 =?utf-8?B?TERkcmpodDhJVkM2ZHN4Y09sazNPWk1FSUcxVzg5WnNsY0d1cy81Qm1jNVU4?=
 =?utf-8?B?djA3MkxYZG5tYmdlMDVxL254V012VXFRMlNPTjYzcm56TlZwWHJLSDFiNjR4?=
 =?utf-8?B?WHVhbElhWTNnbVZpd2pRR2h3WWhpKytIZmZWRFMycE84a1VuM1FqMFRySzFy?=
 =?utf-8?B?eDdvK1Q1cEU2QmtiVzUwNHBLTUtVUllxbzdXN1pDSXh4V3hvaTNXRUR6OUxp?=
 =?utf-8?B?WitLWTlRYVFFOEUyVnZ4SVhLQmdDSlZFZHIvNlpYMUIvN3ljMWxpTFlwZnEv?=
 =?utf-8?B?ZS9pb2NTTnp2YzVEUzhneklQN0J2ZDhtVFNvTWRMZ1JmOVBDVkxCOWl6WkN5?=
 =?utf-8?B?dkpYTzAzZFZFNXkrcEpBMHRQL0EwR04vMEc1RXliWStpdzYwVW5MM3ErdWFa?=
 =?utf-8?B?Q0N4V3VxWmJSc09jQjJXRURJeHBQN09mb010d0tyQW0rRklmamM1NDZ3RG1N?=
 =?utf-8?B?K0dFWjUyN2RlKzRXeStQalNLR2V4dDFaZnZRM1ltNEQyNlNDbEFrTUtPMnNC?=
 =?utf-8?B?aDhndzUzYXJPNWxJVGx5S2pKOHRYU3JFT2lOajV3b2NzaU1hb1Z1U0I1Y2Ro?=
 =?utf-8?B?Wno0NnVWSnVtcnFmdmJ5bTlPNjJBRS9EQ056NktjeExpTXA3aHdodHdpZ0pz?=
 =?utf-8?B?czgwWkZ0d0RoNDlDSWc5aDhTL0JtRzZXZXU3NUVEOFU1YnJnV0x6eE16K0J0?=
 =?utf-8?B?QmVqTWQram4xRjFocWpwczY1S1dBa3llWjN6dlM1Uktzd3BZaWQxWTk1QzRn?=
 =?utf-8?B?RlF2ZkVtVkRiamRzeTBUUmNldFVHa0pPaytQa2ZvSy8yeDJwdzJCanNyVWVx?=
 =?utf-8?B?TG5nY0ZZeW1PUWRrbjZQZThpQm9oMVp5ejFQSVYvSFlxU3RXQ3V4ZnZLcUhM?=
 =?utf-8?B?VHN2cm40ZGN4NExjT1dpOFpLdmw1eGNleUtKRStBSi9IT05WUGIzWW5WUWEx?=
 =?utf-8?B?eUhDQ3BDeHdES2hkcmI2TDdJQ1BDeVBZUVZiNGhmYTB6eW5YU2JpSmpyOGt1?=
 =?utf-8?B?YmFNbHlIdkFvMGFVUlpTTHA3T0N5dmpWczRJQWZxNDRnWDBhVThHTnFhSWsz?=
 =?utf-8?B?TUpWd1ZKbnZ1Zy8vN1cyQWZoSVJ6bkFXOERsMnhIREVYdWlQOVFnNzR4d0VQ?=
 =?utf-8?B?VkNzR3BHNVZ2SmhManQ2UVhNc1VrYWVuaUZtSW1KL2NjeWd4dkVPbHJyR3VV?=
 =?utf-8?B?SisyNmswcFgrYXFkd0V5cDh2bWxkQXA3cDY0clVUYVBzUWRIRDZXY2crL2Qw?=
 =?utf-8?B?UXl5OVllTnRqdEpXMTFOd0IyNGYyTHE0eUlyd1hadWJmSzVKblhKU21EQjhG?=
 =?utf-8?B?SHNIU3E4U3Z4em94MWRpS3Z1djg2VVI0ZnpDcTlSK1RoRDNHWmEyUFpZdE51?=
 =?utf-8?Q?bEaOuG7mJX0zH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnZXQmlmb3VMbVEvUnk1ekVwUlROcE9ob0tGRVE1eGIya0xhemdjWmhTaEpq?=
 =?utf-8?B?dnpOdWxLQWh2MUxFaTd0MmJmeElIYjVodnNudzJiUVNpb2gwN0FJUEpCc3oz?=
 =?utf-8?B?dDBVdjRVZjZVeWc1WjVBT1BDZjNlY0Z1Yko5ZDBoNUVTemMvTDJOQTBIN2x2?=
 =?utf-8?B?U2FmWlo1SW9hU0Jwa0tWOGNZVFQ5eis4YzJUT1N3Z1ZTL0lUWjl2SThDdXAw?=
 =?utf-8?B?Z3pobDhuNWRIeXZ5ZTRqVFMydDYwUjdVNldBRXpyb2dweDdLZFV1UmVSYXRm?=
 =?utf-8?B?NnNhcVJQWUJPM0FhNXlyZHo0a1NEUjg4ZFFHLy96aDdEaVlSNkpCa1VyNjhW?=
 =?utf-8?B?QytjTlM2alBDOGtyR3IwY0pENC9rYUZ3M1RVM09hY2NNdkZjYnA0aFVaZWtG?=
 =?utf-8?B?SWVJdzZOa3g4WjZjWXRhMDM0SlkzRllIb2p1K0ZzemRNVCtORHFiZTBDbnNy?=
 =?utf-8?B?ZUFNVS9oSmlqckFVcXYyNlAwSUsrdnNjekRTQlpjU2VCNTFRWWprdDRKMmFx?=
 =?utf-8?B?L1RXWTZCTitYd2xIOG5uUE5vQmlJL01DMkZuMEZUYnNIdDNjcStlVks4eFVZ?=
 =?utf-8?B?SkJtSkQrcEFsZnFkMHdXcS83SGU3YUVYeFBFdnJ4OUtBMXZxMVl3NGR4dXp1?=
 =?utf-8?B?WUh6WVVXY0gwblE5Rzg4bld3cm5ydC8xNnhRazNFalh0Q1hIUTkvTU9CbFpB?=
 =?utf-8?B?NW5YU25ESDBXdUh2R0RIUGZ6b0ZlU2ZXWVNVWXNrTVhrbFg0MmhQRE8zTktn?=
 =?utf-8?B?WDRjd25RYVJtK1diMUw1aXJKWDlOVnFkWGlaMFpPMTlIaE1aV1F3S3YxRlIy?=
 =?utf-8?B?dDZ1bHpoWGQ4eVNWYU9rT0xYQ1ZUb3V3VnZZdzlNTFJEa3MrYnRCbW1wbURr?=
 =?utf-8?B?L0FVMUlTcXYwekxIbHlpRnlTb1E5N3pLT0xUU1FKa01sWU5STiswSzFMY2Vy?=
 =?utf-8?B?empMYzcvNEVaenVITUt0RWVTTFZTUGdFS3ZFTjQwd2RKWi9NdkxGbWxjbndV?=
 =?utf-8?B?L2NFbFQwWUNLYVhYejZySkJZQm1rSFRNTEJtcGY1cjFXcStjWHVuWi94eDho?=
 =?utf-8?B?N0gzTmVWelFkRU1Oc0E0Rmk5cGFGNExDQ3U1d0JmUVJRdVhNTnRpVXVXTFBh?=
 =?utf-8?B?Z0E5WlJ5UlN5WGdkM3IybjRCVnNQblhOaUpPay9FZTZYQS95K3lOOS9oaVZ1?=
 =?utf-8?B?YlpvTGdPYyttY1p4MDFlS1lzOXJzQjhRVUJtMkZwdDhmR0dTQlBZRVlCdXVy?=
 =?utf-8?B?YzRtVWpHdlkrK0dIem5hVE16Z3dxTjNobWt5SGx3a0VWeWtBaEhjRTNFYnRh?=
 =?utf-8?B?c2tFcEhoQkpCdXVkWk5mOGl2UWYwdUFsUGFIVFBhU3pIcUVuSWorSlp6ZnNi?=
 =?utf-8?B?M213ZEY3UEQ1a2syamZ4aHdnS2l6REVrNEdzMm9EcXhNb29tLys3amUwMjRh?=
 =?utf-8?B?NGNXZnU5UlRhVTlCVUxEK01pcTQ4OXVTYTFKa2k2K3FTdCsxczF1bU1rSEJW?=
 =?utf-8?B?S1ZLR0MrV2VPRVhydUpjeDIzazJtamtTRFBpZkYyUXlZTE55dHoxYjFDT1FM?=
 =?utf-8?B?cXE4aDZlY3BaaGVKYVF1Uy9GcDAzV01ML0lldEsxK1pCNUdyU2M3NW5NOGJC?=
 =?utf-8?B?d1BDcEFyR3lsRUlzcXdZNXNRTFV2Q2dtRDhYQWZvM3ZraElwZTYwYnEzblhr?=
 =?utf-8?B?RVYyWGxuUmRHRHJnU095UnhaYnJ0QlpTUWpFclFKQkhBMkhnTjc3TFluMWxl?=
 =?utf-8?B?SkZ0VVU0czAzUm9uLzJZeXphcWNvelRwRDBmM2hQYzI2T01DeUZGMG42eTBZ?=
 =?utf-8?B?Q29kOEFTckhxMWJjWXgwWGx0cEU1Vkg1WWNtaldUc2xCNFdsa0NETXdOZTdl?=
 =?utf-8?B?TFZJYVVmd3RBaXdlNnR6ODV5Qm0wZEF2WkdqbEZvT1ZkYW1qWnQ4ZDBsZ0hB?=
 =?utf-8?B?QldMeDdUOCtRWExudkU0UVJVSUU0M1NLNitRYzlzWmk3V2tseEpLakFLY1Iy?=
 =?utf-8?B?K0gvV3ppczM0UXJ2OHRrME1LRjhsQjVna3lPdkZsak5EMW5TS29OQ0tqWDRN?=
 =?utf-8?B?UjEzMGFhcEw2QzNiMkV3V2FwUDdKODFRZDNGS24weFYzQjc1aml2UTFkbHBK?=
 =?utf-8?B?b1ZvNkVtWnB5U2RUSjBRRnFXcEhuaDR5K1BQNGNjaDl3UmhLRnMvcWdvc2Uz?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B71CC8CC22B9459A7606325DF367C0@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c0ef5a-a1f9-4859-b152-08dcf340f532
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 08:59:09.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VDVynaOQefa1u1Nuzf4cueS2QBid3vdG+p2s3ksLKVhGmnuoWnOP7TpOOOs7Os1IbFZ343RAXKzl5+QZF+mCDazduArd+ORdpzFlEy0ypec8ixCvJOBCeZMCaFery7F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7131

QWRkaW5nIG1vcmUgcGVvcGxlLg0KDQpPbiAwNy8xMC8yMDI0IDE1OjQ0LCBDYXRhbGluIFBvcGVz
Y3Ugd3JvdGU6DQo+IFNvIGZhciwgb25seSBXRkkgaXMgc3VwcG9ydGVkIG9uIGkuTVg4bXAgcGxh
dGZvcm0uIEFkZCBzdXBwb3J0IGZvcg0KPiBkZWVwZXIgY3B1aWRsZSBzdGF0ZSAiY3B1LXBkLXdh
aXQiIHRoYXQgd291bGQgYWxsb3cgZm9yIGJldHRlciBwb3dlcg0KPiB1c2FnZSBkdXJpbmcgcnVu
dGltZS4gVGhpcyBpcyBhIHBvcnQgZnJvbSBOWFAgZG93bnN0cmVhbSBrZXJuZWwuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IENhdGFsaW4gUG9wZXNjdSA8Y2F0YWxpbi5wb3Blc2N1QGxlaWNhLWdlb3N5
c3RlbXMuY29tPg0KPiAtLS0NCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXAuZHRzaSB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5k
dHNpDQo+IGluZGV4IGYzNTMxY2ZiMGQ3OS4uOGIxZTBjYTI0OGQxIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiBAQCAtNDcsNiArNDcsMjAgQEAg
Y3B1cyB7DQo+ICAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gICAJCSNzaXplLWNlbGxzID0g
PDA+Ow0KPiAgIA0KPiArCQlpZGxlLXN0YXRlcyB7DQo+ICsJCQllbnRyeS1tZXRob2QgPSAicHNj
aSI7DQo+ICsNCj4gKwkJCWNwdV9wZF93YWl0OiBjcHUtcGQtd2FpdCB7DQo+ICsJCQkJY29tcGF0
aWJsZSA9ICJhcm0saWRsZS1zdGF0ZSI7DQo+ICsJCQkJYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9
IDwweDAwMTAwMzM+Ow0KPiArCQkJCWxvY2FsLXRpbWVyLXN0b3A7DQo+ICsJCQkJZW50cnktbGF0
ZW5jeS11cyA9IDwxMDAwPjsNCj4gKwkJCQlleGl0LWxhdGVuY3ktdXMgPSA8NzAwPjsNCj4gKwkJ
CQltaW4tcmVzaWRlbmN5LXVzID0gPDI3MDA+Ow0KPiArCQkJCXdha2V1cC1sYXRlbmN5LXVzID0g
PDE1MDA+Ow0KPiArCQkJfTsNCj4gKwkJfTsNCj4gKw0KPiAgIAkJQTUzXzA6IGNwdUAwIHsNCj4g
ICAJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOw0KPiAgIAkJCWNvbXBhdGlibGUgPSAiYXJtLGNvcnRl
eC1hNTMiOw0KPiBAQCAtNjUsNiArNzksNyBAQCBBNTNfMDogY3B1QDAgew0KPiAgIAkJCW52bWVt
LWNlbGwtbmFtZXMgPSAic3BlZWRfZ3JhZGUiOw0KPiAgIAkJCW9wZXJhdGluZy1wb2ludHMtdjIg
PSA8JmE1M19vcHBfdGFibGU+Ow0KPiAgIAkJCSNjb29saW5nLWNlbGxzID0gPDI+Ow0KPiArCQkJ
Y3B1LWlkbGUtc3RhdGVzID0gPCZjcHVfcGRfd2FpdD47DQo+ICAgCQl9Ow0KPiAgIA0KPiAgIAkJ
QTUzXzE6IGNwdUAxIHsNCj4gQEAgLTgzLDYgKzk4LDcgQEAgQTUzXzE6IGNwdUAxIHsNCj4gICAJ
CQluZXh0LWxldmVsLWNhY2hlID0gPCZBNTNfTDI+Ow0KPiAgIAkJCW9wZXJhdGluZy1wb2ludHMt
djIgPSA8JmE1M19vcHBfdGFibGU+Ow0KPiAgIAkJCSNjb29saW5nLWNlbGxzID0gPDI+Ow0KPiAr
CQkJY3B1LWlkbGUtc3RhdGVzID0gPCZjcHVfcGRfd2FpdD47DQo+ICAgCQl9Ow0KPiAgIA0KPiAg
IAkJQTUzXzI6IGNwdUAyIHsNCj4gQEAgLTEwMSw2ICsxMTcsNyBAQCBBNTNfMjogY3B1QDIgew0K
PiAgIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkE1M19MMj47DQo+ICAgCQkJb3BlcmF0aW5nLXBv
aW50cy12MiA9IDwmYTUzX29wcF90YWJsZT47DQo+ICAgCQkJI2Nvb2xpbmctY2VsbHMgPSA8Mj47
DQo+ICsJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JmNwdV9wZF93YWl0PjsNCj4gICAJCX07DQo+ICAg
DQo+ICAgCQlBNTNfMzogY3B1QDMgew0KPiBAQCAtMTE5LDYgKzEzNiw3IEBAIEE1M18zOiBjcHVA
MyB7DQo+ICAgCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTUzX0wyPjsNCj4gICAJCQlvcGVyYXRp
bmctcG9pbnRzLXYyID0gPCZhNTNfb3BwX3RhYmxlPjsNCj4gICAJCQkjY29vbGluZy1jZWxscyA9
IDwyPjsNCj4gKwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmY3B1X3BkX3dhaXQ+Ow0KPiAgIAkJfTsN
Cj4gICANCj4gICAJCUE1M19MMjogbDItY2FjaGUwIHsNCj4NCj4gYmFzZS1jb21taXQ6IDU4Y2E2
MWMxYTg2NmJmZGFhNWUxOWZiMTlhMjQxNjc2NGY4NDdkNzUNCj4gcHJlcmVxdWlzaXRlLXBhdGNo
LWlkOiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwDQoNCg0K

