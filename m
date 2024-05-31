Return-Path: <linux-kernel+bounces-197586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D28D6CD2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31881F24B40
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9F84DE4;
	Fri, 31 May 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvkLwDMq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1078C6B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717197904; cv=none; b=uEoCdfuSykOlmsToi3qKxYlXQjcJnGEFd+5SpUSdk4q77ijwMifSxgM1kxJwoo5McYgiu4ZE5Kz8FIb+P52uA4PBSABLdxC8mUNvDyNtwBt0jjuswRxowkItinUynDF6vvYbiPG9qPVuiy33AHuM+e1XsCiG/pNjqR7qcvAIwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717197904; c=relaxed/simple;
	bh=NujItm6IZDZ/VF5Y8JbKIbrmn8wRurNxB4bIYtveC2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgQlXBvdWwyBrE52wSpkYKJJzcm+V+vAM5mJ1+SorHN0lq2/kjT3XL/mPcxWw1DKtP/19nnbyYyQFeGvZTafJcn7bBRkRoP7WxCgB5T88BBXQl4fZAQmnpHJOL4odLyvH34OqzMgsE+Na+kMjHC5+SNAQrns6ZyKI3iDGWdBZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvkLwDMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717197901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OswPDDFUjIMOdynPoqOpjOBcZ9Oh6NGxWSjBgab9jQ=;
	b=MvkLwDMqppXlajW1t3JluZynl/j+v5lptd/gmvzj3WWYq845galTTIGWgTYk2SIBoyfpun
	ntoEexLFAOEcKSqNJJdAXyn7QQG2PVBAD3JOo79SbWHgVtGoGiJ2xu2AWpbiu8Kg/7o4A2
	RiwLrHz5RZZnbdncvvAZ2ZecMnvAm78=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-cSXTHYMdNHibX59OtCOq0g-1; Fri, 31 May 2024 19:25:00 -0400
X-MC-Unique: cSXTHYMdNHibX59OtCOq0g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ae60738262so5356936d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717197899; x=1717802699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OswPDDFUjIMOdynPoqOpjOBcZ9Oh6NGxWSjBgab9jQ=;
        b=WEumNfUnIjUyn2OX9YN3Qx1Ldr+RqA3S7FXtoHt9IWOIlWENaj/Q5vQN+uVjWZM+Z5
         KbqvG8kTkL3jvAyBOUtDtalU3IUgET3Wru+RUpJMt3EENobYU7yE1SML4cVi/9Og8UA+
         cSWL6xIpBb4/LbDnRRn7sso3SamWCIRGhmlT7cL0lKFgnx1KBW3i75DSSeZleI6PZ+QQ
         F73TqyMB5sfmD6/TWQBvj/XOiyQqxLz90T9tN5OwBnyl2o8bcZv7LhFOXyiU3Yd02vNO
         zy7biRYDkObfnl2qCKPcKyYwQomEPbgCRRYNXkfqtS+zJiJN9ViRyuoriQhHXSGmczRH
         SrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7yFc/k9ZUCgRAiI29NVmN/sREoMCr6IvE2Oh/cyb2EuTjZNA/8/4vnSNdSTniZtr2zarPDSHQfyiYUQDMHrJKPuTpYtiEG5BUrr3/
X-Gm-Message-State: AOJu0YysTdV/2oa4xamhCrl/D863GLOvDhX17F7Ia0RYANjkfvX5ywGU
	Eo7pod6t3SHa3OQbXkjZT0pq0PRQPzeIeGTKkk6c9N0OQMubSia4tli6X89a15dZI1VFmy8ol3/
	D9tRWET6FxKUWGRbeUz+ez+e6KD6K4mw2LfGDyjL9LE7oDWSHrDrZa8g5ttOcDg==
X-Received: by 2002:a05:6214:f6e:b0:6ad:8c3b:6aed with SMTP id 6a1803df08f44-6aecd599f82mr36367526d6.2.1717197898391;
        Fri, 31 May 2024 16:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz+7XbQjDZ9os1V3c/5X75LCTcRQverrG6zGj/NwlvNEnqx93sPhKf/BgLleDFbNQtcwzDPg==
X-Received: by 2002:a05:6214:f6e:b0:6ad:8c3b:6aed with SMTP id 6a1803df08f44-6aecd599f82mr36367206d6.2.1717197897510;
        Fri, 31 May 2024 16:24:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4065a1sm10327056d6.94.2024.05.31.16.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:24:57 -0700 (PDT)
