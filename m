Return-Path: <linux-kernel+bounces-560913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72464A60AED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22DD3A5C90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091F19883C;
	Fri, 14 Mar 2025 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MZHPQXSl"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BE194C61;
	Fri, 14 Mar 2025 08:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939949; cv=fail; b=hSjiEM2d45UV7J0Ri3+xsNyzVUQXZXONDC8KEzdJ2LJTOzm8dnQ7g4jCqSvNsYDgoSZLcpW95klQjafq01nJMAo9d2pQDoMngeddMVW5TGnLxfT9Mg02Xr/+yWJ/uJQ8nm1tnF7LNdqMX+VzGSyPXNRsETft/8JNe7iQKgJXSEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939949; c=relaxed/simple;
	bh=BYQr1wdO9hek38E2FDk13b40qPLAksAisn6nnaINcTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5KsBvEJK/IJXUOxqbMjZlP3sliXcTNLmciSJa7X1CI2p8DRYodVIGweffPLgTlw57yI6obgc8FQ3DbJ2bygvOKIj295f0I2kuGMTXaujB0sXycoe1poe/FT5pvox148aODay/VrwdGK0gOoh7CXID263rhkl1+DeZhCoPr1U/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MZHPQXSl; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI3mLd8RnzzxkkgO/7RV2TvF0HBvcJglvHGAOc+2hCvDhCQiafMMo9qmLS2x0LsGjwWboEfwNj0UEW5uYa5QPWYjth7ZEUJYWSwDregMLKWjMczwmSHVoXOl2BgKhUI05tWKS2ywhOHqVcllVQuHy+O60y6bXlj+eki9FJq1kW/HnVL+cN3nNjlR4Ke13OCVxHzV+pwMe457RoKGQ9YefCzxExx1Tgej5bT6z+DtYosV1v6zNH+CG+QqFMU+uCZrxZWUK/ljt5dBpCos9aHE1mE+t5sVccGyyllTGz4ufSDyWGI1buYi2DGq9siXGpjgBl2gk73eRC5xWBFrVMj0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYQr1wdO9hek38E2FDk13b40qPLAksAisn6nnaINcTc=;
 b=ODg9GiS62/Ns4Lg/a9RVS6Kb4iDxmFV9RdUxpmBUUiA83f8BrKDBhb5rgg51ZIareTw2OMjAao0uJHR2xHD3ltLxD6R9ucSZy49ABdUrzKoY45ceqtje6Kzk3zjGqa3Y52W3P+y+9DT3Py9jrnZNz8maa5tO0q05N3k7qtTJq1X0w21X6jJ36QiGo2LDKOYKkR0PGMyJm9udGiHRqfIZKsTNcoBG/97OoIwDtZiXiuLAfAc9gy5rug+oTdMuPMBPHDw6LP9RBzQntC8/5AP9z+AqZi+Jh+9y0++3zYGRsBgFvN1gS83sQO6Vt+dMNzlYDrI97nlXqL0fzCL5Y+P7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYQr1wdO9hek38E2FDk13b40qPLAksAisn6nnaINcTc=;
 b=MZHPQXSlYUabkeWTQbNhVV+ZBF/tSOfXv7cys1qNKRFOn9+aTtWxH9143AA/W3sBycpeadtRQeTGSpDQZnbyTp74EuEyFyqkR0T4Xqmi0BJTlLbDCUkMXu24JXuSm84mVUySBr29Gk9lwzQr89PRcbEm19t2NfnRr3zRsHXthdX9iv9t1ghxh6reNjshyeFi7f+NnVIX2qKmylU+grbBWA9VpcOjiH/6KWKSXMO30j1RYeNNn87W/Ly75NIlfCKq+G25cHFW370GtuitZaHPQCwlOvD8Kw/1PoHi2oQ/A5IvvbkDgRGP0rf1W//5RQgbiGKMZLeqQgOm4n/JE2uTyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11067.eurprd04.prod.outlook.com (2603:10a6:150:21a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 08:12:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 08:12:23 +0000
Date: Fri, 14 Mar 2025 17:20:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 13/18] clk: imx: add support for i.MX8MP anatop clock
 driver
