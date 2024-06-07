Return-Path: <linux-kernel+bounces-205414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F448FFB31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32689288659
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5FA1B810;
	Fri,  7 Jun 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mj6rPX5A"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872A1B960;
	Fri,  7 Jun 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736924; cv=fail; b=Esx3uGEgxgtmRQ+hgMib8pEhQyp7QB667/CuGslrJbHwn+BrFVJ/V5tb0ulQnpit0vqGtEkgkKcLZT5BwJNtfua3ia59EFSCOX2HJjPtMNK8yotvwXTgCRtNj3gtN/snqiF7d58NVNZ461AbYSmvJDablLdZlVrhcMRCQTYJLtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736924; c=relaxed/simple;
	bh=eo8XAHXvLmKdyPhE6fE9IJbaIow6Ju70mykasCM5Gm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtPmLX/3XIDoMir+Vt0o7xcXkGDFkB81JTQtGHP3VHBE2BOr7O+jTyfnMPQFP3gi5j2xug5wc+bepCnOAufQhvWHgAYFhW/hiquo5+6BzPjHsU3H9v6uoYZwwcVDMvGxzvtJdzZGQbV8Gie9ZdyGsiyI7v7cubo+C1vVQNy265Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mj6rPX5A; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV1jLz5plcJ8F5szPT1TRR2autjAw9cS0xZXzlf7C0cHBbGxZUbU/GpeX20T0jcKwRXnK+icG+63hMMQAQeNIDcyD8fP1V6gkrCVqL4p3fb8lYU1eQxkjKTgX+sDMs1XBu1Fq7FdCT69wkoebsb6JxfJ1qUTXEMV2SUxQoJ/45qlG6vKf3gFQGpGXfoliaN0PW7LdO4kABwmTkPnGH1Tkh0Svc7XAFqfrCJf7exPNdXP4i7q0ZbSrFXtgCe1T5t4vjxaDFZ9NUpS84AERaqo+wZvP/G3WbfGqOUlnvPP4fVl/Kw13UOcLBXdlyLlKHO21iHc558FdJjRhNeVwuDaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edh79zrvHVBNWvyEtZ3s5dsKIjIsIzONSO/uM7RTMGg=;
 b=OaEY4fq4VfzfP2sZn9xxdYUDM8/lM8B5RwClCg0GOJm4uvx2dbyfx0C2xtNoTUkC7OeuKLPy0tHnmqRLs/gf2rXCJfpBSK8UEhvCNG8gO93qP22hi0Ap+2ddMACIJdJEwrjt83WIJuzWLQV1a2c7bJAE7tMLRnEaPahvOYsdklmnQc/YtglfvsoStEyk7haYsqhoCbpXKhWTxaninySYnf8tZ58hVFV//gv2lJzJSiFl0e92reuU3msrNH8D3ZmmPOP9S9/6W9bISh8xFiCw7uSDwt+9xZgwlVbSeiJh2ZE4tUnmUeXx3WuudM5Tb3uWhB4Vp1R57k1n2iq+wTlqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edh79zrvHVBNWvyEtZ3s5dsKIjIsIzONSO/uM7RTMGg=;
 b=mj6rPX5AIHSrNgV8E0Wh6YL7or4/dwnsmdjufCTspoRP7bYciKAEib0XmKyw62cXMEQcw1a5KDuLdfruckyQ4+FZNHoAqXW5lb+IZLnHc85djsFVGrmhr2AEgAojAj25sWYdCCEGh60c+4w01YgQ8euqzDyoa3Bd+7AJOd5N5pU=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 05:08:40 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 05:08:40 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Franck Lenormand
	<franck.lenormand@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng
 Fan <peng.fan@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Thread-Topic: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Thread-Index: AQHaoao2jC57TZpcF0ePF6O5Tvr8yrGOOJWAgC2zU5A=
Date: Fri, 7 Jun 2024 05:08:39 +0000
Message-ID:
 <AS1PR04MB9358D3AE83FDB89672AE9158F3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <Zjw9044yBRn9+adW@lizhi-Precision-Tower-5810>
