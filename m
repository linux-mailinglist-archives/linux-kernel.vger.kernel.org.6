Return-Path: <linux-kernel+bounces-423664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFD9DAB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE87281E60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152D200127;
	Wed, 27 Nov 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MlEv9kV"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89D1FF7D0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722770; cv=none; b=NESivM1lZ7GF1ztCxJsiZ3Gkokw8MGTAVYmZbUdeRjAy4OSwSCOxOypTm0YTPoa7w7Ny6Iito9YR21dX3w+levJWjIxbENERaN/Y6xOhobEBKECpE5/0H8mUTkg32j3n5Oi/03EqCJnGvDPffroXzIHSofwxDufgAA2Pw1YjiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722770; c=relaxed/simple;
	bh=DPf9CZDUw1xuPmrJRDmJhbs8f7HyL5z27zV/xGxBV0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGpyDOGPqUil3UlRkfAccHoBtTDds1/wWsnObFPClJEqCGUDSw5mJliejNt6jpyqAxyk/R+VY9H/yEw/9VqIDWwxZKN8nfXEQz7+dqeoPt9gmjDWtwvWTlXNkvtvongMPUV2jA83ZKVS7GjKjIghDrFSk6g+Fk1HRVodNjVuzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MlEv9kV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so10161a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732722767; x=1733327567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/NtU0l0FRQQbt2Knk7s8zJ9lWXoHwoocpt9wyTKe8c=;
        b=1MlEv9kVM7mXnifk/452y2zRUtyIaXPvjeRRJd1a0Lz5yS950cP8vMTP/owGiuGeqk
         1GzGhETWUUVBtCkHz9gC0KFPlKB7DGJ5YC2Fc61I9hEe1++p4570ge8XoGfRGcm/TQBJ
         p6lPpcnfXjWzjRn8qgQocdC2ivur+yHrCRG4Mr64fTxuRBz72XnMaOQTdhnZOK7VUx7w
         rvXo72mmoR0lVQs0+L3o3g5HMlsx8ls9r2yi4iDBUwD6OyFjM1oIUHet4B6znDTFvwwG
         NsMTebuMQatAHktsNuc3ycl/28B/MnFsMIrD3zQpGqAgAtLF2sa8j/z/1tvPzSZmt161
         Jo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722767; x=1733327567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/NtU0l0FRQQbt2Knk7s8zJ9lWXoHwoocpt9wyTKe8c=;
        b=glRrApViflTT+HHBgVDuGTkRz/23CaokrVrQ+ikdGIXIwQQ8xCWyL99W8xaBoe0gYA
         Zb9rM0AfKePo1Sbsop3Ch5yWTcb3YNsmC9+DIufgpd/lEQCuSbYb+my8uKVJbjO888p7
         AYjxV83FtWN+pWFU0akZ9IryxSq5ofjybSgYClItbofUMIhxmL3rhrraxNjedn6Y5JZ5
         06rXRvrG8URl2Lo7wjNKODSJR2TW+CUP4Lyx1HNniGccJgRAx2M+Wu+sNXkIwZgdkI/3
         uSVHv7us7cdptaRWwPK3ZPdq4tETuw3IfrN/BWTqtJJx+TFXHfFgaJs0qzP2bgH+9Hnb
         n55Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5ke3CIuuPEYU8GdCfYDTGaw8+zvE/YoKV00oJLBSFLZAgUilowkrbIbh0TW/E4/xcFZ1+2Dv5sqURtAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLACTxyt3JJn+uLVA49eJHEFBPMHgGU48+MarXLbPmc7yQUuk
	KvE+RRm9xlg8kL+fa/Fywk8UbiPyruGyKp4YpyViR8MoFf85kDAjy6481NRx3sY1nE/NsAH+Zxi
	sUgmqoFLX06Z+68ibQ4FVmZG1dsA3V8HrT6Vc
X-Gm-Gg: ASbGncsEbGbHVNOL5ZETLbtxLU6fv0UQPdSXPx5Ar7+ybbpJa5Ioo+w6nAWD2j2/hYr
	/G10aRFOyAJJsUkAkPuyTOWFsvQScQoGgcldd3f2h9zhmKC5UoPjks2QZtSA=
X-Google-Smtp-Source: AGHT+IGTPN4/S8TASU18K7Bf2qjUWSo8zdU4Y5Icg5MBDnyn6tZHZNZ7ool61CiwqTxfrkdgE/GvaQL4yeeJvOCrMtI=
X-Received: by 2002:aa7:c74d:0:b0:5d0:3dcc:16bb with SMTP id
 4fb4d7f45d1cf-5d0819a44fcmr82630a12.4.1732722766657; Wed, 27 Nov 2024
 07:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <CAG48ez09fS1v2gWbOFx+uQd7Lj+z2x3LhL3hfpQzpVHdNJ5UJg@mail.gmail.com> <CAH5fLgiJLP_w9vpuQFszkrUW3V3DyJVGHLv7Q43-Rx9-WSXzyw@mail.gmail.com>
In-Reply-To: <CAH5fLgiJLP_w9vpuQFszkrUW3V3DyJVGHLv7Q43-Rx9-WSXzyw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 Nov 2024 16:52:10 +0100
Message-ID: <CAG48ez3a0vs=LHzkbpOKW753m6_LOtoYyWtjhfYvB48TKsCekQ@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:36=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Tue, Nov 26, 2024 at 6:15=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > > +impl CurrentTask {
> > > +    /// Access the address space of this task.
> > > +    ///
> > > +    /// To increment the refcount of the referenced `mm`, you can us=
e `ARef::from`.
> > > +    #[inline]
> > > +    pub fn mm(&self) -> Option<&MmWithUser> {
> > > +        let mm =3D unsafe { (*self.as_ptr()).mm };
> > > +
> > > +        if mm.is_null() {
> > > +            None
> > > +        } else {
> > > +            // SAFETY: If `current->mm` is non-null, then it referen=
ces a valid mm with a non-zero
> > > +            // value of `mm_users`. The returned `&MmWithUser` borro=
ws from `CurrentTask`, so the
> > > +            // `&MmWithUser` cannot escape the current task, meaning=
 `mm_users` can't reach zero
> > > +            // while the reference is still live.
> > > +            Some(unsafe { MmWithUser::from_raw(mm) })
> >
> > Maybe also add safety comments for these nitpicky details:
> >
> > kthreads can use kthread_use_mm()/kthread_unuse_mm() to change
> > current->mm (which allows kthreads to access arbitrary userspace
> > address spaces with copy_from_user/copy_to_user), but as long as you
> > can't call into kthread_use_mm()/kthread_unuse_mm() from Rust code,
> > this should be correct. If you do want to allow calls into
> > kthread_use_mm()/kthread_unuse_mm() later on, you might have to gate
> > this on a check for PF_KTHREAD, or something like that.
>
> Huh ... is it possible to use kthread_use_mm() to create a situation
> where current->mm has mm_users equal to zero? If not, then I don't
> think it's a problem.

Ah, no, I don't think so. I think the only problematic scenario would
be if rust code created a borrow of current->mm, then called
kthread_unuse_mm() and dropped the reference that was held on the MM,
and then accessed the borrowed old mm_struct. Which isn't possible
unless a Rust binding is created for
kthread_use_mm()/kthread_unuse_mm().

> > Binary formats' .load_binary implementations can change current->mm by
> > calling begin_new_exec(), but that's not an issue as long as no binary
> > format loaders are implemented in Rust.
>
> I think we can allow such loaders by having them involve an unsafe
> operation asserting that you're not holding any references into
> current when you start the new process.

Sounds reasonable.

