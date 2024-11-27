Return-Path: <linux-kernel+bounces-423700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18C9DAB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F73A164CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC13200B95;
	Wed, 27 Nov 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/fIIBId"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF51FE45B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724341; cv=none; b=DZHHgPTa8chG8PnfeTHx66LocovUQVVy5gLKduBTiyG3buXvfXg8gkA5UypZlvKEnUf/2Upl9HEKFaCQv8vddUltWxSk0nVSwUQqq0KXpnY0tpdlrWUrMvHXIt61WfIOChDVWh7V+GkGwvaUlW2afanM2MdX2gm0g79YlR9aedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724341; c=relaxed/simple;
	bh=/1gwrOIavLfrPieDrLJ9EuYDBuWukPgu7Q7CFtpdA0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcZPSPhzjC645Y1I7SDYqmzKrlMm/Iit5Yn4SiTtCzcm6IsCe7NYE5KWpjeF7oAZvUGwGgbaQGFvf/LTmpoI0CdHkrPFx5LDeQYrPzjlvbGAIR6sD4vKTHt4vht+hWeJrEfS/+lavCvHW11U5Nj7vEtIVXd8e2KeifrxxrZc2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/fIIBId; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so10618a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732724338; x=1733329138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtL6wKjrUKaD9G1UUVsHA8qoTJvLASSvZXVOzErx25M=;
        b=y/fIIBId2NQ5XU6sXdlfY9a0XKbSUm8xm6e1ynLiVXHN+PeEjMqnjj/DQtANOnI53w
         l7yUHA080Aqjv5AS4pkas8Drpg+eLL6KPa7lhosd8CzfZa+u5ueSDk1XHfnm7MuWj9fb
         5F3AwoF7PGWu0OH4MJ7xVfgh6mC4SZtMVPPDXy7f9+h+vnRq6Pk5KQmi7Eq/PmKAA/0i
         ZuGmrNm8iZpq1+OtmgLVe2/dFb7h4+sY+jUTqZyP+84FCkKheZvN0IpYj5YF6hyRAZ2a
         m/huU0PI4VW7868FSqWSfrJfrjSdJG47TyiGMdr9sW0hxv3X/TtvFqSyN7OjrJq3QKqJ
         WOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724338; x=1733329138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtL6wKjrUKaD9G1UUVsHA8qoTJvLASSvZXVOzErx25M=;
        b=ugiCZ7fVeSEfTK/jnB1FlYVxcGiSswYa5GcbqY2QLi9/KMzIhtGeAjv8hmlzI4J1Ay
         6nPTaWVgOfYrhHYsg4ZFU7R3QziZmbbR2yIplipycWhRK3OxSJoF7FubnrcDr2RAwqKb
         4TadStRb/P20Z0iBRgrR2XDMRU9187oT3FaxVJj5rCQYKx6ZM++A6PHBdGQVY3ZcREYG
         v8ylup6s+TdRJa2lWrE2UkHwtmKurSVNHfdjHC4uLwbXox7bOfvJk6vmog7CB0lwJIRI
         JmKRs8KAkvrsIE+w5cFsP0jUS9/Nfqf1ChpPyejdkmqQo1elnF7IRKskFkCfGpo4DJec
         Rt8A==
X-Forwarded-Encrypted: i=1; AJvYcCX3Uo1g6xnlb+nbd1gCUqQo5Gc5X9eZ6C9H9CmW0G3gZKvDs0MywMEfavswsftPWuCSUDdxirQwbVrx4Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPeewLXZQSACOJbJlp6qPnEaqIS/sQq/6QCpyVVgQwn88f3t2
	wiZRcBlo/GwO/ri2PXtRaQlX20Ds4Kolblv2c7sMmEHUUWdRutKiJNG0Udt9LIIcYqC2geYZ9wW
	uUB0EiZ90LG/bjXW7IxIZSt5saz4EvX84GWIb
X-Gm-Gg: ASbGncuLIR2GkaDR/1KoimQCLueCKYpSUUs1qA05Tlqhx1nI7QORi45+BLKtxHF0R6/
	ZMN7//7nzVeDajUMywA5X8tcMpmVh33tnxKd14lzOFiCruPoiaqDNpzAnhSU=
