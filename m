Return-Path: <linux-kernel+bounces-186071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8F8CBF82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC153283618
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7882499;
	Wed, 22 May 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhzD32wq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A880C15
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375062; cv=none; b=d0+SBs2IPoU0UW5urFly9dIkVrtjrRU4RFRnwrZ/4I9ywdPbOmLs+wpDOb6ojfoZzH2EjSzQUIEEHnuhLX4z4CNUsADzrSkT45fqQcTKJi559e4QM6yVUNkfBVZM7YIFRFZb+kJ0d/FhVDOcfO2IbidpHq1+caMNBaK31z3AtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375062; c=relaxed/simple;
	bh=eIKy2wBcaIR5N0rjjHKg6yf8hYS5copaiT9LRBhrUSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U4tf3hZWZ8Y/F8KQQxZpa5YBkOO9XXCEo2gfR4xjfbrx4Tu75UOL65iqE14C/LBsAiqI+O9dxMjxmg48dgrjyWY1tZ7/au2vMMb/+AMP1kvdvwppyxyMx3Yrwhe0WlBHIwDDWQRhGGnnwNxZDh8Q6F1iHLrTYzVdnsseaw4t6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhzD32wq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e72b8931caso35063921fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375058; x=1716979858; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLMrKIIqKe3GpiO1YTS+FO5sczDX1G6WDYwUlpVeq9s=;
        b=UhzD32wqVCdPYnXvuAos3WGOeLl5Qwe4gWkKHsH1FzxtRXvpu93vvXWxXcbMSI9K9I
         S6L/OGrjAFKWw+vG4yN0tfxAPKWOyqfdt0G9Ks7n9Es+4IbDd0Zy4y3JYRS50ALSp7Vg
         rVsSbsN7MgjlIAC9qqjHZMpOatYVQllJA7aFNkABXbnq2GcqrF1kugRD4kxtLZ0625HZ
         238CJyJ3uc9huHcUAXL6XVs3I5RNglyDynRQ0mypk9DhkakJ2HHtvuvm2Cu7qiLVsij9
         u//IYSOsgluobp25DVCwRjzkQIyeW45KpEOP3XRwjaS1zSlUMLyT4tfL0x7QpLtG/lKb
         wHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375058; x=1716979858;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLMrKIIqKe3GpiO1YTS+FO5sczDX1G6WDYwUlpVeq9s=;
        b=XR1/UyAQiA178/5xp0HamcdWBmA3Cx1kKP54osBgNtz416PaCu9aPU0tK9TLgGuyp+
         h6a21/r1WvSxEtfvIQGoIFChJsvbAas9goUQq7tpZYvfNbLamUrrBHKvKxzTXISNJJx+
         t4/sRgFkbVhGRPgSYRaQY09aS4iaMC9h6eZ10j3hTOTOpIgT2Qi5H+I/qqh7jSfWnEXy
         bLL/JAFZcF9dsAOgx7YUQlMjECfKvGz0e3hoNI8CvtuuOs7Zxf3LqJJKeL8K886O+F3L
         aAkKM3Q2cffQz8W2OKTkNiiSs2sYVzuBsUq2jCiNAhphgQJCZBcBqSS5b+rW9EO0fMBn
         vtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg/iH02QL5sj5X+PJMSHvMqokKEj2dTwa33+SbAc8wWX6sFxiyDvWkhq9W9oH4lJhB4xnOOAyA1/SLj89SEKaEhLjP5ZrGBJVEYOdv
X-Gm-Message-State: AOJu0YxL16K/Vly9W3awrYA5q77EZ3i/XoR6C6k879gJcVEyXNe4HwTG
	9cHTMS7GVaZt7IyFkj3g5JRJhCtgHhJkJNZt0JrV88fD8rnA+3rqL9qafz/D1KE=
