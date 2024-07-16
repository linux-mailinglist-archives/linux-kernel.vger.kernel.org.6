Return-Path: <linux-kernel+bounces-254291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5693317F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB401F24860
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC21A0AEF;
	Tue, 16 Jul 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHbbCdaF"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20061AB514;
	Tue, 16 Jul 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156355; cv=none; b=KCghWdHabBVZ5G1krUbeK5U/ybzhXNP1OcYa+1EM+R7+KNipjN9HW5PadRPVPemPBGo+F64uhsdvqek/AFmEAKaDMphlKOpN6pmyo/6DOPoy2fhd0yILSQe3kL2MjujMcjbnFELGLEG5CsZVNI4Xub5taUMGCb4MR8UhMgAXSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156355; c=relaxed/simple;
	bh=xfPWPjds0sJ2AfvIzcf5l+NieqwtWcwFGJNxWcu7kOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ5Vdv+MVqmnT+TbrY05J6QmApCuMSgpoPy83/bgzk+pqp6I9TG/HdIC3MXcXn4GcdVROFb0zIOp6xV82G1Arm/hPCdZzJvSGFC8gG1gAILq/ceKmfMEgwmlRHWfTJ3anyJcRVJ8RHoF/hJmUWtULgXBfP7UvJxw9rrsnuWWw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHbbCdaF; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8076708e8ffso5040439f.0;
        Tue, 16 Jul 2024 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156352; x=1721761152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4FIF/HbRAgi1F45UWnC13uNax9+Z9AZXMw7KimFe8Y=;
        b=aHbbCdaFlaJsamoCYgL1hJM2dt1L+ESWs2/y5r4YIrR1AcDbgfW+8go1uDDyRihjte
         2lJKSn5uCSoWlb3IyoRQ6roCPBG8peQBtiu3k5AxTbL5DOz8QKn630FHnU6TXWs3SCRJ
         g3g0wbv7z1mk7wbeoD0gQ3Ew6iRkUeflVFIjqVtb8YDgL2TRExaQsomcOPKj/OJHzNtO
         Ss6mY2lnccMH/moduRor9EqTcgxQftqMuHpTcIULQH29XWAVEyW/EftsyZIlI+R4xy5q
         tVX0VVMZmo3keN6NGhL78at9ORFfilicE/lrZIPfMSjL7L9+5JTxMFpfhwuXSzHZwBoM
         OnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156352; x=1721761152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4FIF/HbRAgi1F45UWnC13uNax9+Z9AZXMw7KimFe8Y=;
        b=FbZe241OHv4KzyauuiKf5JbrZDmfWTCGPn8RxSVPVFpez3A9R4rhNMQ+cipm1l+3Uo
         S+XdAH+17kXUKDx+BSmgII4CqVB/QxvDNXb2QaJsTesSRSBah16v+f0CRV7mfbMPoe9R
         I0sVtcEnZpbtZNodQPOBEXS95iQiK2osVjtHyAbP7tTO9ep7U9LBiBui0ZETdtxyMKEP
         GPwdMyJKnDBkcVB9VipiFJeIacFHyfme/WLU7JqVfQ6L68/XCtTL3cTQZMSBma+0fZ0e
         UUt6MHUQKK0aTw7SsP7gH6NCdMbPbp4ND0iz/BE2Bkt328oIg6o0voJroAytsLPQxFYc
         3M0g==
X-Forwarded-Encrypted: i=1; AJvYcCX3gSoraQXhKtscqoifovkSIPQbCVax0augRp8mPdfHNdnrU8LeC/oyYJkSFBOtAwVO2STCvCe2pcIJIxWWKLWYa+OrF4N6vRgu
X-Gm-Message-State: AOJu0YxwGTVdW6HzHpVhqptS+ocsmbiLEfi5YFjYZkdbHvL7DHRu2MnU
	IECXF8XHqJg4vuiGMfiKaXZCIy/1waE3R+1Re8C3rRQyGpwVqWentk0TTALi
X-Google-Smtp-Source: AGHT+IGZMA5Wv6HVLe5IZ1iRd2dcUnxU5c1yurtEkdS2lNPSvZcznoMoprI5GhjJCIIceYNE78q/rQ==
X-Received: by 2002:a05:6602:3ce:b0:7fb:790c:a317 with SMTP id ca18e2360f4ac-816c32c9ademr48017039f.6.1721156352545;
        Tue, 16 Jul 2024 11:59:12 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:12 -0700 (PDT)
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
Subject: [PATCH v9-resend 37/54] drm-print: workaround unused variable compiler meh
Date: Tue, 16 Jul 2024 12:57:49 -0600
Message-ID: <20240716185806.1572048-38-jim.cromie@gmail.com>
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
index c7455f2076b4..0980210a5146 100644
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


