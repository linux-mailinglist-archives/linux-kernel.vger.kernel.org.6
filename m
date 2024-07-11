Return-Path: <linux-kernel+bounces-249467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5EB92EC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9322863F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F516CD06;
	Thu, 11 Jul 2024 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmGmv9bQ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2C16B72E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713444; cv=none; b=gbng66JvoSEUftNtxnZ9jtAsoIIpVJIMFgoswPTSvFNwHoChGbfpO4umZJEMVZQSB7Uu1Q0XMBIXd7FPLbkEMrA8wnu6zJP+VoNN46Se85g0ERZ/gMXzYV0tiC0I7FuHeZojFA/AC0i3uiJRess63NnxhqFh2VIHVh4jDUms5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713444; c=relaxed/simple;
	bh=omvGZOjrfOzXZVs/WIoBZ6izGXTZ8t0wIj+HOyMaW2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ4bpJSX0Qs52JPWt25StOwe0MkJ70oXvPr+pqYPKSsZxtUkHo3SyT4AXWrX6EvcXZJzu+TcPt0A9NWO75Cws5kSE42eIlEEJ6eU42Mtt6tGQLQIxzfTCwf8LF82PnnSqaNFqwBzUgk7tH64sPZVa6ii2ihnX6pJvLUdkFWxNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmGmv9bQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso18000a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720713440; x=1721318240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgL7ROjy5iOMPF0UW7tQZ1QpAAIOvTOyfKxpIJ4bmyo=;
        b=pmGmv9bQO4mE96Y2LKBYe6LWydKxzELuNoMGleXgopZ1fCbjJQDgTsjKREReMQEFrp
         gI3A+TMEEjBi7pbQaIwZlJ+T8tZO8EmLh1o7t+mtyHV6DyEtE29Evt0EI9D5EztIMPCg
         Syw30AmGbyDGZCl5SkNi7oD6i+RCwbgs8eD5LhEcLpTIOaotG3aUD0znx+2U2qjuYtXc
         xh5cA6mR6JtmO3axFjqBTKrswfKYRBim5vUVZgmQqOS1aVB37NjG7XecV2+Yu1G+VoC6
         xs876fQm/S+NSZQuj8A5UFYrfF8StDWmEXW8PbXq1D74B7dTauH5CuRLQaCr88ndIrmO
         HGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713440; x=1721318240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgL7ROjy5iOMPF0UW7tQZ1QpAAIOvTOyfKxpIJ4bmyo=;
        b=MBLICC4oAp4pxf3byKTpxEV9/vllTJcYgPdAbygGwOdOyDB/g8rRoWe4u1MqEi9ius
         Wh0T9du+XUmnImp3QT+YoT1zsdkqL4jGrDx+lwkniVbCG3oA2jOoNWSBCMYJgC9Yr7Zn
         Nl3J3yscOgSxFLq5pB+i8u35i4VuZ+WRMp52sG6nH8ogps0g3eZCB00ZRutdLR29RYdf
         ZnlSDC03fSfQCV8uwvPr+4mO/vo7Dwoqm7X14hQV4jLrAck/A9OAViEBylZj9GPAxXFv
         RbUaNVN26d1vy0bRNdBWVk1wWf1BlY6W99Z7g9JB+18ZxrQ2/j2cETzXF5TmB4iPDp/t
         Bbdg==
X-Forwarded-Encrypted: i=1; AJvYcCXgLWWMqXjW7qm6+ci4BpRHvEoTUAJUnGSPxPwSyMj3ktov8aJ57HS46t0QFCNhn+wtT2Dxx9xDEZ6pbUlUrHHOCYhwra7uWX9iGU1Y
X-Gm-Message-State: AOJu0YztGyRSaS7EUNyYsUfSboBxvBlqBCrbmMRaaZc8MU4Bu4eGLnop
	Hu3gJP+bdBPofPIvQVXt2cJCNu/+OpXt5jc4eOTMtDClV/xgbM7zZLk8sug9QIkhtospe8GPSng
	fYdVY7A8LUXt0BSZD5feqIvkmgatdSYuW339B
X-Google-Smtp-Source: AGHT+IE3cvfKOYjE6nqB0ekOsf+rVygYEUaDO+ZYgsZUi+mmZ/AGBh1xu5c3PU2Vla9SYolYkwBR2jbQrCMeN1wuqrU=
X-Received: by 2002:a50:8e58:0:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5984e3226a6mr225185a12.3.1720713440316; Thu, 11 Jul 2024
 08:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Thu, 11 Jul 2024 09:57:07 -0600
Message-ID: <CAMkAt6ojzv+FYV5Hnvy9whf-TRTxht2C2y4Xnx_VsM_O5G50eA@mail.gmail.com>
Subject: Re: [RFC 4/5] selftests: KVM: SNP IOCTL test
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, pbonzini@redhat.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:06=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> Introduce testing of SNP ioctl calls. This patch includes both positive
> and negative tests of various parameters such as flags, page types and
> policies.
>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>

Tested-by: Peter Gonda <pgonda@google.com>

