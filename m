Return-Path: <linux-kernel+bounces-520274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A499EA3A7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49EA18954E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0491EFF86;
	Tue, 18 Feb 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSir8Ewt"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C482E1E8335;
	Tue, 18 Feb 2025 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907704; cv=none; b=TfGIE5AutTgf+HVdplDCrWxB+y2LKiGd7YNgYoTPTzgpLVLfDrW2ZbjQ++pGOvpmSpguymffUK5sik7yEBzByfFrIj1QFAW7T69NZfe3h9WJpet2fZceJTJ2ZOt8pgzkNnCxOYiog/dpgmY3+26SZAUYwBb4lN/9gZ+yFrOkoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907704; c=relaxed/simple;
	bh=FkKC1cblMmiYr5M9z0M7oNEPnm2fiY498l/eRo2HEJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arQWwPzuLRYnI8DZCLm7vL5irW0rq7Ti4HysiqA2N4Dklunk6oyCCpuqDXTWqoLOfv0NrSfcjT6+uqxyJG8U7pxp1E5lpN08RGnaJkJHm41y6K1uBmocxdXe0ecCq29jT6e6tnpg/ETzfsAELGaaVc6HLEzXyqfv1Mm5tyVt6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSir8Ewt; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-868e986092cso1795698241.0;
        Tue, 18 Feb 2025 11:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907701; x=1740512501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QuBSv9ph+j/VGeO4Pumxgm08aKHK253KJvIqheZYvs=;
        b=VSir8EwtsFt7M1GRigHqiC6ktUTvFSy8Q18MaPkeWBQfR6ut+01O3X5vdxHoh/Rs8U
         0ok6HVmqeSBY2D//f35+qoRbONzlrkc9cTi7fZ7as7Zo5LID0UINXamOi425TbhUpVIw
         IIlh1u9CMBjG2YTamUehbf6K8bUYT8PaZpXq6P6EL4iMvB8QcF2nWiGE9tA1FZHCdMaR
         2KMmeo5w05QV7GmXs3JKtN8G1NDCWE7crxdI92aDDxIdMUFH9QMWbuybAXbyq0B60dvv
         T8U2BFjQ+oW80WxCavx6UkKWfjGwaG+Whe5oaQBUO/C3GUolyesoohpg5S2rkPOUqmmP
         oGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907701; x=1740512501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QuBSv9ph+j/VGeO4Pumxgm08aKHK253KJvIqheZYvs=;
        b=OD8w3saR9jDfsrpwGNCxwyRgb3XiSHO9xp2tVQ9t8j+MDQzmcpjAUF/u104JR8m5bP
         vMS1rlDdsmdTknS2qmWK7V6yuPd2RjYWQaT4GT1u+wx32DV2kTSV+eJNKoZRkYYxEtSV
         gGW66XJeEI51V88/iMkBwhpXsXs+f3vhfE+TuNt/gWSK06dFMEP3T18uaq676vd/EX1z
         qiwszpSU6Eg5SSiti4l6m9/MeKXYaIuIhkoekCH9ststpfzoAweU9fHYkAh4/oqDE/XY
         SnyOHMLc1SkBTpOhCYuqoGPE/ROduv/5OYWTgDBSPgngRqHwqyPR+ZQiQ6qEimgCh5aW
         K33Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFgtuVRJW9C/QQVCmSoYYFniFolkYC+vHwxBsCYY7RWaahCl37D2R+uID+ISXppJdn/EV8WRoN28yITjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzga1zz4IfDuaSh9FlJIovwczqNDxLhI/qqkC5iP7oqysuLJoy7
	tGQr6ym5rjMGwbZq2V+W7qgVUEF82/B3Ob8TZsZHqPP98f/esa4N7jkymsVl
X-Gm-Gg: ASbGncsF0Jj9uo2ipuu9qchkgQQkcuKDQmW5spxzr6wgWH0YbSOUaot840gRJAwV+yB
	MddDa7AsPMu1P3wfm/jJAPYAhW7EGYhqtiegSngYe7Xxoqh0Ki8pQkf+lYtwChVWSQJaE7pGSo9
	DKrRdgXJFYoMzfDW3IUxgsDrfeBnnmcqT5Ro2wGkivmTFlQscw8cwZcfkPUb2kMWR893r9U3pnC
	Ltd/tRVNkcRB2afMVIg5rJAMdEScLOV+4HzhIqXYrZ6ZzzO7LPzPzNqC/uIcFAt/ecsXSGXAZSK
	+krsB5BZAIAQxKAbKmDzNh8=
