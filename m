Return-Path: <linux-kernel+bounces-174984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE978C184B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA384286184
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145B85C5E;
	Thu,  9 May 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wob9JhIr"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00C1292F8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289640; cv=none; b=AW6Eh0C4xLPjH+LzunLooBuxKh87i6jElMcHOgzFw0tY9Nh1d65Zbd5JC3lXNQ4t4QwK8ppuvlancB+9e27/ODgXRRxzk2e4yrEl3wRL6+EzhQv72+H4/afhAhHLq1fFMNo+2R4AjAcOLJnXDf9S7p1//3AzHYk+TawrToPlGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289640; c=relaxed/simple;
	bh=BYK2WN06GtAji32+gfIGh/W9H3jyH7UilTyBvi9es9o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nfDnd4uju8i5t+C7Xn0b8ygiE++ywduq4ua5dG6vibqi9pbdyZViSf/ebNpxuLvf/ws8+8W39fa9U3jETe7fSIn5iQXI0sOkkWTCpwS3oxDypkeWRN29PkY/ReK7Qtyo2FMMbqSz67kaoOWup1dThl8xfQTRZzozABXkyOz8Q1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wob9JhIr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51fb14816f6so1788641e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715289625; x=1715894425; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1w2Dg2zMqYrpdo5K6ppk2Wk2CEUaZVGV/kusmzWa10=;
        b=wob9JhIrkdBMj9xMvUs3bRyGPFeNdAe57KYwqyAgSOy9RIOugBkFu2aObiX1kdr6iX
         9k5ZBz0dGlYGLIii5QIUth0HOdEFRfd1xYZdQC3sADobz440L8NuBaXsPgVt0sCOwIR1
         4LrxCphxmV2E26znVVXWqsgh+IExzNrWcYAxhR7su0IFIjQ+or4IMuQLBDmWaTwv5mot
         KX6UexASjTVaoevJtA3g//mGTYRp0e6GShz+KQX0SqKzPQd+pIUGvv+PM/Se5caZgitr
         d529yl84jgFkMZuu8aaldb1nevwYPEV4dSUp4p1NSwLyH0ZsHEou3OQEJ7IYvEbZaf2N
         t0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289625; x=1715894425;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1w2Dg2zMqYrpdo5K6ppk2Wk2CEUaZVGV/kusmzWa10=;
        b=O6CWcsDq5CJEG/GxCt6wLmru9vMyeoMHXdRz6u52C08/Ev/RUt6d9xUqf1xsbvQIbV
         /j6NDRiEjD0K8kX4Vyd6R1OHwIrc1JFeVBzVp0j4m7tF9cNeqQX/mmDqJC0uaG5kw9wk
         Ts+NhlEhI+48z7t3zC3NEvcJME04GU+Sw6TkEUtH7Q9ol2B4yUWdfYdIU9Ps1gGOENi+
         /ctIObJ/BOUlG/xIwaF9kHzsPZLvotsb9Jq8fpTDK4MztBtAuijsKPbqyqtZ79yAMAGK
         DYv+NNYI0M/owUehWfENrnaNElwiwX+4A1TsCStHv3TargHg1oyxXxFxvflsXpTzR7aA
         b61w==
X-Forwarded-Encrypted: i=1; AJvYcCV3NltMjWLTQF4asPGrQ5xdV1SpbO1RhkVa3OSgC1sFQ+o4wgv9jWrPY1l1e0q09tW+YLlaalycH5Ib/Ay8FB59xLi7/eJ2ElZTa6WH
X-Gm-Message-State: AOJu0Yyjha/mNJjQzZARI38DgQUIeQAnnKIm6KATQq8oq2XvjJ30PxbN
	YU7F7Utf27XWPAtJjUMHR+aHXDdUd7/V4aBDHXLUO23XabNM1KJ+kJGivX4SG2w=
X-Google-Smtp-Source: AGHT+IHnU/aJy1ZO1/xfH52rJie0WRqDYb/sNSj7f6lqtWBZo2L5OLSGrePaO9FoY1/O5wDNN3L4dA==
X-Received: by 2002:ac2:5049:0:b0:51c:348:3ba9 with SMTP id 2adb3069b0e04-5220fc78614mr475324e87.22.1715289624766;
        Thu, 09 May 2024 14:20:24 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d898fsm438832e87.208.2024.05.09.14.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:20:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] drm/panel: two fixes for lg-sw43408
Date: Fri, 10 May 2024 00:20:20 +0300
Message-Id: <20240510-panel-sw43408-fix-v2-0-d1ef91ee1b7d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQ+PWYC/32NQQ6CMBBFr0Jm7Zh2LIqsvIdhATiFSUhLWlM1p
 He3cgCX7yX//Q0iB+EIbbVB4CRRvCtAhwrGuXcTozwKAykyypDCtXe8YHyZk1ENWnmjtefaXEd
 NemAouzVw0Xvz3hWeJT59+OwXSf/sv1rSqHCghqy9UE2Gbou4PvijDxN0Oecv7sdNXLMAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BYK2WN06GtAji32+gfIGh/W9H3jyH7UilTyBvi9es9o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPT4XQW4EmHL745xMaQ3Khgc3J6NZ1SYxnm0Z9
 VtzIoOZkXyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj0+FwAKCRCLPIo+Aiko
 1fufB/0dIT6yHh/Df7jknSeMZ1ifhCbIcAxPhjYPSt/lQZ9IvamjjzpbcmcA1vT+POsDmG+Kbdu
 34442SiqfdFwqC60oKphHv+KBxtn8koF9d+EHOb7/V+fbSKy4ue+ht9GYX2AbtIFTb10qJKTPyM
 ID+WGhnKX+WC3gPMJ/DQM5yphcxuoHRjulWxpuGMVanKbW2XSzhdbQohHeQwbJl0ZZIt9KvApF5
 rbTIna2d3gl6oCSbdgbkddMVivY8oGtlg48o23V/Q2m6xJqJHsYoSE9WFziveCpxOiqBfOKmfmU
 BgYnhat7KwcA7FbAOW3JDGH7IHp7Fzkq4ThNGtpla92IRDN8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix two issues with the panel-lg-sw43408 driver reported by the kernel
test robot.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- use SELECT instead of DEPEND to follow the reverted Kconfig changes
- Link to v1: https://lore.kernel.org/r/20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org

---
Dmitry Baryshkov (2):
      drm/panel/lg-sw43408: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/panel/lg-sw43408: mark sw43408_backlight_ops as static

 drivers/gpu/drm/panel/Kconfig            | 2 ++
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 704ba27ac55579704ba1289392448b0c66b56258
change-id: 20240420-panel-sw43408-fix-ff6549c121be

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


