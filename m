Return-Path: <linux-kernel+bounces-387932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A9E9B581A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C6A1C25708
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12E20C039;
	Tue, 29 Oct 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGKaITtj"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D620B21B;
	Tue, 29 Oct 2024 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246191; cv=none; b=FO9kY7eMCLuKtLJRQE6+I7YO3QX78LjWiCxWkBeRr9Lwudj+VhjVu2SX3ETU3xJinLkWoyYc6ezCgKyrcc4WTWvWhrspZI/qtBG6/82K/de0T0xK0R8mw6BTs3lsLliCLukAA+rvDTY2ZOcXzSXTNJeK6DcUg61YnrenQkJ1NMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246191; c=relaxed/simple;
	bh=UuQ8M+tN/UTAN1cd/B9UAJ3aK8nBRoJ8Mz0bkX1WkiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d1T6YGZ+3VnDMcsuO7AMeqlsIbYaE8ys12Hfbz75Zr99qaq3DZ9TPuhg5EOCcGKOOTP1U9etjiN4xFPqJSurlUVxdxCTJ8ZUfnePmX4FUvEQIagZ2MWYaF3VdIpQJwxJp8LFkfDRAxjRvpZNk5R4+rL5TK9WIZI4zXUVdBbfDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGKaITtj; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e601b6a33aso3537706b6e.0;
        Tue, 29 Oct 2024 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730246188; x=1730850988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agFhpISqBLTXkaVMKA+MsdRS47xdOgah9nYjld7vxtk=;
        b=PGKaITtjejhLAkIlQRmwB7RY4AqDlfXveZlWZJp7gAk6oVz080FP+QhxaJKzXm6SwJ
         ByCXQiyHOV7beJFcYoKP50viefN1jJ4VxUt7c+BJezbFXWcJZSifhfJomAY7NhnFQYXc
         Dak5CSZTKhYNztN+g0DbdyoxLreAvUYi0Jn1WUTqRYG4aQ3op/envLNlsIR7/XqM4d1y
         +SRPsNYkNF/XNGIv0zDDr2t3swZ5MXG21469mA8EIHslyHl25FhGBuWN1znuUOZVFde+
         YyzAXS/bsEGjLLuRLY1VTAq8aWzxX/h7oMnNb3l1mtAIictz2FSTAQnRf26HTANpzzMU
         9+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246188; x=1730850988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agFhpISqBLTXkaVMKA+MsdRS47xdOgah9nYjld7vxtk=;
        b=OWCM9eXg9IyexKGpg+XRG9ZMdcoVzXf+TRwgJmbJhMRNzRaSE82kZVERl4sEaYpWLx
         flxcOWaKLSSMjVmFg+MT+HMjRnoaPRui3+tnhQ/j0GI+GeRCbKmhVf9yThQbpmmuaylB
         S7jh+2uvgn+OG3ganZE7nKYb/q14TtDN3yYRpHdhfHJq62/tNA1/hzBVqPicr/R0wF4E
         h4KxGMLPlp1nUh/5VvXHAjqUUMQ8YmLge3MmSdBmk1r0xZ8Rq0qkSL1XwvROxs+J7fBg
         4G7VvqBMLIve1Qnw04TrtY6pQmMya9zMPB+80kVm/TCslEFiNnjvNm8O8AykKw7L6HrZ
         +0+A==
X-Forwarded-Encrypted: i=1; AJvYcCUYAk4bcUY8FUd7TCdfMAOYKAWymypcy6C0QFI/hS6mZaPDBWZjdpfq5Rim1hVFzoCXIHvdD3SPTDY=@vger.kernel.org, AJvYcCWphFuhA7ksVxiukwUfAgBlPYrevSmSKtbitdMGVPPchDLjln0RQb6Kz8Hw0npm0wQocsXtmGseOzxTAQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5U4/3BqDo+tJKcUMmyQ4KWcMghPaWQuO9igWY6LjyzQTWAqI
	EheB3KDg5JTA0PpBTJ9a0Q1z4oFpCdv/4flUz9O9HEStOtG5h15U
