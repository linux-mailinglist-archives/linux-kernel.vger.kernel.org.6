Return-Path: <linux-kernel+bounces-254293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE3933183
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5AD281814
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50E1ABCA6;
	Tue, 16 Jul 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4/ncys3"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CC1AAE23;
	Tue, 16 Jul 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156357; cv=none; b=SogyTbu/CbBcv7WjPLebI7q+Xlty5TpzirNil3w3W+0wYIJAQw1NDgOc4GlU2UiDQPb2SCZJaxgmzZxvDwpBpyYwjjNdFG/hxESnN9W7zqbg3nD41P+MzUk+y2tr1qKT9AlITAWf/onz9XN6IRLfELUZQtLdAcpZkNqzCc35IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156357; c=relaxed/simple;
	bh=YU2UQyfbg5EPJu/ixpXIX6osoJjWV5HNauPmSud0G/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOnAdpGZaaTCMugSQr7FQkRsmul1y/PpDd/l18gymQKvmtQwkPBTKAyVLtN5Urcj4qSgacjC/LgrSv3RhBHO3lCdXA7aoXys6HA6KigdKw8aMkFjXP2jXMHlv0r4HmX7ODeu9ek0vh537F7X3OHUBv/Q1vwrJDo3Zg3/QxHw29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4/ncys3; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f684710ff5so2537939f.1;
        Tue, 16 Jul 2024 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156355; x=1721761155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0SsnMAz6GH/rDMkbSAQVrT9nuU+frPtroMw7DfrzhM=;
        b=O4/ncys3HNuIsDlJ3XFHFZhBViXrZFn9Sr+eWY2x1S+NXqnpKV7MSgpgrL3NiX3pvl
         eS21/jK2Q7dLrAm9SJnkGwEmppNH5Z9PttRZitTEK6JvCrsVHecjq5oyDoKjA8K43M7o
         aE/cTFNHQ7eqSVe+c65EP7CDXZYNaf79/lCHd/03tAHOd/yypDo6LM7ZBX1EEzdyGnq8
         uA6jZx/hbpaEuG7Ff/gMHW9CFaIpTATJ80D8g/dhkgUjqml8BRK2u/mglf+3g56k6hSL
         dhDZrLYD5F2evjFYBgVNaeSH8G9x39fdQpAgPVwCcHMN8Kkbmfwj6S9TInGzMQ3O/WXr
         8VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156355; x=1721761155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0SsnMAz6GH/rDMkbSAQVrT9nuU+frPtroMw7DfrzhM=;
        b=IXWKUgB1ku+ZxfhejGppkuNJ1KLnT3se/0NsbKfkr+9szZANfZpyQAo+wkiggWLjdP
         yX+iFRbvGRLo2iiAt9k/mYpq91i6+9gEQ6pyIA4k2Jl0fuEzTvn1oxrDwnmO4WxALvSE
         fTYZPqQ+bJMHAur0jV/GKX8UscAON3z+puWHdOyTaOEG/8ebKX9e8mUzOhUiQZQnqoV7
         vgAD6jrZxksjbGfoJH/MEFtX2YzXKKtnEj+4K+fJHoAac+j5OT3lDZY9qtaaHHQdvTn3
         ovoyXehp9A2BONWjLioN8qXwoZ1HnL9Qwm/ivOpwxY/4TIRcCtfR83Q9CDu4E1jf0z9M
         q68Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMhgZ1WHTjncvqiviUEj9vkIeq4brqJUcLuIZdhI9YNUumMeX9NirrBz4vJAQPG2KFmZs+Ly5P/eujVx0wlpG4joD55TBGWbf+
X-Gm-Message-State: AOJu0Yx4xMn9fUEBfofXoZXejQV8cDveo9M5CDerwZDpcwTuxedyZFvW
	uW7Vmfl6K8iqTOrzyRJbOeS1ouutYgxQ5gAQr/lpCu3JlqOlTI5WsHAV7xjx
X-Google-Smtp-Source: AGHT+IG4PMiQc6lo3f14z8Q6mtR1iYHrjoCgqtBhH8cIy0Dzz/zfd1kFjfu0oHviBWuod8DuEZ49Gw==
X-Received: by 2002:a5e:8b4d:0:b0:805:2048:a492 with SMTP id ca18e2360f4ac-816c4ee6d5amr23979539f.6.1721156355006;
        Tue, 16 Jul 2024 11:59:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:14 -0700 (PDT)
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
Subject: [PATCH v9-resend 39/54] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Tue, 16 Jul 2024 12:57:51 -0600
Message-ID: <20240716185806.1572048-40-jim.cromie@gmail.com>
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

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 188e126383c2..d69d517de2a3 100644
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


