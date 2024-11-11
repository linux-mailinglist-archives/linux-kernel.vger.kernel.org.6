Return-Path: <linux-kernel+bounces-404234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3129C4134
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C286C283264
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8019DFB5;
	Mon, 11 Nov 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgRYU6pT"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80135158DC8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336384; cv=none; b=u/TmcBQMNXT4UqhE4YCA7gKyBbfnec7TANYNq8CbBPw0ga2FAZKVx1yLEZ1HGWd/OcsSOkPod/4mYe1iQ07ag3bWKfnIAkXFTjlzKXSRWxbUnJbPxxqoImdHUoAZIogxq8gXEeKigXqOylK0oBd3hPiHSxHSPw18ktO7zH+gVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336384; c=relaxed/simple;
	bh=/kcz22q+Xh7P78+qXf2Q5/TRZ7aOm71yZ8yTr7zBPg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU7/5C2CHR0/cbqAh8FHB/iRI41NPShRqOmP+0XNPGw/NKhPnLdncli0aXE7eqqjLIxAr1hHtoL1qrjLm1HMIvnzkjQNynbc75C44ocjYn6ea6p/3X1dNL7ksfj6Ih/Gcu9hnod2IkHbCJgz3j0qqWUG3GzO3IqR/6SdOE7He5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgRYU6pT; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2918664a3fso3876505276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731336380; x=1731941180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuBjXOdgMWI3BuIwD303XNDgcqUxAXweoBqiSwzCoBg=;
        b=bgRYU6pTBVJiAZAHYuUDGNJ3KvBazD8ChxiTqcyfTAMtG5uurC0mQmsqiyPEy2dSnH
         wcMOs+eSz1YkM7nQYvhW44gUbvAOU6+OD25vzbL+zcGKAv3TMOOzfVsm/knEIEqU8tNe
         Kq6aUE1AdTV06d9sOf5X9OkTN9jJI0ZukmuYXPPtz7OFcQMPiVfeWCw9fj0/Ty2Zx0Os
         0JCrN72l0Wxp2u7rFO5CXscnRx+6nAbO5FS8w4wInjrQlzppgacStQb3EZUN6OZHR+uX
         yCc4JS/FiRU/Q8XkJ424tACdSb/qzc2FphSYpr+VRI3c3wDmGUzh3fC/cqr+o0azZmTH
         PdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731336380; x=1731941180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuBjXOdgMWI3BuIwD303XNDgcqUxAXweoBqiSwzCoBg=;
        b=b+WJVT1c3X7C/+QB3WYCu2LpauFEIk9QqT6kijUlNesf83HtUQt82EFt83ZrqA33rC
         DJ/g1PsUHSgCo7AvGGZLNPxUGnQFyXuhr3gl6heZmll9GlXF/NZaOckn/yQ+fhY48K1b
         5f08ZslWPBKvbuVpC05zKNxt4WtOO/KeXszYb0lckkg9/Grws8m97uJO5hb3ED4JCmT9
         V8Y/MGkFWDhwbejsHN2SJpE62SlL5JQwZYnZWdYABrKI1p8IKnM1YBCEwzQ6OfAAs4Gh
         yeZdLMuCo0onZ28tguRukn0vzC+Byd0lkwg8xbRaFWxrJzafIDjSkSL5iyY6Ia05Vqs5
         kreg==
X-Forwarded-Encrypted: i=1; AJvYcCVGBA+ULP854TlSTWdohiqdLQiAGvp5GJAJM3VDyws0NC1s01YKmTi9xmjZ+nbE0P/f2FyMTWbsRsCNcaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8LX+n+8YSf4FQ4CQ1S7KEJtNwyYqX+VfHiDFW9nsHrZ6Sy9R
	63BgJ4Wuoizj79YHE78vJn/IhyjYddGn/LtA2WS5lnDm+QTQFh4FJab5BaEirCe3s+uKfUqTN65
	l1OMU6Nno0K3wPe4xtI5i3OlqU048QOUYVx5A
