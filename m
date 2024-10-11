Return-Path: <linux-kernel+bounces-360656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4D999DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D799028699D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339F209F2D;
	Fri, 11 Oct 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6epu6QN"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019E209F36
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631412; cv=none; b=IOJmmDxeT7wq/cxG6YshHPvaBzJ/sVe7A1fUJZTgz7/WvpvBCsrf8mznvL4feLO++21o4OLzdnGlzQyo/rp41iQpkOQqaxYo+BAbs2ZLx0pO9LCuclz7Yv00O6mkiJPs/CBp6CmXGWBBsb3ePTNaW4wU/Mp2sMMmjOg5FG4mLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631412; c=relaxed/simple;
	bh=Tjq7WHo4wiY9BUcZ7Wk9jSRfZDh6UkNJTT78Q2v49Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUJ9WuiAqKzir7HlfO2FAGmqrbLMXuwKc7KLNxrFVKZPRUho1xuuXVbiTIwdJoBMNkqTLzGSxmcmAb6VRk13UdYPEd8pDh+q4blR55HkSL1WF1F6sAiavEo61ema7O2Jkra9BAJGrvg8cJejAMm4cRRPkiNJoPDSA4dgYrbNC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6epu6QN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca7fc4484so1461175ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728631411; x=1729236211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFXU0lQKXMNLX0e10iqDZMzQn21Hy9EUBSVtGclHKC0=;
        b=T6epu6QNeycaPo3BDZuRGyXyEXGJ1J4PUFplv45JUAXKrlky9k/Pkv8TwuzhZ8CnLD
         GRUhOFHMM998lyOvAqg8l898Ncdjpr6jgZSo0kSZRJ5rqtTKL+UBF2R38u7rZa30V2On
         RoTHh2h9YwTUXcX+lmxds0XOVcc06MfURS9L/5tohoSMTMsfLYqzeOw0BJyJ0Bjp9qQR
         1MubkTdDeAANST4i+VMugbalzhup7pilVr/DYHpgBPMnw1k51Fhu1osEhzTUHgxwsWf/
         41De4iFHs5E5sJdRU7VERKtwsszbaT96Cj43XZmW/Acq0VdodQjV/5wp81pNG4v5fZ/G
         Uysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631411; x=1729236211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFXU0lQKXMNLX0e10iqDZMzQn21Hy9EUBSVtGclHKC0=;
        b=E7eZyureu+I5PqbgJ6qAsVr3m/liz7aEBHChtJZyqjUl6INCqmGbfK4ZCyxWprbwEY
         cXqwzsWtaWosN/qAN68BlJrhlaUcMzKsjnsHkWQZglq0Fa1wcc1+hySOc6y7SVX8YY2Y
         y0kDGDnWzmrYoQtoYFcSvsGQOv2jZfuD+sk3nifjIpsQhSifBvom7Z91LVy+AuvAlC/+
         mb56O3CfCpd1gxfMUiGhLpeFZVOt7oT+wZfrHZiLyMsxkx9k+W26jONk8v1Dx70jYi3W
         bW/Cd1OaQWCLzi8yJMk3BxdYRIiVpUIpvSF90u3ENba7FVHmtqmgF2SMDQ/lxusms+wu
         uMCg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVIrkoZSerwTbShyajppmpFrqsqFMDzyeHag3Q9K3HqwnaVGqzA3S04AfzT0SgtV3dQe7rVfc/SOcCQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNiDRcShFWBh2xooBqTbanoEfk39F23LJjusuC1mqW3LP22Bs
	pELGcBgR577qhDdVFy2OtYEa+Y1gCdubBmWZWqoyYP6kF9CTkWTG
X-Google-Smtp-Source: AGHT+IGQ8iq1sir1NebxPCSK/DS4CJ2zGOXIXoa+HRwjhD+gjsmYWNAElhY1mGxdYNMN7u4TdJpehw==
X-Received: by 2002:a17:902:d2c8:b0:206:96bf:b0cf with SMTP id d9443c01a7336-20ca1315240mr25369385ad.0.1728631410877;
        Fri, 11 Oct 2024 00:23:30 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad335dsm18825155ad.50.2024.10.11.00.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:23:30 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 1/4] cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
Date: Fri, 11 Oct 2024 12:53:09 +0530
Message-ID: <8579f887412720bd6f2fbce513c1c9904772ead4.1728585512.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728585512.git.ritesh.list@gmail.com>
References: <cover.1728585512.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cma_init_reserved_mem() checks base and size alignment with
CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
early boot when pageblock_order is 0. That means if base and size does
not have pageblock_order alignment, it can cause functional failures
during cma activate area.

So let's enforce pageblock_order to be non-zero during
cma_init_reserved_mem().

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 mm/cma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..36d753e7a0bf 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -182,6 +182,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
+	/*
+	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
+	 * needs pageblock_order to be initialized. Let's enforce it.
+	 */
+	if (!pageblock_order) {
+		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
+		return -EINVAL;
+	}
+
 	/* ensure minimal alignment required by mm core */
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
-- 
2.46.0


