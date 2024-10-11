Return-Path: <linux-kernel+bounces-361445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ABC99A850
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8501F23C58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F51197A68;
	Fri, 11 Oct 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OnfqOQve"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49038194A74;
	Fri, 11 Oct 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661875; cv=fail; b=TgElRZfDJS0BEVxzlAqs38kDgGWmIPtFBpNtlRQFJ9LTsr3zcd508VUmRbhBSNAFPL6OuyZyI6RtddlOf0B5cEZbQ+BzMLeRgTrpK2fIRR6tBFkPGCqlEBfEE3FYM8JIILBCX7mHxsm2B7YVD4Uykc/eOC1BV9+UzpA3bif+7Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661875; c=relaxed/simple;
	bh=r4Kx4tYuhHHBThgPYC7itUQM4AKNqHA3vveH4qytVV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mx/Fqrv/xXcljJ2wLBweo2rGdEwDMdibfRYTIREKlV4jyUrkXqusSIVachk1GAM1A1mgOeAHPJi+TaDR6AV+A0soBeWudMftpGhRvr0jyCRtu/OcG9uvqODfiACe6eRm43s9zx+MwwUtClX1LBQYI4GWUO3jlPrOwc2rIRyhfCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OnfqOQve; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5+1b98//E1FwIS9Ht2rVUWUUZiplNCJsNs24p7GlVg4UBa72yjoB3HXei8elIxSD2u20cuHvbhDrUVQt3M3/cp79t91fNjj6umU/DmE/1S0pV118rCmTLkmSGAAX0bCv448VVneJSkKWHCTX+glRfChvHdNdlDMmgR4GKxDqfRqycyr4M2Z9WP8+RK+GFpL50nMjTvvFcDsMOU1+qIJOvVKqllf7CuihVcMhuL9Evbrzbwa0X0vtiWgMHIqJ+/Q5FUn7oOZ0XmqRMZYUx1qh8n8zew6MdzhNJj17u/PVFKqKNZIqZ8PW1qdIpdjpxFkCiVJOjlL1e/omzlCBgGvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cB6Kh4N+r6ZsCVIBZN5Vd4TSorm6vsd9bN244AmeT8=;
 b=rGPu+BGaH5QB1JCiEA5sgwtNaFAzwwHowTyF7/VdTN11uO2Q273dsG/pSLVxHu47ZYWmEb/gqGyZoqxvgueJMwQt+HvLUzbo/RjA52SYJ6VkqswjIlgKN+nr3C7AXseyXhyRHn7VyHfka17k4LjsAEq/8nqzB+M4Deu6x2ZUtNw3Ay6P8evQwknY4yXy+VcnZeK777FjEhrA/F+BTW9qrqfO8u7ItX3SOAWR2YOopEH9rM0XbJ+NeOdefWroXPlzDF2sNJniAItSSYIPl15KdfhbvbBoZBvbmUtuYuF3vONecPeSfJkesQ8F6wWvtv8NvEyLkgH9tkgrNjPrO+g3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cB6Kh4N+r6ZsCVIBZN5Vd4TSorm6vsd9bN244AmeT8=;
 b=OnfqOQve15vrb/9k8zAl5MQEbyffQQG1WT9mqbwF6W6HW5vOEidMTCEOzfSfQ4q5DNsOLDXa108j06joO7O5N6gOwCPuolwOBdbbauNrXmXNazUBnr3u1Aj5r3Y4cVFwFlcK7BK9DNxXgyPhOaU83B8BwCGooA2nHfz9TKyXDej4d6A2QHo7g9OroXTm3q5si9QOwAWVSe9b6ULJQX0lMTec/kfDDtsw5jFFg7S3t0utXVhHGgW+JndoajLYtl8jCC6DL4eCHPIKFH8AA2vDndYttMGDCbimUg7xbS/DCrO0lHjs5XVYOLT8h9E8OcY+77CnsSvjlgSS/5hHIPcnEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7434.eurprd04.prod.outlook.com (2603:10a6:102:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:51:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:51:09 +0000
Date: Fri, 11 Oct 2024 11:51:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/6] arm64: dts: imx8qxp-mek: add dsp rproc-related
 mem regions
