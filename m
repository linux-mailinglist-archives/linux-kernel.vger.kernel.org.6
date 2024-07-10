Return-Path: <linux-kernel+bounces-247045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B523492CA40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E6B1C21374
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7F41C92;
	Wed, 10 Jul 2024 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hBxey19p"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C417A47
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590596; cv=none; b=QgD/MAgSO9vOgpf15x/0RAFdgblr0QiB1rsbqUw1Luex+rSeveXGAcBanBjjX0hcbA3VH5L5J47E/m7LJmZPo1DNZ4Zygs6+RfIyHQJ0e2F5uQ8Z1wtLxSOoABU50Ej4gC3U1eB5gGha55hp5Ex/qElsclGAGThKjj7fMFqjFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590596; c=relaxed/simple;
	bh=lDWtoHqNfBmD8p9yIRa0ylwcWIKNjdZxVerbAIOtOGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4Qxu0dq5/5Oi/ErcXr3Kr6atw/iQFrqWF/w477PqdSndwzfHpqGE3zzz75szYkTwW2lDYqJgkpbRaweHKE154wvRslGc67Wpv8NRSpi7DcEnvBsPkL4Qio7MB90hEkIf/28O91eR2YBGuq+WzQ1MqQ/HTrAQLPcAzoblUGZUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hBxey19p; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720590591; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KcWZ936mP77StWiaIt38K+2eLtyyTBUiBBVOItUQAZI=;
	b=hBxey19pLaGZa/lBmLT2X73QDDutjesjqFhYMzWl0Q1OrqUgn2JnCtzNCmK1NG6L3joeo1KU+6BIxoDUMTGIO8WuYasD3GTLeDilf2UOjQkwNNLZYgAXOeddc6dSu5sILZflH56iFwN2v4NJ6WXkL7UaP2fROocB5K+G/tB9wiI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WAE92uh_1720590582;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WAE92uh_1720590582)
          by smtp.aliyun-inc.com;
          Wed, 10 Jul 2024 13:49:50 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: lucas.demarchi@intel.com
Cc: thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/xe: Remove duplicate generated/xe_wa_oob.h header
Date: Wed, 10 Jul 2024 13:49:41 +0800
Message-Id: <20240710054941.44013-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/gpu/drm/xe/xe_gt.c: generated/xe_wa_oob.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9493
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index ce8994b808fe..5547191773fb 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -11,8 +11,6 @@
 #include <drm/xe_drm.h>
 #include <generated/xe_wa_oob.h>
 
-#include <generated/xe_wa_oob.h>
-
 #include "instructions/xe_gfxpipe_commands.h"
 #include "instructions/xe_mi_commands.h"
 #include "regs/xe_gt_regs.h"
-- 
2.20.1.7.g153144c


