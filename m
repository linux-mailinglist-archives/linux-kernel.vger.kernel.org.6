Return-Path: <linux-kernel+bounces-249011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C143B92E4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DA22810C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595215748F;
	Thu, 11 Jul 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JeHnML7C"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03715748C;
	Thu, 11 Jul 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694611; cv=fail; b=uxK2fnob4U2Z1SgNjB69uFp2VVFwp88lLaoBumkZx2mlrabvrEVd6o0g3IsNNG7K2UEhpKxcyT65dD2jV12Th49T13T4DeCKsxp7sawLzxMAlWrWApct8nHO0sgF2t6qtbFmaf0y/47Hf4S5v9pJRl9BvCLcusfCcuA1YxCsrlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694611; c=relaxed/simple;
	bh=RanWov0uOcYoL4JJtHMVgJIQ2KkpRM9+NfWd8wYVcHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kVJFjrTT7PXhqVmeJ+ChRFFvUPJAgWssIHu9YljX6PbWT9j0PPWSi4fkbDPk2rgjZYTqBHrgKO/4N0hw66/kPkNOo7o5qLGCIHrn4vqjSzjEB58uG1EF8fo7ygE8xvfNBlJscRFIQ+Q69ROW0zkFc4Y2ScqEh5njPJOWDNIwXGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JeHnML7C; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMSZhVzN6Q/4Ma1dPXGre6qIwIOzxhLzaV48X4ljeai9qOtGqorcR7/0EsehivsVWxAB/xW3I+cfev+L0LdmAXG5xI4OlOptUyR9ieezghEzj/UO/cNXkX6p///UI94PsW+Y3ukwLciec7JXJ0IW5d4KybEjJBBo5hhFztYMTbf0+9JPe6oXhhAYtQ8crMR6Vn8rOMgggKrX6dG3NO0VGsZv6v0Jz3sINTca8jgevB3LYu4NXnqoz7OyBzqhA1HEksiu+zIni4wpEQC+AlaWg6magcqYuKS+UCoVvGZW9XwmVXxmyhCuhmAQ68OhF+tN9wRxu/+Qcp7MAeN1maBCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17DH+FACxtBUjG0aRBRY5QO3Yy+CPJv/RPUxO07wfbw=;
 b=EbaBXWoX+xIvJ8M3N6Ty1nstlU8K0EXolzfxpBCm18ACHckSF1duy6TUljMbsbGnZW8APWjfirKqjGzkppcap9V9cex4QO4UFv0wOMfTe3/ru5aj237ka9Pwlmr2ZzUXlBFrw8X6pJYQbidAjg5dp9nrtlSWgx1KO+F+W6GYLAGNaGxWJ90aralokO3f4AEkc+pKsAd75kS/H4+f2DSHztCzAdczn2bIVKlxJRrSsQwVSVx05d07sw7e4xLRfdd6c+ip43/6WM9hZJjJ1iWidL+Qip/2P6PBZ5S3VHUXH5JPNelAzsuK65JKoqecrr+yDk8d9WkYrdN38RWyNqT2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17DH+FACxtBUjG0aRBRY5QO3Yy+CPJv/RPUxO07wfbw=;
 b=JeHnML7CPVZOkj7PTXkZubyBswzWO6hmfTYznPJt0W/k0DgK5VPBEZqbzhAIGn9sT/sKkM6myntNKNdFqbgQmATbHhDqQ+S3Db09sqOn2LEerlzbSv9q67x6hE5X8ppMFTEV2ePaySH517/aHtEuhOAs+b4aA2MdUoNHq6QHaZ8=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB8051.eurprd04.prod.outlook.com (2603:10a6:20b:241::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 10:43:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 10:43:23 +0000
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
Subject: RE: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet handling
 helpers
Thread-Topic: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet handling
 helpers
Thread-Index: AQHa0u8kOu4ES77dZ0Cm4ZtFMjqv/rHxV4Mg
Date: Thu, 11 Jul 2024 10:43:23 +0000
Message-ID:
 <PAXPR04MB8459E1ED6375ECE89C8471AE88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-3-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-3-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB8051:EE_
x-ms-office365-filtering-correlation-id: 851b47ab-c579-4f15-aec8-08dca19649d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NeWy655dBJFSR8H5mW1tXLhhiii+Xhe6W7zMcucJCne1x17V2mqFs98mWOcK?=
 =?us-ascii?Q?CN0rmSRdB3kD36y3k09HtTXlSs8BFj1mtulktE+LWFSzHtiBIGjOVzRQ2zTS?=
 =?us-ascii?Q?gh7gZIIsh1P9J3wVL+1/NImlyMl7K0wEZWxc2fMQ0MijThZ2njWh9ks5V9kr?=
 =?us-ascii?Q?2GtNPnw64V+i4hYdc3qvxOzU1V9C77q506zICMZWwZ8FnyiBLBnPa6RwwAGc?=
 =?us-ascii?Q?K7Z2JdqFps5UZogNJNcqylscd+RKkHzj07Bk+VQxni1jRLdlrJEFTR7U4vt7?=
 =?us-ascii?Q?JNaMC4vQ1B8EvzkK3EkyrGa3f0TSnU0nzlx/6q33zMy5DYz6i/7mxgK4Htlb?=
 =?us-ascii?Q?0OM+fZyjhxlFeCM94MMKM8GicsqnMNIC1s/DxfXQ/REv8q/bVUoN1IQllxAQ?=
 =?us-ascii?Q?MvdVTi0Oj2hFJQBbd8iTmuOszgYLaTMA9CNqEWURLQqepU6yh+R2mT6ki4nT?=
 =?us-ascii?Q?zwh4BCww7WgUI/Csv2PmQiJ79IZ0/SFK7LnzD/REZVUOh17Po6ZpSaghsYG+?=
 =?us-ascii?Q?O7PvZIFs6pA0bgz/RKnd7A5LbAXjS1CUqohAb0toMn3FRnZ8nIcE8W0+iIdn?=
 =?us-ascii?Q?aobLyA2mZ+4ffOyXaCHamMVBm0wMhN/A+qZuSWAwjTZcWCBWzBV0hTdZKJ8Z?=
 =?us-ascii?Q?KWcDZTRpAsygpX5xrWq1DRrcDaHwfce4cB+5tkudXyiM3xiCfuwS+IgdXCbW?=
 =?us-ascii?Q?2KUmxEdNkxVqQg0KPyMs/IuF+w0XO40R9ZqyQ++Py2u4NAvjQnswg2lsCYaL?=
 =?us-ascii?Q?Iv4JvrRN/cfoNDTt/nNp9eR5KpESXfGl007xk0txR9JXAA3U5nOSZ5ufzwur?=
 =?us-ascii?Q?u4vdmg15GPvWzZ8fA2FK5qCDVViIn2QHWzrvBVEeiswl0xhvS76m2s/WHRQe?=
 =?us-ascii?Q?PkThR3Zjf+jrDa0yzIk309WViLefrK+iDxCXiQjCAMRLSN0+Y+hrQGR2F0lz?=
 =?us-ascii?Q?UpHFX9JPY2UlFK4oxPyRow5PYkfCDN0d9zKMPWu7vM0fhf3trMovZEBkRxU+?=
 =?us-ascii?Q?qBk/4qMB5oBoGIdj+9o+POdDySnFHHfgX002eAzrKFJj2SrIH3W07JHFcHng?=
 =?us-ascii?Q?chlYbPSjP8IKF+I8ifb/G/I31lpxtYNHe/xIEn9pPnUqtpz90Yt8aLs6pNXp?=
 =?us-ascii?Q?/AVZJqeo+6zgSxgqWmcIlon4E9tWJpYlzJqe/v8pBtcsnp3ax2DmiaJagu0q?=
 =?us-ascii?Q?REXfNYxOf8GS0iQmqrUir7leVimewFH/vYse+ga9dj55KrC1U6HRCj7GA1c0?=
 =?us-ascii?Q?9MQ1rq6PzfPLcxlcpptpm9D01Q840x0FHsSZc59TNR+4aC5G2/nlrCj9CyRb?=
 =?us-ascii?Q?BhV9B74HCDM6G17M5UMn3qlf8w3YBQNJJ2OEHjawiRpP3UOQXgWCPglp9F+F?=
 =?us-ascii?Q?jVJE5z5Z11BnnPWkxd9qI533WObRXqMWDXhTgPdtJiMj4OX5TA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZHdduD8EFs6els/soyMk8QJ85O/505S3SsFHcrRLxGaRUroYzehACnGqNbWv?=
 =?us-ascii?Q?vVdidiOmU2BqbNuaHv9AA79Bf815tf53c8e0SJdUhfa81SCHFrABB2nvE+P5?=
 =?us-ascii?Q?YUY2ZFtFJoH1LaZYngUimOrHw7SSXoHSx7OCiSk68lsF8dMmrhzp0QFfTlHK?=
 =?us-ascii?Q?YdcitQ6dOINi2sV1Ljggp+kW6TdeICfCyPyD1BYHm3EQq0SrkmhbURIybCpN?=
 =?us-ascii?Q?NIGo1v1UKo+FgU9cR1iqX9Up7l+MWdR/qZS+SritDrx7GXRsw+nRtSeEEKpx?=
 =?us-ascii?Q?jalWKAVJ2SbD7sYG1O9pqLENmLQzbPRgzT+ERwi9Cf8zyQogHIYIxNjCh2/Q?=
 =?us-ascii?Q?b3/834RpdD7Z4kZm1bKBO/PL+E/zoseXhrbhC7BO8c/9dZ58w1w1Zbzm7Ofr?=
 =?us-ascii?Q?cxtwHWyzG6M0YGZOBqUAoFm0R9UD5+FLPhCkeyOVnGSa+39BGiL9+7p/ICgA?=
 =?us-ascii?Q?4ZYGdogmwIBV+Rwjyt/xnnPIB26nUq8/ieWnXE8MVcjpVyfT87Q6HQE2kayQ?=
 =?us-ascii?Q?R01Vi3KQNxfe1mvujLgN0WlmnBTWaXVAvO2+NMTrFRqKNCXCU+MLKuKklDBE?=
 =?us-ascii?Q?7oURxVcI961XFVeW5/kn8B9T/tlxx0ZjIJDcJ1k53n9UHX93YOmKUaqESX7z?=
 =?us-ascii?Q?kmhmPw0LKwQxvbrVICJaB6xXTzPn2kUfkyMhlK54f4yRoQDDq6PjlDappIik?=
 =?us-ascii?Q?DwOWCmJw/C15NdckqAPWh06VNP0w3OZ2tJwvrjrLoXq9StpqlSCV0boh7Ll0?=
 =?us-ascii?Q?VxkC//26hn0ElrbXiERGSmS3AQyylL1L0swRNXFCcH9N6HnKKQ8lwMc0g+q8?=
 =?us-ascii?Q?E4sE8heB7HmUsFNYFXTeTV08WQrny46miN7Jo4VBx4Yhm5VhERo6JdSxmDd4?=
 =?us-ascii?Q?n6MR7Gr2/FxwbsYJcPpjwojBlxDiIve53AD58a3fWVPDzhBGLMKip2a3RIDU?=
 =?us-ascii?Q?IUzyebEqxIzKJnDdY5mKfGUQ544dDw00TvCVvPyV5/xWHvIijgjZuCP/fmdK?=
 =?us-ascii?Q?qmSr/hKtHRfDo2PjgpaXmzsBgTYxBIKJ+VcwxHKQnSA5J1P6Um/DcF+Xdrma?=
 =?us-ascii?Q?yMWsVmYRAx+rlY6/vDMyujWb2Vpt7gBbWKXs3Tk1zn8VLxnUaHVVvYSLQhS9?=
 =?us-ascii?Q?K1wCksrlpHXnYKbVkGrnNIPHyHRhA0Rtl34zwaUlF1ttaYW28/gHv3Zhqg7o?=
 =?us-ascii?Q?tfgTfAabZpeDXQpmT32kfoM/jDBdGeCWpEASlrQDjbrNY8yYLolKTYTYziep?=
 =?us-ascii?Q?x5a+rCR3V1EFnwZgYxB8qmaTrJFFG7i0JUnOM0eIjDjO5UwhL08fy3l354r5?=
 =?us-ascii?Q?l6ux/J0hDecY17BiYQTv6G6iRbieBtFFgPNroZXABO4RET9u9OGH2FtD7fwZ?=
 =?us-ascii?Q?L8hA0CvJxySg4wD5tilLbJXhir1FVatUCpqsJDyZ2ZDSB37B4WBcPl43PYG4?=
 =?us-ascii?Q?SJC1CRsXWkrkSCpsYqyTu1b/Oj3ff/x0Za9SZDAQsb19RBV012z/S7dqgBWq?=
 =?us-ascii?Q?8qKgStpvcVwj5fWnKXtsP/9htQ1Uu32R5Bux1iGxkQVN4J+MQBbCfIkBi08l?=
 =?us-ascii?Q?2543UEZslThHJIGQ7vo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b47ab-c579-4f15-aec8-08dca19649d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 10:43:23.5356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBYI7dFatD5yNej3YzqLoNoX6DXmakK6zVTEXKXOKMyLTT6js6bgHZNmpzkKbc1nbX5nOWbv2qkaeI+1NZp73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8051

> Subject: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet
> handling helpers
>=20
> Introduce a pair of structures initialized to contain all the existing
> packet handling helpers, both for transports based on shared memory
> and messages.
>=20
> No functional change.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - fixed commit message
> ---
......

> d33a704e5814..f4ba38afe0bb 100644
> --- a/drivers/firmware/arm_scmi/msg.c
> +++ b/drivers/firmware/arm_scmi/msg.c
> @@ -4,8 +4,8 @@
>   *
>   * Derived from shm.c.
>   *
> - * Copyright (C) 2019-2021 ARM Ltd.
> - * Copyright (C) 2020-2021 OpenSynergy GmbH
> + * Copyright (C) 2019-2024 ARM Ltd.
> + * Copyright (C) 2020-2024 OpenSynergy GmbH

Nitpick: OpenSynergy year should be kept unchanged?

Otherwise looks good:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

