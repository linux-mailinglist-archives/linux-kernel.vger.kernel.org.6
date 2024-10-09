Return-Path: <linux-kernel+bounces-356592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0859963E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C92878A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8984618DF71;
	Wed,  9 Oct 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkKyFXdK"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD618CBFE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463827; cv=none; b=A7lArRoPRyfduEOa6DhW/KR4vOlpM9yQ2vvcd4MDex/VIQWJ1klWil1uaQSZYz7VqnC6O7sxS6NObxvBL0BhgSC0pMeNhdYMWt1gBPn7ZO62xDZ89p6o5aTdVINHXhg6qopx/B8qWTsiWUNm/wYeJ0zEznlxyolBEPv19/nHksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463827; c=relaxed/simple;
	bh=ogiCJCZuk6UCulrrNj6IiPVgq9KKz3uKFmixSequ9dc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OrVcVT3FkkYgvfBC9FOWd4+j1B9TFJDwjlo4UKehTFoO9o8/+EFjlB9XwVZwE4rGv+1z/DTUTbtOfUHwN6wa0cdt+JujMazzD609RY0gHVv5JPtDF5z+nyT9B/VheJbKJf4anMCv88/AiBoQ26okO43Nd/zKKZP90Fe3Cr6lQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BkKyFXdK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e29555a1b2so810087a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728463825; x=1729068625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OyEUM3ayYo8115Z625s6QVnBUkxirDaFIlKShu8dWI=;
        b=BkKyFXdKnzTwSODVnrUZ9KZs5PV2yjy1U+YghK1tXiqdomwke9sG7Rz010392Phqy5
         rhj+KgThMfc+yCb8X6zFjGhYnP+F11XKGqbmutPYVAoBQjEp1b0X/GNBD/0Iw86tjhZk
         ROSmne5QdJqqKx+rzO9SQjkjYb/8OADJpE1+1WXjY+Nbd+0p/vlIfoS7bWwGq3UU3ljp
         3sq7bPOk8Ytyclf1wicG1EILMiZ8wvZ9iX/H3n49xTicvS2nUXJQtPt37w/56Xes1hli
         a+CX4h51OtOwnaL+a4Q7RuwXg2dn7WHOxjSDCNdeVkCLtLexNIIgM3U0sjpd8k9g4jc3
         705w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463825; x=1729068625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OyEUM3ayYo8115Z625s6QVnBUkxirDaFIlKShu8dWI=;
        b=CELZKbJSn/CDu+urwuNPkIZFbdUz0fOrFEOkfTCh04/+IxY+g9ELnGlMbu3mQgvS0/
         X6ThAKhuATa9DvRu5VglPZukR4WhaQuZUBL8JjJPPKhbt5VYnETYHN/VAgrFq/KUuN04
         Bf3h5GRuDg7oeccSpGwO6a7WlwkK3lPBDz+/jqabg9YCL8Kq6zfYAAhHPLodKGW+9xbP
         lpIDxl20y//FGbn9s17gkDo/cyCa98mm2jSIB2tZXl8FyWGKiW3imTWewtJGsadTatMF
         KEVSryyP4QDnswtfxeqTMMoa5Wa9rKbMxtUy+f2RWnqniDGhIYM3VY3ANxhKN0kDM+2E
         t7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVlx/WuSEJ4DfuKUiW9HE007iDYB8GdVtzeh7xhMXlTaNqSu6biTw4oE1WLSjO4IZ7jzdbkuMSOyu1yS1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDuSbdUwFLeUzJ36qhmsdZzVZMixE8SLhAfCmw2J3VEStXltm
	Hj5RINmnBUWb2w804ZUyLTU6cu9IZ8uL1igiY5YIuhYtGsNeOv3OgHMq35igFrEZErfjxgbHHDm
	FL9R91w==
