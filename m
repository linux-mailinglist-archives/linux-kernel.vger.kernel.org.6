Return-Path: <linux-kernel+bounces-535741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102EA476A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B87C1650C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86266221F08;
	Thu, 27 Feb 2025 07:32:30 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4418FA47;
	Thu, 27 Feb 2025 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641550; cv=none; b=XspravYnFUIiLxsMbAUZ8FxsTT/r4sqQKFwqqG59dR/iqLTpuRYkXfdfAV9/8nRsVU6h8+uujI7+51ho+plH57bNR8baWtOnqwX0KiJTNKd2ctsJVc4xzOTdaMR/y8IIuKZr/EBCz8hDB5uAozkel6rRZGq0qQHTK4RRypVygis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641550; c=relaxed/simple;
	bh=M6lTo7scV5I/prrmI/U/RTzFfrkfzqV2OHcOv3mpg+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iiggtjv/Eu3+JnQ3aUAFMGQB/8QeMLjTTXpgAKKaQwd8DQj4Vvf+DjnnsDzpuk1KY7AEdryQGcg/+T7bvHqIX7v6oiQWXaiXhQkI0kVT6+ylz+pS+kW921twMy1jYVhT+DO5i+bbUWknOtO7foqgF1A2aZ927usrDpqs/4UslWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 4392860260CDD;
	Thu, 27 Feb 2025 15:32:14 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Su Hui <suhui@nfschina.com>,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	michael.j.ruhl@intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
Date: Thu, 27 Feb 2025 15:32:06 +0800
Message-Id: <20250227073205.1248282-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When build randconfig, there is an error:
ld: drivers/gpu/drm/xe/xe_vsec.o: in function `xe_vsec_init':
xe_vsec.c:(.text+0x182): undefined reference to `intel_vsec_register'

When CONFIG_DRM_XE=y and CONFIG_INTEL_VSEC=m is set, ld couldn't find
'intel_vsec_register'. Select INTEL_VSEC to fix this error.

Fixes: 0c45e76fcc62 ("drm/xe/vsec: Support BMG devices")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/xe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index b51a2bde73e2..7a60d96d2dd6 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -44,6 +44,7 @@ config DRM_XE
 	select WANT_DEV_COREDUMP
 	select AUXILIARY_BUS
 	select HMM_MIRROR
+	select INTEL_VSEC
 	help
 	  Experimental driver for Intel Xe series GPUs
 
-- 
2.30.2


