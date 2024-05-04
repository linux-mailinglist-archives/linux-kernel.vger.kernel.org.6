Return-Path: <linux-kernel+bounces-168733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F08BBCDE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0D81F21C47
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA9482FA;
	Sat,  4 May 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Q+yaRJya"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091157CAE;
	Sat,  4 May 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714837531; cv=none; b=GEn8pd4Dq58maFFMUg2lS2yN/n7+qiUgNj7iOFA/LrrAdZcTHhGrId9zz1Ivak6qicmkl6WrzxdH4e8xh3O+oxQQFPOeH69asgEeyUsNEn7nibRMc56n2RyOo44/PTrVMjmygQIl1cjLEd2Egk29MPpZhXAnySyY5sUWrHHBiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714837531; c=relaxed/simple;
	bh=ge8eSrWmG1QSzwW7t9UJrqZ0IDlqBkwqstyme4yNE5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PK5x5AqRtJ/kjV2IPIZUm5aETYuuYjrQCrM6IL3lQbQUEN4o/yA7HmZ0HZTxDemYvVMJiI+v4YTkKNeirraeD+mzXq4k4tA0v35x7lDTWX/x+6HnJiv22ZTx33peyX2URuOFHL61b6FmY1uZnZ1+AcVX/G2DCz4qXW8i05QP+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Q+yaRJya; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714837519; x=1715096719;
	bh=ge8eSrWmG1QSzwW7t9UJrqZ0IDlqBkwqstyme4yNE5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q+yaRJyaOA8VLNri/LpklXLordbIb6nISYDvqFQVPGFDoEACtQkIc2cZAZRw9ijGE
	 8ES1G6S0zaFO92FJg+HvPXWKHqKWYe8TZ68TUsKD8W6Epz4CqhNH0bwKgAT60iDysX
	 J3IJrRHUYqDBq0c9gWho+dvEwkTQcm+wzWKoL0ku2fOS327yzSfzcz/iiLckWLkqW5
	 OyiWjl1P236Jzj5Tjt/8H7Y6H+pquCdu0mW8D5edrPHd5eYWp1KcFOBeyVxNzFCaTB
	 bdWfghiXKoSbokukpj7s5OF1SRGQF7AdTJVRElUWeDxFxN9zydRGHVC1h+XikdxEnf
	 5ABeX9/W6unCA==
Date: Sat, 04 May 2024 15:45:09 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: init: add re-initialization functions
Message-ID: <1fa87967-079f-4ff8-9946-81a571eb09bf@proton.me>
In-Reply-To: <CAH5fLggj_MT=njdieD9BX_gV+4A02m0+zMyzPTJ9DR6hSkQhEg@mail.gmail.com>
References: <20240425213419.3904105-1-benno.lossin@proton.me> <20240425213419.3904105-2-benno.lossin@proton.me> <CAH5fLggj_MT=njdieD9BX_gV+4A02m0+zMyzPTJ9DR6hSkQhEg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f67d8b7b5a8af450ba0a34fba934da2883ac5ffc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.05.24 13:34, Alice Ryhl wrote:
> On Thu, Apr 25, 2024 at 11:34=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> Sometimes it is necessary to split allocation and initialization into
>> two steps. One such situation is when reusing existing allocations
>> obtained via `Box::drop_contents`. See [1] for an example.
>> In order to support this use case add `re_[pin_]init` functions to the
>> pin-init API. These functions operate on already allocated smart
>> pointers that contain `MaybeUninit<T>`.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57a=
d3f5bc592@proton.me/ [1]
>=20
> I'm not a big fan of the name. Perhaps we can use a name similar to
> `Box::write`?

Sure, what would be your suggestion? I can only think of `write_pinned`,
but no idea what to do for `impl Init<T>`...

--=20
Cheers,
Benno


