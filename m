Return-Path: <linux-kernel+bounces-174097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B275C8C0A39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62001C21CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36058147C94;
	Thu,  9 May 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltbOzHhK"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8FD26D;
	Thu,  9 May 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225927; cv=fail; b=Bd+G+XhKq20Cwh9lwhTVU1fiBZeJ3hiOYzVunHpHQmd/wat/6WTvpx9fO1fpodwHKZlOLTGSnd5ySB4IIngowqZPzOPTx+YJ58TyNiou79SBfgLUdLYU841eYyn8OLkXkkeSnieoUDjW18wQUcl3WeaR+9ikiSNwDAHTGd0JAaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225927; c=relaxed/simple;
	bh=UBR8LnIN/mLPplNuzZehKoGZq70Fb4IOuzl5NvxR+kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+4P9XQJuwtxIz3ZKbrh27bc1E2D6onW785I1KabgcNiEUmMFEQSkgJRZwhnObr/ukSZfOvXEetvyZmJYImCf8oM+36nQBNIq/vmY72TV1WirrtqRNJBiCBYkIpSJYlduw/IUHMzfEj7k4NdJBPgvpYZXvh+WN9x7p0k8lMAQ7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ltbOzHhK; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nf5QQskA4ksoo6ASCnEm6Pwjr1bpzZK0sSmsMkOXzuGRo/lhineWspm6noOx5hz2/4CHsWu9v3tvkDkOX9LImrzCsW+SZWKV3ccfKSnaSLemCJm4v9wu8tKbMHAQc+tetB7fsFgELrXfU0WK6EILkPf+kbY28n1fRhN6gAWbkRaGTSaub2wJV7ZKu7YS/SgKyxZ+qeZBFpwBiH++1INPqsl+ZpZcXX6Y7cPHC+IwrqMb5ZdjsVZnqNabSoRcM1vhdIz3DTNjhBJwKqweuwsvLgcRBOieSvNjZitS6rwps8GzDDmhwv9EBc/+IJitH+2RBaHWNpPEu8X9f830ghA2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBR8LnIN/mLPplNuzZehKoGZq70Fb4IOuzl5NvxR+kA=;
 b=P2OwU6q5mR/hCBA79DcGnUzaPocPaX0XZA2AhfXo1YWAoMI4s/aojydnPxR5CmM1ikLxLJUpsbBYfzRs4pmolvcM8NzUSfZfMQicJI/MSL7CbAwW8sSIXGRikZFDYck0ufUmZ9VZ1w2n/zHGTIGSGPHShDLQgYUItY6zVAcoWPO8bv5YVj8tTwbo7uH5eqxphj4eNye2VjoekgHDyPA+vI+N7WfR8Tuji/SDlzn0BJMihTMMud/Id32GNIKr8kmObQpadUgphho9ZzY6vTk8XczCyZLX3L7ymPQPXbZ7CwubYmeNKrCdECCE3usJ1kAUXugdIH5Zmz9Syypn+C4YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBR8LnIN/mLPplNuzZehKoGZq70Fb4IOuzl5NvxR+kA=;
 b=ltbOzHhKX1IBW70nEmhD2wnw/7MK/zDvHUR7taACarr75jP30l9+paaN7903IUvGzMmmSiHTDqznDgWy5qSsYy+oxhb6IVCT/Uf3is4rty6hCtHfaf9cwc5lwfZGmpCuMefl5MmQ6xOd3ZO+TPULj0QTYFt5Sz4krEH1sQ29OcQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7154.eurprd04.prod.outlook.com (2603:10a6:208:19f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 03:38:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:38:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] firmware: arm_scmi: add notification completion
 channel
Thread-Topic: [PATCH 0/2] firmware: arm_scmi: add notification completion
 channel
Thread-Index: AQHaoJMB/cXoS4cdSUKMJpx9wox8vLGNkksAgACwkYA=
Date: Thu, 9 May 2024 03:38:42 +0000
Message-ID:
 <DU0PR04MB941788789A3B0DF23995D28488E62@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
 <ZjuwgLZ1Sh5jRBWn@pluto>