In-Reply-To: <Zjw9044yBRn9+adW@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9358:EE_|PAXPR04MB9219:EE_
x-ms-office365-filtering-correlation-id: a91d583c-a9f0-430c-04be-08dc86afe505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7yZeGU9Zvnda4oB3Rg6P5fi1U6QNbSnM2YYWlJkG+k3gh5tjOKoac1gvTALz?=
 =?us-ascii?Q?FOk+QScnI5tjsQBB7wf1GXKJi+eVgJxTVSmh9AYO5wN0W4Lj4bmt5mI38ZKj?=
 =?us-ascii?Q?l22k1g+nX6YRW2dB5RfD2V5S8lnqIzw1rEPPFzUhoRNSHRVw5Dp3K3Tqzvov?=
 =?us-ascii?Q?9lljf/dj5Z+1UwPZ1AoYIg2kwKzEG96kHjdR2WUQgUDAdHq372cN/uEKx9tz?=
 =?us-ascii?Q?KSqx6DPwwng3jyJGOddSiAudTyNwmw33a9KOpszlaqr59pOUu64oktUnPYSH?=
 =?us-ascii?Q?Q/V5vxNQvcALY8rgC5EH9XsVY+HeVaU4O88WzsVxwMrO6Ey44fCcmvYcG7zv?=
 =?us-ascii?Q?x+ASs7DkhKjBqOELHdRp5Q7uKUi5ZmFwgl2Bz0gmw/fdiD3hdBkx2ZgHO8dh?=
 =?us-ascii?Q?ocwWc6kSROSS0yDlVw0zXdbKFNTHMcjqeqPsvZbvcONDFTrlcI2/KOWUInkv?=
 =?us-ascii?Q?5AjAYVCJwIZ/SW27Ot9Kfr8VqHnmsVXb5uiyZMp3VQXkAGlKJf3Xp89A5EfC?=
 =?us-ascii?Q?bVNOxPfPE5RmITjDRrwz5J0TO9o1ZaN+UUvBkbUpC7dvG0yPjyhuLN8TONMF?=
 =?us-ascii?Q?GCyuGuGfhnQ+bf76TNCjrY8MygCZowac8OrXJn5m8hWTjDhaMxapDMWJ2viw?=
 =?us-ascii?Q?JpLQsssY/oEPSpmwY88bRTwnjbACsQVahZHp22Hi5Qd4TE4rR0aCio/QBP4Y?=
 =?us-ascii?Q?JtWcyZ3PMVp/zbGbqwdL1JYjXz7uJrfD/WI1X5e3GkcMgYI3TWGGoh7J5SEz?=
 =?us-ascii?Q?C6RSneYYJW5oCW+Dq8jwdaaF273gg/wAj7+OxACG95LglAMhSDVaNVXfa/0i?=
 =?us-ascii?Q?nkB7uiQmZQmlfVpe7WdCXP/cV+pcREeJVOtl7RQmea7h3KgPm8rkkN1Fz2SB?=
 =?us-ascii?Q?RNV+HNWMSgml78ZuiMHMqQV8WuWMb+HSUp4fyxNeJo4YhMX3MzEysF7lGMGi?=
 =?us-ascii?Q?Ce2hHcYJG+KBtv1BIn/dCk9f5omwo3/c+z42NFZjKEur23Wpqd5rxsbuEZ2x?=
 =?us-ascii?Q?Uqjt5b5bSSvbvclgLJ6NpKCbdg9EGBF0DJdS7+daFHmFKaUYxxj9X/SJPh3X?=
 =?us-ascii?Q?S5EyQg5jlFZx7ep93xD5epcNTsWjMqtwa7tC4xnyUZGEddyf977i50idSZQt?=
 =?us-ascii?Q?IFr5X0XXarbipLO2fSf0ndfHNonDqf8AWzCkttAOtTNTcBKgrRrMLUhYVKCA?=
 =?us-ascii?Q?in27/8PUJM29NY5hNC9L5Y4BMgYm7FByzJ3Wp5FDvIRZdjvW9cOUm/noyK9c?=
 =?us-ascii?Q?ng45x6i3pgoo3G24lqjvXobCuxeMzmx0eAPv9yh4e7K3i2clyqlGFbKCnVky?=
 =?us-ascii?Q?BjSLuDfx2aHCK35+WsuYrKXs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3wfz+vP519aSbcmhjzeTGkafa/6nz3OATGWxFTMxKMON3Ne2eUXwOANfvDPp?=
 =?us-ascii?Q?IQryqNH72oR+IZTliCySorqU1vYaqq1sl+hyg5E8dEBfsrvX8WYlzc1MKqhw?=
 =?us-ascii?Q?FSc4QoIF35CeqpiY69OlOvOZHUahAxfdiwndsuKjQ6S0xYq9fUHmYmXtuEWO?=
 =?us-ascii?Q?ZhxCXARte7p8TXDAx91LsGh1/P4B53h93Iad4kYs9Wh3W4aKP/0eNUQbIFBx?=
 =?us-ascii?Q?RQUxqeL5E4PjXoTBwjvuU8L+DJGJSRNxlFd8I3OQmKHVN1ZLRbtS6Z5/SEB4?=
 =?us-ascii?Q?Ba9XpwpJG6Bi8AQr+nJd5LlTr39Sm9OBx7fIbxBEtg9AyohtYXoXm8AY2ZMF?=
 =?us-ascii?Q?zxryCqvvVvXsnmMLv/GBz/yf86vgef6bvNF2SS7wlz/gy7465iICEsqmJXMj?=
 =?us-ascii?Q?bqP+FMMZ0fQJlbqyLI0bfzOHG/G/pI6Md0hze2t6hpFaHTSnRApYp0hAfa86?=
 =?us-ascii?Q?RzwSa2KLhQXF70Fzfjb8tL/bfCXgBCjuLngR/bIUXZ0T60Oek+yNoA/sAafA?=
 =?us-ascii?Q?MRS08UiQTMSI/D2r39tX0Q1+bd+fpPAe6tEKM+329UVGSoDKRWmWZ1w/6Npr?=
 =?us-ascii?Q?i8xaGVdtGXL/KlJKGjxfg3jNRMmICkU2nuzepGn9G1yGaHiH9BCKzULzkPUk?=
 =?us-ascii?Q?gSukcLrRmX0HLj3nCeT9Zne15V3dfjK/uBkNHR16vE2qu7m4wSA7ErIusWPa?=
 =?us-ascii?Q?u8rDAj8PBQI0HaBc2cD1gwUls/IG6JMl9Q6PGE1ZLryASQhidqw7r2RxL8vs?=
 =?us-ascii?Q?ROXdUssPGrNk9mpZOYntIgp3+iNJFDftl77E8vXzjHxnfxh7YYk643J9Qiw7?=
 =?us-ascii?Q?V9ZRbop3ChQBqnl1ojDCc9QUb0w+LtqLevZUnn/kgnmHHglcN42l97XKD7n6?=
 =?us-ascii?Q?XWibzNy61OQgBpH2YMH4FxaJ71vf/vLS/Ob2E7GE7KiMeQ6sKOPPsmU2iZC7?=
 =?us-ascii?Q?z/pCm0j6CeO6+l95KZ0rqd2jNB6KnhWNrrfWd6wjTOd3YpS6RW03mn109hzT?=
 =?us-ascii?Q?/P0EtB5phF0Z7cW4Nl2Fxi7xCfmKI3fB5iMrIVrn9qLEfafGqvEdwPjcv88j?=
 =?us-ascii?Q?njPFwvIObB/TgPwa8qAIR+Qj8sZHoW9ULl1EiaxD7zWzigsexpva8B6aJjJV?=
 =?us-ascii?Q?jX7xOlb+DfOMapMxJpo/kFk0WsHGZ0EXg1W2vVtrk6tgVhw7PSHJl2MxOyrc?=
 =?us-ascii?Q?951Oy8diut2AVShYAoi2PI/rUWBWaMb4HD7WYa+a5EzvaqirTlAwoqEkH0IN?=
 =?us-ascii?Q?2QLx8k0BIHW7wcV5HYXduYSZjc5R6EZAVe/OWWH68vnDkHwjhdjpI13+f3tN?=
 =?us-ascii?Q?6RQNaFJrSgdKZtvaC0sOaISYGrFG7C4oHJ/EOMdWRKyZQ1Etq+JA1y5wA99j?=
 =?us-ascii?Q?tOEjrxGyA9tVNfZv17rLVDPcWvT7dnjJ51dITIjGPcwA8xiyUm3fYztbpnqd?=
 =?us-ascii?Q?40cKvVKyatjXRuWwpMQWfzDbwIK3+r3AXzPDg/runOvfzWNwcDaAgnkobbPY?=
 =?us-ascii?Q?5YOOqjYGx4CIpQFMWGfwFn4Nb5Zxa3+Cbv84/8XDH+JTN6ZDvmUTlGByMb1y?=
 =?us-ascii?Q?gpzILjXZ6C49JT4VL9AmS1y4hh0eu5ebY3P9V4eY?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91d583c-a9f0-430c-04be-08dc86afe505
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 05:08:39.9375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBxvIByGulxG89EHVpW8VbCbPWd2j2i+kzF9tYP0yQ8qgN0C3oPJR7pKp8sl1GHDr/FX0kd0Tr+nhHZbcCJNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Thursday, May 9, 2024 8:37 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Franck
> Lenormand <franck.lenormand@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Peng Fan
> <peng.fan@nxp.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org; Varun Sethi <V.Sethi@nxp.com>; Silvano Di Nin=
no
> <silvano.dininno@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Daniel
> Baluta <daniel.baluta@nxp.com>
> Subject: Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
> bindings
>=20
> On Thu, May 09, 2024 at 02:45:32AM +0200, Vabhav Sharma wrote:
> > Document the secvio device tree bindings.
>=20
> reduntant sentence.
Ok, I am removing in v3.
> >
> > The tampers are security feature available on i.MX products and
> > managed by SNVS block.The tamper goal is to detect the variation
>                         ^^ space here
>=20
> > of hardware or physical parameters, which can indicate an attack.
> >
> > The SNVS, which provides secure non-volatile storage, allows to detect
> > some hardware attacks against the SoC.They are connected
>                                                ^^ space here
> > to the security-violation ports, which send an alert when an
> > out-of-range value is detected.
> >
> > The "imx-secvio-sc" module is designed to report security violations
> > and tamper triggering via SCU firmware to the user.
> >
> > Add the imx-scu secvio sub node and secvio sub node description.
> >
> > Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  .../bindings/arm/freescale/fsl,scu-secvio.yaml     | 35
> ++++++++++++++++++++++
> >  .../devicetree/bindings/firmware/fsl,scu.yaml      | 10 +++++++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> > new file mode 100644
> > index 000000000000..30dc1e21f903
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.y
> > +++ aml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-secvio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX Security Violation driver
>=20
> Violation detect driver
Ok
>=20
> > +
> > +maintainers:
> > +  - Franck LENORMAND <franck.lenormand@nxp.com>
> > +
> > +description: |
>=20
> Needn't "|"
Ok
>=20
> > +  Receive security violation from the SNVS via the SCU firmware.
> > + Allow to  register notifier for additional processing
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx-sc-secvio
> > +
> > +  nvmem:
> > +    maxItems: 1
> > +
>=20
> any interrupt defined? how do you notify such violation event?
Yes, there is security violation interrupt bit in register map of SECVIO HW=
 block with uses RPC call to notify/enable/disable this bit using RPC API e=
xported through SCU firmware
>=20
> > +required:
> > +  - compatible
> > +  - nvmem
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    secvio {
> > +        compatible =3D "fsl,imx-sc-secvio";
> > +        nvmem =3D <&ocotp>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > index 557e524786c2..b40e127fdc88 100644
> > --- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > @@ -129,6 +129,11 @@ properties:
> >        RTC controller provided by the SCU
> >      $ref: /schemas/rtc/fsl,scu-rtc.yaml
> >
> > +  secvio:
> > +    description:
> > +      Receive security violation from the SNVS via the SCU firmware
> > +    $ref: /schemas/arm/freescale/fsl,scu-secvio.yaml
> > +
> >    thermal-sensor:
> >      description:
> >        Thermal sensor provided by the SCU @@ -197,6 +202,11 @@
> > examples:
> >                  compatible =3D "fsl,imx8qxp-sc-rtc";
> >              };
> >
> > +            secvio {
> > +                compatible =3D "fsl,imx-sc-secvio";
> > +                nvmem =3D <&ocotp>;
> > +            };
> > +
> >              keys {
> >                  compatible =3D "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
> >                  linux,keycodes =3D <KEY_POWER>;
> >
> > --
> > 2.25.1
> >

