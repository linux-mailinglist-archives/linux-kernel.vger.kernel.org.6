Return-Path: <linux-kernel+bounces-234763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7691CABA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DE2845F6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC311CD3D;
	Sat, 29 Jun 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cy87gH/r"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BABA42;
	Sat, 29 Jun 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719629465; cv=fail; b=GRroaS0KfQSRVq/WzvDxKLmZN94Aza8Zr1Vd+bExDotCAv63SkXP4+AL3kPZPU8b871XTvIKVCPIX3zUkSctlUqO2MaAb0lM+0rsFVn5ugcVEdT65RGFB/v5PA8KfSfFWZy+/kcpHIWszUYuPpcrMIS7t4/Jt2WpcQQraj63yqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719629465; c=relaxed/simple;
	bh=KcNX8bt2ka3EoIzbKzVL57xc2KWTjijez/oHSWujrr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l/KbCM1zu6qRPPZea4ZSolN+Pc/ij7F/9/HLSFJZQCUO7JmTaYHCOLSM3K2Q9ZX2fxG0XfjiE6sXtyrU/YbRC7vvo3ev2k+xqojljhIZYxWAGGVsy1dE+/gDSPwV2k5zvLVDDVSSygH8uRs/fRUlhxF0FJiSFbXa6l9pSBX/FmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cy87gH/r; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbgmczOerrM0q/cmx1iKbottVxjuKu2aITcX9QaUoykqjlKYKN+eEJ6vkUFx8UarCx9wxITZvPN78ixDBAUkhlbFCR6crHLvNW7XdQ2MP/WH/mEKz2IvIBNSSKXOmBjGDfI0fhHQyOqZ3j6xMFYWc8PyoDpUQR4WlHzjgsYWOCDHPDBypavs2vkigD0e6iqq14bRlCQz2VwzdRUazeTscFQ9YVM93xJEBhT5opLNyYGhC6CiotR2nkZ1O1a8eZiwtavhegl0MmtxLbCqfe2NOkJ7UVta2BM+96RBWAHnrGuLuCZQXwLaFvBdAAT5f5qKxHi6D3b0fmoTpWaGc8hckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWzfBGJUdfOab4KuAyR3SmGkr8XJRnEmhUXtj/DkOn0=;
 b=OQFskNbPTZrvqnf1m2CJu4XKVTXT9gFAqAq7d0VWKnsi0qmQXlL6876yK+R8wL76cP3hiIq1YXVuFeTs4hWBGONtpQd8OlDtqyatC87A6YBHHQJqLqK4I+8e0uUxYWdqSH8owMqSOK0g1DgAncArhmT0P3QyOdEktUDNtye3afnLKz3bDSBhrLUhKfjqzAGgKPkGpovIBWtAwJFwTqNJshveWCPt4hi+zF9ubW9QMA1HgjMohT6nCq65zuI2XmX2ZgHcW1xaG25FWSrrDxzQXVsE/lAuCOEdaSgljItkcLohjBBhwG6gfKvEXGVTNIu7CA5hnKTs6fk08zNlHZ/YEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWzfBGJUdfOab4KuAyR3SmGkr8XJRnEmhUXtj/DkOn0=;
 b=cy87gH/r87/S14ZHWILvMuEaThcyOA/FMsI2773s8OoSg7FIGlZ1iE53IyUoDWh52Zwl7Y1xbid6hN7UMmlztVSTqbb19NI4+rcoAYUIqxiggA10HMkz9WdEtSY1mEW4qwvzD/uFDU5D5642vus6qam455jmGexwIcFgyWe1DW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB10243.eurprd04.prod.outlook.com (2603:10a6:150:17d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sat, 29 Jun
 2024 02:50:58 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 02:50:58 +0000
Date: Sat, 29 Jun 2024 10:49:49 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <Zn92TX9ZsHde7g2f@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-2-pengfei.li_1@nxp.com>
 <60f9e733-f5bd-4bfc-9bd5-94ae18bb3901@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f9e733-f5bd-4bfc-9bd5-94ae18bb3901@kernel.org>
X-ClientProxiedBy: AM4PR0302CA0002.eurprd03.prod.outlook.com
 (2603:10a6:205:2::15) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB10243:EE_
X-MS-Office365-Filtering-Correlation-Id: db6462dc-6ded-4a19-9278-08dc97e64d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9LQSxOH62cBeB53MMCZPwrG4Guh6d39eYU8EAvoy2bdelHcBO1kcut2tX6Y7?=
 =?us-ascii?Q?0PpSLAg6iyXEsG6GBGDPCNjwsOF6qgqcKyD//IhuQTQaMUaIuwF2Yv6f0m8P?=
 =?us-ascii?Q?e3KbFnqukGM8bHiYfpHcAVXeJJkmGHagwdmyiR7Gug5RxaB99tAMfRfcdCeH?=
 =?us-ascii?Q?D3akDWKVs5IguYb6hKJwrmaFNX+OV7HSbbZf2BkAJHaJa+ybXj29F7atbiQF?=
 =?us-ascii?Q?lELeq7qXTrdOKrfskLrL/QU5UCgWhpY2fboR0LrHHolM4/PIxkItMdPipiGM?=
 =?us-ascii?Q?UAWb4GChz/pH73jw1B44+ADu/0VTLXFdTLOFjxvc6CaiLfHh9OmxLFL32CBl?=
 =?us-ascii?Q?alX4wTa5GxahOi/Vd1qxsu1U/0DGFDSiI8aX6QjIwwEJ7dLpFACnmV5Ck61N?=
 =?us-ascii?Q?TJ/EKb8DY4ukF5xSbnH7zfvxz4xeS8FKY+K9zPpjdivb4+KVHaorCTXauuCm?=
 =?us-ascii?Q?ki8P+5KTfDe6GSN+zX3HGab15Xea9mTzZb+Vhr8mbwAgL/mC2OSh6cN/xAek?=
 =?us-ascii?Q?3b1Up5z1Wrh7F8sjJhjnT0RGcjy9x4M/+Wwneg3Q/tQwq7sGDJ37CiCwEfW5?=
 =?us-ascii?Q?HzZkb8yLuSjj7RusQteP8/+5crRpAZHAjQnnAyqdIExA09rc3sB0+iYv3Mzd?=
 =?us-ascii?Q?TWFs1H35YaJPyQkS7ESDjjQZ9QZYMQ9lRLHGqo9zOk17MVVoB748Mw24LVW2?=
 =?us-ascii?Q?7rflOv0J3Wn/4RrPjYtqMiMbfbK+B97PHoKdI6a19wBaE1eASAmcTkM8IZkM?=
 =?us-ascii?Q?UzEaeKgKsa6fkOa958QTrpj1LsUpeYl8KKuZ1pdY7/U1c959yro9Xo15W/+Q?=
 =?us-ascii?Q?cyWv+Az78rZ+Xhe5OU9+uWCn3/IusKrTSvgUYOFFm0uM0uVjEbRcU3Z0d9Ny?=
 =?us-ascii?Q?CRYn1BHXAx+QsJGecuDXh2AFDtIRT44/yuTUMAM2wUXYn4Ub25yvZqKyhH3I?=
 =?us-ascii?Q?hA2djqh67PLOsD/PzUlEzood13yr420ShZISJ9XpZMmjwwg6n/rUf1IFmaVV?=
 =?us-ascii?Q?wVhjCCBLAgPc9fMwbCOmoTcf8QFegJIssqfNNcycCmwWnSpi75gzYl2KkRKx?=
 =?us-ascii?Q?U0BcDU/h6ciW5WeewtdlNHPaOHRsetyQtOSCvvPM60V4bU0bp3oGBfSXXnEu?=
 =?us-ascii?Q?/8nhA/ds+vzBh6CYMAgc+t8eZ1Vf+KFrOZERtzulIGUJyfHA9WIJwz5GUY+d?=
 =?us-ascii?Q?yPNfjCz5Shx1fbz+5gjTfTxLX9fvw0d1yOZZ0j4OISAxAdKpTjPRRduImaLD?=
 =?us-ascii?Q?d11psZzCec5jR487614KBQxxoPeRXpn0IHLd2IWp42RFaw/90YZ5bayjEPkR?=
 =?us-ascii?Q?7D9YpnjhFbO7kf4fxwosxa+vyFE+iUXEPUN4UB+rftutWNL60xqEUv3yVi9G?=
 =?us-ascii?Q?HvKROcSlLbT2HgIA9fsbkz9HmZseWg8SwHAhoO2ixSvFvERYvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pps+EvDkk9jlkTgap/lFcuTSsYIST4k8N4zT1fOW6ug6YFAeKkTLOrfJ2+lU?=
 =?us-ascii?Q?TG0Y+nlzCzUG+FQKOXWazsrSQjv7tVq2zKTLAlhnH7TOUFpvJLYNBEkOAgzE?=
 =?us-ascii?Q?CCr5OhnPs0K4hN993IyXykLS3ptVu7jvfQa6S1t+ObB+WWHVHk7XL14cfJ/z?=
 =?us-ascii?Q?fySOJgftjGJMbyvQycWE53lykyMq9orm6g7Z5E1LkUxNgpMxq8qNrQInkYAe?=
 =?us-ascii?Q?SZyA2i0VOrJdlkIFriN782UdkWoTBMTn7W0w+ADrA0GDQ8recj9nNiiJqTtm?=
 =?us-ascii?Q?KBkyu/w9GJI1rfTZVpLpC2Jcqtp8VNzbwzLIKRGztDFNs3KivstxyXrbX0zX?=
 =?us-ascii?Q?CaGGaczzUs3lPvW18w2C7S+o+U1wK0FAM0dM43PWN3paH7iJwDhc7IVsz8RL?=
 =?us-ascii?Q?TAR7zsoZIRG8AMjmV1Oq7jMCVKamSU4PaQctZVDPtD5IkGQahIaiHVlK5pAT?=
 =?us-ascii?Q?feb6k0Afx12QviikgqKGQpp9QImh3D9ALUgh6v0MJr0ifBpEBU9kaOOHrl0h?=
 =?us-ascii?Q?27rF/RCkNrzhAPBMTinoihT+CcadYey1BTQ423QdOlQwhbpdxfTAUUmCm1p/?=
 =?us-ascii?Q?mBLpaK308ff3+dr4evUIilrOqRxYA1GNCeHtDSbWTcZrVry2J7C9p1/TvAJa?=
 =?us-ascii?Q?m2J4fYbv0rFUsCHzZynTjEAPn8z2lSTbGK5CWyfEMQAxRaosAQ3wEsAimvFM?=
 =?us-ascii?Q?EWGCzuC2/TUBxtMxMzGAwSnhtMcpSgRd7K1fHp64OehOoU9WSWsKpgQqea13?=
 =?us-ascii?Q?5WsKDz2Rc/DsMgGdrgui4qN/FIBcJiERIlDNqkvvB3iU5FZrbKOqq4TCkGEf?=
 =?us-ascii?Q?QiCVhst4MTcqhpol44szZa3TTzTO0bWis5gtgBhjhfMOlTNG3dpkxRmtrxVc?=
 =?us-ascii?Q?B/IObMOAYYUlNOwTJFNGcW+d0AcJSLH+SCGg6BSKZFagp+L7wvqpJ/HLShoM?=
 =?us-ascii?Q?7exwSsEmRJ2FwexQL7dwAj3i+3r6OJe1VEiZsBiEuk9Rns6LdT8qk5oGX3sK?=
 =?us-ascii?Q?6tXYyJguQy4Db8rBvffuKVFXC9yT64CpRkCkFFSj3ZBJjjySntfdXCilPnd6?=
 =?us-ascii?Q?UPBNgFCjKJGEXrybmktj7ZyEJ5eJb+2mK9GuJJs3bVIb+MfUPFbEpGEjn5zY?=
 =?us-ascii?Q?sHltjN3uaDg6rewhkbxnQ7UCBbqP5w3qgocWdLhZfa+DbkvxuyN80pZ/csRy?=
 =?us-ascii?Q?E3RRLDhIxs5WdLCxmTXTzmST3c/k7X0R+bi9uytbE4IfxkNqPQh2LlSxu3pw?=
 =?us-ascii?Q?x2At8TBlXEUwiBtlMszS7GNLeBIfH8YiO4dpW9JolDCtKzcmlzGtHTFxNSTl?=
 =?us-ascii?Q?8uatk7yeG5TBoETHqsTHMXbZgYFqhxYJ/9FWLe9ffuoFJSpy0IjnEMsqRClD?=
 =?us-ascii?Q?uCPdA8d0h5cFn9wdBba6iSC2rxbJaYtPYoGMGH+O2ikmVBuECXUgESvP+G+I?=
 =?us-ascii?Q?oCUPZB1e9qDT6URXieEFzBqcCJgD7J42qHBUCBjmvUQLP41zv3FHkS9fnhrt?=
 =?us-ascii?Q?E1fweLAqQILRTimG4G3EKHBrBHs9pCEcejMdgY+tiGFjEChqZhZYiV0dRFI0?=
 =?us-ascii?Q?gt2w8CudujZgc/9K7BMMEHU9V8Q4dP0t6Hp6z0Qp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6462dc-6ded-4a19-9278-08dc97e64d9c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 02:50:58.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypy1fv01HdIESQ59RxvIbZAghlSKk1UXSO+kLwYJSGNjthEdXvbDhMdDZRA+m9+OnEbUTvS0SC56PUeH9OMRIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10243

On Fri, Jun 28, 2024 at 09:38:54AM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2024 10:24, Pengfei Li wrote:
> > IMX93_CLK_END was previously defined in imx93-clock.h to indicate
> > the number of clocks, but it is not part of the ABI, so it should
> > be moved to clk driver.
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > ---
> > 
> > Notes:
> >     Change for v2:
> >     - Use pre-processor define to simplify code.
> > 
> >  drivers/clk/imx/clk-imx93.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Are you sure this builds fine? If you need to define it here, it means
> some part of that unit file already uses the define. If so, you include
> the header. If you include the header, you should see fat warning.
> 
> Really, people, just build your patches...
> 
> Best regards,
> Krzysztof
> 
> 

Hi Krzysztof,

Yes, you're right, this macro definition has indeed been used. But
this clk-imx93.c driver file is the only place where this macro is
used. So maybe it would be more appropriate to define this macro in
C rather than in the header file. Meanwhile, I also built my patch,
but no warnings were found.

BR,
Pengfei Li

