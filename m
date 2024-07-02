Return-Path: <linux-kernel+bounces-238483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF6924B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628BC289556
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF21D1A1A;
	Tue,  2 Jul 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU4soTcV"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A61D3084
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957564; cv=none; b=uTFxHkKRvmU+iPuaRbhEevvL+JKqEHcjBtpZq+WLK+cgdXBVBLakvJdWzCtKKhf9i2HWaEOqOxBF0TaMEO9O7E6PkMit9cco/1csq8ccH1224bG7vdDIrAEdsuDRiUEOHc7WaRsEfti5BqJ/NWJAYU0liE7s1ShYpCCYzOOb0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957564; c=relaxed/simple;
	bh=iX3YPrehKsc8JYsY/MYFOXIO6YJ0coOili+oIW2ckmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6VbWlStn6xOWCrPr856VEKnXrrkWvkThvKpuU7kGUdFVVAQlJTQgFCX22dUOa9E+32YZe/RaZf8rkToQ616hVsgBMIvVSj4hBhcD/LzMX8Qa6VU7nZ1ysLuvVPZUyMrBn5hRIf7wRAUfVlHaBs9irg+NL4L+hlG0+yOd1s1Etw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU4soTcV; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f61549406eso180477939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957562; x=1720562362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Eqreo55RWzciyFbwYCY+bKp2K8wKhzwrrhakb4uDM=;
        b=FU4soTcVIx12MkyiaNVmjhN+aaGkwtxuo7YAHqEjT9jmBPAYYJKuzXVjZYSX6tyxBW
         +wFLHbe642sAYBp3Rw4U61RCHB3CD64L2TVQDjO2kAnIArd6bUu8oJvUDlB/YZmyXBuW
         HCCTSvjzZ5TC/CkjtL2Cow1hDBeYUoBeDIauafRk7qi4D/Uv14ZpbYLJCxMnrw3PPjuW
         nr/9zC9yMtrgJzLH6Jvl+Tmf7bjFm5Mw3y+3hvFcp30kbUNaHxyZFeNK5I/FlRomUPoS
         lM+BASTtS3uAqYYBbv03wD00UbKOi0MtDh48elzY+RsCa3c+STd/BVpkl8ga8XSvUrzv
         K0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957562; x=1720562362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Eqreo55RWzciyFbwYCY+bKp2K8wKhzwrrhakb4uDM=;
        b=FKvZm/rhoKD1KalBHYLzYu5+0W25hm67hwPwO4jvhswXqRKGa8LQ1hvo2TBua5UxXM
         ciTpLUVvlg1D/EJTzXftEkJaQVNLHFjuy7+d2BXDhtfgS5QBX473mLB9CS8GdYVkernh
         62p7W5/OGI6vveluDAmPVPX3tWWSRPbEbOiuhmc3ZjuJV3pJIK/bgMrUU99f5Rz4/+oA
         TWAaKzObi2U4BfUyzXtWIIl+TFH7lyez9Dvs7wSqtV0pstUuOcDfFe+kPWuGO9Miq380
         bt7mRuGOnyl2xwhLP0a1Crp8b7xM6QJF/ENbOIatzc0HpqU6DQqnjEpPhUrrfjtL7LOV
         WeCA==
X-Gm-Message-State: AOJu0YwnSyuD1A9bG3sUeVxakSHTv53TjYsMJhmFM7ZRqxMvC+Q4/po8
	wxjexwczciKGZ8V6FFI0cstIQhMP15LP0FxcQD/PtnXTYQuJYasN
X-Google-Smtp-Source: AGHT+IFbVFUYm+0pu0T514FItDcAvbDhzBeP2fYzyyuJhvxQn5GvEZPQBzd7j+fZ1Xji8n6rJpg1qQ==
X-Received: by 2002:a6b:cf18:0:b0:7eb:7f2e:5b41 with SMTP id ca18e2360f4ac-7f62ee196dcmr1130557639f.9.1719957562323;
        Tue, 02 Jul 2024 14:59:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:21 -0700 (PDT)
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
Subject: [PATCH v9 45/53] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Tue,  2 Jul 2024 15:57:48 -0600
Message-ID: <20240702215804.2201271-59-jim.cromie@gmail.com>
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

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..d22308328c76 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -247,6 +247,8 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
-- 
2.45.2


