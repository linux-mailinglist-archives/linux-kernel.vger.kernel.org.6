Return-Path: <linux-kernel+bounces-281197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894594D43B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFB1C20FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07AA1990BB;
	Fri,  9 Aug 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhOt2C/k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE9199EA4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219771; cv=none; b=g0lQZDWF8tKG+M/U44AffyeIUyZworpFWF7W1DfjSpP7Ekhvz74jms87aFysFWInIz/q9oS2b3N2iwfAWOrg6I8oyDfn++2CFaL9UivdZtnFvIDxycLfPQut6nBYC+kkq97MN54pxZ2tyDoXadT6YhWpsK+l5tAhX9nzoLRFA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219771; c=relaxed/simple;
	bh=C1EqeOtQk0O3VuTVuRQD9+bF0J9qW0lfyAutjUQ5RI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KknRFRTnsIKKt/4HPKm+0vfhPxS368mORNZOs7YN3Xij7jY/ZZjLbJyowyJdT/3pY1Tpf0tENy1TogcSkegZDDoEYFix85hCD4nP9QD+boimMWVGHAUVYcFUPTr7aY2+O52vMEyVs6Xq7qzRirHm8eg0xfCRY0QnSoRRsBYiZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhOt2C/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfMsI243pXvbDIYk3LIHdKnZKRp0h0WHhTX8nwPWLTI=;
	b=fhOt2C/kDc2vQKgH9lKXJdsngXv26o7mgfmoR2F5ykfJahMUN2OwY1B2eUeOuGa+n1Lcke
	CBOdn11IJduxCIwgLdhFcjQxMXfUixL3SUxZbrDQrh3yzcGQd5Y3RqKLgfjUdzLQRvenIc
	D9Oh7Umw3EHsTUs19YXwxCTrRbCu2k0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-qPVrE7vJO_ueHRk3ujqt3A-1; Fri, 09 Aug 2024 12:09:27 -0400
X-MC-Unique: qPVrE7vJO_ueHRk3ujqt3A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44fe28cd027so3757781cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219767; x=1723824567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfMsI243pXvbDIYk3LIHdKnZKRp0h0WHhTX8nwPWLTI=;
        b=MVb8e9HEMTOnsv/kQrKts8J9BCX475a0wn9qnMD/Ed/4vkGDfzBcMIjkF3+PlK8GZL
         XAOtE105dr6azwblq/EFd/p19nyUImdvFXe2ZnRX/BsmmAaFJ/9Q6IzkjVMEbxvi95ff
         rqLCyMhbBJERWKQjGaA+O0xra7lIFqJUdpdnbE98tkwp0vb12c1ZA0QrMBssjaEsbHtu
         DmTxMaXnz/4ondCbqcy3EVEqkeXNUHnuIrwhoFVO/7g9e1gn/gvenfwON9w85PcezlKH
         wSV7iCX0+77cWCPHYD276+SjWqnxM300+swxmHpvAN6rx5GdRfiBEg0l73Gv3BBCFBdq
         ETXg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Jc+MU4RyV1JPKmrB/xvAtjVj3WExBcoySnMRETNP+XczOArgnN4PaLu45RpJbje+zV9ZcMATX2TymL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJMPD4BOBU7AlNvCa1UJ9cUUGLGJHSS3rNzGSQAqB/Ru6efCq
	pyFAlssqNvFOF/x8bn9CJqBCCN0iAw9DBi+uIuDgOyMFLtCwpYFEgQI4qIDT3n22KtBRuKeSSog
	vL2fe0kwJ8h49fAVDOEPUaI/VRPMrp9g4efTa01Osy5WzW1eiJBY8j/kCSppT9g==
X-Received: by 2002:ac8:59cc:0:b0:44f:c953:290d with SMTP id d75a77b69052e-4531251d17bmr12885981cf.2.1723219766846;
        Fri, 09 Aug 2024 09:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkbLJ8q6bD88BtBGZOYKdaksYNPrmA3JWwjtOEQ9+GQ5ZX+OpUCG/V8WuVaLDdrJFvk6CQQ==
X-Received: by 2002:ac8:59cc:0:b0:44f:c953:290d with SMTP id d75a77b69052e-4531251d17bmr12885751cf.2.1723219766412;
        Fri, 09 Aug 2024 09:09:26 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 05/19] mm/gup: Detect huge pfnmap entries in gup-fast
Date: Fri,  9 Aug 2024 12:08:55 -0400
Message-ID: <20240809160909.1023470-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since gup-fast doesn't have the vma reference, teach it to detect such huge
pfnmaps by checking the special bit for pmd/pud too, just like ptes.

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


