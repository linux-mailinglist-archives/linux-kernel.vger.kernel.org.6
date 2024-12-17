Return-Path: <linux-kernel+bounces-449545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1221B9F5097
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CFE18802F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282621FCF4F;
	Tue, 17 Dec 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="leY865KZ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9721FCCE5;
	Tue, 17 Dec 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451360; cv=fail; b=ijFd4XyZUTaJLcJGERpF5p8S+S5xg+A2Yx6HIGI4SFFtaz7NMzvnQ07rBXbgr+ZnPkob0Q6HyDvpSMnZt1hRp0H5Ke+kbjsjDeaobvYOmlRwTpRGjbRtoIJ2dlDQcjV0bdaU48/ObN7qFpipZkTmQypo3X+RXIPeBwY18fr+v+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451360; c=relaxed/simple;
	bh=BX16FuMVHbGv3ccNKSbwqqvyEmD94JU61dX7zrj/jBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LOAbzi9wyyszzPuNpjI2zpPYvoPTahxcVpFmogKHrvcpYP3VVFN+yP3FVrZznMU1/0nn7chqxWnThS//zx9em/69B180ZQGI6GE2sw3HJpWCryNh/GZvHuZZqOvzuGcWtm/i7ve+55zDMOXSorNYfYzMI2POCEAgHob/SgVSw9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=leY865KZ; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsIcdXq1Ls+t4oAIYQpyhQ8rRglIfyp8x1DGwx11Llp0ppuv13bPErkALhcinA9IvcnS3LmhzbF8sRPNWXfe3UbqD3e9SXEewNc9afQ97fLhNC4BqhUIDMhAAPyXSpsFudowGHU2JWiRLz3nAiahvYzlcBzYZt+o7HzuSj48MeIQgLpFqbL9jw12bq6o3c6d4Nafrh9KVIMVb0eUKwkIXZmClrgNgz8/FWIrSo0UyOE5Mwmc9GOWwVzWB+CHcME8e+A2pYZ2CdYs4S1NkVtfc50wPmPyrnF7uhhhDc6QlCfXztldm23Qq/GLpYbnuiuVNoHU2NfywI5bvTxCdEPNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Mbw88LtnP7mM0LHR0niFdKKlhaBTUjYxnCbV5+EYSo=;
 b=AMRr+881fLmle1xk05Yn8axxQCEhctKcWkDO6xqk19lXbOLsA1oXYkUVgLwiGhFvORTvk68/MLIwcgnmIOsufgduMcAVOVfUymPuy4zMgAZZ+zzbQIV9GdX2EP3qWM8YgIYXcVG+RYoKImm0zmT1xYQCTbmVQ5UNKKJkG/zTpcIh2wkL8vKrly/iR8s3nQ0NSpoFqzPPesKENEgMt4dwErqMakWp7q4cxObXUHOQaXesuj3rEd+SYe8Db1jeyHyXxUg8bYaJ/mhmRSmqX0qnKfZgUJuEf7QN/7fJtWTyJKg5BtQETh0ybJfo0/HLcWlk816VhRqC32oP5O5xZHaDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mbw88LtnP7mM0LHR0niFdKKlhaBTUjYxnCbV5+EYSo=;
 b=leY865KZCmaxlI+YzJx9xPYvc1YZTwYzvH8J3UrZXoScHvWnmKYYCyaCnONIouPH91UCbpCNjebrtzM920Xyqvp7opB/4tPUva9I4KNOgzbELnkGMUa34p15uQHW49nLeJ0v4TdxEgg1al+ZC/EtH7dDouJElrwP14G97LVupwsOZtP3QwixUFoIozQqrdjaN57YJl0AqT8KdC6uQitdMy5+V3mT0OKWu3+I1b4bQsgsXOmAbc704WMzEElGlSm+TNEkxnKN7TA1a7yJSNq70tcnUOBc2h/sP5GOrC3oSwa2YzcLcSGq+S8bsAEESUp5nKZaEG8aN+Qy9cTSYY/CNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 16:02:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 16:02:34 +0000
Date: Tue, 17 Dec 2024 11:02:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] nvmem: imx-ocotp-ele: Support accessing
 controller for i.MX9
