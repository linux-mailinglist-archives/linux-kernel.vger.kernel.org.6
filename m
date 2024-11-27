Return-Path: <linux-kernel+bounces-423929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC19DAE60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339B8B2343E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C88202F80;
	Wed, 27 Nov 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="uFOe5vKS"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910F12E1E0;
	Wed, 27 Nov 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738355; cv=none; b=Nd2bqw3M6ESrp+/X4UCRgxVARuWy9n3cNekUf5pVoUKNasn0f4P6EC141ECUwj323nuWiC7mwIwgQ43ddvd0MxkJ/nq1kGFGAqV0xLOVUW9PKq1eUjbqDCY3+CbzhdwndPZp0WeQpEGRIPZlXZF/tNguaA5UYY4lK7eUxxFPnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738355; c=relaxed/simple;
	bh=XDze5BzIzCNZR7KMe2eXuyj/wuaMcOLy05uMmzAME1A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gPSDxG3+YUcobadiDD0ZhFuDS+5vUpd2IWJamUZM4c10RQHmtCnLmoXH619aPWT6jlFxuhsT/LdzDtsi37Xd3fApcPk+Wf2XoQ6ubUHtG2xaJGsEROWPlVxAsty3IHw1ZXwvICddjEvegVFeddP0LAErS2lLo7PC1Qwulw7kwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=uFOe5vKS; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 54B7D3F504BD;
	Wed, 27 Nov 2024 21:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732738351;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=XDze5BzIzCNZR7KMe2eXuyj/wuaMcOLy05uMmzAME1A=;
	b=uFOe5vKSOO2o0yPBaINn9QKgKinbHEfXo/Z2KiKCiC7xx/3Rw/vrn7WAIqlucnUE
	fTUZc5GcLUmwFIsm25I0FKfzvluD+oUd7lz+aIXjiGXOD7sdeE1gSIBxgRiq+I3ogS4
	n+pmKyaXnegH9nr7q0fyHc4CDTd/JDbE1aqB+oc2Q1q4ItAualvdf8GSHlHx+KVnZI9
	IbE2ARt5xzQpF9fE7tBP0ohKhUgxJ1JyuwTGRti3Pzhx1WWdiII2XAEycfSZPIPSOUC
	Ypwx2zsH4TpyVeXzR0UljbXeSb/g22KyNvtZMK+uF+Qz/+vYAFZQpPy65dtLGcAdE4Z
	q+PQ6nnSog==
Date: Wed, 27 Nov 2024 21:12:31 +0100 (CET)
From: jens.korinth@tuta.io
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <OCjFF0---F-9@tuta.io>
In-Reply-To: <CAH5fLgj30AmuobugAgzG9vOhSOrk5SqWwguOoNeh3J2fmLRHCA@mail.gmail.com>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io> <CAH5fLgj30AmuobugAgzG9vOhSOrk5SqWwguOoNeh3J2fmLRHCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> What is the use-case for this function?

`DO_ONCE_LITE` has very few uses in C; frankly, the only other use I could =
think
of was initialization. But since `OnceLite` cannot block or guarantee visib=
ility
of the side-effects of the `call_once` expression in other threads, it can'=
t be=C2=A0
used for this case, either. _Unless_ there is some mechanism to wait
voluntarily when this is required, hence `is_completed`. (And it also exist=
s in
`std::sync::Once`.)

`DO_ONCE_LITE_IF` has more uses in C, but this is a bit harder to do well w=
ith
`OnceLite`: A `do_once_lite_if` Rust macro can't short-circuit the conditio=
n to
avoid the evaluation if the atomic load already shows that it has been done=
 / is
being done rn. Maybe a
`pub fn call_once<C: FnOnce() -> bool, F: FnOnce()>(cond: C, f: F)` could b=
e
used to simulate the effect. Thoughts?

> Why not just have one atomic?

Do you also have an `AtomicU32` state var in mind, as Daniel suggested?

Jens

