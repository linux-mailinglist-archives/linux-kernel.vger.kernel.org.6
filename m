Return-Path: <linux-kernel+bounces-441318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F09ECCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213211888EED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E5229154;
	Wed, 11 Dec 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6fne0GJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71369225A4F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922274; cv=none; b=FsiGtFs9YUmJMAADWy6NBxv+8/y3GnHpAmtLGtSTo2WEt0xLqxzW9CeC9ObsLLuvAPumOSmlAwlKO9UJFMoPFewWh9z1o1vTxqEpfRp5RNK9VhkoONgvYkigFVUe9lOoVClRPjVvu1kiopmheT02sQBGHhih+y4M/43viQ+Zv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922274; c=relaxed/simple;
	bh=IIWA+lKM1tkmTiDWlHZ0zy5eqwsnJyc9oPGo1sc8H/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkjYpkz2E7m+fxDd+NxGErNUDvAJahabOPJh5j4z+s8UAvmV1WHW2xjgg5yWYwyhvKA5RyIV799LN+U/4UTEpjQUb3MkYFDgdwGdIo5iBe9HIJWhf1nFWyXuTQVaAdYniaHx0vGE/O2d9/+yJ7rYo69OzPPNfD/vYwKgrPIsyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L6fne0GJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so4570395e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922271; x=1734527071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMl/UGjx4g/sgYeD/tmvYISlIEsOi6IJTxxllbbc/t0=;
        b=L6fne0GJ96e7eTMqvXUxJ1Vn9BtQYSW3MvWcEfs8AVvNAF9IemI426+k7+XkKzL0oL
         W3nKnSML8eeW1TXj4S+1Na8VMo3GEJjdc4mlb5+ewBYSbY26CzGbllwURaPPRbVQZraY
         vLTbSYqWY47YJHMvmIROkq1qplqFi4vNrsJkU+waH1yuF5fkyXZOGNKdgB4XESQHMG66
         7OTaY30SXQfEIpXYn1WIsGl55HIAnPuGfFvtr+vTJApc/o8fWSu7FR4cLLubUvVPC2wU
         ELtaaxuSzWnqsW7I0PShYg0LKUKWer2NqYhYhMq8zvI4a9lneJE/YCXcuGhzL/t6SgOO
         cCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922271; x=1734527071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMl/UGjx4g/sgYeD/tmvYISlIEsOi6IJTxxllbbc/t0=;
        b=S4eQfXje7pxjgI5y0YP0+4AiLk6T9jof9fzsIDQ5qoLF+PkVeECC+P4sCox5B3kcm1
         3Mm0CBvud1DQVBjjwzvKhiUAJcFt1P1CgXjO6vJ7ZvG0kKgY4k96gasFq2rpLyVAXO3+
         ixSiPbgvIUfaT5g3pp9nGOzOHH4GUK1AZVYanqu/N78t19jUjdAdRuw2yjgCBRYLUm+n
         JipRQz0DF0PrDXG26gNlKaybgQEJLguzKKFjBrIzSZG2b3Ezy43p93pImODUJ1Ve8Kup
         kUVgEWs2u/Z33HjkF7d9O0Eg1YyYgSS+9zSTvrMtYdI8gmUrKcq3GBLP43btbDeD5HQm
         NRmw==
X-Forwarded-Encrypted: i=1; AJvYcCVw7yiVSImx73mDuu8V6e9WNTi8Wqh1GzS5gDqyEJRfxcUVh43+K+WLovOb9a2UGw2+ixqijGawTilNUuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiMkjAmkuQdp0Os2eDeIyMInajStSCiDAhe8KQuZeUAGQl4zj
	BMiOT2KZ+2N1cZrkKfAGf7gXn7lCFj21yh4fxjOkf7/e1lZ9w3MhOncUZ3y4/AU=
X-Gm-Gg: ASbGncvlZvBfTNU5W/TNtxozFZmFbxL+3qE8WHbR77vhH/hMGLHs78aqHPXLSajVDYP
	L0pNK3T7r5nVojrdD8zEjrspE2UuRapxos4P7T/HRoxPx89NRXtmvNm9JlNaYqiwpp6Gbk8EwX7
	RS2EnSumZsDZBsHIDRB0xMKJtS64FvDI+RI33FsSqs1q/f3zLQgHVFEEarzIWvAwJ8oWkNJzGsQ
	ARNlNsGhh0kfBqMK5fCGrsega9zu1Dwy/Vp8gKGNHi1qw4Mai5ltg==
X-Google-Smtp-Source: AGHT+IFjbQ3FfGDNfx7qLs4fvnwMzWqzUSohxLQJCM95DyVwEx5JIuglm6aMTZ6H5XSHMNC1W9HBjQ==
X-Received: by 2002:a05:6000:23c6:b0:386:3903:86db with SMTP id ffacd0b85a97d-3864cea2656mr1638187f8f.27.1733922270673;
        Wed, 11 Dec 2024 05:04:30 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e633sm1288081f8f.4.2024.12.11.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:04:30 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 11 Dec 2024 15:04:12 +0200