Message-ID: <Z2GgkELx2EdF8fKl@lizhi-Precision-Tower-5810>
References: <20241217-imx-ocotp-v2-0-3faa6cbff41b@nxp.com>
 <20241217-imx-ocotp-v2-2-3faa6cbff41b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-imx-ocotp-v2-2-3faa6cbff41b@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 3268ad15-13c7-4a41-0078-08dd1eb43800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UihePLqaiEYYtdKiD4V/NZbqC+gXmVll0KitktNR0boabXnVffzTCfxSI+99?=
 =?us-ascii?Q?8Ofd0Uw0FDN9ORowXDVmt74TtYIeZj5YE9S0hiWWtNQ53AHm/iWbCb7aNke7?=
 =?us-ascii?Q?ZCkPLkiDzm0SZ3alBYMWFJ6p3aAZI5h3k0CCMS1RnELO4YHeRg89Zb+CANhu?=
 =?us-ascii?Q?ciEzcqqOIssF2RZJLZQt9N+VDYJIonwqCX7z8UVClCTZGwhvUeWFlA/dhA0x?=
 =?us-ascii?Q?uIH5b2iD2povEgYa3wtGuN0/DI5pcbux4lRFIYASGZJTQGIYlTfa5z1naCwV?=
 =?us-ascii?Q?mNVKEFyNVM5CHxz/Y5azbqSl7AlvjmkaLX74qiVhBUpiHhKrINyudZ+Y8sjE?=
 =?us-ascii?Q?FjcFwjPfAyuARtjjAXhRrtS1C7MmSXCXlPHtpeb96DjM7DYZGWeHrXtBgth3?=
 =?us-ascii?Q?Hn4+JHsiUW4nF5JKlTXb61Y3UIokzHhFQTtg3iL2uCKwuBgJEdhC1XsoDeYu?=
 =?us-ascii?Q?Xsy00PmZpfpGxWFku7lVsd1fYnuRHouN0Ob8PIleaU+LYEujDbf5f2T7nE3U?=
 =?us-ascii?Q?K+hhw3rodwrot9/dPkV1u30cJa9Eztt37gYzopmat/K2NeLDSFeJWtDfrFCj?=
 =?us-ascii?Q?+nzLRL7KgPFgoK9U5gMCB44/SZ+Bl+SYqZEU9H1hIsc09YSBINMDPNd6aJ4E?=
 =?us-ascii?Q?oU6TunKBqq6UAkXRJIEINVZS62qkpfNOfvBpHVILW7Z8JnA3VCCMBAKugqeG?=
 =?us-ascii?Q?pA234xg32Wa4plKQwth01rvw9MiiYKs8F5JJnrgMavxcPHFIxhRR2TGH2jIk?=
 =?us-ascii?Q?+6f//HhZEDLnLZHYO15au48AA/q4yhaUxyWXZD0rP3XCBlxCqJ+JZ68cnq9L?=
 =?us-ascii?Q?jPvHPl+g8oEiEZybFYlyQ0iT3Q5LS038hKO4MHj+9htntnOe4BuDOT9GgcUD?=
 =?us-ascii?Q?GOKsATDReBnnB4hoH0DgaZJi8tHUcweDvVm3q+zlQ9In/wbXIevS5KIHnd+F?=
 =?us-ascii?Q?CKGvZnpqqQEupQiDrRlvUwZ1W6fsetIuevczAP3KMWXmkuoqQ2Mibd/Atr6T?=
 =?us-ascii?Q?WXKGA4IOpjl9NH9/ls5B5VtBr7yRbPkGnzxIhjpm4FEllM4W+sRpENhozXNM?=
 =?us-ascii?Q?V9+l12LBmAk9q87eQta4mKaZFXKUenOEoew+XrodVOFx1Dv5wVWLFpGsUDKl?=
 =?us-ascii?Q?rxIIa9u6z7c0FFy3LGJJlqNN8w/EEBNcICKfy+uN8qoJPbUX1vUP294eEoxS?=
 =?us-ascii?Q?r4wBhKYMejcdHu++ZS7AT+aDLy9bTsD+t/Evfyk7GUU3m/1sF/mVgoaTNWJb?=
 =?us-ascii?Q?CY7EZarqVdFhSy13ngGrK4MjeWCrb0rAG5IPaO3Si2iciQxzynQ2VBE9JA/U?=
 =?us-ascii?Q?fqSO++C1xAr8paFEIDvvEacNcOTOtn4n8vedekQy7grEpmwckiFNyTupGNgi?=
 =?us-ascii?Q?Kcg7Td4LnZH1s9g+GvTwlECdmSNAjj7P7NzN4WBX/671gwuoQnivRAPEPszc?=
 =?us-ascii?Q?gbG6BfRjVnqhAwSlcoNuV8IEv/ZkDw8r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?geYrR1/a5zEpBIFZ3UUz5b+8/Aj7TONIcbWwFtruiIDnRXAk3+qV4AMUT5BW?=
 =?us-ascii?Q?vFclgLku5sYHpKG1+5qKKUuQX3zZlUeEv+hiwUH5oiJZHil7U9xYdZlM31io?=
 =?us-ascii?Q?pFAI2VaCZJ26QuS0rLA9yRb8jL310rRTjW2jsL2XI35EID0xUCa/SUHWsu9T?=
 =?us-ascii?Q?mSxYTjRkRag7ngIbQOLmg+27fu3SpLw/bhkaeiPy5UhvtigIU+ffsAvYseQK?=
 =?us-ascii?Q?8lq6Zi6ahwfNRMp3WfV62hVm515MPsfZRamBAXuzX1+uV+x/0Y8xe/zpjbS8?=
 =?us-ascii?Q?9Ew4eIOj1MK6tpsUKkM3L/dldlN3/IvPfgzxsfixiWPYwKeGbRDOyxjoHBgD?=
 =?us-ascii?Q?n9lujBJhtyIaTYqNPVfwUa/u9M9+kcBuN9l2f/bo8VzfbM+8WzVJMFHNp7RX?=
 =?us-ascii?Q?TPsy9ObA5BbtAbF0bsqbqNO5zy0CJYXi6IbdrNw2rXmLQ6Sy4RAMEoZ9aZFl?=
 =?us-ascii?Q?ZAeq1FQgelmdFPBnVC/63RcRhocQRPzYOqDopq4nmRcZBNiBn7u4iF46q7w2?=
 =?us-ascii?Q?6lTlxhMtkR9zZ7oRr+ukRZzwkhzM++vtjEojDDhfz+QBk+95VuZZryUL0mAG?=
 =?us-ascii?Q?7eDbQEia+73SunNbhCyHxvfD/+me6T8E+rZiM7bjvpecg18rq2JzjHgv7M66?=
 =?us-ascii?Q?lwPPBm9dpprpaKROhRzIhu6AWQDUGTgNKt5OJd4rdnrqiWQS0u35EOAxk4uh?=
 =?us-ascii?Q?KastfzHxKd2wa968IqnZXCFUnil+byPn8eNCd8Mak9/YIm6mXe6+2cHMFqjM?=
 =?us-ascii?Q?2TDr7RpUznvIVzqktpoZPnycV3scyeSQS0XP8w9+KsXD5Tf4T1WkvOLggbrL?=
 =?us-ascii?Q?0SB7CC24orlhFbxMqHQvuu0wSLc1TvU7N1SFnCncDPvLpC3R6dCe3Xu6wmv8?=
 =?us-ascii?Q?xFDAjlOEaq9jOkY5zRl5JlzBPFQ+xXUCMBUqCn6StdqCE1No9Q6ldAlVM1oU?=
 =?us-ascii?Q?yG22Hh2eQkBJe1xjBD2LC6JFwdlfmCtA9uzvsVRzPSA4OxfsuHOHS72GKwmO?=
 =?us-ascii?Q?6n7QREePDvx2VuayVLOBKS8/1KmsWAmhYvUMQTicMECERT/ifSZslXu+ZeqA?=
 =?us-ascii?Q?Z9JGWHYkhzlBOEiVAqNsJM4HmtRUQznGXap/P5cDy27WxcCrJhZQ4b8PCCk3?=
 =?us-ascii?Q?hoHrntIg6Yi0N0T2G+SNLKsHLhLFHJ1gIrMtS18034sNQAAxPS7FCjemMgwi?=
 =?us-ascii?Q?4CFadMsvT3uzNRfZ7+L69TCIEThHgqQyyMwgA1/AbXMnlzZcDYwn17BtSfYs?=
 =?us-ascii?Q?sF5YQGx2fVbTXIVYubtI7dswPo/3lKlbLR1rEtcjRw04wrkSikxT+ZIvq1YL?=
 =?us-ascii?Q?OgL3Jq+Se+wbEuStXsdsxgggLbg78vm/csMKM1fDVHp2lagckqcQ7Rkd5Gar?=
 =?us-ascii?Q?tJRizyz2N4zhpE9ELZXomSVxZ/NoJgqLEinFrGp03zwRvax9rt5x8ru5mFh0?=
 =?us-ascii?Q?t6gN2PYoGwV9R9acpppaRsQDV17jyP9lfKQru5+giWszbQpOo5LQjM3/c/t5?=
 =?us-ascii?Q?wfmDXZSgPs7ar+/a7Bokn1ZEZ6WB3nuSqa2S5oj5BsZiI5D1H/6k/lmlJorC?=
 =?us-ascii?Q?mKtwRFu4dmRCQf3fMzI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3268ad15-13c7-4a41-0078-08dd1eb43800
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:02:34.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTujc9TB68oMY1m3ytSf4X1+ecYOBM0kwuRkbVstBGSyvXJzU7oFCCmy0W+VxjWYpimBoCb4m70iZXieECfnQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594

