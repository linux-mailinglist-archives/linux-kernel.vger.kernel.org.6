Return-Path: <linux-kernel+bounces-445517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2939F172B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1404E188F7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF471EE7A5;
	Fri, 13 Dec 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSvf4emq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6818FDBE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120160; cv=none; b=AqtWGC/qwSqiA1evVOKhBaLKCYB3x+Re2kw81abBgXKIeD1/obXyDUpP/ZWgvTkKvmw/wRFXPjJoz+FWceoLssnx+n0q/Kkxy+MU45fbixmqgdPDCgos8F8i/p86CWVxccQ+PzyBUJUAq+w99h32yEE0Vk2tfgc4iwUzeAyd+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120160; c=relaxed/simple;
	bh=yp16JfYOJAjDMSKK+eOq0yZ2g8bSBzM/k6h3YNYvfjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LfykasqSXlG9Zj8eR9fETahvKZ7/4QvkYFV4MMHU83iJJpYKNZOUc35/rOmDj28fYZsbCaDJ0Yif/6g9fRXkflC4hMQKTeRbBVPgbtQtSE4P4GGjrm2OHJ4FfEsDrSUDWOsukYeRiVKLAj9d/T+xE09R7Qj1T1g/hI3ZcXZi5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSvf4emq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734120157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNS9SgQz3yNcrMP28OglAyAB/O22oVO5b3LG+xQhoiU=;
	b=eSvf4emqEuppcrjyaf2atdYSQdH/Q11jizolVJoWUQDFmZBXhNI7nJSWvwbQwRLWT6/Tm3
	PtqYs0D+hsFnG0jaw5Enq7tHsKBfAOO20Z6VggcdxE1740uHOsbtF6xw5vV0TkylL8259A
	v/Wr/9pibPqF2Rcd1WSd6XtExJmQrpU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-ggv2Sn2OPMeCHKdCX4e4Tw-1; Fri, 13 Dec 2024 15:02:36 -0500
X-MC-Unique: ggv2Sn2OPMeCHKdCX4e4Tw-1
X-Mimecast-MFC-AGG-ID: ggv2Sn2OPMeCHKdCX4e4Tw
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725eaaf8914so2737593b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120155; x=1734724955;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNS9SgQz3yNcrMP28OglAyAB/O22oVO5b3LG+xQhoiU=;
        b=g7cb60hLDVFdVHzHOwVSoI1QUqkZ5PoFyzDTnvrj7yw/2bP2wRRklxfXheH9OADIZj
         aFb7jgO6YeI8K6r4aL+1ZhaU5DNlaDOuUAw8crDNgDWVvmjwCcoRrgbROh1GYwAyg6YS
         XV6U2fD1n1qSCvfUDyaPDKhO5paCr0LPnmEwoPoIIjUPddC1DlTr4HfTBAOh/KAXm3RC
         4pxbj9wNssiQapsTKjgoneVfEH/1EuwfJeRMpc+hce/gTkfQzdlY2EkzLIay5w4wknNo
         i8tUzOgEYU8qV9D//340Teb5/H/HAj7nLI2fjksnSvm4+fbbGQJBCpwfQQQwqnMVcyEn
         wqrg==
X-Forwarded-Encrypted: i=1; AJvYcCXfbC6iJvs/tF6vt+5tJ6y2b2JRLdWQTYNbYmWylcL16qq07rNBggF0kVc7iV03ML2fKQuty4gRI7vMTEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9CH83hpNtYTO4r5GJ1myp6mc+rhQPCp++RpyuqjyNHcDhLXt
	hRTdqfZ+kBVy3Q0O4sNVUOYpMWoFml+s+/UMGvsqqfqUSusWuunJCrIe/QYYhCD7buOJZl78sKM
	1srYMg12rde6zPuaMp3L4NmmtvafBvWaUvT+8V3CQtykTt794CGTr9mORuw36q51d0UHSFg==
X-Gm-Gg: ASbGncuGfK2NVw8NWAQPdbKoySSuBGJcOnIpXvk1rfVo4UOaJhWzn5cNxF2pLx2I6BL
	64xWGRzn5Iz7FcQbtXfRjEatfhqUWSh0r32HQxNV9AXRxqu2ODj2A3ghQ7Kzj+/twQHdja6Z1Tv
	fpQGIYM73aE1DDuQofFh+EhQ6/3FS++QSxB+wL/lQO7fNGAPUvvt4f7D9vzqMGl+Z5reWb9a7PE
	CjKYgUywR2NZKF1bM9vR+wQyKH4fiSaGFv1HHKAQgiCOwfa8/QUxHwb
X-Received: by 2002:a05:6a00:3692:b0:725:e309:7110 with SMTP id d2e1a72fcca58-7290c10fe59mr6834716b3a.5.1734120155011;
        Fri, 13 Dec 2024 12:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMCPOjC5JSWjf3R4QtZ4+4SVXt0a9IhTKiDJkRFHtYQ8JcdI/GjFApb9BSMWlLoMfC40qpAQ==
X-Received: by 2002:a05:6602:492:b0:835:3ffe:fe31 with SMTP id ca18e2360f4ac-844e88489f9mr484065239f.8.1734119798817;
        Fri, 13 Dec 2024 11:56:38 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e03686dcsm37085173.7.2024.12.13.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:56:38 -0800 (PST)
