Return-Path: <linux-kernel+bounces-272867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3C94620A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068591C21335
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8A13634F;
	Fri,  2 Aug 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJp2YPUS"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735516BE0E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617451; cv=none; b=UbXjExOMD4CsDBJ6d4zEGMqcoZprPmN5yZ+IePtKINWhZVHZDUxLfUreTXc0MZQym2HcqmrH2uKaXVO/8x9Nordb1dHCYNc17nFF0ZXA7a7rD3UsJPNocMrbASLHLbqH6az4igU8PE060cCv93l3dE1vjx5owK8ujZgtklNovy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617451; c=relaxed/simple;
	bh=QBxJ2rF+4MnYP5mo4rSjypaHSP50HnOtHw/UQzKOIAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwHgYJ+ok6Efr1hmu+KYFPA+uZUR+a7cvcslFpR/DTI9RqhrAuff048ro/QpdlzG6iqlVBBlAHbLgy3JJCkhkYlMg+fZ7dfO51BbklLQYEuunbhczVJvzOO7X3IaYfZ9M7fXauBFLvjj1iN5T54HcrLLEWSCqgq83SHHhO1MBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VJp2YPUS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so125526601fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722617447; x=1723222247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy7uDpKDjfgFbBNLdCjGfcS9co6ibrIuccREcNoo5pM=;
        b=VJp2YPUSc0leCEYt03crLQ0yXPD2t5CZ4uHtedNimKbWjxrc9ADVJInrTmu7lSN3je
         c7ZWs2nbBtFYdZSb3z2t3XFPfbpIzcpYeVrJXL9h3G2BzVube8eScp7Wq183P5mTIaCN
         JXzWcMj1f5PKJGVRZevn48fvc2Z2enm64lL30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722617447; x=1723222247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy7uDpKDjfgFbBNLdCjGfcS9co6ibrIuccREcNoo5pM=;
        b=DjTmky2bTNdNgMsuG1FSs/N6toaN4sZJQqSarikSkdxrC3h0sP1nOWNPFIgvIwH6Uk
         s1hS97hxO6wLfE5On08U09DYEYDEnRv/ed2YuTudHgC56JYZWKuewE6UalMPyYylE+/2
         G1dXw+t98MnZjQOgohSVUFm0rYe04e47fqnoMM1F92sUCVbGWGgl+WJap484SxaL8mAP
         g8b7N4khUHLqZv+5dR0BFCFkKNviBOTGImkXVzlI0glx4+1TQLWFlWOdFmP8t74FbmDt
         3TKGeXpERPp11GevlBbKyaKfGCQHonnG56Rl2LR6xVsmh47P2Zq/QojYY3SY/pCvRYHj
         pjBA==
X-Gm-Message-State: AOJu0YwjwVmP3hk0/4xpZqQpZ0HSprhczE+W4xFliabc70imaAZKWrjM
	enRHVAye9iCd9VWEnMTmYAw61sCk3dgCwQOoAC6ecpXjvtgYVh6Is+UR5rfOfAqOpnYYBJrJ7LY
	8/5zueQ==
X-Google-Smtp-Source: AGHT+IEnhC216oh5e+DZ1UIf/llhPNGn1lq0bQktmYzyvnXjaebbOPfiqWEeuede1Hjrj6421nGC+A==
X-Received: by 2002:a2e:9dc2:0:b0:2ef:2ba5:d214 with SMTP id 38308e7fff4ca-2f15aa88c3dmr36056651fa.4.1722617447085;
        Fri, 02 Aug 2024 09:50:47 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d45423sm117320866b.134.2024.08.02.09.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 09:50:46 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so74321655e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:50:45 -0700 (PDT)
X-Received: by 2002:a5d:4590:0:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-36bbc0e09f9mr3243960f8f.12.1722617445575; Fri, 02 Aug 2024
 09:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802114518.GA20924@redhat.com>
In-Reply-To: <20240802114518.GA20924@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Aug 2024 09:50:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
Message-ID: <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
Subject: Re: build failure caused by RUNTIME_CONST()
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Aug 2024 at 04:45, Oleg Nesterov <oleg@redhat.com> wrote:
>
> make bzImage results in
>
>         undefined reference to `__start_runtime_shift_d_hash_shift'
>         undefined reference to `__stop_runtime_shift_d_hash_shift'
>         undefined reference to `__start_runtime_ptr_dentry_hashtable'
>         undefined reference to `__stop_runtime_ptr_dentry_hashtable'

Grr.

> The patch below seems to fix the problem, but I didn't find any report on=
 lkml,
> so perhaps I am the only one which hits this problem? And perhaps this is=
 because
> my gcc 5.3.1 is quite old?

It's not your gcc. It must be your linker that is old and decrepit.

> OTOH, I know nothing about lds magic, so I fail to understand where these
> __start/stop_runtime_xxx can come from without something like the change =
below...

So it comes from this:

    https://sourceware.org/binutils/docs/ld/Input-Section-Example.html

and in there you will find

   "If an output section=E2=80=99s name is the same as the input section=E2=
=80=99s name
    and is representable as a C identifier, then the linker will
    automatically see PROVIDE two symbols: __start_SECNAME and
    __stop_SECNAME, where SECNAME is the name of the section. These
    indicate the start address and end address of the output section
    respectively"

but apparently your linker doesn't do that.

I guess we'll have to go with doing this manually as in your patch,
but can you say what your linker version is so that I can curse it in
private and document it in public?

And yes, I think you must be one of the very few users of it, because
I too am not finding any other reports on lore (or with a wider google
search),

                  Linus

