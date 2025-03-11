Return-Path: <linux-kernel+bounces-556801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053CA5CED6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6F3B435C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B7266F1F;
	Tue, 11 Mar 2025 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDoLCSdQ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2962266F10
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719771; cv=none; b=owcI++mN8H/JLC8k/1bX5I9YflS4eeIJOrerMjLt6+BCVjy+whiHR8s3ouiYZDbB8XpqIXkPcNkMQc+r7K9D+LxpC79dIDNqZ7IQ1+XNh/9f+7gix6G5jVP5A+z9iXtD3/7HrGGMQR4el6D41KSZsVYTcFJUdInBt6hkgKp3wXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719771; c=relaxed/simple;
	bh=HpuEY64L0Fw1OnHLOTzTER9uuArLg4VhJ9JNiMiD75M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+hTFmOJVaY+TkKuvLuo0fJHRtLvbemPj4c5O7GKBciYARG3p+SUHCLfem5nsSWX3l+n48PbdrOGu5eEpysG93kqi+iovt5Gj91CHQQ0IKg20Gi0AuW2F/gRVm4DCHJ2+zIpFwf86B7k6R3WF0DhLcHKpIF1EZ8yMiye2scvbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDoLCSdQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38da6a1a20bso335775f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719768; x=1742324568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ix+uU1xNjgf6yeJ0CN+CN8S9z1FXI/b+G+I98D4ytEI=;
        b=IDoLCSdQ4IxneukgIYo4fGehii3hx5AkI4CB1DyM5HzwUX9pSPHJKhfEsgEzp7xXzI
         wYamM9FfW9A32Cfc/jFPIWiimvavYeW+QB75l26aocCkZ+gmYwMERA0IXZ6Xnru5SYD+
         SWQwkHoQ/l2MA1tCGRqwhdlxAdyR1bYi+4MxPuLPv2tALo69ffdfZMEOCXlzZ8J5tUgd
         be3GFguGLTcN6+uY8nDJ6jzqBV2JW5Zc+PwY/Nw8wrIjZ86VCvhZIae6q+6TazqqlhC5
         ZEYstBIC/rVFMt6DIwA3s+4JecXAUDI+j9BqVAhSEau5BUCy1mePHonRoVqoGgSjfD+o
         RnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719768; x=1742324568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix+uU1xNjgf6yeJ0CN+CN8S9z1FXI/b+G+I98D4ytEI=;
        b=tuEkQGKCdl/yW3mdKH0E/OacJ+ktT1xxpp5RN9/0SUTuJvPDs2al4TPW16iRHw4z8E
         pBfRS4j2H9vN27g8WBBs0s3qCH6gz5GvphKPhJA5Bg63wsXxFL9kwYA0guMsm9VDydgW
         eC8wSWEm+jhRiFTNUG+RPjHEasovJFgPj38NHagENwrRocQ608N/1WpZmhf6oIV629ra
         AKMT6m86SbGZk+RTd3OHFuIIbMfjG6LRauTrcZrS2LTYklmEPAaEH3Hs9CmP9pe68SAM
         yLy1VhRf0354hz4D+fcQl34LQWP0SWbZORYIXFStkiEXDgbjOJqljz9Vq40dqy1o0Mz3
         9VqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkqi6GHfePZwB8UA940Xpd/mqqW6Sh+3WyNF8PXwfTAipQ/8WgfMmVptKGkDEcE6FFHHEM1B7w/2SE0lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lv590Ay7YgmO/P0+QC3F4RvvHHnt95pnc+ndFYBCmSJaQDVU
	LOYCIDnJ18RhX1rt1NyLkD3kY6hJbKWSNOTY0b3UyUBmxOJRtHCFRi2LQLnUSH4=
