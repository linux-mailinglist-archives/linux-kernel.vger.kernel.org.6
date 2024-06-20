Return-Path: <linux-kernel+bounces-223554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FB9114C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DB8283625
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6674BF0;
	Thu, 20 Jun 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9UpyW1B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68C7602B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919523; cv=none; b=fUZ4bBXgqc73UrDk0FOMFn/+RoCeFCTatlyDM9edmedM3POLI8+mhPHYNiYw4wJeF4njhuvR8XTY78di+BOmm12naXmu+VZhgiu56zUAd1ZFw9CY1vzTMF5fluffVHCPYnoMV1ecOfSXjS3LKTYykTF7ygmcL1R0Xur63fp/PHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919523; c=relaxed/simple;
	bh=rqttPFpgpdaPfltUEIWArBxugu0a4VlOcZsClzfwyYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BybDA6H6YGwXMrcJtxTPNF2en8uxvYhiB54It424IIU39ID4CUX/g57rTEhnUPyQiF1Dx8hDfk1VsavROyN3I2VKer6Zv+Asjm7MSHMIZ/U8sP0+xRtK4c64uxN/ldXDPfxkV7hejqJV3x1avbv0q/OXLPGdsXFyjNLJHgPcaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9UpyW1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718919519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7aMkAmRZxTuVx1sGr/rCjZ2e5+4RAngXxQuvmrxA14=;
	b=g9UpyW1BS+LA6Td0D56v3C9mWDrMpoH2o8+5n+PRGrHlYC/FMjJjHBN00dQ+ML2DzA3hFB
	CVZPQl9DKhQBwZrHzW9uPn4Ka81+RWmRD9QY92cLjOr6hLoWzu3Pl4yPBv6zTsKu0B5jqG
	WCC7KsnNCPntxG7W3Ms2HQUX92VAkWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-JLlvXH4gMqy5EelBsp6e3g-1; Thu, 20 Jun 2024 17:38:38 -0400
X-MC-Unique: JLlvXH4gMqy5EelBsp6e3g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-362a0c1041dso657055f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919516; x=1719524316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7aMkAmRZxTuVx1sGr/rCjZ2e5+4RAngXxQuvmrxA14=;
        b=vM79KJiTp4mk0u+ScfiBetaGLryXhtatqpHdpAsdEhe2TuKiD0xBghqBRoO8wptO0i
         kxxXI4PwXPr0EIeESKZY4uGiFG9c7eQgjKAIDzN5lQFodVCSR8eXxrYk4AcHt5xHJRod
         4JU9iNNbq2UZ9CaxdKGaahG93ZNlKS2b1yNnozr+0wLDln+joNKUCzRx3ZNVPrYKyeTb
         XUdQ/dYcspmzmqN5KVEXF9/Ye7buWiJPg/tuynTenJ9amcVggxQV9mkHGIGI38h6tjQF
         +9qzX3lsGHufk2jcSfRL9Ilr2186Ts1SfrqVpW/Jccayrgc/Q/p771x6QtRif82P2xa6
         TXsA==
X-Forwarded-Encrypted: i=1; AJvYcCVwbNhl4ZRwuC1U2mpgePv+IEvCPeeDtQDB8lTJRokyX6kVec8Q4UbF+/GcmDvlymoIZ09p9CM8/W13bCGnG+ImfEK80sB+TU5+mPkD
X-Gm-Message-State: AOJu0YzeUQcWzwslGIO0I4V2KDWJ9FDSz58+kbJJ3Y0Rv2CILYVxnXkX
	+QE3FrVXclFJnzZs1Kk0hWAN7uKvmwmCDeUUhGeCXzaVExWu1hH2/9Kej7z8wnvJjLz+uMnrkNK
	jts/+cfY2lZcKm/DX0HknBg4NpsXKwOYs0AN0Wz6Bh53AoFUmzo9+iYcDxAHfsAjZZ0LfhbL83e
	hv3c5+/WIBG5S9yV//hAGi56QhJk9i5Ax1y0L0tf2ji1XX
X-Received: by 2002:adf:a1c3:0:b0:35f:1d3c:4084 with SMTP id ffacd0b85a97d-363175b8117mr5214929f8f.25.1718919516016;
        Thu, 20 Jun 2024 14:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeszHwlXgdEM1NO99w4ms9jc7VT304ZceaMczZNwXUGQLu/wTYm3HMYNQYukZIoWZJZLO79yyRTjGY+fKY3Bw=
X-Received: by 2002:adf:a1c3:0:b0:35f:1d3c:4084 with SMTP id
 ffacd0b85a97d-363175b8117mr5214921f8f.25.1718919515666; Thu, 20 Jun 2024
 14:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614234607.1405974-1-seanjc@google.com>
