Return-Path: <linux-kernel+bounces-318307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D096EB95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208C81F22BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8B14AD24;
	Fri,  6 Sep 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ACmq6nCo"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907C3B1A2;
	Fri,  6 Sep 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606419; cv=fail; b=JeE2MERE+uCBkXia6hM2/uZ/caJqI0b4NJrfKFyT6uEPwzccfWfYg3W49L43XSxkzbPg2i9lk8pjDCoNmNj9TH0iy1ybiBuC9nC7FC4cC7oEYPrWRl8XHdD4wPsq238jUGBxpB346jmGZ+auArH6P2yzIwDxO3UZTAPupuUwynQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606419; c=relaxed/simple;
	bh=DF5wnb9IM6IIe09EzkoMUCYsqQg2g3pCaEUVFsYRjQw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ohy+024AIvYGFGdd2aL7yM6ibzZJFOKfxo/F5MWKHaWzURUqjbIgGYNAAre/fNsA9Dr8dBuhZLzOGwMRaGhbospifZ73LOyN/eO0Htwm4dsZJt1Vk4/rQG/BzndcYecuBqCWB4ARr19Fy1t1HFAiUYhcPEU/SDXBKCHSiKB0Nvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ACmq6nCo; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY90ilKgzgrmkkte7owGvWMs/pX3jLByR0quvWX6V6ap57tY1km3bO7tphxBO29DRGUNUE8t13gV1PqGsO0DvLIaqT7FgPROT+3YwMrdjJ0tfDP4lUlEEbxC3VN6QjLBUnl8gbWMpctRfhZ/mfbyHfLZJOYZxkzXZw9U7PLsWx7gG173sRDhsuqLfyQQZGkAPPy4gpy/YPDSFcOBChYizU5OVUd6Dk2U7E+DRVVCzwqA90AUANcVC+buQqQR3lFxWSxjGMVZV+OJqFDvMC//m3Vr9Kfy6KOEsE1raY+gQmNSmg11prGodslFCsYtLmMTXlW0lZkYN6FZQNBS1El79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX/51u266mKj0LoSdOlTNhnqP4a2UU3yNggL/C+HHwg=;
 b=XjzzxzEHweQjjDG9/W/R80q3T1rjUSn6u9Bj5Qmx6PG+WEoDJQIEbkRPBvrBZjY4OyMZITN15arFtPJN/1S83ZT9Yon2Ev+Sd4B4JFwJNtX72L5UWSHXlYZF69oPwce3+iQ/JxlUGZfK6oGb+Af4wyx+AD4pYNc0CHrzk/TCgfVS7OZwf/stkMIQJvuwOQKY/DVFNuuUnWxM6BG8XcLyumpX5IEAz5s1C5IsDmgMbOtC1rCQEk0vXs0zif9KLRsFH5aQvepnsooCwFMFfMh6r+izVnSioIVm9eZ7e5Phr6M4rill5tqLhdjnc6v2ujYcXMRirKQYzqeJzD+gaE7qQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX/51u266mKj0LoSdOlTNhnqP4a2UU3yNggL/C+HHwg=;
 b=ACmq6nCo3LZocjXCXXqw0+PawZSqYrJ2yhzEhA3gH9vsUfx6gFt7pk/5n8ePzFh0xW5NstMyGwMUe0CSojLyseszWF2gIoGoDRw3syuM+MZyDtQRtXcTLb+gLEIibKldJzSFGC7nQJbD7ALT2A78CtObYJCCUFNChKxC6J1SMLIYTTS59WjT/bLJSeMs2MVq2ATyXfNJNFWzYwWLE1JiUKY5ycGxK9LxxgDPeMVHTOzmB16N92ejIGoYHLxuDdxZO+IhB4dCGoxJ/5OEaRP2edl3+x2t4pZuPIWeS8uCAHxMN0zzStFpINjCxCPGtSL9ruRyeNvNDSluyw98r28quA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB5298.apcprd06.prod.outlook.com (2603:1096:400:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 07:06:53 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 07:06:53 +0000
From: Huan Yang <link@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Michal Simek <michal.simek@amd.com>,
	Huan Yang <link@vivo.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH] soc: xilinx: Use devm_clk_get_enabled() helpers
