Return-Path: <linux-kernel+bounces-526314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBEA3FD35
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02F1860E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6081D5AA1;
	Fri, 21 Feb 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxfAqnV9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597B24BD06
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157815; cv=none; b=DSq2ri1vycHa87jNICu9UIK4hbi8LnJcIepfe3iMdpNiEmgrKroETaGSdEqj5lMEeG4/Nm1w9lOyutgv0AqUxrzcX/scljf5F/HGtCXNsUs8GTuuZPv5kB0R3uv3CJKrzumq+gmvVRt/DQBNOSpgHOD9aTUawQ9cTXaDa+awBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157815; c=relaxed/simple;
	bh=aeZfSLvONakrPfUFPz6/WEr+o9IGTdzP41h/PEH+b6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD3r5UP819152c48HD4jkWCZNif0C1YF3xOyBrSeUVQ27y/GupreTxaXUcED9zYC94YfsroCTQR6repWgpYYbB511YK9qu/N5L0Y4i6StGImB8wSEo2lGx7TiBmdQYn3pwOV+rtzB2g1zFytb7+8x5p6Jd/6Xmo4Z8MA3fDI0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxfAqnV9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so15999465e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740157811; x=1740762611; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ae5OH7jwtkminWKyF9PaRglXPc6x2IkfIyVHHThfxY=;
        b=KxfAqnV9ZfFtqjWVvQBrWEs09AEtjeoqIQLN7k3u7sUqge3nP0eHwF/4C7k0cS6FYm
         A9eHzf0DaYgwo1b2xRVtgwqAg7X65q1VV/McghBBWgNdnMclCImICPW9oeAfXW1qq1ZU
         /PyhNKx1rwHrzlI7sjK86zRJjM2vddp9gI/EqOqE82IFLNJ6NWDWO/h5OiaeN+ypcAJC
         J5ff38xRCU2ey3y23/jfDuwxARXASLXxSxeACD6OGktT31lxQWfu7j/gDVWVyGRM8tiA
         bVVt5QfDceiVliw1vPWvPGWXe6sN8ebtifjxJUaHp8vPq20mHER+10GnrFn27xq8vThD
         y70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157811; x=1740762611;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ae5OH7jwtkminWKyF9PaRglXPc6x2IkfIyVHHThfxY=;
        b=S+JXGWAbZ2Sd8/yL637+0Den63+Gv7NqXRdQV+daeUIWPJry+Kxs75+iTVBxsA28E+
         35+JkFeP2Vz5lrWWzpqA+tATe41FUmjxM8Bva6fFNsaGhbU4U06+ENU8ucv9afhJYjmQ
         B2ogfZsl7wCnhdZzXWanoddVBpMs8GmolE0pBsDue4NgD5QePaIwR5kVCgDCj7sjCWEi
         nSc8YZu+D0oT4EGwI9R+D2AxEJbrpSHBdioe3VkZgsK29jfu96j/jteNVRlVUic9NshH
         t7pofl0jaV4TFDH39x98WOjCS4zomVAUPMU8c76Sl8T1vrHrt0ziz/wEVaY3sMaMzcsF
         Z+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVaAjH+mP3oUvtz2cwJhzWsrsySht1MyGFPQFaqbt1tFtbQ/v2YxttKRGuuC+/lQFi7+X2cvvkY7pyIUJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX7BVDCODth+16O2KcKEGo7tQELZpyLfL+VEvVvI4vK/wEh8I
	olTsQoWSZ/mODwiFCBS6GanIdQRx46pfxeVwIIifr2tYjfhZwZ1M1hKG/r93wQ==
X-Gm-Gg: ASbGncsXIufOcAsMHKonooldJymhMARcFqKYRuU/VEYFsqH8p4dZSlJbSKG6/WKYgpe
	2HMDKdvCxl4zEUreabn0xlMfEeZAe4Wi5E3ragB+1yDIx1B71f2EMKPZ29sp/aW9PwwBUkoemdL
	aEmlmQ3PDxj/iud1eoHiy5f4hV0yuRMHhU38Icx2FNMM83iuU6cf6/cH7WD80X4SFU4/xu6gZhI
	0+5E/On74d38gVgHnv+QsEdhbAnaEQjmHL2M0KQhVSq54U1Ei6ge9j6VcZHfl6F3roFbz3SzRls
	glTmbs33PnPZkdFsLIteM+xDEsp9HhUmwwCt0wgWzfziOg3+eX/6Z9OCqyjv
X-Google-Smtp-Source: AGHT+IEhS0wHzWZ8v8tDe/zSH7y0WxAcPZjhTbw7jssA/vfQ5STDgIJLHbo0vQIMFfjV4xZX+eKRaw==
X-Received: by 2002:a05:6000:154a:b0:38d:e3da:8b50 with SMTP id ffacd0b85a97d-38f7082821bmr3755812f8f.39.1740157810923;
        Fri, 21 Feb 2025 09:10:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:9d7a:cec:e5e:1ee2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f561bee3esm9232017f8f.21.2025.02.21.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:10:10 -0800 (PST)
