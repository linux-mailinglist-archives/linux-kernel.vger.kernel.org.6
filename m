Return-Path: <linux-kernel+bounces-242038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7489282FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27801F2412D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B6144D2B;
	Fri,  5 Jul 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="HuX/m0yo"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F8144D01
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165401; cv=none; b=T3FoUEUxywYXfw05+aT6cOuBGigv2bj2sUlVyD06nTfKUeeMUOiVHD3bY/G6lBcd/tarHRiCoHujDVPNQEgb6eBzOaqQCxEqNhlXEiNj7F1bnCptdInohtAoxAB+34aep9Y4UDhejlRjdQc6xLMuRBhAYkD1HaMVghhE8c/SbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165401; c=relaxed/simple;
	bh=xMRKonIgiBI78xXfSxg1vkO7UNb4VpdzvYn8LbbXScg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fv9FkesqUcqXd/MnCTAO3zhAiK0xqtvTFFa+5ipispV9gWtSYcYETFQzqCY51T6wKiafjthOC7lhpMueKpDEygArb2ixZbwrJnE0I+A0NSj0Wv2ePc1Vldrxwq+Cg6Nt5Z8ku1Iz7hO0jfRNTHAjJfDnx7mgX/4MOsP7+jNV72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=HuX/m0yo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so2261616a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1720165398; x=1720770198; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q0QP9vP7dfkRhnJhs06XzMUSeogIVDRANFYGZhnly8=;
        b=HuX/m0yowfHdvD3KXQTAhFJbOjw/DEgE7WLdQKw8aErbayrpILKN6NSg/e1r9Nl3hk
         wfHXsfcyUQg6iExYdhGUdZ6gGYtW8821Udliih9okRO6Cg6rwkY53KYwhYnEMvDPEH4R
         YVECwLPxzdzEzkM/muONsXPP1FHIwsnugQkvO2iat5F85lcjyKRS+bhS3lvrsbVbt+N5
         F1kP/m07QgVy0rl7xYdd7XIwJePf72oEphVhY/LYgJ0WMawnFmYtfRtaZyF4tJIjy9ek
         AIfJNGuaIAUVOc3sOM2pNWIfza1pexrRImP8ExqQRnYzXC+LGz3Ol2UryoUtobqR//Ft
         fBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165398; x=1720770198;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q0QP9vP7dfkRhnJhs06XzMUSeogIVDRANFYGZhnly8=;
        b=vk+OWBySHJkbd05xDY9fEoPisT2zHiwiON5fwL0+706SChms6pZq94F5ip5aaPmJ7P
         7udRQXCM40pyBU/ZwQb5D9pLTdRluE8WZvj6JURlhQVy1CGedIztN0TeSGRh6uBcs8ZP
         M8QmG3lAmwPWxMO2Q7bCP+cbS26xNFc86HN1TyiAyOlQXPnbbFivtp4kIrzZoG1UzGcH
         ZHJ7YPC34v17jUfB6z+OKuBPs3nJVgCD2Teven9J89BbVIMcUGvveaWNGKgjDAHIiMNV
         vyilg6oas0YEsVVrCGIlnq5R5utO2u8A3gzKNHZSU79QdtYmvuKZxahqJd6m7M6cU6Yh
         Opyw==
X-Forwarded-Encrypted: i=1; AJvYcCXO2FOsLymMMwCOlXuHYcK3BbZzfsQKxN/rEhL9YBFAT+rMhlGy/CE7S2ykgaABCAXwxkOEdOJNEV2kFTSQxFMv1bMl6jVbBTf/K8mo
X-Gm-Message-State: AOJu0Yx7LGQFl207cAiLozPuSUyu42VAuBf9BHVckmzbm1GmlZQO4LES
	AeX1Gh7I8966d9oNJT2eM8wjb3806oZG/kw9mlRj1RMO6i3V0Oj9OfmXqXDbSb4=
X-Google-Smtp-Source: AGHT+IEFQtKLC2KR8SHNPEDd94zyKDCx/t4ohydEafRFmL3Th2JhU9ob/EKwraM6v7NFE/PI3+olHA==
X-Received: by 2002:a17:906:f882:b0:a62:e450:b147 with SMTP id a640c23a62f3a-a77bdc1f137mr278703666b.29.1720165397555;
        Fri, 05 Jul 2024 00:43:17 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c832813csm51332866b.119.2024.07.05.00.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:43:17 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Jul 2024 09:43:11 +0200
Subject: [PATCH v2] arm64: dts: qcom: sm6350: Add missing
 qcom,non-secure-domain property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-sm6350-fastrpc-fix-v2-1-89a43166c9bb@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAA6kh2YC/32NQQ6CMBBFr0Jm7ZhOgVZdeQ/DAunUzgJKWkI0h
 LtbOYDL95L//gaZk3CGW7VB4lWyxKmAPlUwhH56MYorDFrpRllVYx5N3Sr0fV7SPKCXN1qjnL4
 05NTTQBnOiYs+oo+ucJC8xPQ5Plb62b+5lZDw6klbx2TJtnffS5pDnPg8xBG6fd+/uUjGJ7gAA
 AA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.0

By default the DSP domains are secure, add the missing
qcom,non-secure-domain property to mark them as non-secure.

Fixes: efc33c969f23 ("arm64: dts: qcom: sm6350: Add ADSP nodes")
Fixes: 8eb5287e8a42 ("arm64: dts: qcom: sm6350: Add CDSP nodes")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Fix copy-pasted secure vs non-secure mistake in commit message
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20240703-sm6350-fastrpc-fix-v1-1-9f127de17175@fairphone.com
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 46e122c4421c..8b9bff38e687 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1323,6 +1323,7 @@ fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "adsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -1582,6 +1583,7 @@ fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
 					label = "cdsp";
+					qcom,non-secure-domain;
 					#address-cells = <1>;
 					#size-cells = <0>;
 

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240703-sm6350-fastrpc-fix-760d2841d0b6

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


