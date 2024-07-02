Return-Path: <linux-kernel+bounces-238472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADE924B35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10EEB249A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1157F1C814E;
	Tue,  2 Jul 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYtvaE5b"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5611C5A34
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957552; cv=none; b=QMU1kHg9uku/XQbw73ItPJmfBn4NPaRMYSA46HCh8E00mvEAWs5LLx1T3b3DbO/MiS5pqFM7LfcviyU9NYyRAav75flimP3tD7NvI3OG7LYSV3Zuk/kV5jWiCmAyDIcEF3xR7X6qaX3oagcFX/cly8YqBaHVxC0l9ISU1ZuLFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957552; c=relaxed/simple;
	bh=LByawjcddd6Y7jpwbDz/sjAV8w3O5QnZzc7RlvHGwag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzoG0hpKnhWnbb8TW6hODSU1aiytf8/KYeDg/qJPAOvBn1MkSIFXiniCY64uZ6FOJ29dZ/l5kQzMh0IKUHRTJXBE2PbiaoW2x/gxOecdQdhAxDJgGbxaRCQvSzpP3GQ/WbDcqhDno1wkzqGxheWGGqb6JoK0iVy8N5D/OWqWIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYtvaE5b; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f61f41eef0so205092639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957549; x=1720562349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tTLQ7kYNablnENIf/KeDz5dGwor+/R9FnQHvwE/Et4=;
        b=fYtvaE5bzZTeVGwixK4JagclUCVImxuZpC+PrAPyo9VyKoLJ/QqC9dzoul5sMp/v89
         UORd/1JRf1r+c7K8xHV9mQFSPZF8TY79DsHhbSekqSCtQgzEGGvqCCbfOul5B6uQUs+l
         L35PPMzR8nySZ+Q9M58vz31VNlT2bV8sJQ6BlZawwq0vjG9AcB5R6nHn56frpKc7nLiF
         d+hzdEMCinwQwHrxmFwLEVYXyHPLPeqkmOuj+JfKI0PHwXpwGJiCeC6rOFAxuyGlyl2l
         3G1yA7m2zwxTcvaaOnFSb4lZHCm0LMeJiIwWVAvrV+MiJQ+hVNgSrz4IpoJ9zuLiw0Oy
         jWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957549; x=1720562349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tTLQ7kYNablnENIf/KeDz5dGwor+/R9FnQHvwE/Et4=;
        b=tRMkIell0DA9BsBmdIW854LPt65hGWo4fNbtlTiPD6Yvl29k6fo77CxurNaqnIU/6L
         uTCgrm2fp+ILCnHqEAa+o5W7WmvIBFeeYlwVqk/ur3Ivyogr0/tZPrrKisNJ5hzYumF/
         qZShF/IQD9+U4uuNEZ/hO55KTLccTu7js/ekmet8oY5YD2k3lQv62U/XovaYQmxxig5d
         5Y/RbwdAMPRuudhKZ6PNdhMG9fMfTpW92+VX3mbUlrj5rOk1xWnfi9nfMU6phx36zfe/
         94wuXdP+hjh4Dnlhu2fR+eM7OxcycrAPG+JT8wwr6Gmi3JwJYso1k7+AvsPR/07mP6C0
         HVvg==
X-Gm-Message-State: AOJu0Yw05Rcxsmib5J1KudmW8z78Rl/qC42OpXIhVeroFebEotwSoRfq
	QTL8sCaup/kBDSdDEE9ZdWrMDVMxrEV/Sk3A7Km7MyIp34raJkM1
X-Google-Smtp-Source: AGHT+IE2I+kZLU2rS/pXH2LWHejqkkSB+OxH8ZpJWiyY2BdB6lV2bIk60uhOaSqkSLWh+0iOsTHn/w==
X-Received: by 2002:a05:6602:1651:b0:7f6:51ac:bba9 with SMTP id ca18e2360f4ac-7f651acbd92mr409692939f.10.1719957549276;
        Tue, 02 Jul 2024 14:59:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:08 -0700 (PDT)
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
Subject: [PATCH v9 39/53] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Tue,  2 Jul 2024 15:57:37 -0600
Message-ID: <20240702215804.2201271-48-jim.cromie@gmail.com>
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


