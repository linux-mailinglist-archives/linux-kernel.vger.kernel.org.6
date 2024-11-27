Return-Path: <linux-kernel+bounces-422923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48B9D9FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB032826B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BA2F5E;
	Wed, 27 Nov 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="T/MHZgce"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010012.outbound.protection.outlook.com [52.101.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CD81E;
	Wed, 27 Nov 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666525; cv=fail; b=TI2CL1tjca5NPs+/N8is4+0MWf7DdJPMDiY4xK5yOCzC0QEV7icU0f6L3XwIPKdoepq/BAMDG590JP0KMknsacTSaQ8A8WTYLTXbgbbCKdj3TYkpiVmS5J4P72BFDBy2FQkSqYzFMxaUKVkqPUSI0UVAosLB4LS2auoSSg/DHNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666525; c=relaxed/simple;
	bh=HI2HHZsuo102X4gz6YFbcmL7c5N31VPCF2XnPIu6WaE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=gnzWsmjiqN1ZzDM0WkFyWMKf8CcDRDt8XX6bzH2nozT58VQMzjmq+bOOdFYEu3LcU7WSF/JcpaQCRKMwdWypbb2EVxRT75WZlvo+6AEgXP+P7oFtqDjp7GJxQL9Lcza6uxI7xVyGR06P7FsNabTvzpNGkXjoG3AHlsfLWonbTa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=T/MHZgce; arc=fail smtp.client-ip=52.101.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGQDm6oGeqmQB2l7lwfVseu73QYjhyEYCmZ6S1zq+Kv4KQzi8f2ObZKtEfixcjIrEb553IBA0OHvwZEVQjcOMOEbtLPhIVaieDXBeEEBUuyC/f7540SPZUOBHE/D+aLETbu4p2X+Py1lGGwtoFbnVHDM7vtFJ9hT6T4Pqb8ei8zceGj+RKF4ivYtVziWLfcDFKdGzyTyI1NP7LhR7qiYT++Mz0SIDlLrtHVrrMTpdkkoK8PSoGMx+AaGxt4bMele3BQManK41UwArR9S72mHVfmQ7N5fnSxog/umcxJ6yxwWGg1zFwJhPaWiFvnXa4MpD/J0re783XomE3bm7/jzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI2HHZsuo102X4gz6YFbcmL7c5N31VPCF2XnPIu6WaE=;
 b=B1/fu0hK/0S4Py9xl1vbdJqnyDXC42vAv0/n2dPcOhYGQ39ZOh5YnNW317w8pw3ZNZCvkwE/FU/hdYhLRbpbuu0EeHVDe71BtNqNRGX74jl2B3FfgGXHKhqkUI05HHDRH9pI/Vi4plciNFyJwEwcpkKK91u96ktr3UqztomiDBUBflV9iHqkxoYGaNY6AhexNxgdpERznfhNobOH3RcP0iqy2uoL+k6o/zgizt31JteaOurcI/ma2TAhhHDcgm/efSqBZkiEWeU1Bp6ZfnOYdCiFt6QJOk0vMuBRP/5u8nO9rEFqSIwnedtln1B4TIWpRHzKFnPOF/xmQ2qw0RAE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI2HHZsuo102X4gz6YFbcmL7c5N31VPCF2XnPIu6WaE=;
 b=T/MHZgceyPGuB4UXc8ABnRHzRo6g1nbUgMb9XzrTIYZP6plUrqb8awT20GV+gPilNyWrRSmecYcPte/gPS3zb+uiVlBAQ5RhBLjxerE7tLlVsswP9KflQNGlmABPllARxmRsXWyxFNUN5gjyvi+3ani28QdGNdR6xE8wi7rtHmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYYPR01MB13184.jpnprd01.prod.outlook.com
 (2603:1096:405:163::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Wed, 27 Nov
 2024 00:15:19 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 00:15:19 +0000
Message-ID: <87cyihwmzs.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid panic during probe
In-Reply-To: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
References: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Nov 2024 00:15:19 +0000
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYYPR01MB13184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc931c9-a85d-4387-6376-08dd0e7893be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?oAmK0PmZKY+WY+rgLl0Avytmt/8QlSvDN8YSXZyKPWp37FHQLQMuYfsXLn?=
 =?iso-8859-1?Q?ACBKb2SHjfRmQjc3hVfGduih8hb2DBUSRTtnH5Rt8VHKPyaSF7BB24aqqI?=
 =?iso-8859-1?Q?hdTfYutjKA7MvWqCSdToYlAYrnYdxA28kEgNugiPTjw4aMXn3VzqOSgF20?=
 =?iso-8859-1?Q?QcThXVmaJ8rEBpXjE4SQXWfY9jQSyfrKhKU6XxMme2VEPyQjR01bzqVPYI?=
 =?iso-8859-1?Q?MneQo8t6oam0If5EHoDV6By1523U/W58sYHwKm22LDXhNlx/dfvxDvfMZd?=
 =?iso-8859-1?Q?B126OleonqiqyQBxJbaaZ48nkESbZANWIhx2L/CwhlyaB4AG0wCs8DfF2Q?=
 =?iso-8859-1?Q?VTEU97DsFd7b3CtmZmc/X5cmZA++yaBjus++cROoIHaXVbTl7q8+8pu7Kk?=
 =?iso-8859-1?Q?NmOBc5sdyaK5vXhW5paj4gL+VuYS+4JzYri/aYjthIP2SZz8w7vkhSAjfS?=
 =?iso-8859-1?Q?BXpsxGeBVRwlq5aRkjAavLYjW1JEaTtbQtgJuqTDcgDOtU0UcXKaG7e+5L?=
 =?iso-8859-1?Q?hOFEetnECmz7ajYlf1vQEuuQqBGwU52DA1jNHkWodyR7a1LkGGNFCTFrnK?=
 =?iso-8859-1?Q?kVpj+G/USuo6Uzs4way8OAvTE3yeozGM3r1EQPiIthlcktjGL8roJVIrDk?=
 =?iso-8859-1?Q?1b+bR7/pAptU6QxnQOz3lDL9cMe1+NJF+sdV5XbpY9vaq8S8en2x2o3HyG?=
 =?iso-8859-1?Q?PqegN24V+fFYFaXk8Jj8xG3JwLp5QWcN/dvCnOtE+4A/1pEj8DKa+/2dE4?=
 =?iso-8859-1?Q?nkvpUfMRc6YEbnSET6117Ayx3nK3i7CGhfYdfwgIBA+VDEnbTRkHlhmLjw?=
 =?iso-8859-1?Q?y/kTgxsmXElLrxtfmruYx1M4CxjpWG/QER1pl7kLOLG+m13hSosc0XnSht?=
 =?iso-8859-1?Q?NEZpbtINGPl28izY0HyEE08GvKG5D1YKMmRh8GVMg6zGffWaYxm1q6r3F+?=
 =?iso-8859-1?Q?kF07l99PtHgrr0SfWKZFAjbC4nmb1iKBogMd5Z3JEeEDiK9nv5bdB5E7Q8?=
 =?iso-8859-1?Q?7R8n9c+XQhkz3xppz6boA/9OU2oqNf90CpzjU1Ghb5Ry89K/QdCQFGNHUy?=
 =?iso-8859-1?Q?rJKsTsM2TNRNPedvy1xONYhhT3b54XP9htR0JtKGWF3NKRKT9hLbDcw4k+?=
 =?iso-8859-1?Q?yC/Vtjy34pj9/ESI6icqwKEi5htT1AdHVX0uEz2U+A638uYZYjxoPSLN4U?=
 =?iso-8859-1?Q?pSv0wRsSv0c4NYgh0Ch46ngyx1U9C91gyZ+uOtauae2RWfXwNjYwKM1t2N?=
 =?iso-8859-1?Q?fmODUEYjvDPZoHVL7thpy6Yni2pwmiR+hgEkLO2HGmC3shNa81vBeGk0lp?=
 =?iso-8859-1?Q?lezo3n2C42Fvx7xcBe9Uj4OvHSTuJUcrTpfuVh/brbYLRMNbEOoxfvF/8U?=
 =?iso-8859-1?Q?lsNK9gG/0u3dI8LbDAchMWVA4TODt1PqLhnEI6mKYNbZSZ6aSLB6QcN6sJ?=
 =?iso-8859-1?Q?Ca8VmNEH7ieq9eRuXa2yTdujt3lsaUjUOLlAWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ZjAIdelJ9Xru1HzgjdDsMamY7lNqOj4NDmNYn9/Z3le2+u4AjEti6fYmIp?=
 =?iso-8859-1?Q?wP3jICncs4p39tnTmVfD69FD+/A1/7TRAfrXmGbI9T1FW5VC41T57/HTfB?=
 =?iso-8859-1?Q?wprKGQHGRH3eEzX+NMMQw2BwlEvy79aMvphXVA3Xw0iqkT5BINP7QU0tAN?=
 =?iso-8859-1?Q?SIb5zdq0U+D8GfhEGcLp7QKtv/CN6CQiiOqlp6xEmNuz10eWzo8UEV/TdN?=
 =?iso-8859-1?Q?g8Yy0OVt0y3ytvhBzq7M+z8V8q+DtclwThn8tnIUjYuRnw2NW+OCkmhxGN?=
 =?iso-8859-1?Q?68mc6Uh0BPqbJ04DuI1xlOMdxWzgMeiCnMIANEJcdfbrBaKKvStlO5niSg?=
 =?iso-8859-1?Q?jBMou3MExAbmec/FI+AK11YPe0zNZ/GK83XXix0hN1dlrM1R0TrajbD89h?=
 =?iso-8859-1?Q?06X4yvUK3jqkuWkupl2GDbb54pqyI20dkZCLp6rvelgvg4OjPThx+YA+nB?=
 =?iso-8859-1?Q?vMPaMYteuTDqnBc6KcEIF8OtgJJttefDJKiduyHPdzoGfZNs/+hZ83xkWJ?=
 =?iso-8859-1?Q?nmAkN+jADyDv9E5nTVuLaZBHYiRyJlzDx1K7x51/koOHcTVJLgCupPHcbC?=
 =?iso-8859-1?Q?5JvaVhcjl4kP9N8fZSl9k4joYWWmq6umVX/CTGY8NkaVyPlWpxxXyWxZZ2?=
 =?iso-8859-1?Q?9K1lxxW9LeCKzF7pppMTB7/28xpQ90Q6SUaA2wrtTOkzomkhhLqEjKkw53?=
 =?iso-8859-1?Q?OYDuArs/odEU7uXz6ltS6vYWQd5S3U5T5DJkp0sXmeSO4O2v8c+9dMaSMS?=
 =?iso-8859-1?Q?3PYbuZjbHAHlO2tT7wMFYKL2vgSVMS8sPbLVru2NBh2HGmoGdXLzPB5U4/?=
 =?iso-8859-1?Q?sM3PbQpMYvtUEr87XeTHoZgjbio+1h/s2/6wo7citmsMhVoIN2uLeyPcq2?=
 =?iso-8859-1?Q?NGbo21DL3Zr1Mq4pcNoXQFM/g1azltc1D6Zo0OM1J5N6Zrp3ARTctEezx7?=
 =?iso-8859-1?Q?b+/mqSanpSMHz6Z3ARqrR6ZVo27qgEULJubL4wx5dCwLoCBtbEw0O6gA0L?=
 =?iso-8859-1?Q?YvscbSyBnKwZtutNhcgf9o2xcompV4+ll1trcr3pRShEjakYCKEfwuln0h?=
 =?iso-8859-1?Q?7yVKPhPzUyNMelpZIt5BpNpiHYxYwx7fciPKSck/31WfPDDM/+/2V2o9//?=
 =?iso-8859-1?Q?otUWbTBok0+uLhy67QJFel3gHadCzzD2mbNK3Y/0/r1AKtn7vOcBd0H+gF?=
 =?iso-8859-1?Q?wglvr09/tm0QsODMXlsRVzurJ0qnw/4zmqsUctCCJ70lTlj0wlZiDXJXV5?=
 =?iso-8859-1?Q?szIzpi+RLdv0m1y7r/DvKxjnHe9MuSm3OIFCEg/RfSF3swKS+Iq7LvAhre?=
 =?iso-8859-1?Q?7k62MYM7LWFtY+0LIvOZiKRvqTMmiIOZFtYOeteO0N6nTzvhvHVpru1xS1?=
 =?iso-8859-1?Q?QrcUw8x5nYUBR9VSkKx2wLqgobv7ltXZbheHcsBHW1F3g01NIRzaQsk0gX?=
 =?iso-8859-1?Q?d9Fuh+igO4HtG5gzLfJJUgWZ0ioGI32OXvs0A66CD2wOyeuIpfPgu8M2tI?=
 =?iso-8859-1?Q?gstreDgMJEJjNX2t2ZNJYF7zmOGzkmDP47R9WlrIAvtLPuFpofcNZm7j1x?=
 =?iso-8859-1?Q?WiKHUBeG8CRkHfRBzwGiNPAR2b8ayoXBP70cKfXIK1ciwn0A/PWN82TisU?=
 =?iso-8859-1?Q?6q5KF1pQPgl8kpQxblrwmcFrT23RfFDoVeL6meNqvVZMxBXgv/WEahM84i?=
 =?iso-8859-1?Q?5uEMHY5n+hFEE+w6L88=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc931c9-a85d-4387-6376-08dd0e7893be
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 00:15:19.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81+T20i7Wu9ZCHDlIhLJoN+eTp15XGz1NhQQ0xu6fSokGSmrG5GNZ+EsAVAslAic7beKBPuUj5GzO6zqhlg3hxPpdCrOgOfDT/sc2xlCPtqbEWX1qUEfvRt5KKOCtdCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13184


Hi

> Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
> Component via COMP_DUMMY()"), COMP_DUMMY() became an array with zero
> length, and only gets populated with the dummy struct after the card is
> registered. Since the sound card driver's probe happens before the card
> registration, accessing any of the members of a dummy component during
> probe will result in undefined behavior.
>=20
> This can be observed in the mt8188 and mt8195 machine sound drivers. By
> omitting a dai link subnode in the sound card's node in the Devicetree,
> the default uninitialized dummy codec is used, and when its dai_name
> pointer gets passed to strcmp() it results in a null pointer dereference
> and a kernel panic.
>=20
> In addition to that, set_card_codec_info() in the generic helpers file,
> mtk-soundcard-driver.c, will populate a dai link with a dummy codec when
> a dai link node is present in DT but with no codec property.
>=20
> The result is that at probe time, a dummy codec can either be
> uninitialized with num_codecs =3D 0, or be an initialized dummy codec,
> with num_codecs =3D 1 and dai_name =3D "snd-soc-dummy-dai". In order to
> accommodate for both situations, check that num_codecs is not zero
> before accessing the codecs' fields but still check for the codec's dai
> name against "snd-soc-dummy-dai" as needed.
>=20
> While at it, also drop the check that dai_name is not null in the mt8192
> driver, introduced in commit 4d4e1b6319e5 ("ASoC: mediatek: mt8192:
> Check existence of dai_name before dereferencing"), as it is actually
> redundant given the preceding num_codecs !=3D 0 check.
>=20
> Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_=
DUMMY()")
> Signed-off-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

