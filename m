Return-Path: <linux-kernel+bounces-446719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B79F2867
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D941885011
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB118E25;
	Mon, 16 Dec 2024 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W59GdtVY"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134548BE8;
	Mon, 16 Dec 2024 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315136; cv=fail; b=M4cg9U/HHsK6pj4LEIWNeIGTCxrYfXWLsAOrHOAvDXWqUDp8UXz2UTbt5uXir0yX5JXJLqHBM6pPymXPekRc6tpxno119+HFni0eN2zgVoNdVeUIggcnQIfLFZ/qSaHB0mbo/47rpFrw7ItOWLHMTYbTRI2fow2A7G8hUpszRVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315136; c=relaxed/simple;
	bh=RobLszullQceywn5t2KsGvXTU9E0HwQOpYmCmZGcsFA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LJXTqfUSt1mTczdSQIkF+yDVW5cio0vDMZe34vxsJIom9rckeOCf4xHYcm+ymgiwj2ciu/oma1hpK/IbwIx5zDHjKa9XmP5JjwvCp+y/UPMGrOrYO+xh9DOFBtHKLN4fGCKUiBn/fkJGXJ2nmO+Xq6qCZsJSKx9Z6pPygJvwf68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W59GdtVY; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=styG+Z7Gy16a96T6SfAEvKZzTYhheEoe/f5m+0lgaLqOwNS7TmT/6nTcQXHHlnkCO0uNghFcUrNSrD/x1l9EWPzjtNHnebNkyvrPhf/dFRF6ak0pWJzgAtrMknmYeGLO0R/VAEvCNX2FiSADW40I5l04fwg+2ziGuCXnWjzqvEskgRc27j8duO2aZQh/dW/mgCalndOLtS6YtJOISkapmqoBFd1kafSvXI1yhbCWMo2Mp9gcUJHrKwMi9OGPYwTfkYpfn8/jCxIJST8kQeacIdEUm+hdG/FDlOzXTi1LMc2AgpbzB3yiwtkXkDkByMS97Au4/reRF9tpGb51au3cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czNPFLqoFHMi+mFuVpGbawhekDfw3VPIEY5towpSYyA=;
 b=Jm81T++Ov7CYyx7M0874bd7fL7lRpSNjXhpeHNMEM3I4BAyhzaoudCzBopN3fRB0EaJGBJ34mplpYyiqkdOCe9UiSGy2aUw5js5sKnL/CT711dYyRmVDbtqZE2ke29Ea/D1QfLP+I9g0383kKNoFM6/wzUUFZDQSJ7vM48EhTJ3fU0Rz4LAlv6WaZf3CSPO6YJjA3kSpr6lFqqFEKosLwdATb9nCx1T+nRXeg5s5gPnqBqH/p1J5KBkJe+OcasgwuH0KWqjC70nvjtL5rH6OOf7cvqWuuCkGcWipDBpcsh7DNdJ4Nx8GgjhyCWdtaej5qMLxJS6KqhT05CfouCt8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czNPFLqoFHMi+mFuVpGbawhekDfw3VPIEY5towpSYyA=;
 b=W59GdtVYEVfu0brLH6gujglzcCQxVMT3h2P7YI3LHJkIGYXLbZmB+F9LQ3oQ6gf7MwZ/mpdr4Dx2MwK/nyRDJhQ8I5gP4u+ucxGhq+C3rM/lnjMj7p5ROXG3qQU6UiYRm9DAL6EP1mBdVxhyMyfERoajQ3XMqKHIHXhkN9cZB3Qzv7tdsERwsl0jaJfG90/zrNsd0rZPl5X55nhdOrWLv5MQbXzb//sJLKTAKaQIWvvguySjuVbkhCCv79UEeirJsNcFx7nO5hCON3UrJKASNxqpaeRfy43sOtaIwqjEmbtI5j/PURausiAPXX8jnYE0rp9BLBpalO9hzeh/8pQNZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10024.eurprd04.prod.outlook.com (2603:10a6:150:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 02:12:11 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 02:12:10 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [PATCH] ALSA: compress_offload: import namespace DMA_BUF
