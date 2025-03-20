Return-Path: <linux-kernel+bounces-570236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC825A6AE07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10901487918
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBC23E34F;
	Thu, 20 Mar 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfiMOt5q"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBB22A4F8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496838; cv=none; b=fb/EknXV+2n3p9CHkpG/tjBmddFh3X3Dl43yRgYgNdXaSTZC/293CFQ+MiLv+fz2mrZI2OHZ440CEsGYlhcvxvUhRXfAgGIgtETC+4swmyDPeyNOut/BOs+0r0amqf4PIiVPBtLNjpNYLERSJhLoIwROSXMw/gPY4G66WXdZV7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496838; c=relaxed/simple;
	bh=rcrUkUCjB1xs0RhGIZDJqSoks92bVgXttXWRlrICL7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4/hMYtFVLP0QeEcf20+jLNk03z/6BH0I6tm2JGvYqrEdCdEuNnYXm0XcNjG7iYZ6h38x6BX9D+/MX5bPacPIiSgZrM1DMKLXmix7AXqkFv+p+am77kFyzjz86gg+UglGlTny+Ciuf7Q3/5VAzL7ZC/MAVtnxSPH02p6nq4ywoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfiMOt5q; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85b5e49615aso98867039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496836; x=1743101636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmnUjD6NKJR963XR8Ej2QuH8oZFh+mV0bkdDgwQtC1c=;
        b=FfiMOt5qZ1kFcTAmLYiWwQMcxQ2FP4d2fXqb2/6WRmcvyr3cBJknUOlSSvBt5Is9VS
         AXDbuX0nK/06puJbxthXOHs35svDjzZuxDSddTGQz1pHMJWh8Ja6uQmyeyEJypa0aXx9
         pDWz1NVRwCnAyNkBZs8VDI4L2fKcpLjDmw6dYSbwL6BaIrSGjKCvDyxSnCzHxD6S4/NH
         dYtS1tZPCHTFnorxDkQENiSLqSIC421ZSiW1Uhb2YHxK/UN3ZEbUuTmH4U2ny9u4P0Fv
         1bmdnllnlJBildRsbWdqWSImtX/AFfzK7fmGvZ2YpbRMP1+5Ra3QOlbD1w+CIEtRAZZA
         zH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496836; x=1743101636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmnUjD6NKJR963XR8Ej2QuH8oZFh+mV0bkdDgwQtC1c=;
        b=oPNbFjSnwXzpYt6Qmn5LAsjsVB/Aysms8ldYFRONcqQLLmwZWQrRnkDul402i8+jSi
         DHjeEG//MLKr4cciXOCuL1SpaNOH1JkatsPJgR2PQWCwrSO92GwW+/PTKuJgyeKYJhtd
         5KD5JwDuQ1yQqBTKuGAjCTYGHLIBuR3R6zQ8cLrfuaST6v62s7U7gelADLlMWylY+lHY
         o13Bc6ALIsAelghx2w7qLzRS13fHblEJWBArxgWohbl/+mujjpWFYI1Jd0juu37efw1s
         IKkPNs3Fs6hwjuWkKagnUm/YLsqGtJEdfxjEQXFDLNoti9+bXqqK3q+Y/Y4PA6peR2PU
         lg4g==
X-Gm-Message-State: AOJu0YzWbC1iEm97TCGaBkuH80HBZ/DasDdWQmA6L+FxO3muY1tLw894
	Hnm/4ZfoHWlEbRtoX119Wx4a61T682rHq0twItqc0KQ0Zl+7yzjXdC9L92Ac
X-Gm-Gg: ASbGncsBDWsrzfAoHaG8EaTLEcJPDxo/IM873BMtll8/Kzw4oLqyehAGSj6fCLtk+MV
	w9fG7CpwZkdexzm3Gp0DP/m+STc4mQQ4FDIZ3vPV08hIbjG8HkcTm7+ZZa0eF5GvDRftefewGll
	F9mGX/KVN+xNniBa7QHhJZS0cxku/jW98tIMKu/Fp5N8iFHzUkkr8CzkDuoc3UP+UGfhMt8LheA
	jZIVNs5GAqQtfFaeVFYP0CFJBLLjc5zE8A4ypgIfvGTUDcvCA4cB0N+9t/JKqMnDXes0V1IAZVb
	9HUzT50qMrwfTWHIYCbzFK3Fge3c1y+s6Fus1jQ0t7/yM9fWYQ7TDoX/Qn3c8iJaAc3Q2qLNHRZ
	mQg==
X-Google-Smtp-Source: AGHT+IEE+IsH7hIG3IwpuXTfje/wS/kbP6qcYYW231aMk+d0pYaAsvECTE7km24gsBf+wVdEupvShw==
X-Received: by 2002:a05:6602:3a01:b0:85b:3d1c:87d7 with SMTP id ca18e2360f4ac-85e2ca36477mr39404939f.3.1742496835558;
        Thu, 20 Mar 2025 11:53:55 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 45/59] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Thu, 20 Mar 2025 12:52:23 -0600
Message-ID: <20250320185238.447458-46-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
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
index 6a67c6297d58..3bc4e6694fc2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -45,6 +45,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.49.0