X-Google-Smtp-Source: AGHT+IFh9Ye33hh7xt+BanfOhr8q/w6KH/QL7wGsUwxCgNJjCTFqNI8vXbmEH4ajxIiyKiqGhLoWpQ==
X-Received: by 2002:a05:6512:10d2:b0:523:8712:f500 with SMTP id 2adb3069b0e04-526bc1810f6mr1046685e87.0.1716375058192;
        Wed, 22 May 2024 03:50:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:50:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 00/14] drm/msm/hdmi: rework and fix the HPD even
 generation
Date: Wed, 22 May 2024 13:50:52 +0300
Message-Id: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAzOTWYC/zXMQQ6CMBBA0auYWTukTqUSV97DuCh2oBOFkikhE
 sLdbUxcvsX/G2RW4QzXwwbKi2RJYwEdD/CMfuwZJRQDGTqbmgi7gDEMgnEKyLZxTeDWeTZQikm
 5k8/vdn8Ud5oGnKOy/z+scdaQqWuy1cU1ZPGE5TbrWrVe1xxfabm9ZfSaqqQ97PsXAveJhaIAA
 AA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=eIKy2wBcaIR5N0rjjHKg6yf8hYS5copaiT9LRBhrUSo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4PNbnq5cIBEGub6xOmedby/kcYkUvbbLmhO
 AEslgI1n0eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3ODwAKCRCLPIo+Aiko
 1WckCACArlw5q/C37Z6bmwDWaXeoQ0NFyUTYd5pocPEs8HlMv2q7iBQXrz0+pMKOHggj4qOcFKv
 XV3tFqoL6QEJwoy/3vrKvpRT1ei8t5V6WbZEPitVNUsyqY4/5pr9Fo1BMEcdZU2uzReMit0bCfk
 z60XGFUlGeGNQFR/qItE6Sp+S5jruxvwqrnDqd5UTGi+EgW5P4vAE8wgEhtn6N21wfU4VKDBhhf
 5HxWnrepdSUG/gMvjaCTwDKlqvjV8g//n0dcYwR1Z/RZDPRUOLDQ2fH/3kLrXhjwc30yMJrmTL2
 86IP5yUP0ZlRm9b7OkU16/iXCqSTQEDhSiUp2/To9h2y0hyX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM HDMI driver is plagued with the long-standing bug. If HDMI cable
is disconnected, in most of the cases cable reconnection will not be
detected properly. We have been carrying the patch from [1] in our
integration tree for ages. The time has come to fix the long-standing
bug and implement proper HPD handling.

This series was tested on msm8996 and apq8064 boards. Previously HPD
handling sometimes could trigger in the CRTC event handling, however I
can no longer reproduce it now.

[1] https://lore.kernel.org/linux-arm-msm/20171027105732.19235-2-architt@codeaurora.org/

---
Dmitry Baryshkov (14):
      drm/msm/hdmi: move the alt_iface clock to the hpd list
      drm/msm/hdmi: simplify extp clock handling
      drm/msm/hdmi: switch to atomic_pre_enable/post_disable
      drm/msm/hdmi: set infoframes on all pre_enable calls
      drm/msm/hdmi: drop clock frequency assignment
      drm/msm/hdmi: switch to clk_bulk API
      drm/msm/hdmi: switch to pm_runtime_resume_and_get()
      drm/msm/hdmi: add runtime PM calls to DDC transfer function
      drm/msm/hdmi: implement proper runtime PM handling
      drm/msm/hdmi: rename hpd_clks to pwr_clks
      drm/msm/hdmi: expand the HDMI_CFG macro
      drm/msm/hdmi: drop hpd-gpios support
      drm/msm/hdmi: ensure that HDMI is one if HPD is requested
      drm/msm/hdmi: wire in hpd_enable/hpd_disable bridge ops

 drivers/gpu/drm/msm/hdmi/hdmi.c        | 145 ++++++++++++++++-----------------
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  26 ++----
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |  80 +++++++++---------
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 142 ++++++--------------------------
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c    |  14 +++-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c    |   6 +-
 6 files changed, 157 insertions(+), 256 deletions(-)
---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240522-fd-hdmi-hpd-e3868deb6ae0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


