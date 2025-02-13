Return-Path: <linux-kernel+bounces-514035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB0A3518D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386AC16D107
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE6280A47;
	Thu, 13 Feb 2025 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJQuURRM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA7280A39
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486850; cv=none; b=pzOpPt7seouDURvDSM16vewA4q0zpo9Qa+4bmH8aPzqR9lSoEcBKyzL0wmutaghb3ZlkqkzUEBVJRyLzYRmh8BeptILw45ZkEXxC6pGcZ+JoRCVlRZu9jFjeeKy4lGx0u6ZG2DR7ARPWHECnRP1bI4t183zN2z3BkeOV6WXeyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486850; c=relaxed/simple;
	bh=I5W26NtkIfZ7r+KXGjsOlCoBqVfLd6FA3hx3qLn7yhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbd/E+Wor1AKHrLy+frd7Yyde0MMsB8LQvqGPUQ0np53YrOkIxzGMhHAk310Pcm322mW0Jo5AUvou1GOZ57GIZQiJdXCJWDSQvMQzs+bIwNVLQ5dwX/Opnuz7FFaHvEWSfATNwBDvLg+fRac1tWHwhOw2HmyBKTFNLivzlSeqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJQuURRM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d6018858so19090025ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486848; x=1740091648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVzZ14hy4ikDmyPBi6h+538M/HP0SirBYvfDsPDJpOs=;
        b=iJQuURRM+eNGzJd4EMe8to1zSDgOIKMLe4XBPTLiocchArGn1vBGsmEbDq2d6sAVsU
         KCThFXpfb5LGwPbt5d6UAGBfgWRy5IKm3RqGEW/PETu0DMgoQYL4E2Zvx5TfFCNgmk1Z
         gQbn2lMNbuSmOIIHiONmKVXMz8/7y3+xNkWfDwHxorDnakT56fbO6fKTUcSz1hkV2ySe
         jgiwGC4Y9MMuZB9meJkBoz2XKkvXejZiR8aEu9uVHOpEHgLhdU1lNAavkBDS1WyxKSbE
         PHyJHJVBCYRNU31Ymlq8GrWHrodmJoG3stgtFtBQ9pP82JEHvDb2RabMg6raDsfQXoib
         /lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486848; x=1740091648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVzZ14hy4ikDmyPBi6h+538M/HP0SirBYvfDsPDJpOs=;
        b=U3dUuv4E3xk71CRPDtGmWNTn5zJfuZNckczVLFdrEBCP8DrWphMbXAPLz7FaEJzPMq
         UD/P9fia/DrltVYbhQ6+xSsxRMzJNJEKWALIDGz1ZDAWsnkRYxG1TTFGe1v6aECedMRX
         5Bm+zx6ypIWVdIU/MJgOPUObp4JHk/twAsdStQlMio+JGJggNs4blK1hLdVaS8JKCRP1
         qcsGNFOm2hcYzYc7IBVU+f8xK31RBL0V+03zhQH56guMGOODgfCCzXCqQa9mq08e0/QW
         JAq/gmcUwb80zv+iSrHq3B0E9iycT80OtJL7JJZNzRs4dx+8BfUFe3MIDw2b0MHh3EdW
         U77A==
X-Forwarded-Encrypted: i=1; AJvYcCUjHqg1f3fZKdg1j6P8r8tyj4wewel2vAslDCsxzS7oJoqb0vpd4YkketU9HBYOqUz0LN1GxpOJas3pjBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmIPtiaW3IKYpkWo+MmwLXxBWNRQClbdlIKIWvonJU3o6nRnB
	+UBoXryHgb3ftEq2p3ixPAVi1nQoMg2zl3uDc5FqhjyrkkmD5uHbMIUONosZeKrmyYihHIQEwzX
	BUg==
X-Google-Smtp-Source: AGHT+IGwKOeZSc6Bvv2juhw3MUD/Tqd1UKmaxd3x+03s9Ch1BsTNeSistfaqs0trat+JLYOevAMQcp8yyOk=
X-Received: from plhj11.prod.google.com ([2002:a17:903:24b:b0:220:d668:ff81])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cf:b0:215:a04a:89d5
 with SMTP id d9443c01a7336-220d1eb5718mr75972105ad.2.1739486847961; Thu, 13
 Feb 2025 14:47:27 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:51 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-15-surenb@google.com>
Subject: [PATCH v10 14/18] mm/debug: print vm_refcnt state when dumping the vma
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vm_refcnt encodes a number of useful states:
- whether vma is attached or detached
- the number of current vma readers
- presence of a vma writer
Let's include it in the vma dump.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes since v9 [1]:
- Minimized duplicate code, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-14-surenb@google.com/

 mm/debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/debug.c b/mm/debug.c
index e1282b85a877..2d1bd67d957b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -181,11 +181,17 @@ void dump_vma(const struct vm_area_struct *vma)
 	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
+#ifdef CONFIG_PER_VMA_LOCK
+		"refcnt %x\n"
+#endif
 		"flags: %#lx(%pGv)\n",
 		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
+#ifdef CONFIG_PER_VMA_LOCK
+		refcount_read(&vma->vm_refcnt),
+#endif
 		vma->vm_flags, &vma->vm_flags);
 }
 EXPORT_SYMBOL(dump_vma);
-- 
2.48.1.601.g30ceb7b040-goog


