Return-Path: <linux-kernel+bounces-238468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9C924B30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE7B1F24032
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A72220FAB9;
	Tue,  2 Jul 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWSCatHb"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243471C094B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957548; cv=none; b=E//Cs4D1SPYevaTifXlZ1Bc5uMLSvmaYzcQJid5Ao2Ip5KmHDsJHycZqqbqgDOTqp2aedkzrhdBIEEkbmPyG9SvLsZusnweo0K6JTOVHNSZ3kxU0GuQPFVyCUQfqjlEcnUtOE/WHO4/yJpWfOx7OR4yv+EQ30h3uZW10ODeAUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957548; c=relaxed/simple;
	bh=LByawjcddd6Y7jpwbDz/sjAV8w3O5QnZzc7RlvHGwag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNKJurdJibVYTgLoKLt7dSfBVQkIL+UaX+w9PaFUHQVBKkk40kmAklDKS4M01K9We5TSCTWtApdCtOCl0KWdblBu097MDUt4AqjCIhyF/FVvMTHgwnkkt4Myas6bLBRH0wJTKjhPM8QF4ZIPgx/qlRaRDPYkz6YWeU6LIE3mfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWSCatHb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f65a32a58fso21873739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957546; x=1720562346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tTLQ7kYNablnENIf/KeDz5dGwor+/R9FnQHvwE/Et4=;
        b=XWSCatHbWhwxnDw84MkGqFcLmSjhA3ehklioVrAE7IPYc1GHw2HQUL30dwcbx56gL2
         NxjICkHlkNznR/J4Yraiq2sknNSljEL2vjE0CkuuMWgRFq6M/XmGxGQ/6N4d5E7SjkOZ
         z1AWG7vXS7gcxD7UCi66LLbcWDtbeoFMc1ftd5C15vNXDjoZ+X1BjSvPJmWfiZlXtJRB
         9lAVMgAk5l6HZmWM5DPSZI2azZIyN6t4MT/qjHNxSiQjlaBw1lJa/0VT/Ci0ciN4zJ0L
         lZWO7qKK/8TOLNJPHLC/m7FpJwwQe0UmTI8E8cknDgL5X4arXqNhOWj4Emtz2leyVkkP
         MTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957546; x=1720562346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tTLQ7kYNablnENIf/KeDz5dGwor+/R9FnQHvwE/Et4=;
        b=F4Usyhn3QuFEBwWAq5NDGV4Znvx0O56aIM/73EV0g4ys1wLftp7Dh75wlh0v5+xOtC
         cpR3Ya1+jl//i72PvxfqbHzanBzrdGv0uNtzrf8kEi3k2TEmUxZpb3ClRpQZUZaRxWNk
         v0OT7vyql7PTXbOF+pOWlmeUMi2PeL8wXPwo80Msl/EWjMKUww63Nu5Q40Ct+RW6gplx
         +4e2byGhvcp/yP0V8nza0CwkxAfTHPp60OPTrFx5yBHyZi5tMETB0L0h4qLIeRvoKOeb
         71lDq870l+CB5mwWyPzdCw5i1fKRV9lhSWgrE8ZLw7E+ES3iZwdPf7hXMiPRVK1Pi0dZ
         QZRQ==
X-Gm-Message-State: AOJu0YxpazR+ykpYm6y7HOm777XrSX4LGBoA7RtzuNGzZgSgR/eb38xz
	VHrTtSo8PtXjxf/MKICMVd2qW3oxEVTopVyYxURvWbjKwuniPNn2
X-Google-Smtp-Source: AGHT+IHVzUq+7oBbjRhtfUg8hR7fA0Vm3TWdJRFj0erHJhGLHrI/NeeXyYjOwGHjAwtUEfGXKXA+rQ==
X-Received: by 2002:a5e:8f49:0:b0:7f6:1d7e:a9c9 with SMTP id ca18e2360f4ac-7f62ee085a0mr1058272839f.6.1719957546282;
        Tue, 02 Jul 2024 14:59:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:05 -0700 (PDT)
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
Subject: [PATCH v9 38/52] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Tue,  2 Jul 2024 15:57:34 -0600
Message-ID: <20240702215804.2201271-45-jim.cromie@gmail.com>
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

Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this tells dydnbg that Xe uses
has drm.debug calls.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 87c10bd7958b..c61163d0d945 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -15,6 +15,8 @@
 #include "xe_drm_client.h"
 #include "xe_trace.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /**
  * xe_drm_client_alloc() - Allocate drm client
  * @void: No arg
-- 
2.45.2


