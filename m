Return-Path: <linux-kernel+bounces-300764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962495E80F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BDC283A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1588770F1;
	Mon, 26 Aug 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LMCzJHsp"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835822338;
	Mon, 26 Aug 2024 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651122; cv=fail; b=gTPcxwnxF114p7SZQMbgEeWIJmsyMtwTuLniS+061k64W+XMPdL+vh2mKbyy4r96CUp6h5JQ6VIacJMbTiKCgqFtVRhadwKcQI0cO6gQKszRthm4rxbPEj/jxVq16qOctTG4cGIRHa4sKdRasXWKUu77JweJEyH8jgBJO95XSxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651122; c=relaxed/simple;
	bh=JXefSuMHMw5NzgOvyacL3QjoYmUUdB8VDFv3cZLO95M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JoZyiIDHZcAjUDzYSrSfOeIOW85+8DEQAa7mutBUbGfadkHsWgv4zN11Gm4fCw2v7Tjnr+CuhUF9hvF9uzfqMx6azAI9pYCQyFZHrqjrXmMt4yebrV9K/6PwUzTXhWwqbUJUYN7JqDz8R3lLE1jbOd/qZyEFpuceXWnANUmvNUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LMCzJHsp; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOCHk7B1+swqAUuKgT/SpNVsI7D60NI7df6toRWkPK9feu6nyLwi1QD8dnVdQ/ajT/VwNFln8PCt2AL+drMl7ZQE9VrFz5npxrrNRIPxLPpapNDbTWBjDBQV+KyzvqJ5xSfntDPbumrgXFqT0OeEHmksENybdWvTrNF1/7g+AiyistBusG5NTpFH+y70JESBlm5ek1Wl/BfshxbGbegx+njhRZAGM7p6Ihy+gG049YrrWLY/v6MRPludlwLVSVi6PCuW5xNvSkBHBRRxgcnsugtpU3MY8lg2asUD21n7ydZTZQ9XU0PhHm7DQ7+SahFUz8E9nO+BM+2IFlvu5Ej7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQLOGksgy58vRW9+q0baGU14B0Ot8AUpgI4fVp/hUB4=;
 b=QZ99z7wHen0yCW58DTDOhICmah2oXnMfKjVsjMp7FJ6jlOd0Ytzd02kaAl43H+xWg+6e2FXgRB+E0A/+JsDVpIlOUicqX1DZzBZJhfIJUai1yUWjXr6HGeRCVaBg2tlaifIya2/M4hAc6ZuGNUUZvtFCq+GDGQJsvBgP4dm/tu1iA7Waw25PYCnfWvh217zomAPtHfYwxi1xmbFAPefpN31SBWWa6Vvl42Rw7IYAqkSJA1MkopDpVWRWGt2bzBVeXJLop+/Ts/sEJPwN4WBC5PtmBZO5oCe2XtsuXSSqRYi0oo9RU7XKPyG5pY7ze5mbc8z6FzBN8gsFJQZS1V3qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQLOGksgy58vRW9+q0baGU14B0Ot8AUpgI4fVp/hUB4=;
 b=LMCzJHsp6bd7INr6qO0DmV94ZlYHPUhzNsiyJwU7BLjpnC6b7H+DTAnDbp2iPYps5+4Hjhy9JBBQngbVPkY2w74GF/s2RAJNBMtNaOtNpUI4NQkGnASm45GCS8Ga2x/LCHvPavpdIAus+rMmw/OPVdzKn4N5PObyUMQR8eh8NgWqDFV6gW5tBUA6/ApKS/GlQxynvtsvudb39LRGCnv87o4Ai2DKIc7AUxD1tfuywjTSahe+dERM8fhzdDMF6CfJIoVaYhbCczVgQeUmLSjfO/sQdUJ0EzjVay2DcQcJImy3wjucY2gyHMOCbFQMrUF1NHM7bb4G4VHDJTkekugsxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by PUZPR06MB5519.apcprd06.prod.outlook.com (2603:1096:301:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:45:15 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:45:15 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: kai.vehmanen@linux.intel.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] ASoC: SOF: topology: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Mon, 26 Aug 2024 13:44:02 +0800
