Return-Path: <linux-kernel+bounces-312159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579399692DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F328344B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD51CDFB3;
	Tue,  3 Sep 2024 04:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRMOAPKG"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0713CABC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725337680; cv=none; b=rkfmuwb2zbdbxb2jmJofi/qGe686X5NQUpPbIEs3IH+CycspiAMUIi125Lx5wahyib/9Em8icoANIYhd3RQsYWGaGsSc0fDluWpi5nF8YMIH42RXZ5KtzyoY3LSiVuYJZqggGNg5m9ovlNWVxmen5upDDnW/VNWpQgqJU+L8CEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725337680; c=relaxed/simple;
	bh=UXGEdZ3n8R5vF18LazDeSJx5CNddegXHLXXrCfUMjGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=th6EVPRdLyJW3gZMtYkhLtBGJycoPuPT/6GtoqtbnlSZFH4y/yywLpSWzvHWIKathiA3Gxu1lAqgjAXinS6+05gPCy6crxngnOWnPv+MquxSyIQNjakDD5Sss6byqVf1JWSiWHx+HlRaxVZcarpJW2RXOuQKPVjbVp0Yvl/pbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRMOAPKG; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71423704ef3so3624456b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725337679; x=1725942479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSR3ghWq7rx7embFkyRQnJ5+z0d9ilBJIjTTtuB0Mj0=;
        b=LRMOAPKGGbUiKOUHfGJQhKtziyJuImRIkyAbx4SK8I+LekgBEuqrto6sNNRkBXQnGz
         4wMjLwCaKwZ7nSExMzp/7iPQXGwac2favS9nddqcl69AuBGrc74/p0+jmxLk5vHEzgmv
         vfwLv2TkEDe8cZbVjA2+DTrFz8/DaBAhFD+ayzy7qgvrQ65XjZ81X3s1RnQpp+anspGK
         SbOEiVNIc+E/W29naBhFHl7+ohsOoa13GmkTaECwRUghhkqp4LP23aAa9LUOTuoHiDjD
         xfCj6NoD5UAjJ9cjFgJXzgInxLi3NRmzlEv2v/uii/dmrLRn8AAK5c34d2aYugTDFSHF
         2e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725337679; x=1725942479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSR3ghWq7rx7embFkyRQnJ5+z0d9ilBJIjTTtuB0Mj0=;
        b=BrV/3jYpRM57eN5TJ/E6MGebLLK1P9XsKdMZvb2/daz06RSbu+T/AcLLlGblEwewoT
         COK/RCwT1moCZW0bDNrdwTZBllGY/gIof87J/JYMG7QMyzaQPBTVCkkxDjqraKusqPCu
         0IRDhJ53hWOhccLgMimd9oH4s0HiOLiCv1AUxY3Imvv4o8Pssf6KyqL+kxeEXJ1Vf8QZ
         2BzQAKKmoBd0MM4paKi0POxzWiAeXm8KPI+oWXDYxxoYr6lTqcMGP86SStxTHJ2NRrwd
         5RhGIUYFFLc7/QI8lbZeqg5se61FL/c4n93O3cFrACVKm9uF+tJqIRRougZLyiTLhEhH
         BoPw==
X-Gm-Message-State: AOJu0YxWMdXecexFjdmABMh86HmusnafAst9HUbj4S6xP1bx7+nmKer9
	/aliFZ9Tm/8BX6+ZrCbVlxb3Aws0ClR09bx3KKFDBU1r2+zvCtK+
X-Google-Smtp-Source: AGHT+IGc7dGwfXI8/4zLM4NiQDM4WeWkxmzqQ/hrS+g1LIMUs1gJ3g4OUHJvaYUtiPEOUB0yJGF4UA==
X-Received: by 2002:a05:6a20:4389:b0:1c0:e997:7081 with SMTP id adf61e73a8af0-1cecdf2e14amr11927112637.29.1725337678564;
        Mon, 02 Sep 2024 21:27:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20532b81016sm55335005ad.226.2024.09.02.21.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:27:58 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	shr@devkernel.io,
	hughd@google.com,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH 1/3] ksm: add ksm involvement information for each process
Date: Tue,  3 Sep 2024 04:27:54 +0000
Message-Id: <20240903042754.1776245-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240901043525.16831>
References: <20240901043525.16831>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> > KSM_mergeable and KSM_merge_any. It helps administrators to
> > better know the system's KSM behavior at process level.
> > 
> > KSM_mergeable: yes/no
> >     whether any VMAs of the process'mm are currently applicable to KSM.
> > 
> > KSM_merge_any: yes/no
> >     whether the process'mm is added by prctl() into the candidate list
> >     of KSM or not, and fully enabled at process level.
> > 
> > Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > ---
> > Changelog
> > =========
> > v2 -> v3:
> >          Update the KSM_mergeable getting method: loop up if any vma is
> >          mergeable to KSM.
> >         https://lore.kernel.org/all/bc0e1cdd-2d9d-437c-8fc9-4df0e13c48c0@redhat.com/
> > 
> > v1 -> v2:
> >          replace the internal flag names with straightforward strings.
> >          * MMF_VM_MERGEABLE -> KSM_mergeable
> >          * MMF_VM_MERGE_ANY -> KSM_merge_any
> > 
> >   fs/proc/base.c      |  4 ++++
> >   include/linux/ksm.h |  1 +
> >   mm/ksm.c            | 16 ++++++++++++++++
> >   3 files changed, 21 insertions(+)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 18550c071d71..45e12560e698 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3217,6 +3217,10 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
> >           seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
> >           seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
> >           seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
> > +        seq_printf(m, "KSM_mergeable: %s\n",
> > +                ksm_process_mergeable(mm) ? "yes" : "no");
> > +        seq_printf(m, "KSM_merge_any: %s\n",
> > +                test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
> 
> Inconsistent "KSM" casing .

Excuse me, could you be more specific? I didn't get it
> 
> >           mmput(mm);
> >       }
> >   
> > diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> > index 52c63a9c5a9c..5286b84964d3 100644
> > --- a/include/linux/ksm.h
> > +++ b/include/linux/ksm.h
> > @@ -84,6 +84,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
> >   void collect_procs_ksm(struct folio *folio, struct page *page,
> >           struct list_head *to_kill, int force_early);
> >   long ksm_process_profit(struct mm_struct *);
> > +bool ksm_process_mergeable(struct mm_struct *mm);
> >   
> >   #else  /* !CONFIG_KSM */
> >   
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index f5138f43f0d2..6647f2ef27ca 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -3373,6 +3373,22 @@ static void wait_while_offlining(void)
> >   #endif /* CONFIG_MEMORY_HOTREMOVE */
> >   
> >   #ifdef CONFIG_PROC_FS
> > +/*
> > + * The process is mergeable only if any VMA (and which) is currently
> 
> confusing "(and which)"

Oh yes, I'll correct it

> 
> > + * applicable to KSM.
> > + */
> > +bool ksm_process_mergeable(struct mm_struct *mm)
> > +{
> > +    struct vm_area_struct *vma;
> > +
> > +    VMA_ITERATOR(vmi, mm, 0);
> > +    for_each_vma(vmi, vma)
> > +        if (vma->vm_flags & VM_MERGEABLE)
> > +            return true;
> > +
> 
> Are we holding the mmap lock here? I only see a mmput() in 
> proc_pid_ksm_stat() above, which might mean that we are not holding the 
> mmap lock.

No, we'are missing the read lock of mmap. I'll fix it.
Thanks a lot.

