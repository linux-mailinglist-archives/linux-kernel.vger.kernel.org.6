Return-Path: <linux-kernel+bounces-549584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BDDA5541F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0DC189C9A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F22698BD;
	Thu,  6 Mar 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KDjGor+r"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B89272931
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284280; cv=none; b=GCvxBYVVWRh+wkkSN57/2ePnJkEphWhWWPEZsoBGQ4j66gPVwpe09VjxXY5nVdpHKiWQNvjF5tBNMWw2UJmxIgr2D3KtOO1IefH4EcL+qyTp8gDb2YNc+mCBa67ldPj1tdJCHyWt///3Yy4FtyZcJ7vjQCx2WeTQkBJ6/hxCSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284280; c=relaxed/simple;
	bh=y5+pGGebbUWRK5H1usbDrXzuwMWW4SWe1mdJ6KkEhaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8I+dAkiK6qjcm+oi4h/s2QS6Pq/NyoPTVZCTJDZk3lGSLy3jXAl4MfeWpswes2/ABM6zBKeK7Vu1rLbz68X+xsyS11vYJADyFKqnPAmEOFOtkveh4Ingk4qhTWfguy+mVYz85yPq8vLo53jsjW53Dmsr5LEHy14Xa8U2QgSWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KDjGor+r; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2400d1c01so128722266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741284276; x=1741889076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vd2MF6jMwWmVMWwx4ZMQ8WJbC3PZ2CeCHabSL+mH+8U=;
        b=KDjGor+rO4KqsgRj1yw8/cCUEF3q5CezEmsFGAXeFd7G/GZvy4lpOyy4Yr4rx4DM2C
         uosK1PQlArnGN8ydAKmSuPfIHDlPKCeCbadff9W6960aff3dTGi0I/weQT7k5kcP8ZXu
         FnYoUKNxo4+aF+Nb2l0jx6L8GucHyEM0z0RkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284276; x=1741889076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd2MF6jMwWmVMWwx4ZMQ8WJbC3PZ2CeCHabSL+mH+8U=;
        b=lNY7cPVdKbTN7AXr6AeYadznOBNV6ReQC5HRxOs+X8K1vzOUcijXM/C4G5mg91KHPr
         nU65roL7X4FW2KhAkg2zeUShWDxTjjERHsbD5nsbXfDMdeiNvUJMK6z06cPBivWX/5jS
         AVEZvHX7mylJRzkJXTYVF2ZwrAkNaRjix4XiFXZbULDXE5gTJQvC6A7VhbgISy5RWfV4
         YwhtpbkLLJPVdZs/0ELi4EfLqCwQEhhdduppyS3uS3+SFC+qCUOF0I2ZQT6RxbI+uU5v
         KQJm+gx6vN7gTOQy/3ZdwHnlzSEZ0ZKfes32qfMBzxj27gbzht6NpQ5oyB+ee60cRQdD
         13cA==
X-Forwarded-Encrypted: i=1; AJvYcCV1oZO7sPRVujCdmd2nlBGT926wXbi4fewvusuIBk/Zp4A48q7HncnuEa6ohnJIVzPwnlk+j/ocZUn8/2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1PB60V8AZqd9V/fLBXIX4hPO0Xy7L939uwa9pNLy1Q7SIuIg
	HMBnjpz4HpIDb3eOVyX6Nf7lk9eperSo3piTd0epussYHKb3X39X2LIoUwa0FfPnalCjokTtxAy
	IsRE=
