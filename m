Return-Path: <linux-kernel+bounces-305619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1AE963141
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E209F1C23DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AC1AC423;
	Wed, 28 Aug 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m2bUho6c"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605541A76CE;
	Wed, 28 Aug 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874626; cv=fail; b=ZToa2cDHS6cwzlJkrN/M/vpX9PIuig1a1jvSlEnLkA18VIcinUwzZwn6Jnc8RKH6JXtIUMIAqMHpIjFybXWK8AwTr0kY3hoQQk2djdDpH+2Lbt4gna95GeJpuinAlHdkMdOWeVUVwmczrxVaQwq4KnyinKrjT1ML0dBLyMolOqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874626; c=relaxed/simple;
	bh=edGPOqHulbhuXxG/1YNmrs8FInLGEo+m1709CtSyfTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O3ciYe6Mxb1ujoGqhkc8pnDOgm9ZHyrRBDW1PCMupHD+ZLrX8fo87csneXrM8WnLuZA8gYeR1qKE3dkbxLocuDtbk1OOoN5BJkLEkoMqKOIT9uWw6FLvuVLVTn/zt33FtQobx8C8uwjjkv+7JVuAFDd/byQ4OAOtUAL6rgy5ETI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m2bUho6c; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFLfZ18g25v2HEmFPItqyXHU6mPvX7nri4D5V13AQw7gm+fyCnkbjleK1HmGYxDHI/vkc3kfGpPzmnxAs+oySf+iGbWZ33u+yxTf9R28i/Vl8VBqF9lf0TEghbFcsOMD2W6iMoFXg4l4iM8XadMVWMH8kf6FZFtu/Sj6oWqyoMU2dzS7PWeS0VCaI+WaVUJNXZ0baZ66lUmj7g26LQtUtevNJpJRUKVDjPsulSxRrgctNwDKpvMurHnnUevvFggrlla9xqpGs9H0gCKXO72XW7lLONJknm0fyv0rc5E7CqBhIdOLeLVIvtfNpVR7Ii51TD7b2npm6xdsa1H+JG1OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP7RM+4q4aMKTh9iVd76I4IwrDRVSOIhnm77qiPVf3I=;
 b=Ual3e8b9uFLqGEHTE+IQXRzRpc/t1tXiaxV6bPnEOGbZx1/QCmNo75710zqvk5LrwkNPhaHUbvuxo5Ym6QDofrIWxzsO8GS/bJbVuDeTfXqPzNgNQjj9rRYeCX8XvPeuNsdg+przovhuSKSHn3It/I8XK+I+w4/Xi86kbPlvKaw2c0uR1S0RKXcA03krGiToiUFj9AOvOxB4OJ1Ksc0EnLgWsHzzSV3DYjtVvX8fK75RUOLShdmFzDQS51UA/4HrYTkJTJbIlqBzKiS+EDo7ierwCg9tU2ucz/8PGwxso3l8t2WVRdKTX/McC3nmrICDbGDET0GJG0wRQrkXtjRTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP7RM+4q4aMKTh9iVd76I4IwrDRVSOIhnm77qiPVf3I=;
 b=m2bUho6csXN5O6b1IfUrrYq0c2GKdzfvqd+OhTN2Fj1nvz+ipbne9+UmB88XDSQAxH/znpY4jngD6CRm03otVLgdskaTvTsyu7BN0ctRgnGrSFcm4/R2dpo8oz6NCl4f6ZGyEUD9LmINT1Er8yVLdosDfmQXr453PIG0rgTw2JocRN+ekeHo5+HwXf48uPlIODlLtey6SMlHqXUAxOO8dFlF4jMpmF3dfxlZmsUXzjT/fhvNY5QWhg4nsXivcl6ZW86qi/0SMMaEejNEWMnYRLTMG9Cc6jN/6JVAUTUcz7h+/ec/5qdGIeI6YPj40UsCp4jWaZGA5vPvZFKhAJDLOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 19:50:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 19:50:21 +0000
