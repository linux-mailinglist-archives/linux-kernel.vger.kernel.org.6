Return-Path: <linux-kernel+bounces-354359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D22993C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87CF285A9C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481DC18C3E;
	Tue,  8 Oct 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="nnkpuOyP"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CCB14287;
	Tue,  8 Oct 2024 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352232; cv=fail; b=Gr2evEhszBKTfZ5/xoeGccI6awi2sixzndfOnyC0YygbGL5VN9UmIgL/ZhtH8GUSNdXtwHXO307bhPw3LqbtnXjboAljvdHq06OFEKLSMNH7e5joVAPEsOlb4XDMpp1pMRuwbb/yUC7h2dZf9Vl8PXupEsFvQhH3F91D/0JjK5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352232; c=relaxed/simple;
	bh=3eBP/0K1VFLaRw172T6PBRAizJIN4fxdm4nk5QLdxvk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TXBcU1MXuEW4C13Prbsc9PSZmjWQXPlHS/tQ7J57AZHyDbl0TMuLxt9+EZvgIxypvNujiUsuxcVmjX0EHbn6YpWjLtX5LTS6qehkzEALyX9A82BQ1Qtvd2hYEayHV9/RuJqAx+WoYngBPQ7gDEGEjzVeF+dQOiIRsGE7mIzoh0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=nnkpuOyP; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INMYlNgPGobsBP0VQsASp9okTzLxS97zHN15MI+OD/DJaC83W6q9nlm/cy7A5wEtQ4IO3fjVgPNDuzj7jFybTWpg/m7il5mKmAipuneS8I8uxoWWHX9fHdebW+eAhfsB7eJ9LcDh0RCPA0vniddEA3O6JVaSspw/d6Kr/unXjSgfirqvHHOH18xXZQZ+ImvsRjtG+VsGQfkQk8ougbdv7bFnjhUd6IUIRD/wlYlHIQJKgoPNR/JnRlbk8kvWow6bCRanjWmDuSTibc0Y4+lmHnBX7wiRmdEdaphLQPpl1HT6HqhB7/+e9yf2zQAKj8bA6lqaO2oKiC40Aqv0EJZ17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+dM1hXB2RKFzkresFTDVczlKB7+WDbcN19GBbEbLUs=;
 b=JQZJJn2iRUmhPFiMfiSpICANXAl8voHBbpv4LxAeXl6CAquNuihmXpI0EUyXrFrvpY5HlNW68/mdHp8HY+EkNMFtLz25W/ITmnM0cKKdsdCGxAMEJqMaKxPDuhXP013el3d/XTEd+Xxck/pDFpCL9YqY5/cqs5ECURA3hzx25564nvfbWz4V2ZRS13aP1WLSrSzlS8baFPAz74E77y9o4NqGTilGKxoz0Om2q9qRECXbTApzHYaNq/fTHlEb7DY4o6RK8JXBqkBGVb8LXFmnKp+Q5DrZLUWfgsMQa+nqdFMJRvZ2hKQU1nfxnCgfLm0LLNtncv3tPsO65vHdpfSvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+dM1hXB2RKFzkresFTDVczlKB7+WDbcN19GBbEbLUs=;
 b=nnkpuOyPHErlejhR2wOQGSzyW74jKC8HUWp/BiOuUaPjLtarmFbd6/nQyLzZxg4QqZk6RgD29TCA/7ViGwNlFJn0t6FMPwHBOgaDqBwslaqLQJeyTgMwi49K5E6gGO6rWuT7WO5usFoFystbo+YL+iF2+4ZqkfyUL9HrJh2IbIaUqinIz+bmPyeLMGZho7LKStTtfYWrpHnKTy5xZUysjCBWsn5mXRhwr2JBCETBYbde7yhLleJp/UslaTRT8rJEVdnPUDuzgWWnHAa6vL75aixV4OgFvj6lppikeuaJl2mq7pIieAIFRmSwM9dCiP5bLxL638jt1ATwgfxcSdEuGQ==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEYPR06MB6754.apcprd06.prod.outlook.com (2603:1096:101:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Tue, 8 Oct
 2024 01:50:22 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 01:50:22 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 2/2] irqchip/aspeed-intc: Add support for 10 INTC
 interrupts on AST27XX platforms
