Return-Path: <linux-kernel+bounces-417732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303EE9D587A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB3E1F233E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2C7083C;
	Fri, 22 Nov 2024 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehfod1JM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DB230988
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732245484; cv=none; b=gb5aEZwzByNcuHLl2II2uopCsrYNhDZtDkFuncnK5BCH9/eP4VVl9fzCXYts1u7z2xnHHHfm2+PC7XQ4+fJA1WkpN8cAptWQArFpG6chtvRGeGjK9WZNBa3CeoqivNqH3yAT3nTm0IZOQr7yOPS1qnciZMefJfzS/HasySIp9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732245484; c=relaxed/simple;
	bh=c4xG9vuacevZNTMZpGFx+lbBp97ksMAHfmqZHanuPWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rEZiyVXKzmSvPn9/G3pLu6vEqMUJ95s/RvS2MjQcXYiWF0fRiclYwnpGx3CzYiX9cMREHhcAEXCtyjjFYkkwIjPw9UM8dLHLO2xxajxv5PoLw10dQdE0cDyfHPQSik+ZXph51jMoqX+83rJH8DlBEJ+77qIvslNXysH3xH4/E2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ehfod1JM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732245481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJopdvGtdSHSgdTNgTCjjcQqxbc7Sde9lChDv4fkdrM=;
	b=Ehfod1JMJY92K4ge53Xq+pzOco3EOaQYPjxaqR85UdgChopZJyMvaj+/fz352CkL5dWLzj
	h5fxI7WxKq+dVuUfPHJlZuE3hv/L6JVZh6QjewGI3cbRlY80jK9Zx0itrZXdyZF3+Uu800
	/GdX/hhTgeDEy3SLZm7veObzD5WOOJg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62--fIT85_VPIq8Lf-QmLe6Qg-1; Thu, 21 Nov 2024 22:17:59 -0500
X-MC-Unique: -fIT85_VPIq8Lf-QmLe6Qg-1
X-Mimecast-MFC-AGG-ID: -fIT85_VPIq8Lf-QmLe6Qg
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b1581d41dcso187033485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732245479; x=1732850279;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJopdvGtdSHSgdTNgTCjjcQqxbc7Sde9lChDv4fkdrM=;
        b=DAlOyX0BVCW05ioO6Fy3DrmdZDh/VK7unxmfAY+/sNaQbED8gzeuEvWQUTo+5mE/Z/
         CM26hAU0rHIQBlrnGHdTbqHd6dmU9zXMJhyqDJd3TNFBEiAHtdkZKVfozjtv8pKo57qz
         Xyam+g4Tyi8/tgOnzYIJDPnEcA+GkAzLeS3PgSuQK7cN+1h3ocA6YWbNOPqXKIq1n37L
         b4zNC4Wf0eHoBHGdSXcK+KyYpBMNLGqcsQ7lsXcQb1HzNfJlRDPunzHZ/eiyt2bdzJaX
         fY2bbS7qIANddVRBd/hzHmG2QPhuJioG7TrYo02IEhlFG9Ut1KVO5FLLx+IwU6qQw281
         Vy/g==
X-Forwarded-Encrypted: i=1; AJvYcCWtJCdmV2XGqya4UxbV8fApiSKiJ8q6+XXHpoX3CRk3TLzTAGPqs1gUBidaTELE7ON8K8ny2MtRoGdXxfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22j/IJqhq8/vCZ3QvQGqmNT8Ur8NuYcDtp4GRF1Q/ZX41+uqo
	bKzRCdi6UBpshngm35oYJ8JZkyJd/PQTXuqqjqrQVf8U05BEve3iGA/iF8bMUFGlofj8t5QWeAE
	EqCImPC0qG+Ah/ralxiQ6nGkigsJGcG4qsIizzZh1gS+X9wS3Q6cxPw5bQgiVCg==
X-Gm-Gg: ASbGncuNryF6HyniJEJyNGCs7AbAfOPrhy6FK2lJuZjmSfv93zUfue23PqFtqGnUHiZ
	k76MNdOIqKWCbjxNfSvTQgzdDVRFpvf/0NhV5G8+d4xeAEeVlnTKL/YNqsH2RLYrcx1XT0tOxzB
	guojCBdlylBH7Shcqf+zs21ASoTibMkHqkNGYaoi6vno5EyFMY5ozkJvMRia2hi26cfGyrVHxnv
	MiBcCGHTvStChHke7UzvbEJuBdWF/gRrGl5SlLydGlbNYa2Hw==
X-Received: by 2002:a05:620a:2604:b0:7b1:5763:4ba5 with SMTP id af79cd13be357-7b5146048c8mr166801485a.51.1732245479080;
        Thu, 21 Nov 2024 19:17:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEch9B3bdAsLQHyb1TbdZGO2HoTk/rwHkhUPDcurD/9bYYvKyc/41ocDo++gxOxEBl6N7HFAA==
