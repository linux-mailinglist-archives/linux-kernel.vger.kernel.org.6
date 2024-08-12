Return-Path: <linux-kernel+bounces-282791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C6694E8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684BA1F24601
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5016B3B7;
	Mon, 12 Aug 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nFYqhxqS"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272F4D599
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451600; cv=fail; b=EDUxnpRFW89rezHj5sbjCL+3AnYpC0dKAxWAmKVP+9TbnxIcHzvDgHVWm26KhBNruNVuYwP5PWzYgQ65vjfee0RYwUjFroPIez6Pxa+E7GTBMsBiE/6SoRUGHhUpzJMS7DS42bHyPMjlUBTGm57hvg6MM0KnKByHuJZguRlagvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451600; c=relaxed/simple;
	bh=WfE7JncrAXkztA0yFy66xk2L/76RaLXypmpcApN6bHY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mo5VM7Af4Aj2Jsih45PgZH+P8vOpNZbI4SxwwjR4ufS3d9axqUaSGfCSnTEYUUx9nOsIfxeBzjuviYWYraIeQ94aBmycsRTOhIUqsIhurkzj9oqoIOD3YXIMrQI+NgJgycQ/Cgy4D0O+KLIsOBZMwIjypxsl3ZieYnz2BGh2MpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nFYqhxqS; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUolksXz/AndPGrhdV6030K3xBnXcLaSuMsyGM0Wq4gOQfryIq++V8ZuArk5klexG+qwvyjFfZ3oDQadCLooqWgrvORL31twav5suyFSNsO8gG4Btytq/9XMqMXYCfBm71QEktlcmAvpJnvq5N8vZgU0BmwO6RFs7Nliky8zQ9Mt0J2bNTl3aHChUK3dKamnnC5w0H+BQAMhvQ9vTaqJn2odgK+q9fhLasXm+F+pDOwNU7CWwmHRspWiRyrzfkPOkgvhoQKYh52Kbzsy7AayWT3yEWyCwqARFbvy8kt6aqaglWH4ZhRSOXkQ7Jk7KIjjJ6FS4AHPedSXJxPBp6+57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytd5RYe4/JpuUtV6B3nLJ1KwuswURu1DjGqANM8PL44=;
 b=TfNKOvCX3AsRIOYC83QUrb066XZCLbbhhWOEI+3uVTmZjpZuOcd0DN0w3gQDIjbveyycyWIa7yhE81OL2wqZkULVQUG0JgffEakAinh90LhzQmJA0QY58ucNb6m+P6IvCnoz9k7m8whnPTkmNlvkkJvmHnH0SoZVX+SmbeBOpY+LzaU1iCQQ2c1zmaS5cb/mHQS0QrQSh6jPhGJYUTZM1gavhfppIb0ZsnAhqFbwFtPFQ6BaTOMvnMR5BnlFK3psNM3UBnfQhOISoCF6fjT2OlR3OQxWlYi+T+H9C3F1LPZvCwp8KGMO9v0b08WvBUXAcWhrl0KFDBh31cUxCAr5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytd5RYe4/JpuUtV6B3nLJ1KwuswURu1DjGqANM8PL44=;
 b=nFYqhxqSSvp128HT4y9e3z4TQFhZa3oexlb+vP/nRDOjZa3gtoU59lEUCeNgcLL+Pqqk8rTSkNDWzyqQTTL5pALuSATn7Reu3uDX+nPERz7T31B1KejWIhFv85sYgbThU4mHtgsx8rl/EX/fBLrzCCiOHZg6m6q7+kr/xzzWqFK7dRDB2lIgohi4UKNg/DKTtj+r5HuWALHGRoLGdfYnjJdXdZU7ptfoWHrX+DezA9s2bUeXeoLcwGrtilIf20ovUpDuxEK/0iji7j4TiAhG/5L8lShqGUZ1njXXJJA7r1lT11H2Jd4zOmkpJRy0OdZ20Vt+3Bm4oxRku4IxZwK+dQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:33:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:33:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, LKML
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Fabio
 Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: imx6q random crashing using 4 cpus
Thread-Topic: imx6q random crashing using 4 cpus
Thread-Index: AQHa7I8LAS/6k2rI2EaGM7RtgQgCvrIjSa/Q
Date: Mon, 12 Aug 2024 08:33:14 +0000
Message-ID:
 <PAXPR04MB84598DA8723E1F167435F81D88852@PAXPR04MB8459.eurprd04.prod.outlook.com>