Message-ID: <ZwlJZW7z/Oo21ex1@lizhi-Precision-Tower-5810>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
 <20241011150439.4027-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011150439.4027-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: be650dc6-4075-4b2b-af26-08dcea0c868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5JWpkC7X/4PPR8yBHOZDnDt5HBme8okITK4/fiRFVbcMR9gXZt70apI5O7s?=
 =?us-ascii?Q?vU3XuNsVa3H7m8axxa+npSXvwxANnOxrDDgjtyzd6HdSq5GBMfTyXobA1HXO?=
 =?us-ascii?Q?UOdKEJshbshplkwTKTFL2UlZRQQ6RFX3XwZBCOQwJny79r7sK6dkCTOhTqvx?=
 =?us-ascii?Q?XIjzHLqkuhWf8CkxCkCcj8hAVF0GP1fP2/Gb3eFETtt7I97AETLm6krqokUB?=
 =?us-ascii?Q?9I2uilGsgJKfzB3K4xT0SlIeaLeH10/Qt91WWbkfsrbmjXoOZ0sK3H63Rx8J?=
 =?us-ascii?Q?fPkjJccHaKHMbt2AQu5ka6E5q1EsljOmdSwa2D18PmxUK/bdsPfGmV12K/lW?=
 =?us-ascii?Q?XkMb50wuOMmH5YZSN/ydcjBVCrMTcIHmOwCPRKOWv0IDf98D5NCxUcTt0xMu?=
 =?us-ascii?Q?D10Cf7+fWTeK+80Uow4f7KVrviq1xKztUfmAJHKR2rMI6CyyquCWd+XsyqWj?=
 =?us-ascii?Q?Bj8dGQ8JEvTGW0OLQrqKgJF6ztaukP3RuetUURiSNS8z/Mqwf+olUQ5yFz3d?=
 =?us-ascii?Q?jJD4qItPXcH5YrMLUkK1k6/m7m/hcz/YQznBNAEExwZFE1owkQR9OCh0GyZm?=
 =?us-ascii?Q?gVKdW2KZJNv/oUnEZMdHMe45+Ga0vagRZP/4/GFMbBSY1JHtAZHLD4WH+3k4?=
 =?us-ascii?Q?LmMHSjdxhL/ysZSKerhEUjPKD99cNZioKPlYW+TZb14UldPzPB5vbudEVgnw?=
 =?us-ascii?Q?2mkICnpHvJCLaPodS16nF4eCib3ACExG2TU7WhSt65jzRJpOjEi/79ayNPxB?=
 =?us-ascii?Q?/WCknqV66YF0Vbl6Q225cWLvEePWMenC1iYh4wlcPyY+pa03Nf/AVLC4Wi1G?=
 =?us-ascii?Q?582POEYe3g3bPZ9BH1rBQkV0J1Ep5Z/ypPMH0GObpbQNBfmWuavnZSso5koC?=
 =?us-ascii?Q?qsfIBhcH1H/7vvd+DeBfFiKb/7jvE4NrsL5z7iqcKrW1Kvge3MD6gMu2c/Yw?=
 =?us-ascii?Q?yB8AAwWXTI59zDVYRy93mh62/LAaC/LZ10uRUJDtjc1sgMcLwMy5XoE5OG3+?=
 =?us-ascii?Q?v4syxymkTOyQHDnT5ljJmvEfX75oPu8j7/HKAYds6JDTJispywbry4AfrdHV?=
 =?us-ascii?Q?ntgDm6lpWudqv0iuIqnFpsFbPruKuWm0zbfmQ2y5U1AD1J0bjm8GLCg+mXWS?=
 =?us-ascii?Q?KaIzm8IvueGtBIHwrubaPSNjBTEb6OZI2oTEe2f42Oei1rOdW+yIWMkhoGoR?=
 =?us-ascii?Q?RcYuUJ2/nTaDyEYbql1Qu5RV1GzRsBLNPcqOJcGgQAPZRZkrLAODKj2lz7OY?=
 =?us-ascii?Q?D5GNYTt6OIWVPZlMdZji7sGt6gGVf44lS1D+oAZ0jNGEuKf/R93KbVaNOGBp?=
 =?us-ascii?Q?nLeKbFhCiYAPxolLyE+L1Ws35L4ul0ls/SZ/2yHEu/mfYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22nFtNHlwFfGAUREKAcKwWfTcroVV2ZgmuzHzcsJUS/mIlNk1LW+L0i0ZtJ3?=
 =?us-ascii?Q?geXlpmLnhS1GMIjVQ0xQFeM+AXTkem93Pzten5QGZCUiKCdACJUJDJ2jsrxC?=
 =?us-ascii?Q?aBPxs8eIdTqkC9kzYvbKI4VRRXRf7dfPzVgK8bHE28xt8YbbY8PcTHeckPh9?=
 =?us-ascii?Q?ZCaL+RRLelmCGJr04wrSNOswZD3bHKN9XnqdvUUKvJAb5dMoLIH8vE4f9/9b?=
 =?us-ascii?Q?8M+xVJJJaY4tDTOc/Hnw2XvBIb61MI5dqH43UGLd8cCXys/tHEkgMxVJ/RLz?=
 =?us-ascii?Q?P7SQMuQFReATYwBNW6udgMvwePXDeWeFwJlRD00eDnJloDSd5mrVfZi8Rfbq?=
 =?us-ascii?Q?3aoQabWQuqR+8FIgwLHHpz2zH7UJeMYBJ35HZEXP/d50ITclQZteDDYuwbaj?=
 =?us-ascii?Q?DYRK8LDGhSYlvhiz5hxUrd7uwYELhOkEHTYLxqWIWns6aGQN+Hhs9Dp97vmv?=
 =?us-ascii?Q?eK8FnknvvVJPtNVpTKNz9TFUCNO+Ne56GA8emO9H4wciIiPXIbGhlLL6ajjG?=
 =?us-ascii?Q?/whrEfTHtgHYdygl+WFMdhaNX9DhLjqJ+gEHiK6GdDfeayKcdWbLv/sZN93q?=
 =?us-ascii?Q?S6n3xOJ8wU3rhnwJSNSCrenU9rawgv4xZEo+STmWtj7YJSNDVCSuTcsUUoDl?=
 =?us-ascii?Q?/1npjw498f03FkqdQSVv0OpGXV5i9gntfeu9kDKE5lqC6DVp0Q1iuExCU8kN?=
 =?us-ascii?Q?bWUWH2FY9sE2jmIhsln2PTNBX7UwMr64ci5Yde4m4Qbsb0DrjwlOnnrf7vxn?=
 =?us-ascii?Q?V6KopMLjhrv8RfBR31CL8vQHqDmkeKRWnaOvDIfZ1KcHFIi/+1xqbh2sLv6Z?=
 =?us-ascii?Q?oHgrmTWNRUY5/BDZZo19nnK6nm4QV9z9gqxSP1rTqlrt4udUHoxGj8v86C7v?=
 =?us-ascii?Q?lH06pLoB7i5cQ9/cBNsZuzEWwQFKYaTH58bjLWYf5rIK6TZzbPlVA9YwqhZg?=
 =?us-ascii?Q?OWgZR5ypqsfZYkohIIhgQc/TOmiK9jxbVGbeH39G2D2YIW6tCctLMDRqRjFA?=
 =?us-ascii?Q?NWdwTVYkcA1HfxNqB9mRY8V/7TE78+lhiZ6xqXHCazMbA6OmQw1fzOgWUsIE?=
 =?us-ascii?Q?6IST5mH/nXql0y5yf841VV15vc8sGybxp58PzfqqZZdzlbzYxbhvAeYboxsC?=
 =?us-ascii?Q?DQActuehU/i4ue1dqSAlKsWM5x06T8KVF+qJloNMcdidzaWTFoCSBdcJ0g5G?=
 =?us-ascii?Q?dZRZ82wyPOg6u4FFYdkwKRa0G5LK+R4Mx+MkciufnswajrUPv3OGcjVEdmKw?=
 =?us-ascii?Q?21JAViX2uKWQVIXJxE8HtTjg3U8y2d0akI4iw3X7XcWiw010GeFQgvdItVm2?=
 =?us-ascii?Q?KWQbNkmdaqKe15oAsBJ+XnnqFvyizUUEMpiJd3ElcIf6Wnn0Q6tsduPTN3gV?=
 =?us-ascii?Q?XODIu6ajyUd8Tj40PWDeh0Z+GyZPZi+TP9OF9ekvFi/EFEE1L/vU8/+cgW5P?=
 =?us-ascii?Q?RJUopj0AFAadsf6XrVNPGZv6quiwz3rsf+KNLkc0eLTiLD88qZ3HHMNPLc7T?=
 =?us-ascii?Q?JY6CY9p+WEgNi0hlweP+ii2P8irAQMQYm9Sk2wNhxpJltQoOTRh8eYvEiRVo?=
 =?us-ascii?Q?ivGaz1s7sx8RZz94KnY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be650dc6-4075-4b2b-af26-08dcea0c868c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:51:09.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7muc4EyU2a1YzP4gBH5eW21IAtNZGiISfeAsUKHHXb/dhk1t+xsxki+L4nb3+cWXMzMzqlTdRjso9LTObJqHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7434

On Fri, Oct 11, 2024 at 11:04:36AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add missing dsp rproc-related reserved memory regions and
> assign them to the 'dsp' node.

Nit: wrap at 75 char

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 936ba5ecdcac..4c4e71d39bac 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -21,6 +21,24 @@ memory@80000000 {
>  		reg = <0x00000000 0x80000000 0 0x40000000>;
>  	};
>
> +	reserved-memory {
> +		dsp_vdev0vring0: memory@942f0000 {
> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0vring1: memory@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +		};
> +
> +		dsp_vdev0buffer: memory@94300000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x94300000 0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
>  	reg_usdhc2_vmmc: usdhc2-vmmc {
>  		compatible = "regulator-fixed";
>  		regulator-name = "SD1_SPWR";
> @@ -63,7 +81,8 @@ sound-wm8960 {
>  };
>
>  &dsp {
> -	memory-region = <&dsp_reserved>;
> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
>  	status = "okay";
>  };
>
> --
> 2.34.1
>

