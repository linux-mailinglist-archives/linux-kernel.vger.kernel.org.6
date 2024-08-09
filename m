Return-Path: <linux-kernel+bounces-281005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF4E94D1CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6BD1C2103B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5A195FE5;
	Fri,  9 Aug 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MR+OoK1z"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20A19580A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212438; cv=none; b=ha/yY19vRK5IOemK/i+ETWG/MaTxOWJd3Sen7LdBxNAntgElbBA1U2MLYEpLlqpSeUQWG6j4lZ+0t3Rq+RLhjwTE4QPHYpqnjy+TgAPAIVDy0g1p0bBdm9bDLO42/DpWHx2FC6YNzTlxh/w/jkjYWxKo/gbQVCuO53mG0oy5Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212438; c=relaxed/simple;
	bh=3XkI4b92uJtcH/wkNHuOUJZhokFuyv930DI5WCjRN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMhjEzjhHWsj2YfpGBtCxOGfkEuRc/hVAtxT0oXbCkgSoOkXV8rSZh1iCZkZXrRJE4z0zJizz3fIJ0JXyvs6bjWKSGbKojuj2eoSUEuwk5RlRKSBysnGr96YDQqTV4u8MUPpdBNrV4lbV8z0IUZlJvc8CWmoZ80aKVwWR8I/v8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MR+OoK1z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so1720843a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723212436; x=1723817236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2ubsNBkHICjAKnj3VJLgF6tvUYKGQaSXUZ9IHeUjTM=;
        b=MR+OoK1z+WEVapylEJ4HxE6IRY2hXdDLmhaTz4BF+RbEGdCdYKQljSkB+ZEOn3En6o
         79LJou+9AOGfoz+Ilqdvw2xJbAe4lCK/cziDHh6qpwSiX2n2+sQiq5id2HTS3dM1hIos
         6PR19NTBRAnubusxypWwTQo2Fnu26GaRmiYhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212436; x=1723817236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2ubsNBkHICjAKnj3VJLgF6tvUYKGQaSXUZ9IHeUjTM=;
        b=mFTml0NXJIylAfhwHK1EUXqTnQtPqzpwXqFuoA0SDaiCycXhtWVULiHD4G9BFhxcBw
         Go8nztuwlBeXCbu4urcNquP/EKmfYppr+1e2uvYDGT1zhIxg2+rMJm6XQQdKTR+RAA6y
         +6SVTnOtFAO/YUsjFkIVUJfodyqdRsnKEXqyfSsghiTgQiMvop3eKf7sSIC9uaEOti8o
         T/b5hK98jDPDvl7Lf6dEkyOHZVeGoHcBPAt3wuJkNELzfUCmx18cUoNYCLWcYjzBjM5A
         DAveosZr8J7qbIUjZy/sMRMg2KebQzDCBcFF+vZliP+GXNqqjqlIr3mCXM7x1ZUTY+J9
         d27A==
X-Gm-Message-State: AOJu0Yyet8nNMdxlhv77YYL5ROc/YfDTBSVkOzx3cEZEjD/V+O7azjtg
	kbwzGF6pKm5GGksLqhvw8vKobj24jWv9kcJsY7zcLZhhEOXa8i5l9WtY3bJAudk2CLAICs9REuI
	=
X-Google-Smtp-Source: AGHT+IHBh5T9/m4Bb3Mnijo58OaunbxzLHZGB7+5RnK6l5Z6jVFq/unajHaFdxGJkfXNRPo1eRsBIQ==
X-Received: by 2002:a17:90a:510e:b0:2cb:5128:efdd with SMTP id 98e67ed59e1d1-2d1e7fb6373mr1812276a91.10.1723212435769;
        Fri, 09 Aug 2024 07:07:15 -0700 (PDT)
Received: from normanbt-p620.tpe.corp.google.com ([2401:fa00:1:17:86a2:9ae6:e93:3245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c64b1fsm3262422a91.7.2024.08.09.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:07:15 -0700 (PDT)
From: Norman Bintang <normanbt@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: broonie@kernel.org,
	alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.com>,
	cujomalainey@chromium.org,
	Norman Bintang <normanbt@chromium.org>,
	Chih-Yang Hsia <paulhsia@chromium.org>,
	David Riley <davidriley@chromium.org>
Subject: [PATCH] ALSA: pcm: Add xrun counter for snd_pcm_substream
Date: Fri,  9 Aug 2024 22:06:45 +0800
Message-ID: <20240809140648.3414349-1-normanbt@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds an xrun counter to snd_pcm_substream as an alternative
to using logs from XRUN_DEBUG_BASIC. The counter provides a way to track
the number of xrun occurences, accessible through the /proc interface.

The counter is enabled when CONFIG_SND_PCM_XRUN_DEBUG is set.

Example output:

$ cat /proc/asound/card0/pcm9p/sub0/status

owner_pid   : 1425
trigger_time: 235.248957291
tstamp      : 0.000000000
delay       : 1912
avail       : 480
avail_max   : 1920
-----
hw_ptr      : 672000
appl_ptr    : 673440
xrun_counter: 3  # (new row)

Signed-off-by: Norman Bintang <normanbt@chromium.org>
Reviewed-by: Chih-Yang Hsia <paulhsia@chromium.org>
Tested-by: Chih-Yang Hsia <paulhsia@chromium.org>
Reviewed-by: David Riley <davidriley@chromium.org>
---

 include/sound/pcm.h  | 3 +++
 sound/core/pcm.c     | 6 ++++++
 sound/core/pcm_lib.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ac8f3aef9205..384032b6c59c 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -498,6 +498,9 @@ struct snd_pcm_substream {
 	/* misc flags */
 	unsigned int hw_opened: 1;
 	unsigned int managed_buffer_alloc:1;
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	unsigned int xrun_counter; /* number of times xrun happens */
+#endif /* CONFIG_SND_PCM_XRUN_DEBUG */
 };
 
 #define SUBSTREAM_BUSY(substream) ((substream)->ref_count > 0)
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index dc37f3508dc7..290690fc2abc 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -462,6 +462,9 @@ static void snd_pcm_substream_proc_status_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "-----\n");
 	snd_iprintf(buffer, "hw_ptr      : %ld\n", runtime->status->hw_ptr);
 	snd_iprintf(buffer, "appl_ptr    : %ld\n", runtime->control->appl_ptr);
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	snd_iprintf(buffer, "xrun_counter: %d\n", substream->xrun_counter);
+#endif
 }
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
@@ -970,6 +973,9 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	substream->pid = get_pid(task_pid(current));
 	pstr->substream_opened++;
 	*rsubstream = substream;
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	substream->xrun_counter = 0;
+#endif /* CONFIG_SND_PCM_XRUN_DEBUG */
 	return 0;
 }
 
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6e7905749c4a..6eaa950504cf 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -184,6 +184,9 @@ void __snd_pcm_xrun(struct snd_pcm_substream *substream)
 		pcm_warn(substream->pcm, "XRUN: %s\n", name);
 		dump_stack_on_xrun(substream);
 	}
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
+	substream->xrun_counter++;
+#endif
 }
 
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
-- 
2.46.0.76.ge559c4bf1a-goog


