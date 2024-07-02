Return-Path: <linux-kernel+bounces-238467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E4924B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D0284830
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F81C2DCD;
	Tue,  2 Jul 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuQr2WDO"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2701B6A73
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957547; cv=none; b=TmWwtMfDEeEjVOlrYAO2d1ATsEFUiVMQMiu3+iFqW72aaYyhMgJ311dAuSKFXmf/1JhyanJGwoPGXBIGYbPUJZyXbdhZl11weviZW3bZybTRhBid4XtHfC6rUpB4jDOFrtRSVqsuY7UU7thbrC7ddtnvxuLtaHPTjpOjERGCQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957547; c=relaxed/simple;
	bh=O9PUNSxHH2hOtI+j2/xlVettstmLCDGZaJ8HHPON96o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEIrS/G2inWN1C9uO94X8cUxDnYnVby/Id1u/OsqcNQklLS5eEq95BnDnwhAFoco/D4m1+2hA6MvhJ1Q4G9CyRXcYiVNmPOM8CorkFvx+vRksVwBb+08p/1npqgI6xDIoNId5eCHSFLk4/vuRhBVBQU5ln+znJ6utMx7ODrS4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuQr2WDO; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f624e70870so253611539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957545; x=1720562345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GNz3zEEsQ52HQj9oGak+wZ8oAPfmA3LCU3EZ10XWgs=;
        b=DuQr2WDOzqoh6jjtqdI3ek97VdZOrNvgoIiKFVH+rbZcEbpBcbMfkqKrNtC8GbEQAF
         ndOxt0ZjE62oVwYk0E6djF5Gsas1SNKkJjNRKRy417X+HPGIOFe7OB5wshXGMsoeg7DW
         jvM7YiYtKu98kZYtjLilulXFIoJL/I7lhktgqClk8+3jpKL1voDmVhlqI/3uR1Iky3HE
         jCSfLI4Ek3aMwFBiaOAGqoM5s1nvqXQ9Fj4FKmkFoUBhLtMNOszTdGPfvB9wNY/HuyaG
         HpEH/dRweg3pv7A6siPp0wFAnATBU0Im837TfXnpM7n9tcqsis5pIauvmrzl7gDBWoaj
         Y9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957545; x=1720562345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GNz3zEEsQ52HQj9oGak+wZ8oAPfmA3LCU3EZ10XWgs=;
        b=KCSjEnfw9SPZYuSHziJ3hQ5QJAu8q2EqS1I99w8gjXpP8ThCO6nugL4bk7DGY8DJ12
         eSUr2Ql7r5fsUhaKnYiSbwNYI8LBgR/C/ah8YyJO8oDNwvO0neWAifp32HOgtQ6HtHiO
         ZQ65UFS3igEX+LMavjJCVDgUlwedXundCusEOlZdsvy3J8KzHElrd6/yUPuhrxlxZ39I
         BV8yS8M5NHyipHTAH5ml5RcIhZIAsdLXqVWqNc/uYEDaJlWpHWnv0dxoPHexvCgab0x0
         7Gk2OO5U2UxtQT3P6o8mwQ4x/2oMVKOmsWszYSIcT8+LCEnMewY1oWtay+jWGc5p/wOV
         /ouA==
X-Gm-Message-State: AOJu0Yxu4zucUFBroWwK0JlTleGf0yu769jwqEbm7KWtW1NLY8dP9pxz
	vtAB1WjVz0YLgTTO16kF+Q9Kma6KE5+pJlTOVVTdMA6GCPPrARiP
X-Google-Smtp-Source: AGHT+IEpSIuUlWiXo7AlLLZ9H4oUpyxuj1IwsW6JEpLdySuCQ2Dy4tOK0pH6QgalXu1yNAVKG98Eig==
X-Received: by 2002:a5e:cb42:0:b0:7f6:1f5d:3e02 with SMTP id ca18e2360f4ac-7f62ee18215mr1105126939f.2.1719957544885;
        Tue, 02 Jul 2024 14:59:04 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:04 -0700 (PDT)
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
Subject: [PATCH v9 37/52] drm-print: workaround unused variable compiler meh
Date: Tue,  2 Jul 2024 15:57:33 -0600
Message-ID: <20240702215804.2201271-44-jim.cromie@gmail.com>
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

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, I'm getting an unused variable
warning/error on 'category', though the usage follows immediately, in
drm_debug_enabled().

This drops the local var and refs the field directly in the
macro-call, which avoids the warning.  For static-key optimized
dyndbg, the macro doesn't actually check the category, since the
static-key patches in the proper state.  This is also likely why the
auto var appears to be unused by the compiler.

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
2.45.2


