Return-Path: <linux-kernel+bounces-526541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33199A40002
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE7D19E121B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5142512FB;
	Fri, 21 Feb 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rlw3cuGI"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A41FE47A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167244; cv=none; b=pcpHehowHyBBgr48eoux+IA8MCUI98hKT7T+hDLNumT5tAXimasG/0fVsBTs21rXmlqJVkzh1RLExmsykOTfE4XpK+akAUqQDYUp5u5OPOnOE26F0DOuZKTnOhdZXwNMYuoINukwMNj2ue1ATvU0P+MR5cb88ZHwRn95dLrgDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167244; c=relaxed/simple;
	bh=ncoDsRKjh28vVH6GzAvugCMHO3v1MHxTwR6FKJOs+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBrQ4CYRvshivktVwMqNvS0wlejoWaTwFjGfgIxf6o9nOs2n08CC00S098fI8p8dZjGcR0zwo8BZB5h+5RxNPiEs1mX2PRrQru6IBb6Vxhb8RnSRD0KkrzRh7oExhVm9NKh3muwwOV0mk1xotMn336MFE054cA1hL00TQJSowK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rlw3cuGI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso406533a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740167242; x=1740772042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ncoDsRKjh28vVH6GzAvugCMHO3v1MHxTwR6FKJOs+vU=;
        b=Rlw3cuGIAxcg3WfnonzHELaqFki5MHtrG88b+PJaqXoftFWAZOw1iwZ7B1dfoO28lE
         cgOxQhBbPToKTYZs3SAS2fpr/CNVn2uKrY1+gYr7U9B87SQeqLulqBAGHMFnScG529Io
         J1afxgCpTtyCRUNAGoytzPI8L+xOVLjOZuTFUUMBeeZ0GWjqlEGww6XN2usVQ/obfe7s
         aF7KhEyDbzze8qpQOk1Pnh3cmgcvUS6vvk2GQW9xfM9dhI3T7rxZoCyoAAdjyddnwUBB
         WvzZVn/qykY8G9mwQKVo1B0YjmbP2Q1hQb4b/EccXjSfF+7eF3Jib9Hl4/RFrELxYXAd
         htZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167242; x=1740772042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncoDsRKjh28vVH6GzAvugCMHO3v1MHxTwR6FKJOs+vU=;
        b=JoD3XQeNsSTYHeMm72jmgMMAP6Z02buVSh5KHnvyoiXUF0CrvozR8iOYSK9RAymZ1n
         eHImp8T7Zj93i0RLVAIpGGkO1oPF8hmR5tPp7CsZ+ZV+mkP33OeViwENmnejWW6l/TRj
         xGfrLZTt50V5p0sm+IlzMRe/SXKT9iMhw3Bh3ehup97qH2JDwJjVlWQvmmT3b4Unq938
         MHeXCWll8dWTFH84uz0g4N7HePS2lrskAGxpSfyKS85Vuz+5YbfnwXIlNSALlkCY9OTJ
         75eIxjZn+lKmVvgwo6SZGTSekcRzU8fRDVcr3hHtOEOU3SfGHQbLX7bZVFSFjyjqbdkA
         nmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPdzJhwAmEYI6jomXoN/Uh+/skrkQjLURiE29fYN492nGGoNsUNd+MKkz7q6QBzjmGcMPdX0GZvJOpjHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5DCoLODqfq6qKX2+yy0pXjamK5nGyjdXCvo90EMNPQ5hTY9y
	tlKcd78Ep04WUT+lJmnL4CCSeFpQ4lPyfuDyC+HyW36+8d1dzXKer6XDN+0YTD0WgCvdgmtrcjc
	+pqbaraP/lbXHwlmfvPmpguJwUa8sIZRopQnm
X-Gm-Gg: ASbGncsBR/iA+HXyXRaKpyyOm754U101DkbfnphW//Yu3MQnXFb5Ged6LdSVUGh23tp
	EwzjZp8mCKcOgPEKG4kayIdsvYuywAcVrEyjQMixsPWPmoRNyL/fde3Y24D0SXEpyji4jROCQY2
	UzafdRxkQt0r4fzm+FFV9o5vj+tZL72vjlRMTouGo=
X-Google-Smtp-Source: AGHT+IGtec9D57fNEpwTOF5VC56kG+DMvBkePfQGlMMOOM8lBQqp82lJKRrsNscMiVitOb/6ZYzBRGWC+K08kh5F0Y8=
X-Received: by 2002:a17:90b:2252:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-2fce7b26274mr7182179a91.30.1740167242446; Fri, 21 Feb 2025
 11:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com> <20250206181711.1902989-16-elver@google.com>
 <a1483cb1-13a5-4d6e-87b0-fda5f66b0817@paulmck-laptop> <CANpmjNOPiZ=h69V207AfcvWOB=Q+6QWzBKoKk1qTPVdfKsDQDw@mail.gmail.com>
 <3f255ebb-80ca-4073-9d15-fa814d0d7528@paulmck-laptop> <CANpmjNNHTg+uLOe-LaT-5OFP+bHaNxnKUskXqVricTbAppm-Dw@mail.gmail.com>
 <772d8ec7-e743-4ea8-8d62-6acd80bdbc20@paulmck-laptop> <Z7izasDAOC_Vtaeh@elver.google.com>
 <aa50d616-fdbb-4c68-86ff-82bb57aaa26a@paulmck-laptop> <20250221185220.GA7373@noisy.programming.kicks-ass.net>
In-Reply-To: <20250221185220.GA7373@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Fri, 21 Feb 2025 20:46:45 +0100
X-Gm-Features: AWEUYZkA99crBxIegh1gRRcMrAoKxxzyxwRGmWJRS2whchm4-Eofmj8EM7dMgko
Message-ID: <CANpmjNOreC6EqOntBEOAVZJ5QuSnftoa0bc7mopeMt76Bzs1Ag@mail.gmail.com>
Subject: Re: [PATCH RFC 15/24] rcu: Support Clang's capability analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 19:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 21, 2025 at 10:08:06AM -0800, Paul E. McKenney wrote:
>
> > > ... unfortunately even for shared locks, the compiler does not like
> > > re-entrancy yet. It's not yet supported, and to fix that I'd have to go
> > > and implement that in Clang first before coming back to this.
> >
> > This would be needed for some types of reader-writer locks, and also for
> > reference counting, so here is hoping that such support is forthcoming
> > sooner rather than later.
>
> Right, so I read the clang documentation for this feature the other day,
> and my take away was that this was all really primitive and lots of work
> will need to go into making this more capable before we can cover much
> of the more interesting things we do in the kernel.
>
> Notably the whole guarded_by member annotations, which are very cool in
> concept, are very primitive in practise and will need much extensions.

I have one extension in flight:
https://github.com/llvm/llvm-project/pull/127396 - it'll improve
coverage for pointer passing of guarded_by members.

Anything else you see as urgent? Re-entrant locks support a deal breaker?

But yes, a lot of complex locking patterns will not easily be
expressible right away.

> To that effect, and because this is basically a static analysis pass
> with no codegen implications, I would suggest that we keep the whole
> feature limited to the very latest clang version for now and don't
> bother supporting older versions at all.

Along those lines, in an upcoming v2, I'm planning to bump it up to
Clang 20+ because that version introduced a reasonable way to ignore
warnings in not-yet-annotated headers:
https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/commit/?h=cap-analysis/dev&id=2432a39eae8197f5058c578430bd1906c18480c3

