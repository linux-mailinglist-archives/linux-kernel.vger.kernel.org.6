Return-Path: <linux-kernel+bounces-387879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923019B571F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07441B2245A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6120B219;
	Tue, 29 Oct 2024 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUhMCI75"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260E190665;
	Tue, 29 Oct 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245380; cv=none; b=Fn2cuUKc8C/Wf165v+/DOBwoymh4sIKOExv54Ge9optyOh4wrlldfs8vfHtgokSiXdcO++MD2Y4aiXdG8rPgpi5HIwsLTu6Kh6vWLXIbxZ7YXZNm97B+mWCetQluk7Q18GKJAZVgNrdbvPcXWJxwT4UHi2mC4uCDou+goi9aZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245380; c=relaxed/simple;
	bh=P/ZMh9DdOcuMnvAMA2M8KUoPFFGuf1Rk6uM2ShCcXgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQQTo3CCdgmzGZ4w11fWtArkS12wHtn8dQ9LRdf4zR7K4o0vPWTGm6uOP+MjrI/UjGhIR6BWIfg2A38E+T2U8TdBy2NF6bC1uiL2giTkg9xmTCgn2rDCwyiEVGhg4VfJChJbLL3c7iLsE2Hnm0tU+T1EXI40aI7YTNQqZiTV5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUhMCI75; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso4384164a91.0;
        Tue, 29 Oct 2024 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730245378; x=1730850178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5feXvgGng4UyVwqTtiXO5SPyizWSYDtrgAync19J5IU=;
        b=TUhMCI75oVl7DmVV/TYKuGXZ6uuaITaDZhi6Vy9JtoknStTahuDSQM+DZVEwNQXxqC
         r+nJ4fKqa8+BUM1hhhxKw2RwvIjlE9PP5882PGzfimofYIGGTGEYxOT7LPHcskTTl8eZ
         cTFYpMLONUJSJ3NClIG4W8QmzI4WZnWGRCETzAMxJOu/q+nnwn/IURxJw7R5SUlaXwbn
         4AF9+JBkWFUdvQyZUZbaIYNQxvtiOkCJ/dGj9e64FbRHb0rh8bofl9hAf+ts9KmWEpQ6
         a1A6CC5Dx7pPbM/qr1Ooai8NRu+JdFAqCii6uKB+o584f95Co0mlFHOdpKeq0O0mZPCS
         9Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245378; x=1730850178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5feXvgGng4UyVwqTtiXO5SPyizWSYDtrgAync19J5IU=;
        b=glyWPfDMSRwHPnPJOZwHlhPRZnrpJJtZh43LgEbwW4oVQPlfOkHYPWg91EzJ1NubiO
         ycd+uwLESXlzPX/pBCn9ArtdaQgqykt3HETh7L4PvBG+otBXwNRtWxbvx0n62B8p2NTl
         xQtgb7QDDKL8t83A0cdT9hJXlxkNF9ahb/N7x0+g1OkEdAPIn3cpggOPSkGJF3P8xgA2
         2ypqBCvwKsv5SDSnWSUMTFW3qsEgn3hgcZzmBs7cMWqygE6mvuuvSNRAOBW1vwr/0W8c
         x6nLJNHkIrJK1M2Y62W4MFU17ZEZElVZihhDfPXuVabhMzvIF2YVfg5tE4g6L0R00b4Q
         qopg==
X-Forwarded-Encrypted: i=1; AJvYcCXSHT6EppdiVP+jLF2zELBd32ZwTYV0YckwviJJWjq4aPVi4zHQUWUjaIllfe+8mzT7NKyEDxVe06XQAec=@vger.kernel.org, AJvYcCXkCjFy09cLve31Q4HFtlkAa8w5Mq2I2ksH8n3YDDI7bP08sSM7O85Jmmoc5Auqbea0YkjBj5weRE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSqhJH6O5zBa+tda7lG0041WSs4wMbQeAEGhDqKlBHe9endS5
	0sVX1jfBau7ceeOaoDPYpoGlSiM6xRnn/CSgwWOKR1cJw001ciUTF6JcrWOAA8Q=
