Return-Path: <linux-kernel+bounces-550010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B5A559DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7C61896212
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315127C86E;
	Thu,  6 Mar 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9COs/t9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5B2780E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300486; cv=none; b=U9hMpBZWPr1KdLUY+oCPACzm8hnxrC0d19xf/5rNrdGRdL7muQqHC0/iM1YUlduYEVB8fMI5iL+UxJoZ3GHq1+ToS1qOxLCugVMMjhBbQNabsTzkpPySDN7ZG5408NoYcgHt7fpFu3doVqvo7fEmYoixFi/X7t2l474+kphZ6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300486; c=relaxed/simple;
	bh=BtIbPhI38qp07gbI0TeDj3JUTELlfa/KyGrSnU/OTrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUr1U0mbYFm/d+p0OfUMGsRB3pWD/RMklVqi+xS34xbi5+MJ72cebAQa5yMJOVQtqnDOxDQnKTqmANA07f960IV8mKyfJa/vA8Ze+KbBU1DfNQpFa1zRVxkG3QwmJnbCzDtfCBvKLBGQNSmS82XLp+U3rYIVKoDOInUft0NnDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9COs/t9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741300483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BilRY5BACzEHpukifJM+gKV3ZZdDrYiinDyskuIlJeA=;
	b=F9COs/t9b2OWO8muKkMvyZ6GRvoMXbkKjQ4V6pO7qQcZKdY4ta0yTo4VdguC76cwHzcsC5
	TOEhpOH2nYucU9MjN0QUt7Zfd7dFaMNg1PlUqtrGMvDM547ggEBY3DtrGK3xgRbxQThzEC
	anPIIh5xqAyLkZfrGqhVBkBCAv0ejFg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-zsAoxb-aMQK3EBRsn48fAw-1; Thu, 06 Mar 2025 17:34:41 -0500
X-MC-Unique: zsAoxb-aMQK3EBRsn48fAw-1
X-Mimecast-MFC-AGG-ID: zsAoxb-aMQK3EBRsn48fAw_1741300481
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390ddb917abso616452f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 14:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741300481; x=1741905281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BilRY5BACzEHpukifJM+gKV3ZZdDrYiinDyskuIlJeA=;
        b=wmO7oZoxPrxByrHclxEzT10B9PhQuOtXN/sYu0Ba/C92A/AviOHnOahw/52MoqYdfr
         6sF2JesP2PSwgDhAL9JbRkjJ0TjMaJhC7NAQQgjIan238SKB0fR02phexdCL+3LJU/4q
         BYWiQNqrphPS64CSjpqUBrHunDJ4RAmxqcde/gjlhVTpMDE92mjQ77csYssbuee6cSGB
         zMVFzC3D0L0CX+aZywLqqFlLdJjcpGvNSubX3R+pjFm1kgSMw8UbCyw7WYJ3TalSEGYb
         84mwJJulIuwnHrOkFjndJH8sFmDu4klrqsGqZTdLuSAGPj3kngxLqNojJK7Duj8/8DLd
         FZRA==
X-Forwarded-Encrypted: i=1; AJvYcCWCV5/sxxctGhVtm0GW9/ocDnK62wRFwJULfaZdUfrjVTJBwkxZNdeJVlxWxteTe/FA16Py9Fhw+8AKd7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbAn/iMLdHFi25lM913xKPRe2KOd7MeZjDQgyrq5OmkeI9/IU
	rJgLGGtI/r3TX7Wm07P0kuQl2EFxw4PNmWYNECBJZJ1/o1p9lY/SSMflAbeE17Nxp+99zLi9tVv
	z6/a5/bH8rWWshdcKCmkEOMwCKe4uNq+shI5PnseLCpnGzqVDLhWe+ZVpGhdq1uZCqaKgrY0Wal
	E/ASdryNPaqIhm7+BKv6yaMnDiLKPZXfuqTGg+
X-Gm-Gg: ASbGnctdMVRm7Wk4L41KnyCYv3fIKFjklEeGpdpY4lz3UGjzo3+8mliTxFSM5kqkPDo
	ao7ACEQWQCf/fDpb1dxhatA2uo1cvODuU8ocRFUTIvz3EHw+sXOEy8ibTv0QS/gCfMB6D6KQF
