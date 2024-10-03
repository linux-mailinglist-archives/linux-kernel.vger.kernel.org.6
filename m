Return-Path: <linux-kernel+bounces-348784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDAE98EBD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6A6286500
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E413D509;
	Thu,  3 Oct 2024 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEXR6CVX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F58F40
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945153; cv=none; b=cnOdzDIYCDIrPacih0GQlrpL/4lSnwXEBWS5V1qTHCvVvtNryRI8r74vOoXa5JY+9eda5fXspunBSRr4ZVkzTcalK+yWgOEHaFxI4+Nvahp6GnyqH/j8+EcFR5VR23qwCFvJotYDtx4xqWswrjE3o5MolTUve1sb+R9NGlE4p3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945153; c=relaxed/simple;
	bh=H+FAi9wRtocPJs1sPWTIJzwG0DiWNnIpN2eFeYtKxA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwletKxyf9n3hg8IhOAmqkBACR+KeKdGfIsEmmwSS9nhuSD3vtlSA/tMJS+mPnp8MtreJj9q6t/mLCPqFwejGVsI69JxjGIJl4FRqioVC37a6v8UiFX6mISK8q7GJKUHws+A7TN2sJr7lBgbI5p8S5kjAbY5bWTuuiawZXI00Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEXR6CVX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso500612f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727945150; x=1728549950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKrTJrxaC66IYpmC0zcPIsToT+rr6ixnJrZ/0hCTJes=;
        b=kEXR6CVXZARl9ENfAaP2W8IJuel6urnmzfBWPcbAgJGgFYsBolf9yrirY2ouz7ov0h
         r9eE+aezyITznpwBIdFn5SSXWIkua9TU/Uk5HZISGyI/ZA4TKBSnC9llb8jEFnaZqd8R
         mYunfvdfoI8pOvpj5BqPaefUKxlnFD0LPm/eqCjBkVpjnJW1alivBoCn9EpBZmIywQO4
         D0s2LEmGt+05QLwtbYlwUZhwSJF0L76nQNGOryX3MgP4VnpkZjSg+pCQQWPw+K4E3Ffp
         3Ve1LUTW30umXjRh975o6aOYuvhsesTxBLRnZUMJlMH0wnPnNEi0cd8M4KAJyERKQU4o
         mM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945150; x=1728549950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKrTJrxaC66IYpmC0zcPIsToT+rr6ixnJrZ/0hCTJes=;
        b=SUMLJ+lZvFybZ8nu6lgOvMQZmUj5KT1f5FAgTNc9x6yEaXNlntVM0Nkq/Uy5iB9FgK
         QhBRjbTG+0tIZA2F3zgb+UHUmpGhw+q/Uk8jnmjyN8awieb4bOcYz3BVhow6ayMBD5us
         d1Ps2XiQKQ48VN8RtDymEoVkbA+8xzUvXnN5CyNIHfHTVEjDZSKKfYB2BkJj+mIIX418
         IfblDcKk2XUUfxzzsxDRPHdqslaJgkBKyZyS8tzab5aNoE5Hp53Yaz7xu/Lbee2W3i9z
         SzDvGxyDIIS+vPoT8fM1pXzXj+5Hm7ftsz9eg0ymWecf4E/7k3ZJjIUmaxtPmHKHUe1T
         W8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxaWl6cgKdgo5eIACrxqPXT84spQ3zRWmohTuB0yT67MkY9LZdk1pj1TJm8FofEh4CQKyiD1D9U0ErxSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhy22ct4NlqY0uGIkamDFD19j39RNK8Vafciihg+ZY6SN4ACrE
	xLgqDwUGegQSYaRXFdpHTph5PMs/iPrKrdglQwvXLm6J/IrNgH70
X-Google-Smtp-Source: AGHT+IHYcJ+v3BvMh9LmMa+x7Pipzt189nt8Wq5bzwu6NOma37eD1ygcwKs6Tjm30wExRNhkHBbT7A==
X-Received: by 2002:adf:f3c9:0:b0:371:79f2:3d5c with SMTP id ffacd0b85a97d-37cfb8c84e9mr3308661f8f.31.1727945149887;
        Thu, 03 Oct 2024 01:45:49 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f771c1401sm27262635e9.0.2024.10.03.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:45:49 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/i915/active: Use try_cmpxchg() in active_fence_cb()
Date: Thu,  3 Oct 2024 10:44:31 +0200
Message-ID: <20241003084533.871524-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in active_fence_cb():

    cmpxchg(*ptr, old, new) == old

... with the simpler and faster:

    try_cmpxchg(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after the CMPXCHG.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/i915/i915_active.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 5ec293011d99..35319228bc51 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -212,7 +212,7 @@ active_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
 	struct i915_active_fence *active =
 		container_of(cb, typeof(*active), cb);
 
-	return cmpxchg(__active_fence_slot(active), fence, NULL) == fence;
+	return try_cmpxchg(__active_fence_slot(active), &fence, NULL);
 }
 
 static void
-- 
2.46.2