X-Google-Smtp-Source: AGHT+IHtSkbI5TN9NEyh4i69sExMuFBKZk46/8zghhMcwS5mYXDhpMaAhdiuGEKOMx1i5ec0vF2dtkGDnKuXtuAsqeI=
X-Received: by 2002:a05:6902:1023:b0:e29:2560:914c with SMTP id
 3f1490d57ef6-e337fdc0170mr10470151276.9.1731336380318; Mon, 11 Nov 2024
 06:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105184333.2305744-5-jthoughton@google.com>
 <202411061526.RAuCXKJh-lkp@intel.com> <CADrL8HU3KzDxrLsxD1+578zG6E__AjK3TMCfs-nQAnqFTZM2vQ@mail.gmail.com>
 <Zy6UefSlo8vwHxew@google.com>
In-Reply-To: <Zy6UefSlo8vwHxew@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 11 Nov 2024 09:45:44 -0500
Message-ID: <CADrL8HUY0qeDW+g0MPeBdYe9C7i0sXJN_gHVPX0nEeDRVbp-6Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] KVM: x86/mmu: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <lkp@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:45=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Nov 07, 2024, James Houghton wrote:
> > On Wed, Nov 6, 2024 at 3:22=E2=80=AFAM kernel test robot <lkp@intel.com=
> wrote:
> > >
> > > Hi James,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on a27e0515592ec9ca28e0d027f42568c47b314784]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton=
/KVM-Remove-kvm_handle_hva_range-helper-functions/20241106-025133
> > > base:   a27e0515592ec9ca28e0d027f42568c47b314784
> > > patch link:    https://lore.kernel.org/r/20241105184333.2305744-5-jth=
oughton%40google.com
> > > patch subject: [PATCH v8 04/11] KVM: x86/mmu: Relax locking for kvm_t=
est_age_gfn and kvm_age_gfn
> > > config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/2024=
1106/202411061526.RAuCXKJh-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20241106/202411061526.RAuCXKJh-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202411061526.RAuCXKJh=
-lkp@intel.com/
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    arch/x86/kvm/mmu/tdp_mmu.c: In function 'kvm_tdp_mmu_age_spte':
> > > >> arch/x86/kvm/mmu/tdp_mmu.c:1189:23: warning: ignoring return value=
 of '__tdp_mmu_set_spte_atomic' declared with attribute 'warn_unused_result=
' [-Wunused-result]
> > >     1189 |                 (void)__tdp_mmu_set_spte_atomic(iter, new_=
spte);
> > >          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> > >
> >
> > Well, I saw this compiler warning in my latest rebase and thought the
> > `(void)` would fix it. I guess the next best way to fix it would be to
> > assign to an `int __maybe_unused`. I'll do for a v9, or Sean if you're
> > going to take the series (maybe? :)), go ahead and apply whatever fix
> > you like.
>
> Heh, actually, the compiler is correct.  Ignoring the return value is a b=
ug.
> KVM should instead return immediately, as falling through to the tracepoi=
nt will
> log bogus information.  E.g. will show a !PRESENT SPTE, instead of whatev=
er the
> current SPTE actually is (iter->old_spte will have been updating to the c=
urrent
> value of the SPTE).
>
>         trace_kvm_tdp_mmu_spte_changed(iter->as_id, iter->gfn, iter->leve=
l,
>                                        iter->old_spte, new_spte);
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index f5b4f1060fff..cc8ae998b7c8 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1186,7 +1186,8 @@ static void kvm_tdp_mmu_age_spte(struct tdp_iter *i=
ter)
>                  * It is safe for the following cmpxchg to fail. Leave th=
e
>                  * Accessed bit set, as the spte is most likely young any=
way.
>                  */
> -               (void)__tdp_mmu_set_spte_atomic(iter, new_spte);
> +               if (__tdp_mmu_set_spte_atomic(iter, new_spte))
> +                       return;
>         }
>
>         trace_kvm_tdp_mmu_spte_changed(iter->as_id, iter->gfn, iter->leve=
l,
>

Oh yes, you're right. Thanks Sean! The diff LGTM.

