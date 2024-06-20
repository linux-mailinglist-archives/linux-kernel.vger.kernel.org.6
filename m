Return-Path: <linux-kernel+bounces-223629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F59115BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7061282107
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1779513DDAE;
	Thu, 20 Jun 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldaDGIyB"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752A78C8E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922634; cv=none; b=LwS2EgW0Nj1HWVVRxkB4NSJ2nIRl39Gm7uknowtHJ7Ge/TCNoWuoPGPI3owO0H5YDOeJKZAlpv4thwx1KoWg32dg+Z8DIk2TmuyQh9UK/eKr7uRfyAKQNfNpl/UZWB6Wy/0SGQIS1WvjvgrlDl+7phfm6o8yUtXkL4ykP6HduY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922634; c=relaxed/simple;
	bh=qU/CK7cK2ztIubEiOnDLG3FhSQGWI8q05/wnLRMya7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UinFUfYzkiFrRh8WPdqaUlAValQ2KMBjyWcnnre/bT6Dg4IYxF1m1Jlk9iukiUFPvJ+fxbdgJUz5z8KnOQi1cuqNOk95a8DYwRcyU2OMyHZ5hnLY2xSWTFy0eT4HfLfKUiExQ8Nfht6HWDfIICfIU7gbZN0CIBI4VtljbspakmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldaDGIyB; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so17625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718922631; x=1719527431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHREBPCUIs8n+I6KtcDeDKXi3C09zaSei5HzCaoQhXU=;
        b=ldaDGIyBvF6wDNkosaJ+hgro8FvJeadsCQP3rIOCRZ9OZ36+IkbsIKQpOdnwh3ou8G
         syTScZJIW/zBzuSHM3SGawhMcpw8+f0ppw8zLQ+gbFWFFJPNz627hT/dq/nuA+d5eGs7
         +93+UDvrEbbRqx/bWooE0skUu9ENoFEsIqlH7+JkABeb9t9VXhtRjCpqjUyxu82f/Y1D
         02erSUOoki57n3Yk/pYxqUXb55Ine+PnZnxeUuEB6+DqoHdQnt6a6/xHcV6pJ9HbBM9r
         jBzuAX+ZghWUtK3bpYdO/rfAn3t7xS/fe9luRyb1oEDsNhAue5aX6Z6+3GQ6hH2PYHKi
         vPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922631; x=1719527431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHREBPCUIs8n+I6KtcDeDKXi3C09zaSei5HzCaoQhXU=;
        b=nvL69tYqKDJlv+EebEdqYtSNEcXv5p01/3KqwHo0RkVT7xNgvM9OL18Vx+KDe7DFWd
         UKAPewrHZKsXyo8+Su1tC9gpMOGUrO21fpXXZiF8ju5H2Mu2HRrYkv+GWYg6bxFQZ2PV
         iberdw21OXKIGESbJOX1BTGO9IOhdpBcsPUxLJGspqU9erEgmX2g7hMCcMAH9GEn0jlZ
         UHZl3C2luEcrUCFvM/ql/0AxQSx7qZ0yRUbUV7r6MPySMgYgWGAQcx4PVuT5VuJvlpWk
         CLhpcnm4PJqbqTW9wYFdEYlUOchzti7AV1QXZ/helq+V3gPwA5/Z9eOxI1uXomJACf9o
         GawQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDYoBrYhVvbqzavtX9ITTorqTxLuDWY9mRwH3M01VwjjNPP8Vcu6/oq4VlPqXed96BTrNPxHA3Pf657OAymF8bwyPGnokbeC/i8in
X-Gm-Message-State: AOJu0YzbbZWD1LzTgQIVDGj3MiUDpdOX9xkY8sL05t7IR0OMKb1ubvhr
	qMUe0G6f4SZVwJJE9MxpQcQRPGJMyG/lDX57n9QNAIoqyA+1krFZOWIP4zzit6Be4CX4UyoMZst
	+4WTHq2tDk/VMKor+AYcqLemR9Get0rVJGIrS
X-Google-Smtp-Source: AGHT+IG3QZzSrTWr7FqOD3AtuM1SKP3sfyODhN7mg13aomMD50DF/jtHQSYwrOACQW7sSeuYOA45Mb+PEMZtdzwhpq8=
X-Received: by 2002:a92:dc10:0:b0:375:9e2b:a832 with SMTP id
 e9e14a558f8ab-3762f4f3869mr453635ab.21.1718922630941; Thu, 20 Jun 2024
 15:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619083200.1047073-1-shahuang@redhat.com> <20240619083200.1047073-2-shahuang@redhat.com>
In-Reply-To: <20240619083200.1047073-2-shahuang@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 20 Jun 2024 15:30:18 -0700
Message-ID: <CAJHc60zNNsaALEV6XPdwuTZo1_0y2dT--MLMad0ar5Htt8jCtQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] KVM: selftests: aarch64: Add helper function for
 the vpmu vcpu creation
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shaoqin

