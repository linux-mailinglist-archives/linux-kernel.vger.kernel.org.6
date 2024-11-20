Return-Path: <linux-kernel+bounces-416146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5E9D40D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D1D1F21DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBE19F10A;
	Wed, 20 Nov 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlEMllSz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0E155742
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122663; cv=none; b=meNZPEY/ikE17Ls6nCh+2hTx6gWfPRBl09yetAjwXDfq0gskDSmGCiHokymXx4Cq1TaBl7z24+oPL6kALJtoOSAihW3Yc1Xnvhj7HQ7/bVMAvjW34Z+O9uJYPL/8/s0mldWKUC9m7jDadMKZDycRaxpLs08AWuWr4your5d1u40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122663; c=relaxed/simple;
	bh=bD2+PXc5yOVf78h3sEDBO2zFlBtAaawUxdecGEXQBRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SoFb5Jz8T4gHE6speORxZ5zOEpP3cDshc3youtUyvcwEvextJ+NwvK8C909/afCdS4LwOg5JNVUk1OpGzXr+7/V/RYlPHxIg00YCCTIa3aHM/SI6MbXW46JuS2SSVEVb4YXbuYmmA3FHTrE+JX7xx0+On4vY7/VRz/6oYXnMA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlEMllSz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732122661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/9IdVXzOrQgYnWle7hTlDaq+06CP5BjggLeefeVjYk=;
	b=RlEMllSzA/rxihIOBY6n8GHJwW51db9xCc32IN9Uy01ILvAbOUaHTlGlKVzJps9+IXf9rw
	mPjT+jQWgDKNjJiCXyFQIckz92yZUUZNuYnFrbYkID5mUxf/s5wsAwBMWxeD9O3FfBvVuL
	BDa2gTAy4ZJKDj6tTl1TqsCSwj3lE0I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-akK3ynbcOaKbCWRX1ro99w-1; Wed, 20 Nov 2024 12:10:58 -0500
X-MC-Unique: akK3ynbcOaKbCWRX1ro99w-1
X-Mimecast-MFC-AGG-ID: akK3ynbcOaKbCWRX1ro99w
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d4076aa09cso200586d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122658; x=1732727458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/9IdVXzOrQgYnWle7hTlDaq+06CP5BjggLeefeVjYk=;
        b=dXDXcvcQrCga2XILu7F3a+JBegufN1VVRlJl1JNH7Hc8sewZn6yHum5rkFplqd2xww
         lULlTABYdCHF/IjFXZ+fD53BZ9DgGjCDQhrYS/GPmmF2dCjdmC37jgyUqe/A20FB4z1g
         oVgHYxZkAgb7F1rnbXD2xioe2ipV99feztD/3ViS5Y+/FGHUShXmKkI9mu+T4TWhMmpj
         uxM6zS3YfpffnpyKB+kgBXj1VCMhXiZyp/OMlgROI9Z7k2RySn8c2kxFCxHX5ut1S1l0
         yQ2H3WUvHaoQhUj8yxqmpluZAQ18RtXhG/veW1ejB+MHdFF+idwNIYGs2iKveKGITMH9
         rqPg==
X-Gm-Message-State: AOJu0YzdurUS1mfRlhslcPHJthWe858xXEAul5hBWmxHDilZ/+9p3U2t
	JSyWtJiY0K/8IK5Yb52EpgSnVsWGbCnGHbGCmSiiksQ8kwnZY9r12ql9BYpsl3fUPKy2Ltivt+M
	I3w5K/uU8UoTBFcPwbr1D5mAbXzRvEAHonY0XayrVkAJ8uhEP28r1N+/w2azurA==
X-Received: by 2002:a05:6214:1d2a:b0:6d4:1c3b:1cb6 with SMTP id 6a1803df08f44-6d43779b915mr51503856d6.18.1732122658326;
        Wed, 20 Nov 2024 09:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv9CkwhZjIaA2k5+ZORakSpYnSngvWk8FXITINBTOVrkhvREcruWPODJNNTMgDJRVDzvSyug==
X-Received: by 2002:a05:6214:1d2a:b0:6d4:1c3b:1cb6 with SMTP id 6a1803df08f44-6d43779b915mr51503036d6.18.1732122657909;
        Wed, 20 Nov 2024 09:10:57 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab11sm12976636d6.94.2024.11.20.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:10:56 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [RFC PATCH v3 11/15] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <Zz3w0o_3wZDgJn0K@localhost.localdomain>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home> <Zz3w0o_3wZDgJn0K@localhost.localdomain>
Date: Wed, 20 Nov 2024 18:10:43 +0100
Message-ID: <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/24 15:23, Frederic Weisbecker wrote:

> Ah but there is CT_STATE_GUEST and I see the last patch also applies that to
> CT_STATE_IDLE.
>
> So that could be:
>
> bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> {
> 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> 	unsigned int old;
> 	bool ret = false;
>
> 	preempt_disable();
>
> 	old = atomic_read(&ct->state);
>
> 	/* CT_STATE_IDLE can be added to last patch here */
> 	if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
> 		old &= ~CT_STATE_MASK;
> 		old |= CT_STATE_USER;
> 	}

Hmph, so that lets us leverage the cmpxchg for a !CT_STATE_KERNEL check,
but we get an extra loop if the target CPU exits kernelspace not to
userspace (e.g. vcpu or idle) in the meantime - not great, not terrible.

At the cost of one extra bit for the CT_STATE area, with CT_STATE_KERNEL=1
we could do: 

  old = atomic_read(&ct->state);
  old &= ~CT_STATE_KERNEL;


