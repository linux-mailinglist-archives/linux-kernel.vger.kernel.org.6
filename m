Return-Path: <linux-kernel+bounces-441317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D670C9ECCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628BC1888DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26EC225A56;
	Wed, 11 Dec 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrXAGdAz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599731DC9B9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922272; cv=none; b=tbkIIp+OlEOT+YDa2mxE/4FO4GjVjfRJvW7j3I7qSXpdyySU2logaXtwVFLvO/8ugizObxaRN2PF4HjZSGtUsG8QwKBFi+6JTX+Mi0FedU4bsJYepbOgc2lPMn6IVY1E7MUJ22j7zdnWtgq8460r5yMX7+A06vDZUtC1/0IbGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922272; c=relaxed/simple;
	bh=4SL3oSOYfNGgaeWhz9HDRuhRuGic1VpdSQb4rkQTyyA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L7PzdT7Y1PXLYdZdJKY7GeKPGTqwqNIpLeJeSwc5tdQWm5VsCyGduHLk34NFIPmF7q8vHDZNHIL4AEF7n9BaLUdn9BBTMbEIcKGESFNkpTJ+N3hS+8h9fS/kOtUnnE1sU1u3tLIogL9Hrk+7PiiQ2WU9kN9VzeW6isf069MaZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrXAGdAz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f664af5so5043715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922268; x=1734527068; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YpUlzLd4DTvOwWsmuqzajXz424W9CnL0q6rjmHsBkGw=;
        b=rrXAGdAzm3P3ovdEkazsw2XoQLRZQS+kwsJODNpH0QrfD33s56TnQHZJlUG2e3NocE
         HTiHqTikUputEM/DcaKSPkHQyRi0bmuK7rI/YUZN3tWz8jij6OvkWZCLKP+UKfuDpBjo
         9LPOKY1EWArrDh5VAHqQ/f/cNHKQIN+lDGXRFb9eJQWYhZZOocGG2pBKqJAxeRHW39dH
         2k75h7XitelAS78wEin43vAQIffSniRPHW07weM6BIhIDROFnBPukXXHrQhOaG4SlxGW
         +81jyeUGddINadjKLGNylBW5Rv7FEM/wzC1VeMDddf4Ktu8Palb6bV+l85vIaYiExple
         rddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922269; x=1734527069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpUlzLd4DTvOwWsmuqzajXz424W9CnL0q6rjmHsBkGw=;
        b=fGc9AU7FGk78QLSgQ0nZ9upTKy8Zt/C++JxSpkFuOxr4+k2FTjM3F6AARK+UCx3Wa6
         c6/8TCg6W9jbfkqGRlB6mT0te/0brVXGfA/0HVHZTvVRTvW5P/5uLU8Bx66jUJTdC0jz
         fVWGuw9hjlo3kCT0O8Tt/Vsj/sskh2l4b0UFRGvVxOmUQqezNKqesHW03B3mYolipFVc
         IxOgmUSLv7p3EPouuQ18vTiSNjNd2/uDhFQtfcgUkAYrEUMS6zeFG25ioAq1ZdvGIe8X
         u20wU593WpBkoauSzrbnvTeFyOBQl8hqgq34L3swaPX8SB5bdLvJ9Cmg2NqEb+3cdFLz
         u4yA==
X-Forwarded-Encrypted: i=1; AJvYcCWxPjvtc6WrUFT2jgP3X4001l0LvBzQ7i9ABj3mvU9ncSioum/4kRtbblt/uK1mJvZrmKT1SZSkvy6PXo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ShW5NGm7UHQ2nqf3Yk9OqqpQmhUBw3FzLzmW4jK1oqPIf+Fs
	VSD+56vLVLdDUh6vD6sOn0vkgcEzSX0TsMvS3Sp7xhcSiEOONYarCt1pCOtZT1w=
X-Gm-Gg: ASbGncuNaYKHLUqTBaTCp1+JJRSkSXut78jhV7RR2p2ELAgJ6GisKan3weTJn8Zd0NO
	nQkkTLNux/4njU11WO/zPyvfVmwqEWojdEMwsff6MaD60lZ3GCkRGDAOg/H8WxeUiLQn87Cb1pr
	3iOX+7fXeig393+UfD2PkctzGVlzAqbwG/+ROZZAGPqKn5lb+WuxnIwo5erqeW8CzDnLOXsEzqJ
	6Devdfje/PoPf2/rWQIDi8Va45Y+kfnUJuI9OD6Ti6rChJksUqbFQ==
X-Google-Smtp-Source: AGHT+IGPWcM8yhYn2nQJ26y7MGhayOqx4M0waL4G4OgaFUlHH0NcR4gyX+40Z605D2RCeHuL57tWCQ==
X-Received: by 2002:a05:600c:5122:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-4361c393b80mr20312535e9.5.1733922268551;
        Wed, 11 Dec 2024 05:04:28 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e633sm1288081f8f.4.2024.12.11.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:04:27 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/4] drm/dp: Rework LTTPR transparent mode handling and
 add support to msm driver