On Tue, Dec 17, 2024 at 04:43:37PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX9 OCOTP supports a specific peripheral or function being fused
> which means disabled, so
>  - Introduce ocotp_access_gates to be container of efuse gate info
>  - Iterate each node under '/soc' to check accessing permission. If not
>    allowed to be accessed, detach the node
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp-ele.c | 184 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 183 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
> index ca6dd71d8a2e29888c6e556aaea116c1a967cb5f..2c7b698ae4da0ec22eeeabf4ed35d1b703771f6c 100644
> --- a/drivers/nvmem/imx-ocotp-ele.c
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -5,6 +5,8 @@
>   * Copyright 2023 NXP
>   */
>
> +#include <dt-bindings/nvmem/fsl,imx93-ocotp.h>
> +#include <dt-bindings/nvmem/fsl,imx95-ocotp.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -27,6 +29,7 @@ struct ocotp_map_entry {
>  };
>
>  struct ocotp_devtype_data {
> +	const struct ocotp_access_gates *access_gates;
>  	u32 reg_off;
>  	char *name;
>  	u32 size;
> @@ -36,11 +39,26 @@ struct ocotp_devtype_data {
>  	struct ocotp_map_entry entry[];
>  };
>
> +#define OCOTP_MAX_NUM_GATE_WORDS 4
> +#define IMX93_OCOTP_NUM_GATES 17
> +#define IMX95_OCOTP_NUM_GATES 36
> +
> +struct ocotp_access_gates {
> +	u32 num_words;
> +	u32 words[OCOTP_MAX_NUM_GATE_WORDS];
> +	u32 num_gates;
> +	struct access_gate {
> +		u32 word;
> +		u32 mask;
> +	} gates[];
> +};
> +
>  struct imx_ocotp_priv {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct nvmem_config config;
>  	struct mutex lock;
> +	u32 value[OCOTP_MAX_NUM_GATE_WORDS];
>  	const struct ocotp_devtype_data *data;
>  };
>
> @@ -131,6 +149,97 @@ static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
>  	cell->read_post_process = imx_ocotp_cell_pp;
>  }
>
> +static int imx_ele_ocotp_check_access(struct platform_device *pdev, u32 id)
> +{
> +	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
> +	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
> +	u32 word, mask;
> +
> +	if (id >= access_gates->num_gates) {
> +		dev_err(&pdev->dev, "Index %d too large\n", id);
> +		return -EACCES;
> +	}
> +
> +	word = access_gates->gates[id].word;
> +	mask = access_gates->gates[id].mask;
> +
> +	dev_dbg(&pdev->dev, "id:%d word:%d mask:0x%08x\n", id, word, mask);
> +	/* true means not allow access */
> +	if (priv->value[word] & mask)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static int imx_ele_ocotp_grant_access(struct platform_device *pdev, struct device_node *parent)
> +{
> +	struct device_node *child;
> +	struct device *dev = &pdev->dev;

move 'dev' before child.

> +
> +	for_each_available_child_of_node(parent, child) {

for_each_child_of_node_scoped() ?

I am not sure if you need of_node_put for child node.

Frank

> +		struct of_phandle_iterator it;
> +		int err;
> +		u32 id;
> +
> +		of_for_each_phandle(&it, err, child, "access-controllers",
> +				    "#access-controller-cells", 0) {
> +			struct of_phandle_args provider_args;
> +			struct device_node *provider = it.node;
> +
> +			if (err) {
> +				dev_err(dev, "Unable to get access-controllers property for node %s\n, err: %d",
> +					child->full_name, err);
> +				of_node_put(provider);
> +				return err;
> +			}
> +
> +			/* Only support one cell */
> +			if (of_phandle_iterator_args(&it, provider_args.args, 1) != 1) {
> +				dev_err(dev, "wrong args count\n");
> +				return -EINVAL;
> +			}
> +
> +			id = provider_args.args[0];
> +
> +			dev_dbg(dev, "Checking node: %s gate: %d\n", child->full_name, id);
> +
> +			if (imx_ele_ocotp_check_access(pdev, id)) {
> +				of_detach_node(child);
> +				dev_err(dev, "%s: Not granted, device driver will not be probed\n",
> +					child->full_name);
> +			}
> +		}
> +
> +		imx_ele_ocotp_grant_access(pdev, child);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_ele_ocotp_access_control(struct platform_device *pdev)
> +{
> +	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
> +	struct device_node *root __free(device_node) = of_find_node_by_path("/");
> +	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
> +	void __iomem *reg = priv->base + priv->data->reg_off;
> +	u32 off;
> +	int i;
> +
> +	if (!priv->data->access_gates)
> +		return 0;
> +
> +	/* This should never happen */
> +	WARN_ON(!root);
> +
> +	for (i = 0; i < access_gates->num_words; i++) {
> +		off = access_gates->words[i] << 2;
> +		priv->value[i] = readl(reg + off);
> +		dev_dbg(&pdev->dev, "word:%d 0x%08x\n", access_gates->words[i], priv->value[i]);
> +	}
> +
> +	return imx_ele_ocotp_grant_access(pdev, root);
> +}
> +
>  static int imx_ele_ocotp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -161,14 +270,43 @@ static int imx_ele_ocotp_probe(struct platform_device *pdev)
>  	priv->config.fixup_dt_cell_info = imx_ocotp_fixup_dt_cell_info;
>  	mutex_init(&priv->lock);
>
> +	platform_set_drvdata(pdev, priv);
> +
>  	nvmem = devm_nvmem_register(dev, &priv->config);
>  	if (IS_ERR(nvmem))
>  		return PTR_ERR(nvmem);
>
> -	return 0;
> +
> +	return imx_ele_ocotp_access_control(pdev);
>  }
>
> +static const struct ocotp_access_gates imx93_access_gates = {
> +	.num_words = 3,
> +	.words = {19, 20, 21},
> +	.num_gates = IMX93_OCOTP_NUM_GATES,
> +	.gates = {
> +		[IMX93_OCOTP_NPU_GATE]		= { .word = 19, .mask = BIT(13) },
> +		[IMX93_OCOTP_A550_GATE]		= { .word = 19, .mask = BIT(14) },
> +		[IMX93_OCOTP_A551_GATE]		= { .word = 19, .mask = BIT(15) },
> +		[IMX93_OCOTP_M33_GATE]		= { .word = 19, .mask = BIT(24) },
> +		[IMX93_OCOTP_CAN1_FD_GATE]	= { .word = 19, .mask = BIT(28) },
> +		[IMX93_OCOTP_CAN2_FD_GATE]	= { .word = 19, .mask = BIT(29) },
> +		[IMX93_OCOTP_CAN1_GATE]		= { .word = 19, .mask = BIT(30) },
> +		[IMX93_OCOTP_CAN2_GATE]		= { .word = 19, .mask = BIT(31) },
> +		[IMX93_OCOTP_USB1_GATE]		= { .word = 20, .mask = BIT(3) },
> +		[IMX93_OCOTP_USB2_GATE]		= { .word = 20, .mask = BIT(4) },
> +		[IMX93_OCOTP_ENET1_GATE]	= { .word = 20, .mask = BIT(5) },
> +		[IMX93_OCOTP_ENET2_GATE]	= { .word = 20, .mask = BIT(6) },
> +		[IMX93_OCOTP_PXP_GATE]		= { .word = 20, .mask = BIT(10) },
> +		[IMX93_OCOTP_MIPI_CSI1_GATE]	= { .word = 20, .mask = BIT(17) },
> +		[IMX93_OCOTP_MIPI_DSI1_GATE]	= { .word = 20, .mask = BIT(19) },
> +		[IMX93_OCOTP_LVDS1_GATE]	= { .word = 20, .mask = BIT(24) },
> +		[IMX93_OCOTP_ADC1_GATE]		= { .word = 21, .mask = BIT(7) },
> +	},
> +};
> +
>  static const struct ocotp_devtype_data imx93_ocotp_data = {
> +	.access_gates = &imx93_access_gates,
>  	.reg_off = 0x8000,
>  	.reg_read = imx_ocotp_reg_read,
>  	.size = 2048,
> @@ -183,7 +321,51 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
>  	},
>  };
>
> +static const struct ocotp_access_gates imx95_access_gates = {
> +	.num_words = 3,
> +	.words = {17, 18, 19},
> +	.num_gates = IMX95_OCOTP_NUM_GATES,
> +	.gates = {
> +		[IMX95_OCOTP_CANFD1_GATE]	= { .word = 17, .mask = BIT(20) },
> +		[IMX95_OCOTP_CANFD2_GATE]	= { .word = 17, .mask = BIT(21) },
> +		[IMX95_OCOTP_CANFD3_GATE]	= { .word = 17, .mask = BIT(22) },
> +		[IMX95_OCOTP_CANFD4_GATE]	= { .word = 17, .mask = BIT(23) },
> +		[IMX95_OCOTP_CANFD5_GATE]	= { .word = 17, .mask = BIT(24) },
> +		[IMX95_OCOTP_CAN1_GATE]	= { .word = 17, .mask = BIT(25) },
> +		[IMX95_OCOTP_CAN2_GATE]	= { .word = 17, .mask = BIT(26) },
> +		[IMX95_OCOTP_CAN3_GATE]	= { .word = 17, .mask = BIT(27) },
> +		[IMX95_OCOTP_CAN4_GATE]	= { .word = 17, .mask = BIT(28) },
> +		[IMX95_OCOTP_CAN5_GATE]	= { .word = 17, .mask = BIT(29) },
> +		[IMX95_OCOTP_NPU_GATE]		= { .word = 18, .mask = BIT(0) },
> +		[IMX95_OCOTP_A550_GATE]	= { .word = 18, .mask = BIT(1) },
> +		[IMX95_OCOTP_A551_GATE]	= { .word = 18, .mask = BIT(2) },
> +		[IMX95_OCOTP_A552_GATE]	= { .word = 18, .mask = BIT(3) },
> +		[IMX95_OCOTP_A553_GATE]	= { .word = 18, .mask = BIT(4) },
> +		[IMX95_OCOTP_A554_GATE]	= { .word = 18, .mask = BIT(5) },
> +		[IMX95_OCOTP_A555_GATE]	= { .word = 18, .mask = BIT(6) },
> +		[IMX95_OCOTP_M7_GATE]		= { .word = 18, .mask = BIT(9) },
> +		[IMX95_OCOTP_DCSS_GATE]	= { .word = 18, .mask = BIT(22) },
> +		[IMX95_OCOTP_LVDS1_GATE]	= { .word = 18, .mask = BIT(27) },
> +		[IMX95_OCOTP_ISP_GATE]		= { .word = 18, .mask = BIT(29) },
> +		[IMX95_OCOTP_USB1_GATE]	= { .word = 19, .mask = BIT(2) },
> +		[IMX95_OCOTP_USB2_GATE]	= { .word = 19, .mask = BIT(3) },
> +		[IMX95_OCOTP_NETC_GATE]	= { .word = 19, .mask = BIT(4) },
> +		[IMX95_OCOTP_PCIE1_GATE]	= { .word = 19, .mask = BIT(6) },
> +		[IMX95_OCOTP_PCIE2_GATE]	= { .word = 19, .mask = BIT(7) },
> +		[IMX95_OCOTP_ADC1_GATE]	= { .word = 19, .mask = BIT(8) },
> +		[IMX95_OCOTP_EARC_RX_GATE]	= { .word = 19, .mask = BIT(11) },
> +		[IMX95_OCOTP_GPU3D_GATE]	= { .word = 19, .mask = BIT(16) },
> +		[IMX95_OCOTP_VPU_GATE]		= { .word = 19, .mask = BIT(17) },
> +		[IMX95_OCOTP_JPEG_ENC_GATE]	= { .word = 19, .mask = BIT(18) },
> +		[IMX95_OCOTP_JPEG_DEC_GATE]	= { .word = 19, .mask = BIT(19) },
> +		[IMX95_OCOTP_MIPI_CSI1_GATE]	= { .word = 19, .mask = BIT(21) },
> +		[IMX95_OCOTP_MIPI_CSI2_GATE]	= { .word = 19, .mask = BIT(22) },
> +		[IMX95_OCOTP_MIPI_DSI1_GATE]	= { .word = 19, .mask = BIT(23) },
> +	}
> +};
> +
>  static const struct ocotp_devtype_data imx95_ocotp_data = {
> +	.access_gates = &imx95_access_gates,
>  	.reg_off = 0x8000,
>  	.reg_read = imx_ocotp_reg_read,
>  	.size = 2048,
>
> --
> 2.37.1
>

