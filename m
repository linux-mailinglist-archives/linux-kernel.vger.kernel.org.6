Return-Path: <linux-kernel+bounces-422840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DBF9D9EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B923628195F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23B1DDA24;
	Tue, 26 Nov 2024 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwpMYCz6"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6E1DF996
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656607; cv=none; b=E6iiGg4kxRjJi6+pxfam6qAgSfp7c0ijTz6Jv/t0qCtzjEd2oW+Cv0+aQCrGeheFPw2R1lT8Nmm7sn8TftgwBTHcRvZVhwEL7Z8yZ7U9U9JTQfoYxoG5MhsJA2unl4MQF5NfsCJtnsyofQmKWLbo0WKj5HcGMLaWkDOb6Ygz62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656607; c=relaxed/simple;
	bh=KmNk5xOk2Kue+fgxNIZEq5vIeht0l8CGghCJU2wzAfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ok6obCh/tHf4LNwjxVxu2HoyDzVSxNi4W/Hsrys+EPI886loW/05ySpJxKjjkaYLO1BMmbZX+qfRNsBAqsCBGFfRy4LehqtyT2HGnTgbQ0cKSsWZiCh8eA9LIawtpRsPrj7FfYAgtB7VmgPLiSoMIQaqpu5viYtYkrI55MjQHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwpMYCz6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so328a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732656604; x=1733261404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBRiUmH5cK1KW9rqacSmoJx+dyswngEhwrAEnw8m73s=;
        b=HwpMYCz6/J3ckOmnlzh51owF8WcdswYtqL8WDIJSvpriu2RNBEkL9FfbedfU1p2Aa8
         Vyl/ZJ72aJwtrMY/Gh5W3fVlCmeA5Q4bt9+4mc1AH9usLri2O0JNlEMu7WpsMOQesf1m
         DQ6UPVsaCAk4CuUouIrpGbBTC4XVNvDYw1Q18fDWFkilFb9BLjfWLiYqucZCqK84+ZrA
         VMPQ34dpkirz11DGdDElpoDy3pK0sHSDa3KuCFxadj+bC8HZHA2AavYRoFkB+YyB04TJ
         JdNaIKzieYc0XmZULTurPrqGBG/S0Qzb70j8oGqcNrLUeCcKsUbeZpodRVi5EktKTMWA
         I7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656604; x=1733261404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBRiUmH5cK1KW9rqacSmoJx+dyswngEhwrAEnw8m73s=;
        b=KVJ7cbqZ8BB74BnwK1KGJRMJr326mVlYZDxVuawCmE1xAkrHc24hk4T9BPiS97ANdg
         ytwjAads23m3TeEYOkr8Mgz+/lwcYOABpVcnQS0OZq14oGxxV3D5J/WJUcoq88yXBRXY
         +tEidsI37bQxIt4kv/4A/X6LVG6tehjPWowdwd6aZfgnNAUgjD0AHbm1o5hAI3f7jG1H
         uwvDp+SBx9wzuZqfH74gScBY/ub/Wi9zYc7tPnaCAynA2BrsTs38VlK6d/+s1rsxfROf
         A3ME4QIFxLFQ0HWgknwAqQX372bqC+0WXbKabnPY0UkEJLrPHZann//dgtx/6oKUROP7
         kYog==
X-Forwarded-Encrypted: i=1; AJvYcCXmglp4hYSIg7AY0PxiHmBcbX3744Oi6pEH3lEQjTr99Ah1YEVvCQX86N5/oqCH/ys6HPomHosdHxFp3co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6V7MC2EEaB7VHQqgEcZxaogmOSQbgPAE4snXpFUeEo3eu8Y4
	bO0/89kH6gw6ckr68zPHFtAe5XuTPpo12psjuYPpmwqVHa0A8lmVfXOnh8ye/fyCQIAU/B5GS0z
	PAbSrSITcqx2CZU9UU05I1n8GD30AA0MXISQQ
X-Gm-Gg: ASbGncsc3BQ/zkMol/TKMNH7PguKmqax71M7XGQ4LHo25b6uETV3fyH8r3+8xnUpiVp
	Baesr78SpmQJX8gvzJnjv4Xy4iJFkbHq9ZQ1Do4uITr5cNWTDP7e1gaicrxQ=
X-Google-Smtp-Source: AGHT+IGGQKkkUZxUMrUHr4jl8Bz6Q4s3UsJS3XnfpswWphcVs7mNeidA9bI4rEX/3MP/EhElClBSv9DdpnmMbSwW+Fo=
X-Received: by 2002:a05:6402:394:b0:5cf:c23c:2bee with SMTP id
 4fb4d7f45d1cf-5d0810ab5cemr20794a12.0.1732656603448; Tue, 26 Nov 2024
 13:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-6-7127bfcdd54e@google.com>
In-Reply-To: <20241122-vma-v9-6-7127bfcdd54e@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Nov 2024 22:29:27 +0100
Message-ID: <CAG48ez0V5B0ycPuP7eRA-xE88ks8cr+a1MFZC5emv_eAsybNAw@mail.gmail.com>
Subject: Re: [PATCH v9 6/8] mm: rust: add VmAreaNew for f_ops->mmap()
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

On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> This type will be used when setting up a new vma in an f_ops->mmap()
> hook. Using a separate type from VmAreaRef allows us to have a separate
> set of operations that you are only able to use during the mmap() hook.
> For example, the VM_MIXEDMAP flag must not be changed after the initial
> setup that happens during the f_ops->mmap() hook.
>
> To avoid setting invalid flag values, the methods for clearing
> VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
> if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> the return value results in a compilation error because the `Result`
> type is marked #[must_use].
>
> For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> we add a VM_PFNMAP method, we will need some way to prevent you from
> setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Thanks, this looks really neat!

Reviewed-by: Jann Horn <jannh@google.com>

> +    /// Set the `VM_IO` flag on this vma.
> +    ///
> +    /// This marks the vma as being a memory-mapped I/O region.

nit: VM_IO isn't really exclusively used for MMIO; the header comment
says "Memory mapped I/O or similar", while the comment in
remap_pfn_range_internal() says "VM_IO tells people not to look at
these pages (accesses can have side effects)". But I don't really have
a good definition of what VM_IO actually means; so I don't really have
a concrete suggestion for what do do here. So my comment isn't very
actionable, I guess it's fine to leave this as-is unless someone
actually has a good definition...

> +    #[inline]
> +    pub fn set_io(&self) {
> +        // SAFETY: Setting the VM_IO flag is always okay.
> +        unsafe { self.update_flags(flags::IO, 0) };
> +    }