Subject: [PATCH v2 1/4] drm/dp: Add helper to set LTTPRs in transparent
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-1-d5906ed38b28@linaro.org>
References: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
In-Reply-To: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3960; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=IIWA+lKM1tkmTiDWlHZ0zy5eqwsnJyc9oPGo1sc8H/U=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnWY3VIh4VtX7N7lLVm6TJZJvbesZ3g/yi4fmkf
 z4wT7CHEW6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ1mN1QAKCRAbX0TJAJUV
 VvUiD/4gOIEBrXIgr7Tjjp50RNQLN4PYyCFsrIWmviYuBJhS2aDEHXTpq0EGaOCBbsuAs0PwvDq
 gwJGrTWM1bARkmw2Dd6aMfbRGXYr9P8au8qqgoNpOYGnj+0oKRxZk6V50WpubTCHNH3zO5PCeVu
 7ThUbZyDANe9FQbfaSn2Bt76xnnsIVdTgRgmgh8x+MqCkhF9W/dNgW7aeEBtXcQhNHCiD8pkPqR
 e/9+X1t8Jnz0OFfL7EmFc1hI0r8tYkfP/OIlgorLcDa7tSi3iFwG6WgmDSmQnwcQZ8kQEODu17m
 OHx6v3A9lw9vYK+ksks8AY94F3FBFey/I3YhOaYBbAJLF3KjGONnB83ed9DunANS0rRVhtYB+bw
 bXJC0mAc3zTtbd77aC50lh+h0yf7upsDmhYtoAJ2ehfzTeao21Ss+mZ3XooPnZJ8PQ1TNLC0Zdj
 Tf+sqxn/tT3evjCkUo2papj2PWJ57jSmJag7V1fcfuAXxLa1Uf1+t7HftPBiiYWGs/DcHOvXLWI
 i+1aIQBOyGjxP2T9hHGqVYf314tl2muEzNcRUyV7QjLLsxmfD8FuW7MdRUKbLBQYHKgI1Su4HBp
 WGI7q5O/EDCliGewmC5ZDSyGr/GojWCjKMX+Vzfo4C3ybUq1567CXiWjq7+jGt05b2ENzN83lFG
 OfzDOWe8Xv+tUzw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to the DisplayPort standard, LTTPRs have two operating
modes:
 - non-transparent - it replies to DPCD LTTPR field specific AUX
   requests, while passes through all other AUX requests
 - transparent - it passes through all AUX requests.

Switching between this two modes is done by the DPTX by issuing
an AUX write to the DPCD PHY_REPEATER_MODE register.

Add a generic helper that allows switching between these modes.

Also add a generic wrapper for the helper that handles the explicit
disabling of non-transparent mode and its disable->enable sequence
mentioned in the DP Standard v2.0 section 3.6.6.1. Do this in order
to move this handling out of the vendor specific driver implementation
into the generic framework.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 50 +++++++++++++++++++++++++++++++++
 include/drm/display/drm_dp_helper.h     |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index da3c8521a7fa7d3c9761377363cdd4b44ab1106e..6abc54cd28e93d8101358ce05be51d4516778451 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2817,6 +2817,56 @@ int drm_dp_lttpr_max_link_rate(const u8 caps[DP_LTTPR_COMMON_CAP_SIZE])
 }
 EXPORT_SYMBOL(drm_dp_lttpr_max_link_rate);
 
+/**
+ * drm_dp_lttpr_set_transparent_mode - set the LTTPR in transparent mode
+ * @aux: DisplayPort AUX channel
+ * @enable: Enable or disable transparent mode
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int drm_dp_lttpr_set_transparent_mode(struct drm_dp_aux *aux, bool enable)
+{
+	u8 val = enable ? DP_PHY_REPEATER_MODE_TRANSPARENT :
+			  DP_PHY_REPEATER_MODE_NON_TRANSPARENT;
+	int ret = drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE, val);
+
+	return ret == 1 ? 0 : ret;
+}
+EXPORT_SYMBOL(drm_dp_lttpr_set_transparent_mode);
+
+/**
+ * drm_dp_lttpr_init - init LTTPR transparency mode according to DP standard
+ *
+ * @aux: DisplayPort AUX channel
+ * @lttpr_count: Number of LTTPRs
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int drm_dp_lttpr_init(struct drm_dp_aux *aux, int lttpr_count)
+{
+	if (!lttpr_count)
+		return 0;
+
+	/*
+	 * See DP Standard v2.0 3.6.6.1 about the explicit disabling of
+	 * non-transparent mode and the disable->enable non-transparent mode
+	 * sequence.
+	 */
+	drm_dp_lttpr_set_transparent_mode(aux, true);
+
+	if (lttpr_count > 0 && !drm_dp_lttpr_set_transparent_mode(aux, false))
+		return 0;
+
+	/*
+	 * Roll-back to tranparent mode if setting non-tranparent mode failed or
+	 * the number of LTTPRs is invalid
+	 */
+	drm_dp_lttpr_set_transparent_mode(aux, true);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(drm_dp_lttpr_init);
+
 /**
  * drm_dp_lttpr_max_lane_count - get the maximum lane count supported by all LTTPRs
  * @caps: LTTPR common capabilities
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8f4054a560396a43750570a8c2e95624039ab8ad..3311df3b58255cf0620391d0948ccf6b569a8a34 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -630,6 +630,8 @@ int drm_dp_read_lttpr_phy_caps(struct drm_dp_aux *aux,
 			       u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
 int drm_dp_lttpr_count(const u8 cap[DP_LTTPR_COMMON_CAP_SIZE]);
 int drm_dp_lttpr_max_link_rate(const u8 caps[DP_LTTPR_COMMON_CAP_SIZE]);
+int drm_dp_lttpr_set_transparent_mode(struct drm_dp_aux *aux, bool enable);
+int drm_dp_lttpr_init(struct drm_dp_aux *aux, int lttpr_count);
 int drm_dp_lttpr_max_lane_count(const u8 caps[DP_LTTPR_COMMON_CAP_SIZE]);
 bool drm_dp_lttpr_voltage_swing_level_3_supported(const u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
 bool drm_dp_lttpr_pre_emphasis_level_3_supported(const u8 caps[DP_LTTPR_PHY_CAP_SIZE]);

-- 
2.34.1


