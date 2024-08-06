Return-Path: <linux-kernel+bounces-275982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E824948CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138ED1F22487
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48781C2326;
	Tue,  6 Aug 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EsEpT+01"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED01BD501
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940039; cv=none; b=iBVrlX+x/YAOPHaPFsK8b0hyYpnhU6U2+k7SltZbSNl3EC9YRfSMbl1sctbchhtqf2cBy9Xh7fMciuK4k4chtgk4AF7opHAtst3UTuAimK1RMA6z/aO8tUbFEhNXFo7MwVxzQ/Ec4pnIC9lOaS6wiFw4qq0HbVNvj96dLDtVhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940039; c=relaxed/simple;
	bh=Xa7ikL07CwO7v5NvJFdMz+B9/6IHLNqvB3+OJfxa9Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz45bMQDOkD7s+o5np57sGHH7f4U4c7j1buidx8RF171MxFnrPBL/iddmNgxve0XnovT4wmlzj66mZICFMJx3lE7WnrGCg3gkQ6VXj8f5e7oO2Bjuy7PuEN3zOMdH7Ps4iLSMztevSphg+4JNFE3hx++SmHe0ZvrCio2MY/xBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EsEpT+01; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso4035371fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722940035; x=1723544835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWPNsrWX2yOQoNoUJ3eWdP1AwzsknTGOk+n/VwMy71Y=;
        b=EsEpT+01Lq8lq9YuL8rr+2bA28AgAC8kyCWre16yKjdm3JdNVq1XSO5iJ14DqODFZr
         OkKMPNtabqCE/4OP1T/p4VuCqDA0RhQKkfjf4dU98rp6r6KdZIsvmp9O35zuxtFzqbZ0
         0WTszS9OiSWKamGYQvXaeWMFloN7Qfhl4F7Ru2woyjV95MIBN2Bir4wBRZVzIyYhierX
         lMyeYm115omBJb2egtIu61+0wMYDnw2NcsQvhTCIReuCgNW9wiIccQv5QCu4tnbo5OP+
         V95qdrHbMdZoqzhfdnvj01GAeIRjtX58zsFEoH08MRgR3bmFkoiPDpFF2obwLHXaqcGq
         kSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722940035; x=1723544835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWPNsrWX2yOQoNoUJ3eWdP1AwzsknTGOk+n/VwMy71Y=;
        b=AGrhAkcXsRikOTZf4MyM4enhjvD65VxcKuPZ9xOKHbF5Vz3/y5ETMYQDgSN547+ALg
         fJDAlYJolriuTAcrhMxvvCxImo1bW83MT5cFSBKfwqhs4AlrR1sXsMlpzv+cWmFa5MqY
         qDzHvKlf4MIpiDvRgvin4MQYeB/Biyr8/3/2bpbp0W8ZXTgtqFmbCZjM2roMPZa4zWBX
         IKSGuHTtirDFg6Oc+mHFqhId8ttE+0DHWg2zINq0ZZNYZEWi7/b/yY/0Q6o6kadeS/Dq
         4WBUnhysJSL/HYPjoHByERWooyLFu0Vqe7c+DSEXmTN4El3o4dgwRE3d2OHV0JV+/ZSd
         hY9w==
X-Forwarded-Encrypted: i=1; AJvYcCUKk+YIeGqUaS9a32354Yqatvo7ymKj5ck/n1ysTAhb5yM60T0ZXXqpZGIzSFGXdW0Bjw3vkVgHMPNnEgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyA7OowKiAh1c68atFxoYfzgPWrnMJDgs3u4Cij1UdJcm1ospX
	FGKDW1DoawKHLYkOm89NsIQE2xXsskw1FbmME6V0XKwNtFyg0JtaCDn5MSUMrjY=
X-Google-Smtp-Source: AGHT+IFLNq6D7zUmhFznmLMT/7z1PKPJ2cAodH71RSFK2iNObFZv9SHqiiRmAW23aOKp+qbcYsfsJQ==
X-Received: by 2002:a2e:8696:0:b0:2ef:246e:d04c with SMTP id 38308e7fff4ca-2f15aab265dmr99425811fa.26.1722940034418;
        Tue, 06 Aug 2024 03:27:14 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:c541:c0a5:2f43:ca78])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e4073f7bsm195890475e9.18.2024.08.06.03.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:27:14 -0700 (PDT)
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
Subject: [PATCH] ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT
Date: Tue,  6 Aug 2024 12:27:03 +0200
Message-ID: <20240806102707.3825703-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

With PREEMPT_RT enabled, spinlocks become preemptible.
This is usually not a problem with spinlocks used in IRQ context since
IRQ handlers get threaded. However, if IRQF_ONESHOT is set, the upper half
of a threaded irq handler won't be threaded and this causes scheduling
problems if spinlocks are used in the upper half, like with regmap when
'.fast_io' is set.

In this particular instance, it is actually better to do everything in
the bottom half and it solves the problem with PREEMPT_RT.

Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Closes: https://lore.kernel.org/linux-amlogic/20240729131652.3012327-1-avkrasnov@salutedevices.com
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: b11d26660dff ("ASoC: meson: axg-fifo: use threaded irq to check periods")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 7e6090af720b..d0d05fa44d66 100644
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
+	/* Use the bottom half of a threaded irq with non-atomic links */
+	ret = request_threaded_irq(fifo->irq, NULL,
+				   axg_fifo_pcm_irq_block,
 				   IRQF_ONESHOT, dev_name(dev), ss);
 	if (ret)
 		return ret;
-- 
2.43.0


