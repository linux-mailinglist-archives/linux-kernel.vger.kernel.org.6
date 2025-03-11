Return-Path: <linux-kernel+bounces-556432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA43A5C890
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C481897186
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760225EF90;
	Tue, 11 Mar 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cc/++kBO"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072.outbound.protection.outlook.com [40.107.103.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C825E824;
	Tue, 11 Mar 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707631; cv=fail; b=Hb+kUkDjpeZxb7kBhvKbFu5SpgZb+ESAx1ZwrbJ8ZVb1Jtf5Rw1YR1MZvQms/1K//m1M0zatrqIRGQ8Qk0L5OuAExkEQ5POKgoeLDLt8wkfLrXZGOJO9MuluIb8nEwiE14+SI9+FLQOB1sBpvVcCjSsHgGjx8HayzKe05dJ/Baw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707631; c=relaxed/simple;
	bh=ZdA6PYpeVC5XBceP8+eH1AjqKQ41dUJHNz9grn7Cw8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gS77HV8OPyWB/THD1+tzriDi5KhVSAEIG4IPecFAPif/iTnafU5U8g/qZyaFDC89jYKOcmbcgNHgdDSc9c80IR+8FTmHOdBEPVTWhP2gQpVqo8n8BvQU6cI7HhiGuBo8DotT3esLqb++qYIS7HcB0IfYp3hcyrAyTX7Q3i6CiZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cc/++kBO; arc=fail smtp.client-ip=40.107.103.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHQCH8k+BOjd9Hbw61rJsuozaNdyGyDRFM8FJYyubOBpeWMhLwnmYJqNTtFTppvUv3/QzhMTEpXl6gsav2duVPOlUHdzoCsLex8SN/XpAfLqbI5dV+iVUYEnrGhyx9TEi3SAbDM9otIp+hd6e2jE9TtAdf0XSk0ESOCDbTUb3nFgH3XVGMrVnIcbhfvgXTgNKTBKicQWd0Ut+RfUOO73OhoK95JMl1pntGobOUW9ctLIfhLGHqDlY5t+ehkDIY16UWjoyp38Jw+wqssNA5fZkm7scOP/kZjpAy06IYqTlVxiZbC26ZjxY8IIjvMHmiTlfP6pRwVLGrhIZCe9qUA/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+61IMZVr+wvWNJEOIMg3ZTM5/nh+i9zXVcL7Gwz5D0=;
 b=lIBQGmHKkXJxdB9ovcsBUCEZc7EI0IAwkHso2CGwLyz9daE3EkM098qxgGvK6elAyhp/UB78zmqiNF/X0NG5JAMKoO6ClF/whebjO67qTxV1aYhXlaDx/bQQvaag2GUoNsXBq7+upXmGB4W2Yn4nqHDaJk1R8XAU3k4VvaNnhLJSGWfSSbYT3GUCM1FSH246gOuWz1DquFi/40A0HWymcoZq5RhrcIDX2gsap8KaCvHja3T91ps4DIV9XX8JkB/QbjTq6a3rMTDqLNkv3CwjI8VRdE7lEWD0xBy4aAqxeFwBBVz3v4LoZM33QRCEUOUU6xvXOZ1av2rhGNyMoye3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+61IMZVr+wvWNJEOIMg3ZTM5/nh+i9zXVcL7Gwz5D0=;
 b=Cc/++kBOvQC37KPUClWqJLejPVb0Gv3GqqCVMLThjJyDjB90yxMnaTGUVIbyXwSlFy8PlbeFd6XWE/237mMIi5xvj+jcMFBpozFpPljSqIyE3xbPTCnOJFLtNCOSMc68KtYarYIsy9ZR1JVKYuAYWqZxAQAtsUIqk3v/1o5qVeGToWQHTYRR+OP21u8l+4sMYDW4ADMj1Mm7eoDHDeHkx6BMVBsBynNjZErFSdnYIKyo2xRN1G6VL01nl3YGfPrkFQ3vYx9yGKe9LLk3v1vHjOXhJzptbqL5mqZMVrl6j1nkDt/m452jNsyKNLa21WIf4nVxsdEijE+zKUk9sEnTUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 15:40:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:40:23 +0000
Date: Tue, 11 Mar 2025 11:40:13 -0400
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
Subject: Re: [PATCH v13 4/5] firmware: imx: add driver for NXP EdgeLock
 Enclave
