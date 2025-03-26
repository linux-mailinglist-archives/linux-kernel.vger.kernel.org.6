Return-Path: <linux-kernel+bounces-577255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B87A71AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E959C3A5726
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E601F416A;
	Wed, 26 Mar 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAFPnI3A"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08B13B7A3;
	Wed, 26 Mar 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003294; cv=fail; b=SB34l8J7Y4JIRAbdv9NeFHruhMFRacvHsdwG3LJ/33yoJJKncen3FWolRK3KAgmKuuEhny+OBsWu1cLm4wWAaP3Mc0Y641cYJq8RrlHPhaLPisiYnZwKdUCdKH8RVH4C1V8KNhMUYk/0jJXyKYfK6LvwjVHcIXx2+Cx2NwyNQ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003294; c=relaxed/simple;
	bh=QWrWqmXiMJ9d1ia187E5fhvBiae+IAlyVJSpoQe4uAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=svoyM9kQCUoQy0NZZ8PBfgCXoL/lcjP+Vri5CYMi/HCBBkKHfUhv1QioEQEnM0w+H2RXMmkldsK6OHYlryTn3/05Adf6W7b/A2Hppt03RmSNBQHnCmppnukpQVDLDDBpLoGEIIJn8wZKalyrJ9rCPyRcPwL1V7D1w3D2fkZagRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NAFPnI3A; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Me/76tIrk6ZKfadf5x5tBMo9gisGxFkDC9Db4fZMIWcnSECWDf7QOuKj+79tyJBJIzcMfht7hs++vUFrpkLYCR3x3rq6CvFNKPLUU/cTBbqh7Xl2tI+innQ3uYzNzuPfrOvAUDae22bgkl38/OcM51rLLBlp069gQ+t5fMtB1NLc4oc7xjRXoYxh5UzHd8IypX8SLhTw5LP8S8cFU/uR05p5GAYR46lTIPfAdl1WxaZnfD1vC/HHYeJXUOzE925Wlr/fg+jgbJ74jsQ1lO4WAXlShnnODQKW+OXKkIOvpL/EsTqx42wmDqEl7IK6uTm6BocKDRKVU8rU97CvbXv6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdnQNimgGmeVdSQ2wt7ZSq533BfJs4dYXg2Vyrpg80U=;
 b=C3bnAaW05kYyZXWqYkJxDReoGla6+G7NvUwCp9Z8LEO9Iww9S6yXUy21pTVIe/exxvgeHFE1tPi4mVLq4L9DalYrvyHxcPph2aN4BFfuA1yVvQIsXrCXrLuoNtysPOIfVsBk/ZZB8UrRUmBmeMFBXNHR1MW6VaOFOQFV9Zztzkxo5vZDI9J7KMtOcfifonHxAZxc1J2YPjZvQZx/imDNvmNpeMZ7ix8Yrk4e8I+UuzIX5c5ylLT0gPpMWf4+lfQ7YzoMLjV11bunqIanjF9kbQcvpdrzOI/D5vV7sWEGxK6Lo1NfD3wF5ek7jn1eefQp/KZ+wo8XYX1C8w91554O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdnQNimgGmeVdSQ2wt7ZSq533BfJs4dYXg2Vyrpg80U=;
 b=NAFPnI3ASWlymXAj0yw7CZFuTrhaNa8EELPigFE5XcYv81wO1mUukTd3CYy9Fdf/o/D2OIy8nr/k5zX8ZP/+2C+xwC8R031MoRTP0f9pAHGk3ajzYGFP6xG5P8gJPnmXpm8c2+tMB6xlJfSb5vREv/FqZ0qsqOjOTttrBOo+pNfBetKetjh8pV+y3EVWsMQ6YM4mqfzwySUuuXT1NVHHTlHkwbVPVCLdGmQmOjDMb9u0FzKQLHl/hvwJ5F2vOntPIBi2l7VEhE1olgJxUzzZ3b/YN9shcUxpE/fLbiRso8dXl2sxYzger33GK36vFzK5d2/lUhtwIjleYcpxRceJPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8996.eurprd04.prod.outlook.com (2603:10a6:20b:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:34:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 15:34:49 +0000
Date: Wed, 26 Mar 2025 11:34:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 5/6] firmware: imx: device context dedicated to priv
Message-ID: <Z+QekQVacwA4YEix@lizhi-Precision-Tower-5810>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
 <20250327-imx-se-if-v14-5-2219448932e4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-imx-se-if-v14-5-2219448932e4@nxp.com>
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 56be0aeb-48ff-4413-37c4-08dd6c7bbea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uiGMYMVS5fBRFUzfR2RqmYmpCsoiGF9N4T5VYqQZ1wM0PjMfh21UL/0PKqKl?=
 =?us-ascii?Q?PTcNdoGQ5k/f0XMwmUM1Ys6Lnsb8iFHMcWZV3iFwuYG/tfJApTtfKVl4lK4o?=
 =?us-ascii?Q?xqKiBYiWQ1koBGtMEvTUsqW9OCKBJQ6cYYUpro/pWL2R3lHNBwWm+pdTkB0R?=
 =?us-ascii?Q?Wny1qDwUMkYcgKQIk1ufCdHwnJTG/wS+IPx6H9RnXxwKtiEXmFtXq+S6tAAm?=
 =?us-ascii?Q?qKemLqVEUNRrPejafcxBWIsKWq0tzuhE2e0Q5moIX0K/hhlTLvPJUhhHZ2M7?=
 =?us-ascii?Q?hIG/zvwksC8ns80F4lOPbr3jgVvazx0Oh16yphSHdnlClaP1p3RWqHxLXN9q?=
 =?us-ascii?Q?rwFjhuo5Sz25puu+5EK6P5zQcQm2uFDA7ksuJ914pQ3lggMJ2IEHl6U3KRB4?=
 =?us-ascii?Q?40QinBYp/heZUkQfpYLQkNCO29tH1ylHEVx5ukjtUrylMAUOSbH1W3n0LE71?=
 =?us-ascii?Q?PlLMomPZt8t1Jvwk9lf4ruMzTnOA9GvTNoKnaWBLyDgXWjEFTumxgWP67iLk?=
 =?us-ascii?Q?A+JmsZsjjit41WhAQcSweLcaN9FCMZ9VHlIuFFOJ1hQpWTLB9pA9EAnWwyLf?=
 =?us-ascii?Q?BAWATWxqp4MiUIhvZpqd/xw3uPkdtVr22L1ToYEBeY6b6rIS98oQvsCKTajy?=
 =?us-ascii?Q?GRbH35QblZ9tOwv3gtIr6ECyBsW2aeEFPHOt0HC5x7bW8Dd60sPlD/ZGzrR6?=
 =?us-ascii?Q?yr2S2uuapNu7sLxVVJhioRANj4N+8n+1WSE/BIR/8iQr0RH9UaXwc1xdjSA9?=
 =?us-ascii?Q?ewBAsXW6wJfhfFcx4IXVEq5StObyCXHtYvDFVFIcBCwTipdbtn7w5pp/ERwu?=
 =?us-ascii?Q?sNCAfh3ix3yXS6EsWhjrevrPvuktLfIjFGBEjuV8GYjU/oa+U3SbQIxz4KGd?=
 =?us-ascii?Q?Cwqi18gEqjinNDeQsOEDU+Erm9DJTnvm8Ju2Gl1YZSOKWbecFMM4hLcm+9wq?=
 =?us-ascii?Q?tX37EPR6ovprvUNVYka/qhl5m0cKbtBhXvEgJWBaLXKVh/SIlgYyZL7qExo9?=
 =?us-ascii?Q?wgEkOwe2A+mVF4Lanq1mCIV/PrarHRvRhmoWS+vsmJxb64ZJ4MCnHOy/pNzL?=
 =?us-ascii?Q?5Q8UAP74ZDrTlL1xTrpQ1Wa21jlYb9FwNDIclnc98WXHI9/tm14IaUW8DdKZ?=
 =?us-ascii?Q?BFgUOKJ3aOYQ7v6rouVSNGypt+yBINPi/VkrtC6T83e+NgadrAiAlQAEBnSK?=
 =?us-ascii?Q?YZXWH5JzTDVW0rWcucwYTVJJUbq7ZLtF8W+T+l0PNCkXOxd/FGc/D9UoRqkT?=
 =?us-ascii?Q?fnAMfmzI1KxrMnGmKEcy+1WHo9pvaS0Wb1K3NMbt0EnF0TQGcCxoshI8QiHV?=
 =?us-ascii?Q?GdJQibNgERqzAi4LdsY9oJki3+z5N2gUYP4H1YHHqhNdKLFuEZFRN0Ft0HGH?=
 =?us-ascii?Q?kWa1n1UPpIVGw4pW4yZOvjF5P2fsFRRZ30ItsoJdNj6G5QEOFu3JdffPmN3C?=
 =?us-ascii?Q?Jz9+d2wBcjG6c1UzYPfZYPxFVdqVmXMC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qal9pzk7bEYmDGsXpwhemoEEOKd7GyyXe8+rkAwpUg8yU31kvSIjQBcmvPfJ?=
 =?us-ascii?Q?6b29X67ot7eLOKH1L4wgirXM8Ba/tWBvnl3nh1pKeMh55kmP178K2e3cFonl?=
 =?us-ascii?Q?dpwDHrKMFvqGiO/ALd++6Q7QplyUtD3g/nug6pvSiY77/9HXGUreaLSrtx8l?=
 =?us-ascii?Q?U4dLbfGQFmLQzGivnIOBTWYMxH/VjO45IOjNoRCkjC5uSckN+6QeRf1a/EN2?=
 =?us-ascii?Q?v4Ztlo4J5pmr/vlGvNaAFch1Z6sJBWAbj6LN7JvtfVD8slSi56idITr4hcqT?=
 =?us-ascii?Q?AZvLASDkvUTPfiQhu+22+5xEDEWt08YKqKxYGVVqGT9dKjOeX8HHEOUufphD?=
 =?us-ascii?Q?VD4WrKNSf2zkWUPvU/mmqf243FH0+cmj0iXmOoONPkMbZLMyME3sV1SophVR?=
 =?us-ascii?Q?obA7L86CL1lc3m04DXxJ35+lxx7DY7NYSAiBRsP01V50fTyPiOarArQoCE8y?=
 =?us-ascii?Q?34Ri1EAyEfCK5HeD1JhaeH8HGGIPkf7+gRTEAscWYCmxL/9TWeicY9xSLit7?=
 =?us-ascii?Q?Dp1PZPz8AjCqNm5ruyWSnaTAggl4qE/YFAUGwwV8tPIDpvjZgYgM/Ycq5M8Z?=
 =?us-ascii?Q?9kRTLSr1Oveq0h0R8URsH7FrMb4OgMoMBuKMHI1bkqzmkcKnPzXcwqdWYxqw?=
 =?us-ascii?Q?BGTM65VOoYYUE0Gnf1nmodWivpknz+8x1OxnPTE/tw6BiNubxPSQvfod3Wxe?=
 =?us-ascii?Q?tz3DUUR4KT1Uwi1C873Egm8VgT3+CAAGNmQ3irIWEZBPpJF6WlItg1wEf9op?=
 =?us-ascii?Q?5O1YAUlH3AQY6eJaTJBdMAFgOO9Qezm+Spn6140KhKpO0NJFnbF2ARKITKQl?=
 =?us-ascii?Q?RVOX1sQ/IHBNW87ux7+Kx0Bx7Smhwy0Z6fpKLAdzFzxzMkIG/e1/40NRHq6S?=
 =?us-ascii?Q?njUEPRFyYf9RJJDKdUMQlcRlkTX4eOVtiWbFH79VyGlod5D+AH+USHnjPgox?=
 =?us-ascii?Q?QGNcTZbi1S8RtMTAxa/Ofdzzny3N0Bt6wegLarVCxWG+U22HAW0eQC5CNdpU?=
 =?us-ascii?Q?3/+IWyQw691JlWVbCJZTtnp7Q1130Gocsfu8SpXQ4Qcnny17/TKSl/gPL30u?=
 =?us-ascii?Q?Q5Je6KOCEgJKDfuKI81GxLinPAC8tES7p5BCuy6sKnPqCthGj+0Fq/Emmvi0?=
 =?us-ascii?Q?A1r9MDjd5QlrHgrZQLnKbfGcTcSXGTPtxbQain5RO9LbR5BnkWxHFWBAt0FN?=
 =?us-ascii?Q?mxLBkTtYN9wlvEL2io54pv7y+ZolCclxtNeJHDLD2qKJThIkpESOdWqzRhD1?=
 =?us-ascii?Q?RC7rbE+5og/o2MSDTi/K783xXSU7B7p/zWSHK3RccCrrhpFGARofrtw2gySW?=
 =?us-ascii?Q?XpCbSC70stuLBQ6BDHGV/95QKYWV7PUtdER0EpImLNoKNDamv4oGQ6LvleSY?=
 =?us-ascii?Q?kBe10MsG3Y0IraszcG0BFeklIcKzEbzrmqf9mblqffnfLyx3IZ/0IewzySbO?=
 =?us-ascii?Q?vdgnt1JdGtaPVNM6UiQGkoPkwLRqQQ4893gVBoN8r5oQv8rE1RyIGXPIXkyo?=
 =?us-ascii?Q?iMvttOuKCCLMH27ECjxB7E3Lh7VnanEx9ixDOrA+5uB376ocmMP4w4ZUcY1B?=
 =?us-ascii?Q?nEJFKx2UX0N+n9Uy2W6w1hHuBBwjCv7hS8faXYHC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56be0aeb-48ff-4413-37c4-08dd6c7bbea6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:34:49.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cn3yW6Pwq+/IujChgw9ivBzOEEbYKvKQP4YG443zmsL+3xA86m3jd61nHInYoXcVY8ysmZy6NwRu4glmzwP7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8996

