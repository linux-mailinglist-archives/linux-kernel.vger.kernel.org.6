Return-Path: <linux-kernel+bounces-254318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01689331B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F5028167C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5641A2551;
	Tue, 16 Jul 2024 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lbLjj2y"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFC6A8CF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157062; cv=none; b=q8GC33Ou6vV3+AToiJkWjtozpQDg8Em31kT1gXm2etxhSMtGvtuV5XIxb7gx3fl5UFxrV64w+n9bec7EdNcWHboIJhRkYwR1jahDZYoZR9dADKPxLFLXooj8K56iQAP5IivXq5YcQBiqdctHQxsrSbs/iiNQhh5k27ghGXU954Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157062; c=relaxed/simple;
	bh=xMf7Ow4b4a9OO1SvUYk3WEUeFPCKBq0ZdqrtZP9RjKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sa5WWtudIyAbkj9fcYeKuRR6xg4452qfXfIQJelIswl1t23PVWcjtSu1fRdEOFQBZU81o2ylpZXXBm1XoBYw2IPwSGYWS/QFnzM34uniJNA0dQQ54P6e+jFISINcorA9jj4lpVc0O0eJxypT5jXtOTTjnPeWcwpYDtrE+RchkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lbLjj2y; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c96e73c888so6222744a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721157060; x=1721761860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQeWy9MtYTsUqUCd6Pp/Y8oHyCtDG2oiIHg+ZsZAyaw=;
        b=2lbLjj2yXVf1aqzOOV2fAVE9H48UtobFU3KN0DKyOXYx5oWbCNwOfDxx9V9hyabDFl
         O+nJ8X5RYMt20d/Ze2RE5a+2FQdk/RxaoZqbGqqUCOKW3hU0toQnq4VUfBM6ogI8i6Ci
         AZyBos86/+JhCQjyZ/f0iitvrY+CUnTLosdBKur4e7lNAapDhCtgd3ZAuHVYKCctjv1B
         OPrJ3j4tFBAL8TWV1ypXOF9qc45KxZUY/Mpg5qUGHRuokZphNrGhJ3TiZdQW+udt8X5H
         QGfvLYc2rrckqOGDesmKLmR6XJItXRcb4G5VDGffaIhxDnwXiGb9chA5BeKNfjQCkYtD
         E2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721157060; x=1721761860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQeWy9MtYTsUqUCd6Pp/Y8oHyCtDG2oiIHg+ZsZAyaw=;
        b=A928DChV5cJx9IT6V6B36FqxjXvnk4nxiqhY6gguHHMrQ2bgKIhkXdMSqTW4yL0IaO
         oWnKBFwO2amCW4hSkuxaitYTQ9AUQBIpmsk15ZFQVI8PDjmfRpIRZiMcpxk+tpPnj4vU
         ChkZMR5U3erqoPX+ps+BZXYyUbbeTWyq9jtcFtiM/bWmohajEVpKkAM4EwaOj4QyLFpw
         GpgCIqZLtTlY/LOlDOOpJH6z+dOA8QYJq4Ddi3xHsYJICW9ApKX56uzEN1tDJ7jAK8Zc
         brOU+PBj4B7F7etkNwgzToUe126g/VEunIMvUpvtJ/bHK5ycfdVJdoXYRdaVP+tcFOud
         BqVA==
X-Forwarded-Encrypted: i=1; AJvYcCVWI9a5dnP6JmpOrth1LsWOdqKwu8qoVdUUZGNoEJvHCDnWZuV3AtlWG2grfBo9tjMxs5XiLJDy++sgURl3mFg95rVmr++V2KVSMZ1x
X-Gm-Message-State: AOJu0Yx2YXjhhxZh0xtsXy7iHsUnwIRV3EonKTv3/FIuOxd8O/FhcYMa
	YN0zDWvqJAH6sST+t+cxvaz5TQNhR4U62MnIm+e1DNiEwgZVPNuNigcdsxlmBNJe6oBapiCgk8v
	Fag==
X-Google-Smtp-Source: AGHT+IFq21eBmqs1pEeWhmeC44PooSMgYBWsB4/30MxU7oGk1cFolirwLLxCJE9ZW98Wx18j0FxKAD0cOns=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:707:b0:2c9:6370:17eb with SMTP id
 98e67ed59e1d1-2cb36cd4759mr7685a91.3.1721157060370; Tue, 16 Jul 2024 12:11:00
 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:10:53 -0700
In-Reply-To: <ZpTeuJHgwz9u8d_k@t470s.drde.home.arpa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626073719.5246-1-amit@kernel.org> <Zn7gK9KZKxBwgVc_@google.com>
 <CALMp9eSfZsGTngMSaWbFrdvMoWHyVK_SWf9W1Ps4BFdwAzae_g@mail.gmail.com>
 <52d965101127167388565ed1520e1f06d8492d3b.camel@kernel.org>
 <DS7PR12MB57665C3E8A7F0AF59E034B3C94D32@DS7PR12MB5766.namprd12.prod.outlook.com>
 <Zow3IddrQoCTgzVS@google.com> <ZpTeuJHgwz9u8d_k@t470s.drde.home.arpa>
