Return-Path: <linux-kernel+bounces-238446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C33924B12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCAA2874C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BF18DB33;
	Tue,  2 Jul 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqupiE4z"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6317DA15
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957527; cv=none; b=eBfWSwe0il+WuO8jRLlWBURPvOEOxFeZyyNv36jEwD4P8THDbjX3tpYW7eBa3Atc16htRKhiTOscq7q64ns0+chILKxAh5BdAnld9NHC0vcLxKbM5zw3WqCLSCwwRt8pIQ0ZI+M+/LG9IayATMn0zz8h0ILcN0zPFfzGHSxLCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957527; c=relaxed/simple;
	bh=xz4ayeIEfnsbKz6byqcq4Sdf23ac6igLKRe8POg37eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuciXCTnTsUSsVrrhDQgfldbHsFBH9uGFdWWi4rljT+CN4t424BadTeAxEK7diWwPRQBukmqZsICgM7cKpRvunRSJDOXmfIx8cauWxIxZrA8iST/drj3jbIscyTbmD8fjrapWoYyh9sg7d32rsGjc+zxro1ap/l87tV+rfIk4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqupiE4z; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f624e70870so253598839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957525; x=1720562325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/0f+WJi9XEdvmbVJJgJH3wGY/BCuH90DF46SNcsdjc=;
        b=fqupiE4zyzFJAvG8kdyzP5xb1HViD9KhmdAXDZ9sHjVJfyKtRxBHUBUF8gUvg5tMwy
         gJ7YlNNXj+Bb1vENL2f31o1xUcD3FXbzJO/QCrnri3KT55JUOGF+YD1owsdGwtiLVvKT
         ely5jFIM1pLHrXS4sIGwcuaOW4Xrfzqc0Sh6ZhoeqC/HYszjEOKGT8Cjt+G61IQCXD1G
         vUKR6XYVcabuyH7TEiG9rAY3hkGTp6Oyeh5pJJlHzSHrUZUqzptZ+IEoQO3lGSHDtNKd
         PhftUG+MOYp/hbbZHNg9n+UXxuh81HMuQddruPIrdUvI+Trzy66kGGwGMJ75Ae5k/ckw
         ueZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957525; x=1720562325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/0f+WJi9XEdvmbVJJgJH3wGY/BCuH90DF46SNcsdjc=;
        b=SBIqX2A+7eA+hhGXoXYI4IAupmcifZeOJsvAB8sO0yf0V9XC5xI158g2FWVFMPScnD
         pS/HjKEKstRH14myFkO6NKGUd/lbqbKHUqJk5GQDGem4B26YjwEsudNNChxcG+a2GbWU
         Q0W1Ztc359BwYGPTjRqQfiY9OKuwzEn1dUEfPgTJJQkuWsHnOVKNxR5V8BZsOyzPdhBq
         7yiBjvfsNgLn4PLGblrM35WN4P9U7TFe5bCtbePuIjoEGdvLDJU5AQvsJyE40dgNy/uw
         g5i9p/RiUgpO8iAhslxBqev+kyzlpFruky6m/nMcT7esI2hOMpTOkFq/B14Lww2Qk/U8
         Yq4Q==
X-Gm-Message-State: AOJu0YzAf5Lvj9ESmt1iSaVFsni92cFfExyQyY/6EvMaL2y9hCWrlrJw
	gIm52IaCkuK9gZucvX6GAiseBVEgNeOjn8hMaz7WJMTxw1I0UZqd
X-Google-Smtp-Source: AGHT+IHLfOgNFYNQh7piopnisG8tXecKttMpNNloe2nsbJJt7+ulnb0/PNAJxeVF6b/DwLmUpVs2Gg==
X-Received: by 2002:a6b:f212:0:b0:7f6:2b2d:8acd with SMTP id ca18e2360f4ac-7f62ee3d967mr1225918439f.8.1719957525100;
        Tue, 02 Jul 2024 14:58:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:44 -0700 (PDT)
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
Subject: [PATCH v9 25/52] dyndbg-doc: explain flags parse 1st
Date: Tue,  2 Jul 2024 15:57:15 -0600
Message-ID: <20240702215804.2201271-26-jim.cromie@gmail.com>
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field.  So if the flags draw an error, then keyword
errors aren't reported.  This can be mildly confusing/annoying, so
explain it instead.

This note could be moved up to just after the grammar id's the flags,
and before the match-spec is detailed.  Opinions ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7b570f29ae98..ccf3704f2143 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -106,6 +106,16 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
-- 
2.45.2


