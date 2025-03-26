Return-Path: <linux-kernel+bounces-577206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B3CA719D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49342171DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793B1F3B98;
	Wed, 26 Mar 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fSwyToe/"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A1145B27;
	Wed, 26 Mar 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001478; cv=fail; b=qOsnCT99LAmRabzxkxrlVHRQOuFyM5ov16TvpBXTwV7UL1See5uO3NyuYzoHmf2aYTAi86U/21EGtvHS073gzzHosx1EryUjQjNMRoq8YkB9kMGLwnSfApvPv9ppfxkel/EhKUkChoiicYAecD6/Vp6bh/KyvlenynOytpdZ94c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001478; c=relaxed/simple;
	bh=r1SPBy/zTyja6Iha6YVCVB9ZmQSPc4g7Lx+AbGd41pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pehpDUZLp2wDS6KEmhph9zXbbpvuic/u89M+HDxJhhjzGeBqoJuzcdQ/PP/dzcHpaHC4tPqtkUMnCj7C9vPy6Ps7DBQkv6Vcx2t53b2S+K7fomF616mUw+AVV8WrgNCj8xqkdDBZdq4lVqK+7ISTAGkUywqPhkdmDiWl8mZYux8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fSwyToe/; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAPwZdML6D9gndpXwjESRKiaxN4lHKLCTl16a5bLxB9hGT+nVtOL6eK0pnjc3HlcCFE7lE78nyaJCEstNG0clDe8t5elFE6b48BwyHxaTz1YPEgSnRJMFlwouBL3jYVSswEnW3HNxWrDGqxKvgTACzPZnVlP3XHIq8OPblDxg/hnewsZTMtw2VPbnVYrkHLhX/TGTJP+egetvR8pXmPNl9Zq9nxq90HWqliZJELda6Z3ldKpD6FAqgeFTYgxQuEXOU2xfNZZnIJshFXgzv7SdRU/2EdTO6O2U/Dm/Di3GdVjTmyQiddpRZ6YoQdHS64JzvsWfepC+fgkhYfBI/eZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAlGO9RabTGykDkNSLxPh8U5U7GlPHWnlegiG+/7yeM=;
 b=re5y08vX2qkMVjxZBmkGaYDDMY8OAwzIKsomPpR361ZIZQxLdyxoCe8+abT6pgOaXHZql3dhyyvbhYLwqm9yLpJdxoik8pCBFuX9SNnRTRZYImXBSoAHrVHTaB5sZ1BPs4p1rccUPTFsWnTCgQKFcjn0VnqMwfFdnK8ISLz4zXhS+tlv3fNWskJS6hQ2YNVPTp6hIia7L+ik23ibkYQQgkCekzpHU8KuCXsWMs0uevGnaIMH39l7pIvW9akSWF+WgyqO1Jyk61ifGk1sRi+giw9up0YmO9SMOUCOpZwVJcBnhPVD3odky0lfJ+sRP4N9BZ219osUWHogijlU9o8u0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAlGO9RabTGykDkNSLxPh8U5U7GlPHWnlegiG+/7yeM=;
 b=fSwyToe/AY+3+B/YZcuKus7U/WmnaZRm4QhCc4/12NPqimmYNNxENwAkEcQGVn3atHF1Q21MtD/hYNmwtuBj3T8yn9Nb1tP3n4rR75Mv/ROREur3HS9q+qVrnak6yyyzfkbaTqytwMFrDxsXJVyjOsBhhzTQTIpiq69GETcUgEVuA8Rfq3D+MWXbvv5QuU3FdSdtcy1v870HUZXPrnG0gAh1Sb2OAjxg/WjKD5vmB23q2sJz1vOvptbXhnMB7oC8j3k+L2I2/lh8iM+Qtwn/6FNmRzZL/mn7OPZKwP3BGwJ8d4+UWZoXV5NatuN/DyuV2I7ZlUP6VqIfUYbLs0fY3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:04:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 15:04:31 +0000
