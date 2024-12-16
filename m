Return-Path: <linux-kernel+bounces-447079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8268B9F2D10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A307318842C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A37201100;
	Mon, 16 Dec 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA6DS6NZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F32AF03;
	Mon, 16 Dec 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341659; cv=none; b=rROwURgQYkHtiQMizbgeZzjMOVyrQyL9giO3yOEQ95UiI8QswFSJ6//MD5uumiBHAMuLplWPlFVVAYeWlF+Wv5PGrMlpWsnDqqH7ghYQzGcQyiXwDF00AmhvbCEw/hFPXKfBxQrxAj8tjbP9MyzX+xRmZop/mFd6KDeC74RdYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341659; c=relaxed/simple;
	bh=XdDNYSq8B20MH+60EYN/0jpm4mqUUEejEyYcZbSUXHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcZRlJJVn52zfrJd+56uEUXVU5Yg1laBAHZ+4JBGa0wc1to1BK95MCiOsAvsmi04XY9Eg+aBYoXRenbwdduvrjlmX9k7lYz1HJvbu5QCmTpwj8eEiw+5cWlTZZ4yn/UFmfv62MGDlTEexreboAmV+zARNUxucFLa54BPY8h07O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA6DS6NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1A2C4CED0;
	Mon, 16 Dec 2024 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341655;
	bh=XdDNYSq8B20MH+60EYN/0jpm4mqUUEejEyYcZbSUXHA=;
	h=From:To:Cc:Subject:Date:From;
	b=DA6DS6NZljJZ3o6/Bb0Aa/pLgXkoCPIROO/92gKEdRCJ4o4bne47t84vBhFnm50Fk
	 KPW7rkdIa6SbjZxexPY+XFHyhP/eR9GL4ZUQgIAwKyZ7HS/p3kx6JLJMFiNok3nL9H
	 EcdfxgyVzFFAIaWwR2LbduOzfUBU9llXZ4GuNaWmhBM7G1UuihTXbi+6mTpbeTqV/P
	 iGeUYbPw1P3WjR/30OUxYRZxFuWaQL+grrvlpkAyvnUYdteO/B9UtxJBpBrGTOlmFP
	 CqUxlXqcHp4Dj7lNHzQOD7F0bsq2jLXMjrAzjUxD9tW9wuwwWWNfp/8dcRbWBuWldf
	 hT0dYzCRpaM8Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: compress_offload: import DMA_BUF namespace
Date: Mon, 16 Dec 2024 10:33:40 +0100
Message-Id: <20241216093410.377112-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The compression offload code cannot be in a loadable module unless it
imports that namespace:

ERROR: modpost: module snd-compress uses symbol dma_buf_get from namespace DMA_BUF, but does not import it.
ERROR: modpost: module snd-compress uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.
ERROR: modpost: module snd-compress uses symbol dma_buf_fd from namespace DMA_BUF, but does not import it.

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/compress_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 86ed2fbee0c8..ec2485c00e49 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1247,6 +1247,7 @@ void snd_compr_task_finished(struct snd_compr_stream *stream,
 }
 EXPORT_SYMBOL_GPL(snd_compr_task_finished);
 
+MODULE_IMPORT_NS("DMA_BUF");
 #endif /* CONFIG_SND_COMPRESS_ACCEL */
 
 static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
-- 
2.39.5