Message-ID: <Z9BZXVCpNlxWQgVd@lizhi-Precision-Tower-5810>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
 <20250311-imx-se-if-v13-4-9cc6d8fd6d1c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-imx-se-if-v13-4-9cc6d8fd6d1c@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a41493-72a4-48d3-686c-08dd60b30930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZhO+atHiSfGDauuI5mW2YL38m50OcO+nF86oSUsGyaayGs8LT1kcs2EBTqj?=
 =?us-ascii?Q?5KUhLmPwOM+G/1E1rhqd5sphmBGQLtdVdiifwYIZ4EjRFrJ2XXCOCUcb5J6v?=
 =?us-ascii?Q?MD/gVEWuTgzp07XyiDNE4eJrxBBMBkVhYkWdabi6kFV+SuRwGMMegxLsUDjC?=
 =?us-ascii?Q?a1+MMGb536pA4XP+xnchkbrd0d9VqRef7mYvwIAlewCxhgMH3eSdCjk/ptWg?=
 =?us-ascii?Q?CF5BJtoBM+5ePJZvteLvxtnkUkahbGwfBeKahaxMD5mD+22+MHgVABe7iWib?=
 =?us-ascii?Q?tH8OC4VIlWYkp09oxobldkHdkA+XRPBy+85XCH/IVb5gYu3pbago/0/v7acB?=
 =?us-ascii?Q?5oPoLgh6dKGmoIhVxVK6v8deUsdrLQz10lA/Z8VBcmEGUkrZ2Q683znsTThT?=
 =?us-ascii?Q?1DUuHCQN2g8tbyaGfHr+vcdwVCmp9GFbSz3vOsBAqTPnDdoJXDYbaOEpyE9j?=
 =?us-ascii?Q?bk9xEquL+8775+O/jw9GwEnHiJdh1k5xdVVFHltbsF5vx2hipeWGnwnCszqA?=
 =?us-ascii?Q?9WOEywo9um2Z4JTFbOuOfxjY/YNJCkAcmYbQZyNEp5AgCyrx/pbxz52uZhjH?=
 =?us-ascii?Q?inNRAX4XmeFB6hJzWZsFO6nHMPgaXt3ysXA+/PJ2hfupKv9iv58tpyaK3Pgj?=
 =?us-ascii?Q?8DwUqGlwJ8tY22cfjTKPBRZkBlXqf/R/uv1Dvo5WAcuQrw4QGYy3eVON1ogE?=
 =?us-ascii?Q?MgY44uCY37vvmxZSRxU1/112t84Jz6cAsZTGSegBXCJkYot/2F+H2nOmTpNW?=
 =?us-ascii?Q?p30vCvoiNkt7pxMrntSF/HEBXId+ZulVSMvF0C5hkx3jNLoJ3l+xQfVPCiPN?=
 =?us-ascii?Q?OI+irtFBsA5zVm31Ww4wcVwNLFBforJ6iIu0Ko3VgJvECUlW0GELWkJYLr8/?=
 =?us-ascii?Q?7HixIrTqMaxaOi1JIs3uOaf0PUGqMWoVPErYmIoaRDZlTC+NCBGWYPEHczsc?=
 =?us-ascii?Q?aChflKvHWHf4Bt077lxz+uhnoXTiRL83XdR2hEcQ+uQS5Em9WGrxlpVHaUcj?=
 =?us-ascii?Q?W02KpU8NM1b3bHsgf2FAiSnefof9C/2AlJwz0ryhFjf6hFhFAZ1xkaAsWFJR?=
 =?us-ascii?Q?MIVxkiokehf18mpIl8291VF3BXxrcVNW+6wYsi/O9aHB3g713tXDtOlusmBP?=
 =?us-ascii?Q?/F0z+LxdpB+nV0+u/hbsNMa5D4Lwav6AoY5B1yi7TdZh87uVVHHZCrXddm1p?=
 =?us-ascii?Q?/42Sd9WaZo4lPpwMnkwQh8ltCCmwnoGVveCfEZH+bJjMhFquk0E7TI6RX62j?=
 =?us-ascii?Q?to/NEGCesiIs4x+p7oJ9ZkiJBTy1pU2fVKlaYdyPJpmErbMCsj/Rfts3lnda?=
 =?us-ascii?Q?rpZyJ+FyBKxsbvEOeTtaHWCyvmzFZjvKAibUzGt+62oF+iA8l+Rhcux8/5S1?=
 =?us-ascii?Q?9ZPuurMgouDI+i0qcuIoqKCjCC3b7lomIkyFLGUiU5KlaJzqSI3RHmfhcK97?=
 =?us-ascii?Q?rhVz1+5OsS4ZaDY9uODOJMqHZ3nL55Am?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ak8hFVkFu7iyoLkxLSFuqWBp9P0kNJ1DXQtjqNoNAmj5kQMTEC6+Smb5ikMH?=
 =?us-ascii?Q?AoWMX7smo6p4EgWd/CEsW0i1QT9uXiffcorBRY/Etk5EdUd0TudyfoiyzeQN?=
 =?us-ascii?Q?abjFzV9lh068LCOZXsE+U20uxNCuYH/C7QmKm/hEJr9aJpJcKZT4lw0wdZg9?=
 =?us-ascii?Q?F48I8md1j2JRUzclkJjsBl3+2MKyFXy6s7WP2QoNlAloZz+Gg7jTEyZf8W3K?=
 =?us-ascii?Q?vuRNLXo9vVXT7oL6m0ZuCulaG0m4hNJ6lApQ0HceMn+/7boHeflXOlIG7OJv?=
 =?us-ascii?Q?zxat0RliXJUV0g2ODQ/IZi6aj5EuFNr4TEqjiSVFwjGdINA2zE8k6kVEyS2s?=
 =?us-ascii?Q?JrGFAmcXBWIWoMAGeUTJ970aQ/U+etrjowZ9vxtNOo51ht2+2xdWGsEJmbHY?=
 =?us-ascii?Q?phb+ZtB7QkrCBM/CqEwd4OQru8J1T1QbaX/u5hCVeUgEMPTPHs5x67uecIet?=
 =?us-ascii?Q?DVXxUHNLsEbIlvpcbRKAHgS8XnXhKPJVe7gwCgHP+nat09JIJJb5c0BnHsF5?=
 =?us-ascii?Q?bI1j8wEsjDYJ2wz9mfiuGjsVuln4PRiU7sG2/6K3CIF0YYKFjaFGL0Ho0R7b?=
 =?us-ascii?Q?HL5FadA7YNvDJIRseGyiFyVkLdkPW4YiI1JXyESS9Y8jGCc5P8Zsdy8POBUn?=
 =?us-ascii?Q?v/p3/aWBSHACYrLmQIbyjX2vJdjmkKuMlVQt26qYVVWSBZtROptR1GC0cRmr?=
 =?us-ascii?Q?7kL4RO9rf4S9E53//jnSVhe7GuSGtSbiZ09EyTaC1XUE1mj1S+YUgLm8Y/3t?=
 =?us-ascii?Q?bfdJcPLxOymcAstAr2mR7T0hqFRrmeGVW9TuJTJ9heKk2O/cMMogA/3IvGrk?=
 =?us-ascii?Q?pk6hS59PpfRZ6jAn5RIeg3GvF5qgpPdiAgtBsBmhPuT6mRzpIhQ7Bs8SXq6a?=
 =?us-ascii?Q?l+anS8eriVhZnJAgct2gdjl18m8Nda+kaCcqHINZlram4eyBPrhp22+7Hwcs?=
 =?us-ascii?Q?opX7EqGa8IStwmNuVjd+252rMp2lKGCPIR8Leuuv6Ln7qpVijnY2s4fAiV4H?=
 =?us-ascii?Q?r7v/kUPBI/a4ftR6JDUTqdcVfQTru8oA2pX67nGTxNR7xfK7xsqGPaZ5JHKn?=
 =?us-ascii?Q?zv9YLrYfQif0zgIk5tSLB4ZVtiMgBwd1cmWi0d+bqtMeVckFHLN7MKp+TCmv?=
 =?us-ascii?Q?ligBVWVhioLncS/ZxwyrlrfSOQSJf+9inS72xXGMrCrU0bcBbGxmpE5aYikh?=
 =?us-ascii?Q?FXrLkz9+EQHyh4bPjB1g5IRiPD6zSmq/5NtUegLBBU28u8rD2FG5vmdGngPi?=
 =?us-ascii?Q?A9ZDFrc0FdlXNaWixVTJ68JOokiUniFLDRXu4oO5AfiRoQ72Jm5Uug0wodAr?=
 =?us-ascii?Q?EIe0wVZPAP439xWpMffyvNsKY5wsENuDBRWmu9897OHOS+D8U7fuM6G8rlNh?=
 =?us-ascii?Q?LLHbhEsuY/uAcnwKN+8v3H937yzus9VLZfNlbtO3VQHUEqoPLagTdkL/oL6M?=
 =?us-ascii?Q?Va3UTYUFIg9fqlcEAIoSMQtlCxorE/8+vqQ2tqEn+Y12P96xvpB7lqER05KL?=
 =?us-ascii?Q?yEOLvH7+F6t/Y3O6nCpa0seQ48c6etfqwfjwYayVdmRwVX2B5sikbP8FHsyT?=
 =?us-ascii?Q?IUzXcGop/B4lY7T8Z2g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a41493-72a4-48d3-686c-08dd60b30930
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:40:23.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlatXgD/K/BSrVId5F/pExZUf1/CXwjRg913uqQOgYaWJxQeqjH4pb0AdhNEUQVw7Opk7uoL3fC+MQaF2e0KZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866

