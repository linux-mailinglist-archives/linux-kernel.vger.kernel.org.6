Return-Path: <linux-kernel+bounces-418684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732459D644D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327D4282BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269681DF724;
	Fri, 22 Nov 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1ualcxO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92129A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301311; cv=none; b=mptYBjkfEsWPtNqklBi4exId9orDjXlGiuyN44SfDkpwPTV7hvj1thbjQPbJBm8CZeGsZbq8/zorRL63HsA3NxQGgHvdBMwShpkUlZMZ67JgdYmst06GLa4dR+pXv5au2XK3A8390xVWIORa26LVu4xw4djSlgvI/g3cOr8FsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301311; c=relaxed/simple;
	bh=V1bU1fChAa/XHvJnDBwQMQagAVDXTvNTsU8JJ7Yl6nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EV0zxEVjN5ZRoAe6h460rgdAhWKW305ME0a5u7t0w3WjSLJsMbffiago00pfx7jbl90rmoSrRmfGRB+xRHSe+DDC494kex66SaUDaZwi8fGx7GNsL0q2+IvGTJ+3AO3Fj1hYhq6M5XEtzfebBCFMmYrMJ0tVKHsubw3rAq9reMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1ualcxO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so21700315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732301308; x=1732906108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxIeahTsMKLoh9Cd1c7NSRJawE4dDHGCsOK9b9C7oa8=;
        b=x1ualcxOb+f30+2VRrCStSnC/CU1fdeqtDlStev9YXiR9AdgsWgAXdZ/MpVpGECF1R
         uCOdlpvFyBgwd5R23aKUGYaaKpj64ZyJbcibpsXCa5KjlSc1KJLEQORTowj89mV7HtT8
         suHd+1Mg8iWzx0SwGIxjmHqPKfmVxAg7JUx/pCjbyYaQ86jeU2BvjOj3gBnnke0TREnz
         f52+SIrv/6/ECh8csK9GlCgOtpd7rGCkqBG+M/K2ggp/ddm3Djd0g3p+zvKUipgBJgJJ
         5evXJOF7OjhV5NbXkVHUVmDSNxof5NP1hmcL74ipmQPktJxMe5bXjyQ4jUfHHviJSvRi
         0Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732301308; x=1732906108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxIeahTsMKLoh9Cd1c7NSRJawE4dDHGCsOK9b9C7oa8=;
        b=eKS+AJkpUCTYzNPS9hTAsj32vPY3312COyj2xUBNRHgePwNnHaL+WtAtIi2yvJJs1R
         D4DnuGZacUquqmD0K8/JZnmI+ZpftldNhGoHwAvX4uK4aahVLt6PsDW22OkV9Yk/+gMd
         YMp+wgmyzQneIiM09F9eQ3WIG1TANmuqmBs+L7B/+cmxjo4n3Rk+tc/+ZZpJ2K5ysWp4
         VKo66dRkjAq+lqF2XLNB1wzUJx7HdJx6nJi8tfks1SYSL6W3vLYcuUJ1F+skYxZEFCNm
         UtAyKtWVu3qsUGFw+vrst6NT6Xrgs0rrJ8LfQQfnwZCW+syqOtbP5GLnPjNJE/cjAz8b
         Ynng==
X-Forwarded-Encrypted: i=1; AJvYcCW351dSmKrgl84okUVp5gQquElJ5VgfG3D1vX6daDzt1/E+K30yojCt9XiWPvm52ypzn6GMJ1cLtPdKuk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3EMfN7rzUK17EYlfRVAT5JTMavLOO/y92dnjgxZokBnQU04f
	6AQh+uRofwnNPXgFGup25Jq6CARfgq1ittC6ClMZvBpk8kI5o6270CZnb203wC1NPkDvar7Glg9
	8YZiIPbtW8SHtWXJWdXq0IjCHls/N6IuRgMS8
X-Gm-Gg: ASbGnctZbI0Im2MY604xRqYkz0T5gjfhGXdtCIac31aEohpexVP6/C6An8e38CaxpXS
	GOjpku1HwWxgb0KRYzCi9yYPW6TQ4qixS
X-Google-Smtp-Source: AGHT+IHaew+kp1my7q0xI6I8koJgRiIyjZFN91JPlAzIjCxjDZ9Xi1o5BjsQ2ZFr68SvzqEGgIZc5l0od7huX7RZf0c=
X-Received: by 2002:a5d:5f86:0:b0:381:f5c2:df24 with SMTP id
 ffacd0b85a97d-38260bf39a6mr3130037f8f.57.1732301308033; Fri, 22 Nov 2024
 10:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <6740c786.050a0220.31315a.5363@mx.google.com>
In-Reply-To: <6740c786.050a0220.31315a.5363@mx.google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Nov 2024 19:48:16 +0100
Message-ID: <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 7:03=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Nov 22, 2024 at 03:40:33PM +0000, Alice Ryhl wrote:
> > +/// Represents a [`Task`] obtained from the `current` global.
> > +///
> > +/// This type exists to provide more efficient operations that are onl=
y valid on the current task.
> > +/// For example, to retrieve the pid-namespace of a task, you must use=
 rcu protection unless it is
> > +/// the current task.
> > +///
> > +/// # Invariants
> > +///
> > +/// Must be equal to `current` of some thread that is currently runnin=
g somewhere.
> > +pub struct CurrentTask(Task);
> > +
>
> I think you need to make `CurrentTask` `!Sync`, right? Otherwise, other
> threads can access the shared reference of a `CurrentTask` and the ->mm
> field. I'm thinking if we have a scoped thread/workqueue support in the
> future:
>
>         let task =3D current!();
>         Workqueue::scoped(|s| {
>             s.spawn(|| {
>                 let mm =3D task.mm();
>                 // do something with the mm
>             });
>         });

I don't think this is a problem? As long as a thread exists somewhere
with `current` being equal to the task, we should be fine?

> > +impl CurrentTask {
> > +    /// Access the address space of this task.
> > +    ///
> > +    /// To increment the refcount of the referenced `mm`, you can use =
`ARef::from`.
> > +    #[inline]
> > +    pub fn mm(&self) -> Option<&MmWithUser> {
>
> Hmm... similar issue, `MmWithUser` is `Sync`.

What is the problem with that?

> > +        let mm =3D unsafe { (*self.as_ptr()).mm };
> > +
> > +        if mm.is_null() {
> > +            None
> > +        } else {
> > +            // SAFETY: If `current->mm` is non-null, then it reference=
s a valid mm with a non-zero
> > +            // value of `mm_users`. The returned `&MmWithUser` borrows=
 from `CurrentTask`, so the
> > +            // `&MmWithUser` cannot escape the current task, meaning `=
mm_users` can't reach zero
> > +            // while the reference is still live.
>
> Regards,
> Boqun
>
> > +            Some(unsafe { MmWithUser::from_raw(mm) })
> > +        }
> > +    }
> > +}
> > +
> >  // SAFETY: The type invariants guarantee that `Task` is always refcoun=
ted.
> >  unsafe impl crate::types::AlwaysRefCounted for Task {
> >      fn inc_ref(&self) {
> >
> > --
> > 2.47.0.371.ga323438b13-goog
> >

