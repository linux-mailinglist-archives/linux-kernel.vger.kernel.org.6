Return-Path: <linux-kernel+bounces-253639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6C93242D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8740E1C21B30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736961990B3;
	Tue, 16 Jul 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEh201L/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67213A416
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126110; cv=none; b=LWuUm7Ys+1ZzKt4oMQE2/UJBf/nazrfBdZ+5iOFIqSTsgZfzLO6OuMqXFTrpN2O22JPEhK2Jepv+5IznYkLK3NQPbGjUypL0n/H/yfkKsimmrFbfpFUOTef3ybWjevbI0zl5sZHShxUW3cHJFs6dzpoYwjd8Tm1BfcQHHf6TLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126110; c=relaxed/simple;
	bh=0RlLSBg30Vm+mIiZ0RTDcL/42i5dtT/cSe8Rl1Ak+8c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qrF4tk3FxO3k6+ab/N1RapCK6BI1ngnXYZ0GYNZoxvC64FI2EumJpM4RT5pWOQYyRROAjEZ4dCDliQY9uBIT0HZDaI0B1x5MIHG1penpowWCPM6UDN+bAt70mgu9N8e5aqRQ6btAdosbbao1fWpUiy0yIWgX/2Clg76UO9qyTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yEh201L/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so9477425a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721126107; x=1721730907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwYkAPFHix7dQA5aWhBcaAYHxYwK3kTLg39RbIxoKhU=;
        b=yEh201L/VQDubR0/axAcQeMVc62uA93U+qEYet4AMtyNWZpfRRqS1u/1wYlgbeNQKO
         auTP5i5S7+3hEK8LCtoOwh9zxMjlkyVTJpBTeer0SgEXPcRr+7kFDL465qTIVhJF0Xpg
         Er4jTGXH285Ea4Ml0EjE2+I9aO/wvaF6z91vN5mbGdpaxsqx7X7EjLUxqLDPneJLET4z
         pFt+1+6Q9rr9pDMJHExTF2c8SRVitXesCjW90KPEZpZzFLmM0tfOoimze5Fg5Nlr6W4J
         yiDcI2krJkeJ21lw+vVO7eR7WcpE33QggvwzI1QMRaUDtgY3fonHbG7WEoTXOgLhQbLu
         Sc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721126107; x=1721730907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwYkAPFHix7dQA5aWhBcaAYHxYwK3kTLg39RbIxoKhU=;
        b=b1iy+fkK5e+7ehZR37/WyBVKgnhPx/hxoAYnmY4lPD+V3EJqDNPB4Xz2ytFstnVDV5
         YB4rRiyGEzyQ8F6aTbKlgUW1iQaz6k7Mtl5OoosH3XRfXWEROQXvwly/6i+e2Z890YFl
         HFnrISAkqgPcgKkX6Km4ecAYFo+YNtuh76DANSuFPJaNOY5LG1GlLXanMwfjVBzm3uvf
         fJ9aaA+EUDWAfXZgYst96dOrcSpLyb0wc1O3sM7dkbFfSYwOvcUTUwfeAsPN4R3LfayN
         DR9DyOsIG0W0BYIqS+KGXjBvP13EFjGdZAjplTlzkPSPWKBmASHwVc/6oIj+7utcviE3
         /zVg==
X-Forwarded-Encrypted: i=1; AJvYcCWy2Fm1xAj6hodZFFVcDNXgPyasRZQqvOrd9PLErtU3R/nkVi8du5az0pwCLoVbtpYcb+dB7xhI3dFLdtZPl9p7R2u7s7Qy9G+dUNH5
X-Gm-Message-State: AOJu0YwZNdOs3fvIyIT6U6J8aCLTIu9IaMmzCqbzAp3iAi5EzWt4BjEn
	tFYJ1gDjco0xxbNAMIKj8EsglI6SmoKVH6dM62++FA8fGD1Lp3tKAuXtRMV6buY=
X-Google-Smtp-Source: AGHT+IF1JyhuI9G1kqnQGRCyhm30pK4ip+7a84ElO1fRpsC8Tt1pfwEgM+lIBrWPsTnU1qUI4RbeJQ==
X-Received: by 2002:a17:906:4751:b0:a77:afd5:62aa with SMTP id a640c23a62f3a-a79edcf5be9mr131066266b.23.1721126106569;
        Tue, 16 Jul 2024 03:35:06 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7eb4sm294039766b.60.2024.07.16.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:35:06 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] More X1E bits
Date: Tue, 16 Jul 2024 12:35:02 +0200
Message-Id: <20240716-topic-h_bits-v1-0-f6c5d3ff982c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZMlmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0Mz3ZL8gsxk3Yz4pMySYt3UNIskM0MTC9Mk0zQloJaCotS0zAqwcdG
 xtbUAxGrrnl4AAAA=
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721126104; l=498;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0RlLSBg30Vm+mIiZ0RTDcL/42i5dtT/cSe8Rl1Ak+8c=;
 b=K7XpIyf8a20W3H0qgkN86isLatVnNsxCeZhQgdxBgdam4kZd4+Sa/b3FQFSpXyzgvWb+u4WGk
 xtG0g8XkmpiAZL0kx/LtEhJ05tO7DSy3z5ZRLvzqhymJWfJAA+bC+Nq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      arm64: dts: qcom: x1e80100: Fix Adreno SMMU global interrupt
      arm64: dts: qcom: x1e80100: Update C4/C5 residency/exit numbers

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 4f40be61af99a67d5580c1448acd9b74c0376389
change-id: 20240716-topic-h_bits-ef8b61485b5f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