On Tue, Mar 11, 2025 at 09:09:35PM +0530, Pankaj Gupta wrote:
> Add driver for enabling MU based communication interface to secure-enclave.
>
> NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
> are embedded in the SoC to support the features like HSM, SHE & V2X,
> using message based communication interface.
>
> The secure enclave FW communicates with Linux over single or multiple
> dedicated messaging unit(MU) based interface(s).
> Exists on i.MX SoC(s) like i.MX8ULP, i.MX93, i.MX95 etc.
>
> Other dependent kernel drivers will be:
> - NVMEM: that supports non-volatile devices like EFUSES,
>          managed by NXP's secure-enclave.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/firmware/imx/Kconfig        |  13 +
>  drivers/firmware/imx/Makefile       |   2 +
>  drivers/firmware/imx/ele_base_msg.c | 372 ++++++++++++++++++++++++++
>  drivers/firmware/imx/ele_base_msg.h |  98 +++++++
>  drivers/firmware/imx/ele_common.c   | 329 +++++++++++++++++++++++
>  drivers/firmware/imx/ele_common.h   |  50 ++++
>  drivers/firmware/imx/se_ctrl.c      | 503 ++++++++++++++++++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h      |  83 ++++++
>  include/linux/firmware/imx/se_api.h |  14 +
>  9 files changed, 1464 insertions(+)
>
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index c964f4924359..8a487df77976 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -33,3 +33,16 @@ config IMX_SCMI_MISC_DRV
>  	  core that could provide misc functions such as board control.
>
>  	  This driver can also be built as a module.
> +
> +config IMX_SEC_ENCLAVE
> +	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
> +	depends on IMX_MBOX && ARCH_MXC && ARM64
> +	select FW_LOADER
> +	default m if ARCH_MXC
> +
> +	help
> +	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
> +	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> +	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
> +	    Unit. This driver exposes these interfaces via a set of file descriptors
> +	    allowing to configure shared memory, send and receive messages.
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 8d046c341be8..4e1d2706535d 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -2,3 +2,5 @@
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
>  obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
> +sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
> +obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> new file mode 100644
> index 000000000000..eea86f50d276
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/types.h>
> +
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/genalloc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +#define FW_DBG_DUMP_FIXED_STR		"\nELEX: "
> +
> +int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
> +{
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	dma_addr_t get_info_addr = 0;
> +	u32 *get_info_data = NULL;
> +	int ret = 0;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	memset(s_info, 0x0, sizeof(*s_info));
> +
> +	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
> +	if (!tx_msg)
> +		return -ENOMEM;
> +
> +	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg)
> +		return -ENOMEM;
> +
> +	if (priv->mem_pool)
> +		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
> +						   ELE_GET_INFO_BUFF_SZ,
> +						   &get_info_addr);
> +	else
> +		get_info_data = dma_alloc_coherent(priv->dev,
> +						   ELE_GET_INFO_BUFF_SZ,
> +						   &get_info_addr,
> +						   GFP_KERNEL);
> +	if (!get_info_data) {
> +		dev_dbg(priv->dev,
> +			"%s: Failed to allocate get_info_addr.\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  (struct se_msg_hdr *)&tx_msg->header,
> +				  ELE_GET_INFO_REQ,
> +				  ELE_GET_INFO_REQ_MSG_SZ,
> +				  true);
> +	if (ret)
> +		goto exit;
> +
> +	tx_msg->data[0] = upper_32_bits(get_info_addr);
> +	tx_msg->data[1] = lower_32_bits(get_info_addr);
> +	tx_msg->data[2] = sizeof(*s_info);
> +	ret = ele_msg_send_rcv(priv,
> +			       tx_msg,
> +			       ELE_GET_INFO_REQ_MSG_SZ,
> +			       rx_msg,
> +			       ELE_GET_INFO_RSP_MSG_SZ);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      rx_msg,
> +				      ELE_GET_INFO_REQ,
> +				      ELE_GET_INFO_RSP_MSG_SZ,
> +				      true);
> +
> +	memcpy(s_info, get_info_data, sizeof(*s_info));
> +
> +exit:
> +	if (priv->mem_pool)
> +		gen_pool_free(priv->mem_pool,
> +			      (u64)get_info_data,
> +			      ELE_GET_INFO_BUFF_SZ);
> +	else
> +		dma_free_coherent(priv->dev,
> +				  ELE_GET_INFO_BUFF_SZ,
> +				  get_info_data,
> +				  get_info_addr);
> +
> +	return ret;
> +}
> +
> +int ele_fetch_soc_info(struct se_if_priv *priv, void *data)
> +{
> +	int err;
> +
> +	err = ele_get_info(priv, data);
> +	if (err < 0)
> +		return err;
> +
> +	return err;

any way you return err.

you can simple

	return ele_get_info(priv, data);

why need ele_fetch_soc_info() if it is simple wrap ele_get_info() ?

> +}
> +
> +int ele_ping(struct se_if_priv *priv)
> +{
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg)
> +		return -ENOMEM;
> +
> +	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
> +	if (!rx_msg)
> +		return -ENOMEM;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  (struct se_msg_hdr *)&tx_msg->header,
> +				  ELE_PING_REQ, ELE_PING_REQ_SZ, true);
> +	if (ret) {
> +		dev_err(priv->dev, "Error: se_fill_cmd_msg_hdr failed.\n");
> +		return ret;
> +	}
> +
> +	ret = ele_msg_send_rcv(priv,
> +			       tx_msg,
> +			       ELE_PING_REQ_SZ,
> +			       rx_msg,
> +			       ELE_PING_RSP_SZ);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      rx_msg,
> +				      ELE_PING_REQ,
> +				      ELE_PING_RSP_SZ,
> +				      true);
> +
> +	return ret;
> +}
> +
> +int ele_service_swap(struct se_if_priv *priv,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag)
> +{
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
> +	if (!tx_msg)
> +		return -ENOMEM;
> +
> +	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg)
> +		return -ENOMEM;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  (struct se_msg_hdr *)&tx_msg->header,
> +				  ELE_SERVICE_SWAP_REQ,
> +				  ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
> +	if (ret)
> +		return ret;
> +
> +	tx_msg->data[0] = flag;
> +	tx_msg->data[1] = addr_size;
> +	tx_msg->data[2] = ELE_NONE_VAL;
> +	tx_msg->data[3] = lower_32_bits(addr);
> +	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
> +					 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> +	ret = ele_msg_send_rcv(priv,
> +			       tx_msg,
> +			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
> +			       rx_msg,
> +			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      rx_msg,
> +				      ELE_SERVICE_SWAP_REQ,
> +				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
> +				      true);
> +	if (ret)
> +		return ret;
> +
> +	if (flag == ELE_IMEM_EXPORT)
> +		ret = rx_msg->data[1];
> +	else
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
> +{
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int ret = 0;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg)
> +		return -ENOMEM;
> +
> +	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
> +	if (!rx_msg)
> +		return -ENOMEM;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  (struct se_msg_hdr *)&tx_msg->header,
> +				  ELE_FW_AUTH_REQ,
> +				  ELE_FW_AUTH_REQ_SZ,
> +				  true);
> +	if (ret)
> +		return ret;
> +
> +	tx_msg->data[1] = upper_32_bits(addr);
> +	tx_msg->data[0] = lower_32_bits(addr);
> +	tx_msg->data[2] = addr;
> +
> +	ret = ele_msg_send_rcv(priv,
> +			       tx_msg,
> +			       ELE_FW_AUTH_REQ_SZ,
> +			       rx_msg,
> +			       ELE_FW_AUTH_RSP_MSG_SZ);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = se_val_rsp_hdr_n_status(priv,
> +				      rx_msg,
> +				      ELE_FW_AUTH_REQ,
> +				      ELE_FW_AUTH_RSP_MSG_SZ,
> +				      true);
> +	return ret;
> +}
> +
> +int ele_debug_dump(struct se_if_priv *priv)
> +{
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	bool keep_logging;
> +	u8 dump_data[408];
> +	u8 fmt_str[256];
> +	int fmt_str_idx;
> +	int rcv_dbg_wd_ct;
> +	int msg_ex_cnt;
> +	int ret = 0;
> +	int w_ct;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	tx_msg = kzalloc(ELE_DEBUG_DUMP_REQ_SZ, GFP_KERNEL);
> +	if (!tx_msg)
> +		return -ENOMEM;
> +
> +	rx_msg = kzalloc(ELE_DEBUG_DUMP_RSP_SZ, GFP_KERNEL);
> +	if (!rx_msg)
> +		return -ENOMEM;
> +
> +	ret = se_fill_cmd_msg_hdr(priv,
> +				  &tx_msg->header,
> +				  ELE_DEBUG_DUMP_REQ,
> +				  ELE_DEBUG_DUMP_REQ_SZ,
> +				  true);
> +	if (ret)
> +		return ret;
> +
> +	msg_ex_cnt = 0;
> +	do {
> +		w_ct = 0;
> +		fmt_str_idx = 0;
> +		memset(rx_msg, 0xCC, ELE_DEBUG_DUMP_RSP_SZ);
> +
> +		ret = ele_msg_send_rcv(priv,
> +				       tx_msg,
> +				       ELE_DEBUG_DUMP_REQ_SZ,
> +				       rx_msg,
> +				       ELE_DEBUG_DUMP_RSP_SZ);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = se_val_rsp_hdr_n_status(priv,
> +					      rx_msg,
> +					      ELE_DEBUG_DUMP_REQ,
> +					      ELE_DEBUG_DUMP_RSP_SZ,
> +					      true);
> +		if (!ret) {
> +			rcv_dbg_wd_ct = rx_msg->header.size - ELE_NON_DUMP_BUFFER_SZ;
> +			memcpy(fmt_str, FW_DBG_DUMP_FIXED_STR, strlen(FW_DBG_DUMP_FIXED_STR));
> +			fmt_str_idx += strlen(FW_DBG_DUMP_FIXED_STR);
> +			for (w_ct = 0; w_ct < rcv_dbg_wd_ct; w_ct++) {
> +				fmt_str[fmt_str_idx] = '0';
> +				fmt_str_idx++;
> +				fmt_str[fmt_str_idx] = 'x';
> +				fmt_str_idx++;
> +				fmt_str[fmt_str_idx] = '%';
> +				fmt_str_idx++;
> +				fmt_str[fmt_str_idx] = '0';
> +				fmt_str_idx++;
> +				fmt_str[fmt_str_idx] = '8';
> +				fmt_str_idx++;
> +				fmt_str[fmt_str_idx] = 'x';
> +				fmt_str_idx++;
> +				fmt_str[fmt_str_idx] = ' ';
> +				fmt_str_idx++;
> +				if (w_ct % 2) {
> +					memcpy(fmt_str + fmt_str_idx,
> +					       FW_DBG_DUMP_FIXED_STR,
> +					       strlen(FW_DBG_DUMP_FIXED_STR));
> +					fmt_str_idx += strlen(FW_DBG_DUMP_FIXED_STR);
> +				}
> +			}
> +			keep_logging = (rx_msg->header.size < (ELE_DEBUG_DUMP_RSP_SZ >> 2)) ?
> +					false : true;
> +			keep_logging = keep_logging ?
> +						(msg_ex_cnt > ELE_MAX_DBG_DMP_PKT ? false : true) :
> +						false;
> +			/*
> +			 * Number of spaces = rcv_dbg_wd_ct
> +			 * DBG dump length in bytes = rcv_dbg_wd_ct * 4
> +			 *
> +			 * Since, one byte is represented as 2 character,
> +			 * DBG Dump string-length = rcv_dbg_wd_ct * 8
> +			 * Fixed string's string-length =
> +			 *                      strlen(FW_DBG_DUMP_FIXED_STR) * rcv_dbg_wd_ct
> +			 *
> +			 * Total dump_data length = Number of spaces +
> +			 *                          DBG Dump string' string-length +
> +			 *                          Fixed string's string-length
> +			 *
> +			 * Total dump_data length = rcv_dbg_wd_ct + (rcv_dbg_wd_ct * 8) +
> +			 *                          strlen(FW_DBG_DUMP_FIXED_STR) * rcv_dbg_wd_ct
> +			 */
> +
> +			snprintf(dump_data,
> +				 ((rcv_dbg_wd_ct * 9) +
> +				  (strlen(FW_DBG_DUMP_FIXED_STR) * rcv_dbg_wd_ct)),
> +				  fmt_str,
> +				  rx_msg->data[1], rx_msg->data[2],
> +				  rx_msg->data[3], rx_msg->data[4],
> +				  rx_msg->data[5], rx_msg->data[6],
> +				  rx_msg->data[7], rx_msg->data[8],
> +				  rx_msg->data[9], rx_msg->data[10],
> +				  rx_msg->data[11], rx_msg->data[12],
> +				  rx_msg->data[13], rx_msg->data[14],
> +				  rx_msg->data[15], rx_msg->data[16],
> +				  rx_msg->data[17], rx_msg->data[18],
> +				  rx_msg->data[19], rx_msg->data[20]);
> +
> +			dev_err(priv->dev, "%s", dump_data);

I don't suggest construct format string, which will lost compiler check
and make code logic complex. can you directly use

	dev_err(priv->dev, "0x%08x ...", rx_msg->data[1], ...);



> +		} else {
> +			dev_err(priv->dev, "Dump_Debug_Buffer Error: %x.", ret);
> +			break;
> +		}
> +		msg_ex_cnt++;
> +	} while (keep_logging);
> +
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
> new file mode 100644
> index 000000000000..b8c9d9e29ae8
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + *
> + * Header file for the EdgeLock Enclave Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#include "se_ctrl.h"
> +
> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_GET_INFO_REQ		0xDA

Look like most people like low case hex number.

> +#define ELE_GET_INFO_REQ_MSG_SZ		0x10
> +#define ELE_GET_INFO_RSP_MSG_SZ		0x08
> +
> +#define SOC_ID_MASK			0x0000FFFF

use GEN_MASK

> +
> +#define MAX_UID_SIZE                     (16)
> +#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
> +#define DEV_GETINFO_FW_SHA_SZ            (32)
> +#define DEV_GETINFO_OEM_SRKH_SZ          (64)
> +#define DEV_GETINFO_MIN_VER_MASK	0xFF
> +#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
> +#define ELE_DEV_INFO_EXTRA_SZ		0x60
> +
> +struct dev_info {
> +	u8  cmd;
> +	u8  ver;
> +	u16 length;
> +	u16 soc_id;
> +	u16 soc_rev;
> +	u16 lmda_val;
> +	u8  ssm_state;
> +	u8  dev_atts_api_ver;
> +	u8  uid[MAX_UID_SIZE];
> +	u8  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
> +	u8  sha_fw[DEV_GETINFO_FW_SHA_SZ];
> +};
> +
> +struct dev_addn_info {
> +	u8  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
> +	u8  trng_state;
> +	u8  csal_state;
> +	u8  imem_state;
> +	u8  reserved2;
> +};
> +
> +struct ele_dev_info {
> +	struct dev_info d_info;
> +	struct dev_addn_info d_addn_info;
> +};
> +
> +#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
> +						+ ELE_DEV_INFO_EXTRA_SZ)
> +
> +#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
> +	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
> +
> +#define ELE_MAX_DBG_DMP_PKT		30
> +#define ELE_NON_DUMP_BUFFER_SZ		3
> +#define ELE_DEBUG_DUMP_REQ		0x21
> +#define ELE_DEBUG_DUMP_REQ_SZ		0x4
> +#define ELE_DEBUG_DUMP_RSP_SZ		0x5C
> +
> +#define ELE_PING_REQ			0x01
> +#define ELE_PING_REQ_SZ			0x04
> +#define ELE_PING_RSP_SZ			0x08
> +
> +#define ELE_SERVICE_SWAP_REQ		0xDF
> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
> +#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +#define ELE_IMEM_EXPORT			0x1
> +#define ELE_IMEM_IMPORT			0x2
> +
> +#define ELE_FW_AUTH_REQ			0x02
> +#define ELE_FW_AUTH_REQ_SZ		0x10
> +#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
> +
> +int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info);
> +int ele_fetch_soc_info(struct se_if_priv *priv, void *data);
> +int ele_ping(struct se_if_priv *priv);
> +int ele_service_swap(struct se_if_priv *priv,
> +		     phys_addr_t addr,
> +		     u32 addr_size, u16 flag);
> +int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr);
> +int ele_debug_dump(struct se_if_priv *priv);
> +#endif
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> new file mode 100644
> index 000000000000..3fa8182b302f
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +
> +u32 se_add_msg_crc(u32 *msg, u32 msg_len)

