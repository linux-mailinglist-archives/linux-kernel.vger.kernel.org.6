Return-Path: <linux-kernel+bounces-278272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D194AE22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD411C219B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58513D297;
	Wed,  7 Aug 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O161Virp"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B413664E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048041; cv=none; b=L4dWygbTh6BDf9Fx/62Vd/9XB3/LWPBJLZKu3j06vJn2jAvjJl96aT8aKI6fN/EEHPL3/rSvJM80ghK2dUKQH0RPkP4OYcUL/k/24kQvMN6n8h+u2XIGaPPXkM8QZNYjSXaaEw8sBVfdTfqnUbP2EAXqEHHBpn5Ws4EVg57x8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048041; c=relaxed/simple;
	bh=Ng+/JCc1gUQ4aifD/rVtKKq53bnVZwaYRNuOqvikte8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFqY5AU5tF0dE266m0tWbjiaL+OVCoLoGeKyECdZZHojsG48Ybl22p67bibDrAXFk3qEMYQYcLJsOTS16KKpv4cl93C9i6Ckd1xOZ43/H8a78GlpnZK2mEZVCFN1kEY/6+xnRVNpg6eKtFdO3AvI2uM3y9SaLVeI15q/SglVzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O161Virp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368712acb8dso11576f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723048036; x=1723652836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+dBIqzE9uz4423Miwg6qL/QPsaguESKxdu18p0e9Wk=;
        b=O161VirpEQIjSvDctRl8aAPs8k4Vk0vH3/cyB3mqqiQ6R3+IBWJlfDQFOa53yf+IUl
         nL491rnWSlx3OHWzmBYAM1eJJujchG5S3STwdCV/5RdxoPDToJ2IHISHLYoZBTP1fH5o
         qzidJLeFjoICK44EVQjKpe5/3tgMOy2jxwxxthOA5S3zPuizcyAMbWZeuX34F8xnty5D
         Zf7mkpAEBUNzeuuVDLX+dXsvWYUklPNkhXSdJn3MglzAXwjnuaMFIkUucEuS219LAXUr
         UnJbNo/OXxoWRzsoY13AHNW3x+AdKnWz0YhgsNhFReKsCiVZwORHb93pmlPmqgHHRFre
         VHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723048036; x=1723652836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+dBIqzE9uz4423Miwg6qL/QPsaguESKxdu18p0e9Wk=;
        b=gC3HEPXouMeK16nxYTizsu9lSPSV+DUO3E0A90czcAd4kUmK7Bz1EoRjXBquGHQMAA
         doAzQa+14Itvh8x4ihiRUIigGDDlMeMSNKM2xMqefeo6hG8jjUGxYlBeJq5lg7FcyXu1
         I1Md/fPfw/X0yxUE6ckhJVKvqdm3yhdSvv6jwqAT157pxo4u3pW757cVQxb346HLHpvG
         2e7RU5sRVgM7HLj7FnLZ22HWUXp6qClzczkWEx26N7z3XXRHiD0Fmu3MVixJ3W3OT9CG
         zJspEcoMZz7KYLvsYvZAG/kfD6jJjegPiszCoXlbFyNYnU4uAfHq/Es2j1pB2V9HYqpJ
         4ZiA==
X-Forwarded-Encrypted: i=1; AJvYcCUxl/D7rqcAigODNEaAAP2KZIksFO+mwFVd2MluiOyc+Z2EbCNSV5PeykW2i8HSaMOJxEBuQ9ZlaG1uqoeP2y7aQhpxEl6A9/wH2q7a
X-Gm-Message-State: AOJu0YzSiBG+lqcojJ6Zte/so7iyVDr3oTZiXqj7Kd8NK+zZOzWva7eV
	BJuk4tbrAxODwYrBkAZwxXp73/eO0b4wCebR7sm3RpeM4hgUWpZ/LSw6Oxmi0fw=
X-Google-Smtp-Source: AGHT+IFwKsKtdGBREmHTq2kOs7k4+/3e+X9EV8QnAXRSEkHZm0dwuN3Fu+VfeXznpGNYYLj47KdTtw==
X-Received: by 2002:a5d:5c87:0:b0:36b:bd75:ed73 with SMTP id ffacd0b85a97d-36bbd75ef23mr13891573f8f.23.1723048036168;
        Wed, 07 Aug 2024 09:27:16 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:90f1:3c4c:261c:b0f5])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd169697sm16494184f8f.107.2024.08.07.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 09:27:15 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-amlogic@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
Date: Wed,  7 Aug 2024 18:27:03 +0200
Message-ID: <20240807162705.4024136-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

With PREEMPT_RT enabled a spinlock_t becomes a sleeping lock.

This is usually not a problem with spinlocks used in IRQ context since
IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the primary
handler won't be force-threaded and runs always in hardirq context. This is
a problem because spinlock_t requires a preemptible context on PREEMPT_RT.

In this particular instance, regmap mmio uses spinlock_t to protect the
register access and IRQF_ONESHOT is set on the IRQ. In this case, it is
actually better to do everything in threaded handler and it solves the
problem with PREEMPT_RT.

Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Closes: https://lore.kernel.org/linux-amlogic/20240729131652.3012327-1-avkrasnov@salutedevices.com
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: b11d26660dff ("ASoC: meson: axg-fifo: use threaded irq to check periods")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 7e6090af720b..75909196b769 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -207,25 +207,18 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	status = FIELD_GET(STATUS1_INT_STS, status);
 	axg_fifo_ack_irq(fifo, status);
 
-	/* Use the thread to call period elapsed on nonatomic links */
-	if (status & FIFO_INT_COUNT_REPEAT)
-		return IRQ_WAKE_THREAD;
+	if (status & ~FIFO_INT_COUNT_REPEAT)
+		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+			status);
 
-	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
-		status);
+	if (status & FIFO_INT_COUNT_REPEAT) {
+		snd_pcm_period_elapsed(ss);
+		return IRQ_HANDLED;
+	}
 
 	return IRQ_NONE;
 }
 
-static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
-{
-	struct snd_pcm_substream *ss = dev_id;
-
-	snd_pcm_period_elapsed(ss);
-
-	return IRQ_HANDLED;
-}
-
 int axg_fifo_pcm_open(struct snd_soc_component *component,
 		      struct snd_pcm_substream *ss)
 {
@@ -251,8 +244,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	ret = request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
-				   axg_fifo_pcm_irq_block_thread,
+	/* Use the threaded irq handler only with non-atomic links */
+	ret = request_threaded_irq(fifo->irq, NULL,
+				   axg_fifo_pcm_irq_block,
 				   IRQF_ONESHOT, dev_name(dev), ss);
 	if (ret)
 		return ret;
-- 
2.43.0