X-Google-Smtp-Source: AGHT+IGyvRZff5SP+V5FIb2c2WgZxCW2RkMkXyailqNw0SxFY/h2Ezn7rEf+kB6G9/hMA8LcUFv43P+VanzsdKuSEZc=
X-Received: by 2002:aa7:cacf:0:b0:5cf:c93f:36f3 with SMTP id
 4fb4d7f45d1cf-5d08356e19bmr84258a12.7.1732724337334; Wed, 27 Nov 2024
 08:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <CAG48ez09fS1v2gWbOFx+uQd7Lj+z2x3LhL3hfpQzpVHdNJ5UJg@mail.gmail.com>
 <CAH5fLgiJLP_w9vpuQFszkrUW3V3DyJVGHLv7Q43-Rx9-WSXzyw@mail.gmail.com>
 <CAG48ez3a0vs=LHzkbpOKW753m6_LOtoYyWtjhfYvB48TKsCekQ@mail.gmail.com> <CAH5fLgjuKEU8noU5XN_FWEy4wAzJu0aeaURzNsCQrt59a_0gJA@mail.gmail.com>
In-Reply-To: <CAH5fLgjuKEU8noU5XN_FWEy4wAzJu0aeaURzNsCQrt59a_0gJA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 Nov 2024 17:18:21 +0100
Message-ID: <CAG48ez1an_cbUinfCvukQe=X-veygFLe-twQq5zMKTVcMpPv7g@mail.gmail.com>
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

On Wed, Nov 27, 2024 at 4:57=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Wed, Nov 27, 2024 at 4:52=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Wed, Nov 27, 2024 at 1:36=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > > On Tue, Nov 26, 2024 at 6:15=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@googl=
e.com> wrote:
> > > > > +impl CurrentTask {
> > > > > +    /// Access the address space of this task.
> > > > > +    ///
> > > > > +    /// To increment the refcount of the referenced `mm`, you ca=
n use `ARef::from`.
> > > > > +    #[inline]
> > > > > +    pub fn mm(&self) -> Option<&MmWithUser> {
> > > > > +        let mm =3D unsafe { (*self.as_ptr()).mm };
> > > > > +
> > > > > +        if mm.is_null() {
> > > > > +            None
> > > > > +        } else {
> > > > > +            // SAFETY: If `current->mm` is non-null, then it ref=
erences a valid mm with a non-zero
> > > > > +            // value of `mm_users`. The returned `&MmWithUser` b=
orrows from `CurrentTask`, so the
> > > > > +            // `&MmWithUser` cannot escape the current task, mea=
ning `mm_users` can't reach zero
> > > > > +            // while the reference is still live.
> > > > > +            Some(unsafe { MmWithUser::from_raw(mm) })
> > > >
> > > > Maybe also add safety comments for these nitpicky details:
> > > >
> > > > kthreads can use kthread_use_mm()/kthread_unuse_mm() to change
> > > > current->mm (which allows kthreads to access arbitrary userspace
> > > > address spaces with copy_from_user/copy_to_user), but as long as yo=
u
> > > > can't call into kthread_use_mm()/kthread_unuse_mm() from Rust code,
> > > > this should be correct. If you do want to allow calls into
> > > > kthread_use_mm()/kthread_unuse_mm() later on, you might have to gat=
e
> > > > this on a check for PF_KTHREAD, or something like that.
> > >
> > > Huh ... is it possible to use kthread_use_mm() to create a situation
> > > where current->mm has mm_users equal to zero? If not, then I don't
> > > think it's a problem.
> >
> > Ah, no, I don't think so. I think the only problematic scenario would
> > be if rust code created a borrow of current->mm, then called
> > kthread_unuse_mm() and dropped the reference that was held on the MM,
> > and then accessed the borrowed old mm_struct. Which isn't possible
> > unless a Rust binding is created for
> > kthread_use_mm()/kthread_unuse_mm().
>
> Ah, ok.
>
> The way that the current abstraction works is that it enforces that
> the current pointer cannot escape the scope you were in when you
> obtained it. If we enforce that kthread_use_mm() and
> kthread_unuse_mm() involve a scope, then that should solve that.

Oooh, that's neat, thanks for the explanation.