Date: Wed, 26 Mar 2025 11:04:23 -0400
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
Subject: Re: [PATCH v14 0/6] v14: firmware: imx: driver for NXP secure-enclave
Message-ID: <Z+QXd/Irz63X6Xda@lizhi-Precision-Tower-5810>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
X-ClientProxiedBy: PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ba11ac-ec31-46b6-5bbc-08dd6c7782fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XkLAebD6OiENbNp1jLoXjujAHbRFCD9CEF0w12/cJsGmJ8T94Wr0tZRZIVTc?=
 =?us-ascii?Q?5DEaOwA7lBbJyhq3B0iD4DZXVb+K5jik5MhukFEnpudazEkMKjdCiTaH9c9N?=
 =?us-ascii?Q?PgQfdsMy6twWHeLpwDkAWRX87xupL6aVFd/kkXKwPFsU2JDrvu3UFd5BOFgI?=
 =?us-ascii?Q?j56nJH/8iBFrAEsEf78daSrMQAy4tI/DV+WBAK5Ea4V+Uvhl3YL1x5O8HRN1?=
 =?us-ascii?Q?FuBTiKdvwI6II+DgeNVI9JUQifx3r+dEfwuxI5uOlfYR6/ISjCgFcBqqc9rp?=
 =?us-ascii?Q?KpcoIAKGGjBNG+N89JW9tXFzuxKqwOpKMFihqAU7MVy0Zxn+Cuct2H5SaFIe?=
 =?us-ascii?Q?jFYCUJOtNxvJd7Re/WJNMZitO181SGCHVuk2pSebqwCFSj8Z6FyThogsrogW?=
 =?us-ascii?Q?Wr+/CRZfB/CR28nmyHyLwhz0qPzghuIWh4nHgKbiqPEcqLkJd9uaYUkIXNCg?=
 =?us-ascii?Q?fumjZ2lv8+wdnhv7Ny4k+rWlhrKTjsMgdXjuZU/Cl26uoxFq/Q8pzCIcEiNE?=
 =?us-ascii?Q?57Gg8LU2aXn0xbQuj7W6czZ1005eeP1d9IoGA9H3LTUnIhAU2sMNaJ6pTEFV?=
 =?us-ascii?Q?Lfmk5/UHHCg1+2P7KwFbCn5sjhK+VYR7PN/C35+6SEpMNrxY8q90+ZK/FgA+?=
 =?us-ascii?Q?SBOyhHshsZFJl6ihRq0he4Y2QdLqZX6faiEJickrEXkmSUauR2l6eDRYCLLe?=
 =?us-ascii?Q?d02hkIiU2e4YjRKpxA5GmsAtJmScr9J0O2E6uQaAxmpxHchwVc9fNfWlsw+T?=
 =?us-ascii?Q?s7JDruSSJrcJ2ED+EWz1YNm7+42beHj+sLuklN+YyitgoaWgA4jul84Z1eTa?=
 =?us-ascii?Q?l+89jCla1GevjmK0fQ/NtW6ETlrhnD5Sq4l0GXhiP0RMeNyrMTLGV6pggedh?=
 =?us-ascii?Q?fLNjeMhBqBWjrTMkAIXxaZ4514xYgwOqXvAVHqka4/gWmXE56ulAZuwElj+D?=
 =?us-ascii?Q?cdMBRyiA+Xaak8ElMQyoaUvzuNy4s4Z4gZvEMuPw1k6jtg3sbIbWuCNv29yR?=
 =?us-ascii?Q?uES16G+8dOBYmKCsPPLs0V8mDoyP7QtGi7COWuyDguFMfrYB5l5JzjvSRKT8?=
 =?us-ascii?Q?0NZZOB2SDa6GBL4aAf6CULMl7/sNlL9C1uTVqBvtItqBhnMthYy0WHZPs/9C?=
 =?us-ascii?Q?z8UqiBVJTrcsneiCyDFNqGzdM+wXAM2mY5S1Fswo0b2RRxR5q8NKexkqbgtM?=
 =?us-ascii?Q?dINRggi7y49cChkOII0af4UR69Q0spUMzK4WWCQu8nbfbARXSlg1IUWLIUkn?=
 =?us-ascii?Q?inc3eA3WH7Qs3xAdvAWCDW8cWhK7eagGrOU4if0rTpfRpXnQEBRKMK7KAZwN?=
 =?us-ascii?Q?qCR26WYf3aYMAWaxPmXxSMZsz9Ae2Tnz+WJMAccgy8L8BzvqGlc3rz9PW6vF?=
 =?us-ascii?Q?IWP8Hhcw8GiddmQydnrb3wVXXCk3CsuHujyr2rRMMGbaBmePFCZgMK4DeiUl?=
 =?us-ascii?Q?LkUBqHQ2IRonVEnMkajdAaDlREMHN6tD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dSWeMdWVWkEr5RK1+ZCSv0r0i2b46uzjaYzHzYBPi5J1KyKGwApBWvuI4geG?=
 =?us-ascii?Q?EckSC1Vdg6DRSyX7JgI5gjeu3J7nEkVTrC4yAlV79osI43FSqZJ16j3obSd5?=
 =?us-ascii?Q?+ep4wTHD7kugiU5rZcs2s3fqOoydDg2CTVqaNzIVsoQ0OfDT0PYf/fR7za6e?=
 =?us-ascii?Q?OOJanZu7MITzj4uxXa4LPm3+c9KqB0kqTb5ARVtnPaXlgLx3BIbecOHIhAFa?=
 =?us-ascii?Q?r6SbUDmryj8+7ZYorQPMvGAETtXGwSUgQUvQ1q3ZnZ6BdI5ktPNnmxqeyhZx?=
 =?us-ascii?Q?YksL00hO5yzfOqpKm2HfFscRddtRvC/wDpXGuFp5BvYuhXimCoCz9grX5QtO?=
 =?us-ascii?Q?K//FJQD3/5MLUhJlofVfJW9fFAMd7nTDZoSCZSj+ibtTrpGTeDtjK9gspd6B?=
 =?us-ascii?Q?tCOiHOsTgsLm6gMsx9A6mum0zgcsAqq6J/Mkq63Zh5+SsU5dxlL2fOn1fbbn?=
 =?us-ascii?Q?93zqsN0f5NHZMiddVBNGP7W8cH5dedY+LxuGOQfq+b1yggmXyQF65/u2hHEC?=
 =?us-ascii?Q?EICNwg7Rf2WfYJHFwyiu5AfEy0wbOdpzeyReVX0eIMi7KK7ybYqlaxIWKYFO?=
 =?us-ascii?Q?0x2r8WeVA7KtPWzEz9fJm2uQyId9zOwC5R45bOBXN20vWZaByBReh+7cgffe?=
 =?us-ascii?Q?kZDoIV/z5nRmy1sCStl6sQ73ESRJHO9GHAodZOab4A01PqDVl4MDNlfMkuRM?=
 =?us-ascii?Q?VRWTQU2ebF6i/I9lfbuKT5QSfITuF1eJ82LWAT8lI7Z+AaQSWEZEvz878+qm?=
 =?us-ascii?Q?TeJScXQN9LSP0iZBG0cK5Xn9UrjyGDjLlQmGqO5RXMJYYIjyovHTBpqmsb+K?=
 =?us-ascii?Q?Wuxdpnx8VaVeI4LcRJv/Une05fTk3CYUxr3ZkEpKUS43Q4/9PIdsqnbMrziM?=
 =?us-ascii?Q?Fdw0iF96me5SAaoIqMcFAO+viL8qHv+XbGIkG9vyoEwXjsWFiHEwrl3bhHRb?=
 =?us-ascii?Q?ZAZ6PEnHw7Ugsbjv9Teo0dKufFbgjEYeEsI8YgsOqv+aFw0vLgVemyr/H0Eq?=
 =?us-ascii?Q?GZOzBGFlMBt6lqaqX0TcFsXkXcY0AeN7zo61yPUJEKBUK/BDng0Q/1aLGRE6?=
 =?us-ascii?Q?OJARKVVPnqQokPey9Tg/k9uHroDwgC6y0DGOTcofDa/FgpW1wUd3n0NDVvNk?=
 =?us-ascii?Q?2g7v0J/O4EXLKTORW2q3CNM04GdK1docYwm2Tk9AixXhkaj95C9gdBrWQREF?=
 =?us-ascii?Q?EHPU4POEicW+UWKqnKRdzaEJnWfiy4cPPZFiMSDp1YVVxfNMiJZDmAeFopH5?=
 =?us-ascii?Q?6LoB7Pc0+fGrFekRxsBR96Wypr+DSiIPkFGky+s5Q84E971jjbiflvhvSt/j?=
 =?us-ascii?Q?C2xxqvdLFFREmbGjQG5dstqwTVSy5IOsm+uI2o6nZBW1utkiovboRHCMrJWb?=
 =?us-ascii?Q?tLHMGAEwGmDH31UHFBV5ZsbQI+fVa0QFgdFIEYawBBaY/7VqCAkiF9Fpf3x5?=
 =?us-ascii?Q?t/WLklToEW90B/Q4g4QaeiXqWM6pybaTvfpt/yWlbEvvzOkaC/dzEjpaz2s+?=
 =?us-ascii?Q?glohenGdIXUE96r3u9n/hdcTGPmuUqaRB0Cn4jT/rQRztLwrGSfW4NuA3I/y?=
 =?us-ascii?Q?5ujfyWrkIaOy52OuI4B2EV4UxPKxFgwIZg3Q3eI6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ba11ac-ec31-46b6-5bbc-08dd6c7782fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:04:31.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuIrWWccg8h/KV8ySTQ9WlkVSzzw7TQxJQIfW/MDOj1uI7ebYKRyMkJZcHEwm6+zzhCNAo0x/33A94x7kDDMMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784

