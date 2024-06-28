Return-Path: <linux-kernel+bounces-233218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5091B471
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A8B1C214A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFFC14F98;
	Fri, 28 Jun 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9nHT9mg"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78BB125DB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536841; cv=none; b=TMg1so5uIyQPllvJW36L3IeDInOik7es/osL32HOzYyVo/DGSYpklIf82pGgK+qSdeZii4Rn71pO0a9WeLExqiZqtxPHLb+SOAYyEpQSFUaoqp4QojIdzgkUBmATTjwV5U/NJgexDZvzGtgBK4/p+JEG9e3buukvpjf6SGe3pK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536841; c=relaxed/simple;
	bh=oAIm3tFaJTjlkq3iPYQLO+vtIzmnKuyPQUXtqzc6Sk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uv81N//PBhZCaTf2s3mquqLNtfJZZdKi5S8EFbMGm4jDYlf41oYmxw5PZ/yzB6r1dCGR0uGiiC7Cmqes19+wS3sAHEldnUlkhsEuhqPG/+VvZNpRpNp9FNqsBCatYtBurTbYaOOcMLKYGC11HM1mpTD3lU4uVXGNsnEVcNu9oi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9nHT9mg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so522725e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536837; x=1720141637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFzRsf2vVQv0yHSYGNvzC0nZ1m6MD+db413EmZMCcX8=;
        b=a9nHT9mgmFazrfYHXy14C+e0XQfhA6/SOUh72zWkqRaFkzgX0FDFPpn3j6yfj6Emi3
         hWqXKbmmjqqi4vpc9E7ebfZ2VItCWd4YsFry14gJLWpIOsmM0LU5cH3HO56IKWOR5SnS
         4ibNgUFVoPryRKZP0jQPvsuWNpDp0oWMPJw/NGwXs5CwXC00Qm+7Y9h+IH0LKYtm85u6
         w7l4ZWgHOV+XB7knEqXMAaM3qqNzq2Pc2HUTngx70HzupbRAhHXYCjPcs/gxG8QJtdOw
         FYmvJmhKv0duiSPbHXXmyHpl1yfzDZgAGA+yLpFgIwM4Gxqh9fKjRWg1PYftD/gHFi1I
         bl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536837; x=1720141637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFzRsf2vVQv0yHSYGNvzC0nZ1m6MD+db413EmZMCcX8=;
        b=H/5qqo3A4dKF8M0Cxw//+Ertd8eJZhN7+zPS6c3y9cqP8dFW4F2odAIauOzFi41p51
         a5yPkltcZtEFXq2RBwbODByQNr81lpQY1+mzFxFCZncLpxsnBuqSABvdK7UitxejoMaQ
         1u4A3PjCCAjUrN7VaEa6HnoF/U8IKZ9LP0lJuI/ejMdcpGzzZot1w6ib6/b0y0wZeeQq
         rKT3ofpmnhhqbBsWwHQua//mlsrXZhyOjkf3EWDKtORLvHygT+1NAI8ks5G3asPUv6Re
         NCt4e4diSdkFGTRStZGLdCxiFoHbuJsrwbBAxIvAPbHk4aLOiqOQdNjl2DeJjJ0idhGn
         g6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFoKxCd0f+2EfsVme+SrpFXad6GB0Ag0wvkhaYniwGG3Bq4D7V2snptk+7JbJqDxqFk5QY2eq1W95wGMX5K2MiaD85ig2w5kEEtxuX
X-Gm-Message-State: AOJu0YyXWagXqKox6Rg/FM5I1IlqskdqL7Q6ReLKPKgs73D0MIYp8H3D
	Wk75fz4EVFXCXu5QyTGRiFN+7QRDs+hkEWIHu1fUIvJyQJwRShzfIcTaRi/3F8I=
X-Google-Smtp-Source: AGHT+IFQe1Lw9FGACcaDyps6RFYSkDsIklGWtLIOJwNRju+t5I4TqawhUBd4nyhFMIFeZxAwV8S8/g==
X-Received: by 2002:a05:600c:3399:b0:424:a5e3:8022 with SMTP id 5b1f17b1804b1-424a5e38107mr59654025e9.34.1719536837074;
        Thu, 27 Jun 2024 18:07:17 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:16 -0700 (PDT)
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
	alexey.klimov@linaro.org
Subject: [PATCH 0/7] qrb4210-rb2: add HDMI audio playback support
Date: Fri, 28 Jun 2024 02:07:08 +0100
Message-ID: <20240628010715.438471-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First time I am doing anything like this. This series adds
mising pieces here and there to allow addition of sensible
sound card in qrb4210-rb2.dts and enable HDMI audio playback there.

It is planned in future to add support for other outputs and capture --
analog audio support.

The series depends on Srini's sm4250 lpi pinctrl driver:
c2e5a25e8d88 (pinctrl: qcom: Introduce SM4250 LPI pinctrl driver, 2024-06-22)
2ffa7a354662 (dt-bindings: pinctrl: qcom: Add SM4250 pinctrl, 2024-06-22)
As far as I understood it was already accepted and will go through pinctrl tree.

Alexey Klimov (7):
  ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
  ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
  ASoC: qcom: sm8250: add handling of secondary MI2S clock
  arm64: dts: qcom: sm6115: add apr, its services and simple sound node
  arm64: dts: qcom: sm6115: add LPASS LPI pin controller
  arm64: dts: qcom: sm6115: add description of lpi_i2s2 pins
  arm64: dts: qcom: qrb4210-rb2: add HDMI audio playback support

 .../bindings/sound/qcom,sm8250.yaml           |   1 +
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      |  73 ++++++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 112 ++++++++++++++++++
 sound/soc/qcom/sm8250.c                       |  19 +++
 4 files changed, 205 insertions(+)

-- 
2.45.2


