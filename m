Return-Path: <linux-kernel+bounces-319469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F051E96FCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730B31F254C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3A1D6792;
	Fri,  6 Sep 2024 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv78uai1"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AA61FF2;
	Fri,  6 Sep 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655799; cv=none; b=R4IkbHAO9DNZe/+lZ+igJAlybv6/xNFxoZ4RUu7dts4Vrf6AxDAOQekPXzvYDohJD8Wwbx+4rB5ikOIHfMBDg6XTIZIf/SyV0yG1aocRv69PEJUzMjck8AdIUypJatCKjaNgzMR0CyhxMemqUPLlsM0ka58E+yyWYdbzn6ShOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655799; c=relaxed/simple;
	bh=Wtlp/ATJ+1nN5i440t7V2T1lZJmIGpp7HBEctvSayrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPbSgMkGEx+pXQgFPlViSpgiSmw7omnntnvzvJQ/uGmofFnaYk53jUfH+srHG5W7HQpXYupUKE75NLe8oSPPopO0csFziOqfSWnSyGNmIbJPkuRUgTkH5f42HAzPzmyAqeBVW6Iq1rT8cg2vFQRCVlGmR7VCP6INTXjcVyRgV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv78uai1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d44b6e1aebso23779867b3.2;
        Fri, 06 Sep 2024 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725655797; x=1726260597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FQEZvFrvKovB2wC1xSsr16abxPdVdaHcvYWUsxwkLo=;
        b=Bv78uai1/ersYZmfGXxweTiGrbng1Wmnqhzb/+p62NGtrTJoxLOtWT2m0oBkeXhPiW
         YB9uhnyGwBTpryjKFxXAkSw0h+n9ECsbWrMY8ClfeH4adHw6moPgVIBIueG7oes39L+R
         7pG2gD2j70mreoqKhUWeMd1aNqjyt0a0i21mcOu6WLoYqFFoX1YXifOnNPIowk34YwEu
         8kuCE/noS0b2PuJolcQF62DtfyYlsc17jlVvL9kIbFlpFZ+KefsGnisCGhFhn65x2Wxy
         ThXPMpISWaNq6CS29SyMwax8nIV740qdRHcJ0c29eW4YADyTuPu/oM5EvPNWn7aRhd4x
         b1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725655797; x=1726260597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FQEZvFrvKovB2wC1xSsr16abxPdVdaHcvYWUsxwkLo=;
        b=gA/yhtLRq7Yyi4orCJ6qC93nX9MjxeXGJD8XNPLkYf3GirIrt3ro/V8V6TdDO7RCwf
         mD3hOq+DTU/1r93KqvQpmAknjQdrv/Ql6Mnj/SdUWQyR5PzIVjLAzmiJtNZvNq/CWy4+
         0Il/AKW7x26Sb0JsQlnHlrjP1ThewDmeHYUBi7yZYkl/aSB5eoHZohb6E78PG2hTWq+m
         +1vHrYSomFda4IBNVrcKh3ouIs2sMPTe2Tfpz19gzmzDJBo3qsBV6sVJXD9S4QAj2BPu
         fXBPBArWXHCD50prMKpVK2DfCQjiK0vsLnimHFFChmxbEZt8TUt2pkkemYTpLDcE5Zfp
         Jb5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfKPZpDEQqTK3ypRRpVyDnY5PKeAIZaVESbECOYj8XBjeDuI0MeWqqoF6CV9EjTvHPfzaCJnvdsa1QjxyY@vger.kernel.org, AJvYcCXUxyHnaXtwTK0r+wXUJPhW0mDB5ViIHekiXdWnpBxWTRBQx4sW57/RMcQbdW7FsGAU7j5GEqEWV3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbAP0c0WACJAQyij2l91EIsFsCo0CIBn3R8gHX1mJ2Pt5yg4h
	GD4sSesv4ofU/kfrW96wYUl/YCJkL85xSl3Ka4xWb4MyMzxsRT1V
X-Google-Smtp-Source: AGHT+IHPUMkcNYJrjgcd9B+lpzTO2SfTsu/VoSHqpDm6HhpYFVbBnOWH2XzrNgMzrl4bBpfgUY96rg==
X-Received: by 2002:a05:690c:dc3:b0:647:7782:421a with SMTP id 00721157ae682-6db4526c459mr40593877b3.45.1725655797025;
        Fri, 06 Sep 2024 13:49:57 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a98ef3c31esm201620685a.45.2024.09.06.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:49:56 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: corbet@lwn.net,
	nir@lichtman.org,
	rdunlap@infradead.org
Cc: Dennis Lam <dennis.lamerice@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs:mm: fixed spelling and grammar mistakes on vmalloc kernel stack page
Date: Fri,  6 Sep 2024 16:49:13 -0400
Message-ID: <20240906204914.42698-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/mm/vmalloced-kernel-stacks.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/vmalloced-kernel-stacks.rst b/Documentation/mm/vmalloced-kernel-stacks.rst
index 4edca515bfd7..5bc0f7ceea89 100644
--- a/Documentation/mm/vmalloced-kernel-stacks.rst
+++ b/Documentation/mm/vmalloced-kernel-stacks.rst
@@ -110,7 +110,7 @@ Bulk of the code is in:
 `kernel/fork.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c>`.
 
 stack_vm_area pointer in task_struct keeps track of the virtually allocated
-stack and a non-null stack_vm_area pointer serves as a indication that the
+stack and a non-null stack_vm_area pointer serves as an indication that the
 virtually mapped kernel stacks are enabled.
 
 ::
@@ -120,8 +120,8 @@ virtually mapped kernel stacks are enabled.
 Stack overflow handling
 -----------------------
 
-Leading and trailing guard pages help detect stack overflows. When stack
-overflows into the guard pages, handlers have to be careful not overflow
+Leading and trailing guard pages help detect stack overflows. When the stack
+overflows into the guard pages, handlers have to be careful not to overflow
 the stack again. When handlers are called, it is likely that very little
 stack space is left.
 
@@ -148,6 +148,6 @@ Conclusions
 - THREAD_INFO_IN_TASK gets rid of arch-specific thread_info entirely and
   simply embed the thread_info (containing only flags) and 'int cpu' into
   task_struct.
-- The thread stack can be free'ed as soon as the task is dead (without
+- The thread stack can be freed as soon as the task is dead (without
   waiting for RCU) and then, if vmapped stacks are in use, cache the
   entire stack for reuse on the same cpu.
-- 
2.46.0


