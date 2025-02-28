Return-Path: <linux-kernel+bounces-538748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD4BA49C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6947A350C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD3274242;
	Fri, 28 Feb 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gy5kYtgD"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456127180E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754746; cv=none; b=etfXOvPPd1gikFMtTIsiOmM2XgtOpTierWdrDTW27W+2CJIl5nS6M4DZc0ecKiI4Hthdsqc5fumnmk0iAPbJ+cSL8Zq/Pa7HADp9OZS69zS09g0s4cYlF3KLCjQxY/P5aBBHEOdgZgkARMl8G6Ultbi0YaOUBk5x72+fRwSdABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754746; c=relaxed/simple;
	bh=HM2hHWGoPsxiRQOLmE/7B/InCIBuDhe0QVyv+3PxAMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KIxpQtuRAtZjGuuz4fyNnRVExu+45cBHfVJCaU6iWBAYsEaewi2GEAbYo217W5WiCTe3hfL8XNQEoWfPwvdL+380hoOLnYyDTuBdDF41k9u7Ai5KhJRjCqtff7SKaGjQxjgQbITSaS9h8c/A3tTQG5J1dLsnL3ZRX3r6I9IWZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gy5kYtgD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so4849204a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740754744; x=1741359544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9dyGsvh9T/ZSon/b0EZ7+hNIbWTXl5YSkkCNWhacUA=;
        b=gy5kYtgDyz702+44uk+3Ek2fFiKUH3J7RcB6PCNKjgNfgSHm48+aMgQh6rA2CMBzfZ
         RirtB3FskpnJmV2N6K00zu13q+ln/EbCY/5vA6sL2peoCWVqfiL6GaDPFkcd8CafYDh/
         1N0Bc7SmXMBCqicUFzEVeSuuBcsh5AYqscaKXIDP8it1Sz9AeAbozlxbcN6j43AeVBFj
         J7P6CzBYRz6xzU8kxd2LUwJARyjuXinZrWW2BhlJ+EbFiJiTtIL1v6cSZo/jTfBPGKKV
         IcBdBG3j9FiXQlSy5wqOUGgLIgK87UqIzBWT92OpNQg5/tLg4/BrpJrK0YXMlR/MVGca
         mw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754744; x=1741359544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9dyGsvh9T/ZSon/b0EZ7+hNIbWTXl5YSkkCNWhacUA=;
        b=ofFYquKrXC1VWbOr9eF6m5VMb7GC6h/9UgzHK5CjJ07DlOjXp9i1psIaEoxUzU5aKd
         GIBQOvrBokH69vFY1RiBDqKAY1KFdKsN0X6ecwnH5x1EQPvVbit21b4SQ5uho4nFrDsH
         yeGysDSIYPk1DP/D4Ygv0Lhntoth0i7OwB8yWUwmB0kRiHvLdtEO647QkoftNt3fl51c
         sFIMgVx1MM8iGU/D0mvoZG3RaxpmEFFSG0Y1Errbh7IXDuuN9v0HW0Z9kdoB3k0Ah9s0
         4tSOu/0ORptrkDKqrP1A0MJ4Q/nz2dFS0hxUyHOC0YK+K+lMIjfejm2Z3gHk6ELG2/0O
         OM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKH0ypWRrL2xLwCjcrOp8D0hVsykomkFdJKCtkoJkKTTlghO+XRFC2v5ZG0Ik+8aa6pWfgvb0lmrWs8zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGB0xBauuyCxuqE4Vaa235uQ0byyXBEPm7Qwd22nXKQnzkFLt
	c+j+6ozL1e5X8UzsYpy8+Jh5yZ4U2LrHagNcRu0YDk+XFudqpu1hoFiJE0pWoV46JWaBep6G165
	VFw==
X-Google-Smtp-Source: AGHT+IF2C9SjHgY5w3jl+VecgX3ASvzixsucJeI44sz6MgxAbRGH5Zck3g3VWWsuFnNL5P8Hm5Vb9Y9DaLY=
X-Received: from pfaz5.prod.google.com ([2002:aa7:91c5:0:b0:730:94db:d304])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1590:b0:1ee:ba5d:3d55
 with SMTP id adf61e73a8af0-1f2f4e01cf8mr6714343637.38.1740754744565; Fri, 28
 Feb 2025 06:59:04 -0800 (PST)
Date: Fri, 28 Feb 2025 06:59:03 -0800
In-Reply-To: <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com> <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
Message-ID: <Z8HPN5sAgInM4dN2@google.com>
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, David Hildenbrand wrote:
> On 28.02.25 06:17, Linus Torvalds wrote:
> > On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > > 
> > > I'd be fine with SKSM replacing KSM entirely. However, I don't
> > > think we should try to re-implement the existing KSM userspace ABIs
> > > over SKSM.
> > 
> > No, absolutely. The only point (for me) for your new synchronous one
> > would be if it replaced the kernel thread async scanning, which would
> > make the old user space interface basically pointless.
> > 
> > But I don't actually know who uses KSM right now. My reaction really
> > comes from a "it's not nice code in the kernel", not from any actual
> > knowledge of the users.
> > 
> > Maybe it works really well in some cloud VM environment, and we're
> > stuck with it forever.
> 
> Exactly that; and besides the VM use-case, lately people stated using it in
> the context of interpreters (IIRC inside Meta) quite successfully as well.

Does Red Hat (or any other KVM supporters) actually recommend using KSM for VMs
in cloud environments?

The security implications of scanning guest memory and having co-tenant VMs share
mappings (should) make it a complete non-starter for any scenario where VMs and/or
their workloads are owned by third parties.

I can imagine there might be first-party use cases, but I would expect many/most
of those to be able to explicitly share mappings, which would provide far, far
better power and performance characteristics.