References:
 <CAOf5uw=r_eZs6d93bqposDfgcBvax+ZUC865g-H2BwC5g3Hdxw@mail.gmail.com>
In-Reply-To:
 <CAOf5uw=r_eZs6d93bqposDfgcBvax+ZUC865g-H2BwC5g3Hdxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10981:EE_
x-ms-office365-filtering-correlation-id: 828107ad-9dc0-471f-0265-08dcbaa96885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mRNd7TLjHlCy2LwSN65FM7JZjkBdT+3Ilyh9KDhf/Yzgv/NcgmpZmssPtleV?=
 =?us-ascii?Q?wS/ogKzaKmTlIsrDqvuhw5AuPOAyZdt7Kj4XFg9vdBiwhKGtkaRuQdTzo/1/?=
 =?us-ascii?Q?6ZEpASelH5azEQ+HPxEuhMSyaUzemoaIW5Wmml9BTETNiRohbIVaw9HJyG3+?=
 =?us-ascii?Q?VLSDL8v4ouVnoPEExe8ozyUCNPxbfq5PyqKNTdN3B0PRJr7/5j3ciYkCyvnQ?=
 =?us-ascii?Q?KakAWU0VzwdBcRTdZHq/L+flObTx3cS5v+R1DELYcUUaeTjk1dvsEN6ZwESc?=
 =?us-ascii?Q?7nc6reXPo2smb6d/uCBEpZzISOj415mEbMl8GtciecEhvt4DprtaLsoORjez?=
 =?us-ascii?Q?BR4wSdnuFPFMcAv1u0aqtWQrRJKfvaEQ2SKkaCVJduD1Qshfl12xSJqWu5e5?=
 =?us-ascii?Q?ah3GJA0dEps7jujZ6oLz5OezfHmWKuop5930z4BRbaQUy8N6sNf378mMtQmi?=
 =?us-ascii?Q?+VRbCKlz0lG1FVzi9WADcMKpx5osOZyYJ8uEvCiZFB4DJhbuJcHrGQMDQtTx?=
 =?us-ascii?Q?zD5BMShl0yPdDJ5RhWPjg8y/912wzL6AGkQDYrYgjDrh6ubYxmwcTJwfMZA9?=
 =?us-ascii?Q?UgiAvWKR+WDj3jRZf0IXWbg8sOXWR65zWP1+UKaNvMZDrz/u5qN9ahYGv4Lg?=
 =?us-ascii?Q?lMEf5kGNh2e0CT9QVIpnP0hvkL0WMO1i/FpJITOoXeBJCSe6xQQHJBeyp+lZ?=
 =?us-ascii?Q?r7d7M3k+k5xhLUty2CsnlX+tTc5cfuUnZ6ZK5uSadZia7eirqkxQUgK6zats?=
 =?us-ascii?Q?QPUlzgnWzQO1eb1bUh6xgo52oVi2MPnbWx9eA2zUiUzAhu1vtFrxvoepWae4?=
 =?us-ascii?Q?vFH3tx7YA8f/Y3/llhasjjQNq/QawhE2Kw3ZnydtN3FVlCuojFeBJ7rKv3tS?=
 =?us-ascii?Q?BCAAIpXPQT+XGBvI46vlcglsGGeLexKJkMfKST5iffJq11EMddZd2E5HDUnb?=
 =?us-ascii?Q?/C+/UV9lvZt3ndfpsznWA8B9J5qBeTcFXymN5rpC21dx6/R7vdYo/3v/Bb1f?=
 =?us-ascii?Q?ObOChbHd/bZCDBSwu6hIPZcx5PqKiFLtACk/k8NZruLfZyuRTEKdJAFcWnIE?=
 =?us-ascii?Q?tdULXbvz+9zIPGUX8REAd2sOZ0hIhynkwW/nLcyW7Rwd2rrwVEDCpzDF5sDj?=
 =?us-ascii?Q?f7K8LyyfJcizM1ZLpvCCMgH6lapvVmPXHHVyZPvyk7KLUt0qo49dEpLp0203?=
 =?us-ascii?Q?/cJWS3rMnSXt0RTcmhdqnzs/Ew82MjxZ/Z1GIJpNAlYFXXygPsI3gX5M+cmV?=
 =?us-ascii?Q?i9Sic1yOfnw/uJHzy4DXhyHYd1pg20mWv2chEZDen501D9S+EOHSVCvW/VKo?=
 =?us-ascii?Q?YXF9zBGnyYIy7eRx9vb+lIMDKx+0HTFU7fIv3HblZ0SI8l6lK6rUsyi1BZlJ?=
 =?us-ascii?Q?nYJY2Ko=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UsJNH7xL44fQFAaTyOVq9+ZL4cF3diEcYOxOe3FYwqd4EcXVJADl+H9LPv5W?=
 =?us-ascii?Q?KARX4+KrHe1EtPFLG/dYv2spwuol2c7vuOBNXxnguI/pKIGNLGfB+BxRQ60v?=
 =?us-ascii?Q?bp5yrFKHDx/s0NNzCi0ppZD3DrmLuwznu3JvuL5x+Ru06uc190C/s91GujSA?=
 =?us-ascii?Q?nXVNWTGJqiyI6EFA0IAFSBzhXLuIwXOhiO6NvTZyuEdsl71bDChLS9rSGqMW?=
 =?us-ascii?Q?ZJkCjZLuWj2ylLNfgDh2sxHLiVogERL7dLRtjut5SR7bx+HWYVQdqL757T++?=
 =?us-ascii?Q?CsPqggMFnFlkuvI3bDjABfOeUiGQO0kAp+8bl7Kawprv3QX8TabxKV+Ns1A3?=
 =?us-ascii?Q?3Ft0xOeC8UTCKOo5LFtSu3JruVpdtWvFnvawyZvUOlLqsJLfNEYpOI+BwfLh?=
 =?us-ascii?Q?cB28ToXYKKuxjs2IhVj+oYxsSNn7XJRXwQGmdq+KWJ4Z9bn1NQk1eJ3l0XjX?=
 =?us-ascii?Q?b2YomSA/vhkeTrnGr/Ga0sPQLH/vXT7q0V1Yj4xaVq/jJ0Gn6mWVu0UJZmf0?=
 =?us-ascii?Q?yb6awdqaLGnBnr+2kjuUArwyhmIvE430eYjVJd7w72mYQuygRLclk007WLDI?=
 =?us-ascii?Q?yCc3j9aNtouGLW1lIPp8hxg2Ao2J7WpAgP5zBVDOgZH4Yv8Y5hyD6WeceNpQ?=
 =?us-ascii?Q?0fMoVIwo9urv0T7K+cPGYA5prOLZ9eHxYd7yMxyEIVJm7x1kegNrbee/xdBN?=
 =?us-ascii?Q?49p9OqGZ9kszgYd4tOCrFEvqdYpfUQJ8mFba74YCYiOy1WaQQG/8pVrSGlyz?=
 =?us-ascii?Q?C2VQ70IUgRPfESBCOGRnSlJ0CKFHSEsYSdma9xaiaMFpp9DQpcfFrRUuiY3X?=
 =?us-ascii?Q?2DYeAkO7TbTOA0YAVJezzbGBgZtuPZxUGigVkbk9mKq7wU79AW5celBOfX5r?=
 =?us-ascii?Q?zqxFXfbmmyScVpAdRcPO39idHq0J9dIx5MrEiqzC2xLhkROw+pln1SiuBMiN?=
 =?us-ascii?Q?/SRt9U3kd5e4XHPxBiNEjVrAqJVKLjcRhT1pk4ZKRt7uutEUld0uhug/BEal?=
 =?us-ascii?Q?mB4GILROANlHzErPHIDQS+krCiwQexiAeROYGqYblemv3NLDo1WqNpqhqnte?=
 =?us-ascii?Q?fNsHG1Dwp7T7Vez793ZN1itwgigIcab7Yqowr2whu5m4GP9VeIfZjujeDuaP?=
 =?us-ascii?Q?6q6Y+TmSmpVFYeui55IK3zifMBHai6hGCTuHI7ebPDLZ6JzCQVOHYS7dbE6Y?=
 =?us-ascii?Q?nAeb7CZlVl0l89iQ3KZpTG0IfzNe7JLghf9/rZteKhrHXtrlLD1YV3IX9Wmy?=
 =?us-ascii?Q?ApsYkTkmVWu0MYpbB1S4xkzzcQ9GxI3QbBFxIrwUVT0aZsdB8Aa33QvJUOfw?=
 =?us-ascii?Q?K/BKigoMDGZII8a3XF0oGb4RPjlmUnqboaqB9ItcDpWrsrQR2Cof9b+GtNeh?=
 =?us-ascii?Q?OSjCPAsOGofmE8ckRMXXB3eXDLbApq0Rfe4tIMFUoMsj5toT1Br0OS+Z5AY6?=
 =?us-ascii?Q?1UMOByezSzNIwOtth19pqgx0CyfugXXM6hmCU203nPL1w/o2AwceYUOdwCsJ?=
 =?us-ascii?Q?JzuJskR3e1j+qJUMmT1A/7zpF6c4gSCP1pe691HEylVOamM0gmbc1+YRW52p?=
 =?us-ascii?Q?owZWn1hbZcN5N7KeT9s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 828107ad-9dc0-471f-0265-08dcbaa96885
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 08:33:14.5152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKaevlxbDpaPiQ05sCX55S/s2fuPlvbouXzMbJuaaVb5R+T5MozoaZVg+Es19PLZprFt5HFAZLvenRrDiTUokw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

