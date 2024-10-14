Return-Path: <linux-kernel+bounces-363085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043399BDB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099D7B20F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896F63B298;
	Mon, 14 Oct 2024 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X+V8YaE7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102B27470;
	Mon, 14 Oct 2024 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872623; cv=fail; b=PBTBdinn9OUzmOjDJZNVnq1ycS0VzWljAR1MAcVh5GCJ5q+wR3+NyCk0uZfVES4DA0fTeDXXGxfRlp4YpO594Q4LNeOsBQyE+5BSUZdLnSi42F1Ttd8OyZWQiDxYwyjrrz5++v9pRkEF7EwBkGIBp/OtwhqrzwskDD/uZWPn8sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872623; c=relaxed/simple;
	bh=nJ+xyBbhBoNq05takZeWH2XDoE2mOAEm47yRLkccfzs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p0lVb76Hg7etRwkwyQ/BYPSqhW8Ag5EOQuYIyl9nYOAccr+44y2fNs4SpU0iImKNVsD8OCEnnvFidQo8w5R/oUcFRRyu685X9OEZ998Jzmrb9Cjbhklo4Y1fBnxzQoqxFZV3J/fNiGc1oLK5CVly/Dgcjitcrk82e6vZCsddElA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X+V8YaE7; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF0IlcMHfGI4HFcWRiN2ndIqwPg0mnCEEWhcOmabjnbZELlUrJeMYIxMkObFOaNh72JiP+YHkzXUzpoIGglUVD/8BT889Yrsx0+BCXDENWUxXX44kiKsUHKzY7jkpuI6orLHNJUKrpycQGfuW9DUkR8li4by51dbO0nafysEOD2+6zo64ppsncQ3zR4wKCfdAUsPZUPIWJsZF+6uSOKsgt30wzqyIHpaU0+/zXcXA7tTJtOB9iJLVIyxcYYt1Thn8djbNT4Epgfl7nzNbgwkL9Hm7FMavocwcjANGbvMSJy+NxF6AnVheCvh0IBazg5ntPC7mzxBG2sbXoQOA5QT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkUhB8M4NJAVAcRvOKIaMJpUHDPZIOZjGKQJmWOmQLk=;
 b=VUvN7DYqCr5EHHoQzWuNAxW7GsMgpH9ZF4KJWJKBkszqpABpKZNwTpL7BfrvWaVVU//0A3VAHfNAns3RJMEzUuCWLbW2Gf8YZHdW4SCxVTLkXsdoeYnTu/d3EpseArY/XUpizc2+S8L9jL8Qqb5Kw4UtyTGucJyUwF/AMscy94w3VrENbIqlpy6tqABE4p44vvZ754DTp1K8oFqQD/NqZ/uCgNHz8hXp3gobC56wpYX74mTe7iB8lHBRTvX2bGHZhBjpkodbG6cI2YiNoayZhbYwL+7tawXnlLtVIQf+WBOAMNYtdvNQJx5ZZcHevjTirac7A8pmruLYCRUvejyyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkUhB8M4NJAVAcRvOKIaMJpUHDPZIOZjGKQJmWOmQLk=;
 b=X+V8YaE7M+rv7Sc2MZy9iB2xTQX+w4cQV9a+RwfwLX24PoFrmwoABvDlrH+s27TRUCmNfXeSWwp0RGO7cITdidZX4ZN6lAdaTZc092sdLMleBGGRPoIDAa3UhIFm4XtirvsjIDO2GEmLubqDtE9NUx1WQZ1idNa0w33WF+z4hx10LoVKjw/FxhS/OkmV516YyReEjFCEw6dJEJWJm87LG1qDu6mIXkHS/IUlK8d+wcnuRLlVlqP8p84ro1gI/gqx+HNLwoDUftxKhyhM/0jHMf03Fasvkxi4ExXYIJBgZhavoOU0Bbb3lmPx+3DD52PMpOVrPTGjtxl+3dwDAeKUKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 02:23:38 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:23:38 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add iMX91 clock driver support
