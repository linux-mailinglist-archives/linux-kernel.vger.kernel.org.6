Return-Path: <linux-kernel+bounces-170284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A458BD47E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696EB1C22076
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67595158862;
	Mon,  6 May 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SLr4/ZcH"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094F13D50E;
	Mon,  6 May 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019723; cv=fail; b=hnZLF21gFkFuwGHUJP3CdB3QLWQUkE/vxxuIsgVzVyVYdHM5TPNzz+dGigJQhdWDqxpuEA4A7DaSOFPRVxTR01u09Amue5fiIhkyyTsG1+uFWBWiIf15uLZcUZxYnR/dPyjpcT6z+tOq9yFJ4drYkGRtoh66J8GQYm8N1QsRjEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019723; c=relaxed/simple;
	bh=DqwpMcQo0rog3QsHkf8CyauWoNDU7JJ81aEdaTmkwZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gaHXaoXFdBvscTIS3IhvLYwP28cR7qsRh0hcrp9CbElO65xc529NuJ8y8FV5L+7fNKMMRd8fP5P43uIDnWCiEgtEeYCXWeT0WhT2w7L7D6FT0t/I/O+W76NynOwzWD0FKdnmWn0ddn+PizPVxCQ9sXqt4NYHq+2S7mXNpYBzM6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SLr4/ZcH; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwpFborHnvReo3THpvoYKUW6P9XVn2yjdagRD7l4ruXLMYLmeMOtHTqN6m9pLYZpvd5TIdpMiPqMSz4nyQBymmenkcsZoBHk+PekjZtV5fjbF/PGzBhFXnjtEuEQywgZzyObu37kspRHsps7lwKsds8Fw0XQUZA3bRJML+hlDAEqt7fhzcuJU2W1m3u+8ldel/g+Ga3D72c81MUoHi54jnzB6kWXkcyvz4BIX+akksmLu7kJYwY4lT9a/+ltcepytf7++Xl+qMRjtdkc71L/RTga5+eRnZDICNEK0BoGTVjaf3JamKaTmF/iV+t9DeGbpCjElyqZdnRDqdzJW5TtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPPWrNd/QFjYciTmDcPVE7srIwjDsJqhV7BJP//Lf74=;
 b=nv8D+CEvSZHFBnTmUeCu6v6FizqbKmiQp+MGMCN+wUZ1m4RkMeRy7/f/JZGWONlzncavVaqLQcMvLJsAeeTJZv0RYgYBLn7HFH3qcIkGeP/YcyjlbzETQArYU0IraWGGk8u7qv/MhPVI6gS3fi6ZqMmhv6GW8LbaGXT/qXlZSfbZolhYPzmHw6HCjSmdFAdOYGA7gnRc8nPAnTxxbzWQBUiU6g41I/dEebkvV84/vx2VQU6rBySQPPPrOUfRM1gWm9lMpZcxtz33WdMBWvGn3F1NHdCG4zoUVxIfCWGhn2ShsiJPFnxcj42tx7poXK0RkQU4501PQ4H/W7Ai9iyp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPPWrNd/QFjYciTmDcPVE7srIwjDsJqhV7BJP//Lf74=;
 b=SLr4/ZcHLtXYvkyy29UEHOtqJD7Ms/JW5SzOe4w5QPicoFA9zoPwUQ0GuU5jKGT/GEd8Iv4elj4RpsShWDUf7ayjEHcwcxyVTQgHSCoQWgPpxWZ1KK+IHGggfx5+BbgDYdfOkscHyMglPY3PvbqcG5vzLDnQojihtFFSPlaZ76M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:21:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:21:58 +0000
