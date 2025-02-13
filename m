Return-Path: <linux-kernel+bounces-512096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BCA333F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF00167B00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120235951;
	Thu, 13 Feb 2025 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g44owFdk"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100181E48A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406353; cv=none; b=iFbztQrgluMi5l5g11WYHePgl7TdIgVYFrlOIPzqOnIZQLoOzaIM67ETGcxvZFLZU5VLw3lCDV0s3uKT5VYvJDJKtAggf+aPIH7zAaGFNWICbf37WfvWyi9vDUcnkVj6D3uGcy+utyiL1Ds/pakKYniZrejLP0W/vG1C6f9ZKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406353; c=relaxed/simple;
	bh=N6Vhy+AMNySdETQuQGcSvVOsB67SX6hT78NIQyA2UJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP0xe4bt7jqB7xbHtGpAPEM+k59eqOgn0B6ysOhADNNkqi+ta1m/0ajsCdagDeqzWKFjJvl4iFBG+q26KQZehfnDXqYJZ0C1lorvODz+Dc0S0f0FeeH7qhxG00hf1xg+qVXFvyu3lzjM/9U26pKAk8rhShehdzL3dcj8fXZW+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g44owFdk; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fb0de4ecd4so3122547b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739406350; x=1740011150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2u8kKjrY9fIuB9CNcK79YulIHKo8nYe5XdwcfoOaGc=;
        b=g44owFdktVFQzO45V80Y2zTO06nFP3zgAIySx+iU23lzhUqtxh5X/pRSiNd4m4GX3a
         LbtN6yvnMjo3hRUNPaX2rwl3K5exSfZ3EJdTXol6ZrW15+BG1SpoODHVJd0p0UFqVHtz
         ZNfLlU5fR44kcrOm6JFS79PQw3bXb80+CzQJyCrfJq9ihcIMtR07NOiGPqNLzCDMOq+a
         w41P8GXOOG8et9kGSylSFF7HHii5c/vFnrUluPfyQDF/a9NDyWfy2jg8Lvcfus70dM4T
         +H8DSBGbhEb/qdzdopFRehl8Qsbd5FqgrK0HnTEmbzfMryefBr7y4/VrLd9ZoJZ0Lo+b
         iCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739406350; x=1740011150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2u8kKjrY9fIuB9CNcK79YulIHKo8nYe5XdwcfoOaGc=;
        b=euUMXKDPaxbDHQucKbWlJhgw78BSTuiUOGN/+WZAxCjzQKaXBBCq7FpXkjZkig+u+h
         VOkFr+ul3npomYb90mjps8HAX0nAL7y96w8GPmcefpYv94Z7LnMU+Z79BTofcDj366FN
         Oy0dIff6iG4NxuKhk+X3I+auXqTq1hUrWlixdPlJNujCagymAwUDSxGNgpZ5+T005vZ8
         0P/sEXoTA6gdJ52OYdI3VG/+gervMnijhbjPs/BUMJ+vBQzyq36J5CKN4fdu46r/YzeD
         ernfO/vIIhNCJyOCqujH1QIGTtFl/rPI5otaBjBF1sZZGO3vcA9EpoW5gQZerWy3eDRp
         yH4A==
X-Forwarded-Encrypted: i=1; AJvYcCWRye7cGqfp0nZJCfbS28dQK7OrQ/hkHPknAIZoYlh8R/rvQRYXrwTgYvtFI+nu5GC0DyO1aeQhSJpaqEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvBSWtQukHUv87QJWL39HRpEEEDQeaXf2G4eY9/5UnMAoKW6E
	R+xJcDbi5R/bFx8SkxgYd8LDdwt4QVKSKXzD+fXZTJON3QCoZjhaOUnKEGVYiosv7Zg2iC9aAJj
	eZ3zc4jYLzjUsCIa3FJgx/lEBWXJxfmFmW0BS
X-Gm-Gg: ASbGncufSkJ2AkxCszDpTQBl2SZXE0f16d+Dxz+THcuq2EVwgyxXFPmZdTdxQ2L4CJg
	bxg92dVhmvlPAm7w+Hp2pkbjcBE8zq9aEqBQWn6BfG5ACu4jkbAcw5hyCz5bwaBKdt5suRAF8AL
	Z14uUSRo5FFzfnx7YK7eaouIZovg==
X-Google-Smtp-Source: AGHT+IHTvcCYWI14ZvnOu7zHEbTk1BAtb39a79vbmvFNPOyo3bHRiYj75C11od9wdFZaB6X6hn5P1hAXqVGs764bwRg=
X-Received: by 2002:a05:690c:6489:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6fb21c5e23amr46018817b3.33.1739406349753; Wed, 12 Feb 2025
 16:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204004038.1680123-1-jthoughton@google.com>
 <20250204004038.1680123-5-jthoughton@google.com> <Z60bhK96JnKIgqZQ@google.com>
