Return-Path: <linux-kernel+bounces-293174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E63957B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DC7B2294A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2236446D1;
	Tue, 20 Aug 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ngT5ftM+"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E01C6B4;
	Tue, 20 Aug 2024 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122150; cv=fail; b=JODtoZoPM8WSUmHg22LkUGPeeUmVL0+zIqOVsRYIXBdLqXD779qivkqGpBGx2gEi9sloPByomFu+BYmIo8SY3wxQAo0i+GyHiSBXGg1O7hFgxBJ71LUvBlimBSfzm/2MY68keyt5fjghSNhXSX10m47TSxnGAMvS6QT8k5ardt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122150; c=relaxed/simple;
	bh=YtmyVRiQPaEbwH2PTI36o5d1W7WNOohrTE6dw6EWoKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a89RdCiUVFHSROGyer/f8zg+oL7Bo1AP1g8pM/ql8VOGVI9hCFJwnH4Wt0kC20Zito0fWZxFt0s0UQ3rqTcA4x+IopALV8g91JHcERQa5QHTxLvpwR+gVL4x9ch9tedcrC68THQcv024ORxpIa3VtD+xqW8U3LU+UEe5UvOnfMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ngT5ftM+; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg72UcBAFWJx6AnkbOKctBlKcjm1h6NTvorWJTsWgkH9ZninN6tbgVnew8PHmmue/5RG40p9QV3m3bc/ASV7G8dpBTwP7J1HEzGc/SgDbksYGkg1rVKeQN1oVWlpPjVQmCQtIdEsfYJeJnMjGSDaACL6X7m6RJbK9QPOxjHRS8io3o64WFAAFiNBWAdBu7PK3atBH6MVRPCof+vhKjNdQTeec/GocHfpL6jubzAQmveh43hmBZfQgfFxaEzN4RxuI3UThWK55MxveqtAsg4tmUr6xyzodp8Kgmbe1uFEy6jzcS4sjFE0xHJEXzvtZ8kJ9MB94T2llDKDyFp1qbEYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e4okeiKHlg+OUXQu/gvUOgv4Z1Iz9h5yV+J2nvZcjA=;
 b=cuXHWFzPfCsRm4DNFJTsyUrt+UT6hhFrekuh8gJuzPqiQwN6I6lK34JFYzKv1y2xNN6lpTFnIQIdIdwNrqm57zlWZ31Z5ThgTOfpqfZRmMz/qz2/LoWIwJDohaYymStWdHpN2RzUH4vV71/YjfY4ucqh1/2TKQGYBvHjrCM9Aqb0Iy1irL6HxP1CQqA4XmQPA2wq4nscXvrZcVNJVnXDCQsAOJNCoJR6F+aMWgMmsAxPSm2LQ6wwtE3CB19dQs5m02nZrQ5ZmtYiUV85rC0wlZZG4z9vC/v5285ht7pRYtuB69d0IRBlNaeRPgL99w/XA5x86IefcVgkEAO3FVhkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e4okeiKHlg+OUXQu/gvUOgv4Z1Iz9h5yV+J2nvZcjA=;
 b=ngT5ftM+7DB0/1wA3GDjVhzvKwRI4R+5JGD1mAvzLYIn8O9SLOI/np/OFN6D46lSWS+BzjRz0HX7zYLnsFhyIgNNxEbHwwrYUx2AnHPJ4d8gJ5l0kMGVlTztGuDxr4rBBTzzS7HVdhfaSBTzpBF+WoajGVqhqS0kKTveIXFWYK0ndc8U62gy9SpxREbIZMLldBc1kEKL85goX66VpnY4Xas7uB7Aa/mlsagIZI4/nGmkclF73umzsMFbjSqFZBTefQagN9wC6y5jkP5PLPpz7veb19Exx2Lh/7Hajpn64UmG0ZGxFh5EuVKFYWiSBgbvQ5fkuUj4nJVYj9NzlWhoXQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10930.eurprd04.prod.outlook.com (2603:10a6:800:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 02:49:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:49:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:SYSTEM CONTROL & POWER/MANAGEMENT
 INTERFACE" <arm-scmi@vger.kernel.org>, "justin.chen@broadcom.com"
	<justin.chen@broadcom.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kapil.hali@broadcom.com" <kapil.hali@broadcom.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>
Subject: RE: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Thread-Topic: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Thread-Index: AQHa8C2aCnkHs0PaIkOBOegG7uwPcbIvc2GQ
Date: Tue, 20 Aug 2024 02:49:02 +0000
Message-ID:
 <PAXPR04MB8459322CED779885532BD852888D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
 <20240816224221.3256455-3-florian.fainelli@broadcom.com>
In-Reply-To: <20240816224221.3256455-3-florian.fainelli@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI2PR04MB10930:EE_
x-ms-office365-filtering-correlation-id: 730280f2-192c-49fb-4bf4-08dcc0c2a63c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GF9EVi3U3MvjxV/FNXZD55vYciFp732bnlWOY4cI+CwsGgPZtWsDkC6mKwO/?=
 =?us-ascii?Q?b2fvSTJQdqScTuHNMIq8JUeXZAdw2N6gA3PO6ygufBHMXpGX9grA4QpwOzUJ?=
 =?us-ascii?Q?rUZAaB8PE6dnIvXkDS2493cgO0knaWgmE8kms7XLcbhphsg548llHlVrpSOy?=
 =?us-ascii?Q?uCCnwAg4GaPhyHfcpaQeHJNpCfNH9+3NEZyxrkC5xtYmYX5Iqd8b0iCqiH/+?=
 =?us-ascii?Q?/E7IwbwsmuMAr22xcxcVODx4S/mhB5ur4Gj5OaY66oA1its1B252UnnGiyU9?=
 =?us-ascii?Q?SoEoIAsscgdDhKCagicJ58k6hOB0WlK9EptnnMPb81rIlcduM/fRGC68fu9W?=
 =?us-ascii?Q?m4Zu5OXkTJoTf9iJdtDPD1gsBUoStdgJWTvdkoLSV6zpCljneUxg1X12BNXp?=
 =?us-ascii?Q?HJlsY0h/gIZWBlZ7gcBXpO9iDuB1qJnmXo2oDHR8mFUGy/+TG9+5DGYAt9D+?=
 =?us-ascii?Q?Tmb8OxXnD2KHbDFh59FB7gCJoGQJ6eYMwbczS7fpj3cEIU4AR97ecWprLmZ7?=
 =?us-ascii?Q?G6aGVWfJxU709ieSxxz6TubHxReXBnWXo0aYEvAvMbz3efmnQu+J8aQJALF8?=
 =?us-ascii?Q?G7drwH7vIg9cFOCRyriU2pCjaxudbBnq3jnDJJMTiTCUIOg629RHyVzE4xxU?=
 =?us-ascii?Q?FMAl6NC+LOo2l9SeN7u7OWKAB533SL5Zll9fDoVsyqR4eybMv7udBRyi1e/q?=
 =?us-ascii?Q?wH6ZwnKuTBIlJyngthKWDQtrzD1q8QUI2POZqgdPP2wcs0UQW+GP7BOiut5q?=
 =?us-ascii?Q?iqEXETzLjXqvmZ9kLpDxRdAs7JtH4xKsgX19nY9F1XBRxsQXUlUPrjsOjhCM?=
 =?us-ascii?Q?9WEcRKM3N2TILm5XOnAU/gSsnCSaokGVnFldMdGZYwgsW4rzYlsD2/DmSkuE?=
 =?us-ascii?Q?DeO8Cu65Vic6pmag/tySjrzeDU2a3aNaRDeW+26h1syzdiFlNzr5SKH23Fj+?=
 =?us-ascii?Q?TMDtI9iPmwp1rGPeK9IuOBtc/4gDfcM8npUanpbqlYkpOv6xF5BsCSPwnUZ4?=
 =?us-ascii?Q?7wOSxxCY5E/pnkauEwC/l7gVRitIEHcg1Q4Y1L7KUybzzJ+GAcZymih6nfUX?=
 =?us-ascii?Q?qGh1P8B29a5n/wT+Jqt2BjedaHciYXWSj7EsLK9RN8LQYrjeS0ngV8TN1kJp?=
 =?us-ascii?Q?kdY1YXBfjW4L+e9eYF1jS5Qj1bMRzz8RvMJQKKtV3r0bOs7u1Q3KMcW3agVi?=
 =?us-ascii?Q?VOu5o695WX81dsLhKRW0hCbF9KmAetsWJsBZC0CRjiQvan+oZgBrt9qtA5Ed?=
 =?us-ascii?Q?tiKDGYP4Q2USv2GDOJBDnrnip9dWgvlKxKRQqNJbJyVkx9nAp/q020tJ30Di?=
 =?us-ascii?Q?IBwk9ErMU+yDbrmKLAPQwOPj4TnBCKJAiz992cJ27NO0xOkJeQOVckiuWX4d?=
 =?us-ascii?Q?BBIuaJ2tYHpkJiMYIVjhS4Yz05Lj5aD4SNvfrmae6FTAA+ol3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RCkCZcUfe7hvT0+UMxxqZzRqBkRny4G+AwbMbU8snEWTh9+TmQ3AxLVxs/hf?=
 =?us-ascii?Q?si55cJTSJy+6D1cZAxBX2k0zv4+y/858Nn0ezuSXX61rLTIRlnemX44KcJAc?=
 =?us-ascii?Q?/8pvXZn+ARDejj13f4pnKZJBwUWETDFytJfj0F+n47xrscVr2pddIYkub5dO?=
 =?us-ascii?Q?1LBFHetodYWGPAjipQkOUui3hsRCSXlR2hPc0ypzfAAbx8LmHBp5/ndsh3UJ?=
 =?us-ascii?Q?v4K5/cKyK2zL7Mv2idEUDoqJ1/aAXtVA4L5g8ViNXDcpTgN0pCkn0eEQW/Ml?=
 =?us-ascii?Q?bsiIs/GzfJhTfyy7mhod3umML+FAFE88rlpYdPjU2FFEC5wBMJQO5iFLeByP?=
 =?us-ascii?Q?XefueZirT3A+sAg7JmN8vzDzVIvuAIeWxWrQuRSwHQPmkoNTrKgSijvae+on?=
 =?us-ascii?Q?Bb13kFH5eY7BprWPE5jsL8LhgjGuV1Vk4qA4QTcBn5jSdTb0IOhBsC+XBies?=
 =?us-ascii?Q?b101o14TJF4OKDL9Cs8S3DA6XJ5UQkVCq5Fn53z65TVOwf1IahTis+3W/Ypa?=
 =?us-ascii?Q?cdRRd69DrKNeRtG88u1milTOUVZ/upK+L6mxLkyEKli7Q/MA5/B7eUNeaGtN?=
 =?us-ascii?Q?Tq/ARsylN9/L3YhegDrouEzHggRhuln1nzAhSmz5DkbxfAvJTWEG1ZOmpTaJ?=
 =?us-ascii?Q?WOmM0Tiqr9OTN/hQYDo7x/HGMAk6Gu8BDgLg7i6o5PYj9LltEHWMZQcSIFPr?=
 =?us-ascii?Q?IYP3arMux7AoYIz28tneLgbD0VzGZXItHcnixtGKLXoOwogqTQdnp7OdfAHF?=
 =?us-ascii?Q?kQWge89xeJqXIXRrV1jd2QyHrv22a/WzdRBzfM63eQACyeODGTGG28/Gsnsy?=
 =?us-ascii?Q?+o9mQ+9xYouBE4z/cvCDizbLiCXTLEgh1EcTcx9t7QvLEXvYQXeOc4Evim/4?=
 =?us-ascii?Q?ZdaRBpY7bK0JQnxFzvmUPuUkHXxDX7/JuizLROfyx/fA26AuCtRIWybFOFhq?=
 =?us-ascii?Q?gI95x1E1qXIL0QGdZZc7BzZAC36PjNTPBCxS2g7rRDPF9Q5RMuqTMDLATt3y?=
 =?us-ascii?Q?u8RB4OoVdE+gA8voxERsHBU2OEdmoUoP4Rw8drJDk3tYPymCnUVTViz5+5IM?=
 =?us-ascii?Q?OVZBf4I2fb9I2rE0HOlpDQoZ/GGE1pvujDg8+7utIbJghwHAC/Aq7Ng41GNr?=
 =?us-ascii?Q?KrME224scxcb9R2euDGW2BjomgOPqMGg1ReqmguvvQoSc0m1TJt8MLKE4rG2?=
 =?us-ascii?Q?jvRC8Ob5B3KCI2fEVMVQu2muJ75hfYkq8Fuo0GYdByM8m2wEuCv83XRGUabx?=
 =?us-ascii?Q?gt5BhpnJ1LkB7+SHudogZ54FRhICV1He2SmMFLOmrVtdUeX+8B4LXVz9sFoF?=
 =?us-ascii?Q?ax2Jvc6QV7MFcI+T61jxHCan4RNe9EGmyl8QZIl9dwg6ScoD4ZMkArju2j5c?=
 =?us-ascii?Q?6VdTwGQQsWq7c7o/8bci0QVmdJFKQkiR31Nvyt4cTgup+ACrZFIErUCBf5A5?=
 =?us-ascii?Q?25BSMvezwd18yyrlRNd8MHMLzsDNzZFPf8nBF7rKrLriuYRl67vDLU1seBj7?=
 =?us-ascii?Q?i518eKFVh8UGUOAEr+rtbwEEV7r9/0V+VxMPpc3vzyRC1JzkYnFJfl4Me8eQ?=
 =?us-ascii?Q?GMuFHe3Nc+0BJ9uaM3Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 730280f2-192c-49fb-4bf4-08dcc0c2a63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 02:49:02.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWDh76d2/6Kj1C0mP4knx2tlWcLUNGc8JFAnIYoB9Vv6fuf+14wDoTG6TtZucrnKjYq+33VJYJvi2W620OFJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10930

> Subject: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
> property for shared memory
>=20
> Some shared memory areas might only support a certain access width,
> such as 32-bit, which memcpy_{from,to}_io() does not adhere to at
> least on ARM64 by making both 8-bit and 64-bit accesses to such
> memory.
>=20
> Update the shmem layer to support reading from and writing to such
> shared memory area using the specified I/O width in the Device Tree.
> The various transport layers making use of the shmem.c code are
> updated accordingly to pass the I/O accessors that they store.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/firmware/arm_scmi/common.h            | 32 ++++++-
>  .../arm_scmi/scmi_transport_mailbox.c         | 13 ++-
>  .../firmware/arm_scmi/scmi_transport_optee.c  | 11 ++-
>  .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
>  drivers/firmware/arm_scmi/shmem.c             | 86 +++++++++++++++++-
> -
>  5 files changed, 132 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/common.h
> b/drivers/firmware/arm_scmi/common.h
> index 69928bbd01c2..73bb496fac01 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -316,6 +316,26 @@ enum scmi_bad_msg {
>  	MSG_MBOX_SPURIOUS =3D -5,
>  };
>=20
> +/* Used for compactness and signature validation of the function
> +pointers being
> + * passed.
> + */
> +typedef void (*shmem_copy_toio_t)(volatile void __iomem *to, const
> void *from,
> +				  size_t count);
> +typedef void (*shmem_copy_fromio_t)(void *to, const volatile void
> __iomem *from,
> +				    size_t count);
> +
> +/**
> + * struct scmi_shmem_io_ops  - I/O operations to read from/write to
> + * Shared Memory
> + *
> + * @toio: Copy data to the shared memory area
> + * @fromio: Copy data from the shared memory area  */ struct
> +scmi_shmem_io_ops {
> +	shmem_copy_fromio_t fromio;
> +	shmem_copy_toio_t toio;
> +};
> +
>  /* shmem related declarations */
>  struct scmi_shared_mem;
>=20
> @@ -336,13 +356,16 @@ struct scmi_shared_mem;  struct
> scmi_shared_mem_operations {
>  	void (*tx_prepare)(struct scmi_shared_mem __iomem
> *shmem,
>  			   struct scmi_xfer *xfer,
> -			   struct scmi_chan_info *cinfo);
> +			   struct scmi_chan_info *cinfo,
> +			   shmem_copy_toio_t toio);
>  	u32 (*read_header)(struct scmi_shared_mem __iomem
> *shmem);
>=20
>  	void (*fetch_response)(struct scmi_shared_mem __iomem
> *shmem,
> -			       struct scmi_xfer *xfer);
> +			       struct scmi_xfer *xfer,
> +			       shmem_copy_fromio_t fromio);
>  	void (*fetch_notification)(struct scmi_shared_mem __iomem
> *shmem,
> -				   size_t max_len, struct scmi_xfer
> *xfer);
> +				   size_t max_len, struct scmi_xfer
> *xfer,
> +				   shmem_copy_fromio_t fromio);
>  	void (*clear_channel)(struct scmi_shared_mem __iomem
> *shmem);
>  	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
>  			  struct scmi_xfer *xfer);
> @@ -350,7 +373,8 @@ struct scmi_shared_mem_operations {
>  	bool (*channel_intr_enabled)(struct scmi_shared_mem
> __iomem *shmem);
>  	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
>  				     struct device *dev,
> -				     bool tx, struct resource *res);
> +				     bool tx, struct resource *res,
> +				     struct scmi_shmem_io_ops **ops);
>  };
>=20
>  const struct scmi_shared_mem_operations
> *scmi_shared_mem_operations_get(void);
> diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> index dc5ca894d5eb..1a2e90e5c765 100644
> --- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> @@ -25,6 +25,7 @@
>   * @chan_platform_receiver: Optional Platform Receiver mailbox
> unidirectional channel
>   * @cinfo: SCMI channel info
>   * @shmem: Transmit/Receive shared memory area
> + * @io_ops: Transport specific I/O operations
>   */
>  struct scmi_mailbox {
>  	struct mbox_client cl;
> @@ -33,6 +34,7 @@ struct scmi_mailbox {
>  	struct mbox_chan *chan_platform_receiver;
>  	struct scmi_chan_info *cinfo;
>  	struct scmi_shared_mem __iomem *shmem;
> +	struct scmi_shmem_io_ops *io_ops;
>  };
>=20
>  #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox,
> cl) @@ -43,7 +45,8 @@ static void tx_prepare(struct mbox_client *cl,
> void *m)  {
>  	struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
>=20
> -	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
> +	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
> +				smbox->io_ops->toio);
>  }
>=20
>  static void rx_callback(struct mbox_client *cl, void *m) @@ -197,7
> +200,8 @@ static int mailbox_chan_setup(struct scmi_chan_info
> *cinfo, struct device *dev,
>  	if (!smbox)
>  		return -ENOMEM;
>=20
> -	smbox->shmem =3D core->shmem->setup_iomap(cinfo, dev, tx,
> NULL);
> +	smbox->shmem =3D core->shmem->setup_iomap(cinfo, dev, tx,
> NULL,
> +						&smbox->io_ops);
>  	if (IS_ERR(smbox->shmem))
>  		return PTR_ERR(smbox->shmem);
>=20
> @@ -298,7 +302,7 @@ static void mailbox_fetch_response(struct
> scmi_chan_info *cinfo,  {
>  	struct scmi_mailbox *smbox =3D cinfo->transport_info;
>=20
> -	core->shmem->fetch_response(smbox->shmem, xfer);
> +	core->shmem->fetch_response(smbox->shmem, xfer,
> +smbox->io_ops->fromio);
>  }
>=20
>  static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
> @@ -306,7 +310,8 @@ static void mailbox_fetch_notification(struct
> scmi_chan_info *cinfo,  {
>  	struct scmi_mailbox *smbox =3D cinfo->transport_info;
>=20
> -	core->shmem->fetch_notification(smbox->shmem, max_len,
> xfer);
> +	core->shmem->fetch_notification(smbox->shmem, max_len,
> xfer,
> +					smbox->io_ops->fromio);
>  }
>=20
>  static void mailbox_clear_channel(struct scmi_chan_info *cinfo) diff --
> git a/drivers/firmware/arm_scmi/scmi_transport_optee.c
> b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> index 08911f40d1ff..2be4124c6826 100644
> --- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> @@ -114,6 +114,7 @@ enum scmi_optee_pta_cmd {
>   * @req.shmem: Virtual base address of the shared memory
>   * @req.msg: Shared memory protocol handle for SCMI request and
>   *   synchronous response
> + * @io_ops: Transport specific I/O operations
>   * @tee_shm: TEE shared memory handle @req or NULL if using
> IOMEM shmem
>   * @link: Reference in agent's channel list
>   */
> @@ -128,6 +129,7 @@ struct scmi_optee_channel {
>  		struct scmi_shared_mem __iomem *shmem;
>  		struct scmi_msg_payld *msg;
>  	} req;
> +	struct scmi_shmem_io_ops *io_ops;
>  	struct tee_shm *tee_shm;
>  	struct list_head link;
>  };
> @@ -350,7 +352,8 @@ static int setup_dynamic_shmem(struct device
> *dev, struct scmi_optee_channel *ch  static int
> setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>  			      struct scmi_optee_channel *channel)  {
> -	channel->req.shmem =3D core->shmem->setup_iomap(cinfo, dev,
> true, NULL);
> +	channel->req.shmem =3D core->shmem->setup_iomap(cinfo, dev,
> true, NULL,
> +						      &channel-
> >io_ops);
>  	if (IS_ERR(channel->req.shmem))
>  		return PTR_ERR(channel->req.shmem);
>=20
> @@ -465,7 +468,8 @@ static int scmi_optee_send_message(struct
> scmi_chan_info *cinfo,
>  		ret =3D invoke_process_msg_channel(channel,
>  						 core->msg-
> >command_size(xfer));
>  	} else {
> -		core->shmem->tx_prepare(channel->req.shmem, xfer,
> cinfo);
> +		core->shmem->tx_prepare(channel->req.shmem, xfer,
> cinfo,
> +					channel->io_ops->toio);
>  		ret =3D invoke_process_smt_channel(channel);
>  	}
>=20
> @@ -484,7 +488,8 @@ static void scmi_optee_fetch_response(struct
> scmi_chan_info *cinfo,
>  		core->msg->fetch_response(channel->req.msg,
>  					  channel->rx_len, xfer);
>  	else
> -		core->shmem->fetch_response(channel->req.shmem,
> xfer);
> +		core->shmem->fetch_response(channel->req.shmem,
> xfer,
> +					    channel->io_ops->fromio);
>  }
>=20
>  static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int
> ret, diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c
> b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> index c6c69a17a9cc..04e715ec1570 100644
> --- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> @@ -45,6 +45,7 @@
>   * @irq: An optional IRQ for completion
>   * @cinfo: SCMI channel info
>   * @shmem: Transmit/Receive shared memory area
> + * @io_ops: Transport specific I/O operations
>   * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
>   *		Used when NOT operating in atomic mode.
>   * @inflight: Atomic flag to protect access to Tx/Rx shared memory
> area.
> @@ -60,6 +61,7 @@ struct scmi_smc {
>  	int irq;
>  	struct scmi_chan_info *cinfo;
>  	struct scmi_shared_mem __iomem *shmem;
> +	struct scmi_shmem_io_ops *io_ops;
>  	/* Protect access to shmem area */
>  	struct mutex shmem_lock;
>  #define INFLIGHT_NONE	MSG_TOKEN_MAX
> @@ -144,7 +146,8 @@ static int smc_chan_setup(struct
> scmi_chan_info *cinfo, struct device *dev,
>  	if (!scmi_info)
>  		return -ENOMEM;
>=20
> -	scmi_info->shmem =3D core->shmem->setup_iomap(cinfo, dev,
> tx, &res);
> +	scmi_info->shmem =3D core->shmem->setup_iomap(cinfo, dev,
> tx, &res,
> +						    &scmi_info-
> >io_ops);
>  	if (IS_ERR(scmi_info->shmem))
>  		return PTR_ERR(scmi_info->shmem);
>=20
> @@ -229,7 +232,8 @@ static int smc_send_message(struct
> scmi_chan_info *cinfo,
>  	 */
>  	smc_channel_lock_acquire(scmi_info, xfer);
>=20
> -	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
> +				scmi_info->io_ops->toio);
>=20
>  	if (scmi_info->cap_id !=3D ULONG_MAX)
>  		arm_smccc_1_1_invoke(scmi_info->func_id,
> scmi_info->cap_id, 0, @@ -253,7 +257,8 @@ static void
> smc_fetch_response(struct scmi_chan_info *cinfo,  {
>  	struct scmi_smc *scmi_info =3D cinfo->transport_info;
>=20
> -	core->shmem->fetch_response(scmi_info->shmem, xfer);
> +	core->shmem->fetch_response(scmi_info->shmem, xfer,
> +				    scmi_info->io_ops->fromio);
>  }
>=20
>  static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret, diff
> --git a/drivers/firmware/arm_scmi/shmem.c
> b/drivers/firmware/arm_scmi/shmem.c
> index 01d8a9398fe8..aded5f1cd49f 100644
> --- a/drivers/firmware/arm_scmi/shmem.c
> +++ b/drivers/firmware/arm_scmi/shmem.c
> @@ -34,9 +34,67 @@ struct scmi_shared_mem {
>  	u8 msg_payload[];
>  };
>=20
> +static inline void shmem_memcpy_fromio32(void *to,
> +					 const volatile void __iomem
> *from,
> +					 size_t count)
> +{
> +	while (count) {
> +		*(u32 *)to =3D __raw_readl(from);
> +		from +=3D 4;
> +		to +=3D 4;
> +		count -=3D 4;

This may not have issue, considering the 'count % 4' will be 0
and 'from' is 4 bytes aligned.

But I think it maybe better to add check if 'count' and 'from'
are not 4 bytes aligned.=20

> +	}
> +
> +	/* Ensure all reads from I/O have completed */
> +	rmb();

Is there a need to use rmb here? I am not sure, just wonder.

> +}
> +
> +static inline void shmem_memcpy_toio32(volatile void __iomem *to,
> +				       const void *from,
> +				       size_t count)
> +{
> +	while (count) {
> +		__raw_writel(*(u32 *)from, to);
> +		from +=3D 4;
> +		to +=3D 4;
> +		count -=3D 4;
> +	}

Ditto.

> +
> +	/* Ensure all writes to I/O have completed */
> +	wmb();

This maybe not needed.=20
The mailbox will use "writel", the SMC will use "smc",
the virtio will have "hvc", both will have barrier I think.

Regards,
Peng.


> +}
> +
> +static struct scmi_shmem_io_ops shmem_io_ops32 =3D {
> +	.fromio	=3D shmem_memcpy_fromio32,
> +	.toio	=3D shmem_memcpy_toio32,
> +};
> +
> +/* Wrappers are needed for proper memcpy_{from,to}_io expansion
> by the
> + * pre-processor.
> + */
> +static inline void shmem_memcpy_fromio(void *to,
> +				       const volatile void __iomem
> *from,
> +				       size_t count)
> +{
> +	memcpy_fromio(to, from, count);
> +}
> +
> +static inline void shmem_memcpy_toio(volatile void __iomem *to,
> +				     const void *from,
> +				     size_t count)
> +{
> +	memcpy_toio(to, from, count);
> +}
> +
> +static struct scmi_shmem_io_ops shmem_io_ops_default =3D {
> +	.fromio =3D shmem_memcpy_fromio,
> +	.toio	=3D shmem_memcpy_toio,
> +};
> +
>  static void shmem_tx_prepare(struct scmi_shared_mem __iomem
> *shmem,
>  			     struct scmi_xfer *xfer,
> -			     struct scmi_chan_info *cinfo)
> +			     struct scmi_chan_info *cinfo,
> +			     shmem_copy_toio_t copy_toio)
>  {
>  	ktime_t stop;
>=20
> @@ -73,7 +131,7 @@ static void shmem_tx_prepare(struct
> scmi_shared_mem __iomem *shmem,
>  	iowrite32(sizeof(shmem->msg_header) + xfer->tx.len,
> &shmem->length);
>  	iowrite32(pack_scmi_header(&xfer->hdr), &shmem-
> >msg_header);
>  	if (xfer->tx.buf)
> -		memcpy_toio(shmem->msg_payload, xfer->tx.buf,
> xfer->tx.len);
> +		copy_toio(shmem->msg_payload, xfer->tx.buf, xfer-
> >tx.len);
>  }
>=20
>  static u32 shmem_read_header(struct scmi_shared_mem __iomem
> *shmem) @@ -82,7 +140,8 @@ static u32 shmem_read_header(struct
> scmi_shared_mem __iomem *shmem)  }
>=20
>  static void shmem_fetch_response(struct scmi_shared_mem __iomem
> *shmem,
> -				 struct scmi_xfer *xfer)
> +				 struct scmi_xfer *xfer,
> +				 shmem_copy_fromio_t copy_fromio)
>  {
>  	size_t len =3D ioread32(&shmem->length);
>=20
> @@ -91,11 +150,12 @@ static void shmem_fetch_response(struct
> scmi_shared_mem __iomem *shmem,
>  	xfer->rx.len =3D min_t(size_t, xfer->rx.len, len > 8 ? len - 8 : 0);
>=20
>  	/* Take a copy to the rx buffer.. */
> -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer-
> >rx.len);
> +	copy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer-
> >rx.len);
>  }
>=20
>  static void shmem_fetch_notification(struct scmi_shared_mem
> __iomem *shmem,
> -				     size_t max_len, struct scmi_xfer
> *xfer)
> +				     size_t max_len, struct scmi_xfer
> *xfer,
> +				     shmem_copy_fromio_t
> copy_fromio)
>  {
>  	size_t len =3D ioread32(&shmem->length);
>=20
> @@ -103,7 +163,7 @@ static void shmem_fetch_notification(struct
> scmi_shared_mem __iomem *shmem,
>  	xfer->rx.len =3D min_t(size_t, max_len, len > 4 ? len - 4 : 0);
>=20
>  	/* Take a copy to the rx buffer.. */
> -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer-
> >rx.len);
> +	copy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
>  }
>=20
>  static void shmem_clear_channel(struct scmi_shared_mem __iomem
> *shmem) @@ -139,7 +199,8 @@ static bool
> shmem_channel_intr_enabled(struct scmi_shared_mem __iomem
> *shmem)
>=20
>  static void __iomem *shmem_setup_iomap(struct scmi_chan_info
> *cinfo,
>  				       struct device *dev, bool tx,
> -				       struct resource *res)
> +				       struct resource *res,
> +				       struct scmi_shmem_io_ops
> **ops)
>  {
>  	struct device_node *shmem __free(device_node);
>  	const char *desc =3D tx ? "Tx" : "Rx";
> @@ -148,6 +209,7 @@ static void __iomem
> *shmem_setup_iomap(struct scmi_chan_info *cinfo,
>  	struct resource lres =3D {};
>  	resource_size_t size;
>  	void __iomem *addr;
> +	u32 reg_io_width;
>=20
>  	shmem =3D of_parse_phandle(cdev->of_node, "shmem", idx);
>  	if (!shmem)
> @@ -173,6 +235,16 @@ static void __iomem
> *shmem_setup_iomap(struct scmi_chan_info *cinfo,
>  		return IOMEM_ERR_PTR(-EADDRNOTAVAIL);
>  	}
>=20
> +	of_property_read_u32(shmem, "reg-io-width", &reg_io_width);
> +	switch (reg_io_width) {
> +	case 4:
> +		*ops =3D &shmem_io_ops32;
> +		break;
> +	default:
> +		*ops =3D &shmem_io_ops_default;
> +		break;
> +	}
> +
>  	return addr;
>  }
>=20
> --
> 2.34.1
>=20


