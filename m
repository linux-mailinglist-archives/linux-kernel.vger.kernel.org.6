Return-Path: <linux-kernel+bounces-275881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC8948B75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9FF1F23988
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E7E1BD015;
	Tue,  6 Aug 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PvMmLEj3"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B141BB696;
	Tue,  6 Aug 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933511; cv=fail; b=cuSe1K6Dn6VwXtUMGhDtXFNnKcl/fs5PtkbGhjes6m4PladYcGdUo/VWnu3oVy0KlhyGX1/T6v9LLqlH2/6B65sDTHbfs2PhWJMMvPdYJ3/HYtETExCnUoDO366ZzSgYs6ACz1+UPoOHUGCgby0AoQtjDwoMqsTC+uoXoDKOFlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933511; c=relaxed/simple;
	bh=UKmnkklliyuoNhCxnUo9/MG3gnMyMFEDIsHlqD5F+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i967BtVZXHyMYEqRyvHjE8dxlVCUJxwGa4bxi2Xez10hbqeGi38TrhIjiJM06OvbBjNzfjf9l8NRAP+oGjm2p6CdS5M2N9rWlxHzDllw832/f9dwAAxsN0/w5gHGqP79tKglX44SjYx4lDVIssg31+pg0r56JWEKFJCUwNO/hmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PvMmLEj3; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuFQXLzSVVM7HNWtAmm2rnYtTTMWWgW5LPT/LQQpFyoEOFlnocN46JiMu7OCb+ZoxFBY4D82RbrlTmK9uosf4VHJmKBRYSuWYetP/pw/1LtSurApTD+NS4Ze0iP+16utybbbVI32qv7Jwn4418qgtBut8Zvv88CSfR3oRl6YcS2AT/lZLsrDHpj5LYX10sat1D1Q+osn7oJZPTsfg6bIzJ8Mw4ADhOSxnXOdlj01j/LL2Q3LnR/KO+MFd/7FiRVtX1+ntg0wMYxyGr/Lk5wCpFINbczg1WYbVzLsJgeuq4qhgLsM4sxmD9DPHcLB2ySZMAVHlnMXTPviTohNhBN5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C17uZ7vPTaPiooqKmk8fElKXa+l2I6zR8hRcNfjtjsU=;
 b=r3aPqXw6W5MK8LV4bNWBGZ27wcLj8Z0Tkfwms47hztC7AnqgwMNJQFX2Hp27LR02exFHqaH6BnlfU4SYRBK5XLwFQhFINfEmCmr4iheLDAN3m7Vfe+Tb0mP6/FZZi49hJLM2vHsS4yAprss3Pnzj0wea3xX7TNVpNxlvqaYVVUN7jd2Fv9a6oOQZo0VRxgyPuZ6HdC9rBaCcFFrkPXGcHlZA/dvpmbQCOZi8EPOLnhDWWIqnTFUGZyOT9nmRSN7QoBKnV8I6abgKuP/c99dAi5szNBzd0UPrlkU98x1AaCQjqqWoMX34yK7hcJ63YKXWiUKEnFwXBRBqvWOa4YxvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C17uZ7vPTaPiooqKmk8fElKXa+l2I6zR8hRcNfjtjsU=;
 b=PvMmLEj3mhzFdQcSeQiv+IoFNJ2MjsJJvTKY696bk/Xk77y/tpvYHGU9+cQSuIw07wr+O5F4/yjoMAsFgD1gO15ArF46e++oW+mR88qeCzDaC5OHrccOMJxr2U2czZ9qQHsGIzvR6lvxRTLSLr60vPLaGae+ejnhal8+7YWjRUS6fc0rOIA/xw/8G+937O0rG9COlEeANMSGqiI8yynoAEo9MdyW0Bl3iyrZ92MSFCWtXYDqXDUy7VmiEc34752EHVVlpAXuMvYeQO59Bod/s3b2Z/uvi+2HjCN+nCVq1ml5vdh2MVqbXq5KwO87LvUw8srLLPu21DT3cYtJD6kxGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 08:38:23 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:38:23 +0000
