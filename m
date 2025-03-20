Return-Path: <linux-kernel+bounces-570211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FBA6ADE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A27D981BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22F22D78A;
	Thu, 20 Mar 2025 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7SapxrG"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4C22D787
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496807; cv=none; b=HtjC/vknABG5vB3lTS9CPpDLlczH2RDvDgSgSaztL0eh7W/1tVcphlAw8OyE50y/iUoGiKL3QKpif4lvLkyCD/Pr+CWGHQfAsoRlSJgbtRLwO3kE32UQ4KnBG5BSntN0hG9cgaFos/s0MMQwoI0OqDD9rOr1r33ZRdb2YIfSKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496807; c=relaxed/simple;
	bh=+NXwNGKV/1Z0oc/l3HNpTN1LcU/aCdQcnGg1yUnOK7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2M+f6xuXLhp8buRZZhpBTNfnEsz3i9+ZaxX3UHxi376qow8cDnzqHYA3YbB5WeIhAMA6rHu55ikKgR/cs0wwSlGArX2+yEWroHGLzvMBNglGo0hhGx3PerdMXmw+SRgCqqu5oF6Z3BfwYCNEGGaW3dmwVZgK/JxSJOHjihS2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7SapxrG; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85b4277d03fso43900139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496805; x=1743101605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ+ezC9PUeelEIyxHgbZMmX02NoHE8P8VEj6JEyG+nM=;
        b=l7SapxrGmPQJ0x1fk9Flhhhn50DE3wXLgsf/QZ4kUyWkoxmod1Sbw8UfZCANtbQHLI
         2/7HRL4M/ggcmkL0/l1y3WPyBiPz91XBj01yamIch/RTvFeUTVF5+6STMWLiB3U1RN/t
         Q/etAw2rl2O9CUz4JTwRoPCk1iYrdejAfQ2XZHVr8DdGScpB02UffJ1cX2R5FDqADGEM
         hV/u5W+4Z+q/iA4Q8ODu2pCwNUkjYLHt8nkbt7Emq/6RX3BNHYXFYz/s9iUIzmuLAigc
         xb9r67IAob8x8lLWkvU8l4KxPGO8D4Y+qk8DHeCGlsKiCjOHGoB/a1mz3zlblD6ihY0X
         MN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496805; x=1743101605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ+ezC9PUeelEIyxHgbZMmX02NoHE8P8VEj6JEyG+nM=;
        b=nGLKaU1vX/KBDz4RjhzBjSiVEg+9mcikYAJhHTPwOIy0Th0pmYL34ZooGiNg/9eXjT
         AmPkIJ/sZH6i+Fp9nDzO6y0W0ui4u3RiO7gLn86z6DsfRhQ7zIPdTfwR25dBRSFBYq1z
         VixG6XZQ1WKQK7KZmp9LKvfICPuyzO37p04KNb0p9iBQfYCNB5CALa2eSuiuzIBQafT+
         s+15zmNFLd6z3TBMUyirq9IwssdkPWUodj4NzMjn/p4KSsKEXlM532SUuPBEU2KMPKjT
         jVb+ezYT6p97HRInHgsSHgVFpt8hUBsMMXAIusS0txz9Nfe45/uaj8GVged1tz6Mnltn
         q+Cg==
X-Gm-Message-State: AOJu0YwnT12inXQOIaDDfCMk3iziN+BAbI+K9Vp0Hb6szEap3kAjlZjf
	t6w/U1z9YQgcfHmGrKz9yRgtJiy8VB1igH7b80vvA4cIIlFcQay5MzhcRui6
X-Gm-Gg: ASbGncvM54k0sTuHkV307xHHDg80dLArLoCSj5+Nx2gCKgsqFO+O89+0whYG5wUrqJc
	I9orNrrj+cDo3nriV81SEdiUippogYTP9l1Ca2j6CsK3mTc/dE0pdvH/F721tr1OBpnj4KGTKk/
	0HNCgjc1bSUHNwdVNdFxEVyT0FjDmRpSIZpHIxSp2UgDirgOmz02h+VRSh915da9PFb6Cvga1+1
	iKjB2Hu1SoEnDWj+e9Gv/5VF69pld7XY5VRB9SwzI9UQuVBlSVvMXo/waq4jpBeSXtqvvZT57wT
	bPCrLWQ06fHJxrvqLH/hJvxQRpWobUrgoNW7R/wbdmHwi//etnQm101IwK3rTe2bx8GkLPhc5Af
	vRA==
X-Google-Smtp-Source: AGHT+IEy21UJZpH5HbjvbS8lr9b570j8LyVCYAhWgxnKz7fNXlLpp2iHEoci/m3GRK4/7vlcpxTMZQ==
X-Received: by 2002:a05:6602:b8b:b0:85b:3763:9551 with SMTP id ca18e2360f4ac-85e2ca756a0mr47745639f.7.1742496804887;
        Thu, 20 Mar 2025 11:53:24 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 20/59] dyndbg: check DYNDBG_CLASSMAP_DEFINE args at compile-time
Date: Thu, 20 Mar 2025 12:51:58 -0600
Message-ID: <20250320185238.447458-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __DYNDBG_CLASSMAP_CHECK to implement these arg-checks at compile:
	0 <= _base < 63
	class_names is not empty
	class_names[0] is a string
	(class_names.length + _base) < 63

These compile-time checks will prevent several misuses; 4 such
examples are added to test_dynamic_debug_submod.ko, and will fail
compilation if -DDD_MACRO_ARGCHECK is added to cflags.  This wouldn't
be useful CONFIG_ item, since it breaks the build.

NB:

checkpatch complains incorrectly about do-while-0 here; its a strictly
file-scope macro, and do-whiles break there.

It should soften ERR to WARN and qualify advice wrt file-vs-fn scope,
& new-scope-declaratives exception (forex: _METADATA_)

The known exceptions by name/pattern works well (_METADATA_ is covered
by "struct"), this patch just wants static_assert added.  On my list,
with above.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
- split static-asserts to __DYNDBG_CLASSMAP_CHECK
- move __DYNDBG_CLASSMAP_CHECK above kdoc for DYNDBG_CLASSMAP_DEFINE
  silences kernel-doc warnings
---
 include/linux/dynamic_debug.h |  9 +++++++++
 lib/test_dynamic_debug.c      | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0e3e14ca4765..da2d677947ee 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -101,6 +101,14 @@ struct _ddebug_class_map {
 	enum ddebug_class_map_type map_type;
 };
 
+#define __DYNDBG_CLASSMAP_CHECK(_clnames, _base)			\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert((ARRAY_SIZE(_clnames) + (_base)) < _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length exceeds range")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -114,6 +122,7 @@ struct _ddebug_class_map {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNDBG_CLASSMAP_CHECK(_var##_classnames, (_base));		\
 	extern struct _ddebug_class_map _var;				\
 	struct _ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index e42916b08fd4..9f9e3fddd7e6 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -146,8 +146,19 @@ DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
 DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
 
+#if defined(DD_MACRO_ARGCHECK)
+/*
+ * Exersize compile-time arg-checks in DYNDBG_CLASSMAP_DEFINE.
+ * These will break compilation.
+ */
+DYNDBG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
+DYNDBG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
+DYNDBG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
+DYNDBG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
 #endif
 
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
-- 
2.49.0


