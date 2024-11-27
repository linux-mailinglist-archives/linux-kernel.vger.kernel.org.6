Return-Path: <linux-kernel+bounces-423676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B260A9DAB36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A592B21691
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C3120013B;
	Wed, 27 Nov 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYH03wGc"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987220012B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723054; cv=none; b=ce6WakK2WUaTKBCzdC26xmkwFvojs3cEhsFxa0iAkSh9k2f5irendcokuBKrH+yUBJXrYC3ddSjZB+XzYuMNyQzpp1vwxoPVTzgEYgkJmOwpYYgdQtS2GowZubgaMKL6R7F1qSB8BDRGxKUze6SH5ULh9E9P96dHCfQRsQaNryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723054; c=relaxed/simple;
	bh=t+kJdlBAifOlSuWtBBxY75wEWfui+K7/KJBgH4IsG9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo0SxFbDLIUYXE3tjbl1pAwBNKZ4+pJYJIInW7GvA+Sk05t4w1Yv8+vjmXzscXn9b4mGQaoeHpnlGSvjRBYGXaCGncO6q9LnA5lVwam43IiMk/aO2DgM+nQi/Lrzb+uWh26/G/KhgQTVrfGRm9J3RFcsU1HB4RIH8gADSB2U/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYH03wGc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so5841924a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732723052; x=1733327852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mzq+sY/UuVHCJgsty70Afejr/cELZw5CwMQokYJBrCM=;
        b=tYH03wGcAPEKoFFz1aRNnYoI0lImn1Jev1iT9NAq8I5MUi02kFqd61tRD3p/DQU0qj
         hxNhj3z9x0tdHB5Ad6Yppxq/Yov126WH6pv8Q//YKqe3M6DOpnL5tEFQ1C4AdrJ4yhU0
         HctLOqFtJNgJsDykdB2GlrfA4nGjr5qyURKfzajgL/yYCfjYEAudBSe3ypwu3s7lEnis
         hKs1s5C60b5OFHUR6/14KEUALR/2X2Ey6gZpSzC8Iz661Y0baZDSnt/QYqA/g8DmeJYT
         Igo2PMe1MBU41smcbPUE25fWHEP/yxHKKr2CXUY1mWzK6EADiDtyIcHVcPEG1vn0OlUx
         egdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732723052; x=1733327852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzq+sY/UuVHCJgsty70Afejr/cELZw5CwMQokYJBrCM=;
        b=hav4uvYOjcPJnnA9HgrpWCba1RkYOdlAQtBSHCQxgt3M+bl4ZKaVsu6quxRzCpwxCJ
         Qi3Rp7DuJveGky8uju50R80wNrFaBf4aeyPmeIA/f0B5NMGfsbq2tMnQV17ibSQNoPGC
         iSc/tA9AP8dE1AVq3lvThuvhEmi2yF2KM3hbujWAwj8BPEMhWJewfskxn+ArRGgTuYLC
         qP96s5brPWzEp9r/vm66gNNvj9FP7xMS6iP4/4RZJBTR5opTkHHGPv075zo1WiWDSwl0
         QDsrw9vYx4KO0+e0aZKQiS+NbV4gCMEi9bEwgi0rL8CoT3p+eyRnewUsreZHqa/61Wbb
         /XLw==
X-Forwarded-Encrypted: i=1; AJvYcCW8zAeD1Ani5ZGDXs7cMwMKoaXU9vuTj9qdCHiYnfvntxwQi9zmPY8ZLs5IqSzXuRohdBtRe0kecpjPlCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DG6i2MHJvipDpFefbcg5sdMw5wvEF+A7wC4H9rUsWhyC7DtO
	pto1ZVODjBtZuSdoL6AZsnAWCbvjRYKlF6+Dv2/UzgI9pD1bOWCovRjTPvnwbo7GcrgYdHmMPSv
	q0jH+gdi+UNEWNYY6ycpqthQ52ksUEUq4R1rQ
