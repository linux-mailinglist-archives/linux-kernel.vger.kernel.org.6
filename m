Return-Path: <linux-kernel+bounces-416802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 560609D4A77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C2D1F2262F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F131CD1F6;
	Thu, 21 Nov 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpoOriIc"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E121A0B08
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183701; cv=none; b=tciyYGySmqV+RdfGpxu/11VdOxnkwD6TayRwxsXKCxJu83Q9g4kN3QwJmQe8KdWtcrFqP04yLadsBNnTyWTYtxb477uMHgNGT0DwAe845TfZghpjspsdCu+Vgujtsw+yo4G8OXDKpZzW6kiIocoJt6C17VzrZfwsfjxWO9LDJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183701; c=relaxed/simple;
	bh=yBbdsApvfHb/NGOGR5y/qA9wfZsvXHVzSmYceufkpJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqHVhHlbHncq3EyKeaJbULbSmMivUOAVMaYXdIvVkNebopsXfBHihuImqhX4P1fLKnOu+7yoQWdLPho+pSfJtEnBFLNSherxKaT0uH7J6fw/UjmBeljBsCWGY8G7UOlLZj1xf72m5dATyrDLO0fpPN9ZjENpfD1NC5Bq3u88Kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpoOriIc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38241435528so438344f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732183697; x=1732788497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuqAwFP3qXJbhgF+m94fzJxlivQXEpF5fDoudxVSxdg=;
        b=vpoOriIc0J3hEVW4viNZwu753akxblUz/Ji6IGGnPVbn7Ln7mJNZ4pZ/bdMpHUquSq
         2ZYwClmrniQ4+QWUOJsxDgwBMpovjsLr8Nriq8jYImW+9Mt2aF0Oyl1nDL1Hy2aWdwrs
         CJ17cvqXwp2DKOQ7FI0GouyGmhGvGASXfKPXviTztHuMId9rIXjiTzaxLInZ0hPSdFa8
         6Yi/E61ORXXuW3ZbOfXoecVgqCOMqHxZ0nTuiK4OTIx5dzN36PzwAGbzJ8Oxr24rLJX3
         sM+f6Ap6lWeIWmVr1nv4PaWk3hVDzC69f6JJEy6rtatbknbVDa9ZWA3osU7AKLggu5nV
         Rz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732183697; x=1732788497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuqAwFP3qXJbhgF+m94fzJxlivQXEpF5fDoudxVSxdg=;
        b=XnWBUxy9YApkg7XlmKakZ75RzvF4GJ+388ZMSvJgUga4qg2MIJaYQs946ozBM5aseW
         yWw2iaKFsK88HDzU/G95Ahmx5oEl9zIfYvVGewW4YwwBB7mKOpS1jkMT3nCBcCB/9JeU
         LTJT++ZQKB6SBcBHJBhTX9eFtrHnod+8FNhXWyeeSKTwatxxMMJ0xRNU0hIKnDgDXgsS
         /8NLarh75Tgr5rNmhZbqzjqAzZQfqqPR+C3j73y/X3JoO9Op1xFzAQeB2Rns2fB5p0H3
         I2lMMa7SBVjJV+996/dKcSuNM2ITRtYNXtdUwmVJpyqctT3JaEhN4/O38cRnpFXchtPX
         JQkw==
X-Forwarded-Encrypted: i=1; AJvYcCV3APTA0HkU88vnVMK3uO+82GhWW0yEJISZ7kx+aYO5NI0AhxAvVtniqGgH0uLFUKYNbQtmmZZopd4Zi5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+w4l6GQyQ6bNwBWp9dzSnaMDB+iEQATTzzllmrTz0yPBnNG/
	wz4n+BpAd5gn+psQtmIBkYX557wW5X+4buUZDxaBFyk185AKZHgDjauaj8v0Q5V4chUZJUMN9R7
	lY8ogFUKH6d4O+XW9j6pi3tU7XO8y0qN/VUsu
X-Google-Smtp-Source: AGHT+IGfL/ASasP7Bf+YpdHopthl9ENVqGb52IIvzrlZxcW0+1CQTsIidejsTxMVAFwQUIeUIXHTNsPRRrhQUzoCXzM=
X-Received: by 2002:a5d:64c2:0:b0:382:4b5c:418c with SMTP id
 ffacd0b85a97d-38254b20878mr5116380f8f.55.1732183697395; Thu, 21 Nov 2024
 02:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-7-eb31425da66b@google.com>
 <bd95657f-0fcf-4c13-a02a-d7293aa5f5ea@lucifer.local>
In-Reply-To: <bd95657f-0fcf-4c13-a02a-d7293aa5f5ea@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 11:08:05 +0100
Message-ID: <CAH5fLgjz7nd2DfqKJfDKFpODJ_TUMP1omN+7DqTnpqTNrXTC6g@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] rust: miscdevice: add mmap support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 9:07=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:50:01PM +0000, Alice Ryhl wrote:
> > Using the vma support introduced by the previous commit, introduce mmap
> > support for miscdevices. The mmap call is given a vma that is undergoin=
g
> > initial setup, so the VmAreaNew type is used.
>
> Again, I'd be explicit about the VMA being passed to a struct
> file_operations->mmap() hook on mmap. Otherwise this seems super vague to
> me!

I wasn't sure if vmas could be constructed in any context other than
mmap. Will reword.

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/miscdevice.rs | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 7e2a79b3ae26..4e4b9476e092 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -11,6 +11,7 @@
> >  use crate::{
> >      bindings,
> >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > +    mm::virt::VmAreaNew,
> >      prelude::*,
> >      str::CStr,
> >      types::{ForeignOwnable, Opaque},
> > @@ -110,6 +111,11 @@ fn release(device: Self::Ptr) {
> >          drop(device);
> >      }
> >
> > +    /// Handle for mmap.
> > +    fn mmap(_device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>, _vma=
: &VmAreaNew) -> Result {
>
> You will have to help me with this :) ForeignOwnable, Borrowed<'_>, _vma =
I'm a
> bit lost here!

When you implement the Miscdevice for your own type, you write a block
like this one:

impl Miscdevice for MyType {
    type Ptr =3D Arc<MyType>;
    ...
}

Here Arc is a pointer type (very similar to ARef) that represents
ownership over a refcount to a refcounted value.

In this case:
* Self refers to MyType.
* Self::Ptr refers to Arc<MyType>
* <Self::Ptr as ForeignOwnable>::Borrowed<'_> refers to ArcBorrow<MyType>

The last step is resolved to ArcBorrow<MyType> because of this impl
block in rust/kernel/sync/arc.rs:

impl<T: 'static> ForeignOwnable for Arc<T> {
    type Borrowed<'a> =3D ArcBorrow<'a, T>;
    ...
}

Note that Self::Ptr is short-hand for <Self as Miscdevice>::Ptr.

> > +        kernel::build_error(VTABLE_DEFAULT_ERROR)
>
> What is this? Is this not yet implemented or something, and this is a
> placeholder or something?

It's a build-time assertion that this function is dead-code eliminated.

There are two cases:
* Either the driver does not override mmap. In this case, we store a
null pointer in the fops table.
* Or the driver overrides mmap with their own implementation. In this
case, we store a function pointer to whichever implementation they
provided.
In neither case is the above function present anywhere in the final executa=
ble.

Alice

