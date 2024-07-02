Return-Path: <linux-kernel+bounces-238478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713CE924B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DAE2887E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393EC1CD354;
	Tue,  2 Jul 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV105S+F"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3D81C5A37
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957557; cv=none; b=nK2hl2+B1UxB/qndjtXlZmD+UvPffuqR9Hcivztrl7jkeqatNOTiPjmb/bwN0icNMVWB/ZeWKGPHTDmtB64UJB2J67bVMAuBFBMzV2OfbTVs+q+mqnC6+a5PT2iHaXRzHYnYkXBvV9+GogRgWflAeW4nUR+wyN2C5mS8wbZkau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957557; c=relaxed/simple;
	bh=jGiueC+Dh5EN2Lejau2B4bSvCKR8MfH5CgBIgeJvpL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTYDlrgZfbKgCOmlMj3NBSK1ndLmanK9z5jlR6N55XLoU9qVKTUzmSAjDNR0EMbub0ggY50Pc33t5eMIlAnVY/gHv2SeXZlQpNq1h4bsppjtLCV7wvDLB9ORFwL4OcnKmf08c7shV1eqS5/vQZJZ6HuNe9DAzYRkSJGQDECB3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV105S+F; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7f3cd64e71cso138068139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957555; x=1720562355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIsdMzCagTnPqkjtDJJFzcS6RuUfrVRwKo+d8V5q9yk=;
        b=cV105S+F/Lr88SjisUIE0nQEdsRjTH3WYhjcWXQngzzvzC2R0/cU+Mq+7Y7ZIzb7/L
         jfNKP6T+6bgPz+QOcz/SGc7TcOCsptpbTt0Ei45mQaJ3jEGfb1S4ui8oDt0fxZSPK7ZM
         r5pv0jAV/INgyyFTnRZDsoBF5TlkmZVh/DDXFVRfyY5XQXtSScIsRBlxnXOTSEnukR9x
         yfxbJX6NWg5yjgf23NKRRVub37rzSgjic3Kg/qreSkHYhhIkprT7bbM/460qNUoW/JT6
         1Z/zrLYBgr/nSiM9Hs3poLBEqx4C+vXTWL5XrHVjGZdzlRohjbbb5w/8XvQvpOnEO/RU
         NU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957555; x=1720562355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIsdMzCagTnPqkjtDJJFzcS6RuUfrVRwKo+d8V5q9yk=;
        b=hmjeo80xV5FnExIQE2DduaDo11gIfqZkrI3ffP0NlUgSMYpVfUD3AsDoVyF+e1fNf3
         K81SSJ2Ct087t5anZ43cxftrZK++HODQ/b0ulPwG2Y3rBMh5hMJX44oRe0v44mLvdBhF
         U4+XU6zVwM54HSudbkyxOu882IpwaqMRK7xJwkI+9SguqMErJP9UnB4w9fyWGQaSPdpE
         CgBelBmLzxTDPJOkU2nyHl/UarvaA+rC41aNTjxUsx9iocYBuzRIE0IIGZ3uLbm49kLc
         yN9hggOWIHgC8VDLJJqo3DRq8ncZw7/dFVBLM/z0kZCMS3OqvDQxKvcWIZ3uos/BmJgV
         TnNQ==
X-Gm-Message-State: AOJu0Yway2l0rb8tOp2LBBoMeFsSEbdLNYOxhyUcqAucVbY72qSVDWDp
	aUPoDhgjG6MyEAx+vp2Sh7GqeD+ChLrwr5DJ1oMgBfQ1cr+a7Ptl1l7Kkw==
X-Google-Smtp-Source: AGHT+IFdYfSSGOVrNg8Fii4KNPEZjcEw1XtdTCCtZkWFk6OqEpHnTijp+0TjJsgDqve7B+0xLFhnQw==
X-Received: by 2002:a6b:6113:0:b0:7f3:a7d9:5922 with SMTP id ca18e2360f4ac-7f62ee0c850mr1132473239f.8.1719957555439;
        Tue, 02 Jul 2024 14:59:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:15 -0700 (PDT)
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
Subject: [PATCH v9 42/52] drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
Date: Tue,  2 Jul 2024 15:57:43 -0600
Message-ID: <20240702215804.2201271-54-jim.cromie@gmail.com>
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

etnaviv has 5 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs as well as plain-old pr_debug()s

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6500f3999c5f..1d1ddbedcb5a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -25,6 +25,8 @@
 #include "etnaviv_mmu.h"
 #include "etnaviv_perfmon.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * DRM operations:
  */
-- 
2.45.2


