Return-Path: <linux-kernel+bounces-218449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA490BFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7711C21A79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEAAA95E;
	Tue, 18 Jun 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqACPPX7"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816B4D8C1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668910; cv=none; b=HnT4SiNyP4iBPJkdwSf9/BQbPT11y9GPRwLg3uK/XyiXZXDb+HN/5qwcuYhyeha8zQjMAPNfgNGV8+V6LsBlLMWfeQDpQn1Tp6fTZvGgC8x8h2r6QRKlR+lVwCRzgsHLB+4tkj/bWE2vaibX7JRgZkfMyvdZfWlytlvLLNgUurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668910; c=relaxed/simple;
	bh=WsXnkl7kVUYze+FeKGmExkt9GJ8bPzG9K5cBRVrE94Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYKe5ZaU5gKjb9jMDbkoC6Tp5l1pAJ4vN2XlZeYYqtsc4jyEd3IZ6qsI40AsydmGCLV2EVnReO9ta3OMEhgtT1KjOUjbmONV6KURWP3XLeCgwv/nJFuv2TVSKqfXDZ5oZVANQfuMlRgpE071afL1KIJSCOu6k90bK/Ts1IsSzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqACPPX7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-443580f290dso67511cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718668908; x=1719273708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szeTbx+n4i/RQE7ZeuWhiCumzoRR7Ut1YseLs3KbJhQ=;
        b=LqACPPX7taB8wao5TU2wDvxyePHktsw1vqMDPHKfrMc47roqxlrVwRAzmjj1IVRGiq
         8V74Kmp29+vQIqFQZoiyBa1Fj5HY8llC+vnw6gEac9WLDIqNx34L8RR4LXE9OOcQ1yOU
         vi7kYDb0mHWckOe66R3hmFGtinLmc7QPXIX7yo1F8o7wXCsZLsNuozE1AuplSN1NPhHy
         rNXySMFsdZPS6KmVKJF8a/C5hGPjDNQDWnAqcSWYAXYt6CmO0q/sX/UHOg345S9f3dxC
         tVx1qpVLp45gpzOvqKo5keZAINa08NJXwqLfHScFDduIAaYfEcN0avu0fhRW9zaQ32IZ
         cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718668908; x=1719273708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szeTbx+n4i/RQE7ZeuWhiCumzoRR7Ut1YseLs3KbJhQ=;
        b=i19Guv0fx6QoAjS3dC8iBK6GdIZmB+0N8RjyzCOmzaqDJVcqItMS78ASWKBZfO/6Yb
         +1a71uUBeVkFL8FsBNqDhHx8ZZ3OXTUP3JPg7jljz6jZj40qOmGJqNSQx0HZyOztbQo7
         x8ElgdGxM3CRu9Myo7YUvOPdZqEa5pYnohR1k9AXcMSFoJtscl0dRxYMoROGZTuwtj3H
         trt2kpLLIKETSbTjktp9lSlGfKUz1b+s5fg86BVGa9wb2QdSdhcp2zXDf18RqvD/qiNM
         KIxQt3Sv9RAxq1FUTAbkOfkYl8TAjqqrMUxv+6V/nUeC1bZRRxsSHMe13u2/PP7Zg/7k
         xquQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV7uG/oSmnLpPmXvqGzO8XFdbDxQ9wc1/7WXi4K+JrXlnNTqnfLlVexj5xB3m9bpKx8gtnANmkN3y4C9zmu4Dui4zpBXHlHEQlz3ys
X-Gm-Message-State: AOJu0Yw+byaPP8peRPy73LxHauDHQqfJYysZ/3KUgRACwnfmvuVmWx0Y
	noDNc+fVX/9pBhp5gT55RHfzwh7xiL6+FdGimjY7dP3qyS2HiQUxFEc8AGqdmK+YjLjK/1ZVa17
	Y5r44xNdyFyBggpNAkhEcZyBvZhWZBw0yacTX
