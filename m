Return-Path: <linux-kernel+bounces-267101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6C940C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E30B287EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738D193091;
	Tue, 30 Jul 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xno5jUba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D09194098;
	Tue, 30 Jul 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329521; cv=none; b=naA2jyMyEYi933VmtuV8a5RlejhNl6Ir/jv7rvq+3VV95Qtty+kOJ5vb9XtEE5QlqNLKypzQAzdmTvWtoOZ8lZP4ASIP9jW9LVIBprHDWukm/Wo+WikLsB2V4U/uWWIxHjlVCACzKES0Mgj2ULgdeGbiJMwvyjmS6JssxwdGLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329521; c=relaxed/simple;
	bh=mLIWRpXHk39LsbIfes1DXHI3y+srUmTV4y/dISbd/Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNQoaN+G9Dmihxt+pPs1J0uo93rOo5AtkRL9O8gXElw8t5ES8Dmcha4Yg6RXFhGUUBFglnmqEkATFY5X4rjvuroUR9PQInB0EpacPYUNUgzKNmcYSc2i8SN5O+AZt6AVyUp9BQelk8LGku4xA/ZsUjLBcL+4dCTdGoJQvTNnnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xno5jUba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1582C32782;
	Tue, 30 Jul 2024 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722329520;
	bh=mLIWRpXHk39LsbIfes1DXHI3y+srUmTV4y/dISbd/Hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xno5jUbagxBbgr+OlBiA9Ny7aUR4P1XqrORQ0klvSdCKousNkMCqDEo0jq9yiDw56
	 aCBZzN1Dgi0exEp2u3gKc3/D1VdhXnLwAtdoHYfbMgcC6iu78uaW0DKR9oWGu4Of9w
	 U6l5hveFaHiKit5RbVcz+3kIE23Jot4SUvSwce1wFd8h8VaeGhQNS+a5HYR7l4g5S8
	 BeAhuxi8EMIuIY0erTZ8DT069ut9kYCVjGxAM4fWV8OU2HXEA55fcw1tsHY36pQLhH
	 XRkgwyh6hwL15AEZQfIC5B6GxVIdIHsUCB7Ur18UCNQiUhjVYRTrGjivQcS9SvsY6/
	 U7I06Iv9kHHtA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so6391695a12.1;
        Tue, 30 Jul 2024 01:52:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDp/oqM2MMhQoRC6eSJajxy+XVYcr4dGGEdDV2qGDWHEOVpLzzJgTMdZrAo1IWbW+uaBkrc4FW521Rri5n0PM/Gm0/LCW1gREYcuVQkgNzAsFwdisBnBUzk8MoskPYG6Wbb+pJQHYQ
X-Gm-Message-State: AOJu0YzGqxE0XJSL+0nFKwRCRUSn5nk6jRXK0e997iaiQM1q68yZuSg8
	VmYVulU1UGnndQ9FY9S4xcucCKqtZHZZOjU/TJHnjre0lcZdjYQY80TbyJWGvAoxXjJHvqbzoQY
	cqBoGK8jVY80w7RRLdrFvOF4VtK8=
X-Google-Smtp-Source: AGHT+IHW+AU1W+r7xsiUOp1hBCSxb/mXz6j+yFu17KcOiySzFvfuqEaWjA5st56MFNvOvxgarVqBSgCTy4vncXn50V0=
X-Received: by 2002:a50:a68f:0:b0:59f:9f59:b034 with SMTP id
 4fb4d7f45d1cf-5b46ca2845cmr1192944a12.13.1722329519301; Tue, 30 Jul 2024
 01:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102443.12471-1-zhangtianyang@loongson.cn> <87o76kuqza.ffs@tglx>
