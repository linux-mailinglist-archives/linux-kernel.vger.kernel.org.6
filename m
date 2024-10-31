Return-Path: <linux-kernel+bounces-391360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAA9B859B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4BF1F25493
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7281CF280;
	Thu, 31 Oct 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogSMXMXm"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111221CCB30
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411060; cv=none; b=jHdG4e/xGlLUKgekndAT27CN3XlHIKnvesVQZWBof4MgJZc4+tuOxIl2kc+H93QlIqoMaN3Fjut5jMpaseMkMEVyu83l+b6y1fygYZJpdsbEmU99jfzW0eG1IVU82uSMfnHKn5NBDutRxraWTaiVLKTVGbLLch2tUxTVZt9QIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411060; c=relaxed/simple;
	bh=lntCchS/1G7soOEmMcWvSKjNtV6NhH/Ttsm15XGOC80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=soGkVNjdlZZZ2/w9X9MDwxMXrSVXGrVOsSUMXGRoUu+eQcmjClMukS5giMVdsTcYlLoMrJn/AAEdtqygf8WtNswPAd/XGRsJGPqf5MaqsyAoGD4ykcEq6jT2LCH6qgw8N/enwHOOiz3bwK9cBfj/xWxy6xsrsCnCKN0Jc2uxDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogSMXMXm; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a097aa3daso1381229e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730411052; x=1731015852; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JABEHipC9Z0wTq9sKT+cueUNJ0QYw8iXu1pTjI6dILQ=;
        b=ogSMXMXmiBR7mg0jm5IgF29amVRNPKObFz3x56/aMyvUhWPjCO+s4qxmbKs3bdKi5s
         tjoaEfBpe7dsIjaRBXLTUYLBeRwPz1D3fTw9hO5FrwCY05DPvv3Ly8jISkETxTFhDZoJ
         FWTdNuapftF+wE28qGTorKUBmXHUGrsAqZzjk/UhTeFPoKgld4igiZrPZBSuA7FkT4NA
         jANnPRtLrO7PbRWeOKWlSQQVdHWKI73Tu+P1KuqrT1uaB8aFDeCVPAJEXUjXhN83qfBy
         ePNM/qYwsqVtQViFYagZs0TO8tqCJ0dIg1JjcrfZ+csTKmG2hzrR3Gfn4CITqtK0VUrn
         C5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411052; x=1731015852;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JABEHipC9Z0wTq9sKT+cueUNJ0QYw8iXu1pTjI6dILQ=;
        b=gowyzTc+do/vKuBZmvdXnvhGZnk0max0mlwW6SYrNnzfSCUXqWVCiccjb+5KdUiMFx
         We6+Z31b7zLHdZ95bzjKNSJ6p9h0qv/FjfLrUAaV9BDZ6CJ8pVE3VMwCPPwdI5uDTiUR
         n4JuugtDlUxGnh1vJPE7esJZBZnkvkA8d6MVfYbPatHangvziiVWA7HuycaewaYu7XPg
         /gqnW4ipf68NwbdCpiPP40ivMaBXNbml+pMKPP4lsmL2PJV35Sk0c/EjLwxOLIPY+hk7
         g6QRVSJXbNlwEOCaQWP/3bwmHl9+IYZEtzNS3/gSRcSmr4zje6/ChAU0O2650iqR81DI
         bRbA==
X-Forwarded-Encrypted: i=1; AJvYcCV+lt6ufu267TniAA3CHC0Idp23mBo34csEOZpSCCqdoTArdeMm6G9aQEFcUTug3q5msNa6mPt8pnQEU5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFmmoUFT7f6bxN+e51AZ6c5+p4rwKOKrB3bXOF5FSgYPoFHgf
	L7KcegELpauBhgDO0khcvtK+KXeqXVvsq4hL/fuHOGKeCHIsfF6GdxQ1XaGJ20Y=
X-Google-Smtp-Source: AGHT+IEF7sIF6pFMxEAg5enP1MZeKE+KWHTm+s7sQ42B2P3DpcIKoommDZFWzHt2IB4NWkD3YVwjMg==
X-Received: by 2002:a05:6512:b83:b0:535:66ff:c681 with SMTP id 2adb3069b0e04-53d65e1ab82mr763727e87.48.1730411052093;
        Thu, 31 Oct 2024 14:44:12 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9c162sm339567e87.96.2024.10.31.14.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:44:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/3] drm/msm: minor msm_drv.h cleanup
Date: Thu, 31 Oct 2024 23:44:05 +0200
Message-Id: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACX6I2cC/x3MQQ5AMBBA0avIrE3SUgmuIhboYBJM0yJE3F1j+
 Rb/PxDIMwWokwc8nRxYtgidJjDM3TYRso2GTGVGq1yjdQeuchLu4mSR6caxGIwpqzJXvYXYOU8
 jX/+zad/3A8gAQ5JjAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=784;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lntCchS/1G7soOEmMcWvSKjNtV6NhH/Ttsm15XGOC80=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnI/opmTHlf339jNV9uBeC4JpuWF5R5x010IQSv
 gdQZw72twCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyP6KQAKCRCLPIo+Aiko
 1V9eCACly3YzaLuZBIXqln4CQ9UIdmDlWM7KWZt00dBGUajGtHRSxP1uBTTaKLTnrKhKe6lxXEI
 fVnCkiQY2BOLVF8X+88N+d/NDmhnJDYJv7C2nIPPnAs72ZosfUVP9H6RtwmLWAnkmRCJZgHbNsB
 FqLZlKulDEzHD5xWGjdi+tc5juDiSYy6lZfi/i40mK9I+YMZYVw+PKTlC6Bsk7EdFCb7Bj7CHA9
 YmufZHFgXF5XR80IIkNFKJcnPglSgsz07Nq3GZMyaB7A5HDjhcJNzSVQROMd8IBvHFycFriSn3r
 FnWbs2OKwccwm3Vq2LwuaXWxY6dLmPaIqAk47A9ubhc32dn7
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As I stumbled upon msm_display_topology define, perform minor cleanup of
msm_drv.h incldue file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (3):
      drm/msm: move msm_display_topology to the DPU driver
      drm/msm: move MAX_H_TILES_PER_DISPLAY to the DPU driver
      drm/msm: drop MAX_BRIDGES define

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      | 16 ++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h               | 18 ------------------
 3 files changed, 18 insertions(+), 18 deletions(-)
---
base-commit: 4a6fd06643afa99989a0e6b848e125099674227b
change-id: 20241031-dpu-move-topology-f5c4489830bd

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


