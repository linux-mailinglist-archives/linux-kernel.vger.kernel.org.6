Return-Path: <linux-kernel+bounces-556796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DBA5CEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937F9175C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E74266B49;
	Tue, 11 Mar 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMr7q9Q8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6A2661A5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719762; cv=none; b=ouJaB9fWRMwJLBGVwFNwenLmz34Ocozb+5dHNVlaS8mueaTvJZRQwybxiVDbHYhlW0zEBqdHzf+jacU3Mo/NYBILSVCxI0UpEAbUm4ljD2hXBc/mKuu72tVrhCqCFLhxOH8CbWZWBSR99yDouqcX7pMK0YFHbCy2wY6A7WDxh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719762; c=relaxed/simple;
	bh=CNDg+XuaDwD/Q1ciROvRqy2g2qzG+QFV1Mr5Bw+PI9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovIfKnJDdDz7OBleVyVrkPf7n6YhNQ2kcA8v19/6TiYWRbPXz51FFgvjTR5TE1Px1dt9NAb9w0JrmYidPFtd6tYrPgOLXcCUpVvVRd7gHPhbuX1v6LMf5IJ3wamTUFVAxZl1GNdyC3VlOCDfN6SmmDRAOsxPVzAujnOOx/ZtAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMr7q9Q8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-391295490c8so351736f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719758; x=1742324558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1ZjEkkc+uS8mzR19kQqDcUN2sKHwaFdIpV4ZSZeJMg=;
        b=aMr7q9Q8nZBQgz0FuZmbg2Sa7jHiLx4C/N0+2la/J/stPCBIlB9X9E9fHk/TXCHMBS
         a9BE1SzHNC7lGrvLJdHBZO9qNO3ap2v3eQVrfeZ7xcXHwdkQEv0FRHb4blfbnB/h+Kkg
         5EK7H+PUs65iMfwEelD5JF2cfVbJ3Tr0Ejdv8dS5o8tzTyOuZE56fWQs3i10RKwyGTMO
         WnOWRrGRzfmqzpsZJRCN2mMI8YS6xK12D5e7pc/Y+MUxF2+FQEsgSQmvjBNxKNjh90b+
         f5z2NOTnhtA0XKiNTI8vTH/KlIlI37L4mgfke/HHoLu/9ZZabLiFUXpjGUDFYfkn1SQ6
         qaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719758; x=1742324558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1ZjEkkc+uS8mzR19kQqDcUN2sKHwaFdIpV4ZSZeJMg=;
        b=QmQJjvSTStz4cOVwDzTrlZh1AP9CBSylrSfK1PnO1Agkv4x9DvAtLHjBNBwWGMghrQ
         htj46y1Abk8pacJmvrmD/7I5pXXsAWxr6bGvTYycnnmH4RLq097wrpELGBbma+SjVWAD
         kfsH4aMDC8ejGcJ0vBdcdd+URkzdE1jhy8yc8DuT80qM5wTYvoFxYI5RGf5o+YQmIc+I
         GB6OTlFkSxWaHdKZqcQWkP9FCRUXVR+sLDk4PfHDynh/KXVirSSsuy258nwEmn23xw0U
         BtNdd0cWhcuj6K5rbnKVbfAivCUGvuxMcP2wFG/lGmsz9iqFegjtiB8cys6QlYR7N0oh
         x1MA==
X-Forwarded-Encrypted: i=1; AJvYcCVZotF9zuZ+eduEYA7MC77FblwvBCZjhxE4QF4r9ZYSeAXCA2rJB3p4kkwMzAGKy2moG6UieiJeCPBJ+mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFI/+umDoXIOv2gpgRgeXzgDkaZWJXSoYVqyVPsE0+oV6HVmXW
	/sZy9Z6PxXCXaWmga8Ro7u7ImkKlayZeoadzDVoup2mZCWOExwzK203JpaTqezw=