Date: Wed, 11 Dec 2024 15:04:11 +0200
Message-Id: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMuNWWcC/53NOQ6DMBCF4asg15nIZslW5R4RhWHGYAkvGlsoE
 eLucThCyv8V79tEIraUxKPaBNNqkw2+RH2qxDhrPxFYLC1qWbdKNgqQHWAElxxoRFhyjgyZtU9
 RM/kMLiBBogyquYzYDQZJXkX5i0zGvg/r1ZeebcqBPwe9qt/6j7IqkDBqMwz3W9eZVj4X6zWHc
 +BJ9Pu+fwHZAlYD4wAAAA==
X-Change-ID: 20241031-drm-dp-msm-add-lttpr-transparent-mode-set-136cd5bfde07
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2672; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4SL3oSOYfNGgaeWhz9HDRuhRuGic1VpdSQb4rkQTyyA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnWY3PEZV7dIYTv5NvvJXM3bZDVMPWNYimil7AK
 wt2J3+5kbiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ1mNzwAKCRAbX0TJAJUV
 Vo+dD/4p2AWAAkQ6OSPj6dUqNsHrnpSa3jbwEi3CcIbbOwg6w5LxgpXI1osFK7ghd4bn6Ig6n5S
 pkj3wHywKPBCxJWqi7jKnnXgs4PPIqNxpCHODl3GGC0ezCO/PxMQoWLEJk3U1iqzMAQ8s07ZYk8
 eKoLR0VebD1mor9uLs/eXYrB29VgU0MNkN5fs+BEGX6nsuBgwbdM3GmYtUPTLkEfEOi22PHwVS4
 gDPbedPBwC5WMRxSa8EdC7qa20EENKBjYe+FyaV6eeFmRvLeBfVTy9VPrkEHNz5LEsHtBwZHCPs
 RxzQCDlf68mEMVviyJdoDZAW89YbVdYIzast2OTufD+bjaHiIVMe9jnCrJ66jiISmBR/YbtkC37
 Xi3KfJgqkohhzIxprEkUZfWGQcz/OnGu5jWK1SvNA7gvBIFKoiLWEsBLqspRundFegj1qn9x1+u
 kflAoK89iwBD29SohLCrpT7nZjXFMnav0IzlAYtHm8nkrLhgQyBa4OmzGf2In0itA2XPtPLZJHT
 dLANf/svi+j8riF7VblBUUzP2+UWOrSR+NyFXKT+Doeo8vHdqHXYOpnh5u+ONAM2RYVy7fp+zEj
 H+q2xUnOn+t8VXv+cYKRkUi4CNeG251xYVZBGERrDrq19e/P5l3Og1mTiByzs6/33xy/qkECKYM
 ZLJitm6X2eAAmrA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Looking at both i915 and nouveau DP drivers, both are setting the first
LTTPR (if found) in transparent mode first and then in non-transparent
mode, just like the DP v2.0 specification mentions in section 3.6.6.1.

Being part of the standard, setting the LTTPR in a specific operation mode
can be easily moved in the generic framework. So do that by adding a new
helper.

Then, the msm DP driver is lacking any kind of support for LTTPR handling,
so add it by reading the LTTPR caps for figuring out the number of LTTPRs
found on plug detect and then do exactly what the i915 and nouveau drivers
do with respect to toggling through operating modes, just like the
up-mentioned section from DP spec describes.

At some point, link training per sub-segment will probably be needed, but
for now, toggling the operating modes seems to be enough at least for the
X Elite-based platforms that this patchset has been tested on.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Added new wrapper over the set_transparent new helper in order to
  move the non-transparent disable and the its enable->disable sequence
  mentioned in the DP standard section 3.6.6.1 entirely in the generic
  implemetation.
- Switch all 3 drivers to use the new wrapper.
- Fixed the return value of the helper to return 0 on success and
  negative value on error.
- Added explanation about the transparent/non-transparent modes into the
  msm dp commit message.
- Dropped the condition for non-eDP in msm DP driver since it is allowed
  to try to get the number of LTTPRs even on eDP and it will be always
  0 anyway.
- Dropped the RFC prefix
- Link to v1: https://lore.kernel.org/r/20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-0-cafbb9855f40@linaro.org

---
Abel Vesa (4):
      drm/dp: Add helper to set LTTPRs in transparent mode
      drm/nouveau/dp: Use the generic helper to control LTTPR transparent mode
      drm/i915/dp: Use the generic helper to control LTTPR transparent mode
      drm/msm/dp: Add support for LTTPR handling

 drivers/gpu/drm/display/drm_dp_helper.c            | 50 ++++++++++++++++++++++
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 24 +++--------
 drivers/gpu/drm/msm/dp/dp_display.c                | 17 ++++++++
 drivers/gpu/drm/nouveau/nouveau_dp.c               | 17 +-------
 include/drm/display/drm_dp_helper.h                |  2 +
 5 files changed, 76 insertions(+), 34 deletions(-)
---
base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07
change-id: 20241031-drm-dp-msm-add-lttpr-transparent-mode-set-136cd5bfde07

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


