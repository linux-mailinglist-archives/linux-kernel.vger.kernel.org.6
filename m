Return-Path: <linux-kernel+bounces-447517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82059F33AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB014164672
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACC204F8B;
	Mon, 16 Dec 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvnLNeYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA51487E5;
	Mon, 16 Dec 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360663; cv=none; b=SldAx4EYkASCfIsAeXDUOk+oi6dglmZ6JUHAIWcfMDiUwP8z/l8P2CjJggTH6Ej9hZ1VeS/iaVjrl8Io8PDPj33Jh214Y6iXM/BGKkxN5p7AJmDei9a/xhELlSoTlQo/SgET001s2kcPV4izikcp5A7WcvWEfMw6Y+6TK0SglR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360663; c=relaxed/simple;
	bh=XTXuUO4aBKnsu6RlrhoKNi7uAGfKpJaoy/LLiehShL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFm0btGpC+UEi0/KnYt5HZTi5nt8ukYi/QsS/7SvikT+ifv+Ds0NP118bu6cIZnfUoVnSvk/fs9xBGkzgA/EP9JxyuOMw3eWw1h0gj/b7So+jdyTVEU9uZKj1nlTB9JCR0GLPlFe2cB9wVfEBf7nUjcWvZn5m2DwJIUFMwA4k5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvnLNeYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105BC4CED0;
	Mon, 16 Dec 2024 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360662;
	bh=XTXuUO4aBKnsu6RlrhoKNi7uAGfKpJaoy/LLiehShL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RvnLNeYDgZc69r1Wb+U+sa1LklxVpJgX3RCE3Zq3sx3jMiesF49M82A0w46y05CH4
	 Bn93v93TrxhFbRxps5Fry23So0WIlaNH5Jqm8HKDdcKJHhUk7KRKqFjCHMnXFE0A3Z
	 FHg3k7ypk4oQgxGNAcVsEyTGNXcGhYEG9tnE5kcezoRZ8ORELKe6TQ5CPJV9J81il1
	 QQsgEV5hWXuVfGQp4+zoDxIFUBWN50yHGcJrJfAB5b6fTNlfv++F/lLPXu1ElRxkBz
	 33Asya4gTt9/l6Eu2uiook4CPdj3WJShVtM5yQuS8kGoleAuwcUIb2KGkX+RjjqtjL
	 DYvN7t+2ZLdxg==
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
Subject: Re: [PATCH v11 5/8] mm: rust: add mmput_async support
In-Reply-To: <20241211-vma-v11-5-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:09 +0000")
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<HlSjKVLowJx8jJu4bSrIYUhfDdz2BNKq_aDlV2KVN3qUCtQAThvoI1yygvnEMZwKWnT1yrJ2V2YTwcG6aQO-uA==@protonmail.internalid>
	<20241211-vma-v11-5-466640428fc3@google.com>
Date: Mon, 16 Dec 2024 14:10:47 +0100
Message-ID: <87seqnai3s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Adds an MmWithUserAsync type that uses mmput_async when dropped but is
> otherwise identical to MmWithUser. This has to be done using a separate
> type because the thing we are changing is the destructor.
>
> Rust Binder needs this to avoid a certain deadlock. See commit
> 9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
> details. It's also needed in the shrinker to avoid cleaning up the mm in
> the shrinker's context.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




