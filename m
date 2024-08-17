Return-Path: <linux-kernel+bounces-290504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1B9554C6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA92283090
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4E79F6;
	Sat, 17 Aug 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dx3BMMVM"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CD20ED;
	Sat, 17 Aug 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860124; cv=fail; b=KDMOo3/eX+lBxVARVZjCtpl5DncNXjy/WWCE0E4xwlElBBg0z5qtDvwYHov1VUIgYWWsJY1WqfmBNoXr8G9/0Gcwc4tGizMnpLW37NL+HB9sc1qhE1h31Qn2QLEZJQPnzCb+7zVNYAe4hLMJ5qR2Yxy+iwW6LUwM2Ba/nQubTF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860124; c=relaxed/simple;
	bh=+ERO/iXPsXk82oYtmNKG62PzcODKT4LVECTorBEsswc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W+m/AHQyhmHU4OnT0DwZ+wJWXPLKtbH5ARna8O8ajCJoZ69j9ZCBlKnwXxv8Qa18nytIrKDAMd6wDF0nMhOB5G27EUczzKiupK9LR0srgaSddtZK/xx0Bsv+QBeWPBCrwlFlFVzvkD/9ihOCaRhjaydS3su28Z4oyMolFHaYqKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dx3BMMVM; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0zNL5KDi+6vw9P8epRtiWn+kuWSM5fKFXbCU/RSLrtimn+pEdNugDuPq5HQ8kHWsS47GWet6kvZMWVUviNIB/11dIGD+TYyWzgFnNUSRHzC7Y/wq8a4PFJoeb4OVGLKiGPog1ma+1XVp/Xmx0XCWaYNUShFt+98+Vw7P7ZDLBDbqLuqY8cNJiAF81WzgSSpCI1N5laojykAoVFsrYFTs0bFZ59tKhE2KrhID1HR4TIvifXrLYraLTynGNncqvWoIDAOBF/yBJ4nN/q9xyNxtuRPtzqpRGGfVPO/+G12ZEgxERTn4IpuaXm8hj6X0UO46G3ZoZtpZDtmzZbsF32vVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhrYjjOhVrvAOMn7Us0xAVQmwLvcgIGX0mWk45mzTLY=;
 b=TvS3eBtwhqRakaOD293ipHecS/3Q+mp5nArpJ32ZqbtJJ4t/N9bBjFxoFr+eVkI2ZwILGME5ZZAxg0aiMDF26g1RWq/yeJYeyCc+xEwj5BkL4E5bvSso7V3cmIzzKIY6YRgaIrV8aek81pP1zORtQxX+4SO6jQjMSgRmToguwWvwP2INlho0AO7kogT4jG6TLb5JqxHdSarcOU536cd6iG8TGi+OfSwKyQGguz+OGEsmIS0WUEQB3sbOYDASLPx50tdKCKo1F3fpp2ZQ7vqsKR/Tu75AYsYncwQ4TAcWFsdO2AYCnUUVU3uIrQnS4b/QcuFVWmk2YH8F0m3w6wXcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhrYjjOhVrvAOMn7Us0xAVQmwLvcgIGX0mWk45mzTLY=;
 b=dx3BMMVM2BL/QfJ1as/+zvKfD+qT8gfk2ABSuR6ss7od+jAzREJqvP1/vhW+2MzoRvbGsEtrfD2c1vq0f3r1KWG0f+PxZu+Zoujc/jAqTxvYfp7yX7z4shI4XSKdB8hCz5LF876KekT8EsGRU6dMq5m0m7mz7G8HoDbo6NhPhOG6wWhkEbwNvJuULFS42qUJcUttlBPDPnY0gauUApztmInvVXVMed9Ehw1PESkEV+ksO6kkqjnVtJYLviztfe/YXNc87VVvh+TZIC83rNAh2Q9snvKBFHNNI3auKeSI7kRS2MFElpygdfnmn+8CdoZemqr5Zctlh0j5+eKYvHM1XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8598.eurprd04.prod.outlook.com (2603:10a6:10:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sat, 17 Aug
 2024 02:01:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Sat, 17 Aug 2024
 02:01:59 +0000
Date: Fri, 16 Aug 2024 22:01:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to
 yaml
Message-ID: <ZsAEj1k9liVfZgjp@lizhi-Precision-Tower-5810>
References: <20240814181727.4030958-1-Frank.Li@nxp.com>
 <20240816215555.GA2302157-robh@kernel.org>
 <71d341e0-d988-41a9-bf61-c691537749fc@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71d341e0-d988-41a9-bf61-c691537749fc@roeck-us.net>
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa0ff66-4b36-41f3-7827-08dcbe609427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9Xf8zMmQ4EYNI1QlbQhD5OTadwLwOgB0zsEmP1LL7yOXK5xjeXgClgg44me?=
 =?us-ascii?Q?VW2rCquxp/XOZQwZrpbY1eO8IagMUDuUTOGZsTCjhIKcrmg+jD+6eQQXGv6d?=
 =?us-ascii?Q?qlU8dp9Wu5FeZs+6P8BPexgWUlha5/AnG1Pfcmt+45b/yPgyq1Q1Lc6sQ4ns?=
 =?us-ascii?Q?523GNvczxjniTW2gl7qJDej+kQR6vhEImDWsQ3HoFstiOwYnwJ+pcicq3FxU?=
 =?us-ascii?Q?OU3cdZVva8SHddFPlmXzoN7wmgaiCS6uhN5p62o6yucqKPYt9FSmUgELA8m7?=
 =?us-ascii?Q?OHl2nepugklpluVmy0q857KXqlpEEQKYP9dGr1tskedTm41zasxQA7BGMpNO?=
 =?us-ascii?Q?wzFDn3JpojRENqTFnPvzyk2/nCxdxLIIF1SSkcRcqFwx1oYao/xXYXhcE6MW?=
 =?us-ascii?Q?Vy/f81fuj9CgU2zXbqbmoZh5eC2WEQAiCKw9kwT0q1OBkuijungma0nZcDOa?=
 =?us-ascii?Q?z3TwtPRlKjfNechPJKZ3xO8ydzgQvMsqOswhoDryeW+D5qJLgNXBqTFAoxG6?=
 =?us-ascii?Q?J/kijF7qYzqB56PtIS0F7MABpY/DXmhHq6SLBiG+5xWmBR41go5oLB01OrFN?=
 =?us-ascii?Q?App1u2vprDdEv96xlkHiBim7rej4H/P8DjgAuMbi55NyUVcZUUwADo+48Ac0?=
 =?us-ascii?Q?GI0Z5PMOZrhfzxEZz8r8mGQA1QZjWm+sYI6h1ahOf/FCkdW/Hvqjpgv38qaD?=
 =?us-ascii?Q?j7fhhyAVzOTkCcENcHp5TP3+Bfhm4kZaXcyeAHrVwTUgDB3KDqE67a3pRmmj?=
 =?us-ascii?Q?RP9g9UB2UbBeRuD4I9RbFGuWKjtma+Juv/rj4f6zlVl2nmNVgXuRDeLiutDS?=
 =?us-ascii?Q?+PCVJjNN4ymVzQhM1GiZuugZr9Nlf/h7y9kIgwO7o7hGb2WGR0WD7OJ1eZqO?=
 =?us-ascii?Q?sLaHNNQsLsJuebNswPT+c1jiq5QbSvRN0y5O6T2GxCHzCPQGHfetVfFG3u0b?=
 =?us-ascii?Q?bZbysdQTSYae39yEK7eIxhsS2BTUvxtPV58o1d9UVPQdoVUlpOMhfwP73Zag?=
 =?us-ascii?Q?l8qY3/Vt5uevsH2qr2RhMGWOz1L1Ec3PqvlKAE29DIg+/FuCbaJjueCStsV5?=
 =?us-ascii?Q?P0GpWWN6RWVK1V+YFy+JFVrokmYOCeA9h9E/MdNjoodivMq0g7F+diy4ng87?=
 =?us-ascii?Q?Fb32DUJaESUpzlEBEqImCqcIsmpZpwFO9DceFPqU3W8IG9bW4Ao+a3Yrfch4?=
 =?us-ascii?Q?IoxDPGx7WDeriYdL1nsUCC1LWq9iCsXmRd6KQNXemXFm2mnbXqIzR61QioKQ?=
 =?us-ascii?Q?Qqm5oncjdJdfP1M6xZX61h++wZoCaKCzl7q0jFFwN75RhMJ3dfeT1KAEHoyn?=
 =?us-ascii?Q?CFmyrJZyYbx10vgmF2Sw5euX7vhpAECLfX13kfOSXBJiKODvKQmyUazO6kIx?=
 =?us-ascii?Q?i2pCmAfnnvzoZDyfP96v8aV2EjuN681myj/CkeCXTbWK9uJ4pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hCA8ajnXabLlA7qizshjX3uW01gpSpwe1L9A1TjP5xawGP+lEZtnMdIscgPd?=
 =?us-ascii?Q?NFtA7hPaSaJdVf97kkKVOetT0u5R74nLcvLJAmivw5jIri8zaAZW1dMWW6Y0?=
 =?us-ascii?Q?rM6SFx1S2BBsNEWGxW7n1MWNmhdfavTXiAwpLSCufqms1zkN5ySyafo4OfH2?=
 =?us-ascii?Q?kJnnmhn15MMb+ma1NHa9BFlX29/uq8rXuAllpq8VzXp4iF7eL4bfQy9iQyZl?=
 =?us-ascii?Q?spztr0gtdYADReXp1l00l1NNBPoXNnZT0Mbd5iN9zh5rK0LVuxIjmFv8eOft?=
 =?us-ascii?Q?Zito0a9PJtjOWdYVelcdS94TetOLWdNidQ/4YXVUCQh1Fs4vS9zBSlnTOIKl?=
 =?us-ascii?Q?QtBHHX6Hc3EKi13KBsPK6pu+wdCSKjs+8cWqUIRyI2bswz4feBhpWxsPInoh?=
 =?us-ascii?Q?bTIQTaRlMWoGLJ+KMms5yjbiz3FG7osf6seTNCCj5f5r2g4bV+50KwqAD3Ox?=
 =?us-ascii?Q?DHcY27q/3z5zrRv4QXsp/GSRa8PmtVSHeTlmaWwPQFETLaeMZLWHyKi4UDvp?=
 =?us-ascii?Q?loLpLWKu5UFYBmKT5C02/T16WyDjKi1Qj3kHm4dsrmccUTbKGmF4G/BAv/8n?=
 =?us-ascii?Q?NpQYRHZkDt7ve1sPfdHLTbW69Y4PEfQNXfJ/tc0BLuu9HLq3+l7Vd/HPlKNC?=
 =?us-ascii?Q?omeZeELn36I8BOJ7YlKuvOQpK1lPcgGa4VJaaqYL2SWKpbn2TmV5J8wNp4k1?=
 =?us-ascii?Q?bm3KXijAEuB08pNP5C8f6XB7k4bBO/qu58rKirZCzTMMf2hTXLCZzcBOA2Wo?=
 =?us-ascii?Q?fUL/dV+0iO3YZ1gnfncbZXFHq8aXeFE61uoKXd0u9NrpvUciaZ2i/++91Au2?=
 =?us-ascii?Q?5dKAqLAs+idEs7WciEg05G3/9VQ46uCku2QLjQBUBKpCxamfp9BGn7w4FPyr?=
 =?us-ascii?Q?O1RMGac/RhpK2rlw2ApQL680kYVEALTSVeLY3x4e65tbEV5efteDu6SMPQ9f?=
 =?us-ascii?Q?Egl9dYPbgj4oxw7F6VVkkO0cdzDNgfAkx9V8zSXLn14xTY1AwitiAa/ioiug?=
 =?us-ascii?Q?yOKQDVohzEFul7FCNMuP+GlCdRrtiXCjOOo969lfs+dce+/sekNUp+NR9s20?=
 =?us-ascii?Q?sX2hpewcJG/H5Og6BaTgccsFdOIsu6PLbhEORzqNCDUn7150WYMp1ZaK7n2e?=
 =?us-ascii?Q?QlwCPjG7X94vF4ansbaCe0mkWtLpzluItqKA28j396fsfRBmbhCEEiaRW4en?=
 =?us-ascii?Q?2d9mCuDyRfrSBY+04yrI9FFOKUb7heH0TiS4+vHeCBD77D7UEsGvyXV0vjGl?=
 =?us-ascii?Q?PQ/5lB8Ju2CT9UW1c6uzIk7x5ZEI1C8PMHWoNOOvVyas2pVUNIca9G1VQDZg?=
 =?us-ascii?Q?K+l7/gbU5UlgCHFqO/iS+Q1rxHAzjcWLO+mlkgGBLu3oZXilf/9R53rxFtqs?=
 =?us-ascii?Q?bPaCGSNVy+zxPohQ0BJ3IlpcEnRQj5OhIpiuWSSE50/HQZlpKCOaucYp0AQT?=
 =?us-ascii?Q?YDLQJpaxF4A3LL/irXrvhU5tMfaGiDqiZyQ6aCNkCTWu1SqxXpJnxj7xVVgk?=
 =?us-ascii?Q?U4cphygPljxnQD1XuGG7So7RprUvNzjwoX1fgditq5m7bd3Z0oodOazbd51B?=
 =?us-ascii?Q?KvTRlm+rBp0K2K4bIgs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa0ff66-4b36-41f3-7827-08dcbe609427
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 02:01:59.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3di2h+yzv78Fu9CUHja3/5Jq33YL8kuO3oE+bUbpd2WnPtmADowJiWufC/9TOLeVLcfViXMdqvZsnNL9np71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8598

On Fri, Aug 16, 2024 at 05:03:16PM -0700, Guenter Roeck wrote:
> On 8/16/24 14:55, Rob Herring wrote:
> > On Wed, Aug 14, 2024 at 02:17:26PM -0400, Frank Li wrote:
> > > Convert binding doc ltc2978.txt to yaml format.
> > > Additional change:
> > > - add i2c node.
> > > - basic it is regulator according to example, move it under regulator.
> > >
> > > Fix below warning:
> > > arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> > > 	failed to match any schema with compatible: ['lltc,ltc3882']
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >   .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
> > >   .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
> > >   2 files changed, 94 insertions(+), 62 deletions(-)
> > >   delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
> > >   create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
> >
> > I'm on the fence whether to move this...
> >
>
> I don't really understand the rationale behind the move nor the rationale behind
> the rename, but then I don't really care or mind as long as no one claims that
> the _driver_ should be moved because the devicetree bindings moved.

Conor suggest use one of compatible string as file name.

I just help convert it. I am not familar with this chip at all.

According to original docuemnt, most talk about regular instead of hwmon.

If you want to keep it under hwmon, I am fine.

Frank

>
> Note that "basic it is a regulator" is a bit stretching. The driver's regulator
> functionality must be enabled with a separate configuration option; the driver
> works perfectly fine as hardware monitoring driver if SENSORS_LTC2978_REGULATOR=n.
>
> Guenter
>