Date: Wed, 28 Aug 2024 15:50:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh@kernel.org, broonie@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev, jdelvare@suse.com,
	krzk+dt@kernel.org, lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
Message-ID: <Zs9/dWVPri9hoCur@lizhi-Precision-Tower-5810>
References: <20240828164133.1131959-1-Frank.Li@nxp.com>
 <54243e7d-2b54-4934-a530-173ac06180ef@roeck-us.net>
 <Zs9uAbUPRqkcRdxL@lizhi-Precision-Tower-5810>
 <e0fc65c0-45b3-4948-bb00-f34db59fe011@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0fc65c0-45b3-4948-bb00-f34db59fe011@roeck-us.net>
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1d9449-a09b-4015-6980-08dcc79aa64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZlLb4NCH0hNuyVwF53PdJKxutAn+zufnv9aVKFS/bdpCs+wLr6G4Uh0iLCOh?=
 =?us-ascii?Q?/3GwBQEOFYXsG+uoduXDnvTGjXMCYR27FZLL86jiB7wdmUWPjAIuUKyW445M?=
 =?us-ascii?Q?JQ+WZaijlw9/JbajpiBR6ti8YCPpX66F0AFeTs4hmIRhvjRTExApYMcxHgwo?=
 =?us-ascii?Q?/Crta1d1MxSC2eDLZ6R8fmddT2A5b66BSwO3HlPuCfEyVYebIpzxhKoMOeiZ?=
 =?us-ascii?Q?3merJhbOOyB9VAVshNYZnINVwK+rGmbMHaqw9TJYV80jmFzD5YuQYLDj86bO?=
 =?us-ascii?Q?iDjPefnTgwFqowOxM4MHMCl/d1tiTUgepHBmEy+uU6ULqc7WqshBAxDAAmqW?=
 =?us-ascii?Q?yQ41Mk9ZmrCnuyQ4ALXc86nF+swNZHPIEkjNdwztt7iovQ/POZJzgLZEMfvq?=
 =?us-ascii?Q?okaDD9qDf4Xs5+gMA8lEFMF0xT/gze0JNOn5NJ5ZnZlGg0gp5wtivYeLMNwP?=
 =?us-ascii?Q?mOztFC3gRdgaHk/ljRI36uYDEH3lpxd52A6ZiHMbcn+QBO0UbuLOl6OVa5WV?=
 =?us-ascii?Q?s29PHixKs0oU8cMQ+/lS+FG0FKfY1s6cGCZ4AGX34fQo5jGa3fc5A7uamc/q?=
 =?us-ascii?Q?0jPi1XZgd1Vyknqn3JZJznf2ZkEi10UmfrgmQa9UKqevhs8tRaYP0bAWZTd2?=
 =?us-ascii?Q?w1NgKxSDdaQ/SFuXDM7V4OHp0YvEga835ZYYjEVxRsOI3B3FBkpSsQW/MLsu?=
 =?us-ascii?Q?r+WYJPTdY5hlS0nU1Ksq7Gdhurx+7tgFucQczQIe+ksCoGbbHvVEmrn/H6ES?=
 =?us-ascii?Q?fxbRxgWJu0O3vIq162zPe37EpUSR7JUSgfDdfvi30FhvI8le9InwdT9L4bmp?=
 =?us-ascii?Q?3wyfR7vLwW+5hLUm2sjJPGRfZkSHclxeyZ6yo3nkKV4HgGkGm1x6ezW7M4sa?=
 =?us-ascii?Q?yqrdiE41c1kJhMznYKF7wDCaa5ctQVRgdkwuG9euD3x47ZFd+5A2u1ytXaDN?=
 =?us-ascii?Q?UOnHnWJyvs15N1HGiSovFYCUDA3uy1Ap7MaQU5NviMV6OsOLipGjikbl1PUM?=
 =?us-ascii?Q?Fxw5IeYd1RUXNYHmWlYe21CHkMIa0Nenex+boIDBRO9iHZOwzSDc5UcEfuns?=
 =?us-ascii?Q?7ZVA/1UhENac6PLv4vucPptYsY86mC+RWLGNh16XpFC+qyeZM7WGfVKWrdXS?=
 =?us-ascii?Q?ib7AGZan7Ug0ql8KxRhRMaGYPfSzu0OOJ7gq3RAzJnPFUUQ+nJQFwntAx/JL?=
 =?us-ascii?Q?rt/FISIhgJPF3OS/fEMEz2E0YQujNz3A+eo4l1qgiGhxAkmWU8MUus5DRsBf?=
 =?us-ascii?Q?i4CKWpktdusQqjqEyACNgu08zT9AyyRP1V18Bccu6fenQvCCdeV0p4ZF/lmR?=
 =?us-ascii?Q?k5o4jKztljg1ckEfuQMCqpiKCq+3bcgF8IPshlB1+obxmOg6btnXzjyb2DBk?=
 =?us-ascii?Q?Fz2xoRjmfB8RDjq3J7YHFz9bp77OKG5IEumZKWumYzysuaDAqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5g8ljtoTumZEQYLbRJmFFQh96T3HBc8uWcQWKNLpKv3nKrZSGd9XVBJJqsH?=
 =?us-ascii?Q?lGr7z59wObOTu2+59tqQI2g+cM27N6HWMx2eWoU5plAUjpuz6qhP82OXypvR?=
 =?us-ascii?Q?vdqhE/T4MEdFDJCLMVD6XIjC72RA2Q+IfFIr7abTJdHXRZPZgaz6JJPGNQps?=
 =?us-ascii?Q?RAjTTzTbLXl7W4gfDlxgfEB8WoOnWiEMyX8zGM8p5v6BEpHectqaD0KE7hYZ?=
 =?us-ascii?Q?eK/SKtuMg7UU2kx2mj80m/zyH3d7djwe58aty4+2B094U6Q9aRkXUEtD4dqb?=
 =?us-ascii?Q?QoL5HKNrpE1L1yR+nGdC5Bk7C/aNESjfaxceqM8byMvdOD5qXp+pcXfoEtUf?=
 =?us-ascii?Q?CZ1ijQS9rm7TQ2Kjv4lpQC3M0R2Zv41fd+rkvrwAyT6DwibR/TJu75MH7T2J?=
 =?us-ascii?Q?PBhmF3yyD1DhKlfUw+DWQp8GyrmrkQ+tNkhJ6oOaX+F98DtwNVzelW2HJyhU?=
 =?us-ascii?Q?P0vEV0by2uugGuy+0ndKINeyZGwGrdSzu+JJGRUsS5mVGhGBq7QSb2eewSK6?=
 =?us-ascii?Q?CE3AySBqjp0PuoExrMJi+sY0QWkR5RmPQP8yYHyI6noDjJwBG2ooy089/26r?=
 =?us-ascii?Q?woOvJE8rrSCNUDLIVkG7IgpNjeHPLIX/VoTT0IPO4asa7hgyVVR+roktk9Cf?=
 =?us-ascii?Q?1VnlNsunzJWjCAleTQ4FoeOWyuQj4pWjkihghKbCSC31UtdyhXZwMBZ76Us2?=
 =?us-ascii?Q?S65pxncODac/3af8Si0EejdZokwvXo9kEwx6cNEI74Izll/Z0DrUKRaW2qxz?=
 =?us-ascii?Q?1OdQYJiVVLEs9tyq9IyyIQp+FKs2nZKcqt/9QjqEqQqh0qu1HvSntgGk3YyO?=
 =?us-ascii?Q?+zmQ6xKUjPjbIhzZJKhvkzjxoy13orpgUfJgNh8OJBTxo00ffnGuXeN0LE04?=
 =?us-ascii?Q?uM6IVdrdtuOu7Xqi3FaSd9yL/cdJEtp9Qy/1/pbWaQu+ChbKPpWxsqFNZM1G?=
 =?us-ascii?Q?f53L3YS9DM6OhsjxxBaK7OYx67ks4qs0+HaoSFAInvGJYN7KDeVjFApvXmoK?=
 =?us-ascii?Q?lZd2e39K0+qkWKWtYbWrmuSNWqlQ3JI61eRNOUevOivEi6OjgfrAiffSE3Jc?=
 =?us-ascii?Q?fBEl0N/kIqmQD83vKF/qOFIlM/dWsvFbh8J9g+QEFLvhnjhlYkhj5rgXEBEh?=
 =?us-ascii?Q?JL+mt60wKXDXl3DRMb0p/oCCxt4ri9KEKoFYqAjS8J3J8rFLvJC7xjKKLO//?=
 =?us-ascii?Q?sqE2MaY545oGEIpFKjB00Nn/3tQIFFa2bZXGAMH0WSwRevfzxen82qxHcQXi?=
 =?us-ascii?Q?llyON0Gu3ekZwqfG/5njMyApPz5ZbNFYzsWW62wRK1SC5+5bioZqH470rA4R?=
 =?us-ascii?Q?Ffr3D3nCkRhs5E0fKENVDygLJV0c/GZqtWL1939uTjEwfatGTO+LfzAxQtzZ?=
 =?us-ascii?Q?DYL7NH3yPWLYtubQ744wttYqa+Tt09Mbp6UskU8WClzwDg4Z2cGzwqDaehnu?=
 =?us-ascii?Q?cZavKXY1PiuOFcY77YszlHrRpQ59X4oFDRznerdj07kudLCwCcXVN5pDkrq3?=
 =?us-ascii?Q?enym4fufL8wn/Jw9Sb4ojCn7al9Hcaa6jBv9G052QCrNjOWqUyL2QY08I0U8?=
 =?us-ascii?Q?sAgo7jhnb21Ld+fCFWc1xacs8jFqZ/YYadDFGJ/p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1d9449-a09b-4015-6980-08dcc79aa64c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:50:21.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw6OeLKgruqS42URR4WWeUIfTsUNnU/jtytJWiRyVJ4LB9V/s3O+lZ2KON1f6qfo6bggikzBooIPI8ATkdouqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051