X-Gm-Gg: ASbGnct+eQKSJzxjyGElJzrTU82VqPwfJeWMHl3bYxoCNeevxkRUVBB2ptkP1rIakgH
	OuwO4lSmi61Ecj5C+CJ4l9w6+L7SlchhNEjOi1OxtL+RdD5d6107fnGKaC7xfDf4yAwvySBZ0ki
	VFNLcT493eCVodE3lxwAVp2szcHdSBeAHo55ZybZ7tIfKbWnwUX5TqMK/BsGf9sUFdq6MtvnN4n
	zPDmhYkO75/dl0jATJ8vO5B/8p4RccdaSr65MXCgMhN3AgFzLZC8EuGwFz7PVsB/CnbtG9Rj9w8
	ieY6+dJg94KpjyYdvupXrgOMHeDFCmac4uB/Yudm04cG3Ft58McnOUIx2UQ4w45zHrMeo1HRQpj
	yoSnn52FqqUx+GNzi/vI=
X-Google-Smtp-Source: AGHT+IEZ0X0Hg5tMjEJ/DWhHzajPR4+V+cOd9RyzmJwLzaL5vDCzg4pT5BhMVvPQbOevkW1ycO8o/A==
X-Received: by 2002:a17:906:c39b:b0:ac2:3a1:5a81 with SMTP id a640c23a62f3a-ac24ebe6bc7mr44919666b.26.1741284276010;
        Thu, 06 Mar 2025 10:04:36 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239888261sm129551966b.127.2025.03.06.10.04.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:04:35 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so4012178a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:04:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAj+gslrZeAH9I3i8wSrqxbpRBYcDYw6qB09g4z9y5BDhJtxvHWzthRgfaMkhwEJM/XAgxTd9H2VH2PC8=@vger.kernel.org
X-Received: by 2002:a17:907:61a2:b0:ac1:e08c:6ac8 with SMTP id
 a640c23a62f3a-ac24e8a57dcmr59352966b.2.1741284274683; Thu, 06 Mar 2025
 10:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com> <20250306113924.20004-4-kprateek.nayak@amd.com>
 <20250306123245.GE19868@redhat.com> <20250306124120.GF19868@redhat.com> <39574d99-51a2-4314-989e-6331ca7c0d75@amd.com>
In-Reply-To: <39574d99-51a2-4314-989e-6331ca7c0d75@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Mar 2025 08:04:18 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg10syD6-3BwuQCCKxua3_bdK1gfjiw_DtCqNqe8zXFaA@mail.gmail.com>
X-Gm-Features: AQ5f1JoHVwZMPlgVDTPqJEc90ra_MHfbaLp-G-nJPvd2lDeghC0Pw92_liw9JP4
Message-ID: <CAHk-=wg10syD6-3BwuQCCKxua3_bdK1gfjiw_DtCqNqe8zXFaA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <ravi@prevas.dk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 05:33, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >>
> >> I dunno... but if we do this, perhaps we should
> >> s/unsigned int/pipe_index_t instead?
> >>
> >> At least this would be more grep friendly.
>
> Ack. I'll leave the typedef untouched and convert these to use
> pipe_index_t. This was an experiment so see if anything breaks with u16
> conversion just to get more testing on that scenario. As Rasmus
> mentioned, leaving the head and tail as u32 on 64bit will lead to
> better code generation.

Yes, I was going to say the same - please don't change to 'unsigned short'.

Judicious use of 'pipe_index_t' may be a good idea, but as I fixed
some issues Rasmus found, I was also looking at the generated code,
and on at least x86 where 16-bit generates extra instructions and
prefixes, it seems marginally better to treat the values as 32-bit,
and then only do the compares in 16 bits.

That only causes a few "movzwl" instructions (at load time), and then
the occasional "cmpw" (empty check) and "movw" (store) etc.

But I only did a very quick "let's look at a few cases of x86-64 also
using a 16-bit pipe_index_t".

So for testing purposes your patch looks fine, but not as something to apply.

If anything, I think we should actively try to remove as many direct
accesses to these pipe fields as humanly possible. As Oleg said, a lot
of them should just be cleaned up to use the helpers we already have.

Rasmus found a few cases of that already, like that FIONREAD case
where it was just doing a lot of open-coding of things that shouldn't
be open-coded.

I've fixed the two cases he pointed at up as obvious bugs, but it
would be good to see where else issues like this might lurk.

                 Linus