X-Google-Smtp-Source: AGHT+IFiSW+A77UfE53ewep9siEze74zohXl6W/5mPVL5SJd/Yxs3kK45kQNuQ3lInDAJX+4t3AxFg==
X-Received: by 2002:a05:6102:5e91:b0:4bb:9b46:3f90 with SMTP id ada2fe7eead31-4be85bab331mr586457137.9.1739907701544;
        Tue, 18 Feb 2025 11:41:41 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc68dd766bsm2305214137.20.2025.02.18.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:41:40 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 2/4] platform/x86: amd: Use *-y instead of *-objs in Makefiles
Date: Tue, 18 Feb 2025 14:41:09 -0500
Message-ID: <20250218194113.26589-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218194113.26589-1-kuurtb@gmail.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `objs` suffix is reserved for user-space tools. Use the `y` suffix
instead, which is usually used for kernel drivers.

While at it, fix alignment in AMD PMC and PMF Makefiles.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/amd/Makefile      | 2 +-
 drivers/platform/x86/amd/hsmp/Makefile | 6 +++---
 drivers/platform/x86/amd/pmc/Makefile  | 6 +++---
 drivers/platform/x86/amd/pmf/Makefile  | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 56f62fc9c97b..c6c40bdcbded 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-$(CONFIG_AMD_3D_VCACHE)	+= amd_3d_vcache.o
-amd_3d_vcache-objs		:= x3d_vcache.o
+amd_3d_vcache-y			:= x3d_vcache.o
 obj-$(CONFIG_AMD_PMC)		+= pmc/
 obj-$(CONFIG_AMD_HSMP)		+= hsmp/
 obj-$(CONFIG_AMD_PMF)		+= pmf/
diff --git a/drivers/platform/x86/amd/hsmp/Makefile b/drivers/platform/x86/amd/hsmp/Makefile
index 3175d8885e87..0759bbcd13f6 100644
--- a/drivers/platform/x86/amd/hsmp/Makefile
+++ b/drivers/platform/x86/amd/hsmp/Makefile
@@ -5,8 +5,8 @@
 #
 
 obj-$(CONFIG_AMD_HSMP)			+= hsmp_common.o
-hsmp_common-objs			:= hsmp.o
+hsmp_common-y				:= hsmp.o
 obj-$(CONFIG_AMD_HSMP_PLAT)		+= amd_hsmp.o
-amd_hsmp-objs				:= plat.o
+amd_hsmp-y				:= plat.o
 obj-$(CONFIG_AMD_HSMP_ACPI)		+= hsmp_acpi.o
-hsmp_acpi-objs				:= acpi.o
+hsmp_acpi-y				:= acpi.o
diff --git a/drivers/platform/x86/amd/pmc/Makefile b/drivers/platform/x86/amd/pmc/Makefile
index 255d94ddf999..bb6905c4cae9 100644
--- a/drivers/platform/x86/amd/pmc/Makefile
+++ b/drivers/platform/x86/amd/pmc/Makefile
@@ -4,6 +4,6 @@
 # AMD Power Management Controller Driver
 #
 
-amd-pmc-objs := pmc.o pmc-quirks.o mp1_stb.o
-obj-$(CONFIG_AMD_PMC) += amd-pmc.o
-amd-pmc-$(CONFIG_AMD_MP2_STB) += mp2_stb.o
+obj-$(CONFIG_AMD_PMC)			+= amd-pmc.o
+amd-pmc-y				:= pmc.o pmc-quirks.o mp1_stb.o
+amd-pmc-$(CONFIG_AMD_MP2_STB)		+= mp2_stb.o
diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86/amd/pmf/Makefile
index 6b26e48ce8ad..5978464e0eb7 100644
--- a/drivers/platform/x86/amd/pmf/Makefile
+++ b/drivers/platform/x86/amd/pmf/Makefile
@@ -4,7 +4,7 @@
 # AMD Platform Management Framework
 #
 
-obj-$(CONFIG_AMD_PMF) += amd-pmf.o
-amd-pmf-objs := core.o acpi.o sps.o \
-		auto-mode.o cnqf.o \
-		tee-if.o spc.o
+obj-$(CONFIG_AMD_PMF)		+= amd-pmf.o
+amd-pmf-y 			:= core.o acpi.o sps.o \
+				   auto-mode.o cnqf.o \
+				   tee-if.o spc.o
-- 
2.48.1


