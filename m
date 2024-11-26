Return-Path: <linux-kernel+bounces-422264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F0A9D96F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FC7B27579
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9EA1CEE80;
	Tue, 26 Nov 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLGW5jjv"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303901CEAD4;
	Tue, 26 Nov 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622119; cv=fail; b=o2kJuTPrCtKhxoO88c5bFUyXRyq0WnK8hKIm8xz47aXLhJbWfveEr3rwNbEXjjXY5Fc+N1GXrOf5//Ee1XfIg5e6niAaoojePq6uk4S//WSFRFshjV8TCH8G9+wZJlivlmMAKMI1Dne4nVTH4rWRaRgpYoYqtznzZE3Stj3HACc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622119; c=relaxed/simple;
	bh=icWf+E5D7M55M5bvYhDe8mFs3PSyCMXt6G/CZV3lrPU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pq4ShlksC8CTRUuuSx/iFxAfmO81dh+IvBTw0ruz/u9k5JcDHL01YytwtWBNTgC0eZvJ3//q+0B8y8uvR27LfS/8EsIRg2rlQBDct3mwtWu9KRR2a6fzbf0QMraqiocjowAi0BMuw7zqb7KvjBXMHJzz9g3kMrspn6P0Nzs6G1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLGW5jjv; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDIAlEtY8bM5YEcDYKkaZT0W5kKtwSt9EUwbVC4xjolzxWepVMLJWPozAP74Ol5x8S9AcsWS007sOU15jypzsKZ/Y0eJ0lIj7sEhS4O1H+L1prxocOpnmJ7ZJyfffZc6jr83YG4Bix8kvBe2mAJCsl3K4pApFSD5iT8vZGkkRH/IeD3iHOqpbu7BJn2VM2e4J8Q8OypLHOdel5gq3N2/UO99mGmXUUoAI3oGIn8nqv9DwiFrLjw4u0CpFJblUO8UBvXlTMhikPWa2l6BuKrRVTW8TPfat5yW/PUM3pIl/lQ8udCTEFDL53WG7IxJFQH41bSAH2PgqrflLPYrLWPF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA3iiFuck9njuehzcbwLC24MKtMs0Ec5b9ZKlQYY8fA=;
 b=YMXjokwQH4UYvG8iUX0D5im+DL3psgvPeOWfY9kpBe1kWLkV+17nUs4yD5Kck70RU2T0bU13OFBAmkt8k5vjkLinZabwXTMwTkghOM1m1w9AN98QbbPlb43QLSooTQCbJ7Sms4OEyaBIFjzQVeH7OchrWZwFh/HEvsDbcC/Gfm7PmPkcanPF+0ElqJbI1G0fnXi03yjNkLcztmNeUQWUN8aHHv55D700XiVAIBtwkvdtSKz3izgqFT3YS7Z05tTq2ri46rtgUiCLaJF5jQgEaMMinzckzYz45dJiljTiAhFl6vh5SykQVcmxYGuQODyPd/54oEa7ju31jMWyyIVA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA3iiFuck9njuehzcbwLC24MKtMs0Ec5b9ZKlQYY8fA=;
 b=WLGW5jjv9V67ZM0IlmjLkGdWq6XH5wfrEQ6ogIyCDiGTKfO9piAfKkVMo4Qj7ip+/ls5oa1/Xu0UAZ2pDdBqhYLHyrZ6WGEu8hj8hOBy96vawZ3Y4k1pXxVOmMaYKaKDMk7Ek8nlcCaOBpLKSyzfr/MpI/hAHac6fEXUBbMpMD2ar1hlGzj1QiL0JkXeUjeFjAnTMv5jrYTiR3Vzfy5mcRRc1FqHnliXyjkBFSTFTmumXASwabB80WVKZK9ajXlHqJ+FKbu8DARE9N6tBg41LZO2r0Tonp0jgyhO1uBTBFLECdM6/1G0yaWD2/IdO2mMmw02D0uhFUDNeB5x+1PlaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 11:55:13 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::24fa:6f9:8247:c5dc]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::24fa:6f9:8247:c5dc%5]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 11:55:13 +0000
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
Cc: Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 0/4] Add function to constrain rates
Date: Tue, 26 Nov 2024 20:54:36 +0900
Message-ID: <20241126115440.3929061-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6e38ea-77ed-42bb-f834-08dd0e112f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQ3vzAGvQm8k1XdH4icwUCfBo7JIcKn3WOlfO8vLHn9RsGv6RJSulsOGk9Mh?=
 =?us-ascii?Q?fO6gGbdaeaxhDzSJ/hzeIpQKA5yz+uHpcfl6uie1jou09RqPP7sGc76Joza2?=
 =?us-ascii?Q?DqQl9ni3o6XQEhlqA+xtRl0rcboQb7hwxoDtTc/Uvn9bGTc54l7YC3bKxNiL?=
 =?us-ascii?Q?fW8OcU76A6RKu/B9NJcn9R+N1+ap2wJijPLAdRmgPi9oDbVO3AKfr3VWMz2W?=
 =?us-ascii?Q?SajSCKhzz3ZGXHC1VWOtk+RWDsLcw5mbEaUe/e4D0YHa25X+y61BMjVJVZP5?=
 =?us-ascii?Q?ql0MEnkhVWIZZdm5gumaF09uXFmu5cCGVa28dmmmTU+ay5xkVHHudwakVTW7?=
 =?us-ascii?Q?6myNgpZt39X9RXtKUaRAV4NAwNg1YB3TP+LNAOGjsmtAwLMBFxmvVFkgTuVZ?=
 =?us-ascii?Q?gB9IkZ7b1yNomGM0fB0IWWiBEVZKUwHonJ+Y2KDbQyaPr4Apff9JLjAI5MLs?=
 =?us-ascii?Q?/LLR9qKMTB64htyI4/fUze6E5zfqN2xKQKLOlok/vWZ1Q5TNfuVu+Z/qggOh?=
 =?us-ascii?Q?XPKbPDfqJlb+TVuE0qq9o544lTm76TpjceA7vW7nFGZjpXayKo1h8i5Vq7YS?=
 =?us-ascii?Q?ASjeRFKGl0LkK/xHCAtdZ1/6b699TxDtZYfM19yoyncwyHMfYRwYTlKw4X8a?=
 =?us-ascii?Q?v5KWdkuHdjUk1tYBa8FbjrLQUCtRRNbWkAx5QBouJxNKEgjHKzj1WCbj4QAX?=
 =?us-ascii?Q?JUHy5RS+VsRjCusHGjaANyM+3oL+K6y4l3X0PPU9sAhnNjjyOCAWDqr+T0qm?=
 =?us-ascii?Q?Shil78zIhCs61SWHCVsIvVgw/BbrLu/HievQBsAi4XBGts2GU9iSWJpUjGs9?=
 =?us-ascii?Q?iOawtOFXV3QufcMWftKYqQ9UpBd7zqIsj/8WAZKICHkK3XGxPRmE0HeBhFis?=
 =?us-ascii?Q?v4EiFkDmvIoqmgPxQrN7o7lEAUpNk+87uSvocf/hvlOkTgxQVRHHGNK8E4S7?=
 =?us-ascii?Q?FTa9/EWn+7mo7+rBVTgAlthXZ2Tze5k3uiF+4bNgGh/6UMpO5KESF8WF3VoZ?=
 =?us-ascii?Q?Go1NyvCJaS57Rrvhv6IY74T+8j/4HUm/QKy2boHE/y+LSs2uFnYJK4rT3wRd?=
 =?us-ascii?Q?dzQsRWHKN++AJbqQDWXmw3u1FFMYoig+VYWkqCI653GpNGNnKGQniQVN0jbG?=
 =?us-ascii?Q?Rqh/yUuVR7lrlh6bD4FWO9xv5o9u7OTMywszJrN2PKgJe206U2abFStExnTg?=
 =?us-ascii?Q?APLKkl5Pu8+NgWWQ2u4S+L/V2md9DMr4tH775qIuIE+nh6nV1056QC7d7JRU?=
 =?us-ascii?Q?tT/QK+Pks6a7YrAOl7+3H7pKo2zVe38+1va9GrrziTshXrEPlC3PZxfv8zHa?=
 =?us-ascii?Q?m4C6XNHWQn9BPxp+O2lHBvRAJLTNJonMZYy6Iq8+XGAQX2bI4XuMqmMmnud4?=
 =?us-ascii?Q?oKZvz70GzpMsBpcwE3+v+5TsMotpYU55tf1zCjU9giobwsiJKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vX0y3jtAeel7V/efau3oWVeOM/Op1Dv1J8Ny8ECC60HlUCLAhHfpRU6g70Eb?=
 =?us-ascii?Q?JZf11SOoxBkPC5LhdJRCQumoY4y+H1a4cpqAB8PWGHsZPaBO09WAbSYLMNo8?=
 =?us-ascii?Q?FalMGpZo24tsJmnhLmSErT/vVWyVDyQI6CefPqWUSbLQTvzFGYgM3X28pVQO?=
 =?us-ascii?Q?yjJha6aZq1zhrnjg0BLahBYnh82d0atZU46wQUsekiXshaqDQxdibcMsE67w?=
 =?us-ascii?Q?soNxLvcfuZC8rQPlLqG4eh8a5LbyBGzEvxEYhwMQhQG4EeZGrw/rqgg9+tGS?=
 =?us-ascii?Q?shYxnkBu9VphWL/ujJXdFnV8SaMKwm6WSp8NsyoSmQwAwohEFfowOVW1vGkm?=
 =?us-ascii?Q?d6BcQ4lFzfLCPkCA9HFvQHFE0V/De1pf6uy56Q6YBgPxZPRs3zV8GAvm327F?=
 =?us-ascii?Q?9LPOHA0GcJvAEghPSha1SJfL16xowNdIR4lovfTthXiIIvgN7jBgVddK/1mk?=
 =?us-ascii?Q?VjoazbzXnVBVUomBFSglk1WA8m5KtMIrISuXL1LSJff+H/++X/Q0Rc19oauK?=
 =?us-ascii?Q?Posk1BsPoK2hOHk1/1QF+ONCF4kqpiuwbEi633I4XSJNAmQIWfoDUgSsCK9/?=
 =?us-ascii?Q?nUI0kP6M/z6Z9FYbTARNzwSt8OLYZ79Kg6QvKDmMCET4IGd/DjHziFFZG+yM?=
 =?us-ascii?Q?km2AnCeyNkOqnz4UEWU1nec1YR/TJa5oC9nfyWaXZAY2BdBVgVFoiAuhxLF0?=
 =?us-ascii?Q?l7Blr1FzWarVXeZ1RG6LRjIkzk0GJua3NtpuoufMOyGeBjByEFTZwKQWuLh4?=
 =?us-ascii?Q?3xxuYSdPjA1p58rvWIfrlPAPeWQ+UGubM6bh7h2EtJ3qrVbS6cadlJUUmwtL?=
 =?us-ascii?Q?evUIYYyhVNjrroQEookWHlG4euirdsbCeDDf34floCiFFj0BN9HHfMII9NLS?=
 =?us-ascii?Q?o8d933yCUQ5ata+NAbx9W/skLg7+PMs91Qjmp/w2DHFxvlhpC0J0inquE5Vo?=
 =?us-ascii?Q?8gldq/qh49t3JQEuilUlU0+yRAfDJbGEZO5CJ8qUsBBGvtxL+LmI5lAmM+Mq?=
 =?us-ascii?Q?OUAU32PHbPXdT07EEJytfWQycw+sV+Hn8sUs9DCyBFWBKBWFQIGjoR3Gmlef?=
 =?us-ascii?Q?oOMet699T6sOrw4BLaVHE4f7oYINkGizY4NQXPYcpCtAJgDCZhEVIXhuifyn?=
 =?us-ascii?Q?jCT0QmXOH6Hlf8P84UA2vk6HGpiXdWapieyGMTEbVyul03WDXbDOWJrkYi2j?=
 =?us-ascii?Q?YAXOQJ5fnVvEPi5gpWyOZQYmseb4M7vy7MdAqpeFf/7o4mAzzKfkG2eOX47O?=
 =?us-ascii?Q?goBoM3cqk8M4xEsVXYe3MM3h5xXPSGQlHvuZAmErmOmS4eqeBFgdtho8sxAw?=
 =?us-ascii?Q?+4JkSbEmkIcDsRjcuW5hq2b1Fq4LCklPVlr16Vymeq5E0tyMRkWwAWRcoCvS?=
 =?us-ascii?Q?x8EpnIASTg/QKLqjRvW5QkUyVPGOhIy+3PDNzp+o2ReUGUzMpm117J+2lZl1?=
 =?us-ascii?Q?Sev/0RmkfFJJtIzpC4S2fzpzHTmdmG3e62Oyt9v0jxLmBjlI2bLafQhbBI5Z?=
 =?us-ascii?Q?Cngyda8gRM5nGmaIXSNbe9FvIzRyNX2CJeALE713+R/WTiaYeTmm7tKExMHf?=
 =?us-ascii?Q?Tz+rc42lVOG0dhRyf1BrP4AXKTl6/WoKTA5davCx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6e38ea-77ed-42bb-f834-08dd0e112f3c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:55:12.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg/PWaAsrhSR+31gcJGXLT1IMNuQ+m/Z5WgD3MkQkH7FdBsxRRcrI3voVcqcKJyGbKUBBfwIIB1+RY2/OSvEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

Platforms like i.MX93/91 only have one audio PLL. Some sample rates are
not supported. If the PLL source is used for 8kHz series rates, then
11kHz series rates can't be supported. Add common function to constrain
rates according to different clock sources.

In ASoC drivers switch to this new function.

Chancel Liu (4):
  ASoC: fsl_utils: Add function to constrain rates
  ASoC: fsl_micfil: Switch to common sample rate constraint function
  ASoC: fsl_xcvr: Add sample rate constraint
  ASoC: fsl_sai: Add sample rate constraint

 sound/soc/fsl/fsl_micfil.c | 33 ++++++++++++++--------------
 sound/soc/fsl/fsl_sai.c    |  7 +++++-
 sound/soc/fsl/fsl_sai.h    |  3 +++
 sound/soc/fsl/fsl_utils.c  | 45 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h  |  5 +++++
 sound/soc/fsl/fsl_xcvr.c   | 20 +++++++++++++++--
 6 files changed, 93 insertions(+), 20 deletions(-)

--
2.46.2


