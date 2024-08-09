Return-Path: <linux-kernel+bounces-281195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7294D438
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADAF1C21C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C91991AB;
	Fri,  9 Aug 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5kpMRo0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870519925D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219767; cv=none; b=HXsR/NKvojOUHpcENrZ6ns4TtcAJzAYxt/wHX44MqH+FUnS4ldD15d2gCjWcgx/C6k/eEdv+7dlIKAOfZj8JZ2xeEEZxoxaFoyiJmlHjJlAzSotk4cG9W1sGC2TudBkrFgu/iAhfo/LfMhz7niygJrlugjRoPjTcGg2AEnbQYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219767; c=relaxed/simple;
	bh=c/Kt4iwzwH+bi+XcBBAmrHfE490XylwYWMNetRWl84M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFA7HmHCDJfTu7zobqo1BCZMgH99vdqNF3DjU9vsIJOZMA1TGLTRKJyvo/6/SCzwzAHM1Al2mcIbEUs38fZrhcD95n050bFlQn1EBLikxR23BKX442hoiaJPjayCoFHA+YFK7WVb88ieFOFExzLWmiS9V7gFZy783pf0zkRi2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5kpMRo0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOevS25kl1+p5C9bnayjnL4IWCIfturozNfzs94vCz8=;
	b=M5kpMRo0Rdd21FMhOZJAztsVrfWWrio51el/mpVaUTF5sXn11R8bu7jedQzWMbWfi5Qroo
	3ddB4eDQs7b7EUT51lxSt/QkaUPZk81wSLyAXoSEswTXovQY/k6/s69kDgwY/Oh2zLEObN
	XQxiNDfc1cr/nMkjY0VjVqjnLi4jjLg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-wOpkp4MlPrikdVATgDeESA-1; Fri, 09 Aug 2024 12:09:23 -0400
X-MC-Unique: wOpkp4MlPrikdVATgDeESA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7678caf7dso6678736d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219762; x=1723824562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOevS25kl1+p5C9bnayjnL4IWCIfturozNfzs94vCz8=;
        b=Lfy3ES5ZyTqBETdGtFUGqhTpQDcIEg/AvhFoOv8771adr5ZN+gTRBiah+MBtIEAe3P
         Qs5BLzXMFJEoXdoaBCdUa3Nr24LJWvXYwvieYDCtRh8QSwMQz+HLvpPimD/+z9za1WQJ
         K+MVlkogDEsZtlTa+29oxqutTqaK70KlPArejJiKlDbdWyZDu+0AOyVWg9XaVkvFU5xQ
         etE5EZyS4PxArLR7YqROpLoi3C3KhixrMDGXEyRKkjzR8jqNh2TQw1ICK8J/u9PEFDAp
         WeIVH2/cwQk9AT7jGGKbRa+1+KDEkWU+7Hxk1QsODDymId4vXMptvlfAWp0gh9sdCZEp
         Tk8w==
X-Forwarded-Encrypted: i=1; AJvYcCXh2kbnrtgShLfEp/mX1pdXdmVAe0MWqon6WgOpT8kYx3nsUd/qb7mAyR2hFDZeve1gWpGERsNq+BHTIp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Gw86ZfXavlrEhC4cLZ9P9xATO36JK915V10xGVTPXbC/Xd2g
	zy8GX/fCcxOnRUzoJTMuCVCHX70bBUP+NfXRu0j0GAQqWKsudhdq9hV4rbFgVQTOfZ8MnZ9gEG/
	btjwP82XHdsQlixgm+emzaBMQNEaKk+Y+g78uSENLxr/m5k6uK+f/zVjsi6TDYMN0OXekXNi5
X-Received: by 2002:a05:622a:1a8b:b0:44f:89e3:d119 with SMTP id d75a77b69052e-453126babcemr11885501cf.12.1723219761625;
        Fri, 09 Aug 2024 09:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHUujWoHeQHvUCs2OAJSjyQdbxlWd9FX1yi8fb3RZKwv0O5abV6g6G64GeuNGe2uyjoJD48A==
X-Received: by 2002:a05:622a:1a8b:b0:44f:89e3:d119 with SMTP id d75a77b69052e-453126babcemr11885331cf.12.1723219761262;
        Fri, 09 Aug 2024 09:09:21 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:20 -0700 (PDT)
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
Subject: [PATCH 03/19] mm: Mark special bits for huge pfn mappings when inject
Date: Fri,  9 Aug 2024 12:08:53 -0400
Message-ID: <20240809160909.1023470-4-peterx@redhat.com>
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

We need these special bits to be around to enable gup-fast on pfnmaps.
Mark properly for !devmap case, reflecting that there's no page struct
backing the entry.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 39c401a62e87..e95b3a468aee 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1162,6 +1162,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
+	else
+		entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1258,6 +1260,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
+	else
+		entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
-- 
2.45.0


