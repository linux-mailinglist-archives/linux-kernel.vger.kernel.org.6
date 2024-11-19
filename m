Return-Path: <linux-kernel+bounces-414350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B109D26C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DAE282D45
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C51CCB57;
	Tue, 19 Nov 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/EM+ZzA"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440711514FB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022646; cv=none; b=VDOH4npdqefc18SFJHpDbQUn7FMtYiCJMbp9GzYj6WzFQARWnvMWWkwR640LMjiYaHxipVXlvbnzrBX+6QJ9SAYEsx9ss2w36wrv7Dp+8+m2YMcV1tUyGtL654KO6MlpcMtwdzrCGTeMQqvL4PQVWSMM3LWzkCO1NBoD+VuhL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022646; c=relaxed/simple;
	bh=blTBsu0yQG3NFhvqoDnTrSMH9jmy+F3RjqGnWiSjl0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XkF96dEiDqXXYqg2XzZl2V6ksIDH0bURsp5OQwJWOjj0sTHDTW2f3tHmnlay1ScFdwxA9PNnifOnm0M2j2fq9XzSRDw4jT4AKG7pgJmfjK35b34w4nQgk62pQA7WeEF0gCl+YZLXTxlmFMl2sadEzS9WjPajjulltkhzFSfqCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/EM+ZzA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72065695191so1047562b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732022644; x=1732627444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bGGdmm0E4OePUo0A3ow9M/m0GDDzudoyPVvnLN0mfQ=;
        b=S/EM+ZzApMlpcMyjyeYPq8gg9o6/wH+dmipiBVHBnigs0Z/k71dSNPvHbUQnpzpRb5
         Wa71vRjshpyoC6OQ4mBSoX2CVNBXQ1wAcV6K6tKLhL8q9meCQ7ibRlO4XCzO7mUemS6F
         XbzR9DMr899Ivz3Mw+TD2ym23igv+lHXxq/EE35UorWgG+07fDgL+J1YhPN0J+iCCbCn
         2zV51sA5GZsid3JQDprfdmrLWR9plzjdku7FIA29XifDKzyItMh2DRUnlnopAm5p3jI6
         +FlqiouCWL3+XFniRL/1zKokKfW/HGC3GPuNUj8QjXeH0wFc/6uKogCQKglaHxEnQPcQ
         PnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732022644; x=1732627444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bGGdmm0E4OePUo0A3ow9M/m0GDDzudoyPVvnLN0mfQ=;
        b=nBLKOjx/fEDBH+d4jp/2Uw490fh33GUfjjxhrAfcpB4K0V5Ixi5dReXqd9rXZQcKUU
         sgXI9hWO5zaepQUOb91Za7QlmcX4zpZ+YGyFT3TjQtu+OxzRRZjliZL3/v9GpP6kswSl
         Xl1Qx0s4gc1ILqz8qNxG4jLYAg1N4URL0WCDUIB4LYvqj0JPhx2efXsu8MhUeGpN2A0i
         ldAkv82tr+Ac0vkQnwyn6zqY2gpdADAm8JeTQRMcpFJ/ECGv4OQVxheSurqFkil06eg3
         jPWG0eUzYy1ZPGJm61S0k9gsqcBuUmvJU34VvBNCf4kC9+qZnl9UD7f4VbmX5DrJLyvY
         qJfg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCU1tAwmp3UXjOdXquGYLYk6yLBTS03hIhVKnJPsXUd6naz5aQiIwFvI+ywG5KtX1fLjSZlpkrLaD98M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMt+hsP1rGlYu9ysbHy9C5Q5Fj6uv/tIPt+GtPVqybEdXTMyF/
	Zu1Bla7anZrqeMM+D0i68pGAYgERBUDVC8LDRiA0DymHdjDDURS5ssKe8Brj6QxujvlW7rCUc4P
	tTQ==
X-Google-Smtp-Source: AGHT+IGEmsosvS7ptYvrOmIoWHSRpV6M+ZGMWL1a6fd3f8ruEl07mCFWIB29YvTsTAmDdj0hZ615n0lidw4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4c8c:b0:2ea:45d6:a650 with SMTP id
 98e67ed59e1d1-2ea45d6a7c4mr28358a91.0.1732022643643; Tue, 19 Nov 2024
 05:24:03 -0800 (PST)
Date: Tue, 19 Nov 2024 05:24:01 -0800
In-Reply-To: <20241118130403.23184-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118130403.23184-1-kalyazin@amazon.com>
Message-ID: <ZzyRcQmxA3SiEHXT@google.com>
Subject: Re: [PATCH] KVM: x86: async_pf: check earlier if can deliver async pf
From: Sean Christopherson <seanjc@google.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, vkuznets@redhat.com, gshan@redhat.com, graf@amazon.de, 
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es, 
	xmarcalx@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 18, 2024, Nikita Kalyazin wrote:
> On x86, async pagefault events can only be delivered if the page fault
> was triggered by guest userspace, not kernel.  This is because
> the guest may be in non-sleepable context and will not be able
> to reschedule.
> 
> However existing implementation pays the following overhead even for the
> kernel-originated faults, even though it is known in advance that they
> cannot be processed asynchronously:
>  - allocate async PF token
>  - create and schedule an async work

Very deliberately, because as noted below, async page faults aren't limited to
the paravirt case.

> This patch avoids the overhead above in case of kernel-originated faults

Please avoid "This patch".

> by moving the `kvm_can_deliver_async_pf` check from
> `kvm_arch_async_page_not_present` to `__kvm_faultin_pfn`.
> 
> Note that the existing check `kvm_can_do_async_pf` already calls
> `kvm_can_deliver_async_pf` internally, however it only does that if the
> `kvm_hlt_in_guest` check is true, ie userspace requested KVM not to exit
> on guest halts via `KVM_CAP_X86_DISABLE_EXITS`.  In that case the code
> proceeds with the async fault processing with the following
> justification in 1dfdb45ec510ba27e366878f97484e9c9e728902 ("KVM: x86:
> clean up conditions for asynchronous page fault handling"):
> 
> "Even when asynchronous page fault is disabled, KVM does not want to pause
> the host if a guest triggers a page fault; instead it will put it into
> an artificial HLT state that allows running other host processes while
> allowing interrupt delivery into the guest."

None of this justifies breaking host-side, non-paravirt async page faults.  If a
vCPU hits a missing page, KVM can schedule out the vCPU and let something else
run on the pCPU, or enter idle and let the SMT sibling get more cycles, or maybe
even enter a low enough sleep state to let other cores turbo a wee bit.

I have no objection to disabling host async page faults, e.g. it's probably a net
negative for 1:1 vCPU:pCPU pinned setups, but such disabling needs an opt-in from
userspace.

