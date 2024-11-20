Return-Path: <linux-kernel+bounces-416094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEF9D4028
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B877E1F23AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8A147C86;
	Wed, 20 Nov 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJJgIYDb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062A487BE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120487; cv=none; b=NvmRM0C9PUZ94r+TzrP7WqzCR2sUKc76btN13CO8u0Zbv6JjjWVj4ktA26APVj+6teXzLwzS6UuGApZHvOlQaoL/Vp+f6YrNw1Ibr8+rzbRtODU9iK7x0Us82Pfy8CkK1lt7xJSjq331LQWObn7iXvvi0FLoGIQS3/8yRZ+sxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120487; c=relaxed/simple;
	bh=CnsBTMGWcf5M8NoeZ38IEeXK/Z4PUSA9a8D7eN7JuxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvS348ISBnU5U8Y8OrD1niCJrVmMMeevhzGKW+VQRoMfvAKg9K2Lyw791bM5lsVtFJF2UY2yWSzqd8ovNdbiPbpW5nxJ1Cibsufz78Qvp50UOoHkavKjUUhaQI6+i1rYbsZLKHgB7shfWqhz2SlHGZ32xAvR7816eHM2hkwLAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJJgIYDb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732120484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B86g3yeGl3bc8HkRs4Pts1DK7V5+9VBe3Itq07US390=;
	b=JJJgIYDbOaI7MKCBKKLsQzDN2al4/ppOnnVwBpVksALYQLHL0XMKuPon+NsWcGtg3Qr86O
	/VzRqnyzZAr7KtUuIeUX8DHToozMs0orAgosSDhfx/xUemXKKhREmkbY/nSrIo1MUH8BEl
	2SWAdChtfkA0KLnAqQEx7Qg+QVRK0bw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-LL8bWGzMN6qXp4zAuDjqdA-1; Wed, 20 Nov 2024 11:34:43 -0500
X-MC-Unique: LL8bWGzMN6qXp4zAuDjqdA-1
X-Mimecast-MFC-AGG-ID: LL8bWGzMN6qXp4zAuDjqdA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b155c120daso271201785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120482; x=1732725282;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B86g3yeGl3bc8HkRs4Pts1DK7V5+9VBe3Itq07US390=;
        b=KA33qR1OhmWAwelYEFSFBYSVjVEOS+fDSbqZC9ak1Ba/8EoRdG+qE+B309vGiselLc
         LHZbj7JD2/tXnlYfNp7mp052x4KVOLD2F3uSgZdAXbKFrbFpkpbl1DYTo6Yvso3+owLj
         CRn9Z9uLJKLxPiD/sPeP3QsuRW1c/qqildFolmKTKZy0tvaKcT0Dp1/5ivFDeUmZ6VG8
         2p4ACauVAePFfO6Oo2fFqyFDGzgkFF+iWKgm4IeqHy9aJXx21z8GeNXd2k/nR4NjNMi3
         jDykWl13fty9Zkcu6x4J4UINrYemDgMuBkSGhqDYUQD+/tcIBWe/z1TwoD6dIJOl4RaK
         j+aQ==
X-Gm-Message-State: AOJu0YxA6X55nXiNX2RfFuBZUvmVdwyIT3Au7sOLVsVTFyJswNn6fChQ
	EEvK7vQ9yZoppNypx7kUSSYN27uVRs16m2zpBJj/B2HRn4Xb5gfc+xVWyKrfrh1n5w4ylmtA7Lk
	0HPpNRqex/Efi0WHsLRQOk8HW7zVt0bsu4qn2F3gKE/kOBcDRJsE+ZSyQFx3AAQ==
X-Gm-Gg: ASbGncv0jS1IkXI4Elo5yIZI16gEOqVa5v3XIjwPc9nHfB3FoBk8tWUaURjDMn5lSi/
	8SIvwPMoSdQN7XzPa/0LPTzsi/5fHBZOrAu8yq9OJB0dJ0cd+JBvouwfmb5eC8rvow+/37Vgni5
	ivfCgQNcbdUVkOjTnQ+eapN8v/R+bV1S4YTi7fvbOKHNqQp215+hX7xgBfcQ75LHja5II3xP1op
	omkXom8spN3f9SrWW13nRmYTQwWvBZqiDUfToJj29EExGalFqt/Z2nWvZkg7X9jL8mntstAUd4m
	bGfWPWA6P5+NAV/h1pLZ7WSwH3Rug7rZUvE=
X-Received: by 2002:a05:620a:1a90:b0:7b3:7e5e:8708 with SMTP id af79cd13be357-7b43bed4bd7mr355527385a.59.1732120482221;
        Wed, 20 Nov 2024 08:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW1sR9A/+saR1lpfmvKEOVIZYurnawvss8FWysYqEx/qwbDy9sFoGDQpoH7d4xuTE1Ki3dPQ==
X-Received: by 2002:a05:620a:1a90:b0:7b3:7e5e:8708 with SMTP id af79cd13be357-7b43bed4bd7mr355524385a.59.1732120481951;
        Wed, 20 Nov 2024 08:34:41 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b48523f72bsm112716485a.104.2024.11.20.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:34:41 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel
 Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 08/15] sched/clock, x86: Make
 __sched_clock_stable forceful
In-Reply-To: <20241120145904.GK19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-9-vschneid@redhat.com>
 <20241120145904.GK19989@noisy.programming.kicks-ass.net>
Date: Wed, 20 Nov 2024 17:34:32 +0100
Message-ID: <xhsmhv7whhnjb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:59, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:34:55PM +0100, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about non __ro_after_init static
>> keys being used in .noinstr sections in order to safely defer instruction
>> patching IPIs targeted at NOHZ_FULL CPUs.
>> 
>> __sched_clock_stable is used in .noinstr code, and can be modified at
>> runtime (e.g. KVM module loading). Suppressing the text_poke_sync() IPI has
>
> Wait, what !? loading KVM causes the TSC to be marked unstable?

Ah, maybe not, I saw the below but that's actually the x86 specific stuff
and IIUC can only be builtin:

  kvm_init_platform()
  `\
    kvmclock_init()
    `\
      kvm_sched_clock_init()
      `\
        clear_sched_clock_stable()

There is however this:

  kvm_arch_vcpu_load()
  `\
    mark_tsc_unstable()

So plugging a VCPU might do that.