Date: Fri,  6 Sep 2024 15:06:39 +0800
Message-ID: <20240906070641.2466518-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: b850c356-8b6b-403b-65ef-08dcce427c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0MpAUafs1fKG1PMJOoSPim9gxqEoTwEn0b3JrlHMKvnz76f9DuFsaHshLFob?=
 =?us-ascii?Q?/aYJmrkm00kAuy0c7tlRcxSYj96lU8J8Qf296wCWp8X9l9wOo8zR4zWQTs8G?=
 =?us-ascii?Q?f5mQdp+MRcNh1ITOnuWZgEjUgT+24QLU0Ihll3BMfzFrqhy0FRRCU73eqKB9?=
 =?us-ascii?Q?BJOQ8jXKr6vX3f+zfi3PZ8YwNotLVK6gYCsEhGcUw9nmQv0CUZeYZpZsFDBF?=
 =?us-ascii?Q?4kSKg7Qq1KwZi5GGXtNe2nhCbIOQHxKXL+mcImt4ht4lBRR7pEXfY+Jjl9OG?=
 =?us-ascii?Q?2hh7DPCTiGnCTnueYoS+TfZ++eXZMaZj4R+eSYBrsnWqtSvgvRrDw6Js8V97?=
 =?us-ascii?Q?MZBiJWBAtBCgffT7SLIN5NzefN+peYcnYV1AV0plxk5fd/dXpWBKPw7q+dWL?=
 =?us-ascii?Q?YvKzzJqfEHDqhTdkvZpL7G1fYUS8dOlqVGIJ1Bl4h+m5eBY7XuLHWMFFbyqW?=
 =?us-ascii?Q?H6N9+ZEji4+LuMg+Ntm3H/styKZ9zPMCvJMq6zreDfcamdhXjrd7V+rFIh37?=
 =?us-ascii?Q?u7MZo1kdTinCHb1btgr8QOLV4zoCqjneVTFA5BTLU7AxUER+PYvLK9PAhKa/?=
 =?us-ascii?Q?WIM1TWm2vfgFZzrY4K7rJOlORPb1DuunHHm4iSZK4IvzaveG/MhYTvbucMfg?=
 =?us-ascii?Q?5tY9UF+KAoPwhWAj4w9Kh6qt405+zvprDND4b9Zvtf7Ge6C3KOzB/AEelF2D?=
 =?us-ascii?Q?JqUhtvH+WZy0EHp5MzHDE9Q2k0ib4bstRuL5SKutL+wkv712Wh+xmofCSKbT?=
 =?us-ascii?Q?VVwKDWTPBjvhxMYfDeEThJetMboq3nRGenlldqB20K3hDjbA5WVl4Njfkcsu?=
 =?us-ascii?Q?Zy4qy8jMwOHKVea+Gyxv1QNjD73Ri260bGxqFH8BW0x8OKra4SzoY9VCTSny?=
 =?us-ascii?Q?3EhnA5cEmYJzcf4UQG2WMBWlptpGg6JUxaRQ0pAG9E7dn16er1MZ+i60PYSz?=
 =?us-ascii?Q?zNh2okAakpLVvFE3AvNlHEG1mx39H2iQoALk/S6ZSC4haVJQHJwW1SteDKFa?=
 =?us-ascii?Q?3BvRCetEr4ngu3niYPdjPDdtdko5kaqC4JOkMr9VKeDOk40sjDFz7tb0NE5M?=
 =?us-ascii?Q?QGXkwLdxeHB/yQ3uWo7mWpyrrOdxgAXt1e8d3J0Zm3wjrAEtUNldSkPLFcgA?=
 =?us-ascii?Q?aMkt74LMcPbBGXLGy3RQWJTSW/+y6cU8vxxJ05P0Duhusikett9r69qO8vBG?=
 =?us-ascii?Q?ol64jg7/Yd7UwaHNR4dGtXwqQWjoyAn/AhG6s1hIGqrs4fRayoyT8bo072Mj?=
 =?us-ascii?Q?O/+OvLg4VBmLf3nZ2mDVIcjaoJEs1hF0UiM+t+tWMo+b7mnHuJQMEjHCK+CH?=
 =?us-ascii?Q?TjWdlTkVnfJIirZAn3pjb+cIU+8LmEr84WKNXxgf5qyzeIRaA8NGy3h01a4Y?=
 =?us-ascii?Q?HB/932Yr7opljoETh6RhvYuZJAe0agYgmbjzqmB1gF9OArjwDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5NUBngFs0dTh3SRkACYeNPe1eb2yCmonJzWXtT1VqCyGu7qd6Kdu6Wk3Knt?=
 =?us-ascii?Q?Fu/I0z2epJkbPQ2qOnh8k0pwZ37V2jw8i5KyOpJuA4J9g7HCdME9+NrozPG+?=
 =?us-ascii?Q?7ZXIOWpSBAytzPuNl04aJw7R2b1W/Nwz34iK2SG6lXfBkx2KOzsXVji8rYi9?=
 =?us-ascii?Q?mEMkukd8DaKU2xXMjXArkpuvWHgL71X/QHTYWl6l813P7LxitIVSczniFvGU?=
 =?us-ascii?Q?8uimIh7kdd+BgcbuyFTlYeo06fK8cWUM2EWkxHWtlHL9LmI6StTE9pKsgMsJ?=
 =?us-ascii?Q?Uvn5FDVddAPKoFdHy7HrJMF6RX3o0fS9PH4ytEwTLXcp4po2XE85dGjd+Sfe?=
 =?us-ascii?Q?ON+LIgFsSSHLMnwwZDojdiAd0laIVINoOrAOAJ5JjKiGHjZ1vezEQpw12jUZ?=
 =?us-ascii?Q?H3N9e3XNgpnCgQdXMNI1Rka8wRZghMqlmRhiD89D2teOOp32uLp6A6JVDIoT?=
 =?us-ascii?Q?hF6sxLSpUpOJS+sJycBATQhaExFmQt+J7taXpqTyQemXyMvMO4wkNsrAeGFC?=
 =?us-ascii?Q?CwnZTUMd7Am3LVGmP5ZwDqnHzV3J/aJVPSY+gOWU+JJkF+LpAs+FyzMIc2Hb?=
 =?us-ascii?Q?CAnNd07BATLXStvIbIX9eHyGDZvmvohiUF3AMZig9/C4i4WDHgY4xJvBT0C+?=
 =?us-ascii?Q?8LvPdEjjGkjmctRXM8C2FjgWgsUMWfCyMha1FMy9PsFwnMs9KYCKeC+yfJB1?=
 =?us-ascii?Q?RWnLO6ToFmmGg0oPOcsgoHrEV4epU59h0PkOu2G1WF/oeUwuWl/Sf6usZQdi?=
 =?us-ascii?Q?BJACpozXWjriZWILHK6BXK/iH/fIbn8Jphl8GVTAg2WvEijFxhMyV9GjI2lP?=
 =?us-ascii?Q?Z4WLumEGo3SsSNNPba4aw/AdlvVIwmRBtqKkE/ljaTwRMkNUrg5VoxphzoMr?=
 =?us-ascii?Q?04v1AQZwhLYCC7amBOEYyQghdpo3W/t1siH2HcnKKh0ypDaTrFoGzwX71bEs?=
 =?us-ascii?Q?bc3HONAG83fa25KTtPzxURepJFFTyQdNIE5K2QaLTaNAvFF03KtvdcvV2/iL?=
 =?us-ascii?Q?88q2xoZbXBZhSPN/Qn2X426Zg30W7+esm//0jma0/tiMyDuPL6ugzYuKVXqh?=
 =?us-ascii?Q?XRxJ9ocXTv5y5tJ9f+/l1tIrTFSzvglxvnikBGYGaMz5caw37fq1IAx06T7f?=
 =?us-ascii?Q?g4wUnsfcg5wfbxJyf9YpR5agCTgxZ9dU32tyQQ2YfBN79OZEl4lS+50d8IQ+?=
 =?us-ascii?Q?rVgBsP5QttvM0PAwVVpb9CFX+f9vdo51d4nslFvpzAb5BlficLQQF/RnqbAh?=
 =?us-ascii?Q?QaVmtsB8kgpVIgZRx8kCgCQCBNa1OcZutYk4Qw8VbjwhDJUPmiSN2n2ZcO1O?=
 =?us-ascii?Q?18LVBKWNpdYQqYUmV6P2ysPmqzvejmqPDVBO0Tn890Lv66anD4hnxTVz6iQ4?=
 =?us-ascii?Q?WZV1L2t9Ca0vyS4NyR12orBt6VsEUISrnYCvl7l8uj0yCL7w7XgOv+K979pL?=
 =?us-ascii?Q?b68xAq4Rt9pPclFHZRm6rBfh7+UFMlxFqHdlisBIaVX5+PEtwK2yrxwHkyNl?=
 =?us-ascii?Q?SZTbbs+lsGVkPxTA38tvcrngPptRYZXJFWMlHD6HvmowCMOfmxXJ7TjmK7lF?=
 =?us-ascii?Q?lqR8jKm/FlGAbd68CgMAX6JEc6kV/GUfX8Dt7JIV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b850c356-8b6b-403b-65ef-08dcce427c81
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:06:53.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M76ShvazGf/D9ruftM1szu8U5YdIlGOvMTQY8YknRK17LCPdvxgM+eExG1ccPnm7ZqJB6pa8nh26zvZbXsgs8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5298

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Due to clk only used in probe, not in suspend\resume, clk pointer can
remove from spdif_dev_data, this can save a little memory.