On Wed, Jun 19, 2024 at 1:32=E2=80=AFAM Shaoqin Huang <shahuang@redhat.com>=
 wrote:
>
> Create a vcpu with vpmu would be a common requirement for the vpmu test,
> so add the helper function for the vpmu vcpu creation. And use those
> helper function in the vpmu_counter_access.c test.
>
> Use this chance to delete the meaningless ASSERT about the pmuver,
> because KVM does not advertise an IMP_DEF PMU to guests.
>
> No functional changes intended.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/vpmu_counter_access.c         | 32 ++++---------------
>  .../selftests/kvm/include/aarch64/vpmu.h      | 28 ++++++++++++++++
>  2 files changed, 34 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
>
> diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/=
tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> index d31b9f64ba14..68da44198719 100644
> --- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> +++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
> @@ -16,6 +16,7 @@
>  #include <processor.h>
>  #include <test_util.h>
>  #include <vgic.h>
> +#include <vpmu.h>
>  #include <perf/arm_pmuv3.h>
>  #include <linux/bitfield.h>
>
> @@ -407,18 +408,8 @@ static void guest_code(uint64_t expected_pmcr_n)
>  /* Create a VM that has one vCPU with PMUv3 configured. */
>  static void create_vpmu_vm(void *guest_code)
>  {
> -       struct kvm_vcpu_init init;
> -       uint8_t pmuver, ec;
> -       uint64_t dfr0, irq =3D 23;
> -       struct kvm_device_attr irq_attr =3D {
> -               .group =3D KVM_ARM_VCPU_PMU_V3_CTRL,
> -               .attr =3D KVM_ARM_VCPU_PMU_V3_IRQ,
> -               .addr =3D (uint64_t)&irq,
> -       };
> -       struct kvm_device_attr init_attr =3D {
> -               .group =3D KVM_ARM_VCPU_PMU_V3_CTRL,
> -               .attr =3D KVM_ARM_VCPU_PMU_V3_INIT,
> -       };
> +       uint8_t ec;
> +       uint64_t irq =3D 23;
>
>         /* The test creates the vpmu_vm multiple times. Ensure a clean st=
ate */
>         memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> @@ -430,26 +421,15 @@ static void create_vpmu_vm(void *guest_code)
>                                         guest_sync_handler);
>         }
>
> -       /* Create vCPU with PMUv3 */
> -       vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
> -       init.features[0] |=3D (1 << KVM_ARM_VCPU_PMU_V3);
> -       vpmu_vm.vcpu =3D aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_cod=
e);
> +       vpmu_vm.vcpu =3D vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code)=
;
>         vcpu_init_descriptor_tables(vpmu_vm.vcpu);
>         vpmu_vm.gic_fd =3D vgic_v3_setup(vpmu_vm.vm, 1, 64);
>         __TEST_REQUIRE(vpmu_vm.gic_fd >=3D 0,
>                        "Failed to create vgic-v3, skipping");
>
> -       /* Make sure that PMUv3 support is indicated in the ID register *=
/
> -       vcpu_get_reg(vpmu_vm.vcpu,
> -                    KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
> -       pmuver =3D FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), =
dfr0);
> -       TEST_ASSERT(pmuver !=3D ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
> -                   pmuver >=3D ID_AA64DFR0_EL1_PMUVer_IMP,
> -                   "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pm=
uver);
> -
>         /* Initialize vPMU */
> -       vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
> -       vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
> +       vpmu_set_irq(vpmu_vm.vcpu, irq);
> +       vpmu_init(vpmu_vm.vcpu);
>  }
>
>  static void destroy_vpmu_vm(void)
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/t=
esting/selftests/kvm/include/aarch64/vpmu.h
> new file mode 100644
> index 000000000000..5ef6cb011e41
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <kvm_util.h>
> +
> +static inline struct kvm_vcpu *vm_vcpu_add_with_vpmu(struct kvm_vm *vm,
> +                                                    uint32_t vcpu_id,
> +                                                    void *guest_code)
> +{
> +       struct kvm_vcpu_init init;
> +
> +       /* Create vCPU with PMUv3 */
> +       vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> +       init.features[0] |=3D (1 << KVM_ARM_VCPU_PMU_V3);
> +
> +       return aarch64_vcpu_add(vm, 0, &init, guest_code);
> +}
> +
> +static void vpmu_set_irq(struct kvm_vcpu *vcpu, int irq)
> +{
> +       kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                           KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
> +}
> +
> +static void vpmu_init(struct kvm_vcpu *vcpu)
> +{
> +       kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
> +                           KVM_ARM_VCPU_PMU_V3_INIT, NULL);
> +}
> --
> 2.40.1
>
>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

- Raghavendra

