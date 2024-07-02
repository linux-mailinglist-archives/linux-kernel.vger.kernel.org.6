Return-Path: <linux-kernel+bounces-238492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7178924B48
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638F2285DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EFB1D6152;
	Tue,  2 Jul 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0QwixSW"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB86C1D5A3D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957574; cv=none; b=img94hbw8tLIOAf3aeiCcqiTsjnWpDtoB2HLn0PsO/n1qbhXZUGnN5+PLcTPXew8KvNpa8rdNFykd9ltXLVP/jTG7UtcTSxC2TUJKpPn6OCLRgRcFwxSOaU94LTCVRjtvN/ssM8wUWvC2gBz7el3XLx8uqAFkTdkm126m4/+No8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957574; c=relaxed/simple;
	bh=VcaoUfrcouQV0gFCR662Kxzm42SL0jyYYKIh4ngnOzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E64upyIlzYAjibQR8y9j97WHCkuGUufZSI+4d4L7tK2/WwxJFrBMKz8L0+s/Yt7sevcqz8mP/fKhm4bJxEgC49OSOsG8bDwD5rQlzISs7rixfvubo/v+MQzE1FDBsESBBMDmAkVtpcJ4m5PNosjXY0+n8inyQYKMy7Y74FnDaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0QwixSW; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f5f7ecacc0so203306439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957572; x=1720562372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdxS3Fv+DdtdyD/OX9RwYgW//DQBvhU2TaujYV4igeo=;
        b=D0QwixSWE6a2+Rqn0EF+aXCC9K78QKN8dngI5IIjVvDn3jDXKokmbTEf2w0jWMDMWR
         P/Hh4yxA+up9Xh2wZ42O2iCuZACuFBQ9ti6UCp6wmMy2KeGhLTMeQ6K7An4iGBC4/ida
         0F39eyj8uh7Taux1n8JohLAYJO0RUldI1GSlrNy760vlz+e+1KaMAa5vCbTVvyMPj8nj
         kCdryI4VCFOfdBasxlCNJsQbGsdHj4KFzfExEwpOCkgRAoDAhO9A2JhWS8mIo6Jifx4i
         CdDJ2MNgUuyINbuRuV8TMkYT590PZZoxtb0lsvXA2hsffrCbXVOoA2RXFejVi3Fnsd4H
         L2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957572; x=1720562372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdxS3Fv+DdtdyD/OX9RwYgW//DQBvhU2TaujYV4igeo=;
        b=T5ACEb5KWxCG7l8jE8jnYkpnEtl2CeP72f5KEfmKMmLsHuyBhwl6EAKW/rhH5g6GFx
         WaAYkfMAAYbq4+VgdR8Eb+39lSgobBX/IpiJpxdKtHSxM3EbSdFq4ePzXT8ckRe/Yn35
         1UrwCi1xSR64V3i6zH3MAEAWIwvCzqxh4t7kWTCSWgT6T6zM5fUcvmSOezBAk9ckyTuw
         4XQZzCrIq+vb2OGNS9kcBiGVMbUqxdPnTeN54MLTteKaOr/r+RQKgK0HUNUlr2gr9W31
         4SRhSBiLmmHENs8fInHR1IbtGpMjyejnFu5VN4j3Uxm48akbEv7oRVy6Aif03VuRcUYs
         +s2A==
X-Gm-Message-State: AOJu0YxO1GCe3vHjVe66OoLUeGYig5YCUGKxPe7E6i8pa49m/s7cz+em
	WV1rHIH1BDZq53Be+NYHj/pUMZmeumAhV6mOM/0KbIIRmCAhZLyF
X-Google-Smtp-Source: AGHT+IG0BidfQmn2qvsEzI4yxcp7Po1yYyxiFL7MCjw8+FHvwJsFiaR7ArnybWXhDCww+r7LW6gVaQ==
X-Received: by 2002:a6b:7411:0:b0:7eb:8ba1:b03 with SMTP id ca18e2360f4ac-7f62ee18032mr1037353639f.1.1719957571867;
        Tue, 02 Jul 2024 14:59:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:31 -0700 (PDT)
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
Subject: [PATCH v9 49/52] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Tue,  2 Jul 2024 15:57:57 -0600
Message-ID: <20240702215804.2201271-68-jim.cromie@gmail.com>
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


