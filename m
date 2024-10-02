Return-Path: <linux-kernel+bounces-346928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0780198CB1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ED628481A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F679454;
	Wed,  2 Oct 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA8/+rQR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9C6AA7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835622; cv=none; b=Kx/miXPvKCqpDM/mMPjsbuyo/PsUi1P4+1Fo1jFJVrIWZ7dQyaY12k/iqatC+FJG/q8a7J2q5MkAqPxa5wUS91yDrMEHbgXtFSz3I4o4PMgLAZ30sNKQ+Gd4gM9Xf9uAfdroYPEa9YvowGKu8r9i+bFzps2VQ1P9fVgdzZ+/wr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835622; c=relaxed/simple;
	bh=qDf4Q21OUR0O2CrvOwqoQ6MiuMMP4c/itFO4cayaOKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7GNX3VC1l8QoYXClLVoWg6tpjJPZmLHWAMANAavcXMIO+vLeE0Oz53/jdfyht5fCASuGoV38mUqwU5O47eptsSHdZ5k1b2hpyMl52NPLUVyinXrXq7DLj92TAYP+23Ccj7ViUdSLQ/pNkOr4r8fOe6Hzc6dQ+kelU/LpgwkdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tA8/+rQR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cd5016d98so3167963f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727835619; x=1728440419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJP6FxuMyrGQPzIx4I24nor0DhnXqA79XYYTGXwNkXg=;
        b=tA8/+rQR20kn1gBWDv8DBbSunZRM9WlFmDSTrNifY3Kk5z4/LiUXFLB1kC8+XEZ9jR
         VI50av13/0CQWbpdCebF6PLOpY5UaUPUHKLUPVdRuOMVaPN5KHqd934W5XOG59jHvXTV
         k/VetB30QeWD8lp53VIEwwOftn9RGeNqgIzXcvjMQFNXQesdbjfTXpmoehWW6Xdad7R9
         PjTyAg0N0iBKR1ABIBXDCXZFyPdg5I+m3pYUipFKekFVd3MW8EddoAnb2HveDCq4crk6
         L4dfzIXPe5aK4l3FGJqu8OOgXLv0dTu7fhOmSDbMFgqhw1/VnQvKrXt8OksqTuxKDFX0
         4PLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727835619; x=1728440419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJP6FxuMyrGQPzIx4I24nor0DhnXqA79XYYTGXwNkXg=;
        b=cBqLQgjXIpngvI5dzuMf8Ahs+fb6XY9ifjlW/sCAHVkp49CE3HMYL3tEhq/cyulaub
         GATCXrpYqG+5VzYYqp6P2fPsRjA/FrBMSD/wZalJwztPy6g59qzJj8gF1MWw8AlYKyyS
         qi5+vjz3YOlHM7wi4Qcn7NcGbfMofn3UCPi22KYnQi6wKbxhSjnQVEO4crpVv/RVk9xv
         CX69sK7TGASlaIRE+zZXz9SkvN7nRp3NAUb9hnqRR5o0RxhmcujFGHdoMa21CBePsWJB
         6tdSTWda4QBpkVKJrl+OfGOmME/byyNSHm58kLInu9WrU+zXN2nwmzHxwvK1UWUMrB5f
         Uirg==
X-Forwarded-Encrypted: i=1; AJvYcCWba+76yADScbpNOZd2Us+8ttVjXnhWSGju1zPIOiy8L0fw3802CN1lKOuvLJf7CyWs6auYPLHbbgzw+/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhUl5yjk8bvRZTwa3jhiedNYTWzaN88mHBon8PXdstjD+Kwww
	8Afonz0IX/rE6NyQZ6Tu14YNWki65MRm4S6Yj9jsfF05fJ/Jf5AuTA02SXTZWTs=
X-Google-Smtp-Source: AGHT+IFs22+u0l81gOgbkwdFzWLkYNo/t5JE/s/V9n01odUb3GkqtgMLO52O3EfAFsS1MGoPOvkYtA==
X-Received: by 2002:adf:a388:0:b0:37c:cee1:acb5 with SMTP id ffacd0b85a97d-37cfb8b18aemr868706f8f.7.1727835618798;
        Tue, 01 Oct 2024 19:20:18 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2945f2esm787518866b.117.2024.10.01.19.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 19:20:17 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com,
	alexey.klimov@linaro.org
Subject: [PATCH v2 0/7] qrb4210-rb2: add HDMI audio playback support
Date: Wed,  2 Oct 2024 03:20:08 +0100
Message-ID: <20241002022015.867031-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebased on top of -master, tested.

Changes since v1:
-- removed handling of MI2S clock in sm2450_snd_shutdown(): setting clock rate
   and disabling it causes audio delay on playback start;
-- removed empty sound { } node from sm6115.dtsi as suggested by Krzysztof;
-- moved lpi_i2s2_active pins description to qrb423310 board-specific file
   as suggested by Dmitry Baryshkov;
-- moved q6asmdai DAIs to apr soc node as suggested by Konrad Dybcio;
-- lpass_tlmm is not disabled;
-- lpass_tlmm node moved to sm4250.dtsi;
-- kept MultiMedia DAIs as is, without them the sound card driver doesn't initialise;
-- added some reviewed-by tags.

This series still keeps "qcom,qrb4210-rb2-sndcard" for sm8250 soundcard. As per
off the list discussion with Srini it was suggested to have it since in future it
may be required to add clocks, workarounds, quirks, model-specific things based on
this compatible. The same as for RB5 compatible in sm8250 snd driver.

This focuses on HDMI audio playback only hence there are no soundwire and dmic pins,
for instance. The work to enable playback via wcd+wsa8815 amplifier is in progress (it works)
and one of the routes is to merge such two patchsets together.

Link to prev series:
https://lore.kernel.org/linux-sound/20240628010715.438471-1-alexey.klimov@linaro.org/

Alexey Klimov (7):
  ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
  ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
  ASoC: qcom: sm8250: add handling of secondary MI2S clock
  arm64: dts: qcom: sm6115: add apr and its services
  arm64: dts: qcom: sm4250: add LPASS LPI pin controller
  arm64: dts: qcom: qrb4210-rb2: add description of lpi_i2s2 pins
  arm64: dts: qcom: qrb4210-rb2: add HDMI audio playback support

 .../bindings/sound/qcom,sm8250.yaml           |  1 +
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 91 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm4250.dtsi          | 16 ++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 72 +++++++++++++++
 sound/soc/qcom/sm8250.c                       |  9 ++
 5 files changed, 189 insertions(+)

-- 
2.45.2