Need comments why common crc library doesn't work for you.

> +{
> +	u32 nb_words = msg_len / (u32)sizeof(u32);

u32 nb_words = msg_len / sizeof(u32);

what's happen if msg_len % 4 != 0 ?

> +	u32 crc = 0;
> +	u32 i;
> +
> +	for (i = 0; i < nb_words - 1; i++)
> +		crc ^= *(msg + i);
> +
> +	return crc;
> +}
> +
> +int ele_msg_rcv(struct se_if_priv *priv,
> +		struct se_clbk_handle *se_clbk_hdl)
> +{
> +	int err = 0;
> +
> +	do {
> +		err = wait_for_completion_interruptible(&se_clbk_hdl->done);

Suggest add timeout to avoid possible deadlock.

> +		if (err == -ERESTARTSYS) {
> +			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
> +				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
> +				continue;
> +			}
> +			dev_err(priv->dev,
> +				"Err[0x%x]:Interrupted by signal.\n",
> +				err);
> +			err = -EINTR;
> +			break;
> +		}
> +	} while (err != 0);
> +
> +	return err ? err : se_clbk_hdl->rx_msg_sz;
> +}
> +
> +int ele_msg_send(struct se_if_priv *priv,
> +		 void *tx_msg,
> +		 int tx_msg_sz)
> +{
> +	struct se_msg_hdr *header;

small tuning, struct se_msg_hdr *header = tx_msg;

> +	int err;
> +
> +	header = tx_msg;
> +
> +	/*
> +	 * Check that the size passed as argument matches the size
> +	 * carried in the message.
> +	 */
> +	if (header->size << 2 != tx_msg_sz) {
> +		dev_err(priv->dev,
> +			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			*(u32 *)header,
> +			header->size << 2, tx_msg_sz);
> +		return -EINVAL;
> +	}
> +
> +	err = mbox_send_message(priv->tx_chan, tx_msg);
> +	if (err < 0) {
> +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		return err;
> +	}
> +	err = tx_msg_sz;
> +
> +	return err;

return tx_msg_sz;

> +}
> +
> +/* API used for send/receive blocking call. */
> +int ele_msg_send_rcv(struct se_if_priv *priv,
> +		     void *tx_msg,
> +		     int tx_msg_sz,
> +		     void *rx_msg,
> +		     int exp_rx_msg_sz)
> +{
> +	int err;
> +
> +	guard(mutex)(&priv->se_if_cmd_lock);
> +
> +	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
> +	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
> +
> +	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
> +	if (err < 0)
> +		return err;
> +
> +	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
> +
> +	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
> +		err = -EINTR;
> +		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
> +		dev_err(priv->dev,
> +			"Err[0x%x]:Interrupted by signal.\n",
> +			err);

small, tuning, 'err' can move to previous line, code allow wrap at 100 chars.

> +	}
> +
> +	return err;
> +}
> +
> +static bool exception_for_size(struct se_if_priv *priv,
> +			       struct se_msg_hdr *header)

