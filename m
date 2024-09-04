Return-Path: <linux-kernel+bounces-315399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6E96C225
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5002815AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654531DCB30;
	Wed,  4 Sep 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OeuW+UlD"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D26DDCD;
	Wed,  4 Sep 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463359; cv=fail; b=jvlGfLRwXcZ8qtYjjBPxagNzgLGTuc9Mfpo4+0Zlm/v7s5zZ+3p80MKXVibGEbyCIW3+DhtMD/FpkPbRGZrS1gTn7PV+L6j5b17aydrP8qac5R7s3Wi8sXMmugKNz3QIGKNltZ7GE5wPSfM2SESA4YhJUV/Y16Vs6icRx/ruCc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463359; c=relaxed/simple;
	bh=F9RHbjD7J14csu7YBHN5Wr6izV2er0/cKyUd8Og+sv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S0DXZUpJCNN6XnQ3jikCUKnQ93vxMTkxogTSrcaQv0wb/CpD4pKW4ZxX8X8MkhpVbP+n/0cI+TxT+rlcnFdZ5X4Y94GMlMvuo2GrLbHIybd3zOZ9OL5kh04U8R+Hctpp9aZLtGPnVVdLUwDau41eqzeV122NRVBFNvgg+8URKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OeuW+UlD; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvh5WLTstemdLimI0qRoXPi/W90ST3cbP1Q3Iy39sjG+708ZzQkiSMj88iR19agE8RHRDFU9yRQXaDOjfsVzQVwdsSG04TuJY1DKk/GxTxVQQbhh6hJopHkhMBA7bAm/jUnjdMMMxyxBxHBXBfftLuvu3NsL0vaw1kAW5Fa8vX8XCdU9f+OZ+nKtw9awC5k/Seqi8DBe97ZJGpWxzt6CE7JR5MKCTHdEsnFH3hUlZTk1j4SArFC8kEKdbPSb489S+23A40r4PBATgEGbnr7skV5YacJI7rzC9ByzmVlj5YBEBhaRFpU6qRDuyMOROeRtG5HpIIk0MmBkR0W+Uk45sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V4iS08J6/Yztbzjse39wBTWdMQFjSzhuwwN2ePYwe8=;
 b=irFQ+L0bWIkEj96h11KuY8he6WGIJubmTsERDAQvnKiKOOL66cI2k1l5g0GcKTvS4Zd/vi120KN4x9WY3CenunfZ0qx0u0aEzCIuJzxr9rUT14Gg0ufcp41XMJt9ur/8y9mZyr5CKnCa4ICihex8mY9Af9MkAKRRdIaCniP/wFcxceRVihLhi9cNaMxfeJlnrwTOjPVCFGZVY3VPKXccR5JMoaFq6ycs9AaY99b3aynwZV80i8yJr3y9l2sh46R9SYvPfe/iP7HUyKbFCn/tDRGM0HAOnON57dpVjacMId8q43cn969HHABf2Gk0FG9AWHcl6G1ossNMAOdGn5j1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V4iS08J6/Yztbzjse39wBTWdMQFjSzhuwwN2ePYwe8=;
 b=OeuW+UlDO9Wm/Sb8SqlUul9ncmZjLLwm1QOPxCW0JkSzzqzuvYUadA+A948BfKb0vXF/tN0M8Wnlm0/G2qXIg00HIjkzFAsNZmUQMs6PwnMw94BebCEAokHc0GwWuUVxG+rQUfsofEpHRn6ENl0gPAwaxVyFyKXUFsxXW3h9YLgeInip6S8hLwGNe7bmfgO+Gun/MsnEc6pfkq3rhEL7LkL+5UFxoazXNEu9aWgF6jPsz1Cp5gBqolNzTsUVLMbxGNazXFkQj5cMfdmD3YXcyU+GO8ZVInfjQSl34fS6jLt7ffCuvOLXoEefxgrAm/TRpL+P93rv8Kiy7R5M3BtCEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10750.eurprd04.prod.outlook.com (2603:10a6:150:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 15:22:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:22:30 +0000
Date: Wed, 4 Sep 2024 11:22:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/5] Changes in v7:
Message-ID: <Zth7LdsV/KbjzB2b@lizhi-Precision-Tower-5810>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a07de0f-bf0d-44bb-85e1-08dcccf5641c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fACc+slYUksMK3PZho0NAN5+g16O0zb5rD8wy0cGNzMTrw4jeCP3u6JpUHcZ?=
 =?us-ascii?Q?QANLI/eZGZQrWOynXhloEJ1dMWE01aTCIavtf3bF21HJ0uglZALor7QJjhlK?=
 =?us-ascii?Q?xrdE8d6EcZ7zde+K940FIo7btEOPNMjoWtnxlyfy3yDRTIUVV/hgLJnJEN55?=
 =?us-ascii?Q?QDWU3qLlEfWAW4CvRpkAftxjAokxkWX/QhgST5ci5McXUpNaqEjwahp30Qm3?=
 =?us-ascii?Q?Gl7ES9QbMpYVVlQ+8TdYJZesniBBn52tzVITCHcHexu9nKgXO1GyP0x6fxe+?=
 =?us-ascii?Q?PpJ7VbOXoJfPeYuJLzHHE0jBRuFsF5jhDirtvJzNHTeu48mxlCHEwNP8jOeX?=
 =?us-ascii?Q?FkMpSvx6Stlq0ahVutPlGPDKZ4kwHSTGiUzAzRznGW+sFbJXx+/ftMOQn3HT?=
 =?us-ascii?Q?L4nSQCEqILxjyF9fgf6SW0mroR7Q+Ee8o8eLu0K6Omvqnd3kKiooUw4hmdJg?=
 =?us-ascii?Q?diLe1FaTOgzi97F2Hsnuido5FtWFVgXjK/Dumy0AF3L5ru8rgw/co7Rx79mn?=
 =?us-ascii?Q?2Y+UtIC/mwlA0yTFMbueL4jfYL+SOCR6pULYyUOCin6Bssvh6MyKSpPvYWw7?=
 =?us-ascii?Q?exvPjGKUHnr7hJ9H3DZYbEjmUs2u24G9uYzUi472+pWqtLrXUeGpohfucwI6?=
 =?us-ascii?Q?jPStfNqGLenjvI1MMG+U8TrmA11CPdRslnx5olHLMYpd5Rb2KREBf5QnfOHA?=
 =?us-ascii?Q?mDEmmt4Is5ty+thj98B8Oe1z98IqM33ciPpXxc7EBKBMFJlH4EQtUIOcd99w?=
 =?us-ascii?Q?aogqu8+VKSUWPbMoI99oMswCj+WH2iFDtLSOxklh6aBXz6EJmkkY43pxJjSi?=
 =?us-ascii?Q?Tu++rIzGh/G3SUvBkNVeQ3cNWk3PSNUAXx5IB7RLvvymylmrR21RwcsqvsOy?=
 =?us-ascii?Q?6doqNeJt+886TDKXmgtHcF8U6WfYajZXbLICG5cIOdMzTrOGF6csJRwojX9g?=
 =?us-ascii?Q?b8RVnylDWxYyJFFjbNBtPyXDZb8lXCPclLRqOSBoUG/4WUJ5IjYkXoIBfiFy?=
 =?us-ascii?Q?zfJgPNgMzYVkBY0YBDP8jiXhh7U+HrVL52RrMbmyU+toIodh3TKE2tUys84e?=
 =?us-ascii?Q?of1Y2XUIVPzFPRVBoOKFkXQRbYjnYLTBK0vYBCfujirEL3y/GATDicdIW+AE?=
 =?us-ascii?Q?j3l1WGP81teZQS0aTEi01adQ0smZygsXnAm8U0xyp5EJx+12mZz7Qm8sX6st?=
 =?us-ascii?Q?lMW66qveST93qKBvXbv0CnrjTlv1OzndmVocrbTa9thzzic5+1Q0elqw2lUH?=
 =?us-ascii?Q?RJgp1+sMhZAoIuol9LuZGc/Eo8aTPIOZH6W3RNnFZEtqntc7htjySfsh92VS?=
 =?us-ascii?Q?urcS6u13OtB7csE/49ssV0K8Z+cFdDsZAYA5v8yzsLZ/eimfCuJcllpmR/35?=
 =?us-ascii?Q?a01VR68Kaip6rzRVz3oOXpeeaqjTg4PHVBcjhKF/9Tt55r2C+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?973vrNy2aV+UVjxcikTq3b8Zy8BbdhEDWURc36cSwm5TraUQqJ4wep+/KryI?=
 =?us-ascii?Q?sUeZ5YilQK2NTbo3FI1GOiQSxsBDD0yr8x2dJcasGe15d55cu3+HY6epYAP4?=
 =?us-ascii?Q?VIG73CtEn2HGz0twE8mFo8XryDOx7dQqn0xkWLlJ2Emes2L9CGAUvDloNmLf?=
 =?us-ascii?Q?wArmKO685jSr+ILNjxm4I9ubfEnPaPnnqybcXmLgyQT5qqK87+gYxlW7Nns5?=
 =?us-ascii?Q?HHzkXYFzMhHXbm0hzWY3wj7TdIDDdIe1Zbc2YgpHNO7T6ZkBnwzpR7e88q/W?=
 =?us-ascii?Q?NRvrBPQQRpWWWDKuzvBCmtlAydFWVqOJrp5tW9wwvIkkd2laACnVfPT8Smwd?=
 =?us-ascii?Q?FP3IniSc7bHym0aupaiQQWVbwbJntyhPP2xvKUK9Agpg01qbSvSeGGUx7qHE?=
 =?us-ascii?Q?o+/scRj+XKkyuJQBq3UHheI7GALLFUhVbRfEJFHawjtESK7ELiJHM0QvVYC+?=
 =?us-ascii?Q?QODSJtBx/ViVXF3+u8pivs5GRLiBVVcF6mk6IvX5/4VmOz7xw3xOe7lxfR92?=
 =?us-ascii?Q?F3DSB7n/mkrC1/w3tAg3sBN5t4/RFY9u0ONeyTfjlAM2wANlCncmtIqFBaGd?=
 =?us-ascii?Q?JaFilFVZehq/vOglbH8+tZxa2Rw9ayMFvS9YRW/A1aGT31WA5z1AGDt3+IIh?=
 =?us-ascii?Q?18tlCMu4SVWJ8ge+uNyPAqaKW2DOZ8iwidOOJqcbONBY0pdPPoz27PmFnMJq?=
 =?us-ascii?Q?ysUQOqlA8euFEdVKzIhd+Wt3JjhPbPOqJuaDVRyawm5ivO0rBqpPL7tTI8yq?=
 =?us-ascii?Q?+Q7L+Ak/XiLZYIOX2DWL6aKFjxERY0aRPrSrbpfVHLDcq2ZPgUYkav/mMHIK?=
 =?us-ascii?Q?eVr5LFB4yvGnNvlXysFAo4B2EQ3JHcbo+fG1tSFzLiP3XVJJ2ppgRWqalf3/?=
 =?us-ascii?Q?vXCSkVgR7NEpnrHPVH0oRPQDitHtxy5duVpoLbQL72RJ7ePsaAngU1yFYXaF?=
 =?us-ascii?Q?0X02vwIoqRAF1E8wyAh8x9zXkZ5CiXwopkQ3cJlDzNxlZ754aMjuOvLhBp+N?=
 =?us-ascii?Q?7hi80jn08ZLr80DCAXtlhGDgRgnzS9uVFTIrJgFovSq7N5v+ojkmtQl+Gx0U?=
 =?us-ascii?Q?7zd0/BW4Kh1pwe5H3G6iBdpFTcX/OPUoncK/wV3e4Lfnv9Bv/fb8ZTHSRaA2?=
 =?us-ascii?Q?ofqWZmnsaIrC+org2laQP/XiJ1kV2t9P0b0q6QN6+cio4vQZ/T44lUHhL/GG?=
 =?us-ascii?Q?vtECAcUI2e0ltrQ1BJ7Gck1RNvXairgMcJRDfIECQDBrNttPUrwgzyaOASkK?=
 =?us-ascii?Q?PV9+lFZ197WMIcsyfzRXdA0rL+sNRGAc03SLgn7jW5560oP3pTY1ScjoTcHD?=
 =?us-ascii?Q?i5FOgQYZsJp+0g5xnqEV2tr4spRBQMspAHsnPPxP5A6ywjvEpuyY95WAhOhB?=
 =?us-ascii?Q?kVubPvi7k2jfaD5HSrWT09yEv31V861NEee+ONFK3q8F0GMXsoigbBIImua8?=
 =?us-ascii?Q?R6Of0PeVyWVhdZpdvwAD+YVZ8RRE4C5bCdH9OUJoEgMxOQ32ZTkljnV3CVoE?=
 =?us-ascii?Q?mn3nm0/6LEcE6xshfxZfStvknchXK79kAA3a0Dxyzzq3c52rT3g2orJE5S36?=
 =?us-ascii?Q?8RwJDTZiX1f+A3lSgLp4Y8lD6pas8yli5wMIDemP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a07de0f-bf0d-44bb-85e1-08dcccf5641c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:22:30.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz4RIdjNmjYjijZO5MLXnrPXEaBIw/JGaUN8yfL8AATKLpcGHHZCLSdXDMc9CKpC4+3UPu1h8fTs1sc4lpj3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10750