Date: Tue, 6 Aug 2024 16:36:54 +0800
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
Message-ID: <ZrHgpuvoXqsoqTJj@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <20240627082426.394937-2-pengfei.li_1@nxp.com>
 <60f9e733-f5bd-4bfc-9bd5-94ae18bb3901@kernel.org>
 <Zn92TX9ZsHde7g2f@pengfei-OptiPlex-Tower-Plus-7010>
 <ZpoCxmvgKNgvx4Kw@pengfei-OptiPlex-Tower-Plus-7010>
 <0cddd005-6997-4159-8841-beb837957f0c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cddd005-6997-4159-8841-beb837957f0c@kernel.org>
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AS8PR04MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: b97b3d1e-7d9c-43d5-ff84-08dcb5f3222b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiZYA8QiPogIwQWJAdUXKWnH1SvMleOW6z4CnwIJCiYEG4JR2bFUa8lAv7wd?=
 =?us-ascii?Q?Swd2MFG4m3pJf3/hiQbSPRDoRLxKXHoE54wDrHhSIOKr4EFx1F2GwgPKR45l?=
 =?us-ascii?Q?oQO/OpJegZ7n+Q4fLQuh0og9qG0oY1dcMn46F6pp/n6qRoRnvr/I9bOn0Uw1?=
 =?us-ascii?Q?2j2BdiLRD1F2pK3LMeofagZF6ogzd6AMpNqYqBPoq7VZI2xLLVmzw+C/rSCw?=
 =?us-ascii?Q?RrGY6D5cvd6FjSxDgmFv3AZFt4L0uu7wDvey8vwr577AuML5NCMzO9gOVfT2?=
 =?us-ascii?Q?I1yI9Ft0neKOFC32mcbCScLgIW7rDKKlL5f3JVriLGlEfG6h9BCoeY3MVt/q?=
 =?us-ascii?Q?wc6RLX9iUzIxW+qBiAzp6QrxVVHqtJP3pHDdCN4e64Esxas8eeRz9vuJPotq?=
 =?us-ascii?Q?Pvi8SPlcP3guK/cnflHOaFkdP66slzaESEfoyNgwGs3TwuFxTLosi6i3eBjy?=
 =?us-ascii?Q?JfQ4HuY3QyvoAL/24Vy/9VC3nswgG1wviF2fx9E3mL5qkGKxu869v79cl/lH?=
 =?us-ascii?Q?W19uWyQd6yXdiwl7IuGoOgDRuXUTbObONB9oMND3XCVvTAFCYkOKGQORpIMa?=
 =?us-ascii?Q?hijdRJ2NTjQpGOCU2cKIs+4FE8g+nHvr9dqMqNkTnKsLudrZBZIdo7s8I0M6?=
 =?us-ascii?Q?RtxcCyHFk/3n8BP5VK7T2VePCgyigw3aNkLDBlygkyr6JdBZgbXMgWakySF5?=
 =?us-ascii?Q?0/j11B9fN17cLqrunYwB0f8ItvQpUSKHsVS7pHR7pff1Gmq5s2fXl9AMOwIB?=
 =?us-ascii?Q?4F1r3wSmUYnaAfeEfMK71HhDITZ/GJcNR4mj08MkHy6bE7xtW2q85I9CtWBQ?=
 =?us-ascii?Q?YYuEDwx5KrpBdb3jhygwrpiubKW9LucfG0v+Sra8Idh7RHwg0GPFAVnYDUkZ?=
 =?us-ascii?Q?akst2tuefnu/++tbGXcMf1IaooU9JYq9liocp7W9EKv6IglTVBHSpcL6vNli?=
 =?us-ascii?Q?IoMLDPI4PrpYXVi1eVQLgczjtd1lf/CN8cq2IGu6cDiN5KsOBRnNUp5KlZZq?=
 =?us-ascii?Q?e/MXp5aGIdJP3tnSG9hiM39RprK/fCr9s21xJ5Xymm+2JT2BUeRke/FPI3j1?=
 =?us-ascii?Q?+xOBYp4evmL2l8l5xxfDoanAMNzrIAL2p68iRL3y4PbLHTJICvUB5mNIL6zn?=
 =?us-ascii?Q?q8GfBkDUIf9JKvT8AS8PjuZST2NmWzKb7p4ehyZ8mMFGDCsysVtt6LbdoIWs?=
 =?us-ascii?Q?9utqDyn7UgNJTe2do3BDpd1HkaVidrpOKnjW3SCXzmE9kEETtdcY7qooHuy/?=
 =?us-ascii?Q?3jaMd1P46Y0Fkbk1dXSGYR9I5EBhbG/AoMibL89UPeYlSnXcbzEY/2/4gUJ0?=
 =?us-ascii?Q?vJD7VOdIZR4NYpXKSe3vEQZ6V9AusAnOEX1Hr3R/hcRzBZO6FJd/e0f9Z5G2?=
 =?us-ascii?Q?dK73c437CFxBtivvcbk6Zl9U66D5Q5KAaBOBH0F0Fx4Jvjw+6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gu/7jAaMC9enjOm2VftV+eYjqeaylBXJrIIk5y5hX/DGdE2YVPg3Ukm9YlLY?=
 =?us-ascii?Q?NrS2winL28zd4JxcWVzcAnKn4ClAbE4YmhqYPyGVYv26Rj9ZSPwNR0DRfhbK?=
 =?us-ascii?Q?OR3T9uDCguHZcpe7koetY61qIHeSt44eM+bUeaLTrEoYCkLaEcbfbVny2L/v?=
 =?us-ascii?Q?WANbadJUWfkAhZYW07evQOi/tDxTwDxHbVP6XPLQA30QH8j/DY43lfAXEYP7?=
 =?us-ascii?Q?EPrx6fyKYqZwcnrGQs2knG6aGJ9crpnbvWjwbDMkLGIRopDyhg3Ercm9HQE7?=
 =?us-ascii?Q?RT5Ta/+OMSzRNiUgl2TaJHR03WpCT1wZnhKjVh77qxCiWmMJRrs0MbiRkW0Z?=
 =?us-ascii?Q?uAdR2mlo6X06EjiwlKU1Hkcu0F5uZOuCUZwXxRDaZet0Oe5QABsHWKOPHVLV?=
 =?us-ascii?Q?6hmf3cotFsF5zImXg+tdTXGYl0NXmUMQXHpnW4RhNFxx7Zsvl6JhKVq8ml+9?=
 =?us-ascii?Q?V0Es0qkXQ1I9cFF0psOejN62gy6IAcKCrb4Yj37iwCakvxMCxStAHRSo+d/Y?=
 =?us-ascii?Q?hUtups60175Z1TzFtCPg+/213XFRJg0nGhxPt74r6AylIq6mep9tCF5p1j6b?=
 =?us-ascii?Q?RGz2t/rkM55RNfuZa0c5pMzfys95A5+8sdJ+HXKCod65xTw1JGYpqHa16T3a?=
 =?us-ascii?Q?zMGD1vywo9XocHDscjPaZIpRGdeazuhbD+jXOa9/IumAkkc5A851P41VI8UA?=
 =?us-ascii?Q?F+kFK9hWkNu35PX+roLUSesj317SSmw/ojl33WEU/RtAqkkdR2k9J0quO7tT?=
 =?us-ascii?Q?O4XFQZJ7ve0gkFx7TF8BveeW8NRJRYohBTCUJl9Yw7gbuFGLQCRKk/dq+fDD?=
 =?us-ascii?Q?zvBv/5BrgDwYzkmcc7V+HgV+sMRVEIIxWCz56RWQrV6+xGXIR6Uv9e2GHScR?=
 =?us-ascii?Q?mJQJf+2zXoCAUwIJ+SoqKKr1qj1SI/u0XEAiQJmrYCiF7B9/RsbuPFE6/FZA?=
 =?us-ascii?Q?Y9YZ9GgtjdyYbM980fCQwSBY7qEwmuaGHcAuUnC/xn4Xs2kzR9b35VTJ8Djk?=
 =?us-ascii?Q?2oluDjcSL41S839JZN+sF1Bx9eSv/VTYW0NRiZlcUSm69+q29QUE1HGSYZic?=
 =?us-ascii?Q?MUcpKIZr80B9jFDaC39zohx2yWuEst68nk/sWc6zrernGdy6y1MPnKq/O0H/?=
 =?us-ascii?Q?NfiLqF4P5fzli5tmTCUFijPgeKUDqr6U6PUULxl4jwZTLVeoDbTaCWS2RW8/?=
 =?us-ascii?Q?1/AWNH2zkcpAlu3NLjdV2T3tt+NVGBC+Quk5Dr4PZhp4wUBsKy+MdREPIFX8?=
 =?us-ascii?Q?OoYBdZV8ik0jjtJfBFtrpvLYAkurihT/CzzjDfBnTfW/u9Isls9lyxivONlh?=
 =?us-ascii?Q?ee8u5OeLyBTxw7TlzRDb0+AfL7fp1SB9D2HqJEHGF9oqnQGUyaIgzTiG9WpK?=
 =?us-ascii?Q?EgFR3kAxpqX7jhLksIlwtKg8+65RY6POHmE4pE2XzY6H+3khFvJaD8xdv+tE?=
 =?us-ascii?Q?yLwD+Mxf+un6K4pbv/s/rziasIsFSZxF+PGEiUpD/G7eUO9E/ztgIjQQnnoC?=
 =?us-ascii?Q?Ggo7BiuFmWM66/MCA+dr3wyqPBUQzCCXsjTjtRE8oiy9inpJldBZ35mejcti?=
 =?us-ascii?Q?8JtwvM1rtpp2/IqsHCKiNCL4Y9uVqKOzq2XFfVnD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97b3d1e-7d9c-43d5-ff84-08dcb5f3222b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:38:23.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBR+ywgcCcCK675s0J1KX0FQPx1DkhuExhW/FsVRVhpNz/V1Njx7U2ub/27zNUcerNZMLDaIUu/gfc/L+y2Csw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8644