Signed-off-by: Huan Yang <link@vivo.com>
---
 sound/soc/xilinx/xlnx_spdif.c | 44 +++++++++++------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_spdif.c b/sound/soc/xilinx/xlnx_spdif.c
index d52d5fc7b5b8..1ac4bb4b76e8 100644
--- a/sound/soc/xilinx/xlnx_spdif.c
+++ b/sound/soc/xilinx/xlnx_spdif.c
@@ -48,7 +48,6 @@ struct spdif_dev_data {
 	u32 aclk;
 	bool rx_chsts_updated;
 	void __iomem *base;
-	struct clk *axi_clk;
 	wait_queue_head_t chsts_q;
 };
 
@@ -240,49 +239,44 @@ static int xlnx_spdif_probe(struct platform_device *pdev)
 	int ret;
 	struct snd_soc_dai_driver *dai_drv;
 	struct spdif_dev_data *ctx;
-
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct clk *clk;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->axi_clk = devm_clk_get(dev, "s_axi_aclk");
-	if (IS_ERR(ctx->axi_clk)) {
-		ret = PTR_ERR(ctx->axi_clk);
+	clk = devm_clk_get_enabled(dev, "s_axi_aclk");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
 		dev_err(dev, "failed to get s_axi_aclk(%d)\n", ret);
 		return ret;
 	}
