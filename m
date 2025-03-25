Return-Path: <linux-kernel+bounces-575251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508EBA6FAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DC31893BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D408256C86;
	Tue, 25 Mar 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trYrOSl+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5F33EC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903948; cv=none; b=j+SCY4ICoHShLwibk3ezTp9dgw57zS+Na5MIT8TemqAwQG6jz/MI1rdqnHxjObyXYNGwOGaQllSUrsHuo1XZI/48Ak1d8hKE8VrR9QK2OrNeY5Gf1j72F8vCrykCP8B1YecfB/qwO3BaE8KfyGo9aB5arIpPa0ebhlvTUw2zTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903948; c=relaxed/simple;
	bh=X8DyBIFgU0m5nrCkroaMunfeDG8nHWMvWTF1vlsU2Iw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dJXtS/Gl7IV6gCsZy663fm+SaYaVtCLhnIyMsiCbvRKYeMUvXwHI+o0NhzTxAJVdFfTa+PzzNzpJeCR+y6Z/ESZ3fKF4VHtWRczcjGd2M4asGlTxi16q8jIZnLcsgGyHVkLTr0JitxJ41Wt+Ds4KWdoUUHvp2itQ1xQzi7+wfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=trYrOSl+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso34421735e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742903944; x=1743508744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGTI6dUm2MRiVeGplFX7z/KtFfB0S3Uj2G+oen7A4jo=;
        b=trYrOSl+uJwiQ8vmn4Qey5G+nglxeTqAa8BhKlOa//JyxrNgtFC2AqLpFWgGTyj0t4
         itXhXol3OkLDrg2jfetHY5OWnlMYJAdpl/bEuSnQ4n7cSA47kA3T0Y80GDupO+N8eqDe
         EsvdqgarMn3umYN1RUw+MBlEtfyjK0/otjNxLgPibQoq6nmLfHaoDRdr3sseCjsj6BVX
         5mmjzQJBD1TYHCoEsHxblovbhQ7LuOwL08I+o1f1pkgTynANQak0i4Dav4723+9Q1sDX
         3nkilzfsdbqVl2H6f1dwc2eQucBFf0kGGHgFwhNNqm/yH+BtWHMpfSq4sqi7Q46W8gRZ
         Vc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903944; x=1743508744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGTI6dUm2MRiVeGplFX7z/KtFfB0S3Uj2G+oen7A4jo=;
        b=lBqTRVH7fR+eNLF5mHjRullXD1PQsovchYTQknlAAy9QVipzt0RFPt34LqVqQYf95s
         LITOF1bFVMt6qv7CBawuVtT9X1as2Z4osSD52T0ndg4BiopTtw4oCfr3Ae5yRvXS4QpW
         4SjfnaAWDrZjTq9EzjSt2syJykfNfp8Wa3D7Q+pS2oCJ8vHgoZx8+JFts/79xBHohkIs
         WBsNusDb20brDfezazec3v+JlGjaJjGuf1UERKvBL/4RMjyj/6EEHVju9NoaQjVdU6DW
         6bUxAQ6L5vNXRxs3EB6+XznNx09r9hSeBP+YH0vfVczNPqk2OoInKhwu/VdSHF2onDfK
         Qdww==
X-Forwarded-Encrypted: i=1; AJvYcCWAnW5gnn2nyrpEtKDa1EFhda5dYLvNk/oDKQHpCMm9vp+Dom/r8cDQFVOAR9RllnhP8fUB/DyOvuHPkDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1veBZJO8UhJbdJKN9ktAoXdIy4CpzP2QNvGPPhI8xAd+klKI
	Mvw46UJurHjmxvhXbxT+ZbBA62s1yAUFfDelZ/6pmxIu6JAL5R2Cd49Z2lLpdyA=
X-Gm-Gg: ASbGncs5xCdTM2yB4bFeKhWiJflN9s2FHWeeJdhmHMq4y0ephkD7zVIQeVjxUGwPQ39
	qDzy7k5wNiaAQwAek7YINHndCD2aRwo2hTT6HEDBbQY7gHPKQQLu4GN00uLldLESj8AcG3VW7rT
	ETKhcwY8x35j7CdTVC+mpdkSUHzjCymLNQnaK7j/nVkpASDkmAIHELLAVhRchrOPu+jt+XkdLBZ
	qGAf3FsNPoDoDtjmRrloNT8r0uTrUp995Gju1/EIB5KDLcjZ9ty4U9e1CtwfzHP/ezbvbmG1r3l
	Rr2RXqLmOfj+VW7GpX2C6+H8ah5KibKFaj87sFlE52EGwZVPcIlv4p6h/xI=
