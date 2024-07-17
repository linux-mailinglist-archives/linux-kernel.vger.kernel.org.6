Return-Path: <linux-kernel+bounces-255544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EAE934213
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165741C22BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4B1822FB;
	Wed, 17 Jul 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShCr/exq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAD7470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239965; cv=none; b=TCDa3nsX1RB8/SjRKEihwXC6VClFwbxRAWbDT+oC123w2lcKASBgpTG2azYiIjo1dYxkZrGLG+8eR1WllULPz7rN2LkW1CXFT8iGDkGvMU1eM00LVcMOs/fdKPjk1ra6Vwtufv2vlJ6QkP2DGcJJ/OHuJCB28nY1vZfCtKV15r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239965; c=relaxed/simple;
	bh=emzXnwHWwao02ZTIrOa1kF0eLHDU2/gXf9YVKInT58Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OSNC4jvtZvnSXTq1E9IdslbcceZ4OANy/U392vRC1DF+wR/QC3pJZBfo3ICDXKq8rkFpVLraxia7+YdfFyeEIVQNc7F9fGvUEnc86+D687But2jjxGJldUQux2PYPIeOrK784MlwNcKjjmLm3tr7rxAL83RECGAnfKYMcW9aoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShCr/exq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05d72f044cso133712276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721239963; x=1721844763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6pCMaBILMVZMpUv76l77hj2CnbpHGxW5ooU7g9rN7C0=;
        b=ShCr/exqR5wV7QzrFaBCsHqkmRPdMDITDKNtuU2itQ6MR8UG4KwPU4Te6VzFQI5fxJ
         z1nIgRjxZS0qk2kGW1uhv9RxRZIrZlBomgEVsLVC4PSF+DZjPAeUG4PumzkqxFQbdC6O
         37RgacUrAuF/E+QwiSou1fd+hmQQrOQUTA1tjv0tr97SXgcmlBE55kLrnIIRWahXhF2M
         ZzRoAQPS5D8RTMfuhzRqOKwrI0mAA1vQbW/hweehNsTbpyrDlgBk/6/0Q/t/4Z3x1xgP
         g8s2/UpXm0NMhLzc4nu6xFecARpOQDM0uQwBcCjcZVWJIUANLcFL2OF06/EK5LCSkUTh
         RB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239963; x=1721844763;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pCMaBILMVZMpUv76l77hj2CnbpHGxW5ooU7g9rN7C0=;
        b=dm2oSro26bomoVUyJRl91h3pXHykmw85WjEjupjfY0ZiUixLQxEvz/2awydRVYoFFJ
         0iKnQmOlnLcaLqLi1l3lDpO+ydT6vucic5Pzozl3UYdWriYgjrvMnFfp+x4Ny8NTDC1x
         NhA1gyJt9wM8IIMK+DGc259RAy4h7LqRY4IfcQEk3yy7B0grlupgLXr4uLFNaz3hpagx
         iObXbNlPDuD3bJ2Nhr6mmUP3/Dt4wrb2uXzymZ0c6iAVJ9jNY/GQP6SAO//vLzs/e3Xu
         qoX1ZsMJPdoQDduQxUpmB7PLXIdkobAhroTezticm9b9cS3/6lwWPqddeM9rg9WqaTsI
         VPJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCSuFkqSfPHYsKivySLMIEjXMcyO6Ru107I9tHWCOcoc74kboMaUm7Hofa8AUf1uVyTygzm+PM4PWABSCPLAOGkhSZ/Cl5zEsAWV7X
X-Gm-Message-State: AOJu0YxwtN7EAcFDd3aOS+qAAcafPbij86L3r44kFdzpcFFB2Gy/mA2i
	tE1oKfLVy0OSoBnY0tUvn6DU/Rvba9y8ukPLZePGoivJmVyW+O1A/z3MgV6z66St1NumJT+6H2R
	vqg==
X-Google-Smtp-Source: AGHT+IF19jbUpQeDJ/W0pDc5ATf6kXEYujgDlZOQKr66XMlhIzOfsvZ1D1pGIRH1/ONk+P0xbyr3eay6CUU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f44b:e467:5c7c:74ab])
 (user=surenb job=sendgmr) by 2002:a05:6902:2b09:b0:e05:ec0e:38d9 with SMTP id
 3f1490d57ef6-e05febb8182mr403276.12.1721239962759; Wed, 17 Jul 2024 11:12:42
 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:12:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717181239.2510054-1-surenb@google.com>
Subject: [PATCH v2 1/2] alloc_tag: export mem_alloc_profiling_key used by modules
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes since v1 [1]
- Added Acked-by, per Vlastimil Babka

[1] https://lore.kernel.org/all/20240717011631.2150066-1-surenb@google.com/

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

base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
-- 
2.45.2.993.g49e7a77208-goog


