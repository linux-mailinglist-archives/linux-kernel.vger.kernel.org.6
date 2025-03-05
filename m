Return-Path: <linux-kernel+bounces-547091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC0A502EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718E01643A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775D24EAAE;
	Wed,  5 Mar 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUdDf9Vm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22624CEED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186403; cv=none; b=p3YV5K9mMRh2Sor0yD5hou2gJaYFULOWgqz8Z7MxbkJ2QtRWTzcL1789H6hNoJe1e3cay3hxPnKLSbrCTGSAtMutH8tsZtzszHAfKykEu0YUgRdO5Dn1N5FknnHQQEtzcVkxD/OHZl2TjomAZ2pLzdPtc5J3loVCA4mnYZNb1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186403; c=relaxed/simple;
	bh=PGeG/E7ja4XGWHxNzROzI7h2oCS+EH16SyURg4QxoA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGHuYiAaTRYo4x/r1wCEMTMSWcJ+EAzTVAoqgCsE5UGrcEBtywq8jKbiexwl0Za/2O2vrxZrfFzPyTkOZ6xvStlNh38iOFKOV3CYiOYrfZfG1J+Hhfcu0HAmi/Uqh40jvdTjqfxAl1HwC5WSjhO708YJZDBRdHKAmDa8EcYvX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUdDf9Vm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe870bc003so1882100a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741186401; x=1741791201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu1YW5U539CmDNjnWklLjoJJJx5nCfEh8QEnX9CfqX8=;
        b=PUdDf9VmsQH1kjJuTP65L0FGZs1tbmboqC27fUONrdmB8SZ+1JitK1plNTkO5zfo0S
         qiLlO4LZr8TKCMbEz5W/f22y6w0cVuZRLRoe1j3cBT7hiExC9+8ff9mPUwbuFMDgWfLZ
         SnOXVKWfnKWOpq9iuYp0QwFBJOC5Ebf2HMnnYEBHwq7kJTvju0gJYiTQg4BMZXXZy0aV
         QbHZFjWppEyvhDtua1Lk+GjYZy+Sv+Avjke6dnqVmAC5msZg+US0xp3jQtpwSsJ3A29Q
         S2BFO/wM81HjaiH8dTCSmD/+q10WMLYMsqiJQZzt+2KOauzzt1SkyshqQ7AIxs2kbl9v
         xzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186401; x=1741791201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu1YW5U539CmDNjnWklLjoJJJx5nCfEh8QEnX9CfqX8=;
        b=nKiiR1Q1p9aQS6JglLwzHeLWKqAx0etqzwpSW81dv7BMMHqUakFSWpPu9HGXidDZMf
         FZLlY0O19EPvoYA5kPUWE8Rv5ZsgT7Np2jTlKs0jrY++EvqonPqwOlEBbl0uAI3gbL6W
         j8U21gGPyHiqfERTFEuTxX+B1EMGv5c/5x7fzVakeSbsooDVv+wmY32WG97BVg1+OSwi
         NHhQrKps7k+GvisGgOoHDol7Gg1c90JP3vL6NKDVTlGr7d8O0wbAhjXmgodUn0pByvyq
         C0uBztTA45xv2W4fqQGbYn4EYjWbRyjoN+D80tHsPv+ev5vPc1PeFad+57d5YVkgPX/q
         cxwg==
X-Forwarded-Encrypted: i=1; AJvYcCViSFkqn5ANEQy03ULBIpgwjhp2Di9hWOKmmr+niWnYj+2d0NpS4AgTq/9k8Nc8ppJmKexABoMW1wUK1P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UtQ6smWwEFzpnFUPofIHXr80ONMs52extfa1HiYWkhk0PCwg
	SCgqBYn5dwmWN8oRe88fyt5tmNvVjargyFxX1oxtnsLUDzUel8xYyafdqiTG2G4lXuZDwGoA+kA
	+Rg==
