Return-Path: <linux-kernel+bounces-544038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B6A4DCAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5713A462E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57631FFC69;
	Tue,  4 Mar 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G23jRXAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DD1F150D;
	Tue,  4 Mar 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088112; cv=none; b=rYQWtJmq6AXllTdK5A9igeZ40strM1J8ra0oolQZuKhKRK5Sqlj3jsl9d6V+d7pKAAKKKdalLIgXw0JBXW1Mz/olluYQRfnr1A+cRJylxhvaN9RuRdwGR3IcDYZyjmvIjClKsGUtd6T7819XpirbXV5P1JXIy1SBYw9pXp9Pmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088112; c=relaxed/simple;
	bh=zacHG8fP3D/hmNJCwvqEbGptVGdfYUkGYzxjtuIKA6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTzekS+nWjvGdappSmo3I6LLM4o04xqoQ+5Te/atsGIEDdU9w848OHU/jAixnfS0WiIMtc8UHfk677JaVkHJz8E5I+kJKHJD1KuIfQXxXeUeEWF4k+GERPug3zTG0SsoU/rpK1LtJlBnhqLPrtfGvPkmoFId4fiu94fRPz5SdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G23jRXAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE08C4CEE5;
	Tue,  4 Mar 2025 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088111;
	bh=zacHG8fP3D/hmNJCwvqEbGptVGdfYUkGYzxjtuIKA6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G23jRXAJseMjDMk7gCnjGQphqADBG0QsFBko1uNacx2aL5PeuaH69LRwemrGugyrU
	 PN1AkfUmF8PEQ0pxx7wAs6TW2nxCkW/KCV2f2xTqs2O7CSLSoCuS22lIU4EdxTTWQ1
	 A3jQnJJ/pN6w2FLTdkrQiaW8Ne48HO2C7w/h0jNsciL5FFYe4IVNRLwLesOy6+3BoV
	 uVNw4VPUCvOFLyFiKrCIPgtC76EB0mRcwAz7i4oR7J0Zf36P9YKPUyPCVnnKaqwuFw
	 hUkb9qzBy980bHPzexDGjD/55hSav6orbCdvxJeDtsfCPa7Zj2b4AyERCj+3wL7BjN
	 XY1F+25xsIMEg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,  "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Matthew Wilcox" <willy@infradead.org>,  "Vlastimil Babka"
 <vbabka@suse.cz>,  "John Hubbard" <jhubbard@nvidia.com>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Arnd Bergmann" <arnd@arndb.de>,  "Jann
 Horn" <jannh@google.com>,  "Suren Baghdasaryan" <surenb@google.com>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>,  "Balbir Singh"
 <balbirs@nvidia.com>,  "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
In-Reply-To: <33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local> (Lorenzo
	Stoakes's message of "Fri, 28 Feb 2025 09:49:02 +0000")
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
	<CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
	<c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
	<CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
	<2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
	<b6b5tnaw6vnuib7nzcm7ajszxiptqz3i2hex5yengzbsirztks@l3coijkqwtpb>
	<CAH5fLgjMC2Q1tjuVtbhMvU-pmEsn1Ai4=AAB3Tm8HTWi7PFHfg@mail.gmail.com>
	<30ffd737-d0aa-44aa-a647-686e536ac548@lucifer.local>
	<r3iEw6cWkz3wBoUc9l7we40uuvdTVbQBJU3rWXKQspv1GfvviY_0pYLyFtTJPBP0VeofvKHx8-l0WHFT-OQfcA==@protonmail.internalid>
	<33e64b12-aa07-4e78-933a-b07c37ff1d84@lucifer.local>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 20:04:19 +0100
Message-ID: <87h64ahr64.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lorenzo Stoakes" <lorenzo.stoakes@oracle.com> writes:

> +cc Linus
>
> OK since Andrew seems caught up with other things, let's go ahead and propose
> the entire thing to make life easy.
>
> Could you send a v15 with any fixes (don't think any are necessary now?) and
> add a patch to add this to MAINTAINERS in the alphabetical location:
>
> MEMORY MANAGEMENT [RUST]
> M:	Alice Ryhl <aliceryhl@google.com>
> R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> L:	linux-mm@kvack.org
> L:	rust-for-linux@vger.kernel.org
> S:	Maintained
> W:	http://www.linux-mm.org
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> S:	Maintained
> F:	rust/helpers/mm.c
> F:	rust/kernel/mm.rs
> F:	rust/kernel/mm/

Probably a single `S: ` entry would be enough?


Best regards,
Andreas Hindborg



