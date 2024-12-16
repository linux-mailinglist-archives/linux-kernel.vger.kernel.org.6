Return-Path: <linux-kernel+bounces-446994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F19F2BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9006518832E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BC1F7541;
	Mon, 16 Dec 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjBAVkrr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C41F7557
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337650; cv=none; b=uqY6rLWlftj6+vsIt5O0DiK5kMrsM+xjps+kEHXuY1gnAtOOw/IqCLCCmnqssMAGh4v8T1duPiXMue0CLQhSi1tD1xmOSPDDzHg8GQQRFR1xw70wSQMrkrSrH8jdVa1tawV5OA8i5nXlqpb2d848NSNL0cLF5RY+6gkqJLHXKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337650; c=relaxed/simple;
	bh=Ykwoi/viuVCnZ52OOZsyH+WMXqN9YSgRldwQks5nM6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MYLm1v1uaf00F9MPlBJTbvJ/XCH3VueEbYP0lUA3l/zl7cYiU+9hO8ocHNcV6HuDVF+JtTuYphQa3PvK6mMtEzwE9hQ/1K9yPEDmeC/zUp3xRaxXxpstZHPi5pY722A+r4f2QSDVrufyTnneK9f0RU2wba+PYoe0HuoDFKOXETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjBAVkrr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3022484d4e4so44030641fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337646; x=1734942446; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrrxPcocFaYUg6/aaiKr4KpBya9ZDGEcbUvoC1inEjc=;
        b=cjBAVkrrRv7YTQ1WfTvUkJ5Sixszu+DjgHGrDdCNDA2eWUjYfjUrUR1ZErrjWuuYFJ
         TNk0tXHcdbp8WBdGz6biXDNWv7tf4KzsG43mnQbH3uCNIIWllMvCFvsyCSnGaXaH0z+n
         gsdVDxTe4Ooz9ER2NPXDVWnEStuWNg5wuaarzixwgm+kNhq1WPa7C8zxIu4lp/hQMuR6
         EFajGk9qyZWwQZtegVGo/1r/YC3BdvqMWHGTwI3utoS3uinlpLci31nmNH567N1BdiSB
         cb3+ylQeVykfKwj8GxJ72lCv/NPmQLIxWQiswMkpXIICgzx+9cc5E7G5OB+SpovHo9CT
         gL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337646; x=1734942446;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrrxPcocFaYUg6/aaiKr4KpBya9ZDGEcbUvoC1inEjc=;
        b=aqrlTJyRr2hR4dh8KwcKhPX2RhDBL8jeC8Y/ROX4qj/2pcL+hbdOQpi1e48XxdrHxS
         lUD1xZaHw62LYzaIeQTLhJss3ZU4IQIvAwPfI8RlU3BWlXDCvmQ+pfvpCOkDifa8KaPn
         TjXOGmDqaN0zVlMCQT/nvoYBEqKw1L+Aqs7CJ+X0U8PLA22bQ0MbGGAwRy4GEVgyIaeV
         j1nS/q1RJNLC9UHKrYhbT8khWvUVD2iwnY9kH42Qy/tpljtFf5APb9lMYzZ58Ovft3JB
         V3+3N57CwbACEnPPbU5p5C766jyAIK9PPRFUZNSZxBW+M9vePIO9Z6WHf5YJIjwHjGkf
         Lp7g==
X-Forwarded-Encrypted: i=1; AJvYcCUdkuzjegdWpL/yOnQYksLZMwHWe6C9MtqvrpK3ZKQE/hA3r4OeXDO9Fxupt/rEz5TpXFYsD0plSALHMj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMWFPrhZCvdy2B4Akxli3bOvTo845qokMbCl1sDykVIIM21kC
	kx9Fu3JXzrEQ+QYXbazNEbGpMdSQ8rcK/iAZQeLjqvUfj1wQjHj3awz1tL8Z2ip28FiInL91tLf
	c
