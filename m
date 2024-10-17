Return-Path: <linux-kernel+bounces-370591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F839A2F49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C641F213E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F771EE00B;
	Thu, 17 Oct 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt1JEjbW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD051EE001;
	Thu, 17 Oct 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199397; cv=none; b=lry3lonwoFZNzrH67p10O6fGNuuXRTgDFQFn3utf5fCWUkF3t1FW4SgqA8xT3NiHVUENIlE2pmLVjn1//EgOuNNYbz8lcOQsYIBCj9eBfvhuJc7fSL2hiHNshls3D81YLN0z1irgfVqgSs7cj9hR9zq5nX+Rr2WGr3OavK0hxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199397; c=relaxed/simple;
	bh=kkDTGrX6WVVZwK3s/tfrfQeTpzjMt03jbMO0iD4gyOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2H9ZEd7pL9n1pFbuko4rqlrjka4QweV+kEchXOMiRNuipD4I7+NqS1BGmnx1/yB61gtp84bx5u9Oh3KymnOcZ7tJ5p+RSeO4ysfZiGQKkgWaYi0iwvfj/vwBxDG+wWR3MsFdAMhN/0w1hv8q03T9PnBvUtbU3HFsc1znfr09GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt1JEjbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2174DC4CECE;
	Thu, 17 Oct 2024 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729199396;
	bh=kkDTGrX6WVVZwK3s/tfrfQeTpzjMt03jbMO0iD4gyOU=;
	h=From:To:Cc:Subject:Date:From;
	b=tt1JEjbW2IEbIAufSsedoyauLQlwGD4gOV0veRdZvzSbbvsu2yy3pGKZGKSeL/NPD
	 LASCYpS+lNdMaqHV6F57OsMrRt/wfygYMrLnSSl6yp5d/c2NMHUkDqLPXDZ+lpM9ZU
	 NxvJBdqvyP9wcojmel93jROeJiterHMxwq+dj7LpYrXTbs/yMs89tBTPVBBmaD/jk6
	 QtxGXvjU53VfViXXZ2f7Mdyi08qNWBprN2YMWn8gdrC3nF4u0yH77F9Jen1Ai7XL/U
	 V3UCIzgtTxXMJtlumfYFvaBCRcHwkBsYTkzikVISB6oyM34rcQh6OCCh6tzcoVqslc
	 B1lZ5Mawi2faw==
From: Mario Limonciello <superm1@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ASoC: amd: acp: Add stream name to ACP PDM DMIC devices
Date: Thu, 17 Oct 2024 16:09:52 -0500
Message-ID: <20241017210952.3586713-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Add for sof and legacy dai links to dummy DMIC codec.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index e9ff4815c12c8..893ab814cbbdf 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1567,6 +1567,7 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 
 	if (drv_data->dmic_cpu_id == DMIC) {
 		links[i].name = "acp-dmic-codec";
+		links[i].stream_name = "DMIC capture";
 		links[i].id = DMIC_BE_ID;
 		links[i].codecs = dmic_codec;
 		links[i].num_codecs = ARRAY_SIZE(dmic_codec);
@@ -1749,6 +1750,7 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 
 	if (drv_data->dmic_cpu_id == DMIC) {
 		links[i].name = "acp-dmic-codec";
+		links[i].stream_name = "DMIC capture";
 		links[i].id = DMIC_BE_ID;
 		if (drv_data->dmic_codec_id == DMIC) {
 			links[i].codecs = dmic_codec;
-- 
2.43.0


