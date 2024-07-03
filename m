Return-Path: <linux-kernel+bounces-239430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBC4925FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D081F23A26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9AC173348;
	Wed,  3 Jul 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zqo7bfIY"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F545945
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008672; cv=none; b=Vrbu02/zVI/713XYXHPTeITK6+E3nQuz8w8VeK/+ae2WHytYBljQoEJj5QOAcccTbeo5YgzKSCuM4Ks4/dBSzQSZ6ukiVxSy2L9ednz50g6cl1vipIPIPiP0gl59ZgPD8xKgJQY/v/kghDc+IzK/fqiCpTZELDujGvVguH+SnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008672; c=relaxed/simple;
	bh=38E+3ou+E/LV2E8yp/WlqkpQYFuVfruI6m/kZhWQIwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=egzOAXz0Kk42uLX8LQY+3ExCHJoaTbEZrogOjOCLVAO/qUYb5CNHhXfCTitiSPFO4k7HU5vOHE89Ui+YXAUMlUYPXUVuUioR4c3/Odwkl2J7gq11WvnCGch1nnJJJEZkzVi2oOI2gCD8Rv78Y70PcLGKZHBxbZ31LkC1nF1+Ay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zqo7bfIY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso59229761fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008669; x=1720613469; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cedFw99A7YSckyMyYKT6p5GP9raiQYHtK+ru95zornE=;
        b=Zqo7bfIYuJLILF9x5nS0UevjvV1VBhMwXL34SekIopuCp1WKRIoeNfnrOdxftsOGGZ
         oau//V+2bfHUOYXJkkOM5vjNLXWOt7vb9ctXO0drpA53HwlcILo5lX6LIl1lA6kK8mjo
         DkS6joNKGmhjwnCqVTbkQUL2il7d1Ebm82ppAXmN3rhUpKDutgnHCDddQSZ0D+gcOnYb
         DqVg7hfAabx/romHtZ+39UTPYATbN76SoGvm2rmBBO769yiSv23O5FfZz2OfJ/YLafmi
         hwCDTKn9/5cQS9zScLFsvrXRdPgrDRKfMntaSS1FLEpHMKm3zhdTVzMYWE900KxKM9AZ
         4lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008669; x=1720613469;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cedFw99A7YSckyMyYKT6p5GP9raiQYHtK+ru95zornE=;
        b=Q6SqvMfuBl9OFWxKXKIFArLt1eXfmHUNtXtDUrbyV3xiC/4AzDoyA9bck2DqehX3RW
         4h+ElbucUYDoqyLSXshy5HgFLLnLO5DkcYixYyaY5CVGxLoHXpeQl+2PInsj3KtLOYm4
         1tBWYmv75l1Zjxf772jmiuUg1ZInpp1Lku9ZB9QNGm2hJ5Z5Ek2TNtCGBTf6dAOJmKdN
         DHKA09JbP2nxWt6LbmghnJaSrxriQNTV/BULkQSDWm9FBtJTURNFcAVnq9Fs7NVrl8gk
         czJiXgxXDrVV2AC5KB2jJmizhOKBqwgAkZ3HgVTJgxn86NCbOCpdT44KyxZmNXAHTye0
         U41g==
X-Forwarded-Encrypted: i=1; AJvYcCUyncGL9/gSTjAoESlZwaBaRwhVAJyZCKYq1zjTCQnkD949Jz79DJC9+9lajKKdDyyESdf01xh65kJkt93MQVait8oit0djgev4QkzS
X-Gm-Message-State: AOJu0Yy58EQIxkIFtio/NTIBVcga0s2mo4ljAYexviy8VFoun7Yd7VyP
	0TK4i2pV3JAHcmTp+cSfHSpDD1T/QZaE5NatU//uA+tRjIAeX3l71kU7PN5pFqI=
X-Google-Smtp-Source: AGHT+IEfM0+Ld6ncT+ouSLf7osIs906r0Y0FWWGPtojIiKffNhJRaOyCEHrvJZ4Lf1JkvL2wmGUvJg==
X-Received: by 2002:a2e:a7c2:0:b0:2ec:5172:dbc4 with SMTP id 38308e7fff4ca-2ee5e393c8cmr73155651fa.12.1720008669249;
        Wed, 03 Jul 2024 05:11:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/11] ASoC: Simplify code with cleanup.h
