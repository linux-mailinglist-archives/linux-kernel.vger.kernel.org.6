Return-Path: <linux-kernel+bounces-436686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A09E895B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D46C2807BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AC4594D;
	Mon,  9 Dec 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="soeh8yon"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062.outbound.protection.outlook.com [40.107.103.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163114C91;
	Mon,  9 Dec 2024 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712553; cv=fail; b=TScDFtit2ivuqp0pY9+EDppuV0XE9rVR8dYZGxGubVyAKtvHnojvcbbbhcraibPFbd+Ra+i8prQl/CE2dlXn9tzV0fiBrWkMjs4mYrH4sfj6RdXQKoLPVpJQ+b2hotSE2+rMitEBSHBcXncLeZDB9prNlVCBRpciLx08u5CDxkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712553; c=relaxed/simple;
	bh=O4ynzd+KiF7a6EJeqlTxTg/tybqUfaDkCrzsSy55/68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z9gTVT9n/sgcgnx3DO7XNiB9XX50bEhYbBPi/8uFhbefrCB7c7SK9B0vhPTeXN6DNX/x0hip/eaPEg3EVqp15vChhi+85tKOij1Q5vXw3Zc1DGsskh1lSInJbEUB8HTRN1Lq33e3PxYWB81IykYhqQmLUr+s4vrwID6ClgKIKw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=soeh8yon; arc=fail smtp.client-ip=40.107.103.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHKfiyZrExfAEsiOEYvNczx9m8uhzcZYH7NemKllnhkD5vElUBUBO4equJw1FE2v4OJIMzVfkQMop72k3H36kwSzTJ5ulj9XTvNHx8nHCdKGNLKCQrYw+WoPciGKhEnq5immDeHJbD7+0FdEQ+7vC859Q6MtLkR4OkRsFYK6ofNt1C/Eyetfq8YoIDBv2GtHQ7xYDX3eMw7LuplxrvLcmte0qSOaRnwUuXVLxI/P2I3GCFdNtiy6UlnTCGeG6CdnX8rx8vAL4pZQXzWEiclcnZpWRi52MExsXDd5FV6q4vLzwALPFjQWtBCnVtbax2TRWeO6qKmf6w/Ri/avXEGOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ynzd+KiF7a6EJeqlTxTg/tybqUfaDkCrzsSy55/68=;
 b=MLKeSp50Ng3rK/78tM7KC5QsqeJOi8B6jXvabfQHkg21VqO5YgNXVpBGHhzFulkjVPWC2TQG7bSZ+QUB8pSvX5Q2vM1tJpn3fq1NIpT4dGAZ4n56mQKJ0EpX+KLvFvfEwnZuZGZFXQDYsIqXxxsyPJLATT4tjrXxV9YTs5a/VZ2ZdLaG6NiwL9fxfPKBt8lHV7xV2UmEyXns+FM6VG8bCEVC5lBbXem0iC2Yug19wNOcxrcy11893rpT0mEZruqhx9IUEgZwyj1FzW2e10rDBIXDNouUM+8Trz5N63olHx0J0mOav4VfvB9oCafujc4Rwzf7a7gcMIAxdqNcAEoIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4ynzd+KiF7a6EJeqlTxTg/tybqUfaDkCrzsSy55/68=;
 b=soeh8yonhHo6XzwMc++ZbHwuJtYM1uYuNiweMunpnT6GzYmHncduuWUMu9GCb7vjvgBgg2izeQO6zUNI9EVYkhUx948wFlTtm0aN3VKP5WbLDgZtd1CwNYNxzOHsgpmFBqPvc/MtuEM42YGupsfhhhvXS4lzmC3amBID7mUfJOPYwUIw82h0KuaLxsedZNxTBGiVoNtKHXvRSI+iYXb9odzfYBR2/POSwVUlpXxselEWjmJM/CfnnUkOKeGeRgHqyMHUpavwNvw34vSi+1Q2mFpjyGkj0kU1FWHshig8l+jBIrSmkWPv+Vr2EbPgj/jD5+u3FjSdpEJrYSjYqXjWcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 02:49:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 02:49:06 +0000
Date: Mon, 9 Dec 2024 11:54:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, johan+linaro@kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add module aliases to i.MX
 vendor protocols
Message-ID: <20241209035412.GA2291@localhost.localdomain>
References: <20241203200038.3961090-1-cristian.marussi@arm.com>
 <20241203200038.3961090-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203200038.3961090-3-cristian.marussi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: ee04434c-e822-4d57-707d-08dd17fc0c08
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6EKjjs0QPq71WrNfmmTDSbVQRxuVS+bRJuxrg/fgue760sD+vAXtBjHGKhbo?=
 =?us-ascii?Q?AhYDxm6teWF2RCLn7B6ALQVOql8t4kScFlJKZZwUd2SBEQe45VuNTDfdYnWO?=
 =?us-ascii?Q?k4f7kr3eIngV9K+AMIyeYVlcegWhJyitdYOYj1aN/xoXsCUEb9EX6p9xKspx?=
 =?us-ascii?Q?5KCHovueeVUybZkJ3cjLPjfecdM7LVPjgFNGWweaQv4dSKOoheP9vJ3M92YA?=
 =?us-ascii?Q?5xxBiSCzx4uTnM3IJ6qugJ1b1RvBQcyQBOxPU9yT0PbzakWS441JjfPQiTZr?=
 =?us-ascii?Q?xGfobv+kX65QOd3CAVORKVlOE3lMOOyPpaFWNZo+A1ySZ4wIMmNUQ2sKEBm3?=
 =?us-ascii?Q?LE6VzjptmuERfXnmGSmbDSiLd51KK8gwYJZE6DIq/oS8XuRc8cKIxDfgkeJp?=
 =?us-ascii?Q?20XQnNqttDuib3kmswTrHfHZSvbcBQF+Mh3+C8C9ZmFENgrO225Rn/SPw9a6?=
 =?us-ascii?Q?ZT8QjbQxPUxfuykyYaZITbrKZS/bvIO7tPyZtwEA8C/k/zBNTOMQZf8ExeMM?=
 =?us-ascii?Q?IU3/1OF2ka9AhFnr2GHLkHnse9dS0V0V/+vJNN0hATIkDlQapMx4Crq9+of2?=
 =?us-ascii?Q?djgbMuODoDr7sm92J2RWKI0fY/nCMCnIMsqeWlmEld8a1MZvFcz3F+LxBCJM?=
 =?us-ascii?Q?+iLcX+hLs/JUxR92Vgz0QgPKvRJ3JlyRUcF4EWwlF3sB8En9kNd7pSrXHPPY?=
 =?us-ascii?Q?UUsc7uXFHfcGgV6u8OjGIFaniD04vtzi6VEzmB7yx2GZheN90/kFlMtU0Ynr?=
 =?us-ascii?Q?MgkfjrvMxVUyhBHHH5dD1tbqV3Id77WNNbdYPKvNj9uRTE14pFml4+rH+6Vi?=
 =?us-ascii?Q?QNUlK/W2yZV9mcHdgt/hAjEMme7Q+8eGO/v63W8rjk/8D2ScPKx5rCrKD1N9?=
 =?us-ascii?Q?CsqEm7WxpDEM9V+yBe3I8cQ5Q+SwaRPRjoxK3ec8W866XK6B2uzMOClHor2u?=
 =?us-ascii?Q?AphsY3DKhmCFd98g3PpNgE6pjpykIXW14B4EXuO7Dt8aQ5C+rcfV8OlZ2PJO?=
 =?us-ascii?Q?SU2tqPYmQ0BMCwDH5FzbKdjsAzIaINp0Tp3iLFqrFO+2zyGRVCHT3HC4dS0C?=
 =?us-ascii?Q?b66azlBeZlexfDk5afWMZyCosAt4wsLIPkGwLbLij9ygjb2P7+iYjjLwf/rX?=
 =?us-ascii?Q?qoZpPJM3GIbnkE5alDnxZmsw/qlplZHg5U9vHSFZxImcPm/6QiEAqQ2PITTC?=
 =?us-ascii?Q?sXbqhxkXUZjLO5FNu2tCXuC+yGhPNssVw/zdnXadJeYG3C6JHmCkoLFyh5Xv?=
 =?us-ascii?Q?4HtPlf6HytPElvkSGbpgvWu59taOGeO0Q2pR111ScW2/fhgvV4q04FGaLbWW?=
 =?us-ascii?Q?y5524vDTuv/mCRBwPcbxHNjykrlLNVR4j1ibLT5kTrJrAVvAgV/H7RF5nfkT?=
 =?us-ascii?Q?dsp22hRJlceXgM9ELCq7nTqJEkrdHXFLBR0oLdFL/lpbvE6ngQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5t3uKrwHlWC+UDsVLsWTmq6S/edhOdGC3JrdLE1r/JeXSli6weJDuBGk1Q8X?=
 =?us-ascii?Q?9Lq7KKrPoDOJUgkzePSVds5fbtNyReJWCYuSmtJB4e+2XOMK5K6kknwWCTWk?=
 =?us-ascii?Q?BMdLUcfuLFbtHaaDIlrj/N6nytqsGfzt/+ixb6gLvqrpKJyg7xaULgiyYVOc?=
 =?us-ascii?Q?ui8sTDrRtSyehwByEWMZ+u2aFmyxmQHgeyoDo/fbrdaB6858txyxbZpUyRzq?=
 =?us-ascii?Q?JdL66qC4bwGdeyt8W4J3mZoAA+5R1XbN4W9xnaFPLbnzyREU5jhR5RSB2Z7o?=
 =?us-ascii?Q?MnlDDkU0gP4WsiWyvcawid8qUHNwOsXmLXewwfiAh/9kXbvwgISWVTsiLMIp?=
 =?us-ascii?Q?0crdkm/QI+OCDPcN25ll0Own9bMvv9jjfbFz0G+4kc5hF4V6GwNeMGLatVFD?=
 =?us-ascii?Q?0r9YJwQ+lEhXy6a/ure+AnQVH2lpgrY5F3SFcBz5cOwTVCR8EBF3LQQiufHI?=
 =?us-ascii?Q?Fc2zxYeRZVc7GPaGyLLiUxnMJ3p2eRRoGo1XZoja+wssq44sWt0pifwkPNOS?=
 =?us-ascii?Q?EDDWowxNxbsVysVmSi/EKBp9APgYlrE+X25nZYeWyuqjiEyPX4v9Ukz1RHfE?=
 =?us-ascii?Q?nSWWaPXen2pwwKy+N42gbWnAVSLp2XQkWjutKDUYs0DfOOd0C9MzWLcb82AQ?=
 =?us-ascii?Q?nbfYw5yMCQxeD/78VS53iuTKUbDJpxDjIpI9MVk5v+YM4lBHEPulyh2Pst5M?=
 =?us-ascii?Q?BCmv3rL3QEmRcihQMbTuQ3gjX0UIxs0bsTG9SHclLFTmBXF556+UTwwxhlxk?=
 =?us-ascii?Q?iOtV5t7YOwOmrn9G/pjeXrMg3BWidqLi4JnWHP7qKcUCP3UDNVbOihjDCs3U?=
 =?us-ascii?Q?K0FA/hs/0DuuU38X/CIzOF/YtlWssOHV9wQLrYwIQIzlYPUSN9JkxY5SAClg?=
 =?us-ascii?Q?+PxQMO448HrZIQ7vWBjabF24Uq7AWJ4W34Sg/MLvS8AT0KlIA2xnB/ccvBXS?=
 =?us-ascii?Q?FXoStp8N/daQF3Cx8EtxA4ljTx/majmZLFHKf9TXN8wKDBrxpcFdalYQ7JCS?=
 =?us-ascii?Q?OfYr6joDZYvQCrlJeE25L4LuE5+KkPs0bz9NEay4ncKIcaeSYqkpnnBBBS+Y?=
 =?us-ascii?Q?rN/xsx7BWY+db8Ed2fnFuZ8hujZGUVSBM9jZaVYOmtKnov131XbP2shEBzTz?=
 =?us-ascii?Q?7SDbDIbOosACOjSU6B+KTrRXnVHQsi8ZX3qYgiCq31E5xAP8wIbpasuHHwTX?=
 =?us-ascii?Q?l8smd+FxT+P9lV4CAlFMCiDoO+8jue3c67nf13f/uQSdnawxTPA0iRBFvVGK?=
 =?us-ascii?Q?Tx0OjiByut65CAYqBYe1F1Z/taMIA4jQCVbz+NYSEzboUIxKqSDpnsF57ltJ?=
 =?us-ascii?Q?hQ46TEH6auVRwr9qp8w0dXDS8xU/36d6bKIsOmN71k4P0mVeoDzVrsCKD7yO?=
 =?us-ascii?Q?wo8WaywHZEbBcYWqUZA6s2LjMZxlWsJAzRuOL2S7vZxV0uGy0P7wHqOIth2N?=
 =?us-ascii?Q?aWDjhKJO9zBSgt739jWD7iMYR6W37hmu5WB9l2oOTazM4S9gMPA91Vw7otrH?=
 =?us-ascii?Q?tooicfhabZ8F3ElgVPy0sbp64fSFvvi/cNi2a3kdkPOTTpUNViqdarlxjH82?=
 =?us-ascii?Q?37zRg3QHnsphbSe2DpZfND8tXMf0E+Eo+S/PCoy0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee04434c-e822-4d57-707d-08dd17fc0c08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 02:49:06.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOOsb+5uf1o3755cnua3Q/kEPZckScOLtU+jr1TtI7HbR+qDc1uzYWprDu7KDMbkcSfTZRr/F4ZsGxJ+2kyaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316

On Tue, Dec 03, 2024 at 08:00:38PM +0000, Cristian Marussi wrote:
>Using the pattern 'scmi-protocol-0x<PROTO_ID>-<VEND_ID>' as MODULE_ALIAS
>allows the SCMI core to autoload this protocol, if built as a module, when
>its protocol operations are requested by an SCMI driver.
>
>Cc: Peng Fan <peng.fan@nxp.com>
>Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>---

Acked-by: Peng Fan <peng.fan@nxp.com>

