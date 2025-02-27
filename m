Return-Path: <linux-kernel+bounces-535594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA6A474CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B36C3AEF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE21234988;
	Thu, 27 Feb 2025 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7jIgTty"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4756234979
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631093; cv=none; b=nE+t8+YptS6rhAaxQihJNL6AUXW/Uk6Cu2n7zeAuK567dVVW7eDSijJbFgcPkO16TnVy1/xiHzj10XylxQ5PBgI97WY4/oCyCJzDpR0zAwQNk1THRaN0pZ3j00SBwT8cy9rXRJL+/FJb6pu/BsxcYV7wmJqSte8Qg3qn/c4qjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631093; c=relaxed/simple;
	bh=Ib6ZO2EH/a8o5tLg5RHSx5Zf6q2a30HCMjUDr/LDIww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJYN2oqFWPkGedzFt7OVeWWwzLX394NLJ6HIDFFg6DX8lSZU0M4IvY9bbZuAHHOOun9GwTVCqIWp3XAuSy6ed2np6yxJTMF4YBrrMCf9yvKoifGjRf/vAN5qouyNGQOhb4Wlr+O6lYP2BeQtHIGqjqgpZu9DWkrn6yG9JsnEpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j7jIgTty; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5439a6179a7so648348e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631090; x=1741235890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+xNvurO8U1WVGtMu3d7j2YgOZ/XCG9UaC+fiCOcukg=;
        b=j7jIgTty4Ge8fc6Y27G+qumfhEJ4L4gCov1cvPgHnFSv6xfh1oqodqNoBEBH4NzUh3
         Ojt247UR43MCnEaM613INiLXEsUcrGYSFY65JaocbLMKcDuFh1o9Wh2YwT9/sOnCgaYo
         SG1K4AZJ76bgjo5Jnf9nyFKu3zP3VJedcBR5+mMQUEjmQtcnJ1QeYwJ+y1rnA4n6z7pW
         NSdtiDoBc+8xethd3DVdvAlFxn7/rkL03K3xXoJQ0XzdBEuEPzdSIVmRHvzinH3jW9+J
         zR7d4WzHr/PaqBloK9BWv1+KYyTFZ1ge+9GlwK88cV4LbwcBKQEzCX0BYhcMNlZVCSI2
         BZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631090; x=1741235890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+xNvurO8U1WVGtMu3d7j2YgOZ/XCG9UaC+fiCOcukg=;
        b=oZa0geP7l4EO1AZV0CmnBZj6JSRXmRnAOoZebZ8PDSIFDAtOTb54IDpNMCNBU3LCl+
         Dwvw8x1hEcUW9ttqTIdvAHWQqA9GFuyOG1n3FyQALgSkY2J7dUpJaOT0XpIRutWCD6Qn
         EvtKSXUB4UrC4Pi6gUwkHGl1IMcE2UnhHPpne14y/3HrvNjauH1spduQ1njUOxBu1ZzL
         DRiWjNUkWRpbe2GKJBzLyqvxt9t2EFW2DFoyJV3B7X9jtndTl1Q5ty9T1caW+86FH917
         YsgqDRHXNis5Flp7yFM6uP71Xzra7KujqYJqHdpgIM7vJFwWkkde/gtNGALgk++mtUyT
         CGZw==
X-Forwarded-Encrypted: i=1; AJvYcCU616aloyF2IM7TY8JNs1dYnpUT6YdywbcPOL9MCLJsBm5Im41pJ3eB/cJWW1FHYPniGwXAhmM5Hho6Hjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywik1LP3mx/gbboW046R0/ihvwOEQ3YhEnTsgW/kC64zKQnyamv
	NHLljDfYpebcANWLhd/ZV06qN+BOAsBX88X+XBouuTPFf41MMqnReFn13IQuXJo=
X-Gm-Gg: ASbGncv8+LOry4DbqCrpqSLcuaHlpUXg4EhlYFnp3rSotgs45sWlH0Pr+LVG1Oe+8Qm
	BZwLULaNi6ufOfcxLOwNFuUOEhiyCsUxVyN7IWtbpTTGcqtJL5fMbG0SBsshcBSODOuzHCopMOo
	I4zSH9Un/uk5dy5cMPYhSQtgOLk41y0TBuoPYBkhXt6WfDPWl+R3sr8StYprJD5SxNzrz0Uhw2V
	pWMJ1wgw4aQrGuQBU47XvWe8EhS+6OGTJtjGxwxJ/eea5/9IsWTeiYX/6/tQAz+a7FVIVI84vsy
	QgjFm7YtiTEp6eYotF0McZNi4TheWHXQPA0eIiHrVA==
X-Google-Smtp-Source: AGHT+IG4FmEa2E6Vnd3n6pmL4LIRNjCw5Yr6bPCVueD2ge1UqqUmi9/g9dZciGxkaPkoSh2/W32iag==
X-Received: by 2002:a05:6512:31d0:b0:545:240:55ba with SMTP id 2adb3069b0e04-549433167b7mr678503e87.26.1740631089878;
        Wed, 26 Feb 2025 20:38:09 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:38:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] drm/msm: add a display mmu fault handler
Date: Thu, 27 Feb 2025 06:37:35 +0200
Message-Id: <174063096226.3733075.7759942352504243411.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219-abhinavk-smmu-fault-handler-v3-0-aa3f0bf4434a@quicinc.com>
References: <20250219-abhinavk-smmu-fault-handler-v3-0-aa3f0bf4434a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Feb 2025 11:49:16 -0800, Jessica Zhang wrote:
> To debug display mmu faults, this series introduces a display fault
> handler similar to the gpu one.
> 
> This series has been tested on sc7280 chromebook by using triggering
> a smmu fault by forcing an incorrect stride on the planes.
> 

Applied, thanks!

[1/5] drm/msm: register a fault handler for display mmu faults
      https://gitlab.freedesktop.org/lumag/msm/-/commit/eabba31a839a
[2/5] drm/msm/iommu: rename msm_fault_handler to msm_gpu_fault_handler
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f66f3cf6bc42
[3/5] drm/msm/iommu: introduce msm_iommu_disp_new() for msm_kms
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c37d9f0b1a18
[4/5] drm/msm: switch msm_kms to use msm_iommu_disp_new()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/85bdbd8306d8
[5/5] drm/msm/dpu: rate limit snapshot capture for mmu faults
      https://gitlab.freedesktop.org/lumag/msm/-/commit/89839e69f615

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