look like check_header() make sense because you not only check size.

> +{
> +	/* List of API(s) that can be accepte variable length
> +	 * response buffer.
> +	 */
> +	if (header->command == ELE_DEBUG_DUMP_REQ &&
> +	    header->ver == priv->if_defs->base_api_ver &&
> +	    header->size >= 0 &&
> +	    header->size <= ELE_DEBUG_DUMP_RSP_SZ)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Callback called by mailbox FW, when data is received.
> + */
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> +{
> +	struct se_clbk_handle *se_clbk_hdl;
> +	struct device *dev = mbox_cl->dev;
> +	struct se_msg_hdr *header;
> +	struct se_if_priv *priv;
> +	u32 rx_msg_sz;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	/* The function can be called with NULL msg */
> +	if (!msg) {
> +		dev_err(dev, "Message is invalid\n");
> +		return;
> +	}
> +
> +	header = msg;
> +	rx_msg_sz = header->size << 2;
> +
> +	/* Incoming command: wake up the receiver if any. */
> +	if (header->tag == priv->if_defs->cmd_tag) {
> +		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
> +		dev_dbg(dev,
> +			"Selecting cmd receiver for mesg header:0x%x.",
> +			*(u32 *)header);
> +
> +		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
> +		 * as the NVM command are initiated by FW.
> +		 * Size is revealed as part of this call function.
> +		 */
> +		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
> +			dev_err(dev,
> +				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
> +				*(u32 *)header,
> +				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> +
> +			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
> +		}
> +		se_clbk_hdl->rx_msg_sz = rx_msg_sz;
> +
> +	} else if (header->tag == priv->if_defs->rsp_tag) {
> +		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
> +		dev_dbg(dev,
> +			"Selecting resp waiter for mesg header:0x%x.",
> +			*(u32 *)header);
> +
> +		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
> +		    !exception_for_size(priv, header)) {
> +			dev_err(dev,
> +				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
> +				*(u32 *)header,
> +				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> +
> +			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
> +		}
> +	} else {
> +		dev_err(dev, "Failed to select a device for message: %.8x\n",
> +			*((u32 *)header));
> +		return;
> +	}
> +
> +	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
> +
> +	/* Allow user to read */
> +	complete(&se_clbk_hdl->done);
> +}
> +
> +int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> +			    struct se_api_msg *msg,
> +			    u8 msg_id,
> +			    u8 sz,
> +			    bool is_base_api)
> +{
> +	u32 status;
> +	struct se_msg_hdr *header = &msg->header;

struct se_msg_hdr *header = &msg->header;
u32 status;

> +
> +	if (header->tag != priv->if_defs->rsp_tag) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
> +			msg_id, header->tag, priv->if_defs->rsp_tag);
> +		return -EINVAL;
> +	}
> +
> +	if (header->command != msg_id) {
> +		dev_err(priv->dev,
> +			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
> +			header->command, msg_id);
> +		return -EINVAL;
> +	}
> +
> +	if (header->size != (sz >> 2) && !exception_for_size(priv, header)) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
> +			msg_id, header->size, (sz >> 2));
> +		return -EINVAL;
> +	}
> +
> +	if (is_base_api && header->ver != priv->if_defs->base_api_ver) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
> +			msg_id, header->ver, priv->if_defs->base_api_ver);
> +		return -EINVAL;
> +	} else if (!is_base_api && header->ver != priv->if_defs->fw_api_ver) {
> +		dev_err(priv->dev,
> +			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
> +			msg_id, header->ver, priv->if_defs->fw_api_ver);
> +		return -EINVAL;
> +	}
> +
> +	status = RES_STATUS(msg->data[0]);
> +	if (status != priv->if_defs->success_tag) {
> +		dev_err(priv->dev, "Command Id[%x], Response Failure = 0x%x",
> +			header->command, status);
> +		return -EPERM;
> +	}
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
> +{
> +	struct ele_dev_info s_info = {0};
> +	int ret;
> +
> +	ret = ele_get_info(priv, &s_info);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +
> +	/* Do not save the IMEM buffer, if the current IMEM state is BAD. */
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD)
> +		return ret;
> +
> +	/* EXPORT command will save encrypted IMEM to given address,
> +	 * so later in resume, IMEM can be restored from the given
> +	 * address.
> +	 *
> +	 * Size must be at least 64 kB.
> +	 */
> +	ret = ele_service_swap(priv,
> +			       imem->phyaddr,
> +			       ELE_IMEM_SIZE,
> +			       ELE_IMEM_EXPORT);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "Failed to export IMEM\n");
> +		imem->size = 0;
> +	} else {
> +		dev_info(priv->dev,
> +			 "Exported %d bytes of encrypted IMEM\n",
> +			 ret);
> +		imem->size = ret;
> +	}
> +
> +	return ret > 0 ? 0 : -1;

