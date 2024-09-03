Return-Path: <linux-kernel+bounces-313652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD696A82A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD3B1F24187
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7821AB6F1;
	Tue,  3 Sep 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZ8mFr9j"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C2175D45
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394699; cv=none; b=q33fB3pCN50bFEvz8ca6wF60TvJ3NTSknz27rBSgdhxthTXiM1m1S7sfy1v1QK8AynGfv10qI2+unUA4I/PQ4zYAkn2LuS8ufm4aJ91YNNG6RmoHAC/HvIYdKN+H1cTqgqQ6l6LOKJHXFHmhcXxyKBCCh/XGQml87uzSptC758Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394699; c=relaxed/simple;
	bh=vqPrsuLAadIVwHpctirEna5UZ8crz7z1K8rS2xh+mUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjGmY+rxhDxDzm9wgeLgQczTErHHejmnKcW4OnMaiEJLlB1DIuiJfy8aVUnPpUZ/eU4z9bWO02GxbvTBQvRGewpaBPc992k31M2Rfl6b9utEryyrXCn+htXNTwGCofmhnIfa2eMCqrccdljSDfn1Kluzq86VbuTcHWVLTF/mogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZ8mFr9j; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso3531201276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725394697; x=1725999497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IOIYEw/jeHb64GELpDm5TMQOm7M8Rg31rMOmnYe6WQ=;
        b=uZ8mFr9jYLsTG6YUAty9TB/oSdCf5/NnHu6M6JcobaVZiySBxe+Fbckl5gwKnGEimB
         x9bc6N6JdDbzOJBGxU4sL0qq6GKEMCvoyFd6D9VWmughvm8niKahVIm4YYNXOPhHpZue
         hI3+oqZU/+xLy/tCvcQguPrcQH9kOTimNSc0i8uPZH2QlxVMPwOhsLb73oTNdKRkhOGu
         hDkqq7vQz+eLcDqr94fxR9YsXQf3UmfHR2rY+X0LzwMsmcjDj3UuK/QPJq7FQECLPmZU
         ZkJMAlibjlzaBPzAMly76GiUTrE2OZhyzRLuu8sirsqQVloVLSJFSk28GVdOMCwPqofU
         Mg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725394697; x=1725999497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IOIYEw/jeHb64GELpDm5TMQOm7M8Rg31rMOmnYe6WQ=;
        b=BrCYrViyBcPhoC3hpxANV4AZoOl3g/K+WXzu6BeNwaEDV4YTjvUGWGVJuSoYV9LT8c
         ppzLey13y9pSupEZzfERK3zx9k2J1BVFRcLZSxxJLL50x1clG0OdVygiJWhlKkPPA2rI
         ccxmjmaHEM/ox+evqbtdkSef4iR+igy2huVEJxtLaj50uwwjoxqW8ijOkye8bcytPe7W
         zB36jc/fGtXGjX0DqXdoFQHIY8UX5hzSIPMBYtQPwiz4+fLTEOXc3wX4KBpryV6TkpDQ
         SxQKyK/I8bn0rVxT1BzZ+CkVmQcBbS7jNAV3GeXc2HHKijIrzkJfl17O1hndDw3Ai++n
         FoZA==
X-Forwarded-Encrypted: i=1; AJvYcCVna93NmdS9lepi88LA0Gcz0IIbc3/Q+ajU78k1gxrV4Hfr0Y7Aa/Uo9ondugSvx5M6Pclv2Hco4STNUaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9k7klp3X9Tv+r4oCLvX22WOa9yhQH3ZQFdhzAGfO1rD1ABXFU
	Rij/hT2SHFn5DXhzT0XpR0vK4faDcA953NjaNMzC2mxKG0G/GNoQNIM2nc5mgPvNwV703+zPd8P
	8P7kTHEGyssTAuf5h5XK7FGVsLJiymoZY+rKdvDaPDMZJb+9/gw==
X-Google-Smtp-Source: AGHT+IEBPbHaQI58PjAPTmNofcLAkNwr7ellpsk8jvXpXQbpvkKIFZMG2GPmvc+blZiCV4V3tUeq48RgQqu/49/Dgtk=
X-Received: by 2002:a05:6902:160f:b0:e1a:9461:f828 with SMTP id
 3f1490d57ef6-e1a9461f8a6mr13035809276.10.1725394696978; Tue, 03 Sep 2024
 13:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-20-seanjc@google.com>
