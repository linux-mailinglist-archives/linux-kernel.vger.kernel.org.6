Return-Path: <linux-kernel+bounces-192618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809628D1FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13CC1C224A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A08171084;
	Tue, 28 May 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rcYFjAya"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239017082D;
	Tue, 28 May 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908932; cv=fail; b=kO30oPOXRCpuUIDdxI4yTNM5wdNkU4krDkrybL4z4BWiAge6GiGqt6iQ2WGom5EjKOXpp6WpOZnPdCZI8BnadP+r9KkAfH6viwLQcSXv65atigZoyNnzCp3JYPA2pFDDjKF+jL7DAGYfLKElEi5/KhRss6v0R9xt25+m/J4WD6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908932; c=relaxed/simple;
	bh=7xSsGoezWzjvrKfYc1JEk8pw7qIBZFjsWpOAQEGQT1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RbrmiMUzgxSatxaUD4Cktb8MCjIGzN/gSbSToHW+ahG/XNH/jPxWxUNExambMUq1eseV8EfN9Clnu7Ce9Vv4hJGGjL2YraH9oAQxAwqwO5W4ogevfBXS3H272l4AqFS3shqub5Ej2XP1F8uMjD9+6bTEYCKijTziLNjACl64Zlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rcYFjAya; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoQCVmdne2RHqWelEALwWxynh5VgrDqfhleQF+Cjfbot9QZbU8FcD7kXJpHbDxMWXoklpI4oQF02BrlhGRlqK2rBv7zJb/132LpBccQ6oDmq/YoSBz9oZ6ceXOOuBAMUH9hMVoWV+1qAzGkaUsLsyNV+rRhyusypPE4hxn3r0N9mVc4ddApXH8xb1DpxVSpYT54pbmcB76Ccj/jXXflXJd3XZlQKtazUoQPmibx3T/mhgR9j+BKXGgm2acvaoeL04cXzsZIdcF8HuYrOaqtg74Bmwkv8HcRT6Ip4w686PwXVQgIv284CvOKdH25fS77pWLXcf91SJnmzJBvqNeOsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBX/zUEGIfp1cMpGpR1kLgz1+vaj7NHYeR0E/zF478o=;
 b=mzRELLUvpks/H4HJbkZv1W4G2abgLSHYjtiBWY8RT0ZdhOL+zCblAxpgc4RMHx631VVYyKb25z6j6uF2EZ0ssvCitjcFjXbDd2NlF7TYabInS9ziqtojgc5pajh0f/ANZuRZgFK3UbIoRomjz4+BreAWrztl8NiWqXVB57vxsw7j2OVQV7j3c3zNbtjvrRdEftjd3b/4x3cCq1UhmB3Pw+6kvvWH9ZssdK54d1gQcg9BYSNK96tpCWHSanBvvMvTQ/2G0bEp0noGTf5JE14J0jOhu1s0UM7sn+en+UXpO5jBYdWr0/UxWhAhrEpvIMpPG2xOI44f9YC6NWtODPDpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBX/zUEGIfp1cMpGpR1kLgz1+vaj7NHYeR0E/zF478o=;
 b=rcYFjAyartIrnG5aXYlmTSMGhYiRLDyiX+kbEdU/6TYa7HHvF9Jk8hLnDlpUsBmZGFiFeJ/kikMDD61bvlJ3uaQWPnNdn7mlRCz3LaJOWOVSgDrB5n8IymsX4vIHuUA6uxoWFPyuNdDs4xquQiDQIUKojKZDioAAwJLYj6ODdoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9930.eurprd04.prod.outlook.com (2603:10a6:800:1e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 15:08:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 15:08:47 +0000
Date: Tue, 28 May 2024 11:08:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, ping.bai@nxp.com, ye.li@nxp.com,
	peng.fan@nxp.com, aisheng.dong@nxp.com, tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com, gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com, joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com, Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de, m.othacehe@gmail.com, bhelgaas@google.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: clock: Add i.MX91 clock definition
Message-ID: <ZlXzcg5+iqevhp/g@lizhi-Precision-Tower-5810>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
 <20240527235158.1037971-3-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527235158.1037971-3-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: ade96520-85ac-4433-850c-08dc7f2812ed
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?X/Hej0JLm4O2bpbx5OzoS8hxUMAivy0QtuTZWmJ9z6hbkyVGhNY8BcYapTvn?=
 =?us-ascii?Q?LLfVjM/DT9EZ2rPbEBO06+pSs38Q6qiUCmCU9uvd59z0QfwdRrxy9ta/LQcN?=
 =?us-ascii?Q?i3wXXz7J1fZMNJIBFsojKfVZSElOrqJT/Hqmdy8uOB8Et5x9QhuT63c4duhd?=
 =?us-ascii?Q?7rq6bgg7lv1QQeCJ71xV9ggP7NxiquGlbjnWQvuSWnYKRrfcSfVXZmeJ68VJ?=
 =?us-ascii?Q?1Dhh6EBbm5zGuM63JT/c2/D9za+XjH5FxTPXdHABpHY46kwpj7G2HEG/LA5J?=
 =?us-ascii?Q?3z+vEKORBK1B849tChcAG6TVyURquM4QYEvbIu9bBG8OVguRjFxL5JWuGk5r?=
 =?us-ascii?Q?TVq6IMlzGMxE7weBsNhQLyudyeeiW7M8HlH8W75buyNvSxT8ncjG7W4DFX+C?=
 =?us-ascii?Q?Ph4nzxFuIqtYlfrbYnq3F+BYou724moo1nEeAOzAV3dZ6qUcBvQ8pL5GYUuG?=
 =?us-ascii?Q?Q4L4wUT1WIBSrEse69vj4mKUR/1IHsr1r2zlKT7HSGD1eWRjdRc68w4MOVYv?=
 =?us-ascii?Q?oeDTWz8gLCmPF6867svAWA0HaTU60CpcOUfB07jFkLd8LToGaI3oKYXVeuq8?=
 =?us-ascii?Q?mo0Drsp5EzWxhjlzwwn4/AVUdA4ZSEzp90caJmPaGbXdF81DxJhJ8gOajJm2?=
 =?us-ascii?Q?OtDHv8DFCvmR0qbp48eJo6K7BMZnXFtHO67aVvoNFoCUhT4ht3GVzqwcwwko?=
 =?us-ascii?Q?OGN61Kr3pRDPd4QOt6/OzIcdz086sU9hQiiwk+JwiEU90Ugl7cEjBSO2roWe?=
 =?us-ascii?Q?q2iy6MK0CN2sq9BAaQsXpH7gq1hcLfpHxyW4Avm3tKhRnda8iISRoLI04aNH?=
 =?us-ascii?Q?GjWESoZAwk0lo7WSpaaxlclJ1pUQERhhgubHqbKtXQ4sfVa+R7evPL5jcToD?=
 =?us-ascii?Q?tU3gtAvsDwFAX22wfDCk/mSVD6C5vzyGc+IWhgZKOXDg92bs+96fNXocsDiR?=
 =?us-ascii?Q?JDOUhBN8bnIG1YamoF+PkK0g5G4ecgnZcue/DPXEYBHawZAv45Yk2KG8zLu7?=
 =?us-ascii?Q?mEvje0DvAQMlgHnl9z3B4JDDZOSR7EgaIebTWspC/wGFIG3c+/2W1zOXOyas?=
 =?us-ascii?Q?GEwN8kw6WfbqpS0jRIvzbBjW1lx3ZSdGc/PV3SJojbJCMKWMF3Wrx9B6aVHS?=
 =?us-ascii?Q?2DDi4uqs9o+tEfIB9Q0E+Pn63dIvmW05zPZ+G7aG+oYFKox9obQ+19Db4z0N?=
 =?us-ascii?Q?HYdbJIYVZkdu9PB67QqiItDBTG8Ps2VpCc3eSzW8ZSE7xMhsCxZWhve4Etdz?=
 =?us-ascii?Q?jpM5kUYU5rdVUvTu8NgY7AP+p7iB7Kkak7RManDjCIhpQvOxdc6BbMzmbhWl?=
 =?us-ascii?Q?W/uY3dIq6caUmkg5CNe861jtVq9CXtIW239BH+RGUAISZA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?zVX8xFpLMQzpENZPvhFnRoQveV3xrO7pxMkx+qCP+eOlAS53l1EefyqIOEih?=
 =?us-ascii?Q?U/J3qsXSlQ49utQNwUX7gDbMe+gPmPsAGAN1RQgHFY2RANPOiQUl6IsqHBpE?=
 =?us-ascii?Q?jRSqHjsZsz8EaXoDiL0KkZsNkBbhwMpIOkPbqcZk6l8VbORRpHAk7zr6B7GH?=
 =?us-ascii?Q?1QB0UOY9fvI3d/6G5BjqkhXkLxohkzkljCJB+KLapo8GZmUimnFM1iFQnK7v?=
 =?us-ascii?Q?8F1FMr07tE8Rhw1nCNkJ9vpYGcMb3f8Vtqd68RkwvcGZDG82yDFirSefQKmx?=
 =?us-ascii?Q?THT6omLXBpogJ/iw1YOk8lApTo3shIQCo60s/29DhrNIioCTkGI4awxndiLU?=
 =?us-ascii?Q?wFSZqE9iKZ4KeSPS+iufcfp/zLeC93N8pQBHGdQc0NAASUJWy/c6BP0V+FsN?=
 =?us-ascii?Q?jOh3TTKBYm7ukJWgIMruLCN5vxEHxuy7BTUfXmEBwosWLG9ZxveWCwbIa4bY?=
 =?us-ascii?Q?hKtWI5m3rBZOIB3VkID7pTPH7stWwfwNF7HBNbvvypUtwy7zT6QpzcXmTrIk?=
 =?us-ascii?Q?JLEiyTh6jXuPNMPRTbPrY6V9lBGtw0H+yJb5y5Rl4pQpQq+SwyurWdKFQrGr?=
 =?us-ascii?Q?IK0AsnVWUu1UjxpEVJEymuBaoNfIDU9UiUh/UhFqP5pLMkHO6N8Be5RMQIka?=
 =?us-ascii?Q?gkgWmovHN14SDrviA+akSUY1EJlgxGoFbdJVAslY9mpisRGnWezEgNlYajDa?=
 =?us-ascii?Q?24MimqwaM0y1wxgx9y/Otlp2v0VKonhTI+evzyL8uprE4IvVUbeAu1Hrg/wb?=
 =?us-ascii?Q?gTq/kQWXON1Mx8WlsLZjp23w/dLwjNtKgDV8alAvWPm3adEHQDVv5EhICtSf?=
 =?us-ascii?Q?xhjZFbpZGFdBGv1c20LO2CJ+DAs6hqdt5ZipV+4mlNtxzDD42Y5WUgQ15Zdj?=
 =?us-ascii?Q?zdbek3/coH2LCN4hn4HXmzUl2qZCqgg8n22zx+wGX7rA17/ZqyvdZ850nAmv?=
 =?us-ascii?Q?v5nGTl8d51ZjsDW8SpA/sqDaJjQ9rbe0qcC28jCbw6iStmzLlPEbDB7L1JW9?=
 =?us-ascii?Q?3VF2X50icEDjdhvCMT9YuPrVN7GU22KbbUTt8gUsRhL0kmC0qJyuPRGNileS?=
 =?us-ascii?Q?4GhQGk/uIw1GMRLkdE/oWFHBvwlXZAtCwORqbaT0V7ZPdWMJpY91iyojcy+P?=
 =?us-ascii?Q?6PbKEe65CUbom041ryFb5dmog33M4tCsR5Yer3RMfd0egA8OPAOR+1TQJSBu?=
 =?us-ascii?Q?+LhxVymPdCNcFJtkQybeR3nOPoXg+bXNuMbQ3gdflVPzH7Z7u+o/cOepGra0?=
 =?us-ascii?Q?mVbABInkNSwybsIPJY32Sle5adzvkYHdN2OP43C+3oMewalr3mk3sIGbTSj9?=
 =?us-ascii?Q?sHv2CK4ARzWHqLbRG9RQeeEC88ouj4dMbTAzLZdlMW9U+QTcFCn5R5tqFURP?=
 =?us-ascii?Q?ntqGU/PaPUCT5DQqPNK8XrirbkpgKwkmmhULroX67gINanC3iKoHzx7M+0Z4?=
 =?us-ascii?Q?P53Mowrsjxgxaf3e9MkMkKVINSEU8uV+c/24aTUe6fQ8nCbVhsDHADG6SWs9?=
 =?us-ascii?Q?hWhOPmPo0L0BlqDDRoCWgxXvuhnE+1jlmdb7ROKgl7JhIFsLy3NfHInR/xsZ?=
 =?us-ascii?Q?fkSZCqgqNYzssJPMKGo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade96520-85ac-4433-850c-08dc7f2812ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:08:47.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2FA33QO+KG1uUKts2R0fUuIPJXm5SzzqwUslVTCQtqh87RJApz/8lKgw+4UwzmmHMoCFdqnQwRQNea8n/iT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9930

On Mon, May 27, 2024 at 04:51:55PM -0700, Pengfei Li wrote:
> i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
> Add i.MX91 related clock definition.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  include/dt-bindings/clock/imx93-clock.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 787c9e74dc96..ca0785f35a46 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -204,6 +204,11 @@
>  #define IMX93_CLK_A55_SEL		199
>  #define IMX93_CLK_A55_CORE		200
>  #define IMX93_CLK_PDM_IPG		201
> -#define IMX93_CLK_END			202
> +#define IMX91_CLK_ENET1_QOS_TSN     202
> +#define IMX91_CLK_ENET_TIMER        203
> +#define IMX91_CLK_ENET2_REGULAR     204
> +#define IMX91_CLK_ENET2_REGULAR_GATE		205
> +#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
> +#define IMX93_CLK_END			207
>  
>  #endif
> -- 
> 2.34.1
> 

