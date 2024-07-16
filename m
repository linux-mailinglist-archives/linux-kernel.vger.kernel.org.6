Return-Path: <linux-kernel+bounces-254280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C45933169
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3992851AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515E1A9075;
	Tue, 16 Jul 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYbxfpeU"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A621A83C6;
	Tue, 16 Jul 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156341; cv=none; b=KUS/RM/E9KXrJzPJY++KCyuLVxSE6UWzenK1Bp7TRP7DVTXdBw3QVRTovIfzlKQWjlCU/9xw8luXA46L/5NJ+1s1eqwaTNptAD0eUyr1LbG4IhZWEP2J6tIwE2I7aXFTllZbBtA6hI8mRx8GxOLn+EA8S1Pyp4th/ZU/GMeDkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156341; c=relaxed/simple;
	bh=YM09ov2aL5TsiapWtesYtdrCJOGiLL44YOpci9XSkuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1et7TmzMWeqh4K74M921n+jRF+RWIGdOuXuRFafBsqhF6G1WIbTZR/Z7DS7ngkCx2WUvz26wpFHD/5MclQ8U7YM+F0XCiWrpUkuu09je+9ZTTC+4CsIjuNR+0RL/lI1/kelCwAycsUlC39DTue2NjzKT2VDCtSyk/BgaotDNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYbxfpeU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7fd3dbc01deso6030539f.0;
        Tue, 16 Jul 2024 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156338; x=1721761138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/7VuWci/fAdciTJrLUpogyH7arPQhCiQPPhJCx3EJc=;
        b=VYbxfpeUpQ3fkcJXzhbR2NHHLsPdn5yEwDuNVrGTJtOR4KiiecQBr6Ym2FL3GS97cg
         s9XlNoVNBqhyUEBYhnXE1gLGdhsbTLvvd/uLzIE4yZoqwxEE6cEmyEF0XvHCSojWd45u
         bcKe9GyZddh2hyN8wsP6tWykdiaRZlDtUVtqqzC69rk4mi3XWWJKCWOxTXvCKnPj36pC
         q3oeU9CKt2RpXmu3Kr56oj5zVryJGbNRRQ8yswzvrcaZAMQMhvBMtejKyttpogrsOEg/
         F8nes2q6MWJRPkilQIByKaE/CdkVS2tTA3EXrP2XEgPrzO/fB0Wzj6GFitRfZkN4tZvj
         6Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156338; x=1721761138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/7VuWci/fAdciTJrLUpogyH7arPQhCiQPPhJCx3EJc=;
        b=JUjPc7KZsCj0QqSVz2LC+gbWoNTfWJOvIAjYoLR++gIbTJ+bjr+fEqg4IMLjcZhJJa
         8HiFxu2YT38cO87YdbNF5UnhtwoAumkuqqFjkynndUwohfz4wEDKMeASes3n3dMkKjj3
         KsGeJVfHGfOUvKm8RcwHhThNvcoMPpBarjcRborgA5uQ1e4E5Ihq8svx3F5mpVlhHY8h
         EM2ccICoGg5nRAXtVdv/T4hFhOSB7/o2xAuMRXMWJK9hI8ejKfru3rlDI2WVD/RtGfjV
         VVXOWgrAf4hZ2tLNLPu+5a/WZiD+BOJvd+WMuPLgNuGdB7eP1up5zEjKfv5JDBpEN3mN
         qPQA==
X-Forwarded-Encrypted: i=1; AJvYcCU7B3/fQ4vsODms/W+/zowJReUtDnd3/7HYfOO4bvcGTHn3j//srVGv4KXp8hmoOWj5ZcDDVld9Eg+BYWnCh9/NecrHqfEMP9g4
X-Gm-Message-State: AOJu0Yy+em0Vk7yX2WBa8nmiGw+IDbCh4mLFJAFcPTqUqE56+ipEKxVO
	wbvow1dzPiN+bElTYtefJ3KqRR58PfSsnjovRmq3/euSo4HTOXlD48ZsYo4n
X-Google-Smtp-Source: AGHT+IHzpE9SbYwkG5siTLQEKUl8Xu5QeKQLe1T8MPzVIFBNpAur8fUdPhqKhgFYHtZREDVfwyEkOA==
X-Received: by 2002:a05:6602:484:b0:809:83e3:a35c with SMTP id ca18e2360f4ac-816c33f0308mr46697739f.7.1721156338284;
        Tue, 16 Jul 2024 11:58:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:57 -0700 (PDT)
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
Subject: [PATCH v9-resend 26/54] dyndbg: change __dynamic_func_call_cls* macros into expressions
Date: Tue, 16 Jul 2024 12:57:38 -0600
Message-ID: <20240716185806.1572048-27-jim.cromie@gmail.com>
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
index 4a9b9cd53eb7..c958085e0df4 100644
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


