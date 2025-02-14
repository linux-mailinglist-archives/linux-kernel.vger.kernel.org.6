Return-Path: <linux-kernel+bounces-514566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D2A35898
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3620D16D9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03361221DAC;
	Fri, 14 Feb 2025 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="htDtcDHO"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957F1547E2;
	Fri, 14 Feb 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520930; cv=fail; b=r5SiKZ56jx7ip5Xja+9pkBjwiuiR1+u4ibe7LUqPDe7v9xGTM6m4zoOlUZT/QwNt/hdSqlcV2OCFqMy82YHHBdBTJk/t35VVkB++XAM2q8HLNVE1W+5+U980IltfWOh5xDO92WZDThKA6UAsfY5uMpj8J+tbAPiPa7mZWLTCK9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520930; c=relaxed/simple;
	bh=kdGfsSuJDWiUuDcs1IyGOxiLS4IG4vUMpSqUli0bRbI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ocBT4xAuB/Qxvjmoy1tORI3cOOf9rjNHd+lEr45+T43CEkt4C7Y7R6LBCC2jnc6a8G/6J7D66+TdwV6mZd+zgxnQZYloQM7d2hTXkmVsUyt6VbDwJ21JW2ZHwMEd5P/MySgUZZvEQsiCzjOOFcql+Smpct45tIXsB5hIUQ/9750=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=htDtcDHO; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRFuNmP4mkxDDhW2EI1vNBSf2M2/u9aaehIeV3vJpBMNJO7NlnVlsvj6YnZRpLahmBv+RDVHhYuQYsKuz1dOHl5x0e4kynHPyWh1EpkFh3f5lx76TS0oMczLwL0BjbwDCx32fyjV0g2cVT23N/U2/qhQBuFNMJgThm4BRtNPgZMPqbGp/UDe8Di8xkcZkht0/bRv8YM8LbaP+ZCqM8uW/OAEWZb5BMdG9CDpoz2EPirs6ieoOBU5fQ56RpdDU28LB4oO8ZbYTkM1vr1JQM6qT4yIo77o7B3pr5uQJ5JU/Ph4tjGd7RcgI3Wtv551f/lxgeIIDadPZNwipzEfWgL35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djZ7OGIeytxWR8I6ZeAgwHGFZjhdUKxOp2h94vljgDo=;
 b=s70lAfJH+DwZnofnjOfr0q7bEFAKKcQBft+Oe71Gs9LTNP//CWFrPQqNX3sRc9fWZ/9QCRi+ufKuKniaBxVyy+lYqqHG11mM+LZUAy9xdnknCnjuiSB7sjYbFPcpvm/S1pA7DTwp921qWyCQW2SsW6x2E4ySKUyc2hnoYmaJ/qghKX1LIsVC6+Uhgoj3IWyGas+xbOWJXAtgQEq+ZOJ7K0uRbSPwPFf8by1tAD9CW2cliXd//IKg/icjNsPq12ybeDIIKLdGXZjzQW5QzT0cYNAe/OpXAA8AQ3APFdiB8J+uEmy5fVAdzzjuhU5+B0JrMBggbYeFSap+tF/7CbtrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djZ7OGIeytxWR8I6ZeAgwHGFZjhdUKxOp2h94vljgDo=;
 b=htDtcDHO5KDtP6vdYbcT62BqNIPXLKxRxOy0eGruGOAPXdCdNx0ALL76M5NisqYiFmLuRC5xNKrTUiIwMQptzwchS3aNZ+3hATO/M91EVpBMBw+5S5A6Lht0uYzogf4CZZVP6YPPrQAjGZVLK9FyPN5dQVb+EifkSQHcLCsg2srZJIpazqcBKNYfzsrA5lm57BXLqVPCNZaInxqeL+LJbFSr+ANYTMZPdocyetw19KdWWmjpuFx1caspRxLUOzQByv8VkzdQ5NoTosnOuzqZTWdPP2UpCPfSyqTYYDXud25z6m2R0I9lwro0egMcwldofBUhnQ49q6+aonthC/o65g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AS1PR04MB9629.eurprd04.prod.outlook.com (2603:10a6:20b:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 08:15:24 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::24fa:6f9:8247:c5dc]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::24fa:6f9:8247:c5dc%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 08:15:24 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: fsl_sai: Rename stream name of dai driver
