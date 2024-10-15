Return-Path: <linux-kernel+bounces-364966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9B99DBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142D31F23866
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93873189503;
	Tue, 15 Oct 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzEpBIyp"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1518872D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956063; cv=none; b=JnrX2dPlyzRsF3wn/+63Rb7Y+GRIYrMkfVcGUH9KhGvm9ay9KbVm1aN92gNiU3uZ0v2ccndPbQ3G2nyn9kg1vVdscpU/jPGN74mt3upQrZCWl6XWX4Z8Kg9XKhRDSQAJ67NAPtyUkpGt6TXl5hZ6f5aR28f/q7jJLiSOuM2t0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956063; c=relaxed/simple;
	bh=v1P4WAxWuvUCZPOP2tMFqMbCJcwChW39Ab67XAl34ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6zobrcF9KFqo6R6wOIB22TamOaMrr/QPti/RP+ZZgQMIRhfrI9X2p/EFma7BWCFohoZMZv0Dlc7HI0I3m2UBHGWsMZM++3XBogipqXeqmg+0p3/iDlSpEva69kl1HUHal6nw3snzOW9W2Sr6EfG95J17fFY48m7u231wNXjIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzEpBIyp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so1815370a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956061; x=1729560861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTnklaF1aF0bTWeWldi91Sj9bwNgHQZw6gVAVQdUYd0=;
        b=AzEpBIyp0OVVMqWO3areVMHpQstvB1+w9BTHtCmXv2Tk2kdan3F2dtaF/3u2uDEgog
         mSI3e4jw0PatwvRN7q2mz/z9bfo4fvIMyFQKktlzsL7jPdB1Yj0Z46IJlEBDlgkJKEf8
         iLs3N0KAUfuK8pcJNxp4LGZNk4YY2qJSFnNrw/GKV/z5tbYOjuNsTrxutHjIB6Fq/0GE
         3VAF9MKF6jKWHc6wONTafZJfa68XmbDyi/gVqfGThaC0nq/7oUfVdlrtxrAKi8QL4Ssu
         yvmIzKtvgfkiFpwy3Bft3ZiIqffr7MOUK1p1ftliOh/vJCeP7dVEJw8GGKAbegr53uJI
         CpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956061; x=1729560861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTnklaF1aF0bTWeWldi91Sj9bwNgHQZw6gVAVQdUYd0=;
        b=ZGEqFMy7Vd4MWoLaSFVgrtqdcCq+Y4nheRb4XeJeHq8pgKPR8+Da7BC4Xs86comfDw
         +/KzmNeCsSrlVUOzBx8MSY4GD6n9sDO3EqzWCQFozlV8vYMtfqOtRx6YopdGxei0QZo+
         FMuwoaAC5d1x+fNZyCGSPW7ITHy9q1aDqWGNmu5+b/qFF5IHSRtxwkzj11YDDTHsanuj
         rI0C2lGFNdnrCyO9D/k1cY8j6QclJDbgusr1Gmw38xgZSKOGLmUe3Iy0/KA4z53V7gHf
         eeaA4SdZMUStqozQVYfz/EtsN4BCD/mfWsOVJ9sKIzVCJPZ4Nq4ZywjBYiv0OAPkNkym
         pGdw==
X-Forwarded-Encrypted: i=1; AJvYcCXgyWW275fWKjAm97RV4ufVl0S9zp2M64KRD17faEmmzMUxlfAyiEqYvC/0oEIBgQAR4PXAkf9Y5qhf9wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zyGrDe/+YWTqMIJd1VU0+DdzSfvJjbNeM4vkeocXO3YqWo9z
	/X0AYmEVvqFQ+VE4Dvxh1vGZogee+5tw9A6RVgXM7sTat4fbOLfB
X-Google-Smtp-Source: AGHT+IFT6UGlq+wYgtgPhE6bzO8Rllrurc9EHvyW/SZWzz7xpV6AjzAWDpsP/H6dyEXrivEMXbEKOw==
X-Received: by 2002:a05:6a20:cfa4:b0:1d2:e92f:2f48 with SMTP id adf61e73a8af0-1d8bcfa7ef1mr19096796637.40.1728956061028;
        Mon, 14 Oct 2024 18:34:21 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC RESEND v2 07/13] book3s64/hash: Refactor hash__kernel_map_pages() function
Date: Tue, 15 Oct 2024 07:03:30 +0530
Message-ID: <efa3cff65f71cf492702e835250667cb976b9e6d.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
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


