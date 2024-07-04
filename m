Return-Path: <linux-kernel+bounces-241109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B210392771E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE155B222E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9B1AE09B;
	Thu,  4 Jul 2024 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8wF2OBM"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DA1ACE62
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099512; cv=none; b=JCKCm3DIHlTUJUpRdSBUVx/pmuceOI03BdElanL0miVS3jvUGjBbJ5Rqm8aK6KfCWvgxdfAvQgennlAnBMSbfM4ETytPn1/nuzrjaDc2y+jbmcL4VShhshHDSvqa8C5GnS9yVpFz2v8rqHkuCHd73XZTFK9d51OC8l6HCkWzDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099512; c=relaxed/simple;
	bh=Voll2Yc8WG6/v4LxvG2CK3/mC5XTekANdrTvNMMKUiQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pzYlF0tFY/dYVENzZj3FdhS3tKf1IsqUefgY7pVBmWz5gSpxBnNCLvPw9z4Q1JM8ydVJiuiOVLHF+dVf4UANqNdOTeIegUhkUIA6DKPeCIMIyASFgYIRnHLzdui+B6hha5alT92Eq5vTN/vdgmJjfUEYgGY6FvPGtKLOpEVtyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8wF2OBM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a3aafc6eso1057693276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720099510; x=1720704310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/z5eWgjSAssnhVs5ruBEIfE2gZpUKEUPXtdY5HP8ZQ=;
        b=s8wF2OBMeZPvBVS/PI738kZWEdoxBiGBKdad8Mz9nhIaEKFmI3K5BaLylQU7LNBMEk
         zWHYAtSRjhmVv7IFXhGYyE2cpRkhRaS+LYeIR0Y+fGH0dNbWP5CFx3loKr5/Nj6neKGM
         +K3DJ4Pfunx5Um32bzqwe8G0tjc7WIwautPIf62KgXOOzIsqU+8WatBr/OIqeZSUHf7q
         DbT2CbxYgeCl3V4HD7UHeh4EFaGAsBgTn9F3Hz+JYEj8ncXs5vp2K4U2u/zBwJ+f1C35
         KfXHgo4TFAqoOiqNlXCIa96QiiXXjZBdxFXMHciK+bXj5N3dWyvoFN8vtS7yTeSA72Zl
         bWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099510; x=1720704310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/z5eWgjSAssnhVs5ruBEIfE2gZpUKEUPXtdY5HP8ZQ=;
        b=M/vOxiauaR+4KCRZsD5pU31Mg8/X2GPSeZdpFgzd4PDSbJ1p1QonDsB+pclinGof9L
         wQZbQHVuo6qpFBk2xw1W0sDa2pH5NIJS1MdJlZvRQDv16FHLQw/y1/pQdJA8LNG6DvXs
         I63qmXRq5QmSo7mP8aiU9/sj1d8xbtmOQwkLkGyifQX770e+zc5nlZhFiMydfR5rMwao
         6Jn6JhcBXsvi2vdztmzT4CvL5kOWAzd0isePsK/EgF0CidkiG6J5b7cAsXw51XROioVQ
         yTAZmxMhMyxVlbOQBby8vyqKa92qfBuwfVCgaWTZ+hJa/dXFss4siG8SRmujZSlhCGay
         dAeg==
X-Forwarded-Encrypted: i=1; AJvYcCXl7tVy7QcmyFZTpuB9ULzQze6tGx7gKSXu4irQnlrQiHMnKW5sZTYBVQ9i1BdZyS8SvkLJp7Axuv9nvxn5OQ3Pp9+vV/k/7LL1hYZg
X-Gm-Message-State: AOJu0Yw1tunIg7IHrEduu3bL5u+de3PJC1Ka4ea/PnWht3G47V1MmvxP
	HzE+OHxDT+O2WC76NmZUsaV49PIPNd6HI0gH6Zl1KWNUARJzxl1iqZGCrt8KaQO7BQnyBOYSrbH
	htA==
X-Google-Smtp-Source: AGHT+IE3xCGxuoDABW3/KZUt4f7AaMn1Bp0SuK/C64OmLq4UAu763ExpBjweZKFQcIPU9hCc1uGSO1MbM30=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f773:f667:425:1c44])
 (user=surenb job=sendgmr) by 2002:a05:6902:2c07:b0:e02:e1c7:6943 with SMTP id
 3f1490d57ef6-e03c1b6806emr2887276.12.1720099510027; Thu, 04 Jul 2024 06:25:10
 -0700 (PDT)
Date: Thu,  4 Jul 2024 06:25:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704132506.1011978-1-surenb@google.com>
Subject: [PATCH v2 1/2] sched.h: always_inline alloc_tag_{save|restore} to fix
 modpost warnings
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, chris@zankel.net, jcmvbkbc@gmail.com, 
	kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com, 
	surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mark alloc_tag_{save|restore} as always_inline to fix the following
modpost warnings:

WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_save+0x1c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

The warnings happen when these functions are called from an __init
function and they don't get inlined (remain in the .text section) while
the value returned by get_current() points into .init.data section.
Assuming get_current() always returns a valid address, this situation can
happen only during init stage and accessing .init.data from .text section
during that stage should pose no issues.

Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <stable@vger.kernel.org>
---

Changes since v1 [1]:
- Added the second patch to resolve follow-up warnings
- Expanded changelog description, per Andrew Morton
- CC'ed stable, per Andrew Morton
- Added Fixes tag, per Andrew Morton

[1] https://lore.kernel.org/all/20240703221520.4108464-1-surenb@google.com/

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