In-Reply-To: <ZjuwgLZ1Sh5jRBWn@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7154:EE_
x-ms-office365-filtering-correlation-id: b542c4e3-124d-4749-65f8-08dc6fd985e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IUVxJOexW1q9UCEChcQtImnaJ87kwF+w2e0Y78ctOzGyu8/cRgzLnsv8Q/Cy?=
 =?us-ascii?Q?NCXCc1GqkURPFcXJIxyF3HYmDdVmcTY8IuMoOk1lyv6AHky5A9y7Cyv+V/Cr?=
 =?us-ascii?Q?BYO2txJeYeVQ38a+/GNhr7qAoBBSdnURZt71oGwaVfKEaOuNHYnz6mQ066ko?=
 =?us-ascii?Q?+pRATfAUvIk7jvgTHRv6vZjxdwqAp9+e/4QzZwTM0J1fZEeqQzEAFr/0p1c9?=
 =?us-ascii?Q?X96O/4tNtfIb7tiGjIHs8DIo0l3+eOZ+PyZEla233b3e4LUfRyugIVaFc9xj?=
 =?us-ascii?Q?MgsXLwr34oKLce8jXmBDz1Da5LLhCAMPk7ijUNYn92KAyXbE4+RioMf4690k?=
 =?us-ascii?Q?4Hr8YnMKwAq9+NaflkB/Y7xDPLIcMBBxUQUuNOiQDJp7qN8jAdJFLd9ueNnc?=
 =?us-ascii?Q?gPLr5l6r+ERDJzVZ6VOzzDD8i3PIZhp6hPWLqf6xrCmq3bQQWImxQmcsFelr?=
 =?us-ascii?Q?xnHB1LL/L0PWucuzncNS5S+WlCrSB6oxpfuiy0EwfpXJNgmHcrfZxGtpHuPV?=
 =?us-ascii?Q?mwpgpZ+HStD8yZdrTxdhi0Ra80mxFgcJA5knTgUwzQZaM/1xPNZap+biRd5g?=
 =?us-ascii?Q?jGCBhrfzsJshYC8ZNR3xZK2kPaWN81VOhcJhJtJH1vWfqggLtYoHCDrUGL/+?=
 =?us-ascii?Q?zgmQZx/tKKvLwNEYaDvjh7JkeG1UxpnZagfu0wbKtCJ1byEGLrxCOH1Rc8aU?=
 =?us-ascii?Q?iveCmz9kUM9NvUZcuhrpiaFzbdn8U8LNvJXdh1z42zMrd+2dw8IEb4g9uWE0?=
 =?us-ascii?Q?DVuQec40gM38IIv+A25afLjjqVP8rGl+1ul3FYgOjasbSVO8hUBc+sQYZoNu?=
 =?us-ascii?Q?jq610XuRii2yC5Ay3MtqjP5H/BHtEhfQxp11Mi2lUr8g9kAZ/g7SomyYA2/U?=
 =?us-ascii?Q?1Yxb0xH6TKtiaU3Yw8w+MkKCYjRxZaVOdQueDbd2wrg8UNnm6Op9q1ci2njs?=
 =?us-ascii?Q?HdYav2TnhJbPuNAoadKXDH23fK7fa4g5+ggdA+Bsbf7Ws7VKaVdhwgoBZIS6?=
 =?us-ascii?Q?o0yOWKnGwWHMO9Mwr1RM2vU8teMVnAkJpjUvK+rwlRR2SwMU4I0igYbELO4p?=
 =?us-ascii?Q?/spG0wmOwc2MjWPpz6wAzIYQOYxhoR8ACY1/WoAWLtrzclA7kwysD6S79nOY?=
 =?us-ascii?Q?Q3oI4bMKsOaRAVNXYBbhXLZ/dXa8vc+gskIKL7s2xlXlJPCa0ZltW+t5AdaN?=
 =?us-ascii?Q?F07C9jtd91J+xmVtjucesJ6ftIR2AIOHF7IFJC5yuRBytOJtrWimh4kBM42u?=
 =?us-ascii?Q?Jd/Wg1gK+nfq1SERqUI5BESMH9z5gpi8MdRC53WMRXW4ZayPqaJ+KEnYPEGa?=
 =?us-ascii?Q?E9mq3EUZsjrG+nLj1UcOJgOAH6aOzN2Z3WVswWtX76shwg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/nhMLYzIMVoKHpe9j4MnUWZ2b2NUuO/VOqLQrxJEP3n0quahHs8h4NFn3YKn?=
 =?us-ascii?Q?luD6jZmv4JPQTlywv9rbUpqwL11vaL64QqF2R99q9KY6GCZo0nzIrr5mJDbk?=
 =?us-ascii?Q?MZUsE1WOoR6gBKL19EZmTM0mb45fWv5+rSKdqcht3Qlwalm6ESyGFWURzVMu?=
 =?us-ascii?Q?5GjR7aVxlnyItM/4D0rInsqgASZomQG+7Z1OJshViIdzzmfktVLXnjgGrpCK?=
 =?us-ascii?Q?vMV96qDo/7OaNkfDr7ISn5S0602wQdCJwvWb2B5DfpgbAe800JWjzacQQVgk?=
 =?us-ascii?Q?dKEbbWJcvzlIXBvaB6wpFyZJ8si0vnJMHGcbCI//pYA/C98AG2vOailEJFDq?=
 =?us-ascii?Q?0ww1QytXtwKs3Ad5KShubS76wgRhwX7He8BCtuyNFQLO1Z7QqQKVvO02zzoc?=
 =?us-ascii?Q?2bWa4Cy+uE0V1xQz74qlIQfPFLCjqXO3lqxrjLGIQlTWfbNs851sUXfDAIb5?=
 =?us-ascii?Q?h4KbntQXVDjQkY4WUI1UtA7OfNqeIwAPUx/9adJk2c23LpRDBY1wQuPBfzkE?=
 =?us-ascii?Q?D4QywMUWYHB78ew7I+c2f+offrVoxlTmIMaHbuSMWLCB2woPe1DFlMgdLNFA?=
 =?us-ascii?Q?MLG8ZYl/AK/vRJGLgbM8KNWH/wktc2K5dWfW+Z4HqeVbapNUGObpev6Rcz4F?=
 =?us-ascii?Q?fHS2duQgkpgxOnxLiKA8HRH44svL1EXzeol/4JumZ3QegfZoW5WxpOXL3+ki?=
 =?us-ascii?Q?OJv6wSQe0tpNci3hWD3A90XZgDRfAVxIsfCaEb920Kap+dUBHcPLFLLbiLO3?=
 =?us-ascii?Q?qtconVez5MoRkKEwl7Tli4hnKTDVmUvKAm1MuvYDJqj9657UwQj6qqV4n0Pi?=
 =?us-ascii?Q?CtmpxLO9m7C1LgxXIC3CSryvdYo9Qv+RVcgrULsiEx43Ae+gM/fmuq17BNqB?=
 =?us-ascii?Q?8OvUQ/kbxIEFRNVxY1zTvqgHcUY8kJHgFDGLg0L3dk1WZeOIlk3lFmebiFpO?=
 =?us-ascii?Q?icY7mv3M8pq0jc5j79GeuGa2D5LTCWh4S0DmZM9n6wwOzQdXLl/S92DDYwga?=
 =?us-ascii?Q?U3TFXgXWRcP1XPd5LT9pqXJtEgWyu1BLBCXRN3mnS7ay7tqDczUxQIozxrS9?=
 =?us-ascii?Q?VKkHeZjkox2Y+vU7aLPH34LVUSoZzkKHcosqciyV+5VaPLVzI9lwVyjz6zGK?=
 =?us-ascii?Q?H+VphWgqKJjZP9Lw7YnV4x+90ledcu+elKzHPVLxb8ktJnVA41uZT5VnJliL?=
 =?us-ascii?Q?hS7xRf6jrJk6MlwDNCPoiy2BXO1m5UJqgN3weuoWF5fX76HVzvo0Jygpbypt?=
 =?us-ascii?Q?oyAQLI833EWa5t3J7Va69W2Tv7lHzySWQn7bVfCzyH9p1MQUXtWzhJjyrrBV?=
 =?us-ascii?Q?y5Y/je6aw7AKd1+OPEso0L6uYyARezskB8ZR3Pf/tUNYTwG/ySnE+cEHkxdf?=
 =?us-ascii?Q?AmOgubqM8DpeM9U/aIr2otWS3DGm62LZeJhF//iydY58P8jRT/gb6Jd/Y/S6?=
 =?us-ascii?Q?Lfqr2bHSTIzwU4LPgV9HV9/LOSymBvB3Mcms+T5iZZCNYL58x3WVemPLaSgj?=
 =?us-ascii?Q?wkAYUmaDs962wn5i9a3MswYWq4KBLD3gCy0j6+/blJBafoNjQuDOUgE0iHwC?=
 =?us-ascii?Q?Iwas01Vtc6whtSGeglA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b542c4e3-124d-4749-65f8-08dc6fd985e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 03:38:42.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Tw1LtevUk0QWhTiOnXUk74n2TRvUFYnfnGmqF1YH57008kILmVXxa0V7Aly5tCLREx7trpR/d4D2YNjymrqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7154

