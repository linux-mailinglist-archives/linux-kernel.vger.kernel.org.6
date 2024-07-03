Return-Path: <linux-kernel+bounces-240284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE5926B50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2251F2276B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948A142627;
	Wed,  3 Jul 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYDDIRu0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D525760
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044926; cv=none; b=GuyyblQrOJE2ysmiAWQBFdtHwDUi5d7ASj7ax2K5thPiXxKmr7RQuFMXC9carw4P3GQueRyjatKp/UVSe5chgCvqklUFHjYwINZhlfjVgQJmhYtWtGxFlXBPai/WQPdTL3sOM0wjnkZ0JWvwggkrOuGpWM2tbNYrVtHSODuTwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044926; c=relaxed/simple;
	bh=5U+97VIdUMemMTBgeVDVpiqBOk72ICdW8Uhny9VtHkQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WXINmPGlN6R8iRgyfWuf4XI0h0ctMdASUile7TQ9EDEVGk/LpJVc4oWdaS+NtOHHBXhej4wqIMkJLqUJW3KhJGJjdudENRGKoTzuMfun8qlI0idV8O4D/fWM1Ohw4NsJwkmCEnPXUglHY4h6/12EQMvMLKfYunyy9hLFjMQxU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYDDIRu0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso30075276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720044923; x=1720649723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VbdaRivJDkEZ8uZPg1xaCceJnWoje7EsJAVnR1Tx1rc=;
        b=RYDDIRu0JpJ/ydPcP7D08pJFpNhaixFtw+uMuPoJvsRl2NO2I747tL0jPtcRY1zjH0
         hsieGfGbYC/dDSo4c83qhzFgngSlVxKQmbQSmZSelGcRMpugSgJU4goC4ZZkawaWXi3d
         Sql7Wt5GMkyKdldgUk8asFcGWpZE7jhFwJbumvel7Q1/tgdkcmmP3gF268GFCYdwUdZ7
         Fv/FmvzRYuSdYjIz5PwJ/Yv6gtVY1yWXwLXRH50lEFG25pfat394KsiifGJS8SE7YM6e
         +l0djU5E/LtT62C4f8xyY5sNNADOklUpqs7EfwCY768yAiei0fJvB3E06IUp8oarTDVe
         G24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720044923; x=1720649723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbdaRivJDkEZ8uZPg1xaCceJnWoje7EsJAVnR1Tx1rc=;
        b=PXFc4BC76pVOPuP2SNPU1cJWh8voCbWlgQ5JrOnoS7gZHa3q4Unvg0Xx1zSctQC39P
         DEBgVQUEfV/rx9se5gMD/a8ofnfUJ/hYE2v8PfL65ysx8t0aU5nYWKBpWun4yvH/2JE9
         Rtg0o4ker+xXDyRRKbsVnQM8WF1ljvJXfK694uOmZjK+NcykOasnD8q3YQ5i06cFjWfg
         97MuPamAgIJoN0QrTAPBbEQsvZHmPtFSuAgssojhmCHZdmNnmz9YvNSQJE3dNlK6VQNa
         fJef93yf7QPL9E8TU3xKMqlsHaslmJ/+Er7FSPA60AvWtoxQnAF8xeMufdxPbJDbz6s9
         HOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSbD6RnKtLrFRYn1T6Ch69yrN3reJ6RkC5PUm0ZmX3z5W3PkHNZst+XLd3idLGqM6tRVU8SBdkkCcXVNrOAe2xjAuhwWr7gGagsHss
X-Gm-Message-State: AOJu0YyPJypx8fQ+kwTYXiTXY0adYEBd8jSKVdXIOUeguePpjfxr1aKa
	2++qx83zt4K0OFvTzWR3oNwP3GW+HYNqhHoDQ9o5rOVx8Lv3Q5JlHlYg1tqjRrjL4SR+rj5gZZu
	VUw==
X-Google-Smtp-Source: AGHT+IEmFnRUqMiMpV2rFepFx+AiCteobqdvOcvm13aNrOY2ADxAQRCBuPvTOUGzOwXbPQD/DL2+RWfWE0s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7049:5206:eaa8:8edd])
 (user=surenb job=sendgmr) by 2002:a25:e20e:0:b0:e03:5312:c053 with SMTP id
 3f1490d57ef6-e036eb2ffb3mr41300276.7.1720044923618; Wed, 03 Jul 2024 15:15:23
 -0700 (PDT)
Date: Wed,  3 Jul 2024 15:15:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703221520.4108464-1-surenb@google.com>
Subject: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to fix
 modpost warnings
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Mark alloc_tag_{save|restore} as always_inline to fix the following
modpost warnings:

WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_save+0x1c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..a5f4b48fca18 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2192,13 +2192,13 @@ static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
-static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
+static __always_inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
 {
 	swap(current->alloc_tag, tag);
 	return tag;
 }
 
-static inline void alloc_tag_restore(struct alloc_tag *tag, struct alloc_tag *old)
+static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct alloc_tag *old)
 {
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
 	WARN(current->alloc_tag != tag, "current->alloc_tag was changed:\n");

base-commit: 795c58e4c7fc6163d8fb9f2baa86cfe898fa4b19
-- 
2.45.2.803.g4e1b14247a-goog


