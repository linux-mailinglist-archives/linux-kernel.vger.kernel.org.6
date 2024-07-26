Return-Path: <linux-kernel+bounces-263352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75C93D4CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5048D1F2390A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E282AD49;
	Fri, 26 Jul 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHyxN2gT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC34C8C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003059; cv=none; b=hYc7r8zjfwknbvu/EbTseTs89Cj/kZyi+8Wnkcpz1ckcgd8V5hV7bspGZrZ9WgSo17Azxikig/vUz5IOuiePGZu4slCx9XqpcEpsuyUxz8jIAg65DFksRMbBWo6YxZQvXWG0IeAH4vyGZ4NaKFqU+FGGqH9ka2KzcRT5i5WZip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003059; c=relaxed/simple;
	bh=YE4hixYCVQKmzPIsA7SgCIYgqoaL2VnDKmtBWegqXfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bnnq6A5burpFs+/vLhlR/AMDN2eKLD40R/1d0D7o+0YdJMJXCXAu5Yl9grIkrz3QpIP5g7jqvN11+0Ik6txpg7nemLt7xcSOwFDHtElLU9ASiUik3FKWjXB/X7nfmjdoH898/KVYyq+pxRAY4p6hoUUUYwQdPj2P6YP9jsKnfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHyxN2gT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280854e236so12195465e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722003056; x=1722607856; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foeasWWJNDhQ/HQ4yEQa5PNHkqWSKIaHaPMG9mfsBz4=;
        b=EHyxN2gTN19o6M9Oab0xWVWZEEONvHKM6rbAdTiKHDnNZKq0CyY+Vl4hpiUh5UhrMm
         z7t2rMTicg6HaP5c7Ebi2AQRcDcjeEmVRtKnOf61FICa1oO2IcR1ppLBJDxLRzReF0aO
         KL5N9eM7/lNhiOG05rXRBkcKZRi1tTGjqef1XXgNDyACVRckBhcVb4ZjwhG2vsnuiE2D
         1pwn/tMmr6BafXN4aPYpL68o5GxuHJ0enYJDJ4E15F0JgBKkWRbK9lkBFJakhx5jSrrZ
         BM/f1OUPX/QCiMc0qnrLds77VYmCYkLG2aJYtLVvnOrQnv7+5G9TjcrKeTob+9MP32NN
         1Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003056; x=1722607856;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foeasWWJNDhQ/HQ4yEQa5PNHkqWSKIaHaPMG9mfsBz4=;
        b=gsrg9xEUyVw/dyDs3nXM6Qo1hOjZIycDCvNRpuhQN6fGAOPUOpyxeBQ4jTROmmmuK3
         lk5CdZH1iSN5ALf8CGyhmOg2648J79hBus3abwK3O65Qoub9PrEEGe768gh+SpDm5dPe
         TrswIea2pvFGNFKFil/Hg0+CIzPNRNcUFsHlrmgyMRMAUM1jdbuDXiEYlNgSXCWc0m8F
         gIWGsmjai2MILGZPqrQgKDoVkbDsgLOs5SgJIgy7pFShlPiiXnseki/f0aC1krAcuIXz
         TO6b8DTDFwa0tZoN4/0jOFJdcCeMrgoHzhwRpxn4VRiaLvX300+LDNAwd+7d+s4o23SD
         paCg==
X-Forwarded-Encrypted: i=1; AJvYcCWVuapXSoY4rJ2gtXM3azRMmZTuncHtL0S/KFwueiUbML2P4GJxgxJYcUt5ZVgXb3pFEsrLMGtdmCEsGHgLN3lruUzQ2lfIA+2UlbXK
X-Gm-Message-State: AOJu0YxHeQJx9T1BFbUcOWCi0Ix6p42QrvCR0htCzwjWK0rQnQxGRI2M
	94li0zVgSRZ9CZ4/rpxycYwkKdUVCrEGev0DjWC30N7Krm/mkoRg1JjoSuVNuCmKKpq66UyrBW5
	E
