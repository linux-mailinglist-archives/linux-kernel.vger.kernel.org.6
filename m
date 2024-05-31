Return-Path: <linux-kernel+bounces-196015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3518D5615
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3811C22210
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9718412B;
	Thu, 30 May 2024 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANYtWMoT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B41862A2
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110780; cv=none; b=i3WyVJ4L2qIgOv4X3uMxtH69xKYKANeUexsXj0KKgBZTjkQkBveyh/b4W40looC7KwyvAseUta+ifEYOFEXwsjWEM3LDz9lNVuY4fQPsF57sPhE/UAgCx56ggtGhp3GcojifgDEacFqRSF87xNhDKo2kOq0WVeBgo58bMx71Z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110780; c=relaxed/simple;
	bh=VvftgDyvPN2Jo+dzgQt64qBzdF1Q5SyfOzczZqaDLmk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y+bHZG2dsUYS0Ae0qnaRXEBBy3YgTA7XZmVIfe94M1jG4Cw4pZX+MHQTd5RxjawJuk5DlJwvU3ez0QO8BTx+JbcWAZZIm8fWL3HuKKvfiN4AGYid034ZBRg4K5crPRCIoqqRrhlJUziG2VOzU7ihsGsGvQGPu0//eAi7mbOI9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANYtWMoT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52962423ed8so1737353e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717110777; x=1717715577; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxC+zkRQtnEbqEOZ0TSkFRxCG7VsNA8jgi0zgdIyDnk=;
        b=ANYtWMoTj+68KuCoaImQ0oC5aK35mEENfqBIpfryoCEWpv3fdDD0B0WakwxzHZCYhz
         V4cWiqCN8Op1cRpk0X+neRO68ZxA+4CkoXaxSp6D9kwlDF6DcI3n+3og4z90y8YfKciY
         E7O8/MsQgjwh73/SO7KzMXn49kJlElOPNos1e1xmvLtdhAn6HwsrhdK3o/ntbF6Orrh/
         eXkjZsVxvCeyp+Xq7ib0WIjuPArmiIBPKNCljyCjHD6Ax47F55Ocrv0kpbZwUHkOlen8
         FAC5VLU9UC3o78qElvkXOq3I+YxL87m5Jvh+nDOcoLhSnp5yaiM01kkDCXDeWuPLq4Hb
         bu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717110777; x=1717715577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxC+zkRQtnEbqEOZ0TSkFRxCG7VsNA8jgi0zgdIyDnk=;
        b=JJ0g+iP2wKEeHaIXOHSkUg63L7ZppHXvaqhoIEvLPQHbm57gqbeevwFZigpMI8mkV+
         lPYFyfwzO/bnB28bC84KUG1Fbv0AK4rIkiq1q0Fi3hnVeaxMAcj5gceVcgWsqVtzPrLk
         2G9YEq0Bt7wAYNT4KycTcaNXFDp/wJUnx6I/5l4RHEyvkZQop1ab29tAtTNoTJY5Xge3
         F8axL0TB5kYAyQ0dttEVVPnCRrQpOb8hUIJjdoUcQJBI1w2fS4cF9I0nEBYy9Wn78wsG
         GP2RT1dPvVKmdGtLQF4fgWtG/a5y14zmOyX3EoTGLoE/o7O4YUQp2Tgfg+VWLU2N5J9q
         XRdw==
X-Forwarded-Encrypted: i=1; AJvYcCUNrFaTfjFUsLidwh695vBzHf+amLP4xlH5wIDtRx2HcC18yfht2z1chDiGSAT5zBVVe2vTYc5mt3rVEW+3ExKZQMmvlP8w2Awnilhw
X-Gm-Message-State: AOJu0YxlNATk+JQpsvb1DhiMkak1eSZWk4xv59L4hwRpyl2+y1P8kIWr
	ET/ep8YhHYIH216tERFnrlCbWLcHDKGTiT2uU1NGtaBFWO334V/yGqoUCsvZ65M=