X-Google-Smtp-Source: AGHT+IHAYzQscJ8h7qg5HkSjPcaVcG06YIt5n669L2SaCaC2sybvLMQURj9aN7SRU326Fz9IYsQdsLpJF/s=
X-Received: from pfbft1.prod.google.com ([2002:a05:6a00:81c1:b0:730:9146:35ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f84:b0:2fa:1d9f:c80
 with SMTP id 98e67ed59e1d1-2ff33c2129amr12121356a91.17.1741186401066; Wed, 05
 Mar 2025 06:53:21 -0800 (PST)
Date: Wed, 5 Mar 2025 06:53:19 -0800
In-Reply-To: <2025030516-scoured-ethanol-6540@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250112095527.434998-4-pbonzini@redhat.com> <DDEA8D1B-0A0F-4CF3-9A73-7762FFEFD166@xenosoft.de>
 <2025030516-scoured-ethanol-6540@gregkh>
Message-ID: <Z8hlXzQZwVEH11fB@google.com>
Subject: Re: [Kernel 6.12.17] [PowerPC e5500] KVM HV compilation error
From: Sean Christopherson <seanjc@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, regressions@lists.linux.dev, 
	Trevor Dickinson <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au, 
	Darren Stevens <darren@stevens-zone.net>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 05, 2025, Greg KH wrote:
> On Wed, Mar 05, 2025 at 03:14:13PM +0100, Christian Zigotzky wrote:
> > Hi All,
> > 
> > The stable long-term kernel 6.12.17 cannot compile with KVM HV support for e5500 PowerPC machines anymore.
> > 
> > Bug report: https://github.com/chzigotzky/kernels/issues/6
> > 
> > Kernel config: https://github.com/chzigotzky/kernels/blob/6_12/configs/x5000_defconfig
> > 
> > Error messages:
> > 
> > arch/powerpc/kvm/e500_mmu_host.c: In function 'kvmppc_e500_shadow_map':
> > arch/powerpc/kvm/e500_mmu_host.c:447:9: error: implicit declaration of function '__kvm_faultin_pfn' [-Werror=implicit-function-declaration]
> >    pfn = __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, NULL, &page);
> >          ^~~~~~~~~~~~~~~~~
> >   CC      kernel/notifier.o
> > arch/powerpc/kvm/e500_mmu_host.c:500:2: error: implicit declaration of function 'kvm_release_faultin_page'; did you mean 'kvm_read_guest_page'? [-Werror=implicit-function-declaration]
> >   kvm_release_faultin_page(kvm, page, !!ret, writable);
> > 
> > After that, I compiled it without KVM HV support.
> > 
> > Kernel config: https://github.com/chzigotzky/kernels/blob/6_12/configs/e5500_defconfig
> > 
> > Please check the error messages.
> 
> Odd, what commit caused this problem?  Any hint as to what commit is
> missing to fix it?

833f69be62ac.  It most definitely should be reverted.  The "dependency" for commit
87ecfdbc699c ("KVM: e500: always restore irqs") is a superficial code conflict.

Oof.  The same buggy patch was queue/proposed for all stable trees from 5.4 onward,
but it look like it only landed in 6.1, 6.6, and 6.12.  I'll send reverts.

commit 833f69be62ac366b5c23b4a6434389e470dd5c7f
Author:     Sean Christopherson <seanjc@google.com>
AuthorDate: Thu Oct 10 11:23:56 2024 -0700
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Mon Feb 17 10:04:56 2025 +0100

    KVM: PPC: e500: Use __kvm_faultin_pfn() to handle page faults
    
    [ Upstream commit 419cfb983ca93e75e905794521afefcfa07988bb ]
    
    Convert PPC e500 to use __kvm_faultin_pfn()+kvm_release_faultin_page(),
    and continue the inexorable march towards the demise of
    kvm_pfn_to_refcounted_page().
    
    Signed-off-by: Sean Christopherson <seanjc@google.com>
    Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    Message-ID: <20241010182427.1434605-55-seanjc@google.com>
    Stable-dep-of: 87ecfdbc699c ("KVM: e500: always restore irqs")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

