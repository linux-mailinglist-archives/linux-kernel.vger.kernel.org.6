Return-Path: <linux-kernel+bounces-514310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EA3A35563
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8AD7A3C03
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3C155751;
	Fri, 14 Feb 2025 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LGlSC3po"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D5153BD9;
	Fri, 14 Feb 2025 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504349; cv=fail; b=uKImlQwd0CnI28QrVnrvlSUNPnXen2KjeBwZBzyUBZw+OEieRuNRzPthfpXd+QZmc7z4cXjsv13FPPL122dKjc5HfJxyDhvtGXGRM/V685DJ/4WjyyoyCMi1njBwQjn3ZuoRVkTudAw/h3ZPnqJWiFET6k0uf37iom6YUiztXgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504349; c=relaxed/simple;
	bh=7SJh+3WinxlRgkX+uFePTuCEAQHdJDXYmGI7jjCP6HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLe3d7kWNpHTGq3KanT2umKbCyI8jWMp03+6SW0LJ7s2N6sLidsOMl4i026DfsVVt/ULmT1gVV2mNVq+Y5Wtz6U6K0xyUu11ZsBSdQeO+ew2Vbv03bKLaHbQgfiH7J4+v6p/fhuT9Iv7WpMp/o59tHfDLkDeAwGFa3ObO1Esy28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LGlSC3po; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAP1Edwwrx/MbEOCJIJG5QBuFCJ2mOhL39CR0hGBme+SwgkYQi1QiNFAXcIZaXHszyH3eDsIQU4GIojGdhEcgu1lRF+zDE336tvZ2axY7RkEXcazKMLFtlnPU1xiewGMZ/Ca8ro9qrxTag3TkUouz+YK5j+V1SUbC7v2/pyfmVsbVCjF4+qw1QJnZYJtTZAaUjGVnQWZq5R5zCt3Fprve1r9gyWtSwmrt2chsQAr5ROVnTX+5xAX+gf/sLZbdrHdx1OmhhC75udsuZ7+G/rlBHzuZP6KpXwdbu7eWr3OzWfxcQZa9IdXpXMG+e5lk4iMptCR2ca8Cms3+HJqrCB4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4AJVE+8SxqzR3voZ4y7Gp6hBz3h+QhSqIheL7G01Lg=;
 b=YZBickSgvSpxP7L1eJGDcdClMqgl+GUFAhzhrkZdXsHVBTVd5T10xX+TGGUifOcZoyj8coOzAoe++HyxVOCnpFxPhtZORRNnZ0b+VghaJl4ff3PD08OrZ3A159lqQ3mtzzKKfUcZ8KBGMHkGzYVN2P7tTXprz7oEGtQc8NLSd6Dmc05fAl3AlTlFdLcgHmViRqBQ5hHDTi8/pUiwC6PGk2qG2aKDVWJQ2rbTfSNc2arUHDFYBJ1z5p0W3viTDdLyOSpzPCdY8TAk35YEAef9Kf9ZucCoOL2Vb1wuf4ceYNec2MyPXEvDs/xWcybooC5Wy0yGlciMDO5f4jgJ4oPClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4AJVE+8SxqzR3voZ4y7Gp6hBz3h+QhSqIheL7G01Lg=;
 b=LGlSC3poAiYpM4SalNgWovr7qEopJI1P02aST9ewmsFDck+/U6XRyfhoLZ/wPF1D2+qlAooRuzoS0trvIxQ8egGz50UxvAfZvxzngBrU2KB3Oj5dhhh03rzXVnI3vLp1u4DmPUAkCPy7CjQS18vDACfduxxhH5OaK9U0qq7cqC6M3ZEdR3aDeRxhi9U2rDUbo//O4H8EmzhGCRUFoffIdWDJInbSD8aT8I5CAz1EeTEeDHgkQeoatkRHd9B18SBWZC3+8j0zDgMEknv+gyJ48rImMBtKbR+mTiB8gup9Xubu2gHQ7G1U5kH/vAFJswXwmzii/oym9Mf/3/GgwC/Cwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10525.eurprd04.prod.outlook.com (2603:10a6:102:444::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 03:39:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 03:39:02 +0000
