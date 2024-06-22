Return-Path: <linux-kernel+bounces-225522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DA9131C0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FF1F21EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636C8C1D;
	Sat, 22 Jun 2024 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUSbesyK"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6A79C0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719026422; cv=none; b=mS17TzhNx1TvOa7qdYY/g6c2qEZ3tBKmSrzWPtxsrD1dEVL1O/JcZWHzLpScxHxM/fotHOyQWr4XEtE3B91S8YuAHCzjQHJNhuZQ8AiQaaaUqejTcJmrVORm2Ym/I0acElLe6vOveb386x5l7nNvu/VllPRb2nM4TXkZn7W3zNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719026422; c=relaxed/simple;
	bh=I2qpG19Op/YTmIetnh/fRS6hI0Rtx4zMgUsQuKkAgFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFtme+YrZFIvtlrQXWqGlyg+/SX/Wew7S9AVH1TrKCkpSPQbwyqbNz+PIScPSPwIZ7rFXtAvbmaIXMP7LAIP9Hc+NyLovO8eJYFPbBSHJ+MaG+dZ5zp8nT8Cx0B91QeyZbUP4AMZlXP17RpJIzsW2DIUXaqXuSf/tjHp93i26Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUSbesyK; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c1da1f88dfso578327eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719026420; x=1719631220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noIRKzwOenkJYlyIgDWrCHnrYGfNUC84Fg2QmqzIHaQ=;
        b=EUSbesyKlQ+nxVpcEco8ZNhqYzu8RYff0vsfSk9YRCd+Fu9JC5bYVcXYbhewy1mUD5
         SxjjZUpvMt5lC3TMKCOl2VRfxJIdqjG2376Up+lPg4gaeJIRCHP7qwY/VyJ73A5iF5F3
         MJNAoSJlZrAFkz99oVVh3QhjCsUaM7SRQqPx+VtUp/EsWX5Pm8b3qwLMt7lMQrizJ00S
         SCd4+DM8cMdQudc9itsPD7r8BT1EAVd2lNWvqL17Gzgz/lgHxovNQ7oJA4ZfRsKlmLU9
         Bb1HNuFufwTuR2nv7axx7g4O0v8LkMAn+GUBc+VxAavBmzjN7gDdC1wKj8pXh+BOtDD3
         BWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719026420; x=1719631220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noIRKzwOenkJYlyIgDWrCHnrYGfNUC84Fg2QmqzIHaQ=;
        b=PLSB9d9qG3eE3ePeD3tL+VaZnbO3yxh7xLUu5djyc5/9Qnsvlpu0cJdNcfRZdj89ri
         xezRA3Dtlvq3ayurt+/scDppRAnuy+WuwPJLD2bfNxlsYQEAjWoPmB7MQyD9AohvSxFW
         9vQxdEZ2arcugG6AliZO+KSLrk+v8Wg1938+lTLNx6XTSz0dUAI/egOWxv9TC3IHJUse
         vghDhLDYimFt5OxcpS4fsffcXvhyf2naLGwsnxIUoPJJWqBuf8/+f9TSRMyEB0jI28hk
         PwZEkklL8sXkBzDHP5bzBAbgdUqMpwsSpjjVpvMTfClOlL0d+tKo4rjvKNMTgkmzmJTc
         Yb/w==
X-Forwarded-Encrypted: i=1; AJvYcCXzK0W30tc2TTkoIm6CX41pwHDyLc3laMdAuANfj/sc5zRPaO8/CWmxPilbAdjjDumgLT40xdzGdg+jg+W9tK24KMlgB+O6gxT6dGxv
X-Gm-Message-State: AOJu0YwGEjFoTlJI2fcVROthPETonuNa2BvuEXj9tIm8Gao9OBtn0lHK
	0IO9VN+Ma2rn+OClMONjYCC28TSRSIlZ1rn4A8ng/zunqwkuObcX
X-Google-Smtp-Source: AGHT+IFzHnx7M3tBygs51isXq4OUoLtq5aQdebcrHujNqGD7L2U/YJtdQ0FFKqmCpZXizQf75nioOw==
X-Received: by 2002:a05:6358:6f11:b0:19f:174c:7fa0 with SMTP id e5c5f4694b2df-1a1fd559d12mr1201106555d.24.1719026420184;
        Fri, 21 Jun 2024 20:20:20 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c738c1bb81sm5388045a91.1.2024.06.21.20.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:20:19 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuanshuai@oppo.com,
	yuzhao@google.com
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
Date: Sat, 22 Jun 2024 15:20:02 +1200
Message-Id: <20240622032002.53033-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <02b87f01-69c9-4007-b0d0-5ce9ce35876d@redhat.com>
References: <02b87f01-69c9-4007-b0d0-5ce9ce35876d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >
> > Since this is primarily a documentation update, I'll wait for two or
> > three days to see if
> > there are any more Linux-next reports before sending v3 combining these fixes
> > together(I've already fixed another doc warn reported by lkp) and seek Andrew's
> > assistance to drop v2 and apply v3.
>
> Feel free to send fixup patches for such small stuff (for example, as
> reply to this mail). Usually, no need for a new series. Andrew will
> squash all fixups before merging it to mm-stable.

Hi Andrew,

Can you please squash this change(another one suggested by David)?

From: Barry Song <v-songbaohua@oppo.com>
Date: Sat, 22 Jun 2024 15:14:53 +1200
Subject: [PATCH] enhance doc- mm: use folio_add_new_anon_rmap() if
 folio_test_anon(folio)==false

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c   | 1 +
 mm/swapfile.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 00728ea95583..982d81c83d49 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4346,6 +4346,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * here, we have to be careful.
 		 */
 		VM_WARN_ON_ONCE(folio_test_large(folio));
+		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
 		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b99b9f397c1c..ace2440ec0b7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1923,6 +1923,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (!folio_test_anon(folio)) {
 			VM_WARN_ON_ONCE(folio_test_large(folio));
+			VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 			folio_add_new_anon_rmap(folio, vma, addr, rmap_flags);
 		} else {
 			folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags);
-- 
2.34.1

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


