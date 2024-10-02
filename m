Return-Path: <linux-kernel+bounces-347945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB46698E086
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CC11F2610F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808391D151B;
	Wed,  2 Oct 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOuwqF03"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5A1D14EF
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885870; cv=none; b=OBHeWu98m9q9fFUYUd4ESvl9efmr06fgQN6Uuy6suB/lPc1WKZf7wcWITQakgJD4a86s6hJMl8mfwYgcgfsOx43iISch+zLDc0fS+dHy9WQrjL7g7KYifaDJvbaipH6Zv+shF26l8fBhXNH4Hz70sjoCniV8vAZlDKE+UYFYYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885870; c=relaxed/simple;
	bh=dJPiSQMtzoT6qmJD4ZlMBa33FRAvvOCW0QW5w3VD/sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoKQtTERUQatT1EVSrj16USa2LhvtTQUjhEdU00ZxrdjLQecdYP+765QB1SCBriFSSCvtrWWFly2WLxDb7ao05+S4XIsbB/7js7WYQp9GMxLhos2nuxub58/QWMmAop5cTM1NhJ1emYj33Y65kSt2g0mqz95Y2WoUeb0mbemEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOuwqF03; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-536552fcc07so24121e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727885866; x=1728490666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARJcCMXQ+rp7186iuswXniuSA2NCVjCtv9/VFdXLQe8=;
        b=zOuwqF03EUdfGKL2IwAeXK63uplYHZq6a1xM7SbsjMqIagCuxEUk5ya3n8NWqAK1mF
         hEDmZkLW+QF4HFnyPw0/qCPh1aIIA8BhQjM6UtO0HTkhTcB2v9FcrXNmV0upVGw4Uvb7
         2fCP2RepZcNktFY42T/XJuhEYB0f5Z/whxGDeHIeSCvlQCxXxvOIDj5o1uoK2L+JGP+m
         sEJYOdm1Q7U7CS8Mc3B1ED3UxW3LgaivyYFLyHWrMOLf8+BvgsbUDAZpEsDxslax1Gki
         DQHcdMg07JhEJfkm/4uYVrptg9mh/0XpBsKTSyrdm+r8/4DeEvIdcnSGXAxmorq40U3A
         9pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727885866; x=1728490666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARJcCMXQ+rp7186iuswXniuSA2NCVjCtv9/VFdXLQe8=;
        b=J4ZxqM499c9DKC/EmNavRit7+NxDU4taH5O83QtaqH+yuVxHtBROZQmhq5V/rzMIGs
         aGio6ctNcthlglmAVP9utaw80JYVH0ePev1FEHttTBhH/+PSfuUouDV7D0V9ZyHK7bFc
         k0CVTrBtMgd1Z6R3plDHwWhwmpLoBKtynlaZBDYU+tD+4XmAycYyYpr+5jG2e1NzEHgW
         0ddT0ouawgcNhJN+oIocU9PD8Q23AI9VYQ5g4jglMd/kBdesL2JBXwig1cghxVvK6rTj
         aFem3LvEda3mPhe1Azene1kZ9Sm4gGmPhfBAJGmirECXo8Frlz7oVZB601UiosmPVlFu
         qEGA==
X-Forwarded-Encrypted: i=1; AJvYcCWyYdG395VOhg7dOwLno4DI/pphXrScj5XM/1lLsA859aGsDmCYzEKgFGbuYUq1Q0M+CToOEdVIefOqcsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAHz2Nlm8PF+JQT/qnzFwrM7qDCOJmj0bH054+OCrrTmMGNxe
	9Qbm1ZJx6mfOVZQOUwKf2F4z61v/OgOmkNAnQ6THy7L7wYaovaYjAt7mWegFk6RrJ3PdouUeGpR
	RDwZfm2Pjt7jjYap7KXZxS9SAOpiq6DRWiubO
X-Google-Smtp-Source: AGHT+IGsxRWz32UOeReGn8kkna8PcZY9fOYXyW+STw1/2gSLimHMsKPUTudsdcadk2EE8gUZlftzea8kLqZb40eMbVU=
X-Received: by 2002:a05:6512:402a:b0:539:9f44:db7b with SMTP id
 2adb3069b0e04-539a1f6d772mr398247e87.1.1727885865603; Wed, 02 Oct 2024
 09:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913214316.1945951-1-vipinsh@google.com> <20240913214316.1945951-3-vipinsh@google.com>
 <Zvx02r8XjllG7oI_@google.com>
In-Reply-To: <Zvx02r8XjllG7oI_@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Wed, 2 Oct 2024 09:17:06 -0700
Message-ID: <CAHVum0eCmr=YJSvt1CjhS=dz8dTkF6vkJPmm2eyqhQaq+aWVVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Use MMU shrinker to shrink KVM MMU
 memory caches
To: David Matlack <dmatlack@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, zhi.wang.linux@gmail.com, 
	weijiang.yang@intel.com, mizhang@google.com, liangchen.linux@gmail.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:17=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2024-09-13 02:43 PM, Vipin Sharma wrote:
> > @@ -6997,13 +7007,50 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *=
kvm, u64 gen)
> >  static unsigned long mmu_shrink_scan(struct shrinker *shrink,
> >                                    struct shrink_control *sc)
> >  {
> > -     return SHRINK_STOP;
> > +     struct kvm *kvm, *next_kvm, *first_kvm =3D NULL;
> > +     unsigned long i, freed =3D 0;
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     mutex_lock(&kvm_lock);
> > +     list_for_each_entry_safe(kvm, next_kvm, &vm_list, vm_list) {
> > +             if (!first_kvm)
> > +                     first_kvm =3D kvm;
> > +             else if (first_kvm =3D=3D kvm)
> > +                     break;
> > +
> > +             list_move_tail(&kvm->vm_list, &vm_list);
> > +
> > +             kvm_for_each_vcpu(i, vcpu, kvm) {
> > +                     if (!mutex_trylock(&vcpu->arch.mmu_memory_cache_l=
ock))
> > +                             continue;
> > +                     freed +=3D kvm_mmu_empty_memory_cache(&vcpu->arch=
.mmu_shadow_page_cache);
> > +                     freed +=3D kvm_mmu_empty_memory_cache(&vcpu->arch=
.mmu_shadowed_info_cache);
> > +                     mutex_unlock(&vcpu->arch.mmu_memory_cache_lock);
> > +                     if (freed >=3D sc->nr_to_scan)
> > +                             goto out;
>
> Looking at the caller in mm/shrinker.c, sc->nr_to_scan will be <=3D 128
> (SHRINK_BATCH), which is only enough for 2 vCPUs. So I think the
> shrinker will only ever free 2 vCPU caches of each VM (probably the
> first 2 vCPUs) before reordering the list and moving onto the next VM on
> the next call.
>
> Does that match the behavior you observe?
>
Yes, for dropping cache one time on a big VM, I get multiple calls of
mmu_shrink_scan() where sc->nr_to_scan is at max 128 in each call.

mmu_memory_cache_lock availability will play a role in selecting the
two vCPUs. On a VM where not much faults are happening it will
probably be the first two vCPUs.