Thread-Topic: [PATCH v1 2/2] irqchip/aspeed-intc: Add support for 10 INTC
 interrupts on AST27XX platforms
Thread-Index: AQHa7VSHSw8wQLr8FkWU5QCTbIfyFLIk7ZaAgFd5HOA=
Date: Tue, 8 Oct 2024 01:50:22 +0000
Message-ID:
 <PSAPR06MB4949CF3FDD05C1259EE4F11E897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-3-kevin_chen@aspeedtech.com> <87h6borciq.ffs@tglx>
In-Reply-To: <87h6borciq.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEYPR06MB6754:EE_
x-ms-office365-filtering-correlation-id: acadaa68-dc33-47fc-f9d4-08dce73b922e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Zlb4hrPH22eWjENfZjMd7GLaQfup2ljeWo/aB9P4WbfgfYM4Z4OLkJn2PTng?=
 =?us-ascii?Q?hYOKxFRvBRXtPZ5YbV/Hn7Lsgt09whvQSMblEIT+vvIA6UghIK2DuAyBf05h?=
 =?us-ascii?Q?NC/Q4f+UN+WTlstrZeZyjh6COQh5K/2ml/6g146trvw4J+WyWiB0widdpC3B?=
 =?us-ascii?Q?wWMhgK17lHZuTdKcZ6ElYKsNjSDYT5k0l7c8Qop5qOwwa3bVo5SSUXUlPQXY?=
 =?us-ascii?Q?ZYGVYb5joD4xA40iYbXhTZMeDa9LOqhSr8JCHQDMDjcDWwvGUHHTv4St1IFk?=
 =?us-ascii?Q?qzD1hdorGjqg/AydJsdRA3xNx5qBFJ+DKCaf5rJ7s070f7MPcbhpdl4ZOzXZ?=
 =?us-ascii?Q?GxWvqhXNuJ2k53NfWfDRZy9nD6eHrtClcrP0mLbJBeyS7sK8nvrE4ZKxPev+?=
 =?us-ascii?Q?MA5x03d1gWOkWm1sOTrJzUM39UsgDRtVVZJLcfwWDx+Dej1CqkuB05IhWs2p?=
 =?us-ascii?Q?Uixc1P7pwbunaTNn2A9t5O0y2etnTnEwKqvvyKUCyIhvqCsKWb5uhmHbOlN1?=
 =?us-ascii?Q?bdyYRjoMoUnE0idHIshaO+kzAO5VYxz4v9vVbJkgwEzifYikDRlkP8yjSB77?=
 =?us-ascii?Q?IFKi8dlP+XNK4bdo7aoh0oRQAdBOHKGdaN5OOtqkLGtXeZxfIv8tcy0dUEaf?=
 =?us-ascii?Q?553zGuI7IAgLAD2Jx3Z+duUE9RXCUJUIToHS4wHekMrtmD8S2Mu84icHd4UF?=
 =?us-ascii?Q?s+PsEwQ7lBr3WCtU2cHqBUxzHujIYldHmDuYlseVTrDP0Dh5wTGlYUK+JoKb?=
 =?us-ascii?Q?d9TnJTjlP7CCrjcL1tnStxiUwkAWEFry02FGzzGiebHt8jaGLiiTVgJUuyfN?=
 =?us-ascii?Q?lbLUydIFxEbV2hlwLjGUGBwKK4JpC1j6GYok352TFP8BXN7mELU2ZNdFU2iA?=
 =?us-ascii?Q?XEd5mOftNuVbbWwj+zh4ZpqKK6DXx4dCz3tJQnmWAd0Rsmr+opJ1j7tfhs3j?=
 =?us-ascii?Q?u8LhPgi2yWvV0Hvb5/4l6VSErN9NADEw0k7JBAHsXwljeBQUV6WguyuHRy3C?=
 =?us-ascii?Q?zEGQ1fvkoJf63BxQHFOPgLygFJ9gLvCVk6eHWdZfUip03R7FkevPeGjUrR8K?=
 =?us-ascii?Q?jSe/ueFz3DyN4gXstKEG+nC257r65xM4jI2KI3x4eMCqTgiT1SIcd/GDIazf?=
 =?us-ascii?Q?xagS4hM5erSecyPphhUEZAq6UwKj8bvNYMQqQS/x8awUSKN7UmllYOVRiyXe?=
 =?us-ascii?Q?q8byD5kn2+DmrcNYBjFi1Ls53Xw5zZXFcNvTf7h5P0N/Qk6zQJgEDw84WK+9?=
 =?us-ascii?Q?FYEOpEENk+Iwrefq89aMaEbwggwcuImvhdg5USyPCL/veTIwpoL2SnKb2+EW?=
 =?us-ascii?Q?+arEqFgsZXQxksURTdPe5wNJIvtjBn9QBsPTX7NMNTqlM6IprEz56m88Osib?=
 =?us-ascii?Q?ja7tG0c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S4PyugoCnsEFGOI3oXbC+woZyodwEboop0CqVhG8zsOtNq5y7WgJdNNmseBz?=
 =?us-ascii?Q?+uwAHFBxEK0bfu+L/BIHMKgW/sUz9qnzU9BTRwBbVlDZqKQ9V+PIQcGQRIKr?=
 =?us-ascii?Q?lmH39W7C1U21tODKGz5f0PtajbpTpuDxaACSio0HsETshmmC6n0d7IB8MzRC?=
 =?us-ascii?Q?GJRZqXHBppiocsTaETGq/9CTCTu9W2XF867uX7nd/7Y4a+eSyoXtMSyYv26A?=
 =?us-ascii?Q?svrmE5SfKuyhGUfbdRdm7UkZxFdiG4CcDVJHyRe6ufh6FfLOIfvW2ntYvSZZ?=
 =?us-ascii?Q?WfEOQc75UOzGN8pdX+K3fqmy7zpC1YqE2jUdTmc0jVpjfGfmDLR9CvIynL3f?=
 =?us-ascii?Q?aNd8y4eLc+oB/fothkHpQDzJ+u2gOUS5LugSFY+UFIO9aILgb94Sz7o8/p15?=
 =?us-ascii?Q?3YyyNmVw6Jo/gBJEDtrJ3dIgm6uJHsM7gSgsacM9Z6L+8pevXEszeOZY9GZJ?=
 =?us-ascii?Q?3XgCSnEGH5aGb5bIH1fvyHQTVJNwhlRM8fn0du7+obvo5lAu7diYkj7FMOLX?=
 =?us-ascii?Q?t14uXJUp2eLr2kqTSndpdvmIVpfyUIML/7e0SK1FZHhxVPa2CcwInch1E/AR?=
 =?us-ascii?Q?1R6Zj7RHNxfHF1CO5gPdRPabDl5eKa93XRSGmYbDW2j/gH27nFZU57Roslqa?=
 =?us-ascii?Q?8ZhCaV+H1oxfvdEUtKhuu1W/Ywfs/vjtMPAl2Vs5ArTOVsj0330K6xZvLvex?=
 =?us-ascii?Q?TEMyEAmR1Hf5YWopq8t9+ut8vEl2GkWG0gmzC7rLSxJVRY2ocgr0x6M6W73K?=
 =?us-ascii?Q?pnbUlJLJEshzgmKBjk2HRA/8A2grxzDGnZI8NFuUdid0SfWxkbm7YRjGmwhv?=
 =?us-ascii?Q?DPr9aNLLsQ2iozJucz22oAdK+5fAgzyeHxtNQb9QCGxn3eKPBDHofRPZDY60?=
 =?us-ascii?Q?upLYeLoFKkwIHrHfNyTKLGznFX0/9xtUQlHXajXHO3IbrouX/9WGJRRUuAmp?=
 =?us-ascii?Q?cawYJ4IDHtItyP2teefq+PLefPdtb/7dxFxNzj8xXneA+kENFRAnL4i6MwGS?=
 =?us-ascii?Q?yFHb+j+EvDiwA1Xi7dt5c4HYccQmpyYpHOo2/mKSW7JiufAHs0s8xib4LSw3?=
 =?us-ascii?Q?b4x4G6HRMSvYD6huxmVOusLbEaIpc05ps0krehuZ6T9eu6Q59ptZcsbS+w10?=
 =?us-ascii?Q?h2AsXA1RST7bHuY6l/89rcjpUWqNJoxjiqNh21EyjqGTk/im4jY/uHTwpJMN?=
 =?us-ascii?Q?eRbawnHE+i/0wKuOBlzI99eWsPcK30Z8tno5ywNWjFxEjmm7D7eXkNXlzTvE?=
 =?us-ascii?Q?4vVzZFgiOVpSSRTY3/BYj9TPJBQJ+aNnoSQEtzauYyjxvCizz6roF5V9TEbu?=
 =?us-ascii?Q?3FL17MWYERxjfxW6BYrpkVjPG0bLFNR9/IvtxE6xJZM3BHZc5BAvoOeAHOsa?=
 =?us-ascii?Q?9eAqx42WKFSMBB2XOTGJSCzkwu4GP8+SmWycvGFCKMbdCf8TzQ5k8nP51uHB?=
 =?us-ascii?Q?lNi4D5uqe5C9v1ay5zjJHHUsPmbM0PQ7g4zG0ETpPjC3NW1DQy86HW25wzQr?=
 =?us-ascii?Q?1d5p1qs4O1ThqGrlFifUvp47tC72m+xh5rVXQ611KzTuXfvYd317oIPLXz0V?=
 =?us-ascii?Q?zZU4i2ngnFlwxotSPlMh75f3ltpjluYxAnlwE4P8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acadaa68-dc33-47fc-f9d4-08dce73b922e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 01:50:22.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QSti2yvkaHmrmpu5pQJH6gRpPXTIia7u5O4PWq5cReAjtJib4eJi14qnwe6/i0fDA1b96dYp+gOfup26F9rBv2q7covtxA0z6k833hLKO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6754

