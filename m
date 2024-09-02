Return-Path: <linux-kernel+bounces-311565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F02968A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402EDB22CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E81CB52B;
	Mon,  2 Sep 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoUWw/Es"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B41CB523
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288982; cv=none; b=sdGAv4F20Sr5+DhHGk6XDCG2LmjvDZ/nGnBzcaGv/sKRF4VLxEi4uI1HZqa+E+Ktk897wDFpIwBqC+YTjNFrRGe6IFSl1xkVgDTZUt4HDrNmoGKwkuZ/RvT0SeLj+oO2u0ATTHIqEe6Szz91/u5qmLCflVvfWQZLV/gFhYg3fUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288982; c=relaxed/simple;
	bh=edZNdlPqu0BH4DMZBrBUAZom0Aq31Tn1hxdPEW/9kz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgQAqvLfoLWCNsrwCg+dwccnfXbr7TpKiBXp75pRJdnVzOjMfd4KjkeGS4UB/e+w/6lwDwkbFOWsbo3MLsK39yPrfIQVcf8nBEFnTCNR6l3nOYQmCWUV1ZjHiPLY975NDKvvlRTelAKUprh5o0bBR/Syohg2AFriY838323niPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoUWw/Es; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725288979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXMmeBaYJlR4uzCw7PqYk4KRB/yDtlvfzyZX5wr1+OQ=;
	b=VoUWw/EsWD3NgACoLcL1BYMuB8StqG7DMQh7a0eiBi2/+Eh1+9+9lspQozwZchDkMOJHud
	bMYb9Q/jy+qKIiFh+jbJa+LwquwJKpPKI6nW10NuQm/kZu1XpUDzjCXxEzzuyevh0K5LKe
	DTKnSyb83sSQ8pNEpQkw0NXr7iymsAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-jY40yVRlMIubKLj0TuN0-Q-1; Mon, 02 Sep 2024 10:56:18 -0400
X-MC-Unique: jY40yVRlMIubKLj0TuN0-Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42c7dd5d7faso6997735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725288977; x=1725893777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXMmeBaYJlR4uzCw7PqYk4KRB/yDtlvfzyZX5wr1+OQ=;
        b=fwJdWpgTAJGjp625b7xKCVb1JdVl8jJ4lRx827AJB1oECaSuiS8fxZDKUCSZ8OODpH
         0dwjD9qXBvkTygV5N1La+MN6QmVEuHlLv4TQnux2yTbuYdnM7D5qfgrcp1iDRvA1SaWU
         Hac1LKPKV/lJR7D+I4ghI50YtIo39uv1n9idHM1buoYsvdJ8WV0b4Ezb4VTgN4vDuhYA
         +tvHli+r25X8uYGbWkRDG3yIbA+ISZ12svd/09/jtbsqp5EHJbcXq3uGINmq0W7qFiAI
         1+x9cZ015tn9M/lhqPRSk7r/BSaNPrZgkE8E9UcBESb/hd56z7Qkl+HBt3Zupy5NptoF
         A2VA==
X-Forwarded-Encrypted: i=1; AJvYcCUvDyDqbWHEbI99PqA6SfrQrqble5oiq7MJJ1TV0KfrZiYDtpcxeol5aj++SJBm3jputczyuUw8Vw4d5a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhU78kgiCXeXhDW754r1UjFY2GHO5t6s/gkjIKacWKv0LMdJc
	y7rPUhQuHIgtBESFaCyekoM+iO/NgV2BMY7HrsbCz4CqpP2ClANGY0YR3M+qgWd64W5oLmX9YiE
	fZE5Gf5z5VMjV63wuvAyG3R7a5NK7e37EN/e/irGPCjMbd2Os7C0XuxxY1NS4YtrT7q2hgBhYFE
	kz+TEN+g7cU5+OUoDIoSVHiI06E+gRNcrBJW9f
X-Received: by 2002:a5d:4fc6:0:b0:374:bb1a:eebb with SMTP id ffacd0b85a97d-374bb1aefe4mr4354486f8f.25.1725288977227;
        Mon, 02 Sep 2024 07:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf3CScUz921srbnKmcoQAzxvzkfVVn9ngrMaqrnTH6hMEI3EI7azowMppFVEEFNggqR1/cZ7zf+tUQqROs1Ts=
X-Received: by 2002:a5d:4fc6:0:b0:374:bb1a:eebb with SMTP id
 ffacd0b85a97d-374bb1aefe4mr4354473f8f.25.1725288976740; Mon, 02 Sep 2024
 07:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830234042.322988-1-seanjc@google.com>
In-Reply-To: <20240830234042.322988-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 16:56:05 +0200
Message-ID: <CABgObfaE9G30bz8oarCiWmr+LqGMjGa4dijkOLLRoXjra6VecA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 6.11-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 1:40=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a handful of random fixes.  Details in the tag and changelogs=
.
>
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f82083=
99:
>
>   Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.11-rcN
>
> for you to fetch changes up to 5fa9f0480c7985e44e6ec32def0a395b768599cc:
>
>   KVM: SEV: Update KVM_AMD_SEV Kconfig entry and mention SEV-SNP (2024-08=
-28 05:46:25 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM x86 fixes for 6.11
>
>  - Fixup missed comments from the REMOVED_SPTE=3D>FROZEN_SPTE rename.
>
>  - Ensure a root is successfully loaded when pre-faulting SPTEs.
>
>  - Grab kvm->srcu when handling KVM_SET_VCPU_EVENTS to guard against acce=
ssing
>    memslots if toggling SMM happens to force a VM-Exit.
>
>  - Emulate MSR_{FS,GS}_BASE on SVM even though interception is always dis=
abled,
>    so that KVM does the right thing if KVM's emulator encounters {RD,WR}M=
SR.
>
>  - Explicitly clear BUS_LOCK_DETECT from KVM's caps on AMD, as KVM doesn'=
t yet
>    virtualize BUS_LOCK_DETECT on AMD.
>
>  - Cleanup the help message for CONFIG_KVM_AMD_SEV, and call out that KVM=
 now
>    supports SEV-SNP too.
>
> ----------------------------------------------------------------
> Maxim Levitsky (1):
>       KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_=
GS_BASE
>
> Ravi Bangoria (1):
>       KVM: SVM: Don't advertise Bus Lock Detect to guest if SVM support i=
s missing
>
> Sean Christopherson (2):
>       KVM: x86/mmu: Check that root is valid/loaded when pre-faulting SPT=
Es
>       KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS
>
> Vitaly Kuznetsov (1):
>       KVM: SEV: Update KVM_AMD_SEV Kconfig entry and mention SEV-SNP
>
> Yan Zhao (1):
>       KVM: x86/mmu: Fixup comments missed by the REMOVED_SPTE=3D>FROZEN_S=
PTE rename
>
>  arch/x86/kvm/Kconfig       |  6 ++++--
>  arch/x86/kvm/mmu/mmu.c     |  4 +++-
>  arch/x86/kvm/mmu/spte.c    |  6 +++---
>  arch/x86/kvm/mmu/spte.h    |  2 +-
>  arch/x86/kvm/mmu/tdp_mmu.c |  8 ++++----
>  arch/x86/kvm/svm/svm.c     | 15 +++++++++++++++
>  arch/x86/kvm/x86.c         |  2 ++
>  7 files changed, 32 insertions(+), 11 deletions(-)
>