X-Gm-Gg: ASbGncuo8Yl8iBQnXCt2p9u1sSnwqdyjUVBIX+tSdjrNd7Q4R3l+pdSNaXmi6fWMibL
	JvvCUcLGI+qMT6iJHbvk+hXU40mwHc80u1V+4msvW9uHoTItZIlZVfj0WNwxO9wsGfhpqWEvZpm
	Rup/BMw8cPXAAYOqYaahJAeKiLVDXuyhVsQBGD2s7HVNvUCdr/TNqSPsKpE1yCPxHJpla1MYFpU
	xS6k2GXg0k0InlXUvHgwPFvjDyC6cJkDNUcNaN6RIEyuaAH8APlbofE+55BPskx
X-Google-Smtp-Source: AGHT+IHJD+NR/PgyKHAepDFxbWTM+bPz0btqfBlgq5msCTR8EAXGlLoqNe5rUltrMZ1fu4+D0KYY+w==
X-Received: by 2002:a2e:a304:0:b0:2ff:d7cf:ba1d with SMTP id 38308e7fff4ca-302544d3e10mr22023831fa.41.1734337646540;
        Mon, 16 Dec 2024 00:27:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/8] drm/msm/dpu: catalog corrections
Date: Mon, 16 Dec 2024 10:27:21 +0200
Message-Id: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrkX2cC/x2MSQqAMBDAvlLm7EAX6cGviIcuYx2QKq2KIP7d4
 jGE5IFKhanCIB4odHHlLTdQnYCwuJwIOTYGLXWvtLIY9xNnvjG4w61bQmuc8UFGbxRBq/ZCTf/
 HcXrfD2b2XZ5hAAAA
X-Change-ID: 20241216-dpu-fix-catalog-63a3bc0db31e
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Richard Acayan <mailingradian@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Ykwoi/viuVCnZ52OOZsyH+WMXqN9YSgRldwQks5nM6I=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBnX+Rrj5j0J476K3SjRlnLe3dn/SHhLoulfsOer
 1SNLqNKw46JATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kawAKCRCLPIo+Aiko
 1eNiB/jdFVPQLWJTAqF2b7SQPaUkr+lMQqnqZ9FD2Trnx1/ZwVfm7m97liH9CqMc1xRiYyQm9LC
 QGIsgTt/kCynT3KiZA0e/5vQHw2lkoMLl/EejnQm7EaePkGl2yqfKbgfUoQpq7JYQdeRpDzz8PB
 y2HV5jzJGaL2nUP1e4QFMrYxCogCHfegRm2VX5N4iC0Hd1n4A93U6gw4Prfts7LK2R5kin9NPqk
 Gkfz/q0yXlD3JOYX5CoohmqcIazE2VVpsVzCmrJ7Ok997COxERZe6msT8Qln7MPcbuq/amWQrmo
 amx6DuPtTNU720Yf4ywYQnULpgnaWBPjP7olviV/DG6O/JU=
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

After checking the DSPP units in the catalog vs the vendor devicetrees,
link several DSPP units to the corresponding LM units. Each correction
is submitted separately in order to be able to track and apply / skip
them separately based on the feedback from Qualcomm.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (8):
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8150
      drm/msm/dpu: link DSPP_2/_3 blocks on SC8180X
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8250
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8350
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8550
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8650
      drm/msm/dpu: link DSPP_2/_3 blocks on X1E80100
      drm/msm/dpu: provide DSPP and correct LM config for SDM670

 .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    |  2 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h | 54 +++++++++++++++++++++-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |  2 +
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  2 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |  2 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  2 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  2 +
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |  2 +
 8 files changed, 66 insertions(+), 2 deletions(-)
---
base-commit: 4172e9bbb583a2af5f1a3db437caf72a90714ad9
change-id: 20241216-dpu-fix-catalog-63a3bc0db31e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