X-Gm-Gg: ASbGncvsX0pUEmq9df/4SBAN5FRiRB/R6LveESdcxXMRfEMPztr3kfvTFBjDTWqbYCW
	MAOquC6vYVLZepxbEhu15INHPKD0KAbcUMWaA7M0fRDqgFGuyA6YC1vm5+QSnd5h4VmgUkx0tKU
	SJzLwOswIQJ0gsKdldV2uikbQDDShz3OfiCvzR2XzMrL6SSQZmLw0Lat5AUPrp4K21O1ugqlUXq
	A+nTBFPZTiwgccBtoDMT8NyaHO5AG0na/vmBmauoyBQqY4Oza63iSOePUitLCdXmGDy4OSD7ss0
	ClIZKWeh5RClVYf3d0JlBP/BJ1c1r4vofeXwLvbC39KnXAwuJk71By4WnAs=
X-Google-Smtp-Source: AGHT+IGrs/y6SCxMBLedpcGIeqDpbssorlICFBjprBhZtsMWzI0TH3/r/UA8VCHc12GtCrUTJogXDw==
X-Received: by 2002:a05:600c:3b8a:b0:43b:c962:ad29 with SMTP id 5b1f17b1804b1-43d01bd1a8amr24880145e9.1.1741719758167;
        Tue, 11 Mar 2025 12:02:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:01:59 +0100
Subject: [PATCH v4 09/19] drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE before
 blend setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-9-da6b3e959c76@linaro.org>
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
 Rob Clark <robdclark@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CNDg+XuaDwD/Q1ciROvRqy2g2qzG+QFV1Mr5Bw+PI9c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0IiseiF5z/dH2K2cPaPmQG3OrPiBMW0tQ14La
 jZAw5WsrAOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIrAAKCRDBN2bmhouD
 1zfAD/wL6ZWVCBCSes4cUvEz+y6x08TWWYu6pFAwj1IHSlcr8xmh9/sNe1+MmFrfH41XmUXZFAj
 Ulo1yGChFQy0DpILLlHT1jwwj36H8bCeTPuCG3HFMY9TL7NT54LEBUwwVIYkoXCsz3ei312o4vS
 mixSNGTgM0gJZhj41t9prQxbjfh9dDWKqXQHkj//eN/XHN10eRnBqka0DiOmxL+MEahtzDO0p6w
 LPhyDT/WrfbT84ZkglL65Oqq/moKE8nLlZqWdZgxO/+I9z+93RRtwtplAcF0LLoa3wNNkg2pDe3
 AA8bed72dGYp8hVsrTlIBTga0IJdbG4A+Rs4YI0eyN5y49pCwFtNlR1yb7C23zGlv9rfovDEyh8
 YU+XoWIKVYw8mO7Qf4C7jsT2n6VXMWWd3Ge3kyTSuFVRez243wWArrXoKi5u8n2sq2mB1aHA7cK
 cLiu9hlcU3zn8ACaRX2iVwWpbUP3B5YXU1MQ8Mxy58KErzjkC6piogyv6vsIU9t0x6kJqBTFY3S
 GX+Rwb2+HUKj7OODP/NJ0HvG+C/YdXeb7k/y3XA9bb7ou02b4GzWfdY4Tn6FGanzRozL+O0UPNe
 3ASKZ6CN0pDGjzGCo0LLmRIU4hV9MnWP62I1jn/UoIv1EwRD4EipZ3gJV2vnjK7vIkUB/KOMcBA
 23Tz74v1Aixrahg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Before blend setup, all existing blend stages are cleared, so shall be
active fetch pipes.

Fixes: b3652e87c03c ("drm/msm/disp/dpu1: add support to program fetch active in ctl path")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
1. New patch, split from previous big DPU v12.0.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 2d7af6fff2708c12520a78cc6c979b9930dffc95..a4b0fe0d9899b32141928f0b6a16503a49b3c27a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -519,6 +519,8 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 		if (mixer[i].lm_ctl->ops.clear_all_blendstages)
 			mixer[i].lm_ctl->ops.clear_all_blendstages(
 					mixer[i].lm_ctl);
+		if (mixer[i].lm_ctl->ops.set_active_fetch_pipes)
+			mixer[i].lm_ctl->ops.set_active_fetch_pipes(mixer[i].lm_ctl, NULL);
 	}
 
 	/* initialize stage cfg */

-- 
2.43.0


