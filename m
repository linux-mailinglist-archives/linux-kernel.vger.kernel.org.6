Return-Path: <linux-kernel+bounces-539155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F90A4A199
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A4175D05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558327FE8F;
	Fri, 28 Feb 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXwaL0i2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19266277812
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767399; cv=none; b=M+tjOy+c95Dm7OVr52PfjjHs6cmV/HvsVNA1XjaEcbLJo9LbIqWT3OzumUzhSUwnKmwcooEI0xWk4VU3HBHiF9VcTElLURH1RAkcQZgEJgRXHjxBXUbg5hG+Z5Vx182vB8PRyFYKtM96L0LEX8D1TdD1w9T/dVbqPcHKUs71wBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767399; c=relaxed/simple;
	bh=HY2CGcpkWtS+ntQTMmiNkH2cZKOFeEFwZNwW9vji9Mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kGb1XqQxeWbWdr4n09iL3XEYfNWTn76/wE0CeEfGYdhlCfEXYJLiBxGFURYBEvxT+Q0D0+FsS2Q3ccyWwAekph285GCr/0ALvSCKeGwwUyeaeS5DSlIVaRQR0nL9KuZoo5IHVXBWOWb2z85EJATMpo3jBqd5CGcNj9m9EfIOXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXwaL0i2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so5260953a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767397; x=1741372197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFqvkI2A59BbRTUcT+L5ulTUxSAi2JTL7XhWtVP7K+w=;
        b=qXwaL0i2bV+s5VXeoHAUyKYcMVxs/QQhTnnalMqGGWaMIXWESQIX9ucdpigep+Oees
         SyaoJA2RPyJYFkYmXWEUwNKcmVTKbYZjkYKjfbhKkjR2JtdJmbXekKpuzvbuC1DH5vwz
         K2EQalggCbdPU1TJlEYkTGihllUZ8wlc4Gw8qOz33iCMzTLL6wB0UJcrhGGI2/AOrBeB
         OJcVVLEZ3eORFfJfje3IPtZlVBg0JK8uRuPprcYYfO4B2EI5QNybpRCcymKr9zWGrl0v
         yADOlIhTPlmYqD9K/jSLVGmIFcgYHj1Mn+ZNUN20x/CB1hEsSXM4Q/F352m4Q10FZk6r
         U+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767397; x=1741372197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFqvkI2A59BbRTUcT+L5ulTUxSAi2JTL7XhWtVP7K+w=;
        b=qro/2TZLW/4bFmoQfXj61niS0DkRjRGJdBSlo7glcDTwG1BrD5e+YiWg5HcAZmaLZL
         4i/MqhA4uLbqx0MRjK9BmtQ0ozFLn4lXDC3sqPK7o1+Qj0blP+5N2Rt+vCC36sXmSruC
         6mBx/ceCHep/B843zPmrBRf1YD8oNY1zmktLkhv/P9y0XcVs8nAQr3cy2cqX84L/SZld
         ilQYerI7XyC9ViX0ex6n+JS1kYZDlA8J2XypzxEEItWfvr7NEvX4LfCu0lhjfyck5Zh4
         qo7b8KX8a8yqFfe3OSSwgBJ3Io4I0ouFOwT7PwGugfb3X2GTDZLPaMFc8iG9tynLvFkT
         d0HA==
X-Forwarded-Encrypted: i=1; AJvYcCU4qTl5v6MYGJY4VYl5ColKH+oc9/FCOM2iJtkwppnZp7n8ldcXr12P9O72JOZfFFjKXBnpTF/vcWS0iUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlPkYbq/4tnx70CkwVCZDH6EsQreWOwuveVvYBPl1F8pXZPxx
	4BQ0XL0iq9ZXtmj7GZlkdxisj/OQR34FDTPyJZyrX5dVSlNu8l8bdbDccuYf+0uWMpKo0w==
X-Google-Smtp-Source: AGHT+IHeteXGZQA011CNg8cQpzXHdzrwZLVc5nXKBfxk4YN+FprIvtPh1vjqeNwkbz2HLtK+Z+J7QiKW
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:2fc:11a0:c53f])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c11:b0:2fe:baa3:b8b9
 with SMTP id 98e67ed59e1d1-2febab2bdd6mr7106444a91.4.1740767397292; Fri, 28
 Feb 2025 10:29:57 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:06 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-6-fvdl@google.com>
Subject: [PATCH v5 05/27] mm/hugetlb: remove redundant __ClearPageReserved
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"

In hugetlb_folio_init_tail_vmemmap, the reserved flag is cleared for
the tail page just before it is zeroed out, which is redundant.
Remove the __ClearPageReserved call.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fadfacf56066..d6d7ebc75b86 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3198,7 +3198,6 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__ClearPageReserved(folio_page(folio, pfn - head_pfn));
 		__init_single_page(page, pfn, zone, nid);
 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
 		ret = page_ref_freeze(page, 1);
-- 
2.48.1.711.g2feabab25a-goog


