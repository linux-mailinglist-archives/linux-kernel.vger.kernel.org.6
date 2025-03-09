Return-Path: <linux-kernel+bounces-552954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437A1A5816E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E6D3AD0CC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DA183CCA;
	Sun,  9 Mar 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2QOP4hJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423B10E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507651; cv=none; b=P8kO+PioZ9thqRKKEzCah9PvkmAaliFTw1nAjVmreoqmqixY/G07qDlwlK69PK+g9r+DlYKwY8AbOVRrtTMNaKyK3BIL0gH5Y2ig9DnB9tBGdxpJSeQ6kiX6L88xEjQBhos2HjuC4sCP0rAB5KLNMx19FXhtdqj/BNUCFW/MvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507651; c=relaxed/simple;
	bh=99NEVqvBP5TRbaKk01Oc0W/ttk9cc30UFtifsXasBuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC/DXJbRD7gWlVQDTPJio8M4V1atZcIKQ3rxQHJaQHOjKy8RYXx9ymuWt5Foso5OdCsNBixSsgFQ8Czu4Swypewo/6mt+B5YjeBUOakBkP2k2m9SuaxoSaItHWcMOJffNQAFtHqhfuAbctCDkpE1hZxqy6ed6B+YhlrxZNMIhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2QOP4hJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741507648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMxc923CRiMks37b+Jjb8HyITgLj/wOpsi581iiQzTY=;
	b=D2QOP4hJGDSz5OG25vbvgjp/IX9k8W5RWmjqjOFh8HDXbWwMYry7860zOqYIJ4TIuTWaOX
	qAiIC/z3eUskaMj7QE46YSrtHwi3W6OWlZJ5D07oSuZ/jzHHpWtoTGf2r/moNxxwwDwaZW
	G4vwTTjJ2+UaeQidSiji/jwT5E1yz6E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-ezbuFoReP3mZ2qPn0Xmh2g-1; Sun, 09 Mar 2025 04:07:26 -0400
X-MC-Unique: ezbuFoReP3mZ2qPn0Xmh2g-1
X-Mimecast-MFC-AGG-ID: ezbuFoReP3mZ2qPn0Xmh2g_1741507645
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471ddso241667f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 00:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741507645; x=1742112445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMxc923CRiMks37b+Jjb8HyITgLj/wOpsi581iiQzTY=;
        b=H57L00odNynpxzTm4lrECgtVgxI7OsC1VH6+n7Y/zTP9YR7fOZhDMlrbea4cVP1YOp
         +XwKNefd2yP6lbHpAR0art6rBO51YRdXZl+wpsUEVLBPuTftAYhnCs3mIJivPUqBNJQe
         ksWA3rGek+1aSGqoQX4j7ph8gv0fwpLg77qLd5uc246oqZ0BiUgQST7141D+mEjzeztd
         DLlAY+S4WzzrWx5ieL7w811VmGKiV6k0Q8Nll6ulURJmv2l20JbFmq0w7SNd4n3sM0/b
         aw8Dc0isMQnkc+1bfcTFYq5gqsyZabsx1EnkHWaPEFs10bLlfsQB8i8xw/9hC2uQOk8g
         HvIg==
X-Forwarded-Encrypted: i=1; AJvYcCVDcn0iOAZqSH3z1ATVz6a3zGn+KfpiFk+Yi6KwEifhzYTrh4Eh68OmZfUQfcDQ4dQRgK6U3Tr76GwO1hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLMVGUjCb8oJpiZchD+ggYZHLPrTIjssmUEc/rHxdEOQcG+mD
	/biWY5Qgjgdi8JurwMAggOywPo7WekgWaGp9HThjOQyLIQAWQHrDKVackszitAbb1Oau4HRySww
	UK/5EswrA1BYMtrQDI68lSTZ9ltQprFgX54HYbCCVuyHEGsdCsOQaqWFGjNAexC1ASvScbPa3sm
	uzKweRTor8GNyyzp/UDlOO3s6jlld09dyy82Pj
X-Gm-Gg: ASbGncuGR4XuVcIxQP+teMvUgIUZqHAeqEQ03D8V4QhuOxrrpQXnsP/v/Y0jzurpRSh
	5jKmplVyh1l9qdNDLqS9DMLT7/LQw2uWfKCNQ8oyduqW66SEX9FvqrvqjVchHaKmrxTajgcY4CQ
	==