Hi,
> Subject: imx6q random crashing using 4 cpus
>=20
> Hi all
>=20
> I'm getting random crashes including segmentation fault of service if I
> boot a custom imx6q design with all the cpus (nr_cpus=3D3 works). I did
> not find anyone that were raising this problem in the past but I would
> like to know if you get this in your experience. The revision silicon is
> 1.6 for imx6q
>=20
> I have tested
>=20
> 6.10.3

Upstream kernel?

> 6.6

This is upstream kernel or NXP released 6.6 kernel?

Does older version kernel works well?

>=20
> I have tested to remove idle state, increase the voltage core etc.

cpuidle.off=3D1 does not help, right?

I could not recall clear about LDO, I remember there is LDO enabled
and LDO disabled. Have you checked LDO?

> Those cpus are industrial
> grade and they can run up to 800Mhz
>=20
> All kernels look ok if I reduce the number of cpus. Some of the
> backtrace for instance
>=20
> [  OK  ] Stopped target Preparation for Network.
> [  134.671302] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  134.677247] rcu:     2-...0: (1 GPs behind) idle=3D3c74/1/0x40000000
> softirq=3D1197/1201 fqs=3D421

CPU 2 seems stuck.

> [  134.685445] rcu:     (detected by 0, t=3D2106 jiffies, g=3D1449, q=3D1=
75
> ncpus=3D4)
> [  134.692158] Sending NMI from CPU 0 to CPUs 2:
> [  144.696530] rcu: rcu_sched kthread starved for 995 jiffies! g1449
> f0x0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D1
> [  144.706543] rcu:     Unless rcu_sched kthread gets sufficient CPU
> time, OOM is now expected behavior.
> [  144.715506] rcu: RCU grace-period kthread stack dump:
> [  144.720563] task:rcu_sched       state:I stack:0     pid:14
> tgid:14    ppid:2      flags:0x00000000
> [  144.729890] Call trace:
> [  144.729902]  __schedule from schedule+0x24/0x90 [  144.737008]
> schedule from schedule_timeout+0x88/0x100 [  144.742175]
> schedule_timeout from rcu_gp_fqs_loop+0xec/0x4c4 [  144.747955]
> rcu_gp_fqs_loop from rcu_gp_kthread+0xc4/0x154 [  144.753556]
> rcu_gp_kthread from kthread+0xdc/0xfc [  144.758381]  kthread from
> ret_from_fork+0x14/0x20 [  144.763108] Exception stack(0xf0875fb0
> to 0xf0875ff8)
> [  144.768172] 5fa0:                                     00000000
> 00000000 00000000 00000000
> [  144.776360] 5fc0: 00000000 00000000 00000000 00000000
> 00000000
> 00000000 00000000 00000000
> [  144.784546] 5fe0: 00000000 00000000 00000000 00000000
> 00000013 00000000 [  144.791169] rcu: Stack dump where RCU GP
> kthread last ran:
> [  144.796659] Sending NMI from CPU 0 to CPUs 1:
> [  144.801027] NMI backtrace for cpu 1 skipped: idling at
> default_idle_call+0x28/0x3c [  144.809643] sysrq: This sysrq operation
> is disabled.

Have you ever tried use jtag to see cpu status?
cpu in idle loop?
cpu runs in invalid address and hang?

Regards,
Peng.

>=20
> What I'm trying to figure out what could be the problem but I don't
> have similar reference
>=20
> Michael
>=20
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>=20
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL T. +31 (0)85 111 9172
> info@amarulasolutions.com
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F
> www.amarulasolutions.com%2F&data=3D05%7C02%7Cpeng.fan%40nxp.
> com%7C0cfef2a8598047ed1e1808dcbaa62d0d%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638590470075161250%7CUnknow
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D9wzW6km41s
> pIH2J4DjAVZFtW%2FGjIDWeEB%2FJkL74477o%3D&reserved=3D0

