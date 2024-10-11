Return-Path: <linux-kernel+bounces-360524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C6999C11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E11F218D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514B1F9401;
	Fri, 11 Oct 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="HAGQ+XYF"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320319B5B2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624267; cv=none; b=cCozaF5MSUJUq0cPX4zPRs5mB3S3PaeIfex//3NalyL1/9zNOAm4OxZ+mbtPQ4nk56uT8FLalpzaRvflCFzdqGBhSrqw2OGhzaAuhpp2k7ePdtVP2xyM5GgP3Ff2zx5OLTi1PxEmaOOZCb73du2kSXZ3JvSsyPtoHyjcO4Kr4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624267; c=relaxed/simple;
	bh=Eu5/Sx/8t4BbSYZ/Y0H81EOkKHldJwz4fE4MOrm/MkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T73iG0uj7TQnZ8cs5W8aSBgV7botVanld60ktHiMQlXE4fPVnjvlg8bM9GqNeD8GF0vwd4l7qxXFgQ0oqUmzoJdeRkFQhnrTW1PSzUEWTbHu/mbB63JzlmRl7aCbekm2gwidEiCZIQVz0dHJH55VeeGk5m/EWqwDmZay6nxGhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=HAGQ+XYF; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso159614a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728624265; x=1729229065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BGOKIsMg4QP3m6tKk3FDK1aa5VlkpqPKb0X90CWsAo=;
        b=HAGQ+XYFbq7tdQ3f25KCFGUKTML1YKfvlNBrxAbzIzN0eSPhMj6bPHzuOgRlkLTl0s
         smTxTYskW6Bc+jaOq3xjXhrm+g7ZftDTYV44sbA48NYU5Xwd2PTw+7QLIm1ch8yrqt0W
         OQE6FWSTxj+HDgx+QQ0oi/z03yzy2WGDZvJU+TrwdmfPt3CJQ7V1WncYYGHfojc8YvPF
         KzISOqvQ6601/hhLS1rO9DfvDBJyWOUiOI798vKGPMu5xJo6ljPyW705qZo+KomK5eIq
         5ATbBdVHc0mNUtDqZ7dc4PSL1hCGaZpgGenUovu12+h/ZYdI18PfNFT7ipjqwD+u+XIU
         0y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624265; x=1729229065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BGOKIsMg4QP3m6tKk3FDK1aa5VlkpqPKb0X90CWsAo=;
        b=ibKOUGI2fY0uAR12OEtGJ+eGNJ9EuAGLBbDgsdH4uQAbme1Va9q+rVolxkUGXGRTnt
         IYiTqFIZkIa0HZu6cv5F8TO1joVDETViw58DYKvWIArN9NqQ+SF3V5oHkkinpigPWAOB
         92NmUnC+JBtYb0R9MZvoZq3V2W65JzHK+/ZQzBKZrlcztJZTVenz8UtXCYu2hPRqndFa
         nyFsVwzJMx45sUcDAWnQoTXCanZDt1vWkhwnV89OfuXFdDMM5jhrCobeyDFSdkjJtpjX
         bGqk+Y5MgdvuC2eBUs719JOXK6EZkndILtHifEeaNVYJYQfygOE64sIVW9RxhemcidDp
         sr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6e4RCBYVZa625Far+ZRQW83IGh6QMecZpQcUI7P6quDmvrQNtfKUgc/2ZzXxayQ49GVwYFqxiQnmSt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/5UZJoC7wwInfeUn84LUVZt89hkoPtsCPoVKD4EItAvZCcq9
	40GcQOHIRFOLIx7iznmTthqUnbxT7dc7BVofq/ylyjVrHnNH3lr1dXdgLtHJmw4=
X-Google-Smtp-Source: AGHT+IH//kLRhYfrjYGsfIlcKbHS3xoQNKhRAMnMq31mnsU+jdE6aFHUT5rih9UTGv4Vs6virTNbVA==
X-Received: by 2002:a17:90b:3844:b0:2e2:8472:c350 with SMTP id 98e67ed59e1d1-2e2f0ad156dmr2213900a91.17.1728624265466;
        Thu, 10 Oct 2024 22:24:25 -0700 (PDT)
Received: from localhost.localdomain ([91.196.220.222])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e2d5df1133sm2380070a91.15.2024.10.10.22.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:24:24 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: robdclark@gmail.com,
	sean@poorly.run,
	konradybcio@kernel.org,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@linaro.org,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/msm/a6xx: Remove logically deadcode in a6xx_preempt.c
Date: Thu, 10 Oct 2024 23:23:14 -0600
Message-ID: <20241011052315.4713-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ternary operator never returns -1 as `ring` will never be NULL.
Thus, the ternary operator is not needed.
Fix this by removing the ternary operation and only including the
value it will return when the `ring` is not NULL.

This was reported by Coverity Scan.
https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600286

Fixes: 35d36dc1692f ("drm/msm/a6xx: Add traces for preemption")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 6803d5af60cc..2fd4e39f618f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -297,8 +297,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	 */
 	ring->restore_wptr = false;
 
-	trace_msm_gpu_preemption_trigger(a6xx_gpu->cur_ring->id,
-		ring ? ring->id : -1);
+	trace_msm_gpu_preemption_trigger(a6xx_gpu->cur_ring->id, ring->id);
 
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 
-- 
2.43.0


