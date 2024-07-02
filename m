Return-Path: <linux-kernel+bounces-238490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7739924B46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501691F21742
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167E1D5A39;
	Tue,  2 Jul 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZayL7fBD"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AB1D51CC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957571; cv=none; b=cNGUjkl3VE1KcRJjwQ+FwfrMbqsZF8nQpqITk+FV2f8AMvwpxQas73YC0EyY2/vSbISckP6ryyYg38gr7nBxtjGs+QfoVWi00k4M88JYFPt+K8RN4qxZtWgw5phLshqZBIxfVmnKpVer57mvCtw+GgXfMEq+6sYAAGjq1IOJBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957571; c=relaxed/simple;
	bh=y0Zoxeh2NDhcrC27lg8sSPwKxWiQbpVmdMoWiREKFWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FE9A01qLjiujTK2GVTbZDw39v6VbVlbDbmhh8G+Uj3JUo826sc877pkUtvvhqQI0CuP1B6HKsx8BV6KUA9fc3fdiRi5hTMFxbuxFy8UIz2rRO6Jz25OfW3nx0Pq73wCFNeJkTc3Dzg5BiQqspbVS+3PoY1Npcp4Lv8VH0I58n7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZayL7fBD; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f63db7a69cso142365539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957569; x=1720562369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0YsvOK5afJ8qV3rkuOU7CKX9HpGcds0hiKx8bDl++s=;
        b=ZayL7fBDGeZb3xDduuUuU1fztwO7x2rdPiY5YLI2HNyop3bAvHdzz9IP/vx5wbd0y3
         wOGxJ+7GmmxkwrFk5YFPohDdHHpicpQkQkAWPCiDpR3yZfazY0oiZyJaAnm2N/PpmTYo
         bFwX5B/1fUVr/lfh7GSa57ZmhaZzy/jQsjf1wf5uMS2aYo/pKJWE51MPtBOSySDu845Q
         ijk0MGUNihZv6Iy1RoxX2nKtOUmoOG85UR8nOj2NylfE3s3hOP8QLAEu6cyVAgVrqNNE
         LGFnQxwC+CgC7iCLTPqjMveeJJUIjcxS6FBCtM4hi45ZN55/0XmzhJXqmOKcoqoHUrB1
         jB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957569; x=1720562369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0YsvOK5afJ8qV3rkuOU7CKX9HpGcds0hiKx8bDl++s=;
        b=qA+eOd8M4UJeE09VFZHQ1FoalCuIyrG9rzmNlsGfOGeaWMfZunVRTN0pwNMu5rkQtO
         fsPtKLktu49naaNcvxfRgMe17QNEjTXRvLjVY/CCVKippxXi49zr5Kj8caWgjno4tmSM
         vdN/4UiNmnZ+P3jadYKMulmXrOslsc3r2OyGsRBY5TEsqbqRJUmI20vSxbJfJ3xh+6tf
         Txh1YeyIxNJydd88nzu7TaW/9HXaYoVAGFTQIlk26QasJaHoQxbj2O9gtyj1yz1hGmyO
         HaJf3YUSRemuAql1aAGMhwZzYUIhOs56OccpOVaiMx0c/TT48/0c+P+Al6Q4CpGI209o
         kDpA==
X-Gm-Message-State: AOJu0YwY/XZWVfW++2LDDjPPHlmrLVlY23Dr3YK+MZtp1mpceeIfNMKQ
	w2WcxzBLWTa26plU+5Oei3OM/IGQzi+6weuEP5GznmGEjcZKKCsV
X-Google-Smtp-Source: AGHT+IERaSF1E7hyGHvqAXteBQDKZ2gIbvbhsAc5+kpyvD7v6UTlnyWFF6UFWiBkSylriwtIgT4LJw==
X-Received: by 2002:a6b:5103:0:b0:7f3:9bde:f44 with SMTP id ca18e2360f4ac-7f62ee6eaf5mr1109295239f.14.1719957569649;
        Tue, 02 Jul 2024 14:59:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:29 -0700 (PDT)
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
Subject: [PATCH v9 48/53] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
Date: Tue,  2 Jul 2024 15:57:55 -0600
Message-ID: <20240702215804.2201271-66-jim.cromie@gmail.com>
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

The udl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/udl/udl_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 3ebe2ce55dfd..ba57c14454e5 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -19,6 +19,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
-- 
2.45.2