On Thu, Mar 27, 2025 at 12:08:01AM +0530, Pankaj Gupta wrote:
> Add priv_dev_ctx to prepare enabling misc-device context
> based send-receive path, to communicate with FW.
>
> No functionality change.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/ele_base_msg.c | 10 +++++-----
>  drivers/firmware/imx/ele_common.c   |  3 ++-
>  drivers/firmware/imx/ele_common.h   |  2 +-
>  drivers/firmware/imx/se_ctrl.c      | 31 +++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  8 ++++++++
>  5 files changed, 47 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> index 3839c93f8212..c07c21f1fbbd 100644
> --- a/drivers/firmware/imx/ele_base_msg.c
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -62,7 +62,7 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
>  	tx_msg->data[0] = upper_32_bits(get_info_addr);
>  	tx_msg->data[1] = lower_32_bits(get_info_addr);
>  	tx_msg->data[2] = sizeof(*s_info);
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_GET_INFO_REQ_MSG_SZ,
>  			       rx_msg,
> @@ -122,7 +122,7 @@ int ele_ping(struct se_if_priv *priv)
>  		return ret;
>  	}
>
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_PING_REQ_SZ,
>  			       rx_msg,
> @@ -174,7 +174,7 @@ int ele_service_swap(struct se_if_priv *priv,
>  	if (!tx_msg->data[4])
>  		return -EINVAL;
>
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
>  			       rx_msg,
> @@ -227,7 +227,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
>  	tx_msg->data[0] = lower_32_bits(addr);
>  	tx_msg->data[2] = addr;
>
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_FW_AUTH_REQ_SZ,
>  			       rx_msg,
> @@ -275,7 +275,7 @@ int ele_debug_dump(struct se_if_priv *priv)
>  	do {
>  		memset(rx_msg, 0x0, ELE_DEBUG_DUMP_RSP_SZ);
>
> -		ret = ele_msg_send_rcv(priv,
> +		ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  				       tx_msg,
>  				       ELE_DEBUG_DUMP_REQ_SZ,
>  				       rx_msg,
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> index be4dabeeb64c..f75a8237e353 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -89,12 +89,13 @@ int ele_msg_send(struct se_if_priv *priv,
>  }
>
>  /* API used for send/receive blocking call. */
> -int ele_msg_send_rcv(struct se_if_priv *priv,
> +int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
>  		     void *tx_msg,
>  		     int tx_msg_sz,
>  		     void *rx_msg,
>  		     int exp_rx_msg_sz)
>  {
> +	struct se_if_priv *priv = dev_ctx->priv;
>  	int err;
>
>  	guard(mutex)(&priv->se_if_cmd_lock);
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> index c95e45123b5b..a6bf93f0048f 100644
> --- a/drivers/firmware/imx/ele_common.h
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -18,7 +18,7 @@ int ele_msg_rcv(struct se_if_priv *priv,
>  int ele_msg_send(struct se_if_priv *priv,
>  		 void *tx_msg,
>  		 int tx_msg_sz);
> -int ele_msg_send_rcv(struct se_if_priv *priv,
> +int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
>  		     void *tx_msg,
>  		     int tx_msg_sz,
>  		     void *rx_msg,
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> index be381980fec0..144a727bbfe0 100644
> --- a/drivers/firmware/imx/se_ctrl.c
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -191,6 +191,31 @@ static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se
>  	return 0;
>  }
>
> +static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
> +				    struct se_if_device_ctx **new_dev_ctx)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	int ret = 0;
> +
> +	dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
> +
> +	if (!dev_ctx)
> +		return -ENOMEM;
> +
> +	dev_ctx->priv = priv;
> +
> +	dev_ctx->devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s%d_ch%d",
> +					  SE_TYPE_STR_HSM,
> +					  priv->if_defs->se_instance_id,
> +					  ch_id);
> +	if (!dev_ctx->devname)
> +		return -ENOMEM;
> +
> +	*new_dev_ctx = dev_ctx;
> +
> +	return ret;
> +}
> +
>  /* interface for managed res to free a mailbox channel */
>  static void if_mbox_free_channel(void *mbox_chan)
>  {
> @@ -317,6 +342,12 @@ static int se_if_probe(struct platform_device *pdev)
>  					    "Failed to init reserved memory region.");
>  	}
>
> +	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed[0x%x] to create device contexts.",
> +				     ret);
> +
>  	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
>  		ret = get_se_soc_info(priv, se_info);
>  		if (ret)
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> index 177623f3890e..f0893c5c9145 100644
> --- a/drivers/firmware/imx/se_ctrl.h
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -35,6 +35,12 @@ struct se_imem_buf {
>  	u32 state;
>  };
>
> +/* Private struct for each char device instance. */
> +struct se_if_device_ctx {
> +	struct se_if_priv *priv;
> +	const char *devname;
> +};
> +
>  /* Header of the messages exchange with the EdgeLock Enclave */
>  struct se_msg_hdr {
>  	u8 ver;
> @@ -79,6 +85,8 @@ struct se_if_priv {
>
>  	struct gen_pool *mem_pool;
>  	const struct se_if_defines *if_defs;
> +
> +	struct se_if_device_ctx *priv_dev_ctx;
>  };
>
>  #endif
>
> --
> 2.43.0
>

