Return-Path: <linux-kernel+bounces-526006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC6A3F8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A51F4265A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ABA216607;
	Fri, 21 Feb 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2vwxtpA"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ACC215786
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151512; cv=none; b=KSNLqfMtQLlFLLGZzUv2WUcmkIbfSwOX/s/DGnRI0YEshU8EOiPxwqx2T3bwzu1GMDfe+vDeA14yZ3OU1r0woBJrZM+hVFvrzEa3sbyc+IpiCMD9h0EQFnIpwBXGyvsRshXAemjpJMI08Pk5MYHHfRHVyQ3RZtJQu32k0tIrA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151512; c=relaxed/simple;
	bh=9VwNmNeCKWvrEI0E43BuyMfe52M7P67PLdAG7OHfpN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0slrbxdqPGyR/OrDEkOWqut3vfLgxXXdfapTgRjY/0a4+gJSJtyDohfdzDDb58WDdzErpd8bEz77qvvXWeABw5QFRsoSyRD+Dw4x1dbCjUQvJxBqEUljNSeSz7A1aXMNJ8N/TCs9ybZDS90ERO3SYU0qtwHJ3e7jaClWggniKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2vwxtpA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb9c8c4e59so36350566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151508; x=1740756308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxNPRrxR3UMx3sFuHZSjQWUIyV+Refeg1tW/AVVJ31Q=;
        b=G2vwxtpAVHHXntDZVx7ivj5nyeg6wN7oc/afh2qi+ht24s4/PpfM8o9zBnV84XN3IF
         Ooq8JFRlJOhAR/OHk5FxJRYA9CHYjKZy1EmWIgKUNniZFayiONlPx0T6HNcXqSCzq4CJ
         GThhC2U9z9P2aPfobRr2LYe2kCyhRvEY/xd09lU9wD7rvqY2WxH23ffLE3LQEIvwY4J0
         qolhfZQADB9NNUpQ+90KKezzycw6+PyUB/dSgxgmVKna1uPA0ObA5stPYNSXdBSyJILQ
         QjW4Qp4zaF/Sunx6kYLYN4/8jygzfP+qqgaVYxCODNTo8ii2x28iU0LJwk5TH86xe76a
         6F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151508; x=1740756308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxNPRrxR3UMx3sFuHZSjQWUIyV+Refeg1tW/AVVJ31Q=;
        b=TSJj2/xFB2oiAwmYrc4Ilb+Y0y339qyicvwKWTa+IgLTaG6wdNYIkqnNofvPRz2ZAD
         f12NS2vB4UrSG/FF2y70YSeC5BZVtOtrP3otzm1Z0KzZHfhTDa/jIaY5kBIWkES2BOV5
         VPnpfuVQ7Ljyk8gyeLQCskKlVXPT7Ut0zFJam2+HR1DZ5xKrIxbCr4B2zeEmULxBJSlv
         aJCTA3ldYTygYDdhiaawQTSZoGQVXEIQTRPZGjn0KzffFKTXEhWC8Rax3YNQp06qXge4
         FRi8fuoNT81jdrzWOiI6gUEVbTY8U4ztYXMIcIk+Ic2SKaygJsR2qRwkHGed/vhevSLt
         SOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1g4gB5JX1ZBY4IWX6IdgmJjYlS9r+XbX1tK+zPeCrAfJ/qKNAYIiqR3j99PKiyzicAomW0HOka1nTCQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxswdYsJw/JxCSBNn8DZDXjg0lkBgkwWLGueSU7V6pNwv4K4Z7i
	1nQo67Qn+fB8hedm85tk8GSpLqGRY1zuS1leBnJ6BTZI1tquWMs3ovJJpCaM2FQ=