Hi Cristian,

> Subject: Re: [PATCH 0/2] firmware: arm_scmi: add notification completion
> channel
>=20
> On Tue, May 07, 2024 at 11:34:59PM +0800, Peng Fan (OSS) wrote:
> > Per spec:
>=20
> Hi Peng,
>=20
> thanks for doing this.
>=20
> > Completion interrupts This transport supports polling or interrupt
> > driven modes of communication. In interrupt mode, when the callee
> > completes processing a message, it raises an interrupt to the caller.
> > Hardware support for completion interrupts is optional.
> >
> > i.MX95 SCMI firmware is fully interrupt driven, so Platform expects
> > completion interrupt for Platform to Agent(P2A) notifictions.
> >
> > Add another optional mailbox channel for Agent to notify Platform that
> > notification message has been accepted
> >
> > After notification channel status become freed, Agent will use the new
> > mailbox channel to send completion interrupt to Platform.
> >
> > Add shmem_channel_intr_enabled to check channel flags.
>=20
> Glancing through the series I think the bindings and the code are quite g=
ood
> and sensible to achieve the addition of the optional P2A completion inter=
rupt.
>=20
> Your current solution, though, addresses only the case of a mailbox contr=
oller
> providing unidirectional channels. (which I suppose is the one you are us=
ing
> on your platform)

Right. i.MX95 use unidirectional channels.

>=20
> We should take care to add such optional P2A completion interrupt support
> also for the case of mailboxes sporting bidirectional channels.
>=20
> For bidirectional channels we really have already the needed bindings...
> ...no changes there...you have just to also ring the doorbell on that sam=
e P2A
> if completion IRQs are requested.
>=20
> IOW, when the DT description is made by 2 mboxes + 2 shmem, means we
> have both A2P and P2A provided via bidirectional channels...we currently =
just
> use the P2A (RX) channel to receive notifs/dresp via rx_callback (so usin=
g only
> the platform_to_agent direction)...now we should also ring the P2A doorbe=
ll
> on the existing P2A channel if the FLAG_INTR_ENABLED is set to signal the
> completion interrupt on the other direction (agent_to_platform)
>=20
> Not sure if I have been clear or make it worst with my explanation :P

Thanks for detailed explanation, it is clear enough. I will update to suppo=
rt
bidirectional channel in V2.

Thanks,
Peng.
>=20
> Thanks,
> Cristian


