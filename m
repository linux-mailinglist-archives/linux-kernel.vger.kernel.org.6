Return-Path: <linux-kernel+bounces-276366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527ED949287
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A2B28810D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6418D623;
	Tue,  6 Aug 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0PAZ9nT3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38D20FAB7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952825; cv=none; b=PyCUnyN3UHvSgKdStfZK1f9FT/nn2vrt4+OdFS0Vk6eERpEvBYsPqCDY+iqPvbGxOSwRa6tzZPNsBj0LWsSM20u9jBBT+ujj7SYtshvF3LZyBSpni+M7m+Dp+ziyS7mkeuSzY7QeTr8uQqNKUhr3wKX48WK/ufhSkZsCXdX78RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952825; c=relaxed/simple;
	bh=yF7W8plauO3cSOQcFgYN4VtcWTT9YGEzRpS+d5QN+iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT1COyzjoQL204/Zusmat36tSHcEBIIx50qfSR/eGCPkdWouYNPeJMCYcO5a0Xjgcgjkxfp0dWSVJnZg+JWhQOXri0+oylyfLN4g1B1Ca02NiId86lGvVj1HAQzivOXR98lTvI74ZQxmsYUNWsUw/o+RN0qB6mh0KicK8JW0Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0PAZ9nT3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso5368105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952822; x=1723557622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF7W8plauO3cSOQcFgYN4VtcWTT9YGEzRpS+d5QN+iU=;
        b=0PAZ9nT3OrzA8ThpDg92NJMsfGZptftZ+bRIqsET5Kn7uxYTKW0MFOmRnX3CfKsUtd
         IVGfjwT+avmWT/qLApdphPRx3ElYBgVR3/Dty8CkMfY9mGw4UWTOWvZ/6rP8Hfm0Wm80
         9aIQauuyEnKBCE5PlD+vp7ESyKQ7hDda9Be/yytH8Uywx9eLrI9ElmGGqLG5snPacIe4
         WXKelHKD44tAMRQ9gnvFl8nRrnG27TC0ynYJyvYrJ0jdqwHkmzH9gd8fACIx/JbZ/0Mc
         Kh/Tsyjsksws+q8sMYTc2Mzbopm6YiEEg/Kb8LDb/NatmGCq694cwfWZn2WxSUoG4nWE
         b5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952822; x=1723557622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF7W8plauO3cSOQcFgYN4VtcWTT9YGEzRpS+d5QN+iU=;
        b=AzlFo1oQ5KwEH2hKfxMWE2MGnOsBT/HJgGjfBKNQ1GBQdGT7GAQNdRDuftic4BmOAe
         3jc9jQM2UjqbAyVP2cdAijUSJp9QXf33elLvIJF6eVAzrNz9ol6CsQFSpAHjvDP1FD18
         d8JnrNuJCLS68rrUHpy7lWOf7kADOhEduvvR7A128sXeYgRix7lOx2yWAURNx0NhRIbo
         yyAAoht2gy2B5r2xdVLD5znvurrQtp5Yiu/VO1pM02sSikaowc1229+ROZnZjW5aafSJ
         xpCY0wCDIDMqE7gaxJx8e1x0bgjlMWrY6ESEuHhTTXtC2lZiGpscpQTGd+CU29dfOrqb
         RL5g==
X-Forwarded-Encrypted: i=1; AJvYcCXtTlxEQrT+6bqjGcOtNhFNHniNuAjyAuHnTlZnumvyglLBo2ZJRyjBMggGqLtu5sY3Oqc1mxbyQFdwP0c7XjfkmSY4ZuUcgxeMalwy
X-Gm-Message-State: AOJu0Yxw3lUnsuRNfDPbJgRv8iJF6QJkNQQleZicuXiMb/orj9VBztER
	43ShHpuO446mdzMvc6Rh83e3IFPmCibJ7VYvHPQ/xQoXZ+EPcNexg5q5RkpWyl2rkzcM5VyC9TW
	QyH7lbUs9DRqXzTRxlzpkMY95oIaYeLjnJrkJ
X-Google-Smtp-Source: AGHT+IHgz85bFjKsptm4i5LOyuZb90LSO9jrl4flVX7fyPL1vv0Ry8v7hkD5nB5Yvk7R9grQJFQMJbDKPdbryvDuW4g=
X-Received: by 2002:a5d:5f43:0:b0:367:4dce:1ff5 with SMTP id
 ffacd0b85a97d-36bbc0e7593mr12113808f8f.32.1722952821732; Tue, 06 Aug 2024
 07:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 16:00:09 +0200
Message-ID: <CAH5fLghPn-i-rOnC5HeUKDMqmhVFSyzPg0DhMVxkrSgBudw8Kg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add Rust linked list for reference counted values
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
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

On Tue, Aug 6, 2024 at 3:59=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
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
> ---
> Changes in v4:
> - Support several impl blocks inside `impl_list_item!`.
> - Link to v3: https://lore.kernel.org/r/20240723-linked-list-v3-0-89db92c=
7dbf4@google.com

Oops, forgot to fill this out. Also addressed the other comments from Benno=
.

Alice

