Return-Path: <linux-kernel+bounces-238470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB3924B32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0031F24E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C6B1C5A1A;
	Tue,  2 Jul 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M23gvchS"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2E1C2DCB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957549; cv=none; b=lTeAYBxoQzmKtxzzgFm73hCVzMrh/TSj04+UfBWKTpoCXhRFt2jz82f228tKqtTRuP5KpZ/OI1st6fuwrLI1pxcB7pGw2Ci2fJAfnhnl5CfNb7m79ab3HlaIVKwSu921UZNJTmhkjmcqQXc0N6Bpy4fzYrsCjZJJAUew1x4vsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957549; c=relaxed/simple;
	bh=O9PUNSxHH2hOtI+j2/xlVettstmLCDGZaJ8HHPON96o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaAyPvFItKIU6evg343yfkQevIh8/poUdRJSydx8Xa4OFzC7kGxXdQr2xp/oZ0fTudkuaq0h9Oh6Iwsp4jeZRYCeYrNDcdKkN9LoObrsSUJkZwHx+0cbSbxdNu/jnSkQfze+aFi9p/9u1R0t6pdiaE9Xm3CaZdWksoA3Di6xFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M23gvchS; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f5f7ecacc0so203291139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957547; x=1720562347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GNz3zEEsQ52HQj9oGak+wZ8oAPfmA3LCU3EZ10XWgs=;
        b=M23gvchSNYLvS+GAS1zfU8t/ch1NOkKh/l7tS3PYnEGIRG3uUTbEElufEID5heKWZx
         xomqCjxOGxJB0csFManbI/ObGWBkRhuAPk6sIhAFvv86GVs95VGhZRwJ6n414kGJ46+Y
         zTBze4Q9iYPxmsyRPwcDmeQcgBLR5j6sDTYryR87zk9gblEYHWRV5bAmS0XgMtVTjTjF
         85Xlgxo4e18dWmKN/6wYP4V8Sn9fWs21wIDz2aMI93rvFgMDtHH2TP6kGPZl8WqmrQj5
         oVxraPfNS7mcVG1qzZt/Vn5mT6BTeybUQWAE1We03ALOPe8hepFQyT6/0MhB51oBgPNI
         xD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957547; x=1720562347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GNz3zEEsQ52HQj9oGak+wZ8oAPfmA3LCU3EZ10XWgs=;
        b=ZDmyZVXHgGSVidfToQR0/xv8odQpCXNRdePfXPhjFfZ4eaK3WJJ/y8c53Dmve51R8A
         puStcuuFp1knPXmTNwIEmDHP1gEkAiM2/k7ZyUNl/YZWlUg1ozwhEiDVvPt4lJOoGQ6r
         TKTIY4T9Ua8U/CL95YVi7O4ZqjYhlAuwUkuew8YmuqHVTOEuzgE23Z2G125ugQtK7Cu9
         awZFyZ23J+AxEAs4kJKqp5/iLomRoxiD3ZkKYbq8gN2lektoUlOqaJLwnCK7BWFmTDre
         /WgHOFk5TXuPANp3tXjRfrtf/qycbV3jVHH3CmnJOB8TUq0ab3zfhxSjnWxZULZSFWFU
         Q2NQ==
X-Gm-Message-State: AOJu0YzZ8mow+c463ezbyb6laQGnGXd0xyWAtXOfzgSiPpSxudXrmXUl
	4BBHqNAUd5xtnaeWDQa4r2j4LPAneam37BMmP98BBJiV0cqQMSDb
X-Google-Smtp-Source: AGHT+IGqAAyTYDzyBFrvtILHBMnk+bUW4/hZCTzpIaKmJrgPR4f3UslJ2gwGQZPDM8okTSwxG1QIrQ==
X-Received: by 2002:a6b:7214:0:b0:7f3:d8ac:d15b with SMTP id ca18e2360f4ac-7f62ee54681mr1081093439f.11.1719957547290;
        Tue, 02 Jul 2024 14:59:07 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:06 -0700 (PDT)
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
Subject: [PATCH v9 38/53] drm-print: workaround unused variable compiler meh
Date: Tue,  2 Jul 2024 15:57:35 -0600
Message-ID: <20240702215804.2201271-46-jim.cromie@gmail.com>
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