X-Google-Smtp-Source: AGHT+IGi3f+WduASAoJyESw/dkvZV/1xs7w/6CimQs/4qOoGd+9PrfPjTXiaYW1ipNvTLM3qNBE+cQ==
X-Received: by 2002:a05:600c:4995:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-43d491b7dc5mr162584035e9.10.1742903944481;
        Tue, 25 Mar 2025 04:59:04 -0700 (PDT)
Received: from [10.42.0.1] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm13687169f8f.62.2025.03.25.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:59:04 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 0/7] coresight: Clear self hosted claim tag on probe
Date: Tue, 25 Mar 2025 11:58:45 +0000
Message-Id: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHaa4mcC/33OTWrDMBCG4asErTtGo5/Eyqr3KFkIeWxPm1hlZ
 ExD8N0rp5Smmyw/GJ55b6qQMBV13N2U0MKF81SHe9mpNMZpIOCubmW08driAd7jhQqkLFR4GGd
 I58gXmONQIBK6PfbYe9KqAp9CPX/d8bdT3b3kejkKxT/SIKK2wfkm7A8ueMCfD0115eP1zFOU3
 GQZNnDkMme53mMXs7G/Xe2zrsWABgqpjSF11Dp6ZLewxT5YRj+1bLU6i84n9LY1+p+1rus3IFN
 REFIBAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.14.0

I've gotten stuck a few times with unusable Coresight after a warm boot
due to lingering claim tags, especially when testing the Coresight
panic patchsets.

This change does some tidy ups, adds some debug messages and clears the
self hosted claim tag on probe. The last two commits are unrelated
tidyups but they touch some of the same functions so to avoid extra
conflicts I'm including them here.

This gets as far as fixing the claim tag issue, but there is some other
state not being cleared on probe that results in the following error.
This can be fixed up as a later change:

  coresight tmc_etf0: timeout while waiting for TMC to be Ready
  coresight tmc_etf0: Failed to enable : TMC is not ready

Changes in v4:
- Add _unlocked() suffix for consistency
- s/cs_access/csdev_access/

- Link to v3: https://lore.kernel.org/r/20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org

Changes in v3:
- Collapse rename and locked/unlocked addition commits of
  coresight_clear_self_claim_tag() so we don't change the name twice.
- Make coresight_clear_self_claim_tag() a bit more generic by only
  doing UNLOCK for MMIO devices (although there is no use of this right
  now)
- Link to v2: https://lore.kernel.org/r/20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org

Changes in v2:
 * Revert most of the interface changes, just call
   coresight_clear_self_claim_tag() directly. This is possible because
   we're not doing the read first, so it has fewer knock on effects.
 * Split out the change to add struct cs_access to etm3x
 * Add another warning for racing with external debugger

--
2.34.1

---
James Clark (7):
      coresight: Convert tag clear function to take a struct csdev_access
      coresight: Only check bottom two claim bits
      coresight: Add claim tag warnings and debug messages
      coresight: etm3x: Convert raw base pointer to struct coresight access
      coresight: Clear self hosted claim tag on probe
      coresight: Remove inlines from static function definitions
      coresight: Remove extern from function declarations

 drivers/hwtracing/coresight/coresight-catu.c       | 12 +--
 drivers/hwtracing/coresight/coresight-core.c       | 87 ++++++++++++++--------
 drivers/hwtracing/coresight/coresight-cti-core.c   |  2 +
 drivers/hwtracing/coresight/coresight-etb10.c      |  4 +-
 drivers/hwtracing/coresight/coresight-etm.h        |  6 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 28 +++----
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  8 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  1 +
 drivers/hwtracing/coresight/coresight-platform.c   | 26 +++----
 drivers/hwtracing/coresight/coresight-priv.h       | 20 ++---
 drivers/hwtracing/coresight/coresight-replicator.c |  3 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  6 +-
 .../coresight/coresight-syscfg-configfs.c          |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  9 ++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 16 ++--
 drivers/hwtracing/coresight/coresight-trbe.c       | 18 ++---
 include/linux/coresight.h                          | 40 +++++-----
 19 files changed, 168 insertions(+), 134 deletions(-)
---
base-commit: 5442d22da7dbff3ba8c6720fc6f23ea4934d402d
change-id: 20250317-james-coresight-claim-tags-ae1461f1f5e0

Best regards,
-- 
James Clark <james.clark@linaro.org>


