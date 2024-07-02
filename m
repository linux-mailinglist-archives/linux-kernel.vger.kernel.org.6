Return-Path: <linux-kernel+bounces-238493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9C924B49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C6CB22A93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B21D616B;
	Tue,  2 Jul 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvtZd7i0"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66521D5A5F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957575; cv=none; b=IStvtXq5aXXKaGNGJBL1Tqt/2ggPCNcrw17vus3ljW+/MLNxvZ08v9qfgrRzBU+807dhI/jGePUA5bKV3KDBZfctP75jcsNB+1nJXEE5t7KEx7h0dt1w/1BS1kGp1rFCRY45hLr+A6dl+trd9bCxzTsT6m1zJaKm0OArJmT7L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957575; c=relaxed/simple;
	bh=VcaoUfrcouQV0gFCR662Kxzm42SL0jyYYKIh4ngnOzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpbFr+RBr0rGJw+PDngiSSniyNxQ1/NuSrkthZKpmwRCvxbF8rtWTmpFuYIDfFv6HNRkqntIlNQ8eA8kYTMc+22VeGQh0gyl7MZ2QYbUqMSsN09fGhA4ugcfQUR7b+Q8WE+hcumBQ7BJ+Kv4CX+/MtXakHh8LEHc9/b6n1Kkp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvtZd7i0; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f649f7868dso113951339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957573; x=1720562373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdxS3Fv+DdtdyD/OX9RwYgW//DQBvhU2TaujYV4igeo=;
        b=KvtZd7i06r3sIcEr3lpypC4biScgTmhMfVUzX9koCpVu1TRj6cwZRis6SZ4T/e7gfW
         86LihYia1smKtFqQitweBysh4REzmMnExAfo8fB48RWOR4oD0r7wC7a8P0cnNi1GjXGd
         CEJFLwdcybyBPKdJo6d/UvDyUdVBYVxgAQ7QsjVDV8i/9fj7jBxJiblNT86HYWRDGOMH
         koGVars7YSm1Sy+BPStVee1TnIl0Lq3nlJbMRskZa4XemzxCm2io+liHzLrIvHOAabig
         kjt8D7Il2NW19WNLl6OD7l7B5j3gMyuqnSYNkHmoLfBMCEopQA5pi0+fxWfgW87qFsnY
         7C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957573; x=1720562373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdxS3Fv+DdtdyD/OX9RwYgW//DQBvhU2TaujYV4igeo=;
        b=vj+8j8OHFHUvEqLd78hwpAYre+e3xQFMm3Vj0GA3KcB4gzTUm6VoPn39I/sbnCDPa+
         Vq0emI5HFsVaPkGi1l1p2yq3STeIpV8fVvU5+wnhDfuzj/0ygdILCXMHboTrOoWtv8J1
         fjZVtEonxg7lQtSpiDVamTbiTyVEvwRs/RlRB35/oGuC43g53i1txlMkFUwoBxSl/Kes
         vvdg+52slcwqq0+cmdqUUWxyiUwczBedEY1oN0MsF/VLKwDvhRQpVG7zM3JqN1AU8B6+
         OCD/8dnQGENXMIH33oLAyL+FCW3XrMjoVdgFelx8WmZf10wCkqIRmOr930nxeuR3/WcH
         U4QA==
X-Gm-Message-State: AOJu0Yzq1Dhg4i/GVmczUycSN4eAx8pLbt0blIeDCLtxe+D1cK4Dadim
	PJVpGthx+rlS0pndEtPr7rhFxCyZxzLHYyzQ4sdWmF0YyHcLCpwf
X-Google-Smtp-Source: AGHT+IFp5rzNQzwb9sgT1JzgctraTYuaU8bCdfBAOCqgX/PcOHZ/BlCJIM7oWH0DudtrdomfiUMnhg==
X-Received: by 2002:a05:6602:600d:b0:7f6:5035:1826 with SMTP id ca18e2360f4ac-7f650351c42mr444974339f.11.1719957572948;
        Tue, 02 Jul 2024 14:59:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:32 -0700 (PDT)
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
Subject: [PATCH v9 50/53] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Tue,  2 Jul 2024 15:57:58 -0600
Message-ID: <20240702215804.2201271-69-jim.cromie@gmail.com>
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

The gud driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 9d7bf8ee45f1..5b555045fce4 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -31,6 +31,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
-- 
2.45.2