Date: Wed, 03 Jul 2024 14:10:54 +0200
Message-Id: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8/hWYC/x3MQQqAIBBA0avIrBswC6WuEi3UxhwIC6UIorsnL
 d/i/wcKZaYCo3gg08WF91TRNgJ8tGkl5KUalFS9NLJDW3aPfiObzgMjUhi8C04bpzXU6MgU+P6
 H0/y+H1dRFIhgAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=38E+3ou+E/LV2E8yp/WlqkpQYFuVfruI6m/kZhWQIwI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/R5G66T/ENazdFQQUl8BkzHTGMOaqY5guUy
 WT86/WIaeKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/0QAKCRDBN2bmhouD
 11luEACJdPtrllcn7nyU28iQn6ZABmnMGhwYKmPRCiJO9rGZe1Ua2bJ9Sa9uSvdYwL857338dsO
 rqc9dp62eIt/FJGnsUV+Q6pH9fav3duzuOv0S3efQBGskRG+4oSi0pF49z3Zr2srf52bq3o1j7w
 IYikBTMiLyvTXAKLoNmHrDOIGm7imjTUIw3+EcQH9iceHRv8cfgRflt5hZKVBxflZzivq6iSKGK
 Dymd0tsWzbYV46WL81f4Fq0nwR9q6Vi3/REU5qMPMNVJrzCZKGySs2UDYuDJw8GKJVgsv3DREWr
 ypsEU3uGoz/q9K42KSVB3DkjuEsZklahVLCjFjPHB9ImFVYZI4zAXovpT1XRtoob1PLdxnMkhvG
 LsBVtekE5MBYQ3UmQif88KWseLAE926zvHfIv7N/TjsjS09DP3cI8yx27hMmPBEOGYy9VjPiEPL
 isWmkWdzm+9gLZIFMP33igefnO/smk6xmBoY/gOsce3fHvn7loIhbTrWhHRI5rAmBkv+Dt1JWcS
 zq1nm8ZBUUIOSscNrXjiAChP/gxojbrHNYaJTBAcmvQqHuyQPMLNeLLjIBeuwvDf6jUhMv0Kwkj
 Za3LssnmMDG/fvG6+ZmvW/3KAOQ9ixu/1WK28FYb/bvYjR9MaFFuI4zlvQ7dJmACvrSzBE8oai9
 9dUOtBj+/gs/E/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling
(simpler error paths) and make the code a bit smaller.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      ASoC: codecs: audio-iio-aux: Simplify audio_iio_aux_add_dapms() with cleanup.h
      ASoC: codecs: audio-iio-aux: Simplify audio_iio_aux_probe() with cleanup.h
      ASoC: codecs: wcd9335: Simplify with cleanup.h
      ASoC: codecs: wcd934x: Simplify with cleanup.h
      ASoC: simple-card-utils: Simplify with cleanup.h
      ASoC: audio-graph-card: Use cleanup.h instead of devm_kfree()
      ASoC: audio-graph-card2: Use cleanup.h instead of devm_kfree()
      ASoC: simple-card: Use cleanup.h instead of devm_kfree()
      ASoC: ops: Simplify with cleanup.h
      ASoC: dapm: Simplify dapm_cnew_widget() with cleanup.h
      ASoC: dapm: Simplify snd_soc_dai_link_event_pre_pmu() with cleanup.h

 sound/soc/codecs/audio-iio-aux.c      | 83 ++++++++++++-----------------------
 sound/soc/codecs/wcd9335.c            | 22 ++++------
 sound/soc/codecs/wcd934x.c            | 22 ++++------
 sound/soc/generic/audio-graph-card.c  |  5 +--
 sound/soc/generic/audio-graph-card2.c |  5 +--
 sound/soc/generic/simple-card-utils.c | 13 +++---
 sound/soc/generic/simple-card.c       |  5 +--
 sound/soc/soc-dapm.c                  | 47 ++++++++------------
 sound/soc/soc-ops.c                   | 26 +++++------
 9 files changed, 87 insertions(+), 141 deletions(-)
---
base-commit: cf601827c51b0496f6bb8a1865f1bf69ebd246b7
change-id: 20240703-asoc-cleanup-h-ef9cbfb67b66

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


