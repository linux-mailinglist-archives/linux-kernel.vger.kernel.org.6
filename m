Return-Path: <linux-kernel+bounces-446729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57729F2885
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CAD164198
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D014D2B7;
	Mon, 16 Dec 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JHZTJ+S4"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE7A48;
	Mon, 16 Dec 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734316320; cv=fail; b=NMW3Yya7OId5oC3MKN8i/PkrfQO0NU68cmydW8QNW25AoMfV0XjJQcGFLmABh2u6wgPVwdkcTTnSdyiU4c3yl2eUCXCCCagdqpZaLXvU2R6weh4wsTCAQRkncpP0YXf4Ac5g6aPmveD3TC3oesH2Vbx5dEZa9hCW9/IdfwVD61M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734316320; c=relaxed/simple;
	bh=Hta8kLX9k5laQ5duHR/Z6DzVe7R7XftIOdkkXU15mN4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mH1bmOcz3OBF9zuaNy59m9xYwiZrcC37AWW3K10Q3lrBU1yN4kJIL0RYdCIoIvsDQ0617/SvJYTddCXW7xpOsjMsO5zdXTbO0SSIF4yg9AsgfmFLUDtIR/DcxjnkQOVMMEaGbwIx5IgTLaiF1IufMSGnfivEmV7QrINtP6Hl6Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JHZTJ+S4; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxS7XFLLRlUKdz31KWig6kBl9yc1b9j+SH28WhhGZLzcp+5epv/LWfjPsy0dWUPsYNGUW9juPHPYRoRN9RAAiBXcA6BRdYd9pn56ws6ouRp+fI4b4PO8Yxk2UybitdXZdXmlWGRPxZbM8/axVthXRKe6DIdRvzripgitcBxS+gfgFCAlcKe/pkCFznJDBkUSzT1P+LlRNkLrQ+UZlGzxHCFmm1rlSZ5gX7hshzQfADLtQynoxv3P3teuGe7/YRvGSP9lMI8ht+gcKimcRamRk4ccFDHGvRFD5Bw7Dv4EMFNZjwEtFgkLWsBbpTtQ8uHmjtYWG+krVUOL951Aa3eBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv5EHEWv7JXwh+UauY8Q9ye+8jC9+5Kehvjw0xy6P4A=;
 b=G19nS3sajOpfdxlSdAk5sklvHeXupFvDULdfH6tJcV1/Lm1DLEr2WIEil99AlxatB2Alk0n3MlamzR6ozsmaFfXW12E5mmztlbZtuHSen8wuJtRpFH1XUsDFy4akZs1TYWCLJ2U92HSC2a98g+UgMq4ZgbDVwvAXtBXkTSCV6K5KbCAtxp3AVqkp0vuYk2mSH2LwEO8Be6lUAXci9b09dIcoiS2akpVP9QgvtFALNjYTDssmO5z+jR4XCU2gnRBfrTcKYhtNFm9vlGzINVpu4P/FzGOFF8FvGgJAy6bukg0JU5oHlo6om6rw8b/hQb2rudDD+wDQn9PbN8NVytoo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv5EHEWv7JXwh+UauY8Q9ye+8jC9+5Kehvjw0xy6P4A=;
 b=JHZTJ+S4fnsh2f4EE7qd+bbEkyqXkqkKp1zQAj+RDhvGZUASyutrP5hUZjyIUlAe2dDOy9ST0VQObEMhCKO9ZeKT3OZuGaq+9iEw81enLit87K/0GHsYrZf1mcPNdCJgxo9/HPpj+hTd5E/Y5CQ1MY40FGqL5cHsksYtu3SJbg/cZUR8zoVd5dQSQNqlwo9NmxdPBS3psOjJsfTWu5DiFV0C2M1DOr3v18z0pjTnLuAd8SM/AhHqSkq0MH5sFhbbiBL05/7nXkwwDgjqtbBFJUU+wtgBCDH3DEFBBD3GB+lOyojkzVYeeSMMu1849eo6sfn/gNuGmY0EtYvQFBY2Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 02:31:55 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 02:31:55 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [PATCH] ALSA: compress_offload: Fix get_user usage
