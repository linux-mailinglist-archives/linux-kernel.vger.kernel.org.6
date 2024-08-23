Return-Path: <linux-kernel+bounces-298244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1E95C45B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E469E1C2158C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985D481A7;
	Fri, 23 Aug 2024 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBde79ix"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C768488;
	Fri, 23 Aug 2024 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724388476; cv=none; b=FyPYoRJSJXtrgvQD6n4AYHiMFjP5G7n50e5ao6D/tq6/5wHvqCtaONBGXKXcWFfv4iTAt54bXhzk8AG9grKjLFCMUblWN31CKnx0cgZeXGf2biErL/KUdwMW8h9c9WqGlVKypVlROsPwvRpiIcBj0vEfW2hkdU1WSrBwpscTP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724388476; c=relaxed/simple;
	bh=akOHYPcqAlPNdJi8z2ZDHB+o9im3fBWDzL3WOFAk6b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyYY3kN3LjkrnZq36n2gAXGed0UTD7ZT8P+6uDEFWa4JycnNHfHHBPcWn9w0D/vyx3JsTRbH5VXseeVgrBvILK2+fnR30ITEK0HgoZP6Jbx8RTO40oTwetNRNS/a4GE43RaqrjLwxNkQqi5yVZb5DY2Au8B93tg6m6NZ/SsMNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBde79ix; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-268d0979e90so235213fac.3;
        Thu, 22 Aug 2024 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724388473; x=1724993273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk2OgddYqVT69t5+ZZWTdnG00mbBe5e/zNQgU/sdUF4=;
        b=nBde79ixgDiXoNxfVwPmGWbdkOaCooCNJHMtXgadXRzz+ZVFFWx7yQm9a7F3eVScMm
         yQ/OQzz3eSzgQo+MHIp00IXZXKl9tAwUbTZFgWZFFOB6KuHOsh/DPxgzoDqQ/wgxEzxq
         3Cccy2epVMXNqN1V1FHXsP7tLmWgL9Svj3FZvWzfk4wfkqUBp4lI9jCdmJhFD+TikpVX
         JE62PkE0nSTI1HdzvckzikZAEBZqz2/NsG+HSiDJ8AJhP/fpw6M/QqTiWTiTLNy12fvD
         VvIU+1MaEVtDwDwSzqPXpAqIARtm5Dbw6a8f3+4hYwfZfaiFiLLgeBNaY6wJwkNZkbwu
         qasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724388473; x=1724993273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk2OgddYqVT69t5+ZZWTdnG00mbBe5e/zNQgU/sdUF4=;
        b=pvnO/peOwZmQo0ScUkgkhCq6VwpZlfPs2SLgLeKm31smj9LXHLK0zWgCgclpDlV5qU
         nGxPOLScTqpAtSF/ZUCzLuQZ+1HERoj8avMt6BGXwTibobVckHVdULVsa7W5D2db0cRe
         MNZjFDw/UiIWa26qg4uGNBk9r5uDGshZrDXMlBJKw/FE2CA0O+uDq5OEeZbqimti8U3t
         KM0UVAW3GfLKnvI/PRvEDLXcRFNu+8NyAb8IS+y3zkvUEVd5PYbK+fOjpe/WeMIcBng7
         fgRQKktXraPFHXFGu2bRC/5xb/3uN+r1ikj0vb8xOXHp+eAFIzJjdstWB2aqYcj5YFww
         qhZw==
X-Forwarded-Encrypted: i=1; AJvYcCUMzODnxsghuVWj53S3vQAmuCOYw42EIRmYha58JBHfaebYcKCHJ3T8AoCE6G77h6Ga9aCcPQcQSgRG3Q91vkI=@vger.kernel.org, AJvYcCWQlT1Sc632pWl1J+szFSFAQdc6ptHVbfz9xBjx5jgEt0C5PPpG2OZpbsYfaY5KMdDlqkWPHHKvX/CTtMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMqyTHAIztPit6Yx9hpIOs5QpWMYocVcabXLgkDsANwCywfxd
	tOWd6V/xe1gb6I44oP37ljAxHh1RmEIP4HMOni/NyDBnU3QBnqO1OuvKRhUzdXdhTcww4dgif7f
	nYjm5DlEdMdI+dKyw3kc+gjlk4MY=
X-Google-Smtp-Source: AGHT+IGY7DwKXhvQ5zpGHR0/UzXbuNvDsv/962OGJWFddCuiCEgrDK8ClArbJk2wzkHnise655QEIhEQiYTQLyedR04=
X-Received: by 2002:a05:6358:910e:b0:1b1:a6bd:7d1b with SMTP id
 e5c5f4694b2df-1b5c1e81bfamr85237255d.0.1724388473318; Thu, 22 Aug 2024
 21:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Aug 2024 06:47:40 +0200
Message-ID: <CANiq72=9dWLGjU6cTUWaqNPBXgs9CV1Lo_NDpLr3c-fOcfMgaA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] Add Rust linked list for reference counted values
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:06=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This patchset contains a Rust implementation of a doubly-linked list for
> use with reference counted values. Linked lists are famously hard to
> implement in Rust [1] given the cyclic nature of the pointers, and
> indeed, this implementation uses unsafe to get around that.
>
> Linked lists aren't great for cache locality reasons, but it can be hard
> to avoid them for cases where you need data structures that don't
> allocate. Most linked lists in Binder are for collections where order
> matters (usually stacks or queues). There are also a few lists that are
> just collections, but linked lists are only used for this purpose in
> cases where the linked list is cold and performance isn't that
> important. The linked list is chosen over Vec in this case so that I
> don't have to worry about reducing the capacity of the vector. (Our
> red/black trees are a much better place to look for improving cache
> locality of collections in Rust Binder, and the upcoming xarray bindings
> would help with that.)
>
> Please see the Rust Binder RFC [2] for usage examples.
>
> The linked lists are used all over Rust Binder, but some pointers for
> where to look for examples:
>
> [PATCH RFC 04/20] rust_binder: add work lists
> Implements the work lists that store heterogeneous items. Uses the
> various macros a bunch.
>
> [PATCH RFC 10/20] rust_binder: add death notifications
> Uses the cursor. Also has objects with multiple prev/next pointer pairs.
>
> [PATCH RFC 15/20] rust_binder: add process freezing
> Uses the iterator with for loops.
>
> Link: https://rust-unofficial.github.io/too-many-lists/ [1]
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08=
ba9197f637@google.com/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next`-- thanks everyone!

    [ Replaced `compile_fail` with `ignore` and a TODO note. Removed
      `pub` from example to clean `unreachable_pub` lint. - Miguel ]

    [ Fixed a few typos. - Miguel ]

Cheers,
Miguel

