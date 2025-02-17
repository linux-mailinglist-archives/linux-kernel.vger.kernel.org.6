Return-Path: <linux-kernel+bounces-517486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C2A3817B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252BF3A2668
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B010217712;
	Mon, 17 Feb 2025 11:18:04 +0000 (UTC)
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1354212B3E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791083; cv=none; b=ZuzFIDNkjlBOzWsGPxjL4lHn3T/XXRA0lPsGBPlGy+C+ERK7o81PsXpqcW1xLEoTRT5CLQ81bOL0lfbsaANaRTVSn281RL2z8O+7PqqVkqrUQ8Gl5+mSwVwxE7M4fW03LVTNDi9HM5N4HFE9tvqeOFU901KaNEdmg3eyIsaFOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791083; c=relaxed/simple;
	bh=XlYKleX94y6B66dSSrT2H1qCHvUu0eQ2CYD3wdZHzm4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qC3Aa2UpQOdflsRsGaQJeixZPjEcYF1FuEKNDHY4dM7bFYOw1/W6mlcM0A8TN5YDXTAc9BWGN1uRS4SByX5AAojto97asHnUYdDIBqh0hs7XveDl5ziBUdtMtJJcXqdc/wWDJoe4JQg11OoYsUU2VEYHgvGbBznSIAylXr/paWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 664A71F784;
	Mon, 17 Feb 2025 12:17:52 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v3 0/3] drm/msm: Initial fixes for DUALPIPE (+DSC) topology
Date: Mon, 17 Feb 2025 12:17:40 +0100
Message-Id: <20250217-drm-msm-initial-dualpipe-dsc-fixes-v3-0-913100d6103f@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQas2cC/43QzW7DIAwH8FeJOM8TEL4STdPeY9qBBtMihZBBG
 q2q+u4jqXrZLr1hLP1s/6+kYA5YSN9cScY1lJCmWrQvDRlOdjoiBFdrwikXVDAFLkeIJUKYwhL
 sCO5sxznMCK4M4MMPFmg91UweaHvwglRozrg3qvP5VetTKEvKl33myrbfB6+f4VcGFLSx2CJ2V
 nX6o6RowzSGCV9TPpJtxsofrqScdk+5vLoVpMwI74ZW/XNv92Myfp9rUMv9IhKxFLsH1Tdv+0D
 GObj5DIwxWNKcxnS8bDwDSSV2slPC+u4P/75FdbAFYUgxhqVv0EnjGG1ROcukFYJ7b7RU2nRGK
 1NXtErVZ13s9gu/pSb2yQEAAA==
X-Change-ID: 20240416-drm-msm-initial-dualpipe-dsc-fixes-3f0715b03bf4
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Archit Taneja <architt@codeaurora.org>, 
 Hai Li <hali@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jordan Crouse <jordan@cosmicpenguin.net>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3328;
 i=marijn.suijten@somainline.org; h=from:subject:message-id;
 bh=XlYKleX94y6B66dSSrT2H1qCHvUu0eQ2CYD3wdZHzm4=;
 b=owEBbQKS/ZANAwAIAfFi0jHH5IZ2AcsmYgBnsxrfcr9CYslQNi/zZFAiBjHbrUr4GF+oa/EUK
 iAVRzHzeCyJAjMEAAEIAB0WIQROiwG5pb6la1/WZxbxYtIxx+SGdgUCZ7Ma3wAKCRDxYtIxx+SG
 duhXD/4gXtpsLfvjMzmOIHqN/Zv2OqY0dRVcboIQIYcdpzRrMREfIwRUyqqkBzwf+qsjgNnBlvH
 YoGrVBOWgoNMscgxFGV1FQDtzqb7h50V6JI2ojvBvBag4IoByJwPMvuIZ9nzcn93BbcteHSUek8
 Wz09Ks4EgC5pXQwH7MC5ZIjfPazGP1CqvHDrGAv6u5Fgmofk+G5pqaCS7GvUEQ09riEtrPLh04l
 lBdC1MjREMk1qCXFVzdCWRG1K7eaIX6tSahgdI07VzCqYb3zCrNPSZ9ZFA7WMNFEvDesWh2bYgx
 yIsTrvThd/FFX8GQ2NNS+da+Yk9CCRyMJvrIOzQZC/qLelstds+D8dik/NL4TmNL2sNnvcoqBfV
 0vGGAQlgJh1NLXJ7fQkiNAU+cPKFBPebtmmtt5ENjS9xZvkt6C6MQ7x4a2pEaCcUjgE14KQi4i6
 jdEiSitQJc1oDBIl5gVQ9rIibD7djr4cTD6xIVPektqkum9ReXwe2pKOIZTrPw+d4N8xQoxwWAZ
 cwpMHt40AaXIlk4BSbDShyGHj0A2b6K7SL6JT+8+hP8h/45ldHWb17JWK52bbQrWMAylFGKzUX6
 1XLIknD3t13ZJ4iehPlsnsWSQg/jgZJhbM00zNfEMe6QK0L4joa4opzELj9mChTJU7MyWBFARml
 Ft/t1hSHSQYORTg==
