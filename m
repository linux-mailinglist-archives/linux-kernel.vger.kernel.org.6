Return-Path: <linux-kernel+bounces-560949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8986A60B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED83F17F29F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0D1A316B;
	Fri, 14 Mar 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KYNo4o9H"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A77EAD7;
	Fri, 14 Mar 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940846; cv=fail; b=QauPsiM3+2FG9njWeHOT+xpVMQ871iVEQ9fdgd3/fwmM49Ofy1eZ7+be7iT7nq2jlzw+7auHHTR9z0tgtxTHGTPBuyblDPEZxsN/0MT7agf7rl32l8mmaZs3yfmC3n2QDPWKkPKAiVYKU80lYJ+AyGkVb2LuKN/ot+iyVIn+lzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940846; c=relaxed/simple;
	bh=IrDY0hzMIFEx6kuuW+SgfVcYuHzyZBx46VcsUze2kyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGqzJBqwhotx+9cbneaRWaaTd2ktDKJWfGyBduDeTUkZMbm+5jZXstNu74XyL/vnP1yWMd9IxvSLLJUgMytiHl9pQmZsKywvw/RBbjL4gCZAUoz8cX1KxbCZing3TZOLvpjaRMatSfgdmd9V8WorVFdiSa9d+9wnFVXVQikwnQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KYNo4o9H; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCviBDUvkcHZ8MUS9IRpUuT94SQBspvn6pwluXTzMcsqkfOCBv4xmGZfxhewQa2neJaJVFnYZgYbq3u5X2VSn3/fwdPZCIa5widA0DM9zJOLYNFYRFJbcWRWhNOgJwtUb4QuhQADySYSv+unAso3CXKluyqEx8Xka7IleiW/SSwW+fH6OgzuqIYHG+cfygzv/0VkDRXhtHOSeG8ns7FmVzTayXo5UfFY60wMv8APCqzGejW/xuYtZINBeP+v5oZsYAl0jLlxeZxm7cN8WAYtl7ALUK4mXFY9kbnRulxfSkS0azJUYnxPb4F6ivAPk/x1hX1XhU3c8b1i+Z7UjSuvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCbP2sNib2bkuxYqVljhaOrUA6IEAB/sxBR8bC8Gkbk=;
 b=xvnfHqxvvjAlkZ9fizAB7//+pQXoFDwntRMlW303OW2rnR5XtDBR0lhnhBkCmAv/xkYF4G5uHLP1aLDN1+Dt1rxTvUZHnFPxmj4tYAObTKEXll46PPRiDwBfViExLPvxBRgq65Wdes5/h3iL6l+NNqCRXVtnBOXNAa3PAZCDdUa6h5ClA0dy5OLMzTRGGy9Wo019tAitBUTLJ5LKoovItYmnNKsHROEpQrcdsl/3/6fQhsnXws37JDAtZBiJ4KZm4AEOK2GZ+FRzPxA6lA6+2OITGhFVyIPBWZKv6PuUTzE7Nd5AUoP687QuLLx7o++b8uX9orUlW8TqLOss4RfE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCbP2sNib2bkuxYqVljhaOrUA6IEAB/sxBR8bC8Gkbk=;
 b=KYNo4o9HCABlRNfuxYuZjB7s1sDA4xj3vO4NsPnjndOuqFDyA+biXt65W5tsNqO00wu8BGpWpl34HNWOH4ZdRkBI0UFRxAUTBHE+uvpTIdfS7c8NnIvQafOQ2+OUeTUABKw+2lvTe0mARxoHWLYh5tJlNmyJ67O/vVUALF9aiwOsDXv117ktpw+dxHliRlf3GIYLlprOpA0mOTVSbA/siBS8f0eMFGleB4D7icy7+IlYiCS/nkvc3TiuCwGD8Og/ZQhsDlMyyfsr0cOhVp23gZkiBpMkXViyTDXbu4BNaCja7oPxwYATbagC2SLcNdy9TlPgUGmIrXmUhT39AjkfWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 08:27:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 08:27:21 +0000
Date: Fri, 14 Mar 2025 17:35:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v10 00/18] Support spread spectrum clocking for i.MX8M
 PLLs