-1 suggest use err code.

> +}
> +
> +int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
> +{
> +	struct ele_dev_info s_info;
> +	int ret;
> +
> +	/* get info from ELE */
> +	ret = ele_get_info(priv, &s_info);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +	imem->state = s_info.d_addn_info.imem_state;
> +
> +	/* Get IMEM state, if 0xFE then import IMEM */
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD && imem->size) {
> +		/* IMPORT command will restore IMEM from the given
> +		 * address, here size is the actual size returned by ELE
> +		 * during the export operation
> +		 */
> +		ret = ele_service_swap(priv,
> +				       imem->phyaddr,
> +				       imem->size,
> +				       ELE_IMEM_IMPORT);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to import IMEM\n");
> +			return ret;
> +		}
> +	} else {
> +		return ret;
> +	}


if (!(s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD && imem->size)
	return ret; /* do nothing if not use IMEM */

ret = ele_service_swap()
if (ret) {
	pr_err(...);
	return ret;
}

> +
> +	/* After importing IMEM, check if IMEM state is equal to 0xCA
> +	 * to ensure IMEM is fully loaded and
> +	 * ELE functionality can be used.
> +	 */
> +	ret = ele_get_info(priv, &s_info);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to get info from ELE.\n");
> +		return ret;
> +	}
> +	imem->state = s_info.d_addn_info.imem_state;
> +
> +	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
> +		dev_info(priv->dev, "Successfully restored IMEM\n");
> +	else
> +		dev_err(priv->dev, "Failed to restore IMEM\n");
> +
> +	return ret;
> +}
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> new file mode 100644
> index 000000000000..aceb8c891ae6
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef __ELE_COMMON_H__
> +#define __ELE_COMMON_H__
> +
> +#include "se_ctrl.h"
> +
> +#define ELE_SUCCESS_IND			0xD6
> +
> +#define IMX_ELE_FW_DIR                 "imx/ele/"
> +
> +u32 se_add_msg_crc(u32 *msg, u32 msg_len);
> +int ele_msg_rcv(struct se_if_priv *priv,
> +		struct se_clbk_handle *se_clbk_hdl);
> +int ele_msg_send(struct se_if_priv *priv,
> +		 void *tx_msg,
> +		 int tx_msg_sz);
> +int ele_msg_send_rcv(struct se_if_priv *priv,
> +		     void *tx_msg,
> +		     int tx_msg_sz,
> +		     void *rx_msg,
> +		     int exp_rx_msg_sz);
> +void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
> +int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
> +			    struct se_api_msg *msg,
> +			    u8 msg_id,
> +			    u8 sz,
> +			    bool is_base_api);
> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
> +				      struct se_msg_hdr *hdr,
> +				      u8 cmd, u32 len,
> +				      bool is_base_api)
> +{
> +	hdr->tag = priv->if_defs->cmd_tag;
> +	hdr->ver = (is_base_api) ? priv->if_defs->base_api_ver : priv->if_defs->fw_api_ver;
> +	hdr->command = cmd;
> +	hdr->size = len >> 2;
> +
> +	return 0;
> +}
> +
> +int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
> +int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
> +
> +#endif /*__ELE_COMMON_H__ */
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> new file mode 100644
> index 000000000000..12a1ceb87866
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -0,0 +1,503 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/firmware.h>
> +#include <linux/firmware/imx/se_api.h>
> +#include <linux/genalloc.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#include "ele_base_msg.h"
> +#include "ele_common.h"
> +#include "se_ctrl.h"
> +
> +#define MAX_SOC_INFO_DATA_SZ		256
> +#define MBOX_TX_NAME			"tx"
> +#define MBOX_RX_NAME			"rx"
> +#define SE_TYPE_STR_HSM			"hsm"
> +#define SE_TYPE_ID_HSM			0x2
> +
> +struct se_fw_img_name {
> +	const u8 *prim_fw_nm_in_rfs;
> +	const u8 *seco_fw_nm_in_rfs;
> +};
> +
> +struct se_fw_load_info {
> +	const struct se_fw_img_name *se_fw_img_nm;
> +	bool is_fw_loaded;
> +	bool imem_mgmt;
> +	struct se_imem_buf imem;
> +};
> +
> +struct se_if_node {
> +	u8 se_if_id;
> +	u8 se_if_did;
> +	struct se_if_defines if_defs;
> +	u8 *pool_name;
> +	bool reserved_dma_ranges;
> +};
> +
> +/* contains fixed information */
> +struct se_soc_info {
> +	const u8 num_mu;
> +	const u16 soc_id;
> +	bool soc_register;
> +	int (*se_fetch_soc_info)(struct se_if_priv *priv, void *data);
> +	const struct se_fw_img_name se_fw_img_nm;
> +	const struct se_if_node if_node[];
> +};
> +
> +struct se_var_info {
> +	u16 soc_rev;
> +	struct se_fw_load_info load_fw;
> +};
> +
> +static struct se_var_info var_se_info = {
> +	.soc_rev = 0,
> +	.load_fw = {
> +		.is_fw_loaded = true,
> +		.imem_mgmt = false,
> +	},
> +};
> +
> +static struct se_soc_info se_imx8ulp_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX8ULP,
> +	.soc_register = true,
> +	.se_fetch_soc_info = ele_fetch_soc_info,
> +	.se_fw_img_nm = {
> +		.prim_fw_nm_in_rfs = IMX_ELE_FW_DIR
> +			"mx8ulpa2-ahab-container.img",
> +		.seco_fw_nm_in_rfs = IMX_ELE_FW_DIR
> +			"mx8ulpa2ext-ahab-container.img",
> +	},
> +	.if_node = {
> +			{
> +			.se_if_id = 0,
> +			.se_if_did = 7,
> +			.if_defs = {
> +				.se_if_type = SE_TYPE_ID_HSM,
> +				.se_instance_id = 0,
> +				.cmd_tag = 0x17,
> +				.rsp_tag = 0xe1,
> +				.success_tag = ELE_SUCCESS_IND,
> +				.base_api_ver = MESSAGING_VERSION_6,
> +				.fw_api_ver = MESSAGING_VERSION_7,
> +			},
> +			.pool_name = "sram",
> +			.reserved_dma_ranges = true,
> +			},
> +	},
> +};
> +
> +static struct se_soc_info se_imx93_info = {
> +	.num_mu = 1,
> +	.soc_id = SOC_ID_OF_IMX93,
> +	.soc_register = false,
> +	.se_fetch_soc_info = ele_fetch_soc_info,
> +	.se_fw_img_nm = {
> +		.prim_fw_nm_in_rfs = NULL,
> +		.seco_fw_nm_in_rfs = NULL,
> +	},
> +	.if_node = {
> +			{
> +			.se_if_id = 0,
> +			.se_if_did = 3,
> +			.if_defs = {
> +				.se_if_type = SE_TYPE_ID_HSM,
> +				.se_instance_id = 0,
> +				.cmd_tag = 0x17,
> +				.rsp_tag = 0xe1,
> +				.success_tag = ELE_SUCCESS_IND,
> +				.base_api_ver = MESSAGING_VERSION_6,
> +				.fw_api_ver = MESSAGING_VERSION_7,
> +			},
> +			.reserved_dma_ranges = true,
> +			},
> +	},
> +};
> +
> +static const struct of_device_id se_match[] = {
> +	{ .compatible = "fsl,imx8ulp-se-ele-hsm", .data = (void *)&se_imx8ulp_info.if_node},

I remember needn't (void*);

> +	{ .compatible = "fsl,imx93-se-ele-hsm", .data = (void *)&se_imx93_info.if_node},
> +	{},
> +};
> +
> +static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
> +{
> +	return &var_se_info.load_fw;
> +}
> +
> +static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se_info)
> +{
> +	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
> +	struct soc_device_attribute *attr;
> +	struct ele_dev_info *s_info;
> +	struct soc_device *sdev;
> +	u8 data[MAX_SOC_INFO_DATA_SZ];
> +	int err = 0;

Try Reverse christmas tree order.

> +
> +	/* This function should be called once.
> +	 * Check if the se_soc_rev is zero to continue.
> +	 */
> +	if (var_se_info.soc_rev)
> +		return err;
> +
> +	if (se_info->se_fetch_soc_info) {
> +		err = se_info->se_fetch_soc_info(priv, &data);
> +		if (err < 0) {
> +			dev_err(priv->dev, "Failed to fetch SoC Info.");
> +			return err;
> +		}
> +		s_info = (void *)data;
> +		var_se_info.soc_rev = s_info->d_info.soc_rev;
> +		load_fw->imem.state = s_info->d_addn_info.imem_state;
> +	} else {
> +		dev_err(priv->dev, "Failed to fetch SoC revision.");
> +		if (se_info->soc_register)
> +			dev_err(priv->dev, "Failed to do SoC registration.");
> +		return -EINVAL;

look this function call by probe because below you use devm_kzalloc().

return dev_err_probe(...);

> +	}
> +
> +	if (!se_info->soc_register)
> +		return 0;
> +
> +	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, var_se_info.soc_rev))
> +		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
> +						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
> +							  var_se_info.soc_rev),
> +						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> +							  var_se_info.soc_rev));
> +	else
> +		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
> +						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
> +							  var_se_info.soc_rev));
> +
> +	switch (se_info->soc_id) {
> +	case SOC_ID_OF_IMX8ULP:
> +		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
> +					      "i.MX8ULP");

