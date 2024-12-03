Return-Path: <linux-kernel+bounces-428516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410829E0F88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EB528306F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844510E4;
	Tue,  3 Dec 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLlrZs1H"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE0A32
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184886; cv=none; b=Y9mCrBhVvA1hEnLu5HZyDDo2CV77vRSsH4CuHCZjkKypTMS+y4HP+Ww1gtVB3RyjnaRYA3wkDbAHIWEYlSopCOD7t1xUVrpkzLqprrhphvw9J+/uuFXvQGDsdPogAsgJR8t4L2kEiCv7c9hMqFuYX9dylDeliRJ/7k1Q+9vLlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184886; c=relaxed/simple;
	bh=MHJjeZa/reEVzgbcKX2JOJvOOjtlk9wAJDBjubCoJxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHEJ3cl0jCawVvfE7YUVRT/Qx011D7el856rSOO1u/bSYzJmwCNUb+BDfgKijWEeSN9df3VELDSPsgssVXjfrXwmBcXpqLmwxaneruVICZLkXBuFFBfWa8Wx+lCk2/qZgLAoFKiMreozIN/TjdBP7BdljHJA3kyczv7RX7eDwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NLlrZs1H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e95713327eso4600325a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733184884; x=1733789684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHmbDNthMFLWB5i9RKAwYv3EBfwAod31XjZ5W9vetUE=;
        b=NLlrZs1HW6ViweR1JJqfw5FupGNZgaoVrAvHzV1H1c4n3cje5koG4vOzQ1F3iYj2ZW
         o+N2n6MJJb2wEeI6qZudy74ui/Yu4gE6kx13n+xPvs+C/d25Jg50JL7q9c0OA4nRB4bF
         GQr5ElBoxvql7zfoyyLpB0BCBZpNqNAeixlSAwG+8AEMB+PaVExrbKHGC5XARDYB8sl7
         ajU4UMf2PJ1Dv/kQsEQn+BhrUwAcHllodCKVYN9mcKE2Uakk763z+dGDrrPGSpZn/yRv
         K5JcBz7mvCVRqxvIgdtcDN0s4KGOTxWD0aLbsy6GXq7WOqxdqQSX3jjxH3xoSNYQWebe
         us/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184884; x=1733789684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHmbDNthMFLWB5i9RKAwYv3EBfwAod31XjZ5W9vetUE=;
        b=heRwrfCGT7Xbh9jTjKegA1xpyYE8NxSbsIhCkrRgG7mHqXBXJxt1YXIcww4Gbz6hej
         zmhgLWEMmQQqLwuNI1XWi5yBmdMoCEwCbhuAK33q4sEom1nKKgoGD+1Drjb3NKxDYtpW
         uQmnP4R/4eea+BPl0VR7kH/n0wVMNnvEoEfZsbV+wQ4auwDWgAp5CEVWYLCONe4g+CsR
         Tdr6ik8S0BU4MGke2wSUCxEC9oGA6RmwJASV1ooAnKtTPhsZEtrEY4+NYumU8LzhhI7v
         gN3Q/cz8ZUb42fLOANPT7OgzYapYhNIi08ZrsrHSBdghIyfue/79JXEbMBcRZ0Jey1YX
         gvwg==
X-Forwarded-Encrypted: i=1; AJvYcCUZzvMUfIA7RjaEqeaJQcUK8MiA2YAdcCKNmLyzKIpL3P4dRAO/BGuAtnk1bsiyQuWzyxiwBL9+seSrAjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaLbhVEJeaKT9Wdh5tv7ZcSCMaiqCRgo25qpsEmIqc6RpPrDF
	03erSm5wEQuQB0XLfaqEiAC7N/dfygv/ygiBJwsctkUq7Tdd7w+aEBhi8u7zu8TGOOXLyCDhbJg
	2hQ==
X-Google-Smtp-Source: AGHT+IHnBi8JiasKd6b9FR3Eah0ap7D3VLh2iriUG48oInOKWNVAMYuz8N+zAnjehBKrmxwSwb36IkikFng=
X-Received: from pjf5.prod.google.com ([2002:a17:90b:3f05:b0:2ea:7fd8:9dca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a85:b0:2ee:e961:303d
 with SMTP id 98e67ed59e1d1-2ef01275c7dmr796832a91.35.1733184884307; Mon, 02
 Dec 2024 16:14:44 -0800 (PST)
Date: Mon, 2 Dec 2024 16:14:42 -0800
In-Reply-To: <0a8cda3e-8185-0620-32f7-0696a31f4877@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com> <20241128004344.4072099-6-seanjc@google.com>
 <6f4aabdb-5971-1d07-c581-0cd9471eff88@amd.com> <0a8cda3e-8185-0620-32f7-0696a31f4877@amd.com>
Message-ID: <Z05NcpNLCgnL61jH@google.com>
Subject: Re: [PATCH v4 5/6] KVM: x86: Always complete hypercall via function callback
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 02, 2024, Tom Lendacky wrote:
> On 12/2/24 14:57, Tom Lendacky wrote:
> > On 11/27/24 18:43, Sean Christopherson wrote:
> 
> >> @@ -10071,13 +10072,15 @@ unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
> >>  	}
> >>  
> >>  out:
> >> -	return ret;
> >> +	vcpu->run->hypercall.ret = ret;
> >> +	complete_hypercall(vcpu);
> >> +	return 1;
> > 
> > Should this do return complete_hypercall(vcpu) so that you get the
> > return code from kvm_skip_emulated_instruction()?
> 
> Bah, ignore...  already commented on by Xiaoyao.

Reviewers: 2, Sean: 0

:-)

