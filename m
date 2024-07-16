Return-Path: <linux-kernel+bounces-253243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11E4931E84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842D6282C44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DF6AD7;
	Tue, 16 Jul 2024 01:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM4k32dr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911633FD4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093682; cv=none; b=NAwIaCbeWy5X9uqfl7vj71cb/y6O69S/5D3hODmpW0s37tW7E4vXMon9YrOKmDKhtqTC7md1nY/1Cg8GFHw5CO7tHVI+B6vZe3GWegMESksqSEXevNA47QHu2317UzHI6zt+mv6QnuecUaxc1CYFOA2lDmPwbzyAmmAAAq5vq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093682; c=relaxed/simple;
	bh=2CWqaACw4oWsFtInC9zbZLwvE3nZlDzdxgfWY1ufWJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFI1iodn1ShAp+/rpCUXY3srGTqBYZqV9LuSPzNuaQtahyOjhaWKMFKH3jLjqcOuhNGrVYpvYNsU5vK2QBFWGpgqj8YOwkp5bkp5sKi2ohIx2x5V5LzVPaWKqJN3qH7qxPpJRyeAs4n8yfG64BoDhzmEEL8HYltWQiIX1V7IpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vM4k32dr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fd513f18bso522311866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721093678; x=1721698478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXfhOlmNPMcE/iXHOq1+rPCI914TK0b97GVcZ8iZpkQ=;
        b=vM4k32dr03yLN3JE48qna3qDSBGdScG66t1BZm1jJUlqXTdGiFl0F5iP/kHwZx9VwM
         JlwuvzKI+CRTMa+LIQMCf0uNT3aGVEbO8fJp7d6OA9Q8rrOgznQX1Oio1gcGG4Y6ZPdi
         v4BS6//oETA+yeV1MDiCAtN5TEC6Ti9K3LylNnFTS2qrNdoYu54/Kx/ArlMja0NIOK0z
         iazuYt1dE8BRVNNpKKpfLwGvvQ61Gr34lgXfGzSUvoLyLXT9UDmIzdT9SRo0YHmu/yn9
         sHgh6XmBQIYnHrqelpAqHMWSEIyOnlDmTPNxtF3Iby4wNlJsYQ+qiAfm+EJxQd3VPrR5
         69RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093678; x=1721698478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXfhOlmNPMcE/iXHOq1+rPCI914TK0b97GVcZ8iZpkQ=;
        b=DG335qdPCjHA4OWB6F1bm6Lu9nRIFMpPELk80N76VjO14xARVfNxnhPAcB3tit3Gi+
         906BC4tn78N+gQpic9yZk2+93RBjI70GE2bRoNrSDi+dJePIAUPwPWEHHP3tr9G5usNl
         yYWDB4GJGiGwQ6eqhTIinHkg5Lu9bELfYG42YcfobdHtz29bwp8+OkBrrQPqrqUJhg/P
         0x7MJGGFDwxF7XMwTg1iexWZFAK7oXBjjG5rinlIGkGhzxddMOgQgjFgxSf46+E5basJ
         O/WxxHUV81B9S1SoCFNbpXN1a7yNNGZQ+oVrxsFTEHMFsjg2vmOYl4XpMeSA5tph1BuN
         cGEw==
X-Forwarded-Encrypted: i=1; AJvYcCXHJQzcvzI5Husy5mmOmRRJqVtwO/VX3GC5ViDl8gGv04YXYJyHrOEAFw9XXSlnWruGCU7BGc3EZDMzgI2M3v/ukZjOUuCdf+idnZCu
X-Gm-Message-State: AOJu0YxxhkeikcCbryE3JEccjeZuTLG/Cfjkhuw24DMXQjYDRipGwnt0
	B0HW4N2Rx4jiusr6RdCWywNoW3rNQB7uxvRlb78czsaAMyGqCxP/6xaRBn8XoRBeiuO9fiVS3sa
	MlAId+aDposSd/cGGvIVemW7eygxZp/gX0+4W
X-Google-Smtp-Source: AGHT+IHDGZRC35aGLULhbOJd3eQkgf6eopZKOzx2Fx4/dz86aNy8ewBdPze4qEdLeNlnVLuHqesq6uBet9ZLg+DyXPw=
X-Received: by 2002:a17:906:b358:b0:a72:6f10:52da with SMTP id
 a640c23a62f3a-a79eaa9dcafmr30419866b.59.1721093677189; Mon, 15 Jul 2024
 18:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com> <20240712-asi-rfc-24-v1-19-144b319a40d8@google.com>
In-Reply-To: <20240712-asi-rfc-24-v1-19-144b319a40d8@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 15 Jul 2024 18:33:59 -0700
Message-ID: <CAJD7tkahJ3NzBgvB0CwsNUce3a-Gg_GzcYRMy6GsLONcudnJYA@mail.gmail.com>
Subject: Re: [PATCH 19/26] percpu: clean up all mappings when pcpu_map_pages() fails
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Patrick Bellasi <derkling@google.com>, KP Singh <kpsingh@google.com>, 
	Alexandra Sandulescu <aesa@google.com>, Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 10:01=E2=80=AFAM Brendan Jackman <jackmanb@google.c=
om> wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> In pcpu_map_pages(), if __pcpu_map_pages() fails on a CPU, we call
> __pcpu_unmap_pages() to clean up mappings on all CPUs where mappings
> were created, but not on the CPU where __pcpu_map_pages() fails.
>
> __pcpu_map_pages() and __pcpu_unmap_pages() are wrappers around
> vmap_pages_range_noflush() and vunmap_range_noflush(). All other callers
> of vmap_pages_range_noflush() call vunmap_range_noflush() when mapping
> fails, except pcpu_map_pages(). The reason could be that partial
> mappings may be left behind from a failed mapping attempt.
>
> Call __pcpu_unmap_pages() for the failed CPU as well in
> pcpu_map_pages().
>
> This was found by code inspection, no failures or bugs were observed.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>
>
> (am from https://lore.kernel.org/lkml/20240311194346.2291333-1-yosryahmed=
@google.com/)

This went into v6.10 as commit 2ccd48ce35e87f09472b42dda96fbf7b5165f3c3.

> ---
>  mm/percpu-vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 2054c9213c43..cd69caf6aa8d 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -231,10 +231,10 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
>         return 0;
>  err:
>         for_each_possible_cpu(tcpu) {
> -               if (tcpu =3D=3D cpu)
> -                       break;
>                 __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_star=
t),
>                                    page_end - page_start);
> +               if (tcpu =3D=3D cpu)
> +                       break;
>         }
>         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
>         return err;
>
> --
> 2.45.2.993.g49e7a77208-goog
>