No any format at all.

attr->soc_id = "i.MX8ULP";

> +		break;
> +	case SOC_ID_OF_IMX93:
> +		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
> +					      "i.MX93");

the same here.

> +		break;
> +	}
> +
> +	err = of_property_read_string(of_root, "model",
> +				      &attr->machine);
> +	if (err)
> +		return -EINVAL;
> +
> +	attr->family = devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale i.MX");

the same here.

> +
> +	attr->serial_number = devm_kasprintf(priv->dev,
> +					     GFP_KERNEL, "%016llX",
> +					     GET_SERIAL_NUM_FROM_UID(s_info->d_info.uid,
> +								     MAX_UID_SIZE >> 2));
> +
> +	sdev = soc_device_register(attr);
> +	if (IS_ERR(sdev))
> +		return PTR_ERR(sdev);
> +
> +	return 0;
> +}
> +
> +static int se_load_firmware(struct se_if_priv *priv)
> +{
> +	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
> +	const struct firmware *fw;
> +	phys_addr_t se_fw_phyaddr;
> +	const u8 *se_img_file_to_load;
> +	u8 *se_fw_buf;
> +	int ret;
> +
> +	if (load_fw->is_fw_loaded)
> +		return 0;
> +
> +	se_img_file_to_load = load_fw->se_fw_img_nm->seco_fw_nm_in_rfs;
> +	if (load_fw->se_fw_img_nm->prim_fw_nm_in_rfs &&
> +	    load_fw->imem.state == ELE_IMEM_STATE_BAD)
> +		se_img_file_to_load = load_fw->se_fw_img_nm->prim_fw_nm_in_rfs;
> +
> +	do {
> +		ret = request_firmware(&fw, se_img_file_to_load, priv->dev);
> +		if (ret)
> +			return ret;
> +
> +		dev_info(priv->dev, "loading firmware %s\n", se_img_file_to_load);
> +
> +		/* allocate buffer to store the SE FW */
> +		se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
> +					       &se_fw_phyaddr, GFP_KERNEL);
> +		if (!se_fw_buf)
> +			return -ENOMEM;
> +
> +		memcpy(se_fw_buf, fw->data, fw->size);
> +		ret = ele_fw_authenticate(priv, se_fw_phyaddr);
> +		if (ret < 0) {
> +			dev_err(priv->dev,
> +				"Error %pe: Authenticate & load SE firmware %s.\n",
> +				ERR_PTR(ret),
> +				se_img_file_to_load);

miss dma_free_coherent()
if it call from probe(), use return dev_err_probe().

> +			ret = -EPERM;
> +		}
> +
> +		dma_free_coherent(priv->dev,
> +				  fw->size,
> +				  se_fw_buf,
> +				  se_fw_phyaddr);
> +
> +		release_firmware(fw);
> +		fw = NULL;
> +
> +		if (!ret && load_fw->imem.state == ELE_IMEM_STATE_BAD &&
> +		    se_img_file_to_load == load_fw->se_fw_img_nm->prim_fw_nm_in_rfs)
> +			se_img_file_to_load = load_fw->se_fw_img_nm->seco_fw_nm_in_rfs;
> +		else
> +			se_img_file_to_load = NULL;
> +
> +	} while (se_img_file_to_load);

why need loop here?
request_firmware is block function;

* request_firmware() - send firmware request and wait for it

If need retry, you need set max retry count;