Message-ID: <ZpbFvTUeB3gMIKiU@google.com>
Subject: Re: [PATCH v2] KVM: SVM: let alternatives handle the cases when RSB
 filling is required
From: Sean Christopherson <seanjc@google.com>
To: Amit Shah <amit@kernel.org>
Cc: David Kaplan <David.Kaplan@amd.com>, Jim Mattson <jmattson@google.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 15, 2024, Amit Shah wrote:
> On (Mon) 08 Jul 2024 [11:59:45], Sean Christopherson wrote:
> > On Mon, Jul 01, 2024, David Kaplan wrote:
> > > > > >        /*
> > > > > >         * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the
> > > > > > Intel feature
> > > > > >         * flag and protect from vendor-specific bugs via the
> > > > > > whitelist.
> > > > > >         *
> > > > > >         * Don't use AutoIBRS when SNP is enabled because it degrades
> > > > > > host
> > > > > >         * userspace indirect branch performance.
> > > > > >         */
> > > > > >        if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) ||
> > > > > >            (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
> > > > > >             !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
> > > > > >                setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
> > > > > >                if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB)
> > > > > > &&
> > > > > >                    !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
> > > > > >                        setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
> > > > > >        }
> > > > >
> > > > > Families 0FH through 12H don't have EIBRS or AutoIBRS, so there's no
> > > > > cpu_vuln_whitelist[] lookup. Hence, no need to set the NO_EIBRS_PBRSB
> > > > > bit, even if it is accurate.
> > > >
> > > > The commit that adds the RSB_VMEXIT_LITE feature flag does describe the
> > > > bug in a good amount of detail:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> > > > d=2b1299322016731d56807aa49254a5ea3080b6b3
> > > >
> > > > I've not seen any indication this is required for AMD CPUs.
> > > >
> > > > David, do you agree we don't need this?
> > > >
> > > 
> > > It's not required, as AMD CPUs don't have the PBRSB issue with AutoIBRS.
> > > Although I think Sean was talking about being extra paranoid
> > 
> > Ya.  I'm asking if there's a reason not to tack on X86_FEATURE_RSB_VMEXIT_LITE,
> > beyond it effectively being dead code.  There's no runtime cost, and so assuming
> > it doesn't get spuriously enabled, I don't see a downside.
> 
> Ah - I get it now.  You want to add this code for parity with
> vmenter.S so that a future bug like this doesn't happen.
> 
> I disagree, though.  It's not really dead code - it does get patched
> at runtime.

Eh, we're splitting hairs over what's dead code where.

> If a future AMD CPU has a bug that Intel doesn't, we'll have to introduce a
> new ALTERNATIVE just for that condition - leading to more complexity than is
> actually required.

If and only if the bug was mitigated by FILL_RETURN_BUFFER.  And if we needed to
extend FILL_RETURN_BUFFER, then we'd need a new alternative regardless of whether
or not KVM SVM honored RSB_VMEXIT_LITE.

If the hypothetical AMD bug is fixed by a single stuffed return, then the kernel
would simply force set RSB_VMEXIT_LITE as appropriate.  If the bug requires a
mitigation somewhere between RSB_CLEAR_LOOPS and 1, we'd need to add more code
somewhere.

> Also - reviewers of code will get confused, wondering why this code
> for AMD exists when the CPU vuln does not.
> 
> I get that we want to write defensive code, but this was a very
> special condition that is unlikely to happen in this part of the code,
> and also this was missed by the devs and the reviewers.

Defensive code is only part of it, and a minor part at that.  The main "issue" is
having divergent VM-Enter/VM-Exit code for Intel vs. AMD.  To those of us that
care primarily about virtualization and are only passingly familiar with the myriad
speculation bugs and mitigations, omitting RSB_VMEXIT_LITE _looks_ wrong.

To know that the omission is correct, one has to suss out that it's (supposed to
be) impossible for RSB_VMEXIT_LITE to be set on AMD.  And as a KVM person, that's
a detail I don't want to care about.

FWIW, I feel the same way about all the other post-VM-Exit mitigations, they just
don't stand out in the same way because the entire mitigation sequence is absent
on one vendor the other, i.e. they don't look wrong at first glance.  But if KVM
could have a mostly unified VM-Enter => VM-Exit assembly code, I would happliy eat
a dead NOP/JMP or three.  Now that I look at it, that actually seems very doable...

> The good thing here is that missing this only leads to suboptimal
> code, not a security bug.

I don't think we can guarantee that.  Obviously this is all speculative (lolz),
but AFAICT, X86_FEATURE_RSB_VMEXIT_LITE doesn't imply X86_FEATURE_RSB_VMEXIT.

> So given all this, I vote for the simplicity of code, rather than tacking on
> something.
> 
> Sound OK?
> 
> 
> 		Amit
> -- 

