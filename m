Return-Path: <linux-kernel+bounces-523629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABBA3D96E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EBC3BF2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39421F236C;
	Thu, 20 Feb 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mYoaUp7c"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311A1C831A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052956; cv=none; b=FYaU3cOE36IKHFCqFljHhrwZK3ZfXd3Uxohw4Rsg8Vuok+MClU6/Imc3Y6ARSNhQcbZmaCEr74/lS0jErVBBWi+tnJiHlkWOeEQLMGGu27FPVaazkQoWxaB6aSD778joW175nscjsm124+mRktFDXH7qAVUd+aGTK2fVlashHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052956; c=relaxed/simple;
	bh=Qh1fDdbVWoq5LmRU/PBLbEoDH0O/VJX/C+u+qo4SX9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQLZPFoPbAjJoypmbL4bBjaACHiIMZbZoNaJA/dS9a2CQGT2eevOzKrf48TP45KPu8CFtdzzaYCG2LuYDOFnjFdE7kTNeQbQh+6ucdXACblmO6XHW6yoG/IokLssdwFVomSGJQqnSxOqZrX3q0PSSsm4N2z1w/1pjhB2lx7P+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mYoaUp7c; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740052952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iLQeHtr7dflWJfJVnMor0B3u6SKiuchpxdMV07r+zUk=;
	b=mYoaUp7cfmCD080PuBawihKZxN4gl3FHZeyOHfVnkA9xFkTkxg28KIBPKWgFOtlZ/3bnAM
	kVJNXyctksMYXFJvXcHxjir2Tpt0hRgDD26dyXYM/4VSKkcjl8NKFkFuvipDL53NwGRFu1
	APdwEn5ztzmq+uC2KXDyM/nhmdRGD6g=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-core: Use str_yes_no() in snd_soc_close_delayed_work()
Date: Thu, 20 Feb 2025 13:01:56 +0100
Message-ID: <20250220120156.1663-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3c6d8aef4130..c5a8d5ad8c34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -32,6 +32,7 @@
 #include <linux/of_graph.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
+#include <linux/string_choices.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -430,7 +431,7 @@ void snd_soc_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
 		codec_dai->driver->playback.stream_name,
 		snd_soc_dai_stream_active(codec_dai, playback) ?
 		"active" : "inactive",
-		rtd->pop_wait ? "yes" : "no");
+		str_yes_no(rtd->pop_wait));
 
 	/* are we waiting on this codec DAI stream */
 	if (rtd->pop_wait == 1) {
-- 
2.48.1


