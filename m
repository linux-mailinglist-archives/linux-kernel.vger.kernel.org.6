Return-Path: <linux-kernel+bounces-380783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68E9AF612
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6F282C79
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FF95221;
	Fri, 25 Oct 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDvqVWOc"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7879D1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815618; cv=none; b=czf0YW/NlsEgNHKvt0cjDlqJVnmNU1RYodb5N5eSg0z/ASdkdFA3W0FvAlRayoNvLVDy6TrTrXQ6iv6GPw2E8swV2Zh/Vdgi3tXEsy24n6GgEDLvSnx0uGfNKn77ddWDtGG08jmNIzYZccqs/5SKyUqsdRVLJFEncmusORbla8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815618; c=relaxed/simple;
	bh=Z1DUfkZ6/oZuA6xRT2zKvLthKeLBEYc68oLVcqrozCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijP+B8M9g+/4iwerBa/gUCcAl9V8qSbYsHtG5ge5OQtV1kwVh2g+dO/2YX0APHLXvZRbOsIMRaiM5zcKmGggfyk0t+1LPXiG8fTBVn9LEvQ3ZBwcE3/jXCG6hZ+j0iboGkisO06Wa6WCXT6bjM/VUJNtsZMtUaKdy+gqvZck1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDvqVWOc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so2480022e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729815615; x=1730420415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xqrfLhi8maJ3GiZ3G/FlADlqaLUOMJAXiAxxK/1iKc=;
        b=rDvqVWOcA7oaiONdXj8NCvtIffH+i1JnCtTpnfvg9YIuIxnzP13vvnPu8WIm0PO7kq
         eSe8c/RYTlubVU39OvvMNkHp4RX6Csf7kgtmwLHYvxaweEUAiuhVAiZovJOd/CFBc7TU
         vBuq/LN4GLgIAR4PcjfgwycNG2PzUfsW/iOJoIzY6j/CDsC3p7IT46pmvlGEu4l4M7lI
         WrNiy0Wpt6AFFBIVy+XvnfvJwLmhTAFXxCMcIOibz8ML+c4q6KNsvnf16dOxMinMJUOW
         h8yK/ePOBnsjJiz0FjwxR7bewAjWVMg8DS0D6bpHhcfXC2VQpZLnH3EMc9as400SyZ5q
         TvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815615; x=1730420415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xqrfLhi8maJ3GiZ3G/FlADlqaLUOMJAXiAxxK/1iKc=;
        b=SOypUG/hiZ8zifEX6Vzn4POfPqWZHIT8BxtzUMssc3bEGMcuV08qKBWtajU3WWosrE
         2GoG92wIPnhhSZeVK2U/xgh4Pb05VemidDHM3DJLjZuGZswn4ZIb/zPu4XTPAThOVHk/
         /B0/YYY+CPtC278kOPWJnVVhOqmQIgvjedgVENjt/Z8kpJrfUj8FYwcel/r38tzNKY6V
         4z58myFbxTjHcagpm08pBybGUz2ISG3Txu3E5D5tdYKJK0z9VoRoo14n7Nfgz9uoxvD8
         8K/NMCm4I3l3cHamiDksZZGYcIQqaQzNYLsNb4SHre6/9xjE5pUdtJdJ3F29Yls5+HDl
         r+cA==
X-Forwarded-Encrypted: i=1; AJvYcCUJaLlnmf8RVSNXKzmeZs0WDvnvrqGXFIbRGVbySEfBpUIACxZQqEXg0T65PMuQ/wg7JqzqGFV4VYOyZ8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YznH4x1nQmrnaN3im3fvPNmJg7EXXbFQrV+2HJN7O9ojC709KVa
	m/HVDVWPND0wrBoI4oO0SXXTEAOtcDHTa98XFOLcYpWijlWkzGqLvE4cZ5mOp40=
X-Google-Smtp-Source: AGHT+IHMp3Vj8D5xOK8sGcL7IZTD8X2M3Tusli278j57Rh6uC4B2tdfT0DQHDAHKsjpze0EnlHJyZg==
X-Received: by 2002:a05:6512:350e:b0:53b:1e70:6ab4 with SMTP id 2adb3069b0e04-53b1e706b9fmr4865361e87.14.1729815614849;
        Thu, 24 Oct 2024 17:20:14 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1b05b3sm6227e87.161.2024.10.24.17.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:20:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 03:20:08 +0300
Subject: [PATCH v6 1/9] drm/msm/dpu: use drm_rect_fp_to_int()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-dpu-virtual-wide-v6-1-0310fd519765@linaro.org>
References: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
In-Reply-To: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Z1DUfkZ6/oZuA6xRT2zKvLthKeLBEYc68oLVcqrozCs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnGuQ5QZvFmOhdu+ChSig00R7PCHyXB/io4gx82
 9QJ266jmSmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxrkOQAKCRCLPIo+Aiko
 1RuYB/9ryN0Vx5GSVzt0aq/0oxk0TaqWvPjOsc9vwGvdO+M17JlZMARorjXfRX+LVmsgsHRMSpL
 TeR3TE9I6oOQjQbmZrRgw/1QKOowNUQVMeObdT1UshAlhiu4UPLsGSP84itcqEtTo6feXRAs8/O
 iYeyRyUmt7GbRimV8tKYZUCBkHqTE3ZNs1voX7QlW7fpnEpGsnHKLMG5Qe4d2qkvp//XDaxPsw2
 TcLV+wcvgUsB5YtkADcMyKJOtXxvP5crLjWMxyM/HMTt2LxVE4xqTSDbW9rpcfZO4x9Vnj4unbT
 qH228PzTSLSGi5tOrDp7mDMxYYOaQ8cwYMA0P+wFgcpnK8CD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use the drm_rect_fp_to_int() helper instead of using the hand-written
code.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index e935e9c05f04..37faf5b238b0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -829,13 +829,8 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	pipe_cfg->src_rect = new_plane_state->src;
-
 	/* state->src is 16.16, src_rect is not */
-	pipe_cfg->src_rect.x1 >>= 16;
-	pipe_cfg->src_rect.x2 >>= 16;
-	pipe_cfg->src_rect.y1 >>= 16;
-	pipe_cfg->src_rect.y2 >>= 16;
+	drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
 
 	pipe_cfg->dst_rect = new_plane_state->dst;
 

-- 
2.39.5