X-Received: by 2002:a05:6000:144d:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-39132d20ceemr534183f8f.1.1741300480757;
        Thu, 06 Mar 2025 14:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK2EMShg4ohlF52cmlouKCNWhj8j4BBHC3K5pQSbYyNoFw0hEDwZVBUJjNBO6PSe3AofJ29y4UpDODjkRDTcg=
X-Received: by 2002:a05:6000:144d:b0:391:2ab1:d4b8 with SMTP id
 ffacd0b85a97d-39132d20ceemr534165f8f.1.1741300480399; Thu, 06 Mar 2025
 14:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129095902.16391-1-adrian.hunter@intel.com>
 <20250129095902.16391-3-adrian.hunter@intel.com> <01e85b96-db63-4de2-9f49-322919e054ec@intel.com>
 <0745c6ee-9d8b-4936-ab1f-cfecceb86735@redhat.com> <Z8oImITJahUiZbwj@google.com>
In-Reply-To: <Z8oImITJahUiZbwj@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Mar 2025 23:34:28 +0100
X-Gm-Features: AQ5f1JqTpJhq2GqsAPYj4TNSCMsB06Ct7v94uxnewQAR7wWqwkCxu-rREFnHttg
Message-ID: <CABgObfahNJWCMPMV101ta-d0Cxu=RjjfMkKbOWTdRmk_VtACuw@mail.gmail.com>
Subject: Re: [PATCH V2 02/12] KVM: x86: Allow the use of kvm_load_host_xsave_state()
 with guest_state_protected
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	kvm <kvm@vger.kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"Huang, Kai" <kai.huang@intel.com>, reinette.chatre@intel.com, 
	Tony Lindgren <tony.lindgren@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "Yang, Weijiang" <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Il gio 6 mar 2025, 21:44 Sean Christopherson <seanjc@google.com> ha scritto:
> > Allowing the use of kvm_load_host_xsave_state() is really ugly, especially
> > since the corresponding code is so simple:
> >
> >         if (cpu_feature_enabled(X86_FEATURE_PKU) && vcpu->arch.pkru != 0)
> >                         wrpkru(vcpu->arch.host_pkru);
>
> It's clearly not "so simple", because this code is buggy.
>
> The justification for using kvm_load_host_xsave_state() is that either KVM gets
> the TDX state model correct and the existing flows Just Work, or we handle all
> that state as one-offs and at best replicate concepts and flows, and at worst
> have bugs that are unique to TDX, e.g. because we get the "simple" code wrong,
> we miss flows that subtly consume state, etc.

A typo doesn't change the fact that kvm_load_host_xsave_state is
optimized with knowledge of the guest CR0 and CR4; faking the values
so that the same field means both "exit value" and "guest value", just
so that the common code does the right thing for pkru/xcr0/xss, is
unmaintainable and conceptually just wrong.  And while the change for
XSS (and possibly other MSRs) is actually correct, it should be
justified for both SEV-ES/SNP and TDX rather than sneaked into the TDX
patches.

While there could be other flows that consume guest state, they're
just as bound to do the wrong thing if vcpu->arch is only guaranteed
to be somehow plausible (think anything that for whatever reason uses
cpu_role). There's no way the existing flows for
!guest_state_protected should run _at all_ when the register state is
not there. If they do, it's a bug and fixing them is the right thing
to do (it may feel like whack-a-mole but isn't). See for example the
KVM_CAP_SYNC_REGS calls that Adrian mentioned in the reply to 05/12,
and for which I'll send a patch too: I haven't checked if it's
possible, but I wonder if userspace could misuse sync_regs() to change
guest xcr0 and xss, and trick the TDX *host* into running with some
bits of xcr0 and xss unexpectedly cleared.

TDX provides well known values for the host for all three registers
that are being restored here, so there's no need to reuse code that is
meant to do something completely different.  I'm not singling out TDX,
the same would be true for SEV-ES/SNP swap type C.

Paolo


Paolo


