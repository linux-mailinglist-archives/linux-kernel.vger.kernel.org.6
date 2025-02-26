Return-Path: <linux-kernel+bounces-534683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FCA469EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D14A167A53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD223496B;
	Wed, 26 Feb 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPLTIuSW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6F224AF1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595150; cv=none; b=Y1+s3lzyhDdEjQaIkcrMGBJDX4W1DnOHQYMmSSxhbPFiN2m5ZgDTqH/zmMt0i870PoopN0dk1+admK3z/6nF+5iXox0SnpY42JXfKCqBXkv0KC0cEDlsJowhH+mM51NcWbs59ZMea1u6LwEbLVcFpauU4SrW+abNTmRss/W5puE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595150; c=relaxed/simple;
	bh=lKrXR1KGRZSugNM5yC3co97RUFbsdNWdtgCIXHI7OTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eontsQdIyMN1gtupWzM8D916IPFgfKXRQUsE5Xmtt3p4FUc/y3IyWIb3OUr/8bzkSK4W52qwD+4R+n1EF/0rDeYpOUKYtEAXj21Dr61dOOvx1htzNwIejKvwe5JOoGqZAR6H7YfmvlD85jd2zgxuKF2FQK3yjNxHh867WMVAUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPLTIuSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740595147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90eXzmLAT43+01svPMQAHvvPwTa7z+5JsRENaBTrc8I=;
	b=MPLTIuSWWYQfTSAO4mXUziXmnySbrOci7CCAArTHkehUNFuNLgFOzQLwSnk9PCG+S2GNWx
	2zperedj9S2K2aAY1O9ZRAUPU2QKj8Us3ZmpPvHyb0qsl8ZHPs/zf9KjYu3cWHhTtrCHMp
	x5KOSvfwJ/2X48ScKIxutf8XfsvA8Lw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-nzdciPYMNYaZNqE1rIN2QA-1; Wed, 26 Feb 2025 13:39:05 -0500
X-MC-Unique: nzdciPYMNYaZNqE1rIN2QA-1
X-Mimecast-MFC-AGG-ID: nzdciPYMNYaZNqE1rIN2QA_1740595145
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e2378169a4so3256256d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595145; x=1741199945;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90eXzmLAT43+01svPMQAHvvPwTa7z+5JsRENaBTrc8I=;
        b=h/Ce3FLGGOAQCQpJm4+QvYpejxk9zS2KeIr0gnu/f48FDxiQ+bBcgjsvWABt/Gonvp
         mMwtFG+FfTCEYOi3fsZdI+ZQxX0AC0k4WtJRwZ1iEOk0JOxyL1oSMnMWQBsWj3ofG4P1
         iDwcNM3VCk4+TRo/xqx0G7jjR5rIJjXLuvQKVFfDTEVVPxsZ5ZJ0lhfPbrE0gPJ19xg2
         zTvp2SMgSTq0r0HIcxadAqeHop5KM98DSji3G5+3ZaOIwDEvHhCNKPCh3Ng8l3RPgC3Q
         W9MhOlRUyS+EfPKZ5oyLOG+Y1QswGFDJ3XjHoLMTtTiwzPcCU887Sh9UiN9UNBAw9c4D
         aOlA==
X-Forwarded-Encrypted: i=1; AJvYcCUaqxlZFdWagpYqwr4z08KXVi9xEoNrsaX3KcRdqhFHgPK7JoSuamvHj3Om1jQQz//eVDvaS/Dcjqrd8qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqPyAQqzwYx2jTHOmf+cRgGISJbdibCX4fYhZWQZjKdIcJYi5
	TA6dIOWjyUGpjMO84rkKhKz2u9KOKiRZpubd+K0s+kMacph9WN26JLXJN5yTO8t9IBQnmGJuXax
	SuM7YSCU+TjSziLCKi7MaOvF8XwDw3VKDMPE6f8yhvtvRfph8JoXmHHDEOEslUw==
X-Gm-Gg: ASbGncs+UeJltb+c8c/x1WYZ7V/cnoryZbZfwM7jenjvmNAyEr0UM5m3FGE26shra7w
	HcLX9W7kaj84Vp8NIE99kUn/Yts0h9liRok3ei0RWanYtZec1mg5ieAvo7CbSOyenQVb5qhZQWH
	OHm1kSx/ak528YWDtqPaEY58jUhecgdhhQ8+hKdEXVgwDwoV0YYxWbRs0LZMFRCtkD22v/oz1uj
	XxFCY1h/kCon4FVuBO8fOR8MIU55cIEV8M9DbiBbzsjhGUe4uka9uMABTp7NboNLgvM+HU/T9vM
	37F5kmVOQt1GHmU=
X-Received: by 2002:a0c:c587:0:b0:6e6:64ce:3111 with SMTP id 6a1803df08f44-6e88689c141mr38637976d6.24.1740595144726;
        Wed, 26 Feb 2025 10:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbOz3Tqr6hQCs7COjzgB8TX38rAHvlgqyAvPxtiLWjotGeTAS5snldmdaBWtJva1mdqP5ulQ==
X-Received: by 2002:a0c:c587:0:b0:6e6:64ce:3111 with SMTP id 6a1803df08f44-6e88689c141mr38637786d6.24.1740595144399;
        Wed, 26 Feb 2025 10:39:04 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b17194csm25604976d6.97.2025.02.26.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:39:04 -0800 (PST)
