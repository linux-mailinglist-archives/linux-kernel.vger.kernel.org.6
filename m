Return-Path: <linux-kernel+bounces-423467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DE9DA7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A230A281CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790931FC7E5;
	Wed, 27 Nov 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSAcu2K8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402961FC118
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710964; cv=none; b=pGe8uKnk2Wjoh1t8o6pLwPsCc0h/9O0lShtReZ/NyF+a4p3lY8ZgGWxlcd8HFEumr39R0a3/AYZAX+1kp27IeYVBNeMRbKCz8R3hrqs+yePFcvoK2S4kRfE6Y7H9Bu9+RQD+aXdGM6FbbSEohDVUDTY91u9an/nWDeRFBuPRutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710964; c=relaxed/simple;
	bh=JYbL2g8guAT8sd0URsVEdQ/eCdsK61c3+OjoQGgYXoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgxHabp67uzr1benhPCxpDmnKizgcq68pazyS2a8IWzU3uewr1sRYl1FHdJOw+fVdrddVup+6qh578CflIPERSqXZlNqM8MRcOfXahIEVxMfokdHaDn5h1EO9unHhMwJMdIBZIVRqjsj0zQNIRIOpdaYexEl3oXkMAKChgaySPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSAcu2K8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a10588f3so22626865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732710961; x=1733315761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrzbbClRBZ1yOTU2YN04HTV4UJx3/zhI0vBTZVhTMAw=;
        b=mSAcu2K8eGTPWbuxojPWEIMfF2fVTTbYbafdmXnyK6N854nyXqj3Fr2oBZ1ds13VNf
         rTVaEdM+7FuzNim5Gwg6cy4JVOKbBJuEpUlbwV62pqUy49IR6+Qk6bWc9MdtCRpSYWER
         UAthYoP8/X78wgobZy/+rj20BXee1zr+loKM/D/QYNrvdyni7GXcuYrlr10taJcgMSS6
         AzwC4QkWE2oRS/c3m36eLFMyj7xG3ZSOND6JsEAogIRDBCDToeCOlpHMSWuxM0g8QI8T
         AaJQVXIPxACTP/NuxJVF5OIUEZozNAnJ5JWaAbDCHY8DxfYUZG9Cj/9nvvQYyHHSuJmD
         Ux/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710961; x=1733315761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrzbbClRBZ1yOTU2YN04HTV4UJx3/zhI0vBTZVhTMAw=;
        b=JTG9yLO6E9UsfUydJiRA/N0T2no8mm78TEuxglnyyP3zBBqBE1v0LygWaD3HoF2uWr
         ibvrLtfoQb82/sEInTukpDgaV+6JVUdXJ/4zTPBpIHuLS3dN+x2GtHrwR9hP0ZG96RBR
         Vnb7x5otwUlZ9h8b0deHWy8LqkX+3cZDFFJ2lCGMofwoMk2ZIRSnnQ3E00tk0zEJM9eT
         f9k5bEiRDLIGTB9N3bxHosLVAPK85aBPw6+BiZ4z9/3yHwDBO+1VEBTHG6PzjAo14TqB
         BUdtK1a75NDtvr4fIPfh4rYl6N6p1lA4LqRsY2NKrAV9zA6QknGGkKoPH3IRKVF3cQmq
         0hXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMtgmF4mLFPwMkx8xSziECIrDkTgQenewV9G8E9oMsojj/DuXBKS2Y4OEtZuwSdTO3oU0LG0e7ol6oKUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiynGkq2XzObAJojUZMYqbHcehwi/Q84LVg6ieZFcksrfdhVQz
	NlXPZ878haQ8DviInSP+MsrKrrX+iJPwpo/k14xldZdzaoir7+pha+FWtYejlZsMzuz/35kfzvN
	hSTw9Xb+C/zhTANWfwlJzgM6ffMntoB+QUUN9
X-Gm-Gg: ASbGncuzCSO61kw8x0S0ofGtqEynBdj27kSc+dXv2/bWrZ5gx7CCCEVNuhceTgzapdo
	fdBGfrEClIG/Nfj+eb9JlUQuZwXP+iymX74CRKNO+WJ/+2fR/vV/mv5UZ2ucUVQ==
X-Google-Smtp-Source: AGHT+IEbpjzkgc8IM7OndZI804Me6rzyM6Kjc3mTYT80bhflefRpDQA7MbvAM40NWVN+XmE+Ao7DgeTZqeqNuKDfQlI=
X-Received: by 2002:a5d:59a6:0:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-385c6ec0ce0mr2408873f8f.35.1732710961482; Wed, 27 Nov 2024
 04:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <CAG48ez09fS1v2gWbOFx+uQd7Lj+z2x3LhL3hfpQzpVHdNJ5UJg@mail.gmail.com>
In-Reply-To: <CAG48ez09fS1v2gWbOFx+uQd7Lj+z2x3LhL3hfpQzpVHdNJ5UJg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 13:35:49 +0100
Message-ID: <CAH5fLgiJLP_w9vpuQFszkrUW3V3DyJVGHLv7Q43-Rx9-WSXzyw@mail.gmail.com>
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

On Tue, Nov 26, 2024 at 6:15=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > +impl CurrentTask {
> > +    /// Access the address space of this task.
> > +    ///
> > +    /// To increment the refcount of the referenced `mm`, you can use =
`ARef::from`.
> > +    #[inline]
> > +    pub fn mm(&self) -> Option<&MmWithUser> {
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
> > +            Some(unsafe { MmWithUser::from_raw(mm) })
>
> Maybe also add safety comments for these nitpicky details:
>
> kthreads can use kthread_use_mm()/kthread_unuse_mm() to change
> current->mm (which allows kthreads to access arbitrary userspace
> address spaces with copy_from_user/copy_to_user), but as long as you
> can't call into kthread_use_mm()/kthread_unuse_mm() from Rust code,
> this should be correct. If you do want to allow calls into
> kthread_use_mm()/kthread_unuse_mm() later on, you might have to gate
> this on a check for PF_KTHREAD, or something like that.

Huh ... is it possible to use kthread_use_mm() to create a situation
where current->mm has mm_users equal to zero? If not, then I don't
think it's a problem.

> Binary formats' .load_binary implementations can change current->mm by
> calling begin_new_exec(), but that's not an issue as long as no binary
> format loaders are implemented in Rust.

I think we can allow such loaders by having them involve an unsafe
operation asserting that you're not holding any references into
current when you start the new process.

Alice

