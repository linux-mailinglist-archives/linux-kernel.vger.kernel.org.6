Return-Path: <linux-kernel+bounces-229539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C62917097
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F41C22FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51974176AC3;
	Tue, 25 Jun 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbWf/VIx"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050E1369B6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341525; cv=none; b=Zplvw4sjGad7ruYzGZ0Rdjyc1gOw9uoVMGN+gIcOiIwrPs6yadP2Hp35HW9zVSTre5u/j5WzeRdTCktBJGALJI8Qtto/auwcjVgGiNenRQyhPwIw8Fz9/hFVjbhzDYYS/t/TJt/1caX9NOxwEBe8JDfTtZdy19U67tLUOovyYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341525; c=relaxed/simple;
	bh=FURXO1WeM9KERwVxU7l70dy29D6wHhmffFfGT/ThtuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ftfnd6GakK+cKE+0MzQqX3pl3rTMPQzfGf8U7IimqwFk8adk7SMJdVqYYLXlqdRxVTsStkm7/pQ5ldDXinbgKTHJdFS4f0P5qoUv5ktMrdRLY6HbgCTULTZOqaNwmnqX/5EA0Ra0hk99HkpxHTymNqxlycK0/HgnRxoCXkcVgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbWf/VIx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79c0f8d6ec5so41462285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719341523; x=1719946323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMdSyT3TskY0tTwnKiqqMsQwUOsNCEG9Wo5ZTR+RF68=;
        b=BbWf/VIxczt1R7s0/nbnWNV3lze4rYsiwKA8PO3EvWyHaVYvBuuStU3WSCtXZ/34aV
         PQ+b4h90LYto/BuRuzpha8YgmhdKhZYlhy/abV/LjlUfn8L0OBkvZm5RnUu867xRkQEX
         vhwFPp7tbVACn97wEUZFFpyDElkv5AyiZwRhqUTG7qrIXcNDxT5TeZ1DnLkgUcLBIO0j
         3ZV4TvazLjoDlmjUSQ/475i4MRxAZxEFYka8w5RiOzEVD6JbSPmNkYdbgq+5RAVMuc47
         vmtUIS4WL5lWfyOg1ZferVh5eFoAIn++hkYJbzAdghvi70bc9GYwyacevQ23QaBZfzve
         D25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341523; x=1719946323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMdSyT3TskY0tTwnKiqqMsQwUOsNCEG9Wo5ZTR+RF68=;
        b=m24XoejEuqN1NpjXcV9bzugZpF/hZNd4CqwjpTbFWhp849BDPKwV/DrLuxFsUCero6
         mFEmxBqzMzQaumWJ/Jm/ToaLjfivaYbK0cZO+Og0Txnmj2VYbXBarxUCLFqowkUvW5DX
         S33MIU8OSAQd77JVafeRAIDvSRiRSBgi8xHsecX4u7VaA+5+JUanT7iK92me4+EKifUq
         7EB58d/72tosiGyCtunMAracOcRgDI/PAkwOwkAzwCIPgQEyF7gikJkmeP9qFQZnithp
         Qw/fqyqpGExmylmpvHdcJrOC0uNM8ENAot693Yl6Mc0Zx8s8si63qilBqWDoS5AgYb3Z
         5FQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyXksuy/wvAM9+tIUWwKHn6wNRf267AOvu89EU6TV0i96jpqNdWvs4w6C6ys9jjWNl9zrf5rU88RdjBGIYpRn0Q6CDyQ3Y88+n8T4u
X-Gm-Message-State: AOJu0YydhHa2xjw65yd7SzwZVGZo9BKpIe5K8oKpv+EdyGDT1uZHcQsF
	2M9AY3jo+071tr03Hd7D9W+lGijhV02+yhd3NB9OgMsukXk2sI2W