In-Reply-To: <Z60bhK96JnKIgqZQ@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 12 Feb 2025 16:25:14 -0800
X-Gm-Features: AWEUYZkCeXzHOoGZKWc3H7LLiVS6f8Z8ZO9QrsVmFhGfklstLnZ9qL0es-onr0M
Message-ID: <CADrL8HWhuWjfuU2gPjKw0y7y1Z6oxBc05OAWUT3=L3_NtVgRrA@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] KVM: x86/mmu: Relax locking for
 kvm_test_age_gfn() and kvm_age_gfn()
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:07=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Feb 04, 2025, James Houghton wrote:
> > diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> > index 22551e2f1d00..e984b440c0f0 100644
> > --- a/arch/x86/kvm/mmu/spte.c
> > +++ b/arch/x86/kvm/mmu/spte.c
> > @@ -142,8 +142,14 @@ bool spte_has_volatile_bits(u64 spte)
> >               return true;
> >
> >       if (spte_ad_enabled(spte)) {
> > -             if (!(spte & shadow_accessed_mask) ||
> > -                 (is_writable_pte(spte) && !(spte & shadow_dirty_mask)=
))
> > +             /*
> > +              * Do not check the Accessed bit. It can be set (by the C=
PU)
> > +              * and cleared (by kvm_tdp_mmu_age_spte()) without holdin=
g
>
> When possible, don't reference functions by name in comments.  There are =
situations
> where it's unavoidable, e.g. when calling out memory barrier pairs, but f=
or cases
> like this, it inevitably leads to stale code.

Good point. Thanks.

>
> > +              * the mmu_lock, but when clearing the Accessed bit, we d=
o
> > +              * not invalidate the TLB, so we can already miss Accesse=
d bit
>
> No "we" in comments or changelog.

Ah my mistake.

> > +              * updates.
> > +              */
> > +             if (is_writable_pte(spte) && !(spte & shadow_dirty_mask))
> >                       return true;
>
> This 100% belongs in a separate prepatory patch.  And if it's moved to a =
separate
> patch, then the rename can/should happen at the same time.
>
> And with the Accessed check gone, and looking forward to the below change=
, I think
> this is the perfect opportunity to streamline the final check to:
>
>         return spte_ad_enabled(spte) && is_writable_pte(spte) &&
>                !(spte & shadow_dirty_mask);

LGTM.

> No need to send another version, I'll move things around when applying.

Thanks!

> Also, as discussed off-list I'm 99% certain that with the lockless aging,=
 KVM
> must atomically update A/D-disabled SPTEs, as the SPTE can be access-trac=
ked and
> restored outside of mmu_lock.  E.g. a task that holds mmu_lock and is cle=
aring
> the writable bit needs to update it atomically to avoid its change from b=
eing
> lost.

Yeah you're right. This logic applies to A/D-enabled SPTEs too, just
that we choose to tolerate failures to update the Accessed bit. But in
the case of A/D-disabled SPTEs, we can't do that. So this makes sense.
Thanks!

> I'll slot this is in:
>
> --
> From: Sean Christopherson <seanjc@google.com>
> Date: Wed, 12 Feb 2025 12:58:39 -0800
> Subject: [PATCH 03/10] KVM: x86/mmu: Always update A/D-disable SPTEs
>  atomically
>
> In anticipation of aging SPTEs outside of mmu_lock, force A/D-disabled
> SPTEs to be updated atomically, as aging A/D-disabled SPTEs will mark the=
m
> for access-tracking outside of mmu_lock.  Coupled with restoring access-
> tracked SPTEs in the fast page fault handler, the end result is that
> A/D-disable SPTEs will be volatile at all times.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  arch/x86/kvm/mmu/spte.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 9663ba867178..0f9f47b4ab0e 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -141,8 +141,11 @@ bool spte_needs_atomic_update(u64 spte)
>         if (!is_writable_pte(spte) && is_mmu_writable_spte(spte))
>                 return true;
>
> -       /* Access-tracked SPTEs can be restored by KVM's fast page fault =
handler. */
> -       if (is_access_track_spte(spte))
> +       /*
> +        * A/D-disabled SPTEs can be access-tracked by aging, and access-=
tracked
> +        * SPTEs can be restored by KVM's fast page fault handler.
> +        */
> +       if (!spte_ad_enabled(spte))
>                 return true;
>
>         /*
> @@ -151,8 +154,7 @@ bool spte_needs_atomic_update(u64 spte)
>          * invalidate TLBs when aging SPTEs, and so it's safe to clobber =
the
>          * Accessed bit (and rare in practice).
>          */
> -       return spte_ad_enabled(spte) && is_writable_pte(spte) &&
> -              !(spte & shadow_dirty_mask);
> +       return is_writable_pte(spte) && !(spte & shadow_dirty_mask);
>  }
>
>  bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
> --

