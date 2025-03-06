Return-Path: <linux-kernel+bounces-549828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7DA557AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF57AA762
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284A0276D2A;
	Thu,  6 Mar 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qz08cqIJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14520458B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293832; cv=none; b=m/Ym46Vs7B4Cz1IA10m+LN1eeCMetMjMCMNaQ7i/620NPywgwpi2GKskWSqrWc3EzpIgimwQy1+3ejs3bjLq7Kelxw5mRCHos6a4QLVOQxgwS3R51u94T8ifbP+gN5FrWCtwFJowADHTCcOCM+lIFVjNwesCs9ofzGq/aqCCTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293832; c=relaxed/simple;
	bh=l7uz8/UlAi3FlKusi7zzoCQaS1kZZ4iwULRX6B1RPGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tmKt/A48rYeVoO++aXeMGNDKXdw6eLhh5BaOYOaZZkIdUyc1pFQcIePdCGBg71aDm02A4hN6ZqLSuSHRjf5sjj3RJJhuQqVoIbgDA4jjo1Rvb3zUZIpZ7jzCoSOBQ3ejYBrH2iyo7AA8vH9HUpUIT9uKHP6h0MmZaEm5BVdSFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz08cqIJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso1798669a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741293830; x=1741898630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcU+57bF2nKIJKG40WdcNh71zD/thfdwbbX5KGrnw6s=;
        b=qz08cqIJhUfR5e9PQCdl5tA9apfxTNzEfROGuDSS3FltADSWa7By0LItqzKJK7tNFY
         b65G8IKCzxr8QFstzCBqtAyHIpYSzHLPf0+caS9J0n1fQJv/JFsMvbF/vjrwCOumxJdq
         N9iP9QBpZr2jGV4rEyMYeJIypEpELoKu/xk+IouFyKFbsp9006IBubprtkOnjaOAFRzy
         D5zsj25UPVB9YqYvpQFQu5ywrSmS06SELTz4mPmFpa6unfEhuPSRyHi7q9GwroTT+K4p
         BheXgojvs9FjWBuJsW9g3d0S9bv8QuQYaahM1m7EPc+Gz/uuwoAVzPlhSdSdE3p+LZuX
         CCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293830; x=1741898630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcU+57bF2nKIJKG40WdcNh71zD/thfdwbbX5KGrnw6s=;
        b=Op1VmTMa5/GK540E9EtzZbz+j7hvpFwaYpd66kAan4eUz9p25NfC9gRm10TxFLLxZP
         CQqsDucepamzqUU8HW8bdxnkKD2AIAeKqwbaM5ndBHnl7C1qkWyZDgmGZdWyhmulWHQJ
         KaP640Lkv29gZ1ELf5/7pwoQIHuR5vPKuCx8g+rHMX1Tyn7KVmw33SOL/2GNRuc0kGC+
         Y8BzsX7J+WL7r5wuod0qIkI+1Y6/knRq8HvEs3b1f7kBslRdYsDhE9ebtfduGSHMzDF+
         aKxolRcIoGbdy//qIX4DITTwKuhnsY3DJ23TkRL64FeiJLR7V9SNvUWqCvT3ih91NCJg
         JVPg==
X-Forwarded-Encrypted: i=1; AJvYcCVCFsDAv4ezxtQrNULAo+bYy39VEq5KlXhkXgQPy0rOsTKgMsjUH94sjDO2Fsfs8gTEhfdu9JZuMU0c0+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLExx24BNXjARC9zetNrxpAqtzukGgV7d7EtZbo/0sytCMagWI
	aZGjKNJQ0MfzfEYaNJerCIgz1FoaUjakEuB43mdXm5gom3LQueidQz8aiG3m9lgfdyO+DfXSmoL
	New==
X-Google-Smtp-Source: AGHT+IE6M3i30Kw8orX/zf/qVCY180adq6TxVjCLhFUYj1qM1cqjupTsMC6KzI6E/lQ2YGzlrmN6mwMILjQ=
X-Received: from pjyf12.prod.google.com ([2002:a17:90a:ec8c:b0:2fc:1356:bcc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cc9:b0:2fc:aaf:74d3
 with SMTP id 98e67ed59e1d1-2ff6172aef7mr7145660a91.4.1741293830396; Thu, 06
 Mar 2025 12:43:50 -0800 (PST)
Date: Thu, 6 Mar 2025 12:43:49 -0800
In-Reply-To: <0745c6ee-9d8b-4936-ab1f-cfecceb86735@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129095902.16391-1-adrian.hunter@intel.com>
 <20250129095902.16391-3-adrian.hunter@intel.com> <01e85b96-db63-4de2-9f49-322919e054ec@intel.com>
 <0745c6ee-9d8b-4936-ab1f-cfecceb86735@redhat.com>
Message-ID: <Z8oImITJahUiZbwj@google.com>
Subject: Re: [PATCH V2 02/12] KVM: x86: Allow the use of kvm_load_host_xsave_state()
 with guest_state_protected
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kai.huang@intel.com, reinette.chatre@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, nik.borisov@suse.com, linux-kernel@vger.kernel.org, 
	yan.y.zhao@intel.com, chao.gao@intel.com, weijiang.yang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 06, 2025, Paolo Bonzini wrote:
> I agree with Xiaoyao that this change is sensible but should be proposed
> separately for both SNP and TDX.
> 
> Allowing the use of kvm_load_host_xsave_state() is really ugly, especially
> since the corresponding code is so simple:
> 
>         if (cpu_feature_enabled(X86_FEATURE_PKU) && vcpu->arch.pkru != 0)
>                         wrpkru(vcpu->arch.host_pkru);

It's clearly not "so simple", because this code is buggy.

The justification for using kvm_load_host_xsave_state() is that either KVM gets
the TDX state model correct and the existing flows Just Work, or we handle all
that state as one-offs and at best replicate concepts and flows, and at worst
have bugs that are unique to TDX, e.g. because we get the "simple" code wrong,
we miss flows that subtly consume state, etc.