Message-Id: <20240826054402.58396-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|PUZPR06MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ff3437-82ac-4af1-bc33-08dcc592428f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70Q3B6IkzONeE574bkQxsvDDm3fpwQfk67cO22P1qgx/DXbLiAb+90owAT6K?=
 =?us-ascii?Q?MO6LJawDmqQWTTx2kkJO3MIN9ws+qVaO84vhbAgSWUa9MD0s53067/G1yvUr?=
 =?us-ascii?Q?6YzMZxu72IHiYDWrgoOj75tJqFELx7CcIlMdRFHbPoQx6pabMiNU3fiYpW/q?=
 =?us-ascii?Q?Tk56h5+DHwcL6N1ms0KDPmfDf5WG5CaMjVreYItggYIPlCgZOQFCcMFFEOar?=
 =?us-ascii?Q?5kA+q5e/oIC7PYe6gD7iL3A0j3k17D7yOkmb4OH56NFV5/YI+x5in2WBnzWH?=
 =?us-ascii?Q?epg8lqtK6k56tzyWi+UJ8G8QcyRUdsXlhW0yiTAgt8SIbxyU2Zl0Hw8onACr?=
 =?us-ascii?Q?Edl7AGorNg3nsBBeWJ+uSRYyLLUYgJ0FcsDJ/K0QWQdLLCs1IIzZI9quNy11?=
 =?us-ascii?Q?cLjdUHjM9HTfgIgkhDtwStawdgLpnvUbo2oWW508epX+ruRK+N2FE4Cis8rH?=
 =?us-ascii?Q?a07XwgH5vxjktIOQFv0A//nhQ6GFll2U5upqPjg8eIYRll1t5SxtSvhmoY0n?=
 =?us-ascii?Q?zNNZIY6UqQgbDhFi8bb+XRo5ysVgugXGUwMTckLkdpJt+JfymCJy9NQrNg+p?=
 =?us-ascii?Q?m68tug27iHeaQ8fxer4e8e6XKmjgUvFMLGYkFIRM03p/CoUQaMQkCfJCIbuk?=
 =?us-ascii?Q?fcEergABmbo5P6g9guq6thj1jLDxvuyiX1qKV1+J9QBYkY7JmKH+dHOEOoQZ?=
 =?us-ascii?Q?6zHRkrZMvvKNJetC/tyZtQpIu/zM9+VkrEjPjW0R6xwdHtMUcih7MNLPjMal?=
 =?us-ascii?Q?Xou+fLGWiRvd4KxDEsrV8PJ2Gnpl6kIh90HaCgVdWBS+AHhC1GHPFG9ieBwh?=
 =?us-ascii?Q?U1+p4ZHD1Rg+MfquvUD60DlxkWSeeAnK3go6fGLYbrxWnEwrjGO2O2nczb83?=
 =?us-ascii?Q?AwwU1ZEIRM0zM70VByXwtw2sL9IaaykZGoOKfTWiDkfMzffY2WHTz+zFMhvd?=
 =?us-ascii?Q?SKSj2vp/QERnIlkvmGd9MPuOxqABST74aAOCXjafHybeBFeo9kT4js0bNwZ1?=
 =?us-ascii?Q?4ZQwB6Jx2c2iUcCbL2eYFjrbWe6txXpoEmpu3FEkaoPkITYCwQVHmEW9TwWy?=
 =?us-ascii?Q?QOCOnFUxupn7ytDH6cVM6vl4xc1ja5WDP4GhzRPr/7lbDPhtR6xnSR9c7Nu7?=
 =?us-ascii?Q?3rTf3MkGkCG6uhQOvPqHctSIDrpBTqcBlIPz8Zg4vKwACrCYQhYyyR3+nBc2?=
 =?us-ascii?Q?tpsW7nYwO+ihDZz9pCdohhUeP4M2gZzfuZLUBaDlX4Ay+uwW+0gktw2YCurF?=
 =?us-ascii?Q?OILdCr71sNw+Ce/tnR97n7q4LtlWENxMXBmaJxaBHzdVFLkjswz92LFBqeYM?=
 =?us-ascii?Q?KmjynwRsTgb4pPwPocYhJN1ycLmbGH/B9pqZ+edRG8Sb35ghnjSiPK9NuToF?=
 =?us-ascii?Q?VxSvVwTARRmFdpFomJ9X+ZUwXBsWXoTH+QGZJyxsWaFRJj07fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TMxVaJQSbjHSUqqMEmQmvGJoZVwEqyo9vHLH6Q8/1Ti2AualFzm7vDuOAD1v?=
 =?us-ascii?Q?vrydTdWCdb5+vQXF2y5g86xhjcnoQYNSyaNruVbiGF4r6ET7XMxsIc/A9dwZ?=
 =?us-ascii?Q?aQzjT38WLCorGy58Bw8hS5fUbRzMCDZl0xxOAteSxhdGQiEpDT2puK5iF2Hp?=
 =?us-ascii?Q?Fw14ZITDkqVfoOQUY/YTEKHU455wzMDg9cK7F0RBkuafnbrgdUf7dej1jdkV?=
 =?us-ascii?Q?3HfZ1MO95JQLLIa8rspIC/THhkQIBFJ2SpbReX2vHQfb6ERs/Q5qt5O8S/C9?=
 =?us-ascii?Q?WW6Z/oFMiMwvdZIUsSvGWORFNL+eQDNhZK53ysqrRVLTk/OyXEDsFXIYIQrm?=
 =?us-ascii?Q?rVwY6UfklWuMzTDuYVzhH21qI7bhSdlTymQUAtWOid0iqpl0npof55mGy/Ss?=
 =?us-ascii?Q?VKM5IonnDc6nEhq3qZHJwtBkNtg1lyHCa2/Xxxq6iJ9iE3JZC5m9zkpo5IDX?=
 =?us-ascii?Q?N3/3aoOqpc37u+4fY156GNoMLNZTkHE/fRfYGrdgqLv3kVKamt+kvCczWowU?=
 =?us-ascii?Q?zY7lZZLZnM29zFSXs30E0iJ0YtobNCyxuSPwmAGK0jlIeiHN4BTVZ3fifN4T?=
 =?us-ascii?Q?xZK3xmfggEXnT/N6pT/EIythLa+oFHuqBxwLkGEot7dEuGJQTvnXpqYvvhiq?=
 =?us-ascii?Q?GiQozKHnqEIXPi9VQtrTwwA3lu5R0YG9atbkzVZCkU0EM033IOLdcFGCb0mh?=
 =?us-ascii?Q?pC/gaC1N7MiYLI8Mc+xPJeJX9v71lzUHJOss/5DFuB/W9QsbkMH5aIK4edXm?=
 =?us-ascii?Q?45WcR3SDj1qKVgPtIqNUtKwCSXTGBAlIThlRF6rtWdWk2JT/J5hdG1fuMs5H?=
 =?us-ascii?Q?j4oMpVfwDp+Qae+pLBgtSP4FjMhGVDLcUXn42QAvrOsEPYv5APYlnviivN43?=
 =?us-ascii?Q?6mCQbzuy5XXc6b9/p17vFKlXNbsuJEUMuthJdjC8S1P4Hyi9bxuAJ1d0qQY5?=
 =?us-ascii?Q?vQTkVX2APawnOakOLVKDlNK8uv4riiN2sAGRXFP5ddLndC8FkVQJ7KLPQbs5?=
 =?us-ascii?Q?Oq2kOyBYqvLZbZN5B5i3LOC62qqCcXyIZbMvYbvKVy85yrFtMPSihZQsGgJU?=
 =?us-ascii?Q?/tk3gTTneSwB88AL5Z9mguTCOf5Huf2fjTVQNhyoAEKKdGDLVBDL6Ug0w2m6?=
 =?us-ascii?Q?vGHJlFchXbdYiyCNa7vx/3jMB2StrYU0vi1cxT97Frp+q4u1F2xs2RBEViLk?=
 =?us-ascii?Q?0/cL4q+jFpCSG3F7JiWTHMIgykgQ2Uf1nb/2l/DgZLAFLmTaHs/QJwyz4qYZ?=
 =?us-ascii?Q?vF14Ivgh94nbaMkZJzt8s1XQTRSvjZy/Pd4/2BbKT2K5xACixNpz+BZMu+Y0?=
 =?us-ascii?Q?UyzRTy0MmU/MdxU1v7/c87FMWA+siDQuW3/BUxB3a23xY3keGBD8kbU6b/l+?=
 =?us-ascii?Q?40diTj114B4SYvxaJ2KuvOiyM2uUtxKmUCg5k+Z0nmmRqz8rlDd/nIEHSApC?=
 =?us-ascii?Q?mZpClgrDqXkv9R3QnDoYJzfZSVQKWq4Qm6G9FUiQApau3VV1/uh5Fi1tjcfn?=
 =?us-ascii?Q?sA7gccxxarZt4MDqwYwatscfojM76b159utqQfFh/xqnjClxEFD5uoRddRhP?=
 =?us-ascii?Q?6iGYpFADUyu+fjqgpRU101WCBMIzoA1rxk84/ek6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff3437-82ac-4af1-bc33-08dcc592428f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:45:15.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrHn6GMsN+iNl1PhcK9w88m1+WnAyo/FhyD120Gi9lvtX8l0zXkxv1PonYzCL2VeW7aVMAbxmpmaewdzLWzHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5519

