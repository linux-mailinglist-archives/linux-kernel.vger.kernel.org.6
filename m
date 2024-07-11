Return-Path: <linux-kernel+bounces-249288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013992E97A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2E02851A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FD15ECE8;
	Thu, 11 Jul 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QcmIpz7m"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0915E5A6;
	Thu, 11 Jul 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704381; cv=fail; b=RNdUUq66hzpYx8h+0gkLeeQypS40V272k0+uiNlnbLpNwrXeXxR7T5gsmvV5kiW0Wd7H7o2wWj2jve2E/OhIOIGEHg1pkvA/gq9JNx3JOHA9XQ596QfxdLpbVHRUTJXe/V7JyfsdvIfw6VbBK2A/Zv4oHygMwBqS4PGPjblkmEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704381; c=relaxed/simple;
	bh=jk6hc52vC2znN6+K+ypKWzpFtj6kFuDxK7Alb5+9VFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jK9ecrXJYgRZisj9eJImBvCayT2xmK6bgcfbPyQNMPnOyqBnngUNw1LFUreVjk3nzm0e76+BFQo+dSsjrbyAF9Otxps8nQQOf7jSlDv/CfB7sD1CF0qe405xUF7thElt9FJXBS8eBW9+6GHxkuHcWFhoAms33xunU3CDNyq1twU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QcmIpz7m; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SF2XyOVKk3HLaV9jCSJQKYqTL/jb/UpS7jQINU4/AASl8mQKYx7rPYwCdm7bnlwpLUapmVfBzHiwdjHAC3kQAZbJT/lQcZeHPi5JwUNBp5BQITELIsb0RMbtw1Il4NPDiCYxw+XdQb3suuQDT0ChPHVf+gUXF/TxGxY0TV/AkZ5pKjLkHOAl1kW36oNhak+NlJ+5L4wl3D5nm8+zu9SeuTes+9abIjKPOPuVrEXW42gF4pLrTGffvIdoRC/Mv4/hDouX7sUFZkLPtQij5isqnLs4eqNnPAPd7qEuEe3yNCK686prmc042rQmFmIpjY3KLLeiD6qhR8DA1pFl1oi3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moYjzjQVf+1TDV4fhEmopusB232+Md9sI8XiP6TE854=;
 b=F7rHBoqgy/j3L2BXK5dJwcs2lGEeIXm16WJaf0rDRT++gV7w+oCRXen34l8xYtVEiuwOkIWtlX0x0zIhDHxHiVYTSpIXZ6JORt4iVj0BebpiSbPFQXthyftRZ0HBp2n8rkpACc/Xe63FGUIYt3hIxhmHsNPu8ElthVH21pwbw61mFYkYHv9xneBd5aJdqMhsNiD4Ey5HzpZPpDy6oGX0+FOXWbsLPZTZYvkTp8j8xn2hBBQpTQXuTLdtfUGyF20MHJVKhO3CpuFwN4cDKpmk+ZwJcRm2wKp6CwfXBBVjaH9Jd73niWQJhp3nFE4AiFni0ggXj/vcFAlqHd36RP4yhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moYjzjQVf+1TDV4fhEmopusB232+Md9sI8XiP6TE854=;
 b=QcmIpz7mSVrmbfeDnhWKgxFPY9ERTg9jcVGK3zo7+mxTUpBNsHHPW5hDDAgaCk0Ht7UUbxOHqYAslij8GhDGHdapwQMD74cKSVTMF7eSkpLpN6vWEC1Erk7avNVDMstBkhFR4y6LzlE4shzfQq2+0pCV2UOWKWQiTBNozruzaTY=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10602.eurprd04.prod.outlook.com (2603:10a6:102:490::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.37; Thu, 11 Jul
 2024 13:26:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 13:26:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "etienne.carriere@st.com"
	<etienne.carriere@st.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>, "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: RE: [PATCH 0/8] Make SCMI transport as standalone drivers
Thread-Topic: [PATCH 0/8] Make SCMI transport as standalone drivers
Thread-Index: AQHa0u8g8MjHaM5G70mfkg+pmzM66rHxhbDA
Date: Thu, 11 Jul 2024 13:26:16 +0000
Message-ID:
 <PAXPR04MB84592E272D5C16813529815588A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-1-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10602:EE_
x-ms-office365-filtering-correlation-id: df273b35-eba6-48ce-71c5-08dca1ad0b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lkk/jo5ER/h3qZQjuq3XVJtWHh2rM9dj2Q9bPYb+xMzNbSZFNJJ4LeC00N0u?=
 =?us-ascii?Q?BI6ze/xnASJKnM3JteluAy8drBmwUgmqR93F7HMr2wNoIcdidh7flxfrEaR3?=
 =?us-ascii?Q?Sd3LZbH6uATkKDeYfyWNc1W95//p1lq7NPwGyqt1RoGKO0LVeEcV+iLyTH0j?=
 =?us-ascii?Q?2SVecnpLNNeXWhK7+1Msl4X9DzQv7TP3Liq4BgZ2rytB8LQZl/m4uG+HzeYp?=
 =?us-ascii?Q?f/VJWh6hNvx+BMvQixz00CqKJjxwo2QrOF6UuCKlwCYod80AhC2I+BRpDr12?=
 =?us-ascii?Q?UhODMD0Ynlgbm3ErqfJbe28jbIJv/bJ9v9QdbJBAye9SbepoxZFe5xbGhFLa?=
 =?us-ascii?Q?dTnVNvzJQQMsqEFA8D8hVssAtHj5U1QxtfnogdkIHIUzXrG3YG8dNYvXtSlF?=
 =?us-ascii?Q?Q6LuEX+GnNI88A264LHseDQVLgvUddkv1TfUVYHAAq65oYsE5gBmaNGwMMfj?=
 =?us-ascii?Q?G9cUI7VEwIqxOagHcTsWfe46T4+Cs0c8JZLS/z8XgVJlwCT35SHYzjtO7Kb1?=
 =?us-ascii?Q?mEpAmAOc2LRWUB+EzPIQebC3Ud1ifFdcCKVg0oNwRoCQCim4X/x/TnCd7r8I?=
 =?us-ascii?Q?81V2OVs8csToxb4qseN7mhVMzluobXl2uXJJAKOcjQ7lvERLHeHNmpt0LkQu?=
 =?us-ascii?Q?MynkGU8A+W2ChwFaWAFqqOLedpHLRs/GT1TgNgqvNEd6J2rteLC6brCw84cU?=
 =?us-ascii?Q?PJOJ527U7JYlalPByvHo6T3Z4Tbbre2RyGDWz4fk1hyS47+C+or6kBLAqZZC?=
 =?us-ascii?Q?naGJcBiGKTlYrVAPkvGYS/4BowsJeiynh5UD1ReEB6a1qblrxKz76IVqUW7S?=
 =?us-ascii?Q?X4tYmwCLbVOpqEwTMG/2HI6O6MulzaHX0zI8X1WL9kgDw6lvHKQJJduy7UwF?=
 =?us-ascii?Q?UW2jtL3bOLXHJihB0InDuca7WgGlmPXfleSoWfLSTM7UP/hjSpeflTB0mHJG?=
 =?us-ascii?Q?W9uCck1aZq2uZc5fEUGPNFXeEy6lVwTbcFnBAyPNrp02/Vh+/MhnENBn17xE?=
 =?us-ascii?Q?wPk8WZmLF+sZ6xXz4zljBjrLohvyCdWGr0eHGIjItibFWVRGjEj3oCkxgC1B?=
 =?us-ascii?Q?A2lJ1lVbqUKx5pXsXLGDL3tkF5lkP6TmYf5ykTSZwjcqmgZfgRf8iPOl1vl7?=
 =?us-ascii?Q?tts8pHhJgwtk10391pdlFkpepUvDuAB82lVO6XmZwn/MS2WFVIeM0lFfEcL9?=
 =?us-ascii?Q?MXfZqCt7m2ZHs51lgMjoPq59doVvoyciyxwYGCyp4wyKcKlNID1HuK0ycH7L?=
 =?us-ascii?Q?oEDKFi8dhD0ISIXi7eiD02eHdPETFUXySj4H6TAM1woa0eLimQzkiVigdoot?=
 =?us-ascii?Q?7wZsDDZ2uWEWXG2legP5NXhZ0GAwGPnTirBGKRvyT7JOl7U4Bi0yprkzNCCv?=
 =?us-ascii?Q?yJBoZkLpje7+yTH8tbJjL+HegHmtDfmwaVwLM6Nv05xlZO0qsQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MS38JgmkoZZQ+PTesr6uFFT8hWzz0Vv5S4QmecOgw2aA0B5ng/i+wMAMRQQZ?=
 =?us-ascii?Q?7KANLot8C83bH4zvwTMIAWH2DMKLMBi9vIf+Vu6lMLKRJwsziiGAvmOL6Wne?=
 =?us-ascii?Q?Txc/z/y9pZam4wMlkv4mp2hxzhnfQNpXUbHTytWA+AL/R30APobE2l/YSNNs?=
 =?us-ascii?Q?NY2z+MrAWliW4xg9O8CEvHCW843pmHpMouiJWMjwPsJ1lm0TbHT/jsHZiksX?=
 =?us-ascii?Q?iknwNa3UyS+EeMO2Sp61PTabvw+k5/HGWauN3oLDIuj2QZCi1erR9kBbhlu0?=
 =?us-ascii?Q?nIlIaT5dGNrEt7f4F1DMg2JW3FWGPY5tXLOdGPMu3DTksN2ArnlyIBNR8HAE?=
 =?us-ascii?Q?TiwEJ/ftpBu1LjapmaZDpxXqN3tyGnG+hVZsIlYekzDqgNeNGLhHjHJXIJhz?=
 =?us-ascii?Q?DmXnKKQFKRwBJLdfvy8jrIph4xPS29g9fBH9EJhKgsZOqwxdfa1juxvPVMXZ?=
 =?us-ascii?Q?v4EExBNEKvY/l0iiansJTPoovR3OCUnDyU6DGYNdOpvx2OlBXXLAcBI16Qek?=
 =?us-ascii?Q?JIkwUEhA3A0fORoNzyyr9GgjDUAZvEblGp6nlmNOJpwORdCAzfxN/9jHENxN?=
 =?us-ascii?Q?5boFzI1G+59n4Om8FM4VSP5Yd/u4KOJBu9TxyhJuFYLl3weJ1XTP/m92V5/d?=
 =?us-ascii?Q?qaQRjavvl7DuLLlkW68X6f3dyhQVVZ67h0lTx5JL49qqqIbBEdY2pt4pMtAw?=
 =?us-ascii?Q?imlqnP7R2Y8k/N7iG1bPDv4YSkU4ppDd008Qj9cgzceJghcF2dNIBn7WIJCC?=
 =?us-ascii?Q?sSzxIoZ9RfgugwTE9fxoNEKgqUsbl9hWA/kLBK5mH8Qooiotk1HIESp5Im9p?=
 =?us-ascii?Q?JIj6LrMuAO04vw4D631JT2RrR4gCKNepBBVbiZAP9bRcUlOIX0gLLMA9uKdP?=
 =?us-ascii?Q?17ZJ8zuQdbope9XUxdcJ9Ly5bEOxI57lBna6XuJpsaSrs/czX+kg8RFGsCMt?=
 =?us-ascii?Q?2aQWLzasJ+Rt+H14aTn8SfBs3j7XDT/MXUfA/zkJ2jpTuJ/5iSM3oioGCOCY?=
 =?us-ascii?Q?cxstCS8bggZiATInZPNvkn/xTMkWqwNIUhu9KXaG2yzxNrgUex4Em4izhWdV?=
 =?us-ascii?Q?nULgDYDsSgPiRc6x4UlYsx7m+edhrZpiBnj+M9pNGGolT6mcv3P9t8P7BKQi?=
 =?us-ascii?Q?QtXHF8BqaIjEWpr16+NXEfMHKEoktSd/zPBAXN5PonPlebjTEH7hC+ZR4tKZ?=
 =?us-ascii?Q?hWcSa0cKLU+adStgZ67p0mXOzLQl+BjAWmHzGJfa2Fly+DnBvi380g/rMNwk?=
 =?us-ascii?Q?MxmmoczdJlb691fsOTsjG1yG+iQY41rWieKVL1vTxkjWxLkmhwTYRI5AA6Wq?=
 =?us-ascii?Q?JYvvQHwhdo1RD7ZHwlsXqCAoePF2pcW+LdeU3adE8oW/moWdbXOQKJIs2eHH?=
 =?us-ascii?Q?7JfA+C7gMxKJY+pCsihQMNN71BCaxvy2ePwjwn9vlNCNtkaC5M3sy7TYzDqj?=
 =?us-ascii?Q?v9rnKrq0vfihAioUEqrTjwaxwUyZ1rG0c/TLlYg3DYCDhreDvI9/RAPTy9xH?=
 =?us-ascii?Q?KLc9/twqqal3g9Rk8sx1AwY430kqI0qbVksjXwRlnO6KvtJKQOCXuuZErng5?=
 =?us-ascii?Q?BpVn58iBFyWO+t3pYnw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df273b35-eba6-48ce-71c5-08dca1ad0b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 13:26:16.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h0XcUfapHgz1AsHWifWUwmm/23QDWrLbKiHMpfwVPhdg+buW7MQLcb+DD91M8p1nNDrQiDQEg6wfLhrVsv2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10602

> Subject: [PATCH 0/8] Make SCMI transport as standalone drivers

You may need use V2 here :)
>=20
> Hi all,
>=20
> Till now the SCMI transport layer was being built embedded into in the
> core SCMI stack.
>=20
> Some of these transports, despite being currently part of the main
> SCMI module, are indeed also registered with different subsystems like
> optee or virtio, and actively probed also by those: this led to a few
> awkward and convoluted tricks to properly handle such interactions at
> boot time in the SCMI stack.
>=20
> Moreover some partner expressed the desire to be able to fully
> modularize the transports components.
>=20
> This series aim to make all such transports as standalone drivers that
> can be optionally loaded as modules.
>=20
> In order to do this, at first some new mechanism is introduced to
> support this new capability while maintaining, in parallel, the old
> legacy embedded transports; then each transport, one by one, is
> transitioned to be a standalone driver and finally the old legacy
> support for embedded transport is removed.
>=20
> Patch [1/8] is a mostly unrelated (but much needed) clean-up from
> Peng, which I included in this series to avoid conflicts at merge.
>=20
> Patch [2/8] simply collects the existing datagram manipulation helpers
> in a pair of function pointers structures, in preparation for later rewor=
ks.
>=20
> Patch [3/8] adds the bulk of the new logic to the core SCMI stack and
> then each existing transport is transitioned to be a standalone driver in
> patches 4,5,6,7 while shuffling around the compatibles. (no DT change
> is needed of curse for backward compatibility) While doing this I kept
> the module authorship in line with the main
> author(S) as spitted out by git-blame.
>=20
> Finally patch [8/8] removes all the legacy dead code from the core
> SCMI stack.
>=20
> No new symbol EXPORT has been added.
>=20
> The new transport drivers have been tested, as built-in and LKM, as
> follows:
>=20
> - mailbox on JUNO
> - virtio on emulation
> - optee on QEMU/optee using Linaro setup
>=20
> Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> testing commands, replies, delayed responses and notification.
>=20
> Multiple virtual SCMI instances support has been tested too.
>=20
> SMC has NOT been tested/exercised at run-time, only compile-tested.
> (due to lack of hardware)
>=20
> Note that in this new setup, all the probe deferral and retries between
> the SCMI core stack and the transports has been removed, since no
> more needed.
>=20
> Moreover the new drivers have been tested also with a fully
> modularized SCMI stack, i.e.:
>=20
>   scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor
> modules ]
>=20
> ToBeDone:
>  - completely remove any dependency at build time at the Kconfig level
> between
>    the SCMI core and the transport drivers: so that the transports will b=
e
>    dependent only on the related subsystems (optee/virtio/mailbox/smc)
>    (easy to be done but maybe it is not worth...)
>  - integrate per-platform transport configuration capabilities
>    (max_rx_timeout_ms & friends..)
>=20
> Based on sudeep/for-next/scmi/updates.
>=20
> Any feedback, and especially testing (:D) is welcome.
>=20

