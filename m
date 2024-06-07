Return-Path: <linux-kernel+bounces-206632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7709900C24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E995D1C20EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155F1667EF;
	Fri,  7 Jun 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ljs848yR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7214B95F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786494; cv=none; b=eqQpWk6Tc4S/WetE4Uc2lqkKZOmafoQQFSf6zwa7bg0SeQOgtB8izg2MZgc4sGuCqAUhVFsvyWRTEgL/nLvtoScJ+81Yx94pyjlsUzLo31pd2TxJEkZUot8iOOgJh+fzZOMRW+ZKIKlkCibXwOaVJlKVjfkjBRjG8KmYNQ9UF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786494; c=relaxed/simple;
	bh=JJS12luKD/ZuoCZnJkUprUjKVdSbT0jCyS2ppWdkZ+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfQncdITtnDoRv0xgE2IFmrQ5zvvGdCla8LFDdxEkl/R+eKRGl/SG+hcgdB8Kfqt395/8wEl8MHxoE1gU1QiV10bz4+VFzR98ycRktrnSSyH+mLfVvz3KlgrNDEzUPkMc8zbtD0jAfXjkOQWPBnkAWyuEkrDh2Azc3hCE9PFwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ljs848yR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso3189316a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717786490; x=1718391290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qw74WwP8cBPbl8qHVKmrRfW00xLiei7V0eY3BOOvLwA=;
        b=Ljs848yRSRcGqDM7U3aLKBW65OUiVlUG5b+um6ZAQeTO3YffTxncDo4TZVmiH4EYMj
         SvY42fkrJfwcB/kTsd5BWawoa/DckqY8W0yCGYkcZB9tOV5q+MPZ68Bx+RNMlMAn0FSL
         Fvs0gCszQ8ivT0TdswbWwM2aU1TKsGCCudPLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717786490; x=1718391290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qw74WwP8cBPbl8qHVKmrRfW00xLiei7V0eY3BOOvLwA=;
        b=eS3g4mMfO0GCUX4FxhmIndnacyzIBJ/rsMsl37itW8HrKw41eiCoUPHIY0GPS/DSD4
         mEF/BjsQUCqeGbxEthWUoJBasqlmiYszfw/a555XlMBZLks6KWtR9YFws++Rlt0uvmVz
         DYr6t9FBm6LuEsgwJrh/LJ9RSnjsyQpuCuY2c1cVV7BHb6u4M6QlYBn2bLOyiE132slt
         bbCf4XEKpU3I20COE7xwv5kxsv/uvan9pDqFWkE0PozpNBmqAbr7NzEwzaMDmR4pMSaN
         uNmdn0xeraUbv/Zz6ymtYgcB/tiJkPiEdd4MwQQeJvRWkEqRyb4Ho2OiArrQz/Fr0yKq
         XuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbmsm+CGI4qw3rqWUNiD7N0B2SYBbWV4iSBD5bnqYJFxYzPCidI09p2fFIghcMAe+CHnsZHqvNgwLLVdzvEpUKJ1NmtDe+Qbt8t/Re
X-Gm-Message-State: AOJu0YytOCXfzn64cn3kNFUNmw0rIr9zXJDbktn3OVXt2VFUbR3/jZfj
	5EWRzaxYznXv/VvF4kkyft4Ii+z6CkhK28WWpToIb5t6fOBA/hU1m29lm+4M/0VcRokH/1fmILa
	pCM0=
X-Google-Smtp-Source: AGHT+IHodahplBEWhD30lk2Hf5tVCzXTzD/lohg4AjYalOV5Eb+ouc2HxpJBwuXSvzZ1uht7sdjKIA==
X-Received: by 2002:a50:99c9:0:b0:578:6901:7454 with SMTP id 4fb4d7f45d1cf-57c5089a10amr1820534a12.15.1717786489865;
        Fri, 07 Jun 2024 11:54:49 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae20238asm3165466a12.73.2024.06.07.11.54.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 11:54:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68c2915d99so288479366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:54:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCIJTpA7gKAPFuXImCmJA0KINQ2JYEF7bbAAu+6Zk2UU29ZLr00IwVFyrtW5xeGZz9xnmioKpZ7olpjgCGv6P+l3jEL5GkTisVjGGW
X-Received: by 2002:a17:906:25cb:b0:a6e:fdc8:ae3a with SMTP id
 a640c23a62f3a-a6efdc8b0a6mr2036666b.6.1717786488772; Fri, 07 Jun 2024
 11:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
 <8d43678b-6e94-49b6-9cdd-244c0e7b3898@rasmusvillemoes.dk>
In-Reply-To: <8d43678b-6e94-49b6-9cdd-244c0e7b3898@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jun 2024 11:54:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjahXA9r6AxWV_UEXF6LziecMyqJyiPn5PqtEwYHBKkvQ@mail.gmail.com>
Message-ID: <CAHk-=wjahXA9r6AxWV_UEXF6LziecMyqJyiPn5PqtEwYHBKkvQ@mail.gmail.com>
Subject: Re: objtool query: section start/end symbols?
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jun 2024 at 02:39, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> I'm probably missing something, but isn't this exactly what you get for
> free if you avoid using dots and other non-identifier symbols in the
> section names, i.e. make it "__static_const__" #sym or whatnot:

LOL. You're not missing anything - I am. I clearly missed this linker
rule entirely when I was looking for some explicit way to set these
start/end symbols, because that rule - which is almost exactly what I
wanted - is implicit.

That said, I say "almost exactly", because I can't get it to work.

Why? You need to match the output section name with the input section,
and since the whole point was that the input section was a *pattern*,
I can't do that.

I can hardcode the section names, which fixes it, but that is what I
wanted to avoid (once I hardcode the section names I could have just
added the start/end symbols by hand).

That said, clearly there's a way to just do it, since your
test-program - using the built-in linker script can do it.

I do worry that I also need that "AT()" logic to subtract the LOAD_OFFSET.

I really don't know linker scripts very well. I spent more time than I
want to admit to just because of missing whitespace.

                Linus

