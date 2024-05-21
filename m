Return-Path: <linux-kernel+bounces-185097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39738CB074
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EDD286011
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE19130485;
	Tue, 21 May 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Hy0w0VSr"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735112FF89
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301744; cv=none; b=iOebCkWOZa4Kt37YnCDeqPJzVnYjBI6cotqmsVBqqdsirThd4jc6j8nDTxRhNSJIryFa9WiQKE29cCruJFYFIGm7sYVfhaLEGtWQoWjSEBJI58/TCtL+lPX9P2DylW15emGVCRfXSnWGphp4UbmACvUJudj4AYcDcFgJwcTEzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301744; c=relaxed/simple;
	bh=YRYue5aSF5GPpqwooptAjIRHn3hTaLIxoJH1OJ3w9zE=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=lFB6fhsn7Cj9Fo94VXIErvCgejthVPLOoCMvHykCnBYblqZyVRKg85mPhKoA55lbYHjh8b1P33Lf+eeYafML3Bb14mbYz+3NjIqRutD7bciEc6SyAEHeY6bWDJhY02v++h9mlu9WFowQYv7bWFquwC4A6f45mjVXQFrYspoWDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Hy0w0VSr; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f10092c8c7so2692240a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716301742; x=1716906542; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=TwldfdL+T6NcWAidI3T3bL1Xd+CxsE6EH6dzBTpXKgU=;
        b=Hy0w0VSry8FLfcJfPQoGSAQqPF628ivEXEY55OQSOHzsPP+igKSnGRuUux6EgaiCfO
         tQ9fC2WcHJMEsdm2D5ItKMWyTSmO8/9T5Y60ZMj6/I1RgrrjUwuIDCUWE8Ds3ZiJHwz9
         2JYuVKmg06tDKe3ndm0CHZXtoFuuB9Kc2gHmF/OUAChpPvpFJO5zwmAPCAhQPMkTCfwB
         Xnms6y0F2oLPDBl2CzbEpXZ5CYkFSwha0FDiC4zjug2htecycLlQjLo9DfR5cJ74tISF
         w0b+3cCf+VXPSWDGJWhr7AW14HDNykCzVV3C4mLQNfdG+KWtlQTc/I+Z8ieBEGi2XVLX
         GVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716301742; x=1716906542;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwldfdL+T6NcWAidI3T3bL1Xd+CxsE6EH6dzBTpXKgU=;
        b=XPm9gXjwnFACSnpYNKacn5S9teLTRmTmYYbYhi+8f3i5G8bNG8gnumfMWWksX5Vl2N
         vKpfH6+vn2U7wJaeIFwTwZr1dLRUr5vNbd2b13+VI9Lxa2JnmyDtVkw5+YcBezkYlwW/
         g+3EO+IsDhnxyGxVH/8LqLTtdRS+WrV0uQ6FRMAKFVBRio6j4P8F//cYbv2HwhZmJY+F
         j73uH7lryQexrCEIeH7sGHriVwWrhbg+CJC1rFIX20H8i+w6ngz99bBxKhvWm2sUyK3M
         y8w5BN5+sLwyyGqqoFKfJpwguxFNFAIwHySQUHnBrFun1w/ZYWe0PO2NpR9GEkWh/Dvm
         xyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9WPv6FPpVNkoGn2RFiHU23q0bpjC3zsb6Fq3+pay/dQ1eW9g50MkUj8zuQHvsoB16c43kED1vBqeMRXcp8D1biaxfdn2s2NJzZhN+
X-Gm-Message-State: AOJu0YzJxQu4cX4iCqVW+nXl0mCvJNhsPZ48wdOR0cvu1eFutjUgWk6Z
	n0u0B8JaNQ7rKX9L/+V5FOuPcXPJCzbBF331K3ibPEISxizYIxLR5EU/DCntgpI=
X-Google-Smtp-Source: AGHT+IF+toXA1Nu3KEKk8hdXyTF86rbz9YOAD8q6l99vrilAUb3JIDxN2FfEB1nAafTrGIeh+79vhw==
X-Received: by 2002:a05:6358:8a8:b0:186:12e6:42b4 with SMTP id e5c5f4694b2df-193bcfc56a2mr3916016555d.23.1716301741198;
        Tue, 21 May 2024 07:29:01 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f6af98d9edsm3937397b3a.156.2024.05.21.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:29:00 -0700 (PDT)
Subject: [PATCH] drm: xlnx: zynqmp_disp: Fix WARN_ON build warning
Date: Tue, 21 May 2024 07:28:15 -0700
Message-ID: <20240521142814.32145-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
  mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, michal.simek@amd.com,
  dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
  Palmer Dabbelt <palmer@rivosinc.com>, kernel test robot <lkp@intel.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: tomi.valkeinen@ideasonboard.com

From: Palmer Dabbelt <palmer@rivosinc.com>

Without this I get warnings along the lines of

    drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: error: logical not is only applied to the left hand side of this comparison [-Werror,-Wlogical-not-parentheses]
      949 |         if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
          |                     ^            ~~
    arch/s390/include/asm/bug.h:54:25: note: expanded from macro 'WARN_ON'
       54 |         int __ret_warn_on = !!(x);                      \
          |                                ^
    drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: note: add parentheses after the '!' to evaluate the comparison first
    drivers/gpu/drm/xlnx/zynqmp_disp.c:949:14: note: add parentheses around left hand side expression to silence this warning

which get promoted to errors in my test builds.  Adding the suggested
parens elides those warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405080553.tfH9EmS8-lkp@intel.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I couldn't find a patch for this in Linus' tree or on the lists, sorry
if someone's already fixed it.  No rush on my end, I'll just stash this
in a local branch for the tester.
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 13157da0089e..d37b4a9c99ea 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -981,7 +981,7 @@ u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
 	unsigned int i;
 	u32 *formats;
 
-	if (WARN_ON(!layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
+	if (WARN_ON((!layer->mode) == ZYNQMP_DPSUB_LAYER_NONLIVE)) {
 		*num_formats = 0;
 		return NULL;
 	}
-- 
2.45.0


