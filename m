Return-Path: <linux-kernel+bounces-543928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4398A4DB8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0154172E92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85CD1FF1DC;
	Tue,  4 Mar 2025 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlhqEZon"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051211FCF60
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085875; cv=none; b=i+sfAikH+WG/cCfeD4O+zFPt4UDtICVcE1NG8tS7qpgBlZ/v6HSiM+I1VEY29LMPOVtdhHeEsNab+q2avH30ISnIt0sOTg3AybhxohHKwEZ6n3H0W+KLfRXvrLkwhnP+/quSvJDYj9c8vktBcT8sPmQ9mW93CjwbuVo3luxuMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085875; c=relaxed/simple;
	bh=n2UkKVPrXqYPJwFRJJ5cSjNwsrOJN1CW2qj0tohsSrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQQSOaHAl75zCrlr4zhrlN2O8dkERrKByy+0LNUTjpOxi2Z2bZHkOJBPqQmweElFf0DN9Pih5HSfMUvIi1kV1ZxHB+j2duJg+M7XRts6PfURQjVbUpfkBPPxgvsHhWkouMxnFPfY1VWTHxx53uKZShT9UzKTdDY4cW0WJ5G6+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlhqEZon; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so7395942a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085870; x=1741690670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDU4rmBFIHbrSxk1aZkGu1FGzrjcXWe5kWg/s6z9WeE=;
        b=ZlhqEZonxpc9u+Y7JA7Zz1Z3mWFgciPJsGf6mustvAIKdwwc+baJwD+JZCa5HaAiPQ
         CLKsCWE9KHf8JgHVZ9CsAu6IbVVvDh1iB8PoVsZlXBo1dNzbjuL/2VM7QzWqXpSTTOvs
         wPFCf05GmfrKOnKRGpWA21C3Qi0uda5TRY1kid7cd/akh5iCI+vndkXW/FDdJuraK/2W
         /U6imfLO1DPF4iz5n4NsA8gNdP7YoJKY13HIvwe4Nnf+Xb/XMVWx7Jvj2pxQHwlnr1Sd
         jRfpEELSQpstFpTVi+TzWQsflkliLw9cJKvGZWWtyo5FIHGkhHyJyLM8gjAfstlsngZb
         nSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085870; x=1741690670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDU4rmBFIHbrSxk1aZkGu1FGzrjcXWe5kWg/s6z9WeE=;
        b=osw8MeOWTDSDggf7oNdHv4oqxF4tDfMCuTgs+yETSF1IJYmYAfGSvn+w1hQJc29/i9
         udQM/C1HOQw0u4K1pXYMgxGs9qA1blvtOR2YNGMK3cal7UOyT+MvltacyFcalu2GQP/x
         VlAOr7I5Y9oxHjZZqGxhuTGnJlwUMy8VdfkkkpTfzx4ZTivQ3bEZplZkxB9Tf0US5uOo
         /pnFmFqIWVSqAVlarF5MMv5yZztFi4f2059TVz4HSkfc6EVCHP0FU32FTV07uqD92G8j
         iDORr+tH2T7Q2KyhyYqjZUrgvv+KrIn29x3Q9qkx/A7vuXLKv2O2mKopk4QEgRGznmQ3
         Of+g==
X-Forwarded-Encrypted: i=1; AJvYcCXroyOYEH45st8VK9ytbuRr9MMX+YPsbquoptKihhSqwPIiDlSHnz/ITMjRQIZV1KMBzPyIQp1H4TKxYLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQoYODaHA2ODNKiH3LBy2jhfsAYf+t1EaTs49Cf+ReZJc5QsF
	jeA/huszkGTvunMI5ruSob5sj9bq6EaF1SShLtmCtmFDcF1VSU1B5RK/Rx4mRJM=
X-Gm-Gg: ASbGncvSISeiacBaz8mg8Wp6E+ig1B8sy6o+Y0rJ6+SGfFFvxWZjL3pGkoml6lIqetc
	fT0+4qAqq1z6/clAHBrIpLyKVzPfQR2IPpbo0/LGNg/sWjnUeAxYzA/76Akh2EBGc9yidLRSSE9
	Cfcikhj+ISFWV7ogziC4bCCSRerVR3kZX8g8Iq8r98TdJhJ9A9VZjVEznmjMSFutalszdGs4znn
	OFei1XbOGNJKhhRaQOUmGz+NPtlg/Dv402v0TokWvqIZFdklNUHN9hMlBcA8xymfkfAFZy+NEte
	99Gx0sUlDAWjoeOcXJkUGKPpDv4uZF/RkFavTOacOGVGIhzQzO1Ob/O8ujCHYz3vTQ3q4Q==
X-Google-Smtp-Source: AGHT+IEb0GcLCgpBn4DBHJjLz9lM9L+RwrbPgXxAPm7l8NYpXStBAnU1h8ujrhg4rzG0gewdQBsjcQ==
X-Received: by 2002:a17:906:6a25:b0:abf:5eeb:6af0 with SMTP id a640c23a62f3a-abf5eeb989emr1170917366b.18.1741085870210;
        Tue, 04 Mar 2025 02:57:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a5acdsm8002966a12.77.2025.03.04.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:57:49 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/6] ASoC: q6apm: fix under runs and fragment sizes
Date: Tue,  4 Mar 2025 10:57:17 +0000
Message-Id: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qualcomm Audioreach setup, some of the audio artifacts are seen in
both recording and playback. These patches fix issues by
1. Adjusting the fragment size that dsp can service.
2. schedule available playback buffers in time for dsp to not hit under runs 
3. remove some of the manual calculations done to get hardware pointer.

With these patches, am able to see Audio quality improvements.

Any testing would be appreciated.

thanks,
Srini

Changes since v2:
	- dropped patch which is causing regression with pluseaudio.
	- setup period sizes only for capture path
	- fix underruns/overruns in dsp pipelines.
	- add fixes tag
	- add patch to fix buffer alignment

Changes since v1:
	- added new patches to fix the fragment size, pointer
	  calculations
	- updated to schedule only available buffers.

Srinivas Kandagatla (6):
  ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
  ASoC: q6apm: add q6apm_get_hw_pointer helper
  ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
  ASoC: qdsp6: q6apm-dai: set correct period and buffer alignment.
  ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
  ASoC: qdsp6: q6apm-dai: fix playback dsp pipeline underruns

 sound/soc/qcom/qdsp6/q6apm-dai.c | 63 +++++++++++++++++---------------
 sound/soc/qcom/qdsp6/q6apm.c     | 18 ++++++++-
 sound/soc/qcom/qdsp6/q6apm.h     |  3 ++
 3 files changed, 53 insertions(+), 31 deletions(-)

-- 
2.39.5


