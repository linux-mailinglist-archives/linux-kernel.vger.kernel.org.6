Return-Path: <linux-kernel+bounces-408253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7219C7C98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3701F26EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C5206071;
	Wed, 13 Nov 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsUt1wRp"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF62180021;
	Wed, 13 Nov 2024 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528464; cv=fail; b=hX78TFBTUUmwm7kCAWo0cBO0Ou011YmbzW1ExT/JGd8ADa4aregtBeUrz8CfMkl01P+F6wHrZk8JKkSZ/L2ngiRGRjisk/mEBMhgDne5g8zMKoLYfU2saBC9BqLTOFk7AnWIhFP/4TPJS3K9Zp5XoKFe8XK4Q6lsONx5jzF9gd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528464; c=relaxed/simple;
	bh=r3LAsWjEVR71dJQuS3DcC4cUAJEQlbub1liVRjyA5tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FlgzM9JElkfT9M5ricw/xuVTb0O9uP+zvW99tPmrrBCPAhZYaSgf3hlWsfMu3M5QvwA3JW+ntuJnzCT5xmVaU0aUiLNk/y2nm/ECWLDoZmRz0A1hUMHDoFWBwPNUzrpV/7NeMkHmZotfM9i1iL0UhMgh+f0oH5Elit0uhZCxMLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LsUt1wRp; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCtNNxSpjvhYQv/PcSkoS+/mUXKwrZswg+v4s46Q/6RoasW1F2GxYEKMWH8eKg9T/jDPUl201mwzrpINOd2DQpEAI4D3JqS8Xt9+uW5c8bic0ZEGQrOfy5DHW3i/gTO/h3XPgiiOwe2xPll8g97tS1MS0jRqV3ZIxrYzGluscbCKRu4JvKOV6+XnXkVOAktYJKaW4/Ky8a0Htqce/u3NlHdS8xF/B0egPLXqEvoxjAKAN7oLViFe8tgaQJaUCxb03RBUAxE9HfBL/1yLucERxeeCVgB5F0uewXK25uh2ni1p38ny9LACoqksDeNOSssQEYoN6UW+JVMqexODMhSNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFGVVbQJ/KzwMrJEtPOvCEX2Ha91+GArHatd1czLf+0=;
 b=eQb/j5LmN5h0nog+uKxedZmAQ/yGvkOLVIqlmrVouVUFYW19M940eCw4tK/jv4ROaXt8Sj7II8w9LWcj078mK1hjPLNtJLwKagN2NA/t1JEGwIXMltMZE0nx2dwTDcItRlFbKHuWTVVcjoVxcYJ9kxNZKnLV+iN2op17+EHtkhNzbBt4hua24LMZkLO9gXZP6l88CNvoqKafoUJO5dLDy/YEIXsdCgv2ayorG/0lmmpVah7GrkEgV7EV+UqoqToXapOXsg9oQkyoeR8HgcygoB207YnmuM20iN18HfEbsIzIRpwcTAtUKLY79EKNulO1BLKgJTa6yR2NHklthfrmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFGVVbQJ/KzwMrJEtPOvCEX2Ha91+GArHatd1czLf+0=;
 b=LsUt1wRprmodvne09XWNyw1TMOEQHUvcvuD8N5touq9uUgxnYJ+qSCAhv3kDFifJ/Nn7KF5UHk+DIQOh1lzZCVK7JZ45z+L+l9lv1Da1iOZKfO10NvF1Rb6JGjNWtbdrex7VDPRBn2SkdTL+fvL6OGyEim/8DmLj7QoUpwn+3TVwGaSoXskrjD00QyBm6e7hBquK/vGhpqgXogHyrTRN/MkEJrqEGq3L8jm3VOudcgVRtAJaw9bNgJRfz27861FJ9crEmfcqpzDBnx/NcV1cBvSEyg+Xc5pVrknJhYauqZqljDwnwmJAYlvIrws51PBYiVtOHOfO5QKf8prMvZKpPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7735.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 20:07:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 20:07:39 +0000
Date: Wed, 13 Nov 2024 15:07:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: add binding for imx95's CM7
 core
