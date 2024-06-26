Return-Path: <linux-kernel+bounces-231555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3289199FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FB7282956
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468819413C;
	Wed, 26 Jun 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYJDGFtN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042F19308A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438368; cv=none; b=e7LOyg2dKOSLB1FPodPVaq6ZnJj7JOpj3VV6LkEgle23wCDqFV5sOS2NXMCCVH7RA+2xtlNaycmlxn516mge0kQ8Zb9w10DrWmQCipZBI3dlNrKeZ5jNq0P0lMHZdO4x6u6ytd+s3nyMu8ouWOVpFYq2rLrj0WniGjpKQWgtwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438368; c=relaxed/simple;
	bh=rd6rtVl+hHZCsxkoS1jttFBofdxxaB/6oGLBYhRLsTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8B0u5D5teyT+HuRzrVVGDbjoJiBdbVuyqZNZ7NTAw18HCLfO1Rs+sAtmAikDYmZPhp1SvcUOlDPiyzjgEtSdLDhGEUan9CISgv5b7P8PVIfCW6nj78+3zE5bYhcylXUIfIWFBEzCfAgPSdvehBXHuDnRtUNFhb3qvwI7fA/SNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYJDGFtN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec10324791so86740071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719438364; x=1720043164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MqPF1YSYteLhHR2KPh28cADPGHqnda+8urMjgusU7M=;
        b=kYJDGFtNassu83Hs7DO5qzSvVMz8KDFnogQbBANNVQ5CWz71aquWfrirh3Xb0RbelU
         ugomrG/kADUw0jZQxSUgdM6+8k0YoT549b+lqFSIO9RRvuEkzcjZhz69znuNe7DPDNX6
         6BbKH8IibJovUaluvDBywpyOo3OUWUBqxinInmTGTKt9U6iJlo7cgTewV6b9eqawVDC2
         XkigRISSTVCFchhrO81Shitcm5QpH37pCsTcW20DXwKqMzi7yvE1AUXoOGrZH6GpDh9V
         xRUGRP1OS0fBts6rlZrdiNYp8jLcw5trtR9B1jxe6AR1Sht5G7CKZ3i+MTdfFmz1IvB8
         pPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719438364; x=1720043164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MqPF1YSYteLhHR2KPh28cADPGHqnda+8urMjgusU7M=;
        b=UbSufkDXvxccnsD7/6oYHrjtICmiPFvNeqhyXbYe6I+lcfGRLIweVaX3RRr0u9Qfeq
         KiuvpA2l7TO403Bu64Oiq249AZQrIjvqyc4EOM3+f+sltXTWj5JZ0U8/dXaXEmmuB2tq
         P6p3q9mzeF5HWhjNpDyQLkUjMi3c90tJvC5XEFqByN7ZWZMVvNHwZq65CqjPxOhbMm3r
         9Ny5qzES5zUC73yV3+pNBS9gw7Qzq3GrD4EoRgdzglA83K9U4ytWXcXgJi1aTmoAac7k
         wCYxa5r7bsTa1xIuJkcC8Bhyq+vgBYtHOWBWIhQ5ZDzvrPizts0M148brqGtsDunNHtQ
         u1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUL7LJneXpV0wbWw8REk3kLWXjIDJ9oUPSdDAoabluwj1270Phmu0R3AAXswvg1oEpKrP2VgVcK/pkh/yp1+OUXKIFAfTMBqb95jAUJ
X-Gm-Message-State: AOJu0Yzw7zTW2GfohpQnhUbEGdWxQjmzGAK4WpoSBX/csn0Cp7nLsqHw
	vfTkvmoZHa4WYaiZcXvq2mqQv0HtlliNnNUfFkv4TKfp0RT4aThDI1xNgcFo1lA=
X-Google-Smtp-Source: AGHT+IFsc91/IO/fTqSX4VLlvtW+q7dKonkLjP7GXmQRnt4prEY7s1ukZS6fCiYVXXTDyX87FfE93A==
X-Received: by 2002:a2e:8607:0:b0:2eb:f31e:9e7b with SMTP id 38308e7fff4ca-2ec5b27d17emr70321151fa.14.1719438364504;
        Wed, 26 Jun 2024 14:46:04 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a350d96sm23201fa.49.2024.06.26.14.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:46:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 00:45:56 +0300
Subject: [PATCH v5 02/12] drm/msm/dpu: relax YUV requirements
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dpu-virtual-wide-v5-2-5efb90cbb8be@linaro.org>
References: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
In-Reply-To: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rd6rtVl+hHZCsxkoS1jttFBofdxxaB/6oGLBYhRLsTY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1pNj8SOSVKXAq3ffSztvBme8eexqPZkbnHG4rcuDVuDl
 +8Kvm/RyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJpHGx/2ZNFo6eJid61DLn
 vLbf80OujWHGeVLlPXLmbbz9r5y8G59z9Ila6r07YSNX9P6X4tMrRo+NJU1Ery7+sN9pmxV/y2e
 ju1K7ki+aHvoVGd1y/lRCam39ti9MX3e2LhbbZzf3UXiVlfzTJMXYzX2rGyruCAXU/p5wLkRy69
 9X1/+F/lPU2Hq+UE/I8u8qxfNdKqtmna176qP6btmJy03r1/2ZdOnY/E+3Q7TjPFV8uuYLrLfy/
 lRZuulJ2ozyT/y8Do5H5BqvuVqI/jExss3YppKz3apC5PH5WF25Vb3TFTc8WZHbWnUwa2pmFVOF
 VLajCfsuab/N65m8fzVoHuR1eenntLTp0Hup5cWVvuWzAQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

YUV formats require only CSC to be enabled. Even decimated formats
should not require scaler. Relax the requirement and don't check for the
scaler block while checking if YUV format can be enabled.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 1c3a2657450c..148bd79bdcef 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -743,10 +743,9 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 	min_src_size = MSM_FORMAT_IS_YUV(fmt) ? 2 : 1;
 
 	if (MSM_FORMAT_IS_YUV(fmt) &&
-	    (!pipe->sspp->cap->sblk->scaler_blk.len ||
-	     !pipe->sspp->cap->sblk->csc_blk.len)) {
+	    !pipe->sspp->cap->sblk->csc_blk.len) {
 		DPU_DEBUG_PLANE(pdpu,
-				"plane doesn't have scaler/csc for yuv\n");
+				"plane doesn't have csc for yuv\n");
 		return -EINVAL;
 	}
 

-- 
2.39.2