Date: Mon, 16 Dec 2024 10:31:24 +0800
Message-Id: <20241216023124.3817798-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a6c38-6006-4223-6efc-08dd1d79ce5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UM+JllaMrSLtdTUv+KGYOEdSiMDBPBbvnGNiCPcXmZUXpRXGs0zXGuWHQMAQ?=
 =?us-ascii?Q?9WrQMBVaJJLEMT/Vfp/jqhzaRxBRJpMhgl3rgYT6ozJsWbLZ4UrrUkaZrufO?=
 =?us-ascii?Q?onBinoEp4d4dtEHRAT2facdJ7jT1gzWR9pCeF8+mllYEZpXQ74Qndw+gXXJY?=
 =?us-ascii?Q?Q+8itwRz3aly+xz5PQ4AHg5nKLfWT96AMi3z/CV4ZpSsx07SPBcM8CJv2yVm?=
 =?us-ascii?Q?FffKmCALHrnPgjiYjcpalCBvV1m9Aa6+q4xp9GvR5hx8uLnSWTfYtmQ07Jt2?=
 =?us-ascii?Q?CedDaVGYYSxFUQnVhNXq6c2DScuqT20kG3+rbz0iYaD/YE4G9SjC8wNR+ip2?=
 =?us-ascii?Q?cx63twakejJhiRgSlY27y0WgSfcecYGnTd6kZkuwI6eqFfRVOExCGacPgY8e?=
 =?us-ascii?Q?F11Xd8fVradP4D9sh5Qoz83s5fwBh5N1EEKCyPGeawzNsHkjGTdyjr2dfVA4?=
 =?us-ascii?Q?sGBozlb4krBiDS8IrdxdLv23TdM9nolnrBHUyG46R//JHOSvrqsmJ4Cyo1OW?=
 =?us-ascii?Q?mrdw5nv1IRMv8DPNrptTxcvr0NeWo0Qo7/lT59zvm6Qjb4c7EWfgw5tEFerA?=
 =?us-ascii?Q?Czbk3HbqtT68/g3t6tCXtisGlgeMSNVVdCMQx4XXzstdoaOBpQWUwVeH5aT4?=
 =?us-ascii?Q?Wsh8ifRfVaE5YoP+7tL6IkVLqRAK8GTWWVGSKL42gp312O5D7Nbux+WMfvVW?=
 =?us-ascii?Q?Mk9c6BjXiqYrZLmZRlheU3a3g9+FJPiWbR6veYp1eopzDBtAF3oLlDl05bPA?=
 =?us-ascii?Q?sZj9H3vn0R3porvmpwgxcN1M9ff8pdvBGdWw1mqUHnWAe1/C77IEK8IBYj2P?=
 =?us-ascii?Q?lzYRVV/DNfWtnrDujrt+GkcKWsR3x2EH74lok8fSufeBK4SN5KNIOwsnJ2td?=
 =?us-ascii?Q?6+KtfmLGbHL8yc/y/7kw12twtLnRVNof14Y7PuW/rsJ/PYN62LqJ67Z1dVMY?=
 =?us-ascii?Q?o7AYBNRzv95WUmi/zJEsfQbRD4Upq5L87rPXPlY7CiMjR5tabRQSEp1VK0mV?=
 =?us-ascii?Q?24rm3ryjgOMVDNDfY6cVlEUFfzwO6OSvYC+mQ5dHHbS7VN6To40yEjsICTlq?=
 =?us-ascii?Q?HpO/SxeJcn0SserPHYf/IeXZ8gkLwpodDOZWXKRVOL32JnEnIExD5tE7ui+l?=
 =?us-ascii?Q?WncsI1SejjfnFxWaqkHGkk1Ex2vrWhL7tSbicK41DELmxwj2HsgWJim3+4is?=
 =?us-ascii?Q?UlVT1pP0T/vH0MW6CcFUIkTjCe8pamYDXNOu4fg5ZIxycAhSf9XZmV1eQmGZ?=
 =?us-ascii?Q?5mg34PvDaAAzdSUPqRf0/wQNRg0XC3zq7lNRbVWuY9HxSV1+EQuLUoxzk1sX?=
 =?us-ascii?Q?IzGtZ+T81dH2ogKtwCDWHdpxzPOKcmXMyOe8K7RPD8oi5qxljUYwORonQtiM?=
 =?us-ascii?Q?w1cwEqrC0F598z1ApLEuwwbbDH9IcO7imjuMSxX63rJ4qESP4Zpktt9sbbdf?=
 =?us-ascii?Q?4j+n8dj/FvdE1E4Uvib47KACGi+PMIVE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sR6TCvPWJhSAjl1kqMErxaMzckGIrX2nKoNMEjn0Dj2wIYyEjBOU2C5H9hxK?=
 =?us-ascii?Q?W//OFqlpDtAe51ODYavTmvRV52fsdbErrz3qpQ+cPFfR1e9jJIfAgsKwXbEe?=
 =?us-ascii?Q?zhHOd+pKJbk27pM2x2vTvvaJ7F4hAq/0dpR0EcAc8+8l1dwmMZx7O66FOM6O?=
 =?us-ascii?Q?zJbaECLlEuTljcuEe1e2yL1pZNhbmgeoZESzxDfMOtcOCTVjE23FVGuYf0RV?=
 =?us-ascii?Q?WlSkki3QMW9EIy074Too6Sk6sK3AP9FZ3jsJocHVw68F1hENNOcxFceFEc7J?=
 =?us-ascii?Q?9YfzMqRYHpu1uznIAnPZWewaHjxm/ZOgUdCKtEGTt4iphPYgCtEQOff/09zO?=
 =?us-ascii?Q?kPZrwUpPKApSKRmuGt5ixtozvZCqbKxfK8JbB9LYf7uZdD9xECP7kf86XNgW?=
 =?us-ascii?Q?ylpAcfkbSgKpBj+n6LtBq4IfkJGHNfyICz0WYlmSyUfooCd6pnruPH5/fWQb?=
 =?us-ascii?Q?gYJ05yZ9cXL9GUyiA8d1MlHy0XjDCGvVVWMZce6I2+obSnRYIYnfTibXbasJ?=
 =?us-ascii?Q?TgjQ9PeMZ2ZiI9ldXthHCv7qrjaYLCmHm067VOF4HdYSeK2z+70CnhFxIgrq?=
 =?us-ascii?Q?KC6toV3eOvay8rfehl/JmD431P9OFHl584FjAWEd4fPEMKwVKPYCu07cGyKH?=
 =?us-ascii?Q?lFMvEcDV7B2O4TTHkRrBJfpGyQjRHObDxy16OxV47t5s5C20TRZweORLWPoq?=
 =?us-ascii?Q?ikBRHcNBMx63Ytyi+iQFqZcv7h1u27RHUW5gARAVXWCbT7Jaa6a0cHoJdC6B?=
 =?us-ascii?Q?DnEBB8fRJirdhdyDdn+PybfZINWhlMBoR+fTMLciJnMWe/RZ5m0/ZMzph69t?=
 =?us-ascii?Q?iMcE8s1mOvPvnEXIGOmnoJ0bP6ZjnR5Q3bIudbyK9Mo58Pi0zyk2u5a8BhNZ?=
 =?us-ascii?Q?vO3xoOTjd63XVtFrZNOuidvq7PTpwVmWbmSEJW1PTOfPhtu7gdHeFZZtI0jk?=
 =?us-ascii?Q?6eYH9RzroKLKky+L7umObBHPaQ1nTEg2Mg8VsI38L/Iqvrm0zHK+GtDX1bBe?=
 =?us-ascii?Q?qOg5ChkjQvFkYmlBqiSbavJQ1129tUHuRl0B+2UeMtY6BaGgsHAz7/Zr+zms?=
 =?us-ascii?Q?7TCLBf6fY6Fffhjzys8yx3VBqviIwyr0gFnYEIteLNbJdHxbSQMlsEij5oHO?=
 =?us-ascii?Q?zwk/wI01RkC7JYme/ZAsz9GxcLpTnY7J8KmZb9gpcP1URh70xFOq+Nry8rJF?=
 =?us-ascii?Q?sG571dE0/sKTOMMpaq5Ldu+OJqgKqK3oQ/nXFP2/Sm7CaTwEQjHMpjh5GYb8?=
 =?us-ascii?Q?ViZzXowXpW8UGQSxj4OVkw6mRUc4/uDaJ4xG/HE8z4noBiiKrgRjySb8ny2n?=
 =?us-ascii?Q?65Gj6kSuwOS0dyz6mG/+FSztVfRLO/I619q0f+Ac+HFci6Z65z13bhZwJuVo?=
 =?us-ascii?Q?BEYkch6WCDWZx4jMbyOJDkM/m0oS5COVKerPfle6N+P9RXWevNob4USPTL/5?=
 =?us-ascii?Q?eGFhT0YDpocDrz9ykaV9ukajdQS5h8vPQ117uGoOnclCfpGvO5KkY08Aj89v?=
 =?us-ascii?Q?D3WnU+bJwlQHy6DOs8cEokM8gKrqk+8MxFUcIwdk7gemgDIgeQjRnepq6NO9?=
 =?us-ascii?Q?JW9XZa6L7C4CfL371B2oHyZ7evQ8KYk2TMmKcebZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a6c38-6006-4223-6efc-08dd1d79ce5e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 02:31:54.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g/ORjOL5ghDhtNlU/kPENTd2eV9rnGXU5Ah96XEXE55SwaN8vCDZk6GjqSHPapdo9BANlVnYK7KfOVqE5DyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

ERROR: modpost: "__get_user_bad" [sound/core/snd-compress.ko] undefined!

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412141955.FBjr5T5q-lkp@intel.com/
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/core/compress_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 6f2d389abd04..dadf074359ec 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1182,7 +1182,7 @@ static int snd_compr_task_seq(struct snd_compr_stream *stream, unsigned long arg
 
 	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP)
 		return -EPERM;
-	retval = get_user(seqno, (__u64 __user *)arg);
+	retval = get_user(seqno, (__u32 __user *)arg);
 	if (retval < 0)
 		return retval;
 	retval = 0;
-- 
2.37.1


