Return-Path: <linux-kernel+bounces-288256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673789537FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EABF1C256B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69931B29A5;
	Thu, 15 Aug 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hncEndOS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825D1714CF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738241; cv=none; b=M03RKqTK1lATM0mn7u9wqZ7rg+tB+Hp/SHyQs70gEMeECGt40p0mtLqGFbadrPRssG/BXEGTcZ/GlJsbpbs9Y034lxDz4quG/cj6Ncbpz7h1a6UBRhdlXJO8FtMH+3qgwtIt2rjLGrZsZ8PeaKxEALduBLgZkCCBvsPPUcuwVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738241; c=relaxed/simple;
	bh=nhUoeQTxPlzxHkRrHDGgpJTsk5svcnXwNkNbkHZdq+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scG3abiESkj81Czud1QoKjiGK+sr/I16isr7Dqa5h75bpOEUebabDNQCTotvfktlfamtOaV4+x0q+FBRWuKcVkrW2q9clrP0gkCraYoitO47ICtNzcYN78RJVEq0nD+LJmO/3YbD5OrfVIV53/Ea3Z0ZJXdOP5hH4DKKxcUP2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hncEndOS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723738239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0C29WUxU/0x21D0S2vEXYwTrRtZFHVrz4TucO9zGe6Q=;
	b=hncEndOSKvehDZel/x/njLzgTmSIJYnTkUYz1EfcXxi3X8z6/+Wqoy1w2O/csusfIGDV+a
	Ovjk9lzt9Fr6WZonAellsaZQgAmRUPBFLtP4BhWlPWjtI65vrrweDP/Z+aImbHxiJawaUx
	x8ODpOGCND5h4V7QgJWGWsYUMK4GHVA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-9oDg3jD1Ooiw9ZuYk_kGAg-1; Thu, 15 Aug 2024 12:10:38 -0400
X-MC-Unique: 9oDg3jD1Ooiw9ZuYk_kGAg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7a134fd9261so959336a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738235; x=1724343035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C29WUxU/0x21D0S2vEXYwTrRtZFHVrz4TucO9zGe6Q=;
        b=R+JBwALtO5rb/4FpvUeDAOMaeFvi7JoauPVLDjcp+c0iL9J5wPL+criR7ePSji1FUM
         EGW1q2QvC8BwZIZPQlLKoCQH1HH2JgLxe2bXCUoZl2PCtPkSvQoyymNT7NL17YAu8Tt0
         WuGOJctNBvryZFE6Hg1+eMG+ta/I/s9nbKqZhXjBM5DJOekJQgXORZz8vCvoaI5pd5re
         gPfNQ7+QqyMMUTBl5eEj49StDNMP/gkmWPoDZPL8LtODGqqx7aEaWJ2Jyh55kPTEa/Mw
         2w+bP03CXEEqYBK0mvtuLHUt5L2nWzJmERdygfxIJdUE+jxutfcjDRizcUGVzFLp7p/7
         yqEg==
X-Forwarded-Encrypted: i=1; AJvYcCUymzIkacHqP2NZvxvepX0nT5sIMCc0eO3mBkNKBuAY76VjVex8qQwJQXcsgHt3RwWzzhFkPe+z63BTJZNoyq6pQQukA9PPn8RM4LIx
X-Gm-Message-State: AOJu0YyAGhY3TJP6friO/pbTPpNum3PSR5puKMlk9n8rdSgB5vRsSHbd
	N1bPj68xd83V0+JMofYQyIIgEmvAiTie1ym8SvSSH8eoQN8P+/p4JjGP+eUnYSvelhE1qu9Ej3U
	nj/SjmiRYFEzWqhpjk0Drx68EKicYK3yaqikEr8L3fUo/ieY1NUZxBy2zKcKPLEQ9qsS4VhZYQg
	zYzuqL+QIPh336Gv3wnjinJyOOWwUMBXLKQmyXeKkTvaGOt40=
X-Received: by 2002:a17:90a:d783:b0:2d3:d8b0:967b with SMTP id 98e67ed59e1d1-2d3dffdb9fcmr122254a91.27.1723738235493;
        Thu, 15 Aug 2024 09:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXuGOKn3nZprVHVB8nhKQZZwCrztWxBA90Dez4sQ0Fhc7M3UCle8kaUQQiO4lzZNCSrEAKKrx6iXw5ZY7dSyg=
X-Received: by 2002:a17:90a:d783:b0:2d3:d8b0:967b with SMTP id
 98e67ed59e1d1-2d3dffdb9fcmr122224a91.27.1723738235138; Thu, 15 Aug 2024
 09:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608000639.3295768-1-seanjc@google.com> <20240608000639.3295768-2-seanjc@google.com>
 <efb9af41-21ed-4b97-8c67-40d6cda10484@redhat.com> <Zr4TPVQ_SNEKyfUz@google.com>
In-Reply-To: <Zr4TPVQ_SNEKyfUz@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Aug 2024 18:10:21 +0200
Message-ID: <CABgObfZSCZ-dgK3zWao573+RmZSPhnaoMsrify9-48UVhbKVdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] KVM: Use dedicated mutex to protect
 kvm_usage_count to avoid deadlock
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Aug 14, 2024, Paolo Bonzini wrote:
> > On 6/8/24 02:06, Sean Christopherson wrote:
> > > Use a dedicated mutex to guard kvm_usage_count to fix a potential dea=
dlock
> > > on x86 due to a chain of locks and SRCU synchronizations.  Translatin=
g the
> > > below lockdep splat, CPU1 #6 will wait on CPU0 #1, CPU0 #8 will wait =
on
> > > CPU2 #3, and CPU2 #7 will wait on CPU1 #4 (if there's a writer, due t=
o the
> > > fairness of r/w semaphores).
> > >
> > >      CPU0                     CPU1                     CPU2
> > > 1   lock(&kvm->slots_lock);
> > > 2                                                     lock(&vcpu->mut=
ex);
> > > 3                                                     lock(&kvm->srcu=
);
> > > 4                            lock(cpu_hotplug_lock);
> > > 5                            lock(kvm_lock);
> > > 6                            lock(&kvm->slots_lock);
> > > 7                                                     lock(cpu_hotplu=
g_lock);
> > > 8   sync(&kvm->srcu);
> > >
> > > Note, there are likely more potential deadlocks in KVM x86, e.g. the =
same
> > > pattern of taking cpu_hotplug_lock outside of kvm_lock likely exists =
with
> > > __kvmclock_cpufreq_notifier()
> >
> > Offhand I couldn't see any places where {,__}cpufreq_driver_target() is
> > called within cpus_read_lock().  I didn't look too closely though.
>
> Anyways...
>
>   cpuhp_cpufreq_online()
>   |
>   -> cpufreq_online()
>      |
>      -> cpufreq_gov_performance_limits()
>         |
>         -> __cpufreq_driver_target()
>            |
>            -> __target_index()

Ah, I only looked in generic code.

Can you add a comment to the comment message suggesting switching the
vm_list to RCU? All the occurrences of list_for_each_entry(...,
&vm_list, ...) seem amenable to that, and it should be as easy to
stick all or part of kvm_destroy_vm() behind call_rcu().

Thanks,

Paolo