Message-ID: <4c605b4e395a3538d9a2790918b78f4834912d72.camel@redhat.com>
Subject: Re: [PATCH v9 00/11] KVM: x86/mmu: Age sptes locklessly
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  David Matlack <dmatlack@google.com>, David Rientjes
 <rientjes@google.com>, Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao
 <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2025 13:39:02 -0500
In-Reply-To: <Z75lcJOEFfBMATAf@google.com>
References: <20250204004038.1680123-1-jthoughton@google.com>
	 <025b409c5ca44055a5f90d2c67e76af86617e222.camel@redhat.com>
	 <Z7UwI-9zqnhpmg30@google.com>
	 <07788b85473e24627131ffe1a8d1d01856dd9cb5.camel@redhat.com>
	 <Z75lcJOEFfBMATAf@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2025-02-25 at 16:50 -0800, Sean Christopherson wrote:
> On Tue, Feb 25, 2025, Maxim Levitsky wrote:
> > On Tue, 2025-02-18 at 17:13 -0800, Sean Christopherson wrote:
> > > My understanding is that the behavior is deliberate.  Per Yu[1], page_idle/bitmap
> > > effectively isn't supported by MGLRU.
> > > 
> > > [1] https://lore.kernel.org/all/CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com
> > 
> > Hi,
> > 
> > Reading this mail makes me think that the page idle interface isn't really
> > used anymore.
> 
> I'm sure it's still used in production somewhere.  And even if it's being phased
> out in favor of MGLRU, it's still super useful for testing purposes, because it
> gives userspace much more direct control over aging.

I also think that page_idle is used somewhere in production, and it probably works
more or less correctly with regular non VM processes, although I have no idea how well it works
when MGLRU is enabled.

My point was that using page_idle to track guest memory is something that is probably
not used because it doesn't work that well, and nobody seems to complain.
However I don't ask for it to be removed, although a note of deprecation might
be worth it if really nobody uses it.

> 
> > Maybe we should redo the access_tracking_perf_test to only use the MGLRU
> > specific interfaces/mode, and remove its classical page_idle mode altogher?
> 
> I don't want to take a hard dependency on MGLRU (unless page_idle gets fully
> deprecated/removed by the kernel), and I also don't think page_idle is the main
> problem with the test.
>    
> > The point I am trying to get across is that currently
> > access_tracking_perf_test main purpose is to test that page_idle works with
> > secondary paging and the fact is that it doesn't work well due to more that
> > one reason:
> 
> The primary purpose of the test is to measure performance.  Asserting that 90%+
> pages were dirtied is a sanity check, not an outright goal.

From my POV, a performance test can't really be a selftest unless it actually fails
when it detects an unusually low performance. 

Otherwise who is going to be alarmed when a regression happens and
things actually get slower?

> 
> > The mere fact that we don't flush TLB already necessitated hacks like the 90%
> > check, which for example doesn't work nested so another hack was needed, to
> > skip the check completely when hypervisor is detected, etc, etc.
> 
> 100% agreed here.
> 
> > And now as of 6.13, we don't propagate accessed bit when KVM zaps the SPTE at
> > all, which can happen at least in theory due to other reasons than NUMA balancing.
> > 
> > Tomorrow there will be something else that will cause KVM to zap the SPTEs,
> > and the test will fail again, and again...
> > 
> > What do you think?
> 
> What if we make the assertion user controllable?  I.e. let the user opt-out (or
> off-by-default and opt-in) via command line?  We did something similar for the
> rseq test, because the test would run far fewer iterations than expected if the
> vCPU task was migrated to CPU(s) in deep sleep states.
> 
> 	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 2),
> 		    "Only performed %d KVM_RUNs, task stalled too much?\n\n"
> 		    "  Try disabling deep sleep states to reduce CPU wakeup latency,\n"
> 		    "  e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',\n"
> 		    "  or run with -u to disable this sanity check.", i);
> 
> This is quite similar, because as you say, it's impractical for the test to account
> for every possible environmental quirk.

No objections in principle, especially if sanity check is skipped by default, 
although this does sort of defeats the purpose of the check. 
I guess that the check might still be used for developers.


> 
> > > Aha!  I wonder if in the failing case, the vCPU gets migrated to a pCPU on a
> > > different node, and that causes NUMA balancing to go crazy and zap pretty much
> > > all of guest memory.  If that's what's happening, then a better solution for the
> > > NUMA balancing issue would be to affine the vCPU to a single NUMA node (or hard
> > > pin it to a single pCPU?).
> > 
> > Nope. I pinned main thread to  CPU 0 and VM thread to  CPU 1 and the problem
> > persists.  On 6.13, the only way to make the test consistently work is to
> > disable NUMA balancing.
> 
> Well that's odd.  While I'm quite curious as to what's happening, my stance is
> that enabling NUMA balancing with KVM is a terrible idea, so my vote is to sweep
> it under the rug and let the user disable the sanity check.
> 

One thing for sure, with NUMA balancing off, the test passes well (shows on average
around 100-200 idle pages) and I have run it for a long time.


Best regards,
	Maxim Levitsky



