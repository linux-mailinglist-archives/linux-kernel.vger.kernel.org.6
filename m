Return-Path: <linux-kernel+bounces-328376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47565978299
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B6284BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0317C64;
	Fri, 13 Sep 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKYhLYR3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEE1A269
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238103; cv=none; b=ERsT/L2ozknGK4rQM5hYCXUSZ6+6SveOuwH03tlRsw4OMXxpRC7Pxvy462tfLtgLYr6NOiA/+lekaoFNijErIBuy5UtpGfF00zt2fSWpu76YbTtNC18VbSc3ykbtP7oihiHziYtoWtzTFmgW0He8pJJUfRd0G7JpcSl0+mF/yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238103; c=relaxed/simple;
	bh=3ELOloAX6onr0kSBIqXF0Gy4XUjDOYml68qqMcjO/Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l2ZCM/JikPGCHIjkZJY9Scu2aCvAWN/8OKTFs/fX54IOqqAEj2Lxeht2VDujXy3dI0AScMpHkJAwvELcW74cDpF0r/L8LTWYcWdV0q20QSP2W2k7k9Lb5eg4b+DbHFILAr9/Dw0SGEvqjeBppGBe971ECf7AUUcxny8LeBJAu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKYhLYR3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365cc68efaso2419843e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726238099; x=1726842899; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOZr+XBM5WUt/TfPaFfV5hj8BjCZLS7DmNzXffMIGd4=;
        b=tKYhLYR3mQ+/XuW8uk/ZCfFtCe2FGj5ADWQqw92fsgttVhh7MJ/M16465IDfYENOT4
         WcX2CH5MV5W5nDoQEslcTivn+HjqfnmgvjCU9EKZ6tzGrUvTdLzOVOTCba5xzDbrmTZD
         2k4q2rguiW3iJ/kWjnE0s8XsdggWCny+eCO6ExH4CN3H97BuXrEtiU5U/uzAUlnRvJkF
         /gYxsuyqHPB/MK5y3MmqA9djB8OvBeK0LovTbVjWSgLoobRqopRKXQdei/iwFAU/6M2m
         ECBcgp1/bGWqugDgWDk/6zxsE4Gr6dFDFW4Ut5fwGRXwJ/36xYvM2Wm1nqQnCz9h/kPv
         PcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238099; x=1726842899;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOZr+XBM5WUt/TfPaFfV5hj8BjCZLS7DmNzXffMIGd4=;
        b=jP6vR3tLuvkDx194qNBiMNO9bmsSbQ3U988B5+RT0/tBdZZs/wVtNX38HUc/mC07hF
         6cxIYN/sT7hPrB4Vwz/d9x0ufvwglS98a3ian2s4MoLm77RCAHU9EfWDOk7N4XmrqdXZ
         sflKDlloexktsYIFwXPNQHQe0AfkgJkgTWPSNhm18lmtkTtbgfNPh+ag4iGPtO9w0gi8
         2KOIU+D5sLZTmPDfu1tPRgK7ATWxM/wYU8jUdTmDMezyAAaT5qZ7kbfjSXCwH9+PU23f
         3LEbaLWpsOQGfGkeG1rxTVHgRbwlUzHpXXU5MHRCG64r/RjWj7rlr/oPzWedy7DDKxJz
         Rygg==
X-Forwarded-Encrypted: i=1; AJvYcCXi2Xd071Lmyl5yaqtfIkfq6Za7MdnuB+7jgHtm1cqbnUPs/U45Iqr85XDKL2gQ2w0WfrKPUdDnrTdCwvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv9UchkMODbiBevz3c5tirAjOjb5MNqj+mGy7LPWi+BSgcEwVW
	qT+IBzk8h1LNqaE0qgx3GRENUnEKRi7ynKuuHchtCmhq9R0tlTVbCzk63LWMhz8=
X-Google-Smtp-Source: AGHT+IHjq2mTTdTFTKK8BFKScueI01WIN6K5Za4D/dlGAyZ5cP1Y+EQegQPXkmLZH/xNBLTD7hORWw==
X-Received: by 2002:a05:6512:1289:b0:533:e4d:3374 with SMTP id 2adb3069b0e04-53678ff4b06mr4059065e87.57.1726238099288;
        Fri, 13 Sep 2024 07:34:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd466dcsm7692145a12.24.2024.09.13.07.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:34:58 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:34:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/tegra: Fix NULL vs IS_ERR() check in probe()
Message-ID: <ba31cf3a-af3d-4ff1-87a8-f05aaf8c780b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The iommu_paging_domain_alloc() function doesn't  return NULL pointers,
it returns error pointers.  Update the check to match.

Fixes: 45c690aea8ee ("drm/tegra: Use iommu_paging_domain_alloc()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/tegra/drm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index c9eb329665ec..34d22ba210b0 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1153,8 +1153,8 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 	if (host1x_drm_wants_iommu(dev) && device_iommu_mapped(dma_dev)) {
 		tegra->domain = iommu_paging_domain_alloc(dma_dev);
-		if (!tegra->domain) {
-			err = -ENOMEM;
+		if (IS_ERR(tegra->domain)) {
+			err = PTR_ERR(tegra->domain);
 			goto free;
 		}
 
-- 
2.45.2


