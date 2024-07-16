Return-Path: <linux-kernel+bounces-254292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E73C933181
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC951C2164B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79231AB8FE;
	Tue, 16 Jul 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGLrWlTN"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95201AB530;
	Tue, 16 Jul 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156356; cv=none; b=j8ZJfvOGC7PPCwIDUlyPKp6eowTyifQwXKykMeyuMT6MgNPDTOh/ecL5nxb+enbJEC048KCPjss3J9C+GcGQFVwStn40wegs5SpirHHLS3GDGOMHoUkmLP1a6Tg00b4p9YVptZozOEiAfoGVzeiTahB/HwqvkktSwcsclrv4CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156356; c=relaxed/simple;
	bh=rtayNFZqbsyoteA9BiS1vZ4JECzl8M/Zbo3Ltgx4d9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR24UC32RxU3kNXVJ/J5jTusDVznoi9eMgAPVzpAPJJUmqbQUHf1JW0/Nkq9uWxV9O1KPFBevDPICfyy3rmk2rErizYFmRI2HEc3oG0dn5aak3+qqyBgjCQLdfPNL+dgBgSKEekxpNpMnwT6+lDnDKemrei2HVA+0s1pvMGZsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGLrWlTN; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-816ca307407so4164239f.2;
        Tue, 16 Jul 2024 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156354; x=1721761154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js70Xgv7tO+TEiqyDegu3yGlviUzyyQPsaTm0/0JTcY=;
        b=gGLrWlTNzyaifONAT9iO93h7CMO9IxxhKAL3otrlAiZpCAIQmR6CXUmmAwIBtbXYMm
         pWNrpiVCXvykoJVqotWu/ok1uLhLReiprSNg1ZpTzoQ+dOWgp6KzmfxEGfLVWW+Cmaqu
         auQtI9AzvFk5er+Cu1gQkPPcIYyFLM+X/p2Ly+m0EqiNcAoY+P0fMT9P4n1Lx34Z1HpG
         JvFQfeiLKLoAhh5iQAQXPhQJ0dJNewddwYzDEbJY7gb4FHpwA+l1qCQFjgZaIxHJA1VE
         mpMM2zS/lVdU5SDXYQQSrqKloqZXgN83wQLgbLoOZG+G6qi3xiFIzRT+3Jjfqm5WUl89
         Hrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156354; x=1721761154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js70Xgv7tO+TEiqyDegu3yGlviUzyyQPsaTm0/0JTcY=;
        b=cgpXHMnAulXjsnI5+47+hGVNG1sU++r3KTXXZcBuKnPTa/pjM3t8HJsq+PCrj3UTCr
         nmrlNltLQk3/XWr+ZVIkn/NrsfZPBiHu77nxJ1RAKsZ0sul9WHRcS5P3f3Nfh48gzsuU
         Fr2Tsk7yMUwvb3/gv9wDsFGf1YO/V5pPU9xXf59UC3Zk2rEeWV9RnUH7le4CZzsSjiN3
         ndrV3EimrUHIHMA/hyxNFraPc/WKnpSeN/ghHZGv99MY0GrdmfmY4GuEHJjRSNLFrlps
         h6V2/iv6nTOvrL2kDTmy6K4WAQf8l4/QAwb4+8kk52GZD9zlqSQMvIfViXitua36PwbQ
         KoRA==
X-Forwarded-Encrypted: i=1; AJvYcCUV+Ih3Jq/v80iRvyyncyzQexX2VqBYk6CCVCuWyQTu+6qvx7a9ZTMSK7hugcaTn5o8SKo1esTqeI9nCjdjBjCSyR27x7jYOQsQ
X-Gm-Message-State: AOJu0YwSF1So/FD5ZF326v5nnO46MqYaHomOnunlVyjVPaxPMDbgiuYC
	TpOgxhTfGcW7HFQVWyyCFfH4mv0QpViLT29zKRYodz8Wc3Al+kLghWivgS0O
X-Google-Smtp-Source: AGHT+IEAAxHzBu/3CUMwZXKcGeHVjTG9/MciUgkGKMQnclLMbDsGFn2sctNnI8XkLFXsXcs8f15EyQ==
X-Received: by 2002:a05:6602:2c91:b0:807:f0fb:1192 with SMTP id ca18e2360f4ac-816c4071593mr42423439f.1.1721156353753;
        Tue, 16 Jul 2024 11:59:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 38/54] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Tue, 16 Jul 2024 12:57:50 -0600
Message-ID: <20240716185806.1572048-39-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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
index 08f0b7c95901..ffd6e237f3c6 100644
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


