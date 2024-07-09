Return-Path: <linux-kernel+bounces-246157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07A92BE56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7698E282BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA419D88B;
	Tue,  9 Jul 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEqYBGub"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C29B19D07E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538927; cv=none; b=Pf2wa77RR4CFSfsHPqSiul2ViKFz691OHjsALl6pfFCSzQqqSWrWqsIk2Sma29OFQh4tIAfbT4TGUef58hRXvuA17102lDh3kE2WhRllZVG4RGLqFzm9BEwIEvB597gTPZ5tQG1nuKx97KtmyQUcKySLQUJEwdXQ3V2WRY43K5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538927; c=relaxed/simple;
	bh=68++p0TLm5vTWyW+78bNCCU7gxHIxep9gk/S1rYIeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8QuwHRDtMz+r0kJ2n8b4jgMMf3irHxXQNuzTdcJGPYq9e9myzFXUXYBFvWGrPELuwW8nVOSl2FdEIn6kOJxwb6RHSH44QRcE11rR4jKG6mmteKaqlZ0fIm4P2YRcG2viObP3m/M0Kh4uE1JuQOO1mpa6E4BA7m1/cmKhvv95Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEqYBGub; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso37260045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720538924; x=1721143724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uvKJVDAkNfWouoiWb+1kR3F4IBUjlyoO5Q61R4r4Tw=;
        b=qEqYBGubdShLx0Pykh5mmAC4J3htyJaup7qIgGYidQZAvkO4HgOepwSbPjhAGBJ8hD
         wlmNUEp3Ziss1Ob+aa2D91N6nOjiQDKEr8WJJut1g0Pms4bAlyib9q2gnEXF5fP6qWm2
         j3SgFlpSHfxEFVJBWVIOKmRyyc5/L696WhkKHigHwssWROVJXQmUmUYTlNXByDu1nb3Z
         L1RiPH9qCJKUIHrIQuZHtrhZrOHBSOI6/3hGZftxVYzChR+HsUbX7gQBpZXGHy4e2DCs
         WmAOtpa/Tp2vd7lWUwXdvSJqUKNE8ZPN607zPzy7/V0Q8tNj/O8qeR4ZxcNC91K48NP1
         NQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538924; x=1721143724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uvKJVDAkNfWouoiWb+1kR3F4IBUjlyoO5Q61R4r4Tw=;
        b=Zm801sWhy1tUnTfJpFnnY5VvSXFmKwGDz0cT2mMH1EU8j+VFmqeKbnw+Gk4KsbiSUV
         ydGdACfUe7OgkQDzJT2u6LQ1Je4JJLrfO95LVy/eUaRD+jXersowK5qF2QDSE74YNHn+
         N8jJWXj2t9yACvqruNbqQfaTaC7bwWFeRjZaOEXIsmKf9wceejGnL48pWE9l2+qvsq3F
         fl2JbYAZZjy8NTPCqNLEWbAuAF5aa9Tb3WbAi/PoUe1eYO/H34qsv71ULKhJ9x3MrLuV
         xIWMS69zdEUiJzWktHm5yLZRiYusq3OFNtI6xCW8Sf6MYL8+palSLLOiINupNsvCKgQ3
         8XSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbkiJSll5SoLc3DVAOhh5E22RKXT6MgdxKBCBiG3fyiXGiCF88ohqO33XcJXZZ9groKnDFRKUZcGeyI1TMVfb2wXmblENBPGu7fP3o
X-Gm-Message-State: AOJu0YwX/0AOiUcvesfcnIn5K0zow3Lvgq2we2qtp+Y3Ji/VFvOnQWpn
	+mHp8NVqPcflitGSWfWB707SbHsbgb8BuKVlE2LStzdXhDuaSSDhDeZYA23cs4o=
X-Google-Smtp-Source: AGHT+IECZyuBODbUWxODlQIq2TNUEQPYhnYHr3v7tlYB31S3xcLkk0SWvj9qahKiYTMEWYdHqCwhUA==
X-Received: by 2002:a05:600c:2e04:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-426708f1f54mr17918255e9.32.1720538923729;
        Tue, 09 Jul 2024 08:28:43 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a32sm45883775e9.24.2024.07.09.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:28:43 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	alsa-devel@alsa-project.org,
	Banajit Goswami <bgoswami@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: dt-bindings: convert qcom sound bindings to yaml
Date: Tue,  9 Jul 2024 16:24:41 +0100
Message-ID: <20240709152808.155405-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
These patches convert the remaining plain text bindings for Qualcomm
sound drivers to dt schema, so device trees can be validated against
them.

Thanks,
Rayyan

Rayyan Ansari (2):
  ASoC: dt-bindings: qcom,msm8916-wcd-digital-codec: convert to dtschema
  ASoC: dt-bindings: qcom,apq8096-sndcard: use dtschema

 .../bindings/sound/qcom,apq8096.txt           | 128 ------------------
 .../sound/qcom,msm8916-wcd-digital-codec.yaml |  53 ++++++++
 .../sound/qcom,msm8916-wcd-digital.txt        |  20 ---
 .../bindings/sound/qcom,sm8250.yaml           |   1 +
 4 files changed, 54 insertions(+), 148 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital-codec.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt

-- 
2.45.2