X-Google-Smtp-Source: AGHT+IGGLsAMHbk6z9ggkIBZMdQMqoAHVm39g6bHGA+HdZAGC5BH/XBCKbp32FpXhgClt94lctQK5g==
X-Received: by 2002:a05:6512:2085:b0:529:bc99:1cd8 with SMTP id 2adb3069b0e04-52b896d917bmr39787e87.59.1717110777383;
        Thu, 30 May 2024 16:12:57 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75d96sm119005e87.120.2024.05.30.16.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:12:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/3] drm/panel-edp: remove several legacy compatibles
 used by the driver
Date: Fri, 31 May 2024 02:12:54 +0300
Message-Id: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYHWWYC/3WMSwrCMBQAr1Ky9kk+TbWuvIe4SPNpH5QkJBKU0
 rubdqWIyxmYWUi2CW0ml2YhyRbMGHwFcWiInpQfLaCpTDjlLZVcgDURovJ2BpNCBEqV4qIfhO4
 GUqOYrMPnPrzdK0+YHyG99n9hm/27KgwY0FaajkvGDO2vM3qVwjGkkWyvwj/7/qfnQMFpp1t5c
 vpszFe/rusbZq2K++0AAAA=
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=VvftgDyvPN2Jo+dzgQt64qBzdF1Q5SyfOzczZqaDLmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmWQf4bgvbfxFD+03kBTAzGeWGmj39F9t7kiqCY
 mEAskW2zLeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlkH+AAKCRCLPIo+Aiko
 1b/LB/9dVqU653u3o+awrMXOsZ2xSPBHZpil6qLXw6GtARRG1dtdPHMwF2rxdPdl6v62vVz/zgt
 xEA0N8hJPiquSjd22b4m+xShUbX4PMurjMqHnhxDX4+M1tWGeri67i4SkB1AZHxqTcb1076jJcq
 Y46FhaBvHYCToEdZnSJDXBKCcaYqw5DBL0hBpv5BjT4wRlsIW1HldEBHV+g2JGcVDoUu3C2j6P9
 ZfM/vgWE/UatGfLdjV6As/gGbDOV72Ts+LOPl0/wb/zp3Cob6JKWrM9sywDlM2fSzf6oOf76BF5
 FJlGkS4BpBJHSzoa+fmoJVUKLBGHOYSLNw4OMLrnsG924fo5
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There are two ways to describe an eDP panel in device tree. The
recommended way is to add a device on the AUX bus, ideally using the
edp-panel compatible. The legacy way is to define a top-level platform
device for the panel.

Document that adding support for eDP panels in a legacy way is strongly
discouraged (if not forbidden at all).

While we are at it, also drop legacy compatible strings and bindings for
five panels. These compatible strings were never used by a DT file
present in Linux kernel and most likely were never used with the
upstream Linux kernel.

The following compatibles were never used by the devices supported by
the upstream kernel and are a subject to possible removal:

- lg,lp097qx1-spa1
- samsung,lsn122dl01-c01
- sharp,ld-d5116z01b

I'm considering dropping them later, unless there is a good reason not
to do so.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v3:
- Rephrased the warning comment, following some of Doug's suggestions.
- Link to v2: https://lore.kernel.org/r/20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org

Changes in v2:
- Actually drop support for five panels acked by Doug Andersson
- Link to v1: https://lore.kernel.org/r/20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org

---
Dmitry Baryshkov (3):
      drm/panel-edp: add fat warning against adding new panel compatibles
      dt-bindings: display: panel-simple: drop several eDP panels
      drm/panel-edp: drop several legacy panels

 .../bindings/display/panel/panel-simple.yaml       |  10 --
 drivers/gpu/drm/panel/panel-edp.c                  | 192 +++------------------
 2 files changed, 25 insertions(+), 177 deletions(-)
---
base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
change-id: 20240523-edp-panel-drop-00aa239b3c6b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