X-Received: by 2002:a05:620a:2604:b0:7b1:5763:4ba5 with SMTP id af79cd13be357-7b5146048c8mr166798785a.51.1732245478742;
        Thu, 21 Nov 2024 19:17:58 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b513f90428sm45462385a.17.2024.11.21.19.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:17:58 -0800 (PST)
Message-ID: <cbcb80ee5be13d78390ff6f4a1a3c58fc849e311.camel@redhat.com>
Subject: Re: [PATCH v2 22/49] KVM: x86: Add a macro to precisely handle
 aliased 0x1.EDX CPUID features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 21 Nov 2024 22:17:57 -0500
In-Reply-To: <ZuG5ULBjfQ3hv_Jb@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-23-seanjc@google.com>
	 <43ef06aca700528d956c8f51101715df86f32a91.camel@redhat.com>
	 <ZoxVa55MIbAz-WnM@google.com>
	 <3da2be9507058a15578b5f736bc179dc3b5e970f.camel@redhat.com>
	 <ZqKb_JJlUED5JUHP@google.com>
	 <8f35b524cda53aff29a9389c79742fc14f77ec68.camel@redhat.com>
	 <ZrFLlxvUs86nqDqG@google.com>
	 <44e7f9cba483bda99f8ddc0a2ad41d69687e1dbe.camel@redhat.com>
	 <ZuG5ULBjfQ3hv_Jb@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-09-11 at 08:37 -0700, Sean Christopherson wrote:
> On Tue, Sep 10, 2024, Maxim Levitsky wrote:
> > On Mon, 2024-08-05 at 15:00 -0700, Sean Christopherson wrote:
> > > If we go with ALIASED_F() (or ALIASED_8000_0001_F()), then that macro is all that
> > > is needed, and it's bulletproof.  E.g. there is no KVM_X86_FEATURE_FPU_ALIAS that
> > > can be queried, and thus no need to be ensure it's defined in cpuid.c and #undef'd
> > > after its use.
> > > 
> > > Hmm, I supposed we could harden the aliased feature usage in the same way as the
> > > ALIASED_F(), e.g.
> > > 
> > >   #define __X86_FEATURE_8000_0001_ALIAS(feature)				\
> > >   ({										\
> > > 	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);	\
> > > 	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_8000_0001_EDX);	\
> > > 	(feature + (CPUID_8000_0001_EDX - CPUID_1_EDX) * 32);			\
> > >   })
> > > 
> > > If something tries to use an X86_FEATURE_*_ALIAS outside if kvm_cpu_cap_init(),
> > > it would need to define and set kvm_cpu_cap_init_in_progress, i.e. would really
> > > have to try to mess up.
> > > 
> > > Effectively the only differences are that KVM would have ~10 or so more lines of
> > > code to define the X86_FEATURE_*_ALIAS macros, and that the usage would look like:
> > > 
> > > 	VIRTUALIZED_F(FPU_ALIAS)
> > > 
> > > versus
> > > 
> > > 	ALIASED_F(FPU)
> > 
> > This is exactly my point. I want to avoid profiliation of the _F macros, because
> > later, we will need to figure out what each of them (e.g ALIASED_F) does.
> > 
> > A whole leaf alias, is once in x86 arch life misfeature, and it is very likely that
> > Intel/AMD won't add more such aliases.
> > 
> > Why VIRTUALIZED_F though, it wasn't in the patch series? Normal F() should be enough
> > IMHO.
> 
> I'm a-ok with F(), I simply thought there was a desire for more verbosity across
> the board.
> 
> > > At that point, I'm ok with defining each alias, though I honestly still don't
> > > understand the motivation for defining single-use macros.
> > > 
> > 
> > The idea is that nobody will need to look at these macros
> > (e.g__X86_FEATURE_8000_0001_ALIAS() and its usages), because it's clear what
> > they do, they just define few extra CPUID features that nobody really cares
> > about.
> > 
> > ALIASED_F() on the other hand is yet another _F macro() and we will need,
> > once again and again to figure out why it is there, what it does, etc.
> 
> That seems easily solved by naming the macro ALIASED_8000_0001_F().  I don't see
> how that's any less clear than __X86_FEATURE_8000_0001_ALIAS(), and as above,
> there are several advantages to defining the alias in the context of the leaf
> builder.
> 

Hi!

I am stating my point again: Treating 8000_0001 leaf aliases as regular CPUID features means that
we don't need common code to deal with this, and thus when someone reads the common code
(and this is the thing I care about the most) that someone won't need to dig up the info
about what these aliases are. 

I for example didn't knew about them because these aliases are basically a result of AMD redoing 
some things in the spec their way when they just released first 64-bit extensions.
I didn't follow the x86 ISA closely back then (I only had 32 bit systems to play with).

Best regards,
	Maxim Levitsky