In-Reply-To: <20240614234607.1405974-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 23:38:24 +0200
Message-ID: <CABgObfamcK6x4+ZihsNN7q8OCww4MC1i8J-L+B=q7bth1Oimbg@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: Fixes, cleanups, and new tests
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 1:46=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a smattering of x86 changes, most of which have been sitting =
around
> on-list for quite some time.  There are still quite a few KUT x86 series =
that
> want attention, but they are all quite large and exceeded what little rev=
iew
> time I have for KUT :-/

Pulled, thanks.

Paolo

> Note, the posted interrupt test fails due to KVM bugs, patches posted:
> https://lore.kernel.org/all/20240607172609.3205077-1-seanjc@google.com
>
> The following changes since commit a68956b3fb6f5f308822b20ce0ff8e02db1f73=
75:
>
>   gitlab-ci: Always save artifacts (2024-06-05 12:49:58 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2024.06.14
>
> for you to fetch changes up to ee1d79c3f0f871bf78f20930cb1a2441f28ac027:
>
>   nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR =
(2024-06-11 06:41:23 -0700)
>
> ----------------------------------------------------------------
> x86 fixes, cleanups, and new testcases:
>
>  - Add a testcase to verify that KVM doesn't inject a triple fault (or an=
y
>    other "error") if a nested VM is run with an EP4TA pointing MMIO.
>
>  - Play nice with CR4.CET in test_vmxon_bad_cr()
>
>  - Force emulation when testing MSR_IA32_FLUSH_CMD to workaround an issue=
 where
>    Skylake CPUs don't follow the architecturally defined behavior, and so=
 that
>    the test doesn't break if/when new bits are supported by future CPUs.
>
>  - Rework the async #PF test to support IRQ-based page-ready notification=
s.
>
>  - Fix a variety of issues related to adaptive PEBS.
>
>  - Add several nested VMX tests for virtual interrupt delivery and posted
>    interrupts.
>
>  - Ensure PAT is loaded with the default value after the nVMX PAT tests
>    (failure to do so was causing tests to fail due to all memory being UC=
).
>
>  - Misc cleanups.
>
> ----------------------------------------------------------------
> Alejandro Jimenez (1):
>       x86: vmexit: Allow IPI test to be accelerated by SVM AVIC
>
> Dan Wu (1):
>       x86/asyncpf: Update async page fault test for IRQ-based "page ready=
"
>
> Jack Wang (1):
>       x86/msr: Fix typo in output SMR
>
> Jim Mattson (1):
>       nVMX: Enable x2APIC mode for virtual-interrupt delivery tests
>
> Marc Orr (3):
>       nVMX: test nested "virtual-interrupt delivery"
>       nVMX: test nested EOI virtualization
>       nVMX: add self-IPI tests to vmx_basic_vid_test
>
> Mingwei Zhang (3):
>       x86: Add FEP support on read/write register instructions
>       x86: msr: testing MSR_IA32_FLUSH_CMD reserved bits only in KVM emul=
ation
>       x86/pmu: Clear mask in PMI handler to allow delivering subsequent P=
MIs
>
> Oliver Upton (1):
>       nVMX: add test for posted interrupts
>
> Sean Christopherson (9):
>       nVMX: Use helpers to check for WB memtype and 4-level EPT support
>       nVMX: Use setup_dummy_ept() to configure EPT for test_ept_eptp() te=
st
>       nVMX: Add a testcase for running L2 with EP4TA that points at MMIO
>       x86/pmu: Enable PEBS on fixed counters iff baseline PEBS is support
>       x86/pmu: Iterate over adaptive PEBS flag combinations
>       x86/pmu: Test adaptive PEBS without any adaptive counters
>       x86/pmu: Add a PEBS test to verify the host LBRs aren't leaked to t=
he guest
>       nVMX: Ensure host's PAT is loaded at the end of all VMX tests
>       nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT =
MSR
>
> Yang Weijiang (3):
>       nVMX: Exclude CR4.CET from the test_vmxon_bad_cr()
>       nVMX: Rename union vmx_basic and related global variable
>       nVMX: Introduce new vmx_basic MSR feature bit for vmx tests
>
>  lib/x86/apic.h       |   5 +
>  lib/x86/asm/bitops.h |   8 +
>  lib/x86/desc.h       |  30 +++-
>  lib/x86/pmu.h        |   6 +-
>  lib/x86/processor.h  |  24 ++-
>  x86/asyncpf.c        | 154 ++++++++++------
>  x86/msr.c            |  23 ++-
>  x86/pmu.c            |   1 +
>  x86/pmu_pebs.c       | 110 +++++++-----
>  x86/unittests.cfg    |  19 +-
>  x86/vmx.c            |  50 +++---
>  x86/vmx.h            |   7 +-
>  x86/vmx_tests.c      | 497 +++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  13 files changed, 755 insertions(+), 179 deletions(-)
>