Date: Fri, 21 Feb 2025 18:10:02 +0100
From: Marco Elver <elver@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexander Potapenko <glider@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC 15/24] rcu: Support Clang's capability analysis
Message-ID: <Z7izasDAOC_Vtaeh@elver.google.com>
References: <20250206181711.1902989-1-elver@google.com>
 <20250206181711.1902989-16-elver@google.com>
 <a1483cb1-13a5-4d6e-87b0-fda5f66b0817@paulmck-laptop>
 <CANpmjNOPiZ=h69V207AfcvWOB=Q+6QWzBKoKk1qTPVdfKsDQDw@mail.gmail.com>
 <3f255ebb-80ca-4073-9d15-fa814d0d7528@paulmck-laptop>
 <CANpmjNNHTg+uLOe-LaT-5OFP+bHaNxnKUskXqVricTbAppm-Dw@mail.gmail.com>
 <772d8ec7-e743-4ea8-8d62-6acd80bdbc20@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772d8ec7-e743-4ea8-8d62-6acd80bdbc20@paulmck-laptop>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Feb 20, 2025 at 05:26PM -0800, Paul E. McKenney wrote:
[...]
> > That's what I've tried with this patch (rcu_read_lock_bh() also
> > acquires "RCU", on top of "RCU_BH"). I need to add a re-entrancy test,
> > and make sure it doesn't complain about that. At a later stage we
> > might also want to add more general "BH" and "IRQ" capabilities to
> > denote they're disabled when held, but that'd overcomplicate the first
> > version of this series.
> 
> Fair enough!  Then would it work to just do "RCU" now, and ad the "BH"
> and "IRQ" when those capabilities are added?

I tried if this kind of re-entrant locking works - a test like this:

 | --- a/lib/test_capability-analysis.c
 | +++ b/lib/test_capability-analysis.c
 | @@ -370,6 +370,15 @@ static void __used test_rcu_guarded_reader(struct test_rcu_data *d)
 |  	rcu_read_unlock_sched();
 |  }
 |  
 | +static void __used test_rcu_reentrancy(struct test_rcu_data *d)
 | +{
 | +	rcu_read_lock();
 | +	rcu_read_lock_bh();
 | +	(void)rcu_dereference(d->data);
 | +	rcu_read_unlock_bh();
 | +	rcu_read_unlock();
 | +}


 | $ make lib/test_capability-analysis.o
 |   DESCEND objtool
 |   CC      arch/x86/kernel/asm-offsets.s
 |   INSTALL libsubcmd_headers
 |   CALL    scripts/checksyscalls.sh
 |   CC      lib/test_capability-analysis.o
 | lib/test_capability-analysis.c:376:2: error: acquiring __capability_RCU 'RCU' that is already held [-Werror,-Wthread-safety-analysis]
 |   376 |         rcu_read_lock_bh();
 |       |         ^
 | lib/test_capability-analysis.c:375:2: note: __capability_RCU acquired here
 |   375 |         rcu_read_lock();
 |       |         ^
 | lib/test_capability-analysis.c:379:2: error: releasing __capability_RCU 'RCU' that was not held [-Werror,-Wthread-safety-analysis]
 |   379 |         rcu_read_unlock();
 |       |         ^
 | lib/test_capability-analysis.c:378:2: note: __capability_RCU released here
 |   378 |         rcu_read_unlock_bh();
 |       |         ^
 | 2 errors generated.
 | make[3]: *** [scripts/Makefile.build:207: lib/test_capability-analysis.o] Error 1
 | make[2]: *** [scripts/Makefile.build:465: lib] Error 2


... unfortunately even for shared locks, the compiler does not like
re-entrancy yet. It's not yet supported, and to fix that I'd have to go
and implement that in Clang first before coming back to this.

I see 2 options for now:

  a. Accepting the limitation that doing a rcu_read_lock() (and
     variants) while the RCU read lock is already held in the same function
     will result in a false positive warning (like above). Cases like that
     will need to disable the analysis for that piece of code.

  b. Make the compiler not warn about unbalanced rcu_read_lock/unlock(),
     but instead just help enforce a rcu_read_lock() was issued somewhere
     in the function before an RCU-guarded access.

Option (b) is obviously weaker than (a), but avoids the false positives
while accepting more false negatives.

For all the code that I have already tested this on I observed no false
positives, so I'd go with (a), but I'm also fine with the weaker
checking for now until the compiler gains re-entrancy support.

Preferences?

Thanks,
-- Marco