Date: Fri, 14 Feb 2025 12:45:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] clk: imx: clk-fracn-gppll: Support dynamic rates
Message-ID: <20250214044557.GE20275@localhost.localdomain>
References: <20250210160012.783446-1-alexander.stein@ew.tq-group.com>
 <20250210160012.783446-3-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210160012.783446-3-alexander.stein@ew.tq-group.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a275bb5-55ed-4d0f-360f-08dd4ca91fec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LdjBeJfINWhwgR3W2gtSpGAhNWBg5hbupSz2GkJvOWR6GL4U3XQBv7ssnt4I?=
 =?us-ascii?Q?jMUvxGnKL9noUoz+/oQTzLI5iM8pTdi+pWk1sSnsmEzt/OUAGgYyxxuykJjh?=
 =?us-ascii?Q?Pl84cczoWH3NYGikeT42CkW5w/6m7Aj6x28rJUoeV5c3Ybw/k2He1JmXoiMn?=
 =?us-ascii?Q?XC2E1N2qr+VsnFyec65TSbYaNhK2zyh597tobS9OOIMyucVGyLTxu6JdGzSo?=
 =?us-ascii?Q?qK1FU5x+t21Y70a0YTRGtUhf7k2nf71ZvFhB6DSc1f6XfP9wclCuQ58fFRsA?=
 =?us-ascii?Q?3AICo4QP7Y4Hmuy0uRtF/dmFTQz9iB47ViVMk3apM7/iif9XOIQYjdbHmDLX?=
 =?us-ascii?Q?xdddfxgllIL2dFoaTqPUjzEG4x6o0ZSbPTawT6iMDRM/eQq+Qp3dYZNXgyPI?=
 =?us-ascii?Q?qsN56lxR83zzqmbJdWkImiv/DFI0ZmjshfP98mAjv6bkLylQeouupstZKmES?=
 =?us-ascii?Q?Exa6rJUgxJ/IMHuYpApHCLPMZjzwh4LfEgwJAsPqzjfHgh/mVFWXkNWHijOg?=
 =?us-ascii?Q?EMRaYJHsesPNZoB9DnLsB5R0WGgMr/kNcEbnTnTFgg5Xv2cWAaXVXHWldyzb?=
 =?us-ascii?Q?xtHakNfOQoQyZc4CTGAHzb8J4swiKa5BIcGxQo6mlM9jGIAVLoU5cjKMwTLY?=
 =?us-ascii?Q?8XTjnX3Q7bY+xfAuokgGdOLbOTm0j/A/p1cWiVFA/Hsrv312Bb5dPrTFZLqL?=
 =?us-ascii?Q?KgreGAKzIE1+AAZPd5zw8vRKMVY5+6FJaOAnkHOoUK0ZEcT/uLjJ6grt1Caz?=
 =?us-ascii?Q?e5535bzFBBFZn5aMzR5LXyaDHkoUsLWgwaOCVcetBd9hf/ei39yup2AJqhh8?=
 =?us-ascii?Q?L1YMXDkGXIPDtKDz2FSp98TxE1ffmTRoG+LzmfQPzYMjIxjmDKK+iuPk3bG0?=
 =?us-ascii?Q?4wDSB6IBuBj0B4tfRSu2WjeJJuNuXFQS2oITg19Zfs5IPQtMCo+EpTwoVjD4?=
 =?us-ascii?Q?lg6Ptp5RKkc36Z4xwGcwhyuvZB5+A2MOmud7/o9+LWSbVrJnepu4O2eb8oXB?=
 =?us-ascii?Q?8izCfnG8zvE+pvBYmvQ3X0NytHCbVdzjxD9YMVySLeKOBTRa4mPj7WEVFZjG?=
 =?us-ascii?Q?dXhqvrchwqPGPuaeAF9LCjHMGuEiKOOIOxY08MLgdY2DBg/Dr6oM8bXmLaDf?=
 =?us-ascii?Q?7lk0tMDvSlBVg1U7+PFg6D7HSrcJ/LeQj8S9wrCdOy+Fugke4YCWUp1SMdXO?=
 =?us-ascii?Q?AQoDwRc/h8+f22aljojiFavhwVGbtg0qwZ8v7vwLPnQpgDc1JZM+VsCVZbKT?=
 =?us-ascii?Q?QF4fwWt+9xITiaefpw50LmRsToII+/2e35yzc3WZepovi05WTLVU2gbQKdZJ?=
 =?us-ascii?Q?wxMyUUhJ+8gxOZiy4qHkSqL7Q3widYkw1DFRfdvhvOXmjxwW3DwEppCNUBjR?=
 =?us-ascii?Q?AvfAiVUkiJBXCcuwfkBrjme89fldaDGXU7HVXNuXAz9LoSorPVwe4Vk4m/c4?=
 =?us-ascii?Q?cQaXY/Bg+nknLY+Thb4ZUt3QzNTtbBpA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FykfB9PB18Orag5QnuGsMP1m5gNkBDHZkM9hHb0LP8DbFbq4nzTJKc5VDtRX?=
 =?us-ascii?Q?KppusdvQ8osiXnAm64mGMEZ2XhRMND3b2ouvUWasfmjS8JflhnmG4Fxj6VjV?=
 =?us-ascii?Q?U7VxRaKhoFMVyRVVjbuJfTPZvRT4/fzk1mloT9+9GoE5tRUl+i0XejzgT5r1?=
 =?us-ascii?Q?csVJgOjykp8YplkBiikWtNzvzIHRkYCRHdm5612d92zYHlVMaPSRMKfsuvAz?=
 =?us-ascii?Q?GYTROJ8xOSmdzgAgx/0qnRLrtF0sPMyt2A5Iroi5rwvWj0LnKMEftmtt/oOc?=
 =?us-ascii?Q?pxRIy28haqNdJdTMJxgXiP/DWg+ffRJu/xE2HRuwJWagMil9skkJFVMezY03?=
 =?us-ascii?Q?jxX9i7gHLST7aZiWqvZQ72KwYHxnFPNzOpltqnrFozPC37LjreLYHm4E4HXP?=
 =?us-ascii?Q?E5YbNP4vCC0sPR8BnEFphKXf82lhsaPGE3y+C2FL881HUPGFOOsKhCX6JEA9?=
 =?us-ascii?Q?xMRR6K+Zq4Vkpo3r+hb/a1/5Yc905Hv0HqpG+qNvBqyNeCMsuiuOKxYXnE2f?=
 =?us-ascii?Q?FLqJvLyvHC+spBaBVvDl+mXpKm7fiKRm7vnuMfyZjQb/BprVe2rSz9HKde/d?=
 =?us-ascii?Q?bFP+rcjYsC0n33e5bi13CiJ5GGenw2NmNj2uUZdRFFf5JBnlY7Qc8z6suD4A?=
 =?us-ascii?Q?+2xINt6IoCQOHr0HcZJ3Q3lA+fMw58ccObs+b8JUiKYdLUydlTzJI52UITJ2?=
 =?us-ascii?Q?HFA3GxGDOVZ7fgfvDbCKWcuja2Hi6Y0tp/J6dVryZJKvZ04Nwa3VAAuVRH9J?=
 =?us-ascii?Q?zbEOSDn8uCcRx+8JjlRgku127JHRL+nCM4y/fC4o/hRL55BSxCF5xwKHOoGX?=
 =?us-ascii?Q?Z6yBo97kLax5es/u2bfoPel/vPGxRyIDKmlbaHDv6E0azHsiHTI5V3hz96fQ?=
 =?us-ascii?Q?8x1lCnNH/E1ae+4Mscmm/2toFxjtMgvs7OMvL9St4kkJxUAHX5Y8FZGNhYca?=
 =?us-ascii?Q?fC64mV45/hDDo2VRFjXtwTitgLT5ovvsrZ5+bcvbDKdSaWziaVdmpRz04xXI?=
 =?us-ascii?Q?FkzJXx9TBDBk8WARn1oiCZVYmGM904NAItmcqbxLYALHbVSQ8vSoJesgXNj9?=
 =?us-ascii?Q?niedVU9I276TKHxhvgCWz6d195DzuCPi0dfNqAk5S6H3Nw2yfJpclPfuH5Yr?=
 =?us-ascii?Q?yjHn5LCATvfp4Cc2PkSJgCUtMZYFN9Zav9lkFTYGiI2PnGFfWug4Gg1JgjPD?=
 =?us-ascii?Q?geOE6n73bei/3o5NdHVxFJ+o8PKiY4A1D1PtbFQnJKHbk3Xs3D+FAhYBZSid?=
 =?us-ascii?Q?kv45uJyuScLBucNjsYlyUmY2esMjW1YDfglHbHJZ8P9MBn67VsxQWfyGJWHK?=
 =?us-ascii?Q?vkamM4ei2OfHd78qK7/mB7sXRzOLuCcAZyYglQtH132NnPW5MhtmFbOHMYaA?=
 =?us-ascii?Q?alu0kLdjt/p2YlPPiShDWqQ/SFOL8BprGZJbLe8+eqTLn5vTyjfTzLc2FRb/?=
 =?us-ascii?Q?0ShwbpOHZF/JamXK8Ytty/Q4eYM48k/aouU6/XHUMXvTSqvS5U/eyK2uQxAk?=
 =?us-ascii?Q?lNiXIq2Jlvzo+9BW/JDtwFiSL5qgqw84FikF7vMAnbTvjtRSfTt93K5J3tFt?=
 =?us-ascii?Q?V0/SVsHqNOZakxFY5soOZ5XoIz1YpdNX69ZLLXHM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a275bb5-55ed-4d0f-360f-08dd4ca91fec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:39:02.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjLlrG+rf+kwPagoS0N+0TGcY7oCgzFnIu84vnvCqiyUElMeYNn/1PcYRk4iCzTlsj7vxGzvLizVlDNCDfoaKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10525

