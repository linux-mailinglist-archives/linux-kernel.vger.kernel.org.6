Return-Path: <linux-kernel+bounces-515470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A86A3652F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230BE172934
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA02268C51;
	Fri, 14 Feb 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSGDeBXd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DDD1EA91;
	Fri, 14 Feb 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556300; cv=none; b=EEIOjrViORvyJ6VHUHsybzVDFHlLEpOfMneNvccGtK3Y4r3RtfI6VsEqgrolIhuZ5jNSw33b9kcDLLt9zCBj3qizXSu2K3rv39ptOBAM3yRCGf31qaWyX+FbU9aOXs7t5McoIXvm6nJjxm9RXvlhZE8Ntp5DJZk6gIwcdE1tkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556300; c=relaxed/simple;
	bh=xXr1JK1gjavjAE/vEHKIs9kqfKKNroxNQsopDcHfiKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FDIW0hfOmFBTJlDaoi/EEvgIWEoEr/kC3lbu9M7qVq2J9E8Bm1nqx6wkMWiWQERMRHuSajAw0iQFgW2KxLdieRCQ1Cn4QqKcOv4uY0UIBVp8ijOfDoZ37Kq3VPhelYkoT0iGimCJb4fNktqqXGUeNtkVNC+EbyTI3UQN6Qe81gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSGDeBXd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f6fb68502so5906965ad.3;
        Fri, 14 Feb 2025 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739556298; x=1740161098; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNlGKiDQgk/4V9I6WFUe1ZggS7rx0zWohj8BV7AO3Do=;
        b=BSGDeBXdVMaI5KgG6lHkCF8/imx3EMoC99PK6BWF8m5YRf8RWIvdhi56+zVplU9t1A
         lA4zE8qpaTfncmviNdFgCIXmWZIDcFbsxrFSDTQFVQCKhcn9a73ehp3g4BKmfFjpp3H9
         km/WhqMBMhdsScWxZJmEuaM6b8XL9XPBKC/yShA0qmlSFbnPqV345C6Ve5lp1Kw8rZVB
         f1txQwF+b1yQ7tXIqXvnGzRsuIJKHDYKxL0kxQ88vGfEDZ0LsQSPVb4MhoKirjtn153g
         LPHTangyHg1OQOPhtHnZ5youW9/b0/tRWw6rD3+iU/YN9DSRXPd0iOHPxFnHeWv9gpPq
         5izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739556298; x=1740161098;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNlGKiDQgk/4V9I6WFUe1ZggS7rx0zWohj8BV7AO3Do=;
        b=b68kHwaLgxcg0KurTTiVmzK5kNGgqTPRMnqtkbUPCV8Drm3mlooZrBjh65w+w551MA
         b+age//uGk7VEmDn5Z9wry5ZYMhZJoIAXyOAJLePkN5KqbmsscYZ2aQzlevqWmwesb5O
         0zmH4NRDtoEmD8CckE7l8yRsOm93TwfHdeGm9DQkzXen6NGYFEdZNqUhbW2EQyE40Djm
         v6JJJAc6zulsL9UHuhfKQNjW5cRR6KadSZ8kmKgnmCCuvOK5fenuIHKZm37k/62QZcgz
         BDGIbR8q8pY7K+JL967sKGn/qCioV2azzwF5V+unFI0TPoXuV+5QkKkHc9gOFDOz78UP
         iR1g==
X-Forwarded-Encrypted: i=1; AJvYcCW/LVWuVZUjR5OXKwLAJuW/2GfzGltCfl5Z2fu9BL09Hr/RW+bQmdUl4FjOkej0dOvB7RVPoXgm0I6XMRchVrc=@vger.kernel.org, AJvYcCXQP9gQlDzM9LAT9imszcKbFHK9SPQXwmtyNj1mG91nqxAuQOLmlQmvqid5f2wjkaMg2hBujuiMCP2pQV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhP4pBvwtqrOEApDULHSg7vTzYkuZav3+157boUNyj9y+obUx
	E4B49a0alUNqbNyciUrXVvnPuGnKKk/FqnoZ872uig3fTEELy9wEBNAhq9ecMAWm+dIZA/GUYm8
	DQfDlTQtuBpeDDAoFqYbT5WWGDow=
X-Gm-Gg: ASbGnct+LWZsdu3JuhoIJ/g14pP/QbxK14azJgmxLsVPm8uQjnyvghUmaQic9X2kQJR
	TvLT3DhOfkuLuGLi82RLa5UiC91JNpf7gXj0yfHYhm4UByIGrffJ3KKoOpRKQG8ixtGOTjDo4
X-Google-Smtp-Source: AGHT+IGBXkuYnKPoUWEFkmV4TUXnY1Ty6w+tV3iFACV30rX/LII7P1gEfZMjxeabEwWQK0GecQj/2tN+0lbZxNLA7k8=
X-Received: by 2002:a17:903:2312:b0:21f:b7f5:ee58 with SMTP id
 d9443c01a7336-22103f1a081mr1114655ad.4.1739556298116; Fri, 14 Feb 2025
 10:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local> <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local> <b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
 <CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
 <30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local> <2iypqaa3orklplwec4k5n4nuuov3gajtkiv2nt2ce2s2b4e7gd@7y6cmwrwr5te>
In-Reply-To: <2iypqaa3orklplwec4k5n4nuuov3gajtkiv2nt2ce2s2b4e7gd@7y6cmwrwr5te>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 19:04:46 +0100
X-Gm-Features: AWEUYZlksNjUlfuWQ3E5FqVG20TGeackl_sUVz7lkxRiPl7yZlnjyQZLRmVc3RY
Message-ID: <CANiq72nBDEOSuSNTGKGA5xQrs3ZFH87ii0OAdhJq3rqtOv=dfQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> This will become more important once we have more than just wrappers,
> but I think we should talk about what this will need to look like before
> it actually happens.  ie: unstable rust branch tracking unstable c
> branch with build emails, etc?  Early days yet, though.

Like an equivalent to the `mm-unstable` one? Would patches only be
promoted if they pass the Rust build etc.?

(Sorry, I don't mind to interfere -- just trying to understand how it
would work, since I may be able to use as an example later on for
other subsystems etc.)

> I am unclear how the branching/merging happens.  When do we need to
> start (at lest) building the rust side?  We've been doing a lot of work
> in the modularization/interface level to try and integrate more isolated
> testing, as well as the locking changes.
>
> Do you have build bots that will tell us when things are broken?

If you mean on the Rust side, I just wrote some context on another thread:

    https://lore.kernel.org/rust-for-linux/CANiq72=3DYy8e=3DpGA+bUHPZhn+D66=
TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com/

The important bit is:

    I regularly test different combinations (branches, configs, compiler
    versions, and so on) to catch mainly toolchain issues and so on, and
    keep things as clean as I can. Others use regularly the Rust support
    for their different use cases, thus more testing happens on different
    environments. In other words, things generally work just fine.

    However, our testing is not meant to catch every issue everywhere.
    Like for anything else in the kernel, whoever maintains a branch with
    a particular Rust feature needs to set up proper testing for that
    particular feature and relevant configs.

I hope that clarifies.

Moreover, there are some bots available that support Rust, e.g.
Intel's 0-day bot. I am happy to put you in contact with them to see
what they can do for your branches.

Cheers,
Miguel