Date: Mon, 6 May 2024 14:21:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: imx: imx8mp: Add delay after power up
Message-ID: <Zjkftwr4/6KV39sD@lizhi-Precision-Tower-5810>
References: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714966502-27784-1-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: ed207c5d-bf9b-4191-9df1-08dc6df9671d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t2ef2HltjQwcU7Zt1hS9L/JBe+CCf/nvcjiVHWyy5BMVyTktN5ph80zL7JQR?=
 =?us-ascii?Q?CHHPm70C8swBKS4bgIHMzxZdbqeyeGyu5KM8ZjB1jkacyNfqu3eu2sI/2XtA?=
 =?us-ascii?Q?piwVl1JHOT2ukqhDyge9t+4tQA9IXQH2EMhMIilMTDVmLWuR4ydTMyk8UK7c?=
 =?us-ascii?Q?8LdDAr/Q6gnrlYsCHArFoIP6cMy6DsbNJeOHjtneX9CQRG+3RqdEJ9y75Cxv?=
 =?us-ascii?Q?yMDC35vEh7IPLTUpNeZSqzFHWzcQclpLTMizLjJ5CCGenCxnzKd5xgt/3UNa?=
 =?us-ascii?Q?ZzZMqW6a+PDK0kjUCUmDpajfHgCB45ubXKyN5P+gN95pHDGJ0TuLvHjwT2MC?=
 =?us-ascii?Q?ZrN74rtumXWAWuLlJzigD5jSNiu00VCawz2i4pQcJvDEr5NUClakrqbVg4r7?=
 =?us-ascii?Q?QvEohQcBmdICxeeeKhyUJ56cgxWho47mNKRz26cD0KSiJsdXorQOS04MTuxC?=
 =?us-ascii?Q?8yTTihVPH1Tm7GRzxr+hsNZlnrz9RtrjYd9VkKe0pCcLBa+2btIY+TvLnwfU?=
 =?us-ascii?Q?oGsXfWrE0q5yVo7MGeCXbpiFDQdeo27aYlRBP+5hBQQ13s0/+wz0GomhZjau?=
 =?us-ascii?Q?+gU9H+gvp7b+oT61ELaJsUVvBXfuk7s8XXpnSDL8tbb9wiYiFQsIKwvfDCoo?=
 =?us-ascii?Q?gOgOG6nHBMcvtojfEWoGPdBabTKzzRFw5uEa5xU1+77ZfaDY/QRkzodThGrI?=
 =?us-ascii?Q?irgBZ0DYqHVGNyEpoIs+4iDI04BYCC879TKCPoC1nPMndDFcSzz1LfYKxBVe?=
 =?us-ascii?Q?Dsl2BB62ZcdVGfPbu/xec1252Nr0+8bIDR+Agio7ofeWhP5mFMGD3waa7jxv?=
 =?us-ascii?Q?U5aMRHWDPbHZ8WBEmGwLZMUUg8MmdPee5MGhpYyxgbGk90pJLBGSxHdRN9Am?=
 =?us-ascii?Q?ty5O/QnQeWe4GwpK7lIoUej+lNzEMJ02RvzWVkdAgwZ19GMtOHv+rtqzuQol?=
 =?us-ascii?Q?8LZfPPpzq2yQVkQ5mJTGO/uuv0Js9mQ2w9VFusn+po6fsqSkLLuMYKZQyDBU?=
 =?us-ascii?Q?fGLWo4tfGHMP2HZQdWXH+mTh9p0012kvfWZpyNG6D5HQcaRedpEf73PtXdMH?=
 =?us-ascii?Q?DeWpx50KIE4tI6rT8h+6UZ9HVHoODAxMxRnQjTAqzCcaLkppwgep5KScuVn5?=
 =?us-ascii?Q?u1EwrGtYfUkWsqzGtxbqJ+Og6tFzuR4nJxFLsLV/0l2Lucg7aoHCgh7knXY7?=
 =?us-ascii?Q?8fL6kcguAO/1TUxyJlpLiRhs7stmZ/wc8TMnPoFvWenn6HanFlWODPKUgxgw?=
 =?us-ascii?Q?E3trWnTHxjvKxMC///MHoXO8fc2GIzNTkq9ucV8q3yHT38xkKl6Rj0fd8giI?=
 =?us-ascii?Q?IXddcFBQgMf4GqrURutU/e7TgGkeTya9LQ/Om6/2KRmYpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fbYUo5JBZ1/N4Pd0KqaOGkwtfUaRk4zE2JvAHU4zchW2gFe7ptGBtYR0x/1?=
 =?us-ascii?Q?U3wvt9ygabN0C80loU6StMZ4+MB1v6mK/p+FGvqLqf706OYpMkvN1bPROI7Y?=
 =?us-ascii?Q?OILJV0NKFillz6wGax0ybVvAJFylfrWQHblWVnv7Gh4b6W3ZT7OoA62SzWC1?=
 =?us-ascii?Q?DEi3f3dR/ZKHQ3iNOgo/MoBmr/xcYMbFQT+AsvlaJuzDShXPTjNVCVtjWDCI?=
 =?us-ascii?Q?MFukBTU5A2Z1kcccb4+9A/kUDacW2GneGfSTsPrs1q6hH5z7JVATB6ZgB3TB?=
 =?us-ascii?Q?uAuX2q4DisCxnb0oofNmK9+dQABRuW0THMr49P8YkDCqzRBs5/XyEo+uZWpV?=
 =?us-ascii?Q?blcdTFLK20LkWmugGQNmwRZU+umwhhJ7TrSrUipCcf5l8+yg5DBWcux/KreP?=
 =?us-ascii?Q?mIme82bWvxBA43yMYcJHEX0cb8g3NHmmlSDlj5lCQCs3vcEqwK2F0qnqFq4a?=
 =?us-ascii?Q?F6q4E8oup2xvcdMZs0syEDU7+m+QeIb2TSW9HDfm4mCxlRXMSCDaNsKUzyJJ?=
 =?us-ascii?Q?IWdUc2+03fu7bO/q57WoEDiyOAEDaO4+wwnOJZCJIl986S4/UHu7h/E9KZdT?=
 =?us-ascii?Q?QpVHc1OS4WQfOegoqG7creZLvVkfkTRN1AZ4HUwDc6gOLYGYH1ScutxZYKBw?=
 =?us-ascii?Q?349PRZf7gKD2LbaLgduGZMVRJYWWYpjRCfmReSiIOeMG3yqnfKNCY6WhWmQA?=
 =?us-ascii?Q?GLYYGFEW8TSjmUDbmC+KtOLT4mNGfobp7Cpr28ShPzXbupHUw+xGfOr13mGw?=
 =?us-ascii?Q?qHDpmFYGg2W+un8FXo3PpsT/5CMyA66ytTy+OUi/sLUSKshXlGYaUEkXprVR?=
 =?us-ascii?Q?J3iqZqGQter7O4MG5WxdVJbz+Rd85EyB2uZUQlmlFsVYkHcoDJLuEDs8tGx0?=
 =?us-ascii?Q?MY93LaTN29x+UXtw4s7BPYWZgLLri/nfXvwjGbxolpB2Z2+zQ7htsHJm/wBi?=
 =?us-ascii?Q?e/jQjQF4UB1W5Z0p3kYUcRttO6XonbInlEdVJYlDlTU+NgTGJS0ZWPHlp8Fv?=
 =?us-ascii?Q?uC9wcelc1VbgDKe8I/bO7hE1UxOi7MRKs7ErfClQzdbsHIK4VsnVfRLm6Ykl?=
 =?us-ascii?Q?6yUnTG98jUSnREGcv1rsUhbBr6PLoUrVBnH6McEa/wJ9k2u4aOvd65Gp8gK+?=
 =?us-ascii?Q?hezYTsTRjf5bAGsmk4Z+xZkaOLhC5tUymhucqgyKfRgyz20gI1otwyEkKT73?=
 =?us-ascii?Q?yfeECm0tym26MNbw3sviOSF35vvizz+J4G8A8RUlfxGbLW5BxIUtz6vosOMk?=
 =?us-ascii?Q?FhbPIVdYdan9hvVVwgBWFb3Wop1E9emIZ/Nsrtvtb4d6KGGL6FkB6q66ObRl?=
 =?us-ascii?Q?7qYQhxhRlDws5LUzAb5w2CbyHYft8jRzvOGkKghLqV+x1ClBXCIcVuMfuqyx?=
 =?us-ascii?Q?X5vUGk5u4p2iOSyg79Bk0nn0mqwLsSoXasrRb40U2zxSx9ODquHxdYBLkSwR?=
 =?us-ascii?Q?641LCz5aLIC52vxHN//Ou6XzZ+ZVd2xUOXblZZtOmSeUSobW998C6n60tiOp?=
 =?us-ascii?Q?nMCyZw5o5m/I+Zspr5iwWzY9CXjmFagCIlhGNNkOFj22hAOFNMus0Z0/yRcd?=
 =?us-ascii?Q?v/jGdWsqhj1iDB5PfQD7laOz8PQ77NuyZbcoEPyI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed207c5d-bf9b-4191-9df1-08dc6df9671d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:21:58.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsfNiJ6+0PI6OFv6sG3q9sOX1VeSIwyye+AATPUkkUFsfmWBa3je96p7owM9NINToVVAhIIC82wM9SuY2asibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

