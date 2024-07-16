Return-Path: <linux-kernel+bounces-254264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534B933114
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E21F23879
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6011A2FC6;
	Tue, 16 Jul 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjiyuybD"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599011A2C28;
	Tue, 16 Jul 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156313; cv=none; b=WdsXZGP1HXPiUnTneSxxqBHgVSIMXT9qeAmMGsNhc6NgBl+NdadEsgublztnQqEvgNgwKIkzJBWOYghEck/0VCcjsCvXsSLEjtpPHWyctyYKEg5pasSWZGg2RV+13uC3RkalzMVRpt0/Rcp9eSWzj4ksNmgfVw4mHjPsmTYL8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156313; c=relaxed/simple;
	bh=hDky0tcbjpEUJlBM4lJpM2oQBO65Ubzgv+qLWDk5NXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z54Le4UnEtTIsvyhrriuHM1Dm6XNRnYqRvnBvFcBm+JrA6u1Fscx9ySWs4Hnud19RRJASoGM8UrGsgh65CC1Ee7rVF7Zp1bX/8cAQZ4Q3HTLCyN7ecnajoW9Ke0Uodj/0z24cKYxPRzbEfKOjBKNv+rZwLPc70VXpG56jrka6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjiyuybD; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8111f946f04so5130239f.3;
        Tue, 16 Jul 2024 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156311; x=1721761111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kihqcq8gEwvlFuKQVqVa3kRjj6JIPweX7rDvgcIT9h8=;
        b=LjiyuybDD2kZTBvYHa0Z3g1IbNy82JKNcU66RTT29gFNNNbBMhYQXvBH5W+0C2foc2
         R+6IBy6ORmO9T5EfgwB+qyQnppySz1p09/uxe99jm7C2gSFianRiMBABMD11vqZF2xKx
         gpE9dsvEKdpMTnnVwickkmFPhRu83XUp1MHvC4yqqzY4gxy8Xin4ybecK4hcxrbhIKEs
         3raqjf+ifLB/MLFLqDT6O9WDMONHB5cpxRrsJdmzl2iDLORejZ/jwTx1sNIG2nRPP7+z
         wJuOZu2MZuytorY8IY3OzvB4A/yAGf0/0DaQQC9EzqnvKfRDC6/KLTIuvTFe+s5q0Dx7
         9HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156311; x=1721761111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kihqcq8gEwvlFuKQVqVa3kRjj6JIPweX7rDvgcIT9h8=;
        b=OieMPhtDfgZ6DFajg6USpp6A+pQEmEAIpbXUEtmwOHL8oB+OnZj3bP4d1W0Cl8bj+h
         8+nTUVWhbaq5altnJwdJYEhQlCkV5OdY4XQn1LkBqHIC+Z8PFNObVH/GkKDtvHl7Q9IX
         ngDoLMPuB1vspVd9ZNfITiJdxnv/LAbALVq4FEuGUKCJibxnMF81ePdyCa7MOIyR3djA
         WoRtrAVgMGhy7jcVgudHwzwEckj5scy7sHk8xU9Nsi3UDPOPdchZ4UGoGpFwxVa9lAqO
         Q7QZMcwVf/dK2kmhqoRzKeKJKdP7DNS4Xn/VI4E6QRQaM8g620HIXi9sy2maBq3OGCFF
         eDVg==
X-Forwarded-Encrypted: i=1; AJvYcCUVdzb1iEz4Jw6AFU8dgXzTvzWM3q9P2UwrSsY/bgswLFtUJU0aPp27klO62RC/I3d8qB6m6ExCAj5XRXdAnJEDYwrQxtCpGR+h
X-Gm-Message-State: AOJu0Yx5Vm4/Lu1FFYkH9Nbo4/etv/gn3dpEDL9DLQlMd+ZM6u6TzDoU
	DjHYmJfRxP5rbcaoruNXca8v0Jb0e3XVYSzEJ5G7TLmpq3Uyv3KtuQBkhA9d
X-Google-Smtp-Source: AGHT+IG/+jo69dsHArTBqixhUoufA4QPx32dYcoWi4IHunj5MWvseDBGOvH7eIX5hx3svsuPZC331g==
X-Received: by 2002:a05:6602:601b:b0:80b:8cb:e9a2 with SMTP id ca18e2360f4ac-816c39b5f53mr47969539f.9.1721156311067;
        Tue, 16 Jul 2024 11:58:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:30 -0700 (PDT)
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
Subject: [PATCH v9-resend 10/54] dyndbg: silence debugs with no-change updates
Date: Tue, 16 Jul 2024 12:57:22 -0600
Message-ID: <20240716185806.1572048-11-jim.cromie@gmail.com>
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

In ddebug_apply_class_bitmap(), check for actual changes to the bits
before announcing them, to declutter logs.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 368381dbd266..8320cadeb251 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -606,8 +606,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -622,8 +623,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.45.2


