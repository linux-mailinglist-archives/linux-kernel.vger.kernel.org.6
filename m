Return-Path: <linux-kernel+bounces-328657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AAC9786FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EE328AAE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5B84DF1;
	Fri, 13 Sep 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2k6XDHLI"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1F1C2BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249161; cv=none; b=O4HLK5p55bT2PHVMBQQ9hZP9mrS4UVz7KALlt0CYk1tBgDt9KgUzLNBDNNr1FJB1cTpZEI/w/dBlycn0SVDt+IF4rv14xD3A0nmzwaBJaJ4ay9Oztog4BNMEcH2nL3feElAt5JxvyAcOAwH5FelK8uZcPvZmzRyPzEzzkKjFJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249161; c=relaxed/simple;
	bh=evRLds+DdPC5pyCASAV4XWXLDt2x6Uv90fA6yJV1gPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bFr9EYKytfTC/qFywUCC4fzf+b3omRCh0+FPm1+yGP/iDacS8NgcJRHniMZUDAVTLfPCg5CZnGU1EBr7jFiP7ts36/Ijt+kA+idxGtFq+YCW8hRaqf1h00pBE8tqs9Ni58ZllDdxmwwOnM6G3jVFQlbmTo83vxnG3CbFdW6lWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2k6XDHLI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71923d87da2so2792172b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726249159; x=1726853959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ba0FHqDBHCbI118uGJsUV1vp4JaUj/8z5TMh6FauZPc=;
        b=2k6XDHLIVcPN8BOxgyOtF2UfAJo03uolhQy9j0IZAB7Pcg8FbRVh+q8Z9wOICHKm4q
         77N2eBC4sNOVzcVv5HKsidPJnj941dGxl9z8iV7HKdbQQeM2gVZD2eAI8kRuRHhAHMSD
         TqsD94y7rftZv+h/jgf1Xh//Cs/fF8+n2kqYWoQAvNA3CLvFSb6KewuRMfAwIBB3Z6Tt
         53bsa/ycG42OiYggXfnIsslJJyUZFOSjTBlY1xbsFkoGZju2oFpf0Z9li6TjpK6+PyuI
         SLZ2e9oZMxm+cAesYZtsOB9Tw5Ji5vbAJUaAF1+x6xd/7bL7aRhA29wuyAk2L5dJisu3
         G5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249159; x=1726853959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ba0FHqDBHCbI118uGJsUV1vp4JaUj/8z5TMh6FauZPc=;
        b=giRE5Kjfu4hDyS6NQpBFm5tKpr1XY1Zp3Ts00zQ9aeJCUbMlvYFXZuyIbzafsa/++f
         D+3uPvAUc4IT0l7AaFtPjmS882OEUpIQ5/Biybxt1BbADywZJCyvYc6hTasYNOoyW8e/
         on6HroKjoKqC8vElfM32dAEYHDaBikd+xNwD9+m/OeURsJ+dxjBGMJdkc+VFIfINwcJ9
         ZxyRwcPYv7bj9P0V+0qULz0xjBXNPA125PKQ8KcYOCP6Vccyqy6+Gt5YlLmKbzgQLDrq
         4GREj9CfjSFq5c5eStXh1rY7j7SDFCWg97g6kmsn7t/F14ThpmNNKP5HN1VMJ4HxBGd8
         0G0w==
X-Forwarded-Encrypted: i=1; AJvYcCVvPfrjom5xboSQSB5OYAKRde00pe6eGrlDYlsPjzyE75SckSKzH214XjyakLK9cqk4CQypt5x3nBjYK1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uohK7nD4OplygLXpKtAFmNxnEFrjil2wVaxLt0TgZwsE7piH
	ZiiV0C21f5YLjT/bC41KD6CumecdIyo3Eiy2aChfXNVngTa9S+B9vIR7FAylx71zmYZIyJ4sJ6S
	Hxw==
X-Google-Smtp-Source: AGHT+IFIw5bwLE9Jkesd/6So5FmVUUhFVWaY5epVthqEhVMkYSprKp3lhtrI3TJV+i3Bx+4kH28A8vyKt68=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f09:b0:718:dfec:9570 with SMTP id
 d2e1a72fcca58-719263748bbmr14398b3a.6.1726249159126; Fri, 13 Sep 2024
 10:39:19 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:39:17 -0700
In-Reply-To: <74fe44da-b99e-4fe6-b07c-43a146184e7c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com>
 <ZttwkLP74TrQgVtL@google.com> <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com>
 <ZuHC-G575S4A-S_m@google.com> <h5gp6dgcfazm2yk3lorwqms24c2y2z4saqyed6bnzkk2zhq5g2@rf3lj2a22omd>
 <039bc47c-9b5d-41f3-87da-4500731ad347@intel.com> <2v2egjmdpb2fzjriqc2ylvqns3heo5bpirtqm7cn32h3zsuwry@y5ejrbyniwxq>
 <c0d9ff5f-85d5-4df0-94a8-82e3bf6fe21f@intel.com> <ZuRoE6P3DxxK_3C9@google.com>
 <74fe44da-b99e-4fe6-b07c-43a146184e7c@intel.com>
Message-ID: <ZuR4xUoJRX7gWX1r@google.com>
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Gladkov <legion@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 13, 2024, Dave Hansen wrote:
> On 9/13/24 09:28, Sean Christopherson wrote:
> >> because folks would update their kernel and old userspace would break.
> >>
> >> Or maybe we start enforcing things at >=SEV-SNP and TDX and just say
> >> that security model has changed too much to allow the old userspace.
> > Heh, that's an outright lie though.  Nothing relevant has changed between SEV-ES
> > and SEV-SNP that makes old userspace any less secure, or makes it harder for the
> > kernel to support decoding instructions on SNP vs. ES.
> 
> The trust model does change, though.
> 
> The VMM is still in the guest TCB for SEV-ES because there are *so* many
> ways to leverage NPT to compromise a VM.  Yeah, the data isn't in plain
> view of the VMM, but that doesn't mean the VMM is out of the TCB.
> 
> With SEV-ES, old crusty userspace is doing MMIO to a VMM in the TCB.
> 
> With SEV-SNP, old crusty userspace is talking to an untrusted VMM.
> 
> I think that's how the security model changes.

I agree to some extent, but as below, this really only holds true if we're talking
about old crusty userspace.  And even then, it's weird to draw the line at the
emulated MMIO boundary, because if crusty old userspace is a security risk, then
the kernel arguably shouldn't have mapped the MMIO address into that userspace in
the first place.

> > I also don't know that this is for old userspace.  AFAIK, the most common case
> > for userspace triggering emulated MMIO is when a device is passed to userspace
> > via VFIO/IOMMUFD, e.g. a la DPDK.
> 
> Ahh, that would make sense.
> 
> It would be nice to hear from those folks _somewhere_ about what their
> restrictions are and if they'd ever be able to enforce a subset of the
> ISA for MMIO or even (for example) make system calls to do MMIO.
> 
> Does it matter to them if all of a sudden the NIC or the NVMe device on
> the other side of VFIO is malicious?

