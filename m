Return-Path: <linux-kernel+bounces-447525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C895E9F33C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED471888B31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE4207A14;
	Mon, 16 Dec 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpZJl9b1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8214B94C;
	Mon, 16 Dec 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360685; cv=none; b=LP3zWvlYUDkGz3zwxFKYzY9uMbw91JDOPtr9yOIET1tHXCUfx36R8chH1EVka/JMDP3ZureMRhR9jbt6uQWRjP+K3GVQepVDhShyJfCpQ77X0rSepyMwMSAls+ueJzzP1QkCViUQ1v44/qUn/L5VCuKsohPDjF8w6txTX2aJ54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360685; c=relaxed/simple;
	bh=VSQZ/AKwvf2LJcrZzL1IDApIqfRTSAFZpSCwFSSlC/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBJyZpZsdr4vYYeFbaUwEwAHIpTMkGuM4rE0x0NDslvWtreNVaJ21Mr9h/kNyKgE5QptSLIIE2Hh4Lt+nzcOW4tiQwh1VniIeM0fVzsG2Ql+NY82uAW9FKyz4kAUz6FY2J9Ey3kqokJRoMocKCJTK+6bVdSVipTfs7y2af/ZqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpZJl9b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A682C4CED0;
	Mon, 16 Dec 2024 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360684;
	bh=VSQZ/AKwvf2LJcrZzL1IDApIqfRTSAFZpSCwFSSlC/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hpZJl9b1YQB+3WKmUm0rX90tuDV8nxkw5nJZe7Clo2lj4LRzqvvUe4YDNJsoCBEWs
	 zNUxpwjKfZTHighicJ246cMLpKHw8Gg6xBYUffQNizkYnjaLljZLEJq89WzMuXuFwL
	 /Sss64Sp8cinXbnVMCg3Pz1r+tMH+FJcuq8vIW3DqbekSLqthiC17A4VGxNNjhCegQ
	 01jBku9es2bEHp/ElRFw+Vsmz3CeNL0hdZL3JeSrnsSJKXwGrCazsUJaSpOy6nKqw1
	 kJBOz32mcdjNs0D1Ek2vd4yJOgkgoP5amuCFe+NeXkEF4TS7RTNlqU92MXapcqrHnj
	 6p0cTs5yIWrOg==
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
Date: Mon, 16 Dec 2024 14:41:00 +0100
Message-ID: <87o71bagpf.fsf@kernel.org>
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
> @@ -6,7 +6,7 @@
>
>  use crate::{
>      bindings,
> -    error::{to_result, Result},
> +    error::{code::EINVAL, to_result, Result},
>      mm::MmWithUser,
>      page::Page,
>      types::Opaque,
> @@ -171,6 +171,185 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
>      }
>  }
>
> +/// A builder for setting up a vma in an `f_ops->mmap()` hook.

Reading this line, I would expect to be able to chain update methods as
in `Builder::new().prop_a().prop_b().build()`. Could/should this type
accommodate a proper builder pattern? Or is "builder" not the right word
to use here?


Best regards,
Andreas Hindborg



