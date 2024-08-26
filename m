Return-Path: <linux-kernel+bounces-302171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891D95FACC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52E81F23D87
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA719D89F;
	Mon, 26 Aug 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEWHxxWV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF319A282
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705051; cv=none; b=O1LWY0/jCLYbMUnlRvI8XOe1JMRuv7gDhYIQuLR0/Q0P8rTB5BHOeGyaPhIka7ZeC98eWnmipATvtPykSwzQjPW+p/UXd0cNQx3xZGabNm9O48kJuixhc+8GQUEQmPbOzLNJDb/tWpFOR7fpE4CIQwrK/D4+aKsODbMDEUpmt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705051; c=relaxed/simple;
	bh=B4CjEPEBNhW/7ay+iPhYCq//7mfGSaIpgiOs2kdAYJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H71KcEso55ilbzznE3kSKc7wI92YoBoA6jbhirUbuI1vSS+IOxQ2k8izrlB0IuCGXwC0WCdzsxQkOcWYyfo0pUMG5v9RLgs4t7qnwaH1rFj6gWuvcQO9Q4C9LhqhNpfaV9AhX6rW4x8CtjP7x0JlqBCjF8bLQLpwg3Z59/QHZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEWHxxWV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFHgAMnpeJHqDMa0ADr1pyvSduy44GuxF04BOe5aqcw=;
	b=LEWHxxWV8B/d9KIasPxZRdl7+97lJzSjELsdoiljqRqKCSpLXavw+Msj8Swo2aUJnCRRxw
	Ti12aQE7K4xioUm6jHUoQFu2JYBiu7UuPQmuIYbo2dhube5JAQc4ClI0HqgOJlB3PqQQbJ
	+Z2b4E7bPyiSt8U2C6I7VorRLRfOtho=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-VDlJFQtUOGa2JtpI0OZahw-1; Mon, 26 Aug 2024 16:44:07 -0400
X-MC-Unique: VDlJFQtUOGa2JtpI0OZahw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1de8a2adbso643966485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705047; x=1725309847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFHgAMnpeJHqDMa0ADr1pyvSduy44GuxF04BOe5aqcw=;
        b=Ef0s8DatuycrXPNZWzmlhqfJrr8rH4c16M8uDRsGTNhMst80YiDpOfDza/0qMB1ZQh
         EsBTXZ78DFq4Zf0PPjUxtq/0f31ryUR24Aq4xBXafSBiJNVwwHUo3rXOobbSmQ4KBI/E
         VoCA6M+OlB+td9OR2OZFwhHAJAjoOiq3YQp7jrzq5+rgsAwAUgkdvneYLSpcCExowRkH
         8LFF6Up43SmQ7rjQGM9Jt1lN4S6E1bqstb28S8eNfnCbKkba9Q8nl2+n4GRFkntRZpju
         dE0nYW6/bykQX4N64b+m74TCFFGju87f2PzxA7/ZMOvNnauRbYrGvogDjtg4FF4qQWKa
         NXPg==
X-Gm-Message-State: AOJu0YxvgolvSOk/++JPcbfhDPIFgEMVp5neL/mplfNcTKTOLTHuxI/v
	28msSh2OqFHoIB+hkSToWyxoK49xih47+NwSdAUyjp7wjM/oPXQIRtPlJQtZRa1FYEGOOdqzk8H
	AuKf6e/3zUN9Dvkal5HN1yC7QhcBgA53q4vBhg1BSfOj1nBtmrV+rtH00eWCm6bdcijoMv636mN
	bTLhwfE9MJHj1t8F/zkNA3ta3giXKUKjeHhHdaa63zePo=
X-Received: by 2002:a05:620a:2a14:b0:7a2:ccd:9672 with SMTP id af79cd13be357-7a7e4e6144fmr67569885a.67.1724705046930;
        Mon, 26 Aug 2024 13:44:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG++rZwRsHPi3LEX2hBpbUb+Bhnwx97nv6F7Fy5QJm5RgQYxXJ7nF8aD8ykhSm+rXvWrvbUzQ==
X-Received: by 2002:a05:620a:2a14:b0:7a2:ccd:9672 with SMTP id af79cd13be357-7a7e4e6144fmr67565885a.67.1724705046455;
        Mon, 26 Aug 2024 13:44:06 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 05/19] mm/gup: Detect huge pfnmap entries in gup-fast
Date: Mon, 26 Aug 2024 16:43:39 -0400
Message-ID: <20240826204353.2228736-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since gup-fast doesn't have the vma reference, teach it to detect such huge
pfnmaps by checking the special bit for pmd/pud too, just like ptes.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index d19884e097fd..a49f67a512ee 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3038,6 +3038,9 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
+	if (pmd_special(orig))
+		return 0;
+
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
@@ -3082,6 +3085,9 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!pud_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
+	if (pud_special(orig))
+		return 0;
+
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-- 
2.45.0