Message-ID: <88706b97f374bd425da82e78789e6234cb6baed2.camel@redhat.com>
Subject: Re: [PATCH 1/4] KVM: VMX: read the PML log in the same order as it
 was written
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Peter
 Xu <peterx@redhat.com>
Date: Fri, 13 Dec 2024 14:56:37 -0500
In-Reply-To: <Z1vR25ylN5m_DRSy@google.com>
References: <20241211193706.469817-1-mlevitsk@redhat.com>
	 <20241211193706.469817-2-mlevitsk@redhat.com> <Z1ox4OHNT6kkincQ@google.com>
	 <a3e75091f2b6b13d4907ac2fdf09058ab88c4ebf.camel@redhat.com>
	 <Z1vR25ylN5m_DRSy@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-12-12 at 22:19 -0800, Sean Christopherson wrote:
> On Thu, Dec 12, 2024, Maxim Levitsky wrote:
> > On Wed, 2024-12-11 at 16:44 -0800, Sean Christopherson wrote:
> > > But, I can't help but wonder why KVM bothers emulating PML.  I can appreciate
> > > that avoiding exits to L1 would be beneficial, but what use case actually cares
> > > about dirty logging performance in L1?
> > 
> > It does help with performance by a lot and the implementation is emulated and simple.
> 
> Yeah, it's not a lot of complexity, but it's architecturally flawed.  And I get
> that it helps with performance, I'm just stumped as to the use case for dirty
> logging in a nested VM in the first place.
> 
> > Do you have any comments for the rest of the patch series? If not then I'll send
> > v2 of the patch series.
> 
> *sigh*
> 
> I do.  Through no fault of your own.  I was trying to figure out a way to ensure
> the vCPU made meaningful progress, versus just guaranteeing at least one write,
> and stumbled onto a plethora of flaws and unnecessary complexity in the test.
> 
> Can you post this patch as a standalone v2?  I'd like to do a more agressive
> cleanup of the selftest, but I don't want to hold this up, and there's no hard
> dependency.
> 
> As for the issues I encountered with the selftest:
> 
>  1. Tracing how many pages have been written for the current iteration with a
>     guest side counter doesn't work without more fixes, because the test doesn't
>     collect all dirty entries for the current iterations.  For the dirty ring,
>     this results in a vCPU *starting* an iteration with a full dirty ring, and
>     the test hangs because the guest can't make forward progress until
>     log_mode_collect_dirty_pages() is called.
> 
>  2. The test presumably doesn't collect all dirty entries because of the weird
>     and unnecessary kick in dirty_ring_collect_dirty_pages(), and all the
>     synchronization that comes with it.  The kick is "justified" with a comment
>     saying "This makes sure that hardware PML cache flushed", but there's no
>     reason to do *if* pages that the test collects dirty pages *after* stopping
>     the vCPU.  Which is easy to do while also collecting while the vCPU is
>     running, if the kick+synchronization is eliminated (i.e. it's a self-inflicted
>     wound of sorts).
> 
>  3. dirty_ring_after_vcpu_run() doesn't honor vcpu_sync_stop_requested, and so
>     every other iteration runs until the ring is full.  Testing the "soft full"
>     logic is interesting, but not _that_ interesting, and filling the dirty ring
>     basically ignores the "interval".  Fixing this reduces the runtime by a
>     significant amount, especially on nested, at the cost of providing less
>     coverage for the dirty ring with default interval in a nested VM (but if
>     someone cares about testing the dirty ring soft full in a nested VM, they
>     can darn well bump the interval).
> 
>  4. Fixing the test to collect all dirty entries for the current iteration
>     exposes another flaw.  The bitmaps (not dirty ring) start with all bits
>     set.  And so the first iteration can see "dirty" pages that have never
>     been written, but only when applying your fix to limit the hack to s390.
> 
>  5. "iteration" is synched to the guest *after* the vCPU is restarted, i.e. the
>     guest could see a stale iteration if the main thread is delayed.
> 
>  6. host_bmap_track and all of the weird exemptions for writes from previous
>     iterations goes away if all entries are collected for the current iteration
>     (though a second bitmap is needed to handle the second collection; KVM's
>     "get" of the bitmap clobbers the previous value).
> 
> I have everything more or less coded up, but I need to split it into patches,
> write changelogs, and interleave it with your fixes.  Hopefully I'll get to that
> tomorrow.
> 

Hi!

I will take a look at your patch series once you post it.
I also think that the logic in the test is somewhat broken, but then this also 
serves as a way to cause as much havoc as possible.

The fact that not all dirty pages are collected is because the ring harvest happens
at the same time the guest continues dirtying the pages, adding more entries to the
ring, simulating what would happen during real-life migration.

kicking the guest just before ring harvest is also IMHO a good thing as it also
simulates the IRQ load that would happen.

we can avoid kicking the guest if it is already stopped due to dirty ring, in fact,
the fact that we still kick it, delays the kick to the point where we resume the guest
and wait for it to stop again before the do the verify step, which makes it often
exit not due to log full event.

I did this but this makes the test be way less random, and the whole point of this
test is to cause as much havoc as possible.


I do think that we don't need to stop the guest during verify for the dirty-ring case,
this is probably a code that only dirty bitmap part of the test needs.

I added Peter Xu to CC to hear his option about this as well.


Best regards,
	Maxim Levitsky





