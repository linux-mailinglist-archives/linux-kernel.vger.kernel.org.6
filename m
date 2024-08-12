Return-Path: <linux-kernel+bounces-283272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB294EF67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D221F22450
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9D17E47A;
	Mon, 12 Aug 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uf6CeqtJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mf/3373t"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D4174EEB;
	Mon, 12 Aug 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472461; cv=none; b=aFs0McZ/Z9gmLz4sXeRBHCMOnCPq/QX/dhc88L/slkKJU/j84kPxIuj/WCjANkTtmNGrkgAOp7PQFwMy47Oy3rdQBeFEb887RXtlqJeH1dGrJ5bXnLmSB5bCWzDLg/Kmx900ma0+q5NU/WoCHQxRqAwbd5fHj25abZDqvZbr/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472461; c=relaxed/simple;
	bh=+MbbcfrMLqxGuRzQ4dcWA1k4c9SrYKs271WzS35qTX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FD+TQ8EXYWjtBf0NoeSLo0FozQ5JkjFgCkV/6J3fg6e7jonX9OF5QPO+YzpIExioflZqfqlrt90cFGFGwZ7sdTQw5QirDc+uPTYi9NO9Ww+J2LjYWw9BG1Ypa8u1uuYOBuLEcPbGAAIC89PvAA4Hg9BUWKp6q3BXE/bwy6+Z0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Uf6CeqtJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mf/3373t; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WjGry4BYVz9sGk;
	Mon, 12 Aug 2024 16:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723472450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xxdGD0QtojEv+8rigNDDQghjl+1l/EvJu5EhLkkyQMg=;
	b=Uf6CeqtJkIbCvTUVXtV8n63a1f6aKENwgUc7ZUTSzbBrEWI3BKpiq/+nsjcQva4wFIdkD2
	XJBZlcvqp7KR1zQhXxTkIaJng5JMGf06mmqWzu+x4ffIhY9PBvRPxCqF0sdN2BNuHSrqfV
	OBDW2WpQUNvwx7y3R7vJ/QvyaYrMD698iga+4o06zh2x0Nv3mp6sqShdKVoHwA3U+LXGz+
	6Srnm5vG3lZ89nSbf+GG7rmGtj+6e0Qp8iDxZPDOER/LHXV1vmQV9UQcWNvjWjqnXaDF6t
	eqSRscUyjVf5ZmPlO+Sm409C/2qKKYsi3pNmLY5oKzuXU2SnoMsGn7MHssnNsA==
From: Zeno Endemann <zeno.endemann@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1723472448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xxdGD0QtojEv+8rigNDDQghjl+1l/EvJu5EhLkkyQMg=;
	b=mf/3373tIOn0Y0H8K9ZBqVHS8AW/369eARDLWjvuCTBQHK+2XSQ0FpPWfE1cpbY6A1oYIR
	GU2OzOurZSWLJo+0e8QPgHC28qGp/71J3NB9NBuJ2NmINy8eNWRmox3KAG0e9bkK8nT6aM
	pO4Uc66IwEY2b2P/06DOaaQaBSxW6GLvsyd3wVsQoayKmzK6Lh9OWdfs0ODN+Zgk9cNcft
	PnrM7H/MxIyPOE42BpjqPgUcpE8wYpGOA4GfRUTcuBxHJaWpraCAbUohRAUuMVNA2khTat
	FZ+EKmH0qjNjdFRqG6czGoq7TB4LJ669db5WEH+tQumRUfjfO/ATSv3S9MzJBQ==
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	David Howells <dhowells@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Zeno Endemann <zeno.endemann@mailbox.org>
Subject: [PATCH] ALSA: core: Remove trigger_tstamp_latched
Date: Mon, 12 Aug 2024 16:20:29 +0200
Message-ID: <20240812142029.46608-1-zeno.endemann@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j3ju3hp3jo5mzypasahn9bz3drinxo6y
X-MBO-RS-ID: 2a011dac8191284ba64

The trigger_tstamp_latched hook was introduced to allow drivers to
provide their own trigger timestamp instead of the default generated
one for higher accuracy. This makes sense in theory, but in practice
the only place that uses this is the hda core, and:

* The custom timestamp there does not seem to be a meaningful
  improvement over the default one; There is virtually no code in
  between them, so I measured only a difference of around 300ns in a
  KVM VM with ich9-intel-hda device.
* It is also bugged as it does not set a timestamp when the stream
  stops.
* It creates a pitfall for hda driver writers; Calling
  snd_hdac_stream_timecounter_init implicitly makes them responsible
  for generating these timestamps.

Since there is no real good use of this facility, I propose to remove
it.

I reported the bug initially on github (see below), there one can also
find a reproducer userspace app, as well as some other potential ways
to fix this issue, in case this removal is not accepted.

Cc'ing the Intel ASoC maintainers, as the skl-pcm.c is using the
snd_hdac_stream_timecounter_init function this patch modifies.

Closes: https://github.com/alsa-project/alsa-lib/issues/387
Signed-off-by: Zeno Endemann <zeno.endemann@mailbox.org>
---
 include/sound/pcm.h     | 1 -
 sound/core/pcm_native.c | 4 +---
 sound/hda/hdac_stream.c | 6 ------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ac8f3aef9205..3539af9f733e 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -361,7 +361,6 @@ struct snd_pcm_runtime {
 	snd_pcm_state_t suspended_state; /* suspended stream state */
 	struct snd_pcm_substream *trigger_master;
 	struct timespec64 trigger_tstamp;	/* trigger timestamp */
-	bool trigger_tstamp_latched;     /* trigger timestamp latched in low-level driver/hardware */
 	int overrange;
 	snd_pcm_uframes_t avail_max;
 	snd_pcm_uframes_t hw_ptr_base;	/* Position at buffer restart */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4057f9f10aee..ced5bd2d7ebb 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1194,8 +1194,7 @@ static void snd_pcm_trigger_tstamp(struct snd_pcm_substream *substream)
 	if (runtime->trigger_master == NULL)
 		return;
 	if (runtime->trigger_master == substream) {
-		if (!runtime->trigger_tstamp_latched)
-			snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
+		snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
 	} else {
 		snd_pcm_trigger_tstamp(runtime->trigger_master);
 		runtime->trigger_tstamp = runtime->trigger_master->runtime->trigger_tstamp;
@@ -1422,7 +1421,6 @@ static int snd_pcm_pre_start(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    !snd_pcm_playback_data(substream))
 		return -EPIPE;
-	runtime->trigger_tstamp_latched = false;
 	runtime->trigger_master = substream;
 	return 0;
 }
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index b53de020309f..271d42b765fc 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -660,14 +660,11 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
  *
  * Initializes the time counter of streams marked by the bit flags (each
  * bit corresponds to the stream index).
- * The trigger timestamp of PCM substream assigned to the given stream is
- * updated accordingly, too.
  */
 void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 				      unsigned int streams)
 {
 	struct hdac_bus *bus = azx_dev->bus;
-	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
 	struct hdac_stream *s;
 	bool inited = false;
 	u64 cycle_last = 0;
@@ -681,9 +678,6 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 			}
 		}
 	}
-
-	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
-	runtime->trigger_tstamp_latched = true;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_timecounter_init);
 
-- 
2.46.0


