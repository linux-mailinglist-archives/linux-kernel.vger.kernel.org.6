Return-Path: <linux-kernel+bounces-532339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B738A44BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1283B551C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9E20E028;
	Tue, 25 Feb 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xx4qPyv7"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD13D984
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513032; cv=none; b=AZFpTvU2Kuvtdiv5CLJ4D/AmJFrNry+6BTGEZPzkobSOJnW+Jxqah74Las/+y2LX93qYerFwVETXqqvmIzdR/ujxOcmO1mCe+rg8eEKFnkIuZwZ7NNWyi5t4eS5bIS2CEx6ujK9NafKV2u/M6fBILydJUKEFOnNiXCLcTFo0F4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513032; c=relaxed/simple;
	bh=1Zy2XDxcWg+1LkmYMbs1r3piUQe9Sjreh7wFFivRA54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jYVu7qGyp6/xKMuGUKSAAQ+r9iy41Hlr2yX9JLf6RPKetEd3CrPuoq+PCP14NNCYv+oyuN/fI90Rg/YrfgC085jDWBui+0LUIG46ewF7rkjoCEZUlI7ISOwNTygYCWe1j9QkWPJgNZJZ4iHhReEPoptr2Dc2F6zLBpcaqfRbggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xx4qPyv7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso19853805a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740513030; x=1741117830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6Et9fr82xY+XYRvIYbqLbXzncb7Clblhbzo1eZXaAE=;
        b=Xx4qPyv7S3IPT8sT48IvG07WH2dWb4yBzLVUdO6eQawYS4VlUN8EpVByzGvjO1cIsX
         MwbYxCcFcTiAkgXaoWOcRUNKMwiEiqhdh5OhIS4XRVHFrQzZ2C59EKVsarsMY6etmrSf
         cEdcaCv6z8EUSPbh9dCesZPUoYTkWQ2Jurq0NIBYznQDeETU/owdSdnlxsP5GNAh2fzk
         HEU7hNq6RDCKoUycUeL6RO24LxghEZ7l9uCPvanDa+Pjbqn2wmpNX0/HpAu/GavSH+gr
         EaokrFFrhXnDhC9g4aaTkjFY0bFTG6EZB5vOQ8NazAxLvLZvP02CVvs0u/79yygmBUnh
         QXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740513030; x=1741117830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6Et9fr82xY+XYRvIYbqLbXzncb7Clblhbzo1eZXaAE=;
        b=rsD/o8RgPREcv2b2aJfbpW3mO0IfX0psuec6zS0WGnZBgBZVQ6rBbprBk+YOmOOzpO
         P9wP+l0GCz+PbgtPBTNhsk3kHTlM2lMVIMic80DWuqlwY9ccEwd9qm8E8xYu0Jfi8e10
         ehFT3D0ia6VMZdq+zHJZjYX6+C9yWacQGfxa4xLsjiAQ3tswsyJxhhvA1zxVAguCTPML
         K0LdCGJwzXb8O9lAX0XIlurvWIanPTtNkYjZvs9mtVTk4yXDrbjmCuneiKFpxu86NeVo
         bvO4xQ6Y/qLCPSDXSEU//LMbAB1LPI7/6NCfsJxkuBlI4MQvxByLcpvQUphFQgYC/l1I
         Rhmg==
X-Forwarded-Encrypted: i=1; AJvYcCVg2uUyt5ErYcHTcgZ0SFMS9fpfzZrT5xd39ahFjBoROqh/RbnHSIN4O9NPPXcP5FSdIo4nQ7a2hjJRS6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8QUWIyaEDHY80IpekTDDTpfItWm3+IjGptn2w69Kj2ow2dQi
	4e7X0CdkkEa1wY5NlBgRH9TrYEJyuW4buIhYO/NG1Nizp6furgG50qMoVCORV2MmsrQ+ZGFA2L+
	CKA==
X-Google-Smtp-Source: AGHT+IFG+wtu4XcbCmspoDw9L7aeoOS3H04Pvzf76WDj3NCQXzv9+gVkzgnl5jM4Kix+lDfLumAY6Da7HIU=
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:2fc:201d:6026])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548c:b0:2ee:6d04:9dac
 with SMTP id 98e67ed59e1d1-2fe7e3b3228mr829766a91.32.1740513030464; Tue, 25
 Feb 2025 11:50:30 -0800 (PST)
Date: Tue, 25 Feb 2025 11:50:29 -0800
In-Reply-To: <20250219220826.2453186-6-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev> <20250219220826.2453186-6-yosry.ahmed@linux.dev>
Message-ID: <Z74fBQLeXxuiBC-U@google.com>
Subject: Re: [PATCH 5/6] KVM: nVMX: Always use IBPB to properly virtualize IBRS
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 19, 2025, Yosry Ahmed wrote:
> On synthesized nested VM-exits in VMX, an IBPB is performed if IBRS is
> advertised to the guest to properly provide separate prediction domains
> for L1 and L2. However, this is currently conditional on
> X86_FEATURE_USE_IBPB, which depends on the host spectre_v2_user
> mitigation.
> 
> In short, if spectre_v2_user=no, IBRS is not virtualized correctly and
> L1 becomes suspectible to attacks from L2. Fix this by performing the
> IBPB regardless of X86_FEATURE_USE_IBPB.
> 
> Fixes: 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when guest has IBRS")
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

