Return-Path: <linux-kernel+bounces-264996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6393EAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E01DB210B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C428C78C8F;
	Mon, 29 Jul 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XZOoY6D5"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2104.outbound.protection.outlook.com [40.92.42.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330577119;
	Mon, 29 Jul 2024 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219201; cv=fail; b=jMUSd4nwLNnFupyPv3+IEsopMPnSwAQ34wIe3gqs15eWXYnCdjjH6bPTEm3sKCcHNFAe2EeeU95V/UuozmRzFQ+d6V9U/fdxndg9ebDaeIGD2o4rfL106HpwCBj/qnqUgTAnLMGExQj+y0PA9Uzzuy0bPek7vW64WeM6iqj4daQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219201; c=relaxed/simple;
	bh=aCchrBEPv+MKHse5aoiws7WwUO8HA3VSp0hw8SUf8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EAlvLCIVVz5xvGV7Gm4KipIj4kppZy+TcWGQeuBgr/zDTUxaIyH01Ds/bmU3AOJeyTK9ROjkSF34F1bJs9FFsFHyKRvNHgo1KKXtLtB7cSqEI+m51MgBhpEbbfH1xNoP5x3JeUDdZ8qCTSgDv/mlt2wxsiTjKU+of4swWcczsf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XZOoY6D5; arc=fail smtp.client-ip=40.92.42.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB0RHGkc2YjyYqefkcAeokKY9gJlVJP6Oj5iCIMsXhV47hueTs3xPkA7925DWWXz1mFhpX4iu3Ul7BfbsPxs6fdmXxe5PD1gb+xr2c/aklxLOR8nBpTuSmmsVKZuyBgglH3th8o7WNw3pD6wE0aauBjWlsZ7V6Qd4etlmXvGXY4GB/J4FaGHuB3L801Vc5OIWTo4GW9iXuQUdKsIYnvTXFR4bpV1k1fpUxrUXofPWhIEPdNuFVuQQA5NvIJSIjXJywjB6SkAyIxDaibnBzunyCfePx2YBMHQivqyXomb4oQAH421kc7yxRDXIlobOlOYadQ+OPCy90pUnhkA9SbDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSlgZx68KsXcZbYS7tlwavyEPedDXSWgIJXwJD+zLi0=;
 b=whoDd0piHZieE0LHAM/U2DX1PdQuyW20Q6QkzqgP6te/pyTxQcOrmbagLJtcT+FnOiZmORV5SqkCqpifoxttxNFad5ZELGdHRgbf5QE/CA5Gtwh6knP1Pi1vQWxRoNoadNYebDxC66XEJMHhJgF/I2GAhI9+h+7nYF3FTguvLFsSnbXGwq/qm3NctuVJtb+MTmr9OkMDZfAyuj/a96mnLDwb7CpaIFoCijMpK6J7pwPnsPtlVA3iiHTM9g8hTefy/mnl2OAWD4inbtN5JJ+23zeI9+oexFyZnjFhgEp59bzM42x3FHGMGs6ooZ+YKrD0GQyCR7ai2ecNvrYvLzoEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSlgZx68KsXcZbYS7tlwavyEPedDXSWgIJXwJD+zLi0=;
 b=XZOoY6D5DRn3Pt4NIk19ts80EEqjQmIASmyKmzfc9Bhwce68a0sESoDY1AvwFW4UuUgV3OhB2jki/GV7Fa7zzCPRrTM9Tv0JJpz0yporRQ1u2sZi/2Tkkj/srZCeWlHOpuISREMpYhwER8BhsThU6vQ7IuJ4MnqxskspLzvjtF2upmk/Pw2y7Lab5ufNWdElCm09HZjOw7vXrwiIFihwLN8TqR8DiGBVA7cqUz8/KvxxJJtnBXaTYXNaS4ueoAz59vjihnqZfOWToXSufk0aQPEad6rAbUfjZRbS5u+/2cTo2CIkkyKMFJr20+Q5xe0vf9Jmtjrf6Fmu9qhnSN1FDQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5767.namprd20.prod.outlook.com (2603:10b6:8:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 02:13:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:13:17 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chao Wei <chao.wei@sophgo.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: dts: sophgo: Add i2c device support for sg2042
Date: Mon, 29 Jul 2024 10:12:51 +0800
Message-ID:
 <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [j6lmJTTMRJr97VpPkDkNC1DW0AQi5fGfy3q0N06F2jw=]
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729021253.838541-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 57aa253f-7fba-4823-1387-08dcaf74029d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	a/T95Rf4JDiA1MXpJ6ySKpBG4br+UHxcTt6g49P/nZeyNoDbwazRtoqDa1iN/KpcMrv6syPTYqyd95RoZrdDqPzotImusQLuMPpV0woCIdhFCB3J7/cEoCmC4iO5ouYe2VXas4Z1sT6sdMDrJukaICvzC6CWsDhax4hCc0IDb4mTMhVdfnq1ao82ZVT4WDhvr/24c7ghenLUEqmQpl8XOf89NvI8sPwm5WgadbQCzndCzVrZVfELAC85CBwm2CoPUvJosvlHutxVPso2b9ZyWs17Q6P/HbTSoCE4VoE3TMEBlnvhSN0ccWocz0OqP20lUB5G0VEMYAyI69b6WLhud0jmaALYT3gXocNC3oHvDm2qKFKN+9X/0ITrF3z/v4P76H74ckiqRQEsgzgP5jgr/7sqcS9fY2RdpdNsKAfpUUplqmnzpi2RdH5RPTgkzuebociN537KdhF/I3CY2QsJb91ymJUk1GZ5yI1+vwuR2Vh8dOOhcFDjEJH9oItxA5KLnxUYqB8vwrLCsD9Me/u6B/pjqGJQd5wxIHjF3KBq6RzvlWHVfpG6+ZQwz+bH35XJ0/sj2Il5qNhajuFgtX9UIgUh34KJH07l3LO2li1q1reg2wBnzA/0yNyfXSl8AVmTKxrY2M4uQJHI7sfM6NNZW250x6Hc16cNjA/5iJgk5PrUyUYkE19S5Bk380CxdA85l6iTWJu7rB1PHvKgGDGwtg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlsXUu2JGSj+ZJMy3R7/CyDtbZJnsmpnAxIlp/g84PDxiV/7r+6JQbgq6iAb?=
 =?us-ascii?Q?LAFGMtaoZX1gQRPk45fJ36nj2BPZvZjrucHVrejdVG2FpTPOFKNjhHk7ofVD?=
 =?us-ascii?Q?5FTL/rZ6zgQmKPIXXUf6fVEzC9cFkZkEb3bb6shnpjzZRll/xE1wBqjnFFb3?=
 =?us-ascii?Q?px1CY4pulQuCVKV6v+nVvkGfTusz+DgiYDcAp07/XeHJ8xlmAXC6nkIHFae9?=
 =?us-ascii?Q?E9xku0sbtLWGoxBSWJZjkL9dxvqHtQqCb63vmrV+7DmoCnhgqDHVM0q5xsN7?=
 =?us-ascii?Q?b6r2wiUtZXK50dVOjxRgxvkYoedd96XSqu6QNapd4IWUSSg4+Hq/cqen7Azm?=
 =?us-ascii?Q?E0V1pSPIrd27OMBDD7ChzXYLtrsQQtn0fVqeR3GIt0eYcSWhM4EAY+dTXBur?=
 =?us-ascii?Q?GQ7hK0fIx7CAuElW34XYJmWa9+mQkkQY2Uu/AG8cFWxxA1q7YL8AbQHF4nCh?=
 =?us-ascii?Q?KFXC8dYqneetub2kZVaQWjfVo/hlxBhecDZKmiKOPPpoHQXAwP/wZKTd48YE?=
 =?us-ascii?Q?ZShZDF8LIEeRPgBV8quc/dmKtSHXC2unjI278tqjtFL2wOINjoRs3/u0CU7B?=
 =?us-ascii?Q?4FIrUJijvqEpMe44n8EXoQ6PHZkF9T/RPZlGJ5xl4hQ0T2pftUb+SsJj5OPV?=
 =?us-ascii?Q?V0eogNG9Gluzu5gvIvsw4GZTuv60Ier+aUIqzEz4Clunb38yxzgNaM9glkFV?=
 =?us-ascii?Q?Cy5t7CC0Ju8WN8dypv+GE90LvGoXH7CaBjZLeeJOKA+JSnzcqqdgNr6PhEn+?=
 =?us-ascii?Q?k50x6mYr7xsAWOkzceS03Bp8hyWlf+kvRVsuZDY1s/DOZe/wSl79H8+DMt4m?=
 =?us-ascii?Q?TngthLXr7H01k1SnMOKPSQBMUUNVRHp5YUhzwAxJFXi1oTg0cUNjWsvjX1Jn?=
 =?us-ascii?Q?w162yCRJCCZGM8RmLL7RjxCa6WvG8ZJLiJY4dSJkCukuWuiegRicRkOkH/QP?=
 =?us-ascii?Q?U0NsZiosp6+Kkauupwl4Me2yhi9RASvkML+en1FERWqy0BHl7bIrp3GiHom7?=
 =?us-ascii?Q?NG4wW5hFEhzA5lvc4wdLJ+YG8PZ0VkX7ZfKNRlgrsBIcuLCMML+qKrSk/Di1?=
 =?us-ascii?Q?jDBMji21CbTZYF2mdLr3TjFokrHnEv4uBGP5yiuZMFerKf3Vud3jzOR5+x0l?=
 =?us-ascii?Q?AhC88l9UFCO9GuORu34Y/41VnRuRI64B330ZUGFvcT6xh0XDjyVNGjWVsldI?=
 =?us-ascii?Q?sxHFy5G055pSgB0LLOfASIYWvtBgwV4io+g3nk6PctOP8ZpmSUHO2mb0l5k1?=
 =?us-ascii?Q?lTq2BFj4hPCJuOb4AmT5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aa253f-7fba-4823-1387-08dcaf74029d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:13:17.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5767

Add i2c dt node for sg2042

Changed from v1:
1. split the "interrupt-parent" change as a separated patch

Inochi Amaoto (2):
  riscv: dts: sophgo: Use common "interrupt-parent" for all peripherals
    for sg2042
  riscv: dts: sophgo: Add i2c device support for sg2042

 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 54 +++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

--
2.45.2


