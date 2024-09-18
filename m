Return-Path: <linux-kernel+bounces-332883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7E397C044
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A606D1F22308
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E41CA685;
	Wed, 18 Sep 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fSQEfHRW"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA042AAB;
	Wed, 18 Sep 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686159; cv=fail; b=cGknYlDcJ8MwVTvy659Tmzvatr4JLa4/8oIfqFaBvMkN9n8ZW5nYJD59Wve8F1A3AQW4euSGjChNsjrWIbnJ6evK9aQEvrL2l55Zgp5m/cYCG66IDGNkXPDbymteTQCwH9t5Osv/rA/hn719ulmn2+8Pyqe3MjbJkJIzame+uT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686159; c=relaxed/simple;
	bh=R1OUl5tZHPq/vE//OYVHkyuZe8vbgqYIflzGTE3LUeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MQykn3FdOqDCcrtDSgLzIThJtWrzSuzFkKCWlRtrRSBCCNN+O2R9q9nwzA/8oHdRPH3RCbU3QWoidmdaZnLiAqYG+QuKno0/4mMw0CE7+wcZ3F6fIZOVcm8N+shqy/sZjEYrf8IDQzNZD8D3sXx11Xzd2h/8V+6a+AW2fVRL34Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fSQEfHRW; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYF4n6YQn2gj+1xfP3PSRgx/uF0tEUMXRdcQnPCrAn0VqVMDSMljGPMJYg3tAAB1OWiow2SeMUSiGJzvAaC0HZf+NssG3jCy7RnUX7iHDvaDq4C+iRhSGe3UjPuAkmgcA6aXGNRftxIFnMQWkpUkbRljgGacbl86sE+T0XFFPuvkFEzYZthE78ybO4LKpPUWlTmXnH88gx5m8nFhKbVG9epS9euW5C5f24kAmr3vgeN+6iJ1T8vH4JKtmoxWLQmxVTC4VxNb6rbbjpRp2tTk8KUI92cK90ZAN5XFI3n1fHVZtB8+ihbDNQyEynUGbj+9RfdaUeQS8QMt6LQygFhTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/I8sPpMutvtp0P0fEZ01xx+eAUM1vUCJcynBf0w4xs=;
 b=Ft3uOUJynjwpDTWLxcb9n8Kj26lWmoAzYN7V5UA27RATUyIQF8Jw36U4HYJ3zOqH4unyOQYkSIMyrErGNf5MEt7geqWSLj/dKcpW59ojTDiiwg7B6KkaJLen4276b9MPxrg4dCwS7ezJe2cl5qCU0Dsv4L+DJ7GfkB32jO52CV8/ntRuoFW4fWci1r+3jJooF+sreC4iZlp0MXwpztpcFSDEfvCEw4uezq0mKbLM41FOvoIBVIgZOQjW9YxzK4UJQIO3Hd1OWVam6Lno5koTBcemFWQensehckYxlaBQhJtF17+rxnsXBD3G0WYzPKftqZl6jTyjpimoE+kf8G27lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/I8sPpMutvtp0P0fEZ01xx+eAUM1vUCJcynBf0w4xs=;
 b=fSQEfHRWiB5aSlDftOyYW6QycD53I/IpjrlPKqtMvsl2T6pZ6y99FsaiNnIERXw8wYDWfvu7q1oLdtL5pVbWyUM2DKDs+TljEdI+owA6gyZKJBbFCMXQVqY5FTH6WhlZZs91rTHx3Ji4O199c3pu2DtKqpw409g+iR8u0R6DEu2/VWR9Vzijk9fN/dLl/u62hIQ7CgWAXiwCQRMdNdLu/O/mGUz/VFJ5kPs1EP48DIb+BIZ4grAgxlkQiJkbNL8+R6KHFyrvkHRycsboaMj2ECzHlTFBdPQE+DPZjkN8SYxO6Y/0M4gBGMoKJLMG8uttA9rWT+td99xIdb4ccRxJUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10549.eurprd04.prod.outlook.com (2603:10a6:10:58d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 19:02:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 19:02:34 +0000
Date: Wed, 18 Sep 2024 15:02:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: imx8qxp: configure dsp node for rproc
 usage
Message-ID: <ZusjwTdf90J3BMH/@lizhi-Precision-Tower-5810>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918182117.86221-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10549:EE_
X-MS-Office365-Filtering-Correlation-Id: bda29f58-491c-4415-f5c6-08dcd814744d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?34uTEJnFwrEWkcHnqnjicW4fGs9ZjKgSX6/LRufZlAo54GR4VaMf6fjdAh96?=
 =?us-ascii?Q?GfTh5h3AuvyfYovo++BqRb04WJgtckMKlO3SJTu18KlRnMFABOhk3Va8afux?=
 =?us-ascii?Q?08hlPyXCRq6qpuVvs22lLf8/yb9HhzCUChJvdnkzl0rDbiSv1ltoyGOgBwlh?=
 =?us-ascii?Q?fUp/ScmqmjQrwHyFG4JiBGvxJP1AeOo/Q91ap/ytcDchG77BL12gd+t6yIfb?=
 =?us-ascii?Q?G9jJOuBidRk/NA8+NNPxGCPAm4U5TVfp1qYMG1WFWRlrhWbDw94xDaTfiDKe?=
 =?us-ascii?Q?Iph0rpxwl3Q0ItB9tZpYgNXHRMkj+8NjP7+X4x1/NowvhJ4EQHEZrOB6FXjr?=
 =?us-ascii?Q?6p8UrNBLU7Tygf/ZfO2Wx9JcRmKb1TmbXDWuJmii0CIG50/mx3WY3vWGp5hE?=
 =?us-ascii?Q?6dSenpl5K/CyOoFGAYPSydkXdjYMZa6i9pHR6QWm2GWxwyFUXJIPLW0JDO+J?=
 =?us-ascii?Q?+jbO/MdIusA28dOIC1zOouLMqtYpyrye8Qv0KtHIW2AWKYyT0Ti/M3Nk+PI8?=
 =?us-ascii?Q?hP+4hlq2UBlLFgTqQr8buJHlLJiuIjdKnYHMZz9TQy5V/n6G8l/AAHxhOCDL?=
 =?us-ascii?Q?1xxeOvpOyiO9+pmGDG1+qb5Tb8x8RzebBcrQX/BJ9i81lQsEZqFnjKpMiq8o?=
 =?us-ascii?Q?0FwEc+bkandpf2w9J62TK5QwA/0xC/qSkvFmjUOYD8puWnfpiuKPBhWA8Hsl?=
 =?us-ascii?Q?DReedh1ETlFZo4jYMhl0ftwTADPDQZt+XPTMQ0BaUQnH0hbu7YNX2DP71HFu?=
 =?us-ascii?Q?COeMJY4QcMFkB5e4WiGtTDGrZPtQ9jETX35ZjvZCh8za1LSFMGAmWMMKZcJv?=
 =?us-ascii?Q?J4DKTAEGEetdJlOV/C6Ttzqp7ZzhhJfkUddq2IxCHciQHnYVQ6AU4hKCr31a?=
 =?us-ascii?Q?n0nl+FpaapAsDU7Zk80AxBgpS8Zhxfc+2CuZo+tLyQbjm5PQ3QK1WvZZ9O6U?=
 =?us-ascii?Q?5RFD2PD6vIoI6B1GHSLNiDVsOBdm8kMHhdOo1s+SvFa3V+1jCdzGq+WK+2jH?=
 =?us-ascii?Q?q/WcNNNvs8d0PPxrwy4Y7ODUJ5Y6pc6DyImspIvawhyD1Q5jzB2rn5FeTxvS?=
 =?us-ascii?Q?3BNSE02EQhXJRDNll2duHvU5CmgKjFOUhr/7QRZlUMxwfikHZ2H7151XHEBX?=
 =?us-ascii?Q?4Tg/Q2ntWHcaU8GILdZZf82/g1XXPAvJXcljlvG4gUfSKhln1cD4xmrHyolb?=
 =?us-ascii?Q?7DVco/F2wnDqcGlDX7byvCgxBKO+NPrMPU4kG6ilzlhib+xIoBOzA+Bb4Xft?=
 =?us-ascii?Q?J15w3hJv0nXRC6BuorVDf786cWVf1DcGAglIhdB5YFG2Li4MJ4C/ryfzc2yL?=
 =?us-ascii?Q?rlJnEOaMYa0pnVgofAr+IHPWnpcU9LZK4wqHxeZMSPtY/aSo8bDAPqvyHhbI?=
 =?us-ascii?Q?4qjbUEVsL2+dQ6IfdG9gUHd9Q3gpXcdP3JyM9XHHO9gKvK7BPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SedlUPc3uzt1GmAy2jZG7Ov8iO2lkmjnC3ty/iCl5fmoBgfUlZSnxMUMf+gH?=
 =?us-ascii?Q?BEUvFAQhsZ/dxkbSW9vmYtqyaDsH3NAmdJ67L+YuX66fECXOkPDr5eDwaqzJ?=
 =?us-ascii?Q?IfcgOK6iVf+rCWPBM8PjxkrJ4l52HLNYXou0T0kaHGstIG68aa3Ppwtqsrse?=
 =?us-ascii?Q?hDXg3sEtsewj/PpbeDxUO35keCch23BD5iuP7yZPbGnyS9m3M9kFOhvz+Hkd?=
 =?us-ascii?Q?8AhmMvHTvdWOYH2PIU9ODa8TOhCvc/gy3kSMaYljioinFb4htO5EcfpXyQcu?=
 =?us-ascii?Q?4lpL1E2lf+cVr6k/3d1xn93s2ALuoj/ajDU8Kabcgq1/pkqG6RmkdkfY9yIb?=
 =?us-ascii?Q?Oke9aN6c+Q8pPmsrHJ/R6VtIcpxgeWFz9CRwIqVsfJOhdykxX8ba24zmpLoT?=
 =?us-ascii?Q?Om9jA/ZcK/ASpBv9Bsek+rrFKayPjb2onBdxuguAuCVlA3oNeswQUM4TxlPy?=
 =?us-ascii?Q?c+e+304LXaFbvXMbwAdYFykdCDKlvM5RfQ+IWvUwdiXlgeU0JeWaBO/kaW9c?=
 =?us-ascii?Q?jfUoNFLNUZKwQ2ChBR+aYXLQd2YDXJtO8BgN+SvdjMfHyVieGX6WbpJ6LqKa?=
 =?us-ascii?Q?sSu7ZWZyjysiHCbISWGppjamdhnuIpmUkdZXZ16bE47DmMkpVHgh7IizqHiV?=
 =?us-ascii?Q?DEnbZ4zAGP0D8PEVo/ZyaKfLrtfMZowcf8jx6yQMbnUZUiwlbc2nGXJn+QIY?=
 =?us-ascii?Q?pgeFm39yumrKZtCo2g+JPlzFMzqTWz1sO4264T1Jr/nDr53PCzmD57Q0YJvr?=
 =?us-ascii?Q?kacFdmypIorUen13loZ13NfvdENCwmglAE6y6anLrq05ifneQ8VTe9rI5v62?=
 =?us-ascii?Q?qcit8mFA9jwFHihU1qLdO8JRmdFBGYD2ZX8hQbqStPoIxR/Q9om9W50pugGm?=
 =?us-ascii?Q?gRPOmPiE3tWjo558HJmOdNAk/Iqj8kkoAlw2xHudhQ/hodG4SnFgNZcCHS9U?=
 =?us-ascii?Q?J92o8tMpPr5auE1XAIcuZ8NUN3OSVHt2sSCWupohHZY7ULTLweODbTR3VnPZ?=
 =?us-ascii?Q?COGJHd46cEpiqdXbq8o3fad1sOhYjRzIoQRO42RzKRFg4ek7FXXSVEvc7qnv?=
 =?us-ascii?Q?lzJ4gWHDysEuf/dyRLqCkpdPOTCdNJgLpaqwBdkuTYxT+5hlZoVH3CWtN/tW?=
 =?us-ascii?Q?unnb4tSUVH9ZcYS3atSxX6WluiDhbw96+0uhs3zXqKUXY0BR/2OueS+nsf6p?=
 =?us-ascii?Q?jzZDZyWjflIdhLUbmirldROBQvi1fBGZ32mJfSWbFHk3tT01UtZabc7H191n?=
 =?us-ascii?Q?SIPe/OFBBceI8zaSe7d9PPVruLCoXNp2/hFVkmTInTJ5Nzu0gWuiZPV3JfbG?=
 =?us-ascii?Q?qs+lZJ1lxrDtxVAo1nLyJhBZV4SstE+ssT1t/x0GrlvQlyh8FexqUC9tYIA2?=
 =?us-ascii?Q?gBY9PK0nZAN4Cye/8FScLWNohWP5nVndoKmcD32Y1953pMakrIvy7gXnjxcX?=
 =?us-ascii?Q?fonv9ncf+fsQFFWdI0lprfCpfmhO0EYLNH9g8Wg5Nscs1+j2UIE7f6XM4unq?=
 =?us-ascii?Q?UfPBXefdTv6sYruupDFN1SKQ3py9wDJQcPM3/GICcOLTNlom8HOgxpxPQduy?=
 =?us-ascii?Q?HgYV+4oiMj2IKt1O072aGKgB0Z5G6IseM+JMNc34?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda29f58-491c-4415-f5c6-08dcd814744d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 19:02:34.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9pLphngSdafALr7ErwRTay6Ols9xLrVyGdxZTKRukK1XKOk0C6Py58X5KYkVbVul11X7A5bZLZfsHTAXy8oMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10549

On Wed, Sep 18, 2024 at 02:21:14PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Currently, the dsp node is configured for SOF usage, which
> is not the "default" case and should be done in a separate
> SOF DTS. As such, configure the dsp node for rproc usage,
> which is the "default" case.

why do you think SOF is not "default" case? where sof dts?

Frank

>
> This also includes the addition of the 2 optional
> power domains which may be required by some applications.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../boot/dts/freescale/imx8-ss-audio.dtsi     | 20 +++++++++----------
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 15 +++++++++++++-
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 19 ++++++++++++++++++
>  3 files changed, 42 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> index ff5df0fed9e9..28970211dd67 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> @@ -431,22 +431,20 @@ dsp_ram_lpcg: clock-controller@59590000 {
>  	};
>
>  	dsp: dsp@596e8000 {
> -		compatible = "fsl,imx8qxp-dsp";
> +		compatible = "fsl,imx8qxp-hifi4";
>  		reg = <0x596e8000 0x88000>;
>  		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
>  			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
>  			 <&dsp_lpcg IMX_LPCG_CLK_7>;
>  		clock-names = "ipg", "ocram", "core";
> -		power-domains = <&pd IMX_SC_R_MU_13A>,
> -			<&pd IMX_SC_R_MU_13B>,
> -			<&pd IMX_SC_R_DSP>,
> -			<&pd IMX_SC_R_DSP_RAM>;
> -		mbox-names = "txdb0", "txdb1",
> -			"rxdb0", "rxdb1";
> -		mboxes = <&lsio_mu13 2 0>,
> -			<&lsio_mu13 2 1>,
> -			<&lsio_mu13 3 0>,
> -			<&lsio_mu13 3 1>;
> +		power-domains = <&pd IMX_SC_R_MU_13B>,
> +				<&pd IMX_SC_R_IRQSTR_DSP>,
> +				<&pd IMX_SC_R_MU_2A>;
> +		mbox-names = "tx", "rx", "rxdb";
> +		mboxes = <&lsio_mu13 0 0>,
> +			 <&lsio_mu13 1 0>,
> +			 <&lsio_mu13 3 0>;
> +		firmware-name = "imx/dsp/hifi4.bin";
>  		status = "disabled";
>  	};
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 936ba5ecdcac..527933a3eb5c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -63,7 +63,8 @@ sound-wm8960 {
>  };
>
>  &dsp {
> -	memory-region = <&dsp_reserved>;
> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
>  	status = "okay";
>  };
>
> @@ -71,6 +72,18 @@ &dsp_reserved {
>  	status = "okay";
>  };
>
> +&dsp_vdev0buffer {
> +	status = "okay";
> +};
> +
> +&dsp_vdev0vring0 {
> +	status = "okay";
> +};
> +
> +&dsp_vdev0vring1 {
> +	status = "okay";
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0313f295de2e..9522a65b3e22 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -186,6 +186,25 @@ dsp_reserved: dsp@92400000 {
>  			status = "disabled";
>  		};
>
> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +			status = "disabled";
> +		};
> +
> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +			status = "disabled";
> +		};
> +
> +		dsp_vdev0buffer: vdev0buffer@94300000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x94300000 0 0x100000>;
> +			no-map;
> +			status = "disabled";
> +		};
> +
>  		encoder_rpc: encoder-rpc@94400000 {
>  			reg = <0 0x94400000 0 0x700000>;
>  			no-map;
> --
> 2.34.1
>