Message-ID: <20250314093503.GD12210@nxa18884-linux>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: dba5fb7e-943a-410d-5ea2-08dd62d20a42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jzY6UPjTK06CgyRla7HDGrkCEBhP86jFbNPGrjDJ1JQrwvQ5YO89RD3eWNJf?=
 =?us-ascii?Q?S0MnIcyD1BD2blvI4hzUmaLSWtnyIEiLjVpuIT7JnDW3ywlJkkkVecCe7QVe?=
 =?us-ascii?Q?lKuU+YdFMxa78czCOmY0YRcKq6TVQU02sMGXnS8uRvby89lQ9g5kEejuC72F?=
 =?us-ascii?Q?gmEe1nPDBoOQkOYXvwQfVTKgx8n/x48crhN0q0fdlx4uDUL5+pXUzUDwz4g2?=
 =?us-ascii?Q?CZhIKUia9HrymKPEFad5ZLjliCh/LAmHN5Ip28CO5pRfA0vAgvaQwSxxyBBM?=
 =?us-ascii?Q?Xk0N/GjX4l0sSGZ+EoLrrd4Em/pLRy7dwdhf0khC/Ifoz8l/wqcDVYBYnSRt?=
 =?us-ascii?Q?hFKNGZOjoVFvVvg1p9CNorSp0IVtuo2+FKSfIycdZBMw63wCtrVa4OnOieLo?=
 =?us-ascii?Q?Wr2Z5c42dhRUjIVQwiYcxQfjVtwGW3JSM1yUSBpXyiCkKsRRkjeySNrEwghu?=
 =?us-ascii?Q?7slf52RT7mTlLQEQS7vFJa0rfRL9vy/IYaF4aOGijy12jDtqnEhteRx9RiYS?=
 =?us-ascii?Q?DxFoZSS8MAoo9V2V5yP0U6INjKXk57l1dt3CbrQDn7oY/Otisl6s0dCAkyv0?=
 =?us-ascii?Q?4c+1D9sASLC/AHpXGPoLTsSumjyiFI2qJ6D26QPW7/7+h59DcNTqItDKw8jz?=
 =?us-ascii?Q?CAqt65gr9vVOdaHwsNZoXuY4J7VsPVSS+cMVNYsWq4hqk94y8nBaDc7MexwA?=
 =?us-ascii?Q?Vwto0gwn1yFOtAMqhWD3TDUyN2RwVjyf4i8Qez1NrVGLKQUszYU0p6bybnNw?=
 =?us-ascii?Q?TqUD6WeICiDDKlyOtJw+sMSJXPS/jV0vWD76x6yMpvvkLlzFUf9n9Rb+TS4I?=
 =?us-ascii?Q?5X73Fbbk+KV+7fqgpGK+GPDEd4hBUYu4kQqVOiL+AnqL19n941461GDuX1Ax?=
 =?us-ascii?Q?WTPApvmmLZQ+wAmlzwcU5gUJExO6Gg7buA4Kt2q6tY/FUHiYhgiOgoqumgib?=
 =?us-ascii?Q?egIhQeck0TYisAurd1l2Zun/VveiLXFXBRkzWIH96TSI/xeA5U0bPx9F/lFh?=
 =?us-ascii?Q?WMPGwNvJoFUFa8LTPgJk57Ue1gfkr7TegyURNzePPeV+PABLCC3RnxwQWGOD?=
 =?us-ascii?Q?qtOVbbX0SyMrnp5i0+vChCkZkhkgJA0jpDVyG+tAShBDTtX1JihwkdcyxS/Z?=
 =?us-ascii?Q?SxbbfmLev1jBT9lNzbOQphdE/57sE5/OthyaepDB92SrExloJTkrYdDjlx1V?=
 =?us-ascii?Q?8uFtEhsE4OlypSWeGoGnbFpqgWA8zV3RysjuMs2kQpwg8EAM1OOICQEP72/2?=
 =?us-ascii?Q?jayxsWGxW69bAKYMCouMb9bNARQuv5YOJILhU8JdVB27bILoDRzWyqFma7Np?=
 =?us-ascii?Q?5SjOrT6/sz8YVNRe2KdgpAtTJrgwNIto9CgTXiMEkvL0dQaKQyw63uEwyqj3?=
 =?us-ascii?Q?BnRb/rkSo5Ouh3GeIQ7VVYTmI4fY71lImlDbPDwgCPltQiyICqAW/C7oH5ay?=
 =?us-ascii?Q?Y5nuEq6lCgete+JRwNQRLnncuoLMU+TZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FdvYfwCaA3fsIOqUzolQiprEpL6SlEvZAcxBqhH0M3JkDDEw60B6Kc9e3VxJ?=
 =?us-ascii?Q?knLgmpnSBlb49MQRDrgb0ptv7gjWYg2+HQ4BG34EmHzpm/ImC6g68gvgTefU?=
 =?us-ascii?Q?TCz+JxkANztH2xipTDmPfQ4mB3yEY5dEG96lGIrWnz4/QEilzWMsSqMUpkEk?=
 =?us-ascii?Q?YscZssOltU6QjpbK8OiRTBggZUrpIHyVtSpNbiMZqhYpVBn+zLHB+Tohboio?=
 =?us-ascii?Q?jzJ54W7a+dRicDTwlc8nA0dSvci+KVT6QAErTi7SgkyuwgFBoamwNsui9GgZ?=
 =?us-ascii?Q?XI6rPC/2jCSaYzbbntuAHD5Da3YMK7aP5Z7Inv2k3SuBlFRe1nZNPkmAbyxp?=
 =?us-ascii?Q?amaaatOxAa3jms673cuzvwU0Q+w1tbozQqExxSbqgb5+L1beSQCpGez4Xf9x?=
 =?us-ascii?Q?pDFNz0UehaG3nEFYpCR7VS0RSnVlpjbY5GGWuvdlQrqprz2jlfDwCBwcqmWZ?=
 =?us-ascii?Q?X41jGTt40UyHXR+vclVqI3VewvPEmHkLqqw2UNQNAmFbgrzxf+2MpjA/DPov?=
 =?us-ascii?Q?bB1S+h7ziH931NURZhywy/gMLxTTunTjhvxczBNvToNRlwy/uXKIh2spQHSH?=
 =?us-ascii?Q?wj7ZQtakk3wpMGxj0EWw7XXh1MWqW11T60WMj85oEsVSaoBXidGSTPfC4wpF?=
 =?us-ascii?Q?n5Jflmk1uZ/4x6mLwrAgi6wpVOMfj56V+BMYYTClFsiNgLSlJu99OyuPuDTj?=
 =?us-ascii?Q?WJFwZyHoWGkI627lvkCb4a3zLlg6ImBRHIb5iyDAo7Ps0WudROP+s0xyh4vt?=
 =?us-ascii?Q?pWFvIvbwmu0dAWv+aWt52SpSW4sTshH0yxPAdjiqUR2++BFsiXH8xSiTy1Rk?=
 =?us-ascii?Q?VnPl8XLPubj9aplpYC3+5oWGdW/z6KxCMy68ITM2Rd+1J4l73dejtpv/zZ6e?=
 =?us-ascii?Q?KhCFADXlkiDkc3YGN06ODBuyTHxYkhmk+zbmkGLGaO0jVTeFB6Hp0Lj380K6?=
 =?us-ascii?Q?sD6cFy7Z+SonyqSnLZbj0xeGMRKqLtMdQQ6h9c46UOVAxzVhJPt5GRzrsHmv?=
 =?us-ascii?Q?dp8DMv0ubVc09irpJEd6/67qTANxP0CoCXnvYDfyNLE5XhyIimtSqj3dvjfv?=
 =?us-ascii?Q?G3M6wkkcx5VJxGlPU3MMJTSiiSyO+oX6tVPCW1ASjeSY0tofqFYtn+CACxLB?=
 =?us-ascii?Q?74RIyhhXlt3OgZ5+cwN3kVV+wIWDmf0zgthZfEIP5i9nagNcuTrmVF2NKqF6?=
 =?us-ascii?Q?rHoruFbb5pVAP16tXtceHpYg47V4ymTlld9/DXT3jJc/JS1Mj145IAE+VvOe?=
 =?us-ascii?Q?RXFNBB0s/z3l8xCMNwe53AbsbJG/V3v+WRxX5JcRPZlV9KINC6hf0XcgKJAS?=
 =?us-ascii?Q?XdWjtUCEq+vH9bQE+fGGasE0bvQvV5/Q3vZMcUr+8MwMyC0NaUuIJ3IEFGgW?=
 =?us-ascii?Q?viLV1k7oKiVrWsJnlpEh02qicZVlXdGHNaqxsDXhiDT7qWvDqOK93PuBRtm6?=
 =?us-ascii?Q?wJEtej3sxjeLVQ0UCCN3qd0YxRpWeBteDWncoGjk1q4eTvedVcgwxNWO7cMc?=
 =?us-ascii?Q?j2mYy1FyUUOGT9juIrjLWRSMPokuIzj/HPpdkNKxQV+SG0y69OWXDiPbZe0A?=
 =?us-ascii?Q?uKpu8wdcuFj5A8ZDOcPvNHCc0nWCggz+VA3ooiNI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba5fb7e-943a-410d-5ea2-08dd62d20a42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:27:21.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtDGobT1XKsKH0nsB724JkHrL0Q3AnVBS3+eqbeSVlaGX4nrloVaBiwVkBgBhk9cVIRzNsi68CtWJk1f3aGfPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738

On Thu, Mar 06, 2025 at 12:27:49PM +0100, Dario Binacchi wrote:
>This version keeps the version v9 patches that can be merged and
>removes the patches that will need to be modified in case Peng's
>PR https://github.com/devicetree-org/dt-schema/pull/154 is accepted.
>The idea is to speed up the merging of the patches in the series
>that have already been reviewed and are not dependent on the
>introduction of the assigned-clocks-sscs property, and postpone
>the patches for spread spectrum to a future series once it becomes
>clear what needs to be done.
>
Although I give R-b, there is an idea just come out in my mind that this
might break OS distribution that use firmware(e.g. U-Boot) to publish
device tree for Linux Kernel, such as ARM System-Ready complaint OS.
I overlooked this point in previous patchset reviewing.

Since this patchset is to move anatop stuff to a new driver to reflect
the HW truth.  And requires new entries in CCM node, so old bootloader
with new kernel will not boot for OS distribution, such as Fedora/openSuse.

Not sure how to keep backwards support as before. Leave to maintainers
to say if they are ok with this.

Regards,
Peng

