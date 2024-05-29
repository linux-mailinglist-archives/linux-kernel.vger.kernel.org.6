Return-Path: <linux-kernel+bounces-193749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9D8D3178
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6221F22888
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04236178364;
	Wed, 29 May 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPspe4G2"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE810169AF7
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971364; cv=none; b=klCPRMlHUPHOI3LK8Q9q1K8eeWbcGotfee9zVdXHoebQrqNrRmqfN0X7seq6Pt2gnkhxoYKvReF1840FsaCIuZrRue2FrcufqNyDLQN7C8EUf6Bxe5QA8HAUlW4XPqtSU7Eum0X4SsUGiqtPQ/VxTt5lCMuLLOsEqHqqchFML8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971364; c=relaxed/simple;
	bh=j9hjI2tH8Wq5eZsp/WXoSuOZGb8/J9q79Mq4cff2Ewc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGM6jOaO0Cs7RzIMPJISbEfH8B/vi+r3S6H9OFLHzMaIoPYVetCwy27jXc6e5ZE3geXXapxYslaCLSKdmA4MC/14TIIr0CjtZ2cfDZTEly8do0w5pzycvPmChHEO953qp7EOot1arTC4DDuvof6I5QTOj2MChlzA900bpjSDfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPspe4G2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8e9522bfaso952157a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716971362; x=1717576162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+4WZx2jk6Uy8Ser1SPRLQ9xpkk5S7WupCS1+ZFnTlU=;
        b=XPspe4G20Iq9otcVmNw1z1XHwfUktIcjjgXVeR50UL1f+a5d72vl6RHg+vaiUXxXXa
         AF17+VRdKm+WFdrOXSkr8UMzBNZWTGNQz6fS4FV/ZROBkD5oh+kbABJ9EZxl1OgNKjvD
         6QZqTMG52zQQYK5DYfWsCXXQ9k8nONUpC0a6yXWejXOWSU2T81Uio7aQkywa5Gxl0Vv+
         fK1AH1ZnXHpRTmFfepZG42473ntbu5CtK8jL6tHtO/3TBeE7/r8ci/ltm70gNLNgZ6sm
         npF8UzIrIAqdDyEgq9Zxxs9q9siQllxPYEx4tFzQ5ugbdfIY6oUE9pwygkqKA+jo6is4
         hYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971362; x=1717576162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+4WZx2jk6Uy8Ser1SPRLQ9xpkk5S7WupCS1+ZFnTlU=;
        b=VClt+4Empgl84FirBCd2mD/genKP9GO7+b/5HyexsruagMYmUdbCwTK6wkC/4CG/93
         m1x6HM12VO+poydST5xs5KcZt1IGesHrEda7JjelzYXsbA9VHpaZd5qZxiw4jgjT5iLO
         N875Vby3IliRr4vK4rowhlO0bt74e9m1HbQ74f/FEJPZKAFXeObLuP39/ryvMDUDHxC7
         vgrVYwpkQQnJ2qK0wFuP9iz/3IRxAbjPdYiZL8SAYucxJiEstTfb4izZvVCMnnDpijUv
         OWvYsGSJBCC416xNAUgeoaS96xKdnyh2aj0KC9S2N3DOyaFutV5t1jKXcXYSgJDTs5J0
         OOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2pfzFhX3d4dCoOqeUcvZ4EFf1+qw+quzqXH+e/tk4kPQz71zsLHkfGsPc8PA2HtiVtZMJG5SLgMS/W5PTEFFiRbBe0l28wGHEcA7P
X-Gm-Message-State: AOJu0Yz1gaS81uVLUp09jmZyTotZ83uidHcevDokzViHNWurNdE0fvGm
	M0nnm65I5zcIoptTvkANlN6DxFyj1RVI1QjE6ueSce1xADpa7zhb
X-Google-Smtp-Source: AGHT+IHGb+sXIn68+MgGWVaSAFwEZ1WhY2usjFaXYWxY+vdoWKkWciGEogVMz08VfHXPwQpQdXzQOQ==
X-Received: by 2002:a05:6870:d6a2:b0:24f:e000:a6f8 with SMTP id 586e51a60fabf-24fe000ac34mr13014665fac.41.1716971361783;
        Wed, 29 May 2024 01:29:21 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702220d948bsm174916b3a.131.2024.05.29.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:29:21 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v5 5/6] mm: swap: make should_try_to_free_swap() support large-folio
Date: Wed, 29 May 2024 20:28:23 +1200
Message-Id: <20240529082824.150954-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529082824.150954-1-21cnbao@gmail.com>
References: <20240529082824.150954-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

The function should_try_to_free_swap() operates under the assumption
that swap-in always occurs at the normal page granularity,
i.e., folio_nr_pages() = 1. However, in reality, for large folios,
add_to_swap_cache() will invoke folio_ref_add(folio, nr).  To accommodate
large folio swap-in, this patch eliminates this assumption.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c0c6de31a313..10719e5afecb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3925,7 +3925,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