On Wed, Sep 04, 2024 at 04:21:16PM +0530, Pankaj Gupta wrote:

Can you fix subject "[PATCH v7 0/5] Changes in v7"? I remember someone
already complain this in previous version.

Frank

> 5/5
> - struct se_clbk_handle, is added with a member struct se_if_device_ctx *dev_ctx.
> - func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send(), are removed.
> - func se_ioctl_cmd_snd_rcv_rsp_handler(), is modified to remove the func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send()
> - func se_ioctl_cmd_snd_rcv_rsp_handler is callig func ele_msg_send_rcv(), instead.
> - Mutext "se_cmd_if_lock", handling is removed from this patch.
> - func ele_miscdev_msg_send() is replaced with func ele_msg_send(), in fops_write.
> - func ele_miscdev_msg_rcv() is replaced with func ele_msg_rcv(), in fops_read.
> - fops_open is modified to create the new dev_ctx instance (using func init_device_context()), which is not registered as miscdev.
> - Only one dev_ctx is registered as miscdev and its reference is stored in the struct se_if_priv, as priv_dev_ctx.
> - Separate func cleanup_se_shared_mem() & func init_se_shared_mem(), for shared memory handling part of struct dev_ctx.
> - Input param for func(s) ele_msg_rcv(), ele_msg_send() & ele_msg_send_rcv(), is replaced from struct se_if_priv to struct se_if_device_ctx.
>
> 4/5
> - A new structure is defined name struct "se_clbk_handle", to contain members processed in mailbox call-back function.
> - "struct se_if_priv" is modified to contain the two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
> - func ele_msg_rcv() is modified to take a new additional input reference param "struct se_clbk_handle *se_clbk_hdl".
> - func ele_msg_send() is modified to take a new additional input tx_msg_sz.
> - func ele_msg_send_rcv(), is modified to take 2 more inputs - tx_msg_sz & exp_rx_msg_sz.
> - func se_val_rsp_hdr_n_status(), is modified to take input of rx_msg buffer, instead of header value, as input param.
> - each caller of the func ele_msg_send_rcv(), is sending these two additional input params.
> - func se_if_callback(), is modified to work on two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
> - Variable "max_dev_ctx", is removed from info & priv struture, as well its usage.
> - New member variable "se_img_file_to_load", is added to structure "priv".
> - Other member variables - rx_msg(ptr), rx_msg_sz, completion done & list of dev_ctxs, is removed from priv struture, along with their usage.
> - func se_resume(), updated to wakeup the two "wq", part of "struct se_clbk_handle": priv->waiting_rsp_clbk_hdl & priv->cmd_receiver_clbk_hdl.
>
> 3/5
> - Node name is changed from senclave-firmware@0 to "secure-enclave"
>
> 2/5
> - Node name is changed to "secure-enclave".
>
> - Link to v6: https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com
>
> v6: firmware: imx: driver for NXP secure-enclave
>
> 5/5
> - replaced scope_gaurd with gaurd.
>
> 4/5
> - replaced scope_gaurd with gaurd.
> - remove reading the regs property from dtb.
> - Added NULL check for priv data fetched from device, as a sanity check, for ele_base_msg apis)
>
> 3/5
> - replace firmware with senclave-firmware.
>
> 2/5
> - replace firmware with senclave-firmware.
> - drop description for mbox
> - Replaced "items:" with maxItems:1 for "memory-region"
> - Replaced "items:" with maxItems:1 for "sram"
> - remove regs property.
> - remove "$nodename"
>
> - Link to v5: https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com
>
> Changes in v5:
>
> 2/5
> - updated the description of mboxes
> - updated the description & items for mbox-names.
> - updated the description of memory-region
> - move "additional properties: false" after allOf block.
> - removed other example except one.
>
> 4/5
> - Corrected the indentation in Kconfig.
> - info members:mbox_tx_name & mbox_rx_name, are replaced with macros.
>
> 5/5
> - Replaced "for  secure enclaves", with "for secure enclaves"
> - Replaced "user space" with "userspace".
> - End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.
>
> - Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com
>
> Changes in v4:
>
> 1/5
> a. Removed - from EdgeLock Enclave.
>
> b. Removed , after "Each of the above feature,"
>
> c. replace "can exists" with "can exist".
>
> d.
> -messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
> -MU(s), dedicated to itself. None of the MU is shared between two SEs.
> +messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
> +MUs, dedicated to itself. None of the MU is shared between two SEs.
>  Communication of the MU is realized using the Linux mailbox driver.
>
> e.
> -All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
> -enumerated and provisioned under the very single 'SE' node.
> +Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
> +multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
> +that is/are dedicated to a particular SE will be enumerated and provisioned using the
> +single compatible node("fsl,imx95-se").
>
> f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.
>
> g. removed ","
> -  This layer is responsible for ensuring the communication protocol, that is defined
> +  This layer is responsible for ensuring the communication protocol that is defined
>
> h. removed "-"
> -  - FW can handle one command-message at a time.
> +  - FW can handle one command message at a time.
>
> i.
> -  Using these multiple device contexts, that are getting multiplexed over a single MU,
> -  user-space application(s) can call fops like write/read to send the command-message,
> -  and read back the command-response-message to/from Firmware.
> -  fops like read & write uses the above defined service layer API(s) to communicate with
> +  Using these multiple device contexts that are getting multiplexed over a single MU,
> +  userspace application(s) can call fops like write/read to send the command message,
> +  and read back the command response message to/from Firmware.
> +  fops like read & write use the above defined service layer API(s) to communicate with
>    Firmware.
>
> j. Uppercase for word "Linux".
>
> 2/5
> a. Rephrased the description to remove list of phandles.
>
> b. Moved required before allOf:
> +required:
> +  - compatible
> +  - reg
> +  - mboxes
> +  - mbox-names
> +
> +additionalProperties: false
> +
>  allOf:
>
> c. replaced not: required: with properties: <property-name>: false.
>    # memory-region
> -      not:
> -        required:
> -          - memory-region
> +      properties:
> +        memory-region: false
>
>    # sram
> -    else:
> -      not:
> -        required:
> -          - sram
>
> d. Reduced examples. keeping example of i.MX95.
> e. node-name is changed to "firmware@<hex>"
>
> 3/5
> - node name changed to "firmware@<hex>".
>
> 4/5
> - used sizeof(*s_info)
> - return early, rather than doing goto exit, in ele_get_info().
> - Use upper_32_bits() and lower_32_bits()
> - use rx_msg here instead of priv->rx_msg
> - Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
> - typecasting removed header = (struct se_msg_hdr *) msg;
> - Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
> - Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
> - removed the mbox_free_channel() calls from clean-up.
> - Flag "priv->flags" is removed.
> - Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
> - Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
> - Removed the function's declaration get_phy_buf_mem_pool1
>
> 5/5
> Changes to Documentation/ABI/testing/se-cdev.
> a. Removed "-" from "secure-enclave" and "file-descriptor".
>
> b. Removed "-" from "shared-library"
>
> c. Replaced "get" with "getting".
>
> d. Added description for the new IOCTL "send command and receive command response"
>
> e. Replaced "wakeup_intruptible" with "wait_event_interruptible"
>
> f. Removed ";"
>
> g. Removd "," from "mailbox_lock,"
>
> h. Replaced "free" with "frees"
>
> i. In mailbox callback function, checking the buffer size before
> copying.
>
> - Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com
>
> Communication Interface to NXP secure-enclave HW IP like Edgelock Enclave
>
> Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
> V2X, SHE etc, is based on the Messaging Unit module that enables processing
> elements like ARMv8 core, RISC V core, within the SoC to communicate and
> coordinate by passing messages (e.g., data, status and control) through
> these interfaces.
>
> The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
> targeted for use between application core and NXP secure-enclave(s) HW. It allows
> to send/receive messages to/from the secure-enclave.
>
> Patch-set adds the kernel driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
> both from:
> - User-Space Applications via character driver.
> - Kernel-space, used by kernel management layers like DM-Crypt.
>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Rob Herring <robh+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Rob Herring <robh@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>
> Changes in v3:
> 5/5:
> - Initialize tx_msg with NULL.
> - memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
> - new IOCTL is added to send & recieve the message.
> - replaced the while loop till list is empty, with list_for_each_entry.
> - replaced __list_del_entry, with list_del.
> - Removed the dev_err message from copy to user.
> - Removed the casting of void *.
> - corrected the typcasting in copy to user.
> - removed un-necessary goto statement.
> - Removed dead code for clean-up of memory.
> - Removed un-mapping of secured memory
> - Passing se_if_priv structure to init_device_context.
> - Updated the below check to replace io.length with round_up(io.length).
> 	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
> - Created a function to cleanup the list of shared memory buffers.
> - Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()
>
> 4/5
> - Changed the compatible string to replace "-ele", to "-se".
> - Declaration of imx_se_node_info, is done as const in the whole file
> - Remove the unused macros from ele_base_msg.h
> - Remove the function declaration get_phy_buf_mem_pool1, from the header file.
> - Replace the use of dmam_alloc_coherent to dma_alloc_coherent
> - Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
> - Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
> -  Removed the unused macros WORD_SZ
> - instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
> - Removed ret from validate_rsp_hdr.
> - changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
> - indentation correction for info structures.
> - remove the check for priv not null from se_if_probe_cleanup
> - Removed the casting of void *.
> - se_load_firmware function is corrected for not freeing the buffer when allocation fails.
> - Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
> - imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
> - removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
> - removed the function call for devm_of_platform_populate(dev);
> - Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
> - Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.
>
> 3/5
> - Changed the compatible string to replace "-ele", to "-se".
>
> 2/5
> - to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
> - Added an example for ele@0 for compatible string "fsl,imx95-se"
>
> Changes in v2:
>
> 4/4
> - Split this patch into two: 1. base driver & 2. Miscdev
> - Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
> - Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
> - Fix initializing the ret variable, to return the correct error code in case of issue.
> - replaced dmam_alloc_coherent with dma_alloc_coherent.
> - Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
> - Replaced -1 with -EPERM
> - Removed the safety check on func-input param, in ele_get_info().
> - fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
> - Correctly initializing the function's return error code, for file  ele_base_msg.c.
> - replaced 'return' with 'goto'.
> - Use length in bytes.
> - Corrected the structure se_msg_hdr.
> - Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
> - Will add lockdep_assert_held, to receive path, in v2.
> - corrected the spacing at "ret  = validate_rsp_hdr"
> - FIELD_GET() used for RES_STATUS
> - Re-write the structure soc_info, matching the information provided in response to this api.
> - The "|" goes to the end of the previous line.
> - Moved the locking and unlocking of the command lock to the caller of the function.
> - removed the safety check for device private data.
> - Structure memory reference, used to read message header.
> - In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
> - do while removed.
> - replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
> - The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
> - Update the 'if' condition by removing "idx < 0".
> - mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
> - devm managed resources, are not cleaned now, in function se_probe_if_cleanup
> - Used dev_err_probe().
> - Used %pe to print error string.
> - remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
> - used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
> - Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
> - Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
> - removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
> - Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
> - imx_fetch_soc_info will return failure if the get_info function fails.
> - Removed devm_free from imx_fetch_soc_info too.
>
> 3/3
> - Made changes to move all the properties to parent node, without any child node.
>
> 2/4
> - Use Hex pattern string.
> - Move the properties to parent node, with no child node.
> - Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"
>
> 1/1
> - Corrected the spelling from creats to creates.
> - drop the braces around the plural 's' for interfaces
> - written se in upper case SE.
> - Replace "multiple message(s)" with messages.
> - Removed too much details about locks.
>
> Testing
> - make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
> - make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
> - make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
> - ./scripts/checkpatch.pl --git <>..HEAD
> - Tested the Image and .dtb, on the i.MX8ULP.
>
> Reference
> - Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com
> - Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com
>
> ---
> Pankaj Gupta (5):
>       Documentation/firmware: add imx/se to other_interfaces
>       dt-bindings: arm: fsl: add imx-se-fw binding doc
>       arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
>       firmware: imx: add driver for NXP EdgeLock Enclave
>       firmware: imx: adds miscdev
>
>  Documentation/ABI/testing/se-cdev                  |   43 +
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
>  .../driver-api/firmware/other_interfaces.rst       |  121 ++
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
>  drivers/firmware/imx/Kconfig                       |   12 +
>  drivers/firmware/imx/Makefile                      |    2 +
>  drivers/firmware/imx/ele_base_msg.c                |  286 +++++
>  drivers/firmware/imx/ele_base_msg.h                |   95 ++
>  drivers/firmware/imx/ele_common.c                  |  318 +++++
>  drivers/firmware/imx/ele_common.h                  |   51 +
>  drivers/firmware/imx/se_ctrl.c                     | 1305 ++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h                     |  151 +++
>  include/linux/firmware/imx/se_api.h                |   14 +
>  include/uapi/linux/se_ioctl.h                      |   94 ++
>  15 files changed, 2610 insertions(+), 3 deletions(-)
> ---
> base-commit: b63ff26648537a5600cf79bd62f916792c53e015
> change-id: 20240507-imx-se-if-a40055093dc6
>
> Best regards,
> --
> Pankaj Gupta <pankaj.gupta@nxp.com>
>

