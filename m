Return-Path: <linux-kernel+bounces-351403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB599106F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BD32820FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D41DACB0;
	Fri,  4 Oct 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QUGPZ1Qy"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3780231CA5;
	Fri,  4 Oct 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073060; cv=fail; b=fBNycxjbkUyrzWO5Ak0FiI4L9mE29Kkf6FCr4NXkvFin2g6UURxHu8fSqpv96qpT5TPuSEHcxIRdhN9g1+Yc/hBly3lV/COiCnYnCVz7GOV5Oq+AnTfdAQCaOG+IXMFSeCWNY5EUfts2R+oZNMyZ8w+pq97hZA4DonZx0g2aTLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073060; c=relaxed/simple;
	bh=jma7NWg9cNdMcrQ1xwWHGJocmGVWiBgUnPdDOsl7LwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HiGLW49rY/41uybPheUYNnWP71ORrj0TaE8JDDrK9E2jzSPjgvc82katAEwVguB43iG22aEW6Lt57MTen6x8Pflf0aiFY2oSC2RmE4DwqyFhn328yu3w+tamOP6R5gA4W9xXx9qw2GAeKUgXgp5wMO3pOpJh93dqLLov3SkBkto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QUGPZ1Qy; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrWua7P0S4pfkl6DSLXfdOsQlBhdCy2RBUNK+dbDviAQdzEwYGkkdbkGo+T6hoCXa1lVByqo9q3UaWgV2OY33sd8mFkHX1RkfeIXSlNGtGkcDzvUDgxDNF3Niij/hmUeyXXwqQ5uzW0WMikcwjpDwa2NbviJvCrf35t0Io6pHeqkr48CuRtU/p7uE3BztYH7bUwzrc3QAV+BnirteGl9xR1SPfmIWwU67zAsnLTucnYAr2SeoU80Ruqdin4OkIDC4LRdsb/5J2HPMggeK7QyQEG4gHgXnYJJSdHHyNikEGLrQeuh2+gkKSRNfNajTkxrcL/M0FvZw7QqwbKHALJq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mwuXQNOkD7ObOKPMFVTENFyimKaLZ4eLk8/AZ2we4M=;
 b=T974+p2hFJocjSeY+qsbLFswhI3ar/zaSjpoNDKRhWd58nyfT+PXKOaGYU4aFol3GM5ri3D/ZgYPnMSnrQeTB8CVVY2e72aMFd84MgCYmCovAOZ8/vMt6zwNq8CQVCVv5SlHqGej3CoWrM2g63rm6vauXoH4Ly0WTjiTetmtjlpiR+814/3fhucJPTtcZyfrcFiD9if4Ca3mrNhS5PFcVwas81UcA+sVhD7rFrZCkKvq9a9UZszk6c6H6kSxcua+ely1X5/+vTy5B+mJRAmnet3JLvltlzKTL2oejDG+BIqLjJzetViIapfEDQdmVqPfRle7jfZSP80eukCorqdAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mwuXQNOkD7ObOKPMFVTENFyimKaLZ4eLk8/AZ2we4M=;
 b=QUGPZ1Qy7QqyOF56BeyO1403Kw6xq6se5rC+XRTBLBb5HIFL/ywBbOn+sqXZ1POa0XNAZTPp+g8c2SnGTrvDXABZvCU+nf2+QJNJGZIIVwClBaueMGSwKFPyy+y5NH3PquJnhEbgke4BnVyeNAO5duJ23+keEPE2b47E3jzlToQyxBKtvrV433p0ckIGDAVFvkaLY4FbuYjguXNjJJ+pciVjBuDClesNPNzFOvw5pS80zVs8hKPmQ1nrkj4dVx8UXrqhPu0ozzJu02Feiq9j4h5l69FfxvLs7uPZtAGhdLfhko78cl3LdCgf63ZyJGAX3GCDvarPaYRK253OF2GjIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 4 Oct
 2024 20:17:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 20:17:35 +0000
Date: Fri, 4 Oct 2024 16:17:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for
 msi-parent
Message-ID: <ZwBNVb+9qIpEybyQ@lizhi-Precision-Tower-5810>
References: <20240828163417.1130252-1-Frank.Li@nxp.com>
 <kasyt62uhb7cijyrmbs7zelwgjtted6p4ynsy2s47e2ycniicb@szosg55aejjh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kasyt62uhb7cijyrmbs7zelwgjtted6p4ynsy2s47e2ycniicb@szosg55aejjh>
