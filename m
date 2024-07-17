Return-Path: <linux-kernel+bounces-254582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F259334EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F691F22D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F31138C;
	Wed, 17 Jul 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdzBCKF+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BEED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721178997; cv=none; b=sjNWMg+iVrBzpAyPy5aI30Kks0dTigacAyI4u+mqhbC4zIag/TBVJT/4s5x6SscMkh3Cs82bc2zslsgMJy8Fq8u2Seo7fqB5lUjCjI7thzm+K3gvFysq2HHIRj452cf2V88wg5TtPLpqirpOFWzpg7Z2vv1twkvRUSjrYSEOLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721178997; c=relaxed/simple;
	bh=8nBWF6owfg9OMfdRqHWqrseyKhi5lTpgCmxGSlcTJh0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DABVUO/yj/nLVo8RIiH3T9mAVu00QpbrB81KE6GKs00PDp4R6aSl+7QrtAxOiIWeRfpGuR4Rcw+w8ZF4vWuRKm05FJKlqBFXcg6JUvDYVaxVHstKKzEg7cUG8exr2pYnjnNxV+hsCK4z0bIvh3DyM1bDBsejS/+o6W8N5dLpNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdzBCKF+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65fabcd336fso84387087b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721178994; x=1721783794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtrRmPuJ7RM5N+fdBtCHcqUiCGG1Rz876hQyLiOH5uA=;
        b=gdzBCKF+qrGN/ID6tvsMN6UpmjBdRHMRZvxtGy8AZAZnC8A8Pmswm2HmxZ/g3IhmHq
         Bx1nivpZji5Yg5C3EFesg1odQooJg8dIEI+UV+af1vKaJlsrGpw77e+uWPTuWkUNXNs6
         tb1SHWkL6v4xvUqCerpTtitaFU5GUnLhjbQFSfjf3uM7dDpKTBH3J0/r+AxZ1nHHjpEC
         gjP60Op8pOHpMZdPR5WkGTiIPhWKIslc/BY8x+U/XK1txSdnodRg7gkXZGFvVn2hGTje
         zvo9Tcu18DeFK+q+pdf6l+AtiZPPh0pvu720dsGq4s9Pe6KuY8CJ1kKxKXN/yNgUNN33
         /3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721178994; x=1721783794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtrRmPuJ7RM5N+fdBtCHcqUiCGG1Rz876hQyLiOH5uA=;
        b=ESOv4rpTvebdcu2OGfe3M8uY1HfEEpE/el3cJJPLR8B3Pfs8CkSXlwv329fAIT1tmE
         kxa07ErI6qRzGSGG1HCbRiHM+l4FRBuiLeCoOKe9A+9oLo0pWFvqwZUPoqO54EWLmjmR
         JeIIGGnclxJGhvnsmjhEq6moHdxDO/Ek0I9QeBDzSg3zifT14KufOMvZFXnRAvGZCHCq
         d0MHMDRObyMLu9XlYlocpVj+wt6DlYyKFtFTntwCISiwQPoI66Nynl+/zxnDLifqkKoZ
         Dd4D6swNpftrN1Z0QrzpuBQN7UDETXZ5B3B/SGs4DgLed6BsqTQ88p9QDpsGfbEzOlry
         cDRA==
X-Forwarded-Encrypted: i=1; AJvYcCXiJyrwP0KaI2iIOsiPM3VWYk6w2bvYlM7dYJjbc+qsMW2YnShOA64NAO3hscdP7ccgHNpjSOgYjnlGaBoUigzR1bWY11i2pKW3T/vJ
X-Gm-Message-State: AOJu0YwsINibU8EnULhIOVFhoWIw2kiIpaLMYoJIaurlstw2KRO3pU7y
	n1HTr7/kqlQkGdPG8LgEN/Uym0eFdL3yy1omTcD0hNo1jmMvXlbYjYSA84MXjyhyTYHZZmnONIB
	f1Q==
X-Google-Smtp-Source: AGHT+IHTFNVrUuio+0uJd4nBOImnRm7IfFbCs/D9PnfF9NdGaQRDzAThxxkd1t68PzDM1tR8DwO1gU2sT2Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9b4f:4efc:3f93:ed78])
 (user=surenb job=sendgmr) by 2002:a05:690c:2fc5:b0:62d:fbf:920a with SMTP id
 00721157ae682-665015e57ecmr106577b3.10.1721178994558; Tue, 16 Jul 2024
 18:16:34 -0700 (PDT)
Date: Tue, 16 Jul 2024 18:16:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717011631.2150066-1-surenb@google.com>
Subject: [PATCH 1/2] alloc_tag: export mem_alloc_profiling_key used by modules
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Export mem_alloc_profiling_key as it is used by modules (indirectly via
mem_alloc_profiling_enabled()).

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..832f79a32b3e 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -15,6 +15,7 @@ EXPORT_SYMBOL(_shared_alloc_tag);
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
+EXPORT_SYMBOL(mem_alloc_profiling_key);
 
 struct allocinfo_private {
 	struct codetag_iterator iter;

base-commit: 0434dbe32053d07d658165be681505120c6b1abc
-- 
2.45.2.993.g49e7a77208-goog