> +
> +	if (!ret)
> +		load_fw->is_fw_loaded = true;
> +
> +	return ret;
> +}
> +
> +/* interface for managed res to free a mailbox channel */
> +static void if_mbox_free_channel(void *mbox_chan)
> +{
> +	mbox_free_channel(mbox_chan);
> +}
> +
> +static int se_if_request_channel(struct device *dev,
> +				 struct mbox_chan **chan,
> +				 struct mbox_client *cl,
> +				 const char *name)
> +{
> +	struct mbox_chan *t_chan;
> +	int ret = 0;
> +
> +	t_chan = mbox_request_channel_byname(cl, name);
> +	if (IS_ERR(t_chan)) {
> +		ret = PTR_ERR(t_chan);
> +		return dev_err_probe(dev, ret,
> +				     "Failed to request %s channel.", name);
> +	}

	if (IS_ERR(t_can))
		return dev_err_probe(dev, PTR_ERR(t_chan),
				     "Failed to request %s channel.", name);
> +
> +	ret = devm_add_action_or_reset(dev, if_mbox_free_channel, t_chan);
> +	if (ret) {
> +		ret = -EPERM;
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add-action for removal of mbox: %s\n",
> +				     name);

the same here.

> +	}
> +	*chan = t_chan;
> +
> +	return ret;
> +}
> +
> +static void se_if_probe_cleanup(void *plat_dev)
> +{
> +	struct platform_device *pdev = plat_dev;
> +	struct device *dev = &pdev->dev;
> +	struct se_fw_load_info *load_fw;
> +	struct se_if_priv *priv;
> +
> +	priv = dev_get_drvdata(dev);
> +	load_fw = get_load_fw_instance(priv);
> +
> +	/* In se_if_request_channel(), passed the clean-up functional
> +	 * pointer reference as action to devm_add_action_or_reset().
> +	 * No need to free the mbox channels here.
> +	 */
> +
> +	/* free the buffer in se remove, previously allocated
> +	 * in se probe to store encrypted IMEM
> +	 */
> +	if (load_fw && load_fw->imem.buf) {
> +		dmam_free_coherent(dev,
> +				   ELE_IMEM_SIZE,
> +				   load_fw->imem.buf,
> +				   load_fw->imem.phyaddr);
> +		load_fw->imem.buf = NULL;
> +	}
> +
> +	/* No need to check, if reserved memory is allocated
> +	 * before calling for its release. Or clearing the
> +	 * un-set bit.
> +	 */
> +	of_reserved_mem_device_release(dev);
> +}
> +
> +static int se_if_probe(struct platform_device *pdev)
> +{
> +	const struct se_soc_info *se_info;
> +	const struct se_if_node *if_node;
> +	struct device *dev = &pdev->dev;
> +	struct se_fw_load_info *load_fw;
> +	struct se_if_priv *priv;
> +	int ret;
> +
> +	if_node = device_get_match_data(dev);
> +	if (!if_node)
> +		return -EINVAL;
> +
> +	se_info = container_of(if_node,
> +			       typeof(*se_info),
> +			       if_node[if_node->se_if_id]);

Use se_if_id is risk. redesign drv data to make it simple and easy
understand.

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->if_defs = &if_node->if_defs;
> +	dev_set_drvdata(dev, priv);
> +
> +	ret = devm_add_action_or_reset(dev, se_if_probe_cleanup, pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Mailbox client configuration */
> +	priv->se_mb_cl.dev		= dev;
> +	priv->se_mb_cl.tx_block		= false;
> +	priv->se_mb_cl.knows_txdone	= true;
> +	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
> +
> +	ret = se_if_request_channel(dev, &priv->tx_chan,
> +				    &priv->se_mb_cl, MBOX_TX_NAME);
> +	if (ret)
> +		return ret;
> +
> +	ret = se_if_request_channel(dev, &priv->rx_chan,
> +				    &priv->se_mb_cl, MBOX_RX_NAME);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&priv->se_if_cmd_lock);
> +
> +	init_completion(&priv->waiting_rsp_clbk_hdl.done);
> +	init_completion(&priv->cmd_receiver_clbk_hdl.done);
> +
> +	if (if_node->pool_name) {
> +		priv->mem_pool = of_gen_pool_get(dev->of_node,
> +						 if_node->pool_name, 0);
> +		if (!priv->mem_pool)
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "Unable to get sram pool = %s.",
> +					     if_node->pool_name);
> +	}
> +
> +	if (if_node->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					    "Failed to init reserved memory region.");
> +	}
> +
> +	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
> +		ret = get_se_soc_info(priv, se_info);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to fetch SoC Info.");
> +	}
> +
> +	/* By default, there is no pending FW to be loaded.*/
> +	if (se_info->se_fw_img_nm.prim_fw_nm_in_rfs ||
> +	    se_info->se_fw_img_nm.seco_fw_nm_in_rfs) {
> +		load_fw = get_load_fw_instance(priv);
> +		load_fw->se_fw_img_nm = &se_info->se_fw_img_nm;
> +		load_fw->is_fw_loaded = false;
> +
> +		if (se_info->se_fw_img_nm.prim_fw_nm_in_rfs) {
> +			/* allocate buffer where SE store encrypted IMEM */
> +			load_fw->imem.buf = dmam_alloc_coherent(priv->dev, ELE_IMEM_SIZE,
> +								&load_fw->imem.phyaddr,
> +								GFP_KERNEL);
> +			if (!load_fw->imem.buf)
> +				return dev_err_probe(dev, -ENOMEM,
> +						     "dmam-alloc-failed: To store encr-IMEM.");
> +			load_fw->imem_mgmt = true;
> +		}
> +	}
> +	dev_info(dev, "i.MX secure-enclave: %s%d interface to firmware, configured.",
> +		 SE_TYPE_STR_HSM,
> +		 priv->if_defs->se_instance_id);
> +
> +	return ret;
> +}
> +
> +static void se_if_remove(struct platform_device *pdev)
> +{
> +	se_if_probe_cleanup(pdev);
> +}
> +
> +static int se_suspend(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_fw_load_info *load_fw;
> +	int ret = 0;
> +
> +	load_fw = get_load_fw_instance(priv);
> +
> +	if (load_fw->imem_mgmt)
> +		ret = se_save_imem_state(priv, &load_fw->imem);
> +
> +	return ret;
> +}
> +
> +static int se_resume(struct device *dev)
> +{
> +	struct se_if_priv *priv = dev_get_drvdata(dev);
> +	struct se_fw_load_info *load_fw;
> +
> +	load_fw = get_load_fw_instance(priv);
> +
> +	if (load_fw->imem_mgmt)
> +		se_restore_imem_state(priv, &load_fw->imem);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops se_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(se_suspend, se_resume)
> +};
> +
> +static struct platform_driver se_driver = {
> +	.driver = {
> +		.name = "fsl-se",
> +		.of_match_table = se_match,
> +		.pm = &se_pm,
> +	},
> +	.probe = se_if_probe,
> +	.remove = se_if_remove,
> +};
> +MODULE_DEVICE_TABLE(of, se_match);
> +
> +module_platform_driver(se_driver);
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> new file mode 100644
> index 000000000000..32547bc97ca3
> --- /dev/null
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef SE_MU_H
> +#define SE_MU_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/semaphore.h>
> +#include <linux/mailbox_client.h>
> +
> +#define MAX_FW_LOAD_RETRIES		50
> +
> +#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> +#define MAX_NVM_MSG_LEN			(256)
> +#define MESSAGING_VERSION_6		0x6
> +#define MESSAGING_VERSION_7		0x7
> +
> +struct se_clbk_handle {
> +	struct completion done;
> +	bool signal_rcvd;
> +	u32 rx_msg_sz;
> +	/* Assignment of the rx_msg buffer to held till the
> +	 * received content as part callback function, is copied.
> +	 */
> +	struct se_api_msg *rx_msg;
> +};
> +
> +struct se_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +	u32 state;
> +};
> +
> +/* Header of the messages exchange with the EdgeLock Enclave */
> +struct se_msg_hdr {
> +	u8 ver;
> +	u8 size;
> +	u8 command;
> +	u8 tag;
> +}  __packed;
> +
> +#define SE_MU_HDR_SZ	4
> +
> +struct se_api_msg {
> +	struct se_msg_hdr header;
> +	u32 data[];
> +};
> +
> +struct se_if_defines {
> +	const u8 se_if_type;
> +	const u8 se_instance_id;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +	u8 base_api_ver;
> +	u8 fw_api_ver;
> +};
> +
> +struct se_if_priv {
> +	struct device *dev;
> +
> +	struct se_clbk_handle cmd_receiver_clbk_hdl;
> +	/* Update to the waiting_rsp_dev, to be protected
> +	 * under se_if_cmd_lock.
> +	 */
> +	struct se_clbk_handle waiting_rsp_clbk_hdl;
> +	/*
> +	 * prevent new command to be sent on the se interface while previous
> +	 * command is still processing. (response is awaited)
> +	 */
> +	struct mutex se_if_cmd_lock;
> +
> +	struct mbox_client se_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +
> +	struct gen_pool *mem_pool;
> +	const struct se_if_defines *if_defs;
> +};
> +
> +#endif
> diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
> new file mode 100644
> index 000000000000..0d49eb109885
> --- /dev/null
> +++ b/include/linux/firmware/imx/se_api.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef __SE_API_H__
> +#define __SE_API_H__
> +
> +#include <linux/types.h>
> +
> +#define SOC_ID_OF_IMX8ULP		0x084D
> +#define SOC_ID_OF_IMX93			0x9300
> +
> +#endif /* __SE_API_H__ */
>
> --
> 2.43.0
>

