Return-Path: <linux-kernel+bounces-526009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7ADA3F8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286FD704907
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E0218E9F;
	Fri, 21 Feb 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CggMlc9o"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8B217F28
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151517; cv=none; b=YuwN0rrSelSYfkVTHP1PPfy7bV97BvUdN1EeNuFXsZhZMb9T7GLl8MiPx3+nrYafAUzNvGRUa9NVPf3lsOFV9qtCUzCoe5w4/YgUfToQ3HU/zkTagSLXOiS+WFXc10hUfOr4QX+lser+FoqPejNxRoq1aetIOYq+EKPZ2oIHb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151517; c=relaxed/simple;
	bh=Rtqqvrg7pP9bsyM3YOU4Po/H2xEipMowzn5M0FXGvfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcSqQceOlsunHnj+6NJVQDmdwSUsmIBnkvUchFWIjtvjw7aK0I/Yo6nulMvaxGE3utOv6lrsGmZlc2cot2ET3KBUKzu9QYLGhM9OV0kIjKu15q1S9OBkqcfvjmv5O0/0RsUlNDLwWjjTIFNh6TZ8uWFMy+xj4BbwRS+OHFdjsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CggMlc9o; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb9c8c4e59so36357166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151513; x=1740756313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aig57uYJrFI1rR0Npc+LI3qdVee6ZxW9yHVBFNwtitI=;
        b=CggMlc9oap+B/Vg22NkjuqXzDcQuh+8m+XVmFme/4uatMC8Q48WqakVD5kMBkYmMBZ
         VCZXCtZwXFA/NTP4CwzDaKtNLhuK4y7uRFQjbO+NxvETgo9d7Nn/AGAgB39vjgavAb7h
         NKxI4ZPfV+xpEriteBBAujYMR94JKITmIFVooayfjkidBj+72PKO12ROvlQPIc/QMpeI
         Eduu2wyrxhE5molmMxu7GMAEsD5Wx77LOJ0cKaW/MdI8nGHkvR6BTXzGwGpFBCMoIO/D
         W58NIU04qZPLj6YacuU5jLku0HDhmtVEEP5W55+Ia5h9OtFn6hAJ0HaDKbLzmzFxUI2G
         F2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151514; x=1740756314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aig57uYJrFI1rR0Npc+LI3qdVee6ZxW9yHVBFNwtitI=;
        b=Ti42Z1JPmFySPmMdNAlW/IOWuMi7aIKMZjwVCtywhM9hVMAQqUyTfTlgYUQil3Pq5s
         3WKmr3vUDxHmH7ZU16p536rT9cpM7lYBvF1n8txb8lV/68Ab1vfMZN+H8aKA74hp4mlE
         e97TZpj7UZETT60cXreDYbp4CaBk4wBmM7FsVeqtZXxmwFyo/dG0aGxCzSK8oITXMKEu
         ptrtsk3j8FDRtf6AQS3C46u9cUnQ9uJzpUuGIQdUUOp/Z+E5/aihdt8NNtv8HB/h5vF0
         Bs/jvhzcP5GXlcyhZF8sOk19Ac1VKgYbtb7oQtbEN312nmz/hUcnxWAx8LWOf5CDWBzi
         nStQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmqcbxoduSCl3NADgzP4wDncPCFzFh9s2eA3PeuHOuePk4923UvcmqKDI/eJrLLnsJZpXAS9aY0vJolXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wmz6iQtDxQCULM8JltuGchgoqHpkzLuQa1HiOzHCU42ECGx/
	J2KQS02Y6TNqP8Ryn8xoTDSCQdI8wF5OQ+ACeS6eN/aN3FgmNBkvgO+Z4tzoCuQ=
X-Gm-Gg: ASbGncuH5UdJTKnqGDJnqH26dnj+pEzIAvB7Vo5V0CKVH+Q2t5PIjLPtoK8XYfkykb+
	RF3M0teCx+U86/P8BkfB/qEQ0NG+xmhSrtfH/4EzLnH2ChVQ6DMg2OdWmupgZYdwITx6vdfNvnE
	isgxmVpFLRw+XCgMCH5DTMHAvpLp3adUJ/2cBeRREkXMdizuW6OPSNk+exJxLa3eu8pWCKzPxHx
	S4aY3sf8iVCXx839N9JWgL/K03emuA0yUFn7+V+XYAnbWWwbjhysWt9qtxu3OFefUnVjxrRoGwz
	tUiLYT5HF78Av4jjicld7PzLiYpzuLP1xzRkT7a1LX+rnoJ2TkqSwp7C9hOH1pjXyJ7O7HChaEY
	N