X-Developer-Key: i=marijn.suijten@somainline.org; a=openpgp;
 fpr=4E8B01B9A5BEA56B5FD66716F162D231C7E48676

This series covers a step-up towards supporting the DUALPIPE DSC
topology, also known as 2:2:2 topology (on active-CTL hardware).  It
involves 2 layer mixers, 2 DSC compression encoders, and 2 interfaces
(on DSI, this is called bonded-DSI) where bandwidth constraints (e.g. 4k
panels at 120Hz) require two interfaces to transmit pixel data.

Enabling this topology will be hard(er) than downstream as hacking a
layout type in DTS won't be describing the hardware, but "dynamically"
determining it at runtime may pose some of a challenge that is left to a
future series.  Such changes will also involve the 1:1:1 topology needed
for constrained hardware like the Fairphone 5 on SC7280 with access to
only one DSC encoder and thus ruled out of the current 2:2:1 topology.

Likewise, the patches and discussions around improving active-CTL
configuration to support bonded interfaces (that share a single CTL
block) are still in full swing and hence elided from this series, apart
from one patch to fix the ACTIVE_DSC register coding to support updates,
so that it is not forgotten about.

This issue and successful resolution of all the problems is discussed
and demonstrated in https://gitlab.freedesktop.org/drm/msm/-/issues/41.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
Changes in v3:
- Removed start of multiline comment inside another comment
  (editor detritus from merging two comments in v2);
- Inserted empty newline after the start of multi-line comments (per
  kernel coding style).
- Link to v2: https://lore.kernel.org/r/20250209-drm-msm-initial-dualpipe-dsc-fixes-v2-0-9a60184fdc36@somainline.org

Changes in v2:
- Dropped patches that were applied;
- dsi_mgr_setup_components() now sets both the usecase and phy_mode
  prior to calling msm_dsi_host_register(), and for non-bonded too;
- Added patch to remove a forced num_intf = 1 when DSC is enabled;
- Reworked hdisplay/2 "fix" when calculating "DSC timing" to instead use
  dsc->slice_count, allowing us to remove msm_dsc_get_slices_per_intf()
  entirely;
- Link to v1: https://lore.kernel.org/r/20240417-drm-msm-initial-dualpipe-dsc-fixes-v1-0-78ae3ee9a697@somainline.org

Depends on:
- https://lore.kernel.org/linux-arm-msm/20250122-dpu-111-topology-v2-1-505e95964af9@somainline.org/
  (only to prevent conflicts with the patch that removes a hardcoded
   num_intf = 1;).

---
Marijn Suijten (3):
      drm/msm/dsi: Use existing per-interface slice count in DSC timing
      drm/msm/dsi: Set PHY usescase (and mode) before registering DSI host
      drm/msm/dpu: Remove arbitrary limit of 1 interface in DSC topology

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  7 ++++---
 drivers/gpu/drm/msm/dsi/dsi_host.c          |  8 ++++----
 drivers/gpu/drm/msm/dsi/dsi_manager.c       | 32 +++++++++++++++++++----------
 drivers/gpu/drm/msm/msm_dsc_helper.h        | 11 ----------
 4 files changed, 29 insertions(+), 29 deletions(-)
---
base-commit: ed58d103e6da15a442ff87567898768dc3a66987
change-id: 20240416-drm-msm-initial-dualpipe-dsc-fixes-3f0715b03bf4
prerequisite-message-id: <20250122-dpu-111-topology-v2-1-505e95964af9@somainline.org>
prerequisite-patch-id: 9ed44ae089b173f452a6603e6739b0b3bf2d9274

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>


