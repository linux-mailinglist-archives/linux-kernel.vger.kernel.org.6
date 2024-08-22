Return-Path: <linux-kernel+bounces-297189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2321195B450
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD441F24449
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D73D1C9429;
	Thu, 22 Aug 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul3rSUPR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF21C93D3;
	Thu, 22 Aug 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327609; cv=none; b=jECcpnszSuHxfmZi3SVnmeWZxGkV5oP0Do4a/cFA9keXcThI6e2HQuG6kOnuB/jY5uP83rZDJyjWyq09beEZnxN4hKzCj7VgmD1CQojLPGNwL9FE24Ay59DhxmGHoGDYyWTv40GW3cAwZOUG/hdD+EDoe3SWU/PNCcHgSIurfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327609; c=relaxed/simple;
	bh=kq7HkHLVZBMwOV2O6R4WSTN1EqJabyZVI07suXmSc/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dka6asmMN3Oeb33OQUbMdbib0C9Ix7h8tUm6emWvdRjRYf980JpHOeOxJWGJyfydSb02S0hybas+dE4OcFu0hvjDa3zM5TLsMY1ia+KQzDAW4/meS4/CbWEAYzZ0JCm0JplNejVuPgZ6XStqswNqxo8Rr1/jmb19ItgqM1Y/qUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul3rSUPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAFEC4AF15;
	Thu, 22 Aug 2024 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724327609;
	bh=kq7HkHLVZBMwOV2O6R4WSTN1EqJabyZVI07suXmSc/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ul3rSUPR4uSrgVCuvGaIreY6oyMJ/Iz4VzpHxjoReDMlSD+PLQVdRNPenprp0tyM+
	 4PRW8E/bclapaO9ix2LZuUdzKztIKXAye54ae/WOl+V3WGll8vExjfsMY6ld9f5xiP
	 RNs2MKiYVZfN0l3rTwjAy95XdwrKMJN1aj8bayH5ZkPMapxVlWPyXXpZv8f+5KBFoD
	 uTIEcbM6S9Zu16mx6DTqR1xUhZjlzTpvAu2xdhoTvtSsABezKtyg2rPwi+zKX9Ci3N
	 Qe3YxcB7ElTJkjnryLwRsO1yATHrhDrx1URUwiyCFJK4FZhM4tz8j58y4Zv0qrRbHX
	 6So7WpOesArfQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so760970a12.3;
        Thu, 22 Aug 2024 04:53:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyPbMWPh08oni4HZRJCsMKTcFXU3O+cL4pgZDG2nSyCR7VlxKPvQs1HaVfiJXyRv97RbxGsRMxfv6/H/PX@vger.kernel.org, AJvYcCVuMkaLm91tKoV7FZoKQGFLVaFBZb/uo34bb3t6apbo/jOLJdgCQiPWVV2Wnzq6XeKdkrcOGebSCeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAh2DJE0gl4EUeBD+ktrLk8sTS7mOiKO4cW/auK+czTh1NJQJ
	sbXXB/NyrHcL64rEgNVKpTf1osMlSd6kqOtSqAlU1sM0vq01Zyh5GdvbDBdiAhDktI/k+sqelPm
	0nR5sNKvPcY3Dqls9zY4jWK60R+o=
X-Google-Smtp-Source: AGHT+IGuBOo9QhUzweuJTGry2O7SAHfVgztCGpD9T8pktDrHaSIOc8XLNCru4hE14bswILF0Fq3qHz1KAL0u5zAQmJM=
X-Received: by 2002:a05:6402:13ca:b0:5bb:9b09:8c7e with SMTP id
 4fb4d7f45d1cf-5c07928f58amr1133235a12.26.1724327607686; Thu, 22 Aug 2024
 04:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815112608.26925-1-zhangtianyang@loongson.cn>
 <20240815112608.26925-3-zhangtianyang@loongson.cn> <87msl7jgye.ffs@tglx>
 <CAAhV-H424SB_Ff6y4m4Cb7Cx9eWTLbK08Wycwa803y08qWVoOA@mail.gmail.com> <87cym2hrqz.ffs@tglx>
In-Reply-To: <87cym2hrqz.ffs@tglx>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 22 Aug 2024 19:53:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4umZBXAugRm45=dewiTGjpDSJf2wnjCtkakk+xG3VLHg@mail.gmail.com>
Message-ID: <CAAhV-H4umZBXAugRm45=dewiTGjpDSJf2wnjCtkakk+xG3VLHg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net, alexs@kernel.org, 
	kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn, 
	wangliupu@loongson.cn, lvjianmin@loongson.cn, yijun@loongson.cn, 
	mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org, 
	maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn, 
	nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn, 
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Aug 21 2024 at 21:14, Huacai Chen wrote:
> > On Wed, Aug 21, 2024 at 12:29=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> This patch is doing too many things at once and is absolutely not
> >> reviewable.
> >>
> >> Please split it up into the obvious bits and pieces:
> > Splitting may cause another problem: some patches will get upstream
> > via the arch tree and others via the irq tree. These dependencies may
> > cause build errors in a certain tree. But anyway, we will try our best
> > to do this.
>
> That's not a problem at all. The trivial way to solve this is to apply
> the architecture changes to the loongarch tree in a separate branch
> which is based of some -rcX tag and only contains those dependencies.
> That branch is then merged into the main loongarch branch and I can pull
> it in to my tree for adding the irqchip changes. No conflicts, no merge
> dependencies, nothing.
Emm, another way is apply all patches to the irq tree with my Acked-by.