Message-ID: <ZzUHAhicZvMb1JAf@lizhi-Precision-Tower-5810>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113195240.3699-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BYAPR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1877c5-d26f-4e21-3e6f-08dd041ed2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ec5IZ+SMhI5BWkvfbA8Ic2a2TO/5O1e7SB7KZrqVAXmA06PeFvmp6ncM84hN?=
 =?us-ascii?Q?89mHmdtBotEXtfI0QBAogFYT4fy8MLBpXi3xyjEhZCZfVYYt/ZyF7uRtxAWA?=
 =?us-ascii?Q?bj781Dh1N0qz33Gk7v2F7pJi7lS8E51A3J7sH5weLQFN4GiIfHYqrmHJzBxh?=
 =?us-ascii?Q?SN5+ttO8NqLxQF+R/G+ROpaLZ2sIMDpEjwI9lfXwmiHj7jkCQAL5E9vIP6aA?=
 =?us-ascii?Q?94T5G3ZAbnIzPTpKrcHw6Kfu8fOySbp+L5N2iwpLLvm0iNrh2uLWD6rklHj0?=
 =?us-ascii?Q?ZoxsK5REnwA/60o9J4ymwrDlRDCpjnUNEpDcEwZ0rSCaH1v+/2mlMW34iBHD?=
 =?us-ascii?Q?6Rv6jNdHFOS9Q4uWmUNUtFZomE9QopB+FQaYAI5Cyz9QdCX00aDekCh3Lyzp?=
 =?us-ascii?Q?r545QcHRQcfWWPo3rBduR3rb70Mx0YdLTjv4MeZO11v5cmyN4f/qIh99WpXD?=
 =?us-ascii?Q?Gva70r8gzNtu3p12PQ1ouqWRmkEEwSaNj9dcAzRRJSS4JI6c8soJKc0c5PLT?=
 =?us-ascii?Q?XbVHCQdKQ/ZiPHWRfGRHSsxc4LKix7voLo8fNcrvK3GeZo01ltkbBnaNgayC?=
 =?us-ascii?Q?2kn8lOaqlfH+JWJDU/vRV4RQWZD1N7meNIte36kAAyu3TByh5tGli/9g5oJv?=
 =?us-ascii?Q?V05DvflD8PPl22/Pmk5jCFpfMcpoAUh8MZtca2hJwGQFGLVxJmdnILHIg3s1?=
 =?us-ascii?Q?+erthGIUgBdntH75QKViWIIWM3TzSORMJST2Z72I2f8isFEJv1dZX5OKu8H1?=
 =?us-ascii?Q?lK0yTEmlIkHhEsCVrjEIijcDlvMXha4YXWuiXPYGIszpH6V89vTH1bqOhZjv?=
 =?us-ascii?Q?HRbeFv6T3C/Ix3S0k8cueADjGGi6FrJw5hdSGNV4jSZJwn0borFEJs/y7mKx?=
 =?us-ascii?Q?SLN5aSuxWxx/jy6haOuHAAdV2k5tnXDm8MTAMfCK4EQz+WxdagA3bvIH9t+Y?=
 =?us-ascii?Q?kAB3E9FyF9K+MEjt61ixS7Jo7X6ajiwn9niw2C3sjQ74kQ5fi3wqKzqQWoKD?=
 =?us-ascii?Q?lrITXUoH9eFRwidzO9OqavMnW3ASrc7vwtyeTzdYE/17qOqsYaPPhzmQ41rB?=
 =?us-ascii?Q?GnhwoFtnjY1kUHZ6HeasghSmwNDTCxpPBX7PSctGVXTFwFZKr1anu1K/Cl+b?=
 =?us-ascii?Q?8Yx5ykWo61mjJIj9HaPrkQgto+R+JS74BXZFEgmksZFNcpi/Yi/15WR9xO2k?=
 =?us-ascii?Q?VQrbbGSnZ34xRHu0aABoFJ8C972WzfDHNGVw5ii9L9UpGGSu98G1S6WUFuFU?=
 =?us-ascii?Q?tm2jd00G7IsgFCwi10jFJhUU6eWRAnG3SKEkGZ8fPAK1EtjaNEyhvLcmi12r?=
 =?us-ascii?Q?Lurd+Lai71JQB+tdTWXF1EPA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Up/fN7HdsDqkdZN8czOFzctv+R25RBxlV0Zh1rw4FyNuw8fSTQ4MBkKqZRUb?=
 =?us-ascii?Q?OoXj+KG+d90ULainWZmy4UY5WG5IFuOEx4G1H+6RXVi9Iz3HnUBEhmeYn/Pz?=
 =?us-ascii?Q?INp1oDAD2R2rDolivEEmnrvnqKqpRHR1Zgos0wqr985xPBZNkqMSHE7ajief?=
 =?us-ascii?Q?U7gzJ31m9nZ3JzahPV8guBsFD1fNQVOrztjR7awx8y361tapaKqq5u9dTveX?=
 =?us-ascii?Q?JFEasZwV8iNOzSnV542Eek+jLB3w+btfqjbGenIRFYCC2Dju1y9qb+hTDKa6?=
 =?us-ascii?Q?M28yu9wagmHk7BQmAoYCwZIWBn5qltgH633ryuQgZl/U/zOxHV29j+h8KAKN?=
 =?us-ascii?Q?c5pQoxZUcDgvwP/HcsruMgxdnBcadsRrREZ9GwKu19YGyAFqqrf4lHQ9Z86r?=
 =?us-ascii?Q?nareR7uSDMTt+Ztyh1IpfHRy7QXfGLM/pdf5vzp0MRLRmp9wFkfbCFy1UykE?=
 =?us-ascii?Q?jto012ctqpYnMSRXlSmxTAkZwrBF7dxoriSJF/JXHihLDboNijAAS9hh5yEo?=
 =?us-ascii?Q?cmVbDuKgCuATkyt80juZl7DOlVU+v+liQ2Wa14fx9UgfEm8gJ+hqLtHsYEfb?=
 =?us-ascii?Q?1s1vVljzOHipH+VGi9J1Z7FJpp13f67zCu4Q7eRa7cmmAmZCD42DsAnf58+8?=
 =?us-ascii?Q?3rJKfs/dDlQ86xvx2UBSc1Mm6Q3isnjClVkNkS2yTrdcoowkDurgvUAb1KHg?=
 =?us-ascii?Q?sc8ERB3IdJkWSv0yzxwSco2uLzXY1b0L+1rsdOdBeZvwHoneE3+U1t582TXq?=
 =?us-ascii?Q?0mWrphdRKyRYjwA32rnRTIq0j2Vn2byQOAVPFVL5THeAP1OUhmoO2gm57ssU?=
 =?us-ascii?Q?3YtkyOo7wbOZZBE5hwjlsuu1GW58JUHwZi5KNP250m/ubw3q6BwOs1Yklnxd?=
 =?us-ascii?Q?ij0P6es79rZuN0Gghdhl5s4ghJHu1GfatHz0krXixbuoB6gCYlPt95zRrkUm?=
 =?us-ascii?Q?OmLo30AmbN3U9YNKR5j+aWWNp7dNLCoMWlgJDXFibA32dGUQooWEwZEEx4+W?=
 =?us-ascii?Q?V86mQPkJAXXoWiAlILY8BedIPrtQtbdAKgNbAmTAjTWsu5Bk70/9pnGtjajz?=
 =?us-ascii?Q?4YNY1flgzOV9VLCth8WA1xdQEnN/f8yrA6ws+F38iLi5/mB++VW0TipQA5B3?=
 =?us-ascii?Q?Hd0zaPzVW3t8nMKhCcaXzTdTmwOQq3g0BcYIn6DRDVlQ2sQhWgrRI3l55VtM?=
 =?us-ascii?Q?qX8IQ50kLmjzes4tUoL48I/VzuWMEhQLajFXN6de5d2U5U4iY3qzYdJi/A9X?=
 =?us-ascii?Q?evmNrcxVgIJvu4TSlqwPFmR2insNBqw9mIHMfD4xTTnx4dnQDT4Ih0swJQxb?=
 =?us-ascii?Q?J/QQc0ktZFEatqLQb0tMonMoJ6RjvKm8+6GbUn4+lSfVTGW3zr4srfWQwRul?=
 =?us-ascii?Q?s1mgM8hHTWJsAkdc+akljeArNpO1JtzlbkK/EMbWtXm6ePIo/JhX5hGtdS+N?=
 =?us-ascii?Q?MK53vmYuUIUhmfq/dgo2/jrRv92z3DigBn8pgY8HYeKvhJPulCuS1Rqyc9ed?=
 =?us-ascii?Q?m8qhBJRvsN6po0bexwLoUeNkQY0vE/pWkGrE3dp5InSOHxizorLvxhpLUhxs?=
 =?us-ascii?Q?Yl63gqic7Qi5gpT0arY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1877c5-d26f-4e21-3e6f-08dd041ed2c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:07:38.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97eCBF81Wm14EDGJBS0E1XJKYsHx2wF3RTyt8TDVB94uH3I5dp8xiGSeadsyGS5lQXJ+LzUt7vxg4VoChOUJwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7735

title needn't 'binding'.

Add imx95's CM7 core, which used for audio processing.

On Wed, Nov 13, 2024 at 02:52:37PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add binding for imx95's CM7 core.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/sound/fsl,imx95-cm7-sof.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
> new file mode 100644
> index 000000000000..f11e03bbcaba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx95-cm7-sof.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,imx95-cm7-sof.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP imx95 CM7 core
> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +description: NXP imx95 CM7 core used for audio processing
> +
> +allOf:
> +  - $ref: fsl,sof-cpu.yaml#
> +
> +properties:
> +  compatible:
> +    const: fsl,imx95-cm7-sof
> +
> +  port:
> +    description: SAI3 port
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    cm7-cpu@80000000 {
> +      compatible = "fsl,imx95-cm7-sof";

example dts align to 4 chars

> +      reg = <0x80000000 0x6100000>;
> +      mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
> +      mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> +      memory-region = <&adma_res>;
> +      cpu: port {
> +        /* SAI3-WM8962 link */
> +        cpu_ep: endpoint { remote-endpoint = <&wm8962_ep>; };
> +      };

needn't label cpu and cpu_ep here.

> +    };
> --
> 2.34.1
>