X-Google-Smtp-Source: AGHT+IEi7ccLOgI20JoLj/kcBWBw13/ExjkVwWKywTKVTU9eWF12FpV2TM3Gltp794cZr9uzgadrLg==
X-Received: by 2002:a17:90a:8a04:b0:2e2:bd4b:ac2c with SMTP id 98e67ed59e1d1-2e2bd4bacdfmr3881a91.31.1728463825310;
        Wed, 09 Oct 2024 01:50:25 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2abad236esm898157a91.10.2024.10.09.01.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:50:25 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v2 00/14] drm/msm/dpu: Support quad pipe with dual-DSI
Date: Wed, 09 Oct 2024 16:50:13 +0800
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMVDBmcC/x2NQQqDMBAAvyJ77sJm0bT2K6WH1Kx1D9E0q1IQ/
 97Q48Awc4BJUTG4NwcU2dV0mSvwpYFhCvNbUGNlYOLWEfVo6eY7wt2jcziliHkZRkzRDD9biLh
 lW4uEhOyq0XJHV9/zK0At5iKjfv+3x/M8f677qxR9AAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728463820; l=3537;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=XuK8SW++hJbjdzuyT7G+3SNIautCdVNCl8sCs8qP274=;
 b=ypkLgaejJJBfn8jsdKs5HuLSGpjaaUfbXDqk4/kz6wm2nHJj7vcUY3P8taEhMblC4agtxfgWQ
 Azg2zfY8HxMATfMLlvCfmkvT4cBepPS1zuDt+iWQaLiu/jHWkCI5hpA
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=


---
2 or more SSPPs and dual-DSI interface are need for super wide DSI panel.
And 4 DSC are prefered for power optimal in this case. This patch set
extend number of pipes to 4 and revise related mixer blending logic
to support quad pipe.  All these changes depends on the virtual plane
feature to split a super wide drm plane horizontally into 2 or more sub
clip. Thus DMA of multiple SSPPs can share the effort of fetching the
whole drm plane.

The first pipe pair co-work with the first mixer pair to cover the left
half of screen and 2nd pair of pipes and mixers are for the right half
of screen. If a plane is only for the right half of screen, only one
or two of pipes in the 2nd pipe pair are valid, and no SSPP or mixer is
assinged for invalid pipe.

For those panel that does not require quad-pipe, only 1 or 2 pipes in
the 1st pipe pair will be used. There is no concept of right half of
screen.

For legacy non virtual plane mode, the first 1 or 2 pipes are used for
the single SSPP and its multi-rect mode.

This patch set depends on virtual plane patch set v5 and flexible
number of DSC patch set:
https://patchwork.freedesktop.org/series/135456/

Changes in v2:
- Revise the patch sequence with changing to 2 pipes topology first. Then
  prepare for quad-pipe setup, then enable quad-pipe at last.
- Link to v1: https://lore.kernel.org/all/20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org/

Signed-off-by: Jun Nie <jun.nie@linaro.org>

---
Jun Nie (14):
      drm/msm/dpu: polish log for resource allocation
      drm/msm/dpu: decide right side per last bit
      drm/msm/dpu: fix mixer number counter on allocation
      drm/msm/dpu: switch RM to use crtc_id rather than enc_id for allocation
      drm/msm/dpu: handle pipes as array
      drm/msm/dpu: split PIPES_PER_STAGE definition per plane and mixer
      drm/msm/dpu: bind correct pingpong for quad pipe
      drm/msm/dpu: update mixer number info earlier
      drm/msm/dpu: blend pipes per mixer pairs config
      drm/msm/dpu: Support quad-pipe in SSPP checking
      drm/msm/dpu: Share SSPP info for multi-rect case
      drm/msm/dpu: support plane splitting in quad-pipe case
      drm/msm/dpu: support SSPP assignment for quad-pipe case
      drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI case

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         |  74 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      |  69 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c       |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h       |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h      |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h          |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c        | 408 +++++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h        |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c           | 210 ++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h           |  19 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h        |  10 +-
 15 files changed, 478 insertions(+), 364 deletions(-)
---
base-commit: eac5b436019c2eeb005f7bdf3ca29d5e8f443d67
change-id: 20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-1142507692ba

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>