X-Google-Smtp-Source: AGHT+IGHTz/l3VLt1FB5yE6Cf1LM8U9gwkroK+T8UsiqKMvpmoMUSkQ1C00o9jJK0/svpUmFcw+d0A==
X-Received: by 2002:a05:6808:1a02:b0:3e6:37a3:a172 with SMTP id 5614622812f47-3e638247755mr13289155b6e.16.1730246188257;
        Tue, 29 Oct 2024 16:56:28 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:5ce6:bad0:300c:46ef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b091fsm2347393b6e.41.2024.10.29.16.56.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Oct 2024 16:56:27 -0700 (PDT)
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
Subject: [PATCH V2] ASoC: doc: update clocking
Date: Tue, 29 Oct 2024 16:56:23 -0700
Message-Id: <20241029235623.46990-1-yesanishhere@gmail.com>
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
v2: fixed the compilation errors

 Documentation/sound/soc/clocking.rst | 59 +++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/clocking.rst b/Documentation/sound/soc/clocking.rst
index 32122d6877a3..8ba16c7ae75f 100644
--- a/Documentation/sound/soc/clocking.rst
+++ b/Documentation/sound/soc/clocking.rst
@@ -18,7 +18,6 @@ Some master clocks (e.g. PLLs and CPU based clocks) are configurable in that
 their speed can be altered by software (depending on the system use and to save
 power). Other master clocks are fixed at a set frequency (i.e. crystals).
 
-
 DAI Clocks
 ----------
 The Digital Audio Interface is usually driven by a Bit Clock (often referred to
@@ -42,5 +41,63 @@ rate, number of channels and word size) to save on power.
 It is also desirable to use the codec (if possible) to drive (or master) the
 audio clocks as it usually gives more accurate sample rates than the CPU.
 
+ASoC provided clock APIs
+------------------------
+
+.. function:: int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai,
+                                          int clk_id, unsigned int freq,
+                                          int dir)
+
+   This function is generally called in the machine driver to set the
+   sysclk or MCLK. This function in turn calls the codec or platform
+   callbacks to set the sysclk/MCLK. If the call ends up in the codec
+   driver and MCLK is provided by the codec, the direction should be
+   :c:macro:`SND_SOC_CLOCK_IN`. If the processor is providing the clock,
+   it should be set to :c:macro:`SND_SOC_CLOCK_OUT`. If the callback
+   ends up in the platform/cpu driver, it can set up any clocks that are
+   required for platform hardware.
+
+   :param dai: Digital audio interface corresponding to the component.
+   :param clk_id: DAI specific clock ID.
+   :param freq: New clock frequency in Hz.
+   :param dir: New clock direction (:c:macro:`SND_SOC_CLOCK_IN` or
+                :c:macro:`SND_SOC_CLOCK_OUT`).
+
+.. function:: int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
+                                          int div_id, int div)
+
+   This function is used to set the clock divider for the corresponding
+   DAI. It is called in the machine driver. In the case of codec DAI
+   connected through I2S for data transfer, bit clock dividers are set
+   based on this call to either a multiple of the bit clock frequency
+   required to support the requested sample rate or equal to the bit
+   clock frequency.
+
+   :param dai: Digital audio interface corresponding to the component.
+   :param div_id: DAI specific clock divider ID.
+   :param div: New clock divisor.
+
+.. function:: int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
+                                       int pll_id, int source,
+                                       unsigned int freq_in,
+                                       unsigned int freq_out)
+
+   This interface function provides a way for the DAI component drivers
+   to configure PLL based on the input clock. This is called in the machine
+   driver. This PLL can be used to generate output clock such as the
+   bit clock for the codec.
+
+   :param dai: Digital audio interface corresponding to the component.
+   :param pll_id: DAI specific PLL ID.
+   :param source: DAI specific source for the PLL.
+   :param freq_in: PLL input clock frequency in Hz.
+   :param freq_out: Requested PLL output clock frequency in Hz.
+
+.. function:: int snd_soc_dai_set_bclk_ratio(struct snd_soc_dai *dai,
+                                              unsigned int ratio)
 
+   This function configures the DAI for a preset BCLK to sample rate
+   ratio. It is called in the machine driver.
 
+   :param dai: Digital audio interface corresponding to the component.
+   :param ratio: Ratio of BCLK to sample rate.
-- 
2.39.3 (Apple Git-146)