On Sat, Jul 20, 2024 at 08:28:14PM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2024 08:08, Pengfei Li wrote:
> > On Sat, Jun 29, 2024 at 10:49:49AM +0800, Pengfei Li wrote:
> >> On Fri, Jun 28, 2024 at 09:38:54AM +0200, Krzysztof Kozlowski wrote:
> >>> On 27/06/2024 10:24, Pengfei Li wrote:
> >>>> IMX93_CLK_END was previously defined in imx93-clock.h to indicate
> >>>> the number of clocks, but it is not part of the ABI, so it should
> >>>> be moved to clk driver.
> >>>>
> >>>> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>>     Change for v2:
> >>>>     - Use pre-processor define to simplify code.
> >>>>
> >>>>  drivers/clk/imx/clk-imx93.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>
> >>> Are you sure this builds fine? If you need to define it here, it means
> >>> some part of that unit file already uses the define. If so, you include
> >>> the header. If you include the header, you should see fat warning.
> >>>
> >>> Really, people, just build your patches...
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>>
> >>
> >> Hi Krzysztof,
> >>
> >> Yes, you're right, this macro definition has indeed been used. But
> >> this clk-imx93.c driver file is the only place where this macro is
> >> used. So maybe it would be more appropriate to define this macro in
> >> C rather than in the header file. Meanwhile, I also built my patch,
> >> but no warnings were found.
> >>
> >> BR,
> >> Pengfei Li
> >>
> > 
> > Hi Krzysztof,
> > 
> > I've built my patches, but no warnings were found. This C file is the only place where this macro definition is used, so why would I see fat warning?
> 
> I could be wrong, I really thought there should be a warning of
> duplicated define. But if there is none, sure, sounds good.
> 
> Best regards,
> Krzysztof
> 
> 

Hi Krzysztof,

If this patchset is ok, could you help merge it? Otherwise I won't be able to send subsequent patches.

BR,
Pengfei

