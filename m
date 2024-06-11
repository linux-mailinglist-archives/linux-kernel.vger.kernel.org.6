Return-Path: <linux-kernel+bounces-209512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79101903711
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0038E1F26089
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3932175549;
	Tue, 11 Jun 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miaLz83g"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF917554A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095895; cv=none; b=fqDWk+q0bVlnNfV3AqOu7B3npclHNSKOgnL4hhEPYOCXnRucnSAKXfRI+9oBOjKmeiL95PEvVxtLf2KYtOT6DQmzngSP0654/Svk786QKkRXTOsYhgVtXADDqltf5CNxjOfhTPjBd673Ii9M68aGvEDfY9FhbUxBq48HxBQ2WFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095895; c=relaxed/simple;
	bh=UWU68DxMsnWJ89XSm/fDPJZsxETEh3lhJSfrsW5fAhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebxoFVNL6dVdptn4hL78El0szU9I6qYO6DRHbtm3ztqneFs+z2KS6L1+jcrTe3944P8AYjhARXEW5jy0SqkMBWwa/10OewkkG0h9JMEhJVraDK5NkXL2PoDllYP+PIH3UkQCg99p/CDyjjRbTRolDWGHY8IRz0SvQOiv5qqqK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miaLz83g; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so280697f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718095893; x=1718700693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWmRJ+DS9QOyVc/Vbdc3INhVnAvdDE8ka30qlfy9z30=;
        b=miaLz83gv6NfB94Z6HLCV8X+V8WDSVskQXOezqS4/aBUg8cvSHNQChbdarSeMNadjB
         tJOMwf00j0EPKbzSWbgt1Zj0Io1K1+JoFDm3+ve2deWoIRiicw7xYVCbmTrG1LGOiOJN
         lUdnrQ7RfQHGhYegxXG7N/agFRv6SwJ9mnOcbQWrf9NU1D1Yja+Ujswx6NRUGvEgalis
         vEIS68userFGwLn6Le1Y9iFU4+oAdArn9dMgHRqyFYuYnPDwJhUGGZ+UIdg1c5ZTUSs1
         S7dX57cDbfKhcldz/s6IyU9DrA72Fi42P/RQNIbxIcDxBuucEbghFy27LvLrNHej1SiH
         7obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718095893; x=1718700693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWmRJ+DS9QOyVc/Vbdc3INhVnAvdDE8ka30qlfy9z30=;
        b=KJJ+iJwABF2klvOzL/e0ZantUyf1aEZtTuYyzNqV/Vbmcsz990iBI+BE1KeEI6ltiM
         9qIR6Groq1HvXpKrYRH4+Y3mMFdQHMVW7k3qTazr8OUNrM1mo+0PtZGIcKSvGbnyzU+k
         OXqbi+cr9Vl0q07k0CyWOwOY8WE3NWWQKCs9nOLYw7NaOVq+XVf2Z9EEospojoxiIGrU
         C872NTNX77PHutCMWWhigtJalwkOpk7R7OZSlbVZRxnskY0ZE4vLxYelYJuIgJh7/zFL
         NRQP/nh4qqw4/SjeHe8uxADIUCjNsZ49c45jrw0JTS5Yh2IsCL0Oe9G1+/R1mrtsG1Co
         phoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHVjGAr9BLHo2g14NMhKGl0TQOThoaFsy5CSJ+4qvzDhS466wSy1vVfSrEoGv2PK9dojPd9+Y53ANeqcCD+xCzLo00ddlbbqhgcDah
X-Gm-Message-State: AOJu0YyKDUvaRM3ZZECRmmoBKjE3n0mUd8xTVGt1eU9FwOHa5XMR6qzX
	gQ9mAc/DDpt7k0fmVOHYu2bo7B84U3Gk72mJUFbeiO6VUgTz/EhkQ+Z0hyLtRYKmPVcmdJ53reu
	6mKsd7ibs/syk7157qPLsIIiHsUSIAhiQS0B9
X-Google-Smtp-Source: AGHT+IHbMb+7XlG53W12WXEF6AXFOPxNGQEg+5JLxaoMvIxZkN5MKxJsr00B1X4JZqpKLyAwyqD2mrvFQITfqkWsnzw=
X-Received: by 2002:adf:e74c:0:b0:35f:2b1d:433 with SMTP id
 ffacd0b85a97d-35f2b1d04a9mr1545251f8f.26.1718095892531; Tue, 11 Jun 2024
 01:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
 <20240528-alice-mm-v7-4-78222c31b8f4@google.com> <882a4ba5-b0ef-4c21-8167-e2949424912c@redhat.com>
In-Reply-To: <882a4ba5-b0ef-4c21-8167-e2949424912c@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 11 Jun 2024 10:51:19 +0200
Message-ID: <CAH5fLgjrt0Ohj1qBv=GrqZumBTMQ1jbsKakChmxmG2JYDJEM8w@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] rust: add abstraction for `struct page`
To: Abdiel Janulgue <abdiel@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:47=E2=80=AFPM Abdiel Janulgue <abdiel@redhat.com=
> wrote:
>
> Hi,
>
> On 28/05/2024 17:58, Alice Ryhl wrote:
> > Adds a new struct called `Page` that wraps a pointer to `struct page`.
> > This struct is assumed to hold ownership over the page, so that Rust
> > code can allocate and manage pages directly.
> >
> > +
> > +impl Drop for Page {
> > +    fn drop(&mut self) {
> > +        // SAFETY: By the type invariants, we have ownership of the pa=
ge and can free it.
> > +        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> > +    }
> > +}
> >
>
> What about cases where the struct page pointer is not owned or allocated
> by this wrapper? For example, pages returned vmalloc_to_page()?
> Any thoughts about exposing a provision to avoid freeing those pages
> during Drop?
>
> We've been experimenting in adapting this Page wrapper in advance for
> page management within the Nova DRM driver.

That would make a lot of sense, but this Page wrapper doesn't support
it. You are very welcome to extend it.

There are essentially two ways to go about it:

1. Change the Page struct to be a `Opaque<bindings::page>` and use the
types &Page and BoxLikeType<Page> for these two purposes. Here,
BoxLikeType would be a new type that is to Box in the same way as how
ARef is to Arc.
2. Introduce a new PageRef<'a> type that's like a reference to a page.
You can have Page deref to PageRef so that they share methods.

The second solution is easiest right now. The first solution is
probably what we want long-term.

Alice

