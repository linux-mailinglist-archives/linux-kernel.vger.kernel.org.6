Return-Path: <linux-kernel+bounces-321972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6897223F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8EF1C23A25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B2189906;
	Mon,  9 Sep 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJR1LrNI"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E37134C4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908454; cv=none; b=oNIi+CpBAaGvnFTKWcwo09Il+4tA1KiUzli+9Yg/We5ibpW5Ck6wpVh5f/lBvCvZzZhevZrJj6AvFMQgtSUZJANpp2ukHVlFOhgZ6wI5hbPbt9T4F2q6vqpei3h0uRRINby5mUs+6NqsjMxKP6EQKSmeR8LpU+pxjlKpCcp5YuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908454; c=relaxed/simple;
	bh=j/numQIZWtWkd6EtYn4iL3OE7HPVQg+q+JXn6cioXTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsK5WARFAKHBPH+fDK8Dk/RdeYGx+JZ9QcO2fCz8mzA/UvRxELsGOEdc95CSHlhtBkLoAML0gm8gayGcHTUYEHOFrE6LjueWPKFhn2Wsjya/J8+97ynw9keVZvkCbCAhZjSMtXARGov3SI1681FGRAuDNudZ0xBDVSYiusLVrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJR1LrNI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6bada443ffeso35097167b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725908451; x=1726513251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A72L+GUjbQDFBk2MUwlGfe11O4m077FKuGtcJSgBRQQ=;
        b=IJR1LrNIAIBVgtkHXuaVN9HDOrRcbydlX8cTKaXZT3ANXZq7yNHc6cT5MLlgpAhvPb
         Fz85SRrLcKkFgaYqiQ91IchbIXyKl3RAoC6ZaEcHM0mZruQyVJERy4sRnso3eYyqytw2
         adkYF7UvExT0CJy5aWrqutJrI0nzerA0E469hHEQyYSepEJmSzoQ2gSI8od4qxARo1bt
         X9eZni/S18UBIwrcTYpzWZq6PBHw5WSQGZvdvP/AJdTOIeIRPaNO1onbTW+M5jFRPf6m
         PcZp2ICn1HkBhZpGOr/eX84ACeev34ldi2NIrWxnFdwR11GLLgamwrCOk0pTsWGZxHZL
         /yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908451; x=1726513251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A72L+GUjbQDFBk2MUwlGfe11O4m077FKuGtcJSgBRQQ=;
        b=Td+ECXwYOechXG1nAz60rP+am6H+o415uF1ldZpmUA/PlEFLVBU4mvvwYMcHSigS2O
         bqsExV1W11HrgRFeoslMZZlNlg4g+NJ3NnZQRPBhmVVLznqL9KQ5dntkgUidoW3xuqhG
         w/U+wWkE/UL5dOkVRztHEWSUzlxTdxAvWgxJ1f8KYmD6xiaCUmkLK4pa8V2Y3lQGK0nl
         /fFAFiF7+c2pqTaQkRQNAD5gynXF4s4cgGiJIvMAYZ0J02N1WIYU78+cQUs4C4EWuIf1
         q3qdoWy5NxH8xvcCMDOShk0hPbUUmd1ccM73TVfjiF/+YOUo7qy6v89JvzIRNqVvcDrd
         ikHA==
X-Forwarded-Encrypted: i=1; AJvYcCUvx/gOf80fijn22UukVkg5qzUBdBWtANwWeUzDcIyvfVR4WYBYhNXuX2ap9uhfRJp2dsYklSHsZ4zskUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3V/uccRAQZ7L2GcRdEchOLA2g/cPMIV+WgEckBih3YXOP5kWz
	1AQ27OPzQtY3sTnOxSW/LPU+t7YB5Mt/6sI2qZ80eEziXxsZF+5v1EigaXzS135P/KUrPzzIkin
	AShd4rD+6k/e7iyDTEaZw5LDTeVd/8dTabOHh
X-Google-Smtp-Source: AGHT+IFR6zulDZKlUD4bAN1hPEwMA1FY+4vRNJHse0GHukSpBMl4XHH4SgwprP02hwRSXpE0fsxpg+6qvu7h46yJxCs=
X-Received: by 2002:a05:690c:4b0e:b0:6d4:72b7:177e with SMTP id
 00721157ae682-6db95312363mr6193027b3.5.1725908451204; Mon, 09 Sep 2024
 12:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-20-seanjc@google.com>
