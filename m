Return-Path: <linux-kernel+bounces-238474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195B924B36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1B287DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19D1CA2A8;
	Tue,  2 Jul 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwLicMRv"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E31C8132
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957553; cv=none; b=NknRpWj/m7ykndDs7GMRa2CC13ocUMHNEx04bGc8dK/V17wP/59HDnb8QBXIOkO9rbJNIO2Ap/GoAePQH93eyOdZ2cNNV6s06gncB0rLkb3+7FJsOQNI72g03r2EIcJv6D2EdbINVykcSf0o3nWtgFUiQNN9GSPmuVFC6FH2r2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957553; c=relaxed/simple;
	bh=BACRdEKE/EdGzYnQC1ja1K39qZMWUunTQiDC4kIMOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTJUDMBUDii1p0Oi75d8E3z6jJNp8F5Hqy/0f03jbsFdUOvdgwUv8riIMqxLWKJyMVX+hyoe3pKS8TLc6p7SpcYb0O2BKs8he42bXRltylCyO4pFHyzEgc9PaLPnEyJdLo1BT6uok3UXyrIrueidgE5S3aH9tRIBeSwniBkvoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwLicMRv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f3cd802729so172623639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957551; x=1720562351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5Ysg7vbItKfqIGM0QbE+cddDiZC+jdjQozEcgbAHb0=;
        b=TwLicMRvESj6d9255tjFcrJlAZU02rNWR1ELZNWhezYCE8kXSzc9gRiJSDZLZCIgB7
         sEj50/ZX1ZZ8hnE4oTpIjlMIuJTi0xghQ8B2OQb3GFyEk4EzVJR823iWxrRJkR/E54fR
         r4nXIeiWr059mThOoVaTL50sSmL7KRSJZBINyHV3dcOMTIBlj8gJnr1tTT2W17ZkbAvP
         mdf79mZLtNDI38j4PSb4Ww+iS46Msu7P7pnnk7fSvCZBLtbPA/hY14FQuVc2kEVQOPVi
         ezF2M6au1qYg1hAM+4l8jHI0U5aMvKLrsdfAHYNYYsOmANZC3MGri4XWQ/u2HAxaxs7U
         f/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957551; x=1720562351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5Ysg7vbItKfqIGM0QbE+cddDiZC+jdjQozEcgbAHb0=;
        b=AdmB5nvV8DFD5kjjzP+tHAz6YhVcFGGI/Xx18nyYaanz+EuTyoETcFCqUbuCl0dPBE
         9s8QDtvwJEc3+9vRZEkvR/nAMiB2g2FI1c4MdQDbtLaTumMUjZypdeCCiqgrNLtUX9JO
         4k71ArSXDWvVoFzl1XibkoHA/zQorayvGFocrxzPyihN3xHcB5rSPlfGTzBVDtA845oT
         i8b4M1vH1w7EPnNBuYI8bv2YV4t2Qvcml7MdpYU8ofM3YPrATaIieS/zKUdni+B2g/DE
         Ay0QVZeJrjSckcwuJjiMPWbItP75h/O1+IymY6bqLzDCl5/M3t3X425ko3chU/jQQ0Iu
         J/Ow==
X-Gm-Message-State: AOJu0Yz4Gw6ByK2nq+yWTNBCI3ayiiaqJFjX2+qtuFcMhWBS5yTCb/Uu
	uv+DXviQ51fNz0gFId5zdIYDCg0ITONnKDTmqh9uemaBDUoz353b
X-Google-Smtp-Source: AGHT+IHqMpLCRs5CaWnYQ1hnUZnwKhYGHnh3SZ6WBUA2X+aJ/huxMzEjPlMSt2OgDoaqgK5zAZJzPA==
X-Received: by 2002:a5e:c812:0:b0:7f3:d7cb:8464 with SMTP id ca18e2360f4ac-7f62ee559c4mr1048046639f.10.1719957551288;
        Tue, 02 Jul 2024 14:59:11 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:10 -0700 (PDT)
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
Subject: [PATCH v9 40/53] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Tue,  2 Jul 2024 15:57:39 -0600
Message-ID: <20240702215804.2201271-50-jim.cromie@gmail.com>
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

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 9539aa28937f..bb3a3e042264 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -44,6 +44,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.45.2