-	ret = clk_prepare_enable(ctx->axi_clk);
-	if (ret) {
-		dev_err(dev, "failed to enable s_axi_aclk(%d)\n", ret);
-		return ret;
-	}
 
 	ctx->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ctx->base)) {
-		ret = PTR_ERR(ctx->base);
-		goto clk_err;
-	}
+	if (IS_ERR(ctx->base))
+		return PTR_ERR(ctx->base);
+
 	ret = of_property_read_u32(node, "xlnx,spdif-mode", &ctx->mode);
 	if (ret < 0) {
 		dev_err(dev, "cannot get SPDIF mode\n");
-		goto clk_err;
+		return ret;
 	}
+
 	if (ctx->mode) {
 		dai_drv = &xlnx_spdif_tx_dai;
 	} else {
 		ret = platform_get_irq(pdev, 0);
 		if (ret < 0)
-			goto clk_err;
+			return ret;
+
 		ret = devm_request_irq(dev, ret,
 				       xlnx_spdifrx_irq_handler,
 				       0, "XLNX_SPDIF_RX", ctx);
 		if (ret) {
 			dev_err(dev, "spdif rx irq request failed\n");
-			ret = -ENODEV;
-			goto clk_err;
+			return -ENODEV;
 		}
 
 		init_waitqueue_head(&ctx->chsts_q);
@@ -292,7 +286,7 @@ static int xlnx_spdif_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(node, "xlnx,aud_clk_i", &ctx->aclk);
 	if (ret < 0) {
 		dev_err(dev, "cannot get aud_clk_i value\n");
-		goto clk_err;
+		return ret;
 	}
 
 	dev_set_drvdata(dev, ctx);
@@ -301,31 +295,21 @@ static int xlnx_spdif_probe(struct platform_device *pdev)
 					      dai_drv, 1);
 	if (ret) {
 		dev_err(dev, "SPDIF component registration failed\n");
-		goto clk_err;
+		return ret;
 	}
 
 	writel(XSPDIF_SOFT_RESET_VALUE, ctx->base + XSPDIF_SOFT_RESET_REG);
 	dev_info(dev, "%s DAI registered\n", dai_drv->name);
 
-clk_err:
-	clk_disable_unprepare(ctx->axi_clk);
 	return ret;
 }
 
-static void xlnx_spdif_remove(struct platform_device *pdev)
-{
-	struct spdif_dev_data *ctx = dev_get_drvdata(&pdev->dev);
-
-	clk_disable_unprepare(ctx->axi_clk);
-}
-
 static struct platform_driver xlnx_spdif_driver = {
 	.driver = {
 		.name = "xlnx-spdif",
 		.of_match_table = xlnx_spdif_of_match,
 	},
 	.probe = xlnx_spdif_probe,
-	.remove_new = xlnx_spdif_remove,
 };
 module_platform_driver(xlnx_spdif_driver);
 

base-commit: ad40aff1edffeccc412cde93894196dca7bc739e
-- 
2.45.2


