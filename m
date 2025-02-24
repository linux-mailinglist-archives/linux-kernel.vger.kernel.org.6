Return-Path: <linux-kernel+bounces-530164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1DA42FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC3C3A897B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44573204F63;
	Mon, 24 Feb 2025 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jPh52aGb"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98514207DE0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435459; cv=none; b=bFLEODJjy8t4VAFZGYZ4XvkYyB8F8jQrbQ6KLzfx/zQYC3HkLxR0dQQq4Erre2cVR3gx90MRtJ4/BI4Pxe5MqXDhkug0ryzYtGsaqvBqN9Ey6fgRpr5V9Nvb3xbNoeB9Ans2g4/REe4Gcga7y0Tu83GLCRlr6je257h3wVergwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435459; c=relaxed/simple;
	bh=j9ul9lajmssaQGsq2f0RPtIkSoaHICdgb6sZ0MzTFZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXO5cv6aI0HJe/G3nIHQvKHr14U8bZWzS/J/KmPjcCh3WrEV6w72O+0C1dHg0aTDDSapCPTf7mM8aR8AqANoM8F2DOA9YEXRsYBxe8c4SqdYe7DCRlMZ68a4fLz+NP8Ar1orOGSb7rQv9+OSLiTYTk5+lOW30x8pH8bG5t+3lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jPh52aGb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740435455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwgY2gg0fChR9PNYJGZKx8vqnKeNt/Cl9yuFpNMFMTQ=;
	b=jPh52aGbtItWazshP7zdpw3qDR5bkqzjfncQ/BYRKizUSg5as3bcDNA/K/truiH4Y+MzQ0
	fYBcpOn4VLSDOVQevunASLIKWA6H4NOu7oxgilCvCw67DTn5CoFbk5js9DNLQIQTJe/S1I
	liyvH0h0VPyEZKdNu9D1v0nZUzhLHKA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: acp70: Remove unnecessary if-check
Date: Mon, 24 Feb 2025 23:12:12 +0100
Message-ID: <20250224221214.199849-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since list_for_each_entry() expects the list to not be empty, the
iterator variable cannot be NULL and the unnecessary if-check can be
removed. Remove it and indent the code accordingly.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/amd/acp/acp70.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index ef3f6504bc7f..7f4ec3bfaeab 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -230,18 +230,16 @@ static int __maybe_unused acp70_pcm_resume(struct device *dev)
 
 	spin_lock(&adata->acp_lock);
 	list_for_each_entry(stream, &adata->stream_list, list) {
-		if (stream) {
-			substream = stream->substream;
-			if (substream && substream->runtime) {
-				buf_in_frames = (substream->runtime->buffer_size);
-				buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
-				config_pte_for_stream(adata, stream);
-				config_acp_dma(adata, stream, buf_size);
-				if (stream->dai_id)
-					restore_acp_i2s_params(substream, adata, stream);
-				else
-					restore_acp_pdm_params(substream, adata);
-			}
+		substream = stream->substream;
+		if (substream && substream->runtime) {
+			buf_in_frames = (substream->runtime->buffer_size);
+			buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
+			config_pte_for_stream(adata, stream);
+			config_acp_dma(adata, stream, buf_size);
+			if (stream->dai_id)
+				restore_acp_i2s_params(substream, adata, stream);
+			else
+				restore_acp_pdm_params(substream, adata);
 		}
 	}
 	spin_unlock(&adata->acp_lock);
-- 
2.48.1


