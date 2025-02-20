Return-Path: <linux-kernel+bounces-524223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971EBA3E0CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5698517CC78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AD1FECD0;
	Thu, 20 Feb 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYgSBQeO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801C1C3BE0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068964; cv=none; b=hdZABuVwR0PYdcAU6nxqCcTnynn4a843HnbVAR0nFjf1uPxdODzDVSMOHYuNmDWFJqmnnxhqlf/jt3BA+G1nBFq6VD3jA5zS1+EIXmq4XGWs7ZStRHktmumKvVRKMFrXnB4H1GjbSdMCWTY/40oNDu8P6ZIRKan74ldYTxPMCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068964; c=relaxed/simple;
	bh=zT+KI4WcFHKjsYVAFKapOCUJXXn7d1Fjj9NRnfss8wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+i/O74lcdlI6kKiJvd1aQSyh0SXiyjBMUJbnYIKNAkLLBPI75gO8APjQuHNwZESjiV82Oxj0KGM0yEvZXT7Gnx3oTirnkYSvQvNtE2QcGChqyvyLXAPo5i9Hw6PF/Oa1UsTHlUKlQBEpvR8dmz9MUgbmfxrnRYzUsDE7AlI6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zYgSBQeO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f3ac22948so621361f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068961; x=1740673761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZKdzzhd6qiS30Fu8KqeF6do85NZpqdplWUIHWAq4YQ=;
        b=zYgSBQeOD6kC4CdHqhSobbv1M5PMIUhV+M9EKLzOmuXAoBegv4nu5B0VvVxrATsY+W
         mT8gU8d85ZdthO+gjJwk4SmmVMBJAENznnbNQzvolCNtdvn3UkEKrbJQr5Q4Ao4yuFGC
         neJUAJBbBTAegOlHDU5wI9HGKEyILUMg024Pr+mxj7M8QFhjIiKpsnERKhg5oEp4b+m1
         fQxONc9Cjzbl3O6PYelav18u31lqFmYTg5qV/7G/ectE3B5SPUr9K8vap5WM2l7ldLnR
         R9MQQiUeX+RmY4vfUdKlBlWdh0fhRnzuqYu7Ao5SyNOBGERgI/MmljBza6DokiTy4G8V
         SV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068961; x=1740673761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZKdzzhd6qiS30Fu8KqeF6do85NZpqdplWUIHWAq4YQ=;
        b=ISbF9JG9fxPF8zs/NMmKRhpFsidq0UW2032VOXG1bFUmBH/WCf+Wf6Tzty5f0s83w8
         6NfVefyzEYIhvA/fJBCwOcpAH9ImlbG64aUfG8IxrS9I7Zbb3lEyqmQz+04ApINvRHKG
         tMv+BlzJhD+MIGg9KztOd9aT4hjM/MQ7GBHxIc/mQBr4Qam0AD6SOxsMgzKqaFd1nh0V
         UJPj1j7iQjAn+VIpYQf3ucGCwzhN9JXPmuFIV1jN4RkmMh789AfwjEVRmu6fBqtXFNfW
         /JVVHqd4Ol83MA8BPxmLHsA8svQMZcGNcDhNtv1JNbpV92DZBR661OlQtIaEdivl2RDt
         XUvA==
X-Forwarded-Encrypted: i=1; AJvYcCXjXXATFKpZ+/mTgEeed7gd2t6BOjYlm9UYfDTb2+uI39GlY7m1GoFWecIXYamNXBbGEELCm0Y0FX6j5Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4DansJpDyDl6gQmamyht+nzDmAH8L17Y6tf+AxxeJ8L8QjKa
	6oYDMFxSt6ogmp+nUwfvOWJzsoNjvnYDopBzc2yKOURGYRx9A2gn03zUvCl9gfU=
X-Gm-Gg: ASbGncs0baXfi10PZvy6FmH2uuqOvHCAxGhgVe8SXm0CNXqWyvF7xlDZ+hIlQ928RQf
	tWPq772JTXNd2Ow4z1vexPJTWT2eiTKDztF8ycTsPkUjTtM/6biyml9QB3yerr4k17ralWePg5u
	PZ4vcw4GQaU0SskjWXu/s1ashi8LHNa3xzVJdGUtQKJnk2Y0oAhUU+BXQsdpJ5psyiyEmtoE5bt
	IyqTAU4oXTgGIpHo8iqRVDU0lieAyPNyjqs2/cfF9elU+h/ZxaTi6dMIcOm4pFZBWAs7Y4LYvw2
	UcFE/h3poxE4PNIBo5x3G72zsZV16JcRY85AuDYr
X-Google-Smtp-Source: AGHT+IH2gjQh7JBQ8ejAnR21ptNUN/KQFBPj5kyJgCsQVyb/b2MhEDxyhW0FhxZk7ZUcbhlqfOowSQ==
X-Received: by 2002:a5d:6402:0:b0:38f:2f0e:980c with SMTP id ffacd0b85a97d-38f33f57c13mr14497953f8f.47.1740068961049;
        Thu, 20 Feb 2025 08:29:21 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm20813753f8f.45.2025.02.20.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:29:20 -0800 (PST)
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
Subject: [PATCH v2 0/5] ASoC: q6apm: fix under runs and fragment sizes
Date: Thu, 20 Feb 2025 16:28:42 +0000
Message-Id: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
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

Changes since v1:
	- added new patches to fix the fragment size, pointer
	  calculations
	- updated to schedule only available buffers.

Srinivas Kandagatla (4):
  ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
  ASoC: q6apm: add q6apm_get_hw_pointer helper
  ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
  ASoC: qdsp6: q6apm-dai: set correct period size
  ASoC: q6apm-dai: remove redundant hw_constraints setup

 sound/soc/qcom/qdsp6/q6apm-dai.c | 94 +++++++++++++-------------------
 sound/soc/qcom/qdsp6/q6apm.c     | 18 +++++-
 sound/soc/qcom/qdsp6/q6apm.h     |  3 +
 3 files changed, 57 insertions(+), 58 deletions(-)

-- 
2.39.5


