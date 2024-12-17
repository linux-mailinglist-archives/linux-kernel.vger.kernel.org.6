Return-Path: <linux-kernel+bounces-448950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090779F4796
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853571885AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46C1D45EF;
	Tue, 17 Dec 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbpo9mDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4F481B1;
	Tue, 17 Dec 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427878; cv=none; b=ne98dj51dF7URqI3CxURQTUVxpYqInQfM9zP3ZGY51lms+AJDr0VSWaUbhYb321RuBXw2U5zktBAKpD8OxHba1Rmy7QntnaimBbvaPRixecgcIh4LVO974udt4Ffyy5vilpfiJhnoaJVw8X755Ud++4BzUMjFB0gvUgFq9t7dxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427878; c=relaxed/simple;
	bh=ervJxKyQZmVDHzYCEh7bR4br9+een6B1D7MUqP8OFoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UBdhqelzFvzYglUIC5eN3Wkke8IsvgRzSfPVD9092wK5Tz+cR97bgvxe2/hUZMpnW/qwcuVr5kB3yMY+VpB+NIv/Fp4D60P7gh+4iT72eAkNe3qIPVxC5TFPG25cBq2cP8VU1pQ4ZBW56cyMojFZEe6U5A6jZNxw8xxMUJePdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbpo9mDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FFFC4CEDE;
	Tue, 17 Dec 2024 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734427877;
	bh=ervJxKyQZmVDHzYCEh7bR4br9+een6B1D7MUqP8OFoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Dbpo9mDeoh+GbNtjrusvndCYMBEWAOy60nGCeyZmQxE3yKllcWLkyAyrTVbJXi5iR
	 g2Cg3DVc/Aqx0g3hgkoFZ5cz2hEov9lerHg2NEqYOtqmS3TCCM80+I1xKckC7EP0f7
	 PR21PUrg7hI09WpVZUorjWjdqmNR5H8kte58vOFN5R1DnTaOlQIKqU4iB+wGVjY2lh
	 GT6gOGJxS5GTi2MBjUY1tN4ZQw/iorCyG30PDZdOKAkUXkM2mydvWBEy1W3HR8o5Qy
	 HtptbJdAbB9y70qc0ZYfQ0BguM+IodOuQvZgo0jm6GrVSCF3HbKVSsjGkWBtwlZUPf
	 SOZEbM2x9FPSQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
  "Vlastimil Babka" <vbabka@suse.cz>,  "John Hubbard"
 <jhubbard@nvidia.com>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  "Andrew Morton" <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Arnd Bergmann" <arnd@arndb.de>,
  "Christian Brauner" <brauner@kernel.org>,  "Jann Horn"
 <jannh@google.com>,  "Suren Baghdasaryan" <surenb@google.com>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v11 6/8] mm: rust: add VmAreaNew for f_ops->mmap()
In-Reply-To: <20241211-vma-v11-6-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:10 +0000")
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<f8bp5f3T5_3_0LpabBpwjSarzhZTp1CbAvcTBI6lHlaKpPAAFiofsNI2iJxK9kuXwnqvTkky9uvpS0rqRpa_RA==@protonmail.internalid>
	<20241211-vma-v11-6-466640428fc3@google.com>
Date: Tue, 17 Dec 2024 10:31:00 +0100
Message-ID: <87zfku8xm3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

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
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm/virt.rs | 181 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index 3a23854e14f4..6d9ba56d4f95 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs

[cut]

> +    /// Returns whether `VM_READ` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as readable.
> +    #[inline]
> +    pub fn get_read(&self) -> bool {
> +        (self.flags() & flags::READ) != 0
> +    }

As an afterthought, should we name these getters according to RFC344 [1]
(remove get_ prefix)?


Best regards,
Andreas Hindborg


[1] https://github.com/rust-lang/rfcs/blob/master/text/0344-conventions-galore.md#gettersetter-apis