> > There are 10 interrupt sources of soc0_intc in CPU die INTC.
> >   1. 6 interrupt sources in IO die of soc1_intc0~soc1_intc5.
> >   2. 2 interrupt sources in LTPI of ltpi0_intc0 and ltpi0_intc1.
> >   3. 2 interrupt sources in LTPI of ltpi1_intc0 and ltpi1_intc1.
> > Request GIC interrupt to check each bit in status register to do next
> > level INTC handler.
> >
> > In next level INTC handler of IO die or LTPI INTC using soc1_intcX
> > combining
> > 32 interrupt sources into soc0_intc11 in CPU die. In soc1_intcX,
> > handler would check 32 bit of status register to do the requested
> > device handler.
>=20
> I can't figure out what this word salad is trying to tell me. Nothing in =
the code
> does any combining. The handler reads the very same INTC_INT_STATUS_REG.
According to AST2700 datasheet, there are two kinds of interrupt controller=
 with enable and raw status registers for use.
  1. INTC0 is used to assert GIC(#192~#197) if interrupt in INTC1 asserted.=
 There are 6 GIC interrupt number(#192~#197) used in one INTC0.
  2. INTC1 is used to assert INTC0 if interrupt of modules asserted. There =
are 32 module interrupts used in one INTC1.
+------+   +---------+      +-----------+ ---module0
| GIC | -----|INTC0 | ---+----| INTC1_0|---module2...
+------+   +---------+  |   +-----------+---module31
                  |
                  |   +-----------+---module0
                  +-----| INTC1_0|---module2...
                  |   +-----------+---module31
                  ...
                  |   +-----------+---module0
                  +-----| INTC1_5|---module2...
                  |   +-----------+---module31
>=20
> >
>=20
> This lacks a Signed-off-by: tag. See Documentation/process/
>=20
> > ---
> >  drivers/irqchip/Makefile          |   1 +
> >  drivers/irqchip/irq-aspeed-intc.c | 198
> > ++++++++++++++++++++++++++++++
> > +
> > +#define INTC_INT_ENABLE_REG	0x00
> > +#define INTC_INT_STATUS_REG	0x04
> > +
> > +struct aspeed_intc_ic {
> > +	void __iomem		*base;
> > +	raw_spinlock_t		gic_lock;
> > +	raw_spinlock_t		intc_lock;
> > +	struct irq_domain	*irq_domain;
> > +};
> > +
> > +static void aspeed_intc_ic_irq_handler(struct irq_desc *desc) {
> > +	struct aspeed_intc_ic *intc_ic =3D irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	unsigned long bit, status, flags;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	raw_spin_lock_irqsave(&intc_ic->gic_lock, flags);
>=20
> There is no point for irqsave(). This code is invoked with interrupts dis=
abled and
> please convert to:
>=20
>         scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
Agree.

>=20
> > +	status =3D readl(intc_ic->base + INTC_INT_STATUS_REG);
> > +	for_each_set_bit(bit, &status, 32) {
>=20
> Please use a define and not a hardcoded number.
Agree.

>=20
> > +		generic_handle_domain_irq(intc_ic->irq_domain, bit);
> > +		writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
> > +	}
>=20
>         }
>=20
> > +	raw_spin_unlock_irqrestore(&intc_ic->gic_lock, flags);
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aspeed_intc_irq_mask(struct irq_data *data) {
> > +	struct aspeed_intc_ic *intc_ic =3D irq_data_get_irq_chip_data(data);
> > +	unsigned int mask =3D readl(intc_ic->base + INTC_INT_ENABLE_REG) &
> ~BIT(data->hwirq);
> > +	unsigned long flags;
>=20
> Invoked with interrupts disabled too.
Agree.

>=20
> > +	raw_spin_lock_irqsave(&intc_ic->intc_lock, flags);
> > +	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
> > +	raw_spin_unlock_irqrestore(&intc_ic->intc_lock, flags);
>=20
>         guard(raw_spinlock)(&intc_ic->intc_lock);
Agree.

> 	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
>=20
> > +}
> > +
> > +static void aspeed_intc_irq_unmask(struct irq_data *data) {
> > +	struct aspeed_intc_ic *intc_ic =3D irq_data_get_irq_chip_data(data);
> > +	unsigned int unmask =3D readl(intc_ic->base + INTC_INT_ENABLE_REG) |
> BIT(data->hwirq);
> > +	unsigned long flags;
>=20
> Ditto.
Agree.

>=20
> > +	raw_spin_lock_irqsave(&intc_ic->intc_lock, flags);
> > +	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
> > +	raw_spin_unlock_irqrestore(&intc_ic->intc_lock, flags); }
> > +
> > +static int aspeed_intc_irq_set_affinity(struct irq_data *data, const s=
truct
> cpumask *dest,
> > +					bool force)
> > +{
> > +	return -EINVAL;
> > +}
>=20
> No point for this stub, just leave irq_set_affinity uninitialized. The co=
re code
> checks that pointer for NULL. Aside of that this stub and the assignment =
would
> need a #ifdef CONFIG_SMP guard.
Agree.

>=20
> > +static struct irq_chip aspeed_intc_chip =3D {
> > +	.name			=3D "ASPEED INTC",
> > +	.irq_mask		=3D aspeed_intc_irq_mask,
> > +	.irq_unmask		=3D aspeed_intc_irq_unmask,
> > +	.irq_set_affinity	=3D aspeed_intc_irq_set_affinity,
> > +};
> > +
> > +static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain,
> unsigned int irq,
> > +					 irq_hw_number_t hwirq)
> > +{
> > +	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops =3D {
> > +	.map =3D aspeed_intc_ic_map_irq_domain,
>=20
> 	.map	=3D aspeed_intc_ic_map_irq_domain,
Agree.

>=20
> > +};
> > +
> > +static int __init aspeed_intc_ic_of_init(struct device_node *node,
> > +struct device_node *parent) {
> > +	struct aspeed_intc_ic *intc_ic;
> > +	int ret =3D 0;
> > +	int irq;
>=20
>         int irq, ret;
Agree.

>=20
> No point in initializing ret.
Agree.

>=20
> > +	intc_ic =3D kzalloc(sizeof(*intc_ic), GFP_KERNEL);
> > +	if (!intc_ic)
> > +		return -ENOMEM;
> > +
> > +	intc_ic->base =3D of_iomap(node, 0);
> > +	if (!intc_ic->base) {
> > +		pr_err("Failed to iomap intc_ic base\n");
> > +		ret =3D -ENOMEM;
> > +		goto err_free_ic;
> > +	}
> > +	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
> > +	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
> > +
> > +	irq =3D irq_of_parse_and_map(node, 0);
> > +	if (!irq) {
> > +		pr_err("Failed to get irq number\n");
> > +		ret =3D -EINVAL;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	intc_ic->irq_domain =3D irq_domain_add_linear(node, 32,
> > +						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
> > +	if (!intc_ic->irq_domain) {
> > +		ret =3D -ENOMEM;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	raw_spin_lock_init(&intc_ic->gic_lock);
> > +	raw_spin_lock_init(&intc_ic->intc_lock);
> > +
> > +	intc_ic->irq_domain->name =3D "aspeed-intc-domain";
>=20
> See above.
Do you mean the name of "ASPEED INTC" would be covered by "aspeed-intc-doma=
n"?

>=20
> > +	irq_set_chained_handler_and_data(irq,
> > +					 aspeed_intc_ic_irq_handler, intc_ic);
> > +
> > +	return 0;
> > +
> > +err_iounmap:
> > +	iounmap(intc_ic->base);
> > +err_free_ic:
> > +	kfree(intc_ic);
> > +	return ret;
> > +}
> > +
> > +static int __init aspeed_intc_ic_of_init_v2(struct device_node *node,
> > +					    struct device_node *parent)
> > +{
> > +	struct aspeed_intc_ic *intc_ic;
> > +	int ret =3D 0;
> > +	int irq, i;
> > +
> > +	intc_ic =3D kzalloc(sizeof(*intc_ic), GFP_KERNEL);
> > +	if (!intc_ic)
> > +		return -ENOMEM;
> > +
> > +	intc_ic->base =3D of_iomap(node, 0);
> > +	if (!intc_ic->base) {
> > +		pr_err("Failed to iomap intc_ic base\n");
> > +		ret =3D -ENOMEM;
> > +		goto err_free_ic;
> > +	}
> > +	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
> > +	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
> > +
> > +	intc_ic->irq_domain =3D irq_domain_add_linear(node, 32,
> > +						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
> > +	if (!intc_ic->irq_domain) {
> > +		ret =3D -ENOMEM;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	raw_spin_lock_init(&intc_ic->gic_lock);
> > +	raw_spin_lock_init(&intc_ic->intc_lock);
> > +
> > +	intc_ic->irq_domain->name =3D "aspeed-intc-domain";
>=20
> So up to this point aspeed_intc_ic_of_init_v2() is a verbatim copy of
> aspeed_intc_ic_of_init(). Why can't you reuse that function? It's not roc=
ket
> science to make that work.
Agree.

>=20
> > +	for (i =3D 0; i < of_irq_count(node); i++) {
> > +		irq =3D irq_of_parse_and_map(node, i);
> > +		if (!irq) {
> > +			pr_err("Failed to get irq number\n");
> > +			ret =3D -EINVAL;
> > +			goto err_iounmap;
>=20
> Assume #0 and #1 succeed. #2 fails and leaves the chained handlers and th=
e
> irqdomain around, but then unmaps the base and frees the data which the
> handler and the domain code needs. Seriously?
So, do you recommend moving check irq out of for loop?
And, irq_set_chained_hanlder_and_data in another for loop?


>=20
> > +		} else {
>=20
> Pointless else as the if clause terminates with a goto.
Agree. I will remove the else

>=20
> > +			irq_set_chained_handler_and_data(irq,
> aspeed_intc_ic_irq_handler,
> > +intc_ic);
>=20
> So if I understand the code correctly then the hardware coalesces the pen=
ding
> bits into a single status register, but depending on which part of the So=
C raised
> the interrupt one of the demultiplex interrupts is raised in the GIC.
Yes.=20

>=20
> Any of those demultiplex interrupt handles _all_ pending bits and therefo=
re
> you need gic_lock to serialize them, right?
Yes.

>=20
> Thanks,
>=20
>         tglx
Thanks a lot for your review.

