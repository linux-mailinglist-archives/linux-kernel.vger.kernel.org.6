Return-Path: <linux-kernel+bounces-254305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6F93319C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF1D1F26EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA91AD3E6;
	Tue, 16 Jul 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNCHlsBy"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA51ACE9C;
	Tue, 16 Jul 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156374; cv=none; b=OQhhzYWBF8a5ppc7dLTtI7J6h2aClrU8NFQnvZ2myLiEwB06OsPud8be0/24k0ZT1b/CDIo0QlsxhbME9IdgcWK5Kn/diJCL/DhgC62CtM6sPR00DqEc8DHGA7l1/j1P58m0YUNjZQaviXiQc6DbGLD/a9w9im2VSE6hHTqHNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156374; c=relaxed/simple;
	bh=2OnloY1X0a7rOUMOi6pjoyUyTvSveAIvNazc7EXQIsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKolsXixDNtL05s/Lome+3tdiDyOdQFhE7B4SuXwlXOh4bPVonhFbt5IHuD+kmX7GiU8QlpuNKu0SlCIwLDUgtf9aHaLLLcLZyH9n1yb4ypF1i+sVsNKYdy+RDty5BRekyEktnZ44tzy9tdTdkfnI3CL2gnLW4c7y4tFTz5vSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNCHlsBy; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8076ef91d8eso6276239f.1;
        Tue, 16 Jul 2024 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156370; x=1721761170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SFMpYtWIMdGDFXAXC7/EjtlRd2ef06a7BB52SDKmgM=;
        b=MNCHlsBy09YYUiaDkDkTeZpsDt5iaHT6lOWIQvDll0PCxVJjrd/iaTHHR4DzbHlRVA
         WuTD1O1SHnx6cTGZEmcT3wLrAOz/qnuBvI4JYrxKiG4njrkvukUNMiotxomXV8ut9Wfb
         Fw42ugyB6qu2gmwm1GPOECkJ1HFdf01kLI6Bv1FNr/jorNgM/m23oIlWf03le7b7ldrD
         YqCNKcLj3aImOyZNpZMhSIYKHTBoJtCiJilefv+dw+1l1SApo27FHq1IphEiBMSoiybR
         9P6kx8aPgN0sTR++gRyMCsRCG6Vts05ZUwB9K4dMdoCtClUf/oblBQgh41s8wxD6xI8g
         FV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156370; x=1721761170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SFMpYtWIMdGDFXAXC7/EjtlRd2ef06a7BB52SDKmgM=;
        b=pXX7wua5LZobRwR/xps390NRaWbDJEubi7cyvlsQH1VcrbeUwLGozVblh/O/b1Op8J
         TxHpVF1YGdwUIpItmxUmCiClp3iwT9+ozZGz/DGB9530y5p5nTAvsZA2Yi7qaVL9dclf
         HStkCxdmSshJxaE1WcVltWVPYM86muXlSfrfjiP3WJUMQLO0BLTu3wFlT283uwTJE5eB
         JCUWd54ME2qtfcskGrUXtB/BiqeNV1XVCLKtJsemCVDE7aJtiTQq/90c4+JOdsEBr0Fg
         0xDzMOv/UUnt1OX/aTz10fm/xisf91DoDjenLXi6peufFxf1MDUTdQtLt0IB9XQ1XQ3J
         6Y1A==
X-Forwarded-Encrypted: i=1; AJvYcCVxT0zQ/qzjiGom6zu2afAu7Fa79MUgs3J86te9IEKflIGDWJkwB6P95HBm2EFH36fdlvE+TNHGjvOjFvLFfAjmWIL09VC07Sui
X-Gm-Message-State: AOJu0YwVqWTBmBBpMBH/OxFwzwMRtmTTd77kRTTD43P+jUAFz2C2cw35
	qnv6oXpA+sjksqzmYUhPXAaA3kfd9obG6otODMPyYVk3uESAY8WPlYFoZ4hP
X-Google-Smtp-Source: AGHT+IFNNv9vS+/MrWaSGvQuA7wRhxc0WqtmfqfwoM/4kcX2nyGI9RecReeel4bYcF/zOW5GGLx/pw==
X-Received: by 2002:a6b:7c4c:0:b0:7f6:8303:ba80 with SMTP id ca18e2360f4ac-816c3aabedcmr29885939f.11.1721156370398;
        Tue, 16 Jul 2024 11:59:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:30 -0700 (PDT)
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
Subject: [PATCH v9-resend 51/54] drm-dyndbg: add DRM_CLASSMAP_USE to the drm_gem_shmem_helper driver
Date: Tue, 16 Jul 2024 12:58:03 -0600
Message-ID: <20240716185806.1572048-52-jim.cromie@gmail.com>
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

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 53c003983ad1..2b269ae9ea18 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -22,6 +22,8 @@
 #include <drm/drm_prime.h>
 #include <drm/drm_print.h>
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_IMPORT_NS(DMA_BUF);
 
 /**
-- 
2.45.2


