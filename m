Return-Path: <linux-kernel+bounces-292806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A925C9574A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370801F219BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008331DC488;
	Mon, 19 Aug 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lqEFOfxX"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC3145341;
	Mon, 19 Aug 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096394; cv=fail; b=Sr4i54CTIEdyKvIycLcUAp384ucEXl3fcq4BB0XyVJWpiy8V8hcZaalB6LfII/SbIf/zZCy/MsePOUMW0ftpt/WTXXKvOqHOV0xTziZK11fz842cpXm8Kc3ANVReB0vlvGHrxDEI6qhuE6p1mlgmK3nLlQm/jUzjbsuW2EK8hdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096394; c=relaxed/simple;
	bh=UQm7xkVpR2yVu2Z3t1azsrBrcVZ4aNElPWl2Fczp7BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jbsEmZNJ1gwxViZO4nNS1iCw0GMrrbiiLWyQJNq7f3Uz7AZpYRmnzMTxiDLcOUW4TJU8FUD3/DvLLgwdrCoAT/kTHk3eot8Rpdsl+Q4200edYtruVWMuwq37sqEptc5AhRKlLXDUOosZKU7hWb746eqfcnvCc9nuhp2mRi5xEm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lqEFOfxX; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug5SZGEzmM/YFJai1+VcvplFSvYcfT1+SuCHa1Ik2o6x6os6nBQFBodqcnVI8W/V9fY8xK94Ay1MNHc+aq51Ak5KINpS+3BJbmNjzMgbqmPEE8Nhv8tV97OQUZOiez3ru8/zoIvN5QQHnOPGI/rmnn+lP0le2Pw5HTv9WNUTwh88FPEfbq4BVDVnjjkpR+tnGezpMJ+XPg8LH+1bqf2HZd3y5PY1AodiRpniBIHT5/jTQJBoKoGO95ENrf7uNvqxwLHOeGl2J7aoK7T7EWIBCjOLvRYKVnM8RUhyL0brxiagBN7l5GckmFM2KUUuCN9csI2a31ZujlHn3vjqgYy4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dY3z63HCoIC8Zv0Ea3zO5MZwzpYcbMdrb1pEZtvAbo=;
 b=R1N759qGdFzC9Xm8yMyvMsUTE4jb6QyLLl6GZHjRDxi7pgI0Lu7Hm6MzhDvaYCt/IhWwbzkSrIgUc+Si7F6hY9hPgNE38ii7hyPW+zauBnN6Uw9Fy8KQDzGTsREm0AA/YORYez6tRoU8G4cr745B/tBnlWbM6nEDRs9FxBAicqg8VV628r/jWmC12q31EzUor6VH0EVriTV3uOexiILfh9D20JY12fKWUuiWrxvp8cgK6qSEEgw/S9EQ/O/3a/j+buBNL2JsAlSIYEQ6QADa56b0OjgKHNjtMnvAJykUMq7BTsoFE7JYif1osACEkCw+hde/lcySLmh144hEXYJWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dY3z63HCoIC8Zv0Ea3zO5MZwzpYcbMdrb1pEZtvAbo=;
 b=lqEFOfxXlEH7ya4wDZRb/QoChNRs8KWT/+M0IsYSjd7GBhVyYJL2/a9jr2m3jLZB2P6gZ8VC2j6/ITItrNOnHxgZY5eqa/SabVCmYBsrzR2bdODvfmQHh6wdDl6DM83oL2SsVaZS0v4/Lpw2KW+dAToLGaooTdpt0vH4jP2lAcf0Q77iwfxfy4cpuShGLvWxJCH2IDeJ0z9phR2f1SZ6Pzzz3TcW2TVyT1l+aCgMW+FNI7S1jIeXPSG4nuXH81/+165ePiY5yPXXYcGGMEOPVU9d9teFSOdNgzzn8TbhIDO126oGd44pzCtrkgAUB4bJ6FzcbM+PiEpkEpZGG05vFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10596.eurprd04.prod.outlook.com (2603:10a6:800:278::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:39:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:39:48 +0000
Date: Mon, 19 Aug 2024 15:39:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
Message-ID: <ZsOfeimD94+mh5gt@lizhi-Precision-Tower-5810>
References: <20240819190652.373222-1-Frank.Li@nxp.com>
 <bea0d3be-6b2a-41a7-8644-44b17d3a26dc@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea0d3be-6b2a-41a7-8644-44b17d3a26dc@sirena.org.uk>
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10596:EE_
X-MS-Office365-Filtering-Correlation-Id: a35c4bdc-60a9-4048-d99e-08dcc086af88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?seQYdTwCEfVbQTCZ1YQOi5VPq2iLLkxlotw1SpDRlU1yFVIeRzmDi1daM33H?=
 =?us-ascii?Q?0+9eplAuydZLdoOWJOYv0fR0z18UybYj1Y+8uGkq8fd5OPPu2N9IvBvj3O3a?=
 =?us-ascii?Q?cilqfj+MvZbJcvPuNEUd/okTt9nEHQaAHYY5KAvy7ISz0iK35cOKRZCHxlls?=
 =?us-ascii?Q?CIFnO00eASd41L9x0+HMcuFxcW3TqeaCCDjdGILBcXyLFzn+AOKobTw8DylG?=
 =?us-ascii?Q?VN0qsX+8BruMKucU0MxMWefnuY5mTqtPEXaGwP1VC5MH/XJzWNB7CtHNBj79?=
 =?us-ascii?Q?Ce9YzuaT/pCuxplV/9iW1M2Wzh/3SFsiKyLlE6LVRHhvWg8vquHJY4QKyQGj?=
 =?us-ascii?Q?G37GHx1oOyD3mZSi8WuNVTki6+a4n4oDwH/ZMWA92j79VT1ho1kOZjFEt+2d?=
 =?us-ascii?Q?s4GZuc13716naro6Tnj7rr67LGzuhoo/1NuCvnUK2t9XHDNYgsbkgblWh0us?=
 =?us-ascii?Q?ZzdVOZwHgMNyFNqm86XRieCLOZpXdho+vTUbcWFqT5NaZrlAh5j1bvT8aC0h?=
 =?us-ascii?Q?5hxfSwDY7MnlGslZpgh6rS08T3o2wLMvTwSyOPbIXPe3EE4Dg32zK7D60k+Y?=
 =?us-ascii?Q?xiQdOT3bLgUUfFkp+EmksXjMesn8D3NKGvCwuDf/r7pUMwC8Muw46S72JiGF?=
 =?us-ascii?Q?65hhobK8k7NTljq71UM1L4vF33fAGLtZ75k0Xf6FcYbNWHP57B4erXDw68x7?=
 =?us-ascii?Q?4eNaN8Ov/5UjleiKVvfG+E6G+ezTX3S0/hhr9nUgppXJsW+SS0roIaSIVAHU?=
 =?us-ascii?Q?NL7Pk1jeZx83J4EgngELx7WNVBOM2zSi7LfDsdpJXyaqEL4YyvsM7usZxg1C?=
 =?us-ascii?Q?o0TyjiPuiQF5BG7T/nxTmgUIRiCoqW812IxGSZdUyupSWOtAXoI8l/liESH1?=
 =?us-ascii?Q?3IcGdZGgeGeKSge9+4st9Mlxn1PWINXSSxhPJO9TijnuIE8yzhj1HTdkV2Hh?=
 =?us-ascii?Q?210fm4lVYViyFoDQ8738QTLCwEFd16CArqltqvjjxDrd9+b3Y3Gui3gDTFd4?=
 =?us-ascii?Q?c2uuBr3NccdM+4wVu1HpQurPnCFGi9qjyhuaBTnRMvKeVMSSxm73D/gbaUZU?=
 =?us-ascii?Q?UfBv5MsFcWs/WRtTnYf9dDJX864Ear10LhKUP9n9VMwK1L9S4lXYZwv7cSPG?=
 =?us-ascii?Q?DIvOtwxjOk2syLQPe+yy1RWN7Wq0fPvirDbBl+34FD7ZGNZoRSCDTQ+DLuiC?=
 =?us-ascii?Q?RcjK1XAGVfz+jH/ygG9AF6YYMToio4jRNFPQt5s+hh9j47b8NjKPDXKzh1/r?=
 =?us-ascii?Q?+Oy+/NyIwwN5XcOdC+vUhIBnyL4zqbhtQzADu2JE5M5Ilo2zQsWjnJVqj2lZ?=
 =?us-ascii?Q?xxim/kKO25GuvMgC1LDSrHjNd/pPgNCIjguNDMqOmqYSU1kvbMFufvUtBo6/?=
 =?us-ascii?Q?DlH31+TAbEY0GAgRVugJ8+x9rs9DnAn2QepPgbGipzMwf0wNCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iiC21of674k1aPkDYW1UH58FXUG0TVH/u4tyt9WZ9VTVc/EskhM+OZXiJYdY?=
 =?us-ascii?Q?t4xOKqc62r0XPGdl4K0V7A3H5HHsoi1i5N7Qeue3bmQRsHjTPe7zr5VhEqjj?=
 =?us-ascii?Q?dJytxiOptSuey8+3xnG7Rb3hFAcRKHSUoCj2VnaicMEBqg3L5GfslQohCIia?=
 =?us-ascii?Q?XVDcFzD6wPUOf5XL7ESIDHAcMJ7UeDamxcfa+p7uXGEfYFpTeuRq3GOFnLE4?=
 =?us-ascii?Q?NV8/+B3ylwsOsww1mioXIvTa/ElW2vQiZo5ccMheG+W5lynTGOzmylhIuGtY?=
 =?us-ascii?Q?j5hJ38+zZpLuTEezO6Hq8PdC8amnmY+u1D2bj9fIOEzC9W7Q6YowCOUQ/ExZ?=
 =?us-ascii?Q?GqjejAlUzaduROc4F7Wpt1gMQmD0yzB+sUyD5w1PsnZaFl+tJrFicocTrck+?=
 =?us-ascii?Q?Cl9CT939dfb7eqgP3OSPu5yL/CqzTzsE1JH377odqd/lkl9r+9/vOiOEwbji?=
 =?us-ascii?Q?r1iAGWv39LlSQok/SAlNBFe+lOrtXXvnMGUy8dug0Y17umaQUbf9w8HjE2qD?=
 =?us-ascii?Q?k33Z/pKK0Wo43wIxPGNOAzoszceoCjcXxGVSOYxva8JaglwhH6IU3EE6MYhp?=
 =?us-ascii?Q?jPLkOLxUWFKDNh0VTK+wacE7u30MjVLFby7qf5eBx/WNwwzOFIJeh5ojh1gw?=
 =?us-ascii?Q?cUdYjIqTtzke/TYNKe56UhdSDO+aQBRCdA6m7H0FU9bn8cPsy4wdv9j4TA2Z?=
 =?us-ascii?Q?3gC0qaYci8sp4BBrN+qkEaPDSXGcpF0+XUtX7R8ylh5JLNbPZrm08BZTJajW?=
 =?us-ascii?Q?jq/KlzbHzSLgBtA4Ds3KSd0uoCWNzS+uhe5hr7Hvxp+la3K0lN9TcihfP5yt?=
 =?us-ascii?Q?QIRWNmWXO7KmKAvwGqBQrL2hpphsIj9ZwfQfiIIa2ofVFPvdUrUjfg9MtfGb?=
 =?us-ascii?Q?/VH54zhtaN+5S3jDnvv4Xcgrngd7X/OJYFztyAfbPqkooKT0Hggl97FQ+bWh?=
 =?us-ascii?Q?0hCoNCA4nlRiYEDE2yfTw7oNBlgADnX8mJgTtBqiNPdt+tIB8zUKxwcEj5Yl?=
 =?us-ascii?Q?5t0hMb/UxwgvhR9cU3+0JU/0do17H0qTlM3o4KhDCXgPGfdtajKh64hZhW6l?=
 =?us-ascii?Q?Pu5qMmGVBIC/+cZ8S56Nfy49NPGpGJZI0bUxmJ38bZeDl5L5Jof2F7IFHZhJ?=
 =?us-ascii?Q?KuCTKETh+uPei/XGCdTi1Q6qBmayIRFpejiJJzeZ/aWYX2k4LbyU+uuvlCyY?=
 =?us-ascii?Q?L6o00d/hIh1i22b6tqD4JQpiGhVpm35/u0mp0m9mHFkdZT0iHShupsW33H4w?=
 =?us-ascii?Q?MUW2/aND2ce9ZqHRFFUe77f8Bnc+a+dzuh+2qWnkCfZgYeIJMEJ1o+ravE4i?=
 =?us-ascii?Q?v6N5507aBVyd1whefTEs4LN0biDgGJH+Pg7sAXPxveo7D8M8FU6ASGb3qxw0?=
 =?us-ascii?Q?RT0dwpqJW8Ad0kuN5kCA8/TBvcgWnlJnC3FQeDFN5sgFPrYGJuw2OJ2NFKyo?=
 =?us-ascii?Q?B+umlyYUirTKGP9ftfkh8UxVnCLabk8o4YPkITlM83hQpwn7lfQaW2k8XW27?=
 =?us-ascii?Q?n0h1GBCfAjNfpz2xVMS5TzxAKunHfsWDLoHodc4RdT8Lo4tUNKsGQ+lBGRLX?=
 =?us-ascii?Q?vTx32qT2WquC+RJlZkoNTLByDQr0/ZSC1QH4mSN1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35c4bdc-60a9-4048-d99e-08dcc086af88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:39:48.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgQKo2ZJno4t2y4dk1ohIR/O4Qez2NSTnydv24nVP+pdwCEvrYZjyCMdhRn0vcMzd5DGdWX0WVBqUrTWKPXpnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10596

On Mon, Aug 19, 2024 at 08:11:46PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2024 at 03:06:51PM -0400, Frank Li wrote:
>
> > change from v1 to v2
> > - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
>
> I also shouldn't be the maintainer for this specific binding, it should
> be someone with knowledge of the devices.  This is a requirement imposed
> by the DT people, I'd be happy to just not list a specific maintainer.

I remember 'maintainer' is required property for yaml.
Look like Guenter Roeck contribute many code for this driver.

Frank