X-Gm-Gg: ASbGncvnquz6FDrY9enR8aTyTzgOXPCCPzGiiEZwfSjG+g0uKjrN4qj3rFzjU/ScPHJ
	rEvvqe96ByQNyPwOJHF+lDnJhyvR53dcCckH8IgeO9+uSc4tgjwrqn8LIV4ad+joAWhNuPGGG2T
	nh9pDKfyfzp6DCQxjGiltlWsdjlGBGBFP8Uvp13fQISYLNUobHF1XzlLUDo3oesODa6wj+CTAl3
	2pHlTB0HO7m5YV/ExBAtQBzPqvNxSis7A5USlnjv+5Gy4NLklMlw8apkmav/Jzi7oncVnZWXiaI
	HO4Xm+jc9pEMgCC5TO9eGHQIot228xY17X5o6En1hZWWBIAxnB2ato4gyc75KT1c/nbuuQJsDGx
	U
X-Google-Smtp-Source: AGHT+IHh0fQaTyfAd7x4CiJbEqFqx/Echs59QFfVMAyNt0Xg9z7x/W4mDeJ4QDQAi9ApihkTQ3yXlA==
X-Received: by 2002:a17:907:7f8b:b0:ab7:cb76:1ae3 with SMTP id a640c23a62f3a-abc099c279cmr142429766b.2.1740151508098;
        Fri, 21 Feb 2025 07:25:08 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:25:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:19 +0100
Subject: [PATCH v3 09/21] drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE on mixer
 reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-9-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9VwNmNeCKWvrEI0E43BuyMfe52M7P67PLdAG7OHfpN8=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGe4mrSg/e3xXqGoaof807wjPY4hcAiqoJ02A2Y8HGAKoTAAS
 IkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJnuJq0AAoJEME3ZuaGi4PXsFQP/Avo
 A/CWck20edK9vihNhad341ZvUbBaUW4Rc3fw7DvnDOXT+MOopRGMO8GyCH5s0e7MVVIWlQYv9ph
 kyzUpzOo70C3ssipW7zJU6oJkMP2j8Ydvo7i6j4F2e1OD2WlcfY40bZ2pPmOtbXNdeR7iCuoAk7
 p80XegXIlzPE0Fc0VRQQCzDP2xIH96/iyRw/7K7rCFxv4AIKZq/7m8d7Tuwv0DnfeZgay+N1qa5
 cy9Uz+sChIr9NjE4dEQPadqXmR5TnQrSrJqhSNl7JRxs5O/TScaDpKRDRGeM1zeRoxp7QIXLH9W
 8vX0NjfRqE+htZJSH1yFlUoLH5+fJQF0A9d7rUQlZjWXrhrLexCUjH/eKp9RXtxX2772utDlKF/
 TwCPhN4MJS09C3XTQX8xdowMHI5siFkrK1FLCn8OGtrYgdihNtIi3YXKolbcWNe9Fi5JoAO1Kpf
 9mkSWz3pK1FtqcTuadbKvwlSh8ADtRkWcc8NkoE6jx4rLi/K3lT+uRCiPg309UmSJcwXloBPRUD
 lpABBINqeAk1K7W5KtNOH5eDxE8SOJJbww7Mro/TYEoHDivtuO5dph/J1P1QU4sk3hjQ8BFDYtX
 QtCIE5m1xHmtz1O2TmzObe/M6yiqIgw1Lcp+zge2SEba5w/2IJ3khamf4glL3S0I0k22chHL90D
 OUtJ8
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resetting mixers should also include resetting active fetch pipes.

Fixes: ae4d721ce100 ("drm/msm/dpu: add an API to reset the encoder related hw blocks")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. New patch, split from previous big DPU v12.0.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 48e6e8d74c855b1fcf13c8f42516437039fc27da..090b2aa5a63b4797169b24928908215e2424e6b1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2199,6 +2199,9 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 		/* clear all blendstages */
 		if (phys_enc->hw_ctl->ops.setup_blendstage)
 			phys_enc->hw_ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL);
+
+		if (ctl->ops.set_active_fetch_pipes)
+			ctl->ops.set_active_fetch_pipes(ctl, NULL);
 	}
 }
 

-- 
2.43.0