X-Received: by 2002:a05:6000:4102:b0:391:487f:27e7 with SMTP id ffacd0b85a97d-391487f2b5amr87716f8f.55.1741507645473;
        Sun, 09 Mar 2025 00:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhD/61rkcaEIdwMrtxevM0JBg/y05qGnnJvvH/bQYC44QrzoG0yv2gURYtI+KKv8IIxwg7AZ5hOgrh770quwo=
X-Received: by 2002:a05:6000:4102:b0:391:487f:27e7 with SMTP id
 ffacd0b85a97d-391487f2b5amr87696f8f.55.1741507645022; Sun, 09 Mar 2025
 00:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308010347.1014779-1-seanjc@google.com>
In-Reply-To: <20250308010347.1014779-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 9 Mar 2025 09:06:54 +0100
X-Gm-Features: AQ5f1JoolazH4jL0h1xGLNNnbKtztmE1g0HsqhOFa3fHrQo1Y-uGVjTz1XGfUfY
Message-ID: <CABgObfYO8tEYYTDfmf+F-GA3aOCrRn6_Os6uhry9EJ4F3QHkUw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 6.14-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 2:03=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please pull a handful of fixes for 6.14.  The DEBUGCTL changes are the mo=
st
> urgent, as they fix a bug that was introduced in 6.13 that results in Ste=
am
> (and other applications) getting killed due to unexpected #DBs.
>
> The following changes since commit c2fee09fc167c74a64adb08656cb993ea47519=
7e:
>
>   KVM: x86: Load DR6 with guest value only before entering .vcpu_run() lo=
op (2025-02-12 08:59:38 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.14-rcN.2
>
> for you to fetch changes up to f9dc8fb3afc968042bdaf4b6e445a9272071c9f3:
>
>   KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't supported b=
y KVM (2025-03-04 09:19:18 -0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM x86 fixes for 6.14-rcN #2
>
>  - Set RFLAGS.IF in C code on SVM to get VMRUN out of the STI shadow.
>
>  - Ensure DEBUGCTL is context switched on AMD to avoid running the guest =
with
>    the host's value, which can lead to unexpected bus lock #DBs.
>
>  - Suppress DEBUGCTL.BTF on AMD (to match Intel), as KVM doesn't properly
>    emulate BTF.  KVM's lack of context switching has meant BTF has always=
 been
>    broken to some extent.
>
>  - Always save DR masks for SNP vCPUs if DebugSwap is *supported*, as the=
 guest
>    can enable DebugSwap without KVM's knowledge.
>
>  - Fix a bug in mmu_stress_tests where a vCPU could finish the "writes to=
 RO
>    memory" phase without actually generating a write-protection fault.
>
>  - Fix a printf() goof in the SEV smoke test that causes build failures w=
ith
>    -Werror.
>
>  - Explicitly zero EAX and EBX in CPUID.0x8000_0022 output when PERFMON_V=
2
>    isn't supported by KVM.
>
> ----------------------------------------------------------------
> Sean Christopherson (11):
>       KVM: SVM: Set RFLAGS.IF=3D1 in C code, to get VMRUN out of the STI =
shadow
>       KVM: selftests: Assert that STI blocking isn't set after event inje=
ction
>       KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
>       KVM: SVM: Suppress DEBUGCTL.BTF on AMD
>       KVM: x86: Snapshot the host's DEBUGCTL in common x86
>       KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization is=
 disabled
>       KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
>       KVM: SVM: Save host DR masks on CPUs with DebugSwap
>       KVM: SVM: Don't rely on DebugSwap to restore host DR0..DR3
>       KVM: selftests: Ensure all vCPUs hit -EFAULT during initial RO stag=
e
>       KVM: selftests: Fix printf() format goof in SEV smoke test
>
> Xiaoyao Li (1):
>       KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't support=
ed by KVM
>
>  arch/x86/include/asm/kvm_host.h                    |  1 +
>  arch/x86/kvm/cpuid.c                               |  2 +-
>  arch/x86/kvm/svm/sev.c                             | 24 +++++++----
>  arch/x86/kvm/svm/svm.c                             | 49 ++++++++++++++++=
++++++
>  arch/x86/kvm/svm/svm.h                             |  2 +-
>  arch/x86/kvm/svm/vmenter.S                         | 10 +----
>  arch/x86/kvm/vmx/vmx.c                             |  8 +---
>  arch/x86/kvm/vmx/vmx.h                             |  2 -
>  arch/x86/kvm/x86.c                                 |  2 +
>  tools/testing/selftests/kvm/mmu_stress_test.c      | 21 ++++++----
>  .../selftests/kvm/x86/nested_exceptions_test.c     |  2 +
>  tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  3 +-
>  12 files changed, 91 insertions(+), 35 deletions(-)
>


