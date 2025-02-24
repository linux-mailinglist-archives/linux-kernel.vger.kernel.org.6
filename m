Return-Path: <linux-kernel+bounces-530177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E44A43028
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8211F1891E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CAE1CD1E4;
	Mon, 24 Feb 2025 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLCG/Uhd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95172571B2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436358; cv=none; b=fgVYhXI7FMAzUzfbzLymiEQh1RYOmM+QitfUA5Px/oQhIdHCW0hcqc4CWi0mVE9wAa3y1o3eWvg0QXoS33hOaLi10D+YqsJfadYt3uDD6B1uTpIXMP9EinO+Ks/PDYEgziBX8f6+eTqhkAywH1FClNSy1MI/YxF61j2Bv3SIrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436358; c=relaxed/simple;
	bh=lR5+K2O0C7fa3hblXHm0+cUXI+NHjy4Oog7sgRxfZDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oyjyvJCr+pJSZ1os0g2yxiC0YARmX6k3Ou8P/5qQJEmBI37yPcWHIeEvjFXI7UjQrqOMiiOcIfq7F/2oD8+nRJuUsc5vcjItgs7WqbtvR/YZlUCnG52SMvFdFxvGoqeebdJEhBuolg0zUCp0CAGLlYZ9phkiAN9bq2FG84kOogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLCG/Uhd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2210305535bso163449785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740436356; x=1741041156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ602F89Qrv98s0dTpyvrapFlWCXZ4Q+ukdN0YogNYc=;
        b=tLCG/UhdftbDpTzcxPLk+q3MhOnF0jbS5KzVBsWCsPtq6XpjxbDfEfSDeX081pBW0Y
         tq8g/IIqVqpg3GZa3x41efGjPXppBXxEkonn1BjIffkSItuVqACahhemD17rQy3nJ65H
         kNMZxTEmQpBtwn8fxxtpqxPHnJjTR4uaU+jjZ3svRXCCUsplGHJsovSIczOTJmUapjEW
         Nyv6iUABFlQP+deJVqoZiT2+9wLXtQxG4DfcLXUVlft6bJuXD6sb/iopU+CqsQevDuPz
         C3GSStgQdMcQ2PtYn7cFMXGB2/eIB0In/s1Ksd7LY8K2otZWrmu3mbxZHhzKqaDxOe3G
         bgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740436356; x=1741041156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ602F89Qrv98s0dTpyvrapFlWCXZ4Q+ukdN0YogNYc=;
        b=PPnpAOoEQJll2rFl89bHzCMTjyXFTHNwUcY+2BTDZKEtocXklTAxnbI24F3EW5Uvdc
         i/vTdLVbyuQtkNUfAh1OuM/D7OvKuCJAUk+Hc6ExAZ4wt3/726+VPID6Px6niG8+ZGKW
         nXO/FF5rq7un6Ua12psXFjuVXAKex/3fSyQmHRPnU1fEFU4Rd+xoasMhowHnxEZpmM4s
         WPDmVdKs1AD8NYDXLw/bIdLN7UaI+nArZZMI7uGDt9PjpO7Zynn9KyQNo+qxaFDWN+r2
         0zHNSff3je7ABXZJevxlqiXScduX5Nl+weO1geKGT01sWsfw3PuqTf1CccP5j4TKm6s4
         n9JA==
X-Forwarded-Encrypted: i=1; AJvYcCWiY130oJd/Y+zpLdm256ejzxjauqmQMffgJlLPSrqwAa3sV7/jrLaNbZFOU9QgH5TrqZMavXTZN03oxkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuu4zix8NttP93DsBVZuCWqqzzQm0zwz8oDE598JHQzf2ORdsv
	2o/wIUoimhi/81lz5frZSXeuOOPICGdZWiuKiscVOVJQt1rA3WciFUa+lpoomd63bHZ1Mc4qpyv
	uvA==
X-Google-Smtp-Source: AGHT+IFqOEUKQsuWHVPpQJ0lKf4SviNWdzaOb6PyYguj4zrO83Ubft771/46kQy1zz7pRXushkp2tdi5FeE=
X-Received: from pjyp12.prod.google.com ([2002:a17:90a:e70c:b0:2fb:fa85:1678])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0f:b0:21f:52e:939e
 with SMTP id d9443c01a7336-221a10deb2amr283318145ad.28.1740436356245; Mon, 24
 Feb 2025 14:32:36 -0800 (PST)
Date: Mon, 24 Feb 2025 14:32:34 -0800
In-Reply-To: <7794af2d-b3c2-e1f2-6a55-ecd58a1fcc77@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219012705.1495231-1-seanjc@google.com> <20250219012705.1495231-3-seanjc@google.com>
 <7794af2d-b3c2-e1f2-6a55-ecd58a1fcc77@amd.com>
Message-ID: <Z7zzgtS-iu0YHwia@google.com>
Subject: Re: [PATCH 02/10] KVM: SVM: Don't rely on DebugSwap to restore host DR0..DR3
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 24, 2025, Tom Lendacky wrote:
> On 2/18/25 19:26, Sean Christopherson wrote:
> > Never rely on the CPU to restore/load host DR0..DR3 values, even if the
> > CPU supports DebugSwap, as there are no guarantees that SNP guests will
> > actually enable DebugSwap on APs.  E.g. if KVM were to rely on the CPU to
> > load DR0..DR3 and skipped them during hw_breakpoint_restore(), KVM would
> > run with clobbered-to-zero DRs if an SNP guest created APs without
> > DebugSwap enabled.
> > 
> > Update the comment to explain the dangers, and hopefully prevent breaking
> > KVM in the future.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> See comment below about the Type-A vs Type-B thing, but functionally:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> > ---
> >  arch/x86/kvm/svm/sev.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index e3606d072735..6c6d45e13858 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -4594,18 +4594,21 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
> >  	/*
> >  	 * If DebugSwap is enabled, debug registers are loaded but NOT saved by
> >  	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU both
> > -	 * saves and loads debug registers (Type-A).  Sadly, on CPUs without
> > -	 * ALLOWED_SEV_FEATURES, KVM can't prevent SNP guests from enabling
> > -	 * DebugSwap on secondary vCPUs without KVM's knowledge via "AP Create",
> > -	 * and so KVM must save DRs if DebugSwap is supported to prevent DRs
> > -	 * from being clobbered by a misbehaving guest.
> > +	 * saves and loads debug registers (Type-A).  Sadly, KVM can't prevent
> 
> This mention of Type-A was bothering me, so I did some investigation on
> this. If DebugSwap (DebugVirtualization in the latest APM) is
> disabled/unsupported, DR0-3 and DR0-3 Mask registers are left alone and
> the guest sees the host values, they are not fully restored and fully
> saved. When DebugVirtualization is enabled, at that point the registers
> become Type-B.

Good catch.  I completely glossed over that; I'm pretty sure my subconcious simply
rejected that statement as wrong.

> I'm not sure whether it is best to update the comment here or in the
> first patch.

Probably first patch.

