Return-Path: <linux-kernel+bounces-262214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FF93C28F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC6CB22446
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3819ADB0;
	Thu, 25 Jul 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxlp048N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDA199246
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912351; cv=none; b=bGqJpWvQHf/mCLQJABVZMGwBAecSMVjRfdyVsoM8JdyZLckWErY0oIBgJY8DHI8ZSd8GSV/DGxlNqzNQue5SHihn/4H7fuCFS3m3SQKNFaEmPXn0zzTWwTvZrtU6rJOxkY4a/AU+6hTTWUPUQFzhg62GDUUWlTJCIN8ZZrc0co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912351; c=relaxed/simple;
	bh=7CA4phgJfezY9LxFA4uB4CHS2auOdFDTKUYg/tm4Rw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyD1uin4mPDnwLKa9JFd06EtMtjcr07EMs0E25F7uXHTzSLQVY+KSDc8/jJY/PRS3BYbUVWTluHcjFOSfqgHp03iHY1WLlgtksZkjkBS2V+RN9dEXAaX5CvvgCZ2kSB6UXa42Z8N0menYuc5YoAaBY6bNlId/m/W5mt6ouWs4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxlp048N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721912349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dmxiy7y2M1YKqG7m3A1HVRAUp+Gkii06RMCoipziy/I=;
	b=hxlp048NBhRklqlceyy2Oxml7vCfSGhQ4982PTQfOiRfgZ3ng83GIu+4ldCI+KJVITef1N
	8MMAl1Tzy//DyserlZn9gbdfrN2B4xzhu+9vMKi0EYl7qpKP8rpg5ekKHXdZinwL9n3j8h
	LF0YVY5YrDGiKXCjfaR5iJqMuPIJ3Vo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-lMEXJSctMC6Z9CKbAZvBSA-1; Thu, 25 Jul 2024 08:59:07 -0400
X-MC-Unique: lMEXJSctMC6Z9CKbAZvBSA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a15e7d001cso109925685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912347; x=1722517147;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dmxiy7y2M1YKqG7m3A1HVRAUp+Gkii06RMCoipziy/I=;
        b=l/IHoCDAOgcjzthOzhnRirf+o++/qE5Bb1nbfT8WoNqMxDV1zjX6uchsP3x9B6ShoV
         cNhTRuORoOUMluJL/tSPrYtLUaFBISH+Z7a2Ga454s5mXfKvj9vyppdPLalEekB8IXxk
         bzYmlT9HHZLqjeml7ywIeE1yMBVJTZLV3tjP1/dmNr266jqueJSvrwYbMhaYoqIiXG7Q
         ZQy/2nBOFUruDLH/0OY4/l5gzWHuqLDA12mLpNzOfuzDfG0d+9DmoUlfgJMHT8vgYzmk
         kvOzq1Rhk9cMmwtZDvlQL1QbbhLjF2oCJxSWla8KlZcr+b1Pk0skFttfCJogEK0TCDSq
         P2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs4Zxq1tRzH+nj16tyumBddSaYrKdDOyBSMvOSBKbYXvm+FX3+g3y0yiT7CbW47h9h18kYrTYUIeu8Isdx/P23eCh2uB7qtKn9lR3n
X-Gm-Message-State: AOJu0Yzy5N1O2i+XDAu/aCFh/xO5cex7uxv4yG2WGUDReudIXyIO9mm6
	Oa6IbGPJOuhCmz6kRDYXxPEhYt6SVHbPneXUuZ16kmvxxhh0SVVCMW7hbmNhyrb/ICSqhI+BJnf
	plJfJ8CNLKbgs5C+xOq4JnRtsz7WEgRgoYGYTtvqjhSvE0mxduEAlQTIP8l41q8R7ZbneFQ==
X-Received: by 2002:a05:620a:25c8:b0:79f:178f:99d9 with SMTP id af79cd13be357-7a1d449d572mr320160185a.5.1721912346888;
        Thu, 25 Jul 2024 05:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxL2ER0J3D7sIAIN62e2l9nspNW8gtDiZK/Dn4q8GoifTaM8AR0mzQMgz1C82IwdZIgHsFvw==
X-Received: by 2002:a05:620a:25c8:b0:79f:178f:99d9 with SMTP id af79cd13be357-7a1d449d572mr320158185a.5.1721912346487;
        Thu, 25 Jul 2024 05:59:06 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955ccsm80719985a.11.2024.07.25.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:59:05 -0700 (PDT)
