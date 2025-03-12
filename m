Return-Path: <linux-kernel+bounces-557729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DDDA5DCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819BC3A7300
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0C1243399;
	Wed, 12 Mar 2025 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIIRAKbp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC21F949
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783499; cv=none; b=Fx56KwSG19CMCGgq3nC9FPFfuZ3hRFCtvbwY4PAUSp6uXG6XKmU8udXtQ0iMahj7KLl/HU/AsMUOjE3qvhq7LicoXX0IHwJ1rRPW3jCzqGnsmSUaf2wSMdkiM/sUEs0oLzRpQAKA+zIxsCpjRgqS0cXjIceEHPTmy+LNro4DXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783499; c=relaxed/simple;
	bh=dugoWPwMQFye1tjbr5v6MqYrHgK2V18Or3EmpGw88M8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XUDol8QujOgdQjxgZJ+SCUn1+FMXgmZ8faDCtWbnXyl99vktJsRVeY7uBLP/JJNRDOwNVzVHYQSw8QHwYAw94WyNaQ/kIR5wm3AOO2HLVvvl+S9F9JFmjKhaVMBaukcvA90QwT6AudTOMxyHKJN0l66rvh28dsvjPwL1Z3nEQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIIRAKbp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac250d158a8so95639466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741783496; x=1742388296; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqxvnfXkMdskA9Oi1IEowXOJ/kfq6q8SsVkxfIwpyH8=;
        b=WIIRAKbpJNUUdiPj+YwEOCrko4lmBc5+sv7WruxX4q+UQcbXZcNzfkwCoj/lv4dPjU
         arq+vrpfGgYB149JU9IFU3/1DDUht8u4qSTUpAXvdqedyxT2GXW7gsyz3eT4W6Qkpizd
         GqOmN10vBezh6QNek3UoOaNsuzt1ahn0vMshG7KnJ/w9gWOa6QEQgKLQwCYJ+EfPVTQ1
         32LA66qqyMcx1PYjrnsaRtRZhi8FVocJslZEUKUuexclxf8/M+ogtnJ6tNFw/w0LxX0d
         C73uOjNvKgUWjBRBeg3w27Ce0/F+V7Ch/qp7kWGmcvM7yxXzz8LczEhr+3EJicow4Ops
         H+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783496; x=1742388296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqxvnfXkMdskA9Oi1IEowXOJ/kfq6q8SsVkxfIwpyH8=;
        b=pUp1APYn7kV8T9r5UIJg7jVx3/KrconGKHQN4LwO/XFbhs2C41XdRoUkUER8kEvke+
         YHpujt3BbuttC5SyB6h2AUuPkbuMC7LA0fndQogslJkC7mMb3EN4y9v+ApHwYOupwQJR
         GlZ1ycc2RL82GuvfTVpJIfkBEnvmM0VQA/j7l0PPtSgeaMeR4I7HoVOUOr0dP5LzW0kX
         sZIbiUlVsOrSHQAEVgQArXvWwKKhMpGI1VRrHtB9QfSEDEh8oqnouA1J1Wxhb7bT19b1
         bw0yZvfseWX9fwcjgSAAQhRc4I4rfJ2pcYYsluouJ5/epZlRLn9+GIRF6R0VdOvjy/ZS
         fZlA==
X-Forwarded-Encrypted: i=1; AJvYcCWod385+sxMioSiT1uOeJbHmYKsukvzm7DFCqwBCkaGhFfl01W9g5IhzurTG0A4n4Po443rzRmB6NmWPDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBg8b/vTkaCy9siB0OaZs1Z8e3K+YubkVCCgxxXiw0XLF9SyaO
	fkev9csNOqjecnE7hExxQ2TQDhzWMZvf6+uUrS7pFJjacuMz3X4J7qeLsZP5KUE=
X-Gm-Gg: ASbGnctvHgHKz7vP4LxJnVQcenuya7P9AsSztlWRu2fdRbAP7mdcm8y0ew6DSPZPcL4
	Dq1FgfTgk8Z9rgkjRKvm8gs+8hkabTWHUuKa+O5VoKrkWKPwMF5LGjP3dUYKbvaBRNBWrYym6ng
	SD5Fs6i/hLmY6JxhlARKWFhsnnaKhD9XMsBlkLd7EYFS2MOYBdZUICRXmlCYjDDx5/bW8ladGjC
	pnz5Q7V64xN+xngXo3DxWyguTYt75Vexm7xRgRjYITtsqzqa4Rg3KEqkpn8nrFDzRniHFi9BOzg
	zDOXWRzPklNJZ5ZYfNPyHvoZ8DST76mfaKXBqjBZ5jek3Vat4S6g1WpYfbI=