On Mon, Feb 10, 2025 at 05:00:11PM +0100, Alexander Stein wrote:
>The fracn gppll PLL so far only supports rates from a rate table passed
>during initialization. Calculating PLL settings dynamically helps audio
>applications to get their desired rates, so support for this is added
>in this patch.
>
>The strategy to get to the PLL setting for a rate is:
>
>- The rate table is searched for suitable rates, so for standard rates the
>  same settings are used as without this patch
>- Then try to only adjust mfn, on fractional PLLs only, which specifies
>  the fractional part of the PLL. This setting can be changed without
>  glitches on the output and is therefore preferred
>- As a last resort the best settings are calculated dynamically
>
>Implementation is inspired by commit b09c68dc57c9d ("clk: imx: pll14xx:
>Support dynamic rates")

Not a fan of this, we have seen issues that not able to calculate
out exact audio frequency with dynamic rates. But anyway
if your setup needs this feature, it is ok to add.

>
>Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>---
>This is the first time I'm touching PLL code, I might be missing things
>or not being aware of important aspects when it comes to PLL.
>Thus this is a RFC
>
> drivers/clk/imx/clk-fracn-gppll.c | 203 ++++++++++++++++++++++++++----
> 1 file changed, 181 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
>index a7d57fbe93196..68c5b4a95efbe 100644
>--- a/drivers/clk/imx/clk-fracn-gppll.c
>+++ b/drivers/clk/imx/clk-fracn-gppll.c
>@@ -25,6 +25,12 @@
> 
> #define PLL_NUMERATOR		0x40
> #define PLL_MFN_MASK		GENMASK(31, 2)
>+#define PLL_MFI_MIN		0x2
>+#define PLL_MFI_MAX		0x1ff
>+#define PLL_MFN_MIN		0x0
>+#define PLL_MFN_MAX		0x3fffffff
>+#define PLL_MFD_MIN		0x1
>+#define PLL_MFD_MAX		0x3fffffff
> 
> #define PLL_DENOMINATOR		0x50
> #define PLL_MFD_MASK		GENMASK(29, 0)
>@@ -134,21 +140,6 @@ imx_get_pll_settings(struct clk_fracn_gppll *pll, unsigned long rate)
> 	return NULL;
> }
> 
>-static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
>-				       unsigned long *prate)
>-{
>-	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
>-	const struct imx_fracn_gppll_rate_table *rate_table = pll->rate_table;
>-	int i;
>-
>-	/* Assuming rate_table is in descending order */
>-	for (i = 0; i < pll->rate_count; i++)
>-		if (rate >= rate_table[i].rate)
>-			return rate_table[i].rate;
>-
>-	/* return minimum supported value */
>-	return rate_table[pll->rate_count - 1].rate;
>-}
> 
> static long clk_fracn_gppll_calc_rate(struct clk_fracn_gppll *pll, u32 mfn,
> 				      u32 mfd, u32 mfi, u32 rdiv, u32 odiv,
>@@ -202,6 +193,174 @@ static long clk_fracn_gppll_calc_rate(struct clk_fracn_gppll *pll, u32 mfn,
> 	return (unsigned long)fvco;
> }
> 
>+static u32 clk_fracn_gppll_calc_mfi(int rdiv, unsigned long fvco,
>+				    unsigned long fref)
>+{
>+	u32 mfi;
>+
>+	/* fvco = fref / rdiv * mfi */
>+	mfi = DIV_ROUND_CLOSEST(fvco * rdiv, fref);
>+	return clamp_t(u32, mfi, PLL_MFI_MIN, PLL_MFI_MAX);
>+}
>+
>+static long clk_fracn_gppll_calc_mfn(int mfd, int mfi, int odiv, int rdiv,
>+				     unsigned long rate, unsigned long prate)
>+{
>+	unsigned long tmp;
>+	long mfn;
>+
>+	/* calc mfn = ((rate * odiv * rdiv / prate) - mfi) * mfd */
>+	tmp = rate * odiv * rdiv - (mfi * prate);
>+	mfn = DIV_ROUND_CLOSEST(tmp * mfd, prate);
>+	return clamp_t(long, mfn, PLL_MFN_MIN, PLL_MFN_MAX);
>+}
>+
>+static void clk_fracn_gppll_calc_settings(struct clk_fracn_gppll *pll, unsigned long rate,
>+					  unsigned long prate, struct imx_fracn_gppll_rate_table *t)
>+{
>+	u32 pll_denominator, pll_numerator, pll_div;
>+	u32 mfi, mfn, mfd, rdiv, odiv;
>+	long fout, rate_min, rate_max, dist, best = LONG_MAX;
>+	const struct imx_fracn_gppll_rate_table *tt;
>+
>+	/*
>+	 * PLL constrains:
>+	 *
>+	 * a) 1 <= MFN <= 0x3fffffff (fractional only)
>+	 * b) 1 <= MFD <= 0x3fffffff (fractional only)
>+	 * c) 2 <= MFI <= 0x1ff
>+	 * d) 1 <= RDIV <= 7
>+	 * e) 2 <= ODIV <= 255
>+	 * f) -2 <= MFN/MFD <= 2
>+	 * g) 20MHz <= (Fref / rdiv) <= 40MHz
>+	 * h) 2.5GHz <= Fvco <= 5Ghz
>+	 *
>+	 * Fvco = (Fref / rdiv) * (MFI + MFN / MFD)
>+	 * Fout = Fvco / odiv
>+	 */
>+
>+	/* First try if we can get the desired rate from one of the static entries */
>+	tt = imx_get_pll_settings(pll, rate);
>+	if (tt) {
>+		pr_debug("%s: in=%ld, want=%ld, Using PLL setting from table\n",
>+			 clk_hw_get_name(&pll->hw), prate, rate);
>+		t->rate = tt->rate;
>+		t->mfi = tt->mfi;
>+		t->mfn = tt->mfn;
>+		t->mfd = tt->mfd;
>+		t->rdiv = tt->rdiv;
>+		t->odiv = tt->odiv;
>+		return;
>+	}
>+
>+	/* glitch free MFN adjustment only for fractional PLL */
>+	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
>+		pll_numerator = readl_relaxed(pll->base + PLL_NUMERATOR);
>+
>+		pll_denominator = readl_relaxed(pll->base + PLL_DENOMINATOR);
>+		mfd = FIELD_GET(PLL_MFD_MASK, pll_denominator);
>+
>+		pll_div = readl_relaxed(pll->base + PLL_DIV);
>+		mfi = FIELD_GET(PLL_MFI_MASK, pll_div);
>+		rdiv = FIELD_GET(PLL_RDIV_MASK, pll_div);
>+		odiv = FIELD_GET(PLL_ODIV_MASK, pll_div);
>+
>+		/* Then see if we can get the desired rate by only adjusting MFN (glitch free) */
>+		rate_min = clk_fracn_gppll_calc_rate(pll, PLL_MFN_MIN, mfd, mfi, rdiv, odiv, prate);
>+		rate_max = clk_fracn_gppll_calc_rate(pll, PLL_MFN_MAX, mfd, mfi, rdiv, odiv, prate);
>+
>+		if (rate >= rate_min && rate <= rate_max) {
>+			mfn = clk_fracn_gppll_calc_mfn(mfd, mfi, odiv, rdiv, rate, prate);
>+			pr_debug("%s: in=%ld, want=%ld Only adjust mfn %ld -> %d\n",
>+				 clk_hw_get_name(&pll->hw), prate, rate,
>+				 FIELD_GET(PLL_MFN_MASK, pll_numerator), mfn);
>+			fout = clk_fracn_gppll_calc_rate(pll, mfn, mfd, mfi, rdiv, odiv, prate);
>+			t->rate = (unsigned int)fout;
>+			t->mfi = mfi;
>+			t->mfn = mfn;
>+			t->mfd = mfd;
>+			t->rdiv = rdiv;
>+			t->odiv = odiv;
>+			return;
>+		}
>+	}
>+
>+	/* Finally calculate best values */
>+	for (rdiv = 1; rdiv <= 7; rdiv++) {
>+		if ((prate / rdiv) < 20000000)
>+			continue;
>+		if ((prate / rdiv) > 40000000)
>+			continue;
>+
>+		for (odiv = 2; odiv <= 255; odiv++) {
>+			mfi = clk_fracn_gppll_calc_mfi(rdiv, rate * odiv, prate);
>+			mfd = 1;
>+			mfn = 0;
>+
>+			/* Try integer PLL part only first */
>+			fout = clk_fracn_gppll_calc_rate(pll, mfn, mfd, mfi, rdiv, odiv, prate);
>+			if (fout * odiv < 2500000000UL)
>+				continue;
>+			if (fout * odiv > 5000000000UL)
>+				continue;
>+
>+			if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
>+				if (!dist) {
>+					/* Disable fractional part upon exact match */
>+					mfd = 1;
>+					mfn = 0;
>+				} else {
>+					mfd = 100;

why hardcode mfd to 100?

>+					mfd = clamp(mfd, PLL_MFD_MIN, PLL_MFN_MAX);
>+
>+					mfn = clk_fracn_gppll_calc_mfn(mfd, mfi, odiv, rdiv, rate, prate);
>+					if ((mfn / mfd) > 2)
>+						continue;
>+
>+					fout = clk_fracn_gppll_calc_rate(pll, mfn, mfd, mfi, rdiv, odiv, prate);
>+					if (fout * odiv < 2500000000)
>+						continue;
>+					if (fout * odiv > 5000000000)
>+						continue;
>+				}
>+			} else {
>+				mfd = 0;
>+				mfn = 0;
>+			}
>+
>+			/* best match */
>+			dist = abs((long)rate - (long)fout);
>+			if (dist < best) {
>+				best = dist;
>+				t->rate = (unsigned int)fout;
>+				t->mfi = mfi;
>+				t->mfn = mfn;
>+				t->mfd = mfd;
>+				t->rdiv = rdiv;
>+				t->odiv = odiv;
>+
>+				if (!dist)
>+					goto found;
>+			}
>+		}
>+	}
>+found:
>+	pr_debug("%s: in=%lu, want=%lu got=%u (mfi=%u mfn=%u mfd=%u rdiv=%u odiv=%u)\n",
>+		 clk_hw_get_name(&pll->hw), prate, rate, t->rate, t->mfi, t->mfn, t->mfd,
>+		 t->rdiv, t->odiv);
>+}
>+
>+static long clk_fracn_gppll_round_rate(struct clk_hw *hw, unsigned long rate,
>+				       unsigned long *prate)
>+{
>+	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
>+	struct imx_fracn_gppll_rate_table t;
>+
>+	clk_fracn_gppll_calc_settings(pll, rate, *prate, &t);
>+
>+	return t.rate;
>+}
>+
> static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> {
> 	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
>@@ -242,11 +401,11 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> 				    unsigned long prate)
> {
> 	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(hw);
>-	const struct imx_fracn_gppll_rate_table *rate;
>+	struct imx_fracn_gppll_rate_table rate;
> 	u32 tmp, pll_div, ana_mfn;
> 	int ret;
> 
>-	rate = imx_get_pll_settings(pll, drate);
>+	clk_fracn_gppll_calc_settings(pll, drate, prate, &rate);
> 
> 	/* Hardware control select disable. PLL is control by register */
> 	tmp = readl_relaxed(pll->base + PLL_CTRL);
>@@ -266,13 +425,13 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> 	tmp &= ~CLKMUX_BYPASS;
> 	writel_relaxed(tmp, pll->base + PLL_CTRL);

As Sascha mentioned, set rate will first disable output, power down pll based
on current implementation. So this patch might not get tested.

Regards
Peng

> 
>-	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
>-		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
>+	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate.rdiv) | rate.odiv |
>+		FIELD_PREP(PLL_MFI_MASK, rate.mfi);
> 	writel_relaxed(pll_div, pll->base + PLL_DIV);
> 	readl(pll->base + PLL_DIV);
> 	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
>-		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
>-		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
>+		writel_relaxed(rate.mfd, pll->base + PLL_DENOMINATOR);
>+		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate.mfn), pll->base + PLL_NUMERATOR);
> 		readl(pll->base + PLL_NUMERATOR);
> 	}
> 
>@@ -296,7 +455,7 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
> 	ana_mfn = readl_relaxed(pll->base + PLL_STATUS);
> 	ana_mfn = FIELD_GET(PLL_MFN_MASK, ana_mfn);
> 
>-	WARN(ana_mfn != rate->mfn, "ana_mfn != rate->mfn\n");
>+	WARN(ana_mfn != rate.mfn, "ana_mfn != rate->mfn\n");
> 
> 	return 0;
> }
>-- 
>2.34.1
>