X-Google-Smtp-Source: AGHT+IHdJOjKrzQzkQQRCXSbAnLH5FFessN3GeskMAbLKgYrjEA9y24pcdZQtQV3lv+cDs99o+UQfg==
X-Received: by 2002:a17:906:dc8a:b0:a9a:2afc:e4ef with SMTP id a640c23a62f3a-abc09a97a18mr157000566b.7.1740151513561;
        Fri, 21 Feb 2025 07:25:13 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:25:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:22 +0100
Subject: [PATCH v3 12/21] drm/msm/dpu: Drop useless comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-12-3ea95b1630ea@linaro.org>
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
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Rtqqvrg7pP9bsyM3YOU4Po/H2xEipMowzn5M0FXGvfw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJq2+0BckVlsV5NQsH+fOOk+tgIU+W0cwtdk8
 5PAQ0lltK2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iatgAKCRDBN2bmhouD
 1989D/wNvFmmF2NaNbzyERRYlayAx59GBiMJg46dVMuecOeKpYw7e23TtYOBE9e7+w2dhIx2aUP
 J4cLUKshVRrUNa4/xJQ7R+qK5+CzhpVoZT8X8QYnQ6nevWv4GpW0L7gB2RPc80DT0lNDL7kOdeD
 CVY15jrscmSWYkScxCbl66kCdaxVMEa7cHpGcmKaZtEhwU6XSFsLHMvDOp1vlYuzDMtA0sVm8FM
 NK9lbP4oAfJZ8+rxi/0IuSpRozbwrmoOkXrO3uyxbEc9m3XFp7eZ7J21qmObzy2ThScv+QO/yIN
 6H7MRnplfjyV5QqKExYW0tYeW8c20GMFl+SmTQ/TnkVLWZV73pnkm4Z/HJgXd4ZCHoNJkQFZKjt
 cjieYatKU2V4CO8C1dB7eweIn5Qkunm57Y91nRDKWMLJIgFEuAE2PMiD4aRCEb4czTtyUOzZxEm
 A/eUZFbxkYkYMe55NEcdpybTwFeuouDPqOODoNFysGa6KBOkGtBZPqZusfjrnxEhEg0sq9N6cYG
 gtzArVSBRBjTfh75jckfEYuzK5NUaT/mfg0soWqaECcu/PbVJf6IpuqU9UvxW5bsku/BuklYAfH
 K3Dueo8PwMsy8oTnKJbqN36/Fm6wfp4wZ6iagAhFLke/sSx+MWlHfocl967zWudT6Z1UYYkPbzj
 KmVHudvaqT+tP4w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Drop comments about SoC before each 'struct dpu_lm_sub_blks' for given
SoC because it's duplicating the actual name of structure.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 7ea424d7c1b75e06312692225f4e888e81621283..4ff29be965c39b29cf7e3b9761634b7f39ca97b0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -362,8 +362,6 @@ static const struct dpu_sspp_sub_blks dpu_dma_sblk = _DMA_SBLK();
  * MIXER sub blocks config
  *************************************************************/
 
-/* MSM8998 */
-
 static const struct dpu_lm_sub_blks msm8998_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.maxblendstages = 7, /* excluding base layer */
@@ -373,8 +371,6 @@ static const struct dpu_lm_sub_blks msm8998_lm_sblk = {
 	},
 };
 
-/* SDM845 */
-
 static const struct dpu_lm_sub_blks sdm845_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.maxblendstages = 11, /* excluding base layer */
@@ -384,8 +380,6 @@ static const struct dpu_lm_sub_blks sdm845_lm_sblk = {
 	},
 };
 
-/* SC7180 */
-
 static const struct dpu_lm_sub_blks sc7180_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.maxblendstages = 7, /* excluding base layer */
@@ -394,8 +388,6 @@ static const struct dpu_lm_sub_blks sc7180_lm_sblk = {
 	},
 };
 
-/* QCM2290 */
-
 static const struct dpu_lm_sub_blks qcm2290_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_LINE_WIDTH,
 	.maxblendstages = 4, /* excluding base layer */

-- 
2.43.0


