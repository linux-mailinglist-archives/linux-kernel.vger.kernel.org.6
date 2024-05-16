Return-Path: <linux-kernel+bounces-181423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCBB8C7BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3691C21982
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8B156673;
	Thu, 16 May 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BB4dzfiV"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE614D457
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882265; cv=none; b=kCHE/v30cGaP1tsgaXRv4gpNnIY0duqCjavfAPO/XSVrnuzHzQ8SVaDSU2ma1P3MLU5Tkz4SmqgHQqp6XbFnpFQ9mnafkYvEh8SEApvH6V/v8BCevO2ACLXFIIGgIiwOgvtpXfZ1E1tDrF/8BgSDw2SybY8rJKCSsXc1TyVTCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882265; c=relaxed/simple;
	bh=QAHh4f+z1gl2UBJfmsuQjakgT8ESP7RS8QoJaVPvkgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhRCIwIOTfGa4t7qoRPYAfJpgp+fWTq0xPveoC5VKd6PfpFVgURgy63PJ4y4Eg1nupL5mM/l8vGOLY2kUPVa/4lAN28UvtlrSA0+wACwOEDD+SVka2tYqdOFpO18btA9CJl0Is/8AEaM5X4DIJdAtiTlUdJURva5qKTB/PIqPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BB4dzfiV; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e1bf0e9ab5so64261339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715882263; x=1716487063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yk3zlTkgWi4AihMGcc8aW5GoxToOm2dN986l+VV/uk=;
        b=BB4dzfiVUpA15C8zurGm/Q8nV3jJI0EWqrW5qXAVphOWhyZEU5X7NWCgDpQrM2ThKw
         t2mkf1JhcMAlvcNOC7hCcSR+nrZr072zeACeJbCxnsc0kL9jCEKnYI8uG3hDvMIEfFLY
         BQ0JZPMn16hLusCYUENX25dhFG3rHnsH3a7Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715882263; x=1716487063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Yk3zlTkgWi4AihMGcc8aW5GoxToOm2dN986l+VV/uk=;
        b=cuIg+8TH90HL21kdjVjtX0OSjUfGRi8chJQqtU3QCQtLYJNg+u2JyFckUJPgkVRSTN
         Dr4YhC36QdgsaxvEzEtWCZSr1ylCXQr/zn8jNhu2Wr8O+IowUboTdXs6yvkR3FPOF+i2
         W+cIYXrlDRw3Jemn5ku2sSB/gBArcipNSVU/HrzQLiYqLcZxKP1Xx+Nf6nSZG1ahM5s9
         /6HfS4myVusSlvgyBkx1D5mdNA3+qfvarTULS6oOHpOHkPWeqElaRVux29hf3WYUE2Od
         c+Kku0kVD1DtwtKrbF4x5qs6qyXBigKIQKdbYd5h/0YGyreEhXQ+XFwm4Unf67UQCsZ6
         vPIw==
X-Gm-Message-State: AOJu0Yz95PKhVIvD0kui6yoaB3HVV8jfDnsj9HxHEUTZJT7sdRodcGkL
	feQEdRAI396xXsbeVa7QQzQTiAll5SBh3BwtkmcPNemBgClTIGYrfcXCsk8nLmk6l/aP4KyfU8M
	=
X-Google-Smtp-Source: AGHT+IFsR9ezgvWfNnErH4JZuNFg8b3FDJaa1H1EfDvT9mRukNmnEvHG/5IFxY/twUfl/3j6BsBKdg==
X-Received: by 2002:a05:6e02:216f:b0:36c:c8f:89b with SMTP id e9e14a558f8ab-36cc148e4f7mr235882165ab.11.1715882263135;
        Thu, 16 May 2024 10:57:43 -0700 (PDT)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:93ff:e692:b652:436e])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893703bfd8sm4301631173.47.2024.05.16.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:57:42 -0700 (PDT)
From: Tim Van Patten <timvp@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: alexander.deucher@amd.com,
	prathyushi.nangia@amd.com,
	Tim Van Patten <timvp@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>,
	Le Ma <le.ma@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	"Shaoyun.liu" <Shaoyun.liu@amd.com>,
	Shiwu Zhang <shiwu.zhang@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
Date: Thu, 16 May 2024 11:57:25 -0600
Message-ID: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Van Patten <timvp@google.com>

The following commit updated gmc->noretry from 0 to 1 for GC HW IP
9.3.0:

    commit 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=1")

This causes the device to hang when a page fault occurs, until the
device is rebooted. Instead, revert back to gmc->noretry=0 so the device
is still responsive.

Fixes: 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=1")
Signed-off-by: Tim Van Patten <timvp@google.com>
---

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index be4629cdac049..bff54a20835f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -876,7 +876,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	struct amdgpu_gmc *gmc = &adev->gmc;
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool noretry_default = (gc_ver == IP_VERSION(9, 0, 1) ||
-				gc_ver == IP_VERSION(9, 3, 0) ||
 				gc_ver == IP_VERSION(9, 4, 0) ||
 				gc_ver == IP_VERSION(9, 4, 1) ||
 				gc_ver == IP_VERSION(9, 4, 2) ||
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


