Return-Path: <linux-kernel+bounces-292943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F039576C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E3D1F23AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE421DC488;
	Mon, 19 Aug 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IbtAbIaQ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5D188CC5;
	Mon, 19 Aug 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103926; cv=fail; b=p+L9V54sU1AeqfT0UiECiASI709jUebjYm0DUxX20v/XOnzVwTA0Dj3ipzfdHM6ze98YvNyGtdUya1aZ9VjGe1XCfoVxnLLQ35dHUwMYN2NUD7HmZZAksCurjM4qj3XRbAu9iYFHVzBgFrQo/cRuL/CueaJENI/BU30D0GtIjik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103926; c=relaxed/simple;
	bh=RNVGgBh1p+YqoL6Zhcjd7AlhBn9E/Tl2UGRwlb62/Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJZGPSJQpEfmZpHIQiaBg1ZHrwPNRwNmEE6wXtxRzEYVa/vWfI8FKqxXbx4IMRtiQtG2+f2O3wxKHtiGZq4IrWUS8ykTNXKqJHS9g6zA34l4PmCrlsW0F/GGtai2qoTZa8aKg/lUtzhSKMYaACXklz+yB1XHRpuimN2nPszXN/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IbtAbIaQ; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWmmmL/5tommrbpcvBl7qF8zgphr3QaTF/vJ9BXxgnJVHPQr3p5cqo+3N7dzb7Co9Sm+VKAUWebguX21sXg4UwJHsEB/+cAjPXRWgvrXhuuosk8/OJxg+Z/zUFyT5pVm8+1Llwq8ItBmW708ILuUXRn45znzQyLDdvi9lKrSMA9kjx1P2Xvl9XHss54uncKcASAM/JnfSEj23Z06RLnZcj4j1ZJThH2G6+6rUAORwIqTqxDBIueK4f3EFVtzDafoo29Q6OxyFEuFE5HnvozPExpvCVCbEVzt0PV1L3Z59n8/zHXM2wOagge+73N+YRcTW2x2cPSwfEfbT9WHyQsIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws2RqQG7tTwvMpdPRKx7SKihnsOpIPY0jYQ6FXsV+kA=;
 b=nbaRCVy5ehE/hSymQxUiR+urLVJ1OLq30OVTXv8jdDWAhCE8O56pKuUb+Hja0B88AoTImNN2xRvvo9psszMpOwv+Njt00Jo+jYyQ+whT98eQIepzYuP6+wdMTP0EodpVa1tPi3h7pvlT1ZdJjb9IbGTM5Bg9+3zNeicBxl41i8ikCoMLV3+Rd1bW+be/KHiX1tRnRe4/H+2ywvfTplB4K7kwVWBJL39jLirYgkM16xEPlS24UxsFFgHfGfgZ0AqblOlKk6yyQY4AqOUgMSAWloQIqRWpFOPJ2Wyx4b/qCAvS+a2Vg4BB0st4pe+dPjIMggqV2sN0Ydb4bCNOaKoiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws2RqQG7tTwvMpdPRKx7SKihnsOpIPY0jYQ6FXsV+kA=;
 b=IbtAbIaQNn2UDIVx/QMVUm8CxWMOmOCRXl7zBFMEf1cek+MN8Fc/l2fQK4GlTLEu+25B6y6rehSYq05szQVDqIK5NGnSm+vkbOaBUS7kbP1SjotLtTKIi85vfIg/lkCC12B5c3+/JUGWnTGHaDTj5eETMfdqbXb3+hQ1zznqKJjrSlPv8P/IiCbJAhedjO1WEavuloWVVvA2Gmy3tKGRZDwQBaCWI7mlUMEYU6M0vTVARbSK7L1SVowL4A1358wVbbWm0FTLR3lglIQgwhCoh2CQJ+1hDf+ZIzArlzC41Ce55C6e1OAAxDHLyD/+mc7XouI1H6uo5KYpQeDuGlbnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10861.eurprd04.prod.outlook.com (2603:10a6:10:592::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Mon, 19 Aug
 2024 21:45:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 21:45:20 +0000
Date: Mon, 19 Aug 2024 17:45:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
Message-ID: <ZsO86HQKxmV/xFV9@lizhi-Precision-Tower-5810>
References: <20240819190652.373222-1-Frank.Li@nxp.com>
 <bea0d3be-6b2a-41a7-8644-44b17d3a26dc@sirena.org.uk>
 <ZsOfeimD94+mh5gt@lizhi-Precision-Tower-5810>
 <e63f6e5b-09a8-400f-8425-8dac4284fc9d@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63f6e5b-09a8-400f-8425-8dac4284fc9d@roeck-us.net>
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9d3f7a-a839-402d-8a17-08dcc09838ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QyGYbPH1AJoleD+avJbsDvY+TSgFi5fEhAYeTxS6BA29SwgNdhJZ/1VmTtR4?=
 =?us-ascii?Q?KrGr0Ezi4VC0X9056kz4XvBBausFbFSw4OiC2Rk/dbhwah+Ux92lOZoyYqVz?=
 =?us-ascii?Q?FUYPeBPFtBP+Qi45GLm750wvomfeAkZCA0qaAK6BdH/XSVKmxglYkZ8zAjUE?=
 =?us-ascii?Q?DoSmPw1OI/dI6xQnW95p11IS/gSUGQ92xHJTzF1ANTyQKIFLNjE0G2fBZ57n?=
 =?us-ascii?Q?tuWmjgYafH7KhJ+9hoiAtuHXS0WRGWaXsXCf9e4l4i1Je76fKbKvEUd4k3in?=
 =?us-ascii?Q?QyxkgbxvJy9XY35fyfRQ4pqXnF5QOb+sMIe5ckhLZGqOsw5/dVKaTbYgFjNG?=
 =?us-ascii?Q?RMoocAgbTjZvf9cPXTkLq6DBiameAMTLmCXxos66kmEqwUKOS2cwzNQkwCrL?=
 =?us-ascii?Q?YaAq5SB42+v9u1pvr+GzrxhbzjgHab4VuJIKsuS+y56DD78jguHtcbCwGEcx?=
 =?us-ascii?Q?Xx2fCLuevTDgbWnq+zmE/aNrGDz9rVw4dYxyxBXk12OxEU+XqVRBGp0mLlVL?=
 =?us-ascii?Q?PIEl/cTClTpo/hy0f18Gy0wVVkK6FDD3OyA9LtV5HajIQ/wjfipNW/S2U54V?=
 =?us-ascii?Q?H1S3EoDV2FUGD/CfgMCOf4i+Mq8+UkHm1COP6b+wLHxMAZudtswKjVRXW18x?=
 =?us-ascii?Q?pU+37UHV5zb6xhSByOU8n0zAVC2kHes56xsiWgW1wWj9GG3GoVwq60PG5u4q?=
 =?us-ascii?Q?FG+H0e+QJIdVX/cIajzrH+mHG1N8Jn91Gx7epLwBwCmTua5A3jPl2uzQaVOG?=
 =?us-ascii?Q?bdQclx1n74N/75dM3o0od6gD/J+n3GcnsmGi3GgLxwDy++09wA9TBa/eb8PH?=
 =?us-ascii?Q?qktFo51HhMulNG84S6qDFps7T+u/otLoRg/vANpHA9ob6lQevjONeyBydQUf?=
 =?us-ascii?Q?1rqH7mHrsFeG6NPGohV2y/to5VWKK/0rSTJk19/UKjIvlZ7NOc25TLpZKh0J?=
 =?us-ascii?Q?2jfgmnDq9bj3d/p9rqovg6xKeV0CStfZnN2urV+r5arcbRR198Hdlr0fur5d?=
 =?us-ascii?Q?P6Un3/uzpCIufuhE5Z+XL3aY1GLU+HEyFp4SvMGi9pFswvrAnfBxWZ/73PvE?=
 =?us-ascii?Q?0jTuBbAk1cYI9KrWGJ8rVWyPOLRJfZJBSYC8JiNy/sae4yCsRR+Aur6fTdw2?=
 =?us-ascii?Q?sy1Dmc6w/4ahX3ubSCdwcGvJAGq0ssny9FouSYJD2tF4HcIeVqXmQUyVZGSf?=
 =?us-ascii?Q?jLDJ8pEHJLfF9QyWq8EjEbW3xF+zsu2eKCFZt/ll4K5Y3bys9pn04DSJn/OZ?=
 =?us-ascii?Q?trFlqSeaiY9AXTYNowJfO3pUq6t6av4cb8ECQS8CzhJ6U+vM2+C//77dTyHU?=
 =?us-ascii?Q?M7IXEJoQ4RP58UIPgnjkackgQepR5WYuvWbdEOD3uNoiRBuDGo3TwJjTBm6d?=
 =?us-ascii?Q?poGNx+US3G3fbyLHEEM518hEuHsk8uM4o5XIkYG71TUKgPvsXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTF11AKUDAla/JxMVzAgbU55w8uo32wArMj1itBhzlC9coEFE5mtYL8NHnrR?=
 =?us-ascii?Q?EZgO6RpsPdkFaKMhaqQxZaBZ0luKRrT6CblqJuuNyr/NlAXxC4yLXrPIWCNy?=
 =?us-ascii?Q?U8sMKoCH67VXQGAMVd3XM/6hTo9iuH/DrORJ67Uer5RQxJkG+HKQMvsrpq9n?=
 =?us-ascii?Q?qbJAnGPog0pfPSYceBzUAa89kvU3Q0Z4Biqcb48RSG2Y6335J8is1R4sUwpb?=
 =?us-ascii?Q?AttgUqmRwJ9VKXaKZeOmZWLkLJugnkFlsEsw3MGOvootHrBjuYuYnipMEP6Q?=
 =?us-ascii?Q?DFazDY513K3PTAOLrqi8ujDAmCUyhXl1xGYcJRSeun+Y/j7idPpQgpqA6VCh?=
 =?us-ascii?Q?10URKHyZIyOmSU3v2mRM8PPBDS3/AbtfVlE1bN9hxFkCnFBTmCV8LsVJpZXM?=
 =?us-ascii?Q?2i8EgZdCjt6bunuD5SAcz86oFDQtu5fGZsRB9WR9RXFevQ8/e5CZpeL8+1iM?=
 =?us-ascii?Q?Hf4dBcFu/TK8dp/ebzJw/x9yaR3rJauF1FCHtinxgcSujlaAtNbPspfc33oB?=
 =?us-ascii?Q?/lSQq5LMvRR17oi1YkXzsopIcTjKRCxeUWPqBUShaVrnqtdc3Wi0N5AuNb0p?=
 =?us-ascii?Q?nMIn5f55ngMEqht+BN6L8Yapq55V39hpC8lK9ixvg6ocpmGhPvBTIHiSf55j?=
 =?us-ascii?Q?wstwqAgoFXaYh/B2FEe79kVbzrFqH8E5BxfLJ12bcUqm+4bxR+e4Vk29ocUa?=
 =?us-ascii?Q?tFKKd5Wg0DicHMqhkmFeR3VAWC73gkjUc/R8FpZyxkdfGAoxi4FTemy8OZ8L?=
 =?us-ascii?Q?BZIAyU6ZBGsguZx2NUzXKo5Ho47iJVBVXEiHX6HXPBTs5Jph/kNnL6haVmoN?=
 =?us-ascii?Q?01lDOMnZryAO7WAkgXF7Aw2v/J5c6CQODX4NCjC+DBcqb4+LAqaP8hRsxMOe?=
 =?us-ascii?Q?Z0HMNswRcHmHo+RD2jIiHBh3FzPG5gjhuu/1ETs0nmzg6uOUbub07RIzbrYW?=
 =?us-ascii?Q?R7L+HuinynABkEkz6QZ0SZOiu3MXgVCib+78yP0paHGUezeyGGTW9Cc9ce1q?=
 =?us-ascii?Q?l/iRP1eG75kyDQft7Q33aFmRAQZrqn5NBA2WdIC93K6RjHsaMd+Oj3dHIoiR?=
 =?us-ascii?Q?Mk/YM5+Cdl2mxwtHYOhPx8quiVfBOneN189CByuzDZKw79FCf/N0tKpiA56k?=
 =?us-ascii?Q?LWMQbzQFOq1XbvX0akCu4oJfe50lADBJfwZHwmLgbC3N21N2+V8cvjIBLPzv?=
 =?us-ascii?Q?M08EmmLfOhhg4n+B3KYRv6HrPJFK5TXFkVmbpvxDYg4/gJTEE9TPMYJvW4iw?=
 =?us-ascii?Q?olcYnLKhWkd5kdebukna7Khz8qSVBsczd4FNmIcZzvqEAd4lU0LPgf4ECXIT?=
 =?us-ascii?Q?dbYmF+NCD2F66dtRr4Tv218iG+93taf0N6+VC+zXKNEb6QGwNntpASMnJkY5?=
 =?us-ascii?Q?bdAVZqiKCz9mveKJT62W67/S0hjfHSJSQ8H6HV7zGEBSGQnO7OlicOByZWvk?=
 =?us-ascii?Q?vrjk+tw/Db7oafri0cBs0zCHcwCTukoYPT8X757iBTSt7y6U9hMRwfrIPHbk?=
 =?us-ascii?Q?c2RJYZV5Q4MBO6JXShG928lLtFtXgjcxcFjRlfvXIXfds2A1x8IQboFDDwBJ?=
 =?us-ascii?Q?VOtjhheFQFjI0VbNPJguZBI0pB8+0p6gDPwq1mF6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9d3f7a-a839-402d-8a17-08dcc09838ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 21:45:20.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDmRqAO0Mk9wne20Yvoez5bpNNDNKLGY0xwvn8BGUh58n08P5z/gt4v9nbQsJ1xTXEqUeiBIknY55EZ6fRcJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10861

On Mon, Aug 19, 2024 at 02:37:00PM -0700, Guenter Roeck wrote:
> On Mon, Aug 19, 2024 at 03:39:38PM -0400, Frank Li wrote:
> > On Mon, Aug 19, 2024 at 08:11:46PM +0100, Mark Brown wrote:
> > > On Mon, Aug 19, 2024 at 03:06:51PM -0400, Frank Li wrote:
> > >
> > > > change from v1 to v2
> > > > - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> > >
> > > I also shouldn't be the maintainer for this specific binding, it should
> > > be someone with knowledge of the devices.  This is a requirement imposed
> > > by the DT people, I'd be happy to just not list a specific maintainer.
> >
> > I remember 'maintainer' is required property for yaml.
> > Look like Guenter Roeck contribute many code for this driver.
> >
>
> Yes, but I do not maintain code or documentation outside the hardware
> monitoring or watchdog subsystems. You want this file attached to the
> regulator subsystem, so you'll have to find a maintainer from that
> subsystem or sign up to maintain it yourself.

How about just leave in origial place? I think you are more familar than
me about this controller!

Frank

>
> Guenter