X-Gm-Gg: ASbGnctMnQ9k/bwKM1GEknhjaIllFxpFPXEaMbDrs9Kr+lFa+YUQmKIUdlSl2Vt4rn3
	FJGvI2GswHDoS09YJt1KRK7guyykk/cvhsQMJQ0ETIlHQwEh8uXsx62vHn5Y1KA==
X-Google-Smtp-Source: AGHT+IG6y1bQBNLQkQ/ye9/NfGNFTdcIbZPYVf1DhkiwrolILsLzrOzKl8C9OOLMv1IvSiKNfdCQWD3L1QdBkC//MAk=
X-Received: by 2002:a17:90b:1e43:b0:2ea:8e42:c3f with SMTP id
 98e67ed59e1d1-2ee08dab550mr5115668a91.0.1732723051588; Wed, 27 Nov 2024
 07:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <CAG48ez09fS1v2gWbOFx+uQd7Lj+z2x3LhL3hfpQzpVHdNJ5UJg@mail.gmail.com>
 <CAH5fLgiJLP_w9vpuQFszkrUW3V3DyJVGHLv7Q43-Rx9-WSXzyw@mail.gmail.com> <CAG48ez3a0vs=LHzkbpOKW753m6_LOtoYyWtjhfYvB48TKsCekQ@mail.gmail.com>
In-Reply-To: <CAG48ez3a0vs=LHzkbpOKW753m6_LOtoYyWtjhfYvB48TKsCekQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 16:57:18 +0100
Message-ID: <CAH5fLgjuKEU8noU5XN_FWEy4wAzJu0aeaURzNsCQrt59a_0gJA@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Jann Horn <jannh@google.com>
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

On Wed, Nov 27, 2024 at 4:52=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Nov 27, 2024 at 1:36=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > On Tue, Nov 26, 2024 at 6:15=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > > +impl CurrentTask {
> > > > +    /// Access the address space of this task.
> > > > +    ///
> > > > +    /// To increment the refcount of the referenced `mm`, you can =
use `ARef::from`.
> > > > +    #[inline]
> > > > +    pub fn mm(&self) -> Option<&MmWithUser> {
> > > > +        let mm =3D unsafe { (*self.as_ptr()).mm };
> > > > +
> > > > +        if mm.is_null() {
> > > > +            None
> > > > +        } else {
> > > > +            // SAFETY: If `current->mm` is non-null, then it refer=
ences a valid mm with a non-zero
> > > > +            // value of `mm_users`. The returned `&MmWithUser` bor=
rows from `CurrentTask`, so the
> > > > +            // `&MmWithUser` cannot escape the current task, meani=
ng `mm_users` can't reach zero
> > > > +            // while the reference is still live.
> > > > +            Some(unsafe { MmWithUser::from_raw(mm) })
> > >
> > > Maybe also add safety comments for these nitpicky details:
> > >
> > > kthreads can use kthread_use_mm()/kthread_unuse_mm() to change
> > > current->mm (which allows kthreads to access arbitrary userspace
> > > address spaces with copy_from_user/copy_to_user), but as long as you
> > > can't call into kthread_use_mm()/kthread_unuse_mm() from Rust code,
> > > this should be correct. If you do want to allow calls into
> > > kthread_use_mm()/kthread_unuse_mm() later on, you might have to gate
> > > this on a check for PF_KTHREAD, or something like that.
> >
> > Huh ... is it possible to use kthread_use_mm() to create a situation
> > where current->mm has mm_users equal to zero? If not, then I don't
> > think it's a problem.
>
> Ah, no, I don't think so. I think the only problematic scenario would
> be if rust code created a borrow of current->mm, then called
> kthread_unuse_mm() and dropped the reference that was held on the MM,
> and then accessed the borrowed old mm_struct. Which isn't possible
> unless a Rust binding is created for
> kthread_use_mm()/kthread_unuse_mm().

Ah, ok.

The way that the current abstraction works is that it enforces that
the current pointer cannot escape the scope you were in when you
obtained it. If we enforce that kthread_use_mm() and
kthread_unuse_mm() involve a scope, then that should solve that.

Alice

