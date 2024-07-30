Return-Path: <linux-kernel+bounces-268216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62679421CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A001B248C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B652118DF9D;
	Tue, 30 Jul 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkS/MZ3J"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9718CC1F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372255; cv=none; b=Kb10J8KN24moGNqdTTukRfTGlNrbo1KRnwZ4nVz0axBDljJkIP1pCeA6P5lCRbHWiPFzfKRFa9AcTUvNj+MTIuh3yYMDWdOUuiL6mujWrMdi/J0FaqbppWgFIFLGM3sgdnwzpScF4F1rTbVxFTptO0F+ZFZWN8boyOz6zf2WyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372255; c=relaxed/simple;
	bh=7pd2BloxENxQ1inDVjgsIyQVOWegD+25F3x1EEf0zK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R03diq4gMrixU7xUKBNTRWUdv9uBC/KJfPMNlXIJbV9/TO9cWb0MUgIE0pV0BAh66toKnCmU/sxyB4p/D+s0ci3XClHdS4T0UwAAQ5ygviSqJVsehPRQzcypXLxX7ooZHgdysl2/qclbTN9GR1aF1mA8VbFcnYnSf5U+va3Fp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkS/MZ3J; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fe76fa0b8so78431cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722372252; x=1722977052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgyj+j3dt5UcJ0UQYMBi50Wse5pVU30lmwqJLm3OCeU=;
        b=GkS/MZ3JTlePjN72oxeNL9SXxhglYUdUhhkU305jyM0gsEEK3hCq5tIBvKjxwKUkcd
         ZWx09BEQFeEL2Tq6iRelxKHI7e5KtBWmD5dzGvGa1NMocQwCYSy2AX4EBhFLX3YN9SsH
         KEfCqXj4cID73gGAgVzznHeg99XnsvniDjz2PpwuDobeWBN1BnLWyCUweC9xCNDGsNr9
         gFthWKbh9yCKjvmSGYgKwtE67gre6pFReEyCXWqxLyLMV3ndq2F6Tn/8WIcRJfn+r31f
         4JfsB9tKE+6B9xudGUNnUY3NTfndxmCMwEvn9+CDR0LgFbteM5oO/BND2uVH9vlP3WFd
         SwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372252; x=1722977052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgyj+j3dt5UcJ0UQYMBi50Wse5pVU30lmwqJLm3OCeU=;
        b=kvot9ZjCKsMSHr0lcP4EJqj5C5zKaMDTclW13YrvLRpnbP2jQ1Pmu6rsdEFyWZaOpS
         98L+xnRCfrYI9QDYIAGkP0k01XTutF4vaiwtGHfS7IFYYdwRe9yAq2i6TQaGgh5GoNY5
         0jD6ovl7htKMZeUAF33OQxyMsl4B9RAk1gI41Xt5X7IjgOrYw+n8mDQ9udXfgHoP4mun
         I2HNqv0Vh5LmsJQAknd/DqEUO7WXJBHaoWVEcTCjLqdB2fXUTwsm5sqGXJSntNtKMzuH
         42oKFD1Yuv2hiTKRy3EKjF5b/vycuEDTPswTwOx5fRWuPc3IEBpJyGdegt5dXSFhJMhA
         4B+w==
X-Gm-Message-State: AOJu0Ywx7d+cUNk0MXFf1IIW1SxefzQjzGaExJOs2JJ4b55oxPfXNaYr
	Iait9B7+X2xAHm6LfQ5lNx1aaihGbTdKDLgsFkTXr9S6U7cSrftenIZ9ynmJiir5879rO477xxt
	N+AMR1vYBDcThYL979QUhkbl0158SFpYIocaZ
X-Google-Smtp-Source: AGHT+IGvHbr1exiYovMGLFSNWCtRnM+rnR0yYlx5wBYqZh6HIfByABr4k+MHsjm8/Eawp/JhwWBxyUFSDMDWvkd48Ng=
X-Received: by 2002:a05:622a:1306:b0:447:e6c6:bd3 with SMTP id
 d75a77b69052e-4504317924emr99991cf.21.1722372251688; Tue, 30 Jul 2024
 13:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730200341.1642904-1-david@redhat.com>
In-Reply-To: <20240730200341.1642904-1-david@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 30 Jul 2024 13:43:35 -0700
Message-ID: <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:03=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b100df8cb5857..1b1f40ff00b7d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_st=
ruct *mm, pmd_t *pmd)
>         return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>  }
>
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> +       return ptlock_ptr(virt_to_ptdesc(pte));

Hi David,

Small question: ptep_lockptr() does not handle the case where the size
of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
in this case, ptep_lockptr() should be doing the masking that
pmd_lockptr() is doing. Are you sure that you don't need to be doing
it? (Or maybe I am misunderstanding something.)

Thanks for the fix!

> +}
> +
>  static inline bool ptlock_init(struct ptdesc *ptdesc)
>  {
>         /*
> @@ -2950,6 +2956,10 @@ static inline spinlock_t *pte_lockptr(struct mm_st=
ruct *mm, pmd_t *pmd)
>  {
>         return &mm->page_table_lock;
>  }
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +       return &mm->page_table_lock;
> +}
>  static inline void ptlock_cache_init(void) {}
>  static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
> --
> 2.45.2
>
>