X-Google-Smtp-Source: AGHT+IG5yUVd6tBYIwxswRaXrHfjpfduiNh6bBkk43blqNSYrSYHDkMmjzb7Mk3TniW6hr1HNfB3Gg==
X-Received: by 2002:a17:907:3e0a:b0:ac0:b71e:44e7 with SMTP id a640c23a62f3a-ac2b9ee628fmr344602366b.12.1741783495826;
        Wed, 12 Mar 2025 05:44:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm628955866b.125.2025.03.12.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:44:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/4] arm64: dts: qcom: sm8750: Initial audio support
 (not yet complete)
Date: Wed, 12 Mar 2025 13:44:44 +0100
Message-Id: <20250312-sm8750-audio-v3-0-40fbb3e53f95@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALyB0WcC/12OywrCMBQFf6VkbSSvJurK/xAXaXrTXtCmJBqU0
 n83rbioyzkww5lIgoiQyKmaSISMCcNQQO4q4no7dECxLUwEE4ozIWi6H0zNqH22GGgrwfhGG22
 4JkUZI3h8rbnLtXCP6RHie61nvqzfEGd8G8qcMmoks+C40ao+nm842Bj2IXZkKWXxs+vygv3Zo
 ti+AaGkU9Y7ubHnef4AvMSQ6+cAAAA=
X-Change-ID: 20241022-sm8750-audio-d3e7fb676716
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dugoWPwMQFye1tjbr5v6MqYrHgK2V18Or3EmpGw88M8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0YG/HNTDqNjYkTljJ4c91te3ZeogYOBeHXHrl
 cPvOHx5VUCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9GBvwAKCRDBN2bmhouD
 1xpgD/4voMn5T5AJDOokmvSKHK4yTYc9rQLTNFgLpluYFPyul5FpQoJq1+/QLDDcXnDn4zFhfun
 yzCFrzuFKm08TzDZjDb/ayRQ504stxGN1SdOBX3FTD1I/aeXAVKVXKB66MWjaZkQmQ80kUp5Z22
 JpCtlXEo9PK3T+0SaqyqHEoG+K/Li7OKsJB2vlzC4/tsFPcucDrmXF2SLM/Fu1RgvnIG4XQkHWU
 bn24ZO2CyDtYYh6SmHIuBHvZsjR4e2mBCTNnt2RlCARa5KV7FX62EwOWhNubyqJglQc7dYCeo2J
 O1DRRGLp9iviEFzieU2lHEgDfYT7wgAyjllhM6uca/LIhwIOFORAt/tKvx71cf3IsdEEAWuRkEW
 ZfzrJZTZrKd/VpBttbIhuBQutM2NZthFMhB4t5w0/Mw4396FE4lbelJZC9Z7Za/VMPJDaVJvPf0
 MqOiAdBwNrdOleXLrS6Fv3VUwnlQwwTW/4qmL8ipumgGLYD5JYZPp5ze4wr9OZq0G9OElSbyJag
 H3tgIGuVahYjMtDtMys/z1XsAje4+tuCMUbl5klizU6ixM8wnvMs/4XiU2FlGvK3oW5tyjekJI+
 zSlaQ2k8hW3lkAEsAunhjVoUEHprkpkpMzqTZNkYMEjG4dv6ygtpw0Kn3BRBVUKhrAZLIgaB/1l
 u3SjRaLzJG9Bxhg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v3:
- Add Rb tags
- Correct va-macro region size (0x1000->0x2000)
- Link to v2: https://lore.kernel.org/r/20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org

Changes in v2:
- Use 0x0 to match rest of sm8750
- Re-order some nodes to keep preferred order by unit address
- Add Rb tags
- Link to v1: https://lore.kernel.org/r/20241101-sm8750-audio-v1-0-730aec176459@linaro.org

No dependencies - everything merged. Bindings also merged to mainline.

Description
===========
Add necessary SoC components for sound on SM8750: ADSP and relates
blocks, LPASS pin controller and macro codecs.

This is an early release, as I don't have sound yet fully ready, but
speakers and DMICs work with these patches on my WIP branch.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      arm64: dts: qcom: sm8750: Add IPCC, SMP2P, AOSS and ADSP
      arm64: dts: qcom: sm8750: Add LPASS macro codecs and pinctrl
      arm64: dts: qcom: sm8750-mtp: Enable ADSP
      arm64: dts: qcom: sm8750-qrd: Enable ADSP

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts |   7 +
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts |   7 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 342 ++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)
---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20241022-sm8750-audio-d3e7fb676716

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


