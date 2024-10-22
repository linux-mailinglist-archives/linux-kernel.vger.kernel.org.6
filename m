Return-Path: <linux-kernel+bounces-375536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EB9A971D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3362228642D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12714131182;
	Tue, 22 Oct 2024 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJtI1/JE"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E628370
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567898; cv=none; b=n4c2BuCP+Mt8/62XgNNbSxIdWzB5EwEtX8CqVIFVWasbjPehE41t91gbKx0jH59GGwuAFPcF82567xEev5Iso7AOUVBGs+RJH+OJpNjeEQ8ftGWXYJrUETMtE1nlCDOOi8ruTbzrvRUAagH1N6hRWxYhcRCjiZoTwYOUyVyDEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567898; c=relaxed/simple;
	bh=E2iRMBn4vXGC8g6J44VssBZfpzZe5kCM2ZEzAfoRWN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tr7DQlgRzq+RgufJL+34g+8Z1ZcqRDWIw1SM67Wt8XqBAVpEulBcZkSM8htkh++qwB/j5nubFb5ygdFnkb08yCScAjwR/+gSl3xNrUIBrdy3/J/2L4gIzIOuYgyBSGZf5JLAAEeOewWbKAhr0lrnq93NO1rdPtR/3bPmQFKhY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PJtI1/JE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so54536555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729567895; x=1730172695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRNDAKtg23JE6+vxzUvroP0LZ1F0yJev4yH7XRh0MOs=;
        b=PJtI1/JEUj6PvPhJj1gISZqfWN02CfPaxQ0XyeAQElCM+rKsLhPrQxMOpSOYgFaFpQ
         vgOJezeiQGvBp/DJJfa4DnVxRkCQyE+OmVVay7IWjI7mRyVznvYgP3SGA1BMY2ObrMEq
         5QLEUZzbKXFOH9fS4ilVpPOV+hq9Y8TBUIALgwv8CgU97F+x1MW5zGwDoPezybMkCCsG
         Dw90FV4uaGi7WrlcM2jk55DVoX8+vKcX6F7m0GpfmM29S8yfPB3tDG3zD2WorZgfwAbY
         Eg9HTDH/yGAGsi8VQ0/3e2S54GaDxft2Uk0Y4F1coUQZzZUWHDRyObVUxgbWDGl9tXsf
         sfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567895; x=1730172695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRNDAKtg23JE6+vxzUvroP0LZ1F0yJev4yH7XRh0MOs=;
        b=sd7gnFM7moxLoFRaVodPtthJFFFBn/YPhBzFEfI3Jwp6NKHOi/xyWWIMHLBRhQ6aoH
         +pSLUw2W44nrat2OskdPBRHo+smJ98TCoLwsC6ZHF9Nl9YixqG9Ziy9vY0VcMxs8WibX
         +0o0LV/5WLXf6RJD4jJ7eD8WonPfJxwELulmYL+BB5S1PHgpa9tjUmpCpVRtZgVj27Lx
         ydglxgSTS8BraDJwt7LOSsXtt5Jm4Z6ylxiR2PGXoEAC42Pt6HTxduB8y/XniUcNXkE9
         FgNxxFuxkV9s/lenZZzCSAxmbvwpNcU5y9I9li9u30loseHsgoD6pQmlyBoOpgE/tzpw
         bZPA==
X-Forwarded-Encrypted: i=1; AJvYcCVAkwWrkwwPm/tqfz5htRkF5UUU2vjpKQtSH4zXzgQB6AWinG/JeorsFBBuL7s9GZ4lY7o7jiiDKd5ixJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+eCB0o8oYXVzs9uLR/eQZNJH5Ea+JQEjQSlUUdHKLtcR5IQe
	Rfo6W7rObgXTupgbDF5oLaaYT1r6JPv7k+DPBc6LmIKNAJyf3e7VtOxZlBJ6GPw=
X-Google-Smtp-Source: AGHT+IEu/69XGSwovBSRpqpBZi4M2aUiW0DQlzn+G8a5nHeh1xypd9CnrLif8WoStF8WP36gEFBhCg==
X-Received: by 2002:a05:600c:1907:b0:431:1512:743b with SMTP id 5b1f17b1804b1-4317cac091bmr8472035e9.21.1729567894959;
        Mon, 21 Oct 2024 20:31:34 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ea4asm4768455e9.0.2024.10.21.20.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:31:33 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	quic_pkumpatl@quicinc.com,
	a39.skl@gmail.com,
	quic_mohs@quicinc.com
Cc: linux-sound@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] wcd937x codec fixes
Date: Tue, 22 Oct 2024 04:31:29 +0100
Message-ID: <20241022033132.787416-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This sent as RFC because of the following:

- regarding the LO switch patch. I've got info about that from two persons
independently hence not sure what tags to put there and who should be
the author. Please let me know if that needs to be corrected.

- the wcd937x pdm watchdog is a problem for audio playback and needs to be
fixed. The minimal fix would be to at least increase timeout value but
it will still trigger in case of plenty of dbg messages or other
delay-generating things. Unfortunately, I can't test HPHL/R outputs hence
the patch is only for AUX. The other options would be introducing
module parameter for debugging and using HOLD_OFF bit for that or
adding Kconfig option.

Alexey Klimov (2):
  ASoC: codecs: wcd937x: add missing LO Switch control
  ASoC: codecs: wcd937x: relax the AUX PDM watchdog

 sound/soc/codecs/wcd937x.c | 12 ++++++++++--
 sound/soc/codecs/wcd937x.h |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.45.2


