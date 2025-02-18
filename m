Return-Path: <linux-kernel+bounces-520066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDDAA3A534
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DD1895E41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B822F59B;
	Tue, 18 Feb 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3I9tDD8V"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF21272909
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902661; cv=none; b=CR6+h4r+oM8vJHRMp3NyAg5QQeQJ28whV9NnWnR0/djiq7YHmqGssPFG4UVUcQdO1OxK9CWlxUG72WHiaxpnTg9F0etYrWTt9Cci82NE0bsgSbRNuh6g7jRItNzA4mBcYLb1HuemTgnk/TJJzNWFGqAB37qhyUYhFPNJnkP/Fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902661; c=relaxed/simple;
	bh=5vZQ1GXCvGMDTWhgfthSKEBmS0sQYiH3cOarqWYrv8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7pz6p4/NPHvffffeAkUUaGAaFBYf8daSKjaTzqB4nbSy2YktICAXpiZKABwknAMDeoxEj/dQD1A43R9VfABOqWRvtBbGfYb1NDvEi2ZrezvM9705IroBrxNjZuCVNVk/dTSZYUnpIPlm9yNzzD60PlA8WW5xf9vuDhs5keD1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3I9tDD8V; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so8609415a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902659; x=1740507459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4lxvaanET3KprDs3s7VrwzCEx/dq6Uoz76UzjW+xmI=;
        b=3I9tDD8V0EWLpmf4dZDj8U8Scp56Ez+YQUSjIcmWyiS4L2k7b3eIPCHmjiSE/B5yUX
         lzO7dt7PpPLq/sO0vcTeo2SzuNQbveS8chB5czZeoXJ6T8omyEkqQdVq5nKkyoO9sKKe
         UZyWfpUAKC2uYx4AdDfHlsKUrj+cinBSGQPfdQFYRqNAWba2/mywsEgTcr/Eyc7rfVVP
         Fyb38Sfn36kdGeDaopM6otBP4YMgO3TZUAcjd0zXBSV+/bq4nssI3mM4dFjejVncujgF
         RJIEx9vaILtwxrHAl1Lv+LdUEy5srCF7Vx3qDCndx5s6T5KCxFfybJ7rlC//hH98Q33H
         zlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902659; x=1740507459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4lxvaanET3KprDs3s7VrwzCEx/dq6Uoz76UzjW+xmI=;
        b=guTrHW3r5CQvT2vxw9MQCrlg9wlvu/o9hMUzQSLNjWNDOF7AInIsyy1aSmWLsA/cNe
         aek4Xia2xH66ZopoZhFb9aKcNerLrkB1Xtqmdk5NhcNjrtOjF+i5QXC+5OdJ5jDuIcLF
         X4OUbIJV2s+inRRgkB0qWtE9WV+foSNdhzWJ/E2wpGsJ9wp3mHEB8FKgeO7ft+zLPd4Y
         YUAO/+q8/GO79YtZpcc6GASh8DOu4oFj1fgEYJwJnQ8VOvJRGZqwGu3t+Y3nWoKJeeLZ
         qazutpff8KLuTDEzgoAyeIxWsIk6AW6PTnLYPH4+9LNSLvSpVDvasHW3g8z/YzRhWI9G
         V3xg==
X-Forwarded-Encrypted: i=1; AJvYcCWSoZnlxGceYPIEjClUxdcHet6eWbbXtIXM1B8+jg5sLEPnuGOGMCW0mFiwdZ6WTbgaH8SZkP12/iPdWCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsv/qQzmzcdwYlcXPAfn0qRwm1GxJ1h9AvUfA91r8Jw3rE8GE+
	OZ1axgc7Pv7g0rOO+vdMevLU2HgtpmojDUQi+Vi5j2UP3WDWNdPtrnrTE4mk555TfpwnBQ==
X-Google-Smtp-Source: AGHT+IFxez6ckyQY1Z+cRSf5y3EPSwk4DytJGyZjzIw5jPp+flAShbFokg8rFRyA+qYRsz2KFf/vnhwg
X-Received: from pfbbd17.prod.google.com ([2002:a05:6a00:2791:b0:730:8a55:44fd])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c2:b0:730:9659:ff4b
 with SMTP id d2e1a72fcca58-732618e4fccmr18581142b3a.19.1739902659518; Tue, 18
 Feb 2025 10:17:39 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:49 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-22-fvdl@google.com>
Subject: [PATCH v4 21/27] x86/mm: set ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that hugetlb bootmem pages are allocated earlier,
and available for section preinit (HVO-style), set
ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT for x86_64, so
that is can be done.

This enables pre-HVO on x86_64.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..fa0c0059959c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -146,6 +146,7 @@ config X86
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
+	select ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
-- 
2.48.1.601.g30ceb7b040-goog


