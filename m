Return-Path: <linux-kernel+bounces-238475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72C924B37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834AA2880F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679131CA2CB;
	Tue,  2 Jul 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlUkpZLf"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C81C8158
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957554; cv=none; b=RwhssFuzq95ri0k7emOmQbiY3azNV9rF/XlYX8uUPiyiue3+k0QOF0yUSqJMTEu/vC27knQEVFZejtekWATWZXyhNRK4bTNY36XczOdssTZLVqAZ3WWldHQMyFCSsLvZToPfMuD2pkgIke0qgxkS9EnIbFnPufRclrkH/0I0CFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957554; c=relaxed/simple;
	bh=tCPOUZzz1n3M3/Vbz4zH5Gffd4O1Gv0jydxTr8IfQGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB05msC+SsFpsDvYUP2hJlWYQ/4jvwxU0vb8cL0Enw3iTyHYOKML0s7AwU+ZRQKYvk6J14zAid5vrMlRzhGuUAfkdAk14ORMstkdcbqiD0dnMoWL425Qm2M85E3fbEbpz1qTcphb0lMj54jOBH42MDfX81XOvGO1+/epHCst0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlUkpZLf; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f649f7868dso113938939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957552; x=1720562352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVVliFbCcRiwMu0SQpi190huBei8IpcPa+B6oudggrw=;
        b=JlUkpZLfVwEUayeQaV7eJqbWP+Krk/w7F9Ff7ZGq6mCVFkipzAjAvbrxgejY5Ia1lr
         nQs9QitQpXy+BvwlbLnTp/GWBCKwfX3d9pp1R0wR8Palf4Eqy+UCBg9uUZJ2dwbwHNc9
         8cX13T9UnCrs7X1AP8+mzldwNoPklVFm3Qvronh+5d4ApXFrn1thdaEkqTM8UReAqYxu
         u++EjWMf1RoakRV1Pd9NbOkU4P+4mta34BBskFMv1jcixgm1HYtEya8lCIBhHi1eacgw
         z2iicItHwnbB/s0Z/rrfN8Ac2MGv/Zoh0bFxB9A7eT17g5xLXeWsuYxfmfV+Z2ojpZmq
         dFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957552; x=1720562352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVVliFbCcRiwMu0SQpi190huBei8IpcPa+B6oudggrw=;
        b=HFfYZ1wh/fug1yKlcZUaYejuhgUnmtKi1YpbuflTeac9zrl7aoj2dmdiy7Tz8izX54
         yWU9HUTOJUw0/ye2l+eu0eaf+oBDp0iw9lowjMaH3NMPoMOqeF2Ir/Ee3eGI3O9YJ0Wz
         zs/XDWIqFnZ/o4fxlaiP+f79FzG6rkTp3spvuNAfKWd2ZWtNB3KcbGz80792KQoyW7DO
         9MQYJtomneAeO7M0/u7KuPU6+qdqKjaxZ4R6tLj65Wt8ZBV0DTOWeKc5x+r7pQov9sC/
         2YSC44QjXty7/lT3Bjn7dumjf/NceqCKe7U3vS/p8jddg/h5BuySryOUVEgo65SOM1Gu
         UOww==
X-Gm-Message-State: AOJu0YxBXtC4oQQlnMtdkWTraDJBrjKlubxSR5vr+MKEcZMzBvYiKDkJ
	xDdsbOz4gBl07KNXk9B0WJHLP8Ov9uQV3gnLJjvC6rooU2FokUmg
X-Google-Smtp-Source: AGHT+IGEAKvO56UJsUl2ag28O4BHU8pNps2SJqU5SLk78nG5JzHSvTWkp76KWdlSdUH9XcNNV90+ZQ==
X-Received: by 2002:a05:6602:718:b0:7f6:1cd3:9660 with SMTP id ca18e2360f4ac-7f62ee647f7mr978614539f.13.1719957552546;
        Tue, 02 Jul 2024 14:59:12 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:11 -0700 (PDT)
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
Subject: [PATCH v9 41/52] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Tue,  2 Jul 2024 15:57:40 -0600
Message-ID: <20240702215804.2201271-51-jim.cromie@gmail.com>
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

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index c23c9f0cf49c..ee98fab5597e 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -54,6 +54,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.45.2


