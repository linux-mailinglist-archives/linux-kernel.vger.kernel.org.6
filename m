Return-Path: <linux-kernel+bounces-313966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57AA96ACF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE731F258F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93921D7988;
	Tue,  3 Sep 2024 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVs7gRMu"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A06126C0B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406882; cv=none; b=XRH8PDwypA1lws1ZhGQ67/c+EDHkwiuLJe8oA0xje+U9g9HHi2hDnHfbtBF7ayTI+l6sKecurd/saAkBRXxL5WAVF9mtkizgAZceCFZoXw+CycNxRn1t/OnJ8WLAEJIN1UOTzuV8Rx7+T6lvbMKjK1/beI9f0VbcPmlBNGKVSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406882; c=relaxed/simple;
	bh=5iIbSt1aCUfaT7ma92jE9I4MrBY9Tx59H37wbUkPkLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDPsjKBK6T3o+RX/rZ7IN99EeSurizwBhP6c/lNiKKr7iy74yCzGBcAYzzy9KZJSb2oDytnltJ5kR5O3Jc6I4GwMSmapdag3umk4Z7BYGHZ/5VvVm2CoJnGPPA2q5wfmo3rxUB6kJzEujSn7l/MFnIrgcxdUjnQPn4JmfYSPEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVs7gRMu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so4348656276.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725406880; x=1726011680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5M0Sum4xgHlTMU2fLROf8XBEuOZsxnLsFF2EblQMHc=;
        b=BVs7gRMu6QXpsp/trICFc6Sjuqb09w5JLyi8bYWgW63RtG0MQaoDqarHqpJPg6UHb3
         wGteZ+Dejq2tP9BGZQojQuyhiiHWPsb/w0C0F8TgTPkBZN1y5l7LKrsk772ZtBH3/NlI
         XA1ukqmb2k1gO1ZXjsTudSS9CMetMzzn98TCr1AeQkuRf4DABBmWm40hxovC8ivbO0Ho
         QXQHUQoSF0uHDMCg/prDsm0emwMxMgTvzv7hwhP+jDBmgerMWoLzqMVeg8u1mHOrwo9a
         NbKRt6Ndhxkk16sOIHnYz1h08g66MkdBtmO0UT8GD5zo24dVKqgv+CEC8iNbVK+qC97W
         /kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725406880; x=1726011680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5M0Sum4xgHlTMU2fLROf8XBEuOZsxnLsFF2EblQMHc=;
        b=xLhcgJ3zyuMYkFW2Z5xEcNppfpCQzdqApGfOpGCvBQC/JTXvZrfNsZFa1bxlJ25O03
         w8dlzmhfto20oOq4fX7h4bE7nrGhvcSMV9jJ80miZ3aQsqvT5rQskxEG+dHntMEMFqhv
         PMF9cYBgXfcN/zSJd/Kcbl+jA7rtWMxiSbRJEnAvj20mnw5L4+Qc1rapgnaGYu+Q18tu
         kyNIOGtEnwFeoKGSBR/IB0rtEKfcO/YmGRQUJi3rZqaUPuTgJDgfhJef1qCbauEjr6vv
         zbqcnQULRViYGxYz/SYXXpPukpyDhS0JclZC0mU6ChnRXStLCB7g9KHLPZ+mFmVDzprN
         NWCA==
X-Forwarded-Encrypted: i=1; AJvYcCXhXHomwiwy/qvARubvhdqPfH8cwy+yt3Uwi0I+Q7CjE//0CKRdvVKhGornF03PBC8u+Q1QhBWkdG0uE4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu1D8Hr5qDZ/oTIxqI2IYpX7QGNCNtVTADHNh5uGB71BpkbZE/
	/Us7lvbiRCG/W9is+lcRrTUdg3DsEbWVX9a8+FDiOK5lpTFFeyIHaIcryvZ3xk9txUXQuEL6aEs
	SLBa9C305SormPVVv+zPBxypukdq9N/26rfs+
X-Google-Smtp-Source: AGHT+IFWEFEBxEfnZLDRslHEZBai9WH4P0k103YAF6DmVxrdDw6kLMNpGPXrgYEEvE4DIx2uMMfkeh1c/yvpuejloeI=
X-Received: by 2002:a05:6902:1405:b0:e1a:7271:b3e6 with SMTP id
 3f1490d57ef6-e1a7a3d0fabmr17177041276.53.1725406879370; Tue, 03 Sep 2024
 16:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com> <20240903232241.43995-7-anthony.yznaga@oracle.com>
In-Reply-To: <20240903232241.43995-7-anthony.yznaga@oracle.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 3 Sep 2024 16:40:43 -0700
Message-ID: <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/10] mm/mshare: Add vm flag for shared PTEs
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:23=E2=80=AFPM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
>
> From: Khalid Aziz <khalid@kernel.org>
>
> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
> a function to determine if a vma shares PTEs by checking this flag.
> This is to be used to find the shared page table entries on page fault
> for vmas sharing PTEs.
>
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  include/linux/mm.h             | 7 +++++++
>  include/trace/events/mmflags.h | 3 +++
>  mm/internal.h                  | 5 +++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6549d0979b28..3aa0b3322284 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -413,6 +413,13 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_DROPPABLE           VM_NONE
>  #endif
>
> +#ifdef CONFIG_64BIT
> +#define VM_SHARED_PT_BIT       41
> +#define VM_SHARED_PT           BIT(VM_SHARED_PT_BIT)
> +#else
> +#define VM_SHARED_PT           VM_NONE
> +#endif
> +
>  #ifdef CONFIG_64BIT
>  /* VM is sealed, in vm_flags */
>  #define VM_SEALED      _BITUL(63)
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflag=
s.h
> index b63d211bd141..e1ae1e60d086 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -167,8 +167,10 @@ IF_HAVE_PG_ARCH_X(arch_3)
>
>  #ifdef CONFIG_64BIT
>  # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
> +# define IF_HAVE_VM_SHARED_PT(flag, name) {flag, name},
>  #else
>  # define IF_HAVE_VM_DROPPABLE(flag, name)
> +# define IF_HAVE_VM_SHARED_PT(flag, name)
>  #endif
>
>  #define __def_vmaflag_names                                            \
> @@ -204,6 +206,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,  "softdirty"     )=
               \
>         {VM_HUGEPAGE,                   "hugepage"      },              \
>         {VM_NOHUGEPAGE,                 "nohugepage"    },              \
>  IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,     "droppable"     )               \
> +IF_HAVE_VM_SHARED_PT(VM_SHARED_PT,     "sharedpt"      )               \
>         {VM_MERGEABLE,                  "mergeable"     }               \
>
>  #define show_vma_flags(flags)                                          \
> diff --git a/mm/internal.h b/mm/internal.h
> index b4d86436565b..8005d5956b6e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1578,4 +1578,9 @@ void unlink_file_vma_batch_init(struct unlink_vma_f=
ile_batch *);
>  void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm=
_area_struct *);
>  void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>

Hi Anthony,

I'm really excited to see this series on the mailing list again! :) I
won't have time to review this series in too much detail, but I hope
something like it gets merged eventually.

> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
> +{
> +       return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
> +}

Tiny comment - I find vma_is_shared() to be a bit of a confusing name,
especially given how vma_is_shared_maywrite() is defined. (Sorry if
this has already been discussed before.)

How about vma_is_shared_pt()?

