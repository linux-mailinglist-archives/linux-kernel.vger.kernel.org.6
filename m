Return-Path: <linux-kernel+bounces-556786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669AA5CEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B9A189DA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE8264A6B;
	Tue, 11 Mar 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPpt59Am"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4A2641E3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719743; cv=none; b=i3jUdNcNTjiUXWguHQVJDu9kY3poxFpCqi0+4mkuFg/Pwpov7A/frs7ojAYrXOP/O8W35kRiPHKLFR4G0GnNaeeId9uF2JzVkijM2WUwJdmghjR8iaVqA3VISJj9hT8D3YpPPPK/C92aDHxaHhqk6+Yc5SAThrc//0DnDw9uAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719743; c=relaxed/simple;
	bh=g6ZcIsYl2/jMWfZyQs4pXVAtZzsF1td/uQveud5buEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBas4VM7uu7yjDBmakwKha1+4OVe74r7HylQXm9YW7ReSx099p6NKR0A7RhXCL9KLH7vvM0RfZOP5ShJQF5SVe93J8N8/XlHNXZ2aia3i2qYUbixgz2kaTy4NFyuqaj3p8Zn49Uje0L+hgeOC7N8tJTF5/OzD/tu1TT5jAi/SaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vPpt59Am; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso2283755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719740; x=1742324540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YV1kRNxec3hf47euA082/GCXKE5VaU0R53exCWfzts=;
        b=vPpt59AmriaL3iVTrVFsZ5B+1Qu6B8DlUL6c5RFNazq+NDXmR0FSbQzR3iAjIbpFq2
         ZXZgBIKkC9T0MRe6R+enH+qlp852q923946S5IcPX+pvCd9vt9a5013vwH/ZW9crQtvf
         bbgd1kF8MR0TZfQC/Z0tUpYv8u+DO6MFv4koWB7wCP+Ta0duIpJ0n0V1Ue7P2U/xJAmW
         eXGYr47F93fLGP6P9gj9Nll98nIbUQc4Emi6pp5tmcAaM/Pzq5ETRUcNjsLYOATKH/Tw
         fMpCF4mDnCdbUMSUa3KiFUAksqCkoDCrcrtvOil4MYo4nrHAycY3tyOETdQMssm/r3aJ
         TjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719740; x=1742324540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YV1kRNxec3hf47euA082/GCXKE5VaU0R53exCWfzts=;
        b=m0ud+RGL4knTVRIcKgFA2o3P5kdXJ7p05gIyxH+4CkQADce5MVXZdL1/rm8s6W9NiM
         89qFcBFQ15HqmE5tklSzbhvVwTY3GtwOXvECMjZrfoh/Q+Q0RvqEhs/G9+ji5et93no+
         8lQP6OkJA6A7x3CAOzDzxxN8sl90f8aLqsLqpAttqEJzU1eWIZ/fXd0CQbbgq5Wgtc0G
         ZM9fe2h7XHy9UKetPWBfkqzKo2Pi3AUCOiQ5gfo7NufWzVXkvY7Pmpydjo3nEWQaqm56
         h/mYIYHcPhcn9RZB7FNAr3BcP9MN07emFQ0Xb46xWQkjCKfcVks3wD0Q5kXCVaKxMU4j
         2wjA==
X-Forwarded-Encrypted: i=1; AJvYcCXHDf84aCbm5lnf9xqzdw2ZW7RhZQqXk17LcB89Lh/m05+P2Saf/q4rNjGdtMS783V+oNoo6glcu0/7O7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgkxy+F7YyQtvNbeVCjNxZsEmDxjblYJ7jw4QPkMgr5ctGyJyO
	aAESy08ibQxI8Q0DkGAIP+m8KR61t8tC/mkdjba5HtothiiExEL73zdDYYvz8Ow=