X-Google-Smtp-Source: AGHT+IG3sp1c9rKGEdCfW+UiBfPYjCoX2jPEb3H4yCS5NXZnPSEYkTnzpC6vqLsOS0B4q9wzpWgk1g==
X-Received: by 2002:a05:600c:4590:b0:426:6f31:5f5c with SMTP id 5b1f17b1804b1-4280570f82bmr39943175e9.17.1722003055613;
        Fri, 26 Jul 2024 07:10:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm120841115e9.41.2024.07.26.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:10:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/6] ASoC: codecs: wcd93xx/wsa88xx: Correct Soundwire ports
 mask
Date: Fri, 26 Jul 2024 16:10:40 +0200
Message-Id: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGCuo2YC/x2NywqEMAwAf0VyNuBW8bG/Ih5KTTWIrSTLVhD/3
 eJpmMvMBUrCpPAtLhD6s3IMWT5lAW61YSHkOTuYyjRVZ1q0Gh0mN2NSi5oEjyg/xYXCbnXDvu1
 NPfghw0OOHEKez3cwTvf9APRfa3xwAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>, 
 Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YE4hixYCVQKmzPIsA7SgCIYgqoaL2VnDKmtBWegqXfg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmo65lV9Gvax58HA4nJOVWc+P2pZ4UebG+2xFoE
 EFFTphcM7GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqOuZQAKCRDBN2bmhouD
 18aQD/9jqTriLZNGzTS27m5EsRS6+s02mSwC3shx1DXDLvoNDAw3a7tPUCH16TNnrKhlXaoJhfw
 JL+dnvFlRiqGh1EnC3HOJUcY07m5RHTRSFm7THjhgQWo1GZG2XvYgqFjvkVV9bOKK5vQHiF+nI/
 BS+DvwFMNocr/veCSQsUuvKNPlVwdlxkYTh7zwlyvBE60417cWSOR05RfYYYctkp7AWi/h6Ieiw
 woHS3QR/jNB8xqMG0DFUA0Ckoeu3Z116swyTO7PSMUfE2D9gB0HLSpjm08Jzm/+3lLGAQgaPC+I
 UdacDO88/fZdMMC1aQb1c0cUjEhlxdaEMosP6Yg/egprTP+MJo4WFCkGdqldyFMfiWAlNUmfqp9
 7Nb3qFgQ/gflcncKXAGzaDiosxI64hYYwVmPzyE0ge1+3pb30U1AYk3NXelhdpznWqtzR8vSZvX
 vvxCa3NfJGHKbDvojkN1aHQH82meYPyHSXHT6+oZqnydzIgr0PcWNfjC/nbM2yIfq5/+FEX4hNZ
 2wAw0bBFvrOpIT8K/UeHgw2EjCO8UbQWAhy/aMgA6fkQ0Vuj6HRWt5PXyYsLcMJ1DOaA8Sx3UrI
 6r0pSO9YO+k3gZbYwQ6yx6A0MEgvrVbeC9ej09sbT958JvkHwy9ftAmlab7+diNSrPWT/EioYBL
 kvDVeyddORIUEoQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Incorrect mask of Soundwire ports - one bit too long/big - was passed.

Theoretically, too wide mask could cause an out of bounds read in
sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
driver, e.g. adding incorrect number of ports via
sdw_stream_add_slave().

Not adding Cc-stable because I don't think the issue can lead to real
out-of-bounds read.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      ASoC: codecs: wcd937x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd939x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask
      ASoC: codecs: wsa883x: Correct Soundwire ports mask
      ASoC: codecs: wsa884x: Correct Soundwire ports mask

 sound/soc/codecs/wcd937x-sdw.c | 4 ++--
 sound/soc/codecs/wcd938x-sdw.c | 4 ++--
 sound/soc/codecs/wcd939x-sdw.c | 4 ++--
 sound/soc/codecs/wsa881x.c     | 2 +-
 sound/soc/codecs/wsa883x.c     | 2 +-
 sound/soc/codecs/wsa884x.c     | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)
---
base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
change-id: 20240726-asoc-wcd-wsa-swr-ports-genmask-868239f9682f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