Date: Mon, 16 Dec 2024 10:11:36 +0800
Message-Id: <20241216021136.3763127-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10024:EE_
X-MS-Office365-Filtering-Correlation-Id: d82f8183-13f3-46af-6742-08dd1d770c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAZW0k9uq5AMt3moqh99L6xjfKUVNDPQeKBheVK+5kKllzZV5/48JuONC8by?=
 =?us-ascii?Q?0GwppgaBOjrFod1PF5IS01WIUyoG+fR6HOOR9ffrNH2DT56hY7QhpldsIWJU?=
 =?us-ascii?Q?utkDe612N1A6EuDY8pBmdLoONKM77kaLtloCNbC3/kQaDq6C2EYGC6CY6G1f?=
 =?us-ascii?Q?fhrF/dqYXivjg6xhZ5dzCdIPIhr4KeaaRBZLjm/PFPryzJ5R6DB1ApaZxb5E?=
 =?us-ascii?Q?TETLa8aEXg3G07XgYZu7xj2XnyLKtgRAHhIDd0ZMCYwZTceiabxHL3GK3e47?=
 =?us-ascii?Q?AsjNJYYhYFP2MO/QU5GRz+Vn0LVGpMBYS5jAl/eDbvv8XaPTGt/EBYrxN+yx?=
 =?us-ascii?Q?lKbXAO/HHMO6e7kwTwQ7RgbqK3Y9KLHUh+vrXO9gsOVxFZt2uFfCItNF/dP1?=
 =?us-ascii?Q?lWiyRIH2Ndp9JZCYKsbIMR1HSi58Nv0d4QmgsRSocqMhfuDwdvVrDDt4X9DA?=
 =?us-ascii?Q?9hGxmPi6B5T6rdyQ+EKSyjzeSZaaYlSJNXxIMJRfVvkoaG4VwJsDSbBjoVew?=
 =?us-ascii?Q?ytj/voc8JaIs1sf90RuK8Q2bUms9QemtkD6XhKpFsxpHCf0KzHWgWduxu4mw?=
 =?us-ascii?Q?TeGkOlaqVm2tz84n47zTzoJEltwPZ7b5rFj9BuGZwqf2KKOYHkvJ5uJSsxV3?=
 =?us-ascii?Q?0tvBDoZxlAP2VcPZ9hN0g4xmP9aQqpquU1yHMWFJgjtPkND1clQL8BUjHlD7?=
 =?us-ascii?Q?p+4S3f7q7w05Dgr3nKIYYQBS5Y7a6IAHPDcZMa6OPjrWF/G2mDxksSr9fxaF?=
 =?us-ascii?Q?jeH//muOi0XZ2fyYDqa5QD0M84Zr2nf1qz3a7L1oGvF7LogY+75i+Mkp/5N1?=
 =?us-ascii?Q?nYVoU0IkIEcGbHpCDUj0ohbSdBJlT+/YFIfF/Sa63R40v+BXm+vb6ga4SnFu?=
 =?us-ascii?Q?IUAIoTdy18M1Hya3Nm9L/JvZjW4oNyhW4IypnuGsZhRLNlccalE4AEA+o2Rq?=
 =?us-ascii?Q?FfB/dSt5ZZ92ltZRsyGl4LMFXCQQTojIdl58hWAsDTW09gxcG3m2Q3s9IfnR?=
 =?us-ascii?Q?k4x5YJ0KLKi17LQH7RYtlh2PEgy5EYOJccSiMykZnGUONgXVWOSiHtcBRCFv?=
 =?us-ascii?Q?c3MvA3o0viKX0kZZw1pSU8vtaoCdGukfjCo3nV1eSnnYqzqKfcxR0dEcj9gA?=
 =?us-ascii?Q?bMKqoJTMOy7p7CHjvJqKXFPwvEOUKk3mSoVRifzLd7GknxZYSEx/ckvFfQf0?=
 =?us-ascii?Q?kdP9Nii8JmaDK6+IvoWMb78aVzwzL5FYx0oAB2Lf/8VfQp1SUUFRmI0wJcOz?=
 =?us-ascii?Q?HDkaRcfesXhw1bU24KW4Y/GkpFD/OnxixBhBsf2+6Pmf9rwd1R9YnJditr6+?=
 =?us-ascii?Q?oyIXyzKOGb+ss4UC0Z6anBoTa9gmEeMzoQI72PVVd0VpR4nKypOz9N9sLFIw?=
 =?us-ascii?Q?AlwEzIUSwsbrv7JQkqRhvDY7AjIZv5iu0zdN6IJ8O1YPlz9fymfmsBx0KT6I?=
 =?us-ascii?Q?oyR3zoosecAEmAGMkDnrBfn6/oXMQ/9V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YOmKDv36kQhNY5m4pPlo8aGtqgIc/tdeOISUQ455ppCEEreXvy5DwKYg/nS9?=
 =?us-ascii?Q?x87n5W0brvqoW/uQJHex/lJomkF1o+0c1oBCHb5INWMj76Ju6VS/go/8ZG9d?=
 =?us-ascii?Q?xnuQ4ULmF6n4Gs8TnERWVV2jd42F634+jaW5b+8G+xaFxu599GJvQQ3f1U57?=
 =?us-ascii?Q?gLkKTVblGN89sk1z7u5ZxK1jJdlK6/g7JrQFqyQgIGbwO0coTgWb+HlDYbBt?=
 =?us-ascii?Q?c2viIFYWSsvpj+CTxJrhDs3a/6Tj9Os1s8LEMXaTxgiJ/qF1DSz4+Q5RMTh/?=
 =?us-ascii?Q?Wr+IN8EjIJlQ5wi7wIJp3NOYH7cFSELf7+a2o8m0DbThFr3V7j18MWniva6/?=
 =?us-ascii?Q?jvYd9lcokLVb5g6cY5g5c48wOBEyZ4DDeTqGJhDZ57bdbf0VBtr5Ejyuc+jV?=
 =?us-ascii?Q?voKKBKr4ALHfYVAR+ISpx4+xzWQ5gpR46W43++AdlWZbqGzjWea1aqgETgmq?=
 =?us-ascii?Q?3JuKqcrsmSgfT5plqSGVi2YofCF++2S/ijR9PKeSvv+a5Shk9yVBDpr/jA/k?=
 =?us-ascii?Q?RaTxFn7j0FnKj9sBROy5ToIhNBvQmpGnySapnggD4lRi4ooOTM+cSkSOQWvz?=
 =?us-ascii?Q?hgJaGfUK+BRTlUo0KeFGUB/59kPzEgCqDZVZYAkg4/HnBFUamtT4SJBJcIlL?=
 =?us-ascii?Q?LZV0fDUqMDr3QovQY3Tm6tsxX4NAVncDWCJdsL5tDzyJ7jmRE3zeiIBTvaTc?=
 =?us-ascii?Q?+8iyeK51fFViCvSRapDTrvX0VL+7+eOj5MUMILPfs46yrbeibQmb0rWVbsj4?=
 =?us-ascii?Q?0Jd6tIoA+4+apGhLtixl3URiD5DQxLPHbRdnUm0d9Xt/QfAyaPmpxCzJZzsj?=
 =?us-ascii?Q?kWdeAnFVLhk3q4FU8uvuyKjmvbW7Nfp03F6rMi42xaTA90T+FJgOpAGq5oeI?=
 =?us-ascii?Q?P/v4SRP+wx6rjP7LU/DeTvd0R3Ei9u8UnLhbiUqR4PL4RFYD8+gffJ303XId?=
 =?us-ascii?Q?p/zionm86pk7syzo8adOToR3vpEVbj13qkcejQmh59XkE7ORo5A8arlNB0yJ?=
 =?us-ascii?Q?uZRPLF+yBARDokZe6tUwOmadazfrukQotxlPi7gQQk9NVXL0WcZXHvo46xRg?=
 =?us-ascii?Q?izjf4TPbExZfTivdqaxCbUXQd6iz8ZsOBt96srqpDXSQmsg2mi5r/kCR/dEp?=
 =?us-ascii?Q?PbI+x9m7JVorMK5TBnx5257X9Y1NXd4tinoleIFx8d0sqc/Nmk4vtlXpMmtm?=
 =?us-ascii?Q?+rrEOGP5/TfuyBYKCUIA6yk4yIX6xtRIQg/97rGQBXRsINcEa+amGrUpii0b?=
 =?us-ascii?Q?X0KIixEj3J72MJ794cJomDBLc+5dlypjjYfiBaKiL+gwoIxmuzsYnBpsOLb9?=
 =?us-ascii?Q?qfWexv61CtMab61CrNonQc/N8YqsOx1DZKJ8EgQFn33UKbKbAMIGZKFi0ck9?=
 =?us-ascii?Q?SqNhBtamVoG3fcgLYAmgLyg41x3TfnoZCObDB1FR2VKU48LW+iWZYMI1g0S7?=
 =?us-ascii?Q?/JfiKeWo6tsWYdobUYLhIMxN5/8P9cKJhKnMCm8SqsMQ8xexmvzDFQIm7FWH?=
 =?us-ascii?Q?aZ9915E1aVIu1nU9vrAxvybq4mo0eGNEFnaY2NXFdjBe2Ko0GDaqiy4aNMLy?=
 =?us-ascii?Q?LaNq0L35D3EuGg6AcWuZ8vCtnIM4eMsyp29Lx8Fy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82f8183-13f3-46af-6742-08dd1d770c7f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 02:12:10.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oY7HtXryutX2zcLEo8GnkQjQX+IA+6zG0kC68WwVTMYdQGIuJw8sGcmv1GBJPaaNMMFyg84+6ZwxY6heUs7r3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10024

Fix below warning:
WARNING: modpost: module snd-compress uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.
WARNING: modpost: module snd-compress uses symbol dma_buf_fd from namespace DMA_BUF, but does not import it.
WARNING: modpost: module snd-compress uses symbol dma_buf_get from namespace DMA_BUF, but does not import it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412150026.EMUdbO09-lkp@intel.com/
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/core/compress_offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 86ed2fbee0c8..6f2d389abd04 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -993,6 +993,8 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 
 #if IS_ENABLED(CONFIG_SND_COMPRESS_ACCEL)
 
+MODULE_IMPORT_NS("DMA_BUF");
+
 static struct snd_compr_task_runtime *
 snd_compr_find_task(struct snd_compr_stream *stream, __u64 seqno)
 {
-- 
2.37.1


