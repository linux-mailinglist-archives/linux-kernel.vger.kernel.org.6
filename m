Return-Path: <linux-kernel+bounces-181415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074868C7BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A273B22161
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFA15CD56;
	Thu, 16 May 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSTI7V4D"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6415D5C3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881519; cv=none; b=Y77/TJLi2+FONQGZVmCShd0Yfv3PJr0W6By1bbZzjfwJRtdouMQyLU7bTKESke4VNiRlFJnj5ixOZXQETNTIguOcbsVBi3pIrK2aE6QRNJfGpfCfnID7wdPtI6ViSwzn4xHpeOzr+LY4NlRdK0k+aOn6qAgv7+/sFofo0zriQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881519; c=relaxed/simple;
	bh=hGQelBUkaq/JZLSbxTsxKeLUlq22tohYzqKCLBLJTiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvT3mgftc57JQP0fQk2k3yBTcQVGIDmTUviUNn4yNZUcz/BPgMOm6/vfXycikY95F6b05aTwIpNJiird2CV0FbAg3uSgxK1DkdJSF9qj6s+glD54MXXTHl2GeZ7pPXROfFhU01U5jiq5T/Xc2sYdvlTMqBCwgzI0zUgMqYqhX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSTI7V4D; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e1b4f96994so67090839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881517; x=1716486317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukR4HOtDmG+aiLIkXxjNBu5JDcDw31zQRKh9uhizZeM=;
        b=kSTI7V4DRLIQmmsPw/LcgWQ47FyLVY+4h07wKV6oSS5LEH+TV2jQxk47sgwm7eNOEC
         JVbTlNT0jyXxXLI519Mg6E6TS1qSfmabmUsVEZHVpkxqxRI+MsDWWDjVbuEQFmRQuvcQ
         fF6IUVdhwCd+Wdt08cc52Zu883kiQ8YeQyEqO2fBONJBJFI7VqqyGMapWhMU0CX6MR3B
         tyaeZn6a6s9V4OWLfJ0T6pKuD1B21b3g6R/+Sy7qWfYrtADDOo3J2hmdjFsRFRroe5rE
         VJpbzEvBUx5HIvNdwlSwYdJWKXpbRR536rKXVu3YFUmGD9jwj75nyGySY5piuCfRCsH2
         8MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881517; x=1716486317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukR4HOtDmG+aiLIkXxjNBu5JDcDw31zQRKh9uhizZeM=;
        b=oTexwPdo1PVUT9ajhuXvjnOZCCgUvfRqe/woNEMV6KT5ooo3iheGAds0enEs4HOTJ9
         ECFZ4Ufzcg+kqv3RJLyKRK2s01bW9/hWZuVXCR2IuGjMVzjpVpf34cz82iQuJRo29nzt
         +hu44fE/+v9n6lRHk40PrXZoc9bJZGljsCKRgvZTK8+8EKILCyYtOE0vwo7g+HCLzP0j
         XiRl6t34jhtKEsuSr3mlXZ+O3uvH4Ob3maN4amb+dvDk9ika7433wwODLezl2iw1Xxxu
         DYOk2KwoI+4e8E4uhdVcrWIE02jbRcaMJj3HbcaXmydOmM5/8RqNQYPEa9hfyO51zyHW
         palA==
X-Forwarded-Encrypted: i=1; AJvYcCX9PiuKsHI00L2nO2m9d0yyuCyPWUNPsildwOtGW5qs0jhbYjMEk2YktlZ93XZhCzoLzzNS0wCc4VSZqOIP5dJ7RO4YVK0jpRwBI7rF
X-Gm-Message-State: AOJu0YycCtuOxbG7jhY8GuQUvRoijpYq20khTUpCPXfUWTe273vdbItO
	RRydfNqZ3XUql6RCHPEdyDsvVBSx8KZ7s+6sHV9XZYs/YLusTt9P
X-Google-Smtp-Source: AGHT+IF+loahpwgX1qQzZzX7o852RXgHf2TH/P0vy4pdFWNAsBt/Ni5cQCu5Kzr6tBou3N9C6Q+Msw==
X-Received: by 2002:a05:6602:1311:b0:7e1:896e:5065 with SMTP id ca18e2360f4ac-7e1b520203amr2097824439f.14.1715881517661;
        Thu, 16 May 2024 10:45:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:17 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 33/33] drm-print: workaround compiler meh
Date: Thu, 16 May 2024 11:43:57 -0600
Message-ID: <20240516174357.26755-34-jim.cromie@gmail.com>
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

For some reason I cannot grok, I get an unused variable 'category'
warning/error, though the usage follows immediately.  This drops the
local var and directly derefs in the macro-call, which somehow avoids
the warning.

commit 9fd6f61a297e ("drm/print: add drm_dbg_printer() for drm device specific printer")
CC: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index efdf82f8cbbb..c400441cd77e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -183,11 +183,10 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 	const char *prefix = p->prefix ?: "";
 	const char *prefix_pad = p->prefix ? " " : "";
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	/* Note: __builtin_return_address(0) is useless here. */
-- 
2.45.0


