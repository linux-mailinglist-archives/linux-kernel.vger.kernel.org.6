Return-Path: <linux-kernel+bounces-441320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9799ECCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B60167BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171C22C351;
	Wed, 11 Dec 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENcVuwxW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D522B598
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922277; cv=none; b=OI3CfIhlD5UKKNhjIiXNzajbJDwjA9bPL2F+1sQy0KfyCnvBx8mIulizv6A3ZaQ5dJ5H8kfAV6RIGNN7lkNvtzzeXKdkkXXkDbpFPzGb9JCiQZUdkGVkh8ZpLCcfzeSh5V+GKGx2TZhxrz3Y7FYVj0i8eS3/Nf+vuOPw2ldLS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922277; c=relaxed/simple;
	bh=+kjpSyZKMfYDv7GSGvBVLk0oNBwdg69xxssowfQbXBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGdu3neqQ1hpKqW8B0ud2AiGHUWdo6TYfeQVF/d0T1G2X0pLHVRKdba19ZWsPkbG8XW31l4EqTzRW7CwNI0eT3d7GvuX3yG5cU2JXsa7Pna1S73B8m3SR8BImKZaQV3H3an9hMasP0jxLzi0EwTouYobv7CRiFDrBfAoNan/X98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ENcVuwxW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3258820f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922273; x=1734527073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vcNvdRQck5PexrgH0iivqnvEVdJtfPxrI2rBVxQcFQ=;
        b=ENcVuwxWygpygZ7fbHK0Zw0hhyVlQ5X8Izs+U4N70ZAMeosjwYJQ6EAa/yVLZYpr3o
         idtIXaYt6uXdIGTHqzGNu6x3zmypMpufZ9Mbtu8HGXV/YgdZw0sD4XdlTXlPtsfmB3sP
         FGwHh+T/jTNE3p7FiZ1e+FqqNn87AJ7IWa+eaFEhS9XHa4lb92lpABPBSDCPJKfqmoW1
         Ahkk6OOtCPv3RQwzoHrcvVfncrqKrTWMVFNNI6TZWtPyqtXVCm/SgBAXiRjxJB6cEfdl
         4QQuobRz5JhHuvCqGoVcP4dSweZaS+/aSMcZiqEUPGHb33owbY61C/kjQf13K2ByvMut
         uV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922273; x=1734527073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vcNvdRQck5PexrgH0iivqnvEVdJtfPxrI2rBVxQcFQ=;
        b=poIFgvHDXlk8ZdJXN2dMHPX1C/fpKZL/RT8L5gshZvtNedLvTiibfH/61yWamBSSlS
         4OC84/mp+yYt6Lntqda8K/sV+NyfvKxhkeYuwPx+5E3Rad6PteySahXS9qFx3VCM4IgZ
         boR2NBH5+G8dYpI6Z6yqCo+djkb7ckm3mTGVhsTyTRKZMKbO7o9ttoZ9PzJXfri/r7vm
         0u7HLrFuXOZ6xrnvveT2uuz8XbEMhhNFjSce0dj/HSkucB97pxsRawo4BITzVVEKn5X4
         jrkbKOVhgO5mkV+UJh5JPc8o1nOZed9u8lUbfMB3gKAiSymjvB43iBh2HWvKFgg3f3t1
         ifSw==
X-Forwarded-Encrypted: i=1; AJvYcCUAjOSvO0zcHndqXna21372ZV6AEWkhFSil25Le7O5lxAVV6ZLRUk1O0mUWaolWJ8Sa7NHldVuxDlW0Hf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5awEreus0G8aJhWA906Re5v6FGcIgpJxvByKEWuGelXJb5PJT
	KxC2ljz6ItK9+eHUhk+ujUXiHwbZbYm43Lv7U1TnZkWN5ALbhS9oh0dw3cRD3Aw=
X-Gm-Gg: ASbGncsAr2ajj7fcDK5xH14zQnM+BYtJhGgVDM/e1DLvv9cviiE8DGTvue7l1XBxETk
	OBff/0NI1oAReEVHxIOmiZJK8ld2zp3yNhUhQNyKkYE3zZReWz5ngDH/Ffps029yh/pVYMdxyDS
	7mj68Wka92h7KBkvw3H/JYEk+A2bq9OQQGg3CeNztHFW+lHkU+f0y3U7+ftDrA2TPnD/t5bDn8U
	EbmuErV/PrpO22Mn4+apG+wZBU9S9K0D9fS5H7ykD3nO8nfjjX0kw==