X-Google-Smtp-Source: AGHT+IGHzkobBDc6M3yopcf16QeXn++VzvN+NTr0crpz0Mygnf9RbsKFdcd1bMRE+npFHMvEgbm3YMfrR8FegyixQZ4=
X-Received: by 2002:a05:622a:1309:b0:43f:bba6:3759 with SMTP id
 d75a77b69052e-4449c68d727mr1309401cf.10.1718668907696; Mon, 17 Jun 2024
 17:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613082345.132336-1-shahuang@redhat.com> <20240613082345.132336-4-shahuang@redhat.com>
In-Reply-To: <20240613082345.132336-4-shahuang@redhat.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 17 Jun 2024 17:01:36 -0700
Message-ID: <CAJHc60xpGAA1pmz0ad_Fq3a5M-pQMiyxQ4hdNhc6vQrgpSjGww@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] KVM: selftests: aarch64: Add invalid filter test
 in pmu_event_filter_test
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shaoqin,

On Thu, Jun 13, 2024 at 1:27=E2=80=AFAM Shaoqin Huang <shahuang@redhat.com>=
 wrote:
>
> Add the invalid filter test which sets the filter beyond the event
> space and sets the invalid action to double check if the
> KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  .../kvm/aarch64/pmu_event_filter_test.c       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c =
b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> index fb0fde1ed436..13b2f354c39b 100644
> --- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -8,6 +8,7 @@
>   * This test checks if the guest only see the limited pmu event that use=
rspace
>   * sets, if the guest can use those events which user allow, and if the =
guest
>   * can't use those events which user deny.
> + * It also checks that setting invalid filter ranges return the expected=
 error.
>   * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILT=
ER
>   * is supported on the host.
>   */
> @@ -178,6 +179,40 @@ static void destroy_vpmu_vm(void)
>         kvm_vm_free(vpmu_vm.vm);
>  }
>
> +static void test_invalid_filter(void)
> +{
> +       struct kvm_pmu_event_filter invalid;
> +       int ret;
> +
> +       pr_info("Test: test_invalid_filter\n");
> +
> +       memset(&vpmu_vm, 0, sizeof(vpmu_vm));
> +
> +       vpmu_vm.vm =3D vm_create(1);
> +       vpmu_vm.vcpu =3D vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code)=
;
> +       vpmu_vm.gic_fd =3D vgic_v3_setup(vpmu_vm.vm, 1, 64);
> +       __TEST_REQUIRE(vpmu_vm.gic_fd >=3D 0,
> +                      "Failed to create vgic-v3, skipping");
> +
> +       /* The max event number is (1 << 16), set a range largeer than it=
. */
nit: s/largeer/larger

Also, perhaps not in this series, but we can also check for -EBUSY
situations such as setting a (valid) filter after
KVM_ARM_VCPU_PMU_V3_INIT and after the vCPUs have started.

Besides that, Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

- Raghavendra



> +       invalid =3D __DEFINE_FILTER(BIT(15), BIT(15) + 1, 0);
> +       ret =3D __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_=
V3_CTRL,
> +                                   KVM_ARM_VCPU_PMU_V3_FILTER, &invalid)=
;
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL, "Set Invalid filter range=
 "
> +                   "ret =3D %d, errno =3D %d (expected ret =3D -1, errno=
 =3D EINVAL)",
> +                   ret, errno);
> +
> +       /* Set the Invalid action. */
> +       invalid =3D __DEFINE_FILTER(0, 1, 3);
> +       ret =3D __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_=
V3_CTRL,
> +                                   KVM_ARM_VCPU_PMU_V3_FILTER, &invalid)=
;
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL, "Set Invalid filter actio=
n "
> +                   "ret =3D %d, errno =3D %d (expected ret =3D -1, errno=
 =3D EINVAL)",
> +                   ret, errno);
> +
> +       destroy_vpmu_vm();
> +}
> +
>  static void run_test(struct test_desc *t)
>  {
>         pr_info("Test: %s\n", t->name);
> @@ -300,4 +335,6 @@ int main(void)
>         TEST_REQUIRE(kvm_pmu_support_events());
>
>         run_tests();
> +
> +       test_invalid_filter();
>  }
> --
> 2.40.1
>
>