Message-ID: <f183d215c903d4d1e85bf89e9d8b57dd6ce5c175.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] KVM: VMX: disable preemption when touching
 segment fields
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>,  Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 25 Jul 2024 08:59:04 -0400
In-Reply-To: <Zpb127FsRoLdlaBb@google.com>
References: <20240716022014.240960-1-mlevitsk@redhat.com>
	 <20240716022014.240960-3-mlevitsk@redhat.com> <Zpb127FsRoLdlaBb@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-16 at 15:36 -0700, Sean Christopherson wrote:
> On Mon, Jul 15, 2024, Maxim Levitsky wrote:
> > VMX code uses segment cache to avoid reading guest segment fields.
> > 
> > The cache is reset each time a segment's field (e.g base/access rights/etc)
> > is written, and then a new value of this field is written.
> > 
> > However if the vCPU is preempted between these two events, and this
> > segment field is read (e.g kvm reads SS's access rights to check
> > if the vCPU is in kernel mode), then old field value will get
> > cached and never updated.
> 
> It'be super helpful to include the gory details about how kvm_arch_vcpu_put()
> reads stale data.  Without that information, it's very hard to figure out how
> getting preempted is problematic.

I will do this in next version of this patch.

> 
>   vmx_vcpu_reset resets the segment cache bitmask and then initializes
>   the segments in the vmcs, however if the vcpus is preempted in the
>   middle of this code, the kvm_arch_vcpu_put is called which
>   reads SS's AR bytes to determine if the vCPU is in the kernel mode,
>   which caches the old value.
> 
> > Usually a lock is required to avoid such race but since vCPU segments
> > are only accessed by its vCPU thread, we can avoid a lock and
> > only disable preemption, in places where the segment cache
> > is invalidated and segment fields are updated.
> 
> This doesn't fully fix the problem.  It's not just kvm_sched_out() => kvm_arch_vcpu_put()
> that's problematic, it's any path that executes KVM code in interrupt context.
> And it's not just limited to segment registers, any register that is conditionally
> cached via arch.regs_avail is susceptible to races.
> 
> Specifically, kvm_guest_state() and kvm_guest_get_ip() will read SS.AR_bytes and
> RIP in NMI and/or IRQ context when handling a PMI.

> 
> A few possible ideas.
> 
>  1. Force reads from IRQ/NMI context to skip the cache and go to the VMCS.

This IMHO is the best solution. For segment cache its easy to do, the code
will be contained in vmx_read_guest_seg_* functions.

For other VMX registers, this can be lot of work due to the way the code is scattered
around. Still probably double.


> 
>  2. Same thing as #1, but focus it specifically on kvm_arch_vcpu_in_kernel()
>     and kvm_arch_vcpu_get_ip(), and WARN if kvm_register_is_available() or
>     vmx_segment_cache_test_set() is invoked from IRQ or NMI context.

I agree on this, this is actually one of the suggestions I had originally.
( I didn't notice the kvm_arch_vcpu_get_ip though )

I think I will implement this suggestion.

> 
>  3. Force caching of SS.AR_bytes, CS.AR_bytes, and RIP prior to kvm_after_interrupt(),
>     rename preempted_in_kernel to something like "exited_in_kernel" and snapshot
>     it before kvm_after_interrupt(), and add the same hardening as #2.
> 
>     This is doable because kvm_guest_state() should never read guest state for
>     PMIs that occur between VM-Exit and kvm_after_interrupt(), nor should KVM
>     write guest state in that window.  And the intent of the "preempted in kernel"
>     check is to query vCPU state at the time of exit.
> 


>  5. Do a combination of #3 and patch 02 (#3 fixes PMIs, patch 02 fixes preemption).


> 
> My vote is probably for #2 or #4.
#4 causes a NULL pointer deference here :) 

>   I definitely think we need WARNs in the caching
> code, and in general kvm_arch_vcpu_put() shouldn't be reading cacheable state, i.e.
> I am fairly confident we can restrict it to checking CPL.
> 
> I don't hate this patch by any means, but I don't love disabling preemption in a
> bunch of flows just so that the preempted_in_kernel logic works.
> 


Thanks for the suggestions!

Best regards,	
	Maxim Levitsky





