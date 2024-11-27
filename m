Return-Path: <linux-kernel+bounces-423469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FE9DA7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A750281DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3AA1FCCEE;
	Wed, 27 Nov 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czKHaq92"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6118FDD0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711130; cv=none; b=BRHl251vfdLVnWjc7/3heraS//FXJvX/tqAAyKhF99TcbtRWAm78aO9qnbNXNtXrvKi9qhRrVi9PbyUVF5rtEmcJ2fAno7FqzGUIbiu44oDA9ddXz/9VInbTfqYuImj7/OuCIdxGlbO2rmd8lxKlQB1iVd+0F70IXaxVUCaE6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711130; c=relaxed/simple;
	bh=1YYaQVcd/H798xCcU6/zkfoT/mGH/vxkiRfRp4k/Kpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwkWJ0iBnGbc3uMx6E8BYl51yUL7jwBQHJ0VYO0teqX6l46jUzNV7f7dlVl1SQY78htEHPm4oX6LxwdQhDypK1nKyKXpzn2R8NaZZ7hHD5K5YlvF/exWdWtLPXmujutLJP7YQmhSdykyKIsyV2Cc0AEyE/UVuhhCrRgFHiLn9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czKHaq92; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so27058325e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732711127; x=1733315927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHjB0FS8XpctltbckXhibhTVw5p/t9yVHsmxkraO6NE=;
        b=czKHaq92j6hF5wjIB3dT9vG8nv2j1iMhF+crtgiEilp4cmRT8Vz/hBsybI0BMfJ9G3
         r1Cbzsk6BJTipBGPzX6oWkfo3ROPciIeFC0CoRTfuH2q9F1ugnaeH4NfZIxsD94f9OlG
         C4dlkurArBpbdvZF0TXYbdHKFKS8jNydylpeELXydHD38gKASolIzq+Oyx0S8wwOvZfh
         DL7CAOhA7YjI2IvNqJfe+a6FyvNdOs3f5vf+/Eem7YHfrMhZrS6vlQzSM6c/bgErYJ60
         fssfodIdC2EKSN6h/wgd4k1w0CoLsHk/+drWpAKxZKUxioMfkRinyKuVJDPkENrU350p
         ZvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732711127; x=1733315927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHjB0FS8XpctltbckXhibhTVw5p/t9yVHsmxkraO6NE=;
        b=iTyqsTFkjL7UXercNL7gRCwHuPDpb+xx+zB1bER4p+RPZ/3Pod7O0wO7VGYD9U7P/d
         fibo12E/g7HjUJ0NQlwbqnsVvGnbC4PHF2+pnltgHTVp/4dL1KxjufacMarPs6eheAk7
         7hQtEcJpctvV7JsQsJfEUWx/gyHXUUggUY7IX0CyajKAkreoyi/MUhbuR+GvS6VVchgN
         h/rNEZdcRO/JIdmGBcYfSdVhuuLM0nKZzmj5P56h967poCpwLOerXu14dHhwb6kziQ2j
         ohMd9KH9La8eSBXtVuWCyAatlW0463WWH7Zn/Mb0Fxe03kQ3ozVsBvyAogn9L6Qkpx1I
         zNDw==
X-Forwarded-Encrypted: i=1; AJvYcCU+k3N+GZcrwJKHkmkBZDpfSmoBQSWq7hE0YdppsuJDTaz9mA/D3E6jD34liGhrvQBnEDwzZPwLA8YATi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJZGDycMmeg47dNoOuAYlWmIRW3u0bhR+SE8bgdMCCcrZzSim
	/LDFivHauk6qYyYaAKujYgH5KQTsylKP/bnHPLptpFJ62Zg683g3zZmsEx5FiNrO2yd0Cuv2AMs
	W36TFhelOgRw7sYeWDL4RDSVD9T4SHeXp/Gl7
X-Gm-Gg: ASbGncuXxPEZJxMBPya7Fb78ksNcNnRUzH6KMSIt5PTEtQCg65Cm3a8GwRVOS6IbrBG
	oWnAHgexcHlzKTISpW8ARxB7XEi9GgZxJJ3HEOfvK5FfQM03TcHHD1p8oBbloMA==
X-Google-Smtp-Source: AGHT+IGn2m8yJDcE/Dzz/61f9ciHRrx99d8i4GRYNDch74O8JfcQB+p+RQG8+bfMn1ARySVuPp8Pgo3KGaUZC/Ej4uk=
X-Received: by 2002:a05:6000:1aca:b0:382:397f:3df5 with SMTP id
 ffacd0b85a97d-385c6edd4fcmr2071742f8f.38.1732711126964; Wed, 27 Nov 2024
 04:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-6-7127bfcdd54e@google.com>
 <CAG48ez0V5B0ycPuP7eRA-xE88ks8cr+a1MFZC5emv_eAsybNAw@mail.gmail.com>
In-Reply-To: <CAG48ez0V5B0ycPuP7eRA-xE88ks8cr+a1MFZC5emv_eAsybNAw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 13:38:35 +0100
Message-ID: <CAH5fLghFezPeoPD57rXq-jy2wZBO0Bv6nSmU4OA6=hqeuGDVmA@mail.gmail.com>
Subject: Re: [PATCH v9 6/8] mm: rust: add VmAreaNew for f_ops->mmap()
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

On Tue, Nov 26, 2024 at 10:30=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > This type will be used when setting up a new vma in an f_ops->mmap()
> > hook. Using a separate type from VmAreaRef allows us to have a separate
> > set of operations that you are only able to use during the mmap() hook.
> > For example, the VM_MIXEDMAP flag must not be changed after the initial
> > setup that happens during the f_ops->mmap() hook.
> >
> > To avoid setting invalid flag values, the methods for clearing
> > VM_MAYWRITE and similar involve a check of VM_WRITE, and return an erro=
r
> > if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> > the return value results in a compilation error because the `Result`
> > type is marked #[must_use].
> >
> > For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> > we add a VM_PFNMAP method, we will need some way to prevent you from
> > setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Thanks, this looks really neat!
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
> > +    /// Set the `VM_IO` flag on this vma.
> > +    ///
> > +    /// This marks the vma as being a memory-mapped I/O region.
>
> nit: VM_IO isn't really exclusively used for MMIO; the header comment
> says "Memory mapped I/O or similar", while the comment in
> remap_pfn_range_internal() says "VM_IO tells people not to look at
> these pages (accesses can have side effects)". But I don't really have
> a good definition of what VM_IO actually means; so I don't really have
> a concrete suggestion for what do do here. So my comment isn't very
> actionable, I guess it's fine to leave this as-is unless someone
> actually has a good definition...

I can use this comment?

This is used for memory mapped IO and similar. The flag tells other
parts of the kernel to not look at the pages. For memory mapped IO
this is useful as accesses to the pages could have side effects.

Alice