In-Reply-To: <20240809194335.1726916-20-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 9 Sep 2024 12:00:14 -0700
Message-ID: <CADrL8HWACwbzraG=MbDoORJ8ramDxb-h9yb0p4nx9-wq4o3c6A@mail.gmail.com>
Subject: Re: [PATCH 19/22] KVM: x86/mmu: Add infrastructure to allow walking
 rmaps outside of mmu_lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:44=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Steal another bit from rmap entries (which are word aligned pointers, i.e=
.
> have 2 free bits on 32-bit KVM, and 3 free bits on 64-bit KVM), and use
> the bit to implement a *very* rudimentary per-rmap spinlock.  The only
> anticipated usage of the lock outside of mmu_lock is for aging gfns, and
> collisions between aging and other MMU rmap operations are quite rare,
> e.g. unless userspace is being silly and aging a tiny range over and over
> in a tight loop, time between contention when aging an actively running V=
M
> is O(seconds).  In short, a more sophisticated locking scheme shouldn't b=
e
> necessary.
>
> Note, the lock only protects the rmap structure itself, SPTEs that are
> pointed at by a locked rmap can still be modified and zapped by another
> task (KVM drops/zaps SPTEs before deleting the rmap entries)
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 80 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8ca7f51c2da3..a683b5fc4026 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -909,11 +909,73 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty=
_bitmap(struct kvm_vcpu *vcpu
>   * About rmap_head encoding:
>   *
>   * If the bit zero of rmap_head->val is clear, then it points to the onl=
y spte
> - * in this rmap chain. Otherwise, (rmap_head->val & ~1) points to a stru=
ct
> + * in this rmap chain. Otherwise, (rmap_head->val & ~3) points to a stru=
ct
>   * pte_list_desc containing more mappings.
>   */
>  #define KVM_RMAP_MANY  BIT(0)
>
> +/*
> + * rmaps and PTE lists are mostly protected by mmu_lock (the shadow MMU =
always
> + * operates with mmu_lock held for write), but rmaps can be walked witho=
ut
> + * holding mmu_lock so long as the caller can tolerate SPTEs in the rmap=
 chain
> + * being zapped/dropped _while the rmap is locked_.
> + *
> + * Other than the KVM_RMAP_LOCKED flag, modifications to rmap entries mu=
st be
> + * done while holding mmu_lock for write.  This allows a task walking rm=
aps
> + * without holding mmu_lock to concurrently walk the same entries as a t=
ask
> + * that is holding mmu_lock but _not_ the rmap lock.  Neither task will =
modify
> + * the rmaps, thus the walks are stable.
> + *
> + * As alluded to above, SPTEs in rmaps are _not_ protected by KVM_RMAP_L=
OCKED,
> + * only the rmap chains themselves are protected.  E.g. holding an rmap'=
s lock
> + * ensures all "struct pte_list_desc" fields are stable.

This last sentence makes me think we need to be careful about memory orderi=
ng.

> + */
> +#define KVM_RMAP_LOCKED        BIT(1)
> +
> +static unsigned long kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
> +{
> +       unsigned long old_val, new_val;
> +
> +       old_val =3D READ_ONCE(rmap_head->val);
> +       if (!old_val)
> +               return 0;
> +
> +       do {
> +               /*
> +                * If the rmap is locked, wait for it to be unlocked befo=
re
> +                * trying acquire the lock, e.g. to bounce the cache line=
.
> +                */
> +               while (old_val & KVM_RMAP_LOCKED) {
> +                       old_val =3D READ_ONCE(rmap_head->val);
> +                       cpu_relax();
> +               }
> +
> +               /*
> +                * Recheck for an empty rmap, it may have been purged by =
the
> +                * task that held the lock.
> +                */
> +               if (!old_val)
> +                       return 0;
> +
> +               new_val =3D old_val | KVM_RMAP_LOCKED;
> +       } while (!try_cmpxchg(&rmap_head->val, &old_val, new_val));

I think we (technically) need an smp_rmb() here. I think cmpxchg
implicitly has that on x86 (and this code is x86-only), but should we
nonetheless document that we need smp_rmb() (if it indeed required)?
Perhaps we could/should condition the smp_rmb() on `if (old_val)`.

kvm_rmap_lock_readonly() should have an smb_rmb(), but it seems like
adding it here will do the right thing for the read-only lock side.

> +
> +       /* Return the old value, i.e. _without_ the LOCKED bit set. */
> +       return old_val;
> +}
> +
> +static void kvm_rmap_unlock(struct kvm_rmap_head *rmap_head,
> +                           unsigned long new_val)
> +{
> +       WARN_ON_ONCE(new_val & KVM_RMAP_LOCKED);

Same goes with having an smp_wmb() here. Is it necessary? If so,
should it at least be documented?

And this is *not* necessary for kvm_rmap_unlock_readonly(), IIUC.

> +       WRITE_ONCE(rmap_head->val, new_val);
> +}