X-Google-Smtp-Source: AGHT+IFVlzLKfW2XCNk1dbKb+dJ8oL0T0fua+QmFIyZ0d5tbTe1TzD7WGsmsb6LBcX1Z63xkfBC3RQ==
X-Received: by 2002:a05:620a:240a:b0:79b:efe1:1221 with SMTP id af79cd13be357-79befe112f7mr863743985a.48.1719341523018;
        Tue, 25 Jun 2024 11:52:03 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce933e28sm430784785a.120.2024.06.25.11.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:52:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2D06D120006B;
	Tue, 25 Jun 2024 14:52:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Jun 2024 14:52:01 -0400
X-ME-Sender: <xms:0RF7Zi4cCwR_2FODPaE_7FeHVem8MDWqwS4NTWWmVxWyBvw1QAVWAA>
    <xme:0RF7Zr5vato65g-qckf9tV0sTMuzk97uUQ61jKPH1liKzEIHrtahAYFkY8tvCn5CI
    mQI2H7yHO-VkQBs1Q>
X-ME-Received: <xmr:0RF7ZhegPl7nkM2qRWPjNQoDHlGfw1gBwBU8WlbnEQ48Rp6uHs-QFzpbtg8HYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0RF7ZvI_ljCVI6m0sZT4hN8n0VmMOvU2Q_ix2HcmJkITQN5YisVFrw>
    <xmx:0RF7ZmJqyLhitldL8C2O3d2yp5fmTEqQLPO9Io6X6Zc2e3Ih3YhAZg>
    <xmx:0RF7Zgz0J0wvDHQqeZ1547t6VZvKf1jD-Dm_g7zjufymrDnvZq5Rgg>
    <xmx:0RF7ZqJC8ydfOY3LVrFGwtlZfl-V6weIVhH_SS-H5eAT8OhxPwGUbQ>
    <xmx:0RF7Zta3eYLagYLdZx9_jAjELamV3pyR5pvr2KwBtCCCBB6LVDMvumxl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 14:52:00 -0400 (EDT)
Date: Tue, 25 Jun 2024 11:51:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alexander Potapenko <glider@google.com>, elver@google.com,
	dvyukov@google.com, dave.hansen@linux.intel.com,
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/3] lib/Kconfig.debug: disable LOCK_DEBUGGING_SUPPORT
 under KMSAN
Message-ID: <ZnsRq7RNLMnZsr6S@boqun-archlinux>
References: <20240621094901.1360454-1-glider@google.com>
 <20240621094901.1360454-2-glider@google.com>
 <5a38bded-9723-4811-83b5-14e2312ee75d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a38bded-9723-4811-83b5-14e2312ee75d@intel.com>

On Fri, Jun 21, 2024 at 09:23:25AM -0700, Dave Hansen wrote:
> On 6/21/24 02:49, Alexander Potapenko wrote:
> >  config LOCK_DEBUGGING_SUPPORT
> >  	bool
> > -	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
> > +	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT && !KMSAN
> >  	default y
> 
> This kinda stinks.  Practically, it'll mean that anyone turning on KMSAN
> will accidentally turn off lockdep.  That's really nasty, especially for
> folks who are turning on debug options left and right to track down
> nasty bugs.
> 
> I'd *MUCH* rather hide KMSAN:
> 
> config KMSAN
>         bool "KMSAN: detector of uninitialized values use"
>         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
>         depends on DEBUG_KERNEL && !KASAN && !KCSAN
>         depends on !PREEMPT_RT
> +	depends on !LOCKDEP
> 
> Because, frankly, lockdep is way more important than KMSAN.
> 
> But ideally, we'd allow them to coexist somehow.  Have we even discussed
> the problem with the lockdep folks?  For instance, I'd much rather have
> a relaxed lockdep with no checking in pfn_valid() than no lockdep at all.

The only locks used in pfn_valid() are rcu_read_lock_sched(), right? If
so, could you try (don't tell Paul ;-)) replace rcu_read_lock_sched()
with preempt_disable() and rcu_read_unlock_sched() with
preempt_enable()? That would avoid calling into lockdep. If that works
for KMSAN, we can either have a special rcu_read_lock_sched() or call
lockdep_recursion_inc() in instrumented pfn_valid() to disable lockdep
temporarily.

[Cc Paul]

Regards,
Boqun

