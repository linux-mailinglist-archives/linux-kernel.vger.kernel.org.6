Return-Path: <linux-kernel+bounces-238447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C0924B13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B042879C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB220FA91;
	Tue,  2 Jul 2024 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2bPSByt"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FA18DB0E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957528; cv=none; b=eoldUIS48hQuyVrThgSl6xg2IK1TMybW7sUDHN+W+nsOVqn5PpheyknAIsJIF1iiRlEdCqgBivABBiA563J7aAP28TRtmSzIz/2A0FvUcofNpOu0OJJhv4Lw8rfAbHrOS/v0RCzVodiGeucHGNB9noQ887GBYmQXS+Nq28VIAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957528; c=relaxed/simple;
	bh=qGonLoeAF1nKI66oYiyq/9w8tauQ74p3yAoY7oXxkr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO+pm0fyV3O8/ByfaIBbLXqQWtanO1t4YEXPA0uZKm29ZRgd4KEGYvFsgOM8Ae8oqU3kf5H7ijw06NzaE2Gp9uVsfYKEn54Ha2Sr5K8bk4rXUbi9XIIPa4v/LL3sTAX5XsYDxVSM3nEsY72M/SeFvoN6t0+d/3xPJn9mJwjiFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2bPSByt; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f3d3919a4aso177937839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957526; x=1720562326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlDKvAdBKoPRv/bIs38+uKi/tkvNJDzr4jduq2zKdbM=;
        b=L2bPSBytG3u5hNKLMAYLiHPt3C5115tbK1AHbvoiU8XoUcwWqUGX3mYy9ejwLhH8NC
         Nd7k3eaTowtr7HNldX4mqZ38E/0FGNa900HPPKF1PVnFdUs48xogmZlvHPhalf14Kb/0
         CcNeAB4rdbJxaI8YWL9kNXJGVQZUv6SsRyRxX7bnmuZTIOKCWUwvGefWGlqjkWHgogg5
         cTArhqjd5e1ZPvCrZ41AK3+RgDdMUR+CzLlsPCujm1WHqFez5YmHB+nEXUzlPoJQtPrR
         u2oAXJAK5sc5rg5AB8tNHPZMV9fQW80+zIadLyAi9xVOG9mIj2OveIS4PcIKTErEVR6Q
         cnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957526; x=1720562326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlDKvAdBKoPRv/bIs38+uKi/tkvNJDzr4jduq2zKdbM=;
        b=hXfplBui/Vw7/ZMBgc20xal9/7vMUtaZPjoXDQbbnfeMbbmSHuZ2RSQDeaCdibhI1s
         7z+WQH3jCYk4P6+NmP0aL36CK+LJ5O1ExHq3PgdaLJxtdx2G4LZkghMHrBHoMVoQ/3xI
         9GpIfcgL6SN0q7Yuh66lZ/3+teelGIcqlGulsXnzEO203HA1lESLrcLVomRGxhoVBprj
         E17kwNF8RMhHy/8ODJ4YUsrg8YjGAk4cQ3+cuRg6soeTSUXar9mBoJ1JXtvStz5W73e4
         tjVob5lWdsXPzsxK1Jfjhcky8CqgJJxTvvpKMpT1LBbpQqJQoYY96VbSg1keWfIZ/o4t
         a5cg==
X-Gm-Message-State: AOJu0YwQmO3GszyjTSOuX6G0+mZ1E278GbOITrJBwwbNvLkXOkga9Hb2
	jZlSC6YCT4+CoWCVzx0FxBpVmai4B8HVxYhhKnUsln0J856oxlCI
X-Google-Smtp-Source: AGHT+IEykACPg8Yuh6xy1PBNO3lKJQHFEEJ8ReiFUL2QHWIsQS/wu8Ny162mn5gSs3mLVbeCJLAYLw==
X-Received: by 2002:a6b:ce01:0:b0:7eb:7887:a496 with SMTP id ca18e2360f4ac-7f62ee118a2mr1185180239f.4.1719957526148;
        Tue, 02 Jul 2024 14:58:46 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:45 -0700 (PDT)
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
Subject: [PATCH v9 26/52] dyndbg: change __dynamic_func_call_cls* macros into expressions
Date: Tue,  2 Jul 2024 15:57:16 -0600
Message-ID: <20240702215804.2201271-27-jim.cromie@gmail.com>
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

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix it by changing __dynamic_func_call_cls{,_no_desc} macros into
expressions, by replacing the do-while-0s with a ({ }) wrapper.

In C, all legal expressions are also legal statements, as converted by
the trailing semi-colon in a statement-style macro invocation:

   drm_dbg("statement form");

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 19f959f9a6b4..121a66b0ca25 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -287,20 +287,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id))				\
 		func(&id, ##__VA_ARGS__);			\
-} while (0)
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id))					\
 		func(__VA_ARGS__);					\
-} while (0)
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
-- 
2.45.2


