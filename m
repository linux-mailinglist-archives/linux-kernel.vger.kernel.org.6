Return-Path: <linux-kernel+bounces-415664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B219D3998
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE14D282D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0919E966;
	Wed, 20 Nov 2024 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9SQsHzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DED19DF4F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102584; cv=none; b=FpqxZUJW3FKJ5f1QBBa6SOPKHrYFDg668LtG5fyLcFik9kkiEeJDvs+wCi0gdjQ+erqDetSe9JnAyt5cg6caOYlhhayhPOrYRGXmW0NQU9J0lo+Uxgkpn/9VtfWc9HBMVtTPcFWLvsmCSkMrpOk5yOcfFCyOCgl07LxnimLqE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102584; c=relaxed/simple;
	bh=b9ZTko/Jym9h2gl1CHOMGnwxFpCGFUyTh1TMa/eEUZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdLHfb7hPCx58SvftEJFs/kXzib6ls0GD487HArCtLewJS2CgTtBhm129fB9exFuT+anm+J+5du3hnDLqvxKPuEPNMDCKoGjuI2fHpfC88620fGgnhdTLupIgvtywIiNKVGzBk1I93AlUotoCzq+ZtuZi78jFp19vePtEIvfErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9SQsHzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF999C4CECD;
	Wed, 20 Nov 2024 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732102584;
	bh=b9ZTko/Jym9h2gl1CHOMGnwxFpCGFUyTh1TMa/eEUZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9SQsHzf+M+BsVBmn2gcle1yha7mKwarnVkcRphMwM3tazzIJQ7n4PBnjo4xnJDv5
	 h2Qq09GqIX1ktxlPTDUp707ehyw5AXO4lRVADyU+BN10zEYfJDdiifXq1JixrVsUvc
	 NnDHUb/FJTr00YFRwUZCyxe+6ZqCgS5GAIj3ntLOkwnh7MPiBUbKOlIoGTxO2vAqHk
	 7Dv6NTs6amJeyprnKFEvFCmt7l8o3GpuY7G6pcnD87NcoWXVxwcQ41L9+8DZK6HNam
	 gVa/zAfKaQ8Rhp36iJcHIFedTnZUYDbMvIIxffVTLmACsE3uq/tBTMTAss7ID4y5j4
	 E4UWRkShrESSQ==
Date: Wed, 20 Nov 2024 12:36:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH] headers/cleanup.h: Fix if_not_guard() fragility
Message-ID: <Zz3Jsn7Vf8X9ICva@gmail.com>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
 <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 18 Nov 2024 at 01:03, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - <linux/cleanup.h>:
> >     - Add if_not_cond_guard() conditional guard helper (David Lechner)
> 
> I've pulled this, but I'm unhappy.
> 
> This macro generates actively wrong code if it happens to be inside an
> if-statement or a loop without a block.
> 
> IOW, code like this:
> 
>     for (iterate-over-something)
>         if_not_guard(a)
>             return -BUSY;
> 
> looks like will build fine, but will generate completely incorrect code.
> 
> Honestly, just switching the order of the BUILD_BUG_ON() and the
> CLASS() declaration looks like it would have fixed this (because then
> the '_id' won't be in scope of the subsequent if-statement any more),
> but I'm unhappy with how apparently nobody even bothered to think
> about such a fundamental issue with macros.
> 
> Macros that expand to statements absolutely *ALWAYS* need to deal with
> "what if we're in a single-statement situation?"

How about the fix below?

Thanks,

	Ingo

=======================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 20 Nov 2024 11:56:31 +0100
Subject: [PATCH] headers/cleanup.h: Fix if_not_guard() fragility

Linus noticed that the new if_not_guard() definition is fragile:

   "This macro generates actively wrong code if it happens to be inside an
    if-statement or a loop without a block.

    IOW, code like this:

      for (iterate-over-something)
          if_not_guard(a)
              return -BUSY;

    looks like will build fine, but will generate completely incorrect code."

The reason is that the __if_not_guard() macro is multi-statement, so 
while most kernel developers expect macros to be simple or at least 
compound statements - but for __if_not_guard() it is not so:

 #define __if_not_guard(_name, _id, args...)            \
        BUILD_BUG_ON(!__is_cond_ptr(_name));            \
        CLASS(_name, _id)(args);                        \
        if (!__guard_ptr(_name)(&_id))

To add insult to injury, the placement of the BUILD_BUG_ON() line makes 
the macro appear to compile fine, but it will generate incorrect code 
as Linus reported, for example if used within iteration or conditional 
statements that will use the first statement of a macro as a loop body 
or conditional statement body.

While it doesn't appear to be possible to turn this macro into a robust 
single or compound statement that could be used in single statements, 
due to the necessity to define an auto scope variable with an open 
scope and the necessity of it having to expand to a partial 'if' 
statement with no body - we can at least make sure the macro won't 
build if used in a single-statement construct: such as by making the 
CLASS() line the first statement in the macro, followed by the other 
statements, which would break the build, as the single statement would 
close the scope.

Do this.

To test this, I added an artificial if_not_guard() usecase within a 
single statement:

Before:

	$ make kernel/ptrace.o
	CC      kernel/ptrace.o
	$

After:

	CC      kernel/ptrace.o
	In file included from ./include/linux/irqflags.h:17,
		       from ./arch/x86/include/asm/special_insns.h:10,
		       from ./arch/x86/include/asm/processor.h:25,
		       from ./include/linux/sched.h:13,
		       from kernel/ptrace.c:13:
	kernel/ptrace.c: In function ‘ptrace_attach’:
	./include/linux/cleanup.h:258:9: error: expected expression before ‘class_mutex_intr_t’

I'd also like to note that the original submission by David Lechner did 
not contain the BUILD_BUG_ON() line, so it was safer than what we ended 
up committing. Mea culpa.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Fixes: 36c2cf88808d cleanup: Add conditional guard helper
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 966fcc5ff8ef..263f14085617 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -351,8 +351,8 @@ _label:									\
 	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 
 #define __if_not_guard(_name, _id, args...)		\
-	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
 	CLASS(_name, _id)(args);			\
+	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
 	if (!__guard_ptr(_name)(&_id))
 
 #define if_not_guard(_name, args...) \

