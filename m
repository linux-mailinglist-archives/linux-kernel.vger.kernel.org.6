Return-Path: <linux-kernel+bounces-194964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7088D4512
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0406B1C22482
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DD143729;
	Thu, 30 May 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QY3CXkE8"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678F139584
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048610; cv=none; b=V+anRCx94PdNdA94VlNKUJzGf0unFRkUjYg1uPHunPPd2NOJclw+bK6RKbhY/4sA8SfUUPquP9pm7aCm+m44XXjTtdsWVDdsZw/rZ0jS4hYwgC8NJVtWXqGYhahgMoF3QqaYif9U/FqZyd4DHXYB/4tscG4cN8ps0YXPgAgVRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048610; c=relaxed/simple;
	bh=D0yrkfxxFHdMRbEH4oMP9hMkymQbCeCPPCiYJsAX4O0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W2fxiaSU1BpZyEkCL9Myze8TkoOztlXua8aglFApIUFqTfvMl6Ih5TJly7BzEWN3gi8yg/hwEhxxojfIF1ViXEQuz9lW4rH0z9xd8DwALd1uSJAONq2SLOXT9hx3T0/GTW19+8DJVygHBbawL0E+N87do4RqG0aFd0TUeTEDyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QY3CXkE8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6bfd4b88606so349165a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717048608; x=1717653408; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg+y31xl/RmeIgpL0Di9SmbXiRyE56ZbIno+aBs0ekQ=;
        b=QY3CXkE8Tg2IUmUAnYhovzEiLUucQ9cdi+ym29v2KHPl6rcWH09lnx2uptDqvGhxPw
         0f5ftFn0JDI3ytnezWHt5Bazxk3F5W1x1gQyQoem+rdvRxjanRu50rODHf6pVjmJhVHZ
         orGd8k9VfihIWSlHhkuQZ6Ee2uqJ29LjimVoWITHBn6rRuVYM9JCFrq183uc3OGQpJmZ
         /gKQrJzmHgNZQmnTYFx3cN1D8Bg3lIuRN3ZW35MKjGZKG4FB4th4GzGGSeGKmzJ/e5ur
         tQTq1w1hDv3A4/Emz6IpAXLAsCBYKiTd5Nr8zF8KH+M7D8Y98kDLrJPmm8In/Wx0QMKo
         iEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717048608; x=1717653408;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wg+y31xl/RmeIgpL0Di9SmbXiRyE56ZbIno+aBs0ekQ=;
        b=TWzHAkWui1/hSbyhQcmp2G0Ftk7IiIbefo8TwUr/Y3qIiPpgYDMZKns9Edl7pzh+hZ
         Ygg2tQWdAf7GrcIa87Hk7dZbszsE+nTt2JlT6TFew205nziDHi9PwmHllBczPQRL701R
         o1gQN/ObpRvbnFyfZXGSGDXWS62fK2RDpEhHOnLvL8JlcQkpNe6K5onLr0+HK45G70vg
         2LPe8hr2HvCeiLZzUKj3EQeSmJt90EW42C/2qtv1IYw+AQCO6Mo/dpbU0hqoAu7WypDn
         m0JPeZNdLfxpNkHcHL4MQ10dTN2ToW6fkBFzYD8zV1TZp1YV1eS4uKBPxGbVK6oQKOwe
         lv0g==
X-Forwarded-Encrypted: i=1; AJvYcCUyTk8QsRREkVQpAat0SK1nFlQiVnIDAgZky24mfawRe1PwvavJ8S7RTW2vdKR/G+xe+GJ+Dlmi8t9XShbw4I+yl8ewzOFTj2hbuWLL
X-Gm-Message-State: AOJu0YwzRogG9zUJw85rw+iV3JqzR20nGOJslOAidRoj8/xk3KJ9E0jU
	clTXxAvc8BuKutJwd51yRwVx2TSGhPRdD6wc7USIuwGr1g2PMUZCnSm0Jc8RTi0=
X-Google-Smtp-Source: AGHT+IFomuY8PNK14qd7ZuhowVwq4GZWAnuqj0py5ACiE+WTKY8mq9b+tz73xLwbr4TfRr5YJ609NA==
X-Received: by 2002:a05:6a20:4313:b0:1af:d033:d66d with SMTP id adf61e73a8af0-1b264523619mr1354733637.9.1717048608215;
        Wed, 29 May 2024 22:56:48 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75ffc6sm110006705ad.9.2024.05.29.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:56:47 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v6 0/6] Add DSC support to DSI video panel
Date: Thu, 30 May 2024 13:56:44 +0800
Message-Id: <20240530-msm-drm-dsc-dsi-video-upstream-4-v6-0-2ab1d334c657@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwVWGYC/5XNsQ6CMBQF0F8hnX2m1ragk/9hHAp9hZcIJS02G
 sK/W5h00+EO9w7nzixiIIzsXMwsYKJIfshF7wrWdGZoEcjmzgQXkishoY892JATmxyCRBY9PMY
 4BTQ9SBAChdDa1VidWGbGgI6e28X1lntHcfLhtT0mua5/4EkCB9SHhqta8qN1lzsNJvi9Dy1b9
 aQ+xfIHUWXRlafSudpIXYkvcVmWN3pbwKsjAQAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717048617; l=2232;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=D0yrkfxxFHdMRbEH4oMP9hMkymQbCeCPPCiYJsAX4O0=;
 b=GanMoNSM63YmKMLyUezYQhUPp5JSKvRAoKAwiC2PMIKEvIQQ5fqI8A/2Ev82ionXNQOrohpnj
 lrtROQuig5RAXovSraCexeLYMuje8Vm9wyd6nio3//0ZSDYnHybGhGW
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

This is follow up update to Jonathan's patch set.

Changes vs V5:
- Add hardware version check for compression bit change in cfg2 register

Changes vs V4:
- Polish width calculation with helper function
- Split cfg2 compression bit into another patch

Changes vs V3:
- Rebase to latest msm-next-lumag branch.
- Drop the slice_per_pkt change as it does impact basic DSC feature.
- Remove change in generated dsi header
- update DSC compressed width calculation with bpp and bpc
- split wide bus impact on width into another patch
- rename patch tile of VIDEO_COMPRESSION_MODE_CTRL_WC change
- Polish warning usage
- Add tags from reviewers

Changes vs V2:
- Drop the INTF_CFG2_DATA_HCTL_EN change as it is handled in
latest mainline code.
- Drop the bonded DSI patch as I do not have device to test it.
- Address comments from version 2.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
Changes in v6:
- Link to v5: https://lore.kernel.org/r/20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org

Changes in v5:
- Link to v4: https://lore.kernel.org/r/20240524-msm-drm-dsc-dsi-video-upstream-4-v4-0-e61c05b403df@linaro.org

---
Jonathan Marek (4):
      drm/msm/dpu: fix video mode DSC for DSI
      drm/msm/dsi: set video mode widebus enable bit when widebus is enabled
      drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
      drm/msm/dsi: add a comment to explain pkt_per_line encoding

Jun Nie (2):
      drm/msm/dpu: adjust data width for widen bus case
      drm/msm/dpu: enable compression bit in cfg2 for DSC

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c         |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h    |  8 ++++++++
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    | 21 ++++++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c         | 17 ++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h         |  3 ++-
 drivers/gpu/drm/msm/dsi/dsi_host.c                  | 10 +++++++++-
 6 files changed, 56 insertions(+), 5 deletions(-)
---
base-commit: e6428bcb611f6c164856a41fc5a1ae8471a9b5a9
change-id: 20240524-msm-drm-dsc-dsi-video-upstream-4-22e2266fbe89

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>


