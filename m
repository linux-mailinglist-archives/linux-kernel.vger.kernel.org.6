Return-Path: <linux-kernel+bounces-196689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BAA8D5FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA279288E46
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E21D156679;
	Fri, 31 May 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBX0sVX4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BA15099E;
	Fri, 31 May 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152571; cv=none; b=CyL4aSxfbXOeALJS6TUMoFYu0OEcTFcA0pGopBueAw3i1s/5MuO7BU/kR16lvQn/uEPO8neps4QrkkEZXodlxPNhXzwgTYbOx5u6mX2FmQucGaWTZcrGLuEXPnmLSiVNw1gX8wRvbIBCs/wPiQro9uTrb3i3kY21CsxpOZO1cGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152571; c=relaxed/simple;
	bh=pblZuT61VCx5vsKlZZtH1uamW5g6Zzz2eXnPbUTy4hg=;
	h=Date:From:To:Cc:Message-ID:Subject:Mime-Version:Content-Type; b=bCbhJFTHEAGioxGZzM0Y8O4ETXVAad/7krbhFx9XnXj3T0taTdxRptu60YbAEwg/3SDZJxHjGCyOYz6UQxHBmymCw31qvBpQ4ctyn/3tOkeTgT7I0cu4AjMYV0fm9MTEb6GVFtAWhbOikHipn1444ekrL5LEUzSnukIRm2bIEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBX0sVX4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso2780144e87.3;
        Fri, 31 May 2024 03:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717152569; x=1717757369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRfMYuc2oZrIFwHAbgozaR/RAHSemeaE5sWTQ1UXSXk=;
        b=SBX0sVX4xA2gJBZcUOjUHkIxSEYj/AZ3aLjzDZJXLuilEtf+8ZawrPdWIki40z21vQ
         WeNphP7CCqv14I1uqxEqgrIDBs85Vjp5WpOyZ92Fidg8IA34zgktXuWc3UT+bAAB7myP
         mrx+mz6C1EjDBgIhbYbgJ+fRStBAiggrUoGmYdqgJJWY7ySidO3/kpU6LYcN0I38H7pt
         TIwknOTdSSW1MlYWAkHAqv0l5Nlr8DrKBVsCi1gLwBXhy7PUU6lehQeNuT5Vkdfk1za8
         +AJGQ6A3tbeHIW7HVlgr7sKilzPgqbjPcC+8xH3CSupnw4HRfNse1OBP9UaeEj7N/I0o
         T5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152569; x=1717757369;
        h=content-transfer-encoding:mime-version:subject:message-id:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRfMYuc2oZrIFwHAbgozaR/RAHSemeaE5sWTQ1UXSXk=;
        b=CFnur3ca/skwlEng68OSyN5tmIBwgf+dfJNZQT37Bckldc5DWBCvarbPflfqOjPE0j
         iuY+2hDWnOlGfrjBbXmb0pxUMhi92n4FBFRNpOUajXZH95JNIGBuOzbUG2G5vytSk5rX
         rDZ4IWPzMayrSSVWb2GPgK1jF3WJiInS+cxumW5c1pKRv/QA6b2vKHtVeK6LKsoT2wGy
         PYgj+n4Yu5UJ461h3L8xOgOMhEPpc+Pzi5UecKHaq/nFX52Vqfe3DHZ11RHdAgwiBHU8
         OuQu3K+56YemYv5tE6QdVGAaXEGlMAVr41W0qCGrfVzntohiVumQRxcFw4wKFrs1GydD
         dtmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrUlCmWuohPR0tSPwv62VEaflH1/p737krTTwec7fkfadw5ByVVyDHiofilA82PQCr6J5+NPMiwFS08zm/rfb6be80ap1CNZYY290o
X-Gm-Message-State: AOJu0YzzsICka88/guvWbS81rZ0B9crY8vPJAJRsuSvBlmf/7HCosZHy
	bdsgOlMH9JR4W9Hsn6Qdh9YEHZCVhTIdo2mL7APTm8oaZSo7K5U/
X-Google-Smtp-Source: AGHT+IH93ydQNYGhnusbE4nE+VVAoM3R8/l5TcLUYmIfPgPd/wizUfk0JMXCv81VEGeZWU1NyPKOdQ==
X-Received: by 2002:ac2:48aa:0:b0:523:af1f:89d9 with SMTP id 2adb3069b0e04-52b896afe18mr1248601e87.58.1717152567964;
        Fri, 31 May 2024 03:49:27 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e2f5494dsm74207766b.0.2024.05.31.03.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:49:27 -0700 (PDT)
Date: Fri, 31 May 2024 12:49:25 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Message-ID: <6659ab35e4545_ad3bd3707a@njaxe.notmuch>
Subject: ASoC: sunxi: sun4i-i2s: swapped channels from second capture
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Hello everyone,
I am experiencing an issue with the Pine64 A64 i2s controller, which is
compatible with sun8i-h3-i2s. The Pine64 board is paired with an external codec
(ES8311), which can capture from a mono MIC. MIC data can be sent to both
channels or to only one selected channel. During the first capture everything
works fine, but since the second capture the channels are swapped: e.g. if MIC
data should be recorded on the left channel, it is recorded on the right
channel.

It seems it has nothing to do with the LRCLK which looks correct under the
logic state analyzer, also consider that playback does not show this issue.

It looks like the issue is due the RX FIFO: even after flushing the RX FIFO,
the first read sample is the last sample from previous capture. This likely
causes the channel swapping: the first read sample from the RX FIFO is
attributed to the left channel but it's an old sample, then the second read
sample from the RX FIFO which is the actual first sample from left channel gets
attributed to the right channel, and so on.

By adding an additional sample read operation after the RX FIFO flush the
channels get no longer swapped:
---
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 5f8d979585b6..a720daff3be9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -961,10 +961,15 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
        /* Flush RX FIFO */
        regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
                           SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
                           SUN4I_I2S_FIFO_CTRL_FLUSH_RX);

+       /* XXX: Additional dummy read otherwise first read is the last from
+        * previous capture, despite flush of the RX FIFO */
+       unsigned int sample;
+       regmap_read(i2s->regmap, SUN4I_I2S_FIFO_RX_REG, &sample);
+
        /* Clear RX counter */
        regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);

        /* Enable RX Block */
        regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
---

I haven't found any reason for this in the User Manual and by debugging the
registers they look as expected, but maybe I am missing something.
Can this issue be reproduced by anyone else?

Running on linux asoc/for-next branch, commit:
47d09270d777 ("Merge remote-tracking branch 'asoc/for-6.9' into asoc-linus")

Best regards,
Matteo Martelli

