Return-Path: <linux-kernel+bounces-238495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBD924B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CF2287AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64F1D691A;
	Tue,  2 Jul 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIc7wcOA"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2971D616F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957577; cv=none; b=Z/HY6q9EfJHxX5NEbChzZdzWAL4+1LQ36C4RFJbZaENxxjdSCcT3W72rYCO/Mmqaw3nwiH5mNBAN/AoWlz3EOQvsTnpE1DktqspxBMUqYnUtieHQMVWOM+ZGjwYWU5b3SlJtrvgUld0FxIw8LqDiRPjaOOS7jok9yRjPTJPP+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957577; c=relaxed/simple;
	bh=RLkL7ykGMweuG/V8iZOSvPEUEytBCsbn4Qh/HeooHHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDSTOGV/Ze+LMfsIVH/tbyTUs0hLkEIO3wi4vYRSFuKXlNgLtxfN6xK5EAu9twCbUkByN3elWJo6xA6/RblUSFnzX/GXuCmza2fKIKdQHPnVfiM7ZD/VH6tUurLP15jZ8R6TulBd65iMJLwS2DbsptK+zACzP6CaRcGXsrEk0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIc7wcOA; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3738690172eso21851785ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957575; x=1720562375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvF7XGglS4kHqkr9T4qnSlSKUYwSoR5J7DGEbyHu2+8=;
        b=TIc7wcOAyWs8XCSCnZKkQnzFtxX7Pb3sVLwGuw9cbuwX1VZf400p0SblVy4DwamdT1
         LYLGMuD85DXWi2pKrlysYavl4wfQHMsHTwEevjZni/+/7hAQadfzL4aXltrt50/3hMi9
         5ZRsDCHmeDce1rVwQpi8f2tJFQdYgwteMmqD8pRMqWJLPh0BjVPGhoqHIdvGkv0evttW
         /Ceh3AN0bHwzxBemyPPvkrbIaUGX9A6zQpUC8Fm7AVZeEC8BSariNvf8paMHIM+ql8Tw
         6LYrZ9sn99BrQgX8kvFlnCJEED/iA6cfGu5eiEvL3e8+f9nM2Eqhi4Q+Pw5zpdXcM36c
         d/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957575; x=1720562375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvF7XGglS4kHqkr9T4qnSlSKUYwSoR5J7DGEbyHu2+8=;
        b=oB1oTYZpgvEXFGP6LuIY0k++rM9hK4iZBdGeX/QwQWG/opZvFKP/IpMNBV4fRGoL0V
         +H2x3Qbz6PS6iMCNEICBgDrVURcZI4at0OQ2p/5atBgspbgv+Ku0IMs9Sa310EMXRLCd
         mQsi/2vq5vSFG5TmjpglPFIqJ8RWIHRGCDmDHPG5GwJHD62JtGaoCV6fUdpci/gyL2fH
         9ag6SugqJOeHGZ/D8/RHyqeCCeEtyvAF2TAlZeGs3pEa45Vdb26L5YDPPjodWWviEWGo
         sfQpi8+DV3HjIWdLRf4/bZcm7z1kR05cjFlv3kiX5OPk+sWMKlT/ozxOVJd6i4SNr0nq
         bwhA==
X-Gm-Message-State: AOJu0YyzATRKm5hI9qLEmxpEEtG3yNoASH0xtjcVr/D4yk/C0HRTFrP3
	eKB2eD3N5iNzeSyajMI7B2ArMFlYC0/sseYaWhZN1XyTCmTig6WT
X-Google-Smtp-Source: AGHT+IGZOevniVKgdZW5uEHvGIJ0Kpl5IPSqNwolDmOHxjI93GBuoaqkl3SY5q74c9J2pIm9X5kn6w==
X-Received: by 2002:a05:6602:178b:b0:7eb:776f:d963 with SMTP id ca18e2360f4ac-7f62ee1db5cmr1186035939f.8.1719957574846;
        Tue, 02 Jul 2024 14:59:34 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 51/52] drm-dyndbg: add DRM_CLASSMAP_USE to the drm_gem_shmem_helper driver
Date: Tue,  2 Jul 2024 15:58:00 -0600
Message-ID: <20240702215804.2201271-71-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e435f986cd13..066d906e3199 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -23,6 +23,8 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_IMPORT_NS(DMA_BUF);
 
 /**
-- 
2.45.2