X-ClientProxiedBy: BYAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:74::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad7fcf2-cb3a-48c2-8dac-08dce4b19450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+y33vT67hqo7FljVrXYZNWRd/N3SNoTNC+BReeeAMHYrzDLBKpH4ZUgcvSP?=
 =?us-ascii?Q?wiKl0ea/v/GZ0QCHqRhpfws9bBhdxMnq/8ropQjs/kHa4FLnv7DluBcA3MRi?=
 =?us-ascii?Q?/8unuaQnhvdE+6OPQ03gTC1tg5uHz4uSswYgDv5y3Si818KpFCqy0XB9b5N9?=
 =?us-ascii?Q?LeMi3g+eXQl3SCvqyuVbaXC55F6EXvueUJz8mblOSv9mYTYoPsLefE2S4TNA?=
 =?us-ascii?Q?SHFuCtm9qx8SgwcjLixsTrmgl2S9BRwCmyk8L9d5RUb5lVx75aZD9fjMQ7Zs?=
 =?us-ascii?Q?Wxpk4+cH9HKg8GVzV/D5I92G4V6yqKFMl86gl12Bn7cIgm0yyiMEvk6OYur/?=
 =?us-ascii?Q?Lws+AEZuuAAmlHTUHp9gU7RJlayGO4kR+I+tZutruKYHpcpois0zIHRoVFpv?=
 =?us-ascii?Q?bnsCDyGsZdomUWtKrJeh12uoaX/5P6cKtZUZUzEzTePxJwO9wcuT039+xD1f?=
 =?us-ascii?Q?uYHAZo1qgTVOg6sCT3fT81gx3SUO33RLVU3UUtMo/cx6rchwe/p7oeWuLHXB?=
 =?us-ascii?Q?01E6aQ3L8Ic9A+7jt7UHN5WdTg3j8S+pzKYyRzBA0yfVWlJu8ggZxUAtaaEJ?=
 =?us-ascii?Q?6OY9As9HQ7nGIN+ovk1OoET+PGAMy+kR/VAx6gt4WFMYMqiBmhUZFo8zQa8e?=
 =?us-ascii?Q?0+DYtjtCtmZT24B23TXhSkZl5CAvGHJUfc/LAvnwSlpEuzArIWNaWsBCStZC?=
 =?us-ascii?Q?/W5bF2+3uDmtBA2iGPCytRoLA/vQQXltCKz0Av6CAs5qDI/f4ynTNRIH/2yn?=
 =?us-ascii?Q?v1rkGf3J7kn3xnGQWMfA779Gyo7WLylkwYwPRw4Zbjmev2HZcM+qJX5pmRWe?=
 =?us-ascii?Q?ZMG6zao8QPrOR+Tve/o5yzH7vGyC3pqOeCaMsmKlmWdnE+wFcXhAEDj9ZM8V?=
 =?us-ascii?Q?07C9i2CRyumY0ZXu/HtRvgVCfhmAXTjcHdJWce3KqNpNZ7fEcfLAYyLyvc0v?=
 =?us-ascii?Q?jBQuJ5Z86PmFmxup41QOw0BCDBOJxp+Ch2Poijy8DhCg50+mPicswdEqDqF0?=
 =?us-ascii?Q?IRFoKva0XYC1aPE82re3ahDU+ZwAv99ptkMA+sO+Fh6gFv3v880HumFT5q53?=
 =?us-ascii?Q?Li0c88gNfr1/PKlXJONm5xROK0Om+hZKXz/sKhHVZobftv1Ix0Td++Mj38hy?=
 =?us-ascii?Q?WK++wTZ3gC7sNeU0/1IuVOjNFibMSeUdx2dkSV6KWHeqzT2VP4H3w+rEkrJo?=
 =?us-ascii?Q?NS16M7+cRg1l4GdSjFyxc8XXUt+QwYNIbw3MtTnUThlkhBp8lQGAchs3lEFZ?=
 =?us-ascii?Q?bq4Er+MaiSZDSqljsq0HIUfm4N292keIs4aUynMZVIJEAyg904Xg1E10KrKX?=
 =?us-ascii?Q?01XNpkrJNLGAh51okax73pjpjn4qZy3Gj3+jewHsHPkyuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zv14iZ/pq5gpTKs2TJPnWar/Yn1vnq9BtlFn+xKea6kq8w4s7UzSrMW2Q1iT?=
 =?us-ascii?Q?23tvAoxNV1CWHVp0VyEDKzGrO3cgJe72FQtAYuLoM7yZlyKu9YEdAGxxrUPL?=
 =?us-ascii?Q?xQxNTIKUwDM3AbO9ZGRv05z3fZmqNnvb/i8+2gNUiyva4Wd72i+RCnlc/IHP?=
 =?us-ascii?Q?d8JTewgX1wOgHQSPSwtdwtUtXOuXL1DVQrOLdAkKWoMrI0e1v318uVLSfMZJ?=
 =?us-ascii?Q?26ouoX7DpKtT+/W8qQzWNqWxZGB/7mJ+y9w0lxKnQziIVzkaFssZmoUwxZ4I?=
 =?us-ascii?Q?uBHXYQmD8p58YhufDPhRC3KDi7wsvY4JDpljpltezIIrn0mX+sZ/yTlKFubh?=
 =?us-ascii?Q?1L+dGvO0h/u7/o8r43Cq9bVVBlXUoi267z6sxANps8j2PmtRp6YP02RFNXan?=
 =?us-ascii?Q?xIs9BtR/cug2eaH/86gAtIX/Rur5dPyEDSYZ3h4dHEkS4Fabb5v7U9bXRP/u?=
 =?us-ascii?Q?AY7ae0Md3fWq+v3rbVuDaonRmivpw2i2I7/f2niRiNcS/nQ93qrZ4TU7M03O?=
 =?us-ascii?Q?lDUXEIvhdkVEcf7ihzQRwW6tVZ49fTZH6dgR97q0Zm92ZOL5rrVM25JKC+jt?=
 =?us-ascii?Q?vsPr6iOSwgdcLEObTAk9SDkFZbN53L1FokPH4SLRymF8pQgJS5iGcLuQ5oYZ?=
 =?us-ascii?Q?XgFYwvmRL28mkFOsOYJytDzuwUPBx6DzyXPi33HaHqRrQnj8MEhig2KZGNHl?=
 =?us-ascii?Q?fd/VunpFgolDdGpd+gGVKjbk6X2XYP6S18tjfaqYg7W1vT0Tv1HmV/ItiGi/?=
 =?us-ascii?Q?derApTYEQdEkb09aAJ2prMk6f16G5lPAgqwLPuoiYFis49kh4IKd8ztzSZae?=
 =?us-ascii?Q?jyoZ2b08lUv5UHs8AeaLDUwr38e2uaIpYVEkSlO3DRDJ7f7MqgFn60yMYob7?=
 =?us-ascii?Q?OiTnEq/0GSjxrNFJ+RIWZNmcr2gnCIh9OoebMmFl1ynBMwZInEG79aMYReQB?=
 =?us-ascii?Q?2jGiLlod1TJHzoU+JSTHRlT0bMsJ7BTBUGtvrFtapG5XjTI4yqK+9AMhGlsj?=
 =?us-ascii?Q?sZPzc+NSvPQu7dQAZdJemnP6Vowq8ILtNVfQXGYEYbuMwZSP7BkfkFl2EREE?=
 =?us-ascii?Q?4lzKEwuVtfx4FO5OEVMFPd6WnUZlwWoX03K2b/BlYvlkDi3sKsxJsEXR+TRk?=
 =?us-ascii?Q?9OqXP3RbkvbVO2gjpd8LB/j9XpX5K62ghONp2KF90Ulil0aCkHQ/duvNK+Zk?=
 =?us-ascii?Q?7IEuBdLD/h6fFZBiafDI/qhi5/ZWgVy26Jl1jyyH2Zsyptcygf/3Gl2yS2qk?=
 =?us-ascii?Q?7VyzATERWiyqQsReTvP9D2BuPnp359ZuA5PD+Y6EwRlICviwYlYrxFcnYJFR?=
 =?us-ascii?Q?9GGefsrX+HjU5w4oZy2S5cwYyP741mb7VRR927KmGB7cj2SN83Gb3Cuz85mi?=
 =?us-ascii?Q?1E3bhtpM4KC7mdeg4Tiw3CGhjQccEY+c+HrWbI4GSWPjrBpNj8br7R9t43hs?=
 =?us-ascii?Q?9KRrgtq4VE16JLeo85yqioCn8X7tK71TwsrnaLd4oSJ3eTWcB4Xljart2OBD?=
 =?us-ascii?Q?zjW5Y+DOdlS8opqFfhYGpws6RG8jq7cY8CSQmgL+1PuTqYq2QbzoS8cEF1Ar?=
 =?us-ascii?Q?L4rs0gxuKdvMwLy62RoPXlE0KQ2S/MGvnFMaXnAo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad7fcf2-cb3a-48c2-8dac-08dce4b19450
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:17:35.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBbAU7H7FvXz0QmFN9zG/qDaPrdt9eFe32mnxyf75UfVL5rpt3eOTfE9pbsw+PNiJuuQRL2D6KXXpIwXYREK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

On Thu, Aug 29, 2024 at 08:24:26AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 28, 2024 at 12:34:13PM -0400, Frank Li wrote:
> > msi-parent is standard property. Needn't ref to phandle. Add maxItems: 1
> > for it.
> >
> > Fix below warning:
> >   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - add maxItems: 1 for msi-parent
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Anyone pick this patch?

Frank
>
> Best regards,
> Krzysztof
>

