Return-Path: <linux-kernel+bounces-278564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9094B1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BD01C2129A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BA81553A2;
	Wed,  7 Aug 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Y7WCHF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA014EC77
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065205; cv=none; b=TLY/o0Qk4yJxI+0oAJRolnq6mtFvltP5i4Tq2IH/a4KgFbr3z5+d3quJ+uPtBcbvsCGqzaaZ1WIxZ2w5JTkrFQlUvfLS+NED6N2wyTc/haiWbpdWP2lKotDZaADAuzZyvEFbJFU5/dIYQKXswywZhn46telDpuG3OdH0/AFypO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065205; c=relaxed/simple;
	bh=FDADV2BTEwJ+ON+56YH/gWeFoI36jwwpLMj16QIlsZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCq63uTGSGkgWEQGvnemw4W+DGBeY4mMInqa7dZWxHSicW3MLT0l8jrjdZ/va9iis2hznl/x1lch711yvKY7bk93q7nUK3p5x3ER0P2czaBcjEZhTdHwgh0KgALX37Uf02z8JvCRfqXw0K0lxc3vT6BM74WLe0KIAb4w0RhqjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3Y7WCHF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so1913395e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065198; x=1723669998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfNB5/9qLPsvFaLP7sHH3GbTU29axJKL+pgsuJpQFBU=;
        b=E3Y7WCHFOxw18WReMHnHEI+H/qOFp7SSCFZeo5npW748HrnvD2ItToRHJ9hLl6KB0+
         oF68Rkpq7KmsitdvL9c30zOBMNGW/Pp7/zGMGXcwfP0OVtdNmXk4UVYjvtNG2QmIuQz3
         6hrLkJ0go08F/AaqfVdru5v4ZaEGjbSyDI0zWDSv7+wNBEhbHuO1jaBemdtraE8EtQKG
         hGgXLu/NddDgiKkhKa7KdIiq704wMeiu/kThRC0oyIOIwTs4K60bphW5lSOK4ILJVTP+
         SE+Hm8Sqe9s5cn5DK7nH3qzbVm+rQFxx6rzoVCIhIyH0KmRPEcwE2fXddeXeNdJKpu+M
         F74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065198; x=1723669998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfNB5/9qLPsvFaLP7sHH3GbTU29axJKL+pgsuJpQFBU=;
        b=C/nJlDVzjDceKA7zjpUNp223lRdB1gLLD1zfE1RqKlp2Kb6Rhxdgr+ejxqxr0Xwui5
         8pJeUUhdawKrViI92ls3QWqNhaEo4bTDc+OoRouYxvdtl7npHA+p6rsF0Ew6uCVGADbN
         EXw4qyQqAKEanRTEf+8YrTddRsdUzsxjXn/vl3bLF1zzuYQPTKl8kVOXc/plIkh3EHWI
         8LxN8rFBy8fWFrqHPh2vmVp70EKo8O44Fqb5XFl3TvRAFmmwub24gg8lZ7dfCtZnTtVG
         6gyspshjPxMx1IBpGxDXytghJvMWzUCjDIH0zL+aIeM2oBzVopSyN1WfReq+/4ztjqP6
         Nb5A==
X-Forwarded-Encrypted: i=1; AJvYcCVW+OHo1EhiApfdOfF+8YEUt/o4/P+kkG4QbUfxGuK2MjHxKJtlnveqGwF7OQHwaTe0EjPmD9gqaSLlaCj7RLiQf9q7T0BV3WdwDNOm
X-Gm-Message-State: AOJu0YyfBzGFTCahYJq7k2ygb3ZjR6i5L3KUN1tc19k5ePQSD3Lp3mCJ
	P9oYA7+z1ykGeXFiSMky1Sh/O4cxJm5zaG6znAGZ4YwlE4BTujWq
X-Google-Smtp-Source: AGHT+IG+QqtyoGEr6BZhBo9y73IoJVbdjczi56XnHZ7BCAXUG+64xMxM2z7lHTolrd6PpGlBLESRAg==
X-Received: by 2002:a05:600c:350a:b0:426:6ead:5709 with SMTP id 5b1f17b1804b1-4290aeee25emr70945e9.9.1723065197875;
        Wed, 07 Aug 2024 14:13:17 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:17 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 4/6] mm/mremap: Replace can_modify_mm with can_modify_vma
Date: Wed,  7 Aug 2024 22:13:07 +0100
Message-ID: <20240807211309.2729719-5-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delegate all can_modify checks to the proper places. Unmap checks are
done in do_unmap (et al).

This patch allows for mremap partial failure in certain cases (for
instance, when destination VMAs aren't sealed, but the source VMA is).
It shouldn't be too troublesome, as you'd need to go out of your way to
do illegal operations on a VMA.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
v2:
	- Removed a superfluous check in mremap (Jeff Xu)

 mm/mremap.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc64..35afb3e38a8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -821,6 +821,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (!vma)
 		return ERR_PTR(-EFAULT);
 
+	/* Don't allow vma expansion when it has already been sealed */
+	if (!can_modify_vma(vma))
+		return ERR_PTR(-EPERM);
+
 	/*
 	 * !old_len is a special case where an attempt is made to 'duplicate'
 	 * a mapping.  This makes no sense for private mappings as it will
@@ -902,19 +906,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
-	/*
-	 * In mremap_to().
-	 * Move a VMA to another location, check if src addr is sealed.
-	 *
-	 * Place can_modify_mm here because mremap_to()
-	 * does its own checking for address range, and we only
-	 * check the sealing after passing those checks.
-	 *
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
-		return -EPERM;
-
 	if (flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1079,19 +1070,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
-	/*
-	 * Below is shrink/expand case (not mremap_to())
-	 * Check if src address is sealed, if so, reject.
-	 * In other words, prevent shrinking or expanding a sealed VMA.
-	 *
-	 * Place can_modify_mm here so we can keep the logic related to
-	 * shrink/expand together.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.46.0