>
> >>       #ifdef CONFIG_IRQ_LOONGARCH_AVEC
> >>       # define SMP_CLEAR_VECTOR         BIT(ACTION_CLEAR_VECTOR)
> >>       #else
> >>       # define SMP_CLEAR_VECTOR         (0)
> >>       #endif
> >>
> >>       That way the compiler will optimize out stuff like the
> >>       SMP_CLEAR_VECTOR handling and you only need the prototype of
> >>       complete_irq_moving(), but no implementation.
> > These macros are not in hot-path, and we have already tried our best
> > to avoid using #ifdefs for cpu_has_xxx, so I suggest not introduce a
> > new Kconfig option. Moreover, the new option should always be selected
> > due to the deep coupling among loongson's irqchips, which makes the
> > #ifdefs useless.
>
> They are removed in step 8 again. It's for having a sanely split up and
> structured patch series instead of one big lump.
I see, but I'm trying another splitting way to avoid
adding-and-then-removing, of course it should also make reviews easy.

>
> >> > +static void clear_free_vector(struct irq_data *irqd)
> >> > +{
> >> > +     struct avecintc_data *adata =3D irq_data_get_irq_chip_data(irq=
d);
> >> > +     bool managed =3D irqd_affinity_is_managed(irqd);
> >>
> >> Don't even try. Your managed support is broken at the allocation side
> >> and at several other places.
> > I'm a bit confused here, irq_create_affinity_masks() marks some
> > interrupts "managed". So if we completely ignore "managed" here, then
> > can irq_create_affinity_masks() still work? Or the two has nothing to
> > do with each other?
>
> Managed interrupts have the property that the core and irqchip code
> guarantees the interrupts to be affinable to the CPU masks which are
> handed in to the allocator for them.
>
> So the requirement for architectures which have a limited number of
> vectors per CPU (x86, loongarch) is that you have to reserve the managed
> vectors right at allocation time.
>
> x86_vector_alloc_irqs()
>     assign_irq_vector_policy()
>         if (managed)
>             reserve_managed_vector()
>                irq_matrix_reserve_managed(mask)
>
> irq_matrix_reserve_managed() then reserves a vector on all CPUs which
> are in the affinity mask.
>
> On activation:
>
> x86_vector_activate()
>    if (managed)
>       activate_managed()
>         assign_managed_vector(mask)
>            irq_matrix_alloc_managed(mask)
>
> irq_matrix_alloc_managed() then picks an unassigned vector out of the
> managed vector space. Similar mechanism when the affinity is set.
>
> Why is this important for x86 (and loongarch)?
>
> Because both have a limited vector space of 256 vectors per CPU, where
> some of the vectors might be reserved for exceptions and OS purposes or
> the legacy space.
>
> The managed mechanism guarantees at allocation time that the interrupt
> will have a reserved vector on all CPUs in the mask. That ensures that
> on CPU hotplug the interrupt can be migrated over to a still online CPU
> in the mask. If the last CPU goes offline the interrupt is shut down.
>
> You might not yet have run into the situation of vector exhaustion, but
> once your number of CPUs gets big enough that is guaranteed to happen.
>
> That's why x86 also uses the concept of reserved (not guaranteed)
> regular vectors for non-managed interrupts. x86 uses the spurious vector
> for that. That's important because there are enough device drivers out
> there which allocate a gazillion of interrupts at probe time, but only
> request a few of them.
>
> If you allocate all vectors for them right upfront, then you exhaust
> your vector space quickly for no reason. Only when the interrupt is
> requested then a usable vector is allocated - or the allocation fails
> and request_irq() fails. That's better than exhausting the vector space
> for nothing.
>
> The complexity of the x86 allocation/activate/set_affinity mechanisms
> is there for a reason and not just because we did not have anything
> better to do. :)
Frankly, I haven't absorbed everything here, but I think I can try to
answer my question "can irq_create_affinity_masks() still work".

irq_create_affinity_masks() can still mark interrupts "managed" if
avecintc driver doesn't support "managed", but it cannot guarantee
that set_affinity can always succeed. If the destination cpu has a
free vector, then set_affinity succeeds, otherwise it will fail. But
if avecintc driver supports "managed", set_affinity can always
succeed, because the destination cpu has already reserved a vector for
this. Am I right?

Huacai

>
> Thanks,
>
>         tglx

