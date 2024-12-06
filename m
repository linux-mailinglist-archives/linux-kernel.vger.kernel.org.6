Return-Path: <linux-kernel+bounces-434701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F99E69EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398B11884A42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668C1DFDA1;
	Fri,  6 Dec 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av9WrZ0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BD22315
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476771; cv=none; b=WzpUyVaSx0DXV0d0a0WPn6HfMEfVRsxnnwBhCLR0wjOVZ6+/luKBmFmC8nmVczS6nHIB5kkPo20TJAd3Aktmu99RkrYpeb8Sov5McIVsxD8TXeApKQVoPwW3SPX0tHdLhJ8oHSxr7+403938DHm9NpCsJ2qIfOwaIGkSVumV/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476771; c=relaxed/simple;
	bh=Xx2ESvT6rkusBTIbrPowW0jyWmtIIlYoaPGOv2j1/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJzAC/LPTkA0l/5kRUXY8Cf6tRSJEi+EPQr2jcpUHaeJFa9bLuUg1KDyWEtWrrIrNoQFT3hTPrmcwIal/+IYNAEvyoYufCMTJFrnV7iDkzBqcEgwKKzn8wyT2l+S5clYOw9Gut9cq5+fbY7mYSjmwasDkkGIgcNSCFqvgDMjNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av9WrZ0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CC2C4CED1;
	Fri,  6 Dec 2024 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733476771;
	bh=Xx2ESvT6rkusBTIbrPowW0jyWmtIIlYoaPGOv2j1/+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=av9WrZ0MLXJhbBLQ+1kMSTPsKMhDDmG9StFQwLXYUQdJHzVo/2deQMIqa/uUQh3jC
	 qysSn2EH1WIHMGmuGIqJPKJZNqaIiJaF84SCB8YOU80Rr9kFzDd7IoDa2uNNY/vnPq
	 EPrbyzyGahJ+rNqGHgqF72kI13QRaR9EleNDnCtShfKFzLNYLkOwGnGeRHPLHCk+GB
	 D6w5imwqntvsp1Mhjxz9R97pG83F1Ml+WarRRiazALv5pKxCclz5zoJJACR/88KCwt
	 zOHxNHpPAMOmO1tjGzae+1k7CtTFkFLXTOXQ3+RhMYWpvcEIagqCNtgr7aWAZ4GoLV
	 xq7YlbgAFrSNg==
Date: Fri, 6 Dec 2024 10:19:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] headers/cleanup.h: Remove the if_not_guard() facility
Message-ID: <Z1LBnX9TpZLR5Dkf@gmail.com>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
 <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
 <Zz3Jsn7Vf8X9ICva@gmail.com>
 <6499c178-b34d-47f9-8b1e-c87852d8426e@baylibre.com>
 <CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 20 Nov 2024 at 09:57, David Lechner <dlechner@baylibre.com> wrote:
> >
> >         cond_guard(mutex_intr, &st->lock, &ret);
> >         if (ret)
> >                 return ret;
> 
> I'm not convinced that improves on anything.
> 
> You just replace one disgusting syntax with another, and force people
> to have a variable that they may not want to have (even if they have
> an error return variable, it might commonly be an error pointer, for
> example)
> 
> I really think the basic issue is that "cond_guard" itself is a pretty
> broken concept. It simply doesn't work very well in the C syntax.
> 
> I wish people just gave up on it entirely rather than try to work
> around that fundamental fact.
> 
> Not that long ago, Mathieu wanted to introduce "inactive guards" for
> some similar reasons - kind of "conditional guards, except the
> conditional is outside the guard". And I pointed out that the fix was
> to rewrite the disgusting code so that THEY WEREN'T NEEDED in the
> place he wanted to use them. Rewriting things to "Just Don't Do That,
> Then" actually just improved code entirely:
> 
>    https://lore.kernel.org/all/CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com/
> 
> and honestly, I suspect the same is often true of this whole
> "if_not_guard()" thing. It's not *hugely* often needed, and I strongly
> suspect that the explicitly scoped version would be a *lot* safer.
> 
> The "if_not_guard()" model may be great for mindless conversions of
> existing code. But I'm not convinced it's a great interface in itself,
> or that "mindless conversions" of conditional locking is actually a
> good thing.

Ok, agreed - and to progress with fixing the bug & the fragility you 
noticed, let's remove if_cond_guard() as a first step via the patch 
below.

Thanks,

	Ingo

=================================>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 6 Dec 2024 10:13:32 +0100
Subject: [PATCH] headers/cleanup.h: Remove the if_not_guard() facility

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

It doesn't appear to be possible to turn this macro into a robust
single or compound statement that could be used in single statements,
due to the necessity to define an auto scope variable with an open
scope and the necessity of it having to expand to a partial 'if'
statement with no body.

Instead of trying to work around this fragility, just remove the
construct before it gets used by code.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
---
 include/linux/cleanup.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 966fcc5ff8ef..ec00e3f7af2b 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -273,12 +273,6 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *	an anonymous instance of the (guard) class, not recommended for
  *	conditional locks.
  *
- * if_not_guard(name, args...) { <error handling> }:
- *	convenience macro for conditional guards that calls the statement that
- *	follows only if the lock was not acquired (typically an error return).
- *
- *	Only for conditional locks.
- *
  * scoped_guard (name, args...) { }:
  *	similar to CLASS(name, scope)(args), except the variable (with the
  *	explicit name 'scope') is declard in a for-loop such that its scope is
@@ -350,14 +344,6 @@ _label:									\
 #define scoped_cond_guard(_name, _fail, args...)	\
 	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
 
-#define __if_not_guard(_name, _id, args...)		\
-	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
-	CLASS(_name, _id)(args);			\
-	if (!__guard_ptr(_name)(&_id))
-
-#define if_not_guard(_name, args...) \
-	__if_not_guard(_name, __UNIQUE_ID(guard), args)
-
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a