Date: Mon, 14 Oct 2024 11:24:34 -0700
Message-Id: <20241014182438.732444-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: c216658c-f43b-4864-32f5-08dcebf7363d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jwP8P+cU0gmlyRmfJzMfRWKfHKC7SV+u3CeQW2n8GbZSPqpyVn1Mf9MD6f35?=
 =?us-ascii?Q?VHy4s33BT+Lyz3aPjN4VVrp2HDLMB2Pnm95m78RxGPDOzujnhe0SqVx6N4wR?=
 =?us-ascii?Q?4GcGgFR80WkF68F5gJJRy92sskM5UBCAKgX+elnV5y5aWmVZVE2i/3QzHtJp?=
 =?us-ascii?Q?dF0RzNlI9oHyUSqewyMbn1hzd2lM76h9ATUTijUG5wZH7Zp/zwxMyrIexQ3s?=
 =?us-ascii?Q?QXeScmDMIgDRaDouZs82hCd3obUhysYUdUTt6okF2GFRo64yr+Tn5GkVJYEo?=
 =?us-ascii?Q?Zoz6RSwoncUFE417W4nkIidB6c7e2ukMx5f0fdfw2wdb2iXNOQP1KwCySVN/?=
 =?us-ascii?Q?3S40DQW5igESYwZUCu513PJH4kKBw0ZO8TmVdH8qgKZjvVx1yBh8GALZsJUu?=
 =?us-ascii?Q?VtrCtXElAiUwmOO7UluWBl3f6kOnpGnXG3tt1E/hrIh2o5zSYaNFoAozaybS?=
 =?us-ascii?Q?OSjVjVWr5b2LaCX2TRxQARSoTjwlmFbpS2FUQ19sQBn0WvqL4kIm2OCtWQF3?=
 =?us-ascii?Q?G2fkd4Hp1oP0Qml+ox84knDLpIJ9gtzZXINuwlQQgvTgcZkhfYyDa2+FH5rJ?=
 =?us-ascii?Q?5My95gcjioACSjJG45xWAHbrGFfQ/J04MRQPXC0FUwq8eOGQ1uaZhx21WCCo?=
 =?us-ascii?Q?t6vMw2oL8CRb/oKwVS9XuWc0C6mDWm+y3ocZcXhmX2DaM3tAN7bRV1gNAhz/?=
 =?us-ascii?Q?q6xNEDHLHpIlSu7S9G5BTJp2z3FSI7NhUix9xPwFOdOb/NxLCJe28LEYbHaI?=
 =?us-ascii?Q?nrmiPHm9dAi7zt06XZv2h7Uvt19PjVy4bQjcujGTot+Pvkpd6th2iKbxTYBc?=
 =?us-ascii?Q?RdflrAQNTHNfStOI/RVEEvERrZBi0RrfrurJUgn6SwxDdkCsLD/piwhExIQ9?=
 =?us-ascii?Q?tfcNGBldTvXyUqs4sawefIQjaUurHLZNGhDfzoRuQpocFPpFAnw+gBu/kXNJ?=
 =?us-ascii?Q?OUDG+womhWrYGTwaekL830x/RNLDjc8gydR7I+P/1dzIxxHJoWYWggYcjMOC?=
 =?us-ascii?Q?VCixihmSSVdRIeaVMHYFEFYQUYdl1DDZXWH5F+khxuFtfVqiH9YvYy5eV9Ox?=
 =?us-ascii?Q?kjHZqYFxCLMRONicbAbTZWemlADM3qJ5U3ghMpYjt0zPP3o5jAZ8dDyHRK6F?=
 =?us-ascii?Q?Pj1VyGxaFcs4VhbNn8FQ7CrfrLDKWrb3cudJPv+4FBS1xp42V3oCTbddry06?=
 =?us-ascii?Q?vGZeCTi04KDO7CHc57hNkLfD/JDjikqa0dY2ASNpdXmKZpjY/FCr5FYZZmsX?=
 =?us-ascii?Q?NIqBzyBkyes6ObY7Rs8ZDX1KQLfvRDLTu0X0JzzfCRzX4qNo7iFjphYBnJmP?=
 =?us-ascii?Q?LIe12yEcBQ7J6uGZggdNH6ZVpSyb3Ow2oQnkRxxRqxMXSzrh4RGNZURQUtL3?=
 =?us-ascii?Q?mTn/YJw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YcL31Kc94SCzQJraKSSKmWt6J/GIgsXvOlRJ9+opo41Paw3444VTZ60VizU?=
 =?us-ascii?Q?GeNlveUbIXOEFsHlBfUDTvjdYAhugOq3WTw1c3J7q6ieSLegU+msAs1oy+NI?=
 =?us-ascii?Q?46ss1mUalbSJIvChQZmjt7EuzJXqxRB7zU595PnPUPVEYCjpeSA1fQtPT6Wc?=
 =?us-ascii?Q?a0zZ7wZ7vW89mRgBQzGNrV5RuTpUVOVDQQXkB9ZSUdzoeqGb5v6OCgTYBYCj?=
 =?us-ascii?Q?JDYOGBPX0Y8lS84tIp31LvJs1FEh3rhz40m37rqFNO8TsLVJj9HG4yfKiDC1?=
 =?us-ascii?Q?L+ltj9p93fPGNvyCReyE9uKUdGymnys1qzbqJW5F7ffg1vE/bsdi6O3M8kO3?=
 =?us-ascii?Q?DsCU6JNLlur8bNHINmdj1sOkgmpsNHArJaBdyCqqK0eyVPG35Q9SkkrNDm0C?=
 =?us-ascii?Q?WWQWb+4OWsAsbcJ40aRTNMHPAh7XDQ4CV3GQq9rgwmENM9mPVhlhQVBquQfx?=
 =?us-ascii?Q?ydcGdQMhsmQ/jdI/NRCet98MdFrtBvHQdEDXLF7COCuAiOkBAc7QxEoqkfKg?=
 =?us-ascii?Q?CGaERppFJ9f6lonzxpBQHjg0RH80uJD79BFhIjwyAtm1cwJx/F2SZngrzUyO?=
 =?us-ascii?Q?4tc15ynpga7CuvXPhPmcrefoQIYh/wFoeAN8T/3iiZ7mlRBcaPqry6tmVCO9?=
 =?us-ascii?Q?hIFs6532HPqhLl7x8Qt+AErlsqWlZoViH7clN0QixMJMlS3+0eCZivG0Xoxx?=
 =?us-ascii?Q?TEAmwcTreSkOISWazXdDqqat1KWYiXNauINmQBZf6xPF34dfxqiaw4vWURxv?=
 =?us-ascii?Q?WDA9IUchCAZgllJG0V+R3pyk2temRAGexezJfUUUlIVmzYYLjBfllw3OlKya?=
 =?us-ascii?Q?i+BD2xT05weOV7zU81D3AIssp8lJaYNKXVO17/bRIWGiFjwjUorB8t50Uw9T?=
 =?us-ascii?Q?o4dvHnyCVvRYnQDAtpK7N9DEUnA9CFl6YkiCiLSUu7SaXYrXz48A/vw0/XLh?=
 =?us-ascii?Q?3pRKc4aO04id0Drt2qhtG+qhFMQ1e9fkxRu4DjvKFl8FtZuOp2i3Uh5z7fPD?=
 =?us-ascii?Q?lLiKXZMe8dYbXmZZ7zSzFWZ3gSRN7yLhGmG/fM0Lo5haFpYl/Th+DxsSw5Hd?=
 =?us-ascii?Q?A/UFgSBjYrLZiwVtgQYijR6nx9T9YtgeHH2uQTvvmHWn/1V9NtwgFSVxu7j2?=
 =?us-ascii?Q?XgaFzu74GKtfLfbfKtnHsrVHqL0NHUwVAuKp0oU/O1qQ43tOTMpm2pDRIECP?=
 =?us-ascii?Q?6bg6WFbYGBJYfyT61BkIJTaLwneLn57YKJIF6DOn6ec0lzu59sIgDqmwoUms?=
 =?us-ascii?Q?B66Hf1K30Wezmi/X9KqVy3jsCdVeVxoTwVBnoS9TLk1V75TB3fVnKQCstI1q?=
 =?us-ascii?Q?Ey8MDr50+O214gGqoZF7d06xS6Pr2bMneOEiKV9veoQPy/uKFhFIssIeBgUw?=
 =?us-ascii?Q?O4hrJg9ZNgTEhGUWY2zjDXksw2KELXiClwVAPJUilPh89ewxppeiQmKVzfrI?=
 =?us-ascii?Q?b9dKsi6SSi+uVjBo7qD70LqKGCYG4Cl9Z1gkgkhI16mhNT4kHiT9AYI5OjJF?=
 =?us-ascii?Q?D4yVo9oeOvG2JUAfDIauvJpFQpcnWgEKmGBmv/sWJUKiOgj1y8QzAGvQJqbM?=
 =?us-ascii?Q?wcxYiv6fsTEQ66ZJdkSnQelwwucgFxigtG79kq5g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c216658c-f43b-4864-32f5-08dcebf7363d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:23:38.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdN19fJ2WkbIrxok4ngjNoWycbZT8PiNwIRQsfI7AW/lYG7tpk8ktObiCK2RLQVKoNwMAbos7sRsDjtwQwzRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378

This patch set is to add some new clocks to binding header and driver.

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks. However, it is not part of the ABI. For starters
it does no really appear in DTS. But what's more important - new clocks
are described later, which contradicts this define in binding header.
So move this macro to clock driver.

---
Change for v4:
- Put 'Drop IMX93_CLK_END macro definition' in a separate patch.
- Move 'Add i.MX91 clock definition' changes to the Binding Patch.
- link to v3: https://lore.kernel.org/all/20241011045736.308338-1-pengfei.li_1@nxp.com/

Pengfei Li (4):
  clk: imx93: Move IMX93_CLK_END macro to clk driver
  dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
  dt-bindings: clock: Add i.MX91 clock support
  clk: imx: add i.MX91 clk

 .../bindings/clock/imx93-clock.yaml           |  1 +
 drivers/clk/imx/clk-imx93.c                   | 64 ++++++++++++-------
 include/dt-bindings/clock/imx93-clock.h       |  6 +-
 3 files changed, 47 insertions(+), 24 deletions(-)

-- 
2.34.1