X-Google-Smtp-Source: AGHT+IHGNMAtT86/Ll/waDUhwZx90OxCs6KJuTJWJULw9nEvrDR6OYRpOHWgU0GB0l6D/LQb2iNCOw==
X-Received: by 2002:a05:6000:2a3:b0:385:f6b9:e762 with SMTP id ffacd0b85a97d-3864cec3a86mr2328956f8f.36.1733922272749;
        Wed, 11 Dec 2024 05:04:32 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e633sm1288081f8f.4.2024.12.11.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:04:32 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 11 Dec 2024 15:04:13 +0200
Subject: [PATCH v2 2/4] drm/nouveau/dp: Use the generic helper to control
 LTTPR transparent mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-2-d5906ed38b28@linaro.org>
References: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
In-Reply-To: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=+kjpSyZKMfYDv7GSGvBVLk0oNBwdg69xxssowfQbXBQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnWY3WaTT+6VyZh/3rm82/2TydUPnkTOBrLlbTe
 +haYEToEU6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ1mN1gAKCRAbX0TJAJUV
 Vv+EEAC/mhtx4BAo7l+Gpv7VfDJluKQ2IVW2JLA7gcOtRG3KrQ2/7TWoudUHdxCdj7ntdS+AnsM
 clIT7XQej+oMg6vOX1ZCXxtpgnAEUw6dZpkmhzOYWol6pF2ijiTaabFDaE4hxbjS09E5UrRZM7L
 E9wBLGyv24EGZgibP130Ecc9BM9ssTSQedas/qKUgRrrggCoyv2M4Jp6NRpSNuun+whR+CXSMT9
 kxLmdTXL2xT7zAKn2sZcwW/AmK4HYFCFvctGDBadMaiVeHuxGmZJ5iZ2hM1n7bJVw6YXz8p0f/C
 KxyW7r1DTixUkJgcrtKAkeiM+DmuWpfenRgJjbc7FlA6jh01UD/kbm1l3sYNjpmQpIML0BDirLI
 uZ5gbyQ8/zrV3uJpS9ZT5p1SontVtUSOh+PZhGnB3y8cYILLJbxLw1BiljIx9OtFy1d7gSUsJtd
 6MCwPHrB6gUSO608/zFBFJQTuBU4S/xPoKqtEJ1WORQ3QEsF5K5LGTbLeZWedVe24NDrFrKlqbl
 yI5lqEJ/KYUB/ecDm7+9AnH/8At1uJUrzKPhY+MCdOyZNR4zr56pMxHGPqyZWgvQPFvC3UibWrI
 PpQg/dk4ZYkrxuDOet/C0VL4bGZMh1CxyUhO5OyuCK8MP16O/ETSv+MgSpzUrkRtUS87sATbAz3
 05z8rijWelGI5Ng==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

LTTPRs operating modes are defined by the DisplayPort standard and the
generic framework now provides a helper to switch between them, which
is handling the explicit disabling of non-transparent mode and its
disable->enable sequence mentioned in the DP Standard v2.0 section
3.6.6.1.

So use the new drm generic helper instead as it makes the code a bit
cleaner.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index bcda0105160f1450df855281e0d932606a5095dd..55691ec44abaa53c84e73358e33df1949bb1e35c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -79,21 +79,8 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
 	    !drm_dp_read_lttpr_common_caps(aux, dpcd, outp->dp.lttpr.caps)) {
 		int nr = drm_dp_lttpr_count(outp->dp.lttpr.caps);
 
-		if (nr) {
-			drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE,
-						DP_PHY_REPEATER_MODE_TRANSPARENT);
-
-			if (nr > 0) {
-				ret = drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE,
-							      DP_PHY_REPEATER_MODE_NON_TRANSPARENT);
-				if (ret != 1) {
-					drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE,
-								DP_PHY_REPEATER_MODE_TRANSPARENT);
-				} else {
-					outp->dp.lttpr.nr = nr;
-				}
-			}
-		}
+		if (!drm_dp_lttpr_init(aux, nr))
+			outp->dp.lttpr.nr = nr;
 	}
 
 	ret = drm_dp_read_dpcd_caps(aux, dpcd);

-- 
2.34.1


