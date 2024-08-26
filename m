Return-Path: <linux-kernel+bounces-302172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73A95FACE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9432860A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADF19AA56;
	Mon, 26 Aug 2024 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok+baKrA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02F19D89C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705053; cv=none; b=F0UtvGhXay7SiNcZuiauu56MIm0AAjQummIxQgqR8ywmUdkz5q3kit9DOImyYXTWv1UkP4PXijrEveAXmnHB1tXQOCZYyu7gJKwo9AISmE8zIyhf/L2/H1Q89traGsFNpX7pT4IzBJvUw+u8lL3Ewnx9KZqC/RSUStO3MbgJiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705053; c=relaxed/simple;
	bh=0JOvh9d6Ck9MlI1IecLNRwn4z9Son10cjOiVCsL6GIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAXVa5WNFnJgD3NoEMuuVgeQpn+cYQTpmhpT3kKaAIolnxglOjnqkf9M1Sh6IvpyQPKFjbchLGC/tthJAYrkYY1L20Qu0TLb7QsqskEZshiGU1J3R4KBJjLU/CTJdY5O4fCmRmZnnv7vnP3R51p4Efr5uTyDaECS53JUQTN4Kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok+baKrA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaLXo2idJup/Oy4OwRPy2aK364ayUQ63MrUET5wBpvQ=;
	b=Ok+baKrA060QFvLET3CXcxfjMa9U4bQXV/+WOBg70a6njCWetklHda8WaK+bVEfm45SVhf
	rwPME4bnkyNv1Xhsj04LSlUqOc2OOQ5pmMR8LWlvrwmCx/7DRPMTeozMJdjGH1fWvJcp66
	wTuosEhrDM5NpQJxSDwj9W2Tlhylp+Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-8Zm0eE6MPQCIMelgK2W-2w-1; Mon, 26 Aug 2024 16:44:09 -0400
X-MC-Unique: 8Zm0eE6MPQCIMelgK2W-2w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d06f8e78so523628485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705049; x=1725309849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaLXo2idJup/Oy4OwRPy2aK364ayUQ63MrUET5wBpvQ=;
        b=Oc6wxvhdxM+v7MWwBZrhXeAetn42nyQYt2G7fSC+lbP6313xk1y+hz2SM7TNjf+BZy
         +svklbJNu/J6r8fiymYdLPvBhfJW/cklc6m4goKUuDWeTEzev6OZ/7UzQpO/kznbDTw8
         YA35IFUwL1uoz3th3JmT1Rg3IQ1ksosJF4qg1XZEKqvvOcNaV5QZVVCvfsuwxkuu0vbd
         aT4k4BlGvTBuyNEhbIldG7edz9vSsdc8xcs6sgprZ7gFgrMZpKL2g6+8J89EJeXukooe
         byDi7FVVtMwVfDPxmAhiAD4lArb0DYBxPL4DVt5LSDGuJdhrVECAQQB7KOfHUnEckT7j
         W0DA==
X-Gm-Message-State: AOJu0YwcHoLVX8p4bXZYdbwEnEj7f4k4KoUCJnKsntVZA7nsmF7Z5+IE
	+boDuABDalH9vP4GnG1ntsYc5oUHxlPcQC12JQlmMvkdYDPxAWSpu+DatQpIlUEnKkzNYqAUTDm
	atKaraPMYCdbxluLWN6u5r9zRCfVpu0978u4yK3hmOVakTVXSXGUyjSafLHek7ZqhHYArV18XWP
	r2Ms6FQ3QaZJZa8rc1hxER6MLhw9AcAE09Nl/OEiGJa7A=
X-Received: by 2002:a05:620a:4112:b0:7a3:49dc:e6e3 with SMTP id af79cd13be357-7a6897a6f65mr1244453385a.53.1724705048971;
        Mon, 26 Aug 2024 13:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAEqST5igJBEO0jhxDT4OAwN3xGv5rzMyL4N+pVFoujxFDEyZ/hbdQR2zB1kD+DQ4JLF652A==
X-Received: by 2002:a05:620a:4112:b0:7a3:49dc:e6e3 with SMTP id af79cd13be357-7a6897a6f65mr1244449385a.53.1724705048557;
        Mon, 26 Aug 2024 13:44:08 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:07 -0700 (PDT)
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
Subject: [PATCH v2 06/19] mm/pagewalk: Check pfnmap for folio_walk_start()
Date: Mon, 26 Aug 2024 16:43:40 -0400
Message-ID: <20240826204353.2228736-7-peterx@redhat.com>
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

Teach folio_walk_start() to recognize special pmd/pud mappings, and fail
them properly as it means there's no folio backing them.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/pagewalk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index cd79fb3b89e5..12be5222d70e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -753,7 +753,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pudp = pudp;
 		fw->pud = pud;
 
-		if (!pud_present(pud) || pud_devmap(pud)) {
+		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
@@ -783,7 +783,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pmdp = pmdp;
 		fw->pmd = pmd;
 
-		if (pmd_none(pmd)) {
+		if (pmd_none(pmd) || pmd_special(pmd)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pmd_leaf(pmd)) {
-- 
2.45.0


