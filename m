Return-Path: <linux-kernel+bounces-238422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0B924A67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF21B22F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795D20FA8A;
	Tue,  2 Jul 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CChOgjvP"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6B205E22
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957499; cv=none; b=g46JrEVTFOeqZwnIQlOaqnZ5WOmKO97B9ptY7LJ94MCEPirLotTDel/dzNpvoxLsEp2EbGZJP4RbaObX5586e4t3+NKRHhIbbeUJWtPT7uB20+EmReBF7sygpw96DARkSqD4ue3AdvIgU7WZYSAXIqYiLfw4DZumg4PhhMexQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957499; c=relaxed/simple;
	bh=jMFJSvW8rwGwA9QU3Al6zitYRBQUQs9qdqLxCiJYGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLM2vMy1VFxLBMCUocJUrx4sZ7dlreywCz6p7EUbP9hZZCB11Ekp5I4DLLf53RpARiJay21S00u/QSPKA90GIRs/BEtE9awYToNKSbAs24SC5ZPXXApYRAFFV3v87keINcxugqtCMeUpB7wT0rmwuM9owHFNVrOOr0nwbhonR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CChOgjvP; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f62bb42938so154623539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957497; x=1720562297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jicnEuSikysNdrvNl4Iye9B1q1hn5wCOtgRQWjJh+Y=;
        b=CChOgjvP4G5QXgw/DezmE1G5y8kgxRAFXcnJ4yC/YR8JCJlJRvFMRVHEgu97q0d4kb
         Vvyf4118ioZV0Puc4qhfLC19kcq2Y2Zg1Hib0dNmXHbBYbLrVjq+IdTnHBbskgnTflXx
         /+sP/z9LcXBxESodlXWLXoBmsOWhdY01bx1zeNnzuX6e4dHwXIMn0EXkEwrDEvmlThOJ
         /yrYh5wjwVEXcgVgUV97sd1J/qItMpdt27yk/VbSoFy66THil8YHNua9iwo495zoq2i0
         5kpRhi4OYmzPwB6kvpfJxjUG+YnQw9UO6lekd0NTwYy1c7SjRQiRYf2FLEPcTlep/D+Q
         AsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957497; x=1720562297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jicnEuSikysNdrvNl4Iye9B1q1hn5wCOtgRQWjJh+Y=;
        b=PC2/NrBM7SnWt5FXOXizZzonCQVqu3dRSpi4Bf8ZjzQqoIV5NKixM85R6CaULJOlsI
         hY5luXHnkCFr01+8Y8QRIUiTizVG94L214eWyx8bvVeosFG7lXzIETbEEQIOaTs9S170
         iduA43BDBJQfBaeTtguqEs1xf8xNdhJC80qanj9ZS1uLbiJYtqEnqsRWcfuKXBWye1RT
         mxty7e3EioFqb3XjP1SXuHJEBQAJvWe9TyK7w6fjItF2YVMikAlxFRfkcrewinrKD5cf
         /lNbiYybYO1RSYCCPbPSbXSSGvVHwThzrNQMhWilepE4OEMfR4SgsmpYJeik7FVjf6U2
         MC3Q==
X-Gm-Message-State: AOJu0YzkGd0IiFWC+zKadr+fpsXoQdizuO90hlvjQRnj3Z2tcTLhVFJp
	/7Os8Hrszss6fBOcDrlFRFaWFzUZWUv58xOqOhLFgBLPFIKc32jh
X-Google-Smtp-Source: AGHT+IGgEpsraXVf8DsSJ53T9EEmQ2VNyi43sZWgM3hFXw7ayPt2A1BBLWk8VrVLBa5eFbK21ld0jQ==
X-Received: by 2002:a05:6602:1224:b0:7f6:1ea5:de97 with SMTP id ca18e2360f4ac-7f62ee3d6bdmr1057195239f.3.1719957497302;
        Tue, 02 Jul 2024 14:58:17 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:15 -0700 (PDT)
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
Subject: [PATCH v9 02/52] test-dyndbg: fixup CLASSMAP usage error
Date: Tue,  2 Jul 2024 15:56:52 -0600
Message-ID: <20240702215804.2201271-3-jim.cromie@gmail.com>
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

A more careful reading of logging output from test_dynamic_debug.ko
reveals:

lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, 105,106 have LOW/MID and MID/HI skew.

The enum's 1st val (explicitly initialized) was wrong; it must be
_base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP param).  So the last
enumeration exceeded the range of mapped class-id's, which triggered
the "class unknown" report.  I coded in an error, intending to verify
err detection, then forgot, and missed that it was there.

So this patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP(), showing
that it is too error-prone.  As noted in test-mod comments:

 * Using the CLASSMAP api:
 * - classmaps must have corresponding enum
 * - enum symbols must match/correlate with class-name strings in the map.
 * - base must equal enum's 1st value
 * - multiple maps must set their base to share the 0-62 class_id space !!

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..a01f0193a419 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.45.2


