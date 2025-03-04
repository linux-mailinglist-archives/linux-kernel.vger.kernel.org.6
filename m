Return-Path: <linux-kernel+bounces-543935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC13BA4DB9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52BB188F384
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270F51FCFD2;
	Tue,  4 Mar 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSn31Q+6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047E1FF1A0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085891; cv=none; b=sBd+bszA9yjYTQSecmnU8Td9JDtDKeKoLc2YghKItKF2uxE1OPGDePHvqZlMz93MzefRwVIFqnGlB4jt1fZe/3zRWmn+CINhtIdD+lBYmGObNfs7vmOWTSsxTJbyzf3Sb4I7ovZc5HH90OnO+uMQnvhqjsQa7liWLVOnkmtKiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085891; c=relaxed/simple;
	bh=wOUo2jbvXNBvIELvN8SO4TO7+03wuKIRURhdIdb5KQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dPCSzlzcpdhEnssX4ljcbO28HaUC1ogRHZwka9WNhij37yDl/cn+lwkXnBmft4JyExn48hDmLFLoGCldQuv7lY5uEXtm6ROCeScrSxXVwteOOwvAAji0PlunoztW7wp6yi4+kM399SJuTL6KiJfZQIFyTKlKzwy/g/TR72nHuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kSn31Q+6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf42913e95so556494766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085887; x=1741690687; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep9QE8ZgBdpAiwKPizNUm4MFunX+10NNVd1ZFVVsV3A=;
        b=kSn31Q+6ef0s5jTJZ4ayDD2c5UcsvwL1ODfn4xzsYcIolKdhWfwe01DbJ32ifQXQA8
         INUXOeJjWjcJi4JetFRZl49bvxtC63KhLJU+KcsLHm3Yuwla9QR7U6X2Yul8kIJ2al3l
         BlJok/aCGioDF7SthBbel6mKAYT+HF2gR7VCBHypZ79eND3t7lyUII3RJAuh8KHW9/gu
         TcY7MfbBKyqmwxP8gpxtQIOcynqEoDykKKaURpsSY6LEx8doYXrUxN8CYji9QUlowG+z
         T3Nzrxg8DLgdNzLOakRWjqK5bV0bOM4g/fZRTOhFvJWdYRE9pFuNQyaplrr6A+efCF3P
         tdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085887; x=1741690687;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ep9QE8ZgBdpAiwKPizNUm4MFunX+10NNVd1ZFVVsV3A=;
        b=SdkQh10aW2hKFYLq10B93ZBVIewiO/aZwl5vyOwU+uVfNAPEOZMWOvC596drPDDNtH
         iQ2JGRQ7ZkF54zGTCjJQNs4aNHIRp1BTtMND4ITQ2QD9D3APaBL4LEUg04u2LGBl6Z7L
         t2fe5K+NhOC7IQ5Z9pvf16NYjehNA8CXksalWLieeywl2pqVle113ll6M4da3KdnwsIe
         dEO8Z1mkB8bhwCuQXOy9qRpuQANg2Q2f0gG8Svhrvbq+LKRH1bNsQQZJ80ampKGbQ90q
         9XlsHzQMiY5tktVym4NA1wvfpvDzC/skyiw4wbsao7KgaCLKGVkAhfdpLAIeEkobuLI1
         V/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV3YcKLfydgkoJwhN28t3sYjoHAdSL1z9jGt7VK5UKvy/NQgScWPNsFCjRydFsBxPOUPd1V2Y3x35E1478=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWI+V0yps5QFN6fauwdq6RjyIe4cC86h7moqwTSpJpeyvgKCkP
	BbpSAqKUpS+E+7dizVAGqv/gQJi9mlH5YPouph/6c66yzUlutLAuO7OLV1ERDqA=
X-Gm-Gg: ASbGncuoBLSLK70m9hvR8YabLY7z9YXemVFBxGZtRz01Bl4Tm4tba9wD0Z2TE1bgahE
	lUec/Ojg/mMxyEy9lw1UE557LQ+peGk2LOkBqOUfSdeYLde1RTnebaQY/Vhcvn6mPgms0xMYsJN
	cYjcpMvezmKkVoeUS9yi8Hu7HFlhOum89PUT/HnQ8EEYk4iWKlj7RgNyYV0c40Zq3Nbe95Ykgsu
	hkxY1/6kR4WvV2uHcg9xAaXNOAadriXvSUuSM8MGCtDbITvuCt2KGpm2zNtd2u9H4Baup9qwqOu
	sVnEBaK8AEo/gs0cZCgy8s9AXaag/zBzItBqCl7+yz4=