On Mon, May 06, 2024 at 11:35:02AM +0800, Shengjiu Wang wrote:
> According to comments in drivers/pmdomain/imx/gpcv2.c:
> 
> 	/* request the ADB400 to power up */
> 	if (domain->bits.hskreq) {
> 		regmap_update_bits(domain->regmap, domain->regs->hsk,
> 				   domain->bits.hskreq, domain->bits.hskreq);
> 
> 		/*
> 		 * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
> 		 *				  (reg_val & domain->bits.hskack), 0,
> 		 *				  USEC_PER_MSEC);
> 		 * Technically we need the commented code to wait handshake. But that needs
> 		 * the BLK-CTL module BUS clk-en bit being set.
> 		 *
> 		 * There is a separate BLK-CTL module and we will have such a driver for it,
> 		 * that driver will set the BUS clk-en bit and handshake will be triggered
> 		 * automatically there. Just add a delay and suppose the handshake finish
> 		 * after that.
> 		 */
> 	}
> 
> The BLK-CTL module needs to add delay to wait for a handshake request finished
> before accessing registers, which is just after the enabling of the power domain.
> 
> Otherwise there is error:
> 
> [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> [    2.181064] Call trace:
> [...]
> [    2.181142]  arm64_serror_panic+0x6c/0x78
> [    2.181149]  do_serror+0x3c/0x70
> [    2.181157]  el1h_64_error_handler+0x30/0x48
> [    2.181164]  el1h_64_error+0x64/0x68
> [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.181183]  __genpd_runtime_resume+0x30/0x80
> [    2.181195]  genpd_runtime_resume+0x110/0x244
> [    2.181205]  __rpm_callback+0x48/0x1d8
> [    2.181213]  rpm_callback+0x68/0x74
> [    2.181224]  rpm_resume+0x468/0x6c0
> [    2.181234]  __pm_runtime_resume+0x50/0x94
> [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> [    2.181258]  __driver_probe_device+0x48/0x12c
> [    2.181268]  driver_probe_device+0xd8/0x15c
> [    2.181278]  __device_attach_driver+0xb8/0x134
> [    2.181290]  bus_for_each_drv+0x84/0xe0
> [    2.181302]  __device_attach+0x9c/0x188
> [    2.181312]  device_initial_probe+0x14/0x20
> [    2.181323]  bus_probe_device+0xac/0xb0
> [    2.181334]  deferred_probe_work_func+0x88/0xc0
> [    2.181344]  process_one_work+0x150/0x290
> [    2.181357]  worker_thread+0x2f8/0x408
> [    2.181370]  kthread+0x110/0x114
> [    2.181381]  ret_from_fork+0x10/0x20
> [    2.181391] SMP: stopping secondary CPUs
> 
> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Revewied-by: Peng Fan <peng.fan@nxp.com>
> ---
> changes in v2:
> - reduce size of panic log in commit message
> 
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> index b381d6f784c8..ae2c0f254225 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/mod_devicetable.h>
> @@ -360,6 +361,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
>  
>  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
>  {
> +	/*
> +	 * According to the drivers/pmdomain/imx/gpcv2.c
> +	 * need to wait for handshake request to propagate
> +	 */
> +	udelay(5);
> +

Did you address the issue I comments at v1?
It should not fix at here, I think it should be gpcv2.c to delay 5us.

Frank

>  	clk_imx8mp_audiomix_save_restore(dev, false);
>  
>  	return 0;
> -- 
> 2.34.1
> 

