Return-Path: <linux-kernel+bounces-333062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6097C303
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03B01C214B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03F18C3B;
	Thu, 19 Sep 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh6HqwvB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D9225A8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714621; cv=none; b=ZYnNsi4UcipVlFDmNbPcd+ZGFh18F+Nv61cYpK7oWoE1x/ue05giLYvqYdy1VKPRCqlOSUykNUKA0tn27QQvkpLVX+6+T8xBH9NwZsljTwPJVnN4KYSh0vUfIDoKnNSCzgSn9v6xKyhPTJwQlinGu0oTdpchk5Kfdj6XXJI1VNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714621; c=relaxed/simple;
	bh=v1P4WAxWuvUCZPOP2tMFqMbCJcwChW39Ab67XAl34ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+4LadwEacGzeFSd2PHjeOR9jnI5vDxvP1BLWKNZvjfnxFgXj9qV//ChsZMKvZyaLfIPwkelB6JH+mhFvI359KlIlqgvQjTXeu2tvt/h8xWwGfKQQkBzIrniR//cxs3qP+l/6DH3RMJ2XOGXDdMVwL+iMDcWFxyDC7KeMSmlsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh6HqwvB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2053a0bd0a6so4300265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714619; x=1727319419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTnklaF1aF0bTWeWldi91Sj9bwNgHQZw6gVAVQdUYd0=;
        b=Qh6HqwvB7nppCsdGIvvXgSX3WaSOwATmHkNKdEkcYviCyNS5J8/0v09IS5HH1Xin86
         4Y16U7Ad3SXwbX05OWPKdpEKduLsFksBdD0j0fMuRICtVfr9r37tydUpSydH6JnB8JR7
         Tf8tCHCBOyOTBKnR6VYa3UHIPA9xXnSg9lGu0/38tc5x5mb4BxOhcE576yXx0wUr1gY8
         ly9BcLUb/GTrwkASVAvRgGKE9g6lUltcKDuWFI9u+fJJwJ1hRRa9LaI0w4h/2M1CsRRg
         a+ZnIy3wuxSuYmXCABz/ztm1ikdHS5X/wDE9BEMp3P/Mx8lOVF4s9JHF+kH8vP4faSTv
         EGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714620; x=1727319420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTnklaF1aF0bTWeWldi91Sj9bwNgHQZw6gVAVQdUYd0=;
        b=fFBJYiOi3ke6J65eGShn+i4ujJcka7lgQhTslGIMGFpALYvKFBHM0tWru9kVyTh4Me
         FQfD9fi7EMBLmxFUKTBA4QJr2rSK0ZAiXDWnBIXIEvynJ0kpVNl8FpTn4jM/KbH3o5vw
         5IHhQSdec4WLvmxiKaJ9XiOF++ZLxZ5diiYzpIMKtmps6z0hceD8BYfNPBGz8DDKVSVW
         MNw6tix4unQn9u+1omwanGdEl3o3plmbZRyU0vF9jVuF24GdDq6bNxw6d+FFVAMIsC6C
         oOLFJyWL1aTjIUJ5dk9lsZnPxcb+/kIBqiKiw+CDRGSWPtQXOXH6wJskIWov5bRnb7wc
         aQjA==
X-Forwarded-Encrypted: i=1; AJvYcCUeMNcpfM9aw0flWeMYdcXTjYhl95tNNJlSTsGfs+kyyUFbvXe2x6pESk3dQnpqzsKx0WZEfkWMV462m0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjMyf6vJTYdTuCI0raqjb7wqkeCvE/wyo7/lvxxPM3akiZrIQ
	N4leBD+A+b6VPoCfzhRBNKOmo8z9inLqXNHfB2hsbkZuyA6ckysG
X-Google-Smtp-Source: AGHT+IFXJApA5WgaqQlHFHHFqKDy2nOzFXTEZu7K9vwx9KzKHpaYLGI4OiWl2mQQHdfyZu/PNzppfQ==
X-Received: by 2002:a17:903:2445:b0:205:7574:3b79 with SMTP id d9443c01a7336-2076e3622b7mr412645275ad.25.1726714619622;
        Wed, 18 Sep 2024 19:56:59 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:56:59 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 07/13] book3s64/hash: Refactor hash__kernel_map_pages() function
Date: Thu, 19 Sep 2024 08:26:05 +0530
Message-ID: <0ced93c215459479ae70dd9bbe00daa595f9aff0.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactors hash__kernel_map_pages() function to call
hash_debug_pagealloc_map_pages(). This will come useful when we will add
kfence support.

No functionality changes in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 030c120d1399..da9b089c8e8b 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -349,7 +349,8 @@ static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
 		linear_map_hash_slots[paddr >> PAGE_SHIFT] = slot | 0x80;
 }
 
-int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+static int hash_debug_pagealloc_map_pages(struct page *page, int numpages,
+					  int enable)
 {
 	unsigned long flags, vaddr, lmi;
 	int i;
@@ -368,6 +369,12 @@ int hash__kernel_map_pages(struct page *page, int numpages, int enable)
 	local_irq_restore(flags);
 	return 0;
 }
+
+int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	return hash_debug_pagealloc_map_pages(page, numpages, enable);
+}
+
 #else /* CONFIG_DEBUG_PAGEALLOC */
 int hash__kernel_map_pages(struct page *page, int numpages,
 					 int enable)
-- 
2.46.0


