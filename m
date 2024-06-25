Return-Path: <linux-kernel+bounces-229596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFAC91712F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D53B1C22688
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2817C9F7;
	Tue, 25 Jun 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICaY5V/A"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA916D4C8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719344300; cv=none; b=WxyGkbPYnBF5XWFUSeIK6KRK0hyOiZtH8yl9d6nGiuoP9ODSYCetvPv3wlr2ktQB4RWPCXODDCA0I+XZbcqjHIP+Ipqdj3W9BRLgnTWydcmIeZw672zgTx4P1YuhL6vT6GxNOizH/J+8dW4kDN6+s39b3hb73kUypelfjR7X0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719344300; c=relaxed/simple;
	bh=5OoNLBK/a2S4/Z4kU9kjLu5JvVNL+ahDJ+eUyExuxGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw/Bwv3/ulX4YIGrH3Pm7AkiG/9bB2RxDJ0Nt9IBnEi/7KJI37+74625fnt3VAMCQt0JA3sjZZVflMPzqI6+djZ8JHQ2il+d+/s5iKj6UvKiY34bjASUNVkFS+6vFZl2qxPDq2UyRyrkrE84kAVQTPzttFPndZogneh3p9OZZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICaY5V/A; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-444af5c09e8so39766421cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719344298; x=1719949098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+5LEc+OBSMgdXBP2ouh0qVEc/wr3Xl6YlFgRK9NbOk=;
        b=ICaY5V/AH45KLwaKr4Gw3S7ebr2lOeuLcaAqsxKTfy2EQQwG2BonlFDaWS+/FLv78O
         2YTPCPPsmv3wcnKMZT8KVOKQYhV/eMSFn8IroQLYdje4Feyn8iRLQaN+MzOouaBa7eve
         Mo9D7rvjG5YR0m9Lwq1kAI+ShbgWp+1HJgsiE45MPCXEX/JE/NhptFYqKHy0DOLrhYbh
         v8ctqIfjEJEEnBof4B8+yRBfJyHRTKSpw6Fzgjh+wkUsxTD4srjaKAtGsvXR1a+WR7Z7
         /DHF2ZOPRqaSdA0PQjI/e/00wwjbdGPZYOyX8zbS6ltrNJxdE/OiUNwZCNI78XOpGOzd
         LCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719344298; x=1719949098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+5LEc+OBSMgdXBP2ouh0qVEc/wr3Xl6YlFgRK9NbOk=;
        b=MNInXCS3BKgZtkN2MdLyI7e5jluwoybrE4N38xh+RSOKs8C4Xb9sfD3AmHUBey4yiR
         gNTsY79GsLQpd6W0gdcMW5LmpIndWEZOBKtm1gSB0EZVx491TtWPYQ46S/UkXIDNKKij
         /wsGfCY93Uu04x6AQTS447M8rRtiXIC2LctbuLCpfCNupRXuyxP0wTG/joNmmcjtOeJf
         1+pW0pIev2yKKTfJyFf41T9WyO8HuejnnLX/EvUydHv90WCIohhIMgrpjbc+S6KspMbh
         aztE0hYrJbW9wTcfmMxqTU4nduftI+GIYwFhwgt43MsVeV6oQSiMtux9wDpvypVhNo9T
         KTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOPXgSGqq+6XuNSavwUy8bhp5rERREoGeXIkiDh25zIbBExohgu/zLIcHStJghIqkSPeMmWVWXyOw0lkxgVf662xF4Mp8n1MrcWXST
X-Gm-Message-State: AOJu0YzNWkqHQQLrmP8SU3A30ckcKPdvlTPQ5VgsWBe8OEaJ2VtqUfbw
	3OfSBssTm9Rzo6hM98ky2OdHZu7Mi99EPnWa0U+5+FJOp/8iFWHn
X-Google-Smtp-Source: AGHT+IFbCi7Uf/6gdBEP8f6CjQFm5n1RFQWfULXraKEpnOztYBZSwJjT0NVDXU7RWJm10T8t8xhBsA==
X-Received: by 2002:ac8:5dd4:0:b0:440:1c16:547f with SMTP id d75a77b69052e-444d3c0aed9mr122255401cf.41.1719344297880;
        Tue, 25 Jun 2024 12:38:17 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c3e5b5sm58778321cf.75.2024.06.25.12.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:38:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id CEAD91200069;
	Tue, 25 Jun 2024 15:38:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 25 Jun 2024 15:38:16 -0400
