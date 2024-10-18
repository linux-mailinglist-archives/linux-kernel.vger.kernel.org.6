Return-Path: <linux-kernel+bounces-370866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEA9A330E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2501F23CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A6156C6C;
	Fri, 18 Oct 2024 02:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Akjjmvre"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661832BAEF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220099; cv=none; b=p2svdwIIvfRKS1Z+Eokhk+TqvsWj401HJH0KVD6C33ulibSKbNswX/PPyvLP/BP2FgCaUxgpCVB5gPe8w053dlmAbyuemv2of0lqo2Chl1Jel5+iUgt0qbUwXI06T4HXyTe3CdXmfoMn1bqPczXUev3LovzAKQG5NcfBLfRpsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220099; c=relaxed/simple;
	bh=n8QGjegVRsMuoxCZEGmylSDsnFJMTMH0NrzMsCUnIP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrWMz2bumDsdFs/GzIkihjd6EKr2QGLILmw/DAV/En7v8z51QWKINHhZYPnV8JDknWYG/fVHmh4UcZqNei4fTpj0R1CLknU2NcqQxJOcEsjlrOjy5qs4L2wc2AaO4/TS635JkkJQmQ6gZLdq1l2dt+GtA8NMaYdCOP7kOt0wWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Akjjmvre; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1037189f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729220095; x=1729824895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1LotCQ1z2NEQ+5bFgi6Zyo58U+aBsfVFC+loNQpeww=;
        b=AkjjmvrecQsT56YU1yLV8GKgWDxe505X6mqTnJ+oG718KI7/zeDGxnlLdVTNQbX/DA
         Ev1MatfPgG12MK6nWptbB11ASHF2RVejEg4uf3vTF9nI7gy6/BpBNY2g4yG+q2slZWBa
         /8IuJMQGtSzrWD0ijqTT6GjpQE0p9/jWV7GG63XobRCGt2e4G3oaPWd70GfiKTBdujQy
         oOWxgVbaSEod+obkODUqd15dN8Es8uG9uCtay46+PLwxXF8fa5SsmffWRK/YAq3i2s/Z
         cjh8rDdaHdlFihUzscQP+z4g4P/W4P2f7PiWAnic7PLFmhvlT6FrH+lEXBuF2WTScpNb
         hedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220095; x=1729824895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1LotCQ1z2NEQ+5bFgi6Zyo58U+aBsfVFC+loNQpeww=;
        b=dxaAmTKRMuVuL32O2efu3KEr9VnLVghgBXgvaVOCMdbzeoushHyYFAdMdr2bvkO7GJ
         kpgqvMe6ltIC1Vik+YJFUvMLMNzToiWFvOhCAIE1MTWohnqK8h0e+lXAvjZf6+MvyIxw
         jp2eKRdvI+86VxjTiOWxGlgDUbUZZm8tbokGXwz1fpAogmVv2OPfN+BRgnu/4lF8VZ5b
         lqEsgZ3InKq3D3c+Cj0lyF91Eso8szSoARBLkRnn9zQy4gBi+N0GRM/eKObUnudLivpw
         GZ4swTOoHnG9Z1bJbd62FkX6fNiSCaaxjQQfz9476XZvenfAZCJ15wwwiSpWd7zqNpr6
         Z7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWtRWckinPVyH76UqB+/e5jQT/XYt6pbt8qp9KDixiTk8gb4mplKWDx67zN2PAPN8vXlXI4/mckhyW/4Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJSu9aSAsf8K29UqWmMy7SGTmXZHsPyf1/rRugBBPk6p4kC0f
	QxLWLL8wonGn38HpYGjAPslOAXY1k0if8R3H2RF7sZJWL7MnKWY9pEzY6FiLmhU=
X-Google-Smtp-Source: AGHT+IE08/qDHlnXCkBlFCtCmUwhii5YW2Lnw4NJgvIvWxqfM+3ed/YHb9Vb6kd1W+z23dzqqegv2g==
X-Received: by 2002:a05:6000:cc7:b0:37d:498a:a233 with SMTP id ffacd0b85a97d-37eab4ed47bmr463560f8f.43.1729220094695;
        Thu, 17 Oct 2024 19:54:54 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed599sm596135f8f.69.2024.10.17.19.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:54:53 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com
Subject: [PATCH v3 0/5] rb4210-rb2: add HDMI audio playback support
Date: Fri, 18 Oct 2024 03:54:46 +0100
Message-ID: <20241018025452.1362293-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebased on top of -next, re-tested.

Changes since v2:
-- added tags, updated commit messages, added Cc;
-- updated LT9611 -> LT9611UXC comment in qrb4210-rb2.dts;
-- updated addresses in DT to 8 hex digits as requested by Dmitry;
-- added lpass pinctrl to sm6115.dtsi as suggested by Dmitry;
-- added lpass pinctrl override and pins description to sm4250.dtsi,
pins are the property of sm4250;
-- verified with make dtbs_check as suggested by Krzysztof and Rob's bot.
-- dropped two patches (they seem to be merged):
[PATCH v2 1/7] ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
[PATCH v2 2/7] ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
-- stopped Cc-ing out-of-date emails;

URL to previous series:
https://lore.kernel.org/linux-sound/20241002022015.867031-1-alexey.klimov@linaro.org/

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

Alexey Klimov (5):
  ASoC: qcom: sm8250: add handling of secondary MI2S clock
  arm64: dts: qcom: sm6115: add apr and its services
  arm64: dts: qcom: sm6115: add LPASS LPI pin controller
  arm64: dts: qcom: sm4250: add LPASS LPI pin controller
  arm64: dts: qcom: qrb4210-rb2: add HDMI audio playback support

 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 55 +++++++++++++++
 arch/arm64/boot/dts/qcom/sm4250.dtsi     | 39 +++++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi     | 87 ++++++++++++++++++++++++
 sound/soc/qcom/sm8250.c                  |  8 +++
 4 files changed, 189 insertions(+)

-- 
2.45.2