In-Reply-To: <20240809194335.1726916-20-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 3 Sep 2024 13:17:40 -0700
Message-ID: <CADrL8HUvmbtmfcLzqLOVhj-v7=0oEA+0DPrGnngtWoA50=eDPg@mail.gmail.com>
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

I'm having trouble understanding how this bit works. What exactly is
stopping the rmap from being populated while we have it "locked"? We
aren't holding the MMU lock at all in the lockless case, and given
this bit, it is impossible (I think?) for the MMU-write-lock-holding,
rmap-modifying side to tell that this rmap is locked.

Concretely, my immediate concern is that we will still unconditionally
write 0 back at unlock time even if the value has changed.

I expect that this works and I'm just not getting it... :)


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
> +
> +       /* Return the old value, i.e. _without_ the LOCKED bit set. */
> +       return old_val;
> +}
> +
> +static void kvm_rmap_unlock(struct kvm_rmap_head *rmap_head,
> +                           unsigned long new_val)
> +{
> +       WARN_ON_ONCE(new_val & KVM_RMAP_LOCKED);
> +       WRITE_ONCE(rmap_head->val, new_val);
> +}
> +
> +static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
> +{
> +       return READ_ONCE(rmap_head->val) & ~KVM_RMAP_LOCKED;
> +}
> +
>  /*
>   * Returns the number of pointers in the rmap chain, not counting the ne=
w one.
>   */
> @@ -924,7 +986,7 @@ static int pte_list_add(struct kvm_mmu_memory_cache *=
cache, u64 *spte,
>         struct pte_list_desc *desc;
>         int count =3D 0;
>
> -       old_val =3D rmap_head->val;
> +       old_val =3D kvm_rmap_lock(rmap_head);
>
>         if (!old_val) {
>                 new_val =3D (unsigned long)spte;
> @@ -956,7 +1018,7 @@ static int pte_list_add(struct kvm_mmu_memory_cache =
*cache, u64 *spte,
>                 desc->sptes[desc->spte_count++] =3D spte;
>         }
>
> -       rmap_head->val =3D new_val;
> +       kvm_rmap_unlock(rmap_head, new_val);
>
>         return count;
>  }
> @@ -1004,7 +1066,7 @@ static void pte_list_remove(struct kvm *kvm, u64 *s=
pte,
>         unsigned long rmap_val;
>         int i;
>
> -       rmap_val =3D rmap_head->val;
> +       rmap_val =3D kvm_rmap_lock(rmap_head);
>         if (KVM_BUG_ON_DATA_CORRUPTION(!rmap_val, kvm))
>                 goto out;
>
> @@ -1030,7 +1092,7 @@ static void pte_list_remove(struct kvm *kvm, u64 *s=
pte,
>         }
>
>  out:
> -       rmap_head->val =3D rmap_val;
> +       kvm_rmap_unlock(rmap_head, rmap_val);
>  }
>
>  static void kvm_zap_one_rmap_spte(struct kvm *kvm,
> @@ -1048,7 +1110,7 @@ static bool kvm_zap_all_rmap_sptes(struct kvm *kvm,
>         unsigned long rmap_val;
>         int i;
>
> -       rmap_val =3D rmap_head->val;
> +       rmap_val =3D kvm_rmap_lock(rmap_head);
>         if (!rmap_val)
>                 return false;
>
> @@ -1067,13 +1129,13 @@ static bool kvm_zap_all_rmap_sptes(struct kvm *kv=
m,
>         }
>  out:
>         /* rmap_head is meaningless now, remember to reset it */
> -       rmap_head->val =3D 0;
> +       kvm_rmap_unlock(rmap_head, 0);
>         return true;
>  }
>
>  unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
>  {
> -       unsigned long rmap_val =3D rmap_head->val;
> +       unsigned long rmap_val =3D kvm_rmap_get(rmap_head);
>         struct pte_list_desc *desc;
>
>         if (!rmap_val)
> @@ -1139,7 +1201,7 @@ struct rmap_iterator {
>  static u64 *rmap_get_first(struct kvm_rmap_head *rmap_head,
>                            struct rmap_iterator *iter)
>  {
> -       unsigned long rmap_val =3D rmap_head->val;
> +       unsigned long rmap_val =3D kvm_rmap_get(rmap_head);
>         u64 *sptep;
>
>         if (!rmap_val)
> --
> 2.46.0.76.ge559c4bf1a-goog
>