Let the kmemdup_array() take care about multiplication
and possible overflows.

Using kmemdup_array() is more appropriate and makes the code
easier to audit.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 sound/soc/sof/topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b54382131991..996c3234eaee 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1349,7 +1349,7 @@ static int sof_parse_pin_binding(struct snd_sof_widget *swidget,
 
 	/* copy pin binding array to swidget only if it is defined in topology */
 	if (pin_binding[0]) {
-		pb = kmemdup(pin_binding, num_pins * sizeof(char *), GFP_KERNEL);
+		pb = kmemdup_array(pin_binding, num_pins, sizeof(char *), GFP_KERNEL);
 		if (!pb) {
 			ret = -ENOMEM;
 			goto err;
@@ -1889,9 +1889,9 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 		return -ENOMEM;
 
 	slink->num_hw_configs = le32_to_cpu(cfg->num_hw_configs);
-	slink->hw_configs = kmemdup(cfg->hw_config,
-				    sizeof(*slink->hw_configs) * slink->num_hw_configs,
-				    GFP_KERNEL);
+	slink->hw_configs = kmemdup_array(cfg->hw_config,
+					  slink->num_hw_configs, sizeof(*slink->hw_configs),
+					  GFP_KERNEL);
 	if (!slink->hw_configs) {
 		kfree(slink);
 		return -ENOMEM;
-- 
2.17.1


