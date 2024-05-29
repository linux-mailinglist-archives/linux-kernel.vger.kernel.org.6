Return-Path: <linux-kernel+bounces-194271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAC8D3934
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518BE1C22699
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868E15821E;
	Wed, 29 May 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgWRqzwU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C551158210
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992962; cv=none; b=KzNCsHqjmCOSnXTdcGmSO2BfaxAV2XLaCLVVdgiFGYyDOxHk6DrYbL3VfxFpfLDTW5T5pXZGRKWbPCCUyvVLqTkp0Emd4j7BMTS2d4QtIDzJRvtz7Z8IreV6m/RVgKo1dq4pywmY4c8tCAfJoxd+KJ4GJStolKAgJRmRNKzfnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992962; c=relaxed/simple;
	bh=//0ii/zNBOQKKNaDNP3w/g1gM1CezyuYoz6Y2NAEkac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RlgiX8fTqIUjoMoNNyjEnUcEjAwnqUi42ZAnN/xwyGDyKC4QxKkanDum6lbLAFzppz8VafREDNMtJhw7yX/BYuxbh/qMRAdtzs/BL0/x/yh4mitBfK5WIoIj9X5160vD0ROX5wtCDBGEd4D88/i+FvOs1hs0QZBv+ccUjzIo2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgWRqzwU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a92145so35011787b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716992959; x=1717597759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpzkxiZJ+JsVTYQLiVluvU7gtIP+cGyMlWZAn8HOBvc=;
        b=IgWRqzwUAUE/aQEi4/xVaVivYgj7kYV1vdqPIC7g7km8uYLcpdSAlsw/Z/b4Jmkm9K
         zs31IhnlalrHF85rPT5sSwJ2uTDG3e079mgDKbeWE7xYQiW3d0YMsQu5hDb6oMKIaRne
         T3sF2VDD63pRD0nh8bv/lBAz9StTcnndb1IIcHWOCNItaKxHPl7bIGojMw3Fjb2/M7b9
         vMe4dkBZxcb0kBrkuptQYzXi8vPP5PUBWbNqJTUQvDhVQHaJvBV8xDdOgsuvjF3eDXSG
         59qmHJlUPOfVvWSnaFzVxDVhvBK7AM7j0usZEmH8mte37YIQni1bGh0nmeY0oa0PH5QK
         bhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992959; x=1717597759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpzkxiZJ+JsVTYQLiVluvU7gtIP+cGyMlWZAn8HOBvc=;
        b=MTtNcJZmMUD9vuuPC1SiszU9vZFI4Xfzsz9mNYMsLrJdrGfeXS4XeqneyudOEWNSWe
         fP1YDbTmWOtxEz6OvsvombRHa6sIGGBfegOc2kbwvhlhKUR7TqWPuGrt+/9YGWaZTbk0
         j4vDhFnyY0m+6ODfPBTtuHhulwL0zq8veZOkrcGDIaiLfV/MYRFC5fRn+0A8xn2Ks+69
         7faXt4bxMyYFGxexE4B8YqFYOKRcmXfMozRl9NTzWBInSM1Q3hZR+6rN3VOe0P0rBygU
         v7ZSScOPGaxM9SFepamMM2bYqRHICbRaCYhqQ1Do9hCMkDz6Hm2rihYhLDOOO0pW/A8F
         KuEA==
X-Forwarded-Encrypted: i=1; AJvYcCWendbSNEM6YBwrwe3gTYpzBypO+3cCslOHa4gfzCGGXu6VxngXxAhKBr+pQb1B/S/NHKsL6na9IKI6y8a+KTp0b2wp5VsNfagV+J3Q
X-Gm-Message-State: AOJu0YyUej2KqzPCdy6UeOhgEBnt6+gge3pPoeEbw1TTqDE2Nr2CZPz6
	BAinmFybEv4TrYzs+ZwI+HeIJWVWjxOPoobgV7R4TSPG2Fq1m7tewnk68Xz7DhJjl+NZKmdFRnU
	azA==
X-Google-Smtp-Source: AGHT+IEGZoW9p/45uvlpuAhiUqCesSBDBs0K+xmgAn7zLw0SiaXYS/WuIvmvG5ZvjK25/ioNuhWd5tsISM4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d8f:b0:62a:4932:68de with SMTP id
 00721157ae682-62a49326f54mr16363447b3.8.1716992959692; Wed, 29 May 2024
 07:29:19 -0700 (PDT)
Date: Wed, 29 May 2024 07:29:18 -0700
In-Reply-To: <Zk2MRRkS6c5cGYSV@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522022827.1690416-1-seanjc@google.com> <20240522022827.1690416-2-seanjc@google.com>
 <Zk2MRRkS6c5cGYSV@chao-email>
Message-ID: <Zlc7vtp4HaPHqZ2K@google.com>
Subject: Re: [PATCH v2 1/6] KVM: Register cpuhp and syscore callbacks when
 enabling hardware
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, Chao Gao wrote:
> On Tue, May 21, 2024 at 07:28:22PM -0700, Sean Christopherson wrote:
> >Register KVM's cpuhp and syscore callback when enabling virtualization
> >in hardware instead of registering the callbacks during initialization,
> >and let the CPU up/down framework invoke the inner enable/disable
> >functions.  Registering the callbacks during initialization makes things
> >more complex than they need to be, as KVM needs to be very careful about
> >handling races between enabling CPUs being onlined/offlined and hardware
> >being enabled/disabled.
> >
> >Intel TDX support will require KVM to enable virtualization during KVM
> >initialization, i.e. will add another wrinkle to things, at which point
> >sorting out the potential races with kvm_usage_count would become even
> >more complex.
> >
> 
> >Use a dedicated mutex to guard kvm_usage_count, as taking kvm_lock outside
> >cpu_hotplug_lock is disallowed.  Ideally, KVM would *always* take kvm_lock
> >outside cpu_hotplug_lock, but KVM x86 takes kvm_lock in several notifiers
> >that may be called under cpus_read_lock().  kvmclock_cpufreq_notifier() in
> >particular has callchains that are infeasible to guarantee will never be
> >called with cpu_hotplug_lock held.  And practically speaking, using a
> >dedicated mutex is a non-issue as the cost is a few bytes for all of KVM.
> 
> Shouldn't this part go to a separate patch?
> 
> I think so because you post a lockdep splat which indicates the existing
> locking order is problematic. So, using a dedicated mutex actually fixes
> some bug and needs a "Fixes:" tag, so that it can be backported separately.

Oooh, good point.  I'll try to re-decipher the lockdep splat, and go this route
if using a dedicated lock does is indeed fix a real issue.

> And Documentation/virt/kvm/locking.rst needs to be updated accordingly.
> 
> Actually, you are doing a partial revert to the commit:
> 
>   0bf50497f03b ("KVM: Drop kvm_count_lock and instead protect kvm_usage_count with kvm_lock")
> 
> Perhaps you can handle this as a revert. After that, change the lock from
> a raw_spinlock_t to a mutex.

Hmm, I'd prefer to not revert to a spinlock, even temporarily.

