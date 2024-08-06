Return-Path: <linux-kernel+bounces-276489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877694947E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAAA1F21D6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B923776;
	Tue,  6 Aug 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R0HAhSGI"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5686182D2;
	Tue,  6 Aug 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957968; cv=none; b=A+iu0WBdyO3fO3iFu7i5ikDTM4vJTWIUgcWmf0M68/iudJbPiJjFvfDmyEoJ6ksT1E3pUjHDxWncqc/JOugUDtEtw0O/ntvX3mbBTfsrsFh81O9wKqPSgu3noIGLd+9P5uqfXP6ZMGfpigsRjaS7PcCATbGexjHHaC1TQ27igTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957968; c=relaxed/simple;
	bh=s+m3LBTTxg2FPDkOau9oSy/qOOl+HkSTREA3RvxnVv0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3bQuq2SABU9WhJuuEUyEx/O1es5UGSuQZZiv5w0uCVj3Rmu9OL6Wahfe91o7hFGy32AZ2T8CXzpRuuw+JiUuQg/ispNHnuiFH7vh1xwPD9sNEMokMiARPmldg8oxNm08EFvxIEXanDbr8P6WgnHkyBJxRqR5z+cwxcqb1TmI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=R0HAhSGI; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722957963; x=1723217163;
	bh=XSaCQ3gf/32m+amYfxQaMwG709hH5XxLGDSG2DRE9ic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R0HAhSGIulsploBVF51ODy3krtHeF10KlXylbj94aF9w/wopX4gt2FvsWUshzpCoT
	 oBA8alfV4IT0leFrt9lOIpo+tZrmovmnpWQYhuHHkzO75vzxO7T3sPVLj262Le7yHX
	 ji2Kt5zDAtdBS9RBimIoAlcvYT+DOZdsYwt+jkwXI1dbS+tP1j/hYCcq6pn2Vc+7tp
	 wkwf+LGi8cC5XJrWd1H6/vWJooywtrV6uuQYYJOWe2DXXolqDtyR/kS8hsT0SdRuVB
	 TaN8DeUK2vFvQtR5ayAg4b4K+Bifozjx8bc5HkwgZ2gbdFZyn8P42PCKFHO3iq8Csk
	 ivMfgd5eJ7R+Q==
Date: Tue, 06 Aug 2024 14:44:57 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 06/10] rust: list: add List
Message-ID: <61664041-3b15-4cfa-b576-f2b1f785888f@proton.me>
In-Reply-To: <20240806-linked-list-v4-6-23efc510ec92@google.com>
References: <20240806-linked-list-v4-0-23efc510ec92@google.com> <20240806-linked-list-v4-6-23efc510ec92@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7d583b71b82415f0bcfdb8aae935fc84b8ec487f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 15:58, Alice Ryhl wrote:
> Add the actual linked list itself.
>=20
> The linked list uses the following design: The List type itself just has
> a single pointer to the first element of the list. And the actual list
> items then form a cycle. So the last item is `first->prev`.
>=20
> This is slightly different from the usual kernel linked list. Matching
> that exactly would amount to giving List two pointers, and having it be
> part of the cycle of items. This alternate design has the advantage that
> the cycle is never completely empty, which can reduce the number of
> branches in some cases. However, it also has the disadvantage that List
> must be pinned, which this design is trying to avoid.
>=20
> Having the list items form a cycle rather than having null pointers at
> the beginning/end is convenient for several reasons. For one, it lets us
> store only one pointer in List, and it simplifies the implementation of
> several functions.
>=20
> Unfortunately, the `remove` function that removes an arbitrary element
> from the list has to be unsafe. This is needed because there is no way
> to handle the case where you pass an element from the wrong list. For
> example, if it is the first element of some other list, then that other
> list's `first` pointer would not be updated. Similarly, it could be a
> data race if you try to remove it from two different lists in parallel.
> (There's no problem with passing `remove` an item that's not in any
> list. Additionally, other removal methods such as `pop_front` need not
> be unsafe, as they can't be used to remove items from another list.)
>=20
> A future patch in this series will introduce support for cursors that
> can be used to remove arbitrary items without unsafe code.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs     | 330 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  rust/kernel/list/arc.rs |   6 +-
>  2 files changed, 331 insertions(+), 5 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


