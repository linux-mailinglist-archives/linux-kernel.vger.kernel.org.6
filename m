Return-Path: <linux-kernel+bounces-521235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C301A3B9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473763BD936
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A81DFE16;
	Wed, 19 Feb 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StVso1oo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36091D63E8;
	Wed, 19 Feb 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957060; cv=none; b=ojx7/1vmDs8NtirMhSJCjc2QwcEUMdSlLm+Ot4qHq3nQ8M1No8jVWS1COKzxgqfO+iRlSNetZpHbUW6jNDEhnkjKBpLh9HXIRM9EOulSvNyuKdbqZiYPW/p4R8wq6xQPFsPrXaiV9Y3FySbd4izhuyrT+RgatK0kQfFOvXN95Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957060; c=relaxed/simple;
	bh=jiEWU0rM/r0YOGnhMn0CTqavsshglptprIK688rzVEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLXLTTE0ZlGVwZm168/YozjlNd16GC6LsjX3IfNrVd2CMtpXaOPB3SCY2ayPvgNHN3VFmpX5IpRtLGlJUHfvk1dKzk5hiIPpvRX1g8H8fzl2E/L4pwLkdvlYlP71YJKlfb6N7MIKSb1pdnHs7mUNm4xFmfz7agM4z8whu3J16AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StVso1oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B822AC4CEE6;
	Wed, 19 Feb 2025 09:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957060;
	bh=jiEWU0rM/r0YOGnhMn0CTqavsshglptprIK688rzVEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=StVso1ooh0uccS8QdlDZ5wLzVWRjloPAlErH08LDb7nFHd0LDQmN5as22l/KdZ5V1
	 hW+YQgzXhxiBff1tiHpVktYRH+51YEwBYIx0YJn6OCsQuo1bDfqY7aTIe3WNIZmvvf
	 lG74mEe01eHleaZASmKI0s/5WQefDgrqfHyTYv+KQd9NqoO2TOrwwjRsoFh0p2ZYc0
	 yUuGkSRo9l9Jz+GDkwloHSM9pZCTa1JRhrOnNkRATQF5lCDXl5Aaw4IIRt5pa84Cny
	 cvIu33FWL5BlW+Mv2SjH/sylMT+VzRT3w8CVZziw/uFjotjR1xHs+eJkTpVewACaQh
	 ulZfIxO5VieuA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: "Asahi Lina" <lina@asahilina.net>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Jann Horn" <jannh@google.com>,  "Matthew Wilcox" <willy@infradead.org>,
  "Paolo Bonzini" <pbonzini@redhat.com>,  "Wedson Almeida Filho"
 <wedsonaf@gmail.com>,  "Valentin Obst" <kernel@valentinobst.de>,  "Andrew
 Morton" <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <airlied@redhat.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>,  "Danilo
 Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/6] rust: page: Support borrowing `struct page` and
 physaddr conversion
In-Reply-To: <a204824d-2280-4402-b870-9db3e2e15aba@gmail.com> (Abdiel
	Janulgue's message of "Mon, 17 Feb 2025 10:50:28 +0200")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<Z6CY4TvZwLkWmB3I@pollux>
	<a3551d7d-14c7-40a0-90ff-1fcce93be62a@asahilina.net>
	<cae5503e-4330-4c44-8a50-1ebf63ea5a24@asahilina.net>
	<XG7vFvm1LjZiRjXm55DgLGvzsoFsJsk1s6-1T2uKilk9MghGYKSsf5-vcDnbpDMfuePjbxm3u8fQBhFnJhRKfw==@protonmail.internalid>
	<a204824d-2280-4402-b870-9db3e2e15aba@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 10:24:07 +0100
Message-ID: <87frkacmo8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Hi,
>
> On 15/02/2025 21:47, Asahi Lina wrote:
>>
>> Given the discussion in the other subthreads, it looks like this is not
>> the best approach for page table management and using it for crash dumps
>> of arbitrary physical memory pages raises some eyebrows, so I'm going to
>> abandon this series.
>>
>> Abdiel, if the first two patches are helpful to your work, please feel
>> free to incorporate them into a v4. Otherwise, just go ahead with
>> whatever works for you!
>>
>
> Thanks you for improving the series, much appreciated! I will try to
> incorporate your improvements.
>
> Btw, I'll most probably pick this up again once I'm finished with the
> rust dma coherent allocator bindings.

The series has application in `rnull` as well and I will probably add it
as a dependency for next version.


Best regards,
Andreas Hindborg