X-Gm-Gg: ASbGncsXqUjMtyv6jeI+X2Jz1DOffOAUTQqsWTCAtC1acxPnEREYZOxQGxA/gMm58nj
	E9SgmIsDRPogRC+E1+n7PGReJ1QDpEZtPlJDDgOCMOhjzeV6bv6BYQS55r3O3rfaxnCadioHt1j
	yKDPTAqLHBOKL5giQOmxvZyGemPo5aGwODVZcQN0lZMLDbAP8BlTIICIarDjvhsVHYDoghlSdQX
	moCAo5YhroYWynVgATaXke0P+EfmMjbWAU90iO5CJSE5GdjFmAFmPFRXRCttFr6JGSYHDk7EkJG
	SCKHkKubotw9kjcUPAepC7VCcdeARdQTR4NKspyzyDH7JuIa2TEPrnbYYBA=
X-Google-Smtp-Source: AGHT+IHLtSZoNCwGj6vMtj2XdtM72l1RzSdPaEdfWD7UtlotpUT2vtj04hr1SeJ+G3qYudDSC8CThQ==
X-Received: by 2002:a5d:5888:0:b0:38f:25bc:ac74 with SMTP id ffacd0b85a97d-3926beebfe8mr2187185f8f.8.1741719739709;
        Tue, 11 Mar 2025 12:02:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:01:51 +0100
Subject: [PATCH v4 01/19] dt-bindings: display/msm: dsi-phy-7nm: Add SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-1-da6b3e959c76@linaro.org>
References: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
In-Reply-To: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=g6ZcIsYl2/jMWfZyQs4pXVAtZzsF1td/uQveud5buEk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0Iila38uBqZ/e++RoedX8m4tjtUuw4dYHgd89
 01aDXwNyxSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIpQAKCRDBN2bmhouD
 18SAD/9Ja9MlLoxgp84mpxJ3iNsSIk2hI0pvHpp0QQWl2u4PBQhXsbgJrqS8oFYLPUSnjWHn13V
 K6KfM5GPmBff9QqLW1/1lcrJ1a4nud/8fG4gGZW+DWxU6Fz5c9f6o2l6GnZk9Grc4gnUY4qjeju
 LuC/FeSuaASt4et6u5kPmWt/KyZMFnoiQGJfCdj03DMipKwJPYuR7zUTLkKInqTeJFXQaTH6jMV
 uug/IwDvzDS2W0AtxPlv+seBRGwwm7ej6JI6kEnRJf6GCaXeaMZ2BMfgy8vYEmyAqb42TU8kDAu
 NVzXfTSCcijHh7z/Cc1BrT5g9VBoYjYNd+XTFs5q0kbcKoUAM28dH1e3UkPz8K802KfgjiRPTLC
 VzXoMd5+eTz/bhso65kf0B5RapjiPVoMcr8ZpWTznIaqO2F/+bmISqub7iKgsDckk4GDzetDbCH
 jVuLHZfirPyym73QCfA3N1d6HPZ/PSNnilS2dsyQai/bafGJwGGr3rCk8P71bI0J/H6FFR0/4EA
 qXEZaiAMAYB0b/MDbbSlBjCxidR3ScS7oMA3dfzwfFGaBZ3HcTmc/xJWej9ys8ES/1FZH649Vyh
 DU6ujO7B4cp2d0Ec/EOKbRBGbsx6FndlNLgEHAXWveJ0MzpBx/QVso8WBeGQPxj6IK7UvJOUSyq
 yGZtjnJVyqK2yvA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DSI PHY v7.0 for Qualcomm SM8750 SoC which is quite different from
previous (SM8650) generation.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 321470435e654f1d569fc54f6a810e3f70fb168c..4ac262d3feb1293c65633f3b804b4f34c518400c 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,sm8450-dsi-phy-5nm
       - qcom,sm8550-dsi-phy-4nm
       - qcom,sm8650-dsi-phy-4nm
+      - qcom,sm8750-dsi-phy-3nm
 
   reg:
     items:

-- 
2.43.0


