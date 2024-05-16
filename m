Return-Path: <linux-kernel+bounces-181414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACEF8C7B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D371F22DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8461F15DBB2;
	Thu, 16 May 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUX0mTup"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A915D5A3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881518; cv=none; b=HUIjEDXtsREgEIhwn6FYfTC5FZDHn6vCqZxKlfL4sk+ln98auPdlXbUyrN7fonSKeW+ljdipng8lWdGJW3dx7oV9QouRh+A8hUgMZ/ibIFP7XJYyY1H+a1UrFjlpa1KgmElCSqRgq5zGmOSwr5Co5ATASDA2zXrZ/lb7i6Dwveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881518; c=relaxed/simple;
	bh=qzdZmDPP6M1aO8K9TyO1qKHrRlVGT2yqxw1T+9OS14c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7va37zBJdJXtfVQRqCcqEvbCbBhgVEhLt1GjhMklz0E/U+YVKOFiiVMhpBMB10hW1y4Kt6L9ECRmZMZdLgQAVQbTIFtiLDf5DYHlvt7eG4Htngcp9l1v0wI1LGx7GiKgJ52f6L5rtjiyHKqccjPgkmCZHfr7Oan7Sqkvs8X9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUX0mTup; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e1fcd2662cso65731939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881517; x=1716486317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umW2ohU1UkA0RFXV0PRie5tCM7KJ6Ljf1jyfGlyoHPI=;
        b=kUX0mTupvf33c5dTRduwRNxGcD1irPC/odVAgOZ0osBT9nAAgwl1idg3wx5rXT31EY
         +fNeVjo3peDbpMHHTHSpv0YUHlGsp/fy/p0CFqmPJq6XV5PcvHrNtp/MTRQzfgLfzIBL
         n9U0k+xqUcWB+l8ULcY12SHlgeDA0CkSF0FOTOvQp47ThpNqWh74kYE4p60GBjnVPLcE
         nqgjv5qfcueyUoBDSE4n/yOihnVHufc8vqreVZt0WlwL9aygaWOUSQcPEga2qY05ekH+
         feytPWk/RCeaWl2EO4H4u1x7D/o+reyEYmCe93KF64TbCpuAUK+L8fUK/SI4EmkGovnr
         /mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881517; x=1716486317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umW2ohU1UkA0RFXV0PRie5tCM7KJ6Ljf1jyfGlyoHPI=;
        b=pOgKIzqepzn9cN3+MJkPvRcyfU1whQFEJG3R/Qr3mS688bfvJsPsywEg+/26GzpoQ4
         50ZJ+KRQBzOP9eex3vJeLgrOVQrSbf/5hqxN2yk+eDf7ULvxRV4sCFmOzVCjo94ttO7h
         9yfTFypw4ToLURUwvFZgj3SEAJa8amGrAzO4io5KRu/o3Pg2RTF0pAVe/byoTstVYYTx
         XKoGqZ9JbPY+0dJMpBvz3SED+kQgfdcZM11LYuWzAQ7GYC+Gf0R/47h/ICcUUPZjhyKo
         WqqT5Y1fIFS/jk83/a0zdEO/+ZHO25lJU2SQBQmT12IOE3bMT95z/swAKqWW3wmy8ILj
         Tckw==
X-Forwarded-Encrypted: i=1; AJvYcCXNX7+pEWgHEAO3YuFrWK4NzIy3imtKBSiLWAKL4onRKlWyL4zjQM2rkBWmSVb0GniHwVSUqUng+/rRoPPJT1Op9BD/7eSGg3+TqLlU
X-Gm-Message-State: AOJu0YwdHVGDBc/XnR2gkt5+beibAI94hIDWwaM4+dbim+8Ri/BXV9px
	5YVQxEiCPc8CLH8kjUl1KHHGKYOdTPftjGZbkkzFd+YjccvQfW4y
X-Google-Smtp-Source: AGHT+IGI0+lqQOeQnQX/2hVkZUduClO6F81d4lh4jwHt3miuorVA7EdliDmmlizmSbrVis0FmBe97g==
X-Received: by 2002:a05:6e02:1988:b0:36c:4348:35d7 with SMTP id e9e14a558f8ab-36cc1473f49mr218076905ab.9.1715881516680;
        Thu, 16 May 2024 10:45:16 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 32/33] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date: Thu, 16 May 2024 11:43:56 -0600
Message-ID: <20240516174357.26755-33-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Time for some quality CI

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5a0c476361c3..b2ea73ae48f0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -54,8 +54,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.45.0