In-Reply-To: <87o76kuqza.ffs@tglx>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 30 Jul 2024 16:51:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7c0Gtjf-6iS-E4nviMqmPWpJMNwvhWf0fLBx75pDXtrQ@mail.gmail.com>
Message-ID: <CAAhV-H7c0Gtjf-6iS-E4nviMqmPWpJMNwvhWf0fLBx75pDXtrQ@mail.gmail.com>
Subject: Re: [PATCH V7] LoongArch: Add AVEC irqchip support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net, alexs@kernel.org, 
	siyanteng@loongson.cn, kernel@xen0n.name, jiaxun.yang@flygoat.com, 
	gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn, 
	yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org, 
	dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site, 
	zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn, 
	zhoubinbin@loongson.cn, loongarch@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Fri, Jul 26, 2024 at 11:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Fri, Jul 26 2024 at 18:24, Tianyang Zhang wrote:
> > +static int avecintc_set_affinity(struct irq_data *data, const struct c=
pumask *dest,
> > +                                    bool force)
>
> Please align arguments according to documentation. In this case don't
> use a line break. Just use the full 100 character width all over the plac=
e
>
> > +{
> > +     unsigned int cpu, ret, vector;
> > +     unsigned long flags;
> > +     struct avecintc_data *adata;
>
> Please look for variable declarations in:
>
>        https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>
> and fix it up all over the place.
OK, thanks.

>
> > +
> > +     raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>
> This does not need irqsave because the function is always called with
> interrupts disabled.
OK, thanks.

>
> > +     adata =3D irq_data_get_irq_chip_data(data);
> > +
> > +     if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adat=
a->cpu, dest)) {
> > +             raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +             return 0;
> > +     }
> > +
> > +     if (adata->moving)
> > +             return -EBUSY;
>
> This leaks loongarch_avec.lock. Please use
>
>      scoped_guard(raw_spin_lock)(&loongarch_avec.lock);
OK, thanks.