X-Google-Smtp-Source: AGHT+IGLItW6eG57/BOKSOCl7xb6uVRToNOcNGndd7ZtiRJGOr4L61uJYTDa2Et0MWkJmJuYJA+x9A==
X-Received: by 2002:a17:90a:a88c:b0:2e2:bb22:eb59 with SMTP id 98e67ed59e1d1-2e8f11dc376mr13808125a91.41.1730245377895;
        Tue, 29 Oct 2024 16:42:57 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:5ce6:bad0:300c:46ef])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa3dbd2sm265396a91.20.2024.10.29.16.42.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Oct 2024 16:42:57 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] ASoC: doc: update clocking
Date: Tue, 29 Oct 2024 16:42:31 -0700
Message-Id: <20241029234231.46313-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ASoC clock api details to this document.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/sound/soc/clocking.rst | 85 +++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/clocking.rst b/Documentation/sound/soc/clocking.rst
index 32122d6877a3..eb0007dde7f7 100644
--- a/Documentation/sound/soc/clocking.rst
+++ b/Documentation/sound/soc/clocking.rst
@@ -18,7 +18,6 @@ Some master clocks (e.g. PLLs and CPU based clocks) are configurable in that
 their speed can be altered by software (depending on the system use and to save
 power). Other master clocks are fixed at a set frequency (i.e. crystals).
 
-
 DAI Clocks
 ----------
 The Digital Audio Interface is usually driven by a Bit Clock (often referred to
@@ -42,5 +41,89 @@ rate, number of channels and word size) to save on power.
 It is also desirable to use the codec (if possible) to drive (or master) the
 audio clocks as it usually gives more accurate sample rates than the CPU.
 
+ASoC provided clock APIs
+------------------------
+
+    ::
+
+        int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+                                   unsigned int freq, int dir)
+
+    This function is generally called in the machine driver to set the sysclk
+    or MCLK. This function in turn calls the codec or platform callbacks to set
+    the sysclk/MCLK. If the call end up in codec driver and MCLK is either
+    provided by the codec in which case the direction should be SND_SOC_CLOCK_IN
+    and if the processor is providing the clock then it should be set to
+    SND_SOC_CLOCK_OUT. If the callback ends up in platform/cpu driver then it can
+    setup any clocks that is required for platform hardware.
+
+   dai:
+       digital audio interface corresponding to the component.
+
+   clk_id:
+       dai specific clock id
+
+   frequency:
+       new clock frequency in Hz
+
+   dir:
+       new clock direction (SND_SOC_CLOCK_IN or SND_SOC_CLOCK_OUT)
+
+    ::
+
+        int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
+                                   int div_id, int div)
+
+    This function is used to set the clock divider for the corresponding dai.
+    In case of codec dai connected through I2S for data transfer, bit clock
+    dividers are set based on this call to either multiple of bitclock
+    frequency required to support requested sample rate or equal to
+    bitclock frequency.
+
+   dai:
+       digital audio interface corresponding to the component.
+
+   div_id:
+       DAI specific clock divider ID
+
+   div:
+       new clock divisor.
+
+
+    ::
+
+        int snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
+                                unsigned int freq_in, unsigned int freq_out)
+
+    This interface function unregisters the "thermal-cpufreq-%x" cooling device.
+    This function provides a way for the dai component drivers to configure
+    pll based on the input clock. This pll can be used to generate output
+    clock such as bit clock for the codec.
+
+   dai:
+       digital audio interface corresponding to the component.
+
+   pll_id:
+       DAI specific PLL ID
+
+   source:
+       DAI specific source for the PLL
+
+   freq_in:
+       PLL input clock frequency in Hz
+
+   freq_out:
+       requested PLL output clock frequency in Hz
+
+
+    ::
+
+        int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+
+    This function configures the DAI for a preset BCLK to sample rate ratio.
 
+   dai:
+       digital audio interface corresponding to the component.
 
+   ratio:
+       ration of BCLK to sample rate
-- 
2.39.3 (Apple Git-146)