X-Google-Smtp-Source: AGHT+IFD/ObPed5O+mHCOziYcTBZaiZTKm8Gsx1JV9YxWhJV81LeOWJyKbyCJBafUbJ05F/opRYNfw==
X-Received: by 2002:a17:907:3fa6:b0:abf:65c8:70e5 with SMTP id a640c23a62f3a-abf65c8922cmr1103208366b.25.1741085886592;
        Tue, 04 Mar 2025 02:58:06 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fde3f585sm38973266b.53.2025.03.04.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:58:06 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v6 0/4] arm64: dts: qcom: x1e80100: crd/t14s: Enable Parade
 Type-C retimers
Date: Tue, 04 Mar 2025 12:57:45 +0200
Message-Id: <20250304-x1e80100-dts-crd-t14s-enable-typec-retimers-v6-0-e5a49fae4e94@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKncxmcC/53NQQ6CMBCF4auYrh0zFCvoynsYFqUdYRKkZNoQC
 OHuVo7g8n+L920qkjBF9ThtSmjmyGHMcTuflOvt2BGwz600aoNaIywF1Vgggk8RnHhIxTUCjbY
 dCNI6kQOhxB+SCKU2zrdVi/fKq/w4Cb15ObRXk7vnmIKsBz6b3/qfMxtAKGu0JSFV5N1z4NFKu
 ATpVLPv+xc/9OyM5wAAAA==
X-Change-ID: 20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-325cdb7b097d
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=wOUo2jbvXNBvIELvN8SO4TO7+03wuKIRURhdIdb5KQA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxtyxL1EL3VeoqbddYBC6vFLwLOix+x0X5djp5
 JGpP0y3olqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8bcsQAKCRAbX0TJAJUV
 VpzKEACArvNpPIzsxCH48RaWlnCRRoxSPhITR44QHeCuishnXRutzQqEFL/e1UK9/FaX4CCAjJL
 CQBkiI/1N/y2YY6Env6G1tzzsV6AdHIY5KnuAlfl9G9fcXGynUIyKYP/KYpptI2YWKBRjp9nQOk
 eCdDGdsZJNBJ95dTh9NmvTssCaImJ6PyKwlTF9Ja9ncOSkvJmYviMFac5JvYfu7rg7HMXhgjw69
 zqJfwQ2+6T9Ph0883T0kCiCtBRSJ9u87Bqql3+oF8wThmFG5HACfY0oWWqHwOKeuWICtbO2iWaC
 /PuVLsjW2afDqsMkUyz10zcsycS4HLNv7AyR+VCg7KjYrmRJNLp0+BYIYY/d0Ny4zxnSAS2wftt
 pq+MIIol4lrXzHbZByjKBhDNyBR3rfkUozMeFTTXksu6M+7QSM1CoiOpmUG94ETmf6ydsvbmn9D
 6TQRQnSx6xqvI3k9kFmceGfB1heCigy4pB7zoexM28IQ7ovI4uOgQCFN7Z1HdlJq7xLJy6cI1mG
 ucS4/p/DSMPEsc5Xs6xnxYsOXFWY/HfPkUjT4uyV23qRaYSzR7XaPAOx2ivkwLXzgU9Y0DKCX0A
 whnyGshD0sbA2UMo8lBB2wJEEWnTVfNzy35IH0v/9VFB3u+J1syoWskKMQHaf5qFQVWU8TDwwnE
 bCXsDFyeaHvlikw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Since the driver and dt-bindings have been alread merged, it has been
agreed offline that there is no point of holding on to these DT patches
even though there are some issues with plug/unplug during suspend in
both pmic-glink-altmode and ucsi-glink. These issues are being worked on
meanwhile. Merging these means that even though this will provide external DP
and USB orientation, plug/unplug during suspend will give some splats
and render both the USB orientation and DP broken. But then, other
X Elite boards already have these nodes described, so lets bring the crd
and t14s to the same level.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v6:
- Rebased on Bjorn's arm64-for-6.15 branch to fix conflicts with
  Konrad's X1E CRD DT rework.
- Picked up Konrad's and Johan's R-b and T-b tags
- Dropped the extra blank line in T14s dts and CRD dtsi i2c7 retimer
  port@2 reported by Johan
- Link to v5: https://lore.kernel.org/r/20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org

---
Abel Vesa (4):
      arm64: dts: qcom: x1e80100-crd: Describe the Parade PS8830 retimers
      arm64: dts: qcom: x1e80100-crd: Enable external DisplayPort support
      arm64: dts: qcom: x1e80100-t14s: Describe the Parade PS8830 retimers
      arm64: dts: qcom: x1e80100-t14s: Enable external DisplayPort support

 arch/arm64/boot/dts/qcom/x1-crd.dtsi               | 473 ++++++++++++++++++++-
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 320 +++++++++++++-
 2 files changed, 783 insertions(+), 10 deletions(-)
---
base-commit: f22be5c1dd3e12519e3f3b80c14d10b90be2c2fc
change-id: 20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-325cdb7b097d

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


