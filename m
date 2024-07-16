Return-Path: <linux-kernel+bounces-254279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC967933167
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6863D1F22FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C711A83DC;
	Tue, 16 Jul 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et64Y234"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434441A83AB;
	Tue, 16 Jul 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156339; cv=none; b=jKhHcXhzSkRQXPvHOrwJhHc8gZ/zA88CgIkEj6sv/YX/xCEI/nAtNj6veZ5tJ01dIM3TPZY+OigRAEun8tU+HmKF/G0Wv2t7JkWWVQDMz2vYDogL8jTra053+8J8m2UqOjJRIrVrViiDCAE+lP4AHDJHTWuinMaFaVHohaIvjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156339; c=relaxed/simple;
	bh=xz4ayeIEfnsbKz6byqcq4Sdf23ac6igLKRe8POg37eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrQGsBIdB2Hbx8SI4ABjaaQs2mzF5jIRFvhncEfoqapE6l91dnIV/EhE5J63cU7OnXqHhgg7NHsdPf+N95ioflkTNQeLiUXzr0i5oB+vifp0aAcx26AXv5HkZzCWKZ6NNVa+Bnrng7SQ6NhhEIyBKHFMsYzXlL9SxODf4xLJ6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et64Y234; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3815aaa2ab9so247555ab.0;
        Tue, 16 Jul 2024 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156337; x=1721761137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/0f+WJi9XEdvmbVJJgJH3wGY/BCuH90DF46SNcsdjc=;
        b=et64Y234II1Rvc45SmHez7T8XOkvcnzsNtvXDD0wGbjxLG5VANscOuyTmX0qyRUOBg
         /dOntx2yR0cwvIDaEu0lG8pdUCDPFgk7gGKm3aK22nONfyNp/pR560lFmR1OX8zl3qiV
         Y5dBmB65pAjhot8TeL/507L1QXm+NDbvMPDLMolbkdUIdkkFbyUsre2ak9j4tfYHUI1n
         5WQpdUM/JwIaYrfryEiA5XgXXiIFJwBDxXLNo1iacvT55to7mFJOoh+4KlLBTtD/9CZN
         Sb6dKcSy+TKG8+3vceq3+8VorhCyzO6BR8jbjufGpFBPlnRQV8x98v+6SDpQ4k15K1Fm
         a4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156337; x=1721761137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/0f+WJi9XEdvmbVJJgJH3wGY/BCuH90DF46SNcsdjc=;
        b=l84UR8Tn7m4vhiRaWrDjtM1ymJCtIRZsSk8iLwIbL31XdacBGQ977KpWGzn/0jxEPa
         1UBfKHEevUNTgui9kFzyBg5+tC4PbaA08nlboPmg/awpcNw70IkgzpQbfo9HkljOTWmc
         vb1PwlgpT5Z77bPqN5fMkQ0dBmFW/+yw13bLt1YNl6nBK3+Wb3G2bZ+YDxWkzaxkkBbS
         SpwMJP/Trv1Ko8KyHI+DOLTSlRalj1sOipP54MZmBMezsgfkJ6ome6EVRxWodSdPOJdM
         oYhWRn+vP582t6S/Tjb/TnQL4HmJieaiNmPVSZ7ySlkaEh2EZw7ZQ/uKDIGJCZTW1tA2
         +EMw==
X-Forwarded-Encrypted: i=1; AJvYcCXGAwKfgddHdKQqswzTPP7XPoPUKdBc1Y1RHl09d6wQYuOIkCAzDLNJfOaCsjmosDHh8W4rJNvd8eY888Agw+PR8K2rz52rJrZ5
X-Gm-Message-State: AOJu0YwZRoxy1l1PbfY+I6+GG332bDdP+i/XE6+s5LzZXLbmaoar5kU+
	AiOFaqoZNffzgKG695KV8vrE4N3LHtXiq4RZmtnZfrmsp+9PMyJkbfwUvXp4
X-Google-Smtp-Source: AGHT+IEi4sdjxzQ0oudUt7GMdorsoDaH0Xjh0/KlGssDHL3rDixHQ7EbnOzUaj0Aj/gbK9+Ua+nMLA==
X-Received: by 2002:a05:6e02:1a04:b0:380:92fd:c4fc with SMTP id e9e14a558f8ab-3950f2854b3mr2319965ab.14.1721156337088;
        Tue, 16 Jul 2024 11:58:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:56 -0700 (PDT)
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
Subject: [PATCH v9-resend 25/54] dyndbg-doc: explain flags parse 1st
Date: Tue, 16 Jul 2024 12:57:37 -0600
Message-ID: <20240716185806.1572048-26-jim.cromie@gmail.com>
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