On Wed, Aug 28, 2024 at 12:40:59PM -0700, Guenter Roeck wrote:
> On 8/28/24 11:35, Frank Li wrote:
> > On Wed, Aug 28, 2024 at 10:06:25AM -0700, Guenter Roeck wrote:
> > > On 8/28/24 09:41, Frank Li wrote:
> > > > Convert binding doc ltc2978.txt to yaml format.
> > > > Additional change:
> > > > - add i2c node.
> > > > - basic it is regulator according to example, move it under regulator.
> > > >
> > > > Fix below warning:
> > > > arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> > > > 	failed to match any schema with compatible: ['lltc,ltc3882']
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Change from v3 to v4
> > > > - keep under hwmon directory.
> > > > Change from v2 to v3
> > > > - put my name into maintainers.
> > > > change from v1 to v2
> > > > - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> > > > - update title to (from ltc2978 data sheet).
> > > > octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
> > > > ---
> > > >    .../bindings/hwmon/lltc,ltc2972.yaml          | 94 +++++++++++++++++++
> > > >    .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
> > >
> > > I still fail to understand the rationale for renaming the file from ltc2978
> > > to ltc2972. I can see that 2972 is currently the alphabetically first supported
> > > chip, but that is, in my opinion, irrelevant, and it will change.
> >
> > Conor suggest use one of compatbile string as filename. I random pick one.
> > I am not care about filename. If you like, I can use lltc,ltc2978.yaml
> > or other filename.
> >
>
> The rename results in a disconnect between driver name and the associated
> devicetree file. I fail to see the point of introducing that disconnect.

what's name do you prefered? lltc,ltc2978.yaml?

Frank

>
> Guenter
>

