Return-Path: <linux-kernel+bounces-440332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC59EBBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA2F281D00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E82343B2;
	Tue, 10 Dec 2024 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ylsvyit"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D322FAC2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866265; cv=none; b=iL2NQBEkIAouiFb/liiahWlkTVKKSD51LUP0m83uxgl4h5xQjYXikCxVsVjVawuOUtU4P4MhDU99IGqXdz0pq7+z9K0ho62obZcrFKwgyyzJVMFrHVT4f5SydPPN3SSgDcjOQg6l02Uf4IU0/0fgjZph5njmr9TbhW5xK5TIZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866265; c=relaxed/simple;
	bh=lgT59yOQQAh+32S2AgovLwSLHWGX99+a0idf7dOno7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ML7EtsjnLCPw4R2IOmzUUcG4VyGm/nGN3KEoX8/dVED+WaUohxSNkcWj0/qm3kmMhTHJ7IMctufEsoaZAteaXoqb+Gqla+lFqD6HIiDTxwcnWRMwSAPsWbGENWFhwvZlkLn/z+7DnnvJjHqSFwu6AdcLAevTGxpbS00pZQO5xRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ylsvyit; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e1b037d5so141593685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733866262; x=1734471062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLtQZxHfyZ3UG9LKxPNXk6qON+2equfYqBxEH3X/7vQ=;
        b=4ylsvyityhFbZ+2POrQR798MdpQdWKe2vmUt9mmeOfpswcv60egk0uLA2xBxZdKmUk
         uOwObb0FW5iISxBp/mgW1acn8bQO8FwkA0j2siy4lZIepuQjDirnz9wzeyTIwIagE1CD
         flUt8apEySaXbqE6Ka2cnSBrY9bYMTlAQ43R3nfcsxO5lUyGX7T4JyhJES2raj9jTnuh
         vIB51D3bemybZzaY/69RsrLYId5+XRxJPi4YUy/cJa1tN8zOLNgNrNuaHqshWYiDdRJE
         AX8nB9Kuw1OReKQ6GDbt00QsTtMxqE1c1r13p03S4JpNu/62CudAyRpM7ARPiDTgVu/D
         z6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866262; x=1734471062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLtQZxHfyZ3UG9LKxPNXk6qON+2equfYqBxEH3X/7vQ=;
        b=a/wBFplnpRQ00rylcrRX31hCbANVRgc7kywxL4lc7CTrRyx+tb9TeuTZFzRlkOUzY5
         DT8DRlOuow4+QbYi40eYEZBJ+oRG1daiC97SRtawHLOCq0MnveLIy1ElKuVZ0uJ9C+z7
         pzjxCJZNUEExy/UcypmLOs2WbnHoNb42sA0wylWtzUNNaIjyeXIZl/Tx7p9oycVQZxOH
         18/Ld1ORsl+NK0Z9z9z82ihGArR8fsZY+Rd37s3lLAH8JcApIUGAu4KyqWnQQP+RL5kC
         jB8WUpPV7LcKn+YrriqZpU+aHd0ZULZYLRLdjs03jGYQsIDmvOATMiTbW2X5wBgm1SL1
         ZKHw==
X-Forwarded-Encrypted: i=1; AJvYcCXkZ/Z9Cn7nY3to2CYxhzkaZdGN6oZxFxDczgoS2wHnEnWs166nIegrgoOzMIlKL+eZPVRO0PgNU3NdQLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhCvbq5teYVCKJEy44zYSjc6btWWWxfqQpIj7C0Wg7CjIBMzy
	mlVILTNXrmRzKC6uXEA84/FEbUMnaWM6pD7ml8VELg2uciG5vZEL5pVEj4MWBlc9LhFKYiPYelQ
	gycy2wQ==
X-Google-Smtp-Source: AGHT+IH3NMWyVkk/B0e5FDWJt6ft3j8uGcZlVg76bwog9+Es+PKknkRKBnzr77X+s6jFQDjeJUd3QE5HwBLx
X-Received: from qkkl16.prod.google.com ([2002:a37:f510:0:b0:7b6:cfce:56c5])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:6181:b0:7b6:6c33:994e
 with SMTP id af79cd13be357-7b6eb433b8amr127896485a.6.1733866262599; Tue, 10
 Dec 2024 13:31:02 -0800 (PST)
Date: Tue, 10 Dec 2024 16:30:48 -0500
In-Reply-To: <20241210213050.2839638-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210213050.2839638-4-bgeffon@google.com>
Subject: [RFC PATCH 3/5] mm: mremap: Allow new_addr to be specified as a hint
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

When using MREMAP_MAYMOVE previously the new_addr was ignored unless
the user specified MREMAP_FIXED. This change will allow it to be
used as a hint in that situation similar to how mmap(2) behaves.

get_unmapped_area() will handle page aligning the new address hint.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index fdc1b0f1b38e..1d2522fba0ef 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1205,7 +1205,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		if (vma->vm_flags & VM_MAYSHARE)
 			map_flags |= MAP_SHARED;
 
-		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
+		new_addr = get_unmapped_area(vma->vm_file, new_addr, new_len,
 					vma->vm_pgoff +
 					((addr - vma->vm_start) >> PAGE_SHIFT),
 					map_flags);
-- 
2.47.0.338.g60cca15819-goog


