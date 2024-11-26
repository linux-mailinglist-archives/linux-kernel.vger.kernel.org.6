Return-Path: <linux-kernel+bounces-421880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9799D915F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF11286A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC2154C00;
	Tue, 26 Nov 2024 05:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FC8M/1lm"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D828FF;
	Tue, 26 Nov 2024 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599218; cv=fail; b=Cb2PzARvvHLmgfwE1zXz1MxWg4WEOEl1SffqFSphwStUMjAtd6ycL3aiwLJxVerm/ZmjjIsM4Q4sVd15SkRSSWi7DCHK3nlynXg+SphSEK4pqQeORvMolJkpsAV2GEYDdbR1jWV3zlr40TQKhsgZfGGiXcr8Em15jlnCbgYHhgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599218; c=relaxed/simple;
	bh=5uA6kgruncJ3l6cen+NPwG5Asf2Lg/D9+nJt8++pN2Y=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rgw+WNn36F2KzGyhT6K1rGG7ZBEJsHlgmgpvFSn9xpT6ouP8e/ff345DgfislEZH67RdIL+X/C5QfpVGjWmuTrGerix8OU5c7GO61ZNl3YU3ha/48SarW7j+ZY+tWQrwP6jKlQot0pZdE/WZJF15TZOQTbbs70CO+2yU6ZepMSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FC8M/1lm; arc=fail smtp.client-ip=40.107.247.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdUCNur/pVrz1xIlSjQImazJYuKwLmPCbev+qTna1P0erzept6NmD6QLlb7qAiv+hUE/ydGPihGem+3H77ULIOSZt6gC55wBmjSJYCjFxMJbNwKcAa8COCRe8BLaxZWbyul1Si8dFX+4UY/TZNQ+sDmt7hFoJ/gtvf0RtJDDETZ3+M9wLceij2SukzY6KzSnqwTGWgdKivW/Gg3WRFgN/ajYK5l3g2NUuZj7XLd2nSbs0ir4xnaFbyMQJ4jBRpNWcN0wIFZe9ldVXgEvVXAbPMcxQeJFo2yHDRkQ4SH/sgJOJslV41Gj1zqBz1e3boBtGT9vd3M5EMwuo3G/htYgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhUBP3FrCoZQtefOTIVNv/5nzYib9+nrZ+MlfbWOxNA=;
 b=nBD49rBwhDh5P6oDZCP54CR84p0xZQWchwlI0jGTG8Se5HcVWuIEtuRBuU/3cNJnGhANqKnXzBHfroYjqHNC9selnISJdAnR5VvRcHFUAuIACwwwzbDvQx8r5oHAPIZK8OnwGhAiVS43hmIfyY1t8G2dOtjQKZmLl1DthOBy3KCEZxlSoKWU+BuD6SooGz/HGLnxoaqHaxyC8qCK/6gNFh1sttZXaSMR1DSzP+mhIxJIMD74tGxTsJVZm2/A8++gIDblfSGsqpceaXffQZtOGsmVd0yXZmo1eV51BYEByAYk22UuhnPvMmVlWRZLL/8bbmtabc+Yf6dtfQ5OEnKW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhUBP3FrCoZQtefOTIVNv/5nzYib9+nrZ+MlfbWOxNA=;
 b=FC8M/1lmR8TEc+kyFdZlWOeK3Wq2vZrcoV68J5qC8KgFee/eXu5OcKtX/LLZF/ReTcbMNzrvz0JF9fuVm4NjlGvn44fERzz4IJPmtRVhiSF4ugrxy1NspMoMLaPSIecdpwoPKOFlvts1ri34d451n/JsKgMtsUlJOz3wcZsk6J91a+Fw9tb410t/LIgyI+C1EGou0q8GJI06RpMlQzzME+ilRWISeBRa3HpdnEYhAm3S5rmLx1Gmvu/iwedHRYKcDujg0ijJtfHMN+IDo7tFPDYQyFnFagQH8CffGnJNfVMgEvlji/NxVWDU5OEZgaRO2FE0aSQlvxNgjNWhMb4iog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11071.eurprd04.prod.outlook.com (2603:10a6:800:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 05:33:33 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 05:33:33 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ASoC: fsl: change IFACE_PCM to IFACE_MIXER
Date: Tue, 26 Nov 2024 13:32:52 +0800
Message-Id: <20241126053254.3657344-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB11071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9e63ee-4b0e-4835-8205-08dd0ddbddde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wDvfb0sjxuk4kf+rB1tyUdN19kDJgvJC6BkI2f+OPrjItiysyG91xlontop9?=
 =?us-ascii?Q?srJwauKlUis3SgI/uWDl93F+1TBntic1GyZcYF291MLRgm6ysNDUM1tMZyvK?=
 =?us-ascii?Q?9GNGbT0JUir0OtjjclCCjTSLUUIyzsKTp5wP+H7+jauzipCxpKKBHcNuuj5M?=
 =?us-ascii?Q?BUEzgYkw7LvLoVprYJS56TGw8Ir8tvqKc2k9LjFZgzcBqZoR+HacOWruQT27?=
 =?us-ascii?Q?e+whufnUlutI7wKjJhDjl/Iz0EY0ojgz4IhMAoYxZ6b6fV7NswvIKJwDDOnz?=
 =?us-ascii?Q?gvZ0ogcVtiXVsGp5rO8aFS0LRxlDqVerZyo01LZmRZCEyk8XsmpmVNGj5mgZ?=
 =?us-ascii?Q?o2FmxTbEy1yn4KKbDvTIBkPgZlTketchDmZPhuBA2jaGvVDV9Oicir4MBvqN?=
 =?us-ascii?Q?VUYSD7ipEww0jpz3eIazQuf1Uzmr35vLMwoQuM8nrVwKKZlKTsqycp+ztcji?=
 =?us-ascii?Q?emGArGewYQfjkTbc9zQ2iayhrJP3Qno2dUXEOVBUBNefCfCUhZKyq7T/POLP?=
 =?us-ascii?Q?x1Q1DAj3PaocadoRoqdcuoPviDYB4J3IX3Nr5PrOBCGosQQQaGvhj5CITA0+?=
 =?us-ascii?Q?AYUNmUOhgR6ANGHChXnYHojopJ2hdr7SOp7V3MAJpxf+2LZs33cvhc2j+FQL?=
 =?us-ascii?Q?kjH6ovDERE7FehZPx9OgS/4uKekPH0fBS1ScLQTK9P26ZWPIeAK+8VbNQNhX?=
 =?us-ascii?Q?XIRIRQU6ao+t+CIDrRpuUOfqVGsLdab3M3wsYqMyK1Zoo60vmu6EivXV8Zmn?=
 =?us-ascii?Q?U1loXMz0CIFBVRch6dd7z5xMCJXRyFf+o4/jZ5t2pWxlZWKjPU0BVwBztIHy?=
 =?us-ascii?Q?og+ByxMEYfBfF3CTC8rqM5LliTNAFUZKha7Z5CRMijm7tqQVTKZ81XWxSULj?=
 =?us-ascii?Q?atHmK7Vtq/veKBOKIM5Cp7jXao/p5vR66BUzniqWI9b6i7yTRlMdXeRE3Bg/?=
 =?us-ascii?Q?UhAxjWOhyDnmROJBINANdJaVQQqERl3Xayk8cOt+knGpx2XeK+vWLe84zdjL?=
 =?us-ascii?Q?zd4SiRRq/DNHLsz5DMcqJnT300QhL4hQPt1q8oLbmf+OsQVM9S17GubTHkr6?=
 =?us-ascii?Q?gQshZkYY/spnurwpavpi2eZheeGC1C+kvttUSHoh+LYCe7/axYp0PLmkdyjB?=
 =?us-ascii?Q?npFkbS1xD3RXAlwESp0ZB2kJCLtWTSNMp/cVoUuqS9S9OigijBJQoJmfG3rk?=
 =?us-ascii?Q?d2fKs+ZQAwVZQ5pagfN9wefj+GMvwnGHThK5uqHzPSuL562wNA4i1kqKWfKm?=
 =?us-ascii?Q?58qeG4V/1Nc8bdd6yZlZ2fd03dRqiruBrE+W3GqQq8Aml/QrVaHsT8Zz69ht?=
 =?us-ascii?Q?cbW0I+Dt4qqxJbR0I5eXO+MNsaOX7jHvXU1fL6NNR2o4LgfGclMWwOLsqcha?=
 =?us-ascii?Q?rDX9fD3ndZowwAD/IMyiJdSd4cY8EEPV3d2CQ2oLm7F3ZjDDDu9Cxf0IgG+/?=
 =?us-ascii?Q?V0k9+l1PbpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpWYN+KVZO2qhIlszWesDkeX9OsRBe1Ht38Co5M6pS6YzHImFNXVCDWVt3EJ?=
 =?us-ascii?Q?5/stTTDuNhY5FAxWY5gjiT04CU5Nu2PzW8Dr+tNY8JxHUY/3Mj81b8LfKgfF?=
 =?us-ascii?Q?7VIr4p0XFY0UCK37jwCsF+YwhcuXctMGg961WT/ZlGO5lWwLYk3XZrP2oNQ5?=
 =?us-ascii?Q?FmHQtQGov6VL6Sdcjb1pfQWqkrJEnTLS4xePtd6d4I/LzU1MlEc1vNN+NYv7?=
 =?us-ascii?Q?UJjofyRUaLfjpDJh16R15RWEH9LO/64IKymVqbBfuVwDr4Id7GkPahQ1nNbO?=
 =?us-ascii?Q?tEQiDBqCVnflb7WEmNyfTvToejBBHeyABBnJVQ7Uo2xwqaShV8i63MetnPI+?=
 =?us-ascii?Q?k0bTTD7LpA3Ieucbpf0d2iibXPGaOvDca74bAVL0IKsKDISfFivFec8jQhXE?=
 =?us-ascii?Q?a25WpScJZyakDPJNpi1se8EG94fvZJlNPqiyd/cDIYAK11nEQ9KLbnoqdtcH?=
 =?us-ascii?Q?+jICxTRnyWRy6OhVeQwXnVN6AWe4D84pOoIAIvG5iAbYc9NmS8lZkbpo6nY0?=
 =?us-ascii?Q?uKcUJwvVxKw8Yskflr1M5wrNaeIt0IqoW8idqJFlTKdL2YkkLUw0KrlFGsjB?=
 =?us-ascii?Q?JIDl7e7qh1nxkuOF7eIikSKAJMD4jD9z8bOU5QvINcIsAixYB/tAzSUvprVJ?=
 =?us-ascii?Q?+gd9Tq9tnaptPZ4WUtq34GqcdSGKV54xgXmj7clBJqDMuUjHgPtFKXvEHVDF?=
 =?us-ascii?Q?wd3XmSWgyEFVoWX1wvolQxw1SZm1u7/jyHSkG9ac8+/O74IZD2UqJ4LFBEfF?=
 =?us-ascii?Q?CvZbQdoScumCunS5gg0MLpcZEBIjmOdftHZ79Ei47GAmgVYZ8548922d0LTK?=
 =?us-ascii?Q?/FvSP9DaZJQFo/4K7MY1EwxSpTSsyxTbi/MzXhj9GKJ3FB9WrW4i1JivdDks?=
 =?us-ascii?Q?JXqdInCjwxoY/XPImMY8+Fo30sHNG4139ioNYpeTa4bqddUKmq2US+HsCXgn?=
 =?us-ascii?Q?50UPUvVyEmsVsyoiAcsfyrGTN+KYHW7NilOV1mTEdCOhMalOkJZA8Uy8hkEQ?=
 =?us-ascii?Q?otH9r5PiaS1ggFnThDl/++JTUPKWNIso0xw4OvN90aGm6OCDQbt22B3HsQ6M?=
 =?us-ascii?Q?vKEysX+oITl5eDTinsSg8nhip5VBoZuK5WS68PSejF02+zVrKRrt1w2PkWrB?=
 =?us-ascii?Q?7/MJ1M9Zil5AnKBUOXtXC1wmyJ8UAMDGIlopzn0vVP8VJF1P9xMdb7zFsUp/?=
 =?us-ascii?Q?0EiV8WabZ3zz37YcC4wxlffb6R6c7A3H2a9jw/OHW9yUig7eiVwNQf2toWNF?=
 =?us-ascii?Q?1dehWAFUkmq7OtO4zlbIsifEaRQ6FLInd9ZwnkMDagcmzzHCIriTiRFX0QI1?=
 =?us-ascii?Q?+jhxV/SfEKf95bvuf1bH3dMIaLarYNuoVjfeBORLgmESFO+JAR1NdpxIlpsZ?=
 =?us-ascii?Q?FqeV2BHmZv6BQs6vGXWu8DUfG2pMa80rILowdruF3dTQb55SrRFzPM51WI95?=
 =?us-ascii?Q?eWdpB8kAkahIw8bZ4hRCQTzz/2jS/72ELSjFVzZ7mAOs9Xd9Pw6MgRAShFeN?=
 =?us-ascii?Q?mLc1LHfYFdaUl0KPK4DKbxjyoVggGmd18J+iK0lGU2wngAoqu53aLnebiw5P?=
 =?us-ascii?Q?bn6bvkicBfBjynRgOYfcM66nJfCG4073rc+XNXrX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9e63ee-4b0e-4835-8205-08dd0ddbddde
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 05:33:33.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hncUmGVSpcRmSJjP3oqwLNHDwffSJNM+sTGuBZe2Cq+ApbasYnK7Z9nHeU4aeWd720rbE7QN9Y4aqZid9R4E6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11071

As the snd_soc_card_get_kcontrol() is updated to use
snd_ctl_find_id_mixer() in
commit 897cc72b0837 ("ASoC: soc-card: Use
snd_ctl_find_id_mixer() instead of open-coding")
which make the iface fix to be IFACE_MIXER.

if driver need to use snd_soc_card_get_kcontrol()
the id.type need to be IFACE_MIXER.

changes in v2:
- add fixes tag

Shengjiu Wang (2):
  ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
  ASoC: fsl_spdif: change IFACE_PCM to IFACE_MIXER

 sound/soc/fsl/fsl_spdif.c | 2 +-
 sound/soc/fsl/fsl_xcvr.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


