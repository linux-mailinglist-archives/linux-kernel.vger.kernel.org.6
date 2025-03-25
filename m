Return-Path: <linux-kernel+bounces-575217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264DA6F469
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A723916BC31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF52566C4;
	Tue, 25 Mar 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7B8Bp4Y"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50772561AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902866; cv=none; b=rWXoYaBdClncAdx8o7rleaustMdl6x2A8cxo1B9PIXVB+ttCmSroDZ649Mgi4Qmc6FC5CMHBJ97+a6+NcL+p/5PuU1TkN5gYNrKIEPFjxzFljS0kok5ZwjABD7G5QCnP9QmS0zm8K+z5Bwbm2MWVuwWegQWMMYp2woyKDpZCjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902866; c=relaxed/simple;
	bh=DWrs30dWU6BTEKeC5Kt8Uyh7muJJJmVcZ9+Wyy6BDJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKVfv9cA+bgTqXBlRh/2l6byjZQfeXxob2PfLSjO7PzmTgXQiSiClTiwfTwSwWGRhHlLRcNKCA7P9lIpT0A5VhnBgfHNcSwkGIcvrfFNcEgzUByt/7M01yv1qW4Ju4kvHu3N6TLaBY7HeGWoOuMd4qFB4ldTlimtNMj3klZUt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7B8Bp4Y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso50363995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902863; x=1743507663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9gGesvxkXaJrbpdejngTaAxuRUgs7M320w5yoDSB0s=;
        b=a7B8Bp4YPs2/M9crzh+htAIvrEnzWPCdDyNmMcqmukTWWEzDlzxpRj9Pf5/9fnpNfr
         oeknhx4Mz9hMkg0UJCv9MfCkeyocnQEH2fuKccl3n7+Vr5/fZtzxvzv1sEUVzXOVqDYN
         4suGogs/yO15rmO2/n520lD15My5KANzVdVtgnFI3U80RyAG0yLLrijmTC6ovknSFeiY
         7y5h9WCQHqST4grUu0Y8NybYJveI2FJ4rQr3hEA2q+m8FOjkRVcCqZxkHKkpFE8E0jNJ
         q+2nzzF1pMBH4k+6cjwUYoRiZYHeetovb95Q0vYDG2ulJX6MMUdLnY2QJVdaT82T22lp
         sYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902863; x=1743507663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9gGesvxkXaJrbpdejngTaAxuRUgs7M320w5yoDSB0s=;
        b=Z4PMhQ+r9TDW2nCN9d1tkIKsR9gvhnWgHJ7H5Mil8umjr8Y33Uky34WMf4192TCIUA
         KiTV0w9m8lMmHNDePI49u6hIllcB3Mq36GTaFrfQKNPrpS5tH/Xxr1lA0yJPDnqJc+du
         QqTJ3vjO0d5RWHCuoR8tvTCDzhFxTBqObTOZNVWjHZqcWlvsSO1iaKV3eY1hPXl8yPMy
         5dAdhNSCFcp5dOt7fQEH30bKjrlDv5z+88GAHVfkkJjMpASe+ehPATrClR7HXM+cHfbQ
         GhwPwqHPnPjXP053xIelSqELIf3sms12I3NIHmCNi7W4+yXGyYMfxeRgeIiEVKi0aoEe
         cndA==
X-Forwarded-Encrypted: i=1; AJvYcCV0YPhMOId01Vsf6dtri+UdYilqJbxHEIQWILq+IZGSUCg6vzGdo6I7yZeBhpiCjYCcGoYZn78ccgOZiRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrk8VRDVxGcYloYpCNvTGn4J4+lqkziyIMZdVQJ6DdqLyWgxKs
	NCiXt6iKAgY384sDjVyC4tyivm67zLOo/4ybNm8sNWhZUVommN5XNfT3vik/OS4=
X-Gm-Gg: ASbGnct/+xVwipxmlLde/pqt+JYLQuIbR/jBPv3c3ho+/x1mUvUvUZiS7zMN/6rcfUV
	wLDIqXM3IaW3qFm1XpM5QKJq3V1y3ShiEaVRU5HilLMFrmp0yW8Vw6k/tsqTsaqVP2GFoUaZf5U
	7HldXv0mhd7fvgnhe55kPbZkpskL4tG8FUJF4wX1fu6sTm/1wN18JN2UsAhqumNNJRxDmXYnMVj
	rKt5Md09HVaZjZnhgYwVlDK6A/44WAy4f9u+9ibc7ksGpFNdAVBZT05tyzyu4lGkKGyV/vN7+6+
	d+JssuBrgXFxAGrar7ue2iQxXsICs7mQ+dC9d2+YfDs64eBQV4GiyZc+Rl/pxdjsq4lFAw==
X-Google-Smtp-Source: AGHT+IEvlt2SB/BWSd7IHVRcLyRr9LxNATE4wtiptj0pMzXSD4oiYGVGqTIPQ4Cf2L8g8oNx3bNKiw==
X-Received: by 2002:a05:6000:18ab:b0:39a:c6c4:f877 with SMTP id ffacd0b85a97d-39ac6c4fad7mr3875334f8f.20.1742902863180;
        Tue, 25 Mar 2025 04:41:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13213330f8f.29.2025.03.25.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:41:02 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/6] ASoC: wcd938x: enable t14s audio headset
Date: Tue, 25 Mar 2025 11:40:52 +0000
Message-Id: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Lenovo ThinkPad T14s, the headset is connected via a HiFi Switch to
support CTIA and OMTP headsets. This switch is used to minimise pop and
click during headset type switching.

This patchset adds required bindings and changes to codec and dts to   
enable the regulator required to power this switch along with wiring up
gpio that control the headset switching.

Without this patchset, there will be lots of noise on headset and mic
will not we functional.

Changes since v4:
	- do not rely on as-is idle mux state, exclusively get mux

Changes since v3:
	- rearranged mux deselct to do better error handling.
	- reused mux_state for gpios as well.
	- removed tested by on bindings

Changes since v2:
	- udpated bindings as suggested by Rob and Krzysztof
	- cleaned up swap_gnd_mic callback
	- updated mux gpio to use dev_err_probe.
	- added Tested-by and reviewed-by tags 

Changes since v1:
	- moved to using mux-controls.
	- fixed typo in regulator naming.


Srinivas Kandagatla (6):
  dt-bindings: mux: add optional regulator binding to gpio mux
  mux: gpio: add optional regulator support
  ASoC: codecs: wcd-mbhc: cleanup swap_gnd_mic api
  ASoC: dt-bindings: wcd93xx: add bindings for audio mux controlling hp
  ASoC: codecs: wcd938x: add mux control support for hp audio mux
  arm64: dts: qcom: x1e78100-t14s: Enable audio headset support

 .../devicetree/bindings/mux/gpio-mux.yaml     |  4 ++
 .../bindings/sound/qcom,wcd938x.yaml          |  6 +++
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 25 +++++++++
 drivers/mux/gpio.c                            |  5 ++
 sound/soc/codecs/Kconfig                      |  1 +
 sound/soc/codecs/wcd-mbhc-v2.c                |  2 +-
 sound/soc/codecs/wcd-mbhc-v2.h                |  2 +-
 sound/soc/codecs/wcd937x.c                    |  2 +-
 sound/soc/codecs/wcd938x.c                    | 52 ++++++++++++++-----
 sound/soc/codecs/wcd939x.c                    |  2 +-
 10 files changed, 84 insertions(+), 17 deletions(-)

-- 
2.39.5


