Return-Path: <linux-kernel+bounces-254301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA5933194
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54971C220B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6C1ACA32;
	Tue, 16 Jul 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0ph/9w/"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F11ACA10;
	Tue, 16 Jul 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156369; cv=none; b=Osd3yE5uD2iQzFKMUYuR2CjEop4zYKfHwazusKcpzDupoWi47CxDOroFNGMTzWDIuKEuJRyvQvthILE3RAoxRkA6djRXajnZE2ZnBKi+St2VynFkk0mnHvCItgcE9Xb1Oc6EGtVE1Q1bwvUdF+4gHcvXHpMMc0UcKdRaPwLDFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156369; c=relaxed/simple;
	bh=y0Zoxeh2NDhcrC27lg8sSPwKxWiQbpVmdMoWiREKFWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEYR0DqC9UgWVwUPVbgS4B/KOnr7HFlZYFAXvKSiAKDZvW67vumIHZAS3rhXf9My2n43DmQHA3zE2Xge00VRc3sqdaSnFExjqKw3dDGIGruXW5rkd7acmJCjGAEUZUuXUHRMvTifaVphX/R30GIOQuvu40R3fg2l3dIxUMayyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0ph/9w/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f70a708f54so6577139f.3;
        Tue, 16 Jul 2024 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156365; x=1721761165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0YsvOK5afJ8qV3rkuOU7CKX9HpGcds0hiKx8bDl++s=;
        b=X0ph/9w/sUyeFk3HjpCH+EKQUpleTxUxhFA2P5q0uOmg06FfXCJQE/jLtSrTa5jKpS
         mNpQqtj5ESg0+sVrjgxCceacXSB/VNwk3FeHOEa8JYS+cU/D/DEu85kZ78Oqp93OVV40
         tojSVsg6vB2sqpqIqr7cx9oc1hzZSubuvwWpe56goDDUPHbkeUoe9Xby7ivReUZtyFPB
         sWiAVC2IoNpTs3aRlmpsGGZYjgovhW4woLK31x35EBEcr5+cOcQiEgxXP93hmLf4k6N0
         ZKAKrDC6BaJskcwvWzVUUcJNmK+2xuczFC9mkBi7ckjw3ibvfRz4uqA6mDzN2XZYShpg
         DfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156365; x=1721761165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0YsvOK5afJ8qV3rkuOU7CKX9HpGcds0hiKx8bDl++s=;
        b=KvfFmT5AXA4JnXIJ/MAqr+ilClk1M0CGDzoY1kcK9FEzfvb/sbU+faFpRAe9gBdoz9
         AwqEsu46SG6KLc9c1wv+cqYCDLXpfMkb3odm6/F9VZDWrOAI7gil9ooIgAb2PVD7ea+2
         aNzklu/SY/8MmxjWZ++6FxqA1SuKWCxY9VE0NuA5chSnBpHfgvgDu8Sq/kttP7A0tEv/
         VzXxU1t0sjTDhMyFiqNh4Mkfolf84ARmEYBJ0RLHlj3WixlIFoYenhQaSo3MPO6nrl2K
         VoajJXXJztzYr9xg1xY4BZKLTKTC0Pjv9nnUutximHKc2cQaTM9ZfiTqXiiOu3c49Ppv
         TwAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTMsa0mlID0sguBd6SORYIgrCa5YXAdiH99UfVHOZAHSyBuCfKK+dtegw9yI04FwwwqeNnn6J2yiHhW01lLTfVxFwi1FzhVs++
X-Gm-Message-State: AOJu0Yz1CpibcqXY9iZiDMV2rD8c0mLITM/l1rwzsTUL0C9oNq6m3i8Q
	/H79BSG93R0W87bwlO34qQKjElRJs4TvHyyeWvs09PsBOBz6Mg8+B79rRhCg
X-Google-Smtp-Source: AGHT+IFqBmnPojKGoLSqJ/fbhD9h9vqlD9OR7+D3gArRQ5jLMYdMb3YLCZRkAWmsE4QPVuPM6u7NJg==
X-Received: by 2002:a05:6602:3ce:b0:7fb:790c:a317 with SMTP id ca18e2360f4ac-816c32c9ademr48084039f.6.1721156365415;
        Tue, 16 Jul 2024 11:59:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:25 -0700 (PDT)
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
Subject: [PATCH v9-resend 47/54] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
Date: Tue, 16 Jul 2024 12:57:59 -0600
Message-ID: <20240716185806.1572048-48-jim.cromie@gmail.com>
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