Date: Fri, 14 Feb 2025 17:14:57 +0900
Message-ID: <20250214081458.296948-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|AS1PR04MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: d117ef0a-0fcf-4a71-799d-08dd4ccfbb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?honhnjCkfZrXsHnlNjiJKNZGlLQ9XhWzc19NvGiXVGhXJt5+p6j2wcqIL1zU?=
 =?us-ascii?Q?OV4ovyasdOFnb2nxtuhwbgmeiMt6Suy09nR+eoCxD6avIQEMMa6qFeSm9A1f?=
 =?us-ascii?Q?MWqRFpLkLHbqflVdTxZYWdL1yF/sHswAT9H+NK3W8YLD9DhWdqoAfZsM9cGq?=
 =?us-ascii?Q?uwbpMQxkrJn2MG95STm6BeCBiyqJoi6xJp5NEQ4iq5S7XyNrtuo3p2RbTNaY?=
 =?us-ascii?Q?Pwd1pGI+ZBg4ULvvtQqVDb0BzmkC5fNqF3dzECRXJjSWJ6ptfuMcY1AEvXGx?=
 =?us-ascii?Q?cyfP5F/cMCXZd91JjaIWeIwXQ5Vwsp48/wtdUm70h8fmKuDDtWTQGUH9XqkA?=
 =?us-ascii?Q?/HVdAKMJwDeJ7sEv4PSny1bIBoEVuLShRPTYgtee9VPphN+JzAVAu45M36m2?=
 =?us-ascii?Q?mZB5B5BajK0C4hl5oSGHldqIW8Qq29Cu7obGtVZp+6LZiaMbS2zW2aYFulog?=
 =?us-ascii?Q?ShmBl+eB1L9Gh7EuVX1oPesRxW03/ING05/xCYpWI+xkcGmTJgvh7OaCdho9?=
 =?us-ascii?Q?BrHMMNlPg6V+FGl+h0S1jXaKVmuoawK65Duif43iVfphK+GtNjmTSwXuUeTv?=
 =?us-ascii?Q?SQPUuP8FDgCKWY6hWqlVu/Qs3pNCaPCYFybMIJ2qV1vdl/HeP8cql8IOKxqI?=
 =?us-ascii?Q?QAhop5YuLz9QzO6c8CYbjw45EvHuXzFKpCLfyoV1ORdaQ0jUDckJ5r9CCIDZ?=
 =?us-ascii?Q?pgRLcHVVMrpU246C7VpnRpoLhKp3xZOEN7nSECMhc2SegWEHm+ArNzB829rf?=
 =?us-ascii?Q?uZTtkBlOQGvnQe0SvrBZ7TaqU+xvA43cgsjjeVdPtQbNLJ9ElGVgX6UfmCp8?=
 =?us-ascii?Q?LymC11544HLnF+wPzaQhCqmHauc5o7IwmSAWIUQy9KOg4IyeOADUGlUBBuSi?=
 =?us-ascii?Q?145UE0XXkrqR9R4hLOiE8BAeiX1QkLsrPUqiPliee4YAZVLS22OYoyEkuvcr?=
 =?us-ascii?Q?R6YO3N5/YyrMJfB83o33EnhOikkPotwRYY0p7ugBGa3Rjzxfl79SdKH5fMJB?=
 =?us-ascii?Q?GjlT2s9IKKX4+lekclsOWvSn3FFltqIw4UVOx2MS3AXhXg6LzawMblvCFe3X?=
 =?us-ascii?Q?2lg9oPZlweL5T38KR/cE1FH4fSeyDzQnxHLXVYWvCr9fRPsljdJ6mTZl63BZ?=
 =?us-ascii?Q?G1jzyekJluhrzrAWeu1yIY+YnzjoNK6bGVk6gaTGrO9YwzdjhY94LcC7pgVh?=
 =?us-ascii?Q?u+GUhuaL/cqHR1QCiABkFFzIWfULtpLbMNVRGMDtoeHScDJCNaFz99bihOpN?=
 =?us-ascii?Q?G0/y6i43J4ymWCpBBpVSEK4Shc/lcfFrnLSwbkRoNA3trIgdWMEUOQLCI7MQ?=
 =?us-ascii?Q?xOIxuxKvuJmZ4Vw/qyvXJzK90ARPBrovHmKBZD4EglYmfPADqMlouKsuZ1q9?=
 =?us-ascii?Q?dufKbhbb5Q/CLTuzeV0OI2nN5xTIaqu5SjuDZFO1VNSlT9BS7/Wq2xXF8/zA?=
 =?us-ascii?Q?ldyZm84xzRWx2+i4oqHP8szyP1NuomZz5qFyCJm7/9KMd5c4lJCl0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDR15RFqC9T2bmhukDiBop3Xst74LxyKh9qUc8LhOz/T1ZC4l6tL6hc08imH?=
 =?us-ascii?Q?mSISaMDCKcVjViafbAcQrNGMDZ5HEz5azpTv2ueulLTXQtymc5Z1fX+XIML+?=
 =?us-ascii?Q?G/e04YwpYx/iggOIkyUVrJcPUDMQsbjJGBxXLN54KPz+rHjM28XJXA9tEk4M?=
 =?us-ascii?Q?5pnwXa4rfOun6A9faJYceHh7ep4/NeWavqDXUV9WEecnlPXOuOaEh0qcYbj6?=
 =?us-ascii?Q?PPmp6Sq8SegJwZGGJ2tn4pswxq7FV3hKiFkMkbbXqxUqv50lgOqrOZAVzDuE?=
 =?us-ascii?Q?EIcy/Z8ZTc9BaEgun3vjVAZ9wvHVR3MwVfpBlRto0FMXkf3bSSYu4/82yIvF?=
 =?us-ascii?Q?qYC4eHDSOM8TA8mP0xgVro/9wQatplUWFWtllxFdhJF7Ravs1yzkVoOr6Zvr?=
 =?us-ascii?Q?i+2soffsggCbpsYMBAL2OMNzvFn1+V6IdSGeGfjlX7uoFV89LMGhjUUOt+3u?=
 =?us-ascii?Q?/eCEBsZnE4WxiMd9xcOqHAOGHz7GQzgHwGx+E3+AUcrppQwax1S1ytxvArqk?=
 =?us-ascii?Q?7oAR9XK/8t+MoYgqn/hJKSLQMAYu9iLAT4r/fvzzT60bjvJELWrLD3NbLXr+?=
 =?us-ascii?Q?wIEjPHyCxpNmiyRi7Mg79sU7WQUJQnp/j2HT9cDOnS3UU3YWDQG4YJdBa25c?=
 =?us-ascii?Q?vBcnIbwRzzBvL+sGOZh6Nr2b5+qSmfIyjxQemSj28W6y9sQvfEusBbjEOLsE?=
 =?us-ascii?Q?hGM7mTfUfOcT9MJ9bkTKgad72e1TmPRVLOqWmew032RvXGRyPrcVCYDOtjI7?=
 =?us-ascii?Q?YvKlsGqMCk8zXzAZskKvk8HzbGOOtTf4gu1n/lZ5eh9mGdw7kdMZsrSM2ghv?=
 =?us-ascii?Q?+G8lhkf7rKhxYgrx3hAPIFbvc2LyOacF0XeDpKIrN/Y8vcCeYm6S6qyNNfVp?=
 =?us-ascii?Q?NCk9jS+WJgxPR1yHWBPmFahAKxrBE6iwCK7A1cFdJ8QXxlqHBqmMe1pGaDKB?=
 =?us-ascii?Q?NtVYoMjF/UHkqPEuLBn51fcpjh2Q6RFrH4u6wFVDh1d8GOdyg1pW0FzIKV9A?=
 =?us-ascii?Q?Y9NXVpcg6IGl9rWXQXoP5qHDZucON185aF7Mkgt7BHRP825bdl2VdYXjQ9Bb?=
 =?us-ascii?Q?FzJu7RRBv2RlJE1hN05rCHFtzKUvp2Wi29Oi+UW3JQOmVE4Hglhv4YHKQnh/?=
 =?us-ascii?Q?wfMoj7t7F69UgPfbiKnwSBByStQ2n4hMVzv4rFVSS8A46Kh1wzKFO2K0McTx?=
 =?us-ascii?Q?VkXfLzyyOMZLGXV4ELDYssDJa4rJukulk1w8chY5pBUZjLw/4qQL8xzJSB7/?=
 =?us-ascii?Q?Lgoi/mQNx03e+1BWTwe+bY1WgO9PTpNqPuDKgFaHq4Ik4nqzdhTfhSxhtY83?=
 =?us-ascii?Q?A236jDA5QPoGeX3zEaefxW4OakV93PGLHXEKI6kl3rK1XEB7PEMCWItGjVwf?=
 =?us-ascii?Q?ZRHN1QgfY8jWmTW7qRynaMCYQkHCa5fxrYNqjRMpwxH6FlUEWPC/yyIbDd2I?=
 =?us-ascii?Q?aBXcO9vpej0WOjCcYUqeOl2eE0uYLmNFj2JYVtw6/ZaOgVga1CmZHygE4ciQ?=
 =?us-ascii?Q?kxHCKqJJftdrPsMXQQ1x/YsDpkl12183NiSodi/w0WTknpJe4pbC3VAz9BYQ?=
 =?us-ascii?Q?f1ttOMz/cT+FPyWhKfTAwrss6z3yRpxgCX9090Ar?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d117ef0a-0fcf-4a71-799d-08dd4ccfbb9a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:15:24.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpAXH05CO3mpwgZX6hydNhMoViXDWK+mxsjZ73oCqxzd6LeKFgsOGrpXYkowqqEc/APvTtjTClo9Kz5KRaEkbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9629

If stream names of dai driver are duplicated there'll be warnings when
machine driver tries to add widgets on a route:

[    8.831335] fsl-asoc-card sound-wm8960: ASoC: sink widget CPU-Playback overwritten
[    8.839917] fsl-asoc-card sound-wm8960: ASoC: source widget CPU-Capture overwritten

Use different stream names to avoid such warnings.

Fixes: 15c958390460 ("ASoC: fsl_sai: Add separate DAI for transmitter and receiver")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index c4eb87c5d39e..9f33dd11d47f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -994,10 +994,10 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-tx",
 		.playback = {
-			.stream_name = "CPU-Playback",
+			.stream_name = "SAI-Playback",
 			.channels_min = 1,
 			.channels_max = 32,
-				.rate_min = 8000,
+			.rate_min = 8000,
 			.rate_max = 2822400,
 			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = FSL_SAI_FORMATS,
@@ -1007,7 +1007,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-rx",
 		.capture = {
-			.stream_name = "CPU-Capture",
+			.stream_name = "SAI-Capture",
 			.channels_min = 1,
 			.channels_max = 32,
 			.rate_min = 8000,
-- 
2.47.1


