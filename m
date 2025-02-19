Return-Path: <linux-kernel+bounces-521135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE159A3B4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E403B7734
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B81EB1B2;
	Wed, 19 Feb 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdiEO0bX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA1C68B6;
	Wed, 19 Feb 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954296; cv=none; b=Y7uwBMyamSCeaPsIKNd3IMoBkGfgggBwVkTgnJdXbqEC7mNrjS/uarlvQbPScAYPCCQ4znqFx2WoLJP0TxU46zYr+51a5+SU54JgTwk9wg9/jPCgBs+noArfcMCPITKXGQsTM4+e93DgsZnc3zNGvo/Q5MOC1d11+rhsOdAmXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954296; c=relaxed/simple;
	bh=hk/K7Xy7+TFm7X+Cn6nnIxxhnI2tKh7frk+g37U2Q3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oE5MkctxSTRK9AkGKLU4AG22Jb+lJhoELxRWwHwfRURUSOeOkj+o/yLHLEL6dsk9iffm/HhNXm0HOOEkfOdThZYU5tpbPHw7pr2thBjxpu8BNE6He4rMPT1v89kVU9jSNPSWt3Or88X/p22/LBQnVzzCnDshUd/vdrOsfR95VsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdiEO0bX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9381CC4CEE6;
	Wed, 19 Feb 2025 08:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739954296;
	bh=hk/K7Xy7+TFm7X+Cn6nnIxxhnI2tKh7frk+g37U2Q3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CdiEO0bXmEsZKXKRm0QcP4p39t9yOvQaGKeztiXyCnaLcA+iLGYNj3M7FDnz60HT0
	 IlZRSHn5bf8rt8snl1f97UsInPv0X+dtmdiwfqW/Son+bpG512eW8srjisHQ+NjyeA
	 Lht9aAWWsN1fkZlJAXCyBovI6hMUp6xNPciTCEdnTUbXl631eqHtSVunWCVtcEPCFF
	 c4/pGLrZTSqfoIZs62RSylT05bhAGNYWhluDhB3HmOeJqaHpuz5MRXYBs/Lh2554Yu
	 W8M5soPpqrgv4BpgF2eAI22kg6QjPB2eHie8rS5eNWykXdgBjMe7qGYuVMs+jf5xK3
	 jHy8G32JIuT2Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Asahi Lina" <lina@asahilina.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jann Horn" <jannh@google.com>,
  "Matthew Wilcox" <willy@infradead.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <airlied@redhat.com>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>
Subject: Re: [PATCH 1/6] rust: types: Add Ownable/Owned types
In-Reply-To: <20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net> (Asahi
	Lina's message of "Sun, 02 Feb 2025 22:05:43 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<VqpY5D3uyf3txHBNgKZ7F-R6-AjemjEi3R2pH_tiaqEKbp8yxfK4YSqd6TxwvBrZ-MgC-xMbGufMlhXj8_ZWAg==@protonmail.internalid>
	<20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:37:50 +0100
Message-ID: <87h64qe3dt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Asahi Lina" <lina@asahilina.net> writes:

> By analogy to AlwaysRefCounted and ARef, an Ownable type is a (typically
> C FFI) type that *may* be owned by Rust, but need not be. Unlike
> AlwaysRefCounted, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>
> Conceptually, this is similar to a KBox<T>, except that it delegates
> resource management to the T instead of using a generic allocator.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Over all looks good to me - I agree with the points already discussed.

Could you put it in a separate module and file? `kernel::types::ownable`
and then `pub use` in `types.rs`. `types.rs` is getting quite busy.


Best regards,
Andreas Hindborg