On Thu, Mar 27, 2025 at 12:07:56AM +0530, Pankaj Gupta wrote:

Fix subject:

[PATCH v14 0/6] firmware: imx: driver for NXP secure-enclave

No "v14" between "]" and "firmware".

Frank

> Patch 5/5 is two:
> - firmware: drivers: imx: adds miscdev
> - Introduce dev-ctx dedicated to private.
>   -- Base patch before enabling misc-device context, to have the send-receive path, based on device context.
> - change logs are added below the commit message
> - No change in 1/6 & 2/6.
>
> Reference:
> - Link to v13: https://lore.kernel.org/r/20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com
>
> Changes in v13:
>
> 5/5
> - Updated the commit message for imperative mood.
> - Remove the usage of macros- NODE_NAME, GET_ASCII_TO_U8, GET_IDX_FROM_DEV_NODE_NAME.
> - Clean-up the return path by replacing "ret = -<err>; return ret;" with "return -<err>;"
> - Clean-up the return path by replacing "ret = -<err>; goto exit;" with "return -<err>;"
> - Removed goto statements from the entire driver, where there is no common code at function's exit.
> - Fixes the check-patch erros reported with flag "--strict"
> - Replaced devm_add_action, with devm_add_action_or_reset
> - Removed the un-necesary and obvious code comments.
> - Removed dev_probe_err at the exit of function se_if_probe().
>
> 4/5
> - Clean-up the return path by replacing "ret = -<err>; return ret;" with "return -<err>;"
> - Clean-up the return path by replacing "ret = -<err>; goto exit;" with "return -<err>;"
> - Removed goto statements from the entire driver, where there is no common code at function's exit.
> - fixes the check-patch erros reported with flag "--strict"
> - removed the un-necesary and obvious code comments.
> - variable received msg timeout to be different at boot-up & suspend/resume and send/recv ioctlis.
>
> 3/5
> - compatible string is modified from "fsl,imx8ulp-se" to "fsl,imx8ulp-se-ele-hsm".
> - updated the alias name.
>
> 2/5
> - compatible string is modified from "fsl,imx8ulp-se" to "fsl,imx8ulp-se-ele-hsm".
> - compatible string is modified from "fsl,imx93-se" to "fsl,imx93-se-ele-hsm".
> - compatible string is modified from "fsl,imx95-se" to "fsl,imx95-se-ele-hsm".
> - Mis-understood the +1 from Conor. Hence dropped the Reviewed-by tag.
> - Collected Rob's R-b tag on v7 (https://lore.kernel.org/all/172589152997.4184616.5889493628960272898.robh@kernel.org/)
>
> 1/5
> - No change
>
> Reference:
> - Link to v12: https://lore.kernel.org/r/20250120-imx-se-if-v12-0-c5ec9754570c@nxp.com
>
> Changes in v12:
>
> 5/5
> - increased the wait-timeout.
>
> 4/5
> - rename flag "handle_susp_resm" to "imem_mgmt"
> - moved the buffer allocation ot load_fw->imem.buf, to se_probe_if.
> - setting imem state at initialization.
>
> 3/5
> - No change
>
> 2/5
> - No change
>
> 1/5
> - No change
>
> Reference:
> - Link to v11: https://lore.kernel.org/r/20241220-imx-se-if-v11-0-0c7e65d7ae7b@nxp.com
>
> Changes in v11:
>
> 5/5
> - devname is constructed by concatinating get_se_if_name(se_if_id) & se_if_instance_id.
> - ele_rcv_msg(), is updated to add the wait_interruptible_timeout for the non-NVM-Daemon message exchanges, such that in case of no response from FW,
>   Linux donot hangs.
> - added a new helper function get_se_if_name(), to return the secure-enclave interface owner's name string.
> - added a new helper function get_se_soc_id(), to return the secure-enclave's SoC id.
>
> 4/5
> - moved the se_if_node_info member "soc_register", to the struct "se_if_node_info_list"; as soc registration done once, not per interface.
> - moved the se_if_node_info member "se_fetch_soc_info", to the struct "se_if_node_info_list"; as soc info fetching is done once, not per interface.
> - Added two member variable se_if_id and se_if_instance_id to struct se_if_defines.
> - removed the member "se_name" from struct "se_if_node_info". Rather, it will constructed by concatinating get_se_if_name(se_if_id) & se_if_instance_id.
> - moved the static global variable "se_version", to the newly created structure "struct se_var_info".
> - moved the member "struct se_fw_load_info load_fw" of "se_if_node_info_list", to the newly created structure "struct se_var_info".
> - Replaced RUNTIME_PM_OPS with SET_SYSTEM_SLEEP_PM_OPS, in power-managment ops.
>
> 3/5
> - No change
>
> 2/5
> - No change
>
> 1/5
> - No change
>
> Reference:
> - Link to v10: https://lore.kernel.org/r/20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com
>
> v10: firmware: imx: driver for NXP secure-enclave
>
> Changes in v10:
> 5/5
> - replaced the u8, u16, u32, u64, with __u8, __u16, __u32, __u64 in
>   'include/uapi/linux/se_ioctl.h'.
>
> 4/5
> - No change
>
> 3/5
> - No change
>
> 2/5
> - No change
>
> 1/5
> - No change
>
> Reference:
> - Link to v9: https://lore.kernel.org/r/20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com
>
> Changes in v9:
>
> 4/5
> - change se_if_remove function signature, required after rebase to v6.12-rc1.
> - move the info->macros to a structure "struct se_if_defines if_defs".
> - Removed "info" from "struct se_if_defines if_defs".
> - Moved "mem_pool" from "struct se_if_defines if_defs" to "priv".
> - Fetching "info" using container-of.
>
> 5/5
> - Fetching "info" using container-of.
> - Fixed issue reported by sparse.
>
> Reference:
> - Link to v8: https://lore.kernel.org/r/20241015-imx-se-if-v8-0-915438e267d3@nxp.com
>
> Changes in v8:
>
> 5/5
> - Remove the check for SE_IF_CTX_OPENED.
> - replaced dev_ctx->priv-dev, priv->dev, whereever possible.
> - func "if_misc_deregister" moved before func "init_device_context".
> - func "init_device_context" before func "se_ioctl_cmd_snd_rcv_rsp_handler".
> - func "se_if_fops_write" and "se_if_fops_read", are moved after func "se_ioctl_get_mu_info".
> - non static functions "se_dev_ctx_cpy_out_data, se_dev_ctx_shared_mem_cleanup & init_device_context" are moved static and local scope.
> - Removed back & forth between the two structs "struct se_if_device_ctx *dev_ctx" and "struct se_shared_mem_mgmt_info *se_shared_mem_mgmt"
> - removed the NULL check for bdesc.
> - fops_open, is corrected for acquiring the fops_lock.
> - Fops_close, mutex unlock is removed. Infact check for waiting_rsp_clbk_hdl.dev_ctx, is removed.
> - sema_init(&dev_ctx->fops_lock, 1);, replaced with Mutex.
> - structure member se_notify, is removed.
>
> 4/5
> - removed initializing err to zero in func ele_fetch_soc_info(),
> - replaced 'return 0', with 'goto exit', if the condition (!priv->mem_pool) is true.
> - replaced "struct *dev" with "struct se_if_priv *priv", in base_message API(s) and others.
> - Created a separate structure "struct se_if_defines" to maintain interface's fixed values like cmd_tag, rsp_tag, success_tag etc.
> - removed the macros "WORD_SZ", "SOC_VER_MASK", "DEFAULT_IMX_SOC_VER", "RESERVED_DMA_POOL".
> - Added handling for "ctrl+c", by postponing the interrupt, till the response to the "command in flight" is received.
> - Removed the mutext lock "se_if_lock".
> - furnction prototype for "se_save_imem_state" and "se_restore_imem_state", is changed to pass "imem" by reference.
> - Added a new structure "struct se_fw_load_info", dedicated to contain FW loading relevant info. It is a member of struct info_list.
> - split "imem_mgmt_file_in_rfs" into two "prim_fw_nm_in_rfs" and "seco_fw_nm_in_rfs", to be part of "struct se_fw_load_info".
> - moved the function "se_load_firmware" prior to func "if_mbox_free_channel".
> - function "se_load_firmware" is updated to use "request_firmware", instead of "request_firmware_no_wait".
> - function "se_load_firmware" is updated to load "primary" fw image, if the imem_state is not BAD. Then load the "secondary FW" image.
> - Added a new mutex_lock in the function "se_load_firmware", for ensuring FW loading done once, when there are multiple application are in play.
> - instead of "wait_queue_head_t wq", used "sruct completion".
> - add devm_add_action with action as se_if_probe_cleanup.
>
> Reference:
> - Link to v7: https://lore.kernel.org/r/20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com
>
> Changes in v7:
>
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
> Reference:
> - Link to v6: https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com
>
> Changes in v6:
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
> Reference:
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
> Reference:
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
> Reference:
> - Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com
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
> Reference
> - Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com
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
>
> ---
> Pankaj Gupta (6):
>       Documentation/firmware: add imx/se to other_interfaces
>       dt-bindings: arm: fsl: add imx-se-fw binding doc
>       arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
>       firmware: imx: add driver for NXP EdgeLock Enclave
>       firmware: imx: device context dedicated to priv
>       firmware: drivers: imx: adds miscdev
>
>  Documentation/ABI/testing/se-cdev                  |   43 +
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
>  .../driver-api/firmware/other_interfaces.rst       |  121 ++
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   12 +-
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   11 +-
>  drivers/firmware/imx/Kconfig                       |   13 +
>  drivers/firmware/imx/Makefile                      |    2 +
>  drivers/firmware/imx/ele_base_msg.c                |  315 +++++
>  drivers/firmware/imx/ele_base_msg.h                |   95 ++
>  drivers/firmware/imx/ele_common.c                  |  376 ++++++
>  drivers/firmware/imx/ele_common.h                  |   54 +
>  drivers/firmware/imx/se_ctrl.c                     | 1214 ++++++++++++++++++++
>  drivers/firmware/imx/se_ctrl.h                     |  126 ++
>  include/linux/firmware/imx/se_api.h                |   14 +
>  include/uapi/linux/se_ioctl.h                      |  101 ++
>  15 files changed, 2585 insertions(+), 3 deletions(-)
> ---
> base-commit: 8250927cfd6e6538b6c569926865d833ae6b5bc0
> change-id: 20240507-imx-se-if-a40055093dc6
>
> Best regards,
> --
> Pankaj Gupta <pankaj.gupta@nxp.com>
>