> ---
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 119 +++++++++++++++++-
>  1 file changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/=
testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 500c67b3793b..1d5c275c11b3 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -186,13 +186,130 @@ static void test_sev_launch(void *guest_code, uint=
32_t type, uint64_t policy)
>         kvm_vm_free(vm);
>  }
>
> +static int spawn_snp_launch_start(uint32_t type, uint64_t policy, uint8_=
t flags)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       int ret;
> +
> +       vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +       ret =3D snp_vm_launch(vm, policy, flags);
> +       kvm_vm_free(vm);
> +
> +       return ret;
> +}
> +
> +static void test_snp_launch_start(uint32_t type, uint64_t policy)
> +{
> +       uint8_t i;
> +       int ret;
> +
> +       ret =3D spawn_snp_launch_start(type, policy, 0);
> +       TEST_ASSERT(!ret,
> +                   "KVM_SEV_SNP_LAUNCH_START should not fail, invalid fl=
ag.");
> +
> +       for (i =3D 1; i < 8; i++) {
> +               ret =3D spawn_snp_launch_start(type, policy, BIT(i));
> +               TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                           "KVM_SEV_SNP_LAUNCH_START should fail, invali=
d flag.");
> +       }

To save readers sometime do we want to comment that flags must be zero?

> +
> +       ret =3D spawn_snp_launch_start(type, 0, 0);
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy=
.");
> +
> +       ret =3D spawn_snp_launch_start(type, SNP_POLICY_SMT, 0);
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy=
.");
> +
> +       ret =3D spawn_snp_launch_start(type, SNP_POLICY_RSVD_MBO, 0);
> +       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy=
.");

Ditto on SMT comment, this could pass if SMT was disabled right?

> +
> +       ret =3D spawn_snp_launch_start(type, SNP_POLICY_SMT | SNP_POLICY_=
RSVD_MBO |
> +                                    (255 * SNP_POLICY_ABI_MAJOR) |
> +                                    (255 * SNP_POLICY_ABI_MINOR), 0);
> +       TEST_ASSERT(ret && errno =3D=3D EIO,
> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid versio=
n.");
> +}
> +
> +static void test_snp_launch_update(uint32_t type, uint64_t policy)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       int ret;
> +
> +       for (int pgtype =3D 0; pgtype <=3D KVM_SEV_SNP_PAGE_TYPE_CPUID; p=
gtype++) {

Do we want to test KVM_SEV_SNP_PAGE_TYPE_CPUID+1 to make sure that fails?

> +               vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +               snp_vm_launch(vm, policy, 0);
> +               ret =3D snp_vm_launch_update(vm, pgtype);
> +
> +               switch (pgtype) {
> +               case KVM_SEV_SNP_PAGE_TYPE_NORMAL:
> +               case KVM_SEV_SNP_PAGE_TYPE_ZERO:
> +               case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED:
> +               case KVM_SEV_SNP_PAGE_TYPE_SECRETS:
> +                       TEST_ASSERT(!ret,
> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should not=
 fail, invalid Page type.");

Double negative maybe: "KVM_SEV_SNP_LAUNCH_UPDATE should succeed..."

> +                       break;
> +               case KVM_SEV_SNP_PAGE_TYPE_CPUID:
> +                       TEST_ASSERT(ret && errno =3D=3D EIO,
> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should fai=
l, invalid Page type.");

This is a valid page type right? But I think the error is from the ASP
due to the page being malformed for a CPUID page.

> +                       break;
> +               default:
> +                       TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should fai=
l, invalid Page type.");
> +               }
> +
> +               kvm_vm_free(vm);
> +       }
> +}
> +
> +void test_snp_launch_finish(uint32_t type, uint64_t policy)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +       int ret;
> +
> +       vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +       snp_vm_launch(vm, policy, 0);
> +       snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> +       ret =3D snp_vm_launch_finish(vm, 0);
> +       TEST_ASSERT(!ret,
> +                   "KVM_SEV_SNP_LAUNCH_FINISH should not fail, invalid f=
lag.");

Comment is wrong, maybe: "KVM_SEV_SNP_LAUNCH_FINISH should not fail."

> +       kvm_vm_free(vm);
> +
> +       for (int i =3D 1; i < 16; i++) {
> +               vm =3D vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
> +               snp_vm_launch(vm, policy, 0);
> +               snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
> +               ret =3D snp_vm_launch_finish(vm, BIT(i));
> +               TEST_ASSERT(ret && errno =3D=3D EINVAL,
> +                           "KVM_SEV_SNP_LAUNCH_FINISH should fail, inval=
id flag.");
> +               kvm_vm_free(vm);

To save readers sometime do we want to comment that flags must be zero?

> +       }
> +}
> +
> +static void test_sev_ioctl(void *guest_code, uint32_t type, uint64_t pol=
icy)
> +{
> +       if (type =3D=3D KVM_X86_SNP_VM) {
> +               test_snp_launch_start(type, policy);
> +               test_snp_launch_update(type, policy);
> +               test_snp_launch_finish(type, policy);
> +
> +               return;
> +       }
> +
> +       test_sev_launch(guest_code, type, policy);
> +}
> +
>  static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
>  {
>         struct kvm_vcpu *vcpu;
>         struct kvm_vm *vm;
>         struct ucall uc;
>
> -       test_sev_launch(guest_code, type, policy);
> +       test_sev_ioctl(guest_code, type, policy);
>
>         vm =3D vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>
> --
> 2.34.1
>