>
> above so you spare all the unlocks and cannot miss one.
>
> > +     cpumask_and(&intersect_mask, dest, cpu_online_mask);
> > +
> > +     ret =3D irq_matrix_alloc(loongarch_avec.vector_matrix, &intersect=
_mask, false, &cpu);
> > +     if (ret < 0) {
> > +             raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +             return ret;
> > +     }
> > +
> > +     vector =3D ret;
> > +     adata->cpu =3D cpu;
> > +     adata->vec =3D vector;
> > +     per_cpu_ptr(irq_map, adata->cpu)[adata->vec] =3D irq_data_to_desc=
(data);
> > +     avecintc_sync(adata);
> > +
> > +     raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +     irq_data_update_effective_affinity(data, cpumask_of(cpu));
> > +
> > +     return IRQ_SET_MASK_OK;
> > +}
> > +
> > +static int avecintc_cpu_online(unsigned int cpu)
> > +{
> > +     unsigned long flags;
> > +
> > +     if (!loongarch_avec.vector_matrix)
> > +             return 0;
> > +
> > +     raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>
>   guard(raw_spin_lock)
>
> interrupts are disabled.
OK, thanks.

>
> > +     irq_matrix_online(loongarch_avec.vector_matrix);
> > +
> > +     pending_list_init(cpu);
> > +
> > +     raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static int avecintc_cpu_offline(unsigned int cpu)
> > +{
> > +     unsigned long flags;
> > +     struct pending_list *plist =3D per_cpu_ptr(&pending_list, cpu);
> > +
> > +     if (!loongarch_avec.vector_matrix)
> > +             return 0;
> > +
> > +     raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>
> Ditto.
>
> > +     if (list_empty(&plist->head))
> > +             irq_matrix_offline(loongarch_avec.vector_matrix);
> > +     else
> > +             pr_warn("CPU#%d advanced vector is busy\n", cpu);
>
> Seriously? You leave the matrix online so allocation can be made from an
> offline CPU?
Yes, we should always call irq_matrix_offline(loongarch_avec.vector_matrix)=
.

>
> > +     raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +void complete_irq_moving(void)
> > +{
> > +     struct pending_list *plist =3D this_cpu_ptr(&pending_list);
> > +     struct avecintc_data *adata, *tdata;
> > +     int cpu, vector, bias;
> > +     uint64_t isr;
> > +
> > +     raw_spin_lock(&loongarch_avec.lock);
>
>   guard()
>
> > +     list_for_each_entry_safe(adata, tdata, &plist->head, entry) {
> > +             cpu =3D adata->prev_cpu;
> > +             vector =3D adata->prev_vec;
> > +             bias =3D vector / VECTORS_PER_REG;
> > +             switch (bias) {
> > +             case 0:
> > +                     isr =3D csr_read64(LOONGARCH_CSR_ISR0);
> > +             case 1:
> > +                     isr =3D csr_read64(LOONGARCH_CSR_ISR1);
> > +             case 2:
> > +                     isr =3D csr_read64(LOONGARCH_CSR_ISR2);
> > +             case 3:
> > +                     isr =3D csr_read64(LOONGARCH_CSR_ISR3);
> > +             }
> > +
> > +             if (isr & (1UL << (vector % VECTORS_PER_REG))) {
> > +                     mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECTOR);
>
> Is it guaranteed that the device vector is handled _before_ the next
> IPI is handled? If not this is a live lock.
I have also concerned about this in an early version, at last Tianyang
confirmed it is OK.

>
> > +                     continue;
> > +             }
> > +             list_del(&adata->entry);
> > +             irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector=
, adata->managed);
> > +             this_cpu_write(irq_map[vector], NULL);
> > +             adata->prev_cpu =3D adata->cpu;
> > +             adata->prev_vec =3D adata->vec;
> > +             adata->moving =3D 0;
> > +     }
> > +
> > +     raw_spin_unlock(&loongarch_avec.lock);
> > +}
> > +#endif
> > +
> > +static void avecintc_compose_msi_msg(struct irq_data *d, struct msi_ms=
g *msg)
> > +{
> > +     struct avecintc_data *adata;
> > +
> > +     adata =3D irq_data_get_irq_chip_data(d);
>
> Move the assignement up to the declaration.
OK, thanks.

>
>
> > +     msg->address_hi =3D 0x0;
> > +     msg->address_lo =3D (msi_base_addr | (adata->vec & 0xff) << 4) |
> > +                       ((cpu_logical_map(adata->cpu & 0xffff)) << 12);
> > +     msg->data =3D 0x0;
> > +}
> > +
> > +static struct irq_chip avec_irq_controller =3D {
> > +     .name                   =3D "AVECINTC",
> > +     .irq_ack                =3D avecintc_ack_irq,
> > +     .irq_mask               =3D avecintc_mask_irq,
> > +     .irq_unmask             =3D avecintc_unmask_irq,
> > +#ifdef CONFIG_SMP
> > +     .irq_set_affinity       =3D avecintc_set_affinity,
> > +#endif
> > +     .irq_compose_msi_msg    =3D avecintc_compose_msi_msg,
> > +};
> > +
> > +static void avecintc_irq_dispatch(struct irq_desc *desc)
> > +{
> > +     unsigned long vector;
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     struct irq_desc *d;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while (true) {
> > +             vector =3D csr_read64(LOONGARCH_CSR_IRR);
> > +             if (vector & IRR_INVALID_MASK)
> > +                     break;
> > +
> > +             vector &=3D IRR_VECTOR_MASK;
> > +
> > +             d =3D this_cpu_read(irq_map[vector]);
> > +             if (d)
> > +                     generic_handle_irq_desc(d);
> > +             else {
>
> See bracket rules.
Do you mean even if there is only one statement in the if condition,
we still need to do like this?
if (xxx) {
    yyy;
} else {
    zzz;
}

>
> > +                     spurious_interrupt();
> > +                     pr_warn("Unexpected IRQ occurs on CPU#%d [vector =
%ld]\n", smp_processor_id(), vector);
> > +             }
>
> > +     }
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int avecintc_domain_alloc(struct irq_domain *domain,
> > +                              unsigned int virq, unsigned int nr_irqs,=
 void *arg)
> > +{
> > +     unsigned int cpu, i, ret;
> > +     unsigned long flags;
> > +     struct irq_data *irqd;
> > +     struct avecintc_data *adata;
> > +
> > +     raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>
>
>   guard(raw_spinlock_irqsave)(....);
OK, thanks.

>
> > +     for (i =3D 0; i < nr_irqs; i++) {
> > +             irqd =3D irq_domain_get_irq_data(domain, virq + i);
> > +             adata =3D kzalloc(sizeof(*adata), GFP_KERNEL);
> > +             if (!adata) {
> > +                     raw_spin_unlock_irqrestore(&loongarch_avec.lock, =
flags);
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             ret =3D irq_matrix_alloc(loongarch_avec.vector_matrix, cp=
u_online_mask, false, &cpu);
> > +             if (ret < 0) {
> > +                     raw_spin_unlock_irqrestore(&loongarch_avec.lock, =
flags);
> > +                     return ret;
> > +             }
> > +
> > +             adata->prev_cpu =3D adata->cpu =3D cpu;
> > +             adata->prev_vec =3D adata->vec =3D ret;
> > +             adata->managed =3D irqd_affinity_is_managed(irqd);
> > +             irq_domain_set_info(domain, virq + i, virq + i, &avec_irq=
_controller,
> > +                                 adata, handle_edge_irq, NULL, NULL);
> > +             adata->moving =3D 0;
>
> Initialize first before doing enything else.
OK, thanks.

>
> > +             irqd_set_single_target(irqd);
> > +             irqd_set_affinity_on_activate(irqd);
> > +
> > +             per_cpu_ptr(irq_map, adata->cpu)[adata->vec] =3D irq_data=
_to_desc(irqd);
> > +     }
> > +     raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static void clear_free_vector(struct irq_data *irqd)
> > +{
> > +     bool managed =3D irqd_affinity_is_managed(irqd);
> > +     struct avecintc_data *adata =3D irq_data_get_irq_chip_data(irqd);
> > +
> > +     per_cpu(irq_map, adata->cpu)[adata->vec] =3D NULL;
> > +     irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->=
vec, managed);
> > +     adata->cpu =3D 0;
>
> 0 is a valid CPU number, no?
Yes, UINT_MAX is better.

>
> > +     adata->vec =3D 0;
> > +
> > +#ifdef CONFIG_SMP
> > +     if (!adata->moving)
> > +             return;
> > +
> > +     per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] =3D NULL;
> > +     irq_matrix_free(loongarch_avec.vector_matrix,
> > +                     adata->prev_cpu, adata->prev_vec, adata->managed)=
;
> > +     adata->moving =3D 0;
> > +     adata->prev_vec =3D 0;
> > +     adata->prev_cpu =3D 0;
> > +     list_del_init(&adata->entry);
> > +#endif
> > +}
> > +
> > +static void avecintc_domain_free(struct irq_domain *domain,
> > +                              unsigned int virq, unsigned int nr_irqs)
> > +{
> > +     unsigned int i;
> > +     unsigned long flags;
> > +     struct irq_data *d;
> > +
> > +     raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>
> guard()
OK, thanks.

>
> > +     for (i =3D 0; i < nr_irqs; i++) {
> > +             d =3D irq_domain_get_irq_data(domain, virq + i);
> > +             if (d) {
> > +                     clear_free_vector(d);
> > +                     irq_domain_reset_irq_data(d);
> > +
> > +             }
> > +     }
> > +
> > +     raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> > +}
> > +
> > +static const struct irq_domain_ops avecintc_domain_ops =3D {
> > +     .alloc          =3D avecintc_domain_alloc,
> > +     .free           =3D avecintc_domain_free,
> > +};
> > +
> > +static int __init irq_matrix_init(void)
> > +{
> > +     int i;
> > +
> > +     loongarch_avec.vector_matrix =3D irq_alloc_matrix(NR_VECTORS, 0, =
NR_VECTORS - 1);
> > +     if (!loongarch_avec.vector_matrix)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < NR_LEGACY_VECTORS; i++)
> > +             irq_matrix_assign_system(loongarch_avec.vector_matrix, i,=
 false);
> > +
> > +     irq_matrix_online(loongarch_avec.vector_matrix);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init avecintc_init(struct irq_domain *parent)
> > +{
> > +     int ret, parent_irq;
> > +     unsigned long value;
> > +
> > +     raw_spin_lock_init(&loongarch_avec.lock);
> > +
> > +     loongarch_avec.fwnode =3D irq_domain_alloc_named_fwnode("AVECINTC=
");
> > +     if (!loongarch_avec.fwnode) {
> > +             pr_err("Unable to allocate domain handle\n");
> > +             ret =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     loongarch_avec.domain =3D irq_domain_create_tree(loongarch_avec.f=
wnode,
> > +                                                    &avecintc_domain_o=
ps, NULL);
> > +     if (!loongarch_avec.domain) {
> > +             pr_err("Unable to create IRQ domain\n");
> > +             ret =3D -ENOMEM;
> > +             goto out_free_handle;
> > +     }
> > +
> > +     parent_irq =3D irq_create_mapping(parent, INT_AVEC);
> > +     if (!parent_irq) {
> > +             pr_err("Failed to mapping hwirq\n");
> > +             ret =3D -EINVAL;
> > +             goto out_remove_domain;
> > +     }
> > +     irq_set_chained_handler_and_data(parent_irq, avecintc_irq_dispatc=
h, NULL);
> > +
> > +     ret =3D irq_matrix_init();
> > +     if (ret < 0) {
> > +             pr_err("Failed to init irq matrix\n");
> > +             goto out_free_matrix;
> > +     }
> > +#ifdef CONFIG_SMP
> > +     pending_list_init(0);
> > +     ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_AVECINTC_STARTING,
> > +                                     "irqchip/loongarch/avecintc:start=
ing",
> > +                                     avecintc_cpu_online, avecintc_cpu=
_offline);
> > +#endif
> > +     value =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> > +     value |=3D IOCSR_MISC_FUNC_AVEC_EN;
> > +     iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> > +
> > +     return ret;
> > +
> > +out_free_matrix:
> > +     kfree(loongarch_avec.vector_matrix);
>
> The code above just failed to allocate the matrix, so why are you trying
> to free it?
Yes, this is a mistake.

>
> And this happily fails to uninstall the chained handler.
>
> > +out_remove_domain:
> > +     irq_domain_remove(loongarch_avec.domain);
> > +out_free_handle:
> > +     irq_domain_free_fwnode(loongarch_avec.fwnode);
> > +out:
> > +     return ret;
> > +}
> > +
> > +static struct irq_chip pch_msi_irq_chip_v2 =3D {
> > +     .name                   =3D "PCH PCI MSI",
> > +     .irq_ack                =3D irq_chip_ack_parent,
> > +};
> > +
> > +static struct msi_domain_info pch_msi_domain_info_v2 =3D {
> > +     .flags  =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS =
|
> > +               MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> > +     .chip   =3D &pch_msi_irq_chip_v2,
> > +};
> > +
> > +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
> > +                                     struct acpi_madt_msi_pic *acpi_pc=
hmsi)
> > +{
> > +     struct irq_domain *msi_domain;
> > +
> > +     if (pch_msi_handle[0])
> > +             return 0;
> > +
> > +     pch_msi_handle[0] =3D irq_domain_alloc_fwnode(&acpi_pchmsi->msg_a=
ddress);
> > +     if (!pch_msi_handle[0]) {
> > +             pr_err("Unable to allocate domain handle\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     msi_domain =3D pci_msi_create_irq_domain(pch_msi_handle[0],
> > +                                            &pch_msi_domain_info_v2, p=
arent);
>
> Please don't do that. Convert this to use per device MSI domains.
OK, thanks. But it is better to split the conversion to another patch
(so we can convert both V1 and V2).

Huacai
>
> Thanks,
>
>         tglx