Message-ID: <20250314092006.GB12210@nxa18884-linux>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
 <20250306112959.242131-14-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306112959.242131-14-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0e79ab-2df2-4acf-f0d7-08dd62cff2f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvZNxWy/I52TpSJpx/cPNJjBZuGZDov0RUAqqrsOhw5HO8vWUYFkVAY+I+2n?=
 =?us-ascii?Q?K2dZ5LhNS2CUSWfFYo6gMe9xE3HM9p6drbdahE7Vagpf6aoBjsU2zkjUQ+K1?=
 =?us-ascii?Q?BWh5lk+mTx4bA6hFI2mnVXwhQggFrXs+OXycI/kqmWpGBuPeKkLGFXluApjq?=
 =?us-ascii?Q?0udSA/q/TfGmYjk5CAupovZ1oo6ESzBwqa2z6JGXD2LVZi54oYO+baRCGeyS?=
 =?us-ascii?Q?JjucdXHrk3FF74WzswK7FhjIi+YtWyJZpplW1qXyKHp2AzFBYYIAVe3a2WTF?=
 =?us-ascii?Q?GvcIH+IBHz37yg2Umyp2aKhLaED42jLrU/zVVkWxfLZGhbCta1v9C6l84/Md?=
 =?us-ascii?Q?GqTgCuRVAgdFxw9EX0gLectso7zrr2Vrz9hro1Jme8/qn7T9bK0Wr4ynq6lq?=
 =?us-ascii?Q?qpOWPpeDPdeTu14jdniHrT7VRzp6/fdrlT2A8V+o8uc2J2tIWWX9AulIzrBh?=
 =?us-ascii?Q?1tKyHx+s/S1K/YUS9ayjwMec/0gulwUHqDIlmQz1NXJPclthQMUJ7GCeGdnP?=
 =?us-ascii?Q?0egeCRtdB6S5Hm3o2mE85FMnvJxyy57YbSOY7/mJWE+E7Q6kfKhWktD9A6CJ?=
 =?us-ascii?Q?b0zhUmdEzb/IsxdfLp3W7qxrAQ/zQNZx1L+PM42EXBac/quQhDzYqjg4MM1U?=
 =?us-ascii?Q?o+UVVe5HLDuvDmMoroTeTxt/82Sb2YbBI9IDaCDrHKduhtm8r34MAUa5yLg8?=
 =?us-ascii?Q?cy8B08iE0TcqFxI/cC9kA/GctKwAXIbA4gxYJrYeTfH8OEbtYlKdLkLZoSIw?=
 =?us-ascii?Q?Gf3lWP5p6FwexFP85V6lO0bGwQfGij+ErrrI2LEj4O2M9ENTPbe0ePILZbx9?=
 =?us-ascii?Q?32ecizvqQBYFRW9aKHVY1wOcjnWPs32MZ3uLnqtspCdWC5hUF5DvkS3Z5UV+?=
 =?us-ascii?Q?SHph7nOg2+xA5xQ1aZue7IQEDlt/SDLyqnYVmJZ6mkW3xrAj8JV+vg9B7qK2?=
 =?us-ascii?Q?iU72sLpSjp+ttJ2flXC9haCeicuWfeM6LkU0RTScsaCm+bX1wG54uSKjnL2X?=
 =?us-ascii?Q?jVDO2dQXvRTPPEKlo+7YlnJ6NsC5+f0fW02HvM1p7fQ8N8AE8mtjHCZgQAGs?=
 =?us-ascii?Q?sgoCCd/Qzej7DqBcZPHSzlZjU3OQPO1qt0dMKNhLU+3Xs2/MgK3YuuvmUzXw?=
 =?us-ascii?Q?l05aTy12DAyYwI0gutedcxeaREKo2QXhZb7jYlB0CBSDgj5dSw7+dYTfHOaQ?=
 =?us-ascii?Q?/x3ks5gmcOX4/LSRT4rGiP43cOEh30IYBQ9xqnDK76AG4WkbqIQce8zbZMLA?=
 =?us-ascii?Q?TmgWoX2ILbvdH6TY9osHIsj69S97BOzSDIlCNeYziKUzlg+g7jtzkn8vKLZH?=
 =?us-ascii?Q?7jDaNT+6SXP8Ni+HIwFx/SHqxwyrI+2SmUPbxZlzaFYI3BDBCux78HdwZgSi?=
 =?us-ascii?Q?AXbz2TGEPNRgn8lAkCqs2ilbM0hrIKmIuEychNVrHn3pFgw1OB8Oko5cWZe4?=
 =?us-ascii?Q?+aiTLblGcHDm2s49ZIFTTD8pE8cJdDU0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vP9W3x0PU7Gue3WRsilRPyYry8kfpLrt9Kolp9OomPXbWhdRYHOVt5UNXZjT?=
 =?us-ascii?Q?nAwErNYxrqSKR5DpRLbSR37RLqdQ5strIJ/VnVVxuFRrGAU/k3oc9PV+7j5V?=
 =?us-ascii?Q?yIUF7OPFof0gEeNoCLzGL1In6tdFyvOGe0LrCvDyHc2htfJe2LazTQ/N9bpN?=
 =?us-ascii?Q?YGGuLBg9H5IKnTLtuVnii+vPQms8tO69rmnuImu1HrEfjDlp7I7jjRCzg6bE?=
 =?us-ascii?Q?AjfG6I1aHhx8anh8N9Wvr+04N+mFhQeFGiiWUA/XXvMChsaErv5bMrT9g6pt?=
 =?us-ascii?Q?0n3nJyNDW4JH5okku1/cZ1hIQLcQzoee9ig1+kpe2M4PQUEkoULfHe+3EI+8?=
 =?us-ascii?Q?3xQ6O2DXtDcM7WTK+QzfqO1isn2gIFzUTBEHiHrHIvS9hpeWN/QOR+yK7UVT?=
 =?us-ascii?Q?IWQh4GH75xbytMQtvBK0wE3XsOPcdgWmXnNJ9MpWtedbH6vx9VfGTtaVMMYd?=
 =?us-ascii?Q?sXWtWVwRt4cI2yzfiCdo+C8/r6dyJMN+xNG7Zf5eL0y57CjhcUaWxWDR0pUY?=
 =?us-ascii?Q?gzHZGT9ubY5EtlaH2X9Oza0J+H8d6bzJw6yWgn8jqwqwe89vVB5uhJFH0OIk?=
 =?us-ascii?Q?qd7SvdXI1CxrVOl+1077StEadXAGnS9iKFOKv48koZtX4EgM6ozJy8wyyFAm?=
 =?us-ascii?Q?xM9j+umPU9YHZsZJWIDrb1HrcABMYp9IeNK7C4VlRUyetiux/Dx7N6isMGZT?=
 =?us-ascii?Q?zmOSt8K3ttWt+5KJGIMMWJTT6EOI4SE1+U/iViRMSJ+IaJqoKzUmODIYuFke?=
 =?us-ascii?Q?k+gGxqZEpqVgLCVlc+Ar2HuRMZ6JYzCRYvB91h2uy2yis6Eeq8lyA8TO/wzD?=
 =?us-ascii?Q?mRKcy3gYJZBQOeZqbsJBYiWhlJ/XYKK0fo+yqC9DhncjEdhbTkkUerH0wDYI?=
 =?us-ascii?Q?+8j049URx0UGW3TXyg5H+0AojONWVrRCSMwp+OTjuSDF76aXf7DuAPlnvZ95?=
 =?us-ascii?Q?8RUZBxENtnfgLlrQ2Uau3e2ssWuC5ssDxLrPklN1CIMrW+TrJ9/ImyBNxuZp?=
 =?us-ascii?Q?Ef6LijIG5r6aAZ/boHlCINh7S3NdYZilGmeOWGMEMEmJZ0Y+q23nt2Yr8jTC?=
 =?us-ascii?Q?VIDyVbK/tODOSnz5sER2lhMCGto4P+rQYWL6egJALWrK+ck4pCfVSF2I1IEp?=
 =?us-ascii?Q?F3ULWXqbCPvtTzgfJVJU+qPyKvpvICLGTpCmQQqzUk6QiefRntbz/8gMF74N?=
 =?us-ascii?Q?h9jnqohCwWZHpMPHoa7dVS8op2BcYpbah0uCokHzs1yKnk21O3RuDofRKl+A?=
 =?us-ascii?Q?2O+56hy1iFAFiLuFgN2bZkJuhDP4fcOuJs7rFYMlWQy4YRSOfAZPy04Fh1jV?=
 =?us-ascii?Q?A+g7a1EGCo5zolLfo9qTfb8ahdbRif9ss6gDUa66ASHprBkop9NxAyALQcUf?=
 =?us-ascii?Q?W4vUIjaYi/pquhweeuZJBVzRC+vPh6ONWbz4LGeACfgKMEzlkLZS7ShiTkSI?=
 =?us-ascii?Q?pdydGKAKVx3/C1WKziE+1wsZLPGCqCpoTIDZDVrPWhHrQwXJamquLEqlx04e?=
 =?us-ascii?Q?oTIx9fsT24zPS6nxhD7QHxBM0OQdLO1e5YSd0ZVLFfzISuvzIJRQRov02i86?=
 =?us-ascii?Q?/yFweTk3DsKatflGdxM0nOP/X0AdWorIUG2+9FpM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0e79ab-2df2-4acf-f0d7-08dd62cff2f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:12:23.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnPc+NT9oTKM1NF8mXzJTfZb70F8kqIW6xPWHgwSzkEIbKDzta6Dw4Qr24EZoreTUHkovTHe+dOQLRmG/ozwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11067

On Thu, Mar 06, 2025 at 12:28:02PM +0100, Dario Binacchi wrote:
>Support NXP i.MX8P anatop PLL module which generates PLLs to CCM root.
>By doing so, we also simplify the CCM driver code. The changes are
>backward compatible.
>
>Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

