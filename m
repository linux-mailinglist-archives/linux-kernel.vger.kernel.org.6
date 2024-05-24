Return-Path: <linux-kernel+bounces-188194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A838CDF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B49C2826F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41EB749C;
	Fri, 24 May 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ipFnKdqB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112F3FC2;
	Fri, 24 May 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512695; cv=fail; b=t21xww1a4daAXsP8Fe/Z6RXCjK984si9YxT4HQjXPjOzfIfv6bQ84aP1OCoI6Mn4twFtLe+Ovq6FxoiQiSKOmhWlQlKC2DFF/uOJeb9lcEjcMTgos9fwMRv+Kam8ObxVhJkNs4+djxdwlmzW+RWHSMPEwbV6xKEMWeHAja8P+tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512695; c=relaxed/simple;
	bh=wpg3l26zbvofZUCRRhCID5odyYGm+yQ2ZLzo9S1mthM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJrCYimMjx86qKfxznfsPb1d1+BGZo2aEkdCMYVXEunGp4+e2mV+87PVOaPyU1YoFSamwaXxQPxW9dR8d7sKrNMOG+gCGEid4leIFtUXNWpi0FOE/RGpgbrXJejf0hnf47q79HzVYmqc9/G7A5EW3LYp96/Tzy5TtA9Hd0mBaTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ipFnKdqB; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g966A8lP0i/IQ2hBwIkkJbnhBN3/3n86//OoTi7EczZnZyPdeGXVXZpIq7E4+qkCKfQpdj/1cxaucgRYq4+79+D0c0m+VocClklTLUJkEJAz8N1rxoNMqttt2t7nI4ovKgRArRDEbpr2se+FUoB6x9zLGsselUf1paCEGPSjXLlfiI/CCUI8/Z68A6g11Y737zSS6Tm2Bxm7HbYNAI1IAnHiYJiagk0T77zY/kIye5f0k1St8wJubeyCawUU4OEFdf/c6WsiOpb2Z3l2zDGz5R+n5QvmKmYWUkxctsuNpRPAzfHfxz9+ka/nVivYlv59VZ/f91dvhpuqVU3MTsYPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpg3l26zbvofZUCRRhCID5odyYGm+yQ2ZLzo9S1mthM=;
 b=f2dVuEH8D0FioJDce3fAL9OK1c/4jcr0WwNsWdCSuw0Xf/crq4K2u8HyvTDSlcv820F1kAZ32/Lh3RbQ8qHvwX3DfMWD5sWY/nMLv/sjh4/nx0HtyaD33Km7rUt1gJWz+9N0fyMPPFUhHw3KR5t98TmbODkekHBb4WIjrViZzCkfzn1OUv3iM0yUhwbfm12tetY+XIAj4ek1WsmoxM3IQF7l6OrvFN2qdri5/+Rnbor3cAubwVpBkfAn6+7z0UurUe5KBrHhfEIEu3uEz1Od+oH7M8ZWmFUNRC7/urkPVTQQ0iu9aSvDc7ZOobvMCV/SiQPHYg3GqmQxNRQOyw7U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpg3l26zbvofZUCRRhCID5odyYGm+yQ2ZLzo9S1mthM=;
 b=ipFnKdqB9eNtY0cjb7jMBBFliLgrPQZugVE4Wgjn/TGRPzzZmS2LwFWxIjw4PSsgAlu6sNYAlU5MNgBH2qCl0bSDUsXI3ImnpcTRpS0N36nxRqCJN8+lwcIjCdpBRhIiwdrTPldGo64lEpCAJW7qU1uVr5N0JOhQcLkbYZMZbQ4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9786.eurprd04.prod.outlook.com (2603:10a6:800:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 01:04:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 01:04:48 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "S.J. Wang" <shengjiu.wang@nxp.com>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"marex@denx.de" <marex@denx.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: RE: [PATCH v5 4/5] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT
 flags for clocks
Thread-Topic: [PATCH v5 4/5] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT
 flags for clocks
Thread-Index: AQHarPrL9j2RHo5BEke/VM4nN2Yf4rGlkqXg
Date: Fri, 24 May 2024 01:04:47 +0000
Message-ID:
 <DU0PR04MB9417BAD22B5519B46EA8AB9388F52@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
 <1716458390-20120-5-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1716458390-20120-5-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9786:EE_
x-ms-office365-filtering-correlation-id: 474a8638-63ce-4a1d-40a0-08dc7b8d81e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F2s5pVcjf7f0znovEUCwTuobW1BfLzJFxeBO33ILaFs/W2my1pWnnwMrQE52?=
 =?us-ascii?Q?arknE7zxT3R7XywhjaUGjVElQAx3hap8aypxnPw10UHnUPDkF/R6mV39ohQB?=
 =?us-ascii?Q?76ViTVEgY7TswJgDZwdRjX/T3gWJNsrEnwVPYLNPJtKyFD/yjNGApeFEg01g?=
 =?us-ascii?Q?4tik4w+VnG/ogyjYfZ1W86crzKgXZEgcnA9/0NcT/b77L174KlAAtDbS4mQS?=
 =?us-ascii?Q?FeJyxVkW4nx1oZ1Kc+3gqVD294DkFUbyFpc2J1LVBy0YM+MorysZlrNYlu6B?=
 =?us-ascii?Q?f5qUsVh19VeEavgKLZQpDN3XMrzRY7Wi561dH1ugBuw8j1JO5f+FTrFNWSx5?=
 =?us-ascii?Q?8h8SxgkIf5AP3EvHKkXLIgX7qRLYzgOmJkhQDIWeeNq17xiY4TbiZkUH1h7l?=
 =?us-ascii?Q?5KTpDoP1qUFE5dB//XZAp984cItVKkstmlY95akMmxfq9vhB0itb30vSlZZS?=
 =?us-ascii?Q?S8AAst32Uad0laLnnavIdNr9LU2ENOmFLDn6D//CuxtmaKrxHBUrKDzEuMDf?=
 =?us-ascii?Q?uxWrjdeLJqXOngbWNO2d7Nu24mUGY7RRWWx8vAYpfY9MTZ3JPBfVZulUj+/m?=
 =?us-ascii?Q?VnuUbLowkhbh5+SxOHtcJW4ejV3SNy7hduAZcODQnHoZSNrxbladf/QLNM0w?=
 =?us-ascii?Q?Ju/uLfU2Lz+6th3pBZK9f1a8TsQu07seA0bEjkY1sUh/2wwXDKCOQ0vDQ5/0?=
 =?us-ascii?Q?7kgMhhGHEwX4iBW+zX0Wj6gWqpWopFHpA9U++oUaJKvSWb3+w1U/lKFZ4dJL?=
 =?us-ascii?Q?pHeEtqE5HmCfmqNrQmtfeHf/wIs9k5acdhC8umJyeuY4vm3DY9MWSH9GMmBe?=
 =?us-ascii?Q?ErbQP5EScaaDOT/qVlS4QQ3d/uNn44C1XrN+6U+i8zw9HL8m0sfJkMZw3udD?=
 =?us-ascii?Q?dswD/Rw3yjwYyx4lfYTFfYscsPkrW7xJ4lHPCWBb9GqxcEVHpVG1o6E1Coum?=
 =?us-ascii?Q?uhae+pUP0o26K2WNvJ4AftgYmzNxinLThI0tyehtBY0zeR0syhf4S0OZ1h1x?=
 =?us-ascii?Q?V7gCU+nONWnf3RIIkuwDtcpgDG4Sk+59tOJRnLs+XbG17xSFXHcSdaOUt1pt?=
 =?us-ascii?Q?fnpvc+4DeCE8GUTjEUilc4S1H5sCqbAysxXuMWKTlw/TaDaMzYreBmhiRwGA?=
 =?us-ascii?Q?7SsxnV2hFvQIN0zVu1k9AZ6HORvXm51T3mbgA8TdYvy3bbeJqbb+WQvp3R/s?=
 =?us-ascii?Q?Z346BySoTPYV8X5Ssm4xlNa9Iq3NGA/CPaClr6LbtHLgJlh3rP4KLqt305a4?=
 =?us-ascii?Q?xViypPVfd4VVzqPstbz/zIjkwH9xHHdP5P4LC/0o4cbO48i+TRNyIuI7WU3m?=
 =?us-ascii?Q?Vr+5RE8z32SBW7vaGFxWOTC+FuyiK3/tgC3zSVG/alCpqla4DjY7RZIbUlOQ?=
 =?us-ascii?Q?SZeKpug=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hALj9H5nv6NZAcHZBVFPH7YGTqcg8r9bkAnLV0lTptIGvtGewT2+YhGDN5Oh?=
 =?us-ascii?Q?PAoJgSA4AYz89teNFsj9dqMIfijmZySS4JTglAqEtCtDEXxeZ4+bIQ/WnMp+?=
 =?us-ascii?Q?jJJOcyjaWueDWjK4pIWdplgVfLlrO19R5ltau6EhgOxaaD2kRR0m/lFhWmMb?=
 =?us-ascii?Q?hdhiVmG1K4ZWXbJ5JrumYMTZhQlgitcMPS1RMRryelKL1Zf822jDuYfNx4KL?=
 =?us-ascii?Q?kG4/LgkprQwdPdWNvaFWeZs4Vzn9NRuPoACvIL5Vt6ox1lKZHYs2qwCMXIaY?=
 =?us-ascii?Q?Grq29UIXpaSaNoyoMSEvVVxN2wY6bK1fA9b6ow71I6A+ZmLhdr4pDIxgW0gs?=
 =?us-ascii?Q?G06tZUTmhxkyxdYLekl0FkUkTtLH+DYUFDOHiQV5et/kPfM58rO3FfCtG0eI?=
 =?us-ascii?Q?PZIAl1aZRvY3Z3Jw/uAf4R9KPtXPQpGLi66uVi145Yhly0DqmdHkfYOrB98A?=
 =?us-ascii?Q?dd64s7+yqDhSnwiY4cKM0+fn55TW1URk+anvLnbsI9UyY6w8XMu8TxU4ovSR?=
 =?us-ascii?Q?MfMb3lA0fbRH0baEEUw6Sh5CKUQjOHtAnHRbtHLqd6YX5xyiA0BqUq2YsPti?=
 =?us-ascii?Q?y0zCCum43w4VamHv7iTtkCRcjHZX2YgvZp2z1CK8/qzmsZBy9LStJkdRgsu/?=
 =?us-ascii?Q?upJ6ysDq074RgHadKvNlacvGK2Z7Dls19Gpe0FKr4T4i7CCmbyu5pjFvVYaR?=
 =?us-ascii?Q?J1FPZxOsMxR5Fo0AqJTfBiUy/isHtV03vnU3wDUtMy3B/8YgLpDGHB9eIJKI?=
 =?us-ascii?Q?bu0K6T6VkySdfNp44KBDLLLW5xqpWkxVKUdIaobdCp23EuoLGQ2J0hsjycFo?=
 =?us-ascii?Q?cYcNabPgUp4RvpODJ8tVzq5oqDYvNOGYFs+eSRJ+s27msLbGvsdQA4Rpb828?=
 =?us-ascii?Q?s3UkJ/W70P82DKro+fTEhBs+7mxVCRq8TmRHdNbJAqtc432bTkYAW/h5SKMK?=
 =?us-ascii?Q?OYrrknrkKsVO62+YSaKGCMMeCGltW8q9XK3H/iOgl6jWdS+EPDas/PKXo0DQ?=
 =?us-ascii?Q?NUmzavgWV+Y4LLLcQGRlgeBPGdxfKEQp0a8vyKa4yFEUOSXHL6h1Hvbuy0rg?=
 =?us-ascii?Q?z7/31VMvCgLftZu1X0OFF9FacOX/53fOzM/JXkzHro1ig9N61fbOM6tIBm+k?=
 =?us-ascii?Q?puGhjfAexrmo7W5sgyKYZfL0LNxmz0QwS1eTbuIp23rXn9o28P6/18JSD9Qh?=
 =?us-ascii?Q?cd/iLkY5Svo0uoqfDV/z6eJyBxCQBC5yZAmSEB7RxYUH39++agR9yzWRVluh?=
 =?us-ascii?Q?/AJDIdJMpBrgs5PaScZEJ/wtCamf7g9Xjg9LhrI/E1DVCR040hqFg9ho+47y?=
 =?us-ascii?Q?neVp+SNDSrGOS0XqYdNhCkG8iO/VXVsgSyS7mNgTbMSPjLVgVB1xxEpQLMRC?=
 =?us-ascii?Q?0hiu+4XZ0ItlJAH//Y761dIwCmULOgQh9q5+lJu4n4YnItG3Zzuqczqz7iIg?=
 =?us-ascii?Q?yCIC4iGixnqqfHY7zWqXLTZV5hlsBFphyu+ZR8WiPiRsmDpooxrMcLTvTWHN?=
 =?us-ascii?Q?IIEacdJb0rISDo+6F8sIb9ivrpDZL0SJN487KdG/C9t5LNVGJUv1giYLFf3h?=
 =?us-ascii?Q?ywTH6nocWwUXTkLkjB0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 474a8638-63ce-4a1d-40a0-08dc7b8d81e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 01:04:47.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTCh/TChNF3HTAuVk+DShbB/36wa7aO3HmB6tb4WSTbx+w04VsG0Z0zZdWY+Mk6qsK9/9CZMyHHFropFTpyyZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9786

> Subject: [PATCH v5 4/5] clk: imx: clk-audiomix: Add CLK_SET_RATE_PARENT
> flags for clocks
>=20
> Add CLK_SET_RATE_PARENT flags that when the device driver sets the child
> clock rate, parent clock frequency can be refined accordingly.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

