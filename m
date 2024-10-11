Return-Path: <linux-kernel+bounces-361341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788699A703
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B7E28476C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F6183CA5;
	Fri, 11 Oct 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDkYX37F"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B32405FB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658583; cv=none; b=t1UqeGL9dXU3AyLo3Fhy59hZdRigpEa/sM4dySDjuMfqpLxqUDhsD/tLEH+r7y3S4Oz9c0aisRaMBj14vOf0qv15miSQ4JvvRc8uP/Z1rh7SgHqi+SOlFfn8b9JkCNKU/k0iC9aEx9vP7gYxfprRs97FcNye2O/tAFNu/ZrF5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658583; c=relaxed/simple;
	bh=Gp0dRdcDw/2Hws/klO3z/53EQmGE70/7EXAiIMjd2wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpqVC+s9RCrOAZoGQqohvQ5moeGJ3jGn36u8quQgEGQSwkrjOHvqkV63HM0JrVMqr0DiHoM7ZayuwD2CA6HL8rHUPNYaY/BvVTvrso4/LAPiMcAhlHg52eGiXWg72SmtUN4KeUncIfzaDDq1N7usYCuiihfYhAWC/TOT4c3LqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDkYX37F; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71df67c6881so1848394b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658581; x=1729263381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nF9Cu1yFnAPbe7jbcVtURgq11ehq1BMyC9tPOtmnXf4=;
        b=PDkYX37FesA7T5UFKJrg/mRVEdbkeXm52drVZcfK5KYQd0q28wh8P5tRVARB8b87kd
         umoGzb4BVlHds7j97WhmMhgNHM15BM/L4Ja36IJBjPxUP0b0ReYtYPbE555ZZUaeDDdK
         Dy/BPoM5S8xQayUrlvK13FxUhjnGyZCplb1Udtkt7xPE4ce0dElhHaWF6w2xDLUlpNHS
         VDeCcVuB58+Wg4Nd1pX+Alu64dtE1FbCaB7sA99HaVfM9eIYlcoh5GCLMd95M2XztPff
         +2XkX2++13F/6ZYiddab0KfJWEShzFLV6VYgI8/P4xRUwWMT/1MszodV18xVgVIoj+N7
         Oohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658581; x=1729263381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nF9Cu1yFnAPbe7jbcVtURgq11ehq1BMyC9tPOtmnXf4=;
        b=R765AGaphVvTJ/6AI3kq5B5QX9/HnViUHLt5xj7/pqUV6jTuZHjEzpg1VzynYOm0GM
         tYfTjpbJRwRj4ndIVZWMHXv0Q8OVRVoagvAoK1ZYtpIJzbLAbhoaXbMNqVwYK/cQdcWD
         Y2Qxw+AhREZ3epAqIYGTyHu7/p/8IH8Q9TbXg/2cz1SVYnJ4dIecFO+6NtrL3iDNpzEA
         zKV8fv/l/LentTmb3zAH9ysdnbLt/TmsmbfRiFirJN9WFRi+rx+MRorzn2PsTDck1lf0
         P3P1VMoSKxFFbQ8lXeHuI5zAsL2YcqSnNESx4iKoxnlt7+L6PgShBlCowOviU+9m/37L
         YX3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtKazlh2ihSYvculqRcK3EjfjdRzdZ9wQ43sbloGxl+BIdRn+tpaZOq2SznvlQNyhlfO+cvPCkxPqm/8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVIEeWI/359WyroiIfju4O4HC2kQQ/umUMpNBTN5YsvDwddpf/
	h+xuDmlUaD3q1cWqtyQ6RR4XTRhffSazJDh4qLryJ0xwfUj4X6Vb
X-Google-Smtp-Source: AGHT+IEXGk4fmDBJI2QlMnEoAr5L68GZy2LrPDTs+tXSqId4T0CHY5gRz/s/XHjy78yvizjoCrCv3w==
X-Received: by 2002:a05:6a00:1954:b0:71e:13ac:d835 with SMTP id d2e1a72fcca58-71e37e4ff69mr5482147b3a.11.1728658581305;
        Fri, 11 Oct 2024 07:56:21 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e979bsm2674320b3a.2.2024.10.11.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:56:20 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org,
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
Subject: [RFC v3 -next] cma: Enforce non-zero pageblock_order during cma_init_reserved_mem()
Date: Fri, 11 Oct 2024 20:26:09 +0530
Message-ID: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
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

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
v2 -> v3: Separated the series into 2 as discussed in v2.
[v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/

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