Date: Fri, 31 May 2024 19:24:54 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Rik van Riel <riel@surriel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christopher Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <ZlpcRnuZUEYJJ0JA@x1n>
References: <202405311534.86cd4043-lkp@intel.com>
 <CAHbLzkpMhEuGkQDGWrK1LhvZ-ZxTJkV1xjmn-nRGZMH4U+F5ZA@mail.gmail.com>
 <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <890e5a79-8574-4a24-90ab-b9888968d5e5@redhat.com>

On Fri, May 31, 2024 at 07:46:41PM +0200, David Hildenbrand wrote:
> try_grab_folio()->try_get_folio()->folio_ref_try_add_rcu()
> 
> Is called (mm-unstable) from:
> 
> (1) gup_fast function, here IRQs are disable
> (2) gup_hugepte(), possibly problematic
> (3) memfd_pin_folios(), possibly problematic
> (4) __get_user_pages(), likely problematic
> 
> (1) should be fine.
> 
> (2) is possibly problematic on the !fast path. If so, due to commit
>     a12083d721d7 ("mm/gup: handle hugepd for follow_page()") ? CCing Peter.
> 
> (3) is possibly wrong. CCing Vivek.
> 
> (4) is what we hit here

I guess it was overlooked because try_grab_folio() didn't have any comment
or implication on RCU or IRQ internal helpers being used, hence a bit
confusing.  E.g. it has different context requirement on try_grab_page(),
even though they look like sister functions.  It might be helpful to have a
better name, something like try_grab_folio_rcu() in this case.

Btw, none of above cases (2-4) have real bug, but we're looking at some way
to avoid triggering the sanity check, am I right?  I hope besides the host
splash I didn't overlook any other side effect this issue would cause, and
the splash IIUC should so far be benign, as either gup slow (2,4) or the
newly added memfd_pin_folios() (3) look like to have the refcount stablized
anyway.

Yang's patch in the other email looks sane to me, just that then we'll add
quite some code just to avoid this sanity check in paths 2-4 which seems
like an slight overkill.

One thing I'm thinking is whether folio_ref_try_add_rcu() can get rid of
its RCU limitation. It boils down to whether we can use atomic_add_unless()
on TINY_RCU / UP setup too?  I mean, we do plenty of similar things
(get_page_unless_zero, etc.) in generic code and I don't understand why
here we need to treat folio_ref_try_add_rcu() specially.

IOW, the assertions here we added:

	VM_BUG_ON(!in_atomic() && !irqs_disabled());

Is because we need atomicity of below sequences:

	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
	folio_ref_add(folio, count);

But atomic ops avoids it.

This chunk of code was (mostly) originally added in 2008 in commit
e286781d5f2e ("mm: speculative page references").

In short, I'm wondering whether something like below would make sense and
easier:

===8<===
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 1acf5bac7f50..c89a67d239d1 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -258,26 +258,9 @@ static inline bool folio_try_get(struct folio *folio)
 	return folio_ref_add_unless(folio, 1, 0);
 }
 
-static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
-{
-#ifdef CONFIG_TINY_RCU
-	/*
-	 * The caller guarantees the folio will not be freed from interrupt
-	 * context, so (on !SMP) we only need preemption to be disabled
-	 * and TINY_RCU does that for us.
-	 */
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
-	folio_ref_add(folio, count);
-#else
-	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
-		/* Either the folio has been freed, or will be freed. */
-		return false;
-	}
-#endif
-	return true;
+static inline bool folio_ref_try_add(struct folio *folio, int count)
+{
+	return folio_ref_add_unless(folio, count, 0);
 }
 
 /**
@@ -305,7 +288,7 @@ static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
  */
 static inline bool folio_try_get_rcu(struct folio *folio)
 {
-	return folio_ref_try_add_rcu(folio, 1);
+	return folio_ref_try_add(folio, 1);
 }
 
 static inline int page_ref_freeze(struct page *page, int count)
diff --git a/mm/gup.c b/mm/gup.c
index e17466fd62bb..17f89e8d31f1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -78,7 +78,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	folio = page_folio(page);
 	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
-	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
+	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
 
 	/*
===8<===

So instead of adding new code, we fix it by removing some.  There might be
some implication on TINY_RCU / UP config on using the atomic_add_unless()
to replace one atomic_add(), but I'm not sure whether that's a major issue.

The benefit is try_get_folio() then don't need a renaming then, because the
rcu implication just went away.

Thanks,

-- 
Peter Xu