X-Gm-Gg: ASbGnctuIu5s3ogVivlb7JXLs2CSpwijtsmRWDMqUJthdGV9w/Rb42fzTcn7DvPWZg8
	zY2ko9fMN0X2IBLKAvMfc5ZqGrDvlMACswA9dV62Vp8YdwUV+kazJi20pnihm5dqdd+UeEjURnv
	TaknGWBvxTTvx9/CLsi+P/fMTs3oFU7sbSefmeGObGVW9VEW9XqMNltFLGq/tiEQWxc1oPb1kmS
	5lHbavZSe83LG7iB8IpID48SKVZ/e7Bp/FTKiDfnEWEQk6fPJTJKt/wsIPCL77zbJnQkZHs4zYl
	6MHZfbfDSDLc5hdKTF97pal6Eb9zTuN7TB4PtyFT3Bu55/ATdqyjOBcaMGE=
X-Google-Smtp-Source: AGHT+IFJ2OFI5YZhOfkvAINV6IYwYgC6p9uLZV8JfzIM0FiUVQywYJMpVIcHgAsz7JA/MhP+jO6cBA==
X-Received: by 2002:a5d:64c9:0:b0:38d:c2f8:d914 with SMTP id ffacd0b85a97d-39263a0ad68mr1990391f8f.2.1741719767980;
        Tue, 11 Mar 2025 12:02:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:02:02 +0100
Subject: [PATCH v4 12/19] drm/msm/dpu: Add handling of LM_6 and LM_7 bits
 in pending flush mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-12-da6b3e959c76@linaro.org>
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
 Rob Clark <robdclark@chromium.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HpuEY64L0Fw1OnHLOTzTER9uuArLg4VhJ9JNiMiD75M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0IivLsaIHqQgiO6+2cMYQjRG97Ch6IzMUYSp5
 tc7WaSfnJSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIrwAKCRDBN2bmhouD
 1+ZfD/wOIimq9hDJoUuy2MEqzcNyzOAa7I26LtwvTc+khsLz+/gD5VNQWbz9LUMVfnHzTqooqMN
 pQCui0f0sngHA3D7tmbaqAyKIrfJWQra/RgtxJGsNSkddI6itGQBWylNUVmEjca9qy9odfWtbAY
 XNz+9CrB6jEl/qmAHo0EFlSzyXvuQmfxmO1nHXyowiP15owVnd9K4spxswS/M7faYeJiq88vJCl
 9RDEx3q9s4DybG8/nMWQc6CxLszrvV+u6ym6341aZSvm9zunl9Utcf4foZCA4TFR6yC+k6ZKWcg
 4ipfHUqO/PM3XBI/j8fuFqzEZILiad75PRTL3OfUMVbOU0k/leTF64vw0CxgiuGD0ll2qUk7Hw4
 wt9lMEFlPvOGZmZXTY2W+3H5mumzdFUCS06KRJmMP9Xgx2d73q5l6R7ZQADmfTBqNaf/0IxjVdZ
 +lKIJHu2nnWJKN0CSPxkBxTSGZYuBW9fCIWlyhQRgWnXPvipZ//drvScYaPWvJo77aRFAogUEY0
 p6+dIR932XvHuhRKQbeOFoQpj3LiUYGahMtIgLJVHbntzTLu0wk4jWE5AacGFQMt2cGr9Umla7A
 gRtpEtHafBJRUzbqx8KaZg3ZrecmFukKUGLXN9CQ3QrlcGuG1Q5XBHst4vIu8g3TqkIEY/Rxz0A
 x+w8nXg97bw44pg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

MDSS/MDP v12 comes with new bits in flush registers (e.g.
MDP_CTL_0_FLUSH) for Layer Mixer 6 and 7.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 2ce59ba50ffa0d14eaa07e993fadf0f218390ef1..3e5e1e09e9d00ade74371489b2b4e50e648e2d16 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -261,6 +261,12 @@ static void dpu_hw_ctl_update_pending_flush_mixer(struct dpu_hw_ctl *ctx,
 	case LM_5:
 		ctx->pending_flush_mask |= BIT(20);
 		break;
+	case LM_6:
+		ctx->pending_flush_mask |= BIT(21);
+		break;
+	case LM_7:
+		ctx->pending_flush_mask |= BIT(27);
+		break;
 	default:
 		break;
 	}

-- 
2.43.0


