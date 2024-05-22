Return-Path: <linux-kernel+bounces-185924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78568CBCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44741B219E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5108004A;
	Wed, 22 May 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBJoDPSR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3057FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366457; cv=none; b=mfjS/sJ/uQJgn44m48PstnD4n48IEZBLap6ISNyk9bdbfu2jc7Bybin9SPxNsKYB7KY+bkml7EZ4dRwfFgpZ0aU9u3yPV3iJQqhb/S6JWlraqdrKEsmwXl6T70kwuPMwVD8sgQRNSI4xT3KS8pk1XSatcBei14bFaoxcvDKSaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366457; c=relaxed/simple;
	bh=y3VxHR/Yb4X/Ib/4X02OEJsh/+G/11i5weZ0MaiR8kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOxwdi7+rqsqeSdJ/ZRJUd0EGnmNX+qpkFKFdjelj8tUTGcgPpSacchuM/s9/qxAR+urCTXRlxPpiWbKH5yBVBuUC7gboOqvUCpu7mqj6dEeDpaGkTsIyhlDLSVEnEb/hRo7JvpGVch5/Acb1CBC1hS2XU/S37m7GQHUXqNXMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBJoDPSR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b5897so5032475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366454; x=1716971254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc4M1An1SVE3VhBwugQSFEPj2HdsFrg3eqR9/azRDhc=;
        b=lBJoDPSRb9e739kSTyU/6u8vad3xR/PEW0d8F6W1ciB08wHo3v4xtl9hGW+/kpE+Bx
         +sAM1JvBqs4x8Hr0yGUprMgQwQXRUGfz3LaGIJNyN2ZCKQgoQZkirs3Y260JJxbDNTQg
         h4bWIyBfHO39Hc7Scpr0nlauXgPZKB/pYbe8dag8d1y5g/WwKvj0RocMHj8VFEOzZVci
         luWm+ou21C5ylhssXlclh4Mu5R3I9AvTMRjM8+HgsdhvyL2RW0k5VA6ToZ+tXbqBREp2
         FNIUT2omJNEhvR3vBlgg3IzCHl+G3SqRufsi4NIZ3FZEtMtdzjSN/s9GoysEi0doC0mQ
         jiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366454; x=1716971254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc4M1An1SVE3VhBwugQSFEPj2HdsFrg3eqR9/azRDhc=;
        b=Kt7skqaVmpqzcCaYu5LIznfggMYCwCxgGevKlmdi6LYi8QLWze1G1vHia+KcXYnx3r
         hV7W4R4EQyuda2wLyRkQRv7Jk6DB6yAZOA9MniuS4BM7XqBMerOMPu9lpFrR105GbeOd
         ebiWhGNk9s67KIpJSxqAFIV7DWBtGsa/WopeplDAxfj2w2Y1KPu3dWxqe5DvIHt1A/0R
         JypC3VhjqUf3OAiHcWw6VU8jPd6YB4J0M6uKdoM6shCGKvoKgGv85P5nLswGcl8nkMOu
         0RembiAfQXvHfdLjJSUHrWSJwQKWPqTcFwxWmZDzdfZj4LzQvb7t4X4PzzggsriLrmRu
         sWgg==
X-Forwarded-Encrypted: i=1; AJvYcCXzmbwG2ubmPToE/eksad2bDiYDukx6OKrOtTAfDHBLKkUmMrJGAhGz+zGBUbBhZBeCjIggooosmGIz9zz+7DNXoRQUrNEN8R4j+w19
X-Gm-Message-State: AOJu0YyPI+UNkpLomStWTnBYKoYAqf2V0pM2Vlw59J1GSaca2m+m4nJF
	6st5k+F9lQWCskJHGLexBKxjcFXiluTYp5qXfCXtTM4DEQtwcr7j
X-Google-Smtp-Source: AGHT+IERf8nHrVQJQciNF+/AH93iydxOXg4s7DAjqXpHChiioJxblNiO3nCQrgigc6+DScksJIpPOg==
X-Received: by 2002:a7b:c449:0:b0:420:1db0:53c1 with SMTP id 5b1f17b1804b1-420fd355961mr8286005e9.41.1716366454344;
        Wed, 22 May 2024 01:27:34 -0700 (PDT)
Received: from fedora.iskraemeco.si (84-255-245-182.static.t-2.net. [84.255.245.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm33964495f8f.1.2024.05.22.01.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:27:33 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 3/3] iommufd: Use atomic_long_try_cmpxchg() in incr_user_locked_vm()
Date: Wed, 22 May 2024 10:26:49 +0200
Message-ID: <20240522082729.971123-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522082729.971123-1-ubizjak@gmail.com>
References: <20240522082729.971123-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic_long_try_cmpxchg() instead of
atomic_long_cmpxchg (*ptr, old, new) != old in incr_user_locked_vm().
cmpxchg returns success in ZF flag, so this change saves a compare
after cmpxchg (and related move instruction in front of cmpxchg).

Also, atomic_long_try_cmpxchg() implicitly assigns old *ptr
value to "old" when cmpxchg fails. There is no need to re-read
the value in the loop.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommufd/pages.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 528f356238b3..117f644a0c5b 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -809,13 +809,14 @@ static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
 
 	lock_limit = task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
 		     PAGE_SHIFT;
+
+	cur_pages = atomic_long_read(&pages->source_user->locked_vm);
 	do {
-		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
 		new_pages = cur_pages + npages;
 		if (new_pages > lock_limit)
 			return -ENOMEM;
-	} while (atomic_long_cmpxchg(&pages->source_user->locked_vm, cur_pages,
-				     new_pages) != cur_pages);
+	} while (!atomic_long_try_cmpxchg(&pages->source_user->locked_vm,
+					  &cur_pages, new_pages));
 	return 0;
 }
 
-- 
2.45.1


