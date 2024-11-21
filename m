Return-Path: <linux-kernel+bounces-417381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72D9D5342
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F6AB2A47C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913C1D9587;
	Thu, 21 Nov 2024 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLhaRYtK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2531D79BE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215451; cv=none; b=usZiyGETeZvsNyKZguwMtvJiaWIyhZKfot5+UaWhm0S4U+0lBybhoVIpetcbYiZorbKyb63KpM6kNKl5MSxnJ6fJXNLFeFKREZBAVA0TAKoRa7VHBmmmkGuiA8KqL5qPof1e6jov0X2234E/8IAFHJjp0/Nq6V2MMv6X/8vHNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215451; c=relaxed/simple;
	bh=SqxVB5S9ZnCXmJwg3D51+w4alkfmGLlr9ardQuDdsLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pk16zEK++iEZI0IZz2Z2iDPUwr70UrcSD4G62LXAFM832TuEzw67hOheVRncvG0X81kr46VOcyMFZ2jgtnFdWYXh93dHRDx4V6iy5GAUDtCdtEg2XHXArjoqo7G2pD9+o30RAIl2UdjJt9AuE8XMp+RMEOFpGvL70/h6uWFP2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLhaRYtK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e381c19246fso2166645276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215447; x=1732820247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtljJXMaf+UWOpBKMnoIRrXFTJsECASm8jaTE6OQZlo=;
        b=OLhaRYtKBYtoKl8xugwH9pZFyLgIyz5kRDXmQb023WpiZ1kQStJyb2GdQ/oFIcZe/v
         SKdj1HGfcU47Vm9IRH+L3YLrsxa6jd5vmUaN2U/uwnZZh3RCMJbQz20/q3zkRRgt4NnP
         7x2HWR9tHIG9X4SP3DD8Qp+jP51uzz48ge7zEYLCNnzCUJFhhUIsurAeN6YeC0E3OnhP
         bgh1bmgQxspL1znlxbGPV12Zcnm/LOSeLh5Euk8NHKkKtc0uM70Q8iobopjeIZsLIo56
         hg1mDssrx3Zrm80gChfo9spAKK1cOxlp5YyMtE5w40dG5TU6t1sLzAd4vaqGnuSSCGjV
         T1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215447; x=1732820247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtljJXMaf+UWOpBKMnoIRrXFTJsECASm8jaTE6OQZlo=;
        b=BeaqcEprAbxXoLd1NZ2+TY6rhFylRbsh7KtSp3HyrSwLekodwQB3e+XvE/JGip30aK
         t8zHQ1IRCu09iYzPVh9OuSDfvPzrdKu/oCSA8jtLbRKsSi+V+44DiVbn5pfQSk/t6aq+
         VlJG9VcRAP/CvFE/KpQBEEPUvIpNVFnLOz7tbv/031S4EM9uBBPI6If95IkqH+4ARWoJ
         T8l1Z33Se4bJQ8J7Bxs/5mJSgC7DqVujjZiaOskP5BMJxZhz7teA1O7ui1yRptNfzYhf
         x1fCZq6yAQLFsGz5x6DdP7FcO3U4FkE0+cZ2Swj81xp2mXs/zTwpRWAyLEFD8d+dr4XY
         UwCw==
X-Forwarded-Encrypted: i=1; AJvYcCXcQgs461k84z0ldDOT4sAArrF5fxvckb5z/WzGNc2075cHcge3YzKS8wc53dIdcP2XnuHqDd1f3XkbrKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OsK5+m9jyL5nU7k/hbsFXn7s8k8qAdzNkKQMt0KlkG4GiUlK
	RRUDyaIhnsM1X7MWxiiekLoakNiMBOcnc1ZP0p+4dCtOPJuU/958P7kPyBm7SU7kzzgTd1Pv3Ti
	qsg==
X-Google-Smtp-Source: AGHT+IFPhgD0+tZ8PuaJ5SHJ0gWlfVSVuDvUHEavOi5mjZNLvxVtFKB7zcRQ023335iVTGSmRK5UXkZAsBQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8811:0:b0:e38:b1c7:f48e with SMTP id
 3f1490d57ef6-e38cb533507mr11963276.1.1732215447374; Thu, 21 Nov 2024 10:57:27
 -0800 (PST)
Date: Thu, 21 Nov 2024 10:57:26 -0800
In-Reply-To: <3aeeed2f4ccca6ddd404553984f22bf1b72e45cf.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-6-seanjc@google.com>
 <6a8aee9425a47290c7401d4926041c0611d69ff6.camel@redhat.com>
 <Zow_BmpOGwQJ9Yoi@google.com> <3aeeed2f4ccca6ddd404553984f22bf1b72e45cf.camel@redhat.com>
Message-ID: <Zz-ClqMVuOrFlIZK@google.com>
Subject: Re: [PATCH v2 05/49] KVM: selftests: Assert that the @cpuid passed to
 get_cpuid_entry() is non-NULL
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 24, 2024, Maxim Levitsky wrote:
> On Mon, 2024-07-08 at 19:33 +0000, Sean Christopherson wrote:
> > On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > > On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > > > Add a sanity check in get_cpuid_entry() to provide a friendlier error than
> > > > a segfault when a test developer tries to use a vCPU CPUID helper on a
> > > > barebones vCPU.
> > > > 
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > > > index c664e446136b..f0f3434d767e 100644
> > > > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > > > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > > > @@ -1141,6 +1141,8 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
> > > >  {
> > > >  	int i;
> > > >  
> > > > +	TEST_ASSERT(cpuid, "Must do vcpu_init_cpuid() first (or equivalent)");
> > > > +
> > > >  	for (i = 0; i < cpuid->nent; i++) {
> > > >  		if (cpuid->entries[i].function == function &&
> > > >  		    cpuid->entries[i].index == index)
> > > 
> > > Hi,
> > > 
> > > Maybe it is better to do this assert in __vcpu_get_cpuid_entry() because the
> > > assert might confuse the reader, since it just tests for NULL but when it
> > > fails, it complains that you need to call some function.
> > 
> > IIRC, I originally added the assert in __vcpu_get_cpuid_entry(), but I didn't
> > like leaving get_cpuid_entry() unprotected.  What if I add an assert in both?
> > E.g. have __vcpu_get_cpuid_entry() assert with the (hopefully) hepful message,
> > and have get_cpuid_entry() do a simple TEST_ASSERT_NE()?
> > 
> 
> This looks like a great idea.

Circling back to this, I actually like your initial suggestion better.  Asserting
in get_cpuid_entry() is unnecessary paranoia, e.g. it's roughly equivalent to
asserting that any and all pointers are non-NULL.   The __vcpu_get_cpuid_entry()
assert though makes a lot more sense, because it's not all that obvious that
vcpu->cpuid is (usually) initialized elsewhere.