For the v2 patchset:
Tested-by: Peng Fan <peng.fan@nxp.com>  #i.MX95-19x19-EVK

Regards,
Peng.

> Thanks,
> Cristian
>=20
> ---
> v1 --> v2
> - fixed setup_shmem_iomap to address also SMC needs (QC/nikunj)
>   (silencing also warnings by kernel test robot <lkp@intel.com>)
> - using __free OF cleanup.h magic in setup_shmme_iomap
> - properly handle platform_driver_register() failures (Dan)
> - fixed a few commit message style
> - added a few missing static in scmi_desc
>   (addresses warnings by kernel test robot <lkp@intel.com>)
>=20
> Cristian Marussi (7):
>   firmware: arm_scmi: Introduce packet handling helpers
>   firmware: arm_scmi: Add support for standalone transport drivers
>   firmware: arm_scmi: Make MBOX transport a standalone driver
>   firmware: arm_scmi: Make SMC transport a standalone driver
>   firmware: arm_scmi: Make OPTEE transport a standalone driver
>   firmware: arm_scmi: Make VirtIO transport a standalone driver
>   firmware: arm_scmi: Remove legacy transport-layer code
>=20
> Peng Fan (1):
>   firmware: arm_scmi: Introduce setup_shmem_iomap
>=20
>  drivers/firmware/arm_scmi/Kconfig             |  20 +-
>  drivers/firmware/arm_scmi/Makefile            |   9 +-
>  drivers/firmware/arm_scmi/common.h            | 184 +++++++++++++----
> -
>  drivers/firmware/arm_scmi/driver.c            | 140 +++++--------
>  drivers/firmware/arm_scmi/msg.c               |  34 +++-
>  .../{mailbox.c =3D> scmi_transport_mailbox.c}   |  69 ++++---
>  .../{optee.c =3D> scmi_transport_optee.c}       | 124 +++++-------
>  .../arm_scmi/{smc.c =3D> scmi_transport_smc.c}  |  58 +++---
>  .../{virtio.c =3D> scmi_transport_virtio.c}     | 103 +++++-----
>  drivers/firmware/arm_scmi/shmem.c             |  85 ++++++--
>  10 files changed, 468 insertions(+), 358 deletions(-)  rename
> drivers/firmware/arm_scmi/{mailbox.c =3D> scmi_transport_mailbox.c}
> (87%)  rename drivers/firmware/arm_scmi/{optee.c =3D>
> scmi_transport_optee.c} (89%)  rename
> drivers/firmware/arm_scmi/{smc.c =3D> scmi_transport_smc.c} (87%)
> rename drivers/firmware/arm_scmi/{virtio.c =3D> scmi_transport_virtio.c}
> (94%)
>=20
> --
> 2.45.2
>=20


