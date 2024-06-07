Return-Path: <linux-kernel+bounces-206758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01818900D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80098B233EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A933155317;
	Fri,  7 Jun 2024 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwcFxsFT"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291C155384
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794870; cv=none; b=CY7lKs6rVxoq6n/P8RcM6QD2kVbDRQFpKx0rSkDzq14I5A5lPjxc02CUUp3qFr+VOc3BNnTe6sVMDFC7WDjtFVyf/CLTFu5T6qmn6OxPYvuOtmFy/4s3Sso82ekVfXZhFzhx6puNu01UcJcaMsnccxLOHdbAZMQhx7txD5kn2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794870; c=relaxed/simple;
	bh=JAVkFYMuGScehCz9ExhfnppPuqiO/nTupfV+sN9N3to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSpElVDlCi9hOJIn2T2AP0sRVgfaAG3uPJg6PQL38WZp+uVVNZ4pRgcnRYRrZES/54F6VxSfCOaMvUxZYAmYn5sfuj2IGUwQFgnSX+VvX+xBz5fNZhnPjdRYlCIAaaDNrwpZn1z+e8j5CZgvXJZUTgk2ihp55NI3GKA6whdzzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwcFxsFT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6c7cded01so14782605ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717794869; x=1718399669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWi1D+MWFV3PdLNdsuc+9ZlTB2gIrgKafnL+RRtVsTs=;
        b=YwcFxsFT3WYvoXlhpN/lqw4fEGZaB194CVl4W2Iu2LUXQLvU7uqRSLx0a7pqW3+1NB
         O50ZI91PqOXG+5v61FlxaYHR4FeVrrp2rOUJgoDjAA1ZnN9PJBVmconYAbr8whYes0kk
         825EAE2xQx8qytzVato6Mi7OzMYhEWO7phCHS5nIJJ6Z5s7dnniaIRSrnQSCqHvruBFf
         KFGTpm4gQwW6hnmYLzvnENCsH71cIVrDQLmSQBgr642RXow+UisNwVkWw/KhLCQ3XMqC
         iVQ/N4aZZthUgB7W0NqB7SWAXNcdxw6uQ5wstqpqeTubKoZhJLRDVoBVAZZAg+W+yEPi
         ZZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794869; x=1718399669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWi1D+MWFV3PdLNdsuc+9ZlTB2gIrgKafnL+RRtVsTs=;
        b=Ls3TAnjZFSDFKmx8tEP+R5vryMLXNj5X0ngMyJKX0TlGvgzqGkK00bHNSQuQCKqSpk
         qkwx0aCRdf3qiLHh2qSJPyf13Pmn+KkrA+u5eJIUmNL9TTa017vs1EkITM0TcM5zLMFt
         TPIt0RCrcPnoRgTsC921zIhuik/HaCKUBNMCzowz6Kpif1vIpGgUy9LXIl1hMow/EYU4
         saK0lmRRggaCq+QJ+kXIoiQgAywrHRbDR6Gnk587dMSVQjdJd+3OINaY4WNGW5LdKOiz
         yI8UyzRgKA8a8u/AFPgSwW71VOO91rhIanXUaSeQJZmE52p0wcfFvozEC0GvqgDGLUtM
         8Oig==
X-Forwarded-Encrypted: i=1; AJvYcCW6OTMKBMzbrxHNU7XMRDkvL6zGa/SNaEq+d5kdJ4hccMOyevfc7LwapEc8TXdLWVXjItjaMh6kU0b8hGTgtRxPDs/vFWREI0JoeOWM
X-Gm-Message-State: AOJu0YxRyeIqrT8ghF4fPiv17yJOWxnYYKKpOSuhi+0LqupndsT/9Czs
	Oeih77FhDqryLMiX9y/MFOdenyOFhh7XKGAC0wYXc7Pmk5SQByYNBzV7SQ==
X-Google-Smtp-Source: AGHT+IG6pwtK/hl5JOm7TirT0nRdsgcUjVPOoWYAZpxsEa+99qZaWFnUTQy5hXv8A03dkjib73+KUQ==
X-Received: by 2002:a17:903:234b:b0:1e0:bae4:48f9 with SMTP id d9443c01a7336-1f6d02f3c76mr39672315ad.32.1717794868604;
        Fri, 07 Jun 2024 14:14:28 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d859ea3csm17912255ad.178.2024.06.07.14.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:14:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org
Subject: [PATCH v2 2/2] mm: set pte writable while pte_soft_dirty() is true in do_swap_page()
Date: Sat,  8 Jun 2024 09:13:58 +1200
Message-Id: <20240607211358.4660-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607211358.4660-1-21cnbao@gmail.com>
References: <20240607211358.4660-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch leverages the new pte_needs_soft_dirty_wp() helper to optimize
a scenario where softdirty is enabled, but the softdirty flag has already
been set in do_swap_page(). In this situation, we can use pte_mkwrite
instead of applying write-protection since we don't depend on write
faults.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index db9130488231..a063e489446d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4322,7 +4322,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio_test_ksm(folio) &&
 	    (exclusive || folio_ref_count(folio) == 1)) {
 		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
-		    !vma_soft_dirty_enabled(vma)) {
+		    !pte_needs_soft_dirty_wp(vma, pte)) {
 			pte = pte_mkwrite(pte, vma);
 			if (vmf->flags & FAULT_FLAG_WRITE) {
 				pte = pte_mkdirty(pte);
-- 
2.34.1