X-ME-Sender: <xms:qBx7ZmyTkk67Ybc-mSynYuPRafaBlYzIiXJxfzwE7nF7PPVCdj_ylg>
    <xme:qBx7ZiTpYfyPcuAFK-R_tMwgZdP2BdaQibXg1Xs_iFr3apdM2RHCtwiWh0P7YrQgM
    lAu4JODeRqLygB0hA>
X-ME-Received: <xmr:qBx7ZoX0tom6ICw_nxCdLafA-mSLBl1GPhuLdxgTGP65nBZlAX4a6WiW-QlDOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qBx7ZsgGFQjaQ_uS7IvnQfBSOMBV1bTbl2UcMlzij-JIDaYF6Wk_hA>
    <xmx:qBx7ZoBXr0HfsyRoPj6ULAHE78TcxIkW3rXl4TyM8oFtDtz3HNwlDA>
    <xmx:qBx7ZtLdK6sK_1NQL89itZCYgN0x5CPLUv7H2Oso_WU2cSUPK7ywoQ>
    <xmx:qBx7ZvCvLVeWtU_Et0OSkqB3S4p-2IWVzblvlYjZc3OAmgtmzyp9uA>
    <xmx:qBx7ZgxWdoTdHTHPNc3qnI-U0B2ElqEa1H16-A1UZoboanNBZlU6KeVj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 15:38:16 -0400 (EDT)
Date: Tue, 25 Jun 2024 12:37:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Alexander Potapenko <glider@google.com>, elver@google.com,
	dvyukov@google.com, dave.hansen@linux.intel.com,
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] lib/Kconfig.debug: disable LOCK_DEBUGGING_SUPPORT
 under KMSAN
Message-ID: <Znscgx8ssMlYUF5R@boqun-archlinux>
References: <20240621094901.1360454-1-glider@google.com>
 <20240621094901.1360454-2-glider@google.com>
 <5a38bded-9723-4811-83b5-14e2312ee75d@intel.com>
 <ZnsRq7RNLMnZsr6S@boqun-archlinux>
 <3748b5db-6f92-41f8-a86d-ed0e73221028@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3748b5db-6f92-41f8-a86d-ed0e73221028@paulmck-laptop>

On Tue, Jun 25, 2024 at 12:06:52PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 25, 2024 at 11:51:23AM -0700, Boqun Feng wrote:
> > On Fri, Jun 21, 2024 at 09:23:25AM -0700, Dave Hansen wrote:
> > > On 6/21/24 02:49, Alexander Potapenko wrote:
> > > >  config LOCK_DEBUGGING_SUPPORT
> > > >  	bool
> > > > -	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
> > > > +	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT && !KMSAN
> > > >  	default y
> > > 
> > > This kinda stinks.  Practically, it'll mean that anyone turning on KMSAN
> > > will accidentally turn off lockdep.  That's really nasty, especially for
> > > folks who are turning on debug options left and right to track down
> > > nasty bugs.
> > > 
> > > I'd *MUCH* rather hide KMSAN:
> > > 
> > > config KMSAN
> > >         bool "KMSAN: detector of uninitialized values use"
> > >         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> > >         depends on DEBUG_KERNEL && !KASAN && !KCSAN
> > >         depends on !PREEMPT_RT
> > > +	depends on !LOCKDEP
> > > 
> > > Because, frankly, lockdep is way more important than KMSAN.
> > > 
> > > But ideally, we'd allow them to coexist somehow.  Have we even discussed
> > > the problem with the lockdep folks?  For instance, I'd much rather have
> > > a relaxed lockdep with no checking in pfn_valid() than no lockdep at all.
> > 
> > The only locks used in pfn_valid() are rcu_read_lock_sched(), right? If
> > so, could you try (don't tell Paul ;-)) replace rcu_read_lock_sched()
> > with preempt_disable() and rcu_read_unlock_sched() with
> > preempt_enable()? That would avoid calling into lockdep. If that works
> > for KMSAN, we can either have a special rcu_read_lock_sched() or call
> > lockdep_recursion_inc() in instrumented pfn_valid() to disable lockdep
> > temporarily.
> > 
> > [Cc Paul]
> 
> Don't tell me what?  ;-)
> 

Turn out that telling you is a good idea ;-)

> An alternative is to use rcu_read_lock_sched_notrace() and
> rcu_read_unlock_sched_notrace().  If you really want to use

Yes, I think this is better than what I proposed.

Regards,
Boqun

> preempt_disable() and preempt_enable() instead, you will likely want
> the _notrace() variants.
> 
> 							Thanx, Paul

