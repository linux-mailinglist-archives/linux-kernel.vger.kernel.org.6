Return-Path: <linux-kernel+bounces-448007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEC9F39C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2F16CFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ABD20C48D;
	Mon, 16 Dec 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZphh87y"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703920C47B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377088; cv=none; b=NHjkjhBexyFYiQIQfO4okE7KdwfP534CuWA6qu7QpYrbcR/wQZjLzmD0qPMTXdjEX++vaq2zcaULMhYIniimiJMo2Kmte1Pu90iPeU7QPCJjupOsL11DQiizjRC4H/0C07SM4nciSopZqtyNiTq1rKT7bDwmBnkY2HGUvp4UCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377088; c=relaxed/simple;
	bh=J9clzO1R9BBoWjQqCVEG6ERIeffoUB+RtDJCkEdVkoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbo2vC2xJl16aelOP3eYvX0YT9j5a2flUsANfnUjn/SW4BvOKD4JdoeMmGF4V3VTzKDFZqSoxVWst0fKEURBzZhgTGFVhr61rV/2Vrbycd99vlpDZyVsevINRKnlLjO2ep5SmrG0GJcRhWJwS87IZ702EO2fVIQsVbkMYBBNTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oZphh87y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725c882576aso3306929b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377086; x=1734981886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nohm0qlZ+D54asZWR+C7SIZfQAywm7JDUn18lM86DfI=;
        b=oZphh87yVjS2yDxJxJ5dwdmfMXTOmuXQL7CldbpyJ0T46KDEi5DU+MaqRbjcf+sNdU
         Z/0/ai0s8vBjLIiaOVWt4BOLD0JpBhmdTgZu/Dv5yFcJYKjaJp2rxsyMyYlj0h1RrHWV
         378mxJczgUisW0KXoxyBKxa47JjGKYRp6WUUN2+4Im7Qp1r/8sH9Gnlo4qbjbrVfDmTy
         a0ONP2Hsug16sKoUCkr4hHiRFE2u2KNCh35ekG1F+paeNKD7kML5vWj8sklds9EtUQGi
         SMnpTRhdCs5fTd985dQt018OcAy4bOBuVUEcLunDRsa8hddYeg4oeGLU6VXnwY7IQuFD
         8jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377086; x=1734981886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nohm0qlZ+D54asZWR+C7SIZfQAywm7JDUn18lM86DfI=;
        b=qOR3cJzNkk/369BnTDL0mG+DKywvhLoD6K/XXMwJiC5fpA4LqR5MvA3Ot7aMgk0oVo
         7F595NPJfEkI8nTGyrs3Iuixq3LwQHYkun96/fn07bzlbVQvQiH2dqBYe2nBY6LD/AAv
         0fnxLWSwAsLueM61pFaKmJuuOYIj0Ivw953vVl3axDrmev8cFPd9suIBjETX4qKQcT8h
         D3GzcxtJa8OSnYHwzpfoxkmG7KZhFQPf3k9ZJzV+Tcm6X14VqFybnUIEv17ppNeWUiEv
         +Y/F6qq8yu8iXo+eknE311ey8oEQ7g++D8xf4kiRCOGeAkwfNyjIP3ZnqOLy+Fqgyalf
         KVoA==
X-Forwarded-Encrypted: i=1; AJvYcCUM0kS0/Opp9v1+SL4TKNJAmu3kbtHXXX99ocG4m/IESORz8srWUkaRyfMXLTkBEFBkLptINg1jg3D/cuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTUMSmcQAFi969zIdzYItnMfE6B1wQZRnMSohIRp23xAqcO3n
	5jygQBlBiYDgWGn9AZ48XSXvp5Smsvms6dMvwP0dkPNbwpknrHAU+c2wJIr9z0xKK1ZC9zhxiGt
	ylA==
X-Google-Smtp-Source: AGHT+IF9Nz4fP8YCDWuEvv8HenQUzivi17wIWFTDjOw79pIi9puAuyZi3edh0rN76x0eDFYowMyrfvXvJ/c=
X-Received: from pgiz13.prod.google.com ([2002:a63:c04d:0:b0:7fd:585b:babf])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c88e:b0:1e0:f495:1bd9
 with SMTP id adf61e73a8af0-1e45ab17a26mr1379210637.8.1734377086086; Mon, 16
 Dec 2024 11:24:46 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:14 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-12-surenb@google.com>
Subject: [PATCH v6 11/16] mm: enforce vma to be in detached state before freeing
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

exit_mmap() frees vmas without detaching them. This will become a problem
when we introduce vma reuse. Ensure that vmas are always detached before
being freed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c |  4 ++++
 mm/vma.c      | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 283909d082cb..f1ddfc7b3b48 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -473,6 +473,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void __vm_area_free(struct vm_area_struct *vma)
 {
+#ifdef CONFIG_PER_VMA_LOCK
+	/* The vma should be detached while being destroyed. */
+	VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
+#endif
 	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
diff --git a/mm/vma.c b/mm/vma.c
index fbd7254517d6..0436a7d21e01 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -413,9 +413,15 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
-	if (unreachable)
+	if (unreachable) {
+#ifdef CONFIG_PER_VMA_LOCK
+		if (!is_vma_detached(vma)) {
+			vma_start_write(vma);
+			vma_mark_detached(vma);
+		}
+#endif
 		__vm_area_free(vma);
-	else
+	} else
 		vm_area_free(vma);
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog


