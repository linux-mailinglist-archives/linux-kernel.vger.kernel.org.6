Return-Path: <linux-kernel+bounces-422863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91279D9F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C30CB221C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365961DFDA8;
	Tue, 26 Nov 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ3C0bhF"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056D1ABED8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659007; cv=none; b=noSnGVmfGJPS/z4OdMORy/UXiOxhI2KXeYt4iuaRphMOVz51deX2/Yius6pe9hBFpn4I+YrzWorfKD6gNfwIBL0+EoSs4bN6TZOoneY1tQwXBdCMiXmdwHL6jB3sA2zuusCidVznsJSAT3cSjTuPRvVu3bGpuPWGjF0uRzoBFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659007; c=relaxed/simple;
	bh=gD/Fl58jPDD02j64XV/US3xuNiNDOo0k69sMnhhKohA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R90GNbHp7bh4pK1iNCMf8k4OjCLtWdrN+vlOFN1kRlUkiKpvo1cPkRTp9jvyyYb0q0groS7qD6ave4w/ak/6eO2jFMFGHF04c9iy88UROH+/oJjatr5U37gi64JgRhkr2qPlhMHIosB7Zn0a24xRWEZ69HgvxWhlZyvXD0DkK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ3C0bhF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so1091a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732659003; x=1733263803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTHMkYV876MVEV7+UBcdVp/IpT8KJSz6LBKIAJTo1ww=;
        b=XQ3C0bhFLtHdyWeNSP9Dluiw5QDApkc7gnAdBZLxk9T8TiL6k9QuKSDAm87UPDM2XY
         oifh9LMFZLUDACeJromyi/em2asLh5LUc0GCTiBWyAnemRVXnuzPW/fNs5wmeFFk9Ft1
         6WEK9xGX+dlJpO3rvIdeOHFHrjmQ8P45lODxWS+MwYKMWKJWpZiO+pboFxJFeP8FkIn6
         aEinyKfisajHoPcmaX4lsFdnTVOUj0LwWwHfdKwCOv3A5yj1XmReiImpCW0HrUkTui8v
         GkCrpPT9o88ndjKvZPuK+qRvH3Qf0BPBX4weeubYlf78hQ9PqYWQRXr2MWM0WU4zCsck
         JTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659003; x=1733263803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTHMkYV876MVEV7+UBcdVp/IpT8KJSz6LBKIAJTo1ww=;
        b=ptVusomAaql1TQzjWC4++LbF6BgD8r9VfnWZROoAEhriuPu04wGLrpNdrXq9jBKZB3
         PDAjZvCZuedFMmjMrvpNCE+NWlFkTacLYxQ1YXZZ+pvUkgvKcv99ptn4XFhHm8S0TWAk
         bxEZmO/9yiNefLQ+qDJYjRyWGV06low45EgXL7Cd6zSsfW3pCZQ71XQAM0cQ+DqBjfmv
         rzyhg2MLpQ8gNWne3Tr8oOTzQ+GV6rAL3EHvZ5KoarPLgxonhcUaGuSQRgtWz96QG1/+
         9HlRon/4FnQRXukixpVGOpZXqF3cZAkrPVzdNqkAPew8hXR8oduIdUQA0pq253osK+91
         NsQA==
X-Forwarded-Encrypted: i=1; AJvYcCWSnKlBdECWVUWOKxiOyJ5yYDcSFYP1eiT+/lg7+kQic3qtdU6/ockhHBmXIocJjIEkalSZlfl83JWpeTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Mym+rDD0WQwLukpBucDQP2+bvoIXyAnR/7W2aFs/dkj0iJAI
	nQtKYr1PWzam8cvHGdDV83iGWwCRtFmlbOPAoOJrISUOSyQ6lMzYaOmteXFiUfy0JS9BI81jhR3
	J3fEKmxz8GE47X5umF+hGWmzwKUN+EScZ8pkQ
X-Gm-Gg: ASbGnctMx/rFFkG/Hogjy466WbKHvsosiFsLpNItm8hy6izlaHTjG1xjzA/MmE6a69L
	vvseYsYbqa3vEADIxragRCULKNawx5LcmGTiP4hMBT+L+7gb/G46sThcS1s0=
X-Google-Smtp-Source: AGHT+IE2cdAOzjSAFTZV8v2SjKZv2gEDrSa393KXeU/LpDA2nLaDQHfynGcUNHb+iTrSQ3oWWXDj511vbJbEcsHiScM=
X-Received: by 2002:a05:6402:1774:b0:5d0:78d0:f845 with SMTP id
 4fb4d7f45d1cf-5d081159fccmr24776a12.2.1732659002867; Tue, 26 Nov 2024
 14:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-2-7127bfcdd54e@google.com>
In-Reply-To: <20241122-vma-v9-2-7127bfcdd54e@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Nov 2024 23:09:26 +0100
Message-ID: <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] mm: rust: add vm_area_struct methods that require
 read access
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
> This adds a type called VmAreaRef which is used when referencing a vma
> that you have read access to. Here, read access means that you hold
> either the mmap read lock or the vma read lock (or stronger).
>
> Additionally, a vma_lookup method is added to the mmap read guard, which
> enables you to obtain a &VmAreaRef in safe Rust code.
>
> This patch only provides a way to lock the mmap read lock, but a
> follow-up patch also provides a way to just lock the vma read lock.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

with one comment:

> +    /// Zap pages in the given page range.
> +    ///
> +    /// This clears page table mappings for the range at the leaf level,=
 leaving all other page
> +    /// tables intact, and freeing any memory referenced by the VMA in t=
his range. That is,
> +    /// anonymous memory is completely freed, file-backed memory has its=
 reference count on page
> +    /// cache folio's dropped, any dirty data will still be written back=
 to disk as usual.
> +    #[inline]
> +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> +        // SAFETY: By the type invariants, the caller has read access to=
 this VMA, which is
> +        // sufficient for this method call. This method has no requireme=
nts on the vma flags. Any
> +        // value of `address` and `size` is allowed.

If we really want to allow any address and size, we might want to add
an early bailout in zap_page_range_single(). The comment on top of
zap_page_range_single() currently says "The range must fit into one
VMA", and it looks like by the point we reach a bailout, we could have
gone through an interval tree walk via
mmu_notifier_invalidate_range_start()->__mmu_notifier_invalidate_range_star=
t()->mn_itree_invalidate()
for a range that ends before it starts; I don't know how safe that is.

> +        unsafe {
> +            bindings::zap_page_range_single(
> +                self.as_ptr(),
> +                address as _,
> +                size as _,
> +                core::ptr::null_mut(),
> +            )
> +        };
> +    }
> +}

