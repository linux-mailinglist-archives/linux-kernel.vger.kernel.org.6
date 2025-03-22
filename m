Return-Path: <linux-kernel+bounces-572675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE80A6CCF6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C6F171937
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27951EBFF0;
	Sat, 22 Mar 2025 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhaOI6Lz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C99443;
	Sat, 22 Mar 2025 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742681133; cv=none; b=q3y01sUVKcuKePg+uOkPLXYHgj8CwnUS4VXhuhv4EfO9r0NvzFeWzjKvh+CaDek8ztadmhLwQqYZK3iLv9Wxhd/CilMdM58D+CPZ48mqKriGQBVWnOLMkHuLzXzfiH6ug8F1YkVu3S2aVKXnBjXS33wqMjWbLg7myFtydUeTWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742681133; c=relaxed/simple;
	bh=KiPIRwdeUGquhKmV2rD1HVku6R1A8nvlN3f+YFmqi0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNDVeihjK9Ll9njZhm39R5e1Ex4GtRZLlHokx6OiYRuV2VnhXdQBdgaAG7ShMIHfYGvruqw4bgwURRL70rzr3man55KRjbWawD7E7GsEBw90VMAhTHjmoiN64EfcvDe64qgQRZTJDP9cCGyoGxRkOp1jtT0pWa07JnurI0WRtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhaOI6Lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00639C4CEDD;
	Sat, 22 Mar 2025 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742681132;
	bh=KiPIRwdeUGquhKmV2rD1HVku6R1A8nvlN3f+YFmqi0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AhaOI6LzHvACFnWIL8VsPe/Mx/OEEfaNU2i/VGPSY43M0ggTD5nQF3t1eAFRcKJy7
	 lbJXRhU5aLlnuLdwB6HICmiG24Bjhmz+bhorv+Mw0BesmDM1b1OA+y6YP9ktC24Sl4
	 XSt2soVhZzuy4V9kKos80lXnGWPY3ppXxzGHr8sBQI5eKwORwmzbUEP4V1JGEmdTaa
	 dyq9HQXOj0qZ6b9w8JtK0U9OGWFX2BVkx/9FjFVvyPuKH7Ctpe9adIgzNjvmYtOeDa
	 U2dYPyHNoAFkIu+gPc/wtx2YV1bGdJGZb4w0W70V3xyM0xAhIhFgATw+Y0zBrVU9g9
	 go+9GD+aXm2MQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Ralf Jung" <post@ralfj.de>, "Alice Ryhl" <aliceryhl@google.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,  "Miguel Ojeda" <ojeda@kernel.org>,
	"Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <benno.lossin@proton.me>,
	"Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,
	"Matthew Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
	<linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
In-Reply-To: <CANiq72=QN3Sr5xS-uFhZVX0+L2==moR7cBzRJ8kKxDa5s75-jw@mail.gmail.com>
 (Miguel
	Ojeda's message of "Sat, 22 Mar 2025 22:00:26 +0100")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<v6RopSmSHmV8uiLBqkIh2II4bCry2OIo_7opQKqq2H4DftxIuRvY2YaLdhLUKw-Ndyv8MpHCgBbBEQntdLU9DQ==@protonmail.internalid>
	<20250311-iov-iter-v1-1-f6c9134ea824@google.com>
 <871pushmw5.fsf@kernel.org>
	<k-Ep8amSWFdVcWjGYTHXkFyQt8LEmpPa_sGZ-6zTdKv_B4bms_2GhfXev84YUxyp0tO1ZrEWB_iSOW-VcWU6qg==@protonmail.internalid>
	<CANiq72=QN3Sr5xS-uFhZVX0+L2==moR7cBzRJ8kKxDa5s75-jw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Mar 2025 23:05:11 +0100
Message-ID: <877c4gen6w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Mar 19, 2025 at 7:54=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Don't we have some kind of `build_assert` macro to do this? If not,
>> maybe we should.
>
> `static_assert!` is the one (`build_assert!` is the other one, which
> is a heavier hammer that should only be used if really needed).
>
> Though our `static_assert!` does not have support for an (optional)
> message -- we could add that, perhaps as a good first issue. In this
> case it is not a big deal either way.
>
>> How did you arrive at this conclusion? In the discussions with Ralph on
>
> Ralf?

Sorry, misspell. Ralf Jung, added to CC.


Best regards,
Andreas Hindborg




